{-# LANGUAGE FlexibleInstances #-}
module Network.Domain.ParseMatch where


import Data.List (foldl', foldr)
import Data.Attoparsec.Text as P
import qualified Data.Text as T
import Data.Either (isRight)

data PParser = PParser T.Text (Parser Bool)

compile :: T.Text -> PParser
compile tmpl = PParser tmpl (T.foldr subre P.atEnd tmpl)

compile' :: T.Text  -> PParser
compile' tmpl = PParser tmpl (T.foldl' subre' P.atEnd tmpl)

subre' acc n = cast n *> acc

subre n acc = cast n *> acc
--
-- starChar = ord '*'
cast '*' = T.pack <$> many' P.anyChar
-- questChar = ord '?'
cast '?' = T.singleton <$> P.anyChar
cast n  = T.singleton <$> P.char n


match :: T.Text -> PParser -> Bool
match check (PParser _ parser) = isRight $ P.parseOnly parser check