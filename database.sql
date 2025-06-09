--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

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

--
-- Name: recalculate_university_ratings(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.recalculate_university_ratings() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE university
    SET
        rating = (
            SELECT ROUND(AVG(r.rating)::numeric, 1)
            FROM reviews r
            WHERE r.university_id = NEW.university_id
        ),
        avg_education_rating = (
            SELECT ROUND(AVG(r.education_rating)::numeric, 1)
            FROM reviews r
            WHERE r.university_id = NEW.university_id
        ),
        avg_food_rating = (
            SELECT ROUND(AVG(r.food_rating)::numeric, 1)
            FROM reviews r
            WHERE r.university_id = NEW.university_id
        ),
        avg_life_rating = (
            SELECT ROUND(AVG(r.life_rating)::numeric, 1)
            FROM reviews r
            WHERE r.university_id = NEW.university_id
        ),
        avg_teachers_rating = (
            SELECT ROUND(AVG(r.teachers_rating)::numeric, 1)
            FROM reviews r
            WHERE r.university_id = NEW.university_id
        )
    WHERE id = NEW.university_id;

    RETURN NULL;
END;
$$;


ALTER FUNCTION public.recalculate_university_ratings() OWNER TO postgres;

--
-- Name: update_timestamp(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_timestamp() OWNER TO postgres;

--
-- Name: update_university_rating(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_university_rating() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    avg_rating numeric;
BEGIN
    -- Вычисляем средний рейтинг только один раз
    SELECT AVG(rating) INTO avg_rating
    FROM reviews
    WHERE university_id = COALESCE(NEW.university_id, OLD.university_id);
    
    -- Обновляем рейтинг вуза
    UPDATE university
    SET rating = ROUND(avg_rating, 1)
    WHERE id = COALESCE(NEW.university_id, OLD.university_id);
    
    RETURN COALESCE(NEW, OLD);
END;
$$;


ALTER FUNCTION public.update_university_rating() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: faculties; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.faculties (
    id bigint NOT NULL,
    university_id bigint,
    name character varying(255) NOT NULL,
    description text,
    dean_name character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.faculties OWNER TO postgres;

--
-- Name: faculties_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.faculties_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.faculties_id_seq OWNER TO postgres;

--
-- Name: faculties_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.faculties_id_seq OWNED BY public.faculties.id;


--
-- Name: program; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.program (
    id bigint NOT NULL,
    university_id bigint,
    faculty_id bigint,
    name character varying(255) NOT NULL,
    degree character varying(255) NOT NULL,
    duration integer,
    description character varying(255),
    tuition_fee double precision,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.program OWNER TO postgres;

--
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    id bigint NOT NULL,
    university_id bigint,
    author character varying(255),
    rating double precision NOT NULL,
    text character varying(255) NOT NULL,
    created_at character varying(255) DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    education_rating double precision,
    food_rating double precision,
    life_rating double precision,
    teachers_rating double precision,
    CONSTRAINT reviews_rating_check CHECK (((rating >= ((1)::numeric)::double precision) AND (rating <= ((5)::numeric)::double precision)))
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reviews_id_seq OWNER TO postgres;

--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: study_programs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.study_programs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.study_programs_id_seq OWNER TO postgres;

--
-- Name: study_programs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.study_programs_id_seq OWNED BY public.program.id;


--
-- Name: university; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.university (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    city character varying(255) NOT NULL,
    description character varying(255),
    foundation_year integer,
    address character varying(255),
    phone character varying(255),
    email character varying(255),
    website character varying(255),
    students_count bigint,
    faculties_count integer,
    programs_count integer,
    teachers_count bigint,
    has_dormitory boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    speciality character varying(255),
    map_source character varying(255),
    rating double precision,
    avg_education_rating double precision,
    avg_food_rating double precision,
    avg_life_rating double precision,
    avg_teachers_rating double precision,
    avg_rating double precision,
    image character varying(255)
);


ALTER TABLE public.university OWNER TO postgres;

--
-- Name: universities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.universities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.universities_id_seq OWNER TO postgres;

--
-- Name: universities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.universities_id_seq OWNED BY public.university.id;


--
-- Name: faculties id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculties ALTER COLUMN id SET DEFAULT nextval('public.faculties_id_seq'::regclass);


--
-- Name: program id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program ALTER COLUMN id SET DEFAULT nextval('public.study_programs_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: university id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.university ALTER COLUMN id SET DEFAULT nextval('public.universities_id_seq'::regclass);


--
-- Data for Name: faculties; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.faculties (id, university_id, name, description, dean_name, created_at) FROM stdin;
1	1	Механико-математический факультет	Один из ведущих математических факультетов мира	\N	2025-06-05 01:52:19.974672
2	1	Факультет вычислительной математики и кибернетики	Готовит специалистов в области IT и компьютерных наук	\N	2025-06-05 01:52:19.974672
3	1	Физический факультет	Ведущий центр физического образования и исследований	\N	2025-06-05 01:52:19.974672
4	2	Факультет при Санкт-Петербургский государственный университет	\N	\N	2025-06-09 15:59:18.579265
5	3	Факультет при Московский физико-технический институт	\N	\N	2025-06-09 15:59:18.579265
6	4	Факультет при Национальный исследовательский университет "Высшая школа экономики"	\N	\N	2025-06-09 15:59:18.579265
7	1	Факультет при Московский государственный университет им. М.В. Ломоносова	\N	\N	2025-06-09 15:59:18.579265
8	5	Факультет при Московский государственный институт международных отношений	\N	\N	2025-06-09 15:59:18.579265
9	6	Факультет при Новосибирский национальный исследовательский государственный университет	\N	\N	2025-06-09 15:59:18.579265
10	7	Факультет при Уральский федеральный университет	\N	\N	2025-06-09 15:59:18.579265
11	8	Факультет при Казанский федеральный университет	\N	\N	2025-06-09 15:59:18.579265
12	9	Факультет при Национальный исследовательский ядерный университет "МИФИ"	\N	\N	2025-06-09 15:59:18.579265
13	10	Факультет при Томский государственный университет	\N	\N	2025-06-09 15:59:18.579265
14	2	Факультет при Санкт-Петербургский государственный университет	\N	\N	2025-06-09 15:59:59.206971
15	3	Факультет при Московский физико-технический институт	\N	\N	2025-06-09 15:59:59.206971
16	4	Факультет при Национальный исследовательский университет "Высшая школа экономики"	\N	\N	2025-06-09 15:59:59.206971
17	1	Факультет при Московский государственный университет им. М.В. Ломоносова	\N	\N	2025-06-09 15:59:59.206971
18	5	Факультет при Московский государственный институт международных отношений	\N	\N	2025-06-09 15:59:59.206971
19	6	Факультет при Новосибирский национальный исследовательский государственный университет	\N	\N	2025-06-09 15:59:59.206971
20	7	Факультет при Уральский федеральный университет	\N	\N	2025-06-09 15:59:59.206971
21	8	Факультет при Казанский федеральный университет	\N	\N	2025-06-09 15:59:59.206971
22	9	Факультет при Национальный исследовательский ядерный университет "МИФИ"	\N	\N	2025-06-09 15:59:59.206971
23	10	Факультет при Томский государственный университет	\N	\N	2025-06-09 15:59:59.206971
24	2	Факультет при Санкт-Петербургский государственный университет	\N	\N	2025-06-09 16:42:13.987423
25	3	Факультет при Московский физико-технический институт	\N	\N	2025-06-09 16:42:13.987423
26	4	Факультет при Национальный исследовательский университет "Высшая школа экономики"	\N	\N	2025-06-09 16:42:13.987423
27	1	Факультет при Московский государственный университет им. М.В. Ломоносова	\N	\N	2025-06-09 16:42:13.987423
28	5	Факультет при Московский государственный институт международных отношений	\N	\N	2025-06-09 16:42:13.987423
29	6	Факультет при Новосибирский национальный исследовательский государственный университет	\N	\N	2025-06-09 16:42:13.987423
30	7	Факультет при Уральский федеральный университет	\N	\N	2025-06-09 16:42:13.987423
31	8	Факультет при Казанский федеральный университет	\N	\N	2025-06-09 16:42:13.987423
32	9	Факультет при Национальный исследовательский ядерный университет "МИФИ"	\N	\N	2025-06-09 16:42:13.987423
33	10	Факультет при Томский государственный университет	\N	\N	2025-06-09 16:42:13.987423
\.


--
-- Data for Name: program; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.program (id, university_id, faculty_id, name, degree, duration, description, tuition_fee, created_at) FROM stdin;
125	2	24	Физика	бакалавр	4	Фундаментальное изучение физических процессов	160000	2025-06-09 16:42:13.987423
126	2	24	Математика и компьютерные науки	бакалавр	4	Современные методы в программировании и аналитике	155000	2025-06-09 16:42:13.987423
127	2	24	Международные отношения	бакалавр	4	Подготовка специалистов внешней политики	165000	2025-06-09 16:42:13.987423
128	2	24	Экономика	бакалавр	4	Финансовая аналитика и макроэкономика	158000	2025-06-09 16:42:13.987423
129	2	24	Юриспруденция	бакалавр	4	Правовые дисциплины и судебная практика	162000	2025-06-09 16:42:13.987423
130	3	25	Физика	бакалавр	4	Фундаментальное изучение физических процессов	160000	2025-06-09 16:42:13.987423
131	3	25	Математика и компьютерные науки	бакалавр	4	Современные методы в программировании и аналитике	155000	2025-06-09 16:42:13.987423
132	3	25	Международные отношения	бакалавр	4	Подготовка специалистов внешней политики	165000	2025-06-09 16:42:13.987423
133	3	25	Экономика	бакалавр	4	Финансовая аналитика и макроэкономика	158000	2025-06-09 16:42:13.987423
134	3	25	Юриспруденция	бакалавр	4	Правовые дисциплины и судебная практика	162000	2025-06-09 16:42:13.987423
135	4	26	Физика	бакалавр	4	Фундаментальное изучение физических процессов	160000	2025-06-09 16:42:13.987423
136	4	26	Математика и компьютерные науки	бакалавр	4	Современные методы в программировании и аналитике	155000	2025-06-09 16:42:13.987423
137	4	26	Международные отношения	бакалавр	4	Подготовка специалистов внешней политики	165000	2025-06-09 16:42:13.987423
138	4	26	Экономика	бакалавр	4	Финансовая аналитика и макроэкономика	158000	2025-06-09 16:42:13.987423
139	4	26	Юриспруденция	бакалавр	4	Правовые дисциплины и судебная практика	162000	2025-06-09 16:42:13.987423
140	1	27	Физика	бакалавр	4	Фундаментальное изучение физических процессов	160000	2025-06-09 16:42:13.987423
141	1	27	Математика и компьютерные науки	бакалавр	4	Современные методы в программировании и аналитике	155000	2025-06-09 16:42:13.987423
142	1	27	Международные отношения	бакалавр	4	Подготовка специалистов внешней политики	165000	2025-06-09 16:42:13.987423
143	1	27	Экономика	бакалавр	4	Финансовая аналитика и макроэкономика	158000	2025-06-09 16:42:13.987423
144	1	27	Юриспруденция	бакалавр	4	Правовые дисциплины и судебная практика	162000	2025-06-09 16:42:13.987423
145	5	28	Физика	бакалавр	4	Фундаментальное изучение физических процессов	160000	2025-06-09 16:42:13.987423
146	5	28	Математика и компьютерные науки	бакалавр	4	Современные методы в программировании и аналитике	155000	2025-06-09 16:42:13.987423
147	5	28	Международные отношения	бакалавр	4	Подготовка специалистов внешней политики	165000	2025-06-09 16:42:13.987423
148	5	28	Экономика	бакалавр	4	Финансовая аналитика и макроэкономика	158000	2025-06-09 16:42:13.987423
149	5	28	Юриспруденция	бакалавр	4	Правовые дисциплины и судебная практика	162000	2025-06-09 16:42:13.987423
150	6	29	Физика	бакалавр	4	Фундаментальное изучение физических процессов	160000	2025-06-09 16:42:13.987423
151	6	29	Математика и компьютерные науки	бакалавр	4	Современные методы в программировании и аналитике	155000	2025-06-09 16:42:13.987423
152	6	29	Международные отношения	бакалавр	4	Подготовка специалистов внешней политики	165000	2025-06-09 16:42:13.987423
153	6	29	Экономика	бакалавр	4	Финансовая аналитика и макроэкономика	158000	2025-06-09 16:42:13.987423
154	6	29	Юриспруденция	бакалавр	4	Правовые дисциплины и судебная практика	162000	2025-06-09 16:42:13.987423
155	7	30	Физика	бакалавр	4	Фундаментальное изучение физических процессов	160000	2025-06-09 16:42:13.987423
156	7	30	Математика и компьютерные науки	бакалавр	4	Современные методы в программировании и аналитике	155000	2025-06-09 16:42:13.987423
157	7	30	Международные отношения	бакалавр	4	Подготовка специалистов внешней политики	165000	2025-06-09 16:42:13.987423
158	7	30	Экономика	бакалавр	4	Финансовая аналитика и макроэкономика	158000	2025-06-09 16:42:13.987423
159	7	30	Юриспруденция	бакалавр	4	Правовые дисциплины и судебная практика	162000	2025-06-09 16:42:13.987423
160	8	31	Физика	бакалавр	4	Фундаментальное изучение физических процессов	160000	2025-06-09 16:42:13.987423
161	8	31	Математика и компьютерные науки	бакалавр	4	Современные методы в программировании и аналитике	155000	2025-06-09 16:42:13.987423
162	8	31	Международные отношения	бакалавр	4	Подготовка специалистов внешней политики	165000	2025-06-09 16:42:13.987423
163	8	31	Экономика	бакалавр	4	Финансовая аналитика и макроэкономика	158000	2025-06-09 16:42:13.987423
164	8	31	Юриспруденция	бакалавр	4	Правовые дисциплины и судебная практика	162000	2025-06-09 16:42:13.987423
165	9	32	Физика	бакалавр	4	Фундаментальное изучение физических процессов	160000	2025-06-09 16:42:13.987423
166	9	32	Математика и компьютерные науки	бакалавр	4	Современные методы в программировании и аналитике	155000	2025-06-09 16:42:13.987423
167	9	32	Международные отношения	бакалавр	4	Подготовка специалистов внешней политики	165000	2025-06-09 16:42:13.987423
168	9	32	Экономика	бакалавр	4	Финансовая аналитика и макроэкономика	158000	2025-06-09 16:42:13.987423
169	9	32	Юриспруденция	бакалавр	4	Правовые дисциплины и судебная практика	162000	2025-06-09 16:42:13.987423
170	10	33	Физика	бакалавр	4	Фундаментальное изучение физических процессов	160000	2025-06-09 16:42:13.987423
171	10	33	Математика и компьютерные науки	бакалавр	4	Современные методы в программировании и аналитике	155000	2025-06-09 16:42:13.987423
172	10	33	Международные отношения	бакалавр	4	Подготовка специалистов внешней политики	165000	2025-06-09 16:42:13.987423
173	10	33	Экономика	бакалавр	4	Финансовая аналитика и макроэкономика	158000	2025-06-09 16:42:13.987423
174	10	33	Юриспруденция	бакалавр	4	Правовые дисциплины и судебная практика	162000	2025-06-09 16:42:13.987423
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (id, university_id, author, rating, text, created_at, updated_at, education_rating, food_rating, life_rating, teachers_rating) FROM stdin;
3	2	Мария Сидорова	5	Прекрасная атмосфера и высокий уровень преподавания!	2025-06-05 01:52:19.98149	2025-06-05 01:52:19.98149	\N	\N	\N	\N
4	\N		5	fsdf	2025-06-05 16:54:09.657377+03	2025-06-05 16:54:09.727807	\N	\N	\N	\N
5	\N		5	fsdf	2025-06-05 16:55:31.120253+03	2025-06-05 16:55:31.156691	\N	\N	\N	\N
6	\N		5	fsdf	2025-06-05 16:56:49.744519+03	2025-06-05 16:56:49.782439	\N	\N	\N	\N
7	\N		5	dasda	2025-06-05 16:57:41.008483+03	2025-06-05 16:57:41.043621	\N	\N	\N	\N
8	\N		5	dasda	2025-06-05 16:59:06.437005+03	2025-06-05 16:59:06.499921	\N	\N	\N	\N
9	\N		5	dasda	2025-06-05 16:59:10.046651+03	2025-06-05 16:59:10.050351	\N	\N	\N	\N
10	\N		5	dasda	2025-06-05 16:59:28.070317+03	2025-06-05 16:59:28.07323	\N	\N	\N	\N
11	\N		5	dasda	2025-06-05 17:02:05.258835+03	2025-06-05 17:02:05.303	\N	\N	\N	\N
12	\N		5	fghjk	2025-06-05 17:02:18.931487+03	2025-06-05 17:02:18.934685	\N	\N	\N	\N
2	\N	gdsfa	4	sada	2025-06-05 01:52:19.98149	2025-06-06 12:56:14.140112	\N	\N	\N	\N
1	\N	hbjsad	5	fsd	2025-06-05 01:52:19.98149	2025-06-06 13:46:51.673947	\N	\N	\N	\N
13	1	hfbj	5	fcgbnml	2025-06-06 13:55:06.747848+03	2025-06-06 13:55:06.763292	\N	\N	\N	\N
14	1	Даня	1	Хуйня	2025-06-06 13:55:49.526321+03	2025-06-06 13:55:49.527128	\N	\N	\N	\N
16	1	Даша	1	КАААл	2025-06-06 14:01:49.869584+03	2025-06-06 14:01:49.870342	\N	\N	\N	\N
17	1	Nj[f	3	Fxt	2025-06-06 14:04:13.696958+03	2025-06-06 14:04:13.698205	\N	\N	\N	\N
18	1	fdsjfns	5	hbasd	2025-06-06 14:05:16.15898+03	2025-06-06 14:05:16.15977	\N	\N	\N	\N
19	1	anbsdasjda	1	rffffk	2025-06-06 14:05:43.660935+03	2025-06-06 14:05:43.661736	\N	\N	\N	\N
20	3	gege	5	ghjkjl	2025-06-09 17:19:10.263625+03	2025-06-09 17:19:10.278485	\N	\N	\N	\N
21	3	edjsad	5	esrdtfgbhj	2025-06-09 17:25:17.517671+03	2025-06-09 17:25:17.533824	5	5	5	5
31	4	sfds	5	fsnjlk	2025-06-09 18:28:27.202086+03	2025-06-09 18:28:27.218414	5	5	5	5
32	4	sdkjjk	1	hghsbja	2025-06-09 19:12:23.445537+03	2025-06-09 19:12:23.458778	1	1	1	1
\.


--
-- Data for Name: university; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.university (id, name, city, description, foundation_year, address, phone, email, website, students_count, faculties_count, programs_count, teachers_count, has_dormitory, created_at, updated_at, speciality, map_source, rating, avg_education_rating, avg_food_rating, avg_life_rating, avg_teachers_rating, avg_rating, image) FROM stdin;
4	Национальный исследовательский университет "Высшая школа экономики"	Москва	Ведущий университет в области социально-экономических наук.	1992	Мясницкая ул., 20	\N	\N	https://www.hse.ru	44000	28	272	1571	f	2025-06-05 01:52:06.950897	2025-06-09 20:31:23.941072	\N	https://api-maps.yandex.ru/services/constructor/1.0/js/?um=constructor%3Acaeca31edee712bc80aa5695dba3a38136d5781ebd519165c0af30417c4f2f27&amp;width=400&amp;height=400&amp;lang=ru_RU&amp;scroll=true	3	3	3	3	3	\N	/static/hse.png
2	Санкт-Петербургский государственный университет	Санкт-Петербург	Один из крупнейших и старейших университетов России, основанный в 1724 году.	1724	Университетская наб., 7-9	\N	\N	https://spbu.ru	33000	24	323	1375	f	2025-06-05 01:52:06.950897	2025-06-09 20:31:23.941072	\N	https://api-maps.yandex.ru/services/constructor/1.0/js/?um=constructor%3Acaeca31edee712bc80aa5695dba3a38136d5781ebd519165c0af30417c4f2f27&amp;width=400&amp;height=400&amp;lang=ru_RU&amp;scroll=true	3	\N	\N	\N	\N	\N	/static/hse.png
5	Московский государственный институт международных отношений	Москва	Ведущий вуз России по подготовке специалистов международного профиля.	1944	пр. Вернадского, 76	\N	\N	https://mgimo.ru	7000	8	22	875	f	2025-06-05 01:52:06.950897	2025-06-09 20:31:23.941072	\N	https://api-maps.yandex.ru/services/constructor/1.0/js/?um=constructor%3Acaeca31edee712bc80aa5695dba3a38136d5781ebd519165c0af30417c4f2f27&amp;width=400&amp;height=400&amp;lang=ru_RU&amp;scroll=true	3	\N	\N	\N	\N	\N	/static/hse.png
6	Новосибирский национальный исследовательский государственный университет	Новосибирск	Флагманский университет Сибири, тесно связанный с Академгородком.	1959	ул. Пирогова, 1	\N	\N	https://www.nsu.ru	7200	13	115	553	f	2025-06-05 01:52:06.950897	2025-06-09 20:31:23.941072	\N	https://api-maps.yandex.ru/services/constructor/1.0/js/?um=constructor%3Acaeca31edee712bc80aa5695dba3a38136d5781ebd519165c0af30417c4f2f27&amp;width=400&amp;height=400&amp;lang=ru_RU&amp;scroll=true	3	\N	\N	\N	\N	\N	/static/hse.png
7	Уральский федеральный университет	Екатеринбург	Крупнейший университет Уральского региона.	1920	ул. Мира, 19	\N	\N	https://urfu.ru	35000	18	400	1944	f	2025-06-05 01:52:06.950897	2025-06-09 20:31:23.941072	\N	https://api-maps.yandex.ru/services/constructor/1.0/js/?um=constructor%3Acaeca31edee712bc80aa5695dba3a38136d5781ebd519165c0af30417c4f2f27&amp;width=400&amp;height=400&amp;lang=ru_RU&amp;scroll=true	3	\N	\N	\N	\N	\N	/static/hse.png
8	Казанский федеральный университет	Казань	Один из старейших университетов России, основанный в 1804 году.	1804	ул. Кремлевская, 18	\N	\N	https://kpfu.ru	45000	19	300	2368	f	2025-06-05 01:52:06.950897	2025-06-09 20:31:23.941072	\N	https://api-maps.yandex.ru/services/constructor/1.0/js/?um=constructor%3Acaeca31edee712bc80aa5695dba3a38136d5781ebd519165c0af30417c4f2f27&amp;width=400&amp;height=400&amp;lang=ru_RU&amp;scroll=true	3	\N	\N	\N	\N	\N	/static/hse.png
9	Национальный исследовательский ядерный университет "МИФИ"	Москва	Ведущий вуз в области ядерной физики и технологий.	1942	Каширское ш., 31	\N	\N	https://mephi.ru	8500	10	70	850	f	2025-06-05 01:52:06.950897	2025-06-09 20:31:23.941072	\N	https://api-maps.yandex.ru/services/constructor/1.0/js/?um=constructor%3Acaeca31edee712bc80aa5695dba3a38136d5781ebd519165c0af30417c4f2f27&amp;width=400&amp;height=400&amp;lang=ru_RU&amp;scroll=true	3	\N	\N	\N	\N	\N	/static/hse.png
1	Московский государственный университет им. М.В. Ломоносова	Москва	Старейший и самый престижный университет России, основанный в 1755 году.	1755	Ленинские горы, 1	\N	\N	https://www.msu.ru	47000	43	380	1093	f	2025-06-05 01:52:06.950897	2025-06-09 20:31:23.941072	\N	https://api-maps.yandex.ru/services/constructor/1.0/js/?um=constructor%3Acaeca31edee712bc80aa5695dba3a38136d5781ebd519165c0af30417c4f2f27&amp;width=400&amp;height=400&amp;lang=ru_RU&amp;scroll=true	3	\N	\N	\N	\N	\N	/static/hse.png
3	Московский физико-технический институт	Долгопрудный	Ведущий технический вуз России, известный своей системой подготовки "Физтех".	1946	Институтский пер., 9	\N	\N	https://mipt.ru	6200	11	90	563	f	2025-06-05 01:52:06.950897	2025-06-09 20:31:23.941072	\N	https://api-maps.yandex.ru/services/constructor/1.0/js/?um=constructor%3Acaeca31edee712bc80aa5695dba3a38136d5781ebd519165c0af30417c4f2f27&amp;width=400&amp;height=400&amp;lang=ru_RU&amp;scroll=true	3	\N	\N	\N	\N	\N	/static/hse.png
10	Томский государственный университет	Томск	Первый университет в азиатской части России, основанный в 1878 году.	1878	пр. Ленина, 36	\N	\N	https://www.tsu.ru	23000	23	150	1000	f	2025-06-05 01:52:06.950897	2025-06-09 20:31:23.941072	\N	https://api-maps.yandex.ru/services/constructor/1.0/js/?um=constructor%3Acaeca31edee712bc80aa5695dba3a38136d5781ebd519165c0af30417c4f2f27&amp;width=400&amp;height=400&amp;lang=ru_RU&amp;scroll=true	3	\N	\N	\N	\N	\N	/static/hse.png
\.


--
-- Name: faculties_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faculties_id_seq', 33, true);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reviews_id_seq', 32, true);


--
-- Name: study_programs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.study_programs_id_seq', 174, true);


--
-- Name: universities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.universities_id_seq', 10, true);


--
-- Name: faculties faculties_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculties
    ADD CONSTRAINT faculties_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: program study_programs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program
    ADD CONSTRAINT study_programs_pkey PRIMARY KEY (id);


--
-- Name: university universities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.university
    ADD CONSTRAINT universities_pkey PRIMARY KEY (id);


--
-- Name: idx_universities_city; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_universities_city ON public.university USING btree (city);


--
-- Name: reviews trigger_recalculate_university_ratings; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_recalculate_university_ratings AFTER INSERT OR DELETE OR UPDATE ON public.reviews FOR EACH ROW EXECUTE FUNCTION public.recalculate_university_ratings();


--
-- Name: reviews update_reviews_timestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_reviews_timestamp BEFORE UPDATE ON public.reviews FOR EACH ROW EXECUTE FUNCTION public.update_timestamp();


--
-- Name: university update_universities_timestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_universities_timestamp BEFORE UPDATE ON public.university FOR EACH ROW EXECUTE FUNCTION public.update_timestamp();


--
-- Name: faculties faculties_university_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculties
    ADD CONSTRAINT faculties_university_id_fkey FOREIGN KEY (university_id) REFERENCES public.university(id) ON DELETE CASCADE;


--
-- Name: reviews reviews_university_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_university_id_fkey FOREIGN KEY (university_id) REFERENCES public.university(id) ON DELETE CASCADE;


--
-- Name: program study_programs_faculty_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program
    ADD CONSTRAINT study_programs_faculty_id_fkey FOREIGN KEY (faculty_id) REFERENCES public.faculties(id) ON DELETE SET NULL;


--
-- Name: program study_programs_university_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program
    ADD CONSTRAINT study_programs_university_id_fkey FOREIGN KEY (university_id) REFERENCES public.university(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

