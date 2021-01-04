module Parse where
import Data.Char
import Text.Parsec
import Text.Parsec.String

data Rel = Les Term Term
         | Leq Term Term
         deriving Show

data Term = Num Int
         | Add Term Term
         | Sub Term Term
         | Mul Term Term
         | Div Term Term
         deriving Show

-- parser 読み戻しをどうやるか．tryじゃダメなのか．
relational :: Parser Rel
relational = do
  x <- trm
  try $ do
    string "<="
    spaces
    y <- trm
    return (Leq x y)
    -- <|> do
    --   string "<"
    --   spaces
    --   y <- trm
    --   return (Les x y)
    <|> do
      string ">="
      spaces
      y <- trm
      return (Leq y x)

-- trm ::= mul (+ trm | e)
trm :: Parser Term
trm = do
  x <- mul  
  try $ do
    char '+'
    spaces
    y <- trm  
    return (Add x y)
    <|> do
      char '-'
      spaces
      y <- trm   
      return (Sub x y)
    <|> return x

-- mul ::= unary (* mul | e)*
mul :: Parser Term
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

unary :: Parser Term
unary = do
  try $ do
    char '+'
    x <- prim
    return x
    <|> do
      char '-'
      x <- prim
      return (Sub (Num 0) x)
    
-- prim ::= num | (trm)
prim :: Parser Term
prim = paren
  <|> num
  <|> unary
  where
    paren = try $ do
      char '('
      spaces
      x <- trm
      spaces
      char ')'
      spaces
      return x

num :: Parser Term
num = do
  spaces
  p <- many1 digit
  spaces
  return (Num (read p :: Int))




