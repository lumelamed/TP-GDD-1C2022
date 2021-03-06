--Q1
--Desgaste promedio de cada componente de cada auto por vuelta por circuito. 
--Tener en cuenta que, para el cálculo del desgaste de los neumáticos, se  toma la diferencia de mm del mismo entre la medición inicial y final de cada vuelta.
--Lo mismo aplica para el desgaste de frenos. Para el cálculo del desgaste del motor se toma en cuenta la perdida de potencia. 


--Q2
--Mejor tiempo de vuelta de cada escudería por circuito por año. 
--El mejor tiempo está dado por el mínimo tiempo en que un auto logra realizar una vuelta de un circuito. 

create view MejorTiempoVuelta_XEscuderia_XCircuito_Xanio as
select top 3  Q2_MejorTiempoVuelta_XEscuderia_XCircuito_Xanio as tiempo, Anio ,HP.CODIGO_AUTO, DA.CODIGO_PILOTO, DA.AUTO_NUMERO, DA.MOTOR_NRO_SERIE, DA.CAJA_NRO_SERIE, HP.CODIGO_ESCUDERIA, DE.ESCUDERIA_NOMBRE CIRCUITO_CODIGO 
from COSMICOS.BI_HechosPrincipal HP
join COSMICOS.BI_DIMENSION_AUTO DA on DA.CODIGO_AUTO = HP.CODIGO_AUTO
JOIN COSMICOS.BI_DIMENSION_ESCUDERIA DE ON DE.CODIGO_ESCUDERIA = HP.CODIGO_ESCUDERIA
where Q2_MejorTiempoVuelta_XEscuderia_XCircuito_Xanio is not null
order by Q2_MejorTiempoVuelta_XEscuderia_XCircuito_Xanio


--Q3
--Los 3 de circuitos con mayor consumo de combustible promedio. 
CREATE VIEW COSMICOS.Circuitos_Mayor_Consumo AS
SELECT TOP 3 H.CIRCUITO_CODIGO, C.CIRCUITO_NOMBRE, Q3_Prom_Consumo_Combustible_XCircuito AS COMBUSTIBLE_PROMEDIO 
FROM COSMICOS.BI_HechosPrincipal H
JOIN COSMICOS.BI_DIMENSION_CIRCUITO C ON H.CIRCUITO_CODIGO = C.CIRCUITO_CODIGO
ORDER BY Q3_Prom_Consumo_Combustible_XCircuito
-- dado que el dato de las telemetrias de "Combustible", corresponde a "Cantidad de combustible actual en el auto en lts",
-- entonces si tienen poco combustible es porque consumieron mas

--Q4
--Máxima velocidad alcanzada por cada auto en cada tipo de sector de cada circuito. 
CREATE VIEW MaxVelocidadAutoSectorCircuito as
select HP.id_auto,HP.CIRCUITO_CODIGO, DS.SECTOR_TIPO ,HP.Q4_Max_Velocidad_XAuto_XSector_XCircuito from Cosmicos.BI_HechosPrincipal HP
JOIN COSMICOS.BI_DIMENSION_SECTOR DS on DS.CODIGO_SECTOR = HP.CODIGO_SECTOR
GO


--Q5
--Tiempo promedio que tardó cada escudería en las paradas por cuatrimestre. 
CREATE VIEW TiempoPromioParadaCuatri as
		select Q5_Tiempo_Prom_XEscuderia_Xanio_XSector,Cuatrimestre,Anio from Cosmicos.BI_HechosPrincipal HP
		join COSMICOS.BI_DIMENSION_ESCUDERIA ES on ES.CODIGO_ESCUDERIA = HP.CODIGO_ESCUDERIA  
	go
  
--Q6
--Cantidad de paradas por circuito por escudería por año. 
CREATE VIEW COSMICOS.cantParadasCircEscAnio as
		select DE.ESCUDERIA_NOMBRE,DI.CIRCUITO_NOMBRE, HP.Q6_Cant_Paradas_XCirc_Xanio_XEscuderia from Cosmicos.BI_HechosPrincipal HP
		join COSMICOS.BI_DIMENSION_ESCUDERIA DE ON DE.CODIGO_ESCUDERIA = HP.CODIGO_ESCUDERIA 
		JOIN COSMICOS.BI_DIMENSION_CIRCUITO DI ON DI.CIRCUITO_CODIGO = HP.CIRCUITO_CODIGO
	GO

--Q7
--Los 3 circuitos donde se consume mayor cantidad en tiempo de paradas en boxes. 


create view Tiempo_XParada_XCircuito as
select top 3 CIRCUITO_CODIGO,  Q7_Tiempo_XParada_XCircuito as tiempo_parada
from COSMICOS.BI_HechosPrincipal
where Q7_Tiempo_XParada_XCircuito is not null 
order by Q7_Tiempo_XParada_XCircuito desc

--Q8
--Los 3 circuitos más peligrosos del año, en función mayor cantidad de incidentes. 

CREATE VIEW V_circuitos_mas_peligrosos_por_año(
CODIGO_CICUITO , NOMBRE_CIRCUITO , TIPO_DE_SECTOR , CANT_INCIDENTES, AÑO
)AS
SELECT H.CIRCUITO_CODIGO, CIRCUITO_NOMBRE, DESCRIPCION, [Q8_Cant_Incidente_XCircuito_XAnio], ANIO
FROM [COSMICOS].[BI_HechosPrincipal] H
JOIN [COSMICOS].[CIRCUITO] C ON C.CIRCUITO_CODIGO = H.CIRCUITO_CODIGO
JOIN [COSMICOS].[TIPO_SECTOR] T ON T.SECTOR_TIPO = H.CODIGO_SECTOR
where Q8_Cant_Incidente_XCircuito_XAnio IS NOT NULL AND H.CODIGO_ESCUDERIA IS NULL
go

select * from V_circuitos_mas_peligrosos_por_año

--Q9
--Promedio de incidentes que presenta cada escudería por año en los distintos tipo de sectores. 

CREATE VIEW V_promedio_incidentes_escuderia_por_año_por_tipo_de_sector(   -- aca se va a joinear con el tipo de sector para poder promediar la suma de todos los inicidentes de un tipo de sector y luego dividirlo por los codigos_sector
CODIGO_ESCUDERIA, NOMBRE_ESCUDERIA, TIPO_SECTOR, AÑO, PROMEDIO_INCIDENTES)
AS
SELECT H.CODIGO_ESCUDERIA, E.ESCUDERIA_NOMBRE, DESCRIPCION , H.Anio, SUM(H.Q8_Cant_Incidente_XCircuito_XAnio)/COUNT(H.CODIGO_SECTOR)
FROM [COSMICOS].HechosPrincipal H 
JOIN [COSMICOS].ESCUDERIA E ON E.CODIGO_ESCUDERIA = H.CODIGO_ESCUDERIA
JOIN [COSMICOS].SECTOR S ON S.CODIGO_SECTOR = H.CODIGO_SECTOR
JOIN [COSMICOS].TIPO_SECTOR T ON T.SECTOR_TIPO = S.SECTOR_TIPO
WHERE Q8_Cant_Incidente_XCircuito_XAnio IS NOT NULL AND H.CIRCUITO_CODIGO IS NULL
GROUP BY  H.CODIGO_ESCUDERIA, E.ESCUDERIA_NOMBRE, DESCRIPCION, H.Anio
GO

SELECT * FROM V_promedio_incidentes_escuderia_por_año_por_tipo_de_sector

