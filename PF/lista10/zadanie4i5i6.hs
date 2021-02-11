{-# LANGUAGE BlockArguments #-}
import Data.Char

data StreamTrans i o a
  = Return a
  | ReadS (Maybe i -> StreamTrans i o a)
  | WriteS o (StreamTrans i o a)


stoLower :: StreamTrans Char Char ()
stoLower = ReadS (\x -> case x of
                    Just x -> WriteS (toLower x) stoLower
                    Nothing -> Return ())

runIOStreamTrans :: StreamTrans Char Char a -> IO a
runIOStreamTrans (ReadS cont) =
  do {x <- getChar
     ; if x == '\EOT'
      then runIOStreamTrans (cont Nothing)
      else runIOStreamTrans (cont (Just x))}

runIOStreamTrans (WriteS a cont) =
  do {putChar a
     ; runIOStreamTrans cont}

runIOStreamTrans (Return a) =
  return a

-- Zadanie 5
listTrans :: StreamTrans i o a -> [i] -> ([o], a)
listTrans (ReadS cont) read =
  case read of
    [] -> listTrans (cont Nothing) []
    hd:tl -> listTrans (cont (Just hd)) tl

listTrans (WriteS a cont) read =
  let rest = listTrans cont read in
    ((a:(fst rest)), snd rest)

listTrans (Return a) read =
  ([], a)

-- Zadanie 6
runCycleAcc :: StreamTrans a a b -> [a] -> b
runCycleAcc (ReadS cont) [] = runCycleAcc (cont Nothing) []
runCycleAcc (ReadS cont) (hd:tl) = runCycleAcc (cont (Just hd )) tl
runCycleAcc (WriteS elem cont) lst = runCycleAcc cont (elem:lst)
runCycleAcc (Return a) _ = a

runCycle :: StreamTrans a a b -> b
runCycle stream = runCycleAcc stream []
