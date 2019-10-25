{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE BangPatterns #-}

module Main where

import qualified Data.ByteString.Lazy as BL

import Data.Aeson
import Data.Text as Text
import qualified Data.Vector as Vec
import GHC.Generics (Generic)

import Network.Domain.ParseMatch as P
import Network.Domain.GlobMatcher as R
import qualified Network.Domain.TreeMatcher as T

import Criterion.Main

newtype Template = Template
  { template :: Text
  } deriving (Show, Generic)

instance FromJSON Template

instance ToJSON Template


getJSON = BL.readFile "templates.json"

treeMatch (patterns, domain) = T.search (T.compile patterns) domain
regexMatch (patterns, domain) = Vec.filter (`R.match` domain) $ compileBlob patterns
parserMatch (patterns, domain) = parseParser domain $ compileParse patterns
            
comAddr = "test@subdomain.domain.spottradingllc.com"
orgAddr = "test@domain.nyumc.org"

main :: IO ()
main = do
  (Just d) <- decode <$> getJSON :: IO (Maybe (Vec.Vector Template))
  let !patterns = Vec.map template d
  defaultMainWith
    defaultConfig
    [ bench "tree_com" $ whnf treeMatch (patterns, comAddr)
    , bench "glob_com" $ whnf regexMatch (patterns, unpack comAddr)
    , bench "parser_com" $ whnf parserMatch (patterns, comAddr)
    , bench "tree_org" $ whnf treeMatch (patterns, orgAddr)
    , bench "glob_org" $ whnf regexMatch (patterns, unpack orgAddr)
    , bench "parser_org" $ whnf parserMatch (patterns, orgAddr)
    ]

parserBlob checkDomain = Vec.filter (`R.match` checkDomain)

compileBlob = Vec.map (R.compile . unpack)

compileParse = Vec.map P.compile'

parseParser checkDomain =
  Vec.map (\(P.PParser name _) -> name) .
  Vec.filter (P.match (Text.reverse checkDomain))
