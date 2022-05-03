{-# LANGUAGE DeriveGeneric #-}

module Types where

import GHC.Generics
import Data.Aeson

data Paragraph = Paragraph { paragraph :: String } deriving (Generic, Show)
data Seed      = Seed { reference :: String, paragraphs :: [Paragraph] } deriving (Generic, Show)
data AST       = AST { seeds :: [Seed] } deriving (Generic, Show)

instance ToJSON Paragraph
instance ToJSON Seed
instance ToJSON AST
