module Codegen where
import Data.Char
import Text.Parsec
import Text.Parsec.String
import Parse 
  
attatchHeadAndTail :: String -> String
attatchHeadAndTail body =
  ".intel_syntax noprefix" ++ "\n" 
  ++ ".global main" ++ "\n"
  ++ "main:" ++ "\n"
  
  ++ body

  ++ "\t" ++ "pop rax" ++ "\n"
  ++ "\t" ++ "ret" ++ "\n"

codegen :: Either ParseError Exp -> String
codegen (Right (Num n)) = "\t" ++ "push " ++ show n ++ "\n\n"
codegen (Right (Add n m)) = ""
                            ++ codegen (Right n)
                            ++ codegen (Right m)
                            ++ "\t" ++ "pop rdi" ++ "\n"
                            ++ "\t" ++ "pop rax" ++ "\n"
                            ++ "\t" ++ "add rax, rdi" ++ "\n"
                            ++ "\t" ++ "push rax" ++ "\n\n"
codegen (Right (Sub n m)) = ""
                            ++ codegen (Right n)
                            ++ codegen (Right m)
                            ++ "\t" ++ "pop rdi" ++ "\n"
                            ++ "\t" ++ "pop rax" ++ "\n"
                            ++ "\t" ++ "sub rax, rdi" ++ "\n"
                            ++ "\t" ++ "push rax" ++ "\n\n"
codegen (Right (Mul n m)) = ""
                            ++ codegen (Right n)
                            ++ codegen (Right m)
                            ++ "\t" ++ "pop rdi" ++ "\n"
                            ++ "\t" ++ "pop rax" ++ "\n"
                            ++ "\t" ++ "imul rax, rdi" ++ "\n"
                            ++ "\t" ++ "push rax" ++ "\n\n"
codegen (Right (Div n m)) = ""
                            ++ codegen (Right n)
                            ++ codegen (Right m)
                            ++ "\t" ++ "pop rdi" ++ "\n"
                            ++ "\t" ++ "pop rax" ++ "\n"
                            ++ "\t" ++ "cqo"     ++ "\n"
                            ++ "\t" ++ "idiv rax, rdi" ++ "\n"
                            ++ "\t" ++ "push rax" ++ "\n\n"                            
codegen (Left _) = "// Error here -- in codegen\n"                  
