module Parser where

import qualified Types
import Text.Parsec

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
    reference  <- reference
    paragraphs <- paragraphs
    return Types.Seed { Types.reference = reference, Types.paragraphs = paragraphs }

reference = do
    hashes
    space
    book    <- book
    space
    chapter <- chapter
    colon
    verse   <- verse
    (verse, until, is_range) <- case verse of
        Left (verse, until)  -> return (verse, until, True)
        Right verse          -> return (verse, 0, False)
    newline
    return Types.Reference {
        Types.book     = book,
        Types.chapter  = chapter,
        Types.verse    = verse,
        Types.until    = until,
        Types.is_range = is_range
    }

paragraph = do
    notFollowedBy hash
    paragraph <- many1 (noneOf "\n")
    return Types.Paragraph { Types.paragraph = paragraph }

number = do
    value <- many1 digit
    return (toInt value)

range = do
    verse <- number
    dash
    until <- number
    return (verse, until)

verse = (do { value <- range; return (Left value) }) ||| (do { value <- number; return (Right value) })

(|||) p q  = (try p) <|> (try q)
toInt s    = read s :: Int
seeds      = sepBy seed newline
paragraphs = many1 (try (do { newline; paragraph <- paragraph; newline; return paragraph }))
hash       = char '#'
hashes     = count 6 hash
book       = many1 letter
chapter    = number
colon      = char ':'
dash       = char '-'
