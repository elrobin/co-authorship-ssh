/* identificacion de los ut2 de ciencias sociales*/

-- Base de datos PCES
SELECT 
a.wc, 
a.ut2
FROM
wc_2014n a
LEFT JOIN
jcr.wc_factors b
USING(wc)
WHERE b.ed= 'SSCI'
-- 10203
