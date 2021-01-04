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
   (writeFile (cd ++ "/target.s")) . attatchHeadAndTail . codegenRel . myParserRel $ src

myParserTerm :: String -> Either ParseError Term
myParserTerm src = parse trm "mylangTerm" src

myParserRel :: String -> Either ParseError Rel
myParserRel src = parse relational "mylangRel" src

test1 = parseTest trm "7 + 5"
gen2 src = codegenRel . myParserRel $ src
test2 = parseTest relational " 3 <= 7"
--test3 = parseTest relational " 3 < 7" -- error
