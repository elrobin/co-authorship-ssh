/* identificacion de los ut2 de ciencias sociales*/
select 
a.wc, 
a.ut2
from
wc_2014n a
left join
jcr.wc_factors b
using(wc)
where b.ed= 'SSCI'

