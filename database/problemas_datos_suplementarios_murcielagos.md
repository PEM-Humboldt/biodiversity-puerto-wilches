Problemas en las caracteristicas individuales de los murcielagos
================
Marius Bottin
2023-08-02

- [1 Mamiferos](#1-mamiferos)
  - [1.1 contar los casos](#11-contar-los-casos)
  - [1.2 Anotar los casos
    problematicos](#12-anotar-los-casos-problematicos)

------------------------------------------------------------------------

La idea de este documento es mirar cuales son las modificaciones que hay
que hacer sobre los datos de los murcielagos para que tengan sentido.

``` r
require(openxlsx)
```

    ## Loading required package: openxlsx

``` r
require(RPostgreSQL)
```

    ## Loading required package: RPostgreSQL

    ## Loading required package: DBI

``` r
fracking_db <- dbConnect(PostgreSQL(),dbname='fracking')
knitr::opts_chunk$set(tidy.opts = list(width.cutoff = 70), tidy = TRUE, connection="fracking_db", max.print=100)
def.chunk.hook  <- knitr::knit_hooks$get("chunk")
knitr::knit_hooks$set(chunk = function(x, options) {
  x <- def.chunk.hook(x, options)
  paste0("\n \\", "footnotesize","\n\n", x, "\n\n \\normalsize\n\n")
})
```

# 1 Mamiferos

## 1.1 contar los casos

``` sql
SELECT organism_quantity, sex, life_stage, reproductive_condition, count(*)
FROM raw_dwc.mamiferos_tot_registros 
WHERE (sex IS NOT NULL OR life_stage IS NOT NULL OR reproductive_condition IS NOT NULL)
GROUP BY organism_quantity, sex, life_stage, reproductive_condition
ORDER BY count(*) DESC
```

<div class="knitsql-table">

| organism_quantity | sex    | life_stage | reproductive_condition | count |
|:------------------|:-------|:-----------|:-----------------------|------:|
| 1                 | Hembra | Adulto     | No reproductiva        |   837 |
| 1                 | Macho  | Adulto     | Testículos inguinales  |   695 |
| 1                 | Hembra | Adulto     | Gestante               |   541 |
| 1                 | Macho  | Adulto     | Testículos escrotados  |   470 |
| 1                 | Macho  | Adulto     | Testículos escrotales  |   310 |
| 1                 | Hembra | Adulto     | Lactante               |   267 |
| 1                 | Hembra | Adulto     | Lactando               |   248 |
| 1                 | Macho  | Juvenil    | Testículos inguinales  |    91 |
| 1                 | Hembra | Juvenil    | No reproductiva        |    86 |
| 2                 | Hembra | Adulto     | Lactando               |    33 |
| 2                 | Hembra | Adulto     | Gestante               |    30 |
| 2                 | Hembra | Adulto     | Lactante               |    21 |
| 1                 | Macho  | Juvenil    | Testículos escrotados  |     9 |
| 1                 | Macho  | Juvenil    | Testículos escrotales  |     8 |
| 1                 | Macho  | Adulto     | No reproductiva        |     6 |
| 1                 | NA     | Juvenil    | NA                     |     6 |
| 1                 | NA     | Adulto     | NA                     |     5 |
| 1                 | Hembra | Juvenil    | Lactando               |     5 |
| 1                 | Macho  | Adulto     | NA                     |     3 |
| 3                 | Hembra | Adulto     | Gestante               |     3 |
| 1                 | Hembra | NA         | No reproductiva        |     3 |
| 1                 | Hembra | Adulto     | Testículos inguinales  |     3 |
| 1                 | Hembra | Juvenil    | Gestante               |     2 |
| 1                 | Macho  | Adulto     | Lactante               |     2 |
| 1                 | Macho  | Adulto     | Gestante               |     2 |
| 7                 | Hembra | Adulto     | Gestante               |     1 |
| 1                 | Hembra | NA         | NA                     |     1 |
| 4                 | Hembra | Adulto     | Gestante               |     1 |
| 2                 | Hembra | Juvenil    | Gestante               |     1 |
| 1                 | Hembra | Adulto     | Testículos escrotales  |     1 |
| 5                 | Hembra | Adulto     | Gestante               |     1 |
| 1                 | Hembra | Juvenil    | NA                     |     1 |
| 1                 | Macho  | NA         | Testículos escrotados  |     1 |
| 1                 | Macho  | Juvenil    | No reproductiva        |     1 |
| 1                 | Hembra | Adulto     | Lactando               |     1 |

35 records

</div>

## 1.2 Anotar los casos problematicos

``` sql
SELECT cd_reg, mtr.cd_event, cd_gp_event, e.event_id,
      mtr.occurrence_id,catalog_number, other_catalog_numbers,record_number, mtr.organism_id,
      protocol,organism_quantity, sex, life_stage, reproductive_condition,
      CASE
        WHEN sex~'Hembra' AND reproductive_condition ~ '[Tt]est[ií]' THEN true
        WHEN sex~'Macho' AND (reproductive_condition ~ '[Gg]estante' OR reproductive_condition ~ '[Ll]actante') THEN true
        WHEN sex~'Macho' AND reproductive_condition ~ 'reproductiva' THEN true
        ELSE false
      END "resolver_problema",
      CASE
        WHEN life_stage ~ 'Adult' AND reproductive_condition ~ 'No repro' THEN true
        WHEN life_stage ~ 'Adult' AND reproductive_condition ~ 'ingui' THEN true
        ELSE false
      END "averiguar",
      CASE
        WHEN sex~'Hembra' AND reproductive_condition ~ '[Tt]est[ií]' THEN 'Hembra con testículos'
        WHEN sex~'Macho' AND (reproductive_condition ~ '[Gg]estante' OR reproductive_condition ~ '[Ll]actante') THEN 'Macho gestante'
        WHEN sex~'Macho' AND reproductive_condition ~ 'reproductiva' THEN 'Macho no reproductiva?'
        WHEN life_stage ~ 'Adult' AND reproductive_condition ~ 'No repro' THEN 'Adult, pero no reproductivo?'
        WHEN life_stage ~ 'Adult' AND reproductive_condition ~ 'ingui' THEN 'Adult, pero no reproductivo?'
      END "descripcion_problema"
FROM raw_dwc.mamiferos_tot_registros mtr
LEFT JOIN main.registros r USING (cd_reg)
LEFT JOIN main.event e ON mtr.cd_event=e.cd_event
LEFT JOIN main.gp_event ge USING (cd_gp_event)
LEFT JOIN main.def_protocol p USING (cd_protocol)
WHERE --(sex IS NOT NULL OR life_stage IS NOT NULL OR reproductive_condition IS NOT NULL) AND
  protocol='Mist nets'
```

``` r
require(openxlsx)
write.xlsx(tab_problemas, file = "../../bpw_export/pb_murcielagos_carac_ind.xlsx")
```

``` r
dbDisconnect(fracking_db)
```

    ## [1] TRUE
