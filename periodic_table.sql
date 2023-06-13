--
-- PostgreSQL database dump
--

-- Dumped from database version 14.8 (Ubuntu 14.8-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.8 (Ubuntu 14.8-0ubuntu0.22.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE periodic_table;
--
-- Name: periodic_table; Type: DATABASE; Schema: -; Owner: kvothe_snow
--

CREATE DATABASE periodic_table WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.UTF-8';


ALTER DATABASE periodic_table OWNER TO kvothe_snow;

\connect periodic_table

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: trailling_zeros(integer); Type: FUNCTION; Schema: public; Owner: kvothe_snow
--

CREATE FUNCTION public.trailling_zeros(value integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
declare formatted_value text;
begin
formatted_value := TRIM(TRAILING '0' FROM TO_CHAR(value, '9999999999999999999.999999'));
insert into properties(atomic_mass) values(formatted_value); 
end;
$$;


ALTER FUNCTION public.trailling_zeros(value integer) OWNER TO kvothe_snow;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: elements; Type: TABLE; Schema: public; Owner: kvothe_snow
--

CREATE TABLE public.elements (
    atomic_number integer NOT NULL,
    symbol character varying(2) NOT NULL,
    name character varying(40) NOT NULL
);


ALTER TABLE public.elements OWNER TO kvothe_snow;

--
-- Name: properties; Type: TABLE; Schema: public; Owner: kvothe_snow
--

CREATE TABLE public.properties (
    atomic_number integer NOT NULL,
    atomic_mass numeric NOT NULL,
    melting_point_celsius numeric NOT NULL,
    boiling_point_celsius numeric NOT NULL,
    type_id integer NOT NULL
);


ALTER TABLE public.properties OWNER TO kvothe_snow;

--
-- Name: types; Type: TABLE; Schema: public; Owner: kvothe_snow
--

CREATE TABLE public.types (
    type_id integer NOT NULL,
    type character varying(40) NOT NULL
);


ALTER TABLE public.types OWNER TO kvothe_snow;

--
-- Data for Name: elements; Type: TABLE DATA; Schema: public; Owner: kvothe_snow
--

INSERT INTO public.elements VALUES (1, 'H', 'Hydrogen');
INSERT INTO public.elements VALUES (2, 'HE', 'Helium');
INSERT INTO public.elements VALUES (3, 'LI', 'Lithium');
INSERT INTO public.elements VALUES (4, 'BE', 'Beryllium');
INSERT INTO public.elements VALUES (5, 'B', 'Boron');
INSERT INTO public.elements VALUES (6, 'C', 'Carbon');
INSERT INTO public.elements VALUES (7, 'N', 'Nitrogen');
INSERT INTO public.elements VALUES (8, 'O', 'Oxygen');
INSERT INTO public.elements VALUES (9, 'F', 'Fluorine');
INSERT INTO public.elements VALUES (10, 'NE', 'Neon');


--
-- Data for Name: properties; Type: TABLE DATA; Schema: public; Owner: kvothe_snow
--

INSERT INTO public.properties VALUES (1, 1.008, -259.16, -252.87, 1);
INSERT INTO public.properties VALUES (2, 4.0026, -272.2, -268.93, 1);
INSERT INTO public.properties VALUES (3, 6.94, 180.54, 1342, 2);
INSERT INTO public.properties VALUES (4, 9.0122, 1287, 2469, 2);
INSERT INTO public.properties VALUES (5, 10.81, 2075, 4000, 3);
INSERT INTO public.properties VALUES (6, 12.011, 3550, 3749.85, 1);
INSERT INTO public.properties VALUES (7, 14.007, -210.1, -195.79, 1);
INSERT INTO public.properties VALUES (8, 15.999, -218, -182.9, 1);
INSERT INTO public.properties VALUES (9, 18.998, -220, -188.1, 1);
INSERT INTO public.properties VALUES (10, 20.18, -248.6, -246.1, 3);


--
-- Data for Name: types; Type: TABLE DATA; Schema: public; Owner: kvothe_snow
--

INSERT INTO public.types VALUES (1, 'metal');
INSERT INTO public.types VALUES (2, 'nonmetal');
INSERT INTO public.types VALUES (3, 'metalloid');


--
-- Name: elements elements_atomic_number_key; Type: CONSTRAINT; Schema: public; Owner: kvothe_snow
--

ALTER TABLE ONLY public.elements
    ADD CONSTRAINT elements_atomic_number_key UNIQUE (atomic_number);


--
-- Name: elements elements_name_key; Type: CONSTRAINT; Schema: public; Owner: kvothe_snow
--

ALTER TABLE ONLY public.elements
    ADD CONSTRAINT elements_name_key UNIQUE (name);


--
-- Name: elements elements_pkey; Type: CONSTRAINT; Schema: public; Owner: kvothe_snow
--

ALTER TABLE ONLY public.elements
    ADD CONSTRAINT elements_pkey PRIMARY KEY (atomic_number);


--
-- Name: elements elements_symbol_key; Type: CONSTRAINT; Schema: public; Owner: kvothe_snow
--

ALTER TABLE ONLY public.elements
    ADD CONSTRAINT elements_symbol_key UNIQUE (symbol);


--
-- Name: types types_pkey; Type: CONSTRAINT; Schema: public; Owner: kvothe_snow
--

ALTER TABLE ONLY public.types
    ADD CONSTRAINT types_pkey PRIMARY KEY (type_id);


--
-- PostgreSQL database dump complete
--

