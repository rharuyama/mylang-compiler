module Parse where
import Data.Char
import Text.Parsec
import Text.Parsec.String

data Exp = Num Int
         | Add Exp Exp
         | Sub Exp Exp
         | Mul Exp Exp
         | Div Exp Exp
         deriving Show 

-- expr ::= mul (+ expr | e)
expr :: Parser Exp
expr = do
  x <- mul  
  try $ do
    char '+'
    spaces
    y <- expr  
    return (Add x y)
    <|> do
      char '-'
      spaces
      y <- expr   
      return (Sub x y)
    <|> return x

-- mul ::= unary (* mul | e)*
mul :: Parser Exp
mul = do
  x <- prim 
  try $ do
    char '*'
    spaces
    y <- mul    
    return (Mul x y)
    <|> do
      char '/'
      spaces
      y <- mul    
      return (Div x y)
    <|> return x

unary :: Parser Exp
unary = do
  try $ do
    char '+'
    x <- prim
    return x
    <|> do
      char '-'
      x <- prim
      return (Sub (Num 0) x)
    
-- prim ::= num | (expr)
prim :: Parser Exp
prim = paren
  <|> num
  <|> unary
  where
    paren = try $ do
      char '('
      spaces
      x <- expr
      spaces
      char ')'
      spaces
      return x

num :: Parser Exp
num = do
  spaces
  p <- many1 digit
  spaces
  return (Num (read p :: Int))




