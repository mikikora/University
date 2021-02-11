
int :: (String -> a) -> String -> Integer -> a
int f = (\s i -> f (s ++ (show i)))

lit :: String -> (String -> a) -> String -> a
lit s f = (\str -> f (str++s))

str :: (String -> a) -> String -> String -> a
str f = (\prev my_str -> f (prev ++ my_str))

sprintf :: ((a -> a) -> String -> b) -> b
sprintf f = f (\x -> x) ""

(^^) :: (a -> b) -> (c -> a) -> c -> b
(^^) left right = (\x -> left (right x))


