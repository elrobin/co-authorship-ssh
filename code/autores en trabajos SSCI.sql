/* instituciones, autores y citas en los trabajos SSCI*/
select 
	a.*,
	b.wc,
	d.y0,	d.y1,	d.y2
from 
	datos_2012n a
inner join
	wc_2012n b
using(ut2)
inner join
	jcr.wc_factors c
using(wc)
inner joincitas.tc_2012 dusing(ut2)
where c.ed = 'SSCI'
