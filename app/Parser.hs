module Parser where

import Data.List (intercalate)
import Text.Parsec as Parsec
import qualified Types

parseFile filepath = do
    content <- readFile filepath
    return (parseContent content)

parseContent :: String -> Either ParseError Types.AST
parseContent content = parse parser "" content

parser = do
    seeds <- seeds
    eof
    return Types.AST { Types.seeds = seeds }

seed = do
    reference  <- header
    paragraphs <- paragraphs
    return Types.Seed { Types.reference = reference, Types.paragraphs = paragraphs }

paragraph = do
    notFollowedBy hash
    words     <- Parser.words
    paragraph <- return (intercalate " " words)
    return Types.Paragraph { Types.paragraph = paragraph }

(|||) p q  = (try p) <|> (try q)
toInt s    = read s :: Int
space      = char ' '
hash       = char '#'
colon      = char ':'
dash       = char '-'
number     = many1 digit
verse      = range ||| number
seeds      = sepBy seed newline
range      = number >> dash >> number
reference  = book >> Parser.space >> chapter >> colon >> verse
header     = hashes >> Parser.space >> lookAhead (reference >> newline) >> manyTill anyChar newline
character  = notFollowedBy Parsec.space >> anyChar
word       = many1 character
words      = sepBy1 word Parser.space
paragraphs = many1 (try (between newline newline paragraph))
hashes     = count 6 hash
book       = many1 letter
chapter    = number
