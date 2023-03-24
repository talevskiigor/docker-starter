SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Create database
--

\c webmgrdb
SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 8 (class 2615 OID 26258)
-- Name: webmgr; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA octobercms;
CREATE SCHEMA webmgr;

-- CREATE USER postgres SUPERUSER;

-- ALTER SCHEMA webmgr OWNER TO postgres;

SET search_path = webmgr, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
