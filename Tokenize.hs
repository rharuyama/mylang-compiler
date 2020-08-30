
module Tokenize where

replace :: Eq a => [a] -> [a] -> [a] -> [a]
replace [] _ _ = []
replace s find repl =
    if take (length find) s == find
        then repl ++ (replace (drop (length find) s) find repl)
        else [head s] ++ (replace (tail s) find repl)

tokenize :: String -> [String]
tokenize p = words
  . (isolate "(")
  . (isolate ")")
  . (isolate "/")
  . (isolate "*")
  . (isolate "-")
  . (isolate "+")
  $ p

isolate :: String -> String -> String
isolate sign =
  \ x -> replace x sign (" " ++ sign ++ " ")  
