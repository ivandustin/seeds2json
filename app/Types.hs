module Types where

data Reference = Reference { book :: String, chapter :: Int, verse :: Int, until :: Int, is_range :: Bool } deriving Show
data Paragraph = Paragraph { paragraph :: String } deriving Show
data Seed      = Seed { reference :: Reference, paragraphs :: [Paragraph] } deriving Show
data AST       = AST { seeds :: [Seed] } deriving Show
