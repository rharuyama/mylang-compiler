module Codegen where
import Data.Char

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
  
