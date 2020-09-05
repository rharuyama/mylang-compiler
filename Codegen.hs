module Codegen where
import Data.Char
import Text.Parsec
import Text.Parsec.String
import Parse 

-- codegen2 :: [String] -> String
-- codegen2 tokens
--   | null tokens = ""
  
--   | all isDigit tok = "\t" ++ "push " ++ tok ++ "\n\n"
--                       ++ codegen rest
  
--   | tok == "+" =  "\t" ++ "pop rdi" ++ "\n"
--                ++ "\t" ++ "pop rax" ++ "\n"
--                ++ "\t" ++ "add rax, rdi" ++ "\n"
--                ++ "\t" ++ "push rax" ++ "\n\n" 
--                ++ codegen rest 
               
--   | tok == "-" =  "\t" ++ "pop rdi" ++ "\n"
--                ++ "\t" ++ "pop rax" ++ "\n"
--                ++ "\t" ++ "sub rax, rdi" ++ "\n"
--                ++ "\t" ++ "push rax" ++ "\n\n"
--                ++ codegen rest 
               
--   | tok == "*" =  "\t" ++ "pop rdi" ++ "\n"
--                ++ "\t" ++ "pop rax" ++ "\n"
--                ++ "\t" ++ "imul rax, rdi" ++ "\n"
--                ++ "\t" ++ "push rax" ++ "\n\n"
--                ++ codegen rest 
               
--   | tok == "/" =  "\t" ++ "pop rdi" ++ "\n"
--                ++ "\t" ++ "pop rax" ++ "\n"
--                ++ "\t" ++ "cqo"     ++ "\n"
--                ++ "\t" ++ "idiv rdi" ++ "\n"
--                ++ "\t" ++ "push rax" ++ "\n\n"
--                ++ codegen rest

--   | otherwise = "//Error here -- unexpected token in codegen\n"

--   where tok = head tokens
--         rest= tail tokens
  
attatchPrefix :: String -> String
attatchPrefix body =
  ".intel_syntax noprefix" ++ "\n" 
  ++ ".global main" ++ "\n"
  ++ "main:" ++ "\n"
  
  ++ body

  ++ "\t" ++ "pop rax" ++ "\n"
  ++ "\t" ++ "ret" ++ "\n"
  
--

codegen :: Either ParseError Exp -> String
codegen (Right (Num n)) = "\t" ++ "push " ++ show n ++ "\n\n"
codegen (Right (Add n m)) = ""
                    ++ codegen n
                    ++ codegen m
                    ++ "\t" ++ "pop rdi" ++ "\n"
                    ++ "\t" ++ "pop rax" ++ "\n"
                    ++ "\t" ++ "add rax, rdi" ++ "\n"
                    ++ "\t" ++ "push rax" ++ "\n\n"
codegen (Right _) = "// Right else"                    
codegen (Left _) = "// Error here -- in codegen"                    
