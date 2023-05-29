import System.Environment (getArgs)

soma :: Float -> Float -> Float
soma a b = a + b

main :: IO ()
main = do
  args <- getArgs
  case args of
    [a, b] -> print (soma (read a) (read b))
    _ -> putStrLn "Por favor, forneça dois argumentos numéricos."

