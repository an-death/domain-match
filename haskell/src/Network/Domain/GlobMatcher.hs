module Network.Domain.GlobMatcher
  (
  compile
  , match
  )
  where

import qualified System.FilePath.Glob as Glob

compile :: String -> Glob.Pattern
compile = Glob.compile

match :: Glob.Pattern -> FilePath -> Bool
match = Glob.match
