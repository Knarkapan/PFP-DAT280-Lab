{-# LANGUAGE TypeOperators #-}
-- | an example of how repa and our extention can be used together
module Part1 where
import Data.List
import qualified Data.Array.Repa as R

type IntVector = R.Array R.U (R.Z R.:. Int) Integer

stock::[Integer]->Integer
stock (l:[]) = 0
stock (l:ls) = (max (stock ls) (calc ls l 0))
    where 
        calc::[Integer]->Integer->Integer->Integer
        calc (l:[]) x y = max  (x-l)  y  
        calc (l:ls)   x y = max (x-l) (calc ls x y)
        
        
        
pstock::[Int]->IO ()
pstock ls = do
    let i = length ls
    let l  = (tails (ls::[Int])) ::[[Int]]
    --let repLs = R.fromListUnboxed (R.ix1 i) l ::(R.Array R.U R.DIM1 [Int])  
    return ()
        

        
runOnTails::[Integer]->(Integer,Integer)
runOnTails (l:ls) = helper l ls 1 0 0

helper::Integer->[Integer]->Integer->Integer->Integer->(Integer,Integer)
helper f (l:[]) i mi m | l-f > m = (f-l, i)
                     | otherwise = (m, mi)
helper f (l:ls) i mi m | l-f > m = helper f ls (i+1) i (l-f)
                       | otherwise = helper f ls (i+1) mi (m)