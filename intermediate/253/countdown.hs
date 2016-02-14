import Data.List
import Data.Maybe
import Data.Ord
import System.Environment

type Result = ([Double],[String],Double)

ops :: [String]
ops = ["+","-","*","/"]

options :: [String] -> [String]-> [[String]]
options ps base = foldr (\x acc -> (x:base):acc) [] ps

allCombos' :: Int -> [String] -> [[String]] -> [[String]]
allCombos' 0 _ acc = acc
allCombos' x ys acc = allCombos' (x-1) ys (concatMap (options ys) acc)

allCombos :: Int -> [String] -> [[String]]
allCombos x ys = allCombos' x ys [[]]

calc :: [Double] -> [Double] -> [String] -> [String] -> Double -> Maybe Result
calc [x] usedInts [] usedOps _ = Just (usedInts,usedOps,x)
calc (x1:x2:xs) usedInts (y:ys) usedOps z
  | y == "+" = checkPass (x1 + x2)
  | y == "-" = if (x1 - x2) > 0 then checkPass (x1 - x2) else Nothing
  | y == "*" = checkPass (x1 * x2)
  | y == "/" = if fracCheck x1 x2 then checkPass (x1 / x2) else Nothing
    where checkPass x = if x == z then Just (usedInts++[x2],usedOps++[y],z) else calc (x:xs) (usedInts++[x2]) ys (usedOps++[y]) z
          fracCheck x y = ceiling (x/y) == floor (x/y)

calculate :: Double -> [String] -> [Double] -> Maybe Result
calculate z ys (x:xs) = calc (x:xs) [x] ys [] z

combine :: [String] -> [String] -> [String]
combine [] ys = ys
combine (x:xs) ys = x:combine ys xs

prettify :: Result -> [String]
prettify (x,y,_) = combine (map (show . truncate) x) y

countdown :: [Double] -> Double -> String
countdown xs t = unwords $ prettify $ getShortest results
  where posOps = allCombos (length xs - 1) ops
        results = filter (\(_,_,z) -> z == t) $ catMaybes $ concatMap (zipWith (calculate t) posOps . repeat) $ permutations xs
        getShortest = minimumBy (comparing (\(x,_,_) -> length x))

str2D :: [String] -> [Double]
str2D = foldr (\x acc -> (read x :: Double) : acc) []

main :: IO ()
main = do
  args <- fmap str2D getArgs
  let solution = countdown (tail args) (head args)
  putStrLn solution
