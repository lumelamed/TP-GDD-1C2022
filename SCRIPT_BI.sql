--CREACION DE TABLAS-----------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE [COSMICOS].[DIMENSION_CIRCUITO] (
  [CIRCUITO_CODIGO] int PRIMARY KEY, --importado de tabla maestra
  [CIRCUITO_NOMBRE] nvarchar(255),
 )
GO

CREATE TABLE [COSMICOS].[DIMENSION_SECTOR] (
  [CODIGO_SECTOR] int PRIMARY KEY, --importado de tabla maestra
  [SECTOR_DISTANCIA] decimal(18,2),
  [SECTOR_TIPO] nvarchar(255),
  --SECTORTIPO INT
  --[CIRCUITO_CODIGO] int NOT NULL
)
GO


CREATE TABLE [COSMICOS].[DIMENSION_ESCUDERIA] (
  [CODIGO_ESCUDERIA] int PRIMARY KEY , --agregado por nosotros
  [ESCUDERIA_NOMBRE] varchar(50),
  --[ESCUDERIA_NACIONALIDAD] varchar(50)
)
GO

CREATE TABLE [COSMICOS].[DIMENSION_AUTO] (
  [CODIGO_AUTO] int  PRIMARY KEY , --agregado por nosotros
  [AUTO_NUMERO] int NOT NULL,
  --[AUTO_MODELO] nvarchar(255),
  [CODIGO_PILOTO] int NOT NULL,
  [CODIGO_ESCUDERIA] int NOT NULL,
  -- DE AUTO X CARRERA
  [MOTOR_NRO_SERIE] nvarchar(255) NULL,
  [CAJA_NRO_SERIE] nvarchar(255) NULL,
)
GO

CREATE TABLE [COSMICOS].[HechosPrincipal](
	[hecho_id] int PRIMARY KEY IDENTITY(1, 1),
	 [id_auto] int REFERENCES [COSMICOS].[DIMENSION_AUTO] ,
	 [CODIGO_ESCUDERIA] int REFERENCES [COSMICOS].[DIMENSION_ESCUDERIA] ,
	 [CIRCUITO_CODIGO] int  REFERENCES [COSMICOS].[DIMENSION_CIRCUITO],
	 [CODIGO_SECTOR] int REFERENCES [COSMICOS].[DIMENSION_SECTOR] ,
	 [Q2_MejorTiempoVuelta_XEscuderia_XCircuito_Xanio] decimal(18,10) null,
	 [Q3_Prom_Consumo_Combustible_XCircuito] decimal(18,2) null,
	 [Q4_Max_Velocidad_XAuto_XSector_XCircuito] decimal(18,2) null,
	 [Q5_Tiempo_Prom_XEscuderia_Xanio_XSector] decimal(18,10) null,
	 [Q6_Cant_Paradas_XCirc_Xanio_XEscuderia] int null,
	 [Q7_Tiempo_XParada_XCircuito] decimal(18,10) null,
	 [Q8_Cant_Incidente_XCircuito_XAnio] int null,
	 [Q9_Prom_Incidentes_XEsc_Xanio_Xsector] decimal(18,2) null,
	 [Anio] int,
	 [Cuatrimestre] int

)
go
-- faltan las FK
CREATE TABLE [COSMICOS].[HechosNeumaticos](
	[ID_HECHO_NEU] INT PRIMARY KEY IDENTITY(1, 1) ,
	[CODIGO_AUTO] int REFERENCES [COSMICOS].[DIMENSION_AUTO],
	[CIRCUITO_CODIGO] int  REFERENCES [COSMICOS].[DIMENSION_CIRCUITO],
	[NUMERO_VUELTA] int null ,
	[AUTO_COMBUSTIBLE] decimal(18,6) null,
	[DESGASTE_MOTOR] decimal(18,6) null,
	[DESGASTE_CAJA] decimal(18,6) null,
	[DESGASTE_NEUMATICO_1] decimal(18,6) null,
	[DESGASTE_NEUMATICO_2] decimal(18,6) null,
	[DESGASTE_NEUMATICO_3] decimal(18,6) null,
	[DESGASTE_NEUMATICO_4] decimal(18,6) null,
	[DESGASTE_FRENO_1] decimal(18,2) null,
	[DESGASTE_FRENO_2] decimal(18,2) null,
	[DESGASTE_FRENO_3] decimal(18,2) null,
	[DESGASTE_FRENO_4] decimal(18,2) null
)




--INSERT EN LAS DIMENSIONES-----------------------------------------------------------------------------------------------------------------------------------------------
--dimension_escuderia

INSERT INTO[COSMICOS].[DIMENSION_ESCUDERIA] SELECT
  [CODIGO_ESCUDERIA] , --agregado por nosotros
  [ESCUDERIA_NOMBRE] 
FROM [COSMICOS].[ESCUDERIA]

--dimension_auto
INSERT INTO [COSMICOS].[DIMENSION_AUTO]  SELECT
  AC.[CODIGO_AUTO_POR_CARRERA], --agregado por nosotros
  [AUTO_NUMERO] ,
  [CODIGO_PILOTO] ,
  [CODIGO_ESCUDERIA] ,
  [MOTOR_NRO_SERIE],
  [CAJA_NRO_SERIE] 
  FROM [COSMICOS].[AUTO] A
  JOIN [COSMICOS].[AUTO_POR_CARRERA] AC ON AC.CODIGO_AUTO = A.CODIGO_AUTO 

--dimension_circuito
INSERT INTO [COSMICOS].[DIMENSION_CIRCUITO] SELECT
  [CIRCUITO_CODIGO] ,
  [CIRCUITO_NOMBRE] 
  FROM [COSMICOS].[CIRCUITO]

--dimension_sector
INSERT INTO [COSMICOS].[DIMENSION_SECTOR] SELECT
  [CODIGO_SECTOR] , --importado de tabla maestra
  [SECTOR_DISTANCIA] ,
  [DESCRIPCION]
FROM [COSMICOS].[SECTOR] S 
LEFT JOIN  [COSMICOS].[TIPO_SECTOR] T ON S.SECTOR_TIPO = T.SECTOR_TIPO


--INSERT EN LOS HECHOS-----------------------------------------------------------------------------------------------------------------------------------------------
--Q1
--Desgaste promedio de cada componente de cada auto por vuelta por circuito. 
--Tener en cuenta que, para el cálculo del desgaste de los neumáticos, se  toma la diferencia de mm del mismo entre la medición inicial y final de cada vuelta.
--Lo mismo aplica para el desgaste de frenos. Para el cálculo del desgaste del motor se toma en cuenta la perdida de potencia. 


--Q2
--Mejor tiempo de vuelta de cada escudería por circuito por año. 
--El mejor tiempo está dado por el mínimo tiempo en que un auto logra realizar una vuelta de un circuito. 

--listop
insert into COSMICOS.HechosPrincipal (Q2_MejorTiempoVuelta_XEscuderia_XCircuito_Xanio,Anio ,CODIGO_AUTO, CODIGO_ESCUDERIA, CIRCUITO_CODIGO) 
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
order by CODIGO_ESCUDERIA,  AÑO_CARRERA,TELE_AUTO_TIEMPO_VUELTA 

--Q3
--Los 3 de circuitos con mayor consumo de combustible promedio. 

--Q4
--Máxima velocidad alcanzada por cada auto en cada tipo de sector de cada circuito. 
insert into Cosmicos.HechosPrincipal (id_auto,CODIGO_SECTOR,CIRCUITO_CODIGO,Q4_Max_Velocidad_XAuto_XSector_XCircuito) 
(SELECT AC.CODIGO_AUTO,TS.SECTOR_TIPO,C.CIRCUITO_CODIGO ,MAX(TELE_AUTO_VELOCIDAD)  from COSMICOS.TELEMETRIA as T
JOIN COSMICOS.SECTOR as S on S.CODIGO_SECTOR = T.CODIGO_SECTOR
JOIN COSMICOS.CIRCUITO as C on C.CIRCUITO_CODIGO = S.CIRCUITO_CODIGO
JOIN COSMICOS.TIPO_SECTOR as TS on TS.SECTOR_TIPO = S.SECTOR_TIPO
JOIN COSMICOS.AUTO_POR_CARRERA as AC on AC.CODIGO_AUTO_POR_CARRERA = T.CODIGO_AUTO_POR_CARRERA
GROUP BY AC.CODIGO_AUTO,TS.SECTOR_TIPO ,C.CIRCUITO_CODIGO)

--Q5
--Tiempo promedio que tardó cada escudería en las paradas por cuatrimestre. 
INSERT INTO Cosmicos.HechosPrincipal (CODIGO_ESCUDERIA,Q5_Tiempo_Prom_XEscuderia_Xanio_XSector,Cuatrimestre,Anio)

(SELECT E.CODIGO_ESCUDERIA,AVG(PARADA_BOX_TIEMPO) "Promedio", CASE  
	WHEN MONTH(CR.CARRERA_FECHA) >= 1 AND MONTH(CARRERA_FECHA) <= 4 THEN 1
	WHEN MONTH(CR.CARRERA_FECHA) >= 5 AND MONTH(CARRERA_FECHA) <= 8 THEN 2
	WHEN MONTH(CR.CARRERA_FECHA) >= 9 AND MONTH(CARRERA_FECHA) <= 12 THEN 3
	end AS "Cuatrimestre",YEAR(CR.CARRERA_FECHA) as "ANIO"
	 FROM COSMICOS.PARADA_BOX PB
JOIN COSMICOS.AUTO_POR_CARRERA AC ON AC.CODIGO_AUTO_POR_CARRERA =  PB.CODIGO_AUTO_POR_CARRERA
JOIN COSMICOS.AUTO A ON AC.CODIGO_AUTO = A.CODIGO_AUTO
JOIN COSMICOS.ESCUDERIA E ON A.CODIGO_ESCUDERIA = E.CODIGO_ESCUDERIA
JOIN COSMICOS.CARRERA CR ON AC.CODIGO_CARRERA = CR.CODIGO_CARRERA
GROUP BY E.CODIGO_ESCUDERIA,CASE  
	WHEN MONTH(CR.CARRERA_FECHA) >= 1 AND MONTH(CARRERA_FECHA) <= 4 THEN 1
	WHEN MONTH(CR.CARRERA_FECHA) >= 5 AND MONTH(CARRERA_FECHA) <= 8 THEN 2
	WHEN MONTH(CR.CARRERA_FECHA) >= 9 AND MONTH(CARRERA_FECHA) <= 12 THEN 3
	end,YEAR(CR.CARRERA_FECHA)
	)
	
--Q6
--Cantidad de paradas por circuito por escudería por año. 

--Q7
--Los 3 circuitos donde se consume mayor cantidad en tiempo de paradas en boxes. 

--listop, si em da el tiempo el saco el sum e inetnto hacerlo por tiempos individuales

insert into COSMICOS.HechosPrincipal (CIRCUITO_CODIGO,  Q7_Tiempo_XParada_XCircuito)
select  c.CIRCUITO_CODIGO, sum(p.PARADA_BOX_TIEMPO)
from cosmicos.PARADA_BOX p 
join  cosmicos.CARRERA c on c.CODIGO_CARRERA =p.CODIGO_CARRERA
group by c.CIRCUITO_CODIGO  
order by sum(p.PARADA_BOX_TIEMPO) desc




--Q8
--Los 3 circuitos más peligrosos del año, en función mayor cantidad de incidentes. 
---------------------------------------------------------------------------------------------------
--DELETE FROM [COSMICOS].[HechosPrincipal] WHERE Anio IS NOT NULL and CODIGO_SECTOR is not null
--go

DELETE FROM [COSMICOS].HechosPrincipal
GO 

DROP PROCEDURE insetar_en_hehos_top3_circuitos_peligrosos_por_anio 
go

create procedure insetar_en_hehos_top3_circuitos_peligrosos_por_anio 
as begin
	declare @anio int
	declare @contador int
	declare  top3_circuitos cursor for
	SELECT DISTINCT YEAR(CARRERA_FECHA) FROM [COSMICOS].CARRERA ORDER BY 1 DESC
	
	open top3_circuitos
	fetch next FROM top3_circuitos 
	into @anio

	while @@FETCH_STATUS = 0
	begin
		insert into [COSMICOS].[HechosPrincipal] ([CIRCUITO_CODIGO], [CODIGO_SECTOR], Anio,Q8_Cant_Incidente_XCircuito_XAnio)
		select TOP 3  C.CIRCUITO_CODIGO, [SECTOR_TIPO], YEAR(CAR.CARRERA_FECHA),COUNT(CODIGO_INCIDENTE) 
		FROM [COSMICOS].[CIRCUITO] C 
		JOIN [COSMICOS].[SECTOR] S ON C.CIRCUITO_CODIGO = S.CIRCUITO_CODIGO
		JOIN [COSMICOS].[INCIDENTE] I ON S.CODIGO_SECTOR = I.CODIGO_SECTOR 
		JOIN [COSMICOS].[CARRERA] CAR ON CAR.CIRCUITO_CODIGO = C.CIRCUITO_CODIGO WHERE C.CIRCUITO_CODIGO in(
		SELECT C2.CIRCUITO_CODIGO 
		FROM [COSMICOS].[CIRCUITO] C2
		JOIN  [COSMICOS].[CARRERA] CAR ON C2.CIRCUITO_CODIGO = CAR.CIRCUITO_CODIGO
		WHERE YEAR(CAR.CARRERA_FECHA) = @anio)
		GROUP BY C.CIRCUITO_CODIGO, C.CIRCUITO_NOMBRE,[SECTOR_TIPO], YEAR(CAR.CARRERA_FECHA)
		ORDER BY 3 DESC,4 DESC
	fetch next FROM top3_circuitos 
	into @anio
	end
	CLOSE top3_circuitos
DEALLOCATE  top3_circuitos
end
go

EXEC insetar_en_hehos_top3_circuitos_peligrosos_por_anio 
go

SELECT * FROM [COSMICOS].[HechosPrincipal]
GO

DROP VIEW V_circuitos_mas_peligrosos_por_año
GO

CREATE VIEW V_circuitos_mas_peligrosos_por_año(
CODIGO_CICUITO , NOMBRE_CIRCUITO , TIPO_DE_SECTOR , CANT_INCIDENTES, AÑO
)AS
SELECT H.CIRCUITO_CODIGO, CIRCUITO_NOMBRE, DESCRIPCION, [Q8_Cant_Incidente_XCircuito_XAnio], ANIO
FROM [COSMICOS].[HechosPrincipal] H
JOIN [COSMICOS].[CIRCUITO] C ON C.CIRCUITO_CODIGO = H.CIRCUITO_CODIGO
JOIN [COSMICOS].[TIPO_SECTOR] T ON T.SECTOR_TIPO = H.CODIGO_SECTOR
where Q8_Cant_Incidente_XCircuito_XAnio IS NOT NULL AND H.CODIGO_ESCUDERIA IS NULL
go

select * from V_circuitos_mas_peligrosos_por_año

---EL ORDEN EN QUE MUESTRA LOS CIRCUITOS ES EN FUNCION A LA CANTIDAD DE ACCIDENTES (EL PRIMERO DE CADA AÑO  ES EL MAYOR), HECHO EN EL PROCEDURE
-- ESTRATEGIA: se toman los top 3 de cada año en el procedure para simplificar el procedimiento gracias al cursor, luego de insertados en la tabla de hechos
-- se le agregan los datos adicionales convenientes para una mejor lectura. 
-- se filtra con where para que solo traiga los que tienen Q8_Cant_Incidente_XCircuito_XAnio con datos y codigo escuderia null, de esta manera se asegura que se tomen 
-- las filas correspondietes ya que es no es la unica vista que usa la columna Q8_Cant_Incidente_XCircuito_XAnio con datos. 

--Q9
--Promedio de incidentes que presenta cada escudería por año en los distintos tipo de sectores. 


insert into [COSMICOS].[HechosPrincipal](
CODIGO_ESCUDERIA, CODIGO_SECTOR, Anio ,Q8_Cant_Incidente_XCircuito_XAnio)
SELECT E.CODIGO_ESCUDERIA, S.CODIGO_SECTOR, YEAR(CAR.CARRERA_FECHA) AÑO, count(I.CODIGO_INCIDENTE)  --HASTA ACA SE INSERTARON LA CANTIDAD DE INCIDENTES DE CADA ESCUDERIA POR AÑO EN CADA CODIGO_SECTOR (NO TIPO DE SCTOR)
FROM [COSMICOS].[ESCUDERIA] E																									
JOIN [COSMICOS].[AUTO] A ON E.CODIGO_ESCUDERIA = A.CODIGO_ESCUDERIA																 --NO HAY SUFICIENTES EJEMPLOS EN LA BASE PARA OBSERVAR UN RESULTADO CONVINCENTE
JOIN [COSMICOS].[AUTO_POR_INCIDENTE] AI ON A.CODIGO_AUTO = AI.CODIGO_AUTO_POR_CARRERA
JOIN [COSMICOS].[INCIDENTE] I ON I.CODIGO_INCIDENTE = AI.CODIGO_INCIDENTE
JOIN [COSMICOS].[CARRERA] CAR ON I.CODIGO_CARRERA = CAR.CODIGO_CARRERA
JOIN [COSMICOS].[SECTOR] S ON I.CODIGO_SECTOR = S.CODIGO_SECTOR
GROUP BY E.CODIGO_ESCUDERIA, S.CODIGO_SECTOR, YEAR(CARRERA_FECHA)
order by 1, 2, 3 desc
GO

SELECT * FROM [COSMICOS].[HechosPrincipal]
GO

DROP VIEW V_promedio_incidentes_escuderia_por_año_por_tipo_de_sector
GO 

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

--ESTRATEGIA: para poder obtener un promedio correcto se toma la decision de guardar en la tabla de hechos la cantidad de incidentes por año  por cada sector por escuderia, 
-- con esto luego en la vista se obtienen los datos de la tabla de hechos y teniendo en cuenta la cantidad de codigos de sector que tienen el mimso tipo como descripcion(recta, curva etc) 
-- y la suma total de incidentes en ese tipo de sector se hace el promedio y se muestra en la vista. Hay muy pocos casos de incidentes para que el promedio de mas de 1 y todos
-- acontecieron en rectas.