-- AUTO
INSERT INTO COSMICOS.AUTO (AUTO_NUMERO, AUTO_MODELO , CODIGO_PILOTO , CODIGO_ESCUDERIA , MOTOR_NRO_SERIE, CAJA_NRO_SERIE)
SELECT DISTINCT M.AUTO_NUMERO,M.AUTO_MODELO,P.CODIGO_PILOTO,E.CODIGO_ESCUDERIA,M.TELE_MOTOR_NRO_SERIE,M.TELE_CAJA_NRO_SERIE
FROM gd_esquema.Maestra AS M
JOIN COSMICOS.PILOTO AS P on P.PILOTO_NOMBRE = M.PILOTO_NOMBRE and P.PILOTO_APELLIDO = UPPER(M.PILOTO_APELLIDO)
JOIN COSMICOS.ESCUDERIA AS E ON E.ESCUDERIA_NOMBRE = M.ESCUDERIA_NOMBRE and E.ESCUDERIA_NACIONALIDAD = M.ESCUDERIA_NACIONALIDAD
WHERE M.TELE_MOTOR_NRO_SERIE IS NOT NULL AND M.TELE_CAJA_NRO_SERIE IS NOT NULL

-- NEUMATICO_POR_AUTO
           -- BEGIN TRAN AAA
          -- hacer rollback despues porque no anda todavia !!!!!!!!!!!!!!!!!!!
                INSERT INTO COSMICOS.NEUMATICO_POR_AUTO (NEUMATICO_NRO_SERIE, CODIGO_AUTO, ACTIVO)
                SELECT DISTINCT NEUMATICO1_NRO_SERIE_NUEVO, a.CODIGO_AUTO, 0
                FROM gd_esquema.Maestra m
                JOIN COSMICOS.AUTO a ON m.AUTO_NUMERO = a.AUTO_NUMERO AND m.AUTO_MODELO = a.AUTO_MODELO
                WHERE NEUMATICO1_NRO_SERIE_NUEVO IS NOT NULL
                UNION
                SELECT DISTINCT NEUMATICO1_NRO_SERIE_VIEJO, a.CODIGO_AUTO, 0
                FROM gd_esquema.Maestra m
                JOIN COSMICOS.AUTO a ON m.AUTO_NUMERO = a.AUTO_NUMERO AND m.AUTO_MODELO = a.AUTO_MODELO
                WHERE NEUMATICO1_NRO_SERIE_VIEJO IS NOT NULL
                UNION
                SELECT DISTINCT NEUMATICO2_NRO_SERIE_NUEVO, a.CODIGO_AUTO, 0
                FROM gd_esquema.Maestra m
                JOIN COSMICOS.AUTO a ON m.AUTO_NUMERO = a.AUTO_NUMERO AND m.AUTO_MODELO = a.AUTO_MODELO
                WHERE NEUMATICO2_NRO_SERIE_NUEVO IS NOT NULL
                UNION 
                SELECT DISTINCT NEUMATICO2_NRO_SERIE_VIEJO, a.CODIGO_AUTO, 0
                FROM gd_esquema.Maestra m
                JOIN COSMICOS.AUTO a ON m.AUTO_NUMERO = a.AUTO_NUMERO AND m.AUTO_MODELO = a.AUTO_MODELO
                WHERE NEUMATICO2_NRO_SERIE_VIEJO IS NOT NULL
                UNION
                SELECT DISTINCT NEUMATICO3_NRO_SERIE_NUEVO, a.CODIGO_AUTO, 0
                FROM gd_esquema.Maestra m
                JOIN COSMICOS.AUTO a ON m.AUTO_NUMERO = a.AUTO_NUMERO AND m.AUTO_MODELO = a.AUTO_MODELO
                WHERE NEUMATICO3_NRO_SERIE_NUEVO IS NOT NULL
                UNION
                SELECT DISTINCT NEUMATICO3_NRO_SERIE_VIEJO, a.CODIGO_AUTO, 0
                FROM gd_esquema.Maestra m
                JOIN COSMICOS.AUTO a ON m.AUTO_NUMERO = a.AUTO_NUMERO AND m.AUTO_MODELO = a.AUTO_MODELO
                WHERE NEUMATICO3_NRO_SERIE_VIEJO IS NOT NULL
                UNION
                SELECT DISTINCT NEUMATICO4_NRO_SERIE_NUEVO, a.CODIGO_AUTO, 0
                FROM gd_esquema.Maestra m
                JOIN COSMICOS.AUTO a ON m.AUTO_NUMERO = a.AUTO_NUMERO AND m.AUTO_MODELO = a.AUTO_MODELO
                WHERE NEUMATICO4_NRO_SERIE_NUEVO IS NOT NULL
                UNION
                SELECT DISTINCT NEUMATICO4_NRO_SERIE_VIEJO, a.CODIGO_AUTO, 0
                FROM gd_esquema.Maestra m
                JOIN COSMICOS.AUTO a ON m.AUTO_NUMERO = a.AUTO_NUMERO AND m.AUTO_MODELO = a.AUTO_MODELO
                WHERE NEUMATICO4_NRO_SERIE_VIEJO IS NOT NULL
                ORDER BY 2
                
              -- setarmos en 1 los activos
                
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

         
