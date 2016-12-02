/* actualizacion de datos: instituciones extranjeras*/
alter table datos_2006n
add inex int default 0;
update datos_2006n a
inner join
(select ut2, count(*) as inex from in_2006n where cu<>'Spain' group by ut2) b
using(ut2)
set a.inex=b.inex