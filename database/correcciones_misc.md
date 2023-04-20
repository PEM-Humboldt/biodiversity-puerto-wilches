Correcciones sobre los datos (después de la integración de las
estructuras de muestreo)
================
Marius Bottin
2023-04-19

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

<table>
<caption>

Displaying records 1 - 50

</caption>
<thead>
<tr>
<th style="text-align:left;">

event_id

</th>
<th style="text-align:left;">

array_agg

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

ANH_151_Herp_T2_D_TE2

</td>
<td style="text-align:left;">

{135}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_167_Herp_T3_D_TE2

</td>
<td style="text-align:left;">

{301}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_149_Herp_T3_D_TE2

</td>
<td style="text-align:left;">

{113}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_167_Herp_T3_D

</td>
<td style="text-align:left;">

{295}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_149_Herp_T3_N_TE2

</td>
<td style="text-align:left;">

{114}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_149_Herp_T3_D

</td>
<td style="text-align:left;">

{107}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_168_Herp_T2_D

</td>
<td style="text-align:left;">

{305}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_164_Herp_T3_D_TE2

</td>
<td style="text-align:left;">

{265}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_164_Herp_T3_N_TE2

</td>
<td style="text-align:left;">

{266}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_149_Herp_T2_N_TE2

</td>
<td style="text-align:left;">

{112}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_180_Herp_T3_N_TE2

</td>
<td style="text-align:left;">

{368}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_141_Herp_T3_D

</td>
<td style="text-align:left;">

{83}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_163_Herp_T1_D

</td>
<td style="text-align:left;">

{243}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_162_Herp_T3_D

</td>
<td style="text-align:left;">

{235}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_178_Herp_T3_N_TE2

</td>
<td style="text-align:left;">

{344}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_109_Herp_T3_N

</td>
<td style="text-align:left;">

{30}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_162_Herp_T2_D

</td>
<td style="text-align:left;">

{233}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_162_Herp_T3_D_TE2

</td>
<td style="text-align:left;">

{241}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_178_Herp_T2_D

</td>
<td style="text-align:left;">

{335}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_153_Herp_T1_D

</td>
<td style="text-align:left;">

{151}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_180_Herp_T1_D_TE2

</td>
<td style="text-align:left;">

{363}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_167_Herp_T2_N_TE2

</td>
<td style="text-align:left;">

{300}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_180_Herp_T2_D

</td>
<td style="text-align:left;">

{359}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_153_Herp_T2_N

</td>
<td style="text-align:left;">

{154}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_166_Herp_T1_N_TE2

</td>
<td style="text-align:left;">

{286}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_167_Herp_T1_D

</td>
<td style="text-align:left;">

{291}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_164_Herp_T3_N

</td>
<td style="text-align:left;">

{260}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_164_Herp_T2_D_TE2

</td>
<td style="text-align:left;">

{263}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_163_Herp_T3_D

</td>
<td style="text-align:left;">

{247}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_165_Herp_T3_N

</td>
<td style="text-align:left;">

{272}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_166_Herp_T1_D_TE2

</td>
<td style="text-align:left;">

{285}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_162_Herp_T1_D_TE2

</td>
<td style="text-align:left;">

{237}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_178_Herp_T3_D_TE2

</td>
<td style="text-align:left;">

{343}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_100_Herp_T3_D_TE2

</td>
<td style="text-align:left;">

{23}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_150_Herp_T2_N

</td>
<td style="text-align:left;">

{118}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_100_Herp_T2_D_TE2

</td>
<td style="text-align:left;">

{21}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_164_Herp_T2_N_TE2

</td>
<td style="text-align:left;">

{264}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_178_Herp_T1_D

</td>
<td style="text-align:left;">

{333}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_164_Herp_T1_D

</td>
<td style="text-align:left;">

{255}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_180_Herp_T1_D

</td>
<td style="text-align:left;">

{357}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_149_Herp_T3_N

</td>
<td style="text-align:left;">

{108}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_178_Herp_T2_D_TE2

</td>
<td style="text-align:left;">

{341}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_158_Herp_T3_D

</td>
<td style="text-align:left;">

{199}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_180_Herp_T1_N_TE2

</td>
<td style="text-align:left;">

{364}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_167_Herp_T2_D

</td>
<td style="text-align:left;">

{293}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_178_Herp_T1_N

</td>
<td style="text-align:left;">

{334}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_180_Herp_T1_N

</td>
<td style="text-align:left;">

{358}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_164_Herp_T1_N_TE2

</td>
<td style="text-align:left;">

{262}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_162_Herp_T1_D

</td>
<td style="text-align:left;">

{231}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_162_Herp_T2_N_TE2

</td>
<td style="text-align:left;">

{240}

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

Displaying records 1 - 50

</caption>
<thead>
<tr>
<th style="text-align:left;">

event_id

</th>
<th style="text-align:right;">

st_length

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

ANH_153_Herp_T1_D

</td>
<td style="text-align:right;">

164.13303

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_153_Herp_T1_N

</td>
<td style="text-align:right;">

164.13303

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_153_Herp_T2_D

</td>
<td style="text-align:right;">

64.28120

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_153_Herp_T2_N

</td>
<td style="text-align:right;">

64.28120

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_155_Herp_T1_D

</td>
<td style="text-align:right;">

95.51342

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_155_Herp_T1_N

</td>
<td style="text-align:right;">

95.51342

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_155_Herp_T2_D

</td>
<td style="text-align:right;">

115.10921

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_155_Herp_T2_N

</td>
<td style="text-align:right;">

115.10921

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_151_Herp_T2_D_TE2

</td>
<td style="text-align:right;">

131.58884

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_151_Herp_T2_N_TE2

</td>
<td style="text-align:right;">

131.58884

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_168_Herp_T2_D

</td>
<td style="text-align:right;">

371.73964

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_168_Herp_T2_N

</td>
<td style="text-align:right;">

371.73964

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_167_Herp_T1_D

</td>
<td style="text-align:right;">

373.80520

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_167_Herp_T1_N

</td>
<td style="text-align:right;">

373.80520

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_167_Herp_T2_D

</td>
<td style="text-align:right;">

204.50186

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_167_Herp_T2_N

</td>
<td style="text-align:right;">

204.50186

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_167_Herp_T1_D_TE2

</td>
<td style="text-align:right;">

220.63487

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_167_Herp_T1_N_TE2

</td>
<td style="text-align:right;">

220.63487

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_167_Herp_T3_D_TE2

</td>
<td style="text-align:right;">

219.77322

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_167_Herp_T3_N_TE2

</td>
<td style="text-align:right;">

219.77322

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_166_Herp_T1_D_TE2

</td>
<td style="text-align:right;">

171.55170

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_166_Herp_T1_N_TE2

</td>
<td style="text-align:right;">

171.55170

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_162_Herp_T1_D

</td>
<td style="text-align:right;">

509.75756

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_162_Herp_T1_N

</td>
<td style="text-align:right;">

509.75756

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_162_Herp_T2_D

</td>
<td style="text-align:right;">

260.89138

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_162_Herp_T2_N

</td>
<td style="text-align:right;">

260.89138

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_162_Herp_T3_D

</td>
<td style="text-align:right;">

242.18567

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_162_Herp_T3_N

</td>
<td style="text-align:right;">

242.18567

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_162_Herp_T1_D_TE2

</td>
<td style="text-align:right;">

257.16714

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_162_Herp_T1_N_TE2

</td>
<td style="text-align:right;">

257.16714

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_162_Herp_T2_D_TE2

</td>
<td style="text-align:right;">

282.05686

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_162_Herp_T2_N_TE2

</td>
<td style="text-align:right;">

282.05686

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_162_Herp_T3_D_TE2

</td>
<td style="text-align:right;">

233.86321

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_162_Herp_T3_N_TE2

</td>
<td style="text-align:right;">

233.86321

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_164_Herp_T1_D

</td>
<td style="text-align:right;">

268.75959

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_164_Herp_T1_N

</td>
<td style="text-align:right;">

268.75959

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_164_Herp_T3_D

</td>
<td style="text-align:right;">

128.11481

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_164_Herp_T3_N

</td>
<td style="text-align:right;">

128.11481

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_164_Herp_T2_D_TE2

</td>
<td style="text-align:right;">

236.30426

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_164_Herp_T2_N_TE2

</td>
<td style="text-align:right;">

236.30426

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_163_Herp_T1_D

</td>
<td style="text-align:right;">

354.29599

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_163_Herp_T1_N

</td>
<td style="text-align:right;">

354.29599

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_163_Herp_T2_D

</td>
<td style="text-align:right;">

291.34618

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_163_Herp_T2_N

</td>
<td style="text-align:right;">

291.34618

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_163_Herp_T3_D

</td>
<td style="text-align:right;">

430.78631

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_163_Herp_T3_N

</td>
<td style="text-align:right;">

430.78631

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_136_Herp_T1_D_TE2

</td>
<td style="text-align:right;">

153.95272

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_136_Herp_T1_N_TE2

</td>
<td style="text-align:right;">

153.95272

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_158_Herp_T3_D

</td>
<td style="text-align:right;">

174.82988

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_158_Herp_T3_N

</td>
<td style="text-align:right;">

174.82988

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

Displaying records 1 - 50

</caption>
<thead>
<tr>
<th style="text-align:left;">

event_id

</th>
<th style="text-align:left;">

array_agg

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

ANH_135_T. Exc. Human1_2021-07-01/2021-07-03

</td>
<td style="text-align:left;">

{3035}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_120_T. Exc. Human4_2022-03-31/2022-04-02

</td>
<td style="text-align:left;">

{3597}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_135_T. Exc. Human2_2021-07-01/2021-07-03

</td>
<td style="text-align:left;">

{3036}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_371_T. Exc. Human5_2022-03-28/2022-03-30

</td>
<td style="text-align:left;">

{3818}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_138_T. Exc. Human4_2022-03-28/2022-03-30

</td>
<td style="text-align:left;">

{3707}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_120_T. Exc. Human5_2022-03-31/2022-04-02

</td>
<td style="text-align:left;">

{3598}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_135_Captura manual3_2021-07-03

</td>
<td style="text-align:left;">

{3033}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_123_T. Exc. Human1_2022-04-07/2022-04-09

</td>
<td style="text-align:left;">

{3627}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_134_T. Exc. Human2_2022-03-22/2022-03-24

</td>
<td style="text-align:left;">

{3683}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_113_Captura manual4_2021-07-16

</td>
<td style="text-align:left;">

{3100}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_109_T. Exc. Human2_2021-07-15/2021-07-17

</td>
<td style="text-align:left;">

{3003}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_109_T. Exc. Human6_2021-07-15/2021-07-17

</td>
<td style="text-align:left;">

{3007}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_135_T. Exc. Human6_2021-07-01/2021-07-03

</td>
<td style="text-align:left;">

{3040}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_109_T. Exc. Human7_2021-07-15/2021-07-17

</td>
<td style="text-align:left;">

{3008}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_371_T. Exc. Human1_2022-03-28/2022-03-30

</td>
<td style="text-align:left;">

{3814}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_121_Captura manual1_2021-07-22

</td>
<td style="text-align:left;">

{3161}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_392_T. Exc. Human5_2022-03-17/2022-03-19

</td>
<td style="text-align:left;">

{3862}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_371_Captura manual2_2021-07-08

</td>
<td style="text-align:left;">

{3371}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_123_Captura manual4_2021-07-02

</td>
<td style="text-align:left;">

{3186}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_T. Exc. Human4_2021-07-15/2021-07-17

</td>
<td style="text-align:left;">

{3179}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_118_Captura manual2_2022-04-06

</td>
<td style="text-align:left;">

{3580}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_109_T. Exc. Human5_2021-07-15/2021-07-17

</td>
<td style="text-align:left;">

{3006}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Captura manual1_2021-07-23

</td>
<td style="text-align:left;">

{3205}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_T. Exc. Human6_2021-07-15/2021-07-17

</td>
<td style="text-align:left;">

{3181}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_T. Exc. Human2_2022-03-31/2022-04-02

</td>
<td style="text-align:left;">

{3716}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_137_T. Exc. Human6_2022-03-28/2022-03-30

</td>
<td style="text-align:left;">

{3698}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_115_T. Exc. Human7_2022-04-05/2022-04-07

</td>
<td style="text-align:left;">

{3567}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_125_Captura manual2_2022-04-09

</td>
<td style="text-align:left;">

{3635}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_135_T. Exc. Human4_2021-07-01/2021-07-03

</td>
<td style="text-align:left;">

{3038}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_109_Captura manual1_2022-04-06

</td>
<td style="text-align:left;">

{3436}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_391_T. Exc. Human1_2022-03-17/2022-03-19

</td>
<td style="text-align:left;">

{3847}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_113_Captura manual2_2022-04-05

</td>
<td style="text-align:left;">

{3536}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_123_T. Exc. Human7_2021-07-02/2021-07-04

</td>
<td style="text-align:left;">

{3193}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_134_Captura manual2_2022-03-22

</td>
<td style="text-align:left;">

{3679}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_125_T. Exc. Human6_2022-04-07/2022-04-09

</td>
<td style="text-align:left;">

{3643}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_T. Exc. Human1_2021-07-15/2021-07-17

</td>
<td style="text-align:left;">

{3176}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_109_Captura manual2_2021-07-15

</td>
<td style="text-align:left;">

{2999}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_121_T. Exc. Human5_2022-04-07/2022-04-09

</td>
<td style="text-align:left;">

{3609}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_113_T. Exc. Human7_2022-04-05/2022-04-07

</td>
<td style="text-align:left;">

{3545}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_118_T. Exc. Human5_2022-04-04/2022-04-06

</td>
<td style="text-align:left;">

{3587}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_134_T. Exc. Human7_2022-03-22/2022-03-24

</td>
<td style="text-align:left;">

{3688}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_118_T. Exc. Human2_2022-04-04/2022-04-06

</td>
<td style="text-align:left;">

{3584}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_134_T. Exc. Human5_2021-07-05/2021-07-07

</td>
<td style="text-align:left;">

{3246}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_374_Captura manual1_2021-07-19

</td>
<td style="text-align:left;">

{3053}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_120_Captura manual2_2021-07-17

</td>
<td style="text-align:left;">

{3151}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_113_Captura manual3_2021-07-16

</td>
<td style="text-align:left;">

{3099}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_110_T. Exc. Human5_2021-07-15/2021-07-17

</td>
<td style="text-align:left;">

{3083}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_371_Captura manual1_2022-03-28

</td>
<td style="text-align:left;">

{3810}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_118_T. Exc. Human2_2021-07-15/2021-07-17

</td>
<td style="text-align:left;">

{3144}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_120_T. Exc. Human7_2021-07-16/2021-07-18

</td>
<td style="text-align:left;">

{3160}

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

Displaying records 1 - 50

</caption>
<thead>
<tr>
<th style="text-align:left;">

event_id

</th>
<th style="text-align:right;">

st_x

</th>
<th style="text-align:right;">

st_y

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

esca_ANH_373_T. Exc. Human3_2021-07-22/2021-07-24

</td>
<td style="text-align:right;">

1031558

</td>
<td style="text-align:right;">

1300874

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_373_T. Exc. Human3_2022-04-05/2022-04-07

</td>
<td style="text-align:right;">

1031560

</td>
<td style="text-align:right;">

1300874

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_373_T. Exc. Human7_2021-07-22/2021-07-24

</td>
<td style="text-align:right;">

1031722

</td>
<td style="text-align:right;">

1300887

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_373_Captura manual3_2021-07-23

</td>
<td style="text-align:right;">

1031558

</td>
<td style="text-align:right;">

1300874

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_142_Captura manual4_2022-04-01

</td>
<td style="text-align:right;">

1032908

</td>
<td style="text-align:right;">

1300838

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_142_T. Exc. Human5_2022-03-31/2022-04-02

</td>
<td style="text-align:right;">

1032905

</td>
<td style="text-align:right;">

1300838

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_142_T. Exc. Human7_2021-07-13/2021-07-15

</td>
<td style="text-align:right;">

1032916

</td>
<td style="text-align:right;">

1300839

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_142_T. Exc. Human2_2021-07-13/2021-07-15

</td>
<td style="text-align:right;">

1032986

</td>
<td style="text-align:right;">

1300770

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_142_T. Exc. Human2_2022-03-31/2022-04-02

</td>
<td style="text-align:right;">

1032986

</td>
<td style="text-align:right;">

1300769

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_142_T. Exc. Human4_2021-07-13/2021-07-15

</td>
<td style="text-align:right;">

1033007

</td>
<td style="text-align:right;">

1300745

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_114_Captura manual1_2021-07-06

</td>
<td style="text-align:right;">

1034145

</td>
<td style="text-align:right;">

1304390

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_114_T. Exc. Human7_2021-07-06/2021-07-08

</td>
<td style="text-align:right;">

1034148

</td>
<td style="text-align:right;">

1304518

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_118_Captura manual1_2021-07-17

</td>
<td style="text-align:right;">

1024038

</td>
<td style="text-align:right;">

1309377

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_118_Captura manual2_2021-07-17

</td>
<td style="text-align:right;">

1023973

</td>
<td style="text-align:right;">

1309410

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_118_T. Exc. Human2_2021-07-15/2021-07-17

</td>
<td style="text-align:right;">

1023936

</td>
<td style="text-align:right;">

1309398

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_118_T. Exc. Human3_2021-07-15/2021-07-17

</td>
<td style="text-align:right;">

1023964

</td>
<td style="text-align:right;">

1309392

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_118_T. Exc. Human4_2021-07-15/2021-07-17

</td>
<td style="text-align:right;">

1023998

</td>
<td style="text-align:right;">

1309377

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_118_T. Exc. Human4_2022-04-04/2022-04-06

</td>
<td style="text-align:right;">

1024073

</td>
<td style="text-align:right;">

1309334

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_118_T. Exc. Human5_2021-07-15/2021-07-17

</td>
<td style="text-align:right;">

1024053

</td>
<td style="text-align:right;">

1309374

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_118_T. Exc. Human6_2021-07-15/2021-07-17

</td>
<td style="text-align:right;">

1024099

</td>
<td style="text-align:right;">

1309367

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_118_T. Exc. Human7_2021-07-15/2021-07-17

</td>
<td style="text-align:right;">

1024139

</td>
<td style="text-align:right;">

1309361

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_118_T. Exc. Human7_2022-04-04/2022-04-06

</td>
<td style="text-align:right;">

1024244

</td>
<td style="text-align:right;">

1309319

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_120_Captura manual3_2021-07-17

</td>
<td style="text-align:right;">

1024720

</td>
<td style="text-align:right;">

1310294

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_120_Captura manual4_2021-07-18

</td>
<td style="text-align:right;">

1024769

</td>
<td style="text-align:right;">

1310251

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_120_T. Exc. Human4_2021-07-16/2021-07-18

</td>
<td style="text-align:right;">

1024767

</td>
<td style="text-align:right;">

1310124

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_120_T. Exc. Human5_2021-07-16/2021-07-18

</td>
<td style="text-align:right;">

1024682

</td>
<td style="text-align:right;">

1310088

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_120_T. Exc. Human7_2021-07-16/2021-07-18

</td>
<td style="text-align:right;">

1024767

</td>
<td style="text-align:right;">

1310127

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_110_Captura manual3_2021-07-17

</td>
<td style="text-align:right;">

1023788

</td>
<td style="text-align:right;">

1310877

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_125_Captura manual1_2022-04-09

</td>
<td style="text-align:right;">

1029992

</td>
<td style="text-align:right;">

1313943

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_125_Captura manual2_2022-04-09

</td>
<td style="text-align:right;">

1029897

</td>
<td style="text-align:right;">

1313894

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_125_Captura manual3_2021-07-14

</td>
<td style="text-align:right;">

1029826

</td>
<td style="text-align:right;">

1313940

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_125_Captura manual4_2021-07-14

</td>
<td style="text-align:right;">

1029790

</td>
<td style="text-align:right;">

1313941

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_125_T. Exc. Human2_2022-04-07/2022-04-09

</td>
<td style="text-align:right;">

1029761

</td>
<td style="text-align:right;">

1313953

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_125_T. Exc. Human3_2022-04-07/2022-04-09

</td>
<td style="text-align:right;">

1029820

</td>
<td style="text-align:right;">

1313951

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_125_T. Exc. Human4_2022-04-07/2022-04-09

</td>
<td style="text-align:right;">

1029857

</td>
<td style="text-align:right;">

1313932

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_125_T. Exc. Human6_2021-07-12/2021-07-14

</td>
<td style="text-align:right;">

1029921

</td>
<td style="text-align:right;">

1313875

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_125_T. Exc. Human6_2022-04-07/2022-04-09

</td>
<td style="text-align:right;">

1029949

</td>
<td style="text-align:right;">

1313891

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_125_T. Exc. Human7_2022-04-07/2022-04-09

</td>
<td style="text-align:right;">

1029987

</td>
<td style="text-align:right;">

1313936

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_369_T. Exc. Human7_2022-03-29/2022-03-31

</td>
<td style="text-align:right;">

1029776

</td>
<td style="text-align:right;">

1314029

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_369_Captura manual1_2021-07-12

</td>
<td style="text-align:right;">

1029984

</td>
<td style="text-align:right;">

1314224

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_369_T. Exc. Human1_2021-07-12/2021-07-14

</td>
<td style="text-align:right;">

1029984

</td>
<td style="text-align:right;">

1314224

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_369_T. Exc. Human6_2022-03-29/2022-03-31

</td>
<td style="text-align:right;">

1029749

</td>
<td style="text-align:right;">

1314069

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_110_Captura manual2_2021-07-17

</td>
<td style="text-align:right;">

1023791

</td>
<td style="text-align:right;">

1310865

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_110_Captura manual4_2021-07-17

</td>
<td style="text-align:right;">

1023801

</td>
<td style="text-align:right;">

1310897

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_110_T. Exc. Human2_2021-07-15/2021-07-17

</td>
<td style="text-align:right;">

1023788

</td>
<td style="text-align:right;">

1310872

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_110_T. Exc. Human1_2021-07-15/2021-07-17

</td>
<td style="text-align:right;">

1023811

</td>
<td style="text-align:right;">

1310916

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_122_Captura manual1_2022-04-04

</td>
<td style="text-align:right;">

1026118

</td>
<td style="text-align:right;">

1311784

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_122_Captura manual3_2021-07-15

</td>
<td style="text-align:right;">

1025936

</td>
<td style="text-align:right;">

1311813

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_122_Captura manual4_2021-07-15

</td>
<td style="text-align:right;">

1025995

</td>
<td style="text-align:right;">

1311816

</td>
</tr>
<tr>
<td style="text-align:left;">

esca_ANH_122_Captura manual4_2022-04-04

</td>
<td style="text-align:right;">

1025931

</td>
<td style="text-align:right;">

1311809

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

Displaying records 1 - 50

</caption>
<thead>
<tr>
<th style="text-align:left;">

event_id

</th>
<th style="text-align:left;">

array_agg

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

ANH_370_Pitfall6_2022-03-28/2022-03-30

</td>
<td style="text-align:left;">

{4775}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_123_Pitfall1_2021-07-05/2021-07-07

</td>
<td style="text-align:left;">

{4098}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_369_Berlese5_2021-07-07/2021-07-13

</td>
<td style="text-align:left;">

{4276}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_370_Pitfall4_2022-03-28/2022-03-30

</td>
<td style="text-align:left;">

{4773}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_370_Berlese6_2022-03-28/2022-04-03

</td>
<td style="text-align:left;">

{4769}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_369_Pitfall1_2022-03-24/2022-03-26

</td>
<td style="text-align:left;">

{4758}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_366_Berlese5_2021-07-06/2021-07-12

</td>
<td style="text-align:left;">

{4252}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_373_Pitfall2_2021-07-13/2021-07-15

</td>
<td style="text-align:left;">

{NULL}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_372_Berlese2_2021-07-13/2021-07-19

</td>
<td style="text-align:left;">

{4309}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_373_Berlese2_2021-07-13/2021-07-19

</td>
<td style="text-align:left;">

{NULL}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_371_Pitfall2_2021-07-08/2021-07-12

</td>
<td style="text-align:left;">

{4303}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_108_Pitfall6_2021-07-13/2021-07-15

</td>
<td style="text-align:left;">

{3971}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_373_Pitfall1_2022-03-31/2022-04-02

</td>
<td style="text-align:left;">

{NULL}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_134_Pitfall3_2022-03-22/2022-03-24

</td>
<td style="text-align:left;">

{4640}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_134_Berlese6_2021-07-05/2021-07-11

</td>
<td style="text-align:left;">

{4157}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Pitfall2_2022-03-29/2022-03-31

</td>
<td style="text-align:left;">

{4603}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_115_Berlese1_2021-07-02/2021-07-08

</td>
<td style="text-align:left;">

{4020}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_110_Berlese1_2021-07-14/2021-07-20

</td>
<td style="text-align:left;">

{3972}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_369_Berlese1_2022-03-24/2022-03-30

</td>
<td style="text-align:left;">

{4752}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_134_Pitfall5_2021-07-05/2021-07-07

</td>
<td style="text-align:left;">

{4162}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_133_Berlese1_2021-07-05/2021-07-11

</td>
<td style="text-align:left;">

{3900}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_Berlese5_2022-03-31/2022-04-06

</td>
<td style="text-align:left;">

{4672}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_134_Berlese2_2022-03-22/2022-03-28

</td>
<td style="text-align:left;">

{4633}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_368_Pitfall5_2021-07-07/2021-07-09

</td>
<td style="text-align:left;">

{4270}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_369_Pitfall5_2021-07-07/2021-07-09

</td>
<td style="text-align:left;">

{4282}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_372_Pitfall1_2021-07-13/2021-07-15

</td>
<td style="text-align:left;">

{4314}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_370_Berlese5_2022-03-28/2022-04-03

</td>
<td style="text-align:left;">

{4768}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_369_Pitfall6_2021-07-07/2021-07-09

</td>
<td style="text-align:left;">

{4283}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_368_Pitfall2_2021-07-07/2021-07-09

</td>
<td style="text-align:left;">

{4267}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_133_Berlese1_2022-03-22/2022-03-28

</td>
<td style="text-align:left;">

{4380}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Pitfall1_2022-03-29/2022-03-31

</td>
<td style="text-align:left;">

{4602}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_373_Pitfall2_2022-03-31/2022-04-02

</td>
<td style="text-align:left;">

{NULL}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Berlese4_2022-03-29/2022-04-04

</td>
<td style="text-align:left;">

{4599}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_134_Berlese4_2021-07-05/2021-07-11

</td>
<td style="text-align:left;">

{4155}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_371_Berlese1_2021-07-08/2021-07-14

</td>
<td style="text-align:left;">

{4296}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_110_Pitfall1_2021-07-14/2021-07-16

</td>
<td style="text-align:left;">

{3978}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_134_Pitfall5_2022-03-22/2022-03-24

</td>
<td style="text-align:left;">

{4642}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_372_Pitfall3_2021-07-13/2021-07-15

</td>
<td style="text-align:left;">

{4316}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Pitfall6_2022-03-29/2022-03-31

</td>
<td style="text-align:left;">

{4607}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_368_Pitfall1_2021-07-07/2021-07-09

</td>
<td style="text-align:left;">

{4266}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_134_Berlese3_2022-03-22/2022-03-28

</td>
<td style="text-align:left;">

{4634}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_366_Pitfall5_2021-07-06/2021-07-08

</td>
<td style="text-align:left;">

{4258}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_371_Berlese3_2021-07-08/2021-07-14

</td>
<td style="text-align:left;">

{4298}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_371_Pitfall4_2021-07-08/2021-07-12

</td>
<td style="text-align:left;">

{4305}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Pitfall5_2022-03-29/2022-03-31

</td>
<td style="text-align:left;">

{4606}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_370_Pitfall3_2022-03-28/2022-03-30

</td>
<td style="text-align:left;">

{4772}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_368_Berlese2_2021-07-07/2021-07-13

</td>
<td style="text-align:left;">

{4261}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_372_Berlese4_2022-03-24/2022-03-30

</td>
<td style="text-align:left;">

{4791}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_372_Berlese6_2021-07-13/2021-07-19

</td>
<td style="text-align:left;">

{4313}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_123_Berlese1_2021-07-05/2021-07-11

</td>
<td style="text-align:left;">

{4092}

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

Displaying records 1 - 50

</caption>
<thead>
<tr>
<th style="text-align:left;">

event_id

</th>
<th style="text-align:left;">

array_agg

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

ANH_370_Pitfall6_2022-03-28/2022-03-30

</td>
<td style="text-align:left;">

{4775}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_123_Pitfall1_2021-07-05/2021-07-07

</td>
<td style="text-align:left;">

{4098}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_369_Berlese5_2021-07-07/2021-07-13

</td>
<td style="text-align:left;">

{4276}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_370_Pitfall4_2022-03-28/2022-03-30

</td>
<td style="text-align:left;">

{4773}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_370_Berlese6_2022-03-28/2022-04-03

</td>
<td style="text-align:left;">

{4769}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_369_Pitfall1_2022-03-24/2022-03-26

</td>
<td style="text-align:left;">

{4758}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_366_Berlese5_2021-07-06/2021-07-12

</td>
<td style="text-align:left;">

{4252}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_372_Berlese2_2021-07-13/2021-07-19

</td>
<td style="text-align:left;">

{4309}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_403_Pitfall2_2021-07-13/2021-07-15

</td>
<td style="text-align:left;">

{4351}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_371_Pitfall2_2021-07-08/2021-07-12

</td>
<td style="text-align:left;">

{4303}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_108_Pitfall6_2021-07-13/2021-07-15

</td>
<td style="text-align:left;">

{3971}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_134_Pitfall3_2022-03-22/2022-03-24

</td>
<td style="text-align:left;">

{4640}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_134_Berlese6_2021-07-05/2021-07-11

</td>
<td style="text-align:left;">

{4157}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_403_Pitfall1_2022-03-31/2022-04-02

</td>
<td style="text-align:left;">

{4830}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Pitfall2_2022-03-29/2022-03-31

</td>
<td style="text-align:left;">

{4603}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_115_Berlese1_2021-07-02/2021-07-08

</td>
<td style="text-align:left;">

{4020}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_110_Berlese1_2021-07-14/2021-07-20

</td>
<td style="text-align:left;">

{3972}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_369_Berlese1_2022-03-24/2022-03-30

</td>
<td style="text-align:left;">

{4752}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_134_Pitfall5_2021-07-05/2021-07-07

</td>
<td style="text-align:left;">

{4162}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_133_Berlese1_2021-07-05/2021-07-11

</td>
<td style="text-align:left;">

{3900}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_Berlese5_2022-03-31/2022-04-06

</td>
<td style="text-align:left;">

{4672}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_134_Berlese2_2022-03-22/2022-03-28

</td>
<td style="text-align:left;">

{4633}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_368_Pitfall5_2021-07-07/2021-07-09

</td>
<td style="text-align:left;">

{4270}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_369_Pitfall5_2021-07-07/2021-07-09

</td>
<td style="text-align:left;">

{4282}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_372_Pitfall1_2021-07-13/2021-07-15

</td>
<td style="text-align:left;">

{4314}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_370_Berlese5_2022-03-28/2022-04-03

</td>
<td style="text-align:left;">

{4768}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_369_Pitfall6_2021-07-07/2021-07-09

</td>
<td style="text-align:left;">

{4283}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_368_Pitfall2_2021-07-07/2021-07-09

</td>
<td style="text-align:left;">

{4267}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_133_Berlese1_2022-03-22/2022-03-28

</td>
<td style="text-align:left;">

{4380}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Pitfall1_2022-03-29/2022-03-31

</td>
<td style="text-align:left;">

{4602}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Berlese4_2022-03-29/2022-04-04

</td>
<td style="text-align:left;">

{4599}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_134_Berlese4_2021-07-05/2021-07-11

</td>
<td style="text-align:left;">

{4155}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_371_Berlese1_2021-07-08/2021-07-14

</td>
<td style="text-align:left;">

{4296}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_110_Pitfall1_2021-07-14/2021-07-16

</td>
<td style="text-align:left;">

{3978}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_134_Pitfall5_2022-03-22/2022-03-24

</td>
<td style="text-align:left;">

{4642}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_372_Pitfall3_2021-07-13/2021-07-15

</td>
<td style="text-align:left;">

{4316}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Pitfall6_2022-03-29/2022-03-31

</td>
<td style="text-align:left;">

{4607}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_368_Pitfall1_2021-07-07/2021-07-09

</td>
<td style="text-align:left;">

{4266}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_134_Berlese3_2022-03-22/2022-03-28

</td>
<td style="text-align:left;">

{4634}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_366_Pitfall5_2021-07-06/2021-07-08

</td>
<td style="text-align:left;">

{4258}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_371_Berlese3_2021-07-08/2021-07-14

</td>
<td style="text-align:left;">

{4298}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_371_Pitfall4_2021-07-08/2021-07-12

</td>
<td style="text-align:left;">

{4305}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Pitfall5_2022-03-29/2022-03-31

</td>
<td style="text-align:left;">

{4606}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_403_Berlese2_2021-07-13/2021-07-19

</td>
<td style="text-align:left;">

{4345}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_370_Pitfall3_2022-03-28/2022-03-30

</td>
<td style="text-align:left;">

{4772}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_368_Berlese2_2021-07-07/2021-07-13

</td>
<td style="text-align:left;">

{4261}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_372_Berlese4_2022-03-24/2022-03-30

</td>
<td style="text-align:left;">

{4791}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_372_Berlese6_2021-07-13/2021-07-19

</td>
<td style="text-align:left;">

{4313}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_123_Berlese1_2021-07-05/2021-07-11

</td>
<td style="text-align:left;">

{4092}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_368_Berlese3_2021-07-07/2021-07-13

</td>
<td style="text-align:left;">

{4262}

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

Displaying records 1 - 50

</caption>
<thead>
<tr>
<th style="text-align:left;">

event_id

</th>
<th style="text-align:right;">

st_x

</th>
<th style="text-align:right;">

st_y

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

cole_ANH_142_Berlese6_2021-07-13/2021-07-19

</td>
<td style="text-align:right;">

1033016

</td>
<td style="text-align:right;">

1300714

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_142_Pitfall6_2021-07-13/2021-07-15

</td>
<td style="text-align:right;">

1033016

</td>
<td style="text-align:right;">

1300714

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_142_Berlese4_2022-03-31/2022-04-06

</td>
<td style="text-align:right;">

1033014

</td>
<td style="text-align:right;">

1300736

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_142_Berlese5_2022-03-31/2022-04-06

</td>
<td style="text-align:right;">

1033009

</td>
<td style="text-align:right;">

1300741

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_142_Pitfall4_2022-03-31/2022-04-02

</td>
<td style="text-align:right;">

1033014

</td>
<td style="text-align:right;">

1300736

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_142_Pitfall5_2022-03-31/2022-04-02

</td>
<td style="text-align:right;">

1033009

</td>
<td style="text-align:right;">

1300741

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_366_Berlese5_2021-07-06/2021-07-12

</td>
<td style="text-align:right;">

1034424

</td>
<td style="text-align:right;">

1305198

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_366_Berlese6_2021-07-06/2021-07-12

</td>
<td style="text-align:right;">

1034429

</td>
<td style="text-align:right;">

1305198

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_366_Pitfall5_2021-07-06/2021-07-08

</td>
<td style="text-align:right;">

1034424

</td>
<td style="text-align:right;">

1305198

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_366_Pitfall6_2021-07-06/2021-07-08

</td>
<td style="text-align:right;">

1034429

</td>
<td style="text-align:right;">

1305198

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_369_Berlese5_2021-07-07/2021-07-13

</td>
<td style="text-align:right;">

1029754

</td>
<td style="text-align:right;">

1314080

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_369_Berlese6_2021-07-07/2021-07-13

</td>
<td style="text-align:right;">

1029757

</td>
<td style="text-align:right;">

1314095

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_369_Pitfall5_2021-07-07/2021-07-09

</td>
<td style="text-align:right;">

1029754

</td>
<td style="text-align:right;">

1314080

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_369_Pitfall6_2021-07-07/2021-07-09

</td>
<td style="text-align:right;">

1029757

</td>
<td style="text-align:right;">

1314095

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_369_Berlese1_2022-03-24/2022-03-30

</td>
<td style="text-align:right;">

1029772

</td>
<td style="text-align:right;">

1314063

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_369_Pitfall1_2022-03-24/2022-03-26

</td>
<td style="text-align:right;">

1029772

</td>
<td style="text-align:right;">

1314063

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_110_Berlese1_2021-07-14/2021-07-20

</td>
<td style="text-align:right;">

1023809

</td>
<td style="text-align:right;">

1310898

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_110_Pitfall1_2021-07-14/2021-07-16

</td>
<td style="text-align:right;">

1023809

</td>
<td style="text-align:right;">

1310898

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_130_Berlese1_2022-03-29/2022-04-04

</td>
<td style="text-align:right;">

1023725

</td>
<td style="text-align:right;">

1316761

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_130_Berlese2_2022-03-29/2022-04-04

</td>
<td style="text-align:right;">

1023729

</td>
<td style="text-align:right;">

1316775

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_130_Berlese3_2022-03-29/2022-04-04

</td>
<td style="text-align:right;">

1023728

</td>
<td style="text-align:right;">

1316791

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_130_Berlese4_2022-03-29/2022-04-04

</td>
<td style="text-align:right;">

1023730

</td>
<td style="text-align:right;">

1316800

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_130_Berlese5_2022-03-29/2022-04-04

</td>
<td style="text-align:right;">

1023731

</td>
<td style="text-align:right;">

1316814

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_130_Berlese6_2022-03-29/2022-04-04

</td>
<td style="text-align:right;">

1023728

</td>
<td style="text-align:right;">

1316828

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_130_Pitfall1_2022-03-29/2022-03-31

</td>
<td style="text-align:right;">

1023725

</td>
<td style="text-align:right;">

1316761

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_130_Pitfall2_2022-03-29/2022-03-31

</td>
<td style="text-align:right;">

1023729

</td>
<td style="text-align:right;">

1316775

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_130_Pitfall3_2022-03-29/2022-03-31

</td>
<td style="text-align:right;">

1023728

</td>
<td style="text-align:right;">

1316791

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_130_Pitfall4_2022-03-29/2022-03-31

</td>
<td style="text-align:right;">

1023730

</td>
<td style="text-align:right;">

1316800

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_130_Pitfall5_2022-03-29/2022-03-31

</td>
<td style="text-align:right;">

1023731

</td>
<td style="text-align:right;">

1316814

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_130_Pitfall6_2022-03-29/2022-03-31

</td>
<td style="text-align:right;">

1023728

</td>
<td style="text-align:right;">

1316828

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_134_Berlese4_2021-07-05/2021-07-11

</td>
<td style="text-align:right;">

1024273

</td>
<td style="text-align:right;">

1294769

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_134_Berlese5_2021-07-05/2021-07-11

</td>
<td style="text-align:right;">

1024285

</td>
<td style="text-align:right;">

1294763

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_134_Berlese6_2021-07-05/2021-07-11

</td>
<td style="text-align:right;">

1024282

</td>
<td style="text-align:right;">

1294760

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_134_Pitfall4_2021-07-05/2021-07-07

</td>
<td style="text-align:right;">

1024273

</td>
<td style="text-align:right;">

1294769

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_134_Pitfall5_2021-07-05/2021-07-07

</td>
<td style="text-align:right;">

1024285

</td>
<td style="text-align:right;">

1294763

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_134_Pitfall6_2021-07-05/2021-07-07

</td>
<td style="text-align:right;">

1024282

</td>
<td style="text-align:right;">

1294760

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_134_Berlese2_2022-03-22/2022-03-28

</td>
<td style="text-align:right;">

1024331

</td>
<td style="text-align:right;">

1294838

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_134_Berlese3_2022-03-22/2022-03-28

</td>
<td style="text-align:right;">

1024337

</td>
<td style="text-align:right;">

1294826

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_134_Berlese4_2022-03-22/2022-03-28

</td>
<td style="text-align:right;">

1024348

</td>
<td style="text-align:right;">

1294816

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_134_Berlese5_2022-03-22/2022-03-28

</td>
<td style="text-align:right;">

1024359

</td>
<td style="text-align:right;">

1294801

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_134_Berlese6_2022-03-22/2022-03-28

</td>
<td style="text-align:right;">

1024366

</td>
<td style="text-align:right;">

1294795

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_134_Pitfall2_2022-03-22/2022-03-24

</td>
<td style="text-align:right;">

1024331

</td>
<td style="text-align:right;">

1294838

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_134_Pitfall3_2022-03-22/2022-03-24

</td>
<td style="text-align:right;">

1024337

</td>
<td style="text-align:right;">

1294826

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_134_Pitfall4_2022-03-22/2022-03-24

</td>
<td style="text-align:right;">

1024348

</td>
<td style="text-align:right;">

1294816

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_134_Pitfall5_2022-03-22/2022-03-24

</td>
<td style="text-align:right;">

1024359

</td>
<td style="text-align:right;">

1294801

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_134_Pitfall6_2022-03-22/2022-03-24

</td>
<td style="text-align:right;">

1024366

</td>
<td style="text-align:right;">

1294795

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_115_Berlese1_2021-07-02/2021-07-08

</td>
<td style="text-align:right;">

1027613

</td>
<td style="text-align:right;">

1299583

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_115_Berlese2_2021-07-02/2021-07-08

</td>
<td style="text-align:right;">

1027604

</td>
<td style="text-align:right;">

1299580

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_115_Pitfall1_2021-07-02/2021-07-04

</td>
<td style="text-align:right;">

1027613

</td>
<td style="text-align:right;">

1299583

</td>
</tr>
<tr>
<td style="text-align:left;">

cole_ANH_115_Pitfall2_2021-07-02/2021-07-04

</td>
<td style="text-align:right;">

1027604

</td>
<td style="text-align:right;">

1299580

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

Displaying records 1 - 50

</caption>
<thead>
<tr>
<th style="text-align:left;">

event_id

</th>
<th style="text-align:left;">

array_agg

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

ANH_130_Winkler1_2022-03-29/2022-03-31

</td>
<td style="text-align:left;">

{2513}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_123_Pitfall1_2021-07-05/2021-07-07

</td>
<td style="text-align:left;">

{1458}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_123_Winkler2_2021-07-05/2021-07-07

</td>
<td style="text-align:left;">

{1464}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_115_Captura manual5_2022-03-21

</td>
<td style="text-align:left;">

{2303}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Captura manual9_2021-07-12

</td>
<td style="text-align:left;">

{1507}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_Trampa de caída atún5_2022-03-29/2022-03-31

</td>
<td style="text-align:left;">

{2447}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_136_Winkler5_2022-03-17/2022-03-19

</td>
<td style="text-align:left;">

{2117}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_Captura manual5_2022-03-31

</td>
<td style="text-align:left;">

{2653}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_373_Pitfall2_2021-07-13/2021-07-15

</td>
<td style="text-align:left;">

{NULL}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_Winkler3_2021-07-12/2021-07-14

</td>
<td style="text-align:left;">

{1440}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_371_Captura manual2_2021-07-08

</td>
<td style="text-align:left;">

{1875}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Pitfall5_2021-07-12/2021-07-14

</td>
<td style="text-align:left;">

{1512}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_Captura manual4_2022-03-29

</td>
<td style="text-align:left;">

{2427}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_373_Pitfall1_2022-03-31/2022-04-02

</td>
<td style="text-align:left;">

{NULL}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_134_Pitfall3_2022-03-22/2022-03-24

</td>
<td style="text-align:left;">

{2585}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_Winkler4_2021-07-13/2021-07-15

</td>
<td style="text-align:left;">

{1666}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_134_Trampa de caída atún4_2022-03-22/2022-03-24

</td>
<td style="text-align:left;">

{2596}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_115_Winkler2_2021-07-02/2021-07-04

</td>
<td style="text-align:left;">

{1314}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_369_Winkler5_2021-07-07/2021-07-09

</td>
<td style="text-align:left;">

{1842}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Captura manual3_2022-03-29

</td>
<td style="text-align:left;">

{2501}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_Winkler2_2021-07-12/2021-07-14

</td>
<td style="text-align:left;">

{1439}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_Trampa de caída atún1_2021-07-13/2021-07-15

</td>
<td style="text-align:left;">

{1668}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Pitfall4_2021-07-12/2021-07-14

</td>
<td style="text-align:left;">

{1511}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_134_Captura manual5_2022-03-22

</td>
<td style="text-align:left;">

{2578}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_Captura manual4_2021-07-13

</td>
<td style="text-align:left;">

{1652}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_115_Trampa de caída atún2_2021-07-02/2021-07-04

</td>
<td style="text-align:left;">

{1319}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_110_Pitfall1_2021-07-14/2021-07-16

</td>
<td style="text-align:left;">

{1208}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_371_Captura manual3_2021-07-08

</td>
<td style="text-align:left;">

{1876}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_134_Winkler4_2022-03-22/2022-03-24

</td>
<td style="text-align:left;">

{2591}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Pitfall3_2021-07-12/2021-07-14

</td>
<td style="text-align:left;">

{1510}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_115_Captura manual5_2021-07-02

</td>
<td style="text-align:left;">

{1303}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_134_Pitfall5_2022-03-22/2022-03-24

</td>
<td style="text-align:left;">

{2587}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_372_Pitfall3_2021-07-13/2021-07-15

</td>
<td style="text-align:left;">

{1910}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Captura manual8_2022-03-29

</td>
<td style="text-align:left;">

{2506}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_133_Winkler1_2021-07-05/2021-07-07

</td>
<td style="text-align:left;">

{1063}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_366_Captura manual4_2021-07-06

</td>
<td style="text-align:left;">

{1777}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_373_Winkler2_2022-03-31/2022-04-02

</td>
<td style="text-align:left;">

{NULL}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Captura manual2_2022-03-29

</td>
<td style="text-align:left;">

{2500}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_370_Captura manual9_2021-07-08

</td>
<td style="text-align:left;">

{1857}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_123_Captura manual3_2021-07-05

</td>
<td style="text-align:left;">

{1451}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_371_Pitfall4_2021-07-08/2021-07-12

</td>
<td style="text-align:left;">

{1886}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_115_Captura manual9_2021-07-02

</td>
<td style="text-align:left;">

{1307}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_136_Winkler5_2021-07-01/2021-07-03

</td>
<td style="text-align:left;">

{1117}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Pitfall5_2022-03-29/2022-03-31

</td>
<td style="text-align:left;">

{2512}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_115_Trampa de caída atún4_2021-07-02/2021-07-04

</td>
<td style="text-align:left;">

{1321}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_Captura manual3_2021-07-12

</td>
<td style="text-align:left;">

{1426}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_136_Trampa de caída atún1_2021-07-01/2021-07-03

</td>
<td style="text-align:left;">

{1118}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Winkler3_2021-07-12/2021-07-14

</td>
<td style="text-align:left;">

{1515}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Trampa de caída atún3_2021-07-12/2021-07-14

</td>
<td style="text-align:left;">

{1520}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Captura manual2_2021-07-12

</td>
<td style="text-align:left;">

{1500}

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

Displaying records 1 - 50

</caption>
<thead>
<tr>
<th style="text-align:left;">

event_id

</th>
<th style="text-align:left;">

array_agg

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

ANH_130_Winkler1_2022-03-29/2022-03-31

</td>
<td style="text-align:left;">

{2513}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_123_Pitfall1_2021-07-05/2021-07-07

</td>
<td style="text-align:left;">

{1458}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_123_Winkler2_2021-07-05/2021-07-07

</td>
<td style="text-align:left;">

{1464}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_115_Captura manual5_2022-03-21

</td>
<td style="text-align:left;">

{2303}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Captura manual9_2021-07-12

</td>
<td style="text-align:left;">

{1507}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_Trampa de caída atún5_2022-03-29/2022-03-31

</td>
<td style="text-align:left;">

{2447}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_136_Winkler5_2022-03-17/2022-03-19

</td>
<td style="text-align:left;">

{2117}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_Captura manual5_2022-03-31

</td>
<td style="text-align:left;">

{2653}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_Winkler3_2021-07-12/2021-07-14

</td>
<td style="text-align:left;">

{1440}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_403_Pitfall2_2021-07-13/2021-07-15

</td>
<td style="text-align:left;">

{1984}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_371_Captura manual2_2021-07-08

</td>
<td style="text-align:left;">

{1875}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Pitfall5_2021-07-12/2021-07-14

</td>
<td style="text-align:left;">

{1512}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_Captura manual4_2022-03-29

</td>
<td style="text-align:left;">

{2427}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_134_Pitfall3_2022-03-22/2022-03-24

</td>
<td style="text-align:left;">

{2585}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_Winkler4_2021-07-13/2021-07-15

</td>
<td style="text-align:left;">

{1666}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_403_Pitfall1_2022-03-31/2022-04-02

</td>
<td style="text-align:left;">

{2983}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_134_Trampa de caída atún4_2022-03-22/2022-03-24

</td>
<td style="text-align:left;">

{2596}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_115_Winkler2_2021-07-02/2021-07-04

</td>
<td style="text-align:left;">

{1314}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_369_Winkler5_2021-07-07/2021-07-09

</td>
<td style="text-align:left;">

{1842}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Captura manual3_2022-03-29

</td>
<td style="text-align:left;">

{2501}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_Winkler2_2021-07-12/2021-07-14

</td>
<td style="text-align:left;">

{1439}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_Trampa de caída atún1_2021-07-13/2021-07-15

</td>
<td style="text-align:left;">

{1668}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Pitfall4_2021-07-12/2021-07-14

</td>
<td style="text-align:left;">

{1511}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_134_Captura manual5_2022-03-22

</td>
<td style="text-align:left;">

{2578}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_Captura manual4_2021-07-13

</td>
<td style="text-align:left;">

{1652}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_115_Trampa de caída atún2_2021-07-02/2021-07-04

</td>
<td style="text-align:left;">

{1319}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_110_Pitfall1_2021-07-14/2021-07-16

</td>
<td style="text-align:left;">

{1208}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_371_Captura manual3_2021-07-08

</td>
<td style="text-align:left;">

{1876}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_134_Winkler4_2022-03-22/2022-03-24

</td>
<td style="text-align:left;">

{2591}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Pitfall3_2021-07-12/2021-07-14

</td>
<td style="text-align:left;">

{1510}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_115_Captura manual5_2021-07-02

</td>
<td style="text-align:left;">

{1303}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_134_Pitfall5_2022-03-22/2022-03-24

</td>
<td style="text-align:left;">

{2587}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_372_Pitfall3_2021-07-13/2021-07-15

</td>
<td style="text-align:left;">

{1910}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Captura manual8_2022-03-29

</td>
<td style="text-align:left;">

{2506}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_133_Winkler1_2021-07-05/2021-07-07

</td>
<td style="text-align:left;">

{1063}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_366_Captura manual4_2021-07-06

</td>
<td style="text-align:left;">

{1777}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_403_Trampa de caída atún2_2022-03-31/2022-04-02

</td>
<td style="text-align:left;">

{2994}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Captura manual2_2022-03-29

</td>
<td style="text-align:left;">

{2500}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_370_Captura manual9_2021-07-08

</td>
<td style="text-align:left;">

{1857}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_123_Captura manual3_2021-07-05

</td>
<td style="text-align:left;">

{1451}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_371_Pitfall4_2021-07-08/2021-07-12

</td>
<td style="text-align:left;">

{1886}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_115_Captura manual9_2021-07-02

</td>
<td style="text-align:left;">

{1307}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_136_Winkler5_2021-07-01/2021-07-03

</td>
<td style="text-align:left;">

{1117}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Pitfall5_2022-03-29/2022-03-31

</td>
<td style="text-align:left;">

{2512}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_115_Trampa de caída atún4_2021-07-02/2021-07-04

</td>
<td style="text-align:left;">

{1321}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_Captura manual3_2021-07-12

</td>
<td style="text-align:left;">

{1426}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_136_Trampa de caída atún1_2021-07-01/2021-07-03

</td>
<td style="text-align:left;">

{1118}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Winkler3_2021-07-12/2021-07-14

</td>
<td style="text-align:left;">

{1515}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Trampa de caída atún3_2021-07-12/2021-07-14

</td>
<td style="text-align:left;">

{1520}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Captura manual2_2021-07-12

</td>
<td style="text-align:left;">

{1500}

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

Displaying records 1 - 50

</caption>
<thead>
<tr>
<th style="text-align:left;">

event_id

</th>
<th style="text-align:right;">

st_x

</th>
<th style="text-align:right;">

st_y

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

ANH_142_Captura manual2_2021-07-13

</td>
<td style="text-align:right;">

1033020

</td>
<td style="text-align:right;">

1300753

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_Captura manual3_2021-07-13

</td>
<td style="text-align:right;">

1033027

</td>
<td style="text-align:right;">

1300738

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_Captura manual4_2021-07-13

</td>
<td style="text-align:right;">

1033027

</td>
<td style="text-align:right;">

1300736

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_Captura manual5_2021-07-13

</td>
<td style="text-align:right;">

1033027

</td>
<td style="text-align:right;">

1300737

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_Trampa de caída atún1_2021-07-13/2021-07-15

</td>
<td style="text-align:right;">

1033025

</td>
<td style="text-align:right;">

1300741

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_Trampa de caída atún5_2021-07-13/2021-07-15

</td>
<td style="text-align:right;">

1033016

</td>
<td style="text-align:right;">

1300746

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_Winkler1_2021-07-13/2021-07-15

</td>
<td style="text-align:right;">

1033025

</td>
<td style="text-align:right;">

1300741

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_Winkler2_2021-07-13/2021-07-15

</td>
<td style="text-align:right;">

1033020

</td>
<td style="text-align:right;">

1300753

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_Winkler3_2021-07-13/2021-07-15

</td>
<td style="text-align:right;">

1033025

</td>
<td style="text-align:right;">

1300741

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_Winkler4_2021-07-13/2021-07-15

</td>
<td style="text-align:right;">

1033009

</td>
<td style="text-align:right;">

1300740

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_Winkler5_2021-07-13/2021-07-15

</td>
<td style="text-align:right;">

1033010

</td>
<td style="text-align:right;">

1300742

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_Captura manual5_2022-03-31

</td>
<td style="text-align:right;">

1033029

</td>
<td style="text-align:right;">

1300735

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_Trampa de caída atún5_2022-03-31/2022-04-02

</td>
<td style="text-align:right;">

1033029

</td>
<td style="text-align:right;">

1300735

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_Winkler5_2022-03-31/2022-04-02

</td>
<td style="text-align:right;">

1033029

</td>
<td style="text-align:right;">

1300735

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_Captura manual10_2022-03-31

</td>
<td style="text-align:right;">

1033023

</td>
<td style="text-align:right;">

1300745

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_Pitfall4_2022-03-31/2022-04-02

</td>
<td style="text-align:right;">

1033023

</td>
<td style="text-align:right;">

1300745

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_Pitfall5_2022-03-31/2022-04-02

</td>
<td style="text-align:right;">

1033021

</td>
<td style="text-align:right;">

1300749

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_366_Captura manual1_2021-07-06

</td>
<td style="text-align:right;">

1034348

</td>
<td style="text-align:right;">

1305184

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_366_Captura manual3_2021-07-06

</td>
<td style="text-align:right;">

1034327

</td>
<td style="text-align:right;">

1305209

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_366_Captura manual4_2021-07-06

</td>
<td style="text-align:right;">

1034325

</td>
<td style="text-align:right;">

1305200

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_366_Pitfall1_2021-07-06/2021-07-08

</td>
<td style="text-align:right;">

1034348

</td>
<td style="text-align:right;">

1305184

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_366_Pitfall3_2021-07-06/2021-07-08

</td>
<td style="text-align:right;">

1034327

</td>
<td style="text-align:right;">

1305209

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_366_Pitfall4_2021-07-06/2021-07-08

</td>
<td style="text-align:right;">

1034325

</td>
<td style="text-align:right;">

1305200

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_366_Winkler1_2021-07-06/2021-07-08

</td>
<td style="text-align:right;">

1034348

</td>
<td style="text-align:right;">

1305184

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_366_Winkler3_2021-07-06/2021-07-08

</td>
<td style="text-align:right;">

1034327

</td>
<td style="text-align:right;">

1305209

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_366_Winkler4_2021-07-06/2021-07-08

</td>
<td style="text-align:right;">

1034325

</td>
<td style="text-align:right;">

1305200

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_369_Captura manual5_2021-07-07

</td>
<td style="text-align:right;">

1029753

</td>
<td style="text-align:right;">

1314080

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_369_Pitfall5_2021-07-07/2021-07-09

</td>
<td style="text-align:right;">

1029753

</td>
<td style="text-align:right;">

1314080

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_369_Trampa de caída atún5_2021-07-07/2021-07-09

</td>
<td style="text-align:right;">

1029753

</td>
<td style="text-align:right;">

1314080

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_369_Winkler5_2021-07-07/2021-07-09

</td>
<td style="text-align:right;">

1029753

</td>
<td style="text-align:right;">

1314080

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_110_Pitfall1_2021-07-14/2021-07-16

</td>
<td style="text-align:right;">

1023811

</td>
<td style="text-align:right;">

1310897

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_Captura manual1_2021-07-12

</td>
<td style="text-align:right;">

1027905

</td>
<td style="text-align:right;">

1312578

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_Captura manual4_2021-07-12

</td>
<td style="text-align:right;">

1027905

</td>
<td style="text-align:right;">

1312578

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_Captura manual2_2021-07-12

</td>
<td style="text-align:right;">

1027879

</td>
<td style="text-align:right;">

1312515

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_Captura manual3_2021-07-12

</td>
<td style="text-align:right;">

1027880

</td>
<td style="text-align:right;">

1312505

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_Trampa de caída atún1_2021-07-12/2021-07-14

</td>
<td style="text-align:right;">

1027905

</td>
<td style="text-align:right;">

1312578

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_Winkler2_2021-07-12/2021-07-14

</td>
<td style="text-align:right;">

1027879

</td>
<td style="text-align:right;">

1312515

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_Winkler3_2021-07-12/2021-07-14

</td>
<td style="text-align:right;">

1027880

</td>
<td style="text-align:right;">

1312505

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_Winkler4_2021-07-12/2021-07-14

</td>
<td style="text-align:right;">

1027876

</td>
<td style="text-align:right;">

1312488

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_Winkler4_2022-03-29/2022-03-31

</td>
<td style="text-align:right;">

1027881

</td>
<td style="text-align:right;">

1312532

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_Winkler5_2022-03-29/2022-03-31

</td>
<td style="text-align:right;">

1027871

</td>
<td style="text-align:right;">

1312540

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_Trampa de caída atún4_2022-03-29/2022-03-31

</td>
<td style="text-align:right;">

1027881

</td>
<td style="text-align:right;">

1312532

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_Trampa de caída atún5_2022-03-29/2022-03-31

</td>
<td style="text-align:right;">

1027871

</td>
<td style="text-align:right;">

1312540

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_Captura manual4_2022-03-29

</td>
<td style="text-align:right;">

1027881

</td>
<td style="text-align:right;">

1312532

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_Captura manual5_2022-03-29

</td>
<td style="text-align:right;">

1027871

</td>
<td style="text-align:right;">

1312540

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_117_Captura manual2_2021-07-06

</td>
<td style="text-align:right;">

1031581

</td>
<td style="text-align:right;">

1311143

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Captura manual1_2021-07-12

</td>
<td style="text-align:right;">

1023737

</td>
<td style="text-align:right;">

1316761

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Captura manual2_2021-07-12

</td>
<td style="text-align:right;">

1023738

</td>
<td style="text-align:right;">

1316777

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Captura manual3_2021-07-12

</td>
<td style="text-align:right;">

1023751

</td>
<td style="text-align:right;">

1316802

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_130_Captura manual4_2021-07-12

</td>
<td style="text-align:right;">

1023737

</td>
<td style="text-align:right;">

1316800

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

Displaying records 1 - 50

</caption>
<thead>
<tr>
<th style="text-align:left;">

event_id

</th>
<th style="text-align:left;">

array_agg

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

ANH_88_M_S3

</td>
<td style="text-align:left;">

{6883}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_72_M_R02_T2

</td>
<td style="text-align:left;">

{7727}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_94_M_S22

</td>
<td style="text-align:left;">

{7157}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_78_M_S13

</td>
<td style="text-align:left;">

{6789}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_72_M_S52

</td>
<td style="text-align:left;">

{6602}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_72_M_S31

</td>
<td style="text-align:left;">

{6579}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S50

</td>
<td style="text-align:left;">

{6906}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_94_M_S64

</td>
<td style="text-align:left;">

{7203}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_92_M_S38

</td>
<td style="text-align:left;">

{6233}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_72_M_S62

</td>
<td style="text-align:left;">

{6613}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_94_M_S62

</td>
<td style="text-align:left;">

{7201}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_72_M_S10

</td>
<td style="text-align:left;">

{6556}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_72_M_S19

</td>
<td style="text-align:left;">

{6565}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_96_M_R09_T2

</td>
<td style="text-align:left;">

{7625}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_72_M_R15

</td>
<td style="text-align:left;">

{6541}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_97_M_R02_T2

</td>
<td style="text-align:left;">

{7882}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S11

</td>
<td style="text-align:left;">

{6863}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_94_M_S2

</td>
<td style="text-align:left;">

{7154}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_94_M_S35

</td>
<td style="text-align:left;">

{7171}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_72_M_S38

</td>
<td style="text-align:left;">

{6586}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_94_M_S70

</td>
<td style="text-align:left;">

{7210}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_94_M_S21

</td>
<td style="text-align:left;">

{7156}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_100_M_S22

</td>
<td style="text-align:left;">

{5902}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_72_M_S42

</td>
<td style="text-align:left;">

{6591}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_97_M_R15

</td>
<td style="text-align:left;">

{7289}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S43

</td>
<td style="text-align:left;">

{6898}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_78_M_R155

</td>
<td style="text-align:left;">

{6769}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_94_M_S49

</td>
<td style="text-align:left;">

{7186}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S46

</td>
<td style="text-align:left;">

{6901}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_72_M_S25

</td>
<td style="text-align:left;">

{6572}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_94_M_S65

</td>
<td style="text-align:left;">

{7204}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_72_M_R19

</td>
<td style="text-align:left;">

{6545}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_71_M_R7

</td>
<td style="text-align:left;">

{6532}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_98_M_R81

</td>
<td style="text-align:left;">

{7307}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_96_M_S64

</td>
<td style="text-align:left;">

{6357}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_78_M_S1

</td>
<td style="text-align:left;">

{6785}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_75_M_R19_T2

</td>
<td style="text-align:left;">

{7790}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_75_M_R04_T2

</td>
<td style="text-align:left;">

{7775}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_78_M_R161

</td>
<td style="text-align:left;">

{6775}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_72_M_R10_T2

</td>
<td style="text-align:left;">

{7735}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_72_M_R6

</td>
<td style="text-align:left;">

{6551}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_93_M_R16_T2

</td>
<td style="text-align:left;">

{7873}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S42

</td>
<td style="text-align:left;">

{6897}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_78_M_S8

</td>
<td style="text-align:left;">

{6853}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_94_M_S42

</td>
<td style="text-align:left;">

{7179}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_72_M_R11

</td>
<td style="text-align:left;">

{6537}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_71_M_R10

</td>
<td style="text-align:left;">

{6516}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_72_M_R8

</td>
<td style="text-align:left;">

{6553}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S48

</td>
<td style="text-align:left;">

{6903}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_90_M_R118

</td>
<td style="text-align:left;">

{7040}

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

Displaying records 1 - 50

</caption>
<thead>
<tr>
<th style="text-align:left;">

event_id

</th>
<th style="text-align:right;">

st_x

</th>
<th style="text-align:right;">

st_y

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

ANH_74_M_R17

</td>
<td style="text-align:right;">

1030071

</td>
<td style="text-align:right;">

1308697

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S10

</td>
<td style="text-align:right;">

1030839

</td>
<td style="text-align:right;">

1306351

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S11

</td>
<td style="text-align:right;">

1030822

</td>
<td style="text-align:right;">

1306309

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S12

</td>
<td style="text-align:right;">

1030810

</td>
<td style="text-align:right;">

1306304

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S13

</td>
<td style="text-align:right;">

1030815

</td>
<td style="text-align:right;">

1306291

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S14

</td>
<td style="text-align:right;">

1030807

</td>
<td style="text-align:right;">

1306289

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S15

</td>
<td style="text-align:right;">

1030817

</td>
<td style="text-align:right;">

1306281

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S16

</td>
<td style="text-align:right;">

1030809

</td>
<td style="text-align:right;">

1306279

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S17

</td>
<td style="text-align:right;">

1030823

</td>
<td style="text-align:right;">

1306283

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S18

</td>
<td style="text-align:right;">

1030810

</td>
<td style="text-align:right;">

1306260

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S19

</td>
<td style="text-align:right;">

1030819

</td>
<td style="text-align:right;">

1306262

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S20

</td>
<td style="text-align:right;">

1030816

</td>
<td style="text-align:right;">

1306255

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S3

</td>
<td style="text-align:right;">

1030830

</td>
<td style="text-align:right;">

1306262

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S37

</td>
<td style="text-align:right;">

1030791

</td>
<td style="text-align:right;">

1306242

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S38

</td>
<td style="text-align:right;">

1030794

</td>
<td style="text-align:right;">

1306259

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S39

</td>
<td style="text-align:right;">

1030794

</td>
<td style="text-align:right;">

1306278

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S4

</td>
<td style="text-align:right;">

1030828

</td>
<td style="text-align:right;">

1306286

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S40

</td>
<td style="text-align:right;">

1030780

</td>
<td style="text-align:right;">

1306278

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S41

</td>
<td style="text-align:right;">

1030782

</td>
<td style="text-align:right;">

1306249

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S43

</td>
<td style="text-align:right;">

1030777

</td>
<td style="text-align:right;">

1306229

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S5

</td>
<td style="text-align:right;">

1030830

</td>
<td style="text-align:right;">

1306296

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S56

</td>
<td style="text-align:right;">

1030764

</td>
<td style="text-align:right;">

1306209

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S57

</td>
<td style="text-align:right;">

1030765

</td>
<td style="text-align:right;">

1306222

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S58

</td>
<td style="text-align:right;">

1030763

</td>
<td style="text-align:right;">

1306228

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S59

</td>
<td style="text-align:right;">

1030765

</td>
<td style="text-align:right;">

1306241

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S6

</td>
<td style="text-align:right;">

1030828

</td>
<td style="text-align:right;">

1306314

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S60

</td>
<td style="text-align:right;">

1030769

</td>
<td style="text-align:right;">

1306248

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S61

</td>
<td style="text-align:right;">

1030752

</td>
<td style="text-align:right;">

1306239

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S62

</td>
<td style="text-align:right;">

1030749

</td>
<td style="text-align:right;">

1306232

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S63

</td>
<td style="text-align:right;">

1030748

</td>
<td style="text-align:right;">

1306225

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S64

</td>
<td style="text-align:right;">

1030748

</td>
<td style="text-align:right;">

1306214

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S65

</td>
<td style="text-align:right;">

1030748

</td>
<td style="text-align:right;">

1306207

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S7

</td>
<td style="text-align:right;">

1030833

</td>
<td style="text-align:right;">

1306325

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S8

</td>
<td style="text-align:right;">

1030826

</td>
<td style="text-align:right;">

1306334

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S9

</td>
<td style="text-align:right;">

1030837

</td>
<td style="text-align:right;">

1306334

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_74_M_R05_T2

</td>
<td style="text-align:right;">

1029594

</td>
<td style="text-align:right;">

1308665

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S1

</td>
<td style="text-align:right;">

1030831

</td>
<td style="text-align:right;">

1306238

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S2

</td>
<td style="text-align:right;">

1030827

</td>
<td style="text-align:right;">

1306253

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S21

</td>
<td style="text-align:right;">

1030810

</td>
<td style="text-align:right;">

1306247

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S22

</td>
<td style="text-align:right;">

1030819

</td>
<td style="text-align:right;">

1306244

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S23

</td>
<td style="text-align:right;">

1030816

</td>
<td style="text-align:right;">

1306236

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S24

</td>
<td style="text-align:right;">

1030808

</td>
<td style="text-align:right;">

1306236

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S25

</td>
<td style="text-align:right;">

1030810

</td>
<td style="text-align:right;">

1306219

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S26

</td>
<td style="text-align:right;">

1030812

</td>
<td style="text-align:right;">

1306217

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S27

</td>
<td style="text-align:right;">

1030816

</td>
<td style="text-align:right;">

1306216

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S28

</td>
<td style="text-align:right;">

1030813

</td>
<td style="text-align:right;">

1306207

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S29

</td>
<td style="text-align:right;">

1030820

</td>
<td style="text-align:right;">

1306205

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S30

</td>
<td style="text-align:right;">

1030812

</td>
<td style="text-align:right;">

1306198

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S31

</td>
<td style="text-align:right;">

1030795

</td>
<td style="text-align:right;">

1306185

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_88_M_S32

</td>
<td style="text-align:right;">

1030793

</td>
<td style="text-align:right;">

1306192

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

3 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

cd_gp_biol

</th>
<th style="text-align:left;">

event_id

</th>
<th style="text-align:left;">

date_time

</th>
<th style="text-align:left;">

date_time_begin

</th>
<th style="text-align:left;">

date_time_end

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

peri

</td>
<td style="text-align:left;">

ANH18-P-A-Bajas

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

2021-07-23 09:30:00

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:left;">

peri

</td>
<td style="text-align:left;">

ANH18-P-B-Bajas

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

2021-07-23 09:30:00

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:left;">

peri

</td>
<td style="text-align:left;">

ANH18-P-C-Bajas

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

2021-07-23 09:30:00

</td>
<td style="text-align:left;">

NA

</td>
</tr>
</tbody>
</table>

</div>

``` sql
SELECT event_id, date_time_begin, date_time_end
FROM main.event e
WHERE event_id ~ 'ANH18-P-[ABC]-Bajas'
```

<div class="knitsql-table">

<table>
<caption>

3 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

event_id

</th>
<th style="text-align:left;">

date_time_begin

</th>
<th style="text-align:left;">

date_time_end

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

ANH18-P-A-Bajas

</td>
<td style="text-align:left;">

2021-07-23 09:30:00

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH18-P-B-Bajas

</td>
<td style="text-align:left;">

2021-07-23 09:30:00

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH18-P-C-Bajas

</td>
<td style="text-align:left;">

2021-07-23 09:30:00

</td>
<td style="text-align:left;">

NA

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

4 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

cd_event

</th>
<th style="text-align:left;">

event_id

</th>
<th style="text-align:right;">

cd_gp_event

</th>
<th style="text-align:right;">

num_replicate

</th>
<th style="text-align:left;">

description_replicate

</th>
<th style="text-align:left;">

date_time_begin

</th>
<th style="text-align:left;">

date_time_end

</th>
<th style="text-align:left;">

locality_verb

</th>
<th style="text-align:right;">

samp_effort_1

</th>
<th style="text-align:right;">

samp_effort_2

</th>
<th style="text-align:left;">

event_remarks

</th>
<th style="text-align:left;">

cds_creator

</th>
<th style="text-align:left;">

created

</th>
<th style="text-align:left;">

pt_geom

</th>
<th style="text-align:left;">

li_geom

</th>
<th style="text-align:left;">

pol_geom

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

173

</td>
<td style="text-align:left;">

ANH_155_Herp_T1_D

</td>
<td style="text-align:right;">

30

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:left;">

Transect:1\|Jornada:D\|Campaign:1

</td>
<td style="text-align:left;">

2021-07-16 15:27:00

</td>
<td style="text-align:left;">

2021-07-16 16:20:00

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

193

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:left;">

Soleado \|\| Soleado \| No hay registro de individuos

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

01020000202C0C000003000000D4908F23754B2F4166A02E54ADF63341843EFBD51C4B2F412936FF649AF63341A4BEF39D0B4B2F417B8763B56BF63341

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:left;">

174

</td>
<td style="text-align:left;">

ANH_155_Herp_T1_N

</td>
<td style="text-align:right;">

30

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:left;">

Transect:1\|Jornada:N\|Campaign:1

</td>
<td style="text-align:left;">

2021-07-16 19:00:00

</td>
<td style="text-align:left;">

2021-07-16 19:50:00

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

193

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:left;">

Despejado

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

01020000202C0C000003000000D4908F23754B2F4166A02E54ADF63341843EFBD51C4B2F412936FF649AF63341A4BEF39D0B4B2F417B8763B56BF63341

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:left;">

175

</td>
<td style="text-align:left;">

ANH_155_Herp_T2_D

</td>
<td style="text-align:right;">

30

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:left;">

Transect:2\|Jornada:D\|Campaign:1

</td>
<td style="text-align:left;">

2021-07-16 16:45:00

</td>
<td style="text-align:left;">

2021-07-16 17:23:00

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

156

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:left;">

Soleado \| No hay registro de individuos

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

01020000202C0C0000030000003DA53009754B2F412455ECDC10F73341358284C1104B2F41BFF33ECB31F73341B1298E32F74A2F411273046A67F73341

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:left;">

176

</td>
<td style="text-align:left;">

ANH_155_Herp_T2_N

</td>
<td style="text-align:right;">

30

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:left;">

Transect:2\|Jornada:N\|Campaign:1

</td>
<td style="text-align:left;">

2021-07-16 20:15:00

</td>
<td style="text-align:left;">

2021-07-16 21:04:00

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

156

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:left;">

Despejado \|\| Despejado \| No hay registro de individuos

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

01020000202C0C0000030000003DA53009754B2F412455ECDC10F73341358284C1104B2F41BFF33ECB31F73341B1298E32F74A2F411273046A67F73341

</td>
<td style="text-align:left;">

NA

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

2 records

</caption>
<thead>
<tr>
<th style="text-align:right;">

st_length

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">

76.43458

</td>
</tr>
<tr>
<td style="text-align:right;">

76.43458

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

Displaying records 1 - 50

</caption>
<thead>
<tr>
<th style="text-align:left;">

event_id

</th>
<th style="text-align:left;">

array_agg

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

ANH_118_T. Van Someren-Rydon4_2022-04-04/2022-04-06

</td>
<td style="text-align:left;">

{837}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_T. Van Someren-Rydon6_2021-07-13/2021-07-15

</td>
<td style="text-align:left;">

{672}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_113_T. Van Someren-Rydon5_2021-07-16/2021-07-18

</td>
<td style="text-align:left;">

{578}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_136_T. Van Someren-Rydon3_2022-03-21/2022-03-23

</td>
<td style="text-align:left;">

{786}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_125_T. Van Someren-Rydon4_2022-04-07/2022-04-09

</td>
<td style="text-align:left;">

{867}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_118_T. Van Someren-Rydon3_2021-07-15/2021-07-17

</td>
<td style="text-align:left;">

{599}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_132_T. Van Someren-Rydon3_2021-07-05/2021-07-07

</td>
<td style="text-align:left;">

{651}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_371_T. Van Someren-Rydon3_2022-03-28/2022-03-30

</td>
<td style="text-align:left;">

{966}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_135_T. Van Someren-Rydon6_2021-07-01/2021-07-03

</td>
<td style="text-align:left;">

{546}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_110_T. Van Someren-Rydon3_2022-04-04/2022-04-06

</td>
<td style="text-align:left;">

{805}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_371_T. Van Someren-Rydon6_2022-03-28/2022-03-30

</td>
<td style="text-align:left;">

{963}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_T. Van Someren-Rydon2_2022-03-31/2022-04-02

</td>
<td style="text-align:left;">

{858}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_T. Van Someren-Rydon6_2021-07-15/2021-07-17

</td>
<td style="text-align:left;">

{622}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_138_T. Van Someren-Rydon4_2021-07-08/2021-07-12

</td>
<td style="text-align:left;">

{669}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_121_T. Van Someren-Rydon6_2022-04-05/2022-04-07

</td>
<td style="text-align:left;">

{853}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_113_T. Van Someren-Rydon5_2022-04-04/2022-04-06

</td>
<td style="text-align:left;">

{812}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_121_T. Van Someren-Rydon2_2022-04-05/2022-04-07

</td>
<td style="text-align:left;">

{849}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_371_T. Van Someren-Rydon4_2022-03-28/2022-03-30

</td>
<td style="text-align:left;">

{965}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_132_T. Van Someren-Rydon4_2021-07-05/2021-07-07

</td>
<td style="text-align:left;">

{648}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_120_T. Van Someren-Rydon1_2022-03-31/2022-04-02

</td>
<td style="text-align:left;">

{842}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_134_T. Van Someren-Rydon4_2022-03-22/2022-03-24

</td>
<td style="text-align:left;">

{890}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_T. Van Someren-Rydon2_2021-07-15/2021-07-17

</td>
<td style="text-align:left;">

{621}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_113_T. Van Someren-Rydon4_2022-04-04/2022-04-06

</td>
<td style="text-align:left;">

{816}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_110_T. Van Someren-Rydon1_2021-07-15/2021-07-17

</td>
<td style="text-align:left;">

{568}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_121_T. Van Someren-Rydon4_2021-07-22/2021-07-24

</td>
<td style="text-align:left;">

{616}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_125_T. Van Someren-Rydon1_2022-04-07/2022-04-09

</td>
<td style="text-align:left;">

{866}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_134_T. Van Someren-Rydon5_2021-07-05/2021-07-07

</td>
<td style="text-align:left;">

{654}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_368_T. Van Someren-Rydon4_2022-04-04/2022-04-06

</td>
<td style="text-align:left;">

{947}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_112_T. Van Someren-Rydon2_2021-07-12/2021-07-14

</td>
<td style="text-align:left;">

{577}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_109_T. Van Someren-Rydon2_2022-04-05/2022-04-07

</td>
<td style="text-align:left;">

{763}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_109_T. Van Someren-Rydon3_2021-07-15/2021-07-17

</td>
<td style="text-align:left;">

{528}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_120_T. Van Someren-Rydon1_2021-07-16/2021-07-18

</td>
<td style="text-align:left;">

{605}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_371_T. Van Someren-Rydon5_2022-03-28/2022-03-30

</td>
<td style="text-align:left;">

{964}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_391_T. Van Someren-Rydon1_2022-03-17/2022-03-19

</td>
<td style="text-align:left;">

{985}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_120_T. Van Someren-Rydon6_2021-07-16/2021-07-18

</td>
<td style="text-align:left;">

{606}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_113_T. Van Someren-Rydon3_2021-07-16/2021-07-18

</td>
<td style="text-align:left;">

{580}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_109_T. Van Someren-Rydon5_2021-07-15/2021-07-17

</td>
<td style="text-align:left;">

{526}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_125_T. Van Someren-Rydon1_2021-07-12/2021-07-14

</td>
<td style="text-align:left;">

{632}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_121_T. Van Someren-Rydon2_2021-07-22/2021-07-24

</td>
<td style="text-align:left;">

{614}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_T. Van Someren-Rydon2_2022-03-31/2022-04-02

</td>
<td style="text-align:left;">

{909}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_109_T. Van Someren-Rydon1_2021-07-15/2021-07-17

</td>
<td style="text-align:left;">

{529}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_T. Van Someren-Rydon4_2022-03-31/2022-04-02

</td>
<td style="text-align:left;">

{855}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_115_T. Van Someren-Rydon3_2022-04-05/2022-04-07

</td>
<td style="text-align:left;">

{826}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_110_T. Van Someren-Rydon4_2021-07-15/2021-07-17

</td>
<td style="text-align:left;">

{566}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_371_T. Van Someren-Rydon3_2021-07-08/2021-07-12

</td>
<td style="text-align:left;">

{724}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_373_T. Van Someren-Rydon2_2021-07-22/2021-07-24

</td>
<td style="text-align:left;">

{736}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_135_T. Van Someren-Rydon3_2021-07-01/2021-07-03

</td>
<td style="text-align:left;">

{542}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_109_T. Van Someren-Rydon5_2022-04-05/2022-04-07

</td>
<td style="text-align:left;">

{760}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_135_T. Van Someren-Rydon5_2021-07-01/2021-07-03

</td>
<td style="text-align:left;">

{547}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_T. Van Someren-Rydon5_2022-03-31/2022-04-02

</td>
<td style="text-align:left;">

{856}

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

Displaying records 1 - 50

</caption>
<thead>
<tr>
<th style="text-align:left;">

event_id

</th>
<th style="text-align:right;">

st_x

</th>
<th style="text-align:right;">

st_y

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

ANH_373_T. Van Someren-Rydon2_2021-07-22/2021-07-24

</td>
<td style="text-align:right;">

1031555

</td>
<td style="text-align:right;">

1300909

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_T. Van Someren-Rydon2_2021-07-13/2021-07-15

</td>
<td style="text-align:right;">

1033002

</td>
<td style="text-align:right;">

1300764

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_T. Van Someren-Rydon4_2021-07-13/2021-07-15

</td>
<td style="text-align:right;">

1033020

</td>
<td style="text-align:right;">

1300736

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_142_T. Van Someren-Rydon2_2022-03-31/2022-04-02

</td>
<td style="text-align:right;">

1033003

</td>
<td style="text-align:right;">

1300765

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_114_T. Van Someren-Rydon6_2021-07-06/2021-07-08

</td>
<td style="text-align:right;">

1034165

</td>
<td style="text-align:right;">

1304576

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_110_T. Van Someren-Rydon1_2022-04-04/2022-04-06

</td>
<td style="text-align:right;">

1023809

</td>
<td style="text-align:right;">

1310937

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_110_T. Van Someren-Rydon2_2022-04-04/2022-04-06

</td>
<td style="text-align:right;">

1023812

</td>
<td style="text-align:right;">

1310992

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_110_T. Van Someren-Rydon3_2022-04-04/2022-04-06

</td>
<td style="text-align:right;">

1023816

</td>
<td style="text-align:right;">

1311076

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_110_T. Van Someren-Rydon4_2022-04-04/2022-04-06

</td>
<td style="text-align:right;">

1023845

</td>
<td style="text-align:right;">

1311139

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_110_T. Van Someren-Rydon5_2022-04-04/2022-04-06

</td>
<td style="text-align:right;">

1023846

</td>
<td style="text-align:right;">

1311214

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_110_T. Van Someren-Rydon6_2022-04-04/2022-04-06

</td>
<td style="text-align:right;">

1023838

</td>
<td style="text-align:right;">

1311269

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_118_T. Van Someren-Rydon1_2021-07-15/2021-07-17

</td>
<td style="text-align:right;">

1023937

</td>
<td style="text-align:right;">

1309442

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_118_T. Van Someren-Rydon4_2021-07-15/2021-07-17

</td>
<td style="text-align:right;">

1023986

</td>
<td style="text-align:right;">

1309366

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_118_T. Van Someren-Rydon5_2021-07-15/2021-07-17

</td>
<td style="text-align:right;">

1024038

</td>
<td style="text-align:right;">

1309372

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_118_T. Van Someren-Rydon6_2021-07-15/2021-07-17

</td>
<td style="text-align:right;">

1024081

</td>
<td style="text-align:right;">

1309375

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_118_T. Van Someren-Rydon4_2022-04-04/2022-04-06

</td>
<td style="text-align:right;">

1024091

</td>
<td style="text-align:right;">

1309352

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_120_T. Van Someren-Rydon1_2021-07-16/2021-07-18

</td>
<td style="text-align:right;">

1024738

</td>
<td style="text-align:right;">

1310173

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_120_T. Van Someren-Rydon2_2021-07-16/2021-07-18

</td>
<td style="text-align:right;">

1024680

</td>
<td style="text-align:right;">

1310213

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_120_T. Van Someren-Rydon5_2021-07-16/2021-07-18

</td>
<td style="text-align:right;">

1024735

</td>
<td style="text-align:right;">

1310251

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_120_T. Van Someren-Rydon4_2022-03-31/2022-04-02

</td>
<td style="text-align:right;">

1024749

</td>
<td style="text-align:right;">

1310246

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_120_T. Van Someren-Rydon5_2022-03-31/2022-04-02

</td>
<td style="text-align:right;">

1024739

</td>
<td style="text-align:right;">

1310161

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_120_T. Van Someren-Rydon6_2022-03-31/2022-04-02

</td>
<td style="text-align:right;">

1024698

</td>
<td style="text-align:right;">

1310187

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_125_T. Van Someren-Rydon1_2022-04-07/2022-04-09

</td>
<td style="text-align:right;">

1029622

</td>
<td style="text-align:right;">

1313919

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_125_T. Van Someren-Rydon4_2022-04-07/2022-04-09

</td>
<td style="text-align:right;">

1029747

</td>
<td style="text-align:right;">

1313838

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_125_T. Van Someren-Rydon6_2021-07-12/2021-07-14

</td>
<td style="text-align:right;">

1029811

</td>
<td style="text-align:right;">

1313806

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_125_T. Van Someren-Rydon2_2022-04-07/2022-04-09

</td>
<td style="text-align:right;">

1029651

</td>
<td style="text-align:right;">

1313876

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_125_T. Van Someren-Rydon3_2022-04-07/2022-04-09

</td>
<td style="text-align:right;">

1029704

</td>
<td style="text-align:right;">

1313881

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_125_T. Van Someren-Rydon5_2022-04-07/2022-04-09

</td>
<td style="text-align:right;">

1029793

</td>
<td style="text-align:right;">

1313810

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_125_T. Van Someren-Rydon6_2022-04-07/2022-04-09

</td>
<td style="text-align:right;">

1029829

</td>
<td style="text-align:right;">

1313848

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_110_T. Van Someren-Rydon2_2021-07-15/2021-07-17

</td>
<td style="text-align:right;">

1023730

</td>
<td style="text-align:right;">

1310736

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_110_T. Van Someren-Rydon1_2021-07-15/2021-07-17

</td>
<td style="text-align:right;">

1023745

</td>
<td style="text-align:right;">

1310790

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_T. Van Someren-Rydon2_2021-07-15/2021-07-17

</td>
<td style="text-align:right;">

1025943

</td>
<td style="text-align:right;">

1311840

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_T. Van Someren-Rydon4_2021-07-15/2021-07-17

</td>
<td style="text-align:right;">

1026035

</td>
<td style="text-align:right;">

1311850

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_T. Van Someren-Rydon5_2021-07-15/2021-07-17

</td>
<td style="text-align:right;">

1026078

</td>
<td style="text-align:right;">

1311837

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_T. Van Someren-Rydon6_2021-07-15/2021-07-17

</td>
<td style="text-align:right;">

1026124

</td>
<td style="text-align:right;">

1311804

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_T. Van Someren-Rydon2_2022-03-31/2022-04-02

</td>
<td style="text-align:right;">

1025912

</td>
<td style="text-align:right;">

1311825

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_T. Van Someren-Rydon3_2022-03-31/2022-04-02

</td>
<td style="text-align:right;">

1025981

</td>
<td style="text-align:right;">

1311861

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_T. Van Someren-Rydon4_2022-03-31/2022-04-02

</td>
<td style="text-align:right;">

1025940

</td>
<td style="text-align:right;">

1311848

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_T. Van Someren-Rydon5_2022-03-31/2022-04-02

</td>
<td style="text-align:right;">

1026041

</td>
<td style="text-align:right;">

1311859

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_T. Van Someren-Rydon6_2022-03-31/2022-04-02

</td>
<td style="text-align:right;">

1026082

</td>
<td style="text-align:right;">

1311844

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_122_T. Van Someren-Rydon3_2021-07-15/2021-07-17

</td>
<td style="text-align:right;">

1025999

</td>
<td style="text-align:right;">

1311828

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_125_T. Van Someren-Rydon1_2021-07-12/2021-07-14

</td>
<td style="text-align:right;">

1029774

</td>
<td style="text-align:right;">

1313895

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_392_T. Van Someren-Rydon5_2021-07-19/2021-07-21

</td>
<td style="text-align:right;">

1040881

</td>
<td style="text-align:right;">

1299290

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_392_T. Van Someren-Rydon6_2021-07-19/2021-07-21

</td>
<td style="text-align:right;">

1040940

</td>
<td style="text-align:right;">

1299287

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_392_T. Van Someren-Rydon5_2022-03-17/2022-03-19

</td>
<td style="text-align:right;">

1040890

</td>
<td style="text-align:right;">

1299279

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_392_T. Van Someren-Rydon6_2022-03-17/2022-03-19

</td>
<td style="text-align:right;">

1040855

</td>
<td style="text-align:right;">

1299286

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_135_T. Van Someren-Rydon1_2021-07-01/2021-07-03

</td>
<td style="text-align:right;">

1021652

</td>
<td style="text-align:right;">

1291809

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_135_T. Van Someren-Rydon2_2021-07-01/2021-07-03

</td>
<td style="text-align:right;">

1021671

</td>
<td style="text-align:right;">

1291785

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_135_T. Van Someren-Rydon3_2021-07-01/2021-07-03

</td>
<td style="text-align:right;">

1021676

</td>
<td style="text-align:right;">

1291801

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_135_T. Van Someren-Rydon4_2021-07-01/2021-07-03

</td>
<td style="text-align:right;">

1021684

</td>
<td style="text-align:right;">

1291820

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

Displaying records 1 - 50

</caption>
<thead>
<tr>
<th style="text-align:left;">

event_id

</th>
<th style="text-align:left;">

array_agg

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

ANH_404_A_R15_T2

</td>
<td style="text-align:left;">

{5873}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_404_A_R2_T2

</td>
<td style="text-align:left;">

{5879}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_82_A_P3_R2_T2

</td>
<td style="text-align:left;">

{5348}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_232_A_P1_R3_T2

</td>
<td style="text-align:left;">

{5389}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_218_A_P3_R1_T2

</td>
<td style="text-align:left;">

{5513}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_252_A_P2_R3_T2

</td>
<td style="text-align:left;">

{5702}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_360_A_P3_R1_T2

</td>
<td style="text-align:left;">

{5402}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_275_A_P1_R2_T2

</td>
<td style="text-align:left;">

{5761}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_398_A_P3_R3_T2

</td>
<td style="text-align:left;">

{5413}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_192_A_P2_R1_T2

</td>
<td style="text-align:left;">

{5465}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_282_A_P2_R2_T1

</td>
<td style="text-align:left;">

{5288}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_154_A_P2_R1_T2

</td>
<td style="text-align:left;">

{5353}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_282_A_P1_R3_T1

</td>
<td style="text-align:left;">

{5286}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_228_A_P1_R2_T2

</td>
<td style="text-align:left;">

{5571}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_82_A_P3_R1_T1

</td>
<td style="text-align:left;">

{4842}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_233_A_P3_R1_T1

</td>
<td style="text-align:left;">

{5100}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_229_A_P1_R1_T2

</td>
<td style="text-align:left;">

{5579}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_197_A_P3_R1_T2

</td>
<td style="text-align:left;">

{5477}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_228_A_P1_R3_T1

</td>
<td style="text-align:left;">

{5069}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_248_A_P3_R2_T2

</td>
<td style="text-align:left;">

{5686}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_250_A_P1_R2_T1

</td>
<td style="text-align:left;">

{5186}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_252_A_P1_R2_T2

</td>
<td style="text-align:left;">

{5698}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_227_A_P1_R3_T2

</td>
<td style="text-align:left;">

{5563}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_401_A_P1_R3_T2

</td>
<td style="text-align:left;">

{5861}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_238_A_P1_R2_T1

</td>
<td style="text-align:left;">

{5122}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_218_A_P3_R2_T2

</td>
<td style="text-align:left;">

{5514}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_197_A_P1_R1_T2

</td>
<td style="text-align:left;">

{5471}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_192_A_P2_R3_T1

</td>
<td style="text-align:left;">

{4964}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_208_A_P2_R3_T2

</td>
<td style="text-align:left;">

{5485}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_192_A_P2_R1_T1

</td>
<td style="text-align:left;">

{4962}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_233_A_P2_R1_T1

</td>
<td style="text-align:left;">

{5097}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_248_A_P3_R1_T1

</td>
<td style="text-align:left;">

{5182}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_227_A_P2_R1_T2

</td>
<td style="text-align:left;">

{5564}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_213_A_P2_R2_T2

</td>
<td style="text-align:left;">

{5502}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_244_A_P3_R2_T1

</td>
<td style="text-align:left;">

{5174}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_239_A_P3_R3_T2

</td>
<td style="text-align:left;">

{5641}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_361_A_P2_R3_T2

</td>
<td style="text-align:left;">

{5819}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_361_A_P2_R2_T1

</td>
<td style="text-align:left;">

{5315}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_248_A_P3_R1_T2

</td>
<td style="text-align:left;">

{5685}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_227_A_P3_R3_T1

</td>
<td style="text-align:left;">

{5066}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_192_A_P3_R3_T2

</td>
<td style="text-align:left;">

{5470}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_239_A_P2_R1_T1

</td>
<td style="text-align:left;">

{5133}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_233_A_P1_R1_T1

</td>
<td style="text-align:left;">

{5094}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_361_A_P2_R3_T1

</td>
<td style="text-align:left;">

{5316}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_239_A_P1_R3_T1

</td>
<td style="text-align:left;">

{5132}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_213_A_P2_R3_T1

</td>
<td style="text-align:left;">

{5000}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_229_A_P3_R3_T1

</td>
<td style="text-align:left;">

{5084}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_208_A_P2_R1_T2

</td>
<td style="text-align:left;">

{5483}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_238_A_P2_R2_T1

</td>
<td style="text-align:left;">

{5125}

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_154_A_P1_R1_T1

</td>
<td style="text-align:left;">

{4845}

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

Displaying records 1 - 50

</caption>
<thead>
<tr>
<th style="text-align:left;">

event_id

</th>
<th style="text-align:right;">

st_x

</th>
<th style="text-align:right;">

st_y

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

aves_ANH_74_A_P3_R1_T1

</td>
<td style="text-align:right;">

1030180

</td>
<td style="text-align:right;">

1309522

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_74_A_P3_R2_T1

</td>
<td style="text-align:right;">

1030180

</td>
<td style="text-align:right;">

1309522

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_74_A_P3_R3_T1

</td>
<td style="text-align:right;">

1030180

</td>
<td style="text-align:right;">

1309522

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_240_A_P1_R1_T1

</td>
<td style="text-align:right;">

1029797

</td>
<td style="text-align:right;">

1309393

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_240_A_P1_R2_T1

</td>
<td style="text-align:right;">

1029797

</td>
<td style="text-align:right;">

1309393

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_240_A_P1_R3_T1

</td>
<td style="text-align:right;">

1029797

</td>
<td style="text-align:right;">

1309393

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_240_A_P3_R1_T1

</td>
<td style="text-align:right;">

1029761

</td>
<td style="text-align:right;">

1309689

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_240_A_P3_R2_T1

</td>
<td style="text-align:right;">

1029761

</td>
<td style="text-align:right;">

1309689

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_240_A_P3_R3_T1

</td>
<td style="text-align:right;">

1029761

</td>
<td style="text-align:right;">

1309689

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_240_A_R9_T1

</td>
<td style="text-align:right;">

1029779

</td>
<td style="text-align:right;">

1309674

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_240_A_R10_T1

</td>
<td style="text-align:right;">

1029778

</td>
<td style="text-align:right;">

1309660

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_240_A_P1_R1_T2

</td>
<td style="text-align:right;">

1029797

</td>
<td style="text-align:right;">

1309393

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_240_A_P1_R2_T2

</td>
<td style="text-align:right;">

1029797

</td>
<td style="text-align:right;">

1309393

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_240_A_P1_R3_T2

</td>
<td style="text-align:right;">

1029797

</td>
<td style="text-align:right;">

1309393

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_240_A_P3_R1_T2

</td>
<td style="text-align:right;">

1029761

</td>
<td style="text-align:right;">

1309689

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_240_A_P3_R2_T2

</td>
<td style="text-align:right;">

1029761

</td>
<td style="text-align:right;">

1309689

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_240_A_P3_R3_T2

</td>
<td style="text-align:right;">

1029761

</td>
<td style="text-align:right;">

1309689

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_74_A_P3_R1_T2

</td>
<td style="text-align:right;">

1030180

</td>
<td style="text-align:right;">

1309522

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_74_A_P3_R2_T2

</td>
<td style="text-align:right;">

1030180

</td>
<td style="text-align:right;">

1309522

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_74_A_P3_R3_T2

</td>
<td style="text-align:right;">

1030180

</td>
<td style="text-align:right;">

1309522

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_240_A_R8_T2

</td>
<td style="text-align:right;">

1029781

</td>
<td style="text-align:right;">

1309656

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_240_A_R9_T2

</td>
<td style="text-align:right;">

1029772

</td>
<td style="text-align:right;">

1309650

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_240_A_R10_T2

</td>
<td style="text-align:right;">

1029764

</td>
<td style="text-align:right;">

1309640

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_252_A_P1_R1_T1

</td>
<td style="text-align:right;">

1034710

</td>
<td style="text-align:right;">

1298200

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_252_A_P1_R2_T1

</td>
<td style="text-align:right;">

1034710

</td>
<td style="text-align:right;">

1298200

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_252_A_P1_R3_T1

</td>
<td style="text-align:right;">

1034710

</td>
<td style="text-align:right;">

1298200

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_252_A_P2_R1_T1

</td>
<td style="text-align:right;">

1034698

</td>
<td style="text-align:right;">

1298411

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_252_A_P2_R2_T1

</td>
<td style="text-align:right;">

1034698

</td>
<td style="text-align:right;">

1298411

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_252_A_P2_R3_T1

</td>
<td style="text-align:right;">

1034698

</td>
<td style="text-align:right;">

1298411

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_252_A_P1_R1_T2

</td>
<td style="text-align:right;">

1034710

</td>
<td style="text-align:right;">

1298200

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_252_A_P1_R2_T2

</td>
<td style="text-align:right;">

1034710

</td>
<td style="text-align:right;">

1298200

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_252_A_P1_R3_T2

</td>
<td style="text-align:right;">

1034710

</td>
<td style="text-align:right;">

1298200

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_252_A_P2_R1_T2

</td>
<td style="text-align:right;">

1034698

</td>
<td style="text-align:right;">

1298411

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_252_A_P2_R2_T2

</td>
<td style="text-align:right;">

1034698

</td>
<td style="text-align:right;">

1298411

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_252_A_P2_R3_T2

</td>
<td style="text-align:right;">

1034698

</td>
<td style="text-align:right;">

1298411

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_250_A_P3_R1_T2

</td>
<td style="text-align:right;">

1031339

</td>
<td style="text-align:right;">

1299877

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_250_A_P3_R2_T2

</td>
<td style="text-align:right;">

1031339

</td>
<td style="text-align:right;">

1299877

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_250_A_P3_R3_T2

</td>
<td style="text-align:right;">

1031339

</td>
<td style="text-align:right;">

1299877

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_397_A_P2_R1_T2

</td>
<td style="text-align:right;">

1036374

</td>
<td style="text-align:right;">

1304781

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_397_A_P2_R2_T2

</td>
<td style="text-align:right;">

1036374

</td>
<td style="text-align:right;">

1304781

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_397_A_P2_R3_T2

</td>
<td style="text-align:right;">

1036374

</td>
<td style="text-align:right;">

1304781

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_396_A_P1_R1_T2

</td>
<td style="text-align:right;">

1041632

</td>
<td style="text-align:right;">

1304344

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_396_A_P1_R2_T2

</td>
<td style="text-align:right;">

1041632

</td>
<td style="text-align:right;">

1304344

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_396_A_P1_R3_T2

</td>
<td style="text-align:right;">

1041632

</td>
<td style="text-align:right;">

1304344

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_244_A_P3_R1_T1

</td>
<td style="text-align:right;">

1037558

</td>
<td style="text-align:right;">

1308057

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_244_A_P3_R2_T1

</td>
<td style="text-align:right;">

1037558

</td>
<td style="text-align:right;">

1308057

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_244_A_P3_R3_T1

</td>
<td style="text-align:right;">

1037558

</td>
<td style="text-align:right;">

1308057

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_244_A_P3_R1_T2

</td>
<td style="text-align:right;">

1037558

</td>
<td style="text-align:right;">

1308057

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_244_A_P3_R2_T2

</td>
<td style="text-align:right;">

1037558

</td>
<td style="text-align:right;">

1308057

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_ANH_244_A_P3_R3_T2

</td>
<td style="text-align:right;">

1037558

</td>
<td style="text-align:right;">

1308057

</td>
</tr>
</tbody>
</table>

</div>

``` r
dbDisconnect(fracking_db)
```

    ## [1] TRUE
