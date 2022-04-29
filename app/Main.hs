module Main where

import Data.Aeson.Encode.Pretty
import Data.ByteString.Lazy
import System.Environment
import Data.Aeson
import Parser
import Types

main :: IO ()
main = do
    args  <- getArgs
    value <- parseFile (args !! 0)
    ast   <- case value of
        Left err  -> undefined
        Right ast -> return ast
    Data.ByteString.Lazy.writeFile "seeds.json" (encodePretty ast)
    return ()
