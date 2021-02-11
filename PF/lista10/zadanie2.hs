{-# LANGUAGE GADTs #-}


data Format a b where
  Int :: Format a (Integer -> a)
  Lit :: String -> Format a a
  Str :: Format a (String -> a)
  (:^:) :: Format a b -> Format c a -> Format c b

ksprintf :: Format a b -> (String -> a) -> b
ksprintf Int f = (\x -> f (show x))
ksprintf Str f = (\x -> f x)
ksprintf (Lit s) f = f s
ksprintf (a :^: b) f = ksprintf a (\x -> ksprintf b (\c -> f (x++c)))

kprintf :: Format a b -> (IO () -> a) -> b
kprintf Int f = (\x -> f (putStr (show x)))
kprintf Str f = (\x -> f (putStr x))
kprintf (Lit s) f = f (putStr s)
kprintf (a :^: b) f = kprintf a (\x -> kprintf b (\c -> f (x >> c)))

printf f = kprintf f id 
