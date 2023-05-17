Integración de los datos de estructura de muestreo de los grupos
================
Marius Bottin
2023-05-17

- [1 Platforms](#1-platforms)
- [2 Herpetos](#2-herpetos)
  - [2.1 ANH](#21-anh)
  - [2.2 Unit, sampling efforts definition, abundance definition,
    protocolo](#22-unit-sampling-efforts-definition-abundance-definition-protocolo)
  - [2.3 Personas](#23-personas)
  - [2.4 gp_event](#24-gp_event)
  - [2.5 event](#25-event)
  - [2.6 registros](#26-registros)
- [3 Atropellamientos](#3-atropellamientos)
  - [3.1 ANH](#31-anh)
  - [3.2 Unit, sampling efforts definition, abundance definition,
    protocolo](#32-unit-sampling-efforts-definition-abundance-definition-protocolo)
  - [3.3 Personas](#33-personas)
  - [3.4 gp_event](#34-gp_event)
  - [3.5 event](#35-event)
  - [3.6 registros](#36-registros)
- [4 Mariposas](#4-mariposas)
  - [4.1 ANH](#41-anh)
  - [4.2 Unit, sampling efforts definition, abundance definition,
    protocolo](#42-unit-sampling-efforts-definition-abundance-definition-protocolo)
  - [4.3 Personas](#43-personas)
  - [4.4 gp_event](#44-gp_event)
  - [4.5 event](#45-event)
  - [4.6 registros](#46-registros)
- [5 Hormigas](#5-hormigas)
  - [5.1 ANH](#51-anh)
  - [5.2 Unit, sampling efforts definition, abundance definition,
    protocolo](#52-unit-sampling-efforts-definition-abundance-definition-protocolo)
  - [5.3 Personas](#53-personas)
  - [5.4 gp_event](#54-gp_event)
  - [5.5 event](#55-event)
  - [5.6 registros](#56-registros)
- [6 Escarabajos](#6-escarabajos)
  - [6.1 ANH](#61-anh)
  - [6.2 Unit, sampling efforts definition, abundance definition,
    protocolo](#62-unit-sampling-efforts-definition-abundance-definition-protocolo)
  - [6.3 Personas](#63-personas)
  - [6.4 gp_event](#64-gp_event)
  - [6.5 event](#65-event)
  - [6.6 registros](#66-registros)
    - [6.6.1 Añadir la información temporal
      supplementaria](#661-añadir-la-información-temporal-supplementaria)
- [7 Colémbolos](#7-colémbolos)
  - [7.1 ANH](#71-anh)
  - [7.2 Unit, sampling efforts definition, abundance definition,
    protocolo](#72-unit-sampling-efforts-definition-abundance-definition-protocolo)
  - [7.3 Personas](#73-personas)
  - [7.4 gp_event](#74-gp_event)
  - [7.5 event](#75-event)
  - [7.6 registros](#76-registros)
- [8 Aves](#8-aves)
  - [8.1 ANH](#81-anh)
  - [8.2 Unit, sampling efforts definition, abundance definition,
    protocolo](#82-unit-sampling-efforts-definition-abundance-definition-protocolo)
  - [8.3 Personas](#83-personas)
  - [8.4 gp_event](#84-gp_event)
  - [8.5 event](#85-event)
  - [8.6 registros](#86-registros)
    - [8.6.1 Añadir la información temporal
      supplementaria](#861-añadir-la-información-temporal-supplementaria)
- [9 Mamiferos](#9-mamiferos)
  - [9.1 Crear la tabla total de
    eventos](#91-crear-la-tabla-total-de-eventos)
  - [9.2 Crear la tabla total de
    registros](#92-crear-la-tabla-total-de-registros)
  - [9.3 Entender el plan de muestreo](#93-entender-el-plan-de-muestreo)
  - [9.4 ANH](#94-anh)
  - [9.5 Unit, sampling efforts definition, abundance definition,
    protocolo](#95-unit-sampling-efforts-definition-abundance-definition-protocolo)
  - [9.6 Personas](#96-personas)
  - [9.7 gp_event](#97-gp_event)
  - [9.8 event](#98-event)
    - [9.8.1 Añadir información temporal
      faltante](#981-añadir-información-temporal-faltante)
  - [9.9 registros](#99-registros)
    - [9.9.1 Añadir la información temporal
      supplementaria](#991-añadir-la-información-temporal-supplementaria)
- [10 Peces](#10-peces)
  - [10.1 Entender el plan de
    muestreo](#101-entender-el-plan-de-muestreo)
  - [10.2 ANH](#102-anh)
  - [10.3 Unit, sampling efforts definition, abundance definition,
    protocolo](#103-unit-sampling-efforts-definition-abundance-definition-protocolo)
  - [10.4 Personas](#104-personas)
  - [10.5 gp_event](#105-gp_event)
  - [10.6 event](#106-event)
    - [10.6.1 comentarios largos sobre los
      eventos](#1061-comentarios-largos-sobre-los-eventos)
    - [10.6.2 Añadir la jornada](#1062-añadir-la-jornada)
  - [10.7 registros](#107-registros)
- [11 Hidrobiologicos](#11-hidrobiologicos)
  - [11.1 Crear la tabla total de
    registros](#111-crear-la-tabla-total-de-registros)
  - [11.2 Entender el plan de
    muestreo](#112-entender-el-plan-de-muestreo)
  - [11.3 ANH](#113-anh)
  - [11.4 Unit, sampling efforts definition, abundance definition,
    protocolo](#114-unit-sampling-efforts-definition-abundance-definition-protocolo)
  - [11.5 Personas](#115-personas)
  - [11.6 gp_event](#116-gp_event)
  - [11.7 event](#117-event)
    - [11.7.1 Añadir información temporal
      faltante](#1171-añadir-información-temporal-faltante)
  - [11.8 registros](#118-registros)
- [12 Cameras trampa](#12-cameras-trampa)
  - [12.1 Entender el plan de
    muestreo](#121-entender-el-plan-de-muestreo)
  - [12.2 ANH](#122-anh)
  - [12.3 Unit, sampling efforts definition, abundance definition,
    protocolo](#123-unit-sampling-efforts-definition-abundance-definition-protocolo)
  - [12.4 Personas](#124-personas)
  - [12.5 gp_event](#125-gp_event)
  - [12.6 event](#126-event)
  - [12.7 registros](#127-registros)
- [13 Botanica (integración en
  curso)](#13-botanica-integración-en-curso)
  - [13.1 ANH](#131-anh)
  - [13.2 Unit, sampling efforts definition, abundance definition,
    protocolo](#132-unit-sampling-efforts-definition-abundance-definition-protocolo)
  - [13.3 Personas](#133-personas)
  - [13.4 gp_event](#134-gp_event)
  - [13.5 event](#135-event)
    - [13.5.1 Eventos de arboles](#1351-eventos-de-arboles)
    - [13.5.2 Eventos de epifitas
      no-vasculares](#1352-eventos-de-epifitas-no-vasculares)
    - [13.5.3 Epifitas vasculares](#1353-epifitas-vasculares)
    - [13.5.4 Añadir las fechas (sin horas) en la tabla
      event_extra](#1354-añadir-las-fechas-sin-horas-en-la-tabla-event_extra)
  - [13.6 registros](#136-registros)
    - [13.6.1 Arboles](#1361-arboles)
    - [13.6.2 Registros epifitas
      vasculares](#1362-registros-epifitas-vasculares)
    - [13.6.3 epifitas no vasculares](#1363-epifitas-no-vasculares)
- [14 Correcciones](#14-correcciones)
  - [14.1 Macroinvertebrados](#141-macroinvertebrados)
  - [14.2 Macrofitas](#142-macrofitas)
    - [14.2.1 Errores con la suma de abundancia de los
      cuadrantes](#1421-errores-con-la-suma-de-abundancia-de-los-cuadrantes)
  - [14.3 Añadir los “waterbody” de todos los eventos de muestreo
    acuatico](#143-añadir-los-waterbody-de-todos-los-eventos-de-muestreo-acuatico)

------------------------------------------------------------------------

``` r
knitr::opts_chunk$set(tidy.opts = list(width.cutoff = 70), tidy = TRUE, connection="fracking_db", max.print=100)
def.chunk.hook  <- knitr::knit_hooks$get("chunk")
knitr::knit_hooks$set(chunk = function(x, options) {
  x <- def.chunk.hook(x, options)
  paste0("\n \\", "footnotesize","\n\n", x, "\n\n \\normalsize\n\n")
})
require(openxlsx)
require(RPostgreSQL)
```

``` r
fracking_db <- dbConnect(PostgreSQL(), dbname = "fracking")
```

TODO ; error for people affectations when “row.names” are repeated
(mamiferos, hidrobiologicos, herpetos)

# 1 Platforms

**Ver archivo de exportación de los datos espaciales para entender de
donde vienen los datos espaciales brutos**

``` sql
DELETE FROM main.platform;


INSERT INTO main.platform(platform,zona_geom,plat_geom)
SELECT 'Kalé',(ST_DUMP(zonas.wkb_geometry)).geom, (ST_DUMP(kale."Shape")).geom
FROM raw_geom.kale,raw_geom.zonas
WHERE zonas.zona='Kale'
RETURNING cd_plat
;

INSERT INTO main.platform(platform,zona_geom,plat_geom)
SELECT 'Platero',(ST_DUMP(zonas.wkb_geometry)).geom, (ST_DUMP(platero."Shape")).geom
FROM raw_geom.platero,raw_geom.zonas
WHERE zonas.zona='Platero'
RETURNING cd_plat
;

INSERT INTO main.platform(platform,zona_geom)
SELECT 'Caracterización', (ST_DUMP(zonas.wkb_geometry)).geom
FROM raw_geom.zonas
WHERE zonas.zona='Caracterizacion'
RETURNING cd_plat;
```

# 2 Herpetos

## 2.1 ANH

**NOTES**

1.  the same ANH has been associated with caracterización and one of the
    platform… I think the best thing to do is not to hardcode it and
    wait for extracting it from the spatial data
2.  I really doubt occurrenceID to be right for the event IDs in the
    DarwinCore format

``` sql
WITH a AS(
SELECT DISTINCT
  REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_Herp_T[0-9]_[DN](_TE2)?$','\1') anh_name,
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_Herp_T[0-9]_[DN](_TE2)?$','\1')::int num_anh,
  p.cd_plat
FROM raw_dwc.anfibios_event ae
LEFT JOIN main.platform p ON ae.measurement_value__plataforma_=p.platform
UNION
SELECT DISTINCT
  REGEXP_REPLACE(occurrence_id,'^(ANH_[0-9]{1,3})_Herp_T[0-9]_[DN](_TE2)?$','\1') anh_name,
  REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_Herp_T[0-9]_[DN](_TE2)?$','\1')::int num_anh,
  p.cd_plat
FROM raw_dwc.reptiles_event ae
LEFT JOIN main.platform p ON ae.measurement_value__plataforma_=p.platform
)
SELECT anh_name, num_anh, cd_plat
FROM a
ORDER BY num_anh
```

Insertar los datos de anh:

``` sql
INSERT INTO main.punto_referencia(name_pt_ref, num_anh)
WITH a AS(
SELECT DISTINCT
  REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_Herp_T[0-9]_[DN](_TE2)?$','\1') anh_name,
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_Herp_T[0-9]_[DN](_TE2)?$','\1')::int num_anh
FROM raw_dwc.anfibios_event ae
UNION
SELECT DISTINCT
  REGEXP_REPLACE(occurrence_id,'^(ANH_[0-9]{1,3})_Herp_T[0-9]_[DN](_TE2)?$','\1') anh_name,
  REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_Herp_T[0-9]_[DN](_TE2)?$','\1')::int num_anh
FROM raw_dwc.reptiles_event ae
)
SELECT anh_name, num_anh
FROM a
ORDER BY num_anh
RETURNING cd_pt_ref
```

dar las referencias en las tablas de herpetos

``` sql
ALTER TABLE raw_dwc.anfibios_event ADD COLUMN cd_pt_ref int REFERENCES main.punto_referencia(cd_pt_ref) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE raw_dwc.reptiles_event ADD COLUMN cd_pt_ref int REFERENCES main.punto_referencia(cd_pt_ref) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE raw_dwc.anfibios_registros ADD COLUMN cd_pt_ref int REFERENCES main.punto_referencia(cd_pt_ref) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE raw_dwc.reptiles_registros ADD COLUMN cd_pt_ref int REFERENCES main.punto_referencia(cd_pt_ref) ON DELETE SET NULL ON UPDATE CASCADE;

UPDATE raw_dwc.anfibios_event
SET cd_pt_ref=pr.cd_pt_ref
FROM main.punto_referencia pr
WHERE REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_Herp_T[0-9]_[DN](_TE2)?$','\1')=pr.name_pt_ref
;

UPDATE raw_dwc.reptiles_event
SET cd_pt_ref=pr.cd_pt_ref
FROM main.punto_referencia pr
WHERE REGEXP_REPLACE(occurrence_id,'^(ANH_[0-9]{1,3})_Herp_T[0-9]_[DN](_TE2)?$','\1')=pr.name_pt_ref
;

UPDATE raw_dwc.anfibios_registros
SET cd_pt_ref=pr.cd_pt_ref
FROM main.punto_referencia pr
WHERE REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_Herp_T[0-9]_[DN](_TE2)?$','\1')=pr.name_pt_ref
;

UPDATE raw_dwc.reptiles_registros
SET cd_pt_ref=pr.cd_pt_ref
FROM main.punto_referencia pr
WHERE REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_Herp_T[0-9]_[DN](_TE2)?$','\1')=pr.name_pt_ref
;

SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

Averiguando que ninguna fila no tenga anh

``` sql
SELECT * FROM raw_dwc.anfibios_event WHERE cd_pt_ref IS NULL;
```

<div class="knitsql-table">

|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| row.names event_id parent_event_id sample_size_value sample_size_unit sampling_protocol sampling_effort event_date event_time habitat event_remarks continent country country_code state_province county locality minimum_elevation_in_meters maximum_elevation_in_meters verbatim_latitude verbatim_longitude verbatim_coordinate_system verbatim_srs decimal_latitude decimal_longitude geodetic_datum coordinate_uncertainty_in_meters institution_code title type format creator created measurement_type\_*coordenadas_intermedia* measurement_value_coordenadas_intermedia\_ measurement_type\_*coordenadas_final* measurement_value_coordenadasfinal\_ measurement_type\_*plataforma* measurement_value\_*plataforma* measurement_type\_*distancia* measurement_value\_*distancia* measurement_unit\_*distancia* cd_pt_ref |

------------------------------------------------------------------------

: 0 records

</div>

``` sql
SELECT * FROM raw_dwc.anfibios_registros WHERE cd_pt_ref IS NULL;
```

<div class="knitsql-table">

|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| row.names occurrence_id event_id basis_of_record type institution_code collection_code catalog_number dynamic_properties occurrence_remarks record_number recorded_by organism_id organism_quantity organism_quantity_type sex life_stage behavior other_catalog_numbers title type_1 format creator created preparations event_time measurement_type\_*tipo_de_registro* measurement_value\_*tipo_de_registro* event_remarks identified_by date_identified scientific_name kingdom phylum class order family genus specific_epithet taxon_rank scientific_name_authorship title_1 type_2 format_1 creator_1 created_1 tipo_de_tejido preparación_del_tejido colector_del_tejido código_del_tejido measurement_type\_*longitud_rostro_cloaca* measurement_value\_*longitud_rostro_cloaca* measurement_unit\_*longitud_rostro_cloaca* measurement_type\_*longitud_cola* measurement_value\_*longitud_cola* measurement_unit\_*longitud_cola* measurement_type\_*peso* measurement_value\_*peso* measurement_unit\_*peso* cd_pt_ref |

------------------------------------------------------------------------

: 0 records

</div>

``` sql
SELECT * FROM raw_dwc.reptiles_event WHERE cd_pt_ref IS NULL;
```

<div class="knitsql-table">

|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| row.names occurrence_id basis_of_record sampling_size_value sampling_size_unit sampling_protocol sampling_effort event_date event_time habitat event_remarks continent country country_code state_province county locality minimum_elevation_in_meters maximum_elevation_in_meters verbatim_latitude verbatim_longitude verbatim_coordinate_system verbatim_srs decimal_latitude decimal_longitude geodetic_datum coordinate_uncertainty_in_meters identified_by title type format creator created measurement_type\_*coordenadas_intermedia* measurement_value\_*coordenadas_intermedia* measurement_type\_*coordenadas_final* measurement_value\_*coordenadas_final* measurement_type\_*plataforma* measurement_value\_*plataforma* measurement_type\_*distancia* measurement_value\_*distancia* measurement_unit\_*distancia* cd_pt_ref |

------------------------------------------------------------------------

: 0 records

</div>

``` sql
SELECT * FROM raw_dwc.reptiles_registros WHERE cd_pt_ref IS NULL;
```

<div class="knitsql-table">

|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| row.names occurrence_id event_id basis_of_record type institution_code collection_code catalog_number dynamic_properties occurrence_remarks record_number recorded_by organism_id organism_quantity organism_quantity_type sex life_stage behavior preparations event_time measurement_type\_*tipo_de_registro* measurement_value\_*tipo_de_registro* event_remarks identified_by date_identified scientific_name kingdom phylum class order family genus specific_epithet taxon_rank scientific_name_authorship title type_1 format creator created tipo_de_tejido preparación_del_tejido colector_del_tejido código_del_tejido measurement_type\_*longitud_rostro_cloaca* measurement_value\_*longitud_rostro_cloaca* measurement_unit\_*longitud_rostro_cloaca* measurement_type\_*longitud_cola* measurement_value\_*longitud_cola* measurement_unit\_*longitud_cola* measurement_type\_*peso* measurement_value\_*peso* measurement_unit\_*peso* cd_pt_ref |

------------------------------------------------------------------------

: 0 records

</div>

## 2.2 Unit, sampling efforts definition, abundance definition, protocolo

``` sql
INSERT INTO main.def_unit(cd_measurement_type, unit, unit_spa, abbv_unit,factor)
VALUES(
  (SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='distance'),
  'Meter',
  'Metros',
  'm',
  1
  ),
  (
  (SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='number of individuals'),
  'Number of individuals',
  'Número de individuos',
  'ind',
  1
  ),
  (
  (SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='time'),
  'Minutes',
  'Minutos',
  'min',
  1
  )
  
RETURNING cd_unit,unit;
```

``` sql
INSERT INTO main.def_var_samp_eff(var_samp_eff, var_samp_eff_spa, cd_unit,type_variable)
VALUES(
  'Covered distance',
  'Distancia recorrida',
  (SELECT cd_unit FROM main.def_unit WHERE cd_measurement_type=(SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='distance') AND unit='Meter'),
  'double precision'
  ),(
  'Elapsed time',
  'Duración',
  (SELECT cd_unit FROM main.def_unit WHERE cd_measurement_type=(SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='time') AND unit='Minutes'),
  'double precision'
  )
RETURNING cd_var_samp_eff, var_samp_eff ;
```

``` sql
INSERT INTO main.def_var_ind_qt(var_qt_ind, var_qt_ind_spa, cd_unit, type_variable)
VALUES(
  'Number of individuals',
  'Número de individuos',
  (SELECT cd_unit FROM main.def_unit WHERE cd_measurement_type=(SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='number of individuals') AND unit='Number of individuals'),
  'int'
)
RETURNING cd_var_ind_qt,var_qt_ind
;
```

``` sql
INSERT INTO main.def_protocol(protocol,protocol_spa,cd_var_samp_eff_1,cd_var_samp_eff_2,samp_eff_1_implicit,samp_eff_2_implicit,cd_var_ind_qt,description_spa)
VALUES(
  'Visual encounter survey',
  'Búsqueda por encuentros visuales',
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Covered distance'),
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Elapsed time'),
  false,
  true,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind='Number of individuals'),
  'Búsqueda por encuentros visuales (VES)'
)
RETURNING cd_protocol,protocol,protocol_spa;
```

## 2.3 Personas

``` sql
INSERT INTO main.people(verbatim_person)
WITH a AS(
SELECT DISTINCT INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(recorded_by, ' | ')))) AS name_person
FROM raw_dwc.anfibios_registros
UNION
SELECT DISTINCT INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(identified_by, ' | '))))
FROM raw_dwc.anfibios_registros
UNION
SELECT DISTINCT INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(recorded_by, ' | '))))
FROM raw_dwc.reptiles_registros
UNION
SELECT DISTINCT INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(identified_by, ' | '))))
FROM raw_dwc.reptiles_registros
)
SELECT DISTINCT name_person
FROM a 
ORDER BY name_person
RETURNING cd_person, verbatim_person
```

Dar los codigos a las tables de origen:

``` sql
ALTER TABLE raw_dwc.anfibios_registros ADD COLUMN cds_recorded_by int[];
WITH a AS(
SELECT "row.names", INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(recorded_by, ' | ')))) AS name_person
FROM raw_dwc.anfibios_registros
),b AS(
SELECT "row.names", ARRAY_AGG(cd_person) cds
FROM a 
LEFT JOIN main.people p ON a.name_person=p.verbatim_person
GROUP BY "row.names"
)
UPDATE raw_dwc.anfibios_registros AS r
SET cds_recorded_by=b.cds
FROM b
WHERE r."row.names"=b."row.names"
RETURNING r."row.names", cds_recorded_by
;
ALTER TABLE raw_dwc.anfibios_registros ADD COLUMN cds_identified_by int[];
WITH a AS(
SELECT "row.names", INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(identified_by, ' | ')))) AS name_person
FROM raw_dwc.anfibios_registros
),b AS(
SELECT "row.names", ARRAY_AGG(cd_person) cds
FROM a 
LEFT JOIN main.people p ON a.name_person=p.verbatim_person
GROUP BY "row.names"
)
UPDATE raw_dwc.anfibios_registros AS r
SET cds_identified_by=b.cds
FROM b
WHERE r."row.names"=b."row.names"
RETURNING r."row.names", cds_identified_by
;
ALTER TABLE raw_dwc.reptiles_registros ADD COLUMN cds_recorded_by int[];
WITH a AS(
SELECT "row.names", INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(recorded_by, ' | ')))) AS name_person
FROM raw_dwc.reptiles_registros
),b AS(
SELECT "row.names", ARRAY_AGG(cd_person) cds
FROM a 
LEFT JOIN main.people p ON a.name_person=p.verbatim_person
GROUP BY "row.names"
)
UPDATE raw_dwc.reptiles_registros AS r
SET cds_recorded_by=b.cds
FROM b
WHERE r."row.names"=b."row.names"
RETURNING r."row.names", cds_recorded_by
;
ALTER TABLE raw_dwc.reptiles_registros ADD COLUMN cds_identified_by int[];
WITH a AS(
SELECT "row.names", INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(identified_by, ' | ')))) AS name_person
FROM raw_dwc.reptiles_registros
),b AS(
SELECT "row.names", ARRAY_AGG(cd_person) cds
FROM a 
LEFT JOIN main.people p ON a.name_person=p.verbatim_person
GROUP BY "row.names"
)
UPDATE raw_dwc.reptiles_registros AS r
SET cds_identified_by=b.cds
FROM b
WHERE r."row.names"=b."row.names"
RETURNING r."row.names", cds_identified_by
;
SELECT 1;
```

<div class="knitsql-table">

| ?column? |
|---------:|
|        1 |

1 records

</div>

## 2.4 gp_event

**NOTE**:

1.  en algunos casos hay 3 fechas para un solo ANH, yo pensaba encontrar
    solo 2 fechas: error de fecha, o un plan de muestreo particular?
2.  la otra solución podría ser agrupar por ANH+año (solución que voy a
    adoptar por ahora) pero… averiguar!
3.  Algunas asociaciones año + anh solo corresponden a 4 eventos en
    anfibios
4.  Algunos ANH no tienen datos en 2022
5.  problemas de SRID?

``` sql
WITH a AS(
SELECT cd_pt_ref, name_pt_ref, TO_DATE(event_date,'YYYY-MM-DD'), ROW_NUMBER() OVER (PARTITION BY cd_pt_ref  ORDER BY TO_DATE(event_date,'YYYY-MM-DD')) num_gp, count(*)
FROM raw_dwc.anfibios_event
JOIN main.punto_referencia USING (cd_pt_ref)
GROUP BY cd_pt_ref, name_pt_ref, TO_DATE(event_date,'YYYY-MM-DD')
ORDER BY cd_pt_ref, TO_DATE(event_date,'YYYY-MM-DD')
)
SELECT * 
FROM a
WHERE cd_pt_ref IN (SELECT cd_pt_ref FROM a WHERE num_gp=3)
;
```

<div class="knitsql-table">

| cd_pt_ref | name_pt_ref | to_date    | num_gp | count |
|----------:|:------------|:-----------|-------:|------:|
|        17 | ANH_157     | 2021-07-12 |      1 |     4 |
|        17 | ANH_157     | 2021-08-04 |      2 |     2 |
|        17 | ANH_157     | 2022-04-08 |      3 |     6 |
|        22 | ANH_163     | 2021-07-14 |      1 |     4 |
|        22 | ANH_163     | 2021-07-25 |      2 |     2 |
|        22 | ANH_163     | 2022-04-07 |      3 |     6 |
|        24 | ANH_165     | 2021-07-15 |      1 |     4 |
|        24 | ANH_165     | 2021-08-04 |      2 |     2 |
|        24 | ANH_165     | 2022-04-04 |      3 |     6 |
|        26 | ANH_167     | 2021-07-14 |      1 |     4 |
|        26 | ANH_167     | 2021-07-25 |      2 |     2 |
|        26 | ANH_167     | 2022-03-29 |      3 |     6 |

12 records

</div>

``` sql
--WITH a AS(
SELECT cd_pt_ref, name_pt_ref, EXTRACT(isoyear FROM TO_DATE(event_date,'YYYY-MM-DD')), ROW_NUMBER() OVER (PARTITION BY cd_pt_ref  ORDER BY EXTRACT(isoyear FROM TO_DATE(event_date,'YYYY-MM-DD'))) num_gp, count(*)
FROM raw_dwc.anfibios_event
JOIN main.punto_referencia USING (cd_pt_ref)
GROUP BY cd_pt_ref, name_pt_ref, EXTRACT(isoyear FROM TO_DATE(event_date,'YYYY-MM-DD'))
ORDER BY cd_pt_ref, EXTRACT(isoyear FROM TO_DATE(event_date,'YYYY-MM-DD'))
--)
;
```

<div class="knitsql-table">

| cd_pt_ref | name_pt_ref | date_part | num_gp | count |
|----------:|:------------|----------:|-------:|------:|
|         1 | ANH_82      |      2021 |      1 |     6 |
|         1 | ANH_82      |      2022 |      2 |     6 |
|         2 | ANH_100     |      2021 |      1 |     6 |
|         2 | ANH_100     |      2022 |      2 |     6 |
|         3 | ANH_109     |      2021 |      1 |     6 |
|         3 | ANH_109     |      2022 |      2 |     6 |
|         4 | ANH_117     |      2021 |      1 |     6 |
|         4 | ANH_117     |      2022 |      2 |     6 |
|         5 | ANH_133     |      2021 |      1 |     6 |
|         5 | ANH_133     |      2022 |      2 |     6 |
|         6 | ANH_135     |      2022 |      1 |     6 |
|         7 | ANH_136     |      2021 |      1 |     6 |
|         7 | ANH_136     |      2022 |      2 |     6 |
|         8 | ANH_141     |      2021 |      1 |     6 |
|         8 | ANH_141     |      2022 |      2 |     6 |
|         9 | ANH_148     |      2021 |      1 |     6 |
|         9 | ANH_148     |      2022 |      2 |     6 |
|        10 | ANH_149     |      2021 |      1 |     6 |
|        10 | ANH_149     |      2022 |      2 |     6 |
|        11 | ANH_150     |      2021 |      1 |     6 |
|        11 | ANH_150     |      2022 |      2 |     6 |
|        12 | ANH_151     |      2021 |      1 |     6 |
|        12 | ANH_151     |      2022 |      2 |     6 |
|        13 | ANH_152     |      2021 |      1 |     6 |
|        13 | ANH_152     |      2022 |      2 |     6 |
|        14 | ANH_153     |      2021 |      1 |     4 |
|        14 | ANH_153     |      2022 |      2 |     6 |
|        15 | ANH_154     |      2021 |      1 |     6 |
|        15 | ANH_154     |      2022 |      2 |     6 |
|        16 | ANH_155     |      2021 |      1 |     4 |
|        16 | ANH_155     |      2022 |      2 |     6 |
|        17 | ANH_157     |      2021 |      1 |     6 |
|        17 | ANH_157     |      2022 |      2 |     6 |
|        18 | ANH_158     |      2021 |      1 |     6 |
|        18 | ANH_158     |      2022 |      2 |     6 |
|        19 | ANH_159     |      2021 |      1 |     6 |
|        19 | ANH_159     |      2022 |      2 |     6 |
|        20 | ANH_160     |      2021 |      1 |     6 |
|        20 | ANH_160     |      2022 |      2 |     6 |
|        21 | ANH_162     |      2021 |      1 |     6 |
|        21 | ANH_162     |      2022 |      2 |     6 |
|        22 | ANH_163     |      2021 |      1 |     6 |
|        22 | ANH_163     |      2022 |      2 |     6 |
|        23 | ANH_164     |      2021 |      1 |     6 |
|        23 | ANH_164     |      2022 |      2 |     6 |
|        24 | ANH_165     |      2021 |      1 |     6 |
|        24 | ANH_165     |      2022 |      2 |     6 |
|        25 | ANH_166     |      2021 |      1 |     6 |
|        25 | ANH_166     |      2022 |      2 |     6 |
|        26 | ANH_167     |      2021 |      1 |     6 |
|        26 | ANH_167     |      2022 |      2 |     6 |
|        27 | ANH_168     |      2021 |      1 |     6 |
|        27 | ANH_168     |      2022 |      2 |     6 |
|        28 | ANH_169     |      2021 |      1 |     6 |
|        28 | ANH_169     |      2022 |      2 |     6 |
|        29 | ANH_171     |      2021 |      1 |     6 |
|        30 | ANH_178     |      2021 |      1 |     6 |
|        30 | ANH_178     |      2022 |      2 |     6 |
|        31 | ANH_179     |      2021 |      1 |     6 |
|        31 | ANH_179     |      2022 |      2 |     6 |
|        32 | ANH_180     |      2021 |      1 |     6 |
|        32 | ANH_180     |      2022 |      2 |     6 |
|        33 | ANH_181     |      2021 |      1 |     6 |
|        33 | ANH_181     |      2022 |      2 |     6 |
|        34 | ANH_182     |      2021 |      1 |     6 |
|        34 | ANH_182     |      2022 |      2 |     6 |
|        35 | ANH_185     |      2021 |      1 |     6 |
|        35 | ANH_185     |      2022 |      2 |     6 |
|        36 | ANH_223     |      2021 |      1 |     6 |
|        36 | ANH_223     |      2022 |      2 |     6 |
|        37 | ANH_232     |      2021 |      1 |     6 |
|        37 | ANH_232     |      2022 |      2 |     6 |
|        38 | ANH_306     |      2021 |      1 |     6 |
|        38 | ANH_306     |      2022 |      2 |     6 |
|        39 | ANH_360     |      2021 |      1 |     6 |
|        39 | ANH_360     |      2022 |      2 |     6 |
|        40 | ANH_374     |      2021 |      1 |     6 |
|        41 | ANH_375     |      2022 |      1 |     6 |
|        42 | ANH_398     |      2022 |      1 |     6 |

79 records

</div>

``` sql
WITH a AS(
SELECT cd_pt_ref, EXTRACT(isoyear FROM TO_DATE(event_date,'YYYY-MM-DD')) AS year
FROM raw_dwc.anfibios_event
UNION ALL
SELECT cd_pt_ref, EXTRACT(isoyear FROM TO_DATE(event_date,'YYYY-MM-DD')) AS year
FROM raw_dwc.reptiles_event
)
SELECT cd_pt_ref, name_pt_ref, year , ROW_NUMBER() OVER (PARTITION BY cd_pt_ref  ORDER BY year) num_gp, count(*)
FROM a 
JOIN main.punto_referencia USING (cd_pt_ref)
GROUP BY cd_pt_ref, name_pt_ref, year
ORDER BY cd_pt_ref, year
--)
;
```

<div class="knitsql-table">

| cd_pt_ref | name_pt_ref | year | num_gp | count |
|----------:|:------------|-----:|-------:|------:|
|         1 | ANH_82      | 2021 |      1 |    12 |
|         1 | ANH_82      | 2022 |      2 |    12 |
|         2 | ANH_100     | 2021 |      1 |    12 |
|         2 | ANH_100     | 2022 |      2 |    12 |
|         3 | ANH_109     | 2021 |      1 |    12 |
|         3 | ANH_109     | 2022 |      2 |    12 |
|         4 | ANH_117     | 2021 |      1 |    12 |
|         4 | ANH_117     | 2022 |      2 |    12 |
|         5 | ANH_133     | 2021 |      1 |    12 |
|         5 | ANH_133     | 2022 |      2 |    12 |
|         6 | ANH_135     | 2022 |      1 |    12 |
|         7 | ANH_136     | 2021 |      1 |    12 |
|         7 | ANH_136     | 2022 |      2 |    12 |
|         8 | ANH_141     | 2021 |      1 |    12 |
|         8 | ANH_141     | 2022 |      2 |    12 |
|         9 | ANH_148     | 2021 |      1 |    12 |
|         9 | ANH_148     | 2022 |      2 |    12 |
|        10 | ANH_149     | 2021 |      1 |    12 |
|        10 | ANH_149     | 2022 |      2 |    12 |
|        11 | ANH_150     | 2021 |      1 |    12 |
|        11 | ANH_150     | 2022 |      2 |    12 |
|        12 | ANH_151     | 2021 |      1 |    12 |
|        12 | ANH_151     | 2022 |      2 |    12 |
|        13 | ANH_152     | 2021 |      1 |    12 |
|        13 | ANH_152     | 2022 |      2 |    12 |
|        14 | ANH_153     | 2021 |      1 |     8 |
|        14 | ANH_153     | 2022 |      2 |    12 |
|        15 | ANH_154     | 2021 |      1 |    12 |
|        15 | ANH_154     | 2022 |      2 |    12 |
|        16 | ANH_155     | 2021 |      1 |     8 |
|        16 | ANH_155     | 2022 |      2 |    12 |
|        17 | ANH_157     | 2021 |      1 |    12 |
|        17 | ANH_157     | 2022 |      2 |    12 |
|        18 | ANH_158     | 2021 |      1 |    12 |
|        18 | ANH_158     | 2022 |      2 |    12 |
|        19 | ANH_159     | 2021 |      1 |    12 |
|        19 | ANH_159     | 2022 |      2 |    12 |
|        20 | ANH_160     | 2021 |      1 |    12 |
|        20 | ANH_160     | 2022 |      2 |    12 |
|        21 | ANH_162     | 2021 |      1 |    12 |
|        21 | ANH_162     | 2022 |      2 |    12 |
|        22 | ANH_163     | 2021 |      1 |    12 |
|        22 | ANH_163     | 2022 |      2 |    12 |
|        23 | ANH_164     | 2021 |      1 |    12 |
|        23 | ANH_164     | 2022 |      2 |    12 |
|        24 | ANH_165     | 2021 |      1 |    12 |
|        24 | ANH_165     | 2022 |      2 |    12 |
|        25 | ANH_166     | 2021 |      1 |    12 |
|        25 | ANH_166     | 2022 |      2 |    12 |
|        26 | ANH_167     | 2021 |      1 |    12 |
|        26 | ANH_167     | 2022 |      2 |    12 |
|        27 | ANH_168     | 2021 |      1 |    12 |
|        27 | ANH_168     | 2022 |      2 |    12 |
|        28 | ANH_169     | 2021 |      1 |    12 |
|        28 | ANH_169     | 2022 |      2 |    12 |
|        29 | ANH_171     | 2021 |      1 |    12 |
|        30 | ANH_178     | 2021 |      1 |    12 |
|        30 | ANH_178     | 2022 |      2 |    12 |
|        31 | ANH_179     | 2021 |      1 |    12 |
|        31 | ANH_179     | 2022 |      2 |    12 |
|        32 | ANH_180     | 2021 |      1 |    12 |
|        32 | ANH_180     | 2022 |      2 |    12 |
|        33 | ANH_181     | 2021 |      1 |    12 |
|        33 | ANH_181     | 2022 |      2 |    12 |
|        34 | ANH_182     | 2021 |      1 |    12 |
|        34 | ANH_182     | 2022 |      2 |    12 |
|        35 | ANH_185     | 2021 |      1 |    12 |
|        35 | ANH_185     | 2022 |      2 |    12 |
|        36 | ANH_223     | 2021 |      1 |    12 |
|        36 | ANH_223     | 2022 |      2 |    12 |
|        37 | ANH_232     | 2021 |      1 |    12 |
|        37 | ANH_232     | 2022 |      2 |    12 |
|        38 | ANH_306     | 2021 |      1 |    12 |
|        38 | ANH_306     | 2022 |      2 |    12 |
|        39 | ANH_360     | 2021 |      1 |    12 |
|        39 | ANH_360     | 2022 |      2 |    12 |
|        40 | ANH_374     | 2021 |      1 |    12 |
|        41 | ANH_375     | 2022 |      1 |    12 |
|        42 | ANH_398     | 2022 |      1 |    12 |

79 records

</div>

Insertar los grupos de eventos

``` sql
INSERT INTO main.gp_event(cd_gp_biol,cd_protocol,cd_pt_ref,campaign_nb)
WITH a AS(
SELECT cd_pt_ref, EXTRACT(isoyear FROM TO_DATE(event_date,'YYYY-MM-DD')) AS year
FROM raw_dwc.anfibios_event
UNION ALL
SELECT cd_pt_ref, EXTRACT(isoyear FROM TO_DATE(event_date,'YYYY-MM-DD')) AS year
FROM raw_dwc.reptiles_event
)
SELECT 'herp', (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Visual encounter survey'),cd_pt_ref, ROW_NUMBER() OVER (PARTITION BY cd_pt_ref  ORDER BY year) num_gp
FROM a 
JOIN main.punto_referencia USING (cd_pt_ref)
GROUP BY cd_pt_ref, name_pt_ref, year
ORDER BY cd_pt_ref, year
RETURNING cd_gp_event,cd_gp_biol,cd_protocol,cd_pt_ref,campaign_nb
;
```

Attributing the gp_event

``` sql
ALTER TABLE raw_dwc.anfibios_event ADD COLUMN cd_gp_event int REFERENCES main.gp_event(cd_gp_event) ON DELETE SET NULL;
ALTER TABLE raw_dwc.reptiles_event ADD COLUMN cd_gp_event int REFERENCES main.gp_event(cd_gp_event) ON DELETE SET NULL;

WITH a AS(
SELECT cd_pt_ref, EXTRACT(isoyear FROM TO_DATE(event_date,'YYYY-MM-DD')) AS year
FROM raw_dwc.anfibios_event
UNION ALL
SELECT cd_pt_ref, EXTRACT(isoyear FROM TO_DATE(event_date,'YYYY-MM-DD')) AS year
FROM raw_dwc.reptiles_event
),b AS(
SELECT cd_pt_ref, name_pt_ref, year , ROW_NUMBER() OVER (PARTITION BY cd_pt_ref  ORDER BY year) num_gp, count(*)
FROM a 
JOIN main.punto_referencia USING (cd_pt_ref)
GROUP BY cd_pt_ref, name_pt_ref, year
ORDER BY cd_pt_ref, year
), c AS(
SELECT "row.names",ge.cd_gp_event
FROM raw_dwc.anfibios_event e
LEFT JOIN b ON EXTRACT(isoyear FROM TO_DATE(event_date,'YYYY-MM-DD'))=year AND e.cd_pt_ref=b.cd_pt_ref
LEFT JOIN main.gp_event ge ON b.num_gp=ge.campaign_nb AND ge.cd_gp_biol='herp' AND cd_protocol= (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Visual encounter survey') AND ge.cd_pt_ref=e.cd_pt_ref
)
UPDATE raw_dwc.anfibios_event e
SET cd_gp_event=c.cd_gp_event
FROM c
WHERE c."row.names"=e."row.names"
;

WITH a AS(
SELECT cd_pt_ref, EXTRACT(isoyear FROM TO_DATE(event_date,'YYYY-MM-DD')) AS year
FROM raw_dwc.reptiles_event
UNION ALL
SELECT cd_pt_ref, EXTRACT(isoyear FROM TO_DATE(event_date,'YYYY-MM-DD')) AS year
FROM raw_dwc.reptiles_event
),b AS(
SELECT cd_pt_ref, name_pt_ref, year , ROW_NUMBER() OVER (PARTITION BY cd_pt_ref  ORDER BY year) num_gp, count(*)
FROM a 
JOIN main.punto_referencia USING (cd_pt_ref)
GROUP BY cd_pt_ref, name_pt_ref, year
ORDER BY cd_pt_ref, year
), c AS(
SELECT "row.names",ge.cd_gp_event
FROM raw_dwc.reptiles_event e
LEFT JOIN b ON EXTRACT(isoyear FROM TO_DATE(event_date,'YYYY-MM-DD'))=year AND e.cd_pt_ref=b.cd_pt_ref
LEFT JOIN main.gp_event ge ON b.num_gp=ge.campaign_nb AND ge.cd_gp_biol='herp' AND cd_protocol= (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Visual encounter survey') AND ge.cd_pt_ref=e.cd_pt_ref
)
UPDATE raw_dwc.reptiles_event e
SET cd_gp_event=c.cd_gp_event
FROM c
WHERE c."row.names"=e."row.names"
;
SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

## 2.5 event

1.  pb de formatos en las coordenadas intermedias: puntos intempestivos
2.  pb de formato en las horas: espacios raros antes de los segundos
3.  errores de coordenadas sobre los eventos siguientes

``` sql
WITH a AS(
SELECT cd_gp_event,
  event_id, 
  TO_DATE(event_date, 'YYYY-MM-DD') date,
  REGEXP_REPLACE(SPLIT_PART(event_time,'/',1),'\s+','','g') hora_1,
  REGEXP_REPLACE(SPLIT_PART(event_time,'/',2),'\s+','','g') hora_2,
  sample_size_value,
  event_remarks,
  decimal_latitude::double precision pt1_lat,
  decimal_longitude::double precision pt1_long,
  REGEXP_REPLACE(SPLIT_PART(measurement_value_coordenadas_intermedia_,',',1),'[ .]$','')::double precision pt2_lat,
  SPLIT_PART(measurement_value_coordenadas_intermedia_,',',2)::double precision pt2_long,
  SPLIT_PART(measurement_value_coordenadasfinal_,',',1)::double precision pt3_lat,
  SPLIT_PART(measurement_value_coordenadasfinal_,',',2)::double precision pt3_long
FROM raw_dwc.anfibios_event
UNION
SELECT cd_gp_event,
  occurrence_id, 
  TO_DATE(event_date, 'YYYY-MM-DD') date,
  REGEXP_REPLACE(SPLIT_PART(event_time,'/',1),'\s+','','g') hora_1,
  REGEXP_REPLACE(SPLIT_PART(event_time,'/',2),'\s+','','g') hora_2,
  sampling_size_value,
  event_remarks,
  decimal_latitude::double precision pt1_lat,
  decimal_longitude::double precision pt1_long,
  REGEXP_REPLACE(SPLIT_PART(measurement_value__coordenadas_intermedia_,',',1),'[ .]$','')::double precision pt2_lat,
  SPLIT_PART(measurement_value__coordenadas_intermedia_,',',2)::double precision pt2_long,
  SPLIT_PART(measurement_value__coordenadas_final_,',',1)::double precision pt3_lat,
  SPLIT_PART(measurement_value__coordenadas_final_,',',2)::double precision pt3_long
FROM raw_dwc.reptiles_event
),b AS(
SELECT
  cd_gp_event, event_id,
  REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_Herp_T([0-9])_([DN])(_TE2)?$','\2')::int transect,
  REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_Herp_(T[0-9])_([DN])(_TE2)?$','\3') jornada,
  CASE 
    WHEN REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_Herp_(T[0-9])_([DN])(_TE2)?$','\4') ='' THEN 1
    ELSE 2
  END campaign,
  ROW_NUMBER() OVER (PARTITION BY cd_gp_event ORDER BY cd_gp_event,REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_Herp_T([0-9])_([DN])(_TE2)?$','\2')::int,REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_Herp_(T[0-9])_([DN])(_TE2)?$','\3')  ) num_replicate,
  'Transect:'||REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_Herp_T([0-9])_([DN])(_TE2)?$','\2')||'|Jornada:'||REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_Herp_(T[0-9])_([DN])(_TE2)?$','\3')||'|Campaign:'||CASE WHEN REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_Herp_(T[0-9])_([DN])(_TE2)?$','\4') ='' THEN 1 ELSE 2 END name_replicate,
  ARRAY_AGG(DISTINCT (date||' '||hora_1)::timestamp) date_time_begin,
  ARRAY_AGG(DISTINCT (date||' '||hora_2)::timestamp) date_time_end,
  ARRAY_AGG(DISTINCT sample_size_value) samp_effort_1,
  ARRAY_AGG(DISTINCT event_remarks) event_remarks,
  ARRAY_AGG(DISTINCT pt1_lat) a_pt1_lat,
  ARRAY_AGG(DISTINCT pt1_long) a_pt1_long,
  ARRAY_AGG(DISTINCT pt2_lat) a_pt2_lat,
  ARRAY_AGG(DISTINCT pt2_long) a_pt2_long,
  ARRAY_AGG(DISTINCT pt3_lat) a_pt3_lat,
  ARRAY_AGG(DISTINCT pt3_long) a_pt3_long

FROM a
GROUP BY cd_gp_event,event_id, transect, jornada
)
SELECT cd_gp_event, event_id,
a_pt1_lat,
a_pt1_long,
a_pt2_lat,
a_pt2_long,
a_pt3_lat,
a_pt3_long
FROM b 
WHERE 
 ARRAY_LENGTH(a_pt1_lat,1)>1
 OR ARRAY_LENGTH(a_pt1_long,1)>1
 OR ARRAY_LENGTH(a_pt1_lat,1)>1
 OR ARRAY_LENGTH(a_pt1_long,1)>1
 OR ARRAY_LENGTH(a_pt1_lat,1)>1
 OR ARRAY_LENGTH(a_pt1_long,1)>1

;
```

<div class="knitsql-table">

|                                                                                     |
|:-----------------------------------------------------------------------------------:|
| cd_gp_event event_id a_pt1_lat a_pt1_long a_pt2_lat a_pt2_long a_pt3_lat a_pt3_long |

------------------------------------------------------------------------

: 0 records

</div>

Voy a tomar los primeros valores por ahora:

Primero solo los datos obligatorios:

``` sql
INSERT INTO main.event(cd_gp_event, event_id, num_replicate, description_replicate, date_time_begin, date_time_end, samp_effort_1,event_remarks)
WITH a AS(
SELECT cd_gp_event,
  event_id, 
  TO_DATE(event_date, 'YYYY-MM-DD') date,
  REGEXP_REPLACE(SPLIT_PART(event_time,'/',1),'\s+','','g') hora_1,
  REGEXP_REPLACE(SPLIT_PART(event_time,'/',2),'\s+','','g') hora_2,
  sample_size_value,
  event_remarks,
  decimal_latitude::double precision pt1_lat,
  decimal_longitude::double precision pt1_long,
  REGEXP_REPLACE(SPLIT_PART(measurement_value_coordenadas_intermedia_,',',1),'[ .]$','')::double precision pt2_lat,
  SPLIT_PART(measurement_value_coordenadas_intermedia_,',',2)::double precision pt2_long,
  SPLIT_PART(measurement_value_coordenadasfinal_,',',1)::double precision pt3_lat,
  SPLIT_PART(measurement_value_coordenadasfinal_,',',2)::double precision pt3_long
FROM raw_dwc.anfibios_event
UNION
SELECT cd_gp_event,
  occurrence_id, 
  TO_DATE(event_date, 'YYYY-MM-DD') date,
  REGEXP_REPLACE(SPLIT_PART(event_time,'/',1),'\s+','','g') hora_1,
  REGEXP_REPLACE(SPLIT_PART(event_time,'/',2),'\s+','','g') hora_2,
  sampling_size_value,
  event_remarks,
  decimal_latitude::double precision pt1_lat,
  decimal_longitude::double precision pt1_long,
  REGEXP_REPLACE(SPLIT_PART(measurement_value__coordenadas_intermedia_,',',1),'[ .]$','')::double precision pt2_lat,
  SPLIT_PART(measurement_value__coordenadas_intermedia_,',',2)::double precision pt2_long,
  SPLIT_PART(measurement_value__coordenadas_final_,',',1)::double precision pt3_lat,
  SPLIT_PART(measurement_value__coordenadas_final_,',',2)::double precision pt3_long
FROM raw_dwc.reptiles_event
), b AS(
SELECT
  cd_gp_event, event_id,
  REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_Herp_T([0-9])_([DN])(_TE2)?$','\2')::int transect,
  REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_Herp_(T[0-9])_([DN])(_TE2)?$','\3') jornada,
  CASE 
    WHEN REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_Herp_(T[0-9])_([DN])(_TE2)?$','\4') ='' THEN 1
    ELSE 2
  END campaign,
  ROW_NUMBER() OVER (PARTITION BY cd_gp_event ORDER BY cd_gp_event,REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_Herp_T([0-9])_([DN])(_TE2)?$','\2')::int,REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_Herp_(T[0-9])_([DN])(_TE2)?$','\3')  ) num_replicate,
  'Transect:'||REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_Herp_T([0-9])_([DN])(_TE2)?$','\2')||'|Jornada:'||REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_Herp_(T[0-9])_([DN])(_TE2)?$','\3')||'|Campaign:'||CASE WHEN REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_Herp_(T[0-9])_([DN])(_TE2)?$','\4') ='' THEN 1 ELSE 2 END description_replicate,
  (date||' '||hora_1)::timestamp date_time_begin,
  (date||' '||hora_2)::timestamp date_time_end,
  sample_size_value samp_effort_1,
  STRING_AGG(DISTINCT event_remarks, ' || ') event_remarks
FROM a
GROUP BY cd_gp_event,event_id, transect,jornada,campaign, description_replicate, date_time_begin, date_time_end, samp_effort_1
ORDER BY cd_gp_event, num_replicate
)
SELECT cd_gp_event, event_id, num_replicate, description_replicate, date_time_begin, date_time_end, samp_effort_1,event_remarks
FROM b
RETURNING  cd_gp_event, event_id, num_replicate, description_replicate
```

Ahora agregamos la información espacial:

``` sql
WITH a AS(
SELECT event_id,
  decimal_latitude::double precision pt1_lat,
  decimal_longitude::double precision pt1_long,
  REGEXP_REPLACE(SPLIT_PART(measurement_value_coordenadas_intermedia_,',',1),'[ .]$','')::double precision pt2_lat,
  SPLIT_PART(measurement_value_coordenadas_intermedia_,',',2)::double precision pt2_long,
  SPLIT_PART(measurement_value_coordenadasfinal_,',',1)::double precision pt3_lat,
  SPLIT_PART(measurement_value_coordenadasfinal_,',',2)::double precision pt3_long
FROM raw_dwc.anfibios_event
UNION ALL
SELECT occurrence_id,
  decimal_latitude::double precision pt1_lat,
  decimal_longitude::double precision pt1_long,
  REGEXP_REPLACE(SPLIT_PART(measurement_value__coordenadas_intermedia_,',',1),'[ .]$','')::double precision pt2_lat,
  SPLIT_PART(measurement_value__coordenadas_intermedia_,',',2)::double precision pt2_long,
  SPLIT_PART(measurement_value__coordenadas_final_,',',1)::double precision pt3_lat,
  SPLIT_PART(measurement_value__coordenadas_final_,',',2)::double precision pt3_long
FROM raw_dwc.reptiles_event
), b AS(
SELECT a.event_id,
  pt1_lat,pt1_long,
  pt2_lat,pt2_long,
  pt3_lat,pt3_long,
  ROW_NUMBER() OVER (PARTITION BY a.event_id) repet
FROM a
GROUP BY  a.event_id,
  pt1_lat,pt1_long,
  pt2_lat,pt2_long,
  pt3_lat,pt3_long
), c AS(
SELECT 
 event_id,
 ST_SetSRID(ST_transform(
   ST_MakeLine(ARRAY[
     ST_SetSRID(ST_MakePoint(pt1_long,pt1_lat),4326),
     ST_SetSRID(ST_MakePoint(pt2_long,pt2_lat),4326),
     ST_SetSRID(ST_MakePoint(pt3_long,pt3_lat),4326)
   ])
 , (SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)),3116) lines
FROM b
WHERE repet=1
)
UPDATE main.event AS e
SET li_geom=c.lines
FROM c
WHERE e.event_id=c.event_id
RETURNING e.event_id
;
SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

Damos los cd_event a todos las filas:

``` sql
ALTER TABLE raw_dwc.anfibios_event ADD COLUMN cd_event int REFERENCES main.event(cd_event) ON DELETE SET NULL;
ALTER TABLE raw_dwc.anfibios_registros ADD COLUMN cd_event int REFERENCES main.event(cd_event);
ALTER TABLE raw_dwc.reptiles_event ADD COLUMN cd_event int REFERENCES main.event(cd_event) ON DELETE SET NULL;
ALTER TABLE raw_dwc.reptiles_registros ADD COLUMN cd_event int REFERENCES main.event(cd_event) ON DELETE SET NULL;

UPDATE raw_dwc.anfibios_event AS t
SET cd_event=e.cd_event
FROM main.event e
WHERE t.event_id=e.event_id;

UPDATE raw_dwc.anfibios_registros AS t
SET cd_event=e.cd_event
FROM main.event e
WHERE t.event_id=e.event_id;

UPDATE raw_dwc.reptiles_event AS t
SET cd_event=e.cd_event
FROM main.event e
WHERE t.occurrence_id=e.event_id;

UPDATE raw_dwc.reptiles_registros AS t
SET cd_event=e.cd_event
FROM main.event e
WHERE t.event_id=e.event_id;

SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

## 2.6 registros

1.  problem in timestamps
2.  hay un taxon sin taxonomía resuelta
3.  En el caso de los anfibios y de los reptiles, los organism_id no son
    unicos (anotar que de todas formas, hay que utilizar organism_id que
    son diferentes porque comparten event_id) Mi consejo: utilizar
    +10.000 para reptiles
4.  Los occurrence_id no son unicos cuando mezclemos los reptiles y
    anfibios

``` sql
SELECT occurrence_id, count(*)
FROM (SELECT occurrence_id FROM raw_dwc.anfibios_registros UNION ALL SELECT occurrence_id FROM raw_dwc.reptiles_registros) a
GROUP BY occurrence_id
HAVING count(*)>1;
```

<div class="knitsql-table">

occurrence_id count ————— ——-

: 0 records

</div>

Anfibios

``` sql
SELECT organism_id, count(*)
FROM raw_dwc.anfibios_registros--(SELECT occurrence_id FROM raw_dwc.reptiles_registros UNION ALL SELECT occurrence_id FROM raw_dwc.reptiles_registros) a
GROUP BY organism_id
HAVING count(*)>1;
```

<div class="knitsql-table">

    organism_id   count

------------------------------------------------------------------------

: 0 records

</div>

reptiles

``` sql
SELECT organism_id, count(*)
FROM raw_dwc.reptiles_registros--(SELECT occurrence_id FROM raw_dwc.reptiles_registros UNION ALL SELECT occurrence_id FROM raw_dwc.reptiles_registros) a
GROUP BY organism_id
HAVING count(*)>1;
```

<div class="knitsql-table">

organism_id count ————- ——-

: 0 records

</div>

los dos

``` sql
SELECT organism_id::double precision::integer, count(*)
FROM (SELECT organism_id FROM raw_dwc.reptiles_registros UNION ALL SELECT organism_id FROM raw_dwc.reptiles_registros) a
GROUP BY organism_id
HAVING count(*)>1;
```

<div class="knitsql-table">

| organism_id | count |
|------------:|------:|
|        2368 |     2 |
|        2296 |     2 |
|        2723 |     2 |
|        2869 |     2 |
|        2876 |     2 |
|        2837 |     2 |
|        2471 |     2 |
|        2820 |     2 |
|        2721 |     2 |
|        2665 |     2 |
|        2888 |     2 |
|        2793 |     2 |
|        3057 |     2 |
|        3027 |     2 |
|        2819 |     2 |
|        3067 |     2 |
|        3086 |     2 |
|        3007 |     2 |
|        2591 |     2 |
|        2482 |     2 |
|        2487 |     2 |
|        2961 |     2 |
|        2814 |     2 |
|        2273 |     2 |
|        2914 |     2 |
|        2840 |     2 |
|        2338 |     2 |
|        2673 |     2 |
|        3061 |     2 |
|        2490 |     2 |
|        2218 |     2 |
|        2736 |     2 |
|        3064 |     2 |
|        3041 |     2 |
|        2802 |     2 |
|        2402 |     2 |
|        2807 |     2 |
|        2660 |     2 |
|        2651 |     2 |
|        2555 |     2 |
|        2546 |     2 |
|        2831 |     2 |
|        2416 |     2 |
|        2700 |     2 |
|        2623 |     2 |
|        2565 |     2 |
|        2261 |     2 |
|        2486 |     2 |
|        2383 |     2 |
|        2999 |     2 |
|        2432 |     2 |
|        2791 |     2 |
|        2962 |     2 |
|        2467 |     2 |
|        2818 |     2 |
|        2901 |     2 |
|        2390 |     2 |
|        2443 |     2 |
|        2539 |     2 |
|        2292 |     2 |
|        2679 |     2 |
|        2502 |     2 |
|        3119 |     2 |
|        3116 |     2 |
|        3015 |     2 |
|        2215 |     2 |
|        2643 |     2 |
|        2594 |     2 |
|        2571 |     2 |
|        2349 |     2 |
|        2289 |     2 |
|        3054 |     2 |
|        2248 |     2 |
|        2880 |     2 |
|        2725 |     2 |
|        2585 |     2 |
|        3039 |     2 |
|        3104 |     2 |
|        2732 |     2 |
|        2284 |     2 |
|        2806 |     2 |
|        2500 |     2 |
|        2275 |     2 |
|        2394 |     2 |
|        2499 |     2 |
|        3111 |     2 |
|        2667 |     2 |
|        2305 |     2 |
|        2728 |     2 |
|        2928 |     2 |
|        2658 |     2 |
|        3034 |     2 |
|        2775 |     2 |
|        2255 |     2 |
|        3102 |     2 |
|        2903 |     2 |
|        2803 |     2 |
|        2609 |     2 |
|        2397 |     2 |
|        2636 |     2 |

Displaying records 1 - 100

</div>

``` sql
/*
---TO SUPPRESS LATER
WITH a AS
(
SELECT "row.names", ROW_NUMBER() OVER (ORDER BY cd_event,event_time) nb
FROM raw_dwc.anfibios_registros
)
UPDATE raw_dwc.anfibios_registros AS r
SET organism_id=a.nb
FROM a
WHERE a."row.names"=r."row.names";
---
*/

INSERT INTO main.registros(cd_event, cds_recorded_by, date_time, cd_tax, cd_morfo, cds_identified_by, qt_int,remarks, occurrence_id, organism_id)
SELECT 
 cd_event,
 cds_recorded_by,
 (e.date_time_begin::date||' '||event_time)::timestamp date_time,
 tt.cd_tax,
 tt.cd_morfo,
 cds_identified_by,
 organism_quantity::double precision::int qt_int,
 r.event_remarks,
 occurrence_id,
 organism_id::text
FROM raw_dwc.anfibios_registros r
LEFT JOIN raw_dwc.taxonomy_total tt ON tt."row.names"=r."row.names" AND tt.table_orig='anfibios_registros'
LEFT JOIN main.event e USING (cd_event)
ORDER BY cd_event, date_time;
SELECT true;
```

Atribuir los cd_reg

Tenemos que tener una solución para separar los taxones de reptiles y
anfibios

``` sql
WITH a AS(
SELECT DISTINCT find_higher_id(cd_tax,'OR') cd_or
FROM main.registros
)
SELECT name_tax
FROM a
LEFT JOIN main.taxo t ON a.cd_or=t.cd_tax
```

<div class="knitsql-table">

| name_tax |
|:---------|
| Anura    |
| Caudata  |

2 records

</div>

``` sql
ALTER TABLE raw_dwc.anfibios_registros ADD COLUMN cd_reg int REFERENCES main.registros(cd_reg);
UPDATE raw_dwc.anfibios_registros AS ar
SET cd_reg=r.cd_reg
FROM main.registros r
WHERE ar.cd_event=r.cd_event AND ar.organism_id::text=r.organism_id AND find_higher_id(r.cd_tax,'OR') IN (SELECT cd_tax FROM main.taxo WHERE name_tax IN ('Anura', 'Caudata'));

SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

``` sql

---TO SUPPRESS LATER
WITH a AS
(
SELECT "row.names", ROW_NUMBER() OVER (ORDER BY cd_event,event_time) + (SELECT max(cd_reg) FROM main.registros)nb
FROM raw_dwc.reptiles_registros
)
UPDATE raw_dwc.reptiles_registros AS r
SET organism_id=a.nb
FROM a
WHERE a."row.names"=r."row.names";
---


INSERT INTO main.registros(cd_event, cds_recorded_by, date_time, cd_tax, cd_morfo, cds_identified_by, qt_int,remarks, occurrence_id, organism_id)
SELECT 
 cd_event,
 cds_recorded_by,
 (e.date_time_begin::date||' '||event_time)::timestamp date_time,
 tt.cd_tax,
 tt.cd_morfo,
 cds_identified_by,
 organism_quantity::double precision::int qt_int,
 r.event_remarks,
 occurrence_id||'[reptiles]', -- NOTE TO MODIFY IN FUTURE
 organism_id::double precision::int::text
FROM raw_dwc.reptiles_registros r
LEFT JOIN raw_dwc.taxonomy_total tt ON tt."row.names"=r."row.names" AND tt.table_orig='reptiles_registros'
LEFT JOIN main.event e USING (cd_event)
ORDER BY cd_event, date_time;
SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

Atribuir los cd_reg

Tenemos que tener una solución para separar los taxones de reptiles y
reptiles

``` sql
WITH a AS(
SELECT DISTINCT find_higher_id(cd_tax,'OR') cd_or
FROM main.registros
)
SELECT name_tax
FROM a
LEFT JOIN main.taxo t ON a.cd_or=t.cd_tax
```

<div class="knitsql-table">

| name_tax   |
|:-----------|
| Squamata   |
| Anura      |
| Caudata    |
| Crocodylia |
| Testudines |

5 records

</div>

``` sql
ALTER TABLE raw_dwc.reptiles_registros ADD COLUMN cd_reg int REFERENCES main.registros(cd_reg);
UPDATE raw_dwc.reptiles_registros AS ar
SET cd_reg=r.cd_reg
FROM main.registros r
WHERE ar.cd_event=r.cd_event AND ar.organism_id::double precision::int::text=r.organism_id::text AND find_higher_id(r.cd_tax,'OR') NOT IN (SELECT cd_tax FROM main.taxo WHERE name_tax IN ('Anura', 'Caudata'));

SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

# 3 Atropellamientos

## 3.1 ANH

Los atropellamientas no está relacionados a ANH, pero CARAC y KAPLA
podrían codificarse como ANH tambien

``` sql
INSERT INTO main.punto_referencia(name_pt_ref)
VALUES
  ('Kapla'),('Carac')
RETURNING cd_pt_ref,name_pt_ref;
```

## 3.2 Unit, sampling efforts definition, abundance definition, protocolo

Las unidades y variable son las mismas (las distancias recorridas eran
en metros para los herpetos, y en km para atropellamientos, pero las voy
a guardar así por ahora)

``` sql
INSERT INTO main.def_protocol(protocol,protocol_spa,cd_var_samp_eff_1,cd_var_samp_eff_2,samp_eff_1_implicit,samp_eff_2_implicit,cd_var_ind_qt,description_spa)
VALUES(
  'Roadkill search',
  'Búsqueda de atropellamiento',
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Covered distance'),
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Elapsed time'),
  false,
  true,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind='Number of individuals'),
  'Búsqueda de atropellamientos'
)
RETURNING cd_protocol,protocol,protocol_spa;
```

## 3.3 Personas

``` sql
INSERT INTO main.people(verbatim_person)
WITH a AS(
SELECT DISTINCT INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(recorded_by, ' | ')))) AS name_person
FROM raw_dwc.atropellamientos_registros
UNION
SELECT DISTINCT INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(identified_by, ' | '))))
FROM raw_dwc.atropellamientos_registros
)
SELECT DISTINCT name_person
FROM a 
ORDER BY name_person
ON CONFLICT(verbatim_person) DO NOTHING
RETURNING cd_person, verbatim_person
```

Dar los codigos a las tables de origen:

``` sql
ALTER TABLE raw_dwc.atropellamientos_registros ADD COLUMN cds_recorded_by int[];
WITH a AS(
SELECT "row.names", INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(recorded_by, ' | ')))) AS name_person
FROM raw_dwc.atropellamientos_registros
),b AS(
SELECT "row.names", ARRAY_AGG(cd_person) cds
FROM a 
LEFT JOIN main.people p ON a.name_person=p.verbatim_person
GROUP BY "row.names"
)
UPDATE raw_dwc.atropellamientos_registros AS r
SET cds_recorded_by=b.cds
FROM b
WHERE r."row.names"=b."row.names"
RETURNING r."row.names", cds_recorded_by
;
ALTER TABLE raw_dwc.atropellamientos_registros ADD COLUMN cds_identified_by int[];
WITH a AS(
SELECT "row.names", INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(identified_by, ' | ')))) AS name_person
FROM raw_dwc.atropellamientos_registros
),b AS(
SELECT "row.names", ARRAY_AGG(cd_person) cds
FROM a 
LEFT JOIN main.people p ON a.name_person=p.verbatim_person
GROUP BY "row.names"
)
UPDATE raw_dwc.atropellamientos_registros AS r
SET cds_identified_by=b.cds
FROM b
WHERE r."row.names"=b."row.names"
RETURNING r."row.names", cds_identified_by
;
SELECT 1;
```

<div class="knitsql-table">

| ?column? |
|---------:|
|        1 |

1 records

</div>

## 3.4 gp_event

Una manera de hacer los gps event es considerar que cada ves que se hace
CARAC (o KAPLA) es una repetición… Así cada mes es una campaña
diferente: en lugar de tener 2 campañas, tenemos 5

``` sql
WITH a AS(
SELECT 
  event_id, 
  TO_DATE(event_date,'YYYY-MM-DD'),
  REGEXP_REPLACE(event_id,'^([A-Z][a-z]+)-((CARAC)|(KAPLA))_([0-9]{1,3})$','\1') mes,
  REGEXP_REPLACE(event_id,'^([A-Z][a-z]+)-((CARAC)|(KAPLA))_([0-9]{1,3})$','\2') reco,
  REGEXP_REPLACE(event_id,'^([A-Z][a-z]+)-((CARAC)|(KAPLA))_([0-9]{1,3})$','\5') number,
  count(*)
  
FROM raw_dwc.atropellamientos_event
GROUP BY  event_id, TO_DATE(event_date,'YYYY-MM-DD'), mes
ORDER BY  TO_DATE(event_date,'YYYY-MM-DD')
)
SELECT * 
FROM a
;
```

<div class="knitsql-table">

| event_id           | to_date    | mes       | reco  | number | count |
|:-------------------|:-----------|:----------|:------|:-------|------:|
| Noviembre-KAPLA_1  | 2021-11-13 | Noviembre | KAPLA | 1      |     1 |
| Noviembre-CARAC_1  | 2021-11-14 | Noviembre | CARAC | 1      |     1 |
| Noviembre-KAPLA_2  | 2021-11-16 | Noviembre | KAPLA | 2      |     1 |
| Noviembre-CARAC_2  | 2021-11-17 | Noviembre | CARAC | 2      |     1 |
| Noviembre-KAPLA_3  | 2021-11-19 | Noviembre | KAPLA | 3      |     1 |
| Noviembre-CARAC_3  | 2021-11-20 | Noviembre | CARAC | 3      |     1 |
| Noviembre-CARAC_4  | 2021-11-22 | Noviembre | CARAC | 4      |     1 |
| Noviembre-KAPLA_4  | 2021-11-23 | Noviembre | KAPLA | 4      |     1 |
| Noviembre-CARAC_5  | 2021-11-24 | Noviembre | CARAC | 5      |     1 |
| Noviembre-KAPLA_5  | 2021-11-25 | Noviembre | KAPLA | 5      |     1 |
| Diciembre-KAPLA_6  | 2021-12-07 | Diciembre | KAPLA | 6      |     1 |
| Diciembre-CARAC_6  | 2021-12-08 | Diciembre | CARAC | 6      |     1 |
| Diciembre-KAPLA_7  | 2021-12-10 | Diciembre | KAPLA | 7      |     1 |
| Diciembre-CARAC_7  | 2021-12-11 | Diciembre | CARAC | 7      |     1 |
| Diciembre-KAPLA_8  | 2021-12-13 | Diciembre | KAPLA | 8      |     1 |
| Diciembre-CARAC_8  | 2021-12-14 | Diciembre | CARAC | 8      |     1 |
| Diciembre-KAPLA_9  | 2021-12-16 | Diciembre | KAPLA | 9      |     1 |
| Diciembre-CARAC_9  | 2021-12-17 | Diciembre | CARAC | 9      |     1 |
| Diciembre-KAPLA_10 | 2021-12-18 | Diciembre | KAPLA | 10     |     1 |
| Diciembre-CARAC_10 | 2021-12-19 | Diciembre | CARAC | 10     |     1 |
| Enero-KAPLA_11     | 2022-01-18 | Enero     | KAPLA | 11     |     1 |
| Enero-CARAC_11     | 2022-01-19 | Enero     | CARAC | 11     |     1 |
| Enero-KAPLA_12     | 2022-01-20 | Enero     | KAPLA | 12     |     1 |
| Enero-CARAC_12     | 2022-01-21 | Enero     | CARAC | 12     |     1 |
| Enero-KAPLA_13     | 2022-01-22 | Enero     | KAPLA | 13     |     1 |
| Enero-CARAC_13     | 2022-01-24 | Enero     | CARAC | 13     |     1 |
| Enero-KAPLA_14     | 2022-01-25 | Enero     | KAPLA | 14     |     1 |
| Enero-CARAC_14     | 2022-01-26 | Enero     | CARAC | 14     |     1 |
| Enero-KAPLA_15     | 2022-01-27 | Enero     | KAPLA | 15     |     1 |
| Enero-CARAC_15     | 2022-01-28 | Enero     | CARAC | 15     |     1 |
| Marzo-KAPLA_16     | 2022-03-17 | Marzo     | KAPLA | 16     |     1 |
| Marzo-CARAC_16     | 2022-03-18 | Marzo     | CARAC | 16     |     1 |
| Marzo-KAPLA_17     | 2022-03-19 | Marzo     | KAPLA | 17     |     1 |
| Marzo-CARAC_17     | 2022-03-21 | Marzo     | CARAC | 17     |     1 |
| Marzo-KAPLA_18     | 2022-03-22 | Marzo     | KAPLA | 18     |     1 |
| Marzo-CARAC_18     | 2022-03-23 | Marzo     | CARAC | 18     |     1 |
| Marzo-KAPLA_19     | 2022-03-24 | Marzo     | KAPLA | 19     |     1 |
| Marzo-CARAC_19     | 2022-03-25 | Marzo     | CARAC | 19     |     1 |
| Marzo-KAPLA_20     | 2022-03-27 | Marzo     | KAPLA | 20     |     1 |
| Marzo-CARAC_20     | 2022-03-28 | Marzo     | CARAC | 20     |     1 |
| Abril-KAPLA_21     | 2022-04-19 | Abril     | KAPLA | 21     |     1 |
| Abril-CARAC_21     | 2022-04-20 | Abril     | CARAC | 21     |     1 |
| Abril-KAPLA_22     | 2022-04-21 | Abril     | KAPLA | 22     |     1 |
| Abril-CARAC_22     | 2022-04-22 | Abril     | CARAC | 22     |     1 |
| Abril-KAPLA_23     | 2022-04-23 | Abril     | KAPLA | 23     |     1 |
| Abril-CARAC_23     | 2022-04-25 | Abril     | CARAC | 23     |     1 |
| Abril-KAPLA_24     | 2022-04-26 | Abril     | KAPLA | 24     |     1 |
| Abril-CARAC_24     | 2022-04-27 | Abril     | CARAC | 24     |     1 |
| Abril-KAPLA_25     | 2022-04-28 | Abril     | KAPLA | 25     |     1 |
| Abril-CARAC_25     | 2022-04-29 | Abril     | CARAC | 25     |     1 |

50 records

</div>

``` sql
WITH a AS(
SELECT 
  --event_id, 
  --TO_DATE(event_date,'YYYY-MM-DD'),
  REGEXP_REPLACE(event_id,'^([A-Z][a-z]+)-((CARAC)|(KAPLA))_([0-9]{1,3})$','\1') mes,
  INITCAP(REGEXP_REPLACE(event_id,'^([A-Z][a-z]+)-((CARAC)|(KAPLA))_([0-9]{1,3})$','\2')) reco,
  MIN(TO_DATE(event_date,'YYYY-MM-DD')) min_fecha,
  --REGEXP_REPLACE(event_id,'^([A-Z][a-z]+)-((CARAC)|(KAPLA))_([0-9]{1,3})$','\5') number,
  count(*)
  
FROM raw_dwc.atropellamientos_event
GROUP BY  mes,reco
ORDER BY reco,mes-- TO_DATE(event_date,'YYYY-MM-DD')
)
SELECT ROW_NUMBER() OVER (PARTITION BY reco ORDER BY min_fecha) campaign_nb ,* 
FROM a
;
```

<div class="knitsql-table">

| campaign_nb | mes       | reco  | min_fecha  | count |
|------------:|:----------|:------|:-----------|------:|
|           1 | Noviembre | Carac | 2021-11-14 |     5 |
|           2 | Diciembre | Carac | 2021-12-08 |     5 |
|           3 | Enero     | Carac | 2022-01-19 |     5 |
|           4 | Marzo     | Carac | 2022-03-18 |     5 |
|           5 | Abril     | Carac | 2022-04-20 |     5 |
|           1 | Noviembre | Kapla | 2021-11-13 |     5 |
|           2 | Diciembre | Kapla | 2021-12-07 |     5 |
|           3 | Enero     | Kapla | 2022-01-18 |     5 |
|           4 | Marzo     | Kapla | 2022-03-17 |     5 |
|           5 | Abril     | Kapla | 2022-04-19 |     5 |

10 records

</div>

``` sql
INSERT INTO main.gp_event(cd_pt_ref,cd_gp_biol, cd_protocol, campaign_nb)
WITH a AS(
SELECT 
  --event_id, 
  --TO_DATE(event_date,'YYYY-MM-DD'),
  REGEXP_REPLACE(event_id,'^([A-Z][a-z]+)-((CARAC)|(KAPLA))_([0-9]{1,3})$','\1') mes,
  INITCAP(REGEXP_REPLACE(event_id,'^([A-Z][a-z]+)-((CARAC)|(KAPLA))_([0-9]{1,3})$','\2')) reco,
  MIN(TO_DATE(event_date,'YYYY-MM-DD')) min_fecha,
  --REGEXP_REPLACE(event_id,'^([A-Z][a-z]+)-((CARAC)|(KAPLA))_([0-9]{1,3})$','\5') number,
  count(*)
  
FROM raw_dwc.atropellamientos_event
GROUP BY  mes,reco
ORDER BY reco,mes-- TO_DATE(event_date,'YYYY-MM-DD')
)
SELECT cd_pt_ref, 
  'atro', 
  (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Roadkill search'),
  ROW_NUMBER() OVER (PARTITION BY reco ORDER BY min_fecha) campaign_nb
FROM a
JOIN main.punto_referencia pr ON a.reco=pr.name_pt_ref
RETURNING gp_event.*
;
```

Attributing the gp_event

``` sql
ALTER TABLE raw_dwc.atropellamientos_event ADD COLUMN cd_gp_event int REFERENCES main.gp_event(cd_gp_event) ON DELETE SET NULL;

WITH a AS(
SELECT 
  --event_id, 
  --TO_DATE(event_date,'YYYY-MM-DD'),
  REGEXP_REPLACE(event_id,'^([A-Z][a-z]+)-((CARAC)|(KAPLA))_([0-9]{1,3})$','\1') mes,
  INITCAP(REGEXP_REPLACE(event_id,'^([A-Z][a-z]+)-((CARAC)|(KAPLA))_([0-9]{1,3})$','\2')) reco,
  MIN(TO_DATE(event_date,'YYYY-MM-DD')) min_fecha,
  --REGEXP_REPLACE(event_id,'^([A-Z][a-z]+)-((CARAC)|(KAPLA))_([0-9]{1,3})$','\5') number,
  count(*)
  
FROM raw_dwc.atropellamientos_event
GROUP BY  mes,reco
ORDER BY reco,mes-- TO_DATE(event_date,'YYYY-MM-DD')
), b AS(
SELECT *,
  ROW_NUMBER() OVER (PARTITION BY reco ORDER BY min_fecha) campaign_nb
FROM a
JOIN main.punto_referencia pr ON a.reco=pr.name_pt_ref
), c AS(
SELECT "row.names", ge.cd_gp_event
FROM raw_dwc.atropellamientos_event e
LEFT JOIN b ON REGEXP_REPLACE(event_id,'^([A-Z][a-z]+)-((CARAC)|(KAPLA))_([0-9]{1,3})$','\1')=b.mes
  AND INITCAP(REGEXP_REPLACE(event_id,'^([A-Z][a-z]+)-((CARAC)|(KAPLA))_([0-9]{1,3})$','\2'))=b.reco
--cuidado eso no funciona para los grupos que comparten ANH con otros grupos
LEFT JOIN main.gp_event ge USING(cd_pt_ref,campaign_nb)
)
UPDATE raw_dwc.atropellamientos_event AS e
SET cd_gp_event=c.cd_gp_event
FROM c 
WHERE c."row.names"=e."row.names";

SELECT 'true';
```

<div class="knitsql-table">

| ?column? |
|:---------|
| true     |

1 records

</div>

## 3.5 event

``` sql
WITH a AS(
SELECT cd_gp_event,
  event_id, 
  REGEXP_REPLACE(event_id,'^([A-Z][a-z]+)-((CARAC)|(KAPLA))_([0-9]{1,3})$','\1') mes,
  INITCAP(REGEXP_REPLACE(event_id,'^([A-Z][a-z]+)-((CARAC)|(KAPLA))_([0-9]{1,3})$','\2')) reco,
  REGEXP_REPLACE(event_id,'^([A-Z][a-z]+)-((CARAC)|(KAPLA))_([0-9]{1,3})$','\5')::int number,
  TO_DATE(event_date, 'YYYY-MM-DD') date,
  REGEXP_REPLACE(SPLIT_PART(event_time,'/',1),'\s+','','g') hora_1,
  REGEXP_REPLACE(SPLIT_PART(event_time,'/',2),'\s+','','g') hora_2,
  sample_size_value,
  --REGEXP_REPLACE(event_remarks,'La hora inicial corresponde al comienzo del recorrido y la hora final cuando termina;? ?\|?','')||' | '||event_remarks_1 event_remarks,
  event_remarks_1 event_remarks,
  locality,
  decimal_latitude::double precision pt1_lat,
  decimal_longitude::double precision pt1_long,
  REGEXP_REPLACE(SPLIT_PART(measurement_value__coordenadas_intermedia_,',',1),'[ .]$','')::double precision pt2_lat,
  SPLIT_PART(measurement_value__coordenadas_intermedia_,',',2)::double precision pt2_long,
  SPLIT_PART(measurement_value__coordenadas_final_,',',1)::double precision pt3_lat,
  SPLIT_PART(measurement_value__coordenadas_final_,',',2)::double precision pt3_long,
  (sample_size_value::double precision)*1000 samp_effort_1
FROM raw_dwc.atropellamientos_event
ORDER BY cd_gp_event, number
)
 SELECT 
  event_id,
  cd_gp_event,
  ROW_NUMBER() OVER (PARTITION BY cd_gp_event ORDER BY number) num_replicate,
  REGEXP_REPLACE(event_id,'^([A-Z][a-z]+)-((CARAC)|(KAPLA))_([0-9]{1,3})$','month:\1|route:\2|route_repetition_number:\5') description_replicate,
  (date||' '||hora_1)::timestamp date_time_begin,
  (date||' '||hora_2)::timestamp date_time_end,
  locality,
  samp_effort_1,
  event_remarks/*,
  ST_transform(
   ST_MakeLine(ARRAY[
     ST_SetSRID(ST_MakePoint(pt1_long,pt1_lat),4326),
     ST_SetSRID(ST_MakePoint(pt2_long,pt2_lat),4326),
     ST_SetSRID(ST_MakePoint(pt3_long,pt3_lat),4326)
   ])
 ,3116) lines*/
FROM a
```

<div class="knitsql-table">

| event_id           | cd_gp_event | num_replicate | description_replicate                                    | date_time_begin     | date_time_end       | locality      | samp_effort_1 | event_remarks          |
|:-------------------|------------:|--------------:|:---------------------------------------------------------|:--------------------|:--------------------|:--------------|--------------:|:-----------------------|
| Noviembre-CARAC_1  |          80 |             1 | month:Noviembre\|route:CARAC\|route_repetition_number:1  | 2021-11-14 06:00:00 | 2021-11-14 08:25:00 | Vereda Centro |         58000 | Aguas bajas \| Soleado |
| Noviembre-CARAC_2  |          80 |             2 | month:Noviembre\|route:CARAC\|route_repetition_number:2  | 2021-11-17 06:00:00 | 2021-11-17 09:58:00 | Vereda Centro |         58000 | Aguas bajas \| Soleado |
| Noviembre-CARAC_3  |          80 |             3 | month:Noviembre\|route:CARAC\|route_repetition_number:3  | 2021-11-20 06:00:00 | 2021-11-20 09:58:00 | Vereda Centro |         58000 | Aguas bajas \| Soleado |
| Noviembre-CARAC_4  |          80 |             4 | month:Noviembre\|route:CARAC\|route_repetition_number:4  | 2021-11-22 06:00:00 | 2021-11-22 09:58:00 | Vereda Centro |         58000 | Aguas bajas \| Soleado |
| Noviembre-CARAC_5  |          80 |             5 | month:Noviembre\|route:CARAC\|route_repetition_number:5  | 2021-11-24 06:00:00 | 2021-11-24 09:59:00 | Vereda Centro |         58000 | Aguas bajas \| Soleado |
| Diciembre-CARAC_6  |          81 |             1 | month:Diciembre\|route:CARAC\|route_repetition_number:6  | 2021-12-08 06:05:00 | 2021-12-08 11:00:00 | Vereda Centro |         58000 | Aguas bajas \| Soleado |
| Diciembre-CARAC_7  |          81 |             2 | month:Diciembre\|route:CARAC\|route_repetition_number:7  | 2021-12-11 06:24:00 | 2021-12-11 11:15:00 | Vereda Centro |         58000 | Aguas bajas \| Soleado |
| Diciembre-CARAC_8  |          81 |             3 | month:Diciembre\|route:CARAC\|route_repetition_number:8  | 2021-12-14 06:15:00 | 2021-12-14 11:10:00 | Vereda Centro |         58000 | Aguas bajas \| Soleado |
| Diciembre-CARAC_9  |          81 |             4 | month:Diciembre\|route:CARAC\|route_repetition_number:9  | 2021-12-17 06:15:00 | 2021-12-17 11:15:00 | Vereda Centro |         58000 | Aguas bajas \| Soleado |
| Diciembre-CARAC_10 |          81 |             5 | month:Diciembre\|route:CARAC\|route_repetition_number:10 | 2021-12-19 06:15:00 | 2021-12-19 10:00:00 | Vereda Centro |         58000 | Aguas bajas \| Soleado |
| Enero-CARAC_11     |          82 |             1 | month:Enero\|route:CARAC\|route_repetition_number:11     | 2022-01-19 06:12:00 | 2022-01-19 10:59:00 | Vereda Centro |         58000 | Aguas bajas \| Soleado |
| Enero-CARAC_12     |          82 |             2 | month:Enero\|route:CARAC\|route_repetition_number:12     | 2022-01-21 06:16:00 | 2022-01-21 11:10:00 | Vereda Centro |         58000 | Aguas bajas \| Soleado |
| Enero-CARAC_13     |          82 |             3 | month:Enero\|route:CARAC\|route_repetition_number:13     | 2022-01-24 06:15:00 | 2022-01-24 10:36:00 | Vereda Centro |         58000 | Aguas bajas \| Soleado |
| Enero-CARAC_14     |          82 |             4 | month:Enero\|route:CARAC\|route_repetition_number:14     | 2022-01-26 06:30:00 | 2022-01-26 10:43:00 | Vereda Centro |         58000 | Aguas bajas \| soleado |
| Enero-CARAC_15     |          82 |             5 | month:Enero\|route:CARAC\|route_repetition_number:15     | 2022-01-28 06:20:00 | 2022-01-28 11:16:00 | Vereda Centro |         58000 | Aguas bajas \| Nublado |
| Marzo-CARAC_16     |          83 |             1 | month:Marzo\|route:CARAC\|route_repetition_number:16     | 2022-03-18 06:26:00 | 2022-03-18 10:58:00 | Vereda Centro |         58000 | Aguas bajas \| Soleado |
| Marzo-CARAC_17     |          83 |             2 | month:Marzo\|route:CARAC\|route_repetition_number:17     | 2022-03-21 06:40:00 | 2022-03-21 11:00:00 | Vereda Centro |         58000 | Aguas bajas \| Soleado |
| Marzo-CARAC_18     |          83 |             3 | month:Marzo\|route:CARAC\|route_repetition_number:18     | 2022-03-23 06:19:00 | 2022-03-23 10:11:00 | Vereda Centro |         58000 | Aguas bajas \| Soleado |
| Marzo-CARAC_19     |          83 |             4 | month:Marzo\|route:CARAC\|route_repetition_number:19     | 2022-03-25 06:17:00 | 2022-03-25 10:27:00 | Vereda Centro |         58000 | Aguas bajas \| Nublado |
| Marzo-CARAC_20     |          83 |             5 | month:Marzo\|route:CARAC\|route_repetition_number:20     | 2022-03-28 06:16:00 | 2022-03-28 10:53:00 | Vereda Centro |         58000 | Aguas bajas \| Nublado |
| Abril-CARAC_21     |          84 |             1 | month:Abril\|route:CARAC\|route_repetition_number:21     | 2022-04-20 06:01:00 | 2022-04-20 09:56:00 | Vereda Centro |         58000 | Aguas bajas \| Nublado |
| Abril-CARAC_22     |          84 |             2 | month:Abril\|route:CARAC\|route_repetition_number:22     | 2022-04-22 06:05:00 | 2022-04-22 10:25:00 | Vereda Centro |         58000 | Aguas bajas \| Soleado |
| Abril-CARAC_23     |          84 |             3 | month:Abril\|route:CARAC\|route_repetition_number:23     | 2022-04-25 06:18:00 | 2022-04-25 08:33:00 | Vereda Centro |         58000 | Aguas bajas \| Soleado |
| Abril-CARAC_24     |          84 |             4 | month:Abril\|route:CARAC\|route_repetition_number:24     | 2022-04-27 06:21:00 | 2022-04-27 10:09:00 | Vereda Centro |         58000 | Aguas bajas \| Soleado |
| Abril-CARAC_25     |          84 |             5 | month:Abril\|route:CARAC\|route_repetition_number:25     | 2022-04-29 06:11:00 | 2022-04-29 09:53:00 | Vereda Centro |         58000 | Aguas bajas \| Soleado |
| Noviembre-KAPLA_1  |          85 |             1 | month:Noviembre\|route:KAPLA\|route_repetition_number:1  | 2021-11-13 06:00:00 | 2021-11-13 09:53:00 | Vereda Centro |         57000 | Aguas bajas \| Soleado |
| Noviembre-KAPLA_2  |          85 |             2 | month:Noviembre\|route:KAPLA\|route_repetition_number:2  | 2021-11-16 06:00:00 | 2021-11-16 09:56:00 | Vereda Centro |         57000 | Aguas bajas \| Soleado |
| Noviembre-KAPLA_3  |          85 |             3 | month:Noviembre\|route:KAPLA\|route_repetition_number:3  | 2021-11-19 07:00:00 | 2021-11-19 10:58:00 | Vereda Centro |         57000 | Aguas bajas \| Soleado |
| Noviembre-KAPLA_4  |          85 |             4 | month:Noviembre\|route:KAPLA\|route_repetition_number:4  | 2021-11-23 06:00:00 | 2021-11-23 09:58:00 | Vereda Centro |         57000 | Aguas bajas \| Soleado |
| Noviembre-KAPLA_5  |          85 |             5 | month:Noviembre\|route:KAPLA\|route_repetition_number:5  | 2021-11-25 06:00:00 | 2021-11-25 09:59:00 | Vereda Centro |         57000 | Aguas bajas \| Soleado |
| Diciembre-KAPLA_6  |          86 |             1 | month:Diciembre\|route:KAPLA\|route_repetition_number:6  | 2021-12-07 06:15:00 | 2021-12-07 10:30:00 | Vereda Centro |         57000 | Aguas bajas \| Soleado |
| Diciembre-KAPLA_7  |          86 |             2 | month:Diciembre\|route:KAPLA\|route_repetition_number:7  | 2021-12-10 06:10:00 | 2021-12-10 10:38:00 | Vereda Centro |         57000 | Aguas bajas \| Soleado |
| Diciembre-KAPLA_8  |          86 |             3 | month:Diciembre\|route:KAPLA\|route_repetition_number:8  | 2021-12-13 06:10:00 | 2021-12-13 11:15:00 | Vereda Centro |         57000 | Aguas bajas \| Soleado |
| Diciembre-KAPLA_9  |          86 |             4 | month:Diciembre\|route:KAPLA\|route_repetition_number:9  | 2021-12-16 06:15:00 | 2021-12-16 10:50:00 | Vereda Centro |         57000 | Aguas bajas \| Soleado |
| Diciembre-KAPLA_10 |          86 |             5 | month:Diciembre\|route:KAPLA\|route_repetition_number:10 | 2021-12-18 06:15:00 | 2021-12-18 10:00:00 | Vereda Centro |         57000 | Aguas bajas \| Soleado |
| Enero-KAPLA_11     |          87 |             1 | month:Enero\|route:KAPLA\|route_repetition_number:11     | 2022-01-18 06:10:00 | 2022-01-18 10:15:00 | Vereda Centro |         57000 | Aguas bajas \| Nublado |
| Enero-KAPLA_12     |          87 |             2 | month:Enero\|route:KAPLA\|route_repetition_number:12     | 2022-01-20 06:20:00 | 2022-01-20 11:18:00 | Vereda Centro |         57000 | Aguas bajas \| Soleado |
| Enero-KAPLA_13     |          87 |             3 | month:Enero\|route:KAPLA\|route_repetition_number:13     | 2022-01-22 06:18:00 | 2022-01-22 10:29:00 | Vereda Centro |         57000 | Aguas bajas \| Soleado |
| Enero-KAPLA_14     |          87 |             4 | month:Enero\|route:KAPLA\|route_repetition_number:14     | 2022-01-25 06:20:00 | 2022-01-25 09:58:00 | Vereda Centro |         57000 | Aguas bajas \| Soleado |
| Enero-KAPLA_15     |          87 |             5 | month:Enero\|route:KAPLA\|route_repetition_number:15     | 2022-01-27 06:19:00 | 2022-01-27 09:46:00 | Vereda Centro |         57000 | Aguas bajas \| Nublado |
| Marzo-KAPLA_16     |          88 |             1 | month:Marzo\|route:KAPLA\|route_repetition_number:16     | 2022-03-17 06:15:00 | 2022-03-17 11:30:00 | Vereda Centro |         57000 | Aguas bajas \| Soleado |
| Marzo-KAPLA_17     |          88 |             2 | month:Marzo\|route:KAPLA\|route_repetition_number:17     | 2022-03-19 05:55:00 | 2022-03-19 11:00:00 | Vereda Centro |         57000 | Aguas bajas \| Soleado |
| Marzo-KAPLA_18     |          88 |             3 | month:Marzo\|route:KAPLA\|route_repetition_number:18     | 2022-03-22 06:03:00 | 2022-03-22 10:14:00 | Vereda Centro |         57000 | Aguas bajas \| Soleado |
| Marzo-KAPLA_19     |          88 |             4 | month:Marzo\|route:KAPLA\|route_repetition_number:19     | 2022-03-24 06:01:00 | 2022-03-24 09:53:00 | Vereda Centro |         57000 | Aguas bajas \| Nublado |
| Marzo-KAPLA_20     |          88 |             5 | month:Marzo\|route:KAPLA\|route_repetition_number:20     | 2022-03-27 06:05:00 | 2022-03-27 10:00:00 | Vereda Centro |         57000 | Aguas bajas \| Nublado |
| Abril-KAPLA_21     |          89 |             1 | month:Abril\|route:KAPLA\|route_repetition_number:21     | 2022-04-19 06:00:00 | 2022-04-19 09:56:00 | Vereda Centro |         57000 | Aguas bajas \| Nublado |
| Abril-KAPLA_22     |          89 |             2 | month:Abril\|route:KAPLA\|route_repetition_number:22     | 2022-04-21 06:00:00 | 2022-04-21 09:49:00 | Vereda Centro |         57000 | Aguas bajas \| Soleado |
| Abril-KAPLA_23     |          89 |             3 | month:Abril\|route:KAPLA\|route_repetition_number:23     | 2022-04-23 06:00:00 | 2022-04-23 09:30:00 | Vereda Centro |         57000 | Aguas bajas \| Soleado |
| Abril-KAPLA_24     |          89 |             4 | month:Abril\|route:KAPLA\|route_repetition_number:24     | 2022-04-26 06:02:00 | 2022-04-26 09:27:00 | Vereda Centro |         57000 | Aguas bajas \| Soleado |
| Abril-KAPLA_25     |          89 |             5 | month:Abril\|route:KAPLA\|route_repetition_number:25     | 2022-04-28 06:06:00 | 2022-04-28 09:32:00 | Vereda Centro |         57000 | Aguas bajas \| Soleado |

50 records

</div>

``` sql
INSERT INTO main.event(event_id, cd_gp_event, num_replicate, description_replicate, date_time_begin, date_time_end, locality_verb, samp_effort_1, event_remarks, li_geom)
WITH a AS(
SELECT cd_gp_event,
  event_id, 
  REGEXP_REPLACE(event_id,'^([A-Z][a-z]+)-((CARAC)|(KAPLA))_([0-9]{1,3})$','\1') mes,
  INITCAP(REGEXP_REPLACE(event_id,'^([A-Z][a-z]+)-((CARAC)|(KAPLA))_([0-9]{1,3})$','\2')) reco,
  REGEXP_REPLACE(event_id,'^([A-Z][a-z]+)-((CARAC)|(KAPLA))_([0-9]{1,3})$','\5')::int number,
  TO_DATE(event_date, 'YYYY-MM-DD') date,
  REGEXP_REPLACE(SPLIT_PART(event_time,'/',1),'\s+','','g') hora_1,
  REGEXP_REPLACE(SPLIT_PART(event_time,'/',2),'\s+','','g') hora_2,
  sample_size_value,
  --REGEXP_REPLACE(event_remarks,'La hora inicial corresponde al comienzo del recorrido y la hora final cuando termina;? ?\|?','')||' | '||event_remarks_1 event_remarks,
  event_remarks_1 event_remarks,
  locality,
  decimal_latitude::double precision pt1_lat,
  decimal_longitude::double precision pt1_long,
  REGEXP_REPLACE(SPLIT_PART(measurement_value__coordenadas_intermedia_,',',1),'[ .]$','')::double precision pt2_lat,
  SPLIT_PART(measurement_value__coordenadas_intermedia_,',',2)::double precision pt2_long,
  SPLIT_PART(measurement_value__coordenadas_final_,',',1)::double precision pt3_lat,
  SPLIT_PART(measurement_value__coordenadas_final_,',',2)::double precision pt3_long,
  (sample_size_value::double precision)*1000 samp_effort_1
FROM raw_dwc.atropellamientos_event
ORDER BY cd_gp_event, number
)
 SELECT 
  event_id,
  cd_gp_event,
  ROW_NUMBER() OVER (PARTITION BY cd_gp_event ORDER BY number) num_replicate,
  REGEXP_REPLACE(event_id,'^([A-Z][a-z]+)-((CARAC)|(KAPLA))_([0-9]{1,3})$','month:\1|route:\2|route_repetition_number:\5') description_replicate,
  (date||' '||hora_1)::timestamp date_time_begin,
  (date||' '||hora_2)::timestamp date_time_end,
  locality,
  samp_effort_1,
  event_remarks,
 ST_transform(
   ST_MakeLine(ARRAY[
     ST_SetSRID(ST_MakePoint(pt1_long,pt1_lat),4326),
     ST_SetSRID(ST_MakePoint(pt2_long,pt2_lat),4326),
     ST_SetSRID(ST_MakePoint(pt3_long,pt3_lat),4326)
   ])
 ,(SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)) lines
FROM a
RETURNING main.event.cd_event, main.event.event_id;
```

Damos los cd_event a todos las filas:

``` sql
ALTER TABLE raw_dwc.atropellamientos_event ADD COLUMN cd_event int REFERENCES main.event(cd_event) ON DELETE SET NULL;
ALTER TABLE raw_dwc.atropellamientos_registros ADD COLUMN cd_event int REFERENCES main.event(cd_event);

UPDATE raw_dwc.atropellamientos_event AS t
SET cd_event=e.cd_event
FROM main.event e
WHERE t.event_id=e.event_id;

UPDATE raw_dwc.atropellamientos_registros AS t
SET cd_event=e.cd_event
FROM main.event e
WHERE t.event_id=e.event_id;

SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

## 3.6 registros

``` sql
INSERT INTO main.registros(cd_event, cds_recorded_by, date_time, cd_tax, cd_morfo, cds_identified_by, qt_int,remarks, occurrence_id, organism_id, the_geom)
SELECT 
 cd_event,
 cds_recorded_by,
 (e.date_time_begin::date||' '||event_time)::timestamp date_time,
 tt.cd_tax,
 tt.cd_morfo,
 cds_identified_by,
 organism_quantity::int qt_int,
 NULL remarks,
 occurrence_id,
 organism_id,
 ST_SetSRID(ST_Transform(ST_SetSRID(ST_MakePoint(measurement_value__longitud_,measurement_value__latitud_), 4326),  (SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)),3116)
FROM raw_dwc.atropellamientos_registros r
LEFT JOIN raw_dwc.taxonomy_total tt ON tt."row.names"=r."row.names" AND tt.table_orig='atropellamientos_registros'
LEFT JOIN main.event e USING (cd_event)
ORDER BY cd_event, date_time;
SELECT true;
```

Atribuir los cd_reg

Tenemos que tener una solución para separar los taxones de reptiles y
atropellamientos

``` sql
ALTER TABLE raw_dwc.atropellamientos_registros ADD COLUMN cd_reg int REFERENCES main.registros(cd_reg);
UPDATE raw_dwc.atropellamientos_registros AS ar
SET cd_reg=r.cd_reg
FROM main.registros r
WHERE ar.cd_event=r.cd_event AND ar.organism_id=r.organism_id;

SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

# 4 Mariposas

## 4.1 ANH

Entender el plan de muestreo

``` sql
SELECT 
  event_id,
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_T\. Van Someren-Rydon([0-9])_(202[12]-[0-9][0-9]-[0-9][0-9])/(202[12]-[0-9][0-9]-[0-9][0-9])$','\1')::int anh_num,
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_T\. Van Someren-Rydon([0-9])_(202[12]-[0-9][0-9]-[0-9][0-9])/(202[12]-[0-9][0-9]-[0-9][0-9])$','\2')::int trap_num,
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_T\. Van Someren-Rydon([0-9])_(202[12]-[0-9][0-9]-[0-9][0-9])/(202[12]-[0-9][0-9]-[0-9][0-9])$','\3')::date fecha1,
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_T\. Van Someren-Rydon([0-9])_(202[12]-[0-9][0-9]-[0-9][0-9])/(202[12]-[0-9][0-9]-[0-9][0-9])$','\4')::date fecha2
FROM raw_dwc.mariposas_event
ORDER BY anh_num, fecha1, trap_num
```

<div class="knitsql-table">

| event_id                                            | anh_num | trap_num | fecha1     | fecha2     |
|:----------------------------------------------------|--------:|---------:|:-----------|:-----------|
| ANH_108_T. Van Someren-Rydon1_2021-07-13/2021-07-15 |     108 |        1 | 2021-07-13 | 2021-07-15 |
| ANH_108_T. Van Someren-Rydon2_2021-07-13/2021-07-15 |     108 |        2 | 2021-07-13 | 2021-07-15 |
| ANH_108_T. Van Someren-Rydon3_2021-07-13/2021-07-15 |     108 |        3 | 2021-07-13 | 2021-07-15 |
| ANH_108_T. Van Someren-Rydon4_2021-07-13/2021-07-15 |     108 |        4 | 2021-07-13 | 2021-07-15 |
| ANH_108_T. Van Someren-Rydon5_2021-07-13/2021-07-15 |     108 |        5 | 2021-07-13 | 2021-07-15 |
| ANH_108_T. Van Someren-Rydon6_2021-07-13/2021-07-15 |     108 |        6 | 2021-07-13 | 2021-07-15 |
| ANH_108_T. Van Someren-Rydon1_2022-03-29/2022-03-31 |     108 |        1 | 2022-03-29 | 2022-03-31 |
| ANH_108_T. Van Someren-Rydon2_2022-03-29/2022-03-31 |     108 |        2 | 2022-03-29 | 2022-03-31 |
| ANH_108_T. Van Someren-Rydon3_2022-03-29/2022-03-31 |     108 |        3 | 2022-03-29 | 2022-03-31 |
| ANH_108_T. Van Someren-Rydon4_2022-03-29/2022-03-31 |     108 |        4 | 2022-03-29 | 2022-03-31 |
| ANH_108_T. Van Someren-Rydon5_2022-03-29/2022-03-31 |     108 |        5 | 2022-03-29 | 2022-03-31 |
| ANH_108_T. Van Someren-Rydon6_2022-03-29/2022-03-31 |     108 |        6 | 2022-03-29 | 2022-03-31 |
| ANH_109_T. Van Someren-Rydon1_2021-07-15/2021-07-17 |     109 |        1 | 2021-07-15 | 2021-07-17 |
| ANH_109_T. Van Someren-Rydon2_2021-07-15/2021-07-17 |     109 |        2 | 2021-07-15 | 2021-07-17 |
| ANH_109_T. Van Someren-Rydon3_2021-07-15/2021-07-17 |     109 |        3 | 2021-07-15 | 2021-07-17 |
| ANH_109_T. Van Someren-Rydon4_2021-07-15/2021-07-17 |     109 |        4 | 2021-07-15 | 2021-07-17 |
| ANH_109_T. Van Someren-Rydon5_2021-07-15/2021-07-17 |     109 |        5 | 2021-07-15 | 2021-07-17 |
| ANH_109_T. Van Someren-Rydon6_2021-07-15/2021-07-17 |     109 |        6 | 2021-07-15 | 2021-07-17 |
| ANH_109_T. Van Someren-Rydon1_2022-04-05/2022-04-07 |     109 |        1 | 2022-04-05 | 2022-04-07 |
| ANH_109_T. Van Someren-Rydon2_2022-04-05/2022-04-07 |     109 |        2 | 2022-04-05 | 2022-04-07 |
| ANH_109_T. Van Someren-Rydon3_2022-04-05/2022-04-07 |     109 |        3 | 2022-04-05 | 2022-04-07 |
| ANH_109_T. Van Someren-Rydon4_2022-04-05/2022-04-07 |     109 |        4 | 2022-04-05 | 2022-04-07 |
| ANH_109_T. Van Someren-Rydon5_2022-04-05/2022-04-07 |     109 |        5 | 2022-04-05 | 2022-04-07 |
| ANH_109_T. Van Someren-Rydon6_2022-04-05/2022-04-07 |     109 |        6 | 2022-04-05 | 2022-04-07 |
| ANH_110_T. Van Someren-Rydon1_2021-07-15/2021-07-17 |     110 |        1 | 2021-07-15 | 2021-07-17 |
| ANH_110_T. Van Someren-Rydon2_2021-07-15/2021-07-17 |     110 |        2 | 2021-07-15 | 2021-07-17 |
| ANH_110_T. Van Someren-Rydon3_2021-07-15/2021-07-17 |     110 |        3 | 2021-07-15 | 2021-07-17 |
| ANH_110_T. Van Someren-Rydon4_2021-07-15/2021-07-17 |     110 |        4 | 2021-07-15 | 2021-07-17 |
| ANH_110_T. Van Someren-Rydon5_2021-07-15/2021-07-17 |     110 |        5 | 2021-07-15 | 2021-07-17 |
| ANH_110_T. Van Someren-Rydon6_2021-07-15/2021-07-17 |     110 |        6 | 2021-07-15 | 2021-07-17 |
| ANH_110_T. Van Someren-Rydon1_2022-04-04/2022-04-06 |     110 |        1 | 2022-04-04 | 2022-04-06 |
| ANH_110_T. Van Someren-Rydon2_2022-04-04/2022-04-06 |     110 |        2 | 2022-04-04 | 2022-04-06 |
| ANH_110_T. Van Someren-Rydon3_2022-04-04/2022-04-06 |     110 |        3 | 2022-04-04 | 2022-04-06 |
| ANH_110_T. Van Someren-Rydon4_2022-04-04/2022-04-06 |     110 |        4 | 2022-04-04 | 2022-04-06 |
| ANH_110_T. Van Someren-Rydon5_2022-04-04/2022-04-06 |     110 |        5 | 2022-04-04 | 2022-04-06 |
| ANH_110_T. Van Someren-Rydon6_2022-04-04/2022-04-06 |     110 |        6 | 2022-04-04 | 2022-04-06 |
| ANH_112_T. Van Someren-Rydon1_2021-07-12/2021-07-14 |     112 |        1 | 2021-07-12 | 2021-07-14 |
| ANH_112_T. Van Someren-Rydon2_2021-07-12/2021-07-14 |     112 |        2 | 2021-07-12 | 2021-07-14 |
| ANH_112_T. Van Someren-Rydon3_2021-07-12/2021-07-14 |     112 |        3 | 2021-07-12 | 2021-07-14 |
| ANH_112_T. Van Someren-Rydon4_2021-07-12/2021-07-14 |     112 |        4 | 2021-07-12 | 2021-07-14 |
| ANH_112_T. Van Someren-Rydon5_2021-07-12/2021-07-14 |     112 |        5 | 2021-07-12 | 2021-07-14 |
| ANH_112_T. Van Someren-Rydon6_2021-07-12/2021-07-14 |     112 |        6 | 2021-07-12 | 2021-07-14 |
| ANH_112_T. Van Someren-Rydon1_2022-03-29/2022-03-31 |     112 |        1 | 2022-03-29 | 2022-03-31 |
| ANH_112_T. Van Someren-Rydon2_2022-03-29/2022-03-31 |     112 |        2 | 2022-03-29 | 2022-03-31 |
| ANH_112_T. Van Someren-Rydon3_2022-03-29/2022-03-31 |     112 |        3 | 2022-03-29 | 2022-03-31 |
| ANH_112_T. Van Someren-Rydon4_2022-03-29/2022-03-31 |     112 |        4 | 2022-03-29 | 2022-03-31 |
| ANH_112_T. Van Someren-Rydon5_2022-03-29/2022-03-31 |     112 |        5 | 2022-03-29 | 2022-03-31 |
| ANH_112_T. Van Someren-Rydon6_2022-03-29/2022-03-31 |     112 |        6 | 2022-03-29 | 2022-03-31 |
| ANH_113_T. Van Someren-Rydon1_2021-07-16/2021-07-18 |     113 |        1 | 2021-07-16 | 2021-07-18 |
| ANH_113_T. Van Someren-Rydon2_2021-07-16/2021-07-18 |     113 |        2 | 2021-07-16 | 2021-07-18 |
| ANH_113_T. Van Someren-Rydon3_2021-07-16/2021-07-18 |     113 |        3 | 2021-07-16 | 2021-07-18 |
| ANH_113_T. Van Someren-Rydon4_2021-07-16/2021-07-18 |     113 |        4 | 2021-07-16 | 2021-07-18 |
| ANH_113_T. Van Someren-Rydon5_2021-07-16/2021-07-18 |     113 |        5 | 2021-07-16 | 2021-07-18 |
| ANH_113_T. Van Someren-Rydon6_2021-07-16/2021-07-18 |     113 |        6 | 2021-07-16 | 2021-07-18 |
| ANH_113_T. Van Someren-Rydon1_2022-04-04/2022-04-06 |     113 |        1 | 2022-04-04 | 2022-04-06 |
| ANH_113_T. Van Someren-Rydon2_2022-04-04/2022-04-06 |     113 |        2 | 2022-04-04 | 2022-04-06 |
| ANH_113_T. Van Someren-Rydon3_2022-04-04/2022-04-06 |     113 |        3 | 2022-04-04 | 2022-04-06 |
| ANH_113_T. Van Someren-Rydon4_2022-04-04/2022-04-06 |     113 |        4 | 2022-04-04 | 2022-04-06 |
| ANH_113_T. Van Someren-Rydon5_2022-04-04/2022-04-06 |     113 |        5 | 2022-04-04 | 2022-04-06 |
| ANH_113_T. Van Someren-Rydon6_2022-04-04/2022-04-06 |     113 |        6 | 2022-04-04 | 2022-04-06 |
| ANH_114_T. Van Someren-Rydon1_2021-07-06/2021-07-08 |     114 |        1 | 2021-07-06 | 2021-07-08 |
| ANH_114_T. Van Someren-Rydon2_2021-07-06/2021-07-08 |     114 |        2 | 2021-07-06 | 2021-07-08 |
| ANH_114_T. Van Someren-Rydon3_2021-07-06/2021-07-08 |     114 |        3 | 2021-07-06 | 2021-07-08 |
| ANH_114_T. Van Someren-Rydon4_2021-07-06/2021-07-08 |     114 |        4 | 2021-07-06 | 2021-07-08 |
| ANH_114_T. Van Someren-Rydon5_2021-07-06/2021-07-08 |     114 |        5 | 2021-07-06 | 2021-07-08 |
| ANH_114_T. Van Someren-Rydon6_2021-07-06/2021-07-08 |     114 |        6 | 2021-07-06 | 2021-07-08 |
| ANH_114_T. Van Someren-Rydon1_2022-03-24/2022-03-26 |     114 |        1 | 2022-03-24 | 2022-03-26 |
| ANH_114_T. Van Someren-Rydon2_2022-03-24/2022-03-26 |     114 |        2 | 2022-03-24 | 2022-03-26 |
| ANH_114_T. Van Someren-Rydon3_2022-03-24/2022-03-26 |     114 |        3 | 2022-03-24 | 2022-03-26 |
| ANH_114_T. Van Someren-Rydon4_2022-03-24/2022-03-26 |     114 |        4 | 2022-03-24 | 2022-03-26 |
| ANH_114_T. Van Someren-Rydon5_2022-03-24/2022-03-26 |     114 |        5 | 2022-03-24 | 2022-03-26 |
| ANH_114_T. Van Someren-Rydon6_2022-03-24/2022-03-26 |     114 |        6 | 2022-03-24 | 2022-03-26 |
| ANH_115_T. Van Someren-Rydon1_2021-07-16/2021-07-18 |     115 |        1 | 2021-07-16 | 2021-07-18 |
| ANH_115_T. Van Someren-Rydon2_2021-07-16/2021-07-18 |     115 |        2 | 2021-07-16 | 2021-07-18 |
| ANH_115_T. Van Someren-Rydon3_2021-07-16/2021-07-18 |     115 |        3 | 2021-07-16 | 2021-07-18 |
| ANH_115_T. Van Someren-Rydon4_2021-07-16/2021-07-18 |     115 |        4 | 2021-07-16 | 2021-07-18 |
| ANH_115_T. Van Someren-Rydon5_2021-07-16/2021-07-18 |     115 |        5 | 2021-07-16 | 2021-07-18 |
| ANH_115_T. Van Someren-Rydon6_2021-07-16/2021-07-18 |     115 |        6 | 2021-07-16 | 2021-07-18 |
| ANH_115_T. Van Someren-Rydon1_2022-04-05/2022-04-07 |     115 |        1 | 2022-04-05 | 2022-04-07 |
| ANH_115_T. Van Someren-Rydon2_2022-04-05/2022-04-07 |     115 |        2 | 2022-04-05 | 2022-04-07 |
| ANH_115_T. Van Someren-Rydon3_2022-04-05/2022-04-07 |     115 |        3 | 2022-04-05 | 2022-04-07 |
| ANH_115_T. Van Someren-Rydon4_2022-04-05/2022-04-07 |     115 |        4 | 2022-04-05 | 2022-04-07 |
| ANH_115_T. Van Someren-Rydon5_2022-04-05/2022-04-07 |     115 |        5 | 2022-04-05 | 2022-04-07 |
| ANH_115_T. Van Someren-Rydon6_2022-04-05/2022-04-07 |     115 |        6 | 2022-04-05 | 2022-04-07 |
| ANH_116_T. Van Someren-Rydon1_2021-07-05/2021-07-07 |     116 |        1 | 2021-07-05 | 2021-07-07 |
| ANH_116_T. Van Someren-Rydon2_2021-07-05/2021-07-07 |     116 |        2 | 2021-07-05 | 2021-07-07 |
| ANH_116_T. Van Someren-Rydon3_2021-07-05/2021-07-07 |     116 |        3 | 2021-07-05 | 2021-07-07 |
| ANH_116_T. Van Someren-Rydon1_2022-03-22/2022-03-24 |     116 |        1 | 2022-03-22 | 2022-03-24 |
| ANH_116_T. Van Someren-Rydon2_2022-03-22/2022-03-24 |     116 |        2 | 2022-03-22 | 2022-03-24 |
| ANH_116_T. Van Someren-Rydon3_2022-03-22/2022-03-24 |     116 |        3 | 2022-03-22 | 2022-03-24 |
| ANH_116_T. Van Someren-Rydon4_2022-03-22/2022-03-24 |     116 |        4 | 2022-03-22 | 2022-03-24 |
| ANH_116_T. Van Someren-Rydon5_2022-03-22/2022-03-24 |     116 |        5 | 2022-03-22 | 2022-03-24 |
| ANH_116_T. Van Someren-Rydon6_2022-03-22/2022-03-24 |     116 |        6 | 2022-03-22 | 2022-03-24 |
| ANH_117_T. Van Someren-Rydon1_2021-07-06/2021-07-08 |     117 |        1 | 2021-07-06 | 2021-07-08 |
| ANH_117_T. Van Someren-Rydon2_2021-07-06/2021-07-08 |     117 |        2 | 2021-07-06 | 2021-07-08 |
| ANH_117_T. Van Someren-Rydon3_2021-07-06/2021-07-08 |     117 |        3 | 2021-07-06 | 2021-07-08 |
| ANH_117_T. Van Someren-Rydon4_2021-07-06/2021-07-08 |     117 |        4 | 2021-07-06 | 2021-07-08 |
| ANH_117_T. Van Someren-Rydon5_2021-07-06/2021-07-08 |     117 |        5 | 2021-07-06 | 2021-07-08 |
| ANH_117_T. Van Someren-Rydon6_2021-07-06/2021-07-08 |     117 |        6 | 2021-07-06 | 2021-07-08 |
| ANH_117_T. Van Someren-Rydon1_2022-03-24/2022-03-26 |     117 |        1 | 2022-03-24 | 2022-03-26 |

Displaying records 1 - 100

</div>

``` sql
WITH a AS(
SELECT 
  event_id,
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_T\. Van Someren-Rydon([0-9])_(202[12]-[0-9][0-9]-[0-9][0-9])/(202[12]-[0-9][0-9]-[0-9][0-9])$','\1')::int anh_num,
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_T\. Van Someren-Rydon([0-9])_(202[12]-[0-9][0-9]-[0-9][0-9])/(202[12]-[0-9][0-9]-[0-9][0-9])$','\2')::int trap_num,
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_T\. Van Someren-Rydon([0-9])_(202[12]-[0-9][0-9]-[0-9][0-9])/(202[12]-[0-9][0-9]-[0-9][0-9])$','\3')::date fecha1,
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_T\. Van Someren-Rydon([0-9])_(202[12]-[0-9][0-9]-[0-9][0-9])/(202[12]-[0-9][0-9]-[0-9][0-9])$','\4')::date fecha2
FROM raw_dwc.mariposas_event
ORDER BY anh_num, fecha1, trap_num
)
SELECT anh_num, EXTRACT(YEAR FROM fecha1) "year",ARRAY_AGG(trap_num),count(*)
FROM a
GROUP BY anh_num ,EXTRACT(YEAR FROM fecha1)
ORDER BY anh_num, EXTRACT(YEAR FROM fecha1),count(*)
```

<div class="knitsql-table">

| anh_num | year | array_agg     | count |
|--------:|-----:|:--------------|------:|
|     108 | 2021 | {1,2,3,4,5,6} |     6 |
|     108 | 2022 | {1,2,3,4,5,6} |     6 |
|     109 | 2021 | {1,2,3,4,5,6} |     6 |
|     109 | 2022 | {1,2,3,4,5,6} |     6 |
|     110 | 2021 | {1,2,3,4,5,6} |     6 |
|     110 | 2022 | {1,2,3,4,5,6} |     6 |
|     112 | 2021 | {1,2,3,4,5,6} |     6 |
|     112 | 2022 | {1,2,3,4,5,6} |     6 |
|     113 | 2021 | {1,2,3,4,5,6} |     6 |
|     113 | 2022 | {1,2,3,4,5,6} |     6 |
|     114 | 2021 | {1,2,3,4,5,6} |     6 |
|     114 | 2022 | {1,2,3,4,5,6} |     6 |
|     115 | 2021 | {1,2,3,4,5,6} |     6 |
|     115 | 2022 | {1,2,3,4,5,6} |     6 |
|     116 | 2021 | {1,2,3}       |     3 |
|     116 | 2022 | {1,2,3,4,5,6} |     6 |
|     117 | 2021 | {1,2,3,4,5,6} |     6 |
|     117 | 2022 | {1,2,3,4,5,6} |     6 |
|     118 | 2021 | {1,2,3,4,5,6} |     6 |
|     118 | 2022 | {1,2,3,4,5,6} |     6 |
|     120 | 2021 | {1,2,3,4,5,6} |     6 |
|     120 | 2022 | {1,2,3,4,5,6} |     6 |
|     121 | 2021 | {1,2,3,4,5,6} |     6 |
|     121 | 2022 | {1,2,3,4,5,6} |     6 |
|     122 | 2021 | {1,2,3,4,5,6} |     6 |
|     122 | 2022 | {1,2,3,4,5,6} |     6 |
|     123 | 2021 | {1,2,3,4,5,6} |     6 |
|     123 | 2022 | {1,2,3,4,5,6} |     6 |
|     125 | 2021 | {1,2,3,4,5,6} |     6 |
|     125 | 2022 | {1,2,3,4,5,6} |     6 |
|     130 | 2021 | {1,2,3,4,5,6} |     6 |
|     130 | 2022 | {1,2,3,4,5,6} |     6 |
|     131 | 2021 | {1,2,3,4,5,6} |     6 |
|     131 | 2022 | {1,2,3,4,5,6} |     6 |
|     132 | 2021 | {1,2,3,4,5,6} |     6 |
|     132 | 2022 | {1,2,3,4,5,6} |     6 |
|     133 | 2021 | {1,2,3,4,5,6} |     6 |
|     133 | 2022 | {1,2,3,4,5,6} |     6 |
|     134 | 2021 | {1,2,3,4,5,6} |     6 |
|     134 | 2022 | {1,2,3,4,5,6} |     6 |
|     135 | 2021 | {1,2,3,4,5,6} |     6 |
|     135 | 2022 | {1,2,3,4,5,6} |     6 |
|     136 | 2021 | {1,2,3,4,5,6} |     6 |
|     136 | 2022 | {1,2,3,4,5,6} |     6 |
|     137 | 2021 | {1,2,3,4,5,6} |     6 |
|     137 | 2022 | {1,2,3,4,5,6} |     6 |
|     138 | 2021 | {1,2,3,4,5,6} |     6 |
|     138 | 2022 | {1,2,3,4,5,6} |     6 |
|     142 | 2021 | {1,2,3,4,5,6} |     6 |
|     142 | 2022 | {1,2,3,4,5,6} |     6 |
|     144 | 2021 | {1,2,3,4,5,6} |     6 |
|     144 | 2022 | {1,2,3,4,5,6} |     6 |
|     145 | 2021 | {1,2,3,4,5,6} |     6 |
|     145 | 2022 | {1,2,3,4,5,6} |     6 |
|     147 | 2021 | {1,2,3,4,5,6} |     6 |
|     147 | 2022 | {1,2,3,4,5,6} |     6 |
|     365 | 2021 | {1,2,3,4,5,6} |     6 |
|     365 | 2022 | {1,2,3,4,5,6} |     6 |
|     366 | 2021 | {1,2,3,4,5,6} |     6 |
|     366 | 2022 | {1,2,3,4,5,6} |     6 |
|     368 | 2021 | {1,2,3,4,5,6} |     6 |
|     368 | 2022 | {1,2,3,4,5,6} |     6 |
|     369 | 2021 | {1,2,3,4,5,6} |     6 |
|     369 | 2022 | {1,2,3,4,5,6} |     6 |
|     370 | 2021 | {1,2,3,4,5,6} |     6 |
|     370 | 2022 | {1,2,3,4,5,6} |     6 |
|     371 | 2021 | {1,2,3,4,5,6} |     6 |
|     371 | 2022 | {1,2,3,4,5,6} |     6 |
|     372 | 2021 | {1,2,3,4,5,6} |     6 |
|     372 | 2022 | {1,2,3,4,5,6} |     6 |
|     373 | 2021 | {1,2,3,4,5,6} |     6 |
|     373 | 2022 | {1,2,3,4,5,6} |     6 |
|     374 | 2021 | {1,2,3,4,5,6} |     6 |
|     374 | 2022 | {1,2,3,4,5,6} |     6 |
|     391 | 2021 | {1,2,3,4,5,6} |     6 |
|     391 | 2022 | {1,2,3,4,5,6} |     6 |
|     392 | 2021 | {1,2,3,4,5,6} |     6 |
|     392 | 2022 | {1,2,3,4,5,6} |     6 |
|     394 | 2021 | {1,2,3,4,5,6} |     6 |
|     394 | 2022 | {1,2,3,4,5,6} |     6 |

80 records

</div>

Insertar los datos de anh:

``` sql
INSERT INTO main.punto_referencia(name_pt_ref, num_anh)
WITH a AS(
SELECT 
  event_id,
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_T\. Van Someren-Rydon([0-9])_(202[12]-[0-9][0-9]-[0-9][0-9])/(202[12]-[0-9][0-9]-[0-9][0-9])$','\1')::int anh_num,
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_T\. Van Someren-Rydon([0-9])_(202[12]-[0-9][0-9]-[0-9][0-9])/(202[12]-[0-9][0-9]-[0-9][0-9])$','\2')::int trap_num,
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_T\. Van Someren-Rydon([0-9])_(202[12]-[0-9][0-9]-[0-9][0-9])/(202[12]-[0-9][0-9]-[0-9][0-9])$','\3')::date fecha1,
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_T\. Van Someren-Rydon([0-9])_(202[12]-[0-9][0-9]-[0-9][0-9])/(202[12]-[0-9][0-9]-[0-9][0-9])$','\4')::date fecha2
FROM raw_dwc.mariposas_event
)
SELECT 'ANH_'||anh_num, anh_num
FROM a
GROUP BY anh_num
ORDER BY anh_num
ON CONFLICT (name_pt_ref) DO NOTHING
RETURNING cd_pt_ref
;
```

dar las referencias en las tablas de mariposas

``` sql
ALTER TABLE raw_dwc.mariposas_event ADD COLUMN cd_pt_ref int REFERENCES main.punto_referencia(cd_pt_ref) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE raw_dwc.mariposas_registros ADD COLUMN cd_pt_ref int REFERENCES main.punto_referencia(cd_pt_ref) ON DELETE SET NULL ON UPDATE CASCADE;

UPDATE raw_dwc.mariposas_event
SET cd_pt_ref=pr.cd_pt_ref
FROM main.punto_referencia pr
WHERE REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_T\. Van Someren-Rydon([0-9])_(202[12]-[0-9][0-9]-[0-9][0-9])/(202[12]-[0-9][0-9]-[0-9][0-9])$','\1')=pr.name_pt_ref
;

UPDATE raw_dwc.mariposas_registros
SET cd_pt_ref=pr.cd_pt_ref
FROM main.punto_referencia pr
WHERE REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_T\. Van Someren-Rydon([0-9])_(202[12]-[0-9][0-9]-[0-9][0-9])/(202[12]-[0-9][0-9]-[0-9][0-9])$','\1')=pr.name_pt_ref
;

SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

Averiguando que ninguna fila no tenga anh

``` sql
SELECT * FROM raw_dwc.mariposas_event WHERE cd_pt_ref IS NULL;
```

<div class="knitsql-table">

|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| row.names event_id parent_event_id sample_size_value sample_size_unit sampling_protocol sampling_effort event_date event_time event_remarks habitat location_remarks continent country country_code state_province county locality minimum_elevation_in_meters maximum_elevation_in_meters verbatim_latitude verbatim_longitude verbatim_coordinate_system verbatim_srs decimal_latitude decimal_longitude geodetic_datum coordinate_uncertainty_in_meters institution_code measurement_type\_*plataforma* measurement_value\_*plataforma* measurement_type\_*distancia* measurement_value\_*distancia* measurement_unit\_*distancia* title type format creator created measurement_type\_*habitat_homologado* measurement_value\_*habitat_homologado* measurement_type\_*datos_cobertura* measurement_value_datos_cobertura\_ measurement_type\_*temperatura* measurement_value_temperatura\_ measurement_unit\_*temperatura* measurement_type\_*humedad_relativa* measurement_value_humedad_relativa\_ measurement_unit\_*humedad_relativa* measurement_type\_*dap* measurement_value_dap\_ measurement_unit\_*dap* cd_pt_ref |

------------------------------------------------------------------------

: 0 records

</div>

``` sql
SELECT * FROM raw_dwc.mariposas_registros WHERE cd_pt_ref IS NULL;
```

<div class="knitsql-table">

|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| row.names occurrence_id event_id basis_of_record type institution_code collection_code catalog_number dynamic_properties record_number recorded_by organism_quantity organism_quantity_type sex life_stage preparations sampling_protocol sampling_effort event_date event_time habitat event_remarks identified_by date_identified identification_qualifier scientific_name kingdom phylum class order family subfamilia genus specific_epithet infraspecific_epithet taxon_rank scientific_name_authorship tipo_de_tejido preparación_del_tejido colector_del_tejido cd_pt_ref |

------------------------------------------------------------------------

: 0 records

</div>

## 4.2 Unit, sampling efforts definition, abundance definition, protocolo

No hay nuevas unidades, ni variables que añadir (vamos a utilizar
minutos para el tiempo de sampling effort), y ‘Duración’ para la
variable de sampling effort

``` sql
INSERT INTO main.def_protocol(protocol,protocol_spa,cd_var_samp_eff_1,cd_var_samp_eff_2,samp_eff_1_implicit,samp_eff_2_implicit,cd_var_ind_qt,description_spa)
VALUES(
  'VS-R trap',
  'Trampa VS-R',
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Elapsed time'),
  NULL,
  true,
  false,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind='Number of individuals'),
  'Trampa Van Someren-Rydon'
)
RETURNING cd_protocol,protocol,protocol_spa;
```

## 4.3 Personas

``` sql
INSERT INTO main.people(verbatim_person)
WITH a AS(
SELECT DISTINCT INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(recorded_by, ' | ')))) AS name_person
FROM raw_dwc.mariposas_registros
UNION
SELECT DISTINCT INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(identified_by, ' | '))))
FROM raw_dwc.mariposas_registros
)
SELECT DISTINCT REGEXP_REPLACE(name_person, '- ','-')
FROM a 
ORDER BY REGEXP_REPLACE(name_person, '- ','-')
ON CONFLICT(verbatim_person) DO NOTHING
RETURNING cd_person, verbatim_person
```

Dar los codigos a las tables de origen:

``` sql
ALTER TABLE raw_dwc.mariposas_registros ADD COLUMN cds_recorded_by int[];

WITH a AS(
SELECT "row.names", REGEXP_REPLACE(INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(recorded_by, ' | ')))),'- ','-') AS name_person
FROM raw_dwc.mariposas_registros
),b AS(
SELECT "row.names", ARRAY_AGG(cd_person) cds
FROM a 
LEFT JOIN main.people p ON a.name_person=p.verbatim_person
GROUP BY "row.names"
)
UPDATE raw_dwc.mariposas_registros AS r
SET cds_recorded_by=b.cds
FROM b
WHERE r."row.names"=b."row.names"
RETURNING r."row.names", cds_recorded_by
;

ALTER TABLE raw_dwc.mariposas_registros ADD COLUMN cds_identified_by int[];

WITH a AS(
SELECT "row.names", REGEXP_REPLACE(INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(identified_by, ' | ')))),'- ','-') AS name_person
FROM raw_dwc.mariposas_registros
),b AS(
SELECT "row.names", ARRAY_AGG(cd_person) cds
FROM a 
LEFT JOIN main.people p ON a.name_person=p.verbatim_person
GROUP BY "row.names"
)
UPDATE raw_dwc.mariposas_registros AS r
SET cds_identified_by=b.cds
FROM b
WHERE r."row.names"=b."row.names"
RETURNING r."row.names", cds_identified_by
;

SELECT 1;
```

<div class="knitsql-table">

| ?column? |
|---------:|
|        1 |

1 records

</div>

## 4.4 gp_event

``` sql
WITH a AS(
SELECT 
  event_id,
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_T\. Van Someren-Rydon([0-9])_(202[12]-[0-9][0-9]-[0-9][0-9])/(202[12]-[0-9][0-9]-[0-9][0-9])$','\1')::int anh_num,
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_T\. Van Someren-Rydon([0-9])_(202[12]-[0-9][0-9]-[0-9][0-9])/(202[12]-[0-9][0-9]-[0-9][0-9])$','\2')::int trap_num,
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_T\. Van Someren-Rydon([0-9])_(202[12]-[0-9][0-9]-[0-9][0-9])/(202[12]-[0-9][0-9]-[0-9][0-9])$','\3')::date fecha1,
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_T\. Van Someren-Rydon([0-9])_(202[12]-[0-9][0-9]-[0-9][0-9])/(202[12]-[0-9][0-9]-[0-9][0-9])$','\4')::date fecha2
FROM raw_dwc.mariposas_event
ORDER BY anh_num, fecha1, trap_num
)
SELECT EXTRACT(YEAR FROM fecha1), anh_num, ARRAY_AGG(trap_num), count(*)
FROM a
GROUP BY EXTRACT(YEAR FROM fecha1), anh_num
ORDER BY EXTRACT(YEAR FROM fecha1), anh_num
;
```

<div class="knitsql-table">

| date_part | anh_num | array_agg     | count |
|----------:|--------:|:--------------|------:|
|      2021 |     108 | {1,2,3,4,5,6} |     6 |
|      2021 |     109 | {1,2,3,4,5,6} |     6 |
|      2021 |     110 | {1,2,3,4,5,6} |     6 |
|      2021 |     112 | {1,2,3,4,5,6} |     6 |
|      2021 |     113 | {1,2,3,4,5,6} |     6 |
|      2021 |     114 | {1,2,3,4,5,6} |     6 |
|      2021 |     115 | {1,2,3,4,5,6} |     6 |
|      2021 |     116 | {1,2,3}       |     3 |
|      2021 |     117 | {1,2,3,4,5,6} |     6 |
|      2021 |     118 | {1,2,3,4,5,6} |     6 |
|      2021 |     120 | {1,2,3,4,5,6} |     6 |
|      2021 |     121 | {1,2,3,4,5,6} |     6 |
|      2021 |     122 | {1,2,3,4,5,6} |     6 |
|      2021 |     123 | {1,2,3,4,5,6} |     6 |
|      2021 |     125 | {1,2,3,4,5,6} |     6 |
|      2021 |     130 | {1,2,3,4,5,6} |     6 |
|      2021 |     131 | {1,2,3,4,5,6} |     6 |
|      2021 |     132 | {1,2,3,4,5,6} |     6 |
|      2021 |     133 | {1,2,3,4,5,6} |     6 |
|      2021 |     134 | {1,2,3,4,5,6} |     6 |
|      2021 |     135 | {1,2,3,4,5,6} |     6 |
|      2021 |     136 | {1,2,3,4,5,6} |     6 |
|      2021 |     137 | {1,2,3,4,5,6} |     6 |
|      2021 |     138 | {1,2,3,4,5,6} |     6 |
|      2021 |     142 | {1,2,3,4,5,6} |     6 |
|      2021 |     144 | {1,2,3,4,5,6} |     6 |
|      2021 |     145 | {1,2,3,4,5,6} |     6 |
|      2021 |     147 | {1,2,3,4,5,6} |     6 |
|      2021 |     365 | {1,2,3,4,5,6} |     6 |
|      2021 |     366 | {1,2,3,4,5,6} |     6 |
|      2021 |     368 | {1,2,3,4,5,6} |     6 |
|      2021 |     369 | {1,2,3,4,5,6} |     6 |
|      2021 |     370 | {1,2,3,4,5,6} |     6 |
|      2021 |     371 | {1,2,3,4,5,6} |     6 |
|      2021 |     372 | {1,2,3,4,5,6} |     6 |
|      2021 |     373 | {1,2,3,4,5,6} |     6 |
|      2021 |     374 | {1,2,3,4,5,6} |     6 |
|      2021 |     391 | {1,2,3,4,5,6} |     6 |
|      2021 |     392 | {1,2,3,4,5,6} |     6 |
|      2021 |     394 | {1,2,3,4,5,6} |     6 |
|      2022 |     108 | {1,2,3,4,5,6} |     6 |
|      2022 |     109 | {1,2,3,4,5,6} |     6 |
|      2022 |     110 | {1,2,3,4,5,6} |     6 |
|      2022 |     112 | {1,2,3,4,5,6} |     6 |
|      2022 |     113 | {1,2,3,4,5,6} |     6 |
|      2022 |     114 | {1,2,3,4,5,6} |     6 |
|      2022 |     115 | {1,2,3,4,5,6} |     6 |
|      2022 |     116 | {1,2,3,4,5,6} |     6 |
|      2022 |     117 | {1,2,3,4,5,6} |     6 |
|      2022 |     118 | {1,2,3,4,5,6} |     6 |
|      2022 |     120 | {1,2,3,4,5,6} |     6 |
|      2022 |     121 | {1,2,3,4,5,6} |     6 |
|      2022 |     122 | {1,2,3,4,5,6} |     6 |
|      2022 |     123 | {1,2,3,4,5,6} |     6 |
|      2022 |     125 | {1,2,3,4,5,6} |     6 |
|      2022 |     130 | {1,2,3,4,5,6} |     6 |
|      2022 |     131 | {1,2,3,4,5,6} |     6 |
|      2022 |     132 | {1,2,3,4,5,6} |     6 |
|      2022 |     133 | {1,2,3,4,5,6} |     6 |
|      2022 |     134 | {1,2,3,4,5,6} |     6 |
|      2022 |     135 | {1,2,3,4,5,6} |     6 |
|      2022 |     136 | {1,2,3,4,5,6} |     6 |
|      2022 |     137 | {1,2,3,4,5,6} |     6 |
|      2022 |     138 | {1,2,3,4,5,6} |     6 |
|      2022 |     142 | {1,2,3,4,5,6} |     6 |
|      2022 |     144 | {1,2,3,4,5,6} |     6 |
|      2022 |     145 | {1,2,3,4,5,6} |     6 |
|      2022 |     147 | {1,2,3,4,5,6} |     6 |
|      2022 |     365 | {1,2,3,4,5,6} |     6 |
|      2022 |     366 | {1,2,3,4,5,6} |     6 |
|      2022 |     368 | {1,2,3,4,5,6} |     6 |
|      2022 |     369 | {1,2,3,4,5,6} |     6 |
|      2022 |     370 | {1,2,3,4,5,6} |     6 |
|      2022 |     371 | {1,2,3,4,5,6} |     6 |
|      2022 |     372 | {1,2,3,4,5,6} |     6 |
|      2022 |     373 | {1,2,3,4,5,6} |     6 |
|      2022 |     374 | {1,2,3,4,5,6} |     6 |
|      2022 |     391 | {1,2,3,4,5,6} |     6 |
|      2022 |     392 | {1,2,3,4,5,6} |     6 |
|      2022 |     394 | {1,2,3,4,5,6} |     6 |

80 records

</div>

``` sql
INSERT INTO main.gp_event(cd_gp_biol,cd_protocol,cd_pt_ref,campaign_nb)
WITH a AS(
SELECT 
  event_id,
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_T\. Van Someren-Rydon([0-9])_(202[12]-[0-9][0-9]-[0-9][0-9])/(202[12]-[0-9][0-9]-[0-9][0-9])$','\1')::int anh_num,
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_T\. Van Someren-Rydon([0-9])_(202[12]-[0-9][0-9]-[0-9][0-9])/(202[12]-[0-9][0-9]-[0-9][0-9])$','\2')::int trap_num,
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_T\. Van Someren-Rydon([0-9])_(202[12]-[0-9][0-9]-[0-9][0-9])/(202[12]-[0-9][0-9]-[0-9][0-9])$','\3')::date fecha1,
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_T\. Van Someren-Rydon([0-9])_(202[12]-[0-9][0-9]-[0-9][0-9])/(202[12]-[0-9][0-9]-[0-9][0-9])$','\4')::date fecha2,
  cd_pt_ref
FROM raw_dwc.mariposas_event
ORDER BY anh_num, fecha1, trap_num
), b AS(
SELECT EXTRACT(YEAR FROM fecha1) año, anh_num, cd_pt_ref, ARRAY_AGG(trap_num), count(*)
FROM a
GROUP BY año, anh_num, cd_pt_ref
ORDER BY año, cd_pt_ref
)
SELECT 'mari', (SELECT cd_protocol FROM main.def_protocol WHERE protocol='VS-R trap'),cd_pt_ref, ROW_NUMBER() OVER (PARTITION BY cd_pt_ref  ORDER BY año) num_gp
FROM b
JOIN main.punto_referencia USING (cd_pt_ref)
GROUP BY cd_pt_ref, name_pt_ref, año
ORDER BY año,cd_pt_ref
RETURNING cd_gp_event,cd_gp_biol,cd_protocol,cd_pt_ref,campaign_nb
;
```

Attributing the gp_event

``` sql
ALTER TABLE raw_dwc.mariposas_event ADD COLUMN cd_gp_event int REFERENCES main.gp_event(cd_gp_event) ON DELETE SET NULL;

WITH a AS(
SELECT 
  event_id,
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_T\. Van Someren-Rydon([0-9])_(202[12]-[0-9][0-9]-[0-9][0-9])/(202[12]-[0-9][0-9]-[0-9][0-9])$','\1')::int anh_num,
  EXTRACT (YEAR FROM REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_T\. Van Someren-Rydon([0-9])_(202[12]-[0-9][0-9]-[0-9][0-9])/(202[12]-[0-9][0-9]-[0-9][0-9])$','\3')::date) año,
  cd_pt_ref
FROM raw_dwc.mariposas_event
ORDER BY anh_num, año
), b AS(
SELECT año, anh_num, cd_pt_ref, count(*)
FROM a
GROUP BY año, anh_num, cd_pt_ref
ORDER BY año, cd_pt_ref
),c AS(
SELECT cd_pt_ref, año, ROW_NUMBER() OVER (PARTITION BY cd_pt_ref  ORDER BY año) num_gp
FROM b
JOIN main.punto_referencia USING (cd_pt_ref)
GROUP BY cd_pt_ref, name_pt_ref, año
ORDER BY año,cd_pt_ref
), d AS(
SELECT event_id, cd_gp_event
FROM a
LEFT JOIN b USING (cd_pt_ref,año)
LEFT JOIN c USING (cd_pt_ref,año)
LEFT JOIN main.gp_event e ON e.cd_gp_biol='mari' AND e.campaign_nb=c.num_gp AND c.cd_pt_ref=e.cd_pt_ref
)
UPDATE raw_dwc.mariposas_event e
SET cd_gp_event=d.cd_gp_event
FROM d
WHERE d.event_id=e.event_id
RETURNING e.event_id, e.cd_gp_event
;
```

<div class="knitsql-table">

| event_id                                            | cd_gp_event |
|:----------------------------------------------------|------------:|
| ANH_109_T. Van Someren-Rydon2_2021-07-15/2021-07-17 |          90 |
| ANH_109_T. Van Someren-Rydon6_2021-07-15/2021-07-17 |          90 |
| ANH_109_T. Van Someren-Rydon5_2021-07-15/2021-07-17 |          90 |
| ANH_109_T. Van Someren-Rydon4_2021-07-15/2021-07-17 |          90 |
| ANH_109_T. Van Someren-Rydon3_2021-07-15/2021-07-17 |          90 |
| ANH_109_T. Van Someren-Rydon1_2021-07-15/2021-07-17 |          90 |
| ANH_117_T. Van Someren-Rydon3_2021-07-06/2021-07-08 |          91 |
| ANH_117_T. Van Someren-Rydon2_2021-07-06/2021-07-08 |          91 |
| ANH_117_T. Van Someren-Rydon6_2021-07-06/2021-07-08 |          91 |
| ANH_117_T. Van Someren-Rydon1_2021-07-06/2021-07-08 |          91 |
| ANH_117_T. Van Someren-Rydon5_2021-07-06/2021-07-08 |          91 |
| ANH_117_T. Van Someren-Rydon4_2021-07-06/2021-07-08 |          91 |
| ANH_133_T. Van Someren-Rydon4_2021-07-05/2021-07-07 |          92 |
| ANH_133_T. Van Someren-Rydon5_2021-07-05/2021-07-07 |          92 |
| ANH_133_T. Van Someren-Rydon6_2021-07-05/2021-07-07 |          92 |
| ANH_133_T. Van Someren-Rydon2_2021-07-05/2021-07-07 |          92 |
| ANH_133_T. Van Someren-Rydon1_2021-07-05/2021-07-07 |          92 |
| ANH_133_T. Van Someren-Rydon3_2021-07-05/2021-07-07 |          92 |
| ANH_135_T. Van Someren-Rydon3_2021-07-01/2021-07-03 |          93 |
| ANH_135_T. Van Someren-Rydon4_2021-07-01/2021-07-03 |          93 |
| ANH_135_T. Van Someren-Rydon2_2021-07-01/2021-07-03 |          93 |
| ANH_135_T. Van Someren-Rydon1_2021-07-01/2021-07-03 |          93 |
| ANH_135_T. Van Someren-Rydon6_2021-07-01/2021-07-03 |          93 |
| ANH_135_T. Van Someren-Rydon5_2021-07-01/2021-07-03 |          93 |
| ANH_136_T. Van Someren-Rydon5_2021-07-01/2021-07-03 |          94 |
| ANH_136_T. Van Someren-Rydon6_2021-07-01/2021-07-03 |          94 |
| ANH_136_T. Van Someren-Rydon3_2021-07-01/2021-07-03 |          94 |
| ANH_136_T. Van Someren-Rydon2_2021-07-01/2021-07-03 |          94 |
| ANH_136_T. Van Someren-Rydon1_2021-07-01/2021-07-03 |          94 |
| ANH_136_T. Van Someren-Rydon4_2021-07-01/2021-07-03 |          94 |
| ANH_374_T. Van Someren-Rydon5_2021-07-19/2021-07-21 |          95 |
| ANH_374_T. Van Someren-Rydon4_2021-07-19/2021-07-21 |          95 |
| ANH_374_T. Van Someren-Rydon2_2021-07-19/2021-07-21 |          95 |
| ANH_374_T. Van Someren-Rydon6_2021-07-19/2021-07-21 |          95 |
| ANH_374_T. Van Someren-Rydon1_2021-07-19/2021-07-21 |          95 |
| ANH_374_T. Van Someren-Rydon3_2021-07-19/2021-07-21 |          95 |
| ANH_108_T. Van Someren-Rydon2_2021-07-13/2021-07-15 |          96 |
| ANH_108_T. Van Someren-Rydon1_2021-07-13/2021-07-15 |          96 |
| ANH_108_T. Van Someren-Rydon6_2021-07-13/2021-07-15 |          96 |
| ANH_108_T. Van Someren-Rydon4_2021-07-13/2021-07-15 |          96 |
| ANH_108_T. Van Someren-Rydon3_2021-07-13/2021-07-15 |          96 |
| ANH_108_T. Van Someren-Rydon5_2021-07-13/2021-07-15 |          96 |
| ANH_110_T. Van Someren-Rydon4_2021-07-15/2021-07-17 |          97 |
| ANH_110_T. Van Someren-Rydon2_2021-07-15/2021-07-17 |          97 |
| ANH_110_T. Van Someren-Rydon1_2021-07-15/2021-07-17 |          97 |
| ANH_110_T. Van Someren-Rydon3_2021-07-15/2021-07-17 |          97 |
| ANH_110_T. Van Someren-Rydon5_2021-07-15/2021-07-17 |          97 |
| ANH_110_T. Van Someren-Rydon6_2021-07-15/2021-07-17 |          97 |
| ANH_112_T. Van Someren-Rydon1_2021-07-12/2021-07-14 |          98 |
| ANH_112_T. Van Someren-Rydon6_2021-07-12/2021-07-14 |          98 |
| ANH_112_T. Van Someren-Rydon5_2021-07-12/2021-07-14 |          98 |
| ANH_112_T. Van Someren-Rydon4_2021-07-12/2021-07-14 |          98 |
| ANH_112_T. Van Someren-Rydon3_2021-07-12/2021-07-14 |          98 |
| ANH_112_T. Van Someren-Rydon2_2021-07-12/2021-07-14 |          98 |
| ANH_113_T. Van Someren-Rydon5_2021-07-16/2021-07-18 |          99 |
| ANH_113_T. Van Someren-Rydon4_2021-07-16/2021-07-18 |          99 |
| ANH_113_T. Van Someren-Rydon3_2021-07-16/2021-07-18 |          99 |
| ANH_113_T. Van Someren-Rydon2_2021-07-16/2021-07-18 |          99 |
| ANH_113_T. Van Someren-Rydon1_2021-07-16/2021-07-18 |          99 |
| ANH_113_T. Van Someren-Rydon6_2021-07-16/2021-07-18 |          99 |
| ANH_114_T. Van Someren-Rydon1_2021-07-06/2021-07-08 |         100 |
| ANH_114_T. Van Someren-Rydon2_2021-07-06/2021-07-08 |         100 |
| ANH_114_T. Van Someren-Rydon3_2021-07-06/2021-07-08 |         100 |
| ANH_114_T. Van Someren-Rydon4_2021-07-06/2021-07-08 |         100 |
| ANH_114_T. Van Someren-Rydon5_2021-07-06/2021-07-08 |         100 |
| ANH_114_T. Van Someren-Rydon6_2021-07-06/2021-07-08 |         100 |
| ANH_115_T. Van Someren-Rydon5_2021-07-16/2021-07-18 |         101 |
| ANH_115_T. Van Someren-Rydon6_2021-07-16/2021-07-18 |         101 |
| ANH_115_T. Van Someren-Rydon1_2021-07-16/2021-07-18 |         101 |
| ANH_115_T. Van Someren-Rydon2_2021-07-16/2021-07-18 |         101 |
| ANH_115_T. Van Someren-Rydon3_2021-07-16/2021-07-18 |         101 |
| ANH_115_T. Van Someren-Rydon4_2021-07-16/2021-07-18 |         101 |
| ANH_116_T. Van Someren-Rydon2_2021-07-05/2021-07-07 |         102 |
| ANH_116_T. Van Someren-Rydon1_2021-07-05/2021-07-07 |         102 |
| ANH_116_T. Van Someren-Rydon3_2021-07-05/2021-07-07 |         102 |
| ANH_118_T. Van Someren-Rydon3_2021-07-15/2021-07-17 |         103 |
| ANH_118_T. Van Someren-Rydon4_2021-07-15/2021-07-17 |         103 |
| ANH_118_T. Van Someren-Rydon5_2021-07-15/2021-07-17 |         103 |
| ANH_118_T. Van Someren-Rydon6_2021-07-15/2021-07-17 |         103 |
| ANH_118_T. Van Someren-Rydon2_2021-07-15/2021-07-17 |         103 |
| ANH_118_T. Van Someren-Rydon1_2021-07-15/2021-07-17 |         103 |
| ANH_120_T. Van Someren-Rydon1_2021-07-16/2021-07-18 |         104 |
| ANH_120_T. Van Someren-Rydon6_2021-07-16/2021-07-18 |         104 |
| ANH_120_T. Van Someren-Rydon5_2021-07-16/2021-07-18 |         104 |
| ANH_120_T. Van Someren-Rydon4_2021-07-16/2021-07-18 |         104 |
| ANH_120_T. Van Someren-Rydon3_2021-07-16/2021-07-18 |         104 |
| ANH_120_T. Van Someren-Rydon2_2021-07-16/2021-07-18 |         104 |
| ANH_121_T. Van Someren-Rydon6_2021-07-22/2021-07-24 |         105 |
| ANH_121_T. Van Someren-Rydon5_2021-07-22/2021-07-24 |         105 |
| ANH_121_T. Van Someren-Rydon1_2021-07-22/2021-07-24 |         105 |
| ANH_121_T. Van Someren-Rydon2_2021-07-22/2021-07-24 |         105 |
| ANH_121_T. Van Someren-Rydon3_2021-07-22/2021-07-24 |         105 |
| ANH_121_T. Van Someren-Rydon4_2021-07-22/2021-07-24 |         105 |
| ANH_122_T. Van Someren-Rydon5_2021-07-15/2021-07-17 |         106 |
| ANH_122_T. Van Someren-Rydon4_2021-07-15/2021-07-17 |         106 |
| ANH_122_T. Van Someren-Rydon3_2021-07-15/2021-07-17 |         106 |
| ANH_122_T. Van Someren-Rydon1_2021-07-15/2021-07-17 |         106 |
| ANH_122_T. Van Someren-Rydon2_2021-07-15/2021-07-17 |         106 |
| ANH_122_T. Van Someren-Rydon6_2021-07-15/2021-07-17 |         106 |
| ANH_123_T. Van Someren-Rydon2_2021-07-02/2021-07-04 |         107 |

Displaying records 1 - 100

</div>

## 4.5 event

2.  pb de formato en las horas

``` sql
INSERT INTO main.event(cd_gp_event,event_id,num_replicate, description_replicate, date_time_begin, date_time_end, locality_verb, event_remarks, pt_geom)
WITH a AS(
SELECT cd_gp_event,
  event_id, 
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_T\. Van Someren-Rydon([0-9])_(202[12]-[0-9][0-9]-[0-9][0-9])/(202[12]-[0-9][0-9]-[0-9][0-9])$','\2')::int num_replicate,
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_(T\. Van Someren-Rydon[0-9]_202[12]-[0-9][0-9]-[0-9][0-9]/202[12]-[0-9][0-9]-[0-9][0-9])$','\2') description_replicate,
  event_date,
  TO_DATE(SPLIT_PART(event_date,'/',1), 'YYYY-MM-DD') date_1,
  TO_DATE(SPLIT_PART(event_date,'/',2), 'YYYY-MM-DD') date_2,
  REGEXP_REPLACE(REGEXP_REPLACE(SPLIT_PART(event_time,'/',1),'\s+','','g'),'[^0-9]+$','') hora_1,
  CASE
    WHEN REGEXP_REPLACE(SPLIT_PART(event_time,'/',2),'\s+','','g')='' THEN NULL
    ELSE REGEXP_REPLACE(SPLIT_PART(event_time,'/',2),'\s+','','g')
  END hora_2,
  locality locality_verb,
  sample_size_value,
  -- event_remarks, -- concierne unas modificaciones que vamos a hacer en la proxima etapa, o la ausencia de registro que se puede determinar automaticamente
  location_remarks,
  decimal_latitude::double precision,
  decimal_longitude::double precision
FROM raw_dwc.mariposas_event
)
SELECT 
  cd_gp_event,
  event_id, 
  num_replicate,
  description_replicate,
  CASE
    --WHEN hora_1 IS NULL THEN ("date_1"||' '||'10:12:00')::timestamp
    WHEN hora_1 IS NULL THEN NULL::timestamp
    ELSE ("date_1"||' '||hora_1)::timestamp
  END date_time_begin,
  CASE
        --WHEN hora_1 IS NULL AND hora_2 IS NULL THEN (("date_1"||' '||'10:12:00')::timestamp + '48 hours')
    --WHEN hora_2 IS NULL THEN (("date_1"||' '||hora_1)::timestamp + '48 hours')
    WHEN hora_2 IS NULL THEN NULL
    ELSE ("date_2"||' '||hora_2)::timestamp
  END date_time_end,
  locality_verb,
  location_remarks event_remarks,
  /*CASE
    WHEN hora_1 IS NULL AND hora_2 IS NULL THEN location_remarks||'| La hora inicial no estaba disponible se pusó la hora promedia: 10:12, la hora final se pusó 48h después'
    WHEN hora_2 IS NULL THEN location_remarks||'| La hora final no estaba disponible, se pusó 48 horas despues de la hora inicial'
    ELSE location_remarks
  END event_remarks,*/
  ST_SetSRID(ST_Transform(ST_SetSRID(ST_MakePoint(decimal_longitude,decimal_latitude),4326), (SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)),3116)
FROM a
RETURNING main.event.cd_event, main.event.cd_gp_event, main.event.event_id, main.event.num_replicate, main.event.description_replicate, main.event.date_time_begin, main.event.date_time_end, main.event.locality_verb, main.event.event_remarks, main.event.pt_geom
```

Damos los cd_event a todos las filas:

``` sql
ALTER TABLE raw_dwc.mariposas_event ADD COLUMN cd_event int REFERENCES main.event(cd_event) ON DELETE SET NULL;
ALTER TABLE raw_dwc.mariposas_registros ADD COLUMN cd_event int REFERENCES main.event(cd_event);

UPDATE raw_dwc.mariposas_event AS t
SET cd_event=e.cd_event
FROM main.event e
WHERE t.event_id=e.event_id;

UPDATE raw_dwc.mariposas_registros AS t
SET cd_event=e.cd_event
FROM main.event e
WHERE t.event_id=e.event_id;

SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

Añadir fechas en la tabla extra cuando las horas no son disponibles

``` sql
INSERT INTO main.def_var_event_extra(var_event_extra, type_var, var_event_extra_spa, var_event_extra_comment)
VALUES
  ('date_begin',
  'free text',
  'fecha_inicial',
  'This variable exists when the time associated with the beginning of the event does not exists (timestamp is null then). Note that the date is given as text and has to be transformed to be uses as date. format is YYYY-MM_DD'
  ),(
  'date_end',
  'free text',
  'fecha_final',
  'This variable exists when either the time or date associated with the end of the event is not available (timestamp is null then). Note that the date is given as text. format is YYYY-MM-DD'
  );

INSERT INTO main.event_extra(cd_event, cd_var_event_extra,value_text)
WITH a AS(
SELECT cd_event,ef.date_time_begin,ef.date_time_end,
  TO_DATE(SPLIT_PART(event_date,'/',1), 'YYYY-MM-DD') date_1,
  TO_DATE(SPLIT_PART(event_date,'/',2), 'YYYY-MM-DD') date_2
FROM raw_dwc.mariposas_event e
LEFT JOIN main.event ef USING (cd_event)
WHERE date_time_begin IS NULL OR date_time_end IS NULL
),b AS(
SELECT cd_event,
  CASE
   WHEN date_time_begin IS NULL THEN date_1
   ELSE NULL
  END date_begin
FROM a
)
SELECT 
 cd_event,
 (SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin'),
 to_char(date_begin,'yyyy-mm-dd')::text
FROM b
WHERE date_begin IS NOT NULL
RETURNING main.event_extra.cd_event, main.event_extra.cd_var_event_extra, main.event_extra.value_text
;
INSERT INTO main.event_extra(cd_event, cd_var_event_extra,value_text)
WITH a AS(
SELECT cd_event,ef.date_time_begin,ef.date_time_end,
  TO_DATE(SPLIT_PART(event_date,'/',1), 'YYYY-MM-DD') date_1,
  TO_DATE(SPLIT_PART(event_date,'/',2), 'YYYY-MM-DD') date_2
FROM raw_dwc.mariposas_event e
LEFT JOIN main.event ef USING (cd_event)
WHERE date_time_begin IS NULL OR date_time_end IS NULL
),b AS(
SELECT cd_event,
  CASE
   WHEN date_time_end IS NULL THEN date_2
   ELSE NULL
  END date_end
FROM a
)
SELECT 
 cd_event,
 (SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_end'),
 to_char(date_end,'yyyy-mm-dd')::text
FROM b
WHERE date_end IS NOT NULL
RETURNING main.event_extra.cd_event, main.event_extra.cd_var_event_extra, main.event_extra.value_text
;
```

## 4.6 registros

``` sql
SELECT occurrence_id, count(*)
FROM raw_dwc.mariposas_registros 
GROUP BY occurrence_id
HAVING count(*)>1;
```

<div class="knitsql-table">

occurrence_id count ————— ——-

: 0 records

</div>

``` sql

INSERT INTO main.registros(cd_event, cds_recorded_by, date_time, cd_tax, cd_morfo, date_ident, cds_identified_by, qt_int,remarks, occurrence_id, organism_id)
SELECT 
 cd_event,
 cds_recorded_by,
 (e.date_time_begin::date||' '||event_time)::timestamp date_time,
 tt.cd_tax,
 tt.cd_morfo,
 TO_DATE(date_identified,'YYYY-MM-DD') date_ident,
 cds_identified_by,
 organism_quantity::double precision::int qt_int,
 r.event_remarks,
 occurrence_id,
 SPLIT_PART(occurrence_id,':',7) organism_id
 --ROW_NUMBER() OVER (ORDER BY (e.date_time_begin::date||' '||event_time)::timestamp)
 --organism_id::text
FROM raw_dwc.mariposas_registros r
LEFT JOIN raw_dwc.taxonomy_total tt ON tt."row.names"=r."row.names" AND tt.table_orig='mariposas_registros'
LEFT JOIN main.event e USING (cd_event)
ORDER BY date_time
RETURNING cd_event, cds_recorded_by, date_time, cd_tax, cd_morfo, cds_identified_by, qt_int,remarks, occurrence_id, organism_id
```

``` sql
ALTER TABLE raw_dwc.mariposas_registros ADD COLUMN cd_reg int REFERENCES main.registros(cd_reg);
UPDATE raw_dwc.mariposas_registros AS ar
SET cd_reg=r.cd_reg
FROM main.registros r
WHERE ar.cd_event=r.cd_event AND ar.occurrence_id=r.occurrence_id;

-- Check cd_reg are unique in the source table
SELECT cd_reg,count(*) FROM  raw_dwc.mariposas_registros GROUP BY cd_reg HAVING count(*)>1;
```

<div class="knitsql-table">

    cd_reg   count

------------------------------------------------------------------------

: 0 records

</div>

# 5 Hormigas

Para entender el plan de muestreo:

``` sql
WITH a AS(
SELECT event_id,
 REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_((Captura manual)|(Pitfall)|(Trampa de caída atún)|(Winkler))([0-9]{1,2})_(202[12])-[0-9][0-9]-[0-9][0-9](/202[12]-[0-9][0-9]-[0-9][0-9])?','\1')::int anh_num,
 REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_((Captura manual)|(Pitfall)|(Trampa de caída atún)|(Winkler))([0-9]{1,2})_(202[12])-[0-9][0-9]-[0-9][0-9](/202[12]-[0-9][0-9]-[0-9][0-9])?','\2') metodo,
 REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_((Captura manual)|(Pitfall)|(Trampa de caída atún)|(Winkler))([0-9]{1,2})_(202[12])-[0-9][0-9]-[0-9][0-9](/202[12]-[0-9][0-9]-[0-9][0-9])?','\7')::int repli,
 REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_((Captura manual)|(Pitfall)|(Trampa de caída atún)|(Winkler))([0-9]{1,2})_(202[12])-[0-9][0-9]-[0-9][0-9](/202[12]-[0-9][0-9]-[0-9][0-9])?','\8') año
FROM raw_dwc.hormigas_event
)
SELECT anh_num, año, metodo, ARRAY_AGG(repli ORDER BY repli) repli, count(*)
FROM a
GROUP BY anh_num, año, metodo
ORDER BY anh_num, año, metodo
;
```

<div class="knitsql-table">

| anh_num | año  | metodo               | repli                  | count |
|--------:|:-----|:---------------------|:-----------------------|------:|
|     108 | 2021 | Captura manual       | {1,2,3,4,5,6,7,8,9,10} |    10 |
|     108 | 2021 | Pitfall              | {1,2,3,4,5}            |     5 |
|     108 | 2021 | Trampa de caída atún | {1,2,3,4,5}            |     5 |
|     108 | 2021 | Winkler              | {1,2,3,4,5}            |     5 |
|     108 | 2022 | Captura manual       | {1,2,3,4,5,6,7,8,9,10} |    10 |
|     108 | 2022 | Pitfall              | {1,2,3,4,5}            |     5 |
|     108 | 2022 | Trampa de caída atún | {1,2,3,4,5}            |     5 |
|     108 | 2022 | Winkler              | {1,2,3,4,5}            |     5 |
|     109 | 2021 | Captura manual       | {1,2,3,4,5,6,7,8,9,10} |    10 |
|     109 | 2021 | Pitfall              | {1,2,3,4,5}            |     5 |
|     109 | 2021 | Trampa de caída atún | {1,2,3,4,5}            |     5 |
|     109 | 2021 | Winkler              | {1,2,3,4,5}            |     5 |
|     109 | 2022 | Captura manual       | {1,2,3,4,5,6,7,8,9,10} |    10 |
|     109 | 2022 | Pitfall              | {1,2,3,4,5}            |     5 |
|     109 | 2022 | Trampa de caída atún | {1,2,3,4,5}            |     5 |
|     109 | 2022 | Winkler              | {1,2,3,4,5}            |     5 |
|     110 | 2021 | Captura manual       | {1,2,3,4,5,6,7,8,9,10} |    10 |
|     110 | 2021 | Pitfall              | {1,2,3,4,5}            |     5 |
|     110 | 2021 | Trampa de caída atún | {1,2,3,4,5}            |     5 |
|     110 | 2021 | Winkler              | {1,2,3,4,5}            |     5 |
|     110 | 2022 | Captura manual       | {1,2,3,4,5,6,7,8,9,10} |    10 |
|     110 | 2022 | Pitfall              | {1,2,3,4,5}            |     5 |
|     110 | 2022 | Trampa de caída atún | {1,2,3,4,5}            |     5 |
|     110 | 2022 | Winkler              | {1,2,3,4,5}            |     5 |
|     112 | 2021 | Captura manual       | {1,2,3,4,5,6,7,8,9,10} |    10 |
|     112 | 2021 | Pitfall              | {1,2,3,4,5}            |     5 |
|     112 | 2021 | Trampa de caída atún | {1,2,3,4,5}            |     5 |
|     112 | 2021 | Winkler              | {1,2,3,4,5}            |     5 |
|     112 | 2022 | Captura manual       | {1,2,3,4,5,6,7,8,9,10} |    10 |
|     112 | 2022 | Pitfall              | {1,2,3,4,5}            |     5 |
|     112 | 2022 | Trampa de caída atún | {1,2,3,4,5}            |     5 |
|     112 | 2022 | Winkler              | {1,2,3,4,5}            |     5 |
|     113 | 2021 | Captura manual       | {1,2,3,4,5,6,7,8,9,10} |    10 |
|     113 | 2021 | Pitfall              | {1,2,3,4,5}            |     5 |
|     113 | 2021 | Trampa de caída atún | {1,2,3,4,5}            |     5 |
|     113 | 2021 | Winkler              | {1,2,3,4,5}            |     5 |
|     113 | 2022 | Captura manual       | {1,2,3,4,5,6,7,8,9,10} |    10 |
|     113 | 2022 | Pitfall              | {1,2,3,4,5}            |     5 |
|     113 | 2022 | Trampa de caída atún | {1,2,3,4,5}            |     5 |
|     113 | 2022 | Winkler              | {1,2,3,4,5}            |     5 |
|     114 | 2021 | Captura manual       | {1,2,3,4,5,6,7,8,9,10} |    10 |
|     114 | 2021 | Pitfall              | {1,2,3,4,5}            |     5 |
|     114 | 2021 | Trampa de caída atún | {1,2,3,4,5}            |     5 |
|     114 | 2021 | Winkler              | {1,2,3,4,5}            |     5 |
|     114 | 2022 | Captura manual       | {1,2,3,4,5,6,7,8,9,10} |    10 |
|     114 | 2022 | Pitfall              | {1,2,3,4,5}            |     5 |
|     114 | 2022 | Trampa de caída atún | {1,2,3,4,5}            |     5 |
|     114 | 2022 | Winkler              | {1,2,3,4,5}            |     5 |
|     115 | 2021 | Captura manual       | {1,2,3,4,5,6,7,8,9,10} |    10 |
|     115 | 2021 | Pitfall              | {1,2,3,4,5}            |     5 |
|     115 | 2021 | Trampa de caída atún | {1,2,3,4,5}            |     5 |
|     115 | 2021 | Winkler              | {1,2,3,4,5}            |     5 |
|     115 | 2022 | Captura manual       | {1,2,3,4,5,6,7,8,9,10} |    10 |
|     115 | 2022 | Pitfall              | {1,2,3,4,5}            |     5 |
|     115 | 2022 | Trampa de caída atún | {1,2,3,4,5}            |     5 |
|     115 | 2022 | Winkler              | {1,2,3,4,5}            |     5 |
|     116 | 2021 | Captura manual       | {1,2,3,4,5,6,7,8,9,10} |    10 |
|     116 | 2021 | Pitfall              | {1,2,3,4,5}            |     5 |
|     116 | 2021 | Trampa de caída atún | {1,2,3,4,5}            |     5 |
|     116 | 2021 | Winkler              | {1,2,3,4,5}            |     5 |
|     116 | 2022 | Captura manual       | {1,2,3,4,5,6,7,8,9,10} |    10 |
|     116 | 2022 | Pitfall              | {1,2,3,4,5}            |     5 |
|     116 | 2022 | Trampa de caída atún | {1,2,3,4,5}            |     5 |
|     116 | 2022 | Winkler              | {1,2,3,4,5}            |     5 |
|     117 | 2021 | Captura manual       | {1,2,3,4,5,6,7,8,9,10} |    10 |
|     117 | 2021 | Pitfall              | {1,2,3,4,5}            |     5 |
|     117 | 2021 | Trampa de caída atún | {1,2,3,4,5}            |     5 |
|     117 | 2021 | Winkler              | {1,2,3,4,5}            |     5 |
|     117 | 2022 | Captura manual       | {1,2,3,4,5,6,7,8,9,10} |    10 |
|     117 | 2022 | Pitfall              | {1,2,3,4,5}            |     5 |
|     117 | 2022 | Trampa de caída atún | {1,2,3,4,5}            |     5 |
|     117 | 2022 | Winkler              | {1,2,3,4,5}            |     5 |
|     118 | 2021 | Captura manual       | {1,2,3,4,5,6,7,8,9,10} |    10 |
|     118 | 2021 | Pitfall              | {1,2,3,4,5}            |     5 |
|     118 | 2021 | Trampa de caída atún | {1,2,3,4,5}            |     5 |
|     118 | 2021 | Winkler              | {1,2,3,4,5}            |     5 |
|     118 | 2022 | Captura manual       | {1,2,3,4,5,6,7,8,9,10} |    10 |
|     118 | 2022 | Pitfall              | {1,2,3,4,5}            |     5 |
|     118 | 2022 | Trampa de caída atún | {1,2,3,4,5}            |     5 |
|     118 | 2022 | Winkler              | {1,2,3,4,5}            |     5 |
|     120 | 2021 | Captura manual       | {1,2,3,4,5,6,7,8,9,10} |    10 |
|     120 | 2021 | Pitfall              | {1,2,3,4,5}            |     5 |
|     120 | 2021 | Trampa de caída atún | {1,2,3,4,5}            |     5 |
|     120 | 2021 | Winkler              | {1,2,3,4,5}            |     5 |
|     120 | 2022 | Captura manual       | {1,2,3,4,5,6,7,8,9,10} |    10 |
|     120 | 2022 | Pitfall              | {1,2,3,4,5}            |     5 |
|     120 | 2022 | Trampa de caída atún | {1,2,3,4,5}            |     5 |
|     120 | 2022 | Winkler              | {1,2,3,4,5}            |     5 |
|     121 | 2021 | Captura manual       | {1,2,3,4,5,6,7,8,9,10} |    10 |
|     121 | 2021 | Pitfall              | {1,2,3,4,5}            |     5 |
|     121 | 2021 | Trampa de caída atún | {1,2,3,4,5}            |     5 |
|     121 | 2021 | Winkler              | {1,2,3,4,5}            |     5 |
|     121 | 2022 | Captura manual       | {1,2,3,4,5,6,7,8,9,10} |    10 |
|     121 | 2022 | Pitfall              | {1,2,3,4,5}            |     5 |
|     121 | 2022 | Trampa de caída atún | {1,2,3,4,5}            |     5 |
|     121 | 2022 | Winkler              | {1,2,3,4,5}            |     5 |
|     122 | 2021 | Captura manual       | {1,2,3,4,5,6,7,8,9,10} |    10 |
|     122 | 2021 | Pitfall              | {1,2,3,4,5}            |     5 |
|     122 | 2021 | Trampa de caída atún | {1,2,3,4,5}            |     5 |
|     122 | 2021 | Winkler              | {1,2,3,4,5}            |     5 |

Displaying records 1 - 100

</div>

## 5.1 ANH

Insertar los datos de anh:

``` sql
INSERT INTO main.punto_referencia(name_pt_ref, num_anh)
WITH a AS(
SELECT
 REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_((Captura manual)|(Pitfall)|(Trampa de caída atún)|(Winkler))([0-9]{1,2})_(202[12])-[0-9][0-9]-[0-9][0-9](/202[12]-[0-9][0-9]-[0-9][0-9])?','\1')::int anh_num,
 REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_((Captura manual)|(Pitfall)|(Trampa de caída atún)|(Winkler))([0-9]{1,2})_(202[12])-[0-9][0-9]-[0-9][0-9](/202[12]-[0-9][0-9]-[0-9][0-9])?','\1') anh_name
FROM raw_dwc.hormigas_event
)
SELECT anh_name, anh_num
FROM a
GROUP BY anh_name,anh_num
ORDER BY anh_num
ON CONFLICT (name_pt_ref) DO NOTHING
RETURNING cd_pt_ref, name_pt_ref
;
```

dar las referencias en las tablas de hormigas

``` sql
ALTER TABLE raw_dwc.hormigas_event ADD COLUMN cd_pt_ref int REFERENCES main.punto_referencia(cd_pt_ref) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE raw_dwc.hormigas_registros ADD COLUMN cd_pt_ref int REFERENCES main.punto_referencia(cd_pt_ref) ON DELETE SET NULL ON UPDATE CASCADE;

UPDATE raw_dwc.hormigas_event
SET cd_pt_ref=pr.cd_pt_ref
FROM main.punto_referencia pr
WHERE REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_((Captura manual)|(Pitfall)|(Trampa de caída atún)|(Winkler))([0-9]{1,2})_(202[12])-[0-9][0-9]-[0-9][0-9](/202[12]-[0-9][0-9]-[0-9][0-9])?','\1') = name_pt_ref
;

UPDATE raw_dwc.hormigas_registros
SET cd_pt_ref=pr.cd_pt_ref
FROM main.punto_referencia pr
WHERE  REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_((Captura manual)|(Pitfall)|(Trampa de caída atún)|(Winkler))([0-9]{1,2})_(202[12])-[0-9][0-9]-[0-9][0-9](/202[12]-[0-9][0-9]-[0-9][0-9])?','\1') = name_pt_ref
;

SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

Averiguando que ninguna fila no tenga anh

``` sql
SELECT * FROM raw_dwc.hormigas_event WHERE cd_pt_ref IS NULL;
```

<div class="knitsql-table">

|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| row.names event_id parent_event_id sample_size_value sample_size_unit sampling_protocol sampling_effort event_date event_time habitat event_remarks continent country country_code state_province county locality minimum_elevation_in_meters maximum_elevation_in_meters verbatim_latitude verbatim_longitude verbatim_coordinate_system verbatim_srs decimal_latitude decimal_longitude geodetic_datum coordinate_uncertainty_in_meters institution_code measurement_type\_*plataforma* measurement_value\_*plataforma* measurement_type\_*distancia* measurement_value\_*distancia* measurement_unit\_*distancia* measurement_type\_*datos_cober* measurement_value\_*datos_cober* measurement_type\_*cober_homolo* measurement_value\_*cober_homolo* cd_pt_ref |

------------------------------------------------------------------------

: 0 records

</div>

``` sql
SELECT * FROM raw_dwc.hormigas_registros WHERE cd_pt_ref IS NULL;
```

<div class="knitsql-table">

|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| row.names occurrence_id event_id basis_of_record type institution_code collection_code catalog_number dynamic_properties record_number recorded_by organism_quantity organism_quantity_type sex life_stage preparations sampling_protocol sampling_effort event_date event_time habitat event_remarks identified_by date_identified identification_remarks identification_qualifier scientific_name higher_classification kingdom phylum class order family genus specific_epithet taxon_rank scientific_name_authorship occurrence_remarks tipo_de_tejido preparación_del_tejido colector_del_tejido cd_pt_ref |

------------------------------------------------------------------------

: 0 records

</div>

## 5.2 Unit, sampling efforts definition, abundance definition, protocolo

No hay nuevas unidades, ni variables que añadir (vamos a utilizar
minutos para el tiempo de sampling effort), y ‘Duración’ para la
variable de sampling effort

``` sql
INSERT INTO main.def_unit(cd_measurement_type, unit, unit_spa, abbv_unit,factor)
VALUES(
  (SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='area'),
  'Square meter',
  'Metros cuadrados',
  'm2',
  1
  ),
  (
  (SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='presence/absence'),
  'Lot',
  'Lote',
  'lote',
  1
  )
  
RETURNING cd_unit,unit;
```

``` sql
INSERT INTO main.def_var_samp_eff(var_samp_eff, var_samp_eff_spa, cd_unit,type_variable)
VALUES(
  'Sampling area',
  'Superficie de muestreo',
  (SELECT cd_unit FROM main.def_unit WHERE cd_measurement_type=(SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='area') AND unit='Square meter'),
  'double precision'
  )
RETURNING cd_var_samp_eff, var_samp_eff ;
```

``` sql
INSERT INTO main.def_var_ind_qt(var_qt_ind, var_qt_ind_spa, cd_unit, type_variable)
VALUES(
  'Lot',
  'Lote',
  (SELECT cd_unit FROM main.def_unit WHERE cd_measurement_type=(SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='presence/absence') AND unit='Lot'),
  'int'
)
RETURNING cd_var_ind_qt,var_qt_ind
;
```

``` sql
INSERT INTO main.def_protocol(protocol,protocol_spa,cd_var_samp_eff_1,cd_var_samp_eff_2,samp_eff_1_implicit,samp_eff_2_implicit,cd_var_ind_qt,description_spa)
VALUES(
  'Ant hand collection',
  'Captura manual de hormigas',
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Sampling area'),
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Elapsed time'),
  false,
  false,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind='Lot'),
  'Captura manual de hormigas: nota, cuando la cantidad de lote es superior a 1, quiere decir que los individuos se contarón'
),(
  'Ant pitfall',
  'Pitfall para hormigas',
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Elapsed time'),
  NULL,
  true,
  NULL,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind='Lot'),
  'Pitfall: nota, cuando la cantidad de lote es superior a 1, quiere decir que los individuos se contarón'
),(
  'Ant winkler',
  'Winkler para hormigas',
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Elapsed time'),
  NULL,
  true,
  NULL,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind='Lot'),
  'Winkler: nota, cuando la cantidad de lote es superior a 1, quiere decir que los individuos se contarón'
),(
  'Ant tuna fall trap',
  'Trampa de caída atún',
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Elapsed time'),
  NULL,
  true,
  NULL,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind='Lot'),
  'Pitfall: nota, cuando la cantidad de lote es superior a 1, quiere decir que los individuos se contarón'
  )
RETURNING cd_protocol,protocol,protocol_spa;
```

## 5.3 Personas

``` sql
INSERT INTO main.people(verbatim_person)
WITH a AS(
SELECT DISTINCT INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(recorded_by, ' | ')))) AS name_person
FROM raw_dwc.hormigas_registros
UNION
SELECT DISTINCT INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(identified_by, ' | '))))
FROM raw_dwc.hormigas_registros
)
SELECT DISTINCT REGEXP_REPLACE(name_person, '- ','-')
FROM a 
ORDER BY REGEXP_REPLACE(name_person, '- ','-')
ON CONFLICT(verbatim_person) DO NOTHING
RETURNING cd_person, verbatim_person
```

Dar los codigos a las tables de origen:

``` sql
ALTER TABLE raw_dwc.hormigas_registros ADD COLUMN cds_recorded_by int[];

WITH a AS(
SELECT "row.names", REGEXP_REPLACE(INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(recorded_by, ' | ')))),'- ','-') AS name_person
FROM raw_dwc.hormigas_registros
),b AS(
SELECT "row.names", ARRAY_AGG(cd_person) cds
FROM a 
LEFT JOIN main.people p ON a.name_person=p.verbatim_person
GROUP BY "row.names"
)
UPDATE raw_dwc.hormigas_registros AS r
SET cds_recorded_by=b.cds
FROM b
WHERE r."row.names"=b."row.names"
RETURNING r."row.names", cds_recorded_by
;

ALTER TABLE raw_dwc.hormigas_registros ADD COLUMN cds_identified_by int[];

WITH a AS(
SELECT "row.names", REGEXP_REPLACE(INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(identified_by, ' | ')))),'- ','-') AS name_person
FROM raw_dwc.hormigas_registros
),b AS(
SELECT "row.names", ARRAY_AGG(cd_person) cds
FROM a 
LEFT JOIN main.people p ON a.name_person=p.verbatim_person
GROUP BY "row.names"
)
UPDATE raw_dwc.hormigas_registros AS r
SET cds_identified_by=b.cds
FROM b
WHERE r."row.names"=b."row.names"
RETURNING r."row.names", cds_identified_by
;

SELECT 1;
```

<div class="knitsql-table">

| ?column? |
|---------:|
|        1 |

1 records

</div>

## 5.4 gp_event

``` sql
WITH a AS(
SELECT 
  event_id,
 REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_((Captura manual)|(Pitfall)|(Trampa de caída atún)|(Winkler))([0-9]{1,2})_(202[12])-[0-9][0-9]-[0-9][0-9](/202[12]-[0-9][0-9]-[0-9][0-9])?','\1')::int anh_num,
 REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_((Captura manual)|(Pitfall)|(Trampa de caída atún)|(Winkler))([0-9]{1,2})_(202[12])-[0-9][0-9]-[0-9][0-9](/202[12]-[0-9][0-9]-[0-9][0-9])?','\2') metodo,
 REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_((Captura manual)|(Pitfall)|(Trampa de caída atún)|(Winkler))([0-9]{1,2})_(202[12])-[0-9][0-9]-[0-9][0-9](/202[12]-[0-9][0-9]-[0-9][0-9])?','\7')::int repli,
 REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_((Captura manual)|(Pitfall)|(Trampa de caída atún)|(Winkler))([0-9]{1,2})_(202[12])-[0-9][0-9]-[0-9][0-9](/202[12]-[0-9][0-9]-[0-9][0-9])?','\8') año
FROM raw_dwc.hormigas_event
)
SELECT año, anh_num,metodo, ARRAY_AGG(repli), count(*)
FROM a
GROUP BY año, anh_num, metodo
ORDER BY año, anh_num, metodo
;
```

<div class="knitsql-table">

| año  | anh_num | metodo               | array_agg              | count |
|:-----|--------:|:---------------------|:-----------------------|------:|
| 2021 |     108 | Captura manual       | {5,4,3,6,10,2,1,8,7,9} |    10 |
| 2021 |     108 | Pitfall              | {1,3,5,4,2}            |     5 |
| 2021 |     108 | Trampa de caída atún | {1,3,4,5,2}            |     5 |
| 2021 |     108 | Winkler              | {2,1,5,4,3}            |     5 |
| 2021 |     109 | Captura manual       | {3,6,8,9,10,7,5,1,2,4} |    10 |
| 2021 |     109 | Pitfall              | {1,4,3,2,5}            |     5 |
| 2021 |     109 | Trampa de caída atún | {2,3,4,5,1}            |     5 |
| 2021 |     109 | Winkler              | {2,3,4,1,5}            |     5 |
| 2021 |     110 | Captura manual       | {8,9,10,3,4,6,5,7,2,1} |    10 |
| 2021 |     110 | Pitfall              | {2,4,5,1,3}            |     5 |
| 2021 |     110 | Trampa de caída atún | {4,3,2,1,5}            |     5 |
| 2021 |     110 | Winkler              | {3,5,4,2,1}            |     5 |
| 2021 |     112 | Captura manual       | {5,9,8,7,10,1,6,2,3,4} |    10 |
| 2021 |     112 | Pitfall              | {3,1,4,5,2}            |     5 |
| 2021 |     112 | Trampa de caída atún | {3,1,2,4,5}            |     5 |
| 2021 |     112 | Winkler              | {1,5,4,3,2}            |     5 |
| 2021 |     113 | Captura manual       | {1,3,2,5,10,4,9,8,7,6} |    10 |
| 2021 |     113 | Pitfall              | {2,5,4,3,1}            |     5 |
| 2021 |     113 | Trampa de caída atún | {5,4,1,2,3}            |     5 |
| 2021 |     113 | Winkler              | {4,1,2,3,5}            |     5 |
| 2021 |     114 | Captura manual       | {8,10,1,2,3,4,5,6,7,9} |    10 |
| 2021 |     114 | Pitfall              | {3,1,2,4,5}            |     5 |
| 2021 |     114 | Trampa de caída atún | {2,5,4,3,1}            |     5 |
| 2021 |     114 | Winkler              | {5,4,3,2,1}            |     5 |
| 2021 |     115 | Captura manual       | {6,4,3,2,1,8,9,10,7,5} |    10 |
| 2021 |     115 | Pitfall              | {1,3,5,4,2}            |     5 |
| 2021 |     115 | Trampa de caída atún | {2,3,4,5,1}            |     5 |
| 2021 |     115 | Winkler              | {3,5,1,2,4}            |     5 |
| 2021 |     116 | Captura manual       | {2,1,3,7,6,5,8,9,10,4} |    10 |
| 2021 |     116 | Pitfall              | {4,3,2,1,5}            |     5 |
| 2021 |     116 | Trampa de caída atún | {5,2,1,3,4}            |     5 |
| 2021 |     116 | Winkler              | {1,5,4,2,3}            |     5 |
| 2021 |     117 | Captura manual       | {6,5,3,2,8,7,4,10,9,1} |    10 |
| 2021 |     117 | Pitfall              | {1,3,4,5,2}            |     5 |
| 2021 |     117 | Trampa de caída atún | {3,4,2,1,5}            |     5 |
| 2021 |     117 | Winkler              | {1,2,3,5,4}            |     5 |
| 2021 |     118 | Captura manual       | {4,10,9,8,7,6,1,2,3,5} |    10 |
| 2021 |     118 | Pitfall              | {5,1,2,3,4}            |     5 |
| 2021 |     118 | Trampa de caída atún | {5,1,2,3,4}            |     5 |
| 2021 |     118 | Winkler              | {2,1,3,4,5}            |     5 |
| 2021 |     120 | Captura manual       | {7,10,9,8,6,5,4,3,2,1} |    10 |
| 2021 |     120 | Pitfall              | {3,5,4,2,1}            |     5 |
| 2021 |     120 | Trampa de caída atún | {1,2,3,5,4}            |     5 |
| 2021 |     120 | Winkler              | {4,2,1,3,5}            |     5 |
| 2021 |     121 | Captura manual       | {9,1,3,8,7,6,5,10,2,4} |    10 |
| 2021 |     121 | Pitfall              | {5,3,2,1,4}            |     5 |
| 2021 |     121 | Trampa de caída atún | {4,1,3,5,2}            |     5 |
| 2021 |     121 | Winkler              | {5,4,3,2,1}            |     5 |
| 2021 |     122 | Captura manual       | {6,1,3,5,2,10,9,8,7,4} |    10 |
| 2021 |     122 | Pitfall              | {3,2,1,4,5}            |     5 |
| 2021 |     122 | Trampa de caída atún | {4,3,2,1,5}            |     5 |
| 2021 |     122 | Winkler              | {3,4,5,2,1}            |     5 |
| 2021 |     123 | Captura manual       | {9,1,2,3,4,5,6,7,8,10} |    10 |
| 2021 |     123 | Pitfall              | {4,1,3,5,2}            |     5 |
| 2021 |     123 | Trampa de caída atún | {4,5,1,2,3}            |     5 |
| 2021 |     123 | Winkler              | {2,5,4,3,1}            |     5 |
| 2021 |     125 | Captura manual       | {9,10,8,5,6,7,1,2,3,4} |    10 |
| 2021 |     125 | Pitfall              | {2,1,3,4,5}            |     5 |
| 2021 |     125 | Trampa de caída atún | {1,5,4,3,2}            |     5 |
| 2021 |     125 | Winkler              | {5,4,3,2,1}            |     5 |
| 2021 |     127 | Captura manual       | {10,1,6,7,8,9,2,4,3,5} |    10 |
| 2021 |     127 | Pitfall              | {1,2,4,5,3}            |     5 |
| 2021 |     127 | Trampa de caída atún | {1,2,3,4,5}            |     5 |
| 2021 |     127 | Winkler              | {5,4,2,3,1}            |     5 |
| 2021 |     130 | Captura manual       | {8,7,5,4,3,2,1,6,10,9} |    10 |
| 2021 |     130 | Pitfall              | {1,4,3,5,2}            |     5 |
| 2021 |     130 | Trampa de caída atún | {3,4,1,2,5}            |     5 |
| 2021 |     130 | Winkler              | {4,5,3,2,1}            |     5 |
| 2021 |     131 | Captura manual       | {4,5,6,7,8,9,3,2,1,10} |    10 |
| 2021 |     131 | Pitfall              | {4,5,1,2,3}            |     5 |
| 2021 |     131 | Trampa de caída atún | {4,5,3,2,1}            |     5 |
| 2021 |     131 | Winkler              | {3,2,1,4,5}            |     5 |
| 2021 |     132 | Captura manual       | {6,8,9,10,3,2,1,4,5,7} |    10 |
| 2021 |     132 | Pitfall              | {1,5,4,3,2}            |     5 |
| 2021 |     132 | Trampa de caída atún | {4,3,2,1,5}            |     5 |
| 2021 |     132 | Winkler              | {3,5,1,2,4}            |     5 |
| 2021 |     133 | Captura manual       | {8,9,10,1,2,3,6,5,4,7} |    10 |
| 2021 |     133 | Pitfall              | {5,4,3,1,2}            |     5 |
| 2021 |     133 | Trampa de caída atún | {3,4,5,1,2}            |     5 |
| 2021 |     133 | Winkler              | {5,4,3,2,1}            |     5 |
| 2021 |     134 | Captura manual       | {4,3,2,1,5,6,7,10,9,8} |    10 |
| 2021 |     134 | Pitfall              | {4,5,1,2,3}            |     5 |
| 2021 |     134 | Trampa de caída atún | {1,2,3,4,5}            |     5 |
| 2021 |     134 | Winkler              | {1,2,3,4,5}            |     5 |
| 2021 |     135 | Captura manual       | {4,5,6,7,9,8,10,1,2,3} |    10 |
| 2021 |     135 | Pitfall              | {2,5,1,3,4}            |     5 |
| 2021 |     135 | Trampa de caída atún | {5,2,1,3,4}            |     5 |
| 2021 |     135 | Winkler              | {2,3,4,5,1}            |     5 |
| 2021 |     136 | Captura manual       | {1,10,9,8,7,6,5,4,3,2} |    10 |
| 2021 |     136 | Pitfall              | {2,5,4,3,1}            |     5 |
| 2021 |     136 | Trampa de caída atún | {1,3,4,5,2}            |     5 |
| 2021 |     136 | Winkler              | {3,1,2,4,5}            |     5 |
| 2021 |     137 | Captura manual       | {5,4,3,2,6,1,10,8,7,9} |    10 |
| 2021 |     137 | Pitfall              | {5,4,3,2,1}            |     5 |
| 2021 |     137 | Trampa de caída atún | {2,5,4,3,1}            |     5 |
| 2021 |     137 | Winkler              | {2,3,4,5,1}            |     5 |
| 2021 |     138 | Captura manual       | {5,6,7,8,9,3,2,10,1,4} |    10 |
| 2021 |     138 | Pitfall              | {1,2,3,4,5}            |     5 |
| 2021 |     138 | Trampa de caída atún | {2,5,4,3,1}            |     5 |
| 2021 |     138 | Winkler              | {5,1,2,3,4}            |     5 |

Displaying records 1 - 100

</div>

Because there is more than a method, the number of the campaign should
be determined this way:

``` sql
WITH a AS(
SELECT 
  event_id,
 REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_((Captura manual)|(Pitfall)|(Trampa de caída atún)|(Winkler))([0-9]{1,2})_(202[12])-[0-9][0-9]-[0-9][0-9](/202[12]-[0-9][0-9]-[0-9][0-9])?','\1')::int anh_num,
 REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_((Captura manual)|(Pitfall)|(Trampa de caída atún)|(Winkler))([0-9]{1,2})_(202[12])-[0-9][0-9]-[0-9][0-9](/202[12]-[0-9][0-9]-[0-9][0-9])?','\2') metodo,
 REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_((Captura manual)|(Pitfall)|(Trampa de caída atún)|(Winkler))([0-9]{1,2})_(202[12])-[0-9][0-9]-[0-9][0-9](/202[12]-[0-9][0-9]-[0-9][0-9])?','\7')::int repli,
 REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_((Captura manual)|(Pitfall)|(Trampa de caída atún)|(Winkler))([0-9]{1,2})_(202[12])-[0-9][0-9]-[0-9][0-9](/202[12]-[0-9][0-9]-[0-9][0-9])?','\8') año
FROM raw_dwc.hormigas_event
)
SELECT año, anh_num, ROW_NUMBER() OVER (PARTITION BY anh_num ORDER BY año) campaign_nb
FROM a
GROUP BY año, anh_num
ORDER BY año, anh_num
;
```

<div class="knitsql-table">

| año  | anh_num | campaign_nb |
|:-----|--------:|------------:|
| 2021 |     108 |           1 |
| 2021 |     109 |           1 |
| 2021 |     110 |           1 |
| 2021 |     112 |           1 |
| 2021 |     113 |           1 |
| 2021 |     114 |           1 |
| 2021 |     115 |           1 |
| 2021 |     116 |           1 |
| 2021 |     117 |           1 |
| 2021 |     118 |           1 |
| 2021 |     120 |           1 |
| 2021 |     121 |           1 |
| 2021 |     122 |           1 |
| 2021 |     123 |           1 |
| 2021 |     125 |           1 |
| 2021 |     127 |           1 |
| 2021 |     130 |           1 |
| 2021 |     131 |           1 |
| 2021 |     132 |           1 |
| 2021 |     133 |           1 |
| 2021 |     134 |           1 |
| 2021 |     135 |           1 |
| 2021 |     136 |           1 |
| 2021 |     137 |           1 |
| 2021 |     138 |           1 |
| 2021 |     142 |           1 |
| 2021 |     144 |           1 |
| 2021 |     145 |           1 |
| 2021 |     147 |           1 |
| 2021 |     365 |           1 |
| 2021 |     366 |           1 |
| 2021 |     368 |           1 |
| 2021 |     369 |           1 |
| 2021 |     370 |           1 |
| 2021 |     371 |           1 |
| 2021 |     372 |           1 |
| 2021 |     374 |           1 |
| 2021 |     375 |           1 |
| 2021 |     402 |           1 |
| 2021 |     403 |           1 |
| 2022 |     108 |           2 |
| 2022 |     109 |           2 |
| 2022 |     110 |           2 |
| 2022 |     112 |           2 |
| 2022 |     113 |           2 |
| 2022 |     114 |           2 |
| 2022 |     115 |           2 |
| 2022 |     116 |           2 |
| 2022 |     117 |           2 |
| 2022 |     118 |           2 |
| 2022 |     120 |           2 |
| 2022 |     121 |           2 |
| 2022 |     122 |           2 |
| 2022 |     123 |           2 |
| 2022 |     125 |           2 |
| 2022 |     127 |           2 |
| 2022 |     130 |           2 |
| 2022 |     131 |           2 |
| 2022 |     132 |           2 |
| 2022 |     133 |           2 |
| 2022 |     134 |           2 |
| 2022 |     135 |           2 |
| 2022 |     136 |           2 |
| 2022 |     137 |           2 |
| 2022 |     138 |           2 |
| 2022 |     142 |           2 |
| 2022 |     144 |           2 |
| 2022 |     145 |           2 |
| 2022 |     147 |           2 |
| 2022 |     365 |           2 |
| 2022 |     366 |           2 |
| 2022 |     368 |           2 |
| 2022 |     369 |           2 |
| 2022 |     370 |           2 |
| 2022 |     371 |           2 |
| 2022 |     372 |           2 |
| 2022 |     374 |           2 |
| 2022 |     375 |           2 |
| 2022 |     402 |           2 |
| 2022 |     403 |           2 |

80 records

</div>

``` sql
INSERT INTO main.gp_event(cd_gp_biol,cd_protocol,cd_pt_ref,campaign_nb)
WITH a AS(
SELECT 
  event_id,
 REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_((Captura manual)|(Pitfall)|(Trampa de caída atún)|(Winkler))([0-9]{1,2})_(202[12])-[0-9][0-9]-[0-9][0-9](/202[12]-[0-9][0-9]-[0-9][0-9])?','\1')::int anh_num,
 REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_((Captura manual)|(Pitfall)|(Trampa de caída atún)|(Winkler))([0-9]{1,2})_(202[12])-[0-9][0-9]-[0-9][0-9](/202[12]-[0-9][0-9]-[0-9][0-9])?','\2') metodo,
 REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_((Captura manual)|(Pitfall)|(Trampa de caída atún)|(Winkler))([0-9]{1,2})_(202[12])-[0-9][0-9]-[0-9][0-9](/202[12]-[0-9][0-9]-[0-9][0-9])?','\7')::int repli,
 REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_((Captura manual)|(Pitfall)|(Trampa de caída atún)|(Winkler))([0-9]{1,2})_(202[12])-[0-9][0-9]-[0-9][0-9](/202[12]-[0-9][0-9]-[0-9][0-9])?','\8') año,
  cd_pt_ref
FROM raw_dwc.hormigas_event
), campaign AS(
SELECT año, anh_num, ROW_NUMBER() OVER (PARTITION BY anh_num ORDER BY año) campaign_nb
FROM a
GROUP BY año, anh_num
ORDER BY año, anh_num
)
SELECT 'horm',
  CASE
    WHEN metodo='Captura manual' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Ant hand collection')
    WHEN metodo='Pitfall' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Ant pitfall')
    WHEN metodo='Trampa de caída atún' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Ant tuna fall trap')
    WHEN metodo='Winkler' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Ant winkler')
  END cd_protocol,
  cd_pt_ref,
  c.campaign_nb
FROM a
LEFT JOIN campaign c USING (año, anh_num)
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
GROUP BY cd_pt_ref, name_pt_ref, año, metodo, c.campaign_nb
ORDER BY año,cd_pt_ref,cd_protocol
RETURNING cd_gp_event,cd_gp_biol,cd_protocol,cd_pt_ref,campaign_nb
;
```

Attributing the gp_event

``` sql
ALTER TABLE raw_dwc.hormigas_event ADD COLUMN cd_gp_event int REFERENCES main.gp_event(cd_gp_event) ON DELETE SET NULL;


WITH a AS(
SELECT 
  event_id,
 REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_((Captura manual)|(Pitfall)|(Trampa de caída atún)|(Winkler))([0-9]{1,2})_(202[12])-[0-9][0-9]-[0-9][0-9](/202[12]-[0-9][0-9]-[0-9][0-9])?','\1')::int anh_num,
 REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_((Captura manual)|(Pitfall)|(Trampa de caída atún)|(Winkler))([0-9]{1,2})_(202[12])-[0-9][0-9]-[0-9][0-9](/202[12]-[0-9][0-9]-[0-9][0-9])?','\2') metodo,
 REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_((Captura manual)|(Pitfall)|(Trampa de caída atún)|(Winkler))([0-9]{1,2})_(202[12])-[0-9][0-9]-[0-9][0-9](/202[12]-[0-9][0-9]-[0-9][0-9])?','\7')::int repli,
 REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_((Captura manual)|(Pitfall)|(Trampa de caída atún)|(Winkler))([0-9]{1,2})_(202[12])-[0-9][0-9]-[0-9][0-9](/202[12]-[0-9][0-9]-[0-9][0-9])?','\8') año,
  cd_pt_ref
FROM raw_dwc.hormigas_event
), campaign AS(
SELECT año, anh_num, ROW_NUMBER() OVER (PARTITION BY anh_num ORDER BY año) campaign_nb
FROM a
GROUP BY año, anh_num
ORDER BY año, anh_num
), b AS(
SELECT
  CASE
    WHEN metodo='Captura manual' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Ant hand collection')
    WHEN metodo='Pitfall' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Ant pitfall')
    WHEN metodo='Trampa de caída atún' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Ant tuna fall trap')
    WHEN metodo='Winkler' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Ant winkler')
  END cd_protocol,
  cd_pt_ref,
  c.campaign_nb,
  event_id
FROM a
LEFT JOIN campaign c USING (año, anh_num)
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
),d AS(
SELECT b.*, cd_gp_event
FROM b
LEFT JOIN main.gp_event ge ON cd_gp_biol='horm' AND b.cd_protocol=ge.cd_protocol AND b.cd_pt_ref=ge.cd_pt_ref AND b.campaign_nb=ge.campaign_nb
)
UPDATE raw_dwc.hormigas_event e
SET cd_gp_event=d.cd_gp_event
FROM d
WHERE d.event_id=e.event_id
RETURNING e.event_id, e.cd_gp_event
;
```

<div class="knitsql-table">

| event_id                            | cd_gp_event |
|:------------------------------------|------------:|
| ANH_147_Captura manual2_2021-07-01  |         286 |
| ANH_147_Captura manual3_2021-07-01  |         286 |
| ANH_147_Captura manual4_2021-07-01  |         286 |
| ANH_147_Captura manual5_2021-07-01  |         286 |
| ANH_147_Captura manual6_2021-07-01  |         286 |
| ANH_147_Captura manual7_2021-07-01  |         286 |
| ANH_147_Captura manual8_2021-07-01  |         286 |
| ANH_147_Captura manual9_2021-07-01  |         286 |
| ANH_147_Captura manual10_2021-07-01 |         286 |
| ANH_116_Captura manual1_2021-07-02  |         222 |
| ANH_116_Captura manual3_2021-07-02  |         222 |
| ANH_116_Captura manual4_2021-07-02  |         222 |
| ANH_116_Captura manual5_2021-07-02  |         222 |
| ANH_116_Captura manual6_2021-07-02  |         222 |
| ANH_116_Captura manual7_2021-07-02  |         222 |
| ANH_116_Captura manual8_2021-07-02  |         222 |
| ANH_116_Captura manual9_2021-07-02  |         222 |
| ANH_116_Captura manual10_2021-07-02 |         222 |
| ANH_134_Captura manual1_2021-07-05  |         262 |
| ANH_134_Captura manual2_2021-07-05  |         262 |
| ANH_137_Captura manual6_2021-07-08  |         266 |
| ANH_137_Captura manual7_2021-07-08  |         266 |
| ANH_137_Captura manual8_2021-07-08  |         266 |
| ANH_134_Captura manual3_2021-07-05  |         262 |
| ANH_134_Captura manual4_2021-07-05  |         262 |
| ANH_134_Captura manual5_2021-07-05  |         262 |
| ANH_134_Captura manual6_2021-07-05  |         262 |
| ANH_134_Captura manual7_2021-07-05  |         262 |
| ANH_134_Captura manual8_2021-07-05  |         262 |
| ANH_134_Captura manual9_2021-07-05  |         262 |
| ANH_137_Captura manual9_2021-07-08  |         266 |
| ANH_134_Captura manual10_2021-07-05 |         262 |
| ANH_114_Captura manual1_2021-07-06  |         214 |
| ANH_114_Captura manual2_2021-07-06  |         214 |
| ANH_114_Captura manual3_2021-07-06  |         214 |
| ANH_114_Captura manual4_2021-07-06  |         214 |
| ANH_114_Captura manual5_2021-07-06  |         214 |
| ANH_137_Captura manual10_2021-07-08 |         266 |
| ANH_121_Captura manual1_2021-07-12  |         234 |
| ANH_114_Captura manual6_2021-07-06  |         214 |
| ANH_114_Captura manual7_2021-07-06  |         214 |
| ANH_114_Captura manual8_2021-07-06  |         214 |
| ANH_114_Captura manual9_2021-07-06  |         214 |
| ANH_114_Captura manual10_2021-07-06 |         214 |
| ANH_112_Captura manual1_2021-07-07  |         206 |
| ANH_112_Captura manual2_2021-07-07  |         206 |
| ANH_112_Captura manual3_2021-07-07  |         206 |
| ANH_112_Captura manual4_2021-07-07  |         206 |
| ANH_112_Captura manual5_2021-07-07  |         206 |
| ANH_138_Captura manual1_2021-07-08  |         270 |
| ANH_138_Captura manual2_2021-07-08  |         270 |
| ANH_138_Captura manual3_2021-07-08  |         270 |
| ANH_138_Captura manual5_2021-07-08  |         270 |
| ANH_138_Captura manual6_2021-07-08  |         270 |
| ANH_138_Captura manual7_2021-07-08  |         270 |
| ANH_138_Captura manual8_2021-07-08  |         270 |
| ANH_138_Captura manual9_2021-07-08  |         270 |
| ANH_138_Captura manual10_2021-07-08 |         270 |
| ANH_122_Captura manual1_2021-07-12  |         238 |
| ANH_122_Captura manual4_2021-07-12  |         238 |
| ANH_122_Captura manual6_2021-07-12  |         238 |
| ANH_122_Captura manual7_2021-07-12  |         238 |
| ANH_122_Captura manual8_2021-07-12  |         238 |
| ANH_122_Captura manual9_2021-07-12  |         238 |
| ANH_122_Captura manual10_2021-07-12 |         238 |
| ANH_108_Captura manual1_2021-07-13  |         198 |
| ANH_108_Captura manual2_2021-07-13  |         198 |
| ANH_108_Captura manual3_2021-07-13  |         198 |
| ANH_108_Captura manual4_2021-07-13  |         198 |
| ANH_108_Captura manual5_2021-07-13  |         198 |
| ANH_108_Captura manual6_2021-07-13  |         198 |
| ANH_108_Captura manual7_2021-07-13  |         198 |
| ANH_108_Captura manual8_2021-07-13  |         198 |
| ANH_108_Captura manual9_2021-07-13  |         198 |
| ANH_108_Captura manual10_2021-07-13 |         198 |
| ANH_120_Captura manual1_2021-07-14  |         230 |
| ANH_120_Captura manual2_2021-07-14  |         230 |
| ANH_120_Captura manual3_2021-07-14  |         230 |
| ANH_120_Captura manual4_2021-07-14  |         230 |
| ANH_120_Captura manual5_2021-07-14  |         230 |
| ANH_120_Captura manual6_2021-07-14  |         230 |
| ANH_120_Captura manual8_2021-07-14  |         230 |
| ANH_120_Captura manual9_2021-07-14  |         230 |
| ANH_120_Captura manual10_2021-07-14 |         230 |
| ANH_127_Captura manual1_2021-07-15  |         318 |
| ANH_127_Captura manual2_2021-07-15  |         318 |
| ANH_127_Captura manual3_2021-07-15  |         318 |
| ANH_127_Captura manual5_2021-07-15  |         318 |
| ANH_127_Captura manual6_2021-07-15  |         318 |
| ANH_127_Captura manual7_2021-07-15  |         318 |
| ANH_127_Captura manual8_2021-07-15  |         318 |
| ANH_127_Captura manual9_2021-07-15  |         318 |
| ANH_127_Captura manual10_2021-07-15 |         318 |
| ANH_136_Captura manual1_2021-07-01  |         186 |
| ANH_136_Captura manual2_2021-07-01  |         186 |
| ANH_121_Captura manual3_2021-07-12  |         234 |
| ANH_136_Captura manual3_2021-07-01  |         186 |
| ANH_136_Captura manual4_2021-07-01  |         186 |
| ANH_136_Captura manual5_2021-07-01  |         186 |
| ANH_136_Captura manual6_2021-07-01  |         186 |

Displaying records 1 - 100

</div>

## 5.5 event

TODO: ARREGLAR PROBLEMA DE HORA FALTANTE PARA ALGUNOS WINKLERS Note:
maybe it would not be idiot to leave it empty… and to give the date as
an extra variable, as text… and for mariposas as well…

``` sql
INSERT INTO main.event(cd_gp_event,event_id,num_replicate, description_replicate, date_time_begin, date_time_end, locality_verb, event_remarks, samp_effort_1, samp_effort_2, pt_geom)
WITH a AS(
SELECT cd_gp_event,
  event_id, 
 REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_((Captura manual)|(Pitfall)|(Trampa de caída atún)|(Winkler))([0-9]{1,2})_(202[12])-[0-9][0-9]-[0-9][0-9](/202[12]-[0-9][0-9]-[0-9][0-9])?','\7')::int num_replicate,
 REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_((Captura manual)|(Pitfall)|(Trampa de caída atún)|(Winkler)[0-9]{1,2}_202[12]-[0-9][0-9]-[0-9][0-9](/202[12]-[0-9][0-9]-[0-9][0-9])?)','\2') description_replicate,
  TO_DATE(SPLIT_PART(event_date,'/',1), 'YYYY-MM-DD') date_1,
  CASE 
    WHEN SPLIT_PART(event_date,'/',2)='' THEN NULL
    ELSE TO_DATE(SPLIT_PART(event_date,'/',2), 'YYYY-MM-DD')
  END date_2,
  REGEXP_REPLACE(SPLIT_PART(event_time,'/',1),'\s+','','g') hora_1,
  CASE
    WHEN REGEXP_REPLACE(SPLIT_PART(event_time,'/',2),'\s+','','g')='' THEN NULL
    ELSE REGEXP_REPLACE(SPLIT_PART(event_time,'/',2),'\s+','','g')
  END hora_2,
  locality locality_verb,
  sample_size_value,
  event_remarks,
  decimal_latitude::double precision,
  decimal_longitude::double precision
FROM raw_dwc.hormigas_event
)
SELECT 
  cd_gp_event,
  event_id, 
  num_replicate,
  description_replicate,
  CASE
    WHEN date_1 IS NULL OR hora_1 IS NULL THEN NULL
    ELSE (date_1||' '||hora_1)::timestamp 
  END date_time_begin,
  CASE
    WHEN date_2 IS NULL OR hora_2 IS NULL THEN NULL
    ELSE (date_2||' '||hora_2)::timestamp
  END date_time_end,
  locality_verb,
  REGEXP_REPLACE(REGEXP_REPLACE(event_remarks ,'\| La hora inicial corresponde al día que se instaló la trampa y la hora final al día que se retiró',''),'\| Sin registro de individuos','') event_remarks,
  CASE
   WHEN protocol='Ant hand collection' THEN sample_size_value
   ELSE NULL
  END samp_eff_1,
  CASE
   WHEN protocol='Ant hand collection' THEN 12
   ELSE NULL
  END,
  ST_SetSRID(ST_Transform(ST_SetSRID(ST_MakePoint(decimal_longitude,decimal_latitude),4326), (SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)),3116)
FROM a
LEFT JOIN main.gp_event USING (cd_gp_event)
LEFT JOIN main.def_protocol p USING (cd_protocol)
ORDER BY cd_gp_event, event_id, num_replicate


RETURNING main.event.cd_event, main.event.cd_gp_event, main.event.event_id, main.event.num_replicate, main.event.description_replicate, main.event.date_time_begin, main.event.date_time_end, main.event.locality_verb, main.event.event_remarks, main.event.pt_geom
```

Damos los cd_event a todos las filas:

``` sql
ALTER TABLE raw_dwc.hormigas_event ADD COLUMN cd_event int REFERENCES main.event(cd_event) ON DELETE SET NULL;
ALTER TABLE raw_dwc.hormigas_registros ADD COLUMN cd_event int REFERENCES main.event(cd_event);

UPDATE raw_dwc.hormigas_event AS t
SET cd_event=e.cd_event
FROM main.event e
WHERE t.event_id=e.event_id;

UPDATE raw_dwc.hormigas_registros AS t
SET cd_event=e.cd_event
FROM main.event e
WHERE t.event_id=e.event_id;

SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

Añadir fechas en la tabla extra cuando las horas no son disponibles

``` sql
INSERT INTO main.event_extra(cd_event, cd_var_event_extra,value_text)
WITH a AS(
SELECT cd_event,ef.date_time_begin,
  TO_DATE(SPLIT_PART(event_date,'/',1), 'YYYY-MM-DD') date_1
FROM raw_dwc.hormigas_event e
LEFT JOIN main.event ef USING (cd_event)
WHERE date_time_begin IS NULL
),b AS(
SELECT cd_event,
  CASE
   WHEN date_time_begin IS NULL THEN date_1
   ELSE NULL
  END date_begin
FROM a
)
SELECT 
 cd_event,
 (SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin'),
 to_char(date_begin,'yyyy-mm-dd')::text
FROM b
WHERE date_begin IS NOT NULL
RETURNING main.event_extra.cd_event, main.event_extra.cd_var_event_extra, main.event_extra.value_text
;

INSERT INTO main.event_extra(cd_event, cd_var_event_extra,value_text)
WITH a AS(
SELECT cd_event,ef.date_time_end,
  e.event_id,
  REGEXP_REPLACE(e.event_id,'^ANH_([0-9]{1,3})_((Captura manual)|(Pitfall)|(Trampa de caída atún)|(Winkler))([0-9]{1,2})_(202[12])-[0-9][0-9]-[0-9][0-9](/202[12]-[0-9][0-9]-[0-9][0-9])?','\2') metodo,
  TO_DATE(REGEXP_REPLACE(e.event_id,'^ANH_[0-9]{1,3}_((Captura manual)|(Pitfall)|(Trampa de caída atún)|(Winkler))([0-9]{1,2})_(202[12])-[0-9][0-9]-[0-9][0-9](/(202[12]-[0-9][0-9]-[0-9][0-9]))?','\9'),'YYYY-MM-DD') date_2_from_eid,
  TO_DATE(SPLIT_PART(event_date,'/',1), 'YYYY-MM-DD') date_1,
  CASE 
    WHEN SPLIT_PART(event_date,'/',2)='' THEN NULL
    ELSE TO_DATE(SPLIT_PART(event_date,'/',2), 'YYYY-MM-DD')
  END date_2
FROM raw_dwc.hormigas_event e
LEFT JOIN main.event ef USING (cd_event)
WHERE date_time_end IS NULL
),b AS(
SELECT cd_event,
  CASE
   WHEN metodo='Captura manual' THEN date_1
   ELSE COALESCE(date_2,date_2_from_eid)
  END date_end
FROM a
)
SELECT 
 cd_event,
 (SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_end'),
 to_char(date_end,'yyyy-mm-dd')::text
FROM b
WHERE date_end IS NOT NULL
RETURNING main.event_extra.cd_event, main.event_extra.cd_var_event_extra, main.event_extra.value_text
;
```

## 5.6 registros

``` sql
SELECT occurrence_id, count(*)
FROM raw_dwc.hormigas_registros 
GROUP BY occurrence_id
HAVING count(*)>1;
```

<div class="knitsql-table">

occurrence_id count ————— ——-

: 0 records

</div>

``` sql

INSERT INTO main.registros(cd_event, cds_recorded_by, date_time, cd_tax, cd_morfo, date_ident, cds_identified_by, qt_int,remarks, occurrence_id, organism_id)
SELECT 
 cd_event,
 cds_recorded_by,
 (e.date_time_begin::date||' '||event_time)::timestamp date_time,
 tt.cd_tax,
 tt.cd_morfo,
 TO_DATE(date_identified,'YYYY-MM-DD') date_ident,
 cds_identified_by,
 organism_quantity::double precision::int qt_int,
 r.event_remarks,
 occurrence_id,
 SPLIT_PART(occurrence_id,':',7) organism_id
 --ROW_NUMBER() OVER (ORDER BY (e.date_time_begin::date||' '||event_time)::timestamp)
 --organism_id::text
FROM raw_dwc.hormigas_registros r
LEFT JOIN raw_dwc.taxonomy_total tt ON tt."row.names"=r."row.names" AND tt.table_orig='hormigas_registros'
LEFT JOIN main.event e USING (cd_event)
ORDER BY date_time
RETURNING cd_event, cds_recorded_by, date_time, cd_tax, cd_morfo, cds_identified_by, qt_int,remarks, occurrence_id, organism_id
```

``` sql
ALTER TABLE raw_dwc.hormigas_registros ADD COLUMN cd_reg int REFERENCES main.registros(cd_reg);
UPDATE raw_dwc.hormigas_registros AS ar
SET cd_reg=r.cd_reg
FROM main.registros r
WHERE ar.cd_event=r.cd_event AND ar.occurrence_id=r.occurrence_id;

-- Check cd_reg are unique in the source table
SELECT cd_reg,count(*) FROM  raw_dwc.hormigas_registros GROUP BY cd_reg HAVING count(*)>1;
```

<div class="knitsql-table">

    cd_reg   count

------------------------------------------------------------------------

: 0 records

</div>

TODO: poner los occurrenceRemarks en individual characteristics para
poder filtrar los alados

# 6 Escarabajos

Para entender el plan de muestreo:

``` sql
WITH a AS(
SELECT event_id,
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3}).*$','\1')::int anh_num,
  CASE
     WHEN event_id ~ '^ANH_[0-9]{1,3}_Captura manual[0-9]_202[12]-[0-9]{2}-[0-9]{2}$' THEN 'Captura manual'
     WHEN event_id ~ '^ANH_[0-9]{1,3}_T. Exc. Human[0-9]_202[12]-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2}$' THEN 'Tramp Exc'
  END metodo,
  CASE
     WHEN event_id ~ '^ANH_[0-9]{1,3}_Captura manual[0-9]_202[12]-[0-9]{2}-[0-9]{2}$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_Captura manual([0-9])_202[12]-[0-9]{2}-[0-9]{2}$','\1')::int
     WHEN event_id ~ '^ANH_[0-9]{1,3}_T. Exc. Human[0-9]_202[12]-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2}$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_T. Exc. Human([0-9])_202[12]-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2}$','\1')::int
  END trap_num,
  CASE
     WHEN event_id ~ '^ANH_[0-9]{1,3}_Captura manual[0-9]_202[12]-[0-9]{2}-[0-9]{2}$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_Captura manual[0-9]_(202[12])-[0-9]{2}-[0-9]{2}$','\1')
     WHEN event_id ~ '^ANH_[0-9]{1,3}_T. Exc. Human[0-9]_202[12]-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2}$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_T. Exc. Human[0-9]_(202[12])-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2}$','\1')
  END "year"
FROM raw_dwc.escarabajos_event
)
SELECT anh_num,"year",metodo,ARRAY_AGG(trap_num ORDER BY trap_num) traps
FROM a
GROUP BY anh_num,"year",metodo
ORDER BY anh_num,"year",metodo
;
```

<div class="knitsql-table">

| anh_num | year | metodo         | traps           |
|--------:|:-----|:---------------|:----------------|
|     108 | 2021 | Captura manual | {1,2,3,4}       |
|     108 | 2021 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     108 | 2022 | Captura manual | {1,2,3,4}       |
|     108 | 2022 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     109 | 2021 | Captura manual | {1,2,3,4}       |
|     109 | 2021 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     109 | 2022 | Captura manual | {1,2,3,4}       |
|     109 | 2022 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     110 | 2021 | Captura manual | {1,2,3,4}       |
|     110 | 2021 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     110 | 2022 | Captura manual | {1,2,3,4}       |
|     110 | 2022 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     112 | 2021 | Captura manual | {1,2,3,4}       |
|     112 | 2021 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     112 | 2022 | Captura manual | {1,2,3,4}       |
|     112 | 2022 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     113 | 2021 | Captura manual | {1,2,3,4}       |
|     113 | 2021 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     113 | 2022 | Captura manual | {1,2,3,4}       |
|     113 | 2022 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     114 | 2021 | Captura manual | {1,2,3,4}       |
|     114 | 2021 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     114 | 2022 | Captura manual | {1,2,3,4}       |
|     114 | 2022 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     115 | 2021 | Captura manual | {1,2,3,4}       |
|     115 | 2021 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     115 | 2022 | Captura manual | {1,2,3,4}       |
|     115 | 2022 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     116 | 2021 | Captura manual | {1,2,3,4}       |
|     116 | 2021 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     116 | 2022 | Captura manual | {1,2,3,4}       |
|     116 | 2022 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     117 | 2021 | Captura manual | {1,2,3,4}       |
|     117 | 2021 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     117 | 2022 | Captura manual | {1,2,3,4}       |
|     117 | 2022 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     118 | 2021 | Captura manual | {1,2}           |
|     118 | 2021 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     118 | 2022 | Captura manual | {1,2,3,4}       |
|     118 | 2022 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     120 | 2021 | Captura manual | {1,2,3,4}       |
|     120 | 2021 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     120 | 2022 | Captura manual | {1,2,3,4}       |
|     120 | 2022 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     121 | 2021 | Captura manual | {1,2,3,4}       |
|     121 | 2021 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     121 | 2022 | Captura manual | {1,2,3,4}       |
|     121 | 2022 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     122 | 2021 | Captura manual | {1,2,3,4}       |
|     122 | 2021 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     122 | 2022 | Captura manual | {1,2,3,4}       |
|     122 | 2022 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     123 | 2021 | Captura manual | {1,2,3,4}       |
|     123 | 2021 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     123 | 2022 | Captura manual | {1,2,3,4}       |
|     123 | 2022 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     125 | 2021 | Captura manual | {1,2,3,4}       |
|     125 | 2021 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     125 | 2022 | Captura manual | {1,2,3,4}       |
|     125 | 2022 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     130 | 2021 | Captura manual | {1,2,3,4}       |
|     130 | 2021 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     130 | 2022 | Captura manual | {1,2,3,4}       |
|     130 | 2022 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     131 | 2021 | Captura manual | {1,2,3,4}       |
|     131 | 2021 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     131 | 2022 | Captura manual | {1,2,3,4}       |
|     131 | 2022 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     132 | 2021 | Captura manual | {1,2,3,4}       |
|     132 | 2021 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     132 | 2022 | Captura manual | {1,2,3,4}       |
|     132 | 2022 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     133 | 2021 | Captura manual | {1,2,3,4}       |
|     133 | 2021 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     133 | 2022 | Captura manual | {1,2,3,4}       |
|     133 | 2022 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     134 | 2021 | Captura manual | {1,2,3,4}       |
|     134 | 2021 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     134 | 2022 | Captura manual | {1,2,3,4}       |
|     134 | 2022 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     135 | 2021 | Captura manual | {1,2,3,4}       |
|     135 | 2021 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     135 | 2022 | Captura manual | {1,2,3,4}       |
|     135 | 2022 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     136 | 2021 | Captura manual | {1,2,3,4}       |
|     136 | 2021 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     136 | 2022 | Captura manual | {1,2,3,4}       |
|     136 | 2022 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     137 | 2021 | Captura manual | {1,2,3,4}       |
|     137 | 2021 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     137 | 2022 | Captura manual | {1,2,3,4}       |
|     137 | 2022 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     138 | 2021 | Captura manual | {1,2,3,4}       |
|     138 | 2021 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     138 | 2022 | Captura manual | {1,2,3,4}       |
|     138 | 2022 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     142 | 2021 | Captura manual | {1,2,3,4}       |
|     142 | 2021 | Tramp Exc      | {1,2,3,4,5,6,7} |
|     142 | 2022 | Captura manual | {1,2,3,4}       |
|     142 | 2022 | Tramp Exc      | {1,2,3,4,5,6,7} |

Displaying records 1 - 100

</div>

## 6.1 ANH

Insertar los datos de anh:

``` sql
INSERT INTO main.punto_referencia(name_pt_ref, num_anh)
WITH a AS(
SELECT
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3}).*$','\1')::int anh_num,
  REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3}).*$','\1') anh_name
FROM raw_dwc.escarabajos_event
)
SELECT anh_name, anh_num
FROM a
GROUP BY anh_name,anh_num
ORDER BY anh_num
ON CONFLICT (name_pt_ref) DO NOTHING
RETURNING cd_pt_ref, name_pt_ref
;
```

dar las referencias en las tablas de escarabajos

``` sql
ALTER TABLE raw_dwc.escarabajos_event ADD COLUMN cd_pt_ref int REFERENCES main.punto_referencia(cd_pt_ref) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE raw_dwc.escarabajos_registros ADD COLUMN cd_pt_ref int REFERENCES main.punto_referencia(cd_pt_ref) ON DELETE SET NULL ON UPDATE CASCADE;

UPDATE raw_dwc.escarabajos_event
SET cd_pt_ref=pr.cd_pt_ref
FROM main.punto_referencia pr
WHERE REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3}).*$','\1') = name_pt_ref
;

UPDATE raw_dwc.escarabajos_registros
SET cd_pt_ref=pr.cd_pt_ref
FROM main.punto_referencia pr
WHERE  REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3}).*$','\1') = name_pt_ref
;

SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

Averiguando que ninguna fila no tenga anh

``` sql
SELECT * FROM raw_dwc.escarabajos_event WHERE cd_pt_ref IS NULL;
```

<div class="knitsql-table">

|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| row.names event_id parent_event_id sample_size_value sample_size_unit sampling_protocol sampling_effort event_date event_time event_remaks habitat location_remarks continent country country_code state_province county locality minimum_elevation_in_meters maximum_elevation_in_meters verbatim_latitude verbatim_longitude verbatim_coordinate_system verbatim_srs decimal_latitude decimal_longitude geodetic_datum coordinate_uncertainty_in_meters institution_code measurement_type\_*plataforma* measurement_value\_*plataforma* measurement_type\_*distancia* measurement_value\_*distancia* measurement_unit\_*distancia* measurement_type\_*habitat_observado* measurement_value\_*habitat_observado* measurement_type\_*prop_cobertura* measurement_value\_*prop_cobertura* cd_pt_ref |

------------------------------------------------------------------------

: 0 records

</div>

``` sql
SELECT * FROM raw_dwc.escarabajos_registros WHERE cd_pt_ref IS NULL;
```

<div class="knitsql-table">

|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| row.names occurrence_id event_id basis_of_record type institution_code collection_code catalog_number dynamic_properties record_number recorded_by organism_quantity organism_quantity_type life_stage preparations sampling_protocol sampling_effort event_date event_time habitat event_remarks identified_by date_identified identification_remarks identification_qualifier scientific_name higher_classification kingdom phylum class order family genus specific_epithet taxon_rank scientific_name_authorship tipo_de_tejido preparación_del_tejido colector_del_tejido cd_pt_ref |

------------------------------------------------------------------------

: 0 records

</div>

## 6.2 Unit, sampling efforts definition, abundance definition, protocolo

No hay nuevas unidades, ni variables que añadir (vamos a utilizar
minutos para el tiempo de sampling effort), y ‘Duración’ para la
variable de sampling effort

``` sql
INSERT INTO main.def_protocol(protocol,protocol_spa,cd_var_samp_eff_1,cd_var_samp_eff_2,samp_eff_1_implicit,samp_eff_2_implicit,cd_var_ind_qt,description_spa)
VALUES(
  'Insect hand collection',
  'Captura manual de insectos',
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Sampling area'),
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Elapsed time'),
  false,
  false,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind='Number of individuals'),
  'Nota: eso no concierne la hormigas, que manejan solamente presence/absence'
),(
  'Human excrement trap',
  'Trampa de excrementos humanos',
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Elapsed time'),
  NULL,
  false,
  NULL,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind='Number of individuals'),
  'Nota: eso no concierne la hormigas, que manejan solamente presence/absence'
)
RETURNING cd_protocol,protocol,protocol_spa;
```

## 6.3 Personas

``` sql
INSERT INTO main.people(verbatim_person)
WITH a AS(
SELECT DISTINCT INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(recorded_by, ' | ')))) AS name_person
FROM raw_dwc.escarabajos_registros
UNION
SELECT DISTINCT INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(identified_by, ' | '))))
FROM raw_dwc.escarabajos_registros
)
SELECT DISTINCT REGEXP_REPLACE(name_person, '- ','-')
FROM a 
ORDER BY REGEXP_REPLACE(name_person, '- ','-')
ON CONFLICT(verbatim_person) DO NOTHING
RETURNING cd_person, verbatim_person
```

Dar los codigos a las tables de origen:

``` sql
ALTER TABLE raw_dwc.escarabajos_registros ADD COLUMN cds_recorded_by int[];

WITH a AS(
SELECT "row.names", REGEXP_REPLACE(INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(recorded_by, ' | ')))),'- ','-') AS name_person
FROM raw_dwc.escarabajos_registros
),b AS(
SELECT "row.names", ARRAY_AGG(cd_person) cds
FROM a 
LEFT JOIN main.people p ON a.name_person=p.verbatim_person
GROUP BY "row.names"
)
UPDATE raw_dwc.escarabajos_registros AS r
SET cds_recorded_by=b.cds
FROM b
WHERE r."row.names"=b."row.names"
RETURNING r."row.names", cds_recorded_by
;

ALTER TABLE raw_dwc.escarabajos_registros ADD COLUMN cds_identified_by int[];

WITH a AS(
SELECT "row.names", REGEXP_REPLACE(INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(identified_by, ' | ')))),'- ','-') AS name_person
FROM raw_dwc.escarabajos_registros
),b AS(
SELECT "row.names", ARRAY_AGG(cd_person) cds
FROM a 
LEFT JOIN main.people p ON a.name_person=p.verbatim_person
GROUP BY "row.names"
)
UPDATE raw_dwc.escarabajos_registros AS r
SET cds_identified_by=b.cds
FROM b
WHERE r."row.names"=b."row.names"
RETURNING r."row.names", cds_identified_by
;

SELECT 1;
```

<div class="knitsql-table">

| ?column? |
|---------:|
|        1 |

1 records

</div>

## 6.4 gp_event

``` sql
WITH a AS(
SELECT 
  event_id,
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3}).*$','\1')::int anh_num,
  CASE
     WHEN event_id ~ '^ANH_[0-9]{1,3}_Captura manual[0-9]_202[12]-[0-9]{2}-[0-9]{2}$' THEN 'Captura manual'
     WHEN event_id ~ '^ANH_[0-9]{1,3}_T. Exc. Human[0-9]_202[12]-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2}$' THEN 'Tramp Exc'
  END metodo,
  CASE
     WHEN event_id ~ '^ANH_[0-9]{1,3}_Captura manual[0-9]_202[12]-[0-9]{2}-[0-9]{2}$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_Captura manual([0-9])_202[12]-[0-9]{2}-[0-9]{2}$','\1')::int
     WHEN event_id ~ '^ANH_[0-9]{1,3}_T. Exc. Human[0-9]_202[12]-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2}$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_T. Exc. Human([0-9])_202[12]-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2}$','\1')::int
  END trap_num,
  CASE
     WHEN event_id ~ '^ANH_[0-9]{1,3}_Captura manual[0-9]_202[12]-[0-9]{2}-[0-9]{2}$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_Captura manual[0-9]_(202[12])-[0-9]{2}-[0-9]{2}$','\1')
     WHEN event_id ~ '^ANH_[0-9]{1,3}_T. Exc. Human[0-9]_202[12]-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2}$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_T. Exc. Human[0-9]_(202[12])-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2}$','\1')
  END año
FROM raw_dwc.escarabajos_event
)
SELECT año, anh_num,metodo, ARRAY_AGG(trap_num), count(*)
FROM a
GROUP BY año, anh_num, metodo
ORDER BY año, anh_num, metodo
;
```

<div class="knitsql-table">

| año  | anh_num | metodo         | array_agg       | count |
|:-----|--------:|:---------------|:----------------|------:|
| 2021 |     108 | Captura manual | {1,4,2,3}       |     4 |
| 2021 |     108 | Tramp Exc      | {6,7,1,2,3,4,5} |     7 |
| 2021 |     109 | Captura manual | {4,2,1,3}       |     4 |
| 2021 |     109 | Tramp Exc      | {5,2,1,6,7,4,3} |     7 |
| 2021 |     110 | Captura manual | {4,3,1,2}       |     4 |
| 2021 |     110 | Tramp Exc      | {7,6,3,5,1,4,2} |     7 |
| 2021 |     112 | Captura manual | {2,4,3,1}       |     4 |
| 2021 |     112 | Tramp Exc      | {6,2,3,4,5,1,7} |     7 |
| 2021 |     113 | Captura manual | {2,1,3,4}       |     4 |
| 2021 |     113 | Tramp Exc      | {7,1,6,5,4,3,2} |     7 |
| 2021 |     114 | Captura manual | {1,2,4,3}       |     4 |
| 2021 |     114 | Tramp Exc      | {5,1,3,2,7,6,4} |     7 |
| 2021 |     115 | Captura manual | {4,1,2,3}       |     4 |
| 2021 |     115 | Tramp Exc      | {4,5,6,7,2,3,1} |     7 |
| 2021 |     116 | Captura manual | {3,2,4,1}       |     4 |
| 2021 |     116 | Tramp Exc      | {3,4,5,6,1,7,2} |     7 |
| 2021 |     117 | Captura manual | {1,2,3,4}       |     4 |
| 2021 |     117 | Tramp Exc      | {7,2,1,6,5,4,3} |     7 |
| 2021 |     118 | Captura manual | {1,2}           |     2 |
| 2021 |     118 | Tramp Exc      | {3,4,5,6,1,7,2} |     7 |
| 2021 |     120 | Captura manual | {3,4,2,1}       |     4 |
| 2021 |     120 | Tramp Exc      | {7,3,6,4,5,2,1} |     7 |
| 2021 |     121 | Captura manual | {2,1,4,3}       |     4 |
| 2021 |     121 | Tramp Exc      | {6,7,3,1,2,4,5} |     7 |
| 2021 |     122 | Captura manual | {4,1,2,3}       |     4 |
| 2021 |     122 | Tramp Exc      | {6,7,5,4,3,2,1} |     7 |
| 2021 |     123 | Captura manual | {2,4,3,1}       |     4 |
| 2021 |     123 | Tramp Exc      | {4,6,7,5,1,2,3} |     7 |
| 2021 |     125 | Captura manual | {4,2,3,1}       |     4 |
| 2021 |     125 | Tramp Exc      | {1,2,3,4,5,6,7} |     7 |
| 2021 |     130 | Captura manual | {1,4,2,3}       |     4 |
| 2021 |     130 | Tramp Exc      | {6,7,5,4,3,2,1} |     7 |
| 2021 |     131 | Captura manual | {2,4,3,1}       |     4 |
| 2021 |     131 | Tramp Exc      | {4,3,5,6,1,7,2} |     7 |
| 2021 |     132 | Captura manual | {4,1,2,3}       |     4 |
| 2021 |     132 | Tramp Exc      | {7,1,2,3,4,5,6} |     7 |
| 2021 |     133 | Captura manual | {2,4,1,3}       |     4 |
| 2021 |     133 | Tramp Exc      | {2,5,1,3,4,6,7} |     7 |
| 2021 |     134 | Captura manual | {2,1,4,3}       |     4 |
| 2021 |     134 | Tramp Exc      | {4,5,7,6,1,2,3} |     7 |
| 2021 |     135 | Captura manual | {4,1,2,3}       |     4 |
| 2021 |     135 | Tramp Exc      | {1,2,3,4,5,6,7} |     7 |
| 2021 |     136 | Captura manual | {3,2,1,4}       |     4 |
| 2021 |     136 | Tramp Exc      | {6,7,5,4,3,2,1} |     7 |
| 2021 |     137 | Captura manual | {2,1,4,3}       |     4 |
| 2021 |     137 | Tramp Exc      | {2,1,7,6,5,4,3} |     7 |
| 2021 |     138 | Captura manual | {3,1,4,2}       |     4 |
| 2021 |     138 | Tramp Exc      | {6,1,3,2,4,5,7} |     7 |
| 2021 |     142 | Captura manual | {2,1,3,4}       |     4 |
| 2021 |     142 | Tramp Exc      | {1,2,3,4,5,6,7} |     7 |
| 2021 |     144 | Captura manual | {1,2,3,4}       |     4 |
| 2021 |     144 | Tramp Exc      | {1,2,3,4,5,6,7} |     7 |
| 2021 |     145 | Captura manual | {4,3,2,1}       |     4 |
| 2021 |     145 | Tramp Exc      | {2,1,3,4,5,6}   |     6 |
| 2021 |     147 | Captura manual | {2,1,5,4,3}     |     5 |
| 2021 |     147 | Tramp Exc      | {7,5,3,2,1,6,4} |     7 |
| 2021 |     365 | Captura manual | {4,1,2,3}       |     4 |
| 2021 |     365 | Tramp Exc      | {7,2,3,4,5,1,6} |     7 |
| 2021 |     366 | Captura manual | {3,1,4,2}       |     4 |
| 2021 |     366 | Tramp Exc      | {1,4,6,3,2,5,7} |     7 |
| 2021 |     368 | Captura manual | {1,3,4,2}       |     4 |
| 2021 |     368 | Tramp Exc      | {5,4,3,2,1,6,7} |     7 |
| 2021 |     369 | Captura manual | {4,2,1,3}       |     4 |
| 2021 |     369 | Tramp Exc      | {3,7,6,5,2,4,1} |     7 |
| 2021 |     370 | Captura manual | {2,1,4,3}       |     4 |
| 2021 |     370 | Tramp Exc      | {1,7,6,5,4,3,2} |     7 |
| 2021 |     371 | Captura manual | {2,4,1,3}       |     4 |
| 2021 |     371 | Tramp Exc      | {1,7,6,5,4,3,2} |     7 |
| 2021 |     372 | Captura manual | {2,4,3,1}       |     4 |
| 2021 |     372 | Tramp Exc      | {4,1,2,7,6,3,5} |     7 |
| 2021 |     373 | Captura manual | {3,4,2,1}       |     4 |
| 2021 |     373 | Tramp Exc      | {1,2,6,5,4,3,7} |     7 |
| 2021 |     374 | Captura manual | {2,3,1,4}       |     4 |
| 2021 |     374 | Tramp Exc      | {3,6,5,7,1,2,4} |     7 |
| 2021 |     391 | Captura manual | {4,2,1,3}       |     4 |
| 2021 |     391 | Tramp Exc      | {5,7,6,4,3,2,1} |     7 |
| 2021 |     392 | Captura manual | {4,1,2,3}       |     4 |
| 2021 |     392 | Tramp Exc      | {2,1,7,6,5,4,3} |     7 |
| 2021 |     394 | Captura manual | {4,1,2,3}       |     4 |
| 2021 |     394 | Tramp Exc      | {3,4,5,6,7,2,1} |     7 |
| 2022 |     108 | Captura manual | {1,3,2,4}       |     4 |
| 2022 |     108 | Tramp Exc      | {6,2,3,4,5,1,7} |     7 |
| 2022 |     109 | Captura manual | {1,2,4,3}       |     4 |
| 2022 |     109 | Tramp Exc      | {5,6,2,7,1,4,3} |     7 |
| 2022 |     110 | Captura manual | {4,1,2,3}       |     4 |
| 2022 |     110 | Tramp Exc      | {4,1,3,5,2,6,7} |     7 |
| 2022 |     112 | Captura manual | {4,2,3,1}       |     4 |
| 2022 |     112 | Tramp Exc      | {7,1,2,3,4,5,6} |     7 |
| 2022 |     113 | Captura manual | {2,3,4,1}       |     4 |
| 2022 |     113 | Tramp Exc      | {5,1,6,2,3,7,4} |     7 |
| 2022 |     114 | Captura manual | {2,4,3,1}       |     4 |
| 2022 |     114 | Tramp Exc      | {7,4,5,6,2,1,3} |     7 |
| 2022 |     115 | Captura manual | {1,2,3,4}       |     4 |
| 2022 |     115 | Tramp Exc      | {2,1,3,4,5,7,6} |     7 |
| 2022 |     116 | Captura manual | {2,3,1,4}       |     4 |
| 2022 |     116 | Tramp Exc      | {1,6,4,3,5,7,2} |     7 |
| 2022 |     117 | Captura manual | {3,2,4,1}       |     4 |
| 2022 |     117 | Tramp Exc      | {5,3,1,2,7,6,4} |     7 |
| 2022 |     118 | Captura manual | {3,1,4,2}       |     4 |
| 2022 |     118 | Tramp Exc      | {3,6,5,1,4,7,2} |     7 |

Displaying records 1 - 100

</div>

Because there is more than a method, the number of the campaign should
be determined this way:

``` sql
WITH a AS(
SELECT 
  event_id,
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3}).*$','\1')::int anh_num,
  CASE
     WHEN event_id ~ '^ANH_[0-9]{1,3}_Captura manual[0-9]_202[12]-[0-9]{2}-[0-9]{2}$' THEN 'Captura manual'
     WHEN event_id ~ '^ANH_[0-9]{1,3}_T. Exc. Human[0-9]_202[12]-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2}$' THEN 'Tramp Exc'
  END metodo,
  CASE
     WHEN event_id ~ '^ANH_[0-9]{1,3}_Captura manual[0-9]_202[12]-[0-9]{2}-[0-9]{2}$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_Captura manual([0-9])_202[12]-[0-9]{2}-[0-9]{2}$','\1')::int
     WHEN event_id ~ '^ANH_[0-9]{1,3}_T. Exc. Human[0-9]_202[12]-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2}$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_T. Exc. Human([0-9])_202[12]-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2}$','\1')::int
  END trap_num,
  CASE
     WHEN event_id ~ '^ANH_[0-9]{1,3}_Captura manual[0-9]_202[12]-[0-9]{2}-[0-9]{2}$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_Captura manual[0-9]_(202[12])-[0-9]{2}-[0-9]{2}$','\1')
     WHEN event_id ~ '^ANH_[0-9]{1,3}_T. Exc. Human[0-9]_202[12]-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2}$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_T. Exc. Human[0-9]_(202[12])-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2}$','\1')
  END año
FROM raw_dwc.escarabajos_event
)
SELECT año, anh_num, ROW_NUMBER() OVER (PARTITION BY anh_num ORDER BY año) campaign_nb
FROM a
GROUP BY año, anh_num
ORDER BY año, anh_num
;
```

<div class="knitsql-table">

| año  | anh_num | campaign_nb |
|:-----|--------:|------------:|
| 2021 |     108 |           1 |
| 2021 |     109 |           1 |
| 2021 |     110 |           1 |
| 2021 |     112 |           1 |
| 2021 |     113 |           1 |
| 2021 |     114 |           1 |
| 2021 |     115 |           1 |
| 2021 |     116 |           1 |
| 2021 |     117 |           1 |
| 2021 |     118 |           1 |
| 2021 |     120 |           1 |
| 2021 |     121 |           1 |
| 2021 |     122 |           1 |
| 2021 |     123 |           1 |
| 2021 |     125 |           1 |
| 2021 |     130 |           1 |
| 2021 |     131 |           1 |
| 2021 |     132 |           1 |
| 2021 |     133 |           1 |
| 2021 |     134 |           1 |
| 2021 |     135 |           1 |
| 2021 |     136 |           1 |
| 2021 |     137 |           1 |
| 2021 |     138 |           1 |
| 2021 |     142 |           1 |
| 2021 |     144 |           1 |
| 2021 |     145 |           1 |
| 2021 |     147 |           1 |
| 2021 |     365 |           1 |
| 2021 |     366 |           1 |
| 2021 |     368 |           1 |
| 2021 |     369 |           1 |
| 2021 |     370 |           1 |
| 2021 |     371 |           1 |
| 2021 |     372 |           1 |
| 2021 |     373 |           1 |
| 2021 |     374 |           1 |
| 2021 |     391 |           1 |
| 2021 |     392 |           1 |
| 2021 |     394 |           1 |
| 2022 |     108 |           2 |
| 2022 |     109 |           2 |
| 2022 |     110 |           2 |
| 2022 |     112 |           2 |
| 2022 |     113 |           2 |
| 2022 |     114 |           2 |
| 2022 |     115 |           2 |
| 2022 |     116 |           2 |
| 2022 |     117 |           2 |
| 2022 |     118 |           2 |
| 2022 |     120 |           2 |
| 2022 |     121 |           2 |
| 2022 |     122 |           2 |
| 2022 |     123 |           2 |
| 2022 |     125 |           2 |
| 2022 |     130 |           2 |
| 2022 |     131 |           2 |
| 2022 |     132 |           2 |
| 2022 |     133 |           2 |
| 2022 |     134 |           2 |
| 2022 |     135 |           2 |
| 2022 |     136 |           2 |
| 2022 |     137 |           2 |
| 2022 |     138 |           2 |
| 2022 |     142 |           2 |
| 2022 |     144 |           2 |
| 2022 |     145 |           2 |
| 2022 |     147 |           2 |
| 2022 |     365 |           2 |
| 2022 |     366 |           2 |
| 2022 |     368 |           2 |
| 2022 |     369 |           2 |
| 2022 |     370 |           2 |
| 2022 |     371 |           2 |
| 2022 |     372 |           2 |
| 2022 |     373 |           2 |
| 2022 |     374 |           2 |
| 2022 |     391 |           2 |
| 2022 |     392 |           2 |
| 2022 |     394 |           2 |

80 records

</div>

``` sql
INSERT INTO main.gp_event(cd_gp_biol,cd_protocol,cd_pt_ref,campaign_nb)
WITH a AS(
SELECT 
  event_id,
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3}).*$','\1')::int anh_num,
  CASE
     WHEN event_id ~ '^ANH_[0-9]{1,3}_Captura manual[0-9]_202[12]-[0-9]{2}-[0-9]{2}$' THEN 'Captura manual'
     WHEN event_id ~ '^ANH_[0-9]{1,3}_T. Exc. Human[0-9]_202[12]-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2}$' THEN 'Tramp Exc'
  END metodo,
  CASE
     WHEN event_id ~ '^ANH_[0-9]{1,3}_Captura manual[0-9]_202[12]-[0-9]{2}-[0-9]{2}$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_Captura manual([0-9])_202[12]-[0-9]{2}-[0-9]{2}$','\1')::int
     WHEN event_id ~ '^ANH_[0-9]{1,3}_T. Exc. Human[0-9]_202[12]-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2}$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_T. Exc. Human([0-9])_202[12]-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2}$','\1')::int
  END trap_num,
  CASE
     WHEN event_id ~ '^ANH_[0-9]{1,3}_Captura manual[0-9]_202[12]-[0-9]{2}-[0-9]{2}$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_Captura manual[0-9]_(202[12])-[0-9]{2}-[0-9]{2}$','\1')
     WHEN event_id ~ '^ANH_[0-9]{1,3}_T. Exc. Human[0-9]_202[12]-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2}$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_T. Exc. Human[0-9]_(202[12])-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2}$','\1')
  END año,
  cd_pt_ref
FROM raw_dwc.escarabajos_event
), campaign AS(
SELECT año, anh_num, ROW_NUMBER() OVER (PARTITION BY anh_num ORDER BY año) campaign_nb
FROM a
GROUP BY año, anh_num
ORDER BY año, anh_num
)
SELECT 'esca',
  CASE
    WHEN metodo='Captura manual' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Insect hand collection')
    WHEN metodo='Tramp Exc' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Human excrement trap')
  END cd_protocol,
  cd_pt_ref,
  c.campaign_nb
FROM a
LEFT JOIN campaign c USING (año, anh_num)
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
GROUP BY cd_pt_ref, name_pt_ref, año, metodo, c.campaign_nb
ORDER BY año,cd_pt_ref,cd_protocol
RETURNING cd_gp_event,cd_gp_biol,cd_protocol,cd_pt_ref,campaign_nb
;
```

Attributing the gp_event

``` sql
ALTER TABLE raw_dwc.escarabajos_event ADD COLUMN cd_gp_event int REFERENCES main.gp_event(cd_gp_event) ON DELETE SET NULL;


WITH a AS(
SELECT 
  event_id,
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3}).*$','\1')::int anh_num,
  CASE
     WHEN event_id ~ '^ANH_[0-9]{1,3}_Captura manual[0-9]_202[12]-[0-9]{2}-[0-9]{2}$' THEN 'Captura manual'
     WHEN event_id ~ '^ANH_[0-9]{1,3}_T. Exc. Human[0-9]_202[12]-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2}$' THEN 'Tramp Exc'
  END metodo,
  CASE
     WHEN event_id ~ '^ANH_[0-9]{1,3}_Captura manual[0-9]_202[12]-[0-9]{2}-[0-9]{2}$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_Captura manual([0-9])_202[12]-[0-9]{2}-[0-9]{2}$','\1')::int
     WHEN event_id ~ '^ANH_[0-9]{1,3}_T. Exc. Human[0-9]_202[12]-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2}$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_T. Exc. Human([0-9])_202[12]-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2}$','\1')::int
  END trap_num,
  CASE
     WHEN event_id ~ '^ANH_[0-9]{1,3}_Captura manual[0-9]_202[12]-[0-9]{2}-[0-9]{2}$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_Captura manual[0-9]_(202[12])-[0-9]{2}-[0-9]{2}$','\1')
     WHEN event_id ~ '^ANH_[0-9]{1,3}_T. Exc. Human[0-9]_202[12]-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2}$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_T. Exc. Human[0-9]_(202[12])-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2}$','\1')
  END año,
  cd_pt_ref
FROM raw_dwc.escarabajos_event
), campaign AS(
SELECT año, anh_num, ROW_NUMBER() OVER (PARTITION BY anh_num ORDER BY año) campaign_nb
FROM a
GROUP BY año, anh_num
ORDER BY año, anh_num
),b AS(
SELECT event_id,
  CASE
    WHEN metodo='Captura manual' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Insect hand collection')
    WHEN metodo='Tramp Exc' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Human excrement trap')
  END cd_protocol,
  cd_pt_ref,
  c.campaign_nb
FROM a
LEFT JOIN campaign c USING (año, anh_num)
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
),d AS(
SELECT b.*, cd_gp_event
FROM b
LEFT JOIN main.gp_event ge ON cd_gp_biol='esca' AND b.cd_protocol=ge.cd_protocol AND b.cd_pt_ref=ge.cd_pt_ref AND b.campaign_nb=ge.campaign_nb
)
UPDATE raw_dwc.escarabajos_event e
SET cd_gp_event=d.cd_gp_event
FROM d
WHERE d.event_id=e.event_id
RETURNING e.event_id, e.cd_gp_event
;
```

<div class="knitsql-table">

| event_id                                     | cd_gp_event |
|:---------------------------------------------|------------:|
| ANH_113_T. Exc. Human1_2021-07-16/2021-07-18 |         509 |
| ANH_117_T. Exc. Human2_2021-07-06/2021-07-08 |         493 |
| ANH_108_Captura manual1_2021-07-14           |         502 |
| ANH_108_Captura manual1_2022-03-31           |         582 |
| ANH_108_Captura manual2_2021-07-14           |         502 |
| ANH_108_Captura manual2_2022-03-31           |         582 |
| ANH_108_Captura manual3_2021-07-15           |         502 |
| ANH_108_Captura manual3_2022-03-31           |         582 |
| ANH_108_Captura manual4_2021-07-15           |         502 |
| ANH_108_Captura manual4_2022-03-31           |         582 |
| ANH_108_T. Exc. Human1_2021-07-13/2021-07-15 |         503 |
| ANH_108_T. Exc. Human1_2022-03-29/2022-03-31 |         583 |
| ANH_108_T. Exc. Human2_2021-07-13/2021-07-15 |         503 |
| ANH_108_T. Exc. Human2_2022-03-29/2022-03-31 |         583 |
| ANH_108_T. Exc. Human3_2021-07-13/2021-07-15 |         503 |
| ANH_108_T. Exc. Human3_2022-03-29/2022-03-31 |         583 |
| ANH_108_T. Exc. Human4_2021-07-13/2021-07-15 |         503 |
| ANH_121_Captura manual2_2021-07-22           |         520 |
| ANH_108_T. Exc. Human4_2022-03-29/2022-03-31 |         583 |
| ANH_108_T. Exc. Human5_2021-07-13/2021-07-15 |         503 |
| ANH_108_T. Exc. Human5_2022-03-29/2022-03-31 |         583 |
| ANH_108_T. Exc. Human6_2021-07-13/2021-07-15 |         503 |
| ANH_108_T. Exc. Human6_2022-03-29/2022-03-31 |         583 |
| ANH_108_T. Exc. Human7_2021-07-13/2021-07-15 |         503 |
| ANH_108_T. Exc. Human7_2022-03-29/2022-03-31 |         583 |
| ANH_109_Captura manual1_2021-07-15           |         490 |
| ANH_109_Captura manual1_2022-04-06           |         570 |
| ANH_109_Captura manual2_2021-07-15           |         490 |
| ANH_109_Captura manual2_2022-04-06           |         570 |
| ANH_109_Captura manual3_2022-04-06           |         570 |
| ANH_109_Captura manual4_2022-04-06           |         570 |
| ANH_109_T. Exc. Human1_2021-07-15/2021-07-17 |         491 |
| ANH_109_T. Exc. Human1_2022-04-05/2022-04-07 |         571 |
| ANH_109_T. Exc. Human2_2021-07-15/2021-07-17 |         491 |
| ANH_109_T. Exc. Human2_2022-04-05/2022-04-07 |         571 |
| ANH_109_T. Exc. Human3_2021-07-15/2021-07-17 |         491 |
| ANH_109_T. Exc. Human3_2022-04-05/2022-04-07 |         571 |
| ANH_109_T. Exc. Human4_2021-07-15/2021-07-17 |         491 |
| ANH_109_T. Exc. Human4_2022-04-05/2022-04-07 |         571 |
| ANH_109_T. Exc. Human5_2021-07-15/2021-07-17 |         491 |
| ANH_109_T. Exc. Human5_2022-04-05/2022-04-07 |         571 |
| ANH_109_T. Exc. Human6_2021-07-15/2021-07-17 |         491 |
| ANH_109_T. Exc. Human6_2022-04-05/2022-04-07 |         571 |
| ANH_109_T. Exc. Human7_2021-07-15/2021-07-17 |         491 |
| ANH_109_T. Exc. Human7_2022-04-05/2022-04-07 |         571 |
| ANH_110_Captura manual1_2021-07-17           |         504 |
| ANH_110_Captura manual1_2022-04-04           |         584 |
| ANH_110_Captura manual2_2021-07-17           |         504 |
| ANH_110_Captura manual2_2022-04-04           |         584 |
| ANH_110_Captura manual3_2021-07-17           |         504 |
| ANH_110_Captura manual3_2022-04-04           |         584 |
| ANH_110_Captura manual4_2021-07-17           |         504 |
| ANH_110_Captura manual4_2022-04-04           |         584 |
| ANH_110_T. Exc. Human1_2021-07-15/2021-07-17 |         505 |
| ANH_110_T. Exc. Human1_2022-04-04/2022-04-06 |         585 |
| ANH_110_T. Exc. Human2_2021-07-15/2021-07-17 |         505 |
| ANH_112_Captura manual2_2021-07-12           |         506 |
| ANH_110_T. Exc. Human2_2022-04-04/2022-04-06 |         585 |
| ANH_110_T. Exc. Human3_2021-07-15/2021-07-17 |         505 |
| ANH_110_T. Exc. Human3_2022-04-04/2022-04-06 |         585 |
| ANH_110_T. Exc. Human4_2021-07-15/2021-07-17 |         505 |
| ANH_110_T. Exc. Human4_2022-04-04/2022-04-06 |         585 |
| ANH_110_T. Exc. Human5_2021-07-15/2021-07-17 |         505 |
| ANH_110_T. Exc. Human5_2022-04-04/2022-04-06 |         585 |
| ANH_110_T. Exc. Human6_2021-07-15/2021-07-17 |         505 |
| ANH_110_T. Exc. Human6_2022-04-04/2022-04-06 |         585 |
| ANH_110_T. Exc. Human7_2021-07-15/2021-07-17 |         505 |
| ANH_110_T. Exc. Human7_2022-04-04/2022-04-06 |         585 |
| ANH_112_Captura manual1_2021-07-12           |         506 |
| ANH_112_Captura manual1_2022-03-30           |         586 |
| ANH_112_Captura manual2_2022-03-30           |         586 |
| ANH_112_Captura manual3_2021-07-13           |         506 |
| ANH_112_Captura manual3_2022-03-30           |         586 |
| ANH_112_Captura manual4_2021-07-13           |         506 |
| ANH_112_Captura manual4_2022-03-30           |         586 |
| ANH_112_T. Exc. Human1_2021-07-12/2021-07-14 |         507 |
| ANH_112_T. Exc. Human1_2022-03-29/2022-03-31 |         587 |
| ANH_112_T. Exc. Human2_2021-07-12/2021-07-14 |         507 |
| ANH_112_T. Exc. Human2_2022-03-29/2022-03-31 |         587 |
| ANH_112_T. Exc. Human3_2021-07-12/2021-07-14 |         507 |
| ANH_112_T. Exc. Human3_2022-03-29/2022-03-31 |         587 |
| ANH_112_T. Exc. Human4_2021-07-12/2021-07-14 |         507 |
| ANH_112_T. Exc. Human4_2022-03-29/2022-03-31 |         587 |
| ANH_112_T. Exc. Human5_2021-07-12/2021-07-14 |         507 |
| ANH_112_T. Exc. Human5_2022-03-29/2022-03-31 |         587 |
| ANH_112_T. Exc. Human6_2021-07-12/2021-07-14 |         507 |
| ANH_112_T. Exc. Human6_2022-03-29/2022-03-31 |         587 |
| ANH_112_T. Exc. Human7_2021-07-12/2021-07-14 |         507 |
| ANH_112_T. Exc. Human7_2022-03-29/2022-03-31 |         587 |
| ANH_113_Captura manual1_2021-07-16           |         508 |
| ANH_113_Captura manual1_2022-04-05           |         588 |
| ANH_113_Captura manual2_2021-07-16           |         508 |
| ANH_113_Captura manual2_2022-04-05           |         588 |
| ANH_113_Captura manual3_2021-07-16           |         508 |
| ANH_113_Captura manual3_2022-04-05           |         588 |
| ANH_113_Captura manual4_2021-07-16           |         508 |
| ANH_117_T. Exc. Human1_2021-07-06/2021-07-08 |         493 |
| ANH_113_Captura manual4_2022-04-05           |         588 |
| ANH_113_T. Exc. Human1_2022-04-05/2022-04-07 |         589 |
| ANH_113_T. Exc. Human2_2021-07-16/2021-07-18 |         509 |

Displaying records 1 - 100

</div>

## 6.5 event

Note that a lot of temporal information is lacking…

We need to add “esca” to the event_id, otherwise it can be on conflict
with the ants

``` sql
INSERT INTO main.event(cd_gp_event,event_id,num_replicate, description_replicate, date_time_begin, date_time_end, locality_verb, event_remarks, samp_effort_1, samp_effort_2, pt_geom)
WITH a AS(
SELECT cd_gp_event,
  event_id, 
  CASE
     WHEN event_id ~ '^ANH_[0-9]{1,3}_Captura manual[0-9]_202[12]-[0-9]{2}-[0-9]{2}$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_Captura manual([0-9])_202[12]-[0-9]{2}-[0-9]{2}$','\1')::int
     WHEN event_id ~ '^ANH_[0-9]{1,3}_T. Exc. Human[0-9]_202[12]-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2}$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_T. Exc. Human([0-9])_202[12]-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2}$','\1')::int
  END num_replicate,
  CASE
     WHEN event_id ~ '^ANH_[0-9]{1,3}_Captura manual[0-9]_202[12]-[0-9]{2}-[0-9]{2}$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_Captura manual([0-9]_202[12]-[0-9]{2}-[0-9]{2})$','\1')
     WHEN event_id ~ '^ANH_[0-9]{1,3}_T. Exc. Human[0-9]_202[12]-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2}$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_T. Exc. Human([0-9]_202[12]-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2})$','\1')
  END description_replicate,
  TO_DATE(SPLIT_PART(event_date,'/',1), 'YYYY-MM-DD') date_1,
  CASE 
    WHEN SPLIT_PART(event_date,'/',2)='' THEN NULL
    ELSE TO_DATE(SPLIT_PART(event_date,'/',2), 'YYYY-MM-DD')
  END date_2,
  REGEXP_REPLACE(SPLIT_PART(event_time,'/',1),'\s+','','g') hora_1,
  CASE
    WHEN REGEXP_REPLACE(SPLIT_PART(event_time,'/',2),'\s+','','g')='' THEN NULL
    ELSE REGEXP_REPLACE(SPLIT_PART(event_time,'/',2),'\s+','','g')
  END hora_2,
  locality locality_verb,
  sample_size_value,
  sampling_effort,
  location_remarks event_remarks,
  decimal_latitude::double precision,
  decimal_longitude::double precision
FROM raw_dwc.escarabajos_event
),b AS(--calculation of timestamps and coordinates
SELECT 
  cd_gp_event,
  event_id, 
  num_replicate,
  description_replicate,
  CASE
    WHEN date_1 IS NULL OR hora_1 IS NULL THEN NULL
    ELSE (date_1||' '||hora_1)::timestamp 
  END date_time_begin,
  CASE
    WHEN protocol='Insect hand collection' AND date_1 IS NOT NULL AND hora_2 IS NOT NULL THEN (date_1||' '||hora_2)::timestamp
    WHEN date_2 IS NULL OR hora_2 IS NULL THEN NULL
    ELSE (date_2||' '||hora_2)::timestamp
  END date_time_end,
  locality_verb,
  event_remarks ,
  sample_size_value,
  sampling_effort,
  ST_SetSRID(ST_Transform(ST_SetSRID(ST_MakePoint(decimal_longitude,decimal_latitude),4326), (SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)),3116) pt_geom
FROM a
LEFT JOIN main.gp_event USING (cd_gp_event)
LEFT JOIN main.def_protocol p USING (cd_protocol)
ORDER BY cd_gp_event, event_id, num_replicate
)--calculation of sampling efforts
SELECT
  cd_gp_event,
  'esca_'||event_id event_id,
  num_replicate,
  description_replicate,
  date_time_begin,
  date_time_end,
  locality_verb,
  event_remarks,
  CASE
   WHEN protocol='Insect hand collection' THEN sample_size_value
   WHEN protocol='Human excrement trap' AND (date_time_begin IS NULL OR date_time_end IS NULL) THEN (REGEXP_REPLACE(sampling_effort,' horas','')::int)*60
   WHEN protocol='Human excrement trap' AND date_time_begin IS NOT NULL AND date_time_end IS NOT NULL THEN (EXTRACT('EPOCH' FROM (date_time_end-date_time_begin))/60)::int
   ELSE NULL
  END samp_eff_1,
  CASE
   WHEN protocol='Insect hand collection' AND date_time_begin IS NOT NULL AND date_time_end IS NOT NULL THEN (EXTRACT('EPOCH' FROM (date_time_end-date_time_begin))/60)::int
   ELSE NULL
  END samp_eff_2,
  pt_geom
FROM b
LEFT JOIN main.gp_event USING (cd_gp_event)
LEFT JOIN main.def_protocol p USING (cd_protocol)
ORDER BY cd_gp_event, event_id, num_replicate

RETURNING main.event.cd_event, main.event.cd_gp_event, main.event.event_id, main.event.num_replicate, main.event.description_replicate, main.event.date_time_begin, main.event.date_time_end, main.event.locality_verb, main.event.event_remarks, main.event.pt_geom
```

Damos los cd_event a todos las filas:

``` sql
ALTER TABLE raw_dwc.escarabajos_event ADD COLUMN cd_event int REFERENCES main.event(cd_event) ON DELETE SET NULL;
ALTER TABLE raw_dwc.escarabajos_registros ADD COLUMN cd_event int REFERENCES main.event(cd_event);

UPDATE raw_dwc.escarabajos_event AS t
SET cd_event=e.cd_event
FROM main.event e
WHERE 'esca_'||t.event_id=e.event_id;

UPDATE raw_dwc.escarabajos_registros AS t
SET cd_event=e.cd_event
FROM main.event e
WHERE 'esca_'||t.event_id=e.event_id;

SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

Añadir fechas en la tabla extra cuando las horas no son disponibles

``` sql
INSERT INTO main.event_extra(cd_event, cd_var_event_extra,value_text)
WITH a AS(
SELECT cd_event,ef.date_time_begin,
  TO_DATE(SPLIT_PART(event_date,'/',1), 'YYYY-MM-DD') date_1
FROM raw_dwc.escarabajos_event e
LEFT JOIN main.event ef USING (cd_event)
WHERE date_time_begin IS NULL
),b AS(
SELECT cd_event,
  CASE
   WHEN date_time_begin IS NULL THEN date_1
   ELSE NULL
  END date_begin
FROM a
)
SELECT 
 cd_event,
 (SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin'),
 to_char(date_begin,'yyyy-mm-dd')::text
FROM b
WHERE date_begin IS NOT NULL
RETURNING main.event_extra.cd_event, main.event_extra.cd_var_event_extra, main.event_extra.value_text
;

INSERT INTO main.event_extra(cd_event, cd_var_event_extra,value_text)
WITH a AS(
SELECT cd_event,ef.date_time_end,
  e.event_id,
  REGEXP_REPLACE(e.event_id,'^ANH_[0-9]{1,3}_((Captura manual)|(T. Exc. Human))[0-9].*$','\1') metodo,
  CASE
     WHEN e.event_id ~ '^ANH_[0-9]{1,3}_Captura manual[0-9]_202[12]-[0-9]{2}-[0-9]{2}$' THEN REGEXP_REPLACE(e.event_id,'^ANH_[0-9]{1,3}_Captura manual[0-9]_(202[12]-[0-9]{2}-[0-9]{2})$','\1')::date
     WHEN e.event_id ~ '^ANH_[0-9]{1,3}_T. Exc. Human[0-9]_202[12]-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2}$' THEN REGEXP_REPLACE(e.event_id,'^ANH_[0-9]{1,3}_T. Exc. Human[0-9]_(202[12]-[0-9]{2}-[0-9]{2})/202[12]-[0-9]{2}-[0-9]{2}$','\1')::date
  END date_1_from_eid,
  CASE
  WHEN e.event_id ~ '^ANH_[0-9]{1,3}_Captura manual[0-9]_202[12]-[0-9]{2}-[0-9]{2}$' THEN REGEXP_REPLACE(e.event_id,'^ANH_[0-9]{1,3}_Captura manual[0-9]_(202[12]-[0-9]{2}-[0-9]{2})$','\1')::date
  WHEN e.event_id ~ '^ANH_[0-9]{1,3}_T. Exc. Human[0-9]_202[12]-[0-9]{2}-[0-9]{2}/202[12]-[0-9]{2}-[0-9]{2}$' THEN REGEXP_REPLACE(e.event_id,'^ANH_[0-9]{1,3}_T. Exc. Human[0-9]_202[12]-[0-9]{2}-[0-9]{2}/(202[12]-[0-9]{2}-[0-9]{2})$','\1')::date
  
  END date_2_from_eid,
  TO_DATE(SPLIT_PART(event_date,'/',1), 'YYYY-MM-DD') date_1,
  CASE 
    WHEN SPLIT_PART(event_date,'/',2)='' THEN NULL
    ELSE TO_DATE(SPLIT_PART(event_date,'/',2), 'YYYY-MM-DD')
  END date_2
FROM raw_dwc.escarabajos_event e
LEFT JOIN main.event ef USING (cd_event)
WHERE date_time_end IS NULL
),b AS(
SELECT cd_event,
  CASE
   WHEN metodo='Captura manual' THEN COALESCE(date_2,date_1,date_2_from_eid,date_1_from_eid)
   ELSE COALESCE(date_2,date_2_from_eid)
  END date_end
FROM a
)
SELECT 
 cd_event,
 (SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_end'),
 to_char(date_end,'yyyy-mm-dd')::text
FROM b
WHERE date_end IS NOT NULL
RETURNING main.event_extra.cd_event, main.event_extra.cd_var_event_extra, main.event_extra.value_text
;
```

## 6.6 registros

Nota:

1.  a veces la horas en registros no están en el rango de horas dadas en
    el evento
2.  las horas dadas en registros son tambien rangos de horas: se
    guardará la primera hora, la siguiente se podrá añadir en una tabla
    registros extra…
3.  Tocaría averiguar que los samplingEffort dados en event correspondan
    a los de registros, tengo una mala sensación comparandolos a vista…

``` sql
SELECT occurrence_id, count(*)
FROM raw_dwc.escarabajos_registros 
GROUP BY occurrence_id
HAVING count(*)>1;
```

<div class="knitsql-table">

occurrence_id count ————— ——-

: 0 records

</div>

Parece que la fechas y horas en registros son solo el reflejo de las
fechas y horas en eventos:

``` sql
SELECT e.event_id, e.event_date, r.event_date, e.event_time, r.event_time
FROM raw_dwc.escarabajos_registros r
LEFT JOIN raw_dwc.escarabajos_event e USING(cd_event)
```

<div class="knitsql-table">

| event_id                                     | event_date            | event_date | event_time        | event_time        |
|:---------------------------------------------|:----------------------|:-----------|:------------------|:------------------|
| ANH_109_T. Exc. Human1_2021-07-15/2021-07-17 | 2021-07-15/2021-07-17 | 2021-07-17 | 08:23:00/08:07:00 | 08:00:00/12:00:00 |
| ANH_109_T. Exc. Human1_2021-07-15/2021-07-17 | 2021-07-15/2021-07-17 | 2021-07-17 | 08:23:00/08:07:00 | 08:00:00/12:00:00 |
| ANH_109_T. Exc. Human1_2021-07-15/2021-07-17 | 2021-07-15/2021-07-17 | 2021-07-16 | 08:23:00/08:07:00 | 08:00:00/12:00:00 |
| ANH_109_T. Exc. Human2_2021-07-15/2021-07-17 | 2021-07-15/2021-07-17 | 2021-07-16 | 08:27:00/08:16:00 | 08:00:00/12:00:00 |
| ANH_109_T. Exc. Human2_2021-07-15/2021-07-17 | 2021-07-15/2021-07-17 | 2021-07-17 | 08:27:00/08:16:00 | 08:00:00/12:00:00 |
| ANH_109_T. Exc. Human2_2021-07-15/2021-07-17 | 2021-07-15/2021-07-17 | 2021-07-17 | 08:27:00/08:16:00 | 08:00:00/12:00:00 |
| ANH_109_T. Exc. Human3_2021-07-15/2021-07-17 | 2021-07-15/2021-07-17 | 2021-07-17 | 08:31:00/08:26:00 | 08:00:00/12:00:00 |
| ANH_109_T. Exc. Human3_2021-07-15/2021-07-17 | 2021-07-15/2021-07-17 | 2021-07-17 | 08:31:00/08:26:00 | 08:00:00/12:00:00 |
| ANH_109_T. Exc. Human3_2021-07-15/2021-07-17 | 2021-07-15/2021-07-17 | 2021-07-16 | 08:31:00/08:26:00 | 08:00:00/12:00:00 |
| ANH_109_T. Exc. Human4_2021-07-15/2021-07-17 | 2021-07-15/2021-07-17 | 2021-07-17 | 08:41:00/08:37:00 | 08:00:00/12:00:00 |
| ANH_109_T. Exc. Human4_2021-07-15/2021-07-17 | 2021-07-15/2021-07-17 | 2021-07-17 | 08:41:00/08:37:00 | 08:00:00/12:00:00 |
| ANH_109_T. Exc. Human4_2021-07-15/2021-07-17 | 2021-07-15/2021-07-17 | 2021-07-16 | 08:41:00/08:37:00 | 08:00:00/12:00:00 |
| ANH_109_T. Exc. Human4_2021-07-15/2021-07-17 | 2021-07-15/2021-07-17 | 2021-07-16 | 08:41:00/08:37:00 | 08:00:00/12:00:00 |
| ANH_109_T. Exc. Human6_2021-07-15/2021-07-17 | 2021-07-15/2021-07-17 | 2021-07-17 | 09:06:00/08:57:00 | 08:00:00/12:00:00 |
| ANH_109_T. Exc. Human6_2021-07-15/2021-07-17 | 2021-07-15/2021-07-17 | 2021-07-17 | 09:06:00/08:57:00 | 08:00:00/12:00:00 |
| ANH_109_T. Exc. Human7_2021-07-15/2021-07-17 | 2021-07-15/2021-07-17 | 2021-07-16 | 09:20:00/09:10:00 | 08:00:00/12:00:00 |
| ANH_109_T. Exc. Human7_2021-07-15/2021-07-17 | 2021-07-15/2021-07-17 | 2021-07-17 | 09:20:00/09:10:00 | 08:00:00/12:00:00 |
| ANH_109_T. Exc. Human7_2021-07-15/2021-07-17 | 2021-07-15/2021-07-17 | 2021-07-16 | 09:20:00/09:10:00 | 08:00:00/12:00:00 |
| ANH_117_Captura manual1_2021-07-06           | 2021-07-06            | 2021-07-06 | NA                | 08:00:00/12:00:00 |
| ANH_117_Captura manual1_2021-07-06           | 2021-07-06            | 2021-07-06 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human1_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human1_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human1_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human1_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human1_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human1_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human1_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human1_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human1_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human1_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human1_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human2_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human2_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 11:27:00          |
| ANH_117_T. Exc. Human2_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human2_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human2_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human3_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human3_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human3_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human3_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human3_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-07 | NA                | 11:27:00          |
| ANH_117_T. Exc. Human3_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human3_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human3_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human3_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human4_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human4_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human4_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human4_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human4_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human4_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human4_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human4_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human4_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human4_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 11:27:00          |
| ANH_117_T. Exc. Human4_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human4_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human4_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human5_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human5_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human5_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human5_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human5_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human5_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human5_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human5_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human6_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human6_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human6_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human6_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human6_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human7_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human7_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human7_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human7_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human7_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-08 | NA                | 08:00:00/12:00:00 |
| ANH_117_T. Exc. Human7_2021-07-06/2021-07-08 | 2021-07-06/2021-07-08 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_133_Captura manual1_2021-07-05           | 2021-07-05            | 2021-07-05 | NA                | 08:00:00/12:00:00 |
| ANH_133_T. Exc. Human1_2021-07-05/2021-07-07 | 2021-07-05/2021-07-07 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_133_T. Exc. Human1_2021-07-05/2021-07-07 | 2021-07-05/2021-07-07 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_133_T. Exc. Human1_2021-07-05/2021-07-07 | 2021-07-05/2021-07-07 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_133_T. Exc. Human1_2021-07-05/2021-07-07 | 2021-07-05/2021-07-07 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_133_T. Exc. Human2_2021-07-05/2021-07-07 | 2021-07-05/2021-07-07 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_133_T. Exc. Human2_2021-07-05/2021-07-07 | 2021-07-05/2021-07-07 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_133_T. Exc. Human2_2021-07-05/2021-07-07 | 2021-07-05/2021-07-07 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_133_T. Exc. Human3_2021-07-05/2021-07-07 | 2021-07-05/2021-07-07 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_133_T. Exc. Human3_2021-07-05/2021-07-07 | 2021-07-05/2021-07-07 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_133_T. Exc. Human3_2021-07-05/2021-07-07 | 2021-07-05/2021-07-07 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_133_T. Exc. Human4_2021-07-05/2021-07-07 | 2021-07-05/2021-07-07 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_133_T. Exc. Human4_2021-07-05/2021-07-07 | 2021-07-05/2021-07-07 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_133_T. Exc. Human5_2021-07-05/2021-07-07 | 2021-07-05/2021-07-07 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_133_T. Exc. Human6_2021-07-05/2021-07-07 | 2021-07-05/2021-07-07 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_133_T. Exc. Human6_2021-07-05/2021-07-07 | 2021-07-05/2021-07-07 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_133_T. Exc. Human6_2021-07-05/2021-07-07 | 2021-07-05/2021-07-07 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_133_T. Exc. Human6_2021-07-05/2021-07-07 | 2021-07-05/2021-07-07 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_133_T. Exc. Human6_2021-07-05/2021-07-07 | 2021-07-05/2021-07-07 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_133_T. Exc. Human7_2021-07-05/2021-07-07 | 2021-07-05/2021-07-07 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_133_T. Exc. Human7_2021-07-05/2021-07-07 | 2021-07-05/2021-07-07 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_133_T. Exc. Human7_2021-07-05/2021-07-07 | 2021-07-05/2021-07-07 | 2021-07-07 | NA                | 08:00:00/12:00:00 |
| ANH_135_T. Exc. Human1_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 09:46:00/11:08:00 | 08:00:00/12:00:00 |

Displaying records 1 - 100

</div>

``` sql

INSERT INTO main.registros(cd_event, cds_recorded_by, date_time, cd_tax, cd_morfo, date_ident, cds_identified_by, qt_int,remarks, occurrence_id, organism_id)
SELECT 
 cd_event,
 cds_recorded_by,
 (event_date||' '||SPLIT_PART(event_time,'/',1))::timestamp date_time,
 tt.cd_tax,
 tt.cd_morfo,
 TO_DATE(date_identified,'YYYY-MM-DD') date_ident,
 cds_identified_by,
 organism_quantity::double precision::int qt_int,
 r.event_remarks,
 occurrence_id,
 SPLIT_PART(occurrence_id,':',7) organism_id
 --ROW_NUMBER() OVER (ORDER BY (e.date_time_begin::date||' '||event_time)::timestamp)
 --organism_id::text
FROM raw_dwc.escarabajos_registros r
LEFT JOIN raw_dwc.taxonomy_total tt ON tt."row.names"=r."row.names" AND tt.table_orig='escarabajos_registros'
LEFT JOIN main.event e USING (cd_event)
ORDER BY date_time
RETURNING cd_event, cds_recorded_by, date_time, cd_tax, cd_morfo, cds_identified_by, qt_int,remarks, occurrence_id, organism_id
```

``` sql
ALTER TABLE raw_dwc.escarabajos_registros ADD COLUMN cd_reg int REFERENCES main.registros(cd_reg);
UPDATE raw_dwc.escarabajos_registros AS ar
SET cd_reg=r.cd_reg
FROM main.registros r
WHERE ar.cd_event=r.cd_event AND ar.occurrence_id=r.occurrence_id;

-- Check cd_reg are unique in the source table
SELECT cd_reg,count(*) FROM  raw_dwc.escarabajos_registros GROUP BY cd_reg HAVING count(*)>1;
```

<div class="knitsql-table">

    cd_reg   count

------------------------------------------------------------------------

: 0 records

</div>

### 6.6.1 Añadir la información temporal supplementaria

``` sql
INSERT INTO main.def_var_registros_extra(var_registros_extra, type_var, var_registros_extra_spa, var_registros_extra_comment)
VALUES
  ('date_time_end',
  'free text',
  'fecha_tiempo_final',
  'En algunos casos (p.ej escarabajos, un rango de tiempo está dado tambien en los registros, en esos casos date_time da la hora inicial y la hora final está en esta variable suplementaria, as a text. el formato es YYYY-MM-DD HH:MI:SS'
  );

INSERT INTO main.registros_extra(cd_reg,cd_var_registros_extra,value_text)
SELECT cd_reg,
(SELECT cd_var_registros_extra FROM main.def_var_registros_extra WHERE var_registros_extra='date_time_end'),
(event_date||' '||SPLIT_PART(event_time,'/',2))::timestamp::text
FROM raw_dwc.escarabajos_registros
WHERE SPLIT_PART(event_time,'/',2) != '';
```

**TODO: poner los occurrenceRemarks en individual characteristics para
poder filtrar las larvas etc.**

# 7 Colémbolos

``` sql
WITH a AS(
SELECT event_id,
  REGEXP_REPLACE(event_id, '^ANH_([0-9]{1,3})_((Pitfall)|(Berlese))([0-9])_(202[12])-[0-9]{1,2}-[0-9]{1,2}(/202[12]-[0-9]{1,2}-[0-9]{1,2})?$', '\1')::int anh_num,
  REGEXP_REPLACE(event_id, '^ANH_([0-9]{1,3})_((Pitfall)|(Berlese))([0-9])_(202[12])-[0-9]{1,2}-[0-9]{1,2}(/202[12]-[0-9]{1,2}-[0-9]{1,2})?$', '\2') metodo,
  REGEXP_REPLACE(event_id, '^ANH_([0-9]{1,3})_((Pitfall)|(Berlese))([0-9])_(202[12])-[0-9]{1,2}-[0-9]{1,2}(/202[12]-[0-9]{1,2}-[0-9]{1,2})?$', '\5')::int repli,
  REGEXP_REPLACE(event_id, '^ANH_([0-9]{1,3})_((Pitfall)|(Berlese))([0-9])_(202[12])-[0-9]{1,2}-[0-9]{1,2}(/202[12]-[0-9]{1,2}-[0-9]{1,2})?$', '\6') año
FROM raw_dwc.collembolos_event
)
SELECT anh_num, año, ARRAY_AGG(DISTINCT metodo ORDER BY metodo),  count(*)
FROM a
GROUP BY anh_num, año
;
```

<div class="knitsql-table">

| anh_num | año  | array_agg         | count |
|--------:|:-----|:------------------|------:|
|     108 | 2021 | {Berlese,Pitfall} |    12 |
|     108 | 2022 | {Berlese,Pitfall} |    12 |
|     109 | 2021 | {Berlese,Pitfall} |    12 |
|     109 | 2022 | {Berlese,Pitfall} |    12 |
|     110 | 2021 | {Berlese,Pitfall} |    12 |
|     110 | 2022 | {Berlese,Pitfall} |    12 |
|     112 | 2021 | {Berlese,Pitfall} |    12 |
|     112 | 2022 | {Berlese,Pitfall} |    12 |
|     113 | 2021 | {Berlese,Pitfall} |    12 |
|     113 | 2022 | {Berlese,Pitfall} |    12 |
|     114 | 2021 | {Berlese,Pitfall} |    12 |
|     114 | 2022 | {Berlese,Pitfall} |    12 |
|     115 | 2021 | {Berlese,Pitfall} |    12 |
|     115 | 2022 | {Berlese,Pitfall} |    12 |
|     116 | 2021 | {Berlese,Pitfall} |    12 |
|     116 | 2022 | {Berlese,Pitfall} |    12 |
|     117 | 2021 | {Berlese,Pitfall} |    12 |
|     117 | 2022 | {Berlese,Pitfall} |    12 |
|     118 | 2021 | {Berlese,Pitfall} |    12 |
|     118 | 2022 | {Berlese,Pitfall} |    12 |
|     120 | 2021 | {Berlese,Pitfall} |    12 |
|     120 | 2022 | {Berlese,Pitfall} |    12 |
|     121 | 2021 | {Berlese,Pitfall} |    12 |
|     121 | 2022 | {Berlese,Pitfall} |    12 |
|     122 | 2021 | {Berlese,Pitfall} |    12 |
|     122 | 2022 | {Berlese,Pitfall} |    12 |
|     123 | 2021 | {Berlese,Pitfall} |    12 |
|     123 | 2022 | {Berlese,Pitfall} |    12 |
|     125 | 2021 | {Berlese,Pitfall} |    12 |
|     125 | 2022 | {Berlese,Pitfall} |    12 |
|     127 | 2021 | {Berlese,Pitfall} |    12 |
|     127 | 2022 | {Berlese,Pitfall} |    12 |
|     130 | 2021 | {Berlese,Pitfall} |    12 |
|     130 | 2022 | {Berlese,Pitfall} |    12 |
|     131 | 2021 | {Berlese,Pitfall} |    12 |
|     131 | 2022 | {Berlese,Pitfall} |    12 |
|     132 | 2021 | {Berlese,Pitfall} |    12 |
|     132 | 2022 | {Berlese,Pitfall} |    12 |
|     133 | 2021 | {Berlese,Pitfall} |    12 |
|     133 | 2022 | {Berlese,Pitfall} |    12 |
|     134 | 2021 | {Berlese,Pitfall} |    12 |
|     134 | 2022 | {Berlese,Pitfall} |    12 |
|     135 | 2021 | {Berlese,Pitfall} |    12 |
|     135 | 2022 | {Berlese,Pitfall} |    12 |
|     136 | 2021 | {Berlese,Pitfall} |    12 |
|     136 | 2022 | {Berlese,Pitfall} |    12 |
|     137 | 2021 | {Berlese,Pitfall} |    12 |
|     137 | 2022 | {Berlese,Pitfall} |    12 |
|     138 | 2021 | {Berlese,Pitfall} |    12 |
|     138 | 2022 | {Berlese,Pitfall} |    12 |
|     142 | 2021 | {Berlese,Pitfall} |    12 |
|     142 | 2022 | {Berlese,Pitfall} |    12 |
|     144 | 2021 | {Berlese,Pitfall} |    12 |
|     144 | 2022 | {Berlese,Pitfall} |    12 |
|     145 | 2021 | {Berlese,Pitfall} |    12 |
|     145 | 2022 | {Berlese,Pitfall} |    12 |
|     147 | 2021 | {Berlese,Pitfall} |    12 |
|     147 | 2022 | {Berlese,Pitfall} |    12 |
|     365 | 2021 | {Berlese,Pitfall} |    12 |
|     365 | 2022 | {Berlese,Pitfall} |    12 |
|     366 | 2021 | {Berlese,Pitfall} |    12 |
|     366 | 2022 | {Berlese,Pitfall} |    12 |
|     368 | 2021 | {Berlese,Pitfall} |    12 |
|     368 | 2022 | {Berlese,Pitfall} |    12 |
|     369 | 2021 | {Berlese,Pitfall} |    12 |
|     369 | 2022 | {Berlese,Pitfall} |    12 |
|     370 | 2021 | {Berlese,Pitfall} |    12 |
|     370 | 2022 | {Berlese,Pitfall} |    12 |
|     371 | 2021 | {Berlese,Pitfall} |    12 |
|     371 | 2022 | {Berlese,Pitfall} |    12 |
|     372 | 2021 | {Berlese,Pitfall} |    12 |
|     372 | 2022 | {Berlese,Pitfall} |    12 |
|     374 | 2021 | {Berlese,Pitfall} |    12 |
|     374 | 2022 | {Berlese,Pitfall} |    12 |
|     375 | 2021 | {Berlese,Pitfall} |    12 |
|     375 | 2022 | {Berlese,Pitfall} |    12 |
|     402 | 2021 | {Berlese,Pitfall} |    12 |
|     402 | 2022 | {Berlese,Pitfall} |    12 |
|     403 | 2021 | {Berlese,Pitfall} |    12 |
|     403 | 2022 | {Berlese,Pitfall} |    12 |

80 records

</div>

``` sql
WITH a AS(
SELECT event_id,
  REGEXP_REPLACE(event_id, '^ANH_([0-9]{1,3})_((Pitfall)|(Berlese))([0-9])_(202[12])-[0-9]{1,2}-[0-9]{1,2}(/202[12]-[0-9]{1,2}-[0-9]{1,2})?$', '\1')::int anh_num,
  REGEXP_REPLACE(event_id, '^ANH_([0-9]{1,3})_((Pitfall)|(Berlese))([0-9])_(202[12])-[0-9]{1,2}-[0-9]{1,2}(/202[12]-[0-9]{1,2}-[0-9]{1,2})?$', '\2') metodo,
  REGEXP_REPLACE(event_id, '^ANH_([0-9]{1,3})_((Pitfall)|(Berlese))([0-9])_(202[12])-[0-9]{1,2}-[0-9]{1,2}(/202[12]-[0-9]{1,2}-[0-9]{1,2})?$', '\5')::int repli,
  REGEXP_REPLACE(event_id, '^ANH_([0-9]{1,3})_((Pitfall)|(Berlese))([0-9])_(202[12])-[0-9]{1,2}-[0-9]{1,2}(/202[12]-[0-9]{1,2}-[0-9]{1,2})?$', '\6') año
FROM raw_dwc.collembolos_event
)
SELECT anh_num, año,metodo, ARRAY_AGG(DISTINCT repli ORDER BY repli) repli,  count(*)
FROM a
GROUP BY anh_num, año, metodo
;
```

<div class="knitsql-table">

| anh_num | año  | metodo  | repli         | count |
|--------:|:-----|:--------|:--------------|------:|
|     108 | 2021 | Berlese | {1,2,3,4,5,6} |     6 |
|     108 | 2021 | Pitfall | {1,2,3,4,5,6} |     6 |
|     108 | 2022 | Berlese | {1,2,3,4,5,6} |     6 |
|     108 | 2022 | Pitfall | {1,2,3,4,5,6} |     6 |
|     109 | 2021 | Berlese | {1,2,3,4,5,6} |     6 |
|     109 | 2021 | Pitfall | {1,2,3,4,5,6} |     6 |
|     109 | 2022 | Berlese | {1,2,3,4,5,6} |     6 |
|     109 | 2022 | Pitfall | {1,2,3,4,5,6} |     6 |
|     110 | 2021 | Berlese | {1,2,3,4,5,6} |     6 |
|     110 | 2021 | Pitfall | {1,2,3,4,5,6} |     6 |
|     110 | 2022 | Berlese | {1,2,3,4,5,6} |     6 |
|     110 | 2022 | Pitfall | {1,2,3,4,5,6} |     6 |
|     112 | 2021 | Berlese | {1,2,3,4,5,6} |     6 |
|     112 | 2021 | Pitfall | {1,2,3,4,5,6} |     6 |
|     112 | 2022 | Berlese | {1,2,3,4,5,6} |     6 |
|     112 | 2022 | Pitfall | {1,2,3,4,5,6} |     6 |
|     113 | 2021 | Berlese | {1,2,3,4,5,6} |     6 |
|     113 | 2021 | Pitfall | {1,2,3,4,5,6} |     6 |
|     113 | 2022 | Berlese | {1,2,3,4,5,6} |     6 |
|     113 | 2022 | Pitfall | {1,2,3,4,5,6} |     6 |
|     114 | 2021 | Berlese | {1,2,3,4,5,6} |     6 |
|     114 | 2021 | Pitfall | {1,2,3,4,5,6} |     6 |
|     114 | 2022 | Berlese | {1,2,3,4,5,6} |     6 |
|     114 | 2022 | Pitfall | {1,2,3,4,5,6} |     6 |
|     115 | 2021 | Berlese | {1,2,3,4,5,6} |     6 |
|     115 | 2021 | Pitfall | {1,2,3,4,5,6} |     6 |
|     115 | 2022 | Berlese | {1,2,3,4,5,6} |     6 |
|     115 | 2022 | Pitfall | {1,2,3,4,5,6} |     6 |
|     116 | 2021 | Berlese | {1,2,3,4,5,6} |     6 |
|     116 | 2021 | Pitfall | {1,2,3,4,5,6} |     6 |
|     116 | 2022 | Berlese | {1,2,3,4,5,6} |     6 |
|     116 | 2022 | Pitfall | {1,2,3,4,5,6} |     6 |
|     117 | 2021 | Berlese | {1,2,3,4,5,6} |     6 |
|     117 | 2021 | Pitfall | {1,2,3,4,5,6} |     6 |
|     117 | 2022 | Berlese | {1,2,3,4,5,6} |     6 |
|     117 | 2022 | Pitfall | {1,2,3,4,5,6} |     6 |
|     118 | 2021 | Berlese | {1,2,3,4,5,6} |     6 |
|     118 | 2021 | Pitfall | {1,2,3,4,5,6} |     6 |
|     118 | 2022 | Berlese | {1,2,3,4,5,6} |     6 |
|     118 | 2022 | Pitfall | {1,2,3,4,5,6} |     6 |
|     120 | 2021 | Berlese | {1,2,3,4,5,6} |     6 |
|     120 | 2021 | Pitfall | {1,2,3,4,5,6} |     6 |
|     120 | 2022 | Berlese | {1,2,3,4,5,6} |     6 |
|     120 | 2022 | Pitfall | {1,2,3,4,5,6} |     6 |
|     121 | 2021 | Berlese | {1,2,3,4,5,6} |     6 |
|     121 | 2021 | Pitfall | {1,2,3,4,5,6} |     6 |
|     121 | 2022 | Berlese | {1,2,3,4,5,6} |     6 |
|     121 | 2022 | Pitfall | {1,2,3,4,5,6} |     6 |
|     122 | 2021 | Berlese | {1,2,3,4,5,6} |     6 |
|     122 | 2021 | Pitfall | {1,2,3,4,5,6} |     6 |
|     122 | 2022 | Berlese | {1,2,3,4,5,6} |     6 |
|     122 | 2022 | Pitfall | {1,2,3,4,5,6} |     6 |
|     123 | 2021 | Berlese | {1,2,3,4,5,6} |     6 |
|     123 | 2021 | Pitfall | {1,2,3,4,5,6} |     6 |
|     123 | 2022 | Berlese | {1,2,3,4,5,6} |     6 |
|     123 | 2022 | Pitfall | {1,2,3,4,5,6} |     6 |
|     125 | 2021 | Berlese | {1,2,3,4,5,6} |     6 |
|     125 | 2021 | Pitfall | {1,2,3,4,5,6} |     6 |
|     125 | 2022 | Berlese | {1,2,3,4,5,6} |     6 |
|     125 | 2022 | Pitfall | {1,2,3,4,5,6} |     6 |
|     127 | 2021 | Berlese | {1,2,3,4,5,6} |     6 |
|     127 | 2021 | Pitfall | {1,2,3,4,5,6} |     6 |
|     127 | 2022 | Berlese | {1,2,3,4,5,6} |     6 |
|     127 | 2022 | Pitfall | {1,2,3,4,5,6} |     6 |
|     130 | 2021 | Berlese | {1,2,3,4,5,6} |     6 |
|     130 | 2021 | Pitfall | {1,2,3,4,5,6} |     6 |
|     130 | 2022 | Berlese | {1,2,3,4,5,6} |     6 |
|     130 | 2022 | Pitfall | {1,2,3,4,5,6} |     6 |
|     131 | 2021 | Berlese | {1,2,3,4,5,6} |     6 |
|     131 | 2021 | Pitfall | {1,2,3,4,5,6} |     6 |
|     131 | 2022 | Berlese | {1,2,3,4,5,6} |     6 |
|     131 | 2022 | Pitfall | {1,2,3,4,5,6} |     6 |
|     132 | 2021 | Berlese | {1,2,3,4,5,6} |     6 |
|     132 | 2021 | Pitfall | {1,2,3,4,5,6} |     6 |
|     132 | 2022 | Berlese | {1,2,3,4,5,6} |     6 |
|     132 | 2022 | Pitfall | {1,2,3,4,5,6} |     6 |
|     133 | 2021 | Berlese | {1,2,3,4,5,6} |     6 |
|     133 | 2021 | Pitfall | {1,2,3,4,5,6} |     6 |
|     133 | 2022 | Berlese | {1,2,3,4,5,6} |     6 |
|     133 | 2022 | Pitfall | {1,2,3,4,5,6} |     6 |
|     134 | 2021 | Berlese | {1,2,3,4,5,6} |     6 |
|     134 | 2021 | Pitfall | {1,2,3,4,5,6} |     6 |
|     134 | 2022 | Berlese | {1,2,3,4,5,6} |     6 |
|     134 | 2022 | Pitfall | {1,2,3,4,5,6} |     6 |
|     135 | 2021 | Berlese | {1,2,3,4,5,6} |     6 |
|     135 | 2021 | Pitfall | {1,2,3,4,5,6} |     6 |
|     135 | 2022 | Berlese | {1,2,3,4,5,6} |     6 |
|     135 | 2022 | Pitfall | {1,2,3,4,5,6} |     6 |
|     136 | 2021 | Berlese | {1,2,3,4,5,6} |     6 |
|     136 | 2021 | Pitfall | {1,2,3,4,5,6} |     6 |
|     136 | 2022 | Berlese | {1,2,3,4,5,6} |     6 |
|     136 | 2022 | Pitfall | {1,2,3,4,5,6} |     6 |
|     137 | 2021 | Berlese | {1,2,3,4,5,6} |     6 |
|     137 | 2021 | Pitfall | {1,2,3,4,5,6} |     6 |
|     137 | 2022 | Berlese | {1,2,3,4,5,6} |     6 |
|     137 | 2022 | Pitfall | {1,2,3,4,5,6} |     6 |
|     138 | 2021 | Berlese | {1,2,3,4,5,6} |     6 |
|     138 | 2021 | Pitfall | {1,2,3,4,5,6} |     6 |
|     138 | 2022 | Berlese | {1,2,3,4,5,6} |     6 |
|     138 | 2022 | Pitfall | {1,2,3,4,5,6} |     6 |

Displaying records 1 - 100

</div>

Para entender el plan de muestreo:

## 7.1 ANH

Insertar los datos de anh:

``` sql
INSERT INTO main.punto_referencia(name_pt_ref, num_anh)
WITH a AS(
SELECT
  REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3}).*$','\1')::int anh_num,
  REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3}).*$','\1') anh_name
FROM raw_dwc.collembolos_event
)
SELECT anh_name, anh_num
FROM a
GROUP BY anh_name,anh_num
ORDER BY anh_num
ON CONFLICT (name_pt_ref) DO NOTHING
RETURNING cd_pt_ref, name_pt_ref
;
```

dar las referencias en las tablas de collembolos

``` sql
ALTER TABLE raw_dwc.collembolos_event ADD COLUMN cd_pt_ref int REFERENCES main.punto_referencia(cd_pt_ref) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE raw_dwc.collembolos_registros ADD COLUMN cd_pt_ref int REFERENCES main.punto_referencia(cd_pt_ref) ON DELETE SET NULL ON UPDATE CASCADE;

UPDATE raw_dwc.collembolos_event
SET cd_pt_ref=pr.cd_pt_ref
FROM main.punto_referencia pr
WHERE REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3}).*$','\1') = name_pt_ref
;

UPDATE raw_dwc.collembolos_registros
SET cd_pt_ref=pr.cd_pt_ref
FROM main.punto_referencia pr
WHERE  REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3}).*$','\1') = name_pt_ref
;

SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

Averiguando que ninguna fila no tenga anh

``` sql
SELECT event_id FROM raw_dwc.collembolos_event WHERE cd_pt_ref IS NULL;
```

<div class="knitsql-table">

event_id ———-

: 0 records

</div>

``` sql
SELECT occurrence_id FROM raw_dwc.collembolos_registros WHERE cd_pt_ref IS NULL;
```

<div class="knitsql-table">

occurrence_id —————

: 0 records

</div>

## 7.2 Unit, sampling efforts definition, abundance definition, protocolo

``` sql
INSERT INTO main.def_unit(cd_measurement_type, unit, unit_spa, abbv_unit,factor)
VALUES(
  (SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='volume'),
  'Cubic centimeter',
  'Centímetros cúbicos',
  'cm3',
  1
  )
RETURNING cd_unit,unit;
```

``` sql
INSERT INTO main.def_var_samp_eff(var_samp_eff, var_samp_eff_spa, cd_unit,type_variable)
VALUES(
  'Trap volume',
  'Volumen de la trampa',
  (SELECT cd_unit FROM main.def_unit WHERE cd_measurement_type=(SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='volume') AND unit='Cubic centimeter'),
  'double precision'
  )
RETURNING cd_var_samp_eff, var_samp_eff ;
```

``` sql
INSERT INTO main.def_protocol(protocol,protocol_spa,cd_var_samp_eff_1,cd_var_samp_eff_2,samp_eff_1_implicit,samp_eff_2_implicit,cd_var_ind_qt,description_spa)
VALUES(
  'Berlese trap (arthropods)',
  'Trampa Berlese para artropodos',
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Trap volume'),
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Elapsed time'),
  false,
  true,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind='Number of individuals'),
  NULL
),(
  'Pitfall (arthropods)',
  'Trampa pitfall para artropodos',
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Elapsed time'),
  NULL,
  true,
  NULL,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind='Number of individuals'),
  'Nota: eso no concierne la hormigas, que manejan solamente presence/absence'
)
RETURNING cd_protocol,protocol,protocol_spa;
```

## 7.3 Personas

``` sql
INSERT INTO main.people(verbatim_person)
WITH a AS(
SELECT DISTINCT INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(recorded_by, ' | ')))) AS name_person
FROM raw_dwc.collembolos_registros
UNION
SELECT DISTINCT INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(identified_by, ' | '))))
FROM raw_dwc.collembolos_registros
)
SELECT DISTINCT REGEXP_REPLACE(name_person, '- ','-')
FROM a 
ORDER BY REGEXP_REPLACE(name_person, '- ','-')
ON CONFLICT(verbatim_person) DO NOTHING
RETURNING cd_person, verbatim_person
```

Dar los codigos a las tables de origen:

``` sql
ALTER TABLE raw_dwc.collembolos_registros ADD COLUMN cds_recorded_by int[];

WITH a AS(
SELECT "row.names", REGEXP_REPLACE(INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(recorded_by, ' | ')))),'- ','-') AS name_person
FROM raw_dwc.collembolos_registros
),b AS(
SELECT "row.names", ARRAY_AGG(cd_person) cds
FROM a 
LEFT JOIN main.people p ON a.name_person=p.verbatim_person
GROUP BY "row.names"
)
UPDATE raw_dwc.collembolos_registros AS r
SET cds_recorded_by=b.cds
FROM b
WHERE r."row.names"=b."row.names"
RETURNING r."row.names", cds_recorded_by
;

ALTER TABLE raw_dwc.collembolos_registros ADD COLUMN cds_identified_by int[];

WITH a AS(
SELECT "row.names", REGEXP_REPLACE(INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(identified_by, ' | ')))),'- ','-') AS name_person
FROM raw_dwc.collembolos_registros
),b AS(
SELECT "row.names", ARRAY_AGG(cd_person) cds
FROM a 
LEFT JOIN main.people p ON a.name_person=p.verbatim_person
GROUP BY "row.names"
)
UPDATE raw_dwc.collembolos_registros AS r
SET cds_identified_by=b.cds
FROM b
WHERE r."row.names"=b."row.names"
RETURNING r."row.names", cds_identified_by
;

SELECT 1;
```

<div class="knitsql-table">

| ?column? |
|---------:|
|        1 |

1 records

</div>

## 7.4 gp_event

``` sql
WITH a AS(
SELECT 
  event_id,
  REGEXP_REPLACE(event_id, '^ANH_([0-9]{1,3})_((Pitfall)|(Berlese))([0-9])_(202[12])-[0-9]{1,2}-[0-9]{1,2}(/202[12]-[0-9]{1,2}-[0-9]{1,2})?$', '\1')::int anh_num,
  REGEXP_REPLACE(event_id, '^ANH_([0-9]{1,3})_((Pitfall)|(Berlese))([0-9])_(202[12])-[0-9]{1,2}-[0-9]{1,2}(/202[12]-[0-9]{1,2}-[0-9]{1,2})?$', '\2') metodo,
  REGEXP_REPLACE(event_id, '^ANH_([0-9]{1,3})_((Pitfall)|(Berlese))([0-9])_(202[12])-[0-9]{1,2}-[0-9]{1,2}(/202[12]-[0-9]{1,2}-[0-9]{1,2})?$', '\5')::int repli,
  REGEXP_REPLACE(event_id, '^ANH_([0-9]{1,3})_((Pitfall)|(Berlese))([0-9])_(202[12])-[0-9]{1,2}-[0-9]{1,2}(/202[12]-[0-9]{1,2}-[0-9]{1,2})?$', '\6') año
FROM raw_dwc.collembolos_event
)
SELECT año, anh_num,metodo, ARRAY_AGG(repli), count(*)
FROM a
GROUP BY año, anh_num, metodo
ORDER BY año, anh_num, metodo
;
```

<div class="knitsql-table">

| año  | anh_num | metodo  | array_agg     | count |
|:-----|--------:|:--------|:--------------|------:|
| 2021 |     108 | Berlese | {4,6,5,1,2,3} |     6 |
| 2021 |     108 | Pitfall | {2,4,6,5,3,1} |     6 |
| 2021 |     109 | Berlese | {4,5,6,1,2,3} |     6 |
| 2021 |     109 | Pitfall | {6,2,1,3,4,5} |     6 |
| 2021 |     110 | Berlese | {5,4,6,1,2,3} |     6 |
| 2021 |     110 | Pitfall | {5,1,2,3,4,6} |     6 |
| 2021 |     112 | Berlese | {2,1,6,5,4,3} |     6 |
| 2021 |     112 | Pitfall | {2,6,5,4,3,1} |     6 |
| 2021 |     113 | Berlese | {4,6,1,2,3,5} |     6 |
| 2021 |     113 | Pitfall | {4,5,6,1,2,3} |     6 |
| 2021 |     114 | Berlese | {4,5,1,2,3,6} |     6 |
| 2021 |     114 | Pitfall | {4,6,5,3,2,1} |     6 |
| 2021 |     115 | Berlese | {5,1,2,3,4,6} |     6 |
| 2021 |     115 | Pitfall | {1,6,5,4,3,2} |     6 |
| 2021 |     116 | Berlese | {2,6,4,3,1,5} |     6 |
| 2021 |     116 | Pitfall | {6,1,2,3,4,5} |     6 |
| 2021 |     117 | Berlese | {1,6,5,4,3,2} |     6 |
| 2021 |     117 | Pitfall | {1,6,5,4,3,2} |     6 |
| 2021 |     118 | Berlese | {5,1,2,3,4,6} |     6 |
| 2021 |     118 | Pitfall | {4,3,1,6,2,5} |     6 |
| 2021 |     120 | Berlese | {1,4,5,6,3,2} |     6 |
| 2021 |     120 | Pitfall | {5,6,1,2,3,4} |     6 |
| 2021 |     121 | Berlese | {4,6,2,1,3,5} |     6 |
| 2021 |     121 | Pitfall | {1,6,5,4,3,2} |     6 |
| 2021 |     122 | Berlese | {5,4,3,2,1,6} |     6 |
| 2021 |     122 | Pitfall | {6,5,4,3,2,1} |     6 |
| 2021 |     123 | Berlese | {1,5,6,4,3,2} |     6 |
| 2021 |     123 | Pitfall | {5,4,3,2,1,6} |     6 |
| 2021 |     125 | Berlese | {4,1,2,5,6,3} |     6 |
| 2021 |     125 | Pitfall | {2,3,4,5,6,1} |     6 |
| 2021 |     127 | Berlese | {4,3,2,1,6,5} |     6 |
| 2021 |     127 | Pitfall | {4,3,6,2,1,5} |     6 |
| 2021 |     130 | Berlese | {4,5,1,6,2,3} |     6 |
| 2021 |     130 | Pitfall | {1,6,5,4,3,2} |     6 |
| 2021 |     131 | Berlese | {2,3,4,5,6,1} |     6 |
| 2021 |     131 | Pitfall | {6,4,3,1,2,5} |     6 |
| 2021 |     132 | Berlese | {5,1,2,3,4,6} |     6 |
| 2021 |     132 | Pitfall | {6,1,2,3,4,5} |     6 |
| 2021 |     133 | Berlese | {1,6,5,4,3,2} |     6 |
| 2021 |     133 | Pitfall | {5,4,3,2,1,6} |     6 |
| 2021 |     134 | Berlese | {1,3,4,5,6,2} |     6 |
| 2021 |     134 | Pitfall | {6,4,3,2,1,5} |     6 |
| 2021 |     135 | Berlese | {6,1,2,3,4,5} |     6 |
| 2021 |     135 | Pitfall | {5,6,1,2,3,4} |     6 |
| 2021 |     136 | Berlese | {2,3,4,5,6,1} |     6 |
| 2021 |     136 | Pitfall | {4,6,1,2,3,5} |     6 |
| 2021 |     137 | Berlese | {6,5,4,3,2,1} |     6 |
| 2021 |     137 | Pitfall | {1,6,5,4,3,2} |     6 |
| 2021 |     138 | Berlese | {6,5,4,3,2,1} |     6 |
| 2021 |     138 | Pitfall | {1,2,3,4,5,6} |     6 |
| 2021 |     142 | Berlese | {6,5,4,3,2,1} |     6 |
| 2021 |     142 | Pitfall | {6,1,2,3,4,5} |     6 |
| 2021 |     144 | Berlese | {6,1,2,3,4,5} |     6 |
| 2021 |     144 | Pitfall | {1,2,3,4,5,6} |     6 |
| 2021 |     145 | Berlese | {6,1,2,3,4,5} |     6 |
| 2021 |     145 | Pitfall | {1,6,5,4,3,2} |     6 |
| 2021 |     147 | Berlese | {1,6,5,4,3,2} |     6 |
| 2021 |     147 | Pitfall | {6,2,3,4,5,1} |     6 |
| 2021 |     365 | Berlese | {2,6,5,4,3,1} |     6 |
| 2021 |     365 | Pitfall | {6,1,2,3,4,5} |     6 |
| 2021 |     366 | Berlese | {1,2,3,4,5,6} |     6 |
| 2021 |     366 | Pitfall | {2,3,4,5,6,1} |     6 |
| 2021 |     368 | Berlese | {2,6,5,4,3,1} |     6 |
| 2021 |     368 | Pitfall | {1,2,3,4,5,6} |     6 |
| 2021 |     369 | Berlese | {1,5,4,6,3,2} |     6 |
| 2021 |     369 | Pitfall | {3,4,5,6,1,2} |     6 |
| 2021 |     370 | Berlese | {1,6,5,4,3,2} |     6 |
| 2021 |     370 | Pitfall | {4,3,2,1,5,6} |     6 |
| 2021 |     371 | Berlese | {6,5,4,3,2,1} |     6 |
| 2021 |     371 | Pitfall | {6,2,3,4,5,1} |     6 |
| 2021 |     372 | Berlese | {1,4,3,2,6,5} |     6 |
| 2021 |     372 | Pitfall | {5,1,2,3,4,6} |     6 |
| 2021 |     374 | Berlese | {4,3,5,1,6,2} |     6 |
| 2021 |     374 | Pitfall | {5,6,2,1,3,4} |     6 |
| 2021 |     375 | Berlese | {1,2,3,4,5,6} |     6 |
| 2021 |     375 | Pitfall | {2,1,5,4,6,3} |     6 |
| 2021 |     402 | Berlese | {6,4,3,2,1,5} |     6 |
| 2021 |     402 | Pitfall | {6,5,4,3,2,1} |     6 |
| 2021 |     403 | Berlese | {6,1,2,3,5,4} |     6 |
| 2021 |     403 | Pitfall | {1,2,3,4,5,6} |     6 |
| 2022 |     108 | Berlese | {3,4,5,2,1,6} |     6 |
| 2022 |     108 | Pitfall | {6,5,4,3,2,1} |     6 |
| 2022 |     109 | Berlese | {5,1,2,3,4,6} |     6 |
| 2022 |     109 | Pitfall | {6,5,4,3,2,1} |     6 |
| 2022 |     110 | Berlese | {5,6,4,3,2,1} |     6 |
| 2022 |     110 | Pitfall | {1,6,5,4,3,2} |     6 |
| 2022 |     112 | Berlese | {1,5,4,3,2,6} |     6 |
| 2022 |     112 | Pitfall | {1,5,4,3,6,2} |     6 |
| 2022 |     113 | Berlese | {2,6,5,4,3,1} |     6 |
| 2022 |     113 | Pitfall | {1,2,3,4,5,6} |     6 |
| 2022 |     114 | Berlese | {2,6,1,5,4,3} |     6 |
| 2022 |     114 | Pitfall | {3,6,1,5,4,2} |     6 |
| 2022 |     115 | Berlese | {5,1,2,3,4,6} |     6 |
| 2022 |     115 | Pitfall | {1,6,5,4,3,2} |     6 |
| 2022 |     116 | Berlese | {1,6,5,4,3,2} |     6 |
| 2022 |     116 | Pitfall | {6,5,4,3,2,1} |     6 |
| 2022 |     117 | Berlese | {3,4,2,6,5,1} |     6 |
| 2022 |     117 | Pitfall | {3,1,4,5,6,2} |     6 |
| 2022 |     118 | Berlese | {6,2,3,4,1,5} |     6 |
| 2022 |     118 | Pitfall | {1,2,3,4,6,5} |     6 |

Displaying records 1 - 100

</div>

Because there is more than a method, the number of the campaign should
be determined this way:

``` sql
WITH a AS(
SELECT 
  event_id,
  REGEXP_REPLACE(event_id, '^ANH_([0-9]{1,3})_((Pitfall)|(Berlese))([0-9])_(202[12])-[0-9]{1,2}-[0-9]{1,2}(/202[12]-[0-9]{1,2}-[0-9]{1,2})?$', '\1')::int anh_num,
  REGEXP_REPLACE(event_id, '^ANH_([0-9]{1,3})_((Pitfall)|(Berlese))([0-9])_(202[12])-[0-9]{1,2}-[0-9]{1,2}(/202[12]-[0-9]{1,2}-[0-9]{1,2})?$', '\2') metodo,
  REGEXP_REPLACE(event_id, '^ANH_([0-9]{1,3})_((Pitfall)|(Berlese))([0-9])_(202[12])-[0-9]{1,2}-[0-9]{1,2}(/202[12]-[0-9]{1,2}-[0-9]{1,2})?$', '\5')::int repli,
  REGEXP_REPLACE(event_id, '^ANH_([0-9]{1,3})_((Pitfall)|(Berlese))([0-9])_(202[12])-[0-9]{1,2}-[0-9]{1,2}(/202[12]-[0-9]{1,2}-[0-9]{1,2})?$', '\6') año
FROM raw_dwc.collembolos_event
)
SELECT año, anh_num, ROW_NUMBER() OVER (PARTITION BY anh_num ORDER BY año) campaign_nb
FROM a
GROUP BY año, anh_num
ORDER BY año, anh_num
;
```

<div class="knitsql-table">

| año  | anh_num | campaign_nb |
|:-----|--------:|------------:|
| 2021 |     108 |           1 |
| 2021 |     109 |           1 |
| 2021 |     110 |           1 |
| 2021 |     112 |           1 |
| 2021 |     113 |           1 |
| 2021 |     114 |           1 |
| 2021 |     115 |           1 |
| 2021 |     116 |           1 |
| 2021 |     117 |           1 |
| 2021 |     118 |           1 |
| 2021 |     120 |           1 |
| 2021 |     121 |           1 |
| 2021 |     122 |           1 |
| 2021 |     123 |           1 |
| 2021 |     125 |           1 |
| 2021 |     127 |           1 |
| 2021 |     130 |           1 |
| 2021 |     131 |           1 |
| 2021 |     132 |           1 |
| 2021 |     133 |           1 |
| 2021 |     134 |           1 |
| 2021 |     135 |           1 |
| 2021 |     136 |           1 |
| 2021 |     137 |           1 |
| 2021 |     138 |           1 |
| 2021 |     142 |           1 |
| 2021 |     144 |           1 |
| 2021 |     145 |           1 |
| 2021 |     147 |           1 |
| 2021 |     365 |           1 |
| 2021 |     366 |           1 |
| 2021 |     368 |           1 |
| 2021 |     369 |           1 |
| 2021 |     370 |           1 |
| 2021 |     371 |           1 |
| 2021 |     372 |           1 |
| 2021 |     374 |           1 |
| 2021 |     375 |           1 |
| 2021 |     402 |           1 |
| 2021 |     403 |           1 |
| 2022 |     108 |           2 |
| 2022 |     109 |           2 |
| 2022 |     110 |           2 |
| 2022 |     112 |           2 |
| 2022 |     113 |           2 |
| 2022 |     114 |           2 |
| 2022 |     115 |           2 |
| 2022 |     116 |           2 |
| 2022 |     117 |           2 |
| 2022 |     118 |           2 |
| 2022 |     120 |           2 |
| 2022 |     121 |           2 |
| 2022 |     122 |           2 |
| 2022 |     123 |           2 |
| 2022 |     125 |           2 |
| 2022 |     127 |           2 |
| 2022 |     130 |           2 |
| 2022 |     131 |           2 |
| 2022 |     132 |           2 |
| 2022 |     133 |           2 |
| 2022 |     134 |           2 |
| 2022 |     135 |           2 |
| 2022 |     136 |           2 |
| 2022 |     137 |           2 |
| 2022 |     138 |           2 |
| 2022 |     142 |           2 |
| 2022 |     144 |           2 |
| 2022 |     145 |           2 |
| 2022 |     147 |           2 |
| 2022 |     365 |           2 |
| 2022 |     366 |           2 |
| 2022 |     368 |           2 |
| 2022 |     369 |           2 |
| 2022 |     370 |           2 |
| 2022 |     371 |           2 |
| 2022 |     372 |           2 |
| 2022 |     374 |           2 |
| 2022 |     375 |           2 |
| 2022 |     402 |           2 |
| 2022 |     403 |           2 |

80 records

</div>

``` sql
INSERT INTO main.gp_event(cd_gp_biol,cd_protocol,cd_pt_ref,campaign_nb)
WITH a AS(
SELECT 
  event_id,
  REGEXP_REPLACE(event_id, '^ANH_([0-9]{1,3})_((Pitfall)|(Berlese))([0-9])_(202[12])-[0-9]{1,2}-[0-9]{1,2}(/202[12]-[0-9]{1,2}-[0-9]{1,2})?$', '\1')::int anh_num,
  REGEXP_REPLACE(event_id, '^ANH_([0-9]{1,3})_((Pitfall)|(Berlese))([0-9])_(202[12])-[0-9]{1,2}-[0-9]{1,2}(/202[12]-[0-9]{1,2}-[0-9]{1,2})?$', '\2') metodo,
  REGEXP_REPLACE(event_id, '^ANH_([0-9]{1,3})_((Pitfall)|(Berlese))([0-9])_(202[12])-[0-9]{1,2}-[0-9]{1,2}(/202[12]-[0-9]{1,2}-[0-9]{1,2})?$', '\5')::int repli,
  REGEXP_REPLACE(event_id, '^ANH_([0-9]{1,3})_((Pitfall)|(Berlese))([0-9])_(202[12])-[0-9]{1,2}-[0-9]{1,2}(/202[12]-[0-9]{1,2}-[0-9]{1,2})?$', '\6') año,
  cd_pt_ref
FROM raw_dwc.collembolos_event
), campaign AS(
SELECT año, anh_num, ROW_NUMBER() OVER (PARTITION BY anh_num ORDER BY año) campaign_nb
FROM a
GROUP BY año, anh_num
ORDER BY año, anh_num
)
SELECT 'cole',
  CASE
    WHEN metodo='Pitfall' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Pitfall (arthropods)')
    WHEN metodo='Berlese' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Berlese trap (arthropods)')
  END cd_protocol,
  cd_pt_ref,
  c.campaign_nb
FROM a
LEFT JOIN campaign c USING (año, anh_num)
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
GROUP BY cd_pt_ref, name_pt_ref, año, metodo, c.campaign_nb
ORDER BY año,cd_pt_ref,cd_protocol
RETURNING cd_gp_event,cd_gp_biol,cd_protocol,cd_pt_ref,campaign_nb
;
```

Attributing the gp_event

``` sql
ALTER TABLE raw_dwc.collembolos_event ADD COLUMN cd_gp_event int REFERENCES main.gp_event(cd_gp_event) ON DELETE SET NULL;


WITH a AS(
SELECT 
  event_id,
  REGEXP_REPLACE(event_id, '^ANH_([0-9]{1,3})_((Pitfall)|(Berlese))([0-9])_(202[12])-[0-9]{1,2}-[0-9]{1,2}(/202[12]-[0-9]{1,2}-[0-9]{1,2})?$', '\1')::int anh_num,
  REGEXP_REPLACE(event_id, '^ANH_([0-9]{1,3})_((Pitfall)|(Berlese))([0-9])_(202[12])-[0-9]{1,2}-[0-9]{1,2}(/202[12]-[0-9]{1,2}-[0-9]{1,2})?$', '\2') metodo,
  REGEXP_REPLACE(event_id, '^ANH_([0-9]{1,3})_((Pitfall)|(Berlese))([0-9])_(202[12])-[0-9]{1,2}-[0-9]{1,2}(/202[12]-[0-9]{1,2}-[0-9]{1,2})?$', '\5')::int repli,
  REGEXP_REPLACE(event_id, '^ANH_([0-9]{1,3})_((Pitfall)|(Berlese))([0-9])_(202[12])-[0-9]{1,2}-[0-9]{1,2}(/202[12]-[0-9]{1,2}-[0-9]{1,2})?$', '\6') año,
  cd_pt_ref
FROM raw_dwc.collembolos_event
), campaign AS(
SELECT año, anh_num, ROW_NUMBER() OVER (PARTITION BY anh_num ORDER BY año) campaign_nb
FROM a
GROUP BY año, anh_num
ORDER BY año, anh_num
),b AS(
SELECT event_id,
  CASE
    WHEN metodo='Pitfall' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Pitfall (arthropods)')
    WHEN metodo='Berlese' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Berlese trap (arthropods)')
  END cd_protocol,
  cd_pt_ref,
  c.campaign_nb
FROM a
LEFT JOIN campaign c USING (año, anh_num)
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
),d AS(
SELECT b.*, cd_gp_event
FROM b
LEFT JOIN main.gp_event ge ON cd_gp_biol='cole' AND b.cd_protocol=ge.cd_protocol AND b.cd_pt_ref=ge.cd_pt_ref AND b.campaign_nb=ge.campaign_nb
)
UPDATE raw_dwc.collembolos_event e
SET cd_gp_event=d.cd_gp_event
FROM d
WHERE d.event_id=e.event_id
RETURNING e.event_id, e.cd_gp_event
;
```

<div class="knitsql-table">

| event_id                               | cd_gp_event |
|:---------------------------------------|------------:|
| ANH_130_Berlese1_2021-07-12/2021-07-18 |         690 |
| ANH_130_Berlese2_2021-07-12/2021-07-18 |         690 |
| ANH_130_Berlese3_2021-07-12/2021-07-18 |         690 |
| ANH_130_Berlese4_2021-07-12/2021-07-18 |         690 |
| ANH_130_Berlese5_2021-07-12/2021-07-18 |         690 |
| ANH_130_Berlese6_2021-07-12/2021-07-18 |         690 |
| ANH_372_Berlese1_2021-07-13/2021-07-19 |         722 |
| ANH_372_Berlese2_2021-07-13/2021-07-19 |         722 |
| ANH_372_Berlese3_2021-07-13/2021-07-19 |         722 |
| ANH_372_Berlese4_2021-07-13/2021-07-19 |         722 |
| ANH_372_Berlese5_2021-07-13/2021-07-19 |         722 |
| ANH_372_Berlese6_2021-07-13/2021-07-19 |         722 |
| ANH_130_Pitfall1_2021-07-12/2021-07-14 |         691 |
| ANH_130_Pitfall2_2021-07-12/2021-07-14 |         691 |
| ANH_130_Pitfall3_2021-07-12/2021-07-14 |         691 |
| ANH_130_Pitfall4_2021-07-12/2021-07-14 |         691 |
| ANH_130_Pitfall5_2021-07-12/2021-07-14 |         691 |
| ANH_130_Pitfall6_2021-07-12/2021-07-14 |         691 |
| ANH_371_Pitfall5_2021-07-08/2021-07-12 |         721 |
| ANH_371_Pitfall6_2021-07-08/2021-07-12 |         721 |
| ANH_372_Pitfall1_2021-07-13/2021-07-15 |         723 |
| ANH_372_Pitfall2_2021-07-13/2021-07-15 |         723 |
| ANH_374_Pitfall1_2021-07-15/2021-07-17 |         661 |
| ANH_374_Pitfall2_2021-07-15/2021-07-17 |         661 |
| ANH_142_Berlese6_2022-03-31/2022-04-06 |         782 |
| ANH_142_Pitfall1_2022-03-31/2022-04-02 |         783 |
| ANH_142_Pitfall2_2022-03-31/2022-04-02 |         783 |
| ANH_142_Pitfall3_2022-03-31/2022-04-02 |         783 |
| ANH_371_Berlese1_2022-03-28/2022-04-03 |         800 |
| ANH_371_Berlese2_2022-03-28/2022-04-03 |         800 |
| ANH_371_Berlese3_2022-03-28/2022-04-03 |         800 |
| ANH_375_Berlese1_2022-04-04/2022-04-10 |         742 |
| ANH_110_Berlese4_2021-07-14/2021-07-20 |         666 |
| ANH_108_Berlese1_2021-07-13/2021-07-19 |         664 |
| ANH_108_Berlese2_2021-07-13/2021-07-19 |         664 |
| ANH_108_Berlese3_2021-07-13/2021-07-19 |         664 |
| ANH_108_Berlese4_2021-07-13/2021-07-19 |         664 |
| ANH_108_Berlese5_2021-07-13/2021-07-19 |         664 |
| ANH_108_Berlese6_2021-07-13/2021-07-19 |         664 |
| ANH_109_Berlese1_2021-07-14/2021-07-20 |         650 |
| ANH_109_Berlese2_2021-07-14/2021-07-20 |         650 |
| ANH_109_Berlese3_2021-07-14/2021-07-20 |         650 |
| ANH_109_Berlese4_2021-07-14/2021-07-20 |         650 |
| ANH_109_Berlese5_2021-07-14/2021-07-20 |         650 |
| ANH_109_Berlese6_2021-07-14/2021-07-20 |         650 |
| ANH_110_Berlese1_2021-07-14/2021-07-20 |         666 |
| ANH_110_Berlese2_2021-07-14/2021-07-20 |         666 |
| ANH_110_Berlese3_2021-07-14/2021-07-20 |         666 |
| ANH_110_Berlese5_2021-07-14/2021-07-20 |         666 |
| ANH_110_Berlese6_2021-07-14/2021-07-20 |         666 |
| ANH_112_Berlese1_2021-07-07/2021-07-13 |         668 |
| ANH_112_Berlese2_2021-07-07/2021-07-13 |         668 |
| ANH_112_Berlese3_2021-07-07/2021-07-13 |         668 |
| ANH_112_Berlese4_2021-07-07/2021-07-13 |         668 |
| ANH_112_Berlese5_2021-07-07/2021-07-13 |         668 |
| ANH_112_Berlese6_2021-07-07/2021-07-13 |         668 |
| ANH_113_Berlese1_2021-07-12/2021-07-18 |         670 |
| ANH_113_Berlese2_2021-07-12/2021-07-18 |         670 |
| ANH_113_Berlese3_2021-07-12/2021-07-18 |         670 |
| ANH_113_Berlese4_2021-07-12/2021-07-18 |         670 |
| ANH_113_Berlese5_2021-07-12/2021-07-18 |         670 |
| ANH_113_Berlese6_2021-07-12/2021-07-18 |         670 |
| ANH_114_Berlese1_2021-07-06/2021-07-12 |         672 |
| ANH_114_Berlese2_2021-07-06/2021-07-12 |         672 |
| ANH_114_Berlese3_2021-07-06/2021-07-12 |         672 |
| ANH_114_Berlese4_2021-07-06/2021-07-12 |         672 |
| ANH_114_Berlese5_2021-07-06/2021-07-12 |         672 |
| ANH_114_Berlese6_2021-07-06/2021-07-12 |         672 |
| ANH_115_Berlese1_2021-07-02/2021-07-08 |         674 |
| ANH_115_Berlese2_2021-07-02/2021-07-08 |         674 |
| ANH_115_Berlese3_2021-07-02/2021-07-08 |         674 |
| ANH_115_Berlese4_2021-07-02/2021-07-08 |         674 |
| ANH_115_Berlese5_2021-07-02/2021-07-08 |         674 |
| ANH_115_Berlese6_2021-07-02/2021-07-08 |         674 |
| ANH_116_Berlese1_2021-07-02/2021-07-08 |         676 |
| ANH_116_Berlese2_2021-07-02/2021-07-08 |         676 |
| ANH_116_Berlese3_2021-07-02/2021-07-08 |         676 |
| ANH_116_Berlese4_2021-07-02/2021-07-08 |         676 |
| ANH_116_Berlese5_2021-07-02/2021-07-08 |         676 |
| ANH_116_Berlese6_2021-07-02/2021-07-08 |         676 |
| ANH_117_Berlese1_2021-07-06/2021-07-12 |         652 |
| ANH_117_Berlese2_2021-07-06/2021-07-12 |         652 |
| ANH_117_Berlese3_2021-07-06/2021-07-12 |         652 |
| ANH_117_Berlese4_2021-07-06/2021-07-12 |         652 |
| ANH_117_Berlese5_2021-07-06/2021-07-12 |         652 |
| ANH_117_Berlese6_2021-07-06/2021-07-12 |         652 |
| ANH_118_Berlese1_2021-07-14/2021-07-20 |         678 |
| ANH_118_Berlese2_2021-07-14/2021-07-20 |         678 |
| ANH_118_Berlese3_2021-07-14/2021-07-20 |         678 |
| ANH_118_Berlese4_2021-07-14/2021-07-20 |         678 |
| ANH_118_Berlese5_2021-07-14/2021-07-20 |         678 |
| ANH_118_Berlese6_2021-07-14/2021-07-20 |         678 |
| ANH_120_Berlese1_2021-07-14/2021-07-20 |         680 |
| ANH_120_Berlese2_2021-07-14/2021-07-20 |         680 |
| ANH_120_Berlese3_2021-07-14/2021-07-20 |         680 |
| ANH_120_Berlese4_2021-07-14/2021-07-20 |         680 |
| ANH_120_Berlese5_2021-07-14/2021-07-20 |         680 |
| ANH_120_Berlese6_2021-07-14/2021-07-20 |         680 |
| ANH_121_Berlese1_2021-07-12/2021-07-18 |         682 |
| ANH_121_Berlese2_2021-07-12/2021-07-18 |         682 |

Displaying records 1 - 100

</div>

## 7.5 event

``` sql
INSERT INTO main.event(cd_gp_event,event_id,num_replicate, description_replicate, date_time_begin, date_time_end, locality_verb, event_remarks, samp_effort_1, samp_effort_2, pt_geom)
WITH a AS(
SELECT cd_gp_event,
  event_id, 
  REGEXP_REPLACE(event_id, '^ANH_([0-9]{1,3})_((Pitfall)|(Berlese))([0-9])_(202[12])-[0-9]{1,2}-[0-9]{1,2}(/202[12]-[0-9]{1,2}-[0-9]{1,2})?$', '\5')::int num_replicate,
  REGEXP_REPLACE(event_id, '^ANH_([0-9]{1,3})_((Pitfall)|(Berlese))([0-9]_202[12]-[0-9]{1,2}-[0-9]{1,2}(/202[12]-[0-9]{1,2}-[0-9]{1,2})?)$', '\5') description_replicate,
  TO_DATE(SPLIT_PART(event_date,'/',1), 'YYYY-MM-DD') date_1,
  CASE 
    WHEN SPLIT_PART(event_date,'/',2)='' THEN NULL
    ELSE TO_DATE(SPLIT_PART(event_date,'/',2), 'YYYY-MM-DD')
  END date_2,
  REGEXP_REPLACE(SPLIT_PART(event_time,'/',1),'\s+','','g') hora_1,
  CASE
    WHEN REGEXP_REPLACE(SPLIT_PART(event_time,'/',2),'\s+','','g')='' THEN NULL
    ELSE REGEXP_REPLACE(SPLIT_PART(event_time,'/',2),'\s+','','g')
  END hora_2,
  locality locality_verb,
  sample_size_value,
  sampling_effort,
  REGEXP_REPLACE(REGEXP_REPLACE(event_remarks,'\| ?La hora inicial corresponde al día que se instaló la trampa y la hora final al día que se retiró',''),'\| Sin registros de individuos','') event_remarks,
  --locality_remarks,
  decimal_latitude::double precision,
  decimal_longitude::double precision
FROM raw_dwc.collembolos_event
),b AS(--calculation of timestamps and coordinates
SELECT 
  cd_gp_event,
  event_id, 
  num_replicate,
  description_replicate,
  CASE
    WHEN date_1 IS NULL OR hora_1 IS NULL THEN NULL
    ELSE (date_1||' '||hora_1)::timestamp 
  END date_time_begin,
  CASE
    WHEN date_2 IS NULL OR hora_2 IS NULL THEN NULL
    ELSE (date_2||' '||hora_2)::timestamp
  END date_time_end,
  locality_verb,
  event_remarks ,
  sample_size_value,
  sampling_effort,
  ST_SetSRID(ST_Transform(ST_SetSRID(ST_MakePoint(decimal_longitude,decimal_latitude),4326), (SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)),3116) pt_geom
FROM a
LEFT JOIN main.gp_event USING (cd_gp_event)
LEFT JOIN main.def_protocol p USING (cd_protocol)
ORDER BY cd_gp_event, event_id, num_replicate
)--calculation of sampling efforts
SELECT
  cd_gp_event,
  'cole_'||event_id event_id,
  num_replicate,
  description_replicate,
  date_time_begin,
  date_time_end,
  locality_verb,
  event_remarks,
  CASE
   WHEN protocol='Berlese trap (arthropods)' THEN sample_size_value
   WHEN protocol='Pitfall (arthropods)' AND (date_time_begin IS NULL OR date_time_end IS NULL) THEN (REGEXP_REPLACE(sampling_effort,' horas','')::int)*60
   WHEN protocol='Pitfall (arthropods)' AND date_time_begin IS NOT NULL AND date_time_end IS NOT NULL THEN (EXTRACT('EPOCH' FROM (date_time_end-date_time_begin))/60)::int
   ELSE NULL
  END samp_eff_1,
  CASE
   WHEN protocol='Berlese trap (arthropods)' AND date_time_begin IS NOT NULL AND date_time_end IS NOT NULL THEN (EXTRACT('EPOCH' FROM (date_time_end-date_time_begin))/60)::int
   ELSE NULL
  END samp_eff_2,
  pt_geom
FROM b
LEFT JOIN main.gp_event USING (cd_gp_event)
LEFT JOIN main.def_protocol p USING (cd_protocol)
ORDER BY cd_gp_event, event_id, num_replicate

RETURNING main.event.cd_event, main.event.cd_gp_event, main.event.event_id, main.event.num_replicate, main.event.description_replicate, main.event.date_time_begin, main.event.date_time_end, main.event.locality_verb, main.event.event_remarks, main.event.pt_geom
```

Damos los cd_event a todos las filas:

``` sql
ALTER TABLE raw_dwc.collembolos_event ADD COLUMN cd_event int REFERENCES main.event(cd_event) ON DELETE SET NULL;
ALTER TABLE raw_dwc.collembolos_registros ADD COLUMN cd_event int REFERENCES main.event(cd_event);

UPDATE raw_dwc.collembolos_event AS t
SET cd_event=e.cd_event
FROM main.event e
WHERE 'cole_'||t.event_id=e.event_id;

UPDATE raw_dwc.collembolos_registros AS t
SET cd_event=e.cd_event
FROM main.event e
WHERE 'cole_'||t.event_id=e.event_id;

SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

Acá las fechas/horas inicial y final son siempre limpias…

## 7.6 registros

``` sql
SELECT occurrence_id, count(*)
FROM raw_dwc.collembolos_registros 
GROUP BY occurrence_id
HAVING count(*)>1;
```

<div class="knitsql-table">

occurrence_id count ————— ——-

: 0 records

</div>

Parece que la fechas y horas en registros están bien!

``` sql
SELECT e.event_id, e.event_date, r.event_date, e.event_time, r.event_time
FROM raw_dwc.collembolos_registros r
LEFT JOIN raw_dwc.collembolos_event e USING(cd_event)
ORDER BY r.event_date::date, r.event_time::time
```

<div class="knitsql-table">

| event_id                               | event_date            | event_date | event_time        | event_time |
|:---------------------------------------|:----------------------|:-----------|:------------------|:-----------|
| ANH_145_Berlese5_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 01:30:00/01:30:00 | 01:30:00   |
| ANH_145_Berlese6_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 01:41:00/01:41:00 | 01:41:00   |
| ANH_135_Berlese5_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 08:40:00/13:27:00 | 08:40:00   |
| ANH_135_Berlese5_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 08:40:00/13:27:00 | 08:40:00   |
| ANH_147_Berlese1_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 09:23:00/09:23:00 | 09:23:00   |
| ANH_147_Berlese1_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 09:23:00/09:23:00 | 09:23:00   |
| ANH_147_Berlese1_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 09:23:00/09:23:00 | 09:23:00   |
| ANH_147_Berlese1_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 09:23:00/09:23:00 | 09:23:00   |
| ANH_147_Berlese1_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 09:23:00/09:23:00 | 09:23:00   |
| ANH_147_Berlese1_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 09:23:00/09:23:00 | 09:23:00   |
| ANH_147_Berlese1_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 09:23:00/09:23:00 | 09:23:00   |
| ANH_147_Berlese1_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 09:23:00/09:23:00 | 09:23:00   |
| ANH_147_Berlese1_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 09:23:00/09:23:00 | 09:23:00   |
| ANH_147_Berlese4_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 09:57:00/09:57:00 | 09:57:00   |
| ANH_147_Berlese4_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 09:57:00/09:57:00 | 09:57:00   |
| ANH_147_Berlese4_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 09:57:00/09:57:00 | 09:57:00   |
| ANH_147_Berlese4_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 09:57:00/09:57:00 | 09:57:00   |
| ANH_147_Berlese4_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 09:57:00/09:57:00 | 09:57:00   |
| ANH_147_Berlese5_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 09:59:00/09:59:00 | 09:59:00   |
| ANH_147_Berlese5_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 09:59:00/09:59:00 | 09:59:00   |
| ANH_147_Berlese5_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 09:59:00/09:59:00 | 09:59:00   |
| ANH_147_Berlese5_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 09:59:00/09:59:00 | 09:59:00   |
| ANH_147_Berlese5_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 09:59:00/09:59:00 | 09:59:00   |
| ANH_147_Berlese6_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 10:04:00/10:04:00 | 10:04:00   |
| ANH_147_Berlese2_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 09:45:00/09:45:00 | 11:00:00   |
| ANH_145_Berlese1_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 12:50:00/12:50:00 | 11:10:00   |
| ANH_145_Berlese2_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 12:58:00/12:58:00 | 12:58:00   |
| ANH_136_Berlese1_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 14:36:00/14:36:00 | 14:36:00   |
| ANH_136_Berlese2_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 14:48:00/14:48:00 | 14:48:00   |
| ANH_136_Berlese3_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 15:01:00/15:01:00 | 15:01:00   |
| ANH_136_Berlese4_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 15:13:00/15:13:00 | 15:13:00   |
| ANH_136_Berlese4_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 15:13:00/15:13:00 | 15:13:00   |
| ANH_136_Berlese6_2021-07-01/2021-07-07 | 2021-07-01/2021-07-07 | 2021-07-01 | 15:34:00/15:34:00 | 15:34:00   |
| ANH_144_Berlese1_2021-07-02/2021-07-08 | 2021-07-02/2021-07-08 | 2021-07-02 | 08:30:00/08:30:00 | 08:30:00   |
| ANH_144_Berlese2_2021-07-02/2021-07-08 | 2021-07-02/2021-07-08 | 2021-07-02 | 08:40:00/08:40:00 | 08:40:00   |
| ANH_144_Berlese3_2021-07-02/2021-07-08 | 2021-07-02/2021-07-08 | 2021-07-02 | 08:50:00/08:50:00 | 08:50:00   |
| ANH_144_Berlese4_2021-07-02/2021-07-08 | 2021-07-02/2021-07-08 | 2021-07-02 | 09:00:00/09:00:00 | 09:00:00   |
| ANH_144_Berlese5_2021-07-02/2021-07-08 | 2021-07-02/2021-07-08 | 2021-07-02 | 09:10:00/09:10:00 | 09:10:00   |
| ANH_144_Berlese5_2021-07-02/2021-07-08 | 2021-07-02/2021-07-08 | 2021-07-02 | 09:10:00/09:10:00 | 09:10:00   |
| ANH_144_Berlese6_2021-07-02/2021-07-08 | 2021-07-02/2021-07-08 | 2021-07-02 | 09:15:00/09:15:00 | 09:15:00   |
| ANH_144_Berlese6_2021-07-02/2021-07-08 | 2021-07-02/2021-07-08 | 2021-07-02 | 09:15:00/09:15:00 | 09:15:00   |
| ANH_144_Berlese5_2021-07-02/2021-07-08 | 2021-07-02/2021-07-08 | 2021-07-02 | 09:10:00/09:10:00 | 09:55:00   |
| ANH_116_Berlese6_2021-07-02/2021-07-08 | 2021-07-02/2021-07-08 | 2021-07-02 | 10:02:00/10:02:00 | 10:02:00   |
| ANH_116_Berlese4_2021-07-02/2021-07-08 | 2021-07-02/2021-07-08 | 2021-07-02 | 10:33:00/10:33:00 | 10:02:00   |
| ANH_116_Berlese6_2021-07-02/2021-07-08 | 2021-07-02/2021-07-08 | 2021-07-02 | 10:02:00/10:02:00 | 10:02:00   |
| ANH_144_Berlese6_2021-07-02/2021-07-08 | 2021-07-02/2021-07-08 | 2021-07-02 | 09:15:00/09:15:00 | 10:12:00   |
| ANH_116_Berlese2_2021-07-02/2021-07-08 | 2021-07-02/2021-07-08 | 2021-07-02 | 11:00:00/11:00:00 | 10:44:00   |
| ANH_116_Berlese2_2021-07-02/2021-07-08 | 2021-07-02/2021-07-08 | 2021-07-02 | 11:00:00/11:00:00 | 11:00:00   |
| ANH_116_Berlese2_2021-07-02/2021-07-08 | 2021-07-02/2021-07-08 | 2021-07-02 | 11:00:00/11:00:00 | 11:00:00   |
| ANH_116_Berlese2_2021-07-02/2021-07-08 | 2021-07-02/2021-07-08 | 2021-07-02 | 11:00:00/11:00:00 | 11:00:00   |
| ANH_116_Berlese1_2021-07-02/2021-07-08 | 2021-07-02/2021-07-08 | 2021-07-02 | 11:05:00/11:05:00 | 11:05:00   |
| ANH_131_Berlese3_2021-07-02/2021-07-08 | 2021-07-02/2021-07-08 | 2021-07-02 | 12:15:00/12:19:00 | 12:15:00   |
| ANH_131_Berlese3_2021-07-02/2021-07-08 | 2021-07-02/2021-07-08 | 2021-07-02 | 12:15:00/12:19:00 | 12:15:00   |
| ANH_131_Berlese3_2021-07-02/2021-07-08 | 2021-07-02/2021-07-08 | 2021-07-02 | 12:15:00/12:19:00 | 12:15:00   |
| ANH_131_Berlese3_2021-07-02/2021-07-08 | 2021-07-02/2021-07-08 | 2021-07-02 | 12:15:00/12:19:00 | 12:15:00   |
| ANH_131_Berlese5_2021-07-02/2021-07-08 | 2021-07-02/2021-07-08 | 2021-07-02 | 12:20:00/12:27:00 | 12:20:00   |
| ANH_145_Pitfall5_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 01:30:00/01:30:00 | 01:30:00   |
| ANH_145_Pitfall6_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 01:41:00/01:41:00 | 01:41:00   |
| ANH_145_Pitfall6_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 01:41:00/01:41:00 | 01:41:00   |
| ANH_145_Pitfall6_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 01:41:00/01:41:00 | 01:41:00   |
| ANH_145_Pitfall6_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 01:41:00/01:41:00 | 01:41:00   |
| ANH_145_Pitfall6_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 01:41:00/01:41:00 | 01:41:00   |
| ANH_145_Pitfall6_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 01:41:00/01:41:00 | 01:41:00   |
| ANH_145_Pitfall6_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 01:41:00/01:41:00 | 01:41:00   |
| ANH_145_Pitfall6_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 01:41:00/01:41:00 | 01:41:00   |
| ANH_145_Pitfall6_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 01:41:00/01:41:00 | 01:41:00   |
| ANH_145_Pitfall6_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 01:41:00/01:41:00 | 01:41:00   |
| ANH_145_Pitfall6_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 01:41:00/01:41:00 | 01:41:00   |
| ANH_145_Pitfall6_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 01:41:00/01:41:00 | 01:41:00   |
| ANH_145_Pitfall6_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 01:41:00/01:41:00 | 01:41:00   |
| ANH_145_Pitfall6_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 01:41:00/01:41:00 | 01:41:00   |
| ANH_145_Pitfall6_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 01:41:00/01:41:00 | 01:41:00   |
| ANH_145_Pitfall6_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 01:41:00/01:41:00 | 01:41:00   |
| ANH_145_Pitfall6_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 01:41:00/01:41:00 | 01:41:00   |
| ANH_145_Pitfall6_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 01:41:00/01:41:00 | 01:41:00   |
| ANH_145_Pitfall6_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 01:41:00/01:41:00 | 01:41:00   |
| ANH_145_Pitfall6_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 01:41:00/01:41:00 | 01:41:00   |
| ANH_145_Pitfall6_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 01:41:00/01:41:00 | 01:41:00   |
| ANH_145_Pitfall6_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 01:41:00/01:41:00 | 01:41:00   |
| ANH_145_Pitfall6_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 01:41:00/01:41:00 | 01:41:00   |
| ANH_135_Pitfall1_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 08:45:00/07:45:00 | 07:45:00   |
| ANH_135_Pitfall1_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 08:45:00/07:45:00 | 07:45:00   |
| ANH_135_Pitfall1_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 08:45:00/07:45:00 | 07:45:00   |
| ANH_135_Pitfall1_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 08:45:00/07:45:00 | 07:45:00   |
| ANH_135_Pitfall1_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 08:45:00/07:45:00 | 07:45:00   |
| ANH_135_Pitfall1_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 08:45:00/07:45:00 | 07:45:00   |
| ANH_135_Pitfall1_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 08:45:00/07:45:00 | 07:45:00   |
| ANH_135_Pitfall1_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 08:45:00/07:45:00 | 07:45:00   |
| ANH_135_Pitfall1_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 08:45:00/07:45:00 | 07:45:00   |
| ANH_135_Pitfall1_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 08:45:00/07:45:00 | 07:45:00   |
| ANH_135_Pitfall1_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 08:45:00/07:45:00 | 07:45:00   |
| ANH_135_Pitfall1_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 08:45:00/07:45:00 | 07:45:00   |
| ANH_135_Pitfall1_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 08:45:00/07:45:00 | 07:45:00   |
| ANH_135_Pitfall1_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 08:45:00/07:45:00 | 07:45:00   |
| ANH_135_Pitfall1_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 08:45:00/07:45:00 | 07:45:00   |
| ANH_135_Pitfall1_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 08:45:00/07:45:00 | 07:45:00   |
| ANH_135_Pitfall1_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 08:45:00/07:45:00 | 07:45:00   |
| ANH_135_Pitfall1_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 08:45:00/07:45:00 | 07:45:00   |
| ANH_135_Pitfall1_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 08:45:00/07:45:00 | 07:45:00   |
| ANH_135_Pitfall1_2021-07-01/2021-07-03 | 2021-07-01/2021-07-03 | 2021-07-03 | 08:45:00/07:45:00 | 07:45:00   |

Displaying records 1 - 100

</div>

``` sql

INSERT INTO main.registros(cd_event, cds_recorded_by, date_time, cd_tax, cd_morfo, date_ident, cds_identified_by, qt_int,remarks, occurrence_id, organism_id)
SELECT 
 cd_event,
 cds_recorded_by,
 (event_date||' '||event_time)::timestamp date_time,
 tt.cd_tax,
 tt.cd_morfo,
 TO_DATE(date_identified,'YYYY-MM-DD') date_ident,
 cds_identified_by,
 organism_quantity::double precision::int qt_int,
 r.event_remarks,
 occurrence_id,
 SPLIT_PART(occurrence_id,':',7) organism_id
 --ROW_NUMBER() OVER (ORDER BY (e.date_time_begin::date||' '||event_time)::timestamp)
 --organism_id::text
FROM raw_dwc.collembolos_registros r
LEFT JOIN raw_dwc.taxonomy_total tt ON tt."row.names"=r."row.names" AND tt.table_orig='collembolos_registros'
LEFT JOIN main.event e USING (cd_event)
ORDER BY date_time
RETURNING cd_event, cds_recorded_by, date_time, cd_tax, cd_morfo, cds_identified_by, qt_int,remarks, occurrence_id, organism_id
```

``` sql
ALTER TABLE raw_dwc.collembolos_registros ADD COLUMN cd_reg int REFERENCES main.registros(cd_reg);
UPDATE raw_dwc.collembolos_registros AS ar
SET cd_reg=r.cd_reg
FROM main.registros r
WHERE ar.cd_event=r.cd_event AND ar.occurrence_id=r.occurrence_id;

-- Check cd_reg are unique in the source table
SELECT cd_reg,count(*) FROM  raw_dwc.collembolos_registros GROUP BY cd_reg HAVING count(*)>1;
```

<div class="knitsql-table">

    cd_reg   count

------------------------------------------------------------------------

: 0 records

</div>

# 8 Aves

Para entender el plan de muestreo

Para aves (y para mamiferos), existen eventos particulares que no entran
en el plan de muestreo…

``` sql
SELECT occurrence_id event_id,sampling_protocol
FROM raw_dwc.aves_event
WHERE occurrence_id !~'^ANH_[0-9]{1,3}_A(_(P[123]))?_R[0-9]{1,2}_T[12]'
```

<div class="knitsql-table">

| event_id         | sampling_protocol   |
|:-----------------|:--------------------|
| ANH_64_T1        | Redes de Niebla     |
| ANH_65_T1        | Redes de Niebla     |
| ANH_380_T1       | Accidental          |
| ANH_162_T1       | Recorrido en lancha |
| ANH_4_T1         | Recorrido Libre     |
| ANH_162_T2       | Recorrido en lancha |
| ANH_4_T2         | Recorrido en lancha |
| ANH_92_Asio_T2   | Accidental          |
| AT_Crotophaga_T2 | Accidental          |

9 records

</div>

``` sql
WITH a AS(
SELECT occurrence_id,
  CASE
    WHEN occurrence_id ~ '^ANH_([0-9]{1,3})_.*$' THEN REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_.*$','\1')
    ELSE NULL
  END anh_num,
  CASE 
    WHEN sampling_protocol ~ '[Rr]ecorrido' THEN 'recorrido'
    WHEN occurrence_id ~ '^ANH_[0-9]{1,3}_A(_(P[123]))?_R[0-9]{1,2}_T[12]' AND sampling_protocol ~ '[Nn]iebla' THEN 'niebla'
    WHEN occurrence_id ~ '^ANH_[0-9]{1,3}_A(_(P[123]))?_R[0-9]{1,2}_T[12]' AND sampling_protocol ~ '[Pp]unto [Ff]ijo' THEN 'punto fijo'
    ELSE 'accidental'
  END metodo,
  CASE
    WHEN sampling_protocol ~ '[Pp]unto [Ff]ijo' THEN REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_A(_(P[123]))?_R([0-9]{1,2})_(T[12])','\3')
    ELSE NULL
  END punto,
  CASE
    WHEN occurrence_id ~ '^ANH_[0-9]{1,3}_A(_(P[123]))?_R[0-9]{1,2}_T[12]' THEN REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_A(_(P[123]))?_R([0-9]{1,2})_(T[12])','\4')::int
    ELSE NULL
  END repli,
  UNNEST(REGEXP_MATCH(occurrence_id,'^.*(T[12])$')) tempo
FROM raw_dwc.aves_event
)
SELECT anh_num, tempo, ARRAY_AGG(DISTINCT metodo ORDER BY metodo),  count(*)
FROM a
GROUP BY anh_num, tempo
;
```

<div class="knitsql-table">

| anh_num | tempo | array_agg             | count |
|:--------|:------|:----------------------|------:|
| 128     | T1    | {“punto fijo”}        |     9 |
| 128     | T2    | {“punto fijo”}        |     9 |
| 154     | T1    | {“punto fijo”}        |     9 |
| 154     | T2    | {“punto fijo”}        |     9 |
| 162     | T1    | {recorrido}           |     1 |
| 162     | T2    | {recorrido}           |     1 |
| 169     | T1    | {“punto fijo”}        |     9 |
| 169     | T2    | {“punto fijo”}        |     9 |
| 185     | T1    | {“punto fijo”}        |     9 |
| 185     | T2    | {“punto fijo”}        |     9 |
| 189     | T1    | {niebla,“punto fijo”} |    19 |
| 189     | T2    | {“punto fijo”}        |     9 |
| 191     | T1    | {“punto fijo”}        |     9 |
| 191     | T2    | {“punto fijo”}        |     9 |
| 192     | T1    | {“punto fijo”}        |     9 |
| 192     | T2    | {“punto fijo”}        |     9 |
| 197     | T1    | {“punto fijo”}        |     9 |
| 197     | T2    | {“punto fijo”}        |     9 |
| 208     | T1    | {“punto fijo”}        |     9 |
| 208     | T2    | {“punto fijo”}        |     9 |
| 211     | T1    | {“punto fijo”}        |     9 |
| 211     | T2    | {“punto fijo”}        |     9 |
| 213     | T1    | {“punto fijo”}        |     9 |
| 213     | T2    | {“punto fijo”}        |     9 |
| 218     | T1    | {“punto fijo”}        |     9 |
| 218     | T2    | {“punto fijo”}        |     9 |
| 220     | T1    | {“punto fijo”}        |     9 |
| 220     | T2    | {“punto fijo”}        |     9 |
| 221     | T1    | {“punto fijo”}        |     9 |
| 221     | T2    | {“punto fijo”}        |     9 |
| 222     | T1    | {“punto fijo”}        |     9 |
| 222     | T2    | {“punto fijo”}        |     9 |
| 223     | T1    | {“punto fijo”}        |     9 |
| 223     | T2    | {“punto fijo”}        |     9 |
| 225     | T1    | {“punto fijo”}        |     9 |
| 225     | T2    | {“punto fijo”}        |     9 |
| 226     | T1    | {“punto fijo”}        |     9 |
| 226     | T2    | {“punto fijo”}        |     9 |
| 227     | T1    | {“punto fijo”}        |     9 |
| 227     | T2    | {“punto fijo”}        |     9 |
| 228     | T1    | {“punto fijo”}        |     9 |
| 228     | T2    | {“punto fijo”}        |     9 |
| 229     | T1    | {“punto fijo”}        |     9 |
| 229     | T2    | {“punto fijo”}        |     9 |
| 230     | T1    | {“punto fijo”}        |     9 |
| 230     | T2    | {“punto fijo”}        |     9 |
| 232     | T1    | {“punto fijo”}        |     9 |
| 232     | T2    | {“punto fijo”}        |     9 |
| 233     | T1    | {“punto fijo”}        |     9 |
| 233     | T2    | {“punto fijo”}        |     9 |
| 235     | T1    | {“punto fijo”}        |     9 |
| 235     | T2    | {“punto fijo”}        |     9 |
| 236     | T1    | {“punto fijo”}        |     9 |
| 236     | T2    | {“punto fijo”}        |     9 |
| 238     | T1    | {“punto fijo”}        |     9 |
| 238     | T2    | {“punto fijo”}        |     9 |
| 239     | T1    | {“punto fijo”}        |     9 |
| 239     | T2    | {“punto fijo”}        |     9 |
| 240     | T1    | {niebla,“punto fijo”} |    19 |
| 240     | T2    | {niebla,“punto fijo”} |    19 |
| 241     | T1    | {“punto fijo”}        |     9 |
| 241     | T2    | {“punto fijo”}        |     9 |
| 244     | T1    | {“punto fijo”}        |     9 |
| 244     | T2    | {“punto fijo”}        |     9 |
| 248     | T1    | {“punto fijo”}        |     9 |
| 248     | T2    | {“punto fijo”}        |     9 |
| 250     | T1    | {“punto fijo”}        |     9 |
| 250     | T2    | {“punto fijo”}        |     9 |
| 252     | T1    | {“punto fijo”}        |     9 |
| 252     | T2    | {“punto fijo”}        |     9 |
| 253     | T1    | {“punto fijo”}        |     9 |
| 253     | T2    | {“punto fijo”}        |     9 |
| 254     | T1    | {“punto fijo”}        |     9 |
| 254     | T2    | {“punto fijo”}        |     9 |
| 256     | T1    | {“punto fijo”}        |     9 |
| 256     | T2    | {“punto fijo”}        |     9 |
| 258     | T1    | {“punto fijo”}        |     9 |
| 258     | T2    | {“punto fijo”}        |     9 |
| 272     | T1    | {“punto fijo”}        |     9 |
| 272     | T2    | {“punto fijo”}        |     9 |
| 274     | T1    | {“punto fijo”}        |     9 |
| 274     | T2    | {“punto fijo”}        |     9 |
| 275     | T1    | {“punto fijo”}        |     9 |
| 275     | T2    | {“punto fijo”}        |     9 |
| 279     | T1    | {“punto fijo”}        |     9 |
| 279     | T2    | {“punto fijo”}        |     9 |
| 280     | T1    | {“punto fijo”}        |     9 |
| 280     | T2    | {“punto fijo”}        |     9 |
| 282     | T1    | {“punto fijo”}        |     9 |
| 282     | T2    | {“punto fijo”}        |     9 |
| 283     | T1    | {“punto fijo”}        |     9 |
| 283     | T2    | {“punto fijo”}        |     9 |
| 289     | T1    | {“punto fijo”}        |     9 |
| 289     | T2    | {“punto fijo”}        |     9 |
| 360     | T1    | {“punto fijo”}        |     9 |
| 360     | T2    | {“punto fijo”}        |     9 |
| 361     | T1    | {“punto fijo”}        |     9 |
| 361     | T2    | {“punto fijo”}        |     9 |
| 380     | T1    | {accidental}          |     1 |
| 387     | T1    | {niebla}              |    10 |

Displaying records 1 - 100

</div>

``` sql
WITH a AS(
SELECT occurrence_id,
  CASE
    WHEN occurrence_id ~ '^ANH_([0-9]{1,3})_.*$' THEN REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_.*$','\1')::int
    ELSE NULL
  END anh_num,
  CASE 
    WHEN sampling_protocol ~ '[Rr]ecorrido' THEN 'recorrido'
    WHEN occurrence_id ~ '^ANH_[0-9]{1,3}_A(_(P[123]))?_R[0-9]{1,2}_T[12]' AND sampling_protocol ~ '[Nn]iebla' THEN 'niebla'
    WHEN occurrence_id ~ '^ANH_[0-9]{1,3}_A(_(P[123]))?_R[0-9]{1,2}_T[12]' AND sampling_protocol ~ '[Pp]unto [Ff]ijo' THEN 'punto fijo'
    ELSE 'accidental'
  END metodo,
  CASE
    WHEN sampling_protocol ~ '[Pp]unto [Ff]ijo' THEN REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_A(_(P[123]))?_R([0-9]{1,2})_(T[12])','\3')
    ELSE NULL
  END punto,
  CASE
    WHEN occurrence_id ~ '^ANH_[0-9]{1,3}_A(_(P[123]))?_R[0-9]{1,2}_T[12]' THEN REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_A(_(P[123]))?_R([0-9]{1,2})_(T[12])','\4')::int
    ELSE NULL
  END repli,
  UNNEST(REGEXP_MATCH(occurrence_id,'^.*(T[12])$')) tempo
FROM raw_dwc.aves_event
)
SELECT anh_num, tempo,metodo, ARRAY_AGG(DISTINCT repli ORDER BY repli) repli,  count(*)
FROM a
GROUP BY anh_num, tempo, metodo
ORDER BY anh_num,tempo, metodo
;
```

<div class="knitsql-table">

| anh_num | tempo | metodo     | repli                  | count |
|--------:|:------|:-----------|:-----------------------|------:|
|       4 | T1    | recorrido  | {NULL}                 |     1 |
|       4 | T2    | recorrido  | {NULL}                 |     1 |
|      64 | T1    | accidental | {NULL}                 |     1 |
|      65 | T1    | accidental | {NULL}                 |     1 |
|      74 | T1    | punto fijo | {1,2,3}                |     9 |
|      74 | T2    | punto fijo | {1,2,3}                |     9 |
|      82 | T1    | punto fijo | {1,2,3}                |     9 |
|      82 | T2    | punto fijo | {1,2,3}                |     9 |
|      92 | T2    | accidental | {NULL}                 |     1 |
|      96 | T1    | niebla     | {1,2,3,4,5,6,7,8,9,10} |    10 |
|      96 | T2    | niebla     | {1,2,3,4,5,6,7,8,9,10} |    10 |
|     128 | T1    | punto fijo | {1,2,3}                |     9 |
|     128 | T2    | punto fijo | {1,2,3}                |     9 |
|     154 | T1    | punto fijo | {1,2,3}                |     9 |
|     154 | T2    | punto fijo | {1,2,3}                |     9 |
|     162 | T1    | recorrido  | {NULL}                 |     1 |
|     162 | T2    | recorrido  | {NULL}                 |     1 |
|     169 | T1    | punto fijo | {1,2,3}                |     9 |
|     169 | T2    | punto fijo | {1,2,3}                |     9 |
|     185 | T1    | punto fijo | {1,2,3}                |     9 |
|     185 | T2    | punto fijo | {1,2,3}                |     9 |
|     189 | T1    | niebla     | {1,2,3,4,5,6,7,8,9,10} |    10 |
|     189 | T1    | punto fijo | {1,2,3}                |     9 |
|     189 | T2    | punto fijo | {1,2,3}                |     9 |
|     191 | T1    | punto fijo | {1,2,3}                |     9 |
|     191 | T2    | punto fijo | {1,2,3}                |     9 |
|     192 | T1    | punto fijo | {1,2,3}                |     9 |
|     192 | T2    | punto fijo | {1,2,3}                |     9 |
|     197 | T1    | punto fijo | {1,2,3}                |     9 |
|     197 | T2    | punto fijo | {1,2,3}                |     9 |
|     208 | T1    | punto fijo | {1,2,3}                |     9 |
|     208 | T2    | punto fijo | {1,2,3}                |     9 |
|     211 | T1    | punto fijo | {1,2,3}                |     9 |
|     211 | T2    | punto fijo | {1,2,3}                |     9 |
|     213 | T1    | punto fijo | {1,2,3}                |     9 |
|     213 | T2    | punto fijo | {1,2,3}                |     9 |
|     218 | T1    | punto fijo | {1,2,3}                |     9 |
|     218 | T2    | punto fijo | {1,2,3}                |     9 |
|     220 | T1    | punto fijo | {1,2,3}                |     9 |
|     220 | T2    | punto fijo | {1,2,3}                |     9 |
|     221 | T1    | punto fijo | {1,2,3}                |     9 |
|     221 | T2    | punto fijo | {1,2,3}                |     9 |
|     222 | T1    | punto fijo | {1,2,3}                |     9 |
|     222 | T2    | punto fijo | {1,2,3}                |     9 |
|     223 | T1    | punto fijo | {1,2,3}                |     9 |
|     223 | T2    | punto fijo | {1,2,3}                |     9 |
|     225 | T1    | punto fijo | {1,2,3}                |     9 |
|     225 | T2    | punto fijo | {1,2,3}                |     9 |
|     226 | T1    | punto fijo | {1,2,3}                |     9 |
|     226 | T2    | punto fijo | {1,2,3}                |     9 |
|     227 | T1    | punto fijo | {1,2,3}                |     9 |
|     227 | T2    | punto fijo | {1,2,3}                |     9 |
|     228 | T1    | punto fijo | {1,2,3}                |     9 |
|     228 | T2    | punto fijo | {1,2,3}                |     9 |
|     229 | T1    | punto fijo | {1,2,3}                |     9 |
|     229 | T2    | punto fijo | {1,2,3}                |     9 |
|     230 | T1    | punto fijo | {1,2,3}                |     9 |
|     230 | T2    | punto fijo | {1,2,3}                |     9 |
|     232 | T1    | punto fijo | {1,2,3}                |     9 |
|     232 | T2    | punto fijo | {1,2,3}                |     9 |
|     233 | T1    | punto fijo | {1,2,3}                |     9 |
|     233 | T2    | punto fijo | {1,2,3}                |     9 |
|     235 | T1    | punto fijo | {1,2,3}                |     9 |
|     235 | T2    | punto fijo | {1,2,3}                |     9 |
|     236 | T1    | punto fijo | {1,2,3}                |     9 |
|     236 | T2    | punto fijo | {1,2,3}                |     9 |
|     238 | T1    | punto fijo | {1,2,3}                |     9 |
|     238 | T2    | punto fijo | {1,2,3}                |     9 |
|     239 | T1    | punto fijo | {1,2,3}                |     9 |
|     239 | T2    | punto fijo | {1,2,3}                |     9 |
|     240 | T1    | niebla     | {1,2,3,4,5,6,7,8,9,10} |    10 |
|     240 | T1    | punto fijo | {1,2,3}                |     9 |
|     240 | T2    | niebla     | {1,2,3,4,5,6,7,8,9,10} |    10 |
|     240 | T2    | punto fijo | {1,2,3}                |     9 |
|     241 | T1    | punto fijo | {1,2,3}                |     9 |
|     241 | T2    | punto fijo | {1,2,3}                |     9 |
|     244 | T1    | punto fijo | {1,2,3}                |     9 |
|     244 | T2    | punto fijo | {1,2,3}                |     9 |
|     248 | T1    | punto fijo | {1,2,3}                |     9 |
|     248 | T2    | punto fijo | {1,2,3}                |     9 |
|     250 | T1    | punto fijo | {1,2,3}                |     9 |
|     250 | T2    | punto fijo | {1,2,3}                |     9 |
|     252 | T1    | punto fijo | {1,2,3}                |     9 |
|     252 | T2    | punto fijo | {1,2,3}                |     9 |
|     253 | T1    | punto fijo | {1,2,3}                |     9 |
|     253 | T2    | punto fijo | {1,2,3}                |     9 |
|     254 | T1    | punto fijo | {1,2,3}                |     9 |
|     254 | T2    | punto fijo | {1,2,3}                |     9 |
|     256 | T1    | punto fijo | {1,2,3}                |     9 |
|     256 | T2    | punto fijo | {1,2,3}                |     9 |
|     258 | T1    | punto fijo | {1,2,3}                |     9 |
|     258 | T2    | punto fijo | {1,2,3}                |     9 |
|     272 | T1    | punto fijo | {1,2,3}                |     9 |
|     272 | T2    | punto fijo | {1,2,3}                |     9 |
|     274 | T1    | punto fijo | {1,2,3}                |     9 |
|     274 | T2    | punto fijo | {1,2,3}                |     9 |
|     275 | T1    | punto fijo | {1,2,3}                |     9 |
|     275 | T2    | punto fijo | {1,2,3}                |     9 |
|     279 | T1    | punto fijo | {1,2,3}                |     9 |
|     279 | T2    | punto fijo | {1,2,3}                |     9 |

Displaying records 1 - 100

</div>

## 8.1 ANH

- **utilizar occurrenceID para el eventID puede ser muy confuso cuando
  este juego de datos vaya a pasar a las bases de datos internacionales
  como GBIF, debería ser eventID**

Insertar los datos de anh:

``` sql
INSERT INTO main.punto_referencia(name_pt_ref, num_anh)
WITH a AS(
SELECT
  REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3}).*$','\1')::int anh_num,
  REGEXP_REPLACE(occurrence_id,'^(ANH_[0-9]{1,3}).*$','\1') anh_name
FROM raw_dwc.aves_event
WHERE occurrence_id ~ '^ANH_([0-9]{1,3})'
)
SELECT anh_name, anh_num
FROM a
GROUP BY anh_name,anh_num
ORDER BY anh_num
ON CONFLICT (name_pt_ref) DO NOTHING
RETURNING cd_pt_ref, name_pt_ref
;
```

dar las referencias en las tablas de aves

``` sql
ALTER TABLE raw_dwc.aves_event ADD COLUMN cd_pt_ref int REFERENCES main.punto_referencia(cd_pt_ref) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE raw_dwc.aves_registros ADD COLUMN cd_pt_ref int REFERENCES main.punto_referencia(cd_pt_ref) ON DELETE SET NULL ON UPDATE CASCADE;

UPDATE raw_dwc.aves_event
SET cd_pt_ref=pr.cd_pt_ref
FROM main.punto_referencia pr
WHERE REGEXP_REPLACE(occurrence_id,'^(ANH_[0-9]{1,3}).*$','\1') = name_pt_ref
;

UPDATE raw_dwc.aves_registros
SET cd_pt_ref=pr.cd_pt_ref
FROM main.punto_referencia pr
WHERE  REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3}).*$','\1') = name_pt_ref
;

SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

Averiguando que ninguna fila no tenga anh

``` sql
SELECT occurrence_id FROM raw_dwc.aves_event WHERE cd_pt_ref IS NULL;
```

<div class="knitsql-table">

| occurrence_id    |
|:-----------------|
| AT_Crotophaga_T2 |

1 records

</div>

``` sql
SELECT occurrence_id,event_id FROM raw_dwc.aves_registros WHERE cd_pt_ref IS NULL;
```

<div class="knitsql-table">

| occurrence_id                                                            | event_id         |
|:-------------------------------------------------------------------------|:-----------------|
| IAvH:SSCPE-ANH:SANTANDER:AVES:ESPECIMENPRESERVADO:I2D-BIO_2021_050:10172 | AT_Crotophaga_T2 |

1 records

</div>

## 8.2 Unit, sampling efforts definition, abundance definition, protocolo

``` sql
INSERT INTO main.def_var_samp_eff(var_samp_eff, var_samp_eff_spa, cd_unit,type_variable)
VALUES(
  'Trap area',
  'Superficie de la trampa',
  (SELECT cd_unit FROM main.def_unit WHERE cd_measurement_type=(SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='area') AND unit='Square meter'),
  'double precision'
  )
RETURNING cd_var_samp_eff, var_samp_eff ;
```

``` sql
INSERT INTO main.def_protocol(protocol,protocol_spa,cd_var_samp_eff_1,cd_var_samp_eff_2,samp_eff_1_implicit,samp_eff_2_implicit,cd_var_ind_qt,description_spa)
VALUES(
  'Mist nets',
  'Redes de niebla',
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Trap area'),
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Elapsed time'),
  false,
  false,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind='Number of individuals'),
  NULL
),(
  'Bird point count',
  'Punto fijo',
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Elapsed time'),
  NULL,
  true,
  NULL,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind='Number of individuals'),
  NULL
),(
  'Free transect',
  'Recorrido libre',
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Covered distance'),
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Elapsed time'),
  false,
  false,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind='Number of individuals'),
  NULL
),(
  'Accidental encounter',
  'Encuentro accidental',
  NULL,
  NULL,
  NULL,
  NULL,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind='Number of individuals'),
  'Puede representar encuentros de individuos en eventos de muestreos pensados para otros grupos biologicos, o encuentros accidentales fuera de todo evento de muestreo'
)
RETURNING cd_protocol,protocol,protocol_spa;
```

## 8.3 Personas

``` sql
INSERT INTO main.people(verbatim_person)
WITH a AS(
SELECT DISTINCT INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(recorded_by, ' | ')))) AS name_person
FROM raw_dwc.aves_registros
UNION
SELECT DISTINCT INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(identified_by, ' | '))))
FROM raw_dwc.aves_registros
)
SELECT DISTINCT REGEXP_REPLACE(name_person, '- ','-')
FROM a 
ORDER BY REGEXP_REPLACE(name_person, '- ','-')
ON CONFLICT(verbatim_person) DO NOTHING
RETURNING cd_person, verbatim_person
```

Dar los codigos a las tables de origen:

``` sql
ALTER TABLE raw_dwc.aves_registros ADD COLUMN cds_recorded_by int[];

WITH a AS(
SELECT "row.names", REGEXP_REPLACE(INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(recorded_by, ' | ')))),'- ','-') AS name_person
FROM raw_dwc.aves_registros
),b AS(
SELECT "row.names", ARRAY_AGG(cd_person) cds
FROM a 
LEFT JOIN main.people p ON a.name_person=p.verbatim_person
GROUP BY "row.names"
)
UPDATE raw_dwc.aves_registros AS r
SET cds_recorded_by=b.cds
FROM b
WHERE r."row.names"=b."row.names"
RETURNING r."row.names", cds_recorded_by
;

ALTER TABLE raw_dwc.aves_registros ADD COLUMN cds_identified_by int[];

WITH a AS(
SELECT "row.names", REGEXP_REPLACE(INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(identified_by, ' | ')))),'- ','-') AS name_person
FROM raw_dwc.aves_registros
),b AS(
SELECT "row.names", ARRAY_AGG(cd_person) cds
FROM a 
LEFT JOIN main.people p ON a.name_person=p.verbatim_person
GROUP BY "row.names"
)
UPDATE raw_dwc.aves_registros AS r
SET cds_identified_by=b.cds
FROM b
WHERE r."row.names"=b."row.names"
RETURNING r."row.names", cds_identified_by
;

SELECT 1;
```

<div class="knitsql-table">

| ?column? |
|---------:|
|        1 |

1 records

</div>

## 8.4 gp_event

``` sql
WITH a AS(
SELECT 
  occurrence_id,
  CASE
    WHEN occurrence_id ~ '^ANH_([0-9]{1,3})_.*$' THEN REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_.*$','\1')::int
    ELSE NULL
  END anh_num,
  CASE 
    WHEN sampling_protocol ~ '[Rr]ecorrido' THEN 'recorrido'
    WHEN occurrence_id ~ '^ANH_[0-9]{1,3}_A(_(P[123]))?_R[0-9]{1,2}_T[12]' AND sampling_protocol ~ '[Nn]iebla' THEN 'niebla'
    WHEN occurrence_id ~ '^ANH_[0-9]{1,3}_A(_(P[123]))?_R[0-9]{1,2}_T[12]' AND sampling_protocol ~ '[Pp]unto [Ff]ijo' THEN 'punto fijo'
    ELSE 'accidental'
  END metodo,
  CASE
    WHEN sampling_protocol ~ '[Pp]unto [Ff]ijo' THEN REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_A(_(P[123]))?_R([0-9]{1,2})_(T[12])','\3')
    ELSE NULL
  END punto,
  CASE
    WHEN occurrence_id ~ '^ANH_[0-9]{1,3}_A(_(P[123]))?_R[0-9]{1,2}_T[12]' THEN REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_A(_(P[123]))?_R([0-9]{1,2})_(T[12])','\4')::int
    ELSE NULL
  END repli,
  UNNEST(REGEXP_MATCH(occurrence_id,'^.*(T[12])$')) tempo
FROM raw_dwc.aves_event
)
SELECT tempo, anh_num,metodo, ARRAY_AGG(repli), count(*)
FROM a
GROUP BY tempo, anh_num, metodo
ORDER BY tempo, anh_num, metodo
;
```

<div class="knitsql-table">

| tempo | anh_num | metodo     | array_agg              | count |
|:------|--------:|:-----------|:-----------------------|------:|
| T1    |       4 | recorrido  | {NULL}                 |     1 |
| T1    |      64 | accidental | {NULL}                 |     1 |
| T1    |      65 | accidental | {NULL}                 |     1 |
| T1    |      74 | punto fijo | {3,3,1,3,2,2,1,2,1}    |     9 |
| T1    |      82 | punto fijo | {2,1,3,2,1,3,2,1,3}    |     9 |
| T1    |      96 | niebla     | {9,1,4,3,2,5,6,7,8,10} |    10 |
| T1    |     128 | punto fijo | {3,1,2,3,1,2,3,1,2}    |     9 |
| T1    |     154 | punto fijo | {1,3,2,1,3,2,1,3,2}    |     9 |
| T1    |     162 | recorrido  | {NULL}                 |     1 |
| T1    |     169 | punto fijo | {3,2,1,3,2,1,3,1,2}    |     9 |
| T1    |     185 | punto fijo | {3,2,3,1,2,1,2,3,1}    |     9 |
| T1    |     189 | niebla     | {1,2,3,4,5,6,7,8,9,10} |    10 |
| T1    |     189 | punto fijo | {3,2,1,3,2,1,3,2,1}    |     9 |
| T1    |     191 | punto fijo | {1,3,2,1,3,2,1,3,2}    |     9 |
| T1    |     192 | punto fijo | {1,3,2,1,3,2,1,3,2}    |     9 |
| T1    |     197 | punto fijo | {2,3,2,1,3,2,1,3,1}    |     9 |
| T1    |     208 | punto fijo | {1,1,3,2,2,3,1,2,3}    |     9 |
| T1    |     211 | punto fijo | {1,2,3,1,2,3,1,2,3}    |     9 |
| T1    |     213 | punto fijo | {2,3,2,1,3,1,2,3,1}    |     9 |
| T1    |     218 | punto fijo | {3,1,3,2,1,3,2,1,2}    |     9 |
| T1    |     220 | punto fijo | {3,1,2,3,1,2,3,2,1}    |     9 |
| T1    |     221 | punto fijo | {3,2,3,2,1,1,3,2,1}    |     9 |
| T1    |     222 | punto fijo | {1,3,2,1,3,2,1,3,2}    |     9 |
| T1    |     223 | punto fijo | {2,1,1,2,2,1,3,3,3}    |     9 |
| T1    |     225 | punto fijo | {3,1,2,3,2,1,2,3,1}    |     9 |
| T1    |     226 | punto fijo | {1,2,1,2,3,2,1,3,3}    |     9 |
| T1    |     227 | punto fijo | {2,1,2,3,1,2,3,1,3}    |     9 |
| T1    |     228 | punto fijo | {1,3,2,3,1,2,3,1,2}    |     9 |
| T1    |     229 | punto fijo | {3,3,1,2,1,3,2,1,2}    |     9 |
| T1    |     230 | punto fijo | {2,2,1,3,1,2,3,3,1}    |     9 |
| T1    |     232 | punto fijo | {1,1,2,3,1,2,3,2,3}    |     9 |
| T1    |     233 | punto fijo | {1,2,3,1,2,3,2,3,1}    |     9 |
| T1    |     235 | punto fijo | {2,3,2,1,3,2,1,3,1}    |     9 |
| T1    |     236 | punto fijo | {2,1,3,1,3,2,2,1,3}    |     9 |
| T1    |     238 | punto fijo | {3,2,1,3,2,1,3,2,1}    |     9 |
| T1    |     239 | punto fijo | {3,1,2,3,1,2,3,1,2}    |     9 |
| T1    |     240 | niebla     | {7,6,5,10,9,8,4,3,2,1} |    10 |
| T1    |     240 | punto fijo | {1,2,3,1,2,3,1,2,3}    |     9 |
| T1    |     241 | punto fijo | {2,1,3,1,2,3,1,2,3}    |     9 |
| T1    |     244 | punto fijo | {3,2,1,3,2,1,3,2,1}    |     9 |
| T1    |     248 | punto fijo | {3,1,2,3,1,2,1,2,3}    |     9 |
| T1    |     250 | punto fijo | {1,3,2,1,3,2,1,3,2}    |     9 |
| T1    |     252 | punto fijo | {1,3,2,1,3,2,1,3,2}    |     9 |
| T1    |     253 | punto fijo | {2,1,3,2,1,3,2,1,3}    |     9 |
| T1    |     254 | punto fijo | {1,2,3,1,2,3,1,2,3}    |     9 |
| T1    |     256 | punto fijo | {1,1,2,3,1,2,3,2,3}    |     9 |
| T1    |     258 | punto fijo | {3,1,3,2,2,1,1,3,2}    |     9 |
| T1    |     272 | punto fijo | {1,3,2,1,3,2,1,3,2}    |     9 |
| T1    |     274 | punto fijo | {2,3,1,2,3,1,2,3,1}    |     9 |
| T1    |     275 | punto fijo | {3,3,2,1,1,3,2,1,2}    |     9 |
| T1    |     279 | punto fijo | {3,2,1,3,2,1,3,2,1}    |     9 |
| T1    |     280 | punto fijo | {3,2,1,3,2,1,3,2,1}    |     9 |
| T1    |     282 | punto fijo | {2,3,2,3,2,1,1,3,1}    |     9 |
| T1    |     283 | punto fijo | {3,1,3,2,3,2,1,1,2}    |     9 |
| T1    |     289 | punto fijo | {1,3,2,1,3,2,3,2,1}    |     9 |
| T1    |     360 | punto fijo | {3,1,2,3,1,2,3,1,2}    |     9 |
| T1    |     361 | punto fijo | {3,1,2,3,1,2,3,1,2}    |     9 |
| T1    |     380 | accidental | {NULL}                 |     1 |
| T1    |     387 | niebla     | {1,2,3,4,5,6,7,8,10,9} |    10 |
| T1    |     389 | niebla     | {3,4,1,2,6,7,8,9,10,5} |    10 |
| T2    |       4 | recorrido  | {NULL}                 |     1 |
| T2    |      74 | punto fijo | {3,1,1,2,1,2,3,3,2}    |     9 |
| T2    |      82 | punto fijo | {2,1,2,3,1,3,3,2,1}    |     9 |
| T2    |      92 | accidental | {NULL}                 |     1 |
| T2    |      96 | niebla     | {6,4,1,2,3,8,9,7,10,5} |    10 |
| T2    |     128 | punto fijo | {3,1,2,3,1,2,3,1,2}    |     9 |
| T2    |     154 | punto fijo | {1,2,1,3,2,1,3,3,2}    |     9 |
| T2    |     162 | recorrido  | {NULL}                 |     1 |
| T2    |     169 | punto fijo | {3,1,2,1,2,3,1,2,3}    |     9 |
| T2    |     185 | punto fijo | {1,1,3,1,2,3,2,3,2}    |     9 |
| T2    |     189 | punto fijo | {2,1,1,3,3,2,2,3,1}    |     9 |
| T2    |     191 | punto fijo | {2,1,2,3,2,1,3,3,1}    |     9 |
| T2    |     192 | punto fijo | {3,1,1,2,3,1,3,2,2}    |     9 |
| T2    |     197 | punto fijo | {3,1,2,3,1,2,3,1,2}    |     9 |
| T2    |     208 | punto fijo | {1,3,1,2,3,2,1,3,2}    |     9 |
| T2    |     211 | punto fijo | {3,1,2,3,1,2,3,1,2}    |     9 |
| T2    |     213 | punto fijo | {3,2,1,3,1,3,2,2,1}    |     9 |
| T2    |     218 | punto fijo | {3,2,3,3,2,1,1,2,1}    |     9 |
| T2    |     220 | punto fijo | {2,1,3,1,2,3,1,2,3}    |     9 |
| T2    |     221 | punto fijo | {2,1,3,2,1,3,2,1,3}    |     9 |
| T2    |     222 | punto fijo | {2,3,1,2,3,1,2,3,1}    |     9 |
| T2    |     223 | punto fijo | {1,3,2,1,2,1,3,3,2}    |     9 |
| T2    |     225 | punto fijo | {1,1,2,3,2,3,1,2,3}    |     9 |
| T2    |     226 | punto fijo | {1,2,3,1,3,2,3,1,2}    |     9 |
| T2    |     227 | punto fijo | {2,3,2,1,3,1,3,2,1}    |     9 |
| T2    |     228 | punto fijo | {2,1,2,3,1,3,2,1,3}    |     9 |
| T2    |     229 | punto fijo | {2,1,2,3,1,3,1,2,3}    |     9 |
| T2    |     230 | punto fijo | {2,1,3,2,1,3,2,1,3}    |     9 |
| T2    |     232 | punto fijo | {2,3,1,2,3,2,3,1,1}    |     9 |
| T2    |     233 | punto fijo | {2,1,3,2,1,1,3,2,3}    |     9 |
| T2    |     235 | punto fijo | {3,1,2,3,1,3,1,2,2}    |     9 |
| T2    |     236 | punto fijo | {3,1,2,3,1,2,3,1,2}    |     9 |
| T2    |     238 | punto fijo | {1,3,1,2,3,1,2,2,3}    |     9 |
| T2    |     239 | punto fijo | {2,3,3,3,1,2,2,1,1}    |     9 |
| T2    |     240 | niebla     | {7,10,8,6,5,4,2,9,1,3} |    10 |
| T2    |     240 | punto fijo | {1,1,2,3,2,3,1,2,3}    |     9 |
| T2    |     241 | punto fijo | {1,2,3,1,3,2,3,1,2}    |     9 |
| T2    |     244 | punto fijo | {2,3,2,1,3,1,1,3,2}    |     9 |
| T2    |     248 | punto fijo | {2,3,1,2,3,2,1,3,1}    |     9 |
| T2    |     250 | punto fijo | {1,1,2,3,2,3,1,2,3}    |     9 |

Displaying records 1 - 100

</div>

Because there is more than a method, the number of the campaign should
be determined this way:

``` sql
WITH a AS(
SELECT 
  occurrence_id,
  CASE
    WHEN occurrence_id ~ '^ANH_([0-9]{1,3})_.*$' THEN REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_.*$','\1')::int
    ELSE NULL
  END anh_num,
  CASE 
    WHEN sampling_protocol ~ '[Rr]ecorrido' THEN 'recorrido'
    WHEN occurrence_id ~ '^ANH_[0-9]{1,3}_A(_(P[123]))?_R[0-9]{1,2}_T[12]' AND sampling_protocol ~ '[Nn]iebla' THEN 'niebla'
    WHEN occurrence_id ~ '^ANH_[0-9]{1,3}_A(_(P[123]))?_R[0-9]{1,2}_T[12]' AND sampling_protocol ~ '[Pp]unto [Ff]ijo' THEN 'punto fijo'
    ELSE 'accidental'
  END metodo,
  CASE
    WHEN sampling_protocol ~ '[Pp]unto [Ff]ijo' THEN REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_A(_(P[123]))?_R([0-9]{1,2})_(T[12])','\3')
    ELSE NULL
  END punto,
  CASE
    WHEN occurrence_id ~ '^ANH_[0-9]{1,3}_A(_(P[123]))?_R[0-9]{1,2}_T[12]' THEN REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_A(_(P[123]))?_R([0-9]{1,2})_(T[12])','\4')::int
    ELSE NULL
  END repli,
  UNNEST(REGEXP_MATCH(occurrence_id,'^.*(T[12])$')) tempo
FROM raw_dwc.aves_event
)
SELECT tempo, anh_num, ROW_NUMBER() OVER (PARTITION BY anh_num ORDER BY tempo) campaign_nb
FROM a
GROUP BY tempo, anh_num
ORDER BY tempo, anh_num
;
```

<div class="knitsql-table">

| tempo | anh_num | campaign_nb |
|:------|--------:|------------:|
| T1    |       4 |           1 |
| T1    |      64 |           1 |
| T1    |      65 |           1 |
| T1    |      74 |           1 |
| T1    |      82 |           1 |
| T1    |      96 |           1 |
| T1    |     128 |           1 |
| T1    |     154 |           1 |
| T1    |     162 |           1 |
| T1    |     169 |           1 |
| T1    |     185 |           1 |
| T1    |     189 |           1 |
| T1    |     191 |           1 |
| T1    |     192 |           1 |
| T1    |     197 |           1 |
| T1    |     208 |           1 |
| T1    |     211 |           1 |
| T1    |     213 |           1 |
| T1    |     218 |           1 |
| T1    |     220 |           1 |
| T1    |     221 |           1 |
| T1    |     222 |           1 |
| T1    |     223 |           1 |
| T1    |     225 |           1 |
| T1    |     226 |           1 |
| T1    |     227 |           1 |
| T1    |     228 |           1 |
| T1    |     229 |           1 |
| T1    |     230 |           1 |
| T1    |     232 |           1 |
| T1    |     233 |           1 |
| T1    |     235 |           1 |
| T1    |     236 |           1 |
| T1    |     238 |           1 |
| T1    |     239 |           1 |
| T1    |     240 |           1 |
| T1    |     241 |           1 |
| T1    |     244 |           1 |
| T1    |     248 |           1 |
| T1    |     250 |           1 |
| T1    |     252 |           1 |
| T1    |     253 |           1 |
| T1    |     254 |           1 |
| T1    |     256 |           1 |
| T1    |     258 |           1 |
| T1    |     272 |           1 |
| T1    |     274 |           1 |
| T1    |     275 |           1 |
| T1    |     279 |           1 |
| T1    |     280 |           1 |
| T1    |     282 |           1 |
| T1    |     283 |           1 |
| T1    |     289 |           1 |
| T1    |     360 |           1 |
| T1    |     361 |           1 |
| T1    |     380 |           1 |
| T1    |     387 |           1 |
| T1    |     389 |           1 |
| T2    |       4 |           2 |
| T2    |      74 |           2 |
| T2    |      82 |           2 |
| T2    |      92 |           1 |
| T2    |      96 |           2 |
| T2    |     128 |           2 |
| T2    |     154 |           2 |
| T2    |     162 |           2 |
| T2    |     169 |           2 |
| T2    |     185 |           2 |
| T2    |     189 |           2 |
| T2    |     191 |           2 |
| T2    |     192 |           2 |
| T2    |     197 |           2 |
| T2    |     208 |           2 |
| T2    |     211 |           2 |
| T2    |     213 |           2 |
| T2    |     218 |           2 |
| T2    |     220 |           2 |
| T2    |     221 |           2 |
| T2    |     222 |           2 |
| T2    |     223 |           2 |
| T2    |     225 |           2 |
| T2    |     226 |           2 |
| T2    |     227 |           2 |
| T2    |     228 |           2 |
| T2    |     229 |           2 |
| T2    |     230 |           2 |
| T2    |     232 |           2 |
| T2    |     233 |           2 |
| T2    |     235 |           2 |
| T2    |     236 |           2 |
| T2    |     238 |           2 |
| T2    |     239 |           2 |
| T2    |     240 |           2 |
| T2    |     241 |           2 |
| T2    |     244 |           2 |
| T2    |     248 |           2 |
| T2    |     250 |           2 |
| T2    |     252 |           2 |
| T2    |     253 |           2 |
| T2    |     254 |           2 |

Displaying records 1 - 100

</div>

``` sql
INSERT INTO main.gp_event(cd_gp_biol,cd_protocol,cd_pt_ref,campaign_nb, subpart)
WITH a AS(
SELECT 
  occurrence_id,
  CASE
    WHEN occurrence_id ~ '^ANH_([0-9]{1,3})_.*$' THEN REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_.*$','\1')::int
    ELSE NULL
  END anh_num,
  CASE 
    WHEN sampling_protocol ~ '[Rr]ecorrido' THEN 'recorrido'
    WHEN occurrence_id ~ '^ANH_[0-9]{1,3}_A(_(P[123]))?_R[0-9]{1,2}_T[12]' AND sampling_protocol ~ '[Nn]iebla' THEN 'niebla'
    WHEN occurrence_id ~ '^ANH_[0-9]{1,3}_A(_(P[123]))?_R[0-9]{1,2}_T[12]' AND sampling_protocol ~ '[Pp]unto [Ff]ijo' THEN 'punto fijo'
    ELSE 'accidental'
  END metodo,
  CASE
    WHEN sampling_protocol ~ '[Pp]unto [Ff]ijo' THEN REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_A(_(P[123]))?_R([0-9]{1,2})_(T[12])','\3')
    ELSE NULL
  END punto,
  CASE
    WHEN occurrence_id ~ '^ANH_[0-9]{1,3}_A(_(P[123]))?_R[0-9]{1,2}_T[12]' THEN REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_A(_(P[123]))?_R([0-9]{1,2})_(T[12])','\4')::int
    ELSE NULL
  END repli,
  UNNEST(REGEXP_MATCH(occurrence_id,'^.*(T[12])$')) tempo,
  cd_pt_ref
FROM raw_dwc.aves_event
), campaign AS(
SELECT tempo, anh_num, ROW_NUMBER() OVER (PARTITION BY anh_num ORDER BY tempo) campaign_nb
FROM a
GROUP BY tempo, anh_num
ORDER BY tempo, anh_num
)
SELECT 'aves',
  CASE
    WHEN metodo='punto fijo' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Bird point count')
    WHEN metodo='niebla' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Mist nets')
    WHEN metodo='recorrido' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Free transect')
    WHEN metodo='accidental' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Accidental encounter')
  END cd_protocol,
  cd_pt_ref,
  c.campaign_nb,
  punto
FROM a
LEFT JOIN campaign c ON c.tempo=a.tempo AND (c.anh_num=a.anh_num OR (c.anh_num IS NULL AND a.anh_num IS NULL))
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
GROUP BY cd_pt_ref, name_pt_ref, a.tempo, metodo, c.campaign_nb, punto
ORDER BY a.tempo,cd_pt_ref,cd_protocol,punto
RETURNING cd_gp_event,cd_gp_biol,cd_protocol,cd_pt_ref,campaign_nb,subpart
;
```

Attributing the gp_event

``` sql
ALTER TABLE raw_dwc.aves_event ADD COLUMN cd_gp_event int REFERENCES main.gp_event(cd_gp_event) ON DELETE SET NULL;


WITH a AS(
SELECT 
  occurrence_id,
  CASE
    WHEN occurrence_id ~ '^ANH_([0-9]{1,3})_.*$' THEN REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_.*$','\1')::int
    ELSE NULL
  END anh_num,
  CASE 
    WHEN sampling_protocol ~ '[Rr]ecorrido' THEN 'recorrido'
    WHEN occurrence_id ~ '^ANH_[0-9]{1,3}_A(_(P[123]))?_R[0-9]{1,2}_T[12]' AND sampling_protocol ~ '[Nn]iebla' THEN 'niebla'
    WHEN occurrence_id ~ '^ANH_[0-9]{1,3}_A(_(P[123]))?_R[0-9]{1,2}_T[12]' AND sampling_protocol ~ '[Pp]unto [Ff]ijo' THEN 'punto fijo'
    ELSE 'accidental'
  END metodo,
  CASE
    WHEN sampling_protocol ~ '[Pp]unto [Ff]ijo' THEN REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_A(_(P[123]))?_R([0-9]{1,2})_(T[12])','\3')
    ELSE NULL
  END punto,
  CASE
    WHEN occurrence_id ~ '^ANH_[0-9]{1,3}_A(_(P[123]))?_R[0-9]{1,2}_T[12]' THEN REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_A(_(P[123]))?_R([0-9]{1,2})_(T[12])','\4')::int
    ELSE NULL
  END repli,
  UNNEST(REGEXP_MATCH(occurrence_id,'^.*(T[12])$')) tempo,
  cd_pt_ref
FROM raw_dwc.aves_event
), campaign AS(
SELECT tempo, anh_num, ROW_NUMBER() OVER (PARTITION BY anh_num ORDER BY tempo) campaign_nb
FROM a
GROUP BY tempo, anh_num
ORDER BY tempo, anh_num
),b AS(
SELECT occurrence_id,
  CASE
    WHEN metodo='punto fijo' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Bird point count')
    WHEN metodo='niebla' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Mist nets')
    WHEN metodo='recorrido' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Free transect')
    WHEN metodo='accidental' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Accidental encounter')
  END cd_protocol,
  cd_pt_ref,
  c.campaign_nb,
  a.punto
FROM a
LEFT JOIN campaign c ON c.tempo=a.tempo AND (c.anh_num=a.anh_num OR (c.anh_num IS NULL AND a.anh_num IS NULL))
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
),d AS(
SELECT b.*, cd_gp_event
FROM b
LEFT JOIN main.gp_event ge ON cd_gp_biol='aves' AND b.cd_protocol=ge.cd_protocol AND ((b.cd_pt_ref=ge.cd_pt_ref) OR (b.cd_pt_ref IS NULL AND ge.cd_pt_ref IS NULL)) AND b.campaign_nb=ge.campaign_nb AND ((b.punto=ge.subpart) OR (b.punto IS NULL AND ge.subpart IS NULL))
)
UPDATE raw_dwc.aves_event e
SET cd_gp_event=d.cd_gp_event
FROM d
WHERE d.occurrence_id=e.occurrence_id
RETURNING e.occurrence_id, e.cd_gp_event
;
```

<div class="knitsql-table">

| occurrence_id      | cd_gp_event |
|:-------------------|------------:|
| ANH_220_A_P1_R1_T1 |         867 |
| ANH_220_A_P1_R2_T1 |         867 |
| ANH_220_A_P1_R3_T1 |         867 |
| ANH_220_A_P2_R1_T1 |         868 |
| ANH_220_A_P2_R2_T1 |         868 |
| ANH_220_A_P2_R3_T1 |         868 |
| ANH_220_A_P3_R1_T1 |         869 |
| ANH_220_A_P3_R2_T1 |         869 |
| ANH_220_A_P3_R3_T1 |         869 |
| ANH_250_A_P1_R1_T1 |         922 |
| ANH_250_A_P1_R2_T1 |         922 |
| ANH_250_A_P1_R3_T1 |         922 |
| ANH_250_A_P2_R1_T1 |         923 |
| ANH_250_A_P2_R2_T1 |         923 |
| ANH_250_A_P2_R3_T1 |         923 |
| ANH_250_A_P3_R1_T1 |         924 |
| ANH_250_A_P3_R2_T1 |         924 |
| ANH_250_A_P3_R3_T1 |         924 |
| ANH_213_A_P1_R1_T1 |         861 |
| AT_Crotophaga_T2   |        1144 |
| ANH_213_A_P1_R2_T1 |         861 |
| ANH_213_A_P1_R3_T1 |         861 |
| ANH_213_A_P2_R1_T1 |         862 |
| ANH_213_A_P2_R2_T1 |         862 |
| ANH_213_A_P2_R3_T1 |         862 |
| ANH_213_A_P3_R1_T1 |         863 |
| ANH_213_A_P3_R2_T1 |         863 |
| ANH_213_A_P3_R3_T1 |         863 |
| ANH_274_A_P1_R1_T1 |         943 |
| ANH_240_A_R5_T1    |         909 |
| ANH_274_A_P1_R2_T1 |         943 |
| ANH_274_A_P1_R3_T1 |         943 |
| ANH_274_A_P2_R1_T1 |         944 |
| ANH_274_A_P2_R2_T1 |         944 |
| ANH_274_A_P2_R3_T1 |         944 |
| ANH_274_A_P3_R1_T1 |         945 |
| ANH_274_A_P3_R2_T1 |         945 |
| ANH_274_A_P3_R3_T1 |         945 |
| ANH_275_A_P1_R1_T1 |         946 |
| ANH_275_A_P1_R2_T1 |         946 |
| ANH_275_A_P1_R3_T1 |         946 |
| ANH_275_A_P2_R1_T1 |         947 |
| ANH_275_A_P2_R2_T1 |         947 |
| ANH_275_A_P2_R3_T1 |         947 |
| ANH_275_A_P3_R1_T1 |         948 |
| ANH_275_A_P3_R2_T1 |         948 |
| ANH_275_A_P3_R3_T1 |         948 |
| ANH_241_A_P1_R1_T1 |         913 |
| ANH_241_A_P1_R2_T1 |         913 |
| ANH_241_A_P1_R3_T1 |         913 |
| ANH_241_A_P2_R1_T1 |         914 |
| ANH_241_A_P2_R2_T1 |         914 |
| ANH_241_A_P2_R3_T1 |         914 |
| ANH_241_A_P3_R1_T1 |         915 |
| ANH_241_A_P3_R2_T1 |         915 |
| ANH_241_A_P3_R3_T1 |         915 |
| ANH_272_A_P1_R1_T1 |         940 |
| ANH_272_A_P1_R2_T1 |         940 |
| ANH_272_A_P1_R3_T1 |         940 |
| ANH_272_A_P2_R1_T1 |         941 |
| ANH_272_A_P2_R2_T1 |         941 |
| ANH_272_A_P2_R3_T1 |         941 |
| ANH_272_A_P3_R1_T1 |         942 |
| ANH_272_A_P3_R2_T1 |         942 |
| ANH_272_A_P3_R3_T1 |         942 |
| ANH_189_A_P1_R1_T1 |         843 |
| ANH_189_A_P1_R2_T1 |         843 |
| ANH_189_A_P1_R3_T1 |         843 |
| ANH_189_A_P3_R1_T1 |         845 |
| ANH_189_A_P3_R2_T1 |         845 |
| ANH_189_A_P3_R3_T1 |         845 |
| ANH_189_A_P2_R1_T1 |         844 |
| ANH_189_A_P2_R2_T1 |         844 |
| ANH_189_A_P2_R3_T1 |         844 |
| ANH_289_A_P1_R1_T1 |         961 |
| ANH_289_A_P1_R2_T1 |         961 |
| ANH_289_A_P1_R3_T1 |         961 |
| ANH_289_A_P2_R1_T1 |         962 |
| ANH_289_A_P2_R2_T1 |         962 |
| ANH_289_A_P2_R3_T1 |         962 |
| ANH_289_A_P3_R1_T1 |         963 |
| ANH_289_A_P3_R2_T1 |         963 |
| ANH_289_A_P3_R3_T1 |         963 |
| ANH_223_A_P1_R1_T1 |         823 |
| ANH_223_A_P1_R2_T1 |         823 |
| ANH_223_A_P1_R3_T1 |         823 |
| ANH_223_A_P2_R1_T1 |         824 |
| ANH_223_A_P2_R2_T1 |         824 |
| ANH_223_A_P2_R3_T1 |         824 |
| ANH_223_A_P3_R1_T1 |         825 |
| ANH_223_A_P3_R2_T1 |         825 |
| ANH_223_A_P3_R3_T1 |         825 |
| ANH_226_A_P1_R1_T1 |         879 |
| ANH_226_A_P1_R2_T1 |         879 |
| ANH_226_A_P1_R3_T1 |         879 |
| ANH_226_A_P2_R1_T1 |         880 |
| ANH_226_A_P2_R2_T1 |         880 |
| ANH_226_A_P2_R3_T1 |         880 |
| ANH_226_A_P3_R1_T1 |         881 |
| ANH_226_A_P3_R2_T1 |         881 |

Displaying records 1 - 100

</div>

## 8.5 event

**Note los sampling effort no corresponden en termino de tiempo a lo que
hay en las fechas/horas inicial y final** Eso es verdad tanto para las
redes de niebla que para los recorridos. Es muy posible que en el caso
de las redes de niebla, sea un calculo un poco complejo en funcion del
numero de trampas

``` sql
INSERT INTO main.event(cd_gp_event,event_id,num_replicate, description_replicate, date_time_begin, date_time_end, locality_verb, event_remarks, samp_effort_1, samp_effort_2, pt_geom)
WITH a AS(
SELECT cd_gp_event,
  occurrence_id, 
  CASE
    WHEN occurrence_id ~ '^ANH_[0-9]{1,3}_A(_(P[123]))?_R[0-9]{1,2}_T[12]' THEN REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_A(_(P[123]))?_R([0-9]{1,2})_(T[12])','\4')::int
    ELSE NULL
  END repli,
  TO_DATE(SPLIT_PART(event_date,'/',1), 'YYYY-MM-DD') date_1,
  CASE 
    WHEN SPLIT_PART(event_date,'/',2)='' THEN NULL
    ELSE TO_DATE(SPLIT_PART(event_date,'/',2), 'YYYY-MM-DD')
  END date_2,
  REGEXP_REPLACE(SPLIT_PART(event_time,'/',1),'\s+','','g') hora_1,
  CASE
    WHEN REGEXP_REPLACE(SPLIT_PART(event_time,'/',2),'\s+','','g')='' THEN NULL
    ELSE REGEXP_REPLACE(SPLIT_PART(event_time,'/',2),'\s+','','g')
  END hora_2,
  locality locality_verb,
  --sample_size_value,
  sampling_size_value,
  sampling_size_unit,
  sampling_effort,
  event_remarks,
  --locality_remarks,
  decimal_latitude::double precision,
  decimal_longitude::double precision
FROM raw_dwc.aves_event
),b AS(--calculation of timestamps, coordinates and num_replicate
SELECT 
  cd_gp_event,
  occurrence_id, 
  ROW_NUMBER() OVER (PARTITION BY cd_gp_event ORDER BY repli) num_replicate,
  'R'||repli description_replicate,
  CASE
    WHEN date_1 IS NULL OR hora_1 IS NULL THEN NULL
    ELSE (date_1||' '||hora_1)::timestamp 
  END date_time_begin,
  CASE
    WHEN hora_2 IS NULL THEN NULL
    WHEN date_2 IS NULL AND (date_1||' '||hora_2)::timestamp::time='00:00'::time THEN ((date_1::date)+1 ||' '||hora_2)::timestamp
    WHEN date_2 IS NULL AND (date_1||' '||hora_2)::timestamp::time!='00:00'::time THEN (date_1||' '||hora_2)::timestamp
    ELSE (date_2||' '||hora_2)::timestamp
  END date_time_end,
  locality_verb,
  event_remarks ,
  sampling_size_value,
  sampling_size_unit,
  sampling_effort,
  ST_SetSRID(ST_Transform(ST_SetSRID(ST_MakePoint(decimal_longitude,decimal_latitude),4326),(SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)),3116) pt_geom
FROM a
LEFT JOIN main.gp_event USING (cd_gp_event)
LEFT JOIN main.def_protocol p USING (cd_protocol)
ORDER BY cd_gp_event, occurrence_id, num_replicate
)--calculation of sampling efforts
SELECT
  cd_gp_event,
  'aves_'||occurrence_id occurrence_id,
  num_replicate,
  description_replicate,
  date_time_begin,
  date_time_end,
  locality_verb,
  event_remarks,
  CASE
   WHEN protocol='Bird point count' THEN sampling_size_value::double precision
   WHEN protocol='Mist nets' THEN NULL -- to check later
   WHEN protocol='Free transect' AND sampling_size_unit='Kilometros' THEN (sampling_size_value::double precision)*1000
   WHEN protocol='Free transect' AND sampling_size_unit='Metros' THEN (sampling_size_value::double precision)
   ELSE NULL
  END samp_eff_1,
  CASE
   WHEN protocol='Mist nets' THEN sampling_size_value::double precision*60 -- to check later
   WHEN protocol='Free transect' AND sampling_effort ~ 'en [0-9]+ ?min' THEN REGEXP_REPLACE(sampling_effort, '^.*en ([0-9]+) ?min.*$','\1')::int   
   WHEN protocol='Free transect' AND sampling_effort !~ 'en [0-9]+ ?min' THEN EXTRACT(EPOCH FROM(date_time_end-date_time_begin))/60
   ELSE NULL
  END samp_eff_2,
  pt_geom
FROM b
LEFT JOIN main.gp_event USING (cd_gp_event)
LEFT JOIN main.def_protocol p USING (cd_protocol)
ORDER BY cd_gp_event, occurrence_id, num_replicate

RETURNING main.event.cd_event, main.event.cd_gp_event, main.event.event_id, main.event.num_replicate, main.event.description_replicate, main.event.date_time_begin, main.event.date_time_end, main.event.locality_verb, main.event.event_remarks, main.event.pt_geom
```

Damos los cd_event a todos las filas:

``` sql
ALTER TABLE raw_dwc.aves_event ADD COLUMN cd_event int REFERENCES main.event(cd_event) ON DELETE SET NULL;
ALTER TABLE raw_dwc.aves_registros ADD COLUMN cd_event int REFERENCES main.event(cd_event);

UPDATE raw_dwc.aves_event AS t
SET cd_event=e.cd_event
FROM main.event e
WHERE 'aves_'||t.occurrence_id=e.event_id;

UPDATE raw_dwc.aves_registros AS t
SET cd_event=e.cd_event
FROM main.event e
WHERE 'aves_'||t.event_id=e.event_id;

SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

Acá las fechas/horas inicial y final son siempre limpias…

## 8.6 registros

``` sql
SELECT occurrence_id, count(*)
FROM raw_dwc.aves_registros 
GROUP BY occurrence_id
HAVING count(*)>1;
```

<div class="knitsql-table">

occurrence_id count ————— ——-

: 0 records

</div>

**Parece que la fechas y horas en registros correspondan usualmente a la
fechas y horas iniciales de los eventos, tambien en algunos casos falta
la hora**

``` sql
SELECT e.occurrence_id, e.event_date, r.event_date, e.event_time, r.event_time
FROM raw_dwc.aves_registros r
LEFT JOIN raw_dwc.aves_event e USING(cd_event)
ORDER BY r.event_date::date, r.event_time::time
```

<div class="knitsql-table">

| occurrence_id      | event_date | event_date | event_time        | event_time |
|:-------------------|:-----------|:-----------|:------------------|:-----------|
| ANH_220_A_P3_R2_T1 | 2021-06-30 | 2021-06-30 | 06:05:00/06:15:00 | 06:05:00   |
| ANH_220_A_P3_R2_T1 | 2021-06-30 | 2021-06-30 | 06:05:00/06:15:00 | 06:05:00   |
| ANH_220_A_P3_R2_T1 | 2021-06-30 | 2021-06-30 | 06:05:00/06:15:00 | 06:05:00   |
| ANH_220_A_P3_R2_T1 | 2021-06-30 | 2021-06-30 | 06:05:00/06:15:00 | 06:05:00   |
| ANH_220_A_P3_R2_T1 | 2021-06-30 | 2021-06-30 | 06:05:00/06:15:00 | 06:05:00   |
| ANH_220_A_P2_R1_T1 | 2021-06-30 | 2021-06-30 | 06:05:00/06:15:00 | 06:05:00   |
| ANH_220_A_P2_R1_T1 | 2021-06-30 | 2021-06-30 | 06:05:00/06:15:00 | 06:05:00   |
| ANH_220_A_P2_R1_T1 | 2021-06-30 | 2021-06-30 | 06:05:00/06:15:00 | 06:05:00   |
| ANH_220_A_P2_R1_T1 | 2021-06-30 | 2021-06-30 | 06:05:00/06:15:00 | 06:05:00   |
| ANH_220_A_P2_R1_T1 | 2021-06-30 | 2021-06-30 | 06:05:00/06:15:00 | 06:05:00   |
| ANH_220_A_P3_R2_T1 | 2021-06-30 | 2021-06-30 | 06:05:00/06:15:00 | 06:05:00   |
| ANH_220_A_P2_R1_T1 | 2021-06-30 | 2021-06-30 | 06:05:00/06:15:00 | 06:05:00   |
| ANH_220_A_P2_R1_T1 | 2021-06-30 | 2021-06-30 | 06:05:00/06:15:00 | 06:05:00   |
| ANH_220_A_P2_R1_T1 | 2021-06-30 | 2021-06-30 | 06:05:00/06:15:00 | 06:05:00   |
| ANH_220_A_P2_R1_T1 | 2021-06-30 | 2021-06-30 | 06:05:00/06:15:00 | 06:05:00   |
| ANH_220_A_P1_R1_T1 | 2021-06-30 | 2021-06-30 | 06:20:00/06:30:00 | 06:20:00   |
| ANH_220_A_P3_R3_T1 | 2021-06-30 | 2021-06-30 | 06:20:00/06:30:00 | 06:20:00   |
| ANH_220_A_P3_R3_T1 | 2021-06-30 | 2021-06-30 | 06:20:00/06:30:00 | 06:20:00   |
| ANH_220_A_P3_R3_T1 | 2021-06-30 | 2021-06-30 | 06:20:00/06:30:00 | 06:20:00   |
| ANH_220_A_P1_R1_T1 | 2021-06-30 | 2021-06-30 | 06:20:00/06:30:00 | 06:20:00   |
| ANH_220_A_P1_R2_T1 | 2021-06-30 | 2021-06-30 | 06:25:00/06:35:00 | 06:25:00   |
| ANH_220_A_P1_R2_T1 | 2021-06-30 | 2021-06-30 | 06:25:00/06:35:00 | 06:25:00   |
| ANH_220_A_P1_R2_T1 | 2021-06-30 | 2021-06-30 | 06:25:00/06:35:00 | 06:25:00   |
| ANH_220_A_P1_R2_T1 | 2021-06-30 | 2021-06-30 | 06:25:00/06:35:00 | 06:25:00   |
| ANH_220_A_P1_R2_T1 | 2021-06-30 | 2021-06-30 | 06:25:00/06:35:00 | 06:25:00   |
| ANH_220_A_P1_R2_T1 | 2021-06-30 | 2021-06-30 | 06:25:00/06:35:00 | 06:25:00   |
| ANH_220_A_P1_R2_T1 | 2021-06-30 | 2021-06-30 | 06:25:00/06:35:00 | 06:25:00   |
| ANH_220_A_P1_R2_T1 | 2021-06-30 | 2021-06-30 | 06:25:00/06:35:00 | 06:25:00   |
| ANH_220_A_P1_R2_T1 | 2021-06-30 | 2021-06-30 | 06:25:00/06:35:00 | 06:25:00   |
| ANH_220_A_P1_R2_T1 | 2021-06-30 | 2021-06-30 | 06:25:00/06:35:00 | 06:25:00   |
| ANH_220_A_P1_R3_T1 | 2021-06-30 | 2021-06-30 | 06:35:00/06:45:00 | 06:35:00   |
| ANH_220_A_P2_R2_T1 | 2021-06-30 | 2021-06-30 | 06:35:00/06:45:00 | 06:35:00   |
| ANH_220_A_P2_R2_T1 | 2021-06-30 | 2021-06-30 | 06:35:00/06:45:00 | 06:35:00   |
| ANH_220_A_P1_R3_T1 | 2021-06-30 | 2021-06-30 | 06:35:00/06:45:00 | 06:35:00   |
| ANH_220_A_P1_R3_T1 | 2021-06-30 | 2021-06-30 | 06:35:00/06:45:00 | 06:35:00   |
| ANH_220_A_P1_R3_T1 | 2021-06-30 | 2021-06-30 | 06:35:00/06:45:00 | 06:35:00   |
| ANH_220_A_P1_R3_T1 | 2021-06-30 | 2021-06-30 | 06:35:00/06:45:00 | 06:35:00   |
| ANH_220_A_P1_R3_T1 | 2021-06-30 | 2021-06-30 | 06:35:00/06:45:00 | 06:35:00   |
| ANH_220_A_P2_R3_T1 | 2021-06-30 | 2021-06-30 | 06:40:00/06:50:00 | 06:40:00   |
| ANH_220_A_P2_R3_T1 | 2021-06-30 | 2021-06-30 | 06:40:00/06:50:00 | 06:40:00   |
| ANH_220_A_P2_R3_T1 | 2021-06-30 | 2021-06-30 | 06:40:00/06:50:00 | 06:40:00   |
| ANH_220_A_P2_R3_T1 | 2021-06-30 | 2021-06-30 | 06:40:00/06:50:00 | 06:40:00   |
| ANH_220_A_P2_R3_T1 | 2021-06-30 | 2021-06-30 | 06:40:00/06:50:00 | 06:40:00   |
| ANH_220_A_P2_R3_T1 | 2021-06-30 | 2021-06-30 | 06:40:00/06:50:00 | 06:40:00   |
| ANH_250_A_P1_R1_T1 | 2021-06-30 | 2021-06-30 | 07:40:00/07:50:00 | 07:40:00   |
| ANH_250_A_P1_R1_T1 | 2021-06-30 | 2021-06-30 | 07:40:00/07:50:00 | 07:40:00   |
| ANH_250_A_P1_R1_T1 | 2021-06-30 | 2021-06-30 | 07:40:00/07:50:00 | 07:40:00   |
| ANH_250_A_P1_R1_T1 | 2021-06-30 | 2021-06-30 | 07:40:00/07:50:00 | 07:40:00   |
| ANH_250_A_P1_R1_T1 | 2021-06-30 | 2021-06-30 | 07:40:00/07:50:00 | 07:40:00   |
| ANH_250_A_P1_R1_T1 | 2021-06-30 | 2021-06-30 | 07:40:00/07:50:00 | 07:40:00   |
| ANH_250_A_P1_R1_T1 | 2021-06-30 | 2021-06-30 | 07:40:00/07:50:00 | 07:40:00   |
| ANH_250_A_P1_R1_T1 | 2021-06-30 | 2021-06-30 | 07:40:00/07:50:00 | 07:40:00   |
| ANH_250_A_P1_R1_T1 | 2021-06-30 | 2021-06-30 | 07:40:00/07:50:00 | 07:40:00   |
| ANH_250_A_P2_R1_T1 | 2021-06-30 | 2021-06-30 | 07:46:00/07:56:00 | 07:46:00   |
| ANH_250_A_P2_R1_T1 | 2021-06-30 | 2021-06-30 | 07:46:00/07:56:00 | 07:46:00   |
| ANH_250_A_P3_R1_T1 | 2021-06-30 | 2021-06-30 | 07:47:00/07:57:00 | 07:47:00   |
| ANH_250_A_P3_R1_T1 | 2021-06-30 | 2021-06-30 | 07:47:00/07:57:00 | 07:47:00   |
| ANH_250_A_P3_R1_T1 | 2021-06-30 | 2021-06-30 | 07:47:00/07:57:00 | 07:47:00   |
| ANH_250_A_P3_R1_T1 | 2021-06-30 | 2021-06-30 | 07:47:00/07:57:00 | 07:47:00   |
| ANH_250_A_P3_R1_T1 | 2021-06-30 | 2021-06-30 | 07:47:00/07:57:00 | 07:47:00   |
| ANH_250_A_P3_R1_T1 | 2021-06-30 | 2021-06-30 | 07:47:00/07:57:00 | 07:47:00   |
| ANH_250_A_P3_R1_T1 | 2021-06-30 | 2021-06-30 | 07:47:00/07:57:00 | 07:47:00   |
| ANH_250_A_P3_R1_T1 | 2021-06-30 | 2021-06-30 | 07:47:00/07:57:00 | 07:47:00   |
| ANH_250_A_P3_R1_T1 | 2021-06-30 | 2021-06-30 | 07:47:00/07:57:00 | 07:47:00   |
| ANH_250_A_P3_R1_T1 | 2021-06-30 | 2021-06-30 | 07:47:00/07:57:00 | 07:47:00   |
| ANH_250_A_P3_R1_T1 | 2021-06-30 | 2021-06-30 | 07:47:00/07:57:00 | 07:47:00   |
| ANH_250_A_P2_R2_T1 | 2021-06-30 | 2021-06-30 | 07:58:00/08:08:00 | 07:58:00   |
| ANH_250_A_P2_R2_T1 | 2021-06-30 | 2021-06-30 | 07:58:00/08:08:00 | 07:58:00   |
| ANH_250_A_P2_R2_T1 | 2021-06-30 | 2021-06-30 | 07:58:00/08:08:00 | 07:58:00   |
| ANH_250_A_P2_R2_T1 | 2021-06-30 | 2021-06-30 | 07:58:00/08:08:00 | 07:58:00   |
| ANH_250_A_P2_R2_T1 | 2021-06-30 | 2021-06-30 | 07:58:00/08:08:00 | 07:58:00   |
| ANH_250_A_P2_R2_T1 | 2021-06-30 | 2021-06-30 | 07:58:00/08:08:00 | 07:58:00   |
| ANH_250_A_P2_R2_T1 | 2021-06-30 | 2021-06-30 | 07:58:00/08:08:00 | 07:58:00   |
| ANH_250_A_P2_R2_T1 | 2021-06-30 | 2021-06-30 | 07:58:00/08:08:00 | 07:58:00   |
| ANH_250_A_P3_R2_T1 | 2021-06-30 | 2021-06-30 | 08:02:00/08:12:00 | 08:02:00   |
| ANH_250_A_P3_R2_T1 | 2021-06-30 | 2021-06-30 | 08:02:00/08:12:00 | 08:02:00   |
| ANH_250_A_P3_R2_T1 | 2021-06-30 | 2021-06-30 | 08:02:00/08:12:00 | 08:02:00   |
| ANH_250_A_P3_R2_T1 | 2021-06-30 | 2021-06-30 | 08:02:00/08:12:00 | 08:02:00   |
| ANH_250_A_P3_R2_T1 | 2021-06-30 | 2021-06-30 | 08:02:00/08:12:00 | 08:02:00   |
| ANH_250_A_P3_R2_T1 | 2021-06-30 | 2021-06-30 | 08:02:00/08:12:00 | 08:02:00   |
| ANH_250_A_P3_R2_T1 | 2021-06-30 | 2021-06-30 | 08:02:00/08:12:00 | 08:02:00   |
| ANH_250_A_P3_R2_T1 | 2021-06-30 | 2021-06-30 | 08:02:00/08:12:00 | 08:02:00   |
| ANH_250_A_P1_R2_T1 | 2021-06-30 | 2021-06-30 | 08:03:00/08:13:00 | 08:03:00   |
| ANH_250_A_P1_R2_T1 | 2021-06-30 | 2021-06-30 | 08:03:00/08:13:00 | 08:03:00   |
| ANH_250_A_P1_R2_T1 | 2021-06-30 | 2021-06-30 | 08:03:00/08:13:00 | 08:03:00   |
| ANH_250_A_P1_R2_T1 | 2021-06-30 | 2021-06-30 | 08:03:00/08:13:00 | 08:03:00   |
| ANH_250_A_P1_R2_T1 | 2021-06-30 | 2021-06-30 | 08:03:00/08:13:00 | 08:03:00   |
| ANH_250_A_P1_R2_T1 | 2021-06-30 | 2021-06-30 | 08:03:00/08:13:00 | 08:03:00   |
| ANH_250_A_P1_R2_T1 | 2021-06-30 | 2021-06-30 | 08:03:00/08:13:00 | 08:03:00   |
| ANH_250_A_P3_R3_T1 | 2021-06-30 | 2021-06-30 | 08:14:00/08:24:00 | 08:14:00   |
| ANH_250_A_P3_R3_T1 | 2021-06-30 | 2021-06-30 | 08:14:00/08:24:00 | 08:14:00   |
| ANH_250_A_P3_R3_T1 | 2021-06-30 | 2021-06-30 | 08:14:00/08:24:00 | 08:14:00   |
| ANH_250_A_P3_R3_T1 | 2021-06-30 | 2021-06-30 | 08:14:00/08:24:00 | 08:14:00   |
| ANH_250_A_P3_R3_T1 | 2021-06-30 | 2021-06-30 | 08:14:00/08:24:00 | 08:14:00   |
| ANH_250_A_P3_R3_T1 | 2021-06-30 | 2021-06-30 | 08:14:00/08:24:00 | 08:14:00   |
| ANH_250_A_P3_R3_T1 | 2021-06-30 | 2021-06-30 | 08:14:00/08:24:00 | 08:14:00   |
| ANH_250_A_P3_R3_T1 | 2021-06-30 | 2021-06-30 | 08:14:00/08:24:00 | 08:14:00   |
| ANH_250_A_P3_R3_T1 | 2021-06-30 | 2021-06-30 | 08:14:00/08:24:00 | 08:14:00   |
| ANH_250_A_P3_R3_T1 | 2021-06-30 | 2021-06-30 | 08:14:00/08:24:00 | 08:14:00   |
| ANH_250_A_P3_R3_T1 | 2021-06-30 | 2021-06-30 | 08:14:00/08:24:00 | 08:14:00   |

Displaying records 1 - 100

</div>

``` sql
INSERT INTO main.registros(cd_event, cds_recorded_by, date_time, cd_tax, cd_morfo, date_ident, cds_identified_by, qt_int,remarks, occurrence_id, organism_id)
SELECT 
 cd_event,
 cds_recorded_by,
 CASE 
   WHEN event_date IS NULL OR event_time IS NULL THEN NULL
   ELSE (event_date||' '||event_time)::timestamp 
 END date_time,
 tt.cd_tax,
 tt.cd_morfo,
 TO_DATE(date_identified,'YYYY-MM-DD') date_ident,
 cds_identified_by,
 organism_quantity::double precision::int qt_int,
 r.event_remarks,
 r.occurrence_id,
 --SPLIT_PART(occurrence_id,':',7) organism_id
 --ROW_NUMBER() OVER (ORDER BY (e.date_time_begin::date||' '||event_time)::timestamp)
 organism_id::text
 --ST_SetSRID(ST_Transform(ST_SetSRID(ST_MakePoint(measurement_value__longitud_,measurement_value__latitud_), 4326),  (SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)),3116)
FROM raw_dwc.aves_registros r
LEFT JOIN raw_dwc.taxonomy_total tt ON tt."row.names"=r."row.names" AND tt.table_orig='aves_registros'
LEFT JOIN main.event e USING (cd_event)
ORDER BY date_time
RETURNING cd_event, cds_recorded_by, date_time, cd_tax, cd_morfo, cds_identified_by, qt_int,remarks, occurrence_id, organism_id
```

``` sql
ALTER TABLE raw_dwc.aves_registros ADD COLUMN cd_reg int REFERENCES main.registros(cd_reg);
UPDATE raw_dwc.aves_registros AS ar
SET cd_reg=r.cd_reg
FROM main.registros r
WHERE ar.cd_event=r.cd_event AND ar.occurrence_id=r.occurrence_id;

-- Check cd_reg are unique in the source table
SELECT cd_reg,count(*) FROM  raw_dwc.aves_registros GROUP BY cd_reg HAVING count(*)>1;
```

<div class="knitsql-table">

    cd_reg   count

------------------------------------------------------------------------

: 0 records

</div>

### 8.6.1 Añadir la información temporal supplementaria

``` sql
INSERT INTO main.def_var_registros_extra(var_registros_extra, type_var, var_registros_extra_spa, var_registros_extra_comment)
VALUES
  ('date_registro',
  'free text',
  'fecha_registro',
  'En algunos casos (p.ej aves), solo la fecha (sin tiempo) es dada para los registros. En este case el date_time es NULL, y devemos dar la fecha como variable extra (texto) el formato es YYYY-MM-DD HH:MI:SS'
  );

INSERT INTO main.registros_extra(cd_reg,cd_var_registros_extra,value_text)
SELECT cd_reg,
(SELECT cd_var_registros_extra FROM main.def_var_registros_extra WHERE var_registros_extra='date_registro'),
event_date::timestamp::text
FROM raw_dwc.aves_registros
WHERE event_time IS NULL OR event_time='';
```

# 9 Mamiferos

## 9.1 Crear la tabla total de eventos

Antes de poder tratar de manera eficiente los datos de mamiferos,
necesitamos ver si es posible asociar los datos de ultrasonidos con los
datos clasicos de mamiferos

``` sql
WITH a AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='mamiferos_event'
),b AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='mamiferos_us_event'
)
SELECT column_name, ARRAY[a.table_name,b.table_name], ARRAY[a.data_type,b.data_type]
FROM a
FULL OUTER JOIN b USING (column_name)
ORDER BY COALESCE(a.ordinal_position,b.ordinal_position);
```

<div class="knitsql-table">

| column_name                                           | array                                | array                                   |
|:------------------------------------------------------|:-------------------------------------|:----------------------------------------|
| row.names                                             | {mamiferos_event,mamiferos_us_event} | {text,text}                             |
| event_id                                              | {NULL,mamiferos_us_event}            | {NULL,text}                             |
| occurrence_id                                         | {mamiferos_event,NULL}               | {text,NULL}                             |
| parent_event_id                                       | {NULL,mamiferos_us_event}            | {NULL,text}                             |
| basis_of_record                                       | {mamiferos_event,NULL}               | {text,NULL}                             |
| sampling_size_value                                   | {mamiferos_event,NULL}               | {text,NULL}                             |
| sample_size_value                                     | {NULL,mamiferos_us_event}            | {NULL,“double precision”}               |
| sampling_size_unit                                    | {mamiferos_event,NULL}               | {text,NULL}                             |
| sample_size_unit                                      | {NULL,mamiferos_us_event}            | {NULL,text}                             |
| sampling_protocol                                     | {mamiferos_event,mamiferos_us_event} | {text,text}                             |
| sampling_effort                                       | {mamiferos_event,mamiferos_us_event} | {text,text}                             |
| event_date                                            | {mamiferos_event,mamiferos_us_event} | {text,text}                             |
| event_time                                            | {mamiferos_event,mamiferos_us_event} | {text,text}                             |
| habitat                                               | {mamiferos_event,mamiferos_us_event} | {text,text}                             |
| event_remarks                                         | {mamiferos_event,mamiferos_us_event} | {text,text}                             |
| continent                                             | {mamiferos_event,mamiferos_us_event} | {text,text}                             |
| country                                               | {mamiferos_event,mamiferos_us_event} | {text,text}                             |
| country_code                                          | {mamiferos_event,mamiferos_us_event} | {text,text}                             |
| state_province                                        | {mamiferos_event,mamiferos_us_event} | {text,text}                             |
| county                                                | {mamiferos_event,mamiferos_us_event} | {text,text}                             |
| locality                                              | {mamiferos_event,mamiferos_us_event} | {text,text}                             |
| minimum_elevation_in_meters                           | {mamiferos_event,mamiferos_us_event} | {“double precision”,“double precision”} |
| maximum_elevation_in_meters                           | {mamiferos_event,mamiferos_us_event} | {“double precision”,“double precision”} |
| verbatim_latitude                                     | {mamiferos_event,mamiferos_us_event} | {text,text}                             |
| verbatim_longitude                                    | {mamiferos_event,mamiferos_us_event} | {text,text}                             |
| verbatim_coordinate_system                            | {mamiferos_event,mamiferos_us_event} | {text,text}                             |
| verbatim_srs                                          | {mamiferos_event,mamiferos_us_event} | {text,text}                             |
| decimal_latitude                                      | {mamiferos_event,mamiferos_us_event} | {“double precision”,“double precision”} |
| decimal_longitude                                     | {mamiferos_event,mamiferos_us_event} | {“double precision”,“double precision”} |
| geodetic_datum                                        | {mamiferos_event,mamiferos_us_event} | {text,text}                             |
| coordinate_uncertainty_in_meters                      | {mamiferos_event,mamiferos_us_event} | {“double precision”,“double precision”} |
| identified_by                                         | {mamiferos_event,NULL}               | {text,NULL}                             |
| title                                                 | {NULL,mamiferos_us_event}            | {NULL,text}                             |
| measurement_type\_*plataforma*                        | {mamiferos_event,mamiferos_us_event} | {text,text}                             |
| type                                                  | {NULL,mamiferos_us_event}            | {NULL,text}                             |
| format                                                | {NULL,mamiferos_us_event}            | {NULL,text}                             |
| measurement_value\_*plataforma*                       | {mamiferos_event,mamiferos_us_event} | {text,text}                             |
| measurement_type\_*distancia*                         | {mamiferos_event,mamiferos_us_event} | {text,text}                             |
| creator                                               | {NULL,mamiferos_us_event}            | {NULL,text}                             |
| created                                               | {NULL,mamiferos_us_event}            | {NULL,text}                             |
| measurement_value\_*distancia*                        | {mamiferos_event,mamiferos_us_event} | {“double precision”,“double precision”} |
| measurement_unit\_*distancia*                         | {mamiferos_event,mamiferos_us_event} | {text,text}                             |
| measurement_type\_*tipo_de_palma*                     | {mamiferos_event,NULL}               | {text,NULL}                             |
| measurement_value\_*tipo_de_palma*                    | {mamiferos_event,NULL}               | {text,NULL}                             |
| measurement_type\_*edad*                              | {mamiferos_event,NULL}               | {text,NULL}                             |
| measurement_value\_*edad*                             | {mamiferos_event,NULL}               | {text,NULL}                             |
| measurement_type\_*altura_promedio_de_la_vegetación*  | {mamiferos_event,NULL}               | {text,NULL}                             |
| measurement_type\_*grupo*                             | {NULL,mamiferos_us_event}            | {NULL,text}                             |
| measurement_value\_*grupo*                            | {NULL,mamiferos_us_event}            | {NULL,text}                             |
| measurement_value\_*altura_promedio_de_la_vegetación* | {mamiferos_event,NULL}               | {text,NULL}                             |
| measurement_unit\_*altura_promedio_de_la_vegetación*  | {mamiferos_event,NULL}               | {text,NULL}                             |
| measurement_type\_*cobertura_del_dosel_índice_ca_co*  | {mamiferos_event,NULL}               | {text,NULL}                             |
| measurement_value\_*cobertura_del_dosel_índice_ca_co* | {mamiferos_event,NULL}               | {“double precision”,NULL}               |
| measurement_unit\_*cobertura_del_dosel_índice_ca_co*  | {mamiferos_event,NULL}               | {text,NULL}                             |

54 records

</div>

Associar las tablas de eventos (Anotar: yo no utilizo un VIEW acá,
porque voy a necesitar añadir column más tarde):

*note: ver archivo \<./meta_prog_asociacion_table.sql\> para entender
como crear el comando siguiente*

``` sql
CREATE TABLE raw_dwc.mamiferos_tot_event AS(
SELECT 
 'mamiferos_event' AS table_orig,
 "row.names",
 "occurrence_id" AS event_id,
 NULL::text AS "parent_event_id",
 "basis_of_record",
 "sampling_size_value"::text AS sample_size_value,
 "sampling_size_unit" AS "sample_size_unit",
 "sampling_protocol",
 "sampling_effort",
 "event_date",
 "event_time",
 "habitat",
 "event_remarks",
 "continent",
 "country",
 "country_code",
 "state_province",
 "county",
 "locality",
 "minimum_elevation_in_meters",
 "maximum_elevation_in_meters",
 "verbatim_latitude",
 "verbatim_longitude",
 "verbatim_coordinate_system",
 "verbatim_srs",
 "decimal_latitude",
 "decimal_longitude",
 "geodetic_datum",
 "coordinate_uncertainty_in_meters",
 "identified_by",
 NULL::text AS "title",
 "measurement_type__plataforma_",
 NULL::text AS "type",
 NULL::text AS "format",
 "measurement_value__plataforma_",
 "measurement_type__distancia_",
 NULL::text AS "creator",
 NULL::text AS "created",
 "measurement_value__distancia_",
 "measurement_unit__distancia_",
 "measurement_type__tipo_de_palma_",
 "measurement_value__tipo_de_palma_",
 "measurement_type__edad_",
 "measurement_value__edad_",
 "measurement_type__altura_promedio_de_la_vegetación_",
 NULL::text AS "measurement_type__grupo_",
 NULL::text AS "measurement_value__grupo_",
 "measurement_value__altura_promedio_de_la_vegetación_",
 "measurement_unit__altura_promedio_de_la_vegetación_",
 "measurement_type__cobertura_del_dosel_índice_ca_co_",
 "measurement_value__cobertura_del_dosel_índice_ca_co_",
 "measurement_unit__cobertura_del_dosel_índice_ca_co_"
FROM raw_dwc.mamiferos_event
UNION ALL
SELECT 
  'mamiferos_us_event' AS table_orig,
   "row.names",
 "event_id",
 "parent_event_id",
 NULL::text AS "basis_of_record",
 "sample_size_value"::text,
 "sample_size_unit",
 "sampling_protocol",
 "sampling_effort",
 "event_date",
 "event_time",
 "habitat",
 "event_remarks",
 "continent",
 "country",
 "country_code",
 "state_province",
 "county",
 "locality",
 "minimum_elevation_in_meters",
 "maximum_elevation_in_meters",
 "verbatim_latitude",
 "verbatim_longitude",
 "verbatim_coordinate_system",
 "verbatim_srs",
 "decimal_latitude",
 "decimal_longitude",
 "geodetic_datum",
 "coordinate_uncertainty_in_meters",
 NULL::text AS "identified_by",
 "title",
 "measurement_type__plataforma_",
 "type",
 "format",
 "measurement_value__plataforma_",
 "measurement_type__distancia_",
 "creator",
 "created",
 "measurement_value__distancia_",
 "measurement_unit__distancia_",
 NULL::text AS "measurement_type__tipo_de_palma_",
 NULL::text AS "measurement_value__tipo_de_palma_",
 NULL::text AS "measurement_type__edad_",
 NULL::text AS "measurement_value__edad_",
 NULL::text AS "measurement_type__altura_promedio_de_la_vegetación_",
 "measurement_type__grupo_",
 "measurement_value__grupo_",
 NULL::text AS "measurement_value__altura_promedio_de_la_vegetación_",
 NULL::text AS "measurement_unit__altura_promedio_de_la_vegetación_",
 NULL::text AS "measurement_type__cobertura_del_dosel_índice_ca_co_",
 NULL::double precision AS "measurement_value__cobertura_del_dosel_índice_ca_co_",
 NULL::text AS "measurement_unit__cobertura_del_dosel_índice_ca_co_"
FROM raw_dwc.mamiferos_us_event
);

SELECT event_id,count(*)
FROM raw_dwc.mamiferos_tot_event
GROUP BY event_id
HAVING count(*)>1;
```

Podemos ver que, a pesar de esta asociación, los event_id son unicos en
la tabla total.

## 9.2 Crear la tabla total de registros

``` sql
WITH a AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='mamiferos_registros'
),b AS(
SELECT table_name, column_name, ordinal_position, data_type
FROM information_schema.columns
WHERE table_name='mamiferos_us_registros'
)
SELECT column_name, ARRAY[a.table_name,b.table_name], ARRAY[a.data_type,b.data_type]
FROM a
FULL OUTER JOIN b USING (column_name)
ORDER BY COALESCE(a.ordinal_position,b.ordinal_position);
```

<div class="knitsql-table">

| column_name                           | array                                        | array                     |
|:--------------------------------------|:---------------------------------------------|:--------------------------|
| row.names                             | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| occurrence_id                         | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| event_id                              | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| basis_of_record                       | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| type                                  | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| institution_code                      | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| collection_code                       | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| catalog_number                        | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| other_catalog_numbers                 | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| dynamic_properties                    | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| occurrence_remarks                    | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| record_number                         | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| recorded_by                           | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| organism_id                           | {mamiferos_registros,NULL}                   | {text,NULL}               |
| organism_quantity                     | {mamiferos_registros,NULL}                   | {text,NULL}               |
| organism_quantity_1                   | {mamiferos_registros,NULL}                   | {text,NULL}               |
| sex                                   | {mamiferos_registros,NULL}                   | {text,NULL}               |
| life_stage                            | {mamiferos_registros,NULL}                   | {text,NULL}               |
| reproductive_condition                | {mamiferos_registros,NULL}                   | {text,NULL}               |
| preparations                          | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| sampling_protocol                     | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| sampling_effort                       | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| event_date                            | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| event_time                            | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| event_remarks                         | {mamiferos_registros,NULL}                   | {text,NULL}               |
| scientific_name                       | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| identification_qualifier              | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| kingdom                               | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| phylum                                | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| class                                 | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| order                                 | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| family                                | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| genus                                 | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| specific_epithet                      | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| taxon_rank                            | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| identified_by                         | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| measurement_type\_*temperatura*       | {NULL,mamiferos_us_registros}                | {NULL,text}               |
| date_identified                       | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| measurement_value\_*temperatura*      | {NULL,mamiferos_us_registros}                | {NULL,text}               |
| scientific_name_authorship            | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| measurement_unit\_*temperatura*       | {NULL,mamiferos_us_registros}                | {NULL,text}               |
| tipo_de_tejido                        | {mamiferos_registros,NULL}                   | {text,NULL}               |
| measurement_type\_*presión_sonora_n*  | {NULL,mamiferos_us_registros}                | {NULL,text}               |
| preparación_del_tejido                | {mamiferos_registros,NULL}                   | {text,NULL}               |
| colector_del_tejido                   | {mamiferos_registros,NULL}                   | {text,NULL}               |
| measurement_value\_*presión_sonora_n* | {NULL,mamiferos_us_registros}                | {NULL,text}               |
| código_del_tejido                     | {mamiferos_registros,NULL}                   | {text,NULL}               |
| measurement_unit\_*presión_sonora_n*  | {NULL,mamiferos_us_registros}                | {NULL,text}               |
| measurement_type\_*presión_sonora_s*  | {NULL,mamiferos_us_registros}                | {NULL,text}               |
| title                                 | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| type_1                                | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| measurement_value\_*presión_sonora_s* | {NULL,mamiferos_us_registros}                | {NULL,text}               |
| format                                | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| measurement_unit\_*presión_sonora_s*  | {NULL,mamiferos_us_registros}                | {NULL,text}               |
| creator                               | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| measurement_type\_*presión_sonora_e*  | {NULL,mamiferos_us_registros}                | {NULL,text}               |
| measurement_value\_*presión_sonora_e* | {NULL,mamiferos_us_registros}                | {NULL,text}               |
| created                               | {mamiferos_registros,mamiferos_us_registros} | {text,text}               |
| measurement_type\_*peso*              | {mamiferos_registros,NULL}                   | {text,NULL}               |
| measurement_unit\_*presión_sonora_e*  | {NULL,mamiferos_us_registros}                | {NULL,text}               |
| measurement_value\_*peso*             | {mamiferos_registros,NULL}                   | {text,NULL}               |
| measurement_type\_*presión_sonora_w*  | {NULL,mamiferos_us_registros}                | {NULL,text}               |
| measurement_value\_*presión_sonora_w* | {NULL,mamiferos_us_registros}                | {NULL,text}               |
| measurement_unit\_*peso*              | {mamiferos_registros,NULL}                   | {text,NULL}               |
| measurement_type\_*longitud_total*    | {mamiferos_registros,NULL}                   | {text,NULL}               |
| measurement_unit\_*presión_sonora_w*  | {NULL,mamiferos_us_registros}                | {NULL,text}               |
| measurement_value\_*longitud_total*   | {mamiferos_registros,NULL}                   | {text,NULL}               |
| measurement_unit\_*longitud_total*    | {mamiferos_registros,NULL}                   | {text,NULL}               |
| measurement_type\_*longitud_cola*     | {mamiferos_registros,NULL}                   | {text,NULL}               |
| measurement_value\_*longitud_cola*    | {mamiferos_registros,NULL}                   | {text,NULL}               |
| measurement_unit\_*longitud_cola*     | {mamiferos_registros,NULL}                   | {text,NULL}               |
| measurement_type\_*longitud_oreja*    | {mamiferos_registros,NULL}                   | {text,NULL}               |
| measurement_value\_*longitud_oreja*   | {mamiferos_registros,NULL}                   | {“double precision”,NULL} |
| measurement_unit\_*longitud_oreja*    | {mamiferos_registros,NULL}                   | {text,NULL}               |
| measurement_type\_*longitud_pata*     | {mamiferos_registros,NULL}                   | {text,NULL}               |
| measurement_value\_*longitud_pata*    | {mamiferos_registros,NULL}                   | {“double precision”,NULL} |
| measurement_unit\_*longitud_pata*     | {mamiferos_registros,NULL}                   | {text,NULL}               |
| measurement_type\_*antebrazo*         | {mamiferos_registros,NULL}                   | {text,NULL}               |
| measurement_value\_*antebrazo*        | {mamiferos_registros,NULL}                   | {text,NULL}               |
| measurement_unit\_*antebrazo*         | {mamiferos_registros,NULL}                   | {text,NULL}               |
| measurement_type\_*envergadura*       | {mamiferos_registros,NULL}                   | {text,NULL}               |
| measurement_value\_*envergadura*      | {mamiferos_registros,NULL}                   | {text,NULL}               |
| measurement_unit\_*envergadura*       | {mamiferos_registros,NULL}                   | {text,NULL}               |

83 records

</div>

``` sql
CREATE TABLE raw_dwc.mamiferos_tot_registros AS(
SELECT 
 'mamiferos_registros' AS table_orig,
 "row.names",
 "occurrence_id",
 "event_id",
 "basis_of_record",
 "type",
 "institution_code",
 "collection_code",
 "catalog_number",
 "other_catalog_numbers",
 "dynamic_properties",
 "occurrence_remarks",
 "record_number",
 "recorded_by",
 "organism_id",
 "organism_quantity",
 organism_quantity_1 "organism_quantity_type",
 "sex",
 "life_stage",
 "reproductive_condition",
 "preparations",
 "sampling_protocol",
 "sampling_effort",
 "event_date",
 "event_time",
 "event_remarks",
 "scientific_name",
 "identification_qualifier",
 "kingdom",
 "phylum",
 "class",
 "order",
 "family",
 "genus",
 "specific_epithet",
 "taxon_rank",
 "identified_by",
 "date_identified",
 NULL::text AS "measurement_type__temperatura_",
 NULL::text AS "measurement_value__temperatura_",
 "scientific_name_authorship",
 "tipo_de_tejido",
 NULL::text AS "measurement_unit__temperatura_",
 "preparación_del_tejido",
 NULL::text AS "measurement_type__presión_sonora_n_",
 NULL::text AS "measurement_value__presión_sonora_n_",
 "colector_del_tejido",
 "código_del_tejido",
 NULL::text AS "measurement_unit__presión_sonora_n_",
 NULL::text AS "measurement_type__presión_sonora_s_",
 "title",
 "type_1",
 NULL::text AS "measurement_value__presión_sonora_s_",
 "format",
 NULL::text AS "measurement_unit__presión_sonora_s_",
 "creator",
 NULL::text AS "measurement_type__presión_sonora_e_",
 NULL::text AS "measurement_value__presión_sonora_e_",
 "created",
 "measurement_type__peso_",
 NULL::text AS "measurement_unit__presión_sonora_e_",
 NULL::text AS "measurement_type__presión_sonora_w_",
 "measurement_value__peso_",
 NULL::text AS "measurement_value__presión_sonora_w_",
 "measurement_unit__peso_",
 NULL::text AS "measurement_unit__presión_sonora_w_",
 "measurement_type__longitud_total_",
 "measurement_value__longitud_total_",
 "measurement_unit__longitud_total_",
 "measurement_type__longitud_cola_",
 "measurement_value__longitud_cola_",
 "measurement_unit__longitud_cola_",
 "measurement_type__longitud_oreja_",
 "measurement_value__longitud_oreja_",
 "measurement_unit__longitud_oreja_",
 "measurement_type__longitud_pata_",
 "measurement_value__longitud_pata_",
 "measurement_unit__longitud_pata_",
 "measurement_type__antebrazo_",
 "measurement_value__antebrazo_",
 "measurement_unit__antebrazo_",
 "measurement_type__envergadura_",
 "measurement_value__envergadura_",
 "measurement_unit__envergadura_"
FROM raw_dwc.mamiferos_registros
UNION ALL
SELECT 
 'mamiferos_us_registros' AS table_orig,
  "row.names",
 "occurrence_id",
 "event_id",
 "basis_of_record",
 "type",
 "institution_code",
 "collection_code",
 "catalog_number",
 "other_catalog_numbers",
 "dynamic_properties",
 "occurrence_remarks",
 "record_number",
 "recorded_by",
 NULL::text AS "organism_id",
 NULL::text AS "organism_quantity",
 NULL::text AS "organism_quantity_type",
 NULL::text AS "sex",
 NULL::text AS "life_stage",
 NULL::text AS "reproductive_condition",
 "preparations",
 "sampling_protocol",
 "sampling_effort",
 "event_date",
 "event_time",
 NULL::text AS "event_remarks",
 "scientific_name",
 "identification_qualifier",
 "kingdom",
 "phylum",
 "class",
 "order",
 "family",
 "genus",
 "specific_epithet",
 "taxon_rank",
 "identified_by",
 "date_identified",
 "measurement_type__temperatura_",
 "measurement_value__temperatura_",
 "scientific_name_authorship",
 NULL::text AS "tipo_de_tejido",
 "measurement_unit__temperatura_",
 NULL::text AS "preparación_del_tejido",
 "measurement_type__presión_sonora_n_",
 "measurement_value__presión_sonora_n_",
 NULL::text AS "colector_del_tejido",
 NULL::text AS "código_del_tejido",
 "measurement_unit__presión_sonora_n_",
 "measurement_type__presión_sonora_s_",
 "title",
 "type_1",
 "measurement_value__presión_sonora_s_",
 "format",
 "measurement_unit__presión_sonora_s_",
 "creator",
 "measurement_type__presión_sonora_e_",
 "measurement_value__presión_sonora_e_",
 "created",
 NULL::text AS "measurement_type__peso_",
 "measurement_unit__presión_sonora_e_",
 "measurement_type__presión_sonora_w_",
 NULL::text AS "measurement_value__peso_",
 "measurement_value__presión_sonora_w_",
 NULL::text AS "measurement_unit__peso_",
 "measurement_unit__presión_sonora_w_",
 NULL::text AS "measurement_type__longitud_total_",
 NULL::text AS "measurement_value__longitud_total_",
 NULL::text AS "measurement_unit__longitud_total_",
 NULL::text AS "measurement_type__longitud_cola_",
 NULL::text AS "measurement_value__longitud_cola_",
 NULL::text AS "measurement_unit__longitud_cola_",
 NULL::text AS "measurement_type__longitud_oreja_",
 NULL::double precision AS "measurement_value__longitud_oreja_",
 NULL::text AS "measurement_unit__longitud_oreja_",
 NULL::text AS "measurement_type__longitud_pata_",
 NULL::double precision AS "measurement_value__longitud_pata_",
 NULL::text AS "measurement_unit__longitud_pata_",
 NULL::text AS "measurement_type__antebrazo_",
 NULL::text AS "measurement_value__antebrazo_",
 NULL::text AS "measurement_unit__antebrazo_",
 NULL::text AS "measurement_type__envergadura_",
 NULL::text AS "measurement_value__envergadura_",
 NULL::text AS "measurement_unit__envergadura_"
FROM raw_dwc.mamiferos_us_registros
);
SELECT occurrence_id,count(*)
FROM raw_dwc.mamiferos_tot_registros
GROUP BY occurrence_id
HAVING count(*)>1;
```

Podemos ver que, a pesar de esta asociación, los occurrence_id son
unicos en la tabla total.

## 9.3 Entender el plan de muestreo

**Que hacemos con el event sin punto de referencia (ANH_M_CM_4_T2)?**

**Existen 3 eventos de pitfall en los mamiferos, pero la información
sobre esos eventos es minima, no entiendo si vienen de pitfall de otros
grupos (en aquellos casos se anota ‘accidental’ en la base de datos. Si
se tratan de trampa pitfall especificas entonces se debe añadir el
protocolo especifico en la base de datos.**

**No hay Sherman en 2022, averiguar que está bien**

**Averiguar que entendí bien lo que son los metodos menos
representado**:

- Captura manual son eventos puntuales que puedo categorizar como
  accidental en el sentido que no hacen parte de un plan de muestreo a
  larga escala
- Pitfall vienen de planes de muestreo de otros grupos
- Busqueda por encuentros visuales vienen de herpetos
- Existen accidentales que vienen de las redes de niebla de los aves
  (‘Redes de niebla’ en lugar de ‘Red niebla’
- Un evento ‘Encuentro’ corresponde a un encuentro accidental
- Parece que hay grabaciones que no son de ultrasonidos, pero se
  describe en las variables extra de las grabaciones
- No separo las grabaciones en varios metodos (tal vez se justifica?
  automatico o no? us o no, etc.)

``` sql
SELECT table_orig,event_id,sampling_protocol
FROM raw_dwc.mamiferos_tot_event
WHERE event_id!~'^ANH_[0-9]{1,3}_M_[RS][0-9]{1,3}(_T2)?$' AND event_id !~ '^ANH_[0-9]{1,3}_[0-9]{1,2}(_T2)?'
```

<div class="knitsql-table">

| table_orig         | event_id          | sampling_protocol                        |
|:-------------------|:------------------|:-----------------------------------------|
| mamiferos_event    | ANH_223_Herp_T2_N | Búsqueda por encuentros visuales (VES)   |
| mamiferos_event    | ANH_153_Herp_T1_D | Búsqueda por encuentros visuales (VES)   |
| mamiferos_event    | ANH_185_Herp_T3_N | Búsqueda por encuentros visuales (VES)   |
| mamiferos_event    | ANH_360           | Encuentro                                |
| mamiferos_event    | ANH_240_A_R       | Redes de Niebla                          |
| mamiferos_event    | ANH_166_M_CM_1_T2 | Captura manual                           |
| mamiferos_event    | ANH_130_M_P_1_T2  | Trampa pitfall                           |
| mamiferos_event    | ANH_130_M_P_2_T2  | Trampa pitfall                           |
| mamiferos_event    | ANH_149_M_CM_2_T2 | Captura manual                           |
| mamiferos_event    | ANH_368_M_P_3_T2  | Trampa pitfall                           |
| mamiferos_event    | ANH_M_CM_4_T2     | Captura manual                           |
| mamiferos_event    | ANH_374_M_CM_3_T2 | Captura manual                           |
| mamiferos_us_event | Hotel_1AA         | Punto grabación automatica (ultrasonido) |
| mamiferos_us_event | Hotel_1_T2        | Punto de grabación (ultrasonido)         |
| mamiferos_us_event | Hotel_2_T2        | Punto grabación automatica               |

15 records

</div>

``` sql
WITH a AS(
SELECT event_id,sampling_protocol,
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_.*' THEN REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_.*','\1')
   WHEN event_id ~ '^ANH_[0-9]{1,3}$' THEN event_id
   WHEN event_id ~ '[Hh]otel' THEN 'Hotel'
 END anh_name,
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_.*' THEN REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_.*','\1')::int
   WHEN event_id ~ '^ANH_[0-9]{1,3}$' THEN REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})$','\1')::int
   ELSE NULL
 END anh_num,
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_M_[RS][0-9]{1,3}(_T2)?$' AND sampling_protocol='Red niebla' THEN 'niebla'
   WHEN event_id ~ '^ANH_[0-9]{1,3}_M_[RS][0-9]{1,3}(_T2)?$' AND sampling_protocol='Trampa Sherman' THEN 'sherman'
   WHEN sampling_protocol ~ '^Punto( de)? grabación' THEN 'grabación'
   WHEN event_id ~ 'Herp' OR event_id ~ '^ANH_[0-9]{1,3}_A_' THEN 'accidental (otro grupo)'
   WHEN sampling_protocol='Captura manual' THEN 'accidental' 
   WHEN sampling_protocol~'^Encuentro ?$' THEN 'accidental' 
   WHEN sampling_protocol='Trampa pitfall' THEN 'accidental (pitfall)'
 END metodo,
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_M_[RS]([0-9]{1,3})(_T2)?$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_M_[RS]([0-9]{1,3})(_T2)?$','\1')::int
   WHEN sampling_protocol ~ '^Punto( de)? grabación' AND event_id ~ '^ANH_[0-9]{1,3}_([0-9]{1,2})(_T2)?' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_([0-9]{1,2})(_T2)?','\1')::int
   WHEN event_id ~ '^Hotel_[0-9]' THEN REGEXP_REPLACE(event_id,'^Hotel_([0-9]).*','\1')::int
   WHEN event_id ~ 'ANH_[0-9]{1,3}_M_P_[0-9](_T2)?' THEN REGEXP_REPLACE(event_id, 'ANH_[0-9]{1,3}_M_P_([0-9])(_T2)?$', '\1')::int
   WHEN event_id ~ 'ANH_([0-9]{1,3}_)?M_CM_[0-9]_T2' THEN REGEXP_REPLACE(event_id, 'ANH_([0-9]{1,3}_)?M_CM_([0-9])(_T2)?$', '\2')::int
   ELSE NULL
 END repli,
 CASE
   WHEN event_id ~ 'T2$' THEN 'T2'
   ELSE 'T1'
 END tempo,
 EXTRACT(YEAR FROM (SPLIT_PART(event_date,'/',1)::date)) año
FROM raw_dwc.mamiferos_tot_event
)
SELECT  tempo, metodo,año,count(*)-- ARRAY_AGG(event_id)
FROM a
--WHERE NOT((tempo='T1' AND año=2021) OR (tempo='t2' AND año=2022))
GROUP BY tempo,año,metodo
ORDER BY tempo,metodo
;
```

<div class="knitsql-table">

| tempo | metodo                  |  año | count |
|:------|:------------------------|-----:|------:|
| T1    | accidental              | 2021 |     1 |
| T1    | accidental (otro grupo) | 2021 |     4 |
| T1    | grabación               | 2021 |    83 |
| T1    | niebla                  | 2021 |   400 |
| T1    | sherman                 | 2021 |  1120 |
| T2    | accidental              | 2022 |     4 |
| T2    | accidental (pitfall)    | 2022 |     3 |
| T2    | grabación               | 2022 |    48 |
| T2    | niebla                  | 2022 |   400 |

9 records

</div>

``` sql
WITH a AS(
SELECT event_id,
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_.*' THEN REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_.*','\1')
   WHEN event_id ~ '^ANH_[0-9]{1,3}$' THEN event_id
   WHEN event_id ~ '[Hh]otel' THEN 'Hotel'
 END anh_name,
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_.*' THEN REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_.*','\1')::int
   WHEN event_id ~ '^ANH_[0-9]{1,3}$' THEN REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})$','\1')::int
   ELSE NULL
 END anh_num,
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_M_[RS][0-9]{1,3}(_T2)?$' AND sampling_protocol='Red niebla' THEN 'niebla'
   WHEN event_id ~ '^ANH_[0-9]{1,3}_M_[RS][0-9]{1,3}(_T2)?$' AND sampling_protocol='Trampa Sherman' THEN 'sherman'
   WHEN sampling_protocol ~ '^Punto( de)? grabación' THEN 'grabación'
   WHEN event_id ~ 'Herp' OR event_id ~ '^ANH_[0-9]{1,3}_A_' THEN 'accidental (otro grupo)'
   WHEN sampling_protocol='Captura manual' THEN 'accidental' 
   WHEN sampling_protocol~'^Encuentro ?$' THEN 'accidental' 
   WHEN sampling_protocol='Trampa pitfall' THEN 'accidental (pitfall)'
 END metodo,
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_M_[RS]([0-9]{1,3})(_T2)?$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_M_[RS]([0-9]{1,3})(_T2)?$','\1')::int
   WHEN sampling_protocol ~ '^Punto( de)? grabación' AND event_id ~ '^ANH_[0-9]{1,3}_([0-9]{1,2})(_T2)?' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_([0-9]{1,2})(_T2)?','\1')::int
   WHEN event_id ~ '^Hotel_[0-9]' THEN REGEXP_REPLACE(event_id,'^Hotel_([0-9]).*','\1')::int
   WHEN event_id ~ 'ANH_[0-9]{1,3}_M_P_[0-9](_T2)?' THEN REGEXP_REPLACE(event_id, 'ANH_[0-9]{1,3}_M_P_([0-9])(_T2)?$', '\1')::int
   WHEN event_id ~ 'ANH_([0-9]{1,3}_)?M_CM_[0-9]_T2' THEN REGEXP_REPLACE(event_id, 'ANH_([0-9]{1,3}_)?M_CM_([0-9])(_T2)?$', '\2')::int
   ELSE NULL
 END repli,
 CASE
   WHEN event_id ~ 'T2$' THEN 'T2'
   ELSE 'T1'
 END tempo

FROM raw_dwc.mamiferos_tot_event
)
SELECT anh_name,tempo,metodo, /*ARRAY_AGG(DISTINCT repli ORDER BY repli) repli,*/  count(*)
FROM a
GROUP BY anh_num,anh_name, tempo, metodo
ORDER BY anh_num IS NOT NULL,anh_num,tempo, metodo
;
```

<div class="knitsql-table">

| anh_name | tempo | metodo                  | count |
|:---------|:------|:------------------------|------:|
| Hotel    | T1    | grabación               |     1 |
| NA       | T2    | accidental              |     1 |
| Hotel    | T2    | grabación               |     2 |
| ANH_64   | T1    | grabación               |     5 |
| ANH_64   | T1    | niebla                  |    20 |
| ANH_64   | T2    | grabación               |     3 |
| ANH_64   | T2    | niebla                  |    20 |
| ANH_65   | T1    | niebla                  |    20 |
| ANH_65   | T1    | sherman                 |    70 |
| ANH_65   | T2    | niebla                  |    20 |
| ANH_66   | T1    | grabación               |     4 |
| ANH_66   | T1    | niebla                  |    20 |
| ANH_66   | T2    | grabación               |     3 |
| ANH_66   | T2    | niebla                  |    20 |
| ANH_67   | T1    | niebla                  |    20 |
| ANH_67   | T2    | niebla                  |    20 |
| ANH_68   | T1    | grabación               |     6 |
| ANH_68   | T1    | niebla                  |    20 |
| ANH_68   | T2    | grabación               |     3 |
| ANH_68   | T2    | niebla                  |    20 |
| ANH_69   | T1    | sherman                 |    70 |
| ANH_71   | T1    | niebla                  |    20 |
| ANH_71   | T2    | niebla                  |    20 |
| ANH_72   | T1    | grabación               |     3 |
| ANH_72   | T1    | niebla                  |    20 |
| ANH_72   | T1    | sherman                 |    70 |
| ANH_72   | T2    | grabación               |     3 |
| ANH_72   | T2    | niebla                  |    20 |
| ANH_73   | T1    | grabación               |     4 |
| ANH_73   | T1    | niebla                  |    20 |
| ANH_73   | T2    | grabación               |     3 |
| ANH_73   | T2    | niebla                  |    20 |
| ANH_74   | T1    | niebla                  |    20 |
| ANH_74   | T1    | sherman                 |    70 |
| ANH_74   | T2    | niebla                  |    20 |
| ANH_75   | T1    | grabación               |     3 |
| ANH_75   | T1    | niebla                  |    20 |
| ANH_75   | T2    | niebla                  |    20 |
| ANH_76   | T1    | niebla                  |    20 |
| ANH_76   | T2    | grabación               |     3 |
| ANH_76   | T2    | niebla                  |    20 |
| ANH_77   | T1    | sherman                 |    70 |
| ANH_78   | T1    | grabación               |     6 |
| ANH_78   | T1    | niebla                  |    20 |
| ANH_78   | T1    | sherman                 |    70 |
| ANH_88   | T1    | sherman                 |    70 |
| ANH_89   | T1    | grabación               |     2 |
| ANH_89   | T1    | niebla                  |    20 |
| ANH_89   | T1    | sherman                 |    70 |
| ANH_89   | T2    | niebla                  |    20 |
| ANH_90   | T1    | grabación               |     3 |
| ANH_90   | T1    | niebla                  |    20 |
| ANH_90   | T2    | grabación               |     3 |
| ANH_90   | T2    | niebla                  |    20 |
| ANH_91   | T1    | sherman                 |    70 |
| ANH_92   | T1    | grabación               |     5 |
| ANH_92   | T1    | niebla                  |    20 |
| ANH_92   | T1    | sherman                 |    70 |
| ANH_92   | T2    | grabación               |     3 |
| ANH_92   | T2    | niebla                  |    20 |
| ANH_93   | T1    | grabación               |     7 |
| ANH_93   | T1    | niebla                  |    20 |
| ANH_93   | T2    | grabación               |     3 |
| ANH_93   | T2    | niebla                  |    20 |
| ANH_94   | T1    | sherman                 |    70 |
| ANH_95   | T1    | sherman                 |    70 |
| ANH_96   | T1    | grabación               |     4 |
| ANH_96   | T1    | niebla                  |    20 |
| ANH_96   | T1    | sherman                 |    70 |
| ANH_96   | T2    | grabación               |     3 |
| ANH_96   | T2    | niebla                  |    20 |
| ANH_97   | T1    | grabación               |     3 |
| ANH_97   | T1    | niebla                  |    20 |
| ANH_97   | T2    | grabación               |     3 |
| ANH_97   | T2    | niebla                  |    20 |
| ANH_98   | T1    | grabación               |     3 |
| ANH_98   | T1    | niebla                  |    20 |
| ANH_98   | T2    | niebla                  |    20 |
| ANH_99   | T1    | sherman                 |    70 |
| ANH_100  | T1    | sherman                 |    70 |
| ANH_101  | T1    | sherman                 |    70 |
| ANH_103  | T1    | grabación               |     3 |
| ANH_103  | T1    | niebla                  |    20 |
| ANH_103  | T2    | grabación               |     3 |
| ANH_103  | T2    | niebla                  |    20 |
| ANH_130  | T2    | accidental (pitfall)    |     2 |
| ANH_133  | T2    | grabación               |     1 |
| ANH_136  | T1    | grabación               |     3 |
| ANH_136  | T2    | grabación               |     1 |
| ANH_149  | T1    | grabación               |     3 |
| ANH_149  | T2    | accidental              |     1 |
| ANH_150  | T1    | grabación               |     3 |
| ANH_153  | T1    | accidental (otro grupo) |     1 |
| ANH_155  | T2    | grabación               |     1 |
| ANH_158  | T2    | grabación               |     1 |
| ANH_160  | T2    | grabación               |     1 |
| ANH_164  | T1    | grabación               |     3 |
| ANH_166  | T2    | accidental              |     1 |
| ANH_185  | T1    | accidental (otro grupo) |     1 |
| ANH_223  | T1    | accidental (otro grupo) |     1 |

Displaying records 1 - 100

</div>

## 9.4 ANH

Anotar, ‘Hotel’ no es un anh, pero lo incluyo como punto de referencia

Insertar los datos de anh:

``` sql
INSERT INTO main.punto_referencia(name_pt_ref, num_anh)
WITH a AS(
SELECT
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_.*' THEN REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_.*','\1')
   WHEN event_id ~ '^ANH_[0-9]{1,3}$' THEN event_id
   WHEN event_id ~ '[Hh]otel' THEN 'Hotel'
 END anh_name,
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_.*' THEN REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_.*','\1')::int
   WHEN event_id ~ '^ANH_[0-9]{1,3}$' THEN REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})$','\1')::int
   ELSE NULL
 END anh_num
FROM raw_dwc.mamiferos_tot_event
)
SELECT anh_name, anh_num
FROM a
WHERE anh_name IS NOT NULL
GROUP BY anh_name,anh_num
ORDER BY anh_num
ON CONFLICT (name_pt_ref) DO NOTHING
RETURNING cd_pt_ref, name_pt_ref
;
```

dar las referencias en las tablas totales de mamiferos

``` sql
ALTER TABLE raw_dwc.mamiferos_tot_event ADD COLUMN cd_pt_ref int REFERENCES main.punto_referencia(cd_pt_ref) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE raw_dwc.mamiferos_tot_registros ADD COLUMN cd_pt_ref int REFERENCES main.punto_referencia(cd_pt_ref) ON DELETE SET NULL ON UPDATE CASCADE;

WITH a AS(
SELECT event_id,
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_.*' THEN REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_.*','\1')
   WHEN event_id ~ '^ANH_[0-9]{1,3}$' THEN event_id
   WHEN event_id ~ '[Hh]otel' THEN 'Hotel'
   ELSE NULL
 END anh_name
FROM raw_dwc.mamiferos_tot_event
)
UPDATE raw_dwc.mamiferos_tot_event AS m
SET cd_pt_ref=pr.cd_pt_ref
FROM main.punto_referencia pr, a
WHERE m.event_id=a.event_id AND a.anh_name = name_pt_ref
;

WITH a AS(
SELECT event_id,
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_.*' THEN REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_.*','\1')
   WHEN event_id ~ '^ANH_[0-9]{1,3}$' THEN event_id
   WHEN event_id ~ '[Hh]otel' THEN 'Hotel'
   ELSE NULL
 END anh_name
FROM raw_dwc.mamiferos_tot_registros
)
UPDATE raw_dwc.mamiferos_tot_registros AS m
SET cd_pt_ref=pr.cd_pt_ref
FROM main.punto_referencia pr, a
WHERE m.event_id=a.event_id AND a.anh_name = name_pt_ref
;

SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

Averiguando que ninguna fila no tenga anh

``` sql
SELECT event_id FROM raw_dwc.mamiferos_tot_event WHERE cd_pt_ref IS NULL;
```

<div class="knitsql-table">

| event_id      |
|:--------------|
| ANH_M_CM_4_T2 |

1 records

</div>

``` sql
SELECT event_id,occurrence_id FROM raw_dwc.mamiferos_tot_registros WHERE cd_pt_ref IS NULL;
```

<div class="knitsql-table">

| event_id      | occurrence_id                                                             |
|:--------------|:--------------------------------------------------------------------------|
| ANH_M_CM_4_T2 | IAvH:SSCPE-ANH:SANTANDER:MAMMALIA:OBSERVACIONHUMANA:I2D-BIO_2021_083:2791 |

1 records

</div>

## 9.5 Unit, sampling efforts definition, abundance definition, protocolo

**Anotar: en las trampas Sherman, solo está la hora 7:00, pero imagino
que se instalarón a las 6 de la noche porque el tiempo está anotado en
numero de noches**

``` sql
INSERT INTO main.def_unit(cd_measurement_type, unit, unit_spa, abbv_unit,factor)
VALUES(
  (SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='time'),
  'Number of nights',
  'Número de noches',
  'nights',
  12*60--Acá considero noches de 12 horas
  ),(
  (SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='presence/absence'),
  'Occurrence',
  'Occurrencia',
  NULL,
  1
  )
RETURNING cd_unit, unit, unit_spa
```

``` sql
INSERT INTO main.def_var_ind_qt(var_qt_ind, var_qt_ind_spa, cd_unit, type_variable)
VALUES(
  'Occurrence',
  'Occurrencia',
  (SELECT cd_unit FROM main.def_unit WHERE cd_measurement_type=(SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='presence/absence') AND unit='Occurrence'),
  'int'
)
RETURNING cd_var_ind_qt,var_qt_ind
;
```

``` sql
INSERT INTO main.def_var_samp_eff(var_samp_eff, var_samp_eff_spa, cd_unit,type_variable)
VALUES(
  'Time elapsed (nights)',
  'Duración (numero de noches)',
  (SELECT cd_unit FROM main.def_unit WHERE cd_measurement_type=(SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='time') AND unit='Number of nights'),
  'int'
  )
RETURNING cd_var_samp_eff, var_samp_eff ;
```

``` sql
INSERT INTO main.def_protocol(protocol,protocol_spa,cd_var_samp_eff_1,cd_var_samp_eff_2,samp_eff_1_implicit,samp_eff_2_implicit,cd_var_ind_qt,description_spa)
VALUES(
  'Sherman trap',
  'Trampa Sherman',
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Elapsed time'),
  NULL,
  false,
  NULL,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind='Number of individuals'),
  'Tal vez sería bueno añadir la superficie o la area de la trampa, pero no tengo acceso a esta información'
),(
  'Sound recording',
  'Grabación sonora',
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Elapsed time'),
  NULL,
  false,
  NULL,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind='Occurrence'),
  NULL
)
RETURNING cd_protocol,protocol,protocol_spa;
```

## 9.6 Personas

``` sql
INSERT INTO main.people(verbatim_person)
WITH a AS(
SELECT DISTINCT INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(recorded_by, ' | ')))) AS name_person
FROM raw_dwc.mamiferos_tot_registros
UNION
SELECT DISTINCT INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(identified_by, ' | '))))
FROM raw_dwc.mamiferos_tot_registros
)
SELECT DISTINCT REGEXP_REPLACE(name_person, '- ','-')
FROM a 
ORDER BY REGEXP_REPLACE(name_person, '- ','-')
ON CONFLICT(verbatim_person) DO NOTHING
RETURNING cd_person, verbatim_person
```

Dar los codigos a las tables de origen:

``` sql
ALTER TABLE raw_dwc.mamiferos_tot_registros ADD COLUMN cds_recorded_by int[];

WITH a AS(
SELECT table_orig,"row.names", REGEXP_REPLACE(INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(recorded_by, ' | ')))),'- ','-') AS name_person
FROM raw_dwc.mamiferos_tot_registros
),b AS(
SELECT table_orig,"row.names", ARRAY_AGG(cd_person) cds
FROM a 
LEFT JOIN main.people p ON a.name_person=p.verbatim_person
GROUP BY table_orig, "row.names"
)
UPDATE raw_dwc.mamiferos_tot_registros AS r
SET cds_recorded_by=b.cds
FROM b
WHERE r."row.names"=b."row.names" AND r.table_orig=b.table_orig
RETURNING r."row.names", cds_recorded_by
;

ALTER TABLE raw_dwc.mamiferos_tot_registros ADD COLUMN cds_identified_by int[];

WITH a AS(
SELECT table_orig,"row.names", REGEXP_REPLACE(INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(identified_by, ' | ')))),'- ','-') AS name_person
FROM raw_dwc.mamiferos_tot_registros
),b AS(
SELECT table_orig,"row.names", ARRAY_AGG(cd_person) cds
FROM a 
LEFT JOIN main.people p ON a.name_person=p.verbatim_person
GROUP BY table_orig,"row.names"
)
UPDATE raw_dwc.mamiferos_tot_registros AS r
SET cds_identified_by=b.cds
FROM b
WHERE r."row.names"=b."row.names" AND r.table_orig=b.table_orig
RETURNING r."row.names", cds_identified_by
;

SELECT 1;
```

<div class="knitsql-table">

| ?column? |
|---------:|
|        1 |

1 records

</div>

## 9.7 gp_event

``` sql
WITH a AS(
SELECT 
  event_id,
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_.*' THEN REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_.*','\1')
   WHEN event_id ~ '^ANH_[0-9]{1,3}$' THEN event_id
   WHEN event_id ~ '[Hh]otel' THEN 'Hotel'
 END anh_name,
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_.*' THEN REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_.*','\1')::int
   WHEN event_id ~ '^ANH_[0-9]{1,3}$' THEN REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})$','\1')::int
   ELSE NULL
 END anh_num,
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_M_[RS][0-9]{1,3}(_T2)?$' AND sampling_protocol='Red niebla' THEN 'niebla'
   WHEN event_id ~ '^ANH_[0-9]{1,3}_M_[RS][0-9]{1,3}(_T2)?$' AND sampling_protocol='Trampa Sherman' THEN 'sherman'
   WHEN sampling_protocol ~ '^Punto( de)? grabación' THEN 'grabación'
   WHEN event_id ~ 'Herp' OR event_id ~ '^ANH_[0-9]{1,3}_A_' THEN 'accidental (otro grupo)'
   WHEN sampling_protocol='Captura manual' THEN 'accidental' 
   WHEN sampling_protocol~'^Encuentro ?$' THEN 'accidental' 
   WHEN sampling_protocol='Trampa pitfall' THEN 'accidental (pitfall)'
 END metodo,
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_M_[RS]([0-9]{1,3})(_T2)?$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_M_[RS]([0-9]{1,3})(_T2)?$','\1')::int
   WHEN sampling_protocol ~ '^Punto( de)? grabación' AND event_id ~ '^ANH_[0-9]{1,3}_([0-9]{1,2})(_T2)?' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_([0-9]{1,2})(_T2)?','\1')::int
   WHEN event_id ~ '^Hotel_[0-9]' THEN REGEXP_REPLACE(event_id,'^Hotel_([0-9]).*','\1')::int
   WHEN event_id ~ 'ANH_[0-9]{1,3}_M_P_[0-9](_T2)?' THEN REGEXP_REPLACE(event_id, 'ANH_[0-9]{1,3}_M_P_([0-9])(_T2)?$', '\1')::int
   WHEN event_id ~ 'ANH_([0-9]{1,3}_)?M_CM_[0-9]_T2' THEN REGEXP_REPLACE(event_id, 'ANH_([0-9]{1,3}_)?M_CM_([0-9])(_T2)?$', '\2')::int
   ELSE NULL
 END repli,
 CASE
   WHEN event_id ~ 'T2$' THEN 'T2'
   ELSE 'T1'
 END tempo
FROM raw_dwc.mamiferos_tot_event
)
SELECT tempo, anh_num,metodo, ARRAY_AGG(repli), count(*)
FROM a
GROUP BY tempo, anh_num, metodo
ORDER BY tempo, anh_num, metodo
;
```

<div class="knitsql-table">

| tempo | anh_num | metodo                  | array_agg                                                                                                                                                                                                  | count |
|:------|--------:|:------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------:|
| T1    |      64 | grabación               | {1,2,3,4,5}                                                                                                                                                                                                |     5 |
| T1    |      64 | niebla                  | {11,12,13,14,15,16,17,18,20,1,10,19,2,3,4,5,6,7,8,9}                                                                                                                                                       |    20 |
| T1    |      65 | niebla                  | {31,32,33,34,35,36,37,38,39,40,21,22,23,24,25,26,27,28,29,30}                                                                                                                                              |    20 |
| T1    |      65 | sherman                 | {1,10,11,12,13,14,15,16,17,18,19,2,20,21,22,23,24,25,26,27,28,29,3,30,31,32,33,34,35,36,37,38,39,4,40,41,42,43,44,45,46,47,48,49,5,50,51,52,53,54,55,56,57,58,59,6,60,61,62,63,64,65,66,67,68,69,7,70,8,9} |    70 |
| T1    |      66 | grabación               | {1,2,3,4}                                                                                                                                                                                                  |     4 |
| T1    |      66 | niebla                  | {71,61,62,63,64,65,66,67,68,69,70,72,73,74,75,76,77,78,79,80}                                                                                                                                              |    20 |
| T1    |      67 | niebla                  | {1,10,11,12,13,14,15,16,17,18,19,2,20,3,4,5,6,7,8,9}                                                                                                                                                       |    20 |
| T1    |      68 | grabación               | {1,2,3,4,5,6}                                                                                                                                                                                              |     6 |
| T1    |      68 | niebla                  | {211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230}                                                                                                                          |    20 |
| T1    |      69 | sherman                 | {1,10,11,12,13,14,15,16,17,18,19,2,20,21,22,23,24,25,26,27,28,29,3,30,31,32,33,34,35,36,37,38,39,4,40,41,42,43,44,45,46,47,48,49,5,50,51,52,53,54,55,56,57,58,59,6,60,61,62,63,64,65,66,67,68,69,7,70,8,9} |    70 |
| T1    |      71 | niebla                  | {1,10,11,12,13,14,15,16,17,18,19,2,20,3,4,5,6,7,8,9}                                                                                                                                                       |    20 |
| T1    |      72 | grabación               | {1,2,3}                                                                                                                                                                                                    |     3 |
| T1    |      72 | niebla                  | {11,12,13,14,15,1,10,16,17,18,19,2,20,3,4,5,6,7,8,9}                                                                                                                                                       |    20 |
| T1    |      72 | sherman                 | {1,10,11,12,13,14,15,16,17,18,19,2,20,21,22,23,24,25,26,27,28,29,3,30,31,32,33,34,35,36,37,38,39,4,40,41,42,43,44,45,46,47,48,49,5,50,51,52,53,54,55,56,57,58,59,6,60,61,62,63,64,65,66,67,68,69,7,70,8,9} |    70 |
| T1    |      73 | grabación               | {1,2,3,4}                                                                                                                                                                                                  |     4 |
| T1    |      73 | niebla                  | {1,10,11,12,13,14,15,16,17,18,19,2,20,3,4,5,6,7,8,9}                                                                                                                                                       |    20 |
| T1    |      74 | niebla                  | {15,16,17,18,19,20,1,10,11,12,13,14,2,3,4,5,6,7,8,9}                                                                                                                                                       |    20 |
| T1    |      74 | sherman                 | {1,10,11,12,13,14,15,16,17,18,19,2,20,21,22,23,24,25,26,27,28,29,3,30,31,32,33,34,35,36,37,38,39,4,40,41,42,43,44,45,46,47,48,49,5,50,51,52,53,54,55,56,57,58,59,6,60,61,62,63,64,65,66,67,68,69,7,70,8,9} |    70 |
| T1    |      75 | grabación               | {1,2,3}                                                                                                                                                                                                    |     3 |
| T1    |      75 | niebla                  | {121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140}                                                                                                                          |    20 |
| T1    |      76 | niebla                  | {55,41,42,43,44,45,46,47,48,49,50,51,52,53,54,56,57,58,59,60}                                                                                                                                              |    20 |
| T1    |      77 | sherman                 | {1,10,11,12,13,14,15,16,17,18,19,2,20,21,22,23,24,25,26,27,28,29,3,30,31,32,33,34,35,36,37,38,39,4,40,41,42,43,44,45,46,47,48,49,5,50,51,52,53,54,55,56,57,58,59,6,60,61,62,63,64,65,66,67,68,69,7,70,8,9} |    70 |
| T1    |      78 | grabación               | {1,2,3,4,5,6}                                                                                                                                                                                              |     6 |
| T1    |      78 | niebla                  | {151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170}                                                                                                                          |    20 |
| T1    |      78 | sherman                 | {1,10,11,12,13,14,15,16,17,18,19,2,20,21,22,23,24,25,26,27,28,29,3,30,31,32,33,34,35,36,37,38,39,4,40,41,42,43,44,45,46,47,48,49,5,50,51,52,53,54,55,56,57,58,59,6,60,61,62,63,64,65,66,67,68,69,7,70,8,9} |    70 |
| T1    |      88 | sherman                 | {1,10,11,12,13,14,15,16,17,18,19,2,20,21,22,23,24,25,26,27,28,29,3,30,31,32,33,34,35,36,37,38,39,4,40,41,42,43,44,45,46,47,48,49,5,50,51,52,53,54,55,56,57,58,59,6,60,61,62,63,64,65,66,67,68,69,7,70,8,9} |    70 |
| T1    |      89 | grabación               | {1,2}                                                                                                                                                                                                      |     2 |
| T1    |      89 | niebla                  | {191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210}                                                                                                                          |    20 |
| T1    |      89 | sherman                 | {1,10,11,12,13,14,15,16,17,18,19,2,20,21,22,23,24,25,26,27,28,29,3,30,31,32,33,34,35,36,37,38,39,4,40,41,42,43,44,45,46,47,48,49,5,50,51,52,53,54,55,56,57,58,59,6,60,61,62,63,64,65,66,67,68,69,7,70,8,9} |    70 |
| T1    |      90 | grabación               | {1,2,3}                                                                                                                                                                                                    |     3 |
| T1    |      90 | niebla                  | {101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120}                                                                                                                          |    20 |
| T1    |      91 | sherman                 | {1,10,11,12,13,14,15,16,17,18,19,2,20,21,22,23,24,25,26,27,28,29,3,30,31,32,33,34,35,36,37,38,39,4,40,41,42,43,44,45,46,47,48,49,5,50,51,52,53,54,55,56,57,58,59,6,60,61,62,63,64,65,66,67,68,69,7,70,8,9} |    70 |
| T1    |      92 | grabación               | {1,2,3,4,5}                                                                                                                                                                                                |     5 |
| T1    |      92 | niebla                  | {1,15,16,2,3,4,5,6,10,11,12,13,14,17,18,19,20,7,8,9}                                                                                                                                                       |    20 |
| T1    |      92 | sherman                 | {1,10,11,12,13,14,15,16,17,18,19,2,20,21,22,23,24,25,26,27,28,29,3,30,31,32,33,34,35,36,37,38,39,4,40,41,42,43,44,45,46,47,48,49,5,50,51,52,53,54,55,56,57,58,59,6,60,61,62,63,64,65,66,67,68,69,7,70,8,9} |    70 |
| T1    |      93 | grabación               | {1,2,3,4,5,6,7}                                                                                                                                                                                            |     7 |
| T1    |      93 | niebla                  | {181,179,180,171,172,173,174,175,176,177,178,182,183,184,185,186,187,188,189,190}                                                                                                                          |    20 |
| T1    |      94 | sherman                 | {1,10,11,12,13,14,15,16,17,18,19,2,20,21,22,23,24,25,26,27,28,29,3,30,31,32,33,34,35,36,37,38,39,4,40,41,42,43,44,45,46,47,48,49,5,50,51,52,53,54,55,56,57,58,59,6,60,61,62,63,64,65,66,67,68,69,7,70,8,9} |    70 |
| T1    |      95 | sherman                 | {1,10,11,12,13,14,15,16,17,18,19,2,20,21,22,23,24,25,26,27,28,29,3,30,31,32,33,34,35,36,37,38,39,4,40,41,42,43,44,45,46,47,48,49,5,50,51,52,53,54,55,56,57,58,59,6,60,61,62,63,64,65,66,67,68,69,7,70,8,9} |    70 |
| T1    |      96 | grabación               | {1,2,3,4}                                                                                                                                                                                                  |     4 |
| T1    |      96 | niebla                  | {21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40}                                                                                                                                              |    20 |
| T1    |      96 | sherman                 | {1,10,11,12,13,14,15,16,17,18,19,2,20,21,22,23,24,25,26,27,28,29,3,30,31,32,33,34,35,36,37,38,39,4,40,41,42,43,44,45,46,47,48,49,5,50,51,52,53,54,55,56,57,58,59,6,60,61,62,63,64,65,66,67,68,69,7,70,8,9} |    70 |
| T1    |      97 | grabación               | {1,2,3}                                                                                                                                                                                                    |     3 |
| T1    |      97 | niebla                  | {1,10,11,12,13,14,15,16,17,18,19,2,20,3,4,5,6,7,8,9}                                                                                                                                                       |    20 |
| T1    |      98 | grabación               | {1,2,3}                                                                                                                                                                                                    |     3 |
| T1    |      98 | niebla                  | {100,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99}                                                                                                                                             |    20 |
| T1    |      99 | sherman                 | {69,1,10,11,12,13,14,15,16,17,18,19,2,20,21,22,23,24,25,26,27,28,29,3,30,31,32,33,34,35,36,37,38,39,4,40,41,42,43,44,45,46,47,48,49,5,50,51,52,53,54,55,56,57,58,59,6,60,61,62,63,64,65,66,67,68,7,70,8,9} |    70 |
| T1    |     100 | sherman                 | {1,10,11,12,13,14,15,16,17,18,19,2,20,21,22,23,24,25,26,27,28,29,3,30,31,32,33,34,35,36,37,38,39,4,40,41,42,43,44,45,46,47,48,49,5,50,51,52,53,54,55,56,57,58,59,6,60,61,62,63,64,65,66,67,68,69,7,70,8,9} |    70 |
| T1    |     101 | sherman                 | {1,10,11,12,13,14,15,16,17,18,19,2,20,21,22,23,24,25,26,27,28,29,3,30,31,32,33,34,35,36,37,38,39,4,40,41,42,43,44,45,46,47,48,49,5,50,51,52,53,54,55,56,57,58,59,6,60,61,62,63,64,65,66,67,68,69,7,70,8,9} |    70 |
| T1    |     103 | grabación               | {1,2,3}                                                                                                                                                                                                    |     3 |
| T1    |     103 | niebla                  | {1,10,141,142,143,144,145,146,147,148,149,150,2,3,4,5,6,7,8,9}                                                                                                                                             |    20 |
| T1    |     136 | grabación               | {1,2,3}                                                                                                                                                                                                    |     3 |
| T1    |     149 | grabación               | {1,2,3}                                                                                                                                                                                                    |     3 |
| T1    |     150 | grabación               | {1,2,3}                                                                                                                                                                                                    |     3 |
| T1    |     153 | accidental (otro grupo) | {NULL}                                                                                                                                                                                                     |     1 |
| T1    |     164 | grabación               | {1,2,3}                                                                                                                                                                                                    |     3 |
| T1    |     185 | accidental (otro grupo) | {NULL}                                                                                                                                                                                                     |     1 |
| T1    |     223 | accidental (otro grupo) | {NULL}                                                                                                                                                                                                     |     1 |
| T1    |     223 | grabación               | {1,2,3}                                                                                                                                                                                                    |     3 |
| T1    |     240 | accidental (otro grupo) | {NULL}                                                                                                                                                                                                     |     1 |
| T1    |     248 | grabación               | {1,2,3}                                                                                                                                                                                                    |     3 |
| T1    |     336 | grabación               | {1,2,3}                                                                                                                                                                                                    |     3 |
| T1    |     360 | accidental              | {NULL}                                                                                                                                                                                                     |     1 |
| T1    |      NA | grabación               | {1}                                                                                                                                                                                                        |     1 |
| T2    |      64 | grabación               | {1,2,3}                                                                                                                                                                                                    |     3 |
| T2    |      64 | niebla                  | {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}                                                                                                                                                       |    20 |
| T2    |      65 | niebla                  | {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}                                                                                                                                                       |    20 |
| T2    |      66 | grabación               | {1,2,3}                                                                                                                                                                                                    |     3 |
| T2    |      66 | niebla                  | {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}                                                                                                                                                       |    20 |
| T2    |      67 | niebla                  | {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}                                                                                                                                                       |    20 |
| T2    |      68 | grabación               | {1,2,3}                                                                                                                                                                                                    |     3 |
| T2    |      68 | niebla                  | {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}                                                                                                                                                       |    20 |
| T2    |      71 | niebla                  | {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}                                                                                                                                                       |    20 |
| T2    |      72 | grabación               | {1,2,3}                                                                                                                                                                                                    |     3 |
| T2    |      72 | niebla                  | {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}                                                                                                                                                       |    20 |
| T2    |      73 | grabación               | {1,2,3}                                                                                                                                                                                                    |     3 |
| T2    |      73 | niebla                  | {8,9,10,1,2,3,4,5,6,7,11,12,13,14,15,16,17,18,19,20}                                                                                                                                                       |    20 |
| T2    |      74 | niebla                  | {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}                                                                                                                                                       |    20 |
| T2    |      75 | niebla                  | {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}                                                                                                                                                       |    20 |
| T2    |      76 | grabación               | {2,1,3}                                                                                                                                                                                                    |     3 |
| T2    |      76 | niebla                  | {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}                                                                                                                                                       |    20 |
| T2    |      89 | niebla                  | {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}                                                                                                                                                       |    20 |
| T2    |      90 | grabación               | {1,2,3}                                                                                                                                                                                                    |     3 |
| T2    |      90 | niebla                  | {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}                                                                                                                                                       |    20 |
| T2    |      92 | grabación               | {1,2,3}                                                                                                                                                                                                    |     3 |
| T2    |      92 | niebla                  | {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}                                                                                                                                                       |    20 |
| T2    |      93 | grabación               | {1,2,3}                                                                                                                                                                                                    |     3 |
| T2    |      93 | niebla                  | {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}                                                                                                                                                       |    20 |
| T2    |      96 | grabación               | {1,2,3}                                                                                                                                                                                                    |     3 |
| T2    |      96 | niebla                  | {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}                                                                                                                                                       |    20 |
| T2    |      97 | grabación               | {1,2,3}                                                                                                                                                                                                    |     3 |
| T2    |      97 | niebla                  | {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}                                                                                                                                                       |    20 |
| T2    |      98 | niebla                  | {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}                                                                                                                                                       |    20 |
| T2    |     103 | grabación               | {1,2,3}                                                                                                                                                                                                    |     3 |
| T2    |     103 | niebla                  | {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}                                                                                                                                                       |    20 |
| T2    |     130 | accidental (pitfall)    | {1,2}                                                                                                                                                                                                      |     2 |
| T2    |     133 | grabación               | {1}                                                                                                                                                                                                        |     1 |
| T2    |     136 | grabación               | {1}                                                                                                                                                                                                        |     1 |
| T2    |     149 | accidental              | {2}                                                                                                                                                                                                        |     1 |
| T2    |     155 | grabación               | {1}                                                                                                                                                                                                        |     1 |

Displaying records 1 - 100

</div>

Because there is more than a method, the number of the campaign should
be determined this way:

``` sql
WITH a AS(
SELECT 
  event_id,
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_.*' THEN REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_.*','\1')
   WHEN event_id ~ '^ANH_[0-9]{1,3}$' THEN event_id
   WHEN event_id ~ '[Hh]otel' THEN 'Hotel'
 END anh_name,
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_.*' THEN REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_.*','\1')::int
   WHEN event_id ~ '^ANH_[0-9]{1,3}$' THEN REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})$','\1')::int
   ELSE NULL
 END anh_num,
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_M_[RS][0-9]{1,3}(_T2)?$' AND sampling_protocol='Red niebla' THEN 'niebla'
   WHEN event_id ~ '^ANH_[0-9]{1,3}_M_[RS][0-9]{1,3}(_T2)?$' AND sampling_protocol='Trampa Sherman' THEN 'sherman'
   WHEN sampling_protocol ~ '^Punto( de)? grabación' THEN 'grabación'
   WHEN event_id ~ 'Herp' OR event_id ~ '^ANH_[0-9]{1,3}_A_' THEN 'accidental (otro grupo)'
   WHEN sampling_protocol='Captura manual' THEN 'accidental' 
   WHEN sampling_protocol~'^Encuentro ?$' THEN 'accidental' 
   WHEN sampling_protocol='Trampa pitfall' THEN 'accidental (pitfall)'
 END metodo,
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_M_[RS]([0-9]{1,3})(_T2)?$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_M_[RS]([0-9]{1,3})(_T2)?$','\1')::int
   WHEN sampling_protocol ~ '^Punto( de)? grabación' AND event_id ~ '^ANH_[0-9]{1,3}_([0-9]{1,2})(_T2)?' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_([0-9]{1,2})(_T2)?','\1')::int
   WHEN event_id ~ '^Hotel_[0-9]' THEN REGEXP_REPLACE(event_id,'^Hotel_([0-9]).*','\1')::int
   WHEN event_id ~ 'ANH_[0-9]{1,3}_M_P_[0-9](_T2)?' THEN REGEXP_REPLACE(event_id, 'ANH_[0-9]{1,3}_M_P_([0-9])(_T2)?$', '\1')::int
   WHEN event_id ~ 'ANH_([0-9]{1,3}_)?M_CM_[0-9]_T2' THEN REGEXP_REPLACE(event_id, 'ANH_([0-9]{1,3}_)?M_CM_([0-9])(_T2)?$', '\2')::int
   ELSE NULL
 END repli,
 CASE
   WHEN event_id ~ 'T2$' THEN 'T2'
   ELSE 'T1'
 END tempo
FROM raw_dwc.mamiferos_tot_event
)
SELECT tempo, anh_name, ROW_NUMBER() OVER (PARTITION BY anh_name ORDER BY tempo) campaign_nb
FROM a
GROUP BY tempo, anh_name
ORDER BY tempo, anh_name
;
```

<div class="knitsql-table">

| tempo | anh_name | campaign_nb |
|:------|:---------|------------:|
| T1    | ANH_100  |           1 |
| T1    | ANH_101  |           1 |
| T1    | ANH_103  |           1 |
| T1    | ANH_136  |           1 |
| T1    | ANH_149  |           1 |
| T1    | ANH_150  |           1 |
| T1    | ANH_153  |           1 |
| T1    | ANH_164  |           1 |
| T1    | ANH_185  |           1 |
| T1    | ANH_223  |           1 |
| T1    | ANH_240  |           1 |
| T1    | ANH_248  |           1 |
| T1    | ANH_336  |           1 |
| T1    | ANH_360  |           1 |
| T1    | ANH_64   |           1 |
| T1    | ANH_65   |           1 |
| T1    | ANH_66   |           1 |
| T1    | ANH_67   |           1 |
| T1    | ANH_68   |           1 |
| T1    | ANH_69   |           1 |
| T1    | ANH_71   |           1 |
| T1    | ANH_72   |           1 |
| T1    | ANH_73   |           1 |
| T1    | ANH_74   |           1 |
| T1    | ANH_75   |           1 |
| T1    | ANH_76   |           1 |
| T1    | ANH_77   |           1 |
| T1    | ANH_78   |           1 |
| T1    | ANH_88   |           1 |
| T1    | ANH_89   |           1 |
| T1    | ANH_90   |           1 |
| T1    | ANH_91   |           1 |
| T1    | ANH_92   |           1 |
| T1    | ANH_93   |           1 |
| T1    | ANH_94   |           1 |
| T1    | ANH_95   |           1 |
| T1    | ANH_96   |           1 |
| T1    | ANH_97   |           1 |
| T1    | ANH_98   |           1 |
| T1    | ANH_99   |           1 |
| T1    | Hotel    |           1 |
| T2    | ANH_103  |           2 |
| T2    | ANH_130  |           1 |
| T2    | ANH_133  |           1 |
| T2    | ANH_136  |           2 |
| T2    | ANH_149  |           2 |
| T2    | ANH_155  |           1 |
| T2    | ANH_158  |           1 |
| T2    | ANH_160  |           1 |
| T2    | ANH_166  |           1 |
| T2    | ANH_299  |           1 |
| T2    | ANH_306  |           1 |
| T2    | ANH_360  |           2 |
| T2    | ANH_368  |           1 |
| T2    | ANH_374  |           1 |
| T2    | ANH_64   |           2 |
| T2    | ANH_65   |           2 |
| T2    | ANH_66   |           2 |
| T2    | ANH_67   |           2 |
| T2    | ANH_68   |           2 |
| T2    | ANH_71   |           2 |
| T2    | ANH_72   |           2 |
| T2    | ANH_73   |           2 |
| T2    | ANH_74   |           2 |
| T2    | ANH_75   |           2 |
| T2    | ANH_76   |           2 |
| T2    | ANH_89   |           2 |
| T2    | ANH_90   |           2 |
| T2    | ANH_92   |           2 |
| T2    | ANH_93   |           2 |
| T2    | ANH_96   |           2 |
| T2    | ANH_97   |           2 |
| T2    | ANH_98   |           2 |
| T2    | Hotel    |           2 |
| T2    | NA       |           1 |

75 records

</div>

``` sql
INSERT INTO main.gp_event(cd_gp_biol,cd_protocol,cd_pt_ref,campaign_nb)
WITH a AS(
SELECT 
  event_id,
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_.*' THEN REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_.*','\1')
   WHEN event_id ~ '^ANH_[0-9]{1,3}$' THEN event_id
   WHEN event_id ~ '[Hh]otel' THEN 'Hotel'
 END anh_name,
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_.*' THEN REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_.*','\1')::int
   WHEN event_id ~ '^ANH_[0-9]{1,3}$' THEN REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})$','\1')::int
   ELSE NULL
 END anh_num,
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_M_[RS][0-9]{1,3}(_T2)?$' AND sampling_protocol='Red niebla' THEN 'niebla'
   WHEN event_id ~ '^ANH_[0-9]{1,3}_M_[RS][0-9]{1,3}(_T2)?$' AND sampling_protocol='Trampa Sherman' THEN 'sherman'
   WHEN sampling_protocol ~ '^Punto( de)? grabación' THEN 'grabación'
   WHEN event_id ~ 'Herp' OR event_id ~ '^ANH_[0-9]{1,3}_A_' THEN 'accidental (otro grupo)'
   WHEN sampling_protocol='Captura manual' THEN 'accidental' 
   WHEN sampling_protocol~'^Encuentro ?$' THEN 'accidental' 
   WHEN sampling_protocol='Trampa pitfall' THEN 'accidental (pitfall)'
 END metodo,
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_M_[RS]([0-9]{1,3})(_T2)?$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_M_[RS]([0-9]{1,3})(_T2)?$','\1')::int
   WHEN sampling_protocol ~ '^Punto( de)? grabación' AND event_id ~ '^ANH_[0-9]{1,3}_([0-9]{1,2})(_T2)?' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_([0-9]{1,2})(_T2)?','\1')::int
   WHEN event_id ~ '^Hotel_[0-9]' THEN REGEXP_REPLACE(event_id,'^Hotel_([0-9]).*','\1')::int
   WHEN event_id ~ 'ANH_[0-9]{1,3}_M_P_[0-9](_T2)?' THEN REGEXP_REPLACE(event_id, 'ANH_[0-9]{1,3}_M_P_([0-9])(_T2)?$', '\1')::int
   WHEN event_id ~ 'ANH_([0-9]{1,3}_)?M_CM_[0-9]_T2' THEN REGEXP_REPLACE(event_id, 'ANH_([0-9]{1,3}_)?M_CM_([0-9])(_T2)?$', '\2')::int
   ELSE NULL
 END repli,
 CASE
   WHEN event_id ~ 'T2$' THEN 'T2'
   ELSE 'T1'
 END tempo,
  cd_pt_ref
FROM raw_dwc.mamiferos_tot_event
), campaign AS(
SELECT tempo, anh_name, ROW_NUMBER() OVER (PARTITION BY anh_name ORDER BY tempo) campaign_nb
FROM a
GROUP BY tempo, anh_name
ORDER BY tempo, anh_name
)
SELECT 'mami',
  CASE
    WHEN metodo~'accidental' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Accidental encounter')
    WHEN metodo='niebla' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Mist nets')
    WHEN metodo='sherman' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Sherman trap')
    WHEN metodo='grabación' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Sound recording')
  END cd_protocol,
  cd_pt_ref,
  c.campaign_nb
FROM a
LEFT JOIN campaign c ON c.tempo=a.tempo AND (c.anh_name=a.anh_name OR (c.anh_name IS NULL AND a.anh_name IS NULL))
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
GROUP BY cd_pt_ref, name_pt_ref, a.tempo, metodo, c.campaign_nb
ORDER BY a.tempo,cd_pt_ref,cd_protocol
RETURNING cd_gp_event,cd_gp_biol,cd_protocol,cd_pt_ref,campaign_nb,subpart
;
```

Attributing the gp_event

``` sql
ALTER TABLE raw_dwc.mamiferos_tot_event ADD COLUMN cd_gp_event int REFERENCES main.gp_event(cd_gp_event) ON DELETE SET NULL;


WITH a AS(
SELECT 
  event_id,
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_.*' THEN REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_.*','\1')
   WHEN event_id ~ '^ANH_[0-9]{1,3}$' THEN event_id
   WHEN event_id ~ '[Hh]otel' THEN 'Hotel'
 END anh_name,
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_.*' THEN REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_.*','\1')::int
   WHEN event_id ~ '^ANH_[0-9]{1,3}$' THEN REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})$','\1')::int
   ELSE NULL
 END anh_num,
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_M_[RS][0-9]{1,3}(_T2)?$' AND sampling_protocol='Red niebla' THEN 'niebla'
   WHEN event_id ~ '^ANH_[0-9]{1,3}_M_[RS][0-9]{1,3}(_T2)?$' AND sampling_protocol='Trampa Sherman' THEN 'sherman'
   WHEN sampling_protocol ~ '^Punto( de)? grabación' THEN 'grabación'
   WHEN event_id ~ 'Herp' OR event_id ~ '^ANH_[0-9]{1,3}_A_' THEN 'accidental (otro grupo)'
   WHEN sampling_protocol='Captura manual' THEN 'accidental' 
   WHEN sampling_protocol~'^Encuentro ?$' THEN 'accidental' 
   WHEN sampling_protocol='Trampa pitfall' THEN 'accidental (pitfall)'
 END metodo,
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_M_[RS]([0-9]{1,3})(_T2)?$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_M_[RS]([0-9]{1,3})(_T2)?$','\1')::int
   WHEN sampling_protocol ~ '^Punto( de)? grabación' AND event_id ~ '^ANH_[0-9]{1,3}_([0-9]{1,2})(_T2)?' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_([0-9]{1,2})(_T2)?','\1')::int
   WHEN event_id ~ '^Hotel_[0-9]' THEN REGEXP_REPLACE(event_id,'^Hotel_([0-9]).*','\1')::int
   WHEN event_id ~ 'ANH_[0-9]{1,3}_M_P_[0-9](_T2)?' THEN REGEXP_REPLACE(event_id, 'ANH_[0-9]{1,3}_M_P_([0-9])(_T2)?$', '\1')::int
   WHEN event_id ~ 'ANH_([0-9]{1,3}_)?M_CM_[0-9]_T2' THEN REGEXP_REPLACE(event_id, 'ANH_([0-9]{1,3}_)?M_CM_([0-9])(_T2)?$', '\2')::int
   ELSE NULL
 END repli,
 CASE
   WHEN event_id ~ 'T2$' THEN 'T2'
   ELSE 'T1'
 END tempo,
  cd_pt_ref
FROM raw_dwc.mamiferos_tot_event
), campaign AS(
SELECT tempo, anh_name, ROW_NUMBER() OVER (PARTITION BY anh_name ORDER BY tempo) campaign_nb
FROM a
GROUP BY tempo, anh_name
ORDER BY tempo, anh_name
),b AS(
SELECT event_id,
  CASE
    WHEN metodo~'accidental' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Accidental encounter')
    WHEN metodo='niebla' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Mist nets')
    WHEN metodo='sherman' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Sherman trap')
    WHEN metodo='grabación' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Sound recording')
  END cd_protocol,
  cd_pt_ref,
  c.campaign_nb
FROM a
LEFT JOIN campaign c ON c.tempo=a.tempo AND (c.anh_name=a.anh_name OR (c.anh_name IS NULL AND a.anh_name IS NULL))
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
),d AS(
SELECT b.*, cd_gp_event
FROM b
LEFT JOIN main.gp_event ge ON cd_gp_biol='mami' AND b.cd_protocol=ge.cd_protocol AND ((b.cd_pt_ref=ge.cd_pt_ref) OR (b.cd_pt_ref IS NULL AND ge.cd_pt_ref IS NULL)) AND b.campaign_nb=ge.campaign_nb 
)
UPDATE raw_dwc.mamiferos_tot_event e
SET cd_gp_event=d.cd_gp_event
FROM d
WHERE d.event_id=e.event_id
RETURNING e.event_id, e.cd_gp_event
;

SELECT event_id
FROM raw_dwc.mamiferos_tot_event
WHERE cd_gp_event IS NULL;
```

<div class="knitsql-table">

event_id ———-

: 0 records

</div>

## 9.8 event

**Aves has sampl*ing* while the others have sampl*e* in the name of the
columns**

**Existen rangos de horas que utilizan ‘-’ como separador en lugar de
‘/’**

**En las grabaciones del hotel una fecha no tiene el milenario
(‘2022-03-19/22-04-08’)**

**Acá voy a reemplazar la hora inicial de los Sherman por 18:00:00 en
lugar de 07:00:00 porque me parece que las trampas funcionan durante la
noche, me parece que la hora indicada es la hora final**

**las grabaciones no tienen hora final… voy a considerar que la hora +
tiempo de grabación da la hora final**

``` sql
SELECT event_id, event_time
FROM raw_dwc.mamiferos_tot_event
WHERE event_time ~ '-';
```

<div class="knitsql-table">

| event_id        | event_time        |
|:----------------|:------------------|
| ANH_75_M_R01_T2 | 18:15:00-20:30:00 |
| ANH_75_M_R02_T2 | 18:15:00-20:30:00 |
| ANH_75_M_R03_T2 | 18:15:00-20:30:00 |
| ANH_75_M_R04_T2 | 18:15:00-20:30:00 |
| ANH_75_M_R05_T2 | 18:15:00-20:30:00 |
| ANH_75_M_R06_T2 | 18:15:00-20:30:00 |
| ANH_75_M_R07_T2 | 18:15:00-20:30:00 |
| ANH_75_M_R08_T2 | 18:15:00-20:30:00 |
| ANH_75_M_R09_T2 | 18:15:00-20:30:00 |
| ANH_75_M_R10_T2 | 18:15:00-20:30:00 |

10 records

</div>

``` sql
INSERT INTO main.event(cd_gp_event,event_id,num_replicate, description_replicate, date_time_begin, date_time_end, locality_verb, event_remarks, samp_effort_1, samp_effort_2, pt_geom)
WITH a AS(
SELECT cd_gp_event,
  event_id, 
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_.*' THEN REGEXP_REPLACE(event_id,'^(ANH_[0-9]{1,3})_.*','\1')
   WHEN event_id ~ '^ANH_[0-9]{1,3}$' THEN event_id
   WHEN event_id ~ '[Hh]otel' THEN 'Hotel'
 END anh_name,
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_.*' THEN REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})_.*','\1')::int
   WHEN event_id ~ '^ANH_[0-9]{1,3}$' THEN REGEXP_REPLACE(event_id,'^ANH_([0-9]{1,3})$','\1')::int
   ELSE NULL
 END anh_num,
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_M_[RS][0-9]{1,3}(_T2)?$' AND sampling_protocol='Red niebla' THEN 'niebla'
   WHEN event_id ~ '^ANH_[0-9]{1,3}_M_[RS][0-9]{1,3}(_T2)?$' AND sampling_protocol='Trampa Sherman' THEN 'sherman'
   WHEN sampling_protocol ~ '^Punto( de)? grabación' THEN 'grabación'
   WHEN event_id ~ 'Herp' OR event_id ~ '^ANH_[0-9]{1,3}_A_' THEN 'accidental (otro grupo)'
   WHEN sampling_protocol='Captura manual' THEN 'accidental' 
   WHEN sampling_protocol~'^Encuentro ?$' THEN 'accidental' 
   WHEN sampling_protocol='Trampa pitfall' THEN 'accidental (pitfall)'
 END metodo,
 CASE
   WHEN event_id ~ '^ANH_[0-9]{1,3}_M_[RS]([0-9]{1,3})(_T2)?$' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_M_[RS]([0-9]{1,3})(_T2)?$','\1')::int
   WHEN sampling_protocol ~ '^Punto( de)? grabación' AND event_id ~ '^ANH_[0-9]{1,3}_([0-9]{1,2})(_T2)?' THEN REGEXP_REPLACE(event_id,'^ANH_[0-9]{1,3}_([0-9]{1,2})(_T2)?','\1')::int
   WHEN event_id ~ '^Hotel_[0-9]' THEN REGEXP_REPLACE(event_id,'^Hotel_([0-9]).*','\1')::int
   WHEN event_id ~ 'ANH_[0-9]{1,3}_M_P_[0-9](_T2)?' THEN REGEXP_REPLACE(event_id, 'ANH_[0-9]{1,3}_M_P_([0-9])(_T2)?$', '\1')::int
   WHEN event_id ~ 'ANH_([0-9]{1,3}_)?M_CM_[0-9]_T2' THEN REGEXP_REPLACE(event_id, 'ANH_([0-9]{1,3}_)?M_CM_([0-9])(_T2)?$', '\2')::int
   ELSE NULL
 END repli,
 CASE
   WHEN event_id ~ 'T2$' THEN 'T2'
   ELSE 'T1'
 END tempo,
  TO_DATE(SPLIT_PART(event_date,'/',1), 'YYYY-MM-DD') date_1,
  CASE 
    WHEN SPLIT_PART(event_date,'/',2)='' THEN NULL
    WHEN SPLIT_PART(event_date,'/',2) ~ '^[0-9]{2}-[0-9]{2}-[0-9]{2}$' THEN TO_DATE('20'||SPLIT_PART(event_date,'/',2), 'YYYY-MM-DD')

    ELSE TO_DATE(SPLIT_PART(event_date,'/',2), 'YYYY-MM-DD')
  END date_2,
  REGEXP_REPLACE(SPLIT_PART(REGEXP_REPLACE(event_time,'-','/'),'/',1),'\s+','','g')::time hora_1,
  CASE
    WHEN REGEXP_REPLACE(SPLIT_PART(REGEXP_REPLACE(event_time,'-','/'),'/',2),'\s+','','g')='' THEN NULL
    ELSE REGEXP_REPLACE(SPLIT_PART(REGEXP_REPLACE(event_time,'-','/'),'/',2),'\s+','','g')::time
  END hora_2,
  locality locality_verb,
  sample_size_value,
  --sampling_size_value,
  sample_size_unit,
  --sampling_size_unit,
  sampling_effort,
  REGEXP_REPLACE(REGEXP_REPLACE(event_remarks, '\|? ?No hay registros de individuos ?',''),'\|? ?No se registran individuos','') event_remarks,
  --locality_remarks,
  decimal_latitude::double precision,
  decimal_longitude::double precision
FROM raw_dwc.mamiferos_tot_event
),b AS(--calculation of timestamps, coordinates and num_replicate
SELECT 
  cd_gp_event,
  event_id, 
  ROW_NUMBER() OVER (PARTITION BY cd_gp_event ORDER BY repli) num_replicate,
  CASE
  WHEN metodo='niebla' THEN 'R'||repli::text
  WHEN metodo='sherman' THEN 'S'||repli::text
    ELSE repli::text
  END description_replicate,
  CASE
    WHEN metodo = 'sherman' AND hora_1<'18:00:00' THEN (date_1||' '||'18:00:00')::timestamp
    WHEN date_1 IS NULL OR hora_1 IS NULL THEN NULL
    ELSE (date_1||' '||hora_1)::timestamp 
  END date_time_begin,
  CASE
    WHEN metodo='grabación' AND sampling_effort IS NOT NULL THEN ((date_1||' '||hora_1)::timestamp) + (REGEXP_REPLACE(REGEXP_REPLACE(sampling_effort,'[mM]inutos?','minutes'),'[Hh]oras?','hours'))::interval
    WHEN metodo='sherman' THEN (date_2||' '||hora_1)::timestamp
    WHEN date_2 IS NULL AND hora_2 IS NOT NULL THEN (date_1||' '||hora_2)::timestamp
    WHEN date_2 IS NOT NULL AND hora_2 IS NOT NULL THEN (date_2||' '||hora_2)::timestamp
    --WHEN date_2 IS NULL AND (date_1||' '||hora_2)::timestamp::time='00:00'::time THEN ((date_1::date)+1 ||' '||hora_2)::timestamp
  END date_time_end,
  locality_verb,
  event_remarks ,
  --sampling_size_value,
  sample_size_value,
  --sampling_size_unit,
  sample_size_unit,
  sampling_effort,
  ST_SetSRID(ST_Transform(ST_SetSRID(ST_MakePoint(decimal_longitude,decimal_latitude),4326),(SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)),3116) pt_geom
FROM a
LEFT JOIN main.gp_event USING (cd_gp_event)
LEFT JOIN main.def_protocol p USING (cd_protocol)
ORDER BY cd_gp_event, event_id, num_replicate
)--calculation of sampling efforts and modification of existing event_id
SELECT
  cd_gp_event,
  CASE
    WHEN event_id ~ 'Herp' THEN 'mami_'||event_id
    ELSE event_id
  END event_id,
  num_replicate,
  description_replicate,
  date_time_begin,
  date_time_end,
  locality_verb,
  event_remarks,
  CASE
   WHEN protocol='Accidental encounter' THEN NULL::double precision
   WHEN protocol='Mist nets' THEN sample_size_value::double precision
   WHEN protocol='Sherman trap' AND sample_size_value='1 trampa x 5 noches' THEN 5::double precision
   WHEN protocol='Sound recording' AND sampling_effort IS NOT NULL THEN EXTRACT(EPOCH FROM REGEXP_REPLACE(REGEXP_REPLACE(sampling_effort,'[mM]inutos?','minutes'),'[Hh]oras?','hours')::interval)/60
  END samp_eff_1,
  CASE
    WHEN protocol='Mist nets' THEN EXTRACT(EPOCH FROM (date_time_end-date_time_begin))/60
  END samp_eff_2,
  pt_geom
FROM b
LEFT JOIN main.gp_event USING (cd_gp_event)
LEFT JOIN main.def_protocol p USING (cd_protocol)
ORDER BY cd_gp_event, event_id, num_replicate

RETURNING main.event.cd_event, main.event.cd_gp_event, main.event.event_id, main.event.num_replicate, main.event.description_replicate, main.event.date_time_begin, main.event.date_time_end, main.event.locality_verb, main.event.event_remarks, main.event.pt_geom
```

Damos los cd_event a todos las filas:

``` sql
ALTER TABLE raw_dwc.mamiferos_tot_event ADD COLUMN cd_event int REFERENCES main.event(cd_event) ON DELETE SET NULL;
ALTER TABLE raw_dwc.mamiferos_tot_registros ADD COLUMN cd_event int REFERENCES main.event(cd_event);

UPDATE raw_dwc.mamiferos_tot_event AS t
SET cd_event=e.cd_event
FROM main.event e
WHERE t.event_id=REGEXP_REPLACE(e.event_id,'^mami_','') AND e.cd_gp_event IN (SELECT cd_gp_event FROM main.gp_event WHERE cd_gp_biol='mami');

UPDATE raw_dwc.mamiferos_tot_registros AS t
SET cd_event=e.cd_event
FROM main.event e
WHERE t.event_id=REGEXP_REPLACE(e.event_id,'^mami_','') AND e.cd_gp_event IN (SELECT cd_gp_event FROM main.gp_event WHERE cd_gp_biol='mami');

SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

### 9.8.1 Añadir información temporal faltante

Casos donde date_time_begin está NULL pero la fecha es disponible:

``` sql
INSERT INTO main.event_extra(cd_event, cd_var_event_extra,value_text)
WITH a AS(
SELECT cd_event,ef.date_time_begin,ef.date_time_end, event_time, event_date,
  TO_DATE(SPLIT_PART(event_date,'/',1), 'YYYY-MM-DD') date_1,
  TO_DATE(SPLIT_PART(event_date,'/',2), 'YYYY-MM-DD') date_2
FROM raw_dwc.mamiferos_tot_event e
LEFT JOIN main.event ef USING (cd_event)
WHERE date_time_begin IS NULL
),b AS(
SELECT cd_event,
  CASE
   WHEN date_time_begin IS NULL THEN date_1
   ELSE NULL
  END date_begin
FROM a
)
SELECT 
 cd_event,
 (SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin'),
 to_char(date_begin,'yyyy-mm-dd')::text
FROM b
WHERE date_begin IS NOT NULL
RETURNING main.event_extra.cd_event, main.event_extra.cd_var_event_extra, main.event_extra.value_text
;
INSERT INTO main.event_extra(cd_event, cd_var_event_extra,value_text)
WITH a AS(
SELECT cd_event,ef.date_time_begin,ef.date_time_end,event_time, event_date,
TO_DATE(SPLIT_PART(event_date,'/',2), 'YYYY-MM-DD')::date date_2
FROM raw_dwc.mamiferos_tot_event e
LEFT JOIN main.event ef USING (cd_event)
WHERE date_time_begin IS NULL OR date_time_end IS NULL
),b AS(
SELECT cd_event,
  CASE
   WHEN date_time_end IS NULL AND EXTRACT(YEAR FROM date_2)>1 THEN date_2
   ELSE NULL
  END date_end
FROM a
)
SELECT 
 cd_event,
 (SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_end'),
 to_char(date_end,'yyyy-mm-dd')::text
FROM b
WHERE date_end IS NOT NULL
RETURNING main.event_extra.cd_event, main.event_extra.cd_var_event_extra, main.event_extra.value_text
;
```

## 9.9 registros

``` sql
SELECT occurrence_id, count(*)
FROM raw_dwc.mamiferos_tot_registros 
GROUP BY occurrence_id
HAVING count(*)>1;
```

<div class="knitsql-table">

occurrence_id count ————— ——-

: 0 records

</div>

**Parece que la fechas y horas en registros tienen sentido, ahora hay
que notar que tuvé que corregir el formato de las horas de las redes de
nieblas**

``` sql
SELECT e.event_id, e.event_date date_event, r.event_date date_registro, e.event_time time_event, r.event_time time_registro
FROM raw_dwc.mamiferos_tot_registros r
LEFT JOIN raw_dwc.mamiferos_tot_event e USING(cd_event)
ORDER BY r.event_date, r.event_time
```

<div class="knitsql-table">

| event_id     | date_event            | date_registro | time_event        | time_registro |
|:-------------|:----------------------|:--------------|:------------------|:--------------|
| Hotel_1AA    | 2021-07-06/2021-08-05 | 2021-07-06    | 00:00:00          | 00:40:00      |
| ANH_92_M_R9  | 2021-07-06            | 2021-07-06    | 18:00:00/21:00:00 | 18:40:00      |
| ANH_92_M_R2  | 2021-07-06            | 2021-07-06    | 18:00:00/21:00:00 | 19:13:00      |
| ANH_92_M_R2  | 2021-07-06            | 2021-07-06    | 18:00:00/21:00:00 | 19:40:00      |
| ANH_92_M_R8  | 2021-07-06            | 2021-07-06    | 18:00:00/21:00:00 | 19:41:00      |
| ANH_92_M_R8  | 2021-07-06            | 2021-07-06    | 18:00:00/21:00:00 | 19:41:00      |
| ANH_92_M_R8  | 2021-07-06            | 2021-07-06    | 18:00:00/21:00:00 | 20:15:00      |
| ANH_92_M_R10 | 2021-07-06            | 2021-07-06    | 18:00:00/21:00:00 | 20:15:00      |
| ANH_92_M_R10 | 2021-07-06            | 2021-07-06    | 18:00:00/21:00:00 | 20:15:00      |
| ANH_92_M_R8  | 2021-07-06            | 2021-07-06    | 18:00:00/21:00:00 | 21:41:00      |
| ANH_92_M_R7  | 2021-07-06            | 2021-07-06    | 18:00:00/21:00:00 | 21:41:00      |
| ANH_92_M_R2  | 2021-07-06            | 2021-07-06    | 18:00:00/21:00:00 | 21:45:00      |
| Hotel_1AA    | 2021-07-06/2021-08-05 | 2021-07-06    | 00:00:00          | 23:40:00      |
| ANH_92_1     | 2021-07-07            | 2021-07-07    | 18:29:00          | 18:29:00      |
| ANH_92_1     | 2021-07-07            | 2021-07-07    | 18:29:00          | 18:29:00      |
| ANH_92_1     | 2021-07-07            | 2021-07-07    | 18:29:00          | 18:30:00      |
| ANH_92_1     | 2021-07-07            | 2021-07-07    | 18:29:00          | 18:31:00      |
| ANH_92_1     | 2021-07-07            | 2021-07-07    | 18:29:00          | 18:32:00      |
| ANH_92_1     | 2021-07-07            | 2021-07-07    | 18:29:00          | 18:33:00      |
| ANH_92_1     | 2021-07-07            | 2021-07-07    | 18:29:00          | 18:34:00      |
| ANH_92_1     | 2021-07-07            | 2021-07-07    | 18:29:00          | 18:34:00      |
| ANH_92_2     | 2021-07-07            | 2021-07-07    | 18:35:00          | 18:36:00      |
| ANH_92_1     | 2021-07-07            | 2021-07-07    | 18:29:00          | 18:36:00      |
| ANH_92_2     | 2021-07-07            | 2021-07-07    | 18:35:00          | 18:36:00      |
| ANH_92_2     | 2021-07-07            | 2021-07-07    | 18:35:00          | 18:36:00      |
| ANH_92_2     | 2021-07-07            | 2021-07-07    | 18:35:00          | 18:36:00      |
| ANH_92_3     | 2021-07-07            | 2021-07-07    | 18:43:00          | 18:43:00      |
| ANH_92_3     | 2021-07-07            | 2021-07-07    | 18:43:00          | 18:43:00      |
| ANH_92_3     | 2021-07-07            | 2021-07-07    | 18:43:00          | 18:44:00      |
| ANH_92_3     | 2021-07-07            | 2021-07-07    | 18:43:00          | 18:44:00      |
| ANH_92_4     | 2021-07-07            | 2021-07-07    | 18:59:00          | 18:59:00      |
| ANH_92_M_R17 | 2021-07-07            | 2021-07-07    | 18:00:00/21:00:00 | 20:00:00      |
| ANH_92_M_R16 | 2021-07-07            | 2021-07-07    | 18:00:00/21:00:00 | 20:00:00      |
| ANH_92_M_R19 | 2021-07-07            | 2021-07-07    | 18:00:00/21:00:00 | 20:50:00      |
| ANH_92_M_R15 | 2021-07-07            | 2021-07-07    | 18:00:00/21:00:00 | 21:20:00      |
| ANH_92_M_R14 | 2021-07-07            | 2021-07-07    | 18:00:00/21:00:00 | 21:20:00      |
| ANH_92_M_R19 | 2021-07-07            | 2021-07-07    | 18:00:00/21:00:00 | 21:30:00      |
| ANH_92_M_R18 | 2021-07-07            | 2021-07-07    | 18:00:00/21:00:00 | 21:30:00      |
| ANH_96_M_R26 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 18:48:00      |
| ANH_96_M_R25 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 18:50:00      |
| ANH_96_M_R21 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 18:50:00      |
| ANH_96_M_R21 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 18:50:00      |
| ANH_96_M_R25 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 18:50:00      |
| ANH_96_M_R25 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 18:50:00      |
| ANH_96_M_R25 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 18:50:00      |
| ANH_96_M_R25 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 18:50:00      |
| ANH_96_M_R25 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 18:50:00      |
| ANH_96_M_R25 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 18:50:00      |
| ANH_96_M_R25 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 19:00:00      |
| ANH_96_M_R28 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 19:00:00      |
| ANH_96_M_R27 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 19:00:00      |
| ANH_96_M_R26 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 19:08:00      |
| ANH_96_M_R21 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 19:10:00      |
| ANH_96_M_R26 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 19:13:00      |
| ANH_96_M_R27 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 19:16:00      |
| ANH_96_M_R28 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 19:20:00      |
| ANH_96_M_R25 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 19:25:00      |
| ANH_96_M_R25 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 19:35:00      |
| ANH_96_M_R29 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 19:35:00      |
| ANH_96_M_R26 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 19:40:00      |
| ANH_96_M_R22 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 19:42:00      |
| ANH_96_M_R25 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 19:45:00      |
| ANH_96_M_R25 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 19:46:00      |
| ANH_96_M_R25 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 20:20:00      |
| ANH_96_M_R21 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 20:30:00      |
| ANH_96_M_R21 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 20:30:00      |
| ANH_96_M_R23 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 20:47:00      |
| ANH_96_M_R28 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 20:51:00      |
| ANH_96_M_R29 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 21:20:00      |
| ANH_96_M_R25 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 21:30:00      |
| ANH_96_M_R25 | 2021-07-08            | 2021-07-08    | 18:00:00/21:00:00 | 21:30:00      |
| ANH_240_A_R  | 2021-07-09            | 2021-07-09    | 05:50:00/11:00:00 | 00:00:00      |
| ANH_96_1     | 2021-07-09            | 2021-07-09    | 18:51:00          | 18:52:00      |
| ANH_96_1     | 2021-07-09            | 2021-07-09    | 18:51:00          | 18:53:00      |
| ANH_96_1     | 2021-07-09            | 2021-07-09    | 18:51:00          | 18:54:00      |
| ANH_96_2     | 2021-07-09            | 2021-07-09    | 18:58:00          | 18:58:32      |
| ANH_96_2     | 2021-07-09            | 2021-07-09    | 18:58:00          | 18:58:47      |
| ANH_96_2     | 2021-07-09            | 2021-07-09    | 18:58:00          | 18:59:00      |
| ANH_96_2     | 2021-07-09            | 2021-07-09    | 18:58:00          | 18:59:24      |
| ANH_96_2     | 2021-07-09            | 2021-07-09    | 18:58:00          | 18:59:29      |
| ANH_96_2     | 2021-07-09            | 2021-07-09    | 18:58:00          | 18:59:29      |
| ANH_96_2     | 2021-07-09            | 2021-07-09    | 18:58:00          | 18:59:37      |
| ANH_96_M_R36 | 2021-07-09            | 2021-07-09    | 18:00:00/21:00:00 | 19:00:00      |
| ANH_96_2     | 2021-07-09            | 2021-07-09    | 18:58:00          | 19:00:00      |
| ANH_96_M_R31 | 2021-07-09            | 2021-07-09    | 18:00:00/21:00:00 | 19:02:00      |
| ANH_96_M_R31 | 2021-07-09            | 2021-07-09    | 18:00:00/21:00:00 | 19:02:00      |
| ANH_96_M_R33 | 2021-07-09            | 2021-07-09    | 18:00:00/21:00:00 | 19:10:00      |
| ANH_96_M_R31 | 2021-07-09            | 2021-07-09    | 18:00:00/21:00:00 | 19:10:00      |
| ANH_96_M_R32 | 2021-07-09            | 2021-07-09    | 18:00:00/21:00:00 | 19:14:00      |
| ANH_96_3     | 2021-07-09            | 2021-07-09    | 19:16:00          | 19:16:00      |
| ANH_96_3     | 2021-07-09            | 2021-07-09    | 19:16:00          | 19:17:00      |
| ANH_96_M_R39 | 2021-07-09            | 2021-07-09    | 18:00:00/21:00:00 | 19:36:00      |
| ANH_96_M_R34 | 2021-07-09            | 2021-07-09    | 18:00:00/21:00:00 | 19:36:00      |
| ANH_96_M_R39 | 2021-07-09            | 2021-07-09    | 18:00:00/21:00:00 | 19:36:00      |
| ANH_96_M_R39 | 2021-07-09            | 2021-07-09    | 18:00:00/21:00:00 | 19:36:00      |
| ANH_96_M_R40 | 2021-07-09            | 2021-07-09    | 18:00:00/21:00:00 | 19:36:00      |
| ANH_96_M_R32 | 2021-07-09            | 2021-07-09    | 18:00:00/21:00:00 | 19:40:00      |
| ANH_96_M_R32 | 2021-07-09            | 2021-07-09    | 18:00:00/21:00:00 | 19:40:00      |
| ANH_96_M_R32 | 2021-07-09            | 2021-07-09    | 18:00:00/21:00:00 | 19:40:00      |
| ANH_96_M_R38 | 2021-07-09            | 2021-07-09    | 18:00:00/21:00:00 | 19:52:00      |

Displaying records 1 - 100

</div>

**Hay formatos de horas raras**:

``` sql
SELECT event_id, occurrence_id,event_time FROM raw_dwc.mamiferos_tot_registros WHERE event_time ~ '\.'
```

<div class="knitsql-table">

| event_id    | occurrence_id                                                                | event_time |
|:------------|:-----------------------------------------------------------------------------|:-----------|
| ANH_66_2_T2 | IAvH:SSCPE-ANH:SANTANDER:ANIMALIA:OBSERVACIONCONMAQUINA:I2D-BIO_2021_094:517 | 18.27:42   |
| ANH_66_2_T2 | IAvH:SSCPE-ANH:SANTANDER:ANIMALIA:OBSERVACIONCONMAQUINA:I2D-BIO_2021_094:518 | 18.27:42   |
| ANH_66_2_T2 | IAvH:SSCPE-ANH:SANTANDER:ANIMALIA:OBSERVACIONCONMAQUINA:I2D-BIO_2021_094:519 | 18.27:42   |
| ANH_96_3_T2 | IAvH:SSCPE-ANH:SANTANDER:ANIMALIA:OBSERVACIONCONMAQUINA:I2D-BIO_2021_094:856 | 18.45:27   |

4 records

</div>

**Parece que hay una codificación de los organism_id, pero hay
repeticiones y organism_id faltantes**

(anotar que la columna no existe en el archivo de ultrasonidos)

``` sql
SELECT organism_id,count(*)
FROM raw_dwc.mamiferos_tot_registros 
GROUP BY organism_id               
HAVING count(*) > 1
;
```

<div class="knitsql-table">

| organism_id | count |
|:------------|------:|
| NA          |   973 |
| B205        |     3 |
| A565        |     2 |
| B67         |     2 |
| B1-386      |     2 |
| A443        |     2 |
| B1-167      |     2 |
| A8          |     2 |
| B316        |     2 |
| A586        |     2 |
| B12         |     2 |
| B170        |     2 |
| A612        |     2 |
| B1-507      |     2 |
| A396        |     2 |
| B627        |     2 |
| 0           |     2 |
| B1-506      |     2 |
| B584        |     2 |
| A4          |     2 |
| A628        |     2 |
| A6          |     2 |
| A648        |     2 |
| B70         |     2 |
| B583        |     2 |
| B529        |     2 |
| A205        |     2 |
| A198        |     2 |
| A1056       |     2 |
| A839        |     2 |
| B169        |     2 |
| A569        |     2 |
| B507        |     2 |
| A184        |     2 |
| A590        |     2 |
| B1-115      |     2 |
| A682        |     2 |
| B1-168      |     2 |
| A210        |     2 |
| B430        |     2 |
| A620        |     2 |
| B168        |     2 |
| A18         |     2 |
| B1-404      |     2 |
| B17         |     2 |
| A9          |     2 |
| B560        |     2 |
| B13         |     2 |
| B1-398      |     2 |
| A33         |     2 |
| B1-166      |     2 |
| A757        |     2 |
| B1-163      |     3 |
| A300        |     2 |
| A589        |     2 |
| B2-109      |     2 |
| B1-165      |     2 |
| B104        |     2 |
| B200        |     2 |
| B10         |     2 |
| A575        |     2 |
| B628        |     2 |
| B1-399      |     2 |
| B1-164      |     2 |
| B174        |     2 |
| A584        |     2 |
| A576        |     2 |
| B633        |     2 |
| A1049       |     2 |

69 records

</div>

Lo que voy a hacer es:

- extraer el id del occurrence_id para poner un occurrence_id cuando no
  haya
- contar las replicationes de occurrence_id iguales y poner \_rep$$0-9$$
  a las repeticiones
- guardar los occurrence_id que no presentan problemas

**eventRemarks esta pensado como el event_id, pero a veces no
corresponden (es importante averiguar que el verdadero eventID no es lo
que está escrito en event_remarks!**

``` sql
SELECT event_id,occurrence_remarks, event_remarks FROM raw_dwc.mamiferos_tot_registros WHERE event_id!=event_remarks;
```

<div class="knitsql-table">

| event_id          | occurrence_remarks                                                                       | event_remarks     |
|:------------------|:-----------------------------------------------------------------------------------------|:------------------|
| ANH_240_A_R       | Colectado por equipo de Aves 12-jul-2021.                                                | ANH_64_M_R        |
| ANH_153_Herp_T1_D | Capturado por herpetos                                                                   | ANH_155_Herp_T1_D |
| ANH_76_M_R50      | NA                                                                                       | ANH_76_M_R40      |
| ANH_98_M_R93      | NA                                                                                       | ANH_98_M_R3       |
| ANH_90_M_R111     | NA                                                                                       | ANH_90_M_R11      |
| ANH_103_M_R9      | NA                                                                                       | ANH_103_M_R       |
| ANH_75_M_R130     | NA                                                                                       | ANH_75_M_R120     |
| ANH_75_M_R140     | NA                                                                                       | ANH_75_M_R146     |
| ANH_78_M_R159     | NA                                                                                       | ANH_78_M_R149     |
| ANH_103_M_R14_T2  | Cargaba cría \| Plataforma Kalé                                                          | ANH_103_M_R19_T2  |
| ANH_97_M_R05_T2   | Plataforma Platero                                                                       | ANH_97_M_R5_T2    |
| ANH_97_M_R18_T2   | Plataforma Platero/ no fue posible identificar el punto de muestreo asociado             | ANH_97_M          |
| ANH_71_M_R01_T2   | Plataforma Platero                                                                       | ANH_71_M_T2       |
| ANH_71_M_R01_T2   | Plataforma Platero/ no fue posible identificar el punto de muestreo asociado             | ANH_71_M_R01_T3   |
| ANH_166_M_CM_1_T2 | Colecta \| Captura manual por grupo Herpetos, entre herbazal y bosque \| Plataforma Kalé | ANH_166_M_CM_1    |
| ANH_98_M_R20_T2   | Recaptura \| Plataforma Kalé                                                             | ANH_98_M_R10_T2   |
| ANH_76_M_R04_T2   | Plataforma Kalé                                                                          | ANH_76_M_R05_T2   |

17 records

</div>

``` sql
INSERT INTO main.registros(cd_event, cds_recorded_by, date_time, cd_tax, cd_morfo, date_ident, cds_identified_by, qt_int,remarks, occurrence_id, organism_id)
SELECT 
 cd_event,
 cds_recorded_by,
 CASE 
   WHEN event_date IS NULL OR event_time IS NULL THEN NULL
   WHEN event_time ~ '\.' THEN (event_date||' '||REGEXP_REPLACE(event_time,'\.',':'))::timestamp
   WHEN event_time ~ '/' THEN (event_date||' '||SPLIT_PART(event_time,'/',1))::timestamp
   ELSE (event_date||' '||event_time)::timestamp 
 END date_time,
 tt.cd_tax,
 tt.cd_morfo,
 TO_DATE(date_identified,'YYYY-MM-DD') date_ident,
 cds_identified_by,
 CASE
  WHEN var_qt_ind ='Occurrence' AND organism_quantity IS NULL THEN 1
  ELSE organism_quantity::double precision::int 
 END qt_int,
 occurrence_remarks remarks,
 --r.event_remarks remarks,
 r.occurrence_id,
 --SPLIT_PART(occurrence_id,':',7) organism_id
 --ROW_NUMBER() OVER (ORDER BY (e.date_time_begin::date||' '||event_time)::timestamp)
 --organism_id,
 CASE 
  WHEN organism_id IS NULL OR organism_id=' *' THEN SPLIT_PART(occurrence_id,':',7)::text
   WHEN  ROW_NUMBER() OVER (PARTITION BY organism_id ORDER BY event_date,event_time) >1 THEN organism_id||'_rep_'|| ROW_NUMBER() OVER (PARTITION BY organism_id ORDER BY event_date,event_time)  
   ELSE organism_id
 END organism_id_fin
 --ST_SetSRID(ST_Transform(ST_SetSRID(ST_MakePoint(measurement_value__longitud_,measurement_value__latitud_), 4326),  (SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)),3116)
FROM raw_dwc.mamiferos_tot_registros r
LEFT JOIN raw_dwc.taxonomy_total tt ON tt."row.names"=r."row.names" AND tt.table_orig=r.table_orig
LEFT JOIN main.event e USING (cd_event)
LEFT JOIN main.gp_event USING (cd_gp_event)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.def_var_ind_qt USING(cd_var_ind_qt)
ORDER BY date_time

RETURNING cd_event, cds_recorded_by, date_time, cd_tax, cd_morfo, cds_identified_by, qt_int,remarks, occurrence_id, organism_id
```

``` sql
ALTER TABLE raw_dwc.mamiferos_tot_registros ADD COLUMN cd_reg int REFERENCES main.registros(cd_reg);
UPDATE raw_dwc.mamiferos_tot_registros AS ar
SET cd_reg=r.cd_reg
FROM main.registros r
WHERE ar.cd_event=r.cd_event AND ar.occurrence_id=r.occurrence_id;

-- Check cd_reg are unique in the source table
SELECT cd_reg,count(*) FROM  raw_dwc.mamiferos_tot_registros GROUP BY cd_reg HAVING count(*)>1;
```

<div class="knitsql-table">

    cd_reg   count

------------------------------------------------------------------------

: 0 records

</div>

### 9.9.1 Añadir la información temporal supplementaria

``` sql

INSERT INTO main.registros_extra(cd_reg,cd_var_registros_extra,value_text)
SELECT cd_reg,
(SELECT cd_var_registros_extra FROM main.def_var_registros_extra WHERE var_registros_extra='date_time_end'),
(event_date||' '||SPLIT_PART(event_time,'/',2))::timestamp::text
FROM raw_dwc.mamiferos_tot_registros
WHERE SPLIT_PART(event_time,'/',2) != '';
```

# 10 Peces

**Peces utiliza occurrenceID como eventID en la pestaña event, yo creo
que es mala idea en caso de exportación en bases internacionales**

## 10.1 Entender el plan de muestreo

``` sql
SELECT occurrence_id,sampling_protocol
FROM raw_dwc.peces_event
WHERE occurrence_id!~'^ANH_([0-9]{1,3})_([ARET])_([DC])(_T2)?$';
```

<div class="knitsql-table">

occurrence_id sampling_protocol ————— ——————-

: 0 records

</div>

``` sql
WITH a AS(
SELECT occurrence_id,sampling_protocol,
  REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_([ARET])_([DC])(_T2)?$','\1')::int anh_num,
  REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_([ARET])_([DC])(_T2)?$','\2') metodo,
  REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_([ARET])_([DC])(_T2)?$','\3') jornada,
  CASE 
    WHEN occurrence_id ~ 'T2$' THEN 'T2'
    ELSE 'T1'
  END tempo
FROM raw_dwc.peces_event
)
SELECT  tempo, metodo,count(*)-- ARRAY_AGG(occurrence_id)
FROM a
GROUP BY tempo,metodo
ORDER BY tempo,metodo
;
```

<div class="knitsql-table">

| tempo | metodo | count |
|:------|:-------|------:|
| T1    | A      |    49 |
| T1    | E      |    25 |
| T1    | R      |    45 |
| T1    | T      |    32 |
| T2    | A      |    43 |
| T2    | E      |    28 |
| T2    | R      |    45 |
| T2    | T      |    22 |

8 records

</div>

``` sql
WITH a AS(
SELECT occurrence_id,
  REGEXP_REPLACE(occurrence_id,'^(ANH_[0-9]{1,3})_([ARET])_([DC])(_T2)?$','\1') anh_name,
  REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_([ARET])_([DC])(_T2)?$','\1')::int anh_num,
  REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_([ARET])_([DC])(_T2)?$','\2') metodo,
  REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_([ARET])_([DC])(_T2)?$','\3') jornada,
  CASE 
    WHEN occurrence_id ~ 'T2$' THEN 'T2'
    ELSE 'T1'
  END tempo
FROM raw_dwc.peces_event
)
SELECT anh_name,tempo,metodo, ARRAY_AGG(jornada ORDER BY jornada DESC),/*ARRAY_AGG(DISTINCT repli ORDER BY repli) repli,*/  count(*)
FROM a
GROUP BY anh_num,anh_name, tempo, metodo
ORDER BY anh_num IS NOT NULL,anh_num,tempo, metodo
;
```

<div class="knitsql-table">

| anh_name | tempo | metodo | array_agg | count |
|:---------|:------|:-------|:----------|------:|
| ANH_7    | T1    | A      | {D,C}     |     2 |
| ANH_7    | T1    | E      | {D,C}     |     2 |
| ANH_7    | T1    | R      | {D,C}     |     2 |
| ANH_7    | T2    | A      | {D,C}     |     2 |
| ANH_7    | T2    | E      | {D,C}     |     2 |
| ANH_7    | T2    | R      | {D,C}     |     2 |
| ANH_8    | T1    | A      | {D}       |     1 |
| ANH_8    | T1    | E      | {D}       |     1 |
| ANH_8    | T1    | R      | {D}       |     1 |
| ANH_8    | T2    | A      | {D}       |     1 |
| ANH_8    | T2    | E      | {D}       |     1 |
| ANH_8    | T2    | R      | {D}       |     1 |
| ANH_8    | T2    | T      | {D}       |     1 |
| ANH_9    | T1    | A      | {D}       |     1 |
| ANH_9    | T1    | T      | {D}       |     1 |
| ANH_9    | T2    | A      | {D}       |     1 |
| ANH_9    | T2    | T      | {D}       |     1 |
| ANH_10   | T1    | A      | {D}       |     1 |
| ANH_10   | T1    | R      | {D}       |     1 |
| ANH_10   | T1    | T      | {D}       |     1 |
| ANH_10   | T2    | A      | {D}       |     1 |
| ANH_10   | T2    | R      | {D}       |     1 |
| ANH_10   | T2    | T      | {D}       |     1 |
| ANH_11   | T1    | A      | {D}       |     1 |
| ANH_11   | T1    | R      | {D}       |     1 |
| ANH_11   | T1    | T      | {D}       |     1 |
| ANH_11   | T2    | A      | {D}       |     1 |
| ANH_11   | T2    | R      | {D}       |     1 |
| ANH_11   | T2    | T      | {D}       |     1 |
| ANH_12   | T1    | A      | {D}       |     1 |
| ANH_12   | T1    | R      | {D}       |     1 |
| ANH_12   | T1    | T      | {D}       |     1 |
| ANH_12   | T2    | A      | {D}       |     1 |
| ANH_12   | T2    | E      | {D}       |     1 |
| ANH_12   | T2    | R      | {D}       |     1 |
| ANH_13   | T1    | A      | {D}       |     1 |
| ANH_13   | T1    | R      | {D}       |     1 |
| ANH_13   | T1    | T      | {D}       |     1 |
| ANH_13   | T2    | A      | {D}       |     1 |
| ANH_13   | T2    | E      | {D}       |     1 |
| ANH_13   | T2    | R      | {D}       |     1 |
| ANH_14   | T1    | A      | {D}       |     1 |
| ANH_14   | T1    | E      | {D}       |     1 |
| ANH_14   | T1    | R      | {D}       |     1 |
| ANH_14   | T1    | T      | {D}       |     1 |
| ANH_14   | T2    | E      | {D}       |     1 |
| ANH_14   | T2    | R      | {D}       |     1 |
| ANH_15   | T1    | A      | {D}       |     1 |
| ANH_15   | T1    | R      | {D}       |     1 |
| ANH_15   | T1    | T      | {D}       |     1 |
| ANH_15   | T2    | A      | {D}       |     1 |
| ANH_15   | T2    | R      | {D}       |     1 |
| ANH_15   | T2    | T      | {D}       |     1 |
| ANH_16   | T1    | A      | {D}       |     1 |
| ANH_16   | T1    | R      | {D}       |     1 |
| ANH_16   | T1    | T      | {D}       |     1 |
| ANH_16   | T2    | A      | {D}       |     1 |
| ANH_16   | T2    | T      | {D}       |     1 |
| ANH_17   | T1    | A      | {D}       |     1 |
| ANH_17   | T1    | R      | {D}       |     1 |
| ANH_17   | T1    | T      | {D}       |     1 |
| ANH_17   | T2    | A      | {D}       |     1 |
| ANH_17   | T2    | E      | {D}       |     1 |
| ANH_18   | T1    | A      | {D}       |     1 |
| ANH_18   | T1    | R      | {D}       |     1 |
| ANH_18   | T1    | T      | {D}       |     1 |
| ANH_18   | T2    | A      | {D}       |     1 |
| ANH_18   | T2    | R      | {D}       |     1 |
| ANH_19   | T1    | A      | {D}       |     1 |
| ANH_19   | T1    | R      | {D}       |     1 |
| ANH_19   | T1    | T      | {D}       |     1 |
| ANH_19   | T2    | A      | {D}       |     1 |
| ANH_19   | T2    | R      | {D}       |     1 |
| ANH_19   | T2    | T      | {D}       |     1 |
| ANH_20   | T1    | A      | {D}       |     1 |
| ANH_20   | T1    | R      | {D}       |     1 |
| ANH_20   | T1    | T      | {D}       |     1 |
| ANH_20   | T2    | A      | {D}       |     1 |
| ANH_20   | T2    | R      | {D}       |     1 |
| ANH_20   | T2    | T      | {D}       |     1 |
| ANH_21   | T1    | A      | {D}       |     1 |
| ANH_21   | T1    | R      | {D}       |     1 |
| ANH_21   | T1    | T      | {D}       |     1 |
| ANH_21   | T2    | A      | {D}       |     1 |
| ANH_21   | T2    | R      | {D}       |     1 |
| ANH_21   | T2    | T      | {D}       |     1 |
| ANH_32   | T1    | A      | {D}       |     1 |
| ANH_32   | T1    | R      | {D}       |     1 |
| ANH_32   | T1    | T      | {D}       |     1 |
| ANH_32   | T2    | A      | {D}       |     1 |
| ANH_32   | T2    | R      | {D}       |     1 |
| ANH_32   | T2    | T      | {D}       |     1 |
| ANH_33   | T1    | A      | {D}       |     1 |
| ANH_33   | T1    | R      | {D}       |     1 |
| ANH_33   | T1    | T      | {D}       |     1 |
| ANH_33   | T2    | A      | {D}       |     1 |
| ANH_33   | T2    | R      | {D}       |     1 |
| ANH_33   | T2    | T      | {D}       |     1 |
| ANH_34   | T1    | A      | {D}       |     1 |
| ANH_34   | T1    | R      | {D}       |     1 |

Displaying records 1 - 100

</div>

## 10.2 ANH

Insertar los datos de anh:

``` sql
INSERT INTO main.punto_referencia(name_pt_ref, num_anh)
WITH a AS(
SELECT occurrence_id,
  REGEXP_REPLACE(occurrence_id,'^(ANH_[0-9]{1,3})_([ARET])_([DC])(_T2)?$','\1') anh_name,
  REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_([ARET])_([DC])(_T2)?$','\1')::int anh_num
FROM raw_dwc.peces_event
)
SELECT anh_name, anh_num
FROM a
WHERE anh_name IS NOT NULL
GROUP BY anh_name,anh_num
ORDER BY anh_num
ON CONFLICT (name_pt_ref) DO NOTHING
RETURNING cd_pt_ref, name_pt_ref
;
```

dar las referencias en las tablas totales de peces

``` sql
ALTER TABLE raw_dwc.peces_event ADD COLUMN cd_pt_ref int REFERENCES main.punto_referencia(cd_pt_ref) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE raw_dwc.peces_registros ADD COLUMN cd_pt_ref int REFERENCES main.punto_referencia(cd_pt_ref) ON DELETE SET NULL ON UPDATE CASCADE;

UPDATE raw_dwc.peces_event AS m
SET cd_pt_ref=pr.cd_pt_ref
FROM main.punto_referencia pr
WHERE REGEXP_REPLACE(m.occurrence_id,'^(ANH_[0-9]{1,3})_([ARET])_([DC])(_T2)?$','\1') = pr.name_pt_ref
;

UPDATE raw_dwc.peces_registros AS m
SET cd_pt_ref=pr.cd_pt_ref
FROM main.punto_referencia pr
WHERE REGEXP_REPLACE(m.event_id,'^(ANH_[0-9]{1,3})_([ARET])_([DC])(_T2)?$','\1') = pr.name_pt_ref
;

SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

Averiguando que ninguna fila no tenga anh

``` sql
SELECT occurrence_id FROM raw_dwc.peces_event WHERE cd_pt_ref IS NULL;
```

<div class="knitsql-table">

occurrence_id —————

: 0 records

</div>

``` sql
SELECT occurrence_id,occurrence_id FROM raw_dwc.peces_registros WHERE cd_pt_ref IS NULL;
```

<div class="knitsql-table">

occurrence_id occurrence_id ————— —————

: 0 records

</div>

## 10.3 Unit, sampling efforts definition, abundance definition, protocolo

**En peces usualmente no se anota el tiempo final, pero el tiempo
inicial y el sampling effort están muy limpios entonces es relativamente
facil calcularlos** Hay un error raro y es que en caso de electropesca,
sampling_size_unit da 1 minuto cuando sampling effort pueda ser muy
differente, voy a utilizar sampling effort

**Not sure about the vocabulary in english, particularly the difference
between dragnet and trawlnets and what would better translate redes de
arrastre in a continental set**

``` sql
INSERT INTO main.def_unit(cd_measurement_type, unit, unit_spa, abbv_unit,factor)
VALUES(
  (SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='number of traps'),
  'Number of throws',
  'Número de lances',
  'throws',
  1
  ),(
  (SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='number of traps'),
  'Number of drag nets',
  'Número de arrastres',
  'drag nets',
  1
  )
RETURNING cd_unit, unit, unit_spa
```

``` sql
INSERT INTO main.def_var_samp_eff(var_samp_eff, var_samp_eff_spa, cd_unit, type_variable)
  VALUES
    (
    'Number of throws',
    'Número de lances',
    (SELECT cd_unit FROM main.def_unit WHERE unit='Number of throws'),
    'int'
    ),(
    'Number of drag nets',
    'Número de arrastres',
    (SELECT cd_unit FROM main.def_unit WHERE unit='Number of drag nets'),
    'int'
    )

RETURNING cd_var_samp_eff,var_samp_eff;
```

``` sql
INSERT INTO main.def_protocol(protocol,protocol_spa,cd_var_samp_eff_1,cd_var_samp_eff_2,samp_eff_1_implicit,samp_eff_2_implicit,cd_var_ind_qt,description_spa)
VALUES(
  'Cast nets',
  'Atarraya',
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Number of throws'),
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Elapsed time'),
  false,
  true,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind='Number of individuals'),
  'Tal vez sería bueno añadir las caracteristicas de los artes de pesca, pero no tengo acceso a esta información'
),(
  'Drag net',
  'Arrastre',
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Number of drag nets'),
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Elapsed time'),
  false,
  true,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind='Number of individuals'),
  'Tal vez sería bueno añadir las caracteristicas de los artes de pesca, pero no tengo acceso a esta información'
),(
  'Electric fishing',
  'Electropesca',
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Elapsed time'),
  NULL,
  true,
  NULL,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind='Number of individuals'),
  NULL
),(
  'Gillnets',
  'Trasmallo',
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Elapsed time'),
  NULL,
  true,
  NULL,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind='Number of individuals'),
  NULL
)
RETURNING cd_protocol,protocol,protocol_spa;
```

## 10.4 Personas

``` sql
INSERT INTO main.people(verbatim_person)
WITH a AS(
SELECT DISTINCT INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(recorded_by, ' | ')))) AS name_person
FROM raw_dwc.peces_registros
UNION
SELECT DISTINCT INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(identified_by, ' | '))))
FROM raw_dwc.peces_registros
)
SELECT DISTINCT REGEXP_REPLACE(name_person, '- ','-')
FROM a 
ORDER BY REGEXP_REPLACE(name_person, '- ','-')
ON CONFLICT(verbatim_person) DO NOTHING
RETURNING cd_person, verbatim_person
```

Dar los codigos a las tables de origen:

``` sql
ALTER TABLE raw_dwc.peces_registros ADD COLUMN cds_recorded_by int[];

WITH a AS(
SELECT "row.names", REGEXP_REPLACE(INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(recorded_by, ' | ')))),'- ','-') AS name_person
FROM raw_dwc.peces_registros
),b AS(
SELECT "row.names", ARRAY_AGG(cd_person) cds
FROM a 
LEFT JOIN main.people p ON a.name_person=p.verbatim_person
GROUP BY "row.names"
)
UPDATE raw_dwc.peces_registros AS r
SET cds_recorded_by=b.cds
FROM b
WHERE r."row.names"=b."row.names"
RETURNING r."row.names", cds_recorded_by
;

ALTER TABLE raw_dwc.peces_registros ADD COLUMN cds_identified_by int[];

WITH a AS(
SELECT "row.names", REGEXP_REPLACE(INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(identified_by, ' | ')))),'- ','-') AS name_person
FROM raw_dwc.peces_registros
),b AS(
SELECT "row.names", ARRAY_AGG(cd_person) cds
FROM a 
LEFT JOIN main.people p ON a.name_person=p.verbatim_person
GROUP BY "row.names"
)
UPDATE raw_dwc.peces_registros AS r
SET cds_identified_by=b.cds
FROM b
WHERE r."row.names"=b."row.names"
RETURNING r."row.names", cds_identified_by
;

SELECT 1;
```

<div class="knitsql-table">

| ?column? |
|---------:|
|        1 |

1 records

</div>

## 10.5 gp_event

``` sql
WITH a AS(
SELECT 
  occurrence_id,
  REGEXP_REPLACE(occurrence_id,'^(ANH_[0-9]{1,3})_([ARET])_([DC])(_T2)?$','\1') anh_name,
  REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_([ARET])_([DC])(_T2)?$','\1')::int anh_num,
  REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_([ARET])_([DC])(_T2)?$','\2') metodo,
  REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_([ARET])_([DC])(_T2)?$','\3') jornada,
  CASE 
    WHEN occurrence_id ~ 'T2$' THEN 'T2'
    ELSE 'T1'
  END tempo
FROM raw_dwc.peces_event
)
SELECT tempo, anh_num,metodo, ARRAY_AGG(jornada), count(*)
FROM a
GROUP BY tempo, anh_num, metodo
ORDER BY tempo, anh_num, metodo
;
```

<div class="knitsql-table">

| tempo | anh_num | metodo | array_agg | count |
|:------|--------:|:-------|:----------|------:|
| T1    |       7 | A      | {D,C}     |     2 |
| T1    |       7 | E      | {D,C}     |     2 |
| T1    |       7 | R      | {D,C}     |     2 |
| T1    |       8 | A      | {D}       |     1 |
| T1    |       8 | E      | {D}       |     1 |
| T1    |       8 | R      | {D}       |     1 |
| T1    |       9 | A      | {D}       |     1 |
| T1    |       9 | T      | {D}       |     1 |
| T1    |      10 | A      | {D}       |     1 |
| T1    |      10 | R      | {D}       |     1 |
| T1    |      10 | T      | {D}       |     1 |
| T1    |      11 | A      | {D}       |     1 |
| T1    |      11 | R      | {D}       |     1 |
| T1    |      11 | T      | {D}       |     1 |
| T1    |      12 | A      | {D}       |     1 |
| T1    |      12 | R      | {D}       |     1 |
| T1    |      12 | T      | {D}       |     1 |
| T1    |      13 | A      | {D}       |     1 |
| T1    |      13 | R      | {D}       |     1 |
| T1    |      13 | T      | {D}       |     1 |
| T1    |      14 | A      | {D}       |     1 |
| T1    |      14 | E      | {D}       |     1 |
| T1    |      14 | R      | {D}       |     1 |
| T1    |      14 | T      | {D}       |     1 |
| T1    |      15 | A      | {D}       |     1 |
| T1    |      15 | R      | {D}       |     1 |
| T1    |      15 | T      | {D}       |     1 |
| T1    |      16 | A      | {D}       |     1 |
| T1    |      16 | R      | {D}       |     1 |
| T1    |      16 | T      | {D}       |     1 |
| T1    |      17 | A      | {D}       |     1 |
| T1    |      17 | R      | {D}       |     1 |
| T1    |      17 | T      | {D}       |     1 |
| T1    |      18 | A      | {D}       |     1 |
| T1    |      18 | R      | {D}       |     1 |
| T1    |      18 | T      | {D}       |     1 |
| T1    |      19 | A      | {D}       |     1 |
| T1    |      19 | R      | {D}       |     1 |
| T1    |      19 | T      | {D}       |     1 |
| T1    |      20 | A      | {D}       |     1 |
| T1    |      20 | R      | {D}       |     1 |
| T1    |      20 | T      | {D}       |     1 |
| T1    |      21 | A      | {D}       |     1 |
| T1    |      21 | R      | {D}       |     1 |
| T1    |      21 | T      | {D}       |     1 |
| T1    |      32 | A      | {D}       |     1 |
| T1    |      32 | R      | {D}       |     1 |
| T1    |      32 | T      | {D}       |     1 |
| T1    |      33 | A      | {D}       |     1 |
| T1    |      33 | R      | {D}       |     1 |
| T1    |      33 | T      | {D}       |     1 |
| T1    |      34 | A      | {D}       |     1 |
| T1    |      34 | R      | {D}       |     1 |
| T1    |      34 | T      | {D}       |     1 |
| T1    |      35 | A      | {D}       |     1 |
| T1    |      35 | R      | {D}       |     1 |
| T1    |      37 | A      | {C,D}     |     2 |
| T1    |      37 | E      | {C}       |     1 |
| T1    |      37 | R      | {C,D}     |     2 |
| T1    |      37 | T      | {D,C}     |     2 |
| T1    |      38 | A      | {D}       |     1 |
| T1    |      38 | E      | {D}       |     1 |
| T1    |      38 | R      | {D}       |     1 |
| T1    |      38 | T      | {D}       |     1 |
| T1    |      39 | A      | {C,D}     |     2 |
| T1    |      39 | E      | {C,D}     |     2 |
| T1    |      39 | R      | {D,C}     |     2 |
| T1    |      40 | A      | {D}       |     1 |
| T1    |      40 | E      | {D}       |     1 |
| T1    |      41 | A      | {D}       |     1 |
| T1    |      41 | E      | {D}       |     1 |
| T1    |      41 | R      | {D}       |     1 |
| T1    |      42 | A      | {D}       |     1 |
| T1    |      42 | R      | {D}       |     1 |
| T1    |      42 | T      | {D}       |     1 |
| T1    |      43 | A      | {D,C}     |     2 |
| T1    |      43 | E      | {C,D}     |     2 |
| T1    |      43 | R      | {D,C}     |     2 |
| T1    |     291 | A      | {D}       |     1 |
| T1    |     291 | R      | {D}       |     1 |
| T1    |     291 | T      | {D}       |     1 |
| T1    |     292 | A      | {D}       |     1 |
| T1    |     292 | R      | {D}       |     1 |
| T1    |     292 | T      | {D}       |     1 |
| T1    |     293 | A      | {D}       |     1 |
| T1    |     293 | E      | {D}       |     1 |
| T1    |     293 | R      | {D}       |     1 |
| T1    |     294 | A      | {D}       |     1 |
| T1    |     294 | E      | {D}       |     1 |
| T1    |     294 | R      | {D}       |     1 |
| T1    |     295 | A      | {D}       |     1 |
| T1    |     295 | R      | {D}       |     1 |
| T1    |     295 | T      | {D}       |     1 |
| T1    |     296 | A      | {C,D}     |     2 |
| T1    |     296 | E      | {C,D}     |     2 |
| T1    |     296 | R      | {C,D}     |     2 |
| T1    |     296 | T      | {C}       |     1 |
| T1    |     297 | A      | {D}       |     1 |
| T1    |     297 | E      | {D}       |     1 |
| T1    |     297 | R      | {D}       |     1 |

Displaying records 1 - 100

</div>

``` sql
WITH a AS(
SELECT 
  occurrence_id,
  REGEXP_REPLACE(occurrence_id,'^(ANH_[0-9]{1,3})_([ARET])_([DC])(_T2)?$','\1') anh_name,
  REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_([ARET])_([DC])(_T2)?$','\1')::int anh_num,
  REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_([ARET])_([DC])(_T2)?$','\2') metodo,
  REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_([ARET])_([DC])(_T2)?$','\3') jornada,
  CASE 
    WHEN occurrence_id ~ 'T2$' THEN 'T2'
    ELSE 'T1'
  END tempo
FROM raw_dwc.peces_event
)
SELECT anh_num, ARRAY_AGG(tempo) temporadas, ARRAY_AGG(metodo) metodos, ARRAY_AGG(jornada) jornadas, count(*)
FROM a
GROUP BY anh_num
ORDER BY anh_num
;
```

<div class="knitsql-table">

| anh_num | temporadas                                  | metodos                       | jornadas                      | count |
|--------:|:--------------------------------------------|:------------------------------|:------------------------------|------:|
|       7 | {T2,T1,T1,T1,T2,T1,T1,T1,T2,T2,T2,T2}       | {A,E,A,R,R,A,R,E,E,R,A,E}     | {D,C,C,C,D,D,D,D,D,C,C,C}     |    12 |
|       8 | {T2,T1,T1,T1,T2,T2,T2}                      | {R,A,R,E,T,E,A}               | {D,D,D,D,D,D,D}               |     7 |
|       9 | {T1,T2,T2,T1}                               | {A,T,A,T}                     | {D,D,D,D}                     |     4 |
|      10 | {T2,T2,T1,T1,T1,T2}                         | {T,A,R,T,A,R}                 | {D,D,D,D,D,D}                 |     6 |
|      11 | {T2,T1,T2,T1,T1,T2}                         | {A,A,R,R,T,T}                 | {D,D,D,D,D,D}                 |     6 |
|      12 | {T2,T2,T1,T1,T1,T2}                         | {A,E,A,T,R,R}                 | {D,D,D,D,D,D}                 |     6 |
|      13 | {T1,T1,T1,T2,T2,T2}                         | {R,T,A,R,E,A}                 | {D,D,D,D,D,D}                 |     6 |
|      14 | {T1,T1,T1,T1,T2,T2}                         | {R,A,T,E,R,E}                 | {D,D,D,D,D,D}                 |     6 |
|      15 | {T2,T1,T1,T1,T2,T2}                         | {R,T,A,R,T,A}                 | {D,D,D,D,D,D}                 |     6 |
|      16 | {T1,T1,T2,T2,T1}                            | {T,A,T,A,R}                   | {D,D,D,D,D}                   |     5 |
|      17 | {T1,T1,T1,T2,T2}                            | {T,R,A,A,E}                   | {D,D,D,D,D}                   |     5 |
|      18 | {T1,T2,T1,T2,T1}                            | {T,R,A,A,R}                   | {D,D,D,D,D}                   |     5 |
|      19 | {T1,T2,T2,T2,T1,T1}                         | {R,R,A,T,A,T}                 | {D,D,D,D,D,D}                 |     6 |
|      20 | {T1,T2,T2,T2,T1,T1}                         | {R,T,A,R,A,T}                 | {D,D,D,D,D,D}                 |     6 |
|      21 | {T1,T1,T2,T1,T2,T2}                         | {T,A,T,R,R,A}                 | {D,D,D,D,D,D}                 |     6 |
|      32 | {T2,T2,T1,T1,T1,T2}                         | {R,T,R,A,T,A}                 | {D,D,D,D,D,D}                 |     6 |
|      33 | {T2,T1,T2,T1,T2,T1}                         | {A,R,T,A,R,T}                 | {D,D,D,D,D,D}                 |     6 |
|      34 | {T1,T1,T2,T1,T2,T2}                         | {A,T,T,R,A,R}                 | {D,D,D,D,D,D}                 |     6 |
|      35 | {T2,T1,T2,T1,T2}                            | {A,A,R,R,E}                   | {D,D,D,D,D}                   |     5 |
|      37 | {T2,T1,T1,T1,T1,T2,T2,T2,T2,T1,T1,T1,T2}    | {R,T,R,E,A,A,A,E,E,R,T,A,R}   | {D,C,C,C,C,C,D,C,D,D,D,D,C}   |    13 |
|      38 | {T2,T1,T1,T1,T1}                            | {R,E,R,A,T}                   | {D,D,D,D,D}                   |     5 |
|      39 | {T2,T1,T1,T1,T1,T1,T2,T2,T2,T2,T1,T2,T2}    | {T,E,A,R,A,R,A,R,A,E,E,R,E}   | {D,D,D,D,C,C,C,D,D,D,C,C,C}   |    13 |
|      40 | {T1,T1,T2,T2,T2}                            | {A,E,A,R,E}                   | {D,D,D,D,D}                   |     5 |
|      41 | {T2,T1,T1,T2,T2,T1}                         | {E,R,A,A,R,E}                 | {D,D,D,D,D,D}                 |     6 |
|      42 | {T1,T2,T2,T1,T1}                            | {T,E,R,A,R}                   | {D,D,D,D,D}                   |     5 |
|      43 | {T2,T2,T1,T1,T1,T1,T1,T2,T2,T2,T1}          | {A,E,A,R,E,R,E,R,E,R,A}       | {C,C,D,D,D,C,C,C,D,D,C}       |    11 |
|     291 | {T2,T2,T1,T1,T1,T2,T2}                      | {E,T,A,R,T,R,A}               | {D,D,D,D,D,D,D}               |     7 |
|     292 | {T1,T2,T1,T1,T2,T2}                         | {T,R,A,R,A,T}                 | {D,D,D,D,D,D}                 |     6 |
|     293 | {T1,T1,T2,T1,T2}                            | {E,A,E,R,R}                   | {D,D,D,D,D}                   |     5 |
|     294 | {T1,T1,T2,T2,T1}                            | {E,A,R,E,R}                   | {D,D,D,D,D}                   |     5 |
|     295 | {T2,T1,T2,T1,T1}                            | {A,R,T,A,T}                   | {D,D,D,D,D}                   |     5 |
|     296 | {T2,T1,T1,T1,T1,T1,T1,T1,T2,T2,T2,T2,T2}    | {A,T,R,A,E,R,A,E,A,R,T,R,T}   | {C,C,C,C,C,D,D,D,D,D,D,C,C}   |    13 |
|     297 | {T2,T2,T1,T1,T2,T1}                         | {E,A,E,A,R,R}                 | {D,D,D,D,D,D}                 |     6 |
|     298 | {T2,T2,T1,T1,T2,T1}                         | {E,R,R,A,A,E}                 | {D,D,D,D,D,D}                 |     6 |
|     299 | {T2,T1,T1,T1,T1,T1,T2,T2,T2,T2,T2}          | {T,T,A,T,R,A,R,A,T,R,A}       | {D,C,C,D,D,D,C,C,C,D,D}       |    11 |
|     300 | {T1,T2,T2,T2,T1,T1}                         | {T,A,R,T,A,R}                 | {D,D,D,D,D,D}                 |     6 |
|     301 | {T1,T2,T2,T2,T1,T1}                         | {T,A,R,T,E,A}                 | {D,D,D,D,D,D}                 |     6 |
|     302 | {T2,T1,T1,T2,T2,T1,T1,T1,T1,T2,T2,T2}       | {E,R,A,E,R,R,E,A,E,A,A,R}     | {C,D,D,D,D,C,C,C,D,D,C,C}     |    12 |
|     303 | {T1,T2,T2,T2,T1,T1,T1}                      | {R,A,R,E,E,T,A}               | {D,D,D,D,D,D,D}               |     7 |
|     304 | {T2,T1,T2,T1,T1,T1,T2}                      | {R,R,E,T,A,E,A}               | {D,D,D,D,D,D,D}               |     7 |
|     305 | {T1,T2,T2,T1,T1,T2,T1,T1,T1,T1,T2,T2,T2,T1} | {R,A,R,A,T,E,E,E,A,R,A,R,E,T} | {C,D,D,C,C,D,C,D,D,D,C,C,C,D} |    14 |

41 records

</div>

Because there is more than a method, the number of the campaign should
be determined this way:

``` sql
WITH a AS(
SELECT 
  occurrence_id,
  REGEXP_REPLACE(occurrence_id,'^(ANH_[0-9]{1,3})_([ARET])_([DC])(_T2)?$','\1') anh_name,
  REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_([ARET])_([DC])(_T2)?$','\1')::int anh_num,
  REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_([ARET])_([DC])(_T2)?$','\2') metodo,
  REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_([ARET])_([DC])(_T2)?$','\3') jornada,
  CASE 
    WHEN occurrence_id ~ 'T2$' THEN 'T2'
    ELSE 'T1'
  END tempo
FROM raw_dwc.peces_event
)
SELECT tempo, anh_name, ROW_NUMBER() OVER (PARTITION BY anh_name ORDER BY tempo) campaign_nb
FROM a
GROUP BY tempo, anh_name
ORDER BY tempo, anh_name
;
```

<div class="knitsql-table">

| tempo | anh_name | campaign_nb |
|:------|:---------|------------:|
| T1    | ANH_10   |           1 |
| T1    | ANH_11   |           1 |
| T1    | ANH_12   |           1 |
| T1    | ANH_13   |           1 |
| T1    | ANH_14   |           1 |
| T1    | ANH_15   |           1 |
| T1    | ANH_16   |           1 |
| T1    | ANH_17   |           1 |
| T1    | ANH_18   |           1 |
| T1    | ANH_19   |           1 |
| T1    | ANH_20   |           1 |
| T1    | ANH_21   |           1 |
| T1    | ANH_291  |           1 |
| T1    | ANH_292  |           1 |
| T1    | ANH_293  |           1 |
| T1    | ANH_294  |           1 |
| T1    | ANH_295  |           1 |
| T1    | ANH_296  |           1 |
| T1    | ANH_297  |           1 |
| T1    | ANH_298  |           1 |
| T1    | ANH_299  |           1 |
| T1    | ANH_300  |           1 |
| T1    | ANH_301  |           1 |
| T1    | ANH_302  |           1 |
| T1    | ANH_303  |           1 |
| T1    | ANH_304  |           1 |
| T1    | ANH_305  |           1 |
| T1    | ANH_32   |           1 |
| T1    | ANH_33   |           1 |
| T1    | ANH_34   |           1 |
| T1    | ANH_35   |           1 |
| T1    | ANH_37   |           1 |
| T1    | ANH_38   |           1 |
| T1    | ANH_39   |           1 |
| T1    | ANH_40   |           1 |
| T1    | ANH_41   |           1 |
| T1    | ANH_42   |           1 |
| T1    | ANH_43   |           1 |
| T1    | ANH_7    |           1 |
| T1    | ANH_8    |           1 |
| T1    | ANH_9    |           1 |
| T2    | ANH_10   |           2 |
| T2    | ANH_11   |           2 |
| T2    | ANH_12   |           2 |
| T2    | ANH_13   |           2 |
| T2    | ANH_14   |           2 |
| T2    | ANH_15   |           2 |
| T2    | ANH_16   |           2 |
| T2    | ANH_17   |           2 |
| T2    | ANH_18   |           2 |
| T2    | ANH_19   |           2 |
| T2    | ANH_20   |           2 |
| T2    | ANH_21   |           2 |
| T2    | ANH_291  |           2 |
| T2    | ANH_292  |           2 |
| T2    | ANH_293  |           2 |
| T2    | ANH_294  |           2 |
| T2    | ANH_295  |           2 |
| T2    | ANH_296  |           2 |
| T2    | ANH_297  |           2 |
| T2    | ANH_298  |           2 |
| T2    | ANH_299  |           2 |
| T2    | ANH_300  |           2 |
| T2    | ANH_301  |           2 |
| T2    | ANH_302  |           2 |
| T2    | ANH_303  |           2 |
| T2    | ANH_304  |           2 |
| T2    | ANH_305  |           2 |
| T2    | ANH_32   |           2 |
| T2    | ANH_33   |           2 |
| T2    | ANH_34   |           2 |
| T2    | ANH_35   |           2 |
| T2    | ANH_37   |           2 |
| T2    | ANH_38   |           2 |
| T2    | ANH_39   |           2 |
| T2    | ANH_40   |           2 |
| T2    | ANH_41   |           2 |
| T2    | ANH_42   |           2 |
| T2    | ANH_43   |           2 |
| T2    | ANH_7    |           2 |
| T2    | ANH_8    |           2 |
| T2    | ANH_9    |           2 |

82 records

</div>

``` sql
INSERT INTO main.gp_event(cd_gp_biol,cd_protocol,cd_pt_ref,campaign_nb)
WITH a AS(
SELECT 
  occurrence_id,
  REGEXP_REPLACE(occurrence_id,'^(ANH_[0-9]{1,3})_([ARET])_([DC])(_T2)?$','\1') anh_name,
  REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_([ARET])_([DC])(_T2)?$','\1')::int anh_num,
  REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_([ARET])_([DC])(_T2)?$','\2') metodo,
  REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_([ARET])_([DC])(_T2)?$','\3') jornada,
  CASE 
    WHEN occurrence_id ~ 'T2$' THEN 'T2'
    ELSE 'T1'
  END tempo,
  cd_pt_ref
FROM raw_dwc.peces_event
), campaign AS(
SELECT tempo, anh_name, ROW_NUMBER() OVER (PARTITION BY anh_name ORDER BY tempo) campaign_nb
FROM a
GROUP BY tempo, anh_name
ORDER BY tempo, anh_name
)
SELECT 'pece',
  CASE
    WHEN metodo='A' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol_spa='Atarraya')
    WHEN metodo='R' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol_spa='Arrastre')
    WHEN metodo='E' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol_spa='Electropesca')
    WHEN metodo='T' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol_spa='Trasmallo')
  END cd_protocol,
  cd_pt_ref,
  c.campaign_nb
FROM a
LEFT JOIN campaign c ON c.tempo=a.tempo AND (c.anh_name=a.anh_name OR (c.anh_name IS NULL AND a.anh_name IS NULL))
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
GROUP BY cd_pt_ref, name_pt_ref, a.tempo, metodo, c.campaign_nb
ORDER BY a.tempo,cd_pt_ref,cd_protocol
RETURNING cd_gp_event,cd_gp_biol,cd_protocol,cd_pt_ref,campaign_nb,subpart
;
```

Attributing the gp_event

``` sql
ALTER TABLE raw_dwc.peces_event ADD COLUMN cd_gp_event int REFERENCES main.gp_event(cd_gp_event) ON DELETE SET NULL;


WITH a AS(
SELECT 
  occurrence_id,
  REGEXP_REPLACE(occurrence_id,'^(ANH_[0-9]{1,3})_([ARET])_([DC])(_T2)?$','\1') anh_name,
  REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_([ARET])_([DC])(_T2)?$','\1')::int anh_num,
  REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_([ARET])_([DC])(_T2)?$','\2') metodo,
  REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_([ARET])_([DC])(_T2)?$','\3') jornada,
  CASE 
    WHEN occurrence_id ~ 'T2$' THEN 'T2'
    ELSE 'T1'
  END tempo,
  cd_pt_ref
FROM raw_dwc.peces_event
), campaign AS(
SELECT tempo, anh_name, ROW_NUMBER() OVER (PARTITION BY anh_name ORDER BY tempo) campaign_nb
FROM a
GROUP BY tempo, anh_name
ORDER BY tempo, anh_name
),b AS(
SELECT occurrence_id,
  CASE
    WHEN metodo='A' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol_spa='Atarraya')
    WHEN metodo='R' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol_spa='Arrastre')
    WHEN metodo='E' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol_spa='Electropesca')
    WHEN metodo='T' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol_spa='Trasmallo')
  END cd_protocol,
  cd_pt_ref,
  c.campaign_nb
FROM a
LEFT JOIN campaign c ON c.tempo=a.tempo AND (c.anh_name=a.anh_name OR (c.anh_name IS NULL AND a.anh_name IS NULL))
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
),d AS(
SELECT b.*, cd_gp_event
FROM b
LEFT JOIN main.gp_event ge ON cd_gp_biol='pece' AND b.cd_protocol=ge.cd_protocol AND ((b.cd_pt_ref=ge.cd_pt_ref) OR (b.cd_pt_ref IS NULL AND ge.cd_pt_ref IS NULL)) AND b.campaign_nb=ge.campaign_nb 
)
UPDATE raw_dwc.peces_event e
SET cd_gp_event=d.cd_gp_event
FROM d
WHERE d.occurrence_id=e.occurrence_id
RETURNING e.occurrence_id, e.cd_gp_event
;

SELECT occurrence_id
FROM raw_dwc.peces_event
WHERE cd_gp_event IS NULL;
```

<div class="knitsql-table">

occurrence_id —————

: 0 records

</div>

## 10.6 event

**Peces (como aves) has sampl*ing* while the others have sampl*e* in the
name of the columns**

**los eventos no tienen hora final… voy a considerar que la hora +
tiempo de grabación da la hora final**

**los comentarios sobre los eventos son muy largos, para guardar una
lisibilidad de la tabla, se van a poner en la tabla extra**

``` sql
INSERT INTO main.event(cd_gp_event,event_id,num_replicate, description_replicate, date_time_begin, date_time_end, locality_verb, event_remarks, samp_effort_1, samp_effort_2, pt_geom)
WITH a AS(
SELECT cd_gp_event,
  occurrence_id, 
  REGEXP_REPLACE(occurrence_id,'^(ANH_[0-9]{1,3})_([ARET])_([DC])(_T2)?$','\1') anh_name,
  REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_([ARET])_([DC])(_T2)?$','\1')::int anh_num,
  REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_([ARET])_([DC])(_T2)?$','\2') metodo,
  REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_([ARET])_([DC])(_T2)?$','\3') jornada,
  CASE 
    WHEN occurrence_id ~ 'T2$' THEN 'T2'
    ELSE 'T1'
 END tempo,
  --TO_DATE(SPLIT_PART(event_date,'/',1), 'YYYY-MM-DD') date_1,
  TO_DATE(event_date, 'YYYY-MM-DD') date_1,
  /*CASE 
    WHEN SPLIT_PART(event_date,'/',2)='' THEN NULL
    WHEN SPLIT_PART(event_date,'/',2) ~ '^[0-9]{2}-[0-9]{2}-[0-9]{2}$' THEN TO_DATE('20'||SPLIT_PART(event_date,'/',2), 'YYYY-MM-DD')

    ELSE TO_DATE(SPLIT_PART(event_date,'/',2), 'YYYY-MM-DD')
  END date_2,*/
  NULL as date_2,
  --REGEXP_REPLACE(SPLIT_PART(REGEXP_REPLACE(event_time,'-','/'),'/',1),'\s+','','g')::time hora_1,
  REGEXP_REPLACE(event_time,'\s+','','g')::time hora_1,
  /*CASE
    WHEN REGEXP_REPLACE(SPLIT_PART(REGEXP_REPLACE(event_time,'-','/'),'/',2),'\s+','','g')='' THEN NULL
    ELSE REGEXP_REPLACE(SPLIT_PART(REGEXP_REPLACE(event_time,'-','/'),'/',2),'\s+','','g')::time
  END hora_2,*/
  NULL hora_2,
  locality locality_verb,
  --sample_size_value,
  sampling_size_value,
  --sample_size_unit,
  sampling_size_unit,
  sampling_effort,
  REGEXP_REPLACE(REGEXP_REPLACE(location_remarks, '\|? ?No hay registros de individuos ?',''),'\|? ?No se registran individuos','') event_remarks,
  --event_remarks,
  decimal_latitude::double precision,
  decimal_longitude::double precision
FROM raw_dwc.peces_event
)--calculation of timestamps, coordinates and num_replicate
SELECT 
  cd_gp_event,
  occurrence_id, 
  ROW_NUMBER() OVER (PARTITION BY cd_gp_event ORDER BY jornada DESC) num_replicate,
  'jornada:'||jornada description_replicate,
  (date_1||' '||hora_1)::timestamp date_time_begin,
  ((date_1||' '||hora_1)::timestamp) + (REGEXP_REPLACE(REGEXP_REPLACE(sampling_effort,'[mM]inutos?','minutes'),'[Hh]oras?','hours'))::interval date_time_end,
  locality_verb,
  event_remarks ,
  CASE
   WHEN metodo IN ('A','R') THEN sampling_size_value::double precision
   WHEN metodo IN ('E','T') THEN REGEXP_REPLACE(sampling_effort,' *minutos? *','')::double precision
  END samp_eff_1,
  CASE
   WHEN metodo IN ('A','R') THEN REGEXP_REPLACE(sampling_effort,' *minutos? *','')::double precision
  END samp_eff_2,
  ST_SetSRID(ST_Transform(ST_SetSRID(ST_MakePoint(decimal_longitude,decimal_latitude),4326),(SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)),3116) pt_geom
FROM a
LEFT JOIN main.gp_event USING (cd_gp_event)
LEFT JOIN main.def_protocol p USING (cd_protocol)
ORDER BY cd_gp_event, occurrence_id, num_replicate

RETURNING main.event.cd_event, main.event.cd_gp_event, event_id, main.event.num_replicate, main.event.description_replicate, main.event.date_time_begin, main.event.date_time_end, main.event.locality_verb, main.event.event_remarks, main.event.pt_geom
```

Damos los cd_event a todos las filas:

``` sql
ALTER TABLE raw_dwc.peces_event ADD COLUMN cd_event int REFERENCES main.event(cd_event) ON DELETE SET NULL;
ALTER TABLE raw_dwc.peces_registros ADD COLUMN cd_event int REFERENCES main.event(cd_event);

UPDATE raw_dwc.peces_event AS t
SET cd_event=e.cd_event
FROM main.event e
WHERE t.occurrence_id=e.event_id;

UPDATE raw_dwc.peces_registros AS t
SET cd_event=e.cd_event
FROM main.event e
WHERE t.event_id=e.event_id;

SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

### 10.6.1 comentarios largos sobre los eventos

``` sql
INSERT INTO main.def_var_event_extra(var_event_extra, type_var, var_event_extra_spa, var_event_extra_comment)
VALUES
  ('big_remarks',
  'free text',
  'comentarios_largos',
  'This variable exists when the comments are too large to allow readibility of the event table'
  );

INSERT INTO main.event_extra(cd_event, cd_var_event_extra,value_text)
SELECT cd_event, 
  (SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra = 'big_remarks'),
  event_remarks
FROM raw_dwc.peces_event
WHERE  event_remarks IS NOT NULL
;
```

### 10.6.2 Añadir la jornada

``` sql
INSERT INTO main.def_var_event_extra(var_event_extra, type_var, var_event_extra_spa, var_event_extra_comment)
VALUES
  ('period',
  'categorial',
  'jornada',
  NULL
  );
INSERT INTO main.def_categ_event_extra(categ,cd_var_event_extra,categ_spa)
VALUES
  ('Day',
  (SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='period'),
  'Día'
  ),
  ('Night',
  (SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='period'),
  'Noche'
  ),
  ('Dusk',
  (SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='period'),
  'Crepuscular'
  );
INSERT INTO main.event_extra(cd_event,cd_categ_event_extra,cd_var_event_extra)
SELECT cd_event,
  CASE
    WHEN description_replicate~'D$' THEN (SELECT cd_categ_event_extra FROM main.def_categ_event_extra WHERE categ='Day')
    WHEN description_replicate~'C$' THEN (SELECT cd_categ_event_extra FROM main.def_categ_event_extra WHERE categ='Dusk')
  END cd_categ,
  (SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='period')
FROM main.event
LEFT JOIN main.gp_event USING (cd_gp_event)
WHERE cd_gp_biol='pece' AND description_replicate ~ '[DC]$'
;
```

## 10.7 registros

``` sql
SELECT occurrence_id, count(*)
FROM raw_dwc.peces_registros 
GROUP BY occurrence_id
HAVING count(*)>1;
```

<div class="knitsql-table">

occurrence_id count ————— ——-

: 0 records

</div>

No horas ni fechas en los registros…

**No hay organism_id**

``` sql
INSERT INTO main.registros(cd_event, cds_recorded_by, date_time, cd_tax, cd_morfo, date_ident, cds_identified_by, qt_int,remarks, occurrence_id, organism_id)
SELECT 
 cd_event,
 cds_recorded_by,
 NULL::timestamp AS date_time,
 tt.cd_tax,
 tt.cd_morfo,
 TO_DATE(date_identified,'YYYY-MM-DD') date_ident,
 cds_identified_by,
 CASE
  WHEN var_qt_ind ='Occurrence' AND organism_quantity IS NULL THEN 1
  ELSE organism_quantity::double precision::int 
 END qt_int,
 occurrence_remarks remarks,
 --r.event_remarks remarks,
 r.occurrence_id,
 SPLIT_PART(occurrence_id,':',7) organism_id
 --ROW_NUMBER() OVER (ORDER BY (e.date_time_begin::date||' '||event_time)::timestamp)
 --organism_id,
 --ST_SetSRID(ST_Transform(ST_SetSRID(ST_MakePoint(measurement_value__longitud_,measurement_value__latitud_), 4326),  (SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)),3116)
FROM raw_dwc.peces_registros r
LEFT JOIN raw_dwc.taxonomy_total tt ON tt."row.names"=r."row.names" AND tt.table_orig='peces_registros'
LEFT JOIN main.event e USING (cd_event)
LEFT JOIN main.gp_event USING (cd_gp_event)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.def_var_ind_qt USING(cd_var_ind_qt)
ORDER BY date_time

RETURNING cd_event, cds_recorded_by, date_time, cd_tax, cd_morfo, cds_identified_by, qt_int,remarks, occurrence_id, organism_id
```

``` sql
ALTER TABLE raw_dwc.peces_registros ADD COLUMN cd_reg int REFERENCES main.registros(cd_reg);

UPDATE raw_dwc.peces_registros AS ar
SET cd_reg=r.cd_reg
FROM main.registros r
WHERE ar.cd_event=r.cd_event AND ar.occurrence_id=r.occurrence_id;

-- Check cd_reg are unique in the source table
SELECT cd_reg,count(*) FROM  raw_dwc.peces_registros GROUP BY cd_reg HAVING count(*)>1;
```

<div class="knitsql-table">

    cd_reg   count

------------------------------------------------------------------------

: 0 records

</div>

**TODO: Añadir la variables ambientales y las variables de habitats
especificas a los habitats acuaticos**

# 11 Hidrobiologicos

## 11.1 Crear la tabla total de registros

``` sql
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
)
SELECT column_name, 
ARRAY[fipl.table_name,zopl.table_name,peri.table_name,mafi.table_name,minv.table_name],
ARRAY[fipl.data_type,zopl.data_type,peri.data_type,mafi.data_type,minv.data_type]
FROM fipl
FULL OUTER JOIN zopl USING (column_name)
FULL OUTER JOIN peri USING (column_name)
FULL OUTER JOIN mafi USING (column_name)
FULL OUTER JOIN minv USING (column_name)
ORDER BY COALESCE(fipl.ordinal_position,zopl.ordinal_position,peri.ordinal_position,mafi.ordinal_position,minv.ordinal_position);
```

<div class="knitsql-table">

| column_name                                                     | array                                                                                                                                                                                           | array                                                                                            |
|:----------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------------------------------------------------------------------------------------|
| row.names                                                       | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {text,text,text,text,text}                                                                       |
| occurrence_id                                                   | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {text,text,text,text,text}                                                                       |
| event_id                                                        | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {text,text,text,text,text}                                                                       |
| basis_of_record                                                 | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {text,text,text,text,text}                                                                       |
| type                                                            | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {text,text,text,text,text}                                                                       |
| institution_code                                                | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {text,text,text,text,text}                                                                       |
| collection_code                                                 | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {text,text,text,text,text}                                                                       |
| record_number                                                   | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {“double precision”,“double precision”,“double precision”,“double precision”,“double precision”} |
| recorded_by                                                     | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {text,text,text,text,text}                                                                       |
| organism_quantity                                               | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {“double precision”,“double precision”,“double precision”,text,“double precision”}               |
| organism_quantity_type                                          | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,NULL,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados}                               | {text,text,NULL,text,text}                                                                       |
| organ_ism_quant_ity_type                                        | {NULL,NULL,hidrobiologico_registros_perifiton,NULL,NULL}                                                                                                                                        | {NULL,NULL,text,NULL,NULL}                                                                       |
| preparations                                                    | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {text,text,text,text,text}                                                                       |
| sampling_protocol                                               | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {text,text,text,text,text}                                                                       |
| sampling_effort                                                 | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {text,text,text,text,text}                                                                       |
| identified_by                                                   | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {text,text,text,text,text}                                                                       |
| date_identified                                                 | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {text,text,text,text,text}                                                                       |
| identification_remarks                                          | {NULL,NULL,NULL,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados}                                                                                                | {NULL,NULL,NULL,text,text}                                                                       |
| identification_qualifier                                        | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {text,text,text,text,text}                                                                       |
| scientific_name                                                 | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {text,text,text,text,text}                                                                       |
| kingdom                                                         | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {text,text,text,text,text}                                                                       |
| phylum                                                          | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {text,text,text,text,text}                                                                       |
| class                                                           | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {text,text,text,text,text}                                                                       |
| order                                                           | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {text,text,text,text,text}                                                                       |
| family                                                          | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {text,text,text,text,text}                                                                       |
| genus                                                           | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {text,text,text,text,text}                                                                       |
| specific_epithet                                                | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {text,text,text,text,text}                                                                       |
| taxon_rank                                                      | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {text,text,text,text,text}                                                                       |
| scientific_name_authorship                                      | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {text,text,text,text,text}                                                                       |
| title                                                           | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {text,text,text,text,text}                                                                       |
| type_1                                                          | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {text,text,text,text,text}                                                                       |
| format                                                          | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {text,text,text,text,text}                                                                       |
| creator                                                         | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {text,text,text,text,text}                                                                       |
| created                                                         | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,hidrobiologico_registros_macrofitas,hidrobiologico_registros_macroinvertebrados} | {text,text,text,text,text}                                                                       |
| measurement_type\_*abundancia_relativa*                         | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,NULL,hidrobiologico_registros_macroinvertebrados}                                | {text,text,text,NULL,text}                                                                       |
| measurement_value\_*abundancia_relativa*                        | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,NULL,hidrobiologico_registros_macroinvertebrados}                                | {“double precision”,“double precision”,“double precision”,NULL,“double precision”}               |
| measurement_type\_\_cobertura_de_cada_una_de_las_especies**%**  | {NULL,NULL,NULL,hidrobiologico_registros_macrofitas,NULL}                                                                                                                                       | {NULL,NULL,NULL,text,NULL}                                                                       |
| measurement_unit\_*abundancia_relativa*                         | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,hidrobiologico_registros_perifiton,NULL,hidrobiologico_registros_macroinvertebrados}                                | {text,text,text,NULL,text}                                                                       |
| measurement_value\_\_cobertura_de_cada_una_de_las_especies**%** | {NULL,NULL,NULL,hidrobiologico_registros_macrofitas,NULL}                                                                                                                                       | {NULL,NULL,NULL,text,NULL}                                                                       |
| measurement_unit\_\_cobertura_de_cada_una_de_las_especies**%**  | {NULL,NULL,NULL,hidrobiologico_registros_macrofitas,NULL}                                                                                                                                       | {NULL,NULL,NULL,text,NULL}                                                                       |
| measurement_type\_*volumen_filtrado*                            | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,NULL,NULL,NULL}                                                                                                     | {text,text,NULL,NULL,NULL}                                                                       |
| measurement_type\_*área_total_raspada_por_muestra*              | {NULL,NULL,hidrobiologico_registros_perifiton,NULL,hidrobiologico_registros_macroinvertebrados}                                                                                                 | {NULL,NULL,text,NULL,text}                                                                       |
| measurement_type\_*área_total_muestreada_por_estación*          | {NULL,NULL,NULL,hidrobiologico_registros_macrofitas,NULL}                                                                                                                                       | {NULL,NULL,NULL,text,NULL}                                                                       |
| measurement_value\_*volumen_filtrado*                           | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,NULL,NULL,NULL}                                                                                                     | {“double precision”,“double precision”,NULL,NULL,NULL}                                           |
| measurement_value\_*área_total_raspada_por_muestra*             | {NULL,NULL,hidrobiologico_registros_perifiton,NULL,hidrobiologico_registros_macroinvertebrados}                                                                                                 | {NULL,NULL,“double precision”,NULL,“double precision”}                                           |
| measurement_unit\_*área_total_raspada_por_muestra*              | {NULL,NULL,hidrobiologico_registros_perifiton,NULL,hidrobiologico_registros_macroinvertebrados}                                                                                                 | {NULL,NULL,text,NULL,text}                                                                       |
| measurement_unit\_*volumen_filtrado*                            | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,NULL,NULL,NULL}                                                                                                     | {text,text,NULL,NULL,NULL}                                                                       |
| measurement_value\_*área_total_muestreada_por_estación*         | {NULL,NULL,NULL,hidrobiologico_registros_macrofitas,NULL}                                                                                                                                       | {NULL,NULL,NULL,“double precision”,NULL}                                                         |
| measurement_unit\_*área_total_muestreada_por_estación*          | {NULL,NULL,NULL,hidrobiologico_registros_macrofitas,NULL}                                                                                                                                       | {NULL,NULL,NULL,text,NULL}                                                                       |
| measurement_type\_*profundidad_de_capa_fótica*                  | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,NULL,NULL,NULL}                                                                                                     | {text,text,NULL,NULL,NULL}                                                                       |
| measurement_type\_*área_total_raspada_por_estación*             | {NULL,NULL,NULL,NULL,hidrobiologico_registros_macroinvertebrados}                                                                                                                               | {NULL,NULL,NULL,NULL,text}                                                                       |
| measurement_value\_*profundidad_de_capa_fótica*                 | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,NULL,NULL,NULL}                                                                                                     | {“double precision”,“double precision”,NULL,NULL,NULL}                                           |
| measurement_type\_*área_total_muestreada_para_hidrofitos*       | {NULL,NULL,NULL,hidrobiologico_registros_macrofitas,NULL}                                                                                                                                       | {NULL,NULL,NULL,text,NULL}                                                                       |
| measurement_value\_*área_total_muestreada_para_hidrofitos*      | {NULL,NULL,NULL,hidrobiologico_registros_macrofitas,NULL}                                                                                                                                       | {NULL,NULL,NULL,“double precision”,NULL}                                                         |
| measurement_unit\_*profundidad_de_capa_fótica*                  | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,NULL,NULL,NULL}                                                                                                     | {text,text,NULL,NULL,NULL}                                                                       |
| measurement_value\_*área_total_raspada_por_estación*            | {NULL,NULL,NULL,NULL,hidrobiologico_registros_macroinvertebrados}                                                                                                                               | {NULL,NULL,NULL,NULL,“double precision”}                                                         |
| measurement_unit\_*área_total_raspada_por_estación*             | {NULL,NULL,NULL,NULL,hidrobiologico_registros_macroinvertebrados}                                                                                                                               | {NULL,NULL,NULL,NULL,text}                                                                       |
| measurement_type\_*profundidad_total*                           | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,NULL,NULL,NULL}                                                                                                     | {text,text,NULL,NULL,NULL}                                                                       |
| measurement_unit\_*área_total_muestreada_para_hidrofitos*       | {NULL,NULL,NULL,hidrobiologico_registros_macrofitas,NULL}                                                                                                                                       | {NULL,NULL,NULL,text,NULL}                                                                       |
| measurement_value\_*profundidad_total*                          | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,NULL,NULL,NULL}                                                                                                     | {“double precision”,“double precision”,NULL,NULL,NULL}                                           |
| measurement_type\_*área_total_muestreada_en_zona_de_helófitas*  | {NULL,NULL,NULL,hidrobiologico_registros_macrofitas,NULL}                                                                                                                                       | {NULL,NULL,NULL,text,NULL}                                                                       |
| measurement_unit\_*profundidad_total*                           | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_zooplancton,NULL,NULL,NULL}                                                                                                     | {text,text,NULL,NULL,NULL}                                                                       |
| measurement_value\_\_área_total_muestreada_en_zona_de_helófitas | {NULL,NULL,NULL,hidrobiologico_registros_macrofitas,NULL}                                                                                                                                       | {NULL,NULL,NULL,“double precision”,NULL}                                                         |
| measurement_unit\_*área_total_muestreada_en_zona_de_helófitas*  | {NULL,NULL,NULL,hidrobiologico_registros_macrofitas,NULL}                                                                                                                                       | {NULL,NULL,NULL,text,NULL}                                                                       |

64 records

</div>

``` sql
CREATE TABLE raw_dwc.hidrobiologico_registros AS(
SELECT 
 'hidrobiologico_registros_fitoplancton' AS table_orig,
 "row.names"::text,
 "occurrence_id"::text,
 "event_id"::text,
 "basis_of_record"::text,
 "type"::text,
 "institution_code"::text,
 "collection_code"::text,
 "record_number"::double precision,
 "recorded_by"::text,
 "organism_quantity"::text,
 "organism_quantity_type"::text,
 NULL::text AS "organ_ism_quant_ity_type",
 "preparations"::text,
 "sampling_protocol"::text,
 "sampling_effort"::text,
 "identified_by"::text,
 "date_identified"::text,
 NULL::text AS "identification_remarks",
 "identification_qualifier"::text,
 "scientific_name"::text,
 "kingdom"::text,
 "phylum"::text,
 "class"::text,
 "order"::text,
 "family"::text,
 "genus"::text,
 "specific_epithet"::text,
 "taxon_rank"::text,
 "scientific_name_authorship"::text,
 "title"::text,
 "type_1"::text,
 "format"::text,
 "creator"::text,
 "created"::text,
 "measurement_type__abundancia_relativa_"::text,
 "measurement_value__abundancia_relativa_"::double precision,
 NULL::text AS "measurement_type__cobertura_de_cada_una_de_las_especies__%__",
 NULL::text AS "measurement_value__cobertura_de_cada_una_de_las_especies__%__",
 "measurement_unit__abundancia_relativa_"::text,
 NULL::text AS "measurement_type__área_total_raspada_por_muestra_",
 "measurement_type__volumen_filtrado_"::text,
 NULL::text AS "measurement_unit__cobertura_de_cada_una_de_las_especies__%__",
 NULL::text AS "measurement_type__área_total_muestreada_por_estación_",
 "measurement_value__volumen_filtrado_"::double precision,
 NULL::double precision AS "measurement_value__área_total_raspada_por_muestra_",
 NULL::text AS "measurement_unit__área_total_raspada_por_muestra_",
 "measurement_unit__volumen_filtrado_"::text,
 NULL::double precision AS "measurement_value__área_total_muestreada_por_estación_",
 NULL::text AS "measurement_unit__área_total_muestreada_por_estación_",
 "measurement_type__profundidad_de_capa_fótica_"::text,
 NULL::text AS "measurement_type__área_total_muestreada_para_hidrofitos_",
 "measurement_value__profundidad_de_capa_fótica_"::double precision,
 NULL::text AS "measurement_type__área_total_raspada_por_estación_",
 "measurement_unit__profundidad_de_capa_fótica_"::text,
 NULL::double precision AS "measurement_value__área_total_raspada_por_estación_",
 NULL::double precision AS "measurement_value__área_total_muestreada_para_hidrofitos_",
 NULL::text AS "measurement_unit__área_total_muestreada_para_hidrofitos_",
 NULL::text AS "measurement_unit__área_total_raspada_por_estación_",
 "measurement_type__profundidad_total_"::text,
 "measurement_value__profundidad_total_"::double precision,
 NULL::text AS "measurement_type__área_total_muestreada_en_zona_de_helófitas_",
 NULL::double precision AS "measurement_value__área_total_muestreada_en_zona_de_helófitas",
 "measurement_unit__profundidad_total_"::text,
 NULL::text AS "measurement_unit__área_total_muestreada_en_zona_de_helófitas_"
FROM raw_dwc.hidrobiologico_registros_fitoplancton
UNION ALL
SELECT 
 'hidrobiologico_registros_zooplancton' AS table_orig,
 "row.names"::text,
 "occurrence_id"::text,
 "event_id"::text,
 "basis_of_record"::text,
 "type"::text,
 "institution_code"::text,
 "collection_code"::text,
 "record_number"::double precision,
 "recorded_by"::text,
 "organism_quantity"::text,
 "organism_quantity_type"::text,
 NULL::text AS "organ_ism_quant_ity_type",
 "preparations"::text,
 "sampling_protocol"::text,
 "sampling_effort"::text,
 "identified_by"::text,
 "date_identified"::text,
 NULL::text AS "identification_remarks",
 "identification_qualifier"::text,
 "scientific_name"::text,
 "kingdom"::text,
 "phylum"::text,
 "class"::text,
 "order"::text,
 "family"::text,
 "genus"::text,
 "specific_epithet"::text,
 "taxon_rank"::text,
 "scientific_name_authorship"::text,
 "title"::text,
 "type_1"::text,
 "format"::text,
 "creator"::text,
 "created"::text,
 "measurement_type__abundancia_relativa_"::text,
 "measurement_value__abundancia_relativa_"::double precision,
 NULL::text AS "measurement_type__cobertura_de_cada_una_de_las_especies__%__",
 NULL::text AS "measurement_value__cobertura_de_cada_una_de_las_especies__%__",
 "measurement_unit__abundancia_relativa_"::text,
 NULL::text AS "measurement_type__área_total_raspada_por_muestra_",
 "measurement_type__volumen_filtrado_"::text,
 NULL::text AS "measurement_unit__cobertura_de_cada_una_de_las_especies__%__",
 NULL::text AS "measurement_type__área_total_muestreada_por_estación_",
 "measurement_value__volumen_filtrado_"::double precision,
 NULL::double precision AS "measurement_value__área_total_raspada_por_muestra_",
 NULL::text AS "measurement_unit__área_total_raspada_por_muestra_",
 "measurement_unit__volumen_filtrado_"::text,
 NULL::double precision AS "measurement_value__área_total_muestreada_por_estación_",
 NULL::text AS "measurement_unit__área_total_muestreada_por_estación_",
 "measurement_type__profundidad_de_capa_fótica_"::text,
 NULL::text AS "measurement_type__área_total_muestreada_para_hidrofitos_",
 "measurement_value__profundidad_de_capa_fótica_"::double precision,
 NULL::text AS "measurement_type__área_total_raspada_por_estación_",
 "measurement_unit__profundidad_de_capa_fótica_"::text,
 NULL::double precision AS "measurement_value__área_total_raspada_por_estación_",
 NULL::double precision AS "measurement_value__área_total_muestreada_para_hidrofitos_",
 NULL::text AS "measurement_unit__área_total_muestreada_para_hidrofitos_",
 NULL::text AS "measurement_unit__área_total_raspada_por_estación_",
 "measurement_type__profundidad_total_"::text,
 "measurement_value__profundidad_total_"::double precision,
 NULL::text AS "measurement_type__área_total_muestreada_en_zona_de_helófitas_",
 NULL::double precision AS "measurement_value__área_total_muestreada_en_zona_de_helófitas",
 "measurement_unit__profundidad_total_"::text,
 NULL::text AS "measurement_unit__área_total_muestreada_en_zona_de_helófitas_"
FROM raw_dwc.hidrobiologico_registros_zooplancton
UNION ALL
SELECT 
 'hidrobiologico_registros_perifiton' AS table_orig,
 "row.names"::text,
 "occurrence_id"::text,
 "event_id"::text,
 "basis_of_record"::text,
 "type"::text,
 "institution_code"::text,
 "collection_code"::text,
 "record_number"::double precision,
 "recorded_by"::text,
 "organism_quantity"::text,
 NULL::text AS "organism_quantity_type",
 "organ_ism_quant_ity_type"::text,
 "preparations"::text,
 "sampling_protocol"::text,
 "sampling_effort"::text,
 "identified_by"::text,
 "date_identified"::text,
 NULL::text AS "identification_remarks",
 "identification_qualifier"::text,
 "scientific_name"::text,
 "kingdom"::text,
 "phylum"::text,
 "class"::text,
 "order"::text,
 "family"::text,
 "genus"::text,
 "specific_epithet"::text,
 "taxon_rank"::text,
 "scientific_name_authorship"::text,
 "title"::text,
 "type_1"::text,
 "format"::text,
 "creator"::text,
 "created"::text,
 "measurement_type__abundancia_relativa_"::text,
 "measurement_value__abundancia_relativa_"::double precision,
 NULL::text AS "measurement_type__cobertura_de_cada_una_de_las_especies__%__",
 NULL::text AS "measurement_value__cobertura_de_cada_una_de_las_especies__%__",
 "measurement_unit__abundancia_relativa_"::text,
 "measurement_type__área_total_raspada_por_muestra_"::text,
 NULL::text AS "measurement_type__volumen_filtrado_",
 NULL::text AS "measurement_unit__cobertura_de_cada_una_de_las_especies__%__",
 NULL::text AS "measurement_type__área_total_muestreada_por_estación_",
 NULL::double precision AS "measurement_value__volumen_filtrado_",
 "measurement_value__área_total_raspada_por_muestra_"::double precision,
 "measurement_unit__área_total_raspada_por_muestra_"::text,
 NULL::text AS "measurement_unit__volumen_filtrado_",
 NULL::double precision AS "measurement_value__área_total_muestreada_por_estación_",
 NULL::text AS "measurement_unit__área_total_muestreada_por_estación_",
 NULL::text AS "measurement_type__profundidad_de_capa_fótica_",
 NULL::text AS "measurement_type__área_total_muestreada_para_hidrofitos_",
 NULL::double precision AS "measurement_value__profundidad_de_capa_fótica_",
 NULL::text AS "measurement_type__área_total_raspada_por_estación_",
 NULL::text AS "measurement_unit__profundidad_de_capa_fótica_",
 NULL::double precision AS "measurement_value__área_total_raspada_por_estación_",
 NULL::double precision AS "measurement_value__área_total_muestreada_para_hidrofitos_",
 NULL::text AS "measurement_unit__área_total_muestreada_para_hidrofitos_",
 NULL::text AS "measurement_unit__área_total_raspada_por_estación_",
 NULL::text AS "measurement_type__profundidad_total_",
 NULL::double precision AS "measurement_value__profundidad_total_",
 NULL::text AS "measurement_type__área_total_muestreada_en_zona_de_helófitas_",
 NULL::double precision AS "measurement_value__área_total_muestreada_en_zona_de_helófitas",
 NULL::text AS "measurement_unit__profundidad_total_",
 NULL::text AS "measurement_unit__área_total_muestreada_en_zona_de_helófitas_"
FROM raw_dwc.hidrobiologico_registros_perifiton
UNION ALL
SELECT 
 'hidrobiologico_registros_macrofitas' AS table_orig,
 "row.names"::text,
 "occurrence_id"::text,
 "event_id"::text,
 "basis_of_record"::text,
 "type"::text,
 "institution_code"::text,
 "collection_code"::text,
 "record_number"::double precision,
 "recorded_by"::text,
 "organism_quantity"::text,
 "organism_quantity_type"::text,
 NULL::text AS "organ_ism_quant_ity_type",
 "preparations"::text,
 "sampling_protocol"::text,
 "sampling_effort"::text,
 "identified_by"::text,
 "date_identified"::text,
 "identification_remarks"::text,
 "identification_qualifier"::text,
 "scientific_name"::text,
 "kingdom"::text,
 "phylum"::text,
 "class"::text,
 "order"::text,
 "family"::text,
 "genus"::text,
 "specific_epithet"::text,
 "taxon_rank"::text,
 "scientific_name_authorship"::text,
 "title"::text,
 "type_1"::text,
 "format"::text,
 "creator"::text,
 "created"::text,
 NULL::text AS "measurement_type__abundancia_relativa_",
 NULL::double precision AS "measurement_value__abundancia_relativa_",
 "measurement_type__cobertura_de_cada_una_de_las_especies__%__"::text,
 "measurement_value__cobertura_de_cada_una_de_las_especies__%__"::text,
 NULL::text AS "measurement_unit__abundancia_relativa_",
 NULL::text AS "measurement_type__área_total_raspada_por_muestra_",
 NULL::text AS "measurement_type__volumen_filtrado_",
 "measurement_unit__cobertura_de_cada_una_de_las_especies__%__"::text,
 "measurement_type__área_total_muestreada_por_estación_"::text,
 NULL::double precision AS "measurement_value__volumen_filtrado_",
 NULL::double precision AS "measurement_value__área_total_raspada_por_muestra_",
 NULL::text AS "measurement_unit__área_total_raspada_por_muestra_",
 NULL::text AS "measurement_unit__volumen_filtrado_",
 "measurement_value__área_total_muestreada_por_estación_"::double precision,
 "measurement_unit__área_total_muestreada_por_estación_"::text,
 NULL::text AS "measurement_type__profundidad_de_capa_fótica_",
 "measurement_type__área_total_muestreada_para_hidrofitos_"::text,
 NULL::double precision AS "measurement_value__profundidad_de_capa_fótica_",
 NULL::text AS "measurement_type__área_total_raspada_por_estación_",
 NULL::text AS "measurement_unit__profundidad_de_capa_fótica_",
 NULL::double precision AS "measurement_value__área_total_raspada_por_estación_",
 "measurement_value__área_total_muestreada_para_hidrofitos_"::double precision,
 "measurement_unit__área_total_muestreada_para_hidrofitos_"::text,
 NULL::text AS "measurement_unit__área_total_raspada_por_estación_",
 NULL::text AS "measurement_type__profundidad_total_",
 NULL::double precision AS "measurement_value__profundidad_total_",
 "measurement_type__área_total_muestreada_en_zona_de_helófitas_"::text,
 "measurement_value__área_total_muestreada_en_zona_de_helófitas"::double precision,
 NULL::text AS "measurement_unit__profundidad_total_",
 "measurement_unit__área_total_muestreada_en_zona_de_helófitas_"::text
FROM raw_dwc.hidrobiologico_registros_macrofitas
UNION ALL
SELECT 
 'hidrobiologico_registros_macroinvertebrados' AS table_orig,
"row.names"::text,
 "occurrence_id"::text,
 "event_id"::text,
 "basis_of_record"::text,
 "type"::text,
 "institution_code"::text,
 "collection_code"::text,
 "record_number"::double precision,
 "recorded_by"::text,
 "organism_quantity"::text,
 "organism_quantity_type"::text,
 NULL::text AS "organ_ism_quant_ity_type",
 "preparations"::text,
 "sampling_protocol"::text,
 "sampling_effort"::text,
 "identified_by"::text,
 "date_identified"::text,
 "identification_remarks"::text,
 "identification_qualifier"::text,
 "scientific_name"::text,
 "kingdom"::text,
 "phylum"::text,
 "class"::text,
 "order"::text,
 "family"::text,
 "genus"::text,
 "specific_epithet"::text,
 "taxon_rank"::text,
 "scientific_name_authorship"::text,
 "title"::text,
 "type_1"::text,
 "format"::text,
 "creator"::text,
 "created"::text,
 "measurement_type__abundancia_relativa_"::text,
 "measurement_value__abundancia_relativa_"::double precision,
 NULL::text AS "measurement_type__cobertura_de_cada_una_de_las_especies__%__",
 NULL::text AS "measurement_value__cobertura_de_cada_una_de_las_especies__%__",
 "measurement_unit__abundancia_relativa_"::text,
 "measurement_type__área_total_raspada_por_muestra_"::text,
 NULL::text AS "measurement_type__volumen_filtrado_",
 NULL::text AS "measurement_unit__cobertura_de_cada_una_de_las_especies__%__",
 NULL::text AS "measurement_type__área_total_muestreada_por_estación_",
 NULL::double precision AS "measurement_value__volumen_filtrado_",
 "measurement_value__área_total_raspada_por_muestra_"::double precision,
 "measurement_unit__área_total_raspada_por_muestra_"::text,
 NULL::text AS "measurement_unit__volumen_filtrado_",
 NULL::double precision AS "measurement_value__área_total_muestreada_por_estación_",
 NULL::text AS "measurement_unit__área_total_muestreada_por_estación_",
 NULL::text AS "measurement_type__profundidad_de_capa_fótica_",
 NULL::text AS "measurement_type__área_total_muestreada_para_hidrofitos_",
 NULL::double precision AS "measurement_value__profundidad_de_capa_fótica_",
 "measurement_type__área_total_raspada_por_estación_"::text,
 NULL::text AS "measurement_unit__profundidad_de_capa_fótica_",
 "measurement_value__área_total_raspada_por_estación_"::double precision,
 NULL::double precision AS "measurement_value__área_total_muestreada_para_hidrofitos_",
 NULL::text AS "measurement_unit__área_total_muestreada_para_hidrofitos_",
 "measurement_unit__área_total_raspada_por_estación_"::text,
 NULL::text AS "measurement_type__profundidad_total_",
 NULL::double precision AS "measurement_value__profundidad_total_",
 NULL::text AS "measurement_type__área_total_muestreada_en_zona_de_helófitas_",
 NULL::double precision AS "measurement_value__área_total_muestreada_en_zona_de_helófitas",
 NULL::text AS "measurement_unit__profundidad_total_",
 NULL::text AS "measurement_unit__área_total_muestreada_en_zona_de_helófitas_"
FROM raw_dwc.hidrobiologico_registros_macroinvertebrados
);


SELECT occurrence_id,count(*)
FROM raw_dwc.hidrobiologico_registros
GROUP BY occurrence_id
HAVING count(*)>1;
```

Podemos ver que, a pesar de esta asociación, los occurrence_id son
unicos en la tabla total.

## 11.2 Entender el plan de muestreo

Ya tenía entendido que las campañas de 2022 correspondían al periodo de
aguas bajas, pero parece que hay 3 eventos de 2021 en aguas bajas

``` sql
SELECT event_id,sampling_protocol
FROM raw_dwc.hidrobiologico_event
WHERE event_id!~'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$'
```

<div class="knitsql-table">

event_id sampling_protocol ———- ——————-

: 0 records

</div>

``` sql
WITH a AS(
SELECT event_id,
  REGEXP_REPLACE(event_id,'^(ANH[0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\1') anh_name,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\1')::int anh_num,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\2') grupo,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\9') repl,
  REGEXP_REPLACE(event_id,'^ANH[0-9]{1,3}-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\9') ='-Bajas' aguas_bajas,
  EXTRACT(YEAR FROM TO_DATE(event_date,'YYYY-MM-DD')) año,
  event_date
FROM raw_dwc.hidrobiologico_event
)
SELECT event_id, aguas_bajas, año, repl, event_date
FROM a
WHERE año=2021 AND aguas_bajas
```

<div class="knitsql-table">

| event_id        | aguas_bajas |  año | repl | event_date |
|:----------------|:------------|-----:|:-----|:-----------|
| ANH18-P-A-Bajas | TRUE        | 2021 | A    | 2021-07-23 |
| ANH18-P-B-Bajas | TRUE        | 2021 | B    | 2021-07-23 |
| ANH18-P-C-Bajas | TRUE        | 2021 | C    | 2021-07-23 |

3 records

</div>

``` sql
WITH a AS(
SELECT event_id,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\1')::int anh_num,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\2') grupo,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\9') repl,
  REGEXP_REPLACE(event_id,'^ANH[0-9]{1,3}-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\9') ='-Bajas' aguas_bajas,
  EXTRACT(YEAR FROM TO_DATE(event_date,'YYYY-MM-DD')) año
FROM raw_dwc.hidrobiologico_event
)
SELECT anh_num, grupo, año, aguas_bajas, ARRAY_AGG(repl ORDER BY repl)
FROM a
GROUP BY anh_num, aguas_bajas, grupo, año
ORDER BY anh_num, grupo, año
```

<div class="knitsql-table">

| anh_num | grupo |  año | aguas_bajas | array_agg |
|--------:|:------|-----:|:------------|:----------|
|       7 | F     | 2021 | FALSE       | {A,B,C}   |
|       7 | F     | 2022 | TRUE        | {A,B,C}   |
|       7 | MA    | 2021 | FALSE       | {““}      |
|       7 | MA    | 2022 | TRUE        | {““}      |
|       7 | MI    | 2021 | FALSE       | {A,B,C}   |
|       7 | MI    | 2022 | TRUE        | {A,B,C}   |
|       7 | P     | 2021 | FALSE       | {A,B,C}   |
|       7 | P     | 2022 | TRUE        | {A,B,C}   |
|       7 | Z     | 2021 | FALSE       | {A,B,C}   |
|       7 | Z     | 2022 | TRUE        | {A,B,C}   |
|       8 | F     | 2021 | FALSE       | {A,B,C}   |
|       8 | F     | 2022 | TRUE        | {A,B,C}   |
|       8 | MA    | 2021 | FALSE       | {““}      |
|       8 | MA    | 2022 | TRUE        | {““}      |
|       8 | MI    | 2021 | FALSE       | {A,B,C}   |
|       8 | MI    | 2022 | TRUE        | {A,B,C}   |
|       8 | P     | 2021 | FALSE       | {A,B,C}   |
|       8 | P     | 2022 | TRUE        | {A,B,C}   |
|       8 | Z     | 2021 | FALSE       | {A,B,C}   |
|       8 | Z     | 2022 | TRUE        | {A,B,C}   |
|       9 | F     | 2021 | FALSE       | {A,B,C}   |
|       9 | F     | 2022 | TRUE        | {A,B,C}   |
|       9 | MA    | 2021 | FALSE       | {““}      |
|       9 | MA    | 2022 | TRUE        | {““}      |
|       9 | MI    | 2021 | FALSE       | {A,B,C}   |
|       9 | MI    | 2022 | TRUE        | {A,B,C}   |
|       9 | P     | 2022 | TRUE        | {A,B,C}   |
|       9 | Z     | 2021 | FALSE       | {A,B,C}   |
|       9 | Z     | 2022 | TRUE        | {A,B,C}   |
|      10 | F     | 2021 | FALSE       | {A,B,C}   |
|      10 | F     | 2022 | TRUE        | {A,B,C}   |
|      10 | MA    | 2021 | FALSE       | {““}      |
|      10 | MA    | 2022 | TRUE        | {““}      |
|      10 | MI    | 2021 | FALSE       | {A,B,C}   |
|      10 | MI    | 2022 | TRUE        | {A,B,C}   |
|      10 | P     | 2021 | FALSE       | {A,B,C}   |
|      10 | P     | 2022 | TRUE        | {A,B,C}   |
|      10 | Z     | 2021 | FALSE       | {A,B,C}   |
|      10 | Z     | 2022 | TRUE        | {A,B,C}   |
|      11 | F     | 2021 | FALSE       | {A,B,C}   |
|      11 | F     | 2022 | TRUE        | {A,B,C}   |
|      11 | MA    | 2021 | FALSE       | {““}      |
|      11 | MA    | 2022 | TRUE        | {““}      |
|      11 | MI    | 2021 | FALSE       | {A,B,C}   |
|      11 | MI    | 2022 | TRUE        | {A,B,C}   |
|      11 | P     | 2021 | FALSE       | {A,B,C}   |
|      11 | P     | 2022 | TRUE        | {A,B,C}   |
|      11 | Z     | 2021 | FALSE       | {A,B,C}   |
|      11 | Z     | 2022 | TRUE        | {A,B,C}   |
|      12 | F     | 2021 | FALSE       | {A,B,C}   |
|      12 | F     | 2022 | TRUE        | {A,B,C}   |
|      12 | MA    | 2021 | FALSE       | {““}      |
|      12 | MA    | 2022 | TRUE        | {““}      |
|      12 | MI    | 2021 | FALSE       | {A,B,C}   |
|      12 | MI    | 2022 | TRUE        | {A,B,C}   |
|      12 | P     | 2021 | FALSE       | {A,B,C}   |
|      12 | P     | 2022 | TRUE        | {A,B,C}   |
|      12 | Z     | 2021 | FALSE       | {A,B,C}   |
|      12 | Z     | 2022 | TRUE        | {A,B,C}   |
|      13 | F     | 2021 | FALSE       | {A,B,C}   |
|      13 | F     | 2022 | TRUE        | {A,B,C}   |
|      13 | MA    | 2021 | FALSE       | {““}      |
|      13 | MA    | 2022 | TRUE        | {““}      |
|      13 | MI    | 2021 | FALSE       | {A,B,C}   |
|      13 | MI    | 2022 | TRUE        | {A,B,C}   |
|      13 | P     | 2021 | FALSE       | {A,B,C}   |
|      13 | P     | 2022 | TRUE        | {A,B,C}   |
|      13 | Z     | 2021 | FALSE       | {A,B,C}   |
|      13 | Z     | 2022 | TRUE        | {A,B,C}   |
|      14 | F     | 2021 | FALSE       | {A,B,C}   |
|      14 | F     | 2022 | TRUE        | {A,B,C}   |
|      14 | MA    | 2021 | FALSE       | {““}      |
|      14 | MA    | 2022 | TRUE        | {““}      |
|      14 | MI    | 2021 | FALSE       | {A,B,C}   |
|      14 | MI    | 2022 | TRUE        | {A,B,C}   |
|      14 | P     | 2021 | FALSE       | {A,B,C}   |
|      14 | P     | 2022 | TRUE        | {A,B,C}   |
|      14 | Z     | 2021 | FALSE       | {A,B,C}   |
|      14 | Z     | 2022 | TRUE        | {A,B,C}   |
|      15 | F     | 2021 | FALSE       | {A,B,C}   |
|      15 | F     | 2022 | TRUE        | {A,B,C}   |
|      15 | MA    | 2021 | FALSE       | {““}      |
|      15 | MA    | 2022 | TRUE        | {““}      |
|      15 | MI    | 2021 | FALSE       | {A,B,C}   |
|      15 | MI    | 2022 | TRUE        | {A,B,C}   |
|      15 | P     | 2022 | TRUE        | {A,B,C}   |
|      15 | Z     | 2021 | FALSE       | {A,B,C}   |
|      15 | Z     | 2022 | TRUE        | {A,B,C}   |
|      16 | F     | 2021 | FALSE       | {A,B,C}   |
|      16 | F     | 2022 | TRUE        | {A,B,C}   |
|      16 | MA    | 2021 | FALSE       | {““}      |
|      16 | MA    | 2022 | TRUE        | {““}      |
|      16 | MI    | 2021 | FALSE       | {A,B,C}   |
|      16 | MI    | 2022 | TRUE        | {A,B,C}   |
|      16 | P     | 2021 | FALSE       | {A,B,C}   |
|      16 | P     | 2022 | TRUE        | {A,B,C}   |
|      16 | Z     | 2021 | FALSE       | {A,B,C}   |
|      16 | Z     | 2022 | TRUE        | {A,B,C}   |
|      17 | F     | 2021 | FALSE       | {A,B,C}   |
|      17 | F     | 2022 | TRUE        | {A,B,C}   |

Displaying records 1 - 100

</div>

**IMPORTANTE: limpiar los protocolos de muestreo del perifiton y de los
macroinvertebrados**

**Acá, parecen varios “sampling_protocol” por grupo pero yo tenía
entendido que había solo un protocolo de campo por grupo biologico**

``` sql
WITH a AS(
SELECT event_id,sampling_protocol,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\1')::int anh_num,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\2') grupo,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\9') repl,
  REGEXP_REPLACE(event_id,'^ANH[0-9]{1,3}-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\9') ='-Bajas' aguas_bajas,
  EXTRACT(YEAR FROM TO_DATE(event_date,'YYYY-MM-DD')) año
FROM raw_dwc.hidrobiologico_event
)
SELECT grupo,sampling_protocol,count(*)
FROM a
GROUP BY sampling_protocol,grupo
ORDER BY grupo,sampling_protocol
```

<div class="knitsql-table">

| grupo | sampling_protocol                                                        | count |
|:------|:-------------------------------------------------------------------------|------:|
| F     | Botella Van Dorn                                                         |   246 |
| MA    | Cuadrante 1x1 m                                                          |    82 |
| MI    | Draga                                                                    |    27 |
| MI    | Draga/Red tipo D - Asociados a macrofitas                                |     8 |
| MI    | Kick Sampling Red Tipo D                                                 |   132 |
| MI    | Red tipo D - Asociados a macrofitas                                      |    79 |
| P     | 12 raspados                                                              |     3 |
| P     | Raspados de epifiton                                                     |    33 |
| P     | Raspados de epifiton/Raspados en sustratos duros con cuadrante de 3x3 cm |     1 |
| P     | Raspados en plantas acuáticas con cuadrante de 3x3 cm                    |    12 |
| P     | Raspados en sustratos duros con cuadrante de 3x3 cm                      |   185 |
| Z     | Botella Van Dorn                                                         |   246 |

12 records

</div>

Para entender los sampling protocols, intentar en los registros:

``` sql
SELECT 
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\2') grupo,
  e.sampling_protocol, r.sampling_protocol, count(*)
FROM raw_dwc.hidrobiologico_event e
LEFT JOIN (SELECT DISTINCT event_id,sampling_protocol FROM raw_dwc.hidrobiologico_registros) r USING (event_id)
GROUP BY  grupo, e.sampling_protocol, r.sampling_protocol
ORDER BY grupo, r.sampling_protocol, count(*)
```

<div class="knitsql-table">

| grupo | sampling_protocol                                                        | sampling_protocol                                   | count |
|:------|:-------------------------------------------------------------------------|:----------------------------------------------------|------:|
| F     | Botella Van Dorn                                                         | Botella Van Dorn                                    |   212 |
| F     | Botella Van Dorn                                                         | NA                                                  |    34 |
| MA    | Cuadrante 1x1 m                                                          | Cuadrante 1x1 m                                     |    82 |
| MI    | Draga/Red tipo D - Asociados a macrofitas                                | Draga                                               |     1 |
| MI    | Draga                                                                    | Draga                                               |    19 |
| MI    | Draga/Red tipo D - Asociados a macrofitas                                | Draga/Red tipo D - Asociados a macrofitas           |     7 |
| MI    | Red tipo D - Asociados a macrofitas                                      | Kick Sampling Red Tipo D                            |     2 |
| MI    | Kick Sampling Red Tipo D                                                 | Kick Sampling Red Tipo D                            |   130 |
| MI    | Red tipo D - Asociados a macrofitas                                      | Red tipo D - Asociados a macrofitas                 |    77 |
| MI    | Kick Sampling Red Tipo D                                                 | NA                                                  |     2 |
| MI    | Draga                                                                    | NA                                                  |     8 |
| P     | Raspados en sustratos duros con cuadrante de 3x3 cm                      | Raspados de epifiton                                |     2 |
| P     | Raspados de epifiton                                                     | Raspados de epifiton                                |    26 |
| P     | Raspados de epifiton/Raspados en sustratos duros con cuadrante de 3x3 cm | Raspados en sustratos duros con cuadrante de 3x3 cm |     1 |
| P     | Raspados de epifiton                                                     | Raspados en sustratos duros con cuadrante de 3x3 cm |     7 |
| P     | Raspados en plantas acuáticas con cuadrante de 3x3 cm                    | Raspados en sustratos duros con cuadrante de 3x3 cm |     9 |
| P     | Raspados en sustratos duros con cuadrante de 3x3 cm                      | Raspados en sustratos duros con cuadrante de 3x3 cm |   166 |
| P     | 12 raspados                                                              | NA                                                  |     3 |
| P     | Raspados en plantas acuáticas con cuadrante de 3x3 cm                    | NA                                                  |     3 |
| P     | Raspados en sustratos duros con cuadrante de 3x3 cm                      | NA                                                  |    17 |
| Z     | Botella Van Dorn                                                         | Botella Van Dorn                                    |   195 |
| Z     | Botella Van Dorn                                                         | NA                                                  |    51 |

22 records

</div>

Intentar los sampling_efforts

``` sql
SELECT 
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\2') grupo,
  sampling_protocol,e.sampling_effort, count(*)
FROM raw_dwc.hidrobiologico_event e
GROUP BY  grupo,e.sampling_protocol, e.sampling_effort
ORDER BY grupo, e.sampling_effort, count(*)
```

<div class="knitsql-table">

| grupo | sampling_protocol                                                        | sampling_effort                | count |
|:------|:-------------------------------------------------------------------------|:-------------------------------|------:|
| F     | Botella Van Dorn                                                         | 9 replicas Botella             |   246 |
| MA    | Cuadrante 1x1 m                                                          | 100 cuadrantes                 |     1 |
| MA    | Cuadrante 1x1 m                                                          | 120 cuadrantes                 |     1 |
| MA    | Cuadrante 1x1 m                                                          | 12 cuadrantes                  |     2 |
| MA    | Cuadrante 1x1 m                                                          | 20 cuadrantes                  |    21 |
| MA    | Cuadrante 1x1 m                                                          | 30 cuadrantes                  |     7 |
| MA    | Cuadrante 1x1 m                                                          | 40 cuadrantes                  |    17 |
| MA    | Cuadrante 1x1 m                                                          | 50 cuadrantes                  |    18 |
| MA    | Cuadrante 1x1 m                                                          | 60 cuadrantes                  |     2 |
| MA    | Cuadrante 1x1 m                                                          | 70 cuadrantes                  |     2 |
| MA    | Cuadrante 1x1 m                                                          | 80 cuadrantes                  |    11 |
| MI    | Kick Sampling Red Tipo D                                                 | 20 Kicks                       |   132 |
| MI    | Draga/Red tipo D - Asociados a macrofitas                                | 3/2 repeticiones               |     1 |
| MI    | Draga/Red tipo D - Asociados a macrofitas                                | 3/4 repeticiones               |     4 |
| MI    | Draga/Red tipo D - Asociados a macrofitas                                | 3/5 repeticiones               |     3 |
| MI    | Draga                                                                    | 3 repeticiones                 |    27 |
| MI    | Red tipo D - Asociados a macrofitas                                      | 5 arrastres                    |    79 |
| P     | Raspados de epifiton                                                     | 10 tallos sumergidos           |    31 |
| P     | 12 raspados                                                              | 12 raspados                    |     3 |
| P     | Raspados en plantas acuáticas con cuadrante de 3x3 cm                    | 12 raspados                    |    12 |
| P     | Raspados en sustratos duros con cuadrante de 3x3 cm                      | 12 raspados                    |   185 |
| P     | Raspados de epifiton                                                     | 12 tallos sumergidos           |     1 |
| P     | Raspados de epifiton                                                     | 5 tallos sumergidos            |     1 |
| P     | Raspados de epifiton/Raspados en sustratos duros con cuadrante de 3x3 cm | 7 tallos sumergidos/2 raspados |     1 |
| Z     | Botella Van Dorn                                                         | 9 replicas Botella             |   246 |

25 records

</div>

Parece que en macroinvertebrados hay 3 protocolos, más una asociación
entre protocolos:

1.  dragas
2.  redes tipo D (en asociacion con macrofitas)
3.  kick sampling
4.  asociación (usualmente entre dragas y redes tipoD

**Anotar, veo unos sampling_protocol que son: Kick sampling red tipo d
(no sé si son 2 metodos, pero como los kick sampling siempre están en
este sampling_protocol, voy a considerar que es un protocolo)**

Entonces podemos adaptar los codigos anteriores así:

``` sql
WITH a AS(
SELECT event_id,
  REGEXP_REPLACE(event_id,'^(ANH)([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\1_\2') anh_name,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\1')::int anh_num,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\2') grupo,
  CASE
       WHEN sampling_protocol='Draga' THEN 'D'
       WHEN sampling_protocol='Draga/Red tipo D - Asociados a macrofitas' THEN 'DR'
       WHEN sampling_protocol='Kick Sampling Red Tipo D' THEN 'K'
       WHEN sampling_protocol='Red tipo D - Asociados a macrofitas' THEN 'R'
       WHEN sampling_protocol~'[Rr]aspados' THEN 'Ra'
       WHEN sampling_protocol~'Botella Van Dorn' THEN 'B'
       WHEN sampling_protocol='Cuadrante 1x1 m' THEN 'C'
  END metodo,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\9') repl,
  REGEXP_REPLACE(event_id,'^ANH[0-9]{1,3}-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\9') ='-Bajas' aguas_bajas,
  EXTRACT(YEAR FROM TO_DATE(event_date,'YYYY-MM-DD')) año
FROM raw_dwc.hidrobiologico_event
)
SELECT anh_num,año, ARRAY_AGG(DISTINCT grupo ORDER BY grupo)
FROM a
GROUP BY anh_num,año
```

<div class="knitsql-table">

| anh_num |  año | array_agg     |
|--------:|-----:|:--------------|
|       7 | 2021 | {F,MA,MI,P,Z} |
|       7 | 2022 | {F,MA,MI,P,Z} |
|       8 | 2021 | {F,MA,MI,P,Z} |
|       8 | 2022 | {F,MA,MI,P,Z} |
|       9 | 2021 | {F,MA,MI,Z}   |
|       9 | 2022 | {F,MA,MI,P,Z} |
|      10 | 2021 | {F,MA,MI,P,Z} |
|      10 | 2022 | {F,MA,MI,P,Z} |
|      11 | 2021 | {F,MA,MI,P,Z} |
|      11 | 2022 | {F,MA,MI,P,Z} |
|      12 | 2021 | {F,MA,MI,P,Z} |
|      12 | 2022 | {F,MA,MI,P,Z} |
|      13 | 2021 | {F,MA,MI,P,Z} |
|      13 | 2022 | {F,MA,MI,P,Z} |
|      14 | 2021 | {F,MA,MI,P,Z} |
|      14 | 2022 | {F,MA,MI,P,Z} |
|      15 | 2021 | {F,MA,MI,Z}   |
|      15 | 2022 | {F,MA,MI,P,Z} |
|      16 | 2021 | {F,MA,MI,P,Z} |
|      16 | 2022 | {F,MA,MI,P,Z} |
|      17 | 2021 | {F,MA,MI,P,Z} |
|      17 | 2022 | {F,MA,MI,P,Z} |
|      18 | 2021 | {F,MA,MI,P,Z} |
|      18 | 2022 | {F,MA,MI,Z}   |
|      19 | 2021 | {F,MA,MI,P,Z} |
|      19 | 2022 | {F,MA,MI,P,Z} |
|      20 | 2021 | {F,MA,MI,P,Z} |
|      20 | 2022 | {F,MA,MI,Z}   |
|      21 | 2021 | {F,MA,MI,P,Z} |
|      21 | 2022 | {F,MA,MI,P,Z} |
|      32 | 2021 | {F,MA,MI,P,Z} |
|      32 | 2022 | {F,MA,MI,P,Z} |
|      33 | 2021 | {F,MA,MI,Z}   |
|      33 | 2022 | {F,MA,MI,P,Z} |
|      34 | 2021 | {F,MA,MI,P,Z} |
|      34 | 2022 | {F,MA,MI,P,Z} |
|      35 | 2021 | {F,MA,MI,P,Z} |
|      35 | 2022 | {F,MA,MI,P,Z} |
|      37 | 2021 | {F,MA,MI,P,Z} |
|      37 | 2022 | {F,MA,MI,P,Z} |
|      38 | 2021 | {F,MA,MI,P,Z} |
|      38 | 2022 | {F,MA,MI,P,Z} |
|      39 | 2021 | {F,MA,MI,P,Z} |
|      39 | 2022 | {F,MA,MI,P,Z} |
|      40 | 2021 | {F,MA,MI,P,Z} |
|      40 | 2022 | {F,MA,MI,P,Z} |
|      41 | 2021 | {F,MA,MI,P,Z} |
|      41 | 2022 | {F,MA,MI,P,Z} |
|      42 | 2021 | {F,MA,MI,P,Z} |
|      42 | 2022 | {F,MA,MI,P,Z} |
|      43 | 2021 | {F,MA,MI,P,Z} |
|      43 | 2022 | {F,MA,MI,P,Z} |
|     291 | 2021 | {F,MA,MI,P,Z} |
|     291 | 2022 | {F,MA,MI,P,Z} |
|     292 | 2021 | {F,MA,MI,P,Z} |
|     292 | 2022 | {F,MA,MI,P,Z} |
|     293 | 2021 | {F,MA,MI,P,Z} |
|     293 | 2022 | {F,MA,MI,P,Z} |
|     294 | 2021 | {F,MA,MI,P,Z} |
|     294 | 2022 | {F,MA,MI,P,Z} |
|     295 | 2021 | {F,MA,MI,P,Z} |
|     295 | 2022 | {F,MA,MI,P,Z} |
|     296 | 2021 | {F,MA,MI,P,Z} |
|     296 | 2022 | {F,MA,MI,P,Z} |
|     297 | 2021 | {F,MA,MI,P,Z} |
|     297 | 2022 | {F,MA,MI,P,Z} |
|     298 | 2021 | {F,MA,MI,P,Z} |
|     298 | 2022 | {F,MA,MI,P,Z} |
|     299 | 2021 | {F,MA,MI,P,Z} |
|     299 | 2022 | {F,MA,MI,P,Z} |
|     300 | 2021 | {F,MA,MI,P,Z} |
|     300 | 2022 | {F,MA,MI,P,Z} |
|     301 | 2021 | {F,MA,MI,P,Z} |
|     301 | 2022 | {F,MA,MI,P,Z} |
|     302 | 2021 | {F,MA,MI,P,Z} |
|     302 | 2022 | {F,MA,MI,P,Z} |
|     303 | 2021 | {F,MA,MI,P,Z} |
|     303 | 2022 | {F,MA,MI,P,Z} |
|     304 | 2021 | {F,MA,MI,P,Z} |
|     304 | 2022 | {F,MA,MI,P,Z} |
|     305 | 2021 | {F,MA,MI,P,Z} |
|     305 | 2022 | {F,MA,MI,P,Z} |

82 records

</div>

Utilizando esta separación de los metodos, podemos ver que, en un anh,
para un grupo, siempre se utiliza un solo metodo, con repeticiones
posibles (lo que nos va a facilitar la asignación de gp_event

``` sql
WITH a AS(
SELECT event_id,
  REGEXP_REPLACE(event_id,'^(ANH[0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\1') anh_name,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\1')::int anh_num,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\2') grupo,
  CASE
       WHEN sampling_protocol='Draga' THEN 'D'
       WHEN sampling_protocol='Draga/Red tipo D - Asociados a macrofitas' THEN 'DR'
       WHEN sampling_protocol='Kick Sampling Red Tipo D' THEN 'K'
       WHEN sampling_protocol='Red tipo D - Asociados a macrofitas' THEN 'R'
       WHEN sampling_protocol~'[Rr]aspados' THEN 'Ra'
       WHEN sampling_protocol~'Botella Van Dorn' THEN 'B'
       WHEN sampling_protocol='Cuadrante 1x1 m' THEN 'C'
  END metodo,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\9') repl,
  REGEXP_REPLACE(event_id,'^ANH[0-9]{1,3}-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\9') ='-Bajas' aguas_bajas,
  EXTRACT(YEAR FROM TO_DATE(event_date,'YYYY-MM-DD')) año
FROM raw_dwc.hidrobiologico_event
)
SELECT anh_num,año, grupo, ARRAY_AGG(DISTINCT metodo), count(*)
FROM a
GROUP BY anh_num,año,grupo
```

<div class="knitsql-table">

| anh_num |  año | grupo | array_agg | count |
|--------:|-----:|:------|:----------|------:|
|       7 | 2021 | F     | {B}       |     3 |
|       7 | 2021 | MA    | {C}       |     1 |
|       7 | 2021 | MI    | {K}       |     3 |
|       7 | 2021 | P     | {Ra}      |     3 |
|       7 | 2021 | Z     | {B}       |     3 |
|       7 | 2022 | F     | {B}       |     3 |
|       7 | 2022 | MA    | {C}       |     1 |
|       7 | 2022 | MI    | {K}       |     3 |
|       7 | 2022 | P     | {Ra}      |     3 |
|       7 | 2022 | Z     | {B}       |     3 |
|       8 | 2021 | F     | {B}       |     3 |
|       8 | 2021 | MA    | {C}       |     1 |
|       8 | 2021 | MI    | {K}       |     3 |
|       8 | 2021 | P     | {Ra}      |     3 |
|       8 | 2021 | Z     | {B}       |     3 |
|       8 | 2022 | F     | {B}       |     3 |
|       8 | 2022 | MA    | {C}       |     1 |
|       8 | 2022 | MI    | {K}       |     3 |
|       8 | 2022 | P     | {Ra}      |     3 |
|       8 | 2022 | Z     | {B}       |     3 |
|       9 | 2021 | F     | {B}       |     3 |
|       9 | 2021 | MA    | {C}       |     1 |
|       9 | 2021 | MI    | {R}       |     3 |
|       9 | 2021 | Z     | {B}       |     3 |
|       9 | 2022 | F     | {B}       |     3 |
|       9 | 2022 | MA    | {C}       |     1 |
|       9 | 2022 | MI    | {R}       |     3 |
|       9 | 2022 | P     | {Ra}      |     3 |
|       9 | 2022 | Z     | {B}       |     3 |
|      10 | 2021 | F     | {B}       |     3 |
|      10 | 2021 | MA    | {C}       |     1 |
|      10 | 2021 | MI    | {R}       |     3 |
|      10 | 2021 | P     | {Ra}      |     3 |
|      10 | 2021 | Z     | {B}       |     3 |
|      10 | 2022 | F     | {B}       |     3 |
|      10 | 2022 | MA    | {C}       |     1 |
|      10 | 2022 | MI    | {R}       |     3 |
|      10 | 2022 | P     | {Ra}      |     3 |
|      10 | 2022 | Z     | {B}       |     3 |
|      11 | 2021 | F     | {B}       |     3 |
|      11 | 2021 | MA    | {C}       |     1 |
|      11 | 2021 | MI    | {R}       |     3 |
|      11 | 2021 | P     | {Ra}      |     3 |
|      11 | 2021 | Z     | {B}       |     3 |
|      11 | 2022 | F     | {B}       |     3 |
|      11 | 2022 | MA    | {C}       |     1 |
|      11 | 2022 | MI    | {R}       |     3 |
|      11 | 2022 | P     | {Ra}      |     3 |
|      11 | 2022 | Z     | {B}       |     3 |
|      12 | 2021 | F     | {B}       |     3 |
|      12 | 2021 | MA    | {C}       |     1 |
|      12 | 2021 | MI    | {K}       |     3 |
|      12 | 2021 | P     | {Ra}      |     3 |
|      12 | 2021 | Z     | {B}       |     3 |
|      12 | 2022 | F     | {B}       |     3 |
|      12 | 2022 | MA    | {C}       |     1 |
|      12 | 2022 | MI    | {K}       |     3 |
|      12 | 2022 | P     | {Ra}      |     3 |
|      12 | 2022 | Z     | {B}       |     3 |
|      13 | 2021 | F     | {B}       |     3 |
|      13 | 2021 | MA    | {C}       |     1 |
|      13 | 2021 | MI    | {K}       |     3 |
|      13 | 2021 | P     | {Ra}      |     3 |
|      13 | 2021 | Z     | {B}       |     3 |
|      13 | 2022 | F     | {B}       |     3 |
|      13 | 2022 | MA    | {C}       |     1 |
|      13 | 2022 | MI    | {K}       |     3 |
|      13 | 2022 | P     | {Ra}      |     3 |
|      13 | 2022 | Z     | {B}       |     3 |
|      14 | 2021 | F     | {B}       |     3 |
|      14 | 2021 | MA    | {C}       |     1 |
|      14 | 2021 | MI    | {K}       |     3 |
|      14 | 2021 | P     | {Ra}      |     3 |
|      14 | 2021 | Z     | {B}       |     3 |
|      14 | 2022 | F     | {B}       |     3 |
|      14 | 2022 | MA    | {C}       |     1 |
|      14 | 2022 | MI    | {K}       |     3 |
|      14 | 2022 | P     | {Ra}      |     3 |
|      14 | 2022 | Z     | {B}       |     3 |
|      15 | 2021 | F     | {B}       |     3 |
|      15 | 2021 | MA    | {C}       |     1 |
|      15 | 2021 | MI    | {R}       |     3 |
|      15 | 2021 | Z     | {B}       |     3 |
|      15 | 2022 | F     | {B}       |     3 |
|      15 | 2022 | MA    | {C}       |     1 |
|      15 | 2022 | MI    | {R}       |     3 |
|      15 | 2022 | P     | {Ra}      |     3 |
|      15 | 2022 | Z     | {B}       |     3 |
|      16 | 2021 | F     | {B}       |     3 |
|      16 | 2021 | MA    | {C}       |     1 |
|      16 | 2021 | MI    | {R}       |     3 |
|      16 | 2021 | P     | {Ra}      |     3 |
|      16 | 2021 | Z     | {B}       |     3 |
|      16 | 2022 | F     | {B}       |     3 |
|      16 | 2022 | MA    | {C}       |     1 |
|      16 | 2022 | MI    | {R}       |     3 |
|      16 | 2022 | P     | {Ra}      |     3 |
|      16 | 2022 | Z     | {B}       |     3 |
|      17 | 2021 | F     | {B}       |     3 |
|      17 | 2021 | MA    | {C}       |     1 |

Displaying records 1 - 100

</div>

## 11.3 ANH

Insertar los datos de anh:

``` sql
INSERT INTO main.punto_referencia(name_pt_ref, num_anh)
WITH a AS(
SELECT
  REGEXP_REPLACE(event_id,'^(ANH)([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\1_\2') anh_name,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\1')::int anh_num
FROM raw_dwc.hidrobiologico_event
)
SELECT anh_name, anh_num
FROM a
WHERE anh_name IS NOT NULL
GROUP BY anh_name,anh_num
ORDER BY anh_num
ON CONFLICT (name_pt_ref) DO NOTHING
RETURNING cd_pt_ref, name_pt_ref
;
```

dar las referencias en las tablas totales de mamiferos

``` sql
ALTER TABLE raw_dwc.hidrobiologico_event ADD COLUMN cd_pt_ref int REFERENCES main.punto_referencia(cd_pt_ref) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE raw_dwc.hidrobiologico_registros ADD COLUMN cd_pt_ref int REFERENCES main.punto_referencia(cd_pt_ref) ON DELETE SET NULL ON UPDATE CASCADE;

WITH a AS(
SELECT event_id,
  REGEXP_REPLACE(event_id,'^(ANH)([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\1_\2') anh_name,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\1')::int anh_num
FROM raw_dwc.hidrobiologico_event
)
UPDATE raw_dwc.hidrobiologico_event AS m
SET cd_pt_ref=pr.cd_pt_ref
FROM main.punto_referencia pr, a
WHERE m.event_id=a.event_id AND a.anh_name = name_pt_ref
;

WITH a AS(
SELECT event_id,
  REGEXP_REPLACE(event_id,'^(ANH)([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\1_\2') anh_name,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\1')::int anh_num
FROM raw_dwc.hidrobiologico_registros
)
UPDATE raw_dwc.hidrobiologico_registros AS m
SET cd_pt_ref=pr.cd_pt_ref
FROM main.punto_referencia pr, a
WHERE m.event_id=a.event_id AND a.anh_name = name_pt_ref
;

SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

Averiguando que ninguna fila no tenga anh

``` sql
SELECT event_id FROM raw_dwc.hidrobiologico_event WHERE cd_pt_ref IS NULL;
```

<div class="knitsql-table">

event_id ———-

: 0 records

</div>

``` sql
SELECT event_id,occurrence_id FROM raw_dwc.hidrobiologico_registros WHERE cd_pt_ref IS NULL;
```

<div class="knitsql-table">

event_id occurrence_id ———- —————

: 0 records

</div>

## 11.4 Unit, sampling efforts definition, abundance definition, protocolo

**Anotar: lo que llamaron abundancia relativa en las tablas es
abundancia absoluta**

**Anotar: lo que llamaron cobertura en las tablas es area de cobertura
no parece estar en porcentajes, a pesar del nombre de la variable**

``` sql
INSERT INTO main.def_unit(cd_measurement_type, unit, unit_spa, abbv_unit,factor)
VALUES(
  (SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='density'),
  'Individuals per square centimeter',
  'Individuos por centimetro cuadrado',
  'Ind/cm2',
  1
  ),(
  (SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='density'),
  'Individuals per square meter',
  'Individuos por metro cuadrado',
  'Ind/m2',
  10000
  ),(
  (SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='percentage'),
  'Percentage',
  'Porcentaje',
  '%',
  1
  )
  ,(
  (SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='number concentration'),
  'Individuals per liter',
  'Individuos por litro',
  'Ind/L',
  1
  )
  ,(
  (SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='area'),
  'Square centimeters',
  'Centimetros cuadrados',
  'cm2',
  0.0001
  )
  ,(
  (SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='volume'),
  'Liters',
  'Litros',
  'L',
  1000
  )
  ,(
  (SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='number of traps'),
  'Number of quadrat',
  'Número de cuadrante',
  'Quadrats',
  1
  )
  ,(
  (SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='number of traps'),
  'Number of bottles',
  'Número de botellas',
  'bottles',
  1
  )
  ,(
  (SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='number of traps'),
  'Number of scraped areas',
  'Número de raspados',
  'raspados',
  1
  )
  ,(
  (SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='number of traps'),
  'Number of submerged stems',
  'Número de tallos sumergidos',
  'stems',
  1
  )
  ,(
  (SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='number of traps'),
  'Number of kicks',
  'Número de kicks',
  'kicks',
  1
  )
  ,(
  (SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='number of traps'),
  'Number of replicates',
  'Número de repeticiones',
  'replicates',
  1
  )
RETURNING cd_unit, unit, unit_spa
```

``` sql
INSERT INTO main.def_var_ind_qt(var_qt_ind, var_qt_ind_spa, cd_unit, type_variable)
VALUES
(
  'Individual density (ind/cm2)',
  'Densidad de individuos (ind/cm2)',
  (SELECT cd_unit FROM main.def_unit WHERE cd_measurement_type=(SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='density') AND unit='Individuals per square centimeter'),
  'double precision'
),
(
  'Individual density (ind/m2)',
  'Densidad de individuos (ind/m2)',
  (SELECT cd_unit FROM main.def_unit WHERE cd_measurement_type=(SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='density') AND unit='Individuals per square meter'),
  'double precision'
),
(
  'Individual concentration',
  'Concentración de individuos',
  (SELECT cd_unit FROM main.def_unit WHERE cd_measurement_type=(SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='number concentration') AND unit='Individuals per liter'),
  'double precision'
),
(
  'Absolute coverage',
  'Cobertura absoluta',
  (SELECT cd_unit FROM main.def_unit WHERE cd_measurement_type=(SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='area') AND unit='Square meter'),
  'double precision'
),
(
  'Cover (%)',
  'Cobertura (%)',
  (SELECT cd_unit FROM main.def_unit WHERE cd_measurement_type=(SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='percentage') AND unit='Percentage'),
  'double precision'
)
RETURNING cd_var_ind_qt,var_qt_ind
;
```

``` sql
INSERT INTO main.def_var_samp_eff(var_samp_eff, var_samp_eff_spa, cd_unit,type_variable)
VALUES
  (
  'Number of quadrats',
  'Número de cuadrantes',
  (SELECT cd_unit FROM main.def_unit WHERE cd_measurement_type=(SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='number of traps') AND unit='Number of quadrat'),
  'int'
  )
  ,(
  'Number of bottles',
  'Número de botellas',
  (SELECT cd_unit FROM main.def_unit WHERE cd_measurement_type=(SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='number of traps') AND unit='Number of bottles'),
  'int'
  )
  ,(
  'Number of scraped areas',
  'Número de raspados',
  (SELECT cd_unit FROM main.def_unit WHERE cd_measurement_type=(SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='number of traps') AND unit='Number of scraped areas'),
  'int'
  )
  ,(
  'Number of submerged stems',
  'Número de tallos sumergidos',
  (SELECT cd_unit FROM main.def_unit WHERE cd_measurement_type=(SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='number of traps') AND unit='Number of submerged stems'),
  'int'
  )
  ,(
  'Number of kicks',
  'Número de kicks',
  (SELECT cd_unit FROM main.def_unit WHERE cd_measurement_type=(SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='number of traps') AND unit='Number of kicks'),
  'int'
  )
  ,(
  'Sampling volume (L)',
  'Volumen de muestreo (L)',
  (SELECT cd_unit FROM main.def_unit WHERE cd_measurement_type=(SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='volume') AND unit='Liters'),
  'double precision'
  )
  ,(
  'Sampling area (cm2)',
  'Superficie de muestreo (cm2)',
  (SELECT cd_unit FROM main.def_unit WHERE cd_measurement_type=(SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='area') AND unit='Square centimeters'),
  'int'
  )
  ,(
  'Number of replicates',
  'Número de repeticiones',
  (SELECT cd_unit FROM main.def_unit WHERE cd_measurement_type=(SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='number of traps') AND unit='Number of replicates'),
  'int'
  )


RETURNING cd_var_samp_eff, var_samp_eff;
```

``` sql
INSERT INTO main.def_protocol(protocol,protocol_spa,cd_var_samp_eff_1,cd_var_samp_eff_2,samp_eff_1_implicit,samp_eff_2_implicit,cd_var_ind_qt,description_spa)
VALUES(
  'Grab collector',
  'Draga',
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Sampling area'),
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Number of replicates'),
  false,
  false,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind='Individual density (ind/m2)'),
  NULL
)
,(
  'Substrate scraping',
  'Raspados',
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Sampling area (cm2)'),
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Number of replicates'),
  false,
  false,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind_spa='Densidad de individuos (ind/cm2)'),
  NULL
)
,(
  'Sampling quadrats',
  'Cuadrantes',
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Sampling area'),
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Number of quadrats'),
  false,
  false,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind='Cover (%)'),
  NULL
)
,(
  'D net kick sampling',
  'Kick',
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Sampling area'),
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Number of kicks'),
  false,
  false,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind='Individual density (ind/m2)'),
  'Kick Sampling Red Tipo D'
)
,(
  'Van Dorn Bottle',
  'Botella Van Dorn',
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Sampling volume (L)'),
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Number of bottles'),
  false,
  false,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind='Individual concentration'),
  NULL
)
,(
  'D net (associated with macrophytes)',
  'Red tipo D asociados con macrofitas',
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Sampling area'),
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Number of trawl nets'),
  false,
  false,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind='Individual density (ind/m2)'),
  'type D nets associated to macrophytes'
)
,(
  'Grab collector + type D net',
  'Draga + Red tipo D',
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Sampling area'),
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Number of replicates'),
  false,
  false,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind_spa='Densidad de individuos (ind/m2)'),
  'Draga/Red tipo D - Asociados a macrofitas, Se trata de una asociacion entre metodos, por las condiciones particulares del evento de muestreo'
)

RETURNING cd_protocol,protocol,protocol_spa;
```

## 11.5 Personas

``` sql
INSERT INTO main.people(verbatim_person)
WITH a AS(
SELECT DISTINCT INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(recorded_by, ' | ')))) AS name_person
FROM raw_dwc.hidrobiologico_registros
UNION
SELECT DISTINCT INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(identified_by, ' | '))))
FROM raw_dwc.hidrobiologico_registros
)
SELECT DISTINCT REGEXP_REPLACE(name_person, '- ','-')
FROM a 
ORDER BY REGEXP_REPLACE(name_person, '- ','-')
ON CONFLICT(verbatim_person) DO NOTHING
RETURNING cd_person, verbatim_person
```

Dar los codigos a las tables de origen:

``` sql
ALTER TABLE raw_dwc.hidrobiologico_registros ADD COLUMN cds_recorded_by int[];

WITH a AS(
SELECT table_orig,"row.names", REGEXP_REPLACE(INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(recorded_by, ' | ')))),'- ','-') AS name_person
FROM raw_dwc.hidrobiologico_registros
),b AS(
SELECT table_orig,"row.names", ARRAY_AGG(cd_person) cds
FROM a 
LEFT JOIN main.people p ON a.name_person=p.verbatim_person
GROUP BY table_orig,"row.names"
)
UPDATE raw_dwc.hidrobiologico_registros AS r
SET cds_recorded_by=b.cds
FROM b
WHERE r."row.names"=b."row.names" AND r.table_orig=b.table_orig
RETURNING r."row.names", cds_recorded_by
;

ALTER TABLE raw_dwc.hidrobiologico_registros ADD COLUMN cds_identified_by int[];

WITH a AS(
SELECT table_orig,"row.names", REGEXP_REPLACE(INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(identified_by, ' | ')))),'- ','-') AS name_person
FROM raw_dwc.hidrobiologico_registros
),b AS(
SELECT table_orig,"row.names", ARRAY_AGG(cd_person) cds
FROM a 
LEFT JOIN main.people p ON a.name_person=p.verbatim_person
GROUP BY table_orig,"row.names"
)
UPDATE raw_dwc.hidrobiologico_registros AS r
SET cds_identified_by=b.cds
FROM b
WHERE r."row.names"=b."row.names" AND r.table_orig=b.table_orig
RETURNING r."row.names", cds_identified_by
;

SELECT 1;
```

<div class="knitsql-table">

| ?column? |
|---------:|
|        1 |

1 records

</div>

## 11.6 gp_event

``` sql
WITH a AS(
SELECT 
  event_id,
  REGEXP_REPLACE(event_id,'^(ANH)([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\1_\2') anh_name,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\1')::int anh_num,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\2') grupo,
  CASE
       WHEN sampling_protocol='Draga' THEN 'D'
       WHEN sampling_protocol='Draga/Red tipo D - Asociados a macrofitas' THEN 'DR'
       WHEN sampling_protocol='Kick Sampling Red Tipo D' THEN 'K'
       WHEN sampling_protocol='Red tipo D - Asociados a macrofitas' THEN 'R'
       WHEN sampling_protocol~'[Rr]aspados' THEN 'Ra'
       WHEN sampling_protocol~'Botella Van Dorn' THEN 'B'
       WHEN sampling_protocol='Cuadrante 1x1 m' THEN 'C'
  END metodo,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\9') repli,
  REGEXP_REPLACE(event_id,'^ANH[0-9]{1,3}-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\9') ='-Bajas' aguas_bajas,
  EXTRACT(YEAR FROM TO_DATE(event_date,'YYYY-MM-DD')) año
FROM raw_dwc.hidrobiologico_event
)
SELECT año,grupo, anh_num,metodo, ARRAY_AGG(repli), count(*)
FROM a
GROUP BY año, grupo, anh_num, metodo
ORDER BY año, grupo, anh_num, metodo
;
```

<div class="knitsql-table">

|  año | grupo | anh_num | metodo | array_agg | count |
|-----:|:------|--------:|:-------|:----------|------:|
| 2021 | F     |       7 | B      | {C,A,B}   |     3 |
| 2021 | F     |       8 | B      | {A,B,C}   |     3 |
| 2021 | F     |       9 | B      | {B,A,C}   |     3 |
| 2021 | F     |      10 | B      | {A,B,C}   |     3 |
| 2021 | F     |      11 | B      | {B,C,A}   |     3 |
| 2021 | F     |      12 | B      | {B,C,A}   |     3 |
| 2021 | F     |      13 | B      | {A,B,C}   |     3 |
| 2021 | F     |      14 | B      | {A,B,C}   |     3 |
| 2021 | F     |      15 | B      | {B,C,A}   |     3 |
| 2021 | F     |      16 | B      | {B,C,A}   |     3 |
| 2021 | F     |      17 | B      | {B,A,C}   |     3 |
| 2021 | F     |      18 | B      | {B,A,C}   |     3 |
| 2021 | F     |      19 | B      | {C,B,A}   |     3 |
| 2021 | F     |      20 | B      | {A,C,B}   |     3 |
| 2021 | F     |      21 | B      | {C,A,B}   |     3 |
| 2021 | F     |      32 | B      | {B,A,C}   |     3 |
| 2021 | F     |      33 | B      | {A,C,B}   |     3 |
| 2021 | F     |      34 | B      | {C,B,A}   |     3 |
| 2021 | F     |      35 | B      | {C,A,B}   |     3 |
| 2021 | F     |      37 | B      | {C,B,A}   |     3 |
| 2021 | F     |      38 | B      | {A,B,C}   |     3 |
| 2021 | F     |      39 | B      | {C,A,B}   |     3 |
| 2021 | F     |      40 | B      | {A,C,B}   |     3 |
| 2021 | F     |      41 | B      | {C,A,B}   |     3 |
| 2021 | F     |      42 | B      | {C,A,B}   |     3 |
| 2021 | F     |      43 | B      | {B,A,C}   |     3 |
| 2021 | F     |     291 | B      | {A,C,B}   |     3 |
| 2021 | F     |     292 | B      | {B,C,A}   |     3 |
| 2021 | F     |     293 | B      | {A,C,B}   |     3 |
| 2021 | F     |     294 | B      | {C,B,A}   |     3 |
| 2021 | F     |     295 | B      | {C,A,B}   |     3 |
| 2021 | F     |     296 | B      | {C,A,B}   |     3 |
| 2021 | F     |     297 | B      | {C,A,B}   |     3 |
| 2021 | F     |     298 | B      | {A,B,C}   |     3 |
| 2021 | F     |     299 | B      | {C,A,B}   |     3 |
| 2021 | F     |     300 | B      | {A,B,C}   |     3 |
| 2021 | F     |     301 | B      | {B,C,A}   |     3 |
| 2021 | F     |     302 | B      | {C,B,A}   |     3 |
| 2021 | F     |     303 | B      | {C,A,B}   |     3 |
| 2021 | F     |     304 | B      | {C,A,B}   |     3 |
| 2021 | F     |     305 | B      | {C,A,B}   |     3 |
| 2021 | MA    |       7 | C      | {““}      |     1 |
| 2021 | MA    |       8 | C      | {““}      |     1 |
| 2021 | MA    |       9 | C      | {““}      |     1 |
| 2021 | MA    |      10 | C      | {““}      |     1 |
| 2021 | MA    |      11 | C      | {““}      |     1 |
| 2021 | MA    |      12 | C      | {““}      |     1 |
| 2021 | MA    |      13 | C      | {““}      |     1 |
| 2021 | MA    |      14 | C      | {““}      |     1 |
| 2021 | MA    |      15 | C      | {““}      |     1 |
| 2021 | MA    |      16 | C      | {““}      |     1 |
| 2021 | MA    |      17 | C      | {““}      |     1 |
| 2021 | MA    |      18 | C      | {““}      |     1 |
| 2021 | MA    |      19 | C      | {““}      |     1 |
| 2021 | MA    |      20 | C      | {““}      |     1 |
| 2021 | MA    |      21 | C      | {““}      |     1 |
| 2021 | MA    |      32 | C      | {““}      |     1 |
| 2021 | MA    |      33 | C      | {““}      |     1 |
| 2021 | MA    |      34 | C      | {““}      |     1 |
| 2021 | MA    |      35 | C      | {““}      |     1 |
| 2021 | MA    |      37 | C      | {““}      |     1 |
| 2021 | MA    |      38 | C      | {““}      |     1 |
| 2021 | MA    |      39 | C      | {““}      |     1 |
| 2021 | MA    |      40 | C      | {““}      |     1 |
| 2021 | MA    |      41 | C      | {““}      |     1 |
| 2021 | MA    |      42 | C      | {““}      |     1 |
| 2021 | MA    |      43 | C      | {““}      |     1 |
| 2021 | MA    |     291 | C      | {““}      |     1 |
| 2021 | MA    |     292 | C      | {““}      |     1 |
| 2021 | MA    |     293 | C      | {““}      |     1 |
| 2021 | MA    |     294 | C      | {““}      |     1 |
| 2021 | MA    |     295 | C      | {““}      |     1 |
| 2021 | MA    |     296 | C      | {““}      |     1 |
| 2021 | MA    |     297 | C      | {““}      |     1 |
| 2021 | MA    |     298 | C      | {““}      |     1 |
| 2021 | MA    |     299 | C      | {““}      |     1 |
| 2021 | MA    |     300 | C      | {““}      |     1 |
| 2021 | MA    |     301 | C      | {““}      |     1 |
| 2021 | MA    |     302 | C      | {““}      |     1 |
| 2021 | MA    |     303 | C      | {““}      |     1 |
| 2021 | MA    |     304 | C      | {““}      |     1 |
| 2021 | MA    |     305 | C      | {““}      |     1 |
| 2021 | MI    |       7 | K      | {A,C,B}   |     3 |
| 2021 | MI    |       8 | K      | {C,A,B}   |     3 |
| 2021 | MI    |       9 | R      | {A,C,B}   |     3 |
| 2021 | MI    |      10 | R      | {C,A,B}   |     3 |
| 2021 | MI    |      11 | R      | {A,B,C}   |     3 |
| 2021 | MI    |      12 | K      | {C,A,B}   |     3 |
| 2021 | MI    |      13 | K      | {C,A,B}   |     3 |
| 2021 | MI    |      14 | K      | {B,A,C}   |     3 |
| 2021 | MI    |      15 | R      | {A,C,B}   |     3 |
| 2021 | MI    |      16 | R      | {A,C,B}   |     3 |
| 2021 | MI    |      17 | K      | {A,C,B}   |     3 |
| 2021 | MI    |      18 | R      | {C,A,B}   |     3 |
| 2021 | MI    |      19 | D      | {C,A,B}   |     3 |
| 2021 | MI    |      20 | D      | {C,B,A}   |     3 |
| 2021 | MI    |      21 | D      | {A,C,B}   |     3 |
| 2021 | MI    |      32 | K      | {C,B,A}   |     3 |
| 2021 | MI    |      33 | K      | {B,C,A}   |     3 |
| 2021 | MI    |      34 | R      | {C,B,A}   |     3 |

Displaying records 1 - 100

</div>

Because there is more than a method, the number of the campaign should
be determined this way:

``` sql
WITH a AS(
SELECT 
  event_id,
  REGEXP_REPLACE(event_id,'^(ANH)([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\1_\2') anh_name,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\1')::int anh_num,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\2') grupo,
  CASE
       WHEN sampling_protocol='Draga' THEN 'D'
       WHEN sampling_protocol='Draga/Red tipo D - Asociados a macrofitas' THEN 'DR'
       WHEN sampling_protocol='Kick Sampling Red Tipo D' THEN 'K'
       WHEN sampling_protocol='Red tipo D - Asociados a macrofitas' THEN 'R'
       WHEN sampling_protocol~'[Rr]aspados' THEN 'Ra'
       WHEN sampling_protocol~'Botella Van Dorn' THEN 'B'
       WHEN sampling_protocol='Cuadrante 1x1 m' THEN 'C'
  END metodo,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\9') repli,
  REGEXP_REPLACE(event_id,'^ANH[0-9]{1,3}-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\9') ='-Bajas' aguas_bajas,
  EXTRACT(YEAR FROM TO_DATE(event_date,'YYYY-MM-DD')) año
FROM raw_dwc.hidrobiologico_event
)
SELECT año,aguas_bajas, anh_name,grupo, ROW_NUMBER() OVER (PARTITION BY anh_name,grupo ORDER BY año,aguas_bajas) campaign_nb
FROM a
GROUP BY año,grupo,aguas_bajas, anh_name
ORDER BY año,grupo,aguas_bajas, anh_name
;
```

<div class="knitsql-table">

|  año | aguas_bajas | anh_name | grupo | campaign_nb |
|-----:|:------------|:---------|:------|------------:|
| 2021 | FALSE       | ANH_10   | F     |           1 |
| 2021 | FALSE       | ANH_11   | F     |           1 |
| 2021 | FALSE       | ANH_12   | F     |           1 |
| 2021 | FALSE       | ANH_13   | F     |           1 |
| 2021 | FALSE       | ANH_14   | F     |           1 |
| 2021 | FALSE       | ANH_15   | F     |           1 |
| 2021 | FALSE       | ANH_16   | F     |           1 |
| 2021 | FALSE       | ANH_17   | F     |           1 |
| 2021 | FALSE       | ANH_18   | F     |           1 |
| 2021 | FALSE       | ANH_19   | F     |           1 |
| 2021 | FALSE       | ANH_20   | F     |           1 |
| 2021 | FALSE       | ANH_21   | F     |           1 |
| 2021 | FALSE       | ANH_291  | F     |           1 |
| 2021 | FALSE       | ANH_292  | F     |           1 |
| 2021 | FALSE       | ANH_293  | F     |           1 |
| 2021 | FALSE       | ANH_294  | F     |           1 |
| 2021 | FALSE       | ANH_295  | F     |           1 |
| 2021 | FALSE       | ANH_296  | F     |           1 |
| 2021 | FALSE       | ANH_297  | F     |           1 |
| 2021 | FALSE       | ANH_298  | F     |           1 |
| 2021 | FALSE       | ANH_299  | F     |           1 |
| 2021 | FALSE       | ANH_300  | F     |           1 |
| 2021 | FALSE       | ANH_301  | F     |           1 |
| 2021 | FALSE       | ANH_302  | F     |           1 |
| 2021 | FALSE       | ANH_303  | F     |           1 |
| 2021 | FALSE       | ANH_304  | F     |           1 |
| 2021 | FALSE       | ANH_305  | F     |           1 |
| 2021 | FALSE       | ANH_32   | F     |           1 |
| 2021 | FALSE       | ANH_33   | F     |           1 |
| 2021 | FALSE       | ANH_34   | F     |           1 |
| 2021 | FALSE       | ANH_35   | F     |           1 |
| 2021 | FALSE       | ANH_37   | F     |           1 |
| 2021 | FALSE       | ANH_38   | F     |           1 |
| 2021 | FALSE       | ANH_39   | F     |           1 |
| 2021 | FALSE       | ANH_40   | F     |           1 |
| 2021 | FALSE       | ANH_41   | F     |           1 |
| 2021 | FALSE       | ANH_42   | F     |           1 |
| 2021 | FALSE       | ANH_43   | F     |           1 |
| 2021 | FALSE       | ANH_7    | F     |           1 |
| 2021 | FALSE       | ANH_8    | F     |           1 |
| 2021 | FALSE       | ANH_9    | F     |           1 |
| 2021 | FALSE       | ANH_10   | MA    |           1 |
| 2021 | FALSE       | ANH_11   | MA    |           1 |
| 2021 | FALSE       | ANH_12   | MA    |           1 |
| 2021 | FALSE       | ANH_13   | MA    |           1 |
| 2021 | FALSE       | ANH_14   | MA    |           1 |
| 2021 | FALSE       | ANH_15   | MA    |           1 |
| 2021 | FALSE       | ANH_16   | MA    |           1 |
| 2021 | FALSE       | ANH_17   | MA    |           1 |
| 2021 | FALSE       | ANH_18   | MA    |           1 |
| 2021 | FALSE       | ANH_19   | MA    |           1 |
| 2021 | FALSE       | ANH_20   | MA    |           1 |
| 2021 | FALSE       | ANH_21   | MA    |           1 |
| 2021 | FALSE       | ANH_291  | MA    |           1 |
| 2021 | FALSE       | ANH_292  | MA    |           1 |
| 2021 | FALSE       | ANH_293  | MA    |           1 |
| 2021 | FALSE       | ANH_294  | MA    |           1 |
| 2021 | FALSE       | ANH_295  | MA    |           1 |
| 2021 | FALSE       | ANH_296  | MA    |           1 |
| 2021 | FALSE       | ANH_297  | MA    |           1 |
| 2021 | FALSE       | ANH_298  | MA    |           1 |
| 2021 | FALSE       | ANH_299  | MA    |           1 |
| 2021 | FALSE       | ANH_300  | MA    |           1 |
| 2021 | FALSE       | ANH_301  | MA    |           1 |
| 2021 | FALSE       | ANH_302  | MA    |           1 |
| 2021 | FALSE       | ANH_303  | MA    |           1 |
| 2021 | FALSE       | ANH_304  | MA    |           1 |
| 2021 | FALSE       | ANH_305  | MA    |           1 |
| 2021 | FALSE       | ANH_32   | MA    |           1 |
| 2021 | FALSE       | ANH_33   | MA    |           1 |
| 2021 | FALSE       | ANH_34   | MA    |           1 |
| 2021 | FALSE       | ANH_35   | MA    |           1 |
| 2021 | FALSE       | ANH_37   | MA    |           1 |
| 2021 | FALSE       | ANH_38   | MA    |           1 |
| 2021 | FALSE       | ANH_39   | MA    |           1 |
| 2021 | FALSE       | ANH_40   | MA    |           1 |
| 2021 | FALSE       | ANH_41   | MA    |           1 |
| 2021 | FALSE       | ANH_42   | MA    |           1 |
| 2021 | FALSE       | ANH_43   | MA    |           1 |
| 2021 | FALSE       | ANH_7    | MA    |           1 |
| 2021 | FALSE       | ANH_8    | MA    |           1 |
| 2021 | FALSE       | ANH_9    | MA    |           1 |
| 2021 | FALSE       | ANH_10   | MI    |           1 |
| 2021 | FALSE       | ANH_11   | MI    |           1 |
| 2021 | FALSE       | ANH_12   | MI    |           1 |
| 2021 | FALSE       | ANH_13   | MI    |           1 |
| 2021 | FALSE       | ANH_14   | MI    |           1 |
| 2021 | FALSE       | ANH_15   | MI    |           1 |
| 2021 | FALSE       | ANH_16   | MI    |           1 |
| 2021 | FALSE       | ANH_17   | MI    |           1 |
| 2021 | FALSE       | ANH_18   | MI    |           1 |
| 2021 | FALSE       | ANH_19   | MI    |           1 |
| 2021 | FALSE       | ANH_20   | MI    |           1 |
| 2021 | FALSE       | ANH_21   | MI    |           1 |
| 2021 | FALSE       | ANH_291  | MI    |           1 |
| 2021 | FALSE       | ANH_292  | MI    |           1 |
| 2021 | FALSE       | ANH_293  | MI    |           1 |
| 2021 | FALSE       | ANH_294  | MI    |           1 |
| 2021 | FALSE       | ANH_295  | MI    |           1 |
| 2021 | FALSE       | ANH_296  | MI    |           1 |

Displaying records 1 - 100

</div>

``` sql
INSERT INTO main.gp_event(cd_gp_biol,cd_protocol,cd_pt_ref,campaign_nb)
WITH a AS(
SELECT 
  event_id,
  REGEXP_REPLACE(event_id,'^(ANH)([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\1_\2') anh_name,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\1')::int anh_num,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\2') grupo,
  CASE
       WHEN sampling_protocol='Draga' THEN 'D'
       WHEN sampling_protocol='Draga/Red tipo D - Asociados a macrofitas' THEN 'DR'
       WHEN sampling_protocol='Kick Sampling Red Tipo D' THEN 'K'
       WHEN sampling_protocol='Red tipo D - Asociados a macrofitas' THEN 'R'
       WHEN sampling_protocol~'[Rr]aspados' THEN 'Ra'
       WHEN sampling_protocol~'Botella Van Dorn' THEN 'B'
       WHEN sampling_protocol='Cuadrante 1x1 m' THEN 'C'
  END metodo,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\9') repli,
  REGEXP_REPLACE(event_id,'^ANH[0-9]{1,3}-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\9') ='-Bajas' aguas_bajas,
  EXTRACT(YEAR FROM TO_DATE(event_date,'YYYY-MM-DD')) año,
  cd_pt_ref
FROM raw_dwc.hidrobiologico_event
), campaign AS(
SELECT año,aguas_bajas, a.metodo,anh_name,grupo, ROW_NUMBER() OVER (PARTITION BY anh_name,grupo ORDER BY año,aguas_bajas) campaign_nb
FROM a
GROUP BY año,grupo,metodo,aguas_bajas, anh_name
ORDER BY año,grupo,metodo,aguas_bajas, anh_name
)
SELECT 
CASE
 WHEN a.grupo='F' THEN 'fipl'
 WHEN a.grupo='MA' THEN 'mafi'
 WHEN a.grupo='MI' THEN 'minv'
 WHEN a.grupo='P' THEN 'peri'
 WHEN a.grupo='Z' THEN 'zopl'
END cd_gp_biol,  
CASE
    WHEN a.metodo='D' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Grab collector')
    WHEN a.metodo='Ra' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Substrate scraping')
    WHEN a.metodo='C' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Sampling quadrats')
    WHEN a.metodo='K' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='D net kick sampling')
    WHEN a.metodo='B' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Van Dorn Bottle')
    WHEN a.metodo='DR' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Grab collector + type D net')
    WHEN a.metodo='R' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='D net (associated with macrophytes)')
  END cd_protocol,
  cd_pt_ref,
  c.campaign_nb
FROM a
LEFT JOIN campaign c ON c.aguas_bajas=a.aguas_bajas AND (c.anh_name=a.anh_name OR (c.anh_name IS NULL AND a.anh_name IS NULL)) AND a.metodo=c.metodo
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
GROUP BY a.grupo, cd_pt_ref, name_pt_ref,a.año, a.aguas_bajas, a.metodo, c.campaign_nb
ORDER BY a.año,a.aguas_bajas,cd_pt_ref, a.grupo, cd_protocol
RETURNING cd_gp_event,cd_gp_biol,cd_protocol,cd_pt_ref,campaign_nb,subpart
;
```

Attributing the gp_event

``` sql
ALTER TABLE raw_dwc.hidrobiologico_event ADD COLUMN cd_gp_event int REFERENCES main.gp_event(cd_gp_event) ON DELETE SET NULL;

WITH a AS(
SELECT 
  event_id,
  REGEXP_REPLACE(event_id,'^(ANH)([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\1_\2') anh_name,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\1')::int anh_num,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\2') grupo,
  CASE
       WHEN sampling_protocol='Draga' THEN 'D'
       WHEN sampling_protocol='Draga/Red tipo D - Asociados a macrofitas' THEN 'DR'
       WHEN sampling_protocol='Kick Sampling Red Tipo D' THEN 'K'
       WHEN sampling_protocol='Red tipo D - Asociados a macrofitas' THEN 'R'
       WHEN sampling_protocol~'[Rr]aspados' THEN 'Ra'
       WHEN sampling_protocol~'Botella Van Dorn' THEN 'B'
       WHEN sampling_protocol='Cuadrante 1x1 m' THEN 'C'
  END metodo,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\9') repli,
  REGEXP_REPLACE(event_id,'^ANH[0-9]{1,3}-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\9') ='-Bajas' aguas_bajas,
  EXTRACT(YEAR FROM TO_DATE(event_date,'YYYY-MM-DD')) año,
  cd_pt_ref
FROM raw_dwc.hidrobiologico_event
), campaign AS(
SELECT año,aguas_bajas, metodo,anh_name,grupo, ROW_NUMBER() OVER (PARTITION BY anh_name,grupo ORDER BY año,aguas_bajas) campaign_nb
FROM a
GROUP BY año,grupo,metodo,aguas_bajas, anh_name
ORDER BY año,grupo,metodo,aguas_bajas, anh_name
),b AS(
SELECT event_id,
CASE
 WHEN a.grupo='F' THEN 'fipl'
 WHEN a.grupo='MA' THEN 'mafi'
 WHEN a.grupo='MI' THEN 'minv'
 WHEN a.grupo='P' THEN 'peri'
 WHEN a.grupo='Z' THEN 'zopl'
END cd_gp_biol,  
CASE
    WHEN metodo='D' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Grab collector')
    WHEN metodo='Ra' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Substrate scraping')
    WHEN metodo='C' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Sampling quadrats')
    WHEN metodo='K' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='D net kick sampling')
    WHEN metodo='B' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Van Dorn Bottle')
    WHEN metodo='DR' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Grab collector + type D net')
    WHEN metodo='R' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol='D net (associated with macrophytes)')
  END cd_protocol,
  cd_pt_ref,
  c.campaign_nb
FROM a
LEFT JOIN campaign c USING (grupo,año,metodo,aguas_bajas,anh_name)
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
),d AS(
SELECT b.*,cd_gp_event
FROM b
LEFT JOIN main.gp_event USING (cd_gp_biol,cd_protocol,campaign_nb,cd_pt_ref)
)
UPDATE raw_dwc.hidrobiologico_event e
SET cd_gp_event=d.cd_gp_event
FROM d
WHERE d.event_id=e.event_id
RETURNING e.event_id, e.cd_gp_event
;

SELECT event_id
FROM raw_dwc.hidrobiologico_event
WHERE cd_gp_event IS NULL;
```

<div class="knitsql-table">

event_id ———-

: 0 records

</div>

## 11.7 event

**Los event_remarks son muy largos, voy a ponerlos en event_extra**

**Anotar: en sample_size_value hay un espacio que hace que el campo esta
considerado como texto**

``` sql
SELECT event_id,sample_size_value
FROM raw_dwc.hidrobiologico_event
WHERE sample_size_value ~ '\s'
```

<div class="knitsql-table">

| event_id  | sample_size_value |
|:----------|:------------------|
| ANH37-P-C | 109\. 34          |

1 records

</div>

Averiguar que las unidades de sample_size corresponden a las unidades
definidas como samp_eff_1 en los protocolos:

``` sql
SELECT cd_gp_biol,protocol, sample_size_unit, abbv_unit, count(*)
FROM raw_dwc.hidrobiologico_event
LEFT JOIN main.gp_event USING (cd_gp_event)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.def_var_samp_eff ON cd_var_samp_eff_1 = cd_var_samp_eff
LEFT JOIN main.def_unit USING (cd_unit)
GROUP BY cd_gp_biol,sample_size_unit, abbv_unit, protocol
ORDER BY cd_gp_biol, count(*)
```

<div class="knitsql-table">

| cd_gp_biol | protocol                            | sample_size_unit | abbv_unit | count |
|:-----------|:------------------------------------|:-----------------|:----------|------:|
| fipl       | Van Dorn Bottle                     | Litros           | L         |   246 |
| mafi       | Sampling quadrats                   | m2               | m2        |    82 |
| minv       | Grab collector + type D net         | m2               | m2        |     8 |
| minv       | Grab collector                      | m2               | m2        |    27 |
| minv       | D net (associated with macrophytes) | m2               | m2        |    79 |
| minv       | D net kick sampling                 | m2               | m2        |   132 |
| peri       | Substrate scraping                  | cm2              | cm2       |   234 |
| zopl       | Van Dorn Bottle                     | Litros           | L         |   246 |

8 records

</div>

Para extraer samp_eff_2:

``` sql
SELECT DISTINCT 
  sample_size_unit, 
  sample_size_value,
  sampling_effort,
  sampling_protocol
FROM raw_dwc.hidrobiologico_event
```

<div class="knitsql-table">

| sample_size_unit | sample_size_value | sampling_effort                | sampling_protocol                                                        |
|:-----------------|:------------------|:-------------------------------|:-------------------------------------------------------------------------|
| m2               | 0.072             | 3 repeticiones                 | Draga                                                                    |
| cm2              | 133.51            | 10 tallos sumergidos           | Raspados de epifiton                                                     |
| m2               | 30.0              | 30 cuadrantes                  | Cuadrante 1x1 m                                                          |
| m2               | 50.0              | 50 cuadrantes                  | Cuadrante 1x1 m                                                          |
| m2               | 120.0             | 120 cuadrantes                 | Cuadrante 1x1 m                                                          |
| m2               | 60.0              | 60 cuadrantes                  | Cuadrante 1x1 m                                                          |
| m2               | 0.252             | 3/2 repeticiones               | Draga/Red tipo D - Asociados a macrofitas                                |
| cm2              | 79.91             | 7 tallos sumergidos/2 raspados | Raspados de epifiton/Raspados en sustratos duros con cuadrante de 3x3 cm |
| cm2              | 150.8             | 10 tallos sumergidos           | Raspados de epifiton                                                     |
| m2               | 100.0             | 100 cuadrantes                 | Cuadrante 1x1 m                                                          |
| cm2              | 95.12             | 10 tallos sumergidos           | Raspados de epifiton                                                     |
| cm2              | 49.63             | 5 tallos sumergidos            | Raspados de epifiton                                                     |
| cm2              | 178.34            | 10 tallos sumergidos           | Raspados de epifiton                                                     |
| m2               | 0.45              | 5 arrastres                    | Red tipo D - Asociados a macrofitas                                      |
| cm2              | 147.25            | 10 tallos sumergidos           | Raspados de epifiton                                                     |
| m2               | 0.067             | 3 repeticiones                 | Draga                                                                    |
| cm2              | 153.98            | 10 tallos sumergidos           | Raspados de epifiton                                                     |
| cm2              | 164.0             | 10 tallos sumergidos           | Raspados de epifiton                                                     |
| cm2              | 144.57            | 10 tallos sumergidos           | Raspados de epifiton                                                     |
| m2               | 40.0              | 40 cuadrantes                  | Cuadrante 1x1 m                                                          |
| m2               | 70.0              | 70 cuadrantes                  | Cuadrante 1x1 m                                                          |
| cm2              | 56.79             | 10 tallos sumergidos           | Raspados de epifiton                                                     |
| cm2              | 131.91            | 10 tallos sumergidos           | Raspados de epifiton                                                     |
| cm2              | 136.58            | 10 tallos sumergidos           | Raspados de epifiton                                                     |
| cm2              | 108.0             | 12 raspados                    | Raspados en plantas acuáticas con cuadrante de 3x3 cm                    |
| cm2              | 108.0             | 12 raspados                    | 12 raspados                                                              |
| m2               | 80.0              | 80 cuadrantes                  | Cuadrante 1x1 m                                                          |
| m2               | 20.0              | 20 cuadrantes                  | Cuadrante 1x1 m                                                          |
| cm2              | 146.62            | 10 tallos sumergidos           | Raspados de epifiton                                                     |
| m2               | 0.432             | 3/4 repeticiones               | Draga/Red tipo D - Asociados a macrofitas                                |
| cm2              | 111.2             | 10 tallos sumergidos           | Raspados de epifiton                                                     |
| m2               | 3.0               | 20 Kicks                       | Kick Sampling Red Tipo D                                                 |
| Litros           | 27.0              | 9 replicas Botella             | Botella Van Dorn                                                         |
| cm2              | 95.26             | 10 tallos sumergidos           | Raspados de epifiton                                                     |
| cm2              | 108.0             | 12 raspados                    | Raspados en sustratos duros con cuadrante de 3x3 cm                      |
| m2               | 1.65              | 3/5 repeticiones               | Draga/Red tipo D - Asociados a macrofitas                                |
| cm2              | 119.96            | 10 tallos sumergidos           | Raspados de epifiton                                                     |
| Litros           | 18.0              | 9 replicas Botella             | Botella Van Dorn                                                         |
| cm2              | 103.2             | 10 tallos sumergidos           | Raspados de epifiton                                                     |
| cm2              | 64.87             | 10 tallos sumergidos           | Raspados de epifiton                                                     |
| cm2              | 68.71             | 10 tallos sumergidos           | Raspados de epifiton                                                     |
| m2               | 12.0              | 12 cuadrantes                  | Cuadrante 1x1 m                                                          |
| cm2              | 119.2             | 10 tallos sumergidos           | Raspados de epifiton                                                     |
| cm2              | 109\. 34          | 10 tallos sumergidos           | Raspados de epifiton                                                     |
| cm2              | 119.35            | 10 tallos sumergidos           | Raspados de epifiton                                                     |
| cm2              | 170.85            | 10 tallos sumergidos           | Raspados de epifiton                                                     |
| cm2              | 130.92            | 12 tallos sumergidos           | Raspados de epifiton                                                     |
| cm2              | 141.46            | 10 tallos sumergidos           | Raspados de epifiton                                                     |

48 records

</div>

``` sql
WITH se2_1 AS(
SELECT event_id, sampling_effort, UNNEST(REGEXP_MATCHES(sampling_effort,'([0-9]+)','g'))::int s_e
FROM raw_dwc.hidrobiologico_event
)
SELECT event_id,sampling_effort,SUM(s_e) samp_eff_2
FROM se2_1
GROUP BY event_id,sampling_effort
```

<div class="knitsql-table">

| event_id          | sampling_effort      | samp_eff_2 |
|:------------------|:---------------------|-----------:|
| ANH8-P-C          | 12 raspados          |         12 |
| ANH291-P-A-Bajas  | 12 raspados          |         12 |
| ANH303-F-A        | 9 replicas Botella   |          9 |
| ANH297-MA-Bajas   | 80 cuadrantes        |         80 |
| ANH34-P-A         | 10 tallos sumergidos |         10 |
| ANH296-P-B-Bajas  | 12 raspados          |         12 |
| ANH40-P-B-Bajas   | 12 raspados          |         12 |
| ANH42-F-C-Bajas   | 9 replicas Botella   |          9 |
| ANH35-Z-C         | 9 replicas Botella   |          9 |
| ANH294-Z-A-Bajas  | 9 replicas Botella   |          9 |
| ANH41-Z-A-Bajas   | 9 replicas Botella   |          9 |
| ANH20-P-A         | 12 raspados          |         12 |
| ANH297-P-B-Bajas  | 12 raspados          |         12 |
| ANH305-F-A        | 9 replicas Botella   |          9 |
| ANH293-P-B-Bajas  | 12 raspados          |         12 |
| ANH33-Z-A         | 9 replicas Botella   |          9 |
| ANH8-Z-A-Bajas    | 9 replicas Botella   |          9 |
| ANH305-Z-C        | 9 replicas Botella   |          9 |
| ANH21-F-A-Bajas   | 9 replicas Botella   |          9 |
| ANH17-Z-C-Bajas   | 9 replicas Botella   |          9 |
| ANH297-MI-B       | 20 Kicks             |         20 |
| ANH41-MI-B        | 20 Kicks             |         20 |
| ANH299-MI-A       | 3/5 repeticiones     |          8 |
| ANH21-P-A         | 12 raspados          |         12 |
| ANH298-F-B        | 9 replicas Botella   |          9 |
| ANH39-Z-B-Bajas   | 9 replicas Botella   |          9 |
| ANH7-MI-A         | 20 Kicks             |         20 |
| ANH300-MA-Bajas   | 20 cuadrantes        |         20 |
| ANH301-F-A-Bajas  | 9 replicas Botella   |          9 |
| ANH294-F-A-Bajas  | 9 replicas Botella   |          9 |
| ANH13-F-B-Bajas   | 9 replicas Botella   |          9 |
| ANH34-F-B         | 9 replicas Botella   |          9 |
| ANH32-F-A-Bajas   | 9 replicas Botella   |          9 |
| ANH14-Z-A-Bajas   | 9 replicas Botella   |          9 |
| ANH294-MI-A-Bajas | 20 Kicks             |         20 |
| ANH291-F-C        | 9 replicas Botella   |          9 |
| ANH293-P-C        | 12 raspados          |         12 |
| ANH295-MI-B-Bajas | 5 arrastres          |          5 |
| ANH293-MI-B       | 20 Kicks             |         20 |
| ANH39-Z-B         | 9 replicas Botella   |          9 |
| ANH18-P-C-Bajas   | 12 raspados          |         12 |
| ANH32-MI-C-Bajas  | 3 repeticiones       |          3 |
| ANH9-Z-A          | 9 replicas Botella   |          9 |
| ANH40-F-A         | 9 replicas Botella   |          9 |
| ANH17-F-B         | 9 replicas Botella   |          9 |
| ANH43-P-B-Bajas   | 12 raspados          |         12 |
| ANH304-F-B-Bajas  | 9 replicas Botella   |          9 |
| ANH9-F-C-Bajas    | 9 replicas Botella   |          9 |
| ANH296-Z-A-Bajas  | 9 replicas Botella   |          9 |
| ANH34-P-B         | 10 tallos sumergidos |         10 |
| ANH18-P-C         | 12 raspados          |         12 |
| ANH38-P-C         | 10 tallos sumergidos |         10 |
| ANH12-F-C-Bajas   | 9 replicas Botella   |          9 |
| ANH12-P-C         | 12 raspados          |         12 |
| ANH294-Z-B-Bajas  | 9 replicas Botella   |          9 |
| ANH21-Z-C-Bajas   | 9 replicas Botella   |          9 |
| ANH295-Z-C-Bajas  | 9 replicas Botella   |          9 |
| ANH17-F-A         | 9 replicas Botella   |          9 |
| ANH9-Z-C-Bajas    | 9 replicas Botella   |          9 |
| ANH13-P-C-Bajas   | 12 raspados          |         12 |
| ANH33-MA          | 60 cuadrantes        |         60 |
| ANH304-MA         | 50 cuadrantes        |         50 |
| ANH16-F-A-Bajas   | 9 replicas Botella   |          9 |
| ANH9-F-A          | 9 replicas Botella   |          9 |
| ANH18-F-B         | 9 replicas Botella   |          9 |
| ANH14-F-A         | 9 replicas Botella   |          9 |
| ANH7-P-A          | 10 tallos sumergidos |         10 |
| ANH298-Z-A        | 9 replicas Botella   |          9 |
| ANH296-MI-C-Bajas | 3/4 repeticiones     |          7 |
| ANH9-Z-B-Bajas    | 9 replicas Botella   |          9 |
| ANH20-F-A-Bajas   | 9 replicas Botella   |          9 |
| ANH296-Z-B        | 9 replicas Botella   |          9 |
| ANH297-Z-A        | 9 replicas Botella   |          9 |
| ANH18-P-A-Bajas   | 12 raspados          |         12 |
| ANH293-Z-B        | 9 replicas Botella   |          9 |
| ANH32-MI-B-Bajas  | 3 repeticiones       |          3 |
| ANH16-Z-A-Bajas   | 9 replicas Botella   |          9 |
| ANH7-Z-A          | 9 replicas Botella   |          9 |
| ANH303-MI-C-Bajas | 20 Kicks             |         20 |
| ANH35-Z-B-Bajas   | 9 replicas Botella   |          9 |
| ANH302-MI-C-Bajas | 20 Kicks             |         20 |
| ANH295-MA         | 50 cuadrantes        |         50 |
| ANH41-F-C-Bajas   | 9 replicas Botella   |          9 |
| ANH296-F-B        | 9 replicas Botella   |          9 |
| ANH301-MI-C-Bajas | 5 arrastres          |          5 |
| ANH9-MI-B         | 5 arrastres          |          5 |
| ANH11-F-C-Bajas   | 9 replicas Botella   |          9 |
| ANH38-MI-A        | 5 arrastres          |          5 |
| ANH294-MA-Bajas   | 20 cuadrantes        |         20 |
| ANH32-Z-B         | 9 replicas Botella   |          9 |
| ANH14-F-B         | 9 replicas Botella   |          9 |
| ANH294-F-B        | 9 replicas Botella   |          9 |
| ANH298-MA         | 50 cuadrantes        |         50 |
| ANH37-Z-C-Bajas   | 9 replicas Botella   |          9 |
| ANH294-P-B        | 12 raspados          |         12 |
| ANH302-Z-B        | 9 replicas Botella   |          9 |
| ANH14-F-A-Bajas   | 9 replicas Botella   |          9 |
| ANH21-Z-A-Bajas   | 9 replicas Botella   |          9 |
| ANH301-F-C        | 9 replicas Botella   |          9 |
| ANH302-F-C        | 9 replicas Botella   |          9 |

Displaying records 1 - 100

</div>

``` sql
INSERT INTO main.event(cd_gp_event,event_id,num_replicate, description_replicate, date_time_begin, date_time_end, locality_verb, event_remarks, samp_effort_1, samp_effort_2, pt_geom)
WITH se2_1 AS(
SELECT event_id, sampling_effort, UNNEST(REGEXP_MATCHES(sampling_effort,'([0-9]+)','g'))::int s_e
FROM raw_dwc.hidrobiologico_event
),se2_2 AS(
SELECT event_id, SUM(s_e) samp_eff_2
FROM se2_1
GROUP BY event_id,sampling_effort
), a AS(
SELECT cd_gp_event,
  event_id, 
  REGEXP_REPLACE(event_id,'^(ANH)([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\1_\2') anh_name,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\1')::int anh_num,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\2') grupo,
  CASE
       WHEN sampling_protocol='Draga' THEN 'D'
       WHEN sampling_protocol='Draga/Red tipo D - Asociados a macrofitas' THEN 'DR'
       WHEN sampling_protocol='Kick Sampling Red Tipo D' THEN 'K'
       WHEN sampling_protocol='Red tipo D - Asociados a macrofitas' THEN 'R'
       WHEN sampling_protocol~'[Rr]aspados' THEN 'Ra'
       WHEN sampling_protocol~'Botella Van Dorn' THEN 'B'
       WHEN sampling_protocol='Cuadrante 1x1 m' THEN 'C'
  END metodo,
  REGEXP_REPLACE(event_id,'^ANH([0-9]{1,3})-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\9') repli,
  REGEXP_REPLACE(event_id,'^ANH[0-9]{1,3}-((F)|(MA)|(MI)|(P)|(Z))(-([ABC]))?(-Bajas)?$','\9') ='-Bajas' aguas_bajas,
  EXTRACT(YEAR FROM TO_DATE(event_date,'YYYY-MM-DD')) año,
  (event_date||' '||event_time)::timestamp date_time_begin,
  NULL::timestamp date_time_end,
  locality locality_verb,
  REGEXP_REPLACE(sample_size_value,'\s','')::double precision samp_eff_1,
  samp_eff_2,
  --sampling_size_value,
  --sample_size_unit,
  --sampling_size_unit,
  --sampling_effort,
  NULL event_remarks,
  --locality_remarks,
  ST_SetSRID(ST_Transform(ST_SetSRID(ST_MakePoint(decimal_longitude,decimal_latitude),4326),(SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)),3116) pt_geom
FROM raw_dwc.hidrobiologico_event
LEFT JOIN se2_2 USING (event_id)
)--calculation of sampling effort and num_replicate
SELECT 
  cd_gp_event,
  event_id, 
  ROW_NUMBER() OVER (PARTITION BY cd_gp_event ORDER BY repli) num_replicate,
  CASE
    WHEN repli != '' AND repli IS NOT NULL THEN 'replicate:'||repli 
  END description_replicate,
  date_time_begin,
  date_time_end,
  locality_verb,
  event_remarks ,
  samp_eff_1,
  samp_eff_2,
  pt_geom
FROM a
ORDER BY cd_gp_event, event_id, num_replicate

RETURNING main.event.cd_event, main.event.cd_gp_event, main.event.event_id, main.event.num_replicate, main.event.description_replicate, main.event.date_time_begin, main.event.date_time_end, main.event.locality_verb, main.event.event_remarks, main.event.pt_geom
```

Damos los cd_event a todos las filas:

``` sql
ALTER TABLE raw_dwc.hidrobiologico_event ADD COLUMN cd_event int REFERENCES main.event(cd_event) ON DELETE SET NULL;
ALTER TABLE raw_dwc.hidrobiologico_registros ADD COLUMN cd_event int REFERENCES main.event(cd_event);

UPDATE raw_dwc.hidrobiologico_event AS t
SET cd_event=e.cd_event
FROM main.event e
WHERE t.event_id=e.event_id;

UPDATE raw_dwc.hidrobiologico_registros AS t
SET cd_event=e.cd_event
FROM main.event e
WHERE t.event_id=e.event_id;

SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

### 11.7.1 Añadir información temporal faltante

Añadir los comentarios largos sobre los eventos:

``` sql
INSERT INTO main.event_extra(cd_event, cd_var_event_extra,value_text)
SELECT cd_event, 
  (SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra = 'big_remarks'),
  event_remarks
FROM raw_dwc.hidrobiologico_event
WHERE  event_remarks IS NOT NULL
;
```

## 11.8 registros

``` sql
SELECT occurrence_id, count(*)
FROM raw_dwc.hidrobiologico_registros 
GROUP BY occurrence_id
HAVING count(*)>1;
```

<div class="knitsql-table">

occurrence_id count ————— ——-

: 0 records

</div>

**Commas intempestivos en el campo de organism_quantity**

``` sql
INSERT INTO main.registros(cd_event, cds_recorded_by, date_time, cd_tax, cd_morfo, date_ident, cds_identified_by, qt_int, qt_double, remarks, occurrence_id, organism_id)
SELECT 
 cd_event,
 cds_recorded_by,
 NULL::timestamp date_time,
 tt.cd_tax,
 tt.cd_morfo,
 TO_DATE(date_identified,'YYYY-MM-DD') date_ident,
 cds_identified_by,
 measurement_value__abundancia_relativa_ qt_int,
 REGEXP_REPLACE(organism_quantity,',','.')::double precision qt_double,
 NULL remarks,
 --r.event_remarks remarks,
 r.occurrence_id,
 SPLIT_PART(occurrence_id,':',7) organism_id
 --ROW_NUMBER() OVER (ORDER BY (e.date_time_begin::date||' '||event_time)::timestamp)
 --organism_id,
 --ST_SetSRID(ST_Transform(ST_SetSRID(ST_MakePoint(measurement_value__longitud_,measurement_value__latitud_), 4326),  (SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)),3116)
FROM raw_dwc.hidrobiologico_registros r
LEFT JOIN raw_dwc.taxonomy_total tt ON tt."row.names"=r."row.names" AND tt.table_orig=r.table_orig

RETURNING cd_event, cds_recorded_by, date_time, cd_tax, cd_morfo, cds_identified_by, qt_int,remarks, occurrence_id, organism_id
```

``` sql
ALTER TABLE raw_dwc.hidrobiologico_registros ADD COLUMN cd_reg int REFERENCES main.registros(cd_reg);
UPDATE raw_dwc.hidrobiologico_registros AS ar
SET cd_reg=r.cd_reg
FROM main.registros r
WHERE ar.cd_event=r.cd_event AND ar.occurrence_id=r.occurrence_id;

-- Check cd_reg are unique in the source table
SELECT cd_reg,count(*) FROM  raw_dwc.hidrobiologico_registros GROUP BY cd_reg HAVING count(*)>1;
```

<div class="knitsql-table">

    cd_reg   count

------------------------------------------------------------------------

: 0 records

</div>

En la mayoría de los casos no corresponden las cifras de abundancias:

``` sql
SELECT qt_int/samp_effort_1, qt_double
FROM main.registros
LEFT JOIN main.event USING (cd_event)
LEFT JOIN main.gp_event USING (cd_gp_event)
LEFT JOIN main.def_gp_biol USING (cd_gp_biol)
WHERE super_gp='Hydrobiology'
```

<div class="knitsql-table">

|   ?column? |    qt_double |
|-----------:|-------------:|
|  0.0740741 | 2.037037e+00 |
|  0.0740741 | 2.037037e+00 |
|  0.3703704 | 3.819714e+03 |
|  1.9259259 | 5.296296e+01 |
|  0.3703704 | 1.018519e+01 |
|  0.0740741 | 2.037037e+00 |
|  0.0370370 | 3.819714e+02 |
|  0.0740741 | 2.037037e+00 |
|  0.0740741 | 7.639428e+02 |
|  0.2962963 | 3.055771e+03 |
|  0.1481481 | 4.074074e+00 |
|  0.0370370 | 3.819714e+02 |
|  0.6666667 | 6.875485e+03 |
|  0.0370370 | 3.819714e+02 |
|  0.2222222 | 6.111111e+00 |
|  0.0740741 | 3.829899e+02 |
|  0.0740741 | 2.037037e+00 |
|  1.1851852 | 3.259259e+01 |
|  2.5925926 | 7.129630e+01 |
|  0.0370370 | 3.819714e+02 |
| 21.5555556 | 2.223073e+05 |
|  0.0370370 | 2.430727e+02 |
|  0.3703704 | 2.430727e+03 |
|  0.0740741 | 4.861454e+02 |
|  0.0370370 | 6.481481e-01 |
|  0.2962963 | 5.185185e+00 |
|  0.0740741 | 1.296296e+00 |
| 18.5185185 | 1.215364e+05 |
|  0.3703704 | 2.430727e+03 |
|  0.0370370 | 6.481481e-01 |
|  0.0370370 | 2.430727e+02 |
|  0.0740741 | 4.861454e+02 |
|  0.2962963 | 5.185185e+00 |
|  0.0740741 | 1.296296e+00 |
|  0.0370370 | 6.481481e-01 |
|  0.1481481 | 9.722908e+02 |
|  0.0370370 | 2.430727e+02 |
|  0.5925926 | 1.037037e+01 |
|  0.2222222 | 3.888889e+00 |
|  2.5185185 | 1.652894e+04 |
|  0.0740741 | 1.296296e+00 |
| 21.8518519 | 1.434129e+05 |
|  0.2962963 | 5.185185e+00 |
|  2.3703704 | 6.518519e+01 |
|  0.2962963 | 3.055771e+03 |
|  0.1481481 | 4.074074e+00 |
|  0.0370370 | 1.018519e+00 |
|  2.2222222 | 6.111111e+01 |
|  0.5185185 | 5.347599e+03 |
|  0.0740741 | 7.639428e+02 |
|  0.1481481 | 4.074074e+00 |
|  0.0370370 | 1.018519e+00 |
|  0.0370370 | 1.018519e+00 |
|  0.3703704 | 1.018519e+01 |
|  0.9629630 | 9.931256e+03 |
|  0.0370370 | 3.819714e+02 |
|  0.0370370 | 3.819714e+02 |
|  0.1481481 | 4.074074e+00 |
|  0.0370370 | 3.819714e+02 |
|  0.0740741 | 7.639428e+02 |
|  0.1481481 | 4.074074e+00 |
|  0.3703704 | 3.819714e+03 |
| 22.5925926 | 2.330025e+05 |
|  0.1851852 | 4.074074e+00 |
|  0.0740741 | 1.629630e+00 |
|  0.0370370 | 8.148148e-01 |
|  0.0370370 | 8.148148e-01 |
|  0.0370370 | 8.148148e-01 |
|  0.0370370 | 8.148148e-01 |
|  0.1481481 | 3.259259e+00 |
|  0.0370370 | 8.148148e-01 |
|  0.0740741 | 1.629630e+00 |
|  0.0370370 | 8.148148e-01 |
|  0.0370370 | 8.148148e-01 |
|  0.0370370 | 8.148148e-01 |
|  0.0370370 | 8.148148e-01 |
|  0.0370370 | 8.888889e-01 |
|  0.0740741 | 1.777778e+00 |
|  0.0370370 | 8.888889e-01 |
|  0.0370370 | 8.888889e-01 |
|  0.0370370 | 8.888889e-01 |
|  0.0370370 | 8.888889e-01 |
|  0.0370370 | 6.172840e-01 |
|  0.0370370 | 6.172840e-01 |
|  0.0370370 | 6.172840e-01 |
|  0.0370370 | 6.172840e-01 |
| 20.0000000 | 3.333333e+02 |
|  1.8888889 | 3.148148e+01 |
|  0.0370370 | 7.777778e-01 |
|  0.0370370 | 7.777778e-01 |
| 12.1481481 | 2.551111e+02 |
|  0.0370370 | 5.185185e-01 |
|  0.0370370 | 5.185185e-01 |
|  0.1481481 | 2.074074e+00 |
|  0.0370370 | 5.185185e-01 |
|  7.7777778 | 1.088889e+02 |
|  4.2592593 | 5.962963e+01 |
|  2.5555556 | 9.584009e+03 |
|  0.0740741 | 2.222222e+00 |
|  0.0370370 | 1.111111e+00 |

Displaying records 1 - 100

</div>

# 12 Cameras trampa

## 12.1 Entender el plan de muestreo

``` sql
SELECT 
  REGEXP_REPLACE(event_id, '^ANH([0-9]{3})_T([1-3])$','\1')::int anh_num,
  'ANH_'||REGEXP_REPLACE(event_id, '^ANH([0-9]{3})_T([1-3])$','\1')::int anh_name,
  REGEXP_REPLACE(event_id, '^ANH([0-9]{3})_T([1-3])$','\2')::int tempo,
  ARRAY_AGG(event_id)
FROM raw_dwc.cameras_trampa_event
GROUP BY anh_num, tempo
ORDER BY anh_num, tempo
```

<div class="knitsql-table">

| anh_num | anh_name | tempo | array_agg   |
|--------:|:---------|------:|:------------|
|      12 | ANH_12   |     1 | {ANH012_T1} |
|      12 | ANH_12   |     3 | {ANH012_T3} |
|      31 | ANH_31   |     1 | {ANH031_T1} |
|      31 | ANH_31   |     2 | {ANH031_T2} |
|      31 | ANH_31   |     3 | {ANH031_T3} |
|      38 | ANH_38   |     1 | {ANH038_T1} |
|      38 | ANH_38   |     2 | {ANH038_T2} |
|      38 | ANH_38   |     3 | {ANH038_T3} |
|      58 | ANH_58   |     1 | {ANH058_T1} |
|      58 | ANH_58   |     2 | {ANH058_T2} |
|      58 | ANH_58   |     3 | {ANH058_T3} |
|      62 | ANH_62   |     3 | {ANH062_T3} |
|      64 | ANH_64   |     1 | {ANH064_T1} |
|      64 | ANH_64   |     3 | {ANH064_T3} |
|      65 | ANH_65   |     1 | {ANH065_T1} |
|      65 | ANH_65   |     3 | {ANH065_T3} |
|      66 | ANH_66   |     1 | {ANH066_T1} |
|      66 | ANH_66   |     2 | {ANH066_T2} |
|      66 | ANH_66   |     3 | {ANH066_T3} |
|      69 | ANH_69   |     1 | {ANH069_T1} |
|      69 | ANH_69   |     2 | {ANH069_T2} |
|      69 | ANH_69   |     3 | {ANH069_T3} |
|      77 | ANH_77   |     1 | {ANH077_T1} |
|      77 | ANH_77   |     2 | {ANH077_T2} |
|      77 | ANH_77   |     3 | {ANH077_T3} |
|      81 | ANH_81   |     1 | {ANH081_T1} |
|      81 | ANH_81   |     2 | {ANH081_T2} |
|      81 | ANH_81   |     3 | {ANH081_T3} |
|      85 | ANH_85   |     1 | {ANH085_T1} |
|      85 | ANH_85   |     2 | {ANH085_T2} |
|      85 | ANH_85   |     3 | {ANH085_T3} |
|      88 | ANH_88   |     1 | {ANH088_T1} |
|      88 | ANH_88   |     2 | {ANH088_T2} |
|      88 | ANH_88   |     3 | {ANH088_T3} |
|      89 | ANH_89   |     3 | {ANH089_T3} |
|      95 | ANH_95   |     3 | {ANH095_T3} |
|     101 | ANH_101  |     3 | {ANH101_T3} |
|     106 | ANH_106  |     1 | {ANH106_T1} |
|     106 | ANH_106  |     2 | {ANH106_T2} |
|     106 | ANH_106  |     3 | {ANH106_T3} |
|     109 | ANH_109  |     1 | {ANH109_T1} |
|     109 | ANH_109  |     2 | {ANH109_T2} |
|     109 | ANH_109  |     3 | {ANH109_T3} |
|     112 | ANH_112  |     1 | {ANH112_T1} |
|     112 | ANH_112  |     2 | {ANH112_T2} |
|     112 | ANH_112  |     3 | {ANH112_T3} |
|     121 | ANH_121  |     1 | {ANH121_T1} |
|     121 | ANH_121  |     3 | {ANH121_T3} |
|     135 | ANH_135  |     1 | {ANH135_T1} |
|     135 | ANH_135  |     2 | {ANH135_T2} |
|     135 | ANH_135  |     3 | {ANH135_T3} |
|     145 | ANH_145  |     1 | {ANH145_T1} |
|     145 | ANH_145  |     2 | {ANH145_T2} |
|     145 | ANH_145  |     3 | {ANH145_T3} |
|     159 | ANH_159  |     1 | {ANH159_T1} |
|     159 | ANH_159  |     2 | {ANH159_T2} |
|     159 | ANH_159  |     3 | {ANH159_T3} |
|     160 | ANH_160  |     1 | {ANH160_T1} |
|     160 | ANH_160  |     2 | {ANH160_T2} |
|     160 | ANH_160  |     3 | {ANH160_T3} |
|     166 | ANH_166  |     1 | {ANH166_T1} |
|     166 | ANH_166  |     2 | {ANH166_T2} |
|     166 | ANH_166  |     3 | {ANH166_T3} |
|     181 | ANH_181  |     1 | {ANH181_T1} |
|     181 | ANH_181  |     2 | {ANH181_T2} |
|     181 | ANH_181  |     3 | {ANH181_T3} |
|     182 | ANH_182  |     1 | {ANH182_T1} |
|     182 | ANH_182  |     2 | {ANH182_T2} |
|     182 | ANH_182  |     3 | {ANH182_T3} |
|     183 | ANH_183  |     1 | {ANH183_T1} |
|     183 | ANH_183  |     2 | {ANH183_T2} |
|     183 | ANH_183  |     3 | {ANH183_T3} |
|     185 | ANH_185  |     1 | {ANH185_T1} |
|     185 | ANH_185  |     2 | {ANH185_T2} |
|     185 | ANH_185  |     3 | {ANH185_T3} |
|     189 | ANH_189  |     1 | {ANH189_T1} |
|     189 | ANH_189  |     2 | {ANH189_T2} |
|     189 | ANH_189  |     3 | {ANH189_T3} |
|     192 | ANH_192  |     1 | {ANH192_T1} |
|     192 | ANH_192  |     2 | {ANH192_T2} |
|     192 | ANH_192  |     3 | {ANH192_T3} |
|     194 | ANH_194  |     1 | {ANH194_T1} |
|     194 | ANH_194  |     2 | {ANH194_T2} |
|     194 | ANH_194  |     3 | {ANH194_T3} |
|     197 | ANH_197  |     1 | {ANH197_T1} |
|     197 | ANH_197  |     2 | {ANH197_T2} |
|     197 | ANH_197  |     3 | {ANH197_T3} |
|     209 | ANH_209  |     1 | {ANH209_T1} |
|     209 | ANH_209  |     2 | {ANH209_T2} |
|     209 | ANH_209  |     3 | {ANH209_T3} |
|     210 | ANH_210  |     1 | {ANH210_T1} |
|     210 | ANH_210  |     2 | {ANH210_T2} |
|     210 | ANH_210  |     3 | {ANH210_T3} |
|     211 | ANH_211  |     1 | {ANH211_T1} |
|     211 | ANH_211  |     2 | {ANH211_T2} |
|     211 | ANH_211  |     3 | {ANH211_T3} |
|     212 | ANH_212  |     1 | {ANH212_T1} |
|     212 | ANH_212  |     2 | {ANH212_T2} |
|     212 | ANH_212  |     3 | {ANH212_T3} |
|     213 | ANH_213  |     3 | {ANH213_T3} |

Displaying records 1 - 100

</div>

``` sql
WITH a AS(
SELECT 
  event_id,
  REGEXP_REPLACE(event_id, '^ANH([0-9]{3})_T([1-3])$','\1')::int anh_num,
  'ANH_'||REGEXP_REPLACE(event_id, '^ANH([0-9]{3})_T([1-3])$','\1')::int anh_name,
  REGEXP_REPLACE(event_id, '^ANH([0-9]{3})_T([1-3])$','\2')::int tempo
FROM raw_dwc.cameras_trampa_event
ORDER BY anh_num, tempo
)
SELECT anh_num, ARRAY_AGG(tempo),count(*)
FROM a
GROUP BY anh_num
ORDER BY anh_num,count(*)
```

<div class="knitsql-table">

| anh_num | array_agg | count |
|--------:|:----------|------:|
|      12 | {1,3}     |     2 |
|      31 | {1,2,3}   |     3 |
|      38 | {1,2,3}   |     3 |
|      58 | {1,2,3}   |     3 |
|      62 | {3}       |     1 |
|      64 | {1,3}     |     2 |
|      65 | {1,3}     |     2 |
|      66 | {1,2,3}   |     3 |
|      69 | {1,2,3}   |     3 |
|      77 | {1,2,3}   |     3 |
|      81 | {1,2,3}   |     3 |
|      85 | {1,2,3}   |     3 |
|      88 | {1,2,3}   |     3 |
|      89 | {3}       |     1 |
|      95 | {3}       |     1 |
|     101 | {3}       |     1 |
|     106 | {1,2,3}   |     3 |
|     109 | {1,2,3}   |     3 |
|     112 | {1,2,3}   |     3 |
|     121 | {1,3}     |     2 |
|     135 | {1,2,3}   |     3 |
|     145 | {1,2,3}   |     3 |
|     159 | {1,2,3}   |     3 |
|     160 | {1,2,3}   |     3 |
|     166 | {1,2,3}   |     3 |
|     181 | {1,2,3}   |     3 |
|     182 | {1,2,3}   |     3 |
|     183 | {1,2,3}   |     3 |
|     185 | {1,2,3}   |     3 |
|     189 | {1,2,3}   |     3 |
|     192 | {1,2,3}   |     3 |
|     194 | {1,2,3}   |     3 |
|     197 | {1,2,3}   |     3 |
|     209 | {1,2,3}   |     3 |
|     210 | {1,2,3}   |     3 |
|     211 | {1,2,3}   |     3 |
|     212 | {1,2,3}   |     3 |
|     213 | {3}       |     1 |
|     214 | {1,2,3}   |     3 |
|     215 | {1,2,3}   |     3 |
|     217 | {1,2,3}   |     3 |
|     221 | {1}       |     1 |
|     222 | {1,2,3}   |     3 |
|     223 | {1,2}     |     2 |
|     225 | {1,2,3}   |     3 |
|     226 | {1,2,3}   |     3 |
|     227 | {1,2,3}   |     3 |
|     228 | {1,2,3}   |     3 |
|     230 | {1,2,3}   |     3 |
|     231 | {3}       |     1 |
|     232 | {1,3}     |     2 |
|     233 | {1,2,3}   |     3 |
|     234 | {1,3}     |     2 |
|     235 | {1,2,3}   |     3 |
|     236 | {1,2,3}   |     3 |
|     238 | {1,3}     |     2 |
|     239 | {1,3}     |     2 |
|     240 | {1,2,3}   |     3 |
|     241 | {1,2,3}   |     3 |
|     242 | {1,2,3}   |     3 |
|     243 | {1,2}     |     2 |
|     248 | {1,3}     |     2 |
|     250 | {1,2,3}   |     3 |
|     252 | {3}       |     1 |
|     253 | {1,2,3}   |     3 |
|     254 | {1,2,3}   |     3 |
|     256 | {1,2,3}   |     3 |
|     257 | {1,3}     |     2 |
|     272 | {3}       |     1 |
|     274 | {1,2,3}   |     3 |
|     275 | {1,2,3}   |     3 |
|     279 | {1,2,3}   |     3 |
|     280 | {1,2,3}   |     3 |
|     282 | {1,2,3}   |     3 |
|     283 | {1,2,3}   |     3 |
|     284 | {1,2,3}   |     3 |
|     289 | {3}       |     1 |
|     290 | {1,2,3}   |     3 |
|     291 | {3}       |     1 |
|     317 | {1,2,3}   |     3 |
|     324 | {1,2,3}   |     3 |
|     327 | {1,2,3}   |     3 |
|     334 | {1,2,3}   |     3 |
|     336 | {1,2,3}   |     3 |
|     338 | {1,2,3}   |     3 |
|     350 | {1,2,3}   |     3 |
|     351 | {1,3}     |     2 |
|     353 | {1,2,3}   |     3 |
|     360 | {1,2,3}   |     3 |
|     361 | {1,2,3}   |     3 |
|     363 | {1,3}     |     2 |
|     364 | {1,2,3}   |     3 |
|     370 | {1,2,3}   |     3 |
|     375 | {1,2,3}   |     3 |
|     388 | {1,2,3}   |     3 |
|     389 | {1,2,3}   |     3 |
|     390 | {1,2,3}   |     3 |
|     393 | {1,2,3}   |     3 |
|     395 | {1}       |     1 |

99 records

</div>

## 12.2 ANH

Insertar los datos de anh:

``` sql
INSERT INTO main.punto_referencia(name_pt_ref, num_anh)
WITH a AS(
SELECT
  REGEXP_REPLACE(event_id, '^ANH([0-9]{3})_T([1-3])$','\1')::int anh_num,
  'ANH_'||REGEXP_REPLACE(event_id, '^ANH([0-9]{3})_T([1-3])$','\1')::int anh_name
FROM raw_dwc.cameras_trampa_event
)
SELECT anh_name, anh_num
FROM a
GROUP BY anh_name,anh_num
ORDER BY anh_num
ON CONFLICT (name_pt_ref) DO NOTHING
RETURNING cd_pt_ref, name_pt_ref
;
```

dar las referencias en las tablas de cameras_trampa

``` sql
ALTER TABLE raw_dwc.cameras_trampa_event ADD COLUMN cd_pt_ref int REFERENCES main.punto_referencia(cd_pt_ref) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE raw_dwc.cameras_trampa_registros ADD COLUMN cd_pt_ref int REFERENCES main.punto_referencia(cd_pt_ref) ON DELETE SET NULL ON UPDATE CASCADE;

UPDATE raw_dwc.cameras_trampa_event
SET cd_pt_ref=pr.cd_pt_ref
FROM main.punto_referencia pr
WHERE 'ANH_'||REGEXP_REPLACE(event_id, '^ANH([0-9]{3})_T([1-3])$','\1')::int= name_pt_ref
;

UPDATE raw_dwc.cameras_trampa_registros
SET cd_pt_ref=pr.cd_pt_ref
FROM main.punto_referencia pr
WHERE  'ANH_'||REGEXP_REPLACE(event_id, '^ANH([0-9]{3})_T([1-3])$','\1')::int= name_pt_ref
;

SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

Averiguando que ninguna fila no tenga anh

``` sql
SELECT event_id FROM raw_dwc.cameras_trampa_event WHERE cd_pt_ref IS NULL;
```

<div class="knitsql-table">

event_id ———-

: 0 records

</div>

``` sql
SELECT occurrence_id FROM raw_dwc.cameras_trampa_registros WHERE cd_pt_ref IS NULL;
```

<div class="knitsql-table">

    occurrence_id

------------------------------------------------------------------------

: 0 records

</div>

## 12.3 Unit, sampling efforts definition, abundance definition, protocolo

``` sql
INSERT INTO main.def_unit(cd_measurement_type, unit, unit_spa, abbv_unit,factor)
VALUES(
  (SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='number of traps'),
  'Number of camera traps',
  'Número de cameras trampa',
  'camera traps',
  1
  ),
  ((SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='time'),
  'Number of days',
  'Número de días',
  'days',
  60*24
  )
RETURNING cd_unit,unit;
```

``` sql
INSERT INTO main.def_var_samp_eff(var_samp_eff, var_samp_eff_spa, cd_unit,type_variable)
VALUES(
  'Number of camera traps',
  'Número de cameras trampa',
  (SELECT cd_unit FROM main.def_unit WHERE cd_measurement_type=(SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='number of traps') AND unit='Number of camera traps'),
  'int'
  ),
  ('Elapsed time (days)',
  'Duración (días)',
  (SELECT cd_unit FROM main.def_unit WHERE cd_measurement_type=(SELECT cd_measurement_type FROM main.def_measurement_type WHERE measurement_type='time') AND unit='Number of days'),
  'int'
  )
RETURNING cd_var_samp_eff, var_samp_eff ;
```

``` sql
INSERT INTO main.def_protocol(protocol,protocol_spa,cd_var_samp_eff_1,cd_var_samp_eff_2,samp_eff_1_implicit,samp_eff_2_implicit,cd_var_ind_qt,description_spa)
VALUES(
  'Camera traps',
  'Fototrampeo',
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Number of camera traps'),
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Elapsed time (days)'),
  false,
  false,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind='Number of individuals'),
  NULL
)
RETURNING cd_protocol,protocol,protocol_spa;
```

## 12.4 Personas

``` sql
INSERT INTO main.people(verbatim_person)
WITH a AS(
SELECT DISTINCT INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(recorded_by, ' | ')))) AS name_person
FROM raw_dwc.cameras_trampa_registros
UNION
SELECT DISTINCT INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(identified_by, ' | '))))
FROM raw_dwc.cameras_trampa_registros
)
SELECT DISTINCT REGEXP_REPLACE(name_person, '- ','-')
FROM a 
ORDER BY REGEXP_REPLACE(name_person, '- ','-')
ON CONFLICT(verbatim_person) DO NOTHING
RETURNING cd_person, verbatim_person
```

Dar los codigos a las tables de origen:

``` sql
ALTER TABLE raw_dwc.cameras_trampa_registros ADD COLUMN cds_recorded_by int[];

WITH a AS(
SELECT "row.names", REGEXP_REPLACE(INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(recorded_by, ' | ')))),'- ','-') AS name_person
FROM raw_dwc.cameras_trampa_registros
),b AS(
SELECT "row.names", ARRAY_AGG(cd_person) cds
FROM a 
LEFT JOIN main.people p ON a.name_person=p.verbatim_person
GROUP BY "row.names"
)
UPDATE raw_dwc.cameras_trampa_registros AS r
SET cds_recorded_by=b.cds
FROM b
WHERE r."row.names"=b."row.names"
RETURNING r."row.names", cds_recorded_by
;

ALTER TABLE raw_dwc.cameras_trampa_registros ADD COLUMN cds_identified_by int[];

WITH a AS(
SELECT "row.names", REGEXP_REPLACE(INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(identified_by, ' | ')))),'- ','-') AS name_person
FROM raw_dwc.cameras_trampa_registros
),b AS(
SELECT "row.names", ARRAY_AGG(cd_person) cds
FROM a 
LEFT JOIN main.people p ON a.name_person=p.verbatim_person
GROUP BY "row.names"
)
UPDATE raw_dwc.cameras_trampa_registros AS r
SET cds_identified_by=b.cds
FROM b
WHERE r."row.names"=b."row.names"
RETURNING r."row.names", cds_identified_by
;

SELECT 1;
```

<div class="knitsql-table">

| ?column? |
|---------:|
|        1 |

1 records

</div>

## 12.5 gp_event

``` sql
WITH a AS(
SELECT 
  event_id,
  EXTRACT(YEAR FROM TO_DATE(SPLIT_PART(event_date,'/',1), 'YYYY-MM-DD')) año,
  REGEXP_REPLACE(event_id, '^ANH([0-9]{3})_T([1-3])$','\1')::int anh_num,
  'ANH_'||REGEXP_REPLACE(event_id, '^ANH([0-9]{3})_T([1-3])$','\1')::int anh_name,
  REGEXP_REPLACE(event_id, '^ANH([0-9]{3})_T([1-3])$','\2')::int tempo
FROM raw_dwc.cameras_trampa_event
)
SELECT año, anh_num, ARRAY_AGG(tempo), count(*)
FROM a
GROUP BY año, anh_num
ORDER BY anh_num,año
;
```

<div class="knitsql-table">

|  año | anh_num | array_agg | count |
|-----:|--------:|:----------|------:|
| 2021 |      12 | {1}       |     1 |
| 2022 |      12 | {3}       |     1 |
| 2021 |      31 | {2,1}     |     2 |
| 2022 |      31 | {3}       |     1 |
| 2021 |      38 | {1,2}     |     2 |
| 2022 |      38 | {3}       |     1 |
| 2021 |      58 | {1,2}     |     2 |
| 2022 |      58 | {3}       |     1 |
| 2022 |      62 | {3}       |     1 |
| 2021 |      64 | {1}       |     1 |
| 2022 |      64 | {3}       |     1 |
| 2021 |      65 | {1}       |     1 |
| 2022 |      65 | {3}       |     1 |
| 2021 |      66 | {2,1}     |     2 |
| 2022 |      66 | {3}       |     1 |
| 2021 |      69 | {2,1}     |     2 |
| 2022 |      69 | {3}       |     1 |
| 2021 |      77 | {1,2}     |     2 |
| 2022 |      77 | {3}       |     1 |
| 2021 |      81 | {1,2}     |     2 |
| 2022 |      81 | {3}       |     1 |
| 2021 |      85 | {2,1}     |     2 |
| 2022 |      85 | {3}       |     1 |
| 2021 |      88 | {1,2}     |     2 |
| 2022 |      88 | {3}       |     1 |
| 2022 |      89 | {3}       |     1 |
| 2022 |      95 | {3}       |     1 |
| 2022 |     101 | {3}       |     1 |
| 2021 |     106 | {2,1}     |     2 |
| 2022 |     106 | {3}       |     1 |
| 2021 |     109 | {2,1}     |     2 |
| 2022 |     109 | {3}       |     1 |
| 2021 |     112 | {1,2}     |     2 |
| 2022 |     112 | {3}       |     1 |
| 2021 |     121 | {1}       |     1 |
| 2022 |     121 | {3}       |     1 |
| 2021 |     135 | {1,2}     |     2 |
| 2022 |     135 | {3}       |     1 |
| 2021 |     145 | {1,2}     |     2 |
| 2022 |     145 | {3}       |     1 |
| 2021 |     159 | {1,2}     |     2 |
| 2022 |     159 | {3}       |     1 |
| 2021 |     160 | {1,2}     |     2 |
| 2022 |     160 | {3}       |     1 |
| 2021 |     166 | {1,2}     |     2 |
| 2022 |     166 | {3}       |     1 |
| 2021 |     181 | {1,2}     |     2 |
| 2022 |     181 | {3}       |     1 |
| 2021 |     182 | {1,2}     |     2 |
| 2022 |     182 | {3}       |     1 |
| 2021 |     183 | {1,2}     |     2 |
| 2022 |     183 | {3}       |     1 |
| 2021 |     185 | {2,1}     |     2 |
| 2022 |     185 | {3}       |     1 |
| 2021 |     189 | {1,2}     |     2 |
| 2022 |     189 | {3}       |     1 |
| 2021 |     192 | {1,2}     |     2 |
| 2022 |     192 | {3}       |     1 |
| 2021 |     194 | {2,1}     |     2 |
| 2022 |     194 | {3}       |     1 |
| 2021 |     197 | {1,2}     |     2 |
| 2022 |     197 | {3}       |     1 |
| 2021 |     209 | {2,1}     |     2 |
| 2022 |     209 | {3}       |     1 |
| 2021 |     210 | {1,2}     |     2 |
| 2022 |     210 | {3}       |     1 |
| 2021 |     211 | {2,1}     |     2 |
| 2022 |     211 | {3}       |     1 |
| 2021 |     212 | {2,1}     |     2 |
| 2022 |     212 | {3}       |     1 |
| 2022 |     213 | {3}       |     1 |
| 2021 |     214 | {1,2}     |     2 |
| 2022 |     214 | {3}       |     1 |
| 2021 |     215 | {2,1}     |     2 |
| 2022 |     215 | {3}       |     1 |
| 2021 |     217 | {2,1}     |     2 |
| 2022 |     217 | {3}       |     1 |
| 2021 |     221 | {1}       |     1 |
| 2021 |     222 | {1,2}     |     2 |
| 2022 |     222 | {3}       |     1 |
| 2021 |     223 | {2,1}     |     2 |
| 2021 |     225 | {1,2}     |     2 |
| 2022 |     225 | {3}       |     1 |
| 2021 |     226 | {1,2}     |     2 |
| 2022 |     226 | {3}       |     1 |
| 2021 |     227 | {1,2}     |     2 |
| 2022 |     227 | {3}       |     1 |
| 2021 |     228 | {1,2}     |     2 |
| 2022 |     228 | {3}       |     1 |
| 2021 |     230 | {1,2}     |     2 |
| 2022 |     230 | {3}       |     1 |
| 2022 |     231 | {3}       |     1 |
| 2021 |     232 | {1}       |     1 |
| 2022 |     232 | {3}       |     1 |
| 2021 |     233 | {2,1}     |     2 |
| 2022 |     233 | {3}       |     1 |
| 2021 |     234 | {1}       |     1 |
| 2022 |     234 | {3}       |     1 |
| 2021 |     235 | {1,2}     |     2 |
| 2022 |     235 | {3}       |     1 |

Displaying records 1 - 100

</div>

Because there is only one method, the number of the campaign should be
determined this way:

``` sql
WITH a AS(
SELECT 
  event_id,
  REGEXP_REPLACE(event_id, '^ANH([0-9]{3})_T([1-3])$','\1')::int anh_num,
  'ANH_'||REGEXP_REPLACE(event_id, '^ANH([0-9]{3})_T([1-3])$','\1')::int anh_name,
  REGEXP_REPLACE(event_id, '^ANH([0-9]{3})_T([1-3])$','\2')::int tempo
FROM raw_dwc.cameras_trampa_event
)
SELECT anh_num, ROW_NUMBER() OVER (PARTITION BY anh_num ORDER BY tempo) campaign_nb
FROM a
GROUP BY anh_num,tempo
ORDER BY anh_num,tempo
;
```

<div class="knitsql-table">

| anh_num | campaign_nb |
|--------:|------------:|
|      12 |           1 |
|      12 |           2 |
|      31 |           1 |
|      31 |           2 |
|      31 |           3 |
|      38 |           1 |
|      38 |           2 |
|      38 |           3 |
|      58 |           1 |
|      58 |           2 |
|      58 |           3 |
|      62 |           1 |
|      64 |           1 |
|      64 |           2 |
|      65 |           1 |
|      65 |           2 |
|      66 |           1 |
|      66 |           2 |
|      66 |           3 |
|      69 |           1 |
|      69 |           2 |
|      69 |           3 |
|      77 |           1 |
|      77 |           2 |
|      77 |           3 |
|      81 |           1 |
|      81 |           2 |
|      81 |           3 |
|      85 |           1 |
|      85 |           2 |
|      85 |           3 |
|      88 |           1 |
|      88 |           2 |
|      88 |           3 |
|      89 |           1 |
|      95 |           1 |
|     101 |           1 |
|     106 |           1 |
|     106 |           2 |
|     106 |           3 |
|     109 |           1 |
|     109 |           2 |
|     109 |           3 |
|     112 |           1 |
|     112 |           2 |
|     112 |           3 |
|     121 |           1 |
|     121 |           2 |
|     135 |           1 |
|     135 |           2 |
|     135 |           3 |
|     145 |           1 |
|     145 |           2 |
|     145 |           3 |
|     159 |           1 |
|     159 |           2 |
|     159 |           3 |
|     160 |           1 |
|     160 |           2 |
|     160 |           3 |
|     166 |           1 |
|     166 |           2 |
|     166 |           3 |
|     181 |           1 |
|     181 |           2 |
|     181 |           3 |
|     182 |           1 |
|     182 |           2 |
|     182 |           3 |
|     183 |           1 |
|     183 |           2 |
|     183 |           3 |
|     185 |           1 |
|     185 |           2 |
|     185 |           3 |
|     189 |           1 |
|     189 |           2 |
|     189 |           3 |
|     192 |           1 |
|     192 |           2 |
|     192 |           3 |
|     194 |           1 |
|     194 |           2 |
|     194 |           3 |
|     197 |           1 |
|     197 |           2 |
|     197 |           3 |
|     209 |           1 |
|     209 |           2 |
|     209 |           3 |
|     210 |           1 |
|     210 |           2 |
|     210 |           3 |
|     211 |           1 |
|     211 |           2 |
|     211 |           3 |
|     212 |           1 |
|     212 |           2 |
|     212 |           3 |
|     213 |           1 |

Displaying records 1 - 100

</div>

``` sql
INSERT INTO main.gp_event(cd_gp_biol,cd_protocol,cd_pt_ref,campaign_nb)
WITH a AS(
SELECT 
  event_id,
  REGEXP_REPLACE(event_id, '^ANH([0-9]{3})_T([1-3])$','\1')::int anh_num,
  'ANH_'||REGEXP_REPLACE(event_id, '^ANH([0-9]{3})_T([1-3])$','\1')::int anh_name,
  REGEXP_REPLACE(event_id, '^ANH([0-9]{3})_T([1-3])$','\2')::int tempo,
  cd_pt_ref
FROM raw_dwc.cameras_trampa_event
), campaign AS(
SELECT anh_num, tempo, ROW_NUMBER() OVER (PARTITION BY anh_num ORDER BY tempo) campaign_nb
FROM a
GROUP BY anh_num,tempo
ORDER BY anh_num,tempo
)
SELECT 'catr',
    (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Camera traps') cd_protocol,
  cd_pt_ref,
  c.campaign_nb
FROM a
LEFT JOIN campaign c USING (tempo, anh_num)
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
GROUP BY cd_pt_ref, name_pt_ref, c.campaign_nb
ORDER BY cd_pt_ref,cd_protocol
RETURNING cd_gp_event,cd_gp_biol,cd_protocol,cd_pt_ref,campaign_nb
;
```

Attributing the gp_event

``` sql
ALTER TABLE raw_dwc.cameras_trampa_event ADD COLUMN cd_gp_event int REFERENCES main.gp_event(cd_gp_event) ON DELETE SET NULL;


WITH a AS(
SELECT 
  event_id,
  REGEXP_REPLACE(event_id, '^ANH([0-9]{3})_T([1-3])$','\1')::int anh_num,
  'ANH_'||REGEXP_REPLACE(event_id, '^ANH([0-9]{3})_T([1-3])$','\1')::int anh_name,
  REGEXP_REPLACE(event_id, '^ANH([0-9]{3})_T([1-3])$','\2')::int tempo,
  cd_pt_ref
FROM raw_dwc.cameras_trampa_event
), campaign AS(
SELECT anh_num, tempo, ROW_NUMBER() OVER (PARTITION BY anh_num ORDER BY tempo) campaign_nb
FROM a
),b AS(
SELECT event_id,
    (SELECT cd_protocol FROM main.def_protocol WHERE protocol='Camera traps') cd_protocol,
  cd_pt_ref,
  c.campaign_nb
FROM a
LEFT JOIN campaign c USING (tempo, anh_num)
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
),d AS(
SELECT b.*, cd_gp_event
FROM b
LEFT JOIN main.gp_event ge ON cd_gp_biol='catr' AND b.cd_protocol=ge.cd_protocol AND b.cd_pt_ref=ge.cd_pt_ref AND b.campaign_nb=ge.campaign_nb
)
UPDATE raw_dwc.cameras_trampa_event e
SET cd_gp_event=d.cd_gp_event
FROM d
WHERE d.event_id=e.event_id
RETURNING e.event_id, e.cd_gp_event
;
```

<div class="knitsql-table">

| event_id  | cd_gp_event |
|:----------|------------:|
| ANH012_T1 |        2064 |
| ANH012_T3 |        2065 |
| ANH031_T1 |        2070 |
| ANH031_T2 |        2071 |
| ANH031_T3 |        2072 |
| ANH038_T1 |        2066 |
| ANH038_T2 |        2067 |
| ANH038_T3 |        2068 |
| ANH058_T1 |        2073 |
| ANH058_T2 |        2074 |
| ANH058_T3 |        2075 |
| ANH062_T3 |        2076 |
| ANH064_T1 |        1950 |
| ANH064_T3 |        1951 |
| ANH065_T1 |        1952 |
| ANH065_T3 |        1953 |
| ANH066_T1 |        2046 |
| ANH066_T2 |        2047 |
| ANH066_T3 |        2048 |
| ANH069_T1 |        2049 |
| ANH069_T2 |        2050 |
| ANH069_T3 |        2051 |
| ANH077_T1 |        2052 |
| ANH077_T2 |        2053 |
| ANH077_T3 |        2054 |
| ANH081_T1 |        2077 |
| ANH081_T2 |        2078 |
| ANH081_T3 |        2079 |
| ANH085_T1 |        2080 |
| ANH085_T2 |        2081 |
| ANH085_T3 |        2082 |
| ANH088_T1 |        2055 |
| ANH088_T2 |        2056 |
| ANH088_T3 |        2057 |
| ANH089_T3 |        2058 |
| ANH095_T3 |        2059 |
| ANH101_T3 |        2060 |
| ANH106_T1 |        2083 |
| ANH106_T2 |        2084 |
| ANH106_T3 |        2085 |
| ANH109_T1 |        1905 |
| ANH109_T2 |        1906 |
| ANH109_T3 |        1907 |
| ANH112_T1 |        1939 |
| ANH112_T2 |        1940 |
| ANH112_T3 |        1941 |
| ANH121_T1 |        1942 |
| ANH121_T3 |        1943 |
| ANH135_T1 |        1908 |
| ANH135_T2 |        1909 |
| ANH135_T3 |        1910 |
| ANH145_T1 |        1944 |
| ANH145_T2 |        1945 |
| ANH145_T3 |        1946 |
| ANH159_T1 |        1911 |
| ANH159_T2 |        1912 |
| ANH159_T3 |        1913 |
| ANH160_T1 |        1914 |
| ANH160_T2 |        1915 |
| ANH160_T3 |        1916 |
| ANH166_T1 |        1917 |
| ANH166_T2 |        1918 |
| ANH166_T3 |        1919 |
| ANH181_T1 |        1920 |
| ANH181_T2 |        1921 |
| ANH181_T3 |        1922 |
| ANH182_T1 |        1923 |
| ANH182_T2 |        1924 |
| ANH182_T3 |        1925 |
| ANH183_T1 |        2086 |
| ANH183_T2 |        2087 |
| ANH183_T3 |        2088 |
| ANH185_T1 |        1926 |
| ANH185_T2 |        1927 |
| ANH185_T3 |        1928 |
| ANH189_T1 |        1954 |
| ANH189_T2 |        1955 |
| ANH189_T3 |        1956 |
| ANH192_T1 |        1957 |
| ANH192_T2 |        1958 |
| ANH192_T3 |        1959 |
| ANH194_T1 |        2089 |
| ANH194_T2 |        2090 |
| ANH194_T3 |        2091 |
| ANH197_T1 |        1960 |
| ANH197_T2 |        1961 |
| ANH197_T3 |        1962 |
| ANH209_T1 |        2092 |
| ANH209_T2 |        2093 |
| ANH209_T3 |        2094 |
| ANH210_T1 |        2095 |
| ANH210_T2 |        2096 |
| ANH210_T3 |        2097 |
| ANH211_T1 |        1963 |
| ANH211_T2 |        1964 |
| ANH211_T3 |        1965 |
| ANH212_T1 |        2098 |
| ANH212_T2 |        2099 |
| ANH212_T3 |        2100 |
| ANH213_T3 |        1966 |

Displaying records 1 - 100

</div>

## 12.6 event

**Poner 18:00:00 y 06:00:00 en las horas es malo?**

``` sql
INSERT INTO main.event(cd_gp_event,event_id,num_replicate, description_replicate, date_time_begin, date_time_end, locality_verb, event_remarks, samp_effort_1, samp_effort_2, pt_geom)
SELECT cd_gp_event,
  event_id, 
  1 AS num_replicate,
  NULL AS description_replicate,
  (TO_DATE(SPLIT_PART(event_date,'/',1), 'YYYY-MM-DD')||' 18:00:00')::timestamp date_time_begin,
  (TO_DATE(SPLIT_PART(event_date,'/',2), 'YYYY-MM-DD')||' 06:00:00')::timestamp date_time_end,
  locality locality_verb,
  NULL AS event_remarks,
  sample_size_value samp_effort_1,
  REGEXP_REPLACE(sampling_effort,'^([0-9]*) .*','\1')::int samp_effort_2,
  --locality_remarks,
  ST_SetSRID(ST_Transform(ST_SetSRID(ST_MakePoint(decimal_longitude,decimal_latitude),4326), (SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)),3116) pt_geom
FROM raw_dwc.cameras_trampa_event
LEFT JOIN main.gp_event USING (cd_gp_event)
LEFT JOIN main.def_protocol p USING (cd_protocol)
ORDER BY cd_gp_event, event_id, num_replicate

RETURNING main.event.cd_event, main.event.cd_gp_event, main.event.event_id, main.event.num_replicate, main.event.description_replicate, main.event.date_time_begin, main.event.date_time_end, main.event.locality_verb, main.event.event_remarks, main.event.pt_geom
```

**Averiguar si los samp_effort_2 están bien**:

``` sql
SELECT date_time_end-date_time_begin,samp_effort_2 FROM main.event LEFT JOIN main.gp_event USING (cd_gp_event) WHERE cd_gp_biol='catr';
```

<div class="knitsql-table">

| ?column?         | samp_effort_2 |
|:-----------------|--------------:|
| 57 days 12:00:00 |            58 |
| 62 days 12:00:00 |            63 |
| 57 days 12:00:00 |            58 |
| 62 days 12:00:00 |            63 |
| 61 days 12:00:00 |            62 |
| 61 days 12:00:00 |            62 |
| 58 days 12:00:00 |            59 |
| 61 days 12:00:00 |            62 |
| 62 days 12:00:00 |            63 |
| 57 days 12:00:00 |            58 |
| 62 days 12:00:00 |            63 |
| 74 days 12:00:00 |            75 |
| 57 days 12:00:00 |            58 |
| 62 days 12:00:00 |            63 |
| 74 days 12:00:00 |            75 |
| 57 days 12:00:00 |            58 |
| 54 days 12:00:00 |            55 |
| 59 days 12:00:00 |            60 |
| 57 days 12:00:00 |            58 |
| 62 days 12:00:00 |            63 |
| 74 days 12:00:00 |            75 |
| 57 days 12:00:00 |            58 |
| 62 days 12:00:00 |            63 |
| 74 days 12:00:00 |            75 |
| 57 days 12:00:00 |            58 |
| 61 days 12:00:00 |            62 |
| 61 days 12:00:00 |            62 |
| 58 days 12:00:00 |            59 |
| 61 days 12:00:00 |            62 |
| 62 days 12:00:00 |            63 |
| 62 days 12:00:00 |            63 |
| 57 days 12:00:00 |            58 |
| 67 days 12:00:00 |            68 |
| 60 days 12:00:00 |            61 |
| 57 days 12:00:00 |            58 |
| 61 days 12:00:00 |            62 |
| 47 days 12:00:00 |            48 |
| 57 days 12:00:00 |            58 |
| 61 days 12:00:00 |            62 |
| 67 days 12:00:00 |            68 |
| 57 days 12:00:00 |            58 |
| 61 days 12:00:00 |            62 |
| 57 days 12:00:00 |            58 |
| 61 days 12:00:00 |            62 |
| 62 days 12:00:00 |            63 |
| 57 days 12:00:00 |            58 |
| 60 days 12:00:00 |            61 |
| 60 days 12:00:00 |            61 |
| 57 days 12:00:00 |            58 |
| 66 days 12:00:00 |            67 |
| 57 days 12:00:00 |            58 |
| 62 days 12:00:00 |            63 |
| 66 days 12:00:00 |            58 |
| 60 days 12:00:00 |            61 |
| 60 days 12:00:00 |            61 |
| 57 days 12:00:00 |            58 |
| 66 days 12:00:00 |            67 |
| 56 days 12:00:00 |            57 |
| 57 days 12:00:00 |            58 |
| 60 days 12:00:00 |            61 |
| 64 days 12:00:00 |            65 |
| 57 days 12:00:00 |            58 |
| 61 days 12:00:00 |            62 |
| 59 days 12:00:00 |            60 |
| 57 days 12:00:00 |            58 |
| 57 days 12:00:00 |            58 |
| 62 days 12:00:00 |            63 |
| 61 days 12:00:00 |            62 |
| 63 days 12:00:00 |            64 |
| 58 days 12:00:00 |            59 |
| 62 days 12:00:00 |            63 |
| 70 days 12:00:00 |            71 |
| 57 days 12:00:00 |            58 |
| 61 days 12:00:00 |            62 |
| 62 days 12:00:00 |            63 |
| 56 days 12:00:00 |            58 |
| 61 days 12:00:00 |            62 |
| 63 days 12:00:00 |            64 |
| 57 days 12:00:00 |            58 |
| 62 days 12:00:00 |            63 |
| 69 days 12:00:00 |            70 |
| 57 days 12:00:00 |            58 |
| 62 days 12:00:00 |            63 |
| 70 days 12:00:00 |            71 |
| 57 days 12:00:00 |            58 |
| 62 days 12:00:00 |            63 |
| 70 days 12:00:00 |            71 |
| 57 days 12:00:00 |            58 |
| 62 days 12:00:00 |            63 |
| 74 days 12:00:00 |            75 |
| 57 days 12:00:00 |            58 |
| 62 days 12:00:00 |            63 |
| 74 days 12:00:00 |            75 |
| 57 days 12:00:00 |            28 |
| 62 days 12:00:00 |            63 |
| 69 days 12:00:00 |            70 |
| 57 days 12:00:00 |            58 |
| 62 days 12:00:00 |            63 |
| 67 days 12:00:00 |            68 |
| 57 days 12:00:00 |            58 |

Displaying records 1 - 100

</div>

Damos los cd_event a todos las filas:

``` sql
ALTER TABLE raw_dwc.cameras_trampa_event ADD COLUMN cd_event int REFERENCES main.event(cd_event) ON DELETE SET NULL;
ALTER TABLE raw_dwc.cameras_trampa_registros ADD COLUMN cd_event int REFERENCES main.event(cd_event);

UPDATE raw_dwc.cameras_trampa_event AS t
SET cd_event=e.cd_event
FROM main.event e
WHERE t.event_id=e.event_id;

UPDATE raw_dwc.cameras_trampa_registros AS t
SET cd_event=e.cd_event
FROM main.event e
WHERE t.event_id=e.event_id;

SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

## 12.7 registros

**Should we use the organism_id to separate the 30 min of delay to
consider 2 individuals?**

``` sql
SELECT occurrence_id, count(*)
FROM raw_dwc.cameras_trampa_registros 
GROUP BY occurrence_id
HAVING count(*)>1;
```

<div class="knitsql-table">

| occurrence_id | count |
|--------------:|------:|
|            NA | 67556 |

1 records

</div>

**Why are a lot of record numbers always repeated twice**?

``` sql
SELECT record_number, count(*)
FROM raw_dwc.cameras_trampa_registros 
GROUP BY record_number
HAVING count(*)>1;
```

<div class="knitsql-table">

| record_number                        | count |
|:-------------------------------------|------:|
| 427580f2-d5a6-4a4b-861d-e4fa089f89a3 |     2 |
| 7c071954-f315-433e-b9c0-ee99b78c71ec |     2 |
| 523912c8-437a-4803-81fa-98b43f8cdad0 |     2 |
| cf80f164-d393-4813-bff7-0e87f5e89af4 |     2 |
| 14a10adc-a412-4681-8021-d91b7f6a6ec2 |     2 |
| fbf6cdaf-78b1-4dd8-9220-1f5cd907168a |     2 |
| 574e9943-124c-4834-8567-c859c2d5f1e1 |     2 |
| ea5c00e3-2ee0-4097-8407-7a5d0e4dbdfe |     2 |
| fa982671-1931-441c-b0ee-e3b0f6baa033 |     3 |
| e6a19372-fdfe-4bff-acc7-00ffbda1f1b1 |     2 |
| 5183ded2-5ee7-4386-905e-1d150b749cee |     2 |
| 2b94b028-30d5-419c-910d-96fc5861981c |     2 |
| f6a4b75d-11ce-43e9-905d-cbbdb97e5f1f |     2 |
| acdaa0d9-846a-470f-b4e7-d19be4f014cc |     2 |
| a6ea9a2a-b06c-4f32-a966-0fe38e46ca94 |     2 |
| d6a67325-f9ec-41bb-bf0f-dadf317dad1c |     2 |
| 9009f982-fd9a-48c9-bcca-3054cc51b96c |     2 |
| 222042af-d515-432b-ae4c-67d3260481f6 |     2 |
| 8aadf43a-46fe-48b2-89db-a1e99acd5f7f |     2 |
| 4922c4c9-fd06-40aa-96a9-34a4448ab137 |     2 |
| 356d78ec-345d-40b1-bd41-fbfa27a22a50 |     2 |
| 0b1b6b14-2331-46d3-8526-8d3b5db18ec7 |     2 |
| 2518f85c-6de0-4017-aeb6-5f1fa082d9b9 |     2 |
| edaca5d4-614b-4191-a3de-4fe46bafa68f |     2 |
| 0a8e8e92-31ef-4476-8d3a-c28ad83d2972 |     2 |
| 8d4ac6b7-8ddf-4113-a75c-d2dd8f572d93 |     2 |
| e1402227-a7c0-4cf9-ba2f-30306ed36978 |     2 |
| 767aaec3-6245-45da-b18e-bd9e336e61d6 |     2 |
| c147f6a7-6bfc-4187-9be3-9dfca71e08b9 |     2 |
| da2bdc26-e4f9-4d87-ac41-8f2809aa883c |     2 |
| ffd675ef-8ea1-4998-bace-a9c6133bdb45 |     2 |
| b4b447b4-e98c-4556-aeb4-3e7b71add6d4 |     2 |
| d705a745-5c47-4cca-88f3-87b2237d8f62 |     2 |
| dc1959df-9c21-4903-86d7-5c98b357f492 |     2 |
| 0559761c-721c-4ef9-92e7-40976d0062e1 |     2 |
| 52dd5499-ad9b-477e-a0d9-6f6ae1a66ba7 |     2 |
| acc5da3b-a94e-4465-968b-ed6f8d1eef5a |     2 |
| 45a80403-ac9b-4670-8d89-f56f116b5e9a |     2 |
| 7ea1500f-0002-41c1-8000-3e1e134ee97f |     2 |
| cbceb10b-9807-423c-98b0-5c60ba2d9f4d |     2 |
| c4dacd84-f42d-4def-9a2f-ae1507f27ff5 |     2 |
| 00c6b6e7-037a-41a3-992f-9102784ecbff |     2 |
| 27868b7f-507e-4525-9ec2-8e79359337e4 |     2 |
| d93d18e8-e153-48e0-b385-392bc66cc391 |     2 |
| b499cb1e-e502-46da-8b00-febc0fc3ff25 |     2 |
| dc3dffb7-27a5-4b54-a19d-25b5ad16fe0f |     2 |
| c7071041-b4c2-4355-b124-429cb8521d53 |     2 |
| b3709e3b-cd23-4b59-a400-c5ad0f76db15 |     2 |
| 49627477-d0cf-48fa-abfa-04ce4b5d18fb |     2 |
| 47c289cf-60f0-47df-9937-a1c6e5d1b2d9 |     2 |
| 16387eff-e2e8-4e74-a1f3-2a5626bcfb90 |     2 |
| 1528c7e7-0a03-41a1-9d72-8ea8d1f0890d |     2 |
| 704fb528-9a43-4858-9d59-4bc36b3ded49 |     2 |
| eff6bb69-f889-401d-86fa-050649db6005 |     2 |
| 7f74f166-a83b-44d6-991d-2fa368356f3f |     2 |
| a045c82b-9c9c-4f4d-ac55-cb56719226f1 |     2 |
| 9417da6a-dbaa-45f8-aa93-c791206d30eb |     2 |
| b23ee01e-e35c-48a6-92be-91a0a694301c |     2 |
| 8467a533-e2e6-4f13-bc9f-74aa5a846122 |     2 |
| 5cb37366-34d7-42ff-ad1a-910e7ec1341e |     2 |
| b0084e6e-a98e-4baf-8494-d639160c7dd4 |     2 |
| cbf47efa-6c68-49fa-8d1c-28cb4cd93e99 |     2 |
| a64a6948-3993-4bfc-af1f-8f688f7e5d95 |     2 |
| 66780776-deb8-4542-b1cf-8d8b2edcc59c |     2 |
| 0b859f5f-9a18-46cb-a016-ff2083cf3359 |     2 |
| c5201703-73b1-4aaa-abca-db214224fb12 |     2 |
| 564bca6e-ddc8-4d5a-9c95-b5b66adce9a7 |     2 |
| 68c38d7c-3908-4fdb-8184-844a258c0b93 |     2 |
| 9dcdcfa0-7b04-4a35-bcf8-a40e4b81e0e1 |     2 |
| 998ece95-a7c8-4a71-b23b-8ecc60ff5347 |     2 |
| 77fae54c-6313-45e2-9802-740ae400317a |     2 |
| 1fdf7183-28db-4ff7-86d0-8a5df3b24d04 |     2 |
| c8e313ca-ebc2-4762-8d6e-c38350d646a6 |     2 |
| 4433b508-275c-43b4-aae9-10c127922762 |     2 |
| 1f50aebb-0266-47eb-b2c5-ce08bca357bc |     2 |
| 2c287b10-6197-4a88-a869-a286ae5c3dd0 |     2 |
| 0ec68b57-70e0-4e38-b1e2-cf36822c101e |     2 |
| 45a62a7d-2360-4b17-a707-8741ab01d46b |     2 |
| 7b155e19-043f-4053-8bcf-d9376bad5c2a |     2 |
| bcc6a005-bfb4-4ee9-9710-788734de3301 |     2 |
| ff25edff-f4fe-41af-8aa4-b767a81c25e5 |     2 |
| e5d4688d-eb23-413d-a068-89f0b0effc47 |     2 |
| afaf5fb3-4afe-4618-b51c-f5c5ae286e8b |     2 |
| 24590be5-970b-407a-b568-16cb83d816a0 |     2 |
| efa4045a-0ba0-4d7e-963c-f84a7deed61e |     2 |
| 5c8908dc-fca3-429e-9603-54494b34a88a |     2 |
| e9d29e18-8fb1-4f30-b7e2-619d36bf1da7 |     2 |
| 0694a714-25f0-411f-bc82-87ea8f8beec2 |     2 |
| 8ea701d6-3293-4edc-879a-633aeea59728 |     2 |
| 9f194cb9-4443-4929-ab9b-2edac64c7da5 |     2 |
| 197868bc-a5a8-42c7-8677-6c91a8058765 |     2 |
| 9bb975d1-48a5-4d1a-b40d-24091b5ed826 |     2 |
| 4e6dd8af-7d4b-4f50-9ea7-9beeb956ccb1 |     2 |
| 1441e5b5-266d-4401-87eb-23ced14d3f66 |     2 |
| bd21b52c-5ed2-4998-b904-e356bf3e47c3 |     2 |
| 7c2701c6-589e-4ab7-9a82-880a1f726f79 |     2 |
| 41c8c7e1-bacd-4854-a763-b98297553d89 |     2 |
| 273009d0-a56f-4854-a224-e3b33fc06661 |     2 |
| 08451f11-e7c4-4938-b7ff-584eddcb6c55 |     2 |
| 6b8b7fd8-b6a8-4c2d-a332-64def56214b7 |     2 |

Displaying records 1 - 100

</div>

**Why are a lot of associated numbers always repeated twice**?

``` sql
SELECT associated_media, count(*)
FROM raw_dwc.cameras_trampa_registros 
GROUP BY associated_media
HAVING count(*)>1;
```

<div class="knitsql-table">

| associated_media                                                                                           | count |
|:-----------------------------------------------------------------------------------------------------------|------:|
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2075726/1c65de1f-b7ea-4595-a49d-cbce8b773488.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2075726/65ed69d3-e06f-420f-a2c8-a327c11bd3e7.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2075726/bae3cc72-bc33-4694-be45-1702cda73426.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2075726/d846cf6b-6dbb-46cd-aac3-8e9f690490fe.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2075726/db9431e3-12ec-4a68-9097-5fa54491fe5c.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2075726/e18f7bae-17c0-4234-887b-c2dbfdb811b8.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2077642/17a612ed-901c-437f-86fa-3dd4e2b82806.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2077642/2e794af0-01fe-4c79-ade3-4f4217b75c77.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2077642/36d7aa70-dce7-46cc-8a04-7bb0b43c0931.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2077642/3b998e4a-3be9-48c2-969a-f7bb7c1d723e.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2077642/5b86daf9-8987-4467-8c4d-d3d328944e6f.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2077642/712547c7-d0db-4225-8452-56d110871b29.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2077642/76e326ef-c6f4-49a7-b082-7cd5f4bd0242.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2077642/829921a8-2914-44cb-905a-4b4f6e6a679f.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2077642/8841fc1e-a84f-41e5-9aaf-5ecbfb21eeab.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2077642/8e63b66f-b14e-4eef-b0c8-27a2a3d5ecfa.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2077642/99b63478-696e-4e36-aaf2-f8814c216962.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2077642/9a58a7e6-b5a4-4f32-8646-21a2ae8acff2.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2077642/9ac63e86-a62d-4b89-a10a-b9fd0b2e6fad.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2077642/be19ffc6-d7d5-4804-b82f-0d77cf44eb65.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2077642/d544c732-b112-4838-a5e4-f7f742382c23.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2077720/1d5afb52-d006-4d77-838d-21882ae220ea.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2077720/3f89ea42-7021-4b58-8cde-96564aa313e1.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2077720/87345838-34e9-49a4-886f-63fd0bcbaa95.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2077720/c09b2727-9e04-4fd2-9e6f-ab735ba7b6b8.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2077720/f6b91cb8-1b29-4d3d-8ce1-e99e493762e7.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2077720/fe0153fc-0d28-4574-a594-c0c234d9ec23.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2077783/077eaac0-b35e-4c53-9390-b258ae76a69a.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2077783/1d86174f-8ee0-4418-8d65-f1c6fcb9228a.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2077783/26573e85-7e8b-4989-868a-577c0fc0b867.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2077783/8181f64d-53fd-4551-9f8f-b9154eea52cd.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2078812/730097b4-7ed5-40df-921d-e1a85783df36.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2078812/8bd72957-b1be-4f4f-a6da-f7c9b7b1cd10.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2078812/b6f84d2b-6a38-4bd2-ba23-dc53ee5b0cad.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2080593/001ae110-830b-4fde-b499-4480581686c5.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2080593/4cc4482f-d025-45b6-8aaa-fe1102747501.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2080593/8380ecda-8b92-4f86-a22b-6c8742929178.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2082168/02ed9230-99a9-4f61-9cb8-19c30ae2ed76.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2082168/0876a7aa-6772-4eee-8e45-d65259e2b6fa.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2082168/09d9df29-7e76-437f-9a87-544c0c129976.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2082168/132cd65d-b949-4a87-8bf4-7a1ca604a198.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2082168/338eec32-bb4f-4274-b397-e12356bc7e20.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2082168/391da305-6715-406a-815d-9067e378d638.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2082168/3c9f327b-a93a-41ca-b365-1aed494ddd03.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2082168/47a7b908-25f8-478a-a482-9c9ace6247f1.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2082168/57be0f9c-e827-4695-ab91-d8ee0f4bda3f.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2082168/6b596508-14cc-429a-9974-c3b1ad752d06.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2082168/6d27e28c-f80e-4061-93d3-0c94bec7d0cf.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2082168/ce93c32e-6ab1-4298-93f0-9de08b2a198d.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2082168/f681f43c-ad93-44ef-a591-8545f9b99bb6.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2089478/00452e51-1925-4cb8-b1c5-d59782123741.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2089478/01727aeb-1112-472f-ba8d-e9ca2af6aed3.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2089478/09a14ee2-3015-4334-b1f9-325df2655cdc.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2089478/1fea6fee-07fd-473f-a717-3e2e19b05a8d.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2089478/27109526-f92f-4521-93fd-72131b839752.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2089478/29699760-3066-4caf-914c-256d4e0091ab.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2089478/3d195112-7d5c-49f7-be3b-ad18b0666dba.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2089478/3f6b6b7c-350a-47b3-a15e-a5b44a37be4c.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2089478/41c5e44d-69c1-4628-88c1-3211ba88b660.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2089478/446e7384-d16c-4fcb-876e-4cfbda763590.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2089478/45d85920-8143-4163-98b1-54f64d6f9924.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2089478/53c9a194-485a-4978-8569-a06e1d02da98.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2089478/69f92be6-d4c7-420a-98fa-3ff1d1139cb5.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2089478/7a1b44b8-59b2-4f79-887f-57bb70390407.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2089478/81ebc024-7ece-4fc0-9b68-12146ac31d13.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2089478/8f3a587a-a886-48ab-a686-93a726fec677.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2089478/9ab73a74-ca2a-48e8-98c4-e0f9e34e67e7.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2089478/fa9ce22d-a091-40fa-b41a-b921c7f798c7.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2089478/fc387247-6e6a-48c1-ba27-dfb3b4f3e51e.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2096955/01c7b83a-af7b-4afb-8b55-604046bc0580.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2096955/f8232e37-92bd-482f-b2ac-39b5eff397eb.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2103580/048a1e78-2858-447d-a402-bcae92a32cea.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2103580/4c954c07-3414-48a3-975b-0620a475a8c1.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2103580/51f8fbf6-1aa1-4009-9e4c-3f8bca3cd670.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2103580/6bd41d19-b590-4b69-8aca-e3bd95a819b4.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2103580/b392adee-2b0b-464a-8738-8221a99c7b6b.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2103580/da2de8e5-efa2-49f6-a158-cd280a2bb5ea.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2110226/13f7552a-27e9-47be-b114-ea453fa2b80e.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2110226/305b6c3a-84a2-45f0-b16c-3047009fd23b.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2110226/3d94cea9-4d57-4f30-b89b-172ebdbdf802.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2110226/3e45872d-90f4-4bef-9b24-e3449097fd10.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2121606/27bc4e64-ed42-4d40-a7ec-d68360aac145.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2121606/4e5fa583-7fb8-438c-80c0-af4dfc55a7b4.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2121606/6bd8ea28-a13e-443d-a463-552ebd4043c8.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2121606/72e63168-bd83-47ab-9a85-998d508cf364.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2121606/781b02b1-25ba-468a-a93a-1a1f177927b2.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2121606/8130161d-e714-4d1f-97a2-c1f5c546b65c.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2121606/8d192507-8734-4d7e-ba92-6b226c52d9dd.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2121606/8f5726d5-7abc-40ca-89ae-329d7aed6820.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2121606/baf10d7b-09c2-4ed7-967b-b92e686c4654.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2133977/0b55fa53-3e41-4482-8787-2bcff51e610c.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2133977/4684bc7a-796c-4bca-94bc-76067b37480e.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2133977/b6f7e805-9449-413f-adf3-1a0dc0f9a244.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2133978/03353a52-6f5a-435b-9079-c078863afecf.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2133978/3974a71d-2416-4c9d-801d-70640a0a63c8.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2133978/4105bc68-0bb3-4596-91d4-1d39c735c246.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2133978/55e6dc85-e909-4415-9172-9a98da266f33.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2133978/9166b843-0a1c-4699-9405-066f40eff5be.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2133978/9f39ba96-95ec-4257-86ff-a44bad9ceb8d.JPG |     2 |
| gs://437283855702_2003519_931_anh_2021\_\_main/deployment/2133978/a4603203-9967-4862-99bd-752ba7a8807d.JPG |     2 |

Displaying records 1 - 100

</div>

``` sql

INSERT INTO main.registros(cd_event, cds_recorded_by, date_time, cd_tax, cd_morfo, date_ident, cds_identified_by, qt_int,remarks, occurrence_id, organism_id)
SELECT 
 cd_event,
 cds_recorded_by,
 (event_date||' '||event_time)::timestamp date_time,
 tt.cd_tax,
 tt.cd_morfo,
 TO_DATE(date_identified,'YYYY-MM-DD') date_ident,
 cds_identified_by,
 organism_quantity::double precision::int qt_int,
 r."row.names" remarks, -- I use the empty remarks field to have a unique tag for later assignation
 occurrence_id,
 NULL AS organism_id
 --ROW_NUMBER() OVER (ORDER BY (e.date_time_begin::date||' '||event_time)::timestamp)
 --organism_id::text
FROM raw_dwc.cameras_trampa_registros r
LEFT JOIN raw_dwc.taxonomy_total tt ON tt."row.names"=r."row.names" AND tt.table_orig='cameras_trampa_registros'
LEFT JOIN main.event e USING (cd_event)
ORDER BY date_time
RETURNING cd_event, cds_recorded_by, date_time, cd_tax, cd_morfo, cds_identified_by, qt_int,remarks, occurrence_id, organism_id
```

``` sql
ALTER TABLE raw_dwc.cameras_trampa_registros ADD COLUMN cd_reg int REFERENCES main.registros(cd_reg);
UPDATE raw_dwc.cameras_trampa_registros AS ar
SET cd_reg=r.cd_reg
FROM main.registros r
WHERE ar."row.names"=r.remarks;

WITH a AS(
SELECT cd_reg 
FROM main.registros
LEFT JOIN main.event USING (cd_event)
LEFT JOIN main.gp_event USING (cd_gp_event)
WHERE cd_gp_biol = 'catr'
)
UPDATE main.registros r
SET remarks=NULL
FROM a
WHERE a.cd_reg=r.cd_reg;


-- Check cd_reg are unique in the source table
SELECT cd_reg,count(*) FROM  raw_dwc.cameras_trampa_registros GROUP BY cd_reg HAVING count(*)>1;
```

<div class="knitsql-table">

    cd_reg   count

------------------------------------------------------------------------

: 0 records

</div>

**Parece que hay errores fuertes en las fechas de los registros**

**YA HA SIDO CORREGIDO**

``` sql
SELECT cd_reg,e.event_id, 
  SPLIT_PART(e.event_date,'/',1)::date date1_event,
  SPLIT_PART(e.event_date,'/',2)::date date2_event,
  r.event_date event_date_registro, r.event_time event_time_registro,name_tax
FROM raw_dwc.cameras_trampa_registros r
LEFT JOIN raw_dwc.cameras_trampa_event e USING(cd_event)
LEFT JOIN main.registros USING(cd_reg)
LEFT JOIN main.taxo USING (cd_tax)
WHERE r.event_date<SPLIT_PART(e.event_date,'/',1) OR r.event_date>SPLIT_PART(e.event_date,'/',2)
ORDER BY r.event_date::date, r.event_time::time
```

<div class="knitsql-table">

|                                                                                          |
|:----------------------------------------------------------------------------------------:|
| cd_reg event_id date1_event date2_event event_date_registro event_time_registro name_tax |

------------------------------------------------------------------------

: 0 records

</div>

Comparación de fechas:

``` sql
SELECT  e.event_id,e.date_time_begin, e.date_time_end, MIN(r.date_time) min_date_time_reg, MAX(r.date_time) min_date_time_reg
FROM main.registros r
LEFT JOIN main.event e USING (cd_event)
LEFT JOIN main.gp_event ge USING (cd_gp_event)
WHERE cd_gp_biol='catr'
GROUP BY e.event_id,e.date_time_begin, e.date_time_end
;
```

<div class="knitsql-table">

| event_id  | date_time_begin     | date_time_end       | min_date_time_reg   | min_date_time_reg   |
|:----------|:--------------------|:--------------------|:--------------------|:--------------------|
| ANH243_T1 | 2021-07-28 18:00:00 | 2021-09-28 06:00:00 | 2021-07-28 10:42:55 | 2021-09-28 11:38:23 |
| ANH160_T2 | 2021-09-17 18:00:00 | 2021-12-01 06:00:00 | 2021-09-17 14:48:11 | 2021-12-01 11:37:44 |
| ANH194_T3 | 2022-03-28 18:00:00 | 2022-05-25 06:00:00 | 2022-03-28 12:20:23 | 2022-05-22 18:04:21 |
| ANH210_T3 | 2022-03-31 18:00:00 | 2022-05-28 06:00:00 | 2022-03-31 12:20:10 | 2022-05-23 13:23:15 |
| ANH217_T1 | 2021-07-27 18:00:00 | 2021-09-27 06:00:00 | 2021-07-27 10:29:03 | 2021-08-19 16:44:10 |
| ANH197_T3 | 2022-03-24 18:00:00 | 2022-05-21 06:00:00 | 2022-03-24 10:07:59 | 2022-05-21 15:15:09 |
| ANH189_T1 | 2021-07-26 18:00:00 | 2021-09-25 06:00:00 | 2021-07-26 08:35:57 | 2021-07-26 08:39:37 |
| ANH370_T1 | 2021-08-05 18:00:00 | 2021-10-05 06:00:00 | 2021-08-05 09:37:50 | 2021-08-05 09:51:32 |
| ANH159_T1 | 2021-07-16 18:00:00 | 2021-09-17 06:00:00 | 2021-07-16 16:33:33 | 2021-07-20 02:58:42 |
| ANH077_T2 | 2021-09-27 18:00:00 | 2021-11-30 06:00:00 | 2021-09-27 12:50:02 | 2021-10-24 10:22:27 |
| ANH185_T2 | 2021-09-23 18:00:00 | 2021-11-24 06:00:00 | 2021-09-23 13:39:25 | 2021-11-24 11:23:02 |
| ANH066_T1 | 2021-07-28 18:00:00 | 2021-09-28 06:00:00 | 2021-07-28 11:59:51 | 2021-07-31 02:31:36 |
| ANH069_T1 | 2021-07-21 18:00:00 | 2021-09-21 06:00:00 | 2021-07-21 11:48:45 | 2021-08-28 08:50:39 |
| ANH360_T2 | 2021-09-28 18:00:00 | 2021-11-28 06:00:00 | 2021-09-28 14:22:13 | 2021-11-05 15:53:34 |
| ANH238_T3 | 2022-03-22 18:00:00 | 2022-05-19 06:00:00 | 2022-03-22 11:16:27 | 2022-05-16 15:26:58 |
| ANH338_T3 | 2022-03-26 18:00:00 | 2022-05-23 06:00:00 | 2022-03-26 10:01:46 | 2022-05-22 22:24:22 |
| ANH390_T2 | 2021-09-25 18:00:00 | 2021-11-05 06:00:00 | 2021-09-25 09:05:06 | 2021-11-05 12:37:23 |
| ANH253_T3 | 2022-03-22 18:00:00 | 2022-05-28 06:00:00 | 2022-03-22 14:16:15 | 2022-05-28 14:31:55 |
| ANH235_T1 | 2021-07-16 18:00:00 | 2021-09-17 06:00:00 | 2021-07-16 15:22:18 | 2021-09-17 14:06:03 |
| ANH109_T3 | 2022-03-27 18:00:00 | 2022-05-25 06:00:00 | 2022-03-28 11:27:36 | 2022-05-17 17:35:17 |
| ANH233_T1 | 2021-07-17 18:00:00 | 2021-09-18 06:00:00 | 2021-07-17 09:27:09 | 2021-09-18 08:40:48 |
| ANH364_T2 | 2021-09-22 18:00:00 | 2021-11-10 06:00:00 | 2021-09-22 08:36:09 | 2021-11-10 10:20:15 |
| ANH058_T3 | 2022-03-18 18:00:00 | 2022-05-15 06:00:00 | 2022-03-18 11:11:31 | 2022-04-29 19:18:57 |
| ANH160_T3 | 2022-03-19 18:00:00 | 2022-05-16 06:00:00 | 2022-03-19 10:07:40 | 2022-05-11 05:09:27 |
| ANH182_T3 | 2022-03-19 18:00:00 | 2022-05-16 06:00:00 | 2022-03-19 13:09:22 | 2022-05-06 16:53:48 |
| ANH289_T3 | 2022-03-21 18:00:00 | 2022-05-18 06:00:00 | 2022-03-21 11:17:03 | 2022-05-17 14:40:03 |
| ANH280_T2 | 2021-10-05 18:00:00 | 2021-12-01 06:00:00 | 2021-10-05 13:54:03 | 2021-11-10 07:07:38 |
| ANH250_T1 | 2021-07-21 18:00:00 | 2021-09-21 06:00:00 | 2021-07-21 09:12:41 | 2021-07-26 10:05:14 |
| ANH181_T1 | 2021-07-16 18:00:00 | 2021-09-17 06:00:00 | 2021-07-16 13:27:34 | 2021-07-16 13:30:58 |
| ANH089_T3 | 2022-03-30 18:00:00 | 2022-05-31 06:00:00 | 2022-03-30 11:56:00 | 2022-05-10 16:35:20 |
| ANH240_T1 | 2021-07-19 18:00:00 | 2021-09-20 06:00:00 | 2021-07-19 08:19:27 | 2021-09-20 08:20:14 |
| ANH217_T2 | 2021-09-27 18:00:00 | 2021-11-30 06:00:00 | 2021-09-27 11:07:01 | 2021-11-14 05:58:57 |
| ANH317_T2 | 2021-09-18 18:00:00 | 2021-11-24 06:00:00 | 2021-09-18 12:15:44 | 2021-11-24 14:39:45 |
| ANH194_T2 | 2021-09-28 18:00:00 | 2021-11-29 06:00:00 | 2021-09-28 15:29:19 | 2021-09-29 16:16:37 |
| ANH214_T3 | 2022-03-25 18:00:00 | 2022-05-22 06:00:00 | 2022-03-25 08:37:15 | 2022-05-22 09:16:37 |
| ANH106_T3 | 2022-03-24 18:00:00 | 2022-05-21 06:00:00 | 2022-03-24 12:55:13 | 2022-05-19 15:59:36 |
| ANH211_T3 | 2022-03-31 18:00:00 | 2022-05-28 06:00:00 | 2022-03-31 10:29:45 | 2022-05-28 23:26:41 |
| ANH159_T2 | 2021-09-17 18:00:00 | 2021-12-01 06:00:00 | 2021-09-17 15:19:14 | 2021-11-07 12:31:25 |
| ANH351_T3 | 2022-03-23 18:00:00 | 2022-06-11 06:00:00 | 2022-03-23 08:21:57 | 2022-06-11 08:01:59 |
| ANH197_T2 | 2021-09-25 18:00:00 | 2021-11-29 06:00:00 | 2021-09-25 12:18:40 | 2021-11-11 14:59:39 |
| ANH317_T1 | 2021-07-17 18:00:00 | 2021-09-18 06:00:00 | 2021-07-17 13:41:11 | 2021-09-18 12:09:53 |
| ANH283_T1 | 2021-07-26 18:00:00 | 2021-09-25 06:00:00 | 2021-07-26 10:36:21 | 2021-07-26 10:37:22 |
| ANH112_T3 | 2022-03-22 18:00:00 | 2022-05-19 06:00:00 | 2022-03-22 15:20:00 | 2022-05-17 08:30:03 |
| ANH221_T1 | 2021-07-17 18:00:00 | 2021-09-18 06:00:00 | 2021-07-17 10:51:59 | 2021-07-21 06:47:39 |
| ANH233_T3 | 2022-03-23 18:00:00 | 2022-05-20 06:00:00 | 2022-03-23 09:35:23 | 2022-03-26 17:50:31 |
| ANH135_T3 | 2022-03-29 18:00:00 | 2022-05-26 06:00:00 | 2022-03-29 12:15:11 | 2022-05-23 09:33:12 |
| ANH230_T2 | 2021-09-18 18:00:00 | 2021-11-28 06:00:00 | 2021-09-18 11:22:43 | 2021-11-17 15:14:30 |
| ANH393_T3 | 2022-03-18 18:00:00 | 2022-05-01 06:00:00 | 2022-03-18 09:03:52 | 2022-05-01 08:54:02 |
| ANH088_T3 | 2022-03-31 18:00:00 | 2022-05-28 06:00:00 | 2022-03-31 09:55:28 | 2022-05-28 15:02:42 |
| ANH353_T2 | 2021-10-05 18:00:00 | 2021-11-18 06:00:00 | 2021-10-05 12:20:12 | 2021-11-18 15:03:33 |
| ANH038_T2 | 2021-09-29 18:00:00 | 2021-12-01 06:00:00 | 2021-09-29 11:23:00 | 2021-11-09 10:55:48 |
| ANH197_T1 | 2021-07-26 18:00:00 | 2021-09-25 06:00:00 | 2021-07-26 12:28:49 | 2021-07-27 10:30:33 |
| ANH327_T1 | 2021-07-29 18:00:00 | 2021-09-29 06:00:00 | 2021-07-29 14:50:11 | 2021-07-29 14:52:13 |
| ANH183_T2 | 2021-09-17 18:00:00 | 2021-12-01 06:00:00 | 2021-09-17 12:20:00 | 2021-11-17 13:51:25 |
| ANH227_T1 | 2021-07-21 18:00:00 | 2021-09-21 06:00:00 | 2021-07-21 15:23:03 | 2021-07-21 15:24:11 |
| ANH181_T3 | 2022-03-18 18:00:00 | 2022-05-15 06:00:00 | 2022-03-19 11:39:57 | 2022-05-14 04:37:40 |
| ANH228_T1 | 2021-07-19 18:00:00 | 2021-09-20 06:00:00 | 2021-07-19 12:28:48 | 2021-07-30 08:13:30 |
| ANH189_T2 | 2021-09-25 18:00:00 | 2021-11-25 06:00:00 | 2021-09-25 08:40:15 | 2021-11-05 11:26:43 |
| ANH241_T1 | 2021-07-19 18:00:00 | 2021-09-20 06:00:00 | 2021-07-19 08:55:11 | 2021-08-27 08:19:30 |
| ANH334_T1 | 2021-08-05 18:00:00 | 2021-09-29 06:00:00 | 2021-08-05 11:45:21 | 2021-09-26 16:07:22 |
| ANH336_T3 | 2022-03-26 18:00:00 | 2022-05-24 06:00:00 | 2022-03-26 12:15:19 | 2022-05-22 17:17:40 |
| ANH236_T3 | 2022-03-19 18:00:00 | 2022-05-16 06:00:00 | 2022-03-19 12:40:29 | 2022-05-15 10:51:29 |
| ANH361_T1 | 2021-07-30 18:00:00 | 2021-09-30 06:00:00 | 2021-07-30 12:59:26 | 2021-09-01 09:38:23 |
| ANH353_T3 | 2022-03-31 18:00:00 | 2022-05-28 06:00:00 | 2022-03-31 07:31:44 | 2022-04-20 16:44:37 |
| ANH012_T3 | 2022-03-24 18:00:00 | 2022-05-21 06:00:00 | 2022-03-24 11:45:29 | 2022-04-22 11:23:52 |
| ANH088_T1 | 2021-08-06 18:00:00 | 2021-09-30 06:00:00 | 2021-08-06 09:06:12 | 2021-08-10 10:42:22 |
| ANH290_T2 | 2021-09-27 18:00:00 | 2021-11-07 06:00:00 | 2021-09-27 07:58:56 | 2021-11-07 05:58:28 |
| ANH274_T1 | 2021-07-23 18:00:00 | 2021-09-23 06:00:00 | 2021-07-23 12:25:21 | 2021-09-23 11:16:33 |
| ANH256_T3 | 2022-03-30 18:00:00 | 2022-05-27 06:00:00 | 2022-03-30 13:12:48 | 2022-05-21 09:10:43 |
| ANH274_T3 | 2022-03-27 18:00:00 | 2022-05-25 06:00:00 | 2022-03-27 16:29:02 | 2022-05-25 16:06:23 |
| ANH228_T2 | 2021-09-20 18:00:00 | 2021-11-29 06:00:00 | 2021-09-20 15:04:17 | 2021-11-09 15:23:04 |
| ANH232_T3 | 2022-03-23 18:00:00 | 2022-05-20 06:00:00 | 2022-03-23 07:43:28 | 2022-05-15 12:53:20 |
| ANH066_T2 | 2021-09-28 18:00:00 | 2021-11-28 06:00:00 | 2021-09-28 12:31:57 | 2021-11-12 09:29:14 |
| ANH211_T1 | 2021-07-28 18:00:00 | 2021-09-28 06:00:00 | 2021-07-28 11:10:23 | 2021-09-03 23:35:18 |
| ANH064_T3 | 2022-03-28 18:00:00 | 2022-05-25 06:00:00 | 2022-03-28 13:32:05 | 2022-04-26 16:13:01 |
| ANH252_T3 | 2022-03-30 18:00:00 | 2022-05-29 06:00:00 | 2022-03-30 12:33:45 | 2022-05-29 08:42:00 |
| ANH226_T2 | 2021-09-29 18:00:00 | 2021-12-01 06:00:00 | 2021-09-29 10:39:16 | 2021-09-29 10:40:01 |
| ANH375_T3 | 2022-03-21 18:00:00 | 2022-05-18 06:00:00 | 2022-03-21 10:27:27 | 2022-05-17 18:13:18 |
| ANH360_T1 | 2021-07-22 18:00:00 | 2021-09-28 06:00:00 | 2021-07-22 14:37:48 | 2021-08-30 10:41:27 |
| ANH095_T3 | 2022-03-18 18:00:00 | 2022-05-15 06:00:00 | 2022-03-18 11:55:35 | 2022-05-15 08:14:45 |
| ANH231_T3 | 2022-03-23 18:00:00 | 2022-05-20 06:00:00 | 2022-03-23 10:33:03 | 2022-04-21 09:46:40 |
| ANH388_T1 | 2021-07-23 18:00:00 | 2021-09-23 06:00:00 | 2021-07-23 09:42:35 | 2021-09-23 09:19:13 |
| ANH106_T1 | 2021-07-30 18:00:00 | 2021-09-30 06:00:00 | 2021-07-30 11:24:31 | 2021-08-16 17:23:39 |
| ANH257_T1 | 2021-07-21 18:00:00 | 2021-09-21 06:00:00 | 2021-07-21 10:53:41 | 2021-09-21 10:10:22 |
| ANH370_T3 | 2022-03-23 18:00:00 | 2022-05-20 06:00:00 | 2022-03-23 09:02:01 | 2022-03-24 00:00:01 |
| ANH272_T3 | 2022-03-30 18:00:00 | 2022-05-27 06:00:00 | 2022-03-30 09:55:45 | 2022-05-22 05:12:21 |
| ANH215_T2 | 2021-09-27 18:00:00 | 2021-11-30 06:00:00 | 2021-09-27 13:29:45 | 2021-09-27 13:35:18 |
| ANH085_T2 | 2021-09-29 18:00:00 | 2021-12-01 06:00:00 | 2021-09-29 09:04:31 | 2021-11-10 16:10:47 |
| ANH012_T1 | 2021-07-30 18:00:00 | 2021-09-30 06:00:00 | 2021-07-30 11:56:37 | 2021-08-17 08:56:38 |
| ANH390_T3 | 2022-03-21 18:00:00 | 2022-05-18 06:00:00 | 2022-03-21 12:27:06 | 2022-05-18 00:25:11 |
| ANH085_T1 | 2021-07-29 18:00:00 | 2021-09-29 06:00:00 | 2021-07-29 12:38:06 | 2021-08-05 16:32:09 |
| ANH250_T2 | 2021-09-21 18:00:00 | 2021-11-25 06:00:00 | 2021-09-21 07:50:23 | 2021-09-24 07:15:48 |
| ANH210_T1 | 2021-07-28 18:00:00 | 2021-09-28 06:00:00 | 2021-07-28 14:38:16 | 2021-08-14 13:18:06 |
| ANH088_T2 | 2021-09-30 18:00:00 | 2021-11-27 06:00:00 | 2021-10-05 10:49:17 | 2021-11-27 10:41:44 |
| ANH284_T3 | 2022-03-18 18:00:00 | 2022-05-15 06:00:00 | 2022-03-18 09:58:52 | 2022-05-12 07:19:56 |
| ANH064_T1 | 2021-07-30 18:00:00 | 2021-10-05 06:00:00 | 2021-07-30 14:39:46 | 2021-08-03 20:28:33 |
| ANH223_T1 | 2021-07-29 18:00:00 | 2021-09-29 06:00:00 | 2021-07-29 08:43:58 | 2021-09-03 08:51:11 |
| ANH226_T3 | 2022-03-29 18:00:00 | 2022-05-25 06:00:00 | 2022-03-29 10:32:10 | 2022-05-25 23:08:54 |
| ANH275_T1 | 2021-07-19 18:00:00 | 2021-09-20 06:00:00 | 2021-07-19 09:21:41 | 2021-09-20 09:11:44 |
| ANH253_T1 | 2021-07-19 18:00:00 | 2021-09-20 06:00:00 | 2021-07-19 14:31:26 | 2021-09-16 13:46:55 |

Displaying records 1 - 100

</div>

# 13 Botanica (integración en curso)

------------------------------------------------------------------------

**Notas para botánica**:

1.  Para los epifitas, el nivel *event* no corresponde a lo que debería:
    nos queda difícil anotar los esfuerzos de muestreo y las
    características de las mallas o de los transectos en la estructura
    actual…
2.  En relación con el punto anterior: las medidas de esfuerzo dadas en
    cada “event_id” no corresponden con los esfuerzos que se aplicaron
    en campo al nivel de los eventos, hay que multiplicar este esfuerzo
    por números de mallas
3.  Cuando se anote “epifitas no vasculares”, está implícito que se ha
    podido hacer también epifitas no vasculares, pero no es siempre el
    caso
4.  Hay filas de la pestaña de epifitas no vasculares que corresponden a
    la ausencia de organismos, si bien entiendo que esa información
    puede ser util, no está conforme a lo que debería entrar a un DwC.
    Adémas, se afectan a “Plantae” sin ninguna razón…
5.  No se anotaron las horas…
6.  Siempre en esos protocolos de plantas, la definición del “individuo”
    se vuelve complicada… un tag corresponde a una ramificación, y cada
    ramificación de un arbol obtiene una fila del archivo, lo que es muy
    practico para analizar el crecimiento de los individuo, pero confuso
    en terminos de abundancia…
7.  Para las epifitas vasculares, tambien se considera una definición
    rara de la cobertura, en percentaje, pero no entiendo a que
    correspondera

*Lo que pienso hacer es*:

1.  crear un evento por malla, eso implica utilizar event_id con nuevos
    nombres
2.  suprimir las filas de registros que no corresponden a organismos,
    anotar la cobertura, 100%-total debería corresponder a las filas
    excluídas. Si no es el caso, pedir más informaciones…

------------------------------------------------------------------------

Para entender el plan de muestreo

``` sql
SELECT e.occurrence_id, e.sampling_protocol, COUNT(DISTINCT a."row.names") nb_reg_arbo, COUNT (DISTINCT ev."row.names") nb_reg_epi_vas, COUNT (DISTINCT env."row.names")  nb_reg_epi_novas 
FROM raw_dwc.botanica_event e 
LEFT JOIN raw_dwc.botanica_registros_arborea a ON e.occurrence_id=a.event_id 
LEFT JOIN raw_dwc.botanica_registros_epi_vas ev ON e.occurrence_id = ev.event_id 
LEFT JOIN raw_dwc.botanica_registros_epi_novas env ON e.occurrence_id=env.event_id
GROUP BY e.occurrence_id, e.sampling_protocol
```

<div class="knitsql-table">

| occurrence_id | sampling_protocol                                                                                                                                                                                         | nb_reg_arbo | nb_reg_epi_vas | nb_reg_epi_novas |
|:--------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------:|---------------:|-----------------:|
| ANH_12_1      | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          12 |              0 |                0 |
| ANH_12_10     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          12 |              0 |                0 |
| ANH_12_1_F    | Muestreo de flora epifita no vascular sugerido por la ANLA para solicitudes de licenciamiento ambiental.                                                                                                  |           0 |              2 |              125 |
| ANH_12_2      | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |           8 |              0 |                0 |
| ANH_12_3      | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          12 |              0 |                0 |
| ANH_12_4      | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |           4 |              0 |                0 |
| ANH_12_5      | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |           6 |              0 |                0 |
| ANH_12_6      | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          11 |              0 |                0 |
| ANH_12_7      | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          14 |              0 |                0 |
| ANH_12_8      | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          19 |              0 |                0 |
| ANH_12_9      | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          24 |              0 |                0 |
| ANH_18_1      | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |           3 |              0 |                0 |
| ANH_18_10     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |           8 |              0 |                0 |
| ANH_18_1_F    | Muestreo de flora epifita no vascular sugerido por la ANLA para solicitudes de licenciamiento ambiental.                                                                                                  |           0 |              8 |              111 |
| ANH_18_2      | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |           8 |              0 |                0 |
| ANH_18_3      | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          15 |              0 |                0 |
| ANH_18_4      | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |           8 |              0 |                0 |
| ANH_18_5      | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |           9 |              0 |                0 |
| ANH_18_6      | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |           7 |              0 |                0 |
| ANH_18_7      | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          13 |              0 |                0 |
| ANH_18_8      | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |           5 |              0 |                0 |
| ANH_18_9      | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          17 |              0 |                0 |
| ANH_284_1     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |           8 |              0 |                0 |
| ANH_284_10    | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          13 |              0 |                0 |
| ANH_284_1_F   | Muestreo de flora epifita no vascular sugerido por la ANLA para solicitudes de licenciamiento ambiental.                                                                                                  |           0 |              4 |              114 |
| ANH_284_2     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          10 |              0 |                0 |
| ANH_284_3     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          20 |              0 |                0 |
| ANH_284_4     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          10 |              0 |                0 |
| ANH_284_5     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          17 |              0 |                0 |
| ANH_284_6     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          26 |              0 |                0 |
| ANH_284_7     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          15 |              0 |                0 |
| ANH_284_8     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          19 |              0 |                0 |
| ANH_284_9     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |           9 |              0 |                0 |
| ANH_306_1     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          12 |              0 |                0 |
| ANH_306_10    | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          23 |              0 |                0 |
| ANH_306_2     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          16 |              0 |                0 |
| ANH_306_3     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          24 |              0 |                0 |
| ANH_306_4     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          12 |              0 |                0 |
| ANH_306_5     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          15 |              0 |                0 |
| ANH_306_6     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          18 |              0 |                0 |
| ANH_306_7     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          14 |              0 |                0 |
| ANH_306_8     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          17 |              0 |                0 |
| ANH_306_9     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          23 |              0 |                0 |
| ANH_306_9_F   | Muestreo de flora epifita no vascular sugerido por la ANLA para solicitudes de licenciamiento ambiental.                                                                                                  |           0 |              0 |               67 |
| ANH_307_1     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          11 |              0 |                0 |
| ANH_307_10    | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          13 |              0 |                0 |
| ANH_307_1_F   | Muestreo de flora epifita no vascular sugerido por la ANLA para solicitudes de licenciamiento ambiental.                                                                                                  |           0 |              1 |              166 |
| ANH_307_2     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          18 |              0 |                0 |
| ANH_307_3     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          22 |              0 |                0 |
| ANH_307_4     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          13 |              0 |                0 |
| ANH_307_5     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          15 |              0 |                0 |
| ANH_307_6     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          16 |              0 |                0 |
| ANH_307_7     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          17 |              0 |                0 |
| ANH_307_8     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          18 |              0 |                0 |
| ANH_307_9     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          11 |              0 |                0 |
| ANH_308_1     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          21 |              0 |                0 |
| ANH_308_10    | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |           5 |              0 |                0 |
| ANH_308_2     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          13 |              0 |                0 |
| ANH_308_3     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |           9 |              0 |                0 |
| ANH_308_3_F   | Muestreo de flora epifita no vascular sugerido por la ANLA para solicitudes de licenciamiento ambiental.                                                                                                  |           0 |              1 |               76 |
| ANH_308_4     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          16 |              0 |                0 |
| ANH_308_5     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |           6 |              0 |                0 |
| ANH_308_6     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |           7 |              0 |                0 |
| ANH_308_7     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |           8 |              0 |                0 |
| ANH_308_8     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          11 |              0 |                0 |
| ANH_308_9     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |           1 |              0 |                0 |
| ANH_309_1     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          12 |              0 |                0 |
| ANH_309_10    | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |           5 |              0 |                0 |
| ANH_309_1_F   | Muestreo de flora epifita no vascular sugerido por la ANLA para solicitudes de licenciamiento ambiental.                                                                                                  |           0 |              0 |              143 |
| ANH_309_2     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |           6 |              0 |                0 |
| ANH_309_3     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |           6 |              0 |                0 |
| ANH_309_4     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |           3 |              0 |                0 |
| ANH_309_5     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |           3 |              0 |                0 |
| ANH_309_6     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |           4 |              0 |                0 |
| ANH_309_7     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |           8 |              0 |                0 |
| ANH_309_8     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |           6 |              0 |                0 |
| ANH_309_9     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |           9 |              0 |                0 |
| ANH_310_1     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          15 |              0 |                0 |
| ANH_310_10    | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          18 |              0 |                0 |
| ANH_310_1_F   | Muestreo de flora epifita no vascular sugerido por la ANLA para solicitudes de licenciamiento ambiental.                                                                                                  |           0 |              0 |              199 |
| ANH_310_2     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |           9 |              0 |                0 |
| ANH_310_3     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          11 |              0 |                0 |
| ANH_310_4     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          19 |              0 |                0 |
| ANH_310_5     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |           8 |              0 |                0 |
| ANH_310_6     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          13 |              0 |                0 |
| ANH_310_7     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          15 |              0 |                0 |
| ANH_310_8     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          13 |              0 |                0 |
| ANH_310_9     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          15 |              0 |                0 |
| ANH_312_1     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          11 |              0 |                0 |
| ANH_312_10    | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          13 |              0 |                0 |
| ANH_312_1_F   | Muestreo de flora epifita no vascular sugerido por la ANLA para solicitudes de licenciamiento ambiental.                                                                                                  |           0 |              1 |              169 |
| ANH_312_2     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          13 |              0 |                0 |
| ANH_312_3     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |           7 |              0 |                0 |
| ANH_312_4     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          16 |              0 |                0 |
| ANH_312_5     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          10 |              0 |                0 |
| ANH_312_6     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          15 |              0 |                0 |
| ANH_312_7     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          14 |              0 |                0 |
| ANH_312_8     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          14 |              0 |                0 |
| ANH_312_9     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          11 |              0 |                0 |
| ANH_314_1     | Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm |          17 |              0 |                0 |

Displaying records 1 - 100

</div>

Acá tenemos un problema: como saber si se realizó el muestro de epifitas
vasculares (como hacer la diferencia entre “no encontraron” y “no se
hizó”) –\> Sandra me envió la lista que integré a la consulta

``` sql
WITH a AS(
SELECT e.occurrence_id,
    REGEXP_REPLACE(e.occurrence_id,'^ANH_([0-9]{1,3})_([0-9]{1,2})(_F)?$','\1')::int anh_num,
    REGEXP_REPLACE(e.occurrence_id,'^ANH_([0-9]{1,3})_([0-9]{1,2})(_F)?$','\2')::int repli,
    CASE
        WHEN e.sampling_protocol='Muestreo de comunidades de hierbas para estimar coberturas en cuadrantes de un metro cuadrado' THEN ARRAY[NULL]
        WHEN e.sampling_protocol='Muestreo de flora epifita no vascular sugerido por la ANLA para solicitudes de licenciamiento ambiental.' THEN 
            CASE
                WHEN e.occurrence_id IN ('ANH_12_1_F','ANH_18_1_F','ANH_284_1_F','ANH_307_1_F','ANH_308_1_F','ANH_312_1_F','ANH_319_1_F','ANH_320_1_F','ANH_335_1_F','ANH_395_1_F') THEN ARRAY['epva','epnv']
                ELSE ARRAY['epnv']
            END
        WHEN e.sampling_protocol='Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm' THEN ARRAY['arbo']
    END cds_gp_biol
FROM raw_dwc.botanica_event e
),b AS(
SELECT occurrence_id, anh_num, repli, UNNEST(cds_gp_biol) cd_gp_biol
FROM a
)
SELECT anh_num, cd_gp_biol, ARRAY_AGG(repli ORDER BY repli) replis, ARRAY_AGG(occurrence_id) event_ids
FROM b
WHERE cd_gp_biol IS NOT NULL
GROUP BY anh_num,cd_gp_biol
ORDER BY cd_gp_biol,anh_num
```

<div class="knitsql-table">

| anh_num | cd_gp_biol | replis                 | event_ids                                                                                              |
|--------:|:-----------|:-----------------------|:-------------------------------------------------------------------------------------------------------|
|      12 | arbo       | {1,2,3,4,5,6,7,8,9,10} | {ANH_12_3,ANH_12_4,ANH_12_5,ANH_12_6,ANH_12_7,ANH_12_8,ANH_12_9,ANH_12_10,ANH_12_1,ANH_12_2}           |
|      18 | arbo       | {1,2,3,4,5,6,7,8,9,10} | {ANH_18_7,ANH_18_8,ANH_18_9,ANH_18_10,ANH_18_1,ANH_18_2,ANH_18_3,ANH_18_4,ANH_18_5,ANH_18_6}           |
|      88 | arbo       | {1,2,3,4,5,6,7,8,9,10} | {ANH_88_4,ANH_88_1,ANH_88_9,ANH_88_8,ANH_88_7,ANH_88_6,ANH_88_5,ANH_88_2,ANH_88_3,ANH_88_10}           |
|     284 | arbo       | {1,2,3,4,5,6,7,8,9,10} | {ANH_284_2,ANH_284_1,ANH_284_3,ANH_284_4,ANH_284_5,ANH_284_6,ANH_284_7,ANH_284_8,ANH_284_9,ANH_284_10} |
|     306 | arbo       | {1,2,3,4,5,6,7,8,9,10} | {ANH_306_4,ANH_306_5,ANH_306_6,ANH_306_7,ANH_306_8,ANH_306_9,ANH_306_10,ANH_306_3,ANH_306_2,ANH_306_1} |
|     307 | arbo       | {1,2,3,4,5,6,7,8,9,10} | {ANH_307_2,ANH_307_3,ANH_307_4,ANH_307_5,ANH_307_6,ANH_307_7,ANH_307_8,ANH_307_9,ANH_307_10,ANH_307_1} |
|     308 | arbo       | {1,2,3,4,5,6,7,8,9,10} | {ANH_308_2,ANH_308_3,ANH_308_4,ANH_308_5,ANH_308_6,ANH_308_7,ANH_308_8,ANH_308_9,ANH_308_10,ANH_308_1} |
|     309 | arbo       | {1,2,3,4,5,6,7,8,9,10} | {ANH_309_5,ANH_309_1,ANH_309_2,ANH_309_3,ANH_309_4,ANH_309_6,ANH_309_7,ANH_309_8,ANH_309_9,ANH_309_10} |
|     310 | arbo       | {1,2,3,4,5,6,7,8,9,10} | {ANH_310_9,ANH_310_10,ANH_310_1,ANH_310_2,ANH_310_3,ANH_310_4,ANH_310_5,ANH_310_6,ANH_310_7,ANH_310_8} |
|     312 | arbo       | {1,2,3,4,5,6,7,8,9,10} | {ANH_312_6,ANH_312_8,ANH_312_9,ANH_312_10,ANH_312_1,ANH_312_2,ANH_312_3,ANH_312_4,ANH_312_5,ANH_312_7} |
|     314 | arbo       | {1,2,3,4,5,6,7,8,9,10} | {ANH_314_5,ANH_314_10,ANH_314_9,ANH_314_8,ANH_314_7,ANH_314_1,ANH_314_2,ANH_314_3,ANH_314_4,ANH_314_6} |
|     315 | arbo       | {1,2,3,4,5,6,7,8,9,10} | {ANH_315_8,ANH_315_1,ANH_315_2,ANH_315_3,ANH_315_4,ANH_315_5,ANH_315_6,ANH_315_7,ANH_315_9,ANH_315_10} |
|     316 | arbo       | {1,2,3,4,5,6,7,8,9,10} | {ANH_316_4,ANH_316_5,ANH_316_6,ANH_316_10,ANH_316_9,ANH_316_8,ANH_316_7,ANH_316_1,ANH_316_2,ANH_316_3} |
|     317 | arbo       | {1,2,3,4,5,6,7,8,9,10} | {ANH_317_8,ANH_317_9,ANH_317_10,ANH_317_1,ANH_317_2,ANH_317_3,ANH_317_4,ANH_317_5,ANH_317_6,ANH_317_7} |
|     318 | arbo       | {1,2,3,4,5,6,7,8,9,10} | {ANH_318_2,ANH_318_7,ANH_318_8,ANH_318_5,ANH_318_3,ANH_318_4,ANH_318_1,ANH_318_9,ANH_318_10,ANH_318_6} |
|     319 | arbo       | {1,2,3,4,5,6,7,8,9,10} | {ANH_319_4,ANH_319_1,ANH_319_2,ANH_319_3,ANH_319_5,ANH_319_6,ANH_319_7,ANH_319_8,ANH_319_9,ANH_319_10} |
|     320 | arbo       | {1,2,3,4,5,6,7,8,9,10} | {ANH_320_8,ANH_320_9,ANH_320_10,ANH_320_1,ANH_320_2,ANH_320_3,ANH_320_4,ANH_320_5,ANH_320_6,ANH_320_7} |
|     329 | arbo       | {1,2,3,4,5,6,7,8,9,10} | {ANH_329_5,ANH_329_4,ANH_329_3,ANH_329_2,ANH_329_1,ANH_329_10,ANH_329_9,ANH_329_8,ANH_329_7,ANH_329_6} |
|     331 | arbo       | {1,2,3,4,5,6,7,8,9,10} | {ANH_331_5,ANH_331_7,ANH_331_8,ANH_331_9,ANH_331_10,ANH_331_1,ANH_331_2,ANH_331_3,ANH_331_4,ANH_331_6} |
|     332 | arbo       | {1,2,3,4,5,6,7,8,9,10} | {ANH_332_3,ANH_332_4,ANH_332_5,ANH_332_6,ANH_332_1,ANH_332_7,ANH_332_8,ANH_332_9,ANH_332_10,ANH_332_2} |
|     333 | arbo       | {1,2,3,4,5,6,7,8,9,10} | {ANH_333_3,ANH_333_10,ANH_333_9,ANH_333_8,ANH_333_7,ANH_333_6,ANH_333_5,ANH_333_1,ANH_333_2,ANH_333_4} |
|     334 | arbo       | {1,2,3,4,5,6,7,8,9,10} | {ANH_334_4,ANH_334_5,ANH_334_6,ANH_334_8,ANH_334_9,ANH_334_10,ANH_334_7,ANH_334_1,ANH_334_2,ANH_334_3} |
|     335 | arbo       | {1,2,3,4,5,6,7,8,9,10} | {ANH_335_5,ANH_335_1,ANH_335_2,ANH_335_3,ANH_335_4,ANH_335_6,ANH_335_7,ANH_335_8,ANH_335_9,ANH_335_10} |
|     336 | arbo       | {1,2,3,4,5,6,7,8,9,10} | {ANH_336_1,ANH_336_10,ANH_336_9,ANH_336_8,ANH_336_7,ANH_336_6,ANH_336_5,ANH_336_4,ANH_336_3,ANH_336_2} |
|     338 | arbo       | {1,2,3,4,5,6,7,8,9,10} | {ANH_338_1,ANH_338_10,ANH_338_9,ANH_338_8,ANH_338_7,ANH_338_6,ANH_338_5,ANH_338_4,ANH_338_3,ANH_338_2} |
|     359 | arbo       | {1,2,3,4,5,6,7,8,9,10} | {ANH_359_8,ANH_359_10,ANH_359_1,ANH_359_2,ANH_359_3,ANH_359_4,ANH_359_5,ANH_359_6,ANH_359_7,ANH_359_9} |
|     360 | arbo       | {1,2,3,4,5,6,7,8,9,10} | {ANH_360_10,ANH_360_1,ANH_360_2,ANH_360_3,ANH_360_4,ANH_360_5,ANH_360_6,ANH_360_7,ANH_360_8,ANH_360_9} |
|     376 | arbo       | {1,2,3,4,5,6,7,8,9,10} | {ANH_376_10,ANH_376_1,ANH_376_2,ANH_376_3,ANH_376_4,ANH_376_5,ANH_376_6,ANH_376_7,ANH_376_8,ANH_376_9} |
|     395 | arbo       | {1,2,3,4,5,6,7,8,9,10} | {ANH_395_9,ANH_395_1,ANH_395_2,ANH_395_3,ANH_395_4,ANH_395_5,ANH_395_6,ANH_395_7,ANH_395_8,ANH_395_10} |
|      12 | epnv       | {1}                    | {ANH_12_1_F}                                                                                           |
|      18 | epnv       | {1}                    | {ANH_18_1_F}                                                                                           |
|      88 | epnv       | {10}                   | {ANH_88_10_F}                                                                                          |
|     284 | epnv       | {1}                    | {ANH_284_1_F}                                                                                          |
|     306 | epnv       | {9}                    | {ANH_306_9_F}                                                                                          |
|     307 | epnv       | {1}                    | {ANH_307_1_F}                                                                                          |
|     308 | epnv       | {3}                    | {ANH_308_3_F}                                                                                          |
|     309 | epnv       | {1}                    | {ANH_309_1_F}                                                                                          |
|     310 | epnv       | {1}                    | {ANH_310_1_F}                                                                                          |
|     312 | epnv       | {1}                    | {ANH_312_1_F}                                                                                          |
|     314 | epnv       | {1}                    | {ANH_314_1_F}                                                                                          |
|     315 | epnv       | {6}                    | {ANH_315_6_F}                                                                                          |
|     316 | epnv       | {2}                    | {ANH_316_2_F}                                                                                          |
|     317 | epnv       | {6}                    | {ANH_317_6_F}                                                                                          |
|     318 | epnv       | {2}                    | {ANH_318_2_F}                                                                                          |
|     319 | epnv       | {1}                    | {ANH_319_1_F}                                                                                          |
|     320 | epnv       | {1}                    | {ANH_320_1_F}                                                                                          |
|     329 | epnv       | {1}                    | {ANH_329_1_F}                                                                                          |
|     331 | epnv       | {1}                    | {ANH_331_1_F}                                                                                          |
|     332 | epnv       | {1}                    | {ANH_332_1_F}                                                                                          |
|     333 | epnv       | {6}                    | {ANH_333_6_F}                                                                                          |
|     334 | epnv       | {1}                    | {ANH_334_1_F}                                                                                          |
|     335 | epnv       | {1}                    | {ANH_335_1_F}                                                                                          |
|     336 | epnv       | {6}                    | {ANH_336_6_F}                                                                                          |
|     338 | epnv       | {6}                    | {ANH_338_6_F}                                                                                          |
|     359 | epnv       | {6}                    | {ANH_359_6_F}                                                                                          |
|     360 | epnv       | {6}                    | {ANH_360_6_F}                                                                                          |
|     376 | epnv       | {6}                    | {ANH_376_6_F}                                                                                          |
|     395 | epnv       | {1}                    | {ANH_395_1_F}                                                                                          |
|      12 | epva       | {1}                    | {ANH_12_1_F}                                                                                           |
|      18 | epva       | {1}                    | {ANH_18_1_F}                                                                                           |
|     284 | epva       | {1}                    | {ANH_284_1_F}                                                                                          |
|     307 | epva       | {1}                    | {ANH_307_1_F}                                                                                          |
|     312 | epva       | {1}                    | {ANH_312_1_F}                                                                                          |
|     319 | epva       | {1}                    | {ANH_319_1_F}                                                                                          |
|     320 | epva       | {1}                    | {ANH_320_1_F}                                                                                          |
|     335 | epva       | {1}                    | {ANH_335_1_F}                                                                                          |
|     395 | epva       | {1}                    | {ANH_395_1_F}                                                                                          |

67 records

</div>

## 13.1 ANH

- **utilizar occurrenceID para el eventID puede ser muy confuso cuando
  este juego de datos vaya a pasar a las bases de datos internacionales
  como GBIF, debería ser eventID**

Insertar los datos de anh:

``` sql
INSERT INTO main.punto_referencia(name_pt_ref, num_anh)
WITH a AS(
SELECT
    REGEXP_REPLACE(occurrence_id,'^(ANH_[0-9]{1,3})_([0-9]{1,2})(_F)?$','\1') anh_name,
    REGEXP_REPLACE(occurrence_id,'^ANH_([0-9]{1,3})_([0-9]{1,2})(_F)?$','\1')::int anh_num
FROM raw_dwc.botanica_event
)
SELECT anh_name, anh_num
FROM a
GROUP BY anh_name,anh_num
ORDER BY anh_num
ON CONFLICT (name_pt_ref) DO NOTHING
RETURNING cd_pt_ref, name_pt_ref
;
```

dar las referencias en las tablas de botanica

``` sql
ALTER TABLE raw_dwc.botanica_event ADD COLUMN cd_pt_ref int REFERENCES main.punto_referencia(cd_pt_ref) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE raw_dwc.botanica_registros_arborea ADD COLUMN cd_pt_ref int REFERENCES main.punto_referencia(cd_pt_ref) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE raw_dwc.botanica_registros_epi_vas ADD COLUMN cd_pt_ref int REFERENCES main.punto_referencia(cd_pt_ref) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE raw_dwc.botanica_registros_epi_novas ADD COLUMN cd_pt_ref int REFERENCES main.punto_referencia(cd_pt_ref) ON DELETE SET NULL ON UPDATE CASCADE;

UPDATE raw_dwc.botanica_event
SET cd_pt_ref=pr.cd_pt_ref
FROM main.punto_referencia pr
WHERE REGEXP_REPLACE(occurrence_id, '^(ANH_[0-9]{1,3})_([0-9]{1,2})(_F)?$', '\1') = name_pt_ref
;

UPDATE raw_dwc.botanica_registros_arborea
SET cd_pt_ref=pr.cd_pt_ref
FROM main.punto_referencia pr
WHERE REGEXP_REPLACE(event_id, '^(ANH_[0-9]{1,3})_([0-9]{1,2})(_F)?$', '\1') = name_pt_ref
;

UPDATE raw_dwc.botanica_registros_epi_vas
SET cd_pt_ref=pr.cd_pt_ref
FROM main.punto_referencia pr
WHERE REGEXP_REPLACE(event_id, '^(ANH_[0-9]{1,3})_([0-9]{1,2})(_F)?$', '\1') = name_pt_ref
;

UPDATE raw_dwc.botanica_registros_epi_novas
SET cd_pt_ref=pr.cd_pt_ref
FROM main.punto_referencia pr
WHERE REGEXP_REPLACE(event_id, '^(ANH_[0-9]{1,3})_([0-9]{1,2})(_F)?$', '\1') = name_pt_ref
;


SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

Averiguando que ninguna fila no tenga anh

``` sql
SELECT occurrence_id FROM raw_dwc.botanica_event WHERE cd_pt_ref IS NULL;
```

<div class="knitsql-table">

occurrence_id —————

: 0 records

</div>

``` sql
SELECT occurrence_id,event_id FROM raw_dwc.botanica_registros_arborea WHERE cd_pt_ref IS NULL;
```

<div class="knitsql-table">

occurrence_id event_id ————— ———-

: 0 records

</div>

``` sql
SELECT occurrence_id,event_id FROM raw_dwc.botanica_registros_epi_vas WHERE cd_pt_ref IS NULL;
```

<div class="knitsql-table">

occurrence_id event_id ————— ———-

: 0 records

</div>

``` sql
SELECT occurrence_id,event_id FROM raw_dwc.botanica_registros_epi_novas WHERE cd_pt_ref IS NULL;
```

<div class="knitsql-table">

occurrence_id event_id ————— ———-

: 0 records

</div>

## 13.2 Unit, sampling efforts definition, abundance definition, protocolo

``` sql
INSERT INTO main.def_protocol(protocol,protocol_spa,cd_var_samp_eff_1,cd_var_samp_eff_2,samp_eff_1_implicit,samp_eff_2_implicit,cd_var_ind_qt,description_spa, description)
VALUES(
  'Tree systematic transect (DBH>5cm)',
  'Transecto sistemático de arbóles (DAP>5cm)',
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Covered distance'),
  NULL,
  false,
  NULL,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind='Number of individuals'),
  NULL,
  'Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press, adapted to 5cm DBH'
),(
  'Systematic transect for vascular epiphytes (<2m high)',
  'Transecto sistemático para epifitas vasculares (<2m altura)',
  (SELECT cd_var_samp_eff FROM main.def_var_samp_eff WHERE var_samp_eff='Covered distance'),
  NULL,
  false,
  NULL,
  (SELECT cd_var_ind_qt FROM main.def_var_ind_qt WHERE var_qt_ind='Cover (%)'),
  NULL,
  NULL
)
RETURNING cd_protocol,protocol,protocol_spa;
```

## 13.3 Personas

``` sql
INSERT INTO main.people(verbatim_person)
WITH a AS(
SELECT DISTINCT INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(recorded_by, ' | ')))) AS name_person
FROM raw_dwc.botanica_registros_arborea
UNION
SELECT DISTINCT INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(identified_by, ' | '))))
FROM raw_dwc.botanica_registros_arborea
UNION
SELECT DISTINCT INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(recorded_by, ' | ')))) AS name_person
FROM raw_dwc.botanica_registros_epi_vas
UNION
SELECT DISTINCT INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(identified_by, ' | '))))
FROM raw_dwc.botanica_registros_epi_vas
UNION
SELECT DISTINCT INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(recorded_by, ' | ')))) AS name_person
FROM raw_dwc.botanica_registros_epi_novas
UNION
SELECT DISTINCT INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(identified_by, ' | '))))
FROM raw_dwc.botanica_registros_epi_novas
)
SELECT DISTINCT REGEXP_REPLACE(name_person, '- ','-')
FROM a
ORDER BY REGEXP_REPLACE(name_person, '- ','-')
ON CONFLICT(verbatim_person) DO NOTHING
RETURNING cd_person, verbatim_person
```

Dar los codigos a las tables de origen:

``` sql
ALTER TABLE raw_dwc.botanica_registros_arborea ADD COLUMN cds_recorded_by int[];
ALTER TABLE raw_dwc.botanica_registros_epi_vas ADD COLUMN cds_recorded_by int[];
ALTER TABLE raw_dwc.botanica_registros_epi_novas ADD COLUMN cds_recorded_by int[];
ALTER TABLE raw_dwc.botanica_registros_arborea ADD COLUMN cds_identified_by int[];
ALTER TABLE raw_dwc.botanica_registros_epi_vas ADD COLUMN cds_identified_by int[];
ALTER TABLE raw_dwc.botanica_registros_epi_novas ADD COLUMN cds_identified_by int[];

WITH a AS(
SELECT "row.names", REGEXP_REPLACE(INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(recorded_by, ' | ')))),'- ','-') AS name_person
FROM raw_dwc.botanica_registros_arborea
),b AS(
SELECT "row.names", ARRAY_AGG(cd_person) cds
FROM a
LEFT JOIN main.people p ON a.name_person=p.verbatim_person
GROUP BY "row.names"
)
UPDATE raw_dwc.botanica_registros_arborea AS r
SET cds_recorded_by=b.cds
FROM b
WHERE r."row.names"=b."row.names"
RETURNING r."row.names", cds_recorded_by
;

WITH a AS(
SELECT "row.names", REGEXP_REPLACE(INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(identified_by, ' | ')))),'- ','-') AS name_person
FROM raw_dwc.botanica_registros_arborea
),b AS(
SELECT "row.names", ARRAY_AGG(cd_person) cds
FROM a
LEFT JOIN main.people p ON a.name_person=p.verbatim_person
GROUP BY "row.names"
)
UPDATE raw_dwc.botanica_registros_arborea AS r
SET cds_identified_by=b.cds
FROM b
WHERE r."row.names"=b."row.names"
RETURNING r."row.names", cds_identified_by
;

-----------

WITH a AS(
SELECT "row.names", REGEXP_REPLACE(INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(recorded_by, ' | ')))),'- ','-') AS name_person
FROM raw_dwc.botanica_registros_epi_vas
),b AS(
SELECT "row.names", ARRAY_AGG(cd_person) cds
FROM a
LEFT JOIN main.people p ON a.name_person=p.verbatim_person
GROUP BY "row.names"
)
UPDATE raw_dwc.botanica_registros_epi_vas AS r
SET cds_recorded_by=b.cds
FROM b
WHERE r."row.names"=b."row.names"
RETURNING r."row.names", cds_recorded_by
;

WITH a AS(
SELECT "row.names", REGEXP_REPLACE(INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(identified_by, ' | ')))),'- ','-') AS name_person
FROM raw_dwc.botanica_registros_epi_vas
),b AS(
SELECT "row.names", ARRAY_AGG(cd_person) cds
FROM a
LEFT JOIN main.people p ON a.name_person=p.verbatim_person
GROUP BY "row.names"
)
UPDATE raw_dwc.botanica_registros_epi_vas AS r
SET cds_identified_by=b.cds
FROM b
WHERE r."row.names"=b."row.names"
RETURNING r."row.names", cds_identified_by
;

-------------

WITH a AS(
SELECT "row.names", REGEXP_REPLACE(INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(recorded_by, ' | ')))),'- ','-') AS name_person
FROM raw_dwc.botanica_registros_epi_novas
),b AS(
SELECT "row.names", ARRAY_AGG(cd_person) cds
FROM a
LEFT JOIN main.people p ON a.name_person=p.verbatim_person
GROUP BY "row.names"
)
UPDATE raw_dwc.botanica_registros_epi_novas AS r
SET cds_recorded_by=b.cds
FROM b
WHERE r."row.names"=b."row.names"
RETURNING r."row.names", cds_recorded_by
;


WITH a AS(
SELECT "row.names", REGEXP_REPLACE(INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(identified_by, ' | ')))),'- ','-') AS name_person
FROM raw_dwc.botanica_registros_epi_novas
),b AS(
SELECT "row.names", ARRAY_AGG(cd_person) cds
FROM a
LEFT JOIN main.people p ON a.name_person=p.verbatim_person
GROUP BY "row.names"
)
UPDATE raw_dwc.botanica_registros_epi_novas AS r
SET cds_identified_by=b.cds
FROM b
WHERE r."row.names"=b."row.names"
RETURNING r."row.names", cds_identified_by
;


SELECT 1;
```

<div class="knitsql-table">

| ?column? |
|---------:|
|        1 |

1 records

</div>

## 13.4 gp_event

``` sql
INSERT INTO main.gp_event(cd_pt_ref,cd_gp_biol,cd_protocol,campaign_nb)
WITH a AS(
SELECT e.occurrence_id,
    REGEXP_REPLACE(e.occurrence_id,'^ANH_([0-9]{1,3})_([0-9]{1,2})(_F)?$','\1')::int anh_num,
    REGEXP_REPLACE(e.occurrence_id,'^ANH_([0-9]{1,3})_([0-9]{1,2})(_F)?$','\2')::int repli,
    CASE
        WHEN e.sampling_protocol='Muestreo de comunidades de hierbas para estimar coberturas en cuadrantes de un metro cuadrado' THEN ARRAY[NULL]
        WHEN e.sampling_protocol='Muestreo de flora epifita no vascular sugerido por la ANLA para solicitudes de licenciamiento ambiental.' THEN 
            CASE
                WHEN e.occurrence_id IN ('ANH_12_1_F','ANH_18_1_F','ANH_284_1_F','ANH_307_1_F','ANH_308_1_F','ANH_312_1_F','ANH_319_1_F','ANH_320_1_F','ANH_335_1_F','ANH_395_1_F') THEN ARRAY['epva','epnv']
                ELSE ARRAY['epnv']
            END
        WHEN e.sampling_protocol='Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm' THEN ARRAY['arbo']
    END cds_gp_biol
FROM raw_dwc.botanica_event e
), unnest_biol AS(
SELECT occurrence_id event_id_old, anh_num, repli repli_old, UNNEST(cds_gp_biol) cd_gp_biol
FROM a
)
SELECT DISTINCT pr.cd_pt_ref, cd_gp_biol,
    CASE
        WHEN cd_gp_biol = 'arbo' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol = 'Tree systematic transect (DBH>5cm)')
        WHEN cd_gp_biol = 'epva' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol = 'Systematic transect for vascular epiphytes (<2m high)')
        WHEN cd_gp_biol = 'epnv' THEN (SELECT cd_protocol FROM main.def_protocol WHERE protocol = 'Sampling quadrats')
    END cd_protocol,
    1 AS campaign_nb
FROM unnest_biol ub
LEFT JOIN main.punto_referencia pr ON ub.anh_num=pr.num_anh
WHERE cd_gp_biol IS NOT NULL
ORDER BY cd_gp_biol, cd_pt_ref;
```

``` sql
ALTER TABLE raw_dwc.botanica_event ADD COLUMN cd_gp_event int REFERENCES main.gp_event(cd_gp_event) ON DELETE SET NULL;
ALTER TABLE raw_dwc.botanica_event ADD COLUMN cds_gp_event int[];

WITH a AS(
SELECT "row.names",e.occurrence_id,
    REGEXP_REPLACE(e.occurrence_id,'^ANH_([0-9]{1,3})_([0-9]{1,2})(_F)?$','\1')::int anh_num,
    REGEXP_REPLACE(e.occurrence_id,'^ANH_([0-9]{1,3})_([0-9]{1,2})(_F)?$','\2')::int repli,
    CASE
        WHEN e.sampling_protocol='Muestreo de comunidades de hierbas para estimar coberturas en cuadrantes de un metro cuadrado' THEN ARRAY[NULL]
        WHEN e.sampling_protocol='Muestreo de flora epifita no vascular sugerido por la ANLA para solicitudes de licenciamiento ambiental.' THEN 
            CASE
                WHEN e.occurrence_id IN ('ANH_12_1_F','ANH_18_1_F','ANH_284_1_F','ANH_307_1_F','ANH_308_1_F','ANH_312_1_F','ANH_319_1_F','ANH_320_1_F','ANH_335_1_F','ANH_395_1_F') THEN ARRAY['epva','epnv']
                ELSE ARRAY['epnv']
            END
        WHEN e.sampling_protocol='Transecto de inventario de flora arbórea (Oliver et al. 2002, Global Patterns of Plant Diversity: Alwyn H. Gentry Forest Transec Data Set, Missouri Botanical Garden Press) ajustado a DAP mínimo de 5 cm' THEN ARRAY['arbo']
    END cds_gp_biol
FROM raw_dwc.botanica_event e
), unnest_biol AS(
SELECT "row.names",occurrence_id event_id_old, anh_num, repli repli_old, UNNEST(cds_gp_biol) cd_gp_biol
FROM a
), b AS(
SELECT ub."row.names", ARRAY_AGG(cd_gp_biol ORDER BY cd_gp_biol) ,ARRAY_AGG(cd_gp_event ORDER BY cd_gp_biol) cds_gp_event, SUM(cd_gp_event) FILTER (WHERE cd_gp_biol<>'epva') cd_gp_event
FROM unnest_biol ub
LEFT JOIN main.punto_referencia pr ON ub.anh_num=pr.num_anh
LEFT JOIN main.gp_event USING (cd_gp_biol,cd_pt_ref)
GROUP BY ub."row.names"
ORDER BY ub."row.names"::int
)
UPDATE raw_dwc.botanica_event e
SET cd_gp_event=b.cd_gp_event, cds_gp_event=b.cds_gp_event
FROM b
WHERE e."row.names"=b."row.names"
RETURNING e.occurrence_id, e.cd_gp_event
;
```

<div class="knitsql-table">

| occurrence_id | cd_gp_event |
|:--------------|------------:|
| ANH_12_1_F    |        2197 |
| ANH_12_1      |        2168 |
| ANH_12_2      |        2168 |
| ANH_12_3      |        2168 |
| ANH_12_4      |        2168 |
| ANH_12_5      |        2168 |
| ANH_12_6      |        2168 |
| ANH_12_7      |        2168 |
| ANH_12_8      |        2168 |
| ANH_12_9      |        2168 |
| ANH_12_10     |        2168 |
| ANH_18_1_F    |        2198 |
| ANH_18_1      |        2169 |
| ANH_18_2      |        2169 |
| ANH_18_3      |        2169 |
| ANH_18_4      |        2169 |
| ANH_18_5      |        2169 |
| ANH_18_6      |        2169 |
| ANH_18_7      |        2169 |
| ANH_18_8      |        2169 |
| ANH_18_9      |        2169 |
| ANH_18_10     |        2169 |
| ANH_284_1_F   |        2199 |
| ANH_284_1     |        2170 |
| ANH_284_2     |        2170 |
| ANH_284_3     |        2170 |
| ANH_284_4     |        2170 |
| ANH_284_5     |        2170 |
| ANH_284_6     |        2170 |
| ANH_284_7     |        2170 |
| ANH_284_8     |        2170 |
| ANH_284_9     |        2170 |
| ANH_284_10    |        2170 |
| ANH_306_9_F   |        2193 |
| ANH_306_1     |        2164 |
| ANH_306_2     |        2164 |
| ANH_306_3     |        2164 |
| ANH_306_4     |        2164 |
| ANH_306_5     |        2164 |
| ANH_306_6     |        2164 |
| ANH_306_7     |        2164 |
| ANH_306_8     |        2164 |
| ANH_306_9     |        2164 |
| ANH_306_10    |        2164 |
| ANH_307_1_F   |        2204 |
| ANH_307_1     |        2175 |
| ANH_307_2     |        2175 |
| ANH_307_3     |        2175 |
| ANH_307_4     |        2175 |
| ANH_307_5     |        2175 |
| ANH_307_6     |        2175 |
| ANH_307_7     |        2175 |
| ANH_307_8     |        2175 |
| ANH_307_9     |        2175 |
| ANH_307_10    |        2175 |
| ANH_308_1     |        2176 |
| ANH_308_2     |        2176 |
| ANH_308_3     |        2176 |
| ANH_308_4     |        2176 |
| ANH_308_5     |        2176 |
| ANH_308_6     |        2176 |
| ANH_308_7     |        2176 |
| ANH_308_8     |        2176 |
| ANH_308_9     |        2176 |
| ANH_308_10    |        2176 |
| ANH_308_3_F   |        2205 |
| ANH_309_1_F   |        2206 |
| ANH_309_1     |        2177 |
| ANH_309_2     |        2177 |
| ANH_309_3     |        2177 |
| ANH_309_4     |        2177 |
| ANH_309_5     |        2177 |
| ANH_309_6     |        2177 |
| ANH_309_7     |        2177 |
| ANH_309_8     |        2177 |
| ANH_309_9     |        2177 |
| ANH_309_10    |        2177 |
| ANH_310_1_F   |        2207 |
| ANH_310_1     |        2178 |
| ANH_310_2     |        2178 |
| ANH_310_3     |        2178 |
| ANH_310_4     |        2178 |
| ANH_310_5     |        2178 |
| ANH_310_6     |        2178 |
| ANH_310_7     |        2178 |
| ANH_310_8     |        2178 |
| ANH_310_9     |        2178 |
| ANH_310_10    |        2178 |
| ANH_312_1_F   |        2208 |
| ANH_312_1     |        2179 |
| ANH_312_2     |        2179 |
| ANH_312_3     |        2179 |
| ANH_312_4     |        2179 |
| ANH_312_5     |        2179 |
| ANH_312_6     |        2179 |
| ANH_312_7     |        2179 |
| ANH_312_8     |        2179 |
| ANH_312_9     |        2179 |
| ANH_312_10    |        2179 |
| ANH_314_1_F   |        2209 |

Displaying records 1 - 100

</div>

## 13.5 event

Vamos a crear nuevos eventos que corresponden a un quadrat (una malla)
Para eso debemos mezclar las pestañas de eventos y de registros en el
caso de las epifitas no-vasculares.

**Etapa 1**: Averiguar que cada fila de los archivos de registros
corresponden a una fila del archivo de eventos, y que esos recibieron al
menos un cd_gp_event

``` sql
--Arboles
SELECT a."row.names", ARRAY_AGG(e."row.names") row_names_event, ARRAY_AGG(e.cd_gp_event) cd_gp_event
FROM raw_dwc.botanica_registros_arborea a
LEFT JOIN raw_dwc.botanica_event e ON e.occurrence_id=a.event_id
GROUP BY a."row.names"
HAVING ARRAY_LENGTH(ARRAY_AGG(e."row.names"),1)<>1 OR  ARRAY_LENGTH(ARRAY_AGG(e.cd_gp_event),1)<>1
ORDER BY a."row.names"::int;

--Epifitas no-vasculares
SELECT a."row.names", ARRAY_AGG(e."row.names") row_names_event, ARRAY_AGG(e.cd_gp_event) cd_gp_event
FROM raw_dwc.botanica_registros_epi_novas a
LEFT JOIN raw_dwc.botanica_event e ON e.occurrence_id=a.event_id
GROUP BY a."row.names"
HAVING ARRAY_LENGTH(ARRAY_AGG(e."row.names"),1)<>1 OR  ARRAY_LENGTH(ARRAY_AGG(e.cd_gp_event),1)<>1
ORDER BY a."row.names"::int;

-- Epifitas vasculares
WITH unnest_gps_event AS(
SELECT "row.names",occurrence_id,UNNEST(cds_gp_event) cd_gp_event
FROM raw_dwc.botanica_event
)
SELECT a."row.names", ARRAY_AGG(e."row.names") row_names_event, ARRAY_AGG(e.cd_gp_event) cd_gp_event
FROM raw_dwc.botanica_registros_epi_vas a
LEFT JOIN unnest_gps_event e ON e.occurrence_id=a.event_id
GROUP BY a."row.names"
HAVING ARRAY_LENGTH(ARRAY_AGG(DISTINCT e."row.names"),1)<>1 
ORDER BY a."row.names"::int;
```

<div class="knitsql-table">

row.names row_names_event cd_gp_event ———– —————– ————-

: 0 records

</div>

### 13.5.1 Eventos de arboles

``` sql
INSERT INTO main.event(cd_gp_event,event_id,num_replicate, description_replicate, date_time_begin, date_time_end, locality_verb, event_remarks, samp_effort_1, samp_effort_2, pt_geom)
SELECT cd_gp_event,
  'arbo_'||occurrence_id,
  REGEXP_REPLACE(occurrence_id,'^ANH_[0-9]{1,3}_([0-9]{1,3})$','\1')::int num_replicate,
  'transect:'||REGEXP_REPLACE(occurrence_id,'^ANH_[0-9]{1,3}_([0-9]{1,3})$','\1') description_replicate,
  NULL AS date_time_begin,
  NULL AS date_time_end,
  locality locality_verb,
  event_remarks,
  50 as samp_effort_1,
  NULL AS samp_effort_2,
  ST_SetSRID(ST_Transform(ST_SetSRID(ST_MakePoint(decimal_longitude::double precision,decimal_latitude::double precision),4326),(SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)),3116) pt_geom
FROM raw_dwc.botanica_event
LEFT JOIN main.gp_event ge USING (cd_gp_event)
WHERE cd_gp_biol='arbo'
RETURNING main.event.cd_event, main.event.cd_gp_event, main.event.event_id, main.event.num_replicate, main.event.description_replicate, main.event.date_time_begin, main.event.date_time_end, main.event.locality_verb, main.event.event_remarks, main.event.pt_geom
;
```

Damos los cd_event a todos las filas:

``` sql
ALTER TABLE raw_dwc.botanica_event ADD COLUMN cd_event int REFERENCES main.event(cd_event) ON DELETE SET NULL;
ALTER TABLE raw_dwc.botanica_registros_arborea ADD COLUMN cd_event int REFERENCES main.event(cd_event);

UPDATE raw_dwc.botanica_event AS t
SET cd_event=e.cd_event
FROM main.event e
WHERE 'arbo_'||t.occurrence_id=e.event_id;

UPDATE raw_dwc.botanica_registros_arborea AS t
SET cd_event=e.cd_event
FROM main.event e
WHERE 'arbo_'||t.event_id=e.event_id;

SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

### 13.5.2 Eventos de epifitas no-vasculares

``` sql
INSERT INTO main.event(cd_gp_event,event_id,num_replicate, description_replicate, date_time_begin, date_time_end, locality_verb, event_remarks, samp_effort_1, samp_effort_2, pt_geom)
WITH a AS(
SELECT DISTINCT cd_gp_event,
  be.occurrence_id,
  REGEXP_REPLACE(bren.organism_remarks,'^Número de forofito ([0-9]{1,2})_([0-9])$','\1')::int forofito,
  REGEXP_REPLACE(bren.organism_remarks,'^Número de forofito ([0-9]{1,2})_([0-9])$','\2')::int malla,
  REGEXP_REPLACE(be.occurrence_id,'^ANH_[0-9]{1,3}_([0-9]{1,3})_F$','\1')::int transect,
  NULL::timestamp AS date_time_begin,
  NULL::timestamp AS date_time_end,
  locality locality_verb,
  NULL AS event_remarks,
  0.0625 as samp_effort_1,
  1 AS samp_effort_2,
  ST_SetSRID(ST_Transform(ST_SetSRID(ST_MakePoint(decimal_longitude::double precision,decimal_latitude::double precision),4326),(SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)),3116) pt_geom
FROM raw_dwc.botanica_event be
LEFT JOIN main.gp_event ge USING (cd_gp_event)
LEFT JOIN raw_dwc.botanica_registros_epi_novas bren ON be.occurrence_id=bren.event_id
WHERE cd_gp_biol='epnv' AND bren.organism_remarks ~ '^Número de forofito [0-9]{1,2}_[0-9]$'
)
SELECT cd_gp_event, 
    occurrence_id || forofito || '_' || malla event_id,
    ROW_NUMBER() OVER (PARTITION BY occurrence_id ORDER BY forofito,malla) num_replicate,
    'transect:'||transect||'|phorophyte:'||forofito||'|quadrat:'||malla description_replicate,
    date_time_begin,
    date_time_end,
    locality_verb,
    event_remarks,
    samp_effort_1,
    samp_effort_2,
    pt_geom
FROM a
RETURNING main.event.cd_event, main.event.cd_gp_event, main.event.event_id, main.event.num_replicate, main.event.description_replicate, main.event.date_time_begin, main.event.date_time_end, main.event.locality_verb, main.event.event_remarks, main.event.pt_geom
;
```

Damos los cd_event a todos las filas:

``` sql
ALTER TABLE raw_dwc.botanica_event ADD COLUMN cds_event_epnv int[];
ALTER TABLE raw_dwc.botanica_registros_epi_novas ADD COLUMN cd_event int REFERENCES main.event(cd_event);

WITH a AS(
SELECT be."row.names", be.occurrence_id, ARRAY_AGG(e.event_id) event_ids, ARRAY_AGG(e.cd_event) cds_event_epnv
FROM main.event e
LEFT JOIN main.gp_event ge USING (cd_gp_event)
LEFT JOIN raw_dwc.botanica_event be ON e.cd_gp_event=be.cd_gp_event AND REGEXP_REPLACE(e.event_id,'^(ANH_[0-9]{1,3}_[0-9]{1,2}_F)[0-9]{1,2}_[0-9]$','\1')=be.occurrence_id
WHERE cd_gp_biol='epnv'
GROUP BY be."row.names", be.occurrence_id
)
UPDATE raw_dwc.botanica_event AS t
SET cds_event_epnv=a.cds_event_epnv
FROM a
WHERE t."row.names"=a."row.names";

WITH a AS(
SELECT bren."row.names",bren.event_id old_event_id,
  REGEXP_REPLACE(bren.organism_remarks,'^Número de forofito ([0-9]{1,2})_([0-9])$','\1')::int forofito,
  REGEXP_REPLACE(bren.organism_remarks,'^Número de forofito ([0-9]{1,2})_([0-9])$','\2')::int malla
FROM raw_dwc.botanica_registros_epi_novas bren
WHERE bren.organism_remarks ~ '^Número de forofito ([0-9]{1,2})_([0-9])$'
),b AS(
SELECT cd_event,event_id
FROM main.event
LEFT JOIN main.gp_event USING(cd_gp_event)
WHERE cd_gp_biol='epnv'
),c AS(
SELECT *
FROM a
LEFT JOIN b ON
    REGEXP_REPLACE(b.event_id,'^(ANH_[0-9]{1,3}_[0-9]{1,2}_F)[0-9]{1,2}_[0-9]$','\1')=a.old_event_id AND
    REGEXP_REPLACE(b.event_id,'^(ANH_[0-9]{1,3}_[0-9]{1,2}_F)([0-9]{1,2})_[0-9]$','\2')::int=a.forofito  AND
    REGEXP_REPLACE(b.event_id,'^(ANH_[0-9]{1,3}_[0-9]{1,2}_F)([0-9]{1,2})_([0-9])$','\3')::int=a.malla
)
UPDATE raw_dwc.botanica_registros_epi_novas AS t
SET cd_event=c.cd_event
FROM c
WHERE c."row.names"=t."row.names";

SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

### 13.5.3 Epifitas vasculares

``` sql
INSERT INTO main.event(cd_gp_event,event_id,num_replicate, description_replicate, date_time_begin, date_time_end, locality_verb, event_remarks, samp_effort_1, samp_effort_2, pt_geom)
SELECT ge.cd_gp_event,
  'epva_'||REGEXP_REPLACE(occurrence_id,'^(ANH_[0-9]{1,3}_[0-9]{1,3})_F','\1') event_id,
  1::int AS num_replicate,
  'transect:'||REGEXP_REPLACE(occurrence_id,'^ANH_[0-9]{1,3}_([0-9]{1,3})_F$','\1') description_replicate,
  NULL AS date_time_begin,
  NULL AS date_time_end,
  locality locality_verb,
  NULL event_remarks,
  50 as samp_effort_1,
  NULL AS samp_effort_2,
  ST_SetSRID(ST_Transform(ST_SetSRID(ST_MakePoint(decimal_longitude::double precision,decimal_latitude::double precision),4326),(SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)),3116) pt_geom
FROM raw_dwc.botanica_event be
LEFT JOIN main.gp_event ge ON ARRAY[ge.cd_gp_event] <@ be.cds_gp_event
WHERE cd_gp_biol='epva'
RETURNING main.event.cd_event, main.event.cd_gp_event, main.event.event_id, main.event.num_replicate, main.event.description_replicate, main.event.date_time_begin, main.event.date_time_end, main.event.locality_verb, main.event.event_remarks, main.event.pt_geom
;
```

Damos los cd_event a todos las filas:

``` sql
ALTER TABLE raw_dwc.botanica_registros_epi_vas ADD COLUMN cd_event int REFERENCES main.event(cd_event);

UPDATE raw_dwc.botanica_event AS t
SET cd_event=e.cd_event
FROM main.event e
WHERE 'epva_'||REGEXP_REPLACE(t.occurrence_id,'^(ANH_[0-9]{1,3}_[0-9]{1,3})_F','\1')=e.event_id;

UPDATE raw_dwc.botanica_registros_epi_vas AS t
SET cd_event=e.cd_event
FROM main.event e
WHERE 'epva_'||REGEXP_REPLACE(t.event_id,'^(ANH_[0-9]{1,3}_[0-9]{1,3})_F','\1')=e.event_id;

SELECT true;
```

<div class="knitsql-table">

| bool |
|:-----|
| TRUE |

1 records

</div>

### 13.5.4 Añadir las fechas (sin horas) en la tabla event_extra

``` sql
INSERT INTO main.event_extra(cd_event,cd_var_event_extra,value_text)
WITH a AS(
SELECT "row.names",UNNEST(ARRAY_CAT(ARRAY[cd_event],cds_event_epnv)) cd_event,event_date::date
FROM raw_dwc.botanica_event
)
SELECT cd_event,
    (SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin'),
    event_date::text
FROM a
WHERE cd_event IS NOT NULL;
```

## 13.6 registros

### 13.6.1 Arboles

``` sql
SELECT occurrence_id, count(*)
FROM raw_dwc.botanica_registros_arborea
GROUP BY occurrence_id
HAVING count(*)>1;
```

<div class="knitsql-table">

occurrence_id count ————— ——-

: 0 records

</div>

``` sql
SELECT e.occurrence_id, e.event_date-- r.event_date, e.event_time, r.event_time
FROM raw_dwc.botanica_registros_arborea r
LEFT JOIN raw_dwc.botanica_event e USING(cd_event)
--ORDER BY r.event_date::date, r.event_time::time
```

<div class="knitsql-table">

| occurrence_id | event_date |
|:--------------|:-----------|
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| ANH_12_2      | 2021-08-06 |
| ANH_12_2      | 2021-08-06 |
| ANH_12_2      | 2021-08-06 |
| ANH_12_2      | 2021-08-06 |
| ANH_12_2      | 2021-08-06 |
| ANH_12_2      | 2021-08-06 |
| ANH_12_2      | 2021-08-06 |
| ANH_12_2      | 2021-08-06 |
| ANH_12_3      | 2021-08-06 |
| ANH_12_3      | 2021-08-06 |
| ANH_12_3      | 2021-08-06 |
| ANH_12_3      | 2021-08-06 |
| ANH_12_3      | 2021-08-06 |
| ANH_12_3      | 2021-08-06 |
| ANH_12_3      | 2021-08-06 |
| ANH_12_3      | 2021-08-06 |
| ANH_12_3      | 2021-08-06 |
| ANH_12_3      | 2021-08-06 |
| ANH_12_3      | 2021-08-06 |
| ANH_12_3      | 2021-08-06 |
| ANH_12_4      | 2021-08-06 |
| ANH_12_4      | 2021-08-06 |
| ANH_12_4      | 2021-08-06 |
| ANH_12_4      | 2021-08-06 |
| ANH_12_5      | 2021-08-06 |
| ANH_12_5      | 2021-08-06 |
| ANH_12_5      | 2021-08-06 |
| ANH_12_5      | 2021-08-06 |
| ANH_12_5      | 2021-08-06 |
| ANH_12_5      | 2021-08-06 |
| ANH_12_6      | 2021-08-06 |
| ANH_12_6      | 2021-08-06 |
| ANH_12_6      | 2021-08-06 |
| ANH_12_6      | 2021-08-06 |
| ANH_12_6      | 2021-08-06 |
| ANH_12_6      | 2021-08-06 |
| ANH_12_6      | 2021-08-06 |
| ANH_12_6      | 2021-08-06 |
| ANH_12_6      | 2021-08-06 |
| ANH_12_6      | 2021-08-06 |
| ANH_12_6      | 2021-08-06 |
| ANH_12_7      | 2021-08-06 |
| ANH_12_7      | 2021-08-06 |
| ANH_12_7      | 2021-08-06 |
| ANH_12_7      | 2021-08-06 |
| ANH_12_7      | 2021-08-06 |
| ANH_12_7      | 2021-08-06 |
| ANH_12_7      | 2021-08-06 |
| ANH_12_7      | 2021-08-06 |
| ANH_12_7      | 2021-08-06 |
| ANH_12_7      | 2021-08-06 |
| ANH_12_7      | 2021-08-06 |
| ANH_12_7      | 2021-08-06 |
| ANH_12_7      | 2021-08-06 |
| ANH_12_7      | 2021-08-06 |
| ANH_12_8      | 2021-08-06 |
| ANH_12_8      | 2021-08-06 |
| ANH_12_8      | 2021-08-06 |
| ANH_12_8      | 2021-08-06 |
| ANH_12_8      | 2021-08-06 |
| ANH_12_8      | 2021-08-06 |
| ANH_12_8      | 2021-08-06 |
| ANH_12_8      | 2021-08-06 |
| ANH_12_8      | 2021-08-06 |
| ANH_12_8      | 2021-08-06 |
| ANH_12_8      | 2021-08-06 |
| ANH_12_8      | 2021-08-06 |
| ANH_12_8      | 2021-08-06 |
| ANH_12_8      | 2021-08-06 |
| ANH_12_8      | 2021-08-06 |
| ANH_12_8      | 2021-08-06 |
| ANH_12_8      | 2021-08-06 |
| ANH_12_8      | 2021-08-06 |
| ANH_12_8      | 2021-08-06 |
| ANH_12_9      | 2021-08-06 |
| ANH_12_9      | 2021-08-06 |
| ANH_12_9      | 2021-08-06 |
| ANH_12_9      | 2021-08-06 |
| ANH_12_9      | 2021-08-06 |
| ANH_12_9      | 2021-08-06 |
| ANH_12_9      | 2021-08-06 |
| ANH_12_9      | 2021-08-06 |
| ANH_12_9      | 2021-08-06 |
| ANH_12_9      | 2021-08-06 |
| ANH_12_9      | 2021-08-06 |
| ANH_12_9      | 2021-08-06 |
| ANH_12_9      | 2021-08-06 |
| ANH_12_9      | 2021-08-06 |

Displaying records 1 - 100

</div>

``` sql
INSERT INTO main.registros(cd_event, cds_recorded_by, date_time, cd_tax, cd_morfo, date_ident, cds_identified_by, qt_int,remarks, occurrence_id, organism_id)
SELECT
 cd_event,
 cds_recorded_by,
 NULL date_time,
 tt.cd_tax,
 tt.cd_morfo,
 TO_DATE(date_identified,'YYYY-MM-DD') date_ident,
 cds_identified_by,
 organism_quantity::int qt_int,
 CASE
    WHEN r.occurrence_remarks ='' THEN NULL
    ELSE r.occurrence_remarks
 END remarks,
 r.occurrence_id,
 SPLIT_PART(occurrence_id,':',7) organism_id
 --ROW_NUMBER() OVER (ORDER BY (e.date_time_begin::date||' '||event_time)::timestamp)
 --NULL AS organism_id,
 -- organism_id::text
 --ST_SetSRID(ST_Transform(ST_SetSRID(ST_MakePoint(measurement_value__longitud_,measurement_value__latitud_), 4326),  (SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)),3116)
FROM raw_dwc.botanica_registros_arborea r
LEFT JOIN raw_dwc.taxonomy_total tt ON tt."row.names"=r."row.names" AND tt.table_orig='botanica_registros_arborea'
LEFT JOIN main.event e USING (cd_event)
ORDER BY e.event_id
RETURNING cd_event, cds_recorded_by, date_time, cd_tax, cd_morfo, cds_identified_by, qt_int,remarks, occurrence_id, organism_id
```

``` sql
ALTER TABLE raw_dwc.botanica_registros_arborea ADD COLUMN cd_reg int REFERENCES main.registros(cd_reg);
UPDATE raw_dwc.botanica_registros_arborea AS ar
SET cd_reg=r.cd_reg
FROM main.registros r
WHERE ar.cd_event=r.cd_event AND ar.occurrence_id=r.occurrence_id;

-- Check cd_reg are unique in the source table
SELECT cd_reg,count(*) FROM  raw_dwc.botanica_registros_arborea GROUP BY cd_reg HAVING count(*)>1;
```

<div class="knitsql-table">

    cd_reg   count

------------------------------------------------------------------------

: 0 records

</div>

### 13.6.2 Registros epifitas vasculares

``` sql
SELECT occurrence_id, count(*)
FROM raw_dwc.botanica_registros_epi_vas
GROUP BY occurrence_id
HAVING count(*)>1;
```

<div class="knitsql-table">

occurrence_id count ————— ——-

: 0 records

</div>

``` sql
SELECT e.occurrence_id, e.event_date-- r.event_date, e.event_time, r.event_time
FROM raw_dwc.botanica_registros_epi_vas r
LEFT JOIN raw_dwc.botanica_event e USING(cd_event)
```

<div class="knitsql-table">

| occurrence_id | event_date |
|:--------------|:-----------|
| ANH_12_1_F    | 2021-08-06 |
| ANH_12_1_F    | 2021-08-06 |
| ANH_12_1      | 2021-08-06 |
| ANH_12_1      | 2021-08-06 |
| ANH_18_1_F    | 2021-08-04 |
| ANH_18_1_F    | 2021-08-04 |
| ANH_18_1_F    | 2021-08-04 |
| ANH_18_1_F    | 2021-08-04 |
| ANH_18_1_F    | 2021-08-04 |
| ANH_18_1_F    | 2021-08-04 |
| ANH_18_1_F    | 2021-08-04 |
| ANH_18_1_F    | 2021-08-04 |
| ANH_284_1_F   | 2021-07-19 |
| ANH_284_1_F   | 2021-07-19 |
| ANH_284_1_F   | 2021-07-19 |
| ANH_284_1_F   | 2021-07-19 |
| ANH_307_1_F   | 2021-07-26 |
| ANH_312_1_F   | 2021-08-02 |
| ANH_319_1_F   | 2021-07-28 |
| ANH_319_1_F   | 2021-07-28 |
| ANH_319_1_F   | 2021-07-28 |
| ANH_320_1_F   | 2021-07-07 |
| ANH_320_1_F   | 2021-07-07 |
| ANH_335_1_F   | 2021-07-13 |
| ANH_395_1_F   | 2021-08-10 |
| ANH_395_1_F   | 2021-08-10 |
| ANH_395_1_F   | 2021-08-10 |
| ANH_395_1_F   | 2021-08-10 |
| ANH_18_1      | 2021-08-04 |
| ANH_18_1      | 2021-08-04 |
| ANH_18_1      | 2021-08-04 |
| ANH_18_1      | 2021-08-04 |
| ANH_18_1      | 2021-08-04 |
| ANH_18_1      | 2021-08-04 |
| ANH_18_1      | 2021-08-04 |
| ANH_18_1      | 2021-08-04 |
| ANH_284_1     | 2021-07-19 |
| ANH_284_1     | 2021-07-19 |
| ANH_284_1     | 2021-07-19 |
| ANH_284_1     | 2021-07-19 |
| ANH_307_1     | 2021-07-23 |
| ANH_312_1     | 2021-08-02 |
| ANH_319_1     | 2021-07-28 |
| ANH_319_1     | 2021-07-28 |
| ANH_319_1     | 2021-07-28 |
| ANH_320_1     | 2021-07-07 |
| ANH_320_1     | 2021-07-07 |
| ANH_335_1     | 2021-07-13 |
| ANH_395_1     | 2021-08-10 |
| ANH_395_1     | 2021-08-10 |
| ANH_395_1     | 2021-08-10 |
| ANH_395_1     | 2021-08-10 |
| NA            | NA         |

53 records

</div>

``` sql
INSERT INTO main.registros(cd_event, cds_recorded_by, date_time, cd_tax, cd_morfo, date_ident, cds_identified_by, qt_double,remarks, occurrence_id, organism_id)
SELECT
 cd_event,
 cds_recorded_by,
 NULL date_time,
 tt.cd_tax,
 tt.cd_morfo,
 TO_DATE(date_identified,'YYYY-MM-DD') date_ident,
 cds_identified_by,
 organism_quantity::double precision qt_double,
 NULL remarks,
 r.occurrence_id,
 SPLIT_PART(occurrence_id,':',7) organism_id
 --ROW_NUMBER() OVER (ORDER BY (e.date_time_begin::date||' '||event_time)::timestamp)
 --NULL AS organism_id,
 -- organism_id::text
 --ST_SetSRID(ST_Transform(ST_SetSRID(ST_MakePoint(measurement_value__longitud_,measurement_value__latitud_), 4326),  (SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)),3116)
FROM raw_dwc.botanica_registros_epi_vas r
LEFT JOIN raw_dwc.taxonomy_total tt ON tt."row.names"=r."row.names" AND tt.table_orig='botanica_registros_epi_vas'
LEFT JOIN main.event e USING (cd_event)
WHERE cd_event IS NOT NULL
ORDER BY e.event_id
RETURNING cd_event, cds_recorded_by, date_time, cd_tax, cd_morfo, cds_identified_by, qt_double,remarks, occurrence_id, organism_id
```

``` sql
ALTER TABLE raw_dwc.botanica_registros_epi_vas ADD COLUMN cd_reg int REFERENCES main.registros(cd_reg);
UPDATE raw_dwc.botanica_registros_epi_vas AS ar
SET cd_reg=r.cd_reg
FROM main.registros r
WHERE ar.cd_event=r.cd_event AND ar.occurrence_id=r.occurrence_id;

-- Check cd_reg are unique in the source table
SELECT cd_reg,count(*) FROM  raw_dwc.botanica_registros_epi_vas GROUP BY cd_reg HAVING count(*)>1;
```

<div class="knitsql-table">

    cd_reg   count

------------------------------------------------------------------------

: 0 records

</div>

### 13.6.3 epifitas no vasculares

``` sql
SELECT occurrence_id, count(*)
FROM raw_dwc.botanica_registros_epi_novas
GROUP BY occurrence_id
HAVING count(*)>1;
```

<div class="knitsql-table">

occurrence_id count ————— ——-

: 0 records

</div>

``` sql
SELECT e.occurrence_id, e.event_date-- r.event_date, e.event_time, r.event_time
FROM raw_dwc.botanica_registros_epi_novas r
LEFT JOIN raw_dwc.botanica_event e USING(cd_event)
--ORDER BY r.event_date::date, r.event_time::time
```

<div class="knitsql-table">

| occurrence_id | event_date |
|:--------------|:-----------|
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |
| NA            | NA         |

Displaying records 1 - 100

</div>

------------------------------------------------------------------------

**Note**: no integro en los registros todos las filas que tienen una de
las condiciones siguientes:

- No tienen cd_event (probablemente porque no tenían numero de forofito
  o no tenían numero de malla
- No tienen phylum (las cortezas y termiteros se anotaron como Plantae
  en Kingdom, pero si phylum)
- Tienen ‘-’ como cobertura (no idea de lo que es

------------------------------------------------------------------------

``` sql
INSERT INTO main.registros(cd_event, cds_recorded_by, date_time, cd_tax, cd_morfo, date_ident, cds_identified_by, qt_double,remarks, occurrence_id, organism_id)
SELECT
 cd_event,
 cds_recorded_by,
 NULL date_time,
 tt.cd_tax,
 tt.cd_morfo,
 TO_DATE(date_identified,'YYYY-MM-DD') date_ident,
 cds_identified_by,
 organism_quantity::double precision qt_double,
 occurrence_remarks remarks,
 r.occurrence_id,
 SPLIT_PART(occurrence_id,':',7) organism_id
 --ROW_NUMBER() OVER (ORDER BY (e.date_time_begin::date||' '||event_time)::timestamp)
 --NULL AS organism_id,
 --organism_id::text
 --ST_SetSRID(ST_Transform(ST_SetSRID(ST_MakePoint(measurement_value__longitud_,measurement_value__latitud_), 4326),  (SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)),3116)
FROM raw_dwc.botanica_registros_epi_novas r
LEFT JOIN raw_dwc.taxonomy_total tt ON tt."row.names"=r."row.names" AND tt.table_orig='botanica_registros_epi_novas'
LEFT JOIN main.event e USING (cd_event)
WHERE cd_event IS NOT NULL AND r.phylum IS NOT NULL AND organism_quantity <> '-'
ORDER BY e.event_id
RETURNING cd_event, cds_recorded_by, date_time, cd_tax, cd_morfo, cds_identified_by, qt_double,remarks, occurrence_id, organism_id
```

``` sql
ALTER TABLE raw_dwc.botanica_registros_epi_novas ADD COLUMN cd_reg int REFERENCES main.registros(cd_reg);
UPDATE raw_dwc.botanica_registros_epi_novas AS ar
SET cd_reg=r.cd_reg
FROM main.registros r
WHERE ar.cd_event=r.cd_event AND ar.occurrence_id=r.occurrence_id;

-- Check cd_reg are unique in the source table
SELECT cd_reg,count(*) FROM  raw_dwc.botanica_registros_epi_novas GROUP BY cd_reg HAVING count(*)>1;
```

<div class="knitsql-table">

| cd_reg | count |
|-------:|------:|
|     NA |   267 |

1 records

</div>

# 14 Correcciones

## 14.1 Macroinvertebrados

A veces las areas que están en la pestaña de registros están mal, lo que
resulta en errores en el calculo de las densidades:

**Nota: son 171 casos donde la diferencia entre mi calculo y lo que hay
en el DwC es de más de 20%**

``` sql
SELECT event_id,protocol,samp_effort_1 area,qt_int abs_ab,qt_int/samp_effort_1 calculado,qt_double val_dwc
FROM main.registros r
LEFT JOIN main.event USING(cd_event)
LEFT JOIN main.gp_event USING (cd_gp_event)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE cd_gp_biol='minv' AND samp_effort_1 IS NOT NULL AND qt_int IS NOT NULL
 AND ( ((qt_int/samp_effort_1)/qt_double)>1.2 OR ((qt_int/samp_effort_1)/qt_double)<0.8 )
```

<div class="knitsql-table">

| event_id          | protocol                            |  area | abs_ab |   calculado |      val_dwc |
|:------------------|:------------------------------------|------:|-------:|------------:|-------------:|
| ANH15-MI-C-Bajas  | D net (associated with macrophytes) | 0.450 |      3 |   6.6666667 |    1.0000000 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |     22 |  48.8888889 |    7.3333333 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      4 |   8.8888889 |    1.3333333 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      8 |  17.7777778 |    2.6666667 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      5 |  11.1111111 |    1.6666667 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |     10 |  22.2222222 |    3.3333333 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |     16 |  35.5555556 |    5.3333333 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |     45 | 100.0000000 |   15.0000000 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      6 |  13.3333333 |    2.0000000 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      2 |   4.4444444 |    0.6666667 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      2 |   4.4444444 |    0.6666667 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      3 |   6.6666667 |    1.0000000 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      2 |   4.4444444 |    0.6666667 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      2 |   4.4444444 |    0.6666667 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |     61 | 135.5555556 |   20.3333333 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |     20 |  44.4444444 |    6.6666667 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |     26 |  57.7777778 |    8.6666667 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      4 |   8.8888889 |    1.3333333 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      2 |   4.4444444 |    0.6666667 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      7 |  15.5555556 |    2.3333333 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |     15 |  33.3333333 |    5.0000000 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |    277 | 615.5555556 |   92.3333333 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |     61 | 135.5555556 |   20.3300000 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      3 |   6.6666667 |    1.0000000 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |     21 |  46.6666667 |    7.0000000 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      5 |  11.1111111 |    1.6666667 |
| ANH300-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH300-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |     18 |  40.0000000 |    6.0000000 |
| ANH300-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |     12 |  26.6666667 |    4.0000000 |
| ANH301-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |      3 |   6.6666667 |    1.0000000 |
| ANH301-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH301-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |     26 |  57.7777778 |    8.6666667 |
| ANH301-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |     32 |  71.1111111 |   10.6666667 |
| ANH301-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |      3 |   6.6666667 |    1.0000000 |
| ANH15-MI-C-Bajas  | D net (associated with macrophytes) | 0.450 |      2 |   4.4444444 |    0.6666667 |
| ANH15-MI-C-Bajas  | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH42-MI-C-Bajas  | D net kick sampling                 | 3.000 |      2 |   0.6666667 |    0.4950000 |
| ANH296-MI-B-Bajas | Grab collector + type D net         | 0.252 |      2 |   7.9365079 |    4.4400000 |
| ANH296-MI-B-Bajas | Grab collector + type D net         | 0.252 |      2 |   7.9365079 |    4.4400000 |
| ANH296-MI-B-Bajas | Grab collector + type D net         | 0.252 |      2 |   7.9365079 |    4.4400000 |
| ANH296-MI-B-Bajas | Grab collector + type D net         | 0.252 |      1 |   3.9682540 |    2.2200000 |
| ANH299-MI-B-Bajas | Grab collector + type D net         | 0.432 |      3 |   6.9444444 |    5.4500000 |
| ANH305-MI-B-Bajas | D net kick sampling                 | 3.000 |      7 |   2.3333333 |    9.3300000 |
| ANH305-MI-B-Bajas | D net kick sampling                 | 3.000 |    346 | 115.3333333 |  461.3300000 |
| ANH11-MI-B        | D net (associated with macrophytes) | 0.450 |     15 |  33.3333333 |   15.5600000 |
| ANH291-MI-A       | D net (associated with macrophytes) | 0.450 |     22 |  48.8888889 |   18.8880000 |
| ANH300-MI-C       | D net (associated with macrophytes) | 0.450 |     32 |  71.1111111 |   48.8890000 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      7 |  15.5555556 |    2.3333333 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      3 |   6.6666667 |    1.0000000 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |     27 |  60.0000000 |    9.0000000 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      3 |   6.6666667 |    1.0000000 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      2 |   4.4444444 |    0.6666667 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      4 |   8.8888889 |    1.3333333 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      3 |   6.6666667 |    1.0000000 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |     70 | 155.5555556 |   23.3333333 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |     29 |  64.4444444 |    9.6666667 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |    202 | 448.8888889 |   67.3300000 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |     34 |  75.5555556 |   11.3333333 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      9 |  20.0000000 |    3.0000000 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |     13 |  28.8888889 |    4.3333333 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |     65 | 144.4444444 |   21.6666667 |
| ANH300-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |      3 |   6.6666667 |    1.0000000 |
| ANH300-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH301-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |     10 |  22.2222222 |    3.3333333 |
| ANH301-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |      7 |  15.5555556 |    2.3333333 |
| ANH301-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |      2 |   4.4444444 |    0.6666667 |
| ANH15-MI-C-Bajas  | D net (associated with macrophytes) | 0.450 |     11 |  24.4444444 |    3.6666667 |
| ANH42-MI-C-Bajas  | D net kick sampling                 | 3.000 |      2 |   0.6666667 |    0.4950000 |
| ANH296-MI-B-Bajas | Grab collector + type D net         | 0.252 |      1 |   3.9682540 |    2.2200000 |
| ANH305-MI-B-Bajas | D net kick sampling                 | 3.000 |     43 |  14.3333333 |   57.3300000 |
| ANH305-MI-B-Bajas | D net kick sampling                 | 3.000 |      3 |   1.0000000 |    4.0000000 |
| ANH305-MI-B-Bajas | D net kick sampling                 | 3.000 |      2 |   0.6666667 |    2.6700000 |
| ANH305-MI-B-Bajas | D net kick sampling                 | 3.000 |      1 |   0.3333333 |    1.3300000 |
| ANH12-MI-C        | D net kick sampling                 | 3.000 |      5 |   1.6666667 | 1667.0000000 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |     25 |  55.5555556 |    8.3333333 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      7 |  15.5555556 |    2.3333333 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |     14 |  31.1111111 |    4.6666667 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      9 |  20.0000000 |    3.0000000 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |     16 |  35.5555556 |    5.3333333 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      3 |   6.6666667 |    1.0000000 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |    213 | 473.3333333 |   71.0000000 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |    100 | 222.2222222 |   33.3333333 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      2 |   4.4444444 |    0.6666667 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      2 |   4.4444444 |    0.6666667 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      3 |   6.6666667 |    1.0000000 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |     51 | 113.3333333 |   17.0000000 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      4 |   8.8888889 |    1.3333333 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      2 |   4.4444444 |    0.6666667 |
| ANH300-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH300-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |      6 |  13.3333333 |    2.0000000 |
| ANH300-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |     23 |  51.1111111 |    7.6666667 |
| ANH300-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH300-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |      9 |  20.0000000 |    3.0000000 |
| ANH300-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH300-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |     11 |  24.4444444 |    3.6666667 |
| ANH300-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |      5 |  11.1111111 |    1.6666667 |
| ANH300-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH300-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |     26 |  57.7777778 |    8.6700000 |
| ANH301-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |      3 |   6.6666667 |    1.0000000 |
| ANH301-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |     40 |  88.8888889 |   13.3333333 |
| ANH301-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |      2 |   4.4444444 |    0.6666667 |
| ANH301-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |     65 | 144.4444444 |   21.6666667 |
| ANH301-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |      3 |   6.6666667 |    1.0000000 |
| ANH301-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |     83 | 184.4444444 |   27.6600000 |
| ANH301-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |      9 |  20.0000000 |    3.0000000 |
| ANH301-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH301-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |      2 |   4.4444444 |    0.6666667 |
| ANH301-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH15-MI-C-Bajas  | D net (associated with macrophytes) | 0.450 |     12 |  26.6666667 |    4.0000000 |
| ANH15-MI-C-Bajas  | D net (associated with macrophytes) | 0.450 |      3 |   6.6666667 |    1.0000000 |
| ANH15-MI-C-Bajas  | D net (associated with macrophytes) | 0.450 |      2 |   4.4444444 |    0.6666667 |
| ANH15-MI-C-Bajas  | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH305-MI-B-Bajas | D net kick sampling                 | 3.000 |    224 |  74.6666667 |  298.6700000 |
| ANH299-MI-B       | Grab collector + type D net         | 1.650 |      1 |   0.6060606 |    2.2200000 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      5 |  11.1111111 |    1.6666667 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |    103 | 228.8888889 |   34.3333333 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |     20 |  44.4444444 |    6.6666667 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      5 |  11.1111111 |    1.6666667 |
| ANH15-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      9 |  20.0000000 |    3.0000000 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      5 |  11.1111111 |    1.6666667 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |     17 |  37.7777778 |    5.6666667 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |     16 |  35.5555556 |    5.3333333 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      7 |  15.5555556 |    2.3333333 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      4 |   8.8888889 |    1.3333333 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |     34 |  75.5555556 |   11.3333333 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |     10 |  22.2222222 |    3.3333333 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |     12 |  26.6666667 |    4.0000000 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |     69 | 153.3333333 |   23.0000000 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |     23 |  51.1111111 |    7.6666667 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH34-MI-A-Bajas  | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH300-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |      2 |   4.4444444 |    0.6666667 |
| ANH300-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |      3 |   6.6666667 |    1.0000000 |
| ANH300-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |     80 | 177.7777778 |   26.6600000 |
| ANH300-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |     18 |  40.0000000 |    6.0000000 |
| ANH300-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |     11 |  24.4444444 |    3.6600000 |
| ANH301-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |     70 | 155.5555556 |   23.3333333 |
| ANH301-MI-A-Bajas | D net (associated with macrophytes) | 0.450 |     10 |  22.2222222 |    3.3333333 |
| ANH15-MI-C-Bajas  | D net (associated with macrophytes) | 0.450 |      4 |   8.8888889 |    1.3333333 |
| ANH15-MI-C-Bajas  | D net (associated with macrophytes) | 0.450 |     46 | 102.2222222 |   15.3333333 |
| ANH15-MI-C-Bajas  | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH15-MI-C-Bajas  | D net (associated with macrophytes) | 0.450 |      8 |  17.7777778 |    2.6666667 |
| ANH15-MI-C-Bajas  | D net (associated with macrophytes) | 0.450 |      1 |   2.2222222 |    0.3333333 |
| ANH296-MI-B-Bajas | Grab collector + type D net         | 0.252 |     25 |  99.2063492 |   55.5500000 |
| ANH296-MI-B-Bajas | Grab collector + type D net         | 0.252 |      2 |   7.9365079 |    4.4400000 |
| ANH296-MI-B-Bajas | Grab collector + type D net         | 0.252 |      2 |   7.9365079 |    4.4400000 |
| ANH296-MI-B-Bajas | Grab collector + type D net         | 0.252 |      1 |   3.9682540 |    2.2200000 |
| ANH296-MI-B-Bajas | Grab collector + type D net         | 0.252 |      1 |   3.9682540 |    2.2200000 |
| ANH305-MI-B-Bajas | D net kick sampling                 | 3.000 |      1 |   0.3333333 |    1.3300000 |

171 records

</div>

Así que lo que voy a hacer para macroinvertebrados es hacer el calculo y
reemplazar todos los valores (incluso los que tenían menos de 20% de
diferencia)

``` sql
WITH a AS(
  SELECT cd_reg,qt_int/samp_effort_1 calculado
  FROM main.registros r
  LEFT JOIN main.event USING(cd_event)
  LEFT JOIN main.gp_event USING (cd_gp_event)
  LEFT JOIN main.def_protocol USING (cd_protocol)
  WHERE cd_gp_biol='minv' AND samp_effort_1 IS NOT NULL AND qt_int IS NOT NULL
)
UPDATE main.registros r
SET qt_double=a.calculado
FROM a 
WHERE r.cd_reg=a.cd_reg
RETURNING r.cd_reg;
```

<div class="knitsql-table">

| cd_reg |
|-------:|
|  45110 |
|  45111 |
|  45113 |
|  45114 |
|  45115 |
|  48057 |
|  48058 |
|  48059 |
|  48060 |
|  48061 |
|  50878 |
|  50879 |
|  50880 |
|  53756 |
|  53757 |
|  53758 |
|  53759 |
|  53760 |
|  53761 |
|  53762 |
|  53764 |
|  45116 |
|  48062 |
|  48063 |
|  48064 |
|  48065 |
|  50881 |
|  50882 |
|  50883 |
|  50884 |
|  53765 |
|  53766 |
|  53767 |
|  53768 |
|  53769 |
|  53770 |
|  53771 |
|  44659 |
|  44673 |
|  44699 |
|  44700 |
|  44701 |
|  47643 |
|  47647 |
|  50362 |
|  50401 |
|  50444 |
|  50451 |
|  50452 |
|  53216 |
|  53260 |
|  53278 |
|  53287 |
|  53288 |
|  53289 |
|  44702 |
|  44703 |
|  44704 |
|  44705 |
|  47669 |
|  50453 |
|  50454 |
|  50455 |
|  50456 |
|  50457 |
|  50458 |
|  53290 |
|  53291 |
|  53292 |
|  53293 |
|  53294 |
|  53295 |
|  44706 |
|  47670 |
|  47671 |
|  47672 |
|  47673 |
|  47674 |
|  50459 |
|  50460 |
|  50461 |
|  50462 |
|  50463 |
|  50464 |
|  50465 |
|  53296 |
|  53297 |
|  44623 |
|  44707 |
|  44708 |
|  44709 |
|  44710 |
|  44711 |
|  44712 |
|  47675 |
|  47676 |
|  47677 |
|  47678 |
|  50466 |
|  50467 |

Displaying records 1 - 100

</div>

## 14.2 Macrofitas

### 14.2.1 Errores con la suma de abundancia de los cuadrantes

No es un error real sino una imprecisión en las unidades y variables
utilizada, la cantidad expresada en el campo organism_quantity es la
area total de cobertura en metros, lo que vamos a utilizar acá es la
cobertura en porcentaje.

``` sql
WITH a AS(
SELECT cd_reg,cd_event, REGEXP_REPLACE("measurement_value__cobertura_de_cada_una_de_las_especies__%__",',','.')::double precision sum_cov
FROM raw_dwc.hidrobiologico_registros
)
SELECT event_id,samp_effort_1 area, sum_cov, sum_cov/samp_effort_1 calculado,qt_double val_dwc
FROM a
LEFT JOIN main.registros USING (cd_reg,cd_event)
LEFT JOIN main.event USING (cd_event)
LEFT JOIN main.gp_event USING(cd_gp_event)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE cd_gp_biol='mafi'
AND (((sum_cov/samp_effort_1)/qt_double)>1.2 OR ((sum_cov/samp_effort_1)/qt_double)<0.8 )
```

<div class="knitsql-table">

| event_id        | area | sum_cov |   calculado | val_dwc |
|:----------------|-----:|--------:|------------:|--------:|
| ANH292-MA-Bajas |   20 |   30.00 |   1.5000000 |  0.3000 |
| ANH42-MA-Bajas  |   80 |  225.00 |   2.8125000 |  2.2500 |
| ANH10-MA        |   30 |   20.00 |   0.6666667 |  0.2000 |
| ANH10-MA        |   30 |   43.00 |   1.4333333 |  0.4300 |
| ANH10-MA        |   30 |   20.00 |   0.6666667 |  0.2000 |
| ANH10-MA        |   30 |   60.00 |   2.0000000 |  0.6000 |
| ANH11-MA        |   20 |  454.00 |  22.7000000 |  4.5400 |
| ANH11-MA        |   20 |   47.00 |   2.3500000 |  0.4700 |
| ANH11-MA        |   20 |   46.50 |   2.3250000 |  0.4650 |
| ANH11-MA        |   20 |   20.00 |   1.0000000 |  0.2000 |
| ANH11-MA        |   20 |   69.00 |   3.4500000 |  0.6900 |
| ANH11-MA        |   20 |  227.00 |  11.3500000 |  2.2700 |
| ANH12-MA        |   50 |   25.00 |   0.5000000 |  0.2500 |
| ANH12-MA        |   50 |   65.00 |   1.3000000 |  0.6500 |
| ANH12-MA        |   50 |  245.00 |   4.9000000 |  2.4500 |
| ANH12-MA        |   50 |    1.00 |   0.0200000 |  0.0100 |
| ANH12-MA        |   50 |   30.00 |   0.6000000 |  0.3000 |
| ANH13-MA        |   50 |   40.00 |   0.8000000 |  0.4000 |
| ANH14-MA        |   50 |   85.00 |   1.7000000 |  0.8500 |
| ANH14-MA        |   50 |  236.00 |   4.7200000 |  2.3600 |
| ANH14-MA        |   50 |  130.00 |   2.6000000 |  1.3000 |
| ANH15-MA        |   40 |   25.00 |   0.6250000 |  0.2500 |
| ANH15-MA        |   40 |    8.00 |   0.2000000 |  0.0800 |
| ANH15-MA        |   40 |   90.00 |   2.2500000 |  0.9000 |
| ANH15-MA        |   40 |    8.00 |   0.2000000 |  0.0800 |
| ANH15-MA        |   40 |  565.00 |  14.1250000 |  5.6500 |
| ANH16-MA        |   20 |   32.00 |   1.6000000 |  0.3200 |
| ANH16-MA        |   20 |  441.00 |  22.0500000 |  4.4100 |
| ANH16-MA        |   20 |  171.00 |   8.5500000 |  1.7100 |
| ANH17-MA        |   50 |  175.00 |   3.5000000 |  1.7500 |
| ANH18-MA        |   40 |  510.00 |  12.7500000 |  5.1000 |
| ANH18-MA        |   40 |  315.00 |   7.8750000 |  3.1000 |
| ANH18-MA        |   40 |  270.00 |   6.7500000 |  2.7000 |
| ANH18-MA        |   40 |   20.00 |   0.5000000 |  0.2000 |
| ANH18-MA        |   40 |   80.00 |   2.0000000 |  0.8000 |
| ANH19-MA        |   50 |   75.00 |   1.5000000 |  0.7500 |
| ANH19-MA        |   50 |   40.00 |   0.8000000 |  0.4000 |
| ANH19-MA        |   50 |   63.00 |   1.2600000 |  0.6300 |
| ANH20-MA        |   20 |   13.00 |   0.6500000 |  0.1300 |
| ANH21-MA        |   50 |   60.00 |   1.2000000 |  0.6000 |
| ANH291-MA       |   20 |   50.00 |   2.5000000 |  0.5000 |
| ANH291-MA       |   20 |  449.00 |  22.4500000 |  4.4900 |
| ANH291-MA       |   20 |   36.00 |   1.8000000 |  0.3600 |
| ANH291-MA       |   20 |    2.00 |   0.1000000 |  0.0200 |
| ANH293-MA       |   40 |  430.00 |  10.7500000 |  4.3000 |
| ANH294-MA       |   40 |   22.00 |   0.5500000 |  0.2200 |
| ANH294-MA       |   40 |  562.00 |  14.0500000 |  5.6200 |
| ANH294-MA       |   40 |  121.00 |   3.0250000 |  1.2100 |
| ANH295-MA       |   50 |   30.00 |   0.6000000 |  0.3000 |
| ANH295-MA       |   50 |  238.00 |   4.7600000 |  2.3800 |
| ANH296-MA       |   50 | 1515.00 |  30.3000000 | 15.1500 |
| ANH297-MA       |   50 |    5.00 |   0.1000000 |  0.0500 |
| ANH298-MA       |   50 |   30.00 |   0.6000000 |  0.3000 |
| ANH298-MA       |   50 |  205.00 |   4.1000000 |  2.0500 |
| ANH298-MA       |   50 |   26.00 |   0.5200000 |  0.2600 |
| ANH299-MA       |   12 |   44.00 |   3.6666667 |  0.4400 |
| ANH299-MA       |   12 |    1.00 |   0.0833333 |  0.0100 |
| ANH299-MA       |   12 |    5.00 |   0.4166667 |  0.0500 |
| ANH299-MA       |   12 |   74.00 |   6.1666667 |  0.1400 |
| ANH299-MA       |   12 |    1.00 |   0.0833333 |  0.0100 |
| ANH300-MA       |   40 |   11.00 |   0.2750000 |  0.1100 |
| ANH300-MA       |   40 |  434.00 |  10.8500000 |  4.3400 |
| ANH300-MA       |   40 |   56.00 |   1.4000000 |  0.5600 |
| ANH300-MA       |   40 |   40.00 |   1.0000000 |  0.4000 |
| ANH300-MA       |   40 |    2.00 |   0.0500000 |  0.0200 |
| ANH300-MA       |   40 |    5.00 |   0.1250000 |  0.0500 |
| ANH300-MA       |   40 |  390.00 |   9.7500000 |  3.9000 |
| ANH300-MA       |   40 |  303.00 |   7.5750000 |  3.0300 |
| ANH301-MA       |   30 |  792.00 |  26.4000000 |  7.9200 |
| ANH301-MA       |   30 |  100.00 |   3.3333333 |  1.0000 |
| ANH301-MA       |   30 |    4.00 |   0.1333333 |  0.0400 |
| ANH301-MA       |   30 |   25.00 |   0.8333333 |  0.2500 |
| ANH41-MA        |   80 |  155.00 |   1.9375000 |  1.5500 |
| ANH302-MA       |   50 |  205.00 |   4.1000000 |  2.0500 |
| ANH303-MA       |   50 |   25.00 |   0.5000000 |  0.2500 |
| ANH304-MA       |   50 |   80.00 |   1.6000000 |  0.8000 |
| ANH304-MA       |   50 |   75.00 |   1.5000000 |  0.7500 |
| ANH304-MA       |   50 |  110.00 |   2.2000000 |  1.1000 |
| ANH304-MA       |   50 |  625.00 |  12.5000000 |  6.2500 |
| ANH304-MA       |   50 |    5.00 |   0.1000000 |  0.0500 |
| ANH304-MA       |   50 |  163.00 |   3.2600000 |  1.6300 |
| ANH305-MA       |   50 |  150.00 |   3.0000000 |  1.5000 |
| ANH305-MA       |   50 |   90.00 |   1.8000000 |  0.7500 |
| ANH32-MA        |   60 |  667.00 |  11.1166667 |  6.4900 |
| ANH32-MA        |   60 |   74.00 |   1.2333333 |  0.7400 |
| ANH33-MA        |   60 |  821.90 |  13.6983333 |  8.2190 |
| ANH33-MA        |   60 |    5.00 |   0.0833333 |  0.0500 |
| ANH34-MA        |   12 |  129.00 |  10.7500000 |  1.2900 |
| ANH34-MA        |   12 |   75.00 |   6.2500000 |  0.7500 |
| ANH34-MA        |   12 |  136.00 |  11.3333333 |  1.3600 |
| ANH34-MA        |   12 |   11.00 |   0.9166667 |  0.1100 |
| ANH34-MA        |   12 |    1.00 |   0.0833333 |  0.0100 |
| ANH35-MA        |   50 |  210.00 |   4.2000000 |  6.2000 |
| ANH35-MA        |   50 |   25.00 |   0.5000000 |  0.2500 |
| ANH35-MA        |   50 |  570.00 |  11.4000000 |  2.1000 |
| ANH38-MA        |   30 |  596.00 |  19.8666667 |  5.9600 |
| ANH35-MA        |   50 |  105.00 |   2.1000000 |  1.1500 |
| ANH37-MA        |   50 |   13.00 |   0.2600000 |  0.1300 |
| ANH37-MA        |   50 |    5.00 |   0.1000000 |  0.0500 |
| ANH37-MA        |   50 |  275.00 |   5.5000000 |  2.7500 |
| ANH38-MA        |   30 |   27.00 |   0.9000000 |  0.2700 |
| ANH38-MA        |   30 |    5.00 |   0.1666667 |  0.0500 |
| ANH38-MA        |   30 |  251.00 |   8.3666667 |  2.5100 |
| ANH38-MA        |   30 |   25.00 |   0.8333333 |  0.2500 |
| ANH38-MA        |   30 |   10.00 |   0.3333333 |  0.1000 |
| ANH38-MA        |   30 |  204.00 |   6.8000000 |  2.0400 |
| ANH38-MA        |   30 |   86.00 |   2.8666667 |  0.8600 |
| ANH40-MA        |   40 |  625.00 |  15.6250000 |  6.2500 |
| ANH40-MA        |   40 |   87.00 |   2.1750000 |  0.8700 |
| ANH40-MA        |   40 |  170.00 |   4.2500000 |  1.7000 |
| ANH40-MA        |   40 |   36.00 |   0.9000000 |  0.3600 |
| ANH40-MA        |   40 |   93.00 |   2.3250000 |  0.9300 |
| ANH41-MA        |   80 |   15.00 |   0.1875000 |  0.1500 |
| ANH41-MA        |   80 |  650.00 |   8.1250000 |  6.5000 |
| ANH42-MA        |   50 |   74.00 |   1.4800000 |  0.7400 |
| ANH42-MA        |   50 |    1.00 |   0.0200000 |  0.0100 |
| ANH42-MA        |   50 |    7.00 |   0.1400000 |  0.0700 |
| ANH8-MA         |   40 |   17.00 |   0.4250000 |  0.1700 |
| ANH7-MA         |   40 |   20.00 |   0.5000000 |  0.2000 |
| ANH7-MA         |   40 |  203.00 |   5.0750000 |  2.0300 |
| ANH7-MA         |   40 |   10.00 |   0.2500000 |  0.1000 |
| ANH7-MA         |   40 |   25.00 |   0.6250000 |  0.2500 |
| ANH8-MA         |   40 |   30.00 |   0.7500000 |  0.3000 |
| ANH8-MA         |   40 |   30.00 |   0.7500000 |  0.3000 |
| ANH8-MA         |   40 |  140.00 |   3.5000000 |  1.4000 |
| ANH9-MA         |   20 |  503.00 |  25.1500000 |  5.0300 |
| ANH9-MA         |   20 |    1.00 |   0.0500000 |  0.0100 |
| ANH9-MA         |   20 |  270.00 |  13.5000000 |  2.7000 |
| ANH9-MA         |   20 |   40.00 |   2.0000000 |  0.4000 |
| ANH7-MA-Bajas   |   50 |   43.00 |   0.8600000 |  0.4300 |
| ANH7-MA-Bajas   |   50 |    2.00 |   0.0400000 |  0.0200 |
| ANH7-MA-Bajas   |   50 |   47.00 |   0.9400000 |  0.4700 |
| ANH7-MA-Bajas   |   50 |   26.00 |   0.5200000 |  0.2600 |
| ANH8-MA-Bajas   |   80 |   44.00 |   0.5500000 |  0.4400 |
| ANH8-MA-Bajas   |   80 |   18.00 |   0.2250000 |  0.1800 |
| ANH8-MA-Bajas   |   80 |    2.00 |   0.0250000 |  0.0200 |
| ANH8-MA-Bajas   |   80 |    5.00 |   0.0625000 |  0.0500 |
| ANH8-MA-Bajas   |   80 |  440.00 |   5.5000000 |  4.4000 |
| ANH8-MA-Bajas   |   80 |    3.00 |   0.0375000 |  0.0300 |
| ANH8-MA-Bajas   |   80 |    3.00 |   0.0375000 |  0.0300 |
| ANH8-MA-Bajas   |   80 |   20.00 |   0.2500000 |  0.2000 |
| ANH9-MA-Bajas   |   20 |   11.00 |   0.5500000 |  0.1100 |
| ANH9-MA-Bajas   |   20 |  173.00 |   8.6500000 |  1.7300 |
| ANH9-MA-Bajas   |   20 |   40.00 |   2.0000000 |  0.4000 |
| ANH9-MA-Bajas   |   20 |   23.00 |   1.1500000 |  0.2300 |
| ANH9-MA-Bajas   |   20 |  105.00 |   5.2500000 |  1.0500 |
| ANH10-MA-Bajas  |   30 |  235.00 |   7.8333333 |  2.3500 |
| ANH10-MA-Bajas  |   30 |  145.00 |   4.8333333 |  1.4500 |
| ANH10-MA-Bajas  |   30 |  220.00 |   7.3333333 |  2.2000 |
| ANH11-MA-Bajas  |   20 |  160.00 |   8.0000000 |  1.6000 |
| ANH11-MA-Bajas  |   20 |   40.00 |   2.0000000 |  0.4000 |
| ANH11-MA-Bajas  |   20 |   75.00 |   3.7500000 |  0.7500 |
| ANH12-MA-Bajas  |   20 |   15.00 |   0.7500000 |  0.1500 |
| ANH12-MA-Bajas  |   20 |   85.00 |   4.2500000 |  0.8500 |
| ANH12-MA-Bajas  |   20 |  285.00 |  14.2500000 |  2.8500 |
| ANH13-MA-Bajas  |   20 |   35.00 |   1.7500000 |  0.3500 |
| ANH13-MA-Bajas  |   20 |  100.00 |   5.0000000 |  1.0000 |
| ANH14-MA-Bajas  |   20 |   34.00 |   1.7000000 |  0.3400 |
| ANH14-MA-Bajas  |   20 |  120.00 |   6.0000000 |  1.2000 |
| ANH15-MA-Bajas  |   80 |   94.00 |   1.1750000 |  0.9400 |
| ANH15-MA-Bajas  |   80 |   41.00 |   0.5125000 |  0.4100 |
| ANH15-MA-Bajas  |   80 |    3.00 |   0.0375000 |  0.0300 |
| ANH15-MA-Bajas  |   80 |  922.00 |  11.5250000 |  9.2200 |
| ANH15-MA-Bajas  |   80 |  126.00 |   1.5750000 |  1.2600 |
| ANH15-MA-Bajas  |   80 |  289.00 |   3.6125000 |  2.8900 |
| ANH15-MA-Bajas  |   80 |   20.00 |   0.2500000 |  0.2000 |
| ANH16-MA-Bajas  |   80 |  232.00 |   2.9000000 |  2.3200 |
| ANH16-MA-Bajas  |   80 |   19.00 |   0.2375000 |  0.1900 |
| ANH16-MA-Bajas  |   80 | 1383.00 |  17.2875000 | 13.8300 |
| ANH16-MA-Bajas  |   80 |  883.00 |  11.0375000 |  8.8300 |
| ANH17-MA-Bajas  |   20 |  495.00 |  24.7500000 |  4.9500 |
| ANH17-MA-Bajas  |   20 |  151.00 |   7.5500000 |  1.5100 |
| ANH18-MA-Bajas  |   40 | 1330.00 |  33.2500000 | 13.3000 |
| ANH18-MA-Bajas  |   40 |   41.00 |   1.0250000 |  0.4100 |
| ANH18-MA-Bajas  |   40 |   66.00 |   1.6500000 |  0.6600 |
| ANH18-MA-Bajas  |   40 |   38.00 |   0.9500000 |  0.3800 |
| ANH19-MA-Bajas  |   20 |  822.00 |  41.1000000 |  8.2200 |
| ANH291-MA-Bajas |   20 |  470.00 |  23.5000000 |  4.7000 |
| ANH291-MA-Bajas |   20 |  235.00 |  11.7500000 |  2.3500 |
| ANH291-MA-Bajas |   20 |  350.00 |  17.5000000 |  3.5000 |
| ANH291-MA-Bajas |   20 |  325.00 |  16.2500000 |  3.2500 |
| ANH292-MA-Bajas |   20 |  375.00 |  18.7500000 |  3.7500 |
| ANH292-MA-Bajas |   20 |  505.00 |  25.2500000 |  5.0500 |
| ANH292-MA-Bajas |   20 |  490.00 |  24.5000000 |  4.9000 |
| ANH293-MA-Bajas |   40 | 1065.00 |  26.6250000 | 10.6500 |
| ANH293-MA-Bajas |   40 | 1350.00 |  33.7500000 | 13.5000 |
| ANH293-MA-Bajas |   40 |   45.00 |   1.1250000 |  0.4500 |
| ANH294-MA-Bajas |   20 |   70.00 |   3.5000000 |  0.7000 |
| ANH294-MA-Bajas |   20 |   10.00 |   0.5000000 |  0.1000 |
| ANH294-MA-Bajas |   20 |    5.00 |   0.2500000 |  0.0500 |
| ANH296-MA-Bajas |   80 |  185.00 |   2.3125000 |  1.8500 |
| ANH296-MA-Bajas |   80 |   86.00 |   1.0750000 |  0.8600 |
| ANH296-MA-Bajas |   80 |  469.00 |   5.8625000 |  4.6900 |
| ANH296-MA-Bajas |   80 |    1.00 |   0.0125000 |  0.0100 |
| ANH296-MA-Bajas |   80 |   44.00 |   0.5500000 |  0.4400 |
| ANH296-MA-Bajas |   80 |    2.00 |   0.0250000 |  0.0200 |
| ANH297-MA-Bajas |   80 |    5.00 |   0.0625000 |  0.0500 |
| ANH297-MA-Bajas |   80 |    3.00 |   0.0375000 |  0.0300 |
| ANH32-MA-Bajas  |   80 |   60.00 |   0.7500000 |  0.6000 |
| ANH33-MA-Bajas  |   80 |  210.00 |   2.6250000 |  2.1000 |
| ANH33-MA-Bajas  |   80 |  320.00 |   4.0000000 |  3.2000 |
| ANH34-MA-Bajas  |   30 |  278.00 |   9.2666667 |  2.7800 |
| ANH34-MA-Bajas  |   30 |   11.00 |   0.3666667 |  0.1100 |
| ANH34-MA-Bajas  |   30 |    4.00 |   0.1333333 |  0.0400 |
| ANH34-MA-Bajas  |   30 |   32.00 |   1.0666667 |  0.3200 |
| ANH34-MA-Bajas  |   30 |    1.00 |   0.0333333 |  0.0100 |
| ANH34-MA-Bajas  |   30 |   22.00 |   0.7333333 |  0.2200 |
| ANH34-MA-Bajas  |   30 |  100.00 |   3.3333333 |  1.0000 |
| ANH35-MA-Bajas  |   40 |   50.00 |   1.2500000 |  0.5000 |
| ANH35-MA-Bajas  |   40 |   67.00 |   1.6750000 |  0.6700 |
| ANH35-MA-Bajas  |   40 |   30.00 |   0.7500000 |  0.3000 |
| ANH35-MA-Bajas  |   40 |  165.00 |   4.1250000 |  1.6500 |
| ANH35-MA-Bajas  |   40 |   35.00 |   0.8750000 |  0.3500 |
| ANH35-MA-Bajas  |   40 |  140.00 |   3.5000000 |  1.4000 |
| ANH35-MA-Bajas  |   40 |  100.00 |   2.5000000 |  1.0000 |
| ANH35-MA-Bajas  |   40 |  110.00 |   2.7500000 |  1.1000 |
| ANH37-MA-Bajas  |   70 |  235.00 |   3.3571429 |  2.3500 |
| ANH37-MA-Bajas  |   70 |   22.00 |   0.3142857 |  0.2200 |
| ANH37-MA-Bajas  |   70 |    3.00 |   0.0428571 |  0.0300 |
| ANH37-MA-Bajas  |   70 |    7.00 |   0.1000000 |  0.0700 |
| ANH37-MA-Bajas  |   70 |   23.00 |   0.3285714 |  0.2300 |
| ANH37-MA-Bajas  |   70 |   23.00 |   0.3285714 |  0.2300 |
| ANH37-MA-Bajas  |   70 |   20.00 |   0.2857143 |  0.2000 |
| ANH37-MA-Bajas  |   70 |   11.00 |   0.1571429 |  0.1100 |
| ANH37-MA-Bajas  |   70 |    8.00 |   0.1142857 |  0.0800 |
| ANH38-MA-Bajas  |   70 |   35.65 |   0.5092857 |  0.3565 |
| ANH38-MA-Bajas  |   70 |  415.00 |   5.9285714 |  4.1500 |
| ANH38-MA-Bajas  |   70 |    5.00 |   0.0714286 |  0.0500 |
| ANH38-MA-Bajas  |   70 |   70.00 |   1.0000000 |  0.7000 |
| ANH38-MA-Bajas  |   70 |   27.00 |   0.3857143 |  0.2700 |
| ANH38-MA-Bajas  |   70 |  212.00 |   3.0285714 |  2.1200 |
| ANH39-MA-Bajas  |   40 |   10.00 |   0.2500000 |  0.1000 |
| ANH39-MA-Bajas  |   40 |   15.00 |   0.3750000 |  0.1500 |
| ANH39-MA-Bajas  |   40 |  340.00 |   8.5000000 |  3.4000 |
| ANH39-MA-Bajas  |   40 |   40.00 |   1.0000000 |  0.4000 |
| ANH39-MA-Bajas  |   40 |  180.00 |   4.5000000 |  1.8000 |
| ANH39-MA-Bajas  |   40 | 1390.00 |  34.7500000 | 13.9000 |
| ANH40-MA-Bajas  |   40 |    3.00 |   0.0750000 |  0.0300 |
| ANH42-MA-Bajas  |   80 |    5.00 |   0.0625000 |  0.0500 |
| ANH42-MA-Bajas  |   80 |  848.00 |  10.6000000 |  8.4800 |
| ANH42-MA-Bajas  |   80 |   22.00 |   0.2750000 |  0.2200 |
| ANH42-MA-Bajas  |   80 |  146.00 |   1.8250000 |  1.4600 |
| ANH43-MA-Bajas  |   40 |   35.00 |   0.8750000 |  0.3500 |
| ANH43-MA-Bajas  |   40 |   60.00 |   1.5000000 |  0.6000 |
| ANH43-MA-Bajas  |   40 |   20.00 |   0.5000000 |  0.2000 |
| ANH43-MA-Bajas  |   40 |   45.00 |   1.1250000 |  0.4500 |
| ANH43-MA-Bajas  |   40 |   40.00 |   1.0000000 |  0.4000 |
| ANH43-MA-Bajas  |   40 |  285.00 |   7.1250000 |  2.8500 |
| ANH303-MA-Bajas |   40 |    5.00 |   0.1250000 |  0.0500 |
| ANH295-MA-Bajas |   30 |   86.00 |   2.8666667 |  0.8600 |
| ANH298-MA-Bajas |   20 |    5.00 |   0.2500000 |  0.0500 |
| ANH299-MA-Bajas |   30 |  965.00 |  32.1666667 |  9.6500 |
| ANH299-MA-Bajas |   30 |  115.00 |   3.8333333 |  1.1500 |
| ANH300-MA-Bajas |   20 |   40.00 |   2.0000000 |  0.4000 |
| ANH304-MA-Bajas |   80 |  175.00 |   2.1875000 |  1.7500 |
| ANH300-MA-Bajas |   20 |  253.00 |  12.6500000 |  2.5300 |
| ANH300-MA-Bajas |   20 |   31.00 |   1.5500000 |  0.3100 |
| ANH301-MA-Bajas |   20 |  500.00 |  25.0000000 |  5.0000 |
| ANH301-MA-Bajas |   20 |   81.00 |   4.0500000 |  0.8100 |
| ANH301-MA-Bajas |   20 |  303.00 |  15.1500000 |  3.0300 |
| ANH301-MA-Bajas |   20 |    2.00 |   0.1000000 |  0.0200 |
| ANH301-MA-Bajas |   20 | 2850.00 | 142.5000000 | 28.5000 |
| ANH302-MA-Bajas |   20 |  130.00 |   6.5000000 |  1.3000 |
| ANH302-MA-Bajas |   20 |   15.00 |   0.7500000 |  0.1500 |
| ANH302-MA-Bajas |   20 |  110.00 |   5.5000000 |  1.1000 |
| ANH302-MA-Bajas |   20 |   20.00 |   1.0000000 |  0.2000 |
| ANH302-MA-Bajas |   20 |   10.00 |   0.5000000 |  0.1000 |
| ANH303-MA-Bajas |   40 |   65.00 |   1.6250000 |  0.6500 |
| ANH303-MA-Bajas |   40 |   10.00 |   0.2500000 |  0.1000 |
| ANH303-MA-Bajas |   40 |  300.00 |   7.5000000 |  3.0000 |
| ANH303-MA-Bajas |   40 |   85.00 |   2.1250000 |  0.8500 |
| ANH303-MA-Bajas |   40 |    5.00 |   0.1250000 |  0.0500 |
| ANH303-MA-Bajas |   40 |   15.00 |   0.3750000 |  0.1500 |
| ANH303-MA-Bajas |   40 |   10.00 |   0.2500000 |  0.1000 |
| ANH303-MA-Bajas |   40 |  165.00 |   4.1250000 |  1.6500 |
| ANH304-MA-Bajas |   80 |   14.00 |   0.1750000 |  0.1400 |
| ANH304-MA-Bajas |   80 |    5.00 |   0.0625000 |  0.0500 |
| ANH304-MA-Bajas |   80 |  176.00 |   2.2000000 |  1.7600 |
| ANH304-MA-Bajas |   80 |   60.00 |   0.7500000 |  0.6000 |
| ANH305-MA-Bajas |   80 |   89.00 |   1.1125000 |  0.8900 |
| ANH305-MA-Bajas |   80 |   41.00 |   0.5125000 |  0.4100 |
| ANH34-MA-Bajas  |   30 |  903.00 |  30.1000000 |  9.0300 |
| ANH10-MA        |   30 | 1210.00 |  40.3333333 | 12.1000 |
| ANH10-MA        |   30 |  355.00 |  11.8333333 |  3.5500 |
| ANH10-MA        |   30 |  280.00 |   9.3333333 |  2.8000 |
| ANH10-MA        |   30 |   65.00 |   2.1666667 |  0.6500 |
| ANH10-MA        |   30 |   75.00 |   2.5000000 |  0.7500 |
| ANH10-MA        |   30 |   20.00 |   0.6666667 |  0.2000 |
| ANH13-MA        |   50 |   35.00 |   0.7000000 |  0.3000 |
| ANH11-MA        |   20 |   11.00 |   0.5500000 |  0.1100 |
| ANH11-MA        |   20 |    0.50 |   0.0250000 |  5.0000 |
| ANH11-MA        |   20 |  425.00 |  21.2500000 |  4.2500 |
| ANH11-MA        |   20 |   79.00 |   3.9500000 |  0.7900 |
| ANH12-MA        |   50 |    3.00 |   0.0600000 |  0.0300 |
| ANH12-MA        |   50 |   15.00 |   0.3000000 |  0.1500 |
| ANH13-MA        |   50 |   86.00 |   1.7200000 |  0.8600 |
| ANH15-MA        |   40 |  106.00 |   2.6500000 |  1.0600 |
| ANH15-MA        |   40 |   28.00 |   0.7000000 |  0.2800 |
| ANH15-MA        |   40 |   44.00 |   1.1000000 |  0.4100 |
| ANH16-MA        |   20 |   20.00 |   1.0000000 |  0.2000 |
| ANH16-MA        |   20 |    7.00 |   0.3500000 |  0.0700 |
| ANH16-MA        |   20 |  343.00 |  17.1500000 |  3.4300 |
| ANH16-MA        |   20 |  220.00 |  11.0000000 |  2.2000 |
| ANH17-MA        |   50 |  343.00 |   6.8600000 |  3.4300 |
| ANH18-MA        |   40 |   10.00 |   0.2500000 |  0.1000 |
| ANH18-MA        |   40 |   10.00 |   0.2500000 |  0.1000 |
| ANH18-MA        |   40 |  135.00 |   3.3750000 |  1.3500 |
| ANH18-MA        |   40 |  715.00 |  17.8750000 |  7.1500 |
| ANH19-MA        |   50 |   10.00 |   0.2000000 |  0.1000 |
| ANH19-MA        |   50 |    5.00 |   0.1000000 |  0.0500 |
| ANH19-MA        |   50 | 1890.00 |  37.8000000 | 18.9000 |
| ANH19-MA        |   50 |   30.00 |   0.6000000 |  0.3000 |
| ANH20-MA        |   20 |  110.00 |   5.5000000 |  1.1000 |
| ANH21-MA        |   50 |   20.00 |   0.4000000 |  0.2000 |
| ANH21-MA        |   50 |    5.00 |   0.1000000 |  0.0500 |
| ANH291-MA       |   20 |   54.00 |   2.7000000 |  0.5400 |
| ANH291-MA       |   20 |  625.00 |  31.2500000 |  6.2500 |
| ANH291-MA       |   20 |   12.00 |   0.6000000 |  0.1200 |
| ANH291-MA       |   20 |  127.00 |   6.3500000 |  1.2700 |
| ANH292-MA       |   40 |   30.00 |   0.7500000 |  0.3000 |
| ANH292-MA       |   40 |   86.00 |   2.1500000 |  0.8600 |
| ANH292-MA       |   40 |  395.00 |   9.8750000 |  3.9500 |
| ANH293-MA       |   40 |  325.00 |   8.1250000 |  3.2500 |
| ANH293-MA       |   40 |   10.00 |   0.2500000 |  0.1000 |
| ANH294-MA       |   40 |  444.00 |  11.1000000 |  4.4400 |
| ANH294-MA       |   40 |    5.00 |   0.1250000 |  0.0500 |
| ANH295-MA       |   50 | 1315.00 |  26.3000000 | 13.1500 |
| ANH295-MA       |   50 |  123.00 |   2.4600000 |  1.2300 |
| ANH295-MA       |   50 |   20.00 |   0.4000000 |  0.2000 |
| ANH297-MA       |   50 |   17.00 |   0.3400000 |  0.1700 |
| ANH297-MA       |   50 |   90.00 |   1.8000000 |  0.9000 |
| ANH297-MA       |   50 |   31.00 |   0.6200000 |  0.3100 |
| ANH300-MA       |   40 |  121.00 |   3.0250000 |  1.2100 |
| ANH298-MA       |   50 |  148.00 |   2.9600000 |  1.4800 |
| ANH298-MA       |   50 |   45.00 |   0.9000000 |  0.4500 |
| ANH299-MA       |   12 |  615.00 |  51.2500000 |  6.1500 |
| ANH299-MA       |   12 |   63.00 |   5.2500000 |  0.6300 |
| ANH299-MA       |   12 |   14.00 |   1.1666667 |  0.1400 |
| ANH299-MA       |   12 |    2.00 |   0.1666667 |  0.0200 |
| ANH299-MA       |   12 |   14.00 |   1.1666667 |  0.1400 |
| ANH299-MA       |   12 |  155.00 |  12.9166667 |  1.5500 |
| ANH300-MA       |   40 |   36.00 |   0.9000000 |  0.3600 |
| ANH300-MA       |   40 |   25.00 |   0.6250000 |  0.2500 |
| ANH301-MA       |   30 |   16.00 |   0.5333333 |  0.1600 |
| ANH301-MA       |   30 |  387.00 |  12.9000000 |  3.8700 |
| ANH301-MA       |   30 |  177.00 |   5.9000000 |  1.7700 |
| ANH301-MA       |   30 |  349.00 |  11.6333333 |  3.4900 |
| ANH301-MA       |   30 |   92.00 |   3.0666667 |  0.9200 |
| ANH301-MA       |   30 |  149.00 |   4.9666667 |  1.4900 |
| ANH301-MA       |   30 |    8.00 |   0.2666667 |  0.0800 |
| ANH301-MA       |   30 |  110.00 |   3.6666667 |  1.1000 |
| ANH302-MA       |   50 |  193.00 |   3.8600000 |  1.9300 |
| ANH302-MA       |   50 |   73.00 |   1.4600000 |  0.7300 |
| ANH302-MA       |   50 |   40.00 |   0.8000000 |  0.4000 |
| ANH304-MA       |   50 |   15.00 |   0.3000000 |  0.1500 |
| ANH305-MA       |   50 |  760.00 |  15.2000000 |  7.6000 |
| ANH34-MA        |   12 |  171.00 |  14.2500000 |  1.7100 |
| ANH34-MA        |   12 |   21.00 |   1.7500000 |  0.2100 |
| ANH34-MA        |   12 |   33.00 |   2.7500000 |  0.3300 |
| ANH34-MA        |   12 |  211.00 |  17.5833333 |  2.1100 |
| ANH37-MA        |   50 |   41.00 |   0.8200000 |  0.4100 |
| ANH37-MA        |   50 |  100.00 |   2.0000000 |  1.0000 |
| ANH38-MA        |   30 |  104.00 |   3.4666667 |  1.0400 |
| ANH40-MA        |   40 |  248.00 |   6.2000000 |  2.4800 |
| ANH40-MA        |   40 |   28.00 |   0.7000000 |  0.2800 |
| ANH40-MA        |   40 |  690.00 |  17.2500000 |  6.9000 |
| ANH40-MA        |   40 |  100.00 |   2.5000000 |  1.0000 |
| ANH41-MA        |   80 |   90.00 |   1.1250000 |  0.9000 |
| ANH41-MA        |   80 |  987.00 |  12.3375000 |  9.8700 |
| ANH41-MA        |   80 |  215.00 |   2.6875000 |  2.1500 |
| ANH42-MA        |   50 |   63.00 |   1.2600000 |  0.6300 |
| ANH42-MA        |   50 |  379.00 |   7.5800000 |  4.2400 |
| ANH42-MA        |   50 |   15.00 |   0.3000000 |  0.1500 |
| ANH42-MA        |   50 |  343.00 |   6.8600000 |  3.4300 |
| ANH42-MA        |   50 |  225.00 |   4.5000000 |  2.2500 |
| ANH42-MA        |   50 |  139.00 |   2.7800000 |  1.3900 |
| ANH7-MA         |   40 |   22.00 |   0.5500000 |  0.2200 |
| ANH8-MA         |   40 |  200.00 |   5.0000000 |  2.0000 |
| ANH8-MA         |   40 |   13.00 |   0.3250000 |  0.1300 |
| ANH8-MA         |   40 |    7.00 |   0.1750000 |  0.0700 |
| ANH8-MA         |   40 |   46.00 |   1.1500000 |  0.4600 |
| ANH9-MA         |   20 |    3.00 |   0.1500000 |  0.0300 |
| ANH9-MA         |   20 |  650.00 |  32.5000000 |  6.5000 |
| ANH9-MA         |   20 |   18.00 |   0.9000000 |  0.1800 |
| ANH9-MA         |   20 |   36.00 |   1.8000000 |  0.3600 |
| ANH9-MA         |   20 |   22.00 |   1.1000000 |  0.2200 |
| ANH7-MA-Bajas   |   50 |   20.00 |   0.4000000 |  0.2000 |
| ANH8-MA-Bajas   |   80 |    7.00 |   0.0875000 |  0.0700 |
| ANH8-MA-Bajas   |   80 |    1.00 |   0.0125000 |  0.0100 |
| ANH8-MA-Bajas   |   80 |    7.00 |   0.0875000 |  0.0700 |
| ANH8-MA-Bajas   |   80 |    1.00 |   0.0125000 |  0.0100 |
| ANH8-MA-Bajas   |   80 |    3.00 |   0.0375000 |  0.0300 |
| ANH8-MA-Bajas   |   80 |    1.00 |   0.0125000 |  0.0100 |
| ANH8-MA-Bajas   |   80 |    1.00 |   0.0125000 |  0.0100 |
| ANH9-MA-Bajas   |   20 |   19.00 |   0.9500000 |  0.1900 |
| ANH9-MA-Bajas   |   20 |  618.00 |  30.9000000 |  6.1800 |
| ANH9-MA-Bajas   |   20 | 1140.00 |  57.0000000 | 11.4000 |
| ANH9-MA-Bajas   |   20 |   68.00 |   3.4000000 |  0.6800 |
| ANH9-MA-Bajas   |   20 |   44.00 |   2.2000000 |  0.4400 |
| ANH10-MA-Bajas  |   30 | 1195.00 |  39.8333333 | 11.9500 |
| ANH11-MA-Bajas  |   20 |  560.00 |  28.0000000 |  5.6000 |
| ANH11-MA-Bajas  |   20 |  310.00 |  15.5000000 |  3.1000 |
| ANH11-MA-Bajas  |   20 |  220.00 |  11.0000000 |  2.2000 |
| ANH12-MA-Bajas  |   20 |    5.00 |   0.2500000 |  0.0500 |
| ANH13-MA-Bajas  |   20 |  130.00 |   6.5000000 |  1.3000 |
| ANH14-MA-Bajas  |   20 |   17.00 |   0.8500000 |  0.1700 |
| ANH14-MA-Bajas  |   20 |   19.00 |   0.9500000 |  0.1900 |
| ANH14-MA-Bajas  |   20 |    8.00 |   0.4000000 |  0.0800 |
| ANH14-MA-Bajas  |   20 |   38.00 |   1.9000000 |  0.3800 |
| ANH15-MA-Bajas  |   80 |    6.00 |   0.0750000 |  0.0600 |
| ANH15-MA-Bajas  |   80 |    6.00 |   0.0750000 |  0.0600 |
| ANH15-MA-Bajas  |   80 |   22.00 |   0.2750000 |  0.2200 |
| ANH15-MA-Bajas  |   80 |    4.00 |   0.0500000 |  0.0400 |
| ANH15-MA-Bajas  |   80 |   26.00 |   0.3250000 |  0.2600 |
| ANH16-MA-Bajas  |   80 |  144.00 |   1.8000000 |  1.4400 |
| ANH16-MA-Bajas  |   80 |    2.00 |   0.0250000 |  0.0200 |
| ANH16-MA-Bajas  |   80 |    1.00 |   0.0125000 |  0.0100 |
| ANH16-MA-Bajas  |   80 |   15.00 |   0.1875000 |  0.1500 |
| ANH18-MA-Bajas  |   40 |  155.00 |   3.8750000 |  1.5500 |
| ANH18-MA-Bajas  |   40 |  328.00 |   8.2000000 |  3.2800 |
| ANH18-MA-Bajas  |   40 |  360.00 |   9.0000000 |  3.6000 |
| ANH20-MA-Bajas  |   20 |  675.00 |  33.7500000 |  6.7500 |
| ANH20-MA-Bajas  |   20 |   10.00 |   0.5000000 |  0.1000 |
| ANH21-MA-Bajas  |   20 |  670.00 |  33.5000000 |  6.7000 |
| ANH292-MA-Bajas |   20 |   14.00 |   0.7000000 |  0.1400 |
| ANH293-MA-Bajas |   40 |  220.00 |   5.5000000 |  2.2000 |
| ANH294-MA-Bajas |   20 |  175.00 |   8.7500000 |  1.7500 |
| ANH294-MA-Bajas |   20 |  255.00 |  12.7500000 |  2.5500 |
| ANH294-MA-Bajas |   20 |   15.00 |   0.7500000 |  0.1500 |
| ANH294-MA-Bajas |   20 |  325.00 |  16.2500000 |  3.2500 |
| ANH294-MA-Bajas |   20 |    5.00 |   0.2500000 |  0.0500 |
| ANH296-MA-Bajas |   80 |   80.00 |   1.0000000 |  0.8000 |
| ANH296-MA-Bajas |   80 |   25.00 |   0.3125000 |  0.2500 |
| ANH296-MA-Bajas |   80 |   66.00 |   0.8250000 |  0.6600 |
| ANH296-MA-Bajas |   80 |  262.00 |   3.2750000 |  2.6200 |
| ANH296-MA-Bajas |   80 |   25.00 |   0.3125000 |  0.2500 |
| ANH297-MA-Bajas |   80 |   11.00 |   0.1375000 |  0.1100 |
| ANH297-MA-Bajas |   80 |   88.00 |   1.1000000 |  0.8800 |
| ANH32-MA-Bajas  |   80 |  375.00 |   4.6875000 |  3.7500 |
| ANH32-MA-Bajas  |   80 |  925.00 |  11.5625000 |  9.2500 |
| ANH32-MA-Bajas  |   80 |   25.00 |   0.3125000 |  0.2500 |
| ANH33-MA-Bajas  |   80 |  945.00 |  11.8125000 |  9.4500 |
| ANH33-MA-Bajas  |   80 |  315.00 |   3.9375000 |  3.1500 |
| ANH34-MA-Bajas  |   30 |  212.00 |   7.0666667 |  2.1200 |
| ANH34-MA-Bajas  |   30 |  140.00 |   4.6666667 |  1.4000 |
| ANH34-MA-Bajas  |   30 |  641.00 |  21.3666667 |  6.4100 |
| ANH37-MA-Bajas  |   70 |   44.00 |   0.6285714 |  0.4400 |
| ANH35-MA-Bajas  |   40 |   15.00 |   0.3750000 |  0.1500 |
| ANH37-MA-Bajas  |   70 |   29.00 |   0.4142857 |  0.2900 |
| ANH37-MA-Bajas  |   70 |    2.00 |   0.0285714 |  0.0200 |
| ANH38-MA-Bajas  |   70 | 2443.00 |  34.9000000 | 24.4300 |
| ANH38-MA-Bajas  |   70 | 2439.00 |  34.8428571 | 24.3900 |
| ANH38-MA-Bajas  |   70 |  115.00 |   1.6428571 |  1.1500 |
| ANH38-MA-Bajas  |   70 |    9.00 |   0.1285714 |  0.0900 |
| ANH38-MA-Bajas  |   70 |    5.00 |   0.0714286 |  0.0500 |
| ANH38-MA-Bajas  |   70 |   63.00 |   0.9000000 |  0.6300 |
| ANH39-MA-Bajas  |   40 |   40.00 |   1.0000000 |  0.4000 |
| ANH39-MA-Bajas  |   40 |   20.00 |   0.5000000 |  0.2000 |
| ANH39-MA-Bajas  |   40 |  205.00 |   5.1250000 |  2.0500 |
| ANH39-MA-Bajas  |   40 |   90.00 |   2.2500000 |  0.9000 |
| ANH40-MA-Bajas  |   40 |    5.00 |   0.1250000 |  0.0500 |
| ANH40-MA-Bajas  |   40 |  632.00 |  15.8000000 |  6.3200 |
| ANH40-MA-Bajas  |   40 |  477.05 |  11.9262500 |  4.7705 |
| ANH40-MA-Bajas  |   40 |   45.00 |   1.1250000 |  0.4500 |
| ANH40-MA-Bajas  |   40 |  207.00 |   5.1750000 |  2.0700 |
| ANH41-MA-Bajas  |   40 |   15.00 |   0.3750000 |  0.1500 |
| ANH41-MA-Bajas  |   40 |  476.00 |  11.9000000 |  4.7600 |
| ANH41-MA-Bajas  |   40 |  125.00 |   3.1250000 |  1.2500 |
| ANH41-MA-Bajas  |   40 |  535.00 |  13.3750000 |  5.3500 |
| ANH41-MA-Bajas  |   40 |   15.00 |   0.3750000 |  0.1500 |
| ANH41-MA-Bajas  |   40 |  620.00 |  15.5000000 |  6.2000 |
| ANH41-MA-Bajas  |   40 |   80.00 |   2.0000000 |  0.8000 |
| ANH41-MA-Bajas  |   40 |   80.00 |   2.0000000 |  0.8000 |
| ANH42-MA-Bajas  |   80 |   80.00 |   1.0000000 |  0.8000 |
| ANH42-MA-Bajas  |   80 |  413.00 |   5.1625000 |  4.1300 |
| ANH42-MA-Bajas  |   80 | 1098.00 |  13.7250000 | 10.9800 |
| ANH42-MA-Bajas  |   80 |  149.00 |   1.8625000 |  1.4900 |
| ANH43-MA-Bajas  |   40 |  855.00 |  21.3750000 |  8.5500 |
| ANH43-MA-Bajas  |   40 |   30.00 |   0.7500000 |  0.3000 |
| ANH43-MA-Bajas  |   40 |    5.00 |   0.1250000 |  0.0500 |
| ANH295-MA-Bajas |   30 |   28.00 |   0.9333333 |  0.2800 |
| ANH295-MA-Bajas |   30 |   95.00 |   3.1666667 |  0.9500 |
| ANH295-MA-Bajas |   30 | 1875.00 |  62.5000000 | 18.7500 |
| ANH295-MA-Bajas |   30 |  218.00 |   7.2666667 |  2.1800 |
| ANH295-MA-Bajas |   30 |  467.00 |  15.5666667 |  4.6700 |
| ANH298-MA-Bajas |   20 |   25.00 |   1.2500000 |  0.2500 |
| ANH298-MA-Bajas |   20 |  150.00 |   7.5000000 |  1.5000 |
| ANH298-MA-Bajas |   20 |   30.00 |   1.5000000 |  0.3000 |
| ANH298-MA-Bajas |   20 |  165.00 |   8.2500000 |  1.6500 |
| ANH298-MA-Bajas |   20 |   25.00 |   1.2500000 |  0.2500 |
| ANH298-MA-Bajas |   20 |   90.00 |   4.5000000 |  0.9000 |
| ANH298-MA-Bajas |   20 |   10.00 |   0.5000000 |  0.1000 |
| ANH299-MA-Bajas |   30 |  510.00 |  17.0000000 |  5.1000 |
| ANH299-MA-Bajas |   30 |  115.00 |   3.8333333 |  1.1500 |
| ANH299-MA-Bajas |   30 |  315.00 |  10.5000000 |  3.1500 |
| ANH299-MA-Bajas |   30 |  135.00 |   4.5000000 |  1.3500 |
| ANH299-MA-Bajas |   30 |  160.00 |   5.3333333 |  1.6000 |
| ANH300-MA-Bajas |   20 |    8.00 |   0.4000000 |  0.0800 |
| ANH300-MA-Bajas |   20 |  657.00 |  32.8500000 |  6.5700 |
| ANH300-MA-Bajas |   20 |   51.00 |   2.5500000 |  0.5100 |
| ANH300-MA-Bajas |   20 |   46.00 |   2.3000000 |  0.4600 |
| ANH300-MA-Bajas |   20 |  188.00 |   9.4000000 |  1.8800 |
| ANH300-MA-Bajas |   20 |  307.00 |  15.3500000 |  3.0700 |
| ANH301-MA-Bajas |   20 |    3.00 |   0.1500000 |  0.0300 |
| ANH301-MA-Bajas |   20 |  281.00 |  14.0500000 |  2.8100 |
| ANH301-MA-Bajas |   20 |    3.00 |   0.1500000 |  0.0300 |
| ANH301-MA-Bajas |   20 |   84.00 |   4.2000000 |  0.8400 |
| ANH301-MA-Bajas |   20 |   65.00 |   3.2500000 |  0.6500 |
| ANH301-MA-Bajas |   20 |    5.00 |   0.2500000 |  0.0500 |
| ANH301-MA-Bajas |   20 |    5.00 |   0.2500000 |  0.0500 |
| ANH301-MA-Bajas |   20 |   16.00 |   0.8000000 |  0.1600 |
| ANH302-MA-Bajas |   20 |   10.00 |   0.5000000 |  0.1000 |
| ANH302-MA-Bajas |   20 |  620.00 |  31.0000000 |  6.2000 |
| ANH303-MA-Bajas |   40 |  190.00 |   4.7500000 |  1.9000 |
| ANH303-MA-Bajas |   40 |   20.00 |   0.5000000 |  0.2000 |
| ANH304-MA-Bajas |   80 |    2.00 |   0.0250000 |  0.0200 |
| ANH304-MA-Bajas |   80 |   22.00 |   0.2750000 |  0.2200 |
| ANH304-MA-Bajas |   80 |    1.00 |   0.0125000 |  0.0100 |
| ANH304-MA-Bajas |   80 |   10.00 |   0.1250000 |  0.1000 |

519 records

</div>

``` sql
WITH a AS(
SELECT cd_reg,cd_event, REGEXP_REPLACE("measurement_value__cobertura_de_cada_una_de_las_especies__%__",',','.')::double precision sum_cov
FROM raw_dwc.hidrobiologico_registros
),b AS(
SELECT cd_reg,event_id,samp_effort_1 area, sum_cov, sum_cov/samp_effort_1 calculado,qt_double val_dwc
FROM a
LEFT JOIN main.registros USING (cd_reg,cd_event)
LEFT JOIN main.event USING (cd_event)
LEFT JOIN main.gp_event USING(cd_gp_event)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE cd_gp_biol='mafi'
)
UPDATE main.registros r
SET qt_double=b.calculado
FROM b
WHERE r.cd_reg=b.cd_reg
RETURNING r.cd_reg, qt_double
```

<div class="knitsql-table">

| cd_reg |  qt_double |
|-------:|-----------:|
|  42894 |  1.5000000 |
|  48737 |  2.8125000 |
|  53145 |  0.6666667 |
|  47532 |  1.4333333 |
|  44585 |  0.6666667 |
|  44586 |  2.0000000 |
|  47534 | 22.7000000 |
|  47535 |  2.3500000 |
|  47536 |  2.3250000 |
|  53149 |  1.0000000 |
|  50304 |  3.4500000 |
|  50305 | 11.3500000 |
|  44587 |  0.5000000 |
|  53150 |  1.3000000 |
|  53151 |  4.9000000 |
|  50307 |  0.0200000 |
|  53152 |  0.6000000 |
|  47538 |  0.8000000 |
|  50308 |  1.7000000 |
|  53154 |  4.7200000 |
|  50309 |  2.6000000 |
|  53155 |  0.6250000 |
|  50310 |  0.2000000 |
|  53156 |  2.2500000 |
|  53157 |  0.2000000 |
|  53159 | 14.1250000 |
|  44589 |  1.6000000 |
|  44591 | 22.0500000 |
|  53160 |  8.5500000 |
|  53162 |  3.5000000 |
|  47541 | 12.7500000 |
|  47542 |  7.8750000 |
|  50312 |  6.7500000 |
|  50313 |  0.5000000 |
|  47544 |  2.0000000 |
|  53164 |  1.5000000 |
|  47545 |  0.8000000 |
|  53166 |  1.2600000 |
|  53167 |  0.6500000 |
|  44597 |  1.2000000 |
|  53170 |  2.5000000 |
|  53172 | 22.4500000 |
|  47549 |  1.8000000 |
|  44599 |  0.1000000 |
|  50318 | 10.7500000 |
|  44602 |  0.5500000 |
|  53174 | 14.0500000 |
|  53175 |  3.0250000 |
|  50321 |  0.6000000 |
|  53176 |  4.7600000 |
|  44604 | 30.3000000 |
|  47553 |  0.1000000 |
|  53178 |  0.6000000 |
|  47554 |  4.1000000 |
|  53179 |  0.5200000 |
|  44606 |  3.6666667 |
|  44607 |  0.0833333 |
|  44608 |  0.4166667 |
|  53182 |  6.1666667 |
|  44610 |  0.0833333 |
|  50328 |  0.2750000 |
|  50329 | 10.8500000 |
|  44611 |  1.4000000 |
|  47558 |  1.0000000 |
|  50331 |  0.0500000 |
|  50333 |  0.1250000 |
|  53184 |  9.7500000 |
|  50334 |  7.5750000 |
|  44612 | 26.4000000 |
|  50335 |  3.3333333 |
|  50337 |  0.1333333 |
|  44614 |  0.8333333 |
|  50338 |  1.9375000 |
|  50339 |  4.1000000 |
|  47562 |  0.5000000 |
|  44618 |  1.6000000 |
|  53188 |  1.5000000 |
|  53189 |  2.2000000 |
|  44619 | 12.5000000 |
|  44620 |  0.1000000 |
|  53190 |  3.2600000 |
|  50341 |  3.0000000 |
|  50342 |  1.8000000 |
|  53192 | 11.1166667 |
|  44621 |  1.2333333 |
|  44622 | 13.6983333 |
|  50343 |  0.0833333 |
|  50345 | 10.7500000 |
|  44624 |  6.2500000 |
|  44625 | 11.3333333 |
|  50346 |  0.9166667 |
|  47563 |  0.0833333 |
|  44626 |  4.2000000 |
|  47564 |  0.5000000 |
|  53195 | 11.4000000 |
|  47565 | 19.8666667 |
|  47566 |  2.1000000 |
|  50349 |  0.2600000 |
|  44627 |  0.1000000 |
|  53196 |  5.5000000 |

Displaying records 1 - 100

</div>

## 14.3 Añadir los “waterbody” de todos los eventos de muestreo acuatico

``` sql
INSERT INTO main.def_var_event_extra(var_event_extra,type_var,var_event_extra_spa,var_event_extra_comment)
VALUES('waterbody_name', 'free text', 'Nombre del cuerpo de agua','Verbatim from the original DwC file'
);

INSERT INTO main.event_extra (cd_event,cd_var_event_extra,value_text)
WITH a AS(
(
SELECT water_body, cd_event
FROM raw_dwc.peces_event
)
UNION ALL
(
SELECT water_body, cd_event
FROM raw_dwc.hidrobiologico_event
)
)
SELECT DISTINCT ON (cd_event) cd_event,(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='waterbody_name'), water_body
FROM a
RETURNING cd_event, cd_var_event_extra,value_text
;
```

``` r
dbDisconnect(fracking_db)
```

    ## [1] TRUE
