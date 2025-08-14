--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-08-14 12:54:00

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 224 (class 1259 OID 33749)
-- Name: dim_czas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_czas (
    czas_id integer NOT NULL,
    data date NOT NULL,
    rok integer NOT NULL,
    miesiac integer NOT NULL,
    dzien integer NOT NULL,
    dzien_tygodnia character varying(10),
    CONSTRAINT dim_czas_dzien_check CHECK (((dzien >= 1) AND (dzien <= 31))),
    CONSTRAINT dim_czas_miesiac_check CHECK (((miesiac >= 1) AND (miesiac <= 12)))
);


ALTER TABLE public.dim_czas OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 33748)
-- Name: dim_czas_czas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_czas_czas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_czas_czas_id_seq OWNER TO postgres;

--
-- TOC entry 4953 (class 0 OID 0)
-- Dependencies: 223
-- Name: dim_czas_czas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_czas_czas_id_seq OWNED BY public.dim_czas.czas_id;


--
-- TOC entry 220 (class 1259 OID 33727)
-- Name: dim_kategoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_kategoria (
    kategoria_id integer NOT NULL,
    nazwa_kategorii character varying(50) NOT NULL
);


ALTER TABLE public.dim_kategoria OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 33726)
-- Name: dim_kategoria_kategoria_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_kategoria_kategoria_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_kategoria_kategoria_id_seq OWNER TO postgres;

--
-- TOC entry 4954 (class 0 OID 0)
-- Dependencies: 219
-- Name: dim_kategoria_kategoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_kategoria_kategoria_id_seq OWNED BY public.dim_kategoria.kategoria_id;


--
-- TOC entry 218 (class 1259 OID 33720)
-- Name: dim_klient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_klient (
    klient_id integer NOT NULL,
    imie character varying(50) NOT NULL,
    nazwisko character varying(50) NOT NULL,
    miasto character varying(50),
    ulica character varying(100),
    email character varying(100)
);


ALTER TABLE public.dim_klient OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 33719)
-- Name: dim_klient_klient_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_klient_klient_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_klient_klient_id_seq OWNER TO postgres;

--
-- TOC entry 4955 (class 0 OID 0)
-- Dependencies: 217
-- Name: dim_klient_klient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_klient_klient_id_seq OWNED BY public.dim_klient.klient_id;


--
-- TOC entry 222 (class 1259 OID 33736)
-- Name: dim_produkt; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_produkt (
    produkt_id integer NOT NULL,
    nazwa character varying(100) NOT NULL,
    parametr character varying(50),
    cena_brutto numeric(12,2),
    id_kategoria integer,
    CONSTRAINT dim_produkt_cena_brutto_check CHECK ((cena_brutto >= (0)::numeric))
);


ALTER TABLE public.dim_produkt OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 33735)
-- Name: dim_produkt_produkt_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_produkt_produkt_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_produkt_produkt_id_seq OWNER TO postgres;

--
-- TOC entry 4956 (class 0 OID 0)
-- Dependencies: 221
-- Name: dim_produkt_produkt_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_produkt_produkt_id_seq OWNED BY public.dim_produkt.produkt_id;


--
-- TOC entry 226 (class 1259 OID 33760)
-- Name: fakt_zamowienie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fakt_zamowienie (
    zamowienie_id integer NOT NULL,
    klient_id integer NOT NULL,
    produkt_id integer NOT NULL,
    czas_id integer NOT NULL,
    ilosc integer NOT NULL,
    wartosc numeric(12,2) NOT NULL,
    status character varying(20),
    CONSTRAINT fakt_zamowienie_ilosc_check CHECK ((ilosc > 0)),
    CONSTRAINT fakt_zamowienie_wartosc_check CHECK ((wartosc >= (0)::numeric))
);


ALTER TABLE public.fakt_zamowienie OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 33759)
-- Name: fakt_zamowienie_zamowienie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fakt_zamowienie_zamowienie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fakt_zamowienie_zamowienie_id_seq OWNER TO postgres;

--
-- TOC entry 4957 (class 0 OID 0)
-- Dependencies: 225
-- Name: fakt_zamowienie_zamowienie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fakt_zamowienie_zamowienie_id_seq OWNED BY public.fakt_zamowienie.zamowienie_id;


--
-- TOC entry 4765 (class 2604 OID 33752)
-- Name: dim_czas czas_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_czas ALTER COLUMN czas_id SET DEFAULT nextval('public.dim_czas_czas_id_seq'::regclass);


--
-- TOC entry 4763 (class 2604 OID 33730)
-- Name: dim_kategoria kategoria_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_kategoria ALTER COLUMN kategoria_id SET DEFAULT nextval('public.dim_kategoria_kategoria_id_seq'::regclass);


--
-- TOC entry 4762 (class 2604 OID 33723)
-- Name: dim_klient klient_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_klient ALTER COLUMN klient_id SET DEFAULT nextval('public.dim_klient_klient_id_seq'::regclass);


--
-- TOC entry 4764 (class 2604 OID 33739)
-- Name: dim_produkt produkt_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_produkt ALTER COLUMN produkt_id SET DEFAULT nextval('public.dim_produkt_produkt_id_seq'::regclass);


--
-- TOC entry 4766 (class 2604 OID 33763)
-- Name: fakt_zamowienie zamowienie_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fakt_zamowienie ALTER COLUMN zamowienie_id SET DEFAULT nextval('public.fakt_zamowienie_zamowienie_id_seq'::regclass);


--
-- TOC entry 4945 (class 0 OID 33749)
-- Dependencies: 224
-- Data for Name: dim_czas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_czas (czas_id, data, rok, miesiac, dzien, dzien_tygodnia) FROM stdin;
1	2024-01-01	2024	1	1	Monday
2	2024-01-02	2024	1	2	Tuesday
3	2024-01-03	2024	1	3	Wednesday
4	2024-01-04	2024	1	4	Thursday
5	2024-01-05	2024	1	5	Friday
6	2024-01-06	2024	1	6	Saturday
7	2024-01-07	2024	1	7	Sunday
8	2024-01-08	2024	1	8	Monday
9	2024-01-09	2024	1	9	Tuesday
10	2024-01-10	2024	1	10	Wednesday
11	2024-01-11	2024	1	11	Thursday
12	2024-01-12	2024	1	12	Friday
13	2024-01-13	2024	1	13	Saturday
14	2024-01-14	2024	1	14	Sunday
15	2024-01-15	2024	1	15	Monday
16	2024-01-16	2024	1	16	Tuesday
17	2024-01-17	2024	1	17	Wednesday
18	2024-01-18	2024	1	18	Thursday
19	2024-01-19	2024	1	19	Friday
20	2024-01-20	2024	1	20	Saturday
21	2024-01-21	2024	1	21	Sunday
22	2024-01-22	2024	1	22	Monday
23	2024-01-23	2024	1	23	Tuesday
24	2024-01-24	2024	1	24	Wednesday
25	2024-01-25	2024	1	25	Thursday
26	2024-01-26	2024	1	26	Friday
27	2024-01-27	2024	1	27	Saturday
28	2024-01-28	2024	1	28	Sunday
29	2024-01-29	2024	1	29	Monday
30	2024-01-30	2024	1	30	Tuesday
31	2024-01-31	2024	1	31	Wednesday
32	2024-02-01	2024	2	1	Thursday
33	2024-02-02	2024	2	2	Friday
34	2024-02-03	2024	2	3	Saturday
35	2024-02-04	2024	2	4	Sunday
36	2024-02-05	2024	2	5	Monday
37	2024-02-06	2024	2	6	Tuesday
38	2024-02-07	2024	2	7	Wednesday
39	2024-02-08	2024	2	8	Thursday
40	2024-02-09	2024	2	9	Friday
41	2024-02-10	2024	2	10	Saturday
42	2024-02-11	2024	2	11	Sunday
43	2024-02-12	2024	2	12	Monday
44	2024-02-13	2024	2	13	Tuesday
45	2024-02-14	2024	2	14	Wednesday
46	2024-02-15	2024	2	15	Thursday
47	2024-02-16	2024	2	16	Friday
48	2024-02-17	2024	2	17	Saturday
49	2024-02-18	2024	2	18	Sunday
50	2024-02-19	2024	2	19	Monday
51	2024-02-20	2024	2	20	Tuesday
52	2024-02-21	2024	2	21	Wednesday
53	2024-02-22	2024	2	22	Thursday
54	2024-02-23	2024	2	23	Friday
55	2024-02-24	2024	2	24	Saturday
56	2024-02-25	2024	2	25	Sunday
57	2024-02-26	2024	2	26	Monday
58	2024-02-27	2024	2	27	Tuesday
59	2024-02-28	2024	2	28	Wednesday
60	2024-02-29	2024	2	29	Thursday
61	2024-03-01	2024	3	1	Friday
62	2024-03-02	2024	3	2	Saturday
63	2024-03-03	2024	3	3	Sunday
64	2024-03-04	2024	3	4	Monday
65	2024-03-05	2024	3	5	Tuesday
66	2024-03-06	2024	3	6	Wednesday
67	2024-03-07	2024	3	7	Thursday
68	2024-03-08	2024	3	8	Friday
69	2024-03-09	2024	3	9	Saturday
70	2024-03-10	2024	3	10	Sunday
71	2024-03-11	2024	3	11	Monday
72	2024-03-12	2024	3	12	Tuesday
73	2024-03-13	2024	3	13	Wednesday
74	2024-03-14	2024	3	14	Thursday
75	2024-03-15	2024	3	15	Friday
76	2024-03-16	2024	3	16	Saturday
77	2024-03-17	2024	3	17	Sunday
78	2024-03-18	2024	3	18	Monday
79	2024-03-19	2024	3	19	Tuesday
80	2024-03-20	2024	3	20	Wednesday
81	2024-03-21	2024	3	21	Thursday
82	2024-03-22	2024	3	22	Friday
83	2024-03-23	2024	3	23	Saturday
84	2024-03-24	2024	3	24	Sunday
85	2024-03-25	2024	3	25	Monday
86	2024-03-26	2024	3	26	Tuesday
87	2024-03-27	2024	3	27	Wednesday
88	2024-03-28	2024	3	28	Thursday
89	2024-03-29	2024	3	29	Friday
90	2024-03-30	2024	3	30	Saturday
91	2024-03-31	2024	3	31	Sunday
92	2024-04-01	2024	4	1	Monday
93	2024-04-02	2024	4	2	Tuesday
94	2024-04-03	2024	4	3	Wednesday
95	2024-04-04	2024	4	4	Thursday
96	2024-04-05	2024	4	5	Friday
97	2024-04-06	2024	4	6	Saturday
98	2024-04-07	2024	4	7	Sunday
99	2024-04-08	2024	4	8	Monday
100	2024-04-09	2024	4	9	Tuesday
101	2024-04-10	2024	4	10	Wednesday
102	2024-04-11	2024	4	11	Thursday
103	2024-04-12	2024	4	12	Friday
104	2024-04-13	2024	4	13	Saturday
105	2024-04-14	2024	4	14	Sunday
106	2024-04-15	2024	4	15	Monday
107	2024-04-16	2024	4	16	Tuesday
108	2024-04-17	2024	4	17	Wednesday
109	2024-04-18	2024	4	18	Thursday
110	2024-04-19	2024	4	19	Friday
111	2024-04-20	2024	4	20	Saturday
112	2024-04-21	2024	4	21	Sunday
113	2024-04-22	2024	4	22	Monday
114	2024-04-23	2024	4	23	Tuesday
115	2024-04-24	2024	4	24	Wednesday
116	2024-04-25	2024	4	25	Thursday
117	2024-04-26	2024	4	26	Friday
118	2024-04-27	2024	4	27	Saturday
119	2024-04-28	2024	4	28	Sunday
120	2024-04-29	2024	4	29	Monday
121	2024-04-30	2024	4	30	Tuesday
122	2024-05-01	2024	5	1	Wednesday
123	2024-05-02	2024	5	2	Thursday
124	2024-05-03	2024	5	3	Friday
125	2024-05-04	2024	5	4	Saturday
126	2024-05-05	2024	5	5	Sunday
127	2024-05-06	2024	5	6	Monday
128	2024-05-07	2024	5	7	Tuesday
129	2024-05-08	2024	5	8	Wednesday
130	2024-05-09	2024	5	9	Thursday
131	2024-05-10	2024	5	10	Friday
132	2024-05-11	2024	5	11	Saturday
133	2024-05-12	2024	5	12	Sunday
134	2024-05-13	2024	5	13	Monday
135	2024-05-14	2024	5	14	Tuesday
136	2024-05-15	2024	5	15	Wednesday
137	2024-05-16	2024	5	16	Thursday
138	2024-05-17	2024	5	17	Friday
139	2024-05-18	2024	5	18	Saturday
140	2024-05-19	2024	5	19	Sunday
141	2024-05-20	2024	5	20	Monday
142	2024-05-21	2024	5	21	Tuesday
143	2024-05-22	2024	5	22	Wednesday
144	2024-05-23	2024	5	23	Thursday
145	2024-05-24	2024	5	24	Friday
146	2024-05-25	2024	5	25	Saturday
147	2024-05-26	2024	5	26	Sunday
148	2024-05-27	2024	5	27	Monday
149	2024-05-28	2024	5	28	Tuesday
150	2024-05-29	2024	5	29	Wednesday
151	2024-05-30	2024	5	30	Thursday
152	2024-05-31	2024	5	31	Friday
153	2024-06-01	2024	6	1	Saturday
154	2024-06-02	2024	6	2	Sunday
155	2024-06-03	2024	6	3	Monday
156	2024-06-04	2024	6	4	Tuesday
157	2024-06-05	2024	6	5	Wednesday
158	2024-06-06	2024	6	6	Thursday
159	2024-06-07	2024	6	7	Friday
160	2024-06-08	2024	6	8	Saturday
161	2024-06-09	2024	6	9	Sunday
162	2024-06-10	2024	6	10	Monday
163	2024-06-11	2024	6	11	Tuesday
164	2024-06-12	2024	6	12	Wednesday
165	2024-06-13	2024	6	13	Thursday
166	2024-06-14	2024	6	14	Friday
167	2024-06-15	2024	6	15	Saturday
168	2024-06-16	2024	6	16	Sunday
169	2024-06-17	2024	6	17	Monday
170	2024-06-18	2024	6	18	Tuesday
171	2024-06-19	2024	6	19	Wednesday
172	2024-06-20	2024	6	20	Thursday
173	2024-06-21	2024	6	21	Friday
174	2024-06-22	2024	6	22	Saturday
175	2024-06-23	2024	6	23	Sunday
176	2024-06-24	2024	6	24	Monday
177	2024-06-25	2024	6	25	Tuesday
178	2024-06-26	2024	6	26	Wednesday
179	2024-06-27	2024	6	27	Thursday
180	2024-06-28	2024	6	28	Friday
181	2024-06-29	2024	6	29	Saturday
182	2024-06-30	2024	6	30	Sunday
183	2024-07-01	2024	7	1	Monday
184	2024-07-02	2024	7	2	Tuesday
185	2024-07-03	2024	7	3	Wednesday
186	2024-07-04	2024	7	4	Thursday
187	2024-07-05	2024	7	5	Friday
188	2024-07-06	2024	7	6	Saturday
189	2024-07-07	2024	7	7	Sunday
190	2024-07-08	2024	7	8	Monday
191	2024-07-09	2024	7	9	Tuesday
192	2024-07-10	2024	7	10	Wednesday
193	2024-07-11	2024	7	11	Thursday
194	2024-07-12	2024	7	12	Friday
195	2024-07-13	2024	7	13	Saturday
196	2024-07-14	2024	7	14	Sunday
197	2024-07-15	2024	7	15	Monday
198	2024-07-16	2024	7	16	Tuesday
199	2024-07-17	2024	7	17	Wednesday
200	2024-07-18	2024	7	18	Thursday
201	2024-07-19	2024	7	19	Friday
202	2024-07-20	2024	7	20	Saturday
203	2024-07-21	2024	7	21	Sunday
204	2024-07-22	2024	7	22	Monday
205	2024-07-23	2024	7	23	Tuesday
206	2024-07-24	2024	7	24	Wednesday
207	2024-07-25	2024	7	25	Thursday
208	2024-07-26	2024	7	26	Friday
209	2024-07-27	2024	7	27	Saturday
210	2024-07-28	2024	7	28	Sunday
211	2024-07-29	2024	7	29	Monday
212	2024-07-30	2024	7	30	Tuesday
213	2024-07-31	2024	7	31	Wednesday
214	2024-08-01	2024	8	1	Thursday
215	2024-08-02	2024	8	2	Friday
216	2024-08-03	2024	8	3	Saturday
217	2024-08-04	2024	8	4	Sunday
218	2024-08-05	2024	8	5	Monday
219	2024-08-06	2024	8	6	Tuesday
220	2024-08-07	2024	8	7	Wednesday
221	2024-08-08	2024	8	8	Thursday
222	2024-08-09	2024	8	9	Friday
223	2024-08-10	2024	8	10	Saturday
224	2024-08-11	2024	8	11	Sunday
225	2024-08-12	2024	8	12	Monday
226	2024-08-13	2024	8	13	Tuesday
227	2024-08-14	2024	8	14	Wednesday
228	2024-08-15	2024	8	15	Thursday
229	2024-08-16	2024	8	16	Friday
230	2024-08-17	2024	8	17	Saturday
231	2024-08-18	2024	8	18	Sunday
232	2024-08-19	2024	8	19	Monday
233	2024-08-20	2024	8	20	Tuesday
234	2024-08-21	2024	8	21	Wednesday
235	2024-08-22	2024	8	22	Thursday
236	2024-08-23	2024	8	23	Friday
237	2024-08-24	2024	8	24	Saturday
238	2024-08-25	2024	8	25	Sunday
239	2024-08-26	2024	8	26	Monday
240	2024-08-27	2024	8	27	Tuesday
241	2024-08-28	2024	8	28	Wednesday
242	2024-08-29	2024	8	29	Thursday
243	2024-08-30	2024	8	30	Friday
244	2024-08-31	2024	8	31	Saturday
245	2024-09-01	2024	9	1	Sunday
246	2024-09-02	2024	9	2	Monday
247	2024-09-03	2024	9	3	Tuesday
248	2024-09-04	2024	9	4	Wednesday
249	2024-09-05	2024	9	5	Thursday
250	2024-09-06	2024	9	6	Friday
251	2024-09-07	2024	9	7	Saturday
252	2024-09-08	2024	9	8	Sunday
253	2024-09-09	2024	9	9	Monday
254	2024-09-10	2024	9	10	Tuesday
255	2024-09-11	2024	9	11	Wednesday
256	2024-09-12	2024	9	12	Thursday
257	2024-09-13	2024	9	13	Friday
258	2024-09-14	2024	9	14	Saturday
259	2024-09-15	2024	9	15	Sunday
260	2024-09-16	2024	9	16	Monday
261	2024-09-17	2024	9	17	Tuesday
262	2024-09-18	2024	9	18	Wednesday
263	2024-09-19	2024	9	19	Thursday
264	2024-09-20	2024	9	20	Friday
265	2024-09-21	2024	9	21	Saturday
266	2024-09-22	2024	9	22	Sunday
267	2024-09-23	2024	9	23	Monday
268	2024-09-24	2024	9	24	Tuesday
269	2024-09-25	2024	9	25	Wednesday
270	2024-09-26	2024	9	26	Thursday
271	2024-09-27	2024	9	27	Friday
272	2024-09-28	2024	9	28	Saturday
273	2024-09-29	2024	9	29	Sunday
274	2024-09-30	2024	9	30	Monday
275	2024-10-01	2024	10	1	Tuesday
276	2024-10-02	2024	10	2	Wednesday
277	2024-10-03	2024	10	3	Thursday
278	2024-10-04	2024	10	4	Friday
279	2024-10-05	2024	10	5	Saturday
280	2024-10-06	2024	10	6	Sunday
281	2024-10-07	2024	10	7	Monday
282	2024-10-08	2024	10	8	Tuesday
283	2024-10-09	2024	10	9	Wednesday
284	2024-10-10	2024	10	10	Thursday
285	2024-10-11	2024	10	11	Friday
286	2024-10-12	2024	10	12	Saturday
287	2024-10-13	2024	10	13	Sunday
288	2024-10-14	2024	10	14	Monday
289	2024-10-15	2024	10	15	Tuesday
290	2024-10-16	2024	10	16	Wednesday
291	2024-10-17	2024	10	17	Thursday
292	2024-10-18	2024	10	18	Friday
293	2024-10-19	2024	10	19	Saturday
294	2024-10-20	2024	10	20	Sunday
295	2024-10-21	2024	10	21	Monday
296	2024-10-22	2024	10	22	Tuesday
297	2024-10-23	2024	10	23	Wednesday
298	2024-10-24	2024	10	24	Thursday
299	2024-10-25	2024	10	25	Friday
300	2024-10-26	2024	10	26	Saturday
301	2024-10-27	2024	10	27	Sunday
302	2024-10-28	2024	10	28	Monday
303	2024-10-29	2024	10	29	Tuesday
304	2024-10-30	2024	10	30	Wednesday
305	2024-10-31	2024	10	31	Thursday
306	2024-11-01	2024	11	1	Friday
307	2024-11-02	2024	11	2	Saturday
308	2024-11-03	2024	11	3	Sunday
309	2024-11-04	2024	11	4	Monday
310	2024-11-05	2024	11	5	Tuesday
311	2024-11-06	2024	11	6	Wednesday
312	2024-11-07	2024	11	7	Thursday
313	2024-11-08	2024	11	8	Friday
314	2024-11-09	2024	11	9	Saturday
315	2024-11-10	2024	11	10	Sunday
316	2024-11-11	2024	11	11	Monday
317	2024-11-12	2024	11	12	Tuesday
318	2024-11-13	2024	11	13	Wednesday
319	2024-11-14	2024	11	14	Thursday
320	2024-11-15	2024	11	15	Friday
321	2024-11-16	2024	11	16	Saturday
322	2024-11-17	2024	11	17	Sunday
323	2024-11-18	2024	11	18	Monday
324	2024-11-19	2024	11	19	Tuesday
325	2024-11-20	2024	11	20	Wednesday
326	2024-11-21	2024	11	21	Thursday
327	2024-11-22	2024	11	22	Friday
328	2024-11-23	2024	11	23	Saturday
329	2024-11-24	2024	11	24	Sunday
330	2024-11-25	2024	11	25	Monday
331	2024-11-26	2024	11	26	Tuesday
332	2024-11-27	2024	11	27	Wednesday
333	2024-11-28	2024	11	28	Thursday
334	2024-11-29	2024	11	29	Friday
335	2024-11-30	2024	11	30	Saturday
336	2024-12-01	2024	12	1	Sunday
337	2024-12-02	2024	12	2	Monday
338	2024-12-03	2024	12	3	Tuesday
339	2024-12-04	2024	12	4	Wednesday
340	2024-12-05	2024	12	5	Thursday
341	2024-12-06	2024	12	6	Friday
342	2024-12-07	2024	12	7	Saturday
343	2024-12-08	2024	12	8	Sunday
344	2024-12-09	2024	12	9	Monday
345	2024-12-10	2024	12	10	Tuesday
346	2024-12-11	2024	12	11	Wednesday
347	2024-12-12	2024	12	12	Thursday
348	2024-12-13	2024	12	13	Friday
349	2024-12-14	2024	12	14	Saturday
350	2024-12-15	2024	12	15	Sunday
351	2024-12-16	2024	12	16	Monday
352	2024-12-17	2024	12	17	Tuesday
353	2024-12-18	2024	12	18	Wednesday
354	2024-12-19	2024	12	19	Thursday
355	2024-12-20	2024	12	20	Friday
356	2024-12-21	2024	12	21	Saturday
357	2024-12-22	2024	12	22	Sunday
358	2024-12-23	2024	12	23	Monday
359	2024-12-24	2024	12	24	Tuesday
360	2024-12-25	2024	12	25	Wednesday
361	2024-12-26	2024	12	26	Thursday
362	2024-12-27	2024	12	27	Friday
363	2024-12-28	2024	12	28	Saturday
364	2024-12-29	2024	12	29	Sunday
365	2024-12-30	2024	12	30	Monday
\.


--
-- TOC entry 4941 (class 0 OID 33727)
-- Dependencies: 220
-- Data for Name: dim_kategoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_kategoria (kategoria_id, nazwa_kategorii) FROM stdin;
1	1,Procesory
2	2,Plyty glowne
3	3,Pamieci
4	4,Dyski twarde
5	5,Monitor
6	6,Laptopy
7	7,Banki pamieci
8	8,Procesor (CPU)
9	9,Pamiec RAM
10	10,Dysk SSD
11	11,Dysk HDD
12	12,Karta graficzna (GPU)
13	13,Zasilacz (PSU)
14	14,Naped optyczny (CD/DVD/Bluray)
15	15,Chlodzenie procesora (cooler CPU)
16	16,Wentylator obudowy
17	17,Klawiatura
18	18,Mysz komputerowa
19	19,Glosniki komputerowe
20	20,Mikrofon
21	21,Sluchawki
22	22,Router Wi-Fi
23	23,Karta sieciowa
24	24,Adapter Bluetooth
25	25,Modem
26	26,Drukarka
27	27,Skaner
28	28,Kamera internetowa
29	29,Hub USB
30	30,Przechowywanie danych (Pendrive)
31	31,Dysk zewnetrzny
32	32,Czytnik kart pamieci
33	33,Stacja dokujaca
34	34,UPS (Zasilacz awaryjny)
35	35,Tablet graficzny
36	36,Macierz RAID
37	37,Projektor
38	38,Panel sterujacy (front panel)
39	39,Stacja chlodzaca do laptopa
40	40,Rejestrator obrazu (capture card)
41	41,Macierz dyskowa NAS
42	42,Oprogramowanie BIOS/UEFI
43	43,Adapter do VR (wirtualna rzeczywistosc)
44	44,Stacja robocza (workstation chassis)
45	45,Matryca LCD do laptopa
46	46,Touchpad
47	47,Zewnetrzna karta dzwiekowa
48	48,Kabel HDMI
49	49,Kabel DisplayPort
50	50,Karta rozszerzen PCIe (karta sieciowa)
\.


--
-- TOC entry 4939 (class 0 OID 33720)
-- Dependencies: 218
-- Data for Name: dim_klient; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_klient (klient_id, imie, nazwisko, miasto, ulica, email) FROM stdin;
1	Natalia	Baskiewicz	Poznan	Ratajczaka 11	natbas@gmail.com
2	Tomek	Strozyn	Lawica	Fredry	tomstr@gmail.com
3	Jan	Kowalski	Poznań	Główna 12	email@gmail.com
4	Adam	Kaczmarek	Warszawa	ulica1	1email@gmail.com
5	Agnieszka	Mazur	Kraków	ulica2	2email@gmail.com
6	Krzysztof	Zając	Poznań	ulica3	3email@gmail.com
7	Paulina	Lis	Łódź	ulica4	4email@gmail.com
8	Marek	Grabowski	Wrocław	ulica5	5email@gmail.com
9	Monika	Jankowska	Gdańsk	ulica6	6email@gmail.com
10	Damian	Rutkowski	Szczecin	ulica7	7email@gmail.com
11	Weronika	Malinowska	Lublin	ulica8	8email@gmail.com
12	Łukasz	Górski	Katowice	ulica9	9email@gmail.com
13	Karolina	Piotrowska	Bydgoszcz	ulica10	10email@gmail.com
14	Patryk	Baran	Warszawa	ulica11	11email@gmail.com
15	Aleksandra	Szczepańska	Kraków	ulica12	12email@gmail.com
16	Bartosz	Michalski	Poznań	ulica13	13email@gmail.com
17	Julia	Grabowska	Łódź	ulica14	14email@gmail.com
18	Rafał	Król	Wrocław	ulica15	15email@gmail.com
19	Martyna	Pawlak	Gdańsk	ulica16	16email@gmail.com
20	Grzegorz	Wilk	Szczecin	ulica17	17email@gmail.com
21	Natalia	Kubiak	Lublin	ulica18	18email@gmail.com
22	Paweł	Zawadzki	Katowice	ulica19	19email@gmail.com
23	Dorota	Czarnecka	Bydgoszcz	ulica20	20email@gmail.com
24	Jakub	Kozłowski	Warszawa	ulica21	21email@gmail.com
25	Alicja	Chmielewska	Kraków	ulica22	22email@gmail.com
26	Szymon	Sikorski	Poznań	ulica23	23email@gmail.com
27	Sylwia	Wróbel	Łódź	ulica24	24email@gmail.com
28	Dawid	Głowacki	Wrocław	ulica25	25email@gmail.com
29	Emilia	Ostrowska	Gdańsk	ulica26	26email@gmail.com
30	Grzegorz	Jasiński	Szczecin	ulica27	27email@gmail.com
31	Izabela	Sadowska	Lublin	ulica28	28email@gmail.com
32	Marcin	Stępień	Katowice	ulica29	29email@gmail.com
33	Wiktoria	Borkowska	Bydgoszcz	ulica30	30email@gmail.com
34	Wojciech	Cieślak	Warszawa	ulica31	31email@gmail.com
35	Ewa	Musiał	Kraków	ulica32	32email@gmail.com
36	Kamil	Kalinowski	Poznań	ulica33	33email@gmail.com
37	Justyna	Urban	Łódź	ulica34	34email@gmail.com
38	Daniel	Lisowski	Wrocław	ulica35	35email@gmail.com
39	Amelia	Śliwińska	Gdańsk	ulica36	36email@gmail.com
40	Artur	Błaszczyk	Szczecin	ulica37	37email@gmail.com
41	Oliwia	Wysocka	Lublin	ulica38	38email@gmail.com
42	Przemysław	Sobczak	Katowice	ulica39	39email@gmail.com
43	1_Przemysław	1_Sobczak	1_Katowice	1_ulica	1_email@interia.com
44	2_Anna	2_Nowak	2_Warszawa	2_ulica	2_email@interia.com
45	3_Piotr	3_Kowalski	3_Kraków	3_ulica	3_email@interia.com
46	4_Maria	4_Wiśniewska	4_Poznań	4_ulica	4_email@interia.com
47	5_Tomasz	5_Wójcik	5_Łódź	5_ulica	5_email@interia.com
48	6_Katarzyna	6_Kamińska	6_Wrocław	6_ulica	6_email@interia.com
49	7_Andrzej	7_Lewandowski	7_Gdańsk	7_ulica	7_email@interia.com
50	8_Joanna	8_Dąbrowska	8_Szczecin	8_ulica	8_email@interia.com
\.


--
-- TOC entry 4943 (class 0 OID 33736)
-- Dependencies: 222
-- Data for Name: dim_produkt; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_produkt (produkt_id, nazwa, parametr, cena_brutto, id_kategoria) FROM stdin;
1	Intel Core i5	3.5GHz	800.00	1
2	ASUS PRIME B450	AM4	400.00	2
3	Kingston DDR4	8GB 3200MHz	300.00	3
4	WD Blue SSD	1TB	500.00	4
5	Dell UltraSharp U2723QE	27" 4K UHD	2000.00	5
6	LG 27GP850-B	27" QHD 165Hz	1800.00	5
7	Samsung Smart Monitor M8	32" 4K UHD	2500.00	5
8	ASUS ROG Swift PG32UQX	32" 4K 144Hz	10000.00	5
9	Dell XPS 15	15.6" 4K UHD, i7-12700H, 16GB RAM, 512GB SSD	9000.00	6
10	Apple MacBook Pro	16" M2 Pro, 16GB RAM, 1TB SSD	13000.00	6
11	HP Pavilion 15	15.6" FHD, Ryzen 5 5600H, 8GB RAM, 256GB SSD	3500.00	6
12	Lenovo ThinkPad X1 Carbon	14" WUXGA, i5-1240P, 16GB RAM, 512GB SSD	8500.00	6
13	Kingston FURY Beast	16GB DDR4 3200MHz	350.00	7
14	Corsair Vengeance RGB Pro	32GB DDR4 3600MHz	800.00	7
15	G.SKILL Trident Z Neo	16GB DDR4 3600MHz	450.00	7
16	Crucial Ballistix	8GB DDR4 3000MHz	200.00	7
17	NVIDIA GeForce RTX 4090	24GB GDDR6X	8500.00	12
18	AMD Radeon RX 7900 XT	20GB GDDR6	6000.00	12
19	NVIDIA GeForce RTX 3060	12GB GDDR6	1800.00	12
20	AMD Radeon RX 6600 XT	8GB GDDR6	1500.00	12
21	MSI MAG B550 TOMAHAWK	AM4 ATX DDR4	650.00	2
22	ASUS ROG STRIX Z690-A	LGA1700 ATX DDR5	1300.00	2
23	Gigabyte B450M DS3H	AM4 Micro-ATX DDR4	400.00	2
24	ASRock Z590 Extreme	LGA1200 ATX DDR4	850.00	2
25	Kingston FURY Beast	DDR4 16GB 3200MHz	300.00	3
26	Corsair Vengeance LPX	DDR4 32GB 3600MHz	600.00	3
27	G.SKILL Trident Z Neo	DDR4 64GB 4000MHz	1200.00	3
28	Crucial Ballistix	DDR4 8GB 3000MHz	200.00	3
29	Intel Core i5-13600K	3.5GHz, 14-Core	1400.00	1
30	AMD Ryzen 5 7600X	4.7GHz, 6-Core	1200.00	1
31	Intel Core i7-13700K	3.4GHz, 16-Core	1900.00	1
32	AMD Ryzen 9 7900X	4.7GHz, 12-Core	2200.00	1
33	LG GP70NS50	Zewnętrzny DVD RW	150.00	14
34	Asus BW-16D1HT	Blu-ray Writer 16x	500.00	14
35	Pioneer BDR-XS07S	Zewnętrzny Blu-ray 6x	800.00	14
36	Lite-On iHAS124	Wewnętrzny DVD RW	100.00	14
37	Logitech MX Keys	Bezprzewodowa, podświetlana	400.00	17
38	Razer BlackWidow V3	Mechaniczna, RGB	500.00	17
39	SteelSeries Apex Pro	Mechaniczna, podświetlana	800.00	17
40	Corsair K70 RGB MK.2	Mechaniczna, RGB	600.00	17
41	TP-Link Archer AX50	Dual Band AX3000	450.00	22
42	Asus RT-AX86U	Dual Band AX5700	950.00	22
43	Netgear Nighthawk RAX50	Dual Band AX5400	800.00	22
44	Xiaomi Mi AIoT Router AX3600	Dual Band AX3600	600.00	22
45	TP-Link Archer T4U	AC1200, USB 3.0	120.00	23
46	ASUS PCE-AX58BT	WiFi 6, PCIe	350.00	23
47	Intel Ethernet I225-T1	2.5GbE, PCIe	300.00	23
48	Realtek RTL8153	USB 3.0, Gigabit	80.00	23
49	Canon CanoScan LiDE 400	4800x4800 DPI	500.00	27
50	Epson Perfection V600	6400x9600 DPI	1200.00	27
\.


--
-- TOC entry 4947 (class 0 OID 33760)
-- Dependencies: 226
-- Data for Name: fakt_zamowienie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fakt_zamowienie (zamowienie_id, klient_id, produkt_id, czas_id, ilosc, wartosc, status) FROM stdin;
1	14	32	202	7	4152.17	w trakcie
2	32	46	175	10	4932.21	anulowane
3	25	23	337	1	1439.46	anulowane
4	19	42	352	6	1649.26	w trakcie
5	43	36	47	2	3103.54	zrealizowane
6	31	35	277	2	4847.24	anulowane
7	6	4	287	1	1411.45	anulowane
8	17	6	112	10	2072.74	w trakcie
9	15	44	244	9	3398.74	zrealizowane
10	23	31	353	9	784.95	zrealizowane
11	48	43	336	5	4290.46	w trakcie
12	28	44	265	2	1667.39	anulowane
13	7	25	290	6	4375.63	anulowane
14	21	50	267	10	3401.40	w trakcie
15	14	44	303	10	1105.10	w trakcie
16	36	45	214	9	1171.54	w trakcie
17	3	20	276	6	1519.02	w trakcie
18	47	15	16	6	3909.15	w trakcie
19	21	37	52	3	2108.47	anulowane
20	34	37	56	3	3986.11	zrealizowane
21	33	27	145	3	1956.03	w trakcie
22	23	3	318	6	460.15	w trakcie
23	43	34	206	8	4061.99	w trakcie
24	7	8	343	1	3927.95	zrealizowane
25	6	2	123	7	4356.70	zrealizowane
26	32	1	147	5	1456.43	zrealizowane
27	22	30	116	8	2375.53	zrealizowane
28	36	24	21	5	3772.55	zrealizowane
29	50	3	277	6	1248.77	zrealizowane
30	44	49	216	3	2676.81	anulowane
31	24	47	114	9	1535.08	anulowane
32	50	49	169	9	4065.94	anulowane
33	50	15	124	2	1400.68	anulowane
34	36	48	82	6	4373.68	zrealizowane
35	11	12	326	4	4917.42	zrealizowane
36	48	43	178	1	1149.31	anulowane
37	12	38	36	2	3192.94	w trakcie
38	28	9	59	8	1966.85	anulowane
39	25	12	125	6	1277.02	zrealizowane
40	31	41	71	3	4355.89	zrealizowane
41	8	46	241	9	3429.45	zrealizowane
42	22	42	38	3	2570.34	w trakcie
43	4	17	203	4	3252.48	w trakcie
44	27	29	90	3	2303.55	w trakcie
45	14	8	31	3	3732.08	anulowane
46	23	18	190	7	1668.43	anulowane
47	8	46	140	10	4650.96	zrealizowane
48	12	32	298	9	1600.37	w trakcie
49	3	44	151	7	1859.96	w trakcie
50	13	8	347	6	3410.76	w trakcie
\.


--
-- TOC entry 4958 (class 0 OID 0)
-- Dependencies: 223
-- Name: dim_czas_czas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_czas_czas_id_seq', 365, true);


--
-- TOC entry 4959 (class 0 OID 0)
-- Dependencies: 219
-- Name: dim_kategoria_kategoria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_kategoria_kategoria_id_seq', 58, true);


--
-- TOC entry 4960 (class 0 OID 0)
-- Dependencies: 217
-- Name: dim_klient_klient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_klient_klient_id_seq', 50, true);


--
-- TOC entry 4961 (class 0 OID 0)
-- Dependencies: 221
-- Name: dim_produkt_produkt_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_produkt_produkt_id_seq', 50, true);


--
-- TOC entry 4962 (class 0 OID 0)
-- Dependencies: 225
-- Name: fakt_zamowienie_zamowienie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fakt_zamowienie_zamowienie_id_seq', 50, true);


--
-- TOC entry 4781 (class 2606 OID 33758)
-- Name: dim_czas dim_czas_data_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_czas
    ADD CONSTRAINT dim_czas_data_key UNIQUE (data);


--
-- TOC entry 4783 (class 2606 OID 33756)
-- Name: dim_czas dim_czas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_czas
    ADD CONSTRAINT dim_czas_pkey PRIMARY KEY (czas_id);


--
-- TOC entry 4775 (class 2606 OID 33734)
-- Name: dim_kategoria dim_kategoria_nazwa_kategorii_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_kategoria
    ADD CONSTRAINT dim_kategoria_nazwa_kategorii_key UNIQUE (nazwa_kategorii);


--
-- TOC entry 4777 (class 2606 OID 33732)
-- Name: dim_kategoria dim_kategoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_kategoria
    ADD CONSTRAINT dim_kategoria_pkey PRIMARY KEY (kategoria_id);


--
-- TOC entry 4773 (class 2606 OID 33725)
-- Name: dim_klient dim_klient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_klient
    ADD CONSTRAINT dim_klient_pkey PRIMARY KEY (klient_id);


--
-- TOC entry 4779 (class 2606 OID 33742)
-- Name: dim_produkt dim_produkt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_produkt
    ADD CONSTRAINT dim_produkt_pkey PRIMARY KEY (produkt_id);


--
-- TOC entry 4785 (class 2606 OID 33767)
-- Name: fakt_zamowienie fakt_zamowienie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fakt_zamowienie
    ADD CONSTRAINT fakt_zamowienie_pkey PRIMARY KEY (zamowienie_id);


--
-- TOC entry 4786 (class 1259 OID 33785)
-- Name: idx_fakt_czas; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fakt_czas ON public.fakt_zamowienie USING btree (czas_id);


--
-- TOC entry 4787 (class 1259 OID 33783)
-- Name: idx_fakt_klient; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fakt_klient ON public.fakt_zamowienie USING btree (klient_id);


--
-- TOC entry 4788 (class 1259 OID 33784)
-- Name: idx_fakt_produkt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fakt_produkt ON public.fakt_zamowienie USING btree (produkt_id);


--
-- TOC entry 4789 (class 2606 OID 33743)
-- Name: dim_produkt dim_produkt_id_kategoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_produkt
    ADD CONSTRAINT dim_produkt_id_kategoria_fkey FOREIGN KEY (id_kategoria) REFERENCES public.dim_kategoria(kategoria_id);


--
-- TOC entry 4790 (class 2606 OID 33778)
-- Name: fakt_zamowienie fakt_zamowienie_czas_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fakt_zamowienie
    ADD CONSTRAINT fakt_zamowienie_czas_id_fkey FOREIGN KEY (czas_id) REFERENCES public.dim_czas(czas_id);


--
-- TOC entry 4791 (class 2606 OID 33768)
-- Name: fakt_zamowienie fakt_zamowienie_klient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fakt_zamowienie
    ADD CONSTRAINT fakt_zamowienie_klient_id_fkey FOREIGN KEY (klient_id) REFERENCES public.dim_klient(klient_id);


--
-- TOC entry 4792 (class 2606 OID 33773)
-- Name: fakt_zamowienie fakt_zamowienie_produkt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fakt_zamowienie
    ADD CONSTRAINT fakt_zamowienie_produkt_id_fkey FOREIGN KEY (produkt_id) REFERENCES public.dim_produkt(produkt_id);


-- Completed on 2025-08-14 12:54:00

--
-- PostgreSQL database dump complete
--

