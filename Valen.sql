--Mejor tiempo de vuelta de cada escudería por circuito por año.
--El mejor tiempo está dado por el mínimo tiempo en que un auto logra realizar una vuelta de un circuito
--TODO
select TELE_AUTO_TIEMPO_VUELTA , year(C.CARRERA_FECHA) as AÑO_CARRERA , A.CODIGO_AUTO, E.CODIGO_ESCUDERIA
from cosmicos.TELEMETRIA T
join COSMICOS.AUTO_POR_CARRERA AC on T.CODIGO_AUTO_POR_CARRERA = AC.CODIGO_AUTO_POR_CARRERA
join COSMICOS.AUTO A on A.CODIGO_AUTO = AC.CODIGO_AUTO
join COSMICOS.ESCUDERIA E on E.CODIGO_ESCUDERIA = A.CODIGO_ESCUDERIA
join COSMICOS.CARRERA C on C.CODIGO_CARRERA = AC.CODIGO_CARRERA
where TELE_AUTO_TIEMPO_VUELTA <> 0 and e.CODIGO_ESCUDERIA =1 
group by year(C.CARRERA_FECHA), TELE_AUTO_TIEMPO_VUELTA, c.CODIGO_CARRERA, A.CODIGO_AUTO, E.CODIGO_ESCUDERIA
having  TELE_AUTO_TIEMPO_VUELTA = (
		select top 1 TELE_AUTO_TIEMPO_VUELTA from COSMICOS.TELEMETRIA T1
		join COSMICOS.CARRERA C1 on C1.CODIGO_CARRERA = T1.CODIGO_CARRERA
		where c1.CODIGO_CARRERA = c.CODIGO_CARRERA
		group by  t1.TELE_AUTO_TIEMPO_VUELTA ,c1.CODIGO_CARRERA
		order by  t1.TELE_AUTO_TIEMPO_VUELTA 
		)	
order by  AÑO_CARRERA,TELE_AUTO_TIEMPO_VUELTA  

declare c cursor  for select CODIGO_ESCUDERIA from COSMICOS.ESCUDERIA
declare @cod_esc int;
open c
fetch c into @cod_esc
create view mejor_tiempo_vuelta_por_año_por_escuderia as
select 

while @@FETCH_STATUS =0
begin 
	

end


--Los 3 circuitos donde se consume mayor cantidad en tiempo de paradas en boxes
--DONE
create view mayorTiempoParadas as
select top 3 c.CIRCUITO_CODIGO, p.PARADA_BOX_TIEMPO
from cosmicos.PARADA_BOX p 
join  cosmicos.CARRERA c on c.CODIGO_CARRERA =p.CODIGO_CARRERA
order by p.PARADA_BOX_TIEMPO desc
