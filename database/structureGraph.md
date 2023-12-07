Estructura y descripción de la base de datos
================
Marius Bottin
2023-12-07

- [1 Configuración de R](#1-configuración-de-r)
- [2 Tablas principales](#2-tablas-principales)
- [3 Niveles de organización de la base de
  datos](#3-niveles-de-organización-de-la-base-de-datos)
- [4 Tablas de definición](#4-tablas-de-definición)
- [5 Formato DarwinCore y análisis](#5-formato-darwincore-y-análisis)

------------------------------------------------------------------------

# 1 Configuración de R

``` r
require(RPostgreSQL)
## Loading required package: RPostgreSQL
## Loading required package: DBI
require(dm)
## Loading required package: dm
## 
## Attaching package: 'dm'
## The following object is masked from 'package:stats':
## 
##     filter
require(DiagrammeRsvg)
## Loading required package: DiagrammeRsvg
require(rsvg)
## Loading required package: rsvg
## Linking to librsvg 2.54.4
require(png)
## Loading required package: png
knitr::opts_chunk$set(cache=F,tidy.opts = list(width.cutoff = 70), 
                      tidy = TRUE, connection="fracking_db",
                      max.print=50,fig.path="./Fig/estructBase_",echo=T,
                      collapse=T, echo=F)
def.chunk.hook  <- knitr::knit_hooks$get("chunk")
knitr::knit_hooks$set(chunk = function(x, options) {
  x <- def.chunk.hook(x, options)
  paste0("\n \\", "footnotesize","\n\n", x, "\n\n \\normalsize\n\n")
})
options(knitr.kable.NA = "---")
fracking_db <- dbConnect(PostgreSQL(), dbname='fracking')
infoTablesDB <- read.csv("./tables_database.csv",colClasses = c("character","character","factor",NA,NA,NA))
infoTablesDB[,4:ncol(infoTablesDB)]<-lapply(infoTablesDB[,4:ncol(infoTablesDB)],as.logical)
```

# 2 Tablas principales

    ## Warning: <PostgreSQLConnection> uses an old dbplyr interface
    ## ℹ Please install a newer version of the package or contact the maintainer
    ## This warning is displayed once every 8 hours.

<div class="figure">

<img src="../../../../../../../tmp/RtmpboInYK/file418743f821d8.png" alt="\label{fig:mainStruct} Esquéma principal de la base de datos creada para el proyecto ANH. Las tablas presentadas acá son las tablas que definen la estructura principal y general de la base de datos, sin las tablas accesorias." width="15cm" height="15cm" />

<p class="caption">

Esquéma principal de la base de datos creada para el proyecto ANH. Las
tablas presentadas acá son las tablas que definen la estructura
principal y general de la base de datos, sin las tablas accesorias.

</p>

</div>

En la figura , se representan las tablas principales de la base de
datos. Esas tablas permiten entender la estructura generale de la base
de datos:

- *platform*: definición espacial de las zonas grandes en la base de
  datos (Kalé, Platero, Caracterización)
- *punto_referencia*: corresponde a los “sitios”, llamados “ANH” en el
  proyecto
- *gp_event*: corresponde a la asociación entre grupos biologicos, un
  protocolos de muestreo, “sitios” (ANH), y campañas de muestreo
- *event*: corresponde a los eventos de muestreo en los sitios, o sea
  una base sobre cual se puede calcular una unidad de esfuerzo de
  muestreo, y se definen los metadatos de los muestreos de diversidad
- *registros*: en esta tabla se definen la abundancias y/o occurrencias
  de las especies, es la tabla que incluye los datos basicos
- *taxo*: en esta tabla se definen todos los taxones (desde las
  subespecies hasta los reinos)
- *morfo_taxo*: en esta tabla se definen los morfo-taxones

Estas 5 tablas principales están en rojo en la figura

<div class="figure">

<img src="./Fig/estructBase_tablasPrincipales_all-1.png" alt="\label{fig:mainStruct_all} Esquéma de la base de datos creada para el proyecto ANH. Las tablas en rojo corresponden a las tablas presentadas en la figura \ref{fig:mainStruct}" height="\textheight" />

<p class="caption">

Esquéma de la base de datos creada para el proyecto ANH. Las tablas en
rojo corresponden a las tablas presentadas en la figura

</p>

</div>

# 3 Niveles de organización de la base de datos

Para explicar y simplificar la base de datos, podemos describir 8
niveles de organización principal:

- *registros*: nivel que corresponde a los registros de especies
- *eventos*: nivel que corresponde a los eventos de muestreo (metadatos
  y unidad de esfuerzo de muestreo)
- *grupos de eventos*: nivel que corresponde a la asociación entre
  grupos biológicos, métodos de muestreo, temportada y sitios (“campañas
  de muestreo”)
- *sitios*: nivel que corresponde a los sitios de muestreo (“ANH”)
- *taxonomico*: nivel de definición de las informaciones taxonomicas
- *geografico*: nivel de definición de las informaciones espaciales y/o
  geográficas
- *gente*: nivel de definición de las personas y instituciones
- *otros*: tablas que no se pueden clasificar en esos 8 niveles de
  organización (usualmente son tablas que pueden asociarse a varios
  niveles de organización)

<div class="figure">

<img src="./Fig/estructBase_tablasNiveles-1.png" alt="\label{fig:levels_struct} Esquéma de la base de datos creada para el proyecto ANH. Los colores de las tablas corresponde a los 8 niveles principales de la base de datos" height="\textheight" />

<p class="caption">

Esquéma de la base de datos creada para el proyecto ANH. Los colores de
las tablas corresponde a los 8 niveles principales de la base de datos

</p>

</div>

# 4 Tablas de definición

Para racionalizar el almacenamiento de los datos y permitir la
simplificación del tratamiento de las consultas, varias tablas
conciernen la definición de categorias y variables. Esto permite no
repetir datos en la base de datos. Por ejemplo, la categoria “Mamíferos”
como grupo biologico terrestre está definida en una fila de una tabla de
la base de datos, pero está referenciada en varias tablas después. Eso
quiere decir que la modificación de este grupo se puede hacer con una
sola operación, y que no tenemos el riesgo de tener varías ortografías
diferentes, que harían pensar que “mamiferos” y “Mamíferos” corresponden
a 2 grupos diferentes…

Las tablas de definición están representadas en rojo en la figura , la

<div class="figure">

<img src="./Fig/estructBase_tablasDefiniciones-1.png" alt="\label{fig:tablas_def} Esquéma de la base de datos creada para el proyecto ANH. Las tablas representadas en rojo corresponden a tablas de definiciones" height="\textheight" />

<p class="caption">

Esquéma de la base de datos creada para el proyecto ANH. Las tablas
representadas en rojo corresponden a tablas de definiciones

</p>

</div>

<div class="figure">

<img src="./Fig/estructBase_tablasSinDef-1.png" alt="\label{fig:tablas_sinDef} Esquéma de la base de datos creada para el proyecto ANH. Los colores de las tablas corresponde a los 8 niveles principales de la base de datos, no se representan las tablas de definición en esta figura" height="\textheight" />

<p class="caption">

Esquéma de la base de datos creada para el proyecto ANH. Los colores de
las tablas corresponde a los 8 niveles principales de la base de datos,
no se representan las tablas de definición en esta figura

</p>

</div>

# 5 Formato DarwinCore y análisis

La base de datos se estructuró con un objetivo de estar compatible con
el formato DarwinCore. Es decir que los campos que están en el formato
DarwinCore deben poder entrar en la estructura de la base de datos. El
objetivo es poder crear una herramienta de exportación de archivos
DarwinCore desde la base de datos, inclusive si los análisis no
necesitan los datos y campos que se crearón.

En la figura se representan en rojo las tablas creadas para la
exportación de formatos DarwinCore completos, y la figura representa
únicamente las tablas útiles para los análisis estadísticos y ecológicos
de los datos. Anotar: la mayoría de las tablas para las exportación
DarwinCore son tablas de metadatos a escala de los registros para los
catálogos de muestras de tejidos, archivos multimedia etc. Por ahora
(principio de noviembre de 2022) la estructura de esos datos existe en
la base de datos, pero los datos no se integraron todavía,

<div class="figure">

<img src="./Fig/estructBase_tablasDwc-1.png" alt="\label{fig:tablas_dwc} Esquéma de la base de datos creada para el proyecto ANH. Las tablas representadas en rojo corresponden a tablas que no se utilizan en los análisis estadísticos del proyecto ANH pero que son necesarias para poder exportar archivos DarwinCore completos." height="\textheight" />

<p class="caption">

Esquéma de la base de datos creada para el proyecto ANH. Las tablas
representadas en rojo corresponden a tablas que no se utilizan en los
análisis estadísticos del proyecto ANH pero que son necesarias para
poder exportar archivos DarwinCore completos.

</p>

</div>

<div class="figure">

<img src="./Fig/estructBase_tablasSinDwc-1.png" alt="\label{fig:tablas_sinDwc} Esquéma de la base de datos creada para el proyecto ANH. Los colores de las tablas corresponde a los 8 niveles principales de la base de datos, no se representan las tablas necesarias para la exportación de archivos DarwinCore" height="\textheight" />

<p class="caption">

Esquéma de la base de datos creada para el proyecto ANH. Los colores de
las tablas corresponde a los 8 niveles principales de la base de datos,
no se representan las tablas necesarias para la exportación de archivos
DarwinCore

</p>

</div>
