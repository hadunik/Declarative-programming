-----------------------------------------------------------------------------
-- |
-- Module      :  SQLHSExample
-- Copyright   :  (c) 2019-2021 Konstantin Pugachev
--                (c) 2019 Denis Miginsky
-- License     :  MIT
--
-- Maintainer  :  K.V.Pugachev@inp.nsk.su
-- Stability   :  experimental
-- Portability :  portable
--
-- The SQLHSExample module provides examples of using SQLHS/SQLHSSugar module.
--
-----------------------------------------------------------------------------
module SQLHSExample where
import SQLHSSugar
import DBReader

-- CATEGORY:     WARE,    CLASS
-- MANUFACTURER: BILL_ID, COMPANY
-- MATERIAL:     BILL_ID, WARE,   AMOUNT
-- PRODUCT:      BILL_ID, WARE,   AMOUNT	, PRICE
    
main = readDB' defaultDBName >>= executeSomeQueries

executeSomeQueries :: (Named Table, Named Table, Named Table, Named Table) -> IO ()
executeSomeQueries (categories, manufacturers, materials, products) = do
  test "test1" test1
  test "test2" test2
  test "test3" test3
--  test "lecPlan3" lecPlan3
--  test "lecPlan4" lecPlan4
--  test "lecPlan4'" lecPlan4'
  
  where
    test msg p = do
      putStrLn $ "===== execute " ++ msg ++ " ====="
      -- putStrLn . debugTable $ p & enumerate
      printResult $ p & enumerate

    test1 = 
        categories // "c" `wher` col "c.CLASS" `eq` str "Mineral"
        `hjoin` (materials // "m" `indexby` col "WARE") `on` col "c.WARE"
        `hjoin` (products // "p" `indexby` col "BILL_ID") `on` col "m.BILL_ID"
        `orderby`["p.WARE":asc]
        `select` ["p.WARE"]
        & distinct

    test3 = 
        materials // "m1"
        `hjoin` (products // "p1" `indexby` col "BILL_ID") `on` col "m1.BILL_ID"
        `hjoin` (materials // "m2" `indexby` col "WARE") `on` col "p1.WARE"
        `hjoin` (products // "p2" `indexby` col "BILL_ID") `on` col "m2.BILL_ID"
        `hjoin` (manufacturers // "mn1" `indexby` col "BILL_ID") `on` col "p1.BILL_ID"
        `hjoin` (manufacturers // "mn2" `indexby` col "BILL_ID") `on` col "p2.BILL_ID"
        `wher` col "mn1.COMPANY" `eq` col "mn2.COMPANY"
        `orderby` ["mn2.COMPANY":asc]
        `select` ["mn2.COMPANY"]
        &distinct


{-    test3 = 
        materials // "mat"
        `hjoin` (manufacturers // "m1" `indexby` col "BILL_ID") `on` col "mat.BILL_ID"
        `hjoin` (manufacturers // "m2" `indexby` col "COMPANY") `on` col "m1.COMPANY"
        `hjoin` (products // "pr" `indexby` col "BILL_ID") `on` col "m2.BILL_ID"
        `wher` col "mat.WARE" `eq` col "pr.WARE"
        `select` ["m1.COMPANY"]
        & distinct-}
    
    test2 = 
        (products // "p"
        `hjoin` (
        (categories // "c1" `wher` col "c1.CLASS" `eq` str "Stuff")
        // "c1" `indexby` col "c1.WARE") `on` col "p.WARE"
        `select` ["p.BILL_ID", "p.WARE"]) // "p"
        `hjoin` ((
        materials // "m"
        `hjoin` (
        (categories // "c2" `wher` col "c2.CLASS" `eq` str "Mineral")
        // "c2" `indexby` col "c2.WARE") `on` col "m.WARE"
        `select` ["m.BILL_ID", "m.WARE"]
        ) // "m" `indexby` col "m.BILL_ID") `on` col "p.BILL_ID"
        `select` ["m.BILL_ID", "p.WARE", "m.WARE"]
        & limit 0 50


{-    lecPlan2 = 
      -- CATEGORY FILTER c.CLASS='Raw food'
      categories // "c" `wher` col "c.CLASS" `eq` str "Raw food"
      -- -> NL_JOIN PRODUCT ON c.WARE=p.WARE
      `njoin` products // "p" `on` "c.WARE" `jeq` "p.WARE"
      -- -> NL_JOIN MANUFACTURER ON m.BILL_ID=p.BILL_ID
      `njoin` manufacturers // "m" `on` "p.BILL_ID" `jeq` "m.BILL_ID"
      -- -> SORT_BY p.WARE
      `orderby` ["p.WARE":asc]
      -- -> MAP (p.WARE, m.COMPANY)
      `select` ["p.WARE", "m.COMPANY"]
      -- ->DISTINCT
      & distinct 
      -- -> TAKE 10
      & limit 0 10
  
    lecPlan3 = 
      -- CATEGORY FILTER c.CLASS='Raw food'
      categories // "c" `wher` col "c.CLASS" `eq` str "Raw food"  
      -- -> HASH_JOIN PRODUCT INDEX BY WARE ON c.WARE=p.WARE
      `hjoin` (products // "p" `indexby` col "WARE") `on` col "c.WARE"
      -- -> HASH_JOIN MANUFACTURER INDEX BY BILL_ID ON m.BILL_ID=p.BILL_ID
      `hjoin` (manufacturers // "m" `indexby` col "BILL_ID") `on` col "p.BILL_ID"
      -- -> SORT_BY p.WARE
      `orderby` ["p.WARE":asc]
      -- -> MAP (p.WARE, m.COMPANY)
      `select` ["p.WARE", "m.COMPANY"]
      -- ->DISTINCT
      & distinct 
      -- -> TAKE 10
      & limit 0 10

    lecPlan4 = 
      -- CATEGORY FILTER c.CLASS='Raw food'
      (categories // "c" `indexby` col "WARE" & flatten) `wher` col "CLASS" `eq` str "Raw food"
      -- -> MERGE_JOIN PRODUCT INDEX BY WARE ON c.WARE=p.WARE
      `mjoin` (products // "p" `indexby` col "WARE" & flatten) `on` "c.WARE" `jeq` "p.WARE"
      -- -> HASH_JOIN MANUFACTURER INDEX BY BILL_ID ON m.BILL_ID=p.BILL_ID
      `hjoin` (manufacturers // "m" `indexby` col "BILL_ID") `on` col "p.BILL_ID"
      -- -> MAP (p.WARE, m.COMPANY)
      `select` ["p.WARE", "m.COMPANY"]
      -- ->DISTINCT
      & distinct 
      -- -> TAKE 10
      & limit 0 10
  
    lecPlan4' = 
      -- CATEGORY FILTER c.CLASS='Raw food'
      (categories // "c" `indexby` col "WARE" & flatten) `wher` col "CLASS" `eq` str "Raw food"
      -- -> HASH_JOIN PRODUCT INDEX BY WARE ON c.WARE=p.WARE
      `hjoin` (products // "p" `indexby` col "WARE") `on` col "c.WARE"
      -- -> HASH_JOIN MANUFACTURER INDEX BY BILL_ID ON m.BILL_ID=p.BILL_ID
      `hjoin` (manufacturers // "m" `indexby` col "BILL_ID") `on` col "p.BILL_ID"
      -- -> MAP (p.WARE, m.COMPANY)
      `select` ["p.WARE", "m.COMPANY"]
      -- ->DISTINCT
      & distinct 
      -- -> TAKE 10
      & limit 0 10

      -} 