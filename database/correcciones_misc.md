Correcciones sobre los datos (después de la integración de las
estructuras de muestreo)
================
Marius Bottin
2023-05-17

- [1 Cambios de las coordenadas de
  herpetos](#1-cambios-de-las-coordenadas-de-herpetos)
- [2 Cambios de las coordenadas de
  escarabajos](#2-cambios-de-las-coordenadas-de-escarabajos)
- [3 Cambiar las coordenadas de
  Collembola](#3-cambiar-las-coordenadas-de-collembola)
- [4 Cambiar las coordenadas de
  Hormigas](#4-cambiar-las-coordenadas-de-hormigas)
- [5 Cambio coordenadas mamiferos](#5-cambio-coordenadas-mamiferos)
- [6 Change date for ANH_18 for
  perifiton](#6-change-date-for-anh_18-for-perifiton)
- [7 Cambio coordenadas herpetos](#7-cambio-coordenadas-herpetos)
- [8 Cambiar coordenadas de
  mariposas](#8-cambiar-coordenadas-de-mariposas)
- [9 Cambiar coordenadas de Aves](#9-cambiar-coordenadas-de-aves)

------------------------------------------------------------------------

Se trata en este documento de ejecutar las correcciones sobre la base de
datos

------------------------------------------------------------------------

------------------------------------------------------------------------

**Note**:

I do not have a way to share the documents that are used in this steps.
Those correction have been done by other people, which transmitted excel
files to me through emails…

------------------------------------------------------------------------

``` r
knitr::opts_chunk$set(tidy.opts = list(width.cutoff = 70), tidy = TRUE, connection="fracking_db", max.print=50)
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

# 1 Cambios de las coordenadas de herpetos

``` r
file <- "../../bpw_data_repo/Corrections/HerpetosCorreciones.xlsx"
corr <- read.xlsx(file)
colnames(corr) <- gsub("[().-]", "_", tolower(gsub("([a-z])([A-Z]+)", "\\1_\\L\\2",
    colnames(corr), perl = T)))
dbWriteTable(fracking_db, c("raw_dwc", "corr_coord_herp"), corr, overwrite = T)
```

    ## [1] TRUE

Averiguar que los event_id correspondan:

``` sql
SELECT c.event_id,ARRAY_AGG(e.cd_event)
FROM raw_dwc.corr_coord_herp c
LEFT JOIN main.event e USING (event_id)
GROUP BY c.event_id
```

<div class="knitsql-table">

| event_id              | array_agg |
|:----------------------|:----------|
| ANH_151_Herp_T2_D_TE2 | {135}     |
| ANH_167_Herp_T3_D_TE2 | {301}     |
| ANH_149_Herp_T3_D_TE2 | {113}     |
| ANH_167_Herp_T3_D     | {295}     |
| ANH_149_Herp_T3_N_TE2 | {114}     |
| ANH_149_Herp_T3_D     | {107}     |
| ANH_168_Herp_T2_D     | {305}     |
| ANH_164_Herp_T3_D_TE2 | {265}     |
| ANH_164_Herp_T3_N_TE2 | {266}     |
| ANH_149_Herp_T2_N_TE2 | {112}     |
| ANH_180_Herp_T3_N_TE2 | {368}     |
| ANH_141_Herp_T3_D     | {83}      |
| ANH_163_Herp_T1_D     | {243}     |
| ANH_162_Herp_T3_D     | {235}     |
| ANH_178_Herp_T3_N_TE2 | {344}     |
| ANH_109_Herp_T3_N     | {30}      |
| ANH_162_Herp_T2_D     | {233}     |
| ANH_162_Herp_T3_D_TE2 | {241}     |
| ANH_178_Herp_T2_D     | {335}     |
| ANH_153_Herp_T1_D     | {151}     |
| ANH_180_Herp_T1_D_TE2 | {363}     |
| ANH_167_Herp_T2_N_TE2 | {300}     |
| ANH_180_Herp_T2_D     | {359}     |
| ANH_153_Herp_T2_N     | {154}     |
| ANH_166_Herp_T1_N_TE2 | {286}     |
| ANH_167_Herp_T1_D     | {291}     |
| ANH_164_Herp_T3_N     | {260}     |
| ANH_164_Herp_T2_D_TE2 | {263}     |
| ANH_163_Herp_T3_D     | {247}     |
| ANH_165_Herp_T3_N     | {272}     |
| ANH_166_Herp_T1_D_TE2 | {285}     |
| ANH_162_Herp_T1_D_TE2 | {237}     |
| ANH_178_Herp_T3_D_TE2 | {343}     |
| ANH_100_Herp_T3_D_TE2 | {23}      |
| ANH_150_Herp_T2_N     | {118}     |
| ANH_100_Herp_T2_D_TE2 | {21}      |
| ANH_164_Herp_T2_N_TE2 | {264}     |
| ANH_178_Herp_T1_D     | {333}     |
| ANH_164_Herp_T1_D     | {255}     |
| ANH_180_Herp_T1_D     | {357}     |
| ANH_149_Herp_T3_N     | {108}     |
| ANH_178_Herp_T2_D_TE2 | {341}     |
| ANH_158_Herp_T3_D     | {199}     |
| ANH_180_Herp_T1_N_TE2 | {364}     |
| ANH_167_Herp_T2_D     | {293}     |
| ANH_178_Herp_T1_N     | {334}     |
| ANH_180_Herp_T1_N     | {358}     |
| ANH_164_Herp_T1_N_TE2 | {262}     |
| ANH_162_Herp_T1_D     | {231}     |
| ANH_162_Herp_T2_N_TE2 | {240}     |

Displaying records 1 - 50

</div>

``` sql
WITH a AS(
SELECT 
event_id,
ST_SetSrid(ST_transform(
   ST_MakeLine(ARRAY[
     ST_SetSrid(ST_MakePoint(longitud_inicial,latitud_inicial),4326),
     ST_SetSrid(ST_MakePoint(longitud_intermedia, latitud_intermedia),4326),
     ST_SetSrid(ST_MakePoint(longitud_final,latitud_final),4326)
  ])
,(SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)),3116) geom
FROM raw_dwc.corr_coord_herp 
)
UPDATE main.event AS e
SET li_geom=a.geom
FROM a
WHERE a.event_id=e.event_id
RETURNING e.event_id, ST_length(li_geom)
```

<div class="knitsql-table">

| event_id              | st_length |
|:----------------------|----------:|
| ANH_153_Herp_T1_D     | 164.13303 |
| ANH_153_Herp_T1_N     | 164.13303 |
| ANH_153_Herp_T2_D     |  64.28120 |
| ANH_153_Herp_T2_N     |  64.28120 |
| ANH_155_Herp_T1_D     |  95.51342 |
| ANH_155_Herp_T1_N     |  95.51342 |
| ANH_155_Herp_T2_D     | 115.10921 |
| ANH_155_Herp_T2_N     | 115.10921 |
| ANH_151_Herp_T2_D_TE2 | 131.58884 |
| ANH_151_Herp_T2_N_TE2 | 131.58884 |
| ANH_168_Herp_T2_D     | 371.73964 |
| ANH_168_Herp_T2_N     | 371.73964 |
| ANH_167_Herp_T1_D     | 373.80520 |
| ANH_167_Herp_T1_N     | 373.80520 |
| ANH_167_Herp_T2_D     | 204.50186 |
| ANH_167_Herp_T2_N     | 204.50186 |
| ANH_167_Herp_T1_D_TE2 | 220.63487 |
| ANH_167_Herp_T1_N_TE2 | 220.63487 |
| ANH_167_Herp_T3_D_TE2 | 219.77322 |
| ANH_167_Herp_T3_N_TE2 | 219.77322 |
| ANH_166_Herp_T1_D_TE2 | 171.55170 |
| ANH_166_Herp_T1_N_TE2 | 171.55170 |
| ANH_162_Herp_T1_D     | 509.75756 |
| ANH_162_Herp_T1_N     | 509.75756 |
| ANH_162_Herp_T2_D     | 260.89138 |
| ANH_162_Herp_T2_N     | 260.89138 |
| ANH_162_Herp_T3_D     | 242.18567 |
| ANH_162_Herp_T3_N     | 242.18567 |
| ANH_162_Herp_T1_D_TE2 | 257.16714 |
| ANH_162_Herp_T1_N_TE2 | 257.16714 |
| ANH_162_Herp_T2_D_TE2 | 282.05686 |
| ANH_162_Herp_T2_N_TE2 | 282.05686 |
| ANH_162_Herp_T3_D_TE2 | 233.86321 |
| ANH_162_Herp_T3_N_TE2 | 233.86321 |
| ANH_164_Herp_T1_D     | 268.75959 |
| ANH_164_Herp_T1_N     | 268.75959 |
| ANH_164_Herp_T3_D     | 128.11481 |
| ANH_164_Herp_T3_N     | 128.11481 |
| ANH_164_Herp_T2_D_TE2 | 236.30426 |
| ANH_164_Herp_T2_N_TE2 | 236.30426 |
| ANH_163_Herp_T1_D     | 354.29599 |
| ANH_163_Herp_T1_N     | 354.29599 |
| ANH_163_Herp_T2_D     | 291.34618 |
| ANH_163_Herp_T2_N     | 291.34618 |
| ANH_163_Herp_T3_D     | 430.78631 |
| ANH_163_Herp_T3_N     | 430.78631 |
| ANH_136_Herp_T1_D_TE2 | 153.95272 |
| ANH_136_Herp_T1_N_TE2 | 153.95272 |
| ANH_158_Herp_T3_D     | 174.82988 |
| ANH_158_Herp_T3_N     | 174.82988 |

Displaying records 1 - 50

</div>

# 2 Cambios de las coordenadas de escarabajos

``` r
file <- "../../bpw_data_repo/Corrections/EscarabajosCambio.xlsx"
corr <- read.xlsx(file)
colnames(corr) <- gsub("[().-]", "_", tolower(gsub("([a-z])([A-Z]+)", "\\1_\\L\\2",
    colnames(corr), perl = T)))
dbWriteTable(fracking_db, c("raw_dwc", "corr_coord_esca"), corr, overwrite = T)
```

    ## [1] TRUE

Averiguar que los event_id correspondan:

``` sql
SELECT c.event_id,ARRAY_AGG(e.cd_event)
FROM raw_dwc.corr_coord_esca c
LEFT JOIN main.event e ON 'esca_'||c.event_id=e.event_id
GROUP BY c.event_id
```

<div class="knitsql-table">

| event_id                                     | array_agg |
|:---------------------------------------------|:----------|
| ANH_135_T. Exc. Human1_2021-07-01/2021-07-03 | {3035}    |
| ANH_120_T. Exc. Human4_2022-03-31/2022-04-02 | {3597}    |
| ANH_135_T. Exc. Human2_2021-07-01/2021-07-03 | {3036}    |
| ANH_371_T. Exc. Human5_2022-03-28/2022-03-30 | {3818}    |
| ANH_138_T. Exc. Human4_2022-03-28/2022-03-30 | {3707}    |
| ANH_120_T. Exc. Human5_2022-03-31/2022-04-02 | {3598}    |
| ANH_135_Captura manual3_2021-07-03           | {3033}    |
| ANH_123_T. Exc. Human1_2022-04-07/2022-04-09 | {3627}    |
| ANH_134_T. Exc. Human2_2022-03-22/2022-03-24 | {3683}    |
| ANH_113_Captura manual4_2021-07-16           | {3100}    |
| ANH_109_T. Exc. Human2_2021-07-15/2021-07-17 | {3003}    |
| ANH_109_T. Exc. Human6_2021-07-15/2021-07-17 | {3007}    |
| ANH_135_T. Exc. Human6_2021-07-01/2021-07-03 | {3040}    |
| ANH_109_T. Exc. Human7_2021-07-15/2021-07-17 | {3008}    |
| ANH_371_T. Exc. Human1_2022-03-28/2022-03-30 | {3814}    |
| ANH_121_Captura manual1_2021-07-22           | {3161}    |
| ANH_392_T. Exc. Human5_2022-03-17/2022-03-19 | {3862}    |
| ANH_371_Captura manual2_2021-07-08           | {3371}    |
| ANH_123_Captura manual4_2021-07-02           | {3186}    |
| ANH_122_T. Exc. Human4_2021-07-15/2021-07-17 | {3179}    |
| ANH_118_Captura manual2_2022-04-06           | {3580}    |
| ANH_109_T. Exc. Human5_2021-07-15/2021-07-17 | {3006}    |
| ANH_130_Captura manual1_2021-07-23           | {3205}    |
| ANH_122_T. Exc. Human6_2021-07-15/2021-07-17 | {3181}    |
| ANH_142_T. Exc. Human2_2022-03-31/2022-04-02 | {3716}    |
| ANH_137_T. Exc. Human6_2022-03-28/2022-03-30 | {3698}    |
| ANH_115_T. Exc. Human7_2022-04-05/2022-04-07 | {3567}    |
| ANH_125_Captura manual2_2022-04-09           | {3635}    |
| ANH_135_T. Exc. Human4_2021-07-01/2021-07-03 | {3038}    |
| ANH_109_Captura manual1_2022-04-06           | {3436}    |
| ANH_391_T. Exc. Human1_2022-03-17/2022-03-19 | {3847}    |
| ANH_113_Captura manual2_2022-04-05           | {3536}    |
| ANH_123_T. Exc. Human7_2021-07-02/2021-07-04 | {3193}    |
| ANH_134_Captura manual2_2022-03-22           | {3679}    |
| ANH_125_T. Exc. Human6_2022-04-07/2022-04-09 | {3643}    |
| ANH_122_T. Exc. Human1_2021-07-15/2021-07-17 | {3176}    |
| ANH_109_Captura manual2_2021-07-15           | {2999}    |
| ANH_121_T. Exc. Human5_2022-04-07/2022-04-09 | {3609}    |
| ANH_113_T. Exc. Human7_2022-04-05/2022-04-07 | {3545}    |
| ANH_118_T. Exc. Human5_2022-04-04/2022-04-06 | {3587}    |
| ANH_134_T. Exc. Human7_2022-03-22/2022-03-24 | {3688}    |
| ANH_118_T. Exc. Human2_2022-04-04/2022-04-06 | {3584}    |
| ANH_134_T. Exc. Human5_2021-07-05/2021-07-07 | {3246}    |
| ANH_374_Captura manual1_2021-07-19           | {3053}    |
| ANH_120_Captura manual2_2021-07-17           | {3151}    |
| ANH_113_Captura manual3_2021-07-16           | {3099}    |
| ANH_110_T. Exc. Human5_2021-07-15/2021-07-17 | {3083}    |
| ANH_371_Captura manual1_2022-03-28           | {3810}    |
| ANH_118_T. Exc. Human2_2021-07-15/2021-07-17 | {3144}    |
| ANH_120_T. Exc. Human7_2021-07-16/2021-07-18 | {3160}    |

Displaying records 1 - 50

</div>

``` sql
WITH a AS(
SELECT 
'esca_'||event_id event_id,
ST_SetSrid(ST_transform(
     ST_SetSrid(ST_MakePoint(decimal_lon,decimal_lat),4326)
,(SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)),3116) geom
FROM raw_dwc.corr_coord_esca 
)
UPDATE main.event AS e
SET pt_geom=a.geom
FROM a
WHERE a.event_id=e.event_id
RETURNING e.event_id, ST_X(pt_geom),ST_Y(pt_geom)
```

<div class="knitsql-table">

| event_id                                          |    st_x |    st_y |
|:--------------------------------------------------|--------:|--------:|
| esca_ANH_373_T. Exc. Human3_2021-07-22/2021-07-24 | 1031558 | 1300874 |
| esca_ANH_373_T. Exc. Human3_2022-04-05/2022-04-07 | 1031560 | 1300874 |
| esca_ANH_373_T. Exc. Human7_2021-07-22/2021-07-24 | 1031722 | 1300887 |
| esca_ANH_373_Captura manual3_2021-07-23           | 1031558 | 1300874 |
| esca_ANH_142_Captura manual4_2022-04-01           | 1032908 | 1300838 |
| esca_ANH_142_T. Exc. Human5_2022-03-31/2022-04-02 | 1032905 | 1300838 |
| esca_ANH_142_T. Exc. Human7_2021-07-13/2021-07-15 | 1032916 | 1300839 |
| esca_ANH_142_T. Exc. Human2_2021-07-13/2021-07-15 | 1032986 | 1300770 |
| esca_ANH_142_T. Exc. Human2_2022-03-31/2022-04-02 | 1032986 | 1300769 |
| esca_ANH_142_T. Exc. Human4_2021-07-13/2021-07-15 | 1033007 | 1300745 |
| esca_ANH_114_Captura manual1_2021-07-06           | 1034145 | 1304390 |
| esca_ANH_114_T. Exc. Human7_2021-07-06/2021-07-08 | 1034148 | 1304518 |
| esca_ANH_118_Captura manual1_2021-07-17           | 1024038 | 1309377 |
| esca_ANH_118_Captura manual2_2021-07-17           | 1023973 | 1309410 |
| esca_ANH_118_T. Exc. Human2_2021-07-15/2021-07-17 | 1023936 | 1309398 |
| esca_ANH_118_T. Exc. Human3_2021-07-15/2021-07-17 | 1023964 | 1309392 |
| esca_ANH_118_T. Exc. Human4_2021-07-15/2021-07-17 | 1023998 | 1309377 |
| esca_ANH_118_T. Exc. Human4_2022-04-04/2022-04-06 | 1024073 | 1309334 |
| esca_ANH_118_T. Exc. Human5_2021-07-15/2021-07-17 | 1024053 | 1309374 |
| esca_ANH_118_T. Exc. Human6_2021-07-15/2021-07-17 | 1024099 | 1309367 |
| esca_ANH_118_T. Exc. Human7_2021-07-15/2021-07-17 | 1024139 | 1309361 |
| esca_ANH_118_T. Exc. Human7_2022-04-04/2022-04-06 | 1024244 | 1309319 |
| esca_ANH_120_Captura manual3_2021-07-17           | 1024720 | 1310294 |
| esca_ANH_120_Captura manual4_2021-07-18           | 1024769 | 1310251 |
| esca_ANH_120_T. Exc. Human4_2021-07-16/2021-07-18 | 1024767 | 1310124 |
| esca_ANH_120_T. Exc. Human5_2021-07-16/2021-07-18 | 1024682 | 1310088 |
| esca_ANH_120_T. Exc. Human7_2021-07-16/2021-07-18 | 1024767 | 1310127 |
| esca_ANH_110_Captura manual3_2021-07-17           | 1023788 | 1310877 |
| esca_ANH_125_Captura manual1_2022-04-09           | 1029992 | 1313943 |
| esca_ANH_125_Captura manual2_2022-04-09           | 1029897 | 1313894 |
| esca_ANH_125_Captura manual3_2021-07-14           | 1029826 | 1313940 |
| esca_ANH_125_Captura manual4_2021-07-14           | 1029790 | 1313941 |
| esca_ANH_125_T. Exc. Human2_2022-04-07/2022-04-09 | 1029761 | 1313953 |
| esca_ANH_125_T. Exc. Human3_2022-04-07/2022-04-09 | 1029820 | 1313951 |
| esca_ANH_125_T. Exc. Human4_2022-04-07/2022-04-09 | 1029857 | 1313932 |
| esca_ANH_125_T. Exc. Human6_2021-07-12/2021-07-14 | 1029921 | 1313875 |
| esca_ANH_125_T. Exc. Human6_2022-04-07/2022-04-09 | 1029949 | 1313891 |
| esca_ANH_125_T. Exc. Human7_2022-04-07/2022-04-09 | 1029987 | 1313936 |
| esca_ANH_369_T. Exc. Human7_2022-03-29/2022-03-31 | 1029776 | 1314029 |
| esca_ANH_369_Captura manual1_2021-07-12           | 1029984 | 1314224 |
| esca_ANH_369_T. Exc. Human1_2021-07-12/2021-07-14 | 1029984 | 1314224 |
| esca_ANH_369_T. Exc. Human6_2022-03-29/2022-03-31 | 1029749 | 1314069 |
| esca_ANH_110_Captura manual2_2021-07-17           | 1023791 | 1310865 |
| esca_ANH_110_Captura manual4_2021-07-17           | 1023801 | 1310897 |
| esca_ANH_110_T. Exc. Human2_2021-07-15/2021-07-17 | 1023788 | 1310872 |
| esca_ANH_110_T. Exc. Human1_2021-07-15/2021-07-17 | 1023811 | 1310916 |
| esca_ANH_122_Captura manual1_2022-04-04           | 1026118 | 1311784 |
| esca_ANH_122_Captura manual3_2021-07-15           | 1025936 | 1311813 |
| esca_ANH_122_Captura manual4_2021-07-15           | 1025995 | 1311816 |
| esca_ANH_122_Captura manual4_2022-04-04           | 1025931 | 1311809 |

Displaying records 1 - 50

</div>

# 3 Cambiar las coordenadas de Collembola

``` r
file <- "../../bpw_data_repo/Corrections/CollembolaCambio.xlsx"
corr <- read.xlsx(file)
colnames(corr) <- gsub("[().-]", "_", tolower(gsub("([a-z])([A-Z]+)", "\\1_\\L\\2",
    colnames(corr), perl = T)))
dbWriteTable(fracking_db, c("raw_dwc", "corr_coord_cole"), corr, overwrite = T)
```

    ## [1] TRUE

Averiguar que los event_id correspondan:

``` sql
SELECT c.event_id,ARRAY_AGG(e.cd_event)
FROM raw_dwc.corr_coord_cole c
LEFT JOIN main.event e ON 'cole_'||c.event_id=e.event_id
GROUP BY c.event_id
```

<div class="knitsql-table">

| event_id                               | array_agg |
|:---------------------------------------|:----------|
| ANH_370_Pitfall6_2022-03-28/2022-03-30 | {4775}    |
| ANH_123_Pitfall1_2021-07-05/2021-07-07 | {4098}    |
| ANH_369_Berlese5_2021-07-07/2021-07-13 | {4276}    |
| ANH_370_Pitfall4_2022-03-28/2022-03-30 | {4773}    |
| ANH_370_Berlese6_2022-03-28/2022-04-03 | {4769}    |
| ANH_369_Pitfall1_2022-03-24/2022-03-26 | {4758}    |
| ANH_366_Berlese5_2021-07-06/2021-07-12 | {4252}    |
| ANH_373_Pitfall2_2021-07-13/2021-07-15 | {NULL}    |
| ANH_372_Berlese2_2021-07-13/2021-07-19 | {4309}    |
| ANH_373_Berlese2_2021-07-13/2021-07-19 | {NULL}    |
| ANH_371_Pitfall2_2021-07-08/2021-07-12 | {4303}    |
| ANH_108_Pitfall6_2021-07-13/2021-07-15 | {3971}    |
| ANH_373_Pitfall1_2022-03-31/2022-04-02 | {NULL}    |
| ANH_134_Pitfall3_2022-03-22/2022-03-24 | {4640}    |
| ANH_134_Berlese6_2021-07-05/2021-07-11 | {4157}    |
| ANH_130_Pitfall2_2022-03-29/2022-03-31 | {4603}    |
| ANH_115_Berlese1_2021-07-02/2021-07-08 | {4020}    |
| ANH_110_Berlese1_2021-07-14/2021-07-20 | {3972}    |
| ANH_369_Berlese1_2022-03-24/2022-03-30 | {4752}    |
| ANH_134_Pitfall5_2021-07-05/2021-07-07 | {4162}    |
| ANH_133_Berlese1_2021-07-05/2021-07-11 | {3900}    |
| ANH_142_Berlese5_2022-03-31/2022-04-06 | {4672}    |
| ANH_134_Berlese2_2022-03-22/2022-03-28 | {4633}    |
| ANH_368_Pitfall5_2021-07-07/2021-07-09 | {4270}    |
| ANH_369_Pitfall5_2021-07-07/2021-07-09 | {4282}    |
| ANH_372_Pitfall1_2021-07-13/2021-07-15 | {4314}    |
| ANH_370_Berlese5_2022-03-28/2022-04-03 | {4768}    |
| ANH_369_Pitfall6_2021-07-07/2021-07-09 | {4283}    |
| ANH_368_Pitfall2_2021-07-07/2021-07-09 | {4267}    |
| ANH_133_Berlese1_2022-03-22/2022-03-28 | {4380}    |
| ANH_130_Pitfall1_2022-03-29/2022-03-31 | {4602}    |
| ANH_373_Pitfall2_2022-03-31/2022-04-02 | {NULL}    |
| ANH_130_Berlese4_2022-03-29/2022-04-04 | {4599}    |
| ANH_134_Berlese4_2021-07-05/2021-07-11 | {4155}    |
| ANH_371_Berlese1_2021-07-08/2021-07-14 | {4296}    |
| ANH_110_Pitfall1_2021-07-14/2021-07-16 | {3978}    |
| ANH_134_Pitfall5_2022-03-22/2022-03-24 | {4642}    |
| ANH_372_Pitfall3_2021-07-13/2021-07-15 | {4316}    |
| ANH_130_Pitfall6_2022-03-29/2022-03-31 | {4607}    |
| ANH_368_Pitfall1_2021-07-07/2021-07-09 | {4266}    |
| ANH_134_Berlese3_2022-03-22/2022-03-28 | {4634}    |
| ANH_366_Pitfall5_2021-07-06/2021-07-08 | {4258}    |
| ANH_371_Berlese3_2021-07-08/2021-07-14 | {4298}    |
| ANH_371_Pitfall4_2021-07-08/2021-07-12 | {4305}    |
| ANH_130_Pitfall5_2022-03-29/2022-03-31 | {4606}    |
| ANH_370_Pitfall3_2022-03-28/2022-03-30 | {4772}    |
| ANH_368_Berlese2_2021-07-07/2021-07-13 | {4261}    |
| ANH_372_Berlese4_2022-03-24/2022-03-30 | {4791}    |
| ANH_372_Berlese6_2021-07-13/2021-07-19 | {4313}    |
| ANH_123_Berlese1_2021-07-05/2021-07-11 | {4092}    |

Displaying records 1 - 50

</div>

Para colémbolos y hormigas, la anh 373 se vuelve 403 (ver rawdata.Rmd)

``` sql
UPDATE raw_dwc.corr_coord_cole
SET event_id=REGEXP_REPLACE(event_id,'373','403')
WHERE event_id ~ '373'
RETURNING event_id
;
```

``` sql
SELECT c.event_id,ARRAY_AGG(e.cd_event)
FROM raw_dwc.corr_coord_cole c
LEFT JOIN main.event e ON 'cole_'||c.event_id=e.event_id
GROUP BY c.event_id
```

<div class="knitsql-table">

| event_id                               | array_agg |
|:---------------------------------------|:----------|
| ANH_370_Pitfall6_2022-03-28/2022-03-30 | {4775}    |
| ANH_123_Pitfall1_2021-07-05/2021-07-07 | {4098}    |
| ANH_369_Berlese5_2021-07-07/2021-07-13 | {4276}    |
| ANH_370_Pitfall4_2022-03-28/2022-03-30 | {4773}    |
| ANH_370_Berlese6_2022-03-28/2022-04-03 | {4769}    |
| ANH_369_Pitfall1_2022-03-24/2022-03-26 | {4758}    |
| ANH_366_Berlese5_2021-07-06/2021-07-12 | {4252}    |
| ANH_372_Berlese2_2021-07-13/2021-07-19 | {4309}    |
| ANH_403_Pitfall2_2021-07-13/2021-07-15 | {4351}    |
| ANH_371_Pitfall2_2021-07-08/2021-07-12 | {4303}    |
| ANH_108_Pitfall6_2021-07-13/2021-07-15 | {3971}    |
| ANH_134_Pitfall3_2022-03-22/2022-03-24 | {4640}    |
| ANH_134_Berlese6_2021-07-05/2021-07-11 | {4157}    |
| ANH_403_Pitfall1_2022-03-31/2022-04-02 | {4830}    |
| ANH_130_Pitfall2_2022-03-29/2022-03-31 | {4603}    |
| ANH_115_Berlese1_2021-07-02/2021-07-08 | {4020}    |
| ANH_110_Berlese1_2021-07-14/2021-07-20 | {3972}    |
| ANH_369_Berlese1_2022-03-24/2022-03-30 | {4752}    |
| ANH_134_Pitfall5_2021-07-05/2021-07-07 | {4162}    |
| ANH_133_Berlese1_2021-07-05/2021-07-11 | {3900}    |
| ANH_142_Berlese5_2022-03-31/2022-04-06 | {4672}    |
| ANH_134_Berlese2_2022-03-22/2022-03-28 | {4633}    |
| ANH_368_Pitfall5_2021-07-07/2021-07-09 | {4270}    |
| ANH_369_Pitfall5_2021-07-07/2021-07-09 | {4282}    |
| ANH_372_Pitfall1_2021-07-13/2021-07-15 | {4314}    |
| ANH_370_Berlese5_2022-03-28/2022-04-03 | {4768}    |
| ANH_369_Pitfall6_2021-07-07/2021-07-09 | {4283}    |
| ANH_368_Pitfall2_2021-07-07/2021-07-09 | {4267}    |
| ANH_133_Berlese1_2022-03-22/2022-03-28 | {4380}    |
| ANH_130_Pitfall1_2022-03-29/2022-03-31 | {4602}    |
| ANH_130_Berlese4_2022-03-29/2022-04-04 | {4599}    |
| ANH_134_Berlese4_2021-07-05/2021-07-11 | {4155}    |
| ANH_371_Berlese1_2021-07-08/2021-07-14 | {4296}    |
| ANH_110_Pitfall1_2021-07-14/2021-07-16 | {3978}    |
| ANH_134_Pitfall5_2022-03-22/2022-03-24 | {4642}    |
| ANH_372_Pitfall3_2021-07-13/2021-07-15 | {4316}    |
| ANH_130_Pitfall6_2022-03-29/2022-03-31 | {4607}    |
| ANH_368_Pitfall1_2021-07-07/2021-07-09 | {4266}    |
| ANH_134_Berlese3_2022-03-22/2022-03-28 | {4634}    |
| ANH_366_Pitfall5_2021-07-06/2021-07-08 | {4258}    |
| ANH_371_Berlese3_2021-07-08/2021-07-14 | {4298}    |
| ANH_371_Pitfall4_2021-07-08/2021-07-12 | {4305}    |
| ANH_130_Pitfall5_2022-03-29/2022-03-31 | {4606}    |
| ANH_403_Berlese2_2021-07-13/2021-07-19 | {4345}    |
| ANH_370_Pitfall3_2022-03-28/2022-03-30 | {4772}    |
| ANH_368_Berlese2_2021-07-07/2021-07-13 | {4261}    |
| ANH_372_Berlese4_2022-03-24/2022-03-30 | {4791}    |
| ANH_372_Berlese6_2021-07-13/2021-07-19 | {4313}    |
| ANH_123_Berlese1_2021-07-05/2021-07-11 | {4092}    |
| ANH_368_Berlese3_2021-07-07/2021-07-13 | {4262}    |

Displaying records 1 - 50

</div>

``` sql
WITH a AS(
SELECT 
'cole_'||event_id event_id,
ST_SetSrid(ST_transform(
     ST_SetSrid(ST_MakePoint(decimal_lon,decimal_lat),4326)
,(SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)),3116) geom
FROM raw_dwc.corr_coord_cole 
)
UPDATE main.event AS e
SET pt_geom=a.geom
FROM a
WHERE a.event_id=e.event_id
RETURNING e.event_id, ST_X(pt_geom),ST_Y(pt_geom)
```

<div class="knitsql-table">

| event_id                                    |    st_x |    st_y |
|:--------------------------------------------|--------:|--------:|
| cole_ANH_142_Berlese6_2021-07-13/2021-07-19 | 1033016 | 1300714 |
| cole_ANH_142_Pitfall6_2021-07-13/2021-07-15 | 1033016 | 1300714 |
| cole_ANH_142_Berlese4_2022-03-31/2022-04-06 | 1033014 | 1300736 |
| cole_ANH_142_Berlese5_2022-03-31/2022-04-06 | 1033009 | 1300741 |
| cole_ANH_142_Pitfall4_2022-03-31/2022-04-02 | 1033014 | 1300736 |
| cole_ANH_142_Pitfall5_2022-03-31/2022-04-02 | 1033009 | 1300741 |
| cole_ANH_366_Berlese5_2021-07-06/2021-07-12 | 1034424 | 1305198 |
| cole_ANH_366_Berlese6_2021-07-06/2021-07-12 | 1034429 | 1305198 |
| cole_ANH_366_Pitfall5_2021-07-06/2021-07-08 | 1034424 | 1305198 |
| cole_ANH_366_Pitfall6_2021-07-06/2021-07-08 | 1034429 | 1305198 |
| cole_ANH_369_Berlese5_2021-07-07/2021-07-13 | 1029754 | 1314080 |
| cole_ANH_369_Berlese6_2021-07-07/2021-07-13 | 1029757 | 1314095 |
| cole_ANH_369_Pitfall5_2021-07-07/2021-07-09 | 1029754 | 1314080 |
| cole_ANH_369_Pitfall6_2021-07-07/2021-07-09 | 1029757 | 1314095 |
| cole_ANH_369_Berlese1_2022-03-24/2022-03-30 | 1029772 | 1314063 |
| cole_ANH_369_Pitfall1_2022-03-24/2022-03-26 | 1029772 | 1314063 |
| cole_ANH_110_Berlese1_2021-07-14/2021-07-20 | 1023809 | 1310898 |
| cole_ANH_110_Pitfall1_2021-07-14/2021-07-16 | 1023809 | 1310898 |
| cole_ANH_130_Berlese1_2022-03-29/2022-04-04 | 1023725 | 1316761 |
| cole_ANH_130_Berlese2_2022-03-29/2022-04-04 | 1023729 | 1316775 |
| cole_ANH_130_Berlese3_2022-03-29/2022-04-04 | 1023728 | 1316791 |
| cole_ANH_130_Berlese4_2022-03-29/2022-04-04 | 1023730 | 1316800 |
| cole_ANH_130_Berlese5_2022-03-29/2022-04-04 | 1023731 | 1316814 |
| cole_ANH_130_Berlese6_2022-03-29/2022-04-04 | 1023728 | 1316828 |
| cole_ANH_130_Pitfall1_2022-03-29/2022-03-31 | 1023725 | 1316761 |
| cole_ANH_130_Pitfall2_2022-03-29/2022-03-31 | 1023729 | 1316775 |
| cole_ANH_130_Pitfall3_2022-03-29/2022-03-31 | 1023728 | 1316791 |
| cole_ANH_130_Pitfall4_2022-03-29/2022-03-31 | 1023730 | 1316800 |
| cole_ANH_130_Pitfall5_2022-03-29/2022-03-31 | 1023731 | 1316814 |
| cole_ANH_130_Pitfall6_2022-03-29/2022-03-31 | 1023728 | 1316828 |
| cole_ANH_134_Berlese4_2021-07-05/2021-07-11 | 1024273 | 1294769 |
| cole_ANH_134_Berlese5_2021-07-05/2021-07-11 | 1024285 | 1294763 |
| cole_ANH_134_Berlese6_2021-07-05/2021-07-11 | 1024282 | 1294760 |
| cole_ANH_134_Pitfall4_2021-07-05/2021-07-07 | 1024273 | 1294769 |
| cole_ANH_134_Pitfall5_2021-07-05/2021-07-07 | 1024285 | 1294763 |
| cole_ANH_134_Pitfall6_2021-07-05/2021-07-07 | 1024282 | 1294760 |
| cole_ANH_134_Berlese2_2022-03-22/2022-03-28 | 1024331 | 1294838 |
| cole_ANH_134_Berlese3_2022-03-22/2022-03-28 | 1024337 | 1294826 |
| cole_ANH_134_Berlese4_2022-03-22/2022-03-28 | 1024348 | 1294816 |
| cole_ANH_134_Berlese5_2022-03-22/2022-03-28 | 1024359 | 1294801 |
| cole_ANH_134_Berlese6_2022-03-22/2022-03-28 | 1024366 | 1294795 |
| cole_ANH_134_Pitfall2_2022-03-22/2022-03-24 | 1024331 | 1294838 |
| cole_ANH_134_Pitfall3_2022-03-22/2022-03-24 | 1024337 | 1294826 |
| cole_ANH_134_Pitfall4_2022-03-22/2022-03-24 | 1024348 | 1294816 |
| cole_ANH_134_Pitfall5_2022-03-22/2022-03-24 | 1024359 | 1294801 |
| cole_ANH_134_Pitfall6_2022-03-22/2022-03-24 | 1024366 | 1294795 |
| cole_ANH_115_Berlese1_2021-07-02/2021-07-08 | 1027613 | 1299583 |
| cole_ANH_115_Berlese2_2021-07-02/2021-07-08 | 1027604 | 1299580 |
| cole_ANH_115_Pitfall1_2021-07-02/2021-07-04 | 1027613 | 1299583 |
| cole_ANH_115_Pitfall2_2021-07-02/2021-07-04 | 1027604 | 1299580 |

Displaying records 1 - 50

</div>

# 4 Cambiar las coordenadas de Hormigas

``` r
file <- "../../bpw_data_repo/Corrections/HormigasCambiar.xlsx"
corr <- read.xlsx(file)
colnames(corr) <- gsub("[().-]", "_", tolower(gsub("([a-z])([A-Z]+)", "\\1_\\L\\2",
    colnames(corr), perl = T)))
dbWriteTable(fracking_db, c("raw_dwc", "corr_coord_horm"), corr, overwrite = T)
```

    ## [1] TRUE

Averiguar que los event_id correspondan:

``` sql
SELECT c.event_id,ARRAY_AGG(e.cd_event)
FROM raw_dwc.corr_coord_horm c
LEFT JOIN main.event e ON c.event_id=e.event_id
GROUP BY c.event_id
```

<div class="knitsql-table">

| event_id                                            | array_agg |
|:----------------------------------------------------|:----------|
| ANH_130_Winkler1_2022-03-29/2022-03-31              | {2513}    |
| ANH_123_Pitfall1_2021-07-05/2021-07-07              | {1458}    |
| ANH_123_Winkler2_2021-07-05/2021-07-07              | {1464}    |
| ANH_115_Captura manual5_2022-03-21                  | {2303}    |
| ANH_130_Captura manual9_2021-07-12                  | {1507}    |
| ANH_122_Trampa de caída atún5_2022-03-29/2022-03-31 | {2447}    |
| ANH_136_Winkler5_2022-03-17/2022-03-19              | {2117}    |
| ANH_142_Captura manual5_2022-03-31                  | {2653}    |
| ANH_373_Pitfall2_2021-07-13/2021-07-15              | {NULL}    |
| ANH_122_Winkler3_2021-07-12/2021-07-14              | {1440}    |
| ANH_371_Captura manual2_2021-07-08                  | {1875}    |
| ANH_130_Pitfall5_2021-07-12/2021-07-14              | {1512}    |
| ANH_122_Captura manual4_2022-03-29                  | {2427}    |
| ANH_373_Pitfall1_2022-03-31/2022-04-02              | {NULL}    |
| ANH_134_Pitfall3_2022-03-22/2022-03-24              | {2585}    |
| ANH_142_Winkler4_2021-07-13/2021-07-15              | {1666}    |
| ANH_134_Trampa de caída atún4_2022-03-22/2022-03-24 | {2596}    |
| ANH_115_Winkler2_2021-07-02/2021-07-04              | {1314}    |
| ANH_369_Winkler5_2021-07-07/2021-07-09              | {1842}    |
| ANH_130_Captura manual3_2022-03-29                  | {2501}    |
| ANH_122_Winkler2_2021-07-12/2021-07-14              | {1439}    |
| ANH_142_Trampa de caída atún1_2021-07-13/2021-07-15 | {1668}    |
| ANH_130_Pitfall4_2021-07-12/2021-07-14              | {1511}    |
| ANH_134_Captura manual5_2022-03-22                  | {2578}    |
| ANH_142_Captura manual4_2021-07-13                  | {1652}    |
| ANH_115_Trampa de caída atún2_2021-07-02/2021-07-04 | {1319}    |
| ANH_110_Pitfall1_2021-07-14/2021-07-16              | {1208}    |
| ANH_371_Captura manual3_2021-07-08                  | {1876}    |
| ANH_134_Winkler4_2022-03-22/2022-03-24              | {2591}    |
| ANH_130_Pitfall3_2021-07-12/2021-07-14              | {1510}    |
| ANH_115_Captura manual5_2021-07-02                  | {1303}    |
| ANH_134_Pitfall5_2022-03-22/2022-03-24              | {2587}    |
| ANH_372_Pitfall3_2021-07-13/2021-07-15              | {1910}    |
| ANH_130_Captura manual8_2022-03-29                  | {2506}    |
| ANH_133_Winkler1_2021-07-05/2021-07-07              | {1063}    |
| ANH_366_Captura manual4_2021-07-06                  | {1777}    |
| ANH_373_Winkler2_2022-03-31/2022-04-02              | {NULL}    |
| ANH_130_Captura manual2_2022-03-29                  | {2500}    |
| ANH_370_Captura manual9_2021-07-08                  | {1857}    |
| ANH_123_Captura manual3_2021-07-05                  | {1451}    |
| ANH_371_Pitfall4_2021-07-08/2021-07-12              | {1886}    |
| ANH_115_Captura manual9_2021-07-02                  | {1307}    |
| ANH_136_Winkler5_2021-07-01/2021-07-03              | {1117}    |
| ANH_130_Pitfall5_2022-03-29/2022-03-31              | {2512}    |
| ANH_115_Trampa de caída atún4_2021-07-02/2021-07-04 | {1321}    |
| ANH_122_Captura manual3_2021-07-12                  | {1426}    |
| ANH_136_Trampa de caída atún1_2021-07-01/2021-07-03 | {1118}    |
| ANH_130_Winkler3_2021-07-12/2021-07-14              | {1515}    |
| ANH_130_Trampa de caída atún3_2021-07-12/2021-07-14 | {1520}    |
| ANH_130_Captura manual2_2021-07-12                  | {1500}    |

Displaying records 1 - 50

</div>

Para colémbolos y hormigas, la anh 373 se vuelve 403 (ver rawdata.Rmd)

``` sql
UPDATE raw_dwc.corr_coord_horm
SET event_id=REGEXP_REPLACE(event_id,'373','403')
WHERE event_id ~ '373'
RETURNING event_id
;
```

``` sql
SELECT c.event_id,ARRAY_AGG(e.cd_event)
FROM raw_dwc.corr_coord_horm c
LEFT JOIN main.event e ON c.event_id=e.event_id
GROUP BY c.event_id
```

<div class="knitsql-table">

| event_id                                            | array_agg |
|:----------------------------------------------------|:----------|
| ANH_130_Winkler1_2022-03-29/2022-03-31              | {2513}    |
| ANH_123_Pitfall1_2021-07-05/2021-07-07              | {1458}    |
| ANH_123_Winkler2_2021-07-05/2021-07-07              | {1464}    |
| ANH_115_Captura manual5_2022-03-21                  | {2303}    |
| ANH_130_Captura manual9_2021-07-12                  | {1507}    |
| ANH_122_Trampa de caída atún5_2022-03-29/2022-03-31 | {2447}    |
| ANH_136_Winkler5_2022-03-17/2022-03-19              | {2117}    |
| ANH_142_Captura manual5_2022-03-31                  | {2653}    |
| ANH_122_Winkler3_2021-07-12/2021-07-14              | {1440}    |
| ANH_403_Pitfall2_2021-07-13/2021-07-15              | {1984}    |
| ANH_371_Captura manual2_2021-07-08                  | {1875}    |
| ANH_130_Pitfall5_2021-07-12/2021-07-14              | {1512}    |
| ANH_122_Captura manual4_2022-03-29                  | {2427}    |
| ANH_134_Pitfall3_2022-03-22/2022-03-24              | {2585}    |
| ANH_142_Winkler4_2021-07-13/2021-07-15              | {1666}    |
| ANH_403_Pitfall1_2022-03-31/2022-04-02              | {2983}    |
| ANH_134_Trampa de caída atún4_2022-03-22/2022-03-24 | {2596}    |
| ANH_115_Winkler2_2021-07-02/2021-07-04              | {1314}    |
| ANH_369_Winkler5_2021-07-07/2021-07-09              | {1842}    |
| ANH_130_Captura manual3_2022-03-29                  | {2501}    |
| ANH_122_Winkler2_2021-07-12/2021-07-14              | {1439}    |
| ANH_142_Trampa de caída atún1_2021-07-13/2021-07-15 | {1668}    |
| ANH_130_Pitfall4_2021-07-12/2021-07-14              | {1511}    |
| ANH_134_Captura manual5_2022-03-22                  | {2578}    |
| ANH_142_Captura manual4_2021-07-13                  | {1652}    |
| ANH_115_Trampa de caída atún2_2021-07-02/2021-07-04 | {1319}    |
| ANH_110_Pitfall1_2021-07-14/2021-07-16              | {1208}    |
| ANH_371_Captura manual3_2021-07-08                  | {1876}    |
| ANH_134_Winkler4_2022-03-22/2022-03-24              | {2591}    |
| ANH_130_Pitfall3_2021-07-12/2021-07-14              | {1510}    |
| ANH_115_Captura manual5_2021-07-02                  | {1303}    |
| ANH_134_Pitfall5_2022-03-22/2022-03-24              | {2587}    |
| ANH_372_Pitfall3_2021-07-13/2021-07-15              | {1910}    |
| ANH_130_Captura manual8_2022-03-29                  | {2506}    |
| ANH_133_Winkler1_2021-07-05/2021-07-07              | {1063}    |
| ANH_366_Captura manual4_2021-07-06                  | {1777}    |
| ANH_403_Trampa de caída atún2_2022-03-31/2022-04-02 | {2994}    |
| ANH_130_Captura manual2_2022-03-29                  | {2500}    |
| ANH_370_Captura manual9_2021-07-08                  | {1857}    |
| ANH_123_Captura manual3_2021-07-05                  | {1451}    |
| ANH_371_Pitfall4_2021-07-08/2021-07-12              | {1886}    |
| ANH_115_Captura manual9_2021-07-02                  | {1307}    |
| ANH_136_Winkler5_2021-07-01/2021-07-03              | {1117}    |
| ANH_130_Pitfall5_2022-03-29/2022-03-31              | {2512}    |
| ANH_115_Trampa de caída atún4_2021-07-02/2021-07-04 | {1321}    |
| ANH_122_Captura manual3_2021-07-12                  | {1426}    |
| ANH_136_Trampa de caída atún1_2021-07-01/2021-07-03 | {1118}    |
| ANH_130_Winkler3_2021-07-12/2021-07-14              | {1515}    |
| ANH_130_Trampa de caída atún3_2021-07-12/2021-07-14 | {1520}    |
| ANH_130_Captura manual2_2021-07-12                  | {1500}    |

Displaying records 1 - 50

</div>

``` sql
WITH a AS(
SELECT 
event_id event_id,
ST_SetSrid(ST_transform(
     ST_SetSrid(ST_MakePoint(decimal_lon,decimal_lat),4326)
,(SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)),3116) geom
FROM raw_dwc.corr_coord_horm
)
UPDATE main.event AS e
SET pt_geom=a.geom
FROM a
WHERE a.event_id=e.event_id
RETURNING e.event_id, ST_X(pt_geom),ST_Y(pt_geom)
```

<div class="knitsql-table">

| event_id                                            |    st_x |    st_y |
|:----------------------------------------------------|--------:|--------:|
| ANH_142_Captura manual2_2021-07-13                  | 1033020 | 1300753 |
| ANH_142_Captura manual3_2021-07-13                  | 1033027 | 1300738 |
| ANH_142_Captura manual4_2021-07-13                  | 1033027 | 1300736 |
| ANH_142_Captura manual5_2021-07-13                  | 1033027 | 1300737 |
| ANH_142_Trampa de caída atún1_2021-07-13/2021-07-15 | 1033025 | 1300741 |
| ANH_142_Trampa de caída atún5_2021-07-13/2021-07-15 | 1033016 | 1300746 |
| ANH_142_Winkler1_2021-07-13/2021-07-15              | 1033025 | 1300741 |
| ANH_142_Winkler2_2021-07-13/2021-07-15              | 1033020 | 1300753 |
| ANH_142_Winkler3_2021-07-13/2021-07-15              | 1033025 | 1300741 |
| ANH_142_Winkler4_2021-07-13/2021-07-15              | 1033009 | 1300740 |
| ANH_142_Winkler5_2021-07-13/2021-07-15              | 1033010 | 1300742 |
| ANH_142_Captura manual5_2022-03-31                  | 1033029 | 1300735 |
| ANH_142_Trampa de caída atún5_2022-03-31/2022-04-02 | 1033029 | 1300735 |
| ANH_142_Winkler5_2022-03-31/2022-04-02              | 1033029 | 1300735 |
| ANH_142_Captura manual10_2022-03-31                 | 1033023 | 1300745 |
| ANH_142_Pitfall4_2022-03-31/2022-04-02              | 1033023 | 1300745 |
| ANH_142_Pitfall5_2022-03-31/2022-04-02              | 1033021 | 1300749 |
| ANH_366_Captura manual1_2021-07-06                  | 1034348 | 1305184 |
| ANH_366_Captura manual3_2021-07-06                  | 1034327 | 1305209 |
| ANH_366_Captura manual4_2021-07-06                  | 1034325 | 1305200 |
| ANH_366_Pitfall1_2021-07-06/2021-07-08              | 1034348 | 1305184 |
| ANH_366_Pitfall3_2021-07-06/2021-07-08              | 1034327 | 1305209 |
| ANH_366_Pitfall4_2021-07-06/2021-07-08              | 1034325 | 1305200 |
| ANH_366_Winkler1_2021-07-06/2021-07-08              | 1034348 | 1305184 |
| ANH_366_Winkler3_2021-07-06/2021-07-08              | 1034327 | 1305209 |
| ANH_366_Winkler4_2021-07-06/2021-07-08              | 1034325 | 1305200 |
| ANH_369_Captura manual5_2021-07-07                  | 1029753 | 1314080 |
| ANH_369_Pitfall5_2021-07-07/2021-07-09              | 1029753 | 1314080 |
| ANH_369_Trampa de caída atún5_2021-07-07/2021-07-09 | 1029753 | 1314080 |
| ANH_369_Winkler5_2021-07-07/2021-07-09              | 1029753 | 1314080 |
| ANH_110_Pitfall1_2021-07-14/2021-07-16              | 1023811 | 1310897 |
| ANH_122_Captura manual1_2021-07-12                  | 1027905 | 1312578 |
| ANH_122_Captura manual4_2021-07-12                  | 1027905 | 1312578 |
| ANH_122_Captura manual2_2021-07-12                  | 1027879 | 1312515 |
| ANH_122_Captura manual3_2021-07-12                  | 1027880 | 1312505 |
| ANH_122_Trampa de caída atún1_2021-07-12/2021-07-14 | 1027905 | 1312578 |
| ANH_122_Winkler2_2021-07-12/2021-07-14              | 1027879 | 1312515 |
| ANH_122_Winkler3_2021-07-12/2021-07-14              | 1027880 | 1312505 |
| ANH_122_Winkler4_2021-07-12/2021-07-14              | 1027876 | 1312488 |
| ANH_122_Winkler4_2022-03-29/2022-03-31              | 1027881 | 1312532 |
| ANH_122_Winkler5_2022-03-29/2022-03-31              | 1027871 | 1312540 |
| ANH_122_Trampa de caída atún4_2022-03-29/2022-03-31 | 1027881 | 1312532 |
| ANH_122_Trampa de caída atún5_2022-03-29/2022-03-31 | 1027871 | 1312540 |
| ANH_122_Captura manual4_2022-03-29                  | 1027881 | 1312532 |
| ANH_122_Captura manual5_2022-03-29                  | 1027871 | 1312540 |
| ANH_117_Captura manual2_2021-07-06                  | 1031581 | 1311143 |
| ANH_130_Captura manual1_2021-07-12                  | 1023737 | 1316761 |
| ANH_130_Captura manual2_2021-07-12                  | 1023738 | 1316777 |
| ANH_130_Captura manual3_2021-07-12                  | 1023751 | 1316802 |
| ANH_130_Captura manual4_2021-07-12                  | 1023737 | 1316800 |

Displaying records 1 - 50

</div>

# 5 Cambio coordenadas mamiferos

``` r
file <- "../../bpw_data_repo/Corrections/MamiferosCambiar.xlsx"
corr <- read.xlsx(file)
colnames(corr) <- gsub("[().-]", "_", tolower(gsub("([a-z])([A-Z]+)", "\\1_\\L\\2",
    colnames(corr), perl = T)))
dbWriteTable(fracking_db, c("raw_dwc", "corr_coord_mami"), corr, overwrite = T)
```

    ## [1] TRUE

Averiguar que los event_id correspondan:

``` sql
SELECT c.event_id,ARRAY_AGG(e.cd_event)
FROM raw_dwc.corr_coord_mami c
LEFT JOIN main.event e ON c.event_id=e.event_id
GROUP BY c.event_id
```

<div class="knitsql-table">

| event_id        | array_agg |
|:----------------|:----------|
| ANH_88_M_S3     | {6883}    |
| ANH_72_M_R02_T2 | {7727}    |
| ANH_94_M_S22    | {7157}    |
| ANH_78_M_S13    | {6789}    |
| ANH_72_M_S52    | {6602}    |
| ANH_72_M_S31    | {6579}    |
| ANH_88_M_S50    | {6906}    |
| ANH_94_M_S64    | {7203}    |
| ANH_92_M_S38    | {6233}    |
| ANH_72_M_S62    | {6613}    |
| ANH_94_M_S62    | {7201}    |
| ANH_72_M_S10    | {6556}    |
| ANH_72_M_S19    | {6565}    |
| ANH_96_M_R09_T2 | {7625}    |
| ANH_72_M_R15    | {6541}    |
| ANH_97_M_R02_T2 | {7882}    |
| ANH_88_M_S11    | {6863}    |
| ANH_94_M_S2     | {7154}    |
| ANH_94_M_S35    | {7171}    |
| ANH_72_M_S38    | {6586}    |
| ANH_94_M_S70    | {7210}    |
| ANH_94_M_S21    | {7156}    |
| ANH_100_M_S22   | {5902}    |
| ANH_72_M_S42    | {6591}    |
| ANH_97_M_R15    | {7289}    |
| ANH_88_M_S43    | {6898}    |
| ANH_78_M_R155   | {6769}    |
| ANH_94_M_S49    | {7186}    |
| ANH_88_M_S46    | {6901}    |
| ANH_72_M_S25    | {6572}    |
| ANH_94_M_S65    | {7204}    |
| ANH_72_M_R19    | {6545}    |
| ANH_71_M_R7     | {6532}    |
| ANH_98_M_R81    | {7307}    |
| ANH_96_M_S64    | {6357}    |
| ANH_78_M_S1     | {6785}    |
| ANH_75_M_R19_T2 | {7790}    |
| ANH_75_M_R04_T2 | {7775}    |
| ANH_78_M_R161   | {6775}    |
| ANH_72_M_R10_T2 | {7735}    |
| ANH_72_M_R6     | {6551}    |
| ANH_93_M_R16_T2 | {7873}    |
| ANH_88_M_S42    | {6897}    |
| ANH_78_M_S8     | {6853}    |
| ANH_94_M_S42    | {7179}    |
| ANH_72_M_R11    | {6537}    |
| ANH_71_M_R10    | {6516}    |
| ANH_72_M_R8     | {6553}    |
| ANH_88_M_S48    | {6903}    |
| ANH_90_M_R118   | {7040}    |

Displaying records 1 - 50

</div>

``` sql
WITH a AS(
SELECT 
event_id event_id,
ST_SetSrid(ST_transform(
     ST_SetSrid(ST_MakePoint(decimal_lon,decimal_lat),4326)
,(SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)),3116) geom
FROM raw_dwc.corr_coord_mami
)
UPDATE main.event AS e
SET pt_geom=a.geom
FROM a
WHERE a.event_id=e.event_id
RETURNING e.event_id, ST_X(pt_geom),ST_Y(pt_geom)
```

<div class="knitsql-table">

| event_id        |    st_x |    st_y |
|:----------------|--------:|--------:|
| ANH_74_M_R17    | 1030071 | 1308697 |
| ANH_88_M_S10    | 1030839 | 1306351 |
| ANH_88_M_S11    | 1030822 | 1306309 |
| ANH_88_M_S12    | 1030810 | 1306304 |
| ANH_88_M_S13    | 1030815 | 1306291 |
| ANH_88_M_S14    | 1030807 | 1306289 |
| ANH_88_M_S15    | 1030817 | 1306281 |
| ANH_88_M_S16    | 1030809 | 1306279 |
| ANH_88_M_S17    | 1030823 | 1306283 |
| ANH_88_M_S18    | 1030810 | 1306260 |
| ANH_88_M_S19    | 1030819 | 1306262 |
| ANH_88_M_S20    | 1030816 | 1306255 |
| ANH_88_M_S3     | 1030830 | 1306262 |
| ANH_88_M_S37    | 1030791 | 1306242 |
| ANH_88_M_S38    | 1030794 | 1306259 |
| ANH_88_M_S39    | 1030794 | 1306278 |
| ANH_88_M_S4     | 1030828 | 1306286 |
| ANH_88_M_S40    | 1030780 | 1306278 |
| ANH_88_M_S41    | 1030782 | 1306249 |
| ANH_88_M_S43    | 1030777 | 1306229 |
| ANH_88_M_S5     | 1030830 | 1306296 |
| ANH_88_M_S56    | 1030764 | 1306209 |
| ANH_88_M_S57    | 1030765 | 1306222 |
| ANH_88_M_S58    | 1030763 | 1306228 |
| ANH_88_M_S59    | 1030765 | 1306241 |
| ANH_88_M_S6     | 1030828 | 1306314 |
| ANH_88_M_S60    | 1030769 | 1306248 |
| ANH_88_M_S61    | 1030752 | 1306239 |
| ANH_88_M_S62    | 1030749 | 1306232 |
| ANH_88_M_S63    | 1030748 | 1306225 |
| ANH_88_M_S64    | 1030748 | 1306214 |
| ANH_88_M_S65    | 1030748 | 1306207 |
| ANH_88_M_S7     | 1030833 | 1306325 |
| ANH_88_M_S8     | 1030826 | 1306334 |
| ANH_88_M_S9     | 1030837 | 1306334 |
| ANH_74_M_R05_T2 | 1029594 | 1308665 |
| ANH_88_M_S1     | 1030831 | 1306238 |
| ANH_88_M_S2     | 1030827 | 1306253 |
| ANH_88_M_S21    | 1030810 | 1306247 |
| ANH_88_M_S22    | 1030819 | 1306244 |
| ANH_88_M_S23    | 1030816 | 1306236 |
| ANH_88_M_S24    | 1030808 | 1306236 |
| ANH_88_M_S25    | 1030810 | 1306219 |
| ANH_88_M_S26    | 1030812 | 1306217 |
| ANH_88_M_S27    | 1030816 | 1306216 |
| ANH_88_M_S28    | 1030813 | 1306207 |
| ANH_88_M_S29    | 1030820 | 1306205 |
| ANH_88_M_S30    | 1030812 | 1306198 |
| ANH_88_M_S31    | 1030795 | 1306185 |
| ANH_88_M_S32    | 1030793 | 1306192 |

Displaying records 1 - 50

</div>

# 6 Change date for ANH_18 for perifiton

``` sql
SELECT 
  cd_gp_biol,event_id,r.date_time,e.date_time_begin,e.date_time_end 
FROM main.registros r 
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref) 
WHERE 
  num_anh=18 
  AND EXTRACT (YEAR FROM date_time_begin)=2021 
  AND event_id ~ 'Bajas' 
GROUP BY cd_gp_biol,event_id,r.date_time,e.date_time_begin,e.date_time_end;
```

<div class="knitsql-table">

| cd_gp_biol | event_id        | date_time | date_time_begin     | date_time_end |
|:-----------|:----------------|:----------|:--------------------|:--------------|
| peri       | ANH18-P-A-Bajas | NA        | 2021-07-23 09:30:00 | NA            |
| peri       | ANH18-P-B-Bajas | NA        | 2021-07-23 09:30:00 | NA            |
| peri       | ANH18-P-C-Bajas | NA        | 2021-07-23 09:30:00 | NA            |

3 records

</div>

``` sql
SELECT event_id, date_time_begin, date_time_end
FROM main.event e
WHERE event_id ~ 'ANH18-P-[ABC]-Bajas'
```

<div class="knitsql-table">

| event_id        | date_time_begin     | date_time_end |
|:----------------|:--------------------|:--------------|
| ANH18-P-A-Bajas | 2021-07-23 09:30:00 | NA            |
| ANH18-P-B-Bajas | 2021-07-23 09:30:00 | NA            |
| ANH18-P-C-Bajas | 2021-07-23 09:30:00 | NA            |

3 records

</div>

``` sql
UPDATE main.event
SET date_time_begin='2022-03-28 12:00:00'::timestamp
WHERE event_id ~ 'ANH18-P-[ABC]-Bajas'
RETURNING event_id, date_time_begin
```

# 7 Cambio coordenadas herpetos

**Mensajes de Francisco**:

Hola Marius te envio los cambios que te indicaba adri en el grupo de
herpetos quedo atento a cualquier inquietud de tu parte , te envio las
coordenadas del punto a cambiar y el shape de coberturas

Coordenadas Punto ANH_155_Herp_T1_D y ANH_155_Herp_T1_N Latitud 7,384132
Longitud -73,8468238 Punto ANH_155_Herp_T2_D y ANH_155_Herp_T2_N Latitud
7,385501 Longitud -73,847092

te envió las coordenadas faltantes: Coordenadas Punto ANH_155_Herp_T1_D
y ANH_155_Herp_T1_N Latitud Inicial 7,384603 y Latitud Final 7,384
Longitud Inicial -73,846838 y Longitud Final -73,847 Punto
ANH_155_Herp_T2_D y ANH_155_Herp_T2_N Latitud Inicial 7,385203 y Latitud
Final 7,3869 Longitud Inicial -73,846838 y Longitud Final -73,84709

``` sql
SELECT *
FROM main.event WHERE event_id IN('ANH_155_Herp_T1_D','ANH_155_Herp_T1_N','ANH_155_Herp_T2_D','ANH_155_Herp_T2_N')
```

<div class="knitsql-table">

| cd_event | event_id          | cd_gp_event | num_replicate | description_replicate             | date_time_begin     | date_time_end       | locality_verb | samp_effort_1 | samp_effort_2 | event_remarks                                             | cds_creator | created | pt_geom | li_geom                                                                                                                    | pol_geom |
|:---------|:------------------|------------:|--------------:|:----------------------------------|:--------------------|:--------------------|:--------------|--------------:|--------------:|:----------------------------------------------------------|:------------|:--------|:--------|:---------------------------------------------------------------------------------------------------------------------------|:---------|
| 173      | ANH_155_Herp_T1_D |          30 |             1 | Transect:1\|Jornada:D\|Campaign:1 | 2021-07-16 15:27:00 | 2021-07-16 16:20:00 | NA            |           193 |            NA | Soleado \|\| Soleado \| No hay registro de individuos     | NA          | NA      | NA      | 01020000202C0C000003000000D4908F23754B2F4166A02E54ADF63341843EFBD51C4B2F412936FF649AF63341A4BEF39D0B4B2F417B8763B56BF63341 | NA       |
| 174      | ANH_155_Herp_T1_N |          30 |             2 | Transect:1\|Jornada:N\|Campaign:1 | 2021-07-16 19:00:00 | 2021-07-16 19:50:00 | NA            |           193 |            NA | Despejado                                                 | NA          | NA      | NA      | 01020000202C0C000003000000D4908F23754B2F4166A02E54ADF63341843EFBD51C4B2F412936FF649AF63341A4BEF39D0B4B2F417B8763B56BF63341 | NA       |
| 175      | ANH_155_Herp_T2_D |          30 |             3 | Transect:2\|Jornada:D\|Campaign:1 | 2021-07-16 16:45:00 | 2021-07-16 17:23:00 | NA            |           156 |            NA | Soleado \| No hay registro de individuos                  | NA          | NA      | NA      | 01020000202C0C0000030000003DA53009754B2F412455ECDC10F73341358284C1104B2F41BFF33ECB31F73341B1298E32F74A2F411273046A67F73341 | NA       |
| 176      | ANH_155_Herp_T2_N |          30 |             4 | Transect:2\|Jornada:N\|Campaign:1 | 2021-07-16 20:15:00 | 2021-07-16 21:04:00 | NA            |           156 |            NA | Despejado \|\| Despejado \| No hay registro de individuos | NA          | NA      | NA      | 01020000202C0C0000030000003DA53009754B2F412455ECDC10F73341358284C1104B2F41BFF33ECB31F73341B1298E32F74A2F411273046A67F73341 | NA       |

4 records

</div>

``` sql
WITH a AS(
SELECT
 ST_SetSRID(ST_transform(
   ST_MakeLine(ARRAY[
     ST_SetSRID(ST_MakePoint(-73.846838, 7.385203),4326),
     ST_SetSRID(ST_MakePoint(-73.847092, 7.385501),4326),
     ST_SetSRID(ST_MakePoint(-73.84709,7.3869),4326)
   ])
 , (SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)),3116) line
)

UPDATE main.event AS e
SET li_geom=a.line
FROM a
WHERE e.event_id IN ('ANH_155_Herp_T1_D','ANH_155_Herp_T1_N');

WITH a AS(
SELECT
 ST_SetSRID(ST_transform(
   ST_MakeLine(ARRAY[
     ST_SetSRID(ST_MakePoint(-73.846838, 7.384603),4326),
     ST_SetSRID(ST_MakePoint(-73.8468238, 7.384132),4326),
     ST_SetSRID(ST_MakePoint(-73.847,7.384),4326)
   ])
 , (SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)),3116) line
)

UPDATE main.event AS e
SET li_geom=a.line
FROM a
WHERE e.event_id IN ('ANH_155_Herp_T2_D','ANH_155_Herp_T2_N')
RETURNING ST_Length(li_geom);
```

<div class="knitsql-table">

| st_length |
|----------:|
|  76.43458 |
|  76.43458 |

2 records

</div>

# 8 Cambiar coordenadas de mariposas

``` r
file <- "../../bpw_data_repo/Corrections/Mariposas2023.xlsx"
corr <- read.xlsx(file)
colnames(corr) <- gsub("[().-]", "_", tolower(gsub("([a-z])([A-Z]+)", "\\1_\\L\\2",
    colnames(corr), perl = T)))
dbWriteTable(fracking_db, c("raw_dwc", "corr_coord_mari"), corr, overwrite = T)
```

    ## [1] TRUE

Averiguar que los event_id correspondan:

``` sql
SELECT c.event_id,ARRAY_AGG(e.cd_event)
FROM raw_dwc.corr_coord_mari c
LEFT JOIN main.event e ON c.event_id=e.event_id
GROUP BY c.event_id
```

<div class="knitsql-table">

| event_id                                            | array_agg |
|:----------------------------------------------------|:----------|
| ANH_118_T. Van Someren-Rydon4_2022-04-04/2022-04-06 | {837}     |
| ANH_142_T. Van Someren-Rydon6_2021-07-13/2021-07-15 | {672}     |
| ANH_113_T. Van Someren-Rydon5_2021-07-16/2021-07-18 | {578}     |
| ANH_136_T. Van Someren-Rydon3_2022-03-21/2022-03-23 | {786}     |
| ANH_125_T. Van Someren-Rydon4_2022-04-07/2022-04-09 | {867}     |
| ANH_118_T. Van Someren-Rydon3_2021-07-15/2021-07-17 | {599}     |
| ANH_132_T. Van Someren-Rydon3_2021-07-05/2021-07-07 | {651}     |
| ANH_371_T. Van Someren-Rydon3_2022-03-28/2022-03-30 | {966}     |
| ANH_135_T. Van Someren-Rydon6_2021-07-01/2021-07-03 | {546}     |
| ANH_110_T. Van Someren-Rydon3_2022-04-04/2022-04-06 | {805}     |
| ANH_371_T. Van Someren-Rydon6_2022-03-28/2022-03-30 | {963}     |
| ANH_122_T. Van Someren-Rydon2_2022-03-31/2022-04-02 | {858}     |
| ANH_122_T. Van Someren-Rydon6_2021-07-15/2021-07-17 | {622}     |
| ANH_138_T. Van Someren-Rydon4_2021-07-08/2021-07-12 | {669}     |
| ANH_121_T. Van Someren-Rydon6_2022-04-05/2022-04-07 | {853}     |
| ANH_113_T. Van Someren-Rydon5_2022-04-04/2022-04-06 | {812}     |
| ANH_121_T. Van Someren-Rydon2_2022-04-05/2022-04-07 | {849}     |
| ANH_371_T. Van Someren-Rydon4_2022-03-28/2022-03-30 | {965}     |
| ANH_132_T. Van Someren-Rydon4_2021-07-05/2021-07-07 | {648}     |
| ANH_120_T. Van Someren-Rydon1_2022-03-31/2022-04-02 | {842}     |
| ANH_134_T. Van Someren-Rydon4_2022-03-22/2022-03-24 | {890}     |
| ANH_122_T. Van Someren-Rydon2_2021-07-15/2021-07-17 | {621}     |
| ANH_113_T. Van Someren-Rydon4_2022-04-04/2022-04-06 | {816}     |
| ANH_110_T. Van Someren-Rydon1_2021-07-15/2021-07-17 | {568}     |
| ANH_121_T. Van Someren-Rydon4_2021-07-22/2021-07-24 | {616}     |
| ANH_125_T. Van Someren-Rydon1_2022-04-07/2022-04-09 | {866}     |
| ANH_134_T. Van Someren-Rydon5_2021-07-05/2021-07-07 | {654}     |
| ANH_368_T. Van Someren-Rydon4_2022-04-04/2022-04-06 | {947}     |
| ANH_112_T. Van Someren-Rydon2_2021-07-12/2021-07-14 | {577}     |
| ANH_109_T. Van Someren-Rydon2_2022-04-05/2022-04-07 | {763}     |
| ANH_109_T. Van Someren-Rydon3_2021-07-15/2021-07-17 | {528}     |
| ANH_120_T. Van Someren-Rydon1_2021-07-16/2021-07-18 | {605}     |
| ANH_371_T. Van Someren-Rydon5_2022-03-28/2022-03-30 | {964}     |
| ANH_391_T. Van Someren-Rydon1_2022-03-17/2022-03-19 | {985}     |
| ANH_120_T. Van Someren-Rydon6_2021-07-16/2021-07-18 | {606}     |
| ANH_113_T. Van Someren-Rydon3_2021-07-16/2021-07-18 | {580}     |
| ANH_109_T. Van Someren-Rydon5_2021-07-15/2021-07-17 | {526}     |
| ANH_125_T. Van Someren-Rydon1_2021-07-12/2021-07-14 | {632}     |
| ANH_121_T. Van Someren-Rydon2_2021-07-22/2021-07-24 | {614}     |
| ANH_142_T. Van Someren-Rydon2_2022-03-31/2022-04-02 | {909}     |
| ANH_109_T. Van Someren-Rydon1_2021-07-15/2021-07-17 | {529}     |
| ANH_122_T. Van Someren-Rydon4_2022-03-31/2022-04-02 | {855}     |
| ANH_115_T. Van Someren-Rydon3_2022-04-05/2022-04-07 | {826}     |
| ANH_110_T. Van Someren-Rydon4_2021-07-15/2021-07-17 | {566}     |
| ANH_371_T. Van Someren-Rydon3_2021-07-08/2021-07-12 | {724}     |
| ANH_373_T. Van Someren-Rydon2_2021-07-22/2021-07-24 | {736}     |
| ANH_135_T. Van Someren-Rydon3_2021-07-01/2021-07-03 | {542}     |
| ANH_109_T. Van Someren-Rydon5_2022-04-05/2022-04-07 | {760}     |
| ANH_135_T. Van Someren-Rydon5_2021-07-01/2021-07-03 | {547}     |
| ANH_122_T. Van Someren-Rydon5_2022-03-31/2022-04-02 | {856}     |

Displaying records 1 - 50

</div>

``` sql
WITH a AS(
SELECT 
event_id event_id,
ST_SetSrid(ST_transform(
     ST_SetSrid(ST_MakePoint(decimal_lon,decimal_lat),4326)
,(SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)),3116) geom
FROM raw_dwc.corr_coord_mari
)
UPDATE main.event AS e
SET pt_geom=a.geom
FROM a
WHERE a.event_id=e.event_id
RETURNING e.event_id, ST_X(pt_geom),ST_Y(pt_geom)
```

<div class="knitsql-table">

| event_id                                            |    st_x |    st_y |
|:----------------------------------------------------|--------:|--------:|
| ANH_373_T. Van Someren-Rydon2_2021-07-22/2021-07-24 | 1031555 | 1300909 |
| ANH_142_T. Van Someren-Rydon2_2021-07-13/2021-07-15 | 1033002 | 1300764 |
| ANH_142_T. Van Someren-Rydon4_2021-07-13/2021-07-15 | 1033020 | 1300736 |
| ANH_142_T. Van Someren-Rydon2_2022-03-31/2022-04-02 | 1033003 | 1300765 |
| ANH_114_T. Van Someren-Rydon6_2021-07-06/2021-07-08 | 1034165 | 1304576 |
| ANH_110_T. Van Someren-Rydon1_2022-04-04/2022-04-06 | 1023809 | 1310937 |
| ANH_110_T. Van Someren-Rydon2_2022-04-04/2022-04-06 | 1023812 | 1310992 |
| ANH_110_T. Van Someren-Rydon3_2022-04-04/2022-04-06 | 1023816 | 1311076 |
| ANH_110_T. Van Someren-Rydon4_2022-04-04/2022-04-06 | 1023845 | 1311139 |
| ANH_110_T. Van Someren-Rydon5_2022-04-04/2022-04-06 | 1023846 | 1311214 |
| ANH_110_T. Van Someren-Rydon6_2022-04-04/2022-04-06 | 1023838 | 1311269 |
| ANH_118_T. Van Someren-Rydon1_2021-07-15/2021-07-17 | 1023937 | 1309442 |
| ANH_118_T. Van Someren-Rydon4_2021-07-15/2021-07-17 | 1023986 | 1309366 |
| ANH_118_T. Van Someren-Rydon5_2021-07-15/2021-07-17 | 1024038 | 1309372 |
| ANH_118_T. Van Someren-Rydon6_2021-07-15/2021-07-17 | 1024081 | 1309375 |
| ANH_118_T. Van Someren-Rydon4_2022-04-04/2022-04-06 | 1024091 | 1309352 |
| ANH_120_T. Van Someren-Rydon1_2021-07-16/2021-07-18 | 1024738 | 1310173 |
| ANH_120_T. Van Someren-Rydon2_2021-07-16/2021-07-18 | 1024680 | 1310213 |
| ANH_120_T. Van Someren-Rydon5_2021-07-16/2021-07-18 | 1024735 | 1310251 |
| ANH_120_T. Van Someren-Rydon4_2022-03-31/2022-04-02 | 1024749 | 1310246 |
| ANH_120_T. Van Someren-Rydon5_2022-03-31/2022-04-02 | 1024739 | 1310161 |
| ANH_120_T. Van Someren-Rydon6_2022-03-31/2022-04-02 | 1024698 | 1310187 |
| ANH_125_T. Van Someren-Rydon1_2022-04-07/2022-04-09 | 1029622 | 1313919 |
| ANH_125_T. Van Someren-Rydon4_2022-04-07/2022-04-09 | 1029747 | 1313838 |
| ANH_125_T. Van Someren-Rydon6_2021-07-12/2021-07-14 | 1029811 | 1313806 |
| ANH_125_T. Van Someren-Rydon2_2022-04-07/2022-04-09 | 1029651 | 1313876 |
| ANH_125_T. Van Someren-Rydon3_2022-04-07/2022-04-09 | 1029704 | 1313881 |
| ANH_125_T. Van Someren-Rydon5_2022-04-07/2022-04-09 | 1029793 | 1313810 |
| ANH_125_T. Van Someren-Rydon6_2022-04-07/2022-04-09 | 1029829 | 1313848 |
| ANH_110_T. Van Someren-Rydon2_2021-07-15/2021-07-17 | 1023730 | 1310736 |
| ANH_110_T. Van Someren-Rydon1_2021-07-15/2021-07-17 | 1023745 | 1310790 |
| ANH_122_T. Van Someren-Rydon2_2021-07-15/2021-07-17 | 1025943 | 1311840 |
| ANH_122_T. Van Someren-Rydon4_2021-07-15/2021-07-17 | 1026035 | 1311850 |
| ANH_122_T. Van Someren-Rydon5_2021-07-15/2021-07-17 | 1026078 | 1311837 |
| ANH_122_T. Van Someren-Rydon6_2021-07-15/2021-07-17 | 1026124 | 1311804 |
| ANH_122_T. Van Someren-Rydon2_2022-03-31/2022-04-02 | 1025912 | 1311825 |
| ANH_122_T. Van Someren-Rydon3_2022-03-31/2022-04-02 | 1025981 | 1311861 |
| ANH_122_T. Van Someren-Rydon4_2022-03-31/2022-04-02 | 1025940 | 1311848 |
| ANH_122_T. Van Someren-Rydon5_2022-03-31/2022-04-02 | 1026041 | 1311859 |
| ANH_122_T. Van Someren-Rydon6_2022-03-31/2022-04-02 | 1026082 | 1311844 |
| ANH_122_T. Van Someren-Rydon3_2021-07-15/2021-07-17 | 1025999 | 1311828 |
| ANH_125_T. Van Someren-Rydon1_2021-07-12/2021-07-14 | 1029774 | 1313895 |
| ANH_392_T. Van Someren-Rydon5_2021-07-19/2021-07-21 | 1040881 | 1299290 |
| ANH_392_T. Van Someren-Rydon6_2021-07-19/2021-07-21 | 1040940 | 1299287 |
| ANH_392_T. Van Someren-Rydon5_2022-03-17/2022-03-19 | 1040890 | 1299279 |
| ANH_392_T. Van Someren-Rydon6_2022-03-17/2022-03-19 | 1040855 | 1299286 |
| ANH_135_T. Van Someren-Rydon1_2021-07-01/2021-07-03 | 1021652 | 1291809 |
| ANH_135_T. Van Someren-Rydon2_2021-07-01/2021-07-03 | 1021671 | 1291785 |
| ANH_135_T. Van Someren-Rydon3_2021-07-01/2021-07-03 | 1021676 | 1291801 |
| ANH_135_T. Van Someren-Rydon4_2021-07-01/2021-07-03 | 1021684 | 1291820 |

Displaying records 1 - 50

</div>

# 9 Cambiar coordenadas de Aves

``` r
file <- "../../bpw_data_repo/Corrections/Coordenada Aves.xlsx"
corr <- read.xlsx(file)
colnames(corr) <- gsub("[().-]", "_", tolower(gsub("([a-z])([A-Z]+)", "\\1_\\L\\2",
    colnames(corr), perl = T)))
dbWriteTable(fracking_db, c("raw_dwc", "corr_coord_ave"), corr, overwrite = T)
```

    ## [1] TRUE

Aves de la anh 375 van a 404

``` sql
UPDATE raw_dwc.corr_coord_ave
SET event_id=REGEXP_REPLACE(event_id,'^ANH_375','ANH_404')
WHERE event_id ~ '^ANH_375'
```

Averiguar que los event_id correspondan:

``` sql
SELECT c.event_id,ARRAY_AGG(e.cd_event)
FROM raw_dwc.corr_coord_ave c
LEFT JOIN main.event e ON 'aves_'||c.event_id=e.event_id
GROUP BY c.event_id
```

<div class="knitsql-table">

| event_id           | array_agg |
|:-------------------|:----------|
| ANH_404_A_R15_T2   | {5873}    |
| ANH_404_A_R2_T2    | {5879}    |
| ANH_82_A_P3_R2_T2  | {5348}    |
| ANH_232_A_P1_R3_T2 | {5389}    |
| ANH_218_A_P3_R1_T2 | {5513}    |
| ANH_252_A_P2_R3_T2 | {5702}    |
| ANH_360_A_P3_R1_T2 | {5402}    |
| ANH_275_A_P1_R2_T2 | {5761}    |
| ANH_398_A_P3_R3_T2 | {5413}    |
| ANH_192_A_P2_R1_T2 | {5465}    |
| ANH_282_A_P2_R2_T1 | {5288}    |
| ANH_154_A_P2_R1_T2 | {5353}    |
| ANH_282_A_P1_R3_T1 | {5286}    |
| ANH_228_A_P1_R2_T2 | {5571}    |
| ANH_82_A_P3_R1_T1  | {4842}    |
| ANH_233_A_P3_R1_T1 | {5100}    |
| ANH_229_A_P1_R1_T2 | {5579}    |
| ANH_197_A_P3_R1_T2 | {5477}    |
| ANH_228_A_P1_R3_T1 | {5069}    |
| ANH_248_A_P3_R2_T2 | {5686}    |
| ANH_250_A_P1_R2_T1 | {5186}    |
| ANH_252_A_P1_R2_T2 | {5698}    |
| ANH_227_A_P1_R3_T2 | {5563}    |
| ANH_401_A_P1_R3_T2 | {5861}    |
| ANH_238_A_P1_R2_T1 | {5122}    |
| ANH_218_A_P3_R2_T2 | {5514}    |
| ANH_197_A_P1_R1_T2 | {5471}    |
| ANH_192_A_P2_R3_T1 | {4964}    |
| ANH_208_A_P2_R3_T2 | {5485}    |
| ANH_192_A_P2_R1_T1 | {4962}    |
| ANH_233_A_P2_R1_T1 | {5097}    |
| ANH_248_A_P3_R1_T1 | {5182}    |
| ANH_227_A_P2_R1_T2 | {5564}    |
| ANH_213_A_P2_R2_T2 | {5502}    |
| ANH_244_A_P3_R2_T1 | {5174}    |
| ANH_239_A_P3_R3_T2 | {5641}    |
| ANH_361_A_P2_R3_T2 | {5819}    |
| ANH_361_A_P2_R2_T1 | {5315}    |
| ANH_248_A_P3_R1_T2 | {5685}    |
| ANH_227_A_P3_R3_T1 | {5066}    |
| ANH_192_A_P3_R3_T2 | {5470}    |
| ANH_239_A_P2_R1_T1 | {5133}    |
| ANH_233_A_P1_R1_T1 | {5094}    |
| ANH_361_A_P2_R3_T1 | {5316}    |
| ANH_239_A_P1_R3_T1 | {5132}    |
| ANH_213_A_P2_R3_T1 | {5000}    |
| ANH_229_A_P3_R3_T1 | {5084}    |
| ANH_208_A_P2_R1_T2 | {5483}    |
| ANH_238_A_P2_R2_T1 | {5125}    |
| ANH_154_A_P1_R1_T1 | {4845}    |

Displaying records 1 - 50

</div>

``` sql
WITH a AS(
SELECT 
'aves_'||event_id event_id,
ST_SetSrid(ST_transform(
     ST_SetSrid(ST_MakePoint(decimal_lon,decimal_lat),4326)
,(SELECT proj4text FROM spatial_ref_sys WHERE srid=3116)),3116) geom
FROM raw_dwc.corr_coord_ave
)
UPDATE main.event AS e
SET pt_geom=a.geom
FROM a
WHERE a.event_id=e.event_id
RETURNING e.event_id, ST_X(pt_geom),ST_Y(pt_geom)
```

<div class="knitsql-table">

| event_id                |    st_x |    st_y |
|:------------------------|--------:|--------:|
| aves_ANH_74_A_P3_R1_T1  | 1030180 | 1309522 |
| aves_ANH_74_A_P3_R2_T1  | 1030180 | 1309522 |
| aves_ANH_74_A_P3_R3_T1  | 1030180 | 1309522 |
| aves_ANH_240_A_P1_R1_T1 | 1029797 | 1309393 |
| aves_ANH_240_A_P1_R2_T1 | 1029797 | 1309393 |
| aves_ANH_240_A_P1_R3_T1 | 1029797 | 1309393 |
| aves_ANH_240_A_P3_R1_T1 | 1029761 | 1309689 |
| aves_ANH_240_A_P3_R2_T1 | 1029761 | 1309689 |
| aves_ANH_240_A_P3_R3_T1 | 1029761 | 1309689 |
| aves_ANH_240_A_R9_T1    | 1029779 | 1309674 |
| aves_ANH_240_A_R10_T1   | 1029778 | 1309660 |
| aves_ANH_240_A_P1_R1_T2 | 1029797 | 1309393 |
| aves_ANH_240_A_P1_R2_T2 | 1029797 | 1309393 |
| aves_ANH_240_A_P1_R3_T2 | 1029797 | 1309393 |
| aves_ANH_240_A_P3_R1_T2 | 1029761 | 1309689 |
| aves_ANH_240_A_P3_R2_T2 | 1029761 | 1309689 |
| aves_ANH_240_A_P3_R3_T2 | 1029761 | 1309689 |
| aves_ANH_74_A_P3_R1_T2  | 1030180 | 1309522 |
| aves_ANH_74_A_P3_R2_T2  | 1030180 | 1309522 |
| aves_ANH_74_A_P3_R3_T2  | 1030180 | 1309522 |
| aves_ANH_240_A_R8_T2    | 1029781 | 1309656 |
| aves_ANH_240_A_R9_T2    | 1029772 | 1309650 |
| aves_ANH_240_A_R10_T2   | 1029764 | 1309640 |
| aves_ANH_252_A_P1_R1_T1 | 1034710 | 1298200 |
| aves_ANH_252_A_P1_R2_T1 | 1034710 | 1298200 |
| aves_ANH_252_A_P1_R3_T1 | 1034710 | 1298200 |
| aves_ANH_252_A_P2_R1_T1 | 1034698 | 1298411 |
| aves_ANH_252_A_P2_R2_T1 | 1034698 | 1298411 |
| aves_ANH_252_A_P2_R3_T1 | 1034698 | 1298411 |
| aves_ANH_252_A_P1_R1_T2 | 1034710 | 1298200 |
| aves_ANH_252_A_P1_R2_T2 | 1034710 | 1298200 |
| aves_ANH_252_A_P1_R3_T2 | 1034710 | 1298200 |
| aves_ANH_252_A_P2_R1_T2 | 1034698 | 1298411 |
| aves_ANH_252_A_P2_R2_T2 | 1034698 | 1298411 |
| aves_ANH_252_A_P2_R3_T2 | 1034698 | 1298411 |
| aves_ANH_250_A_P3_R1_T2 | 1031339 | 1299877 |
| aves_ANH_250_A_P3_R2_T2 | 1031339 | 1299877 |
| aves_ANH_250_A_P3_R3_T2 | 1031339 | 1299877 |
| aves_ANH_397_A_P2_R1_T2 | 1036374 | 1304781 |
| aves_ANH_397_A_P2_R2_T2 | 1036374 | 1304781 |
| aves_ANH_397_A_P2_R3_T2 | 1036374 | 1304781 |
| aves_ANH_396_A_P1_R1_T2 | 1041632 | 1304344 |
| aves_ANH_396_A_P1_R2_T2 | 1041632 | 1304344 |
| aves_ANH_396_A_P1_R3_T2 | 1041632 | 1304344 |
| aves_ANH_244_A_P3_R1_T1 | 1037558 | 1308057 |
| aves_ANH_244_A_P3_R2_T1 | 1037558 | 1308057 |
| aves_ANH_244_A_P3_R3_T1 | 1037558 | 1308057 |
| aves_ANH_244_A_P3_R1_T2 | 1037558 | 1308057 |
| aves_ANH_244_A_P3_R2_T2 | 1037558 | 1308057 |
| aves_ANH_244_A_P3_R3_T2 | 1037558 | 1308057 |

Displaying records 1 - 50

</div>

``` r
dbDisconnect(fracking_db)
```

    ## [1] TRUE
