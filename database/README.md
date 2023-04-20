In this folder, you will find all the codes which were used to create the database from the files that the researchers of each group sent to the I2D.

********

Note: in the future we will integrate the code for building the database from the data publicly available from the I2D.

******

1. file [reinitialize_base.R](reinitialize_base.R) is a R script which calls all the main operation on the databases (it calls SQL files and render rmarkdown documents containing the codes for building the database)
1. file [rawdata.Rmd](./rawdata.md) contains the codes to read raw files
1. file [taxonomy.Rmd](./taxonomy.md) contains the codes to treat taxonomy of every group
1. file [integración_estructura_muestreo.Rmd](./integración_estructura_muestreo.md) contains the code to integrate all the main data of every group in the database structure
1. file [correction_misc.Rmd](./correction_misc.md) contains supplementary corrections which have been made on the raw data
1. file [datos_registros_suplementarios.Rmd](./datos_registros_suplementarios.md) contains the treatment of supplementary data which have been integrated in the database for some groups
1. file [punto_referencia_habitats.Rmd](./punto_referencia_habitats.md) contains the integration of spatial habitat data
1. file [variables_ambientales.Rmd](./variables_ambientales.md) contains the reading and importing of environmental variables
1. file [exportación_datos.Rmd](./exportación_datos.md) contains the creation of VIEWS for exporting treatable data for each group

