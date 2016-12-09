/* identificacion de los ut2 de ciencias sociales*/
<<<<<<< HEAD
select 
a.wc, 
a.ut2
from
wc_2014n a
left join
jcr.wc_factors b
using(wc)
where b.ed= 'SSCI'

=======

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
>>>>>>> 0fbad9911d9295b41eff33c0a5970fd56b8e68d9
