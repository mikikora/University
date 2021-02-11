module NestedQBF where
import Data.Void

data Inc v = Z | S v

data Formula v =
  Var v
  | Bot
  | Not (Formula v)
  | And (Formula v) (Formula v)
  | All (Formula (Inc v))


type Env v = v -> Bool
eval :: Env v -> Formula v -> Bool

isTrue :: Formula Void -> Bool
isTrue f = eval absurd f

eval env (Var p) = env p
eval env Bot = False
eval env (Not f) = not (eval env f)
eval env (And f1 f2) = (eval env f1) && (eval env f2)
eval env (All f) = (eval (\x ->
                           case x of
                             Z -> True
                             S x -> env x)
                   f) && (eval (\x ->
                                  case x of
                                    Z -> False
                                    S x -> env x)
                           f)
