{-# LANGUAGE OverloadedStrings #-}

module Encode where

import Data.Aeson.Encode.Pretty
import Data.ByteString.Lazy
import Data.Text
import Data.Ord
import Types

keys :: [Text]
keys   = ["reference", "paragraphs", "book", "chapter", "verse", "to", "is_range"]

comp :: Text -> Text -> Ordering
comp   = keyOrder keys `mappend` comparing Data.Text.length

config :: Config
config = Config { confIndent = Spaces 4, confCompare = comp, confNumFormat = Generic, confTrailingNewline = False }

encode :: AST -> ByteString
encode = encodePretty' config
