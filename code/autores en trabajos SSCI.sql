/* instituciones, autores y citas en los trabajos SSCI*/
select 
	a.*,
	b.wc,
	d.y0,
from 
	datos_2012n a
inner join
	wc_2012n b
using(ut2)
inner join
	jcr.wc_factors c
using(wc)
inner join
where c.ed = 'SSCI'