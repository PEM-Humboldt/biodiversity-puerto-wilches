
WITH a AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='mamiferos_event'
),b AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='mamiferos_us_event'
)
SELECT
    CASE
        WHEN a.table_name IS NULL THEN 'NULL::'||b.data_type||' AS "'||column_name||'",'
        ELSE '"'||column_name||'"'||
            CASE
                WHEN a.data_type='double precision' AND b.data_type='text' THEN '::text,'
                ELSE ','
            END
    END
FROM a
FULL OUTER JOIN b USING (column_name)
ORDER BY COALESCE(a.ordinal_position,b.ordinal_position);

WITH a AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='mamiferos_event'
),b AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='mamiferos_us_event'
)
SELECT
    CASE
        WHEN b.table_name IS NULL THEN 'NULL::'||a.data_type||' AS "'||column_name||'",'
        ELSE '"'||column_name||'"'||
            CASE
                WHEN b.data_type='double precision' AND a.data_type='text' THEN '::text,'
                ELSE ','
            END
    END
FROM a
FULL OUTER JOIN b USING (column_name)
ORDER BY COALESCE(a.ordinal_position,b.ordinal_position);


WITH a AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='mamiferos_registros'
),b AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='mamiferos_us_registros'
)
SELECT
    CASE
        WHEN a.table_name IS NULL THEN 'NULL::'||b.data_type||' AS "'||column_name||'",'
        ELSE '"'||column_name||'"'||
            CASE
                WHEN a.data_type='double precision' AND b.data_type='text' THEN '::text,'
                ELSE ','
            END
    END
FROM a
FULL OUTER JOIN b USING (column_name)
ORDER BY COALESCE(a.ordinal_position,b.ordinal_position);

WITH a AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='mamiferos_registros'
),b AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='mamiferos_us_registros'
)
SELECT
    CASE
        WHEN b.table_name IS NULL THEN 'NULL::'||a.data_type||' AS "'||column_name||'",'
        ELSE '"'||column_name||'"'||
            CASE
                WHEN b.data_type='double precision' AND a.data_type='text' THEN '::text,'
                ELSE ','
            END
    END
FROM a
FULL OUTER JOIN b USING (column_name)
ORDER BY COALESCE(a.ordinal_position,b.ordinal_position);

-------------------------------Hidrobiologicos---------------------------------------

WITH fipl AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='hidrobiologico_registros_fitoplancton'
),zopl AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='hidrobiologico_registros_zooplancton'
),peri AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='hidrobiologico_registros_perifiton'
),mafi AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='hidrobiologico_registros_macrofitas'
),minv AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='hidrobiologico_registros_macroinvertebrados'
), res AS(
SELECT column_name,
CASE
 WHEN fipl.data_type='text' OR zopl.data_type='text'  OR peri.data_type='text'  OR mafi.data_type='text'  OR minv.data_type='text' THEN 'text'
 ELSE 'double precision'
END data_type,
fipl.table_name IS NOT NULL fipl,
zopl.table_name IS NOT NULL zopl,
peri.table_name IS NOT NULL peri,
mafi.table_name IS NOT NULL mafi,
minv.table_name IS NOT NULL minv
FROM fipl
FULL OUTER JOIN zopl USING (column_name)
FULL OUTER JOIN peri USING (column_name)
FULL OUTER JOIN mafi USING (column_name)
FULL OUTER JOIN minv USING (column_name)
ORDER BY COALESCE(fipl.ordinal_position,zopl.ordinal_position,peri.ordinal_position,mafi.ordinal_position,minv.ordinal_position)
)
SELECT
  CASE
        WHEN NOT fipl THEN 'NULL::'||data_type||' AS "'||column_name||'",'
        ELSE '"'||column_name||'"::'||data_type||','
    END
FROM res
;


WITH fipl AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='hidrobiologico_registros_fitoplancton'
),zopl AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='hidrobiologico_registros_zooplancton'
),peri AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='hidrobiologico_registros_perifiton'
),mafi AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='hidrobiologico_registros_macrofitas'
),minv AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='hidrobiologico_registros_macroinvertebrados'
), res AS(
SELECT column_name,
CASE
 WHEN fipl.data_type='text' OR zopl.data_type='text'  OR peri.data_type='text'  OR mafi.data_type='text'  OR minv.data_type='text' THEN 'text'
 ELSE 'double precision'
END data_type,
fipl.table_name IS NOT NULL fipl,
zopl.table_name IS NOT NULL zopl,
peri.table_name IS NOT NULL peri,
mafi.table_name IS NOT NULL mafi,
minv.table_name IS NOT NULL minv
FROM fipl
FULL OUTER JOIN zopl USING (column_name)
FULL OUTER JOIN peri USING (column_name)
FULL OUTER JOIN mafi USING (column_name)
FULL OUTER JOIN minv USING (column_name)
ORDER BY COALESCE(fipl.ordinal_position,zopl.ordinal_position,peri.ordinal_position,mafi.ordinal_position,minv.ordinal_position)
)
SELECT
  CASE
        WHEN zopl IS NULL THEN 'NULL::'||data_type||' AS "'||column_name||'",'
        ELSE '"'||column_name||'"::'||data_type||','
    END
FROM res
;


WITH fipl AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='hidrobiologico_registros_fitoplancton'
),zopl AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='hidrobiologico_registros_zooplancton'
),peri AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='hidrobiologico_registros_perifiton'
),mafi AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='hidrobiologico_registros_macrofitas'
),minv AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='hidrobiologico_registros_macroinvertebrados'
), res AS(
SELECT column_name,
CASE
 WHEN fipl.data_type='text' OR zopl.data_type='text'  OR peri.data_type='text'  OR mafi.data_type='text'  OR minv.data_type='text' THEN 'text'
 ELSE 'double precision'
END data_type,
fipl.table_name IS NOT NULL fipl,
zopl.table_name IS NOT NULL zopl,
peri.table_name IS NOT NULL peri,
mafi.table_name IS NOT NULL mafi,
minv.table_name IS NOT NULL minv
FROM fipl
FULL OUTER JOIN zopl USING (column_name)
FULL OUTER JOIN peri USING (column_name)
FULL OUTER JOIN mafi USING (column_name)
FULL OUTER JOIN minv USING (column_name)
ORDER BY COALESCE(fipl.ordinal_position,zopl.ordinal_position,peri.ordinal_position,mafi.ordinal_position,minv.ordinal_position)
)
SELECT
  CASE
        WHEN peri IS NULL THEN 'NULL::'||data_type||' AS "'||column_name||'",'
        ELSE '"'||column_name||'"::'||data_type||','
    END
FROM res
;


WITH fipl AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='hidrobiologico_registros_fitoplancton'
),zopl AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='hidrobiologico_registros_zooplancton'
),peri AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='hidrobiologico_registros_perifiton'
),mafi AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='hidrobiologico_registros_macrofitas'
),minv AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='hidrobiologico_registros_macroinvertebrados'
), res AS(
SELECT column_name,
CASE
 WHEN fipl.data_type='text' OR zopl.data_type='text'  OR peri.data_type='text'  OR mafi.data_type='text'  OR minv.data_type='text' THEN 'text'
 ELSE 'double precision'
END data_type,
fipl.table_name IS NOT NULL fipl,
zopl.table_name IS NOT NULL zopl,
peri.table_name IS NOT NULL peri,
mafi.table_name IS NOT NULL mafi,
minv.table_name IS NOT NULL minv
FROM fipl
FULL OUTER JOIN zopl USING (column_name)
FULL OUTER JOIN peri USING (column_name)
FULL OUTER JOIN mafi USING (column_name)
FULL OUTER JOIN minv USING (column_name)
ORDER BY COALESCE(fipl.ordinal_position,zopl.ordinal_position,peri.ordinal_position,mafi.ordinal_position,minv.ordinal_position)
)
SELECT
  CASE
        WHEN mafi IS NULL THEN 'NULL::'||data_type||' AS "'||column_name||'",'
        ELSE '"'||column_name||'"::'||data_type||','
    END
FROM res
;



WITH fipl AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='hidrobiologico_registros_fitoplancton'
),zopl AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='hidrobiologico_registros_zooplancton'
),peri AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='hidrobiologico_registros_perifiton'
),mafi AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='hidrobiologico_registros_macrofitas'
),minv AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='hidrobiologico_registros_macroinvertebrados'
), res AS(
SELECT column_name,
CASE
 WHEN fipl.data_type='text' OR zopl.data_type='text'  OR peri.data_type='text'  OR mafi.data_type='text'  OR minv.data_type='text' THEN 'text'
 ELSE 'double precision'
END data_type,
fipl.table_name IS NOT NULL fipl,
zopl.table_name IS NOT NULL zopl,
peri.table_name IS NOT NULL peri,
mafi.table_name IS NOT NULL mafi,
minv.table_name IS NOT NULL minv
FROM fipl
FULL OUTER JOIN zopl USING (column_name)
FULL OUTER JOIN peri USING (column_name)
FULL OUTER JOIN mafi USING (column_name)
FULL OUTER JOIN minv USING (column_name)
ORDER BY COALESCE(fipl.ordinal_position,zopl.ordinal_position,peri.ordinal_position,mafi.ordinal_position,minv.ordinal_position)
)
SELECT
  CASE
        WHEN minv IS NULL THEN 'NULL::'||data_type||' AS "'||column_name||'",'
        ELSE '"'||column_name||'"::'||data_type||','
    END
FROM res
;


