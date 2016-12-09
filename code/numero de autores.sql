/*distribucion de las instituciones, los autores y las citas W3 en un año determinado */
select 
a.*,
b.y0,
b.y1,
b.y2
from datos_2012n a
left join
citas.tc_2012 b
using(ut2)