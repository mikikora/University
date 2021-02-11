import Control.Monad
class Monad m => Random m where
  random :: m Int

shuffle :: Random m => [a] -> m [a]
shuffle [] = pure []
shuffle lst = do
  l <- random
  let c = mod l (length lst) in
    let split = splitAt c lst in
      do rest <- shuffle ((fst split) ++ (drop 1 (snd split)))
         pure ((lst !! c) : rest)

newtype RS a = RS {unsRS :: Int -> (Int, a)}

instance Functor RS where
  fmap = liftM

instance Applicative RS where
  pure = return
  (<*>) = ap

instance Monad RS where
  return x = RS (\y -> (y, x))
  RS a >>= f = RS (\x -> let (env, ret) = a x in
                      let RS fun = f ret in
                        fun env)

instance Random RS where
  random = RS (\x -> let bi = 16807 * (mod x 127773) - 2836 * (div x 127773) in
    if bi > 0
    then (bi, bi)
    else
      (bi + 2147483647, bi + 2147483647))

withSeed :: RS a -> Int -> a
withSeed (RS a) n = snd (a n)
  
