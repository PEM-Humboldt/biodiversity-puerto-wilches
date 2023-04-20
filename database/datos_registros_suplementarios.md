Integración de los datos suplementarios de los grupos
================
Marius Bottin
2023-04-19

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

<table>
<caption>

8 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

occurrence_remarks

</th>
<th style="text-align:right;">

count

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Alado hembra

</td>
<td style="text-align:right;">

78

</td>
</tr>
<tr>
<td style="text-align:left;">

Reina

</td>
<td style="text-align:right;">

3

</td>
</tr>
<tr>
<td style="text-align:left;">

Obreras

</td>
<td style="text-align:right;">

9119

</td>
</tr>
<tr>
<td style="text-align:left;">

Obreras y Huevos

</td>
<td style="text-align:right;">

8

</td>
</tr>
<tr>
<td style="text-align:left;">

4 huevos

</td>
<td style="text-align:right;">

1

</td>
</tr>
<tr>
<td style="text-align:left;">

Alado Hembra

</td>
<td style="text-align:right;">

4

</td>
</tr>
<tr>
<td style="text-align:left;">

Alado macho

</td>
<td style="text-align:right;">

31

</td>
</tr>
<tr>
<td style="text-align:left;">

Obreras y Cocón

</td>
<td style="text-align:right;">

1

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

2 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

life_stage

</th>
<th style="text-align:right;">

count

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Larva

</td>
<td style="text-align:right;">

37

</td>
</tr>
<tr>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:right;">

3871

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

7 records

</caption>
<thead>
<tr>
<th style="text-align:left;">

life_stage

</th>
<th style="text-align:left;">

subfamily

</th>
<th style="text-align:left;">

protocol

</th>
<th style="text-align:right;">

occurrences

</th>
<th style="text-align:right;">

total_abundance

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

Adult

</td>
<td style="text-align:left;">

Scarabaeinae

</td>
<td style="text-align:left;">

Human excrement trap

</td>
<td style="text-align:right;">

3867

</td>
<td style="text-align:right;">

25952

</td>
</tr>
<tr>
<td style="text-align:left;">

Larva

</td>
<td style="text-align:left;">

Orphinae

</td>
<td style="text-align:left;">

Insect hand collection

</td>
<td style="text-align:right;">

5

</td>
<td style="text-align:right;">

6

</td>
</tr>
<tr>
<td style="text-align:left;">

Larva

</td>
<td style="text-align:left;">

Rutelinae

</td>
<td style="text-align:left;">

Insect hand collection

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

Adult

</td>
<td style="text-align:left;">

Orphinae

</td>
<td style="text-align:left;">

Insect hand collection

</td>
<td style="text-align:right;">

2

</td>
<td style="text-align:right;">

17

</td>
</tr>
<tr>
<td style="text-align:left;">

Adult

</td>
<td style="text-align:left;">

Dynastinae

</td>
<td style="text-align:left;">

Insect hand collection

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

Larva

</td>
<td style="text-align:left;">

Dynastinae

</td>
<td style="text-align:left;">

Insect hand collection

</td>
<td style="text-align:right;">

3

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

Larva

</td>
<td style="text-align:left;">

Melolonthinae

</td>
<td style="text-align:left;">

Insect hand collection

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

52

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

Displaying records 1 - 100

</caption>
<thead>
<tr>
<th style="text-align:left;">

event_id

</th>
<th style="text-align:left;">

sample_size_value

</th>
<th style="text-align:left;">

sampling_effort

</th>
<th style="text-align:right;">

measurement_value\_*volumen_filtrado*

</th>
<th style="text-align:right;">

measurement_value\_*área_total_muestreada_por_estación*

</th>
<th style="text-align:right;">

measurement_value\_*área_total_raspada_por_muestra*

</th>
<th style="text-align:right;">

samp_effort_1

</th>
<th style="text-align:right;">

samp_effort_2

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A-Bajas

</td>
<td style="text-align:left;">

18.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A-Bajas

</td>
<td style="text-align:left;">

18.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A-Bajas

</td>
<td style="text-align:left;">

18.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A-Bajas

</td>
<td style="text-align:left;">

18.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A-Bajas

</td>
<td style="text-align:left;">

18.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A-Bajas

</td>
<td style="text-align:left;">

18.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A-Bajas

</td>
<td style="text-align:left;">

18.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A-Bajas

</td>
<td style="text-align:left;">

18.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A-Bajas

</td>
<td style="text-align:left;">

18.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A-Bajas

</td>
<td style="text-align:left;">

18.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A-Bajas

</td>
<td style="text-align:left;">

18.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A-Bajas

</td>
<td style="text-align:left;">

18.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A-Bajas

</td>
<td style="text-align:left;">

18.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A-Bajas

</td>
<td style="text-align:left;">

18.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A-Bajas

</td>
<td style="text-align:left;">

18.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A-Bajas

</td>
<td style="text-align:left;">

18.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A-Bajas

</td>
<td style="text-align:left;">

18.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A-Bajas

</td>
<td style="text-align:left;">

18.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A-Bajas

</td>
<td style="text-align:left;">

18.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A-Bajas

</td>
<td style="text-align:left;">

18.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A-Bajas

</td>
<td style="text-align:left;">

18.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-A-Bajas

</td>
<td style="text-align:left;">

18.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

18

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-B

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-B

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-B

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-B

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-B

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-B

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-B

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-B

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-B

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-B

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-B

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-B

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-B

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-B

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-B

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-B

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-B

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-B

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-B

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-B

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-B

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-B

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-B

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH10-F-B

</td>
<td style="text-align:left;">

27.0

</td>
<td style="text-align:left;">

9 replicas Botella

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

NA

</td>
<td style="text-align:right;">

27

</td>
<td style="text-align:right;">

9

</td>
</tr>
</tbody>
</table>

</div>

``` sql
SELECT qt_int/samp_effort_1, qt_double
FROM main.registros --USING (cd_reg)
LEFT JOIN main.event USING (cd_event)
LEFT JOIN main.gp_event USING (cd_gp_event)
WHERE cd_gp_biol='fipl'
```

<div class="knitsql-table">

<table>
<caption>

Displaying records 1 - 100

</caption>
<thead>
<tr>
<th style="text-align:right;">

?column?

</th>
<th style="text-align:right;">

qt_double

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">

2.5555556

</td>
<td style="text-align:right;">

9.584009e+03

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0740741

</td>
<td style="text-align:right;">

2.222222e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

1.111111e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.4814815

</td>
<td style="text-align:right;">

1.805683e+03

</td>
</tr>
<tr>
<td style="text-align:right;">

1.5555556

</td>
<td style="text-align:right;">

4.666667e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

1.111111e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.2222222

</td>
<td style="text-align:right;">

6.666667e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.1481481

</td>
<td style="text-align:right;">

4.444444e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

1.388987e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0740741

</td>
<td style="text-align:right;">

2.222222e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

1.111111e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.2222222

</td>
<td style="text-align:right;">

8.333921e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

1.111111e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0740741

</td>
<td style="text-align:right;">

2.222222e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0740741

</td>
<td style="text-align:right;">

2.222222e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.2962963

</td>
<td style="text-align:right;">

1.111189e+03

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0740741

</td>
<td style="text-align:right;">

2.777974e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0740741

</td>
<td style="text-align:right;">

2.777974e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

2.083480e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

2.083480e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

2.083480e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

1.111111e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

1.111111e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0740741

</td>
<td style="text-align:right;">

2.222222e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

19.7037037

</td>
<td style="text-align:right;">

5.911111e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0740741

</td>
<td style="text-align:right;">

4.166961e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0740741

</td>
<td style="text-align:right;">

4.166961e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.1111111

</td>
<td style="text-align:right;">

2.105703e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0740741

</td>
<td style="text-align:right;">

4.166961e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.2962963

</td>
<td style="text-align:right;">

1.666784e+03

</td>
</tr>
<tr>
<td style="text-align:right;">

12.0000000

</td>
<td style="text-align:right;">

6.750476e+04

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

1.111111e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

1.111111e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0740741

</td>
<td style="text-align:right;">

2.222222e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

1.666784e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

1.111111e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

1.111111e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

1.111111e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

21.5555556

</td>
<td style="text-align:right;">

9.700684e+04

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

1.111111e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

1.111111e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.2962963

</td>
<td style="text-align:right;">

7.777778e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

1.7777778

</td>
<td style="text-align:right;">

4.666667e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

21.8518519

</td>
<td style="text-align:right;">

5.736111e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

9.722222e-01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.1481481

</td>
<td style="text-align:right;">

3.888889e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

2.1481481

</td>
<td style="text-align:right;">

1.626717e+03

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

2.804685e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

2.804685e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.3703704

</td>
<td style="text-align:right;">

2.804685e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

9.722222e-01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0740741

</td>
<td style="text-align:right;">

5.609370e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0740741

</td>
<td style="text-align:right;">

5.609370e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

9.722222e-01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.1481481

</td>
<td style="text-align:right;">

2.962963e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

9.1111111

</td>
<td style="text-align:right;">

1.708454e+04

</td>
</tr>
<tr>
<td style="text-align:right;">

0.3703704

</td>
<td style="text-align:right;">

7.407407e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

7.407407e-01

</td>
</tr>
<tr>
<td style="text-align:right;">

3.0740741

</td>
<td style="text-align:right;">

7.300926e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

8.796296e-01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0740741

</td>
<td style="text-align:right;">

1.851852e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

9.259259e-01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.4444444

</td>
<td style="text-align:right;">

1.333333e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

1.6296296

</td>
<td style="text-align:right;">

4.888889e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0740741

</td>
<td style="text-align:right;">

1.157489e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

1.1851852

</td>
<td style="text-align:right;">

1.851982e+03

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

1.234568e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.2962963

</td>
<td style="text-align:right;">

4.629956e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

5.787445e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

1.234568e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

1.3333333

</td>
<td style="text-align:right;">

5.417049e+03

</td>
</tr>
<tr>
<td style="text-align:right;">

0.3703704

</td>
<td style="text-align:right;">

8.024691e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0740741

</td>
<td style="text-align:right;">

2.098765e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

1.049383e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

1.049383e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.1851852

</td>
<td style="text-align:right;">

5.246914e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

20.0740741

</td>
<td style="text-align:right;">

5.687654e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.5555556

</td>
<td style="text-align:right;">

1.574074e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0740741

</td>
<td style="text-align:right;">

2.098765e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

1.049383e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.2222222

</td>
<td style="text-align:right;">

6.296296e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

1.049383e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.2222222

</td>
<td style="text-align:right;">

6.296296e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

1.1851852

</td>
<td style="text-align:right;">

3.160494e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

9.876543e-01

</td>
</tr>
<tr>
<td style="text-align:right;">

10.1851852

</td>
<td style="text-align:right;">

2.716049e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.5925926

</td>
<td style="text-align:right;">

1.580247e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

12.5925926

</td>
<td style="text-align:right;">

3.358025e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

3.4814815

</td>
<td style="text-align:right;">

9.283951e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

1.8518519

</td>
<td style="text-align:right;">

4.938272e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.8148148

</td>
<td style="text-align:right;">

2.172840e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0740741

</td>
<td style="text-align:right;">

1.975309e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.5925926

</td>
<td style="text-align:right;">

1.975309e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

1.234568e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.2962963

</td>
<td style="text-align:right;">

9.876543e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0740741

</td>
<td style="text-align:right;">

2.469136e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.5185185

</td>
<td style="text-align:right;">

1.728395e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.1481481

</td>
<td style="text-align:right;">

4.938272e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.3703704

</td>
<td style="text-align:right;">

9.876543e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

9.876543e-01

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

Displaying records 1 - 100

</caption>
<thead>
<tr>
<th style="text-align:left;">

event_id

</th>
<th style="text-align:left;">

protocol_spa

</th>
<th style="text-align:right;">

?column?

</th>
<th style="text-align:right;">

qt_double

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">

ANH298-MI-B-Bajas

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

0.6666667

</td>
<td style="text-align:right;">

0.6666667

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH300-MI-B-Bajas

</td>
<td style="text-align:left;">

Red tipo D asociados con macrofitas

</td>
<td style="text-align:right;">

180.0000000

</td>
<td style="text-align:right;">

180.0000000

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH300-MI-B-Bajas

</td>
<td style="text-align:left;">

Red tipo D asociados con macrofitas

</td>
<td style="text-align:right;">

113.3333333

</td>
<td style="text-align:right;">

113.3333333

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH300-MI-B-Bajas

</td>
<td style="text-align:left;">

Red tipo D asociados con macrofitas

</td>
<td style="text-align:right;">

2.2222222

</td>
<td style="text-align:right;">

2.2222222

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH300-MI-B-Bajas

</td>
<td style="text-align:left;">

Red tipo D asociados con macrofitas

</td>
<td style="text-align:right;">

6.6666667

</td>
<td style="text-align:right;">

6.6666667

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH300-MI-B-Bajas

</td>
<td style="text-align:left;">

Red tipo D asociados con macrofitas

</td>
<td style="text-align:right;">

6.6666667

</td>
<td style="text-align:right;">

6.6666667

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH300-MI-B-Bajas

</td>
<td style="text-align:left;">

Red tipo D asociados con macrofitas

</td>
<td style="text-align:right;">

6.6666667

</td>
<td style="text-align:right;">

6.6666667

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH301-MI-B-Bajas

</td>
<td style="text-align:left;">

Red tipo D asociados con macrofitas

</td>
<td style="text-align:right;">

235.5555556

</td>
<td style="text-align:right;">

235.5555556

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH301-MI-B-Bajas

</td>
<td style="text-align:left;">

Red tipo D asociados con macrofitas

</td>
<td style="text-align:right;">

108.8888889

</td>
<td style="text-align:right;">

108.8888889

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH301-MI-B-Bajas

</td>
<td style="text-align:left;">

Red tipo D asociados con macrofitas

</td>
<td style="text-align:right;">

4.4444444

</td>
<td style="text-align:right;">

4.4444444

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH301-MI-B-Bajas

</td>
<td style="text-align:left;">

Red tipo D asociados con macrofitas

</td>
<td style="text-align:right;">

6.6666667

</td>
<td style="text-align:right;">

6.6666667

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH301-MI-B-Bajas

</td>
<td style="text-align:left;">

Red tipo D asociados con macrofitas

</td>
<td style="text-align:right;">

100.0000000

</td>
<td style="text-align:right;">

100.0000000

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH9-MI-B

</td>
<td style="text-align:left;">

Red tipo D asociados con macrofitas

</td>
<td style="text-align:right;">

6.6666667

</td>
<td style="text-align:right;">

6.6666667

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-A

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

14.5454545

</td>
<td style="text-align:right;">

14.5454545

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-A

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

6.6666667

</td>
<td style="text-align:right;">

6.6666667

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-A

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

0.6060606

</td>
<td style="text-align:right;">

0.6060606

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-A

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

7.8787879

</td>
<td style="text-align:right;">

7.8787879

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-A

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

1.8181818

</td>
<td style="text-align:right;">

1.8181818

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-A

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

1.8181818

</td>
<td style="text-align:right;">

1.8181818

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-A

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

3.0303030

</td>
<td style="text-align:right;">

3.0303030

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-A

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

4.8484848

</td>
<td style="text-align:right;">

4.8484848

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-A

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

2.4242424

</td>
<td style="text-align:right;">

2.4242424

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-A

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

0.6060606

</td>
<td style="text-align:right;">

0.6060606

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-A

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

1.8181818

</td>
<td style="text-align:right;">

1.8181818

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-A

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

0.6060606

</td>
<td style="text-align:right;">

0.6060606

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-A

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

0.6060606

</td>
<td style="text-align:right;">

0.6060606

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-A

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

7.2727273

</td>
<td style="text-align:right;">

7.2727273

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-A

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

1.2121212

</td>
<td style="text-align:right;">

1.2121212

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-A

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

0.6060606

</td>
<td style="text-align:right;">

0.6060606

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-A

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

0.6060606

</td>
<td style="text-align:right;">

0.6060606

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-A

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

5.4545455

</td>
<td style="text-align:right;">

5.4545455

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-A

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

6.0606061

</td>
<td style="text-align:right;">

6.0606061

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-A

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

4.2424242

</td>
<td style="text-align:right;">

4.2424242

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-B

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

0.6060606

</td>
<td style="text-align:right;">

0.6060606

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-C

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

10.9090909

</td>
<td style="text-align:right;">

10.9090909

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-C

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

5.4545455

</td>
<td style="text-align:right;">

5.4545455

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-C

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

0.6060606

</td>
<td style="text-align:right;">

0.6060606

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-C

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

3.6363636

</td>
<td style="text-align:right;">

3.6363636

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-C

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

0.6060606

</td>
<td style="text-align:right;">

0.6060606

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-C

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

13.9393939

</td>
<td style="text-align:right;">

13.9393939

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-C

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

0.6060606

</td>
<td style="text-align:right;">

0.6060606

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-C

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

0.6060606

</td>
<td style="text-align:right;">

0.6060606

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-C

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

1.8181818

</td>
<td style="text-align:right;">

1.8181818

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-C

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

1.2121212

</td>
<td style="text-align:right;">

1.2121212

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-C

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

8.4848485

</td>
<td style="text-align:right;">

8.4848485

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-C

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

0.6060606

</td>
<td style="text-align:right;">

0.6060606

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-C

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

1.8181818

</td>
<td style="text-align:right;">

1.8181818

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-C

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

6.6666667

</td>
<td style="text-align:right;">

6.6666667

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-C

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

2.4242424

</td>
<td style="text-align:right;">

2.4242424

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH299-MI-C

</td>
<td style="text-align:left;">

Draga + Red tipo D

</td>
<td style="text-align:right;">

1.8181818

</td>
<td style="text-align:right;">

1.8181818

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-A

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

0.3333333

</td>
<td style="text-align:right;">

0.3333333

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-A

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

5.3333333

</td>
<td style="text-align:right;">

5.3333333

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-A

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

0.6666667

</td>
<td style="text-align:right;">

0.6666667

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-A

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

0.3333333

</td>
<td style="text-align:right;">

0.3333333

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-A

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

0.6666667

</td>
<td style="text-align:right;">

0.6666667

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-A

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

0.3333333

</td>
<td style="text-align:right;">

0.3333333

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-A

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

0.3333333

</td>
<td style="text-align:right;">

0.3333333

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-A

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

2.6666667

</td>
<td style="text-align:right;">

2.6666667

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-A

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

1.0000000

</td>
<td style="text-align:right;">

1.0000000

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-A

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

2.6666667

</td>
<td style="text-align:right;">

2.6666667

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-A

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

1.0000000

</td>
<td style="text-align:right;">

1.0000000

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-A

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

0.6666667

</td>
<td style="text-align:right;">

0.6666667

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-A

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

2.0000000

</td>
<td style="text-align:right;">

2.0000000

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-A

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

7.0000000

</td>
<td style="text-align:right;">

7.0000000

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-A

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

0.3333333

</td>
<td style="text-align:right;">

0.3333333

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-A

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

1.0000000

</td>
<td style="text-align:right;">

1.0000000

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-A

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

0.3333333

</td>
<td style="text-align:right;">

0.3333333

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-A

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

1.0000000

</td>
<td style="text-align:right;">

1.0000000

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-B

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

2.3333333

</td>
<td style="text-align:right;">

2.3333333

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-B

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

2.3333333

</td>
<td style="text-align:right;">

2.3333333

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-B

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

2.0000000

</td>
<td style="text-align:right;">

2.0000000

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-B

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

0.3333333

</td>
<td style="text-align:right;">

0.3333333

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-B

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

32.0000000

</td>
<td style="text-align:right;">

32.0000000

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-B

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

28.0000000

</td>
<td style="text-align:right;">

28.0000000

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-B

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

0.3333333

</td>
<td style="text-align:right;">

0.3333333

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-B

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

2.3333333

</td>
<td style="text-align:right;">

2.3333333

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-B

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

0.3333333

</td>
<td style="text-align:right;">

0.3333333

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-B

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

5.3333333

</td>
<td style="text-align:right;">

5.3333333

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-B

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

1.0000000

</td>
<td style="text-align:right;">

1.0000000

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-B

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

5.3333333

</td>
<td style="text-align:right;">

5.3333333

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-B

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

1.0000000

</td>
<td style="text-align:right;">

1.0000000

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-B

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

3.3333333

</td>
<td style="text-align:right;">

3.3333333

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-B

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

2.0000000

</td>
<td style="text-align:right;">

2.0000000

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-B

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

0.3333333

</td>
<td style="text-align:right;">

0.3333333

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-B

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

1.0000000

</td>
<td style="text-align:right;">

1.0000000

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-C

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

0.3333333

</td>
<td style="text-align:right;">

0.3333333

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-C

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

0.3333333

</td>
<td style="text-align:right;">

0.3333333

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-C

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

0.6666667

</td>
<td style="text-align:right;">

0.6666667

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-C

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

0.3333333

</td>
<td style="text-align:right;">

0.3333333

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-C

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

0.6666667

</td>
<td style="text-align:right;">

0.6666667

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-C

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

0.3333333

</td>
<td style="text-align:right;">

0.3333333

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-C

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

1.3333333

</td>
<td style="text-align:right;">

1.3333333

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-C

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

1.3333333

</td>
<td style="text-align:right;">

1.3333333

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-C

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

6.0000000

</td>
<td style="text-align:right;">

6.0000000

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-C

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

3.3333333

</td>
<td style="text-align:right;">

3.3333333

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-C

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

2.0000000

</td>
<td style="text-align:right;">

2.0000000

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-C

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

0.6666667

</td>
<td style="text-align:right;">

0.6666667

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-C

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

0.3333333

</td>
<td style="text-align:right;">

0.3333333

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-C

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

0.3333333

</td>
<td style="text-align:right;">

0.3333333

</td>
</tr>
<tr>
<td style="text-align:left;">

ANH7-MI-C

</td>
<td style="text-align:left;">

Kick

</td>
<td style="text-align:right;">

0.6666667

</td>
<td style="text-align:right;">

0.6666667

</td>
</tr>
</tbody>
</table>

</div>

``` sql
SELECT qt_int/samp_effort_1, qt_double
FROM main.registros --USING (cd_reg)
LEFT JOIN main.event USING (cd_event)
LEFT JOIN main.gp_event USING (cd_gp_event)
WHERE cd_gp_biol='zopl'
```

<div class="knitsql-table">

<table>
<caption>

Displaying records 1 - 100

</caption>
<thead>
<tr>
<th style="text-align:right;">

?column?

</th>
<th style="text-align:right;">

qt_double

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.5000000

</td>
</tr>
<tr>
<td style="text-align:right;">

1.9259259

</td>
<td style="text-align:right;">

25.0370000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.4074074

</td>
<td style="text-align:right;">

4.4810000

</td>
</tr>
<tr>
<td style="text-align:right;">

1.7407407

</td>
<td style="text-align:right;">

24.3700000

</td>
</tr>
<tr>
<td style="text-align:right;">

2.4074074

</td>
<td style="text-align:right;">

32.5000000

</td>
</tr>
<tr>
<td style="text-align:right;">

2.5555556

</td>
<td style="text-align:right;">

46.0000000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.1851852

</td>
<td style="text-align:right;">

3.8888889

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.5930000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.7037037

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.4070000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.7777778

</td>
</tr>
<tr>
<td style="text-align:right;">

0.5185185

</td>
<td style="text-align:right;">

10.8888889

</td>
</tr>
<tr>
<td style="text-align:right;">

1.5000000

</td>
<td style="text-align:right;">

21.7500000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0555556

</td>
<td style="text-align:right;">

0.7777778

</td>
</tr>
<tr>
<td style="text-align:right;">

0.1666667

</td>
<td style="text-align:right;">

2.3333333

</td>
</tr>
<tr>
<td style="text-align:right;">

0.2777778

</td>
<td style="text-align:right;">

3.8888889

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0555556

</td>
<td style="text-align:right;">

0.7777778

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.8888889

</td>
</tr>
<tr>
<td style="text-align:right;">

0.7777778

</td>
<td style="text-align:right;">

10.8888889

</td>
</tr>
<tr>
<td style="text-align:right;">

0.3888889

</td>
<td style="text-align:right;">

5.4444444

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.5185185

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0555556

</td>
<td style="text-align:right;">

0.8888889

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.6111111

</td>
</tr>
<tr>
<td style="text-align:right;">

0.1666667

</td>
<td style="text-align:right;">

2.6666667

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0555556

</td>
<td style="text-align:right;">

0.6666667

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0555556

</td>
<td style="text-align:right;">

0.8888889

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0555556

</td>
<td style="text-align:right;">

0.4444444

</td>
</tr>
<tr>
<td style="text-align:right;">

1.8888889

</td>
<td style="text-align:right;">

24.5555556

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0555556

</td>
<td style="text-align:right;">

0.7777778

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0555556

</td>
<td style="text-align:right;">

0.8888889

</td>
</tr>
<tr>
<td style="text-align:right;">

0.2962963

</td>
<td style="text-align:right;">

4.8888889

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0555556

</td>
<td style="text-align:right;">

0.6666667

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.5925926

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0555556

</td>
<td style="text-align:right;">

0.6666667

</td>
</tr>
<tr>
<td style="text-align:right;">

0.1666667

</td>
<td style="text-align:right;">

2.0000000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.5481481

</td>
</tr>
<tr>
<td style="text-align:right;">

0.1111111

</td>
<td style="text-align:right;">

1.4444444

</td>
</tr>
<tr>
<td style="text-align:right;">

1.0740741

</td>
<td style="text-align:right;">

17.7222222

</td>
</tr>
<tr>
<td style="text-align:right;">

1.9629630

</td>
<td style="text-align:right;">

25.5185185

</td>
</tr>
<tr>
<td style="text-align:right;">

0.1111111

</td>
<td style="text-align:right;">

1.4444444

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0555556

</td>
<td style="text-align:right;">

0.7222222

</td>
</tr>
<tr>
<td style="text-align:right;">

0.2962963

</td>
<td style="text-align:right;">

3.8518519

</td>
</tr>
<tr>
<td style="text-align:right;">

5.2962963

</td>
<td style="text-align:right;">

68.8518518

</td>
</tr>
<tr>
<td style="text-align:right;">

0.1111111

</td>
<td style="text-align:right;">

1.5555556

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0555556

</td>
<td style="text-align:right;">

0.7777778

</td>
</tr>
<tr>
<td style="text-align:right;">

1.0555556

</td>
<td style="text-align:right;">

7.9166667

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0555556

</td>
<td style="text-align:right;">

0.7222222

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.4259259

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.4444444

</td>
</tr>
<tr>
<td style="text-align:right;">

1.5000000

</td>
<td style="text-align:right;">

13.9500000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.1111111

</td>
<td style="text-align:right;">

1.1111111

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0555556

</td>
<td style="text-align:right;">

0.6666667

</td>
</tr>
<tr>
<td style="text-align:right;">

3.7222222

</td>
<td style="text-align:right;">

44.6666667

</td>
</tr>
<tr>
<td style="text-align:right;">

5.6666667

</td>
<td style="text-align:right;">

107.6666667

</td>
</tr>
<tr>
<td style="text-align:right;">

1.2777778

</td>
<td style="text-align:right;">

15.3333333

</td>
</tr>
<tr>
<td style="text-align:right;">

0.1111111

</td>
<td style="text-align:right;">

1.1111111

</td>
</tr>
<tr>
<td style="text-align:right;">

0.1111111

</td>
<td style="text-align:right;">

2.1111111

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.4070000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0555556

</td>
<td style="text-align:right;">

0.5166667

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0555556

</td>
<td style="text-align:right;">

0.5166667

</td>
</tr>
<tr>
<td style="text-align:right;">

1.5555556

</td>
<td style="text-align:right;">

17.1111111

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0555556

</td>
<td style="text-align:right;">

1.0000000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0555556

</td>
<td style="text-align:right;">

0.9444444

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.5930000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.7777778

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.7777778

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.5185185

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.3700000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.1111111

</td>
<td style="text-align:right;">

1.5555556

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.6110000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.5930000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.5930000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.7037037

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.5560000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.5930000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.7037037

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.4810000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.6851852

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.4440000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.4260000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.1481481

</td>
<td style="text-align:right;">

2.8150000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0740741

</td>
<td style="text-align:right;">

1.0000000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.5185185

</td>
<td style="text-align:right;">

10.6300000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.1851852

</td>
<td style="text-align:right;">

3.7960000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.1111111

</td>
<td style="text-align:right;">

2.3330000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.1481481

</td>
<td style="text-align:right;">

2.9630000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.5925926

</td>
</tr>
<tr>
<td style="text-align:right;">

0.3333333

</td>
<td style="text-align:right;">

4.3330000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.8888889

</td>
<td style="text-align:right;">

12.4440000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.4814815

</td>
<td style="text-align:right;">

6.7410000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.5190000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.6111111

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0740741

</td>
<td style="text-align:right;">

1.0000000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0740741

</td>
<td style="text-align:right;">

1.2222222

</td>
</tr>
<tr>
<td style="text-align:right;">

0.4814815

</td>
<td style="text-align:right;">

6.5000000

</td>
</tr>
<tr>
<td style="text-align:right;">

3.0370370

</td>
<td style="text-align:right;">

51.6300000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.9629630

</td>
<td style="text-align:right;">

16.3700000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.6670000

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

0.4810000

</td>
</tr>
<tr>
<td style="text-align:right;">

3.4074074

</td>
<td style="text-align:right;">

44.2962963

</td>
</tr>
</tbody>
</table>

</div>

``` sql
SELECT qt_int/samp_effort_1, qt_double
FROM main.registros --USING (cd_reg)
LEFT JOIN main.event USING (cd_event)
LEFT JOIN main.gp_event USING (cd_gp_event)
WHERE cd_gp_biol='peri'
```

<div class="knitsql-table">

<table>
<caption>

Displaying records 1 - 100

</caption>
<thead>
<tr>
<th style="text-align:right;">

?column?

</th>
<th style="text-align:right;">

qt_double

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

1.550388e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.2222222

</td>
<td style="text-align:right;">

8.333333e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

3.472222e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0066313

</td>
<td style="text-align:right;">

7.957032e-01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0132626

</td>
<td style="text-align:right;">

5.262587e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0066313

</td>
<td style="text-align:right;">

7.957032e-01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0069171

</td>
<td style="text-align:right;">

8.299903e-01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0154154

</td>
<td style="text-align:right;">

1.233236e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0691706

</td>
<td style="text-align:right;">

7.841934e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0138341

</td>
<td style="text-align:right;">

1.568387e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.1541545

</td>
<td style="text-align:right;">

1.233236e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.1037560

</td>
<td style="text-align:right;">

1.244985e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.2183088

</td>
<td style="text-align:right;">

1.855625e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0069171

</td>
<td style="text-align:right;">

7.841934e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0415024

</td>
<td style="text-align:right;">

4.979942e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0069171

</td>
<td style="text-align:right;">

8.299903e-01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.1521754

</td>
<td style="text-align:right;">

1.725226e+03

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0132626

</td>
<td style="text-align:right;">

5.262587e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0291078

</td>
<td style="text-align:right;">

2.474167e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0276683

</td>
<td style="text-align:right;">

3.136774e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0224291

</td>
<td style="text-align:right;">

3.435251e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0138341

</td>
<td style="text-align:right;">

1.659981e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.3137362

</td>
<td style="text-align:right;">

1.897120e+03

</td>
</tr>
<tr>
<td style="text-align:right;">

0.1106730

</td>
<td style="text-align:right;">

1.327985e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0276683

</td>
<td style="text-align:right;">

1.584987e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0176087

</td>
<td style="text-align:right;">

1.672830e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0899218

</td>
<td style="text-align:right;">

1.019451e+03

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0704349

</td>
<td style="text-align:right;">

6.691319e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.3666044

</td>
<td style="text-align:right;">

4.156225e+03

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0138341

</td>
<td style="text-align:right;">

1.568387e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0138341

</td>
<td style="text-align:right;">

1.659981e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0066313

</td>
<td style="text-align:right;">

2.631294e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0066313

</td>
<td style="text-align:right;">

2.631294e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0464191

</td>
<td style="text-align:right;">

1.841906e+03

</td>
</tr>
<tr>
<td style="text-align:right;">

0.1061008

</td>
<td style="text-align:right;">

4.210070e+03

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0066313

</td>
<td style="text-align:right;">

7.957032e-01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0132626

</td>
<td style="text-align:right;">

5.262587e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0132626

</td>
<td style="text-align:right;">

5.262587e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0068204

</td>
<td style="text-align:right;">

5.456282e-01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0136407

</td>
<td style="text-align:right;">

8.248347e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0136407

</td>
<td style="text-align:right;">

8.248347e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0068204

</td>
<td style="text-align:right;">

5.456282e-01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0068204

</td>
<td style="text-align:right;">

5.456282e-01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0136407

</td>
<td style="text-align:right;">

8.248347e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

2.592593e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0648148

</td>
<td style="text-align:right;">

4.537037e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.2592593

</td>
<td style="text-align:right;">

1.814815e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.2314815

</td>
<td style="text-align:right;">

1.620370e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

6.481481e-01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.3148148

</td>
<td style="text-align:right;">

6.246326e+03

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

6.944444e-01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.2407407

</td>
<td style="text-align:right;">

4.776602e+03

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

1.837155e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.4444444

</td>
<td style="text-align:right;">

3.333333e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0185185

</td>
<td style="text-align:right;">

1.388889e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

6.944444e-01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

6.944444e-01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

6.944444e-01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.1481481

</td>
<td style="text-align:right;">

6.222222e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

6.759259e-01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0462963

</td>
<td style="text-align:right;">

3.240741e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0740741

</td>
<td style="text-align:right;">

5.333333e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

8.518519e-01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

8.518519e-01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

1.759259e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0185185

</td>
<td style="text-align:right;">

1.759259e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0925926

</td>
<td style="text-align:right;">

8.796296e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0925926

</td>
<td style="text-align:right;">

8.796296e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.3703704

</td>
<td style="text-align:right;">

3.518519e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

8.796296e-01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

8.796296e-01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

8.796296e-01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

3.111111e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

7.407407e-01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

7.407407e-01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

3.472222e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

3.472222e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

4.592887e+03

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

3.472222e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.1111111

</td>
<td style="text-align:right;">

4.166667e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.2962963

</td>
<td style="text-align:right;">

4.444444e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

1.2222222

</td>
<td style="text-align:right;">

1.833333e+02

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

1.388889e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

1.388889e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0185185

</td>
<td style="text-align:right;">

2.777778e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0740741

</td>
<td style="text-align:right;">

7.348618e+03

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0370370

</td>
<td style="text-align:right;">

5.555556e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

3.472222e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

1.530962e+03

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

1.530962e+03

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

1.530962e+03

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

1.530962e+03

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

3.472222e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

3.8611111

</td>
<td style="text-align:right;">

6.384112e+05

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

1.530962e+03

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

1.530962e+03

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0092593

</td>
<td style="text-align:right;">

3.472222e+00

</td>
</tr>
<tr>
<td style="text-align:right;">

4.7222222

</td>
<td style="text-align:right;">

1.770833e+03

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0056073

</td>
<td style="text-align:right;">

8.588128e+01

</td>
</tr>
<tr>
<td style="text-align:right;">

0.0056073

</td>
<td style="text-align:right;">

8.588128e+01

</td>
</tr>
</tbody>
</table>

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

<table>
<caption>

91 records

</caption>
<thead>
<tr>
<th style="text-align:right;">

cd_reg

</th>
<th style="text-align:left;">

table_orig

</th>
<th style="text-align:left;">

row.names

</th>
<th style="text-align:left;">

organism_quantity

</th>
<th style="text-align:left;">

sex

</th>
<th style="text-align:left;">

life_stage

</th>
<th style="text-align:left;">

reproductive_condition

</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">

38570

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1792

</td>
<td style="text-align:left;">

7

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

37743

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1392

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

36395

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

31

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactante

</td>
</tr>
<tr>
<td style="text-align:right;">

36367

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

12

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

36397

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

25

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

36526

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

105

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

36573

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

108

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

36485

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

208

</td>
<td style="text-align:left;">

3

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

37046

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

498

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

37067

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

499

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

37411

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

823

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

37603

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

973

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactante

</td>
</tr>
<tr>
<td style="text-align:right;">

37669

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

977

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

37659

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

979

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

37590

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

980

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

37752

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1103

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactante

</td>
</tr>
<tr>
<td style="text-align:right;">

37954

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1107

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

37873

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1241

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactante

</td>
</tr>
<tr>
<td style="text-align:right;">

38092

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1482

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactante

</td>
</tr>
<tr>
<td style="text-align:right;">

38032

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1483

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactante

</td>
</tr>
<tr>
<td style="text-align:right;">

38040

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1485

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactante

</td>
</tr>
<tr>
<td style="text-align:right;">

38063

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1486

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactante

</td>
</tr>
<tr>
<td style="text-align:right;">

38235

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1581

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactante

</td>
</tr>
<tr>
<td style="text-align:right;">

38203

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1582

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactante

</td>
</tr>
<tr>
<td style="text-align:right;">

38374

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1586

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

38301

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1591

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

38385

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1593

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

38475

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1671

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

38434

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1673

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

38544

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1768

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

38571

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1793

</td>
<td style="text-align:left;">

5

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

38569

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1796

</td>
<td style="text-align:left;">

4

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

38728

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1900

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

38749

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1911

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

38769

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1930

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

38780

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1940

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

38885

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

2070

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

40944

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

2210

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Juvenil

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

39403

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

2500

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

39143

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

2626

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

39686

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

2795

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

39511

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

2791

</td>
<td style="text-align:left;">

3

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

39930

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

2847

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

39902

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

2853

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

40010

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

2954

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

39707

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

2963

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

40028

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

3032

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

40240

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

3139

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

40601

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

3386

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

40633

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

3391

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

39528

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

3414

</td>
<td style="text-align:left;">

3

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

40642

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

3416

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

40863

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

3554

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

40927

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

3592

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

40914

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

3613

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

37271

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

36521

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

207

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

37077

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

495

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

37272

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

746

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactante

</td>
</tr>
<tr>
<td style="text-align:right;">

37255

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

747

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactante

</td>
</tr>
<tr>
<td style="text-align:right;">

37243

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

748

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactante

</td>
</tr>
<tr>
<td style="text-align:right;">

37425

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

829

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactante

</td>
</tr>
<tr>
<td style="text-align:right;">

37614

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1035

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactante

</td>
</tr>
<tr>
<td style="text-align:right;">

37724

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1106

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

38013

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1108

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

37754

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1122

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactante

</td>
</tr>
<tr>
<td style="text-align:right;">

38070

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1484

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactante

</td>
</tr>
<tr>
<td style="text-align:right;">

38175

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1579

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactante

</td>
</tr>
<tr>
<td style="text-align:right;">

38140

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1580

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactante

</td>
</tr>
<tr>
<td style="text-align:right;">

38435

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1718

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactante

</td>
</tr>
<tr>
<td style="text-align:right;">

38488

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1726

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

38518

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1727

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

38529

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1740

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactante

</td>
</tr>
<tr>
<td style="text-align:right;">

38701

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1855

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

38720

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1875

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

38772

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

1897

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

39180

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

2343

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

39458

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

2630

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

39886

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

2846

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

39898

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

2848

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

39900

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

2849

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

39890

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

2852

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

39901

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

2854

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

39949

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

2857

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

40030

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

3105

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

40632

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

3390

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

40705

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

3450

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

40627

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

3509

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Gestante

</td>
</tr>
<tr>
<td style="text-align:right;">

40912

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

3615

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

40969

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

3651

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
<tr>
<td style="text-align:right;">

40968

</td>
<td style="text-align:left;">

mamiferos_registros

</td>
<td style="text-align:left;">

3656

</td>
<td style="text-align:left;">

2

</td>
<td style="text-align:left;">

Hembra

</td>
<td style="text-align:left;">

Adulto

</td>
<td style="text-align:left;">

Lactando

</td>
</tr>
</tbody>
</table>

</div>

``` r
dbDisconnect(fracking_db)
```

    ## [1] TRUE
