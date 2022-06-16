--Mejor tiempo de vuelta de cada escudería por circuito por año.
--El mejor tiempo está dado por el mínimo tiempo en que un auto logra realizar una vuelta de un circuito


--Los 3 circuitos donde se consume mayor cantidad en tiempo de paradas en boxes
create view mayorTiempoParadas as
select top 3 c.CIRCUITO_CODIGO, p.PARADA_BOX_TIEMPO
from cosmicos.PARADA_BOX p 
join  cosmicos.CARRERA c on c.CODIGO_CARRERA =p.CODIGO_CARRERA
order by p.PARADA_BOX_TIEMPO desc
