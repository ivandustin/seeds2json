module Main where

import qualified Data.ByteString.Lazy as ByteString
import System.Environment
import System.Exit
import Encode
import Parser
import Types

main :: IO ()
main = do
    args  <- getArgs
    value <- parseFile (args !! 0)
    ast   <- case value of
        Left  err -> die (show err)
        Right ast -> return ast
    ByteString.writeFile "seeds.json" (encode ast)
    return ()
