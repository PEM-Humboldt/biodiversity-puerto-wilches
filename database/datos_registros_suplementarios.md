Integración de los datos suplementarios de los grupos
================
Marius Bottin
2023-05-17

- [1 Hormigas](#1-hormigas)
  - [1.1 Individual characteristics](#11-individual-characteristics)
- [2 Escarabajos](#2-escarabajos)
  - [2.1 Individual characteristics](#21-individual-characteristics)
- [3 Hidrobiologicos](#3-hidrobiologicos)
  - [3.1 Cantidades que permiten pasar de la abundancia contada a las
    densidades](#31-cantidades-que-permiten-pasar-de-la-abundancia-contada-a-las-densidades)
- [4 Filtro de 30 minutos para considerar registros como independientes
  en cameras
  trampas](#4-filtro-de-30-minutos-para-considerar-registros-como-independientes-en-cameras-trampas)
- [5 Mamiferos](#5-mamiferos)
  - [5.1 Individual characteristics](#51-individual-characteristics)

------------------------------------------------------------------------

Se trata en este documento de añadir los datos que no hacen parte de las
variables principales de la estructura general de la base de datos, por
ejemplo:

- variables ambientales
- caracteristicas individuales de los individuos muestreados (formas de
  vida, sexo, edad etc)
- etc.

``` r
require(openxlsx)
require(RPostgreSQL)
fracking_db <- dbConnect(PostgreSQL(),dbname='fracking')
knitr::opts_chunk$set(tidy.opts = list(width.cutoff = 70), tidy = TRUE, connection="fracking_db", max.print=100)
def.chunk.hook  <- knitr::knit_hooks$get("chunk")
knitr::knit_hooks$set(chunk = function(x, options) {
  x <- def.chunk.hook(x, options)
  paste0("\n \\", "footnotesize","\n\n", x, "\n\n \\normalsize\n\n")
})
```

# 1 Hormigas

## 1.1 Individual characteristics

Es muy importante añadir las caracteristicas individuales de las
hormigas en la base de datos, porque eso hace parte de los filtros para
las exportaciones de los datos (alados se excluyen) Esas están en la
variable occurrence_remarks que contiene esas categorias:

``` sql
SELECT occurrence_remarks, count(*)
FROM raw_dwc.hormigas_registros
GROUP BY occurrence_remarks;
```

<div class="knitsql-table">

| occurrence_remarks | count |
|:-------------------|------:|
| Alado hembra       |    78 |
| Reina              |     3 |
| Obreras            |  9119 |
| Obreras y Huevos   |     8 |
| 4 huevos           |     1 |
| Alado Hembra       |     4 |
| Alado macho        |    31 |
| Obreras y Cocón    |     1 |

8 records

</div>

**Anotar: eso complica mucho el tratamiento de este campo, una categoria
como Obreras y huevos impide totalmente la codificación clara de los
individuos: debería haber una fila para los adultos, y otra para los
huevos…**

Lo que voy a hacer es no considerar los huevos y cocones… y transformar
en 2 variables: caste y sexo

``` sql
INSERT INTO main.def_var_ind_charac(var_ind_char, type_var, var_ind_char_spa)
VALUES
 ('Ant caste','categorial', 'Casta de hormiga'),
 ('Sex', 'categorial', 'Sexo')
RETURNING cd_var_ind_char,var_ind_char, type_var, var_ind_char_spa
;
```

``` sql
INSERT INTO main.def_ind_charac_categ(categ,cd_var_ind_char,categ_spa)
VALUES
('Worker',(SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Ant caste'),'Obrera'),
 ('Alate',(SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Ant caste'),'Alado'),
 ('Queen',(SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Ant caste'),'Reina'),
 ('Male',(SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Sex'),'Macho'),
 ('Female',(SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Sex'),'Hembra'),
 ('Sterile',(SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Sex'),'Estéril')
RETURNING cd_categ,categ,cd_var_ind_char,categ_spa
```

``` sql
INSERT INTO main.individual_characteristics AS ic (cd_reg,cd_categ,cd_var_ind_char)
WITH a AS(
SELECT  
 cd_reg,
  CASE
    WHEN occurrence_remarks ~ '[Rr]eina' THEN 'Queen'
    WHEN occurrence_remarks ~ '[Aa]lado' THEN 'Alate'
    WHEN occurrence_remarks ~ '[Oo]brera' THEN 'Worker'
  END caste
FROM raw_dwc.hormigas_registros
)
SELECT a.cd_reg, dc.cd_categ, dc.cd_var_ind_char
FROM a
JOIN main.def_ind_charac_categ dc ON caste=categ AND dc.cd_var_ind_char=(SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Ant caste')
RETURNING ic.cd_reg, ic.cd_categ, ic.cd_var_ind_char
```

``` sql
INSERT INTO main.individual_characteristics AS ic (cd_reg,cd_categ,cd_var_ind_char)
WITH a AS(
SELECT  
 cd_reg,
  CASE
    WHEN occurrence_remarks ~ '[Rr]eina' OR occurrence_remarks ~ '[Hh]embra' THEN 'Female'
    WHEN occurrence_remarks ~ '[Mmacho]' THEN 'Male'
    WHEN occurrence_remarks ~ '[Oo]brera' THEN 'Sterile'
  END sex
FROM raw_dwc.hormigas_registros
)
SELECT a.cd_reg, dc.cd_categ, dc.cd_var_ind_char
FROM a
JOIN main.def_ind_charac_categ dc ON sex=categ AND dc.cd_var_ind_char=(SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Sex')
RETURNING ic.cd_reg, ic.cd_categ, ic.cd_var_ind_char
```

**Pusé como nulo el sexo de los cocones y huevos, así como sus castas,
pero no sé si es la mejor opción**

# 2 Escarabajos

## 2.1 Individual characteristics

Es muy importante añadir las caracteristicas individuales de los
escarabajos en la base de datos, porque eso hace parte de los filtros
para las exportaciones de los datos (larvas/coprofagos) Esas están en la
variable life_stage que contiene esas categorias:

``` sql
SELECT life_stage, count(*)
FROM raw_dwc.escarabajos_registros
GROUP BY life_stage;
```

<div class="knitsql-table">

| life_stage | count |
|:-----------|------:|
| Larva      |    37 |
| Adulto     |  3871 |

2 records

</div>

``` sql
INSERT INTO main.def_var_ind_charac(var_ind_char, type_var, var_ind_char_spa)
VALUES
 ('Life stage','categorial', 'Estado de vida')
RETURNING cd_var_ind_char,var_ind_char, type_var, var_ind_char_spa
;
```

``` sql
INSERT INTO main.def_ind_charac_categ(categ,cd_var_ind_char,categ_spa)
VALUES
 ('Larva',(SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Life stage'),'Larva'),
 ('Adult',(SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Life stage'),'Adulto')
RETURNING cd_categ,categ,cd_var_ind_char,categ_spa
```

``` sql
INSERT INTO main.individual_characteristics AS ic (cd_reg,cd_categ,cd_var_ind_char)
WITH a AS(
SELECT  
 cd_reg,
  CASE
    WHEN life_stage ~ '[Ll]arva' THEN 'Larva'
    WHEN life_stage ~ '[Aa]dulto' THEN 'Adult'
  END lifestage
FROM raw_dwc.escarabajos_registros
)
SELECT a.cd_reg, dc.cd_categ, dc.cd_var_ind_char
FROM a
JOIN main.def_ind_charac_categ dc ON lifestage=categ AND dc.cd_var_ind_char=(SELECT cd_var_ind_char FROM main.def_var_ind_charac WHERE var_ind_char='Life stage')
RETURNING ic.cd_reg, ic.cd_categ, ic.cd_var_ind_char
```

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

| life_stage | subfamily     | protocol               | occurrences | total_abundance |
|:-----------|:--------------|:-----------------------|------------:|----------------:|
| Adult      | Scarabaeinae  | Human excrement trap   |        3867 |           25952 |
| Larva      | Orphinae      | Insect hand collection |           5 |               6 |
| Larva      | Rutelinae     | Insect hand collection |           2 |               3 |
| Adult      | Orphinae      | Insect hand collection |           2 |              17 |
| Adult      | Dynastinae    | Insect hand collection |           2 |               2 |
| Larva      | Dynastinae    | Insect hand collection |           3 |               9 |
| Larva      | Melolonthinae | Insect hand collection |          27 |              52 |

7 records

</div>

# 3 Hidrobiologicos

## 3.1 Cantidades que permiten pasar de la abundancia contada a las densidades

``` sql
SELECT hr.event_id,sample_size_value, he.sampling_effort, measurement_value__volumen_filtrado_,measurement_value__área_total_muestreada_por_estación_,measurement_value__área_total_raspada_por_muestra_, e.samp_effort_1, e.samp_effort_2
FROM raw_dwc.hidrobiologico_registros hr
LEFT JOIN raw_dwc.hidrobiologico_event he USING (event_id)
LEFT JOIN main.event e ON hr.cd_event=e.cd_event
ORDER BY he.sampling_protocol,event_id
```

<div class="knitsql-table">

| event_id        | sample_size_value | sampling_effort    | measurement_value\_*volumen_filtrado* | measurement_value\_*área_total_muestreada_por_estación* | measurement_value\_*área_total_raspada_por_muestra* | samp_effort_1 | samp_effort_2 |
|:----------------|:------------------|:-------------------|--------------------------------------:|--------------------------------------------------------:|----------------------------------------------------:|--------------:|--------------:|
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-A-Bajas | 18.0              | 9 replicas Botella |                                    18 |                                                      NA |                                                  NA |            18 |             9 |
| ANH10-F-A-Bajas | 18.0              | 9 replicas Botella |                                    18 |                                                      NA |                                                  NA |            18 |             9 |
| ANH10-F-A-Bajas | 18.0              | 9 replicas Botella |                                    18 |                                                      NA |                                                  NA |            18 |             9 |
| ANH10-F-A-Bajas | 18.0              | 9 replicas Botella |                                    18 |                                                      NA |                                                  NA |            18 |             9 |
| ANH10-F-A-Bajas | 18.0              | 9 replicas Botella |                                    18 |                                                      NA |                                                  NA |            18 |             9 |
| ANH10-F-A-Bajas | 18.0              | 9 replicas Botella |                                    18 |                                                      NA |                                                  NA |            18 |             9 |
| ANH10-F-A-Bajas | 18.0              | 9 replicas Botella |                                    18 |                                                      NA |                                                  NA |            18 |             9 |
| ANH10-F-A-Bajas | 18.0              | 9 replicas Botella |                                    18 |                                                      NA |                                                  NA |            18 |             9 |
| ANH10-F-A-Bajas | 18.0              | 9 replicas Botella |                                    18 |                                                      NA |                                                  NA |            18 |             9 |
| ANH10-F-A-Bajas | 18.0              | 9 replicas Botella |                                    18 |                                                      NA |                                                  NA |            18 |             9 |
| ANH10-F-A-Bajas | 18.0              | 9 replicas Botella |                                    18 |                                                      NA |                                                  NA |            18 |             9 |
| ANH10-F-A-Bajas | 18.0              | 9 replicas Botella |                                    18 |                                                      NA |                                                  NA |            18 |             9 |
| ANH10-F-A-Bajas | 18.0              | 9 replicas Botella |                                    18 |                                                      NA |                                                  NA |            18 |             9 |
| ANH10-F-A-Bajas | 18.0              | 9 replicas Botella |                                    18 |                                                      NA |                                                  NA |            18 |             9 |
| ANH10-F-A-Bajas | 18.0              | 9 replicas Botella |                                    18 |                                                      NA |                                                  NA |            18 |             9 |
| ANH10-F-A-Bajas | 18.0              | 9 replicas Botella |                                    18 |                                                      NA |                                                  NA |            18 |             9 |
| ANH10-F-A-Bajas | 18.0              | 9 replicas Botella |                                    18 |                                                      NA |                                                  NA |            18 |             9 |
| ANH10-F-A-Bajas | 18.0              | 9 replicas Botella |                                    18 |                                                      NA |                                                  NA |            18 |             9 |
| ANH10-F-A-Bajas | 18.0              | 9 replicas Botella |                                    18 |                                                      NA |                                                  NA |            18 |             9 |
| ANH10-F-A-Bajas | 18.0              | 9 replicas Botella |                                    18 |                                                      NA |                                                  NA |            18 |             9 |
| ANH10-F-A-Bajas | 18.0              | 9 replicas Botella |                                    18 |                                                      NA |                                                  NA |            18 |             9 |
| ANH10-F-A-Bajas | 18.0              | 9 replicas Botella |                                    18 |                                                      NA |                                                  NA |            18 |             9 |
| ANH10-F-B       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-B       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-B       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-B       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-B       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-B       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-B       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-B       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-B       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-B       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-B       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-B       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-B       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-B       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-B       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-B       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-B       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-B       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-B       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-B       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-B       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-B       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-B       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |
| ANH10-F-B       | 27.0              | 9 replicas Botella |                                    27 |                                                      NA |                                                  NA |            27 |             9 |

Displaying records 1 - 100

</div>

``` sql
SELECT qt_int/samp_effort_1, qt_double
FROM main.registros --USING (cd_reg)
LEFT JOIN main.event USING (cd_event)
LEFT JOIN main.gp_event USING (cd_gp_event)
WHERE cd_gp_biol='fipl'
```

<div class="knitsql-table">

|   ?column? |    qt_double |
|-----------:|-------------:|
|  2.5555556 | 9.584009e+03 |
|  0.0740741 | 2.222222e+00 |
|  0.0370370 | 1.111111e+00 |
|  0.4814815 | 1.805683e+03 |
|  1.5555556 | 4.666667e+01 |
|  0.0370370 | 1.111111e+00 |
|  0.2222222 | 6.666667e+00 |
|  0.1481481 | 4.444444e+00 |
|  0.0370370 | 1.388987e+02 |
|  0.0740741 | 2.222222e+00 |
|  0.0370370 | 1.111111e+00 |
|  0.2222222 | 8.333921e+02 |
|  0.0370370 | 1.111111e+00 |
|  0.0740741 | 2.222222e+00 |
|  0.0740741 | 2.222222e+00 |
|  0.2962963 | 1.111189e+03 |
|  0.0740741 | 2.777974e+02 |
|  0.0740741 | 2.777974e+02 |
|  0.0370370 | 2.083480e+02 |
|  0.0370370 | 2.083480e+02 |
|  0.0370370 | 2.083480e+02 |
|  0.0370370 | 1.111111e+00 |
|  0.0370370 | 1.111111e+00 |
|  0.0740741 | 2.222222e+00 |
| 19.7037037 | 5.911111e+02 |
|  0.0740741 | 4.166961e+02 |
|  0.0740741 | 4.166961e+02 |
|  0.1111111 | 2.105703e+02 |
|  0.0740741 | 4.166961e+02 |
|  0.2962963 | 1.666784e+03 |
| 12.0000000 | 6.750476e+04 |
|  0.0370370 | 1.111111e+00 |
|  0.0370370 | 1.111111e+00 |
|  0.0740741 | 2.222222e+00 |
|  0.0370370 | 1.666784e+02 |
|  0.0370370 | 1.111111e+00 |
|  0.0370370 | 1.111111e+00 |
|  0.0370370 | 1.111111e+00 |
| 21.5555556 | 9.700684e+04 |
|  0.0370370 | 1.111111e+00 |
|  0.0370370 | 1.111111e+00 |
|  0.2962963 | 7.777778e+00 |
|  1.7777778 | 4.666667e+01 |
| 21.8518519 | 5.736111e+02 |
|  0.0370370 | 9.722222e-01 |
|  0.1481481 | 3.888889e+00 |
|  2.1481481 | 1.626717e+03 |
|  0.0370370 | 2.804685e+01 |
|  0.0370370 | 2.804685e+01 |
|  0.3703704 | 2.804685e+02 |
|  0.0370370 | 9.722222e-01 |
|  0.0740741 | 5.609370e+01 |
|  0.0740741 | 5.609370e+01 |
|  0.0370370 | 9.722222e-01 |
|  0.1481481 | 2.962963e+00 |
|  9.1111111 | 1.708454e+04 |
|  0.3703704 | 7.407407e+00 |
|  0.0370370 | 7.407407e-01 |
|  3.0740741 | 7.300926e+01 |
|  0.0370370 | 8.796296e-01 |
|  0.0740741 | 1.851852e+00 |
|  0.0370370 | 9.259259e-01 |
|  0.0370370 | 9.876543e-01 |
|  0.4444444 | 1.333333e+01 |
|  1.6296296 | 4.888889e+01 |
|  0.0740741 | 1.157489e+02 |
|  1.1851852 | 1.851982e+03 |
|  0.0370370 | 1.234568e+00 |
|  0.2962963 | 4.629956e+02 |
|  0.0370370 | 5.787445e+01 |
|  0.0370370 | 1.234568e+00 |
|  1.3333333 | 5.417049e+03 |
|  0.3703704 | 8.024691e+00 |
|  0.0740741 | 2.098765e+00 |
|  0.0370370 | 1.049383e+00 |
|  0.0370370 | 1.049383e+00 |
|  0.1851852 | 5.246914e+00 |
| 20.0740741 | 5.687654e+02 |
|  0.5555556 | 1.574074e+01 |
|  0.0740741 | 2.098765e+00 |
|  0.0370370 | 1.049383e+00 |
|  0.2222222 | 6.296296e+00 |
|  0.0370370 | 1.049383e+00 |
|  0.2222222 | 6.296296e+00 |
|  1.1851852 | 3.160494e+01 |
| 10.1851852 | 2.716049e+02 |
|  0.5925926 | 1.580247e+01 |
| 12.5925926 | 3.358025e+02 |
|  3.4814815 | 9.283951e+01 |
|  0.2962963 | 7.901235e+00 |
|  1.8518519 | 4.938272e+01 |
|  0.8148148 | 2.172840e+01 |
|  0.0740741 | 1.975309e+00 |
|  0.5925926 | 1.975309e+01 |
|  0.0370370 | 1.234568e+00 |
|  0.2962963 | 9.876543e+00 |
|  0.0740741 | 2.469136e+00 |
|  0.5185185 | 1.728395e+01 |
|  0.1481481 | 4.938272e+00 |
|  0.3703704 | 9.876543e+00 |

Displaying records 1 - 100

</div>

``` sql
SELECT event_id,protocol_spa,qt_int/samp_effort_1, qt_double
FROM main.registros --USING (cd_reg)
LEFT JOIN main.event USING (cd_event)
LEFT JOIN main.gp_event USING (cd_gp_event)
LEFT JOIN main.def_protocol USING (cd_protocol)
WHERE cd_gp_biol='minv'
```

<div class="knitsql-table">

| event_id          | protocol_spa                        |   ?column? |  qt_double |
|:------------------|:------------------------------------|-----------:|-----------:|
| ANH297-MI-B-Bajas | Kick                                |  0.3333333 |  0.3333333 |
| ANH297-MI-B-Bajas | Kick                                |  0.3333333 |  0.3333333 |
| ANH297-MI-B-Bajas | Kick                                |  2.0000000 |  2.0000000 |
| ANH11-MI-B        | Red tipo D asociados con macrofitas |  4.4444444 |  4.4444444 |
| ANH34-MI-A        | Red tipo D asociados con macrofitas |  2.2222222 |  2.2222222 |
| ANH300-MI-A-Bajas | Red tipo D asociados con macrofitas | 51.1111111 | 51.1111111 |
| ANH299-MI-A       | Draga + Red tipo D                  | 14.5454545 | 14.5454545 |
| ANH299-MI-A       | Draga + Red tipo D                  |  6.6666667 |  6.6666667 |
| ANH299-MI-A       | Draga + Red tipo D                  |  0.6060606 |  0.6060606 |
| ANH299-MI-A       | Draga + Red tipo D                  |  7.8787879 |  7.8787879 |
| ANH299-MI-A       | Draga + Red tipo D                  |  1.8181818 |  1.8181818 |
| ANH299-MI-A       | Draga + Red tipo D                  |  1.8181818 |  1.8181818 |
| ANH299-MI-A       | Draga + Red tipo D                  |  3.0303030 |  3.0303030 |
| ANH299-MI-A       | Draga + Red tipo D                  |  4.8484848 |  4.8484848 |
| ANH299-MI-A       | Draga + Red tipo D                  |  2.4242424 |  2.4242424 |
| ANH299-MI-A       | Draga + Red tipo D                  |  0.6060606 |  0.6060606 |
| ANH299-MI-A       | Draga + Red tipo D                  |  1.8181818 |  1.8181818 |
| ANH299-MI-A       | Draga + Red tipo D                  |  0.6060606 |  0.6060606 |
| ANH299-MI-A       | Draga + Red tipo D                  |  0.6060606 |  0.6060606 |
| ANH299-MI-A       | Draga + Red tipo D                  |  7.2727273 |  7.2727273 |
| ANH299-MI-A       | Draga + Red tipo D                  |  1.2121212 |  1.2121212 |
| ANH299-MI-A       | Draga + Red tipo D                  |  0.6060606 |  0.6060606 |
| ANH299-MI-A       | Draga + Red tipo D                  |  0.6060606 |  0.6060606 |
| ANH299-MI-A       | Draga + Red tipo D                  |  5.4545455 |  5.4545455 |
| ANH299-MI-A       | Draga + Red tipo D                  |  6.0606061 |  6.0606061 |
| ANH299-MI-A       | Draga + Red tipo D                  |  4.2424242 |  4.2424242 |
| ANH299-MI-B       | Draga + Red tipo D                  |  0.6060606 |  0.6060606 |
| ANH299-MI-C       | Draga + Red tipo D                  | 10.9090909 | 10.9090909 |
| ANH299-MI-C       | Draga + Red tipo D                  |  5.4545455 |  5.4545455 |
| ANH299-MI-C       | Draga + Red tipo D                  |  0.6060606 |  0.6060606 |
| ANH299-MI-C       | Draga + Red tipo D                  |  3.6363636 |  3.6363636 |
| ANH299-MI-C       | Draga + Red tipo D                  |  0.6060606 |  0.6060606 |
| ANH299-MI-C       | Draga + Red tipo D                  | 13.9393939 | 13.9393939 |
| ANH299-MI-C       | Draga + Red tipo D                  |  0.6060606 |  0.6060606 |
| ANH299-MI-C       | Draga + Red tipo D                  |  0.6060606 |  0.6060606 |
| ANH299-MI-C       | Draga + Red tipo D                  |  1.8181818 |  1.8181818 |
| ANH299-MI-C       | Draga + Red tipo D                  |  1.2121212 |  1.2121212 |
| ANH299-MI-C       | Draga + Red tipo D                  |  8.4848485 |  8.4848485 |
| ANH299-MI-C       | Draga + Red tipo D                  |  0.6060606 |  0.6060606 |
| ANH299-MI-C       | Draga + Red tipo D                  |  1.8181818 |  1.8181818 |
| ANH299-MI-C       | Draga + Red tipo D                  |  6.6666667 |  6.6666667 |
| ANH299-MI-C       | Draga + Red tipo D                  |  2.4242424 |  2.4242424 |
| ANH299-MI-C       | Draga + Red tipo D                  |  1.8181818 |  1.8181818 |
| ANH7-MI-A         | Kick                                |  0.3333333 |  0.3333333 |
| ANH7-MI-A         | Kick                                |  5.3333333 |  5.3333333 |
| ANH7-MI-A         | Kick                                |  0.6666667 |  0.6666667 |
| ANH7-MI-A         | Kick                                |  0.3333333 |  0.3333333 |
| ANH7-MI-A         | Kick                                |  0.6666667 |  0.6666667 |
| ANH7-MI-A         | Kick                                |  0.3333333 |  0.3333333 |
| ANH7-MI-A         | Kick                                |  0.3333333 |  0.3333333 |
| ANH7-MI-A         | Kick                                |  2.6666667 |  2.6666667 |
| ANH7-MI-A         | Kick                                |  1.0000000 |  1.0000000 |
| ANH7-MI-A         | Kick                                |  2.6666667 |  2.6666667 |
| ANH7-MI-A         | Kick                                |  1.0000000 |  1.0000000 |
| ANH7-MI-A         | Kick                                |  0.6666667 |  0.6666667 |
| ANH7-MI-A         | Kick                                |  2.0000000 |  2.0000000 |
| ANH7-MI-A         | Kick                                |  7.0000000 |  7.0000000 |
| ANH7-MI-A         | Kick                                |  0.3333333 |  0.3333333 |
| ANH7-MI-A         | Kick                                |  1.0000000 |  1.0000000 |
| ANH7-MI-A         | Kick                                |  0.3333333 |  0.3333333 |
| ANH7-MI-A         | Kick                                |  1.0000000 |  1.0000000 |
| ANH7-MI-B         | Kick                                |  2.3333333 |  2.3333333 |
| ANH7-MI-B         | Kick                                |  2.3333333 |  2.3333333 |
| ANH7-MI-B         | Kick                                |  2.0000000 |  2.0000000 |
| ANH7-MI-B         | Kick                                |  0.3333333 |  0.3333333 |
| ANH7-MI-B         | Kick                                | 32.0000000 | 32.0000000 |
| ANH7-MI-B         | Kick                                | 28.0000000 | 28.0000000 |
| ANH7-MI-B         | Kick                                |  0.3333333 |  0.3333333 |
| ANH7-MI-B         | Kick                                |  2.3333333 |  2.3333333 |
| ANH7-MI-B         | Kick                                |  0.3333333 |  0.3333333 |
| ANH7-MI-B         | Kick                                |  5.3333333 |  5.3333333 |
| ANH7-MI-B         | Kick                                |  1.0000000 |  1.0000000 |
| ANH7-MI-B         | Kick                                |  5.3333333 |  5.3333333 |
| ANH7-MI-B         | Kick                                |  1.0000000 |  1.0000000 |
| ANH7-MI-B         | Kick                                |  3.3333333 |  3.3333333 |
| ANH7-MI-B         | Kick                                |  2.0000000 |  2.0000000 |
| ANH7-MI-B         | Kick                                |  0.3333333 |  0.3333333 |
| ANH7-MI-B         | Kick                                |  1.0000000 |  1.0000000 |
| ANH7-MI-C         | Kick                                |  0.3333333 |  0.3333333 |
| ANH7-MI-C         | Kick                                |  0.3333333 |  0.3333333 |
| ANH7-MI-C         | Kick                                |  0.6666667 |  0.6666667 |
| ANH7-MI-C         | Kick                                |  0.3333333 |  0.3333333 |
| ANH7-MI-C         | Kick                                |  0.6666667 |  0.6666667 |
| ANH7-MI-C         | Kick                                |  0.3333333 |  0.3333333 |
| ANH7-MI-C         | Kick                                |  1.3333333 |  1.3333333 |
| ANH7-MI-C         | Kick                                |  1.3333333 |  1.3333333 |
| ANH7-MI-C         | Kick                                |  6.0000000 |  6.0000000 |
| ANH7-MI-C         | Kick                                |  3.3333333 |  3.3333333 |
| ANH7-MI-C         | Kick                                |  2.0000000 |  2.0000000 |
| ANH7-MI-C         | Kick                                |  0.6666667 |  0.6666667 |
| ANH7-MI-C         | Kick                                |  0.3333333 |  0.3333333 |
| ANH7-MI-C         | Kick                                |  0.3333333 |  0.3333333 |
| ANH7-MI-C         | Kick                                |  0.6666667 |  0.6666667 |
| ANH8-MI-A         | Kick                                |  0.3333333 |  0.3333333 |
| ANH8-MI-A         | Kick                                |  0.6666667 |  0.6666667 |
| ANH8-MI-A         | Kick                                |  1.3333333 |  1.3333333 |
| ANH8-MI-A         | Kick                                |  2.6666667 |  2.6666667 |
| ANH8-MI-A         | Kick                                |  6.3333333 |  6.3333333 |
| ANH8-MI-A         | Kick                                |  0.6666667 |  0.6666667 |
| ANH8-MI-A         | Kick                                |  0.3333333 |  0.3333333 |

Displaying records 1 - 100

</div>

``` sql
SELECT qt_int/samp_effort_1, qt_double
FROM main.registros --USING (cd_reg)
LEFT JOIN main.event USING (cd_event)
LEFT JOIN main.gp_event USING (cd_gp_event)
WHERE cd_gp_biol='zopl'
```

<div class="knitsql-table">

|  ?column? |   qt_double |
|----------:|------------:|
| 0.1111111 |   1.0000000 |
| 0.0555556 |   0.7222222 |
| 0.1666667 |   2.6666667 |
| 0.0555556 |   0.6666667 |
| 0.0555556 |   0.8888889 |
| 0.0555556 |   0.4444444 |
| 0.0555556 |   0.5000000 |
| 0.4074074 |   4.4810000 |
| 1.7407407 |  24.3700000 |
| 2.4074074 |  32.5000000 |
| 2.5555556 |  46.0000000 |
| 0.1851852 |   3.8888889 |
| 0.0370370 |   0.5930000 |
| 0.0370370 |   0.7037037 |
| 0.0370370 |   0.4070000 |
| 0.0370370 |   0.7777778 |
| 0.5185185 |  10.8888889 |
| 1.5000000 |  21.7500000 |
| 0.0555556 |   0.7777778 |
| 0.1666667 |   2.3333333 |
| 0.2777778 |   3.8888889 |
| 0.0555556 |   0.7777778 |
| 0.0370370 |   0.8888889 |
| 0.7777778 |  10.8888889 |
| 0.3888889 |   5.4444444 |
| 0.0370370 |   0.5185185 |
| 0.0555556 |   0.8888889 |
| 0.0370370 |   0.6111111 |
| 1.8888889 |  24.5555556 |
| 0.0555556 |   0.7777778 |
| 0.0555556 |   0.8888889 |
| 0.2962963 |   4.8888889 |
| 0.0555556 |   0.6666667 |
| 0.0370370 |   0.5925926 |
| 0.0555556 |   0.6666667 |
| 0.1666667 |   2.0000000 |
| 0.0370370 |   0.5481481 |
| 0.1111111 |   1.4444444 |
| 1.0740741 |  17.7222222 |
| 1.9629630 |  25.5185185 |
| 0.1111111 |   1.4444444 |
| 0.0555556 |   0.7222222 |
| 0.2962963 |   3.8518519 |
| 5.2962963 |  68.8518518 |
| 0.1111111 |   1.5555556 |
| 0.0555556 |   0.7777778 |
| 1.0555556 |   7.9166667 |
| 0.0555556 |   0.7222222 |
| 0.0370370 |   0.4259259 |
| 0.0370370 |   0.4444444 |
| 1.5000000 |  13.9500000 |
| 0.1111111 |   1.1111111 |
| 0.0555556 |   0.6666667 |
| 3.7222222 |  44.6666667 |
| 5.6666667 | 107.6666667 |
| 1.2777778 |  15.3333333 |
| 0.1111111 |   1.1111111 |
| 0.1111111 |   2.1111111 |
| 0.0370370 |   0.4070000 |
| 0.0555556 |   0.5166667 |
| 0.0555556 |   0.5166667 |
| 1.5555556 |  17.1111111 |
| 0.0555556 |   1.0000000 |
| 0.0555556 |   0.9444444 |
| 0.0370370 |   0.5930000 |
| 0.0370370 |   0.7777778 |
| 0.0370370 |   0.7777778 |
| 0.0370370 |   0.5185185 |
| 0.0370370 |   0.3700000 |
| 0.1111111 |   1.5555556 |
| 0.0370370 |   0.6110000 |
| 0.0370370 |   0.5930000 |
| 0.0370370 |   0.5930000 |
| 0.0370370 |   0.7037037 |
| 0.0370370 |   0.5560000 |
| 0.0370370 |   0.5930000 |
| 0.0370370 |   0.7037037 |
| 0.0370370 |   0.4810000 |
| 0.0370370 |   0.6851852 |
| 0.0370370 |   0.4440000 |
| 0.0370370 |   0.4260000 |
| 0.1481481 |   2.8150000 |
| 0.0740741 |   1.0000000 |
| 0.5185185 |  10.6300000 |
| 0.1851852 |   3.7960000 |
| 0.1111111 |   2.3330000 |
| 0.1481481 |   2.9630000 |
| 0.0370370 |   0.5925926 |
| 1.9259259 |  25.0370000 |
| 0.3333333 |   4.3330000 |
| 0.8888889 |  12.4440000 |
| 0.4814815 |   6.7410000 |
| 0.0370370 |   0.5190000 |
| 0.0370370 |   0.6111111 |
| 0.0740741 |   1.0000000 |
| 0.0740741 |   1.2222222 |
| 0.4814815 |   6.5000000 |
| 3.0370370 |  51.6300000 |
| 0.9629630 |  16.3700000 |
| 0.0370370 |   0.6670000 |

Displaying records 1 - 100

</div>

``` sql
SELECT qt_int/samp_effort_1, qt_double
FROM main.registros --USING (cd_reg)
LEFT JOIN main.event USING (cd_event)
LEFT JOIN main.gp_event USING (cd_gp_event)
WHERE cd_gp_biol='peri'
```

<div class="knitsql-table">

|   ?column? |    qt_double |
|-----------:|-------------:|
| 12.9629630 | 1.143118e+06 |
|  0.3137362 | 1.897120e+03 |
|  0.0069171 | 8.299903e-01 |
|  0.1521754 | 1.725226e+03 |
|  0.0154154 | 1.233236e+00 |
|  0.1541545 | 1.233236e+01 |
|  0.2183088 | 1.855625e+01 |
|  0.0069171 | 7.841934e+01 |
|  0.0132626 | 5.262587e+02 |
|  0.0415024 | 4.979942e+00 |
|  0.0068204 | 5.456282e-01 |
|  0.1037560 | 1.244985e+01 |
|  0.0068204 | 5.456282e-01 |
|  0.0138341 | 1.659981e+00 |
|  0.0068204 | 5.456282e-01 |
|  0.0224291 | 3.435251e+02 |
|  0.0291078 | 2.474167e+00 |
|  0.0066313 | 7.957032e-01 |
|  0.0132626 | 5.262587e+02 |
|  0.0066313 | 7.957032e-01 |
|  0.0132626 | 5.262587e+02 |
|  0.0056073 | 8.588128e+01 |
|  0.0276683 | 3.136774e+02 |
|  0.1106730 | 1.327985e+01 |
|  0.0276683 | 1.584987e+02 |
|  0.0176087 | 1.672830e+00 |
|  0.0704349 | 6.691319e+00 |
|  0.0899218 | 1.019451e+03 |
|  0.0069171 | 8.299903e-01 |
|  0.0691706 | 7.841934e+02 |
|  0.0138341 | 1.568387e+02 |
|  0.3666044 | 4.156225e+03 |
|  0.0138341 | 1.568387e+02 |
|  0.0138341 | 1.659981e+00 |
|  0.0066313 | 2.631294e+02 |
|  0.0066313 | 2.631294e+02 |
|  0.0464191 | 1.841906e+03 |
|  0.1061008 | 4.210070e+03 |
|  0.0066313 | 7.957032e-01 |
|  0.0132626 | 5.262587e+02 |
|  0.0136407 | 8.248347e+01 |
|  0.0136407 | 8.248347e+01 |
|  0.0136407 | 8.248347e+01 |
|  0.0370370 | 2.592593e+00 |
|  0.0648148 | 4.537037e+00 |
|  0.2592593 | 1.814815e+01 |
|  0.2314815 | 1.620370e+01 |
|  0.0092593 | 6.481481e-01 |
|  0.3148148 | 6.246326e+03 |
|  0.0092593 | 6.944444e-01 |
|  0.2407407 | 4.776602e+03 |
|  0.0092593 | 1.837155e+02 |
|  0.4444444 | 3.333333e+01 |
|  0.0185185 | 1.388889e+00 |
|  0.0092593 | 6.944444e-01 |
|  0.0092593 | 6.944444e-01 |
|  0.0092593 | 6.944444e-01 |
|  0.1481481 | 6.222222e+00 |
|  0.0092593 | 6.759259e-01 |
|  0.0462963 | 3.240741e+00 |
|  0.0740741 | 5.333333e+00 |
|  0.0092593 | 8.518519e-01 |
|  0.0092593 | 8.518519e-01 |
|  0.0092593 | 1.759259e+00 |
|  0.0185185 | 1.759259e+00 |
|  0.0925926 | 8.796296e+00 |
|  0.0925926 | 8.796296e+00 |
|  0.3703704 | 3.518519e+01 |
|  0.0092593 | 8.796296e-01 |
|  0.0092593 | 8.796296e-01 |
|  0.0092593 | 8.796296e-01 |
|  0.0370370 | 3.111111e+00 |
|  0.0092593 | 7.407407e-01 |
|  0.0092593 | 7.407407e-01 |
|  0.0092593 | 3.472222e+00 |
|  0.0092593 | 3.472222e+00 |
|  0.0092593 | 4.592887e+03 |
|  0.0092593 | 3.472222e+00 |
|  0.1111111 | 4.166667e+01 |
|  0.2962963 | 4.444444e+01 |
|  1.2222222 | 1.833333e+02 |
|  0.0092593 | 1.388889e+00 |
|  0.0092593 | 1.388889e+00 |
|  0.0185185 | 2.777778e+00 |
|  0.0740741 | 7.348618e+03 |
|  0.0370370 | 5.555556e+00 |
|  0.0092593 | 3.472222e+00 |
|  0.0092593 | 1.530962e+03 |
|  0.0092593 | 1.530962e+03 |
|  0.0092593 | 1.530962e+03 |
|  0.0092593 | 1.530962e+03 |
|  0.0092593 | 3.472222e+00 |
|  3.8611111 | 6.384112e+05 |
|  0.0092593 | 1.530962e+03 |
|  0.0092593 | 1.530962e+03 |
|  0.0092593 | 3.472222e+00 |
|  4.7222222 | 1.770833e+03 |
|  0.0056073 | 8.588128e+01 |
|  0.0056073 | 8.588128e+01 |
|  0.0056073 | 8.588128e+01 |

Displaying records 1 - 100

</div>

# 4 Filtro de 30 minutos para considerar registros como independientes en cameras trampas

``` sql
INSERT INTO main.def_var_registros_extra(var_registros_extra,type_var,var_registros_extra_spa,var_registros_extra_comment)
VALUES('30 minutes period','reference','periodo de 30 minutos','los grupos están definidos sobre un periodo de 30 minutos desde la primera fotografía y contienen todos los registros que tienen la misma especie en este periodo, dentro de un mismo evento'
);
BEGIN TRANSACTION;
CREATE TEMPORARY TABLE period_30min
(
  id serial PRIMARY KEY,
  cd_event int NOT NULL,
  cd_tax int NOT NULL,
  date_time_range tsrange NOT NULL
)
ON COMMIT DROP;
DO 
$$
DECLARE r record;
        curid int;
BEGIN
  FOR r IN SELECT cd_reg,cd_tax,cd_event,date_time FROM main.registros LEFT JOIN main.event USING (cd_event) LEFT JOIN main.gp_event USING (cd_gp_event) WHERE cd_gp_biol='catr' ORDER BY cd_event,date_time
  LOOP
   SELECT id INTO curid FROM period_30min p WHERE r.cd_tax=p.cd_tax AND r.cd_event=p.cd_event AND r.date_time <@ p.date_time_range;
   IF curid IS NULL AND r.date_time IS NOT NULL THEN
    INSERT INTO period_30min(cd_event,cd_tax,date_time_range)
      VALUES(
        r.cd_event,r.cd_tax,(SELECT tsrange(r.date_time,r.date_time + '30 min','[]'))
      );
   END IF;
  END LOOP;
END$$; 
INSERT INTO main.registros_extra(cd_reg,cd_var_registros_extra,value_int)
SELECT cd_reg,(SELECT cd_var_registros_extra FROM main.def_var_registros_extra WHERE var_registros_extra='30 minutes period'),id
FROM main.registros reg
LEFT JOIN main.event USING (cd_event)
LEFT JOIN main.gp_event USING (cd_gp_event)
LEFT JOIN period_30min p ON p.cd_event=reg.cd_event AND p.cd_tax=reg.cd_tax AND reg.date_time <@ p.date_time_range
WHERE cd_gp_biol='catr' AND id IS NOT NULL;
COMMIT;
SELECT value_int,COUNT(DISTINCT cd_reg)
FROM main.registros_extra
WHERE cd_var_registros_extra=(SELECT cd_var_registros_extra FROM main.def_var_registros_extra WHERE var_registros_extra='30 minutes period')
GROUP BY value_int;
```

# 5 Mamiferos

## 5.1 Individual characteristics

Tenemos un problema, si damos una caracteristica individual en una fila
del DwC de registros, la fila debería debería contener un solo
individuos… Con el ejemplo de los sexos, condición reproductiva y etapa
de vida:

``` sql
SELECT cd_reg,table_orig,"row.names",organism_quantity, sex, life_stage, reproductive_condition 
FROM raw_dwc.mamiferos_tot_registros 
WHERE (sex IS NOT NULL OR life_stage IS NOT NULL OR reproductive_condition IS NOT NULL) AND organism_quantity::int>1
```

<div class="knitsql-table">

| cd_reg | table_orig          | row.names | organism_quantity | sex    | life_stage | reproductive_condition |
|-------:|:--------------------|:----------|:------------------|:-------|:-----------|:-----------------------|
|  36395 | mamiferos_registros | 31        | 2                 | Hembra | Adulto     | Lactante               |
|  36367 | mamiferos_registros | 12        | 2                 | Hembra | Adulto     | Gestante               |
|  36397 | mamiferos_registros | 25        | 2                 | Hembra | Adulto     | Gestante               |
|  36526 | mamiferos_registros | 105       | 2                 | Hembra | Adulto     | Gestante               |
|  36573 | mamiferos_registros | 108       | 2                 | Hembra | Adulto     | Gestante               |
|  36485 | mamiferos_registros | 208       | 3                 | Hembra | Adulto     | Gestante               |
|  37046 | mamiferos_registros | 498       | 2                 | Hembra | Adulto     | Gestante               |
|  37067 | mamiferos_registros | 499       | 2                 | Hembra | Adulto     | Gestante               |
|  37411 | mamiferos_registros | 823       | 2                 | Hembra | Adulto     | Gestante               |
|  37603 | mamiferos_registros | 973       | 2                 | Hembra | Adulto     | Lactante               |
|  37669 | mamiferos_registros | 977       | 2                 | Hembra | Adulto     | Gestante               |
|  37659 | mamiferos_registros | 979       | 2                 | Hembra | Adulto     | Gestante               |
|  37590 | mamiferos_registros | 980       | 2                 | Hembra | Adulto     | Gestante               |
|  37752 | mamiferos_registros | 1103      | 2                 | Hembra | Adulto     | Lactante               |
|  37954 | mamiferos_registros | 1107      | 2                 | Hembra | Adulto     | Gestante               |
|  37873 | mamiferos_registros | 1241      | 2                 | Hembra | Adulto     | Lactante               |
|  37743 | mamiferos_registros | 1392      | 2                 | Hembra | Adulto     | Gestante               |
|  38092 | mamiferos_registros | 1482      | 2                 | Hembra | Adulto     | Lactante               |
|  38032 | mamiferos_registros | 1483      | 2                 | Hembra | Adulto     | Lactante               |
|  38040 | mamiferos_registros | 1485      | 2                 | Hembra | Adulto     | Lactante               |
|  38063 | mamiferos_registros | 1486      | 2                 | Hembra | Adulto     | Lactante               |
|  38235 | mamiferos_registros | 1581      | 2                 | Hembra | Adulto     | Lactante               |
|  38203 | mamiferos_registros | 1582      | 2                 | Hembra | Adulto     | Lactante               |
|  38374 | mamiferos_registros | 1586      | 2                 | Hembra | Adulto     | Gestante               |
|  38301 | mamiferos_registros | 1591      | 2                 | Hembra | Adulto     | Gestante               |
|  38385 | mamiferos_registros | 1593      | 2                 | Hembra | Adulto     | Gestante               |
|  38475 | mamiferos_registros | 1671      | 2                 | Hembra | Adulto     | Gestante               |
|  38434 | mamiferos_registros | 1673      | 2                 | Hembra | Adulto     | Gestante               |
|  38544 | mamiferos_registros | 1768      | 2                 | Hembra | Adulto     | Gestante               |
|  38571 | mamiferos_registros | 1793      | 5                 | Hembra | Adulto     | Gestante               |
|  38569 | mamiferos_registros | 1796      | 4                 | Hembra | Adulto     | Gestante               |
|  38728 | mamiferos_registros | 1900      | 2                 | Hembra | Adulto     | Lactando               |
|  38749 | mamiferos_registros | 1911      | 2                 | Hembra | Adulto     | Lactando               |
|  38769 | mamiferos_registros | 1930      | 2                 | Hembra | Adulto     | Lactando               |
|  38780 | mamiferos_registros | 1940      | 2                 | Hembra | Adulto     | Lactando               |
|  38885 | mamiferos_registros | 2070      | 2                 | Hembra | Adulto     | Lactando               |
|  40944 | mamiferos_registros | 2210      | 2                 | Hembra | Juvenil    | Gestante               |
|  39403 | mamiferos_registros | 2500      | 2                 | Hembra | Adulto     | Lactando               |
|  39143 | mamiferos_registros | 2626      | 2                 | Hembra | Adulto     | Gestante               |
|  39686 | mamiferos_registros | 2795      | 2                 | Hembra | Adulto     | Lactando               |
|  39511 | mamiferos_registros | 2791      | 3                 | Hembra | Adulto     | Gestante               |
|  39930 | mamiferos_registros | 2847      | 2                 | Hembra | Adulto     | Lactando               |
|  39902 | mamiferos_registros | 2853      | 2                 | Hembra | Adulto     | Lactando               |
|  40010 | mamiferos_registros | 2954      | 2                 | Hembra | Adulto     | Lactando               |
|  39707 | mamiferos_registros | 2963      | 2                 | Hembra | Adulto     | Gestante               |
|  40028 | mamiferos_registros | 3032      | 2                 | Hembra | Adulto     | Lactando               |
|  40240 | mamiferos_registros | 3139      | 2                 | Hembra | Adulto     | Lactando               |
|  40601 | mamiferos_registros | 3386      | 2                 | Hembra | Adulto     | Lactando               |
|  40633 | mamiferos_registros | 3391      | 2                 | Hembra | Adulto     | Lactando               |
|  39528 | mamiferos_registros | 3414      | 3                 | Hembra | Adulto     | Gestante               |
|  40642 | mamiferos_registros | 3416      | 2                 | Hembra | Adulto     | Lactando               |
|  40863 | mamiferos_registros | 3554      | 2                 | Hembra | Adulto     | Lactando               |
|  40927 | mamiferos_registros | 3592      | 2                 | Hembra | Adulto     | Lactando               |
|  40914 | mamiferos_registros | 3613      | 2                 | Hembra | Adulto     | Lactando               |
|  38570 | mamiferos_registros | 1792      | 7                 | Hembra | Adulto     | Gestante               |
|  37271 | mamiferos_registros | 1         | 2                 | Hembra | Adulto     | Gestante               |
|  36521 | mamiferos_registros | 207       | 2                 | Hembra | Adulto     | Gestante               |
|  37077 | mamiferos_registros | 495       | 2                 | Hembra | Adulto     | Gestante               |
|  37272 | mamiferos_registros | 746       | 2                 | Hembra | Adulto     | Lactante               |
|  37255 | mamiferos_registros | 747       | 2                 | Hembra | Adulto     | Lactante               |
|  37243 | mamiferos_registros | 748       | 2                 | Hembra | Adulto     | Lactante               |
|  37425 | mamiferos_registros | 829       | 2                 | Hembra | Adulto     | Lactante               |
|  37614 | mamiferos_registros | 1035      | 2                 | Hembra | Adulto     | Lactante               |
|  37724 | mamiferos_registros | 1106      | 2                 | Hembra | Adulto     | Gestante               |
|  38013 | mamiferos_registros | 1108      | 2                 | Hembra | Adulto     | Gestante               |
|  37754 | mamiferos_registros | 1122      | 2                 | Hembra | Adulto     | Lactante               |
|  38070 | mamiferos_registros | 1484      | 2                 | Hembra | Adulto     | Lactante               |
|  38175 | mamiferos_registros | 1579      | 2                 | Hembra | Adulto     | Lactante               |
|  38140 | mamiferos_registros | 1580      | 2                 | Hembra | Adulto     | Lactante               |
|  38435 | mamiferos_registros | 1718      | 2                 | Hembra | Adulto     | Lactante               |
|  38488 | mamiferos_registros | 1726      | 2                 | Hembra | Adulto     | Gestante               |
|  38518 | mamiferos_registros | 1727      | 2                 | Hembra | Adulto     | Gestante               |
|  38529 | mamiferos_registros | 1740      | 2                 | Hembra | Adulto     | Lactante               |
|  38701 | mamiferos_registros | 1855      | 2                 | Hembra | Adulto     | Lactando               |
|  38720 | mamiferos_registros | 1875      | 2                 | Hembra | Adulto     | Lactando               |
|  38772 | mamiferos_registros | 1897      | 2                 | Hembra | Adulto     | Gestante               |
|  39180 | mamiferos_registros | 2343      | 2                 | Hembra | Adulto     | Lactando               |
|  39458 | mamiferos_registros | 2630      | 2                 | Hembra | Adulto     | Gestante               |
|  39886 | mamiferos_registros | 2846      | 2                 | Hembra | Adulto     | Lactando               |
|  39898 | mamiferos_registros | 2848      | 2                 | Hembra | Adulto     | Lactando               |
|  39900 | mamiferos_registros | 2849      | 2                 | Hembra | Adulto     | Lactando               |
|  39890 | mamiferos_registros | 2852      | 2                 | Hembra | Adulto     | Lactando               |
|  39901 | mamiferos_registros | 2854      | 2                 | Hembra | Adulto     | Lactando               |
|  39949 | mamiferos_registros | 2857      | 2                 | Hembra | Adulto     | Lactando               |
|  40030 | mamiferos_registros | 3105      | 2                 | Hembra | Adulto     | Lactando               |
|  40632 | mamiferos_registros | 3390      | 2                 | Hembra | Adulto     | Lactando               |
|  40705 | mamiferos_registros | 3450      | 2                 | Hembra | Adulto     | Lactando               |
|  40627 | mamiferos_registros | 3509      | 2                 | Hembra | Adulto     | Gestante               |
|  40912 | mamiferos_registros | 3615      | 2                 | Hembra | Adulto     | Lactando               |
|  40969 | mamiferos_registros | 3651      | 2                 | Hembra | Adulto     | Lactando               |
|  40968 | mamiferos_registros | 3656      | 2                 | Hembra | Adulto     | Lactando               |

91 records

</div>

``` r
dbDisconnect(fracking_db)
```

    ## [1] TRUE
