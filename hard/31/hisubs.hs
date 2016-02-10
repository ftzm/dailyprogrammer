f = maximum . concatMap (scanl1 (+)) . scanr (:) []
