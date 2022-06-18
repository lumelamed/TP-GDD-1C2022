--Mejor tiempo de vuelta de cada escudería por circuito por año.
--El mejor tiempo está dado por el mínimo tiempo en que un auto logra realizar una vuelta de un circuito


create view mejor_tiempo_vuelta_por_año_por_escuderia as
select TELE_AUTO_TIEMPO_VUELTA , year(C.CARRERA_FECHA) as AÑO_CARRERA , A.CODIGO_AUTO, E.CODIGO_ESCUDERIA, C.CIRCUITO_CODIGO
from cosmicos.TELEMETRIA T
join COSMICOS.AUTO_POR_CARRERA AC on T.CODIGO_AUTO_POR_CARRERA = AC.CODIGO_AUTO_POR_CARRERA
join COSMICOS.AUTO A on A.CODIGO_AUTO = AC.CODIGO_AUTO
join COSMICOS.ESCUDERIA E on E.CODIGO_ESCUDERIA = A.CODIGO_ESCUDERIA
join COSMICOS.CARRERA C on C.CODIGO_CARRERA = AC.CODIGO_CARRERA
where TELE_AUTO_TIEMPO_VUELTA <> 0  and  TELE_AUTO_TIEMPO_VUELTA = (
		select top 1 TELE_AUTO_TIEMPO_VUELTA from COSMICOS.TELEMETRIA T1
		join COSMICOS.CARRERA C1 on C1.CODIGO_CARRERA = T1.CODIGO_CARRERA
		join COSMICOS.AUTO_POR_CARRERA AC1 on T1.CODIGO_AUTO_POR_CARRERA = AC1.CODIGO_AUTO_POR_CARRERA
		join COSMICOS.AUTO A1 on A1.CODIGO_AUTO = AC1.CODIGO_AUTO
		join COSMICOS.ESCUDERIA E1 on E1.CODIGO_ESCUDERIA = A1.CODIGO_ESCUDERIA and E1.CODIGO_ESCUDERIA = E.CODIGO_ESCUDERIA
		where  year(C.CARRERA_FECHA) = year(C1.CARRERA_FECHA) and   TELE_AUTO_TIEMPO_VUELTA <> 0 and C.CIRCUITO_CODIGO = C1.CIRCUITO_CODIGO
		group by  t1.TELE_AUTO_TIEMPO_VUELTA ,c1.CODIGO_CARRERA
		order by  t1.TELE_AUTO_TIEMPO_VUELTA 
		)	
--order by CODIGO_ESCUDERIA,  AÑO_CARRERA,TELE_AUTO_TIEMPO_VUELTA  -- no se puede ordenar en las vistas solo lo dejo para el select


--Los 3 circuitos donde se consume mayor cantidad en tiempo de paradas en boxes
create view mayorTiempoParadas as
select top 3 c.CIRCUITO_CODIGO, p.PARADA_BOX_TIEMPO
from cosmicos.PARADA_BOX p 
join  cosmicos.CARRERA c on c.CODIGO_CARRERA =p.CODIGO_CARRERA
order by p.PARADA_BOX_TIEMPO desc
