{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TupleSections #-}
{-# LANGUAGE FlexibleInstances #-}

module Network.Domain.TreeMatcher where

import Control.Applicative ((<|>))
import Data.Attoparsec.Text
import Data.Either (either)
import Data.Maybe (catMaybes, maybe, listToMaybe, fromJust)
import qualified Data.List as List
import Data.Text as Text (Text, foldl', splitOn, unpack)
import Data.Tree
import Data.Vector as Vec (Vector, foldl', fromList, map)
import Prelude hiding (takeWhile)
import qualified Network.Domain.GlobMatcher as P

data DomainPart
  = Plain Text.Text
  | Pattern Text.Text
  deriving (Show, Eq)

type DomainTree = Tree DomainPart

type Matcher = DomainTree


reverseDomain = ("." <>).List.foldl1' (\l r -> l <> "." <> r) . List.reverse . Text.splitOn"."

compile :: Vector Text -> Matcher
compile = Vec.foldl' helper (Node (Plain "") []) . Vec.map reverseDomain
  where
    helper :: Tree DomainPart -> Text -> Tree DomainPart
    helper tree "" = tree
    helper tree@(Node root forest) domain =
      let (part, left) = cutDomain domain
       in if root == part
            then Node root (helperF left forest)
            else tree

    helperF "" forest = forest
    helperF domain [] =
      let (part, left) = cutDomain domain
       in [Node part (helperF left [])]

    helperF domain xs =
      let (part, left) = cutDomain domain in
        case List.elemIndex part (Prelude.map rootLabel xs) of
          Nothing -> Node part (helperF left []):xs
          Just i  ->
            Node part (helperF left (subForest $ xs List.!! i)):(List.take i xs++List.drop (i+1) xs)


cutDomain :: Text -> (DomainPart, Text)
cutDomain domain = either (err) (id) $ parseOnly takePart domain
    -- error never must not happen
  where
    err e = error $ "could not parse domain: " ++ Text.unpack domain ++ e

takePart :: Parser (DomainPart, Text)
takePart = plain <|> pattern
  where
    plain = part <|> last
    pattern = (, "") . Pattern <$> takeWhile (const True)
    last = do
      head <- takeWhile isNotPattern <* endOfInput
      return (Plain head, "")
    part = do
      head <- takeWhile isNotPattern <* char '.'
      tail' <- tail
      return (Plain head, tail')
    tail = takeWhile (const True) <* atEnd
    isNotPattern = (notInClass "?*.")

search :: Matcher -> Text -> [Text]
search (Node c forest) domain = let (part, left) = cutDomain (reverseDomain domain) in
  if pEQ c part then List.concat $ List.map (\t -> search t domain) forest
  else []

pEQ :: DomainPart -> DomainPart -> Bool
pEQ (Plain t1) (Plain t2) = t1 == t2
pEQ (Pattern p1) (Plain t2) = P.match (P.compile (unpack p1)) (unpack t2) 
pEQ t1 p2 = pEQ p2 t1