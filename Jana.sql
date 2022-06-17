-- OPCION 1
CREATE VIEW MaxVelocidadAutoSectorCircuito as
SELECT AC.CODIGO_AUTO,TS.DESCRIPCION,C.CIRCUITO_CODIGO
,MAX(TELE_AUTO_VELOCIDAD) "Maxima velocidad Alcanzada" from COSMICOS.TELEMETRIA as T
JOIN COSMICOS.SECTOR as S on S.CODIGO_SECTOR = T.CODIGO_SECTOR
JOIN COSMICOS.CIRCUITO as C on C.CIRCUITO_CODIGO = S.CIRCUITO_CODIGO
JOIN COSMICOS.TIPO_SECTOR as TS on TS.SECTOR_TIPO = S.SECTOR_TIPO
JOIN COSMICOS.AUTO_POR_CARRERA as AC on AC.CODIGO_AUTO_POR_CARRERA = T.CODIGO_AUTO_POR_CARRERA
GROUP BY AC.CODIGO_AUTO,TS.DESCRIPCION,C.CIRCUITO_CODIGO
ORDER BY 1,2
-- TOMAMOS QUE UN AUTO ES UNICO POR SU CODIGO DE AUTO. 

--OPCION 2
SELECT T.CODIGO_AUTO_POR_CARRERA,TS.DESCRIPCION,C.CIRCUITO_CODIGO
,MAX(TELE_AUTO_VELOCIDAD) "Maxima velocidad Alcanzada" from COSMICOS.TELEMETRIA as T
JOIN COSMICOS.SECTOR as S on S.CODIGO_SECTOR = T.CODIGO_SECTOR
JOIN COSMICOS.CIRCUITO as C on C.CIRCUITO_CODIGO = S.CIRCUITO_CODIGO
JOIN COSMICOS.TIPO_SECTOR as TS on TS.SECTOR_TIPO = S.SECTOR_TIPO
GROUP BY CODIGO_AUTO_POR_CARRERA,TS.DESCRIPCION,C.CIRCUITO_CODIGO
ORDER BY 1,2
-- TOMAMOS QUE UN AUTO ES UNICO POR EL CODIGO AUTO POR CARRERA.  



--
CREATE VIEW TiempoPromioParadaCuatri as
SELECT E.ESCUDERIA_NOMBRE,AVG(PARADA_BOX_TIEMPO) "Promedio", CASE  
	WHEN MONTH(CR.CARRERA_FECHA) >= 1 AND MONTH(CARRERA_FECHA) <= 4 THEN 1
	WHEN MONTH(CR.CARRERA_FECHA) >= 5 AND MONTH(CARRERA_FECHA) <= 8 THEN 2
	WHEN MONTH(CR.CARRERA_FECHA) >= 9 AND MONTH(CARRERA_FECHA) <= 12 THEN 3
	end AS "Cuatrimestre",YEAR(CR.CARRERA_FECHA)
	 FROM COSMICOS.PARADA_BOX PB
JOIN COSMICOS.AUTO_POR_CARRERA AC ON AC.CODIGO_AUTO_POR_CARRERA =  PB.CODIGO_AUTO_POR_CARRERA
JOIN COSMICOS.AUTO A ON AC.CODIGO_AUTO = A.CODIGO_AUTO
JOIN COSMICOS.ESCUDERIA E ON A.CODIGO_ESCUDERIA = E.CODIGO_ESCUDERIA
JOIN COSMICOS.CARRERA CR ON AC.CODIGO_CARRERA = CR.CODIGO_CARRERA
GROUP BY E.ESCUDERIA_NOMBRE,CASE  
	WHEN MONTH(CR.CARRERA_FECHA) >= 1 AND MONTH(CARRERA_FECHA) <= 4 THEN 1
	WHEN MONTH(CR.CARRERA_FECHA) >= 5 AND MONTH(CARRERA_FECHA) <= 8 THEN 2
	WHEN MONTH(CR.CARRERA_FECHA) >= 9 AND MONTH(CARRERA_FECHA) <= 12 THEN 3
	end,YEAR(CR.CARRERA_FECHA)
