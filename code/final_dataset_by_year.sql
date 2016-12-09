/*instituciones, autores y citas W3 en un año determinado*/

SELECT 
	a.*,
	b.FU,
	b.FX
FROM (
	SELECT 
	a.*,
	b.wc,
	d.y0,
	d.y1,
	d.y2,
	@py := '2000'
FROM 
	datos_2000n a
INNER JOIN
	wc_2000n b
USING(ut2)
INNER JOIN
	jcr.wc_factors c
USING(wc)
INNER JOIN
citas.tc_2000 d
USING(ut2)
WHERE c.ed = 'SSCI') a
INNER JOIN
	pc_2000n b
USING(ut2)