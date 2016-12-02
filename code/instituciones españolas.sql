/* actualizacion de datos: instituciones españolas*/
alter table datos_2007n
add ines int default 0, 
add primary key (ut2);
update datos_2007n a
inner join
(select ut2, count(*) as ines from in_2007n where cu='Spain' group by ut2) b
using(ut2)
set a.ines=b.ines