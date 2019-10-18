{-# LANGUAGE OverloadedStrings #-}
module Main where

import System.Environment (getArgs)

import qualified Data.ByteString as B
import qualified Data.ByteString.Char8 as BC
import Data.List (foldl')

import Network.Domain.Match


doms :: [B.ByteString]
doms = [
    "domain.com",
    "*.domain.com",
    "domain.*.com",
    "domain.*",
    "*",
    "*domain.com"
       ]

main :: IO ()
main = do
        [checkDomain] <- getArgs
        let prs = foldl' (\acc n -> (n, re n):acc) [] doms
        putStr "Parse domain:  "
        putStrLn checkDomain
        foldl' (\a (name, p) -> 
                B.putStr name >>
                B.putStr ": " >>
                print (parse p (BC.pack checkDomain)) >> a) (pure ()) prs
