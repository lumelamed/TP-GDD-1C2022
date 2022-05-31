-- AUTO
INSERT INTO COSMICOS.AUTO (AUTO_NUMERO, AUTO_MODELO , CODIGO_PILOTO , CODIGO_ESCUDERIA)
SELECT DISTINCT M.AUTO_NUMERO,M.AUTO_MODELO,P.CODIGO_PILOTO,E.CODIGO_ESCUDERIA
FROM gd_esquema.Maestra AS M
JOIN COSMICOS.PILOTO AS P on P.PILOTO_NOMBRE = M.PILOTO_NOMBRE and P.PILOTO_APELLIDO = UPPER(M.PILOTO_APELLIDO)
JOIN COSMICOS.ESCUDERIA AS E ON E.ESCUDERIA_NOMBRE = M.ESCUDERIA_NOMBRE and E.ESCUDERIA_NACIONALIDAD = M.ESCUDERIA_NACIONALIDAD


--AUTO POR CARRERA

INSERT INTO COSMICOS.AUTO_POR_CARRERA (CODIGO_AUTO , CODIGO_CARRERA, CAJA_NRO_SERIE,TELE_MOTOR_NRO_SERIE)
SELECT DISTINCT A.CODIGO_AUTO ,C.CODIGO_CARRERA, M.TELE_CAJA_NRO_SERIE, M.TELE_MOTOR_NRO_SERIE
FROM gd_esquema.Maestra AS M
JOIN COSMICOS.AUTO A ON A.AUTO_MODELO= M.AUTO_MODELO AND A.AUTO_NUMERO =M.AUTO_NUMERO
join COSMICOS.CARRERA C ON C.CODIGO_CARRERA =M.CODIGO_CARRERA
where M.TELE_CAJA_NRO_SERIE is not null and  M.TELE_MOTOR_NRO_SERIE IS NOT NULL

--INCIDENTE
INSERT INTO COSMICOS.INCIDENTE (CODIGO_CARRERA, CODIGO_SECTOR,CODIGO_BANDERA)
SELECT DISTINCT CODIGO_CARRERA,CODIGO_SECTOR, B.CODIGO_BANDERA 
FROM gd_esquema.Maestra M
JOIN COSMICOS.BANDERA AS B ON M.INCIDENTE_BANDERA = B.COMPORTAMIENTO

-- NEUMATICO_POR_AUTO
INSERT INTO COSMICOS.NEUMATICO_POR_AUTO (NEUMATICO_NRO_SERIE, CODIGO_AUTO_POR_CARRERA, ACTIVO)
SELECT DISTINCT NEUMATICO1_NRO_SERIE_NUEVO, AC.CODIGO_AUTO_POR_CARRRA, 0
FROM gd_esquema.Maestra m
JOIN COSMICOS.AUTO a ON m.AUTO_NUMERO = a.AUTO_NUMERO AND m.AUTO_MODELO = a.AUTO_MODELO
		JOIN COSMICOS.AUTO_POR_CARRERA AC ON AC.CODIGO_CARRERA = M.CODIGO_CARRERA   AND A.CODIGO_AUTO =AC.CODIGO_AUTO
		WHERE NEUMATICO1_NRO_SERIE_NUEVO IS NOT NULL
UNION
SELECT DISTINCT NEUMATICO1_NRO_SERIE_VIEJO, AC.CODIGO_AUTO_POR_CARRRA, 0
FROM gd_esquema.Maestra m
JOIN COSMICOS.AUTO a ON m.AUTO_NUMERO = a.AUTO_NUMERO AND m.AUTO_MODELO = a.AUTO_MODELO
		JOIN COSMICOS.AUTO_POR_CARRERA AC ON AC.CODIGO_CARRERA = M.CODIGO_CARRERA  AND A.CODIGO_AUTO =AC.CODIGO_AUTO
WHERE NEUMATICO1_NRO_SERIE_VIEJO IS NOT NULL
UNION
SELECT DISTINCT NEUMATICO2_NRO_SERIE_NUEVO, AC.CODIGO_AUTO_POR_CARRRA, 0
FROM gd_esquema.Maestra m
JOIN COSMICOS.AUTO a ON m.AUTO_NUMERO = a.AUTO_NUMERO AND m.AUTO_MODELO = a.AUTO_MODELO
		JOIN COSMICOS.AUTO_POR_CARRERA AC ON AC.CODIGO_CARRERA = M.CODIGO_CARRERA  AND A.CODIGO_AUTO =AC.CODIGO_AUTO
WHERE NEUMATICO2_NRO_SERIE_NUEVO IS NOT NULL
UNION 
SELECT DISTINCT NEUMATICO2_NRO_SERIE_VIEJO, AC.CODIGO_AUTO_POR_CARRRA, 0
FROM gd_esquema.Maestra m
JOIN COSMICOS.AUTO a ON m.AUTO_NUMERO = a.AUTO_NUMERO AND m.AUTO_MODELO = a.AUTO_MODELO
		JOIN COSMICOS.AUTO_POR_CARRERA AC ON AC.CODIGO_CARRERA = M.CODIGO_CARRERA  AND A.CODIGO_AUTO =AC.CODIGO_AUTO
WHERE NEUMATICO2_NRO_SERIE_VIEJO IS NOT NULL
UNION
SELECT DISTINCT NEUMATICO3_NRO_SERIE_NUEVO, AC.CODIGO_AUTO_POR_CARRRA, 0
FROM gd_esquema.Maestra m
JOIN COSMICOS.AUTO a ON m.AUTO_NUMERO = a.AUTO_NUMERO AND m.AUTO_MODELO = a.AUTO_MODELO
		JOIN COSMICOS.AUTO_POR_CARRERA AC ON AC.CODIGO_CARRERA = M.CODIGO_CARRERA  AND A.CODIGO_AUTO =AC.CODIGO_AUTO
WHERE NEUMATICO3_NRO_SERIE_NUEVO IS NOT NULL
UNION
SELECT DISTINCT NEUMATICO3_NRO_SERIE_VIEJO, AC.CODIGO_AUTO_POR_CARRRA, 0
FROM gd_esquema.Maestra m
JOIN COSMICOS.AUTO a ON m.AUTO_NUMERO = a.AUTO_NUMERO AND m.AUTO_MODELO = a.AUTO_MODELO
		JOIN COSMICOS.AUTO_POR_CARRERA AC ON AC.CODIGO_CARRERA = M.CODIGO_CARRERA  AND A.CODIGO_AUTO =AC.CODIGO_AUTO
WHERE NEUMATICO3_NRO_SERIE_VIEJO IS NOT NULL
UNION
SELECT DISTINCT NEUMATICO4_NRO_SERIE_NUEVO, AC.CODIGO_AUTO_POR_CARRRA, 0
FROM gd_esquema.Maestra m
JOIN COSMICOS.AUTO a ON m.AUTO_NUMERO = a.AUTO_NUMERO AND m.AUTO_MODELO = a.AUTO_MODELO
		JOIN COSMICOS.AUTO_POR_CARRERA AC ON AC.CODIGO_CARRERA = M.CODIGO_CARRERA  AND A.CODIGO_AUTO =AC.CODIGO_AUTO
WHERE NEUMATICO4_NRO_SERIE_NUEVO IS NOT NULL
UNION
SELECT DISTINCT NEUMATICO4_NRO_SERIE_VIEJO, AC.CODIGO_AUTO_POR_CARRRA, 0
FROM gd_esquema.Maestra m
JOIN COSMICOS.AUTO a ON m.AUTO_NUMERO = a.AUTO_NUMERO AND m.AUTO_MODELO = a.AUTO_MODELO
		JOIN COSMICOS.AUTO_POR_CARRERA AC ON AC.CODIGO_CARRERA = M.CODIGO_CARRERA  AND A.CODIGO_AUTO =AC.CODIGO_AUTO
WHERE NEUMATICO4_NRO_SERIE_VIEJO IS NOT NULL
ORDER BY 2

-- FRENO_POR_AUTO
INSERT INTO COSMICOS.FRENO_POR_AUTO ( FRENO_NRO_SERIE ,  CODIGO_AUTO_POR_CARRERA, ACTIVO)
SELECT DISTINCT TELE_FRENO1_NRO_SERIE, AC.CODIGO_AUTO_POR_CARRRA, 0
FROM gd_esquema.Maestra m
JOIN COSMICOS.AUTO a ON m.AUTO_NUMERO = a.AUTO_NUMERO AND m.AUTO_MODELO = a.AUTO_MODELO
JOIN COSMICOS.AUTO_POR_CARRERA AC ON AC.CODIGO_CARRERA = M.CODIGO_CARRERA
WHERE TELE_FRENO1_NRO_SERIE IS NOT NULL
UNION
SELECT DISTINCT TELE_FRENO2_NRO_SERIE, AC.CODIGO_AUTO_POR_CARRRA, 0
FROM gd_esquema.Maestra m
JOIN COSMICOS.AUTO a ON m.AUTO_NUMERO = a.AUTO_NUMERO AND m.AUTO_MODELO = a.AUTO_MODELO
JOIN COSMICOS.AUTO_POR_CARRERA AC ON AC.CODIGO_CARRERA = M.CODIGO_CARRERA  AND A.CODIGO_AUTO =AC.CODIGO_AUTO
WHERE TELE_FRENO2_NRO_SERIE IS NOT NULL
UNION
SELECT DISTINCT TELE_FRENO3_NRO_SERIE, AC.CODIGO_AUTO_POR_CARRRA, 0
FROM gd_esquema.Maestra m
JOIN COSMICOS.AUTO a ON m.AUTO_NUMERO = a.AUTO_NUMERO AND m.AUTO_MODELO = a.AUTO_MODELO
JOIN COSMICOS.AUTO_POR_CARRERA AC ON AC.CODIGO_CARRERA = M.CODIGO_CARRERA  AND A.CODIGO_AUTO =AC.CODIGO_AUTO
WHERE TELE_FRENO3_NRO_SERIE IS NOT NULL
UNION 
SELECT DISTINCT TELE_FRENO4_NRO_SERIE, AC.CODIGO_AUTO_POR_CARRRA, 0
FROM gd_esquema.Maestra m
JOIN COSMICOS.AUTO a ON m.AUTO_NUMERO = a.AUTO_NUMERO AND m.AUTO_MODELO = a.AUTO_MODELO
JOIN COSMICOS.AUTO_POR_CARRERA AC ON AC.CODIGO_CARRERA = M.CODIGO_CARRERA  AND A.CODIGO_AUTO =AC.CODIGO_AUTO
WHERE TELE_FRENO4_NRO_SERIE IS NOT NULL
ORDER BY 2

-- Seteamos en 1 los neumaticos activos   --> algo no cierra porque solo 60 de los 120 autos tienen neumaticos, el resto ni tiene
DECLARE @auto_num int, @auto_modelo nvarchar(255), @cod int
DECLARE CURSOR_AUTOS CURSOR FOR 
SELECT AUTO_MODELO, AUTO_NUMERO, CODIGO_AUTO FROM COSMICOS.AUTO
OPEN CURSOR_AUTOS
FETCH NEXT FROM CURSOR_AUTOS INTO @auto_modelo, @auto_num, @cod
    WHILE @@FETCH_STATUS = 0
    BEGIN
        DECLARE @neu1 nvarchar(255), @neu2 nvarchar(255), @neu3 nvarchar(255), @neu4 nvarchar(255)

        SELECT DISTINCT @neu1 = NEUMATICO1_NRO_SERIE_NUEVO, 
                @neu2 = NEUMATICO2_NRO_SERIE_NUEVO, 
                @neu3 = NEUMATICO3_NRO_SERIE_NUEVO, 
                @neu4 = NEUMATICO4_NRO_SERIE_NUEVO 
                FROM [gd_esquema].[Maestra] m
                WHERE AUTO_MODELO = @auto_modelo AND AUTO_NUMERO = @auto_num 
                AND  NEUMATICO1_NRO_SERIE_NUEVO IS NOT NULL
                AND  NEUMATICO2_NRO_SERIE_NUEVO IS NOT NULL
                AND  NEUMATICO3_NRO_SERIE_NUEVO IS NOT NULL
                AND  NEUMATICO4_NRO_SERIE_NUEVO IS NOT NULL
                  
        UPDATE COSMICOS.NEUMATICO_POR_AUTO
        SET ACTIVO = 1
        WHERE NEUMATICO_NRO_SERIE in (@neu1, @neu2, @neu3, @neu4) AND CODIGO_AUTO = @cod

        FETCH NEXT FROM CURSOR_AUTOS INTO @auto_modelo, @auto_num, @cod
    END
CLOSE CURSOR_AUTOS
DEALLOCATE CURSOR_AUTOS


-- Seteamos en 1 los frenos activos 
DECLARE @auto_num_fre int, @auto_modelo_fre nvarchar(255), @cod_fre int
DECLARE CURSOR_AUTOS CURSOR FOR 
	SELECT AUTO_MODELO, AUTO_NUMERO, CODIGO_AUTO FROM COSMICOS.AUTO
    OPEN CURSOR_AUTOS
    FETCH NEXT FROM CURSOR_AUTOS INTO @auto_modelo_fre, @auto_num_fre, @cod_fre
    WHILE @@FETCH_STATUS = 0
    BEGIN
		DECLARE @fre1 nvarchar(255), @fre2 nvarchar(255), @fre3 nvarchar(255), @fre4 nvarchar(255)

		SELECT DISTINCT @fre1 = TELE_FRENO1_NRO_SERIE, 
                        @fre2 = TELE_FRENO2_NRO_SERIE, 
                        @fre3 = TELE_FRENO3_NRO_SERIE, 
                        @fre4 = TELE_FRENO4_NRO_SERIE 
                 FROM [gd_esquema].[Maestra] m
                 WHERE AUTO_MODELO = @auto_modelo_fre AND AUTO_NUMERO = @auto_num_fre 
                        AND  TELE_FRENO1_NRO_SERIE IS NOT NULL
                        AND  TELE_FRENO2_NRO_SERIE IS NOT NULL
                        AND  TELE_FRENO3_NRO_SERIE IS NOT NULL
                        AND  TELE_FRENO4_NRO_SERIE IS NOT NULL

                  
		UPDATE COSMICOS.FRENO_POR_AUTO
               SET ACTIVO = 1
               WHERE FRENO_NRO_SERIE in (@fre1, @fre2, @fre3, @fre4) AND CODIGO_AUTO = @cod_fre

        FETCH NEXT FROM CURSOR_AUTOS INTO @auto_modelo_fre, @auto_num_fre, @cod_fre
	END
CLOSE CURSOR_AUTOS
DEALLOCATE CURSOR_AUTOS

--AUTO_POR_INCIDENTE
INSERT INTO COSMICOS.AUTO_POR_INCIDENTE (CODIGO_INCIDENTE,CODIGO_AUTO_POR_CARRERA, TIPO_INCIDENTE, NRO_VUELTA, INCIDENTE_TIEMPO)
SELECT CODIGO_INCIDENTE,AC.CODIGO_AUTO_POR_CARRRA, TI.INCIDENTE_TIPO, M.INCIDENTE_NUMERO_VUELTA, M.INCIDENTE_TIEMPO
FROM gd_esquema.Maestra M
JOIN COSMICOS.AUTO a ON m.AUTO_NUMERO = a.AUTO_NUMERO AND m.AUTO_MODELO = a.AUTO_MODELO
JOIN COSMICOS.AUTO_POR_CARRERA AC ON AC.CODIGO_CARRERA = M.CODIGO_CARRERA AND A.CODIGO_AUTO =AC.CODIGO_AUTO
JOIN COSMICOS.TIPO_INCIDENTE TI ON M.INCIDENTE_TIPO =TI.DESCRIPCION
JOIN COSMICOS.INCIDENTE I ON I.CODIGO_CARRERA = M.CODIGO_CARRERA AND I.CODIGO_SECTOR = M.CODIGO_SECTOR
WHERE M.INCIDENTE_TIPO IS NOT NULL
ORDER BY CODIGO_INCIDENTE


--PARADA BOX
INSERT INTO COSMICOS.PARADA_BOX (CODIGO_CARRERA,CODIGO_AUTO_POR_CARRERA, PARADA_BOX_VUELTA,PARADA_BOX_TIEMPO)
SELECT DISTINCT CODIGO_CARRERA, AC.CODIGO_AUTO_POR_CARRRA ,PARADA_BOX_VUELTA,PARADA_BOX_TIEMPO
FROM gd_esquema.Maestra M
JOIN COSMICOS.AUTO a ON m.AUTO_NUMERO = a.AUTO_NUMERO AND m.AUTO_MODELO = a.AUTO_MODELO
JOIN COSMICOS.AUTO_POR_CARRERA AC ON AC.CODIGO_CARRERA = M.CODIGO_CARRERA AND A.CODIGO_AUTO =AC.CODIGO_AUTO
WHERE PARADA_BOX_VUELTA IS NOT NULL
  
    
--BANDERA Y TIPO DE INCIDENTE EN EL SCRIPT 2

--NEUMATICO POR PARADA
INSERT INTO COSMICOS.NEUMATICO_POR_PARADA ( CODIGO_NEUMATICO_POR_AUTO , CODIGO_PARADA_BOX, TIPO)
SELECT CODIGO_NEUMATICO_POR_AUTO, CODIGO_PARADA_BOX, 'NUEVO'
from gd_esquema.Maestra m
	join COSMICOS.NEUMATICO_POR_AUTO npa on m.NEUMATICO1_NRO_SERIE_NUEVO = npa.NEUMATICO_NRO_SERIE
	join COSMICOS.PARADA_BOX pb on m.PARADA_BOX_TIEMPO =pb.PARADA_BOX_TIEMPO AND m.PARADA_BOX_VUELTA = pb.PARADA_BOX_VUELTA

INSERT INTO  COSMICOS.NEUMATICO_POR_PARADA ( CODIGO_NEUMATICO_POR_AUTO , CODIGO_PARADA_BOX, TIPO)
SELECT CODIGO_NEUMATICO_POR_AUTO, CODIGO_PARADA_BOX, 'VIEJO'
from gd_esquema.Maestra m
	join COSMICOS.NEUMATICO_POR_AUTO npa on m.NEUMATICO1_NRO_SERIE_VIEJO = npa.NEUMATICO_NRO_SERIE
	join COSMICOS.PARADA_BOX pb on m.PARADA_BOX_TIEMPO =pb.PARADA_BOX_TIEMPO AND m.PARADA_BOX_VUELTA = pb.PARADA_BOX_VUELTA

INSERT INTO  COSMICOS.NEUMATICO_POR_PARADA ( CODIGO_NEUMATICO_POR_AUTO , CODIGO_PARADA_BOX, TIPO)
SELECT CODIGO_NEUMATICO_POR_AUTO, CODIGO_PARADA_BOX, 'NUEVO'
from gd_esquema.Maestra m
	join COSMICOS.NEUMATICO_POR_AUTO npa on m.NEUMATICO2_NRO_SERIE_NUEVO = npa.NEUMATICO_NRO_SERIE
	join COSMICOS.PARADA_BOX pb on m.PARADA_BOX_TIEMPO =pb.PARADA_BOX_TIEMPO AND m.PARADA_BOX_VUELTA = pb.PARADA_BOX_VUELTA

INSERT INTO  COSMICOS.NEUMATICO_POR_PARADA ( CODIGO_NEUMATICO_POR_AUTO , CODIGO_PARADA_BOX, TIPO)
SELECT CODIGO_NEUMATICO_POR_AUTO, CODIGO_PARADA_BOX, 'VIEJO'
from gd_esquema.Maestra m
	join COSMICOS.NEUMATICO_POR_AUTO npa on m.NEUMATICO2_NRO_SERIE_VIEJO = npa.NEUMATICO_NRO_SERIE
	join COSMICOS.PARADA_BOX pb on m.PARADA_BOX_TIEMPO =pb.PARADA_BOX_TIEMPO AND m.PARADA_BOX_VUELTA = pb.PARADA_BOX_VUELTA

INSERT INTO  COSMICOS.NEUMATICO_POR_PARADA ( CODIGO_NEUMATICO_POR_AUTO , CODIGO_PARADA_BOX, TIPO)
SELECT CODIGO_NEUMATICO_POR_AUTO, CODIGO_PARADA_BOX, 'NUEVO'
from gd_esquema.Maestra m
	join COSMICOS.NEUMATICO_POR_AUTO npa on m.NEUMATICO3_NRO_SERIE_NUEVO = npa.NEUMATICO_NRO_SERIE
	join COSMICOS.PARADA_BOX pb on m.PARADA_BOX_TIEMPO =pb.PARADA_BOX_TIEMPO AND m.PARADA_BOX_VUELTA = pb.PARADA_BOX_VUELTA

INSERT INTO  COSMICOS.NEUMATICO_POR_PARADA ( CODIGO_NEUMATICO_POR_AUTO , CODIGO_PARADA_BOX, TIPO)
SELECT CODIGO_NEUMATICO_POR_AUTO, CODIGO_PARADA_BOX, 'VIEJO'
from gd_esquema.Maestra m
	join COSMICOS.NEUMATICO_POR_AUTO npa on m.NEUMATICO3_NRO_SERIE_VIEJO = npa.NEUMATICO_NRO_SERIE
	join COSMICOS.PARADA_BOX pb on m.PARADA_BOX_TIEMPO =pb.PARADA_BOX_TIEMPO AND m.PARADA_BOX_VUELTA = pb.PARADA_BOX_VUELTA


INSERT INTO  COSMICOS.NEUMATICO_POR_PARADA ( CODIGO_NEUMATICO_POR_AUTO , CODIGO_PARADA_BOX, TIPO)
SELECT CODIGO_NEUMATICO_POR_AUTO, CODIGO_PARADA_BOX, 'NUEVO'
from gd_esquema.Maestra m
	join COSMICOS.NEUMATICO_POR_AUTO npa on m.NEUMATICO4_NRO_SERIE_NUEVO = npa.NEUMATICO_NRO_SERIE
	join COSMICOS.PARADA_BOX pb on m.PARADA_BOX_TIEMPO =pb.PARADA_BOX_TIEMPO AND m.PARADA_BOX_VUELTA = pb.PARADA_BOX_VUELTA

INSERT INTO  COSMICOS.NEUMATICO_POR_PARADA ( CODIGO_NEUMATICO_POR_AUTO , CODIGO_PARADA_BOX, TIPO)
SELECT CODIGO_NEUMATICO_POR_AUTO, CODIGO_PARADA_BOX, 'VIEJO'
from gd_esquema.Maestra m
	join COSMICOS.NEUMATICO_POR_AUTO npa on m.NEUMATICO4_NRO_SERIE_VIEJO = npa.NEUMATICO_NRO_SERIE
	join COSMICOS.PARADA_BOX pb on m.PARADA_BOX_TIEMPO =pb.PARADA_BOX_TIEMPO AND m.PARADA_BOX_VUELTA = pb.PARADA_BOX_VUELTA
