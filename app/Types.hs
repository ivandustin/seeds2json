{-# LANGUAGE DeriveGeneric #-}

module Types where

import GHC.Generics
import Data.Aeson

data Reference = Reference { book :: String, chapter :: Int, verse :: Int, to :: Int, is_range :: Bool } deriving (Generic, Show)
data Paragraph = Paragraph { paragraph :: String } deriving (Generic, Show)
data Seed      = Seed { reference :: Reference, paragraphs :: [Paragraph] } deriving (Generic, Show)
data AST       = AST { seeds :: [Seed] } deriving (Generic, Show)

instance ToJSON Reference
instance ToJSON Paragraph
instance ToJSON Seed
instance ToJSON AST
