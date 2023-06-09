# biodiversity-puerto-wilches

## Object y objetives

The main objective of this repository is to share R and SQL code which we used to manage data and analyse the baseline biodiversity in Puerto Wilches, Santander, Colombia.
This project has been conducted around a project of fracking test phase in this municipality, since then fracking projects have been paused in Colombia.
One of the main interesting part of this study is that a very extensive biodiversity sampling effort have been conducted by the Instituto Alexander von Humboldt, concerning plants, insects, other arthropods, birds and mammals, as a collaboration with the ANH (Agencia Nacional de Hidrocarburos).

## Content

The repository includes:

1. folder [database](./database): data integration in a *postgreSQL* database ( code in R y SQL, presented as Rmarkdown files). 
2. folder [analyses](.analyses): includes analyses code (mainly in R, presented in Rmarkdown files)

## Requirements

In order to run the codes presented in this repository, you will need:

* PostgreSQL
* postgis extension
* pandoc
* R with the following packages:
   + rmarkdown
   + knitr
   + DiagrammeRsvg
   + dm
   + ggplot2
   + htmltools
   + iNEXT
   + kableExtra
   + leaflet
   + openxlsx
   + png
   + readxl
   + rpostgis
   + sp
   + RPostgreSQL
   + rsvg
   + sqldf
   + vegan

You will need to create an empty Postgres database called "fracking", which may be done in bash by:

```
createdb fracking
```

In postgreSQL, call for the postgis extension by entering:

```
CREATE EXTENSION postgis;
```

We recommend the use of [pgpass](https://www.postgresql.org/docs/current/libpq-pgpass.html) to be able to connect to the database without needing to give the password (nor the host in a server based setup).

# Rmarkdown documents

Most of the codes of this repository are presented in rmarkdown document (Rmd extension).

You may render them as github documents with the following command in R:

```
rmarkdown::render("filename.Rmd")
```

However, since github document are not easy to read on a local machine, you may want to use:

```
rmarkdown::render("filename.Rmd", output_format="html_document")
```

If you have a functional latex distribution on your computer (see tinytex R package to install one otherwise), you may even create pdf report out of the rmarkdown files using:

```
rmarkdown::render("filename.Rmd", output_format="pdf_document")
```


