/* actualizacion de datos: autores nacionales*/
alter table datos_2008n
add naues int default 0;
update datos_2008n aa
inner join
(select ut2,count(*) as naues from
(select
a.ut2,
a.af,
b.institution,
b.cu
from 
au_2008n a
inner join
c1_2008n b
where a.ut2=b.ut2 and a.af=b.author and b.cu='Spain') c
group by ut2) bb
using(ut2)
set aa.naues=bb.naues

