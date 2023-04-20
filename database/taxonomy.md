Estructura y manejo de la taxonomía en la base de datos
================
Marius Bottin
2023-04-19

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

<table>
<caption>

Displaying records 1 - 100

</caption>
<thead>
<tr>
<th style="text-align:left;">

taxon_rank

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Orden

</td>
</tr>
<tr>
<td style="text-align:left;">

Especie

</td>
</tr>
<tr>
<td style="text-align:left;">

Especie

</td>
</tr>
<tr>
<td style="text-align:left;">

Especie

</td>
</tr>
<tr>
<td style="text-align:left;">

Especie

</td>
</tr>
<tr>
<td style="text-align:left;">

Especie

</td>
</tr>
<tr>
<td style="text-align:left;">

Especie

</td>
</tr>
<tr>
<td style="text-align:left;">

Especie

</td>
</tr>
<tr>
<td style="text-align:left;">

Especie

</td>
</tr>
<tr>
<td style="text-align:left;">

Especie

</td>
</tr>
<tr>
<td style="text-align:left;">

Especie

</td>
</tr>
<tr>
<td style="text-align:left;">

Especie

</td>
</tr>
<tr>
<td style="text-align:left;">

Especie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
<tr>
<td style="text-align:left;">

Subespecie

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

0 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

table_orig

</th>
<th style="text-align:left;">

row.names

</th>
<th style="text-align:left;">

kingdom

</th>
<th style="text-align:left;">

phylum

</th>
<th style="text-align:left;">

class

</th>
<th style="text-align:left;">

order

</th>
<th style="text-align:left;">

family

</th>
<th style="text-align:left;">

subfamily

</th>
<th style="text-align:left;">

genus

</th>
<th style="text-align:left;">

specific_epithet

</th>
<th style="text-align:left;">

infraspecific_epithet

</th>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

scientific_name_authorship

</th>
<th style="text-align:left;">

taxon_rank

</th>
<th style="text-align:left;">

vernacular_name

</th>
<th style="text-align:left;">

identification_qualifier

</th>
<th style="text-align:left;">

identification_remarks

</th>
</tr>
</thead>
<tbody>
<tr>
</tr>
</tbody>
</table>

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

<table>
<caption>

4 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

table_orig

</th>
<th style="text-align:left;">

row.names

</th>
<th style="text-align:left;">

genus

</th>
<th style="text-align:left;">

specific_epithet

</th>
<th style="text-align:left;">

infraspecific_epithet

</th>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

taxon_rank

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

aves_registros

</td>
<td style="text-align:left;">

10223

</td>
<td style="text-align:left;">

Empidonax

</td>
<td style="text-align:left;">

traillii 

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

Empidonax traillii

</td>
<td style="text-align:left;">

Especie

</td>
</tr>
<tr>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1586

</td>
<td style="text-align:left;">

Lophostoma

</td>
<td style="text-align:left;">

silvicolum

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

Lophostoma silvicola

</td>
<td style="text-align:left;">

Especie

</td>
</tr>
<tr>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

2061

</td>
<td style="text-align:left;">

Lophostoma

</td>
<td style="text-align:left;">

silvicolum

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

Lophostoma silvicola

</td>
<td style="text-align:left;">

Especie

</td>
</tr>
<tr>
<td style="text-align:left;">

mariposas_registros

</td>
<td style="text-align:left;">

284

</td>
<td style="text-align:left;">

Phoebis

</td>
<td style="text-align:left;">

trite

</td>
<td style="text-align:left;">

trite

</td>
<td style="text-align:left;">

Phoebis trite trite

</td>
<td style="text-align:left;">

Especie

</td>
</tr>
</tbody>
</table>

</div>

``` sql
SELECT table_orig, "row.names", genus, specific_epithet, infraspecific_epithet, scientific_name, taxon_rank 
FROM raw_dwc.taxonomy_total
WHERE taxon_rank ~ '^[Ee]specie' AND scientific_name !~ '^[A-Z][a-z]+ [a-z-]+$'
```

<div class="knitsql-table">

<table>
<caption>

1 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

table_orig

</th>
<th style="text-align:left;">

row.names

</th>
<th style="text-align:left;">

genus

</th>
<th style="text-align:left;">

specific_epithet

</th>
<th style="text-align:left;">

infraspecific_epithet

</th>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

taxon_rank

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

mariposas_registros

</td>
<td style="text-align:left;">

284

</td>
<td style="text-align:left;">

Phoebis

</td>
<td style="text-align:left;">

trite

</td>
<td style="text-align:left;">

trite

</td>
<td style="text-align:left;">

Phoebis trite trite

</td>
<td style="text-align:left;">

Especie

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

79 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

genus

</th>
<th style="text-align:left;">

specific_epithet

</th>
<th style="text-align:left;">

infraspecific_epithet

</th>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

taxon_rank

</th>
<th style="text-align:left;">

array_agg

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Abarema

</td>
<td style="text-align:left;">

jupunba

</td>
<td style="text-align:left;">

trapezifolia

</td>
<td style="text-align:left;">

Abarema jupunba trapezifolia

</td>
<td style="text-align:left;">

Variedad

</td>
<td style="text-align:left;">

{botanica_registros_arborea}

</td>
</tr>
<tr>
<td style="text-align:left;">

Bactris

</td>
<td style="text-align:left;">

gasipaes

</td>
<td style="text-align:left;">

chichagui

</td>
<td style="text-align:left;">

Bactris gasipaes chichagui

</td>
<td style="text-align:left;">

Variedad

</td>
<td style="text-align:left;">

{botanica_registros_arborea}

</td>
</tr>
<tr>
<td style="text-align:left;">

Adelpha

</td>
<td style="text-align:left;">

barnesia

</td>
<td style="text-align:left;">

leucas

</td>
<td style="text-align:left;">

Adelpha barnesia leucas

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Adelpha

</td>
<td style="text-align:left;">

cytherea

</td>
<td style="text-align:left;">

daguana

</td>
<td style="text-align:left;">

Adelpha cytherea daguana

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Adelpha

</td>
<td style="text-align:left;">

iphiclus

</td>
<td style="text-align:left;">

iphiclus

</td>
<td style="text-align:left;">

Adelpha iphiclus iphiclus

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Adelpha

</td>
<td style="text-align:left;">

melona

</td>
<td style="text-align:left;">

deborah

</td>
<td style="text-align:left;">

Adelpha melona deborah

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Adelpha

</td>
<td style="text-align:left;">

phylaca

</td>
<td style="text-align:left;">

pseudaethalia

</td>
<td style="text-align:left;">

Adelpha phylaca pseudaethalia

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Adelpha

</td>
<td style="text-align:left;">

salmoneus

</td>
<td style="text-align:left;">

emilia

</td>
<td style="text-align:left;">

Adelpha salmoneus emilia

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Ancyluris

</td>
<td style="text-align:left;">

jurgensenii

</td>
<td style="text-align:left;">

atahualpa

</td>
<td style="text-align:left;">

Ancyluris jurgensenii atahualpa

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Archaeoprepona

</td>
<td style="text-align:left;">

demophon

</td>
<td style="text-align:left;">

muson

</td>
<td style="text-align:left;">

Archaeoprepona demophon muson

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Archaeoprepona

</td>
<td style="text-align:left;">

demophoon

</td>
<td style="text-align:left;">

gulina

</td>
<td style="text-align:left;">

Archaeoprepona demophoon gulina

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Baeotis

</td>
<td style="text-align:left;">

zonata

</td>
<td style="text-align:left;">

zonata

</td>
<td style="text-align:left;">

Baeotis zonata zonata

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Caligo

</td>
<td style="text-align:left;">

idomeneus

</td>
<td style="text-align:left;">

idomenides

</td>
<td style="text-align:left;">

Caligo idomeneus idomenides

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Caligo

</td>
<td style="text-align:left;">

illioneus

</td>
<td style="text-align:left;">

oberon

</td>
<td style="text-align:left;">

Caligo illioneus oberon

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Caligo

</td>
<td style="text-align:left;">

oedipus

</td>
<td style="text-align:left;">

oedipus

</td>
<td style="text-align:left;">

Caligo oedipus oedipus

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Caligo

</td>
<td style="text-align:left;">

telamonius

</td>
<td style="text-align:left;">

menus

</td>
<td style="text-align:left;">

Caligo telamonius menus

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Catoblepia

</td>
<td style="text-align:left;">

berecynthia

</td>
<td style="text-align:left;">

luxuriosus

</td>
<td style="text-align:left;">

Catoblepia berecynthia luxuriosus

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Catonephele

</td>
<td style="text-align:left;">

numilia

</td>
<td style="text-align:left;">

esite

</td>
<td style="text-align:left;">

Catonephele numilia esite

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Chiothion

</td>
<td style="text-align:left;">

asychis

</td>
<td style="text-align:left;">

simon

</td>
<td style="text-align:left;">

Chiothion asychis simon

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Consul

</td>
<td style="text-align:left;">

fabius

</td>
<td style="text-align:left;">

bogotanus

</td>
<td style="text-align:left;">

Consul fabius bogotanus

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Dryas

</td>
<td style="text-align:left;">

iulia

</td>
<td style="text-align:left;">

iulia

</td>
<td style="text-align:left;">

Dryas iulia iulia

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Emesis

</td>
<td style="text-align:left;">

fatimella

</td>
<td style="text-align:left;">

nobilata

</td>
<td style="text-align:left;">

Emesis fatimella nobilata

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Eresia

</td>
<td style="text-align:left;">

eunice

</td>
<td style="text-align:left;">

mechanitis

</td>
<td style="text-align:left;">

Eresia eunice mechanitis

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Eueides

</td>
<td style="text-align:left;">

isabella

</td>
<td style="text-align:left;">

arquata

</td>
<td style="text-align:left;">

Eueides isabella arquata

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Eueides

</td>
<td style="text-align:left;">

lybia

</td>
<td style="text-align:left;">

olympia

</td>
<td style="text-align:left;">

Eueides lybia olympia

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Eunica

</td>
<td style="text-align:left;">

mygdonia

</td>
<td style="text-align:left;">

mygdonia

</td>
<td style="text-align:left;">

Eunica mygdonia mygdonia

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Euptychia

</td>
<td style="text-align:left;">

westwoodi

</td>
<td style="text-align:left;">

westwoodi

</td>
<td style="text-align:left;">

Euptychia westwoodi westwoodi

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Eurema

</td>
<td style="text-align:left;">

agave

</td>
<td style="text-align:left;">

agave

</td>
<td style="text-align:left;">

Eurema agave agave

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Eurema

</td>
<td style="text-align:left;">

arbela

</td>
<td style="text-align:left;">

gratiosa

</td>
<td style="text-align:left;">

Eurema arbela gratiosa

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Eurema

</td>
<td style="text-align:left;">

daira

</td>
<td style="text-align:left;">

lydia

</td>
<td style="text-align:left;">

Eurema daira lydia

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Gallus

</td>
<td style="text-align:left;">

gallus

</td>
<td style="text-align:left;">

domesticus

</td>
<td style="text-align:left;">

Gallus gallus domesticus

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{atropellamientos_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Gorgythion

</td>
<td style="text-align:left;">

begga

</td>
<td style="text-align:left;">

pyralina

</td>
<td style="text-align:left;">

Gorgythion begga pyralina

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Hamadryas

</td>
<td style="text-align:left;">

amphinome

</td>
<td style="text-align:left;">

fumosa

</td>
<td style="text-align:left;">

Hamadryas amphinome fumosa

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Hamadryas

</td>
<td style="text-align:left;">

februa

</td>
<td style="text-align:left;">

ferentina

</td>
<td style="text-align:left;">

Hamadryas februa ferentina

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Hamadryas

</td>
<td style="text-align:left;">

feronia

</td>
<td style="text-align:left;">

farinulenta

</td>
<td style="text-align:left;">

Hamadryas feronia farinulenta

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Heliconius

</td>
<td style="text-align:left;">

charithonia

</td>
<td style="text-align:left;">

bassleri

</td>
<td style="text-align:left;">

Heliconius charithonia bassleri

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Heliconius

</td>
<td style="text-align:left;">

erato

</td>
<td style="text-align:left;">

hydara

</td>
<td style="text-align:left;">

Heliconius erato hydara

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Heliconius

</td>
<td style="text-align:left;">

hecale

</td>
<td style="text-align:left;">

melicerta

</td>
<td style="text-align:left;">

Heliconius hecale melicerta

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Heliconius

</td>
<td style="text-align:left;">

ismenius

</td>
<td style="text-align:left;">

boulleti

</td>
<td style="text-align:left;">

Heliconius ismenius boulleti

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Heliconius

</td>
<td style="text-align:left;">

ismenius

</td>
<td style="text-align:left;">

ismenius

</td>
<td style="text-align:left;">

Heliconius ismenius ismenius

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Heliconius

</td>
<td style="text-align:left;">

sapho

</td>
<td style="text-align:left;">

sapho

</td>
<td style="text-align:left;">

Heliconius sapho sapho

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Heliconius

</td>
<td style="text-align:left;">

sara

</td>
<td style="text-align:left;">

magdalena

</td>
<td style="text-align:left;">

Heliconius sara magdalena

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Hemiargus

</td>
<td style="text-align:left;">

hanno

</td>
<td style="text-align:left;">

bogotana

</td>
<td style="text-align:left;">

Hemiargus hanno bogotana

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Heraclides

</td>
<td style="text-align:left;">

anchisiades

</td>
<td style="text-align:left;">

idaeus

</td>
<td style="text-align:left;">

Heraclides anchisiades idaeus

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Heraclides

</td>
<td style="text-align:left;">

thoas

</td>
<td style="text-align:left;">

nealces

</td>
<td style="text-align:left;">

Heraclides thoas nealces

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Historis

</td>
<td style="text-align:left;">

odius

</td>
<td style="text-align:left;">

dious

</td>
<td style="text-align:left;">

Historis odius dious

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Itaballia

</td>
<td style="text-align:left;">

demophile

</td>
<td style="text-align:left;">

calydonia

</td>
<td style="text-align:left;">

Itaballia demophile calydonia

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Mechanitis

</td>
<td style="text-align:left;">

polymnia

</td>
<td style="text-align:left;">

veritabilis

</td>
<td style="text-align:left;">

Mechanitis polymnia veritabilis

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Memphis

</td>
<td style="text-align:left;">

acidalia

</td>
<td style="text-align:left;">

memphis

</td>
<td style="text-align:left;">

Memphis acidalia memphis

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Memphis

</td>
<td style="text-align:left;">

moruus

</td>
<td style="text-align:left;">

phila

</td>
<td style="text-align:left;">

Memphis moruus phila

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Morpho

</td>
<td style="text-align:left;">

helenor

</td>
<td style="text-align:left;">

peleides

</td>
<td style="text-align:left;">

Morpho helenor peleides

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Mysoria

</td>
<td style="text-align:left;">

barcastus

</td>
<td style="text-align:left;">

venezuelae

</td>
<td style="text-align:left;">

Mysoria barcastus venezuelae

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Notheme

</td>
<td style="text-align:left;">

erota

</td>
<td style="text-align:left;">

diadema

</td>
<td style="text-align:left;">

Notheme erota diadema

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Nyctelius

</td>
<td style="text-align:left;">

nyctelius

</td>
<td style="text-align:left;">

nyctelius

</td>
<td style="text-align:left;">

Nyctelius nyctelius nyctelius

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Nymphidium

</td>
<td style="text-align:left;">

caricae

</td>
<td style="text-align:left;">

trinidadi

</td>
<td style="text-align:left;">

Nymphidium caricae trinidadi

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Opsiphanes

</td>
<td style="text-align:left;">

cassina

</td>
<td style="text-align:left;">

periphetes

</td>
<td style="text-align:left;">

Opsiphanes cassina periphetes

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Opsiphanes

</td>
<td style="text-align:left;">

quiteria

</td>
<td style="text-align:left;">

badius

</td>
<td style="text-align:left;">

Opsiphanes quiteria badius

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Ouleus

</td>
<td style="text-align:left;">

fridericus

</td>
<td style="text-align:left;">

fridericus

</td>
<td style="text-align:left;">

Ouleus fridericus fridericus

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Panoquina

</td>
<td style="text-align:left;">

ocola

</td>
<td style="text-align:left;">

ocola

</td>
<td style="text-align:left;">

Panoquina ocola ocola

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Parides

</td>
<td style="text-align:left;">

erithalion

</td>
<td style="text-align:left;">

erithalion

</td>
<td style="text-align:left;">

Parides erithalion erithalion

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Parides

</td>
<td style="text-align:left;">

sesostris

</td>
<td style="text-align:left;">

tarquinius

</td>
<td style="text-align:left;">

Parides sesostris tarquinius

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Paryphthimoides

</td>
<td style="text-align:left;">

poltys

</td>
<td style="text-align:left;">

numilia

</td>
<td style="text-align:left;">

Paryphthimoides poltys numilia

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Perrhybris

</td>
<td style="text-align:left;">

pamela

</td>
<td style="text-align:left;">

bogotana

</td>
<td style="text-align:left;">

Perrhybris pamela bogotana

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Pierella

</td>
<td style="text-align:left;">

luna

</td>
<td style="text-align:left;">

luna

</td>
<td style="text-align:left;">

Pierella luna luna

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Porphyrogenes

</td>
<td style="text-align:left;">

calathana

</td>
<td style="text-align:left;">

calathana

</td>
<td style="text-align:left;">

Porphyrogenes calathana calathana

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Prepona

</td>
<td style="text-align:left;">

laertes

</td>
<td style="text-align:left;">

amesia

</td>
<td style="text-align:left;">

Prepona laertes amesia

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Prepona

</td>
<td style="text-align:left;">

laertes

</td>
<td style="text-align:left;">

louisa

</td>
<td style="text-align:left;">

Prepona laertes louisa

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Pyrrhogyra

</td>
<td style="text-align:left;">

crameri

</td>
<td style="text-align:left;">

undine

</td>
<td style="text-align:left;">

Pyrrhogyra crameri undine

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Pyrrhogyra

</td>
<td style="text-align:left;">

neaerea

</td>
<td style="text-align:left;">

kheili

</td>
<td style="text-align:left;">

Pyrrhogyra neaerea kheili

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Pyrrhopyge

</td>
<td style="text-align:left;">

phidias

</td>
<td style="text-align:left;">

latifasciata

</td>
<td style="text-align:left;">

Pyrrhopyge phidias latifasciata

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Pyrrhopyge

</td>
<td style="text-align:left;">

thericles

</td>
<td style="text-align:left;">

pseudophidias

</td>
<td style="text-align:left;">

Pyrrhopyge thericles pseudophidias

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Quadrus

</td>
<td style="text-align:left;">

contubernalis

</td>
<td style="text-align:left;">

contubernalis

</td>
<td style="text-align:left;">

Quadrus contubernalis contubernalis

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Selenophanes

</td>
<td style="text-align:left;">

josephus

</td>
<td style="text-align:left;">

excultus

</td>
<td style="text-align:left;">

Selenophanes josephus excultus

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Siproeta

</td>
<td style="text-align:left;">

stelenes

</td>
<td style="text-align:left;">

biplagiata

</td>
<td style="text-align:left;">

Siproeta stelenes biplagiata

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Stalachtis

</td>
<td style="text-align:left;">

magdalena

</td>
<td style="text-align:left;">

magdalena

</td>
<td style="text-align:left;">

Stalachtis magdalena magdalena

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Symmachia

</td>
<td style="text-align:left;">

leena

</td>
<td style="text-align:left;">

leena

</td>
<td style="text-align:left;">

Symmachia leena leena

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Telegonus

</td>
<td style="text-align:left;">

anaphus

</td>
<td style="text-align:left;">

annetta

</td>
<td style="text-align:left;">

Telegonus anaphus annetta

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Telemiades

</td>
<td style="text-align:left;">

antiope

</td>
<td style="text-align:left;">

antiope

</td>
<td style="text-align:left;">

Telemiades antiope antiope

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Thracides

</td>
<td style="text-align:left;">

cleanthes

</td>
<td style="text-align:left;">

telmela

</td>
<td style="text-align:left;">

Thracides cleanthes telmela

</td>
<td style="text-align:left;">

Subespecie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

0 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

genus

</th>
<th style="text-align:left;">

specific_epithet

</th>
<th style="text-align:left;">

infraspecific_epithet

</th>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

taxon_rank

</th>
<th style="text-align:left;">

array_agg

</th>
</tr>
</thead>
<tbody>
<tr>
</tr>
</tbody>
</table>

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

<table>
<caption>

3 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

genus

</th>
<th style="text-align:left;">

specific_epithet

</th>
<th style="text-align:left;">

infraspecific_epithet

</th>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

taxon_rank

</th>
<th style="text-align:left;">

array_agg

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Phoebis

</td>
<td style="text-align:left;">

trite

</td>
<td style="text-align:left;">

trite

</td>
<td style="text-align:left;">

Phoebis trite trite

</td>
<td style="text-align:left;">

Especie

</td>
<td style="text-align:left;">

{mariposas_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Carollia

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

Carollia perspicillata

</td>
<td style="text-align:left;">

Género

</td>
<td style="text-align:left;">

{mamiferos_registros}

</td>
</tr>
<tr>
<td style="text-align:left;">

Pseudomyrmex

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

pseudomyrmex

</td>
<td style="text-align:left;">

Género

</td>
<td style="text-align:left;">

{hormigas_registros}

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

12 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

VAR

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

1366

</td>
</tr>
<tr>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

104660

</td>
</tr>
<tr>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

19636

</td>
</tr>
<tr>
<td style="text-align:left;">

TR

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

590

</td>
</tr>
<tr>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1337

</td>
</tr>
<tr>
<td style="text-align:left;">

SOR

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

895

</td>
</tr>
<tr>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

367

</td>
</tr>
<tr>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:right;">

535

</td>
</tr>
<tr>
<td style="text-align:left;">

KG

</td>
<td style="text-align:right;">

258

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

1 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

name

</th>
<th style="text-align:left;">

ranks

</th>
<th style="text-align:left;">

array_agg

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Trebouxiophyceae

</td>
<td style="text-align:left;">

{class,family,order}

</td>
<td style="text-align:left;">

{hidrobiologico_registros_fitoplancton,hidrobiologico_registros_perifiton}

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

1 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

scientific_name_authorship

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Plantae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

KG

</td>
<td style="text-align:right;">

258

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

6 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

kingdom

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Animalia

</td>
<td style="text-align:left;">

KG

</td>
<td style="text-align:right;">

115643

</td>
</tr>
<tr>
<td style="text-align:left;">

Chromista

</td>
<td style="text-align:left;">

KG

</td>
<td style="text-align:right;">

2820

</td>
</tr>
<tr>
<td style="text-align:left;">

Eubacteria

</td>
<td style="text-align:left;">

KG

</td>
<td style="text-align:right;">

442

</td>
</tr>
<tr>
<td style="text-align:left;">

Fungi

</td>
<td style="text-align:left;">

KG

</td>
<td style="text-align:right;">

2721

</td>
</tr>
<tr>
<td style="text-align:left;">

Plantae

</td>
<td style="text-align:left;">

KG

</td>
<td style="text-align:right;">

7446

</td>
</tr>
<tr>
<td style="text-align:left;">

Protozoa

</td>
<td style="text-align:left;">

KG

</td>
<td style="text-align:right;">

582

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

3 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

scientific_name_authorship

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Ascomycota

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

6

</td>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:right;">

495

</td>
</tr>
<tr>
<td style="text-align:left;">

Bryophyta

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:right;">

10

</td>
</tr>
<tr>
<td style="text-align:left;">

Nematoda

</td>
<td style="text-align:left;">

Rudolphi, 1808

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:right;">

30

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

24 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

kingdom

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

phylum

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Protozoa

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:left;">

Amoebozoa

</td>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:right;">

120

</td>
</tr>
<tr>
<td style="text-align:left;">

Animalia

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:left;">

Annelida

</td>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:right;">

115

</td>
</tr>
<tr>
<td style="text-align:left;">

Animalia

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:left;">

Arthropoda

</td>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:right;">

27321

</td>
</tr>
<tr>
<td style="text-align:left;">

Fungi

</td>
<td style="text-align:right;">

6

</td>
<td style="text-align:left;">

Ascomycota

</td>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:right;">

2719

</td>
</tr>
<tr>
<td style="text-align:left;">

Chromista

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:left;">

Bacillariophyta

</td>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:right;">

2696

</td>
</tr>
<tr>
<td style="text-align:left;">

Fungi

</td>
<td style="text-align:right;">

6

</td>
<td style="text-align:left;">

Basidiomycota

</td>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Plantae

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:left;">

Bryophyta

</td>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:right;">

63

</td>
</tr>
<tr>
<td style="text-align:left;">

Plantae

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:left;">

Charophyta

</td>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:right;">

1296

</td>
</tr>
<tr>
<td style="text-align:left;">

Plantae

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:left;">

Chlorophyta

</td>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:right;">

643

</td>
</tr>
<tr>
<td style="text-align:left;">

Animalia

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:left;">

Chordata

</td>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:right;">

87515

</td>
</tr>
<tr>
<td style="text-align:left;">

Chromista

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:left;">

Cryptophyta

</td>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:right;">

50

</td>
</tr>
<tr>
<td style="text-align:left;">

Eubacteria

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:left;">

Cyanobacteria

</td>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:right;">

442

</td>
</tr>
<tr>
<td style="text-align:left;">

Protozoa

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:left;">

Euglenozoa

</td>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:right;">

462

</td>
</tr>
<tr>
<td style="text-align:left;">

Plantae

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:left;">

Lycopodiophyta

</td>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:right;">

17

</td>
</tr>
<tr>
<td style="text-align:left;">

Plantae

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:left;">

Marchantiophyta

</td>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:right;">

295

</td>
</tr>
<tr>
<td style="text-align:left;">

Chromista

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:left;">

Miozoa

</td>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:right;">

26

</td>
</tr>
<tr>
<td style="text-align:left;">

Animalia

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:left;">

Mollusca

</td>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:right;">

270

</td>
</tr>
<tr>
<td style="text-align:left;">

Animalia

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:left;">

Nematoda

</td>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:right;">

30

</td>
</tr>
<tr>
<td style="text-align:left;">

Chromista

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:left;">

Ochrophyta

</td>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:right;">

48

</td>
</tr>
<tr>
<td style="text-align:left;">

Animalia

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:left;">

Platyhelminthes

</td>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:left;">

Plantae

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:left;">

Pteridophyta

</td>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:right;">

77

</td>
</tr>
<tr>
<td style="text-align:left;">

Plantae

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:left;">

Rhodophyta

</td>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:right;">

30

</td>
</tr>
<tr>
<td style="text-align:left;">

Animalia

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:left;">

Rotifera

</td>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:right;">

388

</td>
</tr>
<tr>
<td style="text-align:left;">

Plantae

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:left;">

Tracheophyta

</td>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:right;">

4767

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

7 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

scientific_name_authorship

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
<th style="text-align:right;">

order_cases_in_name

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Aves

</td>
<td style="text-align:left;">

Linnaeus, 1758

</td>
<td style="text-align:right;">

17

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Chlorophyceae

</td>
<td style="text-align:left;">

Wille 1884

</td>
<td style="text-align:right;">

16

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Euglenophyceae

</td>
<td style="text-align:left;">

Schoenichen, 1925

</td>
<td style="text-align:right;">

20

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

30

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

191

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Maxillopoda

</td>
<td style="text-align:left;">

Dahl, 1956

</td>
<td style="text-align:right;">

12

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

165

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Reptilia

</td>
<td style="text-align:left;">

Laurenti, 1768

</td>
<td style="text-align:right;">

17

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Ulvophyceae

</td>
<td style="text-align:left;">

K.R.Mattox & K.D.Stewart 1984

</td>
<td style="text-align:right;">

16

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

0 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

scientific_name_authorship

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
<th style="text-align:right;">

order_cases_in_name

</th>
</tr>
</thead>
<tbody>
<tr>
</tr>
</tbody>
</table>

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

<table>
<caption>

7 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

scientific_name_authorship

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

cd_rank

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Aves

</td>
<td style="text-align:left;">

Linnaeus, 1758

</td>
<td style="text-align:right;">

17

</td>
<td style="text-align:left;">

CL

</td>
</tr>
<tr>
<td style="text-align:left;">

Chlorophyceae

</td>
<td style="text-align:left;">

Wille 1884

</td>
<td style="text-align:right;">

16

</td>
<td style="text-align:left;">

CL

</td>
</tr>
<tr>
<td style="text-align:left;">

Euglenophyceae

</td>
<td style="text-align:left;">

Schoenichen, 1925

</td>
<td style="text-align:right;">

20

</td>
<td style="text-align:left;">

CL

</td>
</tr>
<tr>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

30

</td>
<td style="text-align:left;">

CL

</td>
</tr>
<tr>
<td style="text-align:left;">

Maxillopoda

</td>
<td style="text-align:left;">

Dahl, 1956

</td>
<td style="text-align:right;">

12

</td>
<td style="text-align:left;">

CL

</td>
</tr>
<tr>
<td style="text-align:left;">

Reptilia

</td>
<td style="text-align:left;">

Laurenti, 1768

</td>
<td style="text-align:right;">

17

</td>
<td style="text-align:left;">

CL

</td>
</tr>
<tr>
<td style="text-align:left;">

Ulvophyceae

</td>
<td style="text-align:left;">

K.R.Mattox & K.D.Stewart 1984

</td>
<td style="text-align:right;">

16

</td>
<td style="text-align:left;">

CL

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

48 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

phylum

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

class

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Chordata

</td>
<td style="text-align:right;">

17

</td>
<td style="text-align:left;">

Actinopterygii

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

1855

</td>
</tr>
<tr>
<td style="text-align:left;">

Basidiomycota

</td>
<td style="text-align:right;">

14

</td>
<td style="text-align:left;">

Agaricomycetes

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Chordata

</td>
<td style="text-align:right;">

17

</td>
<td style="text-align:left;">

Amphibia

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

2228

</td>
</tr>
<tr>
<td style="text-align:left;">

Ascomycota

</td>
<td style="text-align:right;">

7

</td>
<td style="text-align:left;">

Arthoniomycetes

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

550

</td>
</tr>
<tr>
<td style="text-align:left;">

Chordata

</td>
<td style="text-align:right;">

17

</td>
<td style="text-align:left;">

Aves

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

35435

</td>
</tr>
<tr>
<td style="text-align:left;">

Bacillariophyta

</td>
<td style="text-align:right;">

13

</td>
<td style="text-align:left;">

Bacillariophyceae

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

2637

</td>
</tr>
<tr>
<td style="text-align:left;">

Mollusca

</td>
<td style="text-align:right;">

24

</td>
<td style="text-align:left;">

Bivalvia

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

89

</td>
</tr>
<tr>
<td style="text-align:left;">

Arthropoda

</td>
<td style="text-align:right;">

12

</td>
<td style="text-align:left;">

Branchiopoda

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

146

</td>
</tr>
<tr>
<td style="text-align:left;">

Bryophyta

</td>
<td style="text-align:right;">

8

</td>
<td style="text-align:left;">

Bryopsida

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

53

</td>
</tr>
<tr>
<td style="text-align:left;">

Chlorophyta

</td>
<td style="text-align:right;">

16

</td>
<td style="text-align:left;">

Chlorophyceae

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

550

</td>
</tr>
<tr>
<td style="text-align:left;">

Chordata

</td>
<td style="text-align:right;">

17

</td>
<td style="text-align:left;">

Chondrichthyes

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Ochrophyta

</td>
<td style="text-align:right;">

25

</td>
<td style="text-align:left;">

Chrysophyceae

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Annelida

</td>
<td style="text-align:right;">

11

</td>
<td style="text-align:left;">

Clitellata

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

115

</td>
</tr>
<tr>
<td style="text-align:left;">

Bacillariophyta

</td>
<td style="text-align:right;">

13

</td>
<td style="text-align:left;">

Coscinodiscophyceae

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

59

</td>
</tr>
<tr>
<td style="text-align:left;">

Cryptophyta

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:left;">

Cryptophyceae

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

50

</td>
</tr>
<tr>
<td style="text-align:left;">

Cyanobacteria

</td>
<td style="text-align:right;">

19

</td>
<td style="text-align:left;">

Cyanophyceae

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

442

</td>
</tr>
<tr>
<td style="text-align:left;">

Miozoa

</td>
<td style="text-align:right;">

23

</td>
<td style="text-align:left;">

Dinophyceae

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

26

</td>
</tr>
<tr>
<td style="text-align:left;">

Ascomycota

</td>
<td style="text-align:right;">

7

</td>
<td style="text-align:left;">

Dothideomycetes

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

61

</td>
</tr>
<tr>
<td style="text-align:left;">

Arthropoda

</td>
<td style="text-align:right;">

12

</td>
<td style="text-align:left;">

Entognatha

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

5956

</td>
</tr>
<tr>
<td style="text-align:left;">

Arthropoda

</td>
<td style="text-align:right;">

12

</td>
<td style="text-align:left;">

Euchelicerata

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

129

</td>
</tr>
<tr>
<td style="text-align:left;">

Euglenozoa

</td>
<td style="text-align:right;">

20

</td>
<td style="text-align:left;">

Euglenophyceae

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

462

</td>
</tr>
<tr>
<td style="text-align:left;">

Ascomycota

</td>
<td style="text-align:right;">

7

</td>
<td style="text-align:left;">

Eurotiomycetes

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

83

</td>
</tr>
<tr>
<td style="text-align:left;">

Ochrophyta

</td>
<td style="text-align:right;">

25

</td>
<td style="text-align:left;">

Eustigmatophyceae

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

19

</td>
</tr>
<tr>
<td style="text-align:left;">

Rhodophyta

</td>
<td style="text-align:right;">

28

</td>
<td style="text-align:left;">

Florideophyceae

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

30

</td>
</tr>
<tr>
<td style="text-align:left;">

Mollusca

</td>
<td style="text-align:right;">

24

</td>
<td style="text-align:left;">

Gastropoda

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

181

</td>
</tr>
<tr>
<td style="text-align:left;">

Arthropoda

</td>
<td style="text-align:right;">

12

</td>
<td style="text-align:left;">

Insecta

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

20829

</td>
</tr>
<tr>
<td style="text-align:left;">

Marchantiophyta

</td>
<td style="text-align:right;">

22

</td>
<td style="text-align:left;">

Jungermanniopsida

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

295

</td>
</tr>
<tr>
<td style="text-align:left;">

Charophyta

</td>
<td style="text-align:right;">

15

</td>
<td style="text-align:left;">

Klebsormidiophyceae

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:left;">

Ascomycota

</td>
<td style="text-align:right;">

7

</td>
<td style="text-align:left;">

Lecanoromycetes

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

1530

</td>
</tr>
<tr>
<td style="text-align:left;">

Tracheophyta

</td>
<td style="text-align:right;">

30

</td>
<td style="text-align:left;">

Liliopsida

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

418

</td>
</tr>
<tr>
<td style="text-align:left;">

Amoebozoa

</td>
<td style="text-align:right;">

10

</td>
<td style="text-align:left;">

Lobosa

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

120

</td>
</tr>
<tr>
<td style="text-align:left;">

Tracheophyta

</td>
<td style="text-align:right;">

30

</td>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

4346

</td>
</tr>
<tr>
<td style="text-align:left;">

Arthropoda

</td>
<td style="text-align:right;">

12

</td>
<td style="text-align:left;">

Malacostraca

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

27

</td>
</tr>
<tr>
<td style="text-align:left;">

Chordata

</td>
<td style="text-align:right;">

17

</td>
<td style="text-align:left;">

Mammalia

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

45744

</td>
</tr>
<tr>
<td style="text-align:left;">

Arthropoda

</td>
<td style="text-align:right;">

12

</td>
<td style="text-align:left;">

Maxillopoda

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

205

</td>
</tr>
<tr>
<td style="text-align:left;">

Rotifera

</td>
<td style="text-align:right;">

29

</td>
<td style="text-align:left;">

Monogonta

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

388

</td>
</tr>
<tr>
<td style="text-align:left;">

Arthropoda

</td>
<td style="text-align:right;">

12

</td>
<td style="text-align:left;">

Ostracoda

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

29

</td>
</tr>
<tr>
<td style="text-align:left;">

Tracheophyta

</td>
<td style="text-align:right;">

30

</td>
<td style="text-align:left;">

Pinopsida

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:left;">

Pteridophyta

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:left;">

Polypodiopsida

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

52

</td>
</tr>
<tr>
<td style="text-align:left;">

Pteridophyta

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:left;">

Pteridopsida

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

25

</td>
</tr>
<tr>
<td style="text-align:left;">

Chordata

</td>
<td style="text-align:right;">

17

</td>
<td style="text-align:left;">

Reptilia

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

2251

</td>
</tr>
<tr>
<td style="text-align:left;">

Lycopodiophyta

</td>
<td style="text-align:right;">

21

</td>
<td style="text-align:left;">

Selaginellopsida

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

17

</td>
</tr>
<tr>
<td style="text-align:left;">

Ochrophyta

</td>
<td style="text-align:right;">

25

</td>
<td style="text-align:left;">

Synurophyceae

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

21

</td>
</tr>
<tr>
<td style="text-align:left;">

Chlorophyta

</td>
<td style="text-align:right;">

16

</td>
<td style="text-align:left;">

Trebouxiophyceae

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

71

</td>
</tr>
<tr>
<td style="text-align:left;">

Platyhelminthes

</td>
<td style="text-align:right;">

26

</td>
<td style="text-align:left;">

Trepaxonemata

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:left;">

Chlorophyta

</td>
<td style="text-align:right;">

16

</td>
<td style="text-align:left;">

Ulvophyceae

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

22

</td>
</tr>
<tr>
<td style="text-align:left;">

Ochrophyta

</td>
<td style="text-align:right;">

25

</td>
<td style="text-align:left;">

Xanthophyceae

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

7

</td>
</tr>
<tr>
<td style="text-align:left;">

Charophyta

</td>
<td style="text-align:right;">

15

</td>
<td style="text-align:left;">

Zygnematophyceae

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

1292

</td>
</tr>
</tbody>
</table>

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
<table>
<caption>

24 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

scientific_name_authorship

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
<th style="text-align:right;">

order_cases_in_name

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Achnanthales

</td>
<td style="text-align:left;">

P.C. Silva, 1962

</td>
<td style="text-align:right;">

42

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Chlamydomonadales

</td>
<td style="text-align:left;">

Pascher, 1915

</td>
<td style="text-align:right;">

32

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

16

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Chroococcales

</td>
<td style="text-align:left;">

Schaffner, 1922

</td>
<td style="text-align:right;">

51

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Coleoptera

</td>
<td style="text-align:left;">

Linnaeus, 1758

</td>
<td style="text-align:right;">

60

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Diptera

</td>
<td style="text-align:left;">

Linnaeus, 1758

</td>
<td style="text-align:right;">

60

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Entomobryomorpha

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

54

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

290

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Lepidoptera

</td>
<td style="text-align:left;">

- `{=html}     </td>` `{=html}     <td style="text-align:right;">` 60
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` OR
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 2
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Mesostigmata
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Reuter, 1909 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 55 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` OR `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Naviculales
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Bessey, 1907 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 42 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` OR `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 2 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Neelipleona
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 54
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` OR
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 3
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Neoophora
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` Lang,
  1884 `{=html}     </td>` `{=html}     <td style="text-align:right;">`
  76 `{=html}     </td>` `{=html}     <td style="text-align:left;">` OR
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Odonata
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Fabricius, 1793 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 60 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` OR `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Oribatida
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` Dugès,
  1834 `{=html}     </td>` `{=html}     <td style="text-align:right;">`
  55 `{=html}     </td>` `{=html}     <td style="text-align:left;">` OR
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 2
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Oscillatoriales
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Schaffner 1922 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 51 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` OR `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 4 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Poduromorpha
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 54
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` OR
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 213
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Rodentia
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Bowdich, 1821 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 67 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` OR `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 4 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Sarcoptiformes
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Reuter, 1909 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 55 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` OR `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 6 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Sphaeropleales
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Luerssen, 1877 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 32 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` OR `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 2 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Squamata
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Merrem, 1820 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 36 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` OR `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Symphypleona
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 54
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` OR
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 213
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Synechococcaceae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Hoffmann, Komárek & Kastovsky 2005 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 51 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` OR `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Tricladida
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` Lang,
  1884 `{=html}     </td>` `{=html}     <td style="text-align:right;">`
  76 `{=html}     </td>` `{=html}     <td style="text-align:left;">` OR
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 3
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Trombidiformes
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Zakhvatkin, 1952 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 55 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` OR `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 118 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` NA `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` NA `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 40 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` OR `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     </tbody>` `{=html}     </table>`

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

<table>
<caption>

0 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

scientific_name_authorship

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
<th style="text-align:right;">

order_cases_in_name

</th>
</tr>
</thead>
<tbody>
<tr>
</tr>
</tbody>
</table>

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
<table>
<caption>

24 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

scientific_name_authorship

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

cd_rank

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Achnanthales

</td>
<td style="text-align:left;">

P.C. Silva, 1962

</td>
<td style="text-align:right;">

42

</td>
<td style="text-align:left;">

OR

</td>
</tr>
<tr>
<td style="text-align:left;">

Chlamydomonadales

</td>
<td style="text-align:left;">

Pascher, 1915

</td>
<td style="text-align:right;">

32

</td>
<td style="text-align:left;">

OR

</td>
</tr>
<tr>
<td style="text-align:left;">

Chroococcales

</td>
<td style="text-align:left;">

Schaffner, 1922

</td>
<td style="text-align:right;">

51

</td>
<td style="text-align:left;">

OR

</td>
</tr>
<tr>
<td style="text-align:left;">

Coleoptera

</td>
<td style="text-align:left;">

Linnaeus, 1758

</td>
<td style="text-align:right;">

60

</td>
<td style="text-align:left;">

OR

</td>
</tr>
<tr>
<td style="text-align:left;">

Diptera

</td>
<td style="text-align:left;">

Linnaeus, 1758

</td>
<td style="text-align:right;">

60

</td>
<td style="text-align:left;">

OR

</td>
</tr>
<tr>
<td style="text-align:left;">

Entomobryomorpha

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

54

</td>
<td style="text-align:left;">

OR

</td>
</tr>
<tr>
<td style="text-align:left;">

Lepidoptera

</td>
<td style="text-align:left;">

- `{=html}     </td>` `{=html}     <td style="text-align:right;">` 60
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` OR
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Mesostigmata
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Reuter, 1909 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 55 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` OR `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Naviculales
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Bessey, 1907 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 42 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` OR `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Neelipleona
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 54
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` OR
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Neoophora
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` Lang,
  1884 `{=html}     </td>` `{=html}     <td style="text-align:right;">`
  76 `{=html}     </td>` `{=html}     <td style="text-align:left;">` OR
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Odonata
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Fabricius, 1793 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 60 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` OR `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Oribatida
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` Dugès,
  1834 `{=html}     </td>` `{=html}     <td style="text-align:right;">`
  55 `{=html}     </td>` `{=html}     <td style="text-align:left;">` OR
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Oscillatoriales
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Schaffner 1922 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 51 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` OR `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Poduromorpha
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 54
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` OR
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Rodentia
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Bowdich, 1821 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 67 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` OR `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Sarcoptiformes
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Reuter, 1909 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 55 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` OR `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Sphaeropleales
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Luerssen, 1877 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 32 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` OR `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Squamata
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Merrem, 1820 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 36 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` OR `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Symphypleona
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 54
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` OR
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Synechococcaceae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Hoffmann, Komárek & Kastovsky 2005 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 51 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` OR `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Tricladida
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` Lang,
  1884 `{=html}     </td>` `{=html}     <td style="text-align:right;">`
  76 `{=html}     </td>` `{=html}     <td style="text-align:left;">` OR
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Trombidiformes
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Zakhvatkin, 1952 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 55 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` OR `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` NA `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` NA `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 40 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` OR `{=html}     </td>`
  `{=html}     </tr>` `{=html}     </tbody>` `{=html}     </table>`

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

<table>
<caption>

Displaying records 1 - 100

</caption>
<thead>
<tr>
<th style="text-align:left;">

class

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

order

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Aves

</td>
<td style="text-align:right;">

31

</td>
<td style="text-align:left;">

Accipitriformes

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

383

</td>
</tr>
<tr>
<td style="text-align:left;">

Bacillariophyceae

</td>
<td style="text-align:right;">

42

</td>
<td style="text-align:left;">

Achnanthales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

223

</td>
</tr>
<tr>
<td style="text-align:left;">

Florideophyceae

</td>
<td style="text-align:right;">

58

</td>
<td style="text-align:left;">

Acrochaetiales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

24

</td>
</tr>
<tr>
<td style="text-align:left;">

Agaricomycetes

</td>
<td style="text-align:right;">

39

</td>
<td style="text-align:left;">

Agaricales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Liliopsida

</td>
<td style="text-align:right;">

64

</td>
<td style="text-align:left;">

Alismatales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

143

</td>
</tr>
<tr>
<td style="text-align:left;">

Actinopterygii

</td>
<td style="text-align:right;">

38

</td>
<td style="text-align:left;">

Anabantiformes

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

26

</td>
</tr>
<tr>
<td style="text-align:left;">

Aves

</td>
<td style="text-align:right;">

31

</td>
<td style="text-align:left;">

Anseriformes

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

169

</td>
</tr>
<tr>
<td style="text-align:left;">

Amphibia

</td>
<td style="text-align:right;">

40

</td>
<td style="text-align:left;">

Anura

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

2190

</td>
</tr>
<tr>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:right;">

34

</td>
<td style="text-align:left;">

Apiales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

45

</td>
</tr>
<tr>
<td style="text-align:left;">

Aves

</td>
<td style="text-align:right;">

31

</td>
<td style="text-align:left;">

Apodiformes

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

161

</td>
</tr>
<tr>
<td style="text-align:left;">

Lobosa

</td>
<td style="text-align:right;">

65

</td>
<td style="text-align:left;">

Arcellinida

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

120

</td>
</tr>
<tr>
<td style="text-align:left;">

Gastropoda

</td>
<td style="text-align:right;">

59

</td>
<td style="text-align:left;">

Architaenioglossa

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

27

</td>
</tr>
<tr>
<td style="text-align:left;">

Liliopsida

</td>
<td style="text-align:right;">

64

</td>
<td style="text-align:left;">

Arecales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

66

</td>
</tr>
<tr>
<td style="text-align:left;">

Arthoniomycetes

</td>
<td style="text-align:right;">

41

</td>
<td style="text-align:left;">

Arthoniales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

550

</td>
</tr>
<tr>
<td style="text-align:left;">

Mammalia

</td>
<td style="text-align:right;">

67

</td>
<td style="text-align:left;">

Artiodactyla

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

504

</td>
</tr>
<tr>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:right;">

34

</td>
<td style="text-align:left;">

Asterales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:left;">

Coscinodiscophyceae

</td>
<td style="text-align:right;">

49

</td>
<td style="text-align:left;">

Aulacoseirales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

50

</td>
</tr>
<tr>
<td style="text-align:left;">

Bacillariophyceae

</td>
<td style="text-align:right;">

42

</td>
<td style="text-align:left;">

Bacillariales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

259

</td>
</tr>
<tr>
<td style="text-align:left;">

Florideophyceae

</td>
<td style="text-align:right;">

58

</td>
<td style="text-align:left;">

Balliales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

6

</td>
</tr>
<tr>
<td style="text-align:left;">

Gastropoda

</td>
<td style="text-align:right;">

59

</td>
<td style="text-align:left;">

Basommatophora

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

128

</td>
</tr>
<tr>
<td style="text-align:left;">

Actinopterygii

</td>
<td style="text-align:right;">

38

</td>
<td style="text-align:left;">

Blenniiformes

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

350

</td>
</tr>
<tr>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:right;">

34

</td>
<td style="text-align:left;">

Boraginales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

43

</td>
</tr>
<tr>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:right;">

34

</td>
<td style="text-align:left;">

Brassicales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:left;">

Maxillopoda

</td>
<td style="text-align:right;">

35

</td>
<td style="text-align:left;">

Calanoida

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

17

</td>
</tr>
<tr>
<td style="text-align:left;">

Lecanoromycetes

</td>
<td style="text-align:right;">

63

</td>
<td style="text-align:left;">

Caliciales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

Aves

</td>
<td style="text-align:right;">

31

</td>
<td style="text-align:left;">

Caprimulgiformes

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

721

</td>
</tr>
<tr>
<td style="text-align:left;">

Mammalia

</td>
<td style="text-align:right;">

67

</td>
<td style="text-align:left;">

Carnivora

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

2417

</td>
</tr>
<tr>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:right;">

34

</td>
<td style="text-align:left;">

Caryophyllales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

36

</td>
</tr>
<tr>
<td style="text-align:left;">

Aves

</td>
<td style="text-align:right;">

31

</td>
<td style="text-align:left;">

Cathartiformes

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

257

</td>
</tr>
<tr>
<td style="text-align:left;">

Amphibia

</td>
<td style="text-align:right;">

40

</td>
<td style="text-align:left;">

Caudata

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

38

</td>
</tr>
<tr>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:right;">

34

</td>
<td style="text-align:left;">

Celastrales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:left;">

Mammalia

</td>
<td style="text-align:right;">

67

</td>
<td style="text-align:left;">

Cetartiodactyla

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

18851

</td>
</tr>
<tr>
<td style="text-align:left;">

Chlorophyceae

</td>
<td style="text-align:right;">

32

</td>
<td style="text-align:left;">

Chaetophorales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

21

</td>
</tr>
<tr>
<td style="text-align:left;">

Actinopterygii

</td>
<td style="text-align:right;">

38

</td>
<td style="text-align:left;">

Characiformes

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

944

</td>
</tr>
<tr>
<td style="text-align:left;">

Aves

</td>
<td style="text-align:right;">

31

</td>
<td style="text-align:left;">

Charadriiformes

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

241

</td>
</tr>
<tr>
<td style="text-align:left;">

Mammalia

</td>
<td style="text-align:right;">

67

</td>
<td style="text-align:left;">

Chiroptera

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

4553

</td>
</tr>
<tr>
<td style="text-align:left;">

Chlorophyceae

</td>
<td style="text-align:right;">

32

</td>
<td style="text-align:left;">

Chlamydomonadales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

121

</td>
</tr>
<tr>
<td style="text-align:left;">

Trebouxiophyceae

</td>
<td style="text-align:right;">

75

</td>
<td style="text-align:left;">

Chlorellales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

39

</td>
</tr>
<tr>
<td style="text-align:left;">

Chrysophyceae

</td>
<td style="text-align:right;">

47

</td>
<td style="text-align:left;">

Chromulinales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Cyanophyceae

</td>
<td style="text-align:right;">

51

</td>
<td style="text-align:left;">

Chroococcales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

20

</td>
</tr>
<tr>
<td style="text-align:left;">

Aves

</td>
<td style="text-align:right;">

31

</td>
<td style="text-align:left;">

Ciconiiformes

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:left;">

Mammalia

</td>
<td style="text-align:right;">

67

</td>
<td style="text-align:left;">

Cingulata

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

652

</td>
</tr>
<tr>
<td style="text-align:left;">

Ulvophyceae

</td>
<td style="text-align:right;">

37

</td>
<td style="text-align:left;">

Cladophorales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

7

</td>
</tr>
<tr>
<td style="text-align:left;">

Insecta

</td>
<td style="text-align:right;">

60

</td>
<td style="text-align:left;">

Coleoptera

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

4949

</td>
</tr>
<tr>
<td style="text-align:left;">

Aves

</td>
<td style="text-align:right;">

31

</td>
<td style="text-align:left;">

Columbiformes

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

7530

</td>
</tr>
<tr>
<td style="text-align:left;">

Liliopsida

</td>
<td style="text-align:right;">

64

</td>
<td style="text-align:left;">

Commelinales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

43

</td>
</tr>
<tr>
<td style="text-align:left;">

Aves

</td>
<td style="text-align:right;">

31

</td>
<td style="text-align:left;">

Coraciiformes

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

1442

</td>
</tr>
<tr>
<td style="text-align:left;">

Reptilia

</td>
<td style="text-align:right;">

36

</td>
<td style="text-align:left;">

Crocodylia

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

93

</td>
</tr>
<tr>
<td style="text-align:left;">

Cryptophyceae

</td>
<td style="text-align:right;">

50

</td>
<td style="text-align:left;">

Cryptomonadales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

44

</td>
</tr>
<tr>
<td style="text-align:left;">

Branchiopoda

</td>
<td style="text-align:right;">

44

</td>
<td style="text-align:left;">

Ctenopoda

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Aves

</td>
<td style="text-align:right;">

31

</td>
<td style="text-align:left;">

Cuculiformes

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

1937

</td>
</tr>
<tr>
<td style="text-align:left;">

Maxillopoda

</td>
<td style="text-align:right;">

35

</td>
<td style="text-align:left;">

Cyclopoida

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

23

</td>
</tr>
<tr>
<td style="text-align:left;">

Bacillariophyceae

</td>
<td style="text-align:right;">

42

</td>
<td style="text-align:left;">

Cymbellales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

362

</td>
</tr>
<tr>
<td style="text-align:left;">

Malacostraca

</td>
<td style="text-align:right;">

66

</td>
<td style="text-align:left;">

Decapoda

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

27

</td>
</tr>
<tr>
<td style="text-align:left;">

Zygnematophyceae

</td>
<td style="text-align:right;">

78

</td>
<td style="text-align:left;">

Desmidiales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

1138

</td>
</tr>
<tr>
<td style="text-align:left;">

Mammalia

</td>
<td style="text-align:right;">

67

</td>
<td style="text-align:left;">

Didelphimorphia

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

934

</td>
</tr>
<tr>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:right;">

34

</td>
<td style="text-align:left;">

Dilleniales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:left;">

Branchiopoda

</td>
<td style="text-align:right;">

44

</td>
<td style="text-align:left;">

Diplostraca

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

144

</td>
</tr>
<tr>
<td style="text-align:left;">

Insecta

</td>
<td style="text-align:right;">

60

</td>
<td style="text-align:left;">

Diptera

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

1049

</td>
</tr>
<tr>
<td style="text-align:left;">

Entognatha

</td>
<td style="text-align:right;">

54

</td>
<td style="text-align:left;">

Entomobryomorpha

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

3547

</td>
</tr>
<tr>
<td style="text-align:left;">

Insecta

</td>
<td style="text-align:right;">

60

</td>
<td style="text-align:left;">

Ephemeroptera

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

286

</td>
</tr>
<tr>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:right;">

34

</td>
<td style="text-align:left;">

Ericales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

165

</td>
</tr>
<tr>
<td style="text-align:left;">

Euglenophyceae

</td>
<td style="text-align:right;">

33

</td>
<td style="text-align:left;">

Euglenida

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

459

</td>
</tr>
<tr>
<td style="text-align:left;">

Bacillariophyceae

</td>
<td style="text-align:right;">

42

</td>
<td style="text-align:left;">

Eunotiales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

645

</td>
</tr>
<tr>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:right;">

34

</td>
<td style="text-align:left;">

Fabales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

332

</td>
</tr>
<tr>
<td style="text-align:left;">

Aves

</td>
<td style="text-align:right;">

31

</td>
<td style="text-align:left;">

Falconiformes

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

645

</td>
</tr>
<tr>
<td style="text-align:left;">

Monogonta

</td>
<td style="text-align:right;">

68

</td>
<td style="text-align:left;">

Flosculariacea

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

30

</td>
</tr>
<tr>
<td style="text-align:left;">

Bacillariophyceae

</td>
<td style="text-align:right;">

42

</td>
<td style="text-align:left;">

Fragilariales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

8

</td>
</tr>
<tr>
<td style="text-align:left;">

Aves

</td>
<td style="text-align:right;">

31

</td>
<td style="text-align:left;">

Galbuliformes

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

54

</td>
</tr>
<tr>
<td style="text-align:left;">

Aves

</td>
<td style="text-align:right;">

31

</td>
<td style="text-align:left;">

Galliformes

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

4151

</td>
</tr>
<tr>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:right;">

34

</td>
<td style="text-align:left;">

Gentianales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

334

</td>
</tr>
<tr>
<td style="text-align:left;">

Eustigmatophyceae

</td>
<td style="text-align:right;">

57

</td>
<td style="text-align:left;">

Goniochloridales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

19

</td>
</tr>
<tr>
<td style="text-align:left;">

Dinophyceae

</td>
<td style="text-align:right;">

52

</td>
<td style="text-align:left;">

Gonyaulacales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Aves

</td>
<td style="text-align:right;">

31

</td>
<td style="text-align:left;">

Gruiformes

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

6569

</td>
</tr>
<tr>
<td style="text-align:left;">

Dinophyceae

</td>
<td style="text-align:right;">

52

</td>
<td style="text-align:left;">

Gymnodiniales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:left;">

Actinopterygii

</td>
<td style="text-align:right;">

38

</td>
<td style="text-align:left;">

Gymnotiformes

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

162

</td>
</tr>
<tr>
<td style="text-align:left;">

Insecta

</td>
<td style="text-align:right;">

60

</td>
<td style="text-align:left;">

Hemiptera

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

565

</td>
</tr>
<tr>
<td style="text-align:left;">

Clitellata

</td>
<td style="text-align:right;">

48

</td>
<td style="text-align:left;">

Hirudinida

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

51

</td>
</tr>
<tr>
<td style="text-align:left;">

Bryopsida

</td>
<td style="text-align:right;">

45

</td>
<td style="text-align:left;">

Hookeriales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Polypodiopsida

</td>
<td style="text-align:right;">

71

</td>
<td style="text-align:left;">

Hymenophyllales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Insecta

</td>
<td style="text-align:right;">

60

</td>
<td style="text-align:left;">

Hymenoptera

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

9245

</td>
</tr>
<tr>
<td style="text-align:left;">

Bryopsida

</td>
<td style="text-align:right;">

45

</td>
<td style="text-align:left;">

Hypnales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

13

</td>
</tr>
<tr>
<td style="text-align:left;">

Jungermanniopsida

</td>
<td style="text-align:right;">

61

</td>
<td style="text-align:left;">

Jungermanniales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:left;">

Klebsormidiophyceae

</td>
<td style="text-align:right;">

62

</td>
<td style="text-align:left;">

Klebsormidiales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:right;">

34

</td>
<td style="text-align:left;">

Lamiales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

119

</td>
</tr>
<tr>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:right;">

34

</td>
<td style="text-align:left;">

Laurales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

215

</td>
</tr>
<tr>
<td style="text-align:left;">

Lecanoromycetes

</td>
<td style="text-align:right;">

63

</td>
<td style="text-align:left;">

Lecanorales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

245

</td>
</tr>
<tr>
<td style="text-align:left;">

Insecta

</td>
<td style="text-align:right;">

60

</td>
<td style="text-align:left;">

Lepidoptera

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

3812

</td>
</tr>
<tr>
<td style="text-align:left;">

Bacillariophyceae

</td>
<td style="text-align:right;">

42

</td>
<td style="text-align:left;">

Licmophorales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Liliopsida

</td>
<td style="text-align:right;">

64

</td>
<td style="text-align:left;">

Liliales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Clitellata

</td>
<td style="text-align:right;">

48

</td>
<td style="text-align:left;">

Lumbriculida

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

6

</td>
</tr>
<tr>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:right;">

34

</td>
<td style="text-align:left;">

Magnoliales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

488

</td>
</tr>
<tr>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:right;">

34

</td>
<td style="text-align:left;">

Malpighiales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

861

</td>
</tr>
<tr>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:right;">

34

</td>
<td style="text-align:left;">

Malvales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

89

</td>
</tr>
<tr>
<td style="text-align:left;">

Bacillariophyceae

</td>
<td style="text-align:right;">

42

</td>
<td style="text-align:left;">

Mastogloiales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:left;">

Insecta

</td>
<td style="text-align:right;">

60

</td>
<td style="text-align:left;">

Megaloptera

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Coscinodiscophyceae

</td>
<td style="text-align:right;">

49

</td>
<td style="text-align:left;">

Melosirales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

6

</td>
</tr>
<tr>
<td style="text-align:left;">

Euchelicerata

</td>
<td style="text-align:right;">

55

</td>
<td style="text-align:left;">

Mesostigmata

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:right;">

34

</td>
<td style="text-align:left;">

Metteniusales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

7

</td>
</tr>
<tr>
<td style="text-align:left;">

Jungermanniopsida

</td>
<td style="text-align:right;">

61

</td>
<td style="text-align:left;">

Metzgeriales

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

1

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

1 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

scientific_name_authorship

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
<th style="text-align:right;">

order_cases_in_name

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Brachycera

</td>
<td style="text-align:left;">

Schiner, 1862

</td>
<td style="text-align:right;">

83

</td>
<td style="text-align:left;">

SOR

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

0 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

scientific_name_authorship

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
<th style="text-align:right;">

order_cases_in_name

</th>
</tr>
</thead>
<tbody>
<tr>
</tr>
</tbody>
</table>

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

<table>
<caption>

1 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

scientific_name_authorship

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

cd_rank

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Brachycera

</td>
<td style="text-align:left;">

Schiner, 1862

</td>
<td style="text-align:right;">

83

</td>
<td style="text-align:left;">

SOR

</td>
</tr>
</tbody>
</table>

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
<table>
<caption>

96 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

scientific_name_authorship

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
<th style="text-align:right;">

order_cases_in_name

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Acanthaceae

</td>
<td style="text-align:left;">

Juss, 1789

</td>
<td style="text-align:right;">

180

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Acanthaceae

</td>
<td style="text-align:left;">

Juss. 1789

</td>
<td style="text-align:right;">

180

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Achnanthidiaceae

</td>
<td style="text-align:left;">

Kützing, 1844

</td>
<td style="text-align:right;">

79

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

192

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Annonaceae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

186

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

8

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Arctiidae

</td>
<td style="text-align:left;">

Leach, 1815

</td>
<td style="text-align:right;">

85

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Arecaceae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

113

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

7

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Baetidae

</td>
<td style="text-align:left;">

Leach, 1815

</td>
<td style="text-align:right;">

156

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

23

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Bombacaceae

</td>
<td style="text-align:left;">

Kunth, 1822

</td>
<td style="text-align:right;">

188

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Bourletiellidae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

98

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

16

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Caprimulgidae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

126

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Chironomidae

</td>
<td style="text-align:left;">

Rondani, 1840

</td>
<td style="text-align:right;">

83

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Chroococcaceae

</td>
<td style="text-align:left;">

Rabenhorst 1863

</td>
<td style="text-align:right;">

81

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Chrysomelidae

</td>
<td style="text-align:left;">

 Latreille, 1802

</td>
<td style="text-align:right;">

82

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Coenagrionidae

</td>
<td style="text-align:left;">

Kirby, 1890

</td>
<td style="text-align:right;">

90

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

8

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Colubridae

</td>
<td style="text-align:left;">

Oppel, 1811

</td>
<td style="text-align:right;">

97

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

6

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Crambidae

</td>
<td style="text-align:left;">

Latreille, 1810

</td>
<td style="text-align:right;">

85

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

21

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Curculionidae

</td>
<td style="text-align:left;">

Latreille, 1802

</td>
<td style="text-align:right;">

82

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Cyperaceae

</td>
<td style="text-align:left;">

Juss, 1789

</td>
<td style="text-align:right;">

222

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

8

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Cyperaceae

</td>
<td style="text-align:left;">

Juss. 1789

</td>
<td style="text-align:right;">

222

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

8

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Desmidiaceae

</td>
<td style="text-align:left;">

Ralfs, 1848

</td>
<td style="text-align:right;">

152

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Dolichopodidae

</td>
<td style="text-align:left;">

Latreille‎, 1809‎

</td>
<td style="text-align:right;">

83

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

12

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Dryopidae

</td>
<td style="text-align:left;">

Billberg, 1820

</td>
<td style="text-align:right;">

82

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Dycirtomidae

</td>
<td style="text-align:left;">

Börner, 1903

</td>
<td style="text-align:right;">

98

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Dycirtomidae

</td>
<td style="text-align:left;">

Börner, 1906

</td>
<td style="text-align:right;">

98

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Dytiscidae

</td>
<td style="text-align:left;">

Leach, 1815

</td>
<td style="text-align:right;">

82

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Dytiscidae

</td>
<td style="text-align:left;">

Aube, 1836

</td>
<td style="text-align:right;">

82

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Empididae

</td>
<td style="text-align:left;">

Latreille, 1804

</td>
<td style="text-align:right;">

83

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Entomobryidae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

84

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

173

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Entomobryidae

</td>
<td style="text-align:left;">

Schäffer, 1896

</td>
<td style="text-align:right;">

84

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Entomobryidae

</td>
<td style="text-align:left;">

N.D

</td>
<td style="text-align:right;">

84

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:left;">

Euphorbiaceae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

187

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

9

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Fabaceae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

160

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Felidae

</td>
<td style="text-align:left;">

Fischer von Waldheim, 1817

</td>
<td style="text-align:right;">

127

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Fragilariaceae

</td>
<td style="text-align:left;">

Greville, 1833

</td>
<td style="text-align:right;">

163

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Gerridae

</td>
<td style="text-align:left;">

\#N/D

</td>
<td style="text-align:right;">

172

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Gerridae

</td>
<td style="text-align:left;">

Leach, 1815

</td>
<td style="text-align:right;">

172

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Glossiphoniidae

</td>
<td style="text-align:left;">

Vaillant, 1890

</td>
<td style="text-align:right;">

173

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

40

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Glossiphoniidae

</td>
<td style="text-align:left;">

Blanchard, 1896

</td>
<td style="text-align:right;">

173

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

11

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Gomphidae

</td>
<td style="text-align:left;">

Rambur, 1842

</td>
<td style="text-align:right;">

90

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Gomphonemataceae

</td>
<td style="text-align:left;">

Kützing, 1844

</td>
<td style="text-align:right;">

150

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Graphidaceae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

206

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

44

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Gryllidae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

205

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Gyrinidae

</td>
<td style="text-align:left;">

Latreille, 1810

</td>
<td style="text-align:right;">

82

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Hydrobiidae

</td>
<td style="text-align:left;">

Stimpson, 1865

</td>
<td style="text-align:right;">

199

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

22

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Hydroptilidae

</td>
<td style="text-align:left;">

Stephens, 1836

</td>
<td style="text-align:right;">

253

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Hypogastruridae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

93

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Isotomidae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

84

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

181

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Lampyridae

</td>
<td style="text-align:left;">

Rafinesque, 1815

</td>
<td style="text-align:right;">

82

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Lampyridae

</td>
<td style="text-align:left;">

Latreille, 1817

</td>
<td style="text-align:right;">

82

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Lauraceae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

181

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

60

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Leptophlebiidae

</td>
<td style="text-align:left;">

- `{=html}     </td>` `{=html}     <td style="text-align:right;">` 156
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` FAM
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Libellulidae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Rambur, 1842 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 90 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 5 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Liliaceae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` Juss.
  1789 `{=html}     </td>` `{=html}     <td style="text-align:right;">`
  184 `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  FAM `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Limnichidae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Erichson, 1846 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 82 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Lumbriculidae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Vejdovský, 1884 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 185 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 6 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Lutrochidae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` Kasap
  and Crowson, 1975 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 82 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 2 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Marantaceae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` R. Br.
  1814 `{=html}     </td>` `{=html}     <td style="text-align:right;">`
  261 `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  FAM `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Mesoveliidae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Douglas & Scott, 1867 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 172 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Molossidae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 136
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` FAM
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 38
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Moraceae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 232
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` FAM
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 4
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Muscidae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Latreille, 1802 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 83 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 4 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Naididae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Ehrenberg 1828 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 256 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 54 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Naididae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Ehrenberg, 1828 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 256 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 4 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 2 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Neanuridae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 93
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` FAM
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 2
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Noteridae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` C. G.
  Thomson, 1860 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 82 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Orchesellidae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 84
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` FAM
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 3
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Oscillatoriaceae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Engler, 1898 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 92 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 5 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Oscillatoriaceae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` Engler
  1898 `{=html}     </td>` `{=html}     <td style="text-align:right;">`
  92 `{=html}     </td>` `{=html}     <td style="text-align:left;">` FAM
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 3
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 2
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Phormidiaceae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Anagnostidis & Komárek, 1988 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 92 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 5 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Phyllostomidae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 136
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` FAM
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 10
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Poaceae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Barnhart, 1895 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 222 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 2 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Poaceae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Barnhart. 1895 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 222 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 2 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Polycentropodidae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` Ulmer,
  1903 `{=html}     </td>` `{=html}     <td style="text-align:right;">`
  253 `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  FAM `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Pseudanabaenaceae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  K.Anagnostidis & J.Komárek , 1988 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 245 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 15 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Pseudanabaenaceae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  K.Anagnostidis & J.Komárek 1988 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 245 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 2 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 2 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Pseudanabaenaceae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Anagnostidis & Komárek, 1988 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 245 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 3 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Psychodidae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` N.D
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 83
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` FAM
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Pyralidae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Latreille, 1802 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 85 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 3 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Ramalinaceae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 182
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` FAM
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 4
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Rubiaceae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 166
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` FAM
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 46
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Sciaridae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  - `{=html}     </td>` `{=html}     <td style="text-align:right;">` 83
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` FAM
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:left;">` Simaroubaceae
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 235
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` FAM
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:left;">` Sminthuridae
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 98
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` FAM
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 2
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:left;">` Sminthurididae
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 98
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` FAM
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 98
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:left;">` Staphylinidae
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Latreille, 1802 `{=html}     </td>`
    `{=html}     <td style="text-align:right;">` 82 `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
    `{=html}     <td style="text-align:right;">` 4 `{=html}     </td>`
    `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
    `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:left;">` Staphylinidae
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Latreille, 1796 `{=html}     </td>`
    `{=html}     <td style="text-align:right;">` 82 `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
    `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
    `{=html}     <td style="text-align:right;">` 2 `{=html}     </td>`
    `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:left;">` Stratiomyidae
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Latreille, 1802 `{=html}     </td>`
    `{=html}     <td style="text-align:right;">` 83 `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
    `{=html}     <td style="text-align:right;">` 2 `{=html}     </td>`
    `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
    `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:left;">` Tabanidae
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Latreille, 1802 `{=html}     </td>`
    `{=html}     <td style="text-align:right;">` 83 `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
    `{=html}     <td style="text-align:right;">` 14 `{=html}     </td>`
    `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
    `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:left;">` Tettigoniidae
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 205
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` FAM
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 8
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:left;">` Tipulidae
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Kirby & Spence, 1815 `{=html}     </td>`
    `{=html}     <td style="text-align:right;">` 83 `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
    `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
    `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
    `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:left;">` Trichodactylidae
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Milne Edwards, 1853 `{=html}     </td>`
    `{=html}     <td style="text-align:right;">` 151 `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
    `{=html}     <td style="text-align:right;">` 19 `{=html}     </td>`
    `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
    `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:left;">` Trombidiidae
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    - `{=html}     </td>` `{=html}     <td style="text-align:right;">`
      101 `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` FAM
      `{=html}     </td>` `{=html}     <td style="text-align:right;">` 2
      `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
      `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
      `{=html}     <td style="text-align:left;">` Ulotrichaceae
      `{=html}     </td>` `{=html}     <td style="text-align:left;">`
      Kützing, 1843 `{=html}     </td>`
      `{=html}     <td style="text-align:right;">` 257
      `{=html}     </td>` `{=html}     <td style="text-align:left;">`
      FAM `{=html}     </td>`
      `{=html}     <td style="text-align:right;">` 2 `{=html}     </td>`
      `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
      `{=html}     </tr>` `{=html}     <tr>`
      `{=html}     <td style="text-align:left;">` Veliidae
      `{=html}     </td>` `{=html}     <td style="text-align:left;">`
      Amyot & Serville, 1843 `{=html}     </td>`
      `{=html}     <td style="text-align:right;">` 172
      `{=html}     </td>` `{=html}     <td style="text-align:left;">`
      FAM `{=html}     </td>`
      `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
      `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
      `{=html}     </tr>` `{=html}     <tr>`
      `{=html}     <td style="text-align:left;">` Vespertilionidae
      `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
      `{=html}     </td>` `{=html}     <td style="text-align:right;">`
      136 `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` FAM
      `{=html}     </td>` `{=html}     <td style="text-align:right;">`
      32 `{=html}     </td>`
      `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
      `{=html}     </tr>` `{=html}     <tr>`
      `{=html}     <td style="text-align:left;">` Xyridaceae
      `{=html}     </td>` `{=html}     <td style="text-align:left;">`
      C.Agardh `{=html}     </td>`
      `{=html}     <td style="text-align:right;">` 222
      `{=html}     </td>` `{=html}     <td style="text-align:left;">`
      FAM `{=html}     </td>`
      `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
      `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
      `{=html}     </tr>` `{=html}     </tbody>` `{=html}     </table>`

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

<table>
<caption>

28 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

scientific_name_authorship

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
<th style="text-align:right;">

order_cases_in_name

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Acanthaceae

</td>
<td style="text-align:left;">

Juss, 1789

</td>
<td style="text-align:right;">

180

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Acanthaceae

</td>
<td style="text-align:left;">

Juss. 1789

</td>
<td style="text-align:right;">

180

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Cyperaceae

</td>
<td style="text-align:left;">

Juss, 1789

</td>
<td style="text-align:right;">

222

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

8

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Cyperaceae

</td>
<td style="text-align:left;">

Juss. 1789

</td>
<td style="text-align:right;">

222

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

8

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Dycirtomidae

</td>
<td style="text-align:left;">

Börner, 1903

</td>
<td style="text-align:right;">

98

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Dycirtomidae

</td>
<td style="text-align:left;">

Börner, 1906

</td>
<td style="text-align:right;">

98

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Dytiscidae

</td>
<td style="text-align:left;">

Leach, 1815

</td>
<td style="text-align:right;">

82

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Dytiscidae

</td>
<td style="text-align:left;">

Aube, 1836

</td>
<td style="text-align:right;">

82

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Entomobryidae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

84

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

173

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Entomobryidae

</td>
<td style="text-align:left;">

Schäffer, 1896

</td>
<td style="text-align:right;">

84

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Entomobryidae

</td>
<td style="text-align:left;">

N.D

</td>
<td style="text-align:right;">

84

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:left;">

Gerridae

</td>
<td style="text-align:left;">

\#N/D

</td>
<td style="text-align:right;">

172

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Gerridae

</td>
<td style="text-align:left;">

Leach, 1815

</td>
<td style="text-align:right;">

172

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Glossiphoniidae

</td>
<td style="text-align:left;">

Vaillant, 1890

</td>
<td style="text-align:right;">

173

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

40

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Glossiphoniidae

</td>
<td style="text-align:left;">

Blanchard, 1896

</td>
<td style="text-align:right;">

173

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

11

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Lampyridae

</td>
<td style="text-align:left;">

Rafinesque, 1815

</td>
<td style="text-align:right;">

82

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Lampyridae

</td>
<td style="text-align:left;">

Latreille, 1817

</td>
<td style="text-align:right;">

82

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Naididae

</td>
<td style="text-align:left;">

Ehrenberg 1828

</td>
<td style="text-align:right;">

256

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

54

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Naididae

</td>
<td style="text-align:left;">

Ehrenberg, 1828

</td>
<td style="text-align:right;">

256

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Oscillatoriaceae

</td>
<td style="text-align:left;">

Engler, 1898

</td>
<td style="text-align:right;">

92

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Oscillatoriaceae

</td>
<td style="text-align:left;">

Engler 1898

</td>
<td style="text-align:right;">

92

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Poaceae

</td>
<td style="text-align:left;">

Barnhart, 1895

</td>
<td style="text-align:right;">

222

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Poaceae

</td>
<td style="text-align:left;">

Barnhart. 1895

</td>
<td style="text-align:right;">

222

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Pseudanabaenaceae

</td>
<td style="text-align:left;">

K.Anagnostidis & J.Komárek , 1988

</td>
<td style="text-align:right;">

245

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

15

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Pseudanabaenaceae

</td>
<td style="text-align:left;">

K.Anagnostidis & J.Komárek 1988

</td>
<td style="text-align:right;">

245

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Pseudanabaenaceae

</td>
<td style="text-align:left;">

Anagnostidis & Komárek, 1988

</td>
<td style="text-align:right;">

245

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:left;">

Staphylinidae

</td>
<td style="text-align:left;">

Latreille, 1802

</td>
<td style="text-align:right;">

82

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Staphylinidae

</td>
<td style="text-align:left;">

Latreille, 1796

</td>
<td style="text-align:right;">

82

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
</tbody>
</table>

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
<table>
<caption>

81 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

scientific_name_authorship

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

cd_rank

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Acanthaceae

</td>
<td style="text-align:left;">

Juss, 1789

</td>
<td style="text-align:right;">

180

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Achnanthidiaceae

</td>
<td style="text-align:left;">

Kützing, 1844

</td>
<td style="text-align:right;">

79

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Annonaceae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

186

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Arctiidae

</td>
<td style="text-align:left;">

Leach, 1815

</td>
<td style="text-align:right;">

85

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Arecaceae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

113

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Baetidae

</td>
<td style="text-align:left;">

Leach, 1815

</td>
<td style="text-align:right;">

156

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Bombacaceae

</td>
<td style="text-align:left;">

Kunth, 1822

</td>
<td style="text-align:right;">

188

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Bourletiellidae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

98

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Caprimulgidae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

126

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Chironomidae

</td>
<td style="text-align:left;">

Rondani, 1840

</td>
<td style="text-align:right;">

83

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Chroococcaceae

</td>
<td style="text-align:left;">

Rabenhorst 1863

</td>
<td style="text-align:right;">

81

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Chrysomelidae

</td>
<td style="text-align:left;">

 Latreille, 1802

</td>
<td style="text-align:right;">

82

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Coenagrionidae

</td>
<td style="text-align:left;">

Kirby, 1890

</td>
<td style="text-align:right;">

90

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Colubridae

</td>
<td style="text-align:left;">

Oppel, 1811

</td>
<td style="text-align:right;">

97

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Crambidae

</td>
<td style="text-align:left;">

Latreille, 1810

</td>
<td style="text-align:right;">

85

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Curculionidae

</td>
<td style="text-align:left;">

Latreille, 1802

</td>
<td style="text-align:right;">

82

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Cyperaceae

</td>
<td style="text-align:left;">

Juss, 1789

</td>
<td style="text-align:right;">

222

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Desmidiaceae

</td>
<td style="text-align:left;">

Ralfs, 1848

</td>
<td style="text-align:right;">

152

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Dolichopodidae

</td>
<td style="text-align:left;">

Latreille‎, 1809‎

</td>
<td style="text-align:right;">

83

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Dryopidae

</td>
<td style="text-align:left;">

Billberg, 1820

</td>
<td style="text-align:right;">

82

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Dycirtomidae

</td>
<td style="text-align:left;">

Börner, 1903

</td>
<td style="text-align:right;">

98

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Dytiscidae

</td>
<td style="text-align:left;">

Leach, 1815

</td>
<td style="text-align:right;">

82

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Empididae

</td>
<td style="text-align:left;">

Latreille, 1804

</td>
<td style="text-align:right;">

83

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Entomobryidae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

84

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Euphorbiaceae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

187

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Fabaceae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

160

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Felidae

</td>
<td style="text-align:left;">

Fischer von Waldheim, 1817

</td>
<td style="text-align:right;">

127

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Fragilariaceae

</td>
<td style="text-align:left;">

Greville, 1833

</td>
<td style="text-align:right;">

163

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Gerridae

</td>
<td style="text-align:left;">

\#N/D

</td>
<td style="text-align:right;">

172

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Glossiphoniidae

</td>
<td style="text-align:left;">

Vaillant, 1890

</td>
<td style="text-align:right;">

173

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Gomphidae

</td>
<td style="text-align:left;">

Rambur, 1842

</td>
<td style="text-align:right;">

90

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Gomphonemataceae

</td>
<td style="text-align:left;">

Kützing, 1844

</td>
<td style="text-align:right;">

150

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Graphidaceae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

206

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Gryllidae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

205

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Gyrinidae

</td>
<td style="text-align:left;">

Latreille, 1810

</td>
<td style="text-align:right;">

82

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Hydrobiidae

</td>
<td style="text-align:left;">

Stimpson, 1865

</td>
<td style="text-align:right;">

199

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Hydroptilidae

</td>
<td style="text-align:left;">

Stephens, 1836

</td>
<td style="text-align:right;">

253

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Hypogastruridae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

93

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Isotomidae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

84

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Lampyridae

</td>
<td style="text-align:left;">

Rafinesque, 1815

</td>
<td style="text-align:right;">

82

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Lauraceae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

181

</td>
<td style="text-align:left;">

FAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Leptophlebiidae

</td>
<td style="text-align:left;">

- `{=html}     </td>` `{=html}     <td style="text-align:right;">` 156
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` FAM
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Libellulidae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Rambur, 1842 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 90 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Liliaceae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` Juss.
  1789 `{=html}     </td>` `{=html}     <td style="text-align:right;">`
  184 `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  FAM `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Limnichidae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Erichson, 1846 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 82 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Lumbriculidae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Vejdovský, 1884 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 185 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Lutrochidae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` Kasap
  and Crowson, 1975 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 82 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Marantaceae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` R. Br.
  1814 `{=html}     </td>` `{=html}     <td style="text-align:right;">`
  261 `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  FAM `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Mesoveliidae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Douglas & Scott, 1867 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 172 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Molossidae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 136
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` FAM
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Moraceae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 232
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` FAM
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Muscidae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Latreille, 1802 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 83 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Naididae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Ehrenberg 1828 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 256 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Neanuridae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 93
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` FAM
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Noteridae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` C. G.
  Thomson, 1860 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 82 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Orchesellidae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 84
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` FAM
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Oscillatoriaceae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Engler, 1898 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 92 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Phormidiaceae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Anagnostidis & Komárek, 1988 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 92 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Phyllostomidae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 136
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` FAM
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Poaceae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Barnhart, 1895 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 222 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Polycentropodidae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` Ulmer,
  1903 `{=html}     </td>` `{=html}     <td style="text-align:right;">`
  253 `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  FAM `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Pseudanabaenaceae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  K.Anagnostidis & J.Komárek , 1988 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 245 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Psychodidae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` N.D
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 83
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` FAM
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Pyralidae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  Latreille, 1802 `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 85 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Ramalinaceae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 182
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` FAM
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Rubiaceae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 166
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` FAM
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:left;">` Sciaridae
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  - `{=html}     </td>` `{=html}     <td style="text-align:right;">` 83
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` FAM
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:left;">` Simaroubaceae
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 235
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` FAM
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:left;">` Sminthuridae
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 98
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` FAM
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:left;">` Sminthurididae
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 98
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` FAM
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:left;">` Staphylinidae
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Latreille, 1802 `{=html}     </td>`
    `{=html}     <td style="text-align:right;">` 82 `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
    `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:left;">` Stratiomyidae
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Latreille, 1802 `{=html}     </td>`
    `{=html}     <td style="text-align:right;">` 83 `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
    `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:left;">` Tabanidae
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Latreille, 1802 `{=html}     </td>`
    `{=html}     <td style="text-align:right;">` 83 `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
    `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:left;">` Tettigoniidae
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 205
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` FAM
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:left;">` Tipulidae
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Kirby & Spence, 1815 `{=html}     </td>`
    `{=html}     <td style="text-align:right;">` 83 `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
    `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:left;">` Trichodactylidae
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Milne Edwards, 1853 `{=html}     </td>`
    `{=html}     <td style="text-align:right;">` 151 `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` FAM `{=html}     </td>`
    `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:left;">` Trombidiidae
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    - `{=html}     </td>` `{=html}     <td style="text-align:right;">`
      101 `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` FAM
      `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
      `{=html}     <td style="text-align:left;">` Ulotrichaceae
      `{=html}     </td>` `{=html}     <td style="text-align:left;">`
      Kützing, 1843 `{=html}     </td>`
      `{=html}     <td style="text-align:right;">` 257
      `{=html}     </td>` `{=html}     <td style="text-align:left;">`
      FAM `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
      `{=html}     <td style="text-align:left;">` Veliidae
      `{=html}     </td>` `{=html}     <td style="text-align:left;">`
      Amyot & Serville, 1843 `{=html}     </td>`
      `{=html}     <td style="text-align:right;">` 172
      `{=html}     </td>` `{=html}     <td style="text-align:left;">`
      FAM `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
      `{=html}     <td style="text-align:left;">` Vespertilionidae
      `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
      `{=html}     </td>` `{=html}     <td style="text-align:right;">`
      136 `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` FAM
      `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
      `{=html}     <td style="text-align:left;">` Xyridaceae
      `{=html}     </td>` `{=html}     <td style="text-align:left;">`
      C.Agardh `{=html}     </td>`
      `{=html}     <td style="text-align:right;">` 222
      `{=html}     </td>` `{=html}     <td style="text-align:left;">`
      FAM `{=html}     </td>` `{=html}     </tr>` `{=html}     </tbody>`
      `{=html}     </table>`

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

<table>
<caption>

Displaying records 1 - 100

</caption>
<thead>
<tr>
<th style="text-align:left;">

order

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

family

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Lamiales

</td>
<td style="text-align:right;">

180

</td>
<td style="text-align:left;">

Acanthaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:left;">

Accipitriformes

</td>
<td style="text-align:right;">

102

</td>
<td style="text-align:left;">

Accipitridae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

383

</td>
</tr>
<tr>
<td style="text-align:left;">

Malpighiales

</td>
<td style="text-align:right;">

187

</td>
<td style="text-align:left;">

Achariaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

136

</td>
</tr>
<tr>
<td style="text-align:left;">

Achnanthales

</td>
<td style="text-align:right;">

79

</td>
<td style="text-align:left;">

Achnanthidiaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

221

</td>
</tr>
<tr>
<td style="text-align:left;">

Acrochaetiales

</td>
<td style="text-align:right;">

103

</td>
<td style="text-align:left;">

Acrochaetiaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

24

</td>
</tr>
<tr>
<td style="text-align:left;">

Odonata

</td>
<td style="text-align:right;">

90

</td>
<td style="text-align:left;">

Aeshnidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

18

</td>
</tr>
<tr>
<td style="text-align:left;">

Coraciiformes

</td>
<td style="text-align:right;">

144

</td>
<td style="text-align:left;">

Alcedinidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

59

</td>
</tr>
<tr>
<td style="text-align:left;">

Alismatales

</td>
<td style="text-align:right;">

105

</td>
<td style="text-align:left;">

Alismataceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:left;">

Crocodylia

</td>
<td style="text-align:right;">

145

</td>
<td style="text-align:left;">

Alligatoridae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

93

</td>
</tr>
<tr>
<td style="text-align:left;">

Squamata

</td>
<td style="text-align:right;">

97

</td>
<td style="text-align:left;">

Alopoglossidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:left;">

Caryophyllales

</td>
<td style="text-align:right;">

128

</td>
<td style="text-align:left;">

Amaranthaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

6

</td>
</tr>
<tr>
<td style="text-align:left;">

Naviculales

</td>
<td style="text-align:right;">

87

</td>
<td style="text-align:left;">

Amphipleuraceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

257

</td>
</tr>
<tr>
<td style="text-align:left;">

Squamata

</td>
<td style="text-align:right;">

97

</td>
<td style="text-align:left;">

Amphisbaenidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Architaenioglossa

</td>
<td style="text-align:right;">

112

</td>
<td style="text-align:left;">

Ampullariidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

27

</td>
</tr>
<tr>
<td style="text-align:left;">

Sapindales

</td>
<td style="text-align:right;">

235

</td>
<td style="text-align:left;">

Anacardiaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

413

</td>
</tr>
<tr>
<td style="text-align:left;">

Anseriformes

</td>
<td style="text-align:right;">

107

</td>
<td style="text-align:left;">

Anatidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

139

</td>
</tr>
<tr>
<td style="text-align:left;">

Anseriformes

</td>
<td style="text-align:right;">

107

</td>
<td style="text-align:left;">

Anhimidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

30

</td>
</tr>
<tr>
<td style="text-align:left;">

Suliformes

</td>
<td style="text-align:right;">

242

</td>
<td style="text-align:left;">

Anhingidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Magnoliales

</td>
<td style="text-align:right;">

186

</td>
<td style="text-align:left;">

Annonaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

348

</td>
</tr>
<tr>
<td style="text-align:left;">

Squamata

</td>
<td style="text-align:right;">

97

</td>
<td style="text-align:left;">

Anomalepididae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Cymbellales

</td>
<td style="text-align:right;">

150

</td>
<td style="text-align:left;">

Anomoeoneidaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Characiformes

</td>
<td style="text-align:right;">

134

</td>
<td style="text-align:left;">

Anostomidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

20

</td>
</tr>
<tr>
<td style="text-align:left;">

Nostocales

</td>
<td style="text-align:right;">

201

</td>
<td style="text-align:left;">

Aphanizomenonaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:left;">

Gentianales

</td>
<td style="text-align:right;">

166

</td>
<td style="text-align:left;">

Apocynaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

104

</td>
</tr>
<tr>
<td style="text-align:left;">

Apodiformes

</td>
<td style="text-align:right;">

110

</td>
<td style="text-align:left;">

Apodidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

17

</td>
</tr>
<tr>
<td style="text-align:left;">

Gymnotiformes

</td>
<td style="text-align:right;">

171

</td>
<td style="text-align:left;">

Apteronotidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

24

</td>
</tr>
<tr>
<td style="text-align:left;">

Alismatales

</td>
<td style="text-align:right;">

105

</td>
<td style="text-align:left;">

Araceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

107

</td>
</tr>
<tr>
<td style="text-align:left;">

Apiales

</td>
<td style="text-align:right;">

109

</td>
<td style="text-align:left;">

Araliaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

45

</td>
</tr>
<tr>
<td style="text-align:left;">

Gruiformes

</td>
<td style="text-align:right;">

169

</td>
<td style="text-align:left;">

Aramidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

21

</td>
</tr>
<tr>
<td style="text-align:left;">

Arcellinida

</td>
<td style="text-align:right;">

111

</td>
<td style="text-align:left;">

Arcellidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

120

</td>
</tr>
<tr>
<td style="text-align:left;">

Lepidoptera

</td>
<td style="text-align:right;">

85

</td>
<td style="text-align:left;">

Arctiidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Pelecaniformes

</td>
<td style="text-align:right;">

210

</td>
<td style="text-align:left;">

Ardeidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

2153

</td>
</tr>
<tr>
<td style="text-align:left;">

Arecales

</td>
<td style="text-align:right;">

113

</td>
<td style="text-align:left;">

Arecaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

66

</td>
</tr>
<tr>
<td style="text-align:left;">

Anura

</td>
<td style="text-align:right;">

108

</td>
<td style="text-align:left;">

Aromobatidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:left;">

Arthoniales

</td>
<td style="text-align:right;">

114

</td>
<td style="text-align:left;">

Arthoniaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

388

</td>
</tr>
<tr>
<td style="text-align:left;">

Ploima

</td>
<td style="text-align:right;">

221

</td>
<td style="text-align:left;">

Asplanchnidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

14

</td>
</tr>
<tr>
<td style="text-align:left;">

Polypodiales

</td>
<td style="text-align:right;">

224

</td>
<td style="text-align:left;">

Aspleniaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

14

</td>
</tr>
<tr>
<td style="text-align:left;">

Siluriformes

</td>
<td style="text-align:right;">

238

</td>
<td style="text-align:left;">

Aspredinidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

34

</td>
</tr>
<tr>
<td style="text-align:left;">

Siluriformes

</td>
<td style="text-align:right;">

238

</td>
<td style="text-align:left;">

Auchenipteridae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

25

</td>
</tr>
<tr>
<td style="text-align:left;">

Aulacoseirales

</td>
<td style="text-align:right;">

117

</td>
<td style="text-align:left;">

Aulacoseiraceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

50

</td>
</tr>
<tr>
<td style="text-align:left;">

Bacillariales

</td>
<td style="text-align:right;">

118

</td>
<td style="text-align:left;">

Bacillariaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

259

</td>
</tr>
<tr>
<td style="text-align:left;">

Ephemeroptera

</td>
<td style="text-align:right;">

156

</td>
<td style="text-align:left;">

Baetidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

115

</td>
</tr>
<tr>
<td style="text-align:left;">

Balliales

</td>
<td style="text-align:right;">

119

</td>
<td style="text-align:left;">

Balliaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

6

</td>
</tr>
<tr>
<td style="text-align:left;">

Hemiptera

</td>
<td style="text-align:right;">

172

</td>
<td style="text-align:left;">

Belostomatidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

41

</td>
</tr>
<tr>
<td style="text-align:left;">

Lamiales

</td>
<td style="text-align:right;">

180

</td>
<td style="text-align:left;">

Bignoniaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

88

</td>
</tr>
<tr>
<td style="text-align:left;">

Malvales

</td>
<td style="text-align:right;">

188

</td>
<td style="text-align:left;">

Bixaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

23

</td>
</tr>
<tr>
<td style="text-align:left;">

Polypodiales

</td>
<td style="text-align:right;">

224

</td>
<td style="text-align:left;">

Blechnaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Squamata

</td>
<td style="text-align:right;">

97

</td>
<td style="text-align:left;">

Boidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

13

</td>
</tr>
<tr>
<td style="text-align:left;">

Malvales

</td>
<td style="text-align:right;">

188

</td>
<td style="text-align:left;">

Bombacaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Oscillatoriales

</td>
<td style="text-align:right;">

92

</td>
<td style="text-align:left;">

Borziaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Diplostraca

</td>
<td style="text-align:right;">

155

</td>
<td style="text-align:left;">

Bosminidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

22

</td>
</tr>
<tr>
<td style="text-align:left;">

Trebouxiales

</td>
<td style="text-align:right;">

251

</td>
<td style="text-align:left;">

Botryococcaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

22

</td>
</tr>
<tr>
<td style="text-align:left;">

Symphypleona

</td>
<td style="text-align:right;">

98

</td>
<td style="text-align:left;">

Bourletiellidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

122

</td>
</tr>
<tr>
<td style="text-align:left;">

Cetartiodactyla

</td>
<td style="text-align:right;">

132

</td>
<td style="text-align:left;">

Bovidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

18462

</td>
</tr>
<tr>
<td style="text-align:left;">

Ploima

</td>
<td style="text-align:right;">

221

</td>
<td style="text-align:left;">

Brachionidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

83

</td>
</tr>
<tr>
<td style="text-align:left;">

Naviculales

</td>
<td style="text-align:right;">

87

</td>
<td style="text-align:left;">

Brachysiraceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Poduromorpha

</td>
<td style="text-align:right;">

93

</td>
<td style="text-align:left;">

Brachystomellidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

173

</td>
</tr>
<tr>
<td style="text-align:left;">

Brassicales

</td>
<td style="text-align:right;">

123

</td>
<td style="text-align:left;">

Brassicaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Characiformes

</td>
<td style="text-align:right;">

134

</td>
<td style="text-align:left;">

Bryconidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Galbuliformes

</td>
<td style="text-align:right;">

164

</td>
<td style="text-align:left;">

Bucconidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

33

</td>
</tr>
<tr>
<td style="text-align:left;">

Anura

</td>
<td style="text-align:right;">

108

</td>
<td style="text-align:left;">

Bufonidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

76

</td>
</tr>
<tr>
<td style="text-align:left;">

Sapindales

</td>
<td style="text-align:right;">

235

</td>
<td style="text-align:left;">

Burseraceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

88

</td>
</tr>
<tr>
<td style="text-align:left;">

Lecanorales

</td>
<td style="text-align:right;">

182

</td>
<td style="text-align:left;">

Byssolomataceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:left;">

Nymphaeales

</td>
<td style="text-align:right;">

203

</td>
<td style="text-align:left;">

Cabombaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Ephemeroptera

</td>
<td style="text-align:right;">

156

</td>
<td style="text-align:left;">

Caenidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

28

</td>
</tr>
<tr>
<td style="text-align:left;">

Trichoptera

</td>
<td style="text-align:right;">

253

</td>
<td style="text-align:left;">

Calamoceratidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

7

</td>
</tr>
<tr>
<td style="text-align:left;">

Siluriformes

</td>
<td style="text-align:right;">

238

</td>
<td style="text-align:left;">

Callichthyidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

27

</td>
</tr>
<tr>
<td style="text-align:left;">

Malpighiales

</td>
<td style="text-align:right;">

187

</td>
<td style="text-align:left;">

Calophyllaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

6

</td>
</tr>
<tr>
<td style="text-align:left;">

Odonata

</td>
<td style="text-align:right;">

90

</td>
<td style="text-align:left;">

Calopterygidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

16

</td>
</tr>
<tr>
<td style="text-align:left;">

Pottiales

</td>
<td style="text-align:right;">

226

</td>
<td style="text-align:left;">

Calymperaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

22

</td>
</tr>
<tr>
<td style="text-align:left;">

Carnivora

</td>
<td style="text-align:right;">

127

</td>
<td style="text-align:left;">

Canidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

566

</td>
</tr>
<tr>
<td style="text-align:left;">

Rosales

</td>
<td style="text-align:right;">

232

</td>
<td style="text-align:left;">

Cannabaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Brassicales

</td>
<td style="text-align:right;">

123

</td>
<td style="text-align:left;">

Capparaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Caprimulgiformes

</td>
<td style="text-align:right;">

126

</td>
<td style="text-align:left;">

Caprimulgidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

721

</td>
</tr>
<tr>
<td style="text-align:left;">

Passeriformes

</td>
<td style="text-align:right;">

209

</td>
<td style="text-align:left;">

Cardinalidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

15

</td>
</tr>
<tr>
<td style="text-align:left;">

Brassicales

</td>
<td style="text-align:right;">

123

</td>
<td style="text-align:left;">

Caricaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Malpighiales

</td>
<td style="text-align:right;">

187

</td>
<td style="text-align:left;">

Caryocaraceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

13

</td>
</tr>
<tr>
<td style="text-align:left;">

Cathartiformes

</td>
<td style="text-align:right;">

129

</td>
<td style="text-align:left;">

Cathartidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

257

</td>
</tr>
<tr>
<td style="text-align:left;">

Rodentia

</td>
<td style="text-align:right;">

94

</td>
<td style="text-align:left;">

Caviidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

869

</td>
</tr>
<tr>
<td style="text-align:left;">

Primates

</td>
<td style="text-align:right;">

227

</td>
<td style="text-align:left;">

Cebidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

641

</td>
</tr>
<tr>
<td style="text-align:left;">

Celastrales

</td>
<td style="text-align:right;">

131

</td>
<td style="text-align:left;">

Celastraceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:left;">

Anura

</td>
<td style="text-align:right;">

108

</td>
<td style="text-align:left;">

Centrolenidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Gonyaulacales

</td>
<td style="text-align:right;">

168

</td>
<td style="text-align:left;">

Ceratiaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Diptera

</td>
<td style="text-align:right;">

83

</td>
<td style="text-align:left;">

Ceratopogonidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

195

</td>
</tr>
<tr>
<td style="text-align:left;">

Cetartiodactyla

</td>
<td style="text-align:right;">

132

</td>
<td style="text-align:left;">

Cervidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

389

</td>
</tr>
<tr>
<td style="text-align:left;">

Siluriformes

</td>
<td style="text-align:right;">

238

</td>
<td style="text-align:left;">

Cetopsidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Chaetophorales

</td>
<td style="text-align:right;">

133

</td>
<td style="text-align:left;">

Chaetophoraceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

21

</td>
</tr>
<tr>
<td style="text-align:left;">

Diptera

</td>
<td style="text-align:right;">

83

</td>
<td style="text-align:left;">

Chaoboridae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

10

</td>
</tr>
<tr>
<td style="text-align:left;">

Sphaeropleales

</td>
<td style="text-align:right;">

96

</td>
<td style="text-align:left;">

Characiaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

8

</td>
</tr>
<tr>
<td style="text-align:left;">

Characiformes

</td>
<td style="text-align:right;">

134

</td>
<td style="text-align:left;">

Characidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

542

</td>
</tr>
<tr>
<td style="text-align:left;">

Charadriiformes

</td>
<td style="text-align:right;">

135

</td>
<td style="text-align:left;">

Charadriidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

42

</td>
</tr>
<tr>
<td style="text-align:left;">

Diptera

</td>
<td style="text-align:right;">

83

</td>
<td style="text-align:left;">

Chironomidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

572

</td>
</tr>
<tr>
<td style="text-align:left;">

Chlamydomonadales

</td>
<td style="text-align:right;">

80

</td>
<td style="text-align:left;">

Chlamydomonadaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

14

</td>
</tr>
<tr>
<td style="text-align:left;">

Cingulata

</td>
<td style="text-align:right;">

140

</td>
<td style="text-align:left;">

Chlamyphoridae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

25

</td>
</tr>
<tr>
<td style="text-align:left;">

Chlorellales

</td>
<td style="text-align:right;">

137

</td>
<td style="text-align:left;">

Chlorellaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:left;">

Chroococcales

</td>
<td style="text-align:right;">

81

</td>
<td style="text-align:left;">

Chroococcaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Malpighiales

</td>
<td style="text-align:right;">

187

</td>
<td style="text-align:left;">

Chrysobalanaceae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

13

</td>
</tr>
<tr>
<td style="text-align:left;">

Coleoptera

</td>
<td style="text-align:right;">

82

</td>
<td style="text-align:left;">

Chrysomelidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Diplostraca

</td>
<td style="text-align:right;">

155

</td>
<td style="text-align:left;">

Chydoridae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Blenniiformes

</td>
<td style="text-align:right;">

121

</td>
<td style="text-align:left;">

Cichlidae

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

234

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

8 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

scientific_name_authorship

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
<th style="text-align:right;">

order_cases_in_name

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Acentropinae

</td>
<td style="text-align:left;">

Stephens, 1836

</td>
<td style="text-align:right;">

279

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Chironominae

</td>
<td style="text-align:left;">

Rondani, 1840

</td>
<td style="text-align:right;">

274

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

253

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Heptapterinae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

520

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Orthocladiinae

</td>
<td style="text-align:left;">

Lenz, 1921

</td>
<td style="text-align:right;">

274

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

118

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Ponerinae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

500

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Stratiomyinae

</td>
<td style="text-align:left;">

Latrielle, 1802

</td>
<td style="text-align:right;">

336

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

12

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Tachyporinae

</td>
<td style="text-align:left;">

MacLeay, 1825

</td>
<td style="text-align:right;">

335

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Tanypodinae

</td>
<td style="text-align:left;">

Rondani, 1840

</td>
<td style="text-align:right;">

274

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

199

</td>
<td style="text-align:right;">

1

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

0 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

scientific_name_authorship

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
<th style="text-align:right;">

order_cases_in_name

</th>
</tr>
</thead>
<tbody>
<tr>
</tr>
</tbody>
</table>

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

<table>
<caption>

8 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

scientific_name_authorship

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

cd_rank

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Acentropinae

</td>
<td style="text-align:left;">

Stephens, 1836

</td>
<td style="text-align:right;">

279

</td>
<td style="text-align:left;">

SFAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Chironominae

</td>
<td style="text-align:left;">

Rondani, 1840

</td>
<td style="text-align:right;">

274

</td>
<td style="text-align:left;">

SFAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Heptapterinae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

520

</td>
<td style="text-align:left;">

SFAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Orthocladiinae

</td>
<td style="text-align:left;">

Lenz, 1921

</td>
<td style="text-align:right;">

274

</td>
<td style="text-align:left;">

SFAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Ponerinae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

500

</td>
<td style="text-align:left;">

SFAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Stratiomyinae

</td>
<td style="text-align:left;">

Latrielle, 1802

</td>
<td style="text-align:right;">

336

</td>
<td style="text-align:left;">

SFAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Tachyporinae

</td>
<td style="text-align:left;">

MacLeay, 1825

</td>
<td style="text-align:right;">

335

</td>
<td style="text-align:left;">

SFAM

</td>
</tr>
<tr>
<td style="text-align:left;">

Tanypodinae

</td>
<td style="text-align:left;">

Rondani, 1840

</td>
<td style="text-align:right;">

274

</td>
<td style="text-align:left;">

SFAM

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

24 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

family

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

subfamily

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Nymphalidae

</td>
<td style="text-align:right;">

604

</td>
<td style="text-align:left;">

Biblidinae

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

317

</td>
</tr>
<tr>
<td style="text-align:left;">

Nymphalidae

</td>
<td style="text-align:right;">

604

</td>
<td style="text-align:left;">

Charaxinae

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

167

</td>
</tr>
<tr>
<td style="text-align:left;">

Pieridae

</td>
<td style="text-align:right;">

642

</td>
<td style="text-align:left;">

Coliadinae

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

53

</td>
</tr>
<tr>
<td style="text-align:left;">

Nymphalidae

</td>
<td style="text-align:right;">

604

</td>
<td style="text-align:left;">

Cyrestinae

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:left;">

Nymphalidae

</td>
<td style="text-align:right;">

604

</td>
<td style="text-align:left;">

Danainae

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

29

</td>
</tr>
<tr>
<td style="text-align:left;">

Scarabaeidae

</td>
<td style="text-align:right;">

690

</td>
<td style="text-align:left;">

Dynastinae

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:left;">

Hesperiidae

</td>
<td style="text-align:right;">

521

</td>
<td style="text-align:left;">

Eudaminae

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

234

</td>
</tr>
<tr>
<td style="text-align:left;">

Riodinidae

</td>
<td style="text-align:right;">

681

</td>
<td style="text-align:left;">

Euselasiinae

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

8

</td>
</tr>
<tr>
<td style="text-align:left;">

Nymphalidae

</td>
<td style="text-align:right;">

604

</td>
<td style="text-align:left;">

Heliconiinae

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

302

</td>
</tr>
<tr>
<td style="text-align:left;">

Hesperiidae

</td>
<td style="text-align:right;">

521

</td>
<td style="text-align:left;">

Hesperiinae

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

180

</td>
</tr>
<tr>
<td style="text-align:left;">

Nymphalidae

</td>
<td style="text-align:right;">

604

</td>
<td style="text-align:left;">

Limenitidinae

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

117

</td>
</tr>
<tr>
<td style="text-align:left;">

Scarabaeidae

</td>
<td style="text-align:right;">

690

</td>
<td style="text-align:left;">

Melolonthinae

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

27

</td>
</tr>
<tr>
<td style="text-align:left;">

Nymphalidae

</td>
<td style="text-align:right;">

604

</td>
<td style="text-align:left;">

Nymphalinae

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

365

</td>
</tr>
<tr>
<td style="text-align:left;">

Scarabaeidae

</td>
<td style="text-align:right;">

690

</td>
<td style="text-align:left;">

Orphinae

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

7

</td>
</tr>
<tr>
<td style="text-align:left;">

Papilionidae

</td>
<td style="text-align:right;">

621

</td>
<td style="text-align:left;">

Papilioninae

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

15

</td>
</tr>
<tr>
<td style="text-align:left;">

Pieridae

</td>
<td style="text-align:right;">

642

</td>
<td style="text-align:left;">

Pierinae

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:left;">

Lycaenidae

</td>
<td style="text-align:right;">

559

</td>
<td style="text-align:left;">

Polyommatinae

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:left;">

Hesperiidae

</td>
<td style="text-align:right;">

521

</td>
<td style="text-align:left;">

Pyrginae

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

71

</td>
</tr>
<tr>
<td style="text-align:left;">

Hesperiidae

</td>
<td style="text-align:right;">

521

</td>
<td style="text-align:left;">

Pyrrhopyginae

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

Riodinidae

</td>
<td style="text-align:right;">

681

</td>
<td style="text-align:left;">

Riodininae

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

126

</td>
</tr>
<tr>
<td style="text-align:left;">

Scarabaeidae

</td>
<td style="text-align:right;">

690

</td>
<td style="text-align:left;">

Rutelinae

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Nymphalidae

</td>
<td style="text-align:right;">

604

</td>
<td style="text-align:left;">

Satyrinae

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

1703

</td>
</tr>
<tr>
<td style="text-align:left;">

Scarabaeidae

</td>
<td style="text-align:right;">

690

</td>
<td style="text-align:left;">

Scarabaeinae

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

3867

</td>
</tr>
<tr>
<td style="text-align:left;">

Lycaenidae

</td>
<td style="text-align:right;">

559

</td>
<td style="text-align:left;">

Theclinae

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

63

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

1 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

scientific_name_authorship

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
<th style="text-align:right;">

order_cases_in_name

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Bidessini

</td>
<td style="text-align:left;">

Sharp, 1882

</td>
<td style="text-align:right;">

286

</td>
<td style="text-align:left;">

TR

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

0 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

scientific_name_authorship

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
<th style="text-align:right;">

order_cases_in_name

</th>
</tr>
</thead>
<tbody>
<tr>
</tr>
</tbody>
</table>

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

<table>
<caption>

1 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

scientific_name_authorship

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

cd_rank

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Bidessini

</td>
<td style="text-align:left;">

Sharp, 1882

</td>
<td style="text-align:right;">

286

</td>
<td style="text-align:left;">

TR

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

Displaying records 1 - 100

</caption>
<thead>
<tr>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

scientific_name_authorship

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
<th style="text-align:right;">

order_cases_in_name

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Acanthagrion

</td>
<td style="text-align:left;">

Selys, 1876

</td>
<td style="text-align:right;">

277

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

17

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Acantheremus

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

338

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Achnanthidium

</td>
<td style="text-align:left;">

Kützing, 1844

</td>
<td style="text-align:right;">

266

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

16

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Actinella

</td>
<td style="text-align:left;">

Lewis, 1864

</td>
<td style="text-align:right;">

497

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

24

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Actinotaenium

</td>
<td style="text-align:left;">

Teiling, 1954

</td>
<td style="text-align:right;">

282

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

8

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Acutodesmus

</td>
<td style="text-align:left;">

(Hegewald) Tsarenko, 2001

</td>
<td style="text-align:right;">

691

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Adiantum

</td>
<td style="text-align:left;">

Linneo. 1753

</td>
<td style="text-align:right;">

671

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Adisianus

</td>
<td style="text-align:left;">

Bretfeld, 2003

</td>
<td style="text-align:right;">

272

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Aedeomyia

</td>
<td style="text-align:left;">

Theobald, 1901

</td>
<td style="text-align:right;">

459

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

7

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Agriogomphus

</td>
<td style="text-align:left;">

Selys, 1869

</td>
<td style="text-align:right;">

295

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

16

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Aiouea

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

305

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Alchornea

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

289

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Allophyllus

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

688

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Allophylus

</td>
<td style="text-align:left;">

Linneo. 1753

</td>
<td style="text-align:right;">

688

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Alluaudomyia

</td>
<td style="text-align:left;">

Kieffer, 1913

</td>
<td style="text-align:right;">

420

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

71

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Alona

</td>
<td style="text-align:left;">

Baird, 1850

</td>
<td style="text-align:right;">

432

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Amazona

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

670

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Ambrysus

</td>
<td style="text-align:left;">

Stål, 1861

</td>
<td style="text-align:right;">

591

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

43

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Americabaetis

</td>
<td style="text-align:left;">

Kluge, 1992

</td>
<td style="text-align:right;">

270

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Anabaena

</td>
<td style="text-align:left;">

Bornet & Flahault, 1886

</td>
<td style="text-align:right;">

599

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

59

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Anacaena

</td>
<td style="text-align:left;">

Thomson, 1859

</td>
<td style="text-align:right;">

531

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

7

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Anacroneuria

</td>
<td style="text-align:left;">

Klapálek, 1909

</td>
<td style="text-align:right;">

630

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

15

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Anacroneuria

</td>
<td style="text-align:left;">

Klapálek, 1910

</td>
<td style="text-align:right;">

630

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Anacroneuria

</td>
<td style="text-align:left;">

Klapálek, 1911

</td>
<td style="text-align:right;">

630

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:left;">

Andaeschna

</td>
<td style="text-align:left;">

De Marmels, 1994

</td>
<td style="text-align:right;">

349

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Aneumastus

</td>
<td style="text-align:left;">

D.G. Mann & A.J. Stickle in F.E. Round, R.M. Crawford & D.G. Mann, 1990

</td>
<td style="text-align:right;">

565

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Anisagrion

</td>
<td style="text-align:left;">

Selys 1876

</td>
<td style="text-align:right;">

277

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Anisomeridium

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

583

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

8

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Ankistrodesmus

</td>
<td style="text-align:left;">

Corda, 1838

</td>
<td style="text-align:right;">

699

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

21

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Annona

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

267

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Anodocheilus

</td>
<td style="text-align:left;">

Babington, 1838

</td>
<td style="text-align:right;">

286

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Anomoeoneis

</td>
<td style="text-align:left;">

E. Pfitzer, 1871

</td>
<td style="text-align:right;">

363

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Anopheles

</td>
<td style="text-align:left;">

Meigen, 1818

</td>
<td style="text-align:right;">

459

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

13

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Anthurium

</td>
<td style="text-align:left;">

Schott, 1829

</td>
<td style="text-align:right;">

369

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

7

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Anthurium

</td>
<td style="text-align:left;">

Schott. 1829

</td>
<td style="text-align:right;">

369

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

6

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Aphanocapsa

</td>
<td style="text-align:left;">

C.Nägeli, 1849

</td>
<td style="text-align:right;">

570

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Aphylla

</td>
<td style="text-align:left;">

Selys, 1854

</td>
<td style="text-align:right;">

295

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Apobaetis

</td>
<td style="text-align:left;">

Day, 1955

</td>
<td style="text-align:right;">

270

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

33

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Arcella

</td>
<td style="text-align:left;">

Ehrenberg, 1832

</td>
<td style="text-align:right;">

372

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

119

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Argia

</td>
<td style="text-align:left;">

Rambur, 1842

</td>
<td style="text-align:right;">

277

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

33

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Arlesia

</td>
<td style="text-align:left;">

Handschin, 1942

</td>
<td style="text-align:right;">

318

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

72

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Arthothelium

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

375

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Arthrodesmus

</td>
<td style="text-align:left;">

Ehrenberg ex Ralfs, 1848

</td>
<td style="text-align:right;">

282

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Artibeus

</td>
<td style="text-align:left;">

Leach, 1821

</td>
<td style="text-align:right;">

323

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

24

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Asplanchna

</td>
<td style="text-align:left;">

Gosse, 1850

</td>
<td style="text-align:right;">

376

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

14

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Asplenium

</td>
<td style="text-align:left;">

Linneo,

</td>
<td style="text-align:right;">

377

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

14

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Astaena

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

773

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Astrothelium

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

740

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Astyanax

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

426

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

72

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Atractus

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

278

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Atrichopogon

</td>
<td style="text-align:left;">

Meigen, 1830

</td>
<td style="text-align:right;">

420

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

15

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Atrichopogon

</td>
<td style="text-align:left;">

Kieffer, 1906

</td>
<td style="text-align:right;">

420

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Aturbina

</td>
<td style="text-align:left;">

Lugo-Ortiz & McCafferty, 1996

</td>
<td style="text-align:right;">

270

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Audouinella

</td>
<td style="text-align:left;">

Bory, 1823

</td>
<td style="text-align:right;">

348

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

24

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Aulacoseira

</td>
<td style="text-align:left;">

Thwaites, 1848

</td>
<td style="text-align:right;">

380

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

50

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Austrolimnius

</td>
<td style="text-align:left;">

Carter and Zeck, 1929

</td>
<td style="text-align:right;">

487

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

19

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Azteca

</td>
<td style="text-align:left;">

Forel, 1878

</td>
<td style="text-align:right;">

500

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

61

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Bacidia

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

329

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

33

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Bactrospora

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

684

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Ballia

</td>
<td style="text-align:left;">

Harvey, 1840

</td>
<td style="text-align:right;">

382

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

6

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Bambusina

</td>
<td style="text-align:left;">

Kützing ex Kützing, 1849

</td>
<td style="text-align:right;">

282

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

15

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Barybas

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

773

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Beauchampiella

</td>
<td style="text-align:left;">

Remane, 1929

</td>
<td style="text-align:right;">

495

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Belostoma

</td>
<td style="text-align:left;">

Latreille, 1807

</td>
<td style="text-align:right;">

383

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

41

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Berosus

</td>
<td style="text-align:left;">

Leach, 1817

</td>
<td style="text-align:right;">

531

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

26

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Bidessonotus

</td>
<td style="text-align:left;">

Régimbart, 1895

</td>
<td style="text-align:right;">

286

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Biomphalaria

</td>
<td style="text-align:left;">

Preston, 1910

</td>
<td style="text-align:right;">

650

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

51

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Bogoriella

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

740

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

16

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Bosmina

</td>
<td style="text-align:left;">

Baird, 1845

</td>
<td style="text-align:right;">

389

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

22

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Botryococcus

</td>
<td style="text-align:left;">

Kützing, 1849

</td>
<td style="text-align:right;">

390

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

22

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Bourletiella

</td>
<td style="text-align:left;">

Banks, 1899

</td>
<td style="text-align:right;">

272

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

74

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Brachionus

</td>
<td style="text-align:left;">

Pallas, 1766

</td>
<td style="text-align:right;">

392

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

35

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Brachymesia

</td>
<td style="text-align:left;">

Kirby, 1889

</td>
<td style="text-align:right;">

307

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

9

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Brachymetra

</td>
<td style="text-align:left;">

Mayr, 1865

</td>
<td style="text-align:right;">

293

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

25

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Brachymyrmex

</td>
<td style="text-align:left;">

Mayr, 1868

</td>
<td style="text-align:right;">

500

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

11

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Brachysira

</td>
<td style="text-align:left;">

Kützing, 1836

</td>
<td style="text-align:right;">

393

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Brachystomella

</td>
<td style="text-align:left;">

Ågren, 1903

</td>
<td style="text-align:right;">

394

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

171

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Brachystomellides

</td>
<td style="text-align:left;">

Arlé, 1960

</td>
<td style="text-align:right;">

394

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Brechmorhoga

</td>
<td style="text-align:left;">

Kirby, 1894

</td>
<td style="text-align:right;">

307

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Bredinia

</td>
<td style="text-align:left;">

Flint, 1968

</td>
<td style="text-align:right;">

301

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Brosimum

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

315

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

8

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Buenoa

</td>
<td style="text-align:left;">

Kirkaldy, 1904

</td>
<td style="text-align:right;">

601

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

49

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Bulbochaete

</td>
<td style="text-align:left;">

C.Agardh, 1817

</td>
<td style="text-align:right;">

610

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Bunchosia

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

563

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Cabecar

</td>
<td style="text-align:left;">

Baumgardner in Baumgardner and Ávila, 2006

</td>
<td style="text-align:right;">

555

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Caenis

</td>
<td style="text-align:left;">

Stephens, 1835

</td>
<td style="text-align:right;">

402

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

28

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Calathea

</td>
<td style="text-align:left;">

G.Mey.

</td>
<td style="text-align:right;">

312

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Callibaetis

</td>
<td style="text-align:left;">

Eaton, 1881

</td>
<td style="text-align:right;">

270

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

39

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Caloneis

</td>
<td style="text-align:left;">

P.T. Cleve, 1894

</td>
<td style="text-align:right;">

592

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Calx

</td>
<td style="text-align:left;">

Christiansen, 1958

</td>
<td style="text-align:right;">

288

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Calyptrocarya

</td>
<td style="text-align:left;">

Nees,

</td>
<td style="text-align:right;">

281

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Camelobaetidius

</td>
<td style="text-align:left;">

Demoulin, 1966

</td>
<td style="text-align:right;">

270

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Camponotus

</td>
<td style="text-align:left;">

Mayr, 1861

</td>
<td style="text-align:right;">

500

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

100

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Campsurus

</td>
<td style="text-align:left;">

Eaton, 1868

</td>
<td style="text-align:right;">

659

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Campsurus

</td>
<td style="text-align:left;">

\#N/D

</td>
<td style="text-align:right;">

659

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Campylothorax

</td>
<td style="text-align:left;">

Schött, 1893

</td>
<td style="text-align:right;">

624

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

221

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Canthidium

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

784

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

169

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Canthon

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

784

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

235

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Capartogramma

</td>
<td style="text-align:left;">

H. Kufferath, 1956

</td>
<td style="text-align:right;">

592

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

17

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Cardamine

</td>
<td style="text-align:left;">

Linneo,

</td>
<td style="text-align:right;">

395

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

99 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

scientific_name_authorship

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
<th style="text-align:right;">

order_cases_in_name

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Anacroneuria

</td>
<td style="text-align:left;">

Klapálek, 1909

</td>
<td style="text-align:right;">

630

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

15

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Anacroneuria

</td>
<td style="text-align:left;">

Klapálek, 1910

</td>
<td style="text-align:right;">

630

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Anacroneuria

</td>
<td style="text-align:left;">

Klapálek, 1911

</td>
<td style="text-align:right;">

630

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:left;">

Anthurium

</td>
<td style="text-align:left;">

Schott, 1829

</td>
<td style="text-align:right;">

369

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

7

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Anthurium

</td>
<td style="text-align:left;">

Schott. 1829

</td>
<td style="text-align:right;">

369

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

6

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Atrichopogon

</td>
<td style="text-align:left;">

Meigen, 1830

</td>
<td style="text-align:right;">

420

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

15

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Atrichopogon

</td>
<td style="text-align:left;">

Kieffer, 1906

</td>
<td style="text-align:right;">

420

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Campsurus

</td>
<td style="text-align:left;">

Eaton, 1868

</td>
<td style="text-align:right;">

659

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Campsurus

</td>
<td style="text-align:left;">

\#N/D

</td>
<td style="text-align:right;">

659

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Casearia

</td>
<td style="text-align:left;">

Jacq. 1760

</td>
<td style="text-align:right;">

686

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Casearia

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

686

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Ceratopteris

</td>
<td style="text-align:left;">

Brongn, 1822

</td>
<td style="text-align:right;">

671

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Ceratopteris

</td>
<td style="text-align:left;">

Brongn. 1822

</td>
<td style="text-align:right;">

671

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Cernotina

</td>
<td style="text-align:left;">

Ross, 1938

</td>
<td style="text-align:right;">

325

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

17

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Cernotina

</td>
<td style="text-align:left;">

Curtis, 1835

</td>
<td style="text-align:right;">

325

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Culex

</td>
<td style="text-align:left;">

Linnaeus, 1758

</td>
<td style="text-align:right;">

459

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

47

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Culex

</td>
<td style="text-align:left;">

Linnaeus, 1763

</td>
<td style="text-align:right;">

459

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

19

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Culex

</td>
<td style="text-align:left;">

Linnaeus, 1761

</td>
<td style="text-align:right;">

459

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:left;">

Culex

</td>
<td style="text-align:left;">

Linnaeus, 1762

</td>
<td style="text-align:right;">

459

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:left;">

Culex

</td>
<td style="text-align:left;">

Linnaeus, 1764

</td>
<td style="text-align:right;">

459

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:left;">

Culex

</td>
<td style="text-align:left;">

Linnaeus, 1765

</td>
<td style="text-align:right;">

459

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

6

</td>
</tr>
<tr>
<td style="text-align:left;">

Culex

</td>
<td style="text-align:left;">

Linnaeus, 1766

</td>
<td style="text-align:right;">

459

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

7

</td>
</tr>
<tr>
<td style="text-align:left;">

Culex

</td>
<td style="text-align:left;">

Linnaeus, 1768

</td>
<td style="text-align:right;">

459

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

8

</td>
</tr>
<tr>
<td style="text-align:left;">

Culex

</td>
<td style="text-align:left;">

Linnaeus, 1767

</td>
<td style="text-align:right;">

459

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

Culex

</td>
<td style="text-align:left;">

Linnaeus, 1759

</td>
<td style="text-align:right;">

459

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

10

</td>
</tr>
<tr>
<td style="text-align:left;">

Culex

</td>
<td style="text-align:left;">

Linnaeus, 1760

</td>
<td style="text-align:right;">

459

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

11

</td>
</tr>
<tr>
<td style="text-align:left;">

Curicta

</td>
<td style="text-align:left;">

Stål, 1861

</td>
<td style="text-align:right;">

596

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Curicta

</td>
<td style="text-align:left;">

\#N/D

</td>
<td style="text-align:right;">

596

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Cynomops

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

314

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

13

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Cynomops

</td>
<td style="text-align:left;">

Thomas, 1920

</td>
<td style="text-align:right;">

314

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

9

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Dasythemis

</td>
<td style="text-align:left;">

Karsch , 1889

</td>
<td style="text-align:right;">

307

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Dasythemis

</td>
<td style="text-align:left;">

Karsch, 1889

</td>
<td style="text-align:right;">

307

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Elakatothrix

</td>
<td style="text-align:left;">

Wille, 1899

</td>
<td style="text-align:right;">

484

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Elakatothrix

</td>
<td style="text-align:left;">

Wille, 1898

</td>
<td style="text-align:right;">

484

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Eleocharis

</td>
<td style="text-align:left;">

R, Br, 1810

</td>
<td style="text-align:right;">

281

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Eleocharis

</td>
<td style="text-align:left;">

R. Br. 1810

</td>
<td style="text-align:right;">

281

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Encyonema

</td>
<td style="text-align:left;">

Kützing, 1834

</td>
<td style="text-align:right;">

465

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

40

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Encyonema

</td>
<td style="text-align:left;">

Kützing 1844

</td>
<td style="text-align:right;">

465

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Gymnodinium

</td>
<td style="text-align:left;">

F.Stein, 1878

</td>
<td style="text-align:right;">

513

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Gymnodinium

</td>
<td style="text-align:left;">

F.Stein, 1879

</td>
<td style="text-align:right;">

513

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Gyretes

</td>
<td style="text-align:left;">

Brullé, 1834

</td>
<td style="text-align:right;">

299

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

19

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Gyretes

</td>
<td style="text-align:left;">

Brullé, 1835

</td>
<td style="text-align:right;">

299

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Hantzschia

</td>
<td style="text-align:left;">

Grunow, 1877

</td>
<td style="text-align:right;">

381

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Hantzschia

</td>
<td style="text-align:left;">

Grunow, 1877, nom. et typ. cons.

</td>
<td style="text-align:right;">

381

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Hemerodromia

</td>
<td style="text-align:left;">

Say, 1823

</td>
<td style="text-align:right;">

287

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Hemerodromia

</td>
<td style="text-align:left;">

Meigen, 1822

</td>
<td style="text-align:right;">

287

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Limnophora

</td>
<td style="text-align:left;">

Robineau-desvoidy, 1830

</td>
<td style="text-align:right;">

316

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Limnophora

</td>
<td style="text-align:left;">

Robineau-desvoidy, 1831

</td>
<td style="text-align:right;">

316

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Limnophora

</td>
<td style="text-align:left;">

Robineau-desvoidy, 1832

</td>
<td style="text-align:right;">

316

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:left;">

Limnophora

</td>
<td style="text-align:left;">

Robineau-desvoidy, 1833

</td>
<td style="text-align:right;">

316

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:left;">

Limnophora

</td>
<td style="text-align:left;">

Robineau-desvoidy, 1834

</td>
<td style="text-align:right;">

316

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:left;">

Liodessus

</td>
<td style="text-align:left;">

Leach, 1815

</td>
<td style="text-align:right;">

286

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

11

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Liodessus

</td>
<td style="text-align:left;">

Guignot, 1939

</td>
<td style="text-align:right;">

286

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

6

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Liodessus

</td>
<td style="text-align:left;">

Sharp, 1880

</td>
<td style="text-align:right;">

286

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:left;">

Marilia

</td>
<td style="text-align:left;">

Mueller, 1880

</td>
<td style="text-align:right;">

608

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

41

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Marilia

</td>
<td style="text-align:left;">

Gray, 1824

</td>
<td style="text-align:right;">

608

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Molossus

</td>
<td style="text-align:left;">

E. Geoffroy,1805

</td>
<td style="text-align:right;">

314

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

19

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Molossus

</td>
<td style="text-align:left;">

E.Geoffroy, 1805

</td>
<td style="text-align:right;">

314

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

13

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Nectopsyche

</td>
<td style="text-align:left;">

Mueller, 1879

</td>
<td style="text-align:right;">

553

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

12

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Nectopsyche

</td>
<td style="text-align:left;">

Mueller, 1880

</td>
<td style="text-align:right;">

553

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Nectopsyche

</td>
<td style="text-align:left;">

Mueller, 1881

</td>
<td style="text-align:right;">

553

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:left;">

Nectopsyche

</td>
<td style="text-align:left;">

Mueller, 1882

</td>
<td style="text-align:right;">

553

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:left;">

Nectopsyche

</td>
<td style="text-align:left;">

Mueller, 1883

</td>
<td style="text-align:right;">

553

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:left;">

Neobidessus

</td>
<td style="text-align:left;">

Young 1967

</td>
<td style="text-align:right;">

286

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Neobidessus

</td>
<td style="text-align:left;">

Young, 1967

</td>
<td style="text-align:right;">

286

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Nymphoides

</td>
<td style="text-align:left;">

Ség. 1754

</td>
<td style="text-align:right;">

569

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Nymphoides

</td>
<td style="text-align:left;">

Ség, 1754

</td>
<td style="text-align:right;">

569

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Oecetis

</td>
<td style="text-align:left;">

McLachlan, 1877

</td>
<td style="text-align:right;">

553

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Oecetis

</td>
<td style="text-align:left;">

McLachlan, 1878

</td>
<td style="text-align:right;">

553

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Paracymus

</td>
<td style="text-align:left;">

Thomson, 1867

</td>
<td style="text-align:right;">

531

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Paracymus

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

531

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Phaenonotum

</td>
<td style="text-align:left;">

Sharp, 1882

</td>
<td style="text-align:right;">

531

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Phaenonotum

</td>
<td style="text-align:left;">

Agudo, 1882

</td>
<td style="text-align:right;">

531

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Philodendron

</td>
<td style="text-align:left;">

Schott, 1829

</td>
<td style="text-align:right;">

369

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

16

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Philodendron

</td>
<td style="text-align:left;">

Schott. 1829

</td>
<td style="text-align:right;">

369

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

9

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Philodendron

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

369

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:left;">

Pisidium

</td>
<td style="text-align:left;">

L. Pfeiffer, 1821

</td>
<td style="text-align:right;">

648

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

49

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Pisidium

</td>
<td style="text-align:left;">

Bourguignat, 1854

</td>
<td style="text-align:right;">

648

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Pontederia

</td>
<td style="text-align:left;">

Linneo, 1753

</td>
<td style="text-align:right;">

660

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Pontederia

</td>
<td style="text-align:left;">

Linneo. 1753

</td>
<td style="text-align:right;">

660

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Probezzia

</td>
<td style="text-align:left;">

Kieffer, 1906

</td>
<td style="text-align:right;">

420

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

97

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Probezzia

</td>
<td style="text-align:left;">

Grassi, 1900

</td>
<td style="text-align:right;">

420

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Psephenus

</td>
<td style="text-align:left;">

Haldeman, 1853

</td>
<td style="text-align:right;">

668

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

17

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Psephenus

</td>
<td style="text-align:left;">

Haldeman, 1854

</td>
<td style="text-align:right;">

668

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Psephenus

</td>
<td style="text-align:left;">

Haldeman, 1855

</td>
<td style="text-align:right;">

668

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:left;">

Rhogeessa

</td>
<td style="text-align:left;">

H. Allen, 1866

</td>
<td style="text-align:right;">

344

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Rhogeessa

</td>
<td style="text-align:left;">

H.Allen 1866

</td>
<td style="text-align:right;">

344

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Simulium

</td>
<td style="text-align:left;">

Latreille, 1802

</td>
<td style="text-align:right;">

702

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

13

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Simulium

</td>
<td style="text-align:left;">

(Scopoli, 1780)

</td>
<td style="text-align:right;">

702

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

7

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Simulium

</td>
<td style="text-align:left;">

Scopoli, 1780

</td>
<td style="text-align:right;">

702

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:left;">

Sturnira

</td>
<td style="text-align:left;">

Gray, 1842

</td>
<td style="text-align:right;">

323

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

168

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Sturnira

</td>
<td style="text-align:left;">

Velazco and Patterson, 2019

</td>
<td style="text-align:right;">

323

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Suphisellus

</td>
<td style="text-align:left;">

Crotch, 1873

</td>
<td style="text-align:right;">

319

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

34

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Suphisellus

</td>
<td style="text-align:left;">

Say, 1823

</td>
<td style="text-align:right;">

319

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Tauriphila

</td>
<td style="text-align:left;">

Kirby, 1889

</td>
<td style="text-align:right;">

307

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

16

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Tauriphila

</td>
<td style="text-align:left;">

W. F. Kirby, 1889

</td>
<td style="text-align:right;">

307

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Uranotaenia

</td>
<td style="text-align:left;">

ynch Arribálzaga, 1891

</td>
<td style="text-align:right;">

459

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Uranotaenia

</td>
<td style="text-align:left;">

Lynch Arribálzaga, 1891

</td>
<td style="text-align:right;">

459

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Uranotaenia

</td>
<td style="text-align:left;">

Theobald, 1901

</td>
<td style="text-align:right;">

459

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

3

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

Displaying records 1 - 100

</caption>
<thead>
<tr>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

scientific_name_authorship

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

cd_rank

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Acanthagrion

</td>
<td style="text-align:left;">

Selys, 1876

</td>
<td style="text-align:right;">

277

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Acantheremus

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

338

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Achnanthidium

</td>
<td style="text-align:left;">

Kützing, 1844

</td>
<td style="text-align:right;">

266

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Actinella

</td>
<td style="text-align:left;">

Lewis, 1864

</td>
<td style="text-align:right;">

497

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Actinotaenium

</td>
<td style="text-align:left;">

Teiling, 1954

</td>
<td style="text-align:right;">

282

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Acutodesmus

</td>
<td style="text-align:left;">

(Hegewald) Tsarenko, 2001

</td>
<td style="text-align:right;">

691

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Adiantum

</td>
<td style="text-align:left;">

Linneo. 1753

</td>
<td style="text-align:right;">

671

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Adisianus

</td>
<td style="text-align:left;">

Bretfeld, 2003

</td>
<td style="text-align:right;">

272

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Aedeomyia

</td>
<td style="text-align:left;">

Theobald, 1901

</td>
<td style="text-align:right;">

459

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Agriogomphus

</td>
<td style="text-align:left;">

Selys, 1869

</td>
<td style="text-align:right;">

295

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Aiouea

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

305

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Alchornea

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

289

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Allophyllus

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

688

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Allophylus

</td>
<td style="text-align:left;">

Linneo. 1753

</td>
<td style="text-align:right;">

688

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Alluaudomyia

</td>
<td style="text-align:left;">

Kieffer, 1913

</td>
<td style="text-align:right;">

420

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Alona

</td>
<td style="text-align:left;">

Baird, 1850

</td>
<td style="text-align:right;">

432

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Amazona

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

670

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Ambrysus

</td>
<td style="text-align:left;">

Stål, 1861

</td>
<td style="text-align:right;">

591

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Americabaetis

</td>
<td style="text-align:left;">

Kluge, 1992

</td>
<td style="text-align:right;">

270

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Anabaena

</td>
<td style="text-align:left;">

Bornet & Flahault, 1886

</td>
<td style="text-align:right;">

599

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Anacaena

</td>
<td style="text-align:left;">

Thomson, 1859

</td>
<td style="text-align:right;">

531

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Anacroneuria

</td>
<td style="text-align:left;">

Klapálek, 1909

</td>
<td style="text-align:right;">

630

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Andaeschna

</td>
<td style="text-align:left;">

De Marmels, 1994

</td>
<td style="text-align:right;">

349

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Aneumastus

</td>
<td style="text-align:left;">

D.G. Mann & A.J. Stickle in F.E. Round, R.M. Crawford & D.G. Mann, 1990

</td>
<td style="text-align:right;">

565

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Anisagrion

</td>
<td style="text-align:left;">

Selys 1876

</td>
<td style="text-align:right;">

277

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Anisomeridium

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

583

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Ankistrodesmus

</td>
<td style="text-align:left;">

Corda, 1838

</td>
<td style="text-align:right;">

699

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Annona

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

267

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Anodocheilus

</td>
<td style="text-align:left;">

Babington, 1838

</td>
<td style="text-align:right;">

286

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Anomoeoneis

</td>
<td style="text-align:left;">

E. Pfitzer, 1871

</td>
<td style="text-align:right;">

363

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Anopheles

</td>
<td style="text-align:left;">

Meigen, 1818

</td>
<td style="text-align:right;">

459

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Anthurium

</td>
<td style="text-align:left;">

Schott, 1829

</td>
<td style="text-align:right;">

369

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Aphanocapsa

</td>
<td style="text-align:left;">

C.Nägeli, 1849

</td>
<td style="text-align:right;">

570

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Aphylla

</td>
<td style="text-align:left;">

Selys, 1854

</td>
<td style="text-align:right;">

295

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Apobaetis

</td>
<td style="text-align:left;">

Day, 1955

</td>
<td style="text-align:right;">

270

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Arcella

</td>
<td style="text-align:left;">

Ehrenberg, 1832

</td>
<td style="text-align:right;">

372

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Argia

</td>
<td style="text-align:left;">

Rambur, 1842

</td>
<td style="text-align:right;">

277

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Arlesia

</td>
<td style="text-align:left;">

Handschin, 1942

</td>
<td style="text-align:right;">

318

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Arthothelium

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

375

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Arthrodesmus

</td>
<td style="text-align:left;">

Ehrenberg ex Ralfs, 1848

</td>
<td style="text-align:right;">

282

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Artibeus

</td>
<td style="text-align:left;">

Leach, 1821

</td>
<td style="text-align:right;">

323

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Asplanchna

</td>
<td style="text-align:left;">

Gosse, 1850

</td>
<td style="text-align:right;">

376

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Asplenium

</td>
<td style="text-align:left;">

Linneo,

</td>
<td style="text-align:right;">

377

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Astaena

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

773

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Astrothelium

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

740

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Astyanax

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

426

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Atractus

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

278

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Atrichopogon

</td>
<td style="text-align:left;">

Meigen, 1830

</td>
<td style="text-align:right;">

420

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Aturbina

</td>
<td style="text-align:left;">

Lugo-Ortiz & McCafferty, 1996

</td>
<td style="text-align:right;">

270

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Audouinella

</td>
<td style="text-align:left;">

Bory, 1823

</td>
<td style="text-align:right;">

348

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Aulacoseira

</td>
<td style="text-align:left;">

Thwaites, 1848

</td>
<td style="text-align:right;">

380

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Austrolimnius

</td>
<td style="text-align:left;">

Carter and Zeck, 1929

</td>
<td style="text-align:right;">

487

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Azteca

</td>
<td style="text-align:left;">

Forel, 1878

</td>
<td style="text-align:right;">

500

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Bacidia

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

329

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Bactrospora

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

684

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Ballia

</td>
<td style="text-align:left;">

Harvey, 1840

</td>
<td style="text-align:right;">

382

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Bambusina

</td>
<td style="text-align:left;">

Kützing ex Kützing, 1849

</td>
<td style="text-align:right;">

282

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Barybas

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

773

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Beauchampiella

</td>
<td style="text-align:left;">

Remane, 1929

</td>
<td style="text-align:right;">

495

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Belostoma

</td>
<td style="text-align:left;">

Latreille, 1807

</td>
<td style="text-align:right;">

383

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Berosus

</td>
<td style="text-align:left;">

Leach, 1817

</td>
<td style="text-align:right;">

531

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Bidessonotus

</td>
<td style="text-align:left;">

Régimbart, 1895

</td>
<td style="text-align:right;">

286

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Biomphalaria

</td>
<td style="text-align:left;">

Preston, 1910

</td>
<td style="text-align:right;">

650

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Bogoriella

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

740

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Bosmina

</td>
<td style="text-align:left;">

Baird, 1845

</td>
<td style="text-align:right;">

389

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Botryococcus

</td>
<td style="text-align:left;">

Kützing, 1849

</td>
<td style="text-align:right;">

390

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Bourletiella

</td>
<td style="text-align:left;">

Banks, 1899

</td>
<td style="text-align:right;">

272

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Brachionus

</td>
<td style="text-align:left;">

Pallas, 1766

</td>
<td style="text-align:right;">

392

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Brachymesia

</td>
<td style="text-align:left;">

Kirby, 1889

</td>
<td style="text-align:right;">

307

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Brachymetra

</td>
<td style="text-align:left;">

Mayr, 1865

</td>
<td style="text-align:right;">

293

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Brachymyrmex

</td>
<td style="text-align:left;">

Mayr, 1868

</td>
<td style="text-align:right;">

500

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Brachysira

</td>
<td style="text-align:left;">

Kützing, 1836

</td>
<td style="text-align:right;">

393

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Brachystomella

</td>
<td style="text-align:left;">

Ågren, 1903

</td>
<td style="text-align:right;">

394

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Brachystomellides

</td>
<td style="text-align:left;">

Arlé, 1960

</td>
<td style="text-align:right;">

394

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Brechmorhoga

</td>
<td style="text-align:left;">

Kirby, 1894

</td>
<td style="text-align:right;">

307

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Bredinia

</td>
<td style="text-align:left;">

Flint, 1968

</td>
<td style="text-align:right;">

301

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Brosimum

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

315

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Buenoa

</td>
<td style="text-align:left;">

Kirkaldy, 1904

</td>
<td style="text-align:right;">

601

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Bulbochaete

</td>
<td style="text-align:left;">

C.Agardh, 1817

</td>
<td style="text-align:right;">

610

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Bunchosia

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

563

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Cabecar

</td>
<td style="text-align:left;">

Baumgardner in Baumgardner and Ávila, 2006

</td>
<td style="text-align:right;">

555

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Caenis

</td>
<td style="text-align:left;">

Stephens, 1835

</td>
<td style="text-align:right;">

402

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Calathea

</td>
<td style="text-align:left;">

G.Mey.

</td>
<td style="text-align:right;">

312

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Callibaetis

</td>
<td style="text-align:left;">

Eaton, 1881

</td>
<td style="text-align:right;">

270

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Caloneis

</td>
<td style="text-align:left;">

P.T. Cleve, 1894

</td>
<td style="text-align:right;">

592

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Calx

</td>
<td style="text-align:left;">

Christiansen, 1958

</td>
<td style="text-align:right;">

288

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Calyptrocarya

</td>
<td style="text-align:left;">

Nees,

</td>
<td style="text-align:right;">

281

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Camelobaetidius

</td>
<td style="text-align:left;">

Demoulin, 1966

</td>
<td style="text-align:right;">

270

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Camponotus

</td>
<td style="text-align:left;">

Mayr, 1861

</td>
<td style="text-align:right;">

500

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Campsurus

</td>
<td style="text-align:left;">

Eaton, 1868

</td>
<td style="text-align:right;">

659

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Campylothorax

</td>
<td style="text-align:left;">

Schött, 1893

</td>
<td style="text-align:right;">

624

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Canthidium

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

784

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Canthon

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

784

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Capartogramma

</td>
<td style="text-align:left;">

H. Kufferath, 1956

</td>
<td style="text-align:right;">

592

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Cardamine

</td>
<td style="text-align:left;">

Linneo,

</td>
<td style="text-align:right;">

395

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Carollia

</td>
<td style="text-align:left;">

Gray, 1838

</td>
<td style="text-align:right;">

323

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Casearia

</td>
<td style="text-align:left;">

Jacq. 1760

</td>
<td style="text-align:right;">

686

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Catharus

</td>
<td style="text-align:left;">

Bonaparte, 1850

</td>
<td style="text-align:right;">

741

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Cecropia

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

744

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:left;">

Celina

</td>
<td style="text-align:left;">

Aubé, 1837

</td>
<td style="text-align:right;">

286

</td>
<td style="text-align:left;">

GN

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

Displaying records 1 - 100

</caption>
<thead>
<tr>
<th style="text-align:left;">

sup

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

genus

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Fabaceae

</td>
<td style="text-align:right;">

290

</td>
<td style="text-align:left;">

Abarema

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

33

</td>
</tr>
<tr>
<td style="text-align:left;">

Coenagrionidae

</td>
<td style="text-align:right;">

277

</td>
<td style="text-align:left;">

Acanthagrion

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

17

</td>
</tr>
<tr>
<td style="text-align:left;">

Tettigoniidae

</td>
<td style="text-align:right;">

338

</td>
<td style="text-align:left;">

Acantheremus

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Characidae

</td>
<td style="text-align:right;">

426

</td>
<td style="text-align:left;">

Acestrocephalus

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Achnanthidiaceae

</td>
<td style="text-align:right;">

266

</td>
<td style="text-align:left;">

Achnanthidium

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

16

</td>
</tr>
<tr>
<td style="text-align:left;">

Amaranthaceae

</td>
<td style="text-align:right;">

354

</td>
<td style="text-align:left;">

Achyranthes

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Melastomataceae

</td>
<td style="text-align:right;">

566

</td>
<td style="text-align:left;">

Aciotis

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Poaceae

</td>
<td style="text-align:right;">

324

</td>
<td style="text-align:left;">

Acroceras

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

7

</td>
</tr>
<tr>
<td style="text-align:left;">

Formicidae

</td>
<td style="text-align:right;">

500

</td>
<td style="text-align:left;">

Acromyrmex

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

55

</td>
</tr>
<tr>
<td style="text-align:left;">

Formicidae

</td>
<td style="text-align:right;">

500

</td>
<td style="text-align:left;">

Acropyga

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:left;">

Eunotiaceae

</td>
<td style="text-align:right;">

497

</td>
<td style="text-align:left;">

Actinella

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

24

</td>
</tr>
<tr>
<td style="text-align:left;">

Desmidiaceae

</td>
<td style="text-align:right;">

282

</td>
<td style="text-align:left;">

Actinotaenium

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

8

</td>
</tr>
<tr>
<td style="text-align:left;">

Scolopacidae

</td>
<td style="text-align:right;">

696

</td>
<td style="text-align:left;">

Actitis

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Scenedesmaceae

</td>
<td style="text-align:right;">

691

</td>
<td style="text-align:left;">

Acutodesmus

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:left;">

Formicidae

</td>
<td style="text-align:right;">

500

</td>
<td style="text-align:left;">

Adelomyrmex

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:left;">

Limenitidinae

</td>
<td style="text-align:right;">

772

</td>
<td style="text-align:left;">

Adelpha

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

117

</td>
</tr>
<tr>
<td style="text-align:left;">

Bignoniaceae

</td>
<td style="text-align:right;">

384

</td>
<td style="text-align:left;">

Adenocalymma

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Pteridaceae

</td>
<td style="text-align:right;">

671

</td>
<td style="text-align:left;">

Adiantum

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

15

</td>
</tr>
<tr>
<td style="text-align:left;">

Bourletiellidae

</td>
<td style="text-align:right;">

272

</td>
<td style="text-align:left;">

Adisianus

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Culicidae

</td>
<td style="text-align:right;">

459

</td>
<td style="text-align:left;">

Aedeomyia

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

Orphinae

</td>
<td style="text-align:right;">

775

</td>
<td style="text-align:left;">

Aegidinus

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

7

</td>
</tr>
<tr>
<td style="text-align:left;">

Lamiaceae

</td>
<td style="text-align:right;">

545

</td>
<td style="text-align:left;">

Aegiphila

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

8

</td>
</tr>
<tr>
<td style="text-align:left;">

Fabaceae

</td>
<td style="text-align:right;">

290

</td>
<td style="text-align:left;">

Aeschynomene

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Phyllomedusidae

</td>
<td style="text-align:right;">

637

</td>
<td style="text-align:left;">

Agalychnis

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Ardeidae

</td>
<td style="text-align:right;">

373

</td>
<td style="text-align:left;">

Agamia

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:left;">

Auchenipteridae

</td>
<td style="text-align:right;">

379

</td>
<td style="text-align:left;">

Ageneiosus

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Gomphidae

</td>
<td style="text-align:right;">

295

</td>
<td style="text-align:left;">

Agriogomphus

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

16

</td>
</tr>
<tr>
<td style="text-align:left;">

Lauraceae

</td>
<td style="text-align:right;">

305

</td>
<td style="text-align:left;">

Aiouea

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:left;">

Euphorbiaceae

</td>
<td style="text-align:right;">

289

</td>
<td style="text-align:left;">

Alchornea

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

16

</td>
</tr>
<tr>
<td style="text-align:left;">

Euphorbiaceae

</td>
<td style="text-align:right;">

289

</td>
<td style="text-align:left;">

Alchorneopsis

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:left;">

Aromobatidae

</td>
<td style="text-align:right;">

374

</td>
<td style="text-align:left;">

Allobates

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:left;">

Graphidaceae

</td>
<td style="text-align:right;">

297

</td>
<td style="text-align:left;">

Allographa

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

31

</td>
</tr>
<tr>
<td style="text-align:left;">

Sapindaceae

</td>
<td style="text-align:right;">

688

</td>
<td style="text-align:left;">

Allophyllus

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Sapindaceae

</td>
<td style="text-align:right;">

688

</td>
<td style="text-align:left;">

Allophylus

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Theclinae

</td>
<td style="text-align:right;">

785

</td>
<td style="text-align:left;">

Allosmaitia

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Ceratopogonidae

</td>
<td style="text-align:right;">

420

</td>
<td style="text-align:left;">

Alluaudomyia

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

71

</td>
</tr>
<tr>
<td style="text-align:left;">

Chydoridae

</td>
<td style="text-align:right;">

432

</td>
<td style="text-align:left;">

Alona

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Alopoglossidae

</td>
<td style="text-align:right;">

353

</td>
<td style="text-align:left;">

Alopoglossus

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:left;">

Amaranthaceae

</td>
<td style="text-align:right;">

354

</td>
<td style="text-align:left;">

Alternanthera

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Lecanographaceae

</td>
<td style="text-align:right;">

548

</td>
<td style="text-align:left;">

Alyxoria

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

91

</td>
</tr>
<tr>
<td style="text-align:left;">

Rubiaceae

</td>
<td style="text-align:right;">

330

</td>
<td style="text-align:left;">

Amaioua

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

104

</td>
</tr>
<tr>
<td style="text-align:left;">

Amaranthaceae

</td>
<td style="text-align:right;">

354

</td>
<td style="text-align:left;">

Amaranthus

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Trochilidae

</td>
<td style="text-align:right;">

737

</td>
<td style="text-align:left;">

Amazilia

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

23

</td>
</tr>
<tr>
<td style="text-align:left;">

Psittacidae

</td>
<td style="text-align:right;">

670

</td>
<td style="text-align:left;">

Amazona

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

64

</td>
</tr>
<tr>
<td style="text-align:left;">

Naucoridae

</td>
<td style="text-align:right;">

591

</td>
<td style="text-align:left;">

Ambrysus

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

43

</td>
</tr>
<tr>
<td style="text-align:left;">

Teiidae

</td>
<td style="text-align:right;">

721

</td>
<td style="text-align:left;">

Ameiva

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

466

</td>
</tr>
<tr>
<td style="text-align:left;">

Baetidae

</td>
<td style="text-align:right;">

270

</td>
<td style="text-align:left;">

Americabaetis

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Bignoniaceae

</td>
<td style="text-align:right;">

384

</td>
<td style="text-align:left;">

Amphilophium

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Amphisbaenidae

</td>
<td style="text-align:right;">

356

</td>
<td style="text-align:left;">

Amphisbaena

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Nostocaceae

</td>
<td style="text-align:right;">

599

</td>
<td style="text-align:left;">

Anabaena

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

59

</td>
</tr>
<tr>
<td style="text-align:left;">

Hydrophilidae

</td>
<td style="text-align:right;">

531

</td>
<td style="text-align:left;">

Anacaena

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

7

</td>
</tr>
<tr>
<td style="text-align:left;">

Anacardiaceae

</td>
<td style="text-align:right;">

358

</td>
<td style="text-align:left;">

Anacardium

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Perlidae

</td>
<td style="text-align:right;">

630

</td>
<td style="text-align:left;">

Anacroneuria

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

17

</td>
</tr>
<tr>
<td style="text-align:left;">

Nymphalinae

</td>
<td style="text-align:right;">

774

</td>
<td style="text-align:left;">

Anartia

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

12

</td>
</tr>
<tr>
<td style="text-align:left;">

Pyrginae

</td>
<td style="text-align:right;">

779

</td>
<td style="text-align:left;">

Anastrus

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Hesperiinae

</td>
<td style="text-align:right;">

771

</td>
<td style="text-align:left;">

Anatrytone

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Loricariidae

</td>
<td style="text-align:right;">

558

</td>
<td style="text-align:left;">

Ancistrus

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

21

</td>
</tr>
<tr>
<td style="text-align:left;">

Riodininae

</td>
<td style="text-align:right;">

781

</td>
<td style="text-align:left;">

Ancyluris

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

Aeshnidae

</td>
<td style="text-align:right;">

349

</td>
<td style="text-align:left;">

Andaeschna

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:left;">

Cichlidae

</td>
<td style="text-align:right;">

433

</td>
<td style="text-align:left;">

Andinoacara

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

123

</td>
</tr>
<tr>
<td style="text-align:left;">

Mastogloiaceae

</td>
<td style="text-align:right;">

565

</td>
<td style="text-align:left;">

Aneumastus

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:left;">

Anhingidae

</td>
<td style="text-align:right;">

361

</td>
<td style="text-align:left;">

Anhinga

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Lauraceae

</td>
<td style="text-align:right;">

305

</td>
<td style="text-align:left;">

Aniba

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Coenagrionidae

</td>
<td style="text-align:right;">

277

</td>
<td style="text-align:left;">

Anisagrion

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:left;">

Monoblastiaceae

</td>
<td style="text-align:right;">

583

</td>
<td style="text-align:left;">

Anisomeridium

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

8

</td>
</tr>
<tr>
<td style="text-align:left;">

Selenastraceae

</td>
<td style="text-align:right;">

699

</td>
<td style="text-align:left;">

Ankistrodesmus

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

21

</td>
</tr>
<tr>
<td style="text-align:left;">

Annonaceae

</td>
<td style="text-align:right;">

267

</td>
<td style="text-align:left;">

Annona

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

11

</td>
</tr>
<tr>
<td style="text-align:left;">

Formicidae

</td>
<td style="text-align:right;">

500

</td>
<td style="text-align:left;">

Anochetus

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

35

</td>
</tr>
<tr>
<td style="text-align:left;">

Dytiscidae

</td>
<td style="text-align:right;">

286

</td>
<td style="text-align:left;">

Anodocheilus

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:left;">

Dactyloidae

</td>
<td style="text-align:right;">

467

</td>
<td style="text-align:left;">

Anolis

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

194

</td>
</tr>
<tr>
<td style="text-align:left;">

Anomoeoneidaceae

</td>
<td style="text-align:right;">

363

</td>
<td style="text-align:left;">

Anomoeoneis

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Culicidae

</td>
<td style="text-align:right;">

459

</td>
<td style="text-align:left;">

Anopheles

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

13

</td>
</tr>
<tr>
<td style="text-align:left;">

Riodininae

</td>
<td style="text-align:right;">

781

</td>
<td style="text-align:left;">

Anteros

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Nymphalinae

</td>
<td style="text-align:right;">

774

</td>
<td style="text-align:left;">

Anthanassa

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

19

</td>
</tr>
<tr>
<td style="text-align:left;">

Trochilidae

</td>
<td style="text-align:right;">

737

</td>
<td style="text-align:left;">

Anthracothorax

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

11

</td>
</tr>
<tr>
<td style="text-align:left;">

Araceae

</td>
<td style="text-align:right;">

369

</td>
<td style="text-align:left;">

Anthurium

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

15

</td>
</tr>
<tr>
<td style="text-align:left;">

Pyrginae

</td>
<td style="text-align:right;">

779

</td>
<td style="text-align:left;">

Antigonus

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:left;">

Rallidae

</td>
<td style="text-align:right;">

677

</td>
<td style="text-align:left;">

Anurolimnas

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Malvaceae

</td>
<td style="text-align:right;">

564

</td>
<td style="text-align:left;">

Apeiba

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

8

</td>
</tr>
<tr>
<td style="text-align:left;">

Merismopediaceae

</td>
<td style="text-align:right;">

570

</td>
<td style="text-align:left;">

Aphanocapsa

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Gomphidae

</td>
<td style="text-align:right;">

295

</td>
<td style="text-align:left;">

Aphylla

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:left;">

Baetidae

</td>
<td style="text-align:right;">

270

</td>
<td style="text-align:left;">

Apobaetis

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

33

</td>
</tr>
<tr>
<td style="text-align:left;">

Apteronotidae

</td>
<td style="text-align:right;">

368

</td>
<td style="text-align:left;">

Apteronotus

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

24

</td>
</tr>
<tr>
<td style="text-align:left;">

Formicidae

</td>
<td style="text-align:right;">

500

</td>
<td style="text-align:left;">

Apterostigma

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

13

</td>
</tr>
<tr>
<td style="text-align:left;">

Psittacidae

</td>
<td style="text-align:right;">

670

</td>
<td style="text-align:left;">

Ara

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

7

</td>
</tr>
<tr>
<td style="text-align:left;">

Rallidae

</td>
<td style="text-align:right;">

677

</td>
<td style="text-align:left;">

Aramides

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

5422

</td>
</tr>
<tr>
<td style="text-align:left;">

Aramidae

</td>
<td style="text-align:right;">

371

</td>
<td style="text-align:left;">

Aramus

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

21

</td>
</tr>
<tr>
<td style="text-align:left;">

Theclinae

</td>
<td style="text-align:right;">

785

</td>
<td style="text-align:left;">

Arawacus

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

8

</td>
</tr>
<tr>
<td style="text-align:left;">

Theclinae

</td>
<td style="text-align:right;">

785

</td>
<td style="text-align:left;">

Arcas

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Arcellidae

</td>
<td style="text-align:right;">

372

</td>
<td style="text-align:left;">

Arcella

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

120

</td>
</tr>
<tr>
<td style="text-align:left;">

Charaxinae

</td>
<td style="text-align:right;">

763

</td>
<td style="text-align:left;">

Archaeoprepona

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

35

</td>
</tr>
<tr>
<td style="text-align:left;">

Lejeuneaceae

</td>
<td style="text-align:right;">

550

</td>
<td style="text-align:left;">

Archilejeunea

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

41

</td>
</tr>
<tr>
<td style="text-align:left;">

Ardeidae

</td>
<td style="text-align:right;">

373

</td>
<td style="text-align:left;">

Ardea

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

815

</td>
</tr>
<tr>
<td style="text-align:left;">

Coenagrionidae

</td>
<td style="text-align:right;">

277

</td>
<td style="text-align:left;">

Argia

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

33

</td>
</tr>
<tr>
<td style="text-align:left;">

Hesperiinae

</td>
<td style="text-align:right;">

771

</td>
<td style="text-align:left;">

Argon

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

13

</td>
</tr>
<tr>
<td style="text-align:left;">

Characidae

</td>
<td style="text-align:right;">

426

</td>
<td style="text-align:left;">

Argopleura

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

Isotomidae

</td>
<td style="text-align:right;">

303

</td>
<td style="text-align:left;">

Arlea

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:left;">

Neanuridae

</td>
<td style="text-align:right;">

318

</td>
<td style="text-align:left;">

Arlesia

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

72

</td>
</tr>
<tr>
<td style="text-align:left;">

Arthoniaceae

</td>
<td style="text-align:right;">

375

</td>
<td style="text-align:left;">

Arthonia

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

20

</td>
</tr>
<tr>
<td style="text-align:left;">

Arthoniaceae

</td>
<td style="text-align:right;">

375

</td>
<td style="text-align:left;">

Arthothelium

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

Displaying records 1 - 100

</caption>
<thead>
<tr>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

scientific_name_authorship

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
<th style="text-align:right;">

order_cases_in_name

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Abarema jupunba

</td>
<td style="text-align:left;">

(Willd.) Britton & Killip

</td>
<td style="text-align:right;">

1422

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

31

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Acestrocephalus anomalus

</td>
<td style="text-align:left;">

(Steindachner, 1880)

</td>
<td style="text-align:right;">

1423

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Achyranthes aspera

</td>
<td style="text-align:left;">

Linneo. 1753

</td>
<td style="text-align:right;">

1424

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Aciotis acuminifolia

</td>
<td style="text-align:left;">

(Mart. ex DC.) Triana

</td>
<td style="text-align:right;">

1425

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Acroceras zizanioides

</td>
<td style="text-align:left;">

(Kunth) Dandy, 1931

</td>
<td style="text-align:right;">

1426

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Acroceras zizanioides

</td>
<td style="text-align:left;">

(Kunth) Dandy. 1931

</td>
<td style="text-align:right;">

1426

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Acromyrmex octospinosus

</td>
<td style="text-align:left;">

(Reich, 1793)

</td>
<td style="text-align:right;">

1427

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

55

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Acropyga exsanguis

</td>
<td style="text-align:left;">

(Wheeler, 1909)

</td>
<td style="text-align:right;">

1428

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Actitis macularius

</td>
<td style="text-align:left;">

Linnaeus, 1766

</td>
<td style="text-align:right;">

1429

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Adelomyrmex myops

</td>
<td style="text-align:left;">

(Wheeler, 1910)

</td>
<td style="text-align:right;">

1430

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Adelpha basiloides

</td>
<td style="text-align:left;">

(H. Bates, 1865)

</td>
<td style="text-align:right;">

1431

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

7

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Adenocalymma aspericarpum

</td>
<td style="text-align:left;">

(A.H. Gentry) L.G. Lohmann

</td>
<td style="text-align:right;">

1432

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Adiantum petiolatum

</td>
<td style="text-align:left;">

(Schumacher) DC.

</td>
<td style="text-align:right;">

793

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Adiantum tetraphyllum

</td>
<td style="text-align:left;">

Humb. & Bonpl. ex Willd. 1810

</td>
<td style="text-align:right;">

793

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

8

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Aedeomyia squamipennis

</td>
<td style="text-align:left;">

(Lynch Arribálzaga, 1878)

</td>
<td style="text-align:right;">

795

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Aegidinus candezei

</td>
<td style="text-align:left;">

(Preudhomme de Borre, 1886)

</td>
<td style="text-align:right;">

1433

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

7

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Aegiphila integrifolia

</td>
<td style="text-align:left;">

(Jacq.) B.D.

</td>
<td style="text-align:right;">

1434

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Aegiphila integrifolia

</td>
<td style="text-align:left;">

(Jacq.) B.D.Jacks.

</td>
<td style="text-align:right;">

1434

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Aegiphila integrifolia

</td>
<td style="text-align:left;">

(Jacq.) B.D. Jacks.

</td>
<td style="text-align:right;">

1434

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:left;">

Aeschynomene sensitiva

</td>
<td style="text-align:left;">

Sw. 1788

</td>
<td style="text-align:right;">

1435

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Agalychnis terranova

</td>
<td style="text-align:left;">

Rivera, Duarte, Rueda & Daza, 2013

</td>
<td style="text-align:right;">

1436

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Agamia agami

</td>
<td style="text-align:left;">

Gmelin, 1789

</td>
<td style="text-align:right;">

1437

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Ageneiosus pardalis

</td>
<td style="text-align:left;">

Lütken, 1874

</td>
<td style="text-align:right;">

1438

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Alchornea glandulosa

</td>
<td style="text-align:left;">

Poepp.

</td>
<td style="text-align:right;">

798

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

10

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Alchornea triplinervia

</td>
<td style="text-align:left;">

(Spreng.) Müll. Arg.

</td>
<td style="text-align:right;">

798

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Alchorneopsis floribunda

</td>
<td style="text-align:left;">

(Benth.) Müll. Arg.

</td>
<td style="text-align:right;">

1439

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Allobates niputidea

</td>
<td style="text-align:left;">

Grant, Acosta & Rada, 2007

</td>
<td style="text-align:right;">

1440

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Allographa rhizicola

</td>
<td style="text-align:left;">

 (Fée) Lücking & Kalb

</td>
<td style="text-align:right;">

1441

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

31

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Allosmaitia strophius

</td>
<td style="text-align:left;">

(Godart, $$1824$$)

</td>
<td style="text-align:right;">

1442

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Alopoglossus festae

</td>
<td style="text-align:left;">

(Peracca, 1896)

</td>
<td style="text-align:right;">

1443

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Alternanthera albotomentosa

</td>
<td style="text-align:left;">

(L.) Blume

</td>
<td style="text-align:right;">

1444

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Alternanthera albotomentosa

</td>
<td style="text-align:left;">

Suess.

</td>
<td style="text-align:right;">

1444

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Alyxoria varia

</td>
<td style="text-align:left;">

(Pers.) Ertz & Tehler

</td>
<td style="text-align:right;">

1445

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

91

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Amaioua glomerulata

</td>
<td style="text-align:left;">

(Lam. ex Poir.) Delprete & C.H. Perss.

</td>
<td style="text-align:right;">

1446

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

20

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Amaioua guianensis

</td>
<td style="text-align:left;">

Aubl.

</td>
<td style="text-align:right;">

1446

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

84

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Amaranthus dubius

</td>
<td style="text-align:left;">

Mart. ex Thell.

</td>
<td style="text-align:right;">

1447

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Amazilia tzacatl

</td>
<td style="text-align:left;">

De la Llave, 1833

</td>
<td style="text-align:right;">

1448

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

23

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Amazona amazonica

</td>
<td style="text-align:left;">

Linnaeus, 1766

</td>
<td style="text-align:right;">

803

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

55

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Amazona farinosa

</td>
<td style="text-align:left;">

Boddaert, 1783

</td>
<td style="text-align:right;">

803

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Amazona ochrocephala

</td>
<td style="text-align:left;">

Gmelin, JF, 1788

</td>
<td style="text-align:right;">

803

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Ameiva ameiva

</td>
<td style="text-align:left;">

Linnaeus (1758)

</td>
<td style="text-align:right;">

1449

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

225

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Ameiva ameiva

</td>
<td style="text-align:left;">

(Linnaeus, 1758)

</td>
<td style="text-align:right;">

1449

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Ameiva bifrontata

</td>
<td style="text-align:left;">

Cope, 1862

</td>
<td style="text-align:right;">

1449

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

239

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Amphilophium crucigerum

</td>
<td style="text-align:left;">

(L.) L.G. Lohmann

</td>
<td style="text-align:right;">

1450

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Amphisbaena fuliginosa

</td>
<td style="text-align:left;">

Linnaeus, 1758

</td>
<td style="text-align:right;">

1451

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Anacardium excelsum

</td>
<td style="text-align:left;">

(Bertero & Balb. ex Kunth) Skeels

</td>
<td style="text-align:right;">

1452

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Anartia amathea

</td>
<td style="text-align:left;">

(Linnaeus, 1758)

</td>
<td style="text-align:right;">

1453

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

6

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Anartia jatrophae

</td>
<td style="text-align:left;">

(Linnaeus, 1763)

</td>
<td style="text-align:right;">

1453

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

6

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Anastrus neaeris

</td>
<td style="text-align:left;">

(Möschler, 1879)

</td>
<td style="text-align:right;">

1454

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Anastrus neaeris

</td>
<td style="text-align:left;">

(Möschler, 1879) 

</td>
<td style="text-align:right;">

1454

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Anatrytone mella

</td>
<td style="text-align:left;">

(Godman, 1900)

</td>
<td style="text-align:right;">

1455

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Ancistrus caucanus

</td>
<td style="text-align:left;">

Fowler, 1943

</td>
<td style="text-align:right;">

1456

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

21

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Andinoacara latifrons

</td>
<td style="text-align:left;">

(Steindachner, 1878)

</td>
<td style="text-align:right;">

1458

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

123

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Anhinga anhinga

</td>
<td style="text-align:left;">

Linnaeus, 1766

</td>
<td style="text-align:right;">

1459

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Aniba riparia

</td>
<td style="text-align:left;">

(Nees) Mez

</td>
<td style="text-align:right;">

1460

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Annona glabra

</td>
<td style="text-align:left;">

12. 

</td>
<td style="text-align:right;">

814

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Annona mucosa

</td>
<td style="text-align:left;">

Diels

</td>
<td style="text-align:right;">

814

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Anochetus diegensis

</td>
<td style="text-align:left;">

Forel, 1912

</td>
<td style="text-align:right;">

1461

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

35

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Anolis auratus

</td>
<td style="text-align:left;">

(Daudin, 1802)

</td>
<td style="text-align:right;">

1462

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

85

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Anolis tropidogaster

</td>
<td style="text-align:left;">

(Hallowell, 1856)

</td>
<td style="text-align:right;">

1462

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

109

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Anteros carausius

</td>
<td style="text-align:left;">

Westwood, 1851

</td>
<td style="text-align:right;">

1463

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Anthanassa drusilla

</td>
<td style="text-align:left;">

(C. Felder & R. Felder, 1861)

</td>
<td style="text-align:right;">

1464

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

19

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Anthracothorax nigricollis

</td>
<td style="text-align:left;">

Vieillot, 1817,

</td>
<td style="text-align:right;">

1465

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

11

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Anthurium clavigerum

</td>
<td style="text-align:left;">

Poepp.

</td>
<td style="text-align:right;">

818

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Anthurium glaucospadix

</td>
<td style="text-align:left;">

Croat

</td>
<td style="text-align:right;">

818

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Antigonus erosus

</td>
<td style="text-align:left;">

(Hübner, $$1812$$)

</td>
<td style="text-align:right;">

1466

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Anurolimnas viridis

</td>
<td style="text-align:left;">

Statius Muller, 1776

</td>
<td style="text-align:right;">

1467

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Apeiba glabra

</td>
<td style="text-align:left;">

Aubl.

</td>
<td style="text-align:right;">

1468

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

7

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Apeiba membranacea

</td>
<td style="text-align:left;">

Spruce ex Benth.

</td>
<td style="text-align:right;">

1468

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Apteronotus mariae

</td>
<td style="text-align:left;">

Eigenmann & Fisher, 1914

</td>
<td style="text-align:right;">

1469

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Apteronotus milesi

</td>
<td style="text-align:left;">

de Santana & Maldonado-Ocampo, 2005

</td>
<td style="text-align:right;">

1469

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

22

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Apterostigma dentigerum

</td>
<td style="text-align:left;">

Wheeler, 1925

</td>
<td style="text-align:right;">

1470

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Apterostigma manni

</td>
<td style="text-align:left;">

Weber, 1938

</td>
<td style="text-align:right;">

1470

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Apterostigma mayri

</td>
<td style="text-align:left;">

Forel, 1893

</td>
<td style="text-align:right;">

1470

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

7

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Ara ararauna

</td>
<td style="text-align:left;">

Linnaeus, 1758

</td>
<td style="text-align:right;">

1471

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

7

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Aramides cajaneus

</td>
<td style="text-align:left;">

Statius Muller, 1776

</td>
<td style="text-align:right;">

1472

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5422

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Aramus guarauna

</td>
<td style="text-align:left;">

Linnaeus, 1766

</td>
<td style="text-align:right;">

1473

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

21

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Arawacus lincoides

</td>
<td style="text-align:left;">

(Draudt, 1917)

</td>
<td style="text-align:right;">

1474

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

8

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Arcas imperialis

</td>
<td style="text-align:left;">

(Cramer, 1775)

</td>
<td style="text-align:right;">

1475

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Arcella dentata

</td>
<td style="text-align:left;">

Ehrenberg, 1832

</td>
<td style="text-align:right;">

822

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Archilejeunea juliformis

</td>
<td style="text-align:left;">

(Nees) Gradst.

</td>
<td style="text-align:right;">

1477

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

41

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Ardea alba

</td>
<td style="text-align:left;">

Linnaeus, 1758

</td>
<td style="text-align:right;">

1478

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

97

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Ardea alba

</td>
<td style="text-align:left;">

Linnaeus, 1758

</td>
<td style="text-align:right;">

1478

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

36

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Ardea cocoi

</td>
<td style="text-align:left;">

Linnaeus, 1766

</td>
<td style="text-align:right;">

1478

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

682

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Argon lota

</td>
<td style="text-align:left;">

(Hewitson, 1877)

</td>
<td style="text-align:right;">

1479

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

13

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Argopleura magdalenensis

</td>
<td style="text-align:left;">

(Eigenmann, 1913)

</td>
<td style="text-align:right;">

1480

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

9

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Arlea lucifuga

</td>
<td style="text-align:left;">

(Arlé, 1939) Womersley, 1939

</td>
<td style="text-align:right;">

1481

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Arlea spinisetis

</td>
<td style="text-align:left;">

Mendonça & Arlé, 1987

</td>
<td style="text-align:right;">

1481

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Arthonia catenatula

</td>
<td style="text-align:left;">

Nyl.

</td>
<td style="text-align:right;">

1482

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

6

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Arthonia platygraphidea

</td>
<td style="text-align:left;">

Nyl.

</td>
<td style="text-align:right;">

1482

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

14

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Artibeus anderseni

</td>
<td style="text-align:left;">

(Osgood, 1916)

</td>
<td style="text-align:right;">

827

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

26

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Artibeus glaucus

</td>
<td style="text-align:left;">

(Thomas, 1893)

</td>
<td style="text-align:right;">

827

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Artibeus jamaicensis

</td>
<td style="text-align:left;">

Leach, 1821

</td>
<td style="text-align:right;">

827

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Artibeus lituratus

</td>
<td style="text-align:left;">

(Olfers, 1818)

</td>
<td style="text-align:right;">

827

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

960

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Artibeus phaeotis

</td>
<td style="text-align:left;">

Leach, 1821

</td>
<td style="text-align:right;">

827

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Artibeus planirostris

</td>
<td style="text-align:left;">

(Spix, 1823)

</td>
<td style="text-align:right;">

827

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

94

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Artines aepitus

</td>
<td style="text-align:left;">

(Geyer, 1832)

</td>
<td style="text-align:right;">

1483

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Arundinicola leucocephala

</td>
<td style="text-align:left;">

Linnaeus, 1764

</td>
<td style="text-align:right;">

1484

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Ascia monuste

</td>
<td style="text-align:left;">

(Linnaeus, 1764)

</td>
<td style="text-align:right;">

1485

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Asio clamator

</td>
<td style="text-align:left;">

Vieillot, 1808

</td>
<td style="text-align:right;">

1486

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

137 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

scientific_name_authorship

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
<th style="text-align:right;">

order_cases_in_name

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Acroceras zizanioides

</td>
<td style="text-align:left;">

(Kunth) Dandy, 1931

</td>
<td style="text-align:right;">

1426

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Acroceras zizanioides

</td>
<td style="text-align:left;">

(Kunth) Dandy. 1931

</td>
<td style="text-align:right;">

1426

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Aegiphila integrifolia

</td>
<td style="text-align:left;">

(Jacq.) B.D.

</td>
<td style="text-align:right;">

1434

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Aegiphila integrifolia

</td>
<td style="text-align:left;">

(Jacq.) B.D.Jacks.

</td>
<td style="text-align:right;">

1434

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Aegiphila integrifolia

</td>
<td style="text-align:left;">

(Jacq.) B.D. Jacks.

</td>
<td style="text-align:right;">

1434

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:left;">

Alternanthera albotomentosa

</td>
<td style="text-align:left;">

(L.) Blume

</td>
<td style="text-align:right;">

1444

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Alternanthera albotomentosa

</td>
<td style="text-align:left;">

Suess.

</td>
<td style="text-align:right;">

1444

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Ameiva ameiva

</td>
<td style="text-align:left;">

Linnaeus (1758)

</td>
<td style="text-align:right;">

1449

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

225

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Ameiva ameiva

</td>
<td style="text-align:left;">

(Linnaeus, 1758)

</td>
<td style="text-align:right;">

1449

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Anastrus neaeris

</td>
<td style="text-align:left;">

(Möschler, 1879)

</td>
<td style="text-align:right;">

1454

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Anastrus neaeris

</td>
<td style="text-align:left;">

(Möschler, 1879) 

</td>
<td style="text-align:right;">

1454

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Ardea alba

</td>
<td style="text-align:left;">

Linnaeus, 1758

</td>
<td style="text-align:right;">

1478

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

97

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Ardea alba

</td>
<td style="text-align:left;">

Linnaeus, 1758

</td>
<td style="text-align:right;">

1478

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

36

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Asystasia gangetica

</td>
<td style="text-align:left;">

(L.) T. Anderson

</td>
<td style="text-align:right;">

1491

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Asystasia gangetica

</td>
<td style="text-align:left;">

(L.) T.Anderson

</td>
<td style="text-align:right;">

1491

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Bothrops asper

</td>
<td style="text-align:left;">

(Garman, 1884)

</td>
<td style="text-align:right;">

1513

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

7

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Bothrops asper

</td>
<td style="text-align:left;">

Garman, 1884

</td>
<td style="text-align:right;">

1513

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Byrsonima spicata

</td>
<td style="text-align:left;">

(Cav.) DC.

</td>
<td style="text-align:right;">

1526

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

103

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Byrsonima spicata

</td>
<td style="text-align:left;">

(Cav.) Kunth

</td>
<td style="text-align:right;">

1526

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Caiman crocodilus

</td>
<td style="text-align:left;">

(Linnaeus, 1758)

</td>
<td style="text-align:right;">

1531

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

50

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Caiman crocodilus

</td>
<td style="text-align:left;">

Linnaeus, 1758

</td>
<td style="text-align:right;">

1531

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

43

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Calyptrocarya glomerulata

</td>
<td style="text-align:left;">

(Brongn,) Urb, 1900

</td>
<td style="text-align:right;">

873

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

6

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Calyptrocarya glomerulata

</td>
<td style="text-align:left;">

(Brongn.) Urb. 1900

</td>
<td style="text-align:right;">

873

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Campylorhynchus griseus

</td>
<td style="text-align:left;">

Swainson, 1838

</td>
<td style="text-align:right;">

1545

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

654

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Campylorhynchus griseus

</td>
<td style="text-align:left;">

Swainson, 1837

</td>
<td style="text-align:right;">

1545

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

219

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Caperonia palustris

</td>
<td style="text-align:left;">

(L.) A. St.-Hil. 1825

</td>
<td style="text-align:right;">

1548

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Caperonia palustris

</td>
<td style="text-align:left;">

(L,) A, St,-Hil, 1825

</td>
<td style="text-align:right;">

1548

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Caracara cheriway

</td>
<td style="text-align:left;">

von Jacquin, 1784

</td>
<td style="text-align:right;">

1550

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

41

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Caracara cheriway

</td>
<td style="text-align:left;">

Nikolaus Joseph von Jacquin, 1784

</td>
<td style="text-align:right;">

1550

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

25

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Cephalotes columbicus

</td>
<td style="text-align:left;">

(Forel, 1912)

</td>
<td style="text-align:right;">

889

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

16

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Cephalotes columbicus

</td>
<td style="text-align:left;">

(Fabricius, 1804)

</td>
<td style="text-align:right;">

889

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Ceratopteris pteridoides

</td>
<td style="text-align:left;">

(Hook,) Hieron, 1905

</td>
<td style="text-align:right;">

893

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Ceratopteris pteridoides

</td>
<td style="text-align:left;">

(Hook.) Hieron. 1905

</td>
<td style="text-align:right;">

893

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Chironius spixii

</td>
<td style="text-align:left;">

(Hallowell, 1845)

</td>
<td style="text-align:right;">

1580

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

6

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Chironius spixii

</td>
<td style="text-align:left;">

Hallowell, 1845

</td>
<td style="text-align:right;">

1580

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Colinus cristatus

</td>
<td style="text-align:left;">

Linnaeus, 1758

</td>
<td style="text-align:right;">

1604

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Colinus cristatus

</td>
<td style="text-align:left;">

Linnaeus, 1766

</td>
<td style="text-align:right;">

1604

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

12

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Columbina talpacoti

</td>
<td style="text-align:left;">

Temminck‎, 1810

</td>
<td style="text-align:right;">

914

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

189

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Columbina talpacoti

</td>
<td style="text-align:left;">

Temminck, 1810

</td>
<td style="text-align:right;">

914

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

152

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Copiphora vigorosa

</td>
<td style="text-align:left;">

Sarria-S., Buxton, Jonsson & Montealegre-Z., 2016

</td>
<td style="text-align:right;">

1613

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Copiphora vigorosa

</td>
<td style="text-align:left;">

Sarria-S., K. Buxton, Jonsson & Montealegre-Z. 2016.

</td>
<td style="text-align:right;">

1613

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Coragyps atratus

</td>
<td style="text-align:left;">

Bechstein, 1793

</td>
<td style="text-align:right;">

1615

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

121

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Coragyps atratus

</td>
<td style="text-align:left;">

Linnaeus, 1758

</td>
<td style="text-align:right;">

1615

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Dorymyrmex tuberosus

</td>
<td style="text-align:left;">

Cuezzo & Guerrero, 2012

</td>
<td style="text-align:right;">

1677

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

75

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Dorymyrmex tuberosus

</td>
<td style="text-align:left;">

Cuezzo & Guerrero, 2011

</td>
<td style="text-align:right;">

1677

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Ectomis auginus

</td>
<td style="text-align:left;">

(Hewitson, 1867)

</td>
<td style="text-align:right;">

1690

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

6

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Ectomis auginus

</td>
<td style="text-align:left;">

(Hewitson, 1867) 

</td>
<td style="text-align:right;">

1690

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Eptesicus brasiliensis

</td>
<td style="text-align:left;">

(Desmarest, 1819)

</td>
<td style="text-align:right;">

992

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

6

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Eptesicus brasiliensis

</td>
<td style="text-align:left;">

Rafinesque, 1820

</td>
<td style="text-align:right;">

992

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Erythrolamprus melanotus

</td>
<td style="text-align:left;">

Shaw, 1802

</td>
<td style="text-align:right;">

995

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Erythrolamprus melanotus

</td>
<td style="text-align:left;">

(Shaw, 1802)

</td>
<td style="text-align:right;">

995

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Felis catus

</td>
<td style="text-align:left;">

Linnaeus, 1758

</td>
<td style="text-align:right;">

1729

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

14

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Felis catus

</td>
<td style="text-align:left;">

Schreber, 1775

</td>
<td style="text-align:right;">

1729

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

10

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Furnarius leucopus

</td>
<td style="text-align:left;">

Swainson, 1837

</td>
<td style="text-align:right;">

1738

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

98

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Furnarius leucopus

</td>
<td style="text-align:left;">

Swainson, 1838

</td>
<td style="text-align:right;">

1738

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

76

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Helicops danieli

</td>
<td style="text-align:left;">

(Amaral, 1938)

</td>
<td style="text-align:right;">

1769

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

9

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Helicops danieli

</td>
<td style="text-align:left;">

Amaral, 1938

</td>
<td style="text-align:right;">

1769

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Icterus nigrogularis

</td>
<td style="text-align:left;">

Hahn, 1819

</td>
<td style="text-align:right;">

1802

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

85

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Icterus nigrogularis

</td>
<td style="text-align:left;">

Hahn, 1816

</td>
<td style="text-align:right;">

1802

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Iguana iguana

</td>
<td style="text-align:left;">

Linnaeus, 1758

</td>
<td style="text-align:right;">

1804

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

138

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Iguana iguana

</td>
<td style="text-align:left;">

(Linnaeus, 1758)

</td>
<td style="text-align:right;">

1804

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

7

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Imantodes cenchoa

</td>
<td style="text-align:left;">

(Linnaeus, 1758)

</td>
<td style="text-align:right;">

1805

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

32

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Imantodes cenchoa

</td>
<td style="text-align:left;">

Linnaeus, 1758

</td>
<td style="text-align:right;">

1805

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Leonia triandra

</td>
<td style="text-align:left;">

Cuatrec. ex L.B. Sm. & Á. Fernández

</td>
<td style="text-align:right;">

1829

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

94

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Leonia triandra

</td>
<td style="text-align:left;">

Cuatrec.

</td>
<td style="text-align:right;">

1829

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Leonia triandra

</td>
<td style="text-align:left;">

(Jacq.) B.D. Jacks.

</td>
<td style="text-align:right;">

1829

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:left;">

Leptodeira annulata

</td>
<td style="text-align:left;">

(Linnaeus, 1758)

</td>
<td style="text-align:right;">

1832

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

24

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Leptodeira annulata

</td>
<td style="text-align:left;">

Linnaeus, 1758

</td>
<td style="text-align:right;">

1832

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Leptophis ahaetulla

</td>
<td style="text-align:left;">

(Linnaeus, 1758)

</td>
<td style="text-align:right;">

1836

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

9

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Leptophis ahaetulla

</td>
<td style="text-align:left;">

Linnaeus, 1758

</td>
<td style="text-align:right;">

1836

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Loxopholis rugiceps

</td>
<td style="text-align:left;">

(Cope, 1869)

</td>
<td style="text-align:right;">

1847

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

115

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Loxopholis rugiceps

</td>
<td style="text-align:left;">

Cope, 1869

</td>
<td style="text-align:right;">

1847

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Ludwigia helminthorrhiza

</td>
<td style="text-align:left;">

(Mart.) H. Hara, 1953

</td>
<td style="text-align:right;">

1115

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

15

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Ludwigia helminthorrhiza

</td>
<td style="text-align:left;">

(Mart.) H. Hara. 1953

</td>
<td style="text-align:right;">

1115

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Matayba sylvatica

</td>
<td style="text-align:left;">

(Casar.) Radlk.

</td>
<td style="text-align:right;">

1134

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

23

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Matayba sylvatica

</td>
<td style="text-align:left;">

(Standl.) Swart

</td>
<td style="text-align:right;">

1134

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Micrasterias truncata

</td>
<td style="text-align:left;">

Brébisson ex Ralfs, 1849

</td>
<td style="text-align:right;">

1153

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

6

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Micrasterias truncata

</td>
<td style="text-align:left;">

Brébisson ex Ralfs 1848

</td>
<td style="text-align:right;">

1153

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Micropholis guyanensis

</td>
<td style="text-align:left;">

Benth.

</td>
<td style="text-align:right;">

1157

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Micropholis guyanensis

</td>
<td style="text-align:left;">

(A. DC.) Pierre

</td>
<td style="text-align:right;">

1157

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Micrurus dumerilii

</td>
<td style="text-align:left;">

(Jan, 1858)

</td>
<td style="text-align:right;">

1882

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Micrurus dumerilii

</td>
<td style="text-align:left;">

Jan, 1858

</td>
<td style="text-align:right;">

1882

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Molossops temminckii

</td>
<td style="text-align:left;">

(Burmeister, 1854)

</td>
<td style="text-align:right;">

1890

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

15

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Molossops temminckii

</td>
<td style="text-align:left;">

(Burmeister,1854)

</td>
<td style="text-align:right;">

1890

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Molossus molossus

</td>
<td style="text-align:left;">

(Pallas, 1766)

</td>
<td style="text-align:right;">

1164

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

126

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Molossus molossus

</td>
<td style="text-align:left;">

(Pallas,1766)

</td>
<td style="text-align:right;">

1164

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

115

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Molossus molossus

</td>
<td style="text-align:left;">

E. Geoffroy, 1805

</td>
<td style="text-align:right;">

1164

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:left;">

Momotus subrufescens

</td>
<td style="text-align:left;">

Sclater, 1853

</td>
<td style="text-align:right;">

1165

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1249

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Momotus subrufescens

</td>
<td style="text-align:left;">

Sclater, PL, 1853

</td>
<td style="text-align:right;">

1165

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

130

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Myotis nigricans

</td>
<td style="text-align:left;">

(Schinz, 1821)

</td>
<td style="text-align:right;">

1175

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

73

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Myotis nigricans

</td>
<td style="text-align:left;">

Kaup, 1829

</td>
<td style="text-align:right;">

1175

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

6

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Myotis riparius

</td>
<td style="text-align:left;">

Kaup, 1829

</td>
<td style="text-align:right;">

1175

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Myotis riparius

</td>
<td style="text-align:left;">

(Rhoads, 1897)

</td>
<td style="text-align:right;">

1175

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Nyctidromus albicollis

</td>
<td style="text-align:left;">

Gmelin, 1789

</td>
<td style="text-align:right;">

1929

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

713

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Nyctidromus albicollis

</td>
<td style="text-align:left;">

J.F. Gmelin, 1789

</td>
<td style="text-align:right;">

1929

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Oenocarpus minor

</td>
<td style="text-align:left;">

Mart.

</td>
<td style="text-align:right;">

1937

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Oenocarpus minor

</td>
<td style="text-align:left;">

Bercht. & J. Presl

</td>
<td style="text-align:right;">

1937

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Ortalis garrula

</td>
<td style="text-align:left;">

Humboldt, 1805

</td>
<td style="text-align:right;">

1213

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

396

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Ortalis garrula

</td>
<td style="text-align:left;">

von Humboldt, 1805

</td>
<td style="text-align:right;">

1213

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

104

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Phimosus infuscatus

</td>
<td style="text-align:left;">

Hellmayr, 1903

</td>
<td style="text-align:right;">

1990

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

74

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Phimosus infuscatus

</td>
<td style="text-align:left;">

Lichtenstein, 1823

</td>
<td style="text-align:right;">

1990

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

20

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Procyon cancrivorus

</td>
<td style="text-align:left;">

Cuvier, 1798

</td>
<td style="text-align:right;">

2030

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

441

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Procyon cancrivorus

</td>
<td style="text-align:left;">

(G. Cuvier, 1798)

</td>
<td style="text-align:right;">

2030

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Pyrrhopygopsis socrates

</td>
<td style="text-align:left;">

(Ménétriés, 1855)

</td>
<td style="text-align:right;">

2052

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

6

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Pyrrhopygopsis socrates

</td>
<td style="text-align:left;">

(Menetries, 1855)

</td>
<td style="text-align:right;">

2052

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Rhinella horribilis

</td>
<td style="text-align:left;">

(Wiegmann, 1833)

</td>
<td style="text-align:right;">

1302

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

42

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Rhinella horribilis

</td>
<td style="text-align:left;">

Wiegmann, 1833

</td>
<td style="text-align:right;">

1302

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

16

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Rhogeessa io

</td>
<td style="text-align:left;">

H.Allen 1866

</td>
<td style="text-align:right;">

1306

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

9

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Rhogeessa io

</td>
<td style="text-align:left;">

Thomas, 1903

</td>
<td style="text-align:right;">

1306

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Rhynchospora corymbosa

</td>
<td style="text-align:left;">

(L,) Britton, 1892

</td>
<td style="text-align:right;">

2069

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Rhynchospora corymbosa

</td>
<td style="text-align:left;">

(L.) Britton. 1892

</td>
<td style="text-align:right;">

2069

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Rupornis magnirostris

</td>
<td style="text-align:left;">

J. F. Gmelin, 1788

</td>
<td style="text-align:right;">

2077

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

149

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Rupornis magnirostris

</td>
<td style="text-align:left;">

Gmelin, 1788

</td>
<td style="text-align:right;">

2077

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

142

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Swartzia oraria

</td>
<td style="text-align:left;">

Cowan

</td>
<td style="text-align:right;">

1364

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

8

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Swartzia oraria

</td>
<td style="text-align:left;">

Cowan.

</td>
<td style="text-align:right;">

1364

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

6

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Syntheosciurus granatensis

</td>
<td style="text-align:left;">

Humboldt, 1811

</td>
<td style="text-align:right;">

2133

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1427

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Syntheosciurus granatensis

</td>
<td style="text-align:left;">

Humboldt (1811)

</td>
<td style="text-align:right;">

2133

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Tabernaemontana markgrafiana

</td>
<td style="text-align:left;">

J.F. Macbr.

</td>
<td style="text-align:right;">

2135

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Tabernaemontana markgrafiana

</td>
<td style="text-align:left;">

H. Karst.

</td>
<td style="text-align:right;">

2135

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Tamandua mexicana

</td>
<td style="text-align:left;">

Saussure, 1860

</td>
<td style="text-align:right;">

2138

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

374

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Tamandua mexicana

</td>
<td style="text-align:left;">

Saussure 1860

</td>
<td style="text-align:right;">

2138

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Tamandua mexicana

</td>
<td style="text-align:left;">

(Saussure, 1860)

</td>
<td style="text-align:right;">

2138

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:left;">

Tantilla melanocephala

</td>
<td style="text-align:left;">

(Linnaeus, 1758)

</td>
<td style="text-align:right;">

2141

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Tantilla melanocephala

</td>
<td style="text-align:left;">

Linnaeus, 1758

</td>
<td style="text-align:right;">

2141

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Temenis laothoe

</td>
<td style="text-align:left;">

(Cramer, 1777)

</td>
<td style="text-align:right;">

2151

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

47

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Temenis laothoe

</td>
<td style="text-align:left;">

 (Cramer, 1777)

</td>
<td style="text-align:right;">

2151

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Thamnophilus nigriceps

</td>
<td style="text-align:left;">

Sclater, PL, 1869

</td>
<td style="text-align:right;">

2156

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

90

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Thamnophilus nigriceps

</td>
<td style="text-align:left;">

Sclater, 1869

</td>
<td style="text-align:right;">

2156

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

19

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Tupinambis cryptus

</td>
<td style="text-align:left;">

Murphy, Jowers, Lehtinen, Charles, Colli, Peres Jr., Hendry, & Pyron,
2016

</td>
<td style="text-align:right;">

2187

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

656

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Tupinambis cryptus

</td>
<td style="text-align:left;">

Murphy, Jowers, Lehtinen, Charles, Colli, Peres Jr, Hendry & Pyron, 2016

</td>
<td style="text-align:right;">

2187

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Tupinambis cryptus

</td>
<td style="text-align:left;">

Murphy, Jowers, Lehtinen, Charles, Colli, Peres JR, Hendry & Pyron, 2016

</td>
<td style="text-align:right;">

2187

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:left;">

Vareuptychia themis

</td>
<td style="text-align:left;">

(A. Butler, 1867)

</td>
<td style="text-align:right;">

2196

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

39

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Vareuptychia themis

</td>
<td style="text-align:left;">

(A. Buller, 1867)

</td>
<td style="text-align:right;">

2196

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Xylopia discreta

</td>
<td style="text-align:left;">

(L.) Sprague & Hutch.

</td>
<td style="text-align:right;">

2206

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

8

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Xylopia discreta

</td>
<td style="text-align:left;">

(L.f.) Sprague & Hutch.

</td>
<td style="text-align:right;">

2206

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Yphthimoides blanquita

</td>
<td style="text-align:left;">

Barbosa, Marín & Freitas, 2016

</td>
<td style="text-align:right;">

2207

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Yphthimoides blanquita

</td>
<td style="text-align:left;">

E. Barbosa, M. Marín & A.V.L. Freitas, 2016

</td>
<td style="text-align:right;">

2207

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

14

</td>
<td style="text-align:right;">

2

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

Displaying records 1 - 100

</caption>
<thead>
<tr>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

scientific_name_authorship

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

cd_rank

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Abarema jupunba

</td>
<td style="text-align:left;">

(Willd.) Britton & Killip

</td>
<td style="text-align:right;">

1422

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Acestrocephalus anomalus

</td>
<td style="text-align:left;">

(Steindachner, 1880)

</td>
<td style="text-align:right;">

1423

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Achyranthes aspera

</td>
<td style="text-align:left;">

Linneo. 1753

</td>
<td style="text-align:right;">

1424

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Aciotis acuminifolia

</td>
<td style="text-align:left;">

(Mart. ex DC.) Triana

</td>
<td style="text-align:right;">

1425

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Acroceras zizanioides

</td>
<td style="text-align:left;">

(Kunth) Dandy, 1931

</td>
<td style="text-align:right;">

1426

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Acromyrmex octospinosus

</td>
<td style="text-align:left;">

(Reich, 1793)

</td>
<td style="text-align:right;">

1427

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Acropyga exsanguis

</td>
<td style="text-align:left;">

(Wheeler, 1909)

</td>
<td style="text-align:right;">

1428

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Actitis macularius

</td>
<td style="text-align:left;">

Linnaeus, 1766

</td>
<td style="text-align:right;">

1429

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Adelomyrmex myops

</td>
<td style="text-align:left;">

(Wheeler, 1910)

</td>
<td style="text-align:right;">

1430

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Adelpha basiloides

</td>
<td style="text-align:left;">

(H. Bates, 1865)

</td>
<td style="text-align:right;">

1431

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Adenocalymma aspericarpum

</td>
<td style="text-align:left;">

(A.H. Gentry) L.G. Lohmann

</td>
<td style="text-align:right;">

1432

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Adiantum petiolatum

</td>
<td style="text-align:left;">

(Schumacher) DC.

</td>
<td style="text-align:right;">

793

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Adiantum tetraphyllum

</td>
<td style="text-align:left;">

Humb. & Bonpl. ex Willd. 1810

</td>
<td style="text-align:right;">

793

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Aedeomyia squamipennis

</td>
<td style="text-align:left;">

(Lynch Arribálzaga, 1878)

</td>
<td style="text-align:right;">

795

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Aegidinus candezei

</td>
<td style="text-align:left;">

(Preudhomme de Borre, 1886)

</td>
<td style="text-align:right;">

1433

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Aegiphila integrifolia

</td>
<td style="text-align:left;">

(Jacq.) B.D.

</td>
<td style="text-align:right;">

1434

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Aeschynomene sensitiva

</td>
<td style="text-align:left;">

Sw. 1788

</td>
<td style="text-align:right;">

1435

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Agalychnis terranova

</td>
<td style="text-align:left;">

Rivera, Duarte, Rueda & Daza, 2013

</td>
<td style="text-align:right;">

1436

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Agamia agami

</td>
<td style="text-align:left;">

Gmelin, 1789

</td>
<td style="text-align:right;">

1437

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Ageneiosus pardalis

</td>
<td style="text-align:left;">

Lütken, 1874

</td>
<td style="text-align:right;">

1438

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Alchornea glandulosa

</td>
<td style="text-align:left;">

Poepp.

</td>
<td style="text-align:right;">

798

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Alchornea triplinervia

</td>
<td style="text-align:left;">

(Spreng.) Müll. Arg.

</td>
<td style="text-align:right;">

798

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Alchorneopsis floribunda

</td>
<td style="text-align:left;">

(Benth.) Müll. Arg.

</td>
<td style="text-align:right;">

1439

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Allobates niputidea

</td>
<td style="text-align:left;">

Grant, Acosta & Rada, 2007

</td>
<td style="text-align:right;">

1440

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Allographa rhizicola

</td>
<td style="text-align:left;">

 (Fée) Lücking & Kalb

</td>
<td style="text-align:right;">

1441

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Allosmaitia strophius

</td>
<td style="text-align:left;">

(Godart, $$1824$$)

</td>
<td style="text-align:right;">

1442

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Alopoglossus festae

</td>
<td style="text-align:left;">

(Peracca, 1896)

</td>
<td style="text-align:right;">

1443

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Alternanthera albotomentosa

</td>
<td style="text-align:left;">

(L.) Blume

</td>
<td style="text-align:right;">

1444

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Alyxoria varia

</td>
<td style="text-align:left;">

(Pers.) Ertz & Tehler

</td>
<td style="text-align:right;">

1445

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Amaioua glomerulata

</td>
<td style="text-align:left;">

(Lam. ex Poir.) Delprete & C.H. Perss.

</td>
<td style="text-align:right;">

1446

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Amaioua guianensis

</td>
<td style="text-align:left;">

Aubl.

</td>
<td style="text-align:right;">

1446

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Amaranthus dubius

</td>
<td style="text-align:left;">

Mart. ex Thell.

</td>
<td style="text-align:right;">

1447

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Amazilia tzacatl

</td>
<td style="text-align:left;">

De la Llave, 1833

</td>
<td style="text-align:right;">

1448

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Amazona amazonica

</td>
<td style="text-align:left;">

Linnaeus, 1766

</td>
<td style="text-align:right;">

803

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Amazona farinosa

</td>
<td style="text-align:left;">

Boddaert, 1783

</td>
<td style="text-align:right;">

803

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Amazona ochrocephala

</td>
<td style="text-align:left;">

Gmelin, JF, 1788

</td>
<td style="text-align:right;">

803

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Ameiva ameiva

</td>
<td style="text-align:left;">

Linnaeus (1758)

</td>
<td style="text-align:right;">

1449

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Ameiva bifrontata

</td>
<td style="text-align:left;">

Cope, 1862

</td>
<td style="text-align:right;">

1449

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Amphilophium crucigerum

</td>
<td style="text-align:left;">

(L.) L.G. Lohmann

</td>
<td style="text-align:right;">

1450

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Amphisbaena fuliginosa

</td>
<td style="text-align:left;">

Linnaeus, 1758

</td>
<td style="text-align:right;">

1451

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Anacardium excelsum

</td>
<td style="text-align:left;">

(Bertero & Balb. ex Kunth) Skeels

</td>
<td style="text-align:right;">

1452

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Anartia amathea

</td>
<td style="text-align:left;">

(Linnaeus, 1758)

</td>
<td style="text-align:right;">

1453

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Anartia jatrophae

</td>
<td style="text-align:left;">

(Linnaeus, 1763)

</td>
<td style="text-align:right;">

1453

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Anastrus neaeris

</td>
<td style="text-align:left;">

(Möschler, 1879)

</td>
<td style="text-align:right;">

1454

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Anatrytone mella

</td>
<td style="text-align:left;">

(Godman, 1900)

</td>
<td style="text-align:right;">

1455

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Ancistrus caucanus

</td>
<td style="text-align:left;">

Fowler, 1943

</td>
<td style="text-align:right;">

1456

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Andinoacara latifrons

</td>
<td style="text-align:left;">

(Steindachner, 1878)

</td>
<td style="text-align:right;">

1458

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Anhinga anhinga

</td>
<td style="text-align:left;">

Linnaeus, 1766

</td>
<td style="text-align:right;">

1459

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Aniba riparia

</td>
<td style="text-align:left;">

(Nees) Mez

</td>
<td style="text-align:right;">

1460

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Annona glabra

</td>
<td style="text-align:left;">

12. 

</td>
<td style="text-align:right;">

814

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Annona mucosa

</td>
<td style="text-align:left;">

Diels

</td>
<td style="text-align:right;">

814

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Anochetus diegensis

</td>
<td style="text-align:left;">

Forel, 1912

</td>
<td style="text-align:right;">

1461

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Anolis auratus

</td>
<td style="text-align:left;">

(Daudin, 1802)

</td>
<td style="text-align:right;">

1462

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Anolis tropidogaster

</td>
<td style="text-align:left;">

(Hallowell, 1856)

</td>
<td style="text-align:right;">

1462

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Anteros carausius

</td>
<td style="text-align:left;">

Westwood, 1851

</td>
<td style="text-align:right;">

1463

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Anthanassa drusilla

</td>
<td style="text-align:left;">

(C. Felder & R. Felder, 1861)

</td>
<td style="text-align:right;">

1464

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Anthracothorax nigricollis

</td>
<td style="text-align:left;">

Vieillot, 1817,

</td>
<td style="text-align:right;">

1465

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Anthurium clavigerum

</td>
<td style="text-align:left;">

Poepp.

</td>
<td style="text-align:right;">

818

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Anthurium glaucospadix

</td>
<td style="text-align:left;">

Croat

</td>
<td style="text-align:right;">

818

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Antigonus erosus

</td>
<td style="text-align:left;">

(Hübner, $$1812$$)

</td>
<td style="text-align:right;">

1466

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Anurolimnas viridis

</td>
<td style="text-align:left;">

Statius Muller, 1776

</td>
<td style="text-align:right;">

1467

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Apeiba glabra

</td>
<td style="text-align:left;">

Aubl.

</td>
<td style="text-align:right;">

1468

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Apeiba membranacea

</td>
<td style="text-align:left;">

Spruce ex Benth.

</td>
<td style="text-align:right;">

1468

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Apteronotus mariae

</td>
<td style="text-align:left;">

Eigenmann & Fisher, 1914

</td>
<td style="text-align:right;">

1469

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Apteronotus milesi

</td>
<td style="text-align:left;">

de Santana & Maldonado-Ocampo, 2005

</td>
<td style="text-align:right;">

1469

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Apterostigma dentigerum

</td>
<td style="text-align:left;">

Wheeler, 1925

</td>
<td style="text-align:right;">

1470

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Apterostigma manni

</td>
<td style="text-align:left;">

Weber, 1938

</td>
<td style="text-align:right;">

1470

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Apterostigma mayri

</td>
<td style="text-align:left;">

Forel, 1893

</td>
<td style="text-align:right;">

1470

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Ara ararauna

</td>
<td style="text-align:left;">

Linnaeus, 1758

</td>
<td style="text-align:right;">

1471

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Aramides cajaneus

</td>
<td style="text-align:left;">

Statius Muller, 1776

</td>
<td style="text-align:right;">

1472

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Aramus guarauna

</td>
<td style="text-align:left;">

Linnaeus, 1766

</td>
<td style="text-align:right;">

1473

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Arawacus lincoides

</td>
<td style="text-align:left;">

(Draudt, 1917)

</td>
<td style="text-align:right;">

1474

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Arcas imperialis

</td>
<td style="text-align:left;">

(Cramer, 1775)

</td>
<td style="text-align:right;">

1475

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Arcella dentata

</td>
<td style="text-align:left;">

Ehrenberg, 1832

</td>
<td style="text-align:right;">

822

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Archilejeunea juliformis

</td>
<td style="text-align:left;">

(Nees) Gradst.

</td>
<td style="text-align:right;">

1477

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Ardea alba

</td>
<td style="text-align:left;">

Linnaeus, 1758

</td>
<td style="text-align:right;">

1478

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Ardea cocoi

</td>
<td style="text-align:left;">

Linnaeus, 1766

</td>
<td style="text-align:right;">

1478

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Argon lota

</td>
<td style="text-align:left;">

(Hewitson, 1877)

</td>
<td style="text-align:right;">

1479

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Argopleura magdalenensis

</td>
<td style="text-align:left;">

(Eigenmann, 1913)

</td>
<td style="text-align:right;">

1480

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Arlea lucifuga

</td>
<td style="text-align:left;">

(Arlé, 1939) Womersley, 1939

</td>
<td style="text-align:right;">

1481

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Arlea spinisetis

</td>
<td style="text-align:left;">

Mendonça & Arlé, 1987

</td>
<td style="text-align:right;">

1481

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Arthonia catenatula

</td>
<td style="text-align:left;">

Nyl.

</td>
<td style="text-align:right;">

1482

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Arthonia platygraphidea

</td>
<td style="text-align:left;">

Nyl.

</td>
<td style="text-align:right;">

1482

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Artibeus anderseni

</td>
<td style="text-align:left;">

(Osgood, 1916)

</td>
<td style="text-align:right;">

827

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Artibeus glaucus

</td>
<td style="text-align:left;">

(Thomas, 1893)

</td>
<td style="text-align:right;">

827

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Artibeus jamaicensis

</td>
<td style="text-align:left;">

Leach, 1821

</td>
<td style="text-align:right;">

827

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Artibeus lituratus

</td>
<td style="text-align:left;">

(Olfers, 1818)

</td>
<td style="text-align:right;">

827

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Artibeus phaeotis

</td>
<td style="text-align:left;">

Leach, 1821

</td>
<td style="text-align:right;">

827

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Artibeus planirostris

</td>
<td style="text-align:left;">

(Spix, 1823)

</td>
<td style="text-align:right;">

827

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Artines aepitus

</td>
<td style="text-align:left;">

(Geyer, 1832)

</td>
<td style="text-align:right;">

1483

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Arundinicola leucocephala

</td>
<td style="text-align:left;">

Linnaeus, 1764

</td>
<td style="text-align:right;">

1484

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Ascia monuste

</td>
<td style="text-align:left;">

(Linnaeus, 1764)

</td>
<td style="text-align:right;">

1485

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Asio clamator

</td>
<td style="text-align:left;">

Vieillot, 1808

</td>
<td style="text-align:right;">

1486

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Aspidosperma desmanthum

</td>
<td style="text-align:left;">

Benth. ex Müll. Arg.

</td>
<td style="text-align:right;">

1487

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Astraptes enotrus

</td>
<td style="text-align:left;">

(Stoll, 1781)

</td>
<td style="text-align:right;">

1488

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Astrocaryum malybo

</td>
<td style="text-align:left;">

H. Karst.

</td>
<td style="text-align:right;">

1489

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Astrochapsa lassae

</td>
<td style="text-align:left;">

(Mangold) Parnmen, Lücking & Lumbsch

</td>
<td style="text-align:right;">

1490

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Astrothelium megaspermum

</td>
<td style="text-align:left;">

(Mont.) Aptroot & Lücking

</td>
<td style="text-align:right;">

831

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Astrothelium subscoria

</td>
<td style="text-align:left;">

Flakus & Aptroot

</td>
<td style="text-align:right;">

831

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:left;">

Astyanax filiferus

</td>
<td style="text-align:left;">

(Eigenmann, 1913)

</td>
<td style="text-align:right;">

832

</td>
<td style="text-align:left;">

SP

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

82 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

scientific_name_authorship

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
<th style="text-align:right;">

order_cases_in_name

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Abarema jupunba trapezifolia

</td>
<td style="text-align:left;">

(Vahl) Barneby & J.W. Grimes

</td>
<td style="text-align:right;">

2214

</td>
<td style="text-align:left;">

VAR

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Adelpha barnesia leucas

</td>
<td style="text-align:left;">

Fruhstorfer, 1915

</td>
<td style="text-align:right;">

3592

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

39

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Adelpha cytherea daguana

</td>
<td style="text-align:left;">

Fruhstorfer, 1913

</td>
<td style="text-align:right;">

3593

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

36

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Adelpha iphiclus iphiclus

</td>
<td style="text-align:left;">

(Linnaeus, 1758)

</td>
<td style="text-align:right;">

3594

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

26

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Adelpha melona deborah

</td>
<td style="text-align:left;">

Weeks, 1901

</td>
<td style="text-align:right;">

3597

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Adelpha phylaca pseudaethalia

</td>
<td style="text-align:left;">

A. Hall, 1938

</td>
<td style="text-align:right;">

3595

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Adelpha salmoneus emilia

</td>
<td style="text-align:left;">

Fruhstorfer, 1908

</td>
<td style="text-align:right;">

3596

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Ancyluris jurgensenii atahualpa

</td>
<td style="text-align:left;">

(Saunders, 1859)

</td>
<td style="text-align:right;">

3598

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

9

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Archaeoprepona demophon muson

</td>
<td style="text-align:left;">

(Fruhstorfer, 1905)

</td>
<td style="text-align:right;">

3599

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Archaeoprepona demophoon gulina

</td>
<td style="text-align:left;">

(Fruhstorfer, 1904)

</td>
<td style="text-align:right;">

3600

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

8

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Bactris gasipaes chichagui

</td>
<td style="text-align:left;">

(H. Karst.) A.J. Hend.

</td>
<td style="text-align:right;">

3601

</td>
<td style="text-align:left;">

VAR

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Baeotis zonata zonata

</td>
<td style="text-align:left;">

R. Felder, 1869

</td>
<td style="text-align:right;">

3602

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Caligo idomeneus idomenides

</td>
<td style="text-align:left;">

Fruhstorfer, 1903

</td>
<td style="text-align:right;">

3606

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Caligo illioneus oberon

</td>
<td style="text-align:left;">

A. Butler, 1870

</td>
<td style="text-align:right;">

3603

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

23

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Caligo oedipus oedipus

</td>
<td style="text-align:left;">

Stichel, 1903

</td>
<td style="text-align:right;">

3604

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

10

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Caligo telamonius menus

</td>
<td style="text-align:left;">

Fruhstorfer, 1903

</td>
<td style="text-align:right;">

3605

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

9

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Catoblepia berecynthia luxuriosus

</td>
<td style="text-align:left;">

Stichel, 1902

</td>
<td style="text-align:right;">

3607

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Catonephele numilia esite

</td>
<td style="text-align:left;">

(R. Felder, 1869)

</td>
<td style="text-align:right;">

3608

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

10

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Chiothion asychis simon

</td>
<td style="text-align:left;">

(Evans, 1953)

</td>
<td style="text-align:right;">

3609

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Consul fabius bogotanus

</td>
<td style="text-align:left;">

(A. Butler, 1874)

</td>
<td style="text-align:right;">

3610

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

15

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Dryas iulia iulia

</td>
<td style="text-align:left;">

(Fabricius, 1775)

</td>
<td style="text-align:right;">

3611

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

16

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Emesis fatimella nobilata

</td>
<td style="text-align:left;">

Stichel, 1910

</td>
<td style="text-align:right;">

3612

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

6

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Eresia eunice mechanitis

</td>
<td style="text-align:left;">

Godman & Salvin, 1878

</td>
<td style="text-align:right;">

3613

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

32

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Eueides isabella arquata

</td>
<td style="text-align:left;">

Stichel, 1903

</td>
<td style="text-align:right;">

3615

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Eueides lybia olympia

</td>
<td style="text-align:left;">

(Fabricius, 1793)

</td>
<td style="text-align:right;">

3614

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

10

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Eunica mygdonia mygdonia

</td>
<td style="text-align:left;">

(Godart, $$1824$$)

</td>
<td style="text-align:right;">

3616

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Euptychia westwoodi westwoodi

</td>
<td style="text-align:left;">

Butler, 1867

</td>
<td style="text-align:right;">

3617

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Eurema agave agave

</td>
<td style="text-align:left;">

(Cramer, 1775)

</td>
<td style="text-align:right;">

3619

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Eurema arbela gratiosa

</td>
<td style="text-align:left;">

(E. Doubleday, 1847)

</td>
<td style="text-align:right;">

3618

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Eurema daira lydia

</td>
<td style="text-align:left;">

(C. Felder & R. Felder, 1861)

</td>
<td style="text-align:right;">

3620

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Gallus gallus domesticus

</td>
<td style="text-align:left;">

Linnaeus, 1758

</td>
<td style="text-align:right;">

3621

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Gorgythion begga pyralina

</td>
<td style="text-align:left;">

(Möschler, 1877)

</td>
<td style="text-align:right;">

3622

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Hamadryas amphinome fumosa

</td>
<td style="text-align:left;">

(Fruhstorfer, 1915)

</td>
<td style="text-align:right;">

3624

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

33

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Hamadryas februa ferentina

</td>
<td style="text-align:left;">

(Godart, $$1824$$)

</td>
<td style="text-align:right;">

3625

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Hamadryas feronia farinulenta

</td>
<td style="text-align:left;">

(Fruhstorfer, 1916)

</td>
<td style="text-align:right;">

3623

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

100

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Hamadryas feronia farinulenta

</td>
<td style="text-align:left;">

farinulenta

</td>
<td style="text-align:right;">

3623

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Heliconius charithonia bassleri

</td>
<td style="text-align:left;">

W. Comstock & F. Brown, 1950

</td>
<td style="text-align:right;">

3631

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Heliconius erato hydara

</td>
<td style="text-align:left;">

(Hewitson, 1867)

</td>
<td style="text-align:right;">

3627

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

45

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Heliconius erato hydara

</td>
<td style="text-align:left;">

Hewitson, 1867

</td>
<td style="text-align:right;">

3627

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Heliconius hecale melicerta

</td>
<td style="text-align:left;">

H. Bates, 1866

</td>
<td style="text-align:right;">

3628

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

36

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Heliconius ismenius boulleti

</td>
<td style="text-align:left;">

Neustetter, 1928

</td>
<td style="text-align:right;">

3630

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Heliconius ismenius ismenius

</td>
<td style="text-align:left;">

Latreille, $$1817$$

</td>
<td style="text-align:right;">

3630

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

6

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Heliconius sapho sapho

</td>
<td style="text-align:left;">

(Drury, 1782)

</td>
<td style="text-align:right;">

3629

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

8

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Heliconius sara magdalena

</td>
<td style="text-align:left;">

H. Bates, 1864

</td>
<td style="text-align:right;">

3626

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

160

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Hemiargus hanno bogotana

</td>
<td style="text-align:left;">

Draudt, 1921 

</td>
<td style="text-align:right;">

3632

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Heraclides anchisiades idaeus

</td>
<td style="text-align:left;">

(Fabricius, 1793)

</td>
<td style="text-align:right;">

3634

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Heraclides thoas nealces

</td>
<td style="text-align:left;">

(Rothschild & Jordan, 1906)

</td>
<td style="text-align:right;">

3633

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

7

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Historis odius dious

</td>
<td style="text-align:left;">

Lamas, 1995

</td>
<td style="text-align:right;">

3635

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

48

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Itaballia demophile calydonia

</td>
<td style="text-align:left;">

(Boisduval, 1836)

</td>
<td style="text-align:right;">

3636

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Mechanitis polymnia veritabilis

</td>
<td style="text-align:left;">

A. Butler, 1873

</td>
<td style="text-align:right;">

3637

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

24

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Memphis acidalia memphis

</td>
<td style="text-align:left;">

(C. Felder & R. Felder, 1867)

</td>
<td style="text-align:right;">

3639

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Memphis moruus phila

</td>
<td style="text-align:left;">

(H. Druce, 1877)

</td>
<td style="text-align:right;">

3638

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

6

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Morpho helenor peleides

</td>
<td style="text-align:left;">

Kollar, 1850

</td>
<td style="text-align:right;">

3640

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

23

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Mysoria barcastus venezuelae

</td>
<td style="text-align:left;">

(Scudder, 1872)

</td>
<td style="text-align:right;">

3641

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Notheme erota diadema

</td>
<td style="text-align:left;">

Stichel, 1910

</td>
<td style="text-align:right;">

3642

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Nyctelius nyctelius nyctelius

</td>
<td style="text-align:left;">

(Latreille, $$1824$$)

</td>
<td style="text-align:right;">

3643

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Nymphidium caricae trinidadi

</td>
<td style="text-align:left;">

Callaghan, 1999

</td>
<td style="text-align:right;">

3644

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

12

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Opsiphanes cassina periphetes

</td>
<td style="text-align:left;">

Fruhstorfer, 1912

</td>
<td style="text-align:right;">

3645

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

365

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Opsiphanes quiteria badius

</td>
<td style="text-align:left;">

Stichel, 1902

</td>
<td style="text-align:right;">

3646

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

9

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Ouleus fridericus fridericus

</td>
<td style="text-align:left;">

(Geyer, 1832)

</td>
<td style="text-align:right;">

3647

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Panoquina ocola ocola

</td>
<td style="text-align:left;">

(W. H. Edwards, 1863)

</td>
<td style="text-align:right;">

3648

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Parides erithalion erithalion

</td>
<td style="text-align:left;">

(Boisduval, 1836)

</td>
<td style="text-align:right;">

3650

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Parides sesostris tarquinius

</td>
<td style="text-align:left;">

(Boisduval, 1836)

</td>
<td style="text-align:right;">

3649

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Paryphthimoides poltys numilia

</td>
<td style="text-align:left;">

(C. Felder & R. Felder, 1867)

</td>
<td style="text-align:right;">

3651

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

13

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Perrhybris pamela bogotana

</td>
<td style="text-align:left;">

(A. Butler, 1898)

</td>
<td style="text-align:right;">

3652

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Phoebis trite trite

</td>
<td style="text-align:left;">

(Linnaeus, 1758)

</td>
<td style="text-align:right;">

3653

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Pierella luna luna

</td>
<td style="text-align:left;">

(Fabricius, 1793)

</td>
<td style="text-align:right;">

3654

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

10

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Porphyrogenes calathana calathana

</td>
<td style="text-align:left;">

(Hewitson, 1868)

</td>
<td style="text-align:right;">

3655

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Prepona laertes amesia

</td>
<td style="text-align:left;">

Fruhstorfer, 1905

</td>
<td style="text-align:right;">

3656

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

8

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Prepona laertes louisa

</td>
<td style="text-align:left;">

A. Butler, 1870

</td>
<td style="text-align:right;">

3656

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

8

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Pyrrhogyra crameri undine

</td>
<td style="text-align:left;">

Bargmann, 1929

</td>
<td style="text-align:right;">

3657

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

20

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Pyrrhogyra neaerea kheili

</td>
<td style="text-align:left;">

Fruhstorfer, 1908

</td>
<td style="text-align:right;">

3658

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

16

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Pyrrhopyge phidias latifasciata

</td>
<td style="text-align:left;">

A. Butler, 1873

</td>
<td style="text-align:right;">

3660

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Pyrrhopyge thericles pseudophidias

</td>
<td style="text-align:left;">

E. Bell, 1931

</td>
<td style="text-align:right;">

3659

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Quadrus contubernalis contubernalis

</td>
<td style="text-align:left;">

(Mabille, 1883)

</td>
<td style="text-align:right;">

3661

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Selenophanes josephus excultus

</td>
<td style="text-align:left;">

Stichel, 1902

</td>
<td style="text-align:right;">

3662

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

15

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Siproeta stelenes biplagiata

</td>
<td style="text-align:left;">

(Fruhstorfer, 1907)

</td>
<td style="text-align:right;">

3663

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Stalachtis magdalena magdalena

</td>
<td style="text-align:left;">

(Westwood, $$1851$$)

</td>
<td style="text-align:right;">

3664

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

26

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Symmachia leena leena

</td>
<td style="text-align:left;">

Hewitson, 1870

</td>
<td style="text-align:right;">

3665

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Telegonus anaphus annetta

</td>
<td style="text-align:left;">

(Evans, 1952)

</td>
<td style="text-align:right;">

3666

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Telemiades antiope antiope

</td>
<td style="text-align:left;">

(Plötz, 1882)

</td>
<td style="text-align:right;">

3667

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Thracides cleanthes telmela

</td>
<td style="text-align:left;">

(Hewitson, 1866)

</td>
<td style="text-align:right;">

3668

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

8

</td>
<td style="text-align:right;">

1

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

4 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

scientific_name_authorship

</th>
<th style="text-align:right;">

cd_parent

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
<th style="text-align:right;">

order_cases_in_name

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Hamadryas feronia farinulenta

</td>
<td style="text-align:left;">

(Fruhstorfer, 1916)

</td>
<td style="text-align:right;">

3623

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

100

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Hamadryas feronia farinulenta

</td>
<td style="text-align:left;">

farinulenta

</td>
<td style="text-align:right;">

3623

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

Heliconius erato hydara

</td>
<td style="text-align:left;">

(Hewitson, 1867)

</td>
<td style="text-align:right;">

3627

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

45

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Heliconius erato hydara

</td>
<td style="text-align:left;">

Hewitson, 1867

</td>
<td style="text-align:right;">

3627

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

10 records

</caption>
<thead>
<tr>
<th style="text-align:right;">

cd_tax

</th>
<th style="text-align:left;">

name_tax

</th>
<th style="text-align:left;">

authorship

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

cd_parent

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">

1338

</td>
<td style="text-align:left;">

Spondylosium

</td>
<td style="text-align:left;">

Brébisson ex Kützing, 1849

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

282

</td>
</tr>
<tr>
<td style="text-align:right;">

2283

</td>
<td style="text-align:left;">

Aramides cajaneus

</td>
<td style="text-align:left;">

Statius Muller, 1776

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1472

</td>
</tr>
<tr>
<td style="text-align:right;">

3607

</td>
<td style="text-align:left;">

Catoblepia berecynthia

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1559

</td>
</tr>
<tr>
<td style="text-align:right;">

2000

</td>
<td style="text-align:left;">

Pierella

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

783

</td>
</tr>
<tr>
<td style="text-align:right;">

3552

</td>
<td style="text-align:left;">

Uroderma magnirostrum

</td>
<td style="text-align:left;">

Davis, 1968

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1404

</td>
</tr>
<tr>
<td style="text-align:right;">

371

</td>
<td style="text-align:left;">

Aramidae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

169

</td>
</tr>
<tr>
<td style="text-align:right;">

3237

</td>
<td style="text-align:left;">

Phyllostomus hastatus

</td>
<td style="text-align:left;">

(Pallas, 1767)

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1252

</td>
</tr>
<tr>
<td style="text-align:right;">

199

</td>
<td style="text-align:left;">

Neotaenioglossa

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

59

</td>
</tr>
<tr>
<td style="text-align:right;">

1517

</td>
<td style="text-align:left;">

Bubalus

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

391

</td>
</tr>
<tr>
<td style="text-align:right;">

3339

</td>
<td style="text-align:left;">

Rasopone minuta

</td>
<td style="text-align:left;">

(MacKay & MacKay, 2010)

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2060

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

12 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

VAR

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:right;">

78

</td>
</tr>
<tr>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1455

</td>
</tr>
<tr>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1427

</td>
</tr>
<tr>
<td style="text-align:left;">

TR

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

32

</td>
</tr>
<tr>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

489

</td>
</tr>
<tr>
<td style="text-align:left;">

SOR

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

185

</td>
</tr>
<tr>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

48

</td>
</tr>
<tr>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:right;">

24

</td>
</tr>
<tr>
<td style="text-align:left;">

KG

</td>
<td style="text-align:right;">

6

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

13 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

rank child

</th>
<th style="text-align:left;">

rank parent

</th>
<th style="text-align:right;">

number

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

VAR

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

78

</td>
</tr>
<tr>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1455

</td>
</tr>
<tr>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1228

</td>
</tr>
<tr>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:right;">

199

</td>
</tr>
<tr>
<td style="text-align:left;">

TR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

32

</td>
</tr>
<tr>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

489

</td>
</tr>
<tr>
<td style="text-align:left;">

SOR

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

185

</td>
</tr>
<tr>
<td style="text-align:left;">

CL

</td>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:right;">

48

</td>
</tr>
<tr>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:left;">

KG

</td>
<td style="text-align:right;">

24

</td>
</tr>
<tr>
<td style="text-align:left;">

KG

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

6

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

0 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

table_orig

</th>
<th style="text-align:left;">

row.names

</th>
<th style="text-align:right;">

count

</th>
</tr>
</thead>
<tbody>
<tr>
</tr>
</tbody>
</table>

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

<table>
<caption>

Displaying records 1 - 100

</caption>
<thead>
<tr>
<th style="text-align:right;">

cd_tax

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">

2939

</td>
</tr>
<tr>
<td style="text-align:right;">

2617

</td>
</tr>
<tr>
<td style="text-align:right;">

2617

</td>
</tr>
<tr>
<td style="text-align:right;">

2617

</td>
</tr>
<tr>
<td style="text-align:right;">

2939

</td>
</tr>
<tr>
<td style="text-align:right;">

2696

</td>
</tr>
<tr>
<td style="text-align:right;">

2696

</td>
</tr>
<tr>
<td style="text-align:right;">

2696

</td>
</tr>
<tr>
<td style="text-align:right;">

2696

</td>
</tr>
<tr>
<td style="text-align:right;">

2339

</td>
</tr>
<tr>
<td style="text-align:right;">

3395

</td>
</tr>
<tr>
<td style="text-align:right;">

2696

</td>
</tr>
<tr>
<td style="text-align:right;">

2550

</td>
</tr>
<tr>
<td style="text-align:right;">

2550

</td>
</tr>
<tr>
<td style="text-align:right;">

2617

</td>
</tr>
<tr>
<td style="text-align:right;">

2550

</td>
</tr>
<tr>
<td style="text-align:right;">

2939

</td>
</tr>
<tr>
<td style="text-align:right;">

2617

</td>
</tr>
<tr>
<td style="text-align:right;">

2617

</td>
</tr>
<tr>
<td style="text-align:right;">

2339

</td>
</tr>
<tr>
<td style="text-align:right;">

2550

</td>
</tr>
<tr>
<td style="text-align:right;">

2550

</td>
</tr>
<tr>
<td style="text-align:right;">

3394

</td>
</tr>
<tr>
<td style="text-align:right;">

2550

</td>
</tr>
<tr>
<td style="text-align:right;">

2550

</td>
</tr>
<tr>
<td style="text-align:right;">

2939

</td>
</tr>
<tr>
<td style="text-align:right;">

2623

</td>
</tr>
<tr>
<td style="text-align:right;">

3233

</td>
</tr>
<tr>
<td style="text-align:right;">

2623

</td>
</tr>
<tr>
<td style="text-align:right;">

3233

</td>
</tr>
<tr>
<td style="text-align:right;">

2623

</td>
</tr>
<tr>
<td style="text-align:right;">

2623

</td>
</tr>
<tr>
<td style="text-align:right;">

2623

</td>
</tr>
<tr>
<td style="text-align:right;">

2623

</td>
</tr>
<tr>
<td style="text-align:right;">

2623

</td>
</tr>
<tr>
<td style="text-align:right;">

2623

</td>
</tr>
<tr>
<td style="text-align:right;">

3233

</td>
</tr>
<tr>
<td style="text-align:right;">

2550

</td>
</tr>
<tr>
<td style="text-align:right;">

2550

</td>
</tr>
<tr>
<td style="text-align:right;">

2550

</td>
</tr>
<tr>
<td style="text-align:right;">

2550

</td>
</tr>
<tr>
<td style="text-align:right;">

3394

</td>
</tr>
<tr>
<td style="text-align:right;">

2696

</td>
</tr>
<tr>
<td style="text-align:right;">

2922

</td>
</tr>
<tr>
<td style="text-align:right;">

2340

</td>
</tr>
<tr>
<td style="text-align:right;">

2696

</td>
</tr>
<tr>
<td style="text-align:right;">

2920

</td>
</tr>
<tr>
<td style="text-align:right;">

2920

</td>
</tr>
<tr>
<td style="text-align:right;">

2550

</td>
</tr>
<tr>
<td style="text-align:right;">

3394

</td>
</tr>
<tr>
<td style="text-align:right;">

2550

</td>
</tr>
<tr>
<td style="text-align:right;">

2696

</td>
</tr>
<tr>
<td style="text-align:right;">

3394

</td>
</tr>
<tr>
<td style="text-align:right;">

2696

</td>
</tr>
<tr>
<td style="text-align:right;">

2922

</td>
</tr>
<tr>
<td style="text-align:right;">

2920

</td>
</tr>
<tr>
<td style="text-align:right;">

2920

</td>
</tr>
<tr>
<td style="text-align:right;">

3347

</td>
</tr>
<tr>
<td style="text-align:right;">

2617

</td>
</tr>
<tr>
<td style="text-align:right;">

2617

</td>
</tr>
<tr>
<td style="text-align:right;">

3394

</td>
</tr>
<tr>
<td style="text-align:right;">

2550

</td>
</tr>
<tr>
<td style="text-align:right;">

2939

</td>
</tr>
<tr>
<td style="text-align:right;">

2939

</td>
</tr>
<tr>
<td style="text-align:right;">

3416

</td>
</tr>
<tr>
<td style="text-align:right;">

3416

</td>
</tr>
<tr>
<td style="text-align:right;">

3289

</td>
</tr>
<tr>
<td style="text-align:right;">

2550

</td>
</tr>
<tr>
<td style="text-align:right;">

2550

</td>
</tr>
<tr>
<td style="text-align:right;">

2920

</td>
</tr>
<tr>
<td style="text-align:right;">

2696

</td>
</tr>
<tr>
<td style="text-align:right;">

3395

</td>
</tr>
<tr>
<td style="text-align:right;">

3348

</td>
</tr>
<tr>
<td style="text-align:right;">

2696

</td>
</tr>
<tr>
<td style="text-align:right;">

2696

</td>
</tr>
<tr>
<td style="text-align:right;">

2696

</td>
</tr>
<tr>
<td style="text-align:right;">

2696

</td>
</tr>
<tr>
<td style="text-align:right;">

2696

</td>
</tr>
<tr>
<td style="text-align:right;">

2696

</td>
</tr>
<tr>
<td style="text-align:right;">

2696

</td>
</tr>
<tr>
<td style="text-align:right;">

2339

</td>
</tr>
<tr>
<td style="text-align:right;">

2339

</td>
</tr>
<tr>
<td style="text-align:right;">

2920

</td>
</tr>
<tr>
<td style="text-align:right;">

2922

</td>
</tr>
<tr>
<td style="text-align:right;">

2339

</td>
</tr>
<tr>
<td style="text-align:right;">

2623

</td>
</tr>
<tr>
<td style="text-align:right;">

2920

</td>
</tr>
<tr>
<td style="text-align:right;">

2920

</td>
</tr>
<tr>
<td style="text-align:right;">

2922

</td>
</tr>
<tr>
<td style="text-align:right;">

2623

</td>
</tr>
<tr>
<td style="text-align:right;">

2623

</td>
</tr>
<tr>
<td style="text-align:right;">

2623

</td>
</tr>
<tr>
<td style="text-align:right;">

2623

</td>
</tr>
<tr>
<td style="text-align:right;">

2623

</td>
</tr>
<tr>
<td style="text-align:right;">

2623

</td>
</tr>
<tr>
<td style="text-align:right;">

2623

</td>
</tr>
<tr>
<td style="text-align:right;">

2920

</td>
</tr>
<tr>
<td style="text-align:right;">

2339

</td>
</tr>
<tr>
<td style="text-align:right;">

2339

</td>
</tr>
<tr>
<td style="text-align:right;">

2920

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

Displaying records 1 - 100

</caption>
<thead>
<tr>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

identification_qualifier

</th>
<th style="text-align:left;">

identification_remarks

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Xylopia aromatica

</td>
<td style="text-align:left;">

cf. aromatica

</td>
<td style="text-align:left;">

Xilopia cf. aromatica

</td>
</tr>
<tr>
<td style="text-align:left;">

Lacmellea edulis

</td>
<td style="text-align:left;">

cf. edulis

</td>
<td style="text-align:left;">

Lacmellea cf. edulis

</td>
</tr>
<tr>
<td style="text-align:left;">

Eschweilera coriacea

</td>
<td style="text-align:left;">

cf. coriacea

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:left;">

Eschweilera coriacea

</td>
<td style="text-align:left;">

cf. coriacea

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:left;">

Lacmellea edulis

</td>
<td style="text-align:left;">

cf. edulis

</td>
<td style="text-align:left;">

Lacmellea cf. edulis

</td>
</tr>
<tr>
<td style="text-align:left;">

Schefflera morototoni

</td>
<td style="text-align:left;">

cf. morototoni

</td>
<td style="text-align:left;">

Schefflera cf. morototoni

</td>
</tr>
<tr>
<td style="text-align:left;">

Lacmellea edulis

</td>
<td style="text-align:left;">

cf. edulis

</td>
<td style="text-align:left;">

Lacmellea cf. edulis

</td>
</tr>
<tr>
<td style="text-align:left;">

Tapirira guianensis

</td>
<td style="text-align:left;">

cf. Tapirira

</td>
<td style="text-align:left;">

cf. Tapirira (N.C Goyo mojoso)

</td>
</tr>
<tr>
<td style="text-align:left;">

Schefflera morototoni

</td>
<td style="text-align:left;">

cf. Morototoni

</td>
<td style="text-align:left;">

Schefflera cf. morototoni (N.C mano de tigre)

</td>
</tr>
<tr>
<td style="text-align:left;">

Tapirira guianensis

</td>
<td style="text-align:left;">

cf. Tapirira

</td>
<td style="text-align:left;">

cf. Tapirira (N.C Goyo mojoso)

</td>
</tr>
<tr>
<td style="text-align:left;">

Tapirira guianensis

</td>
<td style="text-align:left;">

cf. Tapirira

</td>
<td style="text-align:left;">

cf. Tapirira (N.C Goyo mojoso)

</td>
</tr>
<tr>
<td style="text-align:left;">

Tapirira guianensis

</td>
<td style="text-align:left;">

cf. Tapirira

</td>
<td style="text-align:left;">

cf. Tapirira (N.C Goyo mojoso)

</td>
</tr>
<tr>
<td style="text-align:left;">

Tapirira guianensis

</td>
<td style="text-align:left;">

cf. Tapirira

</td>
<td style="text-align:left;">

cf. Tapirira (N.C Goyo mojoso)

</td>
</tr>
<tr>
<td style="text-align:left;">

Schefflera morototoni

</td>
<td style="text-align:left;">

cf. morototoni

</td>
<td style="text-align:left;">

Schefflera cf. morototoni

</td>
</tr>
<tr>
<td style="text-align:left;">

Tapirira guianensis

</td>
<td style="text-align:left;">

cf. guianensis

</td>
<td style="text-align:left;">

Tapirira cf. guianensis N.C Fresno

</td>
</tr>
<tr>
<td style="text-align:left;">

Xylopia aromatica

</td>
<td style="text-align:left;">

cf. aromatica

</td>
<td style="text-align:left;">

Xylopia cf. aromatica (N.C Escobillo)

</td>
</tr>
<tr>
<td style="text-align:left;">

Chrysophyllum colombianum

</td>
<td style="text-align:left;">

cf. colombianum

</td>
<td style="text-align:left;">

N.C Coco cristal

</td>
</tr>
<tr>
<td style="text-align:left;">

Tapirira guianensis

</td>
<td style="text-align:left;">

cf. Tapirira

</td>
<td style="text-align:left;">

cf. Tapirira (N.C Goyo mojoso)

</td>
</tr>
<tr>
<td style="text-align:left;">

Chrysophyllum colombianum

</td>
<td style="text-align:left;">

cf. colombianum

</td>
<td style="text-align:left;">

N.C Coco cristal

</td>
</tr>
<tr>
<td style="text-align:left;">

Chrysophyllum colombianum

</td>
<td style="text-align:left;">

cf. colombianum

</td>
<td style="text-align:left;">

N.C Coco cristal

</td>
</tr>
<tr>
<td style="text-align:left;">

Tapirira guianensis

</td>
<td style="text-align:left;">

cf. Tapirira

</td>
<td style="text-align:left;">

cf. Tapirira (N.C Goyo mojoso)

</td>
</tr>
<tr>
<td style="text-align:left;">

Schefflera morototoni

</td>
<td style="text-align:left;">

cf. morototoni

</td>
<td style="text-align:left;">

Schefflera cf. morototoni

</td>
</tr>
<tr>
<td style="text-align:left;">

Schefflera morototoni

</td>
<td style="text-align:left;">

cf. morototoni

</td>
<td style="text-align:left;">

Schefflera cf. morototoni (N.C Mano de león)

</td>
</tr>
<tr>
<td style="text-align:left;">

Tapirira guianensis

</td>
<td style="text-align:left;">

cf. Tapirira

</td>
<td style="text-align:left;">

cf. Trapira (N.C Fresno)

</td>
</tr>
<tr>
<td style="text-align:left;">

Tapirira guianensis

</td>
<td style="text-align:left;">

cf. Tapirira

</td>
<td style="text-align:left;">

cf. Trapira (N.C Fresno)

</td>
</tr>
<tr>
<td style="text-align:left;">

Pouteria trilocularis

</td>
<td style="text-align:left;">

cf. trilocularis

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:left;">

Schefflera morototoni

</td>
<td style="text-align:left;">

cf. morototoni

</td>
<td style="text-align:left;">

Schefflera cf. morototoni

</td>
</tr>
<tr>
<td style="text-align:left;">

Xylopia aromatica

</td>
<td style="text-align:left;">

cf. aromatica

</td>
<td style="text-align:left;">

Xylopia cf. aromatica

</td>
</tr>
<tr>
<td style="text-align:left;">

Xylopia aromatica

</td>
<td style="text-align:left;">

cf. aromatica

</td>
<td style="text-align:left;">

Xylopia cf. aromatica

</td>
</tr>
<tr>
<td style="text-align:left;">

Eschweilera coriacea

</td>
<td style="text-align:left;">

cf. coriacea

</td>
<td style="text-align:left;">

Lecythis 1

</td>
</tr>
<tr>
<td style="text-align:left;">

Matayba elegans

</td>
<td style="text-align:left;">

cf. elegans

</td>
<td style="text-align:left;">

Matayba 1

</td>
</tr>
<tr>
<td style="text-align:left;">

Matayba elegans

</td>
<td style="text-align:left;">

cf. elegans

</td>
<td style="text-align:left;">

Matayba 1

</td>
</tr>
<tr>
<td style="text-align:left;">

Ormosia colombiana

</td>
<td style="text-align:left;">

cf. colombiana

</td>
<td style="text-align:left;">

\_

</td>
</tr>
<tr>
<td style="text-align:left;">

Couepia chrysocalyx

</td>
<td style="text-align:left;">

cf. chrysocalyx

</td>
<td style="text-align:left;">

\_

</td>
</tr>
<tr>
<td style="text-align:left;">

Couepia chrysocalyx

</td>
<td style="text-align:left;">

cf. chrysocalyx

</td>
<td style="text-align:left;">

\_

</td>
</tr>
<tr>
<td style="text-align:left;">

Couepia chrysocalyx

</td>
<td style="text-align:left;">

cf. chrysocalyx

</td>
<td style="text-align:left;">

\_

</td>
</tr>
<tr>
<td style="text-align:left;">

Couepia chrysocalyx

</td>
<td style="text-align:left;">

cf. chrysocalyx

</td>
<td style="text-align:left;">

\_

</td>
</tr>
<tr>
<td style="text-align:left;">

Ficus francoae

</td>
<td style="text-align:left;">

cf. francoae

</td>
<td style="text-align:left;">

Exudado blanco claro. Corteza rugosa

</td>
</tr>
<tr>
<td style="text-align:left;">

Eschweilera coriacea

</td>
<td style="text-align:left;">

cf. coriacea

</td>
<td style="text-align:left;">

NC Coco

</td>
</tr>
<tr>
<td style="text-align:left;">

Pouteria trilocularis

</td>
<td style="text-align:left;">

cf. trilocularis

</td>
<td style="text-align:left;">

\_

</td>
</tr>
<tr>
<td style="text-align:left;">

Pouteria trilocularis

</td>
<td style="text-align:left;">

cf. trilocularis

</td>
<td style="text-align:left;">

Exudado blanco

</td>
</tr>
<tr>
<td style="text-align:left;">

Herrania nitida

</td>
<td style="text-align:left;">

cf. nitida

</td>
<td style="text-align:left;">

Cacao de monte

</td>
</tr>
<tr>
<td style="text-align:left;">

Herrania nitida

</td>
<td style="text-align:left;">

cf. nitida

</td>
<td style="text-align:left;">

Cacao de monte

</td>
</tr>
<tr>
<td style="text-align:left;">

Herrania nitida

</td>
<td style="text-align:left;">

cf. nitida

</td>
<td style="text-align:left;">

Cacao de monte

</td>
</tr>
<tr>
<td style="text-align:left;">

Herrania nitida

</td>
<td style="text-align:left;">

cf. nitida

</td>
<td style="text-align:left;">

Cacao de monte

</td>
</tr>
<tr>
<td style="text-align:left;">

Pouteria trilocularis

</td>
<td style="text-align:left;">

cf. trilocularis

</td>
<td style="text-align:left;">

Látexblanco. Corteza amarilla

</td>
</tr>
<tr>
<td style="text-align:left;">

Rinorea falcata

</td>
<td style="text-align:left;">

cf. falcata

</td>
<td style="text-align:left;">

\_

</td>
</tr>
<tr>
<td style="text-align:left;">

Eschweilera coriacea

</td>
<td style="text-align:left;">

cf. coriacea

</td>
<td style="text-align:left;">

NC: Coco

</td>
</tr>
<tr>
<td style="text-align:left;">

Ficus citrifolia

</td>
<td style="text-align:left;">

cf. citrifolia

</td>
<td style="text-align:left;">

Ficus sp

</td>
</tr>
<tr>
<td style="text-align:left;">

Matayba elegans

</td>
<td style="text-align:left;">

cf. elegans

</td>
<td style="text-align:left;">

\_

</td>
</tr>
<tr>
<td style="text-align:left;">

Matayba elegans

</td>
<td style="text-align:left;">

cf. elegans

</td>
<td style="text-align:left;">

\_

</td>
</tr>
<tr>
<td style="text-align:left;">

Eschweilera coriacea

</td>
<td style="text-align:left;">

cf. coriacea

</td>
<td style="text-align:left;">

Forófito 3

</td>
</tr>
<tr>
<td style="text-align:left;">

Eschweilera coriacea

</td>
<td style="text-align:left;">

cf. coriacea

</td>
<td style="text-align:left;">

\_

</td>
</tr>
<tr>
<td style="text-align:left;">

Citrus aurantium

</td>
<td style="text-align:left;">

Híbrido

</td>
<td style="text-align:left;">

Critrus sp Toronja

</td>
</tr>
<tr>
<td style="text-align:left;">

Citrus aurantium

</td>
<td style="text-align:left;">

Híbrido

</td>
<td style="text-align:left;">

Critrus sp Toronja

</td>
</tr>
<tr>
<td style="text-align:left;">

Matayba elegans

</td>
<td style="text-align:left;">

cf. elegans

</td>
<td style="text-align:left;">

Mamoncillo

</td>
</tr>
<tr>
<td style="text-align:left;">

Citrus aurantium

</td>
<td style="text-align:left;">

Híbrido

</td>
<td style="text-align:left;">

Citrus sp Toronja

</td>
</tr>
<tr>
<td style="text-align:left;">

Citrus aurantium

</td>
<td style="text-align:left;">

Híbrido

</td>
<td style="text-align:left;">

Citrus sp Toronja

</td>
</tr>
<tr>
<td style="text-align:left;">

Citrus aurantium

</td>
<td style="text-align:left;">

Híbrido

</td>
<td style="text-align:left;">

Citrus sp Toronja

</td>
</tr>
<tr>
<td style="text-align:left;">

Citrus aurantium

</td>
<td style="text-align:left;">

Híbrido

</td>
<td style="text-align:left;">

Citrus sp Toronja

</td>
</tr>
<tr>
<td style="text-align:left;">

Eschweilera coriacea

</td>
<td style="text-align:left;">

cf. coriacea

</td>
<td style="text-align:left;">

\_

</td>
</tr>
<tr>
<td style="text-align:left;">

Matayba elegans

</td>
<td style="text-align:left;">

cf. elegans

</td>
<td style="text-align:left;">

\_

</td>
</tr>
<tr>
<td style="text-align:left;">

Matayba elegans

</td>
<td style="text-align:left;">

cf. elegans

</td>
<td style="text-align:left;">

\_

</td>
</tr>
<tr>
<td style="text-align:left;">

Ficus citrifolia

</td>
<td style="text-align:left;">

cf. citrifolia

</td>
<td style="text-align:left;">

Corteza roja. Látex blanco

</td>
</tr>
<tr>
<td style="text-align:left;">

Ficus citrifolia

</td>
<td style="text-align:left;">

cf. citrifolia

</td>
<td style="text-align:left;">

Látex blanco

</td>
</tr>
<tr>
<td style="text-align:left;">

Jacaranda caucana

</td>
<td style="text-align:left;">

cf obtusifolia

</td>
<td style="text-align:left;">

Jacaranda cf obtusifolia

</td>
</tr>
<tr>
<td style="text-align:left;">

Xylopia aromatica

</td>
<td style="text-align:left;">

cf amazonica

</td>
<td style="text-align:left;">

Xylopia cf amazonica

</td>
</tr>
<tr>
<td style="text-align:left;">

Eschweilera coriacea

</td>
<td style="text-align:left;">

cf. coriacea

</td>
<td style="text-align:left;">

\_

</td>
</tr>
<tr>
<td style="text-align:left;">

Eschweilera coriacea

</td>
<td style="text-align:left;">

cf. coriacea

</td>
<td style="text-align:left;">

\_

</td>
</tr>
<tr>
<td style="text-align:left;">

Pourouma bicolor

</td>
<td style="text-align:left;">

cf melinonii

</td>
<td style="text-align:left;">

Pourouma cf melinonii

</td>
</tr>
<tr>
<td style="text-align:left;">

Pourouma bicolor

</td>
<td style="text-align:left;">

cf melinonii

</td>
<td style="text-align:left;">

Pourouma cf melinonii

</td>
</tr>
<tr>
<td style="text-align:left;">

Pourouma bicolor

</td>
<td style="text-align:left;">

cf melinonii

</td>
<td style="text-align:left;">

Pourouma cf melinonii

</td>
</tr>
<tr>
<td style="text-align:left;">

Eschweilera coriacea

</td>
<td style="text-align:left;">

cf. coriacea

</td>
<td style="text-align:left;">

\_

</td>
</tr>
<tr>
<td style="text-align:left;">

Pouteria amygdalicarpa

</td>
<td style="text-align:left;">

cf. amygdalicarpa

</td>
<td style="text-align:left;">

\_

</td>
</tr>
<tr>
<td style="text-align:left;">

Jacaranda copaia

</td>
<td style="text-align:left;">

cf Jacaranda

</td>
<td style="text-align:left;">

Cabobira cf Jacaranda

</td>
</tr>
<tr>
<td style="text-align:left;">

Tapirira guianensis

</td>
<td style="text-align:left;">

cf. Tapirira

</td>
<td style="text-align:left;">

Cf Tapirira

</td>
</tr>
<tr>
<td style="text-align:left;">

Pouteria amygdalicarpa

</td>
<td style="text-align:left;">

cf. amygdalicarpa

</td>
<td style="text-align:left;">

\_

</td>
</tr>
<tr>
<td style="text-align:left;">

Pouteria amygdalicarpa

</td>
<td style="text-align:left;">

cf. amygdalicarpa

</td>
<td style="text-align:left;">

\_

</td>
</tr>
<tr>
<td style="text-align:left;">

Leonia racemosa

</td>
<td style="text-align:left;">

cf. racemosa

</td>
<td style="text-align:left;">

Corteza amarilla

</td>
</tr>
<tr>
<td style="text-align:left;">

Leonia racemosa

</td>
<td style="text-align:left;">

cf. racemosa

</td>
<td style="text-align:left;">

Margen dentada

</td>
</tr>
<tr>
<td style="text-align:left;">

Leonia racemosa

</td>
<td style="text-align:left;">

cf. racemosa

</td>
<td style="text-align:left;">

Margen dentada

</td>
</tr>
<tr>
<td style="text-align:left;">

Pouteria trilocularis

</td>
<td style="text-align:left;">

cf. trilocularis

</td>
<td style="text-align:left;">

Exudado blanco.

</td>
</tr>
<tr>
<td style="text-align:left;">

Hirtella americana

</td>
<td style="text-align:left;">

cf. americana

</td>
<td style="text-align:left;">

Corteza amarilla

</td>
</tr>
<tr>
<td style="text-align:left;">

Hirtella americana

</td>
<td style="text-align:left;">

cf. americana

</td>
<td style="text-align:left;">

Aromatica

</td>
</tr>
<tr>
<td style="text-align:left;">

Pouteria trilocularis

</td>
<td style="text-align:left;">

cf. trilocularis

</td>
<td style="text-align:left;">

Estípula ferrugínea y leche

</td>
</tr>
<tr>
<td style="text-align:left;">

Xylopia aromatica

</td>
<td style="text-align:left;">

cf amazonica

</td>
<td style="text-align:left;">

Xylopia cf amazonica Copillo 1

</td>
</tr>
<tr>
<td style="text-align:left;">

Gustavia dubia

</td>
<td style="text-align:left;">

cf. dubia

</td>
<td style="text-align:left;">

Saliaceae Peciolo alado

</td>
</tr>
<tr>
<td style="text-align:left;">

Gustavia dubia

</td>
<td style="text-align:left;">

cf. dubia

</td>
<td style="text-align:left;">

Peciolo alado

</td>
</tr>
<tr>
<td style="text-align:left;">

Gustavia dubia

</td>
<td style="text-align:left;">

cf. dubia

</td>
<td style="text-align:left;">

Peciolo alado

</td>
</tr>
<tr>
<td style="text-align:left;">

Cecropia peltata

</td>
<td style="text-align:left;">

cf peltata

</td>
<td style="text-align:left;">

Cecropia cf peltata

</td>
</tr>
<tr>
<td style="text-align:left;">

Cecropia peltata

</td>
<td style="text-align:left;">

cf peltata

</td>
<td style="text-align:left;">

Cecropia cf peltata

</td>
</tr>
<tr>
<td style="text-align:left;">

Cecropia peltata

</td>
<td style="text-align:left;">

cf peltata

</td>
<td style="text-align:left;">

Cecropia cf peltata

</td>
</tr>
<tr>
<td style="text-align:left;">

Ficus matiziana

</td>
<td style="text-align:left;">

cf maliziana

</td>
<td style="text-align:left;">

Ficus cf maliziana

</td>
</tr>
<tr>
<td style="text-align:left;">

Jacaranda caucana

</td>
<td style="text-align:left;">

cf. obtusifolia

</td>
<td style="text-align:left;">

Jacaranda cf. obtusifolia

</td>
</tr>
<tr>
<td style="text-align:left;">

Pouteria trilocularis

</td>
<td style="text-align:left;">

cf. trilocularis

</td>
<td style="text-align:left;">

Pouteria sp

</td>
</tr>
<tr>
<td style="text-align:left;">

Gustavia verticillata

</td>
<td style="text-align:left;">

cf. verticillata

</td>
<td style="text-align:left;">

Indeterminado

</td>
</tr>
<tr>
<td style="text-align:left;">

Caryocar amygdaliferum

</td>
<td style="text-align:left;">

cf amygdaliferum

</td>
<td style="text-align:left;">

Caryocar cf amygdaliferum

</td>
</tr>
<tr>
<td style="text-align:left;">

Caryocar amygdaliferum

</td>
<td style="text-align:left;">

cf amygdaliferum

</td>
<td style="text-align:left;">

Caryocar cf amygdaliferum

</td>
</tr>
<tr>
<td style="text-align:left;">

Caryocar amygdaliferum

</td>
<td style="text-align:left;">

cf amygdaliferum

</td>
<td style="text-align:left;">

Caryocar cf amygdaliferum

</td>
</tr>
<tr>
<td style="text-align:left;">

Chrysophyllum colombianum

</td>
<td style="text-align:left;">

cf. colombianum

</td>
<td style="text-align:left;">

Pouteria sp

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

Displaying records 1 - 100

</caption>
<thead>
<tr>
<th style="text-align:right;">

cd_tax

</th>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

identification_qualifier

</th>
<th style="text-align:left;">

identification_remarks

</th>
<th style="text-align:left;">

rank_tax

</th>
<th style="text-align:left;">

pseudo_rank

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">

1074

</td>
<td style="text-align:left;">

Inga

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Guamo blanco

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1134

</td>
<td style="text-align:left;">

Matayba

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

34

</td>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:left;">

sp. 4

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:left;">

OR

</td>
</tr>
<tr>
<td style="text-align:right;">

1074

</td>
<td style="text-align:left;">

Inga

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

Inga sp

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

866

</td>
<td style="text-align:left;">

Bunchosia

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Forofito 2

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1074

</td>
<td style="text-align:left;">

Inga

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

Guamo blanco

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1074

</td>
<td style="text-align:left;">

Inga

</td>
<td style="text-align:left;">

sp. 4

</td>
<td style="text-align:left;">

Guamo. Exudado rojo

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1074

</td>
<td style="text-align:left;">

Inga

</td>
<td style="text-align:left;">

sp. 4

</td>
<td style="text-align:left;">

Guamo rojo

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1074

</td>
<td style="text-align:left;">

Inga

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Guamo blanco

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1074

</td>
<td style="text-align:left;">

Inga

</td>
<td style="text-align:left;">

sp. 4

</td>
<td style="text-align:left;">

Guamo

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

863

</td>
<td style="text-align:left;">

Brosimum

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Ficus sp

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1009

</td>
<td style="text-align:left;">

Ficus

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Ficus

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1009

</td>
<td style="text-align:left;">

Ficus

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Ficus

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1009

</td>
<td style="text-align:left;">

Ficus

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Ficus

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1074

</td>
<td style="text-align:left;">

Inga

</td>
<td style="text-align:left;">

sp. 4

</td>
<td style="text-align:left;">

N.C Guamo

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1040

</td>
<td style="text-align:left;">

Helicostylis

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

N.C Yema de huevo

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1212

</td>
<td style="text-align:left;">

Ormosia

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

N.C yema de huevo

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1212

</td>
<td style="text-align:left;">

Ormosia

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Indet.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

34

</td>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Annona sp.

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:left;">

OR

</td>
</tr>
<tr>
<td style="text-align:right;">

34

</td>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

cf. Guazuma (N.C Guacimo)

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:left;">

OR

</td>
</tr>
<tr>
<td style="text-align:right;">

1074

</td>
<td style="text-align:left;">

Inga

</td>
<td style="text-align:left;">

sp. 4

</td>
<td style="text-align:left;">

Inga sp.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1074

</td>
<td style="text-align:left;">

Inga

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

N.C Guamo blanco

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1074

</td>
<td style="text-align:left;">

Inga

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

N.C Guamo blanco

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1074

</td>
<td style="text-align:left;">

Inga

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

Inga sp.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1074

</td>
<td style="text-align:left;">

Inga

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

Inga sp.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1074

</td>
<td style="text-align:left;">

Inga

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

Inga sp.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1074

</td>
<td style="text-align:left;">

Inga

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

Inga sp.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1074

</td>
<td style="text-align:left;">

Inga

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Guamo blanco

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1074

</td>
<td style="text-align:left;">

Inga

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

Inga sp.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1074

</td>
<td style="text-align:left;">

Inga

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

Inga sp.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1074

</td>
<td style="text-align:left;">

Inga

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Guamo blanco

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1074

</td>
<td style="text-align:left;">

Inga

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Guamo blanco

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1074

</td>
<td style="text-align:left;">

Inga

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

Guamo negro

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1028

</td>
<td style="text-align:left;">

Gustavia

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Exudado blanco

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

305

</td>
<td style="text-align:left;">

Lauraceae

</td>
<td style="text-align:left;">

sp. 4

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:right;">

1134

</td>
<td style="text-align:left;">

Matayba

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Con muestra

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

918

</td>
<td style="text-align:left;">

Cordia

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1074

</td>
<td style="text-align:left;">

Inga

</td>
<td style="text-align:left;">

sp. 4

</td>
<td style="text-align:left;">

Inga sp

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

863

</td>
<td style="text-align:left;">

Brosimum

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Exudado blanco

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

863

</td>
<td style="text-align:left;">

Brosimum

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

34

</td>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:left;">

sp. 3

</td>
<td style="text-align:left;">

R. tabloides látex café con leche

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:left;">

OR

</td>
</tr>
<tr>
<td style="text-align:right;">

863

</td>
<td style="text-align:left;">

Brosimum

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Látex blanco

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1278

</td>
<td style="text-align:left;">

Protium

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Látex café con leche

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

34

</td>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:left;">

sp. 4

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:left;">

OR

</td>
</tr>
<tr>
<td style="text-align:right;">

34

</td>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:left;">

sp. 4

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:left;">

OR

</td>
</tr>
<tr>
<td style="text-align:right;">

863

</td>
<td style="text-align:left;">

Brosimum

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1091

</td>
<td style="text-align:left;">

Lacmellea

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Byrsomma

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1091

</td>
<td style="text-align:left;">

Lacmellea

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Byrsomma

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

863

</td>
<td style="text-align:left;">

Brosimum

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Con látex

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

34

</td>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:left;">

sp. 4

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:left;">

OR

</td>
</tr>
<tr>
<td style="text-align:right;">

1311

</td>
<td style="text-align:left;">

Salacia

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

330

</td>
<td style="text-align:left;">

Rubiaceae

</td>
<td style="text-align:left;">

sp. 4

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:right;">

34

</td>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:left;">

sp. 5

</td>
<td style="text-align:left;">

Hojas largas suaves con flores

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:left;">

OR

</td>
</tr>
<tr>
<td style="text-align:right;">

34

</td>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:left;">

sp. 5

</td>
<td style="text-align:left;">

Hojas largas con flores.

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:left;">

OR

</td>
</tr>
<tr>
<td style="text-align:right;">

34

</td>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:left;">

sp. 5

</td>
<td style="text-align:left;">

Hojas largas con flores.

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:left;">

OR

</td>
</tr>
<tr>
<td style="text-align:right;">

34

</td>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:left;">

sp. 5

</td>
<td style="text-align:left;">

Hojas largas con flores.

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:left;">

OR

</td>
</tr>
<tr>
<td style="text-align:right;">

1223

</td>
<td style="text-align:left;">

Palicourea

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

330

</td>
<td style="text-align:left;">

Rubiaceae

</td>
<td style="text-align:left;">

sp. 10

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:right;">

34

</td>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:left;">

sp. 6

</td>
<td style="text-align:left;">

Látex transparente

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:left;">

OR

</td>
</tr>
<tr>
<td style="text-align:right;">

34

</td>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:left;">

sp. 6

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:left;">

OR

</td>
</tr>
<tr>
<td style="text-align:right;">

34

</td>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:left;">

sp. 7

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:left;">

OR

</td>
</tr>
<tr>
<td style="text-align:right;">

986

</td>
<td style="text-align:left;">

Endlicheria

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1229

</td>
<td style="text-align:left;">

Parkia

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1278

</td>
<td style="text-align:left;">

Protium

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1229

</td>
<td style="text-align:left;">

Parkia

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1074

</td>
<td style="text-align:left;">

Inga

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Inga sp

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1074

</td>
<td style="text-align:left;">

Inga

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Inga sp

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1278

</td>
<td style="text-align:left;">

Protium

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Violaceae ?

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1254

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1254

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1254

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1254

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1254

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1254

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1254

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1254

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1254

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1254

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1254

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1254

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

986

</td>
<td style="text-align:left;">

Endlicheria

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1254

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1254

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1254

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

885

</td>
<td style="text-align:left;">

Cecropia

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Cecropia peltata

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1091

</td>
<td style="text-align:left;">

Lacmellea

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

f3

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

289

</td>
<td style="text-align:left;">

Euphorbiaceae

</td>
<td style="text-align:left;">

sp. 4

</td>
<td style="text-align:left;">

f1

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:right;">

1254

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

885

</td>
<td style="text-align:left;">

Cecropia

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Cecropia

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

885

</td>
<td style="text-align:left;">

Cecropia

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Cecropia

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

885

</td>
<td style="text-align:left;">

Cecropia

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Cecropia

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1254

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

Piper

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

797

</td>
<td style="text-align:left;">

Aiouea

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

Corteza amarilla

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

799

</td>
<td style="text-align:left;">

Allophyllus

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Corteza amarilla

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1278

</td>
<td style="text-align:left;">

Protium

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Prunus? Corteza amarilla

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

799

</td>
<td style="text-align:left;">

Allophyllus

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Trifoliada olor agradable

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

305

</td>
<td style="text-align:left;">

Lauraceae

</td>
<td style="text-align:left;">

sp. 9

</td>
<td style="text-align:left;">

Hojas aromáticas Corteza lisa

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
</tr>
<tr>
<td style="text-align:right;">

1057

</td>
<td style="text-align:left;">

Hieronyma

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Hojas aromáticas . Olor a pimienta

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1057

</td>
<td style="text-align:left;">

Hieronyma

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Hojas aromáticas. Corteza lisa. Olor a pimienta

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
<tr>
<td style="text-align:right;">

1057

</td>
<td style="text-align:left;">

Hieronyma

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

Hojas aromáticas. Corteza lisa. Olor a pimienta

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

2 records

</caption>
<thead>
<tr>
<th style="text-align:right;">

cd_tax

</th>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

identification_qualifier

</th>
<th style="text-align:left;">

pseudo_rank

</th>
<th style="text-align:right;">

count

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">

1169

</td>
<td style="text-align:left;">

Monstera

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

12

</td>
</tr>
<tr>
<td style="text-align:right;">

1247

</td>
<td style="text-align:left;">

Philodendron

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
</tr>
</tbody>
</table>

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
<table>
<caption>

Displaying records 1 - 100

</caption>
<thead>
<tr>
<th style="text-align:right;">

cd_tax

</th>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

identification_qualifier

</th>
<th style="text-align:left;">

identification_remarks

</th>
<th style="text-align:left;">

pseudo_rank

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">

2238

</td>
<td style="text-align:left;">

Allographa rhizicola

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

- `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  ERROR_RANK `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` SP `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 15 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:right;">` 2238 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` Allographa rhizicola
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` M10
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  ERROR_RANK `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` SP `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 3 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:right;">` 2238 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` Allographa rhizicola
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` M20
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  ERROR_RANK `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` SP `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 2 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:right;">` 2238 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` Allographa rhizicola
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` M22
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  ERROR_RANK `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` SP `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 2 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:right;">` 2238 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` Allographa rhizicola
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` Talo
  blanco con lirelas delgadas y negras muy evidentes `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` ERROR_RANK
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:right;">` 2238 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` Allographa rhizicola
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` Talo
  blanquecino con lirelas abundantes y delgadas negras
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  ERROR_RANK `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` SP `{=html}     </td>`
  `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
  `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:right;">` 2238 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` Allographa rhizicola
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` Talo
  blanquecino, lirelas cortas y dispersas `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` ERROR_RANK
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:right;">` 2238 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` Allographa rhizicola
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` Talo
  café claro con lirelas negras prominentes `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` ERROR_RANK
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:right;">` 2238 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` Allographa rhizicola
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` Talo
  café claro y lirelas negras `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` ERROR_RANK
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:right;">` 2238 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` Allographa rhizicola
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` Talo
  café colaro de lirelas alargadas negras `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` ERROR_RANK
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:right;">` 2238 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` Allographa rhizicola
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` Talo
  café con lirelas negras `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` ERROR_RANK
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:right;">` 2238 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` Allographa rhizicola
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` Talo
  color crema con lirelas inmersas grises `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` ERROR_RANK
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:right;">` 2238 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` Allographa rhizicola
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` Talo
  verde claro con lirelas largas, negras y dispersas `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` ERROR_RANK
  `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
  `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
  `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
  `{=html}     <td style="text-align:right;">` 2242 `{=html}     </td>`
  `{=html}     <td style="text-align:left;">` Alyxoria varia
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  `{=html}     </td>` `{=html}     <td style="text-align:left;">`
  - `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    ERROR_RANK `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` SP `{=html}     </td>`
    `{=html}     <td style="text-align:right;">` 35 `{=html}     </td>`
    `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:right;">` 2242
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Alyxoria varia `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` M14 `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` ERROR_RANK
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 5
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:right;">` 2242
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Alyxoria varia `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` M22 `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` ERROR_RANK
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:right;">` 2242
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Alyxoria varia `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` M7 `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` ERROR_RANK
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 8
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:right;">` 2242
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Alyxoria varia `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` M9 `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` ERROR_RANK
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 2
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:right;">` 2242
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Alyxoria varia `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` Talo amarillento con
    lirelas negras `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` ERROR_RANK
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:right;">` 2242
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Alyxoria varia `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` Talo cafe a veces verde
    pulveroso con lirelas cortas y pequeñas negras. `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` ERROR_RANK
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:right;">` 2242
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Alyxoria varia `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` Talo café oscuro con
    lirelas negras `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` ERROR_RANK
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:right;">` 2242
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Alyxoria varia `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` Talo café poco
    diferenciado con lirelas negras prominentes `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` ERROR_RANK
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:right;">` 2242
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Alyxoria varia `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` Talo café poco
    diferenciado de corteza con lirelas negras, cortas y pronunciadas
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    ERROR_RANK `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` SP `{=html}     </td>`
    `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
    `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:right;">` 2242
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Alyxoria varia `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` Talo color crema con
    lirelas negras `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` ERROR_RANK
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 3
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:right;">` 2242
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Alyxoria varia `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` Talo color crema con
    lirelas negras pequeñas y dispersas `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` ERROR_RANK
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:right;">` 2242
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Alyxoria varia `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` Talo color crema poco
    diferenciado con lirelas cortas y negras `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` ERROR_RANK
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:right;">` 2242
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Alyxoria varia `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` Talo naranja con
    estructuras negras `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` ERROR_RANK
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:right;">` 2242
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Alyxoria varia `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` Talo verde claro con
    lirelas negras y abundantes `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` ERROR_RANK
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:right;">` 2242
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Alyxoria varia `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` Talo verde con lirelas
    negras cortas y pequeñas `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` ERROR_RANK
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:right;">` 2242
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Alyxoria varia `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` Talo verde con lirelas
    negras evidentes `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` ERROR_RANK
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:right;">` 2242
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Alyxoria varia `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` Talo verde manzana con
    lirelas negras gruesas `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` ERROR_RANK
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:right;">` 2242
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Alyxoria varia `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` Talo verde oscuro con
    lirelas negras `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` ERROR_RANK
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:right;">` 2242
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Alyxoria varia `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` Talo verde oscuro
    polveruloso con estructuras negras alargadas `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` ERROR_RANK
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:right;">` 2242
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Alyxoria varia `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` Talo verde poco
    diferenciado de la corteza con estructuras negras
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    ERROR_RANK `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` SP `{=html}     </td>`
    `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
    `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:right;">` 2242
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Alyxoria varia `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` Talo verde pulveroso con
    lirelas negras `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` ERROR_RANK
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:right;">` 2242
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Alyxoria varia `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` NA `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` ERROR_RANK
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 21
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:right;">` 812 `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` Anisomeridium
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` sp.
    1 `{=html}     </td>` `{=html}     <td style="text-align:left;">` M8
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` GN
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 4
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:right;">` 812 `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` Anisomeridium
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` sp.
    1 `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Talo color crema polvoroso con estructuras negras
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` GN
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:right;">` 812 `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` Anisomeridium
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` sp.
    1 `{=html}     </td>` `{=html}     <td style="text-align:left;">` NA
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
    `{=html}     </td>` `{=html}     <td style="text-align:left;">` GN
    `{=html}     </td>` `{=html}     <td style="text-align:right;">` 3
    `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
    `{=html}     <td style="text-align:right;">` 2288
    `{=html}     </td>` `{=html}     <td style="text-align:left;">`
    Archilejeunea juliformis `{=html}     </td>`
    `{=html}     <td style="text-align:left;">` `{=html}     </td>`
    `{=html}     <td style="text-align:left;">`
    - `{=html}     </td>` `{=html}     <td style="text-align:left;">`
      ERROR_RANK `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` SP `{=html}     </td>`
      `{=html}     <td style="text-align:right;">` 8 `{=html}     </td>`
      `{=html}     </tr>` `{=html}     <tr>`
      `{=html}     <td style="text-align:right;">` 2288
      `{=html}     </td>` `{=html}     <td style="text-align:left;">`
      Archilejeunea juliformis `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` Hepatica foliosa de
      hojas verdes `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` ERROR_RANK
      `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
      `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
      `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
      `{=html}     <td style="text-align:right;">` 2288
      `{=html}     </td>` `{=html}     <td style="text-align:left;">`
      Archilejeunea juliformis `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` Hepática foliosa verde
      `{=html}     </td>` `{=html}     <td style="text-align:left;">`
      ERROR_RANK `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` SP `{=html}     </td>`
      `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
      `{=html}     </tr>` `{=html}     <tr>`
      `{=html}     <td style="text-align:right;">` 2288
      `{=html}     </td>` `{=html}     <td style="text-align:left;">`
      Archilejeunea juliformis `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` Hépatica verde de
      hojas alargadas (Ricardia (?)) `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` ERROR_RANK
      `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
      `{=html}     </td>` `{=html}     <td style="text-align:right;">` 1
      `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
      `{=html}     <td style="text-align:right;">` 2288
      `{=html}     </td>` `{=html}     <td style="text-align:left;">`
      Archilejeunea juliformis `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` M11
      `{=html}     </td>` `{=html}     <td style="text-align:left;">`
      ERROR_RANK `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` SP `{=html}     </td>`
      `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
      `{=html}     </tr>` `{=html}     <tr>`
      `{=html}     <td style="text-align:right;">` 2288
      `{=html}     </td>` `{=html}     <td style="text-align:left;">`
      Archilejeunea juliformis `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` M12
      `{=html}     </td>` `{=html}     <td style="text-align:left;">`
      ERROR_RANK `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` SP `{=html}     </td>`
      `{=html}     <td style="text-align:right;">` 17
      `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
      `{=html}     <td style="text-align:right;">` 2288
      `{=html}     </td>` `{=html}     <td style="text-align:left;">`
      Archilejeunea juliformis `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` M16
      `{=html}     </td>` `{=html}     <td style="text-align:left;">`
      ERROR_RANK `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` SP `{=html}     </td>`
      `{=html}     <td style="text-align:right;">` 1 `{=html}     </td>`
      `{=html}     </tr>` `{=html}     <tr>`
      `{=html}     <td style="text-align:right;">` 2288
      `{=html}     </td>` `{=html}     <td style="text-align:left;">`
      Archilejeunea juliformis `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` M27
      `{=html}     </td>` `{=html}     <td style="text-align:left;">`
      ERROR_RANK `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` SP `{=html}     </td>`
      `{=html}     <td style="text-align:right;">` 3 `{=html}     </td>`
      `{=html}     </tr>` `{=html}     <tr>`
      `{=html}     <td style="text-align:right;">` 2288
      `{=html}     </td>` `{=html}     <td style="text-align:left;">`
      Archilejeunea juliformis `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` M7 `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` ERROR_RANK
      `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
      `{=html}     </td>` `{=html}     <td style="text-align:right;">` 2
      `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
      `{=html}     <td style="text-align:right;">` 2288
      `{=html}     </td>` `{=html}     <td style="text-align:left;">`
      Archilejeunea juliformis `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` M8 `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` ERROR_RANK
      `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
      `{=html}     </td>` `{=html}     <td style="text-align:right;">` 2
      `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
      `{=html}     <td style="text-align:right;">` 2288
      `{=html}     </td>` `{=html}     <td style="text-align:left;">`
      Archilejeunea juliformis `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` NA `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` ERROR_RANK
      `{=html}     </td>` `{=html}     <td style="text-align:left;">` SP
      `{=html}     </td>` `{=html}     <td style="text-align:right;">` 4
      `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
      `{=html}     <td style="text-align:right;">` 2295
      `{=html}     </td>` `{=html}     <td style="text-align:left;">`
      Arthonia catenatula `{=html}     </td>`
      `{=html}     <td style="text-align:left;">` `{=html}     </td>`
      `{=html}     <td style="text-align:left;">`
      - `{=html}     </td>` `{=html}     <td style="text-align:left;">`
        ERROR_RANK `{=html}     </td>`
        `{=html}     <td style="text-align:left;">` SP
        `{=html}     </td>` `{=html}     <td style="text-align:right;">`
        4 `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
        `{=html}     <td style="text-align:right;">` 2295
        `{=html}     </td>` `{=html}     <td style="text-align:left;">`
        Arthonia catenatula `{=html}     </td>`
        `{=html}     <td style="text-align:left;">` `{=html}     </td>`
        `{=html}     <td style="text-align:left;">` Talo grisaceo muy
        similar a corteza `{=html}     </td>`
        `{=html}     <td style="text-align:left;">` ERROR_RANK
        `{=html}     </td>` `{=html}     <td style="text-align:left;">`
        SP `{=html}     </td>`
        `{=html}     <td style="text-align:right;">` 1
        `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
        `{=html}     <td style="text-align:right;">` 2295
        `{=html}     </td>` `{=html}     <td style="text-align:left;">`
        Arthonia catenatula `{=html}     </td>`
        `{=html}     <td style="text-align:left;">` `{=html}     </td>`
        `{=html}     <td style="text-align:left;">` Talo gris con
        paquetes de lirelas marrón `{=html}     </td>`
        `{=html}     <td style="text-align:left;">` ERROR_RANK
        `{=html}     </td>` `{=html}     <td style="text-align:left;">`
        SP `{=html}     </td>`
        `{=html}     <td style="text-align:right;">` 1
        `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
        `{=html}     <td style="text-align:right;">` 2296
        `{=html}     </td>` `{=html}     <td style="text-align:left;">`
        Arthonia platygraphidea `{=html}     </td>`
        `{=html}     <td style="text-align:left;">` `{=html}     </td>`
        `{=html}     <td style="text-align:left;">`
        - `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` ERROR_RANK
          `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` SP
          `{=html}     </td>`
          `{=html}     <td style="text-align:right;">` 8
          `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
          `{=html}     <td style="text-align:right;">` 2296
          `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` Arthonia
          platygraphidea `{=html}     </td>`
          `{=html}     <td style="text-align:left;">`
          `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` M15
          `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` ERROR_RANK
          `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` SP
          `{=html}     </td>`
          `{=html}     <td style="text-align:right;">` 1
          `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
          `{=html}     <td style="text-align:right;">` 2296
          `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` Arthonia
          platygraphidea `{=html}     </td>`
          `{=html}     <td style="text-align:left;">`
          `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` M17
          `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` ERROR_RANK
          `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` SP
          `{=html}     </td>`
          `{=html}     <td style="text-align:right;">` 1
          `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
          `{=html}     <td style="text-align:right;">` 2296
          `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` Arthonia
          platygraphidea `{=html}     </td>`
          `{=html}     <td style="text-align:left;">`
          `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` M19
          `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` ERROR_RANK
          `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` SP
          `{=html}     </td>`
          `{=html}     <td style="text-align:right;">` 1
          `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
          `{=html}     <td style="text-align:right;">` 2296
          `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` Arthonia
          platygraphidea `{=html}     </td>`
          `{=html}     <td style="text-align:left;">`
          `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` Talo amarillo
          verdoso con estructuras negras pequeñas `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` ERROR_RANK
          `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` SP
          `{=html}     </td>`
          `{=html}     <td style="text-align:right;">` 1
          `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
          `{=html}     <td style="text-align:right;">` 2296
          `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` Arthonia
          platygraphidea `{=html}     </td>`
          `{=html}     <td style="text-align:left;">`
          `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` Talo verde oscuro
          polveruloso `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` ERROR_RANK
          `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` SP
          `{=html}     </td>`
          `{=html}     <td style="text-align:right;">` 1
          `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
          `{=html}     <td style="text-align:right;">` 2296
          `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` Arthonia
          platygraphidea `{=html}     </td>`
          `{=html}     <td style="text-align:left;">`
          `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` Talo verde
          pulveruloso con apoteicos vinotinto `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` ERROR_RANK
          `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` SP
          `{=html}     </td>`
          `{=html}     <td style="text-align:right;">` 1
          `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
          `{=html}     <td style="text-align:right;">` 825
          `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` Arthothelium
          `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` sp. 1
          `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` Talo blanco de
          borde y apoteicos negros `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` SP
          `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` GN
          `{=html}     </td>`
          `{=html}     <td style="text-align:right;">` 1
          `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
          `{=html}     <td style="text-align:right;">` 7
          `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` Ascomycota
          `{=html}     </td>`
          `{=html}     <td style="text-align:left;">` sp. 1
          `{=html}     </td>`
          `{=html}     <td style="text-align:left;">`
          - `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` ERROR_RANK
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` PHY
            `{=html}     </td>`
            `{=html}     <td style="text-align:right;">` 26
            `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
            `{=html}     <td style="text-align:right;">` 7
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` Ascomycota
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` sp. 1
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` M18
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` ERROR_RANK
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` PHY
            `{=html}     </td>`
            `{=html}     <td style="text-align:right;">` 5
            `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
            `{=html}     <td style="text-align:right;">` 7
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` Ascomycota
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` sp. 1
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` Talo grisaceo
            con soradios verde claro `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` ERROR_RANK
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` PHY
            `{=html}     </td>`
            `{=html}     <td style="text-align:right;">` 1
            `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
            `{=html}     <td style="text-align:right;">` 7
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` Ascomycota
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` sp. 1
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` Talo gris oscruo
            con estructuras color crema pequeñas `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` ERROR_RANK
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` PHY
            `{=html}     </td>`
            `{=html}     <td style="text-align:right;">` 1
            `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
            `{=html}     <td style="text-align:right;">` 7
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` Ascomycota
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` sp. 1
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` Talo verde
            grisáceo con soradios verde claro `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` ERROR_RANK
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` PHY
            `{=html}     </td>`
            `{=html}     <td style="text-align:right;">` 1
            `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
            `{=html}     <td style="text-align:right;">` 7
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` Ascomycota
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` sp. 1
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` Talo verde
            militar con sorelios verde militar `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` ERROR_RANK
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` PHY
            `{=html}     </td>`
            `{=html}     <td style="text-align:right;">` 1
            `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
            `{=html}     <td style="text-align:right;">` 7
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` Ascomycota
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` sp. 1
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` Talo verde
            oscuro pulverulosa con estructuras negras
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` ERROR_RANK
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` PHY
            `{=html}     </td>`
            `{=html}     <td style="text-align:right;">` 1
            `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
            `{=html}     <td style="text-align:right;">` 7
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` Ascomycota
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` sp. 1
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` Talo verde
            pulveruloso `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` ERROR_RANK
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` PHY
            `{=html}     </td>`
            `{=html}     <td style="text-align:right;">` 1
            `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
            `{=html}     <td style="text-align:right;">` 7
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` Ascomycota
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` sp. 1
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` Tilo color crema
            para diferenciado con estive\*\* negras `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` ERROR_RANK
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` PHY
            `{=html}     </td>`
            `{=html}     <td style="text-align:right;">` 1
            `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
            `{=html}     <td style="text-align:right;">` 7
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` Ascomycota
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` sp. 1
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` NA
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` ERROR_RANK
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` PHY
            `{=html}     </td>`
            `{=html}     <td style="text-align:right;">` 15
            `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
            `{=html}     <td style="text-align:right;">` 7
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` Ascomycota
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` sp. 10
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` M4
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` ERROR_RANK
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` PHY
            `{=html}     </td>`
            `{=html}     <td style="text-align:right;">` 1
            `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
            `{=html}     <td style="text-align:right;">` 7
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` Ascomycota
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` sp. 11
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` M6
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` ERROR_RANK
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` PHY
            `{=html}     </td>`
            `{=html}     <td style="text-align:right;">` 6
            `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
            `{=html}     <td style="text-align:right;">` 7
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` Ascomycota
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` sp. 12
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` M11
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` ERROR_RANK
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` PHY
            `{=html}     </td>`
            `{=html}     <td style="text-align:right;">` 6
            `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
            `{=html}     <td style="text-align:right;">` 7
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` Ascomycota
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` sp. 13
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` M19
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` ERROR_RANK
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` PHY
            `{=html}     </td>`
            `{=html}     <td style="text-align:right;">` 6
            `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
            `{=html}     <td style="text-align:right;">` 7
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` Ascomycota
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` sp. 14
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` M20
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` ERROR_RANK
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` PHY
            `{=html}     </td>`
            `{=html}     <td style="text-align:right;">` 2
            `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
            `{=html}     <td style="text-align:right;">` 7
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` Ascomycota
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">` sp. 15
            `{=html}     </td>`
            `{=html}     <td style="text-align:left;">`
            - `{=html}     </td>`
              `{=html}     <td style="text-align:left;">` ERROR_RANK
              `{=html}     </td>`
              `{=html}     <td style="text-align:left;">` PHY
              `{=html}     </td>`
              `{=html}     <td style="text-align:right;">` 11
              `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
              `{=html}     <td style="text-align:right;">` 7
              `{=html}     </td>`
              `{=html}     <td style="text-align:left;">` Ascomycota
              `{=html}     </td>`
              `{=html}     <td style="text-align:left;">` sp. 15
              `{=html}     </td>`
              `{=html}     <td style="text-align:left;">` Talo verde
              grisáceo con soradios verde claro `{=html}     </td>`
              `{=html}     <td style="text-align:left;">` ERROR_RANK
              `{=html}     </td>`
              `{=html}     <td style="text-align:left;">` PHY
              `{=html}     </td>`
              `{=html}     <td style="text-align:right;">` 1
              `{=html}     </td>` `{=html}     </tr>` `{=html}     <tr>`
              `{=html}     <td style="text-align:right;">` 7
              `{=html}     </td>`
              `{=html}     <td style="text-align:left;">` Ascomycota
              `{=html}     </td>`
              `{=html}     <td style="text-align:left;">` sp. 16
              `{=html}     </td>`
              `{=html}     <td style="text-align:left;">`
              - `{=html}     </td>`
                `{=html}     <td style="text-align:left;">` ERROR_RANK
                `{=html}     </td>`
                `{=html}     <td style="text-align:left;">` PHY
                `{=html}     </td>`
                `{=html}     <td style="text-align:right;">` 9
                `{=html}     </td>` `{=html}     </tr>`
                `{=html}     <tr>`
                `{=html}     <td style="text-align:right;">` 7
                `{=html}     </td>`
                `{=html}     <td style="text-align:left;">` Ascomycota
                `{=html}     </td>`
                `{=html}     <td style="text-align:left;">` sp. 16
                `{=html}     </td>`
                `{=html}     <td style="text-align:left;">` Talo verde
                oscuro aveces café con estructuras negras
                `{=html}     </td>`
                `{=html}     <td style="text-align:left;">` ERROR_RANK
                `{=html}     </td>`
                `{=html}     <td style="text-align:left;">` PHY
                `{=html}     </td>`
                `{=html}     <td style="text-align:right;">` 1
                `{=html}     </td>` `{=html}     </tr>`
                `{=html}     <tr>`
                `{=html}     <td style="text-align:right;">` 7
                `{=html}     </td>`
                `{=html}     <td style="text-align:left;">` Ascomycota
                `{=html}     </td>`
                `{=html}     <td style="text-align:left;">` sp. 17
                `{=html}     </td>`
                `{=html}     <td style="text-align:left;">` M2
                `{=html}     </td>`
                `{=html}     <td style="text-align:left;">` ERROR_RANK
                `{=html}     </td>`
                `{=html}     <td style="text-align:left;">` PHY
                `{=html}     </td>`
                `{=html}     <td style="text-align:right;">` 5
                `{=html}     </td>` `{=html}     </tr>`
                `{=html}     <tr>`
                `{=html}     <td style="text-align:right;">` 7
                `{=html}     </td>`
                `{=html}     <td style="text-align:left;">` Ascomycota
                `{=html}     </td>`
                `{=html}     <td style="text-align:left;">` sp. 18
                `{=html}     </td>`
                `{=html}     <td style="text-align:left;">` M8
                `{=html}     </td>`
                `{=html}     <td style="text-align:left;">` ERROR_RANK
                `{=html}     </td>`
                `{=html}     <td style="text-align:left;">` PHY
                `{=html}     </td>`
                `{=html}     <td style="text-align:right;">` 2
                `{=html}     </td>` `{=html}     </tr>`
                `{=html}     <tr>`
                `{=html}     <td style="text-align:right;">` 7
                `{=html}     </td>`
                `{=html}     <td style="text-align:left;">` Ascomycota
                `{=html}     </td>`
                `{=html}     <td style="text-align:left;">` sp. 19
                `{=html}     </td>`
                `{=html}     <td style="text-align:left;">` Talo verde
                oscuro poco diferenciado con apotecios amarillentos
                `{=html}     </td>`
                `{=html}     <td style="text-align:left;">` ERROR_RANK
                `{=html}     </td>`
                `{=html}     <td style="text-align:left;">` PHY
                `{=html}     </td>`
                `{=html}     <td style="text-align:right;">` 1
                `{=html}     </td>` `{=html}     </tr>`
                `{=html}     <tr>`
                `{=html}     <td style="text-align:right;">` 7
                `{=html}     </td>`
                `{=html}     <td style="text-align:left;">` Ascomycota
                `{=html}     </td>`
                `{=html}     <td style="text-align:left;">` sp. 2
                `{=html}     </td>`
                `{=html}     <td style="text-align:left;">`
                - `{=html}     </td>`
                  `{=html}     <td style="text-align:left;">` ERROR_RANK
                  `{=html}     </td>`
                  `{=html}     <td style="text-align:left;">` PHY
                  `{=html}     </td>`
                  `{=html}     <td style="text-align:right;">` 3
                  `{=html}     </td>` `{=html}     </tr>`
                  `{=html}     <tr>`
                  `{=html}     <td style="text-align:right;">` 7
                  `{=html}     </td>`
                  `{=html}     <td style="text-align:left;">` Ascomycota
                  `{=html}     </td>`
                  `{=html}     <td style="text-align:left;">` sp. 20
                  `{=html}     </td>`
                  `{=html}     <td style="text-align:left;">`
                  - `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">`
                    ERROR_RANK `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">` PHY
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:right;">` 6
                    `{=html}     </td>` `{=html}     </tr>`
                    `{=html}     <tr>`
                    `{=html}     <td style="text-align:right;">` 7
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">`
                    Ascomycota `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">` sp. 20
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">` Talo
                    verde oscuro pulveruloso `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">`
                    ERROR_RANK `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">` PHY
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:right;">` 1
                    `{=html}     </td>` `{=html}     </tr>`
                    `{=html}     <tr>`
                    `{=html}     <td style="text-align:right;">` 7
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">`
                    Ascomycota `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">` sp. 21
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">` M23
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">`
                    ERROR_RANK `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">` PHY
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:right;">` 1
                    `{=html}     </td>` `{=html}     </tr>`
                    `{=html}     <tr>`
                    `{=html}     <td style="text-align:right;">` 7
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">`
                    Ascomycota `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">` sp. 22
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">` M7
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">`
                    ERROR_RANK `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">` PHY
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:right;">` 3
                    `{=html}     </td>` `{=html}     </tr>`
                    `{=html}     <tr>`
                    `{=html}     <td style="text-align:right;">` 7
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">`
                    Ascomycota `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">` sp. 23
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">` M9
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">`
                    ERROR_RANK `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">` PHY
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:right;">` 2
                    `{=html}     </td>` `{=html}     </tr>`
                    `{=html}     <tr>`
                    `{=html}     <td style="text-align:right;">` 7
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">`
                    Ascomycota `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">` sp. 24
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">` M11
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">`
                    ERROR_RANK `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">` PHY
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:right;">` 2
                    `{=html}     </td>` `{=html}     </tr>`
                    `{=html}     <tr>`
                    `{=html}     <td style="text-align:right;">` 7
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">`
                    Ascomycota `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">` sp. 25
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">` M25
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">`
                    ERROR_RANK `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">` PHY
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:right;">` 1
                    `{=html}     </td>` `{=html}     </tr>`
                    `{=html}     <tr>`
                    `{=html}     <td style="text-align:right;">` 7
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">`
                    Ascomycota `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">` sp. 26
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">` M29
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">`
                    ERROR_RANK `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">` PHY
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:right;">` 2
                    `{=html}     </td>` `{=html}     </tr>`
                    `{=html}     <tr>`
                    `{=html}     <td style="text-align:right;">` 7
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">`
                    Ascomycota `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">` sp. 27
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">` M19
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">`
                    ERROR_RANK `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">` PHY
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:right;">` 1
                    `{=html}     </td>` `{=html}     </tr>`
                    `{=html}     <tr>`
                    `{=html}     <td style="text-align:right;">` 7
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">`
                    Ascomycota `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">` sp. 28
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">` M14
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">`
                    ERROR_RANK `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">` PHY
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:right;">` 1
                    `{=html}     </td>` `{=html}     </tr>`
                    `{=html}     <tr>`
                    `{=html}     <td style="text-align:right;">` 7
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">`
                    Ascomycota `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">` sp. 29
                    `{=html}     </td>`
                    `{=html}     <td style="text-align:left;">`
                    - `{=html}     </td>`
                      `{=html}     <td style="text-align:left;">`
                      ERROR_RANK `{=html}     </td>`
                      `{=html}     <td style="text-align:left;">` PHY
                      `{=html}     </td>`
                      `{=html}     <td style="text-align:right;">` 1
                      `{=html}     </td>` `{=html}     </tr>`
                      `{=html}     <tr>`
                      `{=html}     <td style="text-align:right;">` 7
                      `{=html}     </td>`
                      `{=html}     <td style="text-align:left;">`
                      Ascomycota `{=html}     </td>`
                      `{=html}     <td style="text-align:left;">` sp. 29
                      `{=html}     </td>`
                      `{=html}     <td style="text-align:left;">` Talo
                      crema poco diferenciado de superficie con
                      apotecios negros `{=html}     </td>`
                      `{=html}     <td style="text-align:left;">`
                      ERROR_RANK `{=html}     </td>`
                      `{=html}     <td style="text-align:left;">` PHY
                      `{=html}     </td>`
                      `{=html}     <td style="text-align:right;">` 1
                      `{=html}     </td>` `{=html}     </tr>`
                      `{=html}     <tr>`
                      `{=html}     <td style="text-align:right;">` 7
                      `{=html}     </td>`
                      `{=html}     <td style="text-align:left;">`
                      Ascomycota `{=html}     </td>`
                      `{=html}     <td style="text-align:left;">` sp. 3
                      `{=html}     </td>`
                      `{=html}     <td style="text-align:left;">` Talo
                      café claro con estructuras diminutas negras
                      `{=html}     </td>`
                      `{=html}     <td style="text-align:left;">`
                      ERROR_RANK `{=html}     </td>`
                      `{=html}     <td style="text-align:left;">` PHY
                      `{=html}     </td>`
                      `{=html}     <td style="text-align:right;">` 1
                      `{=html}     </td>` `{=html}     </tr>`
                      `{=html}     <tr>`
                      `{=html}     <td style="text-align:right;">` 7
                      `{=html}     </td>`
                      `{=html}     <td style="text-align:left;">`
                      Ascomycota `{=html}     </td>`
                      `{=html}     <td style="text-align:left;">` sp. 30
                      `{=html}     </td>`
                      `{=html}     <td style="text-align:left;">`
                      - `{=html}     </td>`
                        `{=html}     <td style="text-align:left;">`
                        ERROR_RANK `{=html}     </td>`
                        `{=html}     <td style="text-align:left;">` PHY
                        `{=html}     </td>`
                        `{=html}     <td style="text-align:right;">` 39
                        `{=html}     </td>` `{=html}     </tr>`
                        `{=html}     <tr>`
                        `{=html}     <td style="text-align:right;">` 7
                        `{=html}     </td>`
                        `{=html}     <td style="text-align:left;">`
                        Ascomycota `{=html}     </td>`
                        `{=html}     <td style="text-align:left;">` sp.
                        30 `{=html}     </td>`
                        `{=html}     <td style="text-align:left;">` M10
                        `{=html}     </td>`
                        `{=html}     <td style="text-align:left;">`
                        ERROR_RANK `{=html}     </td>`
                        `{=html}     <td style="text-align:left;">` PHY
                        `{=html}     </td>`
                        `{=html}     <td style="text-align:right;">` 1
                        `{=html}     </td>` `{=html}     </tr>`
                        `{=html}     <tr>`
                        `{=html}     <td style="text-align:right;">` 7
                        `{=html}     </td>`
                        `{=html}     <td style="text-align:left;">`
                        Ascomycota `{=html}     </td>`
                        `{=html}     <td style="text-align:left;">` sp.
                        30 `{=html}     </td>`
                        `{=html}     <td style="text-align:left;">` M11
                        `{=html}     </td>`
                        `{=html}     <td style="text-align:left;">`
                        ERROR_RANK `{=html}     </td>`
                        `{=html}     <td style="text-align:left;">` PHY
                        `{=html}     </td>`
                        `{=html}     <td style="text-align:right;">` 9
                        `{=html}     </td>` `{=html}     </tr>`
                        `{=html}     </tbody>` `{=html}     </table>`

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

<table>
<caption>

Displaying records 1 - 100

</caption>
<thead>
<tr>
<th style="text-align:right;">

cd_morfo

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">

171

</td>
</tr>
<tr>
<td style="text-align:right;">

136

</td>
</tr>
<tr>
<td style="text-align:right;">

171

</td>
</tr>
<tr>
<td style="text-align:right;">

202

</td>
</tr>
<tr>
<td style="text-align:right;">

160

</td>
</tr>
<tr>
<td style="text-align:right;">

175

</td>
</tr>
<tr>
<td style="text-align:right;">

152

</td>
</tr>
<tr>
<td style="text-align:right;">

160

</td>
</tr>
<tr>
<td style="text-align:right;">

160

</td>
</tr>
<tr>
<td style="text-align:right;">

160

</td>
</tr>
<tr>
<td style="text-align:right;">

152

</td>
</tr>
<tr>
<td style="text-align:right;">

152

</td>
</tr>
<tr>
<td style="text-align:right;">

160

</td>
</tr>
<tr>
<td style="text-align:right;">

128

</td>
</tr>
<tr>
<td style="text-align:right;">

160

</td>
</tr>
<tr>
<td style="text-align:right;">

170

</td>
</tr>
<tr>
<td style="text-align:right;">

190

</td>
</tr>
<tr>
<td style="text-align:right;">

130

</td>
</tr>
<tr>
<td style="text-align:right;">

131

</td>
</tr>
<tr>
<td style="text-align:right;">

136

</td>
</tr>
<tr>
<td style="text-align:right;">

135

</td>
</tr>
<tr>
<td style="text-align:right;">

160

</td>
</tr>
<tr>
<td style="text-align:right;">

183

</td>
</tr>
<tr>
<td style="text-align:right;">

195

</td>
</tr>
<tr>
<td style="text-align:right;">

152

</td>
</tr>
<tr>
<td style="text-align:right;">

134

</td>
</tr>
<tr>
<td style="text-align:right;">

152

</td>
</tr>
<tr>
<td style="text-align:right;">

183

</td>
</tr>
<tr>
<td style="text-align:right;">

170

</td>
</tr>
<tr>
<td style="text-align:right;">

130

</td>
</tr>
<tr>
<td style="text-align:right;">

157

</td>
</tr>
<tr>
<td style="text-align:right;">

172

</td>
</tr>
<tr>
<td style="text-align:right;">

202

</td>
</tr>
<tr>
<td style="text-align:right;">

149

</td>
</tr>
<tr>
<td style="text-align:right;">

172

</td>
</tr>
<tr>
<td style="text-align:right;">

203

</td>
</tr>
<tr>
<td style="text-align:right;">

203

</td>
</tr>
<tr>
<td style="text-align:right;">

172

</td>
</tr>
<tr>
<td style="text-align:right;">

164

</td>
</tr>
<tr>
<td style="text-align:right;">

203

</td>
</tr>
<tr>
<td style="text-align:right;">

202

</td>
</tr>
<tr>
<td style="text-align:right;">

166

</td>
</tr>
<tr>
<td style="text-align:right;">

203

</td>
</tr>
<tr>
<td style="text-align:right;">

172

</td>
</tr>
<tr>
<td style="text-align:right;">

157

</td>
</tr>
<tr>
<td style="text-align:right;">

201

</td>
</tr>
<tr>
<td style="text-align:right;">

170

</td>
</tr>
<tr>
<td style="text-align:right;">

171

</td>
</tr>
<tr>
<td style="text-align:right;">

171

</td>
</tr>
<tr>
<td style="text-align:right;">

171

</td>
</tr>
<tr>
<td style="text-align:right;">

131

</td>
</tr>
<tr>
<td style="text-align:right;">

159

</td>
</tr>
<tr>
<td style="text-align:right;">

159

</td>
</tr>
<tr>
<td style="text-align:right;">

159

</td>
</tr>
<tr>
<td style="text-align:right;">

171

</td>
</tr>
<tr>
<td style="text-align:right;">

171

</td>
</tr>
<tr>
<td style="text-align:right;">

171

</td>
</tr>
<tr>
<td style="text-align:right;">

159

</td>
</tr>
<tr>
<td style="text-align:right;">

171

</td>
</tr>
<tr>
<td style="text-align:right;">

170

</td>
</tr>
<tr>
<td style="text-align:right;">

171

</td>
</tr>
<tr>
<td style="text-align:right;">

171

</td>
</tr>
<tr>
<td style="text-align:right;">

171

</td>
</tr>
<tr>
<td style="text-align:right;">

171

</td>
</tr>
<tr>
<td style="text-align:right;">

139

</td>
</tr>
<tr>
<td style="text-align:right;">

139

</td>
</tr>
<tr>
<td style="text-align:right;">

132

</td>
</tr>
<tr>
<td style="text-align:right;">

132

</td>
</tr>
<tr>
<td style="text-align:right;">

132

</td>
</tr>
<tr>
<td style="text-align:right;">

139

</td>
</tr>
<tr>
<td style="text-align:right;">

159

</td>
</tr>
<tr>
<td style="text-align:right;">

132

</td>
</tr>
<tr>
<td style="text-align:right;">

133

</td>
</tr>
<tr>
<td style="text-align:right;">

216

</td>
</tr>
<tr>
<td style="text-align:right;">

193

</td>
</tr>
<tr>
<td style="text-align:right;">

216

</td>
</tr>
<tr>
<td style="text-align:right;">

216

</td>
</tr>
<tr>
<td style="text-align:right;">

136

</td>
</tr>
<tr>
<td style="text-align:right;">

215

</td>
</tr>
<tr>
<td style="text-align:right;">

215

</td>
</tr>
<tr>
<td style="text-align:right;">

215

</td>
</tr>
<tr>
<td style="text-align:right;">

215

</td>
</tr>
<tr>
<td style="text-align:right;">

136

</td>
</tr>
<tr>
<td style="text-align:right;">

137

</td>
</tr>
<tr>
<td style="text-align:right;">

137

</td>
</tr>
<tr>
<td style="text-align:right;">

136

</td>
</tr>
<tr>
<td style="text-align:right;">

207

</td>
</tr>
<tr>
<td style="text-align:right;">

207

</td>
</tr>
<tr>
<td style="text-align:right;">

177

</td>
</tr>
<tr>
<td style="text-align:right;">

225

</td>
</tr>
<tr>
<td style="text-align:right;">

148

</td>
</tr>
<tr>
<td style="text-align:right;">

171

</td>
</tr>
<tr>
<td style="text-align:right;">

171

</td>
</tr>
<tr>
<td style="text-align:right;">

171

</td>
</tr>
<tr>
<td style="text-align:right;">

171

</td>
</tr>
<tr>
<td style="text-align:right;">

171

</td>
</tr>
<tr>
<td style="text-align:right;">

225

</td>
</tr>
<tr>
<td style="text-align:right;">

225

</td>
</tr>
<tr>
<td style="text-align:right;">

133

</td>
</tr>
<tr>
<td style="text-align:right;">

225

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

Displaying records 1 - 50

</caption>
<thead>
<tr>
<th style="text-align:right;">

cd_tax

</th>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

identification_qualifier

</th>
<th style="text-align:left;">

identification_remarks

</th>
<th style="text-align:left;">

pseudo_rank

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">

859

</td>
<td style="text-align:left;">

Brachystomella

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 1

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

943

</td>
<td style="text-align:left;">

Cyphoderus

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 1

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

11

</td>
</tr>
<tr>
<td style="text-align:right;">

1013

</td>
<td style="text-align:left;">

Folsomina

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 1

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1179

</td>
<td style="text-align:left;">

Neelides

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 1

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1294

</td>
<td style="text-align:left;">

Ptenothrix

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 1

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

88

</td>
</tr>
<tr>
<td style="text-align:right;">

1312

</td>
<td style="text-align:left;">

Salina

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 10

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

11

</td>
</tr>
<tr>
<td style="text-align:right;">

1327

</td>
<td style="text-align:left;">

Sminthurides

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 10

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

1099

</td>
<td style="text-align:left;">

Lepidocyrtoides

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 100

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

18

</td>
</tr>
<tr>
<td style="text-align:right;">

1054

</td>
<td style="text-align:left;">

Heteromurus

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 101

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1100

</td>
<td style="text-align:left;">

Lepidocyrtus

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 101

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1100

</td>
<td style="text-align:left;">

Lepidocyrtus

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 102

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1312

</td>
<td style="text-align:left;">

Salina

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 103

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

1396

</td>
<td style="text-align:left;">

Trogolaphysa

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 104

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1080

</td>
<td style="text-align:left;">

Isotomurus

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 105

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

8

</td>
</tr>
<tr>
<td style="text-align:right;">

2869

</td>
<td style="text-align:left;">

Isotomurus yamaquizuensis

</td>
<td style="text-align:left;">

cf. yamaquizuensis

</td>
<td style="text-align:left;">

Morfo 105

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1100

</td>
<td style="text-align:left;">

Lepidocyrtus

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 106

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

7

</td>
</tr>
<tr>
<td style="text-align:right;">

988

</td>
<td style="text-align:left;">

Entomobrya

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 107

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

988

</td>
<td style="text-align:left;">

Entomobrya

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 108

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1412

</td>
<td style="text-align:left;">

Willowsia

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 108

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

17

</td>
</tr>
<tr>
<td style="text-align:right;">

1396

</td>
<td style="text-align:left;">

Trogolaphysa

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 109

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

11

</td>
</tr>
<tr>
<td style="text-align:right;">

1412

</td>
<td style="text-align:left;">

Willowsia

</td>
<td style="text-align:left;">

cf. Willowsia

</td>
<td style="text-align:left;">

Morfo 109

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1100

</td>
<td style="text-align:left;">

Lepidocyrtus

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 11

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

26

</td>
</tr>
<tr>
<td style="text-align:right;">

1100

</td>
<td style="text-align:left;">

Lepidocyrtus

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 110

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1099

</td>
<td style="text-align:left;">

Lepidocyrtoides

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 111

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1100

</td>
<td style="text-align:left;">

Lepidocyrtus

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 111

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1099

</td>
<td style="text-align:left;">

Lepidocyrtoides

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 112

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1333

</td>
<td style="text-align:left;">

Sphaeridia

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 113

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

288

</td>
<td style="text-align:left;">

Entomobryidae

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 114 \| género Lepidocyrtus o Lanocyrtus

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

38

</td>
</tr>
<tr>
<td style="text-align:right;">

1333

</td>
<td style="text-align:left;">

Sphaeridia

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 115

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1082

</td>
<td style="text-align:left;">

Katianna

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 116

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

1294

</td>
<td style="text-align:left;">

Ptenothrix

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 117

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

859

</td>
<td style="text-align:left;">

Brachystomella

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 118

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:right;">

859

</td>
<td style="text-align:left;">

Brachystomella

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 119

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

1189

</td>
<td style="text-align:left;">

Neotropiella

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 119

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

86

</td>
</tr>
<tr>
<td style="text-align:right;">

1100

</td>
<td style="text-align:left;">

Lepidocyrtus

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 12

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

50

</td>
</tr>
<tr>
<td style="text-align:right;">

98

</td>
<td style="text-align:left;">

Symphypleona

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 12

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

859

</td>
<td style="text-align:left;">

Brachystomella

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 120

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

93

</td>
<td style="text-align:left;">

Poduromorpha

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 120

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

859

</td>
<td style="text-align:left;">

Brachystomella

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 121

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

1282

</td>
<td style="text-align:left;">

Pseudachorutes

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 121

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

15

</td>
</tr>
<tr>
<td style="text-align:right;">

318

</td>
<td style="text-align:left;">

Neanuridae

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 122

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

824

</td>
<td style="text-align:left;">

Arlesia

</td>
<td style="text-align:left;">

cf. Arlesia

</td>
<td style="text-align:left;">

Morfo 123

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

302

</td>
<td style="text-align:left;">

Hypogastruridae

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 123

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1100

</td>
<td style="text-align:left;">

Lepidocyrtus

</td>
<td style="text-align:left;">

aff. Lepidocyrtus

</td>
<td style="text-align:left;">

Morfo 124

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1100

</td>
<td style="text-align:left;">

Lepidocyrtus

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 124

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

1396

</td>
<td style="text-align:left;">

Trogolaphysa

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 124

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

1100

</td>
<td style="text-align:left;">

Lepidocyrtus

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 125

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1294

</td>
<td style="text-align:left;">

Ptenothrix

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 126

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1333

</td>
<td style="text-align:left;">

Sphaeridia

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfo 127

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

824

</td>
<td style="text-align:left;">

Arlesia

</td>
<td style="text-align:left;">

cf. Arlesia

</td>
<td style="text-align:left;">

Morfo 128

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

7

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

24 records

</caption>
<thead>
<tr>
<th style="text-align:right;">

cd_tax

</th>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

morfo

</th>
<th style="text-align:left;">

affinities

</th>
<th style="text-align:left;">

identification_qualifier

</th>
<th style="text-align:right;">

count

</th>
<th style="text-align:right;">

order_cases_in_sp_morfo

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">

288

</td>
<td style="text-align:left;">

Entomobryidae

</td>
<td style="text-align:left;">

Morfo 65

</td>
<td style="text-align:left;">

género Lepidocyrtus o Lanocyrtus

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:right;">

32

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

288

</td>
<td style="text-align:left;">

Entomobryidae

</td>
<td style="text-align:left;">

Morfo 65

</td>
<td style="text-align:left;">

género Lepidocyrtus o Lanocyrtus

</td>
<td style="text-align:left;">

aff. Entomobryidae

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

853

</td>
<td style="text-align:left;">

Bourletiella

</td>
<td style="text-align:left;">

Morfo 229

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

aff. Bourletiella

</td>
<td style="text-align:right;">

7

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

853

</td>
<td style="text-align:left;">

Bourletiella

</td>
<td style="text-align:left;">

Morfo 229

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

964

</td>
<td style="text-align:left;">

Dicyrtoma

</td>
<td style="text-align:left;">

Morfo 2

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

aff. Dicyrtoma

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

964

</td>
<td style="text-align:left;">

Dicyrtoma

</td>
<td style="text-align:left;">

Morfo 2

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:right;">

12

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1078

</td>
<td style="text-align:left;">

Isotomiella

</td>
<td style="text-align:left;">

Morfo 256

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

aff. Isotomiella

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1078

</td>
<td style="text-align:left;">

Isotomiella

</td>
<td style="text-align:left;">

Morfo 256

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1100

</td>
<td style="text-align:left;">

Lepidocyrtus

</td>
<td style="text-align:left;">

Morfo 124

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1100

</td>
<td style="text-align:left;">

Lepidocyrtus

</td>
<td style="text-align:left;">

Morfo 124

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

aff. Lepidocyrtus

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1187

</td>
<td style="text-align:left;">

Neosminthurus

</td>
<td style="text-align:left;">

Morfo 245

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

cf. Neosminthurus

</td>
<td style="text-align:right;">

4

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1187

</td>
<td style="text-align:left;">

Neosminthurus

</td>
<td style="text-align:left;">

Morfo 245

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

aff. Neosminthurus

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1227

</td>
<td style="text-align:left;">

Pararrhopalites

</td>
<td style="text-align:left;">

Morfo 335

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

cf. Pararrhopalites

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1227

</td>
<td style="text-align:left;">

Pararrhopalites

</td>
<td style="text-align:left;">

Morfo 335

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1324

</td>
<td style="text-align:left;">

Sinella

</td>
<td style="text-align:left;">

Morfo 80

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:right;">

9

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1324

</td>
<td style="text-align:left;">

Sinella

</td>
<td style="text-align:left;">

Morfo 80

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

cf. Sinella

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1329

</td>
<td style="text-align:left;">

Sminthurus

</td>
<td style="text-align:left;">

Morfo 233

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

aff. Sminthurus

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1329

</td>
<td style="text-align:left;">

Sminthurus

</td>
<td style="text-align:left;">

Morfo 233

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:right;">

10

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1329

</td>
<td style="text-align:left;">

Sminthurus

</td>
<td style="text-align:left;">

Morfo 235

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:right;">

21

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1329

</td>
<td style="text-align:left;">

Sminthurus

</td>
<td style="text-align:left;">

Morfo 235

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

cf. Sminthurus

</td>
<td style="text-align:right;">

6

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1333

</td>
<td style="text-align:left;">

Sphaeridia

</td>
<td style="text-align:left;">

Morfo 223

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

cf. Sphaeridia

</td>
<td style="text-align:right;">

6

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1333

</td>
<td style="text-align:left;">

Sphaeridia

</td>
<td style="text-align:left;">

Morfo 223

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1335

</td>
<td style="text-align:left;">

Sphyrotheca

</td>
<td style="text-align:left;">

Morfo 328

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1335

</td>
<td style="text-align:left;">

Sphyrotheca

</td>
<td style="text-align:left;">

Morfo 328

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

cf. Sphyrotheca

</td>
<td style="text-align:right;">

1

</td>
<td style="text-align:right;">

2

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

13 records

</caption>
<thead>
<tr>
<th style="text-align:right;">

cd_tax

</th>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

identification_qualifier

</th>
<th style="text-align:left;">

identification_remarks

</th>
<th style="text-align:left;">

pseudo_rank

</th>
<th style="text-align:right;">

count

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">

878

</td>
<td style="text-align:left;">

Canthidium

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

01H

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

24

</td>
</tr>
<tr>
<td style="text-align:right;">

878

</td>
<td style="text-align:left;">

Canthidium

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

02H

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

39

</td>
</tr>
<tr>
<td style="text-align:right;">

878

</td>
<td style="text-align:left;">

Canthidium

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

05H

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

50

</td>
</tr>
<tr>
<td style="text-align:right;">

878

</td>
<td style="text-align:left;">

Canthidium

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

10H

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

24

</td>
</tr>
<tr>
<td style="text-align:right;">

878

</td>
<td style="text-align:left;">

Canthidium

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

12H

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

32

</td>
</tr>
<tr>
<td style="text-align:right;">

879

</td>
<td style="text-align:left;">

Canthon

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

05H

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

10

</td>
</tr>
<tr>
<td style="text-align:right;">

879

</td>
<td style="text-align:left;">

Canthon

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

06H

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

74

</td>
</tr>
<tr>
<td style="text-align:right;">

879

</td>
<td style="text-align:left;">

Canthon

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

09H

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

54

</td>
</tr>
<tr>
<td style="text-align:right;">

879

</td>
<td style="text-align:left;">

Canthon

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

10H

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

97

</td>
</tr>
<tr>
<td style="text-align:right;">

958

</td>
<td style="text-align:left;">

Dichotomius

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

03H

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

56

</td>
</tr>
<tr>
<td style="text-align:right;">

1207

</td>
<td style="text-align:left;">

Onthophagus

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

01H

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

682

</td>
</tr>
<tr>
<td style="text-align:right;">

1405

</td>
<td style="text-align:left;">

Uroxys

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

02H

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

87

</td>
</tr>
<tr>
<td style="text-align:right;">

1405

</td>
<td style="text-align:left;">

Uroxys

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

05H

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

24

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

Displaying records 1 - 100

</caption>
<thead>
<tr>
<th style="text-align:right;">

cd_tax

</th>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

identification_qualifier

</th>
<th style="text-align:left;">

name_morfo

</th>
<th style="text-align:left;">

identification_remarks

</th>
<th style="text-align:left;">

description

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:left;">

pseudo_rank

</th>
<th style="text-align:right;">

count

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">

9

</td>
<td style="text-align:left;">

Nematoda

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

82

</td>
<td style="text-align:left;">

Coleoptera

</td>
<td style="text-align:left;">

Mf. (larva)

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

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

82

</td>
<td style="text-align:left;">

Coleoptera

</td>
<td style="text-align:left;">

Mf. (pupa)

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

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

83

</td>
<td style="text-align:left;">

Diptera

</td>
<td style="text-align:left;">

Mf. (larva)

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

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

83

</td>
<td style="text-align:left;">

Diptera

</td>
<td style="text-align:left;">

Mf. (pupa)

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

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

85

</td>
<td style="text-align:left;">

Lepidoptera

</td>
<td style="text-align:left;">

cf. Lepidoptera Mf. (pupa)

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

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

86

</td>
<td style="text-align:left;">

Mesostigmata

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

89

</td>
<td style="text-align:left;">

Neoophora

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

90

</td>
<td style="text-align:left;">

Odonata

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

91

</td>
<td style="text-align:left;">

Oribatida

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

91

</td>
<td style="text-align:left;">

Oribatida

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

95

</td>
<td style="text-align:left;">

Sarcoptiformes

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

95

</td>
<td style="text-align:left;">

Sarcoptiformes

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

100

</td>
<td style="text-align:left;">

Tricladida

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

101

</td>
<td style="text-align:left;">

Trombidiformes

</td>
<td style="text-align:left;">

mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

101

</td>
<td style="text-align:left;">

Trombidiformes

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

38

</td>
</tr>
<tr>
<td style="text-align:right;">

101

</td>
<td style="text-align:left;">

Trombidiformes

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

Fuertes espinas en el lado ventral de las patas.

</td>
<td style="text-align:left;">

Fuertes espinas en el lado ventral de las patas.

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

101

</td>
<td style="text-align:left;">

Trombidiformes

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

8

</td>
</tr>
<tr>
<td style="text-align:right;">

101

</td>
<td style="text-align:left;">

Trombidiformes

</td>
<td style="text-align:left;">

mf3.

</td>
<td style="text-align:left;">

Mf3.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

101

</td>
<td style="text-align:left;">

Trombidiformes

</td>
<td style="text-align:left;">

Mf3.

</td>
<td style="text-align:left;">

Mf3.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

11

</td>
</tr>
<tr>
<td style="text-align:right;">

101

</td>
<td style="text-align:left;">

Trombidiformes

</td>
<td style="text-align:left;">

mf4.

</td>
<td style="text-align:left;">

Mf4.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

101

</td>
<td style="text-align:left;">

Trombidiformes

</td>
<td style="text-align:left;">

Mf4.

</td>
<td style="text-align:left;">

Mf4.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

101

</td>
<td style="text-align:left;">

Trombidiformes

</td>
<td style="text-align:left;">

mf5.

</td>
<td style="text-align:left;">

Mf5.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

101

</td>
<td style="text-align:left;">

Trombidiformes

</td>
<td style="text-align:left;">

Mf5.

</td>
<td style="text-align:left;">

Mf5.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

10

</td>
</tr>
<tr>
<td style="text-align:right;">

101

</td>
<td style="text-align:left;">

Trombidiformes

</td>
<td style="text-align:left;">

mf6.

</td>
<td style="text-align:left;">

Mf6.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

101

</td>
<td style="text-align:left;">

Trombidiformes

</td>
<td style="text-align:left;">

Mf6.

</td>
<td style="text-align:left;">

Mf6.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

26

</td>
</tr>
<tr>
<td style="text-align:right;">

101

</td>
<td style="text-align:left;">

Trombidiformes

</td>
<td style="text-align:left;">

Mf7.

</td>
<td style="text-align:left;">

Mf7.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:right;">

101

</td>
<td style="text-align:left;">

Trombidiformes

</td>
<td style="text-align:left;">

Mf8.

</td>
<td style="text-align:left;">

Mf8.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

264

</td>
<td style="text-align:left;">

Brachycera

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SOR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

268

</td>
<td style="text-align:left;">

Arctiidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

270

</td>
<td style="text-align:left;">

Baetidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

23

</td>
</tr>
<tr>
<td style="text-align:right;">

274

</td>
<td style="text-align:left;">

Chironomidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

276

</td>
<td style="text-align:left;">

Chrysomelidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

277

</td>
<td style="text-align:left;">

Coenagrionidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

8

</td>
</tr>
<tr>
<td style="text-align:right;">

279

</td>
<td style="text-align:left;">

Crambidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

A1-A2 solamente con 3 setas dorsales en fila, no llega a A7.

</td>
<td style="text-align:left;">

A1-A2 solamente con 3 setas dorsales en fila, no llega a A7.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

279

</td>
<td style="text-align:left;">

Crambidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Setas dorsales solo en A1, branquias sin ramificar

</td>
<td style="text-align:left;">

Setas dorsales solo en A1, branquias sin ramificar

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

279

</td>
<td style="text-align:left;">

Crambidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

11

</td>
</tr>
<tr>
<td style="text-align:right;">

279

</td>
<td style="text-align:left;">

Crambidae

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

279

</td>
<td style="text-align:left;">

Crambidae

</td>
<td style="text-align:left;">

Mf3.

</td>
<td style="text-align:left;">

Mf3.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

280

</td>
<td style="text-align:left;">

Curculionidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

una larva

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

280

</td>
<td style="text-align:left;">

Curculionidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

14

</td>
</tr>
<tr>
<td style="text-align:right;">

280

</td>
<td style="text-align:left;">

Curculionidae

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

283

</td>
<td style="text-align:left;">

Dolichopodidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

12

</td>
</tr>
<tr>
<td style="text-align:right;">

284

</td>
<td style="text-align:left;">

Dryopidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

285

</td>
<td style="text-align:left;">

Dycirtomidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

6

</td>
</tr>
<tr>
<td style="text-align:right;">

286

</td>
<td style="text-align:left;">

Dytiscidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

286

</td>
<td style="text-align:left;">

Dytiscidae

</td>
<td style="text-align:left;">

Mf. (larva)

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

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

287

</td>
<td style="text-align:left;">

Empididae

</td>
<td style="text-align:left;">

Mf. (larva)

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

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

288

</td>
<td style="text-align:left;">

Entomobryidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

293

</td>
<td style="text-align:left;">

Gerridae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

294

</td>
<td style="text-align:left;">

Glossiphoniidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

51

</td>
</tr>
<tr>
<td style="text-align:right;">

295

</td>
<td style="text-align:left;">

Gomphidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

299

</td>
<td style="text-align:left;">

Gyrinidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

300

</td>
<td style="text-align:left;">

Hydrobiidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

22

</td>
</tr>
<tr>
<td style="text-align:right;">

301

</td>
<td style="text-align:left;">

Hydroptilidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Tubo eppendorf

</td>
<td style="text-align:left;">

Tubo eppendorf

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

304

</td>
<td style="text-align:left;">

Lampyridae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

306

</td>
<td style="text-align:left;">

Leptophlebiidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

307

</td>
<td style="text-align:left;">

Libellulidae

</td>
<td style="text-align:left;">

mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

307

</td>
<td style="text-align:left;">

Libellulidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

309

</td>
<td style="text-align:left;">

Limnichidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

310

</td>
<td style="text-align:left;">

Lumbriculidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

6

</td>
</tr>
<tr>
<td style="text-align:right;">

311

</td>
<td style="text-align:left;">

Lutrochidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

313

</td>
<td style="text-align:left;">

Mesoveliidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

316

</td>
<td style="text-align:left;">

Muscidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

317

</td>
<td style="text-align:left;">

Naididae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

58

</td>
</tr>
<tr>
<td style="text-align:right;">

319

</td>
<td style="text-align:left;">

Noteridae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

325

</td>
<td style="text-align:left;">

Polycentropodidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

327

</td>
<td style="text-align:left;">

Psychodidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

328

</td>
<td style="text-align:left;">

Pyralidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

331

</td>
<td style="text-align:left;">

Sciaridae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

335

</td>
<td style="text-align:left;">

Staphylinidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

6 seg abd descubiertos, antenas de 11 segmentos.

</td>
<td style="text-align:left;">

6 seg abd descubiertos, antenas de 11 segmentos.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

335

</td>
<td style="text-align:left;">

Staphylinidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

335

</td>
<td style="text-align:left;">

Staphylinidae

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

3 seg abd descubiertos, antenas con 10 segmentos.

</td>
<td style="text-align:left;">

3 seg abd descubiertos, antenas con 10 segmentos.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

335

</td>
<td style="text-align:left;">

Staphylinidae

</td>
<td style="text-align:left;">

Mf3.

</td>
<td style="text-align:left;">

Mf3.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

336

</td>
<td style="text-align:left;">

Stratiomyidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

337

</td>
<td style="text-align:left;">

Tabanidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

14

</td>
</tr>
<tr>
<td style="text-align:right;">

339

</td>
<td style="text-align:left;">

Tipulidae

</td>
<td style="text-align:left;">

Mf. (larva)

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

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

340

</td>
<td style="text-align:left;">

Trichodactylidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

19

</td>
</tr>
<tr>
<td style="text-align:right;">

341

</td>
<td style="text-align:left;">

Trombidiidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

343

</td>
<td style="text-align:left;">

Veliidae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

754

</td>
<td style="text-align:left;">

Acentropinae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

755

</td>
<td style="text-align:left;">

Chironominae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

209

</td>
</tr>
<tr>
<td style="text-align:right;">

755

</td>
<td style="text-align:left;">

Chironominae

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

44

</td>
</tr>
<tr>
<td style="text-align:right;">

757

</td>
<td style="text-align:left;">

Orthocladiinae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

77

</td>
</tr>
<tr>
<td style="text-align:right;">

757

</td>
<td style="text-align:left;">

Orthocladiinae

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

41

</td>
</tr>
<tr>
<td style="text-align:right;">

759

</td>
<td style="text-align:left;">

Stratiomyinae

</td>
<td style="text-align:left;">

mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

759

</td>
<td style="text-align:left;">

Stratiomyinae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

8

</td>
</tr>
<tr>
<td style="text-align:right;">

759

</td>
<td style="text-align:left;">

Stratiomyinae

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

760

</td>
<td style="text-align:left;">

Tachyporinae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

761

</td>
<td style="text-align:left;">

Tanypodinae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

199

</td>
</tr>
<tr>
<td style="text-align:right;">

786

</td>
<td style="text-align:left;">

Bidessini

</td>
<td style="text-align:left;">

Mf. (larva)

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

TR

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

787

</td>
<td style="text-align:left;">

Acanthagrion

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

2+2 menton, 3+3 palpos, dientes bien definidos.

</td>
<td style="text-align:left;">

2+2 menton, 3+3 palpos, dientes bien definidos.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

787

</td>
<td style="text-align:left;">

Acanthagrion

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

16

</td>
</tr>
<tr>
<td style="text-align:right;">

795

</td>
<td style="text-align:left;">

Aedeomyia

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

6

</td>
</tr>
<tr>
<td style="text-align:right;">

796

</td>
<td style="text-align:left;">

Agriogomphus

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

Pterotecas poco desarrolladas

</td>
<td style="text-align:left;">

Pterotecas poco desarrolladas

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

796

</td>
<td style="text-align:left;">

Agriogomphus

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

15

</td>
</tr>
<tr>
<td style="text-align:right;">

801

</td>
<td style="text-align:left;">

Alluaudomyia

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

71

</td>
</tr>
<tr>
<td style="text-align:right;">

804

</td>
<td style="text-align:left;">

Ambrysus

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

43

</td>
</tr>
<tr>
<td style="text-align:right;">

805

</td>
<td style="text-align:left;">

Americabaetis

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

807

</td>
<td style="text-align:left;">

Anacaena

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

7

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

72 records

</caption>
<thead>
<tr>
<th style="text-align:right;">

cd_tax

</th>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

identification_qualifier

</th>
<th style="text-align:left;">

name_morfo

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:left;">

pseudo_rank

</th>
<th style="text-align:right;">

count

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">

265

</td>
<td style="text-align:left;">

Acanthaceae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

271

</td>
<td style="text-align:left;">

Bombacaceae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

281

</td>
<td style="text-align:left;">

Cyperaceae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

11

</td>
</tr>
<tr>
<td style="text-align:right;">

281

</td>
<td style="text-align:left;">

Cyperaceae

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

281

</td>
<td style="text-align:left;">

Cyperaceae

</td>
<td style="text-align:left;">

Mf3.

</td>
<td style="text-align:left;">

Mf3.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

281

</td>
<td style="text-align:left;">

Cyperaceae

</td>
<td style="text-align:left;">

Mf4.

</td>
<td style="text-align:left;">

Mf4.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

281

</td>
<td style="text-align:left;">

Cyperaceae

</td>
<td style="text-align:left;">

Mf5.

</td>
<td style="text-align:left;">

Mf5.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

308

</td>
<td style="text-align:left;">

Liliaceae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

312

</td>
<td style="text-align:left;">

Marantaceae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

324

</td>
<td style="text-align:left;">

Poaceae

</td>
<td style="text-align:left;">

Mf3.

</td>
<td style="text-align:left;">

Mf3.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

324

</td>
<td style="text-align:left;">

Poaceae

</td>
<td style="text-align:left;">

Mf4.

</td>
<td style="text-align:left;">

Mf4.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

345

</td>
<td style="text-align:left;">

Xyridaceae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

793

</td>
<td style="text-align:left;">

Adiantum

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

800

</td>
<td style="text-align:left;">

Allophylus

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

818

</td>
<td style="text-align:left;">

Anthurium

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

818

</td>
<td style="text-align:left;">

Anthurium

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

818

</td>
<td style="text-align:left;">

Anthurium

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

818

</td>
<td style="text-align:left;">

Anthurium

</td>
<td style="text-align:left;">

sp4.

</td>
<td style="text-align:left;">

sp4.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

829

</td>
<td style="text-align:left;">

Asplenium

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

10

</td>
</tr>
<tr>
<td style="text-align:right;">

829

</td>
<td style="text-align:left;">

Asplenium

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

869

</td>
<td style="text-align:left;">

Calathea

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

873

</td>
<td style="text-align:left;">

Calyptrocarya

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

881

</td>
<td style="text-align:left;">

Cardamine

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

883

</td>
<td style="text-align:left;">

Casearia

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

893

</td>
<td style="text-align:left;">

Ceratopteris

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

913

</td>
<td style="text-align:left;">

Cololejeunea

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

924

</td>
<td style="text-align:left;">

Costus

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

936

</td>
<td style="text-align:left;">

Cyclanthus

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

961

</td>
<td style="text-align:left;">

Dicranopygium

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

977

</td>
<td style="text-align:left;">

Echinodorus

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

977

</td>
<td style="text-align:left;">

Echinodorus

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

980

</td>
<td style="text-align:left;">

Eleocharis

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

980

</td>
<td style="text-align:left;">

Eleocharis

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1038

</td>
<td style="text-align:left;">

Heliconia

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1068

</td>
<td style="text-align:left;">

Hylaeanthe

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1068

</td>
<td style="text-align:left;">

Hylaeanthe

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1068

</td>
<td style="text-align:left;">

Hylaeanthe

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1069

</td>
<td style="text-align:left;">

Hymenophyllum

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1071

</td>
<td style="text-align:left;">

Hypolytrum

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1075

</td>
<td style="text-align:left;">

Ischnosiphon

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1115

</td>
<td style="text-align:left;">

Ludwigia

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1150

</td>
<td style="text-align:left;">

Metzgeria

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1168

</td>
<td style="text-align:left;">

Monotagma

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1198

</td>
<td style="text-align:left;">

Nymphoides

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

1205

</td>
<td style="text-align:left;">

Olyra

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1247

</td>
<td style="text-align:left;">

Philodendron

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

7

</td>
</tr>
<tr>
<td style="text-align:right;">

1247

</td>
<td style="text-align:left;">

Philodendron

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

1247

</td>
<td style="text-align:left;">

Philodendron

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

6

</td>
</tr>
<tr>
<td style="text-align:right;">

1247

</td>
<td style="text-align:left;">

Philodendron

</td>
<td style="text-align:left;">

sp4.

</td>
<td style="text-align:left;">

sp4.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1247

</td>
<td style="text-align:left;">

Philodendron

</td>
<td style="text-align:left;">

sp5.

</td>
<td style="text-align:left;">

sp5.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

1247

</td>
<td style="text-align:left;">

Philodendron

</td>
<td style="text-align:left;">

sp6.

</td>
<td style="text-align:left;">

sp6.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1247

</td>
<td style="text-align:left;">

Philodendron

</td>
<td style="text-align:left;">

sp7.

</td>
<td style="text-align:left;">

sp7.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1268

</td>
<td style="text-align:left;">

Pontederia

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1270

</td>
<td style="text-align:left;">

Potamogeton

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

1270

</td>
<td style="text-align:left;">

Potamogeton

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

1299

</td>
<td style="text-align:left;">

Renealmia

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1304

</td>
<td style="text-align:left;">

Rhodospatha

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1313

</td>
<td style="text-align:left;">

Salvinia

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1317

</td>
<td style="text-align:left;">

Scleria

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1317

</td>
<td style="text-align:left;">

Scleria

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1332

</td>
<td style="text-align:left;">

Spathiphyllum

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1332

</td>
<td style="text-align:left;">

Spathiphyllum

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1349

</td>
<td style="text-align:left;">

Stenospermation

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1367

</td>
<td style="text-align:left;">

Syngonanthus

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1406

</td>
<td style="text-align:left;">

Utricularia

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

1406

</td>
<td style="text-align:left;">

Utricularia

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1406

</td>
<td style="text-align:left;">

Utricularia

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

1421

</td>
<td style="text-align:left;">

Xyris

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

2334

</td>
<td style="text-align:left;">

Benjaminia reflexa

</td>
<td style="text-align:left;">

cf. Benjaminia reflexa

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

2392

</td>
<td style="text-align:left;">

Calyptrocarya glomerulata

</td>
<td style="text-align:left;">

cf. Calyptrocarya glomerulata

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

3164

</td>
<td style="text-align:left;">

Panicum laxum

</td>
<td style="text-align:left;">

cf. Panicum laxum

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

3557

</td>
<td style="text-align:left;">

Vallisneria americana

</td>
<td style="text-align:left;">

cf. Vallisneria americana

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:right;">

2

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

49 records

</caption>
<thead>
<tr>
<th style="text-align:right;">

cd_tax

</th>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

identification_qualifier

</th>
<th style="text-align:left;">

name_morfo

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:left;">

pseudo_rank

</th>
<th style="text-align:right;">

count

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">

9

</td>
<td style="text-align:left;">

Nematoda

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

PHY

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:right;">

28

</td>
</tr>
<tr>
<td style="text-align:right;">

35

</td>
<td style="text-align:left;">

Maxillopoda

</td>
<td style="text-align:left;">

mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

28

</td>
</tr>
<tr>
<td style="text-align:right;">

35

</td>
<td style="text-align:left;">

Maxillopoda

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

81

</td>
</tr>
<tr>
<td style="text-align:right;">

35

</td>
<td style="text-align:left;">

Maxillopoda

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

56

</td>
</tr>
<tr>
<td style="text-align:right;">

802

</td>
<td style="text-align:left;">

Alona

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

802

</td>
<td style="text-align:left;">

Alona

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

822

</td>
<td style="text-align:left;">

Arcella

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

95

</td>
</tr>
<tr>
<td style="text-align:right;">

822

</td>
<td style="text-align:left;">

Arcella

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

24

</td>
</tr>
<tr>
<td style="text-align:right;">

828

</td>
<td style="text-align:left;">

Asplanchna

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

14

</td>
</tr>
<tr>
<td style="text-align:right;">

845

</td>
<td style="text-align:left;">

Beauchampiella

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

851

</td>
<td style="text-align:left;">

Bosmina

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

10

</td>
</tr>
<tr>
<td style="text-align:right;">

851

</td>
<td style="text-align:left;">

Bosmina

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

8

</td>
</tr>
<tr>
<td style="text-align:right;">

851

</td>
<td style="text-align:left;">

Bosmina

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

854

</td>
<td style="text-align:left;">

Brachionus

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

854

</td>
<td style="text-align:left;">

Brachionus

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

17

</td>
</tr>
<tr>
<td style="text-align:right;">

854

</td>
<td style="text-align:left;">

Brachionus

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

854

</td>
<td style="text-align:left;">

Brachionus

</td>
<td style="text-align:left;">

sp4.

</td>
<td style="text-align:left;">

sp4.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

10

</td>
</tr>
<tr>
<td style="text-align:right;">

854

</td>
<td style="text-align:left;">

Brachionus

</td>
<td style="text-align:left;">

sp5.

</td>
<td style="text-align:left;">

sp5.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

888

</td>
<td style="text-align:left;">

Cephalodella

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

894

</td>
<td style="text-align:left;">

Ceriodaphnia

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

956

</td>
<td style="text-align:left;">

Diaphanosoma

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

960

</td>
<td style="text-align:left;">

Dicranophorus

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

969

</td>
<td style="text-align:left;">

Dipleuchlanis

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

983

</td>
<td style="text-align:left;">

Encentrum

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

990

</td>
<td style="text-align:left;">

Epiphanes

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1010

</td>
<td style="text-align:left;">

Filinia

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

13

</td>
</tr>
<tr>
<td style="text-align:right;">

1051

</td>
<td style="text-align:left;">

Heterocypris

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

29

</td>
</tr>
<tr>
<td style="text-align:right;">

1083

</td>
<td style="text-align:left;">

Keratella

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

17

</td>
</tr>
<tr>
<td style="text-align:right;">

1083

</td>
<td style="text-align:left;">

Keratella

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1094

</td>
<td style="text-align:left;">

Lecane

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

1094

</td>
<td style="text-align:left;">

Lecane

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

31

</td>
</tr>
<tr>
<td style="text-align:right;">

1094

</td>
<td style="text-align:left;">

Lecane

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

8

</td>
</tr>
<tr>
<td style="text-align:right;">

1094

</td>
<td style="text-align:left;">

Lecane

</td>
<td style="text-align:left;">

sp4.

</td>
<td style="text-align:left;">

sp4.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

7

</td>
</tr>
<tr>
<td style="text-align:right;">

1094

</td>
<td style="text-align:left;">

Lecane

</td>
<td style="text-align:left;">

sp5.

</td>
<td style="text-align:left;">

sp5.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1094

</td>
<td style="text-align:left;">

Lecane

</td>
<td style="text-align:left;">

sp6.

</td>
<td style="text-align:left;">

sp6.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1097

</td>
<td style="text-align:left;">

Lepadella

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

1121

</td>
<td style="text-align:left;">

Macrochaetus

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

1126

</td>
<td style="text-align:left;">

Macrothrix

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

1144

</td>
<td style="text-align:left;">

Mesocyclops

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

23

</td>
</tr>
<tr>
<td style="text-align:right;">

1162

</td>
<td style="text-align:left;">

Moina

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

21

</td>
</tr>
<tr>
<td style="text-align:right;">

1162

</td>
<td style="text-align:left;">

Moina

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

15

</td>
</tr>
<tr>
<td style="text-align:right;">

1166

</td>
<td style="text-align:left;">

Monommata

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1176

</td>
<td style="text-align:left;">

Mytilina

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

1265

</td>
<td style="text-align:left;">

Polyarthra

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

8

</td>
</tr>
<tr>
<td style="text-align:right;">

1271

</td>
<td style="text-align:left;">

Prionodiaptomus

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

17

</td>
</tr>
<tr>
<td style="text-align:right;">

1272

</td>
<td style="text-align:left;">

Proales

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

33

</td>
</tr>
<tr>
<td style="text-align:right;">

1378

</td>
<td style="text-align:left;">

Testudinella

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

13

</td>
</tr>
<tr>
<td style="text-align:right;">

1391

</td>
<td style="text-align:left;">

Trichocerca

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

8

</td>
</tr>
<tr>
<td style="text-align:right;">

1393

</td>
<td style="text-align:left;">

Trichotria

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

Displaying records 1 - 100

</caption>
<thead>
<tr>
<th style="text-align:right;">

cd_tax

</th>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

identification_qualifier

</th>
<th style="text-align:left;">

name_morfo

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:left;">

pseudo_rank

</th>
<th style="text-align:right;">

count

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">

32

</td>
<td style="text-align:left;">

Chlorophyceae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

33

</td>
<td style="text-align:left;">

Euglenophyceae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

79

</td>
<td style="text-align:left;">

Achnanthales

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

80

</td>
<td style="text-align:left;">

Chlamydomonadales

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

80

</td>
<td style="text-align:left;">

Chlamydomonadales

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:right;">

80

</td>
<td style="text-align:left;">

Chlamydomonadales

</td>
<td style="text-align:left;">

Mf3.

</td>
<td style="text-align:left;">

Mf3.

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

81

</td>
<td style="text-align:left;">

Chroococcales

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

87

</td>
<td style="text-align:left;">

Naviculales

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

92

</td>
<td style="text-align:left;">

Oscillatoriales

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

266

</td>
<td style="text-align:left;">

Achnanthidiaceae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

7

</td>
</tr>
<tr>
<td style="text-align:right;">

266

</td>
<td style="text-align:left;">

Achnanthidiaceae

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

266

</td>
<td style="text-align:left;">

Achnanthidiaceae

</td>
<td style="text-align:left;">

Mf3.

</td>
<td style="text-align:left;">

Mf3.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

266

</td>
<td style="text-align:left;">

Achnanthidiaceae

</td>
<td style="text-align:left;">

Mf4.

</td>
<td style="text-align:left;">

Mf4.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

6

</td>
</tr>
<tr>
<td style="text-align:right;">

282

</td>
<td style="text-align:left;">

Desmidiaceae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

292

</td>
<td style="text-align:left;">

Fragilariaceae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

292

</td>
<td style="text-align:left;">

Fragilariaceae

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

321

</td>
<td style="text-align:left;">

Oscillatoriaceae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

322

</td>
<td style="text-align:left;">

Phormidiaceae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

326

</td>
<td style="text-align:left;">

Pseudanabaenaceae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

789

</td>
<td style="text-align:left;">

Achnanthidium

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

790

</td>
<td style="text-align:left;">

Actinella

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

790

</td>
<td style="text-align:left;">

Actinella

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

790

</td>
<td style="text-align:left;">

Actinella

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

790

</td>
<td style="text-align:left;">

Actinella

</td>
<td style="text-align:left;">

sp4.

</td>
<td style="text-align:left;">

sp4.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

791

</td>
<td style="text-align:left;">

Actinotaenium

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

791

</td>
<td style="text-align:left;">

Actinotaenium

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

791

</td>
<td style="text-align:left;">

Actinotaenium

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

792

</td>
<td style="text-align:left;">

Acutodesmus

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

806

</td>
<td style="text-align:left;">

Anabaena

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

35

</td>
</tr>
<tr>
<td style="text-align:right;">

813

</td>
<td style="text-align:left;">

Ankistrodesmus

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

10

</td>
</tr>
<tr>
<td style="text-align:right;">

819

</td>
<td style="text-align:left;">

Aphanocapsa

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

826

</td>
<td style="text-align:left;">

Arthrodesmus

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

836

</td>
<td style="text-align:left;">

Audouinella

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

837

</td>
<td style="text-align:left;">

Aulacoseira

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

33

</td>
</tr>
<tr>
<td style="text-align:right;">

843

</td>
<td style="text-align:left;">

Bambusina

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

13

</td>
</tr>
<tr>
<td style="text-align:right;">

852

</td>
<td style="text-align:left;">

Botryococcus

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

17

</td>
</tr>
<tr>
<td style="text-align:right;">

858

</td>
<td style="text-align:left;">

Brachysira

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

865

</td>
<td style="text-align:left;">

Bulbochaete

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

880

</td>
<td style="text-align:left;">

Capartogramma

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

7

</td>
</tr>
<tr>
<td style="text-align:right;">

887

</td>
<td style="text-align:left;">

Centritractus

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

892

</td>
<td style="text-align:left;">

Ceratium

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

900

</td>
<td style="text-align:left;">

Chlamydomonas

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp10.

</td>
<td style="text-align:left;">

sp10.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp11.

</td>
<td style="text-align:left;">

sp11.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp12.

</td>
<td style="text-align:left;">

sp12.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp13.

</td>
<td style="text-align:left;">

sp13.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp14.

</td>
<td style="text-align:left;">

sp14.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp15.

</td>
<td style="text-align:left;">

sp15.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp16.

</td>
<td style="text-align:left;">

sp16.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp17.

</td>
<td style="text-align:left;">

sp17.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

28

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

22

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp4.

</td>
<td style="text-align:left;">

sp4.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

29

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp5.

</td>
<td style="text-align:left;">

sp5.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp6.

</td>
<td style="text-align:left;">

sp6.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

27

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp7.

</td>
<td style="text-align:left;">

sp7.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

19

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp8.

</td>
<td style="text-align:left;">

sp8.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp9.

</td>
<td style="text-align:left;">

sp9.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

909

</td>
<td style="text-align:left;">

Coelastrum

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

35

</td>
</tr>
<tr>
<td style="text-align:right;">

910

</td>
<td style="text-align:left;">

Coelosphaerium

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

915

</td>
<td style="text-align:left;">

Comasiella

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp10.

</td>
<td style="text-align:left;">

sp10.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp11.

</td>
<td style="text-align:left;">

sp11.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp12.

</td>
<td style="text-align:left;">

sp12.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

6

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp13.

</td>
<td style="text-align:left;">

sp13.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp14.

</td>
<td style="text-align:left;">

sp14.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp15.

</td>
<td style="text-align:left;">

sp15.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp16.

</td>
<td style="text-align:left;">

sp16.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

18

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp4.

</td>
<td style="text-align:left;">

sp4.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp5.

</td>
<td style="text-align:left;">

sp5.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

23

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp6.

</td>
<td style="text-align:left;">

sp6.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp7.

</td>
<td style="text-align:left;">

sp7.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

6

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp8.

</td>
<td style="text-align:left;">

sp8.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp9.

</td>
<td style="text-align:left;">

sp9.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

929

</td>
<td style="text-align:left;">

Crucigenia

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

931

</td>
<td style="text-align:left;">

Cryptomonas

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

26

</td>
</tr>
<tr>
<td style="text-align:right;">

953

</td>
<td style="text-align:left;">

Desmidium

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

30

</td>
</tr>
<tr>
<td style="text-align:right;">

953

</td>
<td style="text-align:left;">

Desmidium

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

963

</td>
<td style="text-align:left;">

Dictyosphaerium

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

966

</td>
<td style="text-align:left;">

Didymocystis

</td>
<td style="text-align:left;">

cf. Didymocystis sp.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

12

</td>
</tr>
<tr>
<td style="text-align:right;">

967

</td>
<td style="text-align:left;">

Dimorphococcus

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

15

</td>
</tr>
<tr>
<td style="text-align:right;">

968

</td>
<td style="text-align:left;">

Dinobryon

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

971

</td>
<td style="text-align:left;">

Dolichospermum

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

984

</td>
<td style="text-align:left;">

Encyonema

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

984

</td>
<td style="text-align:left;">

Encyonema

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

985

</td>
<td style="text-align:left;">

Encyonopsis

</td>
<td style="text-align:left;">

cf. Encyonopsis sp.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

985

</td>
<td style="text-align:left;">

Encyonopsis

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

998

</td>
<td style="text-align:left;">

Euastrum

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

998

</td>
<td style="text-align:left;">

Euastrum

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

998

</td>
<td style="text-align:left;">

Euastrum

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

7

</td>
</tr>
<tr>
<td style="text-align:right;">

998

</td>
<td style="text-align:left;">

Euastrum

</td>
<td style="text-align:left;">

sp4.

</td>
<td style="text-align:left;">

sp4.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

998

</td>
<td style="text-align:left;">

Euastrum

</td>
<td style="text-align:left;">

sp5.

</td>
<td style="text-align:left;">

sp5.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

998

</td>
<td style="text-align:left;">

Euastrum

</td>
<td style="text-align:left;">

sp6.

</td>
<td style="text-align:left;">

sp6.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

998

</td>
<td style="text-align:left;">

Euastrum

</td>
<td style="text-align:left;">

sp7.

</td>
<td style="text-align:left;">

sp7.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

999

</td>
<td style="text-align:left;">

Eudorina

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

62

</td>
</tr>
<tr>
<td style="text-align:right;">

1001

</td>
<td style="text-align:left;">

Euglena

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

30

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

Displaying records 1 - 100

</caption>
<thead>
<tr>
<th style="text-align:right;">

cd_tax

</th>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

identification_qualifier

</th>
<th style="text-align:left;">

name_morfo

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:left;">

pseudo_rank

</th>
<th style="text-align:right;">

count

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">

32

</td>
<td style="text-align:left;">

Chlorophyceae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

37

</td>
<td style="text-align:left;">

Ulvophyceae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

CL

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

79

</td>
<td style="text-align:left;">

Achnanthales

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

80

</td>
<td style="text-align:left;">

Chlamydomonadales

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

92

</td>
<td style="text-align:left;">

Oscillatoriales

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

96

</td>
<td style="text-align:left;">

Sphaeropleales

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

99

</td>
<td style="text-align:left;">

Synechococcaceae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

OR

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

266

</td>
<td style="text-align:left;">

Achnanthidiaceae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

42

</td>
</tr>
<tr>
<td style="text-align:right;">

266

</td>
<td style="text-align:left;">

Achnanthidiaceae

</td>
<td style="text-align:left;">

Mf10.

</td>
<td style="text-align:left;">

Mf10.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

266

</td>
<td style="text-align:left;">

Achnanthidiaceae

</td>
<td style="text-align:left;">

Mf11.

</td>
<td style="text-align:left;">

Mf11.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

266

</td>
<td style="text-align:left;">

Achnanthidiaceae

</td>
<td style="text-align:left;">

Mf12.

</td>
<td style="text-align:left;">

Mf12.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

11

</td>
</tr>
<tr>
<td style="text-align:right;">

266

</td>
<td style="text-align:left;">

Achnanthidiaceae

</td>
<td style="text-align:left;">

Mf13.

</td>
<td style="text-align:left;">

Mf13.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

266

</td>
<td style="text-align:left;">

Achnanthidiaceae

</td>
<td style="text-align:left;">

Mf14.

</td>
<td style="text-align:left;">

Mf14.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

266

</td>
<td style="text-align:left;">

Achnanthidiaceae

</td>
<td style="text-align:left;">

Mf15.

</td>
<td style="text-align:left;">

Mf15.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

266

</td>
<td style="text-align:left;">

Achnanthidiaceae

</td>
<td style="text-align:left;">

Mf16.

</td>
<td style="text-align:left;">

Mf16.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

6

</td>
</tr>
<tr>
<td style="text-align:right;">

266

</td>
<td style="text-align:left;">

Achnanthidiaceae

</td>
<td style="text-align:left;">

Mf17.

</td>
<td style="text-align:left;">

Mf17.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

266

</td>
<td style="text-align:left;">

Achnanthidiaceae

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

Mf2.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

7

</td>
</tr>
<tr>
<td style="text-align:right;">

266

</td>
<td style="text-align:left;">

Achnanthidiaceae

</td>
<td style="text-align:left;">

Mf3.

</td>
<td style="text-align:left;">

Mf3.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

24

</td>
</tr>
<tr>
<td style="text-align:right;">

266

</td>
<td style="text-align:left;">

Achnanthidiaceae

</td>
<td style="text-align:left;">

Mf4.

</td>
<td style="text-align:left;">

Mf4.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

266

</td>
<td style="text-align:left;">

Achnanthidiaceae

</td>
<td style="text-align:left;">

Mf5.

</td>
<td style="text-align:left;">

Mf5.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

17

</td>
</tr>
<tr>
<td style="text-align:right;">

266

</td>
<td style="text-align:left;">

Achnanthidiaceae

</td>
<td style="text-align:left;">

Mf6.

</td>
<td style="text-align:left;">

Mf6.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

8

</td>
</tr>
<tr>
<td style="text-align:right;">

266

</td>
<td style="text-align:left;">

Achnanthidiaceae

</td>
<td style="text-align:left;">

Mf7.

</td>
<td style="text-align:left;">

Mf7.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

13

</td>
</tr>
<tr>
<td style="text-align:right;">

266

</td>
<td style="text-align:left;">

Achnanthidiaceae

</td>
<td style="text-align:left;">

Mf8.

</td>
<td style="text-align:left;">

Mf8.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

266

</td>
<td style="text-align:left;">

Achnanthidiaceae

</td>
<td style="text-align:left;">

Mf9.

</td>
<td style="text-align:left;">

Mf9.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

20

</td>
</tr>
<tr>
<td style="text-align:right;">

275

</td>
<td style="text-align:left;">

Chroococcaceae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

296

</td>
<td style="text-align:left;">

Gomphonemataceae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

321

</td>
<td style="text-align:left;">

Oscillatoriaceae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

326

</td>
<td style="text-align:left;">

Pseudanabaenaceae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

17

</td>
</tr>
<tr>
<td style="text-align:right;">

342

</td>
<td style="text-align:left;">

Ulotrichaceae

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

Mf1.

</td>
<td style="text-align:left;">

FAM

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

789

</td>
<td style="text-align:left;">

Achnanthidium

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

789

</td>
<td style="text-align:left;">

Achnanthidium

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

8

</td>
</tr>
<tr>
<td style="text-align:right;">

789

</td>
<td style="text-align:left;">

Achnanthidium

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

790

</td>
<td style="text-align:left;">

Actinella

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

790

</td>
<td style="text-align:left;">

Actinella

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

790

</td>
<td style="text-align:left;">

Actinella

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

790

</td>
<td style="text-align:left;">

Actinella

</td>
<td style="text-align:left;">

sp4.

</td>
<td style="text-align:left;">

sp4.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

791

</td>
<td style="text-align:left;">

Actinotaenium

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

791

</td>
<td style="text-align:left;">

Actinotaenium

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

791

</td>
<td style="text-align:left;">

Actinotaenium

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

792

</td>
<td style="text-align:left;">

Acutodesmus

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

806

</td>
<td style="text-align:left;">

Anabaena

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

24

</td>
</tr>
<tr>
<td style="text-align:right;">

810

</td>
<td style="text-align:left;">

Aneumastus

</td>
<td style="text-align:left;">

cf. Aneumastus sp.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

813

</td>
<td style="text-align:left;">

Ankistrodesmus

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

11

</td>
</tr>
<tr>
<td style="text-align:right;">

816

</td>
<td style="text-align:left;">

Anomoeoneis

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

836

</td>
<td style="text-align:left;">

Audouinella

</td>
<td style="text-align:left;">

cf. Audouinella sp.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

836

</td>
<td style="text-align:left;">

Audouinella

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

17

</td>
</tr>
<tr>
<td style="text-align:right;">

836

</td>
<td style="text-align:left;">

Audouinella

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

837

</td>
<td style="text-align:left;">

Aulacoseira

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

17

</td>
</tr>
<tr>
<td style="text-align:right;">

842

</td>
<td style="text-align:left;">

Ballia

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

6

</td>
</tr>
<tr>
<td style="text-align:right;">

843

</td>
<td style="text-align:left;">

Bambusina

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

852

</td>
<td style="text-align:left;">

Botryococcus

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

865

</td>
<td style="text-align:left;">

Bulbochaete

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

871

</td>
<td style="text-align:left;">

Caloneis

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

880

</td>
<td style="text-align:left;">

Capartogramma

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

10

</td>
</tr>
<tr>
<td style="text-align:right;">

887

</td>
<td style="text-align:left;">

Centritractus

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

899

</td>
<td style="text-align:left;">

Characium

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

7

</td>
</tr>
<tr>
<td style="text-align:right;">

899

</td>
<td style="text-align:left;">

Characium

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

900

</td>
<td style="text-align:left;">

Chlamydomonas

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:right;">

901

</td>
<td style="text-align:left;">

Chroococcus

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

903

</td>
<td style="text-align:left;">

Cladophora

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

7

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

25

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp10.

</td>
<td style="text-align:left;">

sp10.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

11

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp11.

</td>
<td style="text-align:left;">

sp11.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp12.

</td>
<td style="text-align:left;">

sp12.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp13.

</td>
<td style="text-align:left;">

sp13.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp14.

</td>
<td style="text-align:left;">

sp14.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

16

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp4.

</td>
<td style="text-align:left;">

sp4.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

6

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp5.

</td>
<td style="text-align:left;">

sp5.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp6.

</td>
<td style="text-align:left;">

sp6.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

6

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp7.

</td>
<td style="text-align:left;">

sp7.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp8.

</td>
<td style="text-align:left;">

sp8.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

7

</td>
</tr>
<tr>
<td style="text-align:right;">

906

</td>
<td style="text-align:left;">

Closterium

</td>
<td style="text-align:left;">

sp9.

</td>
<td style="text-align:left;">

sp9.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

909

</td>
<td style="text-align:left;">

Coelastrum

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

18

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

sp1.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

28

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp10.

</td>
<td style="text-align:left;">

sp10.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp11.

</td>
<td style="text-align:left;">

sp11.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp12.

</td>
<td style="text-align:left;">

sp12.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp13.

</td>
<td style="text-align:left;">

sp13.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp14.

</td>
<td style="text-align:left;">

sp14.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

11

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp15.

</td>
<td style="text-align:left;">

sp15.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp16.

</td>
<td style="text-align:left;">

sp16.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp17.

</td>
<td style="text-align:left;">

sp17.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

7

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp18.

</td>
<td style="text-align:left;">

sp18.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp19.

</td>
<td style="text-align:left;">

sp19.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

sp2.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

18

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp20.

</td>
<td style="text-align:left;">

sp20.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp21.

</td>
<td style="text-align:left;">

sp21.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp22.

</td>
<td style="text-align:left;">

sp22.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp23.

</td>
<td style="text-align:left;">

sp23.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp24.

</td>
<td style="text-align:left;">

sp24.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp25.

</td>
<td style="text-align:left;">

sp25.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp26.

</td>
<td style="text-align:left;">

sp26.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp27.

</td>
<td style="text-align:left;">

sp27.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp28.

</td>
<td style="text-align:left;">

sp28.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

sp3.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

32

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp4.

</td>
<td style="text-align:left;">

sp4.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

19

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp5.

</td>
<td style="text-align:left;">

sp5.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

922

</td>
<td style="text-align:left;">

Cosmarium

</td>
<td style="text-align:left;">

sp6.

</td>
<td style="text-align:left;">

sp6.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

15 records

</caption>
<thead>
<tr>
<th style="text-align:right;">

cd_tax

</th>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

identification_qualifier

</th>
<th style="text-align:left;">

name_morfo

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:left;">

pseudo_rank

</th>
<th style="text-align:right;">

count

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">

941

</td>
<td style="text-align:left;">

Cynea

</td>
<td style="text-align:left;">

sp1

</td>
<td style="text-align:left;">

sp1

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

941

</td>
<td style="text-align:left;">

Cynea

</td>
<td style="text-align:left;">

sp2

</td>
<td style="text-align:left;">

sp2

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

947

</td>
<td style="text-align:left;">

Decinea

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1146

</td>
<td style="text-align:left;">

Mesosemia

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1161

</td>
<td style="text-align:left;">

Modestia

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

23

</td>
</tr>
<tr>
<td style="text-align:right;">

1174

</td>
<td style="text-align:left;">

Mylon

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1340

</td>
<td style="text-align:left;">

Staphylus

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

2379

</td>
<td style="text-align:left;">

Calephelis laverna

</td>
<td style="text-align:left;">

cf. laverna

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

2385

</td>
<td style="text-align:left;">

Callimormus corus

</td>
<td style="text-align:left;">

cf. corus

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

2390

</td>
<td style="text-align:left;">

Calycopis trebula

</td>
<td style="text-align:left;">

cf. trebula

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

2592

</td>
<td style="text-align:left;">

Cynea corisana

</td>
<td style="text-align:left;">

cf. corisana

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

2593

</td>
<td style="text-align:left;">

Cynea popla

</td>
<td style="text-align:left;">

cf. popla

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:right;">

72

</td>
</tr>
<tr>
<td style="text-align:right;">

3096

</td>
<td style="text-align:left;">

Nisoniades benda

</td>
<td style="text-align:left;">

cf. benda

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

3097

</td>
<td style="text-align:left;">

Nisoniades bessus

</td>
<td style="text-align:left;">

cf. bessus

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:right;">

7

</td>
</tr>
<tr>
<td style="text-align:right;">

3739

</td>
<td style="text-align:left;">

Pyrrhopyge phidias latifasciata

</td>
<td style="text-align:left;">

cf. phidias latifasciata

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SUBSP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:right;">

2

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

4 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

table_orig

</th>
<th style="text-align:left;">

row.names

</th>
<th style="text-align:left;">

kingdom

</th>
<th style="text-align:left;">

phylum

</th>
<th style="text-align:left;">

class

</th>
<th style="text-align:left;">

order

</th>
<th style="text-align:left;">

family

</th>
<th style="text-align:left;">

subfamily

</th>
<th style="text-align:left;">

genus

</th>
<th style="text-align:left;">

specific_epithet

</th>
<th style="text-align:left;">

infraspecific_epithet

</th>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

scientific_name_authorship

</th>
<th style="text-align:left;">

taxon_rank

</th>
<th style="text-align:left;">

vernacular_name

</th>
<th style="text-align:left;">

identification_qualifier

</th>
<th style="text-align:left;">

identification_remarks

</th>
<th style="text-align:right;">

cd_tax

</th>
<th style="text-align:right;">

cd_morfo

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

peces_registros

</td>
<td style="text-align:left;">

811

</td>
<td style="text-align:left;">

Animalia

</td>
<td style="text-align:left;">

Chordata

</td>
<td style="text-align:left;">

Actinopterygii

</td>
<td style="text-align:left;">

Siluriformes

</td>
<td style="text-align:left;">

Heptapteridae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

Heptapterinae

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

Subfamilia

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

Gen. nov. et sp. nov.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

756

</td>
<td style="text-align:right;">

NA

</td>
</tr>
<tr>
<td style="text-align:left;">

peces_registros

</td>
<td style="text-align:left;">

1010

</td>
<td style="text-align:left;">

Animalia

</td>
<td style="text-align:left;">

Chordata

</td>
<td style="text-align:left;">

Actinopterygii

</td>
<td style="text-align:left;">

Siluriformes

</td>
<td style="text-align:left;">

Heptapteridae

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

NA

</td>
<td style="text-align:left;">

Heptapterinae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

Subfamilia

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

Gen. nov. et sp. nov.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

756

</td>
<td style="text-align:right;">

NA

</td>
</tr>
<tr>
<td style="text-align:left;">

peces_registros

</td>
<td style="text-align:left;">

1485

</td>
<td style="text-align:left;">

Animalia

</td>
<td style="text-align:left;">

Chordata

</td>
<td style="text-align:left;">

Actinopterygii

</td>
<td style="text-align:left;">

Siluriformes

</td>
<td style="text-align:left;">

Heptapteridae

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

NA

</td>
<td style="text-align:left;">

Heptapterinae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

Subfamilia

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

Gen. nov. et sp. nov.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

756

</td>
<td style="text-align:right;">

NA

</td>
</tr>
<tr>
<td style="text-align:left;">

peces_registros

</td>
<td style="text-align:left;">

1830

</td>
<td style="text-align:left;">

Animalia

</td>
<td style="text-align:left;">

Chordata

</td>
<td style="text-align:left;">

Actinopterygii

</td>
<td style="text-align:left;">

Siluriformes

</td>
<td style="text-align:left;">

Heptapteridae

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

NA

</td>
<td style="text-align:left;">

Heptapterinae

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

Subfamilia

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

Gen. nov. et sp. nov.

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

756

</td>
<td style="text-align:right;">

NA

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

77 records

</caption>
<thead>
<tr>
<th style="text-align:right;">

cd_tax

</th>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

identification_qualifier

</th>
<th style="text-align:left;">

name_morfo

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:left;">

pseudo_rank

</th>
<th style="text-align:left;">

identification_remarks

</th>
<th style="text-align:right;">

count

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">

756

</td>
<td style="text-align:left;">

Heptapterinae

</td>
<td style="text-align:left;">

Gen. nov. et sp. nov.

</td>
<td style="text-align:left;">

Gen. nov. et sp. nov.

</td>
<td style="text-align:left;">

SFAM

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

832

</td>
<td style="text-align:left;">

Astyanax

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

37

</td>
</tr>
<tr>
<td style="text-align:right;">

832

</td>
<td style="text-align:left;">

Astyanax

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

29

</td>
</tr>
<tr>
<td style="text-align:right;">

832

</td>
<td style="text-align:left;">

Astyanax

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

6

</td>
</tr>
<tr>
<td style="text-align:right;">

898

</td>
<td style="text-align:left;">

Characidium

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1045

</td>
<td style="text-align:left;">

Hemibrycon

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1059

</td>
<td style="text-align:left;">

Hoplias

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1073

</td>
<td style="text-align:left;">

Hypostomus

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1392

</td>
<td style="text-align:left;">

Trichomycterus

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

sp. 1

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

1392

</td>
<td style="text-align:left;">

Trichomycterus

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1392

</td>
<td style="text-align:left;">

Trichomycterus

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

sp. 2

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

2215

</td>
<td style="text-align:left;">

Acestrocephalus anomalus

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

2233

</td>
<td style="text-align:left;">

Ageneiosus pardalis

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

2259

</td>
<td style="text-align:left;">

Ancistrus caucanus

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:right;">

2260

</td>
<td style="text-align:left;">

Andinoacara latifrons

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

30

</td>
</tr>
<tr>
<td style="text-align:right;">

2278

</td>
<td style="text-align:left;">

Apteronotus milesi

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

2292

</td>
<td style="text-align:left;">

Argopleura magdalenensis

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

2313

</td>
<td style="text-align:left;">

Astyanax filiferus

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

2314

</td>
<td style="text-align:left;">

Astyanax magdalenae

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

38

</td>
</tr>
<tr>
<td style="text-align:right;">

2315

</td>
<td style="text-align:left;">

Astyanax yariguies

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

2346

</td>
<td style="text-align:left;">

Brachyhypopomus occidentalis

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:right;">

2355

</td>
<td style="text-align:left;">

Brycon henni

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

2356

</td>
<td style="text-align:left;">

Brycon moorei

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

2361

</td>
<td style="text-align:left;">

Bunocephalus colombianus

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

10

</td>
</tr>
<tr>
<td style="text-align:right;">

2381

</td>
<td style="text-align:left;">

Callichthys oibaensis

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

2420

</td>
<td style="text-align:left;">

Caquetaia kraussii

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

23

</td>
</tr>
<tr>
<td style="text-align:right;">

2471

</td>
<td style="text-align:left;">

Cetopsis othonops

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

2475

</td>
<td style="text-align:left;">

Characidium boavistae

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

2476

</td>
<td style="text-align:left;">

Characidium zebra

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

16

</td>
</tr>
<tr>
<td style="text-align:right;">

2476

</td>
<td style="text-align:left;">

Characidium zebra

</td>
<td style="text-align:left;">

cf. zebra

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

2551

</td>
<td style="text-align:left;">

Creagrutus affinis

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

2552

</td>
<td style="text-align:left;">

Creagrutus magdalenae

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

6

</td>
</tr>
<tr>
<td style="text-align:right;">

2571

</td>
<td style="text-align:left;">

Crossoloricaria cephalaspis

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

2572

</td>
<td style="text-align:left;">

Crossoloricaria variegata

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

2578

</td>
<td style="text-align:left;">

Ctenolucius hujeta

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

19

</td>
</tr>
<tr>
<td style="text-align:right;">

2583

</td>
<td style="text-align:left;">

Curimata mivartii

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

2595

</td>
<td style="text-align:left;">

Cynopotamus magdalenae

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

2601

</td>
<td style="text-align:left;">

Cyphocharax magdalenae

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

19

</td>
</tr>
<tr>
<td style="text-align:right;">

2610

</td>
<td style="text-align:left;">

Dasyloricaria filamentosa

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

2684

</td>
<td style="text-align:left;">

Eigenmannia camposi

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

26

</td>
</tr>
<tr>
<td style="text-align:right;">

2736

</td>
<td style="text-align:left;">

Farlowella yarigui

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

2763

</td>
<td style="text-align:left;">

Gasteropelecus maculatus

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

15

</td>
</tr>
<tr>
<td style="text-align:right;">

2766

</td>
<td style="text-align:left;">

Geophagus steindachneri

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

6

</td>
</tr>
<tr>
<td style="text-align:right;">

2769

</td>
<td style="text-align:left;">

Gephyrocharax melanocheir

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

13

</td>
</tr>
<tr>
<td style="text-align:right;">

2826

</td>
<td style="text-align:left;">

Hoplias malabaricus

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

10

</td>
</tr>
<tr>
<td style="text-align:right;">

2827

</td>
<td style="text-align:left;">

Hoplosternum magdalenae

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

2839

</td>
<td style="text-align:left;">

Hyphessobrycon natagaima

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

26

</td>
</tr>
<tr>
<td style="text-align:right;">

2839

</td>
<td style="text-align:left;">

Hyphessobrycon natagaima

</td>
<td style="text-align:left;">

aff. natagaima

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

44

</td>
</tr>
<tr>
<td style="text-align:right;">

2846

</td>
<td style="text-align:left;">

Hypostomus hondae

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

6

</td>
</tr>
<tr>
<td style="text-align:right;">

2849

</td>
<td style="text-align:left;">

Ichthyoelephas longirostris

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

2879

</td>
<td style="text-align:left;">

Kronoheros umbrifer

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

2918

</td>
<td style="text-align:left;">

Leporinus striatus

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

2943

</td>
<td style="text-align:left;">

Loricariichthys brunneus

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

2989

</td>
<td style="text-align:left;">

Megaleporinus muyscorum

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

2993

</td>
<td style="text-align:left;">

Megalonema xanthum

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

3074

</td>
<td style="text-align:left;">

Nanocheirodon insignis

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

6

</td>
</tr>
<tr>
<td style="text-align:right;">

3140

</td>
<td style="text-align:left;">

Oreochromis niloticus

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

3182

</td>
<td style="text-align:left;">

Parodon magdalenensis

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

3243

</td>
<td style="text-align:left;">

Pimelodella floridablancaensis

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

6

</td>
</tr>
<tr>
<td style="text-align:right;">

3244

</td>
<td style="text-align:left;">

Pimelodus grosskopfii

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

3245

</td>
<td style="text-align:left;">

Pimelodus yuma

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

3266

</td>
<td style="text-align:left;">

Poecilia caucana

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

27

</td>
</tr>
<tr>
<td style="text-align:right;">

3282

</td>
<td style="text-align:left;">

Potamotrygon magdalenae

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

3290

</td>
<td style="text-align:left;">

Prochilodus magdalenae

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

10

</td>
</tr>
<tr>
<td style="text-align:right;">

3316

</td>
<td style="text-align:left;">

Pseudopimelodus atricaudus

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

3344

</td>
<td style="text-align:left;">

Rhamdia guatemalensis

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:right;">

3355

</td>
<td style="text-align:left;">

Rineloricaria magdalenae

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

17

</td>
</tr>
<tr>
<td style="text-align:right;">

3361

</td>
<td style="text-align:left;">

Rivulus xi

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:right;">

3362

</td>
<td style="text-align:left;">

Roeboides dayi

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

21

</td>
</tr>
<tr>
<td style="text-align:right;">

3372

</td>
<td style="text-align:left;">

Saccoderma hastata

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

12

</td>
</tr>
<tr>
<td style="text-align:right;">

3443

</td>
<td style="text-align:left;">

Sternopygus aequilabiatus

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

3461

</td>
<td style="text-align:left;">

Sturisomatichthys aureus

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

10

</td>
</tr>
<tr>
<td style="text-align:right;">

3476

</td>
<td style="text-align:left;">

Synbranchus marmoratus

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

7

</td>
</tr>
<tr>
<td style="text-align:right;">

3524

</td>
<td style="text-align:left;">

Trachelyopterus insignis

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

7

</td>
</tr>
<tr>
<td style="text-align:right;">

3532

</td>
<td style="text-align:left;">

Trichopodus pectoralis

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:right;">

3533

</td>
<td style="text-align:left;">

Trichopodus trichopterus

</td>
<td style="text-align:left;">

aff. trichopterus

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

3537

</td>
<td style="text-align:left;">

Triportheus magdalenae

</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

ERROR_RANK

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

8

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

71 records

</caption>
<thead>
<tr>
<th style="text-align:right;">

cd_tax

</th>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

identification_qualifier

</th>
<th style="text-align:left;">

name_morfo

</th>
<th style="text-align:left;">

identification_remarks

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:left;">

pseudo_rank

</th>
<th style="text-align:right;">

count

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">

839

</td>
<td style="text-align:left;">

Azteca

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 1

</td>
<td style="text-align:left;">

Morfotipo 1

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

839

</td>
<td style="text-align:left;">

Azteca

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 2

</td>
<td style="text-align:left;">

Morfotipo 2

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

11

</td>
</tr>
<tr>
<td style="text-align:right;">

839

</td>
<td style="text-align:left;">

Azteca

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 3

</td>
<td style="text-align:left;">

Morfotipo 3

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

14

</td>
</tr>
<tr>
<td style="text-align:right;">

839

</td>
<td style="text-align:left;">

Azteca

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 4

</td>
<td style="text-align:left;">

Morfotipo 4

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

18

</td>
</tr>
<tr>
<td style="text-align:right;">

839

</td>
<td style="text-align:left;">

Azteca

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 5

</td>
<td style="text-align:left;">

Morfotipo 5

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

839

</td>
<td style="text-align:left;">

Azteca

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 6

</td>
<td style="text-align:left;">

Morfotipo 6

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

839

</td>
<td style="text-align:left;">

Azteca

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 7

</td>
<td style="text-align:left;">

Morfotipo 7

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

6

</td>
</tr>
<tr>
<td style="text-align:right;">

857

</td>
<td style="text-align:left;">

Brachymyrmex

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 1

</td>
<td style="text-align:left;">

Morfotipo 1

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

875

</td>
<td style="text-align:left;">

Camponotus

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 1

</td>
<td style="text-align:left;">

Morfotipo 1

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

6

</td>
</tr>
<tr>
<td style="text-align:right;">

875

</td>
<td style="text-align:left;">

Camponotus

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 10

</td>
<td style="text-align:left;">

Morfotipo 10

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

875

</td>
<td style="text-align:left;">

Camponotus

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 11

</td>
<td style="text-align:left;">

Morfotipo 11

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

875

</td>
<td style="text-align:left;">

Camponotus

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 2

</td>
<td style="text-align:left;">

Morfotipo 2

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

875

</td>
<td style="text-align:left;">

Camponotus

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 3

</td>
<td style="text-align:left;">

Morfotipo 3

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

41

</td>
</tr>
<tr>
<td style="text-align:right;">

875

</td>
<td style="text-align:left;">

Camponotus

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 6

</td>
<td style="text-align:left;">

Morfotipo 6

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

875

</td>
<td style="text-align:left;">

Camponotus

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 8

</td>
<td style="text-align:left;">

Morfotipo 8

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

29

</td>
</tr>
<tr>
<td style="text-align:right;">

875

</td>
<td style="text-align:left;">

Camponotus

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 9

</td>
<td style="text-align:left;">

Morfotipo 9

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:right;">

926

</td>
<td style="text-align:left;">

Crematogaster

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 1

</td>
<td style="text-align:left;">

Morfotipo 1

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

8

</td>
</tr>
<tr>
<td style="text-align:right;">

970

</td>
<td style="text-align:left;">

Dolichoderus

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 1

</td>
<td style="text-align:left;">

Morfotipo 1

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

970

</td>
<td style="text-align:left;">

Dolichoderus

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 4

</td>
<td style="text-align:left;">

Morfotipo 4

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:right;">

970

</td>
<td style="text-align:left;">

Dolichoderus

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 5

</td>
<td style="text-align:left;">

Morfotipo 5

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

5

</td>
</tr>
<tr>
<td style="text-align:right;">

970

</td>
<td style="text-align:left;">

Dolichoderus

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 6

</td>
<td style="text-align:left;">

Morfotipo 6

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

970

</td>
<td style="text-align:left;">

Dolichoderus

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 7

</td>
<td style="text-align:left;">

Morfotipo 7

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

970

</td>
<td style="text-align:left;">

Dolichoderus

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 8

</td>
<td style="text-align:left;">

Morfotipo 8

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1072

</td>
<td style="text-align:left;">

Hypoponera

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 1

</td>
<td style="text-align:left;">

Morfotipo 1

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

33

</td>
</tr>
<tr>
<td style="text-align:right;">

1072

</td>
<td style="text-align:left;">

Hypoponera

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 11

</td>
<td style="text-align:left;">

Morfotipo 11

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1072

</td>
<td style="text-align:left;">

Hypoponera

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 12

</td>
<td style="text-align:left;">

Morfotipo 12

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1072

</td>
<td style="text-align:left;">

Hypoponera

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 13

</td>
<td style="text-align:left;">

Morfotipo 13

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1072

</td>
<td style="text-align:left;">

Hypoponera

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 14

</td>
<td style="text-align:left;">

Morfotipo 14

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1072

</td>
<td style="text-align:left;">

Hypoponera

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 15

</td>
<td style="text-align:left;">

Morfotipo 15

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1072

</td>
<td style="text-align:left;">

Hypoponera

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 16

</td>
<td style="text-align:left;">

Morfotipo 16

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1072

</td>
<td style="text-align:left;">

Hypoponera

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 17

</td>
<td style="text-align:left;">

Morfotipo 17

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1072

</td>
<td style="text-align:left;">

Hypoponera

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 18

</td>
<td style="text-align:left;">

Morfotipo 18

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1072

</td>
<td style="text-align:left;">

Hypoponera

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 19

</td>
<td style="text-align:left;">

Morfotipo 19

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1072

</td>
<td style="text-align:left;">

Hypoponera

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 3

</td>
<td style="text-align:left;">

Morfotipo 3

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1072

</td>
<td style="text-align:left;">

Hypoponera

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 4

</td>
<td style="text-align:left;">

Morfotipo 4

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

13

</td>
</tr>
<tr>
<td style="text-align:right;">

1072

</td>
<td style="text-align:left;">

Hypoponera

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 6

</td>
<td style="text-align:left;">

Morfotipo 6

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

6

</td>
</tr>
<tr>
<td style="text-align:right;">

1072

</td>
<td style="text-align:left;">

Hypoponera

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 7

</td>
<td style="text-align:left;">

Morfotipo 7

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1072

</td>
<td style="text-align:left;">

Hypoponera

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 9

</td>
<td style="text-align:left;">

Morfotipo 9

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1112

</td>
<td style="text-align:left;">

Linepithema

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 1

</td>
<td style="text-align:left;">

Morfotipo 1

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1172

</td>
<td style="text-align:left;">

Mycetomoellerius

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 1

</td>
<td style="text-align:left;">

Morfotipo 1

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1197

</td>
<td style="text-align:left;">

Nylanderia

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 1

</td>
<td style="text-align:left;">

Morfotipo 1

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:right;">

1246

</td>
<td style="text-align:left;">

Pheidole

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 1

</td>
<td style="text-align:left;">

Morfotipo 1

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

53

</td>
</tr>
<tr>
<td style="text-align:right;">

1246

</td>
<td style="text-align:left;">

Pheidole

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 10

</td>
<td style="text-align:left;">

Morfotipo 10

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1246

</td>
<td style="text-align:left;">

Pheidole

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 2

</td>
<td style="text-align:left;">

Morfotipo 2

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

12

</td>
</tr>
<tr>
<td style="text-align:right;">

1246

</td>
<td style="text-align:left;">

Pheidole

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 3

</td>
<td style="text-align:left;">

Morfotipo 3

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1246

</td>
<td style="text-align:left;">

Pheidole

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 4

</td>
<td style="text-align:left;">

Morfotipo 4

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

1246

</td>
<td style="text-align:left;">

Pheidole

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 5

</td>
<td style="text-align:left;">

Morfotipo 5

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1246

</td>
<td style="text-align:left;">

Pheidole

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 6

</td>
<td style="text-align:left;">

Morfotipo 6

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

47

</td>
</tr>
<tr>
<td style="text-align:right;">

1246

</td>
<td style="text-align:left;">

Pheidole

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 7

</td>
<td style="text-align:left;">

Morfotipo 7

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:right;">

1288

</td>
<td style="text-align:left;">

Pseudomyrmex

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 1

</td>
<td style="text-align:left;">

Morfotipo 1

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1288

</td>
<td style="text-align:left;">

Pseudomyrmex

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 10

</td>
<td style="text-align:left;">

Morfotipo 10

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1288

</td>
<td style="text-align:left;">

Pseudomyrmex

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 11

</td>
<td style="text-align:left;">

Morfotipo 11

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1288

</td>
<td style="text-align:left;">

Pseudomyrmex

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 12

</td>
<td style="text-align:left;">

Morfotipo 12

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1288

</td>
<td style="text-align:left;">

Pseudomyrmex

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 13

</td>
<td style="text-align:left;">

Morfotipo 13

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1288

</td>
<td style="text-align:left;">

Pseudomyrmex

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 14

</td>
<td style="text-align:left;">

Morfotipo 14

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1288

</td>
<td style="text-align:left;">

Pseudomyrmex

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 15

</td>
<td style="text-align:left;">

Morfotipo 15

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1288

</td>
<td style="text-align:left;">

Pseudomyrmex

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 17

</td>
<td style="text-align:left;">

Morfotipo 17

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1288

</td>
<td style="text-align:left;">

Pseudomyrmex

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 3

</td>
<td style="text-align:left;">

Morfotipo 3

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1307

</td>
<td style="text-align:left;">

Rhopalothrix

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 1

</td>
<td style="text-align:left;">

Morfotipo 1

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

17

</td>
</tr>
<tr>
<td style="text-align:right;">

1331

</td>
<td style="text-align:left;">

Solenopsis

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 1

</td>
<td style="text-align:left;">

Morfotipo 1

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

481

</td>
</tr>
<tr>
<td style="text-align:right;">

1331

</td>
<td style="text-align:left;">

Solenopsis

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 10

</td>
<td style="text-align:left;">

Morfotipo 10

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

17

</td>
</tr>
<tr>
<td style="text-align:right;">

1331

</td>
<td style="text-align:left;">

Solenopsis

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 11

</td>
<td style="text-align:left;">

Morfotipo 11

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

10

</td>
</tr>
<tr>
<td style="text-align:right;">

1331

</td>
<td style="text-align:left;">

Solenopsis

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 12

</td>
<td style="text-align:left;">

Morfotipo 12

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1331

</td>
<td style="text-align:left;">

Solenopsis

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 3

</td>
<td style="text-align:left;">

Morfotipo 3

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

157

</td>
</tr>
<tr>
<td style="text-align:right;">

1331

</td>
<td style="text-align:left;">

Solenopsis

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 4

</td>
<td style="text-align:left;">

Morfotipo 4

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:right;">

1331

</td>
<td style="text-align:left;">

Solenopsis

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 5

</td>
<td style="text-align:left;">

Morfotipo 5

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1331

</td>
<td style="text-align:left;">

Solenopsis

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 6

</td>
<td style="text-align:left;">

Morfotipo 6

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:right;">

1331

</td>
<td style="text-align:left;">

Solenopsis

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 7

</td>
<td style="text-align:left;">

Morfotipo 7

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1331

</td>
<td style="text-align:left;">

Solenopsis

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 9

</td>
<td style="text-align:left;">

Morfotipo 9

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

11

</td>
</tr>
<tr>
<td style="text-align:right;">

1356

</td>
<td style="text-align:left;">

Strumigenys

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 2

</td>
<td style="text-align:left;">

Morfotipo 2

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1417

</td>
<td style="text-align:left;">

Xenomyrmex

</td>
<td style="text-align:left;">

sp.

</td>
<td style="text-align:left;">

Morfotipo 1

</td>
<td style="text-align:left;">

Morfotipo 1

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

1

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

0 records

</caption>
<thead>
<tr>
<th style="text-align:right;">

cd_tax

</th>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

identification_qualifier

</th>
<th style="text-align:left;">

identification_remarks

</th>
</tr>
</thead>
<tbody>
<tr>
</tr>
</tbody>
</table>

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

<table>
<caption>

Displaying records 1 - 100

</caption>
<thead>
<tr>
<th style="text-align:right;">

cd_tax

</th>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

identification_qualifier

</th>
<th style="text-align:left;">

identification_remarks

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1213

</td>
<td style="text-align:left;">

Ortalis

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1139

</td>
<td style="text-align:left;">

Megascops

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1213

</td>
<td style="text-align:left;">

Ortalis

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1213

</td>
<td style="text-align:left;">

Ortalis

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1213

</td>
<td style="text-align:left;">

Ortalis

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1213

</td>
<td style="text-align:left;">

Ortalis

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

884

</td>
<td style="text-align:left;">

Catharus

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
<tr>
<td style="text-align:right;">

1106

</td>
<td style="text-align:left;">

Leptotila

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

NA

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

2 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:right;">

count

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

GN

</td>
<td style="text-align:right;">

1912

</td>
</tr>
<tr>
<td style="text-align:left;">

SP

</td>
<td style="text-align:right;">

65644

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

3 records

</caption>
<thead>
<tr>
<th style="text-align:right;">

cd_tax

</th>
<th style="text-align:left;">

scientific_name

</th>
<th style="text-align:left;">

identification_qualifier

</th>
<th style="text-align:left;">

name_morfo

</th>
<th style="text-align:left;">

cd_rank

</th>
<th style="text-align:left;">

pseudo_rank

</th>
<th style="text-align:left;">

identification_remarks

</th>
<th style="text-align:right;">

count

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">

833

</td>
<td style="text-align:left;">

Atractus

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

Atractus sp.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1098

</td>
<td style="text-align:left;">

Lepidoblepharis

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

Lepidoblepharis sp.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:right;">

1118

</td>
<td style="text-align:left;">

Mabuya

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:left;">

Mabuya sp.

</td>
<td style="text-align:left;">

GN

</td>
<td style="text-align:left;">

SP

</td>
<td style="text-align:left;">

NA

</td>
<td style="text-align:right;">

18

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

10 records

</caption>
<thead>
<tr>
<th style="text-align:right;">

cd_tax

</th>
<th style="text-align:left;">

name_tax

</th>
<th style="text-align:right;">

cd_family

</th>
<th style="text-align:left;">

name_tax

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">

1267

</td>
<td style="text-align:left;">

Pomacea

</td>
<td style="text-align:right;">

357

</td>
<td style="text-align:left;">

Ampullariidae

</td>
</tr>
<tr>
<td style="text-align:right;">

881

</td>
<td style="text-align:left;">

Cardamine

</td>
<td style="text-align:right;">

395

</td>
<td style="text-align:left;">

Brassicaceae

</td>
</tr>
<tr>
<td style="text-align:right;">

2313

</td>
<td style="text-align:left;">

Astyanax filiferus

</td>
<td style="text-align:right;">

426

</td>
<td style="text-align:left;">

Characidae

</td>
</tr>
<tr>
<td style="text-align:right;">

1050

</td>
<td style="text-align:left;">

Heterelmis

</td>
<td style="text-align:right;">

487

</td>
<td style="text-align:left;">

Elmidae

</td>
</tr>
<tr>
<td style="text-align:right;">

1892

</td>
<td style="text-align:left;">

Monomorium

</td>
<td style="text-align:right;">

500

</td>
<td style="text-align:left;">

Formicidae

</td>
</tr>
<tr>
<td style="text-align:right;">

2856

</td>
<td style="text-align:left;">

Imparfinis usmai

</td>
<td style="text-align:right;">

520

</td>
<td style="text-align:left;">

Heptapteridae

</td>
</tr>
<tr>
<td style="text-align:right;">

2895

</td>
<td style="text-align:left;">

Lecane elegans

</td>
<td style="text-align:right;">

547

</td>
<td style="text-align:left;">

Lecanidae

</td>
</tr>
<tr>
<td style="text-align:right;">

2888

</td>
<td style="text-align:left;">

Laterallus albigularis

</td>
<td style="text-align:right;">

677

</td>
<td style="text-align:left;">

Rallidae

</td>
</tr>
<tr>
<td style="text-align:right;">

3515

</td>
<td style="text-align:left;">

Thraupis palmarum

</td>
<td style="text-align:right;">

725

</td>
<td style="text-align:left;">

Thraupidae

</td>
</tr>
<tr>
<td style="text-align:right;">

1987

</td>
<td style="text-align:left;">

Pheugopedius

</td>
<td style="text-align:right;">

738

</td>
<td style="text-align:left;">

Troglodytidae

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

83 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

table_orig

</th>
<th style="text-align:left;">

class

</th>
<th style="text-align:right;">

count

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

anfibios_registros

</td>
<td style="text-align:left;">

Amphibia

</td>
<td style="text-align:right;">

2211

</td>
</tr>
<tr>
<td style="text-align:left;">

atropellamientos_registros

</td>
<td style="text-align:left;">

Aves

</td>
<td style="text-align:right;">

16

</td>
</tr>
<tr>
<td style="text-align:left;">

atropellamientos_registros

</td>
<td style="text-align:left;">

Amphibia

</td>
<td style="text-align:right;">

17

</td>
</tr>
<tr>
<td style="text-align:left;">

atropellamientos_registros

</td>
<td style="text-align:left;">

Mammalia

</td>
<td style="text-align:right;">

38

</td>
</tr>
<tr>
<td style="text-align:left;">

atropellamientos_registros

</td>
<td style="text-align:left;">

Reptilia

</td>
<td style="text-align:right;">

38

</td>
</tr>
<tr>
<td style="text-align:left;">

aves_registros

</td>
<td style="text-align:left;">

Aves

</td>
<td style="text-align:right;">

10249

</td>
</tr>
<tr>
<td style="text-align:left;">

botanica_registros_arborea

</td>
<td style="text-align:left;">

Pinopsida

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

botanica_registros_arborea

</td>
<td style="text-align:left;">

Liliopsida

</td>
<td style="text-align:right;">

61

</td>
</tr>
<tr>
<td style="text-align:left;">

botanica_registros_arborea

</td>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:right;">

4111

</td>
</tr>
<tr>
<td style="text-align:left;">

botanica_registros_col

</td>
<td style="text-align:left;">

Pinopsida

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

botanica_registros_col

</td>
<td style="text-align:left;">

Liliopsida

</td>
<td style="text-align:right;">

11

</td>
</tr>
<tr>
<td style="text-align:left;">

botanica_registros_col

</td>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:right;">

118

</td>
</tr>
<tr>
<td style="text-align:left;">

botanica_registros_epi_novas

</td>
<td style="text-align:left;">

Agaricomycetes

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

botanica_registros_epi_novas

</td>
<td style="text-align:left;">

Bryopsida

</td>
<td style="text-align:right;">

52

</td>
</tr>
<tr>
<td style="text-align:left;">

botanica_registros_epi_novas

</td>
<td style="text-align:left;">

Dothideomycetes

</td>
<td style="text-align:right;">

61

</td>
</tr>
<tr>
<td style="text-align:left;">

botanica_registros_epi_novas

</td>
<td style="text-align:left;">

Eurotiomycetes

</td>
<td style="text-align:right;">

83

</td>
</tr>
<tr>
<td style="text-align:left;">

botanica_registros_epi_novas

</td>
<td style="text-align:left;">

Jungermanniopsida

</td>
<td style="text-align:right;">

293

</td>
</tr>
<tr>
<td style="text-align:left;">

botanica_registros_epi_novas

</td>
<td style="text-align:left;">

Arthoniomycetes

</td>
<td style="text-align:right;">

550

</td>
</tr>
<tr>
<td style="text-align:left;">

botanica_registros_epi_novas

</td>
<td style="text-align:left;">

Lecanoromycetes

</td>
<td style="text-align:right;">

1530

</td>
</tr>
<tr>
<td style="text-align:left;">

botanica_registros_epi_vas

</td>
<td style="text-align:left;">

Liliopsida

</td>
<td style="text-align:right;">

27

</td>
</tr>
<tr>
<td style="text-align:left;">

cameras_trampa_registros

</td>
<td style="text-align:left;">

Reptilia

</td>
<td style="text-align:right;">

1299

</td>
</tr>
<tr>
<td style="text-align:left;">

cameras_trampa_registros

</td>
<td style="text-align:left;">

Aves

</td>
<td style="text-align:right;">

25170

</td>
</tr>
<tr>
<td style="text-align:left;">

cameras_trampa_registros

</td>
<td style="text-align:left;">

Mammalia

</td>
<td style="text-align:right;">

41087

</td>
</tr>
<tr>
<td style="text-align:left;">

collembolos_registros

</td>
<td style="text-align:left;">

Entognatha

</td>
<td style="text-align:right;">

5948

</td>
</tr>
<tr>
<td style="text-align:left;">

escarabajos_registros

</td>
<td style="text-align:left;">

Insecta

</td>
<td style="text-align:right;">

3908

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_fitoplancton

</td>
<td style="text-align:left;">

Chrysophyceae

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_fitoplancton

</td>
<td style="text-align:left;">

Florideophyceae

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_fitoplancton

</td>
<td style="text-align:left;">

Ulvophyceae

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_fitoplancton

</td>
<td style="text-align:left;">

Xanthophyceae

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_fitoplancton

</td>
<td style="text-align:left;">

Eustigmatophyceae

</td>
<td style="text-align:right;">

19

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_fitoplancton

</td>
<td style="text-align:left;">

Synurophyceae

</td>
<td style="text-align:right;">

20

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_fitoplancton

</td>
<td style="text-align:left;">

Dinophyceae

</td>
<td style="text-align:right;">

24

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_fitoplancton

</td>
<td style="text-align:left;">

Cryptophyceae

</td>
<td style="text-align:right;">

32

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_fitoplancton

</td>
<td style="text-align:left;">

Coscinodiscophyceae

</td>
<td style="text-align:right;">

35

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_fitoplancton

</td>
<td style="text-align:left;">

Trebouxiophyceae

</td>
<td style="text-align:right;">

50

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_fitoplancton

</td>
<td style="text-align:left;">

Cyanophyceae

</td>
<td style="text-align:right;">

223

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_fitoplancton

</td>
<td style="text-align:left;">

Chlorophyceae

</td>
<td style="text-align:right;">

290

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_fitoplancton

</td>
<td style="text-align:left;">

Euglenophyceae

</td>
<td style="text-align:right;">

354

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_fitoplancton

</td>
<td style="text-align:left;">

Bacillariophyceae

</td>
<td style="text-align:right;">

624

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_fitoplancton

</td>
<td style="text-align:left;">

Zygnematophyceae

</td>
<td style="text-align:right;">

699

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_macrofitas

</td>
<td style="text-align:left;">

Bryopsida

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_macrofitas

</td>
<td style="text-align:left;">

Jungermanniopsida

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_macrofitas

</td>
<td style="text-align:left;">

Selaginellopsida

</td>
<td style="text-align:right;">

17

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_macrofitas

</td>
<td style="text-align:left;">

Pteridopsida

</td>
<td style="text-align:right;">

25

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_macrofitas

</td>
<td style="text-align:left;">

Polypodiopsida

</td>
<td style="text-align:right;">

52

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_macrofitas

</td>
<td style="text-align:left;">

Magnoliopsida

</td>
<td style="text-align:right;">

117

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_macrofitas

</td>
<td style="text-align:left;">

Liliopsida

</td>
<td style="text-align:right;">

319

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_macroinvertebrados

</td>
<td style="text-align:left;">

Trepaxonemata

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_macroinvertebrados

</td>
<td style="text-align:left;">

Entognatha

</td>
<td style="text-align:right;">

8

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_macroinvertebrados

</td>
<td style="text-align:left;">

Malacostraca

</td>
<td style="text-align:right;">

27

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_macroinvertebrados

</td>
<td style="text-align:left;">

Branchiopoda

</td>
<td style="text-align:right;">

74

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_macroinvertebrados

</td>
<td style="text-align:left;">

Bivalvia

</td>
<td style="text-align:right;">

89

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_macroinvertebrados

</td>
<td style="text-align:left;">

Clitellata

</td>
<td style="text-align:right;">

115

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_macroinvertebrados

</td>
<td style="text-align:left;">

Euchelicerata

</td>
<td style="text-align:right;">

129

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_macroinvertebrados

</td>
<td style="text-align:left;">

Gastropoda

</td>
<td style="text-align:right;">

181

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_macroinvertebrados

</td>
<td style="text-align:left;">

Insecta

</td>
<td style="text-align:right;">

3845

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_perifiton

</td>
<td style="text-align:left;">

Synurophyceae

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_perifiton

</td>
<td style="text-align:left;">

Dinophyceae

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_perifiton

</td>
<td style="text-align:left;">

Xanthophyceae

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_perifiton

</td>
<td style="text-align:left;">

Klebsormidiophyceae

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_perifiton

</td>
<td style="text-align:left;">

Ulvophyceae

</td>
<td style="text-align:right;">

18

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_perifiton

</td>
<td style="text-align:left;">

Cryptophyceae

</td>
<td style="text-align:right;">

18

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_perifiton

</td>
<td style="text-align:left;">

Trebouxiophyceae

</td>
<td style="text-align:right;">

21

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_perifiton

</td>
<td style="text-align:left;">

Coscinodiscophyceae

</td>
<td style="text-align:right;">

24

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_perifiton

</td>
<td style="text-align:left;">

Florideophyceae

</td>
<td style="text-align:right;">

26

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_perifiton

</td>
<td style="text-align:left;">

Euglenophyceae

</td>
<td style="text-align:right;">

108

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_perifiton

</td>
<td style="text-align:left;">

Cyanophyceae

</td>
<td style="text-align:right;">

219

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_perifiton

</td>
<td style="text-align:left;">

Chlorophyceae

</td>
<td style="text-align:right;">

260

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_perifiton

</td>
<td style="text-align:left;">

Zygnematophyceae

</td>
<td style="text-align:right;">

593

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_perifiton

</td>
<td style="text-align:left;">

Bacillariophyceae

</td>
<td style="text-align:right;">

2013

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_zooplancton

</td>
<td style="text-align:left;">

Ostracoda

</td>
<td style="text-align:right;">

29

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_zooplancton

</td>
<td style="text-align:left;">

Branchiopoda

</td>
<td style="text-align:right;">

72

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_zooplancton

</td>
<td style="text-align:left;">

Lobosa

</td>
<td style="text-align:right;">

120

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_zooplancton

</td>
<td style="text-align:left;">

Maxillopoda

</td>
<td style="text-align:right;">

205

</td>
</tr>
<tr>
<td style="text-align:left;">

hidrobiologico_registros_zooplancton

</td>
<td style="text-align:left;">

Monogonta

</td>
<td style="text-align:right;">

388

</td>
</tr>
<tr>
<td style="text-align:left;">

hormigas_registros

</td>
<td style="text-align:left;">

Insecta

</td>
<td style="text-align:right;">

9245

</td>
</tr>
<tr>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

Mammalia

</td>
<td style="text-align:right;">

3709

</td>
</tr>
<tr>
<td style="text-align:left;">

mamiferos_us_registros

</td>
<td style="text-align:left;">

Insecta

</td>
<td style="text-align:right;">

59

</td>
</tr>
<tr>
<td style="text-align:left;">

mamiferos_us_registros

</td>
<td style="text-align:left;">

Mammalia

</td>
<td style="text-align:right;">

910

</td>
</tr>
<tr>
<td style="text-align:left;">

mariposas_registros

</td>
<td style="text-align:left;">

Insecta

</td>
<td style="text-align:right;">

3772

</td>
</tr>
<tr>
<td style="text-align:left;">

peces_registros

</td>
<td style="text-align:left;">

Chondrichthyes

</td>
<td style="text-align:right;">

2

</td>
</tr>
<tr>
<td style="text-align:left;">

peces_registros

</td>
<td style="text-align:left;">

Actinopterygii

</td>
<td style="text-align:right;">

1855

</td>
</tr>
<tr>
<td style="text-align:left;">

reptiles_registros

</td>
<td style="text-align:left;">

Reptilia

</td>
<td style="text-align:right;">

914

</td>
</tr>
</tbody>
</table>

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
