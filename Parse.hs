module Parse where
import Data.Char
import Text.Parsec
import Text.Parsec.String

data Exp  = Num Int
          | Add Exp Exp
          | Sub Exp Exp
          | Mul Exp Exp
          | Div Exp Exp
          | Bkt Exp
          deriving Show

-- expr ::= mul ('+' mul | e)
expr :: Parser Exp
expr = do
    t <- mul 
    (Add t <$> (char '+' *> mul))
      <|> (Sub t <$> (char '-' *> mul))
      <|> pure t

-- mul ::= prim ('*' prim | e)
mul :: Parser Exp
mul = do
    f <- prim
    (Mul f <$> (char '*' *> prim))
      <|> (Div f <$> (char '/' *> prim))
      <|> pure f

-- prim ::= '(' expr ')' | nat
prim :: Parser Exp
prim = paren
  <|> nat
  where
    paren = char '(' *> (expr <* char ')')

-- nat ::= '0' | '1' | ...
nat :: Parser Exp
nat = Num . charToInt <$> oneOf ['0'..'9']
  where
    charToInt c = ord c - ord '0'
