import System.Environment (getArgs)
import Data.Char
import System.Directory
import Text.Parsec
import Text.Parsec.String

import Tokenize
import Parse
--import Codegen

-- main = do
--   cd <- getCurrentDirectory
--   src <- readFile (cd ++ "/source")
--   (writeFile (cd ++ "/target.s")) . attatchPrefix . codegen . tokenize $ src

test1 =
  parse expr "mylang" "(12 + 3) * 4 / (5 - 6)"
  --codegen $ parse expr "mylang" "43"
