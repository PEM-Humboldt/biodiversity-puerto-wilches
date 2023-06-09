Envio de los datos brutos en la base de datos
================
Marius Bottin
2023-04-19

- [1 Reading rawFiles](#1-reading-rawfiles)
- [2 Getting information to create the
  tables](#2-getting-information-to-create-the-tables)
- [3 create the schema with its raw
  tables](#3-create-the-schema-with-its-raw-tables)
- [4 Cambio “manual” de ANH](#4-cambio-manual-de-anh)
  - [4.1 Colembolos y hormigas de la ANH
    128](#41-colembolos-y-hormigas-de-la-anh-128)
  - [4.2 Colembolos y hormigas de la ANH
    373](#42-colembolos-y-hormigas-de-la-anh-373)
  - [4.3 Aves de la ANH 375](#43-aves-de-la-anh-375)
  - [4.4 Mamiferos ultrasonidos de la ANH
    90](#44-mamiferos-ultrasonidos-de-la-anh-90)
  - [4.5 Modificacions de los ANH de Cameras
    trampa](#45-modificacions-de-los-anh-de-cameras-trampa)
    - [4.5.1 Modificación de un nombre de cuerpo de agua de
      peces](#451-modificación-de-un-nombre-de-cuerpo-de-agua-de-peces)

``` r
knitr::opts_chunk$set(tidy.opts = list(width.cutoff = 70), tidy = TRUE,connection="fracking_db", max.print=100)
require(RPostgreSQL)
require(openxlsx)
require(readxl)
```

------------------------------------------------------------------------

**Note**

For now, I assembled all the DarwinCore data in excel files, as sent by
the researcher to the I2D in a folder “bpw_data_repo” with the same root
as the git repository… In the future, I will adapt my code to download
the real darwin core files (zip folders with various text files). These
files are here:

<https://ipt.biodiversidad.co/iavh/resource.do?r=hormigas_anh_2021>

<http://ipt.biodiversidad.co/iavh/resource.do?r=escarabajos_anh_2021>

<http://ipt.biodiversidad.co/iavh/resource.do?r=collembola_anh_2021>

<http://ipt.biodiversidad.co/iavh/resource.do?r=mariposas_anh_2021>

<http://ipt.biodiversidad.co/iavh/resource.do?r=mamiferos_anh_2021>

<http://ipt.biodiversidad.co/iavh/resource.do?r=hidrob_anh_2021>

<http://ipt.biodiversidad.co/iavh/resource.do?r=hidrobio_fq_anh_2021>

<http://ipt.biodiversidad.co/iavh/resource.do?r=peces_anh_2021>

<http://ipt.biodiversidad.co/iavh/resource.do?r=microorg_anh_2021>

<http://ipt.biodiversidad.co/iavh/resource.do?r=microorg_fq_anh_2022>

<http://ipt.biodiversidad.co/iavh/resource.do?r=sonidos-especaud_anh_2021>

<http://ipt.biodiversidad.co/iavh/resource.do?r=sonidos-ultra_anh_2021>

<http://ipt.biodiversidad.co/iavh/resource.do?r=paisajesonoro_anh_2022>

<http://ipt.biodiversidad.co/iavh/resource.do?r=aves_anh_2021>

<http://ipt.biodiversidad.co/iavh/resource.do?r=anf-rep_anh_2021>

<http://ipt.biodiversidad.co/iavh/resource.do?r=reptiles_anh_2021>

<http://ipt.biodiversidad.co/iavh/resource.do?r=plantas_anh_2021>

<http://ipt.biodiversidad.co/iavh/resource.do?r=rrbb_fototrampeo_anh_aguasaltas_2022>

<http://ipt.biodiversidad.co/iavh/resource.do?r=atropellamiento_anh_2022>

However the code I use here is only working with excel files

------------------------------------------------------------------------

Con el objetivo de poder tratar los datos brutos con códigos SQL, puede
ser útil tener las tablas brutas en un schema de la base de datos.

``` r
fracking_db <- dbConnect(PostgreSQL(), dbname = "fracking")
```

# 1 Reading rawFiles

``` r
# Note: that is not complete just yet, we still have to add extra
# sheets in the files, and maybe the database with the covariables
fol_data <- "../../bpw_data_repo/dwc/"
dataGrupos <- list()
dataGrupos$Anfibios$event <- read.xlsx(file.path(fol_data, "DwC_ANH_Anfibios_v.2.2_Eventos y RegistrosFN 26_revCCastro_Corregido_29_Ago_2022FN.xlsx"),
    sheet = "Eventos", startRow = 2)
dataGrupos$Anfibios$registros <- read.xlsx(file.path(fol_data, "DwC_ANH_Anfibios_v.2.2_Eventos y RegistrosFN 26_revCCastro_Corregido_29_Ago_2022FN.xlsx"),
    sheet = "Anfibios", startRow = 1)
forTime <- read_xlsx(file.path(fol_data, "DwC_ANH_Anfibios_v.2.2_Eventos y RegistrosFN 26_revCCastro_Corregido_29_Ago_2022FN.xlsx"),
    sheet = "Anfibios")
dataGrupos$Anfibios$registros$eventTime <- as.character(format(forTime$eventTime,
    "%H:%M:%S"))
dataGrupos$Reptiles$event <- read.xlsx(file.path(fol_data, "I2D-BIO_2022_060.xlsx"),
    sheet = "Evento", startRow = 1)
dataGrupos$Reptiles$registros <- read.xlsx(file.path(fol_data, "I2D-BIO_2022_060.xlsx"),
    sheet = "Reptiles")
dataGrupos$Atropellamientos$event <- read.xlsx(file.path(fol_data, "I2D-BIO_2022_057.xlsx"),
    sheet = "DwCEventos")
dataGrupos$Atropellamientos$registros <- read.xlsx(file.path(fol_data,
    "I2D-BIO_2022_057.xlsx"), sheet = "Registros")
dataGrupos$Aves$event <- read.xlsx(file.path(fol_data, "I2D-BIO_2021_050_v7.xlsx"),
    sheet = "Eventos", startRow = 2)
dataGrupos$Aves$registros <- read.xlsx(file.path(fol_data, "I2D-BIO_2021_050_v7.xlsx"),
    sheet = "Registros")
dataGrupos$Botanica$event <- read.xlsx(file.path(fol_data, "I2D-BIO_2021_095.xlsx"),
    sheet = "Eventos", startRow = 1)
dataGrupos$Botanica$registros_Arborea <- read.xlsx(file.path(fol_data,
    "I2D-BIO_2021_095.xlsx"), sheet = "Arbórea", startRow = 2)
dataGrupos$Botanica$registros_Epi_vas <- read.xlsx(file.path(fol_data,
    "I2D-BIO_2021_095.xlsx"), sheet = "Epífitas vasculares", startRow = 2)
dataGrupos$Botanica$registros_Epi_novas <- read.xlsx(file.path(fol_data,
    "I2D-BIO_2021_095.xlsx"), sheet = "Epífitas no vasculares", startRow = 2)
dataGrupos$Botanica$registros_col <- read.xlsx(file.path(fol_data, "I2D-BIO_2021_095.xlsx"),
    sheet = "Colección", startRow = 2)
dataGrupos$Collembolos$event <- read.xlsx(file.path(fol_data, "I2D-BIO_2021_099_v3.xlsx"),
    sheet = "DwC_EvCol_2021-2022")
dataGrupos$Collembolos$registros <- read.xlsx(file.path(fol_data, "I2D-BIO_2021_099_v3.xlsx"),
    sheet = "DwC RegCol 2021-2022")
dataGrupos$Collembolos$fotos <- read.xlsx(file.path(fol_data, "I2D-BIO_2021_099_v3.xlsx"),
    sheet = "Imagenes-Collembola")

dataGrupos$Escarabajos$event <- read.xlsx(file.path(fol_data, "I2D-BIO_2021_069_v4_ev.xlsx"),
    sheet = "I2D-BIO_2021_069_event")
dataGrupos$Escarabajos$registros <- read.xlsx(file.path(fol_data, "I2D-BIO_2021_069_v3_rrbb.xlsx"),
    sheet = "Sheet4")
types <- rep("skip", ncol(dataGrupos$Escarabajos$event))
types[colnames(dataGrupos$Escarabajos$event) == "eventTime"] <- "date"



A <- read_xlsx(file.path(fol_data, "I2D-BIO_2021_069_v4_ev.xlsx"), sheet = "I2D-BIO_2021_069_event",
    col_types = types)
dataGrupos$Escarabajos$event$eventTime[!is.na(A)] <- as.character(format(A[!is.na(A)],
    "%H:%M:%S"))
dataGrupos$Escarabajos$event$eventID <- gsub("2012", "2021", dataGrupos$Escarabajos$event$eventID)
types <- rep("skip", ncol(dataGrupos$Escarabajos$event))
types[colnames(dataGrupos$Escarabajos$event) == "eventDate"] <- "date"
A <- read_xlsx(file.path(fol_data, "I2D-BIO_2021_069_v4_ev.xlsx"), sheet = "I2D-BIO_2021_069_event",
    col_types = types)
dataGrupos$Escarabajos$event$eventDate[!is.na(A)] <- as.character(format(A[!is.na(A)],
    "%Y:%m:%d"))
dataGrupos$Escarabajos$event$eventID <- gsub("2012", "2021", dataGrupos$Escarabajos$event$eventID)




dataGrupos$Hormigas$event <- read.xlsx(file.path(fol_data, "I2D-BIO_2021_096_v2_ev.xlsx"),
    sheet = "Eventos")
dataGrupos$Hormigas$registros <- read.xlsx(file.path(fol_data, "I2D-BIO_2021_096_v2_rrbb.xlsx"),
    sheet = "Hoja1")
dataGrupos$Mamiferos$event <- read.xlsx(file.path(fol_data, "I2D-BIO_2021_083_v3.xlsx"),
    sheet = "Evento")
dataGrupos$Mamiferos$registros <- read.xlsx(file.path(fol_data, "I2D-BIO_2021_083_v3.xlsx"),
    sheet = "Registros")
types <- rep("skip", ncol(dataGrupos$Mamiferos$registros))
types[colnames(dataGrupos$Mamiferos$registros) == "eventTime"] <- "date"
A <- read_xlsx(file.path(fol_data, "I2D-BIO_2021_083_v3.xlsx"), sheet = "Registros",
    col_types = types)
dataGrupos$Mamiferos$registros$eventTime[!is.na(A)] <- as.character(format(A[!is.na(A)],
    "%H:%M:%S"))


dataGrupos$Mamiferos_us$event <- read.xlsx(file.path(fol_data, "I2D-BIO_2021_094_v4.xlsx"),
    sheet = "Eventos")
dataGrupos$Mamiferos_us$registros <- read.xlsx(file.path(fol_data, "I2D-BIO_2021_094_v4.xlsx"),
    sheet = "Registros")
types <- rep("skip", ncol(dataGrupos$Mamiferos_us$registros))
types[colnames(dataGrupos$Mamiferos_us$registros) == "eventTime"] <- "date"
A <- read_xlsx(file.path(fol_data, "I2D-BIO_2021_094_v4.xlsx"), sheet = "Registros",
    col_types = types)
dataGrupos$Mamiferos_us$registros$eventTime[!is.na(A)] <- as.character(format(A[!is.na(A)],
    "%H:%M:%S"))

dataGrupos$Mariposas$event <- read.xlsx(file.path(fol_data, "I2D-BIO_2021_084_v3_ev_Sep.xlsx"),
    sheet = "DwCEventos", detectDates = T)
dataGrupos$Mariposas$registros <- read.xlsx(file.path(fol_data, "I2D-BIO_2021_084_v2_rrbb (1).xlsx"),
    sheet = "Plantilla")
dataGrupos$Mariposas$registros$eventTime <- as.character(format(read_xlsx(file.path(fol_data,
    "I2D-BIO_2021_084_v2_rrbb (1).xlsx"), sheet = "Plantilla")$eventTime,
    "%H:%M:%S"))
types <- rep("skip", ncol(dataGrupos$Mariposas$event))
types[colnames(dataGrupos$Mariposas$event) == "eventTime"] <- "date"
A <- read_xlsx(file.path(fol_data, "I2D-BIO_2021_084_v3_ev_Sep.xlsx"),
    sheet = "DwCEventos", col_types = types)$eventTime
dataGrupos$Mariposas$event$eventTime[!is.na(A)] <- as.character(format(A[!is.na(A)],
    "%H:%M:%S"))
# Espacio raro que hace un bug en el codigo más adelante...
dataGrupos$Mariposas$event$eventTime[dataGrupos$Mariposas$event$eventID ==
    "ANH_136_T. Van Someren-Rydon1_2021-07-01/2021-07-03"] <- "09:55:00/10:20:00"



dataGrupos$Peces$event <- read.xlsx(file.path(fol_data, "I2D-BIO_2021_049_v3.xlsx"),
    sheet = "Evento")
dataGrupos$Peces$registros <- read.xlsx(file.path(fol_data, "I2D-BIO_2021_049_v3.xlsx"),
    sheet = "Registro")
dataGrupos$Hidrobiologico$event <- read.xlsx(file.path(fol_data, "I2D-BIO_2021_068_v3 Fn2022.xlsx"),
    sheet = "Hidrobiologicos evento", startRow = 1)
dataGrupos$Hidrobiologico$registros_macroinvertebrados <- read.xlsx(file.path(fol_data,
    "I2D-BIO_2021_068_v3 Fn2022.xlsx"), sheet = "Macroinvertebrados acuáticos",
    startRow = 1)
dataGrupos$Hidrobiologico$registros_macrofitas <- read.xlsx(file.path(fol_data,
    "I2D-BIO_2021_068_v3 Fn2022.xlsx"), sheet = "Macrofitas acuáticas",
    startRow = 1)
dataGrupos$Hidrobiologico$registros_zooplancton <- read.xlsx(file.path(fol_data,
    "I2D-BIO_2021_068_v3 Fn2022.xlsx"), sheet = "Zooplancton ", startRow = 1)
dataGrupos$Hidrobiologico$registros_fitoplancton <- read.xlsx(file.path(fol_data,
    "I2D-BIO_2021_068_v3 Fn2022.xlsx"), sheet = "Fitoplancton", startRow = 1)
dataGrupos$Hidrobiologico$registros_perifiton <- read.xlsx(file.path(fol_data,
    "I2D-BIO_2021_068_v3 Fn2022.xlsx"), sheet = "Perifiton ", startRow = 1)

dataGrupos$Cameras_trampa$event <- read.xlsx(file.path(fol_data, "DwC camaras ANH_13octubre2022_DMM.xlsx"),
    sheet = "Eventos")
dataGrupos$Cameras_trampa$registros <- read.xlsx(file.path(fol_data, "DwC camaras ANH_13octubre2022_DMM.xlsx"),
    sheet = "Registros")
types <- rep("skip", ncol(dataGrupos$Cameras_trampa$registros))
types[colnames(dataGrupos$Cameras_trampa$registros) == "dateIdentified"] <- "date"
A <- read_xlsx(file.path(fol_data, "DwC camaras ANH_13octubre2022_DMM.xlsx"),
    sheet = "Registros", col_types = types)
dataGrupos$Cameras_trampa$registros$dateIdentified[!is.na(A)] <- as.character(format(A[!is.na(A)],
    "%Y/%m/%d"))
types <- rep("skip", ncol(dataGrupos$Cameras_trampa$registros))
types[colnames(dataGrupos$Cameras_trampa$registros) == "eventDate"] <- "date"
A <- read_xlsx(file.path(fol_data, "DwC camaras ANH_13octubre2022_DMM.xlsx"),
    sheet = "Registros", col_types = types)
dataGrupos$Cameras_trampa$registros$eventDate[!is.na(A)] <- as.character(format(A[!is.na(A)],
    "%Y-%m-%d"))

types <- rep("skip", ncol(dataGrupos$Cameras_trampa$registros))
types[colnames(dataGrupos$Cameras_trampa$registros) == "eventDate"] <- "text"
A <- read_xlsx(file.path(fol_data, "DwC camaras ANH_13octubre2022_DMM.xlsx"),
    sheet = "Registros", col_types = types)
dataGrupos$Cameras_trampa$registros$eventDate[grepl("^[0-9]{4}-[0-9]{2}-[0-9]{2}$",
    A$eventDate)] <- A$eventDate[grepl("^[0-9]{4}-[0-9]{2}-[0-9]{2}$",
    A$eventDate)]



save(dataGrupos, file = "./dataGrupos.RData")
```

# 2 Getting information to create the tables

``` r
names_gp_sheets <- lapply(dataGrupos, names)
DF_gp_sheets <- data.frame(gp_biol = rep(names(names_gp_sheets), sapply(names_gp_sheets,
    length)), sheet = Reduce(c, names_gp_sheets))
DF_gp_sheets$registro <- grepl("registro", DF_gp_sheets$sheet)
DF_gp_sheets$name_sql_table <- tolower(paste(DF_gp_sheets$gp_biol, DF_gp_sheets$sheet,
    sep = "_"))
```

# 3 create the schema with its raw tables

``` r
db_schemas <- dbGetQuery(fracking_db, "SELECT schema_name FROM information_schema.schemata")$schema_name
if ("raw_dwc" %in% db_schemas) {
    dbSendQuery(fracking_db, "DROP SCHEMA raw_dwc CASCADE")
}
```

    ## <PostgreSQLResult>

``` r
dbSendQuery(fracking_db, "CREATE SCHEMA raw_dwc")
```

    ## <PostgreSQLResult>

Now let’s send the tables

**Nota**: Necesitamos cambiar los nombres de las columnas de las tablas
antes de enviarlas a SQL, porque:

1.  SQL es insensitivo a las mayusculas/minusculas si los nombres no
    están entre corchetes: es mucho más practico tener solo minusculas
2.  Una tabla no puede haber 2 campos con el mismo nombre
3.  evitar los caracteres especiales en los nombres de campo

``` r
for (i in 1:nrow(DF_gp_sheets)) {
    tab <- dataGrupos[[DF_gp_sheets$gp_biol[i]]][[DF_gp_sheets$sheet[i]]]
    colnames(tab) <- gsub("[().-]", "_", tolower(gsub("([a-z])([A-Z]+)",
        "\\1_\\L\\2", colnames(tab), perl = T)))
    colDupli <- which(duplicated(colnames(tab)))
    rawCN <- colnames(tab)
    for (j in colDupli) {
        number <- sum(rawCN[j:1] == colnames(tab)[j]) - 1
        colnames(tab)[j] <- paste(colnames(tab)[j], number, sep = "_")
    }
    dbWriteTable(fracking_db, c("raw_dwc", DF_gp_sheets$name_sql_table[i]),
        tab)
}
```

# 4 Cambio “manual” de ANH

## 4.1 Colembolos y hormigas de la ANH 128

``` sql
UPDATE raw_dwc.hormigas_event
SET event_id=REGEXP_REPLACE(event_id,'128','402')
WHERE event_id ~ '128';
UPDATE raw_dwc.hormigas_registros
SET event_id=REGEXP_REPLACE(event_id,'128','402')
WHERE event_id ~ '128';
UPDATE raw_dwc.collembolos_event
SET event_id=REGEXP_REPLACE(event_id,'128','402')
WHERE event_id ~ '128';
UPDATE raw_dwc.collembolos_registros
SET event_id=REGEXP_REPLACE(event_id,'128','402')
WHERE event_id ~ '128';
SELECT true;
```

## 4.2 Colembolos y hormigas de la ANH 373

``` sql
UPDATE raw_dwc.hormigas_event
SET event_id=REGEXP_REPLACE(event_id,'373','403')
WHERE event_id ~ '373';
UPDATE raw_dwc.hormigas_registros
SET event_id=REGEXP_REPLACE(event_id,'373','403')
WHERE event_id ~ '373';
UPDATE raw_dwc.collembolos_event
SET event_id=REGEXP_REPLACE(event_id,'373','403')
WHERE event_id ~ '373';
UPDATE raw_dwc.collembolos_registros
SET event_id=REGEXP_REPLACE(event_id,'373','403')
WHERE event_id ~ '373';
SELECT true;
```

## 4.3 Aves de la ANH 375

``` sql
UPDATE raw_dwc.aves_event
SET occurrence_id=REGEXP_REPLACE(occurrence_id,'375','404')
WHERE occurrence_id ~ '375';
UPDATE raw_dwc.aves_registros
SET event_id=REGEXP_REPLACE(event_id,'375','404')
WHERE event_id ~ '375';
SELECT true;
```

## 4.4 Mamiferos ultrasonidos de la ANH 90

``` sql
WITH a AS(
SELECT mue1.event_id event_id1, mue2.event_id event_id2, mue2.decimal_longitude, mue2.decimal_latitude
FROM raw_dwc.mamiferos_us_event mue1
LEFT JOIN raw_dwc.mamiferos_us_event mue2 ON REGEXP_REPLACE(mue2.event_id,'_T2','')=mue1.event_id
WHERE mue1.event_id ~ 'ANH_90' AND mue1.event_id !~ 'T2' AND mue2.event_id ~ 'ANH_90' AND mue2.event_id ~ 'T2'
)
UPDATE raw_dwc.mamiferos_us_event mu
SET decimal_longitude=a.decimal_longitude, decimal_latitude=a.decimal_latitude
FROM a
WHERE event_id=a.event_id1
RETURNING event_id,mu.decimal_latitude,mu.decimal_longitude;
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
<th style="text-align:right;">

decimal_latitude

</th>
<th style="text-align:right;">

decimal_longitude

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

ANH_90_1

</td>
<td style="text-align:right;">

7.273222

</td>
<td style="text-align:right;">

-73.88242

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_90_2

</td>
<td style="text-align:right;">

7.273222

</td>
<td style="text-align:right;">

-73.88242

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH_90_3

</td>
<td style="text-align:right;">

7.273222

</td>
<td style="text-align:right;">

-73.88242

</td>
</tr>
</tbody>
</table>

</div>

## 4.5 Modificacions de los ANH de Cameras trampa

1.  ANH099 -\> ANH185
2.  ANH229 -\> ANH112
3.  ANH208 -\> ANH065

``` sql
UPDATE raw_dwc.cameras_trampa_event
SET event_id=REGEXP_REPLACE(event_id,'099','185')
WHERE event_id ~ '099';
UPDATE raw_dwc.cameras_trampa_registros
SET event_id=REGEXP_REPLACE(event_id,'099','185')
WHERE event_id ~ '099';


UPDATE raw_dwc.cameras_trampa_event
SET event_id=REGEXP_REPLACE(event_id,'229','112')
WHERE event_id ~ '229';
UPDATE raw_dwc.cameras_trampa_registros
SET event_id=REGEXP_REPLACE(event_id,'229','112')
WHERE event_id ~ '229';


UPDATE raw_dwc.cameras_trampa_event
SET event_id=REGEXP_REPLACE(event_id,'208','065')
WHERE event_id ~ '208';
UPDATE raw_dwc.cameras_trampa_registros
SET event_id=REGEXP_REPLACE(event_id,'208','065')
WHERE event_id ~ '208';
```

### 4.5.1 Modificación de un nombre de cuerpo de agua de peces

``` sql
UPDATE raw_dwc.peces_event
SET water_body='Caño Corredor'
WHERE occurrence_id ~ '^ANH_39_' OR occurrence_id ~ '^ANH_42_' OR occurrence_id ~ '^ANH_43_'
```

``` r
dbDisconnect(fracking_db)
```

    ## [1] TRUE
