--
-- PostgreSQL database dump
--

-- Dumped from database version 13.11 (Debian 13.11-1.pgdg120+1)
-- Dumped by pg_dump version 13.11 (Debian 13.11-1.pgdg120+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer,
    title character varying(80) UNIQUE,
    price integer
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_1; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders_1 (
    CONSTRAINT orders_1_price_check CHECK ((price > 499))
)
INHERITS (public.orders);


ALTER TABLE public.orders_1 OWNER TO postgres;

--
-- Name: orders_2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders_2 (
    CONSTRAINT orders_2_price_check CHECK ((price <= 499))
)
INHERITS (public.orders);


ALTER TABLE public.orders_2 OWNER TO postgres;

--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, title, price) FROM stdin;
\.


--
-- Data for Name: orders_1; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders_1 (id, title, price) FROM stdin;
2	My little database	500
6	WAL never lies	900
8	Dbiezdmin	501
\.


--
-- Data for Name: orders_2; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders_2 (id, title, price) FROM stdin;
1	War and peace	100
3	Adventure psql time	300
4	Server gravity falls	300
5	Log gossips	123
7	Me and my bash-pet	499
\.


--
-- Name: orders order_gt_499; Type: RULE; Schema: public; Owner: postgres
--

CREATE RULE order_gt_499 AS
    ON INSERT TO public.orders
   WHERE (new.price > 499) DO INSTEAD  INSERT INTO public.orders_1 (id, title, price)
  VALUES (new.id, new.title, new.price);


--
-- Name: orders order_le_499; Type: RULE; Schema: public; Owner: postgres
--

CREATE RULE order_le_499 AS
    ON INSERT TO public.orders
   WHERE (new.price <= 499) DO INSTEAD  INSERT INTO public.orders_2 (id, title, price)
  VALUES (new.id, new.title, new.price);


--
-- PostgreSQL database dump complete
--

