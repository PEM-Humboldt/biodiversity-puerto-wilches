Exportación de los datos de los grupos
================
Marius Bottin
2023-05-17

- [1 Definición de la functiones](#1-definición-de-la-functiones)
  - [1.1 Pasar a un formato de matriz](#11-pasar-a-un-formato-de-matriz)
  - [1.2 Exportar en Excel](#12-exportar-en-excel)
- [2 Escarabajos](#2-escarabajos)
  - [2.1 Matriz](#21-matriz)
    - [2.1.1 Coprofagos](#211-coprofagos)
    - [2.1.2 Larvas](#212-larvas)
  - [2.2 Información sobre los “sampling unit” de las
    matrices](#22-información-sobre-los-sampling-unit-de-las-matrices)
  - [2.3 Listas](#23-listas)
    - [2.3.1 Lista completa](#231-lista-completa)
    - [2.3.2 Lista por temporada](#232-lista-por-temporada)
    - [2.3.3 Lista por zona y
      temporada](#233-lista-por-zona-y-temporada)
  - [2.4 Exportar: R y Excel](#24-exportar-r-y-excel)
- [3 Phytoplancton](#3-phytoplancton)
  - [3.1 Niveles taxonomicos](#31-niveles-taxonomicos)
  - [3.2 Matriz](#32-matriz)
  - [3.3 Información sobre los “sampling unit” de las
    matrices](#33-información-sobre-los-sampling-unit-de-las-matrices)
  - [3.4 Listas](#34-listas)
    - [3.4.1 Lista completa](#341-lista-completa)
  - [3.5 Exportar: R y Excel](#35-exportar-r-y-excel)
- [4 Perifiton](#4-perifiton)
  - [4.1 Niveles taxonomicos](#41-niveles-taxonomicos)
  - [4.2 Matriz](#42-matriz)
  - [4.3 Información sobre los “sampling unit” de las
    matrices](#43-información-sobre-los-sampling-unit-de-las-matrices)
  - [4.4 Listas](#44-listas)
    - [4.4.1 Lista completa](#441-lista-completa)
    - [4.4.2 Promedio y suma de las abundancias en función de los rangos
      y
      pseudo-rangos](#442-promedio-y-suma-de-las-abundancias-en-función-de-los-rangos-y-pseudo-rangos)
  - [4.5 Exportar: R y Excel](#45-exportar-r-y-excel)
- [5 Macroinvertebrados](#5-macroinvertebrados)
  - [5.1 Niveles taxonomicos](#51-niveles-taxonomicos)
  - [5.2 Matriz](#52-matriz)
  - [5.3 Información sobre los “sampling unit” de las
    matrices](#53-información-sobre-los-sampling-unit-de-las-matrices)
  - [5.4 Listas](#54-listas)
    - [5.4.1 Lista completa](#541-lista-completa)
    - [5.4.2 Promedio y suma de las abundancias en función de los rangos
      y
      pseudo-rangos](#542-promedio-y-suma-de-las-abundancias-en-función-de-los-rangos-y-pseudo-rangos)
  - [5.5 Exportar: R y Excel](#55-exportar-r-y-excel)
- [6 Macrofitas](#6-macrofitas)
  - [6.1 Niveles taxonomicos](#61-niveles-taxonomicos)
  - [6.2 Matriz](#62-matriz)
  - [6.3 Información sobre los “sampling unit” de las
    matrices](#63-información-sobre-los-sampling-unit-de-las-matrices)
  - [6.4 Listas](#64-listas)
    - [6.4.1 Lista completa](#641-lista-completa)
    - [6.4.2 Promedio y suma de las abundancias en función de los rangos
      y
      pseudo-rangos](#642-promedio-y-suma-de-las-abundancias-en-función-de-los-rangos-y-pseudo-rangos)
  - [6.5 Exportar: R y Excel](#65-exportar-r-y-excel)
- [7 Mariposas](#7-mariposas)
  - [7.1 Matriz](#71-matriz)
  - [7.2 Información sobre los “sampling unit” de las
    matrices](#72-información-sobre-los-sampling-unit-de-las-matrices)
  - [7.3 Listas](#73-listas)
    - [7.3.1 Lista completa](#731-lista-completa)
  - [7.4 Exportar: R y Excel](#74-exportar-r-y-excel)
- [8 Hormigas](#8-hormigas)
  - [8.1 Matriz](#81-matriz)
  - [8.2 Información sobre los “sampling unit” de las
    matrices](#82-información-sobre-los-sampling-unit-de-las-matrices)
  - [8.3 Listas](#83-listas)
    - [8.3.1 Lista completa](#831-lista-completa)
  - [8.4 Exportar: R y Excel](#84-exportar-r-y-excel)
- [9 Colémbolos](#9-colémbolos)
  - [9.1 Matrices](#91-matrices)
    - [9.1.1 Berlese](#911-berlese)
    - [9.1.2 Pitfall](#912-pitfall)
    - [9.1.3 Ambos metodos](#913-ambos-metodos)
  - [9.2 Información sobre los “sampling unit” de las
    matrices](#92-información-sobre-los-sampling-unit-de-las-matrices)
  - [9.3 Listas](#93-listas)
    - [9.3.1 Lista completa](#931-lista-completa)
  - [9.4 Exportar: R y Excel](#94-exportar-r-y-excel)
- [10 Peces](#10-peces)
  - [10.1 Niveles taxonomicos](#101-niveles-taxonomicos)
  - [10.2 Matrices](#102-matrices)
    - [10.2.1 Por arte de pesca
      (abundancias)](#1021-por-arte-de-pesca-abundancias)
      - [10.2.1.1 Atarraya](#10211-atarraya)
      - [10.2.1.2 Arrastre](#10212-arrastre)
      - [10.2.1.3 Electropesca](#10213-electropesca)
      - [10.2.1.4 Trasmallo](#10214-trasmallo)
    - [10.2.2 Total (incidencia)](#1022-total-incidencia)
  - [10.3 Información sobre los “sampling unit” de las
    matrices](#103-información-sobre-los-sampling-unit-de-las-matrices)
  - [10.4 Listas](#104-listas)
    - [10.4.1 Lista completa](#1041-lista-completa)
  - [10.5 Exportar: R y Excel](#105-exportar-r-y-excel)
- [11 Mamiferos](#11-mamiferos)
  - [11.1 Metodos y resolución
    taxonomica](#111-metodos-y-resolución-taxonomica)
    - [11.1.1 Total](#1111-total)
    - [11.1.2 Ultrasonidos](#1112-ultrasonidos)
    - [11.1.3 Redes de niebla](#1113-redes-de-niebla)
    - [11.1.4 Trampas Sherman](#1114-trampas-sherman)
  - [11.2 Matrices](#112-matrices)
    - [11.2.1 Ultrasonidos](#1121-ultrasonidos)
    - [11.2.2 Redes de niebla](#1122-redes-de-niebla)
    - [11.2.3 Trampas sherman](#1123-trampas-sherman)
    - [11.2.4 Redes de niebla y
      ultrasonidos](#1124-redes-de-niebla-y-ultrasonidos)
  - [11.3 Información sobre los “sampling unit” de las
    matrices](#113-información-sobre-los-sampling-unit-de-las-matrices)
  - [11.4 Listas](#114-listas)
  - [11.5 Exportar: R y Excel](#115-exportar-r-y-excel)
- [12 Aves](#12-aves)
  - [12.1 Metodos y resolución
    taxonomica](#121-metodos-y-resolución-taxonomica)
    - [12.1.1 Total](#1211-total)
    - [12.1.2 Punto fijo](#1212-punto-fijo)
  - [12.2 Matrices](#122-matrices)
    - [12.2.1 Bird point count](#1221-bird-point-count)
  - [12.3 Información sobre los “sampling unit” de las
    matrices](#123-información-sobre-los-sampling-unit-de-las-matrices)
  - [12.4 Listas](#124-listas)
  - [12.5 Exportar: R y Excel](#125-exportar-r-y-excel)
- [13 Herpetos](#13-herpetos)
  - [13.1 Anfibios](#131-anfibios)
    - [13.1.1 Resolución taxonomica](#1311-resolución-taxonomica)
    - [13.1.2 Matrices](#1312-matrices)
    - [13.1.3 Información sobre los “sampling unit” de las
      matrices](#1313-información-sobre-los-sampling-unit-de-las-matrices)
    - [13.1.4 Listas](#1314-listas)
  - [13.2 Reptiles](#132-reptiles)
    - [13.2.1 Resolución taxonomica](#1321-resolución-taxonomica)
    - [13.2.2 Matrices](#1322-matrices)
    - [13.2.3 Información sobre los “sampling unit” de las
      matrices](#1323-información-sobre-los-sampling-unit-de-las-matrices)
    - [13.2.4 Listas](#1324-listas)
  - [13.3 Exportar: R y Excel](#133-exportar-r-y-excel)
- [14 Zooplancton](#14-zooplancton)
  - [14.1 Niveles taxonomicos](#141-niveles-taxonomicos)
  - [14.2 Matriz](#142-matriz)
  - [14.3 Información sobre los “sampling unit” de las
    matrices](#143-información-sobre-los-sampling-unit-de-las-matrices)
  - [14.4 Listas](#144-listas)
    - [14.4.1 Lista completa](#1441-lista-completa)
  - [14.5 Exportar: R y Excel](#145-exportar-r-y-excel)
- [15 Cameras trampa](#15-cameras-trampa)
  - [15.1 Mamiferos](#151-mamiferos)
    - [15.1.1 Resolución taxonomica](#1511-resolución-taxonomica)
    - [15.1.2 Matrices](#1512-matrices)
    - [15.1.3 Información sobre los “sampling unit” de las
      matrices](#1513-información-sobre-los-sampling-unit-de-las-matrices)
    - [15.1.4 Listas](#1514-listas)
  - [15.2 Reptiles](#152-reptiles)
    - [15.2.1 Resolución taxonomica](#1521-resolución-taxonomica)
    - [15.2.2 Matrices](#1522-matrices)
    - [15.2.3 Información sobre los “sampling unit” de las
      matrices](#1523-información-sobre-los-sampling-unit-de-las-matrices)
    - [15.2.4 Listas](#1524-listas)
  - [15.3 Aves](#153-aves)
    - [15.3.1 Resolución taxonomica](#1531-resolución-taxonomica)
    - [15.3.2 Matrices](#1532-matrices)
    - [15.3.3 Información sobre los “sampling unit” de las
      matrices](#1533-información-sobre-los-sampling-unit-de-las-matrices)
    - [15.3.4 Listas](#1534-listas)
  - [15.4 Exportar: R y Excel](#154-exportar-r-y-excel)

------------------------------------------------------------------------

Se trata en este documento de crear los “VIEWs” principales de
exportación de los datos, y de crear los archivos excel desde R.

------------------------------------------------------------------------

**Note**:

1.  En este documento, mostramos usualmente unicamente las 50 primeras
    filas de las tablas
2.  En las matrices, se excluyen los eventos de muestreo vacíos (sin
    organismos registrados)

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

# 1 Definición de la functiones

## 1.1 Pasar a un formato de matriz

``` r
dbTab2mat <- function(dbTab, col_samplingUnits = "SU", col_species = "sp",
    col_content = "abundance", empty = NA, checklist = F) {
    COLS <- unique(as.character(dbTab[, col_species]))
    ROWS <- unique(as.character(dbTab[, col_samplingUnits]))
    arr.which <- matrix(NA, ncol = 2, nrow = nrow(dbTab), dimnames = list(1:nrow(dbTab),
        c("row", "col")))
    arr.which[, 1] <- match(as.character(dbTab[, col_samplingUnits]), ROWS)
    arr.which[, 2] <- match(as.character(dbTab[, col_species]), COLS)
    modeContent <- ifelse(checklist, "logical", mode(dbTab[, col_content]))
    if (is.na(empty)) {
        empty <- switch(modeContent, character = "", numeric = 0, logical = F)
    }
    res <- matrix(empty, ncol = length(COLS), nrow = length(ROWS), dimnames = list(ROWS,
        COLS))
    if (checklist) {
        res[arr.which] <- T
    } else {
        res[arr.which] <- dbTab[, col_content]
    }
    return(res)
}
```

## 1.2 Exportar en Excel

``` r
save_in_excel <- function(file, lVar) {
    if (!is.list(lVar)) {
        listVar <- mget(lVar, envir = .GlobalEnv)
    } else {
        listVar <- lVar
    }
    wb <- createWorkbook()
    for (i in 1:length(listVar)) {
        addWorksheet(wb, sheetName = names(listVar)[i])
        hasRownames <- !all(grepl("^[0-9]*$", rownames(listVar[[i]])))
        writeDataTable(wb, sheet = names(listVar)[i], listVar[[i]], rowNames = hasRownames)
        nCols <- ifelse(hasRownames, ncol(listVar[[i]]), ncol(listVar[[i]]))
        setColWidths(wb, sheet = names(listVar)[i], cols = 1:nCols, widths = "auto")
    }
    saveWorkbook(wb, file, overwrite = TRUE, )
}
```

# 2 Escarabajos

En escarabajos, exportamos dos matrices diferentes para los análisis:

1.  coprofagos
2.  larvas

Para filtrar los coprofagos: adultos de la subfamilia Scarabaeinae

Para filtrar las larvas:

- larvas
- todas las subfamilias sin Scarabaeinae
- En la capturas manuales solo los gp_event que tienen las trampas 1 a 4

``` sql
WITH a AS(
SELECT dicc.categ life_stage, find_higher_id(cd_tax, 'SFAM') cd_tax, protocol,qt_int
FROM main.registros r 
LEFT JOIN main.individual_characteristics ic USING(cd_reg)
LEFT JOIN main.def_ind_charac_categ dicc ON dicc.cd_var_ind_char= (SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Life stage') AND ic.cd_categ=dicc.cd_categ
LEFT JOIN main.event USING (cd_event) 
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE ge.cd_gp_biol='esca'
)
SELECT life_stage, name_tax subfamily, protocol,count(*) occurrences, sum(qt_int) total_abundance
FROM a
LEFT JOIN main.taxo USING (cd_tax)
GROUP BY life_stage, name_tax, protocol
;
```

<div class="knitsql-table">

</div>

Realmente el filtro coprofagos corresponde al filtro de protocol: todos
los que son de “Human excrement trap” son adultos de Scarabaeinae!

El filtro de larvas tambien se puede simplificar: todas las larvas de
los Insect hand collection no pertenecen a la subfamilia Scarabaeinae.

## 2.1 Matriz

### 2.1.1 Coprofagos

``` sql
CREATE OR REPLACE VIEW esca_coprophage_matrix AS(
SELECT 
  ge.cd_gp_event,
  name_pt_ref||'_'||cd_tempo anh_tempo,
  --r.cd_tax,
  COALESCE(verbatim_taxon||' ('||name_morfo||')', t.name_tax) taxon,
  SUM(qt_int) abundance--,
  -- find_higher_id(r.cd_tax,'SFAM') cd_sfam, 
  -- dicc.categ life_stage,
  -- protocol
FROM main.registros r
LEFT JOIN main.individual_characteristics ic USING(cd_reg)
LEFT JOIN main.def_ind_charac_categ dicc ON dicc.cd_var_ind_char= (SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Life stage') AND ic.cd_categ=dicc.cd_categ
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t USING (cd_tax) --cuidado, hay más de un cd_tax, pero todos deberían ser iguales
LEFT JOIN main.morfo_taxo mt USING(cd_morfo)
LEFT JOIN main.def_tax_rank dtr ON COALESCE(mt.pseudo_rank,t.cd_rank)=dtr.cd_rank
WHERE 
  ge.cd_gp_biol='esca' 
  AND protocol='Human excrement trap' 
  AND dtr.rank_level <= 10
  -- AND dicc.categ='Adult' -- no es util..
  -- AND find_higher_id(r.cd_tax,'SFAM')=(SELECT cd_tax FROM main.taxo WHERE name_tax='Scarabaeinae') -- no es util
GROUP BY 
  ge.cd_gp_event,
  name_pt_ref,
  COALESCE(verbatim_taxon||' ('||name_morfo||')', t.name_tax),
  cd_tempo
ORDER BY 
  name_pt_ref||'_'||cd_tempo,
  SUM(qt_int) DESC
);
```

``` sql
SELECT * FROM esca_coprophage_matrix;
```

<div class="knitsql-table">

</div>

Los registros **excluidos** son:

``` sql
SELECT 
  ge.cd_gp_event,
  name_pt_ref,
  cd_tempo,
  --r.cd_tax,
  COALESCE(verbatim_taxon||' ('||name_morfo||')', t.name_tax) taxon,
  qt_int abundance,
  --t2.name_tax subfamily, 
  dicc.categ life_stage,
  protocol
  -- EXTRACT(YEAR FROM date_time) AS "year"
FROM main.registros r
LEFT JOIN main.individual_characteristics ic USING(cd_reg)
LEFT JOIN main.def_ind_charac_categ dicc ON dicc.cd_var_ind_char= (SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Life stage') AND ic.cd_categ=dicc.cd_categ
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t USING (cd_tax) --cuidado, hay más de un cd_tax, pero todos deberían ser iguales
LEFT JOIN main.morfo_taxo mt USING(cd_morfo)
LEFT JOIN main.def_tax_rank dtr ON COALESCE(mt.pseudo_rank,t.cd_rank)=dtr.cd_rank
--LEFT JOIN main.taxo t2 ON find_higher_id(r.cd_tax,'SFAM')=t2.cd_tax
WHERE 
  ge.cd_gp_biol='esca'
  AND NOT (protocol='Human excrement trap' 
  AND dtr.rank_level <= 10)
  -- AND dicc.categ='Adult' -- no es util..
  -- AND find_higher_id(r.cd_tax,'SFAM')=(SELECT cd_tax FROM main.taxo WHERE name_tax='Scarabaeinae') -- no es util
ORDER BY 
  name_pt_ref||'_'||EXTRACT(YEAR FROM r.date_time),
  qt_int DESC
;
```

<div class="knitsql-table">

</div>

### 2.1.2 Larvas

<!--
Los grupos de eventos que no tienen los 4 eventos de captura manual son los siguientes:
&#10;
&#10;
```sql
SELECT ge.cd_gp_event,name_pt_ref, cd_tempo ,protocol, count(DISTINCT num_replicate)
FROM main.registros r
FULL OUTER JOIN main.event e USING (cd_event)
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
WHERE 
 cd_gp_biol='esca'
  AND protocol = 'Insect hand collection'
GROUP BY ge.cd_gp_event,name_pt_ref,cd_tempo, protocol
HAVING count(DISTINCT num_replicate)<4

**Suma de abundancia excluída en los casos cuando no hay 4 eventos de
captura manual en un grupo**:

``` sql
WITH a AS(
SELECT ge.cd_gp_event,name_pt_ref, cd_tempo ,protocol, count(DISTINCT num_replicate)
FROM main.registros r
FULL OUTER JOIN main.event e USING (cd_event)
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
WHERE 
 cd_gp_biol='esca'
  AND protocol = 'Insect hand collection'
GROUP BY ge.cd_gp_event,name_pt_ref,cd_tempo, protocol
HAVING count(DISTINCT num_replicate)<4
)
SELECT SUM(qt_int) abundancia_excluida
FROM main.registros r
LEFT JOIN main.event e USING (cd_event)
LEFT JOIN main.gp_event USING (cd_gp_event)
WHERE cd_gp_event IN (SELECT cd_gp_event FROM a)
```

**Evento de captura manual que tiene un numero 5**

``` sql
SELECT qt_int,protocol
FROM main.registros 
LEFT JOIN main.event USING (cd_event)
LEFT JOIN main.gp_event USING (cd_gp_event)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE num_replicate=5 AND cd_gp_biol='esca' AND protocol_spa='Insect hand collection'
```

``` sql
CREATE OR REPLACE VIEW esca_larva_matrix AS(
WITH excl AS(--excluding because they are not complete (less than 4 events)
SELECT ge.cd_gp_event
FROM main.registros r
FULL OUTER JOIN main.event e USING (cd_event)
LEFT JOIN main.gp_event ge USING (cd_gp_event)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE 
 cd_gp_biol='esca'
  AND protocol = 'Insect hand collection'
GROUP BY ge.cd_gp_event
HAVING count(DISTINCT num_replicate)<4
)
SELECT 
  ge.cd_gp_event,
  name_pt_ref||'_'||cd_tempo anh_tempo,
  --r.cd_tax,
  CASE
    WHEN r.cd_morfo IS NOT NULL AND mt.pseudo_rank='GN' THEN verbatim_taxon||' ('||name_morfo||')'
    ELSE t.name_tax
  END taxon,
  SUM(qt_int) abundance/*,
  find_higher_id(r.cd_tax,'SFAM') cd_sfam, 
  dicc.categ life_stage,
  protocol*/
FROM main.registros r
LEFT JOIN main.individual_characteristics ic USING(cd_reg)
LEFT JOIN main.def_ind_charac_categ dicc ON dicc.cd_var_ind_char= (SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Life stage') AND ic.cd_categ=dicc.cd_categ
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t ON t.cd_tax=find_higher_id(r.cd_tax,'GN') --cuidado, hay más de un cd_tax, pero todos deberían ser iguales
LEFT JOIN main.morfo_taxo mt USING(cd_morfo)
LEFT JOIN main.def_tax_rank dtr ON COALESCE(mt.pseudo_rank,t.cd_rank)=dtr.cd_rank
WHERE 
  ge.cd_gp_biol='esca' 
  AND protocol='Insect hand collection' 
  AND dtr.rank_level <= (SELECT rank_level FROM main.def_tax_rank WHERE cd_rank='GN')
  AND cd_gp_event NOT IN (SELECT cd_gp_event FROM excl)
  AND dicc.categ='Larva'
  AND find_higher_id(r.cd_tax,'SFAM')!=(SELECT cd_tax FROM main.taxo WHERE name_tax='Scarabaeinae')
  AND num_replicate <=4
GROUP BY 
  ge.cd_gp_event,
  name_pt_ref,
  r.cd_morfo,
  verbatim_taxon,
  name_morfo,
  t.name_tax,
  mt.pseudo_rank,
  cd_tempo,
  find_higher_id(r.cd_tax,'SFAM'), 
  dicc.categ,
  protocol
ORDER BY 
  protocol,
  ge.cd_gp_event,
  name_pt_ref||'_'||cd_tempo,
  SUM(qt_int) DESC
);
```

–\>

    `\footnotesize`{=tex}

    ``` sql
    CREATE OR REPLACE VIEW esca_larva_matrix AS(
    SELECT 
      ge.cd_gp_event,
      name_pt_ref||'_'||cd_tempo anh_tempo,
      --r.cd_tax,
      CASE
        WHEN r.cd_morfo IS NOT NULL AND mt.pseudo_rank='GN' THEN verbatim_taxon||' ('||name_morfo||')'
        ELSE t.name_tax
      END taxon,
      SUM(qt_int) abundance/*,
      find_higher_id(r.cd_tax,'SFAM') cd_sfam, 
      dicc.categ life_stage,
      protocol*/
    FROM main.registros r
    LEFT JOIN main.individual_characteristics ic USING(cd_reg)
    LEFT JOIN main.def_ind_charac_categ dicc ON dicc.cd_var_ind_char= (SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Life stage') AND ic.cd_categ=dicc.cd_categ
    LEFT JOIN main.event e USING (cd_event) 
    LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin) <@ s.date_range
    LEFT JOIN main.gp_event ge USING (cd_gp_event) 
    LEFT JOIN main.punto_referencia USING (cd_pt_ref)
    LEFT JOIN main.def_protocol USING (cd_protocol)
    LEFT JOIN main.taxo t ON t.cd_tax=find_higher_id(r.cd_tax,'GN') --cuidado, hay más de un cd_tax, pero todos deberían ser iguales
    LEFT JOIN main.morfo_taxo mt USING(cd_morfo)
    LEFT JOIN main.def_tax_rank dtr ON COALESCE(mt.pseudo_rank,t.cd_rank)=dtr.cd_rank
    WHERE 
      ge.cd_gp_biol='esca' 
      AND protocol='Insect hand collection' 
      AND dtr.rank_level <= (SELECT rank_level FROM main.def_tax_rank WHERE cd_rank='GN')
      AND dicc.categ='Larva'
      AND find_higher_id(r.cd_tax,'SFAM')!=(SELECT cd_tax FROM main.taxo WHERE name_tax='Scarabaeinae')
    GROUP BY 
      ge.cd_gp_event,
      name_pt_ref,
      r.cd_morfo,
      verbatim_taxon,
      name_morfo,
      t.name_tax,
      mt.pseudo_rank,
      cd_tempo,
      find_higher_id(r.cd_tax,'SFAM'), 
      dicc.categ,
      protocol
    ORDER BY 
      protocol,
      ge.cd_gp_event,
      name_pt_ref||'_'||cd_tempo,
      SUM(qt_int) DESC
    );

## 2.2 Información sobre los “sampling unit” de las matrices

``` sql

CREATE OR REPLACE VIEW esca_info_sampling_coprophage AS(
WITH se AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  SUM(samp_effort_1) "trap_total_time (min)"
FROM main.event e
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.def_season s ON COALESCE((ee.value_text::date||' 12:00:00')::timestamp,e.date_time_begin) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE
  ge.cd_gp_biol='esca' 
  AND protocol='Human excrement trap' 
GROUP BY 
  ge.cd_gp_event,
  name_pt_ref,cd_tempo 
)
SELECT 
  ge.cd_gp_event,
  name_pt_ref||'_'||cd_tempo anh_tempo,
  landcov,
  landcov_spa,
  platform "zone",
  "trap_total_time (min)",
  COUNT(DISTINCT e.cd_event) nb_event,
  ARRAY_AGG(DISTINCT event_id) event_ids,
  sum(qt_int) "total abundance",
  COUNT(DISTINCT COALESCE(verbatim_taxon||' ('||name_morfo||')', t.name_tax)) "total richness",
  ST_X(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) x_coord_centroid,
  ST_Y(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) y_coord_centroid
FROM main.registros r
LEFT JOIN main.individual_characteristics ic USING(cd_reg)
LEFT JOIN main.def_ind_charac_categ dicc ON dicc.cd_var_ind_char= (SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Life stage') AND ic.cd_categ=dicc.cd_categ
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.def_season s ON COALESCE((ee.value_text::date||' 12:00:00')::timestamp,e.date_time_begin) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t USING (cd_tax) --cuidado, hay más de un cd_tax, pero todos deberían ser iguales
LEFT JOIN main.morfo_taxo mt USING(cd_morfo)
LEFT JOIN main.def_tax_rank dtr ON COALESCE(mt.pseudo_rank,t.cd_rank)=dtr.cd_rank
LEFT JOIN punto_ref_platform prf USING (cd_pt_ref,name_pt_ref)
LEFT JOIN landcov_gp_event_terrestrial hge USING (cd_gp_event)
LEFT JOIN se ON se.anh_tempo=name_pt_ref||'_'||cd_tempo
WHERE 
  ge.cd_gp_biol='esca' 
  AND protocol='Human excrement trap' 
GROUP BY 
  ge.cd_gp_event,
  name_pt_ref,
  cd_tempo,
  landcov,
  landcov_spa,
  platform,
  se.anh_tempo,
  "trap_total_time (min)"
ORDER BY 
  name_pt_ref||'_'||cd_tempo,
  SUM(qt_int) DESC
);

CREATE OR REPLACE VIEW esca_info_sampling_larva AS
SELECT 
 ge.cd_gp_event,
 name_pt_ref||'_'||cd_tempo anh_tempo,
 landcov,
 landcov_spa,
 platform "zone",
 COUNT(DISTINCT e.cd_event) nb_event,
 ARRAY_AGG(DISTINCT event_id) event_ids,
 SUM(qt_int) "total abundance without filter",
 SUM(qt_int) FILTER (WHERE dtr.rank_level <= (SELECT rank_level FROM main.def_tax_rank WHERE cd_rank='GN') AND dicc.categ='Larva' AND find_higher_id(r.cd_tax,'SFAM')!=(SELECT cd_tax FROM main.taxo WHERE name_tax='Scarabaeinae')) "total abundance",
 COUNT(DISTINCT CASE
    WHEN r.cd_morfo IS NOT NULL AND mt.pseudo_rank='GN' THEN verbatim_taxon||' ('||name_morfo||')'
    ELSE t.name_tax
  END) "total richness without filter",
  COUNT(DISTINCT CASE
   WHEN r.cd_morfo IS NOT NULL AND mt.pseudo_rank='GN' THEN verbatim_taxon||' ('||name_morfo||')'
   ELSE t.name_tax
  END)  FILTER (WHERE dtr.rank_level <= (SELECT rank_level FROM main.def_tax_rank WHERE cd_rank='GN') AND dicc.categ='Larva' AND find_higher_id(r.cd_tax,'SFAM')!=(SELECT cd_tax FROM main.taxo WHERE name_tax='Scarabaeinae')) "total richness",
  ST_X(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) x_coord_centroid,
  ST_Y(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) y_coord_centroid
FROM main.registros r
LEFT JOIN main.individual_characteristics ic USING(cd_reg)
LEFT JOIN main.def_ind_charac_categ dicc ON dicc.cd_var_ind_char= (SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Life stage') AND ic.cd_categ=dicc.cd_categ
FULL OUTER JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.gp_event ge USING(cd_gp_event)
LEFT JOIN main.def_protocol p USING (cd_protocol)
LEFT JOIN main.def_season s ON COALESCE((ee.value_text::date||' 12:00:00')::timestamp,e.date_time_begin) <@ s.date_range
LEFT JOIN main.punto_referencia pr USING (cd_pt_ref)
LEFT JOIN landcov_gp_event_terrestrial hge USING (cd_gp_event)
LEFT JOIN punto_ref_platform prf USING (cd_pt_ref,name_pt_ref)
LEFT JOIN main.taxo t ON t.cd_tax=find_higher_id(r.cd_tax,'GN') --cuidado, hay más de un cd_tax, pero todos deberían ser iguales
LEFT JOIN main.morfo_taxo mt USING(cd_morfo)
LEFT JOIN main.def_tax_rank dtr ON COALESCE(mt.pseudo_rank,t.cd_rank)=dtr.cd_rank
WHERE 
  ge.cd_gp_biol='esca'
  AND protocol='Insect hand collection'
GROUP BY 
  ge.cd_gp_event,
  name_pt_ref||'_'||cd_tempo,
  landcov,
  landcov_spa,
  platform
```

## 2.3 Listas

### 2.3.1 Lista completa

``` sql
CREATE OR REPLACE VIEW esca_list_tot AS(
WITH a AS(
  SELECT DISTINCT cd_tax,find_higher_id(cd_tax,'GN') cd_gn,find_higher_id(cd_tax,'SFAM') cd_sfam
  FROM main.registros r
  LEFT JOIN main.event USING (cd_event)
  LEFT JOIN main.gp_event USING (cd_gp_event)
), b AS(
  SELECT a.cd_tax, t.name_tax, tsf.name_tax subfamily, tg.name_tax genus
  FROM a
  LEFT JOIN main.taxo t USING (cd_tax)
  LEFT JOIN main.taxo tsf ON a.cd_sfam=tsf.cd_tax
  LEFT JOIN main.taxo tg ON a.cd_gn=tg.cd_tax
)
SELECT 
   subfamily,
   genus,
   COALESCE(verbatim_taxon||' ('||name_morfo||')', t.name_tax) taxon,
   dtr.tax_rank tax_rank,
   dtrm.tax_rank pseudo_rank,
   dicc.categ life_stage,
   ARRAY_AGG(DISTINCT protocol) protocols,
   ARRAY_AGG(DISTINCT cd_tempo) temporadas,
   ARRAY_AGG(DISTINCT name_pt_ref) anh,
   ARRAY_AGG(DISTINCT platform) zonas,
   count(*) occurrence_number,
   SUM(qt_int) total_abundance
FROM main.registros r
LEFT JOIN main.individual_characteristics ic USING(cd_reg)
LEFT JOIN main.def_ind_charac_categ dicc ON dicc.cd_var_ind_char= (SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Life stage') AND ic.cd_categ=dicc.cd_categ
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN b USING (cd_tax)
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.morfo_taxo mt USING(cd_morfo)
LEFT JOIN main.def_tax_rank dtr ON t.cd_rank=dtr.cd_rank
LEFT JOIN main.def_tax_rank dtrm ON mt.pseudo_rank=dtrm.cd_rank
LEFT JOIN punto_ref_platform USING (cd_pt_ref,name_pt_ref)
WHERE
  ge.cd_gp_biol='esca'
GROUP BY 
   subfamily,
   genus,
   COALESCE(verbatim_taxon||' ('||name_morfo||')', t.name_tax),
   dtr.tax_rank,
   dtrm.tax_rank,
   dicc.categ
ORDER BY subfamily,genus,COALESCE(verbatim_taxon||' ('||name_morfo||')', t.name_tax)
)
```

### 2.3.2 Lista por temporada

``` sql
CREATE OR REPLACE VIEW esca_list_tempo AS(
WITH a AS(
  SELECT DISTINCT cd_tax,find_higher_id(cd_tax,'GN') cd_gn,find_higher_id(cd_tax,'SFAM') cd_sfam
  FROM main.registros r
  LEFT JOIN main.event USING (cd_event)
  LEFT JOIN main.gp_event USING (cd_gp_event)
), b AS(
  SELECT a.cd_tax, t.name_tax, tsf.name_tax subfamily, tg.name_tax genus
  FROM a
  LEFT JOIN main.taxo t USING (cd_tax)
  LEFT JOIN main.taxo tsf ON a.cd_sfam=tsf.cd_tax
  LEFT JOIN main.taxo tg ON a.cd_gn=tg.cd_tax
)
SELECT 
   cd_tempo temporada,
   subfamily,
   genus,
   COALESCE(verbatim_taxon||' ('||name_morfo||')', t.name_tax) taxon,
   dtr.tax_rank tax_rank,
   dtrm.tax_rank pseudo_rank,
   dicc.categ life_stage,
   ARRAY_AGG(DISTINCT protocol) protocols,
   ARRAY_AGG(DISTINCT name_pt_ref) anh,
   ARRAY_AGG(DISTINCT platform) zonas,
   count(*) occurrence_number,
   SUM(qt_int) total_abundance
FROM main.registros r
LEFT JOIN main.individual_characteristics ic USING(cd_reg)
LEFT JOIN main.def_ind_charac_categ dicc ON dicc.cd_var_ind_char= (SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Life stage') AND ic.cd_categ=dicc.cd_categ
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN b USING (cd_tax)
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.morfo_taxo mt USING(cd_morfo)
LEFT JOIN main.def_tax_rank dtr ON t.cd_rank=dtr.cd_rank
LEFT JOIN main.def_tax_rank dtrm ON mt.pseudo_rank=dtrm.cd_rank
LEFT JOIN punto_ref_platform USING (cd_pt_ref,name_pt_ref)
WHERE
  ge.cd_gp_biol='esca'
GROUP BY 
   cd_tempo,
   subfamily,
   genus,
   COALESCE(verbatim_taxon||' ('||name_morfo||')', t.name_tax),
   dtr.tax_rank,
   dtrm.tax_rank,
   dicc.categ
ORDER BY cd_tempo,subfamily,genus,COALESCE(verbatim_taxon||' ('||name_morfo||')', t.name_tax)
)
```

### 2.3.3 Lista por zona y temporada

``` sql
CREATE OR REPLACE VIEW esca_list_zona_tempo AS(
WITH a AS(
  SELECT DISTINCT cd_tax,find_higher_id(cd_tax,'GN') cd_gn,find_higher_id(cd_tax,'SFAM') cd_sfam
  FROM main.registros r
  LEFT JOIN main.event USING (cd_event)
  LEFT JOIN main.gp_event USING (cd_gp_event)
), b AS(
  SELECT a.cd_tax, t.name_tax, tsf.name_tax subfamily, tg.name_tax genus
  FROM a
  LEFT JOIN main.taxo t USING (cd_tax)
  LEFT JOIN main.taxo tsf ON a.cd_sfam=tsf.cd_tax
  LEFT JOIN main.taxo tg ON a.cd_gn=tg.cd_tax
)
SELECT 
   platform zona,
   cd_tempo temporada,
   subfamily,
   genus,
   COALESCE(verbatim_taxon||' ('||name_morfo||')', t.name_tax) taxon,
   dtr.tax_rank tax_rank,
   dtrm.tax_rank pseudo_rank,
   dicc.categ life_stage,
   ARRAY_AGG(DISTINCT protocol) protocols,
   ARRAY_AGG(DISTINCT name_pt_ref) anh,
   ARRAY_AGG(DISTINCT platform) zonas,
   count(*) occurrence_number,
   SUM(qt_int) total_abundance
FROM main.registros r
LEFT JOIN main.individual_characteristics ic USING(cd_reg)
LEFT JOIN main.def_ind_charac_categ dicc ON dicc.cd_var_ind_char= (SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Life stage') AND ic.cd_categ=dicc.cd_categ
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN b USING (cd_tax)
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.morfo_taxo mt USING(cd_morfo)
LEFT JOIN main.def_tax_rank dtr ON t.cd_rank=dtr.cd_rank
LEFT JOIN main.def_tax_rank dtrm ON mt.pseudo_rank=dtrm.cd_rank
LEFT JOIN punto_ref_platform USING (cd_pt_ref,name_pt_ref)
WHERE
  ge.cd_gp_biol='esca'
GROUP BY 
   zona,
   cd_tempo,
   subfamily,
   genus,
   COALESCE(verbatim_taxon||' ('||name_morfo||')', t.name_tax),
   dtr.tax_rank,
   dtrm.tax_rank,
   dicc.categ
ORDER BY zona, temporada, subfamily,genus,COALESCE(verbatim_taxon||' ('||name_morfo||')', t.name_tax)
)
```

## 2.4 Exportar: R y Excel

Extraer en R y exportar en excel

``` r
(listTable <- dbGetQuery(fracking_db, "SELECT table_name FROM information_schema.tables WHERE table_schema='public' AND table_name ~ 'esca'")$table_name)
```

    ## [1] "esca_coprophage_matrix"        "esca_larva_matrix"            
    ## [3] "esca_info_sampling_coprophage" "esca_info_sampling_larva"     
    ## [5] "esca_list_tot"                 "esca_list_tempo"              
    ## [7] "esca_list_zona_tempo"

``` r
export_esca <- lapply(listTable, dbReadTable, conn = fracking_db)
names(export_esca) <- listTable
export_esca[grep("matrix", listTable)] <- lapply(export_esca[grep("matrix",
    listTable)], dbTab2mat, col_samplingUnits = "anh_tempo", col_species = "taxon",
    empty = 0)
export_esca <- lapply(export_esca, as.data.frame)
save_in_excel(file = "../../bpw_export//esca_export.xlsx", lVar = export_esca)
```

# 3 Phytoplancton

## 3.1 Niveles taxonomicos

``` sql
SELECT dtr.cd_rank, pseudo_rank,  count(*)
FROM main.registros r
LEFT JOIN main.event e USING (cd_event)
LEFT JOIN main.gp_event ge USING (cd_gp_event)
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.def_tax_rank dtr USING (cd_rank)
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
WHERE ge.cd_gp_biol='fipl'
GROUP BY dtr.cd_rank,dtr.rank_level,pseudo_rank
ORDER BY rank_level DESC
```

<div class="knitsql-table">

</div>

Viendo esos resultados, lo más lógico es trabajar al nivel de la especie
o morfo especie

## 3.2 Matriz

``` sql
CREATE OR REPLACE VIEW fipl_matrix AS(
SELECT 
  ge.cd_gp_event,
  name_pt_ref||'_'||cd_tempo anh_tempo,
  tor.name_tax AS "orden",
  tfam.name_tax AS family,
  tgn.name_tax genus,
  --r.cd_tax,
  COALESCE(verbatim_taxon,t.name_tax) taxon,
  SUM(qt_double)/3 density,
  SUM(qt_int) abs_abundance
FROM main.registros r
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo tfam ON tfam.cd_tax=find_higher_id(r.cd_tax,'FAM')
LEFT JOIN main.taxo tor ON tor.cd_tax=find_higher_id(r.cd_tax,'OR')
LEFT JOIN main.taxo tgn ON tgn.cd_tax=find_higher_id(r.cd_tax,'GN')

WHERE 
  ge.cd_gp_biol='fipl' 
  AND COALESCE(mt.pseudo_rank, t.cd_rank)='SP'
GROUP BY 
  ge.cd_gp_event,
  name_pt_ref,
  verbatim_taxon,
  t.name_tax,
  tor.name_tax,
  tfam.name_tax,
  tgn.name_tax,
  cd_tempo
ORDER BY 
  ge.cd_gp_event,
  name_pt_ref||'_'||cd_tempo,
tor.name_tax ,
tfam.name_tax,
tgn.name_tax
);
```

## 3.3 Información sobre los “sampling unit” de las matrices

``` sql
CREATE OR REPLACE VIEW fipl_info_sampling AS(
WITH se AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  SUM(samp_effort_1) number_of_bottles,
  SUM(samp_effort_2) total_volumen
FROM main.event e
LEFT JOIN main.def_season s ON e.date_time_begin <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE
  ge.cd_gp_biol='fipl' 
GROUP BY 
  ge.cd_gp_event,
  name_pt_ref,cd_tempo 
)
SELECT 
  ge.cd_gp_event,
  name_pt_ref||'_'||cd_tempo anh_tempo,
  wat_body_type, tipo_cuerp_agua,
  eco_type,tipo_ecos,
  platform "zone",
  number_of_bottles,
  total_volumen,
  COUNT(DISTINCT cd_event) nb_events,
  ARRAY_AGG(DISTINCT event_id) event_ids,
  COUNT(DISTINCT COALESCE(verbatim_taxon,t.name_tax)) FILTER (WHERE COALESCE(mt.pseudo_rank, t.cd_rank)='SP') richness,
  SUM(qt_double) FILTER (WHERE COALESCE(mt.pseudo_rank, t.cd_rank)='SP') /COUNT(DISTINCT cd_event)  total_density,
  SUM(qt_double)/COUNT(DISTINCT cd_event) total_density_without_taxo_filter,
  ST_X(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) x_coord_centroid,
  ST_Y(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) y_coord_centroid
FROM main.registros r
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
FULL OUTER JOIN main.event e USING (cd_event) 
LEFT JOIN main.def_season s ON e.date_time_begin <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN habitat_gp_event_aquatic USING (cd_gp_event)
LEFT JOIN punto_ref_platform prp USING (cd_pt_ref,name_pt_ref)
LEFT JOIN se ON se.anh_tempo=name_pt_ref||'_'||cd_tempo
WHERE 
  ge.cd_gp_biol='fipl' 
GROUP BY 
  ge.cd_gp_event,
  name_pt_ref,
  wat_body_type, tipo_cuerp_agua,
  eco_type,tipo_ecos,
  platform,
  number_of_bottles,
  total_volumen,
  cd_tempo
ORDER BY 
  ge.cd_gp_event,
  name_pt_ref||'_'||cd_tempo
);

CREATE OR REPLACE VIEW fipl_envir_water AS

SELECT ge.cd_gp_event,
  name_pt_ref||'_'||s.cd_tempo anh_tempo,
 basin, mean_depth, width_approx, photic_depth, river_clasif, temp, ph, oxy_dis, cond, oxy_sat, tot_sol_situ, tot_org_c, avail_p, mg, cal, na_s, tot_dis_sol, tot_sol, sus_sol, sol_sol, p04, n03, silicates, oil_fat, blue_met_act, carbonates, cal_hard, tot_hard, alk, bicarb
FROM main.event e
LEFT JOIN main.def_season s ON e.date_time_begin <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN 
 ( 
  SELECT * 
  FROM main.phy_chi_hidro_event pche 
  LEFT JOIN main.def_season s2 ON pche.date_time <@ s2.date_range
  LEFT JOIN main.phy_chi_hidro_aguas USING (cd_event_phy_chi)
  WHERE pche.cd_phy_chi_type=(SELECT cd_phy_chi_type FROM main.def_phy_chi_type WHERE phy_chi_type='water')
 ) ag USING (cd_pt_ref,cd_tempo)
WHERE cd_gp_biol='fipl'
GROUP BY ge.cd_gp_event,
  name_pt_ref||'_'||s.cd_tempo,
 basin, mean_depth, width_approx, photic_depth, river_clasif, temp, ph, oxy_dis, cond, oxy_sat, tot_sol_situ, tot_org_c, avail_p, mg, cal, na_s, tot_dis_sol, tot_sol, sus_sol, sol_sol, p04, n03, silicates, oil_fat, blue_met_act, carbonates, cal_hard, tot_hard, alk, bicarb
ORDER BY ge.cd_gp_event
;

CREATE OR REPLACE VIEW fipl_envir_sedim AS

SELECT ge.cd_gp_event,
  name_pt_ref||'_'||s.cd_tempo anh_tempo,
  sand_per, clay_per, silt_per, text_clas, org_c, avail_p, mg, cal, na_s, boron, fe, tot_n
FROM main.event e
LEFT JOIN main.def_season s ON e.date_time_begin <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN 
 (
  SELECT *
  FROM main.phy_chi_hidro_event pche
  LEFT JOIN main.def_season s2 ON pche.date_time <@ s2.date_range
  LEFT JOIN main.phy_chi_hidro_sedi USING (cd_event_phy_chi)
  WHERE pche.cd_phy_chi_type=(SELECT cd_phy_chi_type FROM main.def_phy_chi_type WHERE phy_chi_type='sediment')
 ) se USING  (cd_pt_ref,cd_tempo)
WHERE  cd_gp_biol='fipl'
GROUP BY ge.cd_gp_event,
  name_pt_ref||'_'||s.cd_tempo,
  sand_per, clay_per, silt_per, text_clas, org_c, avail_p, mg, cal, na_s, boron, fe, tot_n
ORDER BY ge.cd_gp_event
;
```

## 3.4 Listas

### 3.4.1 Lista completa

- occurrence number es el numero de registros que tienen la especie (si
  la tabla es limpia, corresponde al numero de evento que contienen el
  taxon)
- la zona está atribuida para cada ANH (se resolvierón los casos de
  eventos fuera de las zonas definidas y las ANH que estaban sobre 2
  zonas distintas

``` sql
CREATE OR REPLACE VIEW fipl_list_tot AS(
WITH a AS(
SELECT count(DISTINCT cd_event) nb_event
FROM main.event
LEFT JOIN main.gp_event USING (cd_gp_event)
WHERE cd_gp_biol='fipl'
)
SELECT 
   tor.name_tax "orden",
   tfam.name_tax "family",
   tgn.name_tax genus,
   COALESCE(verbatim_taxon, t.name_tax) taxon,
   dtr.tax_rank tax_rank,
   dtrm.tax_rank pseudo_rank,
   --ARRAY_AGG(DISTINCT protocol) protocols,
   ARRAY_AGG(DISTINCT cd_tempo) temporadas,
   ARRAY_AGG(DISTINCT name_pt_ref) anh,
   ARRAY_AGG(DISTINCT platform) zonas,
   ARRAY_AGG(DISTINCT tipo_cuerp_agua) tipos_cuerp_agua,
   count(*) "occurrence number",
   SUM(qt_double)/nb_event "mean abundance (ind/L)"
FROM main.registros r
CROSS JOIN a
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.taxo tgn ON find_higher_id(r.cd_tax,'GN')=tgn.cd_tax
LEFT JOIN main.taxo tfam ON find_higher_id(r.cd_tax,'FAM')=tfam.cd_tax
LEFT JOIN main.taxo tor ON find_higher_id(r.cd_tax,'OR')=tor.cd_tax
LEFT JOIN main.morfo_taxo mt USING(cd_morfo)
LEFT JOIN main.def_tax_rank dtr ON t.cd_rank=dtr.cd_rank
LEFT JOIN main.def_tax_rank dtrm ON mt.pseudo_rank=dtrm.cd_rank
LEFT JOIN habitat_gp_event_aquatic USING (cd_gp_event)
LEFT JOIN punto_ref_platform USING (cd_pt_ref,name_pt_ref)
WHERE
  ge.cd_gp_biol='fipl'
GROUP BY 
   tgn.name_tax, 
   tfam.name_tax, 
   tor.name_tax,
   COALESCE(verbatim_taxon, t.name_tax),
   dtr.tax_rank,
   dtrm.tax_rank,
   nb_event
ORDER BY SUM(qt_double)/nb_event DESC
)
;
```

## 3.5 Exportar: R y Excel

Extraer en R y exportar en excel

``` r
(listTable <- dbGetQuery(fracking_db, "SELECT table_name FROM information_schema.tables WHERE table_schema='public' AND table_name ~ '^fipl'")$table_name)
```

    ## [1] "fipl_envir_sedim"   "fipl_envir_water"   "fipl_info_sampling"
    ## [4] "fipl_list_tot"      "fipl_matrix"

``` r
export_fipl <- lapply(listTable, dbReadTable, conn = fracking_db)
names(export_fipl) <- listTable
export_fipl <- c(export_fipl, lapply(export_fipl[grep("matrix", listTable)],
    function(x) {
        col_content <- c("abundance", "density")[c("abundance", "density") %in%
            colnames(x)]
        dbTab2mat(x, col_samplingUnits = "anh_tempo", col_species = "taxon",
            col_content = col_content, empty = 0)
    }))
names(export_fipl)[grepl("matrix", names(export_fipl)) & !sapply(lapply(export_fipl,
    class), function(x) "matrix" %in% x)] <- paste(names(export_fipl)[grepl("matrix",
    names(export_fipl)) & !sapply(lapply(export_fipl, class), function(x) "matrix" %in%
    x)], "_raw", sep = "")
export_fipl <- lapply(export_fipl, as.data.frame)
save_in_excel(file = "../../bpw_export//fipl_export.xlsx", lVar = export_fipl)
```

# 4 Perifiton

## 4.1 Niveles taxonomicos

``` sql
SELECT dtr.cd_rank, pseudo_rank,  count(*)
FROM main.registros r
LEFT JOIN main.event e USING (cd_event)
LEFT JOIN main.gp_event ge USING (cd_gp_event)
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.def_tax_rank dtr USING (cd_rank)
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
WHERE ge.cd_gp_biol='peri'
GROUP BY dtr.cd_rank,dtr.rank_level,pseudo_rank
ORDER BY rank_level DESC
```

<div class="knitsql-table">

</div>

Es mejor trabajar al nivel de genero porque algunos generos o
pseudo-generos corresponden a una abundancia muy fuerte (ver suma de las
abundancias más bajo)

## 4.2 Matriz

``` sql
CREATE OR REPLACE VIEW peri_matrix AS(
SELECT 
  ge.cd_gp_event,
  name_pt_ref||'_'||cd_tempo anh_tempo,
  --r.cd_tax,
  tor.name_tax "orden",
  tfam.name_tax "family",
  CASE
   WHEN mt.pseudo_rank='GN' THEN verbatim_taxon
   ELSE t.name_tax
  END taxon,
  SUM(qt_double)/3 density,
  SUM(qt_int) abs_abundance/*,
  find_higher_id(r.cd_tax,'SFAM') cd_sfam, 
  protocol*/
FROM main.registros r
FULL OUTER JOIN main.event e USING (cd_event) 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'GN')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.taxo tfam ON find_higher_id(r.cd_tax,'FAM')=tfam.cd_tax
LEFT JOIN main.taxo tor ON find_higher_id(r.cd_tax,'OR')=tor.cd_tax
WHERE 
  ge.cd_gp_biol='peri' 
  AND (t.name_tax IS NOT NULL OR mt.pseudo_rank='GN')--ensure we got the genus or pseudo_genus
GROUP BY 
  ge.cd_gp_event,
  name_pt_ref,
  tor.name_tax ,
  tfam.name_tax ,
  taxon,
  cd_tempo
ORDER BY 
  ge.cd_gp_event,
  name_pt_ref||'_'||cd_tempo,
  tor.name_tax ,
  tfam.name_tax ,
  taxon
);
```

## 4.3 Información sobre los “sampling unit” de las matrices

``` sql
CREATE OR REPLACE VIEW peri_info_sampling AS(
WITH se AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  SUM(samp_effort_1) total_scraped_area_cm2,
  SUM(samp_effort_2) number_of_scraped_units
FROM main.event e
LEFT JOIN main.def_season s ON e.date_time_begin <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE
  ge.cd_gp_biol='peri' 
GROUP BY 
  ge.cd_gp_event,
  name_pt_ref,cd_tempo 
)
SELECT 
  ge.cd_gp_event,
  name_pt_ref||'_'||cd_tempo anh_tempo,
  wat_body_type, tipo_cuerp_agua,
  eco_type,tipo_ecos,
  platform "zone",
  total_scraped_area_cm2,
  number_of_scraped_units,
  COUNT(DISTINCT cd_event) nb_events,
  ARRAY_AGG(DISTINCT event_id) event_ids,
  COUNT(DISTINCT 
    CASE
     WHEN mt.pseudo_rank='GN' THEN verbatim_taxon
     ELSE t.name_tax
    END 
  ) FILTER (WHERE t.name_tax IS NOT NULL OR mt.pseudo_rank='GN' ) gn_richness,
  SUM(qt_double) FILTER (WHERE t.name_tax IS NOT NULL OR mt.pseudo_rank='GN') /COUNT(DISTINCT cd_event)  total_density,
  SUM(qt_double)/COUNT(DISTINCT cd_event) total_density_without_taxo_filter,
  ST_X(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) x_coord_centroid,
  ST_Y(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) y_coord_centroid
FROM main.registros r
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'GN')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
FULL OUTER JOIN main.event e USING (cd_event) 
LEFT JOIN main.def_season s ON e.date_time_begin <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN habitat_gp_event_aquatic USING (cd_gp_event)
LEFT JOIN punto_ref_platform prp USING (cd_pt_ref,name_pt_ref)
LEFT JOIN se ON se.anh_tempo=name_pt_ref||'_'||cd_tempo
WHERE 
  ge.cd_gp_biol='peri' 
GROUP BY 
  ge.cd_gp_event,
  name_pt_ref,
  wat_body_type, tipo_cuerp_agua,
  eco_type,tipo_ecos,
  platform,
  total_scraped_area_cm2,
  number_of_scraped_units,
  cd_tempo
ORDER BY 
  ge.cd_gp_event,
  name_pt_ref||'_'||cd_tempo
);

CREATE OR REPLACE VIEW peri_envir_water AS

SELECT ge.cd_gp_event,
  name_pt_ref||'_'||s.cd_tempo anh_tempo,
 basin, mean_depth, width_approx, photic_depth, river_clasif, temp, ph, oxy_dis, cond, oxy_sat, tot_sol_situ, tot_org_c, avail_p, mg, cal, na_s, tot_dis_sol, tot_sol, sus_sol, sol_sol, p04, n03, silicates, oil_fat, blue_met_act, carbonates, cal_hard, tot_hard, alk, bicarb
FROM main.event e
LEFT JOIN main.def_season s ON e.date_time_begin <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN 
 ( 
  SELECT * 
  FROM main.phy_chi_hidro_event pche 
  LEFT JOIN main.def_season s2 ON pche.date_time <@ s2.date_range
  LEFT JOIN main.phy_chi_hidro_aguas USING (cd_event_phy_chi)
  WHERE pche.cd_phy_chi_type=(SELECT cd_phy_chi_type FROM main.def_phy_chi_type WHERE phy_chi_type='water')
 ) ag USING (cd_pt_ref,cd_tempo)
WHERE cd_gp_biol='peri'
GROUP BY ge.cd_gp_event,
  name_pt_ref||'_'||s.cd_tempo,
 basin, mean_depth, width_approx, photic_depth, river_clasif, temp, ph, oxy_dis, cond, oxy_sat, tot_sol_situ, tot_org_c, avail_p, mg, cal, na_s, tot_dis_sol, tot_sol, sus_sol, sol_sol, p04, n03, silicates, oil_fat, blue_met_act, carbonates, cal_hard, tot_hard, alk, bicarb
ORDER BY ge.cd_gp_event
;

CREATE OR REPLACE VIEW peri_envir_sedim AS

SELECT ge.cd_gp_event,
  name_pt_ref||'_'||s.cd_tempo anh_tempo,
  sand_per, clay_per, silt_per, text_clas, org_c, avail_p, mg, cal, na_s, boron, fe, tot_n
FROM main.event e
LEFT JOIN main.def_season s ON e.date_time_begin <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN 
 (
  SELECT *
  FROM main.phy_chi_hidro_event pche
  LEFT JOIN main.def_season s2 ON pche.date_time <@ s2.date_range
  LEFT JOIN main.phy_chi_hidro_sedi USING (cd_event_phy_chi)
  WHERE pche.cd_phy_chi_type=(SELECT cd_phy_chi_type FROM main.def_phy_chi_type WHERE phy_chi_type='sediment')
 ) se USING  (cd_pt_ref,cd_tempo)
WHERE  cd_gp_biol='peri'
GROUP BY ge.cd_gp_event,
  name_pt_ref||'_'||s.cd_tempo,
  sand_per, clay_per, silt_per, text_clas, org_c, avail_p, mg, cal, na_s, boron, fe, tot_n
ORDER BY ge.cd_gp_event
;
```

## 4.4 Listas

### 4.4.1 Lista completa

- occurrence number es el numero de registros que tienen la especie (si
  la tabla es limpia, corresponde al numero de evento que contienen el
  taxon)
- la zona está atribuida para cada ANH (se resolvierón los casos de
  eventos fuera de las zonas definidas y las ANH que estaban sobre 2
  zonas distintas

``` sql
CREATE OR REPLACE VIEW peri_list_tot AS(
WITH a AS(
SELECT count(DISTINCT cd_event) nb_event
FROM main.event
LEFT JOIN main.gp_event USING (cd_gp_event)
WHERE cd_gp_biol='peri'
)
SELECT 
   tor.name_tax "orden",
   tfam.name_tax "family",
   COALESCE(verbatim_taxon, t.name_tax) taxon,
   dtr.tax_rank tax_rank,
   dtrm.tax_rank pseudo_rank,
   --ARRAY_AGG(DISTINCT protocol) protocols,
   ARRAY_AGG(DISTINCT cd_tempo) temporadas,
   ARRAY_AGG(DISTINCT name_pt_ref) anh,
   ARRAY_AGG(DISTINCT platform) zonas,
   ARRAY_AGG(DISTINCT tipo_cuerp_agua) tipos_cuerp_agua,
   count(*) "occurrence number",
   SUM(qt_double)/nb_event "mean density (ind/cm2)"
FROM main.registros r
CROSS JOIN a
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.taxo tfam ON find_higher_id(r.cd_tax,'FAM')=tfam.cd_tax
LEFT JOIN main.taxo tor ON find_higher_id(r.cd_tax,'OR')=tor.cd_tax
LEFT JOIN main.morfo_taxo mt USING(cd_morfo)
LEFT JOIN main.def_tax_rank dtr ON t.cd_rank=dtr.cd_rank
LEFT JOIN main.def_tax_rank dtrm ON mt.pseudo_rank=dtrm.cd_rank
LEFT JOIN habitat_gp_event_aquatic USING (cd_gp_event)
LEFT JOIN punto_ref_platform USING (cd_pt_ref,name_pt_ref)
WHERE
  ge.cd_gp_biol='peri'
GROUP BY 
   tfam.name_tax, 
   tor.name_tax,
   verbatim_taxon,
   t.name_tax,
   dtr.tax_rank,
   dtrm.tax_rank,
   nb_event
ORDER BY SUM(qt_double)/nb_event DESC
)
;
```

### 4.4.2 Promedio y suma de las abundancias en función de los rangos y pseudo-rangos

``` sql
SELECT COALESCE(pseudo_rank,tax_rank) rank_pseudo_rank,SUM("mean density (ind/cm2)") sum_abund, AVG("mean density (ind/cm2)") mean_abund 
FROM peri_list_tot 
GROUP BY COALESCE(pseudo_rank,tax_rank);
```

<div class="knitsql-table">

</div>

<!--
### Lista por temporada
TODO
### Lista por zona y temporada
TODO
### Lista por habitat
TODO
-->

## 4.5 Exportar: R y Excel

Extraer en R y exportar en excel

``` r
(listTable <- dbGetQuery(fracking_db, "SELECT table_name FROM information_schema.tables WHERE table_schema='public' AND table_name ~ '^peri'")$table_name)
```

    ## [1] "peri_envir_sedim"   "peri_envir_water"   "peri_info_sampling"
    ## [4] "peri_list_tot"      "peri_matrix"

``` r
export_peri <- lapply(listTable, dbReadTable, conn = fracking_db)
names(export_peri) <- listTable
export_peri <- c(export_peri, lapply(export_peri[grep("matrix", listTable)],
    function(x) {
        col_content <- c("abundance", "density")[c("abundance", "density") %in%
            colnames(x)]
        dbTab2mat(x, col_samplingUnits = "anh_tempo", col_species = "taxon",
            col_content = col_content, empty = 0)
    }))
names(export_peri)[grepl("matrix", names(export_peri)) & !sapply(lapply(export_peri,
    class), function(x) "matrix" %in% x)] <- paste(names(export_peri)[grepl("matrix",
    names(export_peri)) & !sapply(lapply(export_peri, class), function(x) "matrix" %in%
    x)], "_raw", sep = "")
export_peri <- lapply(export_peri, as.data.frame)
save_in_excel(file = "../../bpw_export//peri_export.xlsx", lVar = export_peri)
```

# 5 Macroinvertebrados

## 5.1 Niveles taxonomicos

``` sql
SELECT dtr.cd_rank, pseudo_rank,  count(*)
FROM main.registros r
LEFT JOIN main.event e USING (cd_event)
LEFT JOIN main.gp_event ge USING (cd_gp_event)
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.def_tax_rank dtr USING (cd_rank)
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
WHERE ge.cd_gp_biol='minv'
GROUP BY dtr.cd_rank,dtr.rank_level,pseudo_rank
ORDER BY rank_level DESC
```

<div class="knitsql-table">

</div>

Es mejor trabajar al nivel de genero porque algunos generos o
pseudo-generos corresponden a una abundancia muy fuerte (ver suma de las
abundancias más bajo)

## 5.2 Matriz

``` sql
CREATE OR REPLACE VIEW minv_matrix AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  --r.cd_tax,
  tor.name_tax "orden",
  tfam.name_tax "family",
  CASE
   WHEN mt.pseudo_rank='GN' THEN verbatim_taxon
   ELSE t.name_tax
  END taxon,
  SUM(qt_double)/3 density,
  SUM(qt_int) abs_abundance/*,
  find_higher_id(r.cd_tax,'SFAM') cd_sfam, 
  protocol*/
FROM main.registros r
FULL OUTER JOIN main.event e USING (cd_event) 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'GN')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.taxo tfam ON find_higher_id(r.cd_tax,'FAM')=tfam.cd_tax
LEFT JOIN main.taxo tor ON find_higher_id(r.cd_tax,'OR')=tor.cd_tax
WHERE 
  ge.cd_gp_biol='minv' 
  AND (t.name_tax IS NOT NULL OR mt.pseudo_rank='GN')--ensure we got the genus or pseudo_genus
GROUP BY 
  name_pt_ref,
  tfam.name_tax,
  tor.name_tax,
  taxon,
  cd_tempo
ORDER BY 
  name_pt_ref||'_'||cd_tempo,
  "orden",
  "family",
  "taxon",
  SUM(qt_double)/3 DESC
);
```

## 5.3 Información sobre los “sampling unit” de las matrices

``` sql
CREATE OR REPLACE VIEW minv_info_sampling AS(
WITH se AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  SUM(samp_effort_1) total_sampled_area_cm2,
  SUM(samp_effort_2) FILTER (WHERE protocol='D net kick sampling') number_of_kicks,
  SUM(samp_effort_2) FILTER (WHERE protocol~'Grab') number_of_replicates
FROM main.event e
LEFT JOIN main.def_season s ON e.date_time_begin <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE
  ge.cd_gp_biol='minv' 
GROUP BY 
  name_pt_ref,cd_tempo 
)
SELECT 
  ARRAY_AGG(DISTINCT cd_gp_event),
  name_pt_ref||'_'||cd_tempo anh_tempo,
  wat_body_type, tipo_cuerp_agua,
  eco_type,tipo_ecos,
  platform "zone",
  ARRAY_AGG(DISTINCT protocol) protocols,ARRAY_AGG(DISTINCT protocol_spa) protocolos,
  total_sampled_area_cm2,
  number_of_kicks,
  number_of_replicates,
  COUNT(DISTINCT cd_event) nb_events,
  ARRAY_AGG(DISTINCT event_id) event_ids,
  COUNT(DISTINCT 
    CASE
     WHEN mt.pseudo_rank='GN' THEN verbatim_taxon
     ELSE t.name_tax
    END 
  ) FILTER (WHERE t.name_tax IS NOT NULL OR mt.pseudo_rank='GN' ) gn_richness,
  SUM(qt_double) FILTER (WHERE t.name_tax IS NOT NULL OR mt.pseudo_rank='GN') /COUNT(DISTINCT cd_event)  total_density,
  SUM(qt_double)/COUNT(DISTINCT cd_event) total_density_without_taxo_filter,
  ST_X(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) x_coord_centroid,
  ST_Y(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) y_coord_centroid
FROM main.registros r
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'GN')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
FULL OUTER JOIN main.event e USING (cd_event) 
LEFT JOIN main.def_season s ON e.date_time_begin <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN habitat_gp_event_aquatic USING (cd_gp_event)
LEFT JOIN punto_ref_platform prp USING (cd_pt_ref,name_pt_ref)
LEFT JOIN se ON se.anh_tempo=name_pt_ref||'_'||cd_tempo
WHERE 
  ge.cd_gp_biol='minv' 
GROUP BY 
  name_pt_ref,
  wat_body_type, tipo_cuerp_agua,
  eco_type,tipo_ecos,
  total_sampled_area_cm2,
  number_of_kicks,
  number_of_replicates,
  platform,
  cd_tempo
ORDER BY 
  name_pt_ref||'_'||cd_tempo
);

CREATE OR REPLACE VIEW minv_envir_water AS

SELECT ARRAY_AGG(DISTINCT cd_gp_event) gps_event,
  name_pt_ref||'_'||s.cd_tempo anh_tempo,
 basin, mean_depth, width_approx, photic_depth, river_clasif, temp, ph, oxy_dis, cond, oxy_sat, tot_sol_situ, tot_org_c, avail_p, mg, cal, na_s, tot_dis_sol, tot_sol, sus_sol, sol_sol, p04, n03, silicates, oil_fat, blue_met_act, carbonates, cal_hard, tot_hard, alk, bicarb
FROM main.event e
LEFT JOIN main.def_season s ON e.date_time_begin <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN 
 ( 
  SELECT * 
  FROM main.phy_chi_hidro_event pche 
  LEFT JOIN main.def_season s2 ON pche.date_time <@ s2.date_range
  LEFT JOIN main.phy_chi_hidro_aguas USING (cd_event_phy_chi)
  WHERE pche.cd_phy_chi_type=(SELECT cd_phy_chi_type FROM main.def_phy_chi_type WHERE phy_chi_type='water')
 ) ag USING (cd_pt_ref,cd_tempo)
WHERE cd_gp_biol='minv'
GROUP BY
  name_pt_ref||'_'||s.cd_tempo,
 basin, mean_depth, width_approx, photic_depth, river_clasif, temp, ph, oxy_dis, cond, oxy_sat, tot_sol_situ, tot_org_c, avail_p, mg, cal, na_s, tot_dis_sol, tot_sol, sus_sol, sol_sol, p04, n03, silicates, oil_fat, blue_met_act, carbonates, cal_hard, tot_hard, alk, bicarb
ORDER BY name_pt_ref||'_'||s.cd_tempo
;

CREATE OR REPLACE VIEW minv_envir_sedim AS

SELECT ARRAY_AGG(DISTINCT cd_gp_event) gps_event,
  name_pt_ref||'_'||s.cd_tempo anh_tempo,
  sand_per, clay_per, silt_per, text_clas, org_c, avail_p, mg, cal, na_s, boron, fe, tot_n
FROM main.event e
LEFT JOIN main.def_season s ON e.date_time_begin <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN 
 (
  SELECT *
  FROM main.phy_chi_hidro_event pche
  LEFT JOIN main.def_season s2 ON pche.date_time <@ s2.date_range
  LEFT JOIN main.phy_chi_hidro_sedi USING (cd_event_phy_chi)
  WHERE pche.cd_phy_chi_type=(SELECT cd_phy_chi_type FROM main.def_phy_chi_type WHERE phy_chi_type='sediment')
 ) se USING  (cd_pt_ref,cd_tempo)
WHERE  cd_gp_biol='minv'
GROUP BY 
  name_pt_ref||'_'||s.cd_tempo,
  sand_per, clay_per, silt_per, text_clas, org_c, avail_p, mg, cal, na_s, boron, fe, tot_n
ORDER BY name_pt_ref||'_'||s.cd_tempo
;
```

## 5.4 Listas

### 5.4.1 Lista completa

- occurrence number es el numero de registros que tienen la especie (si
  la tabla es limpia, corresponde al numero de evento que contienen el
  taxon)
- la zona está atribuida para cada ANH (se resolvierón los casos de
  eventos fuera de las zonas definidas y las ANH que estaban sobre 2
  zonas distintas

``` sql
CREATE OR REPLACE VIEW minv_list_tot AS(
WITH a AS(
SELECT count(DISTINCT cd_event) nb_event
FROM main.event
LEFT JOIN main.gp_event USING (cd_gp_event)
WHERE cd_gp_biol='minv'
)
SELECT 
   tor.name_tax "orden",
   tfam.name_tax "family",
   COALESCE(verbatim_taxon, t.name_tax) taxon,
   dtr.tax_rank tax_rank,
   dtrm.tax_rank pseudo_rank,
   ARRAY_AGG(DISTINCT protocol) protocols,
   ARRAY_AGG(DISTINCT cd_tempo) temporadas,
   ARRAY_AGG(DISTINCT name_pt_ref) anh,
   ARRAY_AGG(DISTINCT platform) zonas,
   ARRAY_AGG(DISTINCT tipo_cuerp_agua) tipos_cuerp_agua,
   count(*) "occurrence number",
   SUM(qt_double)/nb_event "mean density (ind/cm2)"
FROM main.registros r
CROSS JOIN a
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.taxo tfam ON find_higher_id(r.cd_tax,'FAM')=tfam.cd_tax
LEFT JOIN main.taxo tor ON find_higher_id(r.cd_tax,'OR')=tor.cd_tax
LEFT JOIN main.morfo_taxo mt USING(cd_morfo)
LEFT JOIN main.def_tax_rank dtr ON t.cd_rank=dtr.cd_rank
LEFT JOIN main.def_tax_rank dtrm ON mt.pseudo_rank=dtrm.cd_rank
LEFT JOIN habitat_gp_event_aquatic USING (cd_gp_event)
LEFT JOIN punto_ref_platform USING (cd_pt_ref,name_pt_ref)
WHERE
  ge.cd_gp_biol='minv'
GROUP BY 
   tfam.name_tax, 
   tor.name_tax,
   verbatim_taxon,
   t.name_tax,
   dtr.tax_rank,
   dtrm.tax_rank,
   nb_event
ORDER BY SUM(qt_double)/nb_event DESC
)
;
```

### 5.4.2 Promedio y suma de las abundancias en función de los rangos y pseudo-rangos

``` sql
SELECT COALESCE(pseudo_rank,tax_rank) rank_pseudo_rank,SUM("mean density (ind/cm2)") sum_abund, AVG("mean density (ind/cm2)") mean_abund 
FROM minv_list_tot 
GROUP BY COALESCE(pseudo_rank,tax_rank);
```

<div class="knitsql-table">

</div>

<!--
### Lista por temporada
TODO
### Lista por zona y temporada
TODO
### Lista por habitat
TODO
-->

## 5.5 Exportar: R y Excel

Extraer en R y exportar en excel

``` r
(listTable <- dbGetQuery(fracking_db, "SELECT table_name FROM information_schema.tables WHERE table_schema='public' AND table_name ~ '^minv'")$table_name)
```

    ## [1] "minv_envir_sedim"   "minv_envir_water"   "minv_info_sampling"
    ## [4] "minv_list_tot"      "minv_matrix"

``` r
export_minv <- lapply(listTable, dbReadTable, conn = fracking_db)
names(export_minv) <- listTable
export_minv <- c(export_minv, lapply(export_minv[grep("matrix", listTable)],
    function(x) {
        col_content <- c("abundance", "density")[c("abundance", "density") %in%
            colnames(x)]
        dbTab2mat(x, col_samplingUnits = "anh_tempo", col_species = "taxon",
            col_content = col_content, empty = 0)
    }))
names(export_minv)[grepl("matrix", names(export_minv)) & !sapply(lapply(export_minv,
    class), function(x) "matrix" %in% x)] <- paste(names(export_minv)[grepl("matrix",
    names(export_minv)) & !sapply(lapply(export_minv, class), function(x) "matrix" %in%
    x)], "_raw", sep = "")
export_minv <- lapply(export_minv, as.data.frame)
save_in_excel(file = "../../bpw_export//minv_export.xlsx", lVar = export_minv)
```

# 6 Macrofitas

## 6.1 Niveles taxonomicos

``` sql
SELECT dtr.cd_rank, pseudo_rank,  count(*)
FROM main.registros r
LEFT JOIN main.event e USING (cd_event)
LEFT JOIN main.gp_event ge USING (cd_gp_event)
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.def_tax_rank dtr USING (cd_rank)
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
WHERE ge.cd_gp_biol='mafi'
GROUP BY dtr.cd_rank,dtr.rank_level,pseudo_rank
ORDER BY rank_level DESC
```

<div class="knitsql-table">

</div>

## 6.2 Matriz

``` sql
CREATE OR REPLACE VIEW mafi_matrix AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  tor.name_tax "orden",
  tfam.name_tax "family",
  tgn.name_tax "genus",
  CASE
   WHEN mt.pseudo_rank='SP' THEN verbatim_taxon
   ELSE t.name_tax
  END taxon,
  SUM(qt_double) density
FROM main.registros r
FULL OUTER JOIN main.event e USING (cd_event) 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'SP')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.taxo tgn ON find_higher_id(r.cd_tax,'GN')=tgn.cd_tax
LEFT JOIN main.taxo tfam ON find_higher_id(r.cd_tax,'FAM')=tfam.cd_tax
LEFT JOIN main.taxo tor ON find_higher_id(r.cd_tax,'OR')=tor.cd_tax
WHERE 
  ge.cd_gp_biol='mafi' 
  AND (t.name_tax IS NOT NULL OR mt.pseudo_rank='SP')--ensure we got the species or morphospecies
GROUP BY 
  name_pt_ref,
  tor.name_tax,
  tfam.name_tax,
  tgn.name_tax ,
  taxon,
  cd_tempo
ORDER BY 
  name_pt_ref||'_'||cd_tempo,
  tor.name_tax,
  tfam.name_tax,
  tgn.name_tax ,
  taxon
);
```

## 6.3 Información sobre los “sampling unit” de las matrices

``` sql
CREATE OR REPLACE VIEW mafi_info_sampling AS(
WITH se AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  SUM(samp_effort_1) total_sampled_area_m2,
  SUM(samp_effort_2) number_of_quadrats
FROM main.event e
LEFT JOIN main.def_season s ON e.date_time_begin <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE
  ge.cd_gp_biol='mafi' 
GROUP BY 
  ge.cd_gp_event,
  name_pt_ref,cd_tempo 
)
SELECT 
  ge.cd_gp_event,
  name_pt_ref||'_'||cd_tempo anh_tempo,
  wat_body_type, tipo_cuerp_agua,
  eco_type,tipo_ecos,
  platform "zone",
  total_sampled_area_m2,
  number_of_quadrats,
  COUNT(DISTINCT cd_event) nb_events,
  ARRAY_AGG(DISTINCT event_id) event_ids,
  COUNT(DISTINCT 
    CASE
     WHEN mt.pseudo_rank='SP' THEN verbatim_taxon
     ELSE t.name_tax
    END 
  ) FILTER (WHERE t.name_tax IS NOT NULL OR mt.pseudo_rank='SP' ) richness,
  SUM(qt_double) FILTER (WHERE t.name_tax IS NOT NULL OR mt.pseudo_rank='SP') /COUNT(DISTINCT cd_event)  total_density,
  SUM(qt_double)/COUNT(DISTINCT cd_event) total_density_without_taxo_filter,
  ST_X(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) x_coord_centroid,
  ST_Y(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) y_coord_centroid
FROM main.registros r
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'GN')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
FULL OUTER JOIN main.event e USING (cd_event) 
LEFT JOIN main.def_season s ON e.date_time_begin <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN habitat_gp_event_aquatic USING (cd_gp_event)
LEFT JOIN punto_ref_platform prp USING (cd_pt_ref,name_pt_ref)
LEFT JOIN se ON se.anh_tempo=name_pt_ref||'_'||cd_tempo
WHERE 
  ge.cd_gp_biol='mafi' 
GROUP BY 
  ge.cd_gp_event,
  name_pt_ref,
  wat_body_type, tipo_cuerp_agua,
  eco_type,tipo_ecos,
  platform,
  total_sampled_area_m2,
  number_of_quadrats,
  cd_tempo
ORDER BY 
  ge.cd_gp_event,
  name_pt_ref||'_'||cd_tempo
);

CREATE OR REPLACE VIEW mafi_envir_water AS

SELECT ge.cd_gp_event,
  name_pt_ref||'_'||s.cd_tempo anh_tempo,
 basin, mean_depth, width_approx, photic_depth, river_clasif, temp, ph, oxy_dis, cond, oxy_sat, tot_sol_situ, tot_org_c, avail_p, mg, cal, na_s, tot_dis_sol, tot_sol, sus_sol, sol_sol, p04, n03, silicates, oil_fat, blue_met_act, carbonates, cal_hard, tot_hard, alk, bicarb
FROM main.event e
LEFT JOIN main.def_season s ON e.date_time_begin <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN 
 ( 
  SELECT * 
  FROM main.phy_chi_hidro_event pche 
  LEFT JOIN main.def_season s2 ON pche.date_time <@ s2.date_range
  LEFT JOIN main.phy_chi_hidro_aguas USING (cd_event_phy_chi)
  WHERE pche.cd_phy_chi_type=(SELECT cd_phy_chi_type FROM main.def_phy_chi_type WHERE phy_chi_type='water')
 ) ag USING (cd_pt_ref,cd_tempo)
WHERE cd_gp_biol='mafi'
GROUP BY ge.cd_gp_event,
  name_pt_ref||'_'||s.cd_tempo,
 basin, mean_depth, width_approx, photic_depth, river_clasif, temp, ph, oxy_dis, cond, oxy_sat, tot_sol_situ, tot_org_c, avail_p, mg, cal, na_s, tot_dis_sol, tot_sol, sus_sol, sol_sol, p04, n03, silicates, oil_fat, blue_met_act, carbonates, cal_hard, tot_hard, alk, bicarb
ORDER BY ge.cd_gp_event
;

CREATE OR REPLACE VIEW mafi_envir_sedim AS

SELECT ge.cd_gp_event,
  name_pt_ref||'_'||s.cd_tempo anh_tempo,
  sand_per, clay_per, silt_per, text_clas, org_c, avail_p, mg, cal, na_s, boron, fe, tot_n
FROM main.event e
LEFT JOIN main.def_season s ON e.date_time_begin <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN 
 (
  SELECT *
  FROM main.phy_chi_hidro_event pche
  LEFT JOIN main.def_season s2 ON pche.date_time <@ s2.date_range
  LEFT JOIN main.phy_chi_hidro_sedi USING (cd_event_phy_chi)
  WHERE pche.cd_phy_chi_type=(SELECT cd_phy_chi_type FROM main.def_phy_chi_type WHERE phy_chi_type='sediment')
 ) se USING  (cd_pt_ref,cd_tempo)
WHERE  cd_gp_biol='mafi'
GROUP BY ge.cd_gp_event,
  name_pt_ref||'_'||s.cd_tempo,
  sand_per, clay_per, silt_per, text_clas, org_c, avail_p, mg, cal, na_s, boron, fe, tot_n
ORDER BY ge.cd_gp_event
;
```

## 6.4 Listas

### 6.4.1 Lista completa

- occurrence number es el numero de registros que tienen la especie (si
  la tabla es limpia, corresponde al numero de evento que contienen el
  taxon)
- la zona está atribuida para cada ANH (se resolvierón los casos de
  eventos fuera de las zonas definidas y las ANH que estaban sobre 2
  zonas distintas

``` sql
CREATE OR REPLACE VIEW mafi_list_tot AS(
WITH a AS(
SELECT count(DISTINCT cd_event) nb_event, sum(samp_effort_1) tot_area
FROM main.event
LEFT JOIN main.gp_event USING (cd_gp_event)
WHERE cd_gp_biol='mafi'
)
SELECT 
   tor.name_tax "orden",
   tfam.name_tax "family",
   COALESCE(verbatim_taxon, t.name_tax) taxon,
   dtr.tax_rank tax_rank,
   dtrm.tax_rank pseudo_rank,
   --ARRAY_AGG(DISTINCT protocol) protocols,
   ARRAY_AGG(DISTINCT cd_tempo) temporadas,
   ARRAY_AGG(DISTINCT name_pt_ref) anh,
   ARRAY_AGG(DISTINCT platform) zonas,
   ARRAY_AGG(DISTINCT tipo_cuerp_agua) tipos_cuerp_agua,
   count(*) "occurrence number",
   SUM(qt_double)/nb_event "cover (%)",
   (SUM(qt_double)/nb_event)*(tot_area/100) "area cover tot (m2)"
FROM main.registros r
CROSS JOIN a
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.taxo tfam ON find_higher_id(r.cd_tax,'FAM')=tfam.cd_tax
LEFT JOIN main.taxo tor ON find_higher_id(r.cd_tax,'OR')=tor.cd_tax
LEFT JOIN main.morfo_taxo mt USING(cd_morfo)
LEFT JOIN main.def_tax_rank dtr ON t.cd_rank=dtr.cd_rank
LEFT JOIN main.def_tax_rank dtrm ON mt.pseudo_rank=dtrm.cd_rank
LEFT JOIN habitat_gp_event_aquatic USING (cd_gp_event)
LEFT JOIN punto_ref_platform USING (cd_pt_ref,name_pt_ref)
WHERE
  ge.cd_gp_biol='mafi'
GROUP BY 
   tfam.name_tax, 
   tot_area,
   tor.name_tax,
   verbatim_taxon,
   t.name_tax,
   dtr.tax_rank,
   dtrm.tax_rank,
   nb_event
ORDER BY SUM(qt_double)/nb_event DESC
)
;
```

### 6.4.2 Promedio y suma de las abundancias en función de los rangos y pseudo-rangos

``` sql
SELECT COALESCE(pseudo_rank,tax_rank) rank_pseudo_rank,SUM("cover (%)") sum_cover, AVG("cover (%)") mean_cover 
FROM mafi_list_tot 
GROUP BY COALESCE(pseudo_rank,tax_rank);
```

<div class="knitsql-table">

</div>

## 6.5 Exportar: R y Excel

Extraer en R y exportar en excel

``` r
(listTable <- dbGetQuery(fracking_db, "SELECT table_name FROM information_schema.tables WHERE table_schema='public' AND table_name ~ '^mafi'")$table_name)
```

    ## [1] "mafi_envir_sedim"   "mafi_envir_water"   "mafi_info_sampling"
    ## [4] "mafi_list_tot"      "mafi_matrix"

``` r
export_mafi <- lapply(listTable, dbReadTable, conn = fracking_db)
names(export_mafi) <- listTable
export_mafi <- c(export_mafi, lapply(export_mafi[grep("matrix", listTable)],
    function(x) {
        col_content <- c("abundance", "density")[c("abundance", "density") %in%
            colnames(x)]
        dbTab2mat(x, col_samplingUnits = "anh_tempo", col_species = "taxon",
            col_content = col_content, empty = 0)
    }))
names(export_mafi)[grepl("matrix", names(export_mafi)) & !sapply(lapply(export_mafi,
    class), function(x) "matrix" %in% x)] <- paste(names(export_mafi)[grepl("matrix",
    names(export_mafi)) & !sapply(lapply(export_mafi, class), function(x) "matrix" %in%
    x)], "_raw", sep = "")
export_mafi <- lapply(export_mafi, as.data.frame)
save_in_excel(file = "../../bpw_export//mafi_export.xlsx", lVar = export_mafi)
```

# 7 Mariposas

## 7.1 Matriz

``` sql
CREATE OR REPLACE VIEW mari_matrix AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  CASE
   WHEN mt.pseudo_rank='SP' THEN verbatim_taxon
   ELSE t.name_tax
  END taxon,
  SUM(qt_int) abundance
FROM main.registros r
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin') 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin, (ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'SP')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
WHERE 
  ge.cd_gp_biol='mari' 
  AND (t.name_tax IS NOT NULL OR mt.pseudo_rank='SP')--ensure we got the species or morphospecies
GROUP BY 
  name_pt_ref,
  taxon,
  cd_tempo
ORDER BY 
  name_pt_ref||'_'||cd_tempo,
  SUM(qt_double) DESC
);
```

## 7.2 Información sobre los “sampling unit” de las matrices

``` sql
CREATE OR REPLACE VIEW mari_info_sampling AS
/*WITH se AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  SUM(samp_effort_1) total_sampled_area_m2,
  SUM(samp_effort_2) number_of_quadrats
FROM main.event e
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.def_season s ON COALESCE(e.date_time_begin,(ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE
  ge.cd_gp_biol='mari' 
GROUP BY 
  ge.cd_gp_event,
  name_pt_ref,cd_tempo 
)*/
SELECT 
 ge.cd_gp_event,
 name_pt_ref||'_'||cd_tempo anh_tempo,
 landcov,
 landcov_spa,
 platform "zone",
 COUNT(DISTINCT e.cd_event) nb_event,
 ARRAY_AGG(DISTINCT event_id) event_ids,
 SUM(qt_int) FILTER (WHERE t.name_tax IS NOT NULL OR mt.pseudo_rank='SP') total_abundance,
 COUNT(DISTINCT
  CASE
   WHEN mt.pseudo_rank='SP' THEN verbatim_taxon
   ELSE t.name_tax
  END 
  ) FILTER (WHERE t.name_tax IS NOT NULL OR mt.pseudo_rank='SP') richness,
  ST_X(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) x_coord_centroid,
  ST_Y(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) y_coord_centroid
FROM main.registros r
LEFT JOIN main.individual_characteristics ic USING(cd_reg)
LEFT JOIN main.def_ind_charac_categ dicc ON dicc.cd_var_ind_char= (SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Life stage') AND ic.cd_categ=dicc.cd_categ
FULL OUTER JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.gp_event ge USING(cd_gp_event)
LEFT JOIN main.def_protocol p USING (cd_protocol)
LEFT JOIN main.def_season s ON COALESCE((ee.value_text::date||' 12:00:00')::timestamp,e.date_time_begin) <@ s.date_range
LEFT JOIN main.punto_referencia pr USING (cd_pt_ref)
LEFT JOIN landcov_gp_event_terrestrial hge USING (cd_gp_event)
LEFT JOIN punto_ref_platform prf USING (cd_pt_ref,name_pt_ref)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'SP')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
/*LEFT JOIN se ON se.anh_tempo=name_pt_ref||'_'||cd_tempo*/

WHERE 
  ge.cd_gp_biol='mari'
GROUP BY 
  ge.cd_gp_event,
  name_pt_ref||'_'||cd_tempo,
  landcov,
  landcov_spa,
  platform
```

## 7.3 Listas

### 7.3.1 Lista completa

- occurrence number es el numero de registros que tienen la especie (si
  la tabla es limpia, corresponde al numero de eventos que contienen el
  taxon)
- la zona está atribuida para cada ANH (se resolvierón los casos de
  eventos fuera de las zonas definidas y las ANH que estaban sobre 2
  zonas distintas

``` sql
CREATE OR REPLACE VIEW mari_list_tot AS(
SELECT 
   tor.name_tax "orden",
   tfam.name_tax "family",
   tgn.name_tax genus,
   COALESCE(verbatim_taxon, t.name_tax) taxon,
   dtr.tax_rank tax_rank,
   dtrm.tax_rank pseudo_rank,
   --ARRAY_AGG(DISTINCT protocol) protocols,
   ARRAY_AGG(DISTINCT cd_tempo) temporadas,
   ARRAY_AGG(DISTINCT name_pt_ref) anh,
   ARRAY_AGG(DISTINCT platform) zonas,
   ARRAY_AGG(DISTINCT landcov_spa) landcovs,
   count(*) "occurrence number",
   SUM(qt_int) "total abundance"
FROM main.registros r
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin') 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin, (ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.taxo tgn ON find_higher_id(r.cd_tax,'GN')=tgn.cd_tax
LEFT JOIN main.taxo tfam ON find_higher_id(r.cd_tax,'FAM')=tfam.cd_tax
LEFT JOIN main.taxo tor ON find_higher_id(r.cd_tax,'OR')=tor.cd_tax
LEFT JOIN main.morfo_taxo mt USING(cd_morfo)
LEFT JOIN main.def_tax_rank dtr ON t.cd_rank=dtr.cd_rank
LEFT JOIN main.def_tax_rank dtrm ON mt.pseudo_rank=dtrm.cd_rank
LEFT JOIN landcov_gp_event_terrestrial USING (cd_gp_event)
LEFT JOIN punto_ref_platform USING (cd_pt_ref,name_pt_ref)
WHERE
  ge.cd_gp_biol='mari'
GROUP BY 
   tfam.name_tax, 
   tgn.name_tax,
   tor.name_tax,
   verbatim_taxon,
   t.name_tax,
   dtr.tax_rank,
   dtrm.tax_rank
ORDER BY SUM(qt_double) DESC
)
;
```

<!--
### Lista por temporada
TODO
### Lista por zona y temporada
TODO
### Lista por habitat
TODO
-->

## 7.4 Exportar: R y Excel

Extraer en R y exportar en excel

``` r
(listTable <- dbGetQuery(fracking_db, "SELECT table_name FROM information_schema.tables WHERE table_schema='public' AND table_name ~ '^mari'")$table_name)
```

    ## [1] "mari_info_sampling" "mari_list_tot"      "mari_matrix"

``` r
export_mari <- lapply(listTable, dbReadTable, conn = fracking_db)
names(export_mari) <- listTable
export_mari[grep("matrix", listTable)] <- lapply(export_mari[grep("matrix",
    listTable)], function(x) {
    col_content <- c("abundance", "density")[c("abundance", "density") %in%
        colnames(x)]
    dbTab2mat(x, col_samplingUnits = "anh_tempo", col_species = "taxon",
        col_content = col_content, empty = 0)
})
export_mari <- lapply(export_mari, as.data.frame)
save_in_excel(file = "../../bpw_export//mari_export.xlsx", lVar = export_mari)
```

# 8 Hormigas

## 8.1 Matriz

``` sql
CREATE OR REPLACE VIEW horm_matrix AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  CASE
   WHEN mt.pseudo_rank='SP' THEN verbatim_taxon
   ELSE t.name_tax
  END taxon,
  SUM(CASE WHEN qt_int>0 THEN 1 ELSE 0 END) abundance
FROM main.registros r
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin') 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin, (ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'SP')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
WHERE 
  ge.cd_gp_biol='horm' 
  AND (t.name_tax IS NOT NULL OR mt.pseudo_rank='SP')--ensure we got the species or morphospecies
GROUP BY 
  name_pt_ref,
  taxon,
  cd_tempo
ORDER BY 
  name_pt_ref||'_'||cd_tempo,
  SUM(qt_double) DESC
);
```

## 8.2 Información sobre los “sampling unit” de las matrices

``` sql
CREATE OR REPLACE VIEW horm_info_sampling AS
WITH/* se AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  SUM(samp_effort_1) total_sampled_area_m2,
  SUM(samp_effort_2) number_of_quadrats
FROM main.event e
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.def_season s ON COALESCE(e.date_time_begin,(ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE
  ge.cd_gp_biol='horm' 
GROUP BY 
  name_pt_ref,cd_tempo 
),*/
 gel AS(
SELECT DISTINCT ON (name_pt_ref,cd_tempo)
  name_pt_ref||'_'||cd_tempo anh_tempo,
  landcov,
  landcov_spa,
  count(*)
FROM main.event e
LEFT JOIN habitat_event he USING (cd_event,cd_gp_event)
LEFT JOIN spat.def_landcov ON he.habitat=landcov
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.def_season s ON COALESCE(e.date_time_begin,(ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
WHERE
  ge.cd_gp_biol='horm' 
  AND he.aqu_ter='terrestrial'
GROUP BY 
  name_pt_ref,cd_tempo,landcov,landcov_spa
ORDER BY 
  name_pt_ref, cd_tempo, count(*) DESC
)
SELECT 
 ARRAY_AGG(DISTINCT ge.cd_gp_event) cds_gp_event,
 name_pt_ref||'_'||cd_tempo anh_tempo,
 landcov,
 landcov_spa,
 platform "zone",
 COUNT(DISTINCT e.cd_event) nb_event,
 ARRAY_AGG(DISTINCT event_id) event_ids,
 SUM(CASE WHEN qt_int>0 THEN 1 ELSE 0 END) FILTER (WHERE t.name_tax IS NOT NULL OR mt.pseudo_rank='SP') total_sum_of_frequencies,
 COUNT(DISTINCT 
  CASE
   WHEN mt.pseudo_rank='SP' THEN verbatim_taxon
   ELSE t.name_tax
  END 
  ) FILTER (WHERE t.name_tax IS NOT NULL OR mt.pseudo_rank='SP') richness,
  ST_X(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) x_coord_centroid,
  ST_Y(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) y_coord_centroid
FROM main.registros r
LEFT JOIN main.individual_characteristics ic USING(cd_reg)
LEFT JOIN main.def_ind_charac_categ dicc ON dicc.cd_var_ind_char= (SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Life stage') AND ic.cd_categ=dicc.cd_categ
FULL OUTER JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.gp_event ge USING(cd_gp_event)
LEFT JOIN main.def_protocol p USING (cd_protocol)
LEFT JOIN main.def_season s ON COALESCE((ee.value_text::date||' 12:00:00')::timestamp,e.date_time_begin) <@ s.date_range
LEFT JOIN main.punto_referencia pr USING (cd_pt_ref)
--LEFT JOIN landcov_gp_event_terrestrial hge USING (cd_gp_event)
LEFT JOIN punto_ref_platform prf USING (cd_pt_ref,name_pt_ref)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'SP')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
/*LEFT JOIN se ON se.anh_tempo=name_pt_ref||'_'||cd_tempo*/
LEFT JOIN gel ON gel.anh_tempo=name_pt_ref||'_'||cd_tempo
WHERE 
  ge.cd_gp_biol='horm'
GROUP BY 
  name_pt_ref||'_'||cd_tempo,
  landcov,
  landcov_spa,
  platform
```

## 8.3 Listas

### 8.3.1 Lista completa

- occurrence number es el numero de registros que tienen la especie (si
  la tabla es limpia, corresponde al numero de eventos que contienen el
  taxon)
- la zona está atribuida para cada ANH (se resolvierón los casos de
  eventos fuera de las zonas definidas y las ANH que estaban sobre 2
  zonas distintas

``` sql
CREATE OR REPLACE VIEW horm_list_tot AS(
SELECT 
   --tor.name_tax "orden",
   --tfam.name_tax "family",
   tgn.name_tax genus,
   COALESCE(verbatim_taxon, t.name_tax) taxon,
   dtr.tax_rank tax_rank,
   dtrm.tax_rank pseudo_rank,
   --ARRAY_AGG(DISTINCT protocol) protocols,
   ARRAY_AGG(DISTINCT cd_tempo) temporadas,
   ARRAY_AGG(DISTINCT name_pt_ref) anh,
   ARRAY_AGG(DISTINCT platform) zonas,
   ARRAY_AGG(DISTINCT landcov_spa) landcovs,
   count(*) "occurrence number"
FROM main.registros r
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin') 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin, (ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.taxo tgn ON find_higher_id(r.cd_tax,'GN')=tgn.cd_tax
LEFT JOIN main.taxo tfam ON find_higher_id(r.cd_tax,'FAM')=tfam.cd_tax
LEFT JOIN main.taxo tor ON find_higher_id(r.cd_tax,'OR')=tor.cd_tax
LEFT JOIN main.morfo_taxo mt USING(cd_morfo)
LEFT JOIN main.def_tax_rank dtr ON t.cd_rank=dtr.cd_rank
LEFT JOIN main.def_tax_rank dtrm ON mt.pseudo_rank=dtrm.cd_rank
LEFT JOIN landcov_gp_event_terrestrial USING (cd_gp_event)
LEFT JOIN punto_ref_platform USING (cd_pt_ref,name_pt_ref)
WHERE
  ge.cd_gp_biol='horm'
GROUP BY 
   tfam.name_tax, 
   tgn.name_tax,
   tor.name_tax,
   verbatim_taxon,
   t.name_tax,
   dtr.tax_rank,
   dtrm.tax_rank
ORDER BY count(*) DESC
)
;
```

<!--
### Lista por temporada
TODO
### Lista por zona y temporada
TODO
### Lista por habitat
TODO
-->

## 8.4 Exportar: R y Excel

Extraer en R y exportar en excel

``` r
(listTable <- dbGetQuery(fracking_db, "SELECT table_name FROM information_schema.tables WHERE table_schema='public' AND table_name ~ '^horm'")$table_name)
```

    ## [1] "horm_info_sampling" "horm_list_tot"      "horm_matrix"

``` r
export_horm <- lapply(listTable, dbReadTable, conn = fracking_db)
names(export_horm) <- listTable
export_horm[grep("matrix", listTable)] <- lapply(export_horm[grep("matrix",
    listTable)], function(x) {
    col_content <- c("abundance", "density")[c("abundance", "density") %in%
        colnames(x)]
    dbTab2mat(x, col_samplingUnits = "anh_tempo", col_species = "taxon",
        col_content = col_content, empty = 0)
})
export_horm <- lapply(export_horm, as.data.frame)
save_in_excel(file = "../../bpw_export//horm_export.xlsx", lVar = export_horm)
```

# 9 Colémbolos

## 9.1 Matrices

No me acuerdo si había que separar las matrices de Berlese y pitfall,
voy a hacer 3 matrices: Berlese, pitfall, asociación entre los 2

### 9.1.1 Berlese

``` sql
CREATE OR REPLACE VIEW cole_berlese_matrix AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  CASE
   WHEN mt.pseudo_rank='GN' THEN tm.name_tax||' ('||name_morfo||')'
   ELSE t.name_tax
  END taxon,
  SUM(qt_int) abundance
FROM main.registros r
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin') 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin, (ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'GN')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.taxo tm ON mt.cd_tax=tm.cd_tax
WHERE 
  ge.cd_gp_biol='cole' 
  AND protocol='Berlese trap (arthropods)'
  AND (t.name_tax IS NOT NULL OR mt.pseudo_rank='GN')--ensure we got the genus or morphogenus
GROUP BY 
  name_pt_ref,
  taxon,
  cd_tempo
ORDER BY 
  name_pt_ref||'_'||cd_tempo,
  SUM(qt_int) DESC
);
```

    --sql, results='hide'}
    SELECT
      name_pt_ref||'_'||cd_tempo anh_tempo,

### 9.1.2 Pitfall

``` sql
CREATE OR REPLACE VIEW cole_pitfall_matrix AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  CASE
   WHEN mt.pseudo_rank='GN' THEN tm.name_tax||' ('||name_morfo||')'
   ELSE t.name_tax
  END taxon,
  SUM(qt_int) abundance
FROM main.registros r
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin') 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin, (ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'GN')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.taxo tm ON mt.cd_tax=tm.cd_tax
WHERE 
  ge.cd_gp_biol='cole' 
  AND protocol='Pitfall (arthropods)'
  AND (t.name_tax IS NOT NULL OR mt.pseudo_rank='GN')--ensure we got the genus or morphogenus
GROUP BY 
  name_pt_ref,
  taxon,
  cd_tempo
ORDER BY 
  name_pt_ref||'_'||cd_tempo,
  SUM(qt_int) DESC
);
```

### 9.1.3 Ambos metodos

``` sql
CREATE OR REPLACE VIEW cole_matrix AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  CASE
   WHEN mt.pseudo_rank='GN' THEN tm.name_tax||' ('||name_morfo||')'
   ELSE t.name_tax
  END taxon,
  SUM(qt_int) abundance
FROM main.registros r
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin') 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin, (ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'GN')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.taxo tm ON mt.cd_tax=tm.cd_tax
WHERE 
  ge.cd_gp_biol='cole' 
  AND (t.name_tax IS NOT NULL OR mt.pseudo_rank='GN')--ensure we got the genus or morphogenus
GROUP BY 
  name_pt_ref,
  taxon,
  cd_tempo
ORDER BY 
  name_pt_ref||'_'||cd_tempo,
  SUM(qt_int) DESC
);
```

## 9.2 Información sobre los “sampling unit” de las matrices

``` sql
CREATE OR REPLACE VIEW cole_info_sampling_berlese AS
WITH se AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  SUM(samp_effort_1) total_trap_volume,
  SUM(samp_effort_2) total_trap_time_min
FROM main.event e
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.def_season s ON COALESCE(e.date_time_begin,(ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE
  ge.cd_gp_biol='cole' 
  AND protocol='Berlese trap (arthropods)'
GROUP BY 
  name_pt_ref,cd_tempo 
),
 gel AS(
SELECT DISTINCT ON (name_pt_ref,cd_tempo)
  name_pt_ref||'_'||cd_tempo anh_tempo,
  landcov,
  landcov_spa,
  count(*)
FROM main.event e
LEFT JOIN habitat_event he USING (cd_event,cd_gp_event)
LEFT JOIN spat.def_landcov ON he.habitat=landcov
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.def_season s ON COALESCE(e.date_time_begin,(ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE
  ge.cd_gp_biol='cole' 
  AND he.aqu_ter='terrestrial'
  AND protocol='Berlese trap (arthropods)'
GROUP BY 
  name_pt_ref,cd_tempo,landcov,landcov_spa
ORDER BY 
  name_pt_ref, cd_tempo, count(*) DESC, MIN(e.date_time_begin)
)
SELECT 
 ARRAY_AGG(DISTINCT ge.cd_gp_event) cds_gp_event,
 name_pt_ref||'_'||cd_tempo anh_tempo,
 landcov,
 landcov_spa,
 platform "zone",
 total_trap_volume,
 total_trap_time_min,
 COUNT(DISTINCT e.cd_event) nb_event,
 ARRAY_AGG(DISTINCT event_id) event_ids,
 SUM(qt_int) FILTER (WHERE t.name_tax IS NOT NULL OR mt.pseudo_rank='GN') total_abundance,
 COUNT(DISTINCT 
  CASE
   WHEN mt.pseudo_rank='GN' THEN verbatim_taxon
   ELSE t.name_tax
  END 
  ) FILTER (WHERE t.name_tax IS NOT NULL OR mt.pseudo_rank='GN') richness,
 SUM(qt_int) total_abundance_without_taxo_filter,
  ST_X(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) x_coord_centroid,
  ST_Y(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) y_coord_centroid
FROM main.registros r
LEFT JOIN main.individual_characteristics ic USING(cd_reg)
LEFT JOIN main.def_ind_charac_categ dicc ON dicc.cd_var_ind_char= (SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Life stage') AND ic.cd_categ=dicc.cd_categ
FULL OUTER JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.gp_event ge USING(cd_gp_event)
LEFT JOIN main.def_protocol p USING (cd_protocol)
LEFT JOIN main.def_season s ON COALESCE((ee.value_text::date||' 12:00:00')::timestamp,e.date_time_begin) <@ s.date_range
LEFT JOIN main.punto_referencia pr USING (cd_pt_ref)
--LEFT JOIN landcov_gp_event_terrestrial hge USING (cd_gp_event)
LEFT JOIN punto_ref_platform prf USING (cd_pt_ref,name_pt_ref)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'GN')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN se ON se.anh_tempo=name_pt_ref||'_'||cd_tempo
LEFT JOIN gel ON gel.anh_tempo=name_pt_ref||'_'||cd_tempo
WHERE 
  ge.cd_gp_biol='cole'
  AND protocol='Berlese trap (arthropods)'
GROUP BY 
  name_pt_ref||'_'||cd_tempo,
  landcov,
  landcov_spa,
  total_trap_volume,
  total_trap_time_min,
  platform;

CREATE OR REPLACE VIEW cole_info_sampling_pitfall AS
WITH se AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  SUM(samp_effort_1) total_trap_time_min
FROM main.event e
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.def_season s ON COALESCE(e.date_time_begin,(ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE
  ge.cd_gp_biol='cole' 
  AND protocol='Pitfall (arthropods)'
GROUP BY 
  name_pt_ref,cd_tempo 
),
 gel AS(
SELECT DISTINCT ON (name_pt_ref,cd_tempo)
  name_pt_ref||'_'||cd_tempo anh_tempo,
  landcov,
  landcov_spa,
  count(*)
FROM main.event e
LEFT JOIN habitat_event he USING (cd_event,cd_gp_event)
LEFT JOIN spat.def_landcov ON he.habitat=landcov
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.def_season s ON COALESCE(e.date_time_begin,(ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE
  ge.cd_gp_biol='cole' 
  AND he.aqu_ter='terrestrial'
  AND protocol='Pitfall (arthropods)'
GROUP BY 
  name_pt_ref,cd_tempo,landcov,landcov_spa
ORDER BY 
  name_pt_ref, cd_tempo, count(*) DESC, MIN(e.date_time_begin)
)
SELECT 
 ARRAY_AGG(DISTINCT ge.cd_gp_event) cds_gp_event,
 name_pt_ref||'_'||cd_tempo anh_tempo,
 landcov,
 landcov_spa,
 platform "zone",
 total_trap_time_min,
 COUNT(DISTINCT e.cd_event) nb_event,
 ARRAY_AGG(DISTINCT event_id) event_ids,
 SUM(qt_int) FILTER (WHERE t.name_tax IS NOT NULL OR mt.pseudo_rank='GN') total_abundance,
 COUNT(DISTINCT 
  CASE
   WHEN mt.pseudo_rank='GN' THEN verbatim_taxon
   ELSE t.name_tax
  END 
  ) FILTER (WHERE t.name_tax IS NOT NULL OR mt.pseudo_rank='GN') richness,
 SUM(qt_int) total_abundance_without_taxo_filter,
  ST_X(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) x_coord_centroid,
  ST_Y(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) y_coord_centroid
FROM main.registros r
LEFT JOIN main.individual_characteristics ic USING(cd_reg)
LEFT JOIN main.def_ind_charac_categ dicc ON dicc.cd_var_ind_char= (SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Life stage') AND ic.cd_categ=dicc.cd_categ
FULL OUTER JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.gp_event ge USING(cd_gp_event)
LEFT JOIN main.def_protocol p USING (cd_protocol)
LEFT JOIN main.def_season s ON COALESCE((ee.value_text::date||' 12:00:00')::timestamp,e.date_time_begin) <@ s.date_range
LEFT JOIN main.punto_referencia pr USING (cd_pt_ref)
--LEFT JOIN landcov_gp_event_terrestrial hge USING (cd_gp_event)
LEFT JOIN punto_ref_platform prf USING (cd_pt_ref,name_pt_ref)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'GN')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN se ON se.anh_tempo=name_pt_ref||'_'||cd_tempo
LEFT JOIN gel ON gel.anh_tempo=name_pt_ref||'_'||cd_tempo
WHERE 
  ge.cd_gp_biol='cole'
  AND protocol='Pitfall (arthropods)'
GROUP BY 
  name_pt_ref||'_'||cd_tempo,
  landcov,
  landcov_spa,
  total_trap_time_min,
  platform;

CREATE OR REPLACE VIEW cole_info_sampling_total AS
WITH se AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  SUM(samp_effort_1) FILTER (WHERE protocol='Pitfall (arthropods)') + SUM(samp_effort_2) FILTER (WHERE protocol='Berlese trap (arthropods)') total_trap_time_min
FROM main.event e
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.def_season s ON COALESCE(e.date_time_begin,(ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE
  ge.cd_gp_biol='cole' 
GROUP BY 
  name_pt_ref,cd_tempo 
),
 gel AS(
SELECT DISTINCT ON (name_pt_ref,cd_tempo)
  name_pt_ref||'_'||cd_tempo anh_tempo,
  landcov,
  landcov_spa,
  count(*)
FROM main.event e
LEFT JOIN habitat_event he USING (cd_event,cd_gp_event)
LEFT JOIN spat.def_landcov ON he.habitat=landcov
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.def_season s ON COALESCE(e.date_time_begin,(ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE
  ge.cd_gp_biol='cole' 
  AND he.aqu_ter='terrestrial'
GROUP BY 
  name_pt_ref,cd_tempo,landcov,landcov_spa
ORDER BY 
  name_pt_ref, cd_tempo, count(*) DESC, MIN(e.date_time_begin)
)
SELECT 
 ARRAY_AGG(DISTINCT ge.cd_gp_event) cds_gp_event,
 name_pt_ref||'_'||cd_tempo anh_tempo,
 landcov,
 landcov_spa,
 platform "zone",
 total_trap_time_min,
 COUNT(DISTINCT e.cd_event) nb_event,
 ARRAY_AGG(DISTINCT event_id) event_ids,
 SUM(qt_int) FILTER (WHERE t.name_tax IS NOT NULL OR mt.pseudo_rank='GN') total_abundance,
 COUNT(DISTINCT 
  CASE
   WHEN mt.pseudo_rank='GN' THEN verbatim_taxon
   ELSE t.name_tax
  END 
  ) FILTER (WHERE t.name_tax IS NOT NULL OR mt.pseudo_rank='GN') richness,
 SUM(qt_int) total_abundance_without_taxo_filter,
  ST_X(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) x_coord_centroid,
  ST_Y(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) y_coord_centroid
FROM main.registros r
LEFT JOIN main.individual_characteristics ic USING(cd_reg)
LEFT JOIN main.def_ind_charac_categ dicc ON dicc.cd_var_ind_char= (SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Life stage') AND ic.cd_categ=dicc.cd_categ
FULL OUTER JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.gp_event ge USING(cd_gp_event)
LEFT JOIN main.def_protocol p USING (cd_protocol)
LEFT JOIN main.def_season s ON COALESCE((ee.value_text::date||' 12:00:00')::timestamp,e.date_time_begin) <@ s.date_range
LEFT JOIN main.punto_referencia pr USING (cd_pt_ref)
--LEFT JOIN landcov_gp_event_terrestrial hge USING (cd_gp_event)
LEFT JOIN punto_ref_platform prf USING (cd_pt_ref,name_pt_ref)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'GN')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN se ON se.anh_tempo=name_pt_ref||'_'||cd_tempo
LEFT JOIN gel ON gel.anh_tempo=name_pt_ref||'_'||cd_tempo
WHERE 
  ge.cd_gp_biol='cole'
GROUP BY 
  name_pt_ref||'_'||cd_tempo,
  landcov,
  landcov_spa,
  total_trap_time_min,
  platform;
```

## 9.3 Listas

### 9.3.1 Lista completa

1.  occurrence number es el numero de registros que tienen la especie
    (si la tabla es limpia, corresponde al numero de eventos que
    contienen el taxon)
2.  la zona está atribuida para cada ANH (se resolvierón los casos de
    eventos fuera de las zonas definidas y las ANH que estaban sobre 2
    zonas distintas

``` sql
CREATE OR REPLACE VIEW cole_list_tot AS(
SELECT 
   tor.name_tax "orden",
   tfam.name_tax "family",
   --tgn.name_tax genus,
   COALESCE(tm.name_tax||' ('||name_morfo||')', t.name_tax) taxon,
   dtr.tax_rank tax_rank,
   dtrm.tax_rank pseudo_rank,
   ARRAY_AGG(DISTINCT protocol) protocols,
   ARRAY_AGG(DISTINCT cd_tempo) temporadas,
   ARRAY_AGG(DISTINCT name_pt_ref) anh,
   ARRAY_AGG(DISTINCT platform) zonas,
   ARRAY_AGG(DISTINCT landcov_spa) landcovs,
   count(*) "occurrence number",
   sum(qt_int) "total abundance"
FROM main.registros r
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin') 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin, (ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.taxo tgn ON find_higher_id(r.cd_tax,'GN')=tgn.cd_tax
LEFT JOIN main.taxo tfam ON find_higher_id(r.cd_tax,'FAM')=tfam.cd_tax
LEFT JOIN main.taxo tor ON find_higher_id(r.cd_tax,'OR')=tor.cd_tax
LEFT JOIN main.morfo_taxo mt USING(cd_morfo)
LEFT JOIN main.taxo tm ON mt.cd_tax=tm.cd_tax
LEFT JOIN main.def_tax_rank dtr ON t.cd_rank=dtr.cd_rank
LEFT JOIN main.def_tax_rank dtrm ON mt.pseudo_rank=dtrm.cd_rank
LEFT JOIN landcov_gp_event_terrestrial USING (cd_gp_event)
LEFT JOIN punto_ref_platform USING (cd_pt_ref,name_pt_ref)
WHERE
  ge.cd_gp_biol='cole'
GROUP BY 
   tfam.name_tax, 
   tgn.name_tax,
   tor.name_tax,
   verbatim_taxon,
   t.name_tax,
   dtr.tax_rank,
   dtrm.tax_rank,
   name_morfo,
   tm.name_tax
ORDER BY  sum(qt_int) DESC
)
;
```

## 9.4 Exportar: R y Excel

Extraer en R y exportar en excel

``` r
(listTable <- dbGetQuery(fracking_db, "SELECT table_name FROM information_schema.tables WHERE table_schema='public' AND table_name ~ '^cole'")$table_name)
```

    ## [1] "cole_berlese_matrix"        "cole_info_sampling_berlese"
    ## [3] "cole_info_sampling_pitfall" "cole_info_sampling_total"  
    ## [5] "cole_list_tot"              "cole_matrix"               
    ## [7] "cole_pitfall_matrix"

``` r
export_cole <- lapply(listTable, dbReadTable, conn = fracking_db)
names(export_cole) <- listTable
export_cole[grep("matrix", listTable)] <- lapply(export_cole[grep("matrix",
    listTable)], function(x) {
    col_content <- c("abundance", "density")[c("abundance", "density") %in%
        colnames(x)]
    dbTab2mat(x, col_samplingUnits = "anh_tempo", col_species = "taxon",
        col_content = col_content, empty = 0)
})
export_cole <- lapply(export_cole, as.data.frame)
save_in_excel(file = "../../bpw_export//cole_export.xlsx", lVar = export_cole)
```

# 10 Peces

## 10.1 Niveles taxonomicos

``` sql
SELECT dtr.cd_rank, pseudo_rank,  count(*)
FROM main.registros r
LEFT JOIN main.event e USING (cd_event)
LEFT JOIN main.gp_event ge USING (cd_gp_event)
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.def_tax_rank dtr USING (cd_rank)
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
WHERE ge.cd_gp_biol='pece'
GROUP BY dtr.cd_rank,dtr.rank_level,pseudo_rank
ORDER BY rank_level DESC
```

<div class="knitsql-table">

</div>

## 10.2 Matrices

En las matrices se utilizaran unicamente los datos correspondientes a
jornadas diurnas.

### 10.2.1 Por arte de pesca (abundancias)

#### 10.2.1.1 Atarraya

``` sql
CREATE OR REPLACE VIEW pece_castnets_matrix AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  CASE
   WHEN mt.pseudo_rank='SP' THEN verbatim_taxon
   ELSE t.name_tax
  END taxon,
  SUM(qt_int) abundance
FROM main.registros r
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin') 
LEFT JOIN main.event_extra eep ON e.cd_event=eep.cd_event AND eep.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='period') 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin, (ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'SP')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
WHERE 
  ge.cd_gp_biol='pece' 
  AND protocol='Cast nets'
  AND (t.name_tax IS NOT NULL OR mt.pseudo_rank='SP')--ensure we got the genus or morphogenus
  AND eep.cd_categ_event_extra=(SELECT cd_categ_event_extra FROM main.def_categ_event_extra WHERE categ='Day')
GROUP BY 
  name_pt_ref,
  taxon,
  cd_tempo
ORDER BY 
  name_pt_ref||'_'||cd_tempo,
  SUM(qt_int) DESC
);
```

#### 10.2.1.2 Arrastre

``` sql
CREATE OR REPLACE VIEW pece_dragnet_matrix AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  CASE
   WHEN mt.pseudo_rank='SP' THEN verbatim_taxon
   ELSE t.name_tax
  END taxon,
  SUM(qt_int) abundance
FROM main.registros r
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin') 
LEFT JOIN main.event_extra eep ON e.cd_event=eep.cd_event AND eep.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='period') 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin, (ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'SP')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
WHERE 
  ge.cd_gp_biol='pece' 
  AND protocol='Drag net'
  AND (t.name_tax IS NOT NULL OR mt.pseudo_rank='SP')--ensure we got the genus or morphogenus
  AND eep.cd_categ_event_extra=(SELECT cd_categ_event_extra FROM main.def_categ_event_extra WHERE categ='Day')
GROUP BY 
  name_pt_ref,
  taxon,
  cd_tempo
ORDER BY 
  name_pt_ref||'_'||cd_tempo,
  SUM(qt_int) DESC
);
```

#### 10.2.1.3 Electropesca

``` sql
CREATE OR REPLACE VIEW pece_elec_matrix AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  CASE
   WHEN mt.pseudo_rank='SP' THEN verbatim_taxon
   ELSE t.name_tax
  END taxon,
  SUM(qt_int) abundance
FROM main.registros r
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin') 
LEFT JOIN main.event_extra eep ON e.cd_event=eep.cd_event AND eep.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='period') 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin, (ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'SP')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
WHERE 
  ge.cd_gp_biol='pece' 
  AND protocol='Electric fishing'
  AND (t.name_tax IS NOT NULL OR mt.pseudo_rank='SP')--ensure we got the genus or morphogenus
  AND eep.cd_categ_event_extra=(SELECT cd_categ_event_extra FROM main.def_categ_event_extra WHERE categ='Day')
GROUP BY 
  name_pt_ref,
  taxon,
  cd_tempo
ORDER BY 
  name_pt_ref||'_'||cd_tempo,
  SUM(qt_int) DESC
);
```

#### 10.2.1.4 Trasmallo

``` sql
CREATE OR REPLACE VIEW pece_gillnets_matrix AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  CASE
   WHEN mt.pseudo_rank='SP' THEN verbatim_taxon
   ELSE t.name_tax
  END taxon,
  SUM(qt_int) abundance
FROM main.registros r
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin') 
LEFT JOIN main.event_extra eep ON e.cd_event=eep.cd_event AND eep.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='period') 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin, (ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'SP')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
WHERE 
  ge.cd_gp_biol='pece' 
  AND protocol='Gillnets'
  AND (t.name_tax IS NOT NULL OR mt.pseudo_rank='SP')--ensure we got the genus or morphogenus
  AND eep.cd_categ_event_extra=(SELECT cd_categ_event_extra FROM main.def_categ_event_extra WHERE categ='Day')
GROUP BY 
  name_pt_ref,
  taxon,
  cd_tempo
ORDER BY 
  name_pt_ref||'_'||cd_tempo,
  SUM(qt_int) DESC
);
```

### 10.2.2 Total (incidencia)

``` sql
CREATE OR REPLACE VIEW pece_occurrence_matrix AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  CASE
   WHEN mt.pseudo_rank='SP' THEN verbatim_taxon
   ELSE t.name_tax
  END taxon/*,
  SUM(qt_int) abundance*/
FROM main.registros r
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin') 
LEFT JOIN main.event_extra eep ON e.cd_event=eep.cd_event AND eep.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='period') 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin, (ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'SP')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
WHERE 
  ge.cd_gp_biol='pece' 
  AND (t.name_tax IS NOT NULL OR mt.pseudo_rank='SP')--ensure we got the genus or morphogenus
  AND eep.cd_categ_event_extra=(SELECT cd_categ_event_extra FROM main.def_categ_event_extra WHERE categ='Day')
GROUP BY 
  name_pt_ref,
  taxon,
  cd_tempo
ORDER BY 
  name_pt_ref||'_'||cd_tempo,
  SUM(qt_int) DESC
);


CREATE OR REPLACE VIEW pece_incidence_matrix AS
 SELECT (punto_referencia.name_pt_ref::text || '_'::text) || s.cd_tempo::text AS anh_tempo,
        CASE
            WHEN mt.pseudo_rank::text = 'SP'::text THEN mt.verbatim_taxon
            ELSE t.name_tax
        END AS taxon,
        COUNT(DISTINCT e.cd_event) incidence
   FROM main.registros r
     LEFT JOIN main.event e USING (cd_event)
     LEFT JOIN main.event_extra ee ON e.cd_event = ee.cd_event AND ee.cd_var_event_extra = (( SELECT def_var_event_extra.cd_var_event_extra
           FROM main.def_var_event_extra
          WHERE def_var_event_extra.var_event_extra = 'date_begin'::text))
     LEFT JOIN main.event_extra eep ON e.cd_event = eep.cd_event AND eep.cd_var_event_extra = (( SELECT def_var_event_extra.cd_var_event_extra
           FROM main.def_var_event_extra
          WHERE def_var_event_extra.var_event_extra = 'period'::text))
     LEFT JOIN main.def_season s ON COALESCE(r.date_time, e.date_time_begin, (ee.value_text || ' 12:00:00'::text)::timestamp without time zone) <@ s.date_range
     LEFT JOIN main.gp_event ge USING (cd_gp_event)
     LEFT JOIN main.punto_referencia USING (cd_pt_ref)
     LEFT JOIN main.def_protocol USING (cd_protocol)
     LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax, 'SP'::character varying) = t.cd_tax
     LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
  WHERE ge.cd_gp_biol = 'pece'::bpchar AND (t.name_tax IS NOT NULL OR mt.pseudo_rank::text = 'SP'::text) AND eep.cd_categ_event_extra = (( SELECT def_categ_event_extra.cd_categ_event_extra
           FROM main.def_categ_event_extra
          WHERE def_categ_event_extra.categ = 'Day'::text))
  GROUP BY punto_referencia.name_pt_ref, (
        CASE
            WHEN mt.pseudo_rank::text = 'SP'::text THEN mt.verbatim_taxon
            ELSE t.name_tax
        END), s.cd_tempo
  ORDER BY ((punto_referencia.name_pt_ref::text || '_'::text) || s.cd_tempo::text), (sum(r.qt_int)) DESC;
```

## 10.3 Información sobre los “sampling unit” de las matrices

``` sql
CREATE OR REPLACE VIEW pece_info_sampling_castnet AS
WITH se AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  SUM(samp_effort_1) total_number_of_throws,
  SUM(samp_effort_2) total_trap_time_min
FROM main.event e
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.event_extra eep ON e.cd_event=eep.cd_event AND eep.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='period') 
LEFT JOIN main.def_season s ON COALESCE(e.date_time_begin,(ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE
  ge.cd_gp_biol='pece' 
  AND protocol='Cast nets'
  AND eep.cd_categ_event_extra=(SELECT cd_categ_event_extra FROM main.def_categ_event_extra WHERE categ='Day')
GROUP BY 
  name_pt_ref,cd_tempo 
)
SELECT 
 ARRAY_AGG(DISTINCT ge.cd_gp_event) cds_gp_event,
 name_pt_ref||'_'||cd_tempo anh_tempo,
  wat_body_type, tipo_cuerp_agua,
  eco_type,tipo_ecos,
 platform "zone",
  total_number_of_throws,
 total_trap_time_min,
 COUNT(DISTINCT e.cd_event) nb_event,
 ARRAY_AGG(DISTINCT event_id) event_ids,
 SUM(qt_int) FILTER (WHERE t.name_tax IS NOT NULL OR mt.pseudo_rank='SP') total_abundance,
 COUNT(DISTINCT 
  CASE
   WHEN mt.pseudo_rank='sp' THEN verbatim_taxon
   ELSE t.name_tax
  END 
  ) FILTER (WHERE t.name_tax IS NOT NULL OR mt.pseudo_rank='SP') richness,
 SUM(qt_int) total_abundance_without_taxo_filter,
  ST_X(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) x_coord_centroid,
  ST_Y(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) y_coord_centroid
FROM main.registros r
LEFT JOIN main.individual_characteristics ic USING(cd_reg)
LEFT JOIN main.def_ind_charac_categ dicc ON dicc.cd_var_ind_char= (SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Life stage') AND ic.cd_categ=dicc.cd_categ
FULL OUTER JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.event_extra eep ON e.cd_event=eep.cd_event AND eep.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='period') 
LEFT JOIN main.gp_event ge USING(cd_gp_event)
LEFT JOIN main.def_protocol p USING (cd_protocol)
LEFT JOIN main.def_season s ON COALESCE((ee.value_text::date||' 12:00:00')::timestamp,e.date_time_begin) <@ s.date_range
LEFT JOIN main.punto_referencia pr USING (cd_pt_ref)
LEFT JOIN habitat_gp_event_aquatic hge USING (cd_gp_event)
LEFT JOIN punto_ref_platform prf USING (cd_pt_ref,name_pt_ref)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'GN')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN se ON se.anh_tempo=name_pt_ref||'_'||cd_tempo
WHERE 
  ge.cd_gp_biol='pece'
  AND protocol='Cast nets'
  AND eep.cd_categ_event_extra=(SELECT cd_categ_event_extra FROM main.def_categ_event_extra WHERE categ='Day')
GROUP BY 
  name_pt_ref||'_'||cd_tempo,
  wat_body_type, tipo_cuerp_agua,
  eco_type,tipo_ecos,
  total_number_of_throws,
  total_trap_time_min,
  platform;


CREATE OR REPLACE VIEW pece_info_sampling_dragnet AS
WITH se AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  SUM(samp_effort_1) total_number_of_dragnets,
  SUM(samp_effort_2) total_sampling_time_min
FROM main.event e
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.event_extra eep ON e.cd_event=eep.cd_event AND eep.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='period') 
LEFT JOIN main.def_season s ON COALESCE(e.date_time_begin,(ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE
  ge.cd_gp_biol='pece' 
  AND protocol='Drag net'
  AND eep.cd_categ_event_extra=(SELECT cd_categ_event_extra FROM main.def_categ_event_extra WHERE categ='Day')
GROUP BY 
  name_pt_ref,cd_tempo 
)
SELECT 
 ARRAY_AGG(DISTINCT ge.cd_gp_event) cds_gp_event,
 name_pt_ref||'_'||cd_tempo anh_tempo,
  wat_body_type, tipo_cuerp_agua,
  eco_type,tipo_ecos,
 platform "zone",
  total_number_of_dragnets,
  total_sampling_time_min,
 COUNT(DISTINCT e.cd_event) nb_event,
 ARRAY_AGG(DISTINCT event_id) event_ids,
 SUM(qt_int) FILTER (WHERE t.name_tax IS NOT NULL OR mt.pseudo_rank='SP') total_abundance,
 COUNT(DISTINCT 
  CASE
   WHEN mt.pseudo_rank='sp' THEN verbatim_taxon
   ELSE t.name_tax
  END 
  ) FILTER (WHERE t.name_tax IS NOT NULL OR mt.pseudo_rank='SP') richness,
 SUM(qt_int) total_abundance_without_taxo_filter,
  ST_X(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) x_coord_centroid,
  ST_Y(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) y_coord_centroid
FROM main.registros r
LEFT JOIN main.individual_characteristics ic USING(cd_reg)
LEFT JOIN main.def_ind_charac_categ dicc ON dicc.cd_var_ind_char= (SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Life stage') AND ic.cd_categ=dicc.cd_categ
FULL OUTER JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.event_extra eep ON e.cd_event=eep.cd_event AND eep.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='period') 
LEFT JOIN main.gp_event ge USING(cd_gp_event)
LEFT JOIN main.def_protocol p USING (cd_protocol)
LEFT JOIN main.def_season s ON COALESCE((ee.value_text::date||' 12:00:00')::timestamp,e.date_time_begin) <@ s.date_range
LEFT JOIN main.punto_referencia pr USING (cd_pt_ref)
LEFT JOIN habitat_gp_event_aquatic hge USING (cd_gp_event)
LEFT JOIN punto_ref_platform prf USING (cd_pt_ref,name_pt_ref)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'GN')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN se ON se.anh_tempo=name_pt_ref||'_'||cd_tempo
WHERE 
  ge.cd_gp_biol='pece'
  AND protocol='Drag net'
  AND eep.cd_categ_event_extra=(SELECT cd_categ_event_extra FROM main.def_categ_event_extra WHERE categ='Day')
GROUP BY 
  name_pt_ref||'_'||cd_tempo,
  wat_body_type, tipo_cuerp_agua,
  eco_type,tipo_ecos,
  total_number_of_dragnets,
  total_sampling_time_min,
  platform;


CREATE OR REPLACE VIEW pece_info_sampling_electric AS
WITH se AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  SUM(samp_effort_1) total_sampling_time_min
FROM main.event e
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.event_extra eep ON e.cd_event=eep.cd_event AND eep.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='period') 
LEFT JOIN main.def_season s ON COALESCE(e.date_time_begin,(ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE
  ge.cd_gp_biol='pece' 
  AND protocol='Electric fishing'
  AND eep.cd_categ_event_extra=(SELECT cd_categ_event_extra FROM main.def_categ_event_extra WHERE categ='Day')
GROUP BY 
  name_pt_ref,cd_tempo 
)
SELECT 
 ARRAY_AGG(DISTINCT ge.cd_gp_event) cds_gp_event,
 name_pt_ref||'_'||cd_tempo anh_tempo,
  wat_body_type, tipo_cuerp_agua,
  eco_type,tipo_ecos,
 platform "zone",
 total_sampling_time_min,
 COUNT(DISTINCT e.cd_event) nb_event,
 ARRAY_AGG(DISTINCT event_id) event_ids,
 SUM(qt_int) FILTER (WHERE t.name_tax IS NOT NULL OR mt.pseudo_rank='SP') total_abundance,
 COUNT(DISTINCT 
  CASE
   WHEN mt.pseudo_rank='sp' THEN verbatim_taxon
   ELSE t.name_tax
  END 
  ) FILTER (WHERE t.name_tax IS NOT NULL OR mt.pseudo_rank='SP') richness,
 SUM(qt_int) total_abundance_without_taxo_filter,
  ST_X(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) x_coord_centroid,
  ST_Y(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) y_coord_centroid
FROM main.registros r
LEFT JOIN main.individual_characteristics ic USING(cd_reg)
LEFT JOIN main.def_ind_charac_categ dicc ON dicc.cd_var_ind_char= (SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Life stage') AND ic.cd_categ=dicc.cd_categ
FULL OUTER JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.event_extra eep ON e.cd_event=eep.cd_event AND eep.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='period') 
LEFT JOIN main.gp_event ge USING(cd_gp_event)
LEFT JOIN main.def_protocol p USING (cd_protocol)
LEFT JOIN main.def_season s ON COALESCE((ee.value_text::date||' 12:00:00')::timestamp,e.date_time_begin) <@ s.date_range
LEFT JOIN main.punto_referencia pr USING (cd_pt_ref)
LEFT JOIN habitat_gp_event_aquatic hge USING (cd_gp_event)
LEFT JOIN punto_ref_platform prf USING (cd_pt_ref,name_pt_ref)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'GN')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN se ON se.anh_tempo=name_pt_ref||'_'||cd_tempo
WHERE 
  ge.cd_gp_biol='pece'
  AND protocol='Electric fishing'
  AND eep.cd_categ_event_extra=(SELECT cd_categ_event_extra FROM main.def_categ_event_extra WHERE categ='Day')
GROUP BY 
  name_pt_ref||'_'||cd_tempo,
  wat_body_type, tipo_cuerp_agua,
  eco_type,tipo_ecos,
  total_sampling_time_min,
  platform;


CREATE OR REPLACE VIEW pece_info_sampling_gillnet AS
WITH se AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  SUM(samp_effort_1) total_sampling_time_min
FROM main.event e
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.event_extra eep ON e.cd_event=eep.cd_event AND eep.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='period') 
LEFT JOIN main.def_season s ON COALESCE(e.date_time_begin,(ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE
  ge.cd_gp_biol='pece' 
  AND protocol='Gillnets'
  AND eep.cd_categ_event_extra=(SELECT cd_categ_event_extra FROM main.def_categ_event_extra WHERE categ='Day')
GROUP BY 
  name_pt_ref,cd_tempo 
)
SELECT 
 ARRAY_AGG(DISTINCT ge.cd_gp_event) cds_gp_event,
 name_pt_ref||'_'||cd_tempo anh_tempo,
  wat_body_type, tipo_cuerp_agua,
  eco_type,tipo_ecos,
 platform "zone",
 total_sampling_time_min,
 COUNT(DISTINCT e.cd_event) nb_event,
 ARRAY_AGG(DISTINCT event_id) event_ids,
 SUM(qt_int) FILTER (WHERE t.name_tax IS NOT NULL OR mt.pseudo_rank='SP') total_abundance,
 COUNT(DISTINCT 
  CASE
   WHEN mt.pseudo_rank='sp' THEN verbatim_taxon
   ELSE t.name_tax
  END 
  ) FILTER (WHERE t.name_tax IS NOT NULL OR mt.pseudo_rank='SP') richness,
 SUM(qt_int) total_abundance_without_taxo_filter,
  ST_X(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) x_coord_centroid,
  ST_Y(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) y_coord_centroid
FROM main.registros r
LEFT JOIN main.individual_characteristics ic USING(cd_reg)
LEFT JOIN main.def_ind_charac_categ dicc ON dicc.cd_var_ind_char= (SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Life stage') AND ic.cd_categ=dicc.cd_categ
FULL OUTER JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.event_extra eep ON e.cd_event=eep.cd_event AND eep.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='period') 
LEFT JOIN main.gp_event ge USING(cd_gp_event)
LEFT JOIN main.def_protocol p USING (cd_protocol)
LEFT JOIN main.def_season s ON COALESCE((ee.value_text::date||' 12:00:00')::timestamp,e.date_time_begin) <@ s.date_range
LEFT JOIN main.punto_referencia pr USING (cd_pt_ref)
LEFT JOIN habitat_gp_event_aquatic hge USING (cd_gp_event)
LEFT JOIN punto_ref_platform prf USING (cd_pt_ref,name_pt_ref)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'GN')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN se ON se.anh_tempo=name_pt_ref||'_'||cd_tempo
WHERE 
  ge.cd_gp_biol='pece'
  AND protocol='Gillnets'
  AND eep.cd_categ_event_extra=(SELECT cd_categ_event_extra FROM main.def_categ_event_extra WHERE categ='Day')
GROUP BY 
  name_pt_ref||'_'||cd_tempo,
  wat_body_type, tipo_cuerp_agua,
  eco_type,tipo_ecos,
  total_sampling_time_min,
  platform;



CREATE OR REPLACE VIEW pece_info_sampling_total AS
WITH se AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  SUM(samp_effort_1) FILTER (WHERE protocol='Cast nets') total_number_of_throws_castnets,
  SUM(samp_effort_2) FILTER (WHERE protocol='Cast nets')  total_sampling_time_min_castnets,
  SUM(samp_effort_1) FILTER (WHERE protocol='Drag net') total_number_of_dragnets,
  SUM(samp_effort_2) FILTER (WHERE protocol='Drag net')  total_sampling_time_min_dragnets,
  SUM(samp_effort_1) FILTER (WHERE protocol='Electric fishing') total_sampling_time_min_electric,
  SUM(samp_effort_1) FILTER (WHERE protocol='Gillnets') total_sampling_time_min_gillnets
FROM main.event e
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.event_extra eep ON e.cd_event=eep.cd_event AND eep.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='period') 
LEFT JOIN main.def_season s ON COALESCE(e.date_time_begin,(ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE
  ge.cd_gp_biol='pece' 
  AND eep.cd_categ_event_extra=(SELECT cd_categ_event_extra FROM main.def_categ_event_extra WHERE categ='Day')
GROUP BY 
  name_pt_ref,cd_tempo 
)
SELECT 
 ARRAY_AGG(DISTINCT ge.cd_gp_event) cds_gp_event,
 name_pt_ref||'_'||cd_tempo anh_tempo,
  wat_body_type, tipo_cuerp_agua,
  eco_type,tipo_ecos,
 platform "zone",
  total_number_of_throws_castnets,
  total_sampling_time_min_castnets,
  total_number_of_dragnets,
  total_sampling_time_min_dragnets,
  total_sampling_time_min_electric,
  total_sampling_time_min_gillnets,
  CASE WHEN total_sampling_time_min_castnets IS NULL THEN 0 ELSE total_sampling_time_min_castnets END +
  CASE WHEN total_sampling_time_min_dragnets IS NULL THEN 0 ELSE total_sampling_time_min_dragnets END +
  CASE WHEN  total_sampling_time_min_gillnets IS NULL THEN 0 ELSE total_sampling_time_min_gillnets END +
  CASE WHEN  total_sampling_time_min_electric IS NULL THEN 0 ELSE total_sampling_time_min_electric END  
  total_sampling_time_min,
 COUNT(DISTINCT e.cd_event) nb_event,
 ARRAY_AGG(DISTINCT event_id) event_ids,
 SUM(qt_int) FILTER (WHERE t.name_tax IS NOT NULL OR mt.pseudo_rank='SP') total_abundance,
 COUNT(DISTINCT 
  CASE
   WHEN mt.pseudo_rank='sp' THEN verbatim_taxon
   ELSE t.name_tax
  END 
  ) FILTER (WHERE t.name_tax IS NOT NULL OR mt.pseudo_rank='SP') richness,
 SUM(qt_int) total_abundance_without_taxo_filter,
  ST_X(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) x_coord_centroid,
  ST_Y(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) y_coord_centroid
FROM main.registros r
LEFT JOIN main.individual_characteristics ic USING(cd_reg)
LEFT JOIN main.def_ind_charac_categ dicc ON dicc.cd_var_ind_char= (SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Life stage') AND ic.cd_categ=dicc.cd_categ
FULL OUTER JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.event_extra eep ON e.cd_event=eep.cd_event AND eep.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='period') 
LEFT JOIN main.gp_event ge USING(cd_gp_event)
LEFT JOIN main.def_protocol p USING (cd_protocol)
LEFT JOIN main.def_season s ON COALESCE((ee.value_text::date||' 12:00:00')::timestamp,e.date_time_begin) <@ s.date_range
LEFT JOIN main.punto_referencia pr USING (cd_pt_ref)
LEFT JOIN habitat_gp_event_aquatic hge USING (cd_gp_event)
LEFT JOIN punto_ref_platform prf USING (cd_pt_ref,name_pt_ref)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'GN')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN se ON se.anh_tempo=name_pt_ref||'_'||cd_tempo
WHERE 
  ge.cd_gp_biol='pece'
  AND eep.cd_categ_event_extra=(SELECT cd_categ_event_extra FROM main.def_categ_event_extra WHERE categ='Day')
GROUP BY 
  name_pt_ref||'_'||cd_tempo,
  wat_body_type, tipo_cuerp_agua,
  eco_type,tipo_ecos,
  total_number_of_throws_castnets,
  total_sampling_time_min_castnets,
  total_number_of_dragnets,
  total_sampling_time_min_dragnets,
  total_sampling_time_min_electric,
  total_sampling_time_min_gillnets,
  platform;



CREATE OR REPLACE VIEW pece_envir AS

SELECT
   name_pt_ref||'_'||s.cd_tempo anh_tempo,
   cd_tempo,temp, ph, oxy_dis, cond, oil_film, float_mat, subst_compl_idx, struc_compl_idx, canopy_cover
FROM main.event e
LEFT JOIN main.def_season s ON e.date_time_begin <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.phy_chi_peces  USING (cd_pt_ref,cd_tempo)
WHERE cd_gp_biol='pece'
GROUP BY 
  name_pt_ref||'_'||s.cd_tempo,
   cd_tempo,temp, ph, oxy_dis, cond, oil_film, float_mat, subst_compl_idx, struc_compl_idx, canopy_cover
ORDER BY name_pt_ref||'_'||s.cd_tempo
;
```

## 10.4 Listas

### 10.4.1 Lista completa

- occurrence number es el numero de registros que tienen la especie (si
  la tabla es limpia, corresponde al numero de eventos que contienen el
  taxon)
- la zona está atribuida para cada ANH (se resolvierón los casos de
  eventos fuera de las zonas definidas y las ANH que estaban sobre 2
  zonas distintas

``` sql
CREATE OR REPLACE VIEW pece_list_tot AS(
SELECT 
   tor.name_tax "orden",
   tfam.name_tax "family",
   tgn.name_tax genus,
   COALESCE(verbatim_taxon, t.name_tax) taxon,
   dtr.tax_rank tax_rank,
   dtrm.tax_rank pseudo_rank,
   ARRAY_AGG(DISTINCT protocol) protocols,
   ARRAY_AGG(DISTINCT cd_tempo) temporadas,
   ARRAY_AGG(DISTINCT name_pt_ref) anh,
   ARRAY_AGG(DISTINCT platform) zonas,
   ARRAY_AGG(DISTINCT wat_body_type) landcovs,
   ARRAY_AGG(DISTINCT dceep.categ) periods,
   count(*) "occurrence number",
   sum(qt_int) "total abundance"
FROM main.registros r
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin') 
LEFT JOIN main.event_extra eep ON e.cd_event=eep.cd_event AND eep.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='period') 
LEFT JOIN main.def_categ_event_extra dceep ON eep.cd_categ_event_extra=dceep.cd_categ_event_extra AND dceep.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='period') 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin, (ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.taxo tgn ON find_higher_id(r.cd_tax,'GN')=tgn.cd_tax
LEFT JOIN main.taxo tfam ON find_higher_id(r.cd_tax,'FAM')=tfam.cd_tax
LEFT JOIN main.taxo tor ON find_higher_id(r.cd_tax,'OR')=tor.cd_tax
LEFT JOIN main.morfo_taxo mt USING(cd_morfo)
LEFT JOIN main.taxo tm ON mt.cd_tax=tm.cd_tax
LEFT JOIN main.def_tax_rank dtr ON t.cd_rank=dtr.cd_rank
LEFT JOIN main.def_tax_rank dtrm ON mt.pseudo_rank=dtrm.cd_rank
LEFT JOIN habitat_gp_event_aquatic USING (cd_gp_event)
LEFT JOIN punto_ref_platform USING (cd_pt_ref,name_pt_ref)
WHERE
  ge.cd_gp_biol='pece'
GROUP BY 
   tfam.name_tax, 
   tgn.name_tax,
   tor.name_tax,
   verbatim_taxon,
   t.name_tax,
   dtr.tax_rank,
   dtrm.tax_rank,
   name_morfo,
   tm.name_tax
ORDER BY  sum(qt_int) DESC
)
;
```

<!--
### Lista por temporada
TODO
### Lista por zona y temporada
TODO
### Lista por habitat
TODO
-->

## 10.5 Exportar: R y Excel

Extraer en R y exportar en excel

``` r
(listTable <- dbGetQuery(fracking_db, "SELECT table_name FROM information_schema.tables WHERE table_schema='public' AND table_name ~ '^pece'")$table_name)
```

    ##  [1] "pece_castnets_matrix"        "pece_dragnet_matrix"        
    ##  [3] "pece_elec_matrix"            "pece_envir"                 
    ##  [5] "pece_gillnets_matrix"        "pece_incidence_matrix"      
    ##  [7] "pece_info_sampling_castnet"  "pece_info_sampling_dragnet" 
    ##  [9] "pece_info_sampling_electric" "pece_info_sampling_gillnet" 
    ## [11] "pece_info_sampling_total"    "pece_list_tot"              
    ## [13] "pece_occurrence_matrix"

``` r
export_pece <- lapply(listTable, dbReadTable, conn = fracking_db)
names(export_pece) <- listTable
export_pece[grep("matrix", listTable)] <- lapply(export_pece[grep("matrix",
    listTable)], function(x) {
    col_content <- c("abundance", "density", "incidence")[c("abundance",
        "density", "incidence") %in% colnames(x)]
    o_checklist <- !as.logical(length(col_content))
    dbTab2mat(x, col_samplingUnits = "anh_tempo", col_species = "taxon",
        col_content = col_content, empty = 0, checklist = o_checklist)
})
export_pece <- lapply(export_pece, as.data.frame)
save_in_excel(file = "../../bpw_export//pece_export.xlsx", lVar = export_pece)
```

# 11 Mamiferos

## 11.1 Metodos y resolución taxonomica

### 11.1.1 Total

``` sql
SELECT dtr.cd_rank, pseudo_rank,  count(*)
FROM main.registros r
LEFT JOIN main.event e USING (cd_event)
LEFT JOIN main.gp_event ge USING (cd_gp_event)
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.def_tax_rank dtr USING (cd_rank)
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
WHERE ge.cd_gp_biol='mami'
GROUP BY dtr.cd_rank,dtr.rank_level,pseudo_rank
ORDER BY rank_level DESC
```

<div class="knitsql-table">

</div>

### 11.1.2 Ultrasonidos

``` sql
SELECT dtr.cd_rank, pseudo_rank,  count(*)
FROM main.registros r
LEFT JOIN main.event e USING (cd_event)
LEFT JOIN main.gp_event ge USING (cd_gp_event)
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.def_tax_rank dtr USING (cd_rank)
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE ge.cd_gp_biol='mami' AND protocol='Sound recording'
GROUP BY dtr.cd_rank,dtr.rank_level,pseudo_rank
ORDER BY rank_level DESC
```

<div class="knitsql-table">

</div>

### 11.1.3 Redes de niebla

``` sql
SELECT dtr.cd_rank, pseudo_rank,  count(*)
FROM main.registros r
LEFT JOIN main.event e USING (cd_event)
LEFT JOIN main.gp_event ge USING (cd_gp_event)
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.def_tax_rank dtr USING (cd_rank)
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE ge.cd_gp_biol='mami' AND protocol='Mist nets'
GROUP BY dtr.cd_rank,dtr.rank_level,pseudo_rank
ORDER BY rank_level DESC
```

<div class="knitsql-table">

</div>

### 11.1.4 Trampas Sherman

``` sql
SELECT dtr.cd_rank, pseudo_rank,  count(*)
FROM main.registros r
LEFT JOIN main.event e USING (cd_event)
LEFT JOIN main.gp_event ge USING (cd_gp_event)
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.def_tax_rank dtr USING (cd_rank)
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE ge.cd_gp_biol='mami' AND protocol='Sherman trap'
GROUP BY dtr.cd_rank,dtr.rank_level,pseudo_rank
ORDER BY rank_level DESC
```

<div class="knitsql-table">

</div>

## 11.2 Matrices

### 11.2.1 Ultrasonidos

``` sql
CREATE OR REPLACE VIEW mami_ultrasound_matrix AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  CASE
   WHEN mt.pseudo_rank='SP' THEN tm.name_tax||' ('||name_morfo||')'
   ELSE t.name_tax
  END taxon/*,
  SUM(qt_int) abundance*/
FROM main.registros r
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin') 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin, (ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'SP')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.taxo tm ON mt.cd_tax=tm.cd_tax
LEFT JOIN main.taxo tcl ON find_higher_id(r.cd_tax,'CL')=tcl.cd_tax
WHERE 
  ge.cd_gp_biol='mami' 
  AND protocol='Sound recording'
  AND (t.name_tax IS NOT NULL OR mt.pseudo_rank='SP')--ensure we got the species or morphospecies
  AND num_anh IS NOT NULL
  AND tcl.name_tax='Mammalia'
  GROUP BY 
  name_pt_ref,
  taxon,
  cd_tempo
ORDER BY 
  name_pt_ref||'_'||cd_tempo,
  SUM(qt_int) DESC
);
```

### 11.2.2 Redes de niebla

\*\*Nota: en lugar de exportar todos los mamiferos, pucé una regla acá
para exportar unicamente los Chiroptera (sino, se exporta tambien
*Marmosa robinsoni* que pertenece al orden Didelphimorphia)

``` sql
CREATE OR REPLACE VIEW mami_mist_nets_matrix AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  CASE
   WHEN mt.pseudo_rank='SP' THEN tm.name_tax||' ('||name_morfo||')'
   ELSE t.name_tax
  END taxon,
  SUM(qt_int) abundance
FROM main.registros r
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin') 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin, (ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'SP')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.taxo tm ON mt.cd_tax=tm.cd_tax
LEFT JOIN main.taxo tor ON find_higher_id(r.cd_tax,'OR')=tor.cd_tax
WHERE 
  ge.cd_gp_biol='mami' 
  AND protocol='Mist nets'
  AND (t.name_tax IS NOT NULL OR mt.pseudo_rank='SP')--ensure we got the species or morphospecies
  AND num_anh IS NOT NULL
  AND tor.name_tax='Chiroptera'
GROUP BY 
  name_pt_ref,
  taxon,
  cd_tempo
ORDER BY 
  name_pt_ref||'_'||cd_tempo,
  SUM(qt_int) DESC
);
```

### 11.2.3 Trampas sherman

Solo en caso para futuros estudios (no se corre):

``` sql
CREATE OR REPLACE VIEW mami_sherman_matrix AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  CASE
   WHEN mt.pseudo_rank='GN' THEN tm.name_tax||' ('||name_morfo||')'
   ELSE t.name_tax
  END taxon,
  SUM(qt_int) abundance
FROM main.registros r
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin') 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin, (ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'GN')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.taxo tm ON mt.cd_tax=tm.cd_tax
LEFT JOIN main.taxo tcl ON find_higher_id(r.cd_tax,'CL')=tcl.cd_tax
WHERE 
  ge.cd_gp_biol='mami' 
  AND protocol='Sherman trap'
  AND (t.name_tax IS NOT NULL OR mt.pseudo_rank='GN')--ensure we got the species or morphospecies
  AND num_anh IS NOT NULL
  AND tcl.name_tax='Mammalia'
GROUP BY 
  name_pt_ref,
  taxon,
  cd_tempo
ORDER BY 
  name_pt_ref||'_'||cd_tempo,
  SUM(qt_int) DESC
)
```

### 11.2.4 Redes de niebla y ultrasonidos

``` sql
CREATE OR REPLACE VIEW mami_bat_total_matrix AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  CASE
   WHEN mt.pseudo_rank='SP' THEN tm.name_tax||' ('||name_morfo||')'
   ELSE t.name_tax
  END taxon/*,
  SUM(qt_int) abundance*/
FROM main.registros r
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin') 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin, (ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'SP')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.taxo tm ON mt.cd_tax=tm.cd_tax
LEFT JOIN main.taxo tcl ON find_higher_id(r.cd_tax,'CL')=tcl.cd_tax
WHERE 
  ge.cd_gp_biol='mami' 
  AND protocol IN ('Sherman trap','Sound recording')
  AND (t.name_tax IS NOT NULL OR mt.pseudo_rank='SP')--ensure we got the species or morphospecies
  AND num_anh IS NOT NULL
  AND tcl.name_tax='Mammalia'
GROUP BY 
  name_pt_ref,
  taxon,
  cd_tempo
ORDER BY 
  name_pt_ref||'_'||cd_tempo,
  SUM(qt_int) DESC
);
```

## 11.3 Información sobre los “sampling unit” de las matrices

``` sql
CREATE OR REPLACE VIEW mami_info_sampling_ultrasound AS
WITH se AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  SUM(samp_effort_1) total_sampling_time_min
FROM main.event e
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.def_season s ON COALESCE(e.date_time_begin,(ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE
  ge.cd_gp_biol='mami' 
  AND protocol='Sound recording'
  AND num_anh IS NOT NULL
GROUP BY 
  name_pt_ref,cd_tempo 
)
SELECT 
 ARRAY_AGG(DISTINCT ge.cd_gp_event) cds_gp_event,
 name_pt_ref||'_'||cd_tempo anh_tempo,
 landcov,
 landcov_spa,
 platform "zone",
 total_sampling_time_min,
 COUNT(DISTINCT e.cd_event) nb_event,
 ARRAY_AGG(DISTINCT event_id) event_ids,
 COUNT(DISTINCT 
  CASE
   WHEN mt.pseudo_rank='SP' THEN verbatim_taxon
   ELSE t.name_tax
  END 
  ) FILTER (WHERE (t.name_tax IS NOT NULL OR mt.pseudo_rank='SP') AND tcl.name_tax='Mammalia') richness,
 SUM(qt_int) FILTER (WHERE tcl.name_tax='Mammalia') total_number_of_recordings,
  ST_X(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) x_coord_centroid,
  ST_Y(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) y_coord_centroid
FROM main.registros r
LEFT JOIN main.individual_characteristics ic USING(cd_reg)
LEFT JOIN main.def_ind_charac_categ dicc ON dicc.cd_var_ind_char= (SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Life stage') AND ic.cd_categ=dicc.cd_categ
FULL OUTER JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.gp_event ge USING(cd_gp_event)
LEFT JOIN main.def_protocol p USING (cd_protocol)
LEFT JOIN main.def_season s ON COALESCE((ee.value_text::date||' 12:00:00')::timestamp,e.date_time_begin) <@ s.date_range
LEFT JOIN main.punto_referencia pr USING (cd_pt_ref)
LEFT JOIN landcov_gp_event_terrestrial hge USING (cd_gp_event)
LEFT JOIN punto_ref_platform prf USING (cd_pt_ref,name_pt_ref)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'GN')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.taxo tcl ON find_higher_id(r.cd_tax,'CL')=tcl.cd_tax
LEFT JOIN se ON se.anh_tempo=name_pt_ref||'_'||cd_tempo
--LEFT JOIN gel ON gel.anh_tempo=name_pt_ref||'_'||cd_tempo
WHERE 
  ge.cd_gp_biol='mami' 
  AND protocol='Sound recording'
  AND num_anh IS NOT NULL
GROUP BY 
  name_pt_ref||'_'||cd_tempo,
  landcov,
  landcov_spa,
  total_sampling_time_min,
  platform;

CREATE OR REPLACE VIEW mami_info_sampling_mist_nets AS
WITH se AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  SUM(samp_effort_1) total_net_area,
  SUM(samp_effort_2) total_sampling_time_min

FROM main.event e
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.def_season s ON COALESCE(e.date_time_begin,(ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE
  ge.cd_gp_biol='mami' 
  AND protocol='Mist nets'
  AND num_anh IS NOT NULL
GROUP BY 
  name_pt_ref,cd_tempo 
)
SELECT 
 ARRAY_AGG(DISTINCT ge.cd_gp_event) cds_gp_event,
 name_pt_ref||'_'||cd_tempo anh_tempo,
 landcov,
 landcov_spa,
 platform "zone",
 total_sampling_time_min,
 total_net_area,
 COUNT(DISTINCT e.cd_event) nb_event,
 ARRAY_AGG(DISTINCT event_id) event_ids,
 COUNT(DISTINCT 
  CASE
   WHEN mt.pseudo_rank='SP' THEN verbatim_taxon
   ELSE t.name_tax
  END 
  ) FILTER (WHERE (t.name_tax IS NOT NULL OR mt.pseudo_rank='SP') AND tor.name_tax='Chiroptera') richness,
  SUM(qt_int) FILTER (WHERE tcl.name_tax='Mammalia') total_abundance_without_taxo_filter,
  SUM(qt_int) FILTER (WHERE tor.name_tax='Chiroptera' AND (t.name_tax IS NOT NULL OR mt.pseudo_rank='SP') ) total_abundance,
  ST_X(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) x_coord_centroid,
  ST_Y(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) y_coord_centroid
FROM main.registros r
LEFT JOIN main.individual_characteristics ic USING(cd_reg)
LEFT JOIN main.def_ind_charac_categ dicc ON dicc.cd_var_ind_char= (SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Life stage') AND ic.cd_categ=dicc.cd_categ
FULL OUTER JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.gp_event ge USING(cd_gp_event)
LEFT JOIN main.def_protocol p USING (cd_protocol)
LEFT JOIN main.def_season s ON COALESCE((ee.value_text::date||' 12:00:00')::timestamp,e.date_time_begin) <@ s.date_range
LEFT JOIN main.punto_referencia pr USING (cd_pt_ref)
LEFT JOIN landcov_gp_event_terrestrial hge USING (cd_gp_event)
LEFT JOIN punto_ref_platform prf USING (cd_pt_ref,name_pt_ref)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'GN')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.taxo tcl ON find_higher_id(r.cd_tax,'CL')=tcl.cd_tax
LEFT JOIN main.taxo tor ON find_higher_id(r.cd_tax,'OR')=tor.cd_tax
LEFT JOIN se ON se.anh_tempo=name_pt_ref||'_'||cd_tempo
--LEFT JOIN gel ON gel.anh_tempo=name_pt_ref||'_'||cd_tempo
WHERE 
  ge.cd_gp_biol='mami' 
  AND protocol='Mist nets'
  AND num_anh IS NOT NULL
GROUP BY 
  name_pt_ref||'_'||cd_tempo,
  landcov,
  landcov_spa,
  total_sampling_time_min,
 total_net_area,
  platform;
```

## 11.4 Listas

**TODO**

## 11.5 Exportar: R y Excel

Extraer en R y exportar en excel

``` r
(listTable <- dbGetQuery(fracking_db, "SELECT table_name FROM information_schema.tables WHERE table_schema='public' AND table_name ~ '^mami'")$table_name)
```

    ## [1] "mami_bat_total_matrix"         "mami_info_sampling_mist_nets" 
    ## [3] "mami_info_sampling_ultrasound" "mami_mist_nets_matrix"        
    ## [5] "mami_ultrasound_matrix"

``` r
export_mami <- lapply(listTable, dbReadTable, conn = fracking_db)
names(export_mami) <- listTable
export_mami[grep("matrix", listTable)] <- lapply(export_mami[grep("matrix",
    listTable)], function(x) {
    col_content <- c("abundance", "density")[c("abundance", "density") %in%
        colnames(x)]
    o_checklist <- !as.logical(length(col_content))
    dbTab2mat(x, col_samplingUnits = "anh_tempo", col_species = "taxon",
        col_content = col_content, empty = 0, checklist = o_checklist)
})
export_mami <- lapply(export_mami, as.data.frame)
save_in_excel(file = "../../bpw_export//mami_export.xlsx", lVar = export_mami)
```

# 12 Aves

## 12.1 Metodos y resolución taxonomica

### 12.1.1 Total

``` sql
SELECT dtr.cd_rank, pseudo_rank,  count(*)
FROM main.registros r
LEFT JOIN main.event e USING (cd_event)
LEFT JOIN main.gp_event ge USING (cd_gp_event)
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.def_tax_rank dtr USING (cd_rank)
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
WHERE ge.cd_gp_biol='aves'
GROUP BY dtr.cd_rank,dtr.rank_level,pseudo_rank
ORDER BY rank_level DESC
```

<div class="knitsql-table">

</div>

### 12.1.2 Punto fijo

``` sql
SELECT dtr.cd_rank, pseudo_rank,  count(*)
FROM main.registros r
LEFT JOIN main.event e USING (cd_event)
LEFT JOIN main.gp_event ge USING (cd_gp_event)
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.def_tax_rank dtr USING (cd_rank)
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE ge.cd_gp_biol='aves' AND protocol='Bird point count'
GROUP BY dtr.cd_rank,dtr.rank_level,pseudo_rank
ORDER BY rank_level DESC
```

<div class="knitsql-table">

</div>

## 12.2 Matrices

### 12.2.1 Bird point count

Note: el calculo es el siguiente: \* la abundancia de una especie en un
punto (con 3 replicaciones) es el maximo de las 3 replicaciones \* la
abundancia en una anh_tempo es la suma de los 3 (3 pt por anh) maximos
(más simple más tarde para los analisis que el promedio)

``` sql
CREATE OR REPLACE VIEW aves_point_count_matrix AS(
WITH rep AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  name_pt_ref||'_'||subpart||'_'||cd_tempo anh_pt_tempo,
  name_pt_ref||'_'||subpart||'_'||description_replicate||'_'||cd_tempo anh_pt_rep_tempo,
  CASE
   WHEN mt.pseudo_rank='SP' THEN tm.name_tax||' ('||name_morfo||')'
   ELSE t.name_tax
  END taxon,
  SUM(qt_int) abundance
FROM main.registros r
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin') 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin, (ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'SP')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.taxo tm ON mt.cd_tax=tm.cd_tax
LEFT JOIN main.taxo tcl ON find_higher_id(r.cd_tax,'CL')=tcl.cd_tax
WHERE 
  ge.cd_gp_biol='aves' 
  AND protocol='Bird point count'
  AND (t.name_tax IS NOT NULL OR mt.pseudo_rank='SP')--ensure we got the species or morphospecies
  AND num_anh IS NOT NULL
  AND tcl.name_tax='Aves'
GROUP BY 
  name_pt_ref,
  taxon,
  subpart,
  description_replicate,
  cd_tempo
ORDER BY 
  name_pt_ref||'_'||cd_tempo,
  SUM(qt_int) DESC
), pt AS(
SELECT anh_tempo,anh_pt_tempo,taxon,MAX(abundance) abundance
FROM rep
GROUP BY anh_tempo,anh_pt_tempo,taxon
)
SELECT anh_tempo,taxon,sum(abundance) abundance
FROM pt
GROUP BY anh_tempo,taxon
ORDER BY 
  anh_tempo,
  sum(abundance) DESC

);

CREATE OR REPLACE VIEW aves_point_count_puresum_matrix AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  CASE
   WHEN mt.pseudo_rank='SP' THEN tm.name_tax||' ('||name_morfo||')'
   ELSE t.name_tax
  END taxon,
  SUM(qt_int) abundance
FROM main.registros r
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin') 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin, (ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'SP')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.taxo tm ON mt.cd_tax=tm.cd_tax
LEFT JOIN main.taxo tcl ON find_higher_id(r.cd_tax,'CL')=tcl.cd_tax
WHERE 
  ge.cd_gp_biol='aves' 
  AND protocol='Bird point count'
  AND (t.name_tax IS NOT NULL OR mt.pseudo_rank='SP')--ensure we got the species or morphospecies
  AND num_anh IS NOT NULL
  AND tcl.name_tax='Aves'
GROUP BY 
  name_pt_ref,
  taxon,
  cd_tempo
ORDER BY 
  name_pt_ref||'_'||cd_tempo,
  SUM(qt_int) DESC
)
```

## 12.3 Información sobre los “sampling unit” de las matrices

``` sql
CREATE OR REPLACE VIEW aves_info_sampling_point_count AS
WITH se AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  SUM(samp_effort_1) total_sampling_time_min
FROM main.event e
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.def_season s ON COALESCE(e.date_time_begin,(ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE
  ge.cd_gp_biol='aves' 
  AND protocol='Bird point count'
  AND num_anh IS NOT NULL
GROUP BY 
  name_pt_ref,cd_tempo 
)
SELECT 
 ARRAY_AGG(DISTINCT ge.cd_gp_event) cds_gp_event,
 name_pt_ref||'_'||cd_tempo anh_tempo,
 landcov,
 landcov_spa,
 platform "zone",
 total_sampling_time_min,
 COUNT(DISTINCT e.cd_event) nb_event,
 ARRAY_AGG(DISTINCT event_id) event_ids,
 COUNT(DISTINCT 
  CASE
   WHEN mt.pseudo_rank='SP' THEN verbatim_taxon
   ELSE t.name_tax
  END 
  ) FILTER (WHERE (t.name_tax IS NOT NULL OR mt.pseudo_rank='SP') AND tcl.name_tax='Aves') richness,
  SUM(qt_int) FILTER (WHERE tcl.name_tax='Aves') total_number_of_recordings,
  ST_X(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) x_coord_centroid,
  ST_Y(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) y_coord_centroid
FROM main.registros r
LEFT JOIN main.individual_characteristics ic USING(cd_reg)
LEFT JOIN main.def_ind_charac_categ dicc ON dicc.cd_var_ind_char= (SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Life stage') AND ic.cd_categ=dicc.cd_categ
FULL OUTER JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.gp_event ge USING(cd_gp_event)
LEFT JOIN main.def_protocol p USING (cd_protocol)
LEFT JOIN main.def_season s ON COALESCE((ee.value_text::date||' 12:00:00')::timestamp,e.date_time_begin) <@ s.date_range
LEFT JOIN main.punto_referencia pr USING (cd_pt_ref)
LEFT JOIN landcov_gp_event_terrestrial hge USING (cd_gp_event)
LEFT JOIN punto_ref_platform prf USING (cd_pt_ref,name_pt_ref)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'GN')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.taxo tcl ON find_higher_id(r.cd_tax,'CL')=tcl.cd_tax
LEFT JOIN se ON se.anh_tempo=name_pt_ref||'_'||cd_tempo
--LEFT JOIN gel ON gel.anh_tempo=name_pt_ref||'_'||cd_tempo
WHERE 
  ge.cd_gp_biol='aves' 
  AND protocol='Bird point count'
  AND num_anh IS NOT NULL
GROUP BY 
  name_pt_ref||'_'||cd_tempo,
  landcov,
  landcov_spa,
  total_sampling_time_min,
  platform;
```

## 12.4 Listas

**TODO**

## 12.5 Exportar: R y Excel

Extraer en R y exportar en excel

``` r
(listTable <- dbGetQuery(fracking_db, "SELECT table_name FROM information_schema.tables WHERE table_schema='public' AND table_name ~ '^aves'")$table_name)
```

    ## [1] "aves_info_sampling_point_count"  "aves_point_count_matrix"        
    ## [3] "aves_point_count_puresum_matrix"

``` r
export_aves <- lapply(listTable, dbReadTable, conn = fracking_db)
names(export_aves) <- listTable
export_aves[grep("matrix", listTable)] <- lapply(export_aves[grep("matrix",
    listTable)], function(x) {
    col_content <- c("abundance", "density")[c("abundance", "density") %in%
        colnames(x)]
    o_checklist <- !as.logical(length(col_content))
    dbTab2mat(x, col_samplingUnits = "anh_tempo", col_species = "taxon",
        col_content = col_content, empty = 0, checklist = o_checklist)
})
export_aves <- lapply(export_aves, as.data.frame)
save_in_excel(file = "../../bpw_export//aves_export.xlsx", lVar = export_aves)
```

# 13 Herpetos

## 13.1 Anfibios

### 13.1.1 Resolución taxonomica

``` sql
SELECT dtr.cd_rank, pseudo_rank,  count(*)
FROM main.registros r
LEFT JOIN main.event e USING (cd_event)
LEFT JOIN main.gp_event ge USING (cd_gp_event)
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.def_tax_rank dtr USING (cd_rank)
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.taxo tcl ON tcl.cd_tax=find_higher_id(r.cd_tax,'CL')
WHERE ge.cd_gp_biol='herp' AND tcl.name_tax='Amphibia'
GROUP BY tcl.name_tax,dtr.cd_rank,dtr.rank_level,pseudo_rank
ORDER BY rank_level DESC
```

<div class="knitsql-table">

</div>

Casi todos los anfibios están a nivel de especie: no hay debate acá

### 13.1.2 Matrices

``` sql
CREATE OR REPLACE VIEW herp_amphibian_matrix AS
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
--  description_replicate,
  CASE
   WHEN mt.pseudo_rank='SP' THEN tm.name_tax||' '||name_morfo
   ELSE t.name_tax
  END taxon,
  SUM(qt_int) abundance
FROM main.registros r
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin') 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin, (ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'SP')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.taxo tm ON mt.cd_tax=tm.cd_tax
LEFT JOIN main.taxo tcl ON find_higher_id(r.cd_tax,'CL')=tcl.cd_tax
WHERE 
  ge.cd_gp_biol='herp' 
  AND (t.name_tax IS NOT NULL OR mt.pseudo_rank='SP')--ensure we got the species or morphospecies
  AND num_anh IS NOT NULL
  AND tcl.name_tax='Amphibia'
GROUP BY 
  name_pt_ref,
  taxon,
-- description_replicate,
  cd_tempo
ORDER BY 
  name_pt_ref||'_'||cd_tempo,
  SUM(qt_int) DESC
;
```

### 13.1.3 Información sobre los “sampling unit” de las matrices

``` sql
CREATE OR REPLACE VIEW herp_info_sampling_amphibians AS
WITH se AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  ROUND(SUM(EXTRACT(EPOCH FROM date_time_end-date_time_begin)/60)) total_sampling_time_min,
  SUM(samp_effort_1) total_transect_length
FROM main.event e
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.def_season s ON COALESCE(e.date_time_begin,(ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
WHERE
  ge.cd_gp_biol='herp' 
  AND num_anh IS NOT NULL
GROUP BY 
  name_pt_ref,cd_tempo 
)
SELECT 
 ARRAY_AGG(DISTINCT ge.cd_gp_event) cds_gp_event,
 name_pt_ref||'_'||cd_tempo anh_tempo,
 landcov,
 landcov_spa,
 platform "zone",
 total_sampling_time_min,
 total_transect_length,
 COUNT(DISTINCT e.cd_event) nb_event,
 ARRAY_AGG(DISTINCT event_id) event_ids,
 COUNT(DISTINCT 
  CASE
   WHEN mt.pseudo_rank='SP' THEN verbatim_taxon
   ELSE t.name_tax
  END 
  ) FILTER (WHERE (t.name_tax IS NOT NULL OR mt.pseudo_rank='SP') AND tcl.name_tax='Amphibia') richness,
  SUM(qt_int) FILTER (WHERE tcl.name_tax='Amphibia') total_number_of_sightings,
  ST_X(ST_Centroid(ST_COLLECT(DISTINCT li_geom))) x_coord_centroid,
  ST_Y(ST_Centroid(ST_COLLECT(DISTINCT li_geom))) y_coord_centroid
FROM main.registros r
LEFT JOIN main.individual_characteristics ic USING(cd_reg)
LEFT JOIN main.def_ind_charac_categ dicc ON dicc.cd_var_ind_char= (SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Life stage') AND ic.cd_categ=dicc.cd_categ
FULL OUTER JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.gp_event ge USING(cd_gp_event)
LEFT JOIN main.def_protocol p USING (cd_protocol)
LEFT JOIN main.def_season s ON COALESCE((ee.value_text::date||' 12:00:00')::timestamp,e.date_time_begin) <@ s.date_range
LEFT JOIN main.punto_referencia pr USING (cd_pt_ref)
LEFT JOIN landcov_gp_event_terrestrial hge USING (cd_gp_event)
LEFT JOIN punto_ref_platform prf USING (cd_pt_ref,name_pt_ref)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'GN')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.taxo tcl ON find_higher_id(r.cd_tax,'CL')=tcl.cd_tax
LEFT JOIN se ON se.anh_tempo=name_pt_ref||'_'||cd_tempo
--LEFT JOIN gel ON gel.anh_tempo=name_pt_ref||'_'||cd_tempo
WHERE 
  ge.cd_gp_biol='herp' 
  AND num_anh IS NOT NULL
  AND (tcl.name_tax='Amphibia' OR tcl.name_tax IS NULL)
GROUP BY 
  name_pt_ref||'_'||cd_tempo,
  landcov,
  landcov_spa,
  total_sampling_time_min,
  total_transect_length,
  platform;
```

### 13.1.4 Listas

**TODO**

## 13.2 Reptiles

### 13.2.1 Resolución taxonomica

``` sql
SELECT dtr.cd_rank, pseudo_rank,  count(*)
FROM main.registros r
LEFT JOIN main.event e USING (cd_event)
LEFT JOIN main.gp_event ge USING (cd_gp_event)
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.def_tax_rank dtr USING (cd_rank)
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.taxo tcl ON tcl.cd_tax=find_higher_id(r.cd_tax,'CL')
WHERE ge.cd_gp_biol='herp' AND tcl.name_tax='Reptilia'
GROUP BY tcl.name_tax,dtr.cd_rank,dtr.rank_level,pseudo_rank
ORDER BY rank_level DESC
```

<div class="knitsql-table">

</div>

Casi todos los anfibios están a nivel de especie: no hay debate acá

### 13.2.2 Matrices

``` sql
CREATE OR REPLACE VIEW herp_reptiles_matrix AS
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
--  description_replicate,
  CASE
   WHEN mt.pseudo_rank='SP' THEN tm.name_tax||' '||name_morfo
   ELSE t.name_tax
  END taxon,
  SUM(qt_int) abundance
FROM main.registros r
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin') 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin, (ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'SP')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.taxo tm ON mt.cd_tax=tm.cd_tax
LEFT JOIN main.taxo tcl ON find_higher_id(r.cd_tax,'CL')=tcl.cd_tax
WHERE 
  ge.cd_gp_biol='herp' 
  AND (t.name_tax IS NOT NULL OR mt.pseudo_rank='SP')--ensure we got the species or morphospecies
  AND num_anh IS NOT NULL
  AND tcl.name_tax='Reptilia'
GROUP BY 
  name_pt_ref,
  taxon,
-- description_replicate,
  cd_tempo
ORDER BY 
  name_pt_ref||'_'||cd_tempo,
  SUM(qt_int) DESC
;
```

### 13.2.3 Información sobre los “sampling unit” de las matrices

``` sql
CREATE OR REPLACE VIEW herp_info_sampling_reptiles AS
WITH se AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  ROUND(SUM(EXTRACT(EPOCH FROM date_time_end-date_time_begin)/60)) total_sampling_time_min,
  SUM(samp_effort_1) total_transect_length
FROM main.event e
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.def_season s ON COALESCE(e.date_time_begin,(ee.value_text||' 12:00:00')::timestamp) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
WHERE
  ge.cd_gp_biol='herp' 
  AND num_anh IS NOT NULL
GROUP BY 
  name_pt_ref,cd_tempo 
)
SELECT 
 ARRAY_AGG(DISTINCT ge.cd_gp_event) cds_gp_event,
 name_pt_ref||'_'||cd_tempo anh_tempo,
 landcov,
 landcov_spa,
 platform "zone",
 total_sampling_time_min,
 total_transect_length,
 COUNT(DISTINCT e.cd_event) nb_event,
 ARRAY_AGG(DISTINCT event_id) event_ids,
 COUNT(DISTINCT 
  CASE
   WHEN mt.pseudo_rank='SP' THEN verbatim_taxon
   ELSE t.name_tax
  END 
  ) FILTER (WHERE (t.name_tax IS NOT NULL OR mt.pseudo_rank='SP') AND tcl.name_tax='Reptilia') richness,
  SUM(qt_int) FILTER (WHERE tcl.name_tax='Reptilia') total_number_of_sightings,
  ST_X(ST_Centroid(ST_COLLECT(DISTINCT li_geom))) x_coord_centroid,
  ST_Y(ST_Centroid(ST_COLLECT(DISTINCT li_geom))) y_coord_centroid
FROM main.registros r
LEFT JOIN main.individual_characteristics ic USING(cd_reg)
LEFT JOIN main.def_ind_charac_categ dicc ON dicc.cd_var_ind_char= (SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Life stage') AND ic.cd_categ=dicc.cd_categ
FULL OUTER JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND ee.cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin')
LEFT JOIN main.gp_event ge USING(cd_gp_event)
LEFT JOIN main.def_protocol p USING (cd_protocol)
LEFT JOIN main.def_season s ON COALESCE((ee.value_text::date||' 12:00:00')::timestamp,e.date_time_begin) <@ s.date_range
LEFT JOIN main.punto_referencia pr USING (cd_pt_ref)
LEFT JOIN landcov_gp_event_terrestrial hge USING (cd_gp_event)
LEFT JOIN punto_ref_platform prf USING (cd_pt_ref,name_pt_ref)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'GN')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.taxo tcl ON find_higher_id(r.cd_tax,'CL')=tcl.cd_tax
LEFT JOIN se ON se.anh_tempo=name_pt_ref||'_'||cd_tempo
--LEFT JOIN gel ON gel.anh_tempo=name_pt_ref||'_'||cd_tempo
WHERE 
  ge.cd_gp_biol='herp' 
  AND num_anh IS NOT NULL
  AND (tcl.name_tax='Reptilia' OR tcl.name_tax IS NULL)
GROUP BY 
  name_pt_ref||'_'||cd_tempo,
  landcov,
  landcov_spa,
  total_sampling_time_min,
  total_transect_length,
  platform;
```

### 13.2.4 Listas

**TODO**

## 13.3 Exportar: R y Excel

Extraer en R y exportar en excel

``` r
(listTable <- dbGetQuery(fracking_db, "SELECT table_name FROM information_schema.tables WHERE table_schema='public' AND table_name ~ '^herp'")$table_name)
```

    ## [1] "herp_amphibian_matrix"         "herp_info_sampling_amphibians"
    ## [3] "herp_info_sampling_reptiles"   "herp_reptiles_matrix"

``` r
export_herp <- lapply(listTable, dbReadTable, conn = fracking_db)
names(export_herp) <- listTable
export_herp[grep("matrix", listTable)] <- lapply(export_herp[grep("matrix",
    listTable)], function(x) {
    col_content <- c("abundance", "density")[c("abundance", "density") %in%
        colnames(x)]
    o_checklist <- !as.logical(length(col_content))
    dbTab2mat(x, col_samplingUnits = "anh_tempo", col_species = "taxon",
        col_content = col_content, empty = 0, checklist = o_checklist)
})
export_herp <- lapply(export_herp, as.data.frame)
save_in_excel(file = "../../bpw_export//herp_export.xlsx", lVar = export_herp)
```

# 14 Zooplancton

## 14.1 Niveles taxonomicos

``` sql
SELECT dtr.cd_rank, pseudo_rank,  count(*), SUM(qt_int)
FROM main.registros r
LEFT JOIN main.event e USING (cd_event)
LEFT JOIN main.gp_event ge USING (cd_gp_event)
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.def_tax_rank dtr USING (cd_rank)
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
WHERE ge.cd_gp_biol='zopl'
GROUP BY dtr.cd_rank,dtr.rank_level,pseudo_rank
ORDER BY rank_level DESC
```

<div class="knitsql-table">

</div>

Viendo esos resultados, lo más lógico sería trabajar al nivel de la
especie o morfo especie, pero la resolución de Maxilopoda parece hacerse
hasta genero, así que lo vamos a trabajar a escala del genero

Juan Carlos Quijano me envió las indicaciones siguientes para manejar
los

1.  hay dos morfotipos a los cuales pueden pertenecer esos estadios
    juveniles de zooplancton que son Mesocyclops y Prionodiaptomus.
2.  En caso de que en la estación haya un solo género de estos dos
    individuos la sugerencia es sumar los valores de maxillipoda mf 1 y
    Mf2 a genero presente.
3.  Si en la estación se encuentran ambos géneros ( Mesocyclops y
    Prionodiaptomus) la sugerencia es repartir en partes iguales las
    abundancias de maxillipoda Mf 1 y MF2 a cada uno de estos géneros.
4.  El inconveniente seria en las estaciones donde solo aparecen las
    morfoespecies de Maxillipoda sin los géneros, allí no generó
    recomendaciones como tal pero lo que creería es repartir igualmente
    estos valores en ambos géneros para no perder la información y se
    menciona en el DWC y en el informe que los estados inmaduros se
    repartieron en estos dos géneros con presencia en la zona.

## 14.2 Matriz

``` sql
CREATE OR REPLACE VIEW zopl_matrix AS
WITH a AS(
SELECT e.cd_event,e.event_id,
  SUM(qt_double) FILTER (WHERE name_tax='Maxillopoda') maxill_double,
  SUM(qt_int) FILTER (WHERE name_tax='Maxillopoda') maxill_int,
  SUM(qt_double) FILTER (WHERE name_tax='Mesocyclops') mesocy_double,
  SUM(qt_int) FILTER  (WHERE name_tax='Mesocyclops') mesocy_int,
  SUM(qt_double) FILTER (WHERE name_tax='Prionodiaptomus') priono_double,
  SUM(qt_int) FILTER  (WHERE name_tax='Prionodiaptomus') priono_int
FROM main.registros r
LEFT JOIN main.event e USING (cd_event)
LEFT JOIN main.gp_event ge USING (cd_gp_event)
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.morfo_taxo USING(cd_morfo,cd_gp_biol)
WHERE ge.cd_gp_biol='zopl' AND name_tax IN ('Maxillopoda','Prionodiaptomus','Mesocyclops')
GROUP BY event_id,e.cd_event
ORDER BY event_id
), b AS(
SELECT cd_event,event_id,
 CASE
  WHEN maxill_double IS NOT NULL AND mesocy_double IS NOT NULL AND priono_double IS NOT NULL THEN mesocy_double+(maxill_double*(mesocy_double/(mesocy_double+priono_double)))
  WHEN maxill_double IS NOT NULL AND mesocy_double IS NOT NULL AND priono_double IS NULL THEN mesocy_double+maxill_double
  WHEN maxill_double IS NOT NULL AND mesocy_double IS NULL AND priono_double IS NULL THEN (maxill_double/2)
  ELSE mesocy_double
 END,
 CASE
  WHEN maxill_int IS NOT NULL AND mesocy_int IS NOT NULL AND priono_int IS NOT NULL THEN mesocy_int+ROUND(maxill_int::double precision*(mesocy_int::double precision/(mesocy_int::double precision+priono_int::double precision)))
  WHEN maxill_int IS NOT NULL AND mesocy_int IS NOT NULL AND priono_int IS NULL THEN mesocy_int+maxill_int
  WHEN maxill_int IS NOT NULL AND mesocy_int IS NULL AND priono_int IS NULL THEN CEIL(maxill_int::double precision/2)
  ELSE mesocy_int
 END,
 CASE
  WHEN maxill_double IS NOT NULL AND mesocy_double IS NOT NULL AND priono_double IS NOT NULL THEN priono_double+(maxill_double*(priono_double/(mesocy_double+priono_double)))
  WHEN maxill_double IS NOT NULL AND mesocy_double IS NULL AND priono_double IS NOT NULL THEN priono_double+maxill_double
  WHEN maxill_double IS NOT NULL AND mesocy_double IS NULL AND priono_double IS NULL THEN maxill_double/2
  ELSE priono_double
 END,
 CASE
  WHEN maxill_int IS NOT NULL AND mesocy_int IS NOT NULL AND priono_int IS NOT NULL THEN priono_int+ROUND(maxill_int::double precision*(priono_int::double precision/(mesocy_int::double precision+priono_int::double precision)))
  WHEN maxill_int IS NOT NULL AND mesocy_int IS NULL AND priono_int IS NOT NULL THEN priono_int+maxill_int
  WHEN maxill_int IS NOT NULL AND mesocy_int IS NULL AND priono_int IS NULL THEN FLOOR(maxill_int::double precision/2)
  ELSE priono_int
 END
FROM a
), c AS(
(
SELECT cd_event,event_id,
 'Cyclopoida' "orden",
 'Cyclopidae' "family",
 'Mesocyclops' "genus",
 'Mesocyclops sp1.' taxon,
 mesocy_double AS qt_double,
 mesocy_int AS qt_int
 FROM b
 WHERE mesocy_double IS NOT NULL
)
UNION ALL
(SELECT cd_event,event_id,
 'Calanoida' "orden",
 'Diaptomidae' "family",
 'Prionodiaptomus' "genus",
 'Prionodiaptomus sp1.' taxon,
 priono_double AS qt_double,
 priono_int AS qt_int
 FROM b
 WHERE priono_double IS NOT NULL
)
UNION ALL
(
SELECT 
  cd_event,event_id,
  tor.name_tax AS "orden",
  tfam.name_tax AS family,
  tgn.name_tax genus,
  --r.cd_tax,
  COALESCE(verbatim_taxon,t.name_tax) taxon,
  SUM(qt_double) qt_double,
  SUM(qt_int) qt_int
FROM main.registros r
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.event e USING (cd_event)
LEFT JOIN main.gp_event ge USING (cd_gp_event)
LEFT JOIN main.taxo tfam ON tfam.cd_tax=find_higher_id(r.cd_tax,'FAM')
LEFT JOIN main.taxo tor ON tor.cd_tax=find_higher_id(r.cd_tax,'OR')
LEFT JOIN main.taxo tgn ON tgn.cd_tax=find_higher_id(r.cd_tax,'GN')
WHERE
  ge.cd_gp_biol='zopl' 
  AND COALESCE(mt.pseudo_rank, t.cd_rank)='SP'
  AND t.name_tax NOT IN ('Maxillopoda','Prionodiaptomus','Mesocyclops')
GROUP BY
 cd_event,event_id,
 tor.name_tax,
 tfam.name_tax,
 tgn.name_tax,
 t.name_tax,
 verbatim_taxon
)
)
SELECT cd_gp_event,
 name_pt_ref||'_'||cd_tempo anh_tempo,
 "orden",
 "family",
 "genus",
 taxon,
 SUM(qt_double)/3 density,
 SUM(qt_int)::int abs_abundance
FROM c
LEFT JOIN main.event e USING (cd_event)
LEFT JOIN main.gp_event USING (cd_gp_event)
LEFT JOIN main.def_season s ON e.date_time_begin <@ s.date_range
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
GROUP BY cd_gp_event,"orden","family",genus,taxon,name_pt_ref,cd_tempo
ORDER BY name_pt_ref,cd_tempo,"orden", "family", genus
```

## 14.3 Información sobre los “sampling unit” de las matrices

``` sql
CREATE OR REPLACE VIEW zopl_info_sampling AS(
WITH se AS(
SELECT 
  name_pt_ref||'_'||cd_tempo anh_tempo,
  SUM(samp_effort_1) number_of_bottles,
  SUM(samp_effort_2) total_volumen
FROM main.event e
LEFT JOIN main.def_season s ON e.date_time_begin <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE
  ge.cd_gp_biol='zopl' 
GROUP BY 
  ge.cd_gp_event,
  name_pt_ref,cd_tempo 
)
SELECT 
  ge.cd_gp_event,
  name_pt_ref||'_'||cd_tempo anh_tempo,
  wat_body_type, tipo_cuerp_agua,
  eco_type,tipo_ecos,
  platform "zone",
  number_of_bottles,
  total_volumen,
  COUNT(DISTINCT cd_event) nb_events,
  ARRAY_AGG(DISTINCT event_id) event_ids,
  COUNT(DISTINCT COALESCE(verbatim_taxon,t.name_tax)) FILTER (WHERE COALESCE(mt.pseudo_rank, t.cd_rank)='SP') richness,
  SUM(qt_double) FILTER (WHERE COALESCE(mt.pseudo_rank, t.cd_rank)='SP') /COUNT(DISTINCT cd_event)  total_density,
  SUM(qt_double)/COUNT(DISTINCT cd_event) total_density_without_taxo_filter,
  ST_X(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) x_coord_centroid,
  ST_Y(ST_Centroid(ST_COLLECT(DISTINCT pt_geom))) y_coord_centroid
FROM main.registros r
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
FULL OUTER JOIN main.event e USING (cd_event) 
LEFT JOIN main.def_season s ON e.date_time_begin <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN habitat_gp_event_aquatic USING (cd_gp_event)
LEFT JOIN punto_ref_platform prp USING (cd_pt_ref,name_pt_ref)
LEFT JOIN se ON se.anh_tempo=name_pt_ref||'_'||cd_tempo
WHERE 
  ge.cd_gp_biol='zopl' 
GROUP BY 
  ge.cd_gp_event,
  name_pt_ref,
  wat_body_type, tipo_cuerp_agua,
  eco_type,tipo_ecos,
  platform,
  number_of_bottles,
  total_volumen,
  cd_tempo
ORDER BY 
  ge.cd_gp_event,
  name_pt_ref||'_'||cd_tempo
);

CREATE OR REPLACE VIEW zopl_envir_water AS

SELECT ge.cd_gp_event,
  name_pt_ref||'_'||s.cd_tempo anh_tempo,
 basin, mean_depth, width_approx, photic_depth, river_clasif, temp, ph, oxy_dis, cond, oxy_sat, tot_sol_situ, tot_org_c, avail_p, mg, cal, na_s, tot_dis_sol, tot_sol, sus_sol, sol_sol, p04, n03, silicates, oil_fat, blue_met_act, carbonates, cal_hard, tot_hard, alk, bicarb
FROM main.event e
LEFT JOIN main.def_season s ON e.date_time_begin <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN 
 ( 
  SELECT * 
  FROM main.phy_chi_hidro_event pche 
  LEFT JOIN main.def_season s2 ON pche.date_time <@ s2.date_range
  LEFT JOIN main.phy_chi_hidro_aguas USING (cd_event_phy_chi)
  WHERE pche.cd_phy_chi_type=(SELECT cd_phy_chi_type FROM main.def_phy_chi_type WHERE phy_chi_type='water')
 ) ag USING (cd_pt_ref,cd_tempo)
WHERE cd_gp_biol='zopl'
GROUP BY ge.cd_gp_event,
  name_pt_ref||'_'||s.cd_tempo,
 basin, mean_depth, width_approx, photic_depth, river_clasif, temp, ph, oxy_dis, cond, oxy_sat, tot_sol_situ, tot_org_c, avail_p, mg, cal, na_s, tot_dis_sol, tot_sol, sus_sol, sol_sol, p04, n03, silicates, oil_fat, blue_met_act, carbonates, cal_hard, tot_hard, alk, bicarb
ORDER BY ge.cd_gp_event
;

CREATE OR REPLACE VIEW zopl_envir_sedim AS

SELECT ge.cd_gp_event,
  name_pt_ref||'_'||s.cd_tempo anh_tempo,
  sand_per, clay_per, silt_per, text_clas, org_c, avail_p, mg, cal, na_s, boron, fe, tot_n
FROM main.event e
LEFT JOIN main.def_season s ON e.date_time_begin <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN 
 (
  SELECT *
  FROM main.phy_chi_hidro_event pche
  LEFT JOIN main.def_season s2 ON pche.date_time <@ s2.date_range
  LEFT JOIN main.phy_chi_hidro_sedi USING (cd_event_phy_chi)
  WHERE pche.cd_phy_chi_type=(SELECT cd_phy_chi_type FROM main.def_phy_chi_type WHERE phy_chi_type='sediment')
 ) se USING  (cd_pt_ref,cd_tempo)
WHERE  cd_gp_biol='zopl'
GROUP BY ge.cd_gp_event,
  name_pt_ref||'_'||s.cd_tempo,
  sand_per, clay_per, silt_per, text_clas, org_c, avail_p, mg, cal, na_s, boron, fe, tot_n
ORDER BY ge.cd_gp_event
;
```

## 14.4 Listas

### 14.4.1 Lista completa

- occurrence number es el numero de registros que tienen la especie (si
  la tabla es limpia, corresponde al numero de evento que contienen el
  taxon)
- la zona está atribuida para cada ANH (se resolvierón los casos de
  eventos fuera de las zonas definidas y las ANH que estaban sobre 2
  zonas distintas

``` sql
, result='hide'}
CREATE OR REPLACE VIEW zopl_list_tot AS(
WITH a AS(
SELECT count(DISTINCT cd_event) nb_event
FROM main.event
LEFT JOIN main.gp_event USING (cd_gp_event)
WHERE cd_gp_biol='zopl'
)
SELECT 
   tor.name_tax "orden",
   tfam.name_tax "family",
   tgn.name_tax genus,
   COALESCE(verbatim_taxon, t.name_tax) taxon,
   dtr.tax_rank tax_rank,
   dtrm.tax_rank pseudo_rank,
   --ARRAY_AGG(DISTINCT protocol) protocols,
   ARRAY_AGG(DISTINCT cd_tempo) temporadas,
   ARRAY_AGG(DISTINCT name_pt_ref) anh,
   ARRAY_AGG(DISTINCT platform) zonas,
   ARRAY_AGG(DISTINCT tipo_cuerp_agua) tipos_cuerp_agua,
   count(*) "occurrence number",
   SUM(qt_double)/nb_event "mean abundance (ind/L)"
FROM main.registros r
CROSS JOIN a
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.def_season s ON COALESCE(r.date_time,e.date_time_begin) <@ s.date_range
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.taxo tgn ON find_higher_id(r.cd_tax,'GN')=tgn.cd_tax
LEFT JOIN main.taxo tfam ON find_higher_id(r.cd_tax,'FAM')=tfam.cd_tax
LEFT JOIN main.taxo tor ON find_higher_id(r.cd_tax,'OR')=tor.cd_tax
LEFT JOIN main.morfo_taxo mt USING(cd_morfo)
LEFT JOIN main.def_tax_rank dtr ON t.cd_rank=dtr.cd_rank
LEFT JOIN main.def_tax_rank dtrm ON mt.pseudo_rank=dtrm.cd_rank
LEFT JOIN habitat_gp_event_aquatic USING (cd_gp_event)
LEFT JOIN punto_ref_platform USING (cd_pt_ref,name_pt_ref)
WHERE
  ge.cd_gp_biol='zopl'
GROUP BY 
   tgn.name_tax, 
   tfam.name_tax, 
   tor.name_tax,
   COALESCE(verbatim_taxon, t.name_tax),
   dtr.tax_rank,
   dtrm.tax_rank,
   nb_event
ORDER BY SUM(qt_double)/nb_event DESC
)
;
```

## 14.5 Exportar: R y Excel

Extraer en R y exportar en excel

``` r
(listTable <- dbGetQuery(fracking_db, "SELECT table_name FROM information_schema.tables WHERE table_schema='public' AND table_name ~ '^zopl'")$table_name)
```

    ## [1] "zopl_envir_sedim"   "zopl_envir_water"   "zopl_info_sampling"
    ## [4] "zopl_matrix"

``` r
export_zopl <- lapply(listTable, dbReadTable, conn = fracking_db)
names(export_zopl) <- listTable
export_zopl <- c(export_zopl, lapply(export_zopl[grep("matrix", listTable)],
    function(x) {
        col_content <- c("abundance", "density")[c("abundance", "density") %in%
            colnames(x)]
        dbTab2mat(x, col_samplingUnits = "anh_tempo", col_species = "taxon",
            col_content = col_content, empty = 0)
    }))
names(export_zopl)[grepl("matrix", names(export_zopl)) & !sapply(lapply(export_zopl,
    class), function(x) "matrix" %in% x)] <- paste(names(export_zopl)[grepl("matrix",
    names(export_zopl)) & !sapply(lapply(export_zopl, class), function(x) "matrix" %in%
    x)], "_raw", sep = "")
export_zopl <- lapply(export_zopl, as.data.frame)
save_in_excel(file = "../../bpw_export//zopl_export.xlsx", lVar = export_zopl)
```

# 15 Cameras trampa

## 15.1 Mamiferos

### 15.1.1 Resolución taxonomica

``` sql
SELECT dtr.cd_rank, pseudo_rank,  count(*)
FROM main.registros r
LEFT JOIN main.event e USING (cd_event)
LEFT JOIN main.gp_event ge USING (cd_gp_event)
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.def_tax_rank dtr USING (cd_rank)
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.taxo tcl ON tcl.cd_tax=find_higher_id(r.cd_tax,'CL')
WHERE ge.cd_gp_biol='catr' AND tcl.name_tax='Mammalia'
GROUP BY tcl.name_tax,dtr.cd_rank,dtr.rank_level,pseudo_rank
ORDER BY rank_level DESC
```

<div class="knitsql-table">

</div>

### 15.1.2 Matrices

``` sql
CREATE OR REPLACE VIEW catr_mammal_matrix AS
WITH a AS(
SELECT 
   e.event_id,
   re.value_int gp_30_min,
--  description_replicate,
  CASE
   WHEN mt.pseudo_rank='SP' THEN tm.name_tax||' ('||name_morfo||')'
   ELSE t.name_tax
  END taxon,
  MAX(qt_int) abundance
FROM main.registros r
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin') 
LEFT JOIN main.registros_extra re ON r.cd_reg=re.cd_reg AND cd_var_registros_extra=(SELECT cd_var_registros_extra FROM main.def_var_registros_extra WHERE var_registros_extra='30 minutes period') 
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'SP')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.taxo tm ON mt.cd_tax=tm.cd_tax
LEFT JOIN main.taxo tcl ON find_higher_id(r.cd_tax,'CL')=tcl.cd_tax
WHERE 
  ge.cd_gp_biol='catr' 
  AND (t.name_tax IS NOT NULL OR mt.pseudo_rank='SP')--ensure we got the species or morphospecies
  AND num_anh IS NOT NULL
  AND tcl.name_tax='Mammalia'
  AND r.cd_tax NOT IN (SELECT cd_tax FROM main.taxo WHERE name_tax IN ('Bos taurus','Bubalus bubalis','Canis familiaris','Equus caballus','Equus mulus','Felis catus','Homo sapiens','Sus scrofa'))
GROUP BY 
  re.value_int,
  e.event_id,
  name_pt_ref,
  taxon
ORDER BY 
  e.event_id,
  re.value_int,
  MAX(qt_int) DESC
)
SELECT event_id,taxon,SUM(abundance) abundance
FROM a
GROUP BY event_id,taxon
ORDER BY event_id,SUM(abundance)
;
```

### 15.1.3 Información sobre los “sampling unit” de las matrices

``` sql
CREATE OR REPLACE VIEW catr_info_sampling_mammal AS
SELECT 
 cd_gp_event,
 event_id,
 landcov,
 landcov_spa,
 platform "zone",
 AVG(EXTRACT(DAY FROM date_time_end-date_time_begin)) total_period_days,
 EXTRACT(DAY FROM MAX(r.date_time)-MIN(date_time_begin)) period_until_last_pic_days,
 COUNT(DISTINCT 
  CASE
   WHEN mt.pseudo_rank='SP' THEN verbatim_taxon
   ELSE t.name_tax
  END 
  ) FILTER (WHERE (t.name_tax IS NOT NULL OR mt.pseudo_rank='SP') AND tcl.name_tax='Mammalia' AND r.cd_tax NOT IN (SELECT cd_tax FROM main.taxo WHERE name_tax IN ('Bos taurus','Bubalus bubalis','Canis familiaris','Equus caballus','Equus mulus','Felis catus','Homo sapiens','Sus scrofa'))) richness,
  SUM(qt_int) FILTER (WHERE tcl.name_tax='Mammalia') total_number_of_mammal_pics,
  ST_X(pt_geom) x_coord,
  ST_Y(pt_geom) y_coord
FROM main.registros r
FULL OUTER JOIN main.event e USING (cd_event) 
LEFT JOIN main.gp_event ge USING(cd_gp_event)
LEFT JOIN main.punto_referencia pr USING (cd_pt_ref)
LEFT JOIN landcov_gp_event_terrestrial hge USING (cd_gp_event)
LEFT JOIN punto_ref_platform prf USING (cd_pt_ref,name_pt_ref)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'SP')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.taxo tcl ON find_higher_id(r.cd_tax,'CL')=tcl.cd_tax
--LEFT JOIN gel ON gel.anh_tempo=name_pt_ref||'_'||cd_tempo
WHERE 
  ge.cd_gp_biol='catr' 
  AND num_anh IS NOT NULL
  AND tcl.name_tax='Mammalia'
GROUP BY 
  cd_gp_event,
  event_id,
  landcov,
  landcov_spa,
  date_time_begin,
  date_time_end,
  pt_geom,
  platform;
```

### 15.1.4 Listas

**TODO**

## 15.2 Reptiles

### 15.2.1 Resolución taxonomica

``` sql
SELECT dtr.cd_rank, pseudo_rank,  count(*)
FROM main.registros r
LEFT JOIN main.event e USING (cd_event)
LEFT JOIN main.gp_event ge USING (cd_gp_event)
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.def_tax_rank dtr USING (cd_rank)
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.taxo tcl ON tcl.cd_tax=find_higher_id(r.cd_tax,'CL')
WHERE ge.cd_gp_biol='catr' AND tcl.name_tax='Reptilia'
GROUP BY tcl.name_tax,dtr.cd_rank,dtr.rank_level,pseudo_rank
ORDER BY rank_level DESC
```

<div class="knitsql-table">

</div>

### 15.2.2 Matrices

``` sql
CREATE OR REPLACE VIEW catr_reptile_matrix AS
WITH a AS(
SELECT 
   e.event_id,
   re.value_int gp_30_min,
--  description_replicate,
  CASE
   WHEN mt.pseudo_rank='SP' THEN tm.name_tax||' ('||name_morfo||')'
   ELSE t.name_tax
  END taxon,
  MAX(qt_int) abundance
FROM main.registros r
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin') 
LEFT JOIN main.registros_extra re ON r.cd_reg=re.cd_reg AND cd_var_registros_extra=(SELECT cd_var_registros_extra FROM main.def_var_registros_extra WHERE var_registros_extra='30 minutes period') 
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'SP')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.taxo tm ON mt.cd_tax=tm.cd_tax
LEFT JOIN main.taxo tcl ON find_higher_id(r.cd_tax,'CL')=tcl.cd_tax
WHERE 
  ge.cd_gp_biol='catr' 
  AND (t.name_tax IS NOT NULL OR mt.pseudo_rank='SP')--ensure we got the species or morphospecies
  AND num_anh IS NOT NULL
  AND tcl.name_tax='Reptilia'
  AND r.cd_tax NOT IN (SELECT cd_tax FROM main.taxo WHERE name_tax IN ('Bos taurus','Bubalus bubalis','Canis familiaris','Equus caballus','Equus mulus','Felis catus','Homo sapiens','Sus scrofa'))
GROUP BY 
  re.value_int,
  e.event_id,
  name_pt_ref,
  taxon
ORDER BY 
  e.event_id,
  re.value_int,
  MAX(qt_int) DESC
)
SELECT event_id,taxon,SUM(abundance) abundance
FROM a
GROUP BY event_id,taxon
ORDER BY event_id,SUM(abundance)
;
```

### 15.2.3 Información sobre los “sampling unit” de las matrices

``` sql
CREATE OR REPLACE VIEW catr_info_sampling_reptile AS
SELECT 
 cd_gp_event,
 event_id,
 landcov,
 landcov_spa,
 platform "zone",
 AVG(EXTRACT(DAY FROM date_time_end-date_time_begin)) total_period_days,
 EXTRACT(DAY FROM MAX(r.date_time)-MIN(date_time_begin)) period_until_last_pic_days,
 COUNT(DISTINCT 
  CASE
   WHEN mt.pseudo_rank='SP' THEN verbatim_taxon
   ELSE t.name_tax
  END 
  ) FILTER (WHERE (t.name_tax IS NOT NULL OR mt.pseudo_rank='SP') AND tcl.name_tax='Reptilia' AND r.cd_tax NOT IN (SELECT cd_tax FROM main.taxo WHERE name_tax IN ('Bos taurus','Bubalus bubalis','Canis familiaris','Equus caballus','Equus mulus','Felis catus','Homo sapiens','Sus scrofa'))) richness,
  SUM(qt_int) FILTER (WHERE tcl.name_tax='Reptilia') total_number_of_reptile_pics,
  ST_X(pt_geom) x_coord,
  ST_Y(pt_geom) y_coord
FROM main.registros r
FULL OUTER JOIN main.event e USING (cd_event) 
LEFT JOIN main.gp_event ge USING(cd_gp_event)
LEFT JOIN main.punto_referencia pr USING (cd_pt_ref)
LEFT JOIN landcov_gp_event_terrestrial hge USING (cd_gp_event)
LEFT JOIN punto_ref_platform prf USING (cd_pt_ref,name_pt_ref)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'SP')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.taxo tcl ON find_higher_id(r.cd_tax,'CL')=tcl.cd_tax
--LEFT JOIN gel ON gel.anh_tempo=name_pt_ref||'_'||cd_tempo
WHERE 
  ge.cd_gp_biol='catr' 
  AND num_anh IS NOT NULL
  AND tcl.name_tax='Reptilia'
GROUP BY 
  cd_gp_event,
  event_id,
  landcov,
  landcov_spa,
  date_time_begin,
  date_time_end,
  pt_geom,
  platform;
```

### 15.2.4 Listas

**TODO**

## 15.3 Aves

### 15.3.1 Resolución taxonomica

``` sql
SELECT dtr.cd_rank, pseudo_rank,  count(*)
FROM main.registros r
LEFT JOIN main.event e USING (cd_event)
LEFT JOIN main.gp_event ge USING (cd_gp_event)
LEFT JOIN main.taxo t USING (cd_tax)
LEFT JOIN main.def_tax_rank dtr USING (cd_rank)
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.taxo tcl ON tcl.cd_tax=find_higher_id(r.cd_tax,'CL')
WHERE ge.cd_gp_biol='catr' AND tcl.name_tax='Aves'
GROUP BY tcl.name_tax,dtr.cd_rank,dtr.rank_level,pseudo_rank
ORDER BY rank_level DESC
```

<div class="knitsql-table">

</div>

### 15.3.2 Matrices

``` sql
CREATE OR REPLACE VIEW catr_bird_matrix AS
WITH a AS(
SELECT 
   e.event_id,
   re.value_int gp_30_min,
--  description_replicate,
  CASE
   WHEN mt.pseudo_rank='SP' THEN tm.name_tax||' ('||name_morfo||')'
   ELSE t.name_tax
  END taxon,
  MAX(qt_int) abundance
FROM main.registros r
LEFT JOIN main.event e USING (cd_event) 
LEFT JOIN main.event_extra ee ON e.cd_event=ee.cd_event AND cd_var_event_extra=(SELECT cd_var_event_extra FROM main.def_var_event_extra WHERE var_event_extra='date_begin') 
LEFT JOIN main.registros_extra re ON r.cd_reg=re.cd_reg AND cd_var_registros_extra=(SELECT cd_var_registros_extra FROM main.def_var_registros_extra WHERE var_registros_extra='30 minutes period') 
LEFT JOIN main.gp_event ge USING (cd_gp_event) 
LEFT JOIN main.punto_referencia USING (cd_pt_ref)
LEFT JOIN main.def_protocol USING (cd_protocol)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'SP')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.taxo tm ON mt.cd_tax=tm.cd_tax
LEFT JOIN main.taxo tcl ON find_higher_id(r.cd_tax,'CL')=tcl.cd_tax
WHERE 
  ge.cd_gp_biol='catr' 
  AND (t.name_tax IS NOT NULL OR mt.pseudo_rank='SP')--ensure we got the species or morphospecies
  AND num_anh IS NOT NULL
  AND tcl.name_tax='Aves'
  AND r.cd_tax NOT IN (SELECT cd_tax FROM main.taxo WHERE name_tax IN ('Bos taurus','Bubalus bubalis','Canis familiaris','Equus caballus','Equus mulus','Felis catus','Homo sapiens','Sus scrofa'))
GROUP BY 
  re.value_int,
  e.event_id,
  name_pt_ref,
  taxon
ORDER BY 
  e.event_id,
  re.value_int,
  MAX(qt_int) DESC
)
SELECT event_id,taxon,SUM(abundance) abundance
FROM a
GROUP BY event_id,taxon
ORDER BY event_id,SUM(abundance)
;
```

### 15.3.3 Información sobre los “sampling unit” de las matrices

``` sql
CREATE OR REPLACE VIEW catr_info_sampling_bird AS
SELECT 
 cd_gp_event,
 event_id,
 landcov,
 landcov_spa,
 platform "zone",
 AVG(EXTRACT(DAY FROM date_time_end-date_time_begin)) total_period_days,
 EXTRACT(DAY FROM MAX(r.date_time)-MIN(date_time_begin)) period_until_last_pic_days,
 COUNT(DISTINCT 
  CASE
   WHEN mt.pseudo_rank='SP' THEN verbatim_taxon
   ELSE t.name_tax
  END 
  ) FILTER (WHERE (t.name_tax IS NOT NULL OR mt.pseudo_rank='SP') AND tcl.name_tax='Aves' AND r.cd_tax NOT IN (SELECT cd_tax FROM main.taxo WHERE name_tax IN ('Bos taurus','Bubalus bubalis','Canis familiaris','Equus caballus','Equus mulus','Felis catus','Homo sapiens','Sus scrofa'))) richness,
  SUM(qt_int) FILTER (WHERE tcl.name_tax='Aves') total_number_of_bird_pics,
  ST_X(pt_geom) x_coord,
  ST_Y(pt_geom) y_coord
FROM main.registros r
FULL OUTER JOIN main.event e USING (cd_event) 
LEFT JOIN main.gp_event ge USING(cd_gp_event)
LEFT JOIN main.punto_referencia pr USING (cd_pt_ref)
LEFT JOIN landcov_gp_event_terrestrial hge USING (cd_gp_event)
LEFT JOIN punto_ref_platform prf USING (cd_pt_ref,name_pt_ref)
LEFT JOIN main.taxo t ON find_higher_id(r.cd_tax,'SP')=t.cd_tax
LEFT JOIN main.morfo_taxo mt USING (cd_morfo)
LEFT JOIN main.taxo tcl ON find_higher_id(r.cd_tax,'CL')=tcl.cd_tax
--LEFT JOIN gel ON gel.anh_tempo=name_pt_ref||'_'||cd_tempo
WHERE 
  ge.cd_gp_biol='catr' 
  AND num_anh IS NOT NULL
  AND tcl.name_tax='Aves'
GROUP BY 
  cd_gp_event,
  event_id,
  landcov,
  landcov_spa,
  date_time_begin,
  date_time_end,
  pt_geom,
  platform;
```

### 15.3.4 Listas

**TODO**

## 15.4 Exportar: R y Excel

Extraer en R y exportar en excel

``` r
(listTable <- dbGetQuery(fracking_db, "SELECT table_name FROM information_schema.tables WHERE table_schema='public' AND table_name ~ '^catr'")$table_name)
```

    ## [1] "catr_bird_matrix"           "catr_info_sampling_bird"   
    ## [3] "catr_info_sampling_mammal"  "catr_info_sampling_reptile"
    ## [5] "catr_mammal_matrix"         "catr_reptile_matrix"

``` r
export_catr <- lapply(listTable, dbReadTable, conn = fracking_db)
names(export_catr) <- listTable
export_catr[grep("matrix", listTable)] <- lapply(export_catr[grep("matrix",
    listTable)], function(x) {
    col_content <- c("abundance", "density")[c("abundance", "density") %in%
        colnames(x)]
    o_checklist <- !as.logical(length(col_content))
    dbTab2mat(x, col_samplingUnits = "event_id", col_species = "taxon",
        col_content = col_content, empty = 0, checklist = o_checklist)
})
export_catr <- lapply(export_catr, as.data.frame)
save_in_excel(file = "../../bpw_export//catr_export.xlsx", lVar = export_catr)
```

``` r
dbDisconnect(fracking_db)
```

    ## [1] TRUE
