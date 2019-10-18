{-# LANGUAGE FlexibleInstances #-}
module Network.Domain.Match where

import Data.List (foldl')
import Data.Attoparsec.ByteString as P
import qualified Data.ByteString as B 

type DomainTemplate = B.ByteString


re = B.foldr subre P.endOfInput

rere = B.foldl' subre' P.atEnd

subre' acc n = cast n *> acc 

subre n acc =cast n *> acc
-- 
-- starChar = ord '*'
cast 42 = B.pack <$> many' P.anyWord8
-- questChar = ord '?'
cast 63 = B.singleton <$> P.anyWord8
cast n  = B.singleton <$> P.word8 n 

parse = P.parseOnly 
