import System.Environment (getArgs)
import Data.Char
import System.Directory

data Expr  = Num Int
          | Add Expr Expr
          | Sub Expr Expr
          | Mul Expr Expr
          | Div Expr Expr
          deriving Show

main = do
  cd <- getCurrentDirectory
  src <- readFile (cd ++ "/source")
  (writeFile (cd ++ "/target.s")) . attatchPrefix . codegen . tokenize $ src

test1 = do
  print . expr . tokenize $ "44"
  print . expr . tokenize $ "7 + 5"
  print . expr . tokenize $ "100 - 7 + 5"

replace :: Eq a => [a] -> [a] -> [a] -> [a]
replace [] _ _ = []
replace s find repl =
    if take (length find) s == find
        then repl ++ (replace (drop (length find) s) find repl)
        else [head s] ++ (replace (tail s) find repl)

tokenize :: String -> [String]
tokenize p = words
  . (\x->replace x "(" "( " )
  . (\x->replace x ")" " )" )
  $ p

expr :: [String] -> Expr 
expr tokens
  | null tokens = Num 0
  | null iit = mul [lst]
  | last iit == "+" = Add (expr (init iit)) (Num (read lst))
  | last iit == "-" = Sub (expr (init iit)) (Num (read lst))
  where
    iit = init tokens
    lst = last tokens

mul :: [String] -> Expr
mul tokens
  | null tokens = Num 0
  | null iit = prim [lst]
  
  where
    iit = init tokens
    lst = last tokens

prim :: [String] -> Expr
prim tokens
  | null tokens = Num 0
  | null iit = Num (read lst)
  
  where
    iit = init tokens
    lst = last tokens
    
 
codegen :: [String] -> String
codegen tokens
  | null tokens = ""
  
  | all isDigit tok = "\t" ++ "push " ++ tok ++ "\n\n"
                      ++ codegen rest
  
  | tok == "+" =  "\t" ++ "pop rdi" ++ "\n"
               ++ "\t" ++ "pop rax" ++ "\n"
               ++ "\t" ++ "add rax, rdi" ++ "\n"
               ++ "\t" ++ "push rax" ++ "\n\n" 
               ++ codegen rest 
               
  | tok == "-" =  "\t" ++ "pop rdi" ++ "\n"
               ++ "\t" ++ "pop rax" ++ "\n"
               ++ "\t" ++ "sub rax, rdi" ++ "\n"
               ++ "\t" ++ "push rax" ++ "\n\n"
               ++ codegen rest 
               
  | tok == "*" =  "\t" ++ "pop rdi" ++ "\n"
               ++ "\t" ++ "pop rax" ++ "\n"
               ++ "\t" ++ "imul rax, rdi" ++ "\n"
               ++ "\t" ++ "push rax" ++ "\n\n"
               ++ codegen rest 
               
  | tok == "/" =  "\t" ++ "pop rdi" ++ "\n"
               ++ "\t" ++ "pop rax" ++ "\n"
               ++ "\t" ++ "cqo"     ++ "\n"
               ++ "\t" ++ "idiv rdi" ++ "\n"
               ++ "\t" ++ "push rax" ++ "\n\n"
               ++ codegen rest

  | otherwise = "//Error here -- unexpected token in codegen\n"

  where tok = head tokens
        rest= tail tokens
  
attatchPrefix :: String -> String
attatchPrefix body =
  ".intel_syntax noprefix" ++ "\n" 
  ++ ".global main" ++ "\n"
  ++ "main:" ++ "\n"
  
  ++ body

  ++ "\t" ++ "pop rax" ++ "\n"
  ++ "\t" ++ "ret" ++ "\n"
  
