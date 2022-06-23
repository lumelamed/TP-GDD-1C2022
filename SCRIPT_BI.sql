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
  [CODIGO_ESCUDERIA] int PRIMARY KEY IDENTITY(1,1), --agregado por nosotros
  [ESCUDERIA_NOMBRE] varchar(50),
  --[ESCUDERIA_NACIONALIDAD] varchar(50)
)
GO
-- GDD TE ODIO --ME TOO
CREATE TABLE [COSMICOS].[DIMENSION_AUTO] (
  [CODIGO_AUTO] int PRIMARY KEY IDENTITY(1, 1), --agregado por nosotros
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
	 [CODIGO_AUTO] int REFERENCES [COSMICOS].[DIMENSION_AUTO] ,
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
-- faltan las FK
CREATE TABLE [COSMICOS].[HechosNeumaticos](
	[ID_HECHO_NEU] INT PRIMARY KEY IDENTITY(1, 1),
	[CODIGO_AUTO] int ,
	[CIRCUITO_CODIGO] int,
	[NUMERO_VUELTA] int null,
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
INSERT INTO [COSMICOS].[DIMENSION_AUTO] SELECT
  A.[CODIGO_AUTO], --agregado por nosotros
  [AUTO_NUMERO] ,
  [CODIGO_PILOTO] ,
  [CODIGO_ESCUDERIA] ,
  M.[MOTOR_NRO_SERIE],
  C.[CAJA_NRO_SERIE] 
  FROM [COSMICOS].[AUTO] A
  JOIN [COSMICOS].[AUTO_POR_CARRERA] AC ON AC.CODIGO_AUTO = A.CODIGO_AUTO 
  JOIN [COSMICOS].[MOTOR] M ON M.MOTOR_NRO_SERIE = AC.MOTOR_NRO_SERIE
  JOIN [COSMICOS].[CAJA] C ON C.CAJA_NRO_SERIE = AC.CAJA_NRO_SERIE

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
--Tener en cuenta que, para el c�lculo del desgaste de los neum�ticos, se  toma la diferencia de mm del mismo entre la medici�n inicial y final de cada vuelta.
--Lo mismo aplica para el desgaste de frenos. Para el c�lculo del desgaste del motor se toma en cuenta la perdida de potencia. 


--Q2
--Mejor tiempo de vuelta de cada escuder�a por circuito por a�o. 
--El mejor tiempo est� dado por el m�nimo tiempo en que un auto logra realizar una vuelta de un circuito. 


--Q3
--Los 3 de circuitos con mayor consumo de combustible promedio. 

--Q4
--M�xima velocidad alcanzada por cada auto en cada tipo de sector de cada circuito. 


--Q5
--Tiempo promedio que tard� cada escuder�a en las paradas por cuatrimestre. 

--Q6
--Cantidad de paradas por circuito por escuder�a por a�o. 

--Q7
--Los 3 circuitos donde se consume mayor cantidad en tiempo de paradas en boxes. 

--Q8
--Los 3 circuitos m�s peligrosos del a�o, en funci�n mayor cantidad de incidentes. 

--Q9
--Promedio de incidentes que presenta cada escuder�a por a�o en los distintos tipo de sectores. 