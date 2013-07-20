--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: energy2ds; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE energy2ds (
    id integer NOT NULL,
    json_rep text,
    revision character varying(255),
    from_import boolean
);


--
-- Name: energy2ds_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE energy2ds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: energy2ds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE energy2ds_id_seq OWNED BY energy2ds.id;


--
-- Name: groups; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE groups (
    id integer NOT NULL,
    revision text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(255),
    path character varying(255),
    category character varying(255)
);


--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE groups_id_seq OWNED BY groups.id;


--
-- Name: interactive_models; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE interactive_models (
    id integer NOT NULL,
    interactive_id integer,
    model_id integer,
    model_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: interactive_models_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE interactive_models_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: interactive_models_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE interactive_models_id_seq OWNED BY interactive_models.id;


--
-- Name: interactive_searches; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE interactive_searches (
    id integer NOT NULL,
    title character varying(255),
    subtitle character varying(255),
    about character varying(255),
    "publicationStatus" character varying(255),
    group_name character varying(255),
    group_category character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: interactive_searches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE interactive_searches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: interactive_searches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE interactive_searches_id_seq OWNED BY interactive_searches.id;


--
-- Name: interactives; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE interactives (
    id integer NOT NULL,
    from_import boolean DEFAULT false,
    path character varying(255),
    group_key character varying(255),
    json_rep hstore,
    group_id integer,
    revision character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: interactives_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE interactives_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: interactives_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE interactives_id_seq OWNED BY interactives.id;


--
-- Name: md2ds; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE md2ds (
    id integer NOT NULL,
    json_rep text,
    revision character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    from_import boolean DEFAULT false
);


--
-- Name: md2ds_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE md2ds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: md2ds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE md2ds_id_seq OWNED BY md2ds.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: sensors; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sensors (
    id integer NOT NULL,
    json_rep text,
    revision character varying(255),
    from_import boolean
);


--
-- Name: sensors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sensors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sensors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sensors_id_seq OWNED BY sensors.id;


--
-- Name: signal_generators; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE signal_generators (
    id integer NOT NULL,
    json_rep text,
    revision character varying(255),
    from_import boolean
);


--
-- Name: signal_generators_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE signal_generators_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: signal_generators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE signal_generators_id_seq OWNED BY signal_generators.id;


--
-- Name: solar_systems; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE solar_systems (
    id integer NOT NULL,
    json_rep text,
    revision character varying(255),
    from_import boolean
);


--
-- Name: solar_systems_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE solar_systems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: solar_systems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE solar_systems_id_seq OWNED BY solar_systems.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY energy2ds ALTER COLUMN id SET DEFAULT nextval('energy2ds_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY groups ALTER COLUMN id SET DEFAULT nextval('groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY interactive_models ALTER COLUMN id SET DEFAULT nextval('interactive_models_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY interactive_searches ALTER COLUMN id SET DEFAULT nextval('interactive_searches_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY interactives ALTER COLUMN id SET DEFAULT nextval('interactives_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY md2ds ALTER COLUMN id SET DEFAULT nextval('md2ds_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sensors ALTER COLUMN id SET DEFAULT nextval('sensors_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY signal_generators ALTER COLUMN id SET DEFAULT nextval('signal_generators_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY solar_systems ALTER COLUMN id SET DEFAULT nextval('solar_systems_id_seq'::regclass);


--
-- Name: energy2ds_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY energy2ds
    ADD CONSTRAINT energy2ds_pkey PRIMARY KEY (id);


--
-- Name: groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: interactive_models_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY interactive_models
    ADD CONSTRAINT interactive_models_pkey PRIMARY KEY (id);


--
-- Name: interactive_searches_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY interactive_searches
    ADD CONSTRAINT interactive_searches_pkey PRIMARY KEY (id);


--
-- Name: interactives_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY interactives
    ADD CONSTRAINT interactives_pkey PRIMARY KEY (id);


--
-- Name: md2ds_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY md2ds
    ADD CONSTRAINT md2ds_pkey PRIMARY KEY (id);


--
-- Name: sensors_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sensors
    ADD CONSTRAINT sensors_pkey PRIMARY KEY (id);


--
-- Name: signal_generators_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY signal_generators
    ADD CONSTRAINT signal_generators_pkey PRIMARY KEY (id);


--
-- Name: solar_systems_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY solar_systems
    ADD CONSTRAINT solar_systems_pkey PRIMARY KEY (id);


--
-- Name: index_interactive_models_on_interactive_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_interactive_models_on_interactive_id ON interactive_models USING btree (interactive_id);


--
-- Name: index_interactive_models_on_model_id_and_model_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_interactive_models_on_model_id_and_model_type ON interactive_models USING btree (model_id, model_type);


--
-- Name: index_interactives_on_group_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_interactives_on_group_id ON interactives USING btree (group_id);


--
-- Name: interactives_json_rep; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX interactives_json_rep ON interactives USING gin (json_rep);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20130515210606');

INSERT INTO schema_migrations (version) VALUES ('20130516005838');

INSERT INTO schema_migrations (version) VALUES ('20130516015525');

INSERT INTO schema_migrations (version) VALUES ('20130516023144');

INSERT INTO schema_migrations (version) VALUES ('20130522175729');

INSERT INTO schema_migrations (version) VALUES ('20130522184940');

INSERT INTO schema_migrations (version) VALUES ('20130709155201');

INSERT INTO schema_migrations (version) VALUES ('20130709172728');

INSERT INTO schema_migrations (version) VALUES ('20130716200212');

INSERT INTO schema_migrations (version) VALUES ('20130716200410');

INSERT INTO schema_migrations (version) VALUES ('20130716200724');

INSERT INTO schema_migrations (version) VALUES ('20130716200800');

INSERT INTO schema_migrations (version) VALUES ('20130718160757');

INSERT INTO schema_migrations (version) VALUES ('20130718162813');

INSERT INTO schema_migrations (version) VALUES ('20130718162925');

INSERT INTO schema_migrations (version) VALUES ('20130718164201');

INSERT INTO schema_migrations (version) VALUES ('20130719182715');

INSERT INTO schema_migrations (version) VALUES ('20130719185700');
