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

calc :: [Double] -> [Double] -> [String] -> [String] -> Double -> [Result]
calc [x] usedInts [] usedOps _ = []
calc (x1:x2:xs) usedInts (y:ys) usedOps z
  | y == "+" = checkPass (x1 + x2)
  | y == "-" = if (x1 - x2) > 0 then checkPass (x1 - x2) else []
  | y == "*" = checkPass (x1 * x2)
  | y == "/" = if fracCheck x1 x2 then checkPass (x1 / x2) else []
    where checkPass x = if abs (x - z) < 10 then (usedInts++[x2],usedOps++[y],x) : nextIter x else nextIter x
          fracCheck x y = ceiling (x/y) == floor (x/y)
          nextIter x = calc (x:xs) (usedInts++[x2]) ys (usedOps++[y]) z

calculate :: Double -> [String] -> [Double] -> Maybe Result
calculate z ys (x:xs) = let results = calc (x:xs) [x] ys [] z
                        in case results of [] -> Nothing
                                           [x] -> Just x
                                           xs -> Just $ bestValue xs z

combine :: [String] -> [String] -> [String]
combine x [] = x
combine xs ys = ["("]++(combine (init xs) (init ys))++[")"]++[last ys,last xs]


prettify :: Result -> [String]
prettify (x,y,z) = combine (map (show . truncate) x) y ++ ["=",show z]

getResults xs t = catMaybes  [ calculate t y x | x <- (permutations xs), y <- posOps]
  where posOps = allCombos (length xs - 1) ops

getBest xs t = getShortest $ getClosest xs
  where getClosest = filter ( bestValue xs t ==)
        getShortest = minimumBy (comparing (\(x,_,_) -> length x))

bestValue xs t = minimumBy (comparing (\(_,_,x) -> abs (x - t))) xs

countdown :: [Double] -> Double -> String
countdown xs t = case getResults xs t of [] -> "Unsolvable"
                                         xs -> unwords $ prettify $ getBest xs t


str2D :: [String] -> [Double]
str2D = map fst . concatMap (\x -> (reads x :: [(Double, String)]))

argMin xs
  | length xs < 2 = "You must supply more than two numbers"
  | otherwise = countdown (tail xs) (head xs)

main :: IO ()
main = do
  args <- fmap str2D getArgs
  putStrLn $ argMin args

