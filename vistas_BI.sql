--Q1
--Desgaste promedio de cada componente de cada auto por vuelta por circuito. 
--Tener en cuenta que, para el cálculo del desgaste de los neumáticos, se  toma la diferencia de mm del mismo entre la medición inicial y final de cada vuelta.
--Lo mismo aplica para el desgaste de frenos. Para el cálculo del desgaste del motor se toma en cuenta la perdida de potencia. 


--Q2
--Mejor tiempo de vuelta de cada escudería por circuito por año. 
--El mejor tiempo está dado por el mínimo tiempo en que un auto logra realizar una vuelta de un circuito. 

select top 3  Q2_MejorTiempoVuelta_XEscuderia_XCircuito_Xanio,Anio ,CODIGO_AUTO, CODIGO_ESCUDERIA, CIRCUITO_CODIGO 
from COSMICOS.HechosPrincipal 
where Q2_MejorTiempoVuelta_XEscuderia_XCircuito_Xanio is not null
order by Q2_MejorTiempoVuelta_XEscuderia_XCircuito_Xanio 


--Q3
--Los 3 de circuitos con mayor consumo de combustible promedio. 

--Q4
--Máxima velocidad alcanzada por cada auto en cada tipo de sector de cada circuito. 
CREATE VIEW MaxVelocidadAutoSectorCircuito as
select HP.id_auto,HP.CIRCUITO_CODIGO, DS.SECTOR_TIPO ,HP.Q4_Max_Velocidad_XAuto_XSector_XCircuito from Cosmicos.HechosPrincipal HP
JOIN COSMICOS.DIMENSION_SECTOR DS on DS.CODIGO_SECTOR = HP.CODIGO_SECTOR
GO


--Q5
--Tiempo promedio que tardó cada escudería en las paradas por cuatrimestre. 

-Q6
--Cantidad de paradas por circuito por escudería por año. 

--Q7
--Los 3 circuitos donde se consume mayor cantidad en tiempo de paradas en boxes. 

select top 3 CIRCUITO_CODIGO,  Q7_Tiempo_XParada_XCircuito
from COSMICOS.HechosPrincipal
where Q7_Tiempo_XParada_XCircuito is not null 
order by Q7_Tiempo_XParada_XCircuito desc

--Q8
--Los 3 circuitos más peligrosos del año, en función mayor cantidad de incidentes. 

--Q9
--Promedio de incidentes que presenta cada escudería por año en los distintos tipo de sectores. 
