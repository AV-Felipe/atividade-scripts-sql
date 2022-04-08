--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2 (Ubuntu 14.2-1.pgdg20.04+1)
-- Dumped by pg_dump version 14.2 (Ubuntu 14.2-1.pgdg20.04+1)

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
-- Name: br_states; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.br_states AS ENUM (
    'AC',
    'AL',
    'AP',
    'AM',
    'BA',
    'CE',
    'ES',
    'GO',
    'MA',
    'MT',
    'MS',
    'MG',
    'PA',
    'PB',
    'PR',
    'PE',
    'PI',
    'RJ',
    'RN',
    'RS',
    'RO',
    'RR',
    'SC',
    'SP',
    'SE',
    'TO',
    'DF'
);


ALTER TYPE public.br_states OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts (
    id integer NOT NULL,
    account_number character varying(14) NOT NULL,
    branch_number character varying(4) NOT NULL,
    investor_id integer NOT NULL,
    stock_broker_id integer NOT NULL,
    created_at date DEFAULT CURRENT_DATE NOT NULL,
    deleted_at date,
    updated_at date
);


ALTER TABLE public.accounts OWNER TO postgres;

--
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_id_seq OWNER TO postgres;

--
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_id_seq OWNED BY public.accounts.id;


--
-- Name: addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.addresses (
    id integer NOT NULL,
    investor_id integer NOT NULL,
    public_place character varying(150) NOT NULL,
    number integer NOT NULL,
    zip_code character varying(8) NOT NULL,
    complement character varying(150),
    created_at date DEFAULT CURRENT_DATE NOT NULL,
    deleted_at date,
    updated_at date,
    city_id integer NOT NULL
);


ALTER TABLE public.addresses OWNER TO postgres;

--
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.addresses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.addresses_id_seq OWNER TO postgres;

--
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.addresses_id_seq OWNED BY public.addresses.id;


--
-- Name: cities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cities (
    id integer NOT NULL,
    name character varying(40) NOT NULL,
    ibge_code character(7) NOT NULL,
    state public.br_states NOT NULL,
    created_at date DEFAULT CURRENT_DATE NOT NULL,
    created_by integer DEFAULT 1 NOT NULL,
    updated_at date,
    ubpdated_by integer,
    deleted_at date,
    deleted_by integer
);


ALTER TABLE public.cities OWNER TO postgres;

--
-- Name: cities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.cities ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: clearing; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clearing (
    id integer NOT NULL,
    clearing_expenses money NOT NULL,
    invoice_id integer NOT NULL,
    register_expenses money NOT NULL
);


ALTER TABLE public.clearing OWNER TO postgres;

--
-- Name: clearing_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clearing_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clearing_id_seq OWNER TO postgres;

--
-- Name: clearing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clearing_id_seq OWNED BY public.clearing.id;


--
-- Name: investors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.investors (
    id integer NOT NULL,
    user_id integer NOT NULL,
    full_name character varying(120) NOT NULL,
    document character varying(14) NOT NULL,
    cpf character varying(11) NOT NULL,
    birth_date date NOT NULL,
    mother_full_name character varying(120) NOT NULL,
    created_at date DEFAULT CURRENT_DATE NOT NULL,
    deleted_at date,
    updated_at date
);


ALTER TABLE public.investors OWNER TO postgres;

--
-- Name: investors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.investors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.investors_id_seq OWNER TO postgres;

--
-- Name: investors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.investors_id_seq OWNED BY public.investors.id;


--
-- Name: invoices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoices (
    id integer NOT NULL,
    investor_id integer NOT NULL,
    stock_broker_id integer NOT NULL,
    invoice_number integer NOT NULL,
    trading_floor_date date NOT NULL,
    created_at date DEFAULT CURRENT_DATE NOT NULL,
    deleted_at date,
    updated_at date
);


ALTER TABLE public.invoices OWNER TO postgres;

--
-- Name: invoices_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.invoices_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.invoices_id_seq OWNER TO postgres;

--
-- Name: invoices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.invoices_id_seq OWNED BY public.invoices.id;


--
-- Name: operational_costs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.operational_costs (
    id integer NOT NULL,
    operational_tax money NOT NULL,
    custody_tax money NOT NULL,
    municipal_tax money NOT NULL,
    execution money NOT NULL,
    tds money NOT NULL,
    others money NOT NULL,
    invoice_id integer NOT NULL
);


ALTER TABLE public.operational_costs OWNER TO postgres;

--
-- Name: operational_costs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.operational_costs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.operational_costs_id_seq OWNER TO postgres;

--
-- Name: operational_costs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.operational_costs_id_seq OWNED BY public.operational_costs.id;


--
-- Name: operations_real_estate_investment_funds; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.operations_real_estate_investment_funds (
    id integer NOT NULL,
    invoice_id integer NOT NULL,
    real_estate_investment_fund_id integer NOT NULL,
    quantity integer NOT NULL,
    unit_value money NOT NULL,
    operation character varying(1) NOT NULL
);


ALTER TABLE public.operations_real_estate_investment_funds OWNER TO postgres;

--
-- Name: operations_real_estate_investment_funds_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.operations_real_estate_investment_funds_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.operations_real_estate_investment_funds_id_seq OWNER TO postgres;

--
-- Name: operations_real_estate_investment_funds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.operations_real_estate_investment_funds_id_seq OWNED BY public.operations_real_estate_investment_funds.id;


--
-- Name: operations_stocks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.operations_stocks (
    id integer NOT NULL,
    invoice_id integer NOT NULL,
    stock_id integer NOT NULL,
    quantity integer NOT NULL,
    unit_value money NOT NULL,
    operation character varying(1) NOT NULL
);


ALTER TABLE public.operations_stocks OWNER TO postgres;

--
-- Name: operations_stocks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.operations_stocks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.operations_stocks_id_seq OWNER TO postgres;

--
-- Name: operations_stocks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.operations_stocks_id_seq OWNED BY public.operations_stocks.id;


--
-- Name: phones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.phones (
    id integer NOT NULL,
    city_code character varying(2) NOT NULL,
    phone_number character varying(9) NOT NULL,
    investor_id integer NOT NULL,
    created_at date DEFAULT CURRENT_DATE NOT NULL,
    deleted_at date,
    updated_at date
);


ALTER TABLE public.phones OWNER TO postgres;

--
-- Name: phones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.phones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.phones_id_seq OWNER TO postgres;

--
-- Name: phones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.phones_id_seq OWNED BY public.phones.id;


--
-- Name: real_estate_investment_funds; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.real_estate_investment_funds (
    id integer NOT NULL,
    ticker_symbol character varying(7) NOT NULL,
    real_estate_investment_funds_name character varying(150) NOT NULL,
    real_estate_investment_funds_cnpj character varying(14) NOT NULL,
    "real_estate_investment_funds-administrator_id" integer NOT NULL,
    created_by integer DEFAULT 1 NOT NULL,
    created_at date DEFAULT CURRENT_DATE NOT NULL,
    updated_by integer,
    updated_at date,
    deleted_by integer,
    deleted_at date
);


ALTER TABLE public.real_estate_investment_funds OWNER TO postgres;

--
-- Name: real_estate_investment_funds_administrators; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.real_estate_investment_funds_administrators (
    id integer NOT NULL,
    company_name character varying(150) NOT NULL,
    cnpj character varying(14) NOT NULL,
    created_by integer DEFAULT 1 NOT NULL,
    created_at date DEFAULT CURRENT_DATE NOT NULL,
    updated_by integer,
    updated_at date,
    deleted_by integer,
    deleted_at date
);


ALTER TABLE public.real_estate_investment_funds_administrators OWNER TO postgres;

--
-- Name: real_estate_investment_funds_administrators_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.real_estate_investment_funds_administrators_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.real_estate_investment_funds_administrators_id_seq OWNER TO postgres;

--
-- Name: real_estate_investment_funds_administrators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.real_estate_investment_funds_administrators_id_seq OWNED BY public.real_estate_investment_funds_administrators.id;


--
-- Name: real_estate_investment_funds_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.real_estate_investment_funds_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.real_estate_investment_funds_id_seq OWNER TO postgres;

--
-- Name: real_estate_investment_funds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.real_estate_investment_funds_id_seq OWNED BY public.real_estate_investment_funds.id;


--
-- Name: real_estate_investment_funds_opening_balance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.real_estate_investment_funds_opening_balance (
    id integer NOT NULL,
    investor_id integer NOT NULL,
    real_estate_investment_fund_id integer NOT NULL,
    quantity integer NOT NULL,
    unit_value money NOT NULL,
    created_at date DEFAULT CURRENT_DATE NOT NULL,
    updated_at date,
    deleted_at date
);


ALTER TABLE public.real_estate_investment_funds_opening_balance OWNER TO postgres;

--
-- Name: real_estate_investment_funds_opening_balance_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.real_estate_investment_funds_opening_balance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.real_estate_investment_funds_opening_balance_id_seq OWNER TO postgres;

--
-- Name: real_estate_investment_funds_opening_balance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.real_estate_investment_funds_opening_balance_id_seq OWNED BY public.real_estate_investment_funds_opening_balance.id;


--
-- Name: stock_brokers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stock_brokers (
    id integer NOT NULL,
    name character varying(120) NOT NULL,
    cnpj character varying(14) NOT NULL,
    code_number character varying(3),
    created_by integer DEFAULT 1 NOT NULL,
    created_at date DEFAULT CURRENT_DATE NOT NULL,
    deleted_by integer,
    deleted_at date,
    updated_by integer,
    updated_at date
);


ALTER TABLE public.stock_brokers OWNER TO postgres;

--
-- Name: stock_brokers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stock_brokers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stock_brokers_id_seq OWNER TO postgres;

--
-- Name: stock_brokers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stock_brokers_id_seq OWNED BY public.stock_brokers.id;


--
-- Name: stock_market; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stock_market (
    id integer NOT NULL,
    option_tax money NOT NULL,
    ana_tax money NOT NULL,
    fees money NOT NULL,
    invoice_id integer NOT NULL
);


ALTER TABLE public.stock_market OWNER TO postgres;

--
-- Name: stock_market_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stock_market_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stock_market_id_seq OWNER TO postgres;

--
-- Name: stock_market_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stock_market_id_seq OWNED BY public.stock_market.id;


--
-- Name: stocks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stocks (
    id integer NOT NULL,
    ticker_symbol character varying(7) NOT NULL,
    company_name character varying(150) NOT NULL,
    cnpj character varying(14) NOT NULL,
    created_by integer DEFAULT 1 NOT NULL,
    created_at date DEFAULT CURRENT_DATE NOT NULL,
    updated_by integer,
    updated_at date,
    deleted_by integer,
    deleted_at date
);


ALTER TABLE public.stocks OWNER TO postgres;

--
-- Name: stocks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stocks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stocks_id_seq OWNER TO postgres;

--
-- Name: stocks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stocks_id_seq OWNED BY public.stocks.id;


--
-- Name: stocks_opening_balance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stocks_opening_balance (
    id integer NOT NULL,
    investor_id integer NOT NULL,
    stock_id integer NOT NULL,
    quantity integer NOT NULL,
    unit_value money NOT NULL,
    created_at date DEFAULT CURRENT_DATE NOT NULL,
    updated_at date,
    deleted_at date
);


ALTER TABLE public.stocks_opening_balance OWNER TO postgres;

--
-- Name: stocks_opening_balance_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stocks_opening_balance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stocks_opening_balance_id_seq OWNER TO postgres;

--
-- Name: stocks_opening_balance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stocks_opening_balance_id_seq OWNED BY public.stocks_opening_balance.id;


--
-- Name: tds_opening_balance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tds_opening_balance (
    id integer NOT NULL,
    investor_id integer NOT NULL,
    value money NOT NULL,
    created_at date DEFAULT CURRENT_DATE NOT NULL,
    updated_at date,
    deleted_at date
);


ALTER TABLE public.tds_opening_balance OWNER TO postgres;

--
-- Name: tds_opening_balance_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tds_opening_balance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tds_opening_balance_id_seq OWNER TO postgres;

--
-- Name: tds_opening_balance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tds_opening_balance_id_seq OWNED BY public.tds_opening_balance.id;


--
-- Name: tds_opening_balance_value_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tds_opening_balance_value_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tds_opening_balance_value_seq OWNER TO postgres;

--
-- Name: tds_opening_balance_value_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tds_opening_balance_value_seq OWNED BY public.tds_opening_balance.value;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(150) NOT NULL,
    password character varying(60) NOT NULL,
    created_at date DEFAULT CURRENT_DATE NOT NULL,
    updated_at date,
    deleted_at date,
    user_type_id integer NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: users_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_type (
    id integer NOT NULL,
    type character varying(10) NOT NULL,
    created_at date DEFAULT CURRENT_DATE NOT NULL,
    created_by integer NOT NULL,
    updated_at date,
    updated_by integer,
    deleted_at date,
    deleted_by integer
);


ALTER TABLE public.users_type OWNER TO postgres;

--
-- Name: users_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_type_id_seq OWNER TO postgres;

--
-- Name: users_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_type_id_seq OWNED BY public.users_type.id;


--
-- Name: accounts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts ALTER COLUMN id SET DEFAULT nextval('public.accounts_id_seq'::regclass);


--
-- Name: addresses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses ALTER COLUMN id SET DEFAULT nextval('public.addresses_id_seq'::regclass);


--
-- Name: clearing id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clearing ALTER COLUMN id SET DEFAULT nextval('public.clearing_id_seq'::regclass);


--
-- Name: investors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.investors ALTER COLUMN id SET DEFAULT nextval('public.investors_id_seq'::regclass);


--
-- Name: invoices id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices ALTER COLUMN id SET DEFAULT nextval('public.invoices_id_seq'::regclass);


--
-- Name: operational_costs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operational_costs ALTER COLUMN id SET DEFAULT nextval('public.operational_costs_id_seq'::regclass);


--
-- Name: operations_real_estate_investment_funds id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operations_real_estate_investment_funds ALTER COLUMN id SET DEFAULT nextval('public.operations_real_estate_investment_funds_id_seq'::regclass);


--
-- Name: operations_stocks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operations_stocks ALTER COLUMN id SET DEFAULT nextval('public.operations_stocks_id_seq'::regclass);


--
-- Name: phones id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phones ALTER COLUMN id SET DEFAULT nextval('public.phones_id_seq'::regclass);


--
-- Name: real_estate_investment_funds id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.real_estate_investment_funds ALTER COLUMN id SET DEFAULT nextval('public.real_estate_investment_funds_id_seq'::regclass);


--
-- Name: real_estate_investment_funds_administrators id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.real_estate_investment_funds_administrators ALTER COLUMN id SET DEFAULT nextval('public.real_estate_investment_funds_administrators_id_seq'::regclass);


--
-- Name: real_estate_investment_funds_opening_balance id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.real_estate_investment_funds_opening_balance ALTER COLUMN id SET DEFAULT nextval('public.real_estate_investment_funds_opening_balance_id_seq'::regclass);


--
-- Name: stock_brokers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_brokers ALTER COLUMN id SET DEFAULT nextval('public.stock_brokers_id_seq'::regclass);


--
-- Name: stock_market id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_market ALTER COLUMN id SET DEFAULT nextval('public.stock_market_id_seq'::regclass);


--
-- Name: stocks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stocks ALTER COLUMN id SET DEFAULT nextval('public.stocks_id_seq'::regclass);


--
-- Name: stocks_opening_balance id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stocks_opening_balance ALTER COLUMN id SET DEFAULT nextval('public.stocks_opening_balance_id_seq'::regclass);


--
-- Name: tds_opening_balance id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tds_opening_balance ALTER COLUMN id SET DEFAULT nextval('public.tds_opening_balance_id_seq'::regclass);


--
-- Name: tds_opening_balance value; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tds_opening_balance ALTER COLUMN value SET DEFAULT nextval('public.tds_opening_balance_value_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: users_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_type ALTER COLUMN id SET DEFAULT nextval('public.users_type_id_seq'::regclass);


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts (id, account_number, branch_number, investor_id, stock_broker_id, created_at, deleted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.addresses (id, investor_id, public_place, number, zip_code, complement, created_at, deleted_at, updated_at, city_id) FROM stdin;
1	1	R. Rui Barbosa	285	69900120	\N	2022-03-28	\N	\N	68
2	2	R. Um	85	13090000	\N	2022-03-28	\N	\N	3899
\.


--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cities (id, name, ibge_code, state, created_at, created_by, updated_at, ubpdated_by, deleted_at, deleted_by) FROM stdin;
1	'Alta Floresta D''Oeste'	1100015	RO	2022-03-28	1	\N	\N	\N	\N
2	Alto Alegre dos Parecis	1100379	RO	2022-03-28	1	\N	\N	\N	\N
3	Alto Paraíso	1100403	RO	2022-03-28	1	\N	\N	\N	\N
4	'Alvorada D''Oeste'	1100346	RO	2022-03-28	1	\N	\N	\N	\N
5	Ariquemes	1100023	RO	2022-03-28	1	\N	\N	\N	\N
6	Buritis	1100452	RO	2022-03-28	1	\N	\N	\N	\N
7	Cabixi	1100031	RO	2022-03-28	1	\N	\N	\N	\N
8	Cacaulândia	1100601	RO	2022-03-28	1	\N	\N	\N	\N
9	Cacoal	1100049	RO	2022-03-28	1	\N	\N	\N	\N
10	Campo Novo de Rondônia	1100700	RO	2022-03-28	1	\N	\N	\N	\N
11	Candeias do Jamari	1100809	RO	2022-03-28	1	\N	\N	\N	\N
12	Castanheiras	1100908	RO	2022-03-28	1	\N	\N	\N	\N
13	Cerejeiras	1100056	RO	2022-03-28	1	\N	\N	\N	\N
14	Chupinguaia	1100924	RO	2022-03-28	1	\N	\N	\N	\N
15	Colorado do Oeste	1100064	RO	2022-03-28	1	\N	\N	\N	\N
16	Corumbiara	1100072	RO	2022-03-28	1	\N	\N	\N	\N
17	Costa Marques	1100080	RO	2022-03-28	1	\N	\N	\N	\N
18	Cujubim	1100940	RO	2022-03-28	1	\N	\N	\N	\N
19	'Espigão D''Oeste'	1100098	RO	2022-03-28	1	\N	\N	\N	\N
20	Governador Jorge Teixeira	1101005	RO	2022-03-28	1	\N	\N	\N	\N
21	Guajará-Mirim	1100106	RO	2022-03-28	1	\N	\N	\N	\N
22	Itapuã do Oeste	1101104	RO	2022-03-28	1	\N	\N	\N	\N
23	Jaru	1100114	RO	2022-03-28	1	\N	\N	\N	\N
24	Ji-Paraná	1100122	RO	2022-03-28	1	\N	\N	\N	\N
25	'Machadinho D''Oeste'	1100130	RO	2022-03-28	1	\N	\N	\N	\N
26	Ministro Andreazza	1101203	RO	2022-03-28	1	\N	\N	\N	\N
27	Mirante da Serra	1101302	RO	2022-03-28	1	\N	\N	\N	\N
28	Monte Negro	1101401	RO	2022-03-28	1	\N	\N	\N	\N
29	'Nova Brasilândia D''Oeste'	1100148	RO	2022-03-28	1	\N	\N	\N	\N
30	Nova Mamoré	1100338	RO	2022-03-28	1	\N	\N	\N	\N
31	Nova União	1101435	RO	2022-03-28	1	\N	\N	\N	\N
32	Novo Horizonte do Oeste	1100502	RO	2022-03-28	1	\N	\N	\N	\N
33	Ouro Preto do Oeste	1100155	RO	2022-03-28	1	\N	\N	\N	\N
34	Parecis	1101450	RO	2022-03-28	1	\N	\N	\N	\N
35	Pimenta Bueno	1100189	RO	2022-03-28	1	\N	\N	\N	\N
36	Pimenteiras do Oeste	1101468	RO	2022-03-28	1	\N	\N	\N	\N
37	Porto Velho	1100205	RO	2022-03-28	1	\N	\N	\N	\N
38	Presidente Médici	1100254	RO	2022-03-28	1	\N	\N	\N	\N
39	Primavera de Rondônia	1101476	RO	2022-03-28	1	\N	\N	\N	\N
40	Rio Crespo	1100262	RO	2022-03-28	1	\N	\N	\N	\N
41	Rolim de Moura	1100288	RO	2022-03-28	1	\N	\N	\N	\N
42	'Santa Luzia D''Oeste'	1100296	RO	2022-03-28	1	\N	\N	\N	\N
43	'São Felipe D''Oeste'	1101484	RO	2022-03-28	1	\N	\N	\N	\N
44	São Francisco do Guaporé	1101492	RO	2022-03-28	1	\N	\N	\N	\N
45	São Miguel do Guaporé	1100320	RO	2022-03-28	1	\N	\N	\N	\N
46	Seringueiras	1101500	RO	2022-03-28	1	\N	\N	\N	\N
47	Teixeirópolis	1101559	RO	2022-03-28	1	\N	\N	\N	\N
48	Theobroma	1101609	RO	2022-03-28	1	\N	\N	\N	\N
49	Urupá	1101708	RO	2022-03-28	1	\N	\N	\N	\N
50	Vale do Anari	1101757	RO	2022-03-28	1	\N	\N	\N	\N
51	Vale do Paraíso	1101807	RO	2022-03-28	1	\N	\N	\N	\N
52	Vilhena	1100304	RO	2022-03-28	1	\N	\N	\N	\N
53	Acrelândia	1200013	AC	2022-03-28	1	\N	\N	\N	\N
54	Assis Brasil	1200054	AC	2022-03-28	1	\N	\N	\N	\N
55	Brasiléia	1200104	AC	2022-03-28	1	\N	\N	\N	\N
56	Bujari	1200138	AC	2022-03-28	1	\N	\N	\N	\N
57	Capixaba	1200179	AC	2022-03-28	1	\N	\N	\N	\N
58	Cruzeiro do Sul	1200203	AC	2022-03-28	1	\N	\N	\N	\N
59	Epitaciolândia	1200252	AC	2022-03-28	1	\N	\N	\N	\N
60	Feijó	1200302	AC	2022-03-28	1	\N	\N	\N	\N
61	Jordão	1200328	AC	2022-03-28	1	\N	\N	\N	\N
62	Mâncio Lima	1200336	AC	2022-03-28	1	\N	\N	\N	\N
63	Manoel Urbano	1200344	AC	2022-03-28	1	\N	\N	\N	\N
64	Marechal Thaumaturgo	1200351	AC	2022-03-28	1	\N	\N	\N	\N
65	Plácido de Castro	1200385	AC	2022-03-28	1	\N	\N	\N	\N
66	Porto Acre	1200807	AC	2022-03-28	1	\N	\N	\N	\N
67	Porto Walter	1200393	AC	2022-03-28	1	\N	\N	\N	\N
68	Rio Branco	1200401	AC	2022-03-28	1	\N	\N	\N	\N
69	Rodrigues Alves	1200427	AC	2022-03-28	1	\N	\N	\N	\N
70	Santa Rosa do Purus	1200435	AC	2022-03-28	1	\N	\N	\N	\N
71	Sena Madureira	1200500	AC	2022-03-28	1	\N	\N	\N	\N
72	Senador Guiomard	1200450	AC	2022-03-28	1	\N	\N	\N	\N
73	Tarauacá	1200609	AC	2022-03-28	1	\N	\N	\N	\N
74	Xapuri	1200708	AC	2022-03-28	1	\N	\N	\N	\N
75	Alvarães	1300029	AM	2022-03-28	1	\N	\N	\N	\N
76	Amaturá	1300060	AM	2022-03-28	1	\N	\N	\N	\N
77	Anamã	1300086	AM	2022-03-28	1	\N	\N	\N	\N
78	Anori	1300102	AM	2022-03-28	1	\N	\N	\N	\N
79	Apuí	1300144	AM	2022-03-28	1	\N	\N	\N	\N
80	Atalaia do Norte	1300201	AM	2022-03-28	1	\N	\N	\N	\N
81	Autazes	1300300	AM	2022-03-28	1	\N	\N	\N	\N
82	Barcelos	1300409	AM	2022-03-28	1	\N	\N	\N	\N
83	Barreirinha	1300508	AM	2022-03-28	1	\N	\N	\N	\N
84	Benjamin Constant	1300607	AM	2022-03-28	1	\N	\N	\N	\N
85	Beruri	1300631	AM	2022-03-28	1	\N	\N	\N	\N
86	Boa Vista do Ramos	1300680	AM	2022-03-28	1	\N	\N	\N	\N
87	Boca do Acre	1300706	AM	2022-03-28	1	\N	\N	\N	\N
88	Borba	1300805	AM	2022-03-28	1	\N	\N	\N	\N
89	Caapiranga	1300839	AM	2022-03-28	1	\N	\N	\N	\N
90	Canutama	1300904	AM	2022-03-28	1	\N	\N	\N	\N
91	Carauari	1301001	AM	2022-03-28	1	\N	\N	\N	\N
92	Careiro	1301100	AM	2022-03-28	1	\N	\N	\N	\N
93	Careiro da Várzea	1301159	AM	2022-03-28	1	\N	\N	\N	\N
94	Coari	1301209	AM	2022-03-28	1	\N	\N	\N	\N
95	Codajás	1301308	AM	2022-03-28	1	\N	\N	\N	\N
96	Eirunepé	1301407	AM	2022-03-28	1	\N	\N	\N	\N
97	Envira	1301506	AM	2022-03-28	1	\N	\N	\N	\N
98	Fonte Boa	1301605	AM	2022-03-28	1	\N	\N	\N	\N
99	Guajará	1301654	AM	2022-03-28	1	\N	\N	\N	\N
100	Humaitá	1301704	AM	2022-03-28	1	\N	\N	\N	\N
101	Ipixuna	1301803	AM	2022-03-28	1	\N	\N	\N	\N
102	Iranduba	1301852	AM	2022-03-28	1	\N	\N	\N	\N
103	Itacoatiara	1301902	AM	2022-03-28	1	\N	\N	\N	\N
104	Itamarati	1301951	AM	2022-03-28	1	\N	\N	\N	\N
105	Itapiranga	1302009	AM	2022-03-28	1	\N	\N	\N	\N
106	Japurá	1302108	AM	2022-03-28	1	\N	\N	\N	\N
107	Juruá	1302207	AM	2022-03-28	1	\N	\N	\N	\N
108	Jutaí	1302306	AM	2022-03-28	1	\N	\N	\N	\N
109	Lábrea	1302405	AM	2022-03-28	1	\N	\N	\N	\N
110	Manacapuru	1302504	AM	2022-03-28	1	\N	\N	\N	\N
111	Manaquiri	1302553	AM	2022-03-28	1	\N	\N	\N	\N
112	Manaus	1302603	AM	2022-03-28	1	\N	\N	\N	\N
113	Manicoré	1302702	AM	2022-03-28	1	\N	\N	\N	\N
114	Maraã	1302801	AM	2022-03-28	1	\N	\N	\N	\N
115	Maués	1302900	AM	2022-03-28	1	\N	\N	\N	\N
116	Nhamundá	1303007	AM	2022-03-28	1	\N	\N	\N	\N
117	Nova Olinda do Norte	1303106	AM	2022-03-28	1	\N	\N	\N	\N
118	Novo Airão	1303205	AM	2022-03-28	1	\N	\N	\N	\N
119	Novo Aripuanã	1303304	AM	2022-03-28	1	\N	\N	\N	\N
120	Parintins	1303403	AM	2022-03-28	1	\N	\N	\N	\N
121	Pauini	1303502	AM	2022-03-28	1	\N	\N	\N	\N
122	Presidente Figueiredo	1303536	AM	2022-03-28	1	\N	\N	\N	\N
123	Rio Preto da Eva	1303569	AM	2022-03-28	1	\N	\N	\N	\N
124	Santa Isabel do Rio Negro	1303601	AM	2022-03-28	1	\N	\N	\N	\N
125	Santo Antônio do Içá	1303700	AM	2022-03-28	1	\N	\N	\N	\N
126	São Gabriel da Cachoeira	1303809	AM	2022-03-28	1	\N	\N	\N	\N
127	São Paulo de Olivença	1303908	AM	2022-03-28	1	\N	\N	\N	\N
128	São Sebastião do Uatumã	1303957	AM	2022-03-28	1	\N	\N	\N	\N
129	Silves	1304005	AM	2022-03-28	1	\N	\N	\N	\N
130	Tabatinga	1304062	AM	2022-03-28	1	\N	\N	\N	\N
131	Tapauá	1304104	AM	2022-03-28	1	\N	\N	\N	\N
132	Tefé	1304203	AM	2022-03-28	1	\N	\N	\N	\N
133	Tonantins	1304237	AM	2022-03-28	1	\N	\N	\N	\N
134	Uarini	1304260	AM	2022-03-28	1	\N	\N	\N	\N
135	Urucará	1304302	AM	2022-03-28	1	\N	\N	\N	\N
136	Urucurituba	1304401	AM	2022-03-28	1	\N	\N	\N	\N
137	Alto Alegre	1400050	RR	2022-03-28	1	\N	\N	\N	\N
138	Amajari	1400027	RR	2022-03-28	1	\N	\N	\N	\N
139	Boa Vista	1400100	RR	2022-03-28	1	\N	\N	\N	\N
140	Bonfim	1400159	RR	2022-03-28	1	\N	\N	\N	\N
141	Cantá	1400175	RR	2022-03-28	1	\N	\N	\N	\N
142	Caracaraí	1400209	RR	2022-03-28	1	\N	\N	\N	\N
143	Caroebe	1400233	RR	2022-03-28	1	\N	\N	\N	\N
144	Iracema	1400282	RR	2022-03-28	1	\N	\N	\N	\N
145	Mucajaí	1400308	RR	2022-03-28	1	\N	\N	\N	\N
146	Normandia	1400407	RR	2022-03-28	1	\N	\N	\N	\N
147	Pacaraima	1400456	RR	2022-03-28	1	\N	\N	\N	\N
148	Rorainópolis	1400472	RR	2022-03-28	1	\N	\N	\N	\N
149	São João da Baliza	1400506	RR	2022-03-28	1	\N	\N	\N	\N
150	São Luiz	1400605	RR	2022-03-28	1	\N	\N	\N	\N
151	Uiramutã	1400704	RR	2022-03-28	1	\N	\N	\N	\N
152	Abaetetuba	1500107	PA	2022-03-28	1	\N	\N	\N	\N
153	Abel Figueiredo	1500131	PA	2022-03-28	1	\N	\N	\N	\N
154	Acará	1500206	PA	2022-03-28	1	\N	\N	\N	\N
155	Afuá	1500305	PA	2022-03-28	1	\N	\N	\N	\N
156	Água Azul do Norte	1500347	PA	2022-03-28	1	\N	\N	\N	\N
157	Alenquer	1500404	PA	2022-03-28	1	\N	\N	\N	\N
158	Almeirim	1500503	PA	2022-03-28	1	\N	\N	\N	\N
159	Altamira	1500602	PA	2022-03-28	1	\N	\N	\N	\N
160	Anajás	1500701	PA	2022-03-28	1	\N	\N	\N	\N
161	Ananindeua	1500800	PA	2022-03-28	1	\N	\N	\N	\N
162	Anapu	1500859	PA	2022-03-28	1	\N	\N	\N	\N
163	Augusto Corrêa	1500909	PA	2022-03-28	1	\N	\N	\N	\N
164	Aurora do Pará	1500958	PA	2022-03-28	1	\N	\N	\N	\N
165	Aveiro	1501006	PA	2022-03-28	1	\N	\N	\N	\N
166	Bagre	1501105	PA	2022-03-28	1	\N	\N	\N	\N
167	Baião	1501204	PA	2022-03-28	1	\N	\N	\N	\N
168	Bannach	1501253	PA	2022-03-28	1	\N	\N	\N	\N
169	Barcarena	1501303	PA	2022-03-28	1	\N	\N	\N	\N
170	Belém	1501402	PA	2022-03-28	1	\N	\N	\N	\N
171	Belterra	1501451	PA	2022-03-28	1	\N	\N	\N	\N
172	Benevides	1501501	PA	2022-03-28	1	\N	\N	\N	\N
173	Bom Jesus do Tocantins	1501576	PA	2022-03-28	1	\N	\N	\N	\N
174	Bonito	1501600	PA	2022-03-28	1	\N	\N	\N	\N
175	Bragança	1501709	PA	2022-03-28	1	\N	\N	\N	\N
176	Brasil Novo	1501725	PA	2022-03-28	1	\N	\N	\N	\N
177	Brejo Grande do Araguaia	1501758	PA	2022-03-28	1	\N	\N	\N	\N
178	Breu Branco	1501782	PA	2022-03-28	1	\N	\N	\N	\N
179	Breves	1501808	PA	2022-03-28	1	\N	\N	\N	\N
180	Bujaru	1501907	PA	2022-03-28	1	\N	\N	\N	\N
181	Cachoeira do Arari	1502004	PA	2022-03-28	1	\N	\N	\N	\N
182	Cachoeira do Piriá	1501956	PA	2022-03-28	1	\N	\N	\N	\N
183	Cametá	1502103	PA	2022-03-28	1	\N	\N	\N	\N
184	Canaã dos Carajás	1502152	PA	2022-03-28	1	\N	\N	\N	\N
185	Capanema	1502202	PA	2022-03-28	1	\N	\N	\N	\N
186	Capitão Poço	1502301	PA	2022-03-28	1	\N	\N	\N	\N
187	Castanhal	1502400	PA	2022-03-28	1	\N	\N	\N	\N
188	Chaves	1502509	PA	2022-03-28	1	\N	\N	\N	\N
189	Colares	1502608	PA	2022-03-28	1	\N	\N	\N	\N
190	Conceição do Araguaia	1502707	PA	2022-03-28	1	\N	\N	\N	\N
191	Concórdia do Pará	1502756	PA	2022-03-28	1	\N	\N	\N	\N
192	Cumaru do Norte	1502764	PA	2022-03-28	1	\N	\N	\N	\N
193	Curionópolis	1502772	PA	2022-03-28	1	\N	\N	\N	\N
194	Curralinho	1502806	PA	2022-03-28	1	\N	\N	\N	\N
195	Curuá	1502855	PA	2022-03-28	1	\N	\N	\N	\N
196	Curuçá	1502905	PA	2022-03-28	1	\N	\N	\N	\N
197	Dom Eliseu	1502939	PA	2022-03-28	1	\N	\N	\N	\N
198	Eldorado do Carajás	1502954	PA	2022-03-28	1	\N	\N	\N	\N
199	Faro	1503002	PA	2022-03-28	1	\N	\N	\N	\N
200	Floresta do Araguaia	1503044	PA	2022-03-28	1	\N	\N	\N	\N
201	Garrafão do Norte	1503077	PA	2022-03-28	1	\N	\N	\N	\N
202	Goianésia do Pará	1503093	PA	2022-03-28	1	\N	\N	\N	\N
203	Gurupá	1503101	PA	2022-03-28	1	\N	\N	\N	\N
204	Igarapé-Açu	1503200	PA	2022-03-28	1	\N	\N	\N	\N
205	Igarapé-Miri	1503309	PA	2022-03-28	1	\N	\N	\N	\N
206	Inhangapi	1503408	PA	2022-03-28	1	\N	\N	\N	\N
207	Ipixuna do Pará	1503457	PA	2022-03-28	1	\N	\N	\N	\N
208	Irituia	1503507	PA	2022-03-28	1	\N	\N	\N	\N
209	Itaituba	1503606	PA	2022-03-28	1	\N	\N	\N	\N
210	Itupiranga	1503705	PA	2022-03-28	1	\N	\N	\N	\N
211	Jacareacanga	1503754	PA	2022-03-28	1	\N	\N	\N	\N
212	Jacundá	1503804	PA	2022-03-28	1	\N	\N	\N	\N
213	Juruti	1503903	PA	2022-03-28	1	\N	\N	\N	\N
214	Limoeiro do Ajuru	1504000	PA	2022-03-28	1	\N	\N	\N	\N
215	Mãe do Rio	1504059	PA	2022-03-28	1	\N	\N	\N	\N
216	Magalhães Barata	1504109	PA	2022-03-28	1	\N	\N	\N	\N
217	Marabá	1504208	PA	2022-03-28	1	\N	\N	\N	\N
218	Maracanã	1504307	PA	2022-03-28	1	\N	\N	\N	\N
219	Marapanim	1504406	PA	2022-03-28	1	\N	\N	\N	\N
220	Marituba	1504422	PA	2022-03-28	1	\N	\N	\N	\N
221	Medicilândia	1504455	PA	2022-03-28	1	\N	\N	\N	\N
222	Melgaço	1504505	PA	2022-03-28	1	\N	\N	\N	\N
223	Mocajuba	1504604	PA	2022-03-28	1	\N	\N	\N	\N
224	Moju	1504703	PA	2022-03-28	1	\N	\N	\N	\N
225	Mojuí dos Campos	1504752	PA	2022-03-28	1	\N	\N	\N	\N
226	Monte Alegre	1504802	PA	2022-03-28	1	\N	\N	\N	\N
227	Muaná	1504901	PA	2022-03-28	1	\N	\N	\N	\N
228	Nova Esperança do Piriá	1504950	PA	2022-03-28	1	\N	\N	\N	\N
229	Nova Ipixuna	1504976	PA	2022-03-28	1	\N	\N	\N	\N
230	Nova Timboteua	1505007	PA	2022-03-28	1	\N	\N	\N	\N
231	Novo Progresso	1505031	PA	2022-03-28	1	\N	\N	\N	\N
232	Novo Repartimento	1505064	PA	2022-03-28	1	\N	\N	\N	\N
233	Óbidos	1505106	PA	2022-03-28	1	\N	\N	\N	\N
234	Oeiras do Pará	1505205	PA	2022-03-28	1	\N	\N	\N	\N
235	Oriximiná	1505304	PA	2022-03-28	1	\N	\N	\N	\N
236	Ourém	1505403	PA	2022-03-28	1	\N	\N	\N	\N
237	Ourilândia do Norte	1505437	PA	2022-03-28	1	\N	\N	\N	\N
238	Pacajá	1505486	PA	2022-03-28	1	\N	\N	\N	\N
239	Palestina do Pará	1505494	PA	2022-03-28	1	\N	\N	\N	\N
240	Paragominas	1505502	PA	2022-03-28	1	\N	\N	\N	\N
241	Parauapebas	1505536	PA	2022-03-28	1	\N	\N	\N	\N
242	'Pau D''Arco'	1505551	PA	2022-03-28	1	\N	\N	\N	\N
243	Peixe-Boi	1505601	PA	2022-03-28	1	\N	\N	\N	\N
244	Piçarra	1505635	PA	2022-03-28	1	\N	\N	\N	\N
245	Placas	1505650	PA	2022-03-28	1	\N	\N	\N	\N
246	Ponta de Pedras	1505700	PA	2022-03-28	1	\N	\N	\N	\N
247	Portel	1505809	PA	2022-03-28	1	\N	\N	\N	\N
248	Porto de Moz	1505908	PA	2022-03-28	1	\N	\N	\N	\N
249	Prainha	1506005	PA	2022-03-28	1	\N	\N	\N	\N
250	Primavera	1506104	PA	2022-03-28	1	\N	\N	\N	\N
251	Quatipuru	1506112	PA	2022-03-28	1	\N	\N	\N	\N
252	Redenção	1506138	PA	2022-03-28	1	\N	\N	\N	\N
253	Rio Maria	1506161	PA	2022-03-28	1	\N	\N	\N	\N
254	Rondon do Pará	1506187	PA	2022-03-28	1	\N	\N	\N	\N
255	Rurópolis	1506195	PA	2022-03-28	1	\N	\N	\N	\N
256	Salinópolis	1506203	PA	2022-03-28	1	\N	\N	\N	\N
257	Salvaterra	1506302	PA	2022-03-28	1	\N	\N	\N	\N
258	Santa Bárbara do Pará	1506351	PA	2022-03-28	1	\N	\N	\N	\N
259	Santa Cruz do Arari	1506401	PA	2022-03-28	1	\N	\N	\N	\N
260	Santa Izabel do Pará	1506500	PA	2022-03-28	1	\N	\N	\N	\N
261	Santa Luzia do Pará	1506559	PA	2022-03-28	1	\N	\N	\N	\N
262	Santa Maria das Barreiras	1506583	PA	2022-03-28	1	\N	\N	\N	\N
263	Santa Maria do Pará	1506609	PA	2022-03-28	1	\N	\N	\N	\N
264	Santana do Araguaia	1506708	PA	2022-03-28	1	\N	\N	\N	\N
265	Santarém	1506807	PA	2022-03-28	1	\N	\N	\N	\N
266	Santarém Novo	1506906	PA	2022-03-28	1	\N	\N	\N	\N
267	Santo Antônio do Tauá	1507003	PA	2022-03-28	1	\N	\N	\N	\N
268	São Caetano de Odivelas	1507102	PA	2022-03-28	1	\N	\N	\N	\N
269	São Domingos do Araguaia	1507151	PA	2022-03-28	1	\N	\N	\N	\N
270	São Domingos do Capim	1507201	PA	2022-03-28	1	\N	\N	\N	\N
271	São Félix do Xingu	1507300	PA	2022-03-28	1	\N	\N	\N	\N
272	São Francisco do Pará	1507409	PA	2022-03-28	1	\N	\N	\N	\N
273	São Geraldo do Araguaia	1507458	PA	2022-03-28	1	\N	\N	\N	\N
274	São João da Ponta	1507466	PA	2022-03-28	1	\N	\N	\N	\N
275	São João de Pirabas	1507474	PA	2022-03-28	1	\N	\N	\N	\N
276	São João do Araguaia	1507508	PA	2022-03-28	1	\N	\N	\N	\N
277	São Miguel do Guamá	1507607	PA	2022-03-28	1	\N	\N	\N	\N
278	São Sebastião da Boa Vista	1507706	PA	2022-03-28	1	\N	\N	\N	\N
279	Sapucaia	1507755	PA	2022-03-28	1	\N	\N	\N	\N
280	Senador José Porfírio	1507805	PA	2022-03-28	1	\N	\N	\N	\N
281	Soure	1507904	PA	2022-03-28	1	\N	\N	\N	\N
282	Tailândia	1507953	PA	2022-03-28	1	\N	\N	\N	\N
283	Terra Alta	1507961	PA	2022-03-28	1	\N	\N	\N	\N
284	Terra Santa	1507979	PA	2022-03-28	1	\N	\N	\N	\N
285	Tomé-Açu	1508001	PA	2022-03-28	1	\N	\N	\N	\N
286	Tracuateua	1508035	PA	2022-03-28	1	\N	\N	\N	\N
287	Trairão	1508050	PA	2022-03-28	1	\N	\N	\N	\N
288	Tucumã	1508084	PA	2022-03-28	1	\N	\N	\N	\N
289	Tucuruí	1508100	PA	2022-03-28	1	\N	\N	\N	\N
290	Ulianópolis	1508126	PA	2022-03-28	1	\N	\N	\N	\N
291	Uruará	1508159	PA	2022-03-28	1	\N	\N	\N	\N
292	Vigia	1508209	PA	2022-03-28	1	\N	\N	\N	\N
293	Viseu	1508308	PA	2022-03-28	1	\N	\N	\N	\N
294	Vitória do Xingu	1508357	PA	2022-03-28	1	\N	\N	\N	\N
295	Xinguara	1508407	PA	2022-03-28	1	\N	\N	\N	\N
296	Amapá	1600105	AP	2022-03-28	1	\N	\N	\N	\N
297	Calçoene	1600204	AP	2022-03-28	1	\N	\N	\N	\N
298	Cutias	1600212	AP	2022-03-28	1	\N	\N	\N	\N
299	Ferreira Gomes	1600238	AP	2022-03-28	1	\N	\N	\N	\N
300	Itaubal	1600253	AP	2022-03-28	1	\N	\N	\N	\N
301	Laranjal do Jari	1600279	AP	2022-03-28	1	\N	\N	\N	\N
302	Macapá	1600303	AP	2022-03-28	1	\N	\N	\N	\N
303	Mazagão	1600402	AP	2022-03-28	1	\N	\N	\N	\N
304	Oiapoque	1600501	AP	2022-03-28	1	\N	\N	\N	\N
305	Pedra Branca do Amapari	1600154	AP	2022-03-28	1	\N	\N	\N	\N
306	Porto Grande	1600535	AP	2022-03-28	1	\N	\N	\N	\N
307	Pracuúba	1600550	AP	2022-03-28	1	\N	\N	\N	\N
308	Santana	1600600	AP	2022-03-28	1	\N	\N	\N	\N
309	Serra do Navio	1600055	AP	2022-03-28	1	\N	\N	\N	\N
310	Tartarugalzinho	1600709	AP	2022-03-28	1	\N	\N	\N	\N
311	Vitória do Jari	1600808	AP	2022-03-28	1	\N	\N	\N	\N
312	Abreulândia	1700251	TO	2022-03-28	1	\N	\N	\N	\N
313	Aguiarnópolis	1700301	TO	2022-03-28	1	\N	\N	\N	\N
314	Aliança do Tocantins	1700350	TO	2022-03-28	1	\N	\N	\N	\N
315	Almas	1700400	TO	2022-03-28	1	\N	\N	\N	\N
316	Alvorada	1700707	TO	2022-03-28	1	\N	\N	\N	\N
317	Ananás	1701002	TO	2022-03-28	1	\N	\N	\N	\N
318	Angico	1701051	TO	2022-03-28	1	\N	\N	\N	\N
319	Aparecida do Rio Negro	1701101	TO	2022-03-28	1	\N	\N	\N	\N
320	Aragominas	1701309	TO	2022-03-28	1	\N	\N	\N	\N
321	Araguacema	1701903	TO	2022-03-28	1	\N	\N	\N	\N
322	Araguaçu	1702000	TO	2022-03-28	1	\N	\N	\N	\N
323	Araguaína	1702109	TO	2022-03-28	1	\N	\N	\N	\N
324	Araguanã	1702158	TO	2022-03-28	1	\N	\N	\N	\N
325	Araguatins	1702208	TO	2022-03-28	1	\N	\N	\N	\N
326	Arapoema	1702307	TO	2022-03-28	1	\N	\N	\N	\N
327	Arraias	1702406	TO	2022-03-28	1	\N	\N	\N	\N
328	Augustinópolis	1702554	TO	2022-03-28	1	\N	\N	\N	\N
329	Aurora do Tocantins	1702703	TO	2022-03-28	1	\N	\N	\N	\N
330	Axixá do Tocantins	1702901	TO	2022-03-28	1	\N	\N	\N	\N
331	Babaçulândia	1703008	TO	2022-03-28	1	\N	\N	\N	\N
332	Bandeirantes do Tocantins	1703057	TO	2022-03-28	1	\N	\N	\N	\N
333	Barra do Ouro	1703073	TO	2022-03-28	1	\N	\N	\N	\N
334	Barrolândia	1703107	TO	2022-03-28	1	\N	\N	\N	\N
335	Bernardo Sayão	1703206	TO	2022-03-28	1	\N	\N	\N	\N
336	Bom Jesus do Tocantins	1703305	TO	2022-03-28	1	\N	\N	\N	\N
337	Brasilândia do Tocantins	1703602	TO	2022-03-28	1	\N	\N	\N	\N
338	Brejinho de Nazaré	1703701	TO	2022-03-28	1	\N	\N	\N	\N
339	Buriti do Tocantins	1703800	TO	2022-03-28	1	\N	\N	\N	\N
340	Cachoeirinha	1703826	TO	2022-03-28	1	\N	\N	\N	\N
341	Campos Lindos	1703842	TO	2022-03-28	1	\N	\N	\N	\N
342	Cariri do Tocantins	1703867	TO	2022-03-28	1	\N	\N	\N	\N
343	Carmolândia	1703883	TO	2022-03-28	1	\N	\N	\N	\N
344	Carrasco Bonito	1703891	TO	2022-03-28	1	\N	\N	\N	\N
345	Caseara	1703909	TO	2022-03-28	1	\N	\N	\N	\N
346	Centenário	1704105	TO	2022-03-28	1	\N	\N	\N	\N
347	Chapada da Natividade	1705102	TO	2022-03-28	1	\N	\N	\N	\N
348	Chapada de Areia	1704600	TO	2022-03-28	1	\N	\N	\N	\N
349	Colinas do Tocantins	1705508	TO	2022-03-28	1	\N	\N	\N	\N
350	Colméia	1716703	TO	2022-03-28	1	\N	\N	\N	\N
351	Combinado	1705557	TO	2022-03-28	1	\N	\N	\N	\N
352	Conceição do Tocantins	1705607	TO	2022-03-28	1	\N	\N	\N	\N
353	Couto Magalhães	1706001	TO	2022-03-28	1	\N	\N	\N	\N
354	Cristalândia	1706100	TO	2022-03-28	1	\N	\N	\N	\N
355	Crixás do Tocantins	1706258	TO	2022-03-28	1	\N	\N	\N	\N
356	Darcinópolis	1706506	TO	2022-03-28	1	\N	\N	\N	\N
357	Dianópolis	1707009	TO	2022-03-28	1	\N	\N	\N	\N
358	Divinópolis do Tocantins	1707108	TO	2022-03-28	1	\N	\N	\N	\N
359	Dois Irmãos do Tocantins	1707207	TO	2022-03-28	1	\N	\N	\N	\N
360	Dueré	1707306	TO	2022-03-28	1	\N	\N	\N	\N
361	Esperantina	1707405	TO	2022-03-28	1	\N	\N	\N	\N
362	Fátima	1707553	TO	2022-03-28	1	\N	\N	\N	\N
363	Figueirópolis	1707652	TO	2022-03-28	1	\N	\N	\N	\N
364	Filadélfia	1707702	TO	2022-03-28	1	\N	\N	\N	\N
365	Formoso do Araguaia	1708205	TO	2022-03-28	1	\N	\N	\N	\N
366	Goianorte	1708304	TO	2022-03-28	1	\N	\N	\N	\N
367	Goiatins	1709005	TO	2022-03-28	1	\N	\N	\N	\N
368	Guaraí	1709302	TO	2022-03-28	1	\N	\N	\N	\N
369	Gurupi	1709500	TO	2022-03-28	1	\N	\N	\N	\N
370	Ipueiras	1709807	TO	2022-03-28	1	\N	\N	\N	\N
371	Itacajá	1710508	TO	2022-03-28	1	\N	\N	\N	\N
372	Itaguatins	1710706	TO	2022-03-28	1	\N	\N	\N	\N
373	Itapiratins	1710904	TO	2022-03-28	1	\N	\N	\N	\N
374	Itaporã do Tocantins	1711100	TO	2022-03-28	1	\N	\N	\N	\N
375	Jaú do Tocantins	1711506	TO	2022-03-28	1	\N	\N	\N	\N
376	Juarina	1711803	TO	2022-03-28	1	\N	\N	\N	\N
377	Lagoa da Confusão	1711902	TO	2022-03-28	1	\N	\N	\N	\N
378	Lagoa do Tocantins	1711951	TO	2022-03-28	1	\N	\N	\N	\N
379	Lajeado	1712009	TO	2022-03-28	1	\N	\N	\N	\N
380	Lavandeira	1712157	TO	2022-03-28	1	\N	\N	\N	\N
381	Lizarda	1712405	TO	2022-03-28	1	\N	\N	\N	\N
382	Luzinópolis	1712454	TO	2022-03-28	1	\N	\N	\N	\N
383	Marianópolis do Tocantins	1712504	TO	2022-03-28	1	\N	\N	\N	\N
384	Mateiros	1712702	TO	2022-03-28	1	\N	\N	\N	\N
385	Maurilândia do Tocantins	1712801	TO	2022-03-28	1	\N	\N	\N	\N
386	Miracema do Tocantins	1713205	TO	2022-03-28	1	\N	\N	\N	\N
387	Miranorte	1713304	TO	2022-03-28	1	\N	\N	\N	\N
388	Monte do Carmo	1713601	TO	2022-03-28	1	\N	\N	\N	\N
389	Monte Santo do Tocantins	1713700	TO	2022-03-28	1	\N	\N	\N	\N
390	Muricilândia	1713957	TO	2022-03-28	1	\N	\N	\N	\N
391	Natividade	1714203	TO	2022-03-28	1	\N	\N	\N	\N
392	Nazaré	1714302	TO	2022-03-28	1	\N	\N	\N	\N
393	Nova Olinda	1714880	TO	2022-03-28	1	\N	\N	\N	\N
394	Nova Rosalândia	1715002	TO	2022-03-28	1	\N	\N	\N	\N
395	Novo Acordo	1715101	TO	2022-03-28	1	\N	\N	\N	\N
396	Novo Alegre	1715150	TO	2022-03-28	1	\N	\N	\N	\N
397	Novo Jardim	1715259	TO	2022-03-28	1	\N	\N	\N	\N
398	Oliveira de Fátima	1715507	TO	2022-03-28	1	\N	\N	\N	\N
399	Palmas	1721000	TO	2022-03-28	1	\N	\N	\N	\N
400	Palmeirante	1715705	TO	2022-03-28	1	\N	\N	\N	\N
401	Palmeiras do Tocantins	1713809	TO	2022-03-28	1	\N	\N	\N	\N
402	Palmeirópolis	1715754	TO	2022-03-28	1	\N	\N	\N	\N
403	Paraíso do Tocantins	1716109	TO	2022-03-28	1	\N	\N	\N	\N
404	Paranã	1716208	TO	2022-03-28	1	\N	\N	\N	\N
405	'Pau D''Arco'	1716307	TO	2022-03-28	1	\N	\N	\N	\N
406	Pedro Afonso	1716505	TO	2022-03-28	1	\N	\N	\N	\N
407	Peixe	1716604	TO	2022-03-28	1	\N	\N	\N	\N
408	Pequizeiro	1716653	TO	2022-03-28	1	\N	\N	\N	\N
409	Pindorama do Tocantins	1717008	TO	2022-03-28	1	\N	\N	\N	\N
410	Piraquê	1717206	TO	2022-03-28	1	\N	\N	\N	\N
411	Pium	1717503	TO	2022-03-28	1	\N	\N	\N	\N
412	Ponte Alta do Bom Jesus	1717800	TO	2022-03-28	1	\N	\N	\N	\N
413	Ponte Alta do Tocantins	1717909	TO	2022-03-28	1	\N	\N	\N	\N
414	Porto Alegre do Tocantins	1718006	TO	2022-03-28	1	\N	\N	\N	\N
415	Porto Nacional	1718204	TO	2022-03-28	1	\N	\N	\N	\N
416	Praia Norte	1718303	TO	2022-03-28	1	\N	\N	\N	\N
417	Presidente Kennedy	1718402	TO	2022-03-28	1	\N	\N	\N	\N
418	Pugmil	1718451	TO	2022-03-28	1	\N	\N	\N	\N
419	Recursolândia	1718501	TO	2022-03-28	1	\N	\N	\N	\N
420	Riachinho	1718550	TO	2022-03-28	1	\N	\N	\N	\N
421	Rio da Conceição	1718659	TO	2022-03-28	1	\N	\N	\N	\N
422	Rio dos Bois	1718709	TO	2022-03-28	1	\N	\N	\N	\N
423	Rio Sono	1718758	TO	2022-03-28	1	\N	\N	\N	\N
424	Sampaio	1718808	TO	2022-03-28	1	\N	\N	\N	\N
425	Sandolândia	1718840	TO	2022-03-28	1	\N	\N	\N	\N
426	Santa Fé do Araguaia	1718865	TO	2022-03-28	1	\N	\N	\N	\N
427	Santa Maria do Tocantins	1718881	TO	2022-03-28	1	\N	\N	\N	\N
428	Santa Rita do Tocantins	1718899	TO	2022-03-28	1	\N	\N	\N	\N
429	Santa Rosa do Tocantins	1718907	TO	2022-03-28	1	\N	\N	\N	\N
430	Santa Tereza do Tocantins	1719004	TO	2022-03-28	1	\N	\N	\N	\N
431	Santa Terezinha do Tocantins	1720002	TO	2022-03-28	1	\N	\N	\N	\N
432	São Bento do Tocantins	1720101	TO	2022-03-28	1	\N	\N	\N	\N
433	São Félix do Tocantins	1720150	TO	2022-03-28	1	\N	\N	\N	\N
434	São Miguel do Tocantins	1720200	TO	2022-03-28	1	\N	\N	\N	\N
435	São Salvador do Tocantins	1720259	TO	2022-03-28	1	\N	\N	\N	\N
436	São Sebastião do Tocantins	1720309	TO	2022-03-28	1	\N	\N	\N	\N
437	São Valério	1720499	TO	2022-03-28	1	\N	\N	\N	\N
438	Silvanópolis	1720655	TO	2022-03-28	1	\N	\N	\N	\N
439	Sítio Novo do Tocantins	1720804	TO	2022-03-28	1	\N	\N	\N	\N
440	Sucupira	1720853	TO	2022-03-28	1	\N	\N	\N	\N
441	Tabocão	1708254	TO	2022-03-28	1	\N	\N	\N	\N
442	Taguatinga	1720903	TO	2022-03-28	1	\N	\N	\N	\N
443	Taipas do Tocantins	1720937	TO	2022-03-28	1	\N	\N	\N	\N
444	Talismã	1720978	TO	2022-03-28	1	\N	\N	\N	\N
445	Tocantínia	1721109	TO	2022-03-28	1	\N	\N	\N	\N
446	Tocantinópolis	1721208	TO	2022-03-28	1	\N	\N	\N	\N
447	Tupirama	1721257	TO	2022-03-28	1	\N	\N	\N	\N
448	Tupiratins	1721307	TO	2022-03-28	1	\N	\N	\N	\N
449	Wanderlândia	1722081	TO	2022-03-28	1	\N	\N	\N	\N
450	Xambioá	1722107	TO	2022-03-28	1	\N	\N	\N	\N
451	Açailândia	2100055	MA	2022-03-28	1	\N	\N	\N	\N
452	Afonso Cunha	2100105	MA	2022-03-28	1	\N	\N	\N	\N
453	Água Doce do Maranhão	2100154	MA	2022-03-28	1	\N	\N	\N	\N
454	Alcântara	2100204	MA	2022-03-28	1	\N	\N	\N	\N
455	Aldeias Altas	2100303	MA	2022-03-28	1	\N	\N	\N	\N
456	Altamira do Maranhão	2100402	MA	2022-03-28	1	\N	\N	\N	\N
457	Alto Alegre do Maranhão	2100436	MA	2022-03-28	1	\N	\N	\N	\N
458	Alto Alegre do Pindaré	2100477	MA	2022-03-28	1	\N	\N	\N	\N
459	Alto Parnaíba	2100501	MA	2022-03-28	1	\N	\N	\N	\N
460	Amapá do Maranhão	2100550	MA	2022-03-28	1	\N	\N	\N	\N
461	Amarante do Maranhão	2100600	MA	2022-03-28	1	\N	\N	\N	\N
462	Anajatuba	2100709	MA	2022-03-28	1	\N	\N	\N	\N
463	Anapurus	2100808	MA	2022-03-28	1	\N	\N	\N	\N
464	Apicum-Açu	2100832	MA	2022-03-28	1	\N	\N	\N	\N
465	Araguanã	2100873	MA	2022-03-28	1	\N	\N	\N	\N
466	Araioses	2100907	MA	2022-03-28	1	\N	\N	\N	\N
467	Arame	2100956	MA	2022-03-28	1	\N	\N	\N	\N
468	Arari	2101004	MA	2022-03-28	1	\N	\N	\N	\N
469	Axixá	2101103	MA	2022-03-28	1	\N	\N	\N	\N
470	Bacabal	2101202	MA	2022-03-28	1	\N	\N	\N	\N
471	Bacabeira	2101251	MA	2022-03-28	1	\N	\N	\N	\N
472	Bacuri	2101301	MA	2022-03-28	1	\N	\N	\N	\N
473	Bacurituba	2101350	MA	2022-03-28	1	\N	\N	\N	\N
474	Balsas	2101400	MA	2022-03-28	1	\N	\N	\N	\N
475	Barão de Grajaú	2101509	MA	2022-03-28	1	\N	\N	\N	\N
476	Barra do Corda	2101608	MA	2022-03-28	1	\N	\N	\N	\N
477	Barreirinhas	2101707	MA	2022-03-28	1	\N	\N	\N	\N
478	Bela Vista do Maranhão	2101772	MA	2022-03-28	1	\N	\N	\N	\N
479	Belágua	2101731	MA	2022-03-28	1	\N	\N	\N	\N
480	Benedito Leite	2101806	MA	2022-03-28	1	\N	\N	\N	\N
481	Bequimão	2101905	MA	2022-03-28	1	\N	\N	\N	\N
482	Bernardo do Mearim	2101939	MA	2022-03-28	1	\N	\N	\N	\N
483	Boa Vista do Gurupi	2101970	MA	2022-03-28	1	\N	\N	\N	\N
484	Bom Jardim	2102002	MA	2022-03-28	1	\N	\N	\N	\N
485	Bom Jesus das Selvas	2102036	MA	2022-03-28	1	\N	\N	\N	\N
486	Bom Lugar	2102077	MA	2022-03-28	1	\N	\N	\N	\N
487	Brejo	2102101	MA	2022-03-28	1	\N	\N	\N	\N
488	Brejo de Areia	2102150	MA	2022-03-28	1	\N	\N	\N	\N
489	Buriti	2102200	MA	2022-03-28	1	\N	\N	\N	\N
490	Buriti Bravo	2102309	MA	2022-03-28	1	\N	\N	\N	\N
491	Buriticupu	2102325	MA	2022-03-28	1	\N	\N	\N	\N
492	Buritirana	2102358	MA	2022-03-28	1	\N	\N	\N	\N
493	Cachoeira Grande	2102374	MA	2022-03-28	1	\N	\N	\N	\N
494	Cajapió	2102408	MA	2022-03-28	1	\N	\N	\N	\N
495	Cajari	2102507	MA	2022-03-28	1	\N	\N	\N	\N
496	Campestre do Maranhão	2102556	MA	2022-03-28	1	\N	\N	\N	\N
497	Cândido Mendes	2102606	MA	2022-03-28	1	\N	\N	\N	\N
498	Cantanhede	2102705	MA	2022-03-28	1	\N	\N	\N	\N
499	Capinzal do Norte	2102754	MA	2022-03-28	1	\N	\N	\N	\N
500	Carolina	2102804	MA	2022-03-28	1	\N	\N	\N	\N
501	Carutapera	2102903	MA	2022-03-28	1	\N	\N	\N	\N
502	Caxias	2103000	MA	2022-03-28	1	\N	\N	\N	\N
503	Cedral	2103109	MA	2022-03-28	1	\N	\N	\N	\N
504	Central do Maranhão	2103125	MA	2022-03-28	1	\N	\N	\N	\N
505	Centro do Guilherme	2103158	MA	2022-03-28	1	\N	\N	\N	\N
506	Centro Novo do Maranhão	2103174	MA	2022-03-28	1	\N	\N	\N	\N
507	Chapadinha	2103208	MA	2022-03-28	1	\N	\N	\N	\N
508	Cidelândia	2103257	MA	2022-03-28	1	\N	\N	\N	\N
509	Codó	2103307	MA	2022-03-28	1	\N	\N	\N	\N
510	Coelho Neto	2103406	MA	2022-03-28	1	\N	\N	\N	\N
511	Colinas	2103505	MA	2022-03-28	1	\N	\N	\N	\N
512	Conceição do Lago-Açu	2103554	MA	2022-03-28	1	\N	\N	\N	\N
513	Coroatá	2103604	MA	2022-03-28	1	\N	\N	\N	\N
514	Cururupu	2103703	MA	2022-03-28	1	\N	\N	\N	\N
515	Davinópolis	2103752	MA	2022-03-28	1	\N	\N	\N	\N
516	Dom Pedro	2103802	MA	2022-03-28	1	\N	\N	\N	\N
517	Duque Bacelar	2103901	MA	2022-03-28	1	\N	\N	\N	\N
518	Esperantinópolis	2104008	MA	2022-03-28	1	\N	\N	\N	\N
519	Estreito	2104057	MA	2022-03-28	1	\N	\N	\N	\N
520	Feira Nova do Maranhão	2104073	MA	2022-03-28	1	\N	\N	\N	\N
521	Fernando Falcão	2104081	MA	2022-03-28	1	\N	\N	\N	\N
522	Formosa da Serra Negra	2104099	MA	2022-03-28	1	\N	\N	\N	\N
523	Fortaleza dos Nogueiras	2104107	MA	2022-03-28	1	\N	\N	\N	\N
524	Fortuna	2104206	MA	2022-03-28	1	\N	\N	\N	\N
525	Godofredo Viana	2104305	MA	2022-03-28	1	\N	\N	\N	\N
526	Gonçalves Dias	2104404	MA	2022-03-28	1	\N	\N	\N	\N
527	Governador Archer	2104503	MA	2022-03-28	1	\N	\N	\N	\N
528	Governador Edison Lobão	2104552	MA	2022-03-28	1	\N	\N	\N	\N
529	Governador Eugênio Barros	2104602	MA	2022-03-28	1	\N	\N	\N	\N
530	Governador Luiz Rocha	2104628	MA	2022-03-28	1	\N	\N	\N	\N
531	Governador Newton Bello	2104651	MA	2022-03-28	1	\N	\N	\N	\N
532	Governador Nunes Freire	2104677	MA	2022-03-28	1	\N	\N	\N	\N
533	Graça Aranha	2104701	MA	2022-03-28	1	\N	\N	\N	\N
534	Grajaú	2104800	MA	2022-03-28	1	\N	\N	\N	\N
535	Guimarães	2104909	MA	2022-03-28	1	\N	\N	\N	\N
536	Humberto de Campos	2105005	MA	2022-03-28	1	\N	\N	\N	\N
537	Icatu	2105104	MA	2022-03-28	1	\N	\N	\N	\N
538	Igarapé do Meio	2105153	MA	2022-03-28	1	\N	\N	\N	\N
539	Igarapé Grande	2105203	MA	2022-03-28	1	\N	\N	\N	\N
540	Imperatriz	2105302	MA	2022-03-28	1	\N	\N	\N	\N
541	Itaipava do Grajaú	2105351	MA	2022-03-28	1	\N	\N	\N	\N
542	Itapecuru Mirim	2105401	MA	2022-03-28	1	\N	\N	\N	\N
543	Itinga do Maranhão	2105427	MA	2022-03-28	1	\N	\N	\N	\N
544	Jatobá	2105450	MA	2022-03-28	1	\N	\N	\N	\N
545	Jenipapo dos Vieiras	2105476	MA	2022-03-28	1	\N	\N	\N	\N
546	João Lisboa	2105500	MA	2022-03-28	1	\N	\N	\N	\N
547	Joselândia	2105609	MA	2022-03-28	1	\N	\N	\N	\N
548	Junco do Maranhão	2105658	MA	2022-03-28	1	\N	\N	\N	\N
549	Lago da Pedra	2105708	MA	2022-03-28	1	\N	\N	\N	\N
550	Lago do Junco	2105807	MA	2022-03-28	1	\N	\N	\N	\N
551	Lago dos Rodrigues	2105948	MA	2022-03-28	1	\N	\N	\N	\N
552	Lago Verde	2105906	MA	2022-03-28	1	\N	\N	\N	\N
553	Lagoa do Mato	2105922	MA	2022-03-28	1	\N	\N	\N	\N
554	Lagoa Grande do Maranhão	2105963	MA	2022-03-28	1	\N	\N	\N	\N
555	Lajeado Novo	2105989	MA	2022-03-28	1	\N	\N	\N	\N
556	Lima Campos	2106003	MA	2022-03-28	1	\N	\N	\N	\N
557	Loreto	2106102	MA	2022-03-28	1	\N	\N	\N	\N
558	Luís Domingues	2106201	MA	2022-03-28	1	\N	\N	\N	\N
559	Magalhães de Almeida	2106300	MA	2022-03-28	1	\N	\N	\N	\N
560	Maracaçumé	2106326	MA	2022-03-28	1	\N	\N	\N	\N
561	Marajá do Sena	2106359	MA	2022-03-28	1	\N	\N	\N	\N
562	Maranhãozinho	2106375	MA	2022-03-28	1	\N	\N	\N	\N
563	Mata Roma	2106409	MA	2022-03-28	1	\N	\N	\N	\N
564	Matinha	2106508	MA	2022-03-28	1	\N	\N	\N	\N
565	Matões	2106607	MA	2022-03-28	1	\N	\N	\N	\N
566	Matões do Norte	2106631	MA	2022-03-28	1	\N	\N	\N	\N
567	Milagres do Maranhão	2106672	MA	2022-03-28	1	\N	\N	\N	\N
568	Mirador	2106706	MA	2022-03-28	1	\N	\N	\N	\N
569	Miranda do Norte	2106755	MA	2022-03-28	1	\N	\N	\N	\N
570	Mirinzal	2106805	MA	2022-03-28	1	\N	\N	\N	\N
571	Monção	2106904	MA	2022-03-28	1	\N	\N	\N	\N
572	Montes Altos	2107001	MA	2022-03-28	1	\N	\N	\N	\N
573	Morros	2107100	MA	2022-03-28	1	\N	\N	\N	\N
574	Nina Rodrigues	2107209	MA	2022-03-28	1	\N	\N	\N	\N
575	Nova Colinas	2107258	MA	2022-03-28	1	\N	\N	\N	\N
576	Nova Iorque	2107308	MA	2022-03-28	1	\N	\N	\N	\N
577	Nova Olinda do Maranhão	2107357	MA	2022-03-28	1	\N	\N	\N	\N
578	'Olho d''Água das Cunhãs'	2107407	MA	2022-03-28	1	\N	\N	\N	\N
579	Olinda Nova do Maranhão	2107456	MA	2022-03-28	1	\N	\N	\N	\N
580	Paço do Lumiar	2107506	MA	2022-03-28	1	\N	\N	\N	\N
581	Palmeirândia	2107605	MA	2022-03-28	1	\N	\N	\N	\N
582	Paraibano	2107704	MA	2022-03-28	1	\N	\N	\N	\N
583	Parnarama	2107803	MA	2022-03-28	1	\N	\N	\N	\N
584	Passagem Franca	2107902	MA	2022-03-28	1	\N	\N	\N	\N
585	Pastos Bons	2108009	MA	2022-03-28	1	\N	\N	\N	\N
586	Paulino Neves	2108058	MA	2022-03-28	1	\N	\N	\N	\N
587	Paulo Ramos	2108108	MA	2022-03-28	1	\N	\N	\N	\N
588	Pedreiras	2108207	MA	2022-03-28	1	\N	\N	\N	\N
589	Pedro do Rosário	2108256	MA	2022-03-28	1	\N	\N	\N	\N
590	Penalva	2108306	MA	2022-03-28	1	\N	\N	\N	\N
591	Peri Mirim	2108405	MA	2022-03-28	1	\N	\N	\N	\N
592	Peritoró	2108454	MA	2022-03-28	1	\N	\N	\N	\N
593	Pindaré-Mirim	2108504	MA	2022-03-28	1	\N	\N	\N	\N
594	Pinheiro	2108603	MA	2022-03-28	1	\N	\N	\N	\N
595	Pio XII	2108702	MA	2022-03-28	1	\N	\N	\N	\N
596	Pirapemas	2108801	MA	2022-03-28	1	\N	\N	\N	\N
597	Poção de Pedras	2108900	MA	2022-03-28	1	\N	\N	\N	\N
598	Porto Franco	2109007	MA	2022-03-28	1	\N	\N	\N	\N
599	Porto Rico do Maranhão	2109056	MA	2022-03-28	1	\N	\N	\N	\N
600	Presidente Dutra	2109106	MA	2022-03-28	1	\N	\N	\N	\N
601	Presidente Juscelino	2109205	MA	2022-03-28	1	\N	\N	\N	\N
602	Presidente Médici	2109239	MA	2022-03-28	1	\N	\N	\N	\N
603	Presidente Sarney	2109270	MA	2022-03-28	1	\N	\N	\N	\N
604	Presidente Vargas	2109304	MA	2022-03-28	1	\N	\N	\N	\N
605	Primeira Cruz	2109403	MA	2022-03-28	1	\N	\N	\N	\N
606	Raposa	2109452	MA	2022-03-28	1	\N	\N	\N	\N
607	Riachão	2109502	MA	2022-03-28	1	\N	\N	\N	\N
608	Ribamar Fiquene	2109551	MA	2022-03-28	1	\N	\N	\N	\N
609	Rosário	2109601	MA	2022-03-28	1	\N	\N	\N	\N
610	Sambaíba	2109700	MA	2022-03-28	1	\N	\N	\N	\N
611	Santa Filomena do Maranhão	2109759	MA	2022-03-28	1	\N	\N	\N	\N
612	Santa Helena	2109809	MA	2022-03-28	1	\N	\N	\N	\N
613	Santa Inês	2109908	MA	2022-03-28	1	\N	\N	\N	\N
614	Santa Luzia	2110005	MA	2022-03-28	1	\N	\N	\N	\N
615	Santa Luzia do Paruá	2110039	MA	2022-03-28	1	\N	\N	\N	\N
616	Santa Quitéria do Maranhão	2110104	MA	2022-03-28	1	\N	\N	\N	\N
617	Santa Rita	2110203	MA	2022-03-28	1	\N	\N	\N	\N
618	Santana do Maranhão	2110237	MA	2022-03-28	1	\N	\N	\N	\N
619	Santo Amaro do Maranhão	2110278	MA	2022-03-28	1	\N	\N	\N	\N
620	Santo Antônio dos Lopes	2110302	MA	2022-03-28	1	\N	\N	\N	\N
621	São Benedito do Rio Preto	2110401	MA	2022-03-28	1	\N	\N	\N	\N
622	São Bento	2110500	MA	2022-03-28	1	\N	\N	\N	\N
623	São Bernardo	2110609	MA	2022-03-28	1	\N	\N	\N	\N
624	São Domingos do Azeitão	2110658	MA	2022-03-28	1	\N	\N	\N	\N
625	São Domingos do Maranhão	2110708	MA	2022-03-28	1	\N	\N	\N	\N
626	São Félix de Balsas	2110807	MA	2022-03-28	1	\N	\N	\N	\N
627	São Francisco do Brejão	2110856	MA	2022-03-28	1	\N	\N	\N	\N
628	São Francisco do Maranhão	2110906	MA	2022-03-28	1	\N	\N	\N	\N
629	São João Batista	2111003	MA	2022-03-28	1	\N	\N	\N	\N
630	São João do Carú	2111029	MA	2022-03-28	1	\N	\N	\N	\N
631	São João do Paraíso	2111052	MA	2022-03-28	1	\N	\N	\N	\N
632	São João do Soter	2111078	MA	2022-03-28	1	\N	\N	\N	\N
633	São João dos Patos	2111102	MA	2022-03-28	1	\N	\N	\N	\N
634	São José de Ribamar	2111201	MA	2022-03-28	1	\N	\N	\N	\N
635	São José dos Basílios	2111250	MA	2022-03-28	1	\N	\N	\N	\N
636	São Luís	2111300	MA	2022-03-28	1	\N	\N	\N	\N
637	São Luís Gonzaga do Maranhão	2111409	MA	2022-03-28	1	\N	\N	\N	\N
638	São Mateus do Maranhão	2111508	MA	2022-03-28	1	\N	\N	\N	\N
639	São Pedro da Água Branca	2111532	MA	2022-03-28	1	\N	\N	\N	\N
640	São Pedro dos Crentes	2111573	MA	2022-03-28	1	\N	\N	\N	\N
641	São Raimundo das Mangabeiras	2111607	MA	2022-03-28	1	\N	\N	\N	\N
642	São Raimundo do Doca Bezerra	2111631	MA	2022-03-28	1	\N	\N	\N	\N
643	São Roberto	2111672	MA	2022-03-28	1	\N	\N	\N	\N
644	São Vicente Ferrer	2111706	MA	2022-03-28	1	\N	\N	\N	\N
645	Satubinha	2111722	MA	2022-03-28	1	\N	\N	\N	\N
646	Senador Alexandre Costa	2111748	MA	2022-03-28	1	\N	\N	\N	\N
647	Senador La Rocque	2111763	MA	2022-03-28	1	\N	\N	\N	\N
648	Serrano do Maranhão	2111789	MA	2022-03-28	1	\N	\N	\N	\N
649	Sítio Novo	2111805	MA	2022-03-28	1	\N	\N	\N	\N
650	Sucupira do Norte	2111904	MA	2022-03-28	1	\N	\N	\N	\N
651	Sucupira do Riachão	2111953	MA	2022-03-28	1	\N	\N	\N	\N
652	Tasso Fragoso	2112001	MA	2022-03-28	1	\N	\N	\N	\N
653	Timbiras	2112100	MA	2022-03-28	1	\N	\N	\N	\N
654	Timon	2112209	MA	2022-03-28	1	\N	\N	\N	\N
655	Trizidela do Vale	2112233	MA	2022-03-28	1	\N	\N	\N	\N
656	Tufilândia	2112274	MA	2022-03-28	1	\N	\N	\N	\N
657	Tuntum	2112308	MA	2022-03-28	1	\N	\N	\N	\N
658	Turiaçu	2112407	MA	2022-03-28	1	\N	\N	\N	\N
659	Turilândia	2112456	MA	2022-03-28	1	\N	\N	\N	\N
660	Tutóia	2112506	MA	2022-03-28	1	\N	\N	\N	\N
661	Urbano Santos	2112605	MA	2022-03-28	1	\N	\N	\N	\N
662	Vargem Grande	2112704	MA	2022-03-28	1	\N	\N	\N	\N
663	Viana	2112803	MA	2022-03-28	1	\N	\N	\N	\N
664	Vila Nova dos Martírios	2112852	MA	2022-03-28	1	\N	\N	\N	\N
665	Vitória do Mearim	2112902	MA	2022-03-28	1	\N	\N	\N	\N
666	Vitorino Freire	2113009	MA	2022-03-28	1	\N	\N	\N	\N
667	Zé Doca	2114007	MA	2022-03-28	1	\N	\N	\N	\N
668	Acauã	2200053	PI	2022-03-28	1	\N	\N	\N	\N
669	Agricolândia	2200103	PI	2022-03-28	1	\N	\N	\N	\N
670	Água Branca	2200202	PI	2022-03-28	1	\N	\N	\N	\N
671	Alagoinha do Piauí	2200251	PI	2022-03-28	1	\N	\N	\N	\N
672	Alegrete do Piauí	2200277	PI	2022-03-28	1	\N	\N	\N	\N
673	Alto Longá	2200301	PI	2022-03-28	1	\N	\N	\N	\N
674	Altos	2200400	PI	2022-03-28	1	\N	\N	\N	\N
675	Alvorada do Gurguéia	2200459	PI	2022-03-28	1	\N	\N	\N	\N
676	Amarante	2200509	PI	2022-03-28	1	\N	\N	\N	\N
677	Angical do Piauí	2200608	PI	2022-03-28	1	\N	\N	\N	\N
678	Anísio de Abreu	2200707	PI	2022-03-28	1	\N	\N	\N	\N
679	Antônio Almeida	2200806	PI	2022-03-28	1	\N	\N	\N	\N
680	Aroazes	2200905	PI	2022-03-28	1	\N	\N	\N	\N
681	Aroeiras do Itaim	2200954	PI	2022-03-28	1	\N	\N	\N	\N
682	Arraial	2201002	PI	2022-03-28	1	\N	\N	\N	\N
683	Assunção do Piauí	2201051	PI	2022-03-28	1	\N	\N	\N	\N
684	Avelino Lopes	2201101	PI	2022-03-28	1	\N	\N	\N	\N
685	Baixa Grande do Ribeiro	2201150	PI	2022-03-28	1	\N	\N	\N	\N
686	'Barra D''Alcântara'	2201176	PI	2022-03-28	1	\N	\N	\N	\N
687	Barras	2201200	PI	2022-03-28	1	\N	\N	\N	\N
688	Barreiras do Piauí	2201309	PI	2022-03-28	1	\N	\N	\N	\N
689	Barro Duro	2201408	PI	2022-03-28	1	\N	\N	\N	\N
690	Batalha	2201507	PI	2022-03-28	1	\N	\N	\N	\N
691	Bela Vista do Piauí	2201556	PI	2022-03-28	1	\N	\N	\N	\N
692	Belém do Piauí	2201572	PI	2022-03-28	1	\N	\N	\N	\N
693	Beneditinos	2201606	PI	2022-03-28	1	\N	\N	\N	\N
694	Bertolínia	2201705	PI	2022-03-28	1	\N	\N	\N	\N
695	Betânia do Piauí	2201739	PI	2022-03-28	1	\N	\N	\N	\N
696	Boa Hora	2201770	PI	2022-03-28	1	\N	\N	\N	\N
697	Bocaina	2201804	PI	2022-03-28	1	\N	\N	\N	\N
698	Bom Jesus	2201903	PI	2022-03-28	1	\N	\N	\N	\N
699	Bom Princípio do Piauí	2201919	PI	2022-03-28	1	\N	\N	\N	\N
700	Bonfim do Piauí	2201929	PI	2022-03-28	1	\N	\N	\N	\N
701	Boqueirão do Piauí	2201945	PI	2022-03-28	1	\N	\N	\N	\N
702	Brasileira	2201960	PI	2022-03-28	1	\N	\N	\N	\N
703	Brejo do Piauí	2201988	PI	2022-03-28	1	\N	\N	\N	\N
704	Buriti dos Lopes	2202000	PI	2022-03-28	1	\N	\N	\N	\N
705	Buriti dos Montes	2202026	PI	2022-03-28	1	\N	\N	\N	\N
706	Cabeceiras do Piauí	2202059	PI	2022-03-28	1	\N	\N	\N	\N
707	Cajazeiras do Piauí	2202075	PI	2022-03-28	1	\N	\N	\N	\N
708	Cajueiro da Praia	2202083	PI	2022-03-28	1	\N	\N	\N	\N
709	Caldeirão Grande do Piauí	2202091	PI	2022-03-28	1	\N	\N	\N	\N
710	Campinas do Piauí	2202109	PI	2022-03-28	1	\N	\N	\N	\N
711	Campo Alegre do Fidalgo	2202117	PI	2022-03-28	1	\N	\N	\N	\N
712	Campo Grande do Piauí	2202133	PI	2022-03-28	1	\N	\N	\N	\N
713	Campo Largo do Piauí	2202174	PI	2022-03-28	1	\N	\N	\N	\N
714	Campo Maior	2202208	PI	2022-03-28	1	\N	\N	\N	\N
715	Canavieira	2202251	PI	2022-03-28	1	\N	\N	\N	\N
716	Canto do Buriti	2202307	PI	2022-03-28	1	\N	\N	\N	\N
717	Capitão de Campos	2202406	PI	2022-03-28	1	\N	\N	\N	\N
718	Capitão Gervásio Oliveira	2202455	PI	2022-03-28	1	\N	\N	\N	\N
719	Caracol	2202505	PI	2022-03-28	1	\N	\N	\N	\N
720	Caraúbas do Piauí	2202539	PI	2022-03-28	1	\N	\N	\N	\N
721	Caridade do Piauí	2202554	PI	2022-03-28	1	\N	\N	\N	\N
722	Castelo do Piauí	2202604	PI	2022-03-28	1	\N	\N	\N	\N
723	Caxingó	2202653	PI	2022-03-28	1	\N	\N	\N	\N
724	Cocal	2202703	PI	2022-03-28	1	\N	\N	\N	\N
725	Cocal de Telha	2202711	PI	2022-03-28	1	\N	\N	\N	\N
726	Cocal dos Alves	2202729	PI	2022-03-28	1	\N	\N	\N	\N
727	Coivaras	2202737	PI	2022-03-28	1	\N	\N	\N	\N
728	Colônia do Gurguéia	2202752	PI	2022-03-28	1	\N	\N	\N	\N
729	Colônia do Piauí	2202778	PI	2022-03-28	1	\N	\N	\N	\N
730	Conceição do Canindé	2202802	PI	2022-03-28	1	\N	\N	\N	\N
938	Choró	2303931	CE	2022-03-28	1	\N	\N	\N	\N
731	Coronel José Dias	2202851	PI	2022-03-28	1	\N	\N	\N	\N
732	Corrente	2202901	PI	2022-03-28	1	\N	\N	\N	\N
733	Cristalândia do Piauí	2203008	PI	2022-03-28	1	\N	\N	\N	\N
734	Cristino Castro	2203107	PI	2022-03-28	1	\N	\N	\N	\N
735	Curimatá	2203206	PI	2022-03-28	1	\N	\N	\N	\N
736	Currais	2203230	PI	2022-03-28	1	\N	\N	\N	\N
737	Curral Novo do Piauí	2203271	PI	2022-03-28	1	\N	\N	\N	\N
738	Curralinhos	2203255	PI	2022-03-28	1	\N	\N	\N	\N
739	Demerval Lobão	2203305	PI	2022-03-28	1	\N	\N	\N	\N
740	Dirceu Arcoverde	2203354	PI	2022-03-28	1	\N	\N	\N	\N
741	Dom Expedito Lopes	2203404	PI	2022-03-28	1	\N	\N	\N	\N
742	Dom Inocêncio	2203453	PI	2022-03-28	1	\N	\N	\N	\N
743	Domingos Mourão	2203420	PI	2022-03-28	1	\N	\N	\N	\N
744	Elesbão Veloso	2203503	PI	2022-03-28	1	\N	\N	\N	\N
745	Eliseu Martins	2203602	PI	2022-03-28	1	\N	\N	\N	\N
746	Esperantina	2203701	PI	2022-03-28	1	\N	\N	\N	\N
747	Fartura do Piauí	2203750	PI	2022-03-28	1	\N	\N	\N	\N
748	Flores do Piauí	2203800	PI	2022-03-28	1	\N	\N	\N	\N
749	Floresta do Piauí	2203859	PI	2022-03-28	1	\N	\N	\N	\N
750	Floriano	2203909	PI	2022-03-28	1	\N	\N	\N	\N
751	Francinópolis	2204006	PI	2022-03-28	1	\N	\N	\N	\N
752	Francisco Ayres	2204105	PI	2022-03-28	1	\N	\N	\N	\N
753	Francisco Macedo	2204154	PI	2022-03-28	1	\N	\N	\N	\N
754	Francisco Santos	2204204	PI	2022-03-28	1	\N	\N	\N	\N
755	Fronteiras	2204303	PI	2022-03-28	1	\N	\N	\N	\N
756	Geminiano	2204352	PI	2022-03-28	1	\N	\N	\N	\N
757	Gilbués	2204402	PI	2022-03-28	1	\N	\N	\N	\N
758	Guadalupe	2204501	PI	2022-03-28	1	\N	\N	\N	\N
759	Guaribas	2204550	PI	2022-03-28	1	\N	\N	\N	\N
760	Hugo Napoleão	2204600	PI	2022-03-28	1	\N	\N	\N	\N
761	Ilha Grande	2204659	PI	2022-03-28	1	\N	\N	\N	\N
762	Inhuma	2204709	PI	2022-03-28	1	\N	\N	\N	\N
763	Ipiranga do Piauí	2204808	PI	2022-03-28	1	\N	\N	\N	\N
764	Isaías Coelho	2204907	PI	2022-03-28	1	\N	\N	\N	\N
765	Itainópolis	2205003	PI	2022-03-28	1	\N	\N	\N	\N
766	Itaueira	2205102	PI	2022-03-28	1	\N	\N	\N	\N
767	Jacobina do Piauí	2205151	PI	2022-03-28	1	\N	\N	\N	\N
768	Jaicós	2205201	PI	2022-03-28	1	\N	\N	\N	\N
769	Jardim do Mulato	2205250	PI	2022-03-28	1	\N	\N	\N	\N
770	Jatobá do Piauí	2205276	PI	2022-03-28	1	\N	\N	\N	\N
771	Jerumenha	2205300	PI	2022-03-28	1	\N	\N	\N	\N
772	João Costa	2205359	PI	2022-03-28	1	\N	\N	\N	\N
773	Joaquim Pires	2205409	PI	2022-03-28	1	\N	\N	\N	\N
774	Joca Marques	2205458	PI	2022-03-28	1	\N	\N	\N	\N
775	José de Freitas	2205508	PI	2022-03-28	1	\N	\N	\N	\N
776	Juazeiro do Piauí	2205516	PI	2022-03-28	1	\N	\N	\N	\N
777	Júlio Borges	2205524	PI	2022-03-28	1	\N	\N	\N	\N
778	Jurema	2205532	PI	2022-03-28	1	\N	\N	\N	\N
779	Lagoa Alegre	2205557	PI	2022-03-28	1	\N	\N	\N	\N
780	Lagoa de São Francisco	2205573	PI	2022-03-28	1	\N	\N	\N	\N
781	Lagoa do Barro do Piauí	2205565	PI	2022-03-28	1	\N	\N	\N	\N
782	Lagoa do Piauí	2205581	PI	2022-03-28	1	\N	\N	\N	\N
783	Lagoa do Sítio	2205599	PI	2022-03-28	1	\N	\N	\N	\N
784	Lagoinha do Piauí	2205540	PI	2022-03-28	1	\N	\N	\N	\N
785	Landri Sales	2205607	PI	2022-03-28	1	\N	\N	\N	\N
786	Luís Correia	2205706	PI	2022-03-28	1	\N	\N	\N	\N
787	Luzilândia	2205805	PI	2022-03-28	1	\N	\N	\N	\N
788	Madeiro	2205854	PI	2022-03-28	1	\N	\N	\N	\N
789	Manoel Emídio	2205904	PI	2022-03-28	1	\N	\N	\N	\N
790	Marcolândia	2205953	PI	2022-03-28	1	\N	\N	\N	\N
791	Marcos Parente	2206001	PI	2022-03-28	1	\N	\N	\N	\N
792	Massapê do Piauí	2206050	PI	2022-03-28	1	\N	\N	\N	\N
793	Matias Olímpio	2206100	PI	2022-03-28	1	\N	\N	\N	\N
794	Miguel Alves	2206209	PI	2022-03-28	1	\N	\N	\N	\N
795	Miguel Leão	2206308	PI	2022-03-28	1	\N	\N	\N	\N
796	Milton Brandão	2206357	PI	2022-03-28	1	\N	\N	\N	\N
797	Monsenhor Gil	2206407	PI	2022-03-28	1	\N	\N	\N	\N
798	Monsenhor Hipólito	2206506	PI	2022-03-28	1	\N	\N	\N	\N
799	Monte Alegre do Piauí	2206605	PI	2022-03-28	1	\N	\N	\N	\N
800	Morro Cabeça no Tempo	2206654	PI	2022-03-28	1	\N	\N	\N	\N
801	Morro do Chapéu do Piauí	2206670	PI	2022-03-28	1	\N	\N	\N	\N
802	Murici dos Portelas	2206696	PI	2022-03-28	1	\N	\N	\N	\N
803	Nazaré do Piauí	2206704	PI	2022-03-28	1	\N	\N	\N	\N
804	Nazária	2206720	PI	2022-03-28	1	\N	\N	\N	\N
805	Nossa Senhora de Nazaré	2206753	PI	2022-03-28	1	\N	\N	\N	\N
806	Nossa Senhora dos Remédios	2206803	PI	2022-03-28	1	\N	\N	\N	\N
807	Nova Santa Rita	2207959	PI	2022-03-28	1	\N	\N	\N	\N
808	Novo Oriente do Piauí	2206902	PI	2022-03-28	1	\N	\N	\N	\N
809	Novo Santo Antônio	2206951	PI	2022-03-28	1	\N	\N	\N	\N
810	Oeiras	2207009	PI	2022-03-28	1	\N	\N	\N	\N
811	'Olho D''Água do Piauí'	2207108	PI	2022-03-28	1	\N	\N	\N	\N
812	Padre Marcos	2207207	PI	2022-03-28	1	\N	\N	\N	\N
813	Paes Landim	2207306	PI	2022-03-28	1	\N	\N	\N	\N
814	Pajeú do Piauí	2207355	PI	2022-03-28	1	\N	\N	\N	\N
815	Palmeira do Piauí	2207405	PI	2022-03-28	1	\N	\N	\N	\N
816	Palmeirais	2207504	PI	2022-03-28	1	\N	\N	\N	\N
817	Paquetá	2207553	PI	2022-03-28	1	\N	\N	\N	\N
818	Parnaguá	2207603	PI	2022-03-28	1	\N	\N	\N	\N
819	Parnaíba	2207702	PI	2022-03-28	1	\N	\N	\N	\N
820	Passagem Franca do Piauí	2207751	PI	2022-03-28	1	\N	\N	\N	\N
821	Patos do Piauí	2207777	PI	2022-03-28	1	\N	\N	\N	\N
822	'Pau D''Arco do Piauí'	2207793	PI	2022-03-28	1	\N	\N	\N	\N
823	Paulistana	2207801	PI	2022-03-28	1	\N	\N	\N	\N
824	Pavussu	2207850	PI	2022-03-28	1	\N	\N	\N	\N
825	Pedro II	2207900	PI	2022-03-28	1	\N	\N	\N	\N
826	Pedro Laurentino	2207934	PI	2022-03-28	1	\N	\N	\N	\N
827	Picos	2208007	PI	2022-03-28	1	\N	\N	\N	\N
828	Pimenteiras	2208106	PI	2022-03-28	1	\N	\N	\N	\N
829	Pio IX	2208205	PI	2022-03-28	1	\N	\N	\N	\N
830	Piracuruca	2208304	PI	2022-03-28	1	\N	\N	\N	\N
831	Piripiri	2208403	PI	2022-03-28	1	\N	\N	\N	\N
832	Porto	2208502	PI	2022-03-28	1	\N	\N	\N	\N
833	Porto Alegre do Piauí	2208551	PI	2022-03-28	1	\N	\N	\N	\N
1156	Martins	2407401	RN	2022-03-28	1	\N	\N	\N	\N
834	Prata do Piauí	2208601	PI	2022-03-28	1	\N	\N	\N	\N
835	Queimada Nova	2208650	PI	2022-03-28	1	\N	\N	\N	\N
836	Redenção do Gurguéia	2208700	PI	2022-03-28	1	\N	\N	\N	\N
837	Regeneração	2208809	PI	2022-03-28	1	\N	\N	\N	\N
838	Riacho Frio	2208858	PI	2022-03-28	1	\N	\N	\N	\N
839	Ribeira do Piauí	2208874	PI	2022-03-28	1	\N	\N	\N	\N
840	Ribeiro Gonçalves	2208908	PI	2022-03-28	1	\N	\N	\N	\N
841	Rio Grande do Piauí	2209005	PI	2022-03-28	1	\N	\N	\N	\N
842	Santa Cruz do Piauí	2209104	PI	2022-03-28	1	\N	\N	\N	\N
843	Santa Cruz dos Milagres	2209153	PI	2022-03-28	1	\N	\N	\N	\N
844	Santa Filomena	2209203	PI	2022-03-28	1	\N	\N	\N	\N
845	Santa Luz	2209302	PI	2022-03-28	1	\N	\N	\N	\N
846	Santa Rosa do Piauí	2209377	PI	2022-03-28	1	\N	\N	\N	\N
847	Santana do Piauí	2209351	PI	2022-03-28	1	\N	\N	\N	\N
848	Santo Antônio de Lisboa	2209401	PI	2022-03-28	1	\N	\N	\N	\N
849	Santo Antônio dos Milagres	2209450	PI	2022-03-28	1	\N	\N	\N	\N
850	Santo Inácio do Piauí	2209500	PI	2022-03-28	1	\N	\N	\N	\N
851	São Braz do Piauí	2209559	PI	2022-03-28	1	\N	\N	\N	\N
852	São Félix do Piauí	2209609	PI	2022-03-28	1	\N	\N	\N	\N
853	São Francisco de Assis do Piauí	2209658	PI	2022-03-28	1	\N	\N	\N	\N
854	São Francisco do Piauí	2209708	PI	2022-03-28	1	\N	\N	\N	\N
855	São Gonçalo do Gurguéia	2209757	PI	2022-03-28	1	\N	\N	\N	\N
856	São Gonçalo do Piauí	2209807	PI	2022-03-28	1	\N	\N	\N	\N
857	São João da Canabrava	2209856	PI	2022-03-28	1	\N	\N	\N	\N
858	São João da Fronteira	2209872	PI	2022-03-28	1	\N	\N	\N	\N
859	São João da Serra	2209906	PI	2022-03-28	1	\N	\N	\N	\N
860	São João da Varjota	2209955	PI	2022-03-28	1	\N	\N	\N	\N
861	São João do Arraial	2209971	PI	2022-03-28	1	\N	\N	\N	\N
862	São João do Piauí	2210003	PI	2022-03-28	1	\N	\N	\N	\N
863	São José do Divino	2210052	PI	2022-03-28	1	\N	\N	\N	\N
864	São José do Peixe	2210102	PI	2022-03-28	1	\N	\N	\N	\N
865	São José do Piauí	2210201	PI	2022-03-28	1	\N	\N	\N	\N
866	São Julião	2210300	PI	2022-03-28	1	\N	\N	\N	\N
867	São Lourenço do Piauí	2210359	PI	2022-03-28	1	\N	\N	\N	\N
868	São Luis do Piauí	2210375	PI	2022-03-28	1	\N	\N	\N	\N
869	São Miguel da Baixa Grande	2210383	PI	2022-03-28	1	\N	\N	\N	\N
870	São Miguel do Fidalgo	2210391	PI	2022-03-28	1	\N	\N	\N	\N
871	São Miguel do Tapuio	2210409	PI	2022-03-28	1	\N	\N	\N	\N
872	São Pedro do Piauí	2210508	PI	2022-03-28	1	\N	\N	\N	\N
873	São Raimundo Nonato	2210607	PI	2022-03-28	1	\N	\N	\N	\N
874	Sebastião Barros	2210623	PI	2022-03-28	1	\N	\N	\N	\N
875	Sebastião Leal	2210631	PI	2022-03-28	1	\N	\N	\N	\N
876	Sigefredo Pacheco	2210656	PI	2022-03-28	1	\N	\N	\N	\N
877	Simões	2210706	PI	2022-03-28	1	\N	\N	\N	\N
878	Simplício Mendes	2210805	PI	2022-03-28	1	\N	\N	\N	\N
879	Socorro do Piauí	2210904	PI	2022-03-28	1	\N	\N	\N	\N
880	Sussuapara	2210938	PI	2022-03-28	1	\N	\N	\N	\N
881	Tamboril do Piauí	2210953	PI	2022-03-28	1	\N	\N	\N	\N
882	Tanque do Piauí	2210979	PI	2022-03-28	1	\N	\N	\N	\N
883	Teresina	2211001	PI	2022-03-28	1	\N	\N	\N	\N
884	União	2211100	PI	2022-03-28	1	\N	\N	\N	\N
885	Uruçuí	2211209	PI	2022-03-28	1	\N	\N	\N	\N
886	Valença do Piauí	2211308	PI	2022-03-28	1	\N	\N	\N	\N
887	Várzea Branca	2211357	PI	2022-03-28	1	\N	\N	\N	\N
888	Várzea Grande	2211407	PI	2022-03-28	1	\N	\N	\N	\N
889	Vera Mendes	2211506	PI	2022-03-28	1	\N	\N	\N	\N
890	Vila Nova do Piauí	2211605	PI	2022-03-28	1	\N	\N	\N	\N
891	Wall Ferraz	2211704	PI	2022-03-28	1	\N	\N	\N	\N
892	Abaiara	2300101	CE	2022-03-28	1	\N	\N	\N	\N
893	Acarape	2300150	CE	2022-03-28	1	\N	\N	\N	\N
894	Acaraú	2300200	CE	2022-03-28	1	\N	\N	\N	\N
895	Acopiara	2300309	CE	2022-03-28	1	\N	\N	\N	\N
896	Aiuaba	2300408	CE	2022-03-28	1	\N	\N	\N	\N
897	Alcântaras	2300507	CE	2022-03-28	1	\N	\N	\N	\N
898	Altaneira	2300606	CE	2022-03-28	1	\N	\N	\N	\N
899	Alto Santo	2300705	CE	2022-03-28	1	\N	\N	\N	\N
900	Amontada	2300754	CE	2022-03-28	1	\N	\N	\N	\N
901	Antonina do Norte	2300804	CE	2022-03-28	1	\N	\N	\N	\N
902	Apuiarés	2300903	CE	2022-03-28	1	\N	\N	\N	\N
903	Aquiraz	2301000	CE	2022-03-28	1	\N	\N	\N	\N
904	Aracati	2301109	CE	2022-03-28	1	\N	\N	\N	\N
905	Aracoiaba	2301208	CE	2022-03-28	1	\N	\N	\N	\N
906	Ararendá	2301257	CE	2022-03-28	1	\N	\N	\N	\N
907	Araripe	2301307	CE	2022-03-28	1	\N	\N	\N	\N
908	Aratuba	2301406	CE	2022-03-28	1	\N	\N	\N	\N
909	Arneiroz	2301505	CE	2022-03-28	1	\N	\N	\N	\N
910	Assaré	2301604	CE	2022-03-28	1	\N	\N	\N	\N
911	Aurora	2301703	CE	2022-03-28	1	\N	\N	\N	\N
912	Baixio	2301802	CE	2022-03-28	1	\N	\N	\N	\N
913	Banabuiú	2301851	CE	2022-03-28	1	\N	\N	\N	\N
914	Barbalha	2301901	CE	2022-03-28	1	\N	\N	\N	\N
915	Barreira	2301950	CE	2022-03-28	1	\N	\N	\N	\N
916	Barro	2302008	CE	2022-03-28	1	\N	\N	\N	\N
917	Barroquinha	2302057	CE	2022-03-28	1	\N	\N	\N	\N
918	Baturité	2302107	CE	2022-03-28	1	\N	\N	\N	\N
919	Beberibe	2302206	CE	2022-03-28	1	\N	\N	\N	\N
920	Bela Cruz	2302305	CE	2022-03-28	1	\N	\N	\N	\N
921	Boa Viagem	2302404	CE	2022-03-28	1	\N	\N	\N	\N
922	Brejo Santo	2302503	CE	2022-03-28	1	\N	\N	\N	\N
923	Camocim	2302602	CE	2022-03-28	1	\N	\N	\N	\N
924	Campos Sales	2302701	CE	2022-03-28	1	\N	\N	\N	\N
925	Canindé	2302800	CE	2022-03-28	1	\N	\N	\N	\N
926	Capistrano	2302909	CE	2022-03-28	1	\N	\N	\N	\N
927	Caridade	2303006	CE	2022-03-28	1	\N	\N	\N	\N
928	Cariré	2303105	CE	2022-03-28	1	\N	\N	\N	\N
929	Caririaçu	2303204	CE	2022-03-28	1	\N	\N	\N	\N
930	Cariús	2303303	CE	2022-03-28	1	\N	\N	\N	\N
931	Carnaubal	2303402	CE	2022-03-28	1	\N	\N	\N	\N
932	Cascavel	2303501	CE	2022-03-28	1	\N	\N	\N	\N
933	Catarina	2303600	CE	2022-03-28	1	\N	\N	\N	\N
934	Catunda	2303659	CE	2022-03-28	1	\N	\N	\N	\N
935	Caucaia	2303709	CE	2022-03-28	1	\N	\N	\N	\N
936	Cedro	2303808	CE	2022-03-28	1	\N	\N	\N	\N
937	Chaval	2303907	CE	2022-03-28	1	\N	\N	\N	\N
939	Chorozinho	2303956	CE	2022-03-28	1	\N	\N	\N	\N
940	Coreaú	2304004	CE	2022-03-28	1	\N	\N	\N	\N
941	Crateús	2304103	CE	2022-03-28	1	\N	\N	\N	\N
942	Crato	2304202	CE	2022-03-28	1	\N	\N	\N	\N
943	Croatá	2304236	CE	2022-03-28	1	\N	\N	\N	\N
944	Cruz	2304251	CE	2022-03-28	1	\N	\N	\N	\N
945	Deputado Irapuan Pinheiro	2304269	CE	2022-03-28	1	\N	\N	\N	\N
946	Ereré	2304277	CE	2022-03-28	1	\N	\N	\N	\N
947	Eusébio	2304285	CE	2022-03-28	1	\N	\N	\N	\N
948	Farias Brito	2304301	CE	2022-03-28	1	\N	\N	\N	\N
949	Forquilha	2304350	CE	2022-03-28	1	\N	\N	\N	\N
950	Fortaleza	2304400	CE	2022-03-28	1	\N	\N	\N	\N
951	Fortim	2304459	CE	2022-03-28	1	\N	\N	\N	\N
952	Frecheirinha	2304509	CE	2022-03-28	1	\N	\N	\N	\N
953	General Sampaio	2304608	CE	2022-03-28	1	\N	\N	\N	\N
954	Graça	2304657	CE	2022-03-28	1	\N	\N	\N	\N
955	Granja	2304707	CE	2022-03-28	1	\N	\N	\N	\N
956	Granjeiro	2304806	CE	2022-03-28	1	\N	\N	\N	\N
957	Groaíras	2304905	CE	2022-03-28	1	\N	\N	\N	\N
958	Guaiúba	2304954	CE	2022-03-28	1	\N	\N	\N	\N
959	Guaraciaba do Norte	2305001	CE	2022-03-28	1	\N	\N	\N	\N
960	Guaramiranga	2305100	CE	2022-03-28	1	\N	\N	\N	\N
961	Hidrolândia	2305209	CE	2022-03-28	1	\N	\N	\N	\N
962	Horizonte	2305233	CE	2022-03-28	1	\N	\N	\N	\N
963	Ibaretama	2305266	CE	2022-03-28	1	\N	\N	\N	\N
964	Ibiapina	2305308	CE	2022-03-28	1	\N	\N	\N	\N
965	Ibicuitinga	2305332	CE	2022-03-28	1	\N	\N	\N	\N
966	Icapuí	2305357	CE	2022-03-28	1	\N	\N	\N	\N
967	Icó	2305407	CE	2022-03-28	1	\N	\N	\N	\N
968	Iguatu	2305506	CE	2022-03-28	1	\N	\N	\N	\N
969	Independência	2305605	CE	2022-03-28	1	\N	\N	\N	\N
970	Ipaporanga	2305654	CE	2022-03-28	1	\N	\N	\N	\N
971	Ipaumirim	2305704	CE	2022-03-28	1	\N	\N	\N	\N
972	Ipu	2305803	CE	2022-03-28	1	\N	\N	\N	\N
973	Ipueiras	2305902	CE	2022-03-28	1	\N	\N	\N	\N
974	Iracema	2306009	CE	2022-03-28	1	\N	\N	\N	\N
975	Irauçuba	2306108	CE	2022-03-28	1	\N	\N	\N	\N
976	Itaiçaba	2306207	CE	2022-03-28	1	\N	\N	\N	\N
977	Itaitinga	2306256	CE	2022-03-28	1	\N	\N	\N	\N
978	Itapajé	2306306	CE	2022-03-28	1	\N	\N	\N	\N
979	Itapipoca	2306405	CE	2022-03-28	1	\N	\N	\N	\N
980	Itapiúna	2306504	CE	2022-03-28	1	\N	\N	\N	\N
981	Itarema	2306553	CE	2022-03-28	1	\N	\N	\N	\N
982	Itatira	2306603	CE	2022-03-28	1	\N	\N	\N	\N
983	Jaguaretama	2306702	CE	2022-03-28	1	\N	\N	\N	\N
984	Jaguaribara	2306801	CE	2022-03-28	1	\N	\N	\N	\N
985	Jaguaribe	2306900	CE	2022-03-28	1	\N	\N	\N	\N
986	Jaguaruana	2307007	CE	2022-03-28	1	\N	\N	\N	\N
987	Jardim	2307106	CE	2022-03-28	1	\N	\N	\N	\N
988	Jati	2307205	CE	2022-03-28	1	\N	\N	\N	\N
989	Jijoca de Jericoacoara	2307254	CE	2022-03-28	1	\N	\N	\N	\N
990	Juazeiro do Norte	2307304	CE	2022-03-28	1	\N	\N	\N	\N
991	Jucás	2307403	CE	2022-03-28	1	\N	\N	\N	\N
992	Lavras da Mangabeira	2307502	CE	2022-03-28	1	\N	\N	\N	\N
993	Limoeiro do Norte	2307601	CE	2022-03-28	1	\N	\N	\N	\N
994	Madalena	2307635	CE	2022-03-28	1	\N	\N	\N	\N
995	Maracanaú	2307650	CE	2022-03-28	1	\N	\N	\N	\N
996	Maranguape	2307700	CE	2022-03-28	1	\N	\N	\N	\N
997	Marco	2307809	CE	2022-03-28	1	\N	\N	\N	\N
998	Martinópole	2307908	CE	2022-03-28	1	\N	\N	\N	\N
999	Massapê	2308005	CE	2022-03-28	1	\N	\N	\N	\N
1000	Mauriti	2308104	CE	2022-03-28	1	\N	\N	\N	\N
1001	Meruoca	2308203	CE	2022-03-28	1	\N	\N	\N	\N
1002	Milagres	2308302	CE	2022-03-28	1	\N	\N	\N	\N
1003	Milhã	2308351	CE	2022-03-28	1	\N	\N	\N	\N
1004	Miraíma	2308377	CE	2022-03-28	1	\N	\N	\N	\N
1005	Missão Velha	2308401	CE	2022-03-28	1	\N	\N	\N	\N
1006	Mombaça	2308500	CE	2022-03-28	1	\N	\N	\N	\N
1007	Monsenhor Tabosa	2308609	CE	2022-03-28	1	\N	\N	\N	\N
1008	Morada Nova	2308708	CE	2022-03-28	1	\N	\N	\N	\N
1009	Moraújo	2308807	CE	2022-03-28	1	\N	\N	\N	\N
1010	Morrinhos	2308906	CE	2022-03-28	1	\N	\N	\N	\N
1011	Mucambo	2309003	CE	2022-03-28	1	\N	\N	\N	\N
1012	Mulungu	2309102	CE	2022-03-28	1	\N	\N	\N	\N
1013	Nova Olinda	2309201	CE	2022-03-28	1	\N	\N	\N	\N
1014	Nova Russas	2309300	CE	2022-03-28	1	\N	\N	\N	\N
1015	Novo Oriente	2309409	CE	2022-03-28	1	\N	\N	\N	\N
1016	Ocara	2309458	CE	2022-03-28	1	\N	\N	\N	\N
1017	Orós	2309508	CE	2022-03-28	1	\N	\N	\N	\N
1018	Pacajus	2309607	CE	2022-03-28	1	\N	\N	\N	\N
1019	Pacatuba	2309706	CE	2022-03-28	1	\N	\N	\N	\N
1020	Pacoti	2309805	CE	2022-03-28	1	\N	\N	\N	\N
1021	Pacujá	2309904	CE	2022-03-28	1	\N	\N	\N	\N
1022	Palhano	2310001	CE	2022-03-28	1	\N	\N	\N	\N
1023	Palmácia	2310100	CE	2022-03-28	1	\N	\N	\N	\N
1024	Paracuru	2310209	CE	2022-03-28	1	\N	\N	\N	\N
1025	Paraipaba	2310258	CE	2022-03-28	1	\N	\N	\N	\N
1026	Parambu	2310308	CE	2022-03-28	1	\N	\N	\N	\N
1027	Paramoti	2310407	CE	2022-03-28	1	\N	\N	\N	\N
1028	Pedra Branca	2310506	CE	2022-03-28	1	\N	\N	\N	\N
1029	Penaforte	2310605	CE	2022-03-28	1	\N	\N	\N	\N
1030	Pentecoste	2310704	CE	2022-03-28	1	\N	\N	\N	\N
1031	Pereiro	2310803	CE	2022-03-28	1	\N	\N	\N	\N
1032	Pindoretama	2310852	CE	2022-03-28	1	\N	\N	\N	\N
1033	Piquet Carneiro	2310902	CE	2022-03-28	1	\N	\N	\N	\N
1034	Pires Ferreira	2310951	CE	2022-03-28	1	\N	\N	\N	\N
1035	Poranga	2311009	CE	2022-03-28	1	\N	\N	\N	\N
1036	Porteiras	2311108	CE	2022-03-28	1	\N	\N	\N	\N
1037	Potengi	2311207	CE	2022-03-28	1	\N	\N	\N	\N
1038	Potiretama	2311231	CE	2022-03-28	1	\N	\N	\N	\N
1039	Quiterianópolis	2311264	CE	2022-03-28	1	\N	\N	\N	\N
1040	Quixadá	2311306	CE	2022-03-28	1	\N	\N	\N	\N
1041	Quixelô	2311355	CE	2022-03-28	1	\N	\N	\N	\N
1042	Quixeramobim	2311405	CE	2022-03-28	1	\N	\N	\N	\N
1043	Quixeré	2311504	CE	2022-03-28	1	\N	\N	\N	\N
1044	Redenção	2311603	CE	2022-03-28	1	\N	\N	\N	\N
1045	Reriutaba	2311702	CE	2022-03-28	1	\N	\N	\N	\N
1046	Russas	2311801	CE	2022-03-28	1	\N	\N	\N	\N
1047	Saboeiro	2311900	CE	2022-03-28	1	\N	\N	\N	\N
1048	Salitre	2311959	CE	2022-03-28	1	\N	\N	\N	\N
1049	Santa Quitéria	2312205	CE	2022-03-28	1	\N	\N	\N	\N
1050	Santana do Acaraú	2312007	CE	2022-03-28	1	\N	\N	\N	\N
1051	Santana do Cariri	2312106	CE	2022-03-28	1	\N	\N	\N	\N
1052	São Benedito	2312304	CE	2022-03-28	1	\N	\N	\N	\N
1053	São Gonçalo do Amarante	2312403	CE	2022-03-28	1	\N	\N	\N	\N
1054	São João do Jaguaribe	2312502	CE	2022-03-28	1	\N	\N	\N	\N
1055	São Luís do Curu	2312601	CE	2022-03-28	1	\N	\N	\N	\N
1056	Senador Pompeu	2312700	CE	2022-03-28	1	\N	\N	\N	\N
1057	Senador Sá	2312809	CE	2022-03-28	1	\N	\N	\N	\N
1058	Sobral	2312908	CE	2022-03-28	1	\N	\N	\N	\N
1059	Solonópole	2313005	CE	2022-03-28	1	\N	\N	\N	\N
1060	Tabuleiro do Norte	2313104	CE	2022-03-28	1	\N	\N	\N	\N
1061	Tamboril	2313203	CE	2022-03-28	1	\N	\N	\N	\N
1062	Tarrafas	2313252	CE	2022-03-28	1	\N	\N	\N	\N
1063	Tauá	2313302	CE	2022-03-28	1	\N	\N	\N	\N
1064	Tejuçuoca	2313351	CE	2022-03-28	1	\N	\N	\N	\N
1065	Tianguá	2313401	CE	2022-03-28	1	\N	\N	\N	\N
1066	Trairi	2313500	CE	2022-03-28	1	\N	\N	\N	\N
1067	Tururu	2313559	CE	2022-03-28	1	\N	\N	\N	\N
1068	Ubajara	2313609	CE	2022-03-28	1	\N	\N	\N	\N
1069	Umari	2313708	CE	2022-03-28	1	\N	\N	\N	\N
1070	Umirim	2313757	CE	2022-03-28	1	\N	\N	\N	\N
1071	Uruburetama	2313807	CE	2022-03-28	1	\N	\N	\N	\N
1072	Uruoca	2313906	CE	2022-03-28	1	\N	\N	\N	\N
1073	Varjota	2313955	CE	2022-03-28	1	\N	\N	\N	\N
1074	Várzea Alegre	2314003	CE	2022-03-28	1	\N	\N	\N	\N
1075	Viçosa do Ceará	2314102	CE	2022-03-28	1	\N	\N	\N	\N
1076	Acari	2400109	RN	2022-03-28	1	\N	\N	\N	\N
1077	Açu	2400208	RN	2022-03-28	1	\N	\N	\N	\N
1078	Afonso Bezerra	2400307	RN	2022-03-28	1	\N	\N	\N	\N
1079	Água Nova	2400406	RN	2022-03-28	1	\N	\N	\N	\N
1080	Alexandria	2400505	RN	2022-03-28	1	\N	\N	\N	\N
1081	Almino Afonso	2400604	RN	2022-03-28	1	\N	\N	\N	\N
1082	Alto do Rodrigues	2400703	RN	2022-03-28	1	\N	\N	\N	\N
1083	Angicos	2400802	RN	2022-03-28	1	\N	\N	\N	\N
1084	Antônio Martins	2400901	RN	2022-03-28	1	\N	\N	\N	\N
1085	Apodi	2401008	RN	2022-03-28	1	\N	\N	\N	\N
1086	Areia Branca	2401107	RN	2022-03-28	1	\N	\N	\N	\N
1087	Arês	2401206	RN	2022-03-28	1	\N	\N	\N	\N
1088	Baía Formosa	2401404	RN	2022-03-28	1	\N	\N	\N	\N
1089	Baraúna	2401453	RN	2022-03-28	1	\N	\N	\N	\N
1090	Barcelona	2401503	RN	2022-03-28	1	\N	\N	\N	\N
1091	Bento Fernandes	2401602	RN	2022-03-28	1	\N	\N	\N	\N
1092	Bodó	2401651	RN	2022-03-28	1	\N	\N	\N	\N
1093	Bom Jesus	2401701	RN	2022-03-28	1	\N	\N	\N	\N
1094	Brejinho	2401800	RN	2022-03-28	1	\N	\N	\N	\N
1095	Caiçara do Norte	2401859	RN	2022-03-28	1	\N	\N	\N	\N
1096	Caiçara do Rio do Vento	2401909	RN	2022-03-28	1	\N	\N	\N	\N
1097	Caicó	2402006	RN	2022-03-28	1	\N	\N	\N	\N
1098	Campo Grande	2401305	RN	2022-03-28	1	\N	\N	\N	\N
1099	Campo Redondo	2402105	RN	2022-03-28	1	\N	\N	\N	\N
1100	Canguaretama	2402204	RN	2022-03-28	1	\N	\N	\N	\N
1101	Caraúbas	2402303	RN	2022-03-28	1	\N	\N	\N	\N
1102	Carnaúba dos Dantas	2402402	RN	2022-03-28	1	\N	\N	\N	\N
1103	Carnaubais	2402501	RN	2022-03-28	1	\N	\N	\N	\N
1104	Ceará-Mirim	2402600	RN	2022-03-28	1	\N	\N	\N	\N
1105	Cerro Corá	2402709	RN	2022-03-28	1	\N	\N	\N	\N
1106	Coronel Ezequiel	2402808	RN	2022-03-28	1	\N	\N	\N	\N
1107	Coronel João Pessoa	2402907	RN	2022-03-28	1	\N	\N	\N	\N
1108	Cruzeta	2403004	RN	2022-03-28	1	\N	\N	\N	\N
1109	Currais Novos	2403103	RN	2022-03-28	1	\N	\N	\N	\N
1110	Doutor Severiano	2403202	RN	2022-03-28	1	\N	\N	\N	\N
1111	Encanto	2403301	RN	2022-03-28	1	\N	\N	\N	\N
1112	Equador	2403400	RN	2022-03-28	1	\N	\N	\N	\N
1113	Espírito Santo	2403509	RN	2022-03-28	1	\N	\N	\N	\N
1114	Extremoz	2403608	RN	2022-03-28	1	\N	\N	\N	\N
1115	Felipe Guerra	2403707	RN	2022-03-28	1	\N	\N	\N	\N
1116	Fernando Pedroza	2403756	RN	2022-03-28	1	\N	\N	\N	\N
1117	Florânia	2403806	RN	2022-03-28	1	\N	\N	\N	\N
1118	Francisco Dantas	2403905	RN	2022-03-28	1	\N	\N	\N	\N
1119	Frutuoso Gomes	2404002	RN	2022-03-28	1	\N	\N	\N	\N
1120	Galinhos	2404101	RN	2022-03-28	1	\N	\N	\N	\N
1121	Goianinha	2404200	RN	2022-03-28	1	\N	\N	\N	\N
1122	Governador Dix-Sept Rosado	2404309	RN	2022-03-28	1	\N	\N	\N	\N
1123	Grossos	2404408	RN	2022-03-28	1	\N	\N	\N	\N
1124	Guamaré	2404507	RN	2022-03-28	1	\N	\N	\N	\N
1125	Ielmo Marinho	2404606	RN	2022-03-28	1	\N	\N	\N	\N
1126	Ipanguaçu	2404705	RN	2022-03-28	1	\N	\N	\N	\N
1127	Ipueira	2404804	RN	2022-03-28	1	\N	\N	\N	\N
1128	Itajá	2404853	RN	2022-03-28	1	\N	\N	\N	\N
1129	Itaú	2404903	RN	2022-03-28	1	\N	\N	\N	\N
1130	Jaçanã	2405009	RN	2022-03-28	1	\N	\N	\N	\N
1131	Jandaíra	2405108	RN	2022-03-28	1	\N	\N	\N	\N
1132	Janduís	2405207	RN	2022-03-28	1	\N	\N	\N	\N
1133	Januário Cicco	2405306	RN	2022-03-28	1	\N	\N	\N	\N
1134	Japi	2405405	RN	2022-03-28	1	\N	\N	\N	\N
1135	Jardim de Angicos	2405504	RN	2022-03-28	1	\N	\N	\N	\N
1136	Jardim de Piranhas	2405603	RN	2022-03-28	1	\N	\N	\N	\N
1137	Jardim do Seridó	2405702	RN	2022-03-28	1	\N	\N	\N	\N
1138	João Câmara	2405801	RN	2022-03-28	1	\N	\N	\N	\N
1139	João Dias	2405900	RN	2022-03-28	1	\N	\N	\N	\N
1140	José da Penha	2406007	RN	2022-03-28	1	\N	\N	\N	\N
1141	Jucurutu	2406106	RN	2022-03-28	1	\N	\N	\N	\N
1142	Jundiá	2406155	RN	2022-03-28	1	\N	\N	\N	\N
1143	'Lagoa d''Anta'	2406205	RN	2022-03-28	1	\N	\N	\N	\N
1144	Lagoa de Pedras	2406304	RN	2022-03-28	1	\N	\N	\N	\N
1145	Lagoa de Velhos	2406403	RN	2022-03-28	1	\N	\N	\N	\N
1146	Lagoa Nova	2406502	RN	2022-03-28	1	\N	\N	\N	\N
1147	Lagoa Salgada	2406601	RN	2022-03-28	1	\N	\N	\N	\N
1148	Lajes	2406700	RN	2022-03-28	1	\N	\N	\N	\N
1149	Lajes Pintadas	2406809	RN	2022-03-28	1	\N	\N	\N	\N
1150	Lucrécia	2406908	RN	2022-03-28	1	\N	\N	\N	\N
1151	Luís Gomes	2407005	RN	2022-03-28	1	\N	\N	\N	\N
1152	Macaíba	2407104	RN	2022-03-28	1	\N	\N	\N	\N
1153	Macau	2407203	RN	2022-03-28	1	\N	\N	\N	\N
1154	Major Sales	2407252	RN	2022-03-28	1	\N	\N	\N	\N
1155	Marcelino Vieira	2407302	RN	2022-03-28	1	\N	\N	\N	\N
1157	Maxaranguape	2407500	RN	2022-03-28	1	\N	\N	\N	\N
1158	Messias Targino	2407609	RN	2022-03-28	1	\N	\N	\N	\N
1159	Montanhas	2407708	RN	2022-03-28	1	\N	\N	\N	\N
1160	Monte Alegre	2407807	RN	2022-03-28	1	\N	\N	\N	\N
1161	Monte das Gameleiras	2407906	RN	2022-03-28	1	\N	\N	\N	\N
1162	Mossoró	2408003	RN	2022-03-28	1	\N	\N	\N	\N
1163	Natal	2408102	RN	2022-03-28	1	\N	\N	\N	\N
1164	Nísia Floresta	2408201	RN	2022-03-28	1	\N	\N	\N	\N
1165	Nova Cruz	2408300	RN	2022-03-28	1	\N	\N	\N	\N
1166	'Olho d''Água do Borges'	2408409	RN	2022-03-28	1	\N	\N	\N	\N
1167	Ouro Branco	2408508	RN	2022-03-28	1	\N	\N	\N	\N
1168	Paraná	2408607	RN	2022-03-28	1	\N	\N	\N	\N
1169	Paraú	2408706	RN	2022-03-28	1	\N	\N	\N	\N
1170	Parazinho	2408805	RN	2022-03-28	1	\N	\N	\N	\N
1171	Parelhas	2408904	RN	2022-03-28	1	\N	\N	\N	\N
1172	Parnamirim	2403251	RN	2022-03-28	1	\N	\N	\N	\N
1173	Passa e Fica	2409100	RN	2022-03-28	1	\N	\N	\N	\N
1174	Passagem	2409209	RN	2022-03-28	1	\N	\N	\N	\N
1175	Patu	2409308	RN	2022-03-28	1	\N	\N	\N	\N
1176	Pau dos Ferros	2409407	RN	2022-03-28	1	\N	\N	\N	\N
1177	Pedra Grande	2409506	RN	2022-03-28	1	\N	\N	\N	\N
1178	Pedra Preta	2409605	RN	2022-03-28	1	\N	\N	\N	\N
1179	Pedro Avelino	2409704	RN	2022-03-28	1	\N	\N	\N	\N
1180	Pedro Velho	2409803	RN	2022-03-28	1	\N	\N	\N	\N
1181	Pendências	2409902	RN	2022-03-28	1	\N	\N	\N	\N
1182	Pilões	2410009	RN	2022-03-28	1	\N	\N	\N	\N
1183	Poço Branco	2410108	RN	2022-03-28	1	\N	\N	\N	\N
1184	Portalegre	2410207	RN	2022-03-28	1	\N	\N	\N	\N
1185	Porto do Mangue	2410256	RN	2022-03-28	1	\N	\N	\N	\N
1186	Pureza	2410405	RN	2022-03-28	1	\N	\N	\N	\N
1187	Rafael Fernandes	2410504	RN	2022-03-28	1	\N	\N	\N	\N
1188	Rafael Godeiro	2410603	RN	2022-03-28	1	\N	\N	\N	\N
1189	Riacho da Cruz	2410702	RN	2022-03-28	1	\N	\N	\N	\N
1190	Riacho de Santana	2410801	RN	2022-03-28	1	\N	\N	\N	\N
1191	Riachuelo	2410900	RN	2022-03-28	1	\N	\N	\N	\N
1192	Rio do Fogo	2408953	RN	2022-03-28	1	\N	\N	\N	\N
1193	Rodolfo Fernandes	2411007	RN	2022-03-28	1	\N	\N	\N	\N
1194	Ruy Barbosa	2411106	RN	2022-03-28	1	\N	\N	\N	\N
1195	Santa Cruz	2411205	RN	2022-03-28	1	\N	\N	\N	\N
1196	Santa Maria	2409332	RN	2022-03-28	1	\N	\N	\N	\N
1197	Santana do Matos	2411403	RN	2022-03-28	1	\N	\N	\N	\N
1198	Santana do Seridó	2411429	RN	2022-03-28	1	\N	\N	\N	\N
1199	Santo Antônio	2411502	RN	2022-03-28	1	\N	\N	\N	\N
1200	São Bento do Norte	2411601	RN	2022-03-28	1	\N	\N	\N	\N
1201	São Bento do Trairí	2411700	RN	2022-03-28	1	\N	\N	\N	\N
1202	São Fernando	2411809	RN	2022-03-28	1	\N	\N	\N	\N
1203	São Francisco do Oeste	2411908	RN	2022-03-28	1	\N	\N	\N	\N
1204	São Gonçalo do Amarante	2412005	RN	2022-03-28	1	\N	\N	\N	\N
1205	São João do Sabugi	2412104	RN	2022-03-28	1	\N	\N	\N	\N
1206	São José de Mipibu	2412203	RN	2022-03-28	1	\N	\N	\N	\N
1207	São José do Campestre	2412302	RN	2022-03-28	1	\N	\N	\N	\N
1208	São José do Seridó	2412401	RN	2022-03-28	1	\N	\N	\N	\N
1209	São Miguel	2412500	RN	2022-03-28	1	\N	\N	\N	\N
1210	São Miguel do Gostoso	2412559	RN	2022-03-28	1	\N	\N	\N	\N
1211	São Paulo do Potengi	2412609	RN	2022-03-28	1	\N	\N	\N	\N
1212	São Pedro	2412708	RN	2022-03-28	1	\N	\N	\N	\N
1213	São Rafael	2412807	RN	2022-03-28	1	\N	\N	\N	\N
1214	São Tomé	2412906	RN	2022-03-28	1	\N	\N	\N	\N
1215	São Vicente	2413003	RN	2022-03-28	1	\N	\N	\N	\N
1216	Senador Elói de Souza	2413102	RN	2022-03-28	1	\N	\N	\N	\N
1217	Senador Georgino Avelino	2413201	RN	2022-03-28	1	\N	\N	\N	\N
1218	Serra Caiada	2410306	RN	2022-03-28	1	\N	\N	\N	\N
1219	Serra de São Bento	2413300	RN	2022-03-28	1	\N	\N	\N	\N
1220	Serra do Mel	2413359	RN	2022-03-28	1	\N	\N	\N	\N
1221	Serra Negra do Norte	2413409	RN	2022-03-28	1	\N	\N	\N	\N
1222	Serrinha	2413508	RN	2022-03-28	1	\N	\N	\N	\N
1223	Serrinha dos Pintos	2413557	RN	2022-03-28	1	\N	\N	\N	\N
1224	Severiano Melo	2413607	RN	2022-03-28	1	\N	\N	\N	\N
1225	Sítio Novo	2413706	RN	2022-03-28	1	\N	\N	\N	\N
1226	Taboleiro Grande	2413805	RN	2022-03-28	1	\N	\N	\N	\N
1227	Taipu	2413904	RN	2022-03-28	1	\N	\N	\N	\N
1228	Tangará	2414001	RN	2022-03-28	1	\N	\N	\N	\N
1229	Tenente Ananias	2414100	RN	2022-03-28	1	\N	\N	\N	\N
1230	Tenente Laurentino Cruz	2414159	RN	2022-03-28	1	\N	\N	\N	\N
1231	Tibau	2411056	RN	2022-03-28	1	\N	\N	\N	\N
1232	Tibau do Sul	2414209	RN	2022-03-28	1	\N	\N	\N	\N
1233	Timbaúba dos Batistas	2414308	RN	2022-03-28	1	\N	\N	\N	\N
1234	Touros	2414407	RN	2022-03-28	1	\N	\N	\N	\N
1235	Triunfo Potiguar	2414456	RN	2022-03-28	1	\N	\N	\N	\N
1236	Umarizal	2414506	RN	2022-03-28	1	\N	\N	\N	\N
1237	Upanema	2414605	RN	2022-03-28	1	\N	\N	\N	\N
1238	Várzea	2414704	RN	2022-03-28	1	\N	\N	\N	\N
1239	Venha-Ver	2414753	RN	2022-03-28	1	\N	\N	\N	\N
1240	Vera Cruz	2414803	RN	2022-03-28	1	\N	\N	\N	\N
1241	Viçosa	2414902	RN	2022-03-28	1	\N	\N	\N	\N
1242	Vila Flor	2415008	RN	2022-03-28	1	\N	\N	\N	\N
1243	Água Branca	2500106	PB	2022-03-28	1	\N	\N	\N	\N
1244	Aguiar	2500205	PB	2022-03-28	1	\N	\N	\N	\N
1245	Alagoa Grande	2500304	PB	2022-03-28	1	\N	\N	\N	\N
1246	Alagoa Nova	2500403	PB	2022-03-28	1	\N	\N	\N	\N
1247	Alagoinha	2500502	PB	2022-03-28	1	\N	\N	\N	\N
1248	Alcantil	2500536	PB	2022-03-28	1	\N	\N	\N	\N
1249	Algodão de Jandaíra	2500577	PB	2022-03-28	1	\N	\N	\N	\N
1250	Alhandra	2500601	PB	2022-03-28	1	\N	\N	\N	\N
1251	Amparo	2500734	PB	2022-03-28	1	\N	\N	\N	\N
1252	Aparecida	2500775	PB	2022-03-28	1	\N	\N	\N	\N
1253	Araçagi	2500809	PB	2022-03-28	1	\N	\N	\N	\N
1254	Arara	2500908	PB	2022-03-28	1	\N	\N	\N	\N
1255	Araruna	2501005	PB	2022-03-28	1	\N	\N	\N	\N
1256	Areia	2501104	PB	2022-03-28	1	\N	\N	\N	\N
1257	Areia de Baraúnas	2501153	PB	2022-03-28	1	\N	\N	\N	\N
1258	Areial	2501203	PB	2022-03-28	1	\N	\N	\N	\N
1259	Aroeiras	2501302	PB	2022-03-28	1	\N	\N	\N	\N
1260	Assunção	2501351	PB	2022-03-28	1	\N	\N	\N	\N
1261	Baía da Traição	2501401	PB	2022-03-28	1	\N	\N	\N	\N
1262	Bananeiras	2501500	PB	2022-03-28	1	\N	\N	\N	\N
1263	Baraúna	2501534	PB	2022-03-28	1	\N	\N	\N	\N
1264	Barra de Santa Rosa	2501609	PB	2022-03-28	1	\N	\N	\N	\N
1265	Barra de Santana	2501575	PB	2022-03-28	1	\N	\N	\N	\N
1266	Barra de São Miguel	2501708	PB	2022-03-28	1	\N	\N	\N	\N
1267	Bayeux	2501807	PB	2022-03-28	1	\N	\N	\N	\N
1268	Belém	2501906	PB	2022-03-28	1	\N	\N	\N	\N
1269	Belém do Brejo do Cruz	2502003	PB	2022-03-28	1	\N	\N	\N	\N
1270	Bernardino Batista	2502052	PB	2022-03-28	1	\N	\N	\N	\N
1271	Boa Ventura	2502102	PB	2022-03-28	1	\N	\N	\N	\N
1272	Boa Vista	2502151	PB	2022-03-28	1	\N	\N	\N	\N
1273	Bom Jesus	2502201	PB	2022-03-28	1	\N	\N	\N	\N
1274	Bom Sucesso	2502300	PB	2022-03-28	1	\N	\N	\N	\N
1275	Bonito de Santa Fé	2502409	PB	2022-03-28	1	\N	\N	\N	\N
1276	Boqueirão	2502508	PB	2022-03-28	1	\N	\N	\N	\N
1277	Borborema	2502706	PB	2022-03-28	1	\N	\N	\N	\N
1278	Brejo do Cruz	2502805	PB	2022-03-28	1	\N	\N	\N	\N
1279	Brejo dos Santos	2502904	PB	2022-03-28	1	\N	\N	\N	\N
1280	Caaporã	2503001	PB	2022-03-28	1	\N	\N	\N	\N
1281	Cabaceiras	2503100	PB	2022-03-28	1	\N	\N	\N	\N
1282	Cabedelo	2503209	PB	2022-03-28	1	\N	\N	\N	\N
1283	Cachoeira dos Índios	2503308	PB	2022-03-28	1	\N	\N	\N	\N
1284	Cacimba de Areia	2503407	PB	2022-03-28	1	\N	\N	\N	\N
1285	Cacimba de Dentro	2503506	PB	2022-03-28	1	\N	\N	\N	\N
1286	Cacimbas	2503555	PB	2022-03-28	1	\N	\N	\N	\N
1287	Caiçara	2503605	PB	2022-03-28	1	\N	\N	\N	\N
1288	Cajazeiras	2503704	PB	2022-03-28	1	\N	\N	\N	\N
1289	Cajazeirinhas	2503753	PB	2022-03-28	1	\N	\N	\N	\N
1290	Caldas Brandão	2503803	PB	2022-03-28	1	\N	\N	\N	\N
1291	Camalaú	2503902	PB	2022-03-28	1	\N	\N	\N	\N
1292	Campina Grande	2504009	PB	2022-03-28	1	\N	\N	\N	\N
1293	Capim	2504033	PB	2022-03-28	1	\N	\N	\N	\N
1294	Caraúbas	2504074	PB	2022-03-28	1	\N	\N	\N	\N
1295	Carrapateira	2504108	PB	2022-03-28	1	\N	\N	\N	\N
1296	Casserengue	2504157	PB	2022-03-28	1	\N	\N	\N	\N
1297	Catingueira	2504207	PB	2022-03-28	1	\N	\N	\N	\N
1298	Catolé do Rocha	2504306	PB	2022-03-28	1	\N	\N	\N	\N
1299	Caturité	2504355	PB	2022-03-28	1	\N	\N	\N	\N
1300	Conceição	2504405	PB	2022-03-28	1	\N	\N	\N	\N
1301	Condado	2504504	PB	2022-03-28	1	\N	\N	\N	\N
1302	Conde	2504603	PB	2022-03-28	1	\N	\N	\N	\N
1303	Congo	2504702	PB	2022-03-28	1	\N	\N	\N	\N
1304	Coremas	2504801	PB	2022-03-28	1	\N	\N	\N	\N
1305	Coxixola	2504850	PB	2022-03-28	1	\N	\N	\N	\N
1306	Cruz do Espírito Santo	2504900	PB	2022-03-28	1	\N	\N	\N	\N
1307	Cubati	2505006	PB	2022-03-28	1	\N	\N	\N	\N
1308	Cuité	2505105	PB	2022-03-28	1	\N	\N	\N	\N
1309	Cuité de Mamanguape	2505238	PB	2022-03-28	1	\N	\N	\N	\N
1310	Cuitegi	2505204	PB	2022-03-28	1	\N	\N	\N	\N
1311	Curral de Cima	2505279	PB	2022-03-28	1	\N	\N	\N	\N
1312	Curral Velho	2505303	PB	2022-03-28	1	\N	\N	\N	\N
1313	Damião	2505352	PB	2022-03-28	1	\N	\N	\N	\N
1314	Desterro	2505402	PB	2022-03-28	1	\N	\N	\N	\N
1315	Diamante	2505600	PB	2022-03-28	1	\N	\N	\N	\N
1316	Dona Inês	2505709	PB	2022-03-28	1	\N	\N	\N	\N
1317	Duas Estradas	2505808	PB	2022-03-28	1	\N	\N	\N	\N
1318	Emas	2505907	PB	2022-03-28	1	\N	\N	\N	\N
1319	Esperança	2506004	PB	2022-03-28	1	\N	\N	\N	\N
1320	Fagundes	2506103	PB	2022-03-28	1	\N	\N	\N	\N
1321	Frei Martinho	2506202	PB	2022-03-28	1	\N	\N	\N	\N
1322	Gado Bravo	2506251	PB	2022-03-28	1	\N	\N	\N	\N
1323	Guarabira	2506301	PB	2022-03-28	1	\N	\N	\N	\N
1324	Gurinhém	2506400	PB	2022-03-28	1	\N	\N	\N	\N
1325	Gurjão	2506509	PB	2022-03-28	1	\N	\N	\N	\N
1326	Ibiara	2506608	PB	2022-03-28	1	\N	\N	\N	\N
1327	Igaracy	2502607	PB	2022-03-28	1	\N	\N	\N	\N
1328	Imaculada	2506707	PB	2022-03-28	1	\N	\N	\N	\N
1329	Ingá	2506806	PB	2022-03-28	1	\N	\N	\N	\N
1330	Itabaiana	2506905	PB	2022-03-28	1	\N	\N	\N	\N
1331	Itaporanga	2507002	PB	2022-03-28	1	\N	\N	\N	\N
1332	Itapororoca	2507101	PB	2022-03-28	1	\N	\N	\N	\N
1333	Itatuba	2507200	PB	2022-03-28	1	\N	\N	\N	\N
1334	Jacaraú	2507309	PB	2022-03-28	1	\N	\N	\N	\N
1335	Jericó	2507408	PB	2022-03-28	1	\N	\N	\N	\N
1336	João Pessoa	2507507	PB	2022-03-28	1	\N	\N	\N	\N
1337	Joca Claudino	2513653	PB	2022-03-28	1	\N	\N	\N	\N
1338	Juarez Távora	2507606	PB	2022-03-28	1	\N	\N	\N	\N
1339	Juazeirinho	2507705	PB	2022-03-28	1	\N	\N	\N	\N
1340	Junco do Seridó	2507804	PB	2022-03-28	1	\N	\N	\N	\N
1341	Juripiranga	2507903	PB	2022-03-28	1	\N	\N	\N	\N
1342	Juru	2508000	PB	2022-03-28	1	\N	\N	\N	\N
1343	Lagoa	2508109	PB	2022-03-28	1	\N	\N	\N	\N
1344	Lagoa de Dentro	2508208	PB	2022-03-28	1	\N	\N	\N	\N
1345	Lagoa Seca	2508307	PB	2022-03-28	1	\N	\N	\N	\N
1346	Lastro	2508406	PB	2022-03-28	1	\N	\N	\N	\N
1347	Livramento	2508505	PB	2022-03-28	1	\N	\N	\N	\N
1348	Logradouro	2508554	PB	2022-03-28	1	\N	\N	\N	\N
1349	Lucena	2508604	PB	2022-03-28	1	\N	\N	\N	\N
1350	'Mãe d''Água'	2508703	PB	2022-03-28	1	\N	\N	\N	\N
1351	Malta	2508802	PB	2022-03-28	1	\N	\N	\N	\N
1352	Mamanguape	2508901	PB	2022-03-28	1	\N	\N	\N	\N
1353	Manaíra	2509008	PB	2022-03-28	1	\N	\N	\N	\N
1354	Marcação	2509057	PB	2022-03-28	1	\N	\N	\N	\N
1355	Mari	2509107	PB	2022-03-28	1	\N	\N	\N	\N
1356	Marizópolis	2509156	PB	2022-03-28	1	\N	\N	\N	\N
1357	Massaranduba	2509206	PB	2022-03-28	1	\N	\N	\N	\N
1358	Mataraca	2509305	PB	2022-03-28	1	\N	\N	\N	\N
1359	Matinhas	2509339	PB	2022-03-28	1	\N	\N	\N	\N
1360	Mato Grosso	2509370	PB	2022-03-28	1	\N	\N	\N	\N
1361	Maturéia	2509396	PB	2022-03-28	1	\N	\N	\N	\N
1362	Mogeiro	2509404	PB	2022-03-28	1	\N	\N	\N	\N
1363	Montadas	2509503	PB	2022-03-28	1	\N	\N	\N	\N
1364	Monte Horebe	2509602	PB	2022-03-28	1	\N	\N	\N	\N
1365	Monteiro	2509701	PB	2022-03-28	1	\N	\N	\N	\N
1366	Mulungu	2509800	PB	2022-03-28	1	\N	\N	\N	\N
1367	Natuba	2509909	PB	2022-03-28	1	\N	\N	\N	\N
1368	Nazarezinho	2510006	PB	2022-03-28	1	\N	\N	\N	\N
1369	Nova Floresta	2510105	PB	2022-03-28	1	\N	\N	\N	\N
1370	Nova Olinda	2510204	PB	2022-03-28	1	\N	\N	\N	\N
1371	Nova Palmeira	2510303	PB	2022-03-28	1	\N	\N	\N	\N
1372	'Olho d''Água'	2510402	PB	2022-03-28	1	\N	\N	\N	\N
1373	Olivedos	2510501	PB	2022-03-28	1	\N	\N	\N	\N
1374	Ouro Velho	2510600	PB	2022-03-28	1	\N	\N	\N	\N
1375	Parari	2510659	PB	2022-03-28	1	\N	\N	\N	\N
1376	Passagem	2510709	PB	2022-03-28	1	\N	\N	\N	\N
1377	Patos	2510808	PB	2022-03-28	1	\N	\N	\N	\N
1378	Paulista	2510907	PB	2022-03-28	1	\N	\N	\N	\N
1379	Pedra Branca	2511004	PB	2022-03-28	1	\N	\N	\N	\N
1380	Pedra Lavrada	2511103	PB	2022-03-28	1	\N	\N	\N	\N
1381	Pedras de Fogo	2511202	PB	2022-03-28	1	\N	\N	\N	\N
1382	Pedro Régis	2512721	PB	2022-03-28	1	\N	\N	\N	\N
1383	Piancó	2511301	PB	2022-03-28	1	\N	\N	\N	\N
1384	Picuí	2511400	PB	2022-03-28	1	\N	\N	\N	\N
1385	Pilar	2511509	PB	2022-03-28	1	\N	\N	\N	\N
1386	Pilões	2511608	PB	2022-03-28	1	\N	\N	\N	\N
1387	Pilõezinhos	2511707	PB	2022-03-28	1	\N	\N	\N	\N
1388	Pirpirituba	2511806	PB	2022-03-28	1	\N	\N	\N	\N
1389	Pitimbu	2511905	PB	2022-03-28	1	\N	\N	\N	\N
1390	Pocinhos	2512002	PB	2022-03-28	1	\N	\N	\N	\N
1391	Poço Dantas	2512036	PB	2022-03-28	1	\N	\N	\N	\N
1392	Poço de José de Moura	2512077	PB	2022-03-28	1	\N	\N	\N	\N
1393	Pombal	2512101	PB	2022-03-28	1	\N	\N	\N	\N
1394	Prata	2512200	PB	2022-03-28	1	\N	\N	\N	\N
1395	Princesa Isabel	2512309	PB	2022-03-28	1	\N	\N	\N	\N
1396	Puxinanã	2512408	PB	2022-03-28	1	\N	\N	\N	\N
1397	Queimadas	2512507	PB	2022-03-28	1	\N	\N	\N	\N
1398	Quixaba	2512606	PB	2022-03-28	1	\N	\N	\N	\N
1399	Remígio	2512705	PB	2022-03-28	1	\N	\N	\N	\N
1400	Riachão	2512747	PB	2022-03-28	1	\N	\N	\N	\N
1401	Riachão do Bacamarte	2512754	PB	2022-03-28	1	\N	\N	\N	\N
1402	Riachão do Poço	2512762	PB	2022-03-28	1	\N	\N	\N	\N
1403	Riacho de Santo Antônio	2512788	PB	2022-03-28	1	\N	\N	\N	\N
1404	Riacho dos Cavalos	2512804	PB	2022-03-28	1	\N	\N	\N	\N
1405	Rio Tinto	2512903	PB	2022-03-28	1	\N	\N	\N	\N
1406	Salgadinho	2513000	PB	2022-03-28	1	\N	\N	\N	\N
1407	Salgado de São Félix	2513109	PB	2022-03-28	1	\N	\N	\N	\N
1408	Santa Cecília	2513158	PB	2022-03-28	1	\N	\N	\N	\N
1409	Santa Cruz	2513208	PB	2022-03-28	1	\N	\N	\N	\N
1410	Santa Helena	2513307	PB	2022-03-28	1	\N	\N	\N	\N
1411	Santa Inês	2513356	PB	2022-03-28	1	\N	\N	\N	\N
1412	Santa Luzia	2513406	PB	2022-03-28	1	\N	\N	\N	\N
1413	Santa Rita	2513703	PB	2022-03-28	1	\N	\N	\N	\N
1414	Santa Teresinha	2513802	PB	2022-03-28	1	\N	\N	\N	\N
1415	Santana de Mangueira	2513505	PB	2022-03-28	1	\N	\N	\N	\N
1416	Santana dos Garrotes	2513604	PB	2022-03-28	1	\N	\N	\N	\N
1417	Santo André	2513851	PB	2022-03-28	1	\N	\N	\N	\N
1418	São Bentinho	2513927	PB	2022-03-28	1	\N	\N	\N	\N
1419	São Bento	2513901	PB	2022-03-28	1	\N	\N	\N	\N
1420	São Domingos	2513968	PB	2022-03-28	1	\N	\N	\N	\N
1421	São Domingos do Cariri	2513943	PB	2022-03-28	1	\N	\N	\N	\N
1422	São Francisco	2513984	PB	2022-03-28	1	\N	\N	\N	\N
1423	São João do Cariri	2514008	PB	2022-03-28	1	\N	\N	\N	\N
1424	São João do Rio do Peixe	2500700	PB	2022-03-28	1	\N	\N	\N	\N
1425	São João do Tigre	2514107	PB	2022-03-28	1	\N	\N	\N	\N
1426	São José da Lagoa Tapada	2514206	PB	2022-03-28	1	\N	\N	\N	\N
1427	São José de Caiana	2514305	PB	2022-03-28	1	\N	\N	\N	\N
1428	São José de Espinharas	2514404	PB	2022-03-28	1	\N	\N	\N	\N
1429	São José de Piranhas	2514503	PB	2022-03-28	1	\N	\N	\N	\N
1430	São José de Princesa	2514552	PB	2022-03-28	1	\N	\N	\N	\N
1431	São José do Bonfim	2514602	PB	2022-03-28	1	\N	\N	\N	\N
1432	São José do Brejo do Cruz	2514651	PB	2022-03-28	1	\N	\N	\N	\N
1433	São José do Sabugi	2514701	PB	2022-03-28	1	\N	\N	\N	\N
1434	São José dos Cordeiros	2514800	PB	2022-03-28	1	\N	\N	\N	\N
1435	São José dos Ramos	2514453	PB	2022-03-28	1	\N	\N	\N	\N
1436	São Mamede	2514909	PB	2022-03-28	1	\N	\N	\N	\N
1437	São Miguel de Taipu	2515005	PB	2022-03-28	1	\N	\N	\N	\N
1438	São Sebastião de Lagoa de Roça	2515104	PB	2022-03-28	1	\N	\N	\N	\N
1439	São Sebastião do Umbuzeiro	2515203	PB	2022-03-28	1	\N	\N	\N	\N
1440	São Vicente do Seridó	2515401	PB	2022-03-28	1	\N	\N	\N	\N
1441	Sapé	2515302	PB	2022-03-28	1	\N	\N	\N	\N
1442	Serra Branca	2515500	PB	2022-03-28	1	\N	\N	\N	\N
1443	Serra da Raiz	2515609	PB	2022-03-28	1	\N	\N	\N	\N
1444	Serra Grande	2515708	PB	2022-03-28	1	\N	\N	\N	\N
1445	Serra Redonda	2515807	PB	2022-03-28	1	\N	\N	\N	\N
1446	Serraria	2515906	PB	2022-03-28	1	\N	\N	\N	\N
1447	Sertãozinho	2515930	PB	2022-03-28	1	\N	\N	\N	\N
1448	Sobrado	2515971	PB	2022-03-28	1	\N	\N	\N	\N
1449	Solânea	2516003	PB	2022-03-28	1	\N	\N	\N	\N
1450	Soledade	2516102	PB	2022-03-28	1	\N	\N	\N	\N
1451	Sossêgo	2516151	PB	2022-03-28	1	\N	\N	\N	\N
1452	Sousa	2516201	PB	2022-03-28	1	\N	\N	\N	\N
1453	Sumé	2516300	PB	2022-03-28	1	\N	\N	\N	\N
1454	Tacima	2516409	PB	2022-03-28	1	\N	\N	\N	\N
1455	Taperoá	2516508	PB	2022-03-28	1	\N	\N	\N	\N
1456	Tavares	2516607	PB	2022-03-28	1	\N	\N	\N	\N
1457	Teixeira	2516706	PB	2022-03-28	1	\N	\N	\N	\N
1458	Tenório	2516755	PB	2022-03-28	1	\N	\N	\N	\N
1459	Triunfo	2516805	PB	2022-03-28	1	\N	\N	\N	\N
1460	Uiraúna	2516904	PB	2022-03-28	1	\N	\N	\N	\N
1461	Umbuzeiro	2517001	PB	2022-03-28	1	\N	\N	\N	\N
1462	Várzea	2517100	PB	2022-03-28	1	\N	\N	\N	\N
1463	Vieirópolis	2517209	PB	2022-03-28	1	\N	\N	\N	\N
1464	Vista Serrana	2505501	PB	2022-03-28	1	\N	\N	\N	\N
1465	Zabelê	2517407	PB	2022-03-28	1	\N	\N	\N	\N
1466	Abreu e Lima	2600054	PE	2022-03-28	1	\N	\N	\N	\N
1467	Afogados da Ingazeira	2600104	PE	2022-03-28	1	\N	\N	\N	\N
1468	Afrânio	2600203	PE	2022-03-28	1	\N	\N	\N	\N
1469	Agrestina	2600302	PE	2022-03-28	1	\N	\N	\N	\N
1470	Água Preta	2600401	PE	2022-03-28	1	\N	\N	\N	\N
1471	Águas Belas	2600500	PE	2022-03-28	1	\N	\N	\N	\N
1472	Alagoinha	2600609	PE	2022-03-28	1	\N	\N	\N	\N
1473	Aliança	2600708	PE	2022-03-28	1	\N	\N	\N	\N
1474	Altinho	2600807	PE	2022-03-28	1	\N	\N	\N	\N
1475	Amaraji	2600906	PE	2022-03-28	1	\N	\N	\N	\N
1476	Angelim	2601003	PE	2022-03-28	1	\N	\N	\N	\N
1477	Araçoiaba	2601052	PE	2022-03-28	1	\N	\N	\N	\N
1478	Araripina	2601102	PE	2022-03-28	1	\N	\N	\N	\N
1479	Arcoverde	2601201	PE	2022-03-28	1	\N	\N	\N	\N
1480	Barra de Guabiraba	2601300	PE	2022-03-28	1	\N	\N	\N	\N
1481	Barreiros	2601409	PE	2022-03-28	1	\N	\N	\N	\N
1482	Belém de Maria	2601508	PE	2022-03-28	1	\N	\N	\N	\N
1483	Belém do São Francisco	2601607	PE	2022-03-28	1	\N	\N	\N	\N
1484	Belo Jardim	2601706	PE	2022-03-28	1	\N	\N	\N	\N
1485	Betânia	2601805	PE	2022-03-28	1	\N	\N	\N	\N
1486	Bezerros	2601904	PE	2022-03-28	1	\N	\N	\N	\N
1487	Bodocó	2602001	PE	2022-03-28	1	\N	\N	\N	\N
1488	Bom Conselho	2602100	PE	2022-03-28	1	\N	\N	\N	\N
1489	Bom Jardim	2602209	PE	2022-03-28	1	\N	\N	\N	\N
1490	Bonito	2602308	PE	2022-03-28	1	\N	\N	\N	\N
1491	Brejão	2602407	PE	2022-03-28	1	\N	\N	\N	\N
1492	Brejinho	2602506	PE	2022-03-28	1	\N	\N	\N	\N
1493	Brejo da Madre de Deus	2602605	PE	2022-03-28	1	\N	\N	\N	\N
1494	Buenos Aires	2602704	PE	2022-03-28	1	\N	\N	\N	\N
1495	Buíque	2602803	PE	2022-03-28	1	\N	\N	\N	\N
1496	Cabo de Santo Agostinho	2602902	PE	2022-03-28	1	\N	\N	\N	\N
1497	Cabrobó	2603009	PE	2022-03-28	1	\N	\N	\N	\N
1498	Cachoeirinha	2603108	PE	2022-03-28	1	\N	\N	\N	\N
1499	Caetés	2603207	PE	2022-03-28	1	\N	\N	\N	\N
1500	Calçado	2603306	PE	2022-03-28	1	\N	\N	\N	\N
1501	Calumbi	2603405	PE	2022-03-28	1	\N	\N	\N	\N
1502	Camaragibe	2603454	PE	2022-03-28	1	\N	\N	\N	\N
1503	Camocim de São Félix	2603504	PE	2022-03-28	1	\N	\N	\N	\N
1504	Camutanga	2603603	PE	2022-03-28	1	\N	\N	\N	\N
1505	Canhotinho	2603702	PE	2022-03-28	1	\N	\N	\N	\N
1506	Capoeiras	2603801	PE	2022-03-28	1	\N	\N	\N	\N
1507	Carnaíba	2603900	PE	2022-03-28	1	\N	\N	\N	\N
1508	Carnaubeira da Penha	2603926	PE	2022-03-28	1	\N	\N	\N	\N
1509	Carpina	2604007	PE	2022-03-28	1	\N	\N	\N	\N
1510	Caruaru	2604106	PE	2022-03-28	1	\N	\N	\N	\N
1511	Casinhas	2604155	PE	2022-03-28	1	\N	\N	\N	\N
1512	Catende	2604205	PE	2022-03-28	1	\N	\N	\N	\N
1513	Cedro	2604304	PE	2022-03-28	1	\N	\N	\N	\N
1514	Chã de Alegria	2604403	PE	2022-03-28	1	\N	\N	\N	\N
1515	Chã Grande	2604502	PE	2022-03-28	1	\N	\N	\N	\N
1516	Condado	2604601	PE	2022-03-28	1	\N	\N	\N	\N
1517	Correntes	2604700	PE	2022-03-28	1	\N	\N	\N	\N
1518	Cortês	2604809	PE	2022-03-28	1	\N	\N	\N	\N
1519	Cumaru	2604908	PE	2022-03-28	1	\N	\N	\N	\N
1520	Cupira	2605004	PE	2022-03-28	1	\N	\N	\N	\N
1521	Custódia	2605103	PE	2022-03-28	1	\N	\N	\N	\N
1522	Dormentes	2605152	PE	2022-03-28	1	\N	\N	\N	\N
1523	Escada	2605202	PE	2022-03-28	1	\N	\N	\N	\N
1524	Exu	2605301	PE	2022-03-28	1	\N	\N	\N	\N
1525	Feira Nova	2605400	PE	2022-03-28	1	\N	\N	\N	\N
1526	Fernando de Noronha	2605459	PE	2022-03-28	1	\N	\N	\N	\N
1527	Ferreiros	2605509	PE	2022-03-28	1	\N	\N	\N	\N
1528	Flores	2605608	PE	2022-03-28	1	\N	\N	\N	\N
1529	Floresta	2605707	PE	2022-03-28	1	\N	\N	\N	\N
1530	Frei Miguelinho	2605806	PE	2022-03-28	1	\N	\N	\N	\N
1531	Gameleira	2605905	PE	2022-03-28	1	\N	\N	\N	\N
1532	Garanhuns	2606002	PE	2022-03-28	1	\N	\N	\N	\N
1533	Glória do Goitá	2606101	PE	2022-03-28	1	\N	\N	\N	\N
1534	Goiana	2606200	PE	2022-03-28	1	\N	\N	\N	\N
1535	Granito	2606309	PE	2022-03-28	1	\N	\N	\N	\N
1536	Gravatá	2606408	PE	2022-03-28	1	\N	\N	\N	\N
1537	Iati	2606507	PE	2022-03-28	1	\N	\N	\N	\N
1538	Ibimirim	2606606	PE	2022-03-28	1	\N	\N	\N	\N
1539	Ibirajuba	2606705	PE	2022-03-28	1	\N	\N	\N	\N
1540	Igarassu	2606804	PE	2022-03-28	1	\N	\N	\N	\N
1541	Iguaracy	2606903	PE	2022-03-28	1	\N	\N	\N	\N
1542	Ilha de Itamaracá	2607604	PE	2022-03-28	1	\N	\N	\N	\N
1543	Inajá	2607000	PE	2022-03-28	1	\N	\N	\N	\N
1544	Ingazeira	2607109	PE	2022-03-28	1	\N	\N	\N	\N
1545	Ipojuca	2607208	PE	2022-03-28	1	\N	\N	\N	\N
1546	Ipubi	2607307	PE	2022-03-28	1	\N	\N	\N	\N
1547	Itacuruba	2607406	PE	2022-03-28	1	\N	\N	\N	\N
1548	Itaíba	2607505	PE	2022-03-28	1	\N	\N	\N	\N
1549	Itambé	2607653	PE	2022-03-28	1	\N	\N	\N	\N
1550	Itapetim	2607703	PE	2022-03-28	1	\N	\N	\N	\N
1551	Itapissuma	2607752	PE	2022-03-28	1	\N	\N	\N	\N
1552	Itaquitinga	2607802	PE	2022-03-28	1	\N	\N	\N	\N
1553	Jaboatão dos Guararapes	2607901	PE	2022-03-28	1	\N	\N	\N	\N
1554	Jaqueira	2607950	PE	2022-03-28	1	\N	\N	\N	\N
1555	Jataúba	2608008	PE	2022-03-28	1	\N	\N	\N	\N
1556	Jatobá	2608057	PE	2022-03-28	1	\N	\N	\N	\N
1557	João Alfredo	2608107	PE	2022-03-28	1	\N	\N	\N	\N
1558	Joaquim Nabuco	2608206	PE	2022-03-28	1	\N	\N	\N	\N
1559	Jucati	2608255	PE	2022-03-28	1	\N	\N	\N	\N
1560	Jupi	2608305	PE	2022-03-28	1	\N	\N	\N	\N
1561	Jurema	2608404	PE	2022-03-28	1	\N	\N	\N	\N
1562	Lagoa de Itaenga	2608503	PE	2022-03-28	1	\N	\N	\N	\N
1563	Lagoa do Carro	2608453	PE	2022-03-28	1	\N	\N	\N	\N
1564	Lagoa do Ouro	2608602	PE	2022-03-28	1	\N	\N	\N	\N
1565	Lagoa dos Gatos	2608701	PE	2022-03-28	1	\N	\N	\N	\N
1566	Lagoa Grande	2608750	PE	2022-03-28	1	\N	\N	\N	\N
1567	Lajedo	2608800	PE	2022-03-28	1	\N	\N	\N	\N
1568	Limoeiro	2608909	PE	2022-03-28	1	\N	\N	\N	\N
1569	Macaparana	2609006	PE	2022-03-28	1	\N	\N	\N	\N
1570	Machados	2609105	PE	2022-03-28	1	\N	\N	\N	\N
1571	Manari	2609154	PE	2022-03-28	1	\N	\N	\N	\N
1572	Maraial	2609204	PE	2022-03-28	1	\N	\N	\N	\N
1573	Mirandiba	2609303	PE	2022-03-28	1	\N	\N	\N	\N
1574	Moreilândia	2614303	PE	2022-03-28	1	\N	\N	\N	\N
1575	Moreno	2609402	PE	2022-03-28	1	\N	\N	\N	\N
1576	Nazaré da Mata	2609501	PE	2022-03-28	1	\N	\N	\N	\N
1577	Olinda	2609600	PE	2022-03-28	1	\N	\N	\N	\N
1578	Orobó	2609709	PE	2022-03-28	1	\N	\N	\N	\N
1579	Orocó	2609808	PE	2022-03-28	1	\N	\N	\N	\N
1580	Ouricuri	2609907	PE	2022-03-28	1	\N	\N	\N	\N
1581	Palmares	2610004	PE	2022-03-28	1	\N	\N	\N	\N
1582	Palmeirina	2610103	PE	2022-03-28	1	\N	\N	\N	\N
1583	Panelas	2610202	PE	2022-03-28	1	\N	\N	\N	\N
1584	Paranatama	2610301	PE	2022-03-28	1	\N	\N	\N	\N
1585	Parnamirim	2610400	PE	2022-03-28	1	\N	\N	\N	\N
1586	Passira	2610509	PE	2022-03-28	1	\N	\N	\N	\N
1587	Paudalho	2610608	PE	2022-03-28	1	\N	\N	\N	\N
1588	Paulista	2610707	PE	2022-03-28	1	\N	\N	\N	\N
1589	Pedra	2610806	PE	2022-03-28	1	\N	\N	\N	\N
1590	Pesqueira	2610905	PE	2022-03-28	1	\N	\N	\N	\N
1591	Petrolândia	2611002	PE	2022-03-28	1	\N	\N	\N	\N
1592	Petrolina	2611101	PE	2022-03-28	1	\N	\N	\N	\N
1593	Poção	2611200	PE	2022-03-28	1	\N	\N	\N	\N
1594	Pombos	2611309	PE	2022-03-28	1	\N	\N	\N	\N
1595	Primavera	2611408	PE	2022-03-28	1	\N	\N	\N	\N
1596	Quipapá	2611507	PE	2022-03-28	1	\N	\N	\N	\N
1597	Quixaba	2611533	PE	2022-03-28	1	\N	\N	\N	\N
1598	Recife	2611606	PE	2022-03-28	1	\N	\N	\N	\N
1599	Riacho das Almas	2611705	PE	2022-03-28	1	\N	\N	\N	\N
1600	Ribeirão	2611804	PE	2022-03-28	1	\N	\N	\N	\N
1601	Rio Formoso	2611903	PE	2022-03-28	1	\N	\N	\N	\N
1602	Sairé	2612000	PE	2022-03-28	1	\N	\N	\N	\N
1603	Salgadinho	2612109	PE	2022-03-28	1	\N	\N	\N	\N
1604	Salgueiro	2612208	PE	2022-03-28	1	\N	\N	\N	\N
1605	Saloá	2612307	PE	2022-03-28	1	\N	\N	\N	\N
1606	Sanharó	2612406	PE	2022-03-28	1	\N	\N	\N	\N
1607	Santa Cruz	2612455	PE	2022-03-28	1	\N	\N	\N	\N
1608	Santa Cruz da Baixa Verde	2612471	PE	2022-03-28	1	\N	\N	\N	\N
1609	Santa Cruz do Capibaribe	2612505	PE	2022-03-28	1	\N	\N	\N	\N
1610	Santa Filomena	2612554	PE	2022-03-28	1	\N	\N	\N	\N
1611	Santa Maria da Boa Vista	2612604	PE	2022-03-28	1	\N	\N	\N	\N
1612	Santa Maria do Cambucá	2612703	PE	2022-03-28	1	\N	\N	\N	\N
1613	Santa Terezinha	2612802	PE	2022-03-28	1	\N	\N	\N	\N
1614	São Benedito do Sul	2612901	PE	2022-03-28	1	\N	\N	\N	\N
1615	São Bento do Una	2613008	PE	2022-03-28	1	\N	\N	\N	\N
1616	São Caitano	2613107	PE	2022-03-28	1	\N	\N	\N	\N
1617	São João	2613206	PE	2022-03-28	1	\N	\N	\N	\N
1618	São Joaquim do Monte	2613305	PE	2022-03-28	1	\N	\N	\N	\N
1619	São José da Coroa Grande	2613404	PE	2022-03-28	1	\N	\N	\N	\N
1620	São José do Belmonte	2613503	PE	2022-03-28	1	\N	\N	\N	\N
1621	São José do Egito	2613602	PE	2022-03-28	1	\N	\N	\N	\N
1622	São Lourenço da Mata	2613701	PE	2022-03-28	1	\N	\N	\N	\N
1623	São Vicente Férrer	2613800	PE	2022-03-28	1	\N	\N	\N	\N
1624	Serra Talhada	2613909	PE	2022-03-28	1	\N	\N	\N	\N
1625	Serrita	2614006	PE	2022-03-28	1	\N	\N	\N	\N
1626	Sertânia	2614105	PE	2022-03-28	1	\N	\N	\N	\N
1627	Sirinhaém	2614204	PE	2022-03-28	1	\N	\N	\N	\N
1628	Solidão	2614402	PE	2022-03-28	1	\N	\N	\N	\N
1629	Surubim	2614501	PE	2022-03-28	1	\N	\N	\N	\N
1630	Tabira	2614600	PE	2022-03-28	1	\N	\N	\N	\N
1631	Tacaimbó	2614709	PE	2022-03-28	1	\N	\N	\N	\N
1632	Tacaratu	2614808	PE	2022-03-28	1	\N	\N	\N	\N
1633	Tamandaré	2614857	PE	2022-03-28	1	\N	\N	\N	\N
1634	Taquaritinga do Norte	2615003	PE	2022-03-28	1	\N	\N	\N	\N
1635	Terezinha	2615102	PE	2022-03-28	1	\N	\N	\N	\N
1636	Terra Nova	2615201	PE	2022-03-28	1	\N	\N	\N	\N
1637	Timbaúba	2615300	PE	2022-03-28	1	\N	\N	\N	\N
1638	Toritama	2615409	PE	2022-03-28	1	\N	\N	\N	\N
1639	Tracunhaém	2615508	PE	2022-03-28	1	\N	\N	\N	\N
1640	Trindade	2615607	PE	2022-03-28	1	\N	\N	\N	\N
1641	Triunfo	2615706	PE	2022-03-28	1	\N	\N	\N	\N
1642	Tupanatinga	2615805	PE	2022-03-28	1	\N	\N	\N	\N
1643	Tuparetama	2615904	PE	2022-03-28	1	\N	\N	\N	\N
1644	Venturosa	2616001	PE	2022-03-28	1	\N	\N	\N	\N
1645	Verdejante	2616100	PE	2022-03-28	1	\N	\N	\N	\N
1646	Vertente do Lério	2616183	PE	2022-03-28	1	\N	\N	\N	\N
1647	Vertentes	2616209	PE	2022-03-28	1	\N	\N	\N	\N
1648	Vicência	2616308	PE	2022-03-28	1	\N	\N	\N	\N
1649	Vitória de Santo Antão	2616407	PE	2022-03-28	1	\N	\N	\N	\N
1650	Xexéu	2616506	PE	2022-03-28	1	\N	\N	\N	\N
1651	Água Branca	2700102	AL	2022-03-28	1	\N	\N	\N	\N
1652	Anadia	2700201	AL	2022-03-28	1	\N	\N	\N	\N
1653	Arapiraca	2700300	AL	2022-03-28	1	\N	\N	\N	\N
1654	Atalaia	2700409	AL	2022-03-28	1	\N	\N	\N	\N
1655	Barra de Santo Antônio	2700508	AL	2022-03-28	1	\N	\N	\N	\N
1656	Barra de São Miguel	2700607	AL	2022-03-28	1	\N	\N	\N	\N
1657	Batalha	2700706	AL	2022-03-28	1	\N	\N	\N	\N
1658	Belém	2700805	AL	2022-03-28	1	\N	\N	\N	\N
1659	Belo Monte	2700904	AL	2022-03-28	1	\N	\N	\N	\N
1660	Boca da Mata	2701001	AL	2022-03-28	1	\N	\N	\N	\N
1661	Branquinha	2701100	AL	2022-03-28	1	\N	\N	\N	\N
1662	Cacimbinhas	2701209	AL	2022-03-28	1	\N	\N	\N	\N
1663	Cajueiro	2701308	AL	2022-03-28	1	\N	\N	\N	\N
1664	Campestre	2701357	AL	2022-03-28	1	\N	\N	\N	\N
1665	Campo Alegre	2701407	AL	2022-03-28	1	\N	\N	\N	\N
1666	Campo Grande	2701506	AL	2022-03-28	1	\N	\N	\N	\N
1667	Canapi	2701605	AL	2022-03-28	1	\N	\N	\N	\N
1668	Capela	2701704	AL	2022-03-28	1	\N	\N	\N	\N
1669	Carneiros	2701803	AL	2022-03-28	1	\N	\N	\N	\N
1670	Chã Preta	2701902	AL	2022-03-28	1	\N	\N	\N	\N
1671	Coité do Nóia	2702009	AL	2022-03-28	1	\N	\N	\N	\N
1672	Colônia Leopoldina	2702108	AL	2022-03-28	1	\N	\N	\N	\N
1673	Coqueiro Seco	2702207	AL	2022-03-28	1	\N	\N	\N	\N
1674	Coruripe	2702306	AL	2022-03-28	1	\N	\N	\N	\N
1675	Craíbas	2702355	AL	2022-03-28	1	\N	\N	\N	\N
1676	Delmiro Gouveia	2702405	AL	2022-03-28	1	\N	\N	\N	\N
1677	Dois Riachos	2702504	AL	2022-03-28	1	\N	\N	\N	\N
1678	Estrela de Alagoas	2702553	AL	2022-03-28	1	\N	\N	\N	\N
1679	Feira Grande	2702603	AL	2022-03-28	1	\N	\N	\N	\N
1680	Feliz Deserto	2702702	AL	2022-03-28	1	\N	\N	\N	\N
1681	Flexeiras	2702801	AL	2022-03-28	1	\N	\N	\N	\N
1682	Girau do Ponciano	2702900	AL	2022-03-28	1	\N	\N	\N	\N
1683	Ibateguara	2703007	AL	2022-03-28	1	\N	\N	\N	\N
1684	Igaci	2703106	AL	2022-03-28	1	\N	\N	\N	\N
1685	Igreja Nova	2703205	AL	2022-03-28	1	\N	\N	\N	\N
1686	Inhapi	2703304	AL	2022-03-28	1	\N	\N	\N	\N
1687	Jacaré dos Homens	2703403	AL	2022-03-28	1	\N	\N	\N	\N
1688	Jacuípe	2703502	AL	2022-03-28	1	\N	\N	\N	\N
1689	Japaratinga	2703601	AL	2022-03-28	1	\N	\N	\N	\N
1690	Jaramataia	2703700	AL	2022-03-28	1	\N	\N	\N	\N
1691	Jequiá da Praia	2703759	AL	2022-03-28	1	\N	\N	\N	\N
1692	Joaquim Gomes	2703809	AL	2022-03-28	1	\N	\N	\N	\N
1693	Jundiá	2703908	AL	2022-03-28	1	\N	\N	\N	\N
1694	Junqueiro	2704005	AL	2022-03-28	1	\N	\N	\N	\N
1695	Lagoa da Canoa	2704104	AL	2022-03-28	1	\N	\N	\N	\N
1696	Limoeiro de Anadia	2704203	AL	2022-03-28	1	\N	\N	\N	\N
1697	Maceió	2704302	AL	2022-03-28	1	\N	\N	\N	\N
1698	Major Isidoro	2704401	AL	2022-03-28	1	\N	\N	\N	\N
1699	Mar Vermelho	2704906	AL	2022-03-28	1	\N	\N	\N	\N
1700	Maragogi	2704500	AL	2022-03-28	1	\N	\N	\N	\N
1701	Maravilha	2704609	AL	2022-03-28	1	\N	\N	\N	\N
1702	Marechal Deodoro	2704708	AL	2022-03-28	1	\N	\N	\N	\N
1703	Maribondo	2704807	AL	2022-03-28	1	\N	\N	\N	\N
1704	Mata Grande	2705002	AL	2022-03-28	1	\N	\N	\N	\N
1705	Matriz de Camaragibe	2705101	AL	2022-03-28	1	\N	\N	\N	\N
1706	Messias	2705200	AL	2022-03-28	1	\N	\N	\N	\N
1707	Minador do Negrão	2705309	AL	2022-03-28	1	\N	\N	\N	\N
1708	Monteirópolis	2705408	AL	2022-03-28	1	\N	\N	\N	\N
1709	Murici	2705507	AL	2022-03-28	1	\N	\N	\N	\N
1710	Novo Lino	2705606	AL	2022-03-28	1	\N	\N	\N	\N
1711	'Olho d''Água das Flores'	2705705	AL	2022-03-28	1	\N	\N	\N	\N
1712	'Olho d''Água do Casado'	2705804	AL	2022-03-28	1	\N	\N	\N	\N
1713	'Olho d''Água Grande'	2705903	AL	2022-03-28	1	\N	\N	\N	\N
1714	Olivença	2706000	AL	2022-03-28	1	\N	\N	\N	\N
1715	Ouro Branco	2706109	AL	2022-03-28	1	\N	\N	\N	\N
1716	Palestina	2706208	AL	2022-03-28	1	\N	\N	\N	\N
1717	Palmeira dos Índios	2706307	AL	2022-03-28	1	\N	\N	\N	\N
1718	Pão de Açúcar	2706406	AL	2022-03-28	1	\N	\N	\N	\N
1719	Pariconha	2706422	AL	2022-03-28	1	\N	\N	\N	\N
1720	Paripueira	2706448	AL	2022-03-28	1	\N	\N	\N	\N
1721	Passo de Camaragibe	2706505	AL	2022-03-28	1	\N	\N	\N	\N
1722	Paulo Jacinto	2706604	AL	2022-03-28	1	\N	\N	\N	\N
1723	Penedo	2706703	AL	2022-03-28	1	\N	\N	\N	\N
1724	Piaçabuçu	2706802	AL	2022-03-28	1	\N	\N	\N	\N
1725	Pilar	2706901	AL	2022-03-28	1	\N	\N	\N	\N
1726	Pindoba	2707008	AL	2022-03-28	1	\N	\N	\N	\N
1727	Piranhas	2707107	AL	2022-03-28	1	\N	\N	\N	\N
1728	Poço das Trincheiras	2707206	AL	2022-03-28	1	\N	\N	\N	\N
1729	Porto Calvo	2707305	AL	2022-03-28	1	\N	\N	\N	\N
1730	Porto de Pedras	2707404	AL	2022-03-28	1	\N	\N	\N	\N
1731	Porto Real do Colégio	2707503	AL	2022-03-28	1	\N	\N	\N	\N
1732	Quebrangulo	2707602	AL	2022-03-28	1	\N	\N	\N	\N
1733	Rio Largo	2707701	AL	2022-03-28	1	\N	\N	\N	\N
1734	Roteiro	2707800	AL	2022-03-28	1	\N	\N	\N	\N
1735	Santa Luzia do Norte	2707909	AL	2022-03-28	1	\N	\N	\N	\N
1736	Santana do Ipanema	2708006	AL	2022-03-28	1	\N	\N	\N	\N
1737	Santana do Mundaú	2708105	AL	2022-03-28	1	\N	\N	\N	\N
1738	São Brás	2708204	AL	2022-03-28	1	\N	\N	\N	\N
1739	São José da Laje	2708303	AL	2022-03-28	1	\N	\N	\N	\N
1740	São José da Tapera	2708402	AL	2022-03-28	1	\N	\N	\N	\N
1741	São Luís do Quitunde	2708501	AL	2022-03-28	1	\N	\N	\N	\N
1742	São Miguel dos Campos	2708600	AL	2022-03-28	1	\N	\N	\N	\N
1743	São Miguel dos Milagres	2708709	AL	2022-03-28	1	\N	\N	\N	\N
1744	São Sebastião	2708808	AL	2022-03-28	1	\N	\N	\N	\N
1745	Satuba	2708907	AL	2022-03-28	1	\N	\N	\N	\N
1746	Senador Rui Palmeira	2708956	AL	2022-03-28	1	\N	\N	\N	\N
1747	'Tanque d''Arca'	2709004	AL	2022-03-28	1	\N	\N	\N	\N
1748	Taquarana	2709103	AL	2022-03-28	1	\N	\N	\N	\N
1749	Teotônio Vilela	2709152	AL	2022-03-28	1	\N	\N	\N	\N
1750	Traipu	2709202	AL	2022-03-28	1	\N	\N	\N	\N
1751	União dos Palmares	2709301	AL	2022-03-28	1	\N	\N	\N	\N
1752	Viçosa	2709400	AL	2022-03-28	1	\N	\N	\N	\N
1753	Amparo do São Francisco	2800100	SE	2022-03-28	1	\N	\N	\N	\N
1754	Aquidabã	2800209	SE	2022-03-28	1	\N	\N	\N	\N
1755	Aracaju	2800308	SE	2022-03-28	1	\N	\N	\N	\N
1756	Arauá	2800407	SE	2022-03-28	1	\N	\N	\N	\N
1757	Areia Branca	2800506	SE	2022-03-28	1	\N	\N	\N	\N
1758	Barra dos Coqueiros	2800605	SE	2022-03-28	1	\N	\N	\N	\N
1759	Boquim	2800670	SE	2022-03-28	1	\N	\N	\N	\N
1760	Brejo Grande	2800704	SE	2022-03-28	1	\N	\N	\N	\N
1761	Campo do Brito	2801009	SE	2022-03-28	1	\N	\N	\N	\N
1762	Canhoba	2801108	SE	2022-03-28	1	\N	\N	\N	\N
1763	Canindé de São Francisco	2801207	SE	2022-03-28	1	\N	\N	\N	\N
1764	Capela	2801306	SE	2022-03-28	1	\N	\N	\N	\N
1765	Carira	2801405	SE	2022-03-28	1	\N	\N	\N	\N
1766	Carmópolis	2801504	SE	2022-03-28	1	\N	\N	\N	\N
1767	Cedro de São João	2801603	SE	2022-03-28	1	\N	\N	\N	\N
1768	Cristinápolis	2801702	SE	2022-03-28	1	\N	\N	\N	\N
1769	Cumbe	2801900	SE	2022-03-28	1	\N	\N	\N	\N
1770	Divina Pastora	2802007	SE	2022-03-28	1	\N	\N	\N	\N
1771	Estância	2802106	SE	2022-03-28	1	\N	\N	\N	\N
1772	Feira Nova	2802205	SE	2022-03-28	1	\N	\N	\N	\N
1773	Frei Paulo	2802304	SE	2022-03-28	1	\N	\N	\N	\N
1774	Gararu	2802403	SE	2022-03-28	1	\N	\N	\N	\N
1775	General Maynard	2802502	SE	2022-03-28	1	\N	\N	\N	\N
1776	Gracho Cardoso	2802601	SE	2022-03-28	1	\N	\N	\N	\N
1777	Ilha das Flores	2802700	SE	2022-03-28	1	\N	\N	\N	\N
1778	Indiaroba	2802809	SE	2022-03-28	1	\N	\N	\N	\N
1779	Itabaiana	2802908	SE	2022-03-28	1	\N	\N	\N	\N
1780	Itabaianinha	2803005	SE	2022-03-28	1	\N	\N	\N	\N
1781	Itabi	2803104	SE	2022-03-28	1	\N	\N	\N	\N
1782	'Itaporanga d''Ajuda'	2803203	SE	2022-03-28	1	\N	\N	\N	\N
1783	Japaratuba	2803302	SE	2022-03-28	1	\N	\N	\N	\N
1784	Japoatã	2803401	SE	2022-03-28	1	\N	\N	\N	\N
1785	Lagarto	2803500	SE	2022-03-28	1	\N	\N	\N	\N
1786	Laranjeiras	2803609	SE	2022-03-28	1	\N	\N	\N	\N
1787	Macambira	2803708	SE	2022-03-28	1	\N	\N	\N	\N
1788	Malhada dos Bois	2803807	SE	2022-03-28	1	\N	\N	\N	\N
1789	Malhador	2803906	SE	2022-03-28	1	\N	\N	\N	\N
1790	Maruim	2804003	SE	2022-03-28	1	\N	\N	\N	\N
1791	Moita Bonita	2804102	SE	2022-03-28	1	\N	\N	\N	\N
1792	Monte Alegre de Sergipe	2804201	SE	2022-03-28	1	\N	\N	\N	\N
1793	Muribeca	2804300	SE	2022-03-28	1	\N	\N	\N	\N
1794	Neópolis	2804409	SE	2022-03-28	1	\N	\N	\N	\N
1795	Nossa Senhora Aparecida	2804458	SE	2022-03-28	1	\N	\N	\N	\N
1796	Nossa Senhora da Glória	2804508	SE	2022-03-28	1	\N	\N	\N	\N
1797	Nossa Senhora das Dores	2804607	SE	2022-03-28	1	\N	\N	\N	\N
1798	Nossa Senhora de Lourdes	2804706	SE	2022-03-28	1	\N	\N	\N	\N
1799	Nossa Senhora do Socorro	2804805	SE	2022-03-28	1	\N	\N	\N	\N
1800	Pacatuba	2804904	SE	2022-03-28	1	\N	\N	\N	\N
1801	Pedra Mole	2805000	SE	2022-03-28	1	\N	\N	\N	\N
1802	Pedrinhas	2805109	SE	2022-03-28	1	\N	\N	\N	\N
1803	Pinhão	2805208	SE	2022-03-28	1	\N	\N	\N	\N
1804	Pirambu	2805307	SE	2022-03-28	1	\N	\N	\N	\N
1805	Poço Redondo	2805406	SE	2022-03-28	1	\N	\N	\N	\N
1806	Poço Verde	2805505	SE	2022-03-28	1	\N	\N	\N	\N
1807	Porto da Folha	2805604	SE	2022-03-28	1	\N	\N	\N	\N
1808	Propriá	2805703	SE	2022-03-28	1	\N	\N	\N	\N
1809	Riachão do Dantas	2805802	SE	2022-03-28	1	\N	\N	\N	\N
1810	Riachuelo	2805901	SE	2022-03-28	1	\N	\N	\N	\N
1811	Ribeirópolis	2806008	SE	2022-03-28	1	\N	\N	\N	\N
1812	Rosário do Catete	2806107	SE	2022-03-28	1	\N	\N	\N	\N
1813	Salgado	2806206	SE	2022-03-28	1	\N	\N	\N	\N
1814	Santa Luzia do Itanhy	2806305	SE	2022-03-28	1	\N	\N	\N	\N
1815	Santa Rosa de Lima	2806503	SE	2022-03-28	1	\N	\N	\N	\N
1816	Santana do São Francisco	2806404	SE	2022-03-28	1	\N	\N	\N	\N
1817	Santo Amaro das Brotas	2806602	SE	2022-03-28	1	\N	\N	\N	\N
1818	São Cristóvão	2806701	SE	2022-03-28	1	\N	\N	\N	\N
1819	São Domingos	2806800	SE	2022-03-28	1	\N	\N	\N	\N
1820	São Francisco	2806909	SE	2022-03-28	1	\N	\N	\N	\N
1821	São Miguel do Aleixo	2807006	SE	2022-03-28	1	\N	\N	\N	\N
1822	Simão Dias	2807105	SE	2022-03-28	1	\N	\N	\N	\N
1823	Siriri	2807204	SE	2022-03-28	1	\N	\N	\N	\N
1824	Telha	2807303	SE	2022-03-28	1	\N	\N	\N	\N
1825	Tobias Barreto	2807402	SE	2022-03-28	1	\N	\N	\N	\N
1826	Tomar do Geru	2807501	SE	2022-03-28	1	\N	\N	\N	\N
1827	Umbaúba	2807600	SE	2022-03-28	1	\N	\N	\N	\N
1828	Abaíra	2900108	BA	2022-03-28	1	\N	\N	\N	\N
1829	Abaré	2900207	BA	2022-03-28	1	\N	\N	\N	\N
1830	Acajutiba	2900306	BA	2022-03-28	1	\N	\N	\N	\N
1831	Adustina	2900355	BA	2022-03-28	1	\N	\N	\N	\N
1832	Água Fria	2900405	BA	2022-03-28	1	\N	\N	\N	\N
1833	Aiquara	2900603	BA	2022-03-28	1	\N	\N	\N	\N
1834	Alagoinhas	2900702	BA	2022-03-28	1	\N	\N	\N	\N
1835	Alcobaça	2900801	BA	2022-03-28	1	\N	\N	\N	\N
1836	Almadina	2900900	BA	2022-03-28	1	\N	\N	\N	\N
1837	Amargosa	2901007	BA	2022-03-28	1	\N	\N	\N	\N
1838	Amélia Rodrigues	2901106	BA	2022-03-28	1	\N	\N	\N	\N
1839	América Dourada	2901155	BA	2022-03-28	1	\N	\N	\N	\N
1840	Anagé	2901205	BA	2022-03-28	1	\N	\N	\N	\N
1841	Andaraí	2901304	BA	2022-03-28	1	\N	\N	\N	\N
1842	Andorinha	2901353	BA	2022-03-28	1	\N	\N	\N	\N
1843	Angical	2901403	BA	2022-03-28	1	\N	\N	\N	\N
1844	Anguera	2901502	BA	2022-03-28	1	\N	\N	\N	\N
1845	Antas	2901601	BA	2022-03-28	1	\N	\N	\N	\N
1846	Antônio Cardoso	2901700	BA	2022-03-28	1	\N	\N	\N	\N
1847	Antônio Gonçalves	2901809	BA	2022-03-28	1	\N	\N	\N	\N
1848	Aporá	2901908	BA	2022-03-28	1	\N	\N	\N	\N
1849	Apuarema	2901957	BA	2022-03-28	1	\N	\N	\N	\N
1850	Araçás	2902054	BA	2022-03-28	1	\N	\N	\N	\N
1851	Aracatu	2902005	BA	2022-03-28	1	\N	\N	\N	\N
1852	Araci	2902104	BA	2022-03-28	1	\N	\N	\N	\N
1853	Aramari	2902203	BA	2022-03-28	1	\N	\N	\N	\N
1854	Arataca	2902252	BA	2022-03-28	1	\N	\N	\N	\N
1855	Aratuípe	2902302	BA	2022-03-28	1	\N	\N	\N	\N
1856	Aurelino Leal	2902401	BA	2022-03-28	1	\N	\N	\N	\N
1857	Baianópolis	2902500	BA	2022-03-28	1	\N	\N	\N	\N
1858	Baixa Grande	2902609	BA	2022-03-28	1	\N	\N	\N	\N
1859	Banzaê	2902658	BA	2022-03-28	1	\N	\N	\N	\N
1860	Barra	2902708	BA	2022-03-28	1	\N	\N	\N	\N
1861	Barra da Estiva	2902807	BA	2022-03-28	1	\N	\N	\N	\N
1862	Barra do Choça	2902906	BA	2022-03-28	1	\N	\N	\N	\N
1863	Barra do Mendes	2903003	BA	2022-03-28	1	\N	\N	\N	\N
1864	Barra do Rocha	2903102	BA	2022-03-28	1	\N	\N	\N	\N
1865	Barreiras	2903201	BA	2022-03-28	1	\N	\N	\N	\N
1866	Barro Alto	2903235	BA	2022-03-28	1	\N	\N	\N	\N
1867	Barro Preto	2903300	BA	2022-03-28	1	\N	\N	\N	\N
1868	Barrocas	2903276	BA	2022-03-28	1	\N	\N	\N	\N
1869	Belmonte	2903409	BA	2022-03-28	1	\N	\N	\N	\N
1870	Belo Campo	2903508	BA	2022-03-28	1	\N	\N	\N	\N
1871	Biritinga	2903607	BA	2022-03-28	1	\N	\N	\N	\N
1872	Boa Nova	2903706	BA	2022-03-28	1	\N	\N	\N	\N
1873	Boa Vista do Tupim	2903805	BA	2022-03-28	1	\N	\N	\N	\N
1874	Bom Jesus da Lapa	2903904	BA	2022-03-28	1	\N	\N	\N	\N
1875	Bom Jesus da Serra	2903953	BA	2022-03-28	1	\N	\N	\N	\N
1876	Boninal	2904001	BA	2022-03-28	1	\N	\N	\N	\N
1877	Bonito	2904050	BA	2022-03-28	1	\N	\N	\N	\N
1878	Boquira	2904100	BA	2022-03-28	1	\N	\N	\N	\N
1879	Botuporã	2904209	BA	2022-03-28	1	\N	\N	\N	\N
1880	Brejões	2904308	BA	2022-03-28	1	\N	\N	\N	\N
1881	Brejolândia	2904407	BA	2022-03-28	1	\N	\N	\N	\N
1882	Brotas de Macaúbas	2904506	BA	2022-03-28	1	\N	\N	\N	\N
1883	Brumado	2904605	BA	2022-03-28	1	\N	\N	\N	\N
1884	Buerarema	2904704	BA	2022-03-28	1	\N	\N	\N	\N
1885	Buritirama	2904753	BA	2022-03-28	1	\N	\N	\N	\N
1886	Caatiba	2904803	BA	2022-03-28	1	\N	\N	\N	\N
1887	Cabaceiras do Paraguaçu	2904852	BA	2022-03-28	1	\N	\N	\N	\N
1888	Cachoeira	2904902	BA	2022-03-28	1	\N	\N	\N	\N
1889	Caculé	2905008	BA	2022-03-28	1	\N	\N	\N	\N
1890	Caém	2905107	BA	2022-03-28	1	\N	\N	\N	\N
1891	Caetanos	2905156	BA	2022-03-28	1	\N	\N	\N	\N
1892	Caetité	2905206	BA	2022-03-28	1	\N	\N	\N	\N
1893	Cafarnaum	2905305	BA	2022-03-28	1	\N	\N	\N	\N
1894	Cairu	2905404	BA	2022-03-28	1	\N	\N	\N	\N
1895	Caldeirão Grande	2905503	BA	2022-03-28	1	\N	\N	\N	\N
1896	Camacan	2905602	BA	2022-03-28	1	\N	\N	\N	\N
1897	Camaçari	2905701	BA	2022-03-28	1	\N	\N	\N	\N
1898	Camamu	2905800	BA	2022-03-28	1	\N	\N	\N	\N
1899	Campo Alegre de Lourdes	2905909	BA	2022-03-28	1	\N	\N	\N	\N
1900	Campo Formoso	2906006	BA	2022-03-28	1	\N	\N	\N	\N
1901	Canápolis	2906105	BA	2022-03-28	1	\N	\N	\N	\N
1902	Canarana	2906204	BA	2022-03-28	1	\N	\N	\N	\N
1903	Canavieiras	2906303	BA	2022-03-28	1	\N	\N	\N	\N
1904	Candeal	2906402	BA	2022-03-28	1	\N	\N	\N	\N
1905	Candeias	2906501	BA	2022-03-28	1	\N	\N	\N	\N
1906	Candiba	2906600	BA	2022-03-28	1	\N	\N	\N	\N
1907	Cândido Sales	2906709	BA	2022-03-28	1	\N	\N	\N	\N
1908	Cansanção	2906808	BA	2022-03-28	1	\N	\N	\N	\N
1909	Canudos	2906824	BA	2022-03-28	1	\N	\N	\N	\N
1910	Capela do Alto Alegre	2906857	BA	2022-03-28	1	\N	\N	\N	\N
1911	Capim Grosso	2906873	BA	2022-03-28	1	\N	\N	\N	\N
1912	Caraíbas	2906899	BA	2022-03-28	1	\N	\N	\N	\N
1913	Caravelas	2906907	BA	2022-03-28	1	\N	\N	\N	\N
1914	Cardeal da Silva	2907004	BA	2022-03-28	1	\N	\N	\N	\N
1915	Carinhanha	2907103	BA	2022-03-28	1	\N	\N	\N	\N
1916	Casa Nova	2907202	BA	2022-03-28	1	\N	\N	\N	\N
1917	Castro Alves	2907301	BA	2022-03-28	1	\N	\N	\N	\N
1918	Catolândia	2907400	BA	2022-03-28	1	\N	\N	\N	\N
1919	Catu	2907509	BA	2022-03-28	1	\N	\N	\N	\N
1920	Caturama	2907558	BA	2022-03-28	1	\N	\N	\N	\N
1921	Central	2907608	BA	2022-03-28	1	\N	\N	\N	\N
1922	Chorrochó	2907707	BA	2022-03-28	1	\N	\N	\N	\N
1923	Cícero Dantas	2907806	BA	2022-03-28	1	\N	\N	\N	\N
1924	Cipó	2907905	BA	2022-03-28	1	\N	\N	\N	\N
1925	Coaraci	2908002	BA	2022-03-28	1	\N	\N	\N	\N
1926	Cocos	2908101	BA	2022-03-28	1	\N	\N	\N	\N
1927	Conceição da Feira	2908200	BA	2022-03-28	1	\N	\N	\N	\N
1928	Conceição do Almeida	2908309	BA	2022-03-28	1	\N	\N	\N	\N
1929	Conceição do Coité	2908408	BA	2022-03-28	1	\N	\N	\N	\N
1930	Conceição do Jacuípe	2908507	BA	2022-03-28	1	\N	\N	\N	\N
1931	Conde	2908606	BA	2022-03-28	1	\N	\N	\N	\N
1932	Condeúba	2908705	BA	2022-03-28	1	\N	\N	\N	\N
1933	Contendas do Sincorá	2908804	BA	2022-03-28	1	\N	\N	\N	\N
1934	Coração de Maria	2908903	BA	2022-03-28	1	\N	\N	\N	\N
1935	Cordeiros	2909000	BA	2022-03-28	1	\N	\N	\N	\N
1936	Coribe	2909109	BA	2022-03-28	1	\N	\N	\N	\N
1937	Coronel João Sá	2909208	BA	2022-03-28	1	\N	\N	\N	\N
1938	Correntina	2909307	BA	2022-03-28	1	\N	\N	\N	\N
1939	Cotegipe	2909406	BA	2022-03-28	1	\N	\N	\N	\N
1940	Cravolândia	2909505	BA	2022-03-28	1	\N	\N	\N	\N
1941	Crisópolis	2909604	BA	2022-03-28	1	\N	\N	\N	\N
1942	Cristópolis	2909703	BA	2022-03-28	1	\N	\N	\N	\N
1943	Cruz das Almas	2909802	BA	2022-03-28	1	\N	\N	\N	\N
1944	Curaçá	2909901	BA	2022-03-28	1	\N	\N	\N	\N
1945	Dário Meira	2910008	BA	2022-03-28	1	\N	\N	\N	\N
1946	'Dias d''Ávila'	2910057	BA	2022-03-28	1	\N	\N	\N	\N
1947	Dom Basílio	2910107	BA	2022-03-28	1	\N	\N	\N	\N
1948	Dom Macedo Costa	2910206	BA	2022-03-28	1	\N	\N	\N	\N
1949	Elísio Medrado	2910305	BA	2022-03-28	1	\N	\N	\N	\N
1950	Encruzilhada	2910404	BA	2022-03-28	1	\N	\N	\N	\N
1951	Entre Rios	2910503	BA	2022-03-28	1	\N	\N	\N	\N
1952	Érico Cardoso	2900504	BA	2022-03-28	1	\N	\N	\N	\N
1953	Esplanada	2910602	BA	2022-03-28	1	\N	\N	\N	\N
1954	Euclides da Cunha	2910701	BA	2022-03-28	1	\N	\N	\N	\N
1955	Eunápolis	2910727	BA	2022-03-28	1	\N	\N	\N	\N
1956	Fátima	2910750	BA	2022-03-28	1	\N	\N	\N	\N
1957	Feira da Mata	2910776	BA	2022-03-28	1	\N	\N	\N	\N
1958	Feira de Santana	2910800	BA	2022-03-28	1	\N	\N	\N	\N
1959	Filadélfia	2910859	BA	2022-03-28	1	\N	\N	\N	\N
1960	Firmino Alves	2910909	BA	2022-03-28	1	\N	\N	\N	\N
1961	Floresta Azul	2911006	BA	2022-03-28	1	\N	\N	\N	\N
1962	Formosa do Rio Preto	2911105	BA	2022-03-28	1	\N	\N	\N	\N
1963	Gandu	2911204	BA	2022-03-28	1	\N	\N	\N	\N
1964	Gavião	2911253	BA	2022-03-28	1	\N	\N	\N	\N
1965	Gentio do Ouro	2911303	BA	2022-03-28	1	\N	\N	\N	\N
1966	Glória	2911402	BA	2022-03-28	1	\N	\N	\N	\N
1967	Gongogi	2911501	BA	2022-03-28	1	\N	\N	\N	\N
1968	Governador Mangabeira	2911600	BA	2022-03-28	1	\N	\N	\N	\N
1969	Guajeru	2911659	BA	2022-03-28	1	\N	\N	\N	\N
1970	Guanambi	2911709	BA	2022-03-28	1	\N	\N	\N	\N
1971	Guaratinga	2911808	BA	2022-03-28	1	\N	\N	\N	\N
1972	Heliópolis	2911857	BA	2022-03-28	1	\N	\N	\N	\N
1973	Iaçu	2911907	BA	2022-03-28	1	\N	\N	\N	\N
1974	Ibiassucê	2912004	BA	2022-03-28	1	\N	\N	\N	\N
1975	Ibicaraí	2912103	BA	2022-03-28	1	\N	\N	\N	\N
1976	Ibicoara	2912202	BA	2022-03-28	1	\N	\N	\N	\N
1977	Ibicuí	2912301	BA	2022-03-28	1	\N	\N	\N	\N
1978	Ibipeba	2912400	BA	2022-03-28	1	\N	\N	\N	\N
1979	Ibipitanga	2912509	BA	2022-03-28	1	\N	\N	\N	\N
1980	Ibiquera	2912608	BA	2022-03-28	1	\N	\N	\N	\N
1981	Ibirapitanga	2912707	BA	2022-03-28	1	\N	\N	\N	\N
1982	Ibirapuã	2912806	BA	2022-03-28	1	\N	\N	\N	\N
1983	Ibirataia	2912905	BA	2022-03-28	1	\N	\N	\N	\N
1984	Ibitiara	2913002	BA	2022-03-28	1	\N	\N	\N	\N
1985	Ibititá	2913101	BA	2022-03-28	1	\N	\N	\N	\N
1986	Ibotirama	2913200	BA	2022-03-28	1	\N	\N	\N	\N
1987	Ichu	2913309	BA	2022-03-28	1	\N	\N	\N	\N
1988	Igaporã	2913408	BA	2022-03-28	1	\N	\N	\N	\N
1989	Igrapiúna	2913457	BA	2022-03-28	1	\N	\N	\N	\N
1990	Iguaí	2913507	BA	2022-03-28	1	\N	\N	\N	\N
1991	Ilhéus	2913606	BA	2022-03-28	1	\N	\N	\N	\N
1992	Inhambupe	2913705	BA	2022-03-28	1	\N	\N	\N	\N
1993	Ipecaetá	2913804	BA	2022-03-28	1	\N	\N	\N	\N
1994	Ipiaú	2913903	BA	2022-03-28	1	\N	\N	\N	\N
1995	Ipirá	2914000	BA	2022-03-28	1	\N	\N	\N	\N
1996	Ipupiara	2914109	BA	2022-03-28	1	\N	\N	\N	\N
1997	Irajuba	2914208	BA	2022-03-28	1	\N	\N	\N	\N
1998	Iramaia	2914307	BA	2022-03-28	1	\N	\N	\N	\N
1999	Iraquara	2914406	BA	2022-03-28	1	\N	\N	\N	\N
2000	Irará	2914505	BA	2022-03-28	1	\N	\N	\N	\N
2001	Irecê	2914604	BA	2022-03-28	1	\N	\N	\N	\N
2002	Itabela	2914653	BA	2022-03-28	1	\N	\N	\N	\N
2003	Itaberaba	2914703	BA	2022-03-28	1	\N	\N	\N	\N
2004	Itabuna	2914802	BA	2022-03-28	1	\N	\N	\N	\N
2005	Itacaré	2914901	BA	2022-03-28	1	\N	\N	\N	\N
2006	Itaeté	2915007	BA	2022-03-28	1	\N	\N	\N	\N
2007	Itagi	2915106	BA	2022-03-28	1	\N	\N	\N	\N
2008	Itagibá	2915205	BA	2022-03-28	1	\N	\N	\N	\N
2009	Itagimirim	2915304	BA	2022-03-28	1	\N	\N	\N	\N
2010	Itaguaçu da Bahia	2915353	BA	2022-03-28	1	\N	\N	\N	\N
2011	Itaju do Colônia	2915403	BA	2022-03-28	1	\N	\N	\N	\N
2012	Itajuípe	2915502	BA	2022-03-28	1	\N	\N	\N	\N
2013	Itamaraju	2915601	BA	2022-03-28	1	\N	\N	\N	\N
2014	Itamari	2915700	BA	2022-03-28	1	\N	\N	\N	\N
2015	Itambé	2915809	BA	2022-03-28	1	\N	\N	\N	\N
2016	Itanagra	2915908	BA	2022-03-28	1	\N	\N	\N	\N
2017	Itanhém	2916005	BA	2022-03-28	1	\N	\N	\N	\N
2018	Itaparica	2916104	BA	2022-03-28	1	\N	\N	\N	\N
2019	Itapé	2916203	BA	2022-03-28	1	\N	\N	\N	\N
2020	Itapebi	2916302	BA	2022-03-28	1	\N	\N	\N	\N
2021	Itapetinga	2916401	BA	2022-03-28	1	\N	\N	\N	\N
2022	Itapicuru	2916500	BA	2022-03-28	1	\N	\N	\N	\N
2023	Itapitanga	2916609	BA	2022-03-28	1	\N	\N	\N	\N
2024	Itaquara	2916708	BA	2022-03-28	1	\N	\N	\N	\N
2025	Itarantim	2916807	BA	2022-03-28	1	\N	\N	\N	\N
2026	Itatim	2916856	BA	2022-03-28	1	\N	\N	\N	\N
2027	Itiruçu	2916906	BA	2022-03-28	1	\N	\N	\N	\N
2028	Itiúba	2917003	BA	2022-03-28	1	\N	\N	\N	\N
2029	Itororó	2917102	BA	2022-03-28	1	\N	\N	\N	\N
2030	Ituaçu	2917201	BA	2022-03-28	1	\N	\N	\N	\N
2031	Ituberá	2917300	BA	2022-03-28	1	\N	\N	\N	\N
2032	Iuiu	2917334	BA	2022-03-28	1	\N	\N	\N	\N
2033	Jaborandi	2917359	BA	2022-03-28	1	\N	\N	\N	\N
2034	Jacaraci	2917409	BA	2022-03-28	1	\N	\N	\N	\N
2035	Jacobina	2917508	BA	2022-03-28	1	\N	\N	\N	\N
2036	Jaguaquara	2917607	BA	2022-03-28	1	\N	\N	\N	\N
2037	Jaguarari	2917706	BA	2022-03-28	1	\N	\N	\N	\N
2038	Jaguaripe	2917805	BA	2022-03-28	1	\N	\N	\N	\N
2039	Jandaíra	2917904	BA	2022-03-28	1	\N	\N	\N	\N
2040	Jequié	2918001	BA	2022-03-28	1	\N	\N	\N	\N
2041	Jeremoabo	2918100	BA	2022-03-28	1	\N	\N	\N	\N
2042	Jiquiriçá	2918209	BA	2022-03-28	1	\N	\N	\N	\N
2043	Jitaúna	2918308	BA	2022-03-28	1	\N	\N	\N	\N
2044	João Dourado	2918357	BA	2022-03-28	1	\N	\N	\N	\N
2045	Juazeiro	2918407	BA	2022-03-28	1	\N	\N	\N	\N
2046	Jucuruçu	2918456	BA	2022-03-28	1	\N	\N	\N	\N
2047	Jussara	2918506	BA	2022-03-28	1	\N	\N	\N	\N
2048	Jussari	2918555	BA	2022-03-28	1	\N	\N	\N	\N
2049	Jussiape	2918605	BA	2022-03-28	1	\N	\N	\N	\N
2050	Lafaiete Coutinho	2918704	BA	2022-03-28	1	\N	\N	\N	\N
2051	Lagoa Real	2918753	BA	2022-03-28	1	\N	\N	\N	\N
2052	Laje	2918803	BA	2022-03-28	1	\N	\N	\N	\N
2053	Lajedão	2918902	BA	2022-03-28	1	\N	\N	\N	\N
2054	Lajedinho	2919009	BA	2022-03-28	1	\N	\N	\N	\N
2055	Lajedo do Tabocal	2919058	BA	2022-03-28	1	\N	\N	\N	\N
2056	Lamarão	2919108	BA	2022-03-28	1	\N	\N	\N	\N
2057	Lapão	2919157	BA	2022-03-28	1	\N	\N	\N	\N
2058	Lauro de Freitas	2919207	BA	2022-03-28	1	\N	\N	\N	\N
2059	Lençóis	2919306	BA	2022-03-28	1	\N	\N	\N	\N
2060	Licínio de Almeida	2919405	BA	2022-03-28	1	\N	\N	\N	\N
2061	Livramento de Nossa Senhora	2919504	BA	2022-03-28	1	\N	\N	\N	\N
2062	Luís Eduardo Magalhães	2919553	BA	2022-03-28	1	\N	\N	\N	\N
2063	Macajuba	2919603	BA	2022-03-28	1	\N	\N	\N	\N
2064	Macarani	2919702	BA	2022-03-28	1	\N	\N	\N	\N
2065	Macaúbas	2919801	BA	2022-03-28	1	\N	\N	\N	\N
2066	Macururé	2919900	BA	2022-03-28	1	\N	\N	\N	\N
2067	Madre de Deus	2919926	BA	2022-03-28	1	\N	\N	\N	\N
2068	Maetinga	2919959	BA	2022-03-28	1	\N	\N	\N	\N
2069	Maiquinique	2920007	BA	2022-03-28	1	\N	\N	\N	\N
2070	Mairi	2920106	BA	2022-03-28	1	\N	\N	\N	\N
2071	Malhada	2920205	BA	2022-03-28	1	\N	\N	\N	\N
2072	Malhada de Pedras	2920304	BA	2022-03-28	1	\N	\N	\N	\N
2073	Manoel Vitorino	2920403	BA	2022-03-28	1	\N	\N	\N	\N
2074	Mansidão	2920452	BA	2022-03-28	1	\N	\N	\N	\N
2075	Maracás	2920502	BA	2022-03-28	1	\N	\N	\N	\N
2076	Maragogipe	2920601	BA	2022-03-28	1	\N	\N	\N	\N
2077	Maraú	2920700	BA	2022-03-28	1	\N	\N	\N	\N
2078	Marcionílio Souza	2920809	BA	2022-03-28	1	\N	\N	\N	\N
2079	Mascote	2920908	BA	2022-03-28	1	\N	\N	\N	\N
2080	Mata de São João	2921005	BA	2022-03-28	1	\N	\N	\N	\N
2081	Matina	2921054	BA	2022-03-28	1	\N	\N	\N	\N
2082	Medeiros Neto	2921104	BA	2022-03-28	1	\N	\N	\N	\N
2083	Miguel Calmon	2921203	BA	2022-03-28	1	\N	\N	\N	\N
2084	Milagres	2921302	BA	2022-03-28	1	\N	\N	\N	\N
2085	Mirangaba	2921401	BA	2022-03-28	1	\N	\N	\N	\N
2086	Mirante	2921450	BA	2022-03-28	1	\N	\N	\N	\N
2087	Monte Santo	2921500	BA	2022-03-28	1	\N	\N	\N	\N
2088	Morpará	2921609	BA	2022-03-28	1	\N	\N	\N	\N
2089	Morro do Chapéu	2921708	BA	2022-03-28	1	\N	\N	\N	\N
2090	Mortugaba	2921807	BA	2022-03-28	1	\N	\N	\N	\N
2091	Mucugê	2921906	BA	2022-03-28	1	\N	\N	\N	\N
2092	Mucuri	2922003	BA	2022-03-28	1	\N	\N	\N	\N
2093	Mulungu do Morro	2922052	BA	2022-03-28	1	\N	\N	\N	\N
2094	Mundo Novo	2922102	BA	2022-03-28	1	\N	\N	\N	\N
2095	Muniz Ferreira	2922201	BA	2022-03-28	1	\N	\N	\N	\N
2096	Muquém do São Francisco	2922250	BA	2022-03-28	1	\N	\N	\N	\N
2097	Muritiba	2922300	BA	2022-03-28	1	\N	\N	\N	\N
2098	Mutuípe	2922409	BA	2022-03-28	1	\N	\N	\N	\N
2099	Nazaré	2922508	BA	2022-03-28	1	\N	\N	\N	\N
2100	Nilo Peçanha	2922607	BA	2022-03-28	1	\N	\N	\N	\N
2101	Nordestina	2922656	BA	2022-03-28	1	\N	\N	\N	\N
2102	Nova Canaã	2922706	BA	2022-03-28	1	\N	\N	\N	\N
2103	Nova Fátima	2922730	BA	2022-03-28	1	\N	\N	\N	\N
2104	Nova Ibiá	2922755	BA	2022-03-28	1	\N	\N	\N	\N
2105	Nova Itarana	2922805	BA	2022-03-28	1	\N	\N	\N	\N
2106	Nova Redenção	2922854	BA	2022-03-28	1	\N	\N	\N	\N
2107	Nova Soure	2922904	BA	2022-03-28	1	\N	\N	\N	\N
2108	Nova Viçosa	2923001	BA	2022-03-28	1	\N	\N	\N	\N
2109	Novo Horizonte	2923035	BA	2022-03-28	1	\N	\N	\N	\N
2110	Novo Triunfo	2923050	BA	2022-03-28	1	\N	\N	\N	\N
2111	Olindina	2923100	BA	2022-03-28	1	\N	\N	\N	\N
2112	Oliveira dos Brejinhos	2923209	BA	2022-03-28	1	\N	\N	\N	\N
2113	Ouriçangas	2923308	BA	2022-03-28	1	\N	\N	\N	\N
2114	Ourolândia	2923357	BA	2022-03-28	1	\N	\N	\N	\N
2115	Palmas de Monte Alto	2923407	BA	2022-03-28	1	\N	\N	\N	\N
2116	Palmeiras	2923506	BA	2022-03-28	1	\N	\N	\N	\N
2117	Paramirim	2923605	BA	2022-03-28	1	\N	\N	\N	\N
2118	Paratinga	2923704	BA	2022-03-28	1	\N	\N	\N	\N
2119	Paripiranga	2923803	BA	2022-03-28	1	\N	\N	\N	\N
2120	Pau Brasil	2923902	BA	2022-03-28	1	\N	\N	\N	\N
2121	Paulo Afonso	2924009	BA	2022-03-28	1	\N	\N	\N	\N
2872	Raposos	3153905	MG	2022-03-28	1	\N	\N	\N	\N
2122	Pé de Serra	2924058	BA	2022-03-28	1	\N	\N	\N	\N
2123	Pedrão	2924108	BA	2022-03-28	1	\N	\N	\N	\N
2124	Pedro Alexandre	2924207	BA	2022-03-28	1	\N	\N	\N	\N
2125	Piatã	2924306	BA	2022-03-28	1	\N	\N	\N	\N
2126	Pilão Arcado	2924405	BA	2022-03-28	1	\N	\N	\N	\N
2127	Pindaí	2924504	BA	2022-03-28	1	\N	\N	\N	\N
2128	Pindobaçu	2924603	BA	2022-03-28	1	\N	\N	\N	\N
2129	Pintadas	2924652	BA	2022-03-28	1	\N	\N	\N	\N
2130	Piraí do Norte	2924678	BA	2022-03-28	1	\N	\N	\N	\N
2131	Piripá	2924702	BA	2022-03-28	1	\N	\N	\N	\N
2132	Piritiba	2924801	BA	2022-03-28	1	\N	\N	\N	\N
2133	Planaltino	2924900	BA	2022-03-28	1	\N	\N	\N	\N
2134	Planalto	2925006	BA	2022-03-28	1	\N	\N	\N	\N
2135	Poções	2925105	BA	2022-03-28	1	\N	\N	\N	\N
2136	Pojuca	2925204	BA	2022-03-28	1	\N	\N	\N	\N
2137	Ponto Novo	2925253	BA	2022-03-28	1	\N	\N	\N	\N
2138	Porto Seguro	2925303	BA	2022-03-28	1	\N	\N	\N	\N
2139	Potiraguá	2925402	BA	2022-03-28	1	\N	\N	\N	\N
2140	Prado	2925501	BA	2022-03-28	1	\N	\N	\N	\N
2141	Presidente Dutra	2925600	BA	2022-03-28	1	\N	\N	\N	\N
2142	Presidente Jânio Quadros	2925709	BA	2022-03-28	1	\N	\N	\N	\N
2143	Presidente Tancredo Neves	2925758	BA	2022-03-28	1	\N	\N	\N	\N
2144	Queimadas	2925808	BA	2022-03-28	1	\N	\N	\N	\N
2145	Quijingue	2925907	BA	2022-03-28	1	\N	\N	\N	\N
2146	Quixabeira	2925931	BA	2022-03-28	1	\N	\N	\N	\N
2147	Rafael Jambeiro	2925956	BA	2022-03-28	1	\N	\N	\N	\N
2148	Remanso	2926004	BA	2022-03-28	1	\N	\N	\N	\N
2149	Retirolândia	2926103	BA	2022-03-28	1	\N	\N	\N	\N
2150	Riachão das Neves	2926202	BA	2022-03-28	1	\N	\N	\N	\N
2151	Riachão do Jacuípe	2926301	BA	2022-03-28	1	\N	\N	\N	\N
2152	Riacho de Santana	2926400	BA	2022-03-28	1	\N	\N	\N	\N
2153	Ribeira do Amparo	2926509	BA	2022-03-28	1	\N	\N	\N	\N
2154	Ribeira do Pombal	2926608	BA	2022-03-28	1	\N	\N	\N	\N
2155	Ribeirão do Largo	2926657	BA	2022-03-28	1	\N	\N	\N	\N
2156	Rio de Contas	2926707	BA	2022-03-28	1	\N	\N	\N	\N
2157	Rio do Antônio	2926806	BA	2022-03-28	1	\N	\N	\N	\N
2158	Rio do Pires	2926905	BA	2022-03-28	1	\N	\N	\N	\N
2159	Rio Real	2927002	BA	2022-03-28	1	\N	\N	\N	\N
2160	Rodelas	2927101	BA	2022-03-28	1	\N	\N	\N	\N
2161	Ruy Barbosa	2927200	BA	2022-03-28	1	\N	\N	\N	\N
2162	Salinas da Margarida	2927309	BA	2022-03-28	1	\N	\N	\N	\N
2163	Salvador	2927408	BA	2022-03-28	1	\N	\N	\N	\N
2164	Santa Bárbara	2927507	BA	2022-03-28	1	\N	\N	\N	\N
2165	Santa Brígida	2927606	BA	2022-03-28	1	\N	\N	\N	\N
2166	Santa Cruz Cabrália	2927705	BA	2022-03-28	1	\N	\N	\N	\N
2167	Santa Cruz da Vitória	2927804	BA	2022-03-28	1	\N	\N	\N	\N
2168	Santa Inês	2927903	BA	2022-03-28	1	\N	\N	\N	\N
2169	Santa Luzia	2928059	BA	2022-03-28	1	\N	\N	\N	\N
2170	Santa Maria da Vitória	2928109	BA	2022-03-28	1	\N	\N	\N	\N
2171	Santa Rita de Cássia	2928406	BA	2022-03-28	1	\N	\N	\N	\N
2172	Santa Terezinha	2928505	BA	2022-03-28	1	\N	\N	\N	\N
2173	Santaluz	2928000	BA	2022-03-28	1	\N	\N	\N	\N
2174	Santana	2928208	BA	2022-03-28	1	\N	\N	\N	\N
2175	Santanópolis	2928307	BA	2022-03-28	1	\N	\N	\N	\N
2176	Santo Amaro	2928604	BA	2022-03-28	1	\N	\N	\N	\N
2177	Santo Antônio de Jesus	2928703	BA	2022-03-28	1	\N	\N	\N	\N
2178	Santo Estêvão	2928802	BA	2022-03-28	1	\N	\N	\N	\N
2179	São Desidério	2928901	BA	2022-03-28	1	\N	\N	\N	\N
2180	São Domingos	2928950	BA	2022-03-28	1	\N	\N	\N	\N
2181	São Felipe	2929107	BA	2022-03-28	1	\N	\N	\N	\N
2182	São Félix	2929008	BA	2022-03-28	1	\N	\N	\N	\N
2183	São Félix do Coribe	2929057	BA	2022-03-28	1	\N	\N	\N	\N
2184	São Francisco do Conde	2929206	BA	2022-03-28	1	\N	\N	\N	\N
2185	São Gabriel	2929255	BA	2022-03-28	1	\N	\N	\N	\N
2186	São Gonçalo dos Campos	2929305	BA	2022-03-28	1	\N	\N	\N	\N
2187	São José da Vitória	2929354	BA	2022-03-28	1	\N	\N	\N	\N
2188	São José do Jacuípe	2929370	BA	2022-03-28	1	\N	\N	\N	\N
2189	São Miguel das Matas	2929404	BA	2022-03-28	1	\N	\N	\N	\N
2190	São Sebastião do Passé	2929503	BA	2022-03-28	1	\N	\N	\N	\N
2191	Sapeaçu	2929602	BA	2022-03-28	1	\N	\N	\N	\N
2192	Sátiro Dias	2929701	BA	2022-03-28	1	\N	\N	\N	\N
2193	Saubara	2929750	BA	2022-03-28	1	\N	\N	\N	\N
2194	Saúde	2929800	BA	2022-03-28	1	\N	\N	\N	\N
2195	Seabra	2929909	BA	2022-03-28	1	\N	\N	\N	\N
2196	Sebastião Laranjeiras	2930006	BA	2022-03-28	1	\N	\N	\N	\N
2197	Senhor do Bonfim	2930105	BA	2022-03-28	1	\N	\N	\N	\N
2198	Sento Sé	2930204	BA	2022-03-28	1	\N	\N	\N	\N
2199	Serra do Ramalho	2930154	BA	2022-03-28	1	\N	\N	\N	\N
2200	Serra Dourada	2930303	BA	2022-03-28	1	\N	\N	\N	\N
2201	Serra Preta	2930402	BA	2022-03-28	1	\N	\N	\N	\N
2202	Serrinha	2930501	BA	2022-03-28	1	\N	\N	\N	\N
2203	Serrolândia	2930600	BA	2022-03-28	1	\N	\N	\N	\N
2204	Simões Filho	2930709	BA	2022-03-28	1	\N	\N	\N	\N
2205	Sítio do Mato	2930758	BA	2022-03-28	1	\N	\N	\N	\N
2206	Sítio do Quinto	2930766	BA	2022-03-28	1	\N	\N	\N	\N
2207	Sobradinho	2930774	BA	2022-03-28	1	\N	\N	\N	\N
2208	Souto Soares	2930808	BA	2022-03-28	1	\N	\N	\N	\N
2209	Tabocas do Brejo Velho	2930907	BA	2022-03-28	1	\N	\N	\N	\N
2210	Tanhaçu	2931004	BA	2022-03-28	1	\N	\N	\N	\N
2211	Tanque Novo	2931053	BA	2022-03-28	1	\N	\N	\N	\N
2212	Tanquinho	2931103	BA	2022-03-28	1	\N	\N	\N	\N
2213	Taperoá	2931202	BA	2022-03-28	1	\N	\N	\N	\N
2214	Tapiramutá	2931301	BA	2022-03-28	1	\N	\N	\N	\N
2215	Teixeira de Freitas	2931350	BA	2022-03-28	1	\N	\N	\N	\N
2216	Teodoro Sampaio	2931400	BA	2022-03-28	1	\N	\N	\N	\N
2217	Teofilândia	2931509	BA	2022-03-28	1	\N	\N	\N	\N
2218	Teolândia	2931608	BA	2022-03-28	1	\N	\N	\N	\N
2219	Terra Nova	2931707	BA	2022-03-28	1	\N	\N	\N	\N
2220	Tremedal	2931806	BA	2022-03-28	1	\N	\N	\N	\N
2221	Tucano	2931905	BA	2022-03-28	1	\N	\N	\N	\N
2222	Uauá	2932002	BA	2022-03-28	1	\N	\N	\N	\N
2223	Ubaíra	2932101	BA	2022-03-28	1	\N	\N	\N	\N
2224	Ubaitaba	2932200	BA	2022-03-28	1	\N	\N	\N	\N
2225	Ubatã	2932309	BA	2022-03-28	1	\N	\N	\N	\N
2226	Uibaí	2932408	BA	2022-03-28	1	\N	\N	\N	\N
3075	Urucuia	3170529	MG	2022-03-28	1	\N	\N	\N	\N
2227	Umburanas	2932457	BA	2022-03-28	1	\N	\N	\N	\N
2228	Una	2932507	BA	2022-03-28	1	\N	\N	\N	\N
2229	Urandi	2932606	BA	2022-03-28	1	\N	\N	\N	\N
2230	Uruçuca	2932705	BA	2022-03-28	1	\N	\N	\N	\N
2231	Utinga	2932804	BA	2022-03-28	1	\N	\N	\N	\N
2232	Valença	2932903	BA	2022-03-28	1	\N	\N	\N	\N
2233	Valente	2933000	BA	2022-03-28	1	\N	\N	\N	\N
2234	Várzea da Roça	2933059	BA	2022-03-28	1	\N	\N	\N	\N
2235	Várzea do Poço	2933109	BA	2022-03-28	1	\N	\N	\N	\N
2236	Várzea Nova	2933158	BA	2022-03-28	1	\N	\N	\N	\N
2237	Varzedo	2933174	BA	2022-03-28	1	\N	\N	\N	\N
2238	Vera Cruz	2933208	BA	2022-03-28	1	\N	\N	\N	\N
2239	Vereda	2933257	BA	2022-03-28	1	\N	\N	\N	\N
2240	Vitória da Conquista	2933307	BA	2022-03-28	1	\N	\N	\N	\N
2241	Wagner	2933406	BA	2022-03-28	1	\N	\N	\N	\N
2242	Wanderley	2933455	BA	2022-03-28	1	\N	\N	\N	\N
2243	Wenceslau Guimarães	2933505	BA	2022-03-28	1	\N	\N	\N	\N
2244	Xique-Xique	2933604	BA	2022-03-28	1	\N	\N	\N	\N
2245	Abadia dos Dourados	3100104	MG	2022-03-28	1	\N	\N	\N	\N
2246	Abaeté	3100203	MG	2022-03-28	1	\N	\N	\N	\N
2247	Abre Campo	3100302	MG	2022-03-28	1	\N	\N	\N	\N
2248	Acaiaca	3100401	MG	2022-03-28	1	\N	\N	\N	\N
2249	Açucena	3100500	MG	2022-03-28	1	\N	\N	\N	\N
2250	Água Boa	3100609	MG	2022-03-28	1	\N	\N	\N	\N
2251	Água Comprida	3100708	MG	2022-03-28	1	\N	\N	\N	\N
2252	Aguanil	3100807	MG	2022-03-28	1	\N	\N	\N	\N
2253	Águas Formosas	3100906	MG	2022-03-28	1	\N	\N	\N	\N
2254	Águas Vermelhas	3101003	MG	2022-03-28	1	\N	\N	\N	\N
2255	Aimorés	3101102	MG	2022-03-28	1	\N	\N	\N	\N
2256	Aiuruoca	3101201	MG	2022-03-28	1	\N	\N	\N	\N
2257	Alagoa	3101300	MG	2022-03-28	1	\N	\N	\N	\N
2258	Albertina	3101409	MG	2022-03-28	1	\N	\N	\N	\N
2259	Além Paraíba	3101508	MG	2022-03-28	1	\N	\N	\N	\N
2260	Alfenas	3101607	MG	2022-03-28	1	\N	\N	\N	\N
2261	Alfredo Vasconcelos	3101631	MG	2022-03-28	1	\N	\N	\N	\N
2262	Almenara	3101706	MG	2022-03-28	1	\N	\N	\N	\N
2263	Alpercata	3101805	MG	2022-03-28	1	\N	\N	\N	\N
2264	Alpinópolis	3101904	MG	2022-03-28	1	\N	\N	\N	\N
2265	Alterosa	3102001	MG	2022-03-28	1	\N	\N	\N	\N
2266	Alto Caparaó	3102050	MG	2022-03-28	1	\N	\N	\N	\N
2267	Alto Jequitibá	3153509	MG	2022-03-28	1	\N	\N	\N	\N
2268	Alto Rio Doce	3102100	MG	2022-03-28	1	\N	\N	\N	\N
2269	Alvarenga	3102209	MG	2022-03-28	1	\N	\N	\N	\N
2270	Alvinópolis	3102308	MG	2022-03-28	1	\N	\N	\N	\N
2271	Alvorada de Minas	3102407	MG	2022-03-28	1	\N	\N	\N	\N
2272	Amparo do Serra	3102506	MG	2022-03-28	1	\N	\N	\N	\N
2273	Andradas	3102605	MG	2022-03-28	1	\N	\N	\N	\N
2274	Andrelândia	3102803	MG	2022-03-28	1	\N	\N	\N	\N
2275	Angelândia	3102852	MG	2022-03-28	1	\N	\N	\N	\N
2276	Antônio Carlos	3102902	MG	2022-03-28	1	\N	\N	\N	\N
2277	Antônio Dias	3103009	MG	2022-03-28	1	\N	\N	\N	\N
2278	Antônio Prado de Minas	3103108	MG	2022-03-28	1	\N	\N	\N	\N
2279	Araçaí	3103207	MG	2022-03-28	1	\N	\N	\N	\N
2280	Aracitaba	3103306	MG	2022-03-28	1	\N	\N	\N	\N
2281	Araçuaí	3103405	MG	2022-03-28	1	\N	\N	\N	\N
2282	Araguari	3103504	MG	2022-03-28	1	\N	\N	\N	\N
2283	Arantina	3103603	MG	2022-03-28	1	\N	\N	\N	\N
2284	Araponga	3103702	MG	2022-03-28	1	\N	\N	\N	\N
2285	Araporã	3103751	MG	2022-03-28	1	\N	\N	\N	\N
2286	Arapuá	3103801	MG	2022-03-28	1	\N	\N	\N	\N
2287	Araújos	3103900	MG	2022-03-28	1	\N	\N	\N	\N
2288	Araxá	3104007	MG	2022-03-28	1	\N	\N	\N	\N
2289	Arceburgo	3104106	MG	2022-03-28	1	\N	\N	\N	\N
2290	Arcos	3104205	MG	2022-03-28	1	\N	\N	\N	\N
2291	Areado	3104304	MG	2022-03-28	1	\N	\N	\N	\N
2292	Argirita	3104403	MG	2022-03-28	1	\N	\N	\N	\N
2293	Aricanduva	3104452	MG	2022-03-28	1	\N	\N	\N	\N
2294	Arinos	3104502	MG	2022-03-28	1	\N	\N	\N	\N
2295	Astolfo Dutra	3104601	MG	2022-03-28	1	\N	\N	\N	\N
2296	Ataléia	3104700	MG	2022-03-28	1	\N	\N	\N	\N
2297	Augusto de Lima	3104809	MG	2022-03-28	1	\N	\N	\N	\N
2298	Baependi	3104908	MG	2022-03-28	1	\N	\N	\N	\N
2299	Baldim	3105004	MG	2022-03-28	1	\N	\N	\N	\N
2300	Bambuí	3105103	MG	2022-03-28	1	\N	\N	\N	\N
2301	Bandeira	3105202	MG	2022-03-28	1	\N	\N	\N	\N
2302	Bandeira do Sul	3105301	MG	2022-03-28	1	\N	\N	\N	\N
2303	Barão de Cocais	3105400	MG	2022-03-28	1	\N	\N	\N	\N
2304	Barão de Monte Alto	3105509	MG	2022-03-28	1	\N	\N	\N	\N
2305	Barbacena	3105608	MG	2022-03-28	1	\N	\N	\N	\N
2306	Barra Longa	3105707	MG	2022-03-28	1	\N	\N	\N	\N
2307	Barroso	3105905	MG	2022-03-28	1	\N	\N	\N	\N
2308	Bela Vista de Minas	3106002	MG	2022-03-28	1	\N	\N	\N	\N
2309	Belmiro Braga	3106101	MG	2022-03-28	1	\N	\N	\N	\N
2310	Belo Horizonte	3106200	MG	2022-03-28	1	\N	\N	\N	\N
2311	Belo Oriente	3106309	MG	2022-03-28	1	\N	\N	\N	\N
2312	Belo Vale	3106408	MG	2022-03-28	1	\N	\N	\N	\N
2313	Berilo	3106507	MG	2022-03-28	1	\N	\N	\N	\N
2314	Berizal	3106655	MG	2022-03-28	1	\N	\N	\N	\N
2315	Bertópolis	3106606	MG	2022-03-28	1	\N	\N	\N	\N
2316	Betim	3106705	MG	2022-03-28	1	\N	\N	\N	\N
2317	Bias Fortes	3106804	MG	2022-03-28	1	\N	\N	\N	\N
2318	Bicas	3106903	MG	2022-03-28	1	\N	\N	\N	\N
2319	Biquinhas	3107000	MG	2022-03-28	1	\N	\N	\N	\N
2320	Boa Esperança	3107109	MG	2022-03-28	1	\N	\N	\N	\N
2321	Bocaina de Minas	3107208	MG	2022-03-28	1	\N	\N	\N	\N
2322	Bocaiúva	3107307	MG	2022-03-28	1	\N	\N	\N	\N
2323	Bom Despacho	3107406	MG	2022-03-28	1	\N	\N	\N	\N
2324	Bom Jardim de Minas	3107505	MG	2022-03-28	1	\N	\N	\N	\N
2325	Bom Jesus da Penha	3107604	MG	2022-03-28	1	\N	\N	\N	\N
2326	Bom Jesus do Amparo	3107703	MG	2022-03-28	1	\N	\N	\N	\N
2327	Bom Jesus do Galho	3107802	MG	2022-03-28	1	\N	\N	\N	\N
2328	Bom Repouso	3107901	MG	2022-03-28	1	\N	\N	\N	\N
2329	Bom Sucesso	3108008	MG	2022-03-28	1	\N	\N	\N	\N
2330	Bonfim	3108107	MG	2022-03-28	1	\N	\N	\N	\N
2331	Bonfinópolis de Minas	3108206	MG	2022-03-28	1	\N	\N	\N	\N
2332	Bonito de Minas	3108255	MG	2022-03-28	1	\N	\N	\N	\N
2333	Borda da Mata	3108305	MG	2022-03-28	1	\N	\N	\N	\N
2334	Botelhos	3108404	MG	2022-03-28	1	\N	\N	\N	\N
2335	Botumirim	3108503	MG	2022-03-28	1	\N	\N	\N	\N
2336	Brás Pires	3108701	MG	2022-03-28	1	\N	\N	\N	\N
2337	Brasilândia de Minas	3108552	MG	2022-03-28	1	\N	\N	\N	\N
2338	Brasília de Minas	3108602	MG	2022-03-28	1	\N	\N	\N	\N
2339	Braúnas	3108800	MG	2022-03-28	1	\N	\N	\N	\N
2340	Brazópolis	3108909	MG	2022-03-28	1	\N	\N	\N	\N
2341	Brumadinho	3109006	MG	2022-03-28	1	\N	\N	\N	\N
2342	Bueno Brandão	3109105	MG	2022-03-28	1	\N	\N	\N	\N
2343	Buenópolis	3109204	MG	2022-03-28	1	\N	\N	\N	\N
2344	Bugre	3109253	MG	2022-03-28	1	\N	\N	\N	\N
2345	Buritis	3109303	MG	2022-03-28	1	\N	\N	\N	\N
2346	Buritizeiro	3109402	MG	2022-03-28	1	\N	\N	\N	\N
2347	Cabeceira Grande	3109451	MG	2022-03-28	1	\N	\N	\N	\N
2348	Cabo Verde	3109501	MG	2022-03-28	1	\N	\N	\N	\N
2349	Cachoeira da Prata	3109600	MG	2022-03-28	1	\N	\N	\N	\N
2350	Cachoeira de Minas	3109709	MG	2022-03-28	1	\N	\N	\N	\N
2351	Cachoeira de Pajeú	3102704	MG	2022-03-28	1	\N	\N	\N	\N
2352	Cachoeira Dourada	3109808	MG	2022-03-28	1	\N	\N	\N	\N
2353	Caetanópolis	3109907	MG	2022-03-28	1	\N	\N	\N	\N
2354	Caeté	3110004	MG	2022-03-28	1	\N	\N	\N	\N
2355	Caiana	3110103	MG	2022-03-28	1	\N	\N	\N	\N
2356	Cajuri	3110202	MG	2022-03-28	1	\N	\N	\N	\N
2357	Caldas	3110301	MG	2022-03-28	1	\N	\N	\N	\N
2358	Camacho	3110400	MG	2022-03-28	1	\N	\N	\N	\N
2359	Camanducaia	3110509	MG	2022-03-28	1	\N	\N	\N	\N
2360	Cambuí	3110608	MG	2022-03-28	1	\N	\N	\N	\N
2361	Cambuquira	3110707	MG	2022-03-28	1	\N	\N	\N	\N
2362	Campanário	3110806	MG	2022-03-28	1	\N	\N	\N	\N
2363	Campanha	3110905	MG	2022-03-28	1	\N	\N	\N	\N
2364	Campestre	3111002	MG	2022-03-28	1	\N	\N	\N	\N
2365	Campina Verde	3111101	MG	2022-03-28	1	\N	\N	\N	\N
2366	Campo Azul	3111150	MG	2022-03-28	1	\N	\N	\N	\N
2367	Campo Belo	3111200	MG	2022-03-28	1	\N	\N	\N	\N
2368	Campo do Meio	3111309	MG	2022-03-28	1	\N	\N	\N	\N
2369	Campo Florido	3111408	MG	2022-03-28	1	\N	\N	\N	\N
2370	Campos Altos	3111507	MG	2022-03-28	1	\N	\N	\N	\N
2371	Campos Gerais	3111606	MG	2022-03-28	1	\N	\N	\N	\N
2372	Cana Verde	3111903	MG	2022-03-28	1	\N	\N	\N	\N
2373	Canaã	3111705	MG	2022-03-28	1	\N	\N	\N	\N
2374	Canápolis	3111804	MG	2022-03-28	1	\N	\N	\N	\N
2375	Candeias	3112000	MG	2022-03-28	1	\N	\N	\N	\N
2376	Cantagalo	3112059	MG	2022-03-28	1	\N	\N	\N	\N
2377	Caparaó	3112109	MG	2022-03-28	1	\N	\N	\N	\N
2378	Capela Nova	3112208	MG	2022-03-28	1	\N	\N	\N	\N
2379	Capelinha	3112307	MG	2022-03-28	1	\N	\N	\N	\N
2380	Capetinga	3112406	MG	2022-03-28	1	\N	\N	\N	\N
2381	Capim Branco	3112505	MG	2022-03-28	1	\N	\N	\N	\N
2382	Capinópolis	3112604	MG	2022-03-28	1	\N	\N	\N	\N
2383	Capitão Andrade	3112653	MG	2022-03-28	1	\N	\N	\N	\N
2384	Capitão Enéas	3112703	MG	2022-03-28	1	\N	\N	\N	\N
2385	Capitólio	3112802	MG	2022-03-28	1	\N	\N	\N	\N
2386	Caputira	3112901	MG	2022-03-28	1	\N	\N	\N	\N
2387	Caraí	3113008	MG	2022-03-28	1	\N	\N	\N	\N
2388	Caranaíba	3113107	MG	2022-03-28	1	\N	\N	\N	\N
2389	Carandaí	3113206	MG	2022-03-28	1	\N	\N	\N	\N
2390	Carangola	3113305	MG	2022-03-28	1	\N	\N	\N	\N
2391	Caratinga	3113404	MG	2022-03-28	1	\N	\N	\N	\N
2392	Carbonita	3113503	MG	2022-03-28	1	\N	\N	\N	\N
2393	Careaçu	3113602	MG	2022-03-28	1	\N	\N	\N	\N
2394	Carlos Chagas	3113701	MG	2022-03-28	1	\N	\N	\N	\N
2395	Carmésia	3113800	MG	2022-03-28	1	\N	\N	\N	\N
2396	Carmo da Cachoeira	3113909	MG	2022-03-28	1	\N	\N	\N	\N
2397	Carmo da Mata	3114006	MG	2022-03-28	1	\N	\N	\N	\N
2398	Carmo de Minas	3114105	MG	2022-03-28	1	\N	\N	\N	\N
2399	Carmo do Cajuru	3114204	MG	2022-03-28	1	\N	\N	\N	\N
2400	Carmo do Paranaíba	3114303	MG	2022-03-28	1	\N	\N	\N	\N
2401	Carmo do Rio Claro	3114402	MG	2022-03-28	1	\N	\N	\N	\N
2402	Carmópolis de Minas	3114501	MG	2022-03-28	1	\N	\N	\N	\N
2403	Carneirinho	3114550	MG	2022-03-28	1	\N	\N	\N	\N
2404	Carrancas	3114600	MG	2022-03-28	1	\N	\N	\N	\N
2405	Carvalhópolis	3114709	MG	2022-03-28	1	\N	\N	\N	\N
2406	Carvalhos	3114808	MG	2022-03-28	1	\N	\N	\N	\N
2407	Casa Grande	3114907	MG	2022-03-28	1	\N	\N	\N	\N
2408	Cascalho Rico	3115003	MG	2022-03-28	1	\N	\N	\N	\N
2409	Cássia	3115102	MG	2022-03-28	1	\N	\N	\N	\N
2410	Cataguases	3115300	MG	2022-03-28	1	\N	\N	\N	\N
2411	Catas Altas	3115359	MG	2022-03-28	1	\N	\N	\N	\N
2412	Catas Altas da Noruega	3115409	MG	2022-03-28	1	\N	\N	\N	\N
2413	Catuji	3115458	MG	2022-03-28	1	\N	\N	\N	\N
2414	Catuti	3115474	MG	2022-03-28	1	\N	\N	\N	\N
2415	Caxambu	3115508	MG	2022-03-28	1	\N	\N	\N	\N
2416	Cedro do Abaeté	3115607	MG	2022-03-28	1	\N	\N	\N	\N
2417	Central de Minas	3115706	MG	2022-03-28	1	\N	\N	\N	\N
2418	Centralina	3115805	MG	2022-03-28	1	\N	\N	\N	\N
2419	Chácara	3115904	MG	2022-03-28	1	\N	\N	\N	\N
2420	Chalé	3116001	MG	2022-03-28	1	\N	\N	\N	\N
2421	Chapada do Norte	3116100	MG	2022-03-28	1	\N	\N	\N	\N
2422	Chapada Gaúcha	3116159	MG	2022-03-28	1	\N	\N	\N	\N
2423	Chiador	3116209	MG	2022-03-28	1	\N	\N	\N	\N
2424	Cipotânea	3116308	MG	2022-03-28	1	\N	\N	\N	\N
2425	Claraval	3116407	MG	2022-03-28	1	\N	\N	\N	\N
2426	Claro dos Poções	3116506	MG	2022-03-28	1	\N	\N	\N	\N
2427	Cláudio	3116605	MG	2022-03-28	1	\N	\N	\N	\N
2428	Coimbra	3116704	MG	2022-03-28	1	\N	\N	\N	\N
2429	Coluna	3116803	MG	2022-03-28	1	\N	\N	\N	\N
2430	Comendador Gomes	3116902	MG	2022-03-28	1	\N	\N	\N	\N
2431	Comercinho	3117009	MG	2022-03-28	1	\N	\N	\N	\N
2432	Conceição da Aparecida	3117108	MG	2022-03-28	1	\N	\N	\N	\N
2433	Conceição da Barra de Minas	3115201	MG	2022-03-28	1	\N	\N	\N	\N
2434	Conceição das Alagoas	3117306	MG	2022-03-28	1	\N	\N	\N	\N
2435	Conceição das Pedras	3117207	MG	2022-03-28	1	\N	\N	\N	\N
2436	Conceição de Ipanema	3117405	MG	2022-03-28	1	\N	\N	\N	\N
2437	Conceição do Mato Dentro	3117504	MG	2022-03-28	1	\N	\N	\N	\N
2438	Conceição do Pará	3117603	MG	2022-03-28	1	\N	\N	\N	\N
2439	Conceição do Rio Verde	3117702	MG	2022-03-28	1	\N	\N	\N	\N
2440	Conceição dos Ouros	3117801	MG	2022-03-28	1	\N	\N	\N	\N
2441	Cônego Marinho	3117836	MG	2022-03-28	1	\N	\N	\N	\N
2442	Confins	3117876	MG	2022-03-28	1	\N	\N	\N	\N
2443	Congonhal	3117900	MG	2022-03-28	1	\N	\N	\N	\N
2444	Congonhas	3118007	MG	2022-03-28	1	\N	\N	\N	\N
2445	Congonhas do Norte	3118106	MG	2022-03-28	1	\N	\N	\N	\N
2446	Conquista	3118205	MG	2022-03-28	1	\N	\N	\N	\N
2447	Conselheiro Lafaiete	3118304	MG	2022-03-28	1	\N	\N	\N	\N
2448	Conselheiro Pena	3118403	MG	2022-03-28	1	\N	\N	\N	\N
2449	Consolação	3118502	MG	2022-03-28	1	\N	\N	\N	\N
2450	Contagem	3118601	MG	2022-03-28	1	\N	\N	\N	\N
2451	Coqueiral	3118700	MG	2022-03-28	1	\N	\N	\N	\N
2452	Coração de Jesus	3118809	MG	2022-03-28	1	\N	\N	\N	\N
2453	Cordisburgo	3118908	MG	2022-03-28	1	\N	\N	\N	\N
2454	Cordislândia	3119005	MG	2022-03-28	1	\N	\N	\N	\N
2455	Corinto	3119104	MG	2022-03-28	1	\N	\N	\N	\N
2456	Coroaci	3119203	MG	2022-03-28	1	\N	\N	\N	\N
2457	Coromandel	3119302	MG	2022-03-28	1	\N	\N	\N	\N
2458	Coronel Fabriciano	3119401	MG	2022-03-28	1	\N	\N	\N	\N
2459	Coronel Murta	3119500	MG	2022-03-28	1	\N	\N	\N	\N
2460	Coronel Pacheco	3119609	MG	2022-03-28	1	\N	\N	\N	\N
2461	Coronel Xavier Chaves	3119708	MG	2022-03-28	1	\N	\N	\N	\N
2462	Córrego Danta	3119807	MG	2022-03-28	1	\N	\N	\N	\N
2463	Córrego do Bom Jesus	3119906	MG	2022-03-28	1	\N	\N	\N	\N
2464	Córrego Fundo	3119955	MG	2022-03-28	1	\N	\N	\N	\N
2465	Córrego Novo	3120003	MG	2022-03-28	1	\N	\N	\N	\N
2466	Couto de Magalhães de Minas	3120102	MG	2022-03-28	1	\N	\N	\N	\N
2467	Crisólita	3120151	MG	2022-03-28	1	\N	\N	\N	\N
2468	Cristais	3120201	MG	2022-03-28	1	\N	\N	\N	\N
2469	Cristália	3120300	MG	2022-03-28	1	\N	\N	\N	\N
2470	Cristiano Otoni	3120409	MG	2022-03-28	1	\N	\N	\N	\N
2471	Cristina	3120508	MG	2022-03-28	1	\N	\N	\N	\N
2472	Crucilândia	3120607	MG	2022-03-28	1	\N	\N	\N	\N
2473	Cruzeiro da Fortaleza	3120706	MG	2022-03-28	1	\N	\N	\N	\N
2474	Cruzília	3120805	MG	2022-03-28	1	\N	\N	\N	\N
2475	Cuparaque	3120839	MG	2022-03-28	1	\N	\N	\N	\N
2476	Curral de Dentro	3120870	MG	2022-03-28	1	\N	\N	\N	\N
2477	Curvelo	3120904	MG	2022-03-28	1	\N	\N	\N	\N
2478	Datas	3121001	MG	2022-03-28	1	\N	\N	\N	\N
2479	Delfim Moreira	3121100	MG	2022-03-28	1	\N	\N	\N	\N
2480	Delfinópolis	3121209	MG	2022-03-28	1	\N	\N	\N	\N
2481	Delta	3121258	MG	2022-03-28	1	\N	\N	\N	\N
2482	Descoberto	3121308	MG	2022-03-28	1	\N	\N	\N	\N
2483	Desterro de Entre Rios	3121407	MG	2022-03-28	1	\N	\N	\N	\N
2484	Desterro do Melo	3121506	MG	2022-03-28	1	\N	\N	\N	\N
2485	Diamantina	3121605	MG	2022-03-28	1	\N	\N	\N	\N
2486	Diogo de Vasconcelos	3121704	MG	2022-03-28	1	\N	\N	\N	\N
2487	Dionísio	3121803	MG	2022-03-28	1	\N	\N	\N	\N
2488	Divinésia	3121902	MG	2022-03-28	1	\N	\N	\N	\N
2489	Divino	3122009	MG	2022-03-28	1	\N	\N	\N	\N
2490	Divino das Laranjeiras	3122108	MG	2022-03-28	1	\N	\N	\N	\N
2491	Divinolândia de Minas	3122207	MG	2022-03-28	1	\N	\N	\N	\N
2492	Divinópolis	3122306	MG	2022-03-28	1	\N	\N	\N	\N
2493	Divisa Alegre	3122355	MG	2022-03-28	1	\N	\N	\N	\N
2494	Divisa Nova	3122405	MG	2022-03-28	1	\N	\N	\N	\N
2495	Divisópolis	3122454	MG	2022-03-28	1	\N	\N	\N	\N
2496	Dom Bosco	3122470	MG	2022-03-28	1	\N	\N	\N	\N
2497	Dom Cavati	3122504	MG	2022-03-28	1	\N	\N	\N	\N
2498	Dom Joaquim	3122603	MG	2022-03-28	1	\N	\N	\N	\N
2499	Dom Silvério	3122702	MG	2022-03-28	1	\N	\N	\N	\N
2500	Dom Viçoso	3122801	MG	2022-03-28	1	\N	\N	\N	\N
2501	Dona Euzébia	3122900	MG	2022-03-28	1	\N	\N	\N	\N
2502	Dores de Campos	3123007	MG	2022-03-28	1	\N	\N	\N	\N
2503	Dores de Guanhães	3123106	MG	2022-03-28	1	\N	\N	\N	\N
2504	Dores do Indaiá	3123205	MG	2022-03-28	1	\N	\N	\N	\N
2505	Dores do Turvo	3123304	MG	2022-03-28	1	\N	\N	\N	\N
2506	Doresópolis	3123403	MG	2022-03-28	1	\N	\N	\N	\N
2507	Douradoquara	3123502	MG	2022-03-28	1	\N	\N	\N	\N
2508	Durandé	3123528	MG	2022-03-28	1	\N	\N	\N	\N
2509	Elói Mendes	3123601	MG	2022-03-28	1	\N	\N	\N	\N
2510	Engenheiro Caldas	3123700	MG	2022-03-28	1	\N	\N	\N	\N
2511	Engenheiro Navarro	3123809	MG	2022-03-28	1	\N	\N	\N	\N
2512	Entre Folhas	3123858	MG	2022-03-28	1	\N	\N	\N	\N
2513	Entre Rios de Minas	3123908	MG	2022-03-28	1	\N	\N	\N	\N
2514	Ervália	3124005	MG	2022-03-28	1	\N	\N	\N	\N
2515	Esmeraldas	3124104	MG	2022-03-28	1	\N	\N	\N	\N
2516	Espera Feliz	3124203	MG	2022-03-28	1	\N	\N	\N	\N
2517	Espinosa	3124302	MG	2022-03-28	1	\N	\N	\N	\N
2518	Espírito Santo do Dourado	3124401	MG	2022-03-28	1	\N	\N	\N	\N
2519	Estiva	3124500	MG	2022-03-28	1	\N	\N	\N	\N
2520	Estrela Dalva	3124609	MG	2022-03-28	1	\N	\N	\N	\N
2521	Estrela do Indaiá	3124708	MG	2022-03-28	1	\N	\N	\N	\N
2522	Estrela do Sul	3124807	MG	2022-03-28	1	\N	\N	\N	\N
2523	Eugenópolis	3124906	MG	2022-03-28	1	\N	\N	\N	\N
2524	Ewbank da Câmara	3125002	MG	2022-03-28	1	\N	\N	\N	\N
2525	Extrema	3125101	MG	2022-03-28	1	\N	\N	\N	\N
2526	Fama	3125200	MG	2022-03-28	1	\N	\N	\N	\N
2527	Faria Lemos	3125309	MG	2022-03-28	1	\N	\N	\N	\N
2528	Felício dos Santos	3125408	MG	2022-03-28	1	\N	\N	\N	\N
2529	Felisburgo	3125606	MG	2022-03-28	1	\N	\N	\N	\N
2530	Felixlândia	3125705	MG	2022-03-28	1	\N	\N	\N	\N
2531	Fernandes Tourinho	3125804	MG	2022-03-28	1	\N	\N	\N	\N
2532	Ferros	3125903	MG	2022-03-28	1	\N	\N	\N	\N
2533	Fervedouro	3125952	MG	2022-03-28	1	\N	\N	\N	\N
2534	Florestal	3126000	MG	2022-03-28	1	\N	\N	\N	\N
2535	Formiga	3126109	MG	2022-03-28	1	\N	\N	\N	\N
2536	Formoso	3126208	MG	2022-03-28	1	\N	\N	\N	\N
2537	Fortaleza de Minas	3126307	MG	2022-03-28	1	\N	\N	\N	\N
2538	Fortuna de Minas	3126406	MG	2022-03-28	1	\N	\N	\N	\N
2539	Francisco Badaró	3126505	MG	2022-03-28	1	\N	\N	\N	\N
2540	Francisco Dumont	3126604	MG	2022-03-28	1	\N	\N	\N	\N
2541	Francisco Sá	3126703	MG	2022-03-28	1	\N	\N	\N	\N
2542	Franciscópolis	3126752	MG	2022-03-28	1	\N	\N	\N	\N
2543	Frei Gaspar	3126802	MG	2022-03-28	1	\N	\N	\N	\N
2544	Frei Inocêncio	3126901	MG	2022-03-28	1	\N	\N	\N	\N
2545	Frei Lagonegro	3126950	MG	2022-03-28	1	\N	\N	\N	\N
2546	Fronteira	3127008	MG	2022-03-28	1	\N	\N	\N	\N
2547	Fronteira dos Vales	3127057	MG	2022-03-28	1	\N	\N	\N	\N
2548	Fruta de Leite	3127073	MG	2022-03-28	1	\N	\N	\N	\N
2549	Frutal	3127107	MG	2022-03-28	1	\N	\N	\N	\N
2550	Funilândia	3127206	MG	2022-03-28	1	\N	\N	\N	\N
2551	Galiléia	3127305	MG	2022-03-28	1	\N	\N	\N	\N
2552	Gameleiras	3127339	MG	2022-03-28	1	\N	\N	\N	\N
2553	Glaucilândia	3127354	MG	2022-03-28	1	\N	\N	\N	\N
2554	Goiabeira	3127370	MG	2022-03-28	1	\N	\N	\N	\N
2555	Goianá	3127388	MG	2022-03-28	1	\N	\N	\N	\N
2556	Gonçalves	3127404	MG	2022-03-28	1	\N	\N	\N	\N
2557	Gonzaga	3127503	MG	2022-03-28	1	\N	\N	\N	\N
2558	Gouveia	3127602	MG	2022-03-28	1	\N	\N	\N	\N
2559	Governador Valadares	3127701	MG	2022-03-28	1	\N	\N	\N	\N
2560	Grão Mogol	3127800	MG	2022-03-28	1	\N	\N	\N	\N
2561	Grupiara	3127909	MG	2022-03-28	1	\N	\N	\N	\N
2562	Guanhães	3128006	MG	2022-03-28	1	\N	\N	\N	\N
2563	Guapé	3128105	MG	2022-03-28	1	\N	\N	\N	\N
2564	Guaraciaba	3128204	MG	2022-03-28	1	\N	\N	\N	\N
2565	Guaraciama	3128253	MG	2022-03-28	1	\N	\N	\N	\N
2566	Guaranésia	3128303	MG	2022-03-28	1	\N	\N	\N	\N
2567	Guarani	3128402	MG	2022-03-28	1	\N	\N	\N	\N
2568	Guarará	3128501	MG	2022-03-28	1	\N	\N	\N	\N
2569	Guarda-Mor	3128600	MG	2022-03-28	1	\N	\N	\N	\N
2570	Guaxupé	3128709	MG	2022-03-28	1	\N	\N	\N	\N
2571	Guidoval	3128808	MG	2022-03-28	1	\N	\N	\N	\N
2572	Guimarânia	3128907	MG	2022-03-28	1	\N	\N	\N	\N
2573	Guiricema	3129004	MG	2022-03-28	1	\N	\N	\N	\N
2574	Gurinhatã	3129103	MG	2022-03-28	1	\N	\N	\N	\N
2575	Heliodora	3129202	MG	2022-03-28	1	\N	\N	\N	\N
2576	Iapu	3129301	MG	2022-03-28	1	\N	\N	\N	\N
2577	Ibertioga	3129400	MG	2022-03-28	1	\N	\N	\N	\N
2578	Ibiá	3129509	MG	2022-03-28	1	\N	\N	\N	\N
2579	Ibiaí	3129608	MG	2022-03-28	1	\N	\N	\N	\N
2580	Ibiracatu	3129657	MG	2022-03-28	1	\N	\N	\N	\N
2581	Ibiraci	3129707	MG	2022-03-28	1	\N	\N	\N	\N
2582	Ibirité	3129806	MG	2022-03-28	1	\N	\N	\N	\N
2583	Ibitiúra de Minas	3129905	MG	2022-03-28	1	\N	\N	\N	\N
2584	Ibituruna	3130002	MG	2022-03-28	1	\N	\N	\N	\N
2585	Icaraí de Minas	3130051	MG	2022-03-28	1	\N	\N	\N	\N
2586	Igarapé	3130101	MG	2022-03-28	1	\N	\N	\N	\N
2587	Igaratinga	3130200	MG	2022-03-28	1	\N	\N	\N	\N
2588	Iguatama	3130309	MG	2022-03-28	1	\N	\N	\N	\N
2589	Ijaci	3130408	MG	2022-03-28	1	\N	\N	\N	\N
2590	Ilicínea	3130507	MG	2022-03-28	1	\N	\N	\N	\N
2591	Imbé de Minas	3130556	MG	2022-03-28	1	\N	\N	\N	\N
2592	Inconfidentes	3130606	MG	2022-03-28	1	\N	\N	\N	\N
2593	Indaiabira	3130655	MG	2022-03-28	1	\N	\N	\N	\N
2594	Indianópolis	3130705	MG	2022-03-28	1	\N	\N	\N	\N
2595	Ingaí	3130804	MG	2022-03-28	1	\N	\N	\N	\N
2596	Inhapim	3130903	MG	2022-03-28	1	\N	\N	\N	\N
2597	Inhaúma	3131000	MG	2022-03-28	1	\N	\N	\N	\N
2598	Inimutaba	3131109	MG	2022-03-28	1	\N	\N	\N	\N
2599	Ipaba	3131158	MG	2022-03-28	1	\N	\N	\N	\N
2600	Ipanema	3131208	MG	2022-03-28	1	\N	\N	\N	\N
2601	Ipatinga	3131307	MG	2022-03-28	1	\N	\N	\N	\N
2602	Ipiaçu	3131406	MG	2022-03-28	1	\N	\N	\N	\N
2603	Ipuiúna	3131505	MG	2022-03-28	1	\N	\N	\N	\N
2604	Iraí de Minas	3131604	MG	2022-03-28	1	\N	\N	\N	\N
2605	Itabira	3131703	MG	2022-03-28	1	\N	\N	\N	\N
2606	Itabirinha	3131802	MG	2022-03-28	1	\N	\N	\N	\N
2607	Itabirito	3131901	MG	2022-03-28	1	\N	\N	\N	\N
2608	Itacambira	3132008	MG	2022-03-28	1	\N	\N	\N	\N
2609	Itacarambi	3132107	MG	2022-03-28	1	\N	\N	\N	\N
2610	Itaguara	3132206	MG	2022-03-28	1	\N	\N	\N	\N
2611	Itaipé	3132305	MG	2022-03-28	1	\N	\N	\N	\N
2612	Itajubá	3132404	MG	2022-03-28	1	\N	\N	\N	\N
2613	Itamarandiba	3132503	MG	2022-03-28	1	\N	\N	\N	\N
2614	Itamarati de Minas	3132602	MG	2022-03-28	1	\N	\N	\N	\N
2615	Itambacuri	3132701	MG	2022-03-28	1	\N	\N	\N	\N
2616	Itambé do Mato Dentro	3132800	MG	2022-03-28	1	\N	\N	\N	\N
2617	Itamogi	3132909	MG	2022-03-28	1	\N	\N	\N	\N
2618	Itamonte	3133006	MG	2022-03-28	1	\N	\N	\N	\N
2619	Itanhandu	3133105	MG	2022-03-28	1	\N	\N	\N	\N
2620	Itanhomi	3133204	MG	2022-03-28	1	\N	\N	\N	\N
2621	Itaobim	3133303	MG	2022-03-28	1	\N	\N	\N	\N
2622	Itapagipe	3133402	MG	2022-03-28	1	\N	\N	\N	\N
2623	Itapecerica	3133501	MG	2022-03-28	1	\N	\N	\N	\N
2624	Itapeva	3133600	MG	2022-03-28	1	\N	\N	\N	\N
2625	Itatiaiuçu	3133709	MG	2022-03-28	1	\N	\N	\N	\N
2626	Itaú de Minas	3133758	MG	2022-03-28	1	\N	\N	\N	\N
2627	Itaúna	3133808	MG	2022-03-28	1	\N	\N	\N	\N
2628	Itaverava	3133907	MG	2022-03-28	1	\N	\N	\N	\N
2629	Itinga	3134004	MG	2022-03-28	1	\N	\N	\N	\N
2630	Itueta	3134103	MG	2022-03-28	1	\N	\N	\N	\N
2631	Ituiutaba	3134202	MG	2022-03-28	1	\N	\N	\N	\N
2632	Itumirim	3134301	MG	2022-03-28	1	\N	\N	\N	\N
2633	Iturama	3134400	MG	2022-03-28	1	\N	\N	\N	\N
2634	Itutinga	3134509	MG	2022-03-28	1	\N	\N	\N	\N
2635	Jaboticatubas	3134608	MG	2022-03-28	1	\N	\N	\N	\N
2636	Jacinto	3134707	MG	2022-03-28	1	\N	\N	\N	\N
2637	Jacuí	3134806	MG	2022-03-28	1	\N	\N	\N	\N
2638	Jacutinga	3134905	MG	2022-03-28	1	\N	\N	\N	\N
2639	Jaguaraçu	3135001	MG	2022-03-28	1	\N	\N	\N	\N
2640	Jaíba	3135050	MG	2022-03-28	1	\N	\N	\N	\N
2641	Jampruca	3135076	MG	2022-03-28	1	\N	\N	\N	\N
2642	Janaúba	3135100	MG	2022-03-28	1	\N	\N	\N	\N
2643	Januária	3135209	MG	2022-03-28	1	\N	\N	\N	\N
2644	Japaraíba	3135308	MG	2022-03-28	1	\N	\N	\N	\N
2645	Japonvar	3135357	MG	2022-03-28	1	\N	\N	\N	\N
2646	Jeceaba	3135407	MG	2022-03-28	1	\N	\N	\N	\N
2647	Jenipapo de Minas	3135456	MG	2022-03-28	1	\N	\N	\N	\N
2648	Jequeri	3135506	MG	2022-03-28	1	\N	\N	\N	\N
2649	Jequitaí	3135605	MG	2022-03-28	1	\N	\N	\N	\N
2650	Jequitibá	3135704	MG	2022-03-28	1	\N	\N	\N	\N
2651	Jequitinhonha	3135803	MG	2022-03-28	1	\N	\N	\N	\N
2652	Jesuânia	3135902	MG	2022-03-28	1	\N	\N	\N	\N
2653	Joaíma	3136009	MG	2022-03-28	1	\N	\N	\N	\N
2654	Joanésia	3136108	MG	2022-03-28	1	\N	\N	\N	\N
2655	João Monlevade	3136207	MG	2022-03-28	1	\N	\N	\N	\N
2656	João Pinheiro	3136306	MG	2022-03-28	1	\N	\N	\N	\N
2657	Joaquim Felício	3136405	MG	2022-03-28	1	\N	\N	\N	\N
2658	Jordânia	3136504	MG	2022-03-28	1	\N	\N	\N	\N
2659	José Gonçalves de Minas	3136520	MG	2022-03-28	1	\N	\N	\N	\N
2660	José Raydan	3136553	MG	2022-03-28	1	\N	\N	\N	\N
2661	Josenópolis	3136579	MG	2022-03-28	1	\N	\N	\N	\N
2662	Juatuba	3136652	MG	2022-03-28	1	\N	\N	\N	\N
2663	Juiz de Fora	3136702	MG	2022-03-28	1	\N	\N	\N	\N
2664	Juramento	3136801	MG	2022-03-28	1	\N	\N	\N	\N
2665	Juruaia	3136900	MG	2022-03-28	1	\N	\N	\N	\N
2666	Juvenília	3136959	MG	2022-03-28	1	\N	\N	\N	\N
2667	Ladainha	3137007	MG	2022-03-28	1	\N	\N	\N	\N
2668	Lagamar	3137106	MG	2022-03-28	1	\N	\N	\N	\N
2669	Lagoa da Prata	3137205	MG	2022-03-28	1	\N	\N	\N	\N
2670	Lagoa dos Patos	3137304	MG	2022-03-28	1	\N	\N	\N	\N
2671	Lagoa Dourada	3137403	MG	2022-03-28	1	\N	\N	\N	\N
2672	Lagoa Formosa	3137502	MG	2022-03-28	1	\N	\N	\N	\N
2673	Lagoa Grande	3137536	MG	2022-03-28	1	\N	\N	\N	\N
2674	Lagoa Santa	3137601	MG	2022-03-28	1	\N	\N	\N	\N
2675	Lajinha	3137700	MG	2022-03-28	1	\N	\N	\N	\N
2676	Lambari	3137809	MG	2022-03-28	1	\N	\N	\N	\N
2677	Lamim	3137908	MG	2022-03-28	1	\N	\N	\N	\N
2678	Laranjal	3138005	MG	2022-03-28	1	\N	\N	\N	\N
2679	Lassance	3138104	MG	2022-03-28	1	\N	\N	\N	\N
2680	Lavras	3138203	MG	2022-03-28	1	\N	\N	\N	\N
2681	Leandro Ferreira	3138302	MG	2022-03-28	1	\N	\N	\N	\N
2682	Leme do Prado	3138351	MG	2022-03-28	1	\N	\N	\N	\N
2683	Leopoldina	3138401	MG	2022-03-28	1	\N	\N	\N	\N
2684	Liberdade	3138500	MG	2022-03-28	1	\N	\N	\N	\N
2685	Lima Duarte	3138609	MG	2022-03-28	1	\N	\N	\N	\N
2686	Limeira do Oeste	3138625	MG	2022-03-28	1	\N	\N	\N	\N
2687	Lontra	3138658	MG	2022-03-28	1	\N	\N	\N	\N
2688	Luisburgo	3138674	MG	2022-03-28	1	\N	\N	\N	\N
2689	Luislândia	3138682	MG	2022-03-28	1	\N	\N	\N	\N
2690	Luminárias	3138708	MG	2022-03-28	1	\N	\N	\N	\N
2691	Luz	3138807	MG	2022-03-28	1	\N	\N	\N	\N
2692	Machacalis	3138906	MG	2022-03-28	1	\N	\N	\N	\N
2693	Machado	3139003	MG	2022-03-28	1	\N	\N	\N	\N
2694	Madre de Deus de Minas	3139102	MG	2022-03-28	1	\N	\N	\N	\N
2695	Malacacheta	3139201	MG	2022-03-28	1	\N	\N	\N	\N
2696	Mamonas	3139250	MG	2022-03-28	1	\N	\N	\N	\N
2697	Manga	3139300	MG	2022-03-28	1	\N	\N	\N	\N
2698	Manhuaçu	3139409	MG	2022-03-28	1	\N	\N	\N	\N
2699	Manhumirim	3139508	MG	2022-03-28	1	\N	\N	\N	\N
2700	Mantena	3139607	MG	2022-03-28	1	\N	\N	\N	\N
2701	Mar de Espanha	3139805	MG	2022-03-28	1	\N	\N	\N	\N
2702	Maravilhas	3139706	MG	2022-03-28	1	\N	\N	\N	\N
2703	Maria da Fé	3139904	MG	2022-03-28	1	\N	\N	\N	\N
2704	Mariana	3140001	MG	2022-03-28	1	\N	\N	\N	\N
2705	Marilac	3140100	MG	2022-03-28	1	\N	\N	\N	\N
2706	Mário Campos	3140159	MG	2022-03-28	1	\N	\N	\N	\N
2707	Maripá de Minas	3140209	MG	2022-03-28	1	\N	\N	\N	\N
2708	Marliéria	3140308	MG	2022-03-28	1	\N	\N	\N	\N
2709	Marmelópolis	3140407	MG	2022-03-28	1	\N	\N	\N	\N
2710	Martinho Campos	3140506	MG	2022-03-28	1	\N	\N	\N	\N
2711	Martins Soares	3140530	MG	2022-03-28	1	\N	\N	\N	\N
2712	Mata Verde	3140555	MG	2022-03-28	1	\N	\N	\N	\N
2713	Materlândia	3140605	MG	2022-03-28	1	\N	\N	\N	\N
2714	Mateus Leme	3140704	MG	2022-03-28	1	\N	\N	\N	\N
2715	Mathias Lobato	3171501	MG	2022-03-28	1	\N	\N	\N	\N
2716	Matias Barbosa	3140803	MG	2022-03-28	1	\N	\N	\N	\N
2717	Matias Cardoso	3140852	MG	2022-03-28	1	\N	\N	\N	\N
2718	Matipó	3140902	MG	2022-03-28	1	\N	\N	\N	\N
2719	Mato Verde	3141009	MG	2022-03-28	1	\N	\N	\N	\N
2720	Matozinhos	3141108	MG	2022-03-28	1	\N	\N	\N	\N
2721	Matutina	3141207	MG	2022-03-28	1	\N	\N	\N	\N
2722	Medeiros	3141306	MG	2022-03-28	1	\N	\N	\N	\N
2723	Medina	3141405	MG	2022-03-28	1	\N	\N	\N	\N
2724	Mendes Pimentel	3141504	MG	2022-03-28	1	\N	\N	\N	\N
2725	Mercês	3141603	MG	2022-03-28	1	\N	\N	\N	\N
2726	Mesquita	3141702	MG	2022-03-28	1	\N	\N	\N	\N
2727	Minas Novas	3141801	MG	2022-03-28	1	\N	\N	\N	\N
2728	Minduri	3141900	MG	2022-03-28	1	\N	\N	\N	\N
2729	Mirabela	3142007	MG	2022-03-28	1	\N	\N	\N	\N
2730	Miradouro	3142106	MG	2022-03-28	1	\N	\N	\N	\N
2731	Miraí	3142205	MG	2022-03-28	1	\N	\N	\N	\N
2732	Miravânia	3142254	MG	2022-03-28	1	\N	\N	\N	\N
2733	Moeda	3142304	MG	2022-03-28	1	\N	\N	\N	\N
2734	Moema	3142403	MG	2022-03-28	1	\N	\N	\N	\N
2735	Monjolos	3142502	MG	2022-03-28	1	\N	\N	\N	\N
2736	Monsenhor Paulo	3142601	MG	2022-03-28	1	\N	\N	\N	\N
2737	Montalvânia	3142700	MG	2022-03-28	1	\N	\N	\N	\N
2738	Monte Alegre de Minas	3142809	MG	2022-03-28	1	\N	\N	\N	\N
2739	Monte Azul	3142908	MG	2022-03-28	1	\N	\N	\N	\N
2740	Monte Belo	3143005	MG	2022-03-28	1	\N	\N	\N	\N
2741	Monte Carmelo	3143104	MG	2022-03-28	1	\N	\N	\N	\N
2742	Monte Formoso	3143153	MG	2022-03-28	1	\N	\N	\N	\N
2743	Monte Santo de Minas	3143203	MG	2022-03-28	1	\N	\N	\N	\N
2744	Monte Sião	3143401	MG	2022-03-28	1	\N	\N	\N	\N
2745	Montes Claros	3143302	MG	2022-03-28	1	\N	\N	\N	\N
2746	Montezuma	3143450	MG	2022-03-28	1	\N	\N	\N	\N
2747	Morada Nova de Minas	3143500	MG	2022-03-28	1	\N	\N	\N	\N
2748	Morro da Garça	3143609	MG	2022-03-28	1	\N	\N	\N	\N
2749	Morro do Pilar	3143708	MG	2022-03-28	1	\N	\N	\N	\N
2750	Munhoz	3143807	MG	2022-03-28	1	\N	\N	\N	\N
2751	Muriaé	3143906	MG	2022-03-28	1	\N	\N	\N	\N
2752	Mutum	3144003	MG	2022-03-28	1	\N	\N	\N	\N
2753	Muzambinho	3144102	MG	2022-03-28	1	\N	\N	\N	\N
2754	Nacip Raydan	3144201	MG	2022-03-28	1	\N	\N	\N	\N
2755	Nanuque	3144300	MG	2022-03-28	1	\N	\N	\N	\N
2756	Naque	3144359	MG	2022-03-28	1	\N	\N	\N	\N
2757	Natalândia	3144375	MG	2022-03-28	1	\N	\N	\N	\N
2758	Natércia	3144409	MG	2022-03-28	1	\N	\N	\N	\N
2759	Nazareno	3144508	MG	2022-03-28	1	\N	\N	\N	\N
2760	Nepomuceno	3144607	MG	2022-03-28	1	\N	\N	\N	\N
2761	Ninheira	3144656	MG	2022-03-28	1	\N	\N	\N	\N
2762	Nova Belém	3144672	MG	2022-03-28	1	\N	\N	\N	\N
2763	Nova Era	3144706	MG	2022-03-28	1	\N	\N	\N	\N
2764	Nova Lima	3144805	MG	2022-03-28	1	\N	\N	\N	\N
2765	Nova Módica	3144904	MG	2022-03-28	1	\N	\N	\N	\N
2766	Nova Ponte	3145000	MG	2022-03-28	1	\N	\N	\N	\N
2767	Nova Porteirinha	3145059	MG	2022-03-28	1	\N	\N	\N	\N
2768	Nova Resende	3145109	MG	2022-03-28	1	\N	\N	\N	\N
2769	Nova Serrana	3145208	MG	2022-03-28	1	\N	\N	\N	\N
2770	Nova União	3136603	MG	2022-03-28	1	\N	\N	\N	\N
2771	Novo Cruzeiro	3145307	MG	2022-03-28	1	\N	\N	\N	\N
2772	Novo Oriente de Minas	3145356	MG	2022-03-28	1	\N	\N	\N	\N
2773	Novorizonte	3145372	MG	2022-03-28	1	\N	\N	\N	\N
2774	Olaria	3145406	MG	2022-03-28	1	\N	\N	\N	\N
2775	'Olhos-d''Água'	3145455	MG	2022-03-28	1	\N	\N	\N	\N
2776	Olímpio Noronha	3145505	MG	2022-03-28	1	\N	\N	\N	\N
2777	Oliveira	3145604	MG	2022-03-28	1	\N	\N	\N	\N
2778	Oliveira Fortes	3145703	MG	2022-03-28	1	\N	\N	\N	\N
2779	Onça de Pitangui	3145802	MG	2022-03-28	1	\N	\N	\N	\N
2780	Oratórios	3145851	MG	2022-03-28	1	\N	\N	\N	\N
2781	Orizânia	3145877	MG	2022-03-28	1	\N	\N	\N	\N
2782	Ouro Branco	3145901	MG	2022-03-28	1	\N	\N	\N	\N
2783	Ouro Fino	3146008	MG	2022-03-28	1	\N	\N	\N	\N
2784	Ouro Preto	3146107	MG	2022-03-28	1	\N	\N	\N	\N
2785	Ouro Verde de Minas	3146206	MG	2022-03-28	1	\N	\N	\N	\N
2786	Padre Carvalho	3146255	MG	2022-03-28	1	\N	\N	\N	\N
2787	Padre Paraíso	3146305	MG	2022-03-28	1	\N	\N	\N	\N
2788	Pai Pedro	3146552	MG	2022-03-28	1	\N	\N	\N	\N
2789	Paineiras	3146404	MG	2022-03-28	1	\N	\N	\N	\N
2790	Pains	3146503	MG	2022-03-28	1	\N	\N	\N	\N
2791	Paiva	3146602	MG	2022-03-28	1	\N	\N	\N	\N
2792	Palma	3146701	MG	2022-03-28	1	\N	\N	\N	\N
2793	Palmópolis	3146750	MG	2022-03-28	1	\N	\N	\N	\N
2794	Papagaios	3146909	MG	2022-03-28	1	\N	\N	\N	\N
2795	Pará de Minas	3147105	MG	2022-03-28	1	\N	\N	\N	\N
2796	Paracatu	3147006	MG	2022-03-28	1	\N	\N	\N	\N
2797	Paraguaçu	3147204	MG	2022-03-28	1	\N	\N	\N	\N
2798	Paraisópolis	3147303	MG	2022-03-28	1	\N	\N	\N	\N
2799	Paraopeba	3147402	MG	2022-03-28	1	\N	\N	\N	\N
2800	Passa Quatro	3147600	MG	2022-03-28	1	\N	\N	\N	\N
2801	Passa Tempo	3147709	MG	2022-03-28	1	\N	\N	\N	\N
2802	Passa Vinte	3147808	MG	2022-03-28	1	\N	\N	\N	\N
2803	Passabém	3147501	MG	2022-03-28	1	\N	\N	\N	\N
2804	Passos	3147907	MG	2022-03-28	1	\N	\N	\N	\N
2805	Patis	3147956	MG	2022-03-28	1	\N	\N	\N	\N
2806	Patos de Minas	3148004	MG	2022-03-28	1	\N	\N	\N	\N
2807	Patrocínio	3148103	MG	2022-03-28	1	\N	\N	\N	\N
2808	Patrocínio do Muriaé	3148202	MG	2022-03-28	1	\N	\N	\N	\N
2809	Paula Cândido	3148301	MG	2022-03-28	1	\N	\N	\N	\N
2810	Paulistas	3148400	MG	2022-03-28	1	\N	\N	\N	\N
2811	Pavão	3148509	MG	2022-03-28	1	\N	\N	\N	\N
2812	Peçanha	3148608	MG	2022-03-28	1	\N	\N	\N	\N
2813	Pedra Azul	3148707	MG	2022-03-28	1	\N	\N	\N	\N
2814	Pedra Bonita	3148756	MG	2022-03-28	1	\N	\N	\N	\N
2815	Pedra do Anta	3148806	MG	2022-03-28	1	\N	\N	\N	\N
2816	Pedra do Indaiá	3148905	MG	2022-03-28	1	\N	\N	\N	\N
2817	Pedra Dourada	3149002	MG	2022-03-28	1	\N	\N	\N	\N
2818	Pedralva	3149101	MG	2022-03-28	1	\N	\N	\N	\N
2819	Pedras de Maria da Cruz	3149150	MG	2022-03-28	1	\N	\N	\N	\N
2820	Pedrinópolis	3149200	MG	2022-03-28	1	\N	\N	\N	\N
2821	Pedro Leopoldo	3149309	MG	2022-03-28	1	\N	\N	\N	\N
2822	Pedro Teixeira	3149408	MG	2022-03-28	1	\N	\N	\N	\N
2823	Pequeri	3149507	MG	2022-03-28	1	\N	\N	\N	\N
2824	Pequi	3149606	MG	2022-03-28	1	\N	\N	\N	\N
2825	Perdigão	3149705	MG	2022-03-28	1	\N	\N	\N	\N
2826	Perdizes	3149804	MG	2022-03-28	1	\N	\N	\N	\N
2827	Perdões	3149903	MG	2022-03-28	1	\N	\N	\N	\N
2828	Periquito	3149952	MG	2022-03-28	1	\N	\N	\N	\N
2829	Pescador	3150000	MG	2022-03-28	1	\N	\N	\N	\N
2830	Piau	3150109	MG	2022-03-28	1	\N	\N	\N	\N
2831	Piedade de Caratinga	3150158	MG	2022-03-28	1	\N	\N	\N	\N
2832	Piedade de Ponte Nova	3150208	MG	2022-03-28	1	\N	\N	\N	\N
2833	Piedade do Rio Grande	3150307	MG	2022-03-28	1	\N	\N	\N	\N
2834	Piedade dos Gerais	3150406	MG	2022-03-28	1	\N	\N	\N	\N
2835	Pimenta	3150505	MG	2022-03-28	1	\N	\N	\N	\N
2836	'Pingo-d''Água'	3150539	MG	2022-03-28	1	\N	\N	\N	\N
2837	Pintópolis	3150570	MG	2022-03-28	1	\N	\N	\N	\N
2838	Piracema	3150604	MG	2022-03-28	1	\N	\N	\N	\N
2839	Pirajuba	3150703	MG	2022-03-28	1	\N	\N	\N	\N
2840	Piranga	3150802	MG	2022-03-28	1	\N	\N	\N	\N
2841	Piranguçu	3150901	MG	2022-03-28	1	\N	\N	\N	\N
2842	Piranguinho	3151008	MG	2022-03-28	1	\N	\N	\N	\N
2843	Pirapetinga	3151107	MG	2022-03-28	1	\N	\N	\N	\N
2844	Pirapora	3151206	MG	2022-03-28	1	\N	\N	\N	\N
2845	Piraúba	3151305	MG	2022-03-28	1	\N	\N	\N	\N
2846	Pitangui	3151404	MG	2022-03-28	1	\N	\N	\N	\N
2847	Piumhi	3151503	MG	2022-03-28	1	\N	\N	\N	\N
2848	Planura	3151602	MG	2022-03-28	1	\N	\N	\N	\N
2849	Poço Fundo	3151701	MG	2022-03-28	1	\N	\N	\N	\N
2850	Poços de Caldas	3151800	MG	2022-03-28	1	\N	\N	\N	\N
2851	Pocrane	3151909	MG	2022-03-28	1	\N	\N	\N	\N
2852	Pompéu	3152006	MG	2022-03-28	1	\N	\N	\N	\N
2853	Ponte Nova	3152105	MG	2022-03-28	1	\N	\N	\N	\N
2854	Ponto Chique	3152131	MG	2022-03-28	1	\N	\N	\N	\N
2855	Ponto dos Volantes	3152170	MG	2022-03-28	1	\N	\N	\N	\N
2856	Porteirinha	3152204	MG	2022-03-28	1	\N	\N	\N	\N
2857	Porto Firme	3152303	MG	2022-03-28	1	\N	\N	\N	\N
2858	Poté	3152402	MG	2022-03-28	1	\N	\N	\N	\N
2859	Pouso Alegre	3152501	MG	2022-03-28	1	\N	\N	\N	\N
2860	Pouso Alto	3152600	MG	2022-03-28	1	\N	\N	\N	\N
2861	Prados	3152709	MG	2022-03-28	1	\N	\N	\N	\N
2862	Prata	3152808	MG	2022-03-28	1	\N	\N	\N	\N
2863	Pratápolis	3152907	MG	2022-03-28	1	\N	\N	\N	\N
2864	Pratinha	3153004	MG	2022-03-28	1	\N	\N	\N	\N
2865	Presidente Bernardes	3153103	MG	2022-03-28	1	\N	\N	\N	\N
2866	Presidente Juscelino	3153202	MG	2022-03-28	1	\N	\N	\N	\N
2867	Presidente Kubitschek	3153301	MG	2022-03-28	1	\N	\N	\N	\N
2868	Presidente Olegário	3153400	MG	2022-03-28	1	\N	\N	\N	\N
2869	Prudente de Morais	3153608	MG	2022-03-28	1	\N	\N	\N	\N
2870	Quartel Geral	3153707	MG	2022-03-28	1	\N	\N	\N	\N
2871	Queluzito	3153806	MG	2022-03-28	1	\N	\N	\N	\N
2873	Raul Soares	3154002	MG	2022-03-28	1	\N	\N	\N	\N
2874	Recreio	3154101	MG	2022-03-28	1	\N	\N	\N	\N
2875	Reduto	3154150	MG	2022-03-28	1	\N	\N	\N	\N
2876	Resende Costa	3154200	MG	2022-03-28	1	\N	\N	\N	\N
2877	Resplendor	3154309	MG	2022-03-28	1	\N	\N	\N	\N
2878	Ressaquinha	3154408	MG	2022-03-28	1	\N	\N	\N	\N
2879	Riachinho	3154457	MG	2022-03-28	1	\N	\N	\N	\N
2880	Riacho dos Machados	3154507	MG	2022-03-28	1	\N	\N	\N	\N
2881	Ribeirão das Neves	3154606	MG	2022-03-28	1	\N	\N	\N	\N
2882	Ribeirão Vermelho	3154705	MG	2022-03-28	1	\N	\N	\N	\N
2883	Rio Acima	3154804	MG	2022-03-28	1	\N	\N	\N	\N
2884	Rio Casca	3154903	MG	2022-03-28	1	\N	\N	\N	\N
2885	Rio do Prado	3155108	MG	2022-03-28	1	\N	\N	\N	\N
2886	Rio Doce	3155009	MG	2022-03-28	1	\N	\N	\N	\N
2887	Rio Espera	3155207	MG	2022-03-28	1	\N	\N	\N	\N
2888	Rio Manso	3155306	MG	2022-03-28	1	\N	\N	\N	\N
2889	Rio Novo	3155405	MG	2022-03-28	1	\N	\N	\N	\N
2890	Rio Paranaíba	3155504	MG	2022-03-28	1	\N	\N	\N	\N
2891	Rio Pardo de Minas	3155603	MG	2022-03-28	1	\N	\N	\N	\N
2892	Rio Piracicaba	3155702	MG	2022-03-28	1	\N	\N	\N	\N
2893	Rio Pomba	3155801	MG	2022-03-28	1	\N	\N	\N	\N
2894	Rio Preto	3155900	MG	2022-03-28	1	\N	\N	\N	\N
2895	Rio Vermelho	3156007	MG	2022-03-28	1	\N	\N	\N	\N
2896	Ritápolis	3156106	MG	2022-03-28	1	\N	\N	\N	\N
2897	Rochedo de Minas	3156205	MG	2022-03-28	1	\N	\N	\N	\N
2898	Rodeiro	3156304	MG	2022-03-28	1	\N	\N	\N	\N
2899	Romaria	3156403	MG	2022-03-28	1	\N	\N	\N	\N
2900	Rosário da Limeira	3156452	MG	2022-03-28	1	\N	\N	\N	\N
2901	Rubelita	3156502	MG	2022-03-28	1	\N	\N	\N	\N
2902	Rubim	3156601	MG	2022-03-28	1	\N	\N	\N	\N
2903	Sabará	3156700	MG	2022-03-28	1	\N	\N	\N	\N
2904	Sabinópolis	3156809	MG	2022-03-28	1	\N	\N	\N	\N
2905	Sacramento	3156908	MG	2022-03-28	1	\N	\N	\N	\N
2906	Salinas	3157005	MG	2022-03-28	1	\N	\N	\N	\N
2907	Salto da Divisa	3157104	MG	2022-03-28	1	\N	\N	\N	\N
2908	Santa Bárbara	3157203	MG	2022-03-28	1	\N	\N	\N	\N
2909	Santa Bárbara do Leste	3157252	MG	2022-03-28	1	\N	\N	\N	\N
2910	Santa Bárbara do Monte Verde	3157278	MG	2022-03-28	1	\N	\N	\N	\N
2911	Santa Bárbara do Tugúrio	3157302	MG	2022-03-28	1	\N	\N	\N	\N
2912	Santa Cruz de Minas	3157336	MG	2022-03-28	1	\N	\N	\N	\N
2913	Santa Cruz de Salinas	3157377	MG	2022-03-28	1	\N	\N	\N	\N
2914	Santa Cruz do Escalvado	3157401	MG	2022-03-28	1	\N	\N	\N	\N
2915	Santa Efigênia de Minas	3157500	MG	2022-03-28	1	\N	\N	\N	\N
2916	Santa Fé de Minas	3157609	MG	2022-03-28	1	\N	\N	\N	\N
2917	Santa Helena de Minas	3157658	MG	2022-03-28	1	\N	\N	\N	\N
2918	Santa Juliana	3157708	MG	2022-03-28	1	\N	\N	\N	\N
2919	Santa Luzia	3157807	MG	2022-03-28	1	\N	\N	\N	\N
2920	Santa Margarida	3157906	MG	2022-03-28	1	\N	\N	\N	\N
2921	Santa Maria de Itabira	3158003	MG	2022-03-28	1	\N	\N	\N	\N
2922	Santa Maria do Salto	3158102	MG	2022-03-28	1	\N	\N	\N	\N
2923	Santa Maria do Suaçuí	3158201	MG	2022-03-28	1	\N	\N	\N	\N
2924	Santa Rita de Caldas	3159209	MG	2022-03-28	1	\N	\N	\N	\N
2925	Santa Rita de Ibitipoca	3159407	MG	2022-03-28	1	\N	\N	\N	\N
2926	Santa Rita de Jacutinga	3159308	MG	2022-03-28	1	\N	\N	\N	\N
2927	Santa Rita de Minas	3159357	MG	2022-03-28	1	\N	\N	\N	\N
2928	Santa Rita do Itueto	3159506	MG	2022-03-28	1	\N	\N	\N	\N
2929	Santa Rita do Sapucaí	3159605	MG	2022-03-28	1	\N	\N	\N	\N
2930	Santa Rosa da Serra	3159704	MG	2022-03-28	1	\N	\N	\N	\N
2931	Santa Vitória	3159803	MG	2022-03-28	1	\N	\N	\N	\N
2932	Santana da Vargem	3158300	MG	2022-03-28	1	\N	\N	\N	\N
2933	Santana de Cataguases	3158409	MG	2022-03-28	1	\N	\N	\N	\N
2934	Santana de Pirapama	3158508	MG	2022-03-28	1	\N	\N	\N	\N
2935	Santana do Deserto	3158607	MG	2022-03-28	1	\N	\N	\N	\N
2936	Santana do Garambéu	3158706	MG	2022-03-28	1	\N	\N	\N	\N
2937	Santana do Jacaré	3158805	MG	2022-03-28	1	\N	\N	\N	\N
2938	Santana do Manhuaçu	3158904	MG	2022-03-28	1	\N	\N	\N	\N
2939	Santana do Paraíso	3158953	MG	2022-03-28	1	\N	\N	\N	\N
2940	Santana do Riacho	3159001	MG	2022-03-28	1	\N	\N	\N	\N
2941	Santana dos Montes	3159100	MG	2022-03-28	1	\N	\N	\N	\N
2942	Santo Antônio do Amparo	3159902	MG	2022-03-28	1	\N	\N	\N	\N
2943	Santo Antônio do Aventureiro	3160009	MG	2022-03-28	1	\N	\N	\N	\N
2944	Santo Antônio do Grama	3160108	MG	2022-03-28	1	\N	\N	\N	\N
2945	Santo Antônio do Itambé	3160207	MG	2022-03-28	1	\N	\N	\N	\N
2946	Santo Antônio do Jacinto	3160306	MG	2022-03-28	1	\N	\N	\N	\N
2947	Santo Antônio do Monte	3160405	MG	2022-03-28	1	\N	\N	\N	\N
2948	Santo Antônio do Retiro	3160454	MG	2022-03-28	1	\N	\N	\N	\N
2949	Santo Antônio do Rio Abaixo	3160504	MG	2022-03-28	1	\N	\N	\N	\N
2950	Santo Hipólito	3160603	MG	2022-03-28	1	\N	\N	\N	\N
2951	Santos Dumont	3160702	MG	2022-03-28	1	\N	\N	\N	\N
2952	São Bento Abade	3160801	MG	2022-03-28	1	\N	\N	\N	\N
2953	São Brás do Suaçuí	3160900	MG	2022-03-28	1	\N	\N	\N	\N
2954	São Domingos das Dores	3160959	MG	2022-03-28	1	\N	\N	\N	\N
2955	São Domingos do Prata	3161007	MG	2022-03-28	1	\N	\N	\N	\N
2956	São Félix de Minas	3161056	MG	2022-03-28	1	\N	\N	\N	\N
2957	São Francisco	3161106	MG	2022-03-28	1	\N	\N	\N	\N
2958	São Francisco de Paula	3161205	MG	2022-03-28	1	\N	\N	\N	\N
2959	São Francisco de Sales	3161304	MG	2022-03-28	1	\N	\N	\N	\N
2960	São Francisco do Glória	3161403	MG	2022-03-28	1	\N	\N	\N	\N
2961	São Geraldo	3161502	MG	2022-03-28	1	\N	\N	\N	\N
2962	São Geraldo da Piedade	3161601	MG	2022-03-28	1	\N	\N	\N	\N
2963	São Geraldo do Baixio	3161650	MG	2022-03-28	1	\N	\N	\N	\N
2964	São Gonçalo do Abaeté	3161700	MG	2022-03-28	1	\N	\N	\N	\N
2965	São Gonçalo do Pará	3161809	MG	2022-03-28	1	\N	\N	\N	\N
2966	São Gonçalo do Rio Abaixo	3161908	MG	2022-03-28	1	\N	\N	\N	\N
2967	São Gonçalo do Rio Preto	3125507	MG	2022-03-28	1	\N	\N	\N	\N
2968	São Gonçalo do Sapucaí	3162005	MG	2022-03-28	1	\N	\N	\N	\N
2969	São Gotardo	3162104	MG	2022-03-28	1	\N	\N	\N	\N
2970	São João Batista do Glória	3162203	MG	2022-03-28	1	\N	\N	\N	\N
2971	São João da Lagoa	3162252	MG	2022-03-28	1	\N	\N	\N	\N
2972	São João da Mata	3162302	MG	2022-03-28	1	\N	\N	\N	\N
2973	São João da Ponte	3162401	MG	2022-03-28	1	\N	\N	\N	\N
2974	São João das Missões	3162450	MG	2022-03-28	1	\N	\N	\N	\N
2975	São João del Rei	3162500	MG	2022-03-28	1	\N	\N	\N	\N
2976	São João do Manhuaçu	3162559	MG	2022-03-28	1	\N	\N	\N	\N
2977	São João do Manteninha	3162575	MG	2022-03-28	1	\N	\N	\N	\N
2978	São João do Oriente	3162609	MG	2022-03-28	1	\N	\N	\N	\N
2979	São João do Pacuí	3162658	MG	2022-03-28	1	\N	\N	\N	\N
2980	São João do Paraíso	3162708	MG	2022-03-28	1	\N	\N	\N	\N
2981	São João Evangelista	3162807	MG	2022-03-28	1	\N	\N	\N	\N
2982	São João Nepomuceno	3162906	MG	2022-03-28	1	\N	\N	\N	\N
2983	São Joaquim de Bicas	3162922	MG	2022-03-28	1	\N	\N	\N	\N
2984	São José da Barra	3162948	MG	2022-03-28	1	\N	\N	\N	\N
2985	São José da Lapa	3162955	MG	2022-03-28	1	\N	\N	\N	\N
2986	São José da Safira	3163003	MG	2022-03-28	1	\N	\N	\N	\N
2987	São José da Varginha	3163102	MG	2022-03-28	1	\N	\N	\N	\N
2988	São José do Alegre	3163201	MG	2022-03-28	1	\N	\N	\N	\N
2989	São José do Divino	3163300	MG	2022-03-28	1	\N	\N	\N	\N
2990	São José do Goiabal	3163409	MG	2022-03-28	1	\N	\N	\N	\N
2991	São José do Jacuri	3163508	MG	2022-03-28	1	\N	\N	\N	\N
2992	São José do Mantimento	3163607	MG	2022-03-28	1	\N	\N	\N	\N
2993	São Lourenço	3163706	MG	2022-03-28	1	\N	\N	\N	\N
2994	São Miguel do Anta	3163805	MG	2022-03-28	1	\N	\N	\N	\N
2995	São Pedro da União	3163904	MG	2022-03-28	1	\N	\N	\N	\N
2996	São Pedro do Suaçuí	3164100	MG	2022-03-28	1	\N	\N	\N	\N
2997	São Pedro dos Ferros	3164001	MG	2022-03-28	1	\N	\N	\N	\N
2998	São Romão	3164209	MG	2022-03-28	1	\N	\N	\N	\N
2999	São Roque de Minas	3164308	MG	2022-03-28	1	\N	\N	\N	\N
3000	São Sebastião da Bela Vista	3164407	MG	2022-03-28	1	\N	\N	\N	\N
3001	São Sebastião da Vargem Alegre	3164431	MG	2022-03-28	1	\N	\N	\N	\N
3002	São Sebastião do Anta	3164472	MG	2022-03-28	1	\N	\N	\N	\N
3003	São Sebastião do Maranhão	3164506	MG	2022-03-28	1	\N	\N	\N	\N
3004	São Sebastião do Oeste	3164605	MG	2022-03-28	1	\N	\N	\N	\N
3005	São Sebastião do Paraíso	3164704	MG	2022-03-28	1	\N	\N	\N	\N
3006	São Sebastião do Rio Preto	3164803	MG	2022-03-28	1	\N	\N	\N	\N
3007	São Sebastião do Rio Verde	3164902	MG	2022-03-28	1	\N	\N	\N	\N
3008	São Tiago	3165008	MG	2022-03-28	1	\N	\N	\N	\N
3009	São Tomás de Aquino	3165107	MG	2022-03-28	1	\N	\N	\N	\N
3010	São Tomé das Letras	3165206	MG	2022-03-28	1	\N	\N	\N	\N
3011	São Vicente de Minas	3165305	MG	2022-03-28	1	\N	\N	\N	\N
3012	Sapucaí-Mirim	3165404	MG	2022-03-28	1	\N	\N	\N	\N
3013	Sardoá	3165503	MG	2022-03-28	1	\N	\N	\N	\N
3014	Sarzedo	3165537	MG	2022-03-28	1	\N	\N	\N	\N
3015	Sem-Peixe	3165560	MG	2022-03-28	1	\N	\N	\N	\N
3016	Senador Amaral	3165578	MG	2022-03-28	1	\N	\N	\N	\N
3017	Senador Cortes	3165602	MG	2022-03-28	1	\N	\N	\N	\N
3018	Senador Firmino	3165701	MG	2022-03-28	1	\N	\N	\N	\N
3019	Senador José Bento	3165800	MG	2022-03-28	1	\N	\N	\N	\N
3020	Senador Modestino Gonçalves	3165909	MG	2022-03-28	1	\N	\N	\N	\N
3021	Senhora de Oliveira	3166006	MG	2022-03-28	1	\N	\N	\N	\N
3022	Senhora do Porto	3166105	MG	2022-03-28	1	\N	\N	\N	\N
3023	Senhora dos Remédios	3166204	MG	2022-03-28	1	\N	\N	\N	\N
3024	Sericita	3166303	MG	2022-03-28	1	\N	\N	\N	\N
3025	Seritinga	3166402	MG	2022-03-28	1	\N	\N	\N	\N
3026	Serra Azul de Minas	3166501	MG	2022-03-28	1	\N	\N	\N	\N
3027	Serra da Saudade	3166600	MG	2022-03-28	1	\N	\N	\N	\N
3028	Serra do Salitre	3166808	MG	2022-03-28	1	\N	\N	\N	\N
3029	Serra dos Aimorés	3166709	MG	2022-03-28	1	\N	\N	\N	\N
3030	Serrania	3166907	MG	2022-03-28	1	\N	\N	\N	\N
3031	Serranópolis de Minas	3166956	MG	2022-03-28	1	\N	\N	\N	\N
3032	Serranos	3167004	MG	2022-03-28	1	\N	\N	\N	\N
3033	Serro	3167103	MG	2022-03-28	1	\N	\N	\N	\N
3034	Sete Lagoas	3167202	MG	2022-03-28	1	\N	\N	\N	\N
3035	Setubinha	3165552	MG	2022-03-28	1	\N	\N	\N	\N
3036	Silveirânia	3167301	MG	2022-03-28	1	\N	\N	\N	\N
3037	Silvianópolis	3167400	MG	2022-03-28	1	\N	\N	\N	\N
3038	Simão Pereira	3167509	MG	2022-03-28	1	\N	\N	\N	\N
3039	Simonésia	3167608	MG	2022-03-28	1	\N	\N	\N	\N
3040	Sobrália	3167707	MG	2022-03-28	1	\N	\N	\N	\N
3041	Soledade de Minas	3167806	MG	2022-03-28	1	\N	\N	\N	\N
3042	Tabuleiro	3167905	MG	2022-03-28	1	\N	\N	\N	\N
3043	Taiobeiras	3168002	MG	2022-03-28	1	\N	\N	\N	\N
3044	Taparuba	3168051	MG	2022-03-28	1	\N	\N	\N	\N
3045	Tapira	3168101	MG	2022-03-28	1	\N	\N	\N	\N
3046	Tapiraí	3168200	MG	2022-03-28	1	\N	\N	\N	\N
3047	Taquaraçu de Minas	3168309	MG	2022-03-28	1	\N	\N	\N	\N
3048	Tarumirim	3168408	MG	2022-03-28	1	\N	\N	\N	\N
3049	Teixeiras	3168507	MG	2022-03-28	1	\N	\N	\N	\N
3050	Teófilo Otoni	3168606	MG	2022-03-28	1	\N	\N	\N	\N
3051	Timóteo	3168705	MG	2022-03-28	1	\N	\N	\N	\N
3052	Tiradentes	3168804	MG	2022-03-28	1	\N	\N	\N	\N
3053	Tiros	3168903	MG	2022-03-28	1	\N	\N	\N	\N
3054	Tocantins	3169000	MG	2022-03-28	1	\N	\N	\N	\N
3055	Tocos do Moji	3169059	MG	2022-03-28	1	\N	\N	\N	\N
3056	Toledo	3169109	MG	2022-03-28	1	\N	\N	\N	\N
3057	Tombos	3169208	MG	2022-03-28	1	\N	\N	\N	\N
3058	Três Corações	3169307	MG	2022-03-28	1	\N	\N	\N	\N
3059	Três Marias	3169356	MG	2022-03-28	1	\N	\N	\N	\N
3060	Três Pontas	3169406	MG	2022-03-28	1	\N	\N	\N	\N
3061	Tumiritinga	3169505	MG	2022-03-28	1	\N	\N	\N	\N
3062	Tupaciguara	3169604	MG	2022-03-28	1	\N	\N	\N	\N
3063	Turmalina	3169703	MG	2022-03-28	1	\N	\N	\N	\N
3064	Turvolândia	3169802	MG	2022-03-28	1	\N	\N	\N	\N
3065	Ubá	3169901	MG	2022-03-28	1	\N	\N	\N	\N
3066	Ubaí	3170008	MG	2022-03-28	1	\N	\N	\N	\N
3067	Ubaporanga	3170057	MG	2022-03-28	1	\N	\N	\N	\N
3068	Uberaba	3170107	MG	2022-03-28	1	\N	\N	\N	\N
3069	Uberlândia	3170206	MG	2022-03-28	1	\N	\N	\N	\N
3070	Umburatiba	3170305	MG	2022-03-28	1	\N	\N	\N	\N
3071	Unaí	3170404	MG	2022-03-28	1	\N	\N	\N	\N
3072	União de Minas	3170438	MG	2022-03-28	1	\N	\N	\N	\N
3073	Uruana de Minas	3170479	MG	2022-03-28	1	\N	\N	\N	\N
3074	Urucânia	3170503	MG	2022-03-28	1	\N	\N	\N	\N
3076	Vargem Alegre	3170578	MG	2022-03-28	1	\N	\N	\N	\N
3077	Vargem Bonita	3170602	MG	2022-03-28	1	\N	\N	\N	\N
3078	Vargem Grande do Rio Pardo	3170651	MG	2022-03-28	1	\N	\N	\N	\N
3079	Varginha	3170701	MG	2022-03-28	1	\N	\N	\N	\N
3080	Varjão de Minas	3170750	MG	2022-03-28	1	\N	\N	\N	\N
3081	Várzea da Palma	3170800	MG	2022-03-28	1	\N	\N	\N	\N
3082	Varzelândia	3170909	MG	2022-03-28	1	\N	\N	\N	\N
3083	Vazante	3171006	MG	2022-03-28	1	\N	\N	\N	\N
3084	Verdelândia	3171030	MG	2022-03-28	1	\N	\N	\N	\N
3085	Veredinha	3171071	MG	2022-03-28	1	\N	\N	\N	\N
3086	Veríssimo	3171105	MG	2022-03-28	1	\N	\N	\N	\N
3087	Vermelho Novo	3171154	MG	2022-03-28	1	\N	\N	\N	\N
3088	Vespasiano	3171204	MG	2022-03-28	1	\N	\N	\N	\N
3089	Viçosa	3171303	MG	2022-03-28	1	\N	\N	\N	\N
3090	Vieiras	3171402	MG	2022-03-28	1	\N	\N	\N	\N
3091	Virgem da Lapa	3171600	MG	2022-03-28	1	\N	\N	\N	\N
3092	Virgínia	3171709	MG	2022-03-28	1	\N	\N	\N	\N
3093	Virginópolis	3171808	MG	2022-03-28	1	\N	\N	\N	\N
3094	Virgolândia	3171907	MG	2022-03-28	1	\N	\N	\N	\N
3095	Visconde do Rio Branco	3172004	MG	2022-03-28	1	\N	\N	\N	\N
3096	Volta Grande	3172103	MG	2022-03-28	1	\N	\N	\N	\N
3097	Wenceslau Braz	3172202	MG	2022-03-28	1	\N	\N	\N	\N
3098	Afonso Cláudio	3200102	ES	2022-03-28	1	\N	\N	\N	\N
3099	Água Doce do Norte	3200169	ES	2022-03-28	1	\N	\N	\N	\N
3100	Águia Branca	3200136	ES	2022-03-28	1	\N	\N	\N	\N
3101	Alegre	3200201	ES	2022-03-28	1	\N	\N	\N	\N
3102	Alfredo Chaves	3200300	ES	2022-03-28	1	\N	\N	\N	\N
3103	Alto Rio Novo	3200359	ES	2022-03-28	1	\N	\N	\N	\N
3104	Anchieta	3200409	ES	2022-03-28	1	\N	\N	\N	\N
3105	Apiacá	3200508	ES	2022-03-28	1	\N	\N	\N	\N
3106	Aracruz	3200607	ES	2022-03-28	1	\N	\N	\N	\N
3107	Atílio Vivácqua	3200706	ES	2022-03-28	1	\N	\N	\N	\N
3108	Baixo Guandu	3200805	ES	2022-03-28	1	\N	\N	\N	\N
3109	Barra de São Francisco	3200904	ES	2022-03-28	1	\N	\N	\N	\N
3110	Boa Esperança	3201001	ES	2022-03-28	1	\N	\N	\N	\N
3111	Bom Jesus do Norte	3201100	ES	2022-03-28	1	\N	\N	\N	\N
3112	Brejetuba	3201159	ES	2022-03-28	1	\N	\N	\N	\N
3113	Cachoeiro de Itapemirim	3201209	ES	2022-03-28	1	\N	\N	\N	\N
3114	Cariacica	3201308	ES	2022-03-28	1	\N	\N	\N	\N
3115	Castelo	3201407	ES	2022-03-28	1	\N	\N	\N	\N
3116	Colatina	3201506	ES	2022-03-28	1	\N	\N	\N	\N
3117	Conceição da Barra	3201605	ES	2022-03-28	1	\N	\N	\N	\N
3118	Conceição do Castelo	3201704	ES	2022-03-28	1	\N	\N	\N	\N
3119	Divino de São Lourenço	3201803	ES	2022-03-28	1	\N	\N	\N	\N
3120	Domingos Martins	3201902	ES	2022-03-28	1	\N	\N	\N	\N
3121	Dores do Rio Preto	3202009	ES	2022-03-28	1	\N	\N	\N	\N
3122	Ecoporanga	3202108	ES	2022-03-28	1	\N	\N	\N	\N
3123	Fundão	3202207	ES	2022-03-28	1	\N	\N	\N	\N
3124	Governador Lindenberg	3202256	ES	2022-03-28	1	\N	\N	\N	\N
3125	Guaçuí	3202306	ES	2022-03-28	1	\N	\N	\N	\N
3126	Guarapari	3202405	ES	2022-03-28	1	\N	\N	\N	\N
3127	Ibatiba	3202454	ES	2022-03-28	1	\N	\N	\N	\N
3128	Ibiraçu	3202504	ES	2022-03-28	1	\N	\N	\N	\N
3129	Ibitirama	3202553	ES	2022-03-28	1	\N	\N	\N	\N
3130	Iconha	3202603	ES	2022-03-28	1	\N	\N	\N	\N
3131	Irupi	3202652	ES	2022-03-28	1	\N	\N	\N	\N
3132	Itaguaçu	3202702	ES	2022-03-28	1	\N	\N	\N	\N
3133	Itapemirim	3202801	ES	2022-03-28	1	\N	\N	\N	\N
3134	Itarana	3202900	ES	2022-03-28	1	\N	\N	\N	\N
3135	Iúna	3203007	ES	2022-03-28	1	\N	\N	\N	\N
3136	Jaguaré	3203056	ES	2022-03-28	1	\N	\N	\N	\N
3137	Jerônimo Monteiro	3203106	ES	2022-03-28	1	\N	\N	\N	\N
3138	João Neiva	3203130	ES	2022-03-28	1	\N	\N	\N	\N
3139	Laranja da Terra	3203163	ES	2022-03-28	1	\N	\N	\N	\N
3140	Linhares	3203205	ES	2022-03-28	1	\N	\N	\N	\N
3141	Mantenópolis	3203304	ES	2022-03-28	1	\N	\N	\N	\N
3142	Marataízes	3203320	ES	2022-03-28	1	\N	\N	\N	\N
3143	Marechal Floriano	3203346	ES	2022-03-28	1	\N	\N	\N	\N
3144	Marilândia	3203353	ES	2022-03-28	1	\N	\N	\N	\N
3145	Mimoso do Sul	3203403	ES	2022-03-28	1	\N	\N	\N	\N
3146	Montanha	3203502	ES	2022-03-28	1	\N	\N	\N	\N
3147	Mucurici	3203601	ES	2022-03-28	1	\N	\N	\N	\N
3148	Muniz Freire	3203700	ES	2022-03-28	1	\N	\N	\N	\N
3149	Muqui	3203809	ES	2022-03-28	1	\N	\N	\N	\N
3150	Nova Venécia	3203908	ES	2022-03-28	1	\N	\N	\N	\N
3151	Pancas	3204005	ES	2022-03-28	1	\N	\N	\N	\N
3152	Pedro Canário	3204054	ES	2022-03-28	1	\N	\N	\N	\N
3153	Pinheiros	3204104	ES	2022-03-28	1	\N	\N	\N	\N
3154	Piúma	3204203	ES	2022-03-28	1	\N	\N	\N	\N
3155	Ponto Belo	3204252	ES	2022-03-28	1	\N	\N	\N	\N
3156	Presidente Kennedy	3204302	ES	2022-03-28	1	\N	\N	\N	\N
3157	Rio Bananal	3204351	ES	2022-03-28	1	\N	\N	\N	\N
3158	Rio Novo do Sul	3204401	ES	2022-03-28	1	\N	\N	\N	\N
3159	Santa Leopoldina	3204500	ES	2022-03-28	1	\N	\N	\N	\N
3160	Santa Maria de Jetibá	3204559	ES	2022-03-28	1	\N	\N	\N	\N
3161	Santa Teresa	3204609	ES	2022-03-28	1	\N	\N	\N	\N
3162	São Domingos do Norte	3204658	ES	2022-03-28	1	\N	\N	\N	\N
3163	São Gabriel da Palha	3204708	ES	2022-03-28	1	\N	\N	\N	\N
3164	São José do Calçado	3204807	ES	2022-03-28	1	\N	\N	\N	\N
3165	São Mateus	3204906	ES	2022-03-28	1	\N	\N	\N	\N
3166	São Roque do Canaã	3204955	ES	2022-03-28	1	\N	\N	\N	\N
3167	Serra	3205002	ES	2022-03-28	1	\N	\N	\N	\N
3168	Sooretama	3205010	ES	2022-03-28	1	\N	\N	\N	\N
3169	Vargem Alta	3205036	ES	2022-03-28	1	\N	\N	\N	\N
3170	Venda Nova do Imigrante	3205069	ES	2022-03-28	1	\N	\N	\N	\N
3171	Viana	3205101	ES	2022-03-28	1	\N	\N	\N	\N
3172	Vila Pavão	3205150	ES	2022-03-28	1	\N	\N	\N	\N
3173	Vila Valério	3205176	ES	2022-03-28	1	\N	\N	\N	\N
3174	Vila Velha	3205200	ES	2022-03-28	1	\N	\N	\N	\N
3175	Vitória	3205309	ES	2022-03-28	1	\N	\N	\N	\N
3176	Angra dos Reis	3300100	RJ	2022-03-28	1	\N	\N	\N	\N
3177	Aperibé	3300159	RJ	2022-03-28	1	\N	\N	\N	\N
3178	Araruama	3300209	RJ	2022-03-28	1	\N	\N	\N	\N
3179	Areal	3300225	RJ	2022-03-28	1	\N	\N	\N	\N
3180	Armação dos Búzios	3300233	RJ	2022-03-28	1	\N	\N	\N	\N
3181	Arraial do Cabo	3300258	RJ	2022-03-28	1	\N	\N	\N	\N
3182	Barra do Piraí	3300308	RJ	2022-03-28	1	\N	\N	\N	\N
3183	Barra Mansa	3300407	RJ	2022-03-28	1	\N	\N	\N	\N
3184	Belford Roxo	3300456	RJ	2022-03-28	1	\N	\N	\N	\N
3185	Bom Jardim	3300506	RJ	2022-03-28	1	\N	\N	\N	\N
3186	Bom Jesus do Itabapoana	3300605	RJ	2022-03-28	1	\N	\N	\N	\N
3187	Cabo Frio	3300704	RJ	2022-03-28	1	\N	\N	\N	\N
3188	Cachoeiras de Macacu	3300803	RJ	2022-03-28	1	\N	\N	\N	\N
3189	Cambuci	3300902	RJ	2022-03-28	1	\N	\N	\N	\N
3190	Campos dos Goytacazes	3301009	RJ	2022-03-28	1	\N	\N	\N	\N
3191	Cantagalo	3301108	RJ	2022-03-28	1	\N	\N	\N	\N
3192	Carapebus	3300936	RJ	2022-03-28	1	\N	\N	\N	\N
3193	Cardoso Moreira	3301157	RJ	2022-03-28	1	\N	\N	\N	\N
3194	Carmo	3301207	RJ	2022-03-28	1	\N	\N	\N	\N
3195	Casimiro de Abreu	3301306	RJ	2022-03-28	1	\N	\N	\N	\N
3196	Comendador Levy Gasparian	3300951	RJ	2022-03-28	1	\N	\N	\N	\N
3197	Conceição de Macabu	3301405	RJ	2022-03-28	1	\N	\N	\N	\N
3198	Cordeiro	3301504	RJ	2022-03-28	1	\N	\N	\N	\N
3199	Duas Barras	3301603	RJ	2022-03-28	1	\N	\N	\N	\N
3200	Duque de Caxias	3301702	RJ	2022-03-28	1	\N	\N	\N	\N
3201	Engenheiro Paulo de Frontin	3301801	RJ	2022-03-28	1	\N	\N	\N	\N
3202	Guapimirim	3301850	RJ	2022-03-28	1	\N	\N	\N	\N
3203	Iguaba Grande	3301876	RJ	2022-03-28	1	\N	\N	\N	\N
3204	Itaboraí	3301900	RJ	2022-03-28	1	\N	\N	\N	\N
3205	Itaguaí	3302007	RJ	2022-03-28	1	\N	\N	\N	\N
3206	Italva	3302056	RJ	2022-03-28	1	\N	\N	\N	\N
3207	Itaocara	3302106	RJ	2022-03-28	1	\N	\N	\N	\N
3208	Itaperuna	3302205	RJ	2022-03-28	1	\N	\N	\N	\N
3209	Itatiaia	3302254	RJ	2022-03-28	1	\N	\N	\N	\N
3210	Japeri	3302270	RJ	2022-03-28	1	\N	\N	\N	\N
3211	Laje do Muriaé	3302304	RJ	2022-03-28	1	\N	\N	\N	\N
3212	Macaé	3302403	RJ	2022-03-28	1	\N	\N	\N	\N
3213	Macuco	3302452	RJ	2022-03-28	1	\N	\N	\N	\N
3214	Magé	3302502	RJ	2022-03-28	1	\N	\N	\N	\N
3215	Mangaratiba	3302601	RJ	2022-03-28	1	\N	\N	\N	\N
3216	Maricá	3302700	RJ	2022-03-28	1	\N	\N	\N	\N
3217	Mendes	3302809	RJ	2022-03-28	1	\N	\N	\N	\N
3218	Mesquita	3302858	RJ	2022-03-28	1	\N	\N	\N	\N
3219	Miguel Pereira	3302908	RJ	2022-03-28	1	\N	\N	\N	\N
3220	Miracema	3303005	RJ	2022-03-28	1	\N	\N	\N	\N
3221	Natividade	3303104	RJ	2022-03-28	1	\N	\N	\N	\N
3222	Nilópolis	3303203	RJ	2022-03-28	1	\N	\N	\N	\N
3223	Niterói	3303302	RJ	2022-03-28	1	\N	\N	\N	\N
3224	Nova Friburgo	3303401	RJ	2022-03-28	1	\N	\N	\N	\N
3225	Nova Iguaçu	3303500	RJ	2022-03-28	1	\N	\N	\N	\N
3226	Paracambi	3303609	RJ	2022-03-28	1	\N	\N	\N	\N
3227	Paraíba do Sul	3303708	RJ	2022-03-28	1	\N	\N	\N	\N
3228	Paraty	3303807	RJ	2022-03-28	1	\N	\N	\N	\N
3229	Paty do Alferes	3303856	RJ	2022-03-28	1	\N	\N	\N	\N
3230	Petrópolis	3303906	RJ	2022-03-28	1	\N	\N	\N	\N
3231	Pinheiral	3303955	RJ	2022-03-28	1	\N	\N	\N	\N
3232	Piraí	3304003	RJ	2022-03-28	1	\N	\N	\N	\N
3233	Porciúncula	3304102	RJ	2022-03-28	1	\N	\N	\N	\N
3234	Porto Real	3304110	RJ	2022-03-28	1	\N	\N	\N	\N
3235	Quatis	3304128	RJ	2022-03-28	1	\N	\N	\N	\N
3236	Queimados	3304144	RJ	2022-03-28	1	\N	\N	\N	\N
3237	Quissamã	3304151	RJ	2022-03-28	1	\N	\N	\N	\N
3238	Resende	3304201	RJ	2022-03-28	1	\N	\N	\N	\N
3239	Rio Bonito	3304300	RJ	2022-03-28	1	\N	\N	\N	\N
3240	Rio Claro	3304409	RJ	2022-03-28	1	\N	\N	\N	\N
3241	Rio das Flores	3304508	RJ	2022-03-28	1	\N	\N	\N	\N
3242	Rio das Ostras	3304524	RJ	2022-03-28	1	\N	\N	\N	\N
3243	Rio de Janeiro	3304557	RJ	2022-03-28	1	\N	\N	\N	\N
3244	Santa Maria Madalena	3304607	RJ	2022-03-28	1	\N	\N	\N	\N
3245	Santo Antônio de Pádua	3304706	RJ	2022-03-28	1	\N	\N	\N	\N
3246	São Fidélis	3304805	RJ	2022-03-28	1	\N	\N	\N	\N
3247	São Francisco de Itabapoana	3304755	RJ	2022-03-28	1	\N	\N	\N	\N
3248	São Gonçalo	3304904	RJ	2022-03-28	1	\N	\N	\N	\N
3249	São João da Barra	3305000	RJ	2022-03-28	1	\N	\N	\N	\N
3250	São João de Meriti	3305109	RJ	2022-03-28	1	\N	\N	\N	\N
3251	São José de Ubá	3305133	RJ	2022-03-28	1	\N	\N	\N	\N
3252	São José do Vale do Rio Preto	3305158	RJ	2022-03-28	1	\N	\N	\N	\N
3253	São Pedro da Aldeia	3305208	RJ	2022-03-28	1	\N	\N	\N	\N
3254	São Sebastião do Alto	3305307	RJ	2022-03-28	1	\N	\N	\N	\N
3255	Sapucaia	3305406	RJ	2022-03-28	1	\N	\N	\N	\N
3256	Saquarema	3305505	RJ	2022-03-28	1	\N	\N	\N	\N
3257	Seropédica	3305554	RJ	2022-03-28	1	\N	\N	\N	\N
3258	Silva Jardim	3305604	RJ	2022-03-28	1	\N	\N	\N	\N
3259	Sumidouro	3305703	RJ	2022-03-28	1	\N	\N	\N	\N
3260	Tanguá	3305752	RJ	2022-03-28	1	\N	\N	\N	\N
3261	Teresópolis	3305802	RJ	2022-03-28	1	\N	\N	\N	\N
3262	Trajano de Moraes	3305901	RJ	2022-03-28	1	\N	\N	\N	\N
3263	Três Rios	3306008	RJ	2022-03-28	1	\N	\N	\N	\N
3264	Valença	3306107	RJ	2022-03-28	1	\N	\N	\N	\N
3265	Varre-Sai	3306156	RJ	2022-03-28	1	\N	\N	\N	\N
3266	Vassouras	3306206	RJ	2022-03-28	1	\N	\N	\N	\N
3267	Volta Redonda	3306305	RJ	2022-03-28	1	\N	\N	\N	\N
3268	Adamantina	3500105	SP	2022-03-28	1	\N	\N	\N	\N
3269	Adolfo	3500204	SP	2022-03-28	1	\N	\N	\N	\N
3270	Aguaí	3500303	SP	2022-03-28	1	\N	\N	\N	\N
3271	Águas da Prata	3500402	SP	2022-03-28	1	\N	\N	\N	\N
3272	Águas de Lindóia	3500501	SP	2022-03-28	1	\N	\N	\N	\N
3273	Águas de Santa Bárbara	3500550	SP	2022-03-28	1	\N	\N	\N	\N
3274	Águas de São Pedro	3500600	SP	2022-03-28	1	\N	\N	\N	\N
3275	Agudos	3500709	SP	2022-03-28	1	\N	\N	\N	\N
3276	Alambari	3500758	SP	2022-03-28	1	\N	\N	\N	\N
3277	Alfredo Marcondes	3500808	SP	2022-03-28	1	\N	\N	\N	\N
3278	Altair	3500907	SP	2022-03-28	1	\N	\N	\N	\N
3279	Altinópolis	3501004	SP	2022-03-28	1	\N	\N	\N	\N
3280	Alto Alegre	3501103	SP	2022-03-28	1	\N	\N	\N	\N
3281	Alumínio	3501152	SP	2022-03-28	1	\N	\N	\N	\N
3282	Álvares Florence	3501202	SP	2022-03-28	1	\N	\N	\N	\N
3283	Álvares Machado	3501301	SP	2022-03-28	1	\N	\N	\N	\N
3284	Álvaro de Carvalho	3501400	SP	2022-03-28	1	\N	\N	\N	\N
3285	Alvinlândia	3501509	SP	2022-03-28	1	\N	\N	\N	\N
3286	Americana	3501608	SP	2022-03-28	1	\N	\N	\N	\N
3287	Américo Brasiliense	3501707	SP	2022-03-28	1	\N	\N	\N	\N
3288	Américo de Campos	3501806	SP	2022-03-28	1	\N	\N	\N	\N
3289	Amparo	3501905	SP	2022-03-28	1	\N	\N	\N	\N
3290	Analândia	3502002	SP	2022-03-28	1	\N	\N	\N	\N
3291	Andradina	3502101	SP	2022-03-28	1	\N	\N	\N	\N
3292	Angatuba	3502200	SP	2022-03-28	1	\N	\N	\N	\N
3293	Anhembi	3502309	SP	2022-03-28	1	\N	\N	\N	\N
3294	Anhumas	3502408	SP	2022-03-28	1	\N	\N	\N	\N
3295	Aparecida	3502507	SP	2022-03-28	1	\N	\N	\N	\N
3296	'Aparecida d''Oeste'	3502606	SP	2022-03-28	1	\N	\N	\N	\N
3297	Apiaí	3502705	SP	2022-03-28	1	\N	\N	\N	\N
3298	Araçariguama	3502754	SP	2022-03-28	1	\N	\N	\N	\N
3299	Araçatuba	3502804	SP	2022-03-28	1	\N	\N	\N	\N
3300	Araçoiaba da Serra	3502903	SP	2022-03-28	1	\N	\N	\N	\N
3301	Aramina	3503000	SP	2022-03-28	1	\N	\N	\N	\N
3302	Arandu	3503109	SP	2022-03-28	1	\N	\N	\N	\N
3303	Arapeí	3503158	SP	2022-03-28	1	\N	\N	\N	\N
3304	Araraquara	3503208	SP	2022-03-28	1	\N	\N	\N	\N
3305	Araras	3503307	SP	2022-03-28	1	\N	\N	\N	\N
3306	Arco-Íris	3503356	SP	2022-03-28	1	\N	\N	\N	\N
3307	Arealva	3503406	SP	2022-03-28	1	\N	\N	\N	\N
3308	Areias	3503505	SP	2022-03-28	1	\N	\N	\N	\N
3309	Areiópolis	3503604	SP	2022-03-28	1	\N	\N	\N	\N
3310	Ariranha	3503703	SP	2022-03-28	1	\N	\N	\N	\N
3311	Artur Nogueira	3503802	SP	2022-03-28	1	\N	\N	\N	\N
3312	Arujá	3503901	SP	2022-03-28	1	\N	\N	\N	\N
3313	Aspásia	3503950	SP	2022-03-28	1	\N	\N	\N	\N
3314	Assis	3504008	SP	2022-03-28	1	\N	\N	\N	\N
3315	Atibaia	3504107	SP	2022-03-28	1	\N	\N	\N	\N
3316	Auriflama	3504206	SP	2022-03-28	1	\N	\N	\N	\N
3317	Avaí	3504305	SP	2022-03-28	1	\N	\N	\N	\N
3318	Avanhandava	3504404	SP	2022-03-28	1	\N	\N	\N	\N
3319	Avaré	3504503	SP	2022-03-28	1	\N	\N	\N	\N
3320	Bady Bassitt	3504602	SP	2022-03-28	1	\N	\N	\N	\N
3321	Balbinos	3504701	SP	2022-03-28	1	\N	\N	\N	\N
3322	Bálsamo	3504800	SP	2022-03-28	1	\N	\N	\N	\N
3323	Bananal	3504909	SP	2022-03-28	1	\N	\N	\N	\N
3324	Barão de Antonina	3505005	SP	2022-03-28	1	\N	\N	\N	\N
3325	Barbosa	3505104	SP	2022-03-28	1	\N	\N	\N	\N
3326	Bariri	3505203	SP	2022-03-28	1	\N	\N	\N	\N
3327	Barra Bonita	3505302	SP	2022-03-28	1	\N	\N	\N	\N
3328	Barra do Chapéu	3505351	SP	2022-03-28	1	\N	\N	\N	\N
3329	Barra do Turvo	3505401	SP	2022-03-28	1	\N	\N	\N	\N
3330	Barretos	3505500	SP	2022-03-28	1	\N	\N	\N	\N
3331	Barrinha	3505609	SP	2022-03-28	1	\N	\N	\N	\N
3332	Barueri	3505708	SP	2022-03-28	1	\N	\N	\N	\N
3333	Bastos	3505807	SP	2022-03-28	1	\N	\N	\N	\N
3334	Batatais	3505906	SP	2022-03-28	1	\N	\N	\N	\N
3335	Bauru	3506003	SP	2022-03-28	1	\N	\N	\N	\N
3336	Bebedouro	3506102	SP	2022-03-28	1	\N	\N	\N	\N
3337	Bento de Abreu	3506201	SP	2022-03-28	1	\N	\N	\N	\N
3338	Bernardino de Campos	3506300	SP	2022-03-28	1	\N	\N	\N	\N
3339	Bertioga	3506359	SP	2022-03-28	1	\N	\N	\N	\N
3340	Bilac	3506409	SP	2022-03-28	1	\N	\N	\N	\N
3341	Birigui	3506508	SP	2022-03-28	1	\N	\N	\N	\N
3342	Biritiba Mirim	3506607	SP	2022-03-28	1	\N	\N	\N	\N
3343	Boa Esperança do Sul	3506706	SP	2022-03-28	1	\N	\N	\N	\N
3344	Bocaina	3506805	SP	2022-03-28	1	\N	\N	\N	\N
3345	Bofete	3506904	SP	2022-03-28	1	\N	\N	\N	\N
3346	Boituva	3507001	SP	2022-03-28	1	\N	\N	\N	\N
3347	Bom Jesus dos Perdões	3507100	SP	2022-03-28	1	\N	\N	\N	\N
3348	Bom Sucesso de Itararé	3507159	SP	2022-03-28	1	\N	\N	\N	\N
3349	Borá	3507209	SP	2022-03-28	1	\N	\N	\N	\N
3350	Boracéia	3507308	SP	2022-03-28	1	\N	\N	\N	\N
3351	Borborema	3507407	SP	2022-03-28	1	\N	\N	\N	\N
3352	Borebi	3507456	SP	2022-03-28	1	\N	\N	\N	\N
3353	Botucatu	3507506	SP	2022-03-28	1	\N	\N	\N	\N
3354	Bragança Paulista	3507605	SP	2022-03-28	1	\N	\N	\N	\N
3355	Braúna	3507704	SP	2022-03-28	1	\N	\N	\N	\N
3356	Brejo Alegre	3507753	SP	2022-03-28	1	\N	\N	\N	\N
3357	Brodowski	3507803	SP	2022-03-28	1	\N	\N	\N	\N
3358	Brotas	3507902	SP	2022-03-28	1	\N	\N	\N	\N
3359	Buri	3508009	SP	2022-03-28	1	\N	\N	\N	\N
3360	Buritama	3508108	SP	2022-03-28	1	\N	\N	\N	\N
3361	Buritizal	3508207	SP	2022-03-28	1	\N	\N	\N	\N
3362	Cabrália Paulista	3508306	SP	2022-03-28	1	\N	\N	\N	\N
3363	Cabreúva	3508405	SP	2022-03-28	1	\N	\N	\N	\N
3364	Caçapava	3508504	SP	2022-03-28	1	\N	\N	\N	\N
3365	Cachoeira Paulista	3508603	SP	2022-03-28	1	\N	\N	\N	\N
3366	Caconde	3508702	SP	2022-03-28	1	\N	\N	\N	\N
3367	Cafelândia	3508801	SP	2022-03-28	1	\N	\N	\N	\N
3368	Caiabu	3508900	SP	2022-03-28	1	\N	\N	\N	\N
3369	Caieiras	3509007	SP	2022-03-28	1	\N	\N	\N	\N
3370	Caiuá	3509106	SP	2022-03-28	1	\N	\N	\N	\N
3371	Cajamar	3509205	SP	2022-03-28	1	\N	\N	\N	\N
3372	Cajati	3509254	SP	2022-03-28	1	\N	\N	\N	\N
3373	Cajobi	3509304	SP	2022-03-28	1	\N	\N	\N	\N
3374	Cajuru	3509403	SP	2022-03-28	1	\N	\N	\N	\N
3375	Campina do Monte Alegre	3509452	SP	2022-03-28	1	\N	\N	\N	\N
3376	Campinas	3509502	SP	2022-03-28	1	\N	\N	\N	\N
3377	Campo Limpo Paulista	3509601	SP	2022-03-28	1	\N	\N	\N	\N
3378	Campos do Jordão	3509700	SP	2022-03-28	1	\N	\N	\N	\N
3379	Campos Novos Paulista	3509809	SP	2022-03-28	1	\N	\N	\N	\N
3380	Cananéia	3509908	SP	2022-03-28	1	\N	\N	\N	\N
3381	Canas	3509957	SP	2022-03-28	1	\N	\N	\N	\N
3382	Cândido Mota	3510005	SP	2022-03-28	1	\N	\N	\N	\N
3383	Cândido Rodrigues	3510104	SP	2022-03-28	1	\N	\N	\N	\N
3384	Canitar	3510153	SP	2022-03-28	1	\N	\N	\N	\N
3385	Capão Bonito	3510203	SP	2022-03-28	1	\N	\N	\N	\N
3386	Capela do Alto	3510302	SP	2022-03-28	1	\N	\N	\N	\N
3387	Capivari	3510401	SP	2022-03-28	1	\N	\N	\N	\N
3388	Caraguatatuba	3510500	SP	2022-03-28	1	\N	\N	\N	\N
3389	Carapicuíba	3510609	SP	2022-03-28	1	\N	\N	\N	\N
3390	Cardoso	3510708	SP	2022-03-28	1	\N	\N	\N	\N
3391	Casa Branca	3510807	SP	2022-03-28	1	\N	\N	\N	\N
3392	Cássia dos Coqueiros	3510906	SP	2022-03-28	1	\N	\N	\N	\N
3393	Castilho	3511003	SP	2022-03-28	1	\N	\N	\N	\N
3394	Catanduva	3511102	SP	2022-03-28	1	\N	\N	\N	\N
3395	Catiguá	3511201	SP	2022-03-28	1	\N	\N	\N	\N
3396	Cedral	3511300	SP	2022-03-28	1	\N	\N	\N	\N
5314	Tapurah	5108006	MT	2022-03-28	1	\N	\N	\N	\N
3397	Cerqueira César	3511409	SP	2022-03-28	1	\N	\N	\N	\N
3398	Cerquilho	3511508	SP	2022-03-28	1	\N	\N	\N	\N
3399	Cesário Lange	3511607	SP	2022-03-28	1	\N	\N	\N	\N
3400	Charqueada	3511706	SP	2022-03-28	1	\N	\N	\N	\N
3401	Chavantes	3557204	SP	2022-03-28	1	\N	\N	\N	\N
3402	Clementina	3511904	SP	2022-03-28	1	\N	\N	\N	\N
3403	Colina	3512001	SP	2022-03-28	1	\N	\N	\N	\N
3404	Colômbia	3512100	SP	2022-03-28	1	\N	\N	\N	\N
3405	Conchal	3512209	SP	2022-03-28	1	\N	\N	\N	\N
3406	Conchas	3512308	SP	2022-03-28	1	\N	\N	\N	\N
3407	Cordeirópolis	3512407	SP	2022-03-28	1	\N	\N	\N	\N
3408	Coroados	3512506	SP	2022-03-28	1	\N	\N	\N	\N
3409	Coronel Macedo	3512605	SP	2022-03-28	1	\N	\N	\N	\N
3410	Corumbataí	3512704	SP	2022-03-28	1	\N	\N	\N	\N
3411	Cosmópolis	3512803	SP	2022-03-28	1	\N	\N	\N	\N
3412	Cosmorama	3512902	SP	2022-03-28	1	\N	\N	\N	\N
3413	Cotia	3513009	SP	2022-03-28	1	\N	\N	\N	\N
3414	Cravinhos	3513108	SP	2022-03-28	1	\N	\N	\N	\N
3415	Cristais Paulista	3513207	SP	2022-03-28	1	\N	\N	\N	\N
3416	Cruzália	3513306	SP	2022-03-28	1	\N	\N	\N	\N
3417	Cruzeiro	3513405	SP	2022-03-28	1	\N	\N	\N	\N
3418	Cubatão	3513504	SP	2022-03-28	1	\N	\N	\N	\N
3419	Cunha	3513603	SP	2022-03-28	1	\N	\N	\N	\N
3420	Descalvado	3513702	SP	2022-03-28	1	\N	\N	\N	\N
3421	Diadema	3513801	SP	2022-03-28	1	\N	\N	\N	\N
3422	Dirce Reis	3513850	SP	2022-03-28	1	\N	\N	\N	\N
3423	Divinolândia	3513900	SP	2022-03-28	1	\N	\N	\N	\N
3424	Dobrada	3514007	SP	2022-03-28	1	\N	\N	\N	\N
3425	Dois Córregos	3514106	SP	2022-03-28	1	\N	\N	\N	\N
3426	Dolcinópolis	3514205	SP	2022-03-28	1	\N	\N	\N	\N
3427	Dourado	3514304	SP	2022-03-28	1	\N	\N	\N	\N
3428	Dracena	3514403	SP	2022-03-28	1	\N	\N	\N	\N
3429	Duartina	3514502	SP	2022-03-28	1	\N	\N	\N	\N
3430	Dumont	3514601	SP	2022-03-28	1	\N	\N	\N	\N
3431	Echaporã	3514700	SP	2022-03-28	1	\N	\N	\N	\N
3432	Eldorado	3514809	SP	2022-03-28	1	\N	\N	\N	\N
3433	Elias Fausto	3514908	SP	2022-03-28	1	\N	\N	\N	\N
3434	Elisiário	3514924	SP	2022-03-28	1	\N	\N	\N	\N
3435	Embaúba	3514957	SP	2022-03-28	1	\N	\N	\N	\N
3436	Embu das Artes	3515004	SP	2022-03-28	1	\N	\N	\N	\N
3437	Embu-Guaçu	3515103	SP	2022-03-28	1	\N	\N	\N	\N
3438	Emilianópolis	3515129	SP	2022-03-28	1	\N	\N	\N	\N
3439	Engenheiro Coelho	3515152	SP	2022-03-28	1	\N	\N	\N	\N
3440	Espírito Santo do Pinhal	3515186	SP	2022-03-28	1	\N	\N	\N	\N
3441	Espírito Santo do Turvo	3515194	SP	2022-03-28	1	\N	\N	\N	\N
3442	Estiva Gerbi	3557303	SP	2022-03-28	1	\N	\N	\N	\N
3443	Estrela do Norte	3515301	SP	2022-03-28	1	\N	\N	\N	\N
3444	'Estrela d''Oeste'	3515202	SP	2022-03-28	1	\N	\N	\N	\N
3445	Euclides da Cunha Paulista	3515350	SP	2022-03-28	1	\N	\N	\N	\N
3446	Fartura	3515400	SP	2022-03-28	1	\N	\N	\N	\N
3447	Fernando Prestes	3515608	SP	2022-03-28	1	\N	\N	\N	\N
3448	Fernandópolis	3515509	SP	2022-03-28	1	\N	\N	\N	\N
3449	Fernão	3515657	SP	2022-03-28	1	\N	\N	\N	\N
3450	Ferraz de Vasconcelos	3515707	SP	2022-03-28	1	\N	\N	\N	\N
3451	Flora Rica	3515806	SP	2022-03-28	1	\N	\N	\N	\N
3452	Floreal	3515905	SP	2022-03-28	1	\N	\N	\N	\N
3453	Flórida Paulista	3516002	SP	2022-03-28	1	\N	\N	\N	\N
3454	Florínea	3516101	SP	2022-03-28	1	\N	\N	\N	\N
3455	Franca	3516200	SP	2022-03-28	1	\N	\N	\N	\N
3456	Francisco Morato	3516309	SP	2022-03-28	1	\N	\N	\N	\N
3457	Franco da Rocha	3516408	SP	2022-03-28	1	\N	\N	\N	\N
3458	Gabriel Monteiro	3516507	SP	2022-03-28	1	\N	\N	\N	\N
3459	Gália	3516606	SP	2022-03-28	1	\N	\N	\N	\N
3460	Garça	3516705	SP	2022-03-28	1	\N	\N	\N	\N
3461	Gastão Vidigal	3516804	SP	2022-03-28	1	\N	\N	\N	\N
3462	Gavião Peixoto	3516853	SP	2022-03-28	1	\N	\N	\N	\N
3463	General Salgado	3516903	SP	2022-03-28	1	\N	\N	\N	\N
3464	Getulina	3517000	SP	2022-03-28	1	\N	\N	\N	\N
3465	Glicério	3517109	SP	2022-03-28	1	\N	\N	\N	\N
3466	Guaiçara	3517208	SP	2022-03-28	1	\N	\N	\N	\N
3467	Guaimbê	3517307	SP	2022-03-28	1	\N	\N	\N	\N
3468	Guaíra	3517406	SP	2022-03-28	1	\N	\N	\N	\N
3469	Guapiaçu	3517505	SP	2022-03-28	1	\N	\N	\N	\N
3470	Guapiara	3517604	SP	2022-03-28	1	\N	\N	\N	\N
3471	Guará	3517703	SP	2022-03-28	1	\N	\N	\N	\N
3472	Guaraçaí	3517802	SP	2022-03-28	1	\N	\N	\N	\N
3473	Guaraci	3517901	SP	2022-03-28	1	\N	\N	\N	\N
3474	'Guarani d''Oeste'	3518008	SP	2022-03-28	1	\N	\N	\N	\N
3475	Guarantã	3518107	SP	2022-03-28	1	\N	\N	\N	\N
3476	Guararapes	3518206	SP	2022-03-28	1	\N	\N	\N	\N
3477	Guararema	3518305	SP	2022-03-28	1	\N	\N	\N	\N
3478	Guaratinguetá	3518404	SP	2022-03-28	1	\N	\N	\N	\N
3479	Guareí	3518503	SP	2022-03-28	1	\N	\N	\N	\N
3480	Guariba	3518602	SP	2022-03-28	1	\N	\N	\N	\N
3481	Guarujá	3518701	SP	2022-03-28	1	\N	\N	\N	\N
3482	Guarulhos	3518800	SP	2022-03-28	1	\N	\N	\N	\N
3483	Guatapará	3518859	SP	2022-03-28	1	\N	\N	\N	\N
3484	Guzolândia	3518909	SP	2022-03-28	1	\N	\N	\N	\N
3485	Herculândia	3519006	SP	2022-03-28	1	\N	\N	\N	\N
3486	Holambra	3519055	SP	2022-03-28	1	\N	\N	\N	\N
3487	Hortolândia	3519071	SP	2022-03-28	1	\N	\N	\N	\N
3488	Iacanga	3519105	SP	2022-03-28	1	\N	\N	\N	\N
3489	Iacri	3519204	SP	2022-03-28	1	\N	\N	\N	\N
3490	Iaras	3519253	SP	2022-03-28	1	\N	\N	\N	\N
3491	Ibaté	3519303	SP	2022-03-28	1	\N	\N	\N	\N
3492	Ibirá	3519402	SP	2022-03-28	1	\N	\N	\N	\N
3493	Ibirarema	3519501	SP	2022-03-28	1	\N	\N	\N	\N
3494	Ibitinga	3519600	SP	2022-03-28	1	\N	\N	\N	\N
3495	Ibiúna	3519709	SP	2022-03-28	1	\N	\N	\N	\N
3496	Icém	3519808	SP	2022-03-28	1	\N	\N	\N	\N
3497	Iepê	3519907	SP	2022-03-28	1	\N	\N	\N	\N
3498	Igaraçu do Tietê	3520004	SP	2022-03-28	1	\N	\N	\N	\N
3499	Igarapava	3520103	SP	2022-03-28	1	\N	\N	\N	\N
3500	Igaratá	3520202	SP	2022-03-28	1	\N	\N	\N	\N
3501	Iguape	3520301	SP	2022-03-28	1	\N	\N	\N	\N
3502	Ilha Comprida	3520426	SP	2022-03-28	1	\N	\N	\N	\N
3503	Ilha Solteira	3520442	SP	2022-03-28	1	\N	\N	\N	\N
3504	Ilhabela	3520400	SP	2022-03-28	1	\N	\N	\N	\N
3505	Indaiatuba	3520509	SP	2022-03-28	1	\N	\N	\N	\N
3506	Indiana	3520608	SP	2022-03-28	1	\N	\N	\N	\N
3507	Indiaporã	3520707	SP	2022-03-28	1	\N	\N	\N	\N
3508	Inúbia Paulista	3520806	SP	2022-03-28	1	\N	\N	\N	\N
3509	Ipaussu	3520905	SP	2022-03-28	1	\N	\N	\N	\N
3510	Iperó	3521002	SP	2022-03-28	1	\N	\N	\N	\N
3511	Ipeúna	3521101	SP	2022-03-28	1	\N	\N	\N	\N
3512	Ipiguá	3521150	SP	2022-03-28	1	\N	\N	\N	\N
3513	Iporanga	3521200	SP	2022-03-28	1	\N	\N	\N	\N
3514	Ipuã	3521309	SP	2022-03-28	1	\N	\N	\N	\N
3515	Iracemápolis	3521408	SP	2022-03-28	1	\N	\N	\N	\N
3516	Irapuã	3521507	SP	2022-03-28	1	\N	\N	\N	\N
3517	Irapuru	3521606	SP	2022-03-28	1	\N	\N	\N	\N
3518	Itaberá	3521705	SP	2022-03-28	1	\N	\N	\N	\N
3519	Itaí	3521804	SP	2022-03-28	1	\N	\N	\N	\N
3520	Itajobi	3521903	SP	2022-03-28	1	\N	\N	\N	\N
3521	Itaju	3522000	SP	2022-03-28	1	\N	\N	\N	\N
3522	Itanhaém	3522109	SP	2022-03-28	1	\N	\N	\N	\N
3523	Itaoca	3522158	SP	2022-03-28	1	\N	\N	\N	\N
3524	Itapecerica da Serra	3522208	SP	2022-03-28	1	\N	\N	\N	\N
3525	Itapetininga	3522307	SP	2022-03-28	1	\N	\N	\N	\N
3526	Itapeva	3522406	SP	2022-03-28	1	\N	\N	\N	\N
3527	Itapevi	3522505	SP	2022-03-28	1	\N	\N	\N	\N
3528	Itapira	3522604	SP	2022-03-28	1	\N	\N	\N	\N
3529	Itapirapuã Paulista	3522653	SP	2022-03-28	1	\N	\N	\N	\N
3530	Itápolis	3522703	SP	2022-03-28	1	\N	\N	\N	\N
3531	Itaporanga	3522802	SP	2022-03-28	1	\N	\N	\N	\N
3532	Itapuí	3522901	SP	2022-03-28	1	\N	\N	\N	\N
3533	Itapura	3523008	SP	2022-03-28	1	\N	\N	\N	\N
3534	Itaquaquecetuba	3523107	SP	2022-03-28	1	\N	\N	\N	\N
3535	Itararé	3523206	SP	2022-03-28	1	\N	\N	\N	\N
3536	Itariri	3523305	SP	2022-03-28	1	\N	\N	\N	\N
3537	Itatiba	3523404	SP	2022-03-28	1	\N	\N	\N	\N
3538	Itatinga	3523503	SP	2022-03-28	1	\N	\N	\N	\N
3539	Itirapina	3523602	SP	2022-03-28	1	\N	\N	\N	\N
3540	Itirapuã	3523701	SP	2022-03-28	1	\N	\N	\N	\N
3541	Itobi	3523800	SP	2022-03-28	1	\N	\N	\N	\N
3542	Itu	3523909	SP	2022-03-28	1	\N	\N	\N	\N
3543	Itupeva	3524006	SP	2022-03-28	1	\N	\N	\N	\N
3544	Ituverava	3524105	SP	2022-03-28	1	\N	\N	\N	\N
3545	Jaborandi	3524204	SP	2022-03-28	1	\N	\N	\N	\N
3546	Jaboticabal	3524303	SP	2022-03-28	1	\N	\N	\N	\N
3547	Jacareí	3524402	SP	2022-03-28	1	\N	\N	\N	\N
3548	Jaci	3524501	SP	2022-03-28	1	\N	\N	\N	\N
3549	Jacupiranga	3524600	SP	2022-03-28	1	\N	\N	\N	\N
3550	Jaguariúna	3524709	SP	2022-03-28	1	\N	\N	\N	\N
3551	Jales	3524808	SP	2022-03-28	1	\N	\N	\N	\N
3552	Jambeiro	3524907	SP	2022-03-28	1	\N	\N	\N	\N
3553	Jandira	3525003	SP	2022-03-28	1	\N	\N	\N	\N
3554	Jardinópolis	3525102	SP	2022-03-28	1	\N	\N	\N	\N
3555	Jarinu	3525201	SP	2022-03-28	1	\N	\N	\N	\N
3556	Jaú	3525300	SP	2022-03-28	1	\N	\N	\N	\N
3557	Jeriquara	3525409	SP	2022-03-28	1	\N	\N	\N	\N
3558	Joanópolis	3525508	SP	2022-03-28	1	\N	\N	\N	\N
3559	João Ramalho	3525607	SP	2022-03-28	1	\N	\N	\N	\N
3560	José Bonifácio	3525706	SP	2022-03-28	1	\N	\N	\N	\N
3561	Júlio Mesquita	3525805	SP	2022-03-28	1	\N	\N	\N	\N
3562	Jumirim	3525854	SP	2022-03-28	1	\N	\N	\N	\N
3563	Jundiaí	3525904	SP	2022-03-28	1	\N	\N	\N	\N
3564	Junqueirópolis	3526001	SP	2022-03-28	1	\N	\N	\N	\N
3565	Juquiá	3526100	SP	2022-03-28	1	\N	\N	\N	\N
3566	Juquitiba	3526209	SP	2022-03-28	1	\N	\N	\N	\N
3567	Lagoinha	3526308	SP	2022-03-28	1	\N	\N	\N	\N
3568	Laranjal Paulista	3526407	SP	2022-03-28	1	\N	\N	\N	\N
3569	Lavínia	3526506	SP	2022-03-28	1	\N	\N	\N	\N
3570	Lavrinhas	3526605	SP	2022-03-28	1	\N	\N	\N	\N
3571	Leme	3526704	SP	2022-03-28	1	\N	\N	\N	\N
3572	Lençóis Paulista	3526803	SP	2022-03-28	1	\N	\N	\N	\N
3573	Limeira	3526902	SP	2022-03-28	1	\N	\N	\N	\N
3574	Lindóia	3527009	SP	2022-03-28	1	\N	\N	\N	\N
3575	Lins	3527108	SP	2022-03-28	1	\N	\N	\N	\N
3576	Lorena	3527207	SP	2022-03-28	1	\N	\N	\N	\N
3577	Lourdes	3527256	SP	2022-03-28	1	\N	\N	\N	\N
3578	Louveira	3527306	SP	2022-03-28	1	\N	\N	\N	\N
3579	Lucélia	3527405	SP	2022-03-28	1	\N	\N	\N	\N
3580	Lucianópolis	3527504	SP	2022-03-28	1	\N	\N	\N	\N
3581	Luís Antônio	3527603	SP	2022-03-28	1	\N	\N	\N	\N
3582	Luiziânia	3527702	SP	2022-03-28	1	\N	\N	\N	\N
3583	Lupércio	3527801	SP	2022-03-28	1	\N	\N	\N	\N
3584	Lutécia	3527900	SP	2022-03-28	1	\N	\N	\N	\N
3585	Macatuba	3528007	SP	2022-03-28	1	\N	\N	\N	\N
3586	Macaubal	3528106	SP	2022-03-28	1	\N	\N	\N	\N
3587	Macedônia	3528205	SP	2022-03-28	1	\N	\N	\N	\N
3588	Magda	3528304	SP	2022-03-28	1	\N	\N	\N	\N
3589	Mairinque	3528403	SP	2022-03-28	1	\N	\N	\N	\N
3590	Mairiporã	3528502	SP	2022-03-28	1	\N	\N	\N	\N
3591	Manduri	3528601	SP	2022-03-28	1	\N	\N	\N	\N
3592	Marabá Paulista	3528700	SP	2022-03-28	1	\N	\N	\N	\N
3593	Maracaí	3528809	SP	2022-03-28	1	\N	\N	\N	\N
3594	Marapoama	3528858	SP	2022-03-28	1	\N	\N	\N	\N
3595	Mariápolis	3528908	SP	2022-03-28	1	\N	\N	\N	\N
3596	Marília	3529005	SP	2022-03-28	1	\N	\N	\N	\N
3597	Marinópolis	3529104	SP	2022-03-28	1	\N	\N	\N	\N
3598	Martinópolis	3529203	SP	2022-03-28	1	\N	\N	\N	\N
3599	Matão	3529302	SP	2022-03-28	1	\N	\N	\N	\N
3600	Mauá	3529401	SP	2022-03-28	1	\N	\N	\N	\N
3601	Mendonça	3529500	SP	2022-03-28	1	\N	\N	\N	\N
3602	Meridiano	3529609	SP	2022-03-28	1	\N	\N	\N	\N
3603	Mesópolis	3529658	SP	2022-03-28	1	\N	\N	\N	\N
3604	Miguelópolis	3529708	SP	2022-03-28	1	\N	\N	\N	\N
3605	Mineiros do Tietê	3529807	SP	2022-03-28	1	\N	\N	\N	\N
3606	Mira Estrela	3530003	SP	2022-03-28	1	\N	\N	\N	\N
3607	Miracatu	3529906	SP	2022-03-28	1	\N	\N	\N	\N
3608	Mirandópolis	3530102	SP	2022-03-28	1	\N	\N	\N	\N
3609	Mirante do Paranapanema	3530201	SP	2022-03-28	1	\N	\N	\N	\N
3610	Mirassol	3530300	SP	2022-03-28	1	\N	\N	\N	\N
3611	Mirassolândia	3530409	SP	2022-03-28	1	\N	\N	\N	\N
3612	Mococa	3530508	SP	2022-03-28	1	\N	\N	\N	\N
3613	Mogi das Cruzes	3530607	SP	2022-03-28	1	\N	\N	\N	\N
3614	Mogi Guaçu	3530706	SP	2022-03-28	1	\N	\N	\N	\N
3615	Mogi Mirim	3530805	SP	2022-03-28	1	\N	\N	\N	\N
3616	Mombuca	3530904	SP	2022-03-28	1	\N	\N	\N	\N
3617	Monções	3531001	SP	2022-03-28	1	\N	\N	\N	\N
3618	Mongaguá	3531100	SP	2022-03-28	1	\N	\N	\N	\N
3619	Monte Alegre do Sul	3531209	SP	2022-03-28	1	\N	\N	\N	\N
3620	Monte Alto	3531308	SP	2022-03-28	1	\N	\N	\N	\N
3621	Monte Aprazível	3531407	SP	2022-03-28	1	\N	\N	\N	\N
3622	Monte Azul Paulista	3531506	SP	2022-03-28	1	\N	\N	\N	\N
3623	Monte Castelo	3531605	SP	2022-03-28	1	\N	\N	\N	\N
3624	Monte Mor	3531803	SP	2022-03-28	1	\N	\N	\N	\N
3625	Monteiro Lobato	3531704	SP	2022-03-28	1	\N	\N	\N	\N
3626	Morro Agudo	3531902	SP	2022-03-28	1	\N	\N	\N	\N
3627	Morungaba	3532009	SP	2022-03-28	1	\N	\N	\N	\N
3628	Motuca	3532058	SP	2022-03-28	1	\N	\N	\N	\N
3629	Murutinga do Sul	3532108	SP	2022-03-28	1	\N	\N	\N	\N
3630	Nantes	3532157	SP	2022-03-28	1	\N	\N	\N	\N
3631	Narandiba	3532207	SP	2022-03-28	1	\N	\N	\N	\N
3632	Natividade da Serra	3532306	SP	2022-03-28	1	\N	\N	\N	\N
3633	Nazaré Paulista	3532405	SP	2022-03-28	1	\N	\N	\N	\N
3634	Neves Paulista	3532504	SP	2022-03-28	1	\N	\N	\N	\N
3635	Nhandeara	3532603	SP	2022-03-28	1	\N	\N	\N	\N
3636	Nipoã	3532702	SP	2022-03-28	1	\N	\N	\N	\N
3637	Nova Aliança	3532801	SP	2022-03-28	1	\N	\N	\N	\N
3638	Nova Campina	3532827	SP	2022-03-28	1	\N	\N	\N	\N
3639	Nova Canaã Paulista	3532843	SP	2022-03-28	1	\N	\N	\N	\N
3640	Nova Castilho	3532868	SP	2022-03-28	1	\N	\N	\N	\N
3641	Nova Europa	3532900	SP	2022-03-28	1	\N	\N	\N	\N
3642	Nova Granada	3533007	SP	2022-03-28	1	\N	\N	\N	\N
3643	Nova Guataporanga	3533106	SP	2022-03-28	1	\N	\N	\N	\N
3644	Nova Independência	3533205	SP	2022-03-28	1	\N	\N	\N	\N
3645	Nova Luzitânia	3533304	SP	2022-03-28	1	\N	\N	\N	\N
3646	Nova Odessa	3533403	SP	2022-03-28	1	\N	\N	\N	\N
3647	Novais	3533254	SP	2022-03-28	1	\N	\N	\N	\N
3648	Novo Horizonte	3533502	SP	2022-03-28	1	\N	\N	\N	\N
3649	Nuporanga	3533601	SP	2022-03-28	1	\N	\N	\N	\N
3650	Ocauçu	3533700	SP	2022-03-28	1	\N	\N	\N	\N
3651	Óleo	3533809	SP	2022-03-28	1	\N	\N	\N	\N
3652	Olímpia	3533908	SP	2022-03-28	1	\N	\N	\N	\N
3653	Onda Verde	3534005	SP	2022-03-28	1	\N	\N	\N	\N
3654	Oriente	3534104	SP	2022-03-28	1	\N	\N	\N	\N
3655	Orindiúva	3534203	SP	2022-03-28	1	\N	\N	\N	\N
3656	Orlândia	3534302	SP	2022-03-28	1	\N	\N	\N	\N
3657	Osasco	3534401	SP	2022-03-28	1	\N	\N	\N	\N
3658	Oscar Bressane	3534500	SP	2022-03-28	1	\N	\N	\N	\N
3659	Osvaldo Cruz	3534609	SP	2022-03-28	1	\N	\N	\N	\N
3660	Ourinhos	3534708	SP	2022-03-28	1	\N	\N	\N	\N
3661	Ouro Verde	3534807	SP	2022-03-28	1	\N	\N	\N	\N
3662	Ouroeste	3534757	SP	2022-03-28	1	\N	\N	\N	\N
3663	Pacaembu	3534906	SP	2022-03-28	1	\N	\N	\N	\N
3664	Palestina	3535002	SP	2022-03-28	1	\N	\N	\N	\N
3665	Palmares Paulista	3535101	SP	2022-03-28	1	\N	\N	\N	\N
3666	'Palmeira d''Oeste'	3535200	SP	2022-03-28	1	\N	\N	\N	\N
3667	Palmital	3535309	SP	2022-03-28	1	\N	\N	\N	\N
3668	Panorama	3535408	SP	2022-03-28	1	\N	\N	\N	\N
3669	Paraguaçu Paulista	3535507	SP	2022-03-28	1	\N	\N	\N	\N
3670	Paraibuna	3535606	SP	2022-03-28	1	\N	\N	\N	\N
3671	Paraíso	3535705	SP	2022-03-28	1	\N	\N	\N	\N
3672	Paranapanema	3535804	SP	2022-03-28	1	\N	\N	\N	\N
3673	Paranapuã	3535903	SP	2022-03-28	1	\N	\N	\N	\N
3674	Parapuã	3536000	SP	2022-03-28	1	\N	\N	\N	\N
3675	Pardinho	3536109	SP	2022-03-28	1	\N	\N	\N	\N
3676	Pariquera-Açu	3536208	SP	2022-03-28	1	\N	\N	\N	\N
3677	Parisi	3536257	SP	2022-03-28	1	\N	\N	\N	\N
3678	Patrocínio Paulista	3536307	SP	2022-03-28	1	\N	\N	\N	\N
3679	Paulicéia	3536406	SP	2022-03-28	1	\N	\N	\N	\N
3680	Paulínia	3536505	SP	2022-03-28	1	\N	\N	\N	\N
3681	Paulistânia	3536570	SP	2022-03-28	1	\N	\N	\N	\N
3682	Paulo de Faria	3536604	SP	2022-03-28	1	\N	\N	\N	\N
3683	Pederneiras	3536703	SP	2022-03-28	1	\N	\N	\N	\N
3684	Pedra Bela	3536802	SP	2022-03-28	1	\N	\N	\N	\N
3685	Pedranópolis	3536901	SP	2022-03-28	1	\N	\N	\N	\N
3686	Pedregulho	3537008	SP	2022-03-28	1	\N	\N	\N	\N
3687	Pedreira	3537107	SP	2022-03-28	1	\N	\N	\N	\N
3688	Pedrinhas Paulista	3537156	SP	2022-03-28	1	\N	\N	\N	\N
3689	Pedro de Toledo	3537206	SP	2022-03-28	1	\N	\N	\N	\N
3690	Penápolis	3537305	SP	2022-03-28	1	\N	\N	\N	\N
3691	Pereira Barreto	3537404	SP	2022-03-28	1	\N	\N	\N	\N
3692	Pereiras	3537503	SP	2022-03-28	1	\N	\N	\N	\N
3693	Peruíbe	3537602	SP	2022-03-28	1	\N	\N	\N	\N
3694	Piacatu	3537701	SP	2022-03-28	1	\N	\N	\N	\N
3695	Piedade	3537800	SP	2022-03-28	1	\N	\N	\N	\N
3696	Pilar do Sul	3537909	SP	2022-03-28	1	\N	\N	\N	\N
3697	Pindamonhangaba	3538006	SP	2022-03-28	1	\N	\N	\N	\N
3698	Pindorama	3538105	SP	2022-03-28	1	\N	\N	\N	\N
3699	Pinhalzinho	3538204	SP	2022-03-28	1	\N	\N	\N	\N
3700	Piquerobi	3538303	SP	2022-03-28	1	\N	\N	\N	\N
3701	Piquete	3538501	SP	2022-03-28	1	\N	\N	\N	\N
3702	Piracaia	3538600	SP	2022-03-28	1	\N	\N	\N	\N
3703	Piracicaba	3538709	SP	2022-03-28	1	\N	\N	\N	\N
3704	Piraju	3538808	SP	2022-03-28	1	\N	\N	\N	\N
3705	Pirajuí	3538907	SP	2022-03-28	1	\N	\N	\N	\N
3706	Pirangi	3539004	SP	2022-03-28	1	\N	\N	\N	\N
3707	Pirapora do Bom Jesus	3539103	SP	2022-03-28	1	\N	\N	\N	\N
3708	Pirapozinho	3539202	SP	2022-03-28	1	\N	\N	\N	\N
3709	Pirassununga	3539301	SP	2022-03-28	1	\N	\N	\N	\N
3710	Piratininga	3539400	SP	2022-03-28	1	\N	\N	\N	\N
3711	Pitangueiras	3539509	SP	2022-03-28	1	\N	\N	\N	\N
3712	Planalto	3539608	SP	2022-03-28	1	\N	\N	\N	\N
3713	Platina	3539707	SP	2022-03-28	1	\N	\N	\N	\N
3714	Poá	3539806	SP	2022-03-28	1	\N	\N	\N	\N
3715	Poloni	3539905	SP	2022-03-28	1	\N	\N	\N	\N
3716	Pompéia	3540002	SP	2022-03-28	1	\N	\N	\N	\N
3717	Pongaí	3540101	SP	2022-03-28	1	\N	\N	\N	\N
3718	Pontal	3540200	SP	2022-03-28	1	\N	\N	\N	\N
3719	Pontalinda	3540259	SP	2022-03-28	1	\N	\N	\N	\N
3720	Pontes Gestal	3540309	SP	2022-03-28	1	\N	\N	\N	\N
3721	Populina	3540408	SP	2022-03-28	1	\N	\N	\N	\N
3722	Porangaba	3540507	SP	2022-03-28	1	\N	\N	\N	\N
3723	Porto Feliz	3540606	SP	2022-03-28	1	\N	\N	\N	\N
3724	Porto Ferreira	3540705	SP	2022-03-28	1	\N	\N	\N	\N
3725	Potim	3540754	SP	2022-03-28	1	\N	\N	\N	\N
3726	Potirendaba	3540804	SP	2022-03-28	1	\N	\N	\N	\N
3727	Pracinha	3540853	SP	2022-03-28	1	\N	\N	\N	\N
3728	Pradópolis	3540903	SP	2022-03-28	1	\N	\N	\N	\N
3729	Praia Grande	3541000	SP	2022-03-28	1	\N	\N	\N	\N
3730	Pratânia	3541059	SP	2022-03-28	1	\N	\N	\N	\N
3731	Presidente Alves	3541109	SP	2022-03-28	1	\N	\N	\N	\N
3732	Presidente Bernardes	3541208	SP	2022-03-28	1	\N	\N	\N	\N
3733	Presidente Epitácio	3541307	SP	2022-03-28	1	\N	\N	\N	\N
3734	Presidente Prudente	3541406	SP	2022-03-28	1	\N	\N	\N	\N
3735	Presidente Venceslau	3541505	SP	2022-03-28	1	\N	\N	\N	\N
3736	Promissão	3541604	SP	2022-03-28	1	\N	\N	\N	\N
3737	Quadra	3541653	SP	2022-03-28	1	\N	\N	\N	\N
3738	Quatá	3541703	SP	2022-03-28	1	\N	\N	\N	\N
3739	Queiroz	3541802	SP	2022-03-28	1	\N	\N	\N	\N
3740	Queluz	3541901	SP	2022-03-28	1	\N	\N	\N	\N
3741	Quintana	3542008	SP	2022-03-28	1	\N	\N	\N	\N
3742	Rafard	3542107	SP	2022-03-28	1	\N	\N	\N	\N
3743	Rancharia	3542206	SP	2022-03-28	1	\N	\N	\N	\N
3744	Redenção da Serra	3542305	SP	2022-03-28	1	\N	\N	\N	\N
3745	Regente Feijó	3542404	SP	2022-03-28	1	\N	\N	\N	\N
3746	Reginópolis	3542503	SP	2022-03-28	1	\N	\N	\N	\N
3747	Registro	3542602	SP	2022-03-28	1	\N	\N	\N	\N
3748	Restinga	3542701	SP	2022-03-28	1	\N	\N	\N	\N
3749	Ribeira	3542800	SP	2022-03-28	1	\N	\N	\N	\N
3750	Ribeirão Bonito	3542909	SP	2022-03-28	1	\N	\N	\N	\N
3751	Ribeirão Branco	3543006	SP	2022-03-28	1	\N	\N	\N	\N
3752	Ribeirão Corrente	3543105	SP	2022-03-28	1	\N	\N	\N	\N
3753	Ribeirão do Sul	3543204	SP	2022-03-28	1	\N	\N	\N	\N
3754	Ribeirão dos Índios	3543238	SP	2022-03-28	1	\N	\N	\N	\N
3755	Ribeirão Grande	3543253	SP	2022-03-28	1	\N	\N	\N	\N
3756	Ribeirão Pires	3543303	SP	2022-03-28	1	\N	\N	\N	\N
3757	Ribeirão Preto	3543402	SP	2022-03-28	1	\N	\N	\N	\N
3758	Rifaina	3543600	SP	2022-03-28	1	\N	\N	\N	\N
3759	Rincão	3543709	SP	2022-03-28	1	\N	\N	\N	\N
3760	Rinópolis	3543808	SP	2022-03-28	1	\N	\N	\N	\N
3761	Rio Claro	3543907	SP	2022-03-28	1	\N	\N	\N	\N
3762	Rio das Pedras	3544004	SP	2022-03-28	1	\N	\N	\N	\N
3763	Rio Grande da Serra	3544103	SP	2022-03-28	1	\N	\N	\N	\N
3764	Riolândia	3544202	SP	2022-03-28	1	\N	\N	\N	\N
3765	Riversul	3543501	SP	2022-03-28	1	\N	\N	\N	\N
3766	Rosana	3544251	SP	2022-03-28	1	\N	\N	\N	\N
3767	Roseira	3544301	SP	2022-03-28	1	\N	\N	\N	\N
3768	Rubiácea	3544400	SP	2022-03-28	1	\N	\N	\N	\N
3769	Rubinéia	3544509	SP	2022-03-28	1	\N	\N	\N	\N
3770	Sabino	3544608	SP	2022-03-28	1	\N	\N	\N	\N
3771	Sagres	3544707	SP	2022-03-28	1	\N	\N	\N	\N
3772	Sales	3544806	SP	2022-03-28	1	\N	\N	\N	\N
3773	Sales Oliveira	3544905	SP	2022-03-28	1	\N	\N	\N	\N
3774	Salesópolis	3545001	SP	2022-03-28	1	\N	\N	\N	\N
3775	Salmourão	3545100	SP	2022-03-28	1	\N	\N	\N	\N
3776	Saltinho	3545159	SP	2022-03-28	1	\N	\N	\N	\N
3777	Salto	3545209	SP	2022-03-28	1	\N	\N	\N	\N
3778	Salto de Pirapora	3545308	SP	2022-03-28	1	\N	\N	\N	\N
3779	Salto Grande	3545407	SP	2022-03-28	1	\N	\N	\N	\N
3780	Sandovalina	3545506	SP	2022-03-28	1	\N	\N	\N	\N
3781	Santa Adélia	3545605	SP	2022-03-28	1	\N	\N	\N	\N
3782	Santa Albertina	3545704	SP	2022-03-28	1	\N	\N	\N	\N
3783	'Santa Bárbara d''Oeste'	3545803	SP	2022-03-28	1	\N	\N	\N	\N
3784	Santa Branca	3546009	SP	2022-03-28	1	\N	\N	\N	\N
3785	'Santa Clara d''Oeste'	3546108	SP	2022-03-28	1	\N	\N	\N	\N
3786	Santa Cruz da Conceição	3546207	SP	2022-03-28	1	\N	\N	\N	\N
3787	Santa Cruz da Esperança	3546256	SP	2022-03-28	1	\N	\N	\N	\N
3788	Santa Cruz das Palmeiras	3546306	SP	2022-03-28	1	\N	\N	\N	\N
3789	Santa Cruz do Rio Pardo	3546405	SP	2022-03-28	1	\N	\N	\N	\N
3790	Santa Ernestina	3546504	SP	2022-03-28	1	\N	\N	\N	\N
3791	Santa Fé do Sul	3546603	SP	2022-03-28	1	\N	\N	\N	\N
3792	Santa Gertrudes	3546702	SP	2022-03-28	1	\N	\N	\N	\N
3793	Santa Isabel	3546801	SP	2022-03-28	1	\N	\N	\N	\N
3794	Santa Lúcia	3546900	SP	2022-03-28	1	\N	\N	\N	\N
3795	Santa Maria da Serra	3547007	SP	2022-03-28	1	\N	\N	\N	\N
3796	Santa Mercedes	3547106	SP	2022-03-28	1	\N	\N	\N	\N
3797	Santa Rita do Passa Quatro	3547502	SP	2022-03-28	1	\N	\N	\N	\N
3798	'Santa Rita d''Oeste'	3547403	SP	2022-03-28	1	\N	\N	\N	\N
3799	Santa Rosa de Viterbo	3547601	SP	2022-03-28	1	\N	\N	\N	\N
3800	Santa Salete	3547650	SP	2022-03-28	1	\N	\N	\N	\N
3801	Santana da Ponte Pensa	3547205	SP	2022-03-28	1	\N	\N	\N	\N
3802	Santana de Parnaíba	3547304	SP	2022-03-28	1	\N	\N	\N	\N
3803	Santo Anastácio	3547700	SP	2022-03-28	1	\N	\N	\N	\N
3804	Santo André	3547809	SP	2022-03-28	1	\N	\N	\N	\N
3805	Santo Antônio da Alegria	3547908	SP	2022-03-28	1	\N	\N	\N	\N
3806	Santo Antônio de Posse	3548005	SP	2022-03-28	1	\N	\N	\N	\N
3807	Santo Antônio do Aracanguá	3548054	SP	2022-03-28	1	\N	\N	\N	\N
3808	Santo Antônio do Jardim	3548104	SP	2022-03-28	1	\N	\N	\N	\N
3809	Santo Antônio do Pinhal	3548203	SP	2022-03-28	1	\N	\N	\N	\N
3810	Santo Expedito	3548302	SP	2022-03-28	1	\N	\N	\N	\N
3811	Santópolis do Aguapeí	3548401	SP	2022-03-28	1	\N	\N	\N	\N
3812	Santos	3548500	SP	2022-03-28	1	\N	\N	\N	\N
3813	São Bento do Sapucaí	3548609	SP	2022-03-28	1	\N	\N	\N	\N
3814	São Bernardo do Campo	3548708	SP	2022-03-28	1	\N	\N	\N	\N
3815	São Caetano do Sul	3548807	SP	2022-03-28	1	\N	\N	\N	\N
3816	São Carlos	3548906	SP	2022-03-28	1	\N	\N	\N	\N
3817	São Francisco	3549003	SP	2022-03-28	1	\N	\N	\N	\N
3818	São João da Boa Vista	3549102	SP	2022-03-28	1	\N	\N	\N	\N
3819	São João das Duas Pontes	3549201	SP	2022-03-28	1	\N	\N	\N	\N
3820	São João de Iracema	3549250	SP	2022-03-28	1	\N	\N	\N	\N
3821	'São João do Pau d''Alho'	3549300	SP	2022-03-28	1	\N	\N	\N	\N
3822	São Joaquim da Barra	3549409	SP	2022-03-28	1	\N	\N	\N	\N
3823	São José da Bela Vista	3549508	SP	2022-03-28	1	\N	\N	\N	\N
3824	São José do Barreiro	3549607	SP	2022-03-28	1	\N	\N	\N	\N
3825	São José do Rio Pardo	3549706	SP	2022-03-28	1	\N	\N	\N	\N
3826	São José do Rio Preto	3549805	SP	2022-03-28	1	\N	\N	\N	\N
3827	São José dos Campos	3549904	SP	2022-03-28	1	\N	\N	\N	\N
3828	São Lourenço da Serra	3549953	SP	2022-03-28	1	\N	\N	\N	\N
3829	São Luiz do Paraitinga	3550001	SP	2022-03-28	1	\N	\N	\N	\N
3830	São Manuel	3550100	SP	2022-03-28	1	\N	\N	\N	\N
3831	São Miguel Arcanjo	3550209	SP	2022-03-28	1	\N	\N	\N	\N
3832	São Paulo	3550308	SP	2022-03-28	1	\N	\N	\N	\N
3833	São Pedro	3550407	SP	2022-03-28	1	\N	\N	\N	\N
3834	São Pedro do Turvo	3550506	SP	2022-03-28	1	\N	\N	\N	\N
3835	São Roque	3550605	SP	2022-03-28	1	\N	\N	\N	\N
3836	São Sebastião	3550704	SP	2022-03-28	1	\N	\N	\N	\N
3837	São Sebastião da Grama	3550803	SP	2022-03-28	1	\N	\N	\N	\N
3838	São Simão	3550902	SP	2022-03-28	1	\N	\N	\N	\N
3839	São Vicente	3551009	SP	2022-03-28	1	\N	\N	\N	\N
3840	Sarapuí	3551108	SP	2022-03-28	1	\N	\N	\N	\N
3841	Sarutaiá	3551207	SP	2022-03-28	1	\N	\N	\N	\N
3842	Sebastianópolis do Sul	3551306	SP	2022-03-28	1	\N	\N	\N	\N
3843	Serra Azul	3551405	SP	2022-03-28	1	\N	\N	\N	\N
3844	Serra Negra	3551603	SP	2022-03-28	1	\N	\N	\N	\N
3845	Serrana	3551504	SP	2022-03-28	1	\N	\N	\N	\N
3846	Sertãozinho	3551702	SP	2022-03-28	1	\N	\N	\N	\N
3847	Sete Barras	3551801	SP	2022-03-28	1	\N	\N	\N	\N
3848	Severínia	3551900	SP	2022-03-28	1	\N	\N	\N	\N
3849	Silveiras	3552007	SP	2022-03-28	1	\N	\N	\N	\N
3850	Socorro	3552106	SP	2022-03-28	1	\N	\N	\N	\N
3851	Sorocaba	3552205	SP	2022-03-28	1	\N	\N	\N	\N
3852	Sud Mennucci	3552304	SP	2022-03-28	1	\N	\N	\N	\N
3853	Sumaré	3552403	SP	2022-03-28	1	\N	\N	\N	\N
3854	Suzanápolis	3552551	SP	2022-03-28	1	\N	\N	\N	\N
3855	Suzano	3552502	SP	2022-03-28	1	\N	\N	\N	\N
3856	Tabapuã	3552601	SP	2022-03-28	1	\N	\N	\N	\N
3857	Tabatinga	3552700	SP	2022-03-28	1	\N	\N	\N	\N
3858	Taboão da Serra	3552809	SP	2022-03-28	1	\N	\N	\N	\N
3859	Taciba	3552908	SP	2022-03-28	1	\N	\N	\N	\N
3860	Taguaí	3553005	SP	2022-03-28	1	\N	\N	\N	\N
3861	Taiaçu	3553104	SP	2022-03-28	1	\N	\N	\N	\N
3862	Taiúva	3553203	SP	2022-03-28	1	\N	\N	\N	\N
3863	Tambaú	3553302	SP	2022-03-28	1	\N	\N	\N	\N
3864	Tanabi	3553401	SP	2022-03-28	1	\N	\N	\N	\N
3865	Tapiraí	3553500	SP	2022-03-28	1	\N	\N	\N	\N
3866	Tapiratiba	3553609	SP	2022-03-28	1	\N	\N	\N	\N
3867	Taquaral	3553658	SP	2022-03-28	1	\N	\N	\N	\N
3868	Taquaritinga	3553708	SP	2022-03-28	1	\N	\N	\N	\N
3869	Taquarituba	3553807	SP	2022-03-28	1	\N	\N	\N	\N
3870	Taquarivaí	3553856	SP	2022-03-28	1	\N	\N	\N	\N
3871	Tarabai	3553906	SP	2022-03-28	1	\N	\N	\N	\N
3872	Tarumã	3553955	SP	2022-03-28	1	\N	\N	\N	\N
3873	Tatuí	3554003	SP	2022-03-28	1	\N	\N	\N	\N
3874	Taubaté	3554102	SP	2022-03-28	1	\N	\N	\N	\N
3875	Tejupá	3554201	SP	2022-03-28	1	\N	\N	\N	\N
3876	Teodoro Sampaio	3554300	SP	2022-03-28	1	\N	\N	\N	\N
3877	Terra Roxa	3554409	SP	2022-03-28	1	\N	\N	\N	\N
3878	Tietê	3554508	SP	2022-03-28	1	\N	\N	\N	\N
3879	Timburi	3554607	SP	2022-03-28	1	\N	\N	\N	\N
3880	Torre de Pedra	3554656	SP	2022-03-28	1	\N	\N	\N	\N
3881	Torrinha	3554706	SP	2022-03-28	1	\N	\N	\N	\N
3882	Trabiju	3554755	SP	2022-03-28	1	\N	\N	\N	\N
3883	Tremembé	3554805	SP	2022-03-28	1	\N	\N	\N	\N
3884	Três Fronteiras	3554904	SP	2022-03-28	1	\N	\N	\N	\N
3885	Tuiuti	3554953	SP	2022-03-28	1	\N	\N	\N	\N
3886	Tupã	3555000	SP	2022-03-28	1	\N	\N	\N	\N
3887	Tupi Paulista	3555109	SP	2022-03-28	1	\N	\N	\N	\N
3888	Turiúba	3555208	SP	2022-03-28	1	\N	\N	\N	\N
3889	Turmalina	3555307	SP	2022-03-28	1	\N	\N	\N	\N
3890	Ubarana	3555356	SP	2022-03-28	1	\N	\N	\N	\N
3891	Ubatuba	3555406	SP	2022-03-28	1	\N	\N	\N	\N
3892	Ubirajara	3555505	SP	2022-03-28	1	\N	\N	\N	\N
3893	Uchoa	3555604	SP	2022-03-28	1	\N	\N	\N	\N
3894	União Paulista	3555703	SP	2022-03-28	1	\N	\N	\N	\N
3895	Urânia	3555802	SP	2022-03-28	1	\N	\N	\N	\N
3896	Uru	3555901	SP	2022-03-28	1	\N	\N	\N	\N
3897	Urupês	3556008	SP	2022-03-28	1	\N	\N	\N	\N
3898	Valentim Gentil	3556107	SP	2022-03-28	1	\N	\N	\N	\N
3899	Valinhos	3556206	SP	2022-03-28	1	\N	\N	\N	\N
3900	Valparaíso	3556305	SP	2022-03-28	1	\N	\N	\N	\N
3901	Vargem	3556354	SP	2022-03-28	1	\N	\N	\N	\N
3902	Vargem Grande do Sul	3556404	SP	2022-03-28	1	\N	\N	\N	\N
3903	Vargem Grande Paulista	3556453	SP	2022-03-28	1	\N	\N	\N	\N
3904	Várzea Paulista	3556503	SP	2022-03-28	1	\N	\N	\N	\N
3905	Vera Cruz	3556602	SP	2022-03-28	1	\N	\N	\N	\N
3906	Vinhedo	3556701	SP	2022-03-28	1	\N	\N	\N	\N
3907	Viradouro	3556800	SP	2022-03-28	1	\N	\N	\N	\N
3908	Vista Alegre do Alto	3556909	SP	2022-03-28	1	\N	\N	\N	\N
3909	Vitória Brasil	3556958	SP	2022-03-28	1	\N	\N	\N	\N
3910	Votorantim	3557006	SP	2022-03-28	1	\N	\N	\N	\N
3911	Votuporanga	3557105	SP	2022-03-28	1	\N	\N	\N	\N
3912	Zacarias	3557154	SP	2022-03-28	1	\N	\N	\N	\N
3913	Abatiá	4100103	PR	2022-03-28	1	\N	\N	\N	\N
3914	Adrianópolis	4100202	PR	2022-03-28	1	\N	\N	\N	\N
3915	Agudos do Sul	4100301	PR	2022-03-28	1	\N	\N	\N	\N
3916	Almirante Tamandaré	4100400	PR	2022-03-28	1	\N	\N	\N	\N
3917	Altamira do Paraná	4100459	PR	2022-03-28	1	\N	\N	\N	\N
3918	Alto Paraíso	4128625	PR	2022-03-28	1	\N	\N	\N	\N
3919	Alto Paraná	4100608	PR	2022-03-28	1	\N	\N	\N	\N
3920	Alto Piquiri	4100707	PR	2022-03-28	1	\N	\N	\N	\N
3921	Altônia	4100509	PR	2022-03-28	1	\N	\N	\N	\N
3922	Alvorada do Sul	4100806	PR	2022-03-28	1	\N	\N	\N	\N
3923	Amaporã	4100905	PR	2022-03-28	1	\N	\N	\N	\N
3924	Ampére	4101002	PR	2022-03-28	1	\N	\N	\N	\N
3925	Anahy	4101051	PR	2022-03-28	1	\N	\N	\N	\N
3926	Andirá	4101101	PR	2022-03-28	1	\N	\N	\N	\N
3927	Ângulo	4101150	PR	2022-03-28	1	\N	\N	\N	\N
3928	Antonina	4101200	PR	2022-03-28	1	\N	\N	\N	\N
3929	Antônio Olinto	4101309	PR	2022-03-28	1	\N	\N	\N	\N
3930	Apucarana	4101408	PR	2022-03-28	1	\N	\N	\N	\N
3931	Arapongas	4101507	PR	2022-03-28	1	\N	\N	\N	\N
3932	Arapoti	4101606	PR	2022-03-28	1	\N	\N	\N	\N
3933	Arapuã	4101655	PR	2022-03-28	1	\N	\N	\N	\N
3934	Araruna	4101705	PR	2022-03-28	1	\N	\N	\N	\N
3935	Araucária	4101804	PR	2022-03-28	1	\N	\N	\N	\N
3936	Ariranha do Ivaí	4101853	PR	2022-03-28	1	\N	\N	\N	\N
3937	Assaí	4101903	PR	2022-03-28	1	\N	\N	\N	\N
3938	Assis Chateaubriand	4102000	PR	2022-03-28	1	\N	\N	\N	\N
3939	Astorga	4102109	PR	2022-03-28	1	\N	\N	\N	\N
3940	Atalaia	4102208	PR	2022-03-28	1	\N	\N	\N	\N
3941	Balsa Nova	4102307	PR	2022-03-28	1	\N	\N	\N	\N
3942	Bandeirantes	4102406	PR	2022-03-28	1	\N	\N	\N	\N
3943	Barbosa Ferraz	4102505	PR	2022-03-28	1	\N	\N	\N	\N
3944	Barra do Jacaré	4102703	PR	2022-03-28	1	\N	\N	\N	\N
3945	Barracão	4102604	PR	2022-03-28	1	\N	\N	\N	\N
3946	Bela Vista da Caroba	4102752	PR	2022-03-28	1	\N	\N	\N	\N
3947	Bela Vista do Paraíso	4102802	PR	2022-03-28	1	\N	\N	\N	\N
3948	Bituruna	4102901	PR	2022-03-28	1	\N	\N	\N	\N
3949	Boa Esperança	4103008	PR	2022-03-28	1	\N	\N	\N	\N
3950	Boa Esperança do Iguaçu	4103024	PR	2022-03-28	1	\N	\N	\N	\N
3951	Boa Ventura de São Roque	4103040	PR	2022-03-28	1	\N	\N	\N	\N
3952	Boa Vista da Aparecida	4103057	PR	2022-03-28	1	\N	\N	\N	\N
3953	Bocaiúva do Sul	4103107	PR	2022-03-28	1	\N	\N	\N	\N
3954	Bom Jesus do Sul	4103156	PR	2022-03-28	1	\N	\N	\N	\N
3955	Bom Sucesso	4103206	PR	2022-03-28	1	\N	\N	\N	\N
3956	Bom Sucesso do Sul	4103222	PR	2022-03-28	1	\N	\N	\N	\N
3957	Borrazópolis	4103305	PR	2022-03-28	1	\N	\N	\N	\N
3958	Braganey	4103354	PR	2022-03-28	1	\N	\N	\N	\N
3959	Brasilândia do Sul	4103370	PR	2022-03-28	1	\N	\N	\N	\N
3960	Cafeara	4103404	PR	2022-03-28	1	\N	\N	\N	\N
3961	Cafelândia	4103453	PR	2022-03-28	1	\N	\N	\N	\N
3962	Cafezal do Sul	4103479	PR	2022-03-28	1	\N	\N	\N	\N
3963	Califórnia	4103503	PR	2022-03-28	1	\N	\N	\N	\N
3964	Cambará	4103602	PR	2022-03-28	1	\N	\N	\N	\N
3965	Cambé	4103701	PR	2022-03-28	1	\N	\N	\N	\N
3966	Cambira	4103800	PR	2022-03-28	1	\N	\N	\N	\N
3967	Campina da Lagoa	4103909	PR	2022-03-28	1	\N	\N	\N	\N
3968	Campina do Simão	4103958	PR	2022-03-28	1	\N	\N	\N	\N
3969	Campina Grande do Sul	4104006	PR	2022-03-28	1	\N	\N	\N	\N
3970	Campo Bonito	4104055	PR	2022-03-28	1	\N	\N	\N	\N
3971	Campo do Tenente	4104105	PR	2022-03-28	1	\N	\N	\N	\N
3972	Campo Largo	4104204	PR	2022-03-28	1	\N	\N	\N	\N
3973	Campo Magro	4104253	PR	2022-03-28	1	\N	\N	\N	\N
3974	Campo Mourão	4104303	PR	2022-03-28	1	\N	\N	\N	\N
3975	Cândido de Abreu	4104402	PR	2022-03-28	1	\N	\N	\N	\N
3976	Candói	4104428	PR	2022-03-28	1	\N	\N	\N	\N
3977	Cantagalo	4104451	PR	2022-03-28	1	\N	\N	\N	\N
3978	Capanema	4104501	PR	2022-03-28	1	\N	\N	\N	\N
3979	Capitão Leônidas Marques	4104600	PR	2022-03-28	1	\N	\N	\N	\N
3980	Carambeí	4104659	PR	2022-03-28	1	\N	\N	\N	\N
3981	Carlópolis	4104709	PR	2022-03-28	1	\N	\N	\N	\N
3982	Cascavel	4104808	PR	2022-03-28	1	\N	\N	\N	\N
3983	Castro	4104907	PR	2022-03-28	1	\N	\N	\N	\N
3984	Catanduvas	4105003	PR	2022-03-28	1	\N	\N	\N	\N
3985	Centenário do Sul	4105102	PR	2022-03-28	1	\N	\N	\N	\N
3986	Cerro Azul	4105201	PR	2022-03-28	1	\N	\N	\N	\N
3987	Céu Azul	4105300	PR	2022-03-28	1	\N	\N	\N	\N
3988	Chopinzinho	4105409	PR	2022-03-28	1	\N	\N	\N	\N
3989	Cianorte	4105508	PR	2022-03-28	1	\N	\N	\N	\N
3990	Cidade Gaúcha	4105607	PR	2022-03-28	1	\N	\N	\N	\N
3991	Clevelândia	4105706	PR	2022-03-28	1	\N	\N	\N	\N
3992	Colombo	4105805	PR	2022-03-28	1	\N	\N	\N	\N
3993	Colorado	4105904	PR	2022-03-28	1	\N	\N	\N	\N
3994	Congonhinhas	4106001	PR	2022-03-28	1	\N	\N	\N	\N
3995	Conselheiro Mairinck	4106100	PR	2022-03-28	1	\N	\N	\N	\N
3996	Contenda	4106209	PR	2022-03-28	1	\N	\N	\N	\N
3997	Corbélia	4106308	PR	2022-03-28	1	\N	\N	\N	\N
3998	Cornélio Procópio	4106407	PR	2022-03-28	1	\N	\N	\N	\N
3999	Coronel Domingos Soares	4106456	PR	2022-03-28	1	\N	\N	\N	\N
4000	Coronel Vivida	4106506	PR	2022-03-28	1	\N	\N	\N	\N
4001	Corumbataí do Sul	4106555	PR	2022-03-28	1	\N	\N	\N	\N
4002	Cruz Machado	4106803	PR	2022-03-28	1	\N	\N	\N	\N
4003	Cruzeiro do Iguaçu	4106571	PR	2022-03-28	1	\N	\N	\N	\N
4004	Cruzeiro do Oeste	4106605	PR	2022-03-28	1	\N	\N	\N	\N
4005	Cruzeiro do Sul	4106704	PR	2022-03-28	1	\N	\N	\N	\N
4006	Cruzmaltina	4106852	PR	2022-03-28	1	\N	\N	\N	\N
4007	Curitiba	4106902	PR	2022-03-28	1	\N	\N	\N	\N
4008	Curiúva	4107009	PR	2022-03-28	1	\N	\N	\N	\N
4009	Diamante do Norte	4107108	PR	2022-03-28	1	\N	\N	\N	\N
4010	Diamante do Sul	4107124	PR	2022-03-28	1	\N	\N	\N	\N
4011	'Diamante D''Oeste'	4107157	PR	2022-03-28	1	\N	\N	\N	\N
4012	Dois Vizinhos	4107207	PR	2022-03-28	1	\N	\N	\N	\N
4013	Douradina	4107256	PR	2022-03-28	1	\N	\N	\N	\N
4014	Doutor Camargo	4107306	PR	2022-03-28	1	\N	\N	\N	\N
4015	Doutor Ulysses	4128633	PR	2022-03-28	1	\N	\N	\N	\N
4016	Enéas Marques	4107405	PR	2022-03-28	1	\N	\N	\N	\N
4017	Engenheiro Beltrão	4107504	PR	2022-03-28	1	\N	\N	\N	\N
4018	Entre Rios do Oeste	4107538	PR	2022-03-28	1	\N	\N	\N	\N
4019	Esperança Nova	4107520	PR	2022-03-28	1	\N	\N	\N	\N
4020	Espigão Alto do Iguaçu	4107546	PR	2022-03-28	1	\N	\N	\N	\N
4021	Farol	4107553	PR	2022-03-28	1	\N	\N	\N	\N
4022	Faxinal	4107603	PR	2022-03-28	1	\N	\N	\N	\N
4023	Fazenda Rio Grande	4107652	PR	2022-03-28	1	\N	\N	\N	\N
4024	Fênix	4107702	PR	2022-03-28	1	\N	\N	\N	\N
4025	Fernandes Pinheiro	4107736	PR	2022-03-28	1	\N	\N	\N	\N
4026	Figueira	4107751	PR	2022-03-28	1	\N	\N	\N	\N
4027	Flor da Serra do Sul	4107850	PR	2022-03-28	1	\N	\N	\N	\N
4028	Floraí	4107801	PR	2022-03-28	1	\N	\N	\N	\N
4029	Floresta	4107900	PR	2022-03-28	1	\N	\N	\N	\N
4030	Florestópolis	4108007	PR	2022-03-28	1	\N	\N	\N	\N
4031	Flórida	4108106	PR	2022-03-28	1	\N	\N	\N	\N
4032	Formosa do Oeste	4108205	PR	2022-03-28	1	\N	\N	\N	\N
4033	Foz do Iguaçu	4108304	PR	2022-03-28	1	\N	\N	\N	\N
4034	Foz do Jordão	4108452	PR	2022-03-28	1	\N	\N	\N	\N
4035	Francisco Alves	4108320	PR	2022-03-28	1	\N	\N	\N	\N
4036	Francisco Beltrão	4108403	PR	2022-03-28	1	\N	\N	\N	\N
4037	General Carneiro	4108502	PR	2022-03-28	1	\N	\N	\N	\N
4038	Godoy Moreira	4108551	PR	2022-03-28	1	\N	\N	\N	\N
4039	Goioerê	4108601	PR	2022-03-28	1	\N	\N	\N	\N
4040	Goioxim	4108650	PR	2022-03-28	1	\N	\N	\N	\N
4041	Grandes Rios	4108700	PR	2022-03-28	1	\N	\N	\N	\N
4042	Guaíra	4108809	PR	2022-03-28	1	\N	\N	\N	\N
4043	Guairaçá	4108908	PR	2022-03-28	1	\N	\N	\N	\N
4044	Guamiranga	4108957	PR	2022-03-28	1	\N	\N	\N	\N
4045	Guapirama	4109005	PR	2022-03-28	1	\N	\N	\N	\N
4046	Guaporema	4109104	PR	2022-03-28	1	\N	\N	\N	\N
4047	Guaraci	4109203	PR	2022-03-28	1	\N	\N	\N	\N
4048	Guaraniaçu	4109302	PR	2022-03-28	1	\N	\N	\N	\N
4049	Guarapuava	4109401	PR	2022-03-28	1	\N	\N	\N	\N
4050	Guaraqueçaba	4109500	PR	2022-03-28	1	\N	\N	\N	\N
4051	Guaratuba	4109609	PR	2022-03-28	1	\N	\N	\N	\N
4052	Honório Serpa	4109658	PR	2022-03-28	1	\N	\N	\N	\N
4053	Ibaiti	4109708	PR	2022-03-28	1	\N	\N	\N	\N
4054	Ibema	4109757	PR	2022-03-28	1	\N	\N	\N	\N
4055	Ibiporã	4109807	PR	2022-03-28	1	\N	\N	\N	\N
4056	Icaraíma	4109906	PR	2022-03-28	1	\N	\N	\N	\N
4057	Iguaraçu	4110003	PR	2022-03-28	1	\N	\N	\N	\N
4058	Iguatu	4110052	PR	2022-03-28	1	\N	\N	\N	\N
4059	Imbaú	4110078	PR	2022-03-28	1	\N	\N	\N	\N
4060	Imbituva	4110102	PR	2022-03-28	1	\N	\N	\N	\N
4061	Inácio Martins	4110201	PR	2022-03-28	1	\N	\N	\N	\N
4062	Inajá	4110300	PR	2022-03-28	1	\N	\N	\N	\N
4063	Indianópolis	4110409	PR	2022-03-28	1	\N	\N	\N	\N
4064	Ipiranga	4110508	PR	2022-03-28	1	\N	\N	\N	\N
4065	Iporã	4110607	PR	2022-03-28	1	\N	\N	\N	\N
4066	Iracema do Oeste	4110656	PR	2022-03-28	1	\N	\N	\N	\N
4067	Irati	4110706	PR	2022-03-28	1	\N	\N	\N	\N
4068	Iretama	4110805	PR	2022-03-28	1	\N	\N	\N	\N
4069	Itaguajé	4110904	PR	2022-03-28	1	\N	\N	\N	\N
4070	Itaipulândia	4110953	PR	2022-03-28	1	\N	\N	\N	\N
4071	Itambaracá	4111001	PR	2022-03-28	1	\N	\N	\N	\N
4072	Itambé	4111100	PR	2022-03-28	1	\N	\N	\N	\N
4073	'Itapejara d''Oeste'	4111209	PR	2022-03-28	1	\N	\N	\N	\N
4074	Itaperuçu	4111258	PR	2022-03-28	1	\N	\N	\N	\N
4075	Itaúna do Sul	4111308	PR	2022-03-28	1	\N	\N	\N	\N
4076	Ivaí	4111407	PR	2022-03-28	1	\N	\N	\N	\N
4077	Ivaiporã	4111506	PR	2022-03-28	1	\N	\N	\N	\N
4078	Ivaté	4111555	PR	2022-03-28	1	\N	\N	\N	\N
4079	Ivatuba	4111605	PR	2022-03-28	1	\N	\N	\N	\N
4080	Jaboti	4111704	PR	2022-03-28	1	\N	\N	\N	\N
4081	Jacarezinho	4111803	PR	2022-03-28	1	\N	\N	\N	\N
4082	Jaguapitã	4111902	PR	2022-03-28	1	\N	\N	\N	\N
4083	Jaguariaíva	4112009	PR	2022-03-28	1	\N	\N	\N	\N
4084	Jandaia do Sul	4112108	PR	2022-03-28	1	\N	\N	\N	\N
4085	Janiópolis	4112207	PR	2022-03-28	1	\N	\N	\N	\N
4086	Japira	4112306	PR	2022-03-28	1	\N	\N	\N	\N
4087	Japurá	4112405	PR	2022-03-28	1	\N	\N	\N	\N
4088	Jardim Alegre	4112504	PR	2022-03-28	1	\N	\N	\N	\N
4089	Jardim Olinda	4112603	PR	2022-03-28	1	\N	\N	\N	\N
4090	Jataizinho	4112702	PR	2022-03-28	1	\N	\N	\N	\N
4091	Jesuítas	4112751	PR	2022-03-28	1	\N	\N	\N	\N
4092	Joaquim Távora	4112801	PR	2022-03-28	1	\N	\N	\N	\N
4093	Jundiaí do Sul	4112900	PR	2022-03-28	1	\N	\N	\N	\N
4094	Juranda	4112959	PR	2022-03-28	1	\N	\N	\N	\N
4095	Jussara	4113007	PR	2022-03-28	1	\N	\N	\N	\N
4096	Kaloré	4113106	PR	2022-03-28	1	\N	\N	\N	\N
4097	Lapa	4113205	PR	2022-03-28	1	\N	\N	\N	\N
4098	Laranjal	4113254	PR	2022-03-28	1	\N	\N	\N	\N
4099	Laranjeiras do Sul	4113304	PR	2022-03-28	1	\N	\N	\N	\N
4100	Leópolis	4113403	PR	2022-03-28	1	\N	\N	\N	\N
4101	Lidianópolis	4113429	PR	2022-03-28	1	\N	\N	\N	\N
4102	Lindoeste	4113452	PR	2022-03-28	1	\N	\N	\N	\N
4103	Loanda	4113502	PR	2022-03-28	1	\N	\N	\N	\N
4104	Lobato	4113601	PR	2022-03-28	1	\N	\N	\N	\N
4105	Londrina	4113700	PR	2022-03-28	1	\N	\N	\N	\N
4106	Luiziana	4113734	PR	2022-03-28	1	\N	\N	\N	\N
4107	Lunardelli	4113759	PR	2022-03-28	1	\N	\N	\N	\N
4108	Lupionópolis	4113809	PR	2022-03-28	1	\N	\N	\N	\N
4109	Mallet	4113908	PR	2022-03-28	1	\N	\N	\N	\N
4110	Mamborê	4114005	PR	2022-03-28	1	\N	\N	\N	\N
4111	Mandaguaçu	4114104	PR	2022-03-28	1	\N	\N	\N	\N
4112	Mandaguari	4114203	PR	2022-03-28	1	\N	\N	\N	\N
4113	Mandirituba	4114302	PR	2022-03-28	1	\N	\N	\N	\N
4114	Manfrinópolis	4114351	PR	2022-03-28	1	\N	\N	\N	\N
4115	Mangueirinha	4114401	PR	2022-03-28	1	\N	\N	\N	\N
4116	Manoel Ribas	4114500	PR	2022-03-28	1	\N	\N	\N	\N
4117	Marechal Cândido Rondon	4114609	PR	2022-03-28	1	\N	\N	\N	\N
4118	Maria Helena	4114708	PR	2022-03-28	1	\N	\N	\N	\N
4119	Marialva	4114807	PR	2022-03-28	1	\N	\N	\N	\N
4120	Marilândia do Sul	4114906	PR	2022-03-28	1	\N	\N	\N	\N
4121	Marilena	4115002	PR	2022-03-28	1	\N	\N	\N	\N
4122	Mariluz	4115101	PR	2022-03-28	1	\N	\N	\N	\N
4123	Maringá	4115200	PR	2022-03-28	1	\N	\N	\N	\N
4124	Mariópolis	4115309	PR	2022-03-28	1	\N	\N	\N	\N
4125	Maripá	4115358	PR	2022-03-28	1	\N	\N	\N	\N
4126	Marmeleiro	4115408	PR	2022-03-28	1	\N	\N	\N	\N
4127	Marquinho	4115457	PR	2022-03-28	1	\N	\N	\N	\N
4128	Marumbi	4115507	PR	2022-03-28	1	\N	\N	\N	\N
4129	Matelândia	4115606	PR	2022-03-28	1	\N	\N	\N	\N
4130	Matinhos	4115705	PR	2022-03-28	1	\N	\N	\N	\N
4131	Mato Rico	4115739	PR	2022-03-28	1	\N	\N	\N	\N
4132	Mauá da Serra	4115754	PR	2022-03-28	1	\N	\N	\N	\N
4133	Medianeira	4115804	PR	2022-03-28	1	\N	\N	\N	\N
4134	Mercedes	4115853	PR	2022-03-28	1	\N	\N	\N	\N
4135	Mirador	4115903	PR	2022-03-28	1	\N	\N	\N	\N
4136	Miraselva	4116000	PR	2022-03-28	1	\N	\N	\N	\N
4137	Missal	4116059	PR	2022-03-28	1	\N	\N	\N	\N
4138	Moreira Sales	4116109	PR	2022-03-28	1	\N	\N	\N	\N
4139	Morretes	4116208	PR	2022-03-28	1	\N	\N	\N	\N
4140	Munhoz de Melo	4116307	PR	2022-03-28	1	\N	\N	\N	\N
4141	Nossa Senhora das Graças	4116406	PR	2022-03-28	1	\N	\N	\N	\N
4142	Nova Aliança do Ivaí	4116505	PR	2022-03-28	1	\N	\N	\N	\N
4143	Nova América da Colina	4116604	PR	2022-03-28	1	\N	\N	\N	\N
4144	Nova Aurora	4116703	PR	2022-03-28	1	\N	\N	\N	\N
4145	Nova Cantu	4116802	PR	2022-03-28	1	\N	\N	\N	\N
4146	Nova Esperança	4116901	PR	2022-03-28	1	\N	\N	\N	\N
4147	Nova Esperança do Sudoeste	4116950	PR	2022-03-28	1	\N	\N	\N	\N
4148	Nova Fátima	4117008	PR	2022-03-28	1	\N	\N	\N	\N
4149	Nova Laranjeiras	4117057	PR	2022-03-28	1	\N	\N	\N	\N
4150	Nova Londrina	4117107	PR	2022-03-28	1	\N	\N	\N	\N
4151	Nova Olímpia	4117206	PR	2022-03-28	1	\N	\N	\N	\N
4152	Nova Prata do Iguaçu	4117255	PR	2022-03-28	1	\N	\N	\N	\N
4153	Nova Santa Bárbara	4117214	PR	2022-03-28	1	\N	\N	\N	\N
4154	Nova Santa Rosa	4117222	PR	2022-03-28	1	\N	\N	\N	\N
4155	Nova Tebas	4117271	PR	2022-03-28	1	\N	\N	\N	\N
4156	Novo Itacolomi	4117297	PR	2022-03-28	1	\N	\N	\N	\N
4157	Ortigueira	4117305	PR	2022-03-28	1	\N	\N	\N	\N
4158	Ourizona	4117404	PR	2022-03-28	1	\N	\N	\N	\N
4159	Ouro Verde do Oeste	4117453	PR	2022-03-28	1	\N	\N	\N	\N
4160	Paiçandu	4117503	PR	2022-03-28	1	\N	\N	\N	\N
4161	Palmas	4117602	PR	2022-03-28	1	\N	\N	\N	\N
4162	Palmeira	4117701	PR	2022-03-28	1	\N	\N	\N	\N
4163	Palmital	4117800	PR	2022-03-28	1	\N	\N	\N	\N
4164	Palotina	4117909	PR	2022-03-28	1	\N	\N	\N	\N
4165	Paraíso do Norte	4118006	PR	2022-03-28	1	\N	\N	\N	\N
4166	Paranacity	4118105	PR	2022-03-28	1	\N	\N	\N	\N
4167	Paranaguá	4118204	PR	2022-03-28	1	\N	\N	\N	\N
4168	Paranapoema	4118303	PR	2022-03-28	1	\N	\N	\N	\N
4169	Paranavaí	4118402	PR	2022-03-28	1	\N	\N	\N	\N
4170	Pato Bragado	4118451	PR	2022-03-28	1	\N	\N	\N	\N
4171	Pato Branco	4118501	PR	2022-03-28	1	\N	\N	\N	\N
4172	Paula Freitas	4118600	PR	2022-03-28	1	\N	\N	\N	\N
4173	Paulo Frontin	4118709	PR	2022-03-28	1	\N	\N	\N	\N
4174	Peabiru	4118808	PR	2022-03-28	1	\N	\N	\N	\N
4175	Perobal	4118857	PR	2022-03-28	1	\N	\N	\N	\N
4176	Pérola	4118907	PR	2022-03-28	1	\N	\N	\N	\N
4177	'Pérola d''Oeste'	4119004	PR	2022-03-28	1	\N	\N	\N	\N
4178	Piên	4119103	PR	2022-03-28	1	\N	\N	\N	\N
4179	Pinhais	4119152	PR	2022-03-28	1	\N	\N	\N	\N
4180	Pinhal de São Bento	4119251	PR	2022-03-28	1	\N	\N	\N	\N
4181	Pinhalão	4119202	PR	2022-03-28	1	\N	\N	\N	\N
4182	Pinhão	4119301	PR	2022-03-28	1	\N	\N	\N	\N
4183	Piraí do Sul	4119400	PR	2022-03-28	1	\N	\N	\N	\N
4184	Piraquara	4119509	PR	2022-03-28	1	\N	\N	\N	\N
4185	Pitanga	4119608	PR	2022-03-28	1	\N	\N	\N	\N
4186	Pitangueiras	4119657	PR	2022-03-28	1	\N	\N	\N	\N
4187	Planaltina do Paraná	4119707	PR	2022-03-28	1	\N	\N	\N	\N
4188	Planalto	4119806	PR	2022-03-28	1	\N	\N	\N	\N
4189	Ponta Grossa	4119905	PR	2022-03-28	1	\N	\N	\N	\N
4190	Pontal do Paraná	4119954	PR	2022-03-28	1	\N	\N	\N	\N
4191	Porecatu	4120002	PR	2022-03-28	1	\N	\N	\N	\N
4192	Porto Amazonas	4120101	PR	2022-03-28	1	\N	\N	\N	\N
4193	Porto Barreiro	4120150	PR	2022-03-28	1	\N	\N	\N	\N
4194	Porto Rico	4120200	PR	2022-03-28	1	\N	\N	\N	\N
4195	Porto Vitória	4120309	PR	2022-03-28	1	\N	\N	\N	\N
4196	Prado Ferreira	4120333	PR	2022-03-28	1	\N	\N	\N	\N
4197	Pranchita	4120358	PR	2022-03-28	1	\N	\N	\N	\N
4198	Presidente Castelo Branco	4120408	PR	2022-03-28	1	\N	\N	\N	\N
4199	Primeiro de Maio	4120507	PR	2022-03-28	1	\N	\N	\N	\N
4200	Prudentópolis	4120606	PR	2022-03-28	1	\N	\N	\N	\N
4201	Quarto Centenário	4120655	PR	2022-03-28	1	\N	\N	\N	\N
4202	Quatiguá	4120705	PR	2022-03-28	1	\N	\N	\N	\N
4203	Quatro Barras	4120804	PR	2022-03-28	1	\N	\N	\N	\N
4204	Quatro Pontes	4120853	PR	2022-03-28	1	\N	\N	\N	\N
4205	Quedas do Iguaçu	4120903	PR	2022-03-28	1	\N	\N	\N	\N
4206	Querência do Norte	4121000	PR	2022-03-28	1	\N	\N	\N	\N
4207	Quinta do Sol	4121109	PR	2022-03-28	1	\N	\N	\N	\N
4208	Quitandinha	4121208	PR	2022-03-28	1	\N	\N	\N	\N
4209	Ramilândia	4121257	PR	2022-03-28	1	\N	\N	\N	\N
4210	Rancho Alegre	4121307	PR	2022-03-28	1	\N	\N	\N	\N
4211	'Rancho Alegre D''Oeste'	4121356	PR	2022-03-28	1	\N	\N	\N	\N
4212	Realeza	4121406	PR	2022-03-28	1	\N	\N	\N	\N
4213	Rebouças	4121505	PR	2022-03-28	1	\N	\N	\N	\N
4214	Renascença	4121604	PR	2022-03-28	1	\N	\N	\N	\N
4215	Reserva	4121703	PR	2022-03-28	1	\N	\N	\N	\N
4216	Reserva do Iguaçu	4121752	PR	2022-03-28	1	\N	\N	\N	\N
4217	Ribeirão Claro	4121802	PR	2022-03-28	1	\N	\N	\N	\N
4218	Ribeirão do Pinhal	4121901	PR	2022-03-28	1	\N	\N	\N	\N
4219	Rio Azul	4122008	PR	2022-03-28	1	\N	\N	\N	\N
4220	Rio Bom	4122107	PR	2022-03-28	1	\N	\N	\N	\N
4221	Rio Bonito do Iguaçu	4122156	PR	2022-03-28	1	\N	\N	\N	\N
4222	Rio Branco do Ivaí	4122172	PR	2022-03-28	1	\N	\N	\N	\N
4223	Rio Branco do Sul	4122206	PR	2022-03-28	1	\N	\N	\N	\N
4224	Rio Negro	4122305	PR	2022-03-28	1	\N	\N	\N	\N
4225	Rolândia	4122404	PR	2022-03-28	1	\N	\N	\N	\N
4226	Roncador	4122503	PR	2022-03-28	1	\N	\N	\N	\N
4227	Rondon	4122602	PR	2022-03-28	1	\N	\N	\N	\N
4228	Rosário do Ivaí	4122651	PR	2022-03-28	1	\N	\N	\N	\N
4229	Sabáudia	4122701	PR	2022-03-28	1	\N	\N	\N	\N
4230	Salgado Filho	4122800	PR	2022-03-28	1	\N	\N	\N	\N
4231	Salto do Itararé	4122909	PR	2022-03-28	1	\N	\N	\N	\N
4232	Salto do Lontra	4123006	PR	2022-03-28	1	\N	\N	\N	\N
4233	Santa Amélia	4123105	PR	2022-03-28	1	\N	\N	\N	\N
4234	Santa Cecília do Pavão	4123204	PR	2022-03-28	1	\N	\N	\N	\N
4235	Santa Cruz de Monte Castelo	4123303	PR	2022-03-28	1	\N	\N	\N	\N
4236	Santa Fé	4123402	PR	2022-03-28	1	\N	\N	\N	\N
4237	Santa Helena	4123501	PR	2022-03-28	1	\N	\N	\N	\N
4238	Santa Inês	4123600	PR	2022-03-28	1	\N	\N	\N	\N
4239	Santa Isabel do Ivaí	4123709	PR	2022-03-28	1	\N	\N	\N	\N
4240	Santa Izabel do Oeste	4123808	PR	2022-03-28	1	\N	\N	\N	\N
4241	Santa Lúcia	4123824	PR	2022-03-28	1	\N	\N	\N	\N
4242	Santa Maria do Oeste	4123857	PR	2022-03-28	1	\N	\N	\N	\N
4243	Santa Mariana	4123907	PR	2022-03-28	1	\N	\N	\N	\N
4244	Santa Mônica	4123956	PR	2022-03-28	1	\N	\N	\N	\N
4245	Santa Tereza do Oeste	4124020	PR	2022-03-28	1	\N	\N	\N	\N
4246	Santa Terezinha de Itaipu	4124053	PR	2022-03-28	1	\N	\N	\N	\N
4247	Santana do Itararé	4124004	PR	2022-03-28	1	\N	\N	\N	\N
4248	Santo Antônio da Platina	4124103	PR	2022-03-28	1	\N	\N	\N	\N
4249	Santo Antônio do Caiuá	4124202	PR	2022-03-28	1	\N	\N	\N	\N
4250	Santo Antônio do Paraíso	4124301	PR	2022-03-28	1	\N	\N	\N	\N
4251	Santo Antônio do Sudoeste	4124400	PR	2022-03-28	1	\N	\N	\N	\N
4252	Santo Inácio	4124509	PR	2022-03-28	1	\N	\N	\N	\N
4253	São Carlos do Ivaí	4124608	PR	2022-03-28	1	\N	\N	\N	\N
4254	São Jerônimo da Serra	4124707	PR	2022-03-28	1	\N	\N	\N	\N
4255	São João	4124806	PR	2022-03-28	1	\N	\N	\N	\N
4256	São João do Caiuá	4124905	PR	2022-03-28	1	\N	\N	\N	\N
4257	São João do Ivaí	4125001	PR	2022-03-28	1	\N	\N	\N	\N
4258	São João do Triunfo	4125100	PR	2022-03-28	1	\N	\N	\N	\N
4259	São Jorge do Ivaí	4125308	PR	2022-03-28	1	\N	\N	\N	\N
4260	São Jorge do Patrocínio	4125357	PR	2022-03-28	1	\N	\N	\N	\N
4261	'São Jorge d''Oeste'	4125209	PR	2022-03-28	1	\N	\N	\N	\N
4262	São José da Boa Vista	4125407	PR	2022-03-28	1	\N	\N	\N	\N
4263	São José das Palmeiras	4125456	PR	2022-03-28	1	\N	\N	\N	\N
4264	São José dos Pinhais	4125506	PR	2022-03-28	1	\N	\N	\N	\N
4265	São Manoel do Paraná	4125555	PR	2022-03-28	1	\N	\N	\N	\N
4266	São Mateus do Sul	4125605	PR	2022-03-28	1	\N	\N	\N	\N
4267	São Miguel do Iguaçu	4125704	PR	2022-03-28	1	\N	\N	\N	\N
4268	São Pedro do Iguaçu	4125753	PR	2022-03-28	1	\N	\N	\N	\N
4269	São Pedro do Ivaí	4125803	PR	2022-03-28	1	\N	\N	\N	\N
4270	São Pedro do Paraná	4125902	PR	2022-03-28	1	\N	\N	\N	\N
4271	São Sebastião da Amoreira	4126009	PR	2022-03-28	1	\N	\N	\N	\N
4272	São Tomé	4126108	PR	2022-03-28	1	\N	\N	\N	\N
4273	Sapopema	4126207	PR	2022-03-28	1	\N	\N	\N	\N
4274	Sarandi	4126256	PR	2022-03-28	1	\N	\N	\N	\N
4275	Saudade do Iguaçu	4126272	PR	2022-03-28	1	\N	\N	\N	\N
4276	Sengés	4126306	PR	2022-03-28	1	\N	\N	\N	\N
4277	Serranópolis do Iguaçu	4126355	PR	2022-03-28	1	\N	\N	\N	\N
4278	Sertaneja	4126405	PR	2022-03-28	1	\N	\N	\N	\N
4279	Sertanópolis	4126504	PR	2022-03-28	1	\N	\N	\N	\N
4280	Siqueira Campos	4126603	PR	2022-03-28	1	\N	\N	\N	\N
4281	Sulina	4126652	PR	2022-03-28	1	\N	\N	\N	\N
4282	Tamarana	4126678	PR	2022-03-28	1	\N	\N	\N	\N
4283	Tamboara	4126702	PR	2022-03-28	1	\N	\N	\N	\N
4284	Tapejara	4126801	PR	2022-03-28	1	\N	\N	\N	\N
4285	Tapira	4126900	PR	2022-03-28	1	\N	\N	\N	\N
4286	Teixeira Soares	4127007	PR	2022-03-28	1	\N	\N	\N	\N
4287	Telêmaco Borba	4127106	PR	2022-03-28	1	\N	\N	\N	\N
4288	Terra Boa	4127205	PR	2022-03-28	1	\N	\N	\N	\N
4289	Terra Rica	4127304	PR	2022-03-28	1	\N	\N	\N	\N
4290	Terra Roxa	4127403	PR	2022-03-28	1	\N	\N	\N	\N
4291	Tibagi	4127502	PR	2022-03-28	1	\N	\N	\N	\N
4292	Tijucas do Sul	4127601	PR	2022-03-28	1	\N	\N	\N	\N
4293	Toledo	4127700	PR	2022-03-28	1	\N	\N	\N	\N
4294	Tomazina	4127809	PR	2022-03-28	1	\N	\N	\N	\N
4295	Três Barras do Paraná	4127858	PR	2022-03-28	1	\N	\N	\N	\N
4296	Tunas do Paraná	4127882	PR	2022-03-28	1	\N	\N	\N	\N
4297	Tuneiras do Oeste	4127908	PR	2022-03-28	1	\N	\N	\N	\N
4298	Tupãssi	4127957	PR	2022-03-28	1	\N	\N	\N	\N
4299	Turvo	4127965	PR	2022-03-28	1	\N	\N	\N	\N
4300	Ubiratã	4128005	PR	2022-03-28	1	\N	\N	\N	\N
4301	Umuarama	4128104	PR	2022-03-28	1	\N	\N	\N	\N
4302	União da Vitória	4128203	PR	2022-03-28	1	\N	\N	\N	\N
4303	Uniflor	4128302	PR	2022-03-28	1	\N	\N	\N	\N
4304	Uraí	4128401	PR	2022-03-28	1	\N	\N	\N	\N
4305	Ventania	4128534	PR	2022-03-28	1	\N	\N	\N	\N
4306	Vera Cruz do Oeste	4128559	PR	2022-03-28	1	\N	\N	\N	\N
4307	Verê	4128609	PR	2022-03-28	1	\N	\N	\N	\N
4308	Virmond	4128658	PR	2022-03-28	1	\N	\N	\N	\N
4309	Vitorino	4128708	PR	2022-03-28	1	\N	\N	\N	\N
4310	Wenceslau Braz	4128500	PR	2022-03-28	1	\N	\N	\N	\N
4311	Xambrê	4128807	PR	2022-03-28	1	\N	\N	\N	\N
4312	Abdon Batista	4200051	SC	2022-03-28	1	\N	\N	\N	\N
4313	Abelardo Luz	4200101	SC	2022-03-28	1	\N	\N	\N	\N
4314	Agrolândia	4200200	SC	2022-03-28	1	\N	\N	\N	\N
4315	Agronômica	4200309	SC	2022-03-28	1	\N	\N	\N	\N
4316	Água Doce	4200408	SC	2022-03-28	1	\N	\N	\N	\N
4317	Águas de Chapecó	4200507	SC	2022-03-28	1	\N	\N	\N	\N
4318	Águas Frias	4200556	SC	2022-03-28	1	\N	\N	\N	\N
4319	Águas Mornas	4200606	SC	2022-03-28	1	\N	\N	\N	\N
4320	Alfredo Wagner	4200705	SC	2022-03-28	1	\N	\N	\N	\N
4321	Alto Bela Vista	4200754	SC	2022-03-28	1	\N	\N	\N	\N
4322	Anchieta	4200804	SC	2022-03-28	1	\N	\N	\N	\N
4323	Angelina	4200903	SC	2022-03-28	1	\N	\N	\N	\N
4324	Anita Garibaldi	4201000	SC	2022-03-28	1	\N	\N	\N	\N
4325	Anitápolis	4201109	SC	2022-03-28	1	\N	\N	\N	\N
4326	Antônio Carlos	4201208	SC	2022-03-28	1	\N	\N	\N	\N
4327	Apiúna	4201257	SC	2022-03-28	1	\N	\N	\N	\N
4328	Arabutã	4201273	SC	2022-03-28	1	\N	\N	\N	\N
4329	Araquari	4201307	SC	2022-03-28	1	\N	\N	\N	\N
4330	Araranguá	4201406	SC	2022-03-28	1	\N	\N	\N	\N
4331	Armazém	4201505	SC	2022-03-28	1	\N	\N	\N	\N
4332	Arroio Trinta	4201604	SC	2022-03-28	1	\N	\N	\N	\N
4333	Arvoredo	4201653	SC	2022-03-28	1	\N	\N	\N	\N
4334	Ascurra	4201703	SC	2022-03-28	1	\N	\N	\N	\N
4335	Atalanta	4201802	SC	2022-03-28	1	\N	\N	\N	\N
4336	Aurora	4201901	SC	2022-03-28	1	\N	\N	\N	\N
4337	Balneário Arroio do Silva	4201950	SC	2022-03-28	1	\N	\N	\N	\N
4338	Balneário Barra do Sul	4202057	SC	2022-03-28	1	\N	\N	\N	\N
4339	Balneário Camboriú	4202008	SC	2022-03-28	1	\N	\N	\N	\N
4340	Balneário Gaivota	4202073	SC	2022-03-28	1	\N	\N	\N	\N
4341	Balneário Piçarras	4212809	SC	2022-03-28	1	\N	\N	\N	\N
4342	Balneário Rincão	4220000	SC	2022-03-28	1	\N	\N	\N	\N
4343	Bandeirante	4202081	SC	2022-03-28	1	\N	\N	\N	\N
4344	Barra Bonita	4202099	SC	2022-03-28	1	\N	\N	\N	\N
4345	Barra Velha	4202107	SC	2022-03-28	1	\N	\N	\N	\N
4346	Bela Vista do Toldo	4202131	SC	2022-03-28	1	\N	\N	\N	\N
4347	Belmonte	4202156	SC	2022-03-28	1	\N	\N	\N	\N
4348	Benedito Novo	4202206	SC	2022-03-28	1	\N	\N	\N	\N
4349	Biguaçu	4202305	SC	2022-03-28	1	\N	\N	\N	\N
4350	Blumenau	4202404	SC	2022-03-28	1	\N	\N	\N	\N
4351	Bocaina do Sul	4202438	SC	2022-03-28	1	\N	\N	\N	\N
4352	Bom Jardim da Serra	4202503	SC	2022-03-28	1	\N	\N	\N	\N
4353	Bom Jesus	4202537	SC	2022-03-28	1	\N	\N	\N	\N
4354	Bom Jesus do Oeste	4202578	SC	2022-03-28	1	\N	\N	\N	\N
4355	Bom Retiro	4202602	SC	2022-03-28	1	\N	\N	\N	\N
4356	Bombinhas	4202453	SC	2022-03-28	1	\N	\N	\N	\N
4357	Botuverá	4202701	SC	2022-03-28	1	\N	\N	\N	\N
4358	Braço do Norte	4202800	SC	2022-03-28	1	\N	\N	\N	\N
4359	Braço do Trombudo	4202859	SC	2022-03-28	1	\N	\N	\N	\N
4360	Brunópolis	4202875	SC	2022-03-28	1	\N	\N	\N	\N
4361	Brusque	4202909	SC	2022-03-28	1	\N	\N	\N	\N
4362	Caçador	4203006	SC	2022-03-28	1	\N	\N	\N	\N
4363	Caibi	4203105	SC	2022-03-28	1	\N	\N	\N	\N
4364	Calmon	4203154	SC	2022-03-28	1	\N	\N	\N	\N
4365	Camboriú	4203204	SC	2022-03-28	1	\N	\N	\N	\N
4366	Campo Alegre	4203303	SC	2022-03-28	1	\N	\N	\N	\N
4367	Campo Belo do Sul	4203402	SC	2022-03-28	1	\N	\N	\N	\N
4368	Campo Erê	4203501	SC	2022-03-28	1	\N	\N	\N	\N
4369	Campos Novos	4203600	SC	2022-03-28	1	\N	\N	\N	\N
4370	Canelinha	4203709	SC	2022-03-28	1	\N	\N	\N	\N
4371	Canoinhas	4203808	SC	2022-03-28	1	\N	\N	\N	\N
4372	Capão Alto	4203253	SC	2022-03-28	1	\N	\N	\N	\N
4373	Capinzal	4203907	SC	2022-03-28	1	\N	\N	\N	\N
4374	Capivari de Baixo	4203956	SC	2022-03-28	1	\N	\N	\N	\N
4375	Catanduvas	4204004	SC	2022-03-28	1	\N	\N	\N	\N
4376	Caxambu do Sul	4204103	SC	2022-03-28	1	\N	\N	\N	\N
4377	Celso Ramos	4204152	SC	2022-03-28	1	\N	\N	\N	\N
4378	Cerro Negro	4204178	SC	2022-03-28	1	\N	\N	\N	\N
4379	Chapadão do Lageado	4204194	SC	2022-03-28	1	\N	\N	\N	\N
4380	Chapecó	4204202	SC	2022-03-28	1	\N	\N	\N	\N
4381	Cocal do Sul	4204251	SC	2022-03-28	1	\N	\N	\N	\N
4382	Concórdia	4204301	SC	2022-03-28	1	\N	\N	\N	\N
4383	Cordilheira Alta	4204350	SC	2022-03-28	1	\N	\N	\N	\N
4384	Coronel Freitas	4204400	SC	2022-03-28	1	\N	\N	\N	\N
4385	Coronel Martins	4204459	SC	2022-03-28	1	\N	\N	\N	\N
4386	Correia Pinto	4204558	SC	2022-03-28	1	\N	\N	\N	\N
4387	Corupá	4204509	SC	2022-03-28	1	\N	\N	\N	\N
4388	Criciúma	4204608	SC	2022-03-28	1	\N	\N	\N	\N
4389	Cunha Porã	4204707	SC	2022-03-28	1	\N	\N	\N	\N
4390	Cunhataí	4204756	SC	2022-03-28	1	\N	\N	\N	\N
4391	Curitibanos	4204806	SC	2022-03-28	1	\N	\N	\N	\N
4392	Descanso	4204905	SC	2022-03-28	1	\N	\N	\N	\N
4393	Dionísio Cerqueira	4205001	SC	2022-03-28	1	\N	\N	\N	\N
4394	Dona Emma	4205100	SC	2022-03-28	1	\N	\N	\N	\N
4395	Doutor Pedrinho	4205159	SC	2022-03-28	1	\N	\N	\N	\N
4396	Entre Rios	4205175	SC	2022-03-28	1	\N	\N	\N	\N
4397	Ermo	4205191	SC	2022-03-28	1	\N	\N	\N	\N
4398	Erval Velho	4205209	SC	2022-03-28	1	\N	\N	\N	\N
4399	Faxinal dos Guedes	4205308	SC	2022-03-28	1	\N	\N	\N	\N
4400	Flor do Sertão	4205357	SC	2022-03-28	1	\N	\N	\N	\N
4401	Florianópolis	4205407	SC	2022-03-28	1	\N	\N	\N	\N
4402	Formosa do Sul	4205431	SC	2022-03-28	1	\N	\N	\N	\N
4403	Forquilhinha	4205456	SC	2022-03-28	1	\N	\N	\N	\N
4404	Fraiburgo	4205506	SC	2022-03-28	1	\N	\N	\N	\N
4405	Frei Rogério	4205555	SC	2022-03-28	1	\N	\N	\N	\N
4406	Galvão	4205605	SC	2022-03-28	1	\N	\N	\N	\N
4407	Garopaba	4205704	SC	2022-03-28	1	\N	\N	\N	\N
4408	Garuva	4205803	SC	2022-03-28	1	\N	\N	\N	\N
4409	Gaspar	4205902	SC	2022-03-28	1	\N	\N	\N	\N
4410	Governador Celso Ramos	4206009	SC	2022-03-28	1	\N	\N	\N	\N
4411	Grão-Pará	4206108	SC	2022-03-28	1	\N	\N	\N	\N
4412	Gravatal	4206207	SC	2022-03-28	1	\N	\N	\N	\N
4413	Guabiruba	4206306	SC	2022-03-28	1	\N	\N	\N	\N
4414	Guaraciaba	4206405	SC	2022-03-28	1	\N	\N	\N	\N
4415	Guaramirim	4206504	SC	2022-03-28	1	\N	\N	\N	\N
4416	Guarujá do Sul	4206603	SC	2022-03-28	1	\N	\N	\N	\N
4417	Guatambú	4206652	SC	2022-03-28	1	\N	\N	\N	\N
4418	'Herval d''Oeste'	4206702	SC	2022-03-28	1	\N	\N	\N	\N
4419	Ibiam	4206751	SC	2022-03-28	1	\N	\N	\N	\N
4420	Ibicaré	4206801	SC	2022-03-28	1	\N	\N	\N	\N
4421	Ibirama	4206900	SC	2022-03-28	1	\N	\N	\N	\N
4422	Içara	4207007	SC	2022-03-28	1	\N	\N	\N	\N
4423	Ilhota	4207106	SC	2022-03-28	1	\N	\N	\N	\N
4424	Imaruí	4207205	SC	2022-03-28	1	\N	\N	\N	\N
4425	Imbituba	4207304	SC	2022-03-28	1	\N	\N	\N	\N
4426	Imbuia	4207403	SC	2022-03-28	1	\N	\N	\N	\N
4427	Indaial	4207502	SC	2022-03-28	1	\N	\N	\N	\N
4428	Iomerê	4207577	SC	2022-03-28	1	\N	\N	\N	\N
4429	Ipira	4207601	SC	2022-03-28	1	\N	\N	\N	\N
4430	Iporã do Oeste	4207650	SC	2022-03-28	1	\N	\N	\N	\N
4431	Ipuaçu	4207684	SC	2022-03-28	1	\N	\N	\N	\N
4432	Ipumirim	4207700	SC	2022-03-28	1	\N	\N	\N	\N
4433	Iraceminha	4207759	SC	2022-03-28	1	\N	\N	\N	\N
4434	Irani	4207809	SC	2022-03-28	1	\N	\N	\N	\N
4435	Irati	4207858	SC	2022-03-28	1	\N	\N	\N	\N
4436	Irineópolis	4207908	SC	2022-03-28	1	\N	\N	\N	\N
4437	Itá	4208005	SC	2022-03-28	1	\N	\N	\N	\N
4438	Itaiópolis	4208104	SC	2022-03-28	1	\N	\N	\N	\N
4439	Itajaí	4208203	SC	2022-03-28	1	\N	\N	\N	\N
4440	Itapema	4208302	SC	2022-03-28	1	\N	\N	\N	\N
4441	Itapiranga	4208401	SC	2022-03-28	1	\N	\N	\N	\N
4442	Itapoá	4208450	SC	2022-03-28	1	\N	\N	\N	\N
4443	Ituporanga	4208500	SC	2022-03-28	1	\N	\N	\N	\N
4444	Jaborá	4208609	SC	2022-03-28	1	\N	\N	\N	\N
4445	Jacinto Machado	4208708	SC	2022-03-28	1	\N	\N	\N	\N
4446	Jaguaruna	4208807	SC	2022-03-28	1	\N	\N	\N	\N
4447	Jaraguá do Sul	4208906	SC	2022-03-28	1	\N	\N	\N	\N
4448	Jardinópolis	4208955	SC	2022-03-28	1	\N	\N	\N	\N
4449	Joaçaba	4209003	SC	2022-03-28	1	\N	\N	\N	\N
4450	Joinville	4209102	SC	2022-03-28	1	\N	\N	\N	\N
4451	José Boiteux	4209151	SC	2022-03-28	1	\N	\N	\N	\N
4452	Jupiá	4209177	SC	2022-03-28	1	\N	\N	\N	\N
4453	Lacerdópolis	4209201	SC	2022-03-28	1	\N	\N	\N	\N
4454	Lages	4209300	SC	2022-03-28	1	\N	\N	\N	\N
4455	Laguna	4209409	SC	2022-03-28	1	\N	\N	\N	\N
4456	Lajeado Grande	4209458	SC	2022-03-28	1	\N	\N	\N	\N
4457	Laurentino	4209508	SC	2022-03-28	1	\N	\N	\N	\N
4458	Lauro Müller	4209607	SC	2022-03-28	1	\N	\N	\N	\N
4459	Lebon Régis	4209706	SC	2022-03-28	1	\N	\N	\N	\N
4460	Leoberto Leal	4209805	SC	2022-03-28	1	\N	\N	\N	\N
4461	Lindóia do Sul	4209854	SC	2022-03-28	1	\N	\N	\N	\N
4462	Lontras	4209904	SC	2022-03-28	1	\N	\N	\N	\N
4463	Luiz Alves	4210001	SC	2022-03-28	1	\N	\N	\N	\N
4464	Luzerna	4210035	SC	2022-03-28	1	\N	\N	\N	\N
4465	Macieira	4210050	SC	2022-03-28	1	\N	\N	\N	\N
4466	Mafra	4210100	SC	2022-03-28	1	\N	\N	\N	\N
4467	Major Gercino	4210209	SC	2022-03-28	1	\N	\N	\N	\N
4468	Major Vieira	4210308	SC	2022-03-28	1	\N	\N	\N	\N
4469	Maracajá	4210407	SC	2022-03-28	1	\N	\N	\N	\N
4470	Maravilha	4210506	SC	2022-03-28	1	\N	\N	\N	\N
4471	Marema	4210555	SC	2022-03-28	1	\N	\N	\N	\N
4472	Massaranduba	4210605	SC	2022-03-28	1	\N	\N	\N	\N
4473	Matos Costa	4210704	SC	2022-03-28	1	\N	\N	\N	\N
4474	Meleiro	4210803	SC	2022-03-28	1	\N	\N	\N	\N
4475	Mirim Doce	4210852	SC	2022-03-28	1	\N	\N	\N	\N
4476	Modelo	4210902	SC	2022-03-28	1	\N	\N	\N	\N
4477	Mondaí	4211009	SC	2022-03-28	1	\N	\N	\N	\N
4478	Monte Carlo	4211058	SC	2022-03-28	1	\N	\N	\N	\N
4479	Monte Castelo	4211108	SC	2022-03-28	1	\N	\N	\N	\N
4480	Morro da Fumaça	4211207	SC	2022-03-28	1	\N	\N	\N	\N
4481	Morro Grande	4211256	SC	2022-03-28	1	\N	\N	\N	\N
4482	Navegantes	4211306	SC	2022-03-28	1	\N	\N	\N	\N
4483	Nova Erechim	4211405	SC	2022-03-28	1	\N	\N	\N	\N
4484	Nova Itaberaba	4211454	SC	2022-03-28	1	\N	\N	\N	\N
4485	Nova Trento	4211504	SC	2022-03-28	1	\N	\N	\N	\N
4486	Nova Veneza	4211603	SC	2022-03-28	1	\N	\N	\N	\N
4487	Novo Horizonte	4211652	SC	2022-03-28	1	\N	\N	\N	\N
4488	Orleans	4211702	SC	2022-03-28	1	\N	\N	\N	\N
4489	Otacílio Costa	4211751	SC	2022-03-28	1	\N	\N	\N	\N
4490	Ouro	4211801	SC	2022-03-28	1	\N	\N	\N	\N
4491	Ouro Verde	4211850	SC	2022-03-28	1	\N	\N	\N	\N
4492	Paial	4211876	SC	2022-03-28	1	\N	\N	\N	\N
4493	Painel	4211892	SC	2022-03-28	1	\N	\N	\N	\N
4494	Palhoça	4211900	SC	2022-03-28	1	\N	\N	\N	\N
4495	Palma Sola	4212007	SC	2022-03-28	1	\N	\N	\N	\N
4496	Palmeira	4212056	SC	2022-03-28	1	\N	\N	\N	\N
4497	Palmitos	4212106	SC	2022-03-28	1	\N	\N	\N	\N
4498	Papanduva	4212205	SC	2022-03-28	1	\N	\N	\N	\N
4499	Paraíso	4212239	SC	2022-03-28	1	\N	\N	\N	\N
4500	Passo de Torres	4212254	SC	2022-03-28	1	\N	\N	\N	\N
4501	Passos Maia	4212270	SC	2022-03-28	1	\N	\N	\N	\N
4502	Paulo Lopes	4212304	SC	2022-03-28	1	\N	\N	\N	\N
4503	Pedras Grandes	4212403	SC	2022-03-28	1	\N	\N	\N	\N
4504	Penha	4212502	SC	2022-03-28	1	\N	\N	\N	\N
4505	Peritiba	4212601	SC	2022-03-28	1	\N	\N	\N	\N
4506	Pescaria Brava	4212650	SC	2022-03-28	1	\N	\N	\N	\N
4507	Petrolândia	4212700	SC	2022-03-28	1	\N	\N	\N	\N
4508	Pinhalzinho	4212908	SC	2022-03-28	1	\N	\N	\N	\N
4509	Pinheiro Preto	4213005	SC	2022-03-28	1	\N	\N	\N	\N
4510	Piratuba	4213104	SC	2022-03-28	1	\N	\N	\N	\N
4511	Planalto Alegre	4213153	SC	2022-03-28	1	\N	\N	\N	\N
4512	Pomerode	4213203	SC	2022-03-28	1	\N	\N	\N	\N
4513	Ponte Alta	4213302	SC	2022-03-28	1	\N	\N	\N	\N
4514	Ponte Alta do Norte	4213351	SC	2022-03-28	1	\N	\N	\N	\N
4515	Ponte Serrada	4213401	SC	2022-03-28	1	\N	\N	\N	\N
4516	Porto Belo	4213500	SC	2022-03-28	1	\N	\N	\N	\N
4517	Porto União	4213609	SC	2022-03-28	1	\N	\N	\N	\N
4518	Pouso Redondo	4213708	SC	2022-03-28	1	\N	\N	\N	\N
4519	Praia Grande	4213807	SC	2022-03-28	1	\N	\N	\N	\N
4520	Presidente Castello Branco	4213906	SC	2022-03-28	1	\N	\N	\N	\N
4521	Presidente Getúlio	4214003	SC	2022-03-28	1	\N	\N	\N	\N
4522	Presidente Nereu	4214102	SC	2022-03-28	1	\N	\N	\N	\N
4523	Princesa	4214151	SC	2022-03-28	1	\N	\N	\N	\N
4524	Quilombo	4214201	SC	2022-03-28	1	\N	\N	\N	\N
4525	Rancho Queimado	4214300	SC	2022-03-28	1	\N	\N	\N	\N
4526	Rio das Antas	4214409	SC	2022-03-28	1	\N	\N	\N	\N
4527	Rio do Campo	4214508	SC	2022-03-28	1	\N	\N	\N	\N
4528	Rio do Oeste	4214607	SC	2022-03-28	1	\N	\N	\N	\N
4529	Rio do Sul	4214805	SC	2022-03-28	1	\N	\N	\N	\N
4530	Rio dos Cedros	4214706	SC	2022-03-28	1	\N	\N	\N	\N
4531	Rio Fortuna	4214904	SC	2022-03-28	1	\N	\N	\N	\N
4532	Rio Negrinho	4215000	SC	2022-03-28	1	\N	\N	\N	\N
4533	Rio Rufino	4215059	SC	2022-03-28	1	\N	\N	\N	\N
4534	Riqueza	4215075	SC	2022-03-28	1	\N	\N	\N	\N
4535	Rodeio	4215109	SC	2022-03-28	1	\N	\N	\N	\N
4536	Romelândia	4215208	SC	2022-03-28	1	\N	\N	\N	\N
4537	Salete	4215307	SC	2022-03-28	1	\N	\N	\N	\N
4538	Saltinho	4215356	SC	2022-03-28	1	\N	\N	\N	\N
4539	Salto Veloso	4215406	SC	2022-03-28	1	\N	\N	\N	\N
4540	Sangão	4215455	SC	2022-03-28	1	\N	\N	\N	\N
4541	Santa Cecília	4215505	SC	2022-03-28	1	\N	\N	\N	\N
4542	Santa Helena	4215554	SC	2022-03-28	1	\N	\N	\N	\N
4543	Santa Rosa de Lima	4215604	SC	2022-03-28	1	\N	\N	\N	\N
4544	Santa Rosa do Sul	4215653	SC	2022-03-28	1	\N	\N	\N	\N
4545	Santa Terezinha	4215679	SC	2022-03-28	1	\N	\N	\N	\N
4546	Santa Terezinha do Progresso	4215687	SC	2022-03-28	1	\N	\N	\N	\N
4547	Santiago do Sul	4215695	SC	2022-03-28	1	\N	\N	\N	\N
4548	Santo Amaro da Imperatriz	4215703	SC	2022-03-28	1	\N	\N	\N	\N
4549	São Bento do Sul	4215802	SC	2022-03-28	1	\N	\N	\N	\N
4550	São Bernardino	4215752	SC	2022-03-28	1	\N	\N	\N	\N
4551	São Bonifácio	4215901	SC	2022-03-28	1	\N	\N	\N	\N
4552	São Carlos	4216008	SC	2022-03-28	1	\N	\N	\N	\N
4553	São Cristóvão do Sul	4216057	SC	2022-03-28	1	\N	\N	\N	\N
4554	São Domingos	4216107	SC	2022-03-28	1	\N	\N	\N	\N
4555	São Francisco do Sul	4216206	SC	2022-03-28	1	\N	\N	\N	\N
4556	São João Batista	4216305	SC	2022-03-28	1	\N	\N	\N	\N
4557	São João do Itaperiú	4216354	SC	2022-03-28	1	\N	\N	\N	\N
4558	São João do Oeste	4216255	SC	2022-03-28	1	\N	\N	\N	\N
4559	São João do Sul	4216404	SC	2022-03-28	1	\N	\N	\N	\N
4560	São Joaquim	4216503	SC	2022-03-28	1	\N	\N	\N	\N
4561	São José	4216602	SC	2022-03-28	1	\N	\N	\N	\N
4562	São José do Cedro	4216701	SC	2022-03-28	1	\N	\N	\N	\N
4563	São José do Cerrito	4216800	SC	2022-03-28	1	\N	\N	\N	\N
4564	São Lourenço do Oeste	4216909	SC	2022-03-28	1	\N	\N	\N	\N
4565	São Ludgero	4217006	SC	2022-03-28	1	\N	\N	\N	\N
4566	São Martinho	4217105	SC	2022-03-28	1	\N	\N	\N	\N
4567	São Miguel da Boa Vista	4217154	SC	2022-03-28	1	\N	\N	\N	\N
4568	São Miguel do Oeste	4217204	SC	2022-03-28	1	\N	\N	\N	\N
4569	São Pedro de Alcântara	4217253	SC	2022-03-28	1	\N	\N	\N	\N
4570	Saudades	4217303	SC	2022-03-28	1	\N	\N	\N	\N
4571	Schroeder	4217402	SC	2022-03-28	1	\N	\N	\N	\N
4572	Seara	4217501	SC	2022-03-28	1	\N	\N	\N	\N
4573	Serra Alta	4217550	SC	2022-03-28	1	\N	\N	\N	\N
4574	Siderópolis	4217600	SC	2022-03-28	1	\N	\N	\N	\N
4575	Sombrio	4217709	SC	2022-03-28	1	\N	\N	\N	\N
4576	Sul Brasil	4217758	SC	2022-03-28	1	\N	\N	\N	\N
4577	Taió	4217808	SC	2022-03-28	1	\N	\N	\N	\N
4578	Tangará	4217907	SC	2022-03-28	1	\N	\N	\N	\N
4579	Tigrinhos	4217956	SC	2022-03-28	1	\N	\N	\N	\N
4580	Tijucas	4218004	SC	2022-03-28	1	\N	\N	\N	\N
4581	Timbé do Sul	4218103	SC	2022-03-28	1	\N	\N	\N	\N
4582	Timbó	4218202	SC	2022-03-28	1	\N	\N	\N	\N
4583	Timbó Grande	4218251	SC	2022-03-28	1	\N	\N	\N	\N
4584	Três Barras	4218301	SC	2022-03-28	1	\N	\N	\N	\N
4585	Treviso	4218350	SC	2022-03-28	1	\N	\N	\N	\N
4586	Treze de Maio	4218400	SC	2022-03-28	1	\N	\N	\N	\N
4587	Treze Tílias	4218509	SC	2022-03-28	1	\N	\N	\N	\N
4588	Trombudo Central	4218608	SC	2022-03-28	1	\N	\N	\N	\N
4589	Tubarão	4218707	SC	2022-03-28	1	\N	\N	\N	\N
4590	Tunápolis	4218756	SC	2022-03-28	1	\N	\N	\N	\N
4591	Turvo	4218806	SC	2022-03-28	1	\N	\N	\N	\N
4592	União do Oeste	4218855	SC	2022-03-28	1	\N	\N	\N	\N
4593	Urubici	4218905	SC	2022-03-28	1	\N	\N	\N	\N
4594	Urupema	4218954	SC	2022-03-28	1	\N	\N	\N	\N
4595	Urussanga	4219002	SC	2022-03-28	1	\N	\N	\N	\N
4596	Vargeão	4219101	SC	2022-03-28	1	\N	\N	\N	\N
4597	Vargem	4219150	SC	2022-03-28	1	\N	\N	\N	\N
4598	Vargem Bonita	4219176	SC	2022-03-28	1	\N	\N	\N	\N
4599	Vidal Ramos	4219200	SC	2022-03-28	1	\N	\N	\N	\N
4600	Videira	4219309	SC	2022-03-28	1	\N	\N	\N	\N
4601	Vitor Meireles	4219358	SC	2022-03-28	1	\N	\N	\N	\N
4602	Witmarsum	4219408	SC	2022-03-28	1	\N	\N	\N	\N
4603	Xanxerê	4219507	SC	2022-03-28	1	\N	\N	\N	\N
4604	Xavantina	4219606	SC	2022-03-28	1	\N	\N	\N	\N
4605	Xaxim	4219705	SC	2022-03-28	1	\N	\N	\N	\N
4606	Zortéa	4219853	SC	2022-03-28	1	\N	\N	\N	\N
4607	Aceguá	4300034	RS	2022-03-28	1	\N	\N	\N	\N
4608	Água Santa	4300059	RS	2022-03-28	1	\N	\N	\N	\N
4609	Agudo	4300109	RS	2022-03-28	1	\N	\N	\N	\N
4610	Ajuricaba	4300208	RS	2022-03-28	1	\N	\N	\N	\N
4611	Alecrim	4300307	RS	2022-03-28	1	\N	\N	\N	\N
4612	Alegrete	4300406	RS	2022-03-28	1	\N	\N	\N	\N
4613	Alegria	4300455	RS	2022-03-28	1	\N	\N	\N	\N
4614	Almirante Tamandaré do Sul	4300471	RS	2022-03-28	1	\N	\N	\N	\N
4615	Alpestre	4300505	RS	2022-03-28	1	\N	\N	\N	\N
4616	Alto Alegre	4300554	RS	2022-03-28	1	\N	\N	\N	\N
4617	Alto Feliz	4300570	RS	2022-03-28	1	\N	\N	\N	\N
4618	Alvorada	4300604	RS	2022-03-28	1	\N	\N	\N	\N
4619	Amaral Ferrador	4300638	RS	2022-03-28	1	\N	\N	\N	\N
4620	Ametista do Sul	4300646	RS	2022-03-28	1	\N	\N	\N	\N
4621	André da Rocha	4300661	RS	2022-03-28	1	\N	\N	\N	\N
4622	Anta Gorda	4300703	RS	2022-03-28	1	\N	\N	\N	\N
4623	Antônio Prado	4300802	RS	2022-03-28	1	\N	\N	\N	\N
4624	Arambaré	4300851	RS	2022-03-28	1	\N	\N	\N	\N
4625	Araricá	4300877	RS	2022-03-28	1	\N	\N	\N	\N
4626	Aratiba	4300901	RS	2022-03-28	1	\N	\N	\N	\N
4627	Arroio do Meio	4301008	RS	2022-03-28	1	\N	\N	\N	\N
4628	Arroio do Padre	4301073	RS	2022-03-28	1	\N	\N	\N	\N
4629	Arroio do Sal	4301057	RS	2022-03-28	1	\N	\N	\N	\N
4630	Arroio do Tigre	4301206	RS	2022-03-28	1	\N	\N	\N	\N
4631	Arroio dos Ratos	4301107	RS	2022-03-28	1	\N	\N	\N	\N
4632	Arroio Grande	4301305	RS	2022-03-28	1	\N	\N	\N	\N
4633	Arvorezinha	4301404	RS	2022-03-28	1	\N	\N	\N	\N
4634	Augusto Pestana	4301503	RS	2022-03-28	1	\N	\N	\N	\N
4635	Áurea	4301552	RS	2022-03-28	1	\N	\N	\N	\N
4636	Bagé	4301602	RS	2022-03-28	1	\N	\N	\N	\N
4637	Balneário Pinhal	4301636	RS	2022-03-28	1	\N	\N	\N	\N
4638	Barão	4301651	RS	2022-03-28	1	\N	\N	\N	\N
4639	Barão de Cotegipe	4301701	RS	2022-03-28	1	\N	\N	\N	\N
4640	Barão do Triunfo	4301750	RS	2022-03-28	1	\N	\N	\N	\N
4641	Barra do Guarita	4301859	RS	2022-03-28	1	\N	\N	\N	\N
4642	Barra do Quaraí	4301875	RS	2022-03-28	1	\N	\N	\N	\N
4643	Barra do Ribeiro	4301909	RS	2022-03-28	1	\N	\N	\N	\N
4644	Barra do Rio Azul	4301925	RS	2022-03-28	1	\N	\N	\N	\N
4645	Barra Funda	4301958	RS	2022-03-28	1	\N	\N	\N	\N
4646	Barracão	4301800	RS	2022-03-28	1	\N	\N	\N	\N
4647	Barros Cassal	4302006	RS	2022-03-28	1	\N	\N	\N	\N
4648	Benjamin Constant do Sul	4302055	RS	2022-03-28	1	\N	\N	\N	\N
4649	Bento Gonçalves	4302105	RS	2022-03-28	1	\N	\N	\N	\N
4650	Boa Vista das Missões	4302154	RS	2022-03-28	1	\N	\N	\N	\N
4651	Boa Vista do Buricá	4302204	RS	2022-03-28	1	\N	\N	\N	\N
4652	Boa Vista do Cadeado	4302220	RS	2022-03-28	1	\N	\N	\N	\N
4653	Boa Vista do Incra	4302238	RS	2022-03-28	1	\N	\N	\N	\N
4654	Boa Vista do Sul	4302253	RS	2022-03-28	1	\N	\N	\N	\N
4655	Bom Jesus	4302303	RS	2022-03-28	1	\N	\N	\N	\N
4656	Bom Princípio	4302352	RS	2022-03-28	1	\N	\N	\N	\N
4657	Bom Progresso	4302378	RS	2022-03-28	1	\N	\N	\N	\N
4658	Bom Retiro do Sul	4302402	RS	2022-03-28	1	\N	\N	\N	\N
4659	Boqueirão do Leão	4302451	RS	2022-03-28	1	\N	\N	\N	\N
4660	Bossoroca	4302501	RS	2022-03-28	1	\N	\N	\N	\N
4661	Bozano	4302584	RS	2022-03-28	1	\N	\N	\N	\N
4662	Braga	4302600	RS	2022-03-28	1	\N	\N	\N	\N
4663	Brochier	4302659	RS	2022-03-28	1	\N	\N	\N	\N
4664	Butiá	4302709	RS	2022-03-28	1	\N	\N	\N	\N
4665	Caçapava do Sul	4302808	RS	2022-03-28	1	\N	\N	\N	\N
4666	Cacequi	4302907	RS	2022-03-28	1	\N	\N	\N	\N
4667	Cachoeira do Sul	4303004	RS	2022-03-28	1	\N	\N	\N	\N
4668	Cachoeirinha	4303103	RS	2022-03-28	1	\N	\N	\N	\N
4669	Cacique Doble	4303202	RS	2022-03-28	1	\N	\N	\N	\N
4670	Caibaté	4303301	RS	2022-03-28	1	\N	\N	\N	\N
4671	Caiçara	4303400	RS	2022-03-28	1	\N	\N	\N	\N
4672	Camaquã	4303509	RS	2022-03-28	1	\N	\N	\N	\N
4673	Camargo	4303558	RS	2022-03-28	1	\N	\N	\N	\N
4674	Cambará do Sul	4303608	RS	2022-03-28	1	\N	\N	\N	\N
4675	Campestre da Serra	4303673	RS	2022-03-28	1	\N	\N	\N	\N
4676	Campina das Missões	4303707	RS	2022-03-28	1	\N	\N	\N	\N
4677	Campinas do Sul	4303806	RS	2022-03-28	1	\N	\N	\N	\N
4678	Campo Bom	4303905	RS	2022-03-28	1	\N	\N	\N	\N
4679	Campo Novo	4304002	RS	2022-03-28	1	\N	\N	\N	\N
4680	Campos Borges	4304101	RS	2022-03-28	1	\N	\N	\N	\N
4681	Candelária	4304200	RS	2022-03-28	1	\N	\N	\N	\N
4682	Cândido Godói	4304309	RS	2022-03-28	1	\N	\N	\N	\N
4683	Candiota	4304358	RS	2022-03-28	1	\N	\N	\N	\N
4684	Canela	4304408	RS	2022-03-28	1	\N	\N	\N	\N
4685	Canguçu	4304507	RS	2022-03-28	1	\N	\N	\N	\N
4686	Canoas	4304606	RS	2022-03-28	1	\N	\N	\N	\N
4687	Canudos do Vale	4304614	RS	2022-03-28	1	\N	\N	\N	\N
4688	Capão Bonito do Sul	4304622	RS	2022-03-28	1	\N	\N	\N	\N
4689	Capão da Canoa	4304630	RS	2022-03-28	1	\N	\N	\N	\N
4690	Capão do Cipó	4304655	RS	2022-03-28	1	\N	\N	\N	\N
4691	Capão do Leão	4304663	RS	2022-03-28	1	\N	\N	\N	\N
4692	Capela de Santana	4304689	RS	2022-03-28	1	\N	\N	\N	\N
4693	Capitão	4304697	RS	2022-03-28	1	\N	\N	\N	\N
4694	Capivari do Sul	4304671	RS	2022-03-28	1	\N	\N	\N	\N
4695	Caraá	4304713	RS	2022-03-28	1	\N	\N	\N	\N
4696	Carazinho	4304705	RS	2022-03-28	1	\N	\N	\N	\N
4697	Carlos Barbosa	4304804	RS	2022-03-28	1	\N	\N	\N	\N
4698	Carlos Gomes	4304853	RS	2022-03-28	1	\N	\N	\N	\N
4699	Casca	4304903	RS	2022-03-28	1	\N	\N	\N	\N
4700	Caseiros	4304952	RS	2022-03-28	1	\N	\N	\N	\N
4701	Catuípe	4305009	RS	2022-03-28	1	\N	\N	\N	\N
4702	Caxias do Sul	4305108	RS	2022-03-28	1	\N	\N	\N	\N
4703	Centenário	4305116	RS	2022-03-28	1	\N	\N	\N	\N
4704	Cerrito	4305124	RS	2022-03-28	1	\N	\N	\N	\N
4705	Cerro Branco	4305132	RS	2022-03-28	1	\N	\N	\N	\N
4706	Cerro Grande	4305157	RS	2022-03-28	1	\N	\N	\N	\N
4707	Cerro Grande do Sul	4305173	RS	2022-03-28	1	\N	\N	\N	\N
4708	Cerro Largo	4305207	RS	2022-03-28	1	\N	\N	\N	\N
4709	Chapada	4305306	RS	2022-03-28	1	\N	\N	\N	\N
4710	Charqueadas	4305355	RS	2022-03-28	1	\N	\N	\N	\N
4711	Charrua	4305371	RS	2022-03-28	1	\N	\N	\N	\N
4712	Chiapetta	4305405	RS	2022-03-28	1	\N	\N	\N	\N
4713	Chuí	4305439	RS	2022-03-28	1	\N	\N	\N	\N
4714	Chuvisca	4305447	RS	2022-03-28	1	\N	\N	\N	\N
4715	Cidreira	4305454	RS	2022-03-28	1	\N	\N	\N	\N
4716	Ciríaco	4305504	RS	2022-03-28	1	\N	\N	\N	\N
4717	Colinas	4305587	RS	2022-03-28	1	\N	\N	\N	\N
4718	Colorado	4305603	RS	2022-03-28	1	\N	\N	\N	\N
4719	Condor	4305702	RS	2022-03-28	1	\N	\N	\N	\N
4720	Constantina	4305801	RS	2022-03-28	1	\N	\N	\N	\N
4721	Coqueiro Baixo	4305835	RS	2022-03-28	1	\N	\N	\N	\N
4722	Coqueiros do Sul	4305850	RS	2022-03-28	1	\N	\N	\N	\N
4723	Coronel Barros	4305871	RS	2022-03-28	1	\N	\N	\N	\N
4724	Coronel Bicaco	4305900	RS	2022-03-28	1	\N	\N	\N	\N
4725	Coronel Pilar	4305934	RS	2022-03-28	1	\N	\N	\N	\N
4726	Cotiporã	4305959	RS	2022-03-28	1	\N	\N	\N	\N
4727	Coxilha	4305975	RS	2022-03-28	1	\N	\N	\N	\N
4728	Crissiumal	4306007	RS	2022-03-28	1	\N	\N	\N	\N
4729	Cristal	4306056	RS	2022-03-28	1	\N	\N	\N	\N
4730	Cristal do Sul	4306072	RS	2022-03-28	1	\N	\N	\N	\N
4731	Cruz Alta	4306106	RS	2022-03-28	1	\N	\N	\N	\N
4732	Cruzaltense	4306130	RS	2022-03-28	1	\N	\N	\N	\N
4733	Cruzeiro do Sul	4306205	RS	2022-03-28	1	\N	\N	\N	\N
4734	David Canabarro	4306304	RS	2022-03-28	1	\N	\N	\N	\N
4735	Derrubadas	4306320	RS	2022-03-28	1	\N	\N	\N	\N
4736	Dezesseis de Novembro	4306353	RS	2022-03-28	1	\N	\N	\N	\N
4737	Dilermando de Aguiar	4306379	RS	2022-03-28	1	\N	\N	\N	\N
4738	Dois Irmãos	4306403	RS	2022-03-28	1	\N	\N	\N	\N
4739	Dois Irmãos das Missões	4306429	RS	2022-03-28	1	\N	\N	\N	\N
4740	Dois Lajeados	4306452	RS	2022-03-28	1	\N	\N	\N	\N
4741	Dom Feliciano	4306502	RS	2022-03-28	1	\N	\N	\N	\N
4742	Dom Pedrito	4306601	RS	2022-03-28	1	\N	\N	\N	\N
4743	Dom Pedro de Alcântara	4306551	RS	2022-03-28	1	\N	\N	\N	\N
4744	Dona Francisca	4306700	RS	2022-03-28	1	\N	\N	\N	\N
4745	Doutor Maurício Cardoso	4306734	RS	2022-03-28	1	\N	\N	\N	\N
4746	Doutor Ricardo	4306759	RS	2022-03-28	1	\N	\N	\N	\N
4747	Eldorado do Sul	4306767	RS	2022-03-28	1	\N	\N	\N	\N
4748	Encantado	4306809	RS	2022-03-28	1	\N	\N	\N	\N
4749	Encruzilhada do Sul	4306908	RS	2022-03-28	1	\N	\N	\N	\N
4750	Engenho Velho	4306924	RS	2022-03-28	1	\N	\N	\N	\N
4751	Entre Rios do Sul	4306957	RS	2022-03-28	1	\N	\N	\N	\N
4752	Entre-Ijuís	4306932	RS	2022-03-28	1	\N	\N	\N	\N
4753	Erebango	4306973	RS	2022-03-28	1	\N	\N	\N	\N
4754	Erechim	4307005	RS	2022-03-28	1	\N	\N	\N	\N
4755	Ernestina	4307054	RS	2022-03-28	1	\N	\N	\N	\N
4756	Erval Grande	4307203	RS	2022-03-28	1	\N	\N	\N	\N
4757	Erval Seco	4307302	RS	2022-03-28	1	\N	\N	\N	\N
4758	Esmeralda	4307401	RS	2022-03-28	1	\N	\N	\N	\N
4759	Esperança do Sul	4307450	RS	2022-03-28	1	\N	\N	\N	\N
4760	Espumoso	4307500	RS	2022-03-28	1	\N	\N	\N	\N
4761	Estação	4307559	RS	2022-03-28	1	\N	\N	\N	\N
4762	Estância Velha	4307609	RS	2022-03-28	1	\N	\N	\N	\N
4763	Esteio	4307708	RS	2022-03-28	1	\N	\N	\N	\N
4764	Estrela	4307807	RS	2022-03-28	1	\N	\N	\N	\N
4765	Estrela Velha	4307815	RS	2022-03-28	1	\N	\N	\N	\N
4766	Eugênio de Castro	4307831	RS	2022-03-28	1	\N	\N	\N	\N
4767	Fagundes Varela	4307864	RS	2022-03-28	1	\N	\N	\N	\N
4768	Farroupilha	4307906	RS	2022-03-28	1	\N	\N	\N	\N
4769	Faxinal do Soturno	4308003	RS	2022-03-28	1	\N	\N	\N	\N
4770	Faxinalzinho	4308052	RS	2022-03-28	1	\N	\N	\N	\N
4771	Fazenda Vilanova	4308078	RS	2022-03-28	1	\N	\N	\N	\N
4772	Feliz	4308102	RS	2022-03-28	1	\N	\N	\N	\N
4773	Flores da Cunha	4308201	RS	2022-03-28	1	\N	\N	\N	\N
4774	Floriano Peixoto	4308250	RS	2022-03-28	1	\N	\N	\N	\N
4775	Fontoura Xavier	4308300	RS	2022-03-28	1	\N	\N	\N	\N
4776	Formigueiro	4308409	RS	2022-03-28	1	\N	\N	\N	\N
4777	Forquetinha	4308433	RS	2022-03-28	1	\N	\N	\N	\N
4778	Fortaleza dos Valos	4308458	RS	2022-03-28	1	\N	\N	\N	\N
4779	Frederico Westphalen	4308508	RS	2022-03-28	1	\N	\N	\N	\N
4780	Garibaldi	4308607	RS	2022-03-28	1	\N	\N	\N	\N
4781	Garruchos	4308656	RS	2022-03-28	1	\N	\N	\N	\N
4782	Gaurama	4308706	RS	2022-03-28	1	\N	\N	\N	\N
4783	General Câmara	4308805	RS	2022-03-28	1	\N	\N	\N	\N
4784	Gentil	4308854	RS	2022-03-28	1	\N	\N	\N	\N
4785	Getúlio Vargas	4308904	RS	2022-03-28	1	\N	\N	\N	\N
4786	Giruá	4309001	RS	2022-03-28	1	\N	\N	\N	\N
4787	Glorinha	4309050	RS	2022-03-28	1	\N	\N	\N	\N
4788	Gramado	4309100	RS	2022-03-28	1	\N	\N	\N	\N
4789	Gramado dos Loureiros	4309126	RS	2022-03-28	1	\N	\N	\N	\N
4790	Gramado Xavier	4309159	RS	2022-03-28	1	\N	\N	\N	\N
4791	Gravataí	4309209	RS	2022-03-28	1	\N	\N	\N	\N
4792	Guabiju	4309258	RS	2022-03-28	1	\N	\N	\N	\N
4793	Guaíba	4309308	RS	2022-03-28	1	\N	\N	\N	\N
4794	Guaporé	4309407	RS	2022-03-28	1	\N	\N	\N	\N
4795	Guarani das Missões	4309506	RS	2022-03-28	1	\N	\N	\N	\N
4796	Harmonia	4309555	RS	2022-03-28	1	\N	\N	\N	\N
4797	Herval	4307104	RS	2022-03-28	1	\N	\N	\N	\N
4798	Herveiras	4309571	RS	2022-03-28	1	\N	\N	\N	\N
4799	Horizontina	4309605	RS	2022-03-28	1	\N	\N	\N	\N
4800	Hulha Negra	4309654	RS	2022-03-28	1	\N	\N	\N	\N
4801	Humaitá	4309704	RS	2022-03-28	1	\N	\N	\N	\N
4802	Ibarama	4309753	RS	2022-03-28	1	\N	\N	\N	\N
4803	Ibiaçá	4309803	RS	2022-03-28	1	\N	\N	\N	\N
4804	Ibiraiaras	4309902	RS	2022-03-28	1	\N	\N	\N	\N
4805	Ibirapuitã	4309951	RS	2022-03-28	1	\N	\N	\N	\N
4806	Ibirubá	4310009	RS	2022-03-28	1	\N	\N	\N	\N
4807	Igrejinha	4310108	RS	2022-03-28	1	\N	\N	\N	\N
4808	Ijuí	4310207	RS	2022-03-28	1	\N	\N	\N	\N
4809	Ilópolis	4310306	RS	2022-03-28	1	\N	\N	\N	\N
4810	Imbé	4310330	RS	2022-03-28	1	\N	\N	\N	\N
4811	Imigrante	4310363	RS	2022-03-28	1	\N	\N	\N	\N
4812	Independência	4310405	RS	2022-03-28	1	\N	\N	\N	\N
4813	Inhacorá	4310413	RS	2022-03-28	1	\N	\N	\N	\N
4814	Ipê	4310439	RS	2022-03-28	1	\N	\N	\N	\N
4815	Ipiranga do Sul	4310462	RS	2022-03-28	1	\N	\N	\N	\N
4816	Iraí	4310504	RS	2022-03-28	1	\N	\N	\N	\N
4817	Itaara	4310538	RS	2022-03-28	1	\N	\N	\N	\N
4818	Itacurubi	4310553	RS	2022-03-28	1	\N	\N	\N	\N
4819	Itapuca	4310579	RS	2022-03-28	1	\N	\N	\N	\N
4820	Itaqui	4310603	RS	2022-03-28	1	\N	\N	\N	\N
4821	Itati	4310652	RS	2022-03-28	1	\N	\N	\N	\N
4822	Itatiba do Sul	4310702	RS	2022-03-28	1	\N	\N	\N	\N
4823	Ivorá	4310751	RS	2022-03-28	1	\N	\N	\N	\N
4824	Ivoti	4310801	RS	2022-03-28	1	\N	\N	\N	\N
4825	Jaboticaba	4310850	RS	2022-03-28	1	\N	\N	\N	\N
4826	Jacuizinho	4310876	RS	2022-03-28	1	\N	\N	\N	\N
4827	Jacutinga	4310900	RS	2022-03-28	1	\N	\N	\N	\N
4828	Jaguarão	4311007	RS	2022-03-28	1	\N	\N	\N	\N
4829	Jaguari	4311106	RS	2022-03-28	1	\N	\N	\N	\N
4830	Jaquirana	4311122	RS	2022-03-28	1	\N	\N	\N	\N
4831	Jari	4311130	RS	2022-03-28	1	\N	\N	\N	\N
4832	Jóia	4311155	RS	2022-03-28	1	\N	\N	\N	\N
4833	Júlio de Castilhos	4311205	RS	2022-03-28	1	\N	\N	\N	\N
4834	Lagoa Bonita do Sul	4311239	RS	2022-03-28	1	\N	\N	\N	\N
4835	Lagoa dos Três Cantos	4311270	RS	2022-03-28	1	\N	\N	\N	\N
4836	Lagoa Vermelha	4311304	RS	2022-03-28	1	\N	\N	\N	\N
4837	Lagoão	4311254	RS	2022-03-28	1	\N	\N	\N	\N
4838	Lajeado	4311403	RS	2022-03-28	1	\N	\N	\N	\N
4839	Lajeado do Bugre	4311429	RS	2022-03-28	1	\N	\N	\N	\N
4840	Lavras do Sul	4311502	RS	2022-03-28	1	\N	\N	\N	\N
4841	Liberato Salzano	4311601	RS	2022-03-28	1	\N	\N	\N	\N
4842	Lindolfo Collor	4311627	RS	2022-03-28	1	\N	\N	\N	\N
4843	Linha Nova	4311643	RS	2022-03-28	1	\N	\N	\N	\N
4844	Maçambará	4311718	RS	2022-03-28	1	\N	\N	\N	\N
4845	Machadinho	4311700	RS	2022-03-28	1	\N	\N	\N	\N
4846	Mampituba	4311734	RS	2022-03-28	1	\N	\N	\N	\N
4847	Manoel Viana	4311759	RS	2022-03-28	1	\N	\N	\N	\N
4848	Maquiné	4311775	RS	2022-03-28	1	\N	\N	\N	\N
4849	Maratá	4311791	RS	2022-03-28	1	\N	\N	\N	\N
4850	Marau	4311809	RS	2022-03-28	1	\N	\N	\N	\N
4851	Marcelino Ramos	4311908	RS	2022-03-28	1	\N	\N	\N	\N
4852	Mariana Pimentel	4311981	RS	2022-03-28	1	\N	\N	\N	\N
4853	Mariano Moro	4312005	RS	2022-03-28	1	\N	\N	\N	\N
4854	Marques de Souza	4312054	RS	2022-03-28	1	\N	\N	\N	\N
4855	Mata	4312104	RS	2022-03-28	1	\N	\N	\N	\N
4856	Mato Castelhano	4312138	RS	2022-03-28	1	\N	\N	\N	\N
4857	Mato Leitão	4312153	RS	2022-03-28	1	\N	\N	\N	\N
4858	Mato Queimado	4312179	RS	2022-03-28	1	\N	\N	\N	\N
4859	Maximiliano de Almeida	4312203	RS	2022-03-28	1	\N	\N	\N	\N
4860	Minas do Leão	4312252	RS	2022-03-28	1	\N	\N	\N	\N
4861	Miraguaí	4312302	RS	2022-03-28	1	\N	\N	\N	\N
4862	Montauri	4312351	RS	2022-03-28	1	\N	\N	\N	\N
4863	Monte Alegre dos Campos	4312377	RS	2022-03-28	1	\N	\N	\N	\N
4864	Monte Belo do Sul	4312385	RS	2022-03-28	1	\N	\N	\N	\N
4865	Montenegro	4312401	RS	2022-03-28	1	\N	\N	\N	\N
4866	Mormaço	4312427	RS	2022-03-28	1	\N	\N	\N	\N
4867	Morrinhos do Sul	4312443	RS	2022-03-28	1	\N	\N	\N	\N
4868	Morro Redondo	4312450	RS	2022-03-28	1	\N	\N	\N	\N
4869	Morro Reuter	4312476	RS	2022-03-28	1	\N	\N	\N	\N
4870	Mostardas	4312500	RS	2022-03-28	1	\N	\N	\N	\N
4871	Muçum	4312609	RS	2022-03-28	1	\N	\N	\N	\N
4872	Muitos Capões	4312617	RS	2022-03-28	1	\N	\N	\N	\N
4873	Muliterno	4312625	RS	2022-03-28	1	\N	\N	\N	\N
4874	Não-Me-Toque	4312658	RS	2022-03-28	1	\N	\N	\N	\N
4875	Nicolau Vergueiro	4312674	RS	2022-03-28	1	\N	\N	\N	\N
4876	Nonoai	4312708	RS	2022-03-28	1	\N	\N	\N	\N
4877	Nova Alvorada	4312757	RS	2022-03-28	1	\N	\N	\N	\N
4878	Nova Araçá	4312807	RS	2022-03-28	1	\N	\N	\N	\N
4879	Nova Bassano	4312906	RS	2022-03-28	1	\N	\N	\N	\N
4880	Nova Boa Vista	4312955	RS	2022-03-28	1	\N	\N	\N	\N
4881	Nova Bréscia	4313003	RS	2022-03-28	1	\N	\N	\N	\N
4882	Nova Candelária	4313011	RS	2022-03-28	1	\N	\N	\N	\N
4883	Nova Esperança do Sul	4313037	RS	2022-03-28	1	\N	\N	\N	\N
4884	Nova Hartz	4313060	RS	2022-03-28	1	\N	\N	\N	\N
4885	Nova Pádua	4313086	RS	2022-03-28	1	\N	\N	\N	\N
4886	Nova Palma	4313102	RS	2022-03-28	1	\N	\N	\N	\N
4887	Nova Petrópolis	4313201	RS	2022-03-28	1	\N	\N	\N	\N
4888	Nova Prata	4313300	RS	2022-03-28	1	\N	\N	\N	\N
4889	Nova Ramada	4313334	RS	2022-03-28	1	\N	\N	\N	\N
4890	Nova Roma do Sul	4313359	RS	2022-03-28	1	\N	\N	\N	\N
4891	Nova Santa Rita	4313375	RS	2022-03-28	1	\N	\N	\N	\N
4892	Novo Barreiro	4313490	RS	2022-03-28	1	\N	\N	\N	\N
4893	Novo Cabrais	4313391	RS	2022-03-28	1	\N	\N	\N	\N
4894	Novo Hamburgo	4313409	RS	2022-03-28	1	\N	\N	\N	\N
4895	Novo Machado	4313425	RS	2022-03-28	1	\N	\N	\N	\N
4896	Novo Tiradentes	4313441	RS	2022-03-28	1	\N	\N	\N	\N
4897	Novo Xingu	4313466	RS	2022-03-28	1	\N	\N	\N	\N
4898	Osório	4313508	RS	2022-03-28	1	\N	\N	\N	\N
4899	Paim Filho	4313607	RS	2022-03-28	1	\N	\N	\N	\N
4900	Palmares do Sul	4313656	RS	2022-03-28	1	\N	\N	\N	\N
4901	Palmeira das Missões	4313706	RS	2022-03-28	1	\N	\N	\N	\N
4902	Palmitinho	4313805	RS	2022-03-28	1	\N	\N	\N	\N
4903	Panambi	4313904	RS	2022-03-28	1	\N	\N	\N	\N
4904	Pantano Grande	4313953	RS	2022-03-28	1	\N	\N	\N	\N
4905	Paraí	4314001	RS	2022-03-28	1	\N	\N	\N	\N
4906	Paraíso do Sul	4314027	RS	2022-03-28	1	\N	\N	\N	\N
4907	Pareci Novo	4314035	RS	2022-03-28	1	\N	\N	\N	\N
4908	Parobé	4314050	RS	2022-03-28	1	\N	\N	\N	\N
4909	Passa Sete	4314068	RS	2022-03-28	1	\N	\N	\N	\N
4910	Passo do Sobrado	4314076	RS	2022-03-28	1	\N	\N	\N	\N
4911	Passo Fundo	4314100	RS	2022-03-28	1	\N	\N	\N	\N
4912	Paulo Bento	4314134	RS	2022-03-28	1	\N	\N	\N	\N
4913	Paverama	4314159	RS	2022-03-28	1	\N	\N	\N	\N
4914	Pedras Altas	4314175	RS	2022-03-28	1	\N	\N	\N	\N
4915	Pedro Osório	4314209	RS	2022-03-28	1	\N	\N	\N	\N
4916	Pejuçara	4314308	RS	2022-03-28	1	\N	\N	\N	\N
4917	Pelotas	4314407	RS	2022-03-28	1	\N	\N	\N	\N
4918	Picada Café	4314423	RS	2022-03-28	1	\N	\N	\N	\N
4919	Pinhal	4314456	RS	2022-03-28	1	\N	\N	\N	\N
4920	Pinhal da Serra	4314464	RS	2022-03-28	1	\N	\N	\N	\N
4921	Pinhal Grande	4314472	RS	2022-03-28	1	\N	\N	\N	\N
4922	Pinheirinho do Vale	4314498	RS	2022-03-28	1	\N	\N	\N	\N
4923	Pinheiro Machado	4314506	RS	2022-03-28	1	\N	\N	\N	\N
4924	Pinto Bandeira	4314548	RS	2022-03-28	1	\N	\N	\N	\N
4925	Pirapó	4314555	RS	2022-03-28	1	\N	\N	\N	\N
4926	Piratini	4314605	RS	2022-03-28	1	\N	\N	\N	\N
4927	Planalto	4314704	RS	2022-03-28	1	\N	\N	\N	\N
4928	Poço das Antas	4314753	RS	2022-03-28	1	\N	\N	\N	\N
4929	Pontão	4314779	RS	2022-03-28	1	\N	\N	\N	\N
4930	Ponte Preta	4314787	RS	2022-03-28	1	\N	\N	\N	\N
4931	Portão	4314803	RS	2022-03-28	1	\N	\N	\N	\N
4932	Porto Alegre	4314902	RS	2022-03-28	1	\N	\N	\N	\N
4933	Porto Lucena	4315008	RS	2022-03-28	1	\N	\N	\N	\N
4934	Porto Mauá	4315057	RS	2022-03-28	1	\N	\N	\N	\N
4935	Porto Vera Cruz	4315073	RS	2022-03-28	1	\N	\N	\N	\N
4936	Porto Xavier	4315107	RS	2022-03-28	1	\N	\N	\N	\N
4937	Pouso Novo	4315131	RS	2022-03-28	1	\N	\N	\N	\N
4938	Presidente Lucena	4315149	RS	2022-03-28	1	\N	\N	\N	\N
4939	Progresso	4315156	RS	2022-03-28	1	\N	\N	\N	\N
4940	Protásio Alves	4315172	RS	2022-03-28	1	\N	\N	\N	\N
4941	Putinga	4315206	RS	2022-03-28	1	\N	\N	\N	\N
4942	Quaraí	4315305	RS	2022-03-28	1	\N	\N	\N	\N
4943	Quatro Irmãos	4315313	RS	2022-03-28	1	\N	\N	\N	\N
4944	Quevedos	4315321	RS	2022-03-28	1	\N	\N	\N	\N
4945	Quinze de Novembro	4315354	RS	2022-03-28	1	\N	\N	\N	\N
4946	Redentora	4315404	RS	2022-03-28	1	\N	\N	\N	\N
4947	Relvado	4315453	RS	2022-03-28	1	\N	\N	\N	\N
4948	Restinga Sêca	4315503	RS	2022-03-28	1	\N	\N	\N	\N
4949	Rio dos Índios	4315552	RS	2022-03-28	1	\N	\N	\N	\N
4950	Rio Grande	4315602	RS	2022-03-28	1	\N	\N	\N	\N
4951	Rio Pardo	4315701	RS	2022-03-28	1	\N	\N	\N	\N
4952	Riozinho	4315750	RS	2022-03-28	1	\N	\N	\N	\N
4953	Roca Sales	4315800	RS	2022-03-28	1	\N	\N	\N	\N
4954	Rodeio Bonito	4315909	RS	2022-03-28	1	\N	\N	\N	\N
4955	Rolador	4315958	RS	2022-03-28	1	\N	\N	\N	\N
4956	Rolante	4316006	RS	2022-03-28	1	\N	\N	\N	\N
4957	Ronda Alta	4316105	RS	2022-03-28	1	\N	\N	\N	\N
4958	Rondinha	4316204	RS	2022-03-28	1	\N	\N	\N	\N
4959	Roque Gonzales	4316303	RS	2022-03-28	1	\N	\N	\N	\N
4960	Rosário do Sul	4316402	RS	2022-03-28	1	\N	\N	\N	\N
4961	Sagrada Família	4316428	RS	2022-03-28	1	\N	\N	\N	\N
4962	Saldanha Marinho	4316436	RS	2022-03-28	1	\N	\N	\N	\N
4963	Salto do Jacuí	4316451	RS	2022-03-28	1	\N	\N	\N	\N
4964	Salvador das Missões	4316477	RS	2022-03-28	1	\N	\N	\N	\N
4965	Salvador do Sul	4316501	RS	2022-03-28	1	\N	\N	\N	\N
4966	Sananduva	4316600	RS	2022-03-28	1	\N	\N	\N	\N
4967	Santa Bárbara do Sul	4316709	RS	2022-03-28	1	\N	\N	\N	\N
4968	Santa Cecília do Sul	4316733	RS	2022-03-28	1	\N	\N	\N	\N
4969	Santa Clara do Sul	4316758	RS	2022-03-28	1	\N	\N	\N	\N
4970	Santa Cruz do Sul	4316808	RS	2022-03-28	1	\N	\N	\N	\N
4971	Santa Margarida do Sul	4316972	RS	2022-03-28	1	\N	\N	\N	\N
4972	Santa Maria	4316907	RS	2022-03-28	1	\N	\N	\N	\N
4973	Santa Maria do Herval	4316956	RS	2022-03-28	1	\N	\N	\N	\N
4974	Santa Rosa	4317202	RS	2022-03-28	1	\N	\N	\N	\N
4975	Santa Tereza	4317251	RS	2022-03-28	1	\N	\N	\N	\N
4976	Santa Vitória do Palmar	4317301	RS	2022-03-28	1	\N	\N	\N	\N
4977	Santana da Boa Vista	4317004	RS	2022-03-28	1	\N	\N	\N	\N
4978	'Sant''Ana do Livramento'	4317103	RS	2022-03-28	1	\N	\N	\N	\N
4979	Santiago	4317400	RS	2022-03-28	1	\N	\N	\N	\N
4980	Santo Ângelo	4317509	RS	2022-03-28	1	\N	\N	\N	\N
4981	Santo Antônio da Patrulha	4317608	RS	2022-03-28	1	\N	\N	\N	\N
4982	Santo Antônio das Missões	4317707	RS	2022-03-28	1	\N	\N	\N	\N
4983	Santo Antônio do Palma	4317558	RS	2022-03-28	1	\N	\N	\N	\N
4984	Santo Antônio do Planalto	4317756	RS	2022-03-28	1	\N	\N	\N	\N
4985	Santo Augusto	4317806	RS	2022-03-28	1	\N	\N	\N	\N
4986	Santo Cristo	4317905	RS	2022-03-28	1	\N	\N	\N	\N
4987	Santo Expedito do Sul	4317954	RS	2022-03-28	1	\N	\N	\N	\N
4988	São Borja	4318002	RS	2022-03-28	1	\N	\N	\N	\N
4989	São Domingos do Sul	4318051	RS	2022-03-28	1	\N	\N	\N	\N
4990	São Francisco de Assis	4318101	RS	2022-03-28	1	\N	\N	\N	\N
4991	São Francisco de Paula	4318200	RS	2022-03-28	1	\N	\N	\N	\N
4992	São Gabriel	4318309	RS	2022-03-28	1	\N	\N	\N	\N
4993	São Jerônimo	4318408	RS	2022-03-28	1	\N	\N	\N	\N
4994	São João da Urtiga	4318424	RS	2022-03-28	1	\N	\N	\N	\N
4995	São João do Polêsine	4318432	RS	2022-03-28	1	\N	\N	\N	\N
4996	São Jorge	4318440	RS	2022-03-28	1	\N	\N	\N	\N
4997	São José das Missões	4318457	RS	2022-03-28	1	\N	\N	\N	\N
4998	São José do Herval	4318465	RS	2022-03-28	1	\N	\N	\N	\N
4999	São José do Hortêncio	4318481	RS	2022-03-28	1	\N	\N	\N	\N
5000	São José do Inhacorá	4318499	RS	2022-03-28	1	\N	\N	\N	\N
5001	São José do Norte	4318507	RS	2022-03-28	1	\N	\N	\N	\N
5002	São José do Ouro	4318606	RS	2022-03-28	1	\N	\N	\N	\N
5003	São José do Sul	4318614	RS	2022-03-28	1	\N	\N	\N	\N
5004	São José dos Ausentes	4318622	RS	2022-03-28	1	\N	\N	\N	\N
5005	São Leopoldo	4318705	RS	2022-03-28	1	\N	\N	\N	\N
5006	São Lourenço do Sul	4318804	RS	2022-03-28	1	\N	\N	\N	\N
5007	São Luiz Gonzaga	4318903	RS	2022-03-28	1	\N	\N	\N	\N
5008	São Marcos	4319000	RS	2022-03-28	1	\N	\N	\N	\N
5009	São Martinho	4319109	RS	2022-03-28	1	\N	\N	\N	\N
5010	São Martinho da Serra	4319125	RS	2022-03-28	1	\N	\N	\N	\N
5011	São Miguel das Missões	4319158	RS	2022-03-28	1	\N	\N	\N	\N
5012	São Nicolau	4319208	RS	2022-03-28	1	\N	\N	\N	\N
5013	São Paulo das Missões	4319307	RS	2022-03-28	1	\N	\N	\N	\N
5014	São Pedro da Serra	4319356	RS	2022-03-28	1	\N	\N	\N	\N
5015	São Pedro das Missões	4319364	RS	2022-03-28	1	\N	\N	\N	\N
5016	São Pedro do Butiá	4319372	RS	2022-03-28	1	\N	\N	\N	\N
5017	São Pedro do Sul	4319406	RS	2022-03-28	1	\N	\N	\N	\N
5018	São Sebastião do Caí	4319505	RS	2022-03-28	1	\N	\N	\N	\N
5019	São Sepé	4319604	RS	2022-03-28	1	\N	\N	\N	\N
5020	São Valentim	4319703	RS	2022-03-28	1	\N	\N	\N	\N
5021	São Valentim do Sul	4319711	RS	2022-03-28	1	\N	\N	\N	\N
5022	São Valério do Sul	4319737	RS	2022-03-28	1	\N	\N	\N	\N
5023	São Vendelino	4319752	RS	2022-03-28	1	\N	\N	\N	\N
5024	São Vicente do Sul	4319802	RS	2022-03-28	1	\N	\N	\N	\N
5025	Sapiranga	4319901	RS	2022-03-28	1	\N	\N	\N	\N
5026	Sapucaia do Sul	4320008	RS	2022-03-28	1	\N	\N	\N	\N
5027	Sarandi	4320107	RS	2022-03-28	1	\N	\N	\N	\N
5028	Seberi	4320206	RS	2022-03-28	1	\N	\N	\N	\N
5029	Sede Nova	4320230	RS	2022-03-28	1	\N	\N	\N	\N
5030	Segredo	4320263	RS	2022-03-28	1	\N	\N	\N	\N
5031	Selbach	4320305	RS	2022-03-28	1	\N	\N	\N	\N
5032	Senador Salgado Filho	4320321	RS	2022-03-28	1	\N	\N	\N	\N
5033	Sentinela do Sul	4320354	RS	2022-03-28	1	\N	\N	\N	\N
5034	Serafina Corrêa	4320404	RS	2022-03-28	1	\N	\N	\N	\N
5035	Sério	4320453	RS	2022-03-28	1	\N	\N	\N	\N
5036	Sertão	4320503	RS	2022-03-28	1	\N	\N	\N	\N
5037	Sertão Santana	4320552	RS	2022-03-28	1	\N	\N	\N	\N
5038	Sete de Setembro	4320578	RS	2022-03-28	1	\N	\N	\N	\N
5039	Severiano de Almeida	4320602	RS	2022-03-28	1	\N	\N	\N	\N
5040	Silveira Martins	4320651	RS	2022-03-28	1	\N	\N	\N	\N
5041	Sinimbu	4320677	RS	2022-03-28	1	\N	\N	\N	\N
5042	Sobradinho	4320701	RS	2022-03-28	1	\N	\N	\N	\N
5043	Soledade	4320800	RS	2022-03-28	1	\N	\N	\N	\N
5044	Tabaí	4320859	RS	2022-03-28	1	\N	\N	\N	\N
5045	Tapejara	4320909	RS	2022-03-28	1	\N	\N	\N	\N
5046	Tapera	4321006	RS	2022-03-28	1	\N	\N	\N	\N
5047	Tapes	4321105	RS	2022-03-28	1	\N	\N	\N	\N
5048	Taquara	4321204	RS	2022-03-28	1	\N	\N	\N	\N
5049	Taquari	4321303	RS	2022-03-28	1	\N	\N	\N	\N
5050	Taquaruçu do Sul	4321329	RS	2022-03-28	1	\N	\N	\N	\N
5051	Tavares	4321352	RS	2022-03-28	1	\N	\N	\N	\N
5052	Tenente Portela	4321402	RS	2022-03-28	1	\N	\N	\N	\N
5053	Terra de Areia	4321436	RS	2022-03-28	1	\N	\N	\N	\N
5054	Teutônia	4321451	RS	2022-03-28	1	\N	\N	\N	\N
5055	Tio Hugo	4321469	RS	2022-03-28	1	\N	\N	\N	\N
5056	Tiradentes do Sul	4321477	RS	2022-03-28	1	\N	\N	\N	\N
5057	Toropi	4321493	RS	2022-03-28	1	\N	\N	\N	\N
5058	Torres	4321501	RS	2022-03-28	1	\N	\N	\N	\N
5059	Tramandaí	4321600	RS	2022-03-28	1	\N	\N	\N	\N
5060	Travesseiro	4321626	RS	2022-03-28	1	\N	\N	\N	\N
5061	Três Arroios	4321634	RS	2022-03-28	1	\N	\N	\N	\N
5062	Três Cachoeiras	4321667	RS	2022-03-28	1	\N	\N	\N	\N
5063	Três Coroas	4321709	RS	2022-03-28	1	\N	\N	\N	\N
5064	Três de Maio	4321808	RS	2022-03-28	1	\N	\N	\N	\N
5065	Três Forquilhas	4321832	RS	2022-03-28	1	\N	\N	\N	\N
5066	Três Palmeiras	4321857	RS	2022-03-28	1	\N	\N	\N	\N
5067	Três Passos	4321907	RS	2022-03-28	1	\N	\N	\N	\N
5068	Trindade do Sul	4321956	RS	2022-03-28	1	\N	\N	\N	\N
5069	Triunfo	4322004	RS	2022-03-28	1	\N	\N	\N	\N
5070	Tucunduva	4322103	RS	2022-03-28	1	\N	\N	\N	\N
5071	Tunas	4322152	RS	2022-03-28	1	\N	\N	\N	\N
5072	Tupanci do Sul	4322186	RS	2022-03-28	1	\N	\N	\N	\N
5073	Tupanciretã	4322202	RS	2022-03-28	1	\N	\N	\N	\N
5074	Tupandi	4322251	RS	2022-03-28	1	\N	\N	\N	\N
5075	Tuparendi	4322301	RS	2022-03-28	1	\N	\N	\N	\N
5076	Turuçu	4322327	RS	2022-03-28	1	\N	\N	\N	\N
5077	Ubiretama	4322343	RS	2022-03-28	1	\N	\N	\N	\N
5078	União da Serra	4322350	RS	2022-03-28	1	\N	\N	\N	\N
5079	Unistalda	4322376	RS	2022-03-28	1	\N	\N	\N	\N
5080	Uruguaiana	4322400	RS	2022-03-28	1	\N	\N	\N	\N
5081	Vacaria	4322509	RS	2022-03-28	1	\N	\N	\N	\N
5082	Vale do Sol	4322533	RS	2022-03-28	1	\N	\N	\N	\N
5083	Vale Real	4322541	RS	2022-03-28	1	\N	\N	\N	\N
5084	Vale Verde	4322525	RS	2022-03-28	1	\N	\N	\N	\N
5085	Vanini	4322558	RS	2022-03-28	1	\N	\N	\N	\N
5086	Venâncio Aires	4322608	RS	2022-03-28	1	\N	\N	\N	\N
5087	Vera Cruz	4322707	RS	2022-03-28	1	\N	\N	\N	\N
5088	Veranópolis	4322806	RS	2022-03-28	1	\N	\N	\N	\N
5089	Vespasiano Corrêa	4322855	RS	2022-03-28	1	\N	\N	\N	\N
5090	Viadutos	4322905	RS	2022-03-28	1	\N	\N	\N	\N
5091	Viamão	4323002	RS	2022-03-28	1	\N	\N	\N	\N
5092	Vicente Dutra	4323101	RS	2022-03-28	1	\N	\N	\N	\N
5093	Victor Graeff	4323200	RS	2022-03-28	1	\N	\N	\N	\N
5094	Vila Flores	4323309	RS	2022-03-28	1	\N	\N	\N	\N
5095	Vila Lângaro	4323358	RS	2022-03-28	1	\N	\N	\N	\N
5096	Vila Maria	4323408	RS	2022-03-28	1	\N	\N	\N	\N
5097	Vila Nova do Sul	4323457	RS	2022-03-28	1	\N	\N	\N	\N
5098	Vista Alegre	4323507	RS	2022-03-28	1	\N	\N	\N	\N
5099	Vista Alegre do Prata	4323606	RS	2022-03-28	1	\N	\N	\N	\N
5100	Vista Gaúcha	4323705	RS	2022-03-28	1	\N	\N	\N	\N
5101	Vitória das Missões	4323754	RS	2022-03-28	1	\N	\N	\N	\N
5102	Westfália	4323770	RS	2022-03-28	1	\N	\N	\N	\N
5103	Xangri-lá	4323804	RS	2022-03-28	1	\N	\N	\N	\N
5104	Água Clara	5000203	MS	2022-03-28	1	\N	\N	\N	\N
5105	Alcinópolis	5000252	MS	2022-03-28	1	\N	\N	\N	\N
5106	Amambai	5000609	MS	2022-03-28	1	\N	\N	\N	\N
5107	Anastácio	5000708	MS	2022-03-28	1	\N	\N	\N	\N
5108	Anaurilândia	5000807	MS	2022-03-28	1	\N	\N	\N	\N
5109	Angélica	5000856	MS	2022-03-28	1	\N	\N	\N	\N
5110	Antônio João	5000906	MS	2022-03-28	1	\N	\N	\N	\N
5111	Aparecida do Taboado	5001003	MS	2022-03-28	1	\N	\N	\N	\N
5112	Aquidauana	5001102	MS	2022-03-28	1	\N	\N	\N	\N
5113	Aral Moreira	5001243	MS	2022-03-28	1	\N	\N	\N	\N
5114	Bandeirantes	5001508	MS	2022-03-28	1	\N	\N	\N	\N
5115	Bataguassu	5001904	MS	2022-03-28	1	\N	\N	\N	\N
5116	Batayporã	5002001	MS	2022-03-28	1	\N	\N	\N	\N
5117	Bela Vista	5002100	MS	2022-03-28	1	\N	\N	\N	\N
5118	Bodoquena	5002159	MS	2022-03-28	1	\N	\N	\N	\N
5119	Bonito	5002209	MS	2022-03-28	1	\N	\N	\N	\N
5120	Brasilândia	5002308	MS	2022-03-28	1	\N	\N	\N	\N
5121	Caarapó	5002407	MS	2022-03-28	1	\N	\N	\N	\N
5122	Camapuã	5002605	MS	2022-03-28	1	\N	\N	\N	\N
5123	Campo Grande	5002704	MS	2022-03-28	1	\N	\N	\N	\N
5124	Caracol	5002803	MS	2022-03-28	1	\N	\N	\N	\N
5125	Cassilândia	5002902	MS	2022-03-28	1	\N	\N	\N	\N
5126	Chapadão do Sul	5002951	MS	2022-03-28	1	\N	\N	\N	\N
5127	Corguinho	5003108	MS	2022-03-28	1	\N	\N	\N	\N
5128	Coronel Sapucaia	5003157	MS	2022-03-28	1	\N	\N	\N	\N
5129	Corumbá	5003207	MS	2022-03-28	1	\N	\N	\N	\N
5130	Costa Rica	5003256	MS	2022-03-28	1	\N	\N	\N	\N
5131	Coxim	5003306	MS	2022-03-28	1	\N	\N	\N	\N
5132	Deodápolis	5003454	MS	2022-03-28	1	\N	\N	\N	\N
5133	Dois Irmãos do Buriti	5003488	MS	2022-03-28	1	\N	\N	\N	\N
5134	Douradina	5003504	MS	2022-03-28	1	\N	\N	\N	\N
5135	Dourados	5003702	MS	2022-03-28	1	\N	\N	\N	\N
5136	Eldorado	5003751	MS	2022-03-28	1	\N	\N	\N	\N
5137	Fátima do Sul	5003801	MS	2022-03-28	1	\N	\N	\N	\N
5138	Figueirão	5003900	MS	2022-03-28	1	\N	\N	\N	\N
5139	Glória de Dourados	5004007	MS	2022-03-28	1	\N	\N	\N	\N
5140	Guia Lopes da Laguna	5004106	MS	2022-03-28	1	\N	\N	\N	\N
5141	Iguatemi	5004304	MS	2022-03-28	1	\N	\N	\N	\N
5142	Inocência	5004403	MS	2022-03-28	1	\N	\N	\N	\N
5143	Itaporã	5004502	MS	2022-03-28	1	\N	\N	\N	\N
5144	Itaquiraí	5004601	MS	2022-03-28	1	\N	\N	\N	\N
5145	Ivinhema	5004700	MS	2022-03-28	1	\N	\N	\N	\N
5146	Japorã	5004809	MS	2022-03-28	1	\N	\N	\N	\N
5147	Jaraguari	5004908	MS	2022-03-28	1	\N	\N	\N	\N
5148	Jardim	5005004	MS	2022-03-28	1	\N	\N	\N	\N
5149	Jateí	5005103	MS	2022-03-28	1	\N	\N	\N	\N
5150	Juti	5005152	MS	2022-03-28	1	\N	\N	\N	\N
5151	Ladário	5005202	MS	2022-03-28	1	\N	\N	\N	\N
5152	Laguna Carapã	5005251	MS	2022-03-28	1	\N	\N	\N	\N
5153	Maracaju	5005400	MS	2022-03-28	1	\N	\N	\N	\N
5154	Miranda	5005608	MS	2022-03-28	1	\N	\N	\N	\N
5155	Mundo Novo	5005681	MS	2022-03-28	1	\N	\N	\N	\N
5156	Naviraí	5005707	MS	2022-03-28	1	\N	\N	\N	\N
5157	Nioaque	5005806	MS	2022-03-28	1	\N	\N	\N	\N
5158	Nova Alvorada do Sul	5006002	MS	2022-03-28	1	\N	\N	\N	\N
5159	Nova Andradina	5006200	MS	2022-03-28	1	\N	\N	\N	\N
5160	Novo Horizonte do Sul	5006259	MS	2022-03-28	1	\N	\N	\N	\N
5161	Paraíso das Águas	5006275	MS	2022-03-28	1	\N	\N	\N	\N
5162	Paranaíba	5006309	MS	2022-03-28	1	\N	\N	\N	\N
5163	Paranhos	5006358	MS	2022-03-28	1	\N	\N	\N	\N
5164	Pedro Gomes	5006408	MS	2022-03-28	1	\N	\N	\N	\N
5165	Ponta Porã	5006606	MS	2022-03-28	1	\N	\N	\N	\N
5166	Porto Murtinho	5006903	MS	2022-03-28	1	\N	\N	\N	\N
5167	Ribas do Rio Pardo	5007109	MS	2022-03-28	1	\N	\N	\N	\N
5168	Rio Brilhante	5007208	MS	2022-03-28	1	\N	\N	\N	\N
5169	Rio Negro	5007307	MS	2022-03-28	1	\N	\N	\N	\N
5170	Rio Verde de Mato Grosso	5007406	MS	2022-03-28	1	\N	\N	\N	\N
5171	Rochedo	5007505	MS	2022-03-28	1	\N	\N	\N	\N
5172	Santa Rita do Pardo	5007554	MS	2022-03-28	1	\N	\N	\N	\N
5173	São Gabriel do Oeste	5007695	MS	2022-03-28	1	\N	\N	\N	\N
5174	Selvíria	5007802	MS	2022-03-28	1	\N	\N	\N	\N
5175	Sete Quedas	5007703	MS	2022-03-28	1	\N	\N	\N	\N
5176	Sidrolândia	5007901	MS	2022-03-28	1	\N	\N	\N	\N
5177	Sonora	5007935	MS	2022-03-28	1	\N	\N	\N	\N
5178	Tacuru	5007950	MS	2022-03-28	1	\N	\N	\N	\N
5179	Taquarussu	5007976	MS	2022-03-28	1	\N	\N	\N	\N
5180	Terenos	5008008	MS	2022-03-28	1	\N	\N	\N	\N
5181	Três Lagoas	5008305	MS	2022-03-28	1	\N	\N	\N	\N
5182	Vicentina	5008404	MS	2022-03-28	1	\N	\N	\N	\N
5183	Acorizal	5100102	MT	2022-03-28	1	\N	\N	\N	\N
5184	Água Boa	5100201	MT	2022-03-28	1	\N	\N	\N	\N
5185	Alta Floresta	5100250	MT	2022-03-28	1	\N	\N	\N	\N
5186	Alto Araguaia	5100300	MT	2022-03-28	1	\N	\N	\N	\N
5187	Alto Boa Vista	5100359	MT	2022-03-28	1	\N	\N	\N	\N
5188	Alto Garças	5100409	MT	2022-03-28	1	\N	\N	\N	\N
5189	Alto Paraguai	5100508	MT	2022-03-28	1	\N	\N	\N	\N
5190	Alto Taquari	5100607	MT	2022-03-28	1	\N	\N	\N	\N
5191	Apiacás	5100805	MT	2022-03-28	1	\N	\N	\N	\N
5192	Araguaiana	5101001	MT	2022-03-28	1	\N	\N	\N	\N
5193	Araguainha	5101209	MT	2022-03-28	1	\N	\N	\N	\N
5194	Araputanga	5101258	MT	2022-03-28	1	\N	\N	\N	\N
5195	Arenápolis	5101308	MT	2022-03-28	1	\N	\N	\N	\N
5196	Aripuanã	5101407	MT	2022-03-28	1	\N	\N	\N	\N
5197	Barão de Melgaço	5101605	MT	2022-03-28	1	\N	\N	\N	\N
5198	Barra do Bugres	5101704	MT	2022-03-28	1	\N	\N	\N	\N
5199	Barra do Garças	5101803	MT	2022-03-28	1	\N	\N	\N	\N
5200	Bom Jesus do Araguaia	5101852	MT	2022-03-28	1	\N	\N	\N	\N
5201	Brasnorte	5101902	MT	2022-03-28	1	\N	\N	\N	\N
5202	Cáceres	5102504	MT	2022-03-28	1	\N	\N	\N	\N
5203	Campinápolis	5102603	MT	2022-03-28	1	\N	\N	\N	\N
5204	Campo Novo do Parecis	5102637	MT	2022-03-28	1	\N	\N	\N	\N
5205	Campo Verde	5102678	MT	2022-03-28	1	\N	\N	\N	\N
5206	Campos de Júlio	5102686	MT	2022-03-28	1	\N	\N	\N	\N
5207	Canabrava do Norte	5102694	MT	2022-03-28	1	\N	\N	\N	\N
5208	Canarana	5102702	MT	2022-03-28	1	\N	\N	\N	\N
5209	Carlinda	5102793	MT	2022-03-28	1	\N	\N	\N	\N
5210	Castanheira	5102850	MT	2022-03-28	1	\N	\N	\N	\N
5211	Chapada dos Guimarães	5103007	MT	2022-03-28	1	\N	\N	\N	\N
5212	Cláudia	5103056	MT	2022-03-28	1	\N	\N	\N	\N
5213	Cocalinho	5103106	MT	2022-03-28	1	\N	\N	\N	\N
5214	Colíder	5103205	MT	2022-03-28	1	\N	\N	\N	\N
5215	Colniza	5103254	MT	2022-03-28	1	\N	\N	\N	\N
5216	Comodoro	5103304	MT	2022-03-28	1	\N	\N	\N	\N
5217	Confresa	5103353	MT	2022-03-28	1	\N	\N	\N	\N
5218	'Conquista D''Oeste'	5103361	MT	2022-03-28	1	\N	\N	\N	\N
5219	Cotriguaçu	5103379	MT	2022-03-28	1	\N	\N	\N	\N
5220	Cuiabá	5103403	MT	2022-03-28	1	\N	\N	\N	\N
5221	Curvelândia	5103437	MT	2022-03-28	1	\N	\N	\N	\N
5222	Denise	5103452	MT	2022-03-28	1	\N	\N	\N	\N
5223	Diamantino	5103502	MT	2022-03-28	1	\N	\N	\N	\N
5224	Dom Aquino	5103601	MT	2022-03-28	1	\N	\N	\N	\N
5225	Feliz Natal	5103700	MT	2022-03-28	1	\N	\N	\N	\N
5226	'Figueirópolis D''Oeste'	5103809	MT	2022-03-28	1	\N	\N	\N	\N
5227	Gaúcha do Norte	5103858	MT	2022-03-28	1	\N	\N	\N	\N
5228	General Carneiro	5103908	MT	2022-03-28	1	\N	\N	\N	\N
5229	'Glória D''Oeste'	5103957	MT	2022-03-28	1	\N	\N	\N	\N
5230	Guarantã do Norte	5104104	MT	2022-03-28	1	\N	\N	\N	\N
5231	Guiratinga	5104203	MT	2022-03-28	1	\N	\N	\N	\N
5232	Indiavaí	5104500	MT	2022-03-28	1	\N	\N	\N	\N
5233	Ipiranga do Norte	5104526	MT	2022-03-28	1	\N	\N	\N	\N
5234	Itanhangá	5104542	MT	2022-03-28	1	\N	\N	\N	\N
5235	Itaúba	5104559	MT	2022-03-28	1	\N	\N	\N	\N
5236	Itiquira	5104609	MT	2022-03-28	1	\N	\N	\N	\N
5237	Jaciara	5104807	MT	2022-03-28	1	\N	\N	\N	\N
5238	Jangada	5104906	MT	2022-03-28	1	\N	\N	\N	\N
5239	Jauru	5105002	MT	2022-03-28	1	\N	\N	\N	\N
5240	Juara	5105101	MT	2022-03-28	1	\N	\N	\N	\N
5241	Juína	5105150	MT	2022-03-28	1	\N	\N	\N	\N
5242	Juruena	5105176	MT	2022-03-28	1	\N	\N	\N	\N
5243	Juscimeira	5105200	MT	2022-03-28	1	\N	\N	\N	\N
5244	'Lambari D''Oeste'	5105234	MT	2022-03-28	1	\N	\N	\N	\N
5245	Lucas do Rio Verde	5105259	MT	2022-03-28	1	\N	\N	\N	\N
5246	Luciara	5105309	MT	2022-03-28	1	\N	\N	\N	\N
5247	Marcelândia	5105580	MT	2022-03-28	1	\N	\N	\N	\N
5248	Matupá	5105606	MT	2022-03-28	1	\N	\N	\N	\N
5249	'Mirassol d''Oeste'	5105622	MT	2022-03-28	1	\N	\N	\N	\N
5250	Nobres	5105903	MT	2022-03-28	1	\N	\N	\N	\N
5251	Nortelândia	5106000	MT	2022-03-28	1	\N	\N	\N	\N
5252	Nossa Senhora do Livramento	5106109	MT	2022-03-28	1	\N	\N	\N	\N
5253	Nova Bandeirantes	5106158	MT	2022-03-28	1	\N	\N	\N	\N
5254	Nova Brasilândia	5106208	MT	2022-03-28	1	\N	\N	\N	\N
5255	Nova Canaã do Norte	5106216	MT	2022-03-28	1	\N	\N	\N	\N
5256	Nova Guarita	5108808	MT	2022-03-28	1	\N	\N	\N	\N
5257	Nova Lacerda	5106182	MT	2022-03-28	1	\N	\N	\N	\N
5258	Nova Marilândia	5108857	MT	2022-03-28	1	\N	\N	\N	\N
5259	Nova Maringá	5108907	MT	2022-03-28	1	\N	\N	\N	\N
5260	Nova Monte Verde	5108956	MT	2022-03-28	1	\N	\N	\N	\N
5261	Nova Mutum	5106224	MT	2022-03-28	1	\N	\N	\N	\N
5262	Nova Nazaré	5106174	MT	2022-03-28	1	\N	\N	\N	\N
5263	Nova Olímpia	5106232	MT	2022-03-28	1	\N	\N	\N	\N
5264	Nova Santa Helena	5106190	MT	2022-03-28	1	\N	\N	\N	\N
5265	Nova Ubiratã	5106240	MT	2022-03-28	1	\N	\N	\N	\N
5266	Nova Xavantina	5106257	MT	2022-03-28	1	\N	\N	\N	\N
5267	Novo Horizonte do Norte	5106273	MT	2022-03-28	1	\N	\N	\N	\N
5268	Novo Mundo	5106265	MT	2022-03-28	1	\N	\N	\N	\N
5269	Novo Santo Antônio	5106315	MT	2022-03-28	1	\N	\N	\N	\N
5270	Novo São Joaquim	5106281	MT	2022-03-28	1	\N	\N	\N	\N
5271	Paranaíta	5106299	MT	2022-03-28	1	\N	\N	\N	\N
5272	Paranatinga	5106307	MT	2022-03-28	1	\N	\N	\N	\N
5273	Pedra Preta	5106372	MT	2022-03-28	1	\N	\N	\N	\N
5274	Peixoto de Azevedo	5106422	MT	2022-03-28	1	\N	\N	\N	\N
5275	Planalto da Serra	5106455	MT	2022-03-28	1	\N	\N	\N	\N
5276	Poconé	5106505	MT	2022-03-28	1	\N	\N	\N	\N
5277	Pontal do Araguaia	5106653	MT	2022-03-28	1	\N	\N	\N	\N
5278	Ponte Branca	5106703	MT	2022-03-28	1	\N	\N	\N	\N
5279	Pontes e Lacerda	5106752	MT	2022-03-28	1	\N	\N	\N	\N
5280	Porto Alegre do Norte	5106778	MT	2022-03-28	1	\N	\N	\N	\N
5281	Porto dos Gaúchos	5106802	MT	2022-03-28	1	\N	\N	\N	\N
5282	Porto Esperidião	5106828	MT	2022-03-28	1	\N	\N	\N	\N
5283	Porto Estrela	5106851	MT	2022-03-28	1	\N	\N	\N	\N
5284	Poxoréu	5107008	MT	2022-03-28	1	\N	\N	\N	\N
5285	Primavera do Leste	5107040	MT	2022-03-28	1	\N	\N	\N	\N
5286	Querência	5107065	MT	2022-03-28	1	\N	\N	\N	\N
5287	Reserva do Cabaçal	5107156	MT	2022-03-28	1	\N	\N	\N	\N
5288	Ribeirão Cascalheira	5107180	MT	2022-03-28	1	\N	\N	\N	\N
5289	Ribeirãozinho	5107198	MT	2022-03-28	1	\N	\N	\N	\N
5290	Rio Branco	5107206	MT	2022-03-28	1	\N	\N	\N	\N
5291	Rondolândia	5107578	MT	2022-03-28	1	\N	\N	\N	\N
5292	Rondonópolis	5107602	MT	2022-03-28	1	\N	\N	\N	\N
5293	Rosário Oeste	5107701	MT	2022-03-28	1	\N	\N	\N	\N
5294	Salto do Céu	5107750	MT	2022-03-28	1	\N	\N	\N	\N
5295	Santa Carmem	5107248	MT	2022-03-28	1	\N	\N	\N	\N
5296	Santa Cruz do Xingu	5107743	MT	2022-03-28	1	\N	\N	\N	\N
5297	Santa Rita do Trivelato	5107768	MT	2022-03-28	1	\N	\N	\N	\N
5298	Santa Terezinha	5107776	MT	2022-03-28	1	\N	\N	\N	\N
5299	Santo Afonso	5107263	MT	2022-03-28	1	\N	\N	\N	\N
5300	Santo Antônio do Leste	5107792	MT	2022-03-28	1	\N	\N	\N	\N
5301	Santo Antônio do Leverger	5107800	MT	2022-03-28	1	\N	\N	\N	\N
5302	São Félix do Araguaia	5107859	MT	2022-03-28	1	\N	\N	\N	\N
5303	São José do Povo	5107297	MT	2022-03-28	1	\N	\N	\N	\N
5304	São José do Rio Claro	5107305	MT	2022-03-28	1	\N	\N	\N	\N
5305	São José do Xingu	5107354	MT	2022-03-28	1	\N	\N	\N	\N
5306	São José dos Quatro Marcos	5107107	MT	2022-03-28	1	\N	\N	\N	\N
5307	São Pedro da Cipa	5107404	MT	2022-03-28	1	\N	\N	\N	\N
5308	Sapezal	5107875	MT	2022-03-28	1	\N	\N	\N	\N
5309	Serra Nova Dourada	5107883	MT	2022-03-28	1	\N	\N	\N	\N
5310	Sinop	5107909	MT	2022-03-28	1	\N	\N	\N	\N
5311	Sorriso	5107925	MT	2022-03-28	1	\N	\N	\N	\N
5312	Tabaporã	5107941	MT	2022-03-28	1	\N	\N	\N	\N
5313	Tangará da Serra	5107958	MT	2022-03-28	1	\N	\N	\N	\N
5315	Terra Nova do Norte	5108055	MT	2022-03-28	1	\N	\N	\N	\N
5316	Tesouro	5108105	MT	2022-03-28	1	\N	\N	\N	\N
5317	Torixoréu	5108204	MT	2022-03-28	1	\N	\N	\N	\N
5318	União do Sul	5108303	MT	2022-03-28	1	\N	\N	\N	\N
5319	Vale de São Domingos	5108352	MT	2022-03-28	1	\N	\N	\N	\N
5320	Várzea Grande	5108402	MT	2022-03-28	1	\N	\N	\N	\N
5321	Vera	5108501	MT	2022-03-28	1	\N	\N	\N	\N
5322	Vila Bela da Santíssima Trindade	5105507	MT	2022-03-28	1	\N	\N	\N	\N
5323	Vila Rica	5108600	MT	2022-03-28	1	\N	\N	\N	\N
5324	Abadia de Goiás	5200050	GO	2022-03-28	1	\N	\N	\N	\N
5325	Abadiânia	5200100	GO	2022-03-28	1	\N	\N	\N	\N
5326	Acreúna	5200134	GO	2022-03-28	1	\N	\N	\N	\N
5327	Adelândia	5200159	GO	2022-03-28	1	\N	\N	\N	\N
5328	Água Fria de Goiás	5200175	GO	2022-03-28	1	\N	\N	\N	\N
5329	Água Limpa	5200209	GO	2022-03-28	1	\N	\N	\N	\N
5330	Águas Lindas de Goiás	5200258	GO	2022-03-28	1	\N	\N	\N	\N
5331	Alexânia	5200308	GO	2022-03-28	1	\N	\N	\N	\N
5332	Aloândia	5200506	GO	2022-03-28	1	\N	\N	\N	\N
5333	Alto Horizonte	5200555	GO	2022-03-28	1	\N	\N	\N	\N
5334	Alto Paraíso de Goiás	5200605	GO	2022-03-28	1	\N	\N	\N	\N
5335	Alvorada do Norte	5200803	GO	2022-03-28	1	\N	\N	\N	\N
5336	Amaralina	5200829	GO	2022-03-28	1	\N	\N	\N	\N
5337	Americano do Brasil	5200852	GO	2022-03-28	1	\N	\N	\N	\N
5338	Amorinópolis	5200902	GO	2022-03-28	1	\N	\N	\N	\N
5339	Anápolis	5201108	GO	2022-03-28	1	\N	\N	\N	\N
5340	Anhanguera	5201207	GO	2022-03-28	1	\N	\N	\N	\N
5341	Anicuns	5201306	GO	2022-03-28	1	\N	\N	\N	\N
5342	Aparecida de Goiânia	5201405	GO	2022-03-28	1	\N	\N	\N	\N
5343	Aparecida do Rio Doce	5201454	GO	2022-03-28	1	\N	\N	\N	\N
5344	Aporé	5201504	GO	2022-03-28	1	\N	\N	\N	\N
5345	Araçu	5201603	GO	2022-03-28	1	\N	\N	\N	\N
5346	Aragarças	5201702	GO	2022-03-28	1	\N	\N	\N	\N
5347	Aragoiânia	5201801	GO	2022-03-28	1	\N	\N	\N	\N
5348	Araguapaz	5202155	GO	2022-03-28	1	\N	\N	\N	\N
5349	Arenópolis	5202353	GO	2022-03-28	1	\N	\N	\N	\N
5350	Aruanã	5202502	GO	2022-03-28	1	\N	\N	\N	\N
5351	Aurilândia	5202601	GO	2022-03-28	1	\N	\N	\N	\N
5352	Avelinópolis	5202809	GO	2022-03-28	1	\N	\N	\N	\N
5353	Baliza	5203104	GO	2022-03-28	1	\N	\N	\N	\N
5354	Barro Alto	5203203	GO	2022-03-28	1	\N	\N	\N	\N
5355	Bela Vista de Goiás	5203302	GO	2022-03-28	1	\N	\N	\N	\N
5356	Bom Jardim de Goiás	5203401	GO	2022-03-28	1	\N	\N	\N	\N
5357	Bom Jesus de Goiás	5203500	GO	2022-03-28	1	\N	\N	\N	\N
5358	Bonfinópolis	5203559	GO	2022-03-28	1	\N	\N	\N	\N
5359	Bonópolis	5203575	GO	2022-03-28	1	\N	\N	\N	\N
5360	Brazabrantes	5203609	GO	2022-03-28	1	\N	\N	\N	\N
5361	Britânia	5203807	GO	2022-03-28	1	\N	\N	\N	\N
5362	Buriti Alegre	5203906	GO	2022-03-28	1	\N	\N	\N	\N
5363	Buriti de Goiás	5203939	GO	2022-03-28	1	\N	\N	\N	\N
5364	Buritinópolis	5203962	GO	2022-03-28	1	\N	\N	\N	\N
5365	Cabeceiras	5204003	GO	2022-03-28	1	\N	\N	\N	\N
5366	Cachoeira Alta	5204102	GO	2022-03-28	1	\N	\N	\N	\N
5367	Cachoeira de Goiás	5204201	GO	2022-03-28	1	\N	\N	\N	\N
5368	Cachoeira Dourada	5204250	GO	2022-03-28	1	\N	\N	\N	\N
5369	Caçu	5204300	GO	2022-03-28	1	\N	\N	\N	\N
5370	Caiapônia	5204409	GO	2022-03-28	1	\N	\N	\N	\N
5371	Caldas Novas	5204508	GO	2022-03-28	1	\N	\N	\N	\N
5372	Caldazinha	5204557	GO	2022-03-28	1	\N	\N	\N	\N
5373	Campestre de Goiás	5204607	GO	2022-03-28	1	\N	\N	\N	\N
5374	Campinaçu	5204656	GO	2022-03-28	1	\N	\N	\N	\N
5375	Campinorte	5204706	GO	2022-03-28	1	\N	\N	\N	\N
5376	Campo Alegre de Goiás	5204805	GO	2022-03-28	1	\N	\N	\N	\N
5377	Campo Limpo de Goiás	5204854	GO	2022-03-28	1	\N	\N	\N	\N
5378	Campos Belos	5204904	GO	2022-03-28	1	\N	\N	\N	\N
5379	Campos Verdes	5204953	GO	2022-03-28	1	\N	\N	\N	\N
5380	Carmo do Rio Verde	5205000	GO	2022-03-28	1	\N	\N	\N	\N
5381	Castelândia	5205059	GO	2022-03-28	1	\N	\N	\N	\N
5382	Catalão	5205109	GO	2022-03-28	1	\N	\N	\N	\N
5383	Caturaí	5205208	GO	2022-03-28	1	\N	\N	\N	\N
5384	Cavalcante	5205307	GO	2022-03-28	1	\N	\N	\N	\N
5385	Ceres	5205406	GO	2022-03-28	1	\N	\N	\N	\N
5386	Cezarina	5205455	GO	2022-03-28	1	\N	\N	\N	\N
5387	Chapadão do Céu	5205471	GO	2022-03-28	1	\N	\N	\N	\N
5388	Cidade Ocidental	5205497	GO	2022-03-28	1	\N	\N	\N	\N
5389	Cocalzinho de Goiás	5205513	GO	2022-03-28	1	\N	\N	\N	\N
5390	Colinas do Sul	5205521	GO	2022-03-28	1	\N	\N	\N	\N
5391	Córrego do Ouro	5205703	GO	2022-03-28	1	\N	\N	\N	\N
5392	Corumbá de Goiás	5205802	GO	2022-03-28	1	\N	\N	\N	\N
5393	Corumbaíba	5205901	GO	2022-03-28	1	\N	\N	\N	\N
5394	Cristalina	5206206	GO	2022-03-28	1	\N	\N	\N	\N
5395	Cristianópolis	5206305	GO	2022-03-28	1	\N	\N	\N	\N
5396	Crixás	5206404	GO	2022-03-28	1	\N	\N	\N	\N
5397	Cromínia	5206503	GO	2022-03-28	1	\N	\N	\N	\N
5398	Cumari	5206602	GO	2022-03-28	1	\N	\N	\N	\N
5399	Damianópolis	5206701	GO	2022-03-28	1	\N	\N	\N	\N
5400	Damolândia	5206800	GO	2022-03-28	1	\N	\N	\N	\N
5401	Davinópolis	5206909	GO	2022-03-28	1	\N	\N	\N	\N
5402	Diorama	5207105	GO	2022-03-28	1	\N	\N	\N	\N
5403	Divinópolis de Goiás	5208301	GO	2022-03-28	1	\N	\N	\N	\N
5404	Doverlândia	5207253	GO	2022-03-28	1	\N	\N	\N	\N
5405	Edealina	5207352	GO	2022-03-28	1	\N	\N	\N	\N
5406	Edéia	5207402	GO	2022-03-28	1	\N	\N	\N	\N
5407	Estrela do Norte	5207501	GO	2022-03-28	1	\N	\N	\N	\N
5408	Faina	5207535	GO	2022-03-28	1	\N	\N	\N	\N
5409	Fazenda Nova	5207600	GO	2022-03-28	1	\N	\N	\N	\N
5410	Firminópolis	5207808	GO	2022-03-28	1	\N	\N	\N	\N
5411	Flores de Goiás	5207907	GO	2022-03-28	1	\N	\N	\N	\N
5412	Formosa	5208004	GO	2022-03-28	1	\N	\N	\N	\N
5413	Formoso	5208103	GO	2022-03-28	1	\N	\N	\N	\N
5414	Gameleira de Goiás	5208152	GO	2022-03-28	1	\N	\N	\N	\N
5415	Goianápolis	5208400	GO	2022-03-28	1	\N	\N	\N	\N
5416	Goiandira	5208509	GO	2022-03-28	1	\N	\N	\N	\N
5417	Goianésia	5208608	GO	2022-03-28	1	\N	\N	\N	\N
5418	Goiânia	5208707	GO	2022-03-28	1	\N	\N	\N	\N
5419	Goianira	5208806	GO	2022-03-28	1	\N	\N	\N	\N
5420	Goiás	5208905	GO	2022-03-28	1	\N	\N	\N	\N
5421	Goiatuba	5209101	GO	2022-03-28	1	\N	\N	\N	\N
5422	Gouvelândia	5209150	GO	2022-03-28	1	\N	\N	\N	\N
5423	Guapó	5209200	GO	2022-03-28	1	\N	\N	\N	\N
5424	Guaraíta	5209291	GO	2022-03-28	1	\N	\N	\N	\N
5425	Guarani de Goiás	5209408	GO	2022-03-28	1	\N	\N	\N	\N
5426	Guarinos	5209457	GO	2022-03-28	1	\N	\N	\N	\N
5427	Heitoraí	5209606	GO	2022-03-28	1	\N	\N	\N	\N
5428	Hidrolândia	5209705	GO	2022-03-28	1	\N	\N	\N	\N
5429	Hidrolina	5209804	GO	2022-03-28	1	\N	\N	\N	\N
5430	Iaciara	5209903	GO	2022-03-28	1	\N	\N	\N	\N
5431	Inaciolândia	5209937	GO	2022-03-28	1	\N	\N	\N	\N
5432	Indiara	5209952	GO	2022-03-28	1	\N	\N	\N	\N
5433	Inhumas	5210000	GO	2022-03-28	1	\N	\N	\N	\N
5434	Ipameri	5210109	GO	2022-03-28	1	\N	\N	\N	\N
5435	Ipiranga de Goiás	5210158	GO	2022-03-28	1	\N	\N	\N	\N
5436	Iporá	5210208	GO	2022-03-28	1	\N	\N	\N	\N
5437	Israelândia	5210307	GO	2022-03-28	1	\N	\N	\N	\N
5438	Itaberaí	5210406	GO	2022-03-28	1	\N	\N	\N	\N
5439	Itaguari	5210562	GO	2022-03-28	1	\N	\N	\N	\N
5440	Itaguaru	5210604	GO	2022-03-28	1	\N	\N	\N	\N
5441	Itajá	5210802	GO	2022-03-28	1	\N	\N	\N	\N
5442	Itapaci	5210901	GO	2022-03-28	1	\N	\N	\N	\N
5443	Itapirapuã	5211008	GO	2022-03-28	1	\N	\N	\N	\N
5444	Itapuranga	5211206	GO	2022-03-28	1	\N	\N	\N	\N
5445	Itarumã	5211305	GO	2022-03-28	1	\N	\N	\N	\N
5446	Itauçu	5211404	GO	2022-03-28	1	\N	\N	\N	\N
5447	Itumbiara	5211503	GO	2022-03-28	1	\N	\N	\N	\N
5448	Ivolândia	5211602	GO	2022-03-28	1	\N	\N	\N	\N
5449	Jandaia	5211701	GO	2022-03-28	1	\N	\N	\N	\N
5450	Jaraguá	5211800	GO	2022-03-28	1	\N	\N	\N	\N
5451	Jataí	5211909	GO	2022-03-28	1	\N	\N	\N	\N
5452	Jaupaci	5212006	GO	2022-03-28	1	\N	\N	\N	\N
5453	Jesúpolis	5212055	GO	2022-03-28	1	\N	\N	\N	\N
5454	Joviânia	5212105	GO	2022-03-28	1	\N	\N	\N	\N
5455	Jussara	5212204	GO	2022-03-28	1	\N	\N	\N	\N
5456	Lagoa Santa	5212253	GO	2022-03-28	1	\N	\N	\N	\N
5457	Leopoldo de Bulhões	5212303	GO	2022-03-28	1	\N	\N	\N	\N
5458	Luziânia	5212501	GO	2022-03-28	1	\N	\N	\N	\N
5459	Mairipotaba	5212600	GO	2022-03-28	1	\N	\N	\N	\N
5460	Mambaí	5212709	GO	2022-03-28	1	\N	\N	\N	\N
5461	Mara Rosa	5212808	GO	2022-03-28	1	\N	\N	\N	\N
5462	Marzagão	5212907	GO	2022-03-28	1	\N	\N	\N	\N
5463	Matrinchã	5212956	GO	2022-03-28	1	\N	\N	\N	\N
5464	Maurilândia	5213004	GO	2022-03-28	1	\N	\N	\N	\N
5465	Mimoso de Goiás	5213053	GO	2022-03-28	1	\N	\N	\N	\N
5466	Minaçu	5213087	GO	2022-03-28	1	\N	\N	\N	\N
5467	Mineiros	5213103	GO	2022-03-28	1	\N	\N	\N	\N
5468	Moiporá	5213400	GO	2022-03-28	1	\N	\N	\N	\N
5469	Monte Alegre de Goiás	5213509	GO	2022-03-28	1	\N	\N	\N	\N
5470	Montes Claros de Goiás	5213707	GO	2022-03-28	1	\N	\N	\N	\N
5471	Montividiu	5213756	GO	2022-03-28	1	\N	\N	\N	\N
5472	Montividiu do Norte	5213772	GO	2022-03-28	1	\N	\N	\N	\N
5473	Morrinhos	5213806	GO	2022-03-28	1	\N	\N	\N	\N
5474	Morro Agudo de Goiás	5213855	GO	2022-03-28	1	\N	\N	\N	\N
5475	Mossâmedes	5213905	GO	2022-03-28	1	\N	\N	\N	\N
5476	Mozarlândia	5214002	GO	2022-03-28	1	\N	\N	\N	\N
5477	Mundo Novo	5214051	GO	2022-03-28	1	\N	\N	\N	\N
5478	Mutunópolis	5214101	GO	2022-03-28	1	\N	\N	\N	\N
5479	Nazário	5214408	GO	2022-03-28	1	\N	\N	\N	\N
5480	Nerópolis	5214507	GO	2022-03-28	1	\N	\N	\N	\N
5481	Niquelândia	5214606	GO	2022-03-28	1	\N	\N	\N	\N
5482	Nova América	5214705	GO	2022-03-28	1	\N	\N	\N	\N
5483	Nova Aurora	5214804	GO	2022-03-28	1	\N	\N	\N	\N
5484	Nova Crixás	5214838	GO	2022-03-28	1	\N	\N	\N	\N
5485	Nova Glória	5214861	GO	2022-03-28	1	\N	\N	\N	\N
5486	Nova Iguaçu de Goiás	5214879	GO	2022-03-28	1	\N	\N	\N	\N
5487	Nova Roma	5214903	GO	2022-03-28	1	\N	\N	\N	\N
5488	Nova Veneza	5215009	GO	2022-03-28	1	\N	\N	\N	\N
5489	Novo Brasil	5215207	GO	2022-03-28	1	\N	\N	\N	\N
5490	Novo Gama	5215231	GO	2022-03-28	1	\N	\N	\N	\N
5491	Novo Planalto	5215256	GO	2022-03-28	1	\N	\N	\N	\N
5492	Orizona	5215306	GO	2022-03-28	1	\N	\N	\N	\N
5493	Ouro Verde de Goiás	5215405	GO	2022-03-28	1	\N	\N	\N	\N
5494	Ouvidor	5215504	GO	2022-03-28	1	\N	\N	\N	\N
5495	Padre Bernardo	5215603	GO	2022-03-28	1	\N	\N	\N	\N
5496	Palestina de Goiás	5215652	GO	2022-03-28	1	\N	\N	\N	\N
5497	Palmeiras de Goiás	5215702	GO	2022-03-28	1	\N	\N	\N	\N
5498	Palmelo	5215801	GO	2022-03-28	1	\N	\N	\N	\N
5499	Palminópolis	5215900	GO	2022-03-28	1	\N	\N	\N	\N
5500	Panamá	5216007	GO	2022-03-28	1	\N	\N	\N	\N
5501	Paranaiguara	5216304	GO	2022-03-28	1	\N	\N	\N	\N
5502	Paraúna	5216403	GO	2022-03-28	1	\N	\N	\N	\N
5503	Perolândia	5216452	GO	2022-03-28	1	\N	\N	\N	\N
5504	Petrolina de Goiás	5216809	GO	2022-03-28	1	\N	\N	\N	\N
5505	Pilar de Goiás	5216908	GO	2022-03-28	1	\N	\N	\N	\N
5506	Piracanjuba	5217104	GO	2022-03-28	1	\N	\N	\N	\N
5507	Piranhas	5217203	GO	2022-03-28	1	\N	\N	\N	\N
5508	Pirenópolis	5217302	GO	2022-03-28	1	\N	\N	\N	\N
5509	Pires do Rio	5217401	GO	2022-03-28	1	\N	\N	\N	\N
5510	Planaltina	5217609	GO	2022-03-28	1	\N	\N	\N	\N
5511	Pontalina	5217708	GO	2022-03-28	1	\N	\N	\N	\N
5512	Porangatu	5218003	GO	2022-03-28	1	\N	\N	\N	\N
5513	Porteirão	5218052	GO	2022-03-28	1	\N	\N	\N	\N
5514	Portelândia	5218102	GO	2022-03-28	1	\N	\N	\N	\N
5515	Posse	5218300	GO	2022-03-28	1	\N	\N	\N	\N
5516	Professor Jamil	5218391	GO	2022-03-28	1	\N	\N	\N	\N
5517	Quirinópolis	5218508	GO	2022-03-28	1	\N	\N	\N	\N
5518	Rialma	5218607	GO	2022-03-28	1	\N	\N	\N	\N
5519	Rianápolis	5218706	GO	2022-03-28	1	\N	\N	\N	\N
5520	Rio Quente	5218789	GO	2022-03-28	1	\N	\N	\N	\N
5521	Rio Verde	5218805	GO	2022-03-28	1	\N	\N	\N	\N
5522	Rubiataba	5218904	GO	2022-03-28	1	\N	\N	\N	\N
5523	Sanclerlândia	5219001	GO	2022-03-28	1	\N	\N	\N	\N
5524	Santa Bárbara de Goiás	5219100	GO	2022-03-28	1	\N	\N	\N	\N
5525	Santa Cruz de Goiás	5219209	GO	2022-03-28	1	\N	\N	\N	\N
5526	Santa Fé de Goiás	5219258	GO	2022-03-28	1	\N	\N	\N	\N
5527	Santa Helena de Goiás	5219308	GO	2022-03-28	1	\N	\N	\N	\N
5528	Santa Isabel	5219357	GO	2022-03-28	1	\N	\N	\N	\N
5529	Santa Rita do Araguaia	5219407	GO	2022-03-28	1	\N	\N	\N	\N
5530	Santa Rita do Novo Destino	5219456	GO	2022-03-28	1	\N	\N	\N	\N
5531	Santa Rosa de Goiás	5219506	GO	2022-03-28	1	\N	\N	\N	\N
5532	Santa Tereza de Goiás	5219605	GO	2022-03-28	1	\N	\N	\N	\N
5533	Santa Terezinha de Goiás	5219704	GO	2022-03-28	1	\N	\N	\N	\N
5534	Santo Antônio da Barra	5219712	GO	2022-03-28	1	\N	\N	\N	\N
5535	Santo Antônio de Goiás	5219738	GO	2022-03-28	1	\N	\N	\N	\N
5536	Santo Antônio do Descoberto	5219753	GO	2022-03-28	1	\N	\N	\N	\N
5537	São Domingos	5219803	GO	2022-03-28	1	\N	\N	\N	\N
5538	São Francisco de Goiás	5219902	GO	2022-03-28	1	\N	\N	\N	\N
5539	São João da Paraúna	5220058	GO	2022-03-28	1	\N	\N	\N	\N
5540	'São João d''Aliança'	5220009	GO	2022-03-28	1	\N	\N	\N	\N
5541	São Luís de Montes Belos	5220108	GO	2022-03-28	1	\N	\N	\N	\N
5542	São Luiz do Norte	5220157	GO	2022-03-28	1	\N	\N	\N	\N
5543	São Miguel do Araguaia	5220207	GO	2022-03-28	1	\N	\N	\N	\N
5544	São Miguel do Passa Quatro	5220264	GO	2022-03-28	1	\N	\N	\N	\N
5545	São Patrício	5220280	GO	2022-03-28	1	\N	\N	\N	\N
5546	São Simão	5220405	GO	2022-03-28	1	\N	\N	\N	\N
5547	Senador Canedo	5220454	GO	2022-03-28	1	\N	\N	\N	\N
5548	Serranópolis	5220504	GO	2022-03-28	1	\N	\N	\N	\N
5549	Silvânia	5220603	GO	2022-03-28	1	\N	\N	\N	\N
5550	Simolândia	5220686	GO	2022-03-28	1	\N	\N	\N	\N
5551	'Sítio d''Abadia'	5220702	GO	2022-03-28	1	\N	\N	\N	\N
5552	Taquaral de Goiás	5221007	GO	2022-03-28	1	\N	\N	\N	\N
5553	Teresina de Goiás	5221080	GO	2022-03-28	1	\N	\N	\N	\N
5554	Terezópolis de Goiás	5221197	GO	2022-03-28	1	\N	\N	\N	\N
5555	Três Ranchos	5221304	GO	2022-03-28	1	\N	\N	\N	\N
5556	Trindade	5221403	GO	2022-03-28	1	\N	\N	\N	\N
5557	Trombas	5221452	GO	2022-03-28	1	\N	\N	\N	\N
5558	Turvânia	5221502	GO	2022-03-28	1	\N	\N	\N	\N
5559	Turvelândia	5221551	GO	2022-03-28	1	\N	\N	\N	\N
5560	Uirapuru	5221577	GO	2022-03-28	1	\N	\N	\N	\N
5561	Uruaçu	5221601	GO	2022-03-28	1	\N	\N	\N	\N
5562	Uruana	5221700	GO	2022-03-28	1	\N	\N	\N	\N
5563	Urutaí	5221809	GO	2022-03-28	1	\N	\N	\N	\N
5564	Valparaíso de Goiás	5221858	GO	2022-03-28	1	\N	\N	\N	\N
5565	Varjão	5221908	GO	2022-03-28	1	\N	\N	\N	\N
5566	Vianópolis	5222005	GO	2022-03-28	1	\N	\N	\N	\N
5567	Vicentinópolis	5222054	GO	2022-03-28	1	\N	\N	\N	\N
5568	Vila Boa	5222203	GO	2022-03-28	1	\N	\N	\N	\N
5569	Vila Propício	5222302	GO	2022-03-28	1	\N	\N	\N	\N
5570	Brasília	5300108	DF	2022-03-28	1	\N	\N	\N	\N
\.


--
-- Data for Name: clearing; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clearing (id, clearing_expenses, invoice_id, register_expenses) FROM stdin;
1	$0.32	1	$0.00
\.


--
-- Data for Name: investors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.investors (id, user_id, full_name, document, cpf, birth_date, mother_full_name, created_at, deleted_at, updated_at) FROM stdin;
1	1	System Administrator	00000000000000	00000000000	2022-03-28	Machine	2022-03-28	\N	\N
2	2	Apressada da Silva	12345678901234	98765432109	1996-01-15	Muito Apressadona	2022-03-28	\N	\N
\.


--
-- Data for Name: invoices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invoices (id, investor_id, stock_broker_id, invoice_number, trading_floor_date, created_at, deleted_at, updated_at) FROM stdin;
1	2	12	9871462	2021-05-21	2022-03-29	\N	\N
\.


--
-- Data for Name: operational_costs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.operational_costs (id, operational_tax, custody_tax, municipal_tax, execution, tds, others, invoice_id) FROM stdin;
1	$0.00	$0.00	$0.00	$0.00	$0.00	$0.00	1
\.


--
-- Data for Name: operations_real_estate_investment_funds; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.operations_real_estate_investment_funds (id, invoice_id, real_estate_investment_fund_id, quantity, unit_value, operation) FROM stdin;
\.


--
-- Data for Name: operations_stocks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.operations_stocks (id, invoice_id, stock_id, quantity, unit_value, operation) FROM stdin;
1	1	2800	100	$12.90	C
\.


--
-- Data for Name: phones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.phones (id, city_code, phone_number, investor_id, created_at, deleted_at, updated_at) FROM stdin;
1	68	32232201	1	2022-03-28	\N	\N
2	19	32252491	2	2022-03-28	\N	\N
\.


--
-- Data for Name: real_estate_investment_funds; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.real_estate_investment_funds (id, ticker_symbol, real_estate_investment_funds_name, real_estate_investment_funds_cnpj, "real_estate_investment_funds-administrator_id", created_by, created_at, updated_by, updated_at, deleted_by, deleted_at) FROM stdin;
1	ABCP11	FUNDO DE INVESTIMENTO IMOBILIÁRIO GRAND PLAZA SHOPPING	01201140000190	34	1	2022-03-28	\N	\N	\N	\N
2	AFCR11	AF INVEST FUNDO DE INVESTIMENTO IMOBILIÁRIO - RECEBÍVEIS IMOBILIÁRIOS	32065364000146	6	1	2022-03-28	\N	\N	\N	\N
3	AFHI11	AF INVEST CRI FUNDO DE INVESTIMENTO IMOBILIÁRIO - RECEBÍVEIS IMOBILIÁRIOS	36642293000158	26	1	2022-03-28	\N	\N	\N	\N
4	AFOF11	ALIANZA FOF FUNDO DE INVESTIMENTO IMOBILIÁRIO	34847063000108	13	1	2022-03-28	\N	\N	\N	\N
5	AIEC11	AUTONOMY EDIFÍCIOS CORPORATIVOS FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	35765826000126	10	1	2022-03-28	\N	\N	\N	\N
6	ALZR11	ALIANZA TRUST RENDA IMOBILIARIA - FUNDO DE INVESTIMENTO IMOBILIARIO	28737771000185	26	1	2022-03-28	\N	\N	\N	\N
7	ANCR	FII ANCAR IC	07789135000127	17	1	2022-03-28	\N	\N	\N	\N
8	APTO11	NAVI RESIDENCIAL FUNDO DE INVESTIMENTO IMOBILIÁRIO	42432327000182	13	1	2022-03-28	\N	\N	\N	\N
9	ARCT11	RIZA ARCTIUM REAL ESTATE FUNDO DE INVESTIMENTO IMOBILIÁRIO	28267696000136	26	1	2022-03-28	\N	\N	\N	\N
10	ARRI11	FUNDO DE INVESTIMENTO IMOBILIÁRIO ÁTRIO REIT RECEBÍVEIS IMOBILIÁRIOS	32006821000121	21	1	2022-03-28	\N	\N	\N	\N
11	ATCR11	HAZ FUNDO DE INVESTIMENTO IMOBILIÁRIO	14631148000139	23	1	2022-03-28	\N	\N	\N	\N
12	BARI11	FUNDO DE INVESTIMENTO IMOBILIÁRIO BARIGUI RENDIMENTOS IMOBILIÁRIOS I FII	29267567000100	21	1	2022-03-28	\N	\N	\N	\N
13	BBFI11B	BB FUNDO DE INVESTIMENTO IMOBILIARIO PROGRESSIVO	07000400000146	26	1	2022-03-28	\N	\N	\N	\N
14	BBFO11	BB FUNDO DE FUNDOS - FUNDO DE INVESTIMENTO IMOBILIÁRIO	37180091000102	18	1	2022-03-28	\N	\N	\N	\N
15	BBGO11	BB FUNDO DE INVESTIMENTO DE CRÉDITO FIAGRO-IMOBILIÁRIO	42592257000120	18	1	2022-03-28	\N	\N	\N	\N
16	BBIM11	BB RECEBÍVEIS IMOBILIÁRIOS FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	20716161000193	18	1	2022-03-28	\N	\N	\N	\N
17	BBPO11	BB PROGRESSIVO II FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	14410722000129	9	1	2022-03-28	\N	\N	\N	\N
18	BBRC11	BB RENDA CORPORATIVA FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	12681340000104	9	1	2022-03-28	\N	\N	\N	\N
19	BCFF11	FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII BTG PACTUAL FUNDO DE FUNDOS	11026627000138	26	1	2022-03-28	\N	\N	\N	\N
20	BCIA11	BRADESCO CARTEIRA IMOBILIÁRIA ATIVA - FUNDO DE FUNDOS DE INVESTIMENTO IMOBILIÁRIO - FII	20216935000117	27	1	2022-03-28	\N	\N	\N	\N
21	BCLA11	BLUEMACAW CATUAÍ TRIPLE A FUNDO DE INVESTIMENTO IMOBILIÁRIO	41076748000155	26	1	2022-03-28	\N	\N	\N	\N
22	BCRI11	BANESTES RECEBIVEIS IMOBILIARIOS FUNDO DE INVESTIMENTO IMOBILIARIO	22219335000138	13	1	2022-03-28	\N	\N	\N	\N
23	BICE11	BRIO CRÉDITO ESTRUTURADO - FUNDO DE INVESTIMENTO IMOBILIÁRIO	39332032000120	13	1	2022-03-28	\N	\N	\N	\N
24	BICR11	INTER TITULOS IMOBILIARIOS FUNDO DE INVESTIMENTO IMOBILIARIO	34007109000172	15	1	2022-03-28	\N	\N	\N	\N
25	BIME11	BRIO MULTIESTRATEGIA - FUNDO DE INVESTIMENTO IMOBILIARIO	41081356000184	13	1	2022-03-28	\N	\N	\N	\N
26	BLCP11	BLUECAP RENDA LOGÍSTICA FUNDO DE INVESTIMENTO IMOBILIÁRIO -FII	35652060000173	26	1	2022-03-28	\N	\N	\N	\N
27	BLMC11	BLUEMACAW CRÉDITO IMOBILIÁRIO - FUNDO DE INVESTIMENTO IMOBILIÁRIO	38294221000192	26	1	2022-03-28	\N	\N	\N	\N
28	BLMG11	BLUEMACAW LOGÍSTICA FUNDO DE INVESTIMENTO IMOBILIÁRIO	34081637000171	16	1	2022-03-28	\N	\N	\N	\N
29	BLMO11	BLUEMACAW OFFICE FUND II - FUNDO DE INVESTIMENTO IMOBILIÁRIO	34895894000147	13	1	2022-03-28	\N	\N	\N	\N
30	BLMR11	BLUEMACAW RENDA+ FOF FUNDO DE INVESTIMENTO IMOBILIÁRIO	36368869000130	13	1	2022-03-28	\N	\N	\N	\N
31	BMLC11	FII BM BRASCAN LAJES CORPORATIVAS	14376247000111	26	1	2022-03-28	\N	\N	\N	\N
32	BNFS11	BANRISUL NOVAS FRONTEIRAS FUNDO DE INVESTIMENTO IMOBILIARIO - FII	15570431000160	21	1	2022-03-28	\N	\N	\N	\N
33	BPFF11	FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII BRASIL PLURAL ABSOLUTO FUNDO DE FUNDOS	17324357000128	17	1	2022-03-28	\N	\N	\N	\N
34	BPML11	FUNDO DE INVESTIMENTO IMOBILIÁRIO BTG PACTUAL SHOPPINGS	33046142000149	26	1	2022-03-28	\N	\N	\N	\N
35	BPRP11	FUNDO DE INVESTIMENTO IMOBILIARIO - FII BRLPROP	29800650000101	26	1	2022-03-28	\N	\N	\N	\N
36	BRCO11	BRESCO LOGÍSTICA FUNDO DE INVESTIMENTO IMOBILIÁRIO	20748515000181	21	1	2022-03-28	\N	\N	\N	\N
37	BRCR11	FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII BTG PACTUAL CORPORATE OFFICE FUND	08924783000101	26	1	2022-03-28	\N	\N	\N	\N
38	BREV11	BRAZIL REAL ESTATE VICTORY FUND I - FUNDO DE INVESTIMENTO IMOBILIARIO	26195121000120	24	1	2022-03-28	\N	\N	\N	\N
39	BRIM11	BRIO REAL ESTATE II - FUNDO DE INVESTIMENTO IMOBILIÁRIO	23964843000103	13	1	2022-03-28	\N	\N	\N	\N
40	BRLA11	FUNDO DE INVESTIMENTO IMOBILIÁRIO - BRL PROP II	35652278000128	26	1	2022-03-28	\N	\N	\N	\N
41	BTAL11	FUNDO DE INVESTIMENTO IMOBILIÁRIO BTG PACTUAL AGRO LOGÍSTICA	36642244000115	26	1	2022-03-28	\N	\N	\N	\N
42	BTCR11	FUNDO DE INVESTIMENTO IMOBILIARIO - BTG PACTUAL CREDITO IMOBILIARIO	29787928000140	26	1	2022-03-28	\N	\N	\N	\N
43	BTLG11	BTG PACTUAL LOGÍSTICA FUNDO DE INVESTIMENTO IMOBILIÁRIO	11839593000109	26	1	2022-03-28	\N	\N	\N	\N
44	BTRA11	FUNDO DE INVESTIMENTO IMOBILIÁRIO BTG PACTUAL TERRAS AGRÍCOLAS	41076607000132	26	1	2022-03-28	\N	\N	\N	\N
45	BTSG11	BTSP I FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	36098375000183	15	1	2022-03-28	\N	\N	\N	\N
46	BTWR11	BTOWERS FUNDO DE INVESTIMENTO IMOBILIÁRIO	20132453000189	13	1	2022-03-28	\N	\N	\N	\N
47	BVAR11	FUNDO DE INVESTIMENTO IMOBILIÁRIO BRASIL VAREJO	21126204000143	34	1	2022-03-28	\N	\N	\N	\N
48	CARE11	BRAZILIAN GRAVEYARD AND DEATH CARE SERVICES FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	13584584000131	33	1	2022-03-28	\N	\N	\N	\N
49	CBOP11	CASTELLO BRANCO OFFICE PARK FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	17144039000185	28	1	2022-03-28	\N	\N	\N	\N
50	CCRF11	CANVAS CRI - FUNDO DE INVESTIMENTO IMOBILIÁRIO	40011268000143	26	1	2022-03-28	\N	\N	\N	\N
51	CEOC11	FUNDO DE INVESTIMENTO IMOBILIARIO - FII CEO CYRELA COMMERCIAL PROPERTIES	15799397000109	26	1	2022-03-28	\N	\N	\N	\N
52	CNES11	FII CENESP	13551286000145	26	1	2022-03-28	\N	\N	\N	\N
53	CORM11	CORE METROPOLIS FUNDO DE INVESTIMENTO IMOBILIÁRIO	38293921000162	26	1	2022-03-28	\N	\N	\N	\N
54	CPFF11	CAPITÂNIA REIT FOF - FUNDO DE INVESTIMENTO IMOBILIÁRIO	34081611000123	26	1	2022-03-28	\N	\N	\N	\N
55	CPTS11	CAPITÂNIA SECURITIES II FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	18979895000113	26	1	2022-03-28	\N	\N	\N	\N
56	CRFF11	CAIXA RIO BRAVO FUNDO DE FUNDOS DE INVESTIMENTO IMOBILIÁRIO II	31887401000139	3	1	2022-03-28	\N	\N	\N	\N
57	CTXT11	FUNDO DE INVESTIMENTO IMOBILIÁRIO CENTRO TEXTIL INTERNACIONAL	00762723000128	34	1	2022-03-28	\N	\N	\N	\N
58	CVBI11	FUNDO DE INVESTIMENTO IMOBILIÁRIO - VBI CRI	28729197000113	13	1	2022-03-28	\N	\N	\N	\N
59	CXCE11B	FUNDO DE INVESTIMENTO IMOBILIARIO CAIXA CEDAE	10991914000115	3	1	2022-03-28	\N	\N	\N	\N
60	CXCO11	FUNDO DE INVESTIMENTO IMOBILIÁRIO CAIXA IMÓVEIS CORPORATIVOS	38658984000175	16	1	2022-03-28	\N	\N	\N	\N
61	CXRI11	CAIXA RIO BRAVO FUNDO DE FUNDOS DE INVESTIMENTO IMOBILIARIO - FII	17098794000170	3	1	2022-03-28	\N	\N	\N	\N
62	CXTL11	FUNDO DE INVESTIMENTO IMOBILIARIO CAIXA SEQ LOGISTICA RENDA	12887506000143	3	1	2022-03-28	\N	\N	\N	\N
63	CYCR11	CYRELA CRÉDITO - FUNDO DE INVESTIMENTO IMOBILIÁRIO	36501233000115	25	1	2022-03-28	\N	\N	\N	\N
64	DEVA11	DEVANT RECEBÍVEIS IMOBILIÁRIOS FUNDO DE INVESTIMENTO IMOBILIÁRIO	37087810000137	16	1	2022-03-28	\N	\N	\N	\N
65	DLMT11	DEL MONTE AJAX  FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	28108193000118	33	1	2022-03-28	\N	\N	\N	\N
66	DMAC11	MAC FUNDO DE INVESTIMENTO IMOBILIÁRIO	30579348000146	21	1	2022-03-28	\N	\N	\N	\N
67	DOVL11B	DOVEL FII	10522648000181	13	1	2022-03-28	\N	\N	\N	\N
68	DRIT11	MULTIGESTÃO RENDA COMERCIAL FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	10456810000100	29	1	2022-03-28	\N	\N	\N	\N
69	DVFF11	FUNDO DE INVESTIMENTO IMOBILIÁRIO - DEVANT FUNDO DE FUNDOS IMOBILIÁRIOS	39863059000149	29	1	2022-03-28	\N	\N	\N	\N
70	EDFO11B	FII EDIFÍCIO OURINVEST	06175262000173	21	1	2022-03-28	\N	\N	\N	\N
71	EDGA11	FUNDO DE INVESTIMENTO IMOBILIARIO - FII EDIFICIO GALERIA	15333306000137	26	1	2022-03-28	\N	\N	\N	\N
72	ELDO11B	FII ELDORADO	13022994000199	34	1	2022-03-28	\N	\N	\N	\N
73	EQIA11	NCH EQI RECEBÍVEIS DO AGRONEGÓCIO- FIAGRO IMOBILIÁRIO	42537438000153	26	1	2022-03-28	\N	\N	\N	\N
74	EQIN11	Fundo de Investimento Imobiliário - NCH EQI High Yield Recebíveis Imobiliários	18085673000157	26	1	2022-03-28	\N	\N	\N	\N
75	EQIR11	EQI RECEBÍVEIS IMOBILIÁRIOS FUNDO DE INVESTIMENTO FII	41076380000125	26	1	2022-03-28	\N	\N	\N	\N
76	ERCR11	ESTOQUE RESIDENCIAL E COMERCIAL RIO DE JANEIRO FUNDO DE INVESTIMENTO IMOBILIÁRIO	37266902000184	21	1	2022-03-28	\N	\N	\N	\N
77	EURO11	FII EUROPAR	05437916000127	2	1	2022-03-28	\N	\N	\N	\N
78	EVBI11	VBI CONSUMO ESSENCIAL FUNDO DE INVESTIMENTO IMOBILIÁRIO	34691520000100	13	1	2022-03-28	\N	\N	\N	\N
79	EXES11	EXES FUNDO DE INVESTIMENTO IMOBILIÁRIO	41076851000103	26	1	2022-03-28	\N	\N	\N	\N
80	FAED11	FII ANHANGUERA EDUCACIONAL	11179118000145	26	1	2022-03-28	\N	\N	\N	\N
81	FATN11	FUNDO DE INVESTIMENTO IMOBILIÁRIO ATHENA I	30567216000102	24	1	2022-03-28	\N	\N	\N	\N
82	FCFL11	FII CAMPUS FARIA LIMA	11602654000101	26	1	2022-03-28	\N	\N	\N	\N
83	FEXC11	FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII BTG PACTUAL FUNDO DE CRI	09552812000114	26	1	2022-03-28	\N	\N	\N	\N
84	FGAA11	FG/AGRO FUNDO DE INVESTIMENTO NAS CADEIAS PRODUTIVAS AGROINDUSTRIAIS - FIAGRO-IMOBILIÁRIO	42405905000191	13	1	2022-03-28	\N	\N	\N	\N
85	FIGS11	GENERAL SHOPPING ATIVO E RENDA FUNDO DE INVESTIMENTO IMOBILIÁRIO	17590518000125	11	1	2022-03-28	\N	\N	\N	\N
86	FIIB11	FUNDO DE INVESTIMENTO IMOBILIARIO INDUSTRIAL DO BRASIL	14217108000145	2	1	2022-03-28	\N	\N	\N	\N
87	FIIP11B	RB CAPITAL RENDA I FUNDO DE INVESTIMENTO IMOBILIARIO - FII	08696175000197	21	1	2022-03-28	\N	\N	\N	\N
88	FINF11	FUNDO DE INVESTIMENTO IMOBILIÁRIO INFRA REAL ESTATE - FII	18369510000104	33	1	2022-03-28	\N	\N	\N	\N
89	FISC11	FUNDO DE INVESTIMENTO IMOBILIÁRIO SC 401	12804013000100	24	1	2022-03-28	\N	\N	\N	\N
90	FISD11	SÃO DOMINGOS - FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	16543270000189	23	1	2022-03-28	\N	\N	\N	\N
91	FLCR11	FARIA LIMA CAPITAL RECEBÍVEIS IMOBILIÁRIOS I - FUNDO DE INVESTIMENTO IMOBILIÁRIO	33884145000151	13	1	2022-03-28	\N	\N	\N	\N
92	FLMA11	FII CONTINENTAL SQUARE FARIA LIMA	04141645000103	24	1	2022-03-28	\N	\N	\N	\N
93	FLRP11	FII FLORIPA SHOPPING	10375382000191	26	1	2022-03-28	\N	\N	\N	\N
94	FMOB11	IMMOB III  FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	34691925000148	1	1	2022-03-28	\N	\N	\N	\N
95	FPAB11	FII PROJ AGUA BRANCA	03251720000118	2	1	2022-03-28	\N	\N	\N	\N
96	FPNG11	FUNDO DE INVESTIMENTO IMOBILIÁRIO PEDRA NEGRA RENDA IMOBILIÁRIA	17161979000182	24	1	2022-03-28	\N	\N	\N	\N
97	FTCE11B	OPPORTUNITY FUNDO DE INVESTIMENTO IMOBILIÁRIO	01235622000161	13	1	2022-03-28	\N	\N	\N	\N
98	FVPQ11	FUNDO DE INVESTIMENTO IMOBILIÁRIO VIA PARQUE SHOPPING - FII	00332266000131	34	1	2022-03-28	\N	\N	\N	\N
99	GALG11	Fundo de Investimento Imobiliário Guardian Logística	37295919000160	13	1	2022-03-28	\N	\N	\N	\N
100	GAME11	FUNDO DE INVESTIMENTO IMOBILIÁRIO GUARDIAN MULTIESTRATÉGIA IMOBILIÁRIA I	41269052000145	29	1	2022-03-28	\N	\N	\N	\N
101	GCFF11	GALAPAGOS FUNDO DE FUNDOS - FII FUNDO DE INVESTIMENTO IMOBILIÁRIO	35652154000142	26	1	2022-03-28	\N	\N	\N	\N
102	GCRA11	GALAPAGOS RECEBÍVEIS DO AGRONEGÓCIO - FIAGRO-IMOBILIÁRIO	37037297000170	30	1	2022-03-28	\N	\N	\N	\N
103	GCRI11	GALAPAGOS RECEBÍVEIS IMOBILIÁRIOS - FUNDO DE INVESTIMENTO IMOBILIÁRIO	38293897000161	26	1	2022-03-28	\N	\N	\N	\N
104	GESE11	FUNDO DE INVESTIMENTO IMOBILIARIO GENERAL SEVERIANO	17007528000195	21	1	2022-03-28	\N	\N	\N	\N
105	GGRC11	GGR COVEPI RENDA FUNDO DE INVESTIMENTO IMOBILIÁRIO	26614291000100	6	1	2022-03-28	\N	\N	\N	\N
106	GTLG11	GTIS BRAZIL LOGISTICS FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	36200677000110	13	1	2022-03-28	\N	\N	\N	\N
107	GTWR11	FUNDO DE INVESTIMENTO IMOBILIÁRIO GREEN TOWERS	23740527000158	9	1	2022-03-28	\N	\N	\N	\N
108	HAAA11	HEDGE AAA FUNDO DE INVESTIMENTO IMOBILIÁRIO	27445482000140	11	1	2022-03-28	\N	\N	\N	\N
109	HABT11	HABITAT RECEBÍVEIS PULVERIZADOS FUNDO DE INVESTIMENTO IMOBILIÁRIO	30578417000105	16	1	2022-03-28	\N	\N	\N	\N
110	HBCR11	FUNDO DE INVESTIMENTO IMOBILIÁRIO HBC RENDA URBANA	36501159000137	25	1	2022-03-28	\N	\N	\N	\N
111	HBRH11	FUNDO DE INVESTIMENTO IMOBILIÁRIO MULTI RENDA URBANA	30871698000181	13	1	2022-03-28	\N	\N	\N	\N
112	HCHG11	HECTARE RECEBÍVEIS HIGH GRADE FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	34508959000154	16	1	2022-03-28	\N	\N	\N	\N
113	HCRI11	FII HOSPITAL DA CRIANÇA	04066582000160	26	1	2022-03-28	\N	\N	\N	\N
114	HCTR11	HECTARE CE - FUNDO DE INVESTIMENTO IMOBILIÁRIO	30248180000196	16	1	2022-03-28	\N	\N	\N	\N
115	HFOF11	HEDGE TOP FOFII 3 FUNDO DE INVESTIMENTO IMOBILIÁRIO	18307582000119	11	1	2022-03-28	\N	\N	\N	\N
116	HGBS11	HEDGE BRASIL SHOPPING FUNDO DE INVESTIMENTO IMOBILIÁRIO	08431747000106	11	1	2022-03-28	\N	\N	\N	\N
117	HGCR11	CSHG RECEBÍVEIS IMOBILIÁRIOS - FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	11160521000122	28	1	2022-03-28	\N	\N	\N	\N
118	HGFF11	CSHG IMOBILIÁRIO FOF - FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	32784898000122	28	1	2022-03-28	\N	\N	\N	\N
119	HGIC11	HGI CRÉDITOS IMOBILIÁRIOS FUNDO DE INVESTIMENTO IMOBILIÁRIO	38456508000171	16	1	2022-03-28	\N	\N	\N	\N
120	HGLG11	CSHG LOGÍSTICA - FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	11728688000147	28	1	2022-03-28	\N	\N	\N	\N
121	HGPO11	CSHG PRIME OFFICES - FUNDO DE INVESTIMENTO IMOBILIÁRIO FII	11260134000168	28	1	2022-03-28	\N	\N	\N	\N
122	HGRE11	CSHG REAL ESTATE - FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	09072017000129	28	1	2022-03-28	\N	\N	\N	\N
123	HGRS11	CSHG RESIDENCIAL - FUNDO DE INVESTIMENTO IMOBILIARIO - FII	41922239000104	28	1	2022-03-28	\N	\N	\N	\N
124	HGRU11	CSHG RENDA URBANA - FUNDO DE INVESTIMENTO IMOBILIARIO - FII	29641226000153	28	1	2022-03-28	\N	\N	\N	\N
125	HLOG11	HEDGE LOGÍSTICA FUNDO DE INVESTIMENTO IMOBILIÁRIO	27486542000172	11	1	2022-03-28	\N	\N	\N	\N
126	HOSI11	FUNDO DE INVESTIMENTO IMOBILIÁRIO HOUSI	34081631000102	16	1	2022-03-28	\N	\N	\N	\N
127	HPDP11	HEDGE SHOPPING PARQUE DOM PEDRO FUNDO DE INVESTIMENTO IMOBILIÁRIO	35586415000173	11	1	2022-03-28	\N	\N	\N	\N
128	HREC11	HEDGE RECEBÍVEIS IMOBILIÁRIOS FUNDO DE INVESTIMENTO IMOBILIÁRIO	35507262000121	11	1	2022-03-28	\N	\N	\N	\N
129	HSAF11	HSI ATIVOS FINANCEIROS - FUNDO DE INVESTIMENTO IMOBILIÁRIO	35360687000150	13	1	2022-03-28	\N	\N	\N	\N
130	HSLG11	HSI LOGÍSTICA FUNDO DE INVESTIMENTO IMOBILIÁRIO	32903621000171	13	1	2022-03-28	\N	\N	\N	\N
131	HSML11	HSI MALLS FUNDO DE INVESTIMENTO IMOBILIÁRIO	32892018000131	31	1	2022-03-28	\N	\N	\N	\N
132	HSRE11	HSI RENDA IMOBILIÁRIA FUNDO DE INVESTIMENTO IMOBILIÁRIO	08098114000128	13	1	2022-03-28	\N	\N	\N	\N
133	HUSC11	FUNDO DE INVESTIMENTO IMOBILIARIO HOSPITAL UNIMED SUL CAPIXABA	28851767000143	34	1	2022-03-28	\N	\N	\N	\N
134	IBCR11	FUNDO DE INVESTIMENTO IMOBILIÁRIO DE CRI INTEGRAL BREI	40011251000196	26	1	2022-03-28	\N	\N	\N	\N
135	IBFF11	FUNDO DE INVESTIMENTO IMOBILIARIO FOF INTEGRAL BREI	33721517000129	26	1	2022-03-28	\N	\N	\N	\N
136	IDFI11	Fundo de Investimento Imobiliário de Unidades Autônomas	32774914000104	14	1	2022-03-28	\N	\N	\N	\N
137	IDGR11	Fundo de Investimento Imobiliário de Unidades Autônomas II	44177538000141	14	1	2022-03-28	\N	\N	\N	\N
138	IFID11	IFI-D FUNDO DE INVESTIMENTO IMOBILIARIO - FII	36312772000106	15	1	2022-03-28	\N	\N	\N	\N
139	IFIE11	IFI-E FUNDO DE INVESTIMENTO IMOBILIARIO - FII	36293425000183	15	1	2022-03-28	\N	\N	\N	\N
140	IMIV11	IMMOB IV - BRAGANÇA FUNDO DE INVESTIMENTO IMOBILIÁRIO	34693040000188	1	1	2022-03-28	\N	\N	\N	\N
141	IMMO11	IMMOB II FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	32655589000152	1	1	2022-03-28	\N	\N	\N	\N
142	IRDM11	FUNDO DE INVESTIMENTO IMOBILIARIO IRIDIUM RECEBIVEIS IMOBILIARIOS	28830325000110	26	1	2022-03-28	\N	\N	\N	\N
143	IRIM11	IRIDIUM FUNDO DE INVESTIMENTO IMOBILIÁRIO	41076564000195	26	1	2022-03-28	\N	\N	\N	\N
144	JBFO11	JBFO FOF FUNDO DE INVESTIMENTO IMOBILIÁRIO	36615915000159	1	1	2022-03-28	\N	\N	\N	\N
145	JFLL11	JFL LIVING FUNDO DE INVESTIMENTO IMOBILIÁRIO	36501181000187	25	1	2022-03-28	\N	\N	\N	\N
146	JGPX11	FUNDO DE INVESTIMENTO NAS CADEIAS PRODUTIVAS AGROINDUSTRIAIS JGP CRÉDITO - FIAGRO - IMOBILIÁRIO	42888292000190	29	1	2022-03-28	\N	\N	\N	\N
147	JPPA11	JPP ALLOCATON MOGNO FUNDO DE INVESTIMENTO IMOBILIÁRIO	30982880000100	16	1	2022-03-28	\N	\N	\N	\N
148	JPPC11	JPP CAPITAL FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	17216625000198	12	1	2022-03-28	\N	\N	\N	\N
149	JRDM11	FII SHOPPING JARDIM SUL	14879856000193	26	1	2022-03-28	\N	\N	\N	\N
150	JSAF11	JS ATIVOS FINANCEIROS FUNDO DE INVESTIMENTO IMOBILIÁRIO	42085661000107	7	1	2022-03-28	\N	\N	\N	\N
151	JSRE11	JS REAL ESTATE MULTIGESTÃO - FII	13371132000171	7	1	2022-03-28	\N	\N	\N	\N
152	JTPR11	JT PREV FUNDO DE INVESTIMENTO IMOBILIÁRIO D. HAB	23876086000116	4	1	2022-03-28	\N	\N	\N	\N
153	KEVE11	EVEN II KINEA FUNDO DE INVESTIMENTO IMOBILIÁRIO	32317313000164	32	1	2022-03-28	\N	\N	\N	\N
154	KFOF11	FUNDO DE FUNDOS DE INVESTIMENTO IMOBILIÁRIO KINEA FII	30091444000140	32	1	2022-03-28	\N	\N	\N	\N
155	KINP11	EVEN PERMUTA KINEA FII - FUNDO DE INVESTIMENTO IMOBILIÁRIO	24070076000151	32	1	2022-03-28	\N	\N	\N	\N
156	KISU11	KILIMA FUNDO DE INVESTIMENTO EM COTAS DE FUNDOS IMOBILIÁRIOS SUNO 30	36669660000107	13	1	2022-03-28	\N	\N	\N	\N
157	KIVO11	KILIMA VOLKANO RECEBÍVEIS IMOBILIARIOS FUNDO DE INVESTIMENTO IMOBILIARIO	42273325000198	13	1	2022-03-28	\N	\N	\N	\N
158	KNCA11	KINEA CRÉDITO AGRO FIAGRO-IMOBILIÁRIO	41745701000137	32	1	2022-03-28	\N	\N	\N	\N
159	KNCR11	KINEA RENDIMENTOS IMOBILIARIOS FUNDO DE INVESTIMENTO IMOBILIARIO - FII	16706958000132	32	1	2022-03-28	\N	\N	\N	\N
160	KNHY11	KINEA HIGH YIELD CRI FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	30130708000128	32	1	2022-03-28	\N	\N	\N	\N
161	KNIP11	KINEA ÍNDICES DE PREÇOS FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	24960430000113	32	1	2022-03-28	\N	\N	\N	\N
162	KNRE11	KINEA II REAL ESTATE EQUITY FII	14423780000197	32	1	2022-03-28	\N	\N	\N	\N
163	KNRI11	KINEA RENDA IMOBILIÁRIA FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	12005956000165	32	1	2022-03-28	\N	\N	\N	\N
164	KNSC11	KINEA SECURITIES FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	35864448000138	32	1	2022-03-28	\N	\N	\N	\N
165	LASC11	LEGATUS SHOPPINGS FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	30248158000146	16	1	2022-03-28	\N	\N	\N	\N
166	LATR11B	LATERES FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	17209378000100	21	1	2022-03-28	\N	\N	\N	\N
167	LAVF11	LAVOURA FUNDO DE INVESTIMENTO IMOBILIÁRIO	37467733000140	24	1	2022-03-28	\N	\N	\N	\N
168	LFTT11	LOFT II FUNDO DE INVESTIMENTO IMOBILIÁRIO	24796967000190	10	1	2022-03-28	\N	\N	\N	\N
169	LGCP11	LOGCP INTER FUNDO DE INVESTIMENTO IMOBILIARIO	34598181000111	15	1	2022-03-28	\N	\N	\N	\N
170	LOFT12B	LOFT I FUNDO DE INVESTIMENTO IMOBILIÁRIO	19722048000131	22	1	2022-03-28	\N	\N	\N	\N
171	LPLP11	LAGO DA PEDRA - FUNDO DE INVESTIMENTO IMOBILIÁRIO	37262752000130	21	1	2022-03-28	\N	\N	\N	\N
172	LSPA11	LESTE RIVA EQUITY PREFERENCIAL I FUNDO DE INVESTIMENTO IMOBILIÁRIO	31847293000170	25	1	2022-03-28	\N	\N	\N	\N
173	LUGG11	LUGGO FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	34835191000123	15	1	2022-03-28	\N	\N	\N	\N
174	LVBI11	FUNDO DE INVESTIMENTO IMOBILIARIO - VBI LOGISTICO	30629603000118	26	1	2022-03-28	\N	\N	\N	\N
175	MALL11	MALLS BRASIL PLURAL FUNDO DE INVESTIMENTO IMOBILIÁRIO	26499833000132	17	1	2022-03-28	\N	\N	\N	\N
176	MATV11	MORE GESTÃO ATIVA DE RECEBÍVEIS FUNDO DE INVESTIMENTO IMOBILIÁRIO	41076678000135	26	1	2022-03-28	\N	\N	\N	\N
177	MAXR11	FII MAX RETAIL	11274415000170	26	1	2022-03-28	\N	\N	\N	\N
178	MBRF11	FUNDO DE INVESTIMENTO IMOBILIÁRIO MERCANTIL DO BRASIL - FII	13500306000159	34	1	2022-03-28	\N	\N	\N	\N
179	MCCI11	FUNDO DE INVESTIMENTO IMOBILIÁRIO MAUÁ CAPITAL RECEBÍVEIS IMOBILIÁRIOS - FII	23648935000184	26	1	2022-03-28	\N	\N	\N	\N
180	MCHF11	MAUÁ CAPITAL HEDGE FUND FUNDO DE INVESTIMENTO IMOBILIÁRIO	36642139000186	26	1	2022-03-28	\N	\N	\N	\N
181	MCHY11	FUNDO DE INVESTIMENTO IMOBILIÁRIO MAUÁ HIGH YIELD - FII	36655973000106	26	1	2022-03-28	\N	\N	\N	\N
182	MFAI11	Mérito Fundos e Ações Imobiliárias FII - Fundo de Investimento Imobiliário	32397369000176	33	1	2022-03-28	\N	\N	\N	\N
183	MFII11	MERITO DESENVOLVIMENTO IMOBILIARIO I FII - FUNDO DE INVESTIMENTO IMOBILIARIO	16915968000188	4	1	2022-03-28	\N	\N	\N	\N
184	MGCR11	FUNDO DE INVESTIMENTO IMOBILIÁRIO MOGNO CERTIFICADOS DE RECEBÍVEIS IMOBILIÁRIOS HIGH GRADE	35652204000191	26	1	2022-03-28	\N	\N	\N	\N
185	MGFF11	FUNDO DE INVESTIMENTO IMOBILIARIO MOGNO FUNDO DE FUNDOS	29216463000177	26	1	2022-03-28	\N	\N	\N	\N
186	MGHT11	FUNDO DE INVESTIMENTO IMOBILIÁRIO - MOGNO HOTEIS	34197776000165	26	1	2022-03-28	\N	\N	\N	\N
187	MGIM11	FUNDO DE INVESTIMENTO IMOBILIÁRIO MOGNO REAL ESTATE IMPACT DEVELOPMENT FUND	36642099000172	26	1	2022-03-28	\N	\N	\N	\N
188	MGLG11	MOGNO LOGISTICA FUNDO DE INVESTIMENTO IMOBILIARIO - FII	40041711000129	13	1	2022-03-28	\N	\N	\N	\N
189	MMPD11	FUNDO DE INVESTIMENTO IMOBILIÁRIO MAUÁ CAPITAL MPD DESENVOLVIMENTO RESIDENCIAL	41080968000152	26	1	2022-03-28	\N	\N	\N	\N
190	MORC11	MORE RECEBÍVEIS IMOBILIÁRIOS FII FUNDO DE INVESTIMENTO IMOBILIÁRIO	40102474000169	26	1	2022-03-28	\N	\N	\N	\N
191	MORE11	MORE REAL ESTATE FOF FII FUNDO DE INVESTIMENTO IMOBILIÁRIO	34197727000122	26	1	2022-03-28	\N	\N	\N	\N
192	MXRF11	MAXI RENDA FUNDO DE INVESTIMENTO IMOBILIARIO - FII	97521225000125	26	1	2022-03-28	\N	\N	\N	\N
193	NAVT11	NAVI IMOBILIÁRIO TOTAL RETURN FUNDO DE INVESTIMENTO IMOBILIÁRIO	35652252000180	26	1	2022-03-28	\N	\N	\N	\N
194	NEWL11	NEWPORT LOGÍSTICA FUNDO DE INVESTIMENTO IMOBILIÁRIO	32527626000147	25	1	2022-03-28	\N	\N	\N	\N
195	NSLU11	FII HOSPITAL NOSSA SENHORA DE LOURDES	08014513000163	26	1	2022-03-28	\N	\N	\N	\N
196	NVHO11	FUNDO DE INVESTIMENTO IMOBILIARIO - FII NOVO HORIZONTE	17025970000144	25	1	2022-03-28	\N	\N	\N	\N
197	NVIF11B	NOVA I - FUNDO DE INVESTIMENTO IMOBILIARIO - FII	22003469000117	22	1	2022-03-28	\N	\N	\N	\N
198	ONEF11	FUNDO DE INVESTIMENTO IMOBILIÁRIO THE ONE	12948291000123	34	1	2022-03-28	\N	\N	\N	\N
199	OUFF11	FUNDO DE INVESTIMENTO IMOBILIÁRIO - OURINVEST FUNDO DE FUNDOS	30791386000168	35	1	2022-03-28	\N	\N	\N	\N
200	OUJP11	OURINVEST JPP FUNDO DE INVESTIMENTO IMOBILIÁRIO- FII	26091656000150	8	1	2022-03-28	\N	\N	\N	\N
201	OULG11	FUNDO DE INVESTIMENTO IMOBILIÁRIO OURINVEST LOGÍSTICA	13974819000100	35	1	2022-03-28	\N	\N	\N	\N
202	OURE11	FUNDO DE INVESTIMENTO IMOBILIÁRIO OURINVEST RENDA ESTRUTURADA	28516650000103	35	1	2022-03-28	\N	\N	\N	\N
203	PATB11	FUNDO DE INVESTIMENTO IMOBILIARIO - FII PATEO BANDEIRANTES	14788492000136	26	1	2022-03-28	\N	\N	\N	\N
204	PATC11	PÁTRIA EDIFÍCIOS CORPORATIVOS FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	30048651000112	10	1	2022-03-28	\N	\N	\N	\N
205	PATL11	PÁTRIA LOGÍSTICA FUNDO DE INVESTIMENTO IMOBILIÁRIO	35754164000199	16	1	2022-03-28	\N	\N	\N	\N
206	PBLV11	PROLOGIS BRAZIL LOGISTICS VENTURE FUNDO DE INVESTIMENTO IMOBILIÁRIO	31962875000106	13	1	2022-03-28	\N	\N	\N	\N
207	PEMA11	PERFORMA REAL ESTATE - FUNDO DE INVESTIMENTO IMOBILIÁRIO	34736510000143	13	1	2022-03-28	\N	\N	\N	\N
208	PLCR11	PLURAL RECEBÍVEIS IMOBILIÁRIOS FUNDO DE INVESTIMENTO IMOBILIÁRIO	32527683000126	25	1	2022-03-28	\N	\N	\N	\N
209	PLOG11	PLURAL LOGÍSTICA FUNDO DE INVESTIMENTO IMOBILIÁRIO	36501198000134	25	1	2022-03-28	\N	\N	\N	\N
210	PLRI11	POLO FII - FII RECEBÍVEIS IMOBILIÁRIOS I	14080689000116	21	1	2022-03-28	\N	\N	\N	\N
211	PORD11	POLO FUNDO DE INVESTIMENTO IMOBILIARIO - RECEBIVEIS IMOBILIARIOS II - FII	17156502000109	21	1	2022-03-28	\N	\N	\N	\N
212	PQAG11	PARQUE ANHANGUERA FUNDO DE INVESTIMENTO IMOBILIÁRIO	12978943000172	11	1	2022-03-28	\N	\N	\N	\N
213	PQDP11	FII PARQUE DOM PEDRO SHOPPING CENTER	10869155000112	26	1	2022-03-28	\N	\N	\N	\N
214	PRSN11B	PERSONALE I FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	14056001000162	21	1	2022-03-28	\N	\N	\N	\N
215	PURB11	PLURAL RENDA URBANA FUNDO DE INVESTIMENTO IMOBILIÁRIO	36501210000100	25	1	2022-03-28	\N	\N	\N	\N
216	PVBI11	FUNDO DE INVESTIMENTO IMOBILIÁRIO - VBI PRIME PROPERTIES	35652102000176	26	1	2022-03-28	\N	\N	\N	\N
217	QAGR11	QUASAR AGRO - FUNDO DE INVESTIMENTO IMOBILIARIO	32754734000152	26	1	2022-03-28	\N	\N	\N	\N
218	QAMI11	QUASAR CRÉDITO IMOBILIÁRIO FUNDO DE INVESTIMENTO IMOBILIÁRIO	32400264000129	25	1	2022-03-28	\N	\N	\N	\N
219	QIRI11	QUATÁ IMOB RECEBÍVEIS IMOBILIÁRIOS - FUNDO DE INVESTIMENTO IMOBILIÁRIO	34736432000187	13	1	2022-03-28	\N	\N	\N	\N
220	RBCO11	RB CAPITAL OFFICE INCOME FUNDO DE INVESTIMENTO IMOBILIÁRIO	31894369000119	13	1	2022-03-28	\N	\N	\N	\N
221	RBED11	FUNDO DE INVESTIMENTO IMOBILIÁRIO RIO BRAVO RENDA EDUCACIONAL- FII	13873457000152	34	1	2022-03-28	\N	\N	\N	\N
222	RBFF11	RIO BRAVO FUNDO DE FUNDOS DE INVESTIMENTO IMOBILIÁRIO	17329029000114	13	1	2022-03-28	\N	\N	\N	\N
223	RBGS11	RB CAPITAL GENERAL SHOPPING SULACAP  FII	13652006000195	21	1	2022-03-28	\N	\N	\N	\N
224	RBHG11	RIO BRAVO CRÉDITO IMOBILIÁRIO HIGH GRADE FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	30647758000187	13	1	2022-03-28	\N	\N	\N	\N
225	RBHY11	RIO BRAVO CRÉDITO IMOBILIÁRIO HIGH YIELD FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	37899479000150	13	1	2022-03-28	\N	\N	\N	\N
226	RBLG11	RB CAPITAL LOGÍSTICO FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	35652227000104	26	1	2022-03-28	\N	\N	\N	\N
227	RBRD11	RB CAPITAL RENDA II FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	09006914000134	9	1	2022-03-28	\N	\N	\N	\N
228	RBRF11	RBR ALPHA MULTIESTRATÉGIA REAL ESTATE FUNDO DE INVESTIMENTO IMOBILIÁRIO	27529279000151	26	1	2022-03-28	\N	\N	\N	\N
229	RBRI11	FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII RBR DESENVOLVIMENTO III	32441656000136	26	1	2022-03-28	\N	\N	\N	\N
230	RBRL11	RBR LOG  FUNDO DE INVESTIMENTO IMOBILIÁRIO	35705463000133	13	1	2022-03-28	\N	\N	\N	\N
231	RBRM11	FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII RBR DESENVOLVIMENTO	26314437000193	26	1	2022-03-28	\N	\N	\N	\N
232	RBRP11	FUNDO DE INVESTIMENTO IMOBILIARIO RBR PROPERTIES - FII	21408063000151	13	1	2022-03-28	\N	\N	\N	\N
233	RBRR11	FUNDO DE INVESTIMENTO IMOBILIARIO - FII RBR RENDIMENTO HIGH GRADE	29467977000103	26	1	2022-03-28	\N	\N	\N	\N
234	RBRS11	Rio Bravo Renda Residencial Fundo de Investimento Imobiliario	36517660000191	34	1	2022-03-28	\N	\N	\N	\N
235	RBRY11	Fundo de Investimento Imobiliário RBR Crédito Imobiliário Estruturado	30166700000111	26	1	2022-03-28	\N	\N	\N	\N
236	RBTS11	RB CAPITAL TFO SITUS FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	29299737000139	21	1	2022-03-28	\N	\N	\N	\N
237	RBVA11	FUNDO DE INVESTIMENTO IMOBILIÁRIO RIO BRAVO RENDA VAREJO - FII	15576907000170	34	1	2022-03-28	\N	\N	\N	\N
238	RBVO11	RIO BRAVO CRÉDITO IMOBILIÁRIO II FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	15769670000144	34	1	2022-03-28	\N	\N	\N	\N
239	RCFF11	RBR DESENVOLVIMENTO COMERCIAL FEEDER FOF  FUNDO DE INVESTIMENTO IMOBILIÁRIO	35689670000141	13	1	2022-03-28	\N	\N	\N	\N
240	RCRB11	FUNDO DE INVESTIMENTO IMOBILIÁRIO RIO BRAVO RENDA CORPORATIVA	03683056000186	34	1	2022-03-28	\N	\N	\N	\N
241	RCRI11	RB CAPITAL RENDIMENTOS IMOBILIARIOS FUNDO DE INVESTIMENTO IMOBILIARIO - FII	26511274000139	21	1	2022-03-28	\N	\N	\N	\N
242	RDPD11	BB RENDA DE PAPÉIS IMOBILIÁRIOS II FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	23120027000113	9	1	2022-03-28	\N	\N	\N	\N
243	RECR11	FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII REC RECEBÍVEIS IMOBILIÁRIOS	28152272000126	13	1	2022-03-28	\N	\N	\N	\N
244	RECT11	FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII REC RENDA IMOBILIÁRIA	32274163000159	13	1	2022-03-28	\N	\N	\N	\N
245	RECX11	FUNDO DE INVESTIMENTO IMOBILIÁRIO - REC FUNDO DE FUNDOS	36642356000176	26	1	2022-03-28	\N	\N	\N	\N
246	REIT11	SINGULARE FUNDO DE INVESTIMENTO IMOBILIÁRIO	16841067000199	30	1	2022-03-28	\N	\N	\N	\N
247	RELG11	FUNDO DE INVESTIMENTO IMOBILIÁRIO REC LOGÍSTICA	37112770000136	13	1	2022-03-28	\N	\N	\N	\N
248	RFOF11	FUNDO DE INVESTIMENTO IMOBILIÁRIO RB CAPITAL I FUNDO DE FUNDOS	34027774000128	13	1	2022-03-28	\N	\N	\N	\N
249	RMAI11	REAG MULTI ATIVOS IMOBILIÁRIOS - FUNDO DE INVESTIMENTO IMOBILIÁRIO	17374696000119	20	1	2022-03-28	\N	\N	\N	\N
250	RNDP11	BB RENDA DE PAPÉIS IMOBILIÁRIOS FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	15394563000189	9	1	2022-03-28	\N	\N	\N	\N
251	RNGO11	FUNDO DE INVESTIMENTO IMOBILIÁRIO RIO NEGRO - FII	15006286000190	34	1	2022-03-28	\N	\N	\N	\N
252	RNOV12	IMMOB I FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	28893734000166	1	1	2022-03-28	\N	\N	\N	\N
253	RRCI11	RB CAPITAL RECEBÍVEIS IMOBILIÁRIOS FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	35689733000160	13	1	2022-03-28	\N	\N	\N	\N
254	RSPD11	RB CAPITAL DESENVOLVIMENTO RESIDENCIAL III FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	19249989000108	21	1	2022-03-28	\N	\N	\N	\N
255	RVBI11	VBI REITS FOF - FUNDO DE INVESTIMENTO IMOBILIÁRIO	35507457000171	13	1	2022-03-28	\N	\N	\N	\N
256	RZAG11	FUNDO DE INVESTIMENTO NAS CADEIAS PRODUTIVAS AGROINDUSTRIAIS RIZA AGRO - FIAGRO - IMOBILIÁRIO	40413979000144	25	1	2022-03-28	\N	\N	\N	\N
257	RZAK11	RIZA AKIN FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	36642219000131	26	1	2022-03-28	\N	\N	\N	\N
258	RZTR11	FUNDO DE INVESTIMENTO IMOBILIÁRIO RIZA TERRAX	36501128000186	25	1	2022-03-28	\N	\N	\N	\N
259	SADI11	SANTANDER PAPÉIS IMOBILIÁRIOS CDI FUNDO DE INVESTIMENTO IMOBILIÁRIO	32903521000145	31	1	2022-03-28	\N	\N	\N	\N
260	SARE11	SANTANDER RENDA DE ALUGUÉIS FUNDO DE INVESTIMENTO IMOBILIÁRIO- FII	32903702000171	31	1	2022-03-28	\N	\N	\N	\N
261	SCPF11	SCP FII	01657856000105	24	1	2022-03-28	\N	\N	\N	\N
262	SDIL11	FUNDO DE INVESTIMENTO IMOBILIARIO SDI RIO BRAVO RENDA LOGÍSTICA - FII	16671412000193	34	1	2022-03-28	\N	\N	\N	\N
263	SEED11	HEDGE SEED FUNDO DE INVESTIMENTO IMOBILIARIO	35689497000181	11	1	2022-03-28	\N	\N	\N	\N
264	SEQR11	SEQUÓIA III RENDA IMOBILIÁRIA FUNDO DE INVESTIMENTO IMOBILIÁRIO	09517273000182	16	1	2022-03-28	\N	\N	\N	\N
265	SFND11	FUNDO DE INVESTIMENTO IMOBILIÁRIO SÃO FERNANDO	09350920000104	34	1	2022-03-28	\N	\N	\N	\N
266	SHDP11	FII SHOPPING PARQUE D PEDRO	07224019000160	26	1	2022-03-28	\N	\N	\N	\N
267	SHPH11	FUNDO DE INVESTIMENTO IMOBILIÁRIO SHOPPING PÁTIO HIGIENOPOLIS	03507519000159	34	1	2022-03-28	\N	\N	\N	\N
268	SIGR11	SIG CAPITAL RECEBÍVEIS PULVERIZADOS  FUNDO DE INVESTIMENTO IMOBILIÁRIO	40011324000140	26	1	2022-03-28	\N	\N	\N	\N
269	SNCI11	SUNO RECEBÍVEIS IMOBILIÁRIOS FUNDO DE INVESTIMENTO IMOBILIÁRIO	41076710000182	26	1	2022-03-28	\N	\N	\N	\N
270	SNFF11	SUNO FUNDO DE FUNDOS DE INVESTIMENTO IMOBILIÁRIO	40011225000168	26	1	2022-03-28	\N	\N	\N	\N
271	SOLR11	SOLARIUM FII - FUNDO DE INVESTIMENTO IMOBILIÁRIO	22169671000113	25	1	2022-03-28	\N	\N	\N	\N
272	SPAF11	SPA FUNDO DE INVESTIMENTO IMOBILIÁRIO	18311024000127	25	1	2022-03-28	\N	\N	\N	\N
273	SPTW11	SP DOWNTOWN FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	15538445000105	17	1	2022-03-28	\N	\N	\N	\N
274	SPVJ11	FUNDO DE INVESTIMENTO IMOBILIÁRIO SUCCESPAR VAREJO	27538422000171	16	1	2022-03-28	\N	\N	\N	\N
275	SRVD11	SERRA VERDE FUNDO DE INVESTIMENTO IMOBILIÁRIO	38082796000141	16	1	2022-03-28	\N	\N	\N	\N
276	STRX11	STARX FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	11044355000107	15	1	2022-03-28	\N	\N	\N	\N
277	TCPF11	TREECORP REAL ESTATE FII - I	26990011000150	24	1	2022-03-28	\N	\N	\N	\N
278	TEPP11	TELLUS PROPERTIES  FUNDO DE INVESTIMENTO IMOBILIÁRIO	26681370000125	13	1	2022-03-28	\N	\N	\N	\N
279	TGAR11	FUNDO DE INVESTIMENTO IMOBILIÁRIO TG ATIVO REAL	25032881000153	16	1	2022-03-28	\N	\N	\N	\N
280	TORD11	TORDESILHAS EI FUNDO DE INVESTIMENTO IMOBILIÁRIO	30230870000118	16	1	2022-03-28	\N	\N	\N	\N
281	TORM11	FUNDO DE INVESTIMENTO IMOBILIÁRIO TOURMALET I	26395660000102	16	1	2022-03-28	\N	\N	\N	\N
282	TOUR11	FUNDO DE INVESTIMENTO IMOBILIÁRIO TOURMALET II	30578316000126	16	1	2022-03-28	\N	\N	\N	\N
283	TRNT11	FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII TORRE NORTE	04722883000102	26	1	2022-03-28	\N	\N	\N	\N
284	TRXB11	TRX REAL ESTATE II FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	36368925000137	13	1	2022-03-28	\N	\N	\N	\N
285	TRXF11	TRX REAL ESTATE FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	28548288000152	13	1	2022-03-28	\N	\N	\N	\N
286	TSER11	TISHMAN SPEYER RENDA CORPORATIVA FUNDO DE INVESTIMENTO IMOBILIÁRIO	34847042000184	13	1	2022-03-28	\N	\N	\N	\N
287	TSNC11	TRANSINC FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	17007443000107	26	1	2022-03-28	\N	\N	\N	\N
288	URPR11	URCA PRIME RENDA FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	34508872000187	16	1	2022-03-28	\N	\N	\N	\N
289	VCJR11	VECTIS JUROS REAL FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	32400250000105	32	1	2022-03-28	\N	\N	\N	\N
290	VCRR11	VECTIS RENDA RESIDENCIAL FUNDO DE INVESTIMENTO IMOBILIARIO	40041723000153	13	1	2022-03-28	\N	\N	\N	\N
291	VERE11	FUNDO DE INVESTIMENTO IMOBILIARIO VEREDA - FII	08693497000182	16	1	2022-03-28	\N	\N	\N	\N
292	VGHF11	VALORA HEDGE FUND FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	36771692000119	29	1	2022-03-28	\N	\N	\N	\N
293	VGIA11	VALORA CRA FUNDO DE INVESTIMENTO NAS CADEIAS PRODUTIVAS AGROINDUSTRIAIS - FIAGRO-IMOBILIÁRIO	41081088000109	26	1	2022-03-28	\N	\N	\N	\N
294	VGIP11	VALORA CRI ÍNDICE DE PREÇO FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	34197811000146	26	1	2022-03-28	\N	\N	\N	\N
295	VGIR11	VALORA RE III FUNDO DE INVESTIMENTO IMOBILIARIO - FII	29852732000191	26	1	2022-03-28	\N	\N	\N	\N
296	VIFI11	VINCI INSTRUMENTOS FINANCEIROS FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	31547855000160	13	1	2022-03-28	\N	\N	\N	\N
297	VILG11	VINCI LOGÍSTICA FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	24853044000122	13	1	2022-03-28	\N	\N	\N	\N
298	VINO11	VINCI OFFICES FUNDO DE INVESTIMENTO IMOBILIÁRIO	12516185000170	13	1	2022-03-28	\N	\N	\N	\N
299	VISC11	VINCI SHOPPING CENTERS FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	17554274000125	13	1	2022-03-28	\N	\N	\N	\N
300	VIUR11	VINCI IMOVEIS URBANOS FUNDO DE INVESTIMENTO IMOBILIARIO	36445587000190	13	1	2022-03-28	\N	\N	\N	\N
301	VJFD	JFDCAM - FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	15489509000117	9	1	2022-03-28	\N	\N	\N	\N
302	VLJS11	VECTOR QUELUZ LAJES CORPORATIVAS FUNDO DE INVESTIMENTO IMOBILIARIO	13842683000176	4	1	2022-03-28	\N	\N	\N	\N
303	VLOL11	FUNDO DE INVESTIMENTO IMOBILIARIO - FII VILA OLIMPIA CORPORATE	15296696000112	21	1	2022-03-28	\N	\N	\N	\N
304	VOTS11	Votorantim Securities Master Fundo de Investimento Imobiliário - FII	17870926000130	9	1	2022-03-28	\N	\N	\N	\N
305	VPSI11	FUNDO DE INVESTIMENTO IMOBILIÁRIO POLO SHOPPING INDAIATUBA	14721889000100	9	1	2022-03-28	\N	\N	\N	\N
306	VRTA11	FATOR VERITA FUNDO DE INVESTIMENTO IMOBILIARIO	11664201000100	19	1	2022-03-28	\N	\N	\N	\N
307	VSEC11	FUNDO DE INVESTIMENTO IMOBILIÁRIO VOTORANTIM SECURITIES	10347505000180	9	1	2022-03-28	\N	\N	\N	\N
308	VSHO11	FUNDO DE INVESTIMENTO IMOBILIÁRIO VOTORANTIM SHOPPING	23740595000117	9	1	2022-03-28	\N	\N	\N	\N
309	VSLH11	VERSALHES RECEBÍVEIS IMOBILIÁRIOS - FUNDO DE INVESTIMENTO IMOBILIÁRIO	36244015000142	16	1	2022-03-28	\N	\N	\N	\N
310	VTLT11	FUNDO DE INVESTIMENTO IMOBILIÁRIO VOTORANTIM LOGÍSTICA	27368600000163	9	1	2022-03-28	\N	\N	\N	\N
311	VVPR11	Fundo de Investimento Imobiliário - V2 Properties	33045581000137	26	1	2022-03-28	\N	\N	\N	\N
312	WPLZ11	SHOPPING WEST PLAZA FUNDO DE INVESTIMENTO IMOBILIARIO	09326861000139	11	1	2022-03-28	\N	\N	\N	\N
313	WTSP11B	FUNDO DE INVESTIMENTO IMOBILIÁRIO OURINVEST RE I	28693595000127	35	1	2022-03-28	\N	\N	\N	\N
314	XPCA11	XP CRÉDITO AGRÍCOLA-FUNDO DE INVESTIMENTO NAS CADEIAS PRODUTIVAS AGROINDUSTRIAIS IMOB.-FIAGRO-IMOB.	41269527000101	5	1	2022-03-28	\N	\N	\N	\N
315	XPCI11	XP CRÉDITO IMOBILIÁRIO - FUNDO DE INVESTIMENTO IMOBILIÁRIO	28516301000191	16	1	2022-03-28	\N	\N	\N	\N
316	XPCM11	XP CORPORATE MACAÉ FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	16802320000103	34	1	2022-03-28	\N	\N	\N	\N
317	XPIN11	XP Industrial Fundo de Investimento Imobiliário	28516325000140	16	1	2022-03-28	\N	\N	\N	\N
318	XPLG11	XP Log Fundo de Investimento Imobiliário - FII	26502794000185	16	1	2022-03-28	\N	\N	\N	\N
319	XPML11	XP MALLS FUNDO DE INVESTIMENTO IMOBILIÁRIO FII	28757546000100	26	1	2022-03-28	\N	\N	\N	\N
320	XPPR11	XP PROPERTIES FUNDO DE INVESTIMENTO IMOBILIÁRIO - FII	30654849000140	16	1	2022-03-28	\N	\N	\N	\N
321	XPSF11	XP SELECTION FUNDO DE FUNDOS DE INVESTIMENTO IMOBILIÁRIO - FII	30983020000190	5	1	2022-03-28	\N	\N	\N	\N
322	YUFI11	YUCA FUNDO DE INVESTIMENTO IMOBILIÁRIO	36445551000106	13	1	2022-03-28	\N	\N	\N	\N
\.


--
-- Data for Name: real_estate_investment_funds_administrators; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.real_estate_investment_funds_administrators (id, company_name, cnpj, created_by, created_at, updated_by, updated_at, deleted_by, deleted_at) FROM stdin;
1	BEM DISTRIBUIDORA DE TÍTULOS E VALORES MOBILIÁRIOS LTDA.	00066670000100	1	2022-03-28	\N	\N	\N	\N
2	Coinvalores C.C.V.M. LTDA	00336036000140	1	2022-03-28	\N	\N	\N	\N
3	Caixa Econômica Federal	00360305000104	1	2022-03-28	\N	\N	\N	\N
4	PLANNER CORRETORA DE VALORES S/A	00806535000154	1	2022-03-28	\N	\N	\N	\N
5	XP INVESTIMENTOS CTVM S.A.	02332886000104	1	2022-03-28	\N	\N	\N	\N
6	CM CAPITAL MARKETS DTVM LTDA	02671743000119	1	2022-03-28	\N	\N	\N	\N
7	BANCO J SAFRA S/A	03017677000120	1	2022-03-28	\N	\N	\N	\N
8	FINAXIS Corretora	03317692000194	1	2022-03-28	\N	\N	\N	\N
9	BV DISTRIBUIDORA DE TÍTULOS E VALORES MOBILIÁRIOS LTDA.	03384738000198	1	2022-03-28	\N	\N	\N	\N
10	MODAL DISTRIBUIDORA DE TITULOS E VALORES MOBILIARIOS LTDA.	05389174000101	1	2022-03-28	\N	\N	\N	\N
11	HEDGE INVESTMENTS DTVM LTDA.	07253654000176	1	2022-03-28	\N	\N	\N	\N
12	BANCO FINAXIS S.A.	11758741000152	1	2022-03-28	\N	\N	\N	\N
13	BRL TRUST DTVM S.A.	13486793000142	1	2022-03-28	\N	\N	\N	\N
14	ID Corretora de Títulos e Valores Mobiliários S.A.	16695922000109	1	2022-03-28	\N	\N	\N	\N
15	Inter Distribuidora de Títulos e Valores Mobiliários Ltda.	18945670000146	1	2022-03-28	\N	\N	\N	\N
16	VORTX DISTRIBUIDORA DE TÍTULOS DE VALORES MOBILIÁRIOS LTDA.	22610500000188	1	2022-03-28	\N	\N	\N	\N
17	Geração Futuro Corretora de Valores S.A.	27652684000162	1	2022-03-28	\N	\N	\N	\N
18	BB Gestão de Recursos DTVM S.A.	30822936000169	1	2022-03-28	\N	\N	\N	\N
19	Banco Fator S.A.	33644196000106	1	2022-03-28	\N	\N	\N	\N
20	REAG DISTRIBUIDORA DE TÍTULOS E VALORES MOBILIÁRIOS S.A.	34829992000186	1	2022-03-28	\N	\N	\N	\N
21	OLIVEIRA TRUST DTVM S.A.	36113876000191	1	2022-03-28	\N	\N	\N	\N
22	MAF Distribuidora de Títulos e Valores Mobiliários S.A	36864992000142	1	2022-03-28	\N	\N	\N	\N
23	RJI CORRETORA VALORES MOBILIÁRIOS LTDA	42066258000130	1	2022-03-28	\N	\N	\N	\N
24	BR-CAPITAL DISTR. TITS. E VALS. MOBILIÁRIOS S.A.	44077014000189	1	2022-03-28	\N	\N	\N	\N
25	BRASIL PLURAL S.A BANCO MÚLTIPLO	45246410000155	1	2022-03-28	\N	\N	\N	\N
26	BTG Pactual Serviços Financeiros S.A. DTVM	59281253000123	1	2022-03-28	\N	\N	\N	\N
27	BANCO BRADESCO S/A	60746948000112	1	2022-03-28	\N	\N	\N	\N
28	CREDIT SUISSE HEDGING - GRIFFO CORRETORA DE VALORES S.A.	61809182000130	1	2022-03-28	\N	\N	\N	\N
29	BANCO DAYCOVAL S.A	62232889000190	1	2022-03-28	\N	\N	\N	\N
30	Singulare Corretora de Valores e Titulos Mobiliarios S.A	62285390000140	1	2022-03-28	\N	\N	\N	\N
31	SANTANDER CACEIS BRASIL DISTRIB TITULOS E VALORES MOB S.A	62318407000119	1	2022-03-28	\N	\N	\N	\N
32	INTRAG DTVM	62418140000131	1	2022-03-28	\N	\N	\N	\N
33	PLANNER TRUSTEE DTVM LTDA	67030395000146	1	2022-03-28	\N	\N	\N	\N
34	Rio Bravo Investimentos DTVM Ltda	72600026000181	1	2022-03-28	\N	\N	\N	\N
35	BANCO OURINVEST S.A.	78632767000120	1	2022-03-28	\N	\N	\N	\N
\.


--
-- Data for Name: real_estate_investment_funds_opening_balance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.real_estate_investment_funds_opening_balance (id, investor_id, real_estate_investment_fund_id, quantity, unit_value, created_at, updated_at, deleted_at) FROM stdin;
1	2	19	148	$98.34	2022-03-29	\N	\N
\.


--
-- Data for Name: stock_brokers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stock_brokers (id, name, cnpj, code_number, created_by, created_at, deleted_by, deleted_at, updated_by, updated_at) FROM stdin;
1	BANCO DO BRASIL S/A	00000000000191	1	1	2022-03-29	\N	\N	\N	\N
2	CAIXA ECONOMICA FEDERAL	00360305000104	104	1	2022-03-29	\N	\N	\N	\N
3	PLANNER CORRETORA DE VALORES S/A	00806535000154	\N	1	2022-03-29	\N	\N	\N	\N
4	BANCO B3 S.A.	00997185000150	96	1	2022-03-29	\N	\N	\N	\N
5	OURINVEST DTVM S.A.	00997804000107	\N	1	2022-03-29	\N	\N	\N	\N
6	BANCO COOPERATIVO SICREDI S/A	01181521000155	748	1	2022-03-29	\N	\N	\N	\N
7	BANCO BNP PARIBAS BRASIL S/A	01522368000182	752	1	2022-03-29	\N	\N	\N	\N
8	H.COMMCOR DTVM LTDA	01788147000150	\N	1	2022-03-29	\N	\N	\N	\N
9	BANCO COOPERATIVO SICOOB S.A. - BANCO SICOOB	02038232000164	756	1	2022-03-29	\N	\N	\N	\N
10	TRINUS CAPITAL DTVM S.A.	02276653000123	\N	1	2022-03-29	\N	\N	\N	\N
11	XP INVESTIMENTOS CCTVM S/A	02332886000104	102	1	2022-03-29	\N	\N	\N	\N
12	CLEAR CORRETORA - GRUPO XP	02332886001178	102	1	2022-03-29	\N	\N	\N	\N
13	RICO INVESTIMENTOS - GRUPO XP	02332886001682	102	1	2022-03-29	\N	\N	\N	\N
14	MERRILL LYNCH S/A CTVM	02670590000195	\N	1	2022-03-29	\N	\N	\N	\N
15	CM CAPITAL MARKETS CCTVM LTDA	02685483000130	\N	1	2022-03-29	\N	\N	\N	\N
16	UBS BRASIL CCTVM S/A	02819125000173	\N	1	2022-03-29	\N	\N	\N	\N
17	BV DISTRIBUIDORA DE TITULOS E VALORES MOBILIARIOS LTDA	03384738000198	\N	1	2022-03-29	\N	\N	\N	\N
18	PI DISTRIBUIDORA DE TITULOS E VALORES MOBILIARIOS S.A.	03502968000104	\N	1	2022-03-29	\N	\N	\N	\N
19	BANCO ABN AMRO S.A.	03532415000102	75	1	2022-03-29	\N	\N	\N	\N
20	TERRA INVESTIMENTOS DTVM LTDA	03751794000113	\N	1	2022-03-29	\N	\N	\N	\N
21	NOVA FUTURA CTVM LTDA	04257795000179	\N	1	2022-03-29	\N	\N	\N	\N
22	MORGAN STANLEY CTVM S/A	04323351000194	\N	1	2022-03-29	\N	\N	\N	\N
23	MODAL DTVM LTDA	05389174000101	\N	1	2022-03-29	\N	\N	\N	\N
24	GENIAL INSTITUCIONAL CCTVM S/A	05816451000115	\N	1	2022-03-29	\N	\N	\N	\N
25	HEDGE INVESTMENTS DTVM LTDA	07253654000176	\N	1	2022-03-29	\N	\N	\N	\N
26	ICAP DO BRASIL CTVM LTDA	09105360000122	\N	1	2022-03-29	\N	\N	\N	\N
27	B3 S.A. - BRASIL  BOLSA  BALCÃO	09346601000125	\N	1	2022-03-29	\N	\N	\N	\N
28	CODEPE CORRETORA DE VALORES E CÂMBIO S/A	09512542000118	\N	1	2022-03-29	\N	\N	\N	\N
29	GOLDMAN SACHS DO BRASIL CTVM SA	09605581000160	\N	1	2022-03-29	\N	\N	\N	\N
30	BANCOSEGURO S.A.	10264663000177	81	1	2022-03-29	\N	\N	\N	\N
31	BANCO FINAXIS S.A.	11758741000152	\N	1	2022-03-29	\N	\N	\N	\N
32	MIRAE ASSET WEALTH MANAGEMENT (BRASIL) CCTVM LTDA.	12392983000138	\N	1	2022-03-29	\N	\N	\N	\N
33	BR PARTNERS BANCO DE INVESTIMENTO S/A	13220493000117	\N	1	2022-03-29	\N	\N	\N	\N
34	ORAMA DTVM S A	13293225000125	\N	1	2022-03-29	\N	\N	\N	\N
35	BRL TRUST DTVM S.A	13486793000142	\N	1	2022-03-29	\N	\N	\N	\N
36	FRAM CAPITAL DTVM SA	13673855000125	\N	1	2022-03-29	\N	\N	\N	\N
37	VIC DTVM S/A	14388516000160	\N	1	2022-03-29	\N	\N	\N	\N
38	BANCO BOCOM BBM SA	15114366000169	107	1	2022-03-29	\N	\N	\N	\N
39	BOCOM BBM CCVM S/A	15213150000150	\N	1	2022-03-29	\N	\N	\N	\N
40	MERCANTIL DO BRASIL C. S/A CTVM	16683062000185	\N	1	2022-03-29	\N	\N	\N	\N
41	AMARIL FRANKLIN CTV LTDA	17312661000155	\N	1	2022-03-29	\N	\N	\N	\N
42	SITA SOCIEDADE CCVM S/A	17315359000150	\N	1	2022-03-29	\N	\N	\N	\N
43	SENSO C.C.V.M. S/A	17352220000187	\N	1	2022-03-29	\N	\N	\N	\N
44	AZIMUT BRASIL DTVM LTDA	18684408000195	\N	1	2022-03-29	\N	\N	\N	\N
45	INTER DTVM LTDA	18945670000146	\N	1	2022-03-29	\N	\N	\N	\N
46	VORTX DTVM LTDA	22610500000188	\N	1	2022-03-29	\N	\N	\N	\N
47	BB BANCO DE INVESTIMENTO S/A	24933830000130	\N	1	2022-03-29	\N	\N	\N	\N
48	GENIAL INVESTIMENTOS CORRETORA DE VALORES MOBILIÁRIOS S.A.	27652684000162	\N	1	2022-03-29	\N	\N	\N	\N
49	ELITE CCVM LTDA	28048783000100	\N	1	2022-03-29	\N	\N	\N	\N
50	BANCO ABC BRASIL S/A	28195667000106	246	1	2022-03-29	\N	\N	\N	\N
51	BS2 DTVM S.A.	28650236000192	\N	1	2022-03-29	\N	\N	\N	\N
52	TORO CTVM LTDA	29162769000198	\N	1	2022-03-29	\N	\N	\N	\N
53	BANCO BTG PACTUAL S/A	30306294000145	208	1	2022-03-29	\N	\N	\N	\N
54	BANCO MODAL S/A	30723886000162	746	1	2022-03-29	\N	\N	\N	\N
55	BANCO CLASSICO S/A	31597552000152	241	1	2022-03-29	\N	\N	\N	\N
56	IDEAL CTVM S.A.	31749596000150	\N	1	2022-03-29	\N	\N	\N	\N
57	BANCO C6 S.A.	31872495000172	\N	1	2022-03-29	\N	\N	\N	\N
58	C6 CORRETORA DE TITULOS E VALORES MOBILIARIOS LTDA	32345784000186	\N	1	2022-03-29	\N	\N	\N	\N
59	J.P. MORGAN CCVM S/A	32588139000194	\N	1	2022-03-29	\N	\N	\N	\N
60	BANCO J.P.MORGAN S/A	33172537000198	376	1	2022-03-29	\N	\N	\N	\N
61	ITAU DTVM S/A	33311713000125	\N	1	2022-03-29	\N	\N	\N	\N
62	BANCO CAIXA GERAL - BRASIL S/A	33466988000138	473	1	2022-03-29	\N	\N	\N	\N
63	BANCO CITIBANK S/A	33479023000180	745	1	2022-03-29	\N	\N	\N	\N
64	BANCO FATOR S/A	33644196000106	265	1	2022-03-29	\N	\N	\N	\N
65	BANCO NAC DE DESN ECO E SOCIAL - BNDES	33657248000189	\N	1	2022-03-29	\N	\N	\N	\N
66	CITIGROUP GLOBAL MARKETS BRASIL CCTVM S/A	33709114000164	\N	1	2022-03-29	\N	\N	\N	\N
67	ATIVA INVESTIMENTOS S/A CTCV	33775974000104	\N	1	2022-03-29	\N	\N	\N	\N
68	BRB DTVM S/A	33850686000169	\N	1	2022-03-29	\N	\N	\N	\N
69	J.P. MORGAN S/A DTVM	33851205000130	\N	1	2022-03-29	\N	\N	\N	\N
70	BGC LIQUIDEZ DTVM LTDA	33862244000132	\N	1	2022-03-29	\N	\N	\N	\N
71	CITIBANK DTVM S/A	33868597000140	\N	1	2022-03-29	\N	\N	\N	\N
72	MASTER S/A CCTVM	33886862000112	\N	1	2022-03-29	\N	\N	\N	\N
73	GRADUAL CORRET DE CAMBIO TIT E VALS MOB SA	33918160000173	\N	1	2022-03-29	\N	\N	\N	\N
74	UM INVESTIMENTOS S/A CTVM	33968066000129	\N	1	2022-03-29	\N	\N	\N	\N
75	BANCO DE INVEST. CREDIT SUISSE (BRASIL) S.A.	33987793000133	\N	1	2022-03-29	\N	\N	\N	\N
76	VITREO DTVM S.A.	34711571000156	\N	1	2022-03-29	\N	\N	\N	\N
77	SCOTIABANK BRASIL S.A. CTVM	39696805000157	\N	1	2022-03-29	\N	\N	\N	\N
78	BNY MELLON BANCO S/A	42272526000170	\N	1	2022-03-29	\N	\N	\N	\N
79	CREDIT SUISSE (BRASIL) S.A. CTVM	42584318000107	\N	1	2022-03-29	\N	\N	\N	\N
80	NOVINVEST CVM LTDA	43060029000171	\N	1	2022-03-29	\N	\N	\N	\N
81	BTG PACTUAL CTVM S/A	43815158000122	\N	1	2022-03-29	\N	\N	\N	\N
82	BR-CAPITAL DTVM S/A	44077014000189	\N	1	2022-03-29	\N	\N	\N	\N
83	BANCO GENIAL S.A	45246410000155	\N	1	2022-03-29	\N	\N	\N	\N
84	BANCO ANDBANK (BRASIL) S.A.	48795256000169	65	1	2022-03-29	\N	\N	\N	\N
85	SLW CVC LTDA	50657675000186	\N	1	2022-03-29	\N	\N	\N	\N
86	SANTANDER CCVM S/A	51014223000149	\N	1	2022-03-29	\N	\N	\N	\N
87	NECTON INVESTIMENTOS S.A. CVMC	52904364000108	\N	1	2022-03-29	\N	\N	\N	\N
88	SSM - SISTEMA DE SIMULACAO DE MARGENS	54641030000378	\N	1	2022-03-29	\N	\N	\N	\N
89	BANCO SAFRA S/A	58160789000128	422	1	2022-03-29	\N	\N	\N	\N
90	BANCO FIBRA S/A	58616418000108	224	1	2022-03-29	\N	\N	\N	\N
91	BANCO VOTORANTIM S/A	59588111000103	655	1	2022-03-29	\N	\N	\N	\N
92	ITAU UNIBANCO S/A	60701190000104	341	1	2022-03-29	\N	\N	\N	\N
93	BANCO BRADESCO S/A	60746948000112	237	1	2022-03-29	\N	\N	\N	\N
94	SAFRA CORRETORA DE VALORES E CAMBIO LTDA	60783503000102	\N	1	2022-03-29	\N	\N	\N	\N
95	BANCO SOFISA S/A	60889128000180	637	1	2022-03-29	\N	\N	\N	\N
96	BANCO VOITER SA	61024352000171	653	1	2022-03-29	\N	\N	\N	\N
97	ITAU CV S/A	61194353000164	\N	1	2022-03-29	\N	\N	\N	\N
98	MAGLIANO S/A CCVM	61723847000199	\N	1	2022-03-29	\N	\N	\N	\N
99	TULLETT PREBON BRASIL CVC LTDA.	61747085000160	\N	1	2022-03-29	\N	\N	\N	\N
100	BANCO PAULISTA S/A	61820817000109	611	1	2022-03-29	\N	\N	\N	\N
101	BRADESCO S/A CTVM	61855045000132	\N	1	2022-03-29	\N	\N	\N	\N
102	BANK OF AMERICA MERRILL LYNCH BANCO MULTIPLO	62073200000121	\N	1	2022-03-29	\N	\N	\N	\N
103	STONEX DISTRIBUIDORA DE TITULOS E VALORES MOBILIARIOS LTDA	62090873000190	\N	1	2022-03-29	\N	\N	\N	\N
104	NU INVEST CORRETORA DE VALORES S.A.	62169875000179	\N	1	2022-03-29	\N	\N	\N	\N
105	ALFA CCVM S/A	62178421000164	\N	1	2022-03-29	\N	\N	\N	\N
106	BANCO DAYCOVAL S/A	62232889000190	707	1	2022-03-29	\N	\N	\N	\N
107	SINGULARE CORRETORA DE TÍTULOS E VALORES MOBILIÁRIOS S.A.	62285390000140	\N	1	2022-03-29	\N	\N	\N	\N
108	RENASCENCA DTVM LTDA	62287735000103	\N	1	2022-03-29	\N	\N	\N	\N
109	SANTANDER CACEIS BRASIL DTVM S.A.	62318407000119	\N	1	2022-03-29	\N	\N	\N	\N
110	DEUTSCHE BANK S/A - BANCO ALEMAO	62331228000111	487	1	2022-03-29	\N	\N	\N	\N
111	FATOR S/A - CORRETORA DE VALORES	63062749000183	\N	1	2022-03-29	\N	\N	\N	\N
112	GUIDE INVESTIMENTOS SA CORRETORA DE VALORES	65913436000117	\N	1	2022-03-29	\N	\N	\N	\N
113	SIM PAUL CORRETORA DE CAMBIO E VALORES MOBILIARIOS S.A	68757681000170	\N	1	2022-03-29	\N	\N	\N	\N
114	AGORA CTVM S/A	74014747000135	\N	1	2022-03-29	\N	\N	\N	\N
115	BANCO CREDIT AGRICOLE BRASIL S.A.	75647891000171	222	1	2022-03-29	\N	\N	\N	\N
116	BANCO OURINVEST S/A	78632767000120	\N	1	2022-03-29	\N	\N	\N	\N
117	RB INVESTIMENTOS DTVM LTDA	89960090000176	\N	1	2022-03-29	\N	\N	\N	\N
118	BANCO SANTANDER (BRASIL) S.A.	90400888000142	33	1	2022-03-29	\N	\N	\N	\N
119	BANCO DO ESTADO DO RIO GRANDE DO SUL S/A	92702067000196	41	1	2022-03-29	\N	\N	\N	\N
120	CORRETORA GERAL DE VALORES E CAMBIO LTDA	92858380000118	\N	1	2022-03-29	\N	\N	\N	\N
121	WARREN CVMC LTDA	92875780000131	\N	1	2022-03-29	\N	\N	\N	\N
122	BANCO ORIGINAL S/A	92894922000108	212	1	2022-03-29	\N	\N	\N	\N
123	BANRISUL S/A CORRETORA DE VAL MOB E CAMBIO	93026847000126	\N	1	2022-03-29	\N	\N	\N	\N
\.


--
-- Data for Name: stock_market; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stock_market (id, option_tax, ana_tax, fees, invoice_id) FROM stdin;
1	$0.00	$0.00	$0.06	1
\.


--
-- Data for Name: stocks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stocks (id, ticker_symbol, company_name, cnpj, created_by, created_at, updated_by, updated_at, deleted_by, deleted_at) FROM stdin;
2001	AALR3	CENTRO DE IMAGEM DIAGNOSTICOS S.A.	42771949000135	1	2022-03-28	\N	\N	\N	\N
2002	AALR3F	CENTRO DE IMAGEM DIAGNOSTICOS S.A.	42771949000135	1	2022-03-28	\N	\N	\N	\N
2003	ABCB4	BCO ABC BRASIL S.A.	28195667000106	1	2022-03-28	\N	\N	\N	\N
2004	ABCB4F	BCO ABC BRASIL S.A.	28195667000106	1	2022-03-28	\N	\N	\N	\N
2005	ABEV3	AMBEV S.A.	07526557000100	1	2022-03-28	\N	\N	\N	\N
2006	ABEV3F	AMBEV S.A.	07526557000100	1	2022-03-28	\N	\N	\N	\N
2007	AERI3	AERIS IND. E COM. DE EQUIP. GERACAO DE ENERGIA S/A	12528708000107	1	2022-03-28	\N	\N	\N	\N
2008	AERI3F	AERIS IND. E COM. DE EQUIP. GERACAO DE ENERGIA S/A	12528708000107	1	2022-03-28	\N	\N	\N	\N
2009	AESB3	AES BRASIL ENERGIA S.A.	37663076000107	1	2022-03-28	\N	\N	\N	\N
2010	AESB3F	AES BRASIL ENERGIA S.A.	37663076000107	1	2022-03-28	\N	\N	\N	\N
2011	AESO3	AES BRASIL OPERAÇĠES S.A.	00194724000113	1	2022-03-28	\N	\N	\N	\N
2012	AESO3F	AES BRASIL OPERAÇĠES S.A.	00194724000113	1	2022-03-28	\N	\N	\N	\N
2013	AFLT3	AFLUENTE TRANSMISSO DE ENERGIA ELÉTRICA S/A	10338320000100	1	2022-03-28	\N	\N	\N	\N
2014	AFLT3F	AFLUENTE TRANSMISSO DE ENERGIA ELÉTRICA S/A	10338320000100	1	2022-03-28	\N	\N	\N	\N
2015	AGRO3	BRASILAGRO - CIA BRAS DE PROP AGRICOLAS	07628528000159	1	2022-03-28	\N	\N	\N	\N
2016	AGRO3F	BRASILAGRO - CIA BRAS DE PROP AGRICOLAS	07628528000159	1	2022-03-28	\N	\N	\N	\N
2017	AGXY3	AGROGALAXY PARTICIPAÇĠES S.A.	21240146000184	1	2022-03-28	\N	\N	\N	\N
2018	AGXY3F	AGROGALAXY PARTICIPAÇĠES S.A.	21240146000184	1	2022-03-28	\N	\N	\N	\N
2019	AHEB3	SAO PAULO TURISMO S.A.	62002886000160	1	2022-03-28	\N	\N	\N	\N
2020	AHEB3F	SAO PAULO TURISMO S.A.	62002886000160	1	2022-03-28	\N	\N	\N	\N
2021	AHEB5	SAO PAULO TURISMO S.A.	62002886000160	1	2022-03-28	\N	\N	\N	\N
2022	AHEB5F	SAO PAULO TURISMO S.A.	62002886000160	1	2022-03-28	\N	\N	\N	\N
2023	AHEB6	SAO PAULO TURISMO S.A.	62002886000160	1	2022-03-28	\N	\N	\N	\N
2024	AHEB6F	SAO PAULO TURISMO S.A.	62002886000160	1	2022-03-28	\N	\N	\N	\N
2025	ALLD3	ALLIED TECNOLOGIA S.A.	20247322000147	1	2022-03-28	\N	\N	\N	\N
2026	ALLD3F	ALLIED TECNOLOGIA S.A.	20247322000147	1	2022-03-28	\N	\N	\N	\N
2027	ALPA3	ALPARGATAS S.A.	61079117000105	1	2022-03-28	\N	\N	\N	\N
2028	ALPA3F	ALPARGATAS S.A.	61079117000105	1	2022-03-28	\N	\N	\N	\N
2029	ALPA4	ALPARGATAS S.A.	61079117000105	1	2022-03-28	\N	\N	\N	\N
2030	ALPA4F	ALPARGATAS S.A.	61079117000105	1	2022-03-28	\N	\N	\N	\N
2031	ALPK3	ALLPARK EMPREENDIMENTOS PARTICIPACOES SERVICOS S.A	60537263000166	1	2022-03-28	\N	\N	\N	\N
2032	ALPK3F	ALLPARK EMPREENDIMENTOS PARTICIPACOES SERVICOS S.A	60537263000166	1	2022-03-28	\N	\N	\N	\N
2033	ALSO3	ALIANSCE SONAE SHOPPING CENTERS S.A.	05878397000132	1	2022-03-28	\N	\N	\N	\N
2034	ALSO3F	ALIANSCE SONAE SHOPPING CENTERS S.A.	05878397000132	1	2022-03-28	\N	\N	\N	\N
2035	ALUP3	ALUPAR INVESTIMENTO S/A	08364948000138	1	2022-03-28	\N	\N	\N	\N
2036	ALUP3F	ALUPAR INVESTIMENTO S/A	08364948000138	1	2022-03-28	\N	\N	\N	\N
2037	ALUP4	ALUPAR INVESTIMENTO S/A	08364948000138	1	2022-03-28	\N	\N	\N	\N
2038	ALUP4F	ALUPAR INVESTIMENTO S/A	08364948000138	1	2022-03-28	\N	\N	\N	\N
2039	AMAR3	MARISA LOJAS S.A.	61189288000189	1	2022-03-28	\N	\N	\N	\N
2040	AMAR3F	MARISA LOJAS S.A.	61189288000189	1	2022-03-28	\N	\N	\N	\N
2041	AMBP3	AMBIPAR PARTICIPACOES E EMPREENDIMENTOS S/A	12648266000124	1	2022-03-28	\N	\N	\N	\N
2042	AMBP3F	AMBIPAR PARTICIPACOES E EMPREENDIMENTOS S/A	12648266000124	1	2022-03-28	\N	\N	\N	\N
2043	AMER3	AMERICANAS S.A	00776574000156	1	2022-03-28	\N	\N	\N	\N
2044	AMER3F	AMERICANAS S.A	00776574000156	1	2022-03-28	\N	\N	\N	\N
2045	ANIM3	ANIMA HOLDING S.A.	09288252000132	1	2022-03-28	\N	\N	\N	\N
2046	ANIM3F	ANIMA HOLDING S.A.	09288252000132	1	2022-03-28	\N	\N	\N	\N
2047	APER3	ALPER CONSULTORIA E CORRETORA DE SEGUROS S.A.	11721921000160	1	2022-03-28	\N	\N	\N	\N
2048	APER3F	ALPER CONSULTORIA E CORRETORA DE SEGUROS S.A.	11721921000160	1	2022-03-28	\N	\N	\N	\N
2049	APTI3	SIDERURGICA J. L. ALIPERTI S.A.	61156931000178	1	2022-03-28	\N	\N	\N	\N
2050	APTI3F	SIDERURGICA J. L. ALIPERTI S.A.	61156931000178	1	2022-03-28	\N	\N	\N	\N
2051	APTI4	SIDERURGICA J. L. ALIPERTI S.A.	61156931000178	1	2022-03-28	\N	\N	\N	\N
2052	APTI4F	SIDERURGICA J. L. ALIPERTI S.A.	61156931000178	1	2022-03-28	\N	\N	\N	\N
2053	ARML3	ARMAC LOCAÇO	00242184000104	1	2022-03-28	\N	\N	\N	\N
2054	ARML3F	ARMAC LOCAÇO	00242184000104	1	2022-03-28	\N	\N	\N	\N
2055	ARZZ3	AREZZO INDÚSTRIA E COMÉRCIO S.A.	16590234000176	1	2022-03-28	\N	\N	\N	\N
2056	ARZZ3F	AREZZO INDÚSTRIA E COMÉRCIO S.A.	16590234000176	1	2022-03-28	\N	\N	\N	\N
2057	ASAI3	SENDAS DISTRIBUIDORA S.A.	06057223000171	1	2022-03-28	\N	\N	\N	\N
2058	ASAI3F	SENDAS DISTRIBUIDORA S.A.	06057223000171	1	2022-03-28	\N	\N	\N	\N
2059	ATMP3	ATMA PARTICIPAÇĠES S.A.	04032433000180	1	2022-03-28	\N	\N	\N	\N
2060	ATMP3F	ATMA PARTICIPAÇĠES S.A.	04032433000180	1	2022-03-28	\N	\N	\N	\N
2061	ATOM3	ATOM EMPREENDIMENTOS E PARTICIPAÇĠES S.A.	00359742000108	1	2022-03-28	\N	\N	\N	\N
2062	ATOM3F	ATOM EMPREENDIMENTOS E PARTICIPAÇĠES S.A.	00359742000108	1	2022-03-28	\N	\N	\N	\N
2063	AVLL3	ALPHAVILLE S.A.	16811931000100	1	2022-03-28	\N	\N	\N	\N
2064	AVLL3F	ALPHAVILLE S.A.	16811931000100	1	2022-03-28	\N	\N	\N	\N
2065	AZEV3	AZEVEDO E TRAVASSOS S.A.	61351532000168	1	2022-03-28	\N	\N	\N	\N
2066	AZEV3F	AZEVEDO E TRAVASSOS S.A.	61351532000168	1	2022-03-28	\N	\N	\N	\N
2067	AZEV4	AZEVEDO E TRAVASSOS S.A.	61351532000168	1	2022-03-28	\N	\N	\N	\N
2068	AZEV4F	AZEVEDO E TRAVASSOS S.A.	61351532000168	1	2022-03-28	\N	\N	\N	\N
2069	AZUL4	AZUL S.A.	09305994000129	1	2022-03-28	\N	\N	\N	\N
2070	AZUL4F	AZUL S.A.	09305994000129	1	2022-03-28	\N	\N	\N	\N
2071	B3SA3	B3 S.A. - BRASIL	09346601000125	1	2022-03-28	\N	\N	\N	\N
2072	B3SA3F	B3 S.A. - BRASIL	09346601000125	1	2022-03-28	\N	\N	\N	\N
2073	BAHI3	BAHEMA EDUCAÇO S.A.	45987245000192	1	2022-03-28	\N	\N	\N	\N
2074	BAHI3F	BAHEMA EDUCAÇO S.A.	45987245000192	1	2022-03-28	\N	\N	\N	\N
2075	BALM3	BAUMER S.A.	61374161000130	1	2022-03-28	\N	\N	\N	\N
2076	BALM3F	BAUMER S.A.	61374161000130	1	2022-03-28	\N	\N	\N	\N
2077	BALM4	BAUMER S.A.	61374161000130	1	2022-03-28	\N	\N	\N	\N
2078	BALM4F	BAUMER S.A.	61374161000130	1	2022-03-28	\N	\N	\N	\N
2079	BAUH3	EXCELSIOR ALIMENTOS S.A.	95426862000197	1	2022-03-28	\N	\N	\N	\N
2080	BAUH3F	EXCELSIOR ALIMENTOS S.A.	95426862000197	1	2022-03-28	\N	\N	\N	\N
2081	BAUH4	EXCELSIOR ALIMENTOS S.A.	95426862000197	1	2022-03-28	\N	\N	\N	\N
2082	BAUH4F	EXCELSIOR ALIMENTOS S.A.	95426862000197	1	2022-03-28	\N	\N	\N	\N
2083	BAZA3	BCO AMAZONIA S.A.	04902979000144	1	2022-03-28	\N	\N	\N	\N
2084	BAZA3F	BCO AMAZONIA S.A.	04902979000144	1	2022-03-28	\N	\N	\N	\N
2085	BBAS11	BCO BRASIL S.A.	00000000000191	1	2022-03-28	\N	\N	\N	\N
2086	BBAS11F	BCO BRASIL S.A.	00000000000191	1	2022-03-28	\N	\N	\N	\N
2087	BBAS12	BCO BRASIL S.A.	00000000000191	1	2022-03-28	\N	\N	\N	\N
2088	BBAS12F	BCO BRASIL S.A.	00000000000191	1	2022-03-28	\N	\N	\N	\N
2089	BBAS3	BCO BRASIL S.A.	00000000000191	1	2022-03-28	\N	\N	\N	\N
2090	BBAS3F	BCO BRASIL S.A.	00000000000191	1	2022-03-28	\N	\N	\N	\N
2091	BBDC3	BCO BRADESCO S.A.	60746948000112	1	2022-03-28	\N	\N	\N	\N
2092	BBDC3F	BCO BRADESCO S.A.	60746948000112	1	2022-03-28	\N	\N	\N	\N
2093	BBDC4	BCO BRADESCO S.A.	60746948000112	1	2022-03-28	\N	\N	\N	\N
2094	BBDC4F	BCO BRADESCO S.A.	60746948000112	1	2022-03-28	\N	\N	\N	\N
2095	BBML3	BBM LOGISTICA S.A.	01107327000120	1	2022-03-28	\N	\N	\N	\N
2096	BBML3F	BBM LOGISTICA S.A.	01107327000120	1	2022-03-28	\N	\N	\N	\N
2097	BBRK3	BRASIL BROKERS PARTICIPACOES S.A.	08613550000198	1	2022-03-28	\N	\N	\N	\N
2098	BBRK3F	BRASIL BROKERS PARTICIPACOES S.A.	08613550000198	1	2022-03-28	\N	\N	\N	\N
2099	BBSE3	BB SEGURIDADE PARTICIPAÇĠES S.A.	17344597000194	1	2022-03-28	\N	\N	\N	\N
2100	BBSE3F	BB SEGURIDADE PARTICIPAÇĠES S.A.	17344597000194	1	2022-03-28	\N	\N	\N	\N
2101	BDLL3	BARDELLA S.A. INDUSTRIAS MECANICAS	60851615000153	1	2022-03-28	\N	\N	\N	\N
2102	BDLL3F	BARDELLA S.A. INDUSTRIAS MECANICAS	60851615000153	1	2022-03-28	\N	\N	\N	\N
2103	BDLL4	BARDELLA S.A. INDUSTRIAS MECANICAS	60851615000153	1	2022-03-28	\N	\N	\N	\N
2104	BDLL4F	BARDELLA S.A. INDUSTRIAS MECANICAS	60851615000153	1	2022-03-28	\N	\N	\N	\N
2105	BEEF3	MINERVA S.A.	67620377000114	1	2022-03-28	\N	\N	\N	\N
2106	BEEF3F	MINERVA S.A.	67620377000114	1	2022-03-28	\N	\N	\N	\N
2107	BEES3	BANESTES S.A. - BCO EST ESPIRITO SANTO	28127603000178	1	2022-03-28	\N	\N	\N	\N
2108	BEES3F	BANESTES S.A. - BCO EST ESPIRITO SANTO	28127603000178	1	2022-03-28	\N	\N	\N	\N
2109	BEES4	BANESTES S.A. - BCO EST ESPIRITO SANTO	28127603000178	1	2022-03-28	\N	\N	\N	\N
2110	BEES4F	BANESTES S.A. - BCO EST ESPIRITO SANTO	28127603000178	1	2022-03-28	\N	\N	\N	\N
2111	BETP3B	BETAPART PARTICIPACOES S.A.	02762124000130	1	2022-03-28	\N	\N	\N	\N
2112	BETP3BF	BETAPART PARTICIPACOES S.A.	02762124000130	1	2022-03-28	\N	\N	\N	\N
2113	BGIP3	BCO ESTADO DE SERGIPE S.A. - BANESE	13009717000146	1	2022-03-28	\N	\N	\N	\N
2114	BGIP3F	BCO ESTADO DE SERGIPE S.A. - BANESE	13009717000146	1	2022-03-28	\N	\N	\N	\N
2115	BGIP4	BCO ESTADO DE SERGIPE S.A. - BANESE	13009717000146	1	2022-03-28	\N	\N	\N	\N
2116	BGIP4F	BCO ESTADO DE SERGIPE S.A. - BANESE	13009717000146	1	2022-03-28	\N	\N	\N	\N
2117	BIDI3	BANCO INTER S.A.	00416968000101	1	2022-03-28	\N	\N	\N	\N
2118	BIDI3F	BANCO INTER S.A.	00416968000101	1	2022-03-28	\N	\N	\N	\N
2119	BIDI4	BANCO INTER S.A.	00416968000101	1	2022-03-28	\N	\N	\N	\N
2120	BIDI4F	BANCO INTER S.A.	00416968000101	1	2022-03-28	\N	\N	\N	\N
2121	BIOM3	BIOMM S.A.	04752991000110	1	2022-03-28	\N	\N	\N	\N
2122	BIOM3F	BIOMM S.A.	04752991000110	1	2022-03-28	\N	\N	\N	\N
2123	BKBR3	BK BRASIL OPERAÇO E ASSESSORIA A RESTAURANTES SA	13574594000196	1	2022-03-28	\N	\N	\N	\N
2124	BKBR3F	BK BRASIL OPERAÇO E ASSESSORIA A RESTAURANTES SA	13574594000196	1	2022-03-28	\N	\N	\N	\N
2125	BLAU3	BLAU FARMACÊUTICA S.A.	58430828000160	1	2022-03-28	\N	\N	\N	\N
2126	BLAU3F	BLAU FARMACÊUTICA S.A.	58430828000160	1	2022-03-28	\N	\N	\N	\N
2127	BLUT3	BLUE TECH SOLUTIONS E.Q.I. S	60637238000154	1	2022-03-28	\N	\N	\N	\N
2128	BLUT3F	BLUE TECH SOLUTIONS E.Q.I. S	60637238000154	1	2022-03-28	\N	\N	\N	\N
2129	BLUT4	BLUE TECH SOLUTIONS E.Q.I. S	60637238000154	1	2022-03-28	\N	\N	\N	\N
2130	BLUT4F	BLUE TECH SOLUTIONS E.Q.I. S	60637238000154	1	2022-03-28	\N	\N	\N	\N
2131	BMEB3	BCO MERCANTIL DO BRASIL S.A.	17184037000110	1	2022-03-28	\N	\N	\N	\N
2132	BMEB3F	BCO MERCANTIL DO BRASIL S.A.	17184037000110	1	2022-03-28	\N	\N	\N	\N
2133	BMEB4	BCO MERCANTIL DO BRASIL S.A.	17184037000110	1	2022-03-28	\N	\N	\N	\N
2134	BMEB4F	BCO MERCANTIL DO BRASIL S.A.	17184037000110	1	2022-03-28	\N	\N	\N	\N
2135	BMGB4	BANCO BMG S.A.	61186680000174	1	2022-03-28	\N	\N	\N	\N
2136	BMGB4F	BANCO BMG S.A.	61186680000174	1	2022-03-28	\N	\N	\N	\N
2137	BMIN3	BCO MERCANTIL DE INVESTIMENTOS S.A.	34169557000172	1	2022-03-28	\N	\N	\N	\N
2138	BMIN3F	BCO MERCANTIL DE INVESTIMENTOS S.A.	34169557000172	1	2022-03-28	\N	\N	\N	\N
2139	BMIN4	BCO MERCANTIL DE INVESTIMENTOS S.A.	34169557000172	1	2022-03-28	\N	\N	\N	\N
2140	BMIN4F	BCO MERCANTIL DE INVESTIMENTOS S.A.	34169557000172	1	2022-03-28	\N	\N	\N	\N
2141	BMKS3	BICICLETAS MONARK S.A.	56992423000190	1	2022-03-28	\N	\N	\N	\N
2142	BMOB3	BEMOBI MOBILE TECH S.A.	09042817000105	1	2022-03-28	\N	\N	\N	\N
2143	BMOB3F	BEMOBI MOBILE TECH S.A.	09042817000105	1	2022-03-28	\N	\N	\N	\N
2144	BNBR3	BCO NORDESTE DO BRASIL S.A.	07237373000120	1	2022-03-28	\N	\N	\N	\N
2145	BNBR3F	BCO NORDESTE DO BRASIL S.A.	07237373000120	1	2022-03-28	\N	\N	\N	\N
2146	BOAS3	BOA VISTA SERVIÇOS S.A.	11725176000127	1	2022-03-28	\N	\N	\N	\N
2147	BOAS3F	BOA VISTA SERVIÇOS S.A.	11725176000127	1	2022-03-28	\N	\N	\N	\N
2148	BOBR3	BOMBRIL S.A.	50564053000103	1	2022-03-28	\N	\N	\N	\N
2149	BOBR3F	BOMBRIL S.A.	50564053000103	1	2022-03-28	\N	\N	\N	\N
2150	BOBR4	BOMBRIL S.A.	50564053000103	1	2022-03-28	\N	\N	\N	\N
2151	BOBR4F	BOMBRIL S.A.	50564053000103	1	2022-03-28	\N	\N	\N	\N
2152	BPAC3	BCO BTG PACTUAL S.A.	30306294000145	1	2022-03-28	\N	\N	\N	\N
2153	BPAC3F	BCO BTG PACTUAL S.A.	30306294000145	1	2022-03-28	\N	\N	\N	\N
2154	BPAC5	BCO BTG PACTUAL S.A.	30306294000145	1	2022-03-28	\N	\N	\N	\N
2155	BPAC5F	BCO BTG PACTUAL S.A.	30306294000145	1	2022-03-28	\N	\N	\N	\N
2156	BPAN11	BCO PAN S.A.	59285411000113	1	2022-03-28	\N	\N	\N	\N
2157	BPAN3	BCO PAN S.A.	59285411000113	1	2022-03-28	\N	\N	\N	\N
2158	BPAN4	BCO PAN S.A.	59285411000113	1	2022-03-28	\N	\N	\N	\N
2159	BPAN4F	BCO PAN S.A.	59285411000113	1	2022-03-28	\N	\N	\N	\N
2160	BPAR3	BCO ESTADO DO PARA S.A.	04913711000108	1	2022-03-28	\N	\N	\N	\N
2161	BPAR3F	BCO ESTADO DO PARA S.A.	04913711000108	1	2022-03-28	\N	\N	\N	\N
2162	BRAP3	BRADESPAR S.A.	03847461000192	1	2022-03-28	\N	\N	\N	\N
2163	BRAP3F	BRADESPAR S.A.	03847461000192	1	2022-03-28	\N	\N	\N	\N
2164	BRAP4	BRADESPAR S.A.	03847461000192	1	2022-03-28	\N	\N	\N	\N
2165	BRAP4F	BRADESPAR S.A.	03847461000192	1	2022-03-28	\N	\N	\N	\N
2166	BRBI3	BR ADVISORY PARTNERS PARTICIPAÇĠES S.A.	10739356000103	1	2022-03-28	\N	\N	\N	\N
2167	BRBI4	BR ADVISORY PARTNERS PARTICIPAÇĠES S.A.	10739356000103	1	2022-03-28	\N	\N	\N	\N
2168	BRFS3	BRF S.A.	01838723000127	1	2022-03-28	\N	\N	\N	\N
2169	BRFS3F	BRF S.A.	01838723000127	1	2022-03-28	\N	\N	\N	\N
2170	BRGE11	CONSORCIO ALFA DE ADMINISTRACAO S.A.	17193806000146	1	2022-03-28	\N	\N	\N	\N
2171	BRGE11F	CONSORCIO ALFA DE ADMINISTRACAO S.A.	17193806000146	1	2022-03-28	\N	\N	\N	\N
2172	BRGE12	CONSORCIO ALFA DE ADMINISTRACAO S.A.	17193806000146	1	2022-03-28	\N	\N	\N	\N
2173	BRGE12F	CONSORCIO ALFA DE ADMINISTRACAO S.A.	17193806000146	1	2022-03-28	\N	\N	\N	\N
2174	BRGE3	CONSORCIO ALFA DE ADMINISTRACAO S.A.	17193806000146	1	2022-03-28	\N	\N	\N	\N
2175	BRGE3F	CONSORCIO ALFA DE ADMINISTRACAO S.A.	17193806000146	1	2022-03-28	\N	\N	\N	\N
2176	BRGE5	CONSORCIO ALFA DE ADMINISTRACAO S.A.	17193806000146	1	2022-03-28	\N	\N	\N	\N
2177	BRGE5F	CONSORCIO ALFA DE ADMINISTRACAO S.A.	17193806000146	1	2022-03-28	\N	\N	\N	\N
2178	BRGE6	CONSORCIO ALFA DE ADMINISTRACAO S.A.	17193806000146	1	2022-03-28	\N	\N	\N	\N
2179	BRGE6F	CONSORCIO ALFA DE ADMINISTRACAO S.A.	17193806000146	1	2022-03-28	\N	\N	\N	\N
2180	BRGE7	CONSORCIO ALFA DE ADMINISTRACAO S.A.	17193806000146	1	2022-03-28	\N	\N	\N	\N
2181	BRGE7F	CONSORCIO ALFA DE ADMINISTRACAO S.A.	17193806000146	1	2022-03-28	\N	\N	\N	\N
2182	BRGE8	CONSORCIO ALFA DE ADMINISTRACAO S.A.	17193806000146	1	2022-03-28	\N	\N	\N	\N
2183	BRGE8F	CONSORCIO ALFA DE ADMINISTRACAO S.A.	17193806000146	1	2022-03-28	\N	\N	\N	\N
2184	BRIT3	BRISANET PARTICIPAÇĠES S.A.	19796586000170	1	2022-03-28	\N	\N	\N	\N
2185	BRIT3F	BRISANET PARTICIPAÇĠES S.A.	19796586000170	1	2022-03-28	\N	\N	\N	\N
2186	BRIV3	BCO ALFA DE INVESTIMENTO S.A.	60770336000165	1	2022-03-28	\N	\N	\N	\N
2187	BRIV3F	BCO ALFA DE INVESTIMENTO S.A.	60770336000165	1	2022-03-28	\N	\N	\N	\N
2188	BRIV4	BCO ALFA DE INVESTIMENTO S.A.	60770336000165	1	2022-03-28	\N	\N	\N	\N
2189	BRIV4F	BCO ALFA DE INVESTIMENTO S.A.	60770336000165	1	2022-03-28	\N	\N	\N	\N
2190	BRKM3	BRASKEM S.A.	42150391000170	1	2022-03-28	\N	\N	\N	\N
2191	BRKM3F	BRASKEM S.A.	42150391000170	1	2022-03-28	\N	\N	\N	\N
2192	BRKM5	BRASKEM S.A.	42150391000170	1	2022-03-28	\N	\N	\N	\N
2193	BRKM5F	BRASKEM S.A.	42150391000170	1	2022-03-28	\N	\N	\N	\N
2194	BRKM6	BRASKEM S.A.	42150391000170	1	2022-03-28	\N	\N	\N	\N
2195	BRKM6F	BRASKEM S.A.	42150391000170	1	2022-03-28	\N	\N	\N	\N
2196	BRML3	BR MALLS PARTICIPACOES S.A.	06977745000191	1	2022-03-28	\N	\N	\N	\N
2197	BRML3F	BR MALLS PARTICIPACOES S.A.	06977745000191	1	2022-03-28	\N	\N	\N	\N
2198	BRPR11	BR PROPERTIES S.A.	06977751000149	1	2022-03-28	\N	\N	\N	\N
2199	BRPR3	BR PROPERTIES S.A.	06977751000149	1	2022-03-28	\N	\N	\N	\N
2200	BRPR3F	BR PROPERTIES S.A.	06977751000149	1	2022-03-28	\N	\N	\N	\N
2201	BRQB3	BRQ SOLUCOES EM INFORMATICA S.A.	36542025000164	1	2022-03-28	\N	\N	\N	\N
2202	BRQB3F	BRQ SOLUCOES EM INFORMATICA S.A.	36542025000164	1	2022-03-28	\N	\N	\N	\N
2203	BRSR3	BCO ESTADO DO RIO GRANDE DO SUL S.A.	92702067000196	1	2022-03-28	\N	\N	\N	\N
2204	BRSR3F	BCO ESTADO DO RIO GRANDE DO SUL S.A.	92702067000196	1	2022-03-28	\N	\N	\N	\N
2205	BRSR5	BCO ESTADO DO RIO GRANDE DO SUL S.A.	92702067000196	1	2022-03-28	\N	\N	\N	\N
2206	BRSR5F	BCO ESTADO DO RIO GRANDE DO SUL S.A.	92702067000196	1	2022-03-28	\N	\N	\N	\N
2207	BRSR6	BCO ESTADO DO RIO GRANDE DO SUL S.A.	92702067000196	1	2022-03-28	\N	\N	\N	\N
2208	BRSR6F	BCO ESTADO DO RIO GRANDE DO SUL S.A.	92702067000196	1	2022-03-28	\N	\N	\N	\N
2209	BSLI3	BRB BCO DE BRASILIA S.A.	00000208000100	1	2022-03-28	\N	\N	\N	\N
2210	BSLI3F	BRB BCO DE BRASILIA S.A.	00000208000100	1	2022-03-28	\N	\N	\N	\N
2211	BSLI4	BRB BCO DE BRASILIA S.A.	00000208000100	1	2022-03-28	\N	\N	\N	\N
2212	BSLI4F	BRB BCO DE BRASILIA S.A.	00000208000100	1	2022-03-28	\N	\N	\N	\N
2213	CABI3B	CABINDA PARTICIPACOES S.A.	04030182000102	1	2022-03-28	\N	\N	\N	\N
2214	CABI3BF	CABINDA PARTICIPACOES S.A.	04030182000102	1	2022-03-28	\N	\N	\N	\N
2215	CACO3B	CACONDE PARTICIPACOES S.A.	04031213000131	1	2022-03-28	\N	\N	\N	\N
2216	CACO3BF	CACONDE PARTICIPACOES S.A.	04031213000131	1	2022-03-28	\N	\N	\N	\N
2217	CALI3	CONSTRUTORA ADOLPHO LINDENBERG S.A.	61022042000118	1	2022-03-28	\N	\N	\N	\N
2218	CALI3F	CONSTRUTORA ADOLPHO LINDENBERG S.A.	61022042000118	1	2022-03-28	\N	\N	\N	\N
2219	CALI4	CONSTRUTORA ADOLPHO LINDENBERG S.A.	61022042000118	1	2022-03-28	\N	\N	\N	\N
2220	CALI4F	CONSTRUTORA ADOLPHO LINDENBERG S.A.	61022042000118	1	2022-03-28	\N	\N	\N	\N
2221	CAMB3	CAMBUCI S.A.	61088894000108	1	2022-03-28	\N	\N	\N	\N
2222	CAMB3F	CAMBUCI S.A.	61088894000108	1	2022-03-28	\N	\N	\N	\N
2223	CAML3	CAMIL ALIMENTOS S.A.	64904295000103	1	2022-03-28	\N	\N	\N	\N
2224	CAML3F	CAMIL ALIMENTOS S.A.	64904295000103	1	2022-03-28	\N	\N	\N	\N
2225	CARD3	CSU CARDSYSTEM S.A.	01896779000138	1	2022-03-28	\N	\N	\N	\N
2226	CARD3F	CSU CARDSYSTEM S.A.	01896779000138	1	2022-03-28	\N	\N	\N	\N
2227	CASH3	MÉLIUZ S.A.	14110585000107	1	2022-03-28	\N	\N	\N	\N
2228	CASH3F	MÉLIUZ S.A.	14110585000107	1	2022-03-28	\N	\N	\N	\N
2229	CASN3	CIA CATARINENSE DE AGUAS E SANEAM.-CASAN	82508433000117	1	2022-03-28	\N	\N	\N	\N
2230	CASN3F	CIA CATARINENSE DE AGUAS E SANEAM.-CASAN	82508433000117	1	2022-03-28	\N	\N	\N	\N
2231	CASN4	CIA CATARINENSE DE AGUAS E SANEAM.-CASAN	82508433000117	1	2022-03-28	\N	\N	\N	\N
2232	CASN4F	CIA CATARINENSE DE AGUAS E SANEAM.-CASAN	82508433000117	1	2022-03-28	\N	\N	\N	\N
2233	CATA3	CIA INDUSTRIAL CATAGUASES	19526748000150	1	2022-03-28	\N	\N	\N	\N
2234	CATA3F	CIA INDUSTRIAL CATAGUASES	19526748000150	1	2022-03-28	\N	\N	\N	\N
2235	CATA4	CIA INDUSTRIAL CATAGUASES	19526748000150	1	2022-03-28	\N	\N	\N	\N
2236	CATA4F	CIA INDUSTRIAL CATAGUASES	19526748000150	1	2022-03-28	\N	\N	\N	\N
2237	CBAV3	Companhia Brasileira de Alumínio	61409892000173	1	2022-03-28	\N	\N	\N	\N
2238	CBAV3F	Companhia Brasileira de Alumínio	61409892000173	1	2022-03-28	\N	\N	\N	\N
2239	CBEE3	AMPLA ENERGIA E SERVICOS S.A.	33050071000158	1	2022-03-28	\N	\N	\N	\N
2240	CBEE3F	AMPLA ENERGIA E SERVICOS S.A.	33050071000158	1	2022-03-28	\N	\N	\N	\N
2241	CCRO3	CCR S.A.	02846056000197	1	2022-03-28	\N	\N	\N	\N
2242	CCRO3F	CCR S.A.	02846056000197	1	2022-03-28	\N	\N	\N	\N
2243	CEAB3	CEA MODAS S.A.	45242914000105	1	2022-03-28	\N	\N	\N	\N
2244	CEAB3F	CEA MODAS S.A.	45242914000105	1	2022-03-28	\N	\N	\N	\N
2245	CEBR3	CIA ENERGETICA DE BRASILIA	00070698000111	1	2022-03-28	\N	\N	\N	\N
2246	CEBR3F	CIA ENERGETICA DE BRASILIA	00070698000111	1	2022-03-28	\N	\N	\N	\N
2247	CEBR5	CIA ENERGETICA DE BRASILIA	00070698000111	1	2022-03-28	\N	\N	\N	\N
2248	CEBR5F	CIA ENERGETICA DE BRASILIA	00070698000111	1	2022-03-28	\N	\N	\N	\N
2249	CEBR6	CIA ENERGETICA DE BRASILIA	00070698000111	1	2022-03-28	\N	\N	\N	\N
2250	CEBR6F	CIA ENERGETICA DE BRASILIA	00070698000111	1	2022-03-28	\N	\N	\N	\N
2251	CEDO3	CIA FIACAO TECIDOS CEDRO CACHOEIRA	17245234000100	1	2022-03-28	\N	\N	\N	\N
2252	CEDO3F	CIA FIACAO TECIDOS CEDRO CACHOEIRA	17245234000100	1	2022-03-28	\N	\N	\N	\N
2253	CEDO4	CIA FIACAO TECIDOS CEDRO CACHOEIRA	17245234000100	1	2022-03-28	\N	\N	\N	\N
2254	CEDO4F	CIA FIACAO TECIDOS CEDRO CACHOEIRA	17245234000100	1	2022-03-28	\N	\N	\N	\N
2255	CEEB3	CIA ELETRICIDADE EST. DA BAHIA - COELBA	15139629000194	1	2022-03-28	\N	\N	\N	\N
2256	CEEB3F	CIA ELETRICIDADE EST. DA BAHIA - COELBA	15139629000194	1	2022-03-28	\N	\N	\N	\N
2257	CEEB5	CIA ELETRICIDADE EST. DA BAHIA - COELBA	15139629000194	1	2022-03-28	\N	\N	\N	\N
2258	CEEB5F	CIA ELETRICIDADE EST. DA BAHIA - COELBA	15139629000194	1	2022-03-28	\N	\N	\N	\N
2259	CEEB6	CIA ELETRICIDADE EST. DA BAHIA - COELBA	15139629000194	1	2022-03-28	\N	\N	\N	\N
2260	CEEB6F	CIA ELETRICIDADE EST. DA BAHIA - COELBA	15139629000194	1	2022-03-28	\N	\N	\N	\N
2261	CEED3	CIA ESTADUAL DE DISTRIB ENER ELET-CEEE-D	08467115000100	1	2022-03-28	\N	\N	\N	\N
2262	CEED3F	CIA ESTADUAL DE DISTRIB ENER ELET-CEEE-D	08467115000100	1	2022-03-28	\N	\N	\N	\N
2263	CEED4	CIA ESTADUAL DE DISTRIB ENER ELET-CEEE-D	08467115000100	1	2022-03-28	\N	\N	\N	\N
2264	CEED4F	CIA ESTADUAL DE DISTRIB ENER ELET-CEEE-D	08467115000100	1	2022-03-28	\N	\N	\N	\N
2265	CEGR3	CIA DISTRIB DE GAS DO RIO DE JANEIRO-CEG	33938119000169	1	2022-03-28	\N	\N	\N	\N
2266	CEGR3F	CIA DISTRIB DE GAS DO RIO DE JANEIRO-CEG	33938119000169	1	2022-03-28	\N	\N	\N	\N
2267	CEPE3	CIA ENERGETICA DE PERNAMBUCO - CELPE	10835932000108	1	2022-03-28	\N	\N	\N	\N
2268	CEPE3F	CIA ENERGETICA DE PERNAMBUCO - CELPE	10835932000108	1	2022-03-28	\N	\N	\N	\N
2269	CEPE5	CIA ENERGETICA DE PERNAMBUCO - CELPE	10835932000108	1	2022-03-28	\N	\N	\N	\N
2270	CEPE5F	CIA ENERGETICA DE PERNAMBUCO - CELPE	10835932000108	1	2022-03-28	\N	\N	\N	\N
2271	CEPE6	CIA ENERGETICA DE PERNAMBUCO - CELPE	10835932000108	1	2022-03-28	\N	\N	\N	\N
2272	CEPE6F	CIA ENERGETICA DE PERNAMBUCO - CELPE	10835932000108	1	2022-03-28	\N	\N	\N	\N
2273	CESP3	CESP - CIA ENERGETICA DE SAO PAULO	60933603000178	1	2022-03-28	\N	\N	\N	\N
2274	CESP3F	CESP - CIA ENERGETICA DE SAO PAULO	60933603000178	1	2022-03-28	\N	\N	\N	\N
2275	CESP5	CESP - CIA ENERGETICA DE SAO PAULO	60933603000178	1	2022-03-28	\N	\N	\N	\N
2276	CESP5F	CESP - CIA ENERGETICA DE SAO PAULO	60933603000178	1	2022-03-28	\N	\N	\N	\N
2277	CESP6	CESP - CIA ENERGETICA DE SAO PAULO	60933603000178	1	2022-03-28	\N	\N	\N	\N
2278	CESP6F	CESP - CIA ENERGETICA DE SAO PAULO	60933603000178	1	2022-03-28	\N	\N	\N	\N
2279	CGAS3	CIA GAS DE SAO PAULO - COMGAS	61856571000117	1	2022-03-28	\N	\N	\N	\N
2280	CGAS3F	CIA GAS DE SAO PAULO - COMGAS	61856571000117	1	2022-03-28	\N	\N	\N	\N
2281	CGAS5	CIA GAS DE SAO PAULO - COMGAS	61856571000117	1	2022-03-28	\N	\N	\N	\N
2282	CGAS5F	CIA GAS DE SAO PAULO - COMGAS	61856571000117	1	2022-03-28	\N	\N	\N	\N
2283	CGRA3	GRAZZIOTIN S.A.	92012467000170	1	2022-03-28	\N	\N	\N	\N
2284	CGRA3F	GRAZZIOTIN S.A.	92012467000170	1	2022-03-28	\N	\N	\N	\N
2285	CGRA4	GRAZZIOTIN S.A.	92012467000170	1	2022-03-28	\N	\N	\N	\N
2286	CGRA4F	GRAZZIOTIN S.A.	92012467000170	1	2022-03-28	\N	\N	\N	\N
2287	CIEL3	CIELO S.A.	01027058000191	1	2022-03-28	\N	\N	\N	\N
2288	CIEL3F	CIELO S.A.	01027058000191	1	2022-03-28	\N	\N	\N	\N
2289	CLSA3	CLEAR SALE S.A.	03802115000198	1	2022-03-28	\N	\N	\N	\N
2290	CLSA3F	CLEAR SALE S.A.	03802115000198	1	2022-03-28	\N	\N	\N	\N
2291	CLSC3	CENTRAIS ELET DE SANTA CATARINA S.A.	83878892000155	1	2022-03-28	\N	\N	\N	\N
2292	CLSC3F	CENTRAIS ELET DE SANTA CATARINA S.A.	83878892000155	1	2022-03-28	\N	\N	\N	\N
2293	CLSC4	CENTRAIS ELET DE SANTA CATARINA S.A.	83878892000155	1	2022-03-28	\N	\N	\N	\N
2294	CLSC4F	CENTRAIS ELET DE SANTA CATARINA S.A.	83878892000155	1	2022-03-28	\N	\N	\N	\N
2295	CMIG3	CIA ENERGETICA DE MINAS GERAIS - CEMIG	17155730000164	1	2022-03-28	\N	\N	\N	\N
2296	CMIG3F	CIA ENERGETICA DE MINAS GERAIS - CEMIG	17155730000164	1	2022-03-28	\N	\N	\N	\N
2297	CMIG4	CIA ENERGETICA DE MINAS GERAIS - CEMIG	17155730000164	1	2022-03-28	\N	\N	\N	\N
2298	CMIG4F	CIA ENERGETICA DE MINAS GERAIS - CEMIG	17155730000164	1	2022-03-28	\N	\N	\N	\N
2299	CMIN3	CSN MINERAÇO S.A.	08902291000115	1	2022-03-28	\N	\N	\N	\N
2300	CMIN3F	CSN MINERAÇO S.A.	08902291000115	1	2022-03-28	\N	\N	\N	\N
2301	CMSA3	CIMS S.A.	00272185000193	1	2022-03-28	\N	\N	\N	\N
2302	CMSA3F	CIMS S.A.	00272185000193	1	2022-03-28	\N	\N	\N	\N
2303	CMSA4	CIMS S.A.	00272185000193	1	2022-03-28	\N	\N	\N	\N
2304	CMSA4F	CIMS S.A.	00272185000193	1	2022-03-28	\N	\N	\N	\N
2305	CNSY3	CINESYSTEM S.A.	07437016000105	1	2022-03-28	\N	\N	\N	\N
2306	CNSY3F	CINESYSTEM S.A.	07437016000105	1	2022-03-28	\N	\N	\N	\N
2307	COCE3	CIA ENERGETICA DO CEARA - COELCE	07047251000170	1	2022-03-28	\N	\N	\N	\N
2308	COCE3F	CIA ENERGETICA DO CEARA - COELCE	07047251000170	1	2022-03-28	\N	\N	\N	\N
2309	COCE5	CIA ENERGETICA DO CEARA - COELCE	07047251000170	1	2022-03-28	\N	\N	\N	\N
2310	COCE5F	CIA ENERGETICA DO CEARA - COELCE	07047251000170	1	2022-03-28	\N	\N	\N	\N
2311	COCE6	CIA ENERGETICA DO CEARA - COELCE	07047251000170	1	2022-03-28	\N	\N	\N	\N
2312	COCE6F	CIA ENERGETICA DO CEARA - COELCE	07047251000170	1	2022-03-28	\N	\N	\N	\N
2313	COGN3	COGNA EDUCAÇO S.A.	02800026000140	1	2022-03-28	\N	\N	\N	\N
2314	COGN3F	COGNA EDUCAÇO S.A.	02800026000140	1	2022-03-28	\N	\N	\N	\N
2315	COMR3	COMERC PARTICIPACOES S.A.	25369840000157	1	2022-03-28	\N	\N	\N	\N
2316	COMR3F	COMERC PARTICIPACOES S.A.	25369840000157	1	2022-03-28	\N	\N	\N	\N
2317	CORR3	CORREA RIBEIRO S.A. COMERCIO E INDUSTRIA	15101405000193	1	2022-03-28	\N	\N	\N	\N
2318	CORR3F	CORREA RIBEIRO S.A. COMERCIO E INDUSTRIA	15101405000193	1	2022-03-28	\N	\N	\N	\N
2319	CORR4	CORREA RIBEIRO S.A. COMERCIO E INDUSTRIA	15101405000193	1	2022-03-28	\N	\N	\N	\N
2320	CORR4F	CORREA RIBEIRO S.A. COMERCIO E INDUSTRIA	15101405000193	1	2022-03-28	\N	\N	\N	\N
2321	CPFE3	CPFL ENERGIA S.A.	02429144000193	1	2022-03-28	\N	\N	\N	\N
2322	CPFE3F	CPFL ENERGIA S.A.	02429144000193	1	2022-03-28	\N	\N	\N	\N
2323	CPLE3	CIA PARANAENSE DE ENERGIA - COPEL	76483817000120	1	2022-03-28	\N	\N	\N	\N
2324	CPLE3F	CIA PARANAENSE DE ENERGIA - COPEL	76483817000120	1	2022-03-28	\N	\N	\N	\N
2325	CPLE5	CIA PARANAENSE DE ENERGIA - COPEL	76483817000120	1	2022-03-28	\N	\N	\N	\N
2326	CPLE5F	CIA PARANAENSE DE ENERGIA - COPEL	76483817000120	1	2022-03-28	\N	\N	\N	\N
2327	CPLE6	CIA PARANAENSE DE ENERGIA - COPEL	76483817000120	1	2022-03-28	\N	\N	\N	\N
2328	CPLE6F	CIA PARANAENSE DE ENERGIA - COPEL	76483817000120	1	2022-03-28	\N	\N	\N	\N
2329	CRDE3	CR2 EMPREENDIMENTOS IMOBILIARIOS S.A.	07820907000146	1	2022-03-28	\N	\N	\N	\N
2330	CRDE3F	CR2 EMPREENDIMENTOS IMOBILIARIOS S.A.	07820907000146	1	2022-03-28	\N	\N	\N	\N
2331	CRFB3	ATACADO S.A.	75315333000109	1	2022-03-28	\N	\N	\N	\N
2332	CRFB3F	ATACADO S.A.	75315333000109	1	2022-03-28	\N	\N	\N	\N
2333	CRIV3	FINANCEIRA ALFA S.A.- CRED FINANC E INVS	17167412000113	1	2022-03-28	\N	\N	\N	\N
2334	CRIV3F	FINANCEIRA ALFA S.A.- CRED FINANC E INVS	17167412000113	1	2022-03-28	\N	\N	\N	\N
2335	CRIV4	FINANCEIRA ALFA S.A.- CRED FINANC E INVS	17167412000113	1	2022-03-28	\N	\N	\N	\N
2336	CRIV4F	FINANCEIRA ALFA S.A.- CRED FINANC E INVS	17167412000113	1	2022-03-28	\N	\N	\N	\N
2337	CRPG3	TRONOX PIGMENTOS DO BRASIL S.A.	15115504000124	1	2022-03-28	\N	\N	\N	\N
2338	CRPG3F	TRONOX PIGMENTOS DO BRASIL S.A.	15115504000124	1	2022-03-28	\N	\N	\N	\N
2339	CRPG5	TRONOX PIGMENTOS DO BRASIL S.A.	15115504000124	1	2022-03-28	\N	\N	\N	\N
2340	CRPG5F	TRONOX PIGMENTOS DO BRASIL S.A.	15115504000124	1	2022-03-28	\N	\N	\N	\N
2341	CRPG6	TRONOX PIGMENTOS DO BRASIL S.A.	15115504000124	1	2022-03-28	\N	\N	\N	\N
2342	CRPG6F	TRONOX PIGMENTOS DO BRASIL S.A.	15115504000124	1	2022-03-28	\N	\N	\N	\N
2343	CRTE3B	CONC RIO-TERESOPOLIS S.A.	00938574000105	1	2022-03-28	\N	\N	\N	\N
2344	CRTE3BF	CONC RIO-TERESOPOLIS S.A.	00938574000105	1	2022-03-28	\N	\N	\N	\N
2345	CRTE5B	CONC RIO-TERESOPOLIS S.A.	00938574000105	1	2022-03-28	\N	\N	\N	\N
2346	CRTE5BF	CONC RIO-TERESOPOLIS S.A.	00938574000105	1	2022-03-28	\N	\N	\N	\N
2347	CSAB3	CIA SEGUROS ALIANCA DA BAHIA	15144017000190	1	2022-03-28	\N	\N	\N	\N
2348	CSAB3F	CIA SEGUROS ALIANCA DA BAHIA	15144017000190	1	2022-03-28	\N	\N	\N	\N
2349	CSAB4	CIA SEGUROS ALIANCA DA BAHIA	15144017000190	1	2022-03-28	\N	\N	\N	\N
2350	CSAB4F	CIA SEGUROS ALIANCA DA BAHIA	15144017000190	1	2022-03-28	\N	\N	\N	\N
2351	CSAN3	COSAN S.A.	50746577000115	1	2022-03-28	\N	\N	\N	\N
2352	CSAN3F	COSAN S.A.	50746577000115	1	2022-03-28	\N	\N	\N	\N
2353	CSED3	CRUZEIRO DO SUL EDUCACIONAL S.A.	62984091000102	1	2022-03-28	\N	\N	\N	\N
2354	CSED3F	CRUZEIRO DO SUL EDUCACIONAL S.A.	62984091000102	1	2022-03-28	\N	\N	\N	\N
2355	CSMG3	CIA SANEAMENTO DE MINAS GERAIS-COPASA MG	17281106000103	1	2022-03-28	\N	\N	\N	\N
2356	CSMG3F	CIA SANEAMENTO DE MINAS GERAIS-COPASA MG	17281106000103	1	2022-03-28	\N	\N	\N	\N
2357	CSNA3	CIA SIDERURGICA NACIONAL	33042730000104	1	2022-03-28	\N	\N	\N	\N
2358	CSNA3F	CIA SIDERURGICA NACIONAL	33042730000104	1	2022-03-28	\N	\N	\N	\N
2359	CSRN3	CIA ENERGETICA DO RIO GDE NORTE - COSERN	08324196000181	1	2022-03-28	\N	\N	\N	\N
2360	CSRN3F	CIA ENERGETICA DO RIO GDE NORTE - COSERN	08324196000181	1	2022-03-28	\N	\N	\N	\N
2361	CSRN5	CIA ENERGETICA DO RIO GDE NORTE - COSERN	08324196000181	1	2022-03-28	\N	\N	\N	\N
2362	CSRN5F	CIA ENERGETICA DO RIO GDE NORTE - COSERN	08324196000181	1	2022-03-28	\N	\N	\N	\N
2363	CSRN6	CIA ENERGETICA DO RIO GDE NORTE - COSERN	08324196000181	1	2022-03-28	\N	\N	\N	\N
2364	CSRN6F	CIA ENERGETICA DO RIO GDE NORTE - COSERN	08324196000181	1	2022-03-28	\N	\N	\N	\N
2365	CTCA3	CTC - CENTRO DE TECNOLOGIA CANAVIEIRA S.A.	06981381000113	1	2022-03-28	\N	\N	\N	\N
2366	CTCA3F	CTC - CENTRO DE TECNOLOGIA CANAVIEIRA S.A.	06981381000113	1	2022-03-28	\N	\N	\N	\N
2367	CTKA3	KARSTEN S.A.	82640558000104	1	2022-03-28	\N	\N	\N	\N
2368	CTKA3F	KARSTEN S.A.	82640558000104	1	2022-03-28	\N	\N	\N	\N
2369	CTKA4	KARSTEN S.A.	82640558000104	1	2022-03-28	\N	\N	\N	\N
2370	CTKA4F	KARSTEN S.A.	82640558000104	1	2022-03-28	\N	\N	\N	\N
2371	CTNM3	CIA TECIDOS NORTE DE MINAS COTEMINAS	22677520000176	1	2022-03-28	\N	\N	\N	\N
2372	CTNM3F	CIA TECIDOS NORTE DE MINAS COTEMINAS	22677520000176	1	2022-03-28	\N	\N	\N	\N
2373	CTNM4	CIA TECIDOS NORTE DE MINAS COTEMINAS	22677520000176	1	2022-03-28	\N	\N	\N	\N
2374	CTNM4F	CIA TECIDOS NORTE DE MINAS COTEMINAS	22677520000176	1	2022-03-28	\N	\N	\N	\N
2375	CTSA3	CIA TECIDOS SANTANENSE	21255567000189	1	2022-03-28	\N	\N	\N	\N
2376	CTSA3F	CIA TECIDOS SANTANENSE	21255567000189	1	2022-03-28	\N	\N	\N	\N
2377	CTSA4	CIA TECIDOS SANTANENSE	21255567000189	1	2022-03-28	\N	\N	\N	\N
2378	CTSA4F	CIA TECIDOS SANTANENSE	21255567000189	1	2022-03-28	\N	\N	\N	\N
2379	CURY3	CURY CONSTRUTORA E INCORPORADORA S.A.	08797760000183	1	2022-03-28	\N	\N	\N	\N
2380	CURY3F	CURY CONSTRUTORA E INCORPORADORA S.A.	08797760000183	1	2022-03-28	\N	\N	\N	\N
2381	CVCB3	CVC BRASIL OPERADORA E AGÊNCIA DE VIAGENS S.A.	10760260000119	1	2022-03-28	\N	\N	\N	\N
2382	CVCB3F	CVC BRASIL OPERADORA E AGÊNCIA DE VIAGENS S.A.	10760260000119	1	2022-03-28	\N	\N	\N	\N
2383	CXSE3	CAIXA SEGURIDADE PARTICIPAÇĠES S.A.	22543331000100	1	2022-03-28	\N	\N	\N	\N
2384	CXSE3F	CAIXA SEGURIDADE PARTICIPAÇĠES S.A.	22543331000100	1	2022-03-28	\N	\N	\N	\N
2385	CYRE3	CYRELA BRAZIL REALTY S.A.EMPREEND E PART	73178600000118	1	2022-03-28	\N	\N	\N	\N
2386	CYRE3F	CYRELA BRAZIL REALTY S.A.EMPREEND E PART	73178600000118	1	2022-03-28	\N	\N	\N	\N
2387	DASA3	DIAGNOSTICOS DA AMERICA S.A.	61486650000183	1	2022-03-28	\N	\N	\N	\N
2388	DASA3F	DIAGNOSTICOS DA AMERICA S.A.	61486650000183	1	2022-03-28	\N	\N	\N	\N
2389	DESK3	DESKTOP S.A.	08170849000115	1	2022-03-28	\N	\N	\N	\N
2390	DESK3F	DESKTOP S.A.	08170849000115	1	2022-03-28	\N	\N	\N	\N
2391	DEXP3	DEXXOS PARTICIPACOES S.A.	02193750000152	1	2022-03-28	\N	\N	\N	\N
2392	DEXP3F	DEXXOS PARTICIPACOES S.A.	02193750000152	1	2022-03-28	\N	\N	\N	\N
2393	DEXP4	DEXXOS PARTICIPACOES S.A.	02193750000152	1	2022-03-28	\N	\N	\N	\N
2394	DEXP4F	DEXXOS PARTICIPACOES S.A.	02193750000152	1	2022-03-28	\N	\N	\N	\N
2395	DIRR3	DIRECIONAL ENGENHARIA S.A.	16614075000100	1	2022-03-28	\N	\N	\N	\N
2396	DIRR3F	DIRECIONAL ENGENHARIA S.A.	16614075000100	1	2022-03-28	\N	\N	\N	\N
2397	DMMO3	DOMMO ENERGIA S.A.	08926302000105	1	2022-03-28	\N	\N	\N	\N
2398	DMMO3F	DOMMO ENERGIA S.A.	08926302000105	1	2022-03-28	\N	\N	\N	\N
2399	DMVF3	D1000 VAREJO FARMA PARTICIPAÇĠES S.A.	12108897000150	1	2022-03-28	\N	\N	\N	\N
2400	DMVF3F	D1000 VAREJO FARMA PARTICIPAÇĠES S.A.	12108897000150	1	2022-03-28	\N	\N	\N	\N
2401	DOHL3	DOHLER S.A.	84683408000103	1	2022-03-28	\N	\N	\N	\N
2402	DOHL3F	DOHLER S.A.	84683408000103	1	2022-03-28	\N	\N	\N	\N
2403	DOHL4	DOHLER S.A.	84683408000103	1	2022-03-28	\N	\N	\N	\N
2404	DOHL4F	DOHLER S.A.	84683408000103	1	2022-03-28	\N	\N	\N	\N
2405	DOTZ3	Dotz S.A.	18174270000184	1	2022-03-28	\N	\N	\N	\N
2406	DOTZ3F	Dotz S.A.	18174270000184	1	2022-03-28	\N	\N	\N	\N
2407	DTCY3	DTCOM - DIRECT TO COMPANY S.A.	03303999000136	1	2022-03-28	\N	\N	\N	\N
2408	DTCY3F	DTCOM - DIRECT TO COMPANY S.A.	03303999000136	1	2022-03-28	\N	\N	\N	\N
2409	DTCY4	DTCOM - DIRECT TO COMPANY S.A.	03303999000136	1	2022-03-28	\N	\N	\N	\N
2410	DTCY4F	DTCOM - DIRECT TO COMPANY S.A.	03303999000136	1	2022-03-28	\N	\N	\N	\N
2411	DXCO3	DEXCO S.A.	97837181000147	1	2022-03-28	\N	\N	\N	\N
2412	DXCO3F	DEXCO S.A.	97837181000147	1	2022-03-28	\N	\N	\N	\N
2413	EALT3	ELECTRO ACO ALTONA S.A.	82643537000134	1	2022-03-28	\N	\N	\N	\N
2414	EALT3F	ELECTRO ACO ALTONA S.A.	82643537000134	1	2022-03-28	\N	\N	\N	\N
2415	EALT4	ELECTRO ACO ALTONA S.A.	82643537000134	1	2022-03-28	\N	\N	\N	\N
2416	EALT4F	ELECTRO ACO ALTONA S.A.	82643537000134	1	2022-03-28	\N	\N	\N	\N
2417	ECOR3	ECORODOVIAS INFRAESTRUTURA E LOGÍSTICA S.A.	04149454000180	1	2022-03-28	\N	\N	\N	\N
2418	ECOR3F	ECORODOVIAS INFRAESTRUTURA E LOGÍSTICA S.A.	04149454000180	1	2022-03-28	\N	\N	\N	\N
2419	ECPR3	EMPRESA NAC COM REDITO PART S.A.ENCORPAR	01971614000183	1	2022-03-28	\N	\N	\N	\N
2420	ECPR3F	EMPRESA NAC COM REDITO PART S.A.ENCORPAR	01971614000183	1	2022-03-28	\N	\N	\N	\N
2421	ECPR4	EMPRESA NAC COM REDITO PART S.A.ENCORPAR	01971614000183	1	2022-03-28	\N	\N	\N	\N
2422	ECPR4F	EMPRESA NAC COM REDITO PART S.A.ENCORPAR	01971614000183	1	2022-03-28	\N	\N	\N	\N
2423	EEEL3	CIA ESTADUAL DE TRANSMISSO DE ENER. ELET-CEEE-T	92715812000131	1	2022-03-28	\N	\N	\N	\N
2424	EEEL3F	CIA ESTADUAL DE TRANSMISSO DE ENER. ELET-CEEE-T	92715812000131	1	2022-03-28	\N	\N	\N	\N
2425	EEEL4	CIA ESTADUAL DE TRANSMISSO DE ENER. ELET-CEEE-T	92715812000131	1	2022-03-28	\N	\N	\N	\N
2426	EEEL4F	CIA ESTADUAL DE TRANSMISSO DE ENER. ELET-CEEE-T	92715812000131	1	2022-03-28	\N	\N	\N	\N
2427	EGIE3	ENGIE BRASIL ENERGIA S.A.	02474103000119	1	2022-03-28	\N	\N	\N	\N
2428	EGIE3F	ENGIE BRASIL ENERGIA S.A.	02474103000119	1	2022-03-28	\N	\N	\N	\N
2429	EKTR3	ELEKTRO REDES S.A.	02328280000197	1	2022-03-28	\N	\N	\N	\N
2430	EKTR3F	ELEKTRO REDES S.A.	02328280000197	1	2022-03-28	\N	\N	\N	\N
2431	EKTR4	ELEKTRO REDES S.A.	02328280000197	1	2022-03-28	\N	\N	\N	\N
2432	EKTR4F	ELEKTRO REDES S.A.	02328280000197	1	2022-03-28	\N	\N	\N	\N
2433	ELET3	CENTRAIS ELET BRAS S.A. - ELETROBRAS	00001180000126	1	2022-03-28	\N	\N	\N	\N
2434	ELET3F	CENTRAIS ELET BRAS S.A. - ELETROBRAS	00001180000126	1	2022-03-28	\N	\N	\N	\N
2435	ELET5	CENTRAIS ELET BRAS S.A. - ELETROBRAS	00001180000126	1	2022-03-28	\N	\N	\N	\N
2436	ELET5F	CENTRAIS ELET BRAS S.A. - ELETROBRAS	00001180000126	1	2022-03-28	\N	\N	\N	\N
2437	ELET6	CENTRAIS ELET BRAS S.A. - ELETROBRAS	00001180000126	1	2022-03-28	\N	\N	\N	\N
2438	ELET6F	CENTRAIS ELET BRAS S.A. - ELETROBRAS	00001180000126	1	2022-03-28	\N	\N	\N	\N
2439	ELMD3	ELETROMIDIA S.A.	09347516000181	1	2022-03-28	\N	\N	\N	\N
2440	ELMD3F	ELETROMIDIA S.A.	09347516000181	1	2022-03-28	\N	\N	\N	\N
2441	EMAE3	EMAE - EMPRESA METROP.AGUAS ENERGIA S.A.	02302101000142	1	2022-03-28	\N	\N	\N	\N
2442	EMAE3F	EMAE - EMPRESA METROP.AGUAS ENERGIA S.A.	02302101000142	1	2022-03-28	\N	\N	\N	\N
2443	EMAE4	EMAE - EMPRESA METROP.AGUAS ENERGIA S.A.	02302101000142	1	2022-03-28	\N	\N	\N	\N
2444	EMAE4F	EMAE - EMPRESA METROP.AGUAS ENERGIA S.A.	02302101000142	1	2022-03-28	\N	\N	\N	\N
2445	EMBR3	EMBRAER S.A.	07689002000189	1	2022-03-28	\N	\N	\N	\N
2446	EMBR3F	EMBRAER S.A.	07689002000189	1	2022-03-28	\N	\N	\N	\N
2447	ENAT3	ENAUTA PARTICIPAÇĠES S.A.	11669021000110	1	2022-03-28	\N	\N	\N	\N
2448	ENAT3F	ENAUTA PARTICIPAÇĠES S.A.	11669021000110	1	2022-03-28	\N	\N	\N	\N
2449	ENBR3	EDP - ENERGIAS DO BRASIL S.A.	03983431000103	1	2022-03-28	\N	\N	\N	\N
2450	ENBR3F	EDP - ENERGIAS DO BRASIL S.A.	03983431000103	1	2022-03-28	\N	\N	\N	\N
2451	ENEV3	ENEVA S.A	04423567000121	1	2022-03-28	\N	\N	\N	\N
2452	ENEV3F	ENEVA S.A	04423567000121	1	2022-03-28	\N	\N	\N	\N
2453	ENGI3	ENERGISA S.A.	00864214000106	1	2022-03-28	\N	\N	\N	\N
2454	ENGI3F	ENERGISA S.A.	00864214000106	1	2022-03-28	\N	\N	\N	\N
2455	ENGI4	ENERGISA S.A.	00864214000106	1	2022-03-28	\N	\N	\N	\N
2456	ENGI4F	ENERGISA S.A.	00864214000106	1	2022-03-28	\N	\N	\N	\N
2457	ENJU3	ENJOEI S.A.	16922038000151	1	2022-03-28	\N	\N	\N	\N
2458	ENJU3F	ENJOEI S.A.	16922038000151	1	2022-03-28	\N	\N	\N	\N
2459	ENMT3	ENERGISA MATO GROSSO-DISTRIBUIDORA DE ENERGIA S/A	03467321000199	1	2022-03-28	\N	\N	\N	\N
2460	ENMT3F	ENERGISA MATO GROSSO-DISTRIBUIDORA DE ENERGIA S/A	03467321000199	1	2022-03-28	\N	\N	\N	\N
2461	ENMT4	ENERGISA MATO GROSSO-DISTRIBUIDORA DE ENERGIA S/A	03467321000199	1	2022-03-28	\N	\N	\N	\N
2462	ENMT4F	ENERGISA MATO GROSSO-DISTRIBUIDORA DE ENERGIA S/A	03467321000199	1	2022-03-28	\N	\N	\N	\N
2463	EPAR3	EMBPAR PARTICIPACOES S.A.	42331462000131	1	2022-03-28	\N	\N	\N	\N
2464	EPAR3F	EMBPAR PARTICIPACOES S.A.	42331462000131	1	2022-03-28	\N	\N	\N	\N
2465	EQMA3B	EQUATORIAL MARANHO DISTRIBUIDORA DE ENERGIA S.A.	06272793000184	1	2022-03-28	\N	\N	\N	\N
2466	EQMA3BF	EQUATORIAL MARANHO DISTRIBUIDORA DE ENERGIA S.A.	06272793000184	1	2022-03-28	\N	\N	\N	\N
2467	EQMA5B	EQUATORIAL MARANHO DISTRIBUIDORA DE ENERGIA S.A.	06272793000184	1	2022-03-28	\N	\N	\N	\N
2468	EQMA5BF	EQUATORIAL MARANHO DISTRIBUIDORA DE ENERGIA S.A.	06272793000184	1	2022-03-28	\N	\N	\N	\N
2469	EQMA6B	EQUATORIAL MARANHO DISTRIBUIDORA DE ENERGIA S.A.	06272793000184	1	2022-03-28	\N	\N	\N	\N
2470	EQMA6BF	EQUATORIAL MARANHO DISTRIBUIDORA DE ENERGIA S.A.	06272793000184	1	2022-03-28	\N	\N	\N	\N
2471	EQPA3	EQUATORIAL PARA DISTRIBUIDORA DE ENERGIA S.A.	04895728000180	1	2022-03-28	\N	\N	\N	\N
2472	EQPA3F	EQUATORIAL PARA DISTRIBUIDORA DE ENERGIA S.A.	04895728000180	1	2022-03-28	\N	\N	\N	\N
2473	EQPA5	EQUATORIAL PARA DISTRIBUIDORA DE ENERGIA S.A.	04895728000180	1	2022-03-28	\N	\N	\N	\N
2474	EQPA5F	EQUATORIAL PARA DISTRIBUIDORA DE ENERGIA S.A.	04895728000180	1	2022-03-28	\N	\N	\N	\N
2475	EQPA6	EQUATORIAL PARA DISTRIBUIDORA DE ENERGIA S.A.	04895728000180	1	2022-03-28	\N	\N	\N	\N
2476	EQPA6F	EQUATORIAL PARA DISTRIBUIDORA DE ENERGIA S.A.	04895728000180	1	2022-03-28	\N	\N	\N	\N
2477	EQPA7	EQUATORIAL PARA DISTRIBUIDORA DE ENERGIA S.A.	04895728000180	1	2022-03-28	\N	\N	\N	\N
2478	EQPA7F	EQUATORIAL PARA DISTRIBUIDORA DE ENERGIA S.A.	04895728000180	1	2022-03-28	\N	\N	\N	\N
2479	EQTL3	EQUATORIAL ENERGIA S.A.	03220438000173	1	2022-03-28	\N	\N	\N	\N
2480	EQTL3F	EQUATORIAL ENERGIA S.A.	03220438000173	1	2022-03-28	\N	\N	\N	\N
2481	ESPA3	MPM CORPÓREOS S.A.	26659061000159	1	2022-03-28	\N	\N	\N	\N
2482	ESPA3F	MPM CORPÓREOS S.A.	26659061000159	1	2022-03-28	\N	\N	\N	\N
2483	ESTR3	MANUFATURA DE BRINQUEDOS ESTRELA S.A.	61082004000150	1	2022-03-28	\N	\N	\N	\N
2484	ESTR3F	MANUFATURA DE BRINQUEDOS ESTRELA S.A.	61082004000150	1	2022-03-28	\N	\N	\N	\N
2485	ESTR4	MANUFATURA DE BRINQUEDOS ESTRELA S.A.	61082004000150	1	2022-03-28	\N	\N	\N	\N
2486	ESTR4F	MANUFATURA DE BRINQUEDOS ESTRELA S.A.	61082004000150	1	2022-03-28	\N	\N	\N	\N
2487	ETER3	ETERNIT S.A.	61092037000181	1	2022-03-28	\N	\N	\N	\N
2488	ETER3F	ETERNIT S.A.	61092037000181	1	2022-03-28	\N	\N	\N	\N
2489	EUCA3	EUCATEX S.A. INDUSTRIA E COMERCIO	56643018000166	1	2022-03-28	\N	\N	\N	\N
2490	EUCA3F	EUCATEX S.A. INDUSTRIA E COMERCIO	56643018000166	1	2022-03-28	\N	\N	\N	\N
2491	EUCA4	EUCATEX S.A. INDUSTRIA E COMERCIO	56643018000166	1	2022-03-28	\N	\N	\N	\N
2492	EUCA4F	EUCATEX S.A. INDUSTRIA E COMERCIO	56643018000166	1	2022-03-28	\N	\N	\N	\N
2493	EVEN3	EVEN CONSTRUTORA E INCORPORADORA S.A.	43470988000165	1	2022-03-28	\N	\N	\N	\N
2494	EVEN3F	EVEN CONSTRUTORA E INCORPORADORA S.A.	43470988000165	1	2022-03-28	\N	\N	\N	\N
2495	EZTC3	EZ TEC EMPREEND. E PARTICIPACOES S.A.	08312229000173	1	2022-03-28	\N	\N	\N	\N
2496	EZTC3F	EZ TEC EMPREEND. E PARTICIPACOES S.A.	08312229000173	1	2022-03-28	\N	\N	\N	\N
2497	FESA3	CIA FERRO LIGAS DA BAHIA - FERBASA	15141799000103	1	2022-03-28	\N	\N	\N	\N
2498	FESA3F	CIA FERRO LIGAS DA BAHIA - FERBASA	15141799000103	1	2022-03-28	\N	\N	\N	\N
2499	FESA4	CIA FERRO LIGAS DA BAHIA - FERBASA	15141799000103	1	2022-03-28	\N	\N	\N	\N
2500	FESA4F	CIA FERRO LIGAS DA BAHIA - FERBASA	15141799000103	1	2022-03-28	\N	\N	\N	\N
2501	FHER3	FERTILIZANTES HERINGER S.A.	22266175000188	1	2022-03-28	\N	\N	\N	\N
2502	FHER3F	FERTILIZANTES HERINGER S.A.	22266175000188	1	2022-03-28	\N	\N	\N	\N
2503	FIGE3	INVESTIMENTOS BEMGE S.A.	01548981000179	1	2022-03-28	\N	\N	\N	\N
2504	FIGE3F	INVESTIMENTOS BEMGE S.A.	01548981000179	1	2022-03-28	\N	\N	\N	\N
2505	FIGE4	INVESTIMENTOS BEMGE S.A.	01548981000179	1	2022-03-28	\N	\N	\N	\N
2506	FIGE4F	INVESTIMENTOS BEMGE S.A.	01548981000179	1	2022-03-28	\N	\N	\N	\N
2507	FIQE3	UNIFIQUE TELECOMUNICAÇĠES S.A.	02255187000108	1	2022-03-28	\N	\N	\N	\N
2508	FIQE3F	UNIFIQUE TELECOMUNICAÇĠES S.A.	02255187000108	1	2022-03-28	\N	\N	\N	\N
2509	FLEX3	FLEX GESTO DE RELACIONAMENTOS S.A.	10851805000100	1	2022-03-28	\N	\N	\N	\N
2510	FLEX3F	FLEX GESTO DE RELACIONAMENTOS S.A.	10851805000100	1	2022-03-28	\N	\N	\N	\N
2511	FLRY3	FLEURY S.A.	60840055000131	1	2022-03-28	\N	\N	\N	\N
2512	FLRY3F	FLEURY S.A.	60840055000131	1	2022-03-28	\N	\N	\N	\N
2513	FNCN3	FINANSINOS S.A.- CREDITO FINANC E INVEST	91669747000192	1	2022-03-28	\N	\N	\N	\N
2514	FNCN3F	FINANSINOS S.A.- CREDITO FINANC E INVEST	91669747000192	1	2022-03-28	\N	\N	\N	\N
2515	FRAS3	FRAS-LE S.A.	88610126000129	1	2022-03-28	\N	\N	\N	\N
2516	FRAS3F	FRAS-LE S.A.	88610126000129	1	2022-03-28	\N	\N	\N	\N
2517	FRIO3	METALFRIO SOLUTIONS S.A.	04821041000108	1	2022-03-28	\N	\N	\N	\N
2518	FRIO3F	METALFRIO SOLUTIONS S.A.	04821041000108	1	2022-03-28	\N	\N	\N	\N
2519	FRRN3B	RUMO MALHA NORTE S.A.	24962466000136	1	2022-03-28	\N	\N	\N	\N
2520	FRRN3BF	RUMO MALHA NORTE S.A.	24962466000136	1	2022-03-28	\N	\N	\N	\N
2521	FRRN5B	RUMO MALHA NORTE S.A.	24962466000136	1	2022-03-28	\N	\N	\N	\N
2522	FRRN5BF	RUMO MALHA NORTE S.A.	24962466000136	1	2022-03-28	\N	\N	\N	\N
2523	FRRN6B	RUMO MALHA NORTE S.A.	24962466000136	1	2022-03-28	\N	\N	\N	\N
2524	FRRN6BF	RUMO MALHA NORTE S.A.	24962466000136	1	2022-03-28	\N	\N	\N	\N
2525	FRTA3	POMIFRUTAS S/A	86550951000150	1	2022-03-28	\N	\N	\N	\N
2526	FRTA3F	POMIFRUTAS S/A	86550951000150	1	2022-03-28	\N	\N	\N	\N
2527	GEPA3	RIO PARANAPANEMA ENERGIA S.A.	02998301000181	1	2022-03-28	\N	\N	\N	\N
2528	GEPA3F	RIO PARANAPANEMA ENERGIA S.A.	02998301000181	1	2022-03-28	\N	\N	\N	\N
2529	GEPA4	RIO PARANAPANEMA ENERGIA S.A.	02998301000181	1	2022-03-28	\N	\N	\N	\N
2530	GEPA4F	RIO PARANAPANEMA ENERGIA S.A.	02998301000181	1	2022-03-28	\N	\N	\N	\N
2531	GETT3	GETNET ADQUIRENCIA E SERV PARA MEIOS DE PGTO S.A.	10440482000154	1	2022-03-28	\N	\N	\N	\N
2532	GETT3F	GETNET ADQUIRENCIA E SERV PARA MEIOS DE PGTO S.A.	10440482000154	1	2022-03-28	\N	\N	\N	\N
2533	GETT4	GETNET ADQUIRENCIA E SERV PARA MEIOS DE PGTO S.A.	10440482000154	1	2022-03-28	\N	\N	\N	\N
2534	GETT4F	GETNET ADQUIRENCIA E SERV PARA MEIOS DE PGTO S.A.	10440482000154	1	2022-03-28	\N	\N	\N	\N
2535	GFSA3	GAFISA S.A.	01545826000107	1	2022-03-28	\N	\N	\N	\N
2536	GFSA3F	GAFISA S.A.	01545826000107	1	2022-03-28	\N	\N	\N	\N
2537	GGBR3	GERDAU S.A.	33611500000119	1	2022-03-28	\N	\N	\N	\N
2538	GGBR3F	GERDAU S.A.	33611500000119	1	2022-03-28	\N	\N	\N	\N
2539	GGBR4	GERDAU S.A.	33611500000119	1	2022-03-28	\N	\N	\N	\N
2540	GGBR4F	GERDAU S.A.	33611500000119	1	2022-03-28	\N	\N	\N	\N
2541	GGPS3	GPS PARTICIPACOES E EMPREENDIMENTOS S.A.	09229201000130	1	2022-03-28	\N	\N	\N	\N
2542	GGPS3F	GPS PARTICIPACOES E EMPREENDIMENTOS S.A.	09229201000130	1	2022-03-28	\N	\N	\N	\N
2543	GMAT3	GRUPO MATEUS S.A.	24990777000109	1	2022-03-28	\N	\N	\N	\N
2544	GMAT3F	GRUPO MATEUS S.A.	24990777000109	1	2022-03-28	\N	\N	\N	\N
2545	GOAU3	METALURGICA GERDAU S.A.	92690783000109	1	2022-03-28	\N	\N	\N	\N
2546	GOAU3F	METALURGICA GERDAU S.A.	92690783000109	1	2022-03-28	\N	\N	\N	\N
2547	GOAU4	METALURGICA GERDAU S.A.	92690783000109	1	2022-03-28	\N	\N	\N	\N
2548	GOAU4F	METALURGICA GERDAU S.A.	92690783000109	1	2022-03-28	\N	\N	\N	\N
2549	GOLL3	GOL LINHAS AEREAS INTELIGENTES S.A.	06164253000187	1	2022-03-28	\N	\N	\N	\N
2550	GOLL3F	GOL LINHAS AEREAS INTELIGENTES S.A.	06164253000187	1	2022-03-28	\N	\N	\N	\N
2551	GOLL4	GOL LINHAS AEREAS INTELIGENTES S.A.	06164253000187	1	2022-03-28	\N	\N	\N	\N
2552	GOLL4F	GOL LINHAS AEREAS INTELIGENTES S.A.	06164253000187	1	2022-03-28	\N	\N	\N	\N
2553	GPAR3	CIA CELG DE PARTICIPACOES - CELGPAR	08560444000193	1	2022-03-28	\N	\N	\N	\N
2554	GPAR3F	CIA CELG DE PARTICIPACOES - CELGPAR	08560444000193	1	2022-03-28	\N	\N	\N	\N
2555	GRAO3	HUMBERG AGRIBRASIL COM. E EXPORT. DE GROS S.A.	18483666000103	1	2022-03-28	\N	\N	\N	\N
2556	GRAO3F	HUMBERG AGRIBRASIL COM. E EXPORT. DE GROS S.A.	18483666000103	1	2022-03-28	\N	\N	\N	\N
2557	GRND3	GRENDENE S.A.	89850341000160	1	2022-03-28	\N	\N	\N	\N
2558	GRND3F	GRENDENE S.A.	89850341000160	1	2022-03-28	\N	\N	\N	\N
2559	GSHP3	GENERAL SHOPPING E OUTLETS DO BRASIL S.A.	08764621000153	1	2022-03-28	\N	\N	\N	\N
2560	GSHP3F	GENERAL SHOPPING E OUTLETS DO BRASIL S.A.	08764621000153	1	2022-03-28	\N	\N	\N	\N
2561	GUAR3	GUARARAPES CONFECCOES S.A.	08402943000152	1	2022-03-28	\N	\N	\N	\N
2562	GUAR3F	GUARARAPES CONFECCOES S.A.	08402943000152	1	2022-03-28	\N	\N	\N	\N
2563	HAGA3	HAGA S.A. INDUSTRIA E COMERCIO	30540991000166	1	2022-03-28	\N	\N	\N	\N
2564	HAGA3F	HAGA S.A. INDUSTRIA E COMERCIO	30540991000166	1	2022-03-28	\N	\N	\N	\N
2565	HAGA4	HAGA S.A. INDUSTRIA E COMERCIO	30540991000166	1	2022-03-28	\N	\N	\N	\N
2566	HAGA4F	HAGA S.A. INDUSTRIA E COMERCIO	30540991000166	1	2022-03-28	\N	\N	\N	\N
2567	HAPV3	HAPVIDA PARTICIPACOES E INVESTIMENTOS SA	05197443000138	1	2022-03-28	\N	\N	\N	\N
2568	HAPV3F	HAPVIDA PARTICIPACOES E INVESTIMENTOS SA	05197443000138	1	2022-03-28	\N	\N	\N	\N
2569	HBOR3	HELBOR EMPREENDIMENTOS S.A.	49263189000102	1	2022-03-28	\N	\N	\N	\N
2570	HBOR3F	HELBOR EMPREENDIMENTOS S.A.	49263189000102	1	2022-03-28	\N	\N	\N	\N
2571	HBRE3	HBR REALTY EMPREENDIMENTOS IMOBILIARIOS S/A	14785152000151	1	2022-03-28	\N	\N	\N	\N
2572	HBRE3F	HBR REALTY EMPREENDIMENTOS IMOBILIARIOS S/A	14785152000151	1	2022-03-28	\N	\N	\N	\N
2573	HBSA3	HIDROVIAS DO BRASIL S.A.	12648327000153	1	2022-03-28	\N	\N	\N	\N
2574	HBSA3F	HIDROVIAS DO BRASIL S.A.	12648327000153	1	2022-03-28	\N	\N	\N	\N
2575	HBTS3	CIA HABITASUL DE PARTICIPACOES	87762563000103	1	2022-03-28	\N	\N	\N	\N
2576	HBTS3F	CIA HABITASUL DE PARTICIPACOES	87762563000103	1	2022-03-28	\N	\N	\N	\N
2577	HBTS5	CIA HABITASUL DE PARTICIPACOES	87762563000103	1	2022-03-28	\N	\N	\N	\N
2578	HBTS5F	CIA HABITASUL DE PARTICIPACOES	87762563000103	1	2022-03-28	\N	\N	\N	\N
2579	HBTS6	CIA HABITASUL DE PARTICIPACOES	87762563000103	1	2022-03-28	\N	\N	\N	\N
2580	HBTS6F	CIA HABITASUL DE PARTICIPACOES	87762563000103	1	2022-03-28	\N	\N	\N	\N
2581	HETA3	HERCULES S.A. FABRICA DE TALHERES	92749225000163	1	2022-03-28	\N	\N	\N	\N
2582	HETA3F	HERCULES S.A. FABRICA DE TALHERES	92749225000163	1	2022-03-28	\N	\N	\N	\N
2583	HETA4	HERCULES S.A. FABRICA DE TALHERES	92749225000163	1	2022-03-28	\N	\N	\N	\N
2584	HETA4F	HERCULES S.A. FABRICA DE TALHERES	92749225000163	1	2022-03-28	\N	\N	\N	\N
2585	HMOB3	HMOBI PARTICIPAÇĠES S.A.	40159947000164	1	2022-03-28	\N	\N	\N	\N
2586	HMOB3F	HMOBI PARTICIPAÇĠES S.A.	40159947000164	1	2022-03-28	\N	\N	\N	\N
2587	HOOT3	HOTEIS OTHON S.A.	33200049000147	1	2022-03-28	\N	\N	\N	\N
2588	HOOT3F	HOTEIS OTHON S.A.	33200049000147	1	2022-03-28	\N	\N	\N	\N
2589	HOOT4	HOTEIS OTHON S.A.	33200049000147	1	2022-03-28	\N	\N	\N	\N
2590	HOOT4F	HOTEIS OTHON S.A.	33200049000147	1	2022-03-28	\N	\N	\N	\N
2591	HYPE3	HYPERA S.A.	02932074000191	1	2022-03-28	\N	\N	\N	\N
2592	HYPE3F	HYPERA S.A.	02932074000191	1	2022-03-28	\N	\N	\N	\N
2593	IFCM3	Infracommerce CXAAS S.A.	38456921000136	1	2022-03-28	\N	\N	\N	\N
2594	IFCM3F	INFRACOMMERCE CXAAS S.A.	38456921000136	1	2022-03-28	\N	\N	\N	\N
2595	IGBR3	IGB ELETRÔNICA S/A	43185362000107	1	2022-03-28	\N	\N	\N	\N
2596	IGBR3F	IGB ELETRÔNICA S/A	43185362000107	1	2022-03-28	\N	\N	\N	\N
2597	IGSN3	IGUA SANEAMENTO S.A.	08159965000133	1	2022-03-28	\N	\N	\N	\N
2598	IGSN3F	IGUA SANEAMENTO S.A.	08159965000133	1	2022-03-28	\N	\N	\N	\N
2599	IGTI3	IGUATEMI S.A.	60543816000193	1	2022-03-28	\N	\N	\N	\N
2600	IGTI3F	IGUATEMI S.A.	60543816000193	1	2022-03-28	\N	\N	\N	\N
2601	IGTI4	IGUATEMI S.A.	60543816000193	1	2022-03-28	\N	\N	\N	\N
2602	INEP3	INEPAR S.A. INDUSTRIA E CONSTRUCOES	76627504000106	1	2022-03-28	\N	\N	\N	\N
2603	INEP3F	INEPAR S.A. INDUSTRIA E CONSTRUCOES	76627504000106	1	2022-03-28	\N	\N	\N	\N
2604	INEP4	INEPAR S.A. INDUSTRIA E CONSTRUCOES	76627504000106	1	2022-03-28	\N	\N	\N	\N
2605	INEP4F	INEPAR S.A. INDUSTRIA E CONSTRUCOES	76627504000106	1	2022-03-28	\N	\N	\N	\N
2606	INNT3	INTER CONSTRUTORA E INCORPORADORA S.A.	09611768000176	1	2022-03-28	\N	\N	\N	\N
2607	INNT3F	INTER CONSTRUTORA E INCORPORADORA S.A.	09611768000176	1	2022-03-28	\N	\N	\N	\N
2608	IRBR3	IRB - BRASIL RESSEGUROS S.A.	33376989000191	1	2022-03-28	\N	\N	\N	\N
2609	IRBR3F	IRB - BRASIL RESSEGUROS S.A.	33376989000191	1	2022-03-28	\N	\N	\N	\N
2610	ITSA3	ITAUSA S.A.	61532644000115	1	2022-03-28	\N	\N	\N	\N
2611	ITSA3F	ITAUSA S.A.	61532644000115	1	2022-03-28	\N	\N	\N	\N
2612	ITSA4	ITAUSA S.A.	61532644000115	1	2022-03-28	\N	\N	\N	\N
2613	ITSA4F	ITAUSA S.A.	61532644000115	1	2022-03-28	\N	\N	\N	\N
2614	ITUB3	ITAU UNIBANCO HOLDING S.A.	60872504000123	1	2022-03-28	\N	\N	\N	\N
2615	ITUB3F	ITAU UNIBANCO HOLDING S.A.	60872504000123	1	2022-03-28	\N	\N	\N	\N
2616	ITUB4	ITAU UNIBANCO HOLDING S.A.	60872504000123	1	2022-03-28	\N	\N	\N	\N
2617	ITUB4F	ITAU UNIBANCO HOLDING S.A.	60872504000123	1	2022-03-28	\N	\N	\N	\N
2618	IVPR3B	INVESTIMENTOS E PARTICIP. EM INFRA S.A. - INVEPAR	03758318000124	1	2022-03-28	\N	\N	\N	\N
2619	IVPR3BF	INVESTIMENTOS E PARTICIP. EM INFRA S.A. - INVEPAR	03758318000124	1	2022-03-28	\N	\N	\N	\N
2620	IVPR4B	INVESTIMENTOS E PARTICIP. EM INFRA S.A. - INVEPAR	03758318000124	1	2022-03-28	\N	\N	\N	\N
2621	IVPR4BF	INVESTIMENTOS E PARTICIP. EM INFRA S.A. - INVEPAR	03758318000124	1	2022-03-28	\N	\N	\N	\N
2622	JALL3	JALLES MACHADO S.A.	02635522000195	1	2022-03-28	\N	\N	\N	\N
2623	JALL3F	JALLES MACHADO S.A.	02635522000195	1	2022-03-28	\N	\N	\N	\N
2624	JBSS3	JBS S.A.	02916265000160	1	2022-03-28	\N	\N	\N	\N
2625	JBSS3F	JBS S.A.	02916265000160	1	2022-03-28	\N	\N	\N	\N
2626	JHSF3	JHSF PARTICIPACOES S.A.	08294224000165	1	2022-03-28	\N	\N	\N	\N
2627	JHSF3F	JHSF PARTICIPACOES S.A.	08294224000165	1	2022-03-28	\N	\N	\N	\N
2628	JOPA3	JOSAPAR-JOAQUIM OLIVEIRA S.A. - PARTICIP	87456562000122	1	2022-03-28	\N	\N	\N	\N
2629	JOPA3F	JOSAPAR-JOAQUIM OLIVEIRA S.A. - PARTICIP	87456562000122	1	2022-03-28	\N	\N	\N	\N
2630	JOPA4	JOSAPAR-JOAQUIM OLIVEIRA S.A. - PARTICIP	87456562000122	1	2022-03-28	\N	\N	\N	\N
2631	JOPA4F	JOSAPAR-JOAQUIM OLIVEIRA S.A. - PARTICIP	87456562000122	1	2022-03-28	\N	\N	\N	\N
2632	JSLG3	JSL S.A.	52548435000179	1	2022-03-28	\N	\N	\N	\N
2633	JSLG3F	JSL S.A.	52548435000179	1	2022-03-28	\N	\N	\N	\N
2634	KEPL3	KEPLER WEBER S.A.	91983056000169	1	2022-03-28	\N	\N	\N	\N
2635	KEPL3F	KEPLER WEBER S.A.	91983056000169	1	2022-03-28	\N	\N	\N	\N
2636	KLAS3	KALLAS INCORPORACOES E CONSTRUCOES S.A.	09146451000106	1	2022-03-28	\N	\N	\N	\N
2637	KLAS3F	KALLAS INCORPORACOES E CONSTRUCOES S.A.	09146451000106	1	2022-03-28	\N	\N	\N	\N
2638	KLBN3	KLABIN S.A.	89637490000145	1	2022-03-28	\N	\N	\N	\N
2639	KLBN3F	KLABIN S.A.	89637490000145	1	2022-03-28	\N	\N	\N	\N
2640	KLBN4	KLABIN S.A.	89637490000145	1	2022-03-28	\N	\N	\N	\N
2641	KLBN4F	KLABIN S.A.	89637490000145	1	2022-03-28	\N	\N	\N	\N
2642	KRSA3	KORA SAÚDE PARTICIPAÇĠES S.A	13270520000166	1	2022-03-28	\N	\N	\N	\N
2643	KRSA3F	KORA SAÚDE PARTICIPAÇĠES S.A	13270520000166	1	2022-03-28	\N	\N	\N	\N
2644	LAND3	Terra Santa Propriedades Agricolas S.A.	40337136000106	1	2022-03-28	\N	\N	\N	\N
2645	LAND3F	Terra Santa Propriedades Agricolas S.A.	40337136000106	1	2022-03-28	\N	\N	\N	\N
2646	LAVV3	LAVVI EMPREENDIMENTOS IMOBILIÁRIOS S.A.	26462693000128	1	2022-03-28	\N	\N	\N	\N
2647	LAVV3F	LAVVI EMPREENDIMENTOS IMOBILIÁRIOS S.A.	26462693000128	1	2022-03-28	\N	\N	\N	\N
2648	LCAM3	CIA LOCAÇO DAS AMÉRICAS	10215988000160	1	2022-03-28	\N	\N	\N	\N
2649	LCAM3F	CIA LOCAÇO DAS AMÉRICAS	10215988000160	1	2022-03-28	\N	\N	\N	\N
2650	LEVE3	MAHLE-METAL LEVE S.A.	60476884000187	1	2022-03-28	\N	\N	\N	\N
2651	LEVE3F	MAHLE-METAL LEVE S.A.	60476884000187	1	2022-03-28	\N	\N	\N	\N
2652	LIGT3	LIGHT S.A.	03378521000175	1	2022-03-28	\N	\N	\N	\N
2653	LIGT3F	LIGHT S.A.	03378521000175	1	2022-03-28	\N	\N	\N	\N
2654	LIPR3	ELETROBRÁS PARTICIPAÇĠES S.A. - ELETROPAR	01104937000170	1	2022-03-28	\N	\N	\N	\N
2655	LIPR3F	ELETROBRÁS PARTICIPAÇĠES S.A. - ELETROPAR	01104937000170	1	2022-03-28	\N	\N	\N	\N
2656	LJQQ3	LOJAS QUERO-QUERO S/A	96418264021802	1	2022-03-28	\N	\N	\N	\N
2657	LJQQ3F	LOJAS QUERO-QUERO S/A	96418264021802	1	2022-03-28	\N	\N	\N	\N
2658	LLBI3	LOJAS LE BISCUIT S.A.	16233389000155	1	2022-03-28	\N	\N	\N	\N
2659	LLBI3F	LOJAS LE BISCUIT S.A.	16233389000155	1	2022-03-28	\N	\N	\N	\N
2660	LLBI4	LOJAS LE BISCUIT S.A.	16233389000155	1	2022-03-28	\N	\N	\N	\N
2661	LLBI4F	LOJAS LE BISCUIT S.A.	16233389000155	1	2022-03-28	\N	\N	\N	\N
2662	LLIS3	RESTOQUE COMÉRCIO E CONFECÇĠES DE ROUPAS S.A.	49669856000143	1	2022-03-28	\N	\N	\N	\N
2663	LLIS3F	RESTOQUE COMÉRCIO E CONFECÇĠES DE ROUPAS S.A.	49669856000143	1	2022-03-28	\N	\N	\N	\N
2664	LMED3	LIFEMED INDUSTRIAL EQUIP. DE ART. MÉD. HOSP. S.A.	02357251000153	1	2022-03-28	\N	\N	\N	\N
2665	LMED3F	LIFEMED INDUSTRIAL EQUIP. DE ART. MÉD. HOSP. S.A.	02357251000153	1	2022-03-28	\N	\N	\N	\N
2666	LOGG3	LOG COMMERCIAL PROPERTIES	09041168000110	1	2022-03-28	\N	\N	\N	\N
2667	LOGG3F	LOG COMMERCIAL PROPERTIES	09041168000110	1	2022-03-28	\N	\N	\N	\N
2668	LOGN3	LOG-IN LOGISTICA INTERMODAL S.A.	42278291000124	1	2022-03-28	\N	\N	\N	\N
2669	LOGN3F	LOG-IN LOGISTICA INTERMODAL S.A.	42278291000124	1	2022-03-28	\N	\N	\N	\N
2670	LPSB3	LPS BRASIL - CONSULTORIA DE IMOVEIS S.A.	08078847000109	1	2022-03-28	\N	\N	\N	\N
2671	LPSB3F	LPS BRASIL - CONSULTORIA DE IMOVEIS S.A.	08078847000109	1	2022-03-28	\N	\N	\N	\N
2672	LREN3	LOJAS RENNER S.A.	92754738000162	1	2022-03-28	\N	\N	\N	\N
2673	LREN3F	LOJAS RENNER S.A.	92754738000162	1	2022-03-28	\N	\N	\N	\N
2674	LTEL3B	LITEL PARTICIPACOES S.A.	00743065000127	1	2022-03-28	\N	\N	\N	\N
2675	LTEL3BF	LITEL PARTICIPACOES S.A.	00743065000127	1	2022-03-28	\N	\N	\N	\N
2676	LTLA3B	LITELA PARTICIPAÇĠES S.A.	05495546000184	1	2022-03-28	\N	\N	\N	\N
2677	LTLA3BF	LITELA PARTICIPAÇĠES S.A.	05495546000184	1	2022-03-28	\N	\N	\N	\N
2678	LUPA3	LUPATECH S.A.	89463822000112	1	2022-03-28	\N	\N	\N	\N
2679	LUPA3F	LUPATECH S.A.	89463822000112	1	2022-03-28	\N	\N	\N	\N
2680	LUXM3	TREVISA INVESTIMENTOS S.A.	92660570000126	1	2022-03-28	\N	\N	\N	\N
2681	LUXM3F	TREVISA INVESTIMENTOS S.A.	92660570000126	1	2022-03-28	\N	\N	\N	\N
2682	LUXM4	TREVISA INVESTIMENTOS S.A.	92660570000126	1	2022-03-28	\N	\N	\N	\N
2683	LUXM4F	TREVISA INVESTIMENTOS S.A.	92660570000126	1	2022-03-28	\N	\N	\N	\N
2684	LVTC3	LIVETECH DA BAHIA INDUSTRIA E COMERCIO S/A	05917486000140	1	2022-03-28	\N	\N	\N	\N
2685	LVTC3F	LIVETECH DA BAHIA INDUSTRIA E COMERCIO S/A	05917486000140	1	2022-03-28	\N	\N	\N	\N
2686	LWSA3	LOCAWEB SERVIÇOS DE INTERNET S.A.	02351877000152	1	2022-03-28	\N	\N	\N	\N
2687	LWSA3F	LOCAWEB SERVIÇOS DE INTERNET S.A.	02351877000152	1	2022-03-28	\N	\N	\N	\N
2688	MAPT3	CEMEPE INVESTIMENTOS S.A.	93828986000173	1	2022-03-28	\N	\N	\N	\N
2689	MAPT3F	CEMEPE INVESTIMENTOS S.A.	93828986000173	1	2022-03-28	\N	\N	\N	\N
2690	MAPT4	CEMEPE INVESTIMENTOS S.A.	93828986000173	1	2022-03-28	\N	\N	\N	\N
2691	MAPT4F	CEMEPE INVESTIMENTOS S.A.	93828986000173	1	2022-03-28	\N	\N	\N	\N
2692	MATD3	HOSPITAL MATER DEI S/A	16676520000159	1	2022-03-28	\N	\N	\N	\N
2693	MATD3F	HOSPITAL MATER DEI S/A	16676520000159	1	2022-03-28	\N	\N	\N	\N
2694	MBLY3	Mobly S.A.	31553627000101	1	2022-03-28	\N	\N	\N	\N
2695	MBLY3F	Mobly S.A.	31553627000101	1	2022-03-28	\N	\N	\N	\N
2696	MDIA3	M.DIAS BRANCO S.A. IND COM DE ALIMENTOS	07206816000115	1	2022-03-28	\N	\N	\N	\N
2697	MDIA3F	M.DIAS BRANCO S.A. IND COM DE ALIMENTOS	07206816000115	1	2022-03-28	\N	\N	\N	\N
2698	MDNE3	MOURA DUBEUX ENGENHARIA S/A	12049631000184	1	2022-03-28	\N	\N	\N	\N
2699	MDNE3F	MOURA DUBEUX ENGENHARIA S/A	12049631000184	1	2022-03-28	\N	\N	\N	\N
2700	MEAL3	INTERNATIONAL MEAL COMPANY ALIMENTACAO S.A.	17314329000120	1	2022-03-28	\N	\N	\N	\N
2701	MEAL3F	INTERNATIONAL MEAL COMPANY ALIMENTACAO S.A.	17314329000120	1	2022-03-28	\N	\N	\N	\N
2702	MEGA3	OMEGA ENERGIA S.A.	42500384000151	1	2022-03-28	\N	\N	\N	\N
2703	MEGA3F	OMEGA ENERGIA S.A.	42500384000151	1	2022-03-28	\N	\N	\N	\N
2704	MELK3	MELNICK DESENVOLVIMENTO IMOBILIÁRIO S.A.	12181987000177	1	2022-03-28	\N	\N	\N	\N
2705	MELK3F	MELNICK DESENVOLVIMENTO IMOBILIÁRIO S.A.	12181987000177	1	2022-03-28	\N	\N	\N	\N
2706	MERC3	MERCANTIL BRASIL FINANC S.A. C.F.I.	33040601000187	1	2022-03-28	\N	\N	\N	\N
2707	MERC3F	MERCANTIL BRASIL FINANC S.A. C.F.I.	33040601000187	1	2022-03-28	\N	\N	\N	\N
2708	MERC4	MERCANTIL BRASIL FINANC S.A. C.F.I.	33040601000187	1	2022-03-28	\N	\N	\N	\N
2709	MERC4F	MERCANTIL BRASIL FINANC S.A. C.F.I.	33040601000187	1	2022-03-28	\N	\N	\N	\N
2710	MGEL3	MANGELS INDUSTRIAL S.A.	61065298000102	1	2022-03-28	\N	\N	\N	\N
2711	MGEL3F	MANGELS INDUSTRIAL S.A.	61065298000102	1	2022-03-28	\N	\N	\N	\N
2712	MGEL4	MANGELS INDUSTRIAL S.A.	61065298000102	1	2022-03-28	\N	\N	\N	\N
2713	MGEL4F	MANGELS INDUSTRIAL S.A.	61065298000102	1	2022-03-28	\N	\N	\N	\N
2714	MGLU3	MAGAZINE LUIZA S.A.	47960950000121	1	2022-03-28	\N	\N	\N	\N
2715	MGLU3F	MAGAZINE LUIZA S.A.	47960950000121	1	2022-03-28	\N	\N	\N	\N
2716	MILS3	MILLS ESTRUTURAS E SERVIÇOS DE ENGENHARIA S.A.	27093558000115	1	2022-03-28	\N	\N	\N	\N
2717	MILS3F	MILLS ESTRUTURAS E SERVIÇOS DE ENGENHARIA S.A.	27093558000115	1	2022-03-28	\N	\N	\N	\N
2718	MLAS3	MULTILASER INDUSTRIAL S.A.	59717553000102	1	2022-03-28	\N	\N	\N	\N
2719	MLAS3F	MULTILASER INDUSTRIAL S.A.	59717553000102	1	2022-03-28	\N	\N	\N	\N
2720	MMAQ3	MINASMAQUINAS S.A.	17161241000115	1	2022-03-28	\N	\N	\N	\N
2721	MMAQ3F	MINASMAQUINAS S.A.	17161241000115	1	2022-03-28	\N	\N	\N	\N
2722	MMAQ4	MINASMAQUINAS S.A.	17161241000115	1	2022-03-28	\N	\N	\N	\N
2723	MMAQ4F	MINASMAQUINAS S.A.	17161241000115	1	2022-03-28	\N	\N	\N	\N
2724	MMXM11	MMX MINERACAO E METALICOS S.A.	02762115000149	1	2022-03-28	\N	\N	\N	\N
2725	MMXM11F	MMX MINERACAO E METALICOS S.A.	02762115000149	1	2022-03-28	\N	\N	\N	\N
2726	MMXM3	MMX MINERACAO E METALICOS S.A.	02762115000149	1	2022-03-28	\N	\N	\N	\N
2727	MMXM3F	MMX MINERACAO E METALICOS S.A.	02762115000149	1	2022-03-28	\N	\N	\N	\N
2728	MNDL3	MUNDIAL S.A. - PRODUTOS DE CONSUMO	88610191000154	1	2022-03-28	\N	\N	\N	\N
2729	MNDL3F	MUNDIAL S.A. - PRODUTOS DE CONSUMO	88610191000154	1	2022-03-28	\N	\N	\N	\N
2730	MNPR3	MINUPAR PARTICIPACOES S.A.	90076886000140	1	2022-03-28	\N	\N	\N	\N
2731	MNPR3F	MINUPAR PARTICIPACOES S.A.	90076886000140	1	2022-03-28	\N	\N	\N	\N
2732	MNZC3B	TERMINAL GARAGEM MENEZES CORTES S.A.	02664042000152	1	2022-03-28	\N	\N	\N	\N
2733	MNZC3BF	TERMINAL GARAGEM MENEZES CORTES S.A.	02664042000152	1	2022-03-28	\N	\N	\N	\N
2734	MOAR3	MONTEIRO ARANHA S.A.	33102476000192	1	2022-03-28	\N	\N	\N	\N
2735	MOAR3F	MONTEIRO ARANHA S.A.	33102476000192	1	2022-03-28	\N	\N	\N	\N
2736	MODL3	BANCO MODAL S.A	30723886000162	1	2022-03-28	\N	\N	\N	\N
2737	MODL3F	BANCO MODAL S.A	30723886000162	1	2022-03-28	\N	\N	\N	\N
2738	MODL4	BANCO MODAL S.A	30723886000162	1	2022-03-28	\N	\N	\N	\N
2739	MODL4F	BANCO MODAL S.A	30723886000162	1	2022-03-28	\N	\N	\N	\N
2740	MOVI3	MOVIDA PARTICIPACOES SA	21314559000166	1	2022-03-28	\N	\N	\N	\N
2741	MOVI3F	MOVIDA PARTICIPACOES SA	21314559000166	1	2022-03-28	\N	\N	\N	\N
2742	MRFG3	MARFRIG GLOBAL FOODS S.A.	03853896000140	1	2022-03-28	\N	\N	\N	\N
2743	MRFG3F	MARFRIG GLOBAL FOODS S.A.	03853896000140	1	2022-03-28	\N	\N	\N	\N
2744	MRSA3B	MRS LOGISTICA S.A.	01417222000177	1	2022-03-28	\N	\N	\N	\N
2745	MRSA3BF	MRS LOGISTICA S.A.	01417222000177	1	2022-03-28	\N	\N	\N	\N
2746	MRSA5B	MRS LOGISTICA S.A.	01417222000177	1	2022-03-28	\N	\N	\N	\N
2747	MRSA5BF	MRS LOGISTICA S.A.	01417222000177	1	2022-03-28	\N	\N	\N	\N
2748	MRSA6B	MRS LOGISTICA S.A.	01417222000177	1	2022-03-28	\N	\N	\N	\N
2749	MRSA6BF	MRS LOGISTICA S.A.	01417222000177	1	2022-03-28	\N	\N	\N	\N
2750	MRVE3	MRV ENGENHARIA E PARTICIPACOES S.A.	08343492000120	1	2022-03-28	\N	\N	\N	\N
2751	MRVE3F	MRV ENGENHARIA E PARTICIPACOES S.A.	08343492000120	1	2022-03-28	\N	\N	\N	\N
2752	MSPA3	CIA MELHORAMENTOS DE SAO PAULO	60730348000166	1	2022-03-28	\N	\N	\N	\N
2753	MSPA3F	CIA MELHORAMENTOS DE SAO PAULO	60730348000166	1	2022-03-28	\N	\N	\N	\N
2754	MSPA4	CIA MELHORAMENTOS DE SAO PAULO	60730348000166	1	2022-03-28	\N	\N	\N	\N
2755	MSPA4F	CIA MELHORAMENTOS DE SAO PAULO	60730348000166	1	2022-03-28	\N	\N	\N	\N
2756	MSRO3	MAESTRO LOCADORA DE VEICULOS S.A.	08795211000170	1	2022-03-28	\N	\N	\N	\N
2757	MSRO3F	MAESTRO LOCADORA DE VEICULOS S.A.	08795211000170	1	2022-03-28	\N	\N	\N	\N
2758	MTIG3	METALGRAFICA IGUACU S.A.	80227184000166	1	2022-03-28	\N	\N	\N	\N
2759	MTIG3F	METALGRAFICA IGUACU S.A.	80227184000166	1	2022-03-28	\N	\N	\N	\N
2760	MTIG4	METALGRAFICA IGUACU S.A.	80227184000166	1	2022-03-28	\N	\N	\N	\N
2761	MTIG4F	METALGRAFICA IGUACU S.A.	80227184000166	1	2022-03-28	\N	\N	\N	\N
2762	MTRE3	MITRE REALTY EMPREENDIMENTOS E PARTICIPAÇĠES S.A.	07882930000165	1	2022-03-28	\N	\N	\N	\N
2763	MTRE3F	MITRE REALTY EMPREENDIMENTOS E PARTICIPAÇĠES S.A.	07882930000165	1	2022-03-28	\N	\N	\N	\N
2764	MTSA3	METISA METALURGICA TIMBOENSE S.A.	86375425000109	1	2022-03-28	\N	\N	\N	\N
2765	MTSA3F	METISA METALURGICA TIMBOENSE S.A.	86375425000109	1	2022-03-28	\N	\N	\N	\N
2766	MTSA4	METISA METALURGICA TIMBOENSE S.A.	86375425000109	1	2022-03-28	\N	\N	\N	\N
2767	MTSA4F	METISA METALURGICA TIMBOENSE S.A.	86375425000109	1	2022-03-28	\N	\N	\N	\N
2768	MULT3	MULTIPLAN - EMPREEND IMOBILIARIOS S.A.	07816890000153	1	2022-03-28	\N	\N	\N	\N
2769	MULT3F	MULTIPLAN - EMPREEND IMOBILIARIOS S.A.	07816890000153	1	2022-03-28	\N	\N	\N	\N
2770	MWET3	WETZEL S.A.	84683671000194	1	2022-03-28	\N	\N	\N	\N
2771	MWET3F	WETZEL S.A.	84683671000194	1	2022-03-28	\N	\N	\N	\N
2772	MWET4	WETZEL S.A.	84683671000194	1	2022-03-28	\N	\N	\N	\N
2773	MWET4F	WETZEL S.A.	84683671000194	1	2022-03-28	\N	\N	\N	\N
2774	MYPK3	IOCHPE MAXION S.A.	61156113000175	1	2022-03-28	\N	\N	\N	\N
2775	MYPK3F	IOCHPE MAXION S.A.	61156113000175	1	2022-03-28	\N	\N	\N	\N
2776	NEMO3	SUZANO HOLDING S.A.	60651809000105	1	2022-03-28	\N	\N	\N	\N
2777	NEMO3F	SUZANO HOLDING S.A.	60651809000105	1	2022-03-28	\N	\N	\N	\N
2778	NEMO5	SUZANO HOLDING S.A.	60651809000105	1	2022-03-28	\N	\N	\N	\N
2779	NEMO5F	SUZANO HOLDING S.A.	60651809000105	1	2022-03-28	\N	\N	\N	\N
2780	NEMO6	SUZANO HOLDING S.A.	60651809000105	1	2022-03-28	\N	\N	\N	\N
2781	NEMO6F	SUZANO HOLDING S.A.	60651809000105	1	2022-03-28	\N	\N	\N	\N
2782	NEOE3	NEOENERGIA S.A.	01083200000118	1	2022-03-28	\N	\N	\N	\N
2783	NEOE3F	NEOENERGIA S.A.	01083200000118	1	2022-03-28	\N	\N	\N	\N
2784	NGRD3	NEOGRID PARTICIPACOES S.A.	10139870000108	1	2022-03-28	\N	\N	\N	\N
2785	NGRD3F	NEOGRID PARTICIPACOES S.A.	10139870000108	1	2022-03-28	\N	\N	\N	\N
2786	NINJ3	GETNINJAS S.A.	14127813000151	1	2022-03-28	\N	\N	\N	\N
2787	NINJ3F	GETNINJAS S.A.	14127813000151	1	2022-03-28	\N	\N	\N	\N
2788	NORD3	NORDON INDUSTRIAS METALURGICAS S.A.	60884319000159	1	2022-03-28	\N	\N	\N	\N
2789	NORD3F	NORDON INDUSTRIAS METALURGICAS S.A.	60884319000159	1	2022-03-28	\N	\N	\N	\N
2790	NRTQ3	NORTEC QUÍMICA S.A.	29950060000157	1	2022-03-28	\N	\N	\N	\N
2791	NRTQ3F	NORTEC QUÍMICA S.A.	29950060000157	1	2022-03-28	\N	\N	\N	\N
2792	NTCO3	NATURA &CO HOLDING S.A.	32785497000197	1	2022-03-28	\N	\N	\N	\N
2793	NTCO3F	NATURA &CO HOLDING S.A.	32785497000197	1	2022-03-28	\N	\N	\N	\N
2794	NUTR3	NUTRIPLANT INDUSTRIA E COMERCIO S.A.	51128999000190	1	2022-03-28	\N	\N	\N	\N
2795	NUTR3F	NUTRIPLANT INDUSTRIA E COMERCIO S.A.	51128999000190	1	2022-03-28	\N	\N	\N	\N
2796	ODER3	CONSERVAS ODERICH S.A.	97191902000194	1	2022-03-28	\N	\N	\N	\N
2797	ODER3F	CONSERVAS ODERICH S.A.	97191902000194	1	2022-03-28	\N	\N	\N	\N
2798	ODER4	CONSERVAS ODERICH S.A.	97191902000194	1	2022-03-28	\N	\N	\N	\N
2799	ODER4F	CONSERVAS ODERICH S.A.	97191902000194	1	2022-03-28	\N	\N	\N	\N
2800	ODPV3	ODONTOPREV S.A.	58119199000151	1	2022-03-28	\N	\N	\N	\N
2801	ODPV3F	ODONTOPREV S.A.	58119199000151	1	2022-03-28	\N	\N	\N	\N
2802	OFSA3	OURO FINO SAUDE ANIMAL PARTICIPACOES S.A.	20258278000170	1	2022-03-28	\N	\N	\N	\N
2803	OFSA3F	OURO FINO SAUDE ANIMAL PARTICIPACOES S.A.	20258278000170	1	2022-03-28	\N	\N	\N	\N
2804	OIBR3	OI S.A.	76535764000143	1	2022-03-28	\N	\N	\N	\N
2805	OIBR3F	OI S.A.	76535764000143	1	2022-03-28	\N	\N	\N	\N
2806	OIBR4	OI S.A.	76535764000143	1	2022-03-28	\N	\N	\N	\N
2807	OIBR4F	OI S.A.	76535764000143	1	2022-03-28	\N	\N	\N	\N
2808	ONCO3	ONCOCLINICAS DO BRASIL SERVICOS MEDICOS  S.A.	12104241000402	1	2022-03-28	\N	\N	\N	\N
2809	ONCO3F	ONCOCLINICAS DO BRASIL SERVICOS MEDICOS  S.A.	12104241000402	1	2022-03-28	\N	\N	\N	\N
2810	OPCT3	OCEANPACT SERVICOS MARITIMOS S.A.	09114805000130	1	2022-03-28	\N	\N	\N	\N
2811	OPCT3F	OCEANPACT SERVICOS MARITIMOS S.A.	09114805000130	1	2022-03-28	\N	\N	\N	\N
2812	OPGM3B	GAMA PARTICIPACOES S.A.	02796775000140	1	2022-03-28	\N	\N	\N	\N
2813	OPGM3BF	GAMA PARTICIPACOES S.A.	02796775000140	1	2022-03-28	\N	\N	\N	\N
2814	OPSE3B	SUDESTE S.A.	02062747000108	1	2022-03-28	\N	\N	\N	\N
2815	OPSE3BF	SUDESTE S.A.	02062747000108	1	2022-03-28	\N	\N	\N	\N
2816	OPTS3B	SUL 116 PARTICIPACOES S.A.	01957772000189	1	2022-03-28	\N	\N	\N	\N
2817	OPTS3BF	SUL 116 PARTICIPACOES S.A.	01957772000189	1	2022-03-28	\N	\N	\N	\N
2818	ORVR3	ORIZON VALORIZACAO DE RESIDUOS S.A.	11421994000136	1	2022-03-28	\N	\N	\N	\N
2819	ORVR3F	ORIZON VALORIZACAO DE RESIDUOS S.A.	11421994000136	1	2022-03-28	\N	\N	\N	\N
2820	OSXB3	OSX BRASIL S.A.	09112685000132	1	2022-03-28	\N	\N	\N	\N
2821	OSXB3F	OSX BRASIL S.A.	09112685000132	1	2022-03-28	\N	\N	\N	\N
2822	PARD3	INSTITUTO HERMES PARDINI S.A.	19378769000176	1	2022-03-28	\N	\N	\N	\N
2823	PARD3F	INSTITUTO HERMES PARDINI S.A.	19378769000176	1	2022-03-28	\N	\N	\N	\N
2824	PASS3	COMPASS GAS E ENERGIA S.A.	21389501000181	1	2022-03-28	\N	\N	\N	\N
2825	PASS3F	COMPASS GAS E ENERGIA S.A.	21389501000181	1	2022-03-28	\N	\N	\N	\N
2826	PASS5	COMPASS GAS E ENERGIA S.A.	21389501000181	1	2022-03-28	\N	\N	\N	\N
2827	PASS5F	COMPASS GAS E ENERGIA S.A.	21389501000181	1	2022-03-28	\N	\N	\N	\N
2828	PASS6	COMPASS GAS E ENERGIA S.A.	21389501000181	1	2022-03-28	\N	\N	\N	\N
2829	PASS6F	COMPASS GAS E ENERGIA S.A.	21389501000181	1	2022-03-28	\N	\N	\N	\N
2830	PATI3	PANATLANTICA S.A.	92693019000189	1	2022-03-28	\N	\N	\N	\N
2831	PATI3F	PANATLANTICA S.A.	92693019000189	1	2022-03-28	\N	\N	\N	\N
2832	PATI4	PANATLANTICA S.A.	92693019000189	1	2022-03-28	\N	\N	\N	\N
2833	PATI4F	PANATLANTICA S.A.	92693019000189	1	2022-03-28	\N	\N	\N	\N
2834	PCAR3	CIA BRASILEIRA DE DISTRIBUICAO	47508411000156	1	2022-03-28	\N	\N	\N	\N
2835	PCAR3F	CIA BRASILEIRA DE DISTRIBUICAO	47508411000156	1	2022-03-28	\N	\N	\N	\N
2836	PDGR3	PDG REALTY S.A. EMPREEND E PARTICIPACOES	02950811000189	1	2022-03-28	\N	\N	\N	\N
2837	PDGR3F	PDG REALTY S.A. EMPREEND E PARTICIPACOES	02950811000189	1	2022-03-28	\N	\N	\N	\N
2838	PDTC3	PADTEC HOLDING S.A.	02365069000144	1	2022-03-28	\N	\N	\N	\N
2839	PDTC3F	PADTEC HOLDING S.A.	02365069000144	1	2022-03-28	\N	\N	\N	\N
2840	PEAB3	CIA PARTICIPACOES ALIANCA DA BAHIA	01938783000111	1	2022-03-28	\N	\N	\N	\N
2841	PEAB3F	CIA PARTICIPACOES ALIANCA DA BAHIA	01938783000111	1	2022-03-28	\N	\N	\N	\N
2842	PEAB4	CIA PARTICIPACOES ALIANCA DA BAHIA	01938783000111	1	2022-03-28	\N	\N	\N	\N
2843	PEAB4F	CIA PARTICIPACOES ALIANCA DA BAHIA	01938783000111	1	2022-03-28	\N	\N	\N	\N
2844	PETR3	PETROLEO BRASILEIRO S.A. PETROBRAS	33000167000101	1	2022-03-28	\N	\N	\N	\N
2845	PETR3F	PETROLEO BRASILEIRO S.A. PETROBRAS	33000167000101	1	2022-03-28	\N	\N	\N	\N
2846	PETR4	PETROLEO BRASILEIRO S.A. PETROBRAS	33000167000101	1	2022-03-28	\N	\N	\N	\N
2847	PETR4F	PETROLEO BRASILEIRO S.A. PETROBRAS	33000167000101	1	2022-03-28	\N	\N	\N	\N
2848	PETZ3	PET CENTER COMERCIO  E PARTICIPACOES S.A.	18328118000109	1	2022-03-28	\N	\N	\N	\N
2849	PETZ3F	PET CENTER COMERCIO  E PARTICIPACOES S.A.	18328118000109	1	2022-03-28	\N	\N	\N	\N
2850	PFRM3	PROFARMA DISTRIB PROD FARMACEUTICOS S.A.	45453214000151	1	2022-03-28	\N	\N	\N	\N
2851	PFRM3F	PROFARMA DISTRIB PROD FARMACEUTICOS S.A.	45453214000151	1	2022-03-28	\N	\N	\N	\N
2852	PGMN3	EMPREENDIMENTOS PAGUE MENOS S.A.	06626253000151	1	2022-03-28	\N	\N	\N	\N
2853	PGMN3F	EMPREENDIMENTOS PAGUE MENOS S.A.	06626253000151	1	2022-03-28	\N	\N	\N	\N
2854	PINE3	BCO PINE S.A.	62144175000120	1	2022-03-28	\N	\N	\N	\N
2855	PINE3F	BCO PINE S.A.	62144175000120	1	2022-03-28	\N	\N	\N	\N
2856	PINE4	BCO PINE S.A.	62144175000120	1	2022-03-28	\N	\N	\N	\N
2857	PINE4F	BCO PINE S.A.	62144175000120	1	2022-03-28	\N	\N	\N	\N
2858	PLAS3	PLASCAR PARTICIPACOES INDUSTRIAIS S.A.	51928174000150	1	2022-03-28	\N	\N	\N	\N
2859	PLAS3F	PLASCAR PARTICIPACOES INDUSTRIAIS S.A.	51928174000150	1	2022-03-28	\N	\N	\N	\N
2860	PLPL3	PLANO & PLANO DESENVOLVIMENTO IMOBILIÁRIO S.A.	24230275000180	1	2022-03-28	\N	\N	\N	\N
2861	PLPL3F	PLANO & PLANO DESENVOLVIMENTO IMOBILIÁRIO S.A.	24230275000180	1	2022-03-28	\N	\N	\N	\N
2862	PMAM3	PARANAPANEMA S.A.	60398369000126	1	2022-03-28	\N	\N	\N	\N
2863	PMAM3F	PARANAPANEMA S.A.	60398369000126	1	2022-03-28	\N	\N	\N	\N
2864	PNVL3	DIMED S.A. DISTRIBUIDORA DE MEDICAMENTOS	92665611000177	1	2022-03-28	\N	\N	\N	\N
2865	PNVL3F	DIMED S.A. DISTRIBUIDORA DE MEDICAMENTOS	92665611000177	1	2022-03-28	\N	\N	\N	\N
2866	POMO3	MARCOPOLO S.A.	88611835000129	1	2022-03-28	\N	\N	\N	\N
2867	POMO3F	MARCOPOLO S.A.	88611835000129	1	2022-03-28	\N	\N	\N	\N
2868	POMO4	MARCOPOLO S.A.	88611835000129	1	2022-03-28	\N	\N	\N	\N
2869	POMO4F	MARCOPOLO S.A.	88611835000129	1	2022-03-28	\N	\N	\N	\N
2870	PORT3	WILSON SONS HOLDINGS BRASIL S.A.	33130691000105	1	2022-03-28	\N	\N	\N	\N
2871	PORT3F	WILSON SONS HOLDINGS BRASIL S.A.	33130691000105	1	2022-03-28	\N	\N	\N	\N
2872	POSI3	POSITIVO TECNOLOGIA S.A.	81243735000148	1	2022-03-28	\N	\N	\N	\N
2873	POSI3F	POSITIVO TECNOLOGIA S.A.	81243735000148	1	2022-03-28	\N	\N	\N	\N
2874	PPAR3	POLPAR S.A.	59789545000171	1	2022-03-28	\N	\N	\N	\N
2875	PPAR3F	POLPAR S.A.	59789545000171	1	2022-03-28	\N	\N	\N	\N
2876	PRIO3	PETRO RIO S.A.	10629105000168	1	2022-03-28	\N	\N	\N	\N
2877	PRIO3F	PETRO RIO S.A.	10629105000168	1	2022-03-28	\N	\N	\N	\N
2878	PRNR3	PRINER SERVIÇOS INDUSTRIAIS S.A.	18593815000197	1	2022-03-28	\N	\N	\N	\N
2879	PRNR3F	PRINER SERVIÇOS INDUSTRIAIS S.A.	18593815000197	1	2022-03-28	\N	\N	\N	\N
2880	PRPT3B	PROMPT PARTICIPACOES S.A.	02992449000109	1	2022-03-28	\N	\N	\N	\N
2881	PRPT3BF	PROMPT PARTICIPACOES S.A.	02992449000109	1	2022-03-28	\N	\N	\N	\N
2882	PSSA3	PORTO SEGURO S.A.	02149205000169	1	2022-03-28	\N	\N	\N	\N
2883	PSSA3F	PORTO SEGURO S.A.	02149205000169	1	2022-03-28	\N	\N	\N	\N
2884	PTBL3	PBG S/A	83475913000191	1	2022-03-28	\N	\N	\N	\N
2885	PTBL3F	PBG S/A	83475913000191	1	2022-03-28	\N	\N	\N	\N
2886	PTCA11	PRATICA KLIMAQUIP INDUSTRIA E COMERCIO SA	08574411000100	1	2022-03-28	\N	\N	\N	\N
2887	PTCA11F	PRATICA KLIMAQUIP INDUSTRIA E COMERCIO SA	08574411000100	1	2022-03-28	\N	\N	\N	\N
2888	PTCA3	PRATICA KLIMAQUIP INDUSTRIA E COMERCIO SA	08574411000100	1	2022-03-28	\N	\N	\N	\N
2889	PTCA3F	PRATICA KLIMAQUIP INDUSTRIA E COMERCIO SA	08574411000100	1	2022-03-28	\N	\N	\N	\N
2890	PTNT3	PETTENATI S.A. INDUSTRIA TEXTIL	88613658000110	1	2022-03-28	\N	\N	\N	\N
2891	PTNT3F	PETTENATI S.A. INDUSTRIA TEXTIL	88613658000110	1	2022-03-28	\N	\N	\N	\N
2892	PTNT4	PETTENATI S.A. INDUSTRIA TEXTIL	88613658000110	1	2022-03-28	\N	\N	\N	\N
2893	PTNT4F	PETTENATI S.A. INDUSTRIA TEXTIL	88613658000110	1	2022-03-28	\N	\N	\N	\N
2894	QUAL3	QUALICORP CONSULTORIA E CORRETORA DE SEGUROS S.A.	11992680000193	1	2022-03-28	\N	\N	\N	\N
2895	QUAL3F	QUALICORP CONSULTORIA E CORRETORA DE SEGUROS S.A.	11992680000193	1	2022-03-28	\N	\N	\N	\N
2896	QUSW3	QUALITY SOFTWARE S.A.	35791391000194	1	2022-03-28	\N	\N	\N	\N
2897	QUSW3F	QUALITY SOFTWARE S.A.	35791391000194	1	2022-03-28	\N	\N	\N	\N
2898	QVQP3B	524 PARTICIPACOES S.A.	01851771000155	1	2022-03-28	\N	\N	\N	\N
2899	QVQP3BF	524 PARTICIPACOES S.A.	01851771000155	1	2022-03-28	\N	\N	\N	\N
2900	RADL3	RAIA DROGASIL S.A.	61585865000151	1	2022-03-28	\N	\N	\N	\N
2901	RADL3F	RAIA DROGASIL S.A.	61585865000151	1	2022-03-28	\N	\N	\N	\N
2902	RAIL3	RUMO S.A.	02387241000160	1	2022-03-28	\N	\N	\N	\N
2903	RAIL3F	RUMO S.A.	02387241000160	1	2022-03-28	\N	\N	\N	\N
2904	RAIZ4	RAIZEN S.A.	33453598000123	1	2022-03-28	\N	\N	\N	\N
2905	RAIZ4F	RAIZEN S.A.	33453598000123	1	2022-03-28	\N	\N	\N	\N
2906	RANI3	IRANI PAPEL E EMBALAGEM S.A.	92791243000103	1	2022-03-28	\N	\N	\N	\N
2907	RANI3F	IRANI PAPEL E EMBALAGEM S.A.	92791243000103	1	2022-03-28	\N	\N	\N	\N
2908	RAPT3	RANDON S.A. IMPLEMENTOS E PARTICIPACOES	89086144000116	1	2022-03-28	\N	\N	\N	\N
2909	RAPT3F	RANDON S.A. IMPLEMENTOS E PARTICIPACOES	89086144000116	1	2022-03-28	\N	\N	\N	\N
2910	RAPT4	RANDON S.A. IMPLEMENTOS E PARTICIPACOES	89086144000116	1	2022-03-28	\N	\N	\N	\N
2911	RAPT4F	RANDON S.A. IMPLEMENTOS E PARTICIPACOES	89086144000116	1	2022-03-28	\N	\N	\N	\N
2912	RBNS3	RODOBENS S.A	59981829000165	1	2022-03-28	\N	\N	\N	\N
2913	RBNS4	RODOBENS S.A	59981829000165	1	2022-03-28	\N	\N	\N	\N
2914	RCSL3	RECRUSUL S.A.	91333666000117	1	2022-03-28	\N	\N	\N	\N
2915	RCSL3F	RECRUSUL S.A.	91333666000117	1	2022-03-28	\N	\N	\N	\N
2916	RCSL4	RECRUSUL S.A.	91333666000117	1	2022-03-28	\N	\N	\N	\N
2917	RCSL4F	RECRUSUL S.A.	91333666000117	1	2022-03-28	\N	\N	\N	\N
2918	RDNI3	RNI NEGÓCIOS IMOBILIÁRIOS S.A.	67010660000124	1	2022-03-28	\N	\N	\N	\N
2919	RDNI3F	RNI NEGÓCIOS IMOBILIÁRIOS S.A.	67010660000124	1	2022-03-28	\N	\N	\N	\N
2920	RDOR3	Rede DOr So Luiz S.A.	06047087000139	1	2022-03-28	\N	\N	\N	\N
2921	RDOR3F	Rede DOr So Luiz S.A.	06047087000139	1	2022-03-28	\N	\N	\N	\N
2922	RECV3	PETRORECÔNCAVO S.A.	03342704000130	1	2022-03-28	\N	\N	\N	\N
2923	RECV3F	PETRORECÔNCAVO S.A.	03342704000130	1	2022-03-28	\N	\N	\N	\N
2924	REDE3	REDE ENERGIA PARTICIPAÇĠES S.A.	61584140000149	1	2022-03-28	\N	\N	\N	\N
2925	REDE3F	REDE ENERGIA PARTICIPAÇĠES S.A.	61584140000149	1	2022-03-28	\N	\N	\N	\N
2926	RENT3	LOCALIZA RENT A CAR S.A.	16670085000155	1	2022-03-28	\N	\N	\N	\N
2927	RENT3F	LOCALIZA RENT A CAR S.A.	16670085000155	1	2022-03-28	\N	\N	\N	\N
2928	RNEW3	RENOVA ENERGIA S.A.	08534605000174	1	2022-03-28	\N	\N	\N	\N
2929	RNEW3F	RENOVA ENERGIA S.A.	08534605000174	1	2022-03-28	\N	\N	\N	\N
2930	RNEW4	RENOVA ENERGIA S.A.	08534605000174	1	2022-03-28	\N	\N	\N	\N
2931	RNEW4F	RENOVA ENERGIA S.A.	08534605000174	1	2022-03-28	\N	\N	\N	\N
2932	ROMI3	INDUSTRIAS ROMI S.A.	56720428000163	1	2022-03-28	\N	\N	\N	\N
2933	ROMI3F	INDUSTRIAS ROMI S.A.	56720428000163	1	2022-03-28	\N	\N	\N	\N
2934	RPAD3	ALFA HOLDINGS S.A.	17167396000169	1	2022-03-28	\N	\N	\N	\N
2935	RPAD3F	ALFA HOLDINGS S.A.	17167396000169	1	2022-03-28	\N	\N	\N	\N
2936	RPAD5	ALFA HOLDINGS S.A.	17167396000169	1	2022-03-28	\N	\N	\N	\N
2937	RPAD5F	ALFA HOLDINGS S.A.	17167396000169	1	2022-03-28	\N	\N	\N	\N
2938	RPAD6	ALFA HOLDINGS S.A.	17167396000169	1	2022-03-28	\N	\N	\N	\N
2939	RPAD6F	ALFA HOLDINGS S.A.	17167396000169	1	2022-03-28	\N	\N	\N	\N
2940	RPMG3	REFINARIA DE PETROLEOS MANGUINHOS S.A.	33412081000196	1	2022-03-28	\N	\N	\N	\N
2941	RPMG3F	REFINARIA DE PETROLEOS MANGUINHOS S.A.	33412081000196	1	2022-03-28	\N	\N	\N	\N
2942	RRRP3	3R PETROLEUM ÓLEO E GÁS S.A	12091809000155	1	2022-03-28	\N	\N	\N	\N
2943	RRRP3F	3R PETROLEUM ÓLEO E GÁS S.A	12091809000155	1	2022-03-28	\N	\N	\N	\N
2944	RSID3	ROSSI RESIDENCIAL S.A.	61065751000180	1	2022-03-28	\N	\N	\N	\N
2945	RSID3F	ROSSI RESIDENCIAL S.A.	61065751000180	1	2022-03-28	\N	\N	\N	\N
2946	RSUL3	METALURGICA RIOSULENSE S.A.	85778074000106	1	2022-03-28	\N	\N	\N	\N
2947	RSUL3F	METALURGICA RIOSULENSE S.A.	85778074000106	1	2022-03-28	\N	\N	\N	\N
2948	RSUL4	METALURGICA RIOSULENSE S.A.	85778074000106	1	2022-03-28	\N	\N	\N	\N
2949	RSUL4F	METALURGICA RIOSULENSE S.A.	85778074000106	1	2022-03-28	\N	\N	\N	\N
2950	SANB3	BCO SANTANDER (BRASIL) S.A.	90400888000142	1	2022-03-28	\N	\N	\N	\N
2951	SANB3F	BCO SANTANDER (BRASIL) S.A.	90400888000142	1	2022-03-28	\N	\N	\N	\N
2952	SANB4	BCO SANTANDER (BRASIL) S.A.	90400888000142	1	2022-03-28	\N	\N	\N	\N
2953	SANB4F	BCO SANTANDER (BRASIL) S.A.	90400888000142	1	2022-03-28	\N	\N	\N	\N
2954	SAPR3	CIA SANEAMENTO DO PARANA - SANEPAR	76484013000145	1	2022-03-28	\N	\N	\N	\N
2955	SAPR3F	CIA SANEAMENTO DO PARANA - SANEPAR	76484013000145	1	2022-03-28	\N	\N	\N	\N
2956	SAPR4	CIA SANEAMENTO DO PARANA - SANEPAR	76484013000145	1	2022-03-28	\N	\N	\N	\N
2957	SAPR4F	CIA SANEAMENTO DO PARANA - SANEPAR	76484013000145	1	2022-03-28	\N	\N	\N	\N
2958	SBFG3	GRUPO SBF SA	13217485000111	1	2022-03-28	\N	\N	\N	\N
2959	SBFG3F	GRUPO SBF SA	13217485000111	1	2022-03-28	\N	\N	\N	\N
2960	SBSP3	CIA SANEAMENTO BASICO EST SAO PAULO	43776517000180	1	2022-03-28	\N	\N	\N	\N
2961	SBSP3F	CIA SANEAMENTO BASICO EST SAO PAULO	43776517000180	1	2022-03-28	\N	\N	\N	\N
2962	SCAR3	SAO CARLOS EMPREEND E PARTICIPACOES S.A.	29780061000109	1	2022-03-28	\N	\N	\N	\N
2963	SCAR3F	SAO CARLOS EMPREEND E PARTICIPACOES S.A.	29780061000109	1	2022-03-28	\N	\N	\N	\N
2964	SEER3	SER EDUCACIONAL S.A.	04986320000113	1	2022-03-28	\N	\N	\N	\N
2965	SEER3F	SER EDUCACIONAL S.A.	04986320000113	1	2022-03-28	\N	\N	\N	\N
2966	SEQL3	SEQUOIA LOGISTICA E TRANSPORTES S.A	01599101000193	1	2022-03-28	\N	\N	\N	\N
2967	SEQL3F	SEQUOIA LOGISTICA E TRANSPORTES S.A	01599101000193	1	2022-03-28	\N	\N	\N	\N
2968	SGPS3	SPRINGS GLOBAL PARTICIPACOES S.A.	07718269000157	1	2022-03-28	\N	\N	\N	\N
2969	SGPS3F	SPRINGS GLOBAL PARTICIPACOES S.A.	07718269000157	1	2022-03-28	\N	\N	\N	\N
2970	SHOW3	T4F ENTRETENIMENTO S.A.	02860694000162	1	2022-03-28	\N	\N	\N	\N
2971	SHOW3F	T4F ENTRETENIMENTO S.A.	02860694000162	1	2022-03-28	\N	\N	\N	\N
2972	SHUL3	SCHULZ S.A.	84693183000168	1	2022-03-28	\N	\N	\N	\N
2973	SHUL3F	SCHULZ S.A.	84693183000168	1	2022-03-28	\N	\N	\N	\N
2974	SHUL4	SCHULZ S.A.	84693183000168	1	2022-03-28	\N	\N	\N	\N
2975	SHUL4F	SCHULZ S.A.	84693183000168	1	2022-03-28	\N	\N	\N	\N
2976	SIMH3	SIMPAR S.A.	07415333000120	1	2022-03-28	\N	\N	\N	\N
2977	SIMH3F	SIMPAR S.A.	07415333000120	1	2022-03-28	\N	\N	\N	\N
2978	SLCE3	SLC AGRICOLA S.A.	89096457000155	1	2022-03-28	\N	\N	\N	\N
2979	SLCE3F	SLC AGRICOLA S.A.	89096457000155	1	2022-03-28	\N	\N	\N	\N
2980	SLED3	SARAIVA LIVREIROS S.A. - EM RECUPERAÇO JUDICIAL	60500139000126	1	2022-03-28	\N	\N	\N	\N
2981	SLED3F	SARAIVA LIVREIROS S.A. - EM RECUPERAÇO JUDICIAL	60500139000126	1	2022-03-28	\N	\N	\N	\N
2982	SLED4	SARAIVA LIVREIROS S.A. - EM RECUPERAÇO JUDICIAL	60500139000126	1	2022-03-28	\N	\N	\N	\N
2983	SLED4F	SARAIVA LIVREIROS S.A. - EM RECUPERAÇO JUDICIAL	60500139000126	1	2022-03-28	\N	\N	\N	\N
2984	SMFT3	SMARTFIT ESCOLA DE GINÁSTICA E DANÇA S.A.	07594978000178	1	2022-03-28	\N	\N	\N	\N
2985	SMFT3F	SMARTFIT ESCOLA DE GINÁSTICA E DANÇA S.A.	07594978000178	1	2022-03-28	\N	\N	\N	\N
2986	SMTO3	SAO MARTINHO S.A.	51466860000156	1	2022-03-28	\N	\N	\N	\N
2987	SMTO3F	SAO MARTINHO S.A.	51466860000156	1	2022-03-28	\N	\N	\N	\N
2988	SNSY3	SANSUY S.A. INDUSTRIA DE PLASTICOS	14807945000124	1	2022-03-28	\N	\N	\N	\N
2989	SNSY3F	SANSUY S.A. INDUSTRIA DE PLASTICOS	14807945000124	1	2022-03-28	\N	\N	\N	\N
2990	SNSY5	SANSUY S.A. INDUSTRIA DE PLASTICOS	14807945000124	1	2022-03-28	\N	\N	\N	\N
2991	SNSY5F	SANSUY S.A. INDUSTRIA DE PLASTICOS	14807945000124	1	2022-03-28	\N	\N	\N	\N
2992	SNSY6	SANSUY S.A. INDUSTRIA DE PLASTICOS	14807945000124	1	2022-03-28	\N	\N	\N	\N
2993	SNSY6F	SANSUY S.A. INDUSTRIA DE PLASTICOS	14807945000124	1	2022-03-28	\N	\N	\N	\N
2994	SOJA3	BOA SAFRA SEMENTES S.A.	10807374000177	1	2022-03-28	\N	\N	\N	\N
2995	SOJA3F	BOA SAFRA SEMENTES S.A.	10807374000177	1	2022-03-28	\N	\N	\N	\N
2996	SOMA3	GRUPO DE MODA SOMA S.A.	10285590000108	1	2022-03-28	\N	\N	\N	\N
2997	SOMA3F	GRUPO DE MODA SOMA S.A.	10285590000108	1	2022-03-28	\N	\N	\N	\N
2998	SOND3	SONDOTECNICA ENGENHARIA SOLOS S.A.	33386210000119	1	2022-03-28	\N	\N	\N	\N
2999	SOND3F	SONDOTECNICA ENGENHARIA SOLOS S.A.	33386210000119	1	2022-03-28	\N	\N	\N	\N
3000	SOND5	SONDOTECNICA ENGENHARIA SOLOS S.A.	33386210000119	1	2022-03-28	\N	\N	\N	\N
3001	SOND5F	SONDOTECNICA ENGENHARIA SOLOS S.A.	33386210000119	1	2022-03-28	\N	\N	\N	\N
3002	SOND6	SONDOTECNICA ENGENHARIA SOLOS S.A.	33386210000119	1	2022-03-28	\N	\N	\N	\N
3003	SOND6F	SONDOTECNICA ENGENHARIA SOLOS S.A.	33386210000119	1	2022-03-28	\N	\N	\N	\N
3004	SQIA3	SINQIA S.A.	04065791000199	1	2022-03-28	\N	\N	\N	\N
3005	SQIA3F	SINQIA S.A.	04065791000199	1	2022-03-28	\N	\N	\N	\N
3006	STBP3	SANTOS BRASIL PARTICIPACOES S.A.	02762121000104	1	2022-03-28	\N	\N	\N	\N
3007	STBP3F	SANTOS BRASIL PARTICIPACOES S.A.	02762121000104	1	2022-03-28	\N	\N	\N	\N
3008	STKF3	STATKRAFT ENERGIAS RENOVAVEIS S.A.	00622416000141	1	2022-03-28	\N	\N	\N	\N
3009	STKF3F	STATKRAFT ENERGIAS RENOVAVEIS S.A.	00622416000141	1	2022-03-28	\N	\N	\N	\N
3010	STTR3	STARA S.A. - INDÚSTRIA DE IMPLEMENTOS AGRÍCOLAS	91495499000100	1	2022-03-28	\N	\N	\N	\N
3011	STTR3F	STARA S.A. - INDÚSTRIA DE IMPLEMENTOS AGRÍCOLAS	91495499000100	1	2022-03-28	\N	\N	\N	\N
3012	SULA3	SUL AMERICA S.A.	29978814000187	1	2022-03-28	\N	\N	\N	\N
3013	SULA3F	SUL AMERICA S.A.	29978814000187	1	2022-03-28	\N	\N	\N	\N
3014	SULA4	SUL AMERICA S.A.	29978814000187	1	2022-03-28	\N	\N	\N	\N
3015	SULA4F	SUL AMERICA S.A.	29978814000187	1	2022-03-28	\N	\N	\N	\N
3016	SUZB3	SUZANO S.A.	16404287000155	1	2022-03-28	\N	\N	\N	\N
3017	SUZB3F	SUZANO S.A.	16404287000155	1	2022-03-28	\N	\N	\N	\N
3018	SYNE3	SYN prop e tech S.A.	08801621000186	1	2022-03-28	\N	\N	\N	\N
3019	SYNE3F	SYN prop e tech S.A.	08801621000186	1	2022-03-28	\N	\N	\N	\N
3020	TAEE3	TRANSMISSORA ALIANÇA DE ENERGIA ELÉTRICA S.A.	07859971000130	1	2022-03-28	\N	\N	\N	\N
3021	TAEE3F	TRANSMISSORA ALIANÇA DE ENERGIA ELÉTRICA S.A.	07859971000130	1	2022-03-28	\N	\N	\N	\N
3022	TAEE4	TRANSMISSORA ALIANÇA DE ENERGIA ELÉTRICA S.A.	07859971000130	1	2022-03-28	\N	\N	\N	\N
3023	TAEE4F	TRANSMISSORA ALIANÇA DE ENERGIA ELÉTRICA S.A.	07859971000130	1	2022-03-28	\N	\N	\N	\N
3024	TASA3	TAURUS ARMAS S.A.	92781335000102	1	2022-03-28	\N	\N	\N	\N
3025	TASA3F	TAURUS ARMAS S.A.	92781335000102	1	2022-03-28	\N	\N	\N	\N
3026	TASA4	TAURUS ARMAS S.A.	92781335000102	1	2022-03-28	\N	\N	\N	\N
3027	TASA4F	TAURUS ARMAS S.A.	92781335000102	1	2022-03-28	\N	\N	\N	\N
3028	TCNO3	TECNOSOLO ENGENHARIA S.A.	33111246000190	1	2022-03-28	\N	\N	\N	\N
3029	TCNO3F	TECNOSOLO ENGENHARIA S.A.	33111246000190	1	2022-03-28	\N	\N	\N	\N
3030	TCNO4	TECNOSOLO ENGENHARIA S.A.	33111246000190	1	2022-03-28	\N	\N	\N	\N
3031	TCNO4F	TECNOSOLO ENGENHARIA S.A.	33111246000190	1	2022-03-28	\N	\N	\N	\N
3032	TCSA3	TECNISA S.A.	08065557000112	1	2022-03-28	\N	\N	\N	\N
3033	TCSA3F	TECNISA S.A.	08065557000112	1	2022-03-28	\N	\N	\N	\N
3034	TECN3	TECHNOS S.A.	09295063000197	1	2022-03-28	\N	\N	\N	\N
3035	TECN3F	TECHNOS S.A.	09295063000197	1	2022-03-28	\N	\N	\N	\N
3036	TEGA3	TEGRA INCORPORADORA S.A.	30213493000109	1	2022-03-28	\N	\N	\N	\N
3037	TEGA3F	TEGRA INCORPORADORA S.A.	30213493000109	1	2022-03-28	\N	\N	\N	\N
3038	TEKA3	TEKA-TECELAGEM KUEHNRICH S.A.	82636986000155	1	2022-03-28	\N	\N	\N	\N
3039	TEKA3F	TEKA-TECELAGEM KUEHNRICH S.A.	82636986000155	1	2022-03-28	\N	\N	\N	\N
3040	TEKA4	TEKA-TECELAGEM KUEHNRICH S.A.	82636986000155	1	2022-03-28	\N	\N	\N	\N
3041	TEKA4F	TEKA-TECELAGEM KUEHNRICH S.A.	82636986000155	1	2022-03-28	\N	\N	\N	\N
3042	TELB3	TELEC BRASILEIRAS S.A. TELEBRAS	00336701000104	1	2022-03-28	\N	\N	\N	\N
3043	TELB3F	TELEC BRASILEIRAS S.A. TELEBRAS	00336701000104	1	2022-03-28	\N	\N	\N	\N
3044	TELB4	TELEC BRASILEIRAS S.A. TELEBRAS	00336701000104	1	2022-03-28	\N	\N	\N	\N
3045	TELB4F	TELEC BRASILEIRAS S.A. TELEBRAS	00336701000104	1	2022-03-28	\N	\N	\N	\N
3046	TEND3	CONSTRUTORA TENDA S.A.	71476527000135	1	2022-03-28	\N	\N	\N	\N
3047	TEND3F	CONSTRUTORA TENDA S.A.	71476527000135	1	2022-03-28	\N	\N	\N	\N
3048	TFCO4	TRACK & FIELD CO S.A.	59418806000147	1	2022-03-28	\N	\N	\N	\N
3049	TFCO4F	TRACK & FIELD CO S.A.	59418806000147	1	2022-03-28	\N	\N	\N	\N
3050	TGMA3	TEGMA GESTAO LOGISTICA S.A.	02351144000118	1	2022-03-28	\N	\N	\N	\N
3051	TGMA3F	TEGMA GESTAO LOGISTICA S.A.	02351144000118	1	2022-03-28	\N	\N	\N	\N
3052	TIMS3	TIM S.A.	02421421000111	1	2022-03-28	\N	\N	\N	\N
3053	TIMS3F	TIM S.A.	02421421000111	1	2022-03-28	\N	\N	\N	\N
3054	TKNO3	TEKNO S.A. - INDUSTRIA E COMERCIO	33467572000134	1	2022-03-28	\N	\N	\N	\N
3055	TKNO3F	TEKNO S.A. - INDUSTRIA E COMERCIO	33467572000134	1	2022-03-28	\N	\N	\N	\N
3056	TKNO4	TEKNO S.A. - INDUSTRIA E COMERCIO	33467572000134	1	2022-03-28	\N	\N	\N	\N
3057	TKNO4F	TEKNO S.A. - INDUSTRIA E COMERCIO	33467572000134	1	2022-03-28	\N	\N	\N	\N
3058	TOTS3	TOTVS S.A.	53113791000122	1	2022-03-28	\N	\N	\N	\N
3059	TOTS3F	TOTVS S.A.	53113791000122	1	2022-03-28	\N	\N	\N	\N
3060	TPIS3	TPI - TRIUNFO PARTICIP. E INVEST. S.A.	03014553000191	1	2022-03-28	\N	\N	\N	\N
3061	TPIS3F	TPI - TRIUNFO PARTICIP. E INVEST. S.A.	03014553000191	1	2022-03-28	\N	\N	\N	\N
3062	TRAD3	TC TRADERS CLUB S.A.	26345998000150	1	2022-03-28	\N	\N	\N	\N
3063	TRAD3F	TC TRADERS CLUB S.A.	26345998000150	1	2022-03-28	\N	\N	\N	\N
3064	TRIS3	TRISUL S.A.	08811643000127	1	2022-03-28	\N	\N	\N	\N
3065	TRIS3F	TRISUL S.A.	08811643000127	1	2022-03-28	\N	\N	\N	\N
3066	TRPL3	CTEEP - CIA TRANSMISSO ENERGIA ELÉTRICA PAULISTA	02998611000104	1	2022-03-28	\N	\N	\N	\N
3067	TRPL3F	CTEEP - CIA TRANSMISSO ENERGIA ELÉTRICA PAULISTA	02998611000104	1	2022-03-28	\N	\N	\N	\N
3068	TRPL4	CTEEP - CIA TRANSMISSO ENERGIA ELÉTRICA PAULISTA	02998611000104	1	2022-03-28	\N	\N	\N	\N
3069	TRPL4F	CTEEP - CIA TRANSMISSO ENERGIA ELÉTRICA PAULISTA	02998611000104	1	2022-03-28	\N	\N	\N	\N
3070	TTEN3	TRÊS TENTOS AGROINDUSTRIAL S/A	94813102000170	1	2022-03-28	\N	\N	\N	\N
3071	TTEN3F	TRÊS TENTOS AGROINDUSTRIAL S/A	94813102000170	1	2022-03-28	\N	\N	\N	\N
3072	TUPY3	TUPY S.A.	84683374000149	1	2022-03-28	\N	\N	\N	\N
3073	TUPY3F	TUPY S.A.	84683374000149	1	2022-03-28	\N	\N	\N	\N
3074	TXRX11	TEXTIL RENAUXVIEW S.A.	82982075000180	1	2022-03-28	\N	\N	\N	\N
3075	TXRX3	TEXTIL RENAUXVIEW S.A.	82982075000180	1	2022-03-28	\N	\N	\N	\N
3076	TXRX3F	TEXTIL RENAUXVIEW S.A.	82982075000180	1	2022-03-28	\N	\N	\N	\N
3077	TXRX4	TEXTIL RENAUXVIEW S.A.	82982075000180	1	2022-03-28	\N	\N	\N	\N
3078	TXRX4F	TEXTIL RENAUXVIEW S.A.	82982075000180	1	2022-03-28	\N	\N	\N	\N
3079	UCAS3	UNICASA INDÚSTRIA DE MÓVEIS S.A.	90441460000148	1	2022-03-28	\N	\N	\N	\N
3080	UCAS3F	UNICASA INDÚSTRIA DE MÓVEIS S.A.	90441460000148	1	2022-03-28	\N	\N	\N	\N
3081	UGPA3	ULTRAPAR PARTICIPACOES S.A.	33256439000139	1	2022-03-28	\N	\N	\N	\N
3082	UGPA3F	ULTRAPAR PARTICIPACOES S.A.	33256439000139	1	2022-03-28	\N	\N	\N	\N
3083	UNIP3	UNIPAR CARBOCLORO S.A.	33958695000178	1	2022-03-28	\N	\N	\N	\N
3084	UNIP3F	UNIPAR CARBOCLORO S.A.	33958695000178	1	2022-03-28	\N	\N	\N	\N
3085	UNIP5	UNIPAR CARBOCLORO S.A.	33958695000178	1	2022-03-28	\N	\N	\N	\N
3086	UNIP5F	UNIPAR CARBOCLORO S.A.	33958695000178	1	2022-03-28	\N	\N	\N	\N
3087	UNIP6	UNIPAR CARBOCLORO S.A.	33958695000178	1	2022-03-28	\N	\N	\N	\N
3088	UNIP6F	UNIPAR CARBOCLORO S.A.	33958695000178	1	2022-03-28	\N	\N	\N	\N
3089	UPKP3B	UPTICK PARTICIPACOES S.A.	02162616000194	1	2022-03-28	\N	\N	\N	\N
3090	UPKP3BF	UPTICK PARTICIPACOES S.A.	02162616000194	1	2022-03-28	\N	\N	\N	\N
3091	USIM3	USINAS SID DE MINAS GERAIS S.A.-USIMINAS	60894730000105	1	2022-03-28	\N	\N	\N	\N
3092	USIM3F	USINAS SID DE MINAS GERAIS S.A.-USIMINAS	60894730000105	1	2022-03-28	\N	\N	\N	\N
3093	USIM5	USINAS SID DE MINAS GERAIS S.A.-USIMINAS	60894730000105	1	2022-03-28	\N	\N	\N	\N
3094	USIM5F	USINAS SID DE MINAS GERAIS S.A.-USIMINAS	60894730000105	1	2022-03-28	\N	\N	\N	\N
3095	USIM6	USINAS SID DE MINAS GERAIS S.A.-USIMINAS	60894730000105	1	2022-03-28	\N	\N	\N	\N
3096	USIM6F	USINAS SID DE MINAS GERAIS S.A.-USIMINAS	60894730000105	1	2022-03-28	\N	\N	\N	\N
3097	VALE3	VALE S.A.	33592510000154	1	2022-03-28	\N	\N	\N	\N
3098	VALE3F	VALE S.A.	33592510000154	1	2022-03-28	\N	\N	\N	\N
3099	VAMO3	VAMOS LOCAÇO DE CAMINHĠES	23373000000132	1	2022-03-28	\N	\N	\N	\N
3100	VAMO3F	VAMOS LOCAÇO DE CAMINHĠES	23373000000132	1	2022-03-28	\N	\N	\N	\N
3101	VBBR3	VIBRA ENERGIA S.A.	34274233000102	1	2022-03-28	\N	\N	\N	\N
3102	VBBR3F	VIBRA ENERGIA S.A.	34274233000102	1	2022-03-28	\N	\N	\N	\N
3103	VIIA3	VIA S.A	33041260065290	1	2022-03-28	\N	\N	\N	\N
3104	VIIA3F	VIA S.A	33041260065290	1	2022-03-28	\N	\N	\N	\N
3105	VITT3	VITTIA FERTILIZANTES E BIOLOGICOS S.A.	45365558000109	1	2022-03-28	\N	\N	\N	\N
3106	VITT3F	VITTIA FERTILIZANTES E BIOLOGICOS S.A.	45365558000109	1	2022-03-28	\N	\N	\N	\N
3107	VIVA3	VIVARA PARTICIPAÇOES S.A	33839910000111	1	2022-03-28	\N	\N	\N	\N
3108	VIVA3F	VIVARA PARTICIPAÇOES S.A	33839910000111	1	2022-03-28	\N	\N	\N	\N
3109	VIVR3	VIVER INCORPORADORA E CONSTRUTORA S.A.	67571414000141	1	2022-03-28	\N	\N	\N	\N
3110	VIVR3F	VIVER INCORPORADORA E CONSTRUTORA S.A.	67571414000141	1	2022-03-28	\N	\N	\N	\N
3111	VIVT3	TELEFÔNICA BRASIL S.A	02558157000162	1	2022-03-28	\N	\N	\N	\N
3112	VIVT3F	TELEFÔNICA BRASIL S.A	02558157000162	1	2022-03-28	\N	\N	\N	\N
3113	VLID3	VALID SOLUÇĠES S.A.	33113309000147	1	2022-03-28	\N	\N	\N	\N
3114	VLID3F	VALID SOLUÇĠES S.A.	33113309000147	1	2022-03-28	\N	\N	\N	\N
3115	VULC3	VULCABRAS S.A.	50926955000142	1	2022-03-28	\N	\N	\N	\N
3116	VULC3F	VULCABRAS S.A.	50926955000142	1	2022-03-28	\N	\N	\N	\N
3117	VVEO3	CM HOSPITALAR S.A.	12420164000157	1	2022-03-28	\N	\N	\N	\N
3118	VVEO3F	CM HOSPITALAR S.A.	12420164000157	1	2022-03-28	\N	\N	\N	\N
3119	WEGE3	WEG S.A.	84429695000111	1	2022-03-28	\N	\N	\N	\N
3120	WEGE3F	WEG S.A.	84429695000111	1	2022-03-28	\N	\N	\N	\N
3121	WEST3	WESTWING COMERCIO VAREJISTA S.A.	14776142000150	1	2022-03-28	\N	\N	\N	\N
3122	WEST3F	WESTWING COMERCIO VAREJISTA S.A.	14776142000150	1	2022-03-28	\N	\N	\N	\N
3123	WHRL3	WHIRLPOOL S.A.	59105999000186	1	2022-03-28	\N	\N	\N	\N
3124	WHRL3F	WHIRLPOOL S.A.	59105999000186	1	2022-03-28	\N	\N	\N	\N
3125	WHRL4	WHIRLPOOL S.A.	59105999000186	1	2022-03-28	\N	\N	\N	\N
3126	WHRL4F	WHIRLPOOL S.A.	59105999000186	1	2022-03-28	\N	\N	\N	\N
3127	WIZS3	WIZ SOLUÇĠES E CORRETAGEM DE SEGUROS S.A.	42278473000103	1	2022-03-28	\N	\N	\N	\N
3128	WIZS3F	WIZ SOLUÇĠES E CORRETAGEM DE SEGUROS S.A.	42278473000103	1	2022-03-28	\N	\N	\N	\N
3129	WLMM3	WLM PART. E COMÉRCIO DE MÁQUINAS E VEÍCULOS S.A.	33228024000151	1	2022-03-28	\N	\N	\N	\N
3130	WLMM3F	WLM PART. E COMÉRCIO DE MÁQUINAS E VEÍCULOS S.A.	33228024000151	1	2022-03-28	\N	\N	\N	\N
3131	WLMM4	WLM PART. E COMÉRCIO DE MÁQUINAS E VEÍCULOS S.A.	33228024000151	1	2022-03-28	\N	\N	\N	\N
3132	WLMM4F	WLM PART. E COMÉRCIO DE MÁQUINAS E VEÍCULOS S.A.	33228024000151	1	2022-03-28	\N	\N	\N	\N
3133	YBRA3B	YBYRÁ S.A.	02217319000107	1	2022-03-28	\N	\N	\N	\N
3134	YBRA3BF	YBYRÁ S.A.	02217319000107	1	2022-03-28	\N	\N	\N	\N
3135	YBRA4B	YBYRÁ S.A.	02217319000107	1	2022-03-28	\N	\N	\N	\N
3136	YDUQ3	YDUQS PARTICIPACOES S.A.	08807432000110	1	2022-03-28	\N	\N	\N	\N
3137	YDUQ3F	YDUQS PARTICIPACOES S.A.	08807432000110	1	2022-03-28	\N	\N	\N	\N
\.


--
-- Data for Name: stocks_opening_balance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stocks_opening_balance (id, investor_id, stock_id, quantity, unit_value, created_at, updated_at, deleted_at) FROM stdin;
1	2	2612	317	$9.99	2022-03-29	\N	\N
\.


--
-- Data for Name: tds_opening_balance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tds_opening_balance (id, investor_id, value, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, password, created_at, updated_at, deleted_at, user_type_id) FROM stdin;
1	admin@admin.com	$2b$10$GfIYRgFapvUp3nMt6AQsPeNov0zPf0gHCDZ0mIfuRLB8v2rvS3irO	2022-03-28	\N	\N	1
2	cliente1@apressada.com.br	$2b$10$BozLt.TKQdhCEkIGmu0gduzqGSpc9eIf17RAsnUBWTz3MUNvB118O	2022-03-28	\N	\N	2
\.


--
-- Data for Name: users_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_type (id, type, created_at, created_by, updated_at, updated_by, deleted_at, deleted_by) FROM stdin;
1	admin	2022-03-28	1	\N	\N	\N	\N
2	user	2022-03-28	1	\N	\N	\N	\N
\.


--
-- Name: accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_id_seq', 1, false);


--
-- Name: addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.addresses_id_seq', 2, true);


--
-- Name: cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cities_id_seq', 5570, true);


--
-- Name: clearing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clearing_id_seq', 1, true);


--
-- Name: investors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.investors_id_seq', 2, true);


--
-- Name: invoices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.invoices_id_seq', 1, true);


--
-- Name: operational_costs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.operational_costs_id_seq', 1, true);


--
-- Name: operations_real_estate_investment_funds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.operations_real_estate_investment_funds_id_seq', 1, false);


--
-- Name: operations_stocks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.operations_stocks_id_seq', 1, true);


--
-- Name: phones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.phones_id_seq', 2, true);


--
-- Name: real_estate_investment_funds_administrators_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.real_estate_investment_funds_administrators_id_seq', 35, true);


--
-- Name: real_estate_investment_funds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.real_estate_investment_funds_id_seq', 322, true);


--
-- Name: real_estate_investment_funds_opening_balance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.real_estate_investment_funds_opening_balance_id_seq', 1, true);


--
-- Name: stock_brokers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stock_brokers_id_seq', 123, true);


--
-- Name: stock_market_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stock_market_id_seq', 1, true);


--
-- Name: stocks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stocks_id_seq', 3137, true);


--
-- Name: stocks_opening_balance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stocks_opening_balance_id_seq', 1, true);


--
-- Name: tds_opening_balance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tds_opening_balance_id_seq', 1, false);


--
-- Name: tds_opening_balance_value_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tds_opening_balance_value_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: users_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_type_id_seq', 2, true);


--
-- Name: accounts accounts_account_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_account_number_key UNIQUE (account_number);


--
-- Name: accounts accounts_branch_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_branch_number_key UNIQUE (branch_number);


--
-- Name: accounts accounts_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_id_key UNIQUE (id);


--
-- Name: accounts accounts_investor_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_investor_id_key UNIQUE (investor_id);


--
-- Name: accounts accounts_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pk PRIMARY KEY (account_number, branch_number, investor_id, stock_broker_id);


--
-- Name: accounts accounts_stock_broker_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_stock_broker_id_key UNIQUE (stock_broker_id);


--
-- Name: addresses adresses_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT adresses_pk PRIMARY KEY (id, investor_id);


--
-- Name: cities cities_pk0; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pk0 PRIMARY KEY (name, state);


--
-- Name: clearing clearing_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clearing
    ADD CONSTRAINT clearing_pk PRIMARY KEY (id);


--
-- Name: investors investors_document_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.investors
    ADD CONSTRAINT investors_document_key UNIQUE (document);


--
-- Name: investors investors_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.investors
    ADD CONSTRAINT investors_pk PRIMARY KEY (id);


--
-- Name: invoices invoices_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_id_key UNIQUE (id);


--
-- Name: invoices invoices_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_pk PRIMARY KEY (stock_broker_id, invoice_number);


--
-- Name: operational_costs operational_costs_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operational_costs
    ADD CONSTRAINT operational_costs_pk PRIMARY KEY (id);


--
-- Name: operations_real_estate_investment_funds operations_real_estate_investment_funds_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operations_real_estate_investment_funds
    ADD CONSTRAINT operations_real_estate_investment_funds_pk PRIMARY KEY (id);


--
-- Name: operations_stocks operations_stocks_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operations_stocks
    ADD CONSTRAINT operations_stocks_pk PRIMARY KEY (id);


--
-- Name: phones phones_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phones
    ADD CONSTRAINT phones_id_key UNIQUE (id);


--
-- Name: phones phones_phone_ddd_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phones
    ADD CONSTRAINT phones_phone_ddd_key UNIQUE (city_code);


--
-- Name: phones phones_phone_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phones
    ADD CONSTRAINT phones_phone_number_key UNIQUE (phone_number);


--
-- Name: phones phones_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phones
    ADD CONSTRAINT phones_pk PRIMARY KEY (city_code, phone_number, investor_id);


--
-- Name: real_estate_investment_funds_administrators real_estate_investment_funds_administrators_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.real_estate_investment_funds_administrators
    ADD CONSTRAINT real_estate_investment_funds_administrators_id_key UNIQUE (id);


--
-- Name: real_estate_investment_funds_administrators real_estate_investment_funds_administrators_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.real_estate_investment_funds_administrators
    ADD CONSTRAINT real_estate_investment_funds_administrators_pk PRIMARY KEY (cnpj);


--
-- Name: real_estate_investment_funds real_estate_investment_funds_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.real_estate_investment_funds
    ADD CONSTRAINT real_estate_investment_funds_id_key UNIQUE (id);


--
-- Name: real_estate_investment_funds_opening_balance real_estate_investment_funds_opening_balance_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.real_estate_investment_funds_opening_balance
    ADD CONSTRAINT real_estate_investment_funds_opening_balance_id_key UNIQUE (id);


--
-- Name: real_estate_investment_funds_opening_balance real_estate_investment_funds_opening_balance_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.real_estate_investment_funds_opening_balance
    ADD CONSTRAINT real_estate_investment_funds_opening_balance_pk PRIMARY KEY (real_estate_investment_fund_id);


--
-- Name: real_estate_investment_funds real_estate_investment_funds_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.real_estate_investment_funds
    ADD CONSTRAINT real_estate_investment_funds_pk PRIMARY KEY (ticker_symbol, real_estate_investment_funds_cnpj);


--
-- Name: real_estate_investment_funds real_estate_investment_funds_real_estate_investment_funds_c_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.real_estate_investment_funds
    ADD CONSTRAINT real_estate_investment_funds_real_estate_investment_funds_c_key UNIQUE (real_estate_investment_funds_cnpj);


--
-- Name: real_estate_investment_funds real_estate_investment_funds_ticker_symbol_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.real_estate_investment_funds
    ADD CONSTRAINT real_estate_investment_funds_ticker_symbol_key UNIQUE (ticker_symbol);


--
-- Name: stock_brokers stock_brokers_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_brokers
    ADD CONSTRAINT stock_brokers_id_key UNIQUE (id);


--
-- Name: stock_brokers stock_brokers_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_brokers
    ADD CONSTRAINT stock_brokers_pk PRIMARY KEY (cnpj);


--
-- Name: stock_market stock_market_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_market
    ADD CONSTRAINT stock_market_pk PRIMARY KEY (id);


--
-- Name: stocks stocks_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stocks
    ADD CONSTRAINT stocks_id_key UNIQUE (id);


--
-- Name: stocks_opening_balance stocks_opening_balance_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stocks_opening_balance
    ADD CONSTRAINT stocks_opening_balance_id_key UNIQUE (id);


--
-- Name: stocks_opening_balance stocks_opening_balance_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stocks_opening_balance
    ADD CONSTRAINT stocks_opening_balance_pk PRIMARY KEY (stock_id);


--
-- Name: stocks stocks_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stocks
    ADD CONSTRAINT stocks_pk PRIMARY KEY (ticker_symbol, cnpj);


--
-- Name: stocks stocks_ticker_symbol_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stocks
    ADD CONSTRAINT stocks_ticker_symbol_key UNIQUE (ticker_symbol);


--
-- Name: tds_opening_balance tds_opening_balance_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tds_opening_balance
    ADD CONSTRAINT tds_opening_balance_pk PRIMARY KEY (id);


--
-- Name: cities unique_city_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT unique_city_id UNIQUE (id);


--
-- Name: users_type unique_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_type
    ADD CONSTRAINT unique_id UNIQUE (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_id_key UNIQUE (id);


--
-- Name: users users_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY (email, password);


--
-- Name: users_type users_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_type
    ADD CONSTRAINT users_type_pkey PRIMARY KEY (type);


--
-- Name: accounts accounts_fk0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_fk0 FOREIGN KEY (investor_id) REFERENCES public.investors(id);


--
-- Name: accounts accounts_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_fk1 FOREIGN KEY (stock_broker_id) REFERENCES public.stock_brokers(id);


--
-- Name: addresses adresses_fk0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT adresses_fk0 FOREIGN KEY (investor_id) REFERENCES public.investors(id);


--
-- Name: addresses cities_fk0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT cities_fk0 FOREIGN KEY (city_id) REFERENCES public.cities(id) NOT VALID;


--
-- Name: clearing clearing_fk0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clearing
    ADD CONSTRAINT clearing_fk0 FOREIGN KEY (invoice_id) REFERENCES public.invoices(id) NOT VALID;


--
-- Name: investors investors_fk0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.investors
    ADD CONSTRAINT investors_fk0 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: invoices invoices_fk0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_fk0 FOREIGN KEY (investor_id) REFERENCES public.investors(id);


--
-- Name: invoices invoices_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_fk1 FOREIGN KEY (stock_broker_id) REFERENCES public.stock_brokers(id);


--
-- Name: operational_costs operational_costs_fk0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operational_costs
    ADD CONSTRAINT operational_costs_fk0 FOREIGN KEY (invoice_id) REFERENCES public.invoices(id) NOT VALID;


--
-- Name: operations_real_estate_investment_funds operations_real_estate_investment_funds_fk0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operations_real_estate_investment_funds
    ADD CONSTRAINT operations_real_estate_investment_funds_fk0 FOREIGN KEY (invoice_id) REFERENCES public.invoices(id);


--
-- Name: operations_real_estate_investment_funds operations_real_estate_investment_funds_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operations_real_estate_investment_funds
    ADD CONSTRAINT operations_real_estate_investment_funds_fk1 FOREIGN KEY (real_estate_investment_fund_id) REFERENCES public.real_estate_investment_funds(id);


--
-- Name: operations_stocks operations_stocks_fk0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operations_stocks
    ADD CONSTRAINT operations_stocks_fk0 FOREIGN KEY (invoice_id) REFERENCES public.invoices(id);


--
-- Name: operations_stocks operations_stocks_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operations_stocks
    ADD CONSTRAINT operations_stocks_fk1 FOREIGN KEY (stock_id) REFERENCES public.stocks(id);


--
-- Name: phones phones_fk0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phones
    ADD CONSTRAINT phones_fk0 FOREIGN KEY (investor_id) REFERENCES public.investors(id);


--
-- Name: real_estate_investment_funds real_estate_investment_funds_fk0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.real_estate_investment_funds
    ADD CONSTRAINT real_estate_investment_funds_fk0 FOREIGN KEY ("real_estate_investment_funds-administrator_id") REFERENCES public.real_estate_investment_funds_administrators(id);


--
-- Name: real_estate_investment_funds_opening_balance real_estate_investment_funds_opening_balance_fk0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.real_estate_investment_funds_opening_balance
    ADD CONSTRAINT real_estate_investment_funds_opening_balance_fk0 FOREIGN KEY (investor_id) REFERENCES public.investors(id);


--
-- Name: real_estate_investment_funds_opening_balance real_estate_investment_funds_opening_balance_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.real_estate_investment_funds_opening_balance
    ADD CONSTRAINT real_estate_investment_funds_opening_balance_fk1 FOREIGN KEY (real_estate_investment_fund_id) REFERENCES public.real_estate_investment_funds(id) NOT VALID;


--
-- Name: stock_market stock_market_fk0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_market
    ADD CONSTRAINT stock_market_fk0 FOREIGN KEY (invoice_id) REFERENCES public.invoices(id) NOT VALID;


--
-- Name: stocks_opening_balance stocks_opening_balance_fk0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stocks_opening_balance
    ADD CONSTRAINT stocks_opening_balance_fk0 FOREIGN KEY (investor_id) REFERENCES public.investors(id);


--
-- Name: stocks_opening_balance stocks_opening_balance_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stocks_opening_balance
    ADD CONSTRAINT stocks_opening_balance_fk1 FOREIGN KEY (stock_id) REFERENCES public.stocks(id);


--
-- Name: tds_opening_balance tds_opening_balance_fk0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tds_opening_balance
    ADD CONSTRAINT tds_opening_balance_fk0 FOREIGN KEY (investor_id) REFERENCES public.investors(id);


--
-- Name: users user_type_id_fk0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_type_id_fk0 FOREIGN KEY (user_type_id) REFERENCES public.users_type(id) NOT VALID;


--
-- PostgreSQL database dump complete
--

