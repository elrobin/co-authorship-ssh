/* actualizacion de datos: autores extranjeros version 2*/
alter table datos_2008n
add nauext int default 0;
update datos_2008n aa
inner join
(select ut2,count(*) as nauext from
(select
a.ut2,
a.af,
b.cu
from 
au_2008n a
inner join
(select
  ut2,
  author,
  group_concat(cu) as cu
FROM c1_2008n
group by author,ut2) b
where a.ut2=b.ut2 and a.af=b.author and b.cu not like '%Spain%') c
group by ut2) bb
using(ut2)
set aa.nauext=bb.nauext

