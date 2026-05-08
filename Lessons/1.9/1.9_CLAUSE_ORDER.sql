--CLAUSE ORDER
EXPLAIN -- physical plani gosterir ama kodu calistirmaz
EXPLAIN ANALYZE -- physical plani gosterir ve kodu calistirmaz
SELECT DISTINCT column1, column2 --Hangi sutunlari gormek istedigini belirtir. DISTINCT sadece cesitleri gosterir.
FROM table1 --verinin hangi tablodan cekicegini belirtir
JOIN table2 
    ON join_condition --iki tabloyu birlestirir ON ile nasil baglancigi belirlenir
WHERE condition --satirlari filtreler
GROUP BY column --verileri gruplar
HAVING condition --gruplanan verileri filtreler  AGG FUNC icin kosul
ORDER BY column1 --sonuclari siralar ASC or DESC
LIMIT number --kac satir donecegi