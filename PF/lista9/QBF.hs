module QBF where

type Var = String

data Formula
  = Var Var
  | Bot
  | Not Formula
  | And Formula Formula
  | All Var Formula

type Env = Var -> Bool
eval :: Env -> Formula -> Bool


isTrue :: Formula -> Bool
isTrue f = eval (\x -> error "var doesn't exits") f

eval env (Var p) = env p
eval env Bot = False
eval env (Not f) = not (eval env f)
eval env (And f1 f2) = (eval env f1) && (eval env f2)
eval env (All p f) = (eval (\x -> if x == p then True else env x) f) && (eval (\x -> if x == p then False else env x) f)




