import Data.Char

echoLower :: IO ()
echoLower = getChar >>= \c ->
  if c == '\EOT'
  then putChar '\0'
  else
  putChar (toLower c) >> 
  echoLower
