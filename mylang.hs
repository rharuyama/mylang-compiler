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

