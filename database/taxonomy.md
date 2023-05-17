Estructura y manejo de la taxonomía en la base de datos
================
Marius Bottin
2023-05-17

- [1 Probar la taxonomía en los datos
  DarwinCore](#1-probar-la-taxonomía-en-los-datos-darwincore)
  - [1.1 Buscar las variables de
    taxonomía](#11-buscar-las-variables-de-taxonomía)
  - [1.2 Correcciones de forma](#12-correcciones-de-forma)
  - [1.3 Creación tabla sin
    repetición](#13-creación-tabla-sin-repetición)
- [2 Buscar los errores de
  taxonomía](#2-buscar-los-errores-de-taxonomía)
  - [2.1 Inconsistencias en los nombres superiores de
    taxones](#21-inconsistencias-en-los-nombres-superiores-de-taxones)
  - [0.1 Inconsistencias en los niveles
    taxonomicos](#inconsistencias-en-los-niveles-taxonomicos)
  - [3.1 Integración en el sistema
    taxonomico](#31-integración-en-el-sistema-taxonomico)
    - [3.1.1 Reinos](#311-reinos)
    - [3.1.2 Filos](#312-filos)
    - [3.1.3 Clases](#313-clases)
    - [3.1.4 Ordenes](#314-ordenes)
    - [3.1.5 subordenes](#315-subordenes)
    - [3.1.6 Family](#316-family)
    - [3.1.7 Subfamilias](#317-subfamilias)
    - [3.1.8 Tribus](#318-tribus)
    - [3.1.9 Género](#319-género)
    - [3.1.10 Especies](#3110-especies)
      - [3.1.10.1 Añadir las especies que corresponden a los taxones
        inferiores](#31101-añadir-las-especies-que-corresponden-a-los-taxones-inferiores)
    - [3.1.11 Infraespecies](#3111-infraespecies)
- [4 Analyse of the taxonomic
  database](#4-analyse-of-the-taxonomic-database)
- [5 Dar codigos taxonomicos a cada fila de la tabla taxonomica
  total](#5-dar-codigos-taxonomicos-a-cada-fila-de-la-tabla-taxonomica-total)
- [6 Manejo de las morfo especies](#6-manejo-de-las-morfo-especies)
  - [6.1 Arboreos (botanica)](#61-arboreos-botanica)
  - [6.2 Epifitas vasculares](#62-epifitas-vasculares)
  - [6.3 Epifitas no vasculares](#63-epifitas-no-vasculares)
  - [6.4 Colémbolos](#64-colémbolos)
  - [6.5 Escarabajos](#65-escarabajos)
  - [6.6 Macroinvertebrados](#66-macroinvertebrados)
  - [6.7 Macrofitas](#67-macrofitas)
  - [6.8 Zooplancton](#68-zooplancton)
  - [6.9 Phytoplancton](#69-phytoplancton)
  - [6.10 Perifiton](#610-perifiton)
  - [6.11 Mamiferos](#611-mamiferos)
  - [6.12 Mariposas](#612-mariposas)
  - [6.13 Peces](#613-peces)
  - [6.14 Hormigas](#614-hormigas)
  - [6.15 Cameras trampa](#615-cameras-trampa)
  - [6.16 Herpetos (reptiles)](#616-herpetos-reptiles)
- [7 CREATING sql taxonomic
  function](#7-creating-sql-taxonomic-function)
  - [7.1 Ejemplos de utilización](#71-ejemplos-de-utilización)
  - [7.2 INDEX](#72-index)

------------------------------------------------------------------------

``` r
knitr::opts_chunk$set(tidy.opts = list(width.cutoff = 70), tidy = TRUE, connection="fracking_db")
require(openxlsx)
require(RPostgreSQL)
```

``` r
fracking_db <- dbConnect(PostgreSQL(), dbname = "fracking")
```

# 1 Probar la taxonomía en los datos DarwinCore

``` r
load("dataGrupos.RData")
```

## 1.1 Buscar las variables de taxonomía

``` r
names_gp_sheets <- lapply(dataGrupos, names)
DF_gp_sheets <- data.frame(gp_biol = rep(names(names_gp_sheets), sapply(names_gp_sheets,
    length)), sheet = Reduce(c, names_gp_sheets))
DF_gp_sheets$registro <- grepl("registro", DF_gp_sheets$sheet)
column_registros <- apply(DF_gp_sheets[DF_gp_sheets$registro, ], 1, function(x,
    l) {
    colnames(l[[x[1]]][[x[2]]])
}, l = dataGrupos)
# sort(table(Reduce(c,column_registros)),decreasing = T)

taxonomic_col <- c("kingdom", "phylum", "class", "order", "family", "genus",
    "scientificName", "specificEpithet", "taxonRank", "vernacularName",
    "scientificNameAuthorship", "identificationQualifier", "identificationRemarks",
    "higherClassification")
# lapply(column_registros,function(x,c)c[!c%in%x],c=taxonomic_col)
colnames(dataGrupos$Hidrobiologico$registros_fitoplancton)[colnames(dataGrupos$Hidrobiologico$registros_fitoplancton) ==
    "Family"] <- "family"
```

Extraer una tabla total de taxonomía

``` r
taxonomicTotal <- Reduce(rbind, apply(DF_gp_sheets[DF_gp_sheets$registro,
    ], 1, function(x, l, c) {
    tabReg <- l[[x[1]]][[x[2]]]
    MissingVar <- c[!c %in% colnames(tabReg)]
    if (length(MissingVar) > 0) {
        MissingTab <- as.data.frame(matrix(NA, nrow = nrow(tabReg), ncol = length(MissingVar)))
        colnames(MissingTab) <- MissingVar
        tabReg <- data.frame(tabReg, MissingTab, row.names = NULL)
    }
    data.frame(gp = x[1], sheet = x[2], tabReg[, c], row.names = NULL)
}, l = dataGrupos, c = taxonomic_col))
```

## 1.2 Correcciones de forma

**Reemplazar vacíos por NA**

``` r
taxonomicTotal[which(taxonomicTotal == "", arr.ind = T)] <- NA
```

**Suprimir los “trailing whitespace”**

``` r
for (i in 1:ncol(taxonomicTotal)) {
    taxonomicTotal[, i] <- trimws(taxonomicTotal[, i])
}
```

**Los nombres taxonomico deben empezar por una mayuscula (al menos en la
primera palabra)**

``` r
mayu1_col <- c("kingdom", "phylum", "class", "order", "family", "genus",
    "scientificName")
for (i in 1:length(mayu1_col)) {
    taxonomicTotal[, mayu1_col[i]] <- gsub("^([a-z])", "\\U\\1", taxonomicTotal[,
        mayu1_col[i]], perl = T)
}
```

## 1.3 Creación tabla sin repetición

``` r
dim(taxonomicTotal)
```

    ## [1] 129654     16

``` r
taxonomicTotal_un <- unique(taxonomicTotal)
dim(taxonomicTotal_un)
```

    ## [1] 5490   16

# 2 Buscar los errores de taxonomía

## 2.1 Inconsistencias en los nombres superiores de taxones

Lo que hacemos acá es, para cada caso de cada nivel taxonomico,
averiguar que el nivel superior sea siempre lo mismo:

``` r
toTest <- c("kingdom", "phylum", "class", "order", "family", "genus", "scientificName")
error_diffSup <- list()
for (i in 1:length(toTest)) {
    if (i > 1) {
        sup <- tapply(taxonomicTotal_un[, toTest[i - 1]], taxonomicTotal_un[toTest[i]],
            unique, simplify = F)
        if (i > 2) {
            sup <- tapply(dplyr::coalesce(taxonomicTotal_un[, toTest[i -
                1]], taxonomicTotal_un[, toTest[i - 2]]), taxonomicTotal_un[toTest[i]],
                unique, simplify = F)
        }
        nb_sup <- sapply(sup, length)
        error_diffSup[[toTest[i]]] <- sup[nb_sup > 1]
    }
}
```

Mostrar los resultados:

``` r
for (i in 1:length(error_diffSup)) {
    nivel = names(error_diffSup)[i]
    if (!length(error_diffSup[[i]])) {
        next
    }
    for (j in 1:length(error_diffSup[[i]])) {
        taxon_inf <- names(error_diffSup[[i]])[j]
        tabConcerned <- taxonomicTotal[taxonomicTotal[, nivel] == taxon_inf,
            ]
        cat("El taxon \"", taxon_inf, "\" (nivel:", nivel, ", presente en los grupos: ",
            paste(unique(na.omit(tabConcerned$gp)), collapse = ", "), ")\n se encuentra con los taxones superiores siguientes:",
            paste(error_diffSup[[i]][[j]], collapse = ", "), "\n\n")
    }
}
```

El taxon ” Sphyrotheca ” (nivel: scientificName , presente en los
grupos: Collembolos ) se encuentra con los taxones superiores
siguientes: Sphyrotheca , Sphyrotheca

<!--
&#10;
## Inconsistencias en las autorías
&#10;
```r
# TODO: buscar las errores con las autorías

## 0.1 Inconsistencias en los niveles taxonomicos

``` r
# Buscar los nombres que no parecen ser de su nivel taxonomico
```

–\>

    # [3 Integrating the taxonomy from the raw_dwc schema]{data-rmarkdown-temporarily-recorded-id="integrating-the-taxonomy-from-the-raw_dwc-schema"}

    Creating a complete temporary table:

    ```{=tex}
    \tiny

``` sql
DROP TABLE IF EXISTS raw_dwc.taxonomy_total;
CREATE TABLE raw_dwc.taxonomy_total AS(
--------------------------- ANFIBIOS -----------------------------------------------------------------
SELECT 
'anfibios_registros' AS table_orig, "row.names",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(kingdom,'^\s+',''),'\s+$',''),'\s+',' ')) AS kingdom,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(phylum,'^\s+',''),'\s+$',''),'\s+',' ')) AS phylum,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(class,'^\s+',''),'\s+$',''),'\s+',' ')) AS "class",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE("order",'^\s+',''),'\s+$',''),'\s+',' ')) AS "order",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(family,'^\s+',''),'\s+$',''),'\s+',' ')) AS family,
  NULL as subfamily,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(genus,'^\s+',''),'\s+$',''),'\s+',' ')) AS genus,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(specific_epithet,'^\s+',''),'\s+$',''),'\s+',' ') AS specific_epithet,
  NULL AS infraspecific_epithet,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name_authorship,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name_authorship,
  taxon_rank,
  NULL AS vernacular_name,
  NULL AS identification_qualifier,
  NULL AS identification_remarks
FROM raw_dwc.anfibios_registros
UNION ALL
------------------------------- REPTILES --------------------------------------------------------------
SELECT
  'reptiles_registros' AS table_orig, "row.names",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(kingdom,'^\s+',''),'\s+$',''),'\s+',' ')) AS kingdom,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(phylum,'^\s+',''),'\s+$',''),'\s+',' ')) AS phylum,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(class,'^\s+',''),'\s+$',''),'\s+',' ')) AS "class",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE("order",'^\s+',''),'\s+$',''),'\s+',' ')) AS "order",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(family,'^\s+',''),'\s+$',''),'\s+',' ')) AS family,
  NULL as subfamily,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(genus,'^\s+',''),'\s+$',''),'\s+',' ')) AS genus,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(specific_epithet,'^\s+',''),'\s+$',''),'\s+',' ') AS specific_epithet,
  NULL AS infraspecific_epithet,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name_authorship,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name_authorship,
  taxon_rank,
  NULL AS vernacular_name,
  NULL AS identification_qualifier,
  NULL AS identification_remarks
FROM raw_dwc.reptiles_registros
UNION ALL

------------------------------- ATROPELLAMIENTOS --------------------------------------------------------------
SELECT
  'atropellamientos_registros' AS table_orig, "row.names",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(kingdom,'^\s+',''),'\s+$',''),'\s+',' ')) AS kingdom,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(phylum,'^\s+',''),'\s+$',''),'\s+',' ')) AS phylum,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(class,'^\s+',''),'\s+$',''),'\s+',' ')) AS "class",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE("order",'^\s+',''),'\s+$',''),'\s+',' ')) AS "order",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(family,'^\s+',''),'\s+$',''),'\s+',' ')) AS family,
  NULL as subfamily,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(genus,'^\s+',''),'\s+$',''),'\s+',' ')) AS genus,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(specific_epithet,'^\s+',''),'\s+$',''),'\s+',' ') AS specific_epithet,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(infraspecific_epithet,'^\s+',''),'\s+$',''),'\s+',' ') AS infraspecific_epithet,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name_authorship,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name_authorship,
  taxon_rank,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(vernacular_name,'^\s+',''),'\s+$',''),'\s+',' ') AS vernacular_name,
  NULL AS identification_qualifier,
  NULL AS identification_remarks
FROM raw_dwc.atropellamientos_registros
UNION ALL
------------------------------- AVES --------------------------------------------------------------
SELECT
  'aves_registros' AS table_orig, "row.names",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(kingdom,'^\s+',''),'\s+$',''),'\s+',' ')) AS kingdom,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(phylum,'^\s+',''),'\s+$',''),'\s+',' ')) AS phylum,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(class,'^\s+',''),'\s+$',''),'\s+',' ')) AS "class",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE("order",'^\s+',''),'\s+$',''),'\s+',' ')) AS "order",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(family,'^\s+',''),'\s+$',''),'\s+',' ')) AS family,
  NULL as subfamily,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(genus,'^\s+',''),'\s+$',''),'\s+',' ')) AS genus,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(specific_epithet,'^\s+',''),'\s+$',''),'\s+',' ') AS specific_epithet,
  NULL AS infraspecific_epithet,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name_authorship,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name_authorship,
  taxon_rank,
  NULL AS vernacular_name,
  NULL AS identification_qualifier,
  NULL AS identification_remarks
FROM raw_dwc.aves_registros
UNION ALL 
-------------------------------- BOTANICA ----------------------------------------------------------
SELECT
  'botanica_registros_arborea' AS table_orig, "row.names",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(kingdom,'^\s+',''),'\s+$',''),'\s+',' ')) AS kingdom,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(phylum,'^\s+',''),'\s+$',''),'\s+',' ')) AS phylum,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(class,'^\s+',''),'\s+$',''),'\s+',' ')) AS "class",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE("order",'^\s+',''),'\s+$',''),'\s+',' ')) AS "order",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(family,'^\s+',''),'\s+$',''),'\s+',' ')) AS family,
  NULL as subfamily,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(genus,'^\s+',''),'\s+$',''),'\s+',' ')) AS genus,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(specific_epithet,'^\s+',''),'\s+$',''),'\s+',' ') AS specific_epithet,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(infraspecific_epithet,'^\s+',''),'\s+$',''),'\s+',' ') AS infraspecific_epithet,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name_authorship,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name_authorship,
  taxon_rank,
  NULL AS vernacular_name,
  identification_qualifier,
  identification_remarks
FROM raw_dwc.botanica_registros_arborea
UNION ALL
SELECT
  'botanica_registros_col' AS table_orig, "row.names",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(kingdom,'^\s+',''),'\s+$',''),'\s+',' ')) AS kingdom,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(phylum,'^\s+',''),'\s+$',''),'\s+',' ')) AS phylum,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(class,'^\s+',''),'\s+$',''),'\s+',' ')) AS "class",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE("order",'^\s+',''),'\s+$',''),'\s+',' ')) AS "order",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(family,'^\s+',''),'\s+$',''),'\s+',' ')) AS family,
  NULL as subfamily,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(genus,'^\s+',''),'\s+$',''),'\s+',' ')) AS genus,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(specific_epithet,'^\s+',''),'\s+$',''),'\s+',' ') AS specific_epithet,
  NULL AS infraspecific_epithet,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name_authorship,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name_authorship,
  taxon_rank,
  NULL AS vernacular_name,
  identification_qualifier,
  identification_remarks::text
FROM raw_dwc.botanica_registros_col
UNION ALL
SELECT
  'botanica_registros_epi_novas' AS table_orig, "row.names",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(kingdom,'^\s+',''),'\s+$',''),'\s+',' ')) AS kingdom,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(phylum,'^\s+',''),'\s+$',''),'\s+',' ')) AS phylum,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(class,'^\s+',''),'\s+$',''),'\s+',' ')) AS "class",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE("order",'^\s+',''),'\s+$',''),'\s+',' ')) AS "order",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(family,'^\s+',''),'\s+$',''),'\s+',' ')) AS family,
  NULL as subfamily,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(genus,'^\s+',''),'\s+$',''),'\s+',' ')) AS genus,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(specific_epithet,'^\s+',''),'\s+$',''),'\s+',' ') AS specific_epithet,
  NULL AS infraspecific_epithet,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name_authorship,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name_authorship,
  taxon_rank,
  NULL AS vernacular_name,
  identification_qualifier,
  identification_remarks
FROM raw_dwc.botanica_registros_epi_novas
UNION ALL
SELECT
  'botanica_registros_epi_vas' AS table_orig, "row.names",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(kingdom,'^\s+',''),'\s+$',''),'\s+',' ')) AS kingdom,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(phylum,'^\s+',''),'\s+$',''),'\s+',' ')) AS phylum,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(class,'^\s+',''),'\s+$',''),'\s+',' ')) AS "class",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE("order",'^\s+',''),'\s+$',''),'\s+',' ')) AS "order",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(family,'^\s+',''),'\s+$',''),'\s+',' ')) AS family,
  NULL as subfamily,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(genus,'^\s+',''),'\s+$',''),'\s+',' ')) AS genus,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(specific_epithet,'^\s+',''),'\s+$',''),'\s+',' ') AS specific_epithet,
  NULL AS infraspecific_epithet,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name_authorship,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name_authorship,
  taxon_rank,
  NULL AS vernacular_name,
  identification_qualifier,
  NULL AS identification_remarks
FROM raw_dwc.botanica_registros_epi_vas
UNION ALL
-------------------------------- COLEMBOLOS  ----------------------------------------------------------
SELECT
  'collembolos_registros' AS table_orig, "row.names",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(kingdom,'^\s+',''),'\s+$',''),'\s+',' ')) AS kingdom,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(phylum,'^\s+',''),'\s+$',''),'\s+',' ')) AS phylum,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(class,'^\s+',''),'\s+$',''),'\s+',' ')) AS "class",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE("order",'^\s+',''),'\s+$',''),'\s+',' ')) AS "order",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(family,'^\s+',''),'\s+$',''),'\s+',' ')) AS family,
  NULL as subfamily,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(genus,'^\s+',''),'\s+$',''),'\s+',' ')) AS genus,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(specific_epithet,'^\s+',''),'\s+$',''),'\s+',' ') AS specific_epithet,
  NULL AS infraspecific_epithet,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name_authorship,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name_authorship,
  taxon_rank,
  NULL AS vernacular_name,
  identification_qualifier,
  identification_remarks
FROM raw_dwc.collembolos_registros
UNION ALL
-------------------------------- ESCARABAJOS  ----------------------------------------------------------
SELECT
  'escarabajos_registros' AS table_orig, "row.names",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(kingdom,'^\s+',''),'\s+$',''),'\s+',' ')) AS kingdom,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(phylum,'^\s+',''),'\s+$',''),'\s+',' ')) AS phylum,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(class,'^\s+',''),'\s+$',''),'\s+',' ')) AS "class",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE("order",'^\s+',''),'\s+$',''),'\s+',' ')) AS "order",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(family,'^\s+',''),'\s+$',''),'\s+',' ')) AS family,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(SPLIT_PART(higher_classification,'|',6),'^\s+',''),'\s+$',''),'\s+',' ')) as subfamily,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(genus,'^\s+',''),'\s+$',''),'\s+',' ')) AS genus,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(specific_epithet,'^\s+',''),'\s+$',''),'\s+',' ') AS specific_epithet,
  NULL AS infraspecific_epithet,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name_authorship,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name_authorship,
  taxon_rank,
  NULL AS vernacular_name,
  identification_qualifier,
  identification_remarks
FROM raw_dwc.escarabajos_registros
UNION ALL
-------------------------------- HIDROBIOLOGICOS  ----------------------------------------------------------
SELECT
  'hidrobiologico_registros_fitoplancton' AS table_orig, "row.names",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(kingdom,'^\s+',''),'\s+$',''),'\s+',' ')) AS kingdom,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(phylum,'^\s+',''),'\s+$',''),'\s+',' ')) AS phylum,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(class,'^\s+',''),'\s+$',''),'\s+',' ')) AS "class",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE("order",'^\s+',''),'\s+$',''),'\s+',' ')) AS "order",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(family,'^\s+',''),'\s+$',''),'\s+',' ')) AS family,
  NULL as subfamily,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(genus,'^\s+',''),'\s+$',''),'\s+',' ')) AS genus,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(specific_epithet,'^\s+',''),'\s+$',''),'\s+',' ') AS specific_epithet,
  NULL AS infraspecific_epithet,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name_authorship,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name_authorship,
  taxon_rank,
  NULL AS vernacular_name,
  identification_qualifier,
  NULL AS identification_remarks
FROM raw_dwc.hidrobiologico_registros_fitoplancton
UNION ALL
SELECT
  'hidrobiologico_registros_macrofitas' AS table_orig, "row.names",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(kingdom,'^\s+',''),'\s+$',''),'\s+',' ')) AS kingdom,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(phylum,'^\s+',''),'\s+$',''),'\s+',' ')) AS phylum,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(class,'^\s+',''),'\s+$',''),'\s+',' ')) AS "class",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE("order",'^\s+',''),'\s+$',''),'\s+',' ')) AS "order",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(family,'^\s+',''),'\s+$',''),'\s+',' ')) AS family,
  NULL as subfamily,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(genus,'^\s+',''),'\s+$',''),'\s+',' ')) AS genus,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(specific_epithet,'^\s+',''),'\s+$',''),'\s+',' ') AS specific_epithet,
  NULL AS infraspecific_epithet,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name_authorship,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name_authorship,
  taxon_rank,
  NULL AS vernacular_name,
  identification_qualifier,
  NULL AS identification_remarks
FROM raw_dwc.hidrobiologico_registros_macrofitas
UNION ALL
SELECT
  'hidrobiologico_registros_macroinvertebrados' AS table_orig, "row.names",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(kingdom,'^\s+',''),'\s+$',''),'\s+',' ')) AS kingdom,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(phylum,'^\s+',''),'\s+$',''),'\s+',' ')) AS phylum,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(class,'^\s+',''),'\s+$',''),'\s+',' ')) AS "class",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE("order",'^\s+',''),'\s+$',''),'\s+',' ')) AS "order",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(family,'^\s+',''),'\s+$',''),'\s+',' ')) AS family,
  NULL as subfamily,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(genus,'^\s+',''),'\s+$',''),'\s+',' ')) AS genus,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(specific_epithet,'^\s+',''),'\s+$',''),'\s+',' ') AS specific_epithet,
  NULL AS infraspecific_epithet,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name_authorship,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name_authorship,
  taxon_rank,
  NULL AS vernacular_name,
  identification_qualifier,
  identification_remarks
FROM raw_dwc.hidrobiologico_registros_macroinvertebrados
UNION ALL
SELECT
  'hidrobiologico_registros_perifiton' AS table_orig, "row.names",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(kingdom,'^\s+',''),'\s+$',''),'\s+',' ')) AS kingdom,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(phylum,'^\s+',''),'\s+$',''),'\s+',' ')) AS phylum,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(class,'^\s+',''),'\s+$',''),'\s+',' ')) AS "class",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE("order",'^\s+',''),'\s+$',''),'\s+',' ')) AS "order",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(family,'^\s+',''),'\s+$',''),'\s+',' ')) AS family,
  NULL as subfamily,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(genus,'^\s+',''),'\s+$',''),'\s+',' ')) AS genus,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(specific_epithet,'^\s+',''),'\s+$',''),'\s+',' ') AS specific_epithet,
  NULL AS infraspecific_epithet,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name_authorship,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name_authorship,
  taxon_rank,
  NULL AS vernacular_name,
  identification_qualifier,
  NULL AS identification_remarks
FROM raw_dwc.hidrobiologico_registros_perifiton
UNION ALL
SELECT
  'hidrobiologico_registros_zooplancton' AS table_orig, "row.names",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(kingdom,'^\s+',''),'\s+$',''),'\s+',' ')) AS kingdom,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(phylum,'^\s+',''),'\s+$',''),'\s+',' ')) AS phylum,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(class,'^\s+',''),'\s+$',''),'\s+',' ')) AS "class",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE("order",'^\s+',''),'\s+$',''),'\s+',' ')) AS "order",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(family,'^\s+',''),'\s+$',''),'\s+',' ')) AS family,
  NULL as subfamily,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(genus,'^\s+',''),'\s+$',''),'\s+',' ')) AS genus,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(specific_epithet,'^\s+',''),'\s+$',''),'\s+',' ') AS specific_epithet,
  NULL AS infraspecific_epithet,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name_authorship,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name_authorship,
  taxon_rank,
  NULL AS vernacular_name,
  identification_qualifier,
  NULL AS identification_remarks
FROM raw_dwc.hidrobiologico_registros_zooplancton
UNION ALL
-------------------------------- HORMIGAS  ----------------------------------------------------------
SELECT
 'hormigas_registros' AS table_orig, "row.names",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(kingdom,'^\s+',''),'\s+$',''),'\s+',' ')) AS kingdom,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(phylum,'^\s+',''),'\s+$',''),'\s+',' ')) AS phylum,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(class,'^\s+',''),'\s+$',''),'\s+',' ')) AS "class",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE("order",'^\s+',''),'\s+$',''),'\s+',' ')) AS "order",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(family,'^\s+',''),'\s+$',''),'\s+',' ')) AS family,
  NULL as subfamily,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(genus,'^\s+',''),'\s+$',''),'\s+',' ')) AS genus,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(specific_epithet,'^\s+',''),'\s+$',''),'\s+',' ') AS specific_epithet,
  NULL AS infraspecific_epithet,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name_authorship,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name_authorship,
  taxon_rank,
  NULL AS vernacular_name,
  identification_qualifier,
  identification_remarks
FROM raw_dwc.hormigas_registros
UNION ALL
-------------------------------- MAMIFEROS  ----------------------------------------------------------
SELECT
  'mamiferos_registros' AS table_orig, "row.names",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(kingdom,'^\s+',''),'\s+$',''),'\s+',' ')) AS kingdom,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(phylum,'^\s+',''),'\s+$',''),'\s+',' ')) AS phylum,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(class,'^\s+',''),'\s+$',''),'\s+',' ')) AS "class",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE("order",'^\s+',''),'\s+$',''),'\s+',' ')) AS "order",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(family,'^\s+',''),'\s+$',''),'\s+',' ')) AS family,
  NULL as subfamily,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(genus,'^\s+',''),'\s+$',''),'\s+',' ')) AS genus,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(specific_epithet,'^\s+',''),'\s+$',''),'\s+',' ') AS specific_epithet,
  NULL AS infraspecific_epithet,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name_authorship,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name_authorship,
  taxon_rank,
  NULL AS vernacular_name,
  identification_qualifier,
  NULL AS identification_remarks
FROM raw_dwc.mamiferos_registros
UNION ALL
-------------------------------- MARIPOSAS  ----------------------------------------------------------
SELECT
  'mariposas_registros' AS table_orig, "row.names",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(kingdom,'^\s+',''),'\s+$',''),'\s+',' ')) AS kingdom,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(phylum,'^\s+',''),'\s+$',''),'\s+',' ')) AS phylum,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(class,'^\s+',''),'\s+$',''),'\s+',' ')) AS "class",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE("order",'^\s+',''),'\s+$',''),'\s+',' ')) AS "order",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(family,'^\s+',''),'\s+$',''),'\s+',' ')) AS family,
  subfamilia as subfamily,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(genus,'^\s+',''),'\s+$',''),'\s+',' ')) AS genus,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(specific_epithet,'^\s+',''),'\s+$',''),'\s+',' ') AS specific_epithet,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(infraspecific_epithet,'^\s+',''),'\s+$',''),'\s+',' ') AS infraspecific_epithet,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name_authorship,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name_authorship,
  taxon_rank,
  NULL AS vernacular_name,
  identification_qualifier,
  NULL AS identification_remarks
FROM raw_dwc.mariposas_registros
UNION ALL
-------------------------------- PECES  ----------------------------------------------------------
SELECT
  'peces_registros' AS table_orig, "row.names",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(kingdom,'^\s+',''),'\s+$',''),'\s+',' ')) AS kingdom,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(phylum,'^\s+',''),'\s+$',''),'\s+',' ')) AS phylum,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(class,'^\s+',''),'\s+$',''),'\s+',' ')) AS "class",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE("order",'^\s+',''),'\s+$',''),'\s+',' ')) AS "order",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(family,'^\s+',''),'\s+$',''),'\s+',' ')) AS family,
  NULL as subfamily,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(genus,'^\s+',''),'\s+$',''),'\s+',' ')) AS genus,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(specific_epithet,'^\s+',''),'\s+$',''),'\s+',' ') AS specific_epithet,
  NULL AS infraspecific_epithet,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name_authorship,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name_authorship,
  taxon_rank,
  NULL AS vernacular_name,
  identification_qualifier,
  NULL AS identification_remarks
FROM raw_dwc.peces_registros
UNION ALL
-------------------------------- ULTRASONIDOS  ----------------------------------------------------------
SELECT
  'mamiferos_us_registros' AS table_orig, "row.names",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(kingdom,'^\s+',''),'\s+$',''),'\s+',' ')) AS kingdom,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(phylum,'^\s+',''),'\s+$',''),'\s+',' ')) AS phylum,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(class,'^\s+',''),'\s+$',''),'\s+',' ')) AS "class",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE("order",'^\s+',''),'\s+$',''),'\s+',' ')) AS "order",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(family,'^\s+',''),'\s+$',''),'\s+',' ')) AS family,
  NULL as subfamily,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(genus,'^\s+',''),'\s+$',''),'\s+',' ')) AS genus,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(specific_epithet,'^\s+',''),'\s+$',''),'\s+',' ') AS specific_epithet,
  NULL AS infraspecific_epithet,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name_authorship,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name_authorship,
  taxon_rank,
  NULL AS vernacular_name,
  identification_qualifier,
  NULL AS identification_remarks
FROM raw_dwc.mamiferos_us_registros
UNION ALL
-------------------------------- CAMERAS TRAMPAS -------------------------------------------------------
SELECT
  'cameras_trampa_registros' AS table_orig, "row.names",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(kingdom,'^\s+',''),'\s+$',''),'\s+',' ')) AS kingdom,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(phylum,'^\s+',''),'\s+$',''),'\s+',' ')) AS phylum,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(class,'^\s+',''),'\s+$',''),'\s+',' ')) AS "class",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE("order",'^\s+',''),'\s+$',''),'\s+',' ')) AS "order",
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(family,'^\s+',''),'\s+$',''),'\s+',' ')) AS family,
  NULL as subfamily,
  INITCAP(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(genus,'^\s+',''),'\s+$',''),'\s+',' ')) AS genus,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(specific_epithet,'^\s+',''),'\s+$',''),'\s+',' ') AS specific_epithet,
  NULL AS infraspecific_epithet,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(scientific_name_authorship,'^\s+',''),'\s+$',''),'\s+',' ') AS scientific_name_authorship,
  taxon_rank,
  NULL AS vernacular_name,
  identification_qualifier::text,
  NULL AS identification_remarks
FROM raw_dwc.cameras_trampa_registros

)
;
```

Correcciones basicas sobre la tabla de taxonomía total:

``` sql
-- suppressing trailing space in taxon_rank
UPDATE raw_dwc.taxonomy_total
SET taxon_rank=REGEXP_REPLACE(taxon_rank,'\s+$','')
WHERE taxon_rank ~ '\s+$'
RETURNING taxon_rank;
```

<div class="knitsql-table">

| taxon_rank |
|:-----------|
| Orden      |
| Especie    |
| Especie    |
| Especie    |
| Especie    |
| Especie    |
| Especie    |
| Especie    |
| Especie    |
| Especie    |

Displaying records 1 - 10

</div>

Existen espacios raros en scientific_name

``` sql
UPDATE raw_dwc.taxonomy_total
SET scientific_name=REGEXP_REPLACE(scientific_name,' ',' ')
WHERE scientific_name ~ ' '
RETURNING scientific_name
```

``` sql
UPDATE raw_dwc.taxonomy_total
SET genus=REGEXP_REPLACE(genus,'[^a-z]+$','')
WHERE genus ~ '[^a-z]+$'
RETURNING genus;
```

Problema de especies que tienen solo el genero en scientific_name:

``` sql
SELECT * FROM raw_dwc.taxonomy_total WHERE scientific_name ~ '^[A-Z][a-z]+$' AND taxon_rank ~ '^[Ee]specie';
```

<div class="knitsql-table">

|                                                                                                                                                                                                                                     |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| table_orig row.names kingdom phylum class order family subfamily genus specific_epithet infraspecific_epithet scientific_name scientific_name_authorship taxon_rank vernacular_name identification_qualifier identification_remarks |

------------------------------------------------------------------------

: 0 records

</div>

``` sql
UPDATE raw_dwc.taxonomy_total
SET scientific_name= genus || ' ' ||specific_epithet
WHERE scientific_name ~ '^[A-Z][a-z]+$' AND taxon_rank ~ '^[Ee]specie'
RETURNING genus || specific_epithet;
```

Checking on especies:

``` sql
SELECT table_orig, "row.names", genus, specific_epithet, infraspecific_epithet, scientific_name, taxon_rank 
FROM raw_dwc.taxonomy_total
WHERE taxon_rank ~ '^[Ee]specie' AND (genus || ' ' || specific_epithet) != scientific_name
```

<div class="knitsql-table">

| table_orig          | row.names | genus      | specific_epithet | infraspecific_epithet | scientific_name      | taxon_rank |
|:--------------------|:----------|:-----------|:-----------------|:----------------------|:---------------------|:-----------|
| aves_registros      | 10223     | Empidonax  | traillii         | NA                    | Empidonax traillii   | Especie    |
| mamiferos_registros | 1586      | Lophostoma | silvicolum       | NA                    | Lophostoma silvicola | Especie    |
| mamiferos_registros | 2061      | Lophostoma | silvicolum       | NA                    | Lophostoma silvicola | Especie    |
| mariposas_registros | 284       | Phoebis    | trite            | trite                 | Phoebis trite trite  | Especie    |

4 records

</div>

``` sql
SELECT table_orig, "row.names", genus, specific_epithet, infraspecific_epithet, scientific_name, taxon_rank 
FROM raw_dwc.taxonomy_total
WHERE taxon_rank ~ '^[Ee]specie' AND scientific_name !~ '^[A-Z][a-z]+ [a-z-]+$'
```

<div class="knitsql-table">

| table_orig          | row.names | genus   | specific_epithet | infraspecific_epithet | scientific_name     | taxon_rank |
|:--------------------|:----------|:--------|:-----------------|:----------------------|:--------------------|:-----------|
| mariposas_registros | 284       | Phoebis | trite            | trite                 | Phoebis trite trite | Especie    |

1 records

</div>

Averiguando los rangos inferiores a especie:

``` sql
SELECT genus, specific_epithet, infraspecific_epithet, scientific_name, taxon_rank, ARRAY_AGG(DISTINCT table_orig) 
FROM raw_dwc.taxonomy_total t 
LEFT JOIN main.def_tax_rank d 
  ON 
    LOWER(t.taxon_rank)=d.tax_rank_spa 
    OR
    LOWER(t.taxon_rank)=d.tax_rank 
WHERE d.rank_level<10
GROUP BY genus, specific_epithet, infraspecific_epithet, scientific_name, taxon_rank, d.rank_level ORDER BY d.rank_level;
```

<div class="knitsql-table">

| genus           | specific_epithet | infraspecific_epithet | scientific_name                     | taxon_rank | array_agg                    |
|:----------------|:-----------------|:----------------------|:------------------------------------|:-----------|:-----------------------------|
| Abarema         | jupunba          | trapezifolia          | Abarema jupunba trapezifolia        | Variedad   | {botanica_registros_arborea} |
| Bactris         | gasipaes         | chichagui             | Bactris gasipaes chichagui          | Variedad   | {botanica_registros_arborea} |
| Adelpha         | barnesia         | leucas                | Adelpha barnesia leucas             | Subespecie | {mariposas_registros}        |
| Adelpha         | cytherea         | daguana               | Adelpha cytherea daguana            | Subespecie | {mariposas_registros}        |
| Adelpha         | iphiclus         | iphiclus              | Adelpha iphiclus iphiclus           | Subespecie | {mariposas_registros}        |
| Adelpha         | melona           | deborah               | Adelpha melona deborah              | Subespecie | {mariposas_registros}        |
| Adelpha         | phylaca          | pseudaethalia         | Adelpha phylaca pseudaethalia       | Subespecie | {mariposas_registros}        |
| Adelpha         | salmoneus        | emilia                | Adelpha salmoneus emilia            | Subespecie | {mariposas_registros}        |
| Ancyluris       | jurgensenii      | atahualpa             | Ancyluris jurgensenii atahualpa     | Subespecie | {mariposas_registros}        |
| Archaeoprepona  | demophon         | muson                 | Archaeoprepona demophon muson       | Subespecie | {mariposas_registros}        |
| Archaeoprepona  | demophoon        | gulina                | Archaeoprepona demophoon gulina     | Subespecie | {mariposas_registros}        |
| Baeotis         | zonata           | zonata                | Baeotis zonata zonata               | Subespecie | {mariposas_registros}        |
| Caligo          | idomeneus        | idomenides            | Caligo idomeneus idomenides         | Subespecie | {mariposas_registros}        |
| Caligo          | illioneus        | oberon                | Caligo illioneus oberon             | Subespecie | {mariposas_registros}        |
| Caligo          | oedipus          | oedipus               | Caligo oedipus oedipus              | Subespecie | {mariposas_registros}        |
| Caligo          | telamonius       | menus                 | Caligo telamonius menus             | Subespecie | {mariposas_registros}        |
| Catoblepia      | berecynthia      | luxuriosus            | Catoblepia berecynthia luxuriosus   | Subespecie | {mariposas_registros}        |
| Catonephele     | numilia          | esite                 | Catonephele numilia esite           | Subespecie | {mariposas_registros}        |
| Chiothion       | asychis          | simon                 | Chiothion asychis simon             | Subespecie | {mariposas_registros}        |
| Consul          | fabius           | bogotanus             | Consul fabius bogotanus             | Subespecie | {mariposas_registros}        |
| Dryas           | iulia            | iulia                 | Dryas iulia iulia                   | Subespecie | {mariposas_registros}        |
| Emesis          | fatimella        | nobilata              | Emesis fatimella nobilata           | Subespecie | {mariposas_registros}        |
| Eresia          | eunice           | mechanitis            | Eresia eunice mechanitis            | Subespecie | {mariposas_registros}        |
| Eueides         | isabella         | arquata               | Eueides isabella arquata            | Subespecie | {mariposas_registros}        |
| Eueides         | lybia            | olympia               | Eueides lybia olympia               | Subespecie | {mariposas_registros}        |
| Eunica          | mygdonia         | mygdonia              | Eunica mygdonia mygdonia            | Subespecie | {mariposas_registros}        |
| Euptychia       | westwoodi        | westwoodi             | Euptychia westwoodi westwoodi       | Subespecie | {mariposas_registros}        |
| Eurema          | agave            | agave                 | Eurema agave agave                  | Subespecie | {mariposas_registros}        |
| Eurema          | arbela           | gratiosa              | Eurema arbela gratiosa              | Subespecie | {mariposas_registros}        |
| Eurema          | daira            | lydia                 | Eurema daira lydia                  | Subespecie | {mariposas_registros}        |
| Gallus          | gallus           | domesticus            | Gallus gallus domesticus            | Subespecie | {atropellamientos_registros} |
| Gorgythion      | begga            | pyralina              | Gorgythion begga pyralina           | Subespecie | {mariposas_registros}        |
| Hamadryas       | amphinome        | fumosa                | Hamadryas amphinome fumosa          | Subespecie | {mariposas_registros}        |
| Hamadryas       | februa           | ferentina             | Hamadryas februa ferentina          | Subespecie | {mariposas_registros}        |
| Hamadryas       | feronia          | farinulenta           | Hamadryas feronia farinulenta       | Subespecie | {mariposas_registros}        |
| Heliconius      | charithonia      | bassleri              | Heliconius charithonia bassleri     | Subespecie | {mariposas_registros}        |
| Heliconius      | erato            | hydara                | Heliconius erato hydara             | Subespecie | {mariposas_registros}        |
| Heliconius      | hecale           | melicerta             | Heliconius hecale melicerta         | Subespecie | {mariposas_registros}        |
| Heliconius      | ismenius         | boulleti              | Heliconius ismenius boulleti        | Subespecie | {mariposas_registros}        |
| Heliconius      | ismenius         | ismenius              | Heliconius ismenius ismenius        | Subespecie | {mariposas_registros}        |
| Heliconius      | sapho            | sapho                 | Heliconius sapho sapho              | Subespecie | {mariposas_registros}        |
| Heliconius      | sara             | magdalena             | Heliconius sara magdalena           | Subespecie | {mariposas_registros}        |
| Hemiargus       | hanno            | bogotana              | Hemiargus hanno bogotana            | Subespecie | {mariposas_registros}        |
| Heraclides      | anchisiades      | idaeus                | Heraclides anchisiades idaeus       | Subespecie | {mariposas_registros}        |
| Heraclides      | thoas            | nealces               | Heraclides thoas nealces            | Subespecie | {mariposas_registros}        |
| Historis        | odius            | dious                 | Historis odius dious                | Subespecie | {mariposas_registros}        |
| Itaballia       | demophile        | calydonia             | Itaballia demophile calydonia       | Subespecie | {mariposas_registros}        |
| Mechanitis      | polymnia         | veritabilis           | Mechanitis polymnia veritabilis     | Subespecie | {mariposas_registros}        |
| Memphis         | acidalia         | memphis               | Memphis acidalia memphis            | Subespecie | {mariposas_registros}        |
| Memphis         | moruus           | phila                 | Memphis moruus phila                | Subespecie | {mariposas_registros}        |
| Morpho          | helenor          | peleides              | Morpho helenor peleides             | Subespecie | {mariposas_registros}        |
| Mysoria         | barcastus        | venezuelae            | Mysoria barcastus venezuelae        | Subespecie | {mariposas_registros}        |
| Notheme         | erota            | diadema               | Notheme erota diadema               | Subespecie | {mariposas_registros}        |
| Nyctelius       | nyctelius        | nyctelius             | Nyctelius nyctelius nyctelius       | Subespecie | {mariposas_registros}        |
| Nymphidium      | caricae          | trinidadi             | Nymphidium caricae trinidadi        | Subespecie | {mariposas_registros}        |
| Opsiphanes      | cassina          | periphetes            | Opsiphanes cassina periphetes       | Subespecie | {mariposas_registros}        |
| Opsiphanes      | quiteria         | badius                | Opsiphanes quiteria badius          | Subespecie | {mariposas_registros}        |
| Ouleus          | fridericus       | fridericus            | Ouleus fridericus fridericus        | Subespecie | {mariposas_registros}        |
| Panoquina       | ocola            | ocola                 | Panoquina ocola ocola               | Subespecie | {mariposas_registros}        |
| Parides         | erithalion       | erithalion            | Parides erithalion erithalion       | Subespecie | {mariposas_registros}        |
| Parides         | sesostris        | tarquinius            | Parides sesostris tarquinius        | Subespecie | {mariposas_registros}        |
| Paryphthimoides | poltys           | numilia               | Paryphthimoides poltys numilia      | Subespecie | {mariposas_registros}        |
| Perrhybris      | pamela           | bogotana              | Perrhybris pamela bogotana          | Subespecie | {mariposas_registros}        |
| Pierella        | luna             | luna                  | Pierella luna luna                  | Subespecie | {mariposas_registros}        |
| Porphyrogenes   | calathana        | calathana             | Porphyrogenes calathana calathana   | Subespecie | {mariposas_registros}        |
| Prepona         | laertes          | amesia                | Prepona laertes amesia              | Subespecie | {mariposas_registros}        |
| Prepona         | laertes          | louisa                | Prepona laertes louisa              | Subespecie | {mariposas_registros}        |
| Pyrrhogyra      | crameri          | undine                | Pyrrhogyra crameri undine           | Subespecie | {mariposas_registros}        |
| Pyrrhogyra      | neaerea          | kheili                | Pyrrhogyra neaerea kheili           | Subespecie | {mariposas_registros}        |
| Pyrrhopyge      | phidias          | latifasciata          | Pyrrhopyge phidias latifasciata     | Subespecie | {mariposas_registros}        |
| Pyrrhopyge      | thericles        | pseudophidias         | Pyrrhopyge thericles pseudophidias  | Subespecie | {mariposas_registros}        |
| Quadrus         | contubernalis    | contubernalis         | Quadrus contubernalis contubernalis | Subespecie | {mariposas_registros}        |
| Selenophanes    | josephus         | excultus              | Selenophanes josephus excultus      | Subespecie | {mariposas_registros}        |
| Siproeta        | stelenes         | biplagiata            | Siproeta stelenes biplagiata        | Subespecie | {mariposas_registros}        |
| Stalachtis      | magdalena        | magdalena             | Stalachtis magdalena magdalena      | Subespecie | {mariposas_registros}        |
| Symmachia       | leena            | leena                 | Symmachia leena leena               | Subespecie | {mariposas_registros}        |
| Telegonus       | anaphus          | annetta               | Telegonus anaphus annetta           | Subespecie | {mariposas_registros}        |
| Telemiades      | antiope          | antiope               | Telemiades antiope antiope          | Subespecie | {mariposas_registros}        |
| Thracides       | cleanthes        | telmela               | Thracides cleanthes telmela         | Subespecie | {mariposas_registros}        |

79 records

</div>

``` sql
SELECT genus, specific_epithet, infraspecific_epithet, scientific_name, taxon_rank, ARRAY_AGG(DISTINCT table_orig) 
FROM raw_dwc.taxonomy_total t 
LEFT JOIN main.def_tax_rank d 
  ON 
    LOWER(t.taxon_rank)=d.tax_rank_spa 
    OR
    LOWER(t.taxon_rank)=d.tax_rank 
WHERE d.rank_level<10 AND scientific_name != genus || ' ' || specific_epithet || ' ' || infraspecific_epithet
GROUP BY genus, specific_epithet, infraspecific_epithet, scientific_name, taxon_rank, d.rank_level ORDER BY d.rank_level;
```

<div class="knitsql-table">

|                                                                                   |
|:----------------------------------------------------------------------------------|
| genus specific_epithet infraspecific_epithet scientific_name taxon_rank array_agg |

------------------------------------------------------------------------

: 0 records

</div>

PROBLEMAS DE FORMA

``` sql
SELECT genus, specific_epithet, infraspecific_epithet, scientific_name, taxon_rank, ARRAY_AGG(DISTINCT table_orig) 
FROM raw_dwc.taxonomy_total t 
LEFT JOIN main.def_tax_rank d 
  ON 
    LOWER(t.taxon_rank)=d.tax_rank_spa 
    OR
    LOWER(t.taxon_rank)=d.tax_rank 
WHERE 
  CASE
    WHEN d.cd_rank IN ('VAR','SUBSP') THEN scientific_name !~ '[A-Z][a-z-]+ [a-z-]+ [a-z-]+$'
    WHEN d.cd_rank = 'SP' THEN scientific_name !~ '[A-Z][a-z-]+ [a-z-]+$'
    WHEN d.cd_rank = 'FAM' THEN scientific_name !~ '[A-Z][a-z-]+ae$'
    ELSE scientific_name !~ '[A-Z][a-z-]+$'
  END
GROUP BY genus, specific_epithet, infraspecific_epithet, scientific_name, taxon_rank, d.rank_level ORDER BY d.rank_level;
```

<div class="knitsql-table">

| genus        | specific_epithet | infraspecific_epithet | scientific_name        | taxon_rank | array_agg             |
|:-------------|:-----------------|:----------------------|:-----------------------|:-----------|:----------------------|
| Phoebis      | trite            | trite                 | Phoebis trite trite    | Especie    | {mariposas_registros} |
| Carollia     | NA               | NA                    | Carollia perspicillata | Género     | {mamiferos_registros} |
| Pseudomyrmex | NA               | NA                    | pseudomyrmex           | Género     | {hormigas_registros}  |

3 records

</div>

Correcciones:

``` sql
UPDATE raw_dwc.taxonomy_total
SET scientific_name='Phacus tortus'
WHERE genus='Phacus' AND specific_epithet='tortus' AND taxon_rank ~ '^[Ee]specie'
RETURNING scientific_name;

UPDATE raw_dwc.taxonomy_total
SET taxon_rank='Subespecie'
WHERE scientific_name='Phoebis trite trite'
RETURNING scientific_name;

UPDATE raw_dwc.taxonomy_total
SET scientific_name=genus
WHERE scientific_name !~ '^[A-Z][a-z-]+$' AND taxon_rank = 'Género'
RETURNING scientific_name;
```

Con este comando, los rangos taxonomicos pueden estar incluidos en el
sistema de las tablas taxonomicas:

``` sql
SELECT d.cd_rank,count(*) FROM raw_dwc.taxonomy_total t LEFT JOIN main.def_tax_rank d ON LOWER(t.taxon_rank)=d.tax_rank_spa OR LOWER(t.taxon_rank)=d.tax_rank GROUP BY d.cd_rank ORDER BY d.rank_level;
```

<div class="knitsql-table">

| cd_rank |  count |
|:--------|-------:|
| VAR     |      5 |
| SUBSP   |   1366 |
| SP      | 104660 |
| GN      |  19636 |
| TR      |      1 |
| SFAM    |    590 |
| FAM     |   1337 |
| SOR     |      4 |
| OR      |    895 |
| CL      |    367 |

Displaying records 1 - 10

</div>

``` sql
WITH a AS(
SELECT table_orig, 'kingdom' AS tax_rank, kingdom AS name
FROM raw_dwc.taxonomy_total
UNION
SELECT table_orig, 'phylum' ,phylum
FROM raw_dwc.taxonomy_total
UNION
SELECT table_orig, 'class' ,class
FROM raw_dwc.taxonomy_total
UNION
SELECT table_orig, 'order' ,"order"
FROM raw_dwc.taxonomy_total
UNION
SELECT table_orig, 'family' ,family
FROM raw_dwc.taxonomy_total
UNION
SELECT table_orig, 'subfamily' ,subfamily
FROM raw_dwc.taxonomy_total
UNION
SELECT table_orig, 'genus' ,genus
FROM raw_dwc.taxonomy_total
)
SELECT name, ARRAY_AGG(DISTINCT tax_rank) ranks, ARRAY_AGG(DISTINCT table_orig)
FROM a
WHERE name IS NOT NULL
GROUP BY name
HAVING ARRAY_LENGTH(ARRAY_AGG(DISTINCT tax_rank),1)>1
```

<div class="knitsql-table">

| name             | ranks                | array_agg                                                                  |
|:-----------------|:---------------------|:---------------------------------------------------------------------------|
| Trebouxiophyceae | {class,family,order} | {hidrobiologico_registros_fitoplancton,hidrobiologico_registros_perifiton} |

1 records

</div>

Temporalmente, ya había suprimido estas filas:

``` sql
DELETE
FROM raw_dwc.taxonomy_total
WHERE
  class='Collembola' OR "order"='Collembola'
  OR
  class='Trebouxiophyceae' OR "order"='Trebouxiophyceae' OR family='Trebouxiophyceae'
RETURNING *
```

Las modificaciones que hay que hacer para Trebouxiophyceae es lo
siguiente:

``` sql
UPDATE raw_dwc.taxonomy_total
SET "order"='Trebouxiophyceae ordo incertae sedis'
WHERE "order"= 'Trebouxiophyceae'
```

``` sql
UPDATE raw_dwc.taxonomy_total
SET "family"='Trebouxiophyceae incertae sedis'
WHERE "family"= 'Trebouxiophyceae'
```

## 3.1 Integración en el sistema taxonomico

``` r
knitr::opts_chunk$set(max.print = 100)
```

La integración se hará en 3 etapas para cada nivel taxonomico:

1.  integración de los taxones de este rango por scientificName
2.  averiguar los problemas potenciales
3.  integración de los taxones de este rango por las columnas de las
    tablas taxonómicas

### 3.1.1 Reinos

``` sql
SELECT tt.scientific_name, tt.scientific_name_authorship,dtr.cd_rank,count(*)
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='KG'
GROUP BY tt.scientific_name, tt.scientific_name_authorship,dtr.cd_rank
ORDER BY tt.scientific_name, tt.scientific_name_authorship,dtr.cd_rank,count(*) DESC
```

<div class="knitsql-table">

| scientific_name | scientific_name_authorship | cd_rank | count |
|:----------------|:---------------------------|:--------|------:|
| Plantae         | NA                         | KG      |   258 |

1 records

</div>

``` sql
INSERT INTO main.taxo(name_tax, authorship,cd_rank)
SELECT DISTINCT tt.scientific_name, tt.scientific_name_authorship,dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='KG'
ORDER BY tt.scientific_name, tt.scientific_name_authorship,dtr.cd_rank
RETURNING cd_tax
```

``` sql
SELECT tt.kingdom, 'KG' AS cd_rank, count(*)
FROM raw_dwc.taxonomy_total tt
GROUP BY tt.kingdom
ORDER BY tt.kingdom, count(*) DESC
```

<div class="knitsql-table">

| kingdom    | cd_rank |  count |
|:-----------|:--------|-------:|
| Animalia   | KG      | 115643 |
| Chromista  | KG      |   2820 |
| Eubacteria | KG      |    442 |
| Fungi      | KG      |   2721 |
| Plantae    | KG      |   7446 |
| Protozoa   | KG      |    582 |

6 records

</div>

``` sql
INSERT INTO main.taxo(name_tax,cd_rank)
SELECT DISTINCT tt.kingdom, 'KG' AS cd_rank
FROM raw_dwc.taxonomy_total tt
WHERE tt.kingdom NOT IN (SELECT name_tax FROM main.taxo WHERE cd_rank='KG')
RETURNING cd_tax
```

### 3.1.2 Filos

``` sql
WITH a AS(
SELECT
  tt.kingdom,
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='PHY'
)
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*)
FROM a
LEFT JOIN main.taxo t ON a.kingdom=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
```

<div class="knitsql-table">

| scientific_name | scientific_name_authorship | cd_parent | cd_rank | count |
|:----------------|:---------------------------|----------:|:--------|------:|
| Ascomycota      | NA                         |         6 | PHY     |   495 |
| Bryophyta       | NA                         |         1 | PHY     |    10 |
| Nematoda        | Rudolphi, 1808             |         2 | PHY     |    30 |

3 records

</div>

``` sql
INSERT INTO main.taxo(name_tax,authorship,cd_parent,cd_rank)
WITH a AS(
SELECT
  tt.kingdom,
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='PHY'
)
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank
FROM a
LEFT JOIN main.taxo t ON a.kingdom=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
RETURNING cd_tax
```

``` sql
SELECT tt.kingdom, t.cd_tax AS cd_parent, tt.phylum, 'PHY' AS cd_rank, count(*)
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.taxo t ON tt.kingdom=t.name_tax
WHERE tt.phylum IS NOT NULL
GROUP BY tt.kingdom,tt.phylum, t.cd_tax
ORDER BY tt.phylum, count(*) DESC
```

<div class="knitsql-table">

| kingdom    | cd_parent | phylum          | cd_rank | count |
|:-----------|----------:|:----------------|:--------|------:|
| Protozoa   |         3 | Amoebozoa       | PHY     |   120 |
| Animalia   |         2 | Annelida        | PHY     |   115 |
| Animalia   |         2 | Arthropoda      | PHY     | 27321 |
| Fungi      |         6 | Ascomycota      | PHY     |  2719 |
| Chromista  |         5 | Bacillariophyta | PHY     |  2696 |
| Fungi      |         6 | Basidiomycota   | PHY     |     2 |
| Plantae    |         1 | Bryophyta       | PHY     |    63 |
| Plantae    |         1 | Charophyta      | PHY     |  1296 |
| Plantae    |         1 | Chlorophyta     | PHY     |   643 |
| Animalia   |         2 | Chordata        | PHY     | 87515 |
| Chromista  |         5 | Cryptophyta     | PHY     |    50 |
| Eubacteria |         4 | Cyanobacteria   | PHY     |   442 |
| Protozoa   |         3 | Euglenozoa      | PHY     |   462 |
| Plantae    |         1 | Lycopodiophyta  | PHY     |    17 |
| Plantae    |         1 | Marchantiophyta | PHY     |   295 |
| Chromista  |         5 | Miozoa          | PHY     |    26 |
| Animalia   |         2 | Mollusca        | PHY     |   270 |
| Animalia   |         2 | Nematoda        | PHY     |    30 |
| Chromista  |         5 | Ochrophyta      | PHY     |    48 |
| Animalia   |         2 | Platyhelminthes | PHY     |     4 |
| Plantae    |         1 | Pteridophyta    | PHY     |    77 |
| Plantae    |         1 | Rhodophyta      | PHY     |    30 |
| Animalia   |         2 | Rotifera        | PHY     |   388 |
| Plantae    |         1 | Tracheophyta    | PHY     |  4767 |

24 records

</div>

``` sql
INSERT INTO main.taxo(name_tax,cd_parent,cd_rank)
SELECT  tt.phylum, t.cd_tax AS cd_parent, 'PHY' AS cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.taxo t ON tt.kingdom=t.name_tax
WHERE tt.phylum IS NOT NULL AND tt.phylum NOT IN (SELECT name_tax FROM main.taxo WHERE cd_rank='PHY')
GROUP BY tt.kingdom,tt.phylum, t.cd_tax
ORDER BY tt.phylum, count(*) DESC
RETURNING cd_tax
```

### 3.1.3 Clases

Acá empezamos a ver problemas potenciales, con el ejemplo de
Chlorophyceae que está 2 veces en la tabla con autorías diferentes. Para
evitar esos problemas, voy a añadir una etapa que numerota los casos en
función del numero de filas totales que utilizan tal autoría, o otra,
por scientific name.

``` sql
WITH a AS(
SELECT
  tt.phylum,
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='CL'
)
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a.phylum=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
```

<div class="knitsql-table">

| scientific_name | scientific_name_authorship    | cd_parent | cd_rank | count | order_cases_in_name |
|:----------------|:------------------------------|----------:|:--------|------:|--------------------:|
| Aves            | Linnaeus, 1758                |        17 | CL      |     1 |                   1 |
| Chlorophyceae   | Wille 1884                    |        16 | CL      |     4 |                   1 |
| Euglenophyceae  | Schoenichen, 1925             |        20 | CL      |     3 |                   1 |
| Magnoliopsida   | NA                            |        30 | CL      |   191 |                   1 |
| Maxillopoda     | Dahl, 1956                    |        12 | CL      |   165 |                   1 |
| Reptilia        | Laurenti, 1768                |        17 | CL      |     1 |                   1 |
| Ulvophyceae     | K.R.Mattox & K.D.Stewart 1984 |        16 | CL      |     2 |                   1 |

7 records

</div>

Para ver solo los casos problematicos, podemos utilizar eso:

``` sql
WITH a AS(
SELECT
  tt.phylum,
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='CL'
), b AS(
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a.phylum=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
)
SELECT * 
FROM b
WHERE b.scientific_name IN (SELECT scientific_name FROM b WHERE order_cases_in_name=2)
```

<div class="knitsql-table">

|                                                                                        |
|----------------------------------------------------------------------------------------|
| scientific_name scientific_name_authorship cd_parent cd_rank count order_cases_in_name |

------------------------------------------------------------------------

: 0 records

</div>

Para obtener la tabla por insertar:

``` sql
WITH a AS(
SELECT
  tt.phylum,
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='CL'
), b AS(
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a.phylum=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
)
SELECT scientific_name,scientific_name_authorship,cd_parent,cd_rank
FROM b 
WHERE order_cases_in_name=1
```

<div class="knitsql-table">

| scientific_name | scientific_name_authorship    | cd_parent | cd_rank |
|:----------------|:------------------------------|----------:|:--------|
| Aves            | Linnaeus, 1758                |        17 | CL      |
| Chlorophyceae   | Wille 1884                    |        16 | CL      |
| Euglenophyceae  | Schoenichen, 1925             |        20 | CL      |
| Magnoliopsida   | NA                            |        30 | CL      |
| Maxillopoda     | Dahl, 1956                    |        12 | CL      |
| Reptilia        | Laurenti, 1768                |        17 | CL      |
| Ulvophyceae     | K.R.Mattox & K.D.Stewart 1984 |        16 | CL      |

7 records

</div>

Ahora la inserción:

``` sql
INSERT INTO main.taxo(name_tax,authorship,cd_parent,cd_rank)
WITH a AS(
SELECT
  tt.phylum,
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='CL'
), b AS(
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a.phylum=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
)
SELECT scientific_name,scientific_name_authorship,cd_parent,cd_rank
FROM b 
WHERE order_cases_in_name=1
RETURNING cd_tax
```

``` sql
SELECT tt.phylum, t.cd_tax AS cd_parent, tt.class, 'CL' AS cd_rank, count(*)
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.taxo t ON tt.phylum=t.name_tax
WHERE tt.class IS NOT NULL
GROUP BY tt.phylum,tt.class, t.cd_tax
ORDER BY tt.class, count(*) DESC
```

<div class="knitsql-table">

| phylum          | cd_parent | class               | cd_rank | count |
|:----------------|----------:|:--------------------|:--------|------:|
| Chordata        |        17 | Actinopterygii      | CL      |  1855 |
| Basidiomycota   |        14 | Agaricomycetes      | CL      |     2 |
| Chordata        |        17 | Amphibia            | CL      |  2228 |
| Ascomycota      |         7 | Arthoniomycetes     | CL      |   550 |
| Chordata        |        17 | Aves                | CL      | 35435 |
| Bacillariophyta |        13 | Bacillariophyceae   | CL      |  2637 |
| Mollusca        |        24 | Bivalvia            | CL      |    89 |
| Arthropoda      |        12 | Branchiopoda        | CL      |   146 |
| Bryophyta       |         8 | Bryopsida           | CL      |    53 |
| Chlorophyta     |        16 | Chlorophyceae       | CL      |   550 |
| Chordata        |        17 | Chondrichthyes      | CL      |     2 |
| Ochrophyta      |        25 | Chrysophyceae       | CL      |     1 |
| Annelida        |        11 | Clitellata          | CL      |   115 |
| Bacillariophyta |        13 | Coscinodiscophyceae | CL      |    59 |
| Cryptophyta     |        18 | Cryptophyceae       | CL      |    50 |
| Cyanobacteria   |        19 | Cyanophyceae        | CL      |   442 |
| Miozoa          |        23 | Dinophyceae         | CL      |    26 |
| Ascomycota      |         7 | Dothideomycetes     | CL      |    61 |
| Arthropoda      |        12 | Entognatha          | CL      |  5956 |
| Arthropoda      |        12 | Euchelicerata       | CL      |   129 |
| Euglenozoa      |        20 | Euglenophyceae      | CL      |   462 |
| Ascomycota      |         7 | Eurotiomycetes      | CL      |    83 |
| Ochrophyta      |        25 | Eustigmatophyceae   | CL      |    19 |
| Rhodophyta      |        28 | Florideophyceae     | CL      |    30 |
| Mollusca        |        24 | Gastropoda          | CL      |   181 |
| Arthropoda      |        12 | Insecta             | CL      | 20829 |
| Marchantiophyta |        22 | Jungermanniopsida   | CL      |   295 |
| Charophyta      |        15 | Klebsormidiophyceae | CL      |     4 |
| Ascomycota      |         7 | Lecanoromycetes     | CL      |  1530 |
| Tracheophyta    |        30 | Liliopsida          | CL      |   418 |
| Amoebozoa       |        10 | Lobosa              | CL      |   120 |
| Tracheophyta    |        30 | Magnoliopsida       | CL      |  4346 |
| Arthropoda      |        12 | Malacostraca        | CL      |    27 |
| Chordata        |        17 | Mammalia            | CL      | 45744 |
| Arthropoda      |        12 | Maxillopoda         | CL      |   205 |
| Rotifera        |        29 | Monogonta           | CL      |   388 |
| Arthropoda      |        12 | Ostracoda           | CL      |    29 |
| Tracheophyta    |        30 | Pinopsida           | CL      |     3 |
| Pteridophyta    |        27 | Polypodiopsida      | CL      |    52 |
| Pteridophyta    |        27 | Pteridopsida        | CL      |    25 |
| Chordata        |        17 | Reptilia            | CL      |  2251 |
| Lycopodiophyta  |        21 | Selaginellopsida    | CL      |    17 |
| Ochrophyta      |        25 | Synurophyceae       | CL      |    21 |
| Chlorophyta     |        16 | Trebouxiophyceae    | CL      |    71 |
| Platyhelminthes |        26 | Trepaxonemata       | CL      |     4 |
| Chlorophyta     |        16 | Ulvophyceae         | CL      |    22 |
| Ochrophyta      |        25 | Xanthophyceae       | CL      |     7 |
| Charophyta      |        15 | Zygnematophyceae    | CL      |  1292 |

48 records

</div>

``` sql
INSERT INTO main.taxo(name_tax,cd_parent,cd_rank)
SELECT  tt.class, t.cd_tax AS cd_parent, 'CL' AS cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.taxo t ON tt.phylum=t.name_tax
WHERE tt.class IS NOT NULL AND tt.class NOT IN (SELECT name_tax FROM main.taxo WHERE cd_rank='CL')
GROUP BY tt.phylum,tt.class, t.cd_tax
ORDER BY tt.class, count(*) DESC
RETURNING cd_tax
```

### 3.1.4 Ordenes

``` sql
WITH a AS(
SELECT
  tt.class,
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='OR'
)
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a.class=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
```

<div class="knitsql-table">

| scientific_name   | scientific_name_authorship         | cd_parent | cd_rank | count | order_cases_in_name |
|:------------------|:-----------------------------------|----------:|:--------|------:|--------------------:|
| Achnanthales      | P.C. Silva, 1962                   |        42 | OR      |     2 |                   1 |
| Chlamydomonadales | Pascher, 1915                      |        32 | OR      |    16 |                   1 |
| Chroococcales     | Schaffner, 1922                    |        51 | OR      |     1 |                   1 |
| Coleoptera        | Linnaeus, 1758                     |        60 | OR      |     4 |                   1 |
| Diptera           | Linnaeus, 1758                     |        60 | OR      |     4 |                   1 |
| Entomobryomorpha  | NA                                 |        54 | OR      |   290 |                   1 |
| Lepidoptera       | \-                                 |        60 | OR      |     2 |                   1 |
| Mesostigmata      | Reuter, 1909                       |        55 | OR      |     1 |                   1 |
| Naviculales       | Bessey, 1907                       |        42 | OR      |     2 |                   1 |
| Neelipleona       | NA                                 |        54 | OR      |     3 |                   1 |
| Neoophora         | Lang, 1884                         |        76 | OR      |     1 |                   1 |
| Odonata           | Fabricius, 1793                    |        60 | OR      |     1 |                   1 |
| Oribatida         | Dugès, 1834                        |        55 | OR      |     2 |                   1 |
| Oscillatoriales   | Schaffner 1922                     |        51 | OR      |     4 |                   1 |
| Poduromorpha      | NA                                 |        54 | OR      |   213 |                   1 |
| Rodentia          | Bowdich, 1821                      |        67 | OR      |     4 |                   1 |
| Sarcoptiformes    | Reuter, 1909                       |        55 | OR      |     6 |                   1 |
| Sphaeropleales    | Luerssen, 1877                     |        32 | OR      |     2 |                   1 |
| Squamata          | Merrem, 1820                       |        36 | OR      |     1 |                   1 |
| Symphypleona      | NA                                 |        54 | OR      |   213 |                   1 |
| Synechococcaceae  | Hoffmann, Komárek & Kastovsky 2005 |        51 | OR      |     1 |                   1 |
| Tricladida        | Lang, 1884                         |        76 | OR      |     3 |                   1 |
| Trombidiformes    | Zakhvatkin, 1952                   |        55 | OR      |   118 |                   1 |
| NA                | NA                                 |        40 | OR      |     1 |                   1 |

24 records

</div>

Casos problematicos:

``` sql
WITH a AS(
SELECT
  tt.class,
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='OR'
), b AS(
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a.class=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
)
SELECT * 
FROM b
WHERE b.scientific_name IN (SELECT scientific_name FROM b WHERE order_cases_in_name=2)
```

<div class="knitsql-table">

|                                                                                        |
|----------------------------------------------------------------------------------------|
| scientific_name scientific_name_authorship cd_parent cd_rank count order_cases_in_name |

------------------------------------------------------------------------

: 0 records

</div>

Por insertar:

``` sql
WITH a AS(
SELECT
  tt.class,
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='OR'
), b AS(
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a.class=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
)
SELECT scientific_name,scientific_name_authorship,cd_parent,cd_rank
FROM b 
WHERE order_cases_in_name=1
```

<div class="knitsql-table">

| scientific_name   | scientific_name_authorship         | cd_parent | cd_rank |
|:------------------|:-----------------------------------|----------:|:--------|
| Achnanthales      | P.C. Silva, 1962                   |        42 | OR      |
| Chlamydomonadales | Pascher, 1915                      |        32 | OR      |
| Chroococcales     | Schaffner, 1922                    |        51 | OR      |
| Coleoptera        | Linnaeus, 1758                     |        60 | OR      |
| Diptera           | Linnaeus, 1758                     |        60 | OR      |
| Entomobryomorpha  | NA                                 |        54 | OR      |
| Lepidoptera       | \-                                 |        60 | OR      |
| Mesostigmata      | Reuter, 1909                       |        55 | OR      |
| Naviculales       | Bessey, 1907                       |        42 | OR      |
| Neelipleona       | NA                                 |        54 | OR      |
| Neoophora         | Lang, 1884                         |        76 | OR      |
| Odonata           | Fabricius, 1793                    |        60 | OR      |
| Oribatida         | Dugès, 1834                        |        55 | OR      |
| Oscillatoriales   | Schaffner 1922                     |        51 | OR      |
| Poduromorpha      | NA                                 |        54 | OR      |
| Rodentia          | Bowdich, 1821                      |        67 | OR      |
| Sarcoptiformes    | Reuter, 1909                       |        55 | OR      |
| Sphaeropleales    | Luerssen, 1877                     |        32 | OR      |
| Squamata          | Merrem, 1820                       |        36 | OR      |
| Symphypleona      | NA                                 |        54 | OR      |
| Synechococcaceae  | Hoffmann, Komárek & Kastovsky 2005 |        51 | OR      |
| Tricladida        | Lang, 1884                         |        76 | OR      |
| Trombidiformes    | Zakhvatkin, 1952                   |        55 | OR      |
| NA                | NA                                 |        40 | OR      |

24 records

</div>

Ahora la inserción:

``` sql
INSERT INTO main.taxo(name_tax,authorship,cd_parent,cd_rank)
WITH a AS(
SELECT
  tt.class,
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='OR'
), b AS(
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a.class=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
)
SELECT scientific_name,scientific_name_authorship,cd_parent,cd_rank
FROM b 
WHERE order_cases_in_name=1 AND scientific_name IS NOT NULL
RETURNING cd_tax
```

Desde la columna

``` sql
SELECT tt.class, t.cd_tax AS cd_parent, tt."order", 'OR' AS cd_rank, count(*)
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.taxo t ON tt.class=t.name_tax
WHERE tt."order" IS NOT NULL
GROUP BY tt.class,tt."order", t.cd_tax
ORDER BY tt."order", count(*) DESC
```

<div class="knitsql-table">

| class               | cd_parent | order             | cd_rank | count |
|:--------------------|----------:|:------------------|:--------|------:|
| Aves                |        31 | Accipitriformes   | OR      |   383 |
| Bacillariophyceae   |        42 | Achnanthales      | OR      |   223 |
| Florideophyceae     |        58 | Acrochaetiales    | OR      |    24 |
| Agaricomycetes      |        39 | Agaricales        | OR      |     2 |
| Liliopsida          |        64 | Alismatales       | OR      |   143 |
| Actinopterygii      |        38 | Anabantiformes    | OR      |    26 |
| Aves                |        31 | Anseriformes      | OR      |   169 |
| Amphibia            |        40 | Anura             | OR      |  2190 |
| Magnoliopsida       |        34 | Apiales           | OR      |    45 |
| Aves                |        31 | Apodiformes       | OR      |   161 |
| Lobosa              |        65 | Arcellinida       | OR      |   120 |
| Gastropoda          |        59 | Architaenioglossa | OR      |    27 |
| Liliopsida          |        64 | Arecales          | OR      |    66 |
| Arthoniomycetes     |        41 | Arthoniales       | OR      |   550 |
| Mammalia            |        67 | Artiodactyla      | OR      |   504 |
| Magnoliopsida       |        34 | Asterales         | OR      |     4 |
| Coscinodiscophyceae |        49 | Aulacoseirales    | OR      |    50 |
| Bacillariophyceae   |        42 | Bacillariales     | OR      |   259 |
| Florideophyceae     |        58 | Balliales         | OR      |     6 |
| Gastropoda          |        59 | Basommatophora    | OR      |   128 |
| Actinopterygii      |        38 | Blenniiformes     | OR      |   350 |
| Magnoliopsida       |        34 | Boraginales       | OR      |    43 |
| Magnoliopsida       |        34 | Brassicales       | OR      |     4 |
| Maxillopoda         |        35 | Calanoida         | OR      |    17 |
| Lecanoromycetes     |        63 | Caliciales        | OR      |     9 |
| Aves                |        31 | Caprimulgiformes  | OR      |   721 |
| Mammalia            |        67 | Carnivora         | OR      |  2417 |
| Magnoliopsida       |        34 | Caryophyllales    | OR      |    36 |
| Aves                |        31 | Cathartiformes    | OR      |   257 |
| Amphibia            |        40 | Caudata           | OR      |    38 |
| Magnoliopsida       |        34 | Celastrales       | OR      |     4 |
| Mammalia            |        67 | Cetartiodactyla   | OR      | 18851 |
| Chlorophyceae       |        32 | Chaetophorales    | OR      |    21 |
| Actinopterygii      |        38 | Characiformes     | OR      |   944 |
| Aves                |        31 | Charadriiformes   | OR      |   241 |
| Mammalia            |        67 | Chiroptera        | OR      |  4553 |
| Chlorophyceae       |        32 | Chlamydomonadales | OR      |   121 |
| Trebouxiophyceae    |        75 | Chlorellales      | OR      |    39 |
| Chrysophyceae       |        47 | Chromulinales     | OR      |     1 |
| Cyanophyceae        |        51 | Chroococcales     | OR      |    20 |
| Aves                |        31 | Ciconiiformes     | OR      |     3 |
| Mammalia            |        67 | Cingulata         | OR      |   652 |
| Ulvophyceae         |        37 | Cladophorales     | OR      |     7 |
| Insecta             |        60 | Coleoptera        | OR      |  4949 |
| Aves                |        31 | Columbiformes     | OR      |  7530 |
| Liliopsida          |        64 | Commelinales      | OR      |    43 |
| Aves                |        31 | Coraciiformes     | OR      |  1442 |
| Reptilia            |        36 | Crocodylia        | OR      |    93 |
| Cryptophyceae       |        50 | Cryptomonadales   | OR      |    44 |
| Branchiopoda        |        44 | Ctenopoda         | OR      |     2 |
| Aves                |        31 | Cuculiformes      | OR      |  1937 |
| Maxillopoda         |        35 | Cyclopoida        | OR      |    23 |
| Bacillariophyceae   |        42 | Cymbellales       | OR      |   362 |
| Malacostraca        |        66 | Decapoda          | OR      |    27 |
| Zygnematophyceae    |        78 | Desmidiales       | OR      |  1138 |
| Mammalia            |        67 | Didelphimorphia   | OR      |   934 |
| Magnoliopsida       |        34 | Dilleniales       | OR      |     3 |
| Branchiopoda        |        44 | Diplostraca       | OR      |   144 |
| Insecta             |        60 | Diptera           | OR      |  1049 |
| Entognatha          |        54 | Entomobryomorpha  | OR      |  3547 |
| Insecta             |        60 | Ephemeroptera     | OR      |   286 |
| Magnoliopsida       |        34 | Ericales          | OR      |   165 |
| Euglenophyceae      |        33 | Euglenida         | OR      |   459 |
| Bacillariophyceae   |        42 | Eunotiales        | OR      |   645 |
| Magnoliopsida       |        34 | Fabales           | OR      |   332 |
| Aves                |        31 | Falconiformes     | OR      |   645 |
| Monogonta           |        68 | Flosculariacea    | OR      |    30 |
| Bacillariophyceae   |        42 | Fragilariales     | OR      |     8 |
| Aves                |        31 | Galbuliformes     | OR      |    54 |
| Aves                |        31 | Galliformes       | OR      |  4151 |
| Magnoliopsida       |        34 | Gentianales       | OR      |   334 |
| Eustigmatophyceae   |        57 | Goniochloridales  | OR      |    19 |
| Dinophyceae         |        52 | Gonyaulacales     | OR      |     1 |
| Aves                |        31 | Gruiformes        | OR      |  6569 |
| Dinophyceae         |        52 | Gymnodiniales     | OR      |     5 |
| Actinopterygii      |        38 | Gymnotiformes     | OR      |   162 |
| Insecta             |        60 | Hemiptera         | OR      |   565 |
| Clitellata          |        48 | Hirudinida        | OR      |    51 |
| Bryopsida           |        45 | Hookeriales       | OR      |     1 |
| Polypodiopsida      |        71 | Hymenophyllales   | OR      |     1 |
| Insecta             |        60 | Hymenoptera       | OR      |  9245 |
| Bryopsida           |        45 | Hypnales          | OR      |    13 |
| Jungermanniopsida   |        61 | Jungermanniales   | OR      |     3 |
| Klebsormidiophyceae |        62 | Klebsormidiales   | OR      |     4 |
| Magnoliopsida       |        34 | Lamiales          | OR      |   119 |
| Magnoliopsida       |        34 | Laurales          | OR      |   215 |
| Lecanoromycetes     |        63 | Lecanorales       | OR      |   245 |
| Insecta             |        60 | Lepidoptera       | OR      |  3812 |
| Bacillariophyceae   |        42 | Licmophorales     | OR      |     1 |
| Liliopsida          |        64 | Liliales          | OR      |     1 |
| Clitellata          |        48 | Lumbriculida      | OR      |     6 |
| Magnoliopsida       |        34 | Magnoliales       | OR      |   488 |
| Magnoliopsida       |        34 | Malpighiales      | OR      |   861 |
| Magnoliopsida       |        34 | Malvales          | OR      |    89 |
| Bacillariophyceae   |        42 | Mastogloiales     | OR      |     4 |
| Insecta             |        60 | Megaloptera       | OR      |     2 |
| Coscinodiscophyceae |        49 | Melosirales       | OR      |     6 |
| Euchelicerata       |        55 | Mesostigmata      | OR      |     1 |
| Magnoliopsida       |        34 | Metteniusales     | OR      |     7 |
| Jungermanniopsida   |        61 | Metzgeriales      | OR      |     1 |

Displaying records 1 - 100

</div>

``` sql
INSERT INTO main.taxo(name_tax,cd_parent,cd_rank)
SELECT  tt."order", t.cd_tax AS cd_parent, 'OR' AS cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.taxo t ON tt.class=t.name_tax
WHERE tt."order" IS NOT NULL AND tt."order" NOT IN (SELECT name_tax FROM main.taxo WHERE cd_rank='OR')
GROUP BY tt."order", t.cd_tax
ORDER BY tt."order", count(*) DESC
RETURNING cd_tax
```

### 3.1.5 subordenes

``` sql
WITH a AS(
SELECT
  tt."order",
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='SOR'
)
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a."order"=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
```

<div class="knitsql-table">

| scientific_name | scientific_name_authorship | cd_parent | cd_rank | count | order_cases_in_name |
|:----------------|:---------------------------|----------:|:--------|------:|--------------------:|
| Brachycera      | Schiner, 1862              |        83 | SOR     |     4 |                   1 |

1 records

</div>

Casos problematicos:

``` sql
WITH a AS(
SELECT
  tt."order",
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='SOR'
), b AS(
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a."order"=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
)
SELECT * 
FROM b
WHERE b.scientific_name IN (SELECT scientific_name FROM b WHERE order_cases_in_name=2)
```

<div class="knitsql-table">

|                                                                                        |
|----------------------------------------------------------------------------------------|
| scientific_name scientific_name_authorship cd_parent cd_rank count order_cases_in_name |

------------------------------------------------------------------------

: 0 records

</div>

Por insertar:

``` sql
WITH a AS(
SELECT
  tt."order",
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='SOR'
), b AS(
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a."order"=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
)
SELECT scientific_name,scientific_name_authorship,cd_parent,cd_rank
FROM b 
WHERE order_cases_in_name=1
```

<div class="knitsql-table">

| scientific_name | scientific_name_authorship | cd_parent | cd_rank |
|:----------------|:---------------------------|----------:|:--------|
| Brachycera      | Schiner, 1862              |        83 | SOR     |

1 records

</div>

Ahora la inserción:

``` sql
INSERT INTO main.taxo(name_tax,authorship,cd_parent,cd_rank)
WITH a AS(
SELECT
  tt."order",
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='SOR'
), b AS(
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a."order"=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
)
SELECT scientific_name,scientific_name_authorship,cd_parent,cd_rank
FROM b 
WHERE order_cases_in_name=1 AND scientific_name IS NOT NULL
RETURNING cd_tax
```

### 3.1.6 Family

``` sql
WITH a AS(
SELECT
  tt."order",
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='FAM'
)
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a."order"=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
```

<div class="knitsql-table">

| scientific_name   | scientific_name_authorship        | cd_parent | cd_rank | count | order_cases_in_name |
|:------------------|:----------------------------------|----------:|:--------|------:|--------------------:|
| Acanthaceae       | Juss, 1789                        |       180 | FAM     |     1 |                   1 |
| Acanthaceae       | Juss. 1789                        |       180 | FAM     |     1 |                   2 |
| Achnanthidiaceae  | Kützing, 1844                     |        79 | FAM     |   192 |                   1 |
| Annonaceae        | NA                                |       186 | FAM     |     8 |                   1 |
| Arctiidae         | Leach, 1815                       |        85 | FAM     |     1 |                   1 |
| Arecaceae         | NA                                |       113 | FAM     |     7 |                   1 |
| Baetidae          | Leach, 1815                       |       156 | FAM     |    23 |                   1 |
| Bombacaceae       | Kunth, 1822                       |       188 | FAM     |     1 |                   1 |
| Bourletiellidae   | NA                                |        98 | FAM     |    16 |                   1 |
| Caprimulgidae     | NA                                |       126 | FAM     |     1 |                   1 |
| Chironomidae      | Rondani, 1840                     |        83 | FAM     |     2 |                   1 |
| Chroococcaceae    | Rabenhorst 1863                   |        81 | FAM     |     1 |                   1 |
| Chrysomelidae     |  Latreille, 1802                  |        82 | FAM     |     2 |                   1 |
| Coenagrionidae    | Kirby, 1890                       |        90 | FAM     |     8 |                   1 |
| Colubridae        | Oppel, 1811                       |        97 | FAM     |     6 |                   1 |
| Crambidae         | Latreille, 1810                   |        85 | FAM     |    21 |                   1 |
| Curculionidae     | Latreille, 1802                   |        82 | FAM     |    18 |                   1 |
| Cyperaceae        | Juss, 1789                        |       222 | FAM     |     8 |                   1 |
| Cyperaceae        | Juss. 1789                        |       222 | FAM     |     8 |                   2 |
| Desmidiaceae      | Ralfs, 1848                       |       152 | FAM     |     3 |                   1 |
| Dolichopodidae    | Latreille‎, 1809‎                   |        83 | FAM     |    12 |                   1 |
| Dryopidae         | Billberg, 1820                    |        82 | FAM     |     3 |                   1 |
| Dycirtomidae      | Börner, 1903                      |        98 | FAM     |     5 |                   1 |
| Dycirtomidae      | Börner, 1906                      |        98 | FAM     |     1 |                   2 |
| Dytiscidae        | Leach, 1815                       |        82 | FAM     |     2 |                   1 |
| Dytiscidae        | Aube, 1836                        |        82 | FAM     |     1 |                   2 |
| Empididae         | Latreille, 1804                   |        83 | FAM     |     1 |                   1 |
| Entomobryidae     | NA                                |        84 | FAM     |   173 |                   1 |
| Entomobryidae     | Schäffer, 1896                    |        84 | FAM     |     1 |                   2 |
| Entomobryidae     | N.D                               |        84 | FAM     |     1 |                   3 |
| Euphorbiaceae     | NA                                |       187 | FAM     |     9 |                   1 |
| Fabaceae          | NA                                |       160 | FAM     |     4 |                   1 |
| Felidae           | Fischer von Waldheim, 1817        |       127 | FAM     |     1 |                   1 |
| Fragilariaceae    | Greville, 1833                    |       163 | FAM     |     4 |                   1 |
| Gerridae          | \#N/D                             |       172 | FAM     |     1 |                   1 |
| Gerridae          | Leach, 1815                       |       172 | FAM     |     1 |                   2 |
| Glossiphoniidae   | Vaillant, 1890                    |       173 | FAM     |    40 |                   1 |
| Glossiphoniidae   | Blanchard, 1896                   |       173 | FAM     |    11 |                   2 |
| Gomphidae         | Rambur, 1842                      |        90 | FAM     |     2 |                   1 |
| Gomphonemataceae  | Kützing, 1844                     |       150 | FAM     |     2 |                   1 |
| Graphidaceae      | NA                                |       206 | FAM     |    44 |                   1 |
| Gryllidae         | NA                                |       205 | FAM     |     1 |                   1 |
| Gyrinidae         | Latreille, 1810                   |        82 | FAM     |     1 |                   1 |
| Hydrobiidae       | Stimpson, 1865                    |       199 | FAM     |    22 |                   1 |
| Hydroptilidae     | Stephens, 1836                    |       253 | FAM     |     1 |                   1 |
| Hypogastruridae   | NA                                |        93 | FAM     |     3 |                   1 |
| Isotomidae        | NA                                |        84 | FAM     |   181 |                   1 |
| Lampyridae        | Rafinesque, 1815                  |        82 | FAM     |     4 |                   1 |
| Lampyridae        | Latreille, 1817                   |        82 | FAM     |     1 |                   2 |
| Lauraceae         | NA                                |       181 | FAM     |    60 |                   1 |
| Leptophlebiidae   | \-                                |       156 | FAM     |     1 |                   1 |
| Libellulidae      | Rambur, 1842                      |        90 | FAM     |     5 |                   1 |
| Liliaceae         | Juss. 1789                        |       184 | FAM     |     1 |                   1 |
| Limnichidae       | Erichson, 1846                    |        82 | FAM     |     1 |                   1 |
| Lumbriculidae     | Vejdovský, 1884                   |       185 | FAM     |     6 |                   1 |
| Lutrochidae       | Kasap and Crowson, 1975           |        82 | FAM     |     2 |                   1 |
| Marantaceae       | R. Br. 1814                       |       261 | FAM     |     1 |                   1 |
| Mesoveliidae      | Douglas & Scott, 1867             |       172 | FAM     |     1 |                   1 |
| Molossidae        | NA                                |       136 | FAM     |    38 |                   1 |
| Moraceae          | NA                                |       232 | FAM     |     4 |                   1 |
| Muscidae          | Latreille, 1802                   |        83 | FAM     |     4 |                   1 |
| Naididae          | Ehrenberg 1828                    |       256 | FAM     |    54 |                   1 |
| Naididae          | Ehrenberg, 1828                   |       256 | FAM     |     4 |                   2 |
| Neanuridae        | NA                                |        93 | FAM     |     2 |                   1 |
| Noteridae         | C. G. Thomson, 1860               |        82 | FAM     |     1 |                   1 |
| Orchesellidae     | NA                                |        84 | FAM     |     3 |                   1 |
| Oscillatoriaceae  | Engler, 1898                      |        92 | FAM     |     5 |                   1 |
| Oscillatoriaceae  | Engler 1898                       |        92 | FAM     |     3 |                   2 |
| Phormidiaceae     | Anagnostidis & Komárek, 1988      |        92 | FAM     |     5 |                   1 |
| Phyllostomidae    | NA                                |       136 | FAM     |    10 |                   1 |
| Poaceae           | Barnhart, 1895                    |       222 | FAM     |     2 |                   1 |
| Poaceae           | Barnhart. 1895                    |       222 | FAM     |     1 |                   2 |
| Polycentropodidae | Ulmer, 1903                       |       253 | FAM     |     1 |                   1 |
| Pseudanabaenaceae | K.Anagnostidis & J.Komárek , 1988 |       245 | FAM     |    15 |                   1 |
| Pseudanabaenaceae | K.Anagnostidis & J.Komárek 1988   |       245 | FAM     |     2 |                   2 |
| Pseudanabaenaceae | Anagnostidis & Komárek, 1988      |       245 | FAM     |     1 |                   3 |
| Psychodidae       | N.D                               |        83 | FAM     |     1 |                   1 |
| Pyralidae         | Latreille, 1802                   |        85 | FAM     |     3 |                   1 |
| Ramalinaceae      | NA                                |       182 | FAM     |     4 |                   1 |
| Rubiaceae         | NA                                |       166 | FAM     |    46 |                   1 |
| Sciaridae         | \-                                |        83 | FAM     |     1 |                   1 |
| Simaroubaceae     | NA                                |       235 | FAM     |     1 |                   1 |
| Sminthuridae      | NA                                |        98 | FAM     |     2 |                   1 |
| Sminthurididae    | NA                                |        98 | FAM     |    98 |                   1 |
| Staphylinidae     | Latreille, 1802                   |        82 | FAM     |     4 |                   1 |
| Staphylinidae     | Latreille, 1796                   |        82 | FAM     |     1 |                   2 |
| Stratiomyidae     | Latreille, 1802                   |        83 | FAM     |     2 |                   1 |
| Tabanidae         | Latreille, 1802                   |        83 | FAM     |    14 |                   1 |
| Tettigoniidae     | NA                                |       205 | FAM     |     8 |                   1 |
| Tipulidae         | Kirby & Spence, 1815              |        83 | FAM     |     1 |                   1 |
| Trichodactylidae  | Milne Edwards, 1853               |       151 | FAM     |    19 |                   1 |
| Trombidiidae      | \-                                |       101 | FAM     |     2 |                   1 |
| Ulotrichaceae     | Kützing, 1843                     |       257 | FAM     |     2 |                   1 |
| Veliidae          | Amyot & Serville, 1843            |       172 | FAM     |     1 |                   1 |
| Vespertilionidae  | NA                                |       136 | FAM     |    32 |                   1 |
| Xyridaceae        | C.Agardh                          |       222 | FAM     |     1 |                   1 |

96 records

</div>

Para ver solo los casos problematicos, podemos utilizar eso:

``` sql
WITH a AS(
SELECT
  tt."order",
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='FAM'
), b AS(
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a."order"=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
)
SELECT * 
FROM b
WHERE b.scientific_name IN (SELECT scientific_name FROM b WHERE order_cases_in_name=2)
```

<div class="knitsql-table">

| scientific_name   | scientific_name_authorship        | cd_parent | cd_rank | count | order_cases_in_name |
|:------------------|:----------------------------------|----------:|:--------|------:|--------------------:|
| Acanthaceae       | Juss, 1789                        |       180 | FAM     |     1 |                   1 |
| Acanthaceae       | Juss. 1789                        |       180 | FAM     |     1 |                   2 |
| Cyperaceae        | Juss, 1789                        |       222 | FAM     |     8 |                   1 |
| Cyperaceae        | Juss. 1789                        |       222 | FAM     |     8 |                   2 |
| Dycirtomidae      | Börner, 1903                      |        98 | FAM     |     5 |                   1 |
| Dycirtomidae      | Börner, 1906                      |        98 | FAM     |     1 |                   2 |
| Dytiscidae        | Leach, 1815                       |        82 | FAM     |     2 |                   1 |
| Dytiscidae        | Aube, 1836                        |        82 | FAM     |     1 |                   2 |
| Entomobryidae     | NA                                |        84 | FAM     |   173 |                   1 |
| Entomobryidae     | Schäffer, 1896                    |        84 | FAM     |     1 |                   2 |
| Entomobryidae     | N.D                               |        84 | FAM     |     1 |                   3 |
| Gerridae          | \#N/D                             |       172 | FAM     |     1 |                   1 |
| Gerridae          | Leach, 1815                       |       172 | FAM     |     1 |                   2 |
| Glossiphoniidae   | Vaillant, 1890                    |       173 | FAM     |    40 |                   1 |
| Glossiphoniidae   | Blanchard, 1896                   |       173 | FAM     |    11 |                   2 |
| Lampyridae        | Rafinesque, 1815                  |        82 | FAM     |     4 |                   1 |
| Lampyridae        | Latreille, 1817                   |        82 | FAM     |     1 |                   2 |
| Naididae          | Ehrenberg 1828                    |       256 | FAM     |    54 |                   1 |
| Naididae          | Ehrenberg, 1828                   |       256 | FAM     |     4 |                   2 |
| Oscillatoriaceae  | Engler, 1898                      |        92 | FAM     |     5 |                   1 |
| Oscillatoriaceae  | Engler 1898                       |        92 | FAM     |     3 |                   2 |
| Poaceae           | Barnhart, 1895                    |       222 | FAM     |     2 |                   1 |
| Poaceae           | Barnhart. 1895                    |       222 | FAM     |     1 |                   2 |
| Pseudanabaenaceae | K.Anagnostidis & J.Komárek , 1988 |       245 | FAM     |    15 |                   1 |
| Pseudanabaenaceae | K.Anagnostidis & J.Komárek 1988   |       245 | FAM     |     2 |                   2 |
| Pseudanabaenaceae | Anagnostidis & Komárek, 1988      |       245 | FAM     |     1 |                   3 |
| Staphylinidae     | Latreille, 1802                   |        82 | FAM     |     4 |                   1 |
| Staphylinidae     | Latreille, 1796                   |        82 | FAM     |     1 |                   2 |

28 records

</div>

Para obtener la tabla por insertar:

``` sql
WITH a AS(
SELECT
  tt."order",
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='FAM'
), b AS(
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a."order"=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
)
SELECT scientific_name,scientific_name_authorship,cd_parent,cd_rank
FROM b 
WHERE order_cases_in_name=1
```

<div class="knitsql-table">

| scientific_name   | scientific_name_authorship        | cd_parent | cd_rank |
|:------------------|:----------------------------------|----------:|:--------|
| Acanthaceae       | Juss, 1789                        |       180 | FAM     |
| Achnanthidiaceae  | Kützing, 1844                     |        79 | FAM     |
| Annonaceae        | NA                                |       186 | FAM     |
| Arctiidae         | Leach, 1815                       |        85 | FAM     |
| Arecaceae         | NA                                |       113 | FAM     |
| Baetidae          | Leach, 1815                       |       156 | FAM     |
| Bombacaceae       | Kunth, 1822                       |       188 | FAM     |
| Bourletiellidae   | NA                                |        98 | FAM     |
| Caprimulgidae     | NA                                |       126 | FAM     |
| Chironomidae      | Rondani, 1840                     |        83 | FAM     |
| Chroococcaceae    | Rabenhorst 1863                   |        81 | FAM     |
| Chrysomelidae     |  Latreille, 1802                  |        82 | FAM     |
| Coenagrionidae    | Kirby, 1890                       |        90 | FAM     |
| Colubridae        | Oppel, 1811                       |        97 | FAM     |
| Crambidae         | Latreille, 1810                   |        85 | FAM     |
| Curculionidae     | Latreille, 1802                   |        82 | FAM     |
| Cyperaceae        | Juss, 1789                        |       222 | FAM     |
| Desmidiaceae      | Ralfs, 1848                       |       152 | FAM     |
| Dolichopodidae    | Latreille‎, 1809‎                   |        83 | FAM     |
| Dryopidae         | Billberg, 1820                    |        82 | FAM     |
| Dycirtomidae      | Börner, 1903                      |        98 | FAM     |
| Dytiscidae        | Leach, 1815                       |        82 | FAM     |
| Empididae         | Latreille, 1804                   |        83 | FAM     |
| Entomobryidae     | NA                                |        84 | FAM     |
| Euphorbiaceae     | NA                                |       187 | FAM     |
| Fabaceae          | NA                                |       160 | FAM     |
| Felidae           | Fischer von Waldheim, 1817        |       127 | FAM     |
| Fragilariaceae    | Greville, 1833                    |       163 | FAM     |
| Gerridae          | \#N/D                             |       172 | FAM     |
| Glossiphoniidae   | Vaillant, 1890                    |       173 | FAM     |
| Gomphidae         | Rambur, 1842                      |        90 | FAM     |
| Gomphonemataceae  | Kützing, 1844                     |       150 | FAM     |
| Graphidaceae      | NA                                |       206 | FAM     |
| Gryllidae         | NA                                |       205 | FAM     |
| Gyrinidae         | Latreille, 1810                   |        82 | FAM     |
| Hydrobiidae       | Stimpson, 1865                    |       199 | FAM     |
| Hydroptilidae     | Stephens, 1836                    |       253 | FAM     |
| Hypogastruridae   | NA                                |        93 | FAM     |
| Isotomidae        | NA                                |        84 | FAM     |
| Lampyridae        | Rafinesque, 1815                  |        82 | FAM     |
| Lauraceae         | NA                                |       181 | FAM     |
| Leptophlebiidae   | \-                                |       156 | FAM     |
| Libellulidae      | Rambur, 1842                      |        90 | FAM     |
| Liliaceae         | Juss. 1789                        |       184 | FAM     |
| Limnichidae       | Erichson, 1846                    |        82 | FAM     |
| Lumbriculidae     | Vejdovský, 1884                   |       185 | FAM     |
| Lutrochidae       | Kasap and Crowson, 1975           |        82 | FAM     |
| Marantaceae       | R. Br. 1814                       |       261 | FAM     |
| Mesoveliidae      | Douglas & Scott, 1867             |       172 | FAM     |
| Molossidae        | NA                                |       136 | FAM     |
| Moraceae          | NA                                |       232 | FAM     |
| Muscidae          | Latreille, 1802                   |        83 | FAM     |
| Naididae          | Ehrenberg 1828                    |       256 | FAM     |
| Neanuridae        | NA                                |        93 | FAM     |
| Noteridae         | C. G. Thomson, 1860               |        82 | FAM     |
| Orchesellidae     | NA                                |        84 | FAM     |
| Oscillatoriaceae  | Engler, 1898                      |        92 | FAM     |
| Phormidiaceae     | Anagnostidis & Komárek, 1988      |        92 | FAM     |
| Phyllostomidae    | NA                                |       136 | FAM     |
| Poaceae           | Barnhart, 1895                    |       222 | FAM     |
| Polycentropodidae | Ulmer, 1903                       |       253 | FAM     |
| Pseudanabaenaceae | K.Anagnostidis & J.Komárek , 1988 |       245 | FAM     |
| Psychodidae       | N.D                               |        83 | FAM     |
| Pyralidae         | Latreille, 1802                   |        85 | FAM     |
| Ramalinaceae      | NA                                |       182 | FAM     |
| Rubiaceae         | NA                                |       166 | FAM     |
| Sciaridae         | \-                                |        83 | FAM     |
| Simaroubaceae     | NA                                |       235 | FAM     |
| Sminthuridae      | NA                                |        98 | FAM     |
| Sminthurididae    | NA                                |        98 | FAM     |
| Staphylinidae     | Latreille, 1802                   |        82 | FAM     |
| Stratiomyidae     | Latreille, 1802                   |        83 | FAM     |
| Tabanidae         | Latreille, 1802                   |        83 | FAM     |
| Tettigoniidae     | NA                                |       205 | FAM     |
| Tipulidae         | Kirby & Spence, 1815              |        83 | FAM     |
| Trichodactylidae  | Milne Edwards, 1853               |       151 | FAM     |
| Trombidiidae      | \-                                |       101 | FAM     |
| Ulotrichaceae     | Kützing, 1843                     |       257 | FAM     |
| Veliidae          | Amyot & Serville, 1843            |       172 | FAM     |
| Vespertilionidae  | NA                                |       136 | FAM     |
| Xyridaceae        | C.Agardh                          |       222 | FAM     |

81 records

</div>

Ahora la inserción:

``` sql
INSERT INTO main.taxo(name_tax,authorship,cd_parent,cd_rank)
WITH a AS(
SELECT
  tt."order",
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='FAM'
), b AS(
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a."order"=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
)
SELECT scientific_name,scientific_name_authorship,cd_parent,cd_rank
FROM b 
WHERE order_cases_in_name=1
RETURNING cd_tax
```

``` sql
SELECT tt."order", t.cd_tax AS cd_parent, tt.family, 'FAM' AS cd_rank, count(*)
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.taxo t ON tt."order"=t.name_tax
WHERE tt.family IS NOT NULL
GROUP BY tt."order",tt.family, t.cd_tax
ORDER BY tt.family, count(*) DESC
```

<div class="knitsql-table">

| order             | cd_parent | family             | cd_rank | count |
|:------------------|----------:|:-------------------|:--------|------:|
| Lamiales          |       180 | Acanthaceae        | FAM     |     5 |
| Accipitriformes   |       102 | Accipitridae       | FAM     |   383 |
| Malpighiales      |       187 | Achariaceae        | FAM     |   136 |
| Achnanthales      |        79 | Achnanthidiaceae   | FAM     |   221 |
| Acrochaetiales    |       103 | Acrochaetiaceae    | FAM     |    24 |
| Odonata           |        90 | Aeshnidae          | FAM     |    18 |
| Coraciiformes     |       144 | Alcedinidae        | FAM     |    59 |
| Alismatales       |       105 | Alismataceae       | FAM     |     4 |
| Crocodylia        |       145 | Alligatoridae      | FAM     |    93 |
| Squamata          |        97 | Alopoglossidae     | FAM     |     4 |
| Caryophyllales    |       128 | Amaranthaceae      | FAM     |     6 |
| Naviculales       |        87 | Amphipleuraceae    | FAM     |   257 |
| Squamata          |        97 | Amphisbaenidae     | FAM     |     1 |
| Architaenioglossa |       112 | Ampullariidae      | FAM     |    27 |
| Sapindales        |       235 | Anacardiaceae      | FAM     |   413 |
| Anseriformes      |       107 | Anatidae           | FAM     |   139 |
| Anseriformes      |       107 | Anhimidae          | FAM     |    30 |
| Suliformes        |       242 | Anhingidae         | FAM     |     1 |
| Magnoliales       |       186 | Annonaceae         | FAM     |   348 |
| Squamata          |        97 | Anomalepididae     | FAM     |     1 |
| Cymbellales       |       150 | Anomoeoneidaceae   | FAM     |     2 |
| Characiformes     |       134 | Anostomidae        | FAM     |    20 |
| Nostocales        |       201 | Aphanizomenonaceae | FAM     |     5 |
| Gentianales       |       166 | Apocynaceae        | FAM     |   104 |
| Apodiformes       |       110 | Apodidae           | FAM     |    17 |
| Gymnotiformes     |       171 | Apteronotidae      | FAM     |    24 |
| Alismatales       |       105 | Araceae            | FAM     |   107 |
| Apiales           |       109 | Araliaceae         | FAM     |    45 |
| Gruiformes        |       169 | Aramidae           | FAM     |    21 |
| Arcellinida       |       111 | Arcellidae         | FAM     |   120 |
| Lepidoptera       |        85 | Arctiidae          | FAM     |     1 |
| Pelecaniformes    |       210 | Ardeidae           | FAM     |  2153 |
| Arecales          |       113 | Arecaceae          | FAM     |    66 |
| Anura             |       108 | Aromobatidae       | FAM     |     5 |
| Arthoniales       |       114 | Arthoniaceae       | FAM     |   388 |
| Ploima            |       221 | Asplanchnidae      | FAM     |    14 |
| Polypodiales      |       224 | Aspleniaceae       | FAM     |    14 |
| Siluriformes      |       238 | Aspredinidae       | FAM     |    34 |
| Siluriformes      |       238 | Auchenipteridae    | FAM     |    25 |
| Aulacoseirales    |       117 | Aulacoseiraceae    | FAM     |    50 |
| Bacillariales     |       118 | Bacillariaceae     | FAM     |   259 |
| Ephemeroptera     |       156 | Baetidae           | FAM     |   115 |
| Balliales         |       119 | Balliaceae         | FAM     |     6 |
| Hemiptera         |       172 | Belostomatidae     | FAM     |    41 |
| Lamiales          |       180 | Bignoniaceae       | FAM     |    88 |
| Malvales          |       188 | Bixaceae           | FAM     |    23 |
| Polypodiales      |       224 | Blechnaceae        | FAM     |     1 |
| Squamata          |        97 | Boidae             | FAM     |    13 |
| Malvales          |       188 | Bombacaceae        | FAM     |     1 |
| Oscillatoriales   |        92 | Borziaceae         | FAM     |     1 |
| Diplostraca       |       155 | Bosminidae         | FAM     |    22 |
| Trebouxiales      |       251 | Botryococcaceae    | FAM     |    22 |
| Symphypleona      |        98 | Bourletiellidae    | FAM     |   122 |
| Cetartiodactyla   |       132 | Bovidae            | FAM     | 18462 |
| Ploima            |       221 | Brachionidae       | FAM     |    83 |
| Naviculales       |        87 | Brachysiraceae     | FAM     |     1 |
| Poduromorpha      |        93 | Brachystomellidae  | FAM     |   173 |
| Brassicales       |       123 | Brassicaceae       | FAM     |     1 |
| Characiformes     |       134 | Bryconidae         | FAM     |     2 |
| Galbuliformes     |       164 | Bucconidae         | FAM     |    33 |
| Anura             |       108 | Bufonidae          | FAM     |    76 |
| Sapindales        |       235 | Burseraceae        | FAM     |    88 |
| Lecanorales       |       182 | Byssolomataceae    | FAM     |     3 |
| Nymphaeales       |       203 | Cabombaceae        | FAM     |     2 |
| Ephemeroptera     |       156 | Caenidae           | FAM     |    28 |
| Trichoptera       |       253 | Calamoceratidae    | FAM     |     7 |
| Siluriformes      |       238 | Callichthyidae     | FAM     |    27 |
| Malpighiales      |       187 | Calophyllaceae     | FAM     |     6 |
| Odonata           |        90 | Calopterygidae     | FAM     |    16 |
| Pottiales         |       226 | Calymperaceae      | FAM     |    22 |
| Carnivora         |       127 | Canidae            | FAM     |   566 |
| Rosales           |       232 | Cannabaceae        | FAM     |     1 |
| Brassicales       |       123 | Capparaceae        | FAM     |     1 |
| Caprimulgiformes  |       126 | Caprimulgidae      | FAM     |   721 |
| Passeriformes     |       209 | Cardinalidae       | FAM     |    15 |
| Brassicales       |       123 | Caricaceae         | FAM     |     2 |
| Malpighiales      |       187 | Caryocaraceae      | FAM     |    13 |
| Cathartiformes    |       129 | Cathartidae        | FAM     |   257 |
| Rodentia          |        94 | Caviidae           | FAM     |   869 |
| Primates          |       227 | Cebidae            | FAM     |   641 |
| Celastrales       |       131 | Celastraceae       | FAM     |     4 |
| Anura             |       108 | Centrolenidae      | FAM     |     1 |
| Gonyaulacales     |       168 | Ceratiaceae        | FAM     |     1 |
| Diptera           |        83 | Ceratopogonidae    | FAM     |   195 |
| Cetartiodactyla   |       132 | Cervidae           | FAM     |   389 |
| Siluriformes      |       238 | Cetopsidae         | FAM     |     1 |
| Chaetophorales    |       133 | Chaetophoraceae    | FAM     |    21 |
| Diptera           |        83 | Chaoboridae        | FAM     |    10 |
| Sphaeropleales    |        96 | Characiaceae       | FAM     |     8 |
| Characiformes     |       134 | Characidae         | FAM     |   542 |
| Charadriiformes   |       135 | Charadriidae       | FAM     |    42 |
| Diptera           |        83 | Chironomidae       | FAM     |   572 |
| Chlamydomonadales |        80 | Chlamydomonadaceae | FAM     |    14 |
| Cingulata         |       140 | Chlamyphoridae     | FAM     |    25 |
| Chlorellales      |       137 | Chlorellaceae      | FAM     |     3 |
| Chroococcales     |        81 | Chroococcaceae     | FAM     |     2 |
| Malpighiales      |       187 | Chrysobalanaceae   | FAM     |    13 |
| Coleoptera        |        82 | Chrysomelidae      | FAM     |     2 |
| Diplostraca       |       155 | Chydoridae         | FAM     |     2 |
| Blenniiformes     |       121 | Cichlidae          | FAM     |   234 |

Displaying records 1 - 100

</div>

``` sql
INSERT INTO main.taxo(name_tax,cd_parent,cd_rank)
SELECT  tt.family, t.cd_tax AS cd_parent, 'FAM' AS cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.taxo t ON tt."order"=t.name_tax
WHERE tt.family IS NOT NULL AND tt.family NOT IN (SELECT name_tax FROM main.taxo WHERE cd_rank='FAM')
GROUP BY tt."order",tt.family, t.cd_tax
ORDER BY tt.family, count(*) DESC
RETURNING cd_tax
```

### 3.1.7 Subfamilias

``` sql
WITH a AS(
SELECT
  tt.family,
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='SFAM'
)
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a.family=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
```

<div class="knitsql-table">

| scientific_name | scientific_name_authorship | cd_parent | cd_rank | count | order_cases_in_name |
|:----------------|:---------------------------|----------:|:--------|------:|--------------------:|
| Acentropinae    | Stephens, 1836             |       279 | SFAM    |     1 |                   1 |
| Chironominae    | Rondani, 1840              |       274 | SFAM    |   253 |                   1 |
| Heptapterinae   | NA                         |       520 | SFAM    |     4 |                   1 |
| Orthocladiinae  | Lenz, 1921                 |       274 | SFAM    |   118 |                   1 |
| Ponerinae       | NA                         |       500 | SFAM    |     2 |                   1 |
| Stratiomyinae   | Latrielle, 1802            |       336 | SFAM    |    12 |                   1 |
| Tachyporinae    | MacLeay, 1825              |       335 | SFAM    |     1 |                   1 |
| Tanypodinae     | Rondani, 1840              |       274 | SFAM    |   199 |                   1 |

8 records

</div>

Para ver solo los casos problematicos, podemos utilizar eso:

``` sql
WITH a AS(
SELECT
  tt.family,
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='SFAM'
), b AS(
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a.family=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
)
SELECT * 
FROM b
WHERE b.scientific_name IN (SELECT scientific_name FROM b WHERE order_cases_in_name=2)
```

<div class="knitsql-table">

|                                                                                        |
|----------------------------------------------------------------------------------------|
| scientific_name scientific_name_authorship cd_parent cd_rank count order_cases_in_name |

------------------------------------------------------------------------

: 0 records

</div>

Para obtener la tabla por insertar:

``` sql
WITH a AS(
SELECT
  tt.family,
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='SFAM'
), b AS(
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a.family=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
)
SELECT scientific_name,scientific_name_authorship,cd_parent,cd_rank
FROM b 
WHERE order_cases_in_name=1
```

<div class="knitsql-table">

| scientific_name | scientific_name_authorship | cd_parent | cd_rank |
|:----------------|:---------------------------|----------:|:--------|
| Acentropinae    | Stephens, 1836             |       279 | SFAM    |
| Chironominae    | Rondani, 1840              |       274 | SFAM    |
| Heptapterinae   | NA                         |       520 | SFAM    |
| Orthocladiinae  | Lenz, 1921                 |       274 | SFAM    |
| Ponerinae       | NA                         |       500 | SFAM    |
| Stratiomyinae   | Latrielle, 1802            |       336 | SFAM    |
| Tachyporinae    | MacLeay, 1825              |       335 | SFAM    |
| Tanypodinae     | Rondani, 1840              |       274 | SFAM    |

8 records

</div>

Ahora la inserción:

``` sql
INSERT INTO main.taxo(name_tax,authorship,cd_parent,cd_rank)
WITH a AS(
SELECT
  tt.family,
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='SFAM'
), b AS(
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a.family=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
)
SELECT scientific_name,scientific_name_authorship,cd_parent,cd_rank
FROM b 
WHERE order_cases_in_name=1
RETURNING cd_tax
```

``` sql
SELECT tt.family, t.cd_tax AS cd_parent, tt.subfamily, 'SFAM' AS cd_rank, count(*)
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.taxo t ON tt.family=t.name_tax
WHERE tt.subfamily IS NOT NULL
GROUP BY tt.family,tt.subfamily, t.cd_tax
ORDER BY tt.subfamily, count(*) DESC
```

<div class="knitsql-table">

| family       | cd_parent | subfamily     | cd_rank | count |
|:-------------|----------:|:--------------|:--------|------:|
| Nymphalidae  |       604 | Biblidinae    | SFAM    |   317 |
| Nymphalidae  |       604 | Charaxinae    | SFAM    |   167 |
| Pieridae     |       642 | Coliadinae    | SFAM    |    53 |
| Nymphalidae  |       604 | Cyrestinae    | SFAM    |     4 |
| Nymphalidae  |       604 | Danainae      | SFAM    |    29 |
| Scarabaeidae |       690 | Dynastinae    | SFAM    |     5 |
| Hesperiidae  |       521 | Eudaminae     | SFAM    |   234 |
| Riodinidae   |       681 | Euselasiinae  | SFAM    |     8 |
| Nymphalidae  |       604 | Heliconiinae  | SFAM    |   302 |
| Hesperiidae  |       521 | Hesperiinae   | SFAM    |   180 |
| Nymphalidae  |       604 | Limenitidinae | SFAM    |   117 |
| Scarabaeidae |       690 | Melolonthinae | SFAM    |    27 |
| Nymphalidae  |       604 | Nymphalinae   | SFAM    |   365 |
| Scarabaeidae |       690 | Orphinae      | SFAM    |     7 |
| Papilionidae |       621 | Papilioninae  | SFAM    |    15 |
| Pieridae     |       642 | Pierinae      | SFAM    |     5 |
| Lycaenidae   |       559 | Polyommatinae | SFAM    |     4 |
| Hesperiidae  |       521 | Pyrginae      | SFAM    |    71 |
| Hesperiidae  |       521 | Pyrrhopyginae | SFAM    |     9 |
| Riodinidae   |       681 | Riodininae    | SFAM    |   126 |
| Scarabaeidae |       690 | Rutelinae     | SFAM    |     2 |
| Nymphalidae  |       604 | Satyrinae     | SFAM    |  1703 |
| Scarabaeidae |       690 | Scarabaeinae  | SFAM    |  3867 |
| Lycaenidae   |       559 | Theclinae     | SFAM    |    63 |

24 records

</div>

``` sql
INSERT INTO main.taxo(name_tax,cd_parent,cd_rank)
SELECT  tt.subfamily, t.cd_tax AS cd_parent, 'SFAM' AS cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.taxo t ON tt.family=t.name_tax
WHERE tt.subfamily IS NOT NULL AND tt.subfamily NOT IN (SELECT name_tax FROM main.taxo WHERE cd_rank='SFAM')
GROUP BY tt.family,tt.subfamily, t.cd_tax
ORDER BY tt.subfamily, count(*) DESC
RETURNING cd_tax
```

### 3.1.8 Tribus

``` sql
WITH a AS(
SELECT
  COALESCE(tt.subfamily,tt.family) sup,
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='TR'
)
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a.sup=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
```

<div class="knitsql-table">

| scientific_name | scientific_name_authorship | cd_parent | cd_rank | count | order_cases_in_name |
|:----------------|:---------------------------|----------:|:--------|------:|--------------------:|
| Bidessini       | Sharp, 1882                |       286 | TR      |     1 |                   1 |

1 records

</div>

Para ver solo los casos problematicos, podemos utilizar eso:

``` sql
WITH a AS(
SELECT
  COALESCE(tt.subfamily,tt.family) sup,
  tt.phylum,
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='TR'
), b AS(
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a.sup=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
)
SELECT * 
FROM b
WHERE b.scientific_name IN (SELECT scientific_name FROM b WHERE order_cases_in_name=2)
```

<div class="knitsql-table">

|                                                                                        |
|----------------------------------------------------------------------------------------|
| scientific_name scientific_name_authorship cd_parent cd_rank count order_cases_in_name |

------------------------------------------------------------------------

: 0 records

</div>

Para obtener la tabla por insertar:

``` sql
WITH a AS(
SELECT
  COALESCE(tt.subfamily,tt.family) sup,
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='TR'
), b AS(
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a.sup=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
)
SELECT scientific_name,scientific_name_authorship,cd_parent,cd_rank
FROM b 
WHERE order_cases_in_name=1
```

<div class="knitsql-table">

| scientific_name | scientific_name_authorship | cd_parent | cd_rank |
|:----------------|:---------------------------|----------:|:--------|
| Bidessini       | Sharp, 1882                |       286 | TR      |

1 records

</div>

Ahora la inserción:

``` sql
INSERT INTO main.taxo(name_tax,authorship,cd_parent,cd_rank)
WITH a AS(
SELECT
  COALESCE(tt.subfamily,tt.family) sup,
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='TR'
), b AS(
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a.sup=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
)
SELECT scientific_name,scientific_name_authorship,cd_parent,cd_rank
FROM b 
WHERE order_cases_in_name=1
RETURNING cd_tax
```

### 3.1.9 Género

``` sql
WITH a AS(
SELECT
  COALESCE(tt.subfamily,tt.family) sup,
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='GN'
)
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a.sup=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
```

<div class="knitsql-table">

| scientific_name   | scientific_name_authorship                                              | cd_parent | cd_rank | count | order_cases_in_name |
|:------------------|:------------------------------------------------------------------------|----------:|:--------|------:|--------------------:|
| Acanthagrion      | Selys, 1876                                                             |       277 | GN      |    17 |                   1 |
| Acantheremus      | NA                                                                      |       338 | GN      |     2 |                   1 |
| Achnanthidium     | Kützing, 1844                                                           |       266 | GN      |    16 |                   1 |
| Actinella         | Lewis, 1864                                                             |       497 | GN      |    24 |                   1 |
| Actinotaenium     | Teiling, 1954                                                           |       282 | GN      |     8 |                   1 |
| Acutodesmus       | (Hegewald) Tsarenko, 2001                                               |       691 | GN      |     3 |                   1 |
| Adiantum          | Linneo. 1753                                                            |       671 | GN      |     5 |                   1 |
| Adisianus         | Bretfeld, 2003                                                          |       272 | GN      |     1 |                   1 |
| Aedeomyia         | Theobald, 1901                                                          |       459 | GN      |     7 |                   1 |
| Agriogomphus      | Selys, 1869                                                             |       295 | GN      |    16 |                   1 |
| Aiouea            | NA                                                                      |       305 | GN      |     3 |                   1 |
| Alchornea         | NA                                                                      |       289 | GN      |     2 |                   1 |
| Allophyllus       | NA                                                                      |       688 | GN      |     2 |                   1 |
| Allophylus        | Linneo. 1753                                                            |       688 | GN      |     1 |                   1 |
| Alluaudomyia      | Kieffer, 1913                                                           |       420 | GN      |    71 |                   1 |
| Alona             | Baird, 1850                                                             |       432 | GN      |     2 |                   1 |
| Amazona           | NA                                                                      |       670 | GN      |     4 |                   1 |
| Ambrysus          | Stål, 1861                                                              |       591 | GN      |    43 |                   1 |
| Americabaetis     | Kluge, 1992                                                             |       270 | GN      |     2 |                   1 |
| Anabaena          | Bornet & Flahault, 1886                                                 |       599 | GN      |    59 |                   1 |
| Anacaena          | Thomson, 1859                                                           |       531 | GN      |     7 |                   1 |
| Anacroneuria      | Klapálek, 1909                                                          |       630 | GN      |    15 |                   1 |
| Anacroneuria      | Klapálek, 1910                                                          |       630 | GN      |     1 |                   2 |
| Anacroneuria      | Klapálek, 1911                                                          |       630 | GN      |     1 |                   3 |
| Andaeschna        | De Marmels, 1994                                                        |       349 | GN      |     5 |                   1 |
| Aneumastus        | D.G. Mann & A.J. Stickle in F.E. Round, R.M. Crawford & D.G. Mann, 1990 |       565 | GN      |     4 |                   1 |
| Anisagrion        | Selys 1876                                                              |       277 | GN      |     5 |                   1 |
| Anisomeridium     | NA                                                                      |       583 | GN      |     8 |                   1 |
| Ankistrodesmus    | Corda, 1838                                                             |       699 | GN      |    21 |                   1 |
| Annona            | NA                                                                      |       267 | GN      |     3 |                   1 |
| Anodocheilus      | Babington, 1838                                                         |       286 | GN      |     5 |                   1 |
| Anomoeoneis       | E. Pfitzer, 1871                                                        |       363 | GN      |     2 |                   1 |
| Anopheles         | Meigen, 1818                                                            |       459 | GN      |    13 |                   1 |
| Anthurium         | Schott, 1829                                                            |       369 | GN      |     7 |                   1 |
| Anthurium         | Schott. 1829                                                            |       369 | GN      |     6 |                   2 |
| Aphanocapsa       | C.Nägeli, 1849                                                          |       570 | GN      |     2 |                   1 |
| Aphylla           | Selys, 1854                                                             |       295 | GN      |     5 |                   1 |
| Apobaetis         | Day, 1955                                                               |       270 | GN      |    33 |                   1 |
| Arcella           | Ehrenberg, 1832                                                         |       372 | GN      |   119 |                   1 |
| Argia             | Rambur, 1842                                                            |       277 | GN      |    33 |                   1 |
| Arlesia           | Handschin, 1942                                                         |       318 | GN      |    72 |                   1 |
| Arthothelium      | NA                                                                      |       375 | GN      |     1 |                   1 |
| Arthrodesmus      | Ehrenberg ex Ralfs, 1848                                                |       282 | GN      |     2 |                   1 |
| Artibeus          | Leach, 1821                                                             |       323 | GN      |    24 |                   1 |
| Asplanchna        | Gosse, 1850                                                             |       376 | GN      |    14 |                   1 |
| Asplenium         | Linneo,                                                                 |       377 | GN      |    14 |                   1 |
| Astaena           | NA                                                                      |       773 | GN      |     1 |                   1 |
| Astrothelium      | NA                                                                      |       740 | GN      |     3 |                   1 |
| Astyanax          | NA                                                                      |       426 | GN      |    72 |                   1 |
| Atractus          | NA                                                                      |       278 | GN      |     1 |                   1 |
| Atrichopogon      | Meigen, 1830                                                            |       420 | GN      |    15 |                   1 |
| Atrichopogon      | Kieffer, 1906                                                           |       420 | GN      |     2 |                   2 |
| Aturbina          | Lugo-Ortiz & McCafferty, 1996                                           |       270 | GN      |     5 |                   1 |
| Audouinella       | Bory, 1823                                                              |       348 | GN      |    24 |                   1 |
| Aulacoseira       | Thwaites, 1848                                                          |       380 | GN      |    50 |                   1 |
| Austrolimnius     | Carter and Zeck, 1929                                                   |       487 | GN      |    19 |                   1 |
| Azteca            | Forel, 1878                                                             |       500 | GN      |    61 |                   1 |
| Bacidia           | NA                                                                      |       329 | GN      |    33 |                   1 |
| Bactrospora       | NA                                                                      |       684 | GN      |     2 |                   1 |
| Ballia            | Harvey, 1840                                                            |       382 | GN      |     6 |                   1 |
| Bambusina         | Kützing ex Kützing, 1849                                                |       282 | GN      |    15 |                   1 |
| Barybas           | NA                                                                      |       773 | GN      |     1 |                   1 |
| Beauchampiella    | Remane, 1929                                                            |       495 | GN      |     1 |                   1 |
| Belostoma         | Latreille, 1807                                                         |       383 | GN      |    41 |                   1 |
| Berosus           | Leach, 1817                                                             |       531 | GN      |    26 |                   1 |
| Bidessonotus      | Régimbart, 1895                                                         |       286 | GN      |     1 |                   1 |
| Biomphalaria      | Preston, 1910                                                           |       650 | GN      |    51 |                   1 |
| Bogoriella        | NA                                                                      |       740 | GN      |    16 |                   1 |
| Bosmina           | Baird, 1845                                                             |       389 | GN      |    22 |                   1 |
| Botryococcus      | Kützing, 1849                                                           |       390 | GN      |    22 |                   1 |
| Bourletiella      | Banks, 1899                                                             |       272 | GN      |    74 |                   1 |
| Brachionus        | Pallas, 1766                                                            |       392 | GN      |    35 |                   1 |
| Brachymesia       | Kirby, 1889                                                             |       307 | GN      |     9 |                   1 |
| Brachymetra       | Mayr, 1865                                                              |       293 | GN      |    25 |                   1 |
| Brachymyrmex      | Mayr, 1868                                                              |       500 | GN      |    11 |                   1 |
| Brachysira        | Kützing, 1836                                                           |       393 | GN      |     1 |                   1 |
| Brachystomella    | Ågren, 1903                                                             |       394 | GN      |   171 |                   1 |
| Brachystomellides | Arlé, 1960                                                              |       394 | GN      |     2 |                   1 |
| Brechmorhoga      | Kirby, 1894                                                             |       307 | GN      |     2 |                   1 |
| Bredinia          | Flint, 1968                                                             |       301 | GN      |     1 |                   1 |
| Brosimum          | NA                                                                      |       315 | GN      |     8 |                   1 |
| Buenoa            | Kirkaldy, 1904                                                          |       601 | GN      |    49 |                   1 |
| Bulbochaete       | C.Agardh, 1817                                                          |       610 | GN      |     4 |                   1 |
| Bunchosia         | NA                                                                      |       563 | GN      |     1 |                   1 |
| Cabecar           | Baumgardner in Baumgardner and Ávila, 2006                              |       555 | GN      |     4 |                   1 |
| Caenis            | Stephens, 1835                                                          |       402 | GN      |    28 |                   1 |
| Calathea          | G.Mey.                                                                  |       312 | GN      |     1 |                   1 |
| Callibaetis       | Eaton, 1881                                                             |       270 | GN      |    39 |                   1 |
| Caloneis          | P.T. Cleve, 1894                                                        |       592 | GN      |     2 |                   1 |
| Calx              | Christiansen, 1958                                                      |       288 | GN      |     1 |                   1 |
| Calyptrocarya     | Nees,                                                                   |       281 | GN      |     1 |                   1 |
| Camelobaetidius   | Demoulin, 1966                                                          |       270 | GN      |     3 |                   1 |
| Camponotus        | Mayr, 1861                                                              |       500 | GN      |   100 |                   1 |
| Campsurus         | Eaton, 1868                                                             |       659 | GN      |     2 |                   1 |
| Campsurus         | \#N/D                                                                   |       659 | GN      |     1 |                   2 |
| Campylothorax     | Schött, 1893                                                            |       624 | GN      |   221 |                   1 |
| Canthidium        | NA                                                                      |       784 | GN      |   169 |                   1 |
| Canthon           | NA                                                                      |       784 | GN      |   235 |                   1 |
| Capartogramma     | H. Kufferath, 1956                                                      |       592 | GN      |    17 |                   1 |
| Cardamine         | Linneo,                                                                 |       395 | GN      |     1 |                   1 |

Displaying records 1 - 100

</div>

Para ver solo los casos problematicos, podemos utilizar eso:

``` sql
WITH a AS(
SELECT
  COALESCE(tt.subfamily,tt.family) sup,
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='GN'
), b AS(
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a.sup=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
)
SELECT * 
FROM b
WHERE b.scientific_name IN (SELECT scientific_name FROM b WHERE order_cases_in_name=2)
```

<div class="knitsql-table">

| scientific_name | scientific_name_authorship       | cd_parent | cd_rank | count | order_cases_in_name |
|:----------------|:---------------------------------|----------:|:--------|------:|--------------------:|
| Anacroneuria    | Klapálek, 1909                   |       630 | GN      |    15 |                   1 |
| Anacroneuria    | Klapálek, 1910                   |       630 | GN      |     1 |                   2 |
| Anacroneuria    | Klapálek, 1911                   |       630 | GN      |     1 |                   3 |
| Anthurium       | Schott, 1829                     |       369 | GN      |     7 |                   1 |
| Anthurium       | Schott. 1829                     |       369 | GN      |     6 |                   2 |
| Atrichopogon    | Meigen, 1830                     |       420 | GN      |    15 |                   1 |
| Atrichopogon    | Kieffer, 1906                    |       420 | GN      |     2 |                   2 |
| Campsurus       | Eaton, 1868                      |       659 | GN      |     2 |                   1 |
| Campsurus       | \#N/D                            |       659 | GN      |     1 |                   2 |
| Casearia        | Jacq. 1760                       |       686 | GN      |     1 |                   1 |
| Casearia        | NA                               |       686 | GN      |     1 |                   2 |
| Ceratopteris    | Brongn, 1822                     |       671 | GN      |     2 |                   1 |
| Ceratopteris    | Brongn. 1822                     |       671 | GN      |     1 |                   2 |
| Cernotina       | Ross, 1938                       |       325 | GN      |    17 |                   1 |
| Cernotina       | Curtis, 1835                     |       325 | GN      |     4 |                   2 |
| Culex           | Linnaeus, 1758                   |       459 | GN      |    47 |                   1 |
| Culex           | Linnaeus, 1763                   |       459 | GN      |    19 |                   2 |
| Culex           | Linnaeus, 1761                   |       459 | GN      |     1 |                   3 |
| Culex           | Linnaeus, 1762                   |       459 | GN      |     1 |                   4 |
| Culex           | Linnaeus, 1764                   |       459 | GN      |     1 |                   5 |
| Culex           | Linnaeus, 1765                   |       459 | GN      |     1 |                   6 |
| Culex           | Linnaeus, 1766                   |       459 | GN      |     1 |                   7 |
| Culex           | Linnaeus, 1768                   |       459 | GN      |     1 |                   8 |
| Culex           | Linnaeus, 1767                   |       459 | GN      |     1 |                   9 |
| Culex           | Linnaeus, 1759                   |       459 | GN      |     1 |                  10 |
| Culex           | Linnaeus, 1760                   |       459 | GN      |     1 |                  11 |
| Curicta         | Stål, 1861                       |       596 | GN      |     4 |                   1 |
| Curicta         | \#N/D                            |       596 | GN      |     3 |                   2 |
| Cynomops        | NA                               |       314 | GN      |    13 |                   1 |
| Cynomops        | Thomas, 1920                     |       314 | GN      |     9 |                   2 |
| Dasythemis      | Karsch , 1889                    |       307 | GN      |     2 |                   1 |
| Dasythemis      | Karsch, 1889                     |       307 | GN      |     1 |                   2 |
| Elakatothrix    | Wille, 1899                      |       484 | GN      |     3 |                   1 |
| Elakatothrix    | Wille, 1898                      |       484 | GN      |     1 |                   2 |
| Eleocharis      | R, Br, 1810                      |       281 | GN      |     2 |                   1 |
| Eleocharis      | R. Br. 1810                      |       281 | GN      |     1 |                   2 |
| Encyonema       | Kützing, 1834                    |       465 | GN      |    40 |                   1 |
| Encyonema       | Kützing 1844                     |       465 | GN      |     1 |                   2 |
| Gymnodinium     | F.Stein, 1878                    |       513 | GN      |     4 |                   1 |
| Gymnodinium     | F.Stein, 1879                    |       513 | GN      |     1 |                   2 |
| Gyretes         | Brullé, 1834                     |       299 | GN      |    19 |                   1 |
| Gyretes         | Brullé, 1835                     |       299 | GN      |     2 |                   2 |
| Hantzschia      | Grunow, 1877                     |       381 | GN      |     4 |                   1 |
| Hantzschia      | Grunow, 1877, nom. et typ. cons. |       381 | GN      |     1 |                   2 |
| Hemerodromia    | Say, 1823                        |       287 | GN      |     2 |                   1 |
| Hemerodromia    | Meigen, 1822                     |       287 | GN      |     1 |                   2 |
| Limnophora      | Robineau-desvoidy, 1830          |       316 | GN      |     4 |                   1 |
| Limnophora      | Robineau-desvoidy, 1831          |       316 | GN      |     1 |                   2 |
| Limnophora      | Robineau-desvoidy, 1832          |       316 | GN      |     1 |                   3 |
| Limnophora      | Robineau-desvoidy, 1833          |       316 | GN      |     1 |                   4 |
| Limnophora      | Robineau-desvoidy, 1834          |       316 | GN      |     1 |                   5 |
| Liodessus       | Leach, 1815                      |       286 | GN      |    11 |                   1 |
| Liodessus       | Guignot, 1939                    |       286 | GN      |     6 |                   2 |
| Liodessus       | Sharp, 1880                      |       286 | GN      |     2 |                   3 |
| Marilia         | Mueller, 1880                    |       608 | GN      |    41 |                   1 |
| Marilia         | Gray, 1824                       |       608 | GN      |     1 |                   2 |
| Molossus        | E. Geoffroy,1805                 |       314 | GN      |    19 |                   1 |
| Molossus        | E.Geoffroy, 1805                 |       314 | GN      |    13 |                   2 |
| Nectopsyche     | Mueller, 1879                    |       553 | GN      |    12 |                   1 |
| Nectopsyche     | Mueller, 1880                    |       553 | GN      |     1 |                   2 |
| Nectopsyche     | Mueller, 1881                    |       553 | GN      |     1 |                   3 |
| Nectopsyche     | Mueller, 1882                    |       553 | GN      |     1 |                   4 |
| Nectopsyche     | Mueller, 1883                    |       553 | GN      |     1 |                   5 |
| Neobidessus     | Young 1967                       |       286 | GN      |     2 |                   1 |
| Neobidessus     | Young, 1967                      |       286 | GN      |     2 |                   2 |
| Nymphoides      | Ség. 1754                        |       569 | GN      |     2 |                   1 |
| Nymphoides      | Ség, 1754                        |       569 | GN      |     1 |                   2 |
| Oecetis         | McLachlan, 1877                  |       553 | GN      |    27 |                   1 |
| Oecetis         | McLachlan, 1878                  |       553 | GN      |     1 |                   2 |
| Paracymus       | Thomson, 1867                    |       531 | GN      |     5 |                   1 |
| Paracymus       | NA                               |       531 | GN      |     1 |                   2 |
| Phaenonotum     | Sharp, 1882                      |       531 | GN      |     2 |                   1 |
| Phaenonotum     | Agudo, 1882                      |       531 | GN      |     2 |                   2 |
| Philodendron    | Schott, 1829                     |       369 | GN      |    16 |                   1 |
| Philodendron    | Schott. 1829                     |       369 | GN      |     9 |                   2 |
| Philodendron    | NA                               |       369 | GN      |     4 |                   3 |
| Pisidium        | L. Pfeiffer, 1821                |       648 | GN      |    49 |                   1 |
| Pisidium        | Bourguignat, 1854                |       648 | GN      |     1 |                   2 |
| Pontederia      | Linneo, 1753                     |       660 | GN      |     1 |                   1 |
| Pontederia      | Linneo. 1753                     |       660 | GN      |     1 |                   2 |
| Probezzia       | Kieffer, 1906                    |       420 | GN      |    97 |                   1 |
| Probezzia       | Grassi, 1900                     |       420 | GN      |     1 |                   2 |
| Psephenus       | Haldeman, 1853                   |       668 | GN      |    17 |                   1 |
| Psephenus       | Haldeman, 1854                   |       668 | GN      |     1 |                   2 |
| Psephenus       | Haldeman, 1855                   |       668 | GN      |     1 |                   3 |
| Rhogeessa       | H. Allen, 1866                   |       344 | GN      |    18 |                   1 |
| Rhogeessa       | H.Allen 1866                     |       344 | GN      |     3 |                   2 |
| Simulium        | Latreille, 1802                  |       702 | GN      |    13 |                   1 |
| Simulium        | (Scopoli, 1780)                  |       702 | GN      |     7 |                   2 |
| Simulium        | Scopoli, 1780                    |       702 | GN      |     3 |                   3 |
| Sturnira        | Gray, 1842                       |       323 | GN      |   168 |                   1 |
| Sturnira        | Velazco and Patterson, 2019      |       323 | GN      |     3 |                   2 |
| Suphisellus     | Crotch, 1873                     |       319 | GN      |    34 |                   1 |
| Suphisellus     | Say, 1823                        |       319 | GN      |     1 |                   2 |
| Tauriphila      | Kirby, 1889                      |       307 | GN      |    16 |                   1 |
| Tauriphila      | W. F. Kirby, 1889                |       307 | GN      |     4 |                   2 |
| Uranotaenia     | ynch Arribálzaga, 1891           |       459 | GN      |     5 |                   1 |
| Uranotaenia     | Lynch Arribálzaga, 1891          |       459 | GN      |     1 |                   2 |
| Uranotaenia     | Theobald, 1901                   |       459 | GN      |     1 |                   3 |

99 records

</div>

Para obtener la tabla por insertar:

``` sql
WITH a AS(
SELECT
  COALESCE(tt.subfamily,tt.family) sup,
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='GN'
), b AS(
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a.sup=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
)
SELECT scientific_name,scientific_name_authorship,cd_parent,cd_rank
FROM b 
WHERE order_cases_in_name=1
```

<div class="knitsql-table">

| scientific_name   | scientific_name_authorship                                              | cd_parent | cd_rank |
|:------------------|:------------------------------------------------------------------------|----------:|:--------|
| Acanthagrion      | Selys, 1876                                                             |       277 | GN      |
| Acantheremus      | NA                                                                      |       338 | GN      |
| Achnanthidium     | Kützing, 1844                                                           |       266 | GN      |
| Actinella         | Lewis, 1864                                                             |       497 | GN      |
| Actinotaenium     | Teiling, 1954                                                           |       282 | GN      |
| Acutodesmus       | (Hegewald) Tsarenko, 2001                                               |       691 | GN      |
| Adiantum          | Linneo. 1753                                                            |       671 | GN      |
| Adisianus         | Bretfeld, 2003                                                          |       272 | GN      |
| Aedeomyia         | Theobald, 1901                                                          |       459 | GN      |
| Agriogomphus      | Selys, 1869                                                             |       295 | GN      |
| Aiouea            | NA                                                                      |       305 | GN      |
| Alchornea         | NA                                                                      |       289 | GN      |
| Allophyllus       | NA                                                                      |       688 | GN      |
| Allophylus        | Linneo. 1753                                                            |       688 | GN      |
| Alluaudomyia      | Kieffer, 1913                                                           |       420 | GN      |
| Alona             | Baird, 1850                                                             |       432 | GN      |
| Amazona           | NA                                                                      |       670 | GN      |
| Ambrysus          | Stål, 1861                                                              |       591 | GN      |
| Americabaetis     | Kluge, 1992                                                             |       270 | GN      |
| Anabaena          | Bornet & Flahault, 1886                                                 |       599 | GN      |
| Anacaena          | Thomson, 1859                                                           |       531 | GN      |
| Anacroneuria      | Klapálek, 1909                                                          |       630 | GN      |
| Andaeschna        | De Marmels, 1994                                                        |       349 | GN      |
| Aneumastus        | D.G. Mann & A.J. Stickle in F.E. Round, R.M. Crawford & D.G. Mann, 1990 |       565 | GN      |
| Anisagrion        | Selys 1876                                                              |       277 | GN      |
| Anisomeridium     | NA                                                                      |       583 | GN      |
| Ankistrodesmus    | Corda, 1838                                                             |       699 | GN      |
| Annona            | NA                                                                      |       267 | GN      |
| Anodocheilus      | Babington, 1838                                                         |       286 | GN      |
| Anomoeoneis       | E. Pfitzer, 1871                                                        |       363 | GN      |
| Anopheles         | Meigen, 1818                                                            |       459 | GN      |
| Anthurium         | Schott, 1829                                                            |       369 | GN      |
| Aphanocapsa       | C.Nägeli, 1849                                                          |       570 | GN      |
| Aphylla           | Selys, 1854                                                             |       295 | GN      |
| Apobaetis         | Day, 1955                                                               |       270 | GN      |
| Arcella           | Ehrenberg, 1832                                                         |       372 | GN      |
| Argia             | Rambur, 1842                                                            |       277 | GN      |
| Arlesia           | Handschin, 1942                                                         |       318 | GN      |
| Arthothelium      | NA                                                                      |       375 | GN      |
| Arthrodesmus      | Ehrenberg ex Ralfs, 1848                                                |       282 | GN      |
| Artibeus          | Leach, 1821                                                             |       323 | GN      |
| Asplanchna        | Gosse, 1850                                                             |       376 | GN      |
| Asplenium         | Linneo,                                                                 |       377 | GN      |
| Astaena           | NA                                                                      |       773 | GN      |
| Astrothelium      | NA                                                                      |       740 | GN      |
| Astyanax          | NA                                                                      |       426 | GN      |
| Atractus          | NA                                                                      |       278 | GN      |
| Atrichopogon      | Meigen, 1830                                                            |       420 | GN      |
| Aturbina          | Lugo-Ortiz & McCafferty, 1996                                           |       270 | GN      |
| Audouinella       | Bory, 1823                                                              |       348 | GN      |
| Aulacoseira       | Thwaites, 1848                                                          |       380 | GN      |
| Austrolimnius     | Carter and Zeck, 1929                                                   |       487 | GN      |
| Azteca            | Forel, 1878                                                             |       500 | GN      |
| Bacidia           | NA                                                                      |       329 | GN      |
| Bactrospora       | NA                                                                      |       684 | GN      |
| Ballia            | Harvey, 1840                                                            |       382 | GN      |
| Bambusina         | Kützing ex Kützing, 1849                                                |       282 | GN      |
| Barybas           | NA                                                                      |       773 | GN      |
| Beauchampiella    | Remane, 1929                                                            |       495 | GN      |
| Belostoma         | Latreille, 1807                                                         |       383 | GN      |
| Berosus           | Leach, 1817                                                             |       531 | GN      |
| Bidessonotus      | Régimbart, 1895                                                         |       286 | GN      |
| Biomphalaria      | Preston, 1910                                                           |       650 | GN      |
| Bogoriella        | NA                                                                      |       740 | GN      |
| Bosmina           | Baird, 1845                                                             |       389 | GN      |
| Botryococcus      | Kützing, 1849                                                           |       390 | GN      |
| Bourletiella      | Banks, 1899                                                             |       272 | GN      |
| Brachionus        | Pallas, 1766                                                            |       392 | GN      |
| Brachymesia       | Kirby, 1889                                                             |       307 | GN      |
| Brachymetra       | Mayr, 1865                                                              |       293 | GN      |
| Brachymyrmex      | Mayr, 1868                                                              |       500 | GN      |
| Brachysira        | Kützing, 1836                                                           |       393 | GN      |
| Brachystomella    | Ågren, 1903                                                             |       394 | GN      |
| Brachystomellides | Arlé, 1960                                                              |       394 | GN      |
| Brechmorhoga      | Kirby, 1894                                                             |       307 | GN      |
| Bredinia          | Flint, 1968                                                             |       301 | GN      |
| Brosimum          | NA                                                                      |       315 | GN      |
| Buenoa            | Kirkaldy, 1904                                                          |       601 | GN      |
| Bulbochaete       | C.Agardh, 1817                                                          |       610 | GN      |
| Bunchosia         | NA                                                                      |       563 | GN      |
| Cabecar           | Baumgardner in Baumgardner and Ávila, 2006                              |       555 | GN      |
| Caenis            | Stephens, 1835                                                          |       402 | GN      |
| Calathea          | G.Mey.                                                                  |       312 | GN      |
| Callibaetis       | Eaton, 1881                                                             |       270 | GN      |
| Caloneis          | P.T. Cleve, 1894                                                        |       592 | GN      |
| Calx              | Christiansen, 1958                                                      |       288 | GN      |
| Calyptrocarya     | Nees,                                                                   |       281 | GN      |
| Camelobaetidius   | Demoulin, 1966                                                          |       270 | GN      |
| Camponotus        | Mayr, 1861                                                              |       500 | GN      |
| Campsurus         | Eaton, 1868                                                             |       659 | GN      |
| Campylothorax     | Schött, 1893                                                            |       624 | GN      |
| Canthidium        | NA                                                                      |       784 | GN      |
| Canthon           | NA                                                                      |       784 | GN      |
| Capartogramma     | H. Kufferath, 1956                                                      |       592 | GN      |
| Cardamine         | Linneo,                                                                 |       395 | GN      |
| Carollia          | Gray, 1838                                                              |       323 | GN      |
| Casearia          | Jacq. 1760                                                              |       686 | GN      |
| Catharus          | Bonaparte, 1850                                                         |       741 | GN      |
| Cecropia          | NA                                                                      |       744 | GN      |
| Celina            | Aubé, 1837                                                              |       286 | GN      |

Displaying records 1 - 100

</div>

Ahora la inserción:

``` sql
INSERT INTO main.taxo(name_tax,authorship,cd_parent,cd_rank)
WITH a AS(
SELECT
  COALESCE(tt.subfamily,tt.family) sup,
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='GN'
), b AS(
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a.sup=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
)
SELECT scientific_name,scientific_name_authorship,cd_parent,cd_rank
FROM b 
WHERE order_cases_in_name=1
RETURNING cd_tax
```

``` sql
SELECT  COALESCE(subfamily, family) sup, t.cd_tax AS cd_parent, tt.genus, 'GN' AS cd_rank, count(*)
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.taxo t ON COALESCE(subfamily, family)=t.name_tax
WHERE tt.genus IS NOT NULL AND tt.genus!=''
GROUP BY COALESCE(subfamily, family),tt.genus, t.cd_tax
ORDER BY tt.genus, count(*) DESC
```

<div class="knitsql-table">

| sup              | cd_parent | genus           | cd_rank | count |
|:-----------------|----------:|:----------------|:--------|------:|
| Fabaceae         |       290 | Abarema         | GN      |    33 |
| Coenagrionidae   |       277 | Acanthagrion    | GN      |    17 |
| Tettigoniidae    |       338 | Acantheremus    | GN      |     2 |
| Characidae       |       426 | Acestrocephalus | GN      |     2 |
| Achnanthidiaceae |       266 | Achnanthidium   | GN      |    16 |
| Amaranthaceae    |       354 | Achyranthes     | GN      |     1 |
| Melastomataceae  |       566 | Aciotis         | GN      |     1 |
| Poaceae          |       324 | Acroceras       | GN      |     7 |
| Formicidae       |       500 | Acromyrmex      | GN      |    55 |
| Formicidae       |       500 | Acropyga        | GN      |     4 |
| Eunotiaceae      |       497 | Actinella       | GN      |    24 |
| Desmidiaceae     |       282 | Actinotaenium   | GN      |     8 |
| Scolopacidae     |       696 | Actitis         | GN      |     2 |
| Scenedesmaceae   |       691 | Acutodesmus     | GN      |     3 |
| Formicidae       |       500 | Adelomyrmex     | GN      |     5 |
| Limenitidinae    |       772 | Adelpha         | GN      |   117 |
| Bignoniaceae     |       384 | Adenocalymma    | GN      |     2 |
| Pteridaceae      |       671 | Adiantum        | GN      |    15 |
| Bourletiellidae  |       272 | Adisianus       | GN      |     1 |
| Culicidae        |       459 | Aedeomyia       | GN      |     9 |
| Orphinae         |       775 | Aegidinus       | GN      |     7 |
| Lamiaceae        |       545 | Aegiphila       | GN      |     8 |
| Fabaceae         |       290 | Aeschynomene    | GN      |     1 |
| Phyllomedusidae  |       637 | Agalychnis      | GN      |     1 |
| Ardeidae         |       373 | Agamia          | GN      |     3 |
| Auchenipteridae  |       379 | Ageneiosus      | GN      |     1 |
| Gomphidae        |       295 | Agriogomphus    | GN      |    16 |
| Lauraceae        |       305 | Aiouea          | GN      |     3 |
| Euphorbiaceae    |       289 | Alchornea       | GN      |    16 |
| Euphorbiaceae    |       289 | Alchorneopsis   | GN      |     4 |
| Aromobatidae     |       374 | Allobates       | GN      |     5 |
| Graphidaceae     |       297 | Allographa      | GN      |    31 |
| Sapindaceae      |       688 | Allophyllus     | GN      |     2 |
| Sapindaceae      |       688 | Allophylus      | GN      |     1 |
| Theclinae        |       785 | Allosmaitia     | GN      |     1 |
| Ceratopogonidae  |       420 | Alluaudomyia    | GN      |    71 |
| Chydoridae       |       432 | Alona           | GN      |     2 |
| Alopoglossidae   |       353 | Alopoglossus    | GN      |     4 |
| Amaranthaceae    |       354 | Alternanthera   | GN      |     2 |
| Lecanographaceae |       548 | Alyxoria        | GN      |    91 |
| Rubiaceae        |       330 | Amaioua         | GN      |   104 |
| Amaranthaceae    |       354 | Amaranthus      | GN      |     2 |
| Trochilidae      |       737 | Amazilia        | GN      |    23 |
| Psittacidae      |       670 | Amazona         | GN      |    64 |
| Naucoridae       |       591 | Ambrysus        | GN      |    43 |
| Teiidae          |       721 | Ameiva          | GN      |   466 |
| Baetidae         |       270 | Americabaetis   | GN      |     2 |
| Bignoniaceae     |       384 | Amphilophium    | GN      |     1 |
| Amphisbaenidae   |       356 | Amphisbaena     | GN      |     1 |
| Nostocaceae      |       599 | Anabaena        | GN      |    59 |
| Hydrophilidae    |       531 | Anacaena        | GN      |     7 |
| Anacardiaceae    |       358 | Anacardium      | GN      |     1 |
| Perlidae         |       630 | Anacroneuria    | GN      |    17 |
| Nymphalinae      |       774 | Anartia         | GN      |    12 |
| Pyrginae         |       779 | Anastrus        | GN      |     2 |
| Hesperiinae      |       771 | Anatrytone      | GN      |     1 |
| Loricariidae     |       558 | Ancistrus       | GN      |    21 |
| Riodininae       |       781 | Ancyluris       | GN      |     9 |
| Aeshnidae        |       349 | Andaeschna      | GN      |     5 |
| Cichlidae        |       433 | Andinoacara     | GN      |   123 |
| Mastogloiaceae   |       565 | Aneumastus      | GN      |     4 |
| Anhingidae       |       361 | Anhinga         | GN      |     1 |
| Lauraceae        |       305 | Aniba           | GN      |     2 |
| Coenagrionidae   |       277 | Anisagrion      | GN      |     5 |
| Monoblastiaceae  |       583 | Anisomeridium   | GN      |     8 |
| Selenastraceae   |       699 | Ankistrodesmus  | GN      |    21 |
| Annonaceae       |       267 | Annona          | GN      |    11 |
| Formicidae       |       500 | Anochetus       | GN      |    35 |
| Dytiscidae       |       286 | Anodocheilus    | GN      |     5 |
| Dactyloidae      |       467 | Anolis          | GN      |   194 |
| Anomoeoneidaceae |       363 | Anomoeoneis     | GN      |     2 |
| Culicidae        |       459 | Anopheles       | GN      |    13 |
| Riodininae       |       781 | Anteros         | GN      |     1 |
| Nymphalinae      |       774 | Anthanassa      | GN      |    19 |
| Trochilidae      |       737 | Anthracothorax  | GN      |    11 |
| Araceae          |       369 | Anthurium       | GN      |    15 |
| Pyrginae         |       779 | Antigonus       | GN      |     4 |
| Rallidae         |       677 | Anurolimnas     | GN      |     1 |
| Malvaceae        |       564 | Apeiba          | GN      |     8 |
| Merismopediaceae |       570 | Aphanocapsa     | GN      |     2 |
| Gomphidae        |       295 | Aphylla         | GN      |     5 |
| Baetidae         |       270 | Apobaetis       | GN      |    33 |
| Apteronotidae    |       368 | Apteronotus     | GN      |    24 |
| Formicidae       |       500 | Apterostigma    | GN      |    13 |
| Psittacidae      |       670 | Ara             | GN      |     7 |
| Rallidae         |       677 | Aramides        | GN      |  5422 |
| Aramidae         |       371 | Aramus          | GN      |    21 |
| Theclinae        |       785 | Arawacus        | GN      |     8 |
| Theclinae        |       785 | Arcas           | GN      |     1 |
| Arcellidae       |       372 | Arcella         | GN      |   120 |
| Charaxinae       |       763 | Archaeoprepona  | GN      |    35 |
| Lejeuneaceae     |       550 | Archilejeunea   | GN      |    41 |
| Ardeidae         |       373 | Ardea           | GN      |   815 |
| Coenagrionidae   |       277 | Argia           | GN      |    33 |
| Hesperiinae      |       771 | Argon           | GN      |    13 |
| Characidae       |       426 | Argopleura      | GN      |     9 |
| Isotomidae       |       303 | Arlea           | GN      |     5 |
| Neanuridae       |       318 | Arlesia         | GN      |    72 |
| Arthoniaceae     |       375 | Arthonia        | GN      |    20 |
| Arthoniaceae     |       375 | Arthothelium    | GN      |     1 |

Displaying records 1 - 100

</div>

``` sql
INSERT INTO main.taxo(name_tax,cd_parent,cd_rank)
SELECT  tt.genus, t.cd_tax AS cd_parent, 'GN' AS cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.taxo t ON COALESCE(subfamily, family)=t.name_tax
WHERE tt.genus IS NOT NULL AND tt.genus != '' AND tt.genus NOT IN (SELECT name_tax FROM main.taxo WHERE cd_rank='GN')
GROUP BY COALESCE(subfamily, family),tt.genus, t.cd_tax
ORDER BY tt.genus, count(*) DESC
RETURNING cd_tax
```

### 3.1.10 Especies

``` sql
WITH a AS(
SELECT
  tt.genus,
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='SP'
)
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a.genus=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
```

<div class="knitsql-table">

| scientific_name             | scientific_name_authorship             | cd_parent | cd_rank | count | order_cases_in_name |
|:----------------------------|:---------------------------------------|----------:|:--------|------:|--------------------:|
| Abarema jupunba             | (Willd.) Britton & Killip              |      1422 | SP      |    31 |                   1 |
| Acestrocephalus anomalus    | (Steindachner, 1880)                   |      1423 | SP      |     2 |                   1 |
| Achyranthes aspera          | Linneo. 1753                           |      1424 | SP      |     1 |                   1 |
| Aciotis acuminifolia        | (Mart. ex DC.) Triana                  |      1425 | SP      |     1 |                   1 |
| Acroceras zizanioides       | (Kunth) Dandy, 1931                    |      1426 | SP      |     4 |                   1 |
| Acroceras zizanioides       | (Kunth) Dandy. 1931                    |      1426 | SP      |     3 |                   2 |
| Acromyrmex octospinosus     | (Reich, 1793)                          |      1427 | SP      |    55 |                   1 |
| Acropyga exsanguis          | (Wheeler, 1909)                        |      1428 | SP      |     4 |                   1 |
| Actitis macularius          | Linnaeus, 1766                         |      1429 | SP      |     2 |                   1 |
| Adelomyrmex myops           | (Wheeler, 1910)                        |      1430 | SP      |     5 |                   1 |
| Adelpha basiloides          | (H. Bates, 1865)                       |      1431 | SP      |     7 |                   1 |
| Adenocalymma aspericarpum   | (A.H. Gentry) L.G. Lohmann             |      1432 | SP      |     2 |                   1 |
| Adiantum petiolatum         | (Schumacher) DC.                       |       793 | SP      |     2 |                   1 |
| Adiantum tetraphyllum       | Humb. & Bonpl. ex Willd. 1810          |       793 | SP      |     8 |                   1 |
| Aedeomyia squamipennis      | (Lynch Arribálzaga, 1878)              |       795 | SP      |     2 |                   1 |
| Aegidinus candezei          | (Preudhomme de Borre, 1886)            |      1433 | SP      |     7 |                   1 |
| Aegiphila integrifolia      | (Jacq.) B.D.                           |      1434 | SP      |     5 |                   1 |
| Aegiphila integrifolia      | (Jacq.) B.D.Jacks.                     |      1434 | SP      |     2 |                   2 |
| Aegiphila integrifolia      | (Jacq.) B.D. Jacks.                    |      1434 | SP      |     1 |                   3 |
| Aeschynomene sensitiva      | Sw. 1788                               |      1435 | SP      |     1 |                   1 |
| Agalychnis terranova        | Rivera, Duarte, Rueda & Daza, 2013     |      1436 | SP      |     1 |                   1 |
| Agamia agami                | Gmelin, 1789                           |      1437 | SP      |     3 |                   1 |
| Ageneiosus pardalis         | Lütken, 1874                           |      1438 | SP      |     1 |                   1 |
| Alchornea glandulosa        | Poepp.                                 |       798 | SP      |    10 |                   1 |
| Alchornea triplinervia      | (Spreng.) Müll. Arg.                   |       798 | SP      |     4 |                   1 |
| Alchorneopsis floribunda    | (Benth.) Müll. Arg.                    |      1439 | SP      |     4 |                   1 |
| Allobates niputidea         | Grant, Acosta & Rada, 2007             |      1440 | SP      |     5 |                   1 |
| Allographa rhizicola        |  (Fée) Lücking & Kalb                  |      1441 | SP      |    31 |                   1 |
| Allosmaitia strophius       | (Godart, $$1824$$)                     |      1442 | SP      |     1 |                   1 |
| Alopoglossus festae         | (Peracca, 1896)                        |      1443 | SP      |     4 |                   1 |
| Alternanthera albotomentosa | (L.) Blume                             |      1444 | SP      |     1 |                   1 |
| Alternanthera albotomentosa | Suess.                                 |      1444 | SP      |     1 |                   2 |
| Alyxoria varia              | (Pers.) Ertz & Tehler                  |      1445 | SP      |    91 |                   1 |
| Amaioua glomerulata         | (Lam. ex Poir.) Delprete & C.H. Perss. |      1446 | SP      |    20 |                   1 |
| Amaioua guianensis          | Aubl.                                  |      1446 | SP      |    84 |                   1 |
| Amaranthus dubius           | Mart. ex Thell.                        |      1447 | SP      |     2 |                   1 |
| Amazilia tzacatl            | De la Llave, 1833                      |      1448 | SP      |    23 |                   1 |
| Amazona amazonica           | Linnaeus, 1766                         |       803 | SP      |    55 |                   1 |
| Amazona farinosa            | Boddaert, 1783                         |       803 | SP      |     4 |                   1 |
| Amazona ochrocephala        | Gmelin, JF, 1788                       |       803 | SP      |     1 |                   1 |
| Ameiva ameiva               | Linnaeus (1758)                        |      1449 | SP      |   225 |                   1 |
| Ameiva ameiva               | (Linnaeus, 1758)                       |      1449 | SP      |     2 |                   2 |
| Ameiva bifrontata           | Cope, 1862                             |      1449 | SP      |   239 |                   1 |
| Amphilophium crucigerum     | (L.) L.G. Lohmann                      |      1450 | SP      |     1 |                   1 |
| Amphisbaena fuliginosa      | Linnaeus, 1758                         |      1451 | SP      |     1 |                   1 |
| Anacardium excelsum         | (Bertero & Balb. ex Kunth) Skeels      |      1452 | SP      |     1 |                   1 |
| Anartia amathea             | (Linnaeus, 1758)                       |      1453 | SP      |     6 |                   1 |
| Anartia jatrophae           | (Linnaeus, 1763)                       |      1453 | SP      |     6 |                   1 |
| Anastrus neaeris            | (Möschler, 1879)                       |      1454 | SP      |     1 |                   1 |
| Anastrus neaeris            | (Möschler, 1879)                       |      1454 | SP      |     1 |                   2 |
| Anatrytone mella            | (Godman, 1900)                         |      1455 | SP      |     1 |                   1 |
| Ancistrus caucanus          | Fowler, 1943                           |      1456 | SP      |    21 |                   1 |
| Andinoacara latifrons       | (Steindachner, 1878)                   |      1458 | SP      |   123 |                   1 |
| Anhinga anhinga             | Linnaeus, 1766                         |      1459 | SP      |     1 |                   1 |
| Aniba riparia               | (Nees) Mez                             |      1460 | SP      |     2 |                   1 |
| Annona glabra               | L.                                     |       814 | SP      |     4 |                   1 |
| Annona mucosa               | Diels                                  |       814 | SP      |     4 |                   1 |
| Anochetus diegensis         | Forel, 1912                            |      1461 | SP      |    35 |                   1 |
| Anolis auratus              | (Daudin, 1802)                         |      1462 | SP      |    85 |                   1 |
| Anolis tropidogaster        | (Hallowell, 1856)                      |      1462 | SP      |   109 |                   1 |
| Anteros carausius           | Westwood, 1851                         |      1463 | SP      |     1 |                   1 |
| Anthanassa drusilla         | (C. Felder & R. Felder, 1861)          |      1464 | SP      |    19 |                   1 |
| Anthracothorax nigricollis  | Vieillot, 1817,                        |      1465 | SP      |    11 |                   1 |
| Anthurium clavigerum        | Poepp.                                 |       818 | SP      |     1 |                   1 |
| Anthurium glaucospadix      | Croat                                  |       818 | SP      |     1 |                   1 |
| Antigonus erosus            | (Hübner, $$1812$$)                     |      1466 | SP      |     4 |                   1 |
| Anurolimnas viridis         | Statius Muller, 1776                   |      1467 | SP      |     1 |                   1 |
| Apeiba glabra               | Aubl.                                  |      1468 | SP      |     7 |                   1 |
| Apeiba membranacea          | Spruce ex Benth.                       |      1468 | SP      |     1 |                   1 |
| Apteronotus mariae          | Eigenmann & Fisher, 1914               |      1469 | SP      |     2 |                   1 |
| Apteronotus milesi          | de Santana & Maldonado-Ocampo, 2005    |      1469 | SP      |    22 |                   1 |
| Apterostigma dentigerum     | Wheeler, 1925                          |      1470 | SP      |     2 |                   1 |
| Apterostigma manni          | Weber, 1938                            |      1470 | SP      |     4 |                   1 |
| Apterostigma mayri          | Forel, 1893                            |      1470 | SP      |     7 |                   1 |
| Ara ararauna                | Linnaeus, 1758                         |      1471 | SP      |     7 |                   1 |
| Aramides cajaneus           | Statius Muller, 1776                   |      1472 | SP      |  5422 |                   1 |
| Aramus guarauna             | Linnaeus, 1766                         |      1473 | SP      |    21 |                   1 |
| Arawacus lincoides          | (Draudt, 1917)                         |      1474 | SP      |     8 |                   1 |
| Arcas imperialis            | (Cramer, 1775)                         |      1475 | SP      |     1 |                   1 |
| Arcella dentata             | Ehrenberg, 1832                        |       822 | SP      |     1 |                   1 |
| Archilejeunea juliformis    | (Nees) Gradst.                         |      1477 | SP      |    41 |                   1 |
| Ardea alba                  | Linnaeus, 1758                         |      1478 | SP      |    97 |                   1 |
| Ardea alba                  | Linnaeus, 1758                         |      1478 | SP      |    36 |                   2 |
| Ardea cocoi                 | Linnaeus, 1766                         |      1478 | SP      |   682 |                   1 |
| Argon lota                  | (Hewitson, 1877)                       |      1479 | SP      |    13 |                   1 |
| Argopleura magdalenensis    | (Eigenmann, 1913)                      |      1480 | SP      |     9 |                   1 |
| Arlea lucifuga              | (Arlé, 1939) Womersley, 1939           |      1481 | SP      |     4 |                   1 |
| Arlea spinisetis            | Mendonça & Arlé, 1987                  |      1481 | SP      |     1 |                   1 |
| Arthonia catenatula         | Nyl.                                   |      1482 | SP      |     6 |                   1 |
| Arthonia platygraphidea     | Nyl.                                   |      1482 | SP      |    14 |                   1 |
| Artibeus anderseni          | (Osgood, 1916)                         |       827 | SP      |    26 |                   1 |
| Artibeus glaucus            | (Thomas, 1893)                         |       827 | SP      |     1 |                   1 |
| Artibeus jamaicensis        | Leach, 1821                            |       827 | SP      |     3 |                   1 |
| Artibeus lituratus          | (Olfers, 1818)                         |       827 | SP      |   960 |                   1 |
| Artibeus phaeotis           | Leach, 1821                            |       827 | SP      |     1 |                   1 |
| Artibeus planirostris       | (Spix, 1823)                           |       827 | SP      |    94 |                   1 |
| Artines aepitus             | (Geyer, 1832)                          |      1483 | SP      |     1 |                   1 |
| Arundinicola leucocephala   | Linnaeus, 1764                         |      1484 | SP      |     5 |                   1 |
| Ascia monuste               | (Linnaeus, 1764)                       |      1485 | SP      |     2 |                   1 |
| Asio clamator               | Vieillot, 1808                         |      1486 | SP      |     1 |                   1 |

Displaying records 1 - 100

</div>

Para ver solo los casos problematicos, podemos utilizar eso:

``` sql
WITH a AS(
SELECT
  tt.genus,
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='SP'
), b AS(
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a.genus=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
)
SELECT * 
FROM b
WHERE b.scientific_name IN (SELECT scientific_name FROM b WHERE order_cases_in_name=2)
```

<div class="knitsql-table">

| scientific_name              | scientific_name_authorship                                                 | cd_parent | cd_rank | count | order_cases_in_name |
|:-----------------------------|:---------------------------------------------------------------------------|----------:|:--------|------:|--------------------:|
| Acroceras zizanioides        | (Kunth) Dandy, 1931                                                        |      1426 | SP      |     4 |                   1 |
| Acroceras zizanioides        | (Kunth) Dandy. 1931                                                        |      1426 | SP      |     3 |                   2 |
| Aegiphila integrifolia       | (Jacq.) B.D.                                                               |      1434 | SP      |     5 |                   1 |
| Aegiphila integrifolia       | (Jacq.) B.D.Jacks.                                                         |      1434 | SP      |     2 |                   2 |
| Aegiphila integrifolia       | (Jacq.) B.D. Jacks.                                                        |      1434 | SP      |     1 |                   3 |
| Alternanthera albotomentosa  | (L.) Blume                                                                 |      1444 | SP      |     1 |                   1 |
| Alternanthera albotomentosa  | Suess.                                                                     |      1444 | SP      |     1 |                   2 |
| Ameiva ameiva                | Linnaeus (1758)                                                            |      1449 | SP      |   225 |                   1 |
| Ameiva ameiva                | (Linnaeus, 1758)                                                           |      1449 | SP      |     2 |                   2 |
| Anastrus neaeris             | (Möschler, 1879)                                                           |      1454 | SP      |     1 |                   1 |
| Anastrus neaeris             | (Möschler, 1879)                                                           |      1454 | SP      |     1 |                   2 |
| Ardea alba                   | Linnaeus, 1758                                                             |      1478 | SP      |    97 |                   1 |
| Ardea alba                   | Linnaeus, 1758                                                             |      1478 | SP      |    36 |                   2 |
| Asystasia gangetica          | (L.) T. Anderson                                                           |      1491 | SP      |     1 |                   1 |
| Asystasia gangetica          | (L.) T.Anderson                                                            |      1491 | SP      |     1 |                   2 |
| Bothrops asper               | (Garman, 1884)                                                             |      1513 | SP      |     7 |                   1 |
| Bothrops asper               | Garman, 1884                                                               |      1513 | SP      |     4 |                   2 |
| Byrsonima spicata            | (Cav.) DC.                                                                 |      1526 | SP      |   103 |                   1 |
| Byrsonima spicata            | (Cav.) Kunth                                                               |      1526 | SP      |     1 |                   2 |
| Caiman crocodilus            | (Linnaeus, 1758)                                                           |      1531 | SP      |    50 |                   1 |
| Caiman crocodilus            | Linnaeus, 1758                                                             |      1531 | SP      |    43 |                   2 |
| Calyptrocarya glomerulata    | (Brongn,) Urb, 1900                                                        |       873 | SP      |     6 |                   1 |
| Calyptrocarya glomerulata    | (Brongn.) Urb. 1900                                                        |       873 | SP      |     2 |                   2 |
| Campylorhynchus griseus      | Swainson, 1838                                                             |      1545 | SP      |   654 |                   1 |
| Campylorhynchus griseus      | Swainson, 1837                                                             |      1545 | SP      |   219 |                   2 |
| Caperonia palustris          | (L.) A. St.-Hil. 1825                                                      |      1548 | SP      |     3 |                   1 |
| Caperonia palustris          | (L,) A, St,-Hil, 1825                                                      |      1548 | SP      |     2 |                   2 |
| Caracara cheriway            | von Jacquin, 1784                                                          |      1550 | SP      |    41 |                   1 |
| Caracara cheriway            | Nikolaus Joseph von Jacquin, 1784                                          |      1550 | SP      |    25 |                   2 |
| Cephalotes columbicus        | (Forel, 1912)                                                              |       889 | SP      |    16 |                   1 |
| Cephalotes columbicus        | (Fabricius, 1804)                                                          |       889 | SP      |     1 |                   2 |
| Ceratopteris pteridoides     | (Hook,) Hieron, 1905                                                       |       893 | SP      |     3 |                   1 |
| Ceratopteris pteridoides     | (Hook.) Hieron. 1905                                                       |       893 | SP      |     2 |                   2 |
| Chironius spixii             | (Hallowell, 1845)                                                          |      1580 | SP      |     6 |                   1 |
| Chironius spixii             | Hallowell, 1845                                                            |      1580 | SP      |     1 |                   2 |
| Colinus cristatus            | Linnaeus, 1758                                                             |      1604 | SP      |    18 |                   1 |
| Colinus cristatus            | Linnaeus, 1766                                                             |      1604 | SP      |    12 |                   2 |
| Columbina talpacoti          | Temminck‎, 1810                                                             |       914 | SP      |   189 |                   1 |
| Columbina talpacoti          | Temminck, 1810                                                             |       914 | SP      |   152 |                   2 |
| Copiphora vigorosa           | Sarria-S., Buxton, Jonsson & Montealegre-Z., 2016                          |      1613 | SP      |     1 |                   1 |
| Copiphora vigorosa           | Sarria-S., K. Buxton, Jonsson & Montealegre-Z. 2016.                       |      1613 | SP      |     1 |                   2 |
| Coragyps atratus             | Bechstein, 1793                                                            |      1615 | SP      |   121 |                   1 |
| Coragyps atratus             | Linnaeus, 1758                                                             |      1615 | SP      |     1 |                   2 |
| Dorymyrmex tuberosus         | Cuezzo & Guerrero, 2012                                                    |      1677 | SP      |    75 |                   1 |
| Dorymyrmex tuberosus         | Cuezzo & Guerrero, 2011                                                    |      1677 | SP      |     1 |                   2 |
| Ectomis auginus              | (Hewitson, 1867)                                                           |      1690 | SP      |     6 |                   1 |
| Ectomis auginus              | (Hewitson, 1867)                                                           |      1690 | SP      |     1 |                   2 |
| Eptesicus brasiliensis       | (Desmarest, 1819)                                                          |       992 | SP      |     6 |                   1 |
| Eptesicus brasiliensis       | Rafinesque, 1820                                                           |       992 | SP      |     5 |                   2 |
| Erythrolamprus melanotus     | Shaw, 1802                                                                 |       995 | SP      |     2 |                   1 |
| Erythrolamprus melanotus     | (Shaw, 1802)                                                               |       995 | SP      |     1 |                   2 |
| Felis catus                  | Linnaeus, 1758                                                             |      1729 | SP      |    14 |                   1 |
| Felis catus                  | Schreber, 1775                                                             |      1729 | SP      |    10 |                   2 |
| Furnarius leucopus           | Swainson, 1837                                                             |      1738 | SP      |    98 |                   1 |
| Furnarius leucopus           | Swainson, 1838                                                             |      1738 | SP      |    76 |                   2 |
| Helicops danieli             | (Amaral, 1938)                                                             |      1769 | SP      |     9 |                   1 |
| Helicops danieli             | Amaral, 1938                                                               |      1769 | SP      |     2 |                   2 |
| Icterus nigrogularis         | Hahn, 1819                                                                 |      1802 | SP      |    85 |                   1 |
| Icterus nigrogularis         | Hahn, 1816                                                                 |      1802 | SP      |     1 |                   2 |
| Iguana iguana                | Linnaeus, 1758                                                             |      1804 | SP      |   138 |                   1 |
| Iguana iguana                | (Linnaeus, 1758)                                                           |      1804 | SP      |     7 |                   2 |
| Imantodes cenchoa            | (Linnaeus, 1758)                                                           |      1805 | SP      |    32 |                   1 |
| Imantodes cenchoa            | Linnaeus, 1758                                                             |      1805 | SP      |     5 |                   2 |
| Leonia triandra              | Cuatrec. ex L.B. Sm. & Á. Fernández                                        |      1829 | SP      |    94 |                   1 |
| Leonia triandra              | Cuatrec.                                                                   |      1829 | SP      |     4 |                   2 |
| Leonia triandra              | (Jacq.) B.D. Jacks.                                                        |      1829 | SP      |     2 |                   3 |
| Leptodeira annulata          | (Linnaeus, 1758)                                                           |      1832 | SP      |    24 |                   1 |
| Leptodeira annulata          | Linnaeus, 1758                                                             |      1832 | SP      |     2 |                   2 |
| Leptophis ahaetulla          | (Linnaeus, 1758)                                                           |      1836 | SP      |     9 |                   1 |
| Leptophis ahaetulla          | Linnaeus, 1758                                                             |      1836 | SP      |     1 |                   2 |
| Loxopholis rugiceps          | (Cope, 1869)                                                               |      1847 | SP      |   115 |                   1 |
| Loxopholis rugiceps          | Cope, 1869                                                                 |      1847 | SP      |     2 |                   2 |
| Ludwigia helminthorrhiza     | (Mart.) H. Hara, 1953                                                      |      1115 | SP      |    15 |                   1 |
| Ludwigia helminthorrhiza     | (Mart.) H. Hara. 1953                                                      |      1115 | SP      |     4 |                   2 |
| Matayba sylvatica            | (Casar.) Radlk.                                                            |      1134 | SP      |    23 |                   1 |
| Matayba sylvatica            | (Standl.) Swart                                                            |      1134 | SP      |     1 |                   2 |
| Micrasterias truncata        | Brébisson ex Ralfs, 1849                                                   |      1153 | SP      |     6 |                   1 |
| Micrasterias truncata        | Brébisson ex Ralfs 1848                                                    |      1153 | SP      |     5 |                   2 |
| Micropholis guyanensis       | Benth.                                                                     |      1157 | SP      |     4 |                   1 |
| Micropholis guyanensis       | (A. DC.) Pierre                                                            |      1157 | SP      |     2 |                   2 |
| Micrurus dumerilii           | (Jan, 1858)                                                                |      1882 | SP      |     2 |                   1 |
| Micrurus dumerilii           | Jan, 1858                                                                  |      1882 | SP      |     2 |                   2 |
| Molossops temminckii         | (Burmeister, 1854)                                                         |      1890 | SP      |    15 |                   1 |
| Molossops temminckii         | (Burmeister,1854)                                                          |      1890 | SP      |     4 |                   2 |
| Molossus molossus            | (Pallas, 1766)                                                             |      1164 | SP      |   126 |                   1 |
| Molossus molossus            | (Pallas,1766)                                                              |      1164 | SP      |   115 |                   2 |
| Molossus molossus            | E. Geoffroy, 1805                                                          |      1164 | SP      |     5 |                   3 |
| Momotus subrufescens         | Sclater, 1853                                                              |      1165 | SP      |  1249 |                   1 |
| Momotus subrufescens         | Sclater, PL, 1853                                                          |      1165 | SP      |   130 |                   2 |
| Myotis nigricans             | (Schinz, 1821)                                                             |      1175 | SP      |    73 |                   1 |
| Myotis nigricans             | Kaup, 1829                                                                 |      1175 | SP      |     6 |                   2 |
| Myotis riparius              | Kaup, 1829                                                                 |      1175 | SP      |     2 |                   1 |
| Myotis riparius              | (Rhoads, 1897)                                                             |      1175 | SP      |     1 |                   2 |
| Nyctidromus albicollis       | Gmelin, 1789                                                               |      1929 | SP      |   713 |                   1 |
| Nyctidromus albicollis       | J.F. Gmelin, 1789                                                          |      1929 | SP      |     4 |                   2 |
| Oenocarpus minor             | Mart.                                                                      |      1937 | SP      |    27 |                   1 |
| Oenocarpus minor             | Bercht. & J. Presl                                                         |      1937 | SP      |     2 |                   2 |
| Ortalis garrula              | Humboldt, 1805                                                             |      1213 | SP      |   396 |                   1 |
| Ortalis garrula              | von Humboldt, 1805                                                         |      1213 | SP      |   104 |                   2 |
| Phimosus infuscatus          | Hellmayr, 1903                                                             |      1990 | SP      |    74 |                   1 |
| Phimosus infuscatus          | Lichtenstein, 1823                                                         |      1990 | SP      |    20 |                   2 |
| Procyon cancrivorus          | Cuvier, 1798                                                               |      2030 | SP      |   441 |                   1 |
| Procyon cancrivorus          | (G. Cuvier, 1798)                                                          |      2030 | SP      |     1 |                   2 |
| Pyrrhopygopsis socrates      | (Ménétriés, 1855)                                                          |      2052 | SP      |     6 |                   1 |
| Pyrrhopygopsis socrates      | (Menetries, 1855)                                                          |      2052 | SP      |     3 |                   2 |
| Rhinella horribilis          | (Wiegmann, 1833)                                                           |      1302 | SP      |    42 |                   1 |
| Rhinella horribilis          | Wiegmann, 1833                                                             |      1302 | SP      |    16 |                   2 |
| Rhogeessa io                 | H.Allen 1866                                                               |      1306 | SP      |     9 |                   1 |
| Rhogeessa io                 | Thomas, 1903                                                               |      1306 | SP      |     5 |                   2 |
| Rhynchospora corymbosa       | (L,) Britton, 1892                                                         |      2069 | SP      |     1 |                   1 |
| Rhynchospora corymbosa       | (L.) Britton. 1892                                                         |      2069 | SP      |     1 |                   2 |
| Rupornis magnirostris        | J. F. Gmelin, 1788                                                         |      2077 | SP      |   149 |                   1 |
| Rupornis magnirostris        | Gmelin, 1788                                                               |      2077 | SP      |   142 |                   2 |
| Swartzia oraria              | Cowan                                                                      |      1364 | SP      |     8 |                   1 |
| Swartzia oraria              | Cowan.                                                                     |      1364 | SP      |     6 |                   2 |
| Syntheosciurus granatensis   | Humboldt, 1811                                                             |      2133 | SP      |  1427 |                   1 |
| Syntheosciurus granatensis   | Humboldt (1811)                                                            |      2133 | SP      |     3 |                   2 |
| Tabernaemontana markgrafiana | J.F. Macbr.                                                                |      2135 | SP      |     3 |                   1 |
| Tabernaemontana markgrafiana | H. Karst.                                                                  |      2135 | SP      |     1 |                   2 |
| Tamandua mexicana            | Saussure, 1860                                                             |      2138 | SP      |   374 |                   1 |
| Tamandua mexicana            | Saussure 1860                                                              |      2138 | SP      |     3 |                   2 |
| Tamandua mexicana            | (Saussure, 1860)                                                           |      2138 | SP      |     2 |                   3 |
| Tantilla melanocephala       | (Linnaeus, 1758)                                                           |      2141 | SP      |     5 |                   1 |
| Tantilla melanocephala       | Linnaeus, 1758                                                             |      2141 | SP      |     1 |                   2 |
| Temenis laothoe              | (Cramer, 1777)                                                             |      2151 | SP      |    47 |                   1 |
| Temenis laothoe              |  (Cramer, 1777)                                                            |      2151 | SP      |     4 |                   2 |
| Thamnophilus nigriceps       | Sclater, PL, 1869                                                          |      2156 | SP      |    90 |                   1 |
| Thamnophilus nigriceps       | Sclater, 1869                                                              |      2156 | SP      |    19 |                   2 |
| Tupinambis cryptus           | Murphy, Jowers, Lehtinen, Charles, Colli, Peres Jr., Hendry, & Pyron, 2016 |      2187 | SP      |   656 |                   1 |
| Tupinambis cryptus           | Murphy, Jowers, Lehtinen, Charles, Colli, Peres Jr, Hendry & Pyron, 2016   |      2187 | SP      |     1 |                   2 |
| Tupinambis cryptus           | Murphy, Jowers, Lehtinen, Charles, Colli, Peres JR, Hendry & Pyron, 2016   |      2187 | SP      |     1 |                   3 |
| Vareuptychia themis          | (A. Butler, 1867)                                                          |      2196 | SP      |    39 |                   1 |
| Vareuptychia themis          | (A. Buller, 1867)                                                          |      2196 | SP      |     1 |                   2 |
| Xylopia discreta             | (L.) Sprague & Hutch.                                                      |      2206 | SP      |     8 |                   1 |
| Xylopia discreta             | (L.f.) Sprague & Hutch.                                                    |      2206 | SP      |     1 |                   2 |
| Yphthimoides blanquita       | Barbosa, Marín & Freitas, 2016                                             |      2207 | SP      |    27 |                   1 |
| Yphthimoides blanquita       | E. Barbosa, M. Marín & A.V.L. Freitas, 2016                                |      2207 | SP      |    14 |                   2 |

137 records

</div>

Para obtener la tabla por insertar:

``` sql
WITH a AS(
SELECT
  tt.genus,
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='SP'
), b AS(
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a.genus=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
)
SELECT scientific_name,scientific_name_authorship,cd_parent,cd_rank
FROM b 
WHERE order_cases_in_name=1
```

<div class="knitsql-table">

| scientific_name             | scientific_name_authorship             | cd_parent | cd_rank |
|:----------------------------|:---------------------------------------|----------:|:--------|
| Abarema jupunba             | (Willd.) Britton & Killip              |      1422 | SP      |
| Acestrocephalus anomalus    | (Steindachner, 1880)                   |      1423 | SP      |
| Achyranthes aspera          | Linneo. 1753                           |      1424 | SP      |
| Aciotis acuminifolia        | (Mart. ex DC.) Triana                  |      1425 | SP      |
| Acroceras zizanioides       | (Kunth) Dandy, 1931                    |      1426 | SP      |
| Acromyrmex octospinosus     | (Reich, 1793)                          |      1427 | SP      |
| Acropyga exsanguis          | (Wheeler, 1909)                        |      1428 | SP      |
| Actitis macularius          | Linnaeus, 1766                         |      1429 | SP      |
| Adelomyrmex myops           | (Wheeler, 1910)                        |      1430 | SP      |
| Adelpha basiloides          | (H. Bates, 1865)                       |      1431 | SP      |
| Adenocalymma aspericarpum   | (A.H. Gentry) L.G. Lohmann             |      1432 | SP      |
| Adiantum petiolatum         | (Schumacher) DC.                       |       793 | SP      |
| Adiantum tetraphyllum       | Humb. & Bonpl. ex Willd. 1810          |       793 | SP      |
| Aedeomyia squamipennis      | (Lynch Arribálzaga, 1878)              |       795 | SP      |
| Aegidinus candezei          | (Preudhomme de Borre, 1886)            |      1433 | SP      |
| Aegiphila integrifolia      | (Jacq.) B.D.                           |      1434 | SP      |
| Aeschynomene sensitiva      | Sw. 1788                               |      1435 | SP      |
| Agalychnis terranova        | Rivera, Duarte, Rueda & Daza, 2013     |      1436 | SP      |
| Agamia agami                | Gmelin, 1789                           |      1437 | SP      |
| Ageneiosus pardalis         | Lütken, 1874                           |      1438 | SP      |
| Alchornea glandulosa        | Poepp.                                 |       798 | SP      |
| Alchornea triplinervia      | (Spreng.) Müll. Arg.                   |       798 | SP      |
| Alchorneopsis floribunda    | (Benth.) Müll. Arg.                    |      1439 | SP      |
| Allobates niputidea         | Grant, Acosta & Rada, 2007             |      1440 | SP      |
| Allographa rhizicola        |  (Fée) Lücking & Kalb                  |      1441 | SP      |
| Allosmaitia strophius       | (Godart, $$1824$$)                     |      1442 | SP      |
| Alopoglossus festae         | (Peracca, 1896)                        |      1443 | SP      |
| Alternanthera albotomentosa | (L.) Blume                             |      1444 | SP      |
| Alyxoria varia              | (Pers.) Ertz & Tehler                  |      1445 | SP      |
| Amaioua glomerulata         | (Lam. ex Poir.) Delprete & C.H. Perss. |      1446 | SP      |
| Amaioua guianensis          | Aubl.                                  |      1446 | SP      |
| Amaranthus dubius           | Mart. ex Thell.                        |      1447 | SP      |
| Amazilia tzacatl            | De la Llave, 1833                      |      1448 | SP      |
| Amazona amazonica           | Linnaeus, 1766                         |       803 | SP      |
| Amazona farinosa            | Boddaert, 1783                         |       803 | SP      |
| Amazona ochrocephala        | Gmelin, JF, 1788                       |       803 | SP      |
| Ameiva ameiva               | Linnaeus (1758)                        |      1449 | SP      |
| Ameiva bifrontata           | Cope, 1862                             |      1449 | SP      |
| Amphilophium crucigerum     | (L.) L.G. Lohmann                      |      1450 | SP      |
| Amphisbaena fuliginosa      | Linnaeus, 1758                         |      1451 | SP      |
| Anacardium excelsum         | (Bertero & Balb. ex Kunth) Skeels      |      1452 | SP      |
| Anartia amathea             | (Linnaeus, 1758)                       |      1453 | SP      |
| Anartia jatrophae           | (Linnaeus, 1763)                       |      1453 | SP      |
| Anastrus neaeris            | (Möschler, 1879)                       |      1454 | SP      |
| Anatrytone mella            | (Godman, 1900)                         |      1455 | SP      |
| Ancistrus caucanus          | Fowler, 1943                           |      1456 | SP      |
| Andinoacara latifrons       | (Steindachner, 1878)                   |      1458 | SP      |
| Anhinga anhinga             | Linnaeus, 1766                         |      1459 | SP      |
| Aniba riparia               | (Nees) Mez                             |      1460 | SP      |
| Annona glabra               | L.                                     |       814 | SP      |
| Annona mucosa               | Diels                                  |       814 | SP      |
| Anochetus diegensis         | Forel, 1912                            |      1461 | SP      |
| Anolis auratus              | (Daudin, 1802)                         |      1462 | SP      |
| Anolis tropidogaster        | (Hallowell, 1856)                      |      1462 | SP      |
| Anteros carausius           | Westwood, 1851                         |      1463 | SP      |
| Anthanassa drusilla         | (C. Felder & R. Felder, 1861)          |      1464 | SP      |
| Anthracothorax nigricollis  | Vieillot, 1817,                        |      1465 | SP      |
| Anthurium clavigerum        | Poepp.                                 |       818 | SP      |
| Anthurium glaucospadix      | Croat                                  |       818 | SP      |
| Antigonus erosus            | (Hübner, $$1812$$)                     |      1466 | SP      |
| Anurolimnas viridis         | Statius Muller, 1776                   |      1467 | SP      |
| Apeiba glabra               | Aubl.                                  |      1468 | SP      |
| Apeiba membranacea          | Spruce ex Benth.                       |      1468 | SP      |
| Apteronotus mariae          | Eigenmann & Fisher, 1914               |      1469 | SP      |
| Apteronotus milesi          | de Santana & Maldonado-Ocampo, 2005    |      1469 | SP      |
| Apterostigma dentigerum     | Wheeler, 1925                          |      1470 | SP      |
| Apterostigma manni          | Weber, 1938                            |      1470 | SP      |
| Apterostigma mayri          | Forel, 1893                            |      1470 | SP      |
| Ara ararauna                | Linnaeus, 1758                         |      1471 | SP      |
| Aramides cajaneus           | Statius Muller, 1776                   |      1472 | SP      |
| Aramus guarauna             | Linnaeus, 1766                         |      1473 | SP      |
| Arawacus lincoides          | (Draudt, 1917)                         |      1474 | SP      |
| Arcas imperialis            | (Cramer, 1775)                         |      1475 | SP      |
| Arcella dentata             | Ehrenberg, 1832                        |       822 | SP      |
| Archilejeunea juliformis    | (Nees) Gradst.                         |      1477 | SP      |
| Ardea alba                  | Linnaeus, 1758                         |      1478 | SP      |
| Ardea cocoi                 | Linnaeus, 1766                         |      1478 | SP      |
| Argon lota                  | (Hewitson, 1877)                       |      1479 | SP      |
| Argopleura magdalenensis    | (Eigenmann, 1913)                      |      1480 | SP      |
| Arlea lucifuga              | (Arlé, 1939) Womersley, 1939           |      1481 | SP      |
| Arlea spinisetis            | Mendonça & Arlé, 1987                  |      1481 | SP      |
| Arthonia catenatula         | Nyl.                                   |      1482 | SP      |
| Arthonia platygraphidea     | Nyl.                                   |      1482 | SP      |
| Artibeus anderseni          | (Osgood, 1916)                         |       827 | SP      |
| Artibeus glaucus            | (Thomas, 1893)                         |       827 | SP      |
| Artibeus jamaicensis        | Leach, 1821                            |       827 | SP      |
| Artibeus lituratus          | (Olfers, 1818)                         |       827 | SP      |
| Artibeus phaeotis           | Leach, 1821                            |       827 | SP      |
| Artibeus planirostris       | (Spix, 1823)                           |       827 | SP      |
| Artines aepitus             | (Geyer, 1832)                          |      1483 | SP      |
| Arundinicola leucocephala   | Linnaeus, 1764                         |      1484 | SP      |
| Ascia monuste               | (Linnaeus, 1764)                       |      1485 | SP      |
| Asio clamator               | Vieillot, 1808                         |      1486 | SP      |
| Aspidosperma desmanthum     | Benth. ex Müll. Arg.                   |      1487 | SP      |
| Astraptes enotrus           | (Stoll, 1781)                          |      1488 | SP      |
| Astrocaryum malybo          | H. Karst.                              |      1489 | SP      |
| Astrochapsa lassae          | (Mangold) Parnmen, Lücking & Lumbsch   |      1490 | SP      |
| Astrothelium megaspermum    | (Mont.) Aptroot & Lücking              |       831 | SP      |
| Astrothelium subscoria      | Flakus & Aptroot                       |       831 | SP      |
| Astyanax filiferus          | (Eigenmann, 1913)                      |       832 | SP      |

Displaying records 1 - 100

</div>

Ahora la inserción:

``` sql
INSERT INTO main.taxo(name_tax,authorship,cd_parent,cd_rank)
WITH a AS(
SELECT
  tt.genus,
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.cd_rank='SP'
), b AS(
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a.genus=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
)
SELECT scientific_name,scientific_name_authorship,cd_parent,cd_rank
FROM b 
WHERE order_cases_in_name=1
RETURNING cd_tax
```

#### 3.1.10.1 Añadir las especies que corresponden a los taxones inferiores

``` sql
SELECT tt.genus, t.cd_tax AS cd_parent, tt.genus || ' ' || tt.specific_epithet, 'SP' AS cd_rank, count(*)
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.taxo t ON tt.genus=t.name_tax
LEFT JOIN main.def_tax_rank d ON LOWER(tt.taxon_rank)=d.tax_rank_spa OR LOWER(tt.taxon_rank)=d.tax_rank
WHERE d.rank_level<10
  AND  tt.genus || ' ' || tt.specific_epithet NOT IN (SELECT name_tax FROM main.taxo WHERE cd_rank='SP')
GROUP BY tt.genus, tt.genus || ' ' || tt.specific_epithet, t.cd_tax
ORDER BY tt.genus, count(*) DESC
```

``` sql
INSERT INTO main.taxo(cd_parent,name_tax,cd_rank)
SELECT t.cd_tax AS cd_parent, tt.genus || ' ' || tt.specific_epithet, 'SP' AS cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.taxo t ON tt.genus=t.name_tax
LEFT JOIN main.def_tax_rank d ON LOWER(tt.taxon_rank)=d.tax_rank_spa OR LOWER(tt.taxon_rank)=d.tax_rank
WHERE d.rank_level<10
  AND  tt.genus || ' ' || tt.specific_epithet NOT IN (SELECT name_tax FROM main.taxo WHERE cd_rank='SP')
GROUP BY tt.genus, tt.genus || ' ' || tt.specific_epithet, t.cd_tax
ORDER BY tt.genus, count(*) DESC
RETURNING cd_tax
```

### 3.1.11 Infraespecies

``` sql
WITH a AS(
SELECT
  tt.genus || ' ' || tt.specific_epithet AS species,
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.rank_level<10
), b AS(
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a.species=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
)
SELECT * 
FROM b
```

<div class="knitsql-table">

| scientific_name                     | scientific_name_authorship    | cd_parent | cd_rank | count | order_cases_in_name |
|:------------------------------------|:------------------------------|----------:|:--------|------:|--------------------:|
| Abarema jupunba trapezifolia        | (Vahl) Barneby & J.W. Grimes  |      2214 | VAR     |     2 |                   1 |
| Adelpha barnesia leucas             | Fruhstorfer, 1915             |      3592 | SUBSP   |    39 |                   1 |
| Adelpha cytherea daguana            | Fruhstorfer, 1913             |      3593 | SUBSP   |    36 |                   1 |
| Adelpha iphiclus iphiclus           | (Linnaeus, 1758)              |      3594 | SUBSP   |    26 |                   1 |
| Adelpha melona deborah              | Weeks, 1901                   |      3596 | SUBSP   |     2 |                   1 |
| Adelpha phylaca pseudaethalia       | A. Hall, 1938                 |      3595 | SUBSP   |     5 |                   1 |
| Adelpha salmoneus emilia            | Fruhstorfer, 1908             |      3597 | SUBSP   |     2 |                   1 |
| Ancyluris jurgensenii atahualpa     | (Saunders, 1859)              |      3598 | SUBSP   |     9 |                   1 |
| Archaeoprepona demophon muson       | (Fruhstorfer, 1905)           |      3599 | SUBSP   |    27 |                   1 |
| Archaeoprepona demophoon gulina     | (Fruhstorfer, 1904)           |      3600 | SUBSP   |     8 |                   1 |
| Bactris gasipaes chichagui          | (H. Karst.) A.J. Hend.        |      3601 | VAR     |     3 |                   1 |
| Baeotis zonata zonata               | R. Felder, 1869               |      3602 | SUBSP   |     2 |                   1 |
| Caligo idomeneus idomenides         | Fruhstorfer, 1903             |      3606 | SUBSP   |     1 |                   1 |
| Caligo illioneus oberon             | A. Butler, 1870               |      3603 | SUBSP   |    23 |                   1 |
| Caligo oedipus oedipus              | Stichel, 1903                 |      3604 | SUBSP   |    10 |                   1 |
| Caligo telamonius menus             | Fruhstorfer, 1903             |      3605 | SUBSP   |     9 |                   1 |
| Catoblepia berecynthia luxuriosus   | Stichel, 1902                 |      3607 | SUBSP   |     3 |                   1 |
| Catonephele numilia esite           | (R. Felder, 1869)             |      3608 | SUBSP   |    10 |                   1 |
| Chiothion asychis simon             | (Evans, 1953)                 |      3609 | SUBSP   |     1 |                   1 |
| Consul fabius bogotanus             | (A. Butler, 1874)             |      3610 | SUBSP   |    15 |                   1 |
| Dryas iulia iulia                   | (Fabricius, 1775)             |      3611 | SUBSP   |    16 |                   1 |
| Emesis fatimella nobilata           | Stichel, 1910                 |      3612 | SUBSP   |     6 |                   1 |
| Eresia eunice mechanitis            | Godman & Salvin, 1878         |      3613 | SUBSP   |    32 |                   1 |
| Eueides isabella arquata            | Stichel, 1903                 |      3615 | SUBSP   |     2 |                   1 |
| Eueides lybia olympia               | (Fabricius, 1793)             |      3614 | SUBSP   |    10 |                   1 |
| Eunica mygdonia mygdonia            | (Godart, $$1824$$)            |      3616 | SUBSP   |     1 |                   1 |
| Euptychia westwoodi westwoodi       | Butler, 1867                  |      3617 | SUBSP   |     2 |                   1 |
| Eurema agave agave                  | (Cramer, 1775)                |      3619 | SUBSP   |     2 |                   1 |
| Eurema arbela gratiosa              | (E. Doubleday, 1847)          |      3618 | SUBSP   |     3 |                   1 |
| Eurema daira lydia                  | (C. Felder & R. Felder, 1861) |      3620 | SUBSP   |     1 |                   1 |
| Gallus gallus domesticus            | Linnaeus, 1758                |      3621 | SUBSP   |     1 |                   1 |
| Gorgythion begga pyralina           | (Möschler, 1877)              |      3622 | SUBSP   |     4 |                   1 |
| Hamadryas amphinome fumosa          | (Fruhstorfer, 1915)           |      3624 | SUBSP   |    33 |                   1 |
| Hamadryas februa ferentina          | (Godart, $$1824$$)            |      3625 | SUBSP   |     1 |                   1 |
| Hamadryas feronia farinulenta       | (Fruhstorfer, 1916)           |      3623 | SUBSP   |   100 |                   1 |
| Hamadryas feronia farinulenta       | farinulenta                   |      3623 | SUBSP   |     1 |                   2 |
| Heliconius charithonia bassleri     | W. Comstock & F. Brown, 1950  |      3631 | SUBSP   |     2 |                   1 |
| Heliconius erato hydara             | (Hewitson, 1867)              |      3627 | SUBSP   |    45 |                   1 |
| Heliconius erato hydara             | Hewitson, 1867                |      3627 | SUBSP   |     1 |                   2 |
| Heliconius hecale melicerta         | H. Bates, 1866                |      3628 | SUBSP   |    36 |                   1 |
| Heliconius ismenius boulleti        | Neustetter, 1928              |      3630 | SUBSP   |     1 |                   1 |
| Heliconius ismenius ismenius        | Latreille, $$1817$$           |      3630 | SUBSP   |     6 |                   1 |
| Heliconius sapho sapho              | (Drury, 1782)                 |      3629 | SUBSP   |     8 |                   1 |
| Heliconius sara magdalena           | H. Bates, 1864                |      3626 | SUBSP   |   160 |                   1 |
| Hemiargus hanno bogotana            | Draudt, 1921                  |      3632 | SUBSP   |     1 |                   1 |
| Heraclides anchisiades idaeus       | (Fabricius, 1793)             |      3634 | SUBSP   |     1 |                   1 |
| Heraclides thoas nealces            | (Rothschild & Jordan, 1906)   |      3633 | SUBSP   |     7 |                   1 |
| Historis odius dious                | Lamas, 1995                   |      3635 | SUBSP   |    48 |                   1 |
| Itaballia demophile calydonia       | (Boisduval, 1836)             |      3636 | SUBSP   |     1 |                   1 |
| Mechanitis polymnia veritabilis     | A. Butler, 1873               |      3637 | SUBSP   |    24 |                   1 |
| Memphis acidalia memphis            | (C. Felder & R. Felder, 1867) |      3639 | SUBSP   |     3 |                   1 |
| Memphis moruus phila                | (H. Druce, 1877)              |      3638 | SUBSP   |     6 |                   1 |
| Morpho helenor peleides             | Kollar, 1850                  |      3640 | SUBSP   |    23 |                   1 |
| Mysoria barcastus venezuelae        | (Scudder, 1872)               |      3641 | SUBSP   |     2 |                   1 |
| Notheme erota diadema               | Stichel, 1910                 |      3642 | SUBSP   |     4 |                   1 |
| Nyctelius nyctelius nyctelius       | (Latreille, $$1824$$)         |      3643 | SUBSP   |     4 |                   1 |
| Nymphidium caricae trinidadi        | Callaghan, 1999               |      3644 | SUBSP   |    12 |                   1 |
| Opsiphanes cassina periphetes       | Fruhstorfer, 1912             |      3645 | SUBSP   |   365 |                   1 |
| Opsiphanes quiteria badius          | Stichel, 1902                 |      3646 | SUBSP   |     9 |                   1 |
| Ouleus fridericus fridericus        | (Geyer, 1832)                 |      3647 | SUBSP   |     1 |                   1 |
| Panoquina ocola ocola               | (W. H. Edwards, 1863)         |      3648 | SUBSP   |     1 |                   1 |
| Parides erithalion erithalion       | (Boisduval, 1836)             |      3650 | SUBSP   |     2 |                   1 |
| Parides sesostris tarquinius        | (Boisduval, 1836)             |      3649 | SUBSP   |     5 |                   1 |
| Paryphthimoides poltys numilia      | (C. Felder & R. Felder, 1867) |      3651 | SUBSP   |    13 |                   1 |
| Perrhybris pamela bogotana          | (A. Butler, 1898)             |      3652 | SUBSP   |     2 |                   1 |
| Phoebis trite trite                 | (Linnaeus, 1758)              |      3653 | SUBSP   |     1 |                   1 |
| Pierella luna luna                  | (Fabricius, 1793)             |      3654 | SUBSP   |    10 |                   1 |
| Porphyrogenes calathana calathana   | (Hewitson, 1868)              |      3655 | SUBSP   |     2 |                   1 |
| Prepona laertes amesia              | Fruhstorfer, 1905             |      3656 | SUBSP   |     8 |                   1 |
| Prepona laertes louisa              | A. Butler, 1870               |      3656 | SUBSP   |     8 |                   1 |
| Pyrrhogyra crameri undine           | Bargmann, 1929                |      3657 | SUBSP   |    20 |                   1 |
| Pyrrhogyra neaerea kheili           | Fruhstorfer, 1908             |      3658 | SUBSP   |    16 |                   1 |
| Pyrrhopyge phidias latifasciata     | A. Butler, 1873               |      3660 | SUBSP   |     2 |                   1 |
| Pyrrhopyge thericles pseudophidias  | E. Bell, 1931                 |      3659 | SUBSP   |     5 |                   1 |
| Quadrus contubernalis contubernalis | (Mabille, 1883)               |      3661 | SUBSP   |     1 |                   1 |
| Selenophanes josephus excultus      | Stichel, 1902                 |      3662 | SUBSP   |    15 |                   1 |
| Siproeta stelenes biplagiata        | (Fruhstorfer, 1907)           |      3663 | SUBSP   |     2 |                   1 |
| Stalachtis magdalena magdalena      | (Westwood, $$1851$$)          |      3664 | SUBSP   |    26 |                   1 |
| Symmachia leena leena               | Hewitson, 1870                |      3665 | SUBSP   |     1 |                   1 |
| Telegonus anaphus annetta           | (Evans, 1952)                 |      3666 | SUBSP   |     4 |                   1 |
| Telemiades antiope antiope          | (Plötz, 1882)                 |      3667 | SUBSP   |     1 |                   1 |
| Thracides cleanthes telmela         | (Hewitson, 1866)              |      3668 | SUBSP   |     8 |                   1 |

82 records

</div>

``` sql
WITH a AS(
SELECT
  tt.genus || ' ' || tt.specific_epithet AS species,
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.rank_level<10
), b AS(
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a.species=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
)
SELECT * 
FROM b
WHERE b.scientific_name IN (SELECT scientific_name FROM b WHERE order_cases_in_name=2)
```

<div class="knitsql-table">

| scientific_name               | scientific_name_authorship | cd_parent | cd_rank | count | order_cases_in_name |
|:------------------------------|:---------------------------|----------:|:--------|------:|--------------------:|
| Hamadryas feronia farinulenta | (Fruhstorfer, 1916)        |      3623 | SUBSP   |   100 |                   1 |
| Hamadryas feronia farinulenta | farinulenta                |      3623 | SUBSP   |     1 |                   2 |
| Heliconius erato hydara       | (Hewitson, 1867)           |      3627 | SUBSP   |    45 |                   1 |
| Heliconius erato hydara       | Hewitson, 1867             |      3627 | SUBSP   |     1 |                   2 |

4 records

</div>

``` sql
INSERT INTO main.taxo(name_tax,authorship,cd_parent,cd_rank)
WITH a AS(
SELECT
  tt.genus || ' ' || tt.specific_epithet AS species,
  tt.scientific_name,
  CASE 
    WHEN tt.scientific_name_authorship='' THEN NULL
    ELSE tt.scientific_name_authorship
  END scientific_name_authorship,
  dtr.cd_rank
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.def_tax_rank dtr ON LOWER(tt.taxon_rank)=dtr.tax_rank_spa OR LOWER(tt.taxon_rank)=dtr.tax_rank
WHERE dtr.rank_level<10
), b AS(
SELECT a.scientific_name, a.scientific_name_authorship, t.cd_tax AS cd_parent, a.cd_rank,count(*), ROW_NUMBER() OVER (PARTITION BY a.scientific_name ORDER BY count(*) DESC) AS order_cases_in_name
FROM a
LEFT JOIN main.taxo t ON a.species=t.name_tax
GROUP BY a.scientific_name, a.scientific_name_authorship,a.cd_rank,t.cd_tax
ORDER BY a.scientific_name, count(*) DESC
)
SELECT scientific_name,scientific_name_authorship,cd_parent,cd_rank 
FROM b
WHERE order_cases_in_name=1
```

# 4 Analyse of the taxonomic database

Examples of taxa

``` sql
SELECT *
FROM main.taxo
ORDER BY random()
LIMIT 10
```

<div class="knitsql-table">

| cd_tax | name_tax           | authorship               | cd_rank | cd_parent |
|-------:|:-------------------|:-------------------------|:--------|----------:|
|    207 | Oxalidales         | NA                       | OR      |        34 |
|   1243 | Phaeographis       | NA                       | GN      |       297 |
|   2026 | Prepona            | NA                       | GN      |       763 |
|    374 | Aromobatidae       | NA                       | FAM     |       108 |
|   2520 | Coenogonium linkii | Ehrenb.                  | SP      |       911 |
|   2140 | Tangara            | NA                       | GN      |       725 |
|    433 | Cichlidae          | NA                       | FAM     |       121 |
|    116 | Asterales          | NA                       | OR      |        34 |
|   2506 | Closterium gracile | Brébisson ex Ralfs, 1848 | SP      |       906 |
|   1092 | Lasiurus           | Gray,1831                | GN      |       344 |

10 records

</div>

Rangos representados en la base de datos

``` sql
SELECT cd_rank,count(*)
FROM main.taxo t
LEFT JOIN main.def_tax_rank USING (cd_rank)
GROUP BY rank_level,cd_rank
ORDER BY rank_level
```

<div class="knitsql-table">

| cd_rank | count |
|:--------|------:|
| VAR     |     2 |
| SUBSP   |    78 |
| SP      |  1455 |
| GN      |  1427 |
| TR      |     1 |
| SFAM    |    32 |
| FAM     |   489 |
| SOR     |     1 |
| OR      |   185 |
| CL      |    48 |
| PHY     |    24 |
| KG      |     6 |

12 records

</div>

Rangos superiores en la base de datos

``` sql
SELECT t.cd_rank AS "rank child", tp.cd_rank AS "rank parent",count(*) AS number
FROM main.taxo t
LEFT JOIN main.taxo tp ON t.cd_parent=tp.cd_tax
LEFT JOIN main.def_tax_rank d ON t.cd_rank=d.cd_rank
GROUP BY t.cd_rank,tp.cd_rank,d.rank_level
ORDER BY rank_level
```

<div class="knitsql-table">

| rank child | rank parent | number |
|:-----------|:------------|-------:|
| VAR        | SP          |      2 |
| SUBSP      | SP          |     78 |
| SP         | GN          |   1455 |
| GN         | FAM         |   1228 |
| GN         | SFAM        |    199 |
| TR         | FAM         |      1 |
| SFAM       | FAM         |     32 |
| FAM        | OR          |    489 |
| SOR        | OR          |      1 |
| OR         | CL          |    185 |
| CL         | PHY         |     48 |
| PHY        | KG          |     24 |
| KG         | NA          |      6 |

13 records

</div>

# 5 Dar codigos taxonomicos a cada fila de la tabla taxonomica total

``` sql
WITH a AS(
SELECT table_orig,"row.names", t.cd_tax
FROM raw_dwc.taxonomy_total tt
LEFT JOIN main.taxo t ON tt.scientific_name=t.name_tax
)
SELECT table_orig,"row.names",count(*)
FROM a
GROUP BY table_orig,"row.names"
HAVING count(*)!=1
```

<div class="knitsql-table">

table_orig row.names count ———— ———– ——-

: 0 records

</div>

``` sql
ALTER TABLE raw_dwc.taxonomy_total
ADD COLUMN IF NOT EXISTS cd_tax int REFERENCES main.taxo(cd_tax) ON DELETE SET NULL ON UPDATE CASCADE;
UPDATE raw_dwc.taxonomy_total AS tt
SET cd_tax=t.cd_tax
FROM main.taxo t
WHERE tt.scientific_name=t.name_tax
RETURNING tt.cd_tax;
```

<div class="knitsql-table">

| cd_tax |
|-------:|
|   2939 |
|   2617 |
|   2617 |
|   2617 |
|   2939 |
|   2696 |
|   2696 |
|   2696 |
|   2696 |
|   2339 |
|   3395 |
|   2696 |
|   2550 |
|   2550 |
|   2617 |
|   2550 |
|   2939 |
|   2617 |
|   2617 |
|   2339 |
|   2550 |
|   2550 |
|   3394 |
|   2550 |
|   2550 |
|   2939 |
|   2623 |
|   3233 |
|   2623 |
|   3233 |
|   2623 |
|   2623 |
|   2623 |
|   2623 |
|   2623 |
|   2623 |
|   3233 |
|   2550 |
|   2550 |
|   2550 |
|   2550 |
|   3394 |
|   2696 |
|   2922 |
|   2340 |
|   2696 |
|   2920 |
|   2920 |
|   2550 |
|   3394 |
|   2550 |
|   2696 |
|   3394 |
|   2696 |
|   2922 |
|   2920 |
|   2920 |
|   3347 |
|   2617 |
|   2617 |
|   3394 |
|   2550 |
|   2939 |
|   2939 |
|   3416 |
|   3416 |
|   3289 |
|   2550 |
|   2550 |
|   2920 |
|   2696 |
|   3395 |
|   3348 |
|   2696 |
|   2696 |
|   2696 |
|   2696 |
|   2696 |
|   2696 |
|   2696 |
|   2339 |
|   2339 |
|   2920 |
|   2922 |
|   2339 |
|   2623 |
|   2920 |
|   2920 |
|   2922 |
|   2623 |
|   2623 |
|   2623 |
|   2623 |
|   2623 |
|   2623 |
|   2623 |
|   2920 |
|   2339 |
|   2339 |
|   2920 |

Displaying records 1 - 100

</div>

``` sql
UPDATE raw_dwc.taxonomy_total tt
SET cd_tax=t.cd_tax
FROM main.taxo t
WHERE tt.cd_tax IS NULL AND tt.scientific_name IS NULL AND COALESCE(tt.genus,tt.subfamily,tt.family,tt."order",tt.class, tt.phylum,tt.kingdom)=t.name_tax;
```

# 6 Manejo de las morfo especies

``` r
SQL <- "ALTER TABLE raw_dwc.taxonomy_total
ADD COLUMN IF NOT EXISTS cd_morfo int REFERENCES main.morfo_taxo(cd_morfo) ON DELETE SET NULL ON UPDATE CASCADE"
dbSendQuery(fracking_db, SQL)
```

    ## <PostgreSQLResult>

## 6.1 Arboreos (botanica)

Esperar la respuesta del Whatsapp, para el caso de los cf.

> Estoy tratando de codificar las morfoespecies… En botanica, hay
> especies que corresponden a especies… Con nuestro criterio actual
> quiere decir que el “nivel taxonomica” de la morfoespecie sería
> subespecie, pero me da la impresion que no es lo que quisieran decir
> los expertos… lo problematico de eso es que afectaron las especies en
> scientificName, cuando solo son cf.

Ejemplo:

``` sql
SELECT scientific_name, identification_qualifier, identification_remarks
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE table_orig='botanica_registros_arborea' AND rank_level=10 AND identification_qualifier IS NOT NULL
```

<div class="knitsql-table">

| scientific_name           | identification_qualifier | identification_remarks                        |
|:--------------------------|:-------------------------|:----------------------------------------------|
| Tapirira guianensis       | cf. Tapirira             | cf. Tapirira (N.C Goyo mojoso)                |
| Schefflera morototoni     | cf. Morototoni           | Schefflera cf. morototoni (N.C mano de tigre) |
| Tapirira guianensis       | cf. Tapirira             | cf. Tapirira (N.C Goyo mojoso)                |
| Tapirira guianensis       | cf. Tapirira             | cf. Tapirira (N.C Goyo mojoso)                |
| Tapirira guianensis       | cf. Tapirira             | cf. Tapirira (N.C Goyo mojoso)                |
| Tapirira guianensis       | cf. Tapirira             | cf. Tapirira (N.C Goyo mojoso)                |
| Schefflera morototoni     | cf. morototoni           | Schefflera cf. morototoni                     |
| Tapirira guianensis       | cf. guianensis           | Tapirira cf. guianensis N.C Fresno            |
| Xylopia aromatica         | cf. aromatica            | Xylopia cf. aromatica (N.C Escobillo)         |
| Chrysophyllum colombianum | cf. colombianum          | N.C Coco cristal                              |
| Schefflera morototoni     | cf. morototoni           | Schefflera cf. morototoni                     |
| Xylopia aromatica         | cf. aromatica            | Xylopia cf. aromatica                         |
| Xylopia aromatica         | cf. aromatica            | Xylopia cf. aromatica                         |
| Eschweilera coriacea      | cf. coriacea             | Lecythis 1                                    |
| Matayba elegans           | cf. elegans              | Matayba 1                                     |
| Matayba elegans           | cf. elegans              | Matayba 1                                     |
| Ormosia colombiana        | cf. colombiana           | \_                                            |
| Couepia chrysocalyx       | cf. chrysocalyx          | \_                                            |
| Couepia chrysocalyx       | cf. chrysocalyx          | \_                                            |
| Couepia chrysocalyx       | cf. chrysocalyx          | \_                                            |
| Couepia chrysocalyx       | cf. chrysocalyx          | \_                                            |
| Ficus francoae            | cf. francoae             | Exudado blanco claro. Corteza rugosa          |
| Eschweilera coriacea      | cf. coriacea             | NC Coco                                       |
| Pouteria trilocularis     | cf. trilocularis         | \_                                            |
| Pouteria trilocularis     | cf. trilocularis         | Exudado blanco                                |
| Herrania nitida           | cf. nitida               | Cacao de monte                                |
| Herrania nitida           | cf. nitida               | Cacao de monte                                |
| Herrania nitida           | cf. nitida               | Cacao de monte                                |
| Herrania nitida           | cf. nitida               | Cacao de monte                                |
| Pouteria trilocularis     | cf. trilocularis         | Látexblanco. Corteza amarilla                 |
| Rinorea falcata           | cf. falcata              | \_                                            |
| Eschweilera coriacea      | cf. coriacea             | NC: Coco                                      |
| Ficus citrifolia          | cf. citrifolia           | Ficus sp                                      |
| Matayba elegans           | cf. elegans              | \_                                            |
| Matayba elegans           | cf. elegans              | \_                                            |
| Eschweilera coriacea      | cf. coriacea             | Forófito 3                                    |
| Eschweilera coriacea      | cf. coriacea             | \_                                            |
| Citrus aurantium          | Híbrido                  | Critrus sp Toronja                            |
| Citrus aurantium          | Híbrido                  | Critrus sp Toronja                            |
| Matayba elegans           | cf. elegans              | Mamoncillo                                    |
| Citrus aurantium          | Híbrido                  | Citrus sp Toronja                             |
| Citrus aurantium          | Híbrido                  | Citrus sp Toronja                             |
| Citrus aurantium          | Híbrido                  | Citrus sp Toronja                             |
| Citrus aurantium          | Híbrido                  | Citrus sp Toronja                             |
| Eschweilera coriacea      | cf. coriacea             | \_                                            |
| Matayba elegans           | cf. elegans              | \_                                            |
| Matayba elegans           | cf. elegans              | \_                                            |
| Ficus citrifolia          | cf. citrifolia           | Corteza roja. Látex blanco                    |
| Ficus citrifolia          | cf. citrifolia           | Látex blanco                                  |
| Jacaranda caucana         | cf obtusifolia           | Jacaranda cf obtusifolia                      |
| Xylopia aromatica         | cf amazonica             | Xylopia cf amazonica                          |
| Eschweilera coriacea      | cf. coriacea             | \_                                            |
| Eschweilera coriacea      | cf. coriacea             | \_                                            |
| Pourouma bicolor          | cf melinonii             | Pourouma cf melinonii                         |
| Pourouma bicolor          | cf melinonii             | Pourouma cf melinonii                         |
| Pourouma bicolor          | cf melinonii             | Pourouma cf melinonii                         |
| Eschweilera coriacea      | cf. coriacea             | \_                                            |
| Pouteria amygdalicarpa    | cf. amygdalicarpa        | \_                                            |
| Jacaranda copaia          | cf Jacaranda             | Cabobira cf Jacaranda                         |
| Tapirira guianensis       | cf. Tapirira             | Cf Tapirira                                   |
| Pouteria amygdalicarpa    | cf. amygdalicarpa        | \_                                            |
| Pouteria amygdalicarpa    | cf. amygdalicarpa        | \_                                            |
| Leonia racemosa           | cf. racemosa             | Corteza amarilla                              |
| Leonia racemosa           | cf. racemosa             | Margen dentada                                |
| Leonia racemosa           | cf. racemosa             | Margen dentada                                |
| Pouteria trilocularis     | cf. trilocularis         | Exudado blanco.                               |
| Hirtella americana        | cf. americana            | Corteza amarilla                              |
| Hirtella americana        | cf. americana            | Aromatica                                     |
| Pouteria trilocularis     | cf. trilocularis         | Estípula ferrugínea y leche                   |
| Xylopia aromatica         | cf amazonica             | Xylopia cf amazonica Copillo 1                |
| Gustavia dubia            | cf. dubia                | Saliaceae Peciolo alado                       |
| Gustavia dubia            | cf. dubia                | Peciolo alado                                 |
| Gustavia dubia            | cf. dubia                | Peciolo alado                                 |
| Cecropia peltata          | cf peltata               | Cecropia cf peltata                           |
| Cecropia peltata          | cf peltata               | Cecropia cf peltata                           |
| Cecropia peltata          | cf peltata               | Cecropia cf peltata                           |
| Ficus matiziana           | cf maliziana             | Ficus cf maliziana                            |
| Jacaranda caucana         | cf. obtusifolia          | Jacaranda cf. obtusifolia                     |
| Pouteria trilocularis     | cf. trilocularis         | Pouteria sp                                   |
| Tapirira guianensis       | cf. Tapirira             | cf. Tapirira (N.C Goyo mojoso)                |
| Xylopia aromatica         | cf. aromatica            | Xilopia cf. aromatica                         |
| Chrysophyllum colombianum | cf. colombianum          | N.C Coco cristal                              |
| Gustavia verticillata     | cf. verticillata         | Indeterminado                                 |
| Chrysophyllum colombianum | cf. colombianum          | N.C Coco cristal                              |
| Tapirira guianensis       | cf. Tapirira             | cf. Tapirira (N.C Goyo mojoso)                |
| Schefflera morototoni     | cf. morototoni           | Schefflera cf. morototoni                     |
| Schefflera morototoni     | cf. morototoni           | Schefflera cf. morototoni (N.C Mano de león)  |
| Tapirira guianensis       | cf. Tapirira             | cf. Trapira (N.C Fresno)                      |
| Tapirira guianensis       | cf. Tapirira             | cf. Trapira (N.C Fresno)                      |
| Pouteria trilocularis     | cf. trilocularis         | NA                                            |
| Lacmellea edulis          | cf. edulis               | Lacmellea cf. edulis                          |
| Eschweilera coriacea      | cf. coriacea             | NA                                            |
| Eschweilera coriacea      | cf. coriacea             | NA                                            |
| Lacmellea edulis          | cf. edulis               | Lacmellea cf. edulis                          |
| Schefflera morototoni     | cf. morototoni           | Schefflera cf. morototoni                     |
| Lacmellea edulis          | cf. edulis               | Lacmellea cf. edulis                          |
| Chrysophyllum colombianum | cf. colombianum          | Pouteria sp                                   |
| Chrysophyllum colombianum | cf. colombianum          | Pouteria sp                                   |
| Eschweilera coriacea      | cf. coriacea             | Lecythis sp                                   |
| Caryocar amygdaliferum    | cf amygdaliferum         | Caryocar cf amygdaliferum                     |

Displaying records 1 - 100

</div>

Existen tambien generos que tienen sp. 1 etc

``` sql
SELECT cd_tax, scientific_name, identification_qualifier,
  CASE
    WHEN identification_remarks='_' THEN NULL
    ELSE identification_remarks
  END identification_remarks,
  cd_rank rank_tax,
  CASE
    WHEN cd_rank='GN' THEN 'SP'
    WHEN cd_rank='FAM' THEN 'GN'
    WHEN cd_rank='CL' THEN 'OR'
  END pseudo_rank
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE table_orig='botanica_registros_arborea' AND rank_level>10 AND identification_qualifier IS NOT NULL
```

<div class="knitsql-table">

| cd_tax | scientific_name | identification_qualifier | identification_remarks                          | rank_tax | pseudo_rank |
|-------:|:----------------|:-------------------------|:------------------------------------------------|:---------|:------------|
|     34 | Magnoliopsida   | sp. 4                    | NA                                              | CL       | OR          |
|   1074 | Inga            | sp. 4                    | Guamo                                           | GN       | SP          |
|   1009 | Ficus           | sp. 1                    | Ficus                                           | GN       | SP          |
|   1009 | Ficus           | sp. 1                    | Ficus                                           | GN       | SP          |
|   1009 | Ficus           | sp. 1                    | Ficus                                           | GN       | SP          |
|   1074 | Inga            | sp. 4                    | N.C Guamo                                       | GN       | SP          |
|   1040 | Helicostylis    | sp. 1                    | N.C Yema de huevo                               | GN       | SP          |
|   1212 | Ormosia         | sp. 1                    | N.C yema de huevo                               | GN       | SP          |
|   1212 | Ormosia         | sp. 1                    | Indet.                                          | GN       | SP          |
|     34 | Magnoliopsida   | sp. 1                    | Annona sp.                                      | CL       | OR          |
|     34 | Magnoliopsida   | sp. 2                    | cf. Guazuma (N.C Guacimo)                       | CL       | OR          |
|   1074 | Inga            | sp. 4                    | Inga sp.                                        | GN       | SP          |
|   1074 | Inga            | sp. 1                    | N.C Guamo blanco                                | GN       | SP          |
|   1074 | Inga            | sp. 1                    | N.C Guamo blanco                                | GN       | SP          |
|   1074 | Inga            | sp. 2                    | Inga sp.                                        | GN       | SP          |
|   1074 | Inga            | sp. 2                    | Inga sp.                                        | GN       | SP          |
|   1074 | Inga            | sp. 2                    | Inga sp.                                        | GN       | SP          |
|   1074 | Inga            | sp. 2                    | Inga sp.                                        | GN       | SP          |
|   1074 | Inga            | sp. 1                    | Guamo blanco                                    | GN       | SP          |
|   1074 | Inga            | sp. 1                    | Guamo blanco                                    | GN       | SP          |
|   1074 | Inga            | sp. 2                    | Inga sp.                                        | GN       | SP          |
|   1074 | Inga            | sp. 2                    | Inga sp.                                        | GN       | SP          |
|   1074 | Inga            | sp. 1                    | Guamo blanco                                    | GN       | SP          |
|   1074 | Inga            | sp. 1                    | Guamo blanco                                    | GN       | SP          |
|   1074 | Inga            | sp. 2                    | Guamo negro                                     | GN       | SP          |
|   1028 | Gustavia        | sp. 1                    | Exudado blanco                                  | GN       | SP          |
|   1074 | Inga            | sp. 1                    | Inga sp                                         | GN       | SP          |
|    305 | Lauraceae       | sp. 4                    | NA                                              | FAM      | GN          |
|   1134 | Matayba         | sp. 1                    | NA                                              | GN       | SP          |
|   1134 | Matayba         | sp. 1                    | Con muestra                                     | GN       | SP          |
|    918 | Cordia          | sp. 2                    | NA                                              | GN       | SP          |
|    863 | Brosimum        | sp. 1                    | Exudado blanco                                  | GN       | SP          |
|    863 | Brosimum        | sp. 1                    | NA                                              | GN       | SP          |
|     34 | Magnoliopsida   | sp. 3                    | R. tabloides látex café con leche               | CL       | OR          |
|    863 | Brosimum        | sp. 1                    | Látex blanco                                    | GN       | SP          |
|   1278 | Protium         | sp. 1                    | Látex café con leche                            | GN       | SP          |
|     34 | Magnoliopsida   | sp. 4                    | NA                                              | CL       | OR          |
|     34 | Magnoliopsida   | sp. 4                    | NA                                              | CL       | OR          |
|    863 | Brosimum        | sp. 1                    | NA                                              | GN       | SP          |
|   1091 | Lacmellea       | sp. 1                    | Byrsomma                                        | GN       | SP          |
|   1091 | Lacmellea       | sp. 1                    | Byrsomma                                        | GN       | SP          |
|    863 | Brosimum        | sp. 1                    | Con látex                                       | GN       | SP          |
|     34 | Magnoliopsida   | sp. 4                    | NA                                              | CL       | OR          |
|   1311 | Salacia         | sp. 1                    | NA                                              | GN       | SP          |
|    330 | Rubiaceae       | sp. 4                    | NA                                              | FAM      | GN          |
|     34 | Magnoliopsida   | sp. 5                    | Hojas largas suaves con flores                  | CL       | OR          |
|     34 | Magnoliopsida   | sp. 5                    | Hojas largas con flores.                        | CL       | OR          |
|     34 | Magnoliopsida   | sp. 5                    | Hojas largas con flores.                        | CL       | OR          |
|     34 | Magnoliopsida   | sp. 5                    | Hojas largas con flores.                        | CL       | OR          |
|   1223 | Palicourea      | sp. 2                    | NA                                              | GN       | SP          |
|    330 | Rubiaceae       | sp. 10                   | NA                                              | FAM      | GN          |
|     34 | Magnoliopsida   | sp. 6                    | Látex transparente                              | CL       | OR          |
|     34 | Magnoliopsida   | sp. 6                    | NA                                              | CL       | OR          |
|     34 | Magnoliopsida   | sp. 7                    | NA                                              | CL       | OR          |
|    986 | Endlicheria     | sp. 1                    | NA                                              | GN       | SP          |
|   1229 | Parkia          | sp. 1                    | NA                                              | GN       | SP          |
|   1278 | Protium         | sp. 1                    | NA                                              | GN       | SP          |
|   1229 | Parkia          | sp. 1                    | NA                                              | GN       | SP          |
|   1074 | Inga            | sp. 1                    | Inga sp                                         | GN       | SP          |
|   1278 | Protium         | sp. 1                    | Violaceae ?                                     | GN       | SP          |
|   1254 | Piper           | sp. 2                    | Piper                                           | GN       | SP          |
|   1254 | Piper           | sp. 2                    | Piper                                           | GN       | SP          |
|   1254 | Piper           | sp. 2                    | Piper                                           | GN       | SP          |
|   1254 | Piper           | sp. 2                    | Piper                                           | GN       | SP          |
|   1254 | Piper           | sp. 2                    | Piper                                           | GN       | SP          |
|   1254 | Piper           | sp. 2                    | Piper                                           | GN       | SP          |
|   1254 | Piper           | sp. 2                    | Piper                                           | GN       | SP          |
|   1254 | Piper           | sp. 2                    | Piper                                           | GN       | SP          |
|   1254 | Piper           | sp. 2                    | Piper                                           | GN       | SP          |
|   1254 | Piper           | sp. 2                    | Piper                                           | GN       | SP          |
|   1254 | Piper           | sp. 2                    | Piper                                           | GN       | SP          |
|   1254 | Piper           | sp. 2                    | Piper                                           | GN       | SP          |
|    986 | Endlicheria     | sp. 1                    | NA                                              | GN       | SP          |
|   1254 | Piper           | sp. 2                    | Piper                                           | GN       | SP          |
|   1254 | Piper           | sp. 2                    | Piper                                           | GN       | SP          |
|   1254 | Piper           | sp. 2                    | Piper                                           | GN       | SP          |
|    885 | Cecropia        | sp. 1                    | Cecropia peltata                                | GN       | SP          |
|   1091 | Lacmellea       | sp. 1                    | f3                                              | GN       | SP          |
|    289 | Euphorbiaceae   | sp. 4                    | f1                                              | FAM      | GN          |
|   1254 | Piper           | sp. 2                    | NA                                              | GN       | SP          |
|    885 | Cecropia        | sp. 1                    | Cecropia                                        | GN       | SP          |
|    885 | Cecropia        | sp. 1                    | Cecropia                                        | GN       | SP          |
|    885 | Cecropia        | sp. 1                    | Cecropia                                        | GN       | SP          |
|   1254 | Piper           | sp. 2                    | Piper                                           | GN       | SP          |
|    797 | Aiouea          | sp. 2                    | Corteza amarilla                                | GN       | SP          |
|    799 | Allophyllus     | sp. 1                    | Corteza amarilla                                | GN       | SP          |
|   1278 | Protium         | sp. 1                    | Prunus? Corteza amarilla                        | GN       | SP          |
|    799 | Allophyllus     | sp. 1                    | Trifoliada olor agradable                       | GN       | SP          |
|   1200 | Ocotea          | sp. 3                    | NA                                              | GN       | SP          |
|    305 | Lauraceae       | sp. 9                    | Hojas aromáticas Corteza lisa                   | FAM      | GN          |
|   1057 | Hieronyma       | sp. 1                    | Hojas aromáticas . Olor a pimienta              | GN       | SP          |
|   1057 | Hieronyma       | sp. 1                    | Hojas aromáticas. Corteza lisa. Olor a pimienta | GN       | SP          |
|   1057 | Hieronyma       | sp. 1                    | Hojas aromáticas. Corteza lisa. Olor a pimienta | GN       | SP          |
|   1057 | Hieronyma       | sp. 1                    | Hojas aromáticas. Corteza lisa. Olor a pimienta | GN       | SP          |
|   1057 | Hieronyma       | sp. 1                    | Hojas aromáticas. Corteza lisa. Olor a pimienta | GN       | SP          |
|   1057 | Hieronyma       | sp. 1                    | Hojas aromáticas. Corteza lisa. Olor a pimienta | GN       | SP          |
|   1057 | Hieronyma       | sp. 1                    | Hojas aromáticas. Corteza lisa. Olor a pimienta | GN       | SP          |
|   1057 | Hieronyma       | sp. 1                    | Hojas aromáticas. Corteza lisa. Olor a pimienta | GN       | SP          |
|   1057 | Hieronyma       | sp. 1                    | Hojas aromáticas. Corteza lisa. Olor a pimienta | GN       | SP          |
|    290 | Fabaceae        | sp. 1                    | Jacaranda Corteza escamosa                      | FAM      | GN          |

Displaying records 1 - 100

</div>

``` sql
INSERT INTO main.morfo_taxo(cd_gp_biol, cd_tax, name_morfo, pseudo_rank, description)
WITH a AS(
SELECT cd_tax, scientific_name, identification_qualifier,
  CASE
    WHEN identification_remarks IN ('_','-') THEN NULL
    ELSE identification_remarks
  END identification_remarks,
  cd_rank rank_tax,
  CASE
    WHEN cd_rank='GN' THEN 'SP'
    WHEN cd_rank='FAM' THEN 'GN'
    WHEN cd_rank='CL' THEN 'OR'
  END pseudo_rank
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE table_orig='botanica_registros_arborea' AND rank_level>10 AND identification_qualifier IS NOT NULL
)
SELECT 'arbo', cd_tax, identification_qualifier,pseudo_rank,STRING_AGG(DISTINCT identification_remarks, ' | ')
FROM a
GROUP BY pseudo_rank, cd_tax, identification_qualifier, scientific_name
ORDER BY scientific_name, identification_qualifier
RETURNING cd_morfo
```

``` sql
UPDATE raw_dwc.taxonomy_total AS tt
SET cd_morfo=m.cd_morfo
FROM main.morfo_taxo m
WHERE tt.table_orig='botanica_registros_arborea' AND tt.cd_tax=m.cd_tax AND tt.identification_qualifier=m.name_morfo
RETURNING tt.cd_morfo
```

## 6.2 Epifitas vasculares

``` sql
SELECT cd_tax, scientific_name, identification_qualifier, 
  CASE
    WHEN cd_rank='GN' THEN 'SP'
    ELSE 'ERROR_RANK'
  END pseudo_rank, count(*)
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE table_orig='botanica_registros_epi_vas' AND identification_qualifier IS NOT NULL
GROUP BY cd_tax,scientific_name,identification_qualifier,cd_rank
```

<div class="knitsql-table">

| cd_tax | scientific_name | identification_qualifier | pseudo_rank | count |
|-------:|:----------------|:-------------------------|:------------|------:|
|   1169 | Monstera        | sp. 1                    | SP          |    12 |
|   1247 | Philodendron    | sp. 1                    | SP          |     4 |

2 records

</div>

``` sql
INSERT INTO main.morfo_taxo(cd_gp_biol,cd_tax,name_morfo,pseudo_rank)
SELECT 'epva',cd_tax, identification_qualifier, 
  CASE
    WHEN cd_rank='GN' THEN 'SP'
    ELSE 'ERROR_RANK'
  END pseudo_rank
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE table_orig='botanica_registros_epi_vas' AND identification_qualifier IS NOT NULL
GROUP BY cd_tax,scientific_name,identification_qualifier,cd_rank
RETURNING cd_tax
```

``` sql
UPDATE raw_dwc.taxonomy_total AS tt
SET cd_morfo=m.cd_morfo
FROM main.morfo_taxo m
WHERE tt.table_orig='botanica_registros_epi_vas' AND tt.cd_tax=m.cd_tax AND tt.identification_qualifier=m.name_morfo
RETURNING tt.cd_morfo
```

## 6.3 Epifitas no vasculares

``` sql
SELECT cd_tax, scientific_name, identification_qualifier, identification_remarks,
  CASE
    WHEN cd_rank='GN' THEN 'SP'
    ELSE 'ERROR_RANK'
  END pseudo_rank, cd_rank, count(*)
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE table_orig='botanica_registros_epi_novas' AND (identification_qualifier IS NOT NULL OR identification_remarks IS NOT NULL)
GROUP BY cd_tax,scientific_name,identification_qualifier,identification_remarks,cd_rank
ORDER BY scientific_name
```

<div class="knitsql-table">

| cd_tax | scientific_name          | identification_qualifier | identification_remarks                                                           | pseudo_rank | cd_rank | count |
|-------:|:-------------------------|:-------------------------|:---------------------------------------------------------------------------------|:------------|:--------|------:|
|   2238 | Allographa rhizicola     |                          | \-                                                                               | ERROR_RANK  | SP      |    15 |
|   2238 | Allographa rhizicola     |                          | M10                                                                              | ERROR_RANK  | SP      |     3 |
|   2238 | Allographa rhizicola     |                          | M20                                                                              | ERROR_RANK  | SP      |     2 |
|   2238 | Allographa rhizicola     |                          | M22                                                                              | ERROR_RANK  | SP      |     2 |
|   2238 | Allographa rhizicola     |                          | Talo blanco con lirelas delgadas y negras muy evidentes                          | ERROR_RANK  | SP      |     1 |
|   2238 | Allographa rhizicola     |                          | Talo blanquecino con lirelas abundantes y delgadas negras                        | ERROR_RANK  | SP      |     1 |
|   2238 | Allographa rhizicola     |                          | Talo blanquecino, lirelas cortas y dispersas                                     | ERROR_RANK  | SP      |     1 |
|   2238 | Allographa rhizicola     |                          | Talo café claro con lirelas negras prominentes                                   | ERROR_RANK  | SP      |     1 |
|   2238 | Allographa rhizicola     |                          | Talo café claro y lirelas negras                                                 | ERROR_RANK  | SP      |     1 |
|   2238 | Allographa rhizicola     |                          | Talo café colaro de lirelas alargadas negras                                     | ERROR_RANK  | SP      |     1 |
|   2238 | Allographa rhizicola     |                          | Talo café con lirelas negras                                                     | ERROR_RANK  | SP      |     1 |
|   2238 | Allographa rhizicola     |                          | Talo color crema con lirelas inmersas grises                                     | ERROR_RANK  | SP      |     1 |
|   2238 | Allographa rhizicola     |                          | Talo verde claro con lirelas largas, negras y dispersas                          | ERROR_RANK  | SP      |     1 |
|   2242 | Alyxoria varia           |                          | \-                                                                               | ERROR_RANK  | SP      |    35 |
|   2242 | Alyxoria varia           |                          | M14                                                                              | ERROR_RANK  | SP      |     5 |
|   2242 | Alyxoria varia           |                          | M22                                                                              | ERROR_RANK  | SP      |     1 |
|   2242 | Alyxoria varia           |                          | M7                                                                               | ERROR_RANK  | SP      |     8 |
|   2242 | Alyxoria varia           |                          | M9                                                                               | ERROR_RANK  | SP      |     2 |
|   2242 | Alyxoria varia           |                          | Talo amarillento con lirelas negras                                              | ERROR_RANK  | SP      |     1 |
|   2242 | Alyxoria varia           |                          | Talo cafe a veces verde pulveroso con lirelas cortas y pequeñas negras.          | ERROR_RANK  | SP      |     1 |
|   2242 | Alyxoria varia           |                          | Talo café oscuro con lirelas negras                                              | ERROR_RANK  | SP      |     1 |
|   2242 | Alyxoria varia           |                          | Talo café poco diferenciado con lirelas negras prominentes                       | ERROR_RANK  | SP      |     1 |
|   2242 | Alyxoria varia           |                          | Talo café poco diferenciado de corteza con lirelas negras, cortas y pronunciadas | ERROR_RANK  | SP      |     1 |
|   2242 | Alyxoria varia           |                          | Talo color crema con lirelas negras                                              | ERROR_RANK  | SP      |     3 |
|   2242 | Alyxoria varia           |                          | Talo color crema con lirelas negras pequeñas y dispersas                         | ERROR_RANK  | SP      |     1 |
|   2242 | Alyxoria varia           |                          | Talo color crema poco diferenciado con lirelas cortas y negras                   | ERROR_RANK  | SP      |     1 |
|   2242 | Alyxoria varia           |                          | Talo naranja con estructuras negras                                              | ERROR_RANK  | SP      |     1 |
|   2242 | Alyxoria varia           |                          | Talo verde claro con lirelas negras y abundantes                                 | ERROR_RANK  | SP      |     1 |
|   2242 | Alyxoria varia           |                          | Talo verde con lirelas negras cortas y pequeñas                                  | ERROR_RANK  | SP      |     1 |
|   2242 | Alyxoria varia           |                          | Talo verde con lirelas negras evidentes                                          | ERROR_RANK  | SP      |     1 |
|   2242 | Alyxoria varia           |                          | Talo verde manzana con lirelas negras gruesas                                    | ERROR_RANK  | SP      |     1 |
|   2242 | Alyxoria varia           |                          | Talo verde oscuro con lirelas negras                                             | ERROR_RANK  | SP      |     1 |
|   2242 | Alyxoria varia           |                          | Talo verde oscuro polveruloso con estructuras negras alargadas                   | ERROR_RANK  | SP      |     1 |
|   2242 | Alyxoria varia           |                          | Talo verde poco diferenciado de la corteza con estructuras negras                | ERROR_RANK  | SP      |     1 |
|   2242 | Alyxoria varia           |                          | Talo verde pulveroso con lirelas negras                                          | ERROR_RANK  | SP      |     1 |
|   2242 | Alyxoria varia           |                          | NA                                                                               | ERROR_RANK  | SP      |    21 |
|    812 | Anisomeridium            | sp. 1                    | M8                                                                               | SP          | GN      |     4 |
|    812 | Anisomeridium            | sp. 1                    | Talo color crema polvoroso con estructuras negras                                | SP          | GN      |     1 |
|    812 | Anisomeridium            | sp. 1                    | NA                                                                               | SP          | GN      |     3 |
|   2288 | Archilejeunea juliformis |                          | \-                                                                               | ERROR_RANK  | SP      |     8 |
|   2288 | Archilejeunea juliformis |                          | Hepatica foliosa de hojas verdes                                                 | ERROR_RANK  | SP      |     1 |
|   2288 | Archilejeunea juliformis |                          | Hepática foliosa verde                                                           | ERROR_RANK  | SP      |     1 |
|   2288 | Archilejeunea juliformis |                          | Hépatica verde de hojas alargadas (Ricardia (?))                                 | ERROR_RANK  | SP      |     1 |
|   2288 | Archilejeunea juliformis |                          | M11                                                                              | ERROR_RANK  | SP      |     1 |
|   2288 | Archilejeunea juliformis |                          | M12                                                                              | ERROR_RANK  | SP      |    17 |
|   2288 | Archilejeunea juliformis |                          | M16                                                                              | ERROR_RANK  | SP      |     1 |
|   2288 | Archilejeunea juliformis |                          | M27                                                                              | ERROR_RANK  | SP      |     3 |
|   2288 | Archilejeunea juliformis |                          | M7                                                                               | ERROR_RANK  | SP      |     2 |
|   2288 | Archilejeunea juliformis |                          | M8                                                                               | ERROR_RANK  | SP      |     2 |
|   2288 | Archilejeunea juliformis |                          | NA                                                                               | ERROR_RANK  | SP      |     4 |
|   2295 | Arthonia catenatula      |                          | \-                                                                               | ERROR_RANK  | SP      |     4 |
|   2295 | Arthonia catenatula      |                          | Talo grisaceo muy similar a corteza                                              | ERROR_RANK  | SP      |     1 |
|   2295 | Arthonia catenatula      |                          | Talo gris con paquetes de lirelas marrón                                         | ERROR_RANK  | SP      |     1 |
|   2296 | Arthonia platygraphidea  |                          | \-                                                                               | ERROR_RANK  | SP      |     8 |
|   2296 | Arthonia platygraphidea  |                          | M15                                                                              | ERROR_RANK  | SP      |     1 |
|   2296 | Arthonia platygraphidea  |                          | M17                                                                              | ERROR_RANK  | SP      |     1 |
|   2296 | Arthonia platygraphidea  |                          | M19                                                                              | ERROR_RANK  | SP      |     1 |
|   2296 | Arthonia platygraphidea  |                          | Talo amarillo verdoso con estructuras negras pequeñas                            | ERROR_RANK  | SP      |     1 |
|   2296 | Arthonia platygraphidea  |                          | Talo verde oscuro polveruloso                                                    | ERROR_RANK  | SP      |     1 |
|   2296 | Arthonia platygraphidea  |                          | Talo verde pulveruloso con apoteicos vinotinto                                   | ERROR_RANK  | SP      |     1 |
|    825 | Arthothelium             | sp. 1                    | Talo blanco de borde y apoteicos negros                                          | SP          | GN      |     1 |
|      7 | Ascomycota               | sp. 1                    | \-                                                                               | ERROR_RANK  | PHY     |    26 |
|      7 | Ascomycota               | sp. 1                    | M18                                                                              | ERROR_RANK  | PHY     |     5 |
|      7 | Ascomycota               | sp. 1                    | Talo grisaceo con soradios verde claro                                           | ERROR_RANK  | PHY     |     1 |
|      7 | Ascomycota               | sp. 1                    | Talo gris oscruo con estructuras color crema pequeñas                            | ERROR_RANK  | PHY     |     1 |
|      7 | Ascomycota               | sp. 1                    | Talo verde grisáceo con soradios verde claro                                     | ERROR_RANK  | PHY     |     1 |
|      7 | Ascomycota               | sp. 1                    | Talo verde militar con sorelios verde militar                                    | ERROR_RANK  | PHY     |     1 |
|      7 | Ascomycota               | sp. 1                    | Talo verde oscuro pulverulosa con estructuras negras                             | ERROR_RANK  | PHY     |     1 |
|      7 | Ascomycota               | sp. 1                    | Talo verde pulveruloso                                                           | ERROR_RANK  | PHY     |     1 |
|      7 | Ascomycota               | sp. 1                    | Tilo color crema para diferenciado con estive\*\* negras                         | ERROR_RANK  | PHY     |     1 |
|      7 | Ascomycota               | sp. 1                    | NA                                                                               | ERROR_RANK  | PHY     |    15 |
|      7 | Ascomycota               | sp. 10                   | M4                                                                               | ERROR_RANK  | PHY     |     1 |
|      7 | Ascomycota               | sp. 11                   | M6                                                                               | ERROR_RANK  | PHY     |     6 |
|      7 | Ascomycota               | sp. 12                   | M11                                                                              | ERROR_RANK  | PHY     |     6 |
|      7 | Ascomycota               | sp. 13                   | M19                                                                              | ERROR_RANK  | PHY     |     6 |
|      7 | Ascomycota               | sp. 14                   | M20                                                                              | ERROR_RANK  | PHY     |     2 |
|      7 | Ascomycota               | sp. 15                   | \-                                                                               | ERROR_RANK  | PHY     |    11 |
|      7 | Ascomycota               | sp. 15                   | Talo verde grisáceo con soradios verde claro                                     | ERROR_RANK  | PHY     |     1 |
|      7 | Ascomycota               | sp. 16                   | \-                                                                               | ERROR_RANK  | PHY     |     9 |
|      7 | Ascomycota               | sp. 16                   | Talo verde oscuro aveces café con estructuras negras                             | ERROR_RANK  | PHY     |     1 |
|      7 | Ascomycota               | sp. 17                   | M2                                                                               | ERROR_RANK  | PHY     |     5 |
|      7 | Ascomycota               | sp. 18                   | M8                                                                               | ERROR_RANK  | PHY     |     2 |
|      7 | Ascomycota               | sp. 19                   | Talo verde oscuro poco diferenciado con apotecios amarillentos                   | ERROR_RANK  | PHY     |     1 |
|      7 | Ascomycota               | sp. 2                    | \-                                                                               | ERROR_RANK  | PHY     |     3 |
|      7 | Ascomycota               | sp. 20                   | \-                                                                               | ERROR_RANK  | PHY     |     6 |
|      7 | Ascomycota               | sp. 20                   | Talo verde oscuro pulveruloso                                                    | ERROR_RANK  | PHY     |     1 |
|      7 | Ascomycota               | sp. 21                   | M23                                                                              | ERROR_RANK  | PHY     |     1 |
|      7 | Ascomycota               | sp. 22                   | M7                                                                               | ERROR_RANK  | PHY     |     3 |
|      7 | Ascomycota               | sp. 23                   | M9                                                                               | ERROR_RANK  | PHY     |     2 |
|      7 | Ascomycota               | sp. 24                   | M11                                                                              | ERROR_RANK  | PHY     |     2 |
|      7 | Ascomycota               | sp. 25                   | M25                                                                              | ERROR_RANK  | PHY     |     1 |
|      7 | Ascomycota               | sp. 26                   | M29                                                                              | ERROR_RANK  | PHY     |     2 |
|      7 | Ascomycota               | sp. 27                   | M19                                                                              | ERROR_RANK  | PHY     |     1 |
|      7 | Ascomycota               | sp. 28                   | M14                                                                              | ERROR_RANK  | PHY     |     1 |
|      7 | Ascomycota               | sp. 29                   | \-                                                                               | ERROR_RANK  | PHY     |     1 |
|      7 | Ascomycota               | sp. 29                   | Talo crema poco diferenciado de superficie con apotecios negros                  | ERROR_RANK  | PHY     |     1 |
|      7 | Ascomycota               | sp. 3                    | Talo café claro con estructuras diminutas negras                                 | ERROR_RANK  | PHY     |     1 |
|      7 | Ascomycota               | sp. 30                   | \-                                                                               | ERROR_RANK  | PHY     |    39 |
|      7 | Ascomycota               | sp. 30                   | M10                                                                              | ERROR_RANK  | PHY     |     1 |
|      7 | Ascomycota               | sp. 30                   | M11                                                                              | ERROR_RANK  | PHY     |     9 |

Displaying records 1 - 100

</div>

Anotar:

- identification_remarks da morfospecies M1, M2, M3 etc
- identification_qualifier da morfospecies de tipo sp1, sp2 etc.
- a veces hay más de un M1, M2 etc por un mismo sp1, sp2 etc.
- en identification_qualifier hay tambien descripción de las
  caracteristicas biologicas que permitieron la identificación, incluso
  cuando la identificación se hace a nivel de especie.
- a veces se ponen un M1, M2 sobre una identificación a nivel de especie

Entonces lo que voy a hacer por ahora es:

- solo considerar morfo-taxones para los niveles de taxones superior a
  especie
- solo considerar los sp1 sp2 o M1 M2, ninguna de las descripciones dara
  un morfo-taxon
- considerar todas las asociaciones unicas entre sp y M como
  morfo-taxones diferentes

**A confirmar** : es posible que solo los tipos sp1, sp2 etc tengan
valor de morfo-taxon: los M1 M2 etc pueden ser los resultados del
trabajo de identificación sin tener ningun valor despues de la
identificación del scientificName.

``` sql
INSERT INTO main.morfo_taxo (cd_gp_biol,cd_tax, name_morfo, verbatim_taxon, pseudo_rank)
WITH a AS(
SELECT cd_tax, scientific_name, identification_qualifier, identification_remarks,
  CASE
    WHEN cd_rank='GN' THEN 'SP'
    WHEN cd_rank='FAM' THEN 'GN'
    WHEN cd_rank='OR' THEN 'FAM'
    WHEN cd_rank='CL' THEN 'OR'
    WHEN cd_rank='PHY' THEN 'CL'
    WHEN cd_rank='KG' THEN 'PHY'
    ELSE 'ERROR_RANK'
  END pseudo_rank,
  cd_rank,
  CASE
    WHEN identification_qualifier ~ '^sp.' THEN identification_qualifier
    ELSE NULL
  END morfo_sp,
  CASE
    WHEN identification_remarks ~ '^M[0-9]+' THEN identification_remarks
    ELSE NULL
  END morfo_m,
  count(*)
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE rank_level>10 AND table_orig='botanica_registros_epi_novas' AND (identification_qualifier IS NOT NULL OR identification_remarks IS NOT NULL)
GROUP BY cd_tax,scientific_name,identification_qualifier,identification_remarks,cd_rank
ORDER BY scientific_name
), b AS(
SELECT cd_tax, 
  CASE 
    WHEN morfo_sp IS NOT NULL AND morfo_m IS NOT NULL THEN morfo_sp || ' (' || morfo_m || ')'
    WHEN morfo_sp IS NOT NULL AND morfo_m IS NULL THEN morfo_sp
    WHEN morfo_sp IS NULL AND morfo_m IS NOT NULL THEN morfo_m
    ELSE NULL
  END name_morfo,
  scientific_name || ' ' || morfo_sp verbatim_taxon,
  pseudo_rank
FROM a 
WHERE morfo_sp IS NOT NULL OR morfo_m IS NOT NULL
)
SELECT 'epnv',*
FROM b
GROUP BY cd_tax,name_morfo, verbatim_taxon, pseudo_rank

RETURNING cd_morfo
;
```

``` sql
WITH a AS(
SELECT
  table_orig,"row.names",
  'epnv' AS cd_gp_biol,
  cd_tax,
  CASE
    WHEN identification_qualifier ~ '^sp.' THEN identification_qualifier
    ELSE NULL
  END morfo_sp,
  CASE
    WHEN identification_remarks ~ '^M[0-9]+' THEN identification_remarks
    ELSE NULL
  END morfo_m
FROM raw_dwc.taxonomy_total
WHERE table_orig='botanica_registros_epi_novas'
),b AS (
SELECT table_orig,"row.names",
  cd_gp_biol,
  cd_tax, 
  CASE 
    WHEN morfo_sp IS NOT NULL AND morfo_m IS NOT NULL THEN morfo_sp || ' (' || morfo_m || ')'
    WHEN morfo_sp IS NOT NULL AND morfo_m IS NULL THEN morfo_sp
    WHEN morfo_sp IS NULL AND morfo_m IS NOT NULL THEN morfo_m
    ELSE NULL
  END name_morfo
FROM a
),c AS (
SELECT 
  table_orig,"row.names",cd_morfo
FROM b
JOIN main.morfo_taxo USING(name_morfo,cd_gp_biol,cd_tax)
)
UPDATE raw_dwc.taxonomy_total AS tt
SET cd_morfo=c.cd_morfo
FROM c
WHERE tt.table_orig=c.table_orig AND tt."row.names"=c."row.names"
RETURNING tt.cd_morfo;
```

<div class="knitsql-table">

| cd_morfo |
|---------:|
|      171 |
|      136 |
|      171 |
|      152 |
|      160 |
|      160 |
|      160 |
|      152 |
|      160 |
|      128 |
|      160 |
|      170 |
|      183 |
|      165 |
|      172 |
|      202 |
|      149 |
|      172 |
|      203 |
|      157 |
|      203 |
|      172 |
|      164 |
|      203 |
|      202 |
|      166 |
|      203 |
|      172 |
|      157 |
|      201 |
|      170 |
|      171 |
|      171 |
|      171 |
|      131 |
|      159 |
|      159 |
|      159 |
|      171 |
|      171 |
|      131 |
|      171 |
|      159 |
|      171 |
|      170 |
|      171 |
|      171 |
|      171 |
|      171 |
|      139 |
|      139 |
|      132 |
|      132 |
|      132 |
|      139 |
|      159 |
|      132 |
|      133 |
|      216 |
|      193 |
|      216 |
|      216 |
|      136 |
|      215 |
|      136 |
|      215 |
|      215 |
|      215 |
|      136 |
|      137 |
|      137 |
|      136 |
|      207 |
|      207 |
|      177 |
|      225 |
|      225 |
|      148 |
|      171 |
|      171 |
|      171 |
|      171 |
|      171 |
|      225 |
|      133 |
|      225 |
|      225 |
|      132 |
|      132 |
|      225 |
|      225 |
|      225 |
|      169 |
|      179 |
|      179 |
|      179 |
|      179 |
|      194 |
|      194 |
|      179 |

Displaying records 1 - 100

</div>

## 6.4 Colémbolos

**Algunos morfos tienen el mismo numero pero conciernen taxones
diferentes (scientificName diferentes). ¿Será un error?**

``` sql
SELECT cd_tax, scientific_name, identification_qualifier, identification_remarks,
  CASE
    WHEN cd_rank='GN' THEN 'SP'
    WHEN cd_rank='FAM' THEN 'GN'
    WHEN cd_rank='OR' THEN 'FAM'
    WHEN cd_rank='CL' THEN 'OR'
    WHEN cd_rank='PHY' THEN 'CL'
    WHEN cd_rank='KG' THEN 'PHY'
    ELSE 'ERROR_RANK'
  END pseudo_rank,
  cd_rank,
  count(*)
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE /*rank_level>10 AND*/ table_orig='collembolos_registros' AND (identification_qualifier IS NOT NULL OR identification_remarks IS NOT NULL)
GROUP BY cd_tax,scientific_name,identification_qualifier,identification_remarks,cd_rank
ORDER BY identification_remarks,scientific_name
```

<div class="knitsql-table">

| cd_tax | scientific_name           | identification_qualifier | identification_remarks                        | pseudo_rank | cd_rank | count |
|-------:|:--------------------------|:-------------------------|:----------------------------------------------|:------------|:--------|------:|
|    859 | Brachystomella            | sp.                      | Morfo 1                                       | SP          | GN      |     4 |
|    943 | Cyphoderus                | sp.                      | Morfo 1                                       | SP          | GN      |    11 |
|   1013 | Folsomina                 | sp.                      | Morfo 1                                       | SP          | GN      |     1 |
|   1179 | Neelides                  | sp.                      | Morfo 1                                       | SP          | GN      |     1 |
|   1294 | Ptenothrix                | sp.                      | Morfo 1                                       | SP          | GN      |    88 |
|   1312 | Salina                    | sp.                      | Morfo 10                                      | SP          | GN      |    11 |
|   1327 | Sminthurides              | sp.                      | Morfo 10                                      | SP          | GN      |     4 |
|   1099 | Lepidocyrtoides           | sp.                      | Morfo 100                                     | SP          | GN      |    18 |
|   1054 | Heteromurus               | sp.                      | Morfo 101                                     | SP          | GN      |     2 |
|   1100 | Lepidocyrtus              | sp.                      | Morfo 101                                     | SP          | GN      |     2 |
|   1100 | Lepidocyrtus              | sp.                      | Morfo 102                                     | SP          | GN      |     2 |
|   1312 | Salina                    | sp.                      | Morfo 103                                     | SP          | GN      |     4 |
|   1396 | Trogolaphysa              | sp.                      | Morfo 104                                     | SP          | GN      |     1 |
|   1080 | Isotomurus                | sp.                      | Morfo 105                                     | SP          | GN      |     8 |
|   2869 | Isotomurus yamaquizuensis | cf. yamaquizuensis       | Morfo 105                                     | ERROR_RANK  | SP      |     1 |
|   1100 | Lepidocyrtus              | sp.                      | Morfo 106                                     | SP          | GN      |     7 |
|    988 | Entomobrya                | sp.                      | Morfo 107                                     | SP          | GN      |     1 |
|    988 | Entomobrya                | sp.                      | Morfo 108                                     | SP          | GN      |     2 |
|   1412 | Willowsia                 | sp.                      | Morfo 108                                     | SP          | GN      |    17 |
|   1396 | Trogolaphysa              | sp.                      | Morfo 109                                     | SP          | GN      |    11 |
|   1412 | Willowsia                 | cf. Willowsia            | Morfo 109                                     | SP          | GN      |     1 |
|   1100 | Lepidocyrtus              | sp.                      | Morfo 11                                      | SP          | GN      |    26 |
|   1100 | Lepidocyrtus              | sp.                      | Morfo 110                                     | SP          | GN      |     1 |
|   1099 | Lepidocyrtoides           | sp.                      | Morfo 111                                     | SP          | GN      |     2 |
|   1100 | Lepidocyrtus              | sp.                      | Morfo 111                                     | SP          | GN      |     1 |
|   1099 | Lepidocyrtoides           | sp.                      | Morfo 112                                     | SP          | GN      |     1 |
|   1333 | Sphaeridia                | sp.                      | Morfo 113                                     | SP          | GN      |     2 |
|    288 | Entomobryidae             | sp.                      | Morfo 114 \| género Lepidocyrtus o Lanocyrtus | GN          | FAM     |    38 |
|   1333 | Sphaeridia                | sp.                      | Morfo 115                                     | SP          | GN      |     1 |
|   1082 | Katianna                  | sp.                      | Morfo 116                                     | SP          | GN      |     3 |
|   1294 | Ptenothrix                | sp.                      | Morfo 117                                     | SP          | GN      |     1 |
|    859 | Brachystomella            | sp.                      | Morfo 118                                     | SP          | GN      |     9 |
|    859 | Brachystomella            | sp.                      | Morfo 119                                     | SP          | GN      |     4 |
|   1189 | Neotropiella              | sp.                      | Morfo 119                                     | SP          | GN      |    86 |
|   1100 | Lepidocyrtus              | sp.                      | Morfo 12                                      | SP          | GN      |    50 |
|     98 | Symphypleona              | sp.                      | Morfo 12                                      | FAM         | OR      |     2 |
|    859 | Brachystomella            | sp.                      | Morfo 120                                     | SP          | GN      |     1 |
|     93 | Poduromorpha              | sp.                      | Morfo 120                                     | FAM         | OR      |     1 |
|    859 | Brachystomella            | sp.                      | Morfo 121                                     | SP          | GN      |     3 |
|   1282 | Pseudachorutes            | sp.                      | Morfo 121                                     | SP          | GN      |    15 |
|    318 | Neanuridae                | sp.                      | Morfo 122                                     | GN          | FAM     |     1 |
|    824 | Arlesia                   | cf. Arlesia              | Morfo 123                                     | SP          | GN      |     1 |
|    302 | Hypogastruridae           | sp.                      | Morfo 123                                     | GN          | FAM     |     1 |
|   1100 | Lepidocyrtus              | aff. Lepidocyrtus        | Morfo 124                                     | SP          | GN      |     1 |
|   1100 | Lepidocyrtus              | sp.                      | Morfo 124                                     | SP          | GN      |     5 |
|   1396 | Trogolaphysa              | sp.                      | Morfo 124                                     | SP          | GN      |     5 |
|   1100 | Lepidocyrtus              | sp.                      | Morfo 125                                     | SP          | GN      |     1 |
|   1294 | Ptenothrix                | sp.                      | Morfo 126                                     | SP          | GN      |     2 |
|   1333 | Sphaeridia                | sp.                      | Morfo 127                                     | SP          | GN      |     1 |
|    824 | Arlesia                   | cf. Arlesia              | Morfo 128                                     | SP          | GN      |     7 |

Displaying records 1 - 50

</div>

``` sql
WITH a AS(
SELECT cd_tax, scientific_name, identification_qualifier,
SPLIT_PART(identification_remarks,' | ',1) morfo,
SPLIT_PART(identification_remarks,' | ',2) affinities,
  CASE
    WHEN cd_rank='GN' THEN 'SP'
    WHEN cd_rank='FAM' THEN 'GN'
    WHEN cd_rank='OR' THEN 'FAM'
    WHEN cd_rank='CL' THEN 'OR'
    WHEN cd_rank='PHY' THEN 'CL'
    WHEN cd_rank='KG' THEN 'PHY'
    ELSE 'ERROR_RANK'
  END pseudo_rank,
  cd_rank
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE /*rank_level>10 AND*/ table_orig='collembolos_registros' AND (identification_qualifier IS NOT NULL OR identification_remarks IS NOT NULL)
), b AS(
SELECT cd_tax,scientific_name,morfo,affinities,identification_qualifier,count(*), ROW_NUMBER()  OVER (PARTITION BY cd_tax,morfo ORDER BY count(*) DESC) AS order_cases_in_sp_morfo
FROM a
GROUP BY cd_tax,scientific_name,morfo,affinities,identification_qualifier
ORDER BY cd_tax,morfo
)
SELECT b.* 
FROM b
JOIN (SELECT * FROM b WHERE order_cases_in_sp_morfo=2) AS b2 USING(cd_tax,morfo)
/*
GROUP BY cd_tax,scientific_name,identification_qualifier,identification_remarks,cd_rank
ORDER BY identification_remarks,scientific_name
*/
```

<div class="knitsql-table">

| cd_tax | scientific_name | morfo     | affinities                       | identification_qualifier | count | order_cases_in_sp_morfo |
|-------:|:----------------|:----------|:---------------------------------|:-------------------------|------:|------------------------:|
|    288 | Entomobryidae   | Morfo 65  | género Lepidocyrtus o Lanocyrtus | sp.                      |    32 |                       1 |
|    288 | Entomobryidae   | Morfo 65  | género Lepidocyrtus o Lanocyrtus | aff. Entomobryidae       |     2 |                       2 |
|    853 | Bourletiella    | Morfo 229 |                                  | aff. Bourletiella        |     7 |                       1 |
|    853 | Bourletiella    | Morfo 229 |                                  | sp.                      |     1 |                       2 |
|    964 | Dicyrtoma       | Morfo 2   |                                  | aff. Dicyrtoma           |    18 |                       1 |
|    964 | Dicyrtoma       | Morfo 2   |                                  | sp.                      |    12 |                       2 |
|   1078 | Isotomiella     | Morfo 256 |                                  | aff. Isotomiella         |     1 |                       1 |
|   1078 | Isotomiella     | Morfo 256 |                                  | sp.                      |     1 |                       2 |
|   1100 | Lepidocyrtus    | Morfo 124 |                                  | sp.                      |     5 |                       1 |
|   1100 | Lepidocyrtus    | Morfo 124 |                                  | aff. Lepidocyrtus        |     1 |                       2 |
|   1187 | Neosminthurus   | Morfo 245 |                                  | cf. Neosminthurus        |     4 |                       1 |
|   1187 | Neosminthurus   | Morfo 245 |                                  | aff. Neosminthurus       |     3 |                       2 |
|   1227 | Pararrhopalites | Morfo 335 |                                  | sp.                      |     3 |                       1 |
|   1227 | Pararrhopalites | Morfo 335 |                                  | cf. Pararrhopalites      |     3 |                       2 |
|   1324 | Sinella         | Morfo 80  |                                  | sp.                      |     9 |                       1 |
|   1324 | Sinella         | Morfo 80  |                                  | cf. Sinella              |     3 |                       2 |
|   1329 | Sminthurus      | Morfo 233 |                                  | aff. Sminthurus          |    18 |                       1 |
|   1329 | Sminthurus      | Morfo 233 |                                  | sp.                      |    10 |                       2 |
|   1329 | Sminthurus      | Morfo 235 |                                  | sp.                      |    21 |                       1 |
|   1329 | Sminthurus      | Morfo 235 |                                  | cf. Sminthurus           |     6 |                       2 |
|   1333 | Sphaeridia      | Morfo 223 |                                  | cf. Sphaeridia           |     6 |                       1 |
|   1333 | Sphaeridia      | Morfo 223 |                                  | sp.                      |     2 |                       2 |
|   1335 | Sphyrotheca     | Morfo 328 |                                  | sp.                      |     3 |                       1 |
|   1335 | Sphyrotheca     | Morfo 328 |                                  | cf. Sphyrotheca          |     1 |                       2 |

24 records

</div>

Sería posible, con más trabajo, extraer los taxones potenciales, y los
rangos etc. Pero es mucho trabajo, con incertidumbre: para ir más allá,
deberíamos consultar los expertos del grupo.

Por ahora, lo que voy a hacer es:

- Considerar unicamente las associaciones scientific_name/Morfo
- Considerar unicamente los morfo-taxones construidos sobre rangos
  superiores a especies
- Poner el Morfo como name_morfo
- Poner como verbatim_taxon el identification_qualifier más utilizado
- Poner todos los morfo/afinities/identification_qualifier en las
  descripciones

``` sql
INSERT INTO main.morfo_taxo(cd_gp_biol, cd_tax,name_morfo,verbatim_taxon,description,pseudo_rank)
WITH a AS(
SELECT cd_tax, scientific_name, identification_qualifier,
SPLIT_PART(identification_remarks,' | ',1) morfo,
SPLIT_PART(identification_remarks,' | ',2) affinities,
  CASE
    WHEN cd_rank='GN' THEN 'SP'
    WHEN cd_rank='FAM' THEN 'GN'
    WHEN cd_rank='OR' THEN 'FAM'
    WHEN cd_rank='CL' THEN 'OR'
    WHEN cd_rank='PHY' THEN 'CL'
    WHEN cd_rank='KG' THEN 'PHY'
    ELSE 'ERROR_RANK'
  END pseudo_rank,
  cd_rank
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE rank_level>10 AND table_orig='collembolos_registros' AND (identification_qualifier IS NOT NULL OR identification_remarks IS NOT NULL)
), b AS(
SELECT cd_tax,scientific_name,morfo,affinities,identification_qualifier,count(*), ROW_NUMBER()  OVER (PARTITION BY cd_tax,morfo ORDER BY count(*) DESC) AS order_cases_in_sp_morfo,pseudo_rank
FROM a
GROUP BY cd_tax,scientific_name,morfo,affinities,identification_qualifier,pseudo_rank
ORDER BY cd_tax,morfo
)
SELECT 'cole',cd_tax,morfo, 
  scientific_name || ' ' || STRING_AGG(DISTINCT identification_qualifier, '|  ') FILTER (WHERE order_cases_in_sp_morfo=1) AS verbatim_name,
  'affinities: '|| STRING_AGG(DISTINCT affinities, ', ')|| ' | qualifiers: ' || STRING_AGG(DISTINCT identification_qualifier,', '),pseudo_rank
FROM b
GROUP BY cd_tax,morfo,scientific_name,pseudo_rank
ORDER BY morfo
RETURNING cd_morfo
```

``` sql
UPDATE main.morfo_taxo
SET description=REGEXP_REPLACE(description,'^affinities:  \|','')
WHERE cd_gp_biol='cole' AND description ~'^affinities:  \|'
RETURNING description
```

Afectar el cd_morfo en la tabla taxonomy_total:

``` sql
UPDATE raw_dwc.taxonomy_total tt
SET cd_morfo=m.cd_morfo
FROM main.morfo_taxo m
WHERE m.cd_gp_biol='cole' AND tt.cd_tax=m.cd_tax AND SPLIT_PART(tt.identification_remarks,' | ',1)=m.name_morfo
RETURNING tt.cd_morfo
```

## 6.5 Escarabajos

``` sql
SELECT cd_tax,scientific_name,identification_qualifier,identification_remarks,
  CASE
    WHEN cd_rank='GN' THEN 'SP'
    WHEN cd_rank='FAM' THEN 'GN'
    WHEN cd_rank='OR' THEN 'FAM'
    WHEN cd_rank='CL' THEN 'OR'
    WHEN cd_rank='PHY' THEN 'CL'
    WHEN cd_rank='KG' THEN 'PHY'
    ELSE 'ERROR_RANK'
  END pseudo_rank,
count(*)
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE /*rank_level>10 AND */table_orig='escarabajos_registros'
  AND (identification_remarks IS NOT NULL)
GROUP BY cd_tax,cd_rank,scientific_name,identification_qualifier,identification_remarks
ORDER BY cd_tax,identification_remarks
```

<div class="knitsql-table">

| cd_tax | scientific_name | identification_qualifier | identification_remarks | pseudo_rank | count |
|-------:|:----------------|:-------------------------|:-----------------------|:------------|------:|
|    878 | Canthidium      | sp.                      | 01H                    | SP          |    24 |
|    878 | Canthidium      | sp.                      | 02H                    | SP          |    39 |
|    878 | Canthidium      | sp.                      | 05H                    | SP          |    50 |
|    878 | Canthidium      | sp.                      | 10H                    | SP          |    24 |
|    878 | Canthidium      | sp.                      | 12H                    | SP          |    32 |
|    879 | Canthon         | sp.                      | 05H                    | SP          |    10 |
|    879 | Canthon         | sp.                      | 06H                    | SP          |    74 |
|    879 | Canthon         | sp.                      | 09H                    | SP          |    54 |
|    879 | Canthon         | sp.                      | 10H                    | SP          |    97 |
|    958 | Dichotomius     | sp.                      | 03H                    | SP          |    56 |
|   1207 | Onthophagus     | sp.                      | 01H                    | SP          |   682 |
|   1405 | Uroxys          | sp.                      | 02H                    | SP          |    87 |
|   1405 | Uroxys          | sp.                      | 05H                    | SP          |    24 |

13 records

</div>

``` sql
INSERT INTO main.morfo_taxo(cd_gp_biol,cd_tax,verbatim_taxon,name_morfo,pseudo_rank)
SELECT 'esca',cd_tax,scientific_name || ' ' || identification_qualifier AS verbatim_taxon, identification_remarks AS name_morfo,
  CASE
    WHEN cd_rank='GN' THEN 'SP'
    WHEN cd_rank='FAM' THEN 'GN'
    WHEN cd_rank='OR' THEN 'FAM'
    WHEN cd_rank='CL' THEN 'OR'
    WHEN cd_rank='PHY' THEN 'CL'
    WHEN cd_rank='KG' THEN 'PHY'
    ELSE 'ERROR_RANK'
  END pseudo_rank
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE /*rank_level>10 AND */table_orig='escarabajos_registros'
  AND (identification_remarks IS NOT NULL)
GROUP BY cd_tax,cd_rank,scientific_name,identification_qualifier,identification_remarks
ORDER BY cd_tax,identification_remarks
```

Afectar cd_morfo a las filas de taxonomy_total

``` sql
UPDATE raw_dwc.taxonomy_total AS tt
SET cd_morfo=m.cd_morfo
FROM main.morfo_taxo m
WHERE m.cd_gp_biol='esca' AND tt.table_orig='escarabajos_registros' AND tt.cd_tax=m.cd_tax AND tt.identification_remarks=m.name_morfo
RETURNING tt.cd_morfo
```

## 6.6 Macroinvertebrados

En el caso de macroinvertebrados, la columna de identification_qualifier
contiene 2 tipos de identificadores: tipo sp y tipo Mf. Por ahora voy a
considerar los dos como morfotipos, pero de pronto, los expertos
esperaban que solo los Mf sean morfo-taxones.

**Hay una diferencia entre Trombidiformes mf1. y Trombidiformes Mf1?
(voy a considerar que no)**

**Que hacer con Coleoptera Mf. (larva) versus Coleoptera Mf. (pupa)?**
Por ahora, voy a considera unicamente los que tienen un numero…

``` sql
SELECT cd_tax,scientific_name,
  identification_qualifier,
  CASE 
    WHEN identification_qualifier ~ '^[Mm]f[0-9]\.' THEN 'Mf'||REGEXP_REPLACE(identification_qualifier,'^[Mm]f([0-9])\.','\1')||'.'
    WHEN identification_qualifier ~ '^sp[0-9]\.' THEN identification_qualifier
    ELSE NULL
  END name_morfo
  ,identification_remarks,
  CASE
    WHEN identification_remarks ~ '[Ll]arva' OR identification_remarks ~ '[Aa]dulto' THEN NULL
    ELSE identification_remarks 
  END description,
  cd_rank,
  CASE
    WHEN cd_rank='GN' THEN 'SP'
    WHEN cd_rank='TR' THEN 'GN'
    WHEN cd_rank='SFAM' THEN 'GN'
    WHEN cd_rank='FAM' THEN 'GN'
    WHEN cd_rank='SOR' THEN 'FAM'
    WHEN cd_rank='OR' THEN 'FAM'
    WHEN cd_rank='CL' THEN 'OR'
    WHEN cd_rank='PHY' THEN 'CL'
    WHEN cd_rank='KG' THEN 'PHY'
    ELSE 'ERROR_RANK'
  END pseudo_rank,
count(*)
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE /*rank_level>10 AND */table_orig='hidrobiologico_registros_macroinvertebrados'
  AND (identification_qualifier IS NOT NULL)
GROUP BY cd_tax,cd_rank,scientific_name,identification_qualifier,identification_remarks
ORDER BY cd_tax,identification_qualifier
```

<div class="knitsql-table">

| cd_tax | scientific_name   | identification_qualifier   | name_morfo | identification_remarks                                       | description                                                  | cd_rank | pseudo_rank | count |
|-------:|:------------------|:---------------------------|:-----------|:-------------------------------------------------------------|:-------------------------------------------------------------|:--------|:------------|------:|
|      9 | Nematoda          | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | PHY     | CL          |     2 |
|     82 | Coleoptera        | Mf. (larva)                | NA         | NA                                                           | NA                                                           | OR      | FAM         |     2 |
|     82 | Coleoptera        | Mf. (pupa)                 | NA         | NA                                                           | NA                                                           | OR      | FAM         |     2 |
|     83 | Diptera           | Mf. (larva)                | NA         | NA                                                           | NA                                                           | OR      | FAM         |     3 |
|     83 | Diptera           | Mf. (pupa)                 | NA         | NA                                                           | NA                                                           | OR      | FAM         |     1 |
|     85 | Lepidoptera       | cf. Lepidoptera Mf. (pupa) | NA         | NA                                                           | NA                                                           | OR      | FAM         |     2 |
|     86 | Mesostigmata      | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | OR      | FAM         |     1 |
|     89 | Neoophora         | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | OR      | FAM         |     1 |
|     90 | Odonata           | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | OR      | FAM         |     1 |
|     91 | Oribatida         | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | OR      | FAM         |     1 |
|     91 | Oribatida         | Mf2.                       | Mf2.       | NA                                                           | NA                                                           | OR      | FAM         |     1 |
|     95 | Sarcoptiformes    | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | OR      | FAM         |     2 |
|     95 | Sarcoptiformes    | Mf2.                       | Mf2.       | NA                                                           | NA                                                           | OR      | FAM         |     4 |
|    100 | Tricladida        | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | OR      | FAM         |     3 |
|    101 | Trombidiformes    | mf1.                       | Mf1.       | NA                                                           | NA                                                           | OR      | FAM         |     2 |
|    101 | Trombidiformes    | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | OR      | FAM         |    38 |
|    101 | Trombidiformes    | Mf2.                       | Mf2.       | Fuertes espinas en el lado ventral de las patas.             | Fuertes espinas en el lado ventral de las patas.             | OR      | FAM         |     1 |
|    101 | Trombidiformes    | Mf2.                       | Mf2.       | NA                                                           | NA                                                           | OR      | FAM         |     8 |
|    101 | Trombidiformes    | mf3.                       | Mf3.       | NA                                                           | NA                                                           | OR      | FAM         |     2 |
|    101 | Trombidiformes    | Mf3.                       | Mf3.       | NA                                                           | NA                                                           | OR      | FAM         |    11 |
|    101 | Trombidiformes    | mf4.                       | Mf4.       | NA                                                           | NA                                                           | OR      | FAM         |     1 |
|    101 | Trombidiformes    | Mf4.                       | Mf4.       | NA                                                           | NA                                                           | OR      | FAM         |     4 |
|    101 | Trombidiformes    | mf5.                       | Mf5.       | NA                                                           | NA                                                           | OR      | FAM         |     2 |
|    101 | Trombidiformes    | Mf5.                       | Mf5.       | NA                                                           | NA                                                           | OR      | FAM         |    10 |
|    101 | Trombidiformes    | mf6.                       | Mf6.       | NA                                                           | NA                                                           | OR      | FAM         |     2 |
|    101 | Trombidiformes    | Mf6.                       | Mf6.       | NA                                                           | NA                                                           | OR      | FAM         |    26 |
|    101 | Trombidiformes    | Mf7.                       | Mf7.       | NA                                                           | NA                                                           | OR      | FAM         |     9 |
|    101 | Trombidiformes    | Mf8.                       | Mf8.       | NA                                                           | NA                                                           | OR      | FAM         |     2 |
|    264 | Brachycera        | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | SOR     | FAM         |     4 |
|    268 | Arctiidae         | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |     1 |
|    270 | Baetidae          | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |    23 |
|    274 | Chironomidae      | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |     2 |
|    276 | Chrysomelidae     | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |     2 |
|    277 | Coenagrionidae    | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |     8 |
|    279 | Crambidae         | Mf1.                       | Mf1.       | A1-A2 solamente con 3 setas dorsales en fila, no llega a A7. | A1-A2 solamente con 3 setas dorsales en fila, no llega a A7. | FAM     | GN          |     1 |
|    279 | Crambidae         | Mf1.                       | Mf1.       | Setas dorsales solo en A1, branquias sin ramificar           | Setas dorsales solo en A1, branquias sin ramificar           | FAM     | GN          |     1 |
|    279 | Crambidae         | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |    11 |
|    279 | Crambidae         | Mf2.                       | Mf2.       | NA                                                           | NA                                                           | FAM     | GN          |     3 |
|    279 | Crambidae         | Mf3.                       | Mf3.       | NA                                                           | NA                                                           | FAM     | GN          |     5 |
|    280 | Curculionidae     | Mf1.                       | Mf1.       | una larva                                                    | NA                                                           | FAM     | GN          |     1 |
|    280 | Curculionidae     | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |    14 |
|    280 | Curculionidae     | Mf2.                       | Mf2.       | NA                                                           | NA                                                           | FAM     | GN          |     3 |
|    283 | Dolichopodidae    | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |    12 |
|    284 | Dryopidae         | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |     3 |
|    285 | Dycirtomidae      | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |     6 |
|    286 | Dytiscidae        | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |     2 |
|    286 | Dytiscidae        | Mf. (larva)                | NA         | NA                                                           | NA                                                           | FAM     | GN          |     1 |
|    287 | Empididae         | Mf. (larva)                | NA         | NA                                                           | NA                                                           | FAM     | GN          |     1 |
|    288 | Entomobryidae     | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |     2 |
|    293 | Gerridae          | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |     2 |
|    294 | Glossiphoniidae   | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |    51 |
|    295 | Gomphidae         | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |     2 |
|    299 | Gyrinidae         | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |     1 |
|    300 | Hydrobiidae       | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |    22 |
|    301 | Hydroptilidae     | Mf1.                       | Mf1.       | Tubo eppendorf                                               | Tubo eppendorf                                               | FAM     | GN          |     1 |
|    304 | Lampyridae        | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |     5 |
|    306 | Leptophlebiidae   | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |     1 |
|    307 | Libellulidae      | mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |     1 |
|    307 | Libellulidae      | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |     4 |
|    309 | Limnichidae       | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |     1 |
|    310 | Lumbriculidae     | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |     6 |
|    311 | Lutrochidae       | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |     2 |
|    313 | Mesoveliidae      | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |     1 |
|    316 | Muscidae          | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |     4 |
|    317 | Naididae          | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |    58 |
|    319 | Noteridae         | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |     1 |
|    325 | Polycentropodidae | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |     1 |
|    327 | Psychodidae       | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |     1 |
|    328 | Pyralidae         | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |     3 |
|    331 | Sciaridae         | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |     1 |
|    335 | Staphylinidae     | Mf1.                       | Mf1.       | 6 seg abd descubiertos, antenas de 11 segmentos.             | 6 seg abd descubiertos, antenas de 11 segmentos.             | FAM     | GN          |     1 |
|    335 | Staphylinidae     | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |     2 |
|    335 | Staphylinidae     | Mf2.                       | Mf2.       | 3 seg abd descubiertos, antenas con 10 segmentos.            | 3 seg abd descubiertos, antenas con 10 segmentos.            | FAM     | GN          |     1 |
|    335 | Staphylinidae     | Mf3.                       | Mf3.       | NA                                                           | NA                                                           | FAM     | GN          |     1 |
|    336 | Stratiomyidae     | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |     2 |
|    337 | Tabanidae         | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |    14 |
|    339 | Tipulidae         | Mf. (larva)                | NA         | NA                                                           | NA                                                           | FAM     | GN          |     1 |
|    340 | Trichodactylidae  | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |    19 |
|    341 | Trombidiidae      | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |     2 |
|    343 | Veliidae          | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | FAM     | GN          |     1 |
|    754 | Acentropinae      | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | SFAM    | GN          |     1 |
|    755 | Chironominae      | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | SFAM    | GN          |   209 |
|    755 | Chironominae      | Mf2.                       | Mf2.       | NA                                                           | NA                                                           | SFAM    | GN          |    44 |
|    757 | Orthocladiinae    | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | SFAM    | GN          |    77 |
|    757 | Orthocladiinae    | Mf2.                       | Mf2.       | NA                                                           | NA                                                           | SFAM    | GN          |    41 |
|    759 | Stratiomyinae     | mf1.                       | Mf1.       | NA                                                           | NA                                                           | SFAM    | GN          |     3 |
|    759 | Stratiomyinae     | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | SFAM    | GN          |     8 |
|    759 | Stratiomyinae     | Mf2.                       | Mf2.       | NA                                                           | NA                                                           | SFAM    | GN          |     1 |
|    760 | Tachyporinae      | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | SFAM    | GN          |     1 |
|    761 | Tanypodinae       | Mf1.                       | Mf1.       | NA                                                           | NA                                                           | SFAM    | GN          |   199 |
|    786 | Bidessini         | Mf. (larva)                | NA         | NA                                                           | NA                                                           | TR      | GN          |     1 |
|    787 | Acanthagrion      | sp1.                       | sp1.       | 2+2 menton, 3+3 palpos, dientes bien definidos.              | 2+2 menton, 3+3 palpos, dientes bien definidos.              | GN      | SP          |     1 |
|    787 | Acanthagrion      | sp1.                       | sp1.       | NA                                                           | NA                                                           | GN      | SP          |    16 |
|    795 | Aedeomyia         | sp1.                       | sp1.       | NA                                                           | NA                                                           | GN      | SP          |     6 |
|    796 | Agriogomphus      | sp1.                       | sp1.       | Pterotecas poco desarrolladas                                | Pterotecas poco desarrolladas                                | GN      | SP          |     1 |
|    796 | Agriogomphus      | sp1.                       | sp1.       | NA                                                           | NA                                                           | GN      | SP          |    15 |
|    801 | Alluaudomyia      | sp1.                       | sp1.       | NA                                                           | NA                                                           | GN      | SP          |    71 |
|    804 | Ambrysus          | sp1.                       | sp1.       | NA                                                           | NA                                                           | GN      | SP          |    43 |
|    805 | Americabaetis     | sp1.                       | sp1.       | NA                                                           | NA                                                           | GN      | SP          |     2 |
|    807 | Anacaena          | sp1.                       | sp1.       | NA                                                           | NA                                                           | GN      | SP          |     7 |

Displaying records 1 - 100

</div>

``` sql
INSERT INTO main.morfo_taxo(cd_gp_biol, cd_tax, name_morfo, verbatim_taxon, description, pseudo_rank)
WITH a AS(
SELECT cd_tax,scientific_name,
  identification_qualifier,
  CASE 
    WHEN identification_qualifier ~ '^[Mm]f[0-9]\.' THEN 'Mf'||REGEXP_REPLACE(identification_qualifier,'^[Mm]f([0-9])\.','\1')||'.'
    WHEN identification_qualifier ~ '^sp[0-9]\.' THEN identification_qualifier
    WHEN identification_qualifier ~ '^Mf\.' THEN 'Mf1.'
    ELSE NULL
  END name_morfo
  ,identification_remarks,
  CASE
    WHEN identification_remarks ~ '[Ll]arva' OR identification_remarks ~ '[Aa]dulto' THEN NULL
    ELSE identification_remarks 
  END description,
  cd_rank,
  CASE
    WHEN cd_rank='GN' THEN 'SP'
    WHEN cd_rank='TR' THEN 'GN'
    WHEN cd_rank='SFAM' THEN 'GN'
    WHEN cd_rank='FAM' THEN 'GN'
    WHEN cd_rank='SOR' THEN 'FAM'
    WHEN cd_rank='OR' THEN 'FAM'
    WHEN cd_rank='CL' THEN 'OR'
    WHEN cd_rank='PHY' THEN 'CL'
    WHEN cd_rank='KG' THEN 'PHY'
    ELSE 'ERROR_RANK'
  END pseudo_rank
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE /*rank_level>10 AND */table_orig='hidrobiologico_registros_macroinvertebrados'
  AND (identification_qualifier IS NOT NULL)
)
SELECT 'minv', cd_tax, name_morfo, scientific_name || ' ' || name_morfo verbatim_taxon, STRING_AGG(DISTINCT description, ' | '), pseudo_rank
FROM a
WHERE name_morfo IS NOT NULL
GROUP BY cd_tax,scientific_name, name_morfo, pseudo_rank
ORDER BY cd_tax,name_morfo
RETURNING main.morfo_taxo.cd_morfo, main.morfo_taxo.verbatim_taxon
```

Dar un cd_morfo a las filas de taxonomy_total

``` sql
UPDATE raw_dwc.taxonomy_total AS tt
SET cd_morfo=m.cd_morfo
FROM main.morfo_taxo m
WHERE m.cd_gp_biol='minv' AND tt.table_orig='hidrobiologico_registros_macroinvertebrados' 
  AND tt.cd_tax=m.cd_tax
  AND (
   CASE 
      WHEN tt.identification_qualifier ~ '^[Mm]f[0-9]\.' THEN 'Mf'||REGEXP_REPLACE(tt.identification_qualifier,'^[Mm]f([0-9])\.','\1')||'.'
      WHEN tt.identification_qualifier ~ '^sp[0-9]\.' THEN tt.identification_qualifier
    WHEN identification_qualifier ~ '^Mf\.' THEN 'Mf1.'
      ELSE NULL
    END = m.name_morfo)
RETURNING tt."row.names", tt.cd_morfo
```

## 6.7 Macrofitas

**Otra vez esta diferencia entre Mf y sp…**

``` sql
SELECT cd_tax,scientific_name,
  identification_qualifier,
  CASE 
    WHEN identification_qualifier ~ '^[Mm]f[0-9]\.' THEN 'Mf'||REGEXP_REPLACE(identification_qualifier,'^[Mm]f([0-9])\.','\1')||'.'
    WHEN identification_qualifier ~ '^sp[0-9]\.' THEN identification_qualifier
    ELSE NULL
  END name_morfo,
  cd_rank,
  CASE
    WHEN cd_rank='GN' THEN 'SP'
    WHEN cd_rank='TR' THEN 'GN'
    WHEN cd_rank='SFAM' THEN 'GN'
    WHEN cd_rank='FAM' THEN 'GN'
    WHEN cd_rank='SOR' THEN 'FAM'
    WHEN cd_rank='OR' THEN 'FAM'
    WHEN cd_rank='CL' THEN 'OR'
    WHEN cd_rank='PHY' THEN 'CL'
    WHEN cd_rank='KG' THEN 'PHY'
    ELSE 'ERROR_RANK'
  END pseudo_rank,
count(*)
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE /*rank_level>10 AND */table_orig='hidrobiologico_registros_macrofitas'
  AND (identification_qualifier IS NOT NULL)
GROUP BY cd_tax,cd_rank,scientific_name,identification_qualifier,identification_remarks
ORDER BY cd_tax,identification_qualifier
```

<div class="knitsql-table">

| cd_tax | scientific_name           | identification_qualifier      | name_morfo | cd_rank | pseudo_rank | count |
|-------:|:--------------------------|:------------------------------|:-----------|:--------|:------------|------:|
|    265 | Acanthaceae               | Mf1.                          | Mf1.       | FAM     | GN          |     2 |
|    271 | Bombacaceae               | Mf1.                          | Mf1.       | FAM     | GN          |     1 |
|    281 | Cyperaceae                | Mf1.                          | Mf1.       | FAM     | GN          |    11 |
|    281 | Cyperaceae                | Mf2.                          | Mf2.       | FAM     | GN          |     1 |
|    281 | Cyperaceae                | Mf3.                          | Mf3.       | FAM     | GN          |     1 |
|    281 | Cyperaceae                | Mf4.                          | Mf4.       | FAM     | GN          |     2 |
|    281 | Cyperaceae                | Mf5.                          | Mf5.       | FAM     | GN          |     1 |
|    308 | Liliaceae                 | Mf1.                          | Mf1.       | FAM     | GN          |     1 |
|    312 | Marantaceae               | Mf1.                          | Mf1.       | FAM     | GN          |     1 |
|    324 | Poaceae                   | Mf3.                          | Mf3.       | FAM     | GN          |     2 |
|    324 | Poaceae                   | Mf4.                          | Mf4.       | FAM     | GN          |     1 |
|    345 | Xyridaceae                | Mf1.                          | Mf1.       | FAM     | GN          |     1 |
|    793 | Adiantum                  | sp1.                          | sp1.       | GN      | SP          |     5 |
|    800 | Allophylus                | sp1.                          | sp1.       | GN      | SP          |     1 |
|    818 | Anthurium                 | sp1.                          | sp1.       | GN      | SP          |     4 |
|    818 | Anthurium                 | sp2.                          | sp2.       | GN      | SP          |     5 |
|    818 | Anthurium                 | sp3.                          | sp3.       | GN      | SP          |     1 |
|    818 | Anthurium                 | sp4.                          | sp4.       | GN      | SP          |     3 |
|    829 | Asplenium                 | sp1.                          | sp1.       | GN      | SP          |    10 |
|    829 | Asplenium                 | sp2.                          | sp2.       | GN      | SP          |     4 |
|    869 | Calathea                  | sp1.                          | sp1.       | GN      | SP          |     1 |
|    873 | Calyptrocarya             | sp1.                          | sp1.       | GN      | SP          |     1 |
|    881 | Cardamine                 | sp1.                          | sp1.       | GN      | SP          |     1 |
|    883 | Casearia                  | sp1.                          | sp1.       | GN      | SP          |     1 |
|    893 | Ceratopteris              | sp1.                          | sp1.       | GN      | SP          |     3 |
|    913 | Cololejeunea              | sp1.                          | sp1.       | GN      | SP          |     1 |
|    924 | Costus                    | sp1.                          | sp1.       | GN      | SP          |     1 |
|    936 | Cyclanthus                | sp1.                          | sp1.       | GN      | SP          |     1 |
|    961 | Dicranopygium             | sp1.                          | sp1.       | GN      | SP          |     2 |
|    977 | Echinodorus               | sp1.                          | sp1.       | GN      | SP          |     1 |
|    977 | Echinodorus               | sp2.                          | sp2.       | GN      | SP          |     1 |
|    980 | Eleocharis                | sp1.                          | sp1.       | GN      | SP          |     2 |
|    980 | Eleocharis                | sp2.                          | sp2.       | GN      | SP          |     1 |
|   1038 | Heliconia                 | sp1.                          | sp1.       | GN      | SP          |     2 |
|   1068 | Hylaeanthe                | sp1.                          | sp1.       | GN      | SP          |     1 |
|   1068 | Hylaeanthe                | sp2.                          | sp2.       | GN      | SP          |     1 |
|   1068 | Hylaeanthe                | sp3.                          | sp3.       | GN      | SP          |     1 |
|   1069 | Hymenophyllum             | sp1.                          | sp1.       | GN      | SP          |     1 |
|   1071 | Hypolytrum                | sp1.                          | sp1.       | GN      | SP          |     1 |
|   1075 | Ischnosiphon              | sp1.                          | sp1.       | GN      | SP          |     1 |
|   1115 | Ludwigia                  | sp1.                          | sp1.       | GN      | SP          |     2 |
|   1150 | Metzgeria                 | sp1.                          | sp1.       | GN      | SP          |     1 |
|   1168 | Monotagma                 | sp1.                          | sp1.       | GN      | SP          |     1 |
|   1198 | Nymphoides                | sp1.                          | sp1.       | GN      | SP          |     3 |
|   1205 | Olyra                     | sp1.                          | sp1.       | GN      | SP          |     1 |
|   1247 | Philodendron              | sp1.                          | sp1.       | GN      | SP          |     7 |
|   1247 | Philodendron              | sp2.                          | sp2.       | GN      | SP          |     3 |
|   1247 | Philodendron              | sp3.                          | sp3.       | GN      | SP          |     6 |
|   1247 | Philodendron              | sp4.                          | sp4.       | GN      | SP          |     2 |
|   1247 | Philodendron              | sp5.                          | sp5.       | GN      | SP          |     4 |
|   1247 | Philodendron              | sp6.                          | sp6.       | GN      | SP          |     1 |
|   1247 | Philodendron              | sp7.                          | sp7.       | GN      | SP          |     2 |
|   1268 | Pontederia                | sp1.                          | sp1.       | GN      | SP          |     2 |
|   1270 | Potamogeton               | sp1.                          | sp1.       | GN      | SP          |     5 |
|   1270 | Potamogeton               | sp2.                          | sp2.       | GN      | SP          |     3 |
|   1299 | Renealmia                 | sp1.                          | sp1.       | GN      | SP          |     1 |
|   1304 | Rhodospatha               | sp1.                          | sp1.       | GN      | SP          |     1 |
|   1313 | Salvinia                  | sp1.                          | sp1.       | GN      | SP          |     1 |
|   1317 | Scleria                   | sp1.                          | sp1.       | GN      | SP          |     1 |
|   1317 | Scleria                   | sp2.                          | sp2.       | GN      | SP          |     1 |
|   1332 | Spathiphyllum             | sp1.                          | sp1.       | GN      | SP          |     2 |
|   1332 | Spathiphyllum             | sp2.                          | sp2.       | GN      | SP          |     1 |
|   1349 | Stenospermation           | sp1.                          | sp1.       | GN      | SP          |     2 |
|   1367 | Syngonanthus              | sp1.                          | sp1.       | GN      | SP          |     2 |
|   1406 | Utricularia               | sp1.                          | sp1.       | GN      | SP          |     3 |
|   1406 | Utricularia               | sp2.                          | sp2.       | GN      | SP          |     1 |
|   1406 | Utricularia               | sp3.                          | sp3.       | GN      | SP          |     3 |
|   1421 | Xyris                     | sp1.                          | sp1.       | GN      | SP          |     1 |
|   2334 | Benjaminia reflexa        | cf. Benjaminia reflexa        | NA         | SP      | ERROR_RANK  |     1 |
|   2392 | Calyptrocarya glomerulata | cf. Calyptrocarya glomerulata | NA         | SP      | ERROR_RANK  |     1 |
|   3164 | Panicum laxum             | cf. Panicum laxum             | NA         | SP      | ERROR_RANK  |     2 |
|   3557 | Vallisneria americana     | cf. Vallisneria americana     | NA         | SP      | ERROR_RANK  |     2 |

72 records

</div>

``` sql
INSERT INTO main.morfo_taxo(cd_gp_biol, cd_tax, name_morfo, verbatim_taxon, pseudo_rank)
WITH a AS(
SELECT cd_tax,scientific_name,
  identification_qualifier,
  CASE 
    WHEN identification_qualifier ~ '^[Mm]f[0-9]\.' THEN 'Mf'||REGEXP_REPLACE(identification_qualifier,'^[Mm]f([0-9])\.','\1')||'.'
    WHEN identification_qualifier ~ '^sp[0-9]\.' THEN identification_qualifier
    ELSE NULL
  END name_morfo,
  cd_rank,
  CASE
    WHEN cd_rank='GN' THEN 'SP'
    WHEN cd_rank='TR' THEN 'GN'
    WHEN cd_rank='SFAM' THEN 'GN'
    WHEN cd_rank='FAM' THEN 'GN'
    WHEN cd_rank='SOR' THEN 'FAM'
    WHEN cd_rank='OR' THEN 'FAM'
    WHEN cd_rank='CL' THEN 'OR'
    WHEN cd_rank='PHY' THEN 'CL'
    WHEN cd_rank='KG' THEN 'PHY'
    ELSE 'ERROR_RANK'
  END pseudo_rank
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE /*rank_level>10 AND */table_orig='hidrobiologico_registros_macrofitas'
  AND (identification_qualifier IS NOT NULL)
)
SELECT 'mafi',cd_tax,name_morfo,scientific_name||' '||name_morfo,pseudo_rank
FROM a
WHERE name_morfo IS NOT NULL
GROUP BY cd_tax,pseudo_rank,scientific_name,name_morfo
ORDER BY cd_tax,name_morfo
RETURNING main.morfo_taxo.cd_morfo, main.morfo_taxo.verbatim_taxon
```

Dar cd_morfo en taxonomy_total

``` sql
UPDATE raw_dwc.taxonomy_total AS tt
SET cd_morfo=m.cd_morfo
FROM main.morfo_taxo m
WHERE m.cd_gp_biol='mafi' AND tt.table_orig='hidrobiologico_registros_macrofitas' 
  AND tt.cd_tax=m.cd_tax
  AND (
   CASE 
      WHEN tt.identification_qualifier ~ '^[Mm]f[0-9]\.' THEN 'Mf'||REGEXP_REPLACE(tt.identification_qualifier,'^[Mm]f([0-9])\.','\1')||'.'
      WHEN tt.identification_qualifier ~ '^sp[0-9]\.' THEN tt.identification_qualifier
      ELSE NULL
    END = m.name_morfo)
RETURNING tt."row.names", tt.cd_morfo
```

## 6.8 Zooplancton

Mismo problema de minuscula/mayuscula y mismo problema de mf vs sp

``` sql
SELECT cd_tax,scientific_name,
  identification_qualifier,
  CASE 
    WHEN identification_qualifier ~ '^[Mm]f[0-9]\.' THEN 'Mf'||REGEXP_REPLACE(identification_qualifier,'^[Mm]f([0-9])\.','\1')||'.'
    WHEN identification_qualifier ~ '^sp[0-9]\.' THEN identification_qualifier
    ELSE NULL
  END name_morfo,
  cd_rank,
  CASE
    WHEN cd_rank='GN' THEN 'SP'
    WHEN cd_rank='TR' THEN 'GN'
    WHEN cd_rank='SFAM' THEN 'GN'
    WHEN cd_rank='FAM' THEN 'GN'
    WHEN cd_rank='SOR' THEN 'FAM'
    WHEN cd_rank='OR' THEN 'FAM'
    WHEN cd_rank='CL' THEN 'OR'
    WHEN cd_rank='PHY' THEN 'CL'
    WHEN cd_rank='KG' THEN 'PHY'
    ELSE 'ERROR_RANK'
  END pseudo_rank,
count(*)
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE /*rank_level>10 AND */table_orig='hidrobiologico_registros_zooplancton'
  AND (identification_qualifier IS NOT NULL)
GROUP BY cd_tax,cd_rank,scientific_name,identification_qualifier,identification_remarks
ORDER BY cd_tax,identification_qualifier
```

<div class="knitsql-table">

| cd_tax | scientific_name | identification_qualifier | name_morfo | cd_rank | pseudo_rank | count |
|-------:|:----------------|:-------------------------|:-----------|:--------|:------------|------:|
|      9 | Nematoda        | Mf1.                     | Mf1.       | PHY     | CL          |    28 |
|     35 | Maxillopoda     | mf1.                     | Mf1.       | CL      | OR          |    28 |
|     35 | Maxillopoda     | Mf1.                     | Mf1.       | CL      | OR          |    81 |
|     35 | Maxillopoda     | Mf2.                     | Mf2.       | CL      | OR          |    56 |
|    802 | Alona           | sp1.                     | sp1.       | GN      | SP          |     1 |
|    802 | Alona           | sp2.                     | sp2.       | GN      | SP          |     1 |
|    822 | Arcella         | sp1.                     | sp1.       | GN      | SP          |    95 |
|    822 | Arcella         | sp2.                     | sp2.       | GN      | SP          |    24 |
|    828 | Asplanchna      | sp1.                     | sp1.       | GN      | SP          |    14 |
|    845 | Beauchampiella  | sp1.                     | sp1.       | GN      | SP          |     1 |
|    851 | Bosmina         | sp1.                     | sp1.       | GN      | SP          |    10 |
|    851 | Bosmina         | sp2.                     | sp2.       | GN      | SP          |     8 |
|    851 | Bosmina         | sp3.                     | sp3.       | GN      | SP          |     4 |
|    854 | Brachionus      | sp1.                     | sp1.       | GN      | SP          |     1 |
|    854 | Brachionus      | sp2.                     | sp2.       | GN      | SP          |    17 |
|    854 | Brachionus      | sp3.                     | sp3.       | GN      | SP          |     4 |
|    854 | Brachionus      | sp4.                     | sp4.       | GN      | SP          |    10 |
|    854 | Brachionus      | sp5.                     | sp5.       | GN      | SP          |     3 |
|    888 | Cephalodella    | sp1.                     | sp1.       | GN      | SP          |     4 |
|    894 | Ceriodaphnia    | sp1.                     | sp1.       | GN      | SP          |     2 |
|    956 | Diaphanosoma    | sp1.                     | sp1.       | GN      | SP          |     2 |
|    960 | Dicranophorus   | sp1.                     | sp1.       | GN      | SP          |     1 |
|    969 | Dipleuchlanis   | sp1.                     | sp1.       | GN      | SP          |     5 |
|    983 | Encentrum       | sp1.                     | sp1.       | GN      | SP          |     3 |
|    990 | Epiphanes       | sp1.                     | sp1.       | GN      | SP          |     2 |
|   1010 | Filinia         | sp1.                     | sp1.       | GN      | SP          |    13 |
|   1051 | Heterocypris    | sp1.                     | sp1.       | GN      | SP          |    29 |
|   1083 | Keratella       | sp1.                     | sp1.       | GN      | SP          |    17 |
|   1083 | Keratella       | sp2.                     | sp2.       | GN      | SP          |     1 |
|   1094 | Lecane          | sp1.                     | sp1.       | GN      | SP          |     3 |
|   1094 | Lecane          | sp2.                     | sp2.       | GN      | SP          |    31 |
|   1094 | Lecane          | sp3.                     | sp3.       | GN      | SP          |     8 |
|   1094 | Lecane          | sp4.                     | sp4.       | GN      | SP          |     7 |
|   1094 | Lecane          | sp5.                     | sp5.       | GN      | SP          |     1 |
|   1094 | Lecane          | sp6.                     | sp6.       | GN      | SP          |     1 |
|   1097 | Lepadella       | sp1.                     | sp1.       | GN      | SP          |     5 |
|   1121 | Macrochaetus    | sp1.                     | sp1.       | GN      | SP          |     5 |
|   1126 | Macrothrix      | sp1.                     | sp1.       | GN      | SP          |     4 |
|   1144 | Mesocyclops     | sp1.                     | sp1.       | GN      | SP          |    23 |
|   1162 | Moina           | sp1.                     | sp1.       | GN      | SP          |    21 |
|   1162 | Moina           | sp2.                     | sp2.       | GN      | SP          |    15 |
|   1166 | Monommata       | sp1.                     | sp1.       | GN      | SP          |     2 |
|   1176 | Mytilina        | sp1.                     | sp1.       | GN      | SP          |     4 |
|   1265 | Polyarthra      | sp1.                     | sp1.       | GN      | SP          |     8 |
|   1271 | Prionodiaptomus | sp1.                     | sp1.       | GN      | SP          |    17 |
|   1272 | Proales         | sp1.                     | sp1.       | GN      | SP          |    33 |
|   1378 | Testudinella    | sp1.                     | sp1.       | GN      | SP          |    13 |
|   1391 | Trichocerca     | sp1.                     | sp1.       | GN      | SP          |     8 |
|   1393 | Trichotria      | sp1.                     | sp1.       | GN      | SP          |     2 |

49 records

</div>

``` sql
INSERT INTO main.morfo_taxo(cd_gp_biol, cd_tax, name_morfo, verbatim_taxon, pseudo_rank)
WITH a AS(
SELECT cd_tax,scientific_name,
  identification_qualifier,
  CASE 
    WHEN identification_qualifier ~ '^[Mm]f[0-9]\.' THEN 'Mf'||REGEXP_REPLACE(identification_qualifier,'^[Mm]f([0-9])\.','\1')||'.'
    WHEN identification_qualifier ~ '^sp[0-9]\.' THEN identification_qualifier
    ELSE NULL
  END name_morfo,
  cd_rank,
  CASE
    WHEN cd_rank='GN' THEN 'SP'
    WHEN cd_rank='TR' THEN 'GN'
    WHEN cd_rank='SFAM' THEN 'GN'
    WHEN cd_rank='FAM' THEN 'GN'
    WHEN cd_rank='SOR' THEN 'FAM'
    WHEN cd_rank='OR' THEN 'FAM'
    WHEN cd_rank='CL' THEN 'OR'
    WHEN cd_rank='PHY' THEN 'CL'
    WHEN cd_rank='KG' THEN 'PHY'
    ELSE 'ERROR_RANK'
  END pseudo_rank
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE /*rank_level>10 AND */table_orig='hidrobiologico_registros_zooplancton'
  AND (identification_qualifier IS NOT NULL)
)
SELECT 'zopl',cd_tax,name_morfo,scientific_name||' '||name_morfo,pseudo_rank
FROM a
WHERE name_morfo IS NOT NULL
GROUP BY cd_tax,pseudo_rank,scientific_name,name_morfo
ORDER BY cd_tax,name_morfo
RETURNING main.morfo_taxo.cd_morfo, main.morfo_taxo.verbatim_taxon
```

Dar cd_morfo en taxonomy_total

``` sql
UPDATE raw_dwc.taxonomy_total AS tt
SET cd_morfo=m.cd_morfo
FROM main.morfo_taxo m
WHERE m.cd_gp_biol='zopl' AND tt.table_orig='hidrobiologico_registros_zooplancton' 
  AND tt.cd_tax=m.cd_tax
  AND (
   CASE 
      WHEN tt.identification_qualifier ~ '^[Mm]f[0-9]\.' THEN 'Mf'||REGEXP_REPLACE(tt.identification_qualifier,'^[Mm]f([0-9])\.','\1')||'.'
      WHEN tt.identification_qualifier ~ '^sp[0-9]\.' THEN tt.identification_qualifier
      ELSE NULL
    END = m.name_morfo)
RETURNING tt."row.names", tt.cd_morfo
```

## 6.9 Phytoplancton

Mismo problema de minuscula/mayuscula y mismo problema de mf vs sp

``` sql
SELECT cd_tax,scientific_name,
  identification_qualifier,
  CASE 
    WHEN identification_qualifier ~ '^[Mm]f[0-9]\.' THEN 'Mf'||REGEXP_REPLACE(identification_qualifier,'^[Mm]f([0-9])\.','\1')||'.'
    WHEN identification_qualifier ~ '^sp[0-9]{1,2}\.' THEN identification_qualifier
    ELSE NULL
  END name_morfo,
  cd_rank,
  CASE
    WHEN cd_rank='GN' THEN 'SP'
    WHEN cd_rank='TR' THEN 'GN'
    WHEN cd_rank='SFAM' THEN 'GN'
    WHEN cd_rank='FAM' THEN 'GN'
    WHEN cd_rank='SOR' THEN 'FAM'
    WHEN cd_rank='OR' THEN 'FAM'
    WHEN cd_rank='CL' THEN 'OR'
    WHEN cd_rank='PHY' THEN 'CL'
    WHEN cd_rank='KG' THEN 'PHY'
    ELSE 'ERROR_RANK'
  END pseudo_rank,
count(*)
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE /*rank_level>10 AND */table_orig='hidrobiologico_registros_fitoplancton'
  AND (identification_qualifier IS NOT NULL)
GROUP BY cd_tax,cd_rank,scientific_name,identification_qualifier,identification_remarks
ORDER BY cd_tax,identification_qualifier
```

<div class="knitsql-table">

| cd_tax | scientific_name   | identification_qualifier | name_morfo | cd_rank | pseudo_rank | count |
|-------:|:------------------|:-------------------------|:-----------|:--------|:------------|------:|
|     32 | Chlorophyceae     | Mf1.                     | Mf1.       | CL      | OR          |     3 |
|     33 | Euglenophyceae    | Mf1.                     | Mf1.       | CL      | OR          |     3 |
|     79 | Achnanthales      | Mf1.                     | Mf1.       | OR      | FAM         |     1 |
|     80 | Chlamydomonadales | Mf1.                     | Mf1.       | OR      | FAM         |     2 |
|     80 | Chlamydomonadales | Mf2.                     | Mf2.       | OR      | FAM         |     9 |
|     80 | Chlamydomonadales | Mf3.                     | Mf3.       | OR      | FAM         |     2 |
|     81 | Chroococcales     | Mf1.                     | Mf1.       | OR      | FAM         |     1 |
|     87 | Naviculales       | Mf1.                     | Mf1.       | OR      | FAM         |     2 |
|     92 | Oscillatoriales   | Mf1.                     | Mf1.       | OR      | FAM         |     3 |
|    266 | Achnanthidiaceae  | Mf1.                     | Mf1.       | FAM     | GN          |     7 |
|    266 | Achnanthidiaceae  | Mf2.                     | Mf2.       | FAM     | GN          |     4 |
|    266 | Achnanthidiaceae  | Mf3.                     | Mf3.       | FAM     | GN          |     1 |
|    266 | Achnanthidiaceae  | Mf4.                     | Mf4.       | FAM     | GN          |     6 |
|    282 | Desmidiaceae      | Mf1.                     | Mf1.       | FAM     | GN          |     3 |
|    292 | Fragilariaceae    | Mf1.                     | Mf1.       | FAM     | GN          |     1 |
|    292 | Fragilariaceae    | Mf2.                     | Mf2.       | FAM     | GN          |     3 |
|    321 | Oscillatoriaceae  | Mf1.                     | Mf1.       | FAM     | GN          |     3 |
|    322 | Phormidiaceae     | Mf1.                     | Mf1.       | FAM     | GN          |     5 |
|    326 | Pseudanabaenaceae | Mf1.                     | Mf1.       | FAM     | GN          |     1 |
|    789 | Achnanthidium     | sp1.                     | sp1.       | GN      | SP          |     4 |
|    790 | Actinella         | sp1.                     | sp1.       | GN      | SP          |     5 |
|    790 | Actinella         | sp2.                     | sp2.       | GN      | SP          |     1 |
|    790 | Actinella         | sp3.                     | sp3.       | GN      | SP          |     5 |
|    790 | Actinella         | sp4.                     | sp4.       | GN      | SP          |     3 |
|    791 | Actinotaenium     | sp1.                     | sp1.       | GN      | SP          |     1 |
|    791 | Actinotaenium     | sp2.                     | sp2.       | GN      | SP          |     1 |
|    791 | Actinotaenium     | sp3.                     | sp3.       | GN      | SP          |     1 |
|    792 | Acutodesmus       | sp1.                     | sp1.       | GN      | SP          |     2 |
|    806 | Anabaena          | sp1.                     | sp1.       | GN      | SP          |    35 |
|    813 | Ankistrodesmus    | sp1.                     | sp1.       | GN      | SP          |    10 |
|    819 | Aphanocapsa       | sp1.                     | sp1.       | GN      | SP          |     2 |
|    826 | Arthrodesmus      | sp1.                     | sp1.       | GN      | SP          |     2 |
|    836 | Audouinella       | sp1.                     | sp1.       | GN      | SP          |     4 |
|    837 | Aulacoseira       | sp1.                     | sp1.       | GN      | SP          |    33 |
|    843 | Bambusina         | sp1.                     | sp1.       | GN      | SP          |    13 |
|    852 | Botryococcus      | sp1.                     | sp1.       | GN      | SP          |    17 |
|    858 | Brachysira        | sp1.                     | sp1.       | GN      | SP          |     1 |
|    865 | Bulbochaete       | sp1.                     | sp1.       | GN      | SP          |     1 |
|    880 | Capartogramma     | sp1.                     | sp1.       | GN      | SP          |     7 |
|    887 | Centritractus     | sp1.                     | sp1.       | GN      | SP          |     1 |
|    892 | Ceratium          | sp1.                     | sp1.       | GN      | SP          |     1 |
|    900 | Chlamydomonas     | sp1.                     | sp1.       | GN      | SP          |     5 |
|    906 | Closterium        | sp1.                     | sp1.       | GN      | SP          |     3 |
|    906 | Closterium        | sp10.                    | sp10.      | GN      | SP          |     2 |
|    906 | Closterium        | sp11.                    | sp11.      | GN      | SP          |     3 |
|    906 | Closterium        | sp12.                    | sp12.      | GN      | SP          |     4 |
|    906 | Closterium        | sp13.                    | sp13.      | GN      | SP          |     4 |
|    906 | Closterium        | sp14.                    | sp14.      | GN      | SP          |     1 |
|    906 | Closterium        | sp15.                    | sp15.      | GN      | SP          |     4 |
|    906 | Closterium        | sp16.                    | sp16.      | GN      | SP          |     1 |
|    906 | Closterium        | sp17.                    | sp17.      | GN      | SP          |     1 |
|    906 | Closterium        | sp2.                     | sp2.       | GN      | SP          |    28 |
|    906 | Closterium        | sp3.                     | sp3.       | GN      | SP          |    22 |
|    906 | Closterium        | sp4.                     | sp4.       | GN      | SP          |    29 |
|    906 | Closterium        | sp5.                     | sp5.       | GN      | SP          |     9 |
|    906 | Closterium        | sp6.                     | sp6.       | GN      | SP          |    27 |
|    906 | Closterium        | sp7.                     | sp7.       | GN      | SP          |    19 |
|    906 | Closterium        | sp8.                     | sp8.       | GN      | SP          |     4 |
|    906 | Closterium        | sp9.                     | sp9.       | GN      | SP          |     5 |
|    909 | Coelastrum        | sp1.                     | sp1.       | GN      | SP          |    35 |
|    910 | Coelosphaerium    | sp1.                     | sp1.       | GN      | SP          |     5 |
|    915 | Comasiella        | sp1.                     | sp1.       | GN      | SP          |     3 |
|    922 | Cosmarium         | sp1.                     | sp1.       | GN      | SP          |     1 |
|    922 | Cosmarium         | sp10.                    | sp10.      | GN      | SP          |     2 |
|    922 | Cosmarium         | sp11.                    | sp11.      | GN      | SP          |     1 |
|    922 | Cosmarium         | sp12.                    | sp12.      | GN      | SP          |     6 |
|    922 | Cosmarium         | sp13.                    | sp13.      | GN      | SP          |     1 |
|    922 | Cosmarium         | sp14.                    | sp14.      | GN      | SP          |     2 |
|    922 | Cosmarium         | sp15.                    | sp15.      | GN      | SP          |     5 |
|    922 | Cosmarium         | sp16.                    | sp16.      | GN      | SP          |     1 |
|    922 | Cosmarium         | sp2.                     | sp2.       | GN      | SP          |     2 |
|    922 | Cosmarium         | sp3.                     | sp3.       | GN      | SP          |    18 |
|    922 | Cosmarium         | sp4.                     | sp4.       | GN      | SP          |     1 |
|    922 | Cosmarium         | sp5.                     | sp5.       | GN      | SP          |    23 |
|    922 | Cosmarium         | sp6.                     | sp6.       | GN      | SP          |     2 |
|    922 | Cosmarium         | sp7.                     | sp7.       | GN      | SP          |     6 |
|    922 | Cosmarium         | sp8.                     | sp8.       | GN      | SP          |     9 |
|    922 | Cosmarium         | sp9.                     | sp9.       | GN      | SP          |     2 |
|    929 | Crucigenia        | sp1.                     | sp1.       | GN      | SP          |     5 |
|    931 | Cryptomonas       | sp1.                     | sp1.       | GN      | SP          |    26 |
|    953 | Desmidium         | sp1.                     | sp1.       | GN      | SP          |    30 |
|    953 | Desmidium         | sp2.                     | sp2.       | GN      | SP          |     1 |
|    963 | Dictyosphaerium   | sp1.                     | sp1.       | GN      | SP          |     3 |
|    966 | Didymocystis      | cf. Didymocystis sp.     | NA         | GN      | SP          |    12 |
|    967 | Dimorphococcus    | sp1.                     | sp1.       | GN      | SP          |    15 |
|    968 | Dinobryon         | sp1.                     | sp1.       | GN      | SP          |     1 |
|    971 | Dolichospermum    | sp1.                     | sp1.       | GN      | SP          |     5 |
|    984 | Encyonema         | sp1.                     | sp1.       | GN      | SP          |     2 |
|    984 | Encyonema         | sp2.                     | sp2.       | GN      | SP          |     3 |
|    985 | Encyonopsis       | cf. Encyonopsis sp.      | NA         | GN      | SP          |     1 |
|    985 | Encyonopsis       | sp1.                     | sp1.       | GN      | SP          |     3 |
|    998 | Euastrum          | sp1.                     | sp1.       | GN      | SP          |     1 |
|    998 | Euastrum          | sp2.                     | sp2.       | GN      | SP          |     1 |
|    998 | Euastrum          | sp3.                     | sp3.       | GN      | SP          |     7 |
|    998 | Euastrum          | sp4.                     | sp4.       | GN      | SP          |     3 |
|    998 | Euastrum          | sp5.                     | sp5.       | GN      | SP          |     5 |
|    998 | Euastrum          | sp6.                     | sp6.       | GN      | SP          |     1 |
|    998 | Euastrum          | sp7.                     | sp7.       | GN      | SP          |     1 |
|    999 | Eudorina          | sp1.                     | sp1.       | GN      | SP          |    62 |
|   1001 | Euglena           | sp1.                     | sp1.       | GN      | SP          |    30 |

Displaying records 1 - 100

</div>

``` sql
INSERT INTO main.morfo_taxo(cd_gp_biol, cd_tax, name_morfo, verbatim_taxon, pseudo_rank)
WITH a AS(
SELECT cd_tax,scientific_name,
  identification_qualifier,
  CASE 
    WHEN identification_qualifier ~ '^[Mm]f[0-9]\.' THEN 'Mf'||REGEXP_REPLACE(identification_qualifier,'^[Mm]f([0-9])\.','\1')||'.'
    WHEN identification_qualifier ~ '^sp[0-9]{1,2}\.' THEN identification_qualifier
    WHEN identification_qualifier ~ '^cf. [A-Z][a-z]+ sp\.$' THEN 'sp.'
    ELSE NULL
  END name_morfo,
  cd_rank,
  CASE
    WHEN cd_rank='GN' THEN 'SP'
    WHEN cd_rank='TR' THEN 'GN'
    WHEN cd_rank='SFAM' THEN 'GN'
    WHEN cd_rank='FAM' THEN 'GN'
    WHEN cd_rank='SOR' THEN 'FAM'
    WHEN cd_rank='OR' THEN 'FAM'
    WHEN cd_rank='CL' THEN 'OR'
    WHEN cd_rank='PHY' THEN 'CL'
    WHEN cd_rank='KG' THEN 'PHY'
    ELSE 'ERROR_RANK'
  END pseudo_rank
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE /*rank_level>10 AND */table_orig='hidrobiologico_registros_fitoplancton'
  AND (identification_qualifier IS NOT NULL)
)
SELECT 'fipl',cd_tax,name_morfo,scientific_name||' '||name_morfo,pseudo_rank
FROM a
WHERE name_morfo IS NOT NULL
GROUP BY cd_tax,pseudo_rank,scientific_name,name_morfo
ORDER BY cd_tax,name_morfo
RETURNING main.morfo_taxo.cd_morfo, main.morfo_taxo.verbatim_taxon
```

Dar cd_morfo en taxonomy_total

``` sql
UPDATE raw_dwc.taxonomy_total AS tt
SET cd_morfo=m.cd_morfo
FROM main.morfo_taxo m
WHERE m.cd_gp_biol='fipl' AND tt.table_orig='hidrobiologico_registros_fitoplancton' 
  AND tt.cd_tax=m.cd_tax
  AND (
   CASE 
      WHEN tt.identification_qualifier ~ '^[Mm]f[0-9]\.' THEN 'Mf'||REGEXP_REPLACE(tt.identification_qualifier,'^[Mm]f([0-9])\.','\1')||'.'
      WHEN tt.identification_qualifier ~ '^sp[0-9]{1,2}\.' THEN tt.identification_qualifier
      WHEN tt.identification_qualifier ~ '^cf. [A-Z][a-z]+ sp\.$' THEN 'sp.'
      ELSE NULL
    END = m.name_morfo)
RETURNING tt."row.names", tt.cd_morfo
```

## 6.10 Perifiton

Mismo problema de minuscula/mayuscula y mismo problema de mf vs sp

``` sql
SELECT cd_tax,scientific_name,
  identification_qualifier,
  CASE 
    WHEN identification_qualifier ~ '^[Mm]f[0-9]{1,2}\.' THEN 'Mf'||REGEXP_REPLACE(identification_qualifier,'^[Mm]f([0-9]{1,2})\.','\1')||'.'
    WHEN identification_qualifier ~ '^sp[0-9]{1,2}\.' THEN identification_qualifier
    ELSE NULL
  END name_morfo,
  cd_rank,
  CASE
    WHEN cd_rank='GN' THEN 'SP'
    WHEN cd_rank='TR' THEN 'GN'
    WHEN cd_rank='SFAM' THEN 'GN'
    WHEN cd_rank='FAM' THEN 'GN'
    WHEN cd_rank='SOR' THEN 'FAM'
    WHEN cd_rank='OR' THEN 'FAM'
    WHEN cd_rank='CL' THEN 'OR'
    WHEN cd_rank='PHY' THEN 'CL'
    WHEN cd_rank='KG' THEN 'PHY'
    ELSE 'ERROR_RANK'
  END pseudo_rank,
count(*)
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE /*rank_level>10 AND */table_orig='hidrobiologico_registros_perifiton'
  AND (identification_qualifier IS NOT NULL)
GROUP BY cd_tax,cd_rank,scientific_name,identification_qualifier,identification_remarks
ORDER BY cd_tax,identification_qualifier
```

<div class="knitsql-table">

| cd_tax | scientific_name   | identification_qualifier | name_morfo | cd_rank | pseudo_rank | count |
|-------:|:------------------|:-------------------------|:-----------|:--------|:------------|------:|
|     32 | Chlorophyceae     | Mf1.                     | Mf1.       | CL      | OR          |     1 |
|     37 | Ulvophyceae       | Mf1.                     | Mf1.       | CL      | OR          |     2 |
|     79 | Achnanthales      | Mf1.                     | Mf1.       | OR      | FAM         |     1 |
|     80 | Chlamydomonadales | Mf1.                     | Mf1.       | OR      | FAM         |     3 |
|     92 | Oscillatoriales   | Mf1.                     | Mf1.       | OR      | FAM         |     1 |
|     96 | Sphaeropleales    | Mf1.                     | Mf1.       | OR      | FAM         |     2 |
|     99 | Synechococcaceae  | Mf1.                     | Mf1.       | OR      | FAM         |     1 |
|    266 | Achnanthidiaceae  | Mf1.                     | Mf1.       | FAM     | GN          |    42 |
|    266 | Achnanthidiaceae  | Mf10.                    | Mf10.      | FAM     | GN          |     5 |
|    266 | Achnanthidiaceae  | Mf11.                    | Mf11.      | FAM     | GN          |     1 |
|    266 | Achnanthidiaceae  | Mf12.                    | Mf12.      | FAM     | GN          |    11 |
|    266 | Achnanthidiaceae  | Mf13.                    | Mf13.      | FAM     | GN          |     3 |
|    266 | Achnanthidiaceae  | Mf14.                    | Mf14.      | FAM     | GN          |     3 |
|    266 | Achnanthidiaceae  | Mf15.                    | Mf15.      | FAM     | GN          |     5 |
|    266 | Achnanthidiaceae  | Mf16.                    | Mf16.      | FAM     | GN          |     6 |
|    266 | Achnanthidiaceae  | Mf17.                    | Mf17.      | FAM     | GN          |     2 |
|    266 | Achnanthidiaceae  | Mf2.                     | Mf2.       | FAM     | GN          |     7 |
|    266 | Achnanthidiaceae  | Mf3.                     | Mf3.       | FAM     | GN          |    24 |
|    266 | Achnanthidiaceae  | Mf4.                     | Mf4.       | FAM     | GN          |     5 |
|    266 | Achnanthidiaceae  | Mf5.                     | Mf5.       | FAM     | GN          |    17 |
|    266 | Achnanthidiaceae  | Mf6.                     | Mf6.       | FAM     | GN          |     8 |
|    266 | Achnanthidiaceae  | Mf7.                     | Mf7.       | FAM     | GN          |    13 |
|    266 | Achnanthidiaceae  | Mf8.                     | Mf8.       | FAM     | GN          |     2 |
|    266 | Achnanthidiaceae  | Mf9.                     | Mf9.       | FAM     | GN          |    20 |
|    275 | Chroococcaceae    | Mf1.                     | Mf1.       | FAM     | GN          |     1 |
|    296 | Gomphonemataceae  | Mf1.                     | Mf1.       | FAM     | GN          |     2 |
|    321 | Oscillatoriaceae  | Mf1.                     | Mf1.       | FAM     | GN          |     5 |
|    326 | Pseudanabaenaceae | Mf1.                     | Mf1.       | FAM     | GN          |    17 |
|    342 | Ulotrichaceae     | Mf1.                     | Mf1.       | FAM     | GN          |     2 |
|    789 | Achnanthidium     | sp1.                     | sp1.       | GN      | SP          |     2 |
|    789 | Achnanthidium     | sp2.                     | sp2.       | GN      | SP          |     8 |
|    789 | Achnanthidium     | sp3.                     | sp3.       | GN      | SP          |     2 |
|    790 | Actinella         | sp1.                     | sp1.       | GN      | SP          |     4 |
|    790 | Actinella         | sp2.                     | sp2.       | GN      | SP          |     2 |
|    790 | Actinella         | sp3.                     | sp3.       | GN      | SP          |     3 |
|    790 | Actinella         | sp4.                     | sp4.       | GN      | SP          |     1 |
|    791 | Actinotaenium     | sp1.                     | sp1.       | GN      | SP          |     1 |
|    791 | Actinotaenium     | sp2.                     | sp2.       | GN      | SP          |     3 |
|    791 | Actinotaenium     | sp3.                     | sp3.       | GN      | SP          |     1 |
|    792 | Acutodesmus       | sp1.                     | sp1.       | GN      | SP          |     1 |
|    806 | Anabaena          | sp1.                     | sp1.       | GN      | SP          |    24 |
|    810 | Aneumastus        | cf. Aneumastus sp.       | NA         | GN      | SP          |     4 |
|    813 | Ankistrodesmus    | sp1.                     | sp1.       | GN      | SP          |    11 |
|    816 | Anomoeoneis       | sp1.                     | sp1.       | GN      | SP          |     2 |
|    836 | Audouinella       | cf. Audouinella sp.      | NA         | GN      | SP          |     1 |
|    836 | Audouinella       | sp1.                     | sp1.       | GN      | SP          |    17 |
|    836 | Audouinella       | sp2.                     | sp2.       | GN      | SP          |     2 |
|    837 | Aulacoseira       | sp1.                     | sp1.       | GN      | SP          |    17 |
|    842 | Ballia            | sp1.                     | sp1.       | GN      | SP          |     6 |
|    843 | Bambusina         | sp1.                     | sp1.       | GN      | SP          |     2 |
|    852 | Botryococcus      | sp1.                     | sp1.       | GN      | SP          |     5 |
|    865 | Bulbochaete       | sp1.                     | sp1.       | GN      | SP          |     3 |
|    871 | Caloneis          | sp1.                     | sp1.       | GN      | SP          |     2 |
|    880 | Capartogramma     | sp1.                     | sp1.       | GN      | SP          |    10 |
|    887 | Centritractus     | sp1.                     | sp1.       | GN      | SP          |     1 |
|    899 | Characium         | sp1.                     | sp1.       | GN      | SP          |     7 |
|    899 | Characium         | sp2.                     | sp2.       | GN      | SP          |     1 |
|    900 | Chlamydomonas     | sp1.                     | sp1.       | GN      | SP          |     9 |
|    901 | Chroococcus       | sp1.                     | sp1.       | GN      | SP          |     1 |
|    903 | Cladophora        | sp1.                     | sp1.       | GN      | SP          |     7 |
|    906 | Closterium        | sp1.                     | sp1.       | GN      | SP          |    25 |
|    906 | Closterium        | sp10.                    | sp10.      | GN      | SP          |    11 |
|    906 | Closterium        | sp11.                    | sp11.      | GN      | SP          |     2 |
|    906 | Closterium        | sp12.                    | sp12.      | GN      | SP          |     4 |
|    906 | Closterium        | sp13.                    | sp13.      | GN      | SP          |     1 |
|    906 | Closterium        | sp14.                    | sp14.      | GN      | SP          |     1 |
|    906 | Closterium        | sp2.                     | sp2.       | GN      | SP          |    16 |
|    906 | Closterium        | sp3.                     | sp3.       | GN      | SP          |     9 |
|    906 | Closterium        | sp4.                     | sp4.       | GN      | SP          |     6 |
|    906 | Closterium        | sp5.                     | sp5.       | GN      | SP          |     3 |
|    906 | Closterium        | sp6.                     | sp6.       | GN      | SP          |     6 |
|    906 | Closterium        | sp7.                     | sp7.       | GN      | SP          |     4 |
|    906 | Closterium        | sp8.                     | sp8.       | GN      | SP          |     7 |
|    906 | Closterium        | sp9.                     | sp9.       | GN      | SP          |     4 |
|    909 | Coelastrum        | sp1.                     | sp1.       | GN      | SP          |    18 |
|    922 | Cosmarium         | sp1.                     | sp1.       | GN      | SP          |    28 |
|    922 | Cosmarium         | sp10.                    | sp10.      | GN      | SP          |     4 |
|    922 | Cosmarium         | sp11.                    | sp11.      | GN      | SP          |     1 |
|    922 | Cosmarium         | sp12.                    | sp12.      | GN      | SP          |     1 |
|    922 | Cosmarium         | sp13.                    | sp13.      | GN      | SP          |     2 |
|    922 | Cosmarium         | sp14.                    | sp14.      | GN      | SP          |    11 |
|    922 | Cosmarium         | sp15.                    | sp15.      | GN      | SP          |     1 |
|    922 | Cosmarium         | sp16.                    | sp16.      | GN      | SP          |     1 |
|    922 | Cosmarium         | sp17.                    | sp17.      | GN      | SP          |     7 |
|    922 | Cosmarium         | sp18.                    | sp18.      | GN      | SP          |     1 |
|    922 | Cosmarium         | sp19.                    | sp19.      | GN      | SP          |     1 |
|    922 | Cosmarium         | sp2.                     | sp2.       | GN      | SP          |    18 |
|    922 | Cosmarium         | sp20.                    | sp20.      | GN      | SP          |     3 |
|    922 | Cosmarium         | sp21.                    | sp21.      | GN      | SP          |     2 |
|    922 | Cosmarium         | sp22.                    | sp22.      | GN      | SP          |     1 |
|    922 | Cosmarium         | sp23.                    | sp23.      | GN      | SP          |     4 |
|    922 | Cosmarium         | sp24.                    | sp24.      | GN      | SP          |     1 |
|    922 | Cosmarium         | sp25.                    | sp25.      | GN      | SP          |     1 |
|    922 | Cosmarium         | sp26.                    | sp26.      | GN      | SP          |     1 |
|    922 | Cosmarium         | sp27.                    | sp27.      | GN      | SP          |     1 |
|    922 | Cosmarium         | sp28.                    | sp28.      | GN      | SP          |     1 |
|    922 | Cosmarium         | sp3.                     | sp3.       | GN      | SP          |    32 |
|    922 | Cosmarium         | sp4.                     | sp4.       | GN      | SP          |    19 |
|    922 | Cosmarium         | sp5.                     | sp5.       | GN      | SP          |     3 |
|    922 | Cosmarium         | sp6.                     | sp6.       | GN      | SP          |     2 |

Displaying records 1 - 100

</div>

``` sql
INSERT INTO main.morfo_taxo(cd_gp_biol, cd_tax, name_morfo, verbatim_taxon, pseudo_rank)
WITH a AS(
SELECT cd_tax,scientific_name,
  identification_qualifier,
  CASE 
    WHEN identification_qualifier ~ '^[Mm]f[0-9]{1,2}\.' THEN 'Mf'||REGEXP_REPLACE(identification_qualifier,'^[Mm]f([0-9]{1,2})\.','\1')||'.'
    WHEN identification_qualifier ~ '^sp[0-9]{1,2}\.' THEN identification_qualifier
    ELSE NULL
  END name_morfo,
  cd_rank,
  CASE
    WHEN cd_rank='GN' THEN 'SP'
    WHEN cd_rank='TR' THEN 'GN'
    WHEN cd_rank='SFAM' THEN 'GN'
    WHEN cd_rank='FAM' THEN 'GN'
    WHEN cd_rank='SOR' THEN 'FAM'
    WHEN cd_rank='OR' THEN 'FAM'
    WHEN cd_rank='CL' THEN 'OR'
    WHEN cd_rank='PHY' THEN 'CL'
    WHEN cd_rank='KG' THEN 'PHY'
    ELSE 'ERROR_RANK'
  END pseudo_rank
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE /*rank_level>10 AND */table_orig='hidrobiologico_registros_perifiton'
  AND (identification_qualifier IS NOT NULL)
)
SELECT 'peri',cd_tax,name_morfo,scientific_name||' '||name_morfo,pseudo_rank
FROM a
WHERE name_morfo IS NOT NULL
GROUP BY cd_tax,pseudo_rank,scientific_name,name_morfo
ORDER BY cd_tax,name_morfo
RETURNING main.morfo_taxo.cd_morfo, main.morfo_taxo.verbatim_taxon
```

Dar cd_morfo en taxonomy_total

``` sql
UPDATE raw_dwc.taxonomy_total AS tt
SET cd_morfo=m.cd_morfo
FROM main.morfo_taxo m
WHERE m.cd_gp_biol='peri' AND tt.table_orig='hidrobiologico_registros_perifiton' 
  AND tt.cd_tax=m.cd_tax
  AND (
   CASE 
      WHEN tt.identification_qualifier ~ '^[Mm]f[0-9]{1,2}\.' THEN 'Mf'||REGEXP_REPLACE(tt.identification_qualifier,'^[Mm]f([0-9]{1,2})\.','\1')||'.'
      WHEN tt.identification_qualifier ~ '^sp[0-9]{1,2}\.' THEN tt.identification_qualifier
      ELSE NULL
    END = m.name_morfo)
RETURNING tt."row.names", tt.cd_morfo
```

## 6.11 Mamiferos

No morfotipos, scientificName es lo que hay!

## 6.12 Mariposas

Parece que solo hay Cynea sp1 y Cynea sp2

``` sql
SELECT cd_tax,scientific_name,
  identification_qualifier,
  CASE 
    WHEN identification_qualifier ~ '^sp[0-9]{1,2}' THEN identification_qualifier
    ELSE NULL
  END name_morfo,
  cd_rank,
  CASE
    WHEN cd_rank='GN' THEN 'SP'
    WHEN cd_rank='TR' THEN 'GN'
    WHEN cd_rank='SFAM' THEN 'GN'
    WHEN cd_rank='FAM' THEN 'GN'
    WHEN cd_rank='SOR' THEN 'FAM'
    WHEN cd_rank='OR' THEN 'FAM'
    WHEN cd_rank='CL' THEN 'OR'
    WHEN cd_rank='PHY' THEN 'CL'
    WHEN cd_rank='KG' THEN 'PHY'
    ELSE 'ERROR_RANK'
  END pseudo_rank,
count(*)
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE /*rank_level>10 AND */table_orig='mariposas_registros'
  AND (identification_qualifier IS NOT NULL)
GROUP BY cd_tax,cd_rank,scientific_name,identification_qualifier,identification_remarks
ORDER BY cd_tax,identification_qualifier
```

<div class="knitsql-table">

| cd_tax | scientific_name                 | identification_qualifier | name_morfo | cd_rank | pseudo_rank | count |
|-------:|:--------------------------------|:-------------------------|:-----------|:--------|:------------|------:|
|    941 | Cynea                           | sp1                      | sp1        | GN      | SP          |     2 |
|    941 | Cynea                           | sp2                      | sp2        | GN      | SP          |     1 |
|    947 | Decinea                         | sp.                      | NA         | GN      | SP          |     1 |
|   1146 | Mesosemia                       | sp.                      | NA         | GN      | SP          |     1 |
|   1161 | Modestia                        | sp.                      | NA         | GN      | SP          |    23 |
|   1174 | Mylon                           | sp.                      | NA         | GN      | SP          |     1 |
|   1340 | Staphylus                       | sp.                      | NA         | GN      | SP          |     2 |
|   2379 | Calephelis laverna              | cf. laverna              | NA         | SP      | ERROR_RANK  |     3 |
|   2385 | Callimormus corus               | cf. corus                | NA         | SP      | ERROR_RANK  |     1 |
|   2390 | Calycopis trebula               | cf. trebula              | NA         | SP      | ERROR_RANK  |     1 |
|   2592 | Cynea corisana                  | cf. corisana             | NA         | SP      | ERROR_RANK  |     1 |
|   2593 | Cynea popla                     | cf. popla                | NA         | SP      | ERROR_RANK  |    72 |
|   3096 | Nisoniades benda                | cf. benda                | NA         | SP      | ERROR_RANK  |     2 |
|   3097 | Nisoniades bessus               | cf. bessus               | NA         | SP      | ERROR_RANK  |     7 |
|   3739 | Pyrrhopyge phidias latifasciata | cf. phidias latifasciata | NA         | SUBSP   | ERROR_RANK  |     2 |

15 records

</div>

``` sql
INSERT INTO main.morfo_taxo(cd_gp_biol, cd_tax, name_morfo, verbatim_taxon, pseudo_rank)
WITH a AS(
SELECT cd_tax,scientific_name,
  identification_qualifier,
  CASE 
    WHEN identification_qualifier ~ '^sp[0-9]{1,2}' THEN identification_qualifier
    ELSE NULL
  END name_morfo,
  cd_rank,
  CASE
    WHEN cd_rank='GN' THEN 'SP'
    WHEN cd_rank='TR' THEN 'GN'
    WHEN cd_rank='SFAM' THEN 'GN'
    WHEN cd_rank='FAM' THEN 'GN'
    WHEN cd_rank='SOR' THEN 'FAM'
    WHEN cd_rank='OR' THEN 'FAM'
    WHEN cd_rank='CL' THEN 'OR'
    WHEN cd_rank='PHY' THEN 'CL'
    WHEN cd_rank='KG' THEN 'PHY'
    ELSE 'ERROR_RANK'
  END pseudo_rank
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE /*rank_level>10 AND */table_orig='mariposas_registros'
  AND (identification_qualifier IS NOT NULL)
)
SELECT 'mari',cd_tax,name_morfo, scientific_name||' '||name_morfo AS verbatim_taxon, pseudo_rank
FROM a
WHERE name_morfo IS NOT NULL
GROUP BY cd_tax,cd_rank,scientific_name, pseudo_rank, name_morfo
ORDER BY cd_tax, name_morfo
RETURNING main.morfo_taxo.cd_morfo, verbatim_taxon
```

``` sql
UPDATE raw_dwc.taxonomy_total AS tt
SET cd_morfo=m.cd_morfo
FROM main.morfo_taxo m
WHERE m.cd_gp_biol='mari' AND tt.table_orig='mariposas_registros' 
  AND tt.cd_tax=m.cd_tax
  AND (
   CASE 
      WHEN tt.identification_qualifier ~ '^sp[0-9]{1,2}' THEN tt.identification_qualifier
      ELSE NULL
    END = m.name_morfo)
RETURNING tt."row.names", tt.cd_morfo
```

## 6.13 Peces

Parece que existen sp1 y sp2 principalmente

No sé que hacer con: ‘Gen. nov. et sp. nov.’

``` sql
SELECT *
FROM raw_dwc.taxonomy_total
WHERE identification_qualifier = 'Gen. nov. et sp. nov.'
```

<div class="knitsql-table">

| table_orig      | row.names | kingdom  | phylum   | class          | order        | family        | subfamily | genus | specific_epithet | infraspecific_epithet | scientific_name | scientific_name_authorship | taxon_rank | vernacular_name | identification_qualifier | identification_remarks | cd_tax | cd_morfo |
|:----------------|:----------|:---------|:---------|:---------------|:-------------|:--------------|:----------|:------|:-----------------|:----------------------|:----------------|:---------------------------|:-----------|:----------------|:-------------------------|:-----------------------|-------:|---------:|
| peces_registros | 811       | Animalia | Chordata | Actinopterygii | Siluriformes | Heptapteridae | NA        |       |                  | NA                    | Heptapterinae   |                            | Subfamilia | NA              | Gen. nov. et sp. nov.    | NA                     |    756 |       NA |
| peces_registros | 1010      | Animalia | Chordata | Actinopterygii | Siluriformes | Heptapteridae | NA        | NA    | NA               | NA                    | Heptapterinae   | NA                         | Subfamilia | NA              | Gen. nov. et sp. nov.    | NA                     |    756 |       NA |
| peces_registros | 1830      | Animalia | Chordata | Actinopterygii | Siluriformes | Heptapteridae | NA        | NA    | NA               | NA                    | Heptapterinae   | NA                         | Subfamilia | NA              | Gen. nov. et sp. nov.    | NA                     |    756 |       NA |
| peces_registros | 1485      | Animalia | Chordata | Actinopterygii | Siluriformes | Heptapteridae | NA        | NA    | NA               | NA                    | Heptapterinae   | NA                         | Subfamilia | NA              | Gen. nov. et sp. nov.    | NA                     |    756 |       NA |

4 records

</div>

``` sql
SELECT cd_tax,scientific_name,
  identification_qualifier,
  CASE 
    WHEN identification_qualifier ~ '^sp. [0-9]{1,2} *$' THEN REGEXP_REPLACE(identification_qualifier,'^(sp. [0-9]{1,2}) *$', '\1')
    WHEN identification_qualifier='Gen. nov. et sp. nov.' THEN identification_qualifier
    WHEN scientific_name IN ('Characidium','Hemibrycon','Hoplias','Hypostomus') THEN 'sp.'
    ELSE NULL
  END name_morfo,
  cd_rank,
  CASE
    WHEN identification_qualifier='Gen. nov. et sp. nov.' THEN 'SP'
    WHEN cd_rank='GN' THEN 'SP'
    WHEN cd_rank='TR' THEN 'GN'
    WHEN cd_rank='SFAM' THEN 'GN'
    WHEN cd_rank='FAM' THEN 'GN'
    WHEN cd_rank='SOR' THEN 'FAM'
    WHEN cd_rank='OR' THEN 'FAM'
    WHEN cd_rank='CL' THEN 'OR'
    WHEN cd_rank='PHY' THEN 'CL'
    WHEN cd_rank='KG' THEN 'PHY'
    ELSE 'ERROR_RANK'
  END pseudo_rank,
  identification_remarks,
count(*)
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE /*rank_level>10 AND */table_orig='peces_registros'
  AND (identification_qualifier IS NOT NULL OR identification_remarks IS NOT NULL)
GROUP BY cd_tax,cd_rank,scientific_name,identification_qualifier,identification_remarks
ORDER BY cd_tax,identification_qualifier
```

<div class="knitsql-table">

| cd_tax | scientific_name                | identification_qualifier | name_morfo            | cd_rank | pseudo_rank | identification_remarks | count |
|-------:|:-------------------------------|:-------------------------|:----------------------|:--------|:------------|:-----------------------|------:|
|    756 | Heptapterinae                  | Gen. nov. et sp. nov.    | Gen. nov. et sp. nov. | SFAM    | SP          | NA                     |     4 |
|    832 | Astyanax                       | sp. 1                    | sp. 1                 | GN      | SP          | NA                     |    37 |
|    832 | Astyanax                       | sp. 2                    | sp. 2                 | GN      | SP          | NA                     |    29 |
|    832 | Astyanax                       | sp. 2                    | sp. 2                 | GN      | SP          | NA                     |     6 |
|    898 | Characidium                    | sp.                      | sp.                   | GN      | SP          | NA                     |     1 |
|   1045 | Hemibrycon                     |                          | sp.                   | GN      | SP          | NA                     |     2 |
|   1059 | Hoplias                        |                          | sp.                   | GN      | SP          | NA                     |     1 |
|   1073 | Hypostomus                     |                          | sp.                   | GN      | SP          | NA                     |     1 |
|   1392 | Trichomycterus                 | sp. 1                    | sp. 1                 | GN      | SP          | NA                     |     5 |
|   1392 | Trichomycterus                 | sp. 2                    | sp. 2                 | GN      | SP          | NA                     |     2 |
|   1392 | Trichomycterus                 | sp. 2                    | sp. 2                 | GN      | SP          | NA                     |     2 |
|   2215 | Acestrocephalus anomalus       |                          | NA                    | SP      | ERROR_RANK  | NA                     |     2 |
|   2233 | Ageneiosus pardalis            |                          | NA                    | SP      | ERROR_RANK  | NA                     |     1 |
|   2259 | Ancistrus caucanus             |                          | NA                    | SP      | ERROR_RANK  | NA                     |     9 |
|   2260 | Andinoacara latifrons          |                          | NA                    | SP      | ERROR_RANK  | NA                     |    30 |
|   2278 | Apteronotus milesi             |                          | NA                    | SP      | ERROR_RANK  | NA                     |     5 |
|   2292 | Argopleura magdalenensis       |                          | NA                    | SP      | ERROR_RANK  | NA                     |     5 |
|   2313 | Astyanax filiferus             |                          | NA                    | SP      | ERROR_RANK  | NA                     |     5 |
|   2314 | Astyanax magdalenae            |                          | NA                    | SP      | ERROR_RANK  | NA                     |    38 |
|   2315 | Astyanax yariguies             |                          | NA                    | SP      | ERROR_RANK  | NA                     |     5 |
|   2346 | Brachyhypopomus occidentalis   |                          | NA                    | SP      | ERROR_RANK  | NA                     |     9 |
|   2355 | Brycon henni                   |                          | NA                    | SP      | ERROR_RANK  | NA                     |     1 |
|   2356 | Brycon moorei                  |                          | NA                    | SP      | ERROR_RANK  | NA                     |     1 |
|   2361 | Bunocephalus colombianus       |                          | NA                    | SP      | ERROR_RANK  | NA                     |    10 |
|   2381 | Callichthys oibaensis          |                          | NA                    | SP      | ERROR_RANK  | NA                     |     1 |
|   2420 | Caquetaia kraussii             |                          | NA                    | SP      | ERROR_RANK  | NA                     |    23 |
|   2471 | Cetopsis othonops              |                          | NA                    | SP      | ERROR_RANK  | NA                     |     1 |
|   2475 | Characidium boavistae          |                          | NA                    | SP      | ERROR_RANK  | NA                     |     2 |
|   2476 | Characidium zebra              |                          | NA                    | SP      | ERROR_RANK  | NA                     |    16 |
|   2476 | Characidium zebra              | cf. zebra                | NA                    | SP      | ERROR_RANK  | NA                     |     2 |
|   2551 | Creagrutus affinis             |                          | NA                    | SP      | ERROR_RANK  | NA                     |     3 |
|   2552 | Creagrutus magdalenae          |                          | NA                    | SP      | ERROR_RANK  | NA                     |     6 |
|   2571 | Crossoloricaria cephalaspis    |                          | NA                    | SP      | ERROR_RANK  | NA                     |     1 |
|   2572 | Crossoloricaria variegata      |                          | NA                    | SP      | ERROR_RANK  | NA                     |     3 |
|   2578 | Ctenolucius hujeta             |                          | NA                    | SP      | ERROR_RANK  | NA                     |    19 |
|   2583 | Curimata mivartii              |                          | NA                    | SP      | ERROR_RANK  | NA                     |     5 |
|   2595 | Cynopotamus magdalenae         |                          | NA                    | SP      | ERROR_RANK  | NA                     |     2 |
|   2601 | Cyphocharax magdalenae         |                          | NA                    | SP      | ERROR_RANK  | NA                     |    19 |
|   2610 | Dasyloricaria filamentosa      |                          | NA                    | SP      | ERROR_RANK  | NA                     |     3 |
|   2684 | Eigenmannia camposi            |                          | NA                    | SP      | ERROR_RANK  | NA                     |    26 |
|   2736 | Farlowella yarigui             |                          | NA                    | SP      | ERROR_RANK  | NA                     |     1 |
|   2763 | Gasteropelecus maculatus       |                          | NA                    | SP      | ERROR_RANK  | NA                     |    15 |
|   2766 | Geophagus steindachneri        |                          | NA                    | SP      | ERROR_RANK  | NA                     |     6 |
|   2769 | Gephyrocharax melanocheir      |                          | NA                    | SP      | ERROR_RANK  | NA                     |    13 |
|   2826 | Hoplias malabaricus            |                          | NA                    | SP      | ERROR_RANK  | NA                     |    10 |
|   2827 | Hoplosternum magdalenae        |                          | NA                    | SP      | ERROR_RANK  | NA                     |     4 |
|   2839 | Hyphessobrycon natagaima       |                          | NA                    | SP      | ERROR_RANK  | NA                     |    26 |
|   2839 | Hyphessobrycon natagaima       | aff. natagaima           | NA                    | SP      | ERROR_RANK  | NA                     |    44 |
|   2846 | Hypostomus hondae              |                          | NA                    | SP      | ERROR_RANK  | NA                     |     6 |
|   2849 | Ichthyoelephas longirostris    |                          | NA                    | SP      | ERROR_RANK  | NA                     |     1 |
|   2879 | Kronoheros umbrifer            |                          | NA                    | SP      | ERROR_RANK  | NA                     |     3 |
|   2918 | Leporinus striatus             |                          | NA                    | SP      | ERROR_RANK  | NA                     |     3 |
|   2943 | Loricariichthys brunneus       |                          | NA                    | SP      | ERROR_RANK  | NA                     |     1 |
|   2989 | Megaleporinus muyscorum        |                          | NA                    | SP      | ERROR_RANK  | NA                     |     5 |
|   2993 | Megalonema xanthum             |                          | NA                    | SP      | ERROR_RANK  | NA                     |     1 |
|   3074 | Nanocheirodon insignis         |                          | NA                    | SP      | ERROR_RANK  | NA                     |     6 |
|   3140 | Oreochromis niloticus          |                          | NA                    | SP      | ERROR_RANK  | NA                     |     2 |
|   3182 | Parodon magdalenensis          |                          | NA                    | SP      | ERROR_RANK  | NA                     |     2 |
|   3243 | Pimelodella floridablancaensis |                          | NA                    | SP      | ERROR_RANK  | NA                     |     6 |
|   3244 | Pimelodus grosskopfii          |                          | NA                    | SP      | ERROR_RANK  | NA                     |     5 |
|   3245 | Pimelodus yuma                 |                          | NA                    | SP      | ERROR_RANK  | NA                     |     5 |
|   3266 | Poecilia caucana               |                          | NA                    | SP      | ERROR_RANK  | NA                     |    27 |
|   3282 | Potamotrygon magdalenae        |                          | NA                    | SP      | ERROR_RANK  | NA                     |     1 |
|   3290 | Prochilodus magdalenae         |                          | NA                    | SP      | ERROR_RANK  | NA                     |    10 |
|   3316 | Pseudopimelodus atricaudus     |                          | NA                    | SP      | ERROR_RANK  | NA                     |     3 |
|   3344 | Rhamdia guatemalensis          |                          | NA                    | SP      | ERROR_RANK  | NA                     |     9 |
|   3355 | Rineloricaria magdalenae       |                          | NA                    | SP      | ERROR_RANK  | NA                     |    17 |
|   3361 | Rivulus xi                     |                          | NA                    | SP      | ERROR_RANK  | NA                     |     9 |
|   3362 | Roeboides dayi                 |                          | NA                    | SP      | ERROR_RANK  | NA                     |    21 |
|   3372 | Saccoderma hastata             |                          | NA                    | SP      | ERROR_RANK  | NA                     |    12 |
|   3443 | Sternopygus aequilabiatus      |                          | NA                    | SP      | ERROR_RANK  | NA                     |     5 |
|   3461 | Sturisomatichthys aureus       |                          | NA                    | SP      | ERROR_RANK  | NA                     |    10 |
|   3476 | Synbranchus marmoratus         |                          | NA                    | SP      | ERROR_RANK  | NA                     |     7 |
|   3524 | Trachelyopterus insignis       |                          | NA                    | SP      | ERROR_RANK  | NA                     |     7 |
|   3532 | Trichopodus pectoralis         |                          | NA                    | SP      | ERROR_RANK  | NA                     |     9 |
|   3533 | Trichopodus trichopterus       | aff. trichopterus        | NA                    | SP      | ERROR_RANK  | NA                     |     4 |
|   3537 | Triportheus magdalenae         |                          | NA                    | SP      | ERROR_RANK  | NA                     |     8 |

77 records

</div>

``` sql
INSERT INTO main.morfo_taxo(cd_gp_biol, cd_tax, name_morfo, verbatim_taxon, pseudo_rank)
WITH a AS(
SELECT cd_tax,scientific_name,
  identification_qualifier,
  CASE 
    WHEN identification_qualifier ~ '^sp. [0-9]{1,2} *$' THEN REGEXP_REPLACE(identification_qualifier,'^(sp. [0-9]{1,2}) *$', '\1')
    WHEN identification_qualifier='Gen. nov. et sp. nov.' THEN identification_qualifier
    WHEN scientific_name IN ('Characidium','Hemibrycon','Hoplias','Hypostomus') THEN 'sp.'
    ELSE NULL
  END name_morfo,
  cd_rank,
  CASE
    WHEN identification_qualifier='Gen. nov. et sp. nov.' THEN 'SP'
    WHEN cd_rank='GN' THEN 'SP'
    WHEN cd_rank='TR' THEN 'GN'
    WHEN cd_rank='SFAM' THEN 'GN'
    WHEN cd_rank='FAM' THEN 'GN'
    WHEN cd_rank='SOR' THEN 'FAM'
    WHEN cd_rank='OR' THEN 'FAM'
    WHEN cd_rank='CL' THEN 'OR'
    WHEN cd_rank='PHY' THEN 'CL'
    WHEN cd_rank='KG' THEN 'PHY'
    ELSE 'ERROR_RANK'
  END pseudo_rank
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE /*rank_level>10 AND */table_orig='peces_registros'
  AND (identification_qualifier IS NOT NULL OR identification_remarks IS NOT NULL)
)
SELECT 'pece',cd_tax,name_morfo, scientific_name||' '||name_morfo AS verbatim_taxon, pseudo_rank
FROM a
WHERE name_morfo IS NOT NULL
GROUP BY cd_tax,cd_rank,scientific_name, pseudo_rank, name_morfo
ORDER BY cd_tax, name_morfo
RETURNING main.morfo_taxo.cd_morfo, verbatim_taxon
```

``` sql
UPDATE raw_dwc.taxonomy_total AS tt
SET cd_morfo=m.cd_morfo
FROM main.morfo_taxo m
WHERE m.cd_gp_biol='pece' AND tt.table_orig='peces_registros' 
  AND tt.cd_tax=m.cd_tax
  AND (
   CASE 
    WHEN identification_qualifier ~ '^sp. [0-9]{1,2} *$' THEN REGEXP_REPLACE(identification_qualifier,'^(sp. [0-9]{1,2}) *$', '\1')
    WHEN identification_qualifier='Gen. nov. et sp. nov.' THEN identification_qualifier
    WHEN scientific_name IN ('Characidium','Hemibrycon','Hoplias','Hypostomus') THEN 'sp.'
    ELSE NULL
  END = m.name_morfo)
RETURNING tt."row.names", tt.cd_morfo
```

## 6.14 Hormigas

**Averiguar: *Genus sp.* tal vez no es la mejor manera para diferenciar
los morfotipos de los taxones que solo tienen un genero**

``` sql
SELECT cd_tax,scientific_name,
  identification_qualifier,
  CASE 
    WHEN identification_remarks ~ '^Morfotipo [0-9]{1,2} *$' THEN REGEXP_REPLACE(identification_remarks, '^(Morfotipo [0-9]{1,2}) *$', '\1')
    ELSE NULL
  END name_morfo,
  identification_remarks,
  cd_rank,
  CASE
    WHEN cd_rank='GN' THEN 'SP'
    WHEN cd_rank='TR' THEN 'GN'
    WHEN cd_rank='SFAM' THEN 'GN'
    WHEN cd_rank='FAM' THEN 'GN'
    WHEN cd_rank='SOR' THEN 'FAM'
    WHEN cd_rank='OR' THEN 'FAM'
    WHEN cd_rank='CL' THEN 'OR'
    WHEN cd_rank='PHY' THEN 'CL'
    WHEN cd_rank='KG' THEN 'PHY'
    ELSE 'ERROR_RANK'
  END pseudo_rank,
count(*)
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE /*rank_level>10 AND */table_orig='hormigas_registros'
  AND (identification_qualifier IS NOT NULL OR identification_remarks IS NOT NULL)
GROUP BY cd_tax,cd_rank,scientific_name,identification_qualifier,identification_remarks
ORDER BY cd_tax,identification_qualifier
```

<div class="knitsql-table">

| cd_tax | scientific_name  | identification_qualifier | name_morfo   | identification_remarks | cd_rank | pseudo_rank | count |
|-------:|:-----------------|:-------------------------|:-------------|:-----------------------|:--------|:------------|------:|
|    839 | Azteca           | sp.                      | Morfotipo 1  | Morfotipo 1            | GN      | SP          |     4 |
|    839 | Azteca           | sp.                      | Morfotipo 2  | Morfotipo 2            | GN      | SP          |    11 |
|    839 | Azteca           | sp.                      | Morfotipo 3  | Morfotipo 3            | GN      | SP          |    14 |
|    839 | Azteca           | sp.                      | Morfotipo 4  | Morfotipo 4            | GN      | SP          |    18 |
|    839 | Azteca           | sp.                      | Morfotipo 5  | Morfotipo 5            | GN      | SP          |     4 |
|    839 | Azteca           | sp.                      | Morfotipo 6  | Morfotipo 6            | GN      | SP          |     4 |
|    839 | Azteca           | sp.                      | Morfotipo 7  | Morfotipo 7            | GN      | SP          |     6 |
|    857 | Brachymyrmex     | sp.                      | Morfotipo 1  | Morfotipo 1            | GN      | SP          |     4 |
|    875 | Camponotus       | sp.                      | Morfotipo 1  | Morfotipo 1            | GN      | SP          |     6 |
|    875 | Camponotus       | sp.                      | Morfotipo 10 | Morfotipo 10           | GN      | SP          |     3 |
|    875 | Camponotus       | sp.                      | Morfotipo 11 | Morfotipo 11           | GN      | SP          |     2 |
|    875 | Camponotus       | sp.                      | Morfotipo 2  | Morfotipo 2            | GN      | SP          |     5 |
|    875 | Camponotus       | sp.                      | Morfotipo 3  | Morfotipo 3            | GN      | SP          |    41 |
|    875 | Camponotus       | sp.                      | Morfotipo 6  | Morfotipo 6            | GN      | SP          |     1 |
|    875 | Camponotus       | sp.                      | Morfotipo 8  | Morfotipo 8            | GN      | SP          |    29 |
|    875 | Camponotus       | sp.                      | Morfotipo 9  | Morfotipo 9            | GN      | SP          |     9 |
|    926 | Crematogaster    | sp.                      | Morfotipo 1  | Morfotipo 1            | GN      | SP          |     8 |
|    970 | Dolichoderus     | sp.                      | Morfotipo 1  | Morfotipo 1            | GN      | SP          |     5 |
|    970 | Dolichoderus     | sp.                      | Morfotipo 4  | Morfotipo 4            | GN      | SP          |     4 |
|    970 | Dolichoderus     | sp.                      | Morfotipo 5  | Morfotipo 5            | GN      | SP          |     5 |
|    970 | Dolichoderus     | sp.                      | Morfotipo 6  | Morfotipo 6            | GN      | SP          |     2 |
|    970 | Dolichoderus     | sp.                      | Morfotipo 7  | Morfotipo 7            | GN      | SP          |     1 |
|    970 | Dolichoderus     | sp.                      | Morfotipo 8  | Morfotipo 8            | GN      | SP          |     2 |
|   1072 | Hypoponera       | sp.                      | Morfotipo 1  | Morfotipo 1            | GN      | SP          |    33 |
|   1072 | Hypoponera       | sp.                      | Morfotipo 11 | Morfotipo 11           | GN      | SP          |     1 |
|   1072 | Hypoponera       | sp.                      | Morfotipo 12 | Morfotipo 12           | GN      | SP          |     2 |
|   1072 | Hypoponera       | sp.                      | Morfotipo 13 | Morfotipo 13           | GN      | SP          |     1 |
|   1072 | Hypoponera       | sp.                      | Morfotipo 14 | Morfotipo 14           | GN      | SP          |     1 |
|   1072 | Hypoponera       | sp.                      | Morfotipo 15 | Morfotipo 15           | GN      | SP          |     1 |
|   1072 | Hypoponera       | sp.                      | Morfotipo 16 | Morfotipo 16           | GN      | SP          |     2 |
|   1072 | Hypoponera       | sp.                      | Morfotipo 17 | Morfotipo 17           | GN      | SP          |     1 |
|   1072 | Hypoponera       | sp.                      | Morfotipo 18 | Morfotipo 18           | GN      | SP          |     1 |
|   1072 | Hypoponera       | sp.                      | Morfotipo 19 | Morfotipo 19           | GN      | SP          |     1 |
|   1072 | Hypoponera       | sp.                      | Morfotipo 3  | Morfotipo 3            | GN      | SP          |     2 |
|   1072 | Hypoponera       | sp.                      | Morfotipo 4  | Morfotipo 4            | GN      | SP          |    13 |
|   1072 | Hypoponera       | sp.                      | Morfotipo 6  | Morfotipo 6            | GN      | SP          |     6 |
|   1072 | Hypoponera       | sp.                      | Morfotipo 7  | Morfotipo 7            | GN      | SP          |     2 |
|   1072 | Hypoponera       | sp.                      | Morfotipo 9  | Morfotipo 9            | GN      | SP          |     2 |
|   1112 | Linepithema      | sp.                      | Morfotipo 1  | Morfotipo 1            | GN      | SP          |     1 |
|   1172 | Mycetomoellerius | sp.                      | Morfotipo 1  | Morfotipo 1            | GN      | SP          |     2 |
|   1197 | Nylanderia       | sp.                      | Morfotipo 1  | Morfotipo 1            | GN      | SP          |     9 |
|   1246 | Pheidole         | sp.                      | Morfotipo 1  | Morfotipo 1            | GN      | SP          |    53 |
|   1246 | Pheidole         | sp.                      | Morfotipo 10 | Morfotipo 10           | GN      | SP          |     1 |
|   1246 | Pheidole         | sp.                      | Morfotipo 2  | Morfotipo 2            | GN      | SP          |    12 |
|   1246 | Pheidole         | sp.                      | Morfotipo 3  | Morfotipo 3            | GN      | SP          |     2 |
|   1246 | Pheidole         | sp.                      | Morfotipo 4  | Morfotipo 4            | GN      | SP          |     3 |
|   1246 | Pheidole         | sp.                      | Morfotipo 5  | Morfotipo 5            | GN      | SP          |     1 |
|   1246 | Pheidole         | sp.                      | Morfotipo 6  | Morfotipo 6            | GN      | SP          |    47 |
|   1246 | Pheidole         | sp.                      | Morfotipo 7  | Morfotipo 7            | GN      | SP          |     3 |
|   1288 | Pseudomyrmex     | sp.                      | Morfotipo 1  | Morfotipo 1            | GN      | SP          |     1 |
|   1288 | Pseudomyrmex     | sp.                      | Morfotipo 10 | Morfotipo 10           | GN      | SP          |     2 |
|   1288 | Pseudomyrmex     | sp.                      | Morfotipo 11 | Morfotipo 11           | GN      | SP          |     2 |
|   1288 | Pseudomyrmex     | sp.                      | Morfotipo 12 | Morfotipo 12           | GN      | SP          |     1 |
|   1288 | Pseudomyrmex     | sp.                      | Morfotipo 13 | Morfotipo 13           | GN      | SP          |     2 |
|   1288 | Pseudomyrmex     | sp.                      | Morfotipo 14 | Morfotipo 14           | GN      | SP          |     1 |
|   1288 | Pseudomyrmex     | sp.                      | Morfotipo 15 | Morfotipo 15           | GN      | SP          |     2 |
|   1288 | Pseudomyrmex     | sp.                      | Morfotipo 17 | Morfotipo 17           | GN      | SP          |     1 |
|   1288 | Pseudomyrmex     | sp.                      | Morfotipo 3  | Morfotipo 3            | GN      | SP          |     1 |
|   1307 | Rhopalothrix     | sp.                      | Morfotipo 1  | Morfotipo 1            | GN      | SP          |    17 |
|   1331 | Solenopsis       | sp.                      | Morfotipo 1  | Morfotipo 1            | GN      | SP          |   481 |
|   1331 | Solenopsis       | sp.                      | Morfotipo 10 | Morfotipo 10           | GN      | SP          |    17 |
|   1331 | Solenopsis       | sp.                      | Morfotipo 11 | Morfotipo 11           | GN      | SP          |    10 |
|   1331 | Solenopsis       | sp.                      | Morfotipo 12 | Morfotipo 12           | GN      | SP          |     1 |
|   1331 | Solenopsis       | sp.                      | Morfotipo 3  | Morfotipo 3            | GN      | SP          |   157 |
|   1331 | Solenopsis       | sp.                      | Morfotipo 4  | Morfotipo 4            | GN      | SP          |     9 |
|   1331 | Solenopsis       | sp.                      | Morfotipo 5  | Morfotipo 5            | GN      | SP          |     1 |
|   1331 | Solenopsis       | sp.                      | Morfotipo 6  | Morfotipo 6            | GN      | SP          |     2 |
|   1331 | Solenopsis       | sp.                      | Morfotipo 7  | Morfotipo 7            | GN      | SP          |     1 |
|   1331 | Solenopsis       | sp.                      | Morfotipo 9  | Morfotipo 9            | GN      | SP          |    11 |
|   1356 | Strumigenys      | sp.                      | Morfotipo 2  | Morfotipo 2            | GN      | SP          |     1 |
|   1417 | Xenomyrmex       | sp.                      | Morfotipo 1  | Morfotipo 1            | GN      | SP          |     1 |

71 records

</div>

``` sql
INSERT INTO main.morfo_taxo(cd_gp_biol, cd_tax, name_morfo, verbatim_taxon, pseudo_rank)
WITH a AS(
SELECT cd_tax,scientific_name,
  identification_qualifier,
  CASE 
    WHEN identification_remarks ~ '^Morfotipo [0-9]{1,2} *$' THEN REGEXP_REPLACE(identification_remarks, '^(Morfotipo [0-9]{1,2}) *$', '\1')
    ELSE NULL
  END name_morfo,
  cd_rank,
  CASE
    WHEN cd_rank='GN' THEN 'SP'
    WHEN cd_rank='TR' THEN 'GN'
    WHEN cd_rank='SFAM' THEN 'GN'
    WHEN cd_rank='FAM' THEN 'GN'
    WHEN cd_rank='SOR' THEN 'FAM'
    WHEN cd_rank='OR' THEN 'FAM'
    WHEN cd_rank='CL' THEN 'OR'
    WHEN cd_rank='PHY' THEN 'CL'
    WHEN cd_rank='KG' THEN 'PHY'
    ELSE 'ERROR_RANK'
  END pseudo_rank
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE /*rank_level>10 AND */table_orig='hormigas_registros'
  AND (identification_qualifier IS NOT NULL)
)
SELECT 'horm',cd_tax,name_morfo, scientific_name||' sp'||SPLIT_PART(name_morfo,' ',2) AS verbatim_taxon, pseudo_rank
FROM a
WHERE name_morfo IS NOT NULL
GROUP BY cd_tax,cd_rank,scientific_name, pseudo_rank, name_morfo
ORDER BY cd_tax, name_morfo
RETURNING main.morfo_taxo.cd_morfo, verbatim_taxon
```

``` sql
UPDATE raw_dwc.taxonomy_total AS tt
SET cd_morfo=m.cd_morfo
FROM main.morfo_taxo m
WHERE m.cd_gp_biol='horm' AND tt.table_orig='hormigas_registros' 
  AND tt.cd_tax=m.cd_tax
  AND (
   CASE 
      WHEN identification_remarks ~ '^Morfotipo [0-9]{1,2} *$' THEN REGEXP_REPLACE(identification_remarks, '^(Morfotipo [0-9]{1,2}) *$', '\1')
      ELSE NULL
    END = m.name_morfo)
RETURNING tt."row.names", tt.cd_morfo
```

## 6.15 Cameras trampa

**No detecto ningun caso de morfoespecie**

``` sql
SELECT cd_tax,scientific_name,
  identification_qualifier, identification_remarks
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE /*rank_level>10 AND */table_orig='cameras_trampa_registros'
  AND (identification_qualifier IS NOT NULL OR identification_remarks IS NOT NULL)
```

<div class="knitsql-table">

|                                                                        |
|:----------------------------------------------------------------------:|
| cd_tax scientific_name identification_qualifier identification_remarks |

------------------------------------------------------------------------

: 0 records

</div>

``` sql
SELECT cd_tax,scientific_name,
  identification_qualifier, identification_remarks
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE rank_level>10 AND table_orig='cameras_trampa_registros'
```

<div class="knitsql-table">

| cd_tax | scientific_name | identification_qualifier | identification_remarks |
|-------:|:----------------|:-------------------------|:-----------------------|
|   1139 | Megascops       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1213 | Ortalis         | NA                       | NA                     |
|   1213 | Ortalis         | NA                       | NA                     |
|   1213 | Ortalis         | NA                       | NA                     |
|   1213 | Ortalis         | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|    884 | Catharus        | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1138 | Megarynchus     | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1138 | Megarynchus     | NA                       | NA                     |
|   1106 | Leptotila       | NA                       | NA                     |
|   1138 | Megarynchus     | NA                       | NA                     |

Displaying records 1 - 100

</div>

``` sql
SELECT cd_rank,count(*)
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE table_orig='cameras_trampa_registros'
GROUP BY cd_rank,rank_level
ORDER BY rank_level DESC
```

<div class="knitsql-table">

| cd_rank | count |
|:--------|------:|
| GN      |  1912 |
| SP      | 65644 |

2 records

</div>

## 6.16 Herpetos (reptiles)

``` sql
SELECT cd_tax,scientific_name,
  identification_qualifier,
  CASE 
    WHEN scientific_name IN ('Atractus','Lepidoblepharis','Mabuya') THEN scientific_name||' sp.'
    ELSE NULL
  END name_morfo,
  cd_rank,
  CASE
    WHEN identification_qualifier='Gen. nov. et sp. nov.' THEN 'SP'
    WHEN cd_rank='GN' THEN 'SP'
    WHEN cd_rank='TR' THEN 'GN'
    WHEN cd_rank='SFAM' THEN 'GN'
    WHEN cd_rank='FAM' THEN 'GN'
    WHEN cd_rank='SOR' THEN 'FAM'
    WHEN cd_rank='OR' THEN 'FAM'
    WHEN cd_rank='CL' THEN 'OR'
    WHEN cd_rank='PHY' THEN 'CL'
    WHEN cd_rank='KG' THEN 'PHY'
    ELSE 'ERROR_RANK'
  END pseudo_rank,
  identification_remarks,
count(*)
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE /*rank_level>10 AND */table_orig='reptiles_registros'
  AND (identification_qualifier IS NOT NULL OR identification_remarks IS NOT NULL OR (scientific_name IN ('Atractus','Lepidoblepharis','Mabuya'))) 
GROUP BY cd_tax,cd_rank,scientific_name,identification_qualifier,identification_remarks
ORDER BY cd_tax,identification_qualifier
```

<div class="knitsql-table">

| cd_tax | scientific_name | identification_qualifier | name_morfo          | cd_rank | pseudo_rank | identification_remarks | count |
|-------:|:----------------|:-------------------------|:--------------------|:--------|:------------|:-----------------------|------:|
|    833 | Atractus        | NA                       | Atractus sp.        | GN      | SP          | NA                     |     1 |
|   1098 | Lepidoblepharis | NA                       | Lepidoblepharis sp. | GN      | SP          | NA                     |     1 |
|   1118 | Mabuya          | NA                       | Mabuya sp.          | GN      | SP          | NA                     |    18 |

3 records

</div>

``` sql
INSERT INTO main.morfo_taxo (cd_gp_biol,cd_tax,name_morfo,verbatim_taxon,pseudo_rank)
WITH a AS (
SELECT cd_tax,scientific_name,
  identification_qualifier,
  CASE 
    WHEN scientific_name IN ('Atractus','Lepidoblepharis','Mabuya') THEN 'sp.'
    ELSE NULL
  END name_morfo,
  cd_rank,
  CASE
    WHEN identification_qualifier='Gen. nov. et sp. nov.' THEN 'SP'
    WHEN cd_rank='GN' THEN 'SP'
    WHEN cd_rank='TR' THEN 'GN'
    WHEN cd_rank='SFAM' THEN 'GN'
    WHEN cd_rank='FAM' THEN 'GN'
    WHEN cd_rank='SOR' THEN 'FAM'
    WHEN cd_rank='OR' THEN 'FAM'
    WHEN cd_rank='CL' THEN 'OR'
    WHEN cd_rank='PHY' THEN 'CL'
    WHEN cd_rank='KG' THEN 'PHY'
    ELSE 'ERROR_RANK'
  END pseudo_rank,
  identification_remarks,
count(*)
FROM raw_dwc.taxonomy_total
LEFT JOIN main.taxo USING (cd_tax)
LEFT JOIN main.def_tax_rank USING (cd_rank)
WHERE /*rank_level>10 AND */table_orig='reptiles_registros'
  AND (identification_qualifier IS NOT NULL OR identification_remarks IS NOT NULL OR (scientific_name IN ('Atractus','Lepidoblepharis','Mabuya'))) 
GROUP BY cd_tax,cd_rank,scientific_name,identification_qualifier,identification_remarks
ORDER BY cd_tax,identification_qualifier
)
SELECT 'herp',cd_tax, name_morfo, scientific_name||' '||name_morfo,pseudo_rank
FROM a
RETURNING cd_morfo,name_morfo,verbatim_taxon,pseudo_rank
```

``` sql
UPDATE raw_dwc.taxonomy_total AS tt
SET cd_morfo=m.cd_morfo
FROM main.morfo_taxo m
WHERE m.cd_gp_biol='herp' AND tt.table_orig='reptiles_registros' 
  AND tt.cd_tax=m.cd_tax
  AND (
   CASE 
      WHEN scientific_name IN ('Atractus','Lepidoblepharis','Mabuya') THEN 'sp.'
      ELSE NULL
    END = m.name_morfo)
RETURNING tt."row.names", tt.cd_morfo
```

# 7 CREATING sql taxonomic function

Para poder aprovechar todas las posibilidades de las tablas taxonomicas
y sus INDEX, es importante crear las funciones que permiten buscar las
relaciones entre taxones

``` sql
CREATE OR REPLACE FUNCTION find_higher(id1 int,lev character varying(6), OUT idfin int, OUT type_res character varying(10))
IMMUTABLE
AS $$
DECLARE
    finallev int;
    starthigher boolean;
    currentid int;
    currentlev smallint;
BEGIN
currentid := id1;
-- define final level
SELECT rank_level INTO finallev FROM main.def_tax_rank WHERE cd_rank=lev;
-- define current level
SELECT r.rank_level INTO currentlev FROM main.taxo n JOIN main.def_tax_rank r ON n.cd_rank=r.cd_rank WHERE cd_tax=currentid;

-- starting level is higher than final level
starthigher := (currentlev>finallev);
IF starthigher THEN
    idfin := NULL;
    type_res := 'start_higher';
END IF;

-- loop to browse the parent levels
WHILE currentlev<finallev LOOP
    SELECT cd_parent INTO currentid FROM main.taxo WHERE main.taxo.cd_tax=currentid;
    SELECT r.rank_level INTO currentlev FROM main.taxo n JOIN main.def_tax_rank r ON n.cd_rank=r.cd_rank WHERE cd_tax=currentid;
    -- RAISE NOTICE 'current level is (%) \n', currentlev;
    -- RAISE NOTICE 'current id is (%) \n', currentid;
END LOOP;

-- missing rank
IF (currentlev>finallev AND NOT starthigher) THEN
    idfin := NULL;
    type_res := 'absent_rank';
END IF;

-- We are good!
IF (currentlev=finallev) THEN
    idfin := currentid;
    type_res := 'ok';
END IF;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION find_higher_id(id1 int,lev character varying(4), OUT idfin int)
IMMUTABLE
AS $$
DECLARE
    finallev int;
    starthigher boolean;
    currentid int;
    currentlev smallint;
BEGIN
currentid := id1;
SELECT rank_level INTO finallev FROM main.def_tax_rank WHERE cd_rank=lev;
SELECT r.rank_level INTO currentlev FROM main.taxo n JOIN main.def_tax_rank r ON n.cd_rank=r.cd_rank WHERE cd_tax=currentid;
starthigher := (currentlev>finallev);
IF starthigher THEN
    idfin := NULL;
END IF;

WHILE currentlev IS NOT NULL AND currentlev<finallev LOOP
    SELECT cd_parent INTO currentid FROM main.taxo WHERE main.taxo.cd_tax=currentid;
    SELECT r.rank_level INTO currentlev FROM main.taxo n JOIN main.def_tax_rank r ON n.cd_rank=r.cd_rank WHERE cd_tax=currentid;
    --RAISE NOTICE 'current level is (%) \n', currentlev;
    --RAISE NOTICE 'current id is (%) \n', currentid;   
END LOOP;

IF (currentlev>finallev AND NOT starthigher) THEN
    idfin := NULL;
END IF;

IF (currentlev=finallev) THEN
    idfin := currentid;
END IF;

END;
$$ LANGUAGE plpgsql;

SELECT true;
```

## 7.1 Ejemplos de utilización

``` sql
WITH a AS(
SELECT t.cd_tax,find_higher_id(t.cd_tax,'FAM') cd_family
FROM main.taxo t
ORDER BY random()
LIMIT 10
)
SELECT a.cd_tax,t.name_tax, a.cd_family, t2.name_tax
FROM a
LEFT JOIN main.taxo t ON a.cd_tax=t.cd_tax
LEFT JOIN main.taxo t2 ON cd_family=t2.cd_tax
```

<div class="knitsql-table">

| cd_tax | name_tax               | cd_family | name_tax       |
|-------:|:-----------------------|----------:|:---------------|
|    274 | Chironomidae           |       274 | Chironomidae   |
|    279 | Crambidae              |       279 | Crambidae      |
|   1089 | Laccophilus            |       286 | Dytiscidae     |
|   2803 | Helicostylis tomentosa |       315 | Moraceae       |
|   1657 | Desmodus               |       323 | Phyllostomidae |
|   1414 | Wyeomyia               |       459 | Culicidae      |
|   2038 | Pseudolycaena          |       559 | Lycaenidae     |
|   2948 | Ludwigia latifolia     |       613 | Onagraceae     |
|   3271 | Polytmus guainumbi     |       737 | Trochilidae    |
|    115 | Artiodactyla           |        NA | NA             |

10 records

</div>

Numero de taxa en cada clase, por tabla de origen

``` sql
WITH a AS(
SELECT DISTINCT table_orig,"row.names",cd_tax
FROM raw_dwc.taxonomy_total
), b AS(
SELECT a.*,find_higher_id(a.cd_tax,'CL') cd_cl
FROM a
)
SELECT table_orig, t.name_tax as class, count(*)
FROM raw_dwc.taxonomy_total tt
JOIN b USING (table_orig,"row.names")
JOIN main.taxo t ON b.cd_cl=t.cd_tax
GROUP BY table_orig, t.name_tax
ORDER BY table_orig, count(*)
```

<div class="knitsql-table">

| table_orig                                  | class               | count |
|:--------------------------------------------|:--------------------|------:|
| anfibios_registros                          | Amphibia            |  2211 |
| atropellamientos_registros                  | Aves                |    16 |
| atropellamientos_registros                  | Amphibia            |    17 |
| atropellamientos_registros                  | Mammalia            |    38 |
| atropellamientos_registros                  | Reptilia            |    38 |
| aves_registros                              | Aves                | 10249 |
| botanica_registros_arborea                  | Pinopsida           |     2 |
| botanica_registros_arborea                  | Liliopsida          |    61 |
| botanica_registros_arborea                  | Magnoliopsida       |  4111 |
| botanica_registros_col                      | Pinopsida           |     1 |
| botanica_registros_col                      | Liliopsida          |    11 |
| botanica_registros_col                      | Magnoliopsida       |   118 |
| botanica_registros_epi_novas                | Agaricomycetes      |     2 |
| botanica_registros_epi_novas                | Bryopsida           |    52 |
| botanica_registros_epi_novas                | Dothideomycetes     |    61 |
| botanica_registros_epi_novas                | Eurotiomycetes      |    83 |
| botanica_registros_epi_novas                | Jungermanniopsida   |   293 |
| botanica_registros_epi_novas                | Arthoniomycetes     |   550 |
| botanica_registros_epi_novas                | Lecanoromycetes     |  1530 |
| botanica_registros_epi_vas                  | Liliopsida          |    27 |
| cameras_trampa_registros                    | Reptilia            |  1299 |
| cameras_trampa_registros                    | Aves                | 25170 |
| cameras_trampa_registros                    | Mammalia            | 41087 |
| collembolos_registros                       | Entognatha          |  5948 |
| escarabajos_registros                       | Insecta             |  3908 |
| hidrobiologico_registros_fitoplancton       | Chrysophyceae       |     1 |
| hidrobiologico_registros_fitoplancton       | Ulvophyceae         |     4 |
| hidrobiologico_registros_fitoplancton       | Xanthophyceae       |     4 |
| hidrobiologico_registros_fitoplancton       | Florideophyceae     |     4 |
| hidrobiologico_registros_fitoplancton       | Eustigmatophyceae   |    19 |
| hidrobiologico_registros_fitoplancton       | Synurophyceae       |    20 |
| hidrobiologico_registros_fitoplancton       | Dinophyceae         |    24 |
| hidrobiologico_registros_fitoplancton       | Cryptophyceae       |    32 |
| hidrobiologico_registros_fitoplancton       | Coscinodiscophyceae |    35 |
| hidrobiologico_registros_fitoplancton       | Trebouxiophyceae    |    50 |
| hidrobiologico_registros_fitoplancton       | Cyanophyceae        |   223 |
| hidrobiologico_registros_fitoplancton       | Chlorophyceae       |   290 |
| hidrobiologico_registros_fitoplancton       | Euglenophyceae      |   354 |
| hidrobiologico_registros_fitoplancton       | Bacillariophyceae   |   624 |
| hidrobiologico_registros_fitoplancton       | Zygnematophyceae    |   699 |
| hidrobiologico_registros_macrofitas         | Bryopsida           |     1 |
| hidrobiologico_registros_macrofitas         | Jungermanniopsida   |     2 |
| hidrobiologico_registros_macrofitas         | Selaginellopsida    |    17 |
| hidrobiologico_registros_macrofitas         | Pteridopsida        |    25 |
| hidrobiologico_registros_macrofitas         | Polypodiopsida      |    52 |
| hidrobiologico_registros_macrofitas         | Magnoliopsida       |   117 |
| hidrobiologico_registros_macrofitas         | Liliopsida          |   319 |
| hidrobiologico_registros_macroinvertebrados | Trepaxonemata       |     4 |
| hidrobiologico_registros_macroinvertebrados | Entognatha          |     8 |
| hidrobiologico_registros_macroinvertebrados | Malacostraca        |    27 |
| hidrobiologico_registros_macroinvertebrados | Branchiopoda        |    74 |
| hidrobiologico_registros_macroinvertebrados | Bivalvia            |    89 |
| hidrobiologico_registros_macroinvertebrados | Clitellata          |   115 |
| hidrobiologico_registros_macroinvertebrados | Euchelicerata       |   129 |
| hidrobiologico_registros_macroinvertebrados | Gastropoda          |   181 |
| hidrobiologico_registros_macroinvertebrados | Insecta             |  3845 |
| hidrobiologico_registros_perifiton          | Synurophyceae       |     1 |
| hidrobiologico_registros_perifiton          | Dinophyceae         |     2 |
| hidrobiologico_registros_perifiton          | Xanthophyceae       |     3 |
| hidrobiologico_registros_perifiton          | Klebsormidiophyceae |     4 |
| hidrobiologico_registros_perifiton          | Cryptophyceae       |    18 |
| hidrobiologico_registros_perifiton          | Ulvophyceae         |    18 |
| hidrobiologico_registros_perifiton          | Trebouxiophyceae    |    21 |
| hidrobiologico_registros_perifiton          | Coscinodiscophyceae |    24 |
| hidrobiologico_registros_perifiton          | Florideophyceae     |    26 |
| hidrobiologico_registros_perifiton          | Euglenophyceae      |   108 |
| hidrobiologico_registros_perifiton          | Cyanophyceae        |   219 |
| hidrobiologico_registros_perifiton          | Chlorophyceae       |   260 |
| hidrobiologico_registros_perifiton          | Zygnematophyceae    |   593 |
| hidrobiologico_registros_perifiton          | Bacillariophyceae   |  2013 |
| hidrobiologico_registros_zooplancton        | Ostracoda           |    29 |
| hidrobiologico_registros_zooplancton        | Branchiopoda        |    72 |
| hidrobiologico_registros_zooplancton        | Lobosa              |   120 |
| hidrobiologico_registros_zooplancton        | Maxillopoda         |   205 |
| hidrobiologico_registros_zooplancton        | Monogonta           |   388 |
| hormigas_registros                          | Insecta             |  9245 |
| mamiferos_registros                         | Mammalia            |  3709 |
| mamiferos_us_registros                      | Insecta             |    59 |
| mamiferos_us_registros                      | Mammalia            |   910 |
| mariposas_registros                         | Insecta             |  3772 |
| peces_registros                             | Chondrichthyes      |     2 |
| peces_registros                             | Actinopterygii      |  1855 |
| reptiles_registros                          | Reptilia            |   914 |

83 records

</div>

## 7.2 INDEX

Los calculos para buscar elementos taxonomicos (en particular en
operaciones JOIN) pueden tomar mucho tiempo de calculo, los INDEX
siguientes permiten accelerar mucho el proceso!

``` sql
CREATE INDEX registros_genus_idx ON main.registros USING BTREE(find_higher_id(cd_tax,'GN'));
CREATE INDEX registros_family_idx ON main.registros USING BTREE(find_higher_id(cd_tax,'FAM'));
CREATE INDEX registros_order_idx ON main.registros USING BTREE(find_higher_id(cd_tax,'OR'));
CREATE INDEX registros_class_idx ON main.registros USING BTREE(find_higher_id(cd_tax,'CL'));
CREATE INDEX registros_phylum_idx ON main.registros USING BTREE(find_higher_id(cd_tax,'PHY'));
CREATE INDEX registros_kingdom_idx ON main.registros USING BTREE(find_higher_id(cd_tax,'KG'));
CREATE INDEX registros_subfamily_idx ON main.registros USING BTREE(find_higher_id(cd_tax,'SFAM'));
SELECT True ;
```

En casos particulares, y eso solo hasta que la base de datos esté
consolidada para todos los grupos, puede ser util tambien implementar
los INDEX sobre la tabla taxonomy_total tambien:

``` sql
CREATE INDEX taxonomy_genus_idx ON raw_dwc.taxonomy_total USING BTREE(find_higher_id(cd_tax,'GN'));
CREATE INDEX taxonomy_family_idx ON raw_dwc.taxonomy_total USING BTREE(find_higher_id(cd_tax,'FAM'));
CREATE INDEX taxonomy_order_idx ON raw_dwc.taxonomy_total USING BTREE(find_higher_id(cd_tax,'OR'));
CREATE INDEX taxonomy_class_idx ON raw_dwc.taxonomy_total USING BTREE(find_higher_id(cd_tax,'CL'));
CREATE INDEX taxonomy_phylum_idx ON raw_dwc.taxonomy_total USING BTREE(find_higher_id(cd_tax,'PHY'));
CREATE INDEX taxonomy_kingdom_idx ON raw_dwc.taxonomy_total USING BTREE(find_higher_id(cd_tax,'KG'));
CREATE INDEX taxonomy_subfamily_idx ON raw_dwc.taxonomy_total USING BTREE(find_higher_id(cd_tax,'SFAM'));
SELECT True ;
```

``` r
dbDisconnect(fracking_db)
```

    ## [1] TRUE
