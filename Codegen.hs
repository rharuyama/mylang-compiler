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

codegenRel :: Either ParseError Rel -> String
codegenRel (Right (Les t u)) = ""
                            ++ codegenTerm (Right t)
                            ++ codegenTerm (Right u)
                            ++ "\t" ++ "pop rdi" ++ "\n"
                            ++ "\t" ++ "pop rax" ++ "\n"
                            ++ "\t" ++ "cmp rax, rdi" ++ "\n"
                            ++ "\t" ++ "setl al" ++ "\n"
                            ++ "\t" ++ "movzb rax, al" ++ "\n"
                            ++ "\t" ++ "push rax" ++ "\n\n"
codegenRel (Right (Leq t u)) = ""
                            ++ codegenTerm (Right t)
                            ++ codegenTerm (Right u)
                            ++ "\t" ++ "pop rdi" ++ "\n"
                            ++ "\t" ++ "pop rax" ++ "\n"
                            ++ "\t" ++ "cmp rax, rdi" ++ "\n"
                            ++ "\t" ++ "setle al" ++ "\n"
                            ++ "\t" ++ "movzb rax, al" ++ "\n"
                            ++ "\t" ++ "push rax" ++ "\n\n"
codegenRel (Left _) = "// Error here -- in codegenRel\n"                            

codegenTerm :: Either ParseError Term -> String
codegenTerm (Right (Num n)) = "\t" ++ "push " ++ show n ++ "\n\n"
codegenTerm (Right (Add n m)) = ""
                            ++ codegenTerm (Right n)
                            ++ codegenTerm (Right m)
                            ++ "\t" ++ "pop rdi" ++ "\n"
                            ++ "\t" ++ "pop rax" ++ "\n"
                            ++ "\t" ++ "add rax, rdi" ++ "\n"
                            ++ "\t" ++ "push rax" ++ "\n\n"
codegenTerm (Right (Sub n m)) = ""
                            ++ codegenTerm (Right n)
                            ++ codegenTerm (Right m)
                            ++ "\t" ++ "pop rdi" ++ "\n"
                            ++ "\t" ++ "pop rax" ++ "\n"
                            ++ "\t" ++ "sub rax, rdi" ++ "\n"
                            ++ "\t" ++ "push rax" ++ "\n\n"
codegenTerm (Right (Mul n m)) = ""
                            ++ codegenTerm (Right n)
                            ++ codegenTerm (Right m)
                            ++ "\t" ++ "pop rdi" ++ "\n"
                            ++ "\t" ++ "pop rax" ++ "\n"
                            ++ "\t" ++ "imul rax, rdi" ++ "\n"
                            ++ "\t" ++ "push rax" ++ "\n\n"
codegenTerm (Right (Div n m)) = ""
                            ++ codegenTerm (Right n)
                            ++ codegenTerm (Right m)
                            ++ "\t" ++ "pop rdi" ++ "\n"
                            ++ "\t" ++ "pop rax" ++ "\n"
                            ++ "\t" ++ "cqo"     ++ "\n"
                            ++ "\t" ++ "idiv rax, rdi" ++ "\n"
                            ++ "\t" ++ "push rax" ++ "\n\n"                            
codegenTerm (Left _) = "// Error here -- in codegenTerm\n"                  
