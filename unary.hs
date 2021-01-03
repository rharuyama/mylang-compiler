module Parse where
import Data.Char
import Text.Parsec
import Text.Parsec.String

data Exp = Num Int
         deriving Show

unary :: Parser Exp
unary = do
  try $ do
    char '+'
    x <- num
    return x

num :: Parser Exp
num = do
  spaces
  p <- many1 digit
  spaces
  return (Num (read p :: Int))

test1 = parseTest num "42"
test2 = parseTest unary "+42"
