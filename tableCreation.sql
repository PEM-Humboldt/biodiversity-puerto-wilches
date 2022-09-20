CREATE SCHEMA main;
CREATE TABLE main.platform
(
    cd_plat serial PRIMARY KEY,
    platform text UNIQUE NOT NULL
);
SELECT AddGeometryColumn('main', 'platform', 'zona_geom', 3116, 'POLYGON', 2);
SELECT AddGeometryColumn('main', 'platform', 'plat_geom', 3116, 'POLYGON', 2);
CREATE INDEX platform_zona_geom_geog_idx ON main.platform USING GIST( zona_geom );
CREATE INDEX platform_plat_geom_geog_idx ON main.platform USING GIST( plat_geom );


CREATE TABLE main.punto_referencia
(
    cd_pt_ref serial PRIMARY KEY,
    name_pt_ref varchar(10) UNIQUE NOT NULL,
    --cd_plat int REFERENCES main.platform(cd_plat) ON DELETE SET NULL ON UPDATE CASCADE,
    num_anh integer UNIQUE
)
;
--CREATE INDEX punto_referencia_cd_plat_key ON main.punto_referencia(cd_plat);

CREATE TABLE main.def_gp_biol
(
    cd_gp_biol char(4) PRIMARY KEY,
    biol_gp varchar(50) UNIQUE NOT NULL,
    super_gp varchar(50),
    biol_gp_spa varchar(50),
    super_gp_spa varchar(50),
    aquatic boolean

);
INSERT INTO main.def_gp_biol
VALUES
    ('herp', 'Herpetofauna',NULL,'Herpetos',NULL,false),
    ('atro', 'Atropellamientos', NULL, 'Atropellamientos', NULL,false),
    ('aves', 'Birds', NULL, 'Aves',NULL,false),
    ('arbo', 'Trees', 'Botany', 'Arbórea', 'Botánica',false),
    ('epva', 'Vascular epiphytes', 'Botany', 'Epifitas vasculares','Botánica',false),
    ('epnv', 'Non-vascular epiphytes', 'Botany', 'Epifitas no vasculares', 'Botánica',false),
    ('cole', 'Collembola', NULL, 'Colémbolos', NULL,false),
    ('esca', 'Beetles', NULL, 'Escarabajos', NULL,false),
    ('horm','Ants', NULL, 'Hormigas', NULL,false),
    ('mami','Mammals', NULL, 'Mamiferos', NULL,false),
    ('mari','Butterflies', NULL, 'Mariposas', NULL,false),
    ('pece', 'Fishes', NULL, 'Peces', NULL,true),
    ('fipl','Phytoplankton', 'Hydrobiology', 'Fitoplancton', 'Hidrobiología',true),
    ('zopl', 'Zooplankton' , 'Hydrobiology', 'Zooplancton', 'Hidrobiología',true),
    ('peri', 'Periphyton' , 'Hydrobiology', 'Perifiton', 'Hidrobiología',true),
    ('mafi', 'Macrophytes' , 'Hydrobiology', 'Macrofitas', 'Hidrobiología',true),
    ('minv', 'Macroinvertebrates' , 'Hydrobiology', 'Macroinvertebrados', 'Hidrobiología',true),
    ('catr', 'Camera traps', NULL, 'Cameras trampa', NULL, false),
    ('arch', 'Archaea', 'Microorganisms', 'Arqueas', 'Microorganismos', false),
    ('bact', 'Bacteria', 'Microorganisms', 'Bacteria', 'Microorganismos', false),
    ('paso', 'Soundscape',NULL, 'Paísajes sonores', NULL, false)

;

CREATE TABLE main.def_measurement_type -- a measurement type is something like distance, area, time, density, number of individuals, density, concentration, volume. This allows us to define what is virtually possible to translate from one variable to another.
(
    cd_measurement_type smallserial PRIMARY KEY,
    measurement_type text
);

INSERT INTO main.def_measurement_type(measurement_type)
VALUES
    ('area'),
    ('time'),
    ('distance'),
    ('density'),
    ('number of traps'),
    ('number of individuals'),
    ('presence/absence'),
    ('longitude'),
    ('volume'),
    ('number concentration'),
    ('mass concentration'),
    ('volume concentration'),
    ('percentage')
    ;

--('area', 'time', 'number of traps', 'distancia', 'number of individuals', 'density', 'concentration'))

CREATE TABLE main.def_unit
(
    cd_unit smallserial PRIMARY KEY,
    cd_measurement_type smallint REFERENCES main.def_measurement_type(cd_measurement_type) NOT NULL,
    unit text NOT NULL UNIQUE,
    unit_spa text,
    abbv_unit text,
    factor double precision NOT NULL,
    UNIQUE (cd_measurement_type,unit)
);

CREATE TABLE main.def_var_samp_eff -- a variable is a definition more precise than measurement type, for example concentration of oxygen is a variable, while concentration is a measurement type
(
    cd_var_samp_eff smallserial PRIMARY KEY,
    var_samp_eff text UNIQUE NOT NULL,
    var_samp_eff_spa text,
    cd_unit smallint REFERENCES main.def_unit(cd_unit) ON DELETE SET NULL ON UPDATE CASCADE NOT NULL ,--this is the reference unit it allows to determine both the reference unit and the measurement type
    type_variable varchar(25),
    CHECK (type_variable IN ('int', 'double precision'))
);

CREATE TABLE main.def_var_ind_qt
(
    cd_var_ind_qt smallserial PRIMARY KEY,
    var_qt_ind text UNIQUE NOT NULL,
    var_qt_ind_spa text,
    cd_unit smallint REFERENCES main.def_unit(cd_unit) ON DELETE SET NULL ON UPDATE CASCADE NOT NULL,
    type_variable varchar(20),
    CHECK (type_variable IN ('int', 'double precision'))
);

/*
CREATE TABLE main.def_categ
(
    cd_categ serial PRIMARY KEY,
    cd_var int REFERENCES main.def_variable,
    categ text,
    description text,
    UNIQUE (cd_var,categ)
);
*/

CREATE TABLE main.def_protocol
(
    cd_protocol smallserial PRIMARY KEY,
    protocol text UNIQUE NOT NULL,
    protocol_spa text,
    cd_var_samp_eff_1 smallint REFERENCES main.def_var_samp_eff(cd_var_samp_eff),
    samp_eff_1_implicit boolean,
    cd_var_samp_eff_2 smallint REFERENCES main.def_var_samp_eff(cd_var_samp_eff),
    samp_eff_2_implicit boolean,
    cd_var_ind_qt smallint REFERENCES main.def_var_ind_qt(cd_var_ind_qt),
    description_spa text,
    description text
);
CREATE INDEX def_protocol_cd_var_samp_eff_1_fkey ON main.def_protocol(cd_var_samp_eff_1);
CREATE INDEX def_protocol_cd_var_samp_eff_2_fkey ON main.def_protocol(cd_var_samp_eff_2);
CREATE INDEX def_protocol_cd_var_ind_qt_fkey ON main.def_protocol(cd_var_ind_qt);



CREATE TABLE main.institution
(
    cd_inst smallserial PRIMARY KEY,
    name text
);

CREATE TABLE main.people
(
    cd_person smallserial PRIMARY KEY,
    verbatim_person text UNIQUE NOT NULL,
    first_name text,
    family_name text,
    initials varchar(5),
    mail text,
    cd_inst smallint REFERENCES main.institution(cd_inst)
);

CREATE TABLE main.gp_event
(
    cd_gp_event serial PRIMARY KEY,
    cd_pt_ref integer REFERENCES main.punto_referencia(cd_pt_ref) ON DELETE SET NULL ON UPDATE CASCADE,
    cd_gp_biol char(4) REFERENCES main.def_gp_biol(cd_gp_biol) ON DELETE CASCADE NOT NULL,
    cd_protocol int REFERENCES main.def_protocol(cd_protocol) ON DELETE SET NULL ON UPDATE CASCADE ,
    campaign_nb int NOT NULL,
    subpart varchar(10),
    UNIQUE(cd_pt_ref,cd_gp_biol,cd_protocol,campaign_nb,subpart)
);
CREATE INDEX gp_event_cd_punto_ref_fkey ON main.gp_event(cd_pt_ref);
CREATE INDEX gp_event_cd_gp_biol_fkey ON main.gp_event(cd_gp_biol);
CREATE INDEX gp_event_cd_protocol_fkey ON main.gp_event(cd_protocol);



CREATE TABLE main.event
(
    cd_event serial PRIMARY KEY,
    event_id text UNIQUE,
    cd_gp_event int REFERENCES main.gp_event(cd_gp_event) ON DELETE CASCADE NOT NULL,
    num_replicate int NOT NULL, --numero de la trampa o del evento (dentro del gp_event)
    description_replicate text, --part of the eventID that describes the replicate
    date_time_begin timestamp,
    date_time_end timestamp,
    locality_verb text,
    samp_effort_1 double precision,
    samp_effort_2 double precision,
    event_remarks text,
    cds_creator integer[] ,-- note: we can't use foreign keys because more than  one person might have created the event, otherwise we need to make more tables.
    created date,
    UNIQUE (cd_gp_event, num_replicate),
    CHECK (date_time_begin<date_time_end OR date_time_begin IS NULL OR date_time_end IS NULL)
)
;
CREATE INDEX event_cd_gp_event_fkey ON main.event(cd_gp_event);
SELECT AddGeometryColumn('main', 'event', 'pt_geom', 3116, 'POINT', 2);
CREATE INDEX event_pt_geom_idx ON main.event USING GIST(pt_geom);
SELECT AddGeometryColumn('main', 'event', 'li_geom', 3116, 'LINESTRING', 2);
CREATE INDEX event_li_geom_idx ON main.event USING GIST(li_geom);
SELECT AddGeometryColumn('main', 'event', 'pol_geom', 3116, 'POLYGON', 2);
CREATE INDEX event_pol_geom_idx ON main.event USING GIST(pol_geom);

CREATE TABLE main.def_tax_rank
(
    cd_rank varchar(6) PRIMARY KEY,
    tax_rank text UNIQUE NOT NULL,
    tax_rank_spa text UNIQUE NOT NULL,
    rank_level int UNIQUE NOT NULL,
    marker varchar(7) UNIQUE,
    placement_marker varchar(40),
    CHECK (placement_marker IN ('before epithet', 'absent'))
);


INSERT INTO main.def_tax_rank
VALUES
    ('FORM', 'form', 'forma', 1,'f.','before epithet'),
    ('SUBVAR', 'subvariety','subvariedad', 2,'subvar.', 'before epithet'),
    ('VAR', 'variety','variedad', 3,'var.', 'before epithet'),
    ('SUBSP', 'subspecies', 'subespecie', 9, 'subsp.', 'before epithet'),
    ('SP', 'species', 'especie', 10, 'sp.', 'absent'),
    ('SPSP', 'superspecies', 'superespecie', 11, NULL, 'absent'),
    ('SGN', 'subgenus', 'subgénero', 19, 'subgen.', 'before epithet'),
    ('GN', 'genus', 'género', 20,'gen.', 'absent'),
    ('TR', 'tribe', 'tribu', 21, NULL, 'absent'),
    ('SFAM', 'subfamily', 'subfamilia', 99,'subfam.', 'absent'),
    ('FAM', 'family', 'familia', 100,'fam.', 'absent'),
    ('SPFAM', 'superfamily', 'superfamilia', 101,NULL, 'absent'),
    ('SOR', 'suborder', 'suborden', 199,NULL, 'absent'),
    ('OR', 'order', 'orden', 200,'ord.', 'absent'),
    ('LEG', 'legion', 'legión', 201,NULL, 'absent'),
    ('SCL', 'subclass', 'subclase', 299,NULL, 'absent'),
    ('CL', 'class', 'clase', 300, 'cl.', 'absent'),
    ('SPCL', 'superclass', 'superclase', 301,NULL, 'absent'),
    ('SPHY', 'subphylum', 'subfilo', 399,NULL, 'absent'),
    ('PHY', 'phylum', 'filo', 400,'phyl.', 'absent'),
    ('SPPHY', 'superphylum', 'superfilo', 401,NULL, 'absent'),
    ('SKG', 'subkingdom', 'subreino', 499,NULL, 'absent'),
    ('KG', 'kingdom', 'reino', 500,NULL, 'absent'),
    ('SPKG', 'superkingdom', 'superreino', 501,NULL, 'absent'),
    ('SDOM', 'subdomain', 'subdominio', 999,NULL, 'absent'),
    ('DOM', 'domain', 'dominio', 1000,NULL, 'absent');

CREATE TABLE main.taxo
(
    cd_tax serial PRIMARY KEY,
    name_tax text UNIQUE,
    authorship text,
    cd_rank varchar(6) REFERENCES main.def_tax_rank(cd_rank) ON DELETE SET NULL ON UPDATE CASCADE,
    cd_parent int REFERENCES main.taxo(cd_tax) ON UPDATE CASCADE,
    UNIQUE(name_tax, authorship),
    CHECK(cd_rank IN ('KG', 'DOM') OR cd_parent IS NOT NULL),
    CHECK(
        CASE
            WHEN cd_rank IN ('SGN', 'GN', 'TR', 'SFAM', 'FAM', 'SPFAM', 'SOR', 'OR', 'LEG', 'SCL', 'CL', 'SPCL', 'SPHY', 'PHY', 'SPPHY', 'SKG', 'KG', 'SPKG', 'SDOM', 'DOM') THEN name_tax ~ '^[A-Z][a-z-]+$' OR name_tax ~ '^[A-Z][a-z-]+ (ordo )?incertae sedis$'
            WHEN cd_rank='SP' THEN name_tax ~ '^[A-Z][a-z-]+ [a-z-]+$'
            WHEN cd_rank IN ('FORM','SUBVAR','VAR','SUBSP') THEN name_tax ~ '^[A-Z][a-z-]+ [a-z-]+ [a-z-]+$'
        END
        )
);
CREATE INDEX taxo_cd_parent_key ON main.taxo(cd_parent);
CREATE INDEX taxo_cd_rank_key ON main.taxo(cd_rank);

CREATE TABLE main.morfo_taxo
(
    cd_morfo serial PRIMARY KEY,
    cd_gp_biol char(4) REFERENCES main.def_gp_biol,
    cd_tax int REFERENCES main.taxo(cd_tax) ON DELETE CASCADE ON UPDATE CASCADE,
    name_morfo text NOT NULL,
    verbatim_taxon text,
    description text,
    --min_level int REFERENCES main.def_nivel_taxo(cd_niv_taxo),
    --max_level int REFERENCES main.def_nivel_taxo(cd_niv_taxo),
    pseudo_rank varchar(6) REFERENCES main.def_tax_rank(cd_rank) ON DELETE SET NULL ON UPDATE CASCADE,
    cds_tax_possibilities integer[],
    UNIQUE(cd_tax,cd_gp_biol,name_morfo)
);
CREATE INDEX morfo_taxo_cd_gp_biol_key ON main.morfo_taxo(cd_gp_biol);
CREATE INDEX morfo_taxo_cd_tax_key ON main.morfo_taxo(cd_tax);
CREATE INDEX morfo_taxo_pseudo_rank_key ON main.morfo_taxo(pseudo_rank);

CREATE TABLE main.registros
(
    cd_reg serial PRIMARY KEY,
    cd_event int REFERENCES main.event(cd_event) ON DELETE CASCADE NOT NULL,
    cds_recorded_by int[],
    date_time timestamp,
    locality_verb text,
    organism_id text,
    cd_tax integer REFERENCES main.taxo(cd_tax),
    cd_morfo integer REFERENCES main.morfo_taxo(cd_morfo),
    date_ident date,
    cds_identified_by int[],-- note: we can't use foreign keys because more than  one person might have created the event, otherwise we need to make more tables.
    qt_int integer,
    qt_double double precision,
    remarks text,
    occurrence_id text UNIQUE,
    UNIQUE (cd_event,organism_id)
);
SELECT AddGeometryColumn('main', 'registros', 'the_geom', 3116, 'POINT', 2);
CREATE INDEX registros_cd_event_idx ON main.registros USING GIST(the_geom);
CREATE INDEX registros_cd_event_fkey ON main.registros(cd_event);
CREATE INDEX registros_cd_tax_fkey ON main.registros(cd_tax);
CREATE INDEX registros_cd_morfo_fkey ON main.registros(cd_morfo);

CREATE TABLE main.def_organ
(
    cd_organ smallserial PRIMARY KEY,
    organ text UNIQUE NOT NULL,
    organ_spa text UNIQUE
)
;

CREATE TABLE main.def_var_biometry
(
    cd_var_biometry smallserial PRIMARY KEY,
    var_biometry text UNIQUE,
    cd_unit smallint REFERENCES main.def_unit(cd_unit) NOT NULL,--this is the reference unit it allows to determine both the reference unit and the measurement type
    cd_organ smallint REFERENCES main.def_organ(cd_organ),
    comp_ind boolean,
    var_biometry_comment text,
    CHECK (comp_ind OR cd_organ IS NOT NULL)
);

CREATE TABLE main.biometry
(
    cd_biometry serial PRIMARY KEY,
    cd_reg int REFERENCES main.registros(cd_reg) NOT NULL,
    cd_var_biometry int REFERENCES main.def_var_biometry(cd_var_biometry) NOT NULL,
    cd_unit smallint REFERENCES main.def_unit(cd_unit), --poner FOREIGN KEY NOT NULL
    valor_biometry double precision NOT NULL,
    UNIQUE (cd_reg, cd_var_biometry)
);


CREATE TABLE main.catalog
(
    cd_catalog serial PRIMARY KEY,
    catalog_tag text NOT NULL,
    principal boolean default true NOT NULL,
    complete_ind boolean default false NOT NULL,
    cd_organ smallint REFERENCES main.def_organ(cd_organ),
    cd_reg int REFERENCES main.registros(cd_reg) NOT NULL,
    --cd_name_catalog REFERENCES main.def_catalog(cd_name_catalog),
    name_catalog text,
    CHECK (complete_ind OR cd_organ IS NOT NULL)
);

CREATE TABLE main.def_multimedia_type
(
    cd_type_multimedia smallserial PRIMARY KEY,
    multimedia_type_spa text,
    multimedia_type_en text
);

CREATE TABLE main.multimedia
(
    cd_multimedia serial PRIMARY KEY,
    cd_type_multimedia int REFERENCES main.def_multimedia_type(cd_type_multimedia),
    cd_event smallint REFERENCES main.event(cd_event),
    cd_reg int REFERENCES main.registros(cd_reg),
    name_file text,
    extension varchar(8),
    cds_creator int[],-- es realmente una referencia a las personas, pero como más de una persona puede estar aca, no se puede utilizar
    CHECK (cd_event IS NOT NULL OR cd_reg IS NOT NULL)
);
CREATE TABLE main.def_var_ind_charac
(
    cd_var_ind_char smallserial PRIMARY KEY,
    var_ind_char text UNIQUE,
    cd_unit smallint REFERENCES main.def_unit(cd_unit),--this is the reference unit it allows to determine both the reference unit and the measurement type
    type_var varchar(20),
    var_ind_char_spa text,
    var_ind_char_comment text,
    CHECK (type_var IN ('integer', 'double precision', 'categorial', 'free text')),
    CHECK (type_var IN ('categorial', 'free text') OR cd_unit IS NOT NULL)
);
CREATE TABLE main.def_ind_charac_categ
(
    cd_categ serial PRIMARY KEY,
    categ text NOT NULL,
    cd_var_ind_char smallint REFERENCES main.def_var_ind_charac(cd_var_ind_char),
    categ_spa text,
    order_categ int,
    comment_categ text,
    UNIQUE (cd_var_ind_char,categ)
    --it might be useful to work a unique constraint and/or index on (cd_var, order_categ) but since order_categ might be null, that's not trivial
);
/*
CREATE TABLE main.def_gender
(
    cd_gender smallserial PRIMARY KEY,
    gender_spa varchar(20) UNIQUE NOT NULL,
    gender_en varchar(20) UNIQUE NOT NULL
);
INSERT INTO main.def_sex(sex_spa,sex_en)
    VALUES ('Hembra','Female'),
        ('Macho', 'Male'),
        ('Indeterminado', 'Undetermined');

CREATE TABLE main.def_lifestage
(
    cd_lifestage smallserial PRIMARY KEY,
    lifestage_spa text UNIQUE NOT NULL,
    lifestage_en UNIQUE NOT NULL
);
CREATE TABLE main.def_behaviour
(
    cd_behaviour smallserial PRIMARY KEY,
    behaviour_spa text UNIQUE NOT NULL,
    behaviour_en text UNIQUE,
    cds_gp_biol smallint[]
);
*/
CREATE TABLE main.individual_characteristics
(
    cd_reg int REFERENCES main.registros(cd_reg),
    cd_var_ind_char smallint REFERENCES main.def_var_ind_charac,
    cd_categ integer REFERENCES main.def_ind_charac_categ,
    ind_char_int integer,
    ind_char_double integer,
    CHECK( ((cd_categ IS NOT NULL)::integer + (ind_char_int IS NOT NULL)::integer + (ind_char_int IS NOT NULL)::integer)=1)
    --UNIQUE (cd_reg,cd_var_ind_char,COALESCE(cd_categ::double,ind_char_int::double,ind_char_double))
    --might be useful to create more specific constraints depending on whether it is an integer, double or categorial variable.
);

CREATE TABLE main.individual_tag
(
    cd_tag serial PRIMARY KEY,
    cd_gp_biol char(4) REFERENCES main.def_gp_biol(cd_gp_biol),
    cd_pt_ref smallint REFERENCES main.punto_referencia(cd_pt_ref),
    tag text,
    UNIQUE (cd_gp_biol, cd_pt_ref, tag)
);
CREATE TABLE main.assign_individual_tag
(
    cd_reg int PRIMARY KEY REFERENCES main.registros(cd_reg),
    cd_tag int REFERENCES main.individual_tag(cd_tag)
);

CREATE TABLE main.def_var_habitat
(
    cd_var_habitat smallserial PRIMARY KEY,
    var_habitat text UNIQUE,
    cd_unit smallint REFERENCES main.def_unit(cd_unit),--this is the reference unit it allows to determine both the reference unit and the measurement type
    type_var varchar(20),
    var_habitat_spa text,
    var_habitat_comment text,
    CHECK (type_var IN ('integer', 'double precision', 'categorial', 'free text')),
    CHECK (type_var IN ('categorial', 'free text') OR cd_unit IS NOT NULL)
);

CREATE TABLE main.def_categ_habitat
(
    cd_categ serial PRIMARY KEY,
    categ text NOT NULL,
    cd_var_habitat smallint REFERENCES main.def_var_habitat(cd_var_habitat) NOT NULL,
    categ_spa text,
    order_categ int,
    UNIQUE (cd_var_habitat, categ)
    --it might be useful to work a unique constraint and/or index on (cd_var, order_categ) but since order_categ might be null, that's not trivial
);

CREATE TABLE main.habitat
(
    cd_habitat serial PRIMARY KEY,
    cd_pt_ref int REFERENCES main.punto_referencia(cd_pt_ref),
    cd_gp_event int REFERENCES main.gp_event(cd_gp_event),
    cd_event int REFERENCES main.event(cd_event),
    cd_reg int REFERENCES main.registros(cd_reg),
    cd_var_habitat smallint REFERENCES main.def_var_habitat(cd_var_habitat),
    cd_categ int REFERENCES main.def_categ_habitat(cd_categ),
    value_int int,
    value_double double precision,
    CHECK ( ( (cd_pt_ref IS NOT NULL)::integer + (cd_gp_event IS NOT NULL)::integer + (cd_event IS NOT NULL)::integer + (cd_reg IS NOT NULL)::integer )=1),
    CHECK (((cd_categ IS NOT NULL)::integer + (value_int IS NOT NULL)::integer + (value_double IS NOT NULL)::integer)=1)
);

CREATE TABLE main.def_var_event_extra
(
    cd_var_event_extra smallserial PRIMARY KEY,
    var_event_extra text NOT NULL UNIQUE,
    cd_unit smallint REFERENCES main.def_unit(cd_unit),
    type_var varchar(20),
    var_event_extra_spa text,
    var_event_extra_comment text,
    CHECK (type_var IN ('integer', 'double precision', 'categorial', 'free text', 'boolean')),
    CHECK (type_var IN ('categorial','free text', 'boolean') OR cd_unit IS NOT NULL)
);

CREATE TABLE main.def_categ_event_extra
(
    cd_categ_event_extra serial PRIMARY KEY,
    categ text NOT NULL,
    cd_var_event_extra smallint REFERENCES main.def_var_event_extra(cd_var_event_extra) NOT NULL,
    categ_spa text,
    order_categ int,
    UNIQUE (cd_var_event_extra,categ)
);

CREATE TABLE main.event_extra
(
    cd_event integer REFERENCES main.event(cd_event) NOT NULL,
    cd_var_event_extra smallint REFERENCES main.def_var_event_extra(cd_var_event_extra),
    cd_categ_event_extra integer REFERENCES main.def_categ_event_extra(cd_categ_event_extra),
    value_bool boolean,
    value_int integer,
    value_double double precision,
    value_text text,
    CHECK (cd_categ_event_extra IS NOT NULL OR value_bool IS NOT NULL OR value_int IS NOT NULL OR value_double IS NOT NULL OR value_text IS NOT NULL)
);


CREATE TABLE main.def_var_registros_extra
(
    cd_var_registros_extra smallserial PRIMARY KEY,
    var_registros_extra text NOT NULL UNIQUE,
    cd_unit smallint REFERENCES main.def_unit(cd_unit),
    type_var varchar(20),
    var_registros_extra_spa text,
    var_registros_extra_comment text,
    CHECK (type_var IN ('integer', 'double precision', 'categorial', 'free text', 'boolean')),
    CHECK (type_var IN ('categorial','free text', 'boolean') OR cd_unit IS NOT NULL)
);

CREATE TABLE main.def_categ_registros_extra
(
    cd_categ_registros_extra serial PRIMARY KEY,
    categ text NOT NULL,
    cd_var_registros_extra smallint REFERENCES main.def_var_registros_extra(cd_var_registros_extra),
    categ_spa text,
    order_categ int,
    UNIQUE (cd_var_registros_extra,categ)
);

CREATE TABLE main.registros_extra
(
    cd_reg integer REFERENCES main.registros(cd_reg) NOT NULL,
    cd_var_registros_extra smallint REFERENCES main.def_var_registros_extra(cd_var_registros_extra),
    cd_categ_registros_extra integer REFERENCES main.def_categ_registros_extra(cd_categ_registros_extra),
    value_bool boolean,
    value_int integer,
    value_double double precision,
    value_text text,
    CHECK (cd_categ_registros_extra IS NOT NULL OR value_bool IS NOT NULL OR value_int IS NOT NULL OR value_double IS NOT NULL OR value_text IS NOT NULL)
);

CREATE TABLE main.def_season
(
   cd_tempo char(2) PRIMARY KEY,
   date_range tsrange,
   season varchar(10) NOT NULL,
   temporada varchar(20) NOT NULL,
   EXCLUDE USING GIST (date_range WITH &&)
);

INSERT INTO main.def_season
VALUES
  ('T1', '[2021-06-01,2021-12-31 23:59:59]'::tsrange,'Rainy','Aguas altas'),
  ('T2', '[2022-01-01,2022-08-31 23:59:59]'::tsrange,'Dry','Aguas bajas')
;


/*Variables ambientales*/
/* vamos a crear tablas de variables ambientales para poder utilizarla de manera rapida: Anotar, la manera limpía de hacerlo sería

* o sea añadir un "grupo biologico" de variables ambientales, con sus propios eventos, gp de eventos
* o sea añadir unas variables ambientales en las tablas de habitat, con el problema que en el caso de peces, anh+temporada no es un nivel de organización que se pueda referenciar
*/

CREATE TABLE main.phy_chi_peces
(
  cd_pt_ref smallint REFERENCES main.punto_referencia(cd_pt_ref),
  cd_tempo char(2) REFERENCES main.def_season(cd_tempo),
  temp double precision,
  ph double precision,
  oxy_dis double precision,
  cond double precision,
  oil_film boolean,
  float_mat boolean,
  subst_compl_idx double precision,
  struc_compl_idx double precision,
  canopy_cover smallint,
  PRIMARY KEY (cd_pt_ref,cd_tempo)
);

CREATE TABLE main.def_phy_chi_type
(
    cd_phy_chi_type smallserial PRIMARY KEY,
    phy_chi_type varchar(10) UNIQUE NOT NULL,
    phy_chi_type_spa varchar(10) UNIQUE NOT NULL
);
INSERT INTO main.def_phy_chi_type(phy_chi_type, phy_chi_type_spa)
VALUES
  ('water','agua'),
  ('sediment','sedimento');

CREATE TABLE main.phy_chi_hidro_event
(
   cd_event_phy_chi smallserial PRIMARY KEY,
   cd_pt_ref smallint REFERENCES main.punto_referencia(cd_pt_ref),
   event_id_phy_chi text UNIQUE NOT NULL,
   cd_phy_chi_type smallint REFERENCES main.def_phy_chi_type(cd_phy_chi_type),
   date_time timestamp
);
SELECT AddGeometryColumn('main', 'phy_chi_hidro_event', 'the_geom', 3116, 'POINT', 2);
CREATE INDEX event_phy_chi_pt_geom_idx ON main.phy_chi_hidro_event USING GIST(the_geom);

CREATE TABLE main.phy_chi_hidro_aguas
(
   cd_event_phy_chi smallint PRIMARY KEY REFERENCES main.phy_chi_hidro_event(cd_event_phy_chi),
   basin text,
   mean_depth double precision,
   width_approx double precision,
   photic_depth double precision,
   river_clasif text,
   temp double precision,
   ph double precision,
   oxy_dis double precision,
   cond double precision,
   oxy_sat double precision,
   tot_sol_situ double precision,
   tot_org_c double precision,
   avail_p double precision,
   mg double precision,
   cal double precision,
   na_s double precision,
   tot_dis_sol double precision,
   tot_sol double precision,
   sus_sol double precision,
   sol_sol double precision,
   p04 double precision,
   n03 double precision,
   silicates double precision,
   oil_fat double precision,
   blue_met_act double precision,
   carbonates double precision,
   cal_hard double precision,
   tot_hard double precision,
   alk double precision,
   bicarb double precision
);


CREATE TABLE main.phy_chi_hidro_sedi
(
   cd_event_phy_chi smallint PRIMARY KEY REFERENCES main.phy_chi_hidro_sedi,
   sand_per double precision,
   clay_per double precision,
   silt_per double precision,
   text_clas text,
   org_c double precision,
   avail_p double precision,
   mg double precision,
   cal double precision,
   na_s double precision,
   boron double precision,
   fe double precision,
   tot_n double precision
);





/* Schema spatial */
CREATE SCHEMA spat;

CREATE TABLE spat.def_landcov
(
   cd_landcov smallserial PRIMARY KEY,
   landcov varchar(50) UNIQUE NOT NULL,
   landcov_spa varchar(50) UNIQUE NOT NULL
);

CREATE TABLE spat.landcov
(
  gid serial PRIMARY KEY,
  cd_landcov smallint REFERENCES spat.def_landcov(cd_landcov) ON DELETE SET NULL ON UPDATE CASCADE
);
SELECT AddGeometryColumn('spat', 'landcov', 'the_geom', 3116, 'POLYGON', 2);
CREATE INDEX spat_landcov_the_geom_idx ON spat.landcov USING GIST(the_geom);
CREATE INDEX spat_landcov_cd_landcov_fkey ON spat.landcov(cd_landcov);

