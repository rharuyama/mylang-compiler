import System.Environment (getArgs)
import Data.Char
import System.Directory
import Text.Parsec
import Text.Parsec.String

import Parse
import Codegen

main = do
   cd <- getCurrentDirectory
   src <- readFile (cd ++ "/source")
   (writeFile (cd ++ "/target.s")) . attatchHeadAndTail . codegen . myParser $ src

test :: Either ParseError Exp
test = parse expr "test" "42+7"

myParser :: String -> Either ParseError Exp
myParser src = parse expr "mylang" src


