--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0
-- Dumped by pg_dump version 16.0

-- Started on 2024-05-15 09:23:24

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = on;

SET SESSION AUTHORIZATION 'postgres';

DROP DATABASE IF EXISTS "briefing";
--
-- TOC entry 4921 (class 1262 OID 17378)
-- Name: briefing; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "briefing" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';


\connect "briefing"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = on;

SET SESSION AUTHORIZATION 'pg_database_owner';

--
-- TOC entry 4922 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA "public"; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA "public" IS 'standard public schema';


SET SESSION AUTHORIZATION 'postgres';

--
-- TOC entry 887 (class 1247 OID 17477)
-- Name: briefing_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE "public"."briefing_status" AS ENUM (
    'открыто',
    'закрыто'
);


--
-- TOC entry 863 (class 1247 OID 17380)
-- Name: user_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE "public"."user_status" AS ENUM (
    'student',
    'teacher'
);


--
-- TOC entry 890 (class 1247 OID 17482)
-- Name: verification_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE "public"."verification_type" AS ENUM (
    'вручную',
    'автоматически'
);


SET default_tablespace = '';

SET default_table_access_method = "heap";

--
-- TOC entry 235 (class 1259 OID 17527)
-- Name: answer_student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."answer_student" (
    "id" integer NOT NULL,
    "id_student" integer NOT NULL,
    "id_question" integer NOT NULL,
    "text" character varying(255),
    "accuracy_percent" numeric(5,2),
    CONSTRAINT "answer_student_accuracy_percent_check" CHECK ((("accuracy_percent" >= (0)::numeric) AND ("accuracy_percent" <= (100)::numeric)))
);


--
-- TOC entry 234 (class 1259 OID 17526)
-- Name: answer_student_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "public"."answer_student_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4924 (class 0 OID 0)
-- Dependencies: 234
-- Name: answer_student_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "public"."answer_student_id_seq" OWNED BY "public"."answer_student"."id";


--
-- TOC entry 230 (class 1259 OID 17488)
-- Name: briefing; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."briefing" (
    "id" integer NOT NULL,
    "id_subject" integer NOT NULL,
    "number" integer NOT NULL,
    "title" character varying(255) NOT NULL,
    "duration" interval NOT NULL,
    "status" character varying(255)
);


--
-- TOC entry 229 (class 1259 OID 17487)
-- Name: briefing_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "public"."briefing_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4926 (class 0 OID 0)
-- Dependencies: 229
-- Name: briefing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "public"."briefing_id_seq" OWNED BY "public"."briefing"."id";


--
-- TOC entry 216 (class 1259 OID 17386)
-- Name: loginmoodle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."loginmoodle" (
    "id" integer NOT NULL,
    "login" character varying(255) NOT NULL,
    "status" character varying(255)
);


--
-- TOC entry 215 (class 1259 OID 17385)
-- Name: loginmoodle_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "public"."loginmoodle_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4928 (class 0 OID 0)
-- Dependencies: 215
-- Name: loginmoodle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "public"."loginmoodle_id_seq" OWNED BY "public"."loginmoodle"."id";


--
-- TOC entry 228 (class 1259 OID 17458)
-- Name: news; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."news" (
    "id" integer NOT NULL,
    "date_start" timestamp(6) without time zone NOT NULL,
    "text" character varying(255) NOT NULL,
    "id_teacher" integer NOT NULL,
    "id_profile" integer NOT NULL
);


--
-- TOC entry 227 (class 1259 OID 17457)
-- Name: news_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "public"."news_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4930 (class 0 OID 0)
-- Dependencies: 227
-- Name: news_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "public"."news_id_seq" OWNED BY "public"."news"."id";


--
-- TOC entry 237 (class 1259 OID 17547)
-- Name: plagiat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."plagiat" (
    "id" integer NOT NULL,
    "id_answer_student1" integer NOT NULL,
    "id_answer_student2" integer NOT NULL
);


--
-- TOC entry 236 (class 1259 OID 17546)
-- Name: plagiat_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "public"."plagiat_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4932 (class 0 OID 0)
-- Dependencies: 236
-- Name: plagiat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "public"."plagiat_id_seq" OWNED BY "public"."plagiat"."id";


--
-- TOC entry 218 (class 1259 OID 17393)
-- Name: profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."profile" (
    "id" integer NOT NULL,
    "title" character varying(255) NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 17392)
-- Name: profile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "public"."profile_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4934 (class 0 OID 0)
-- Dependencies: 217
-- Name: profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "public"."profile_id_seq" OWNED BY "public"."profile"."id";


--
-- TOC entry 233 (class 1259 OID 17513)
-- Name: profilebriefing; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."profilebriefing" (
    "id_profile" integer NOT NULL,
    "id_briefing" integer NOT NULL,
    "id" integer NOT NULL
);


--
-- TOC entry 238 (class 1259 OID 17588)
-- Name: profilebriefing_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "public"."profilebriefing_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4936 (class 0 OID 0)
-- Dependencies: 238
-- Name: profilebriefing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "public"."profilebriefing_id_seq" OWNED BY "public"."profilebriefing"."id";


--
-- TOC entry 232 (class 1259 OID 17500)
-- Name: question; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."question" (
    "id" integer NOT NULL,
    "id_briefing" integer NOT NULL,
    "text" character varying(255) NOT NULL,
    "type_verification" character varying(255),
    "answer" character varying(255) NOT NULL
);


--
-- TOC entry 231 (class 1259 OID 17499)
-- Name: question_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "public"."question_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4938 (class 0 OID 0)
-- Dependencies: 231
-- Name: question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "public"."question_id_seq" OWNED BY "public"."question"."id";


--
-- TOC entry 222 (class 1259 OID 17412)
-- Name: student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."student" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "surname" character varying(255) NOT NULL,
    "patronymic" character varying(255),
    "id_group" integer NOT NULL,
    "id_login" integer NOT NULL
);


--
-- TOC entry 221 (class 1259 OID 17411)
-- Name: student_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "public"."student_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4940 (class 0 OID 0)
-- Dependencies: 221
-- Name: student_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "public"."student_id_seq" OWNED BY "public"."student"."id";


--
-- TOC entry 226 (class 1259 OID 17441)
-- Name: subject; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."subject" (
    "id" integer NOT NULL,
    "title" character varying(255) NOT NULL,
    "id_teacher" integer NOT NULL,
    "id_profile" integer NOT NULL
);


--
-- TOC entry 225 (class 1259 OID 17440)
-- Name: subject_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "public"."subject_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4942 (class 0 OID 0)
-- Dependencies: 225
-- Name: subject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "public"."subject_id_seq" OWNED BY "public"."subject"."id";


--
-- TOC entry 224 (class 1259 OID 17429)
-- Name: teacher; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."teacher" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "surname" character varying(255) NOT NULL,
    "patronymic" character varying(255),
    "id_login" integer NOT NULL
);


--
-- TOC entry 223 (class 1259 OID 17428)
-- Name: teacher_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "public"."teacher_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4944 (class 0 OID 0)
-- Dependencies: 223
-- Name: teacher_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "public"."teacher_id_seq" OWNED BY "public"."teacher"."id";


--
-- TOC entry 220 (class 1259 OID 17400)
-- Name: universitygroup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."universitygroup" (
    "id" integer NOT NULL,
    "id_profile" integer NOT NULL,
    "year_begin" integer NOT NULL,
    "number" character varying(255) NOT NULL
);


--
-- TOC entry 219 (class 1259 OID 17399)
-- Name: universitygroup_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "public"."universitygroup_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4946 (class 0 OID 0)
-- Dependencies: 219
-- Name: universitygroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "public"."universitygroup_id_seq" OWNED BY "public"."universitygroup"."id";


--
-- TOC entry 4708 (class 2604 OID 17530)
-- Name: answer_student id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."answer_student" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."answer_student_id_seq"'::"regclass");


--
-- TOC entry 4705 (class 2604 OID 17491)
-- Name: briefing id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."briefing" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."briefing_id_seq"'::"regclass");


--
-- TOC entry 4698 (class 2604 OID 17389)
-- Name: loginmoodle id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."loginmoodle" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."loginmoodle_id_seq"'::"regclass");


--
-- TOC entry 4704 (class 2604 OID 17461)
-- Name: news id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."news" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."news_id_seq"'::"regclass");


--
-- TOC entry 4709 (class 2604 OID 17550)
-- Name: plagiat id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."plagiat" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."plagiat_id_seq"'::"regclass");


--
-- TOC entry 4699 (class 2604 OID 17396)
-- Name: profile id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."profile" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."profile_id_seq"'::"regclass");


--
-- TOC entry 4707 (class 2604 OID 17589)
-- Name: profilebriefing id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."profilebriefing" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."profilebriefing_id_seq"'::"regclass");


--
-- TOC entry 4706 (class 2604 OID 17503)
-- Name: question id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."question" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."question_id_seq"'::"regclass");


--
-- TOC entry 4701 (class 2604 OID 17415)
-- Name: student id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."student" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."student_id_seq"'::"regclass");


--
-- TOC entry 4703 (class 2604 OID 17444)
-- Name: subject id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."subject" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."subject_id_seq"'::"regclass");


--
-- TOC entry 4702 (class 2604 OID 17432)
-- Name: teacher id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."teacher" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."teacher_id_seq"'::"regclass");


--
-- TOC entry 4700 (class 2604 OID 17403)
-- Name: universitygroup id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."universitygroup" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."universitygroup_id_seq"'::"regclass");


--
-- TOC entry 4912 (class 0 OID 17527)
-- Dependencies: 235
-- Data for Name: answer_student; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (1, 1, 3, 'Ответ студента на вопрос 1', 75.50) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (2, 1, 4, 'Ответ студента на вопрос 2', 90.00) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (3, 2, 3, 'Ответ студента на вопрос 3', 85.25) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (4, 2, 4, 'Ответ студента на вопрос 4', 80.75) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (5, 3, 5, 'Ответ студента на вопрос 5', 95.00) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (6, 3, 6, 'Ответ студента на вопрос 6', 70.00) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (7, 4, 7, 'Ответ студента на вопрос 7', 60.00) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (8, 4, 8, 'Ответ студента на вопрос 8', 85.00) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (9, 5, 9, 'Ответ студента на вопрос 9', 80.50) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (10, 5, 10, 'Ответ студента на вопрос 10', 92.00) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (11, 6, 11, 'Ответ студента на вопрос 11', 88.25) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (12, 6, 12, 'Ответ студента на вопрос 12', 75.75) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (13, 7, 13, 'Ответ студента на вопрос 13', 70.00) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (14, 7, 14, 'Ответ студента на вопрос 14', 65.50) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (15, 8, 15, 'Ответ студента на вопрос 15', 90.00) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (16, 8, 16, 'Ответ студента на вопрос 16', 85.75) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (17, 9, 3, 'Ответ студента на вопрос 1', 80.00) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (18, 9, 4, 'Ответ студента на вопрос 2', 85.00) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (19, 10, 3, 'Ответ студента на вопрос 3', 70.50) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (20, 10, 4, 'Ответ студента на вопрос 4', 75.00) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (21, 11, 5, 'Ответ студента на вопрос 5', 85.50) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (22, 11, 6, 'Ответ студента на вопрос 6', 60.00) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (23, 12, 7, 'Ответ студента на вопрос 7', 70.00) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (24, 12, 8, 'Ответ студента на вопрос 8', 95.00) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (25, 13, 9, 'Ответ студента на вопрос 9', 90.50) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (26, 13, 10, 'Ответ студента на вопрос 10', 88.00) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (27, 14, 11, 'Ответ студента на вопрос 11', 75.25) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (28, 14, 12, 'Ответ студента на вопрос 12', 80.75) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (29, 15, 13, 'Ответ студента на вопрос 13', 65.00) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (30, 15, 14, 'Ответ студента на вопрос 14', 70.50) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (31, 16, 15, 'Ответ студента на вопрос 15', 92.00) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (32, 16, 16, 'Ответ студента на вопрос 16', 85.00) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (33, 17, 3, 'Ответ студента на вопрос 1', 85.00) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (34, 17, 4, 'Ответ студента на вопрос 2', 80.00) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (35, 18, 3, 'Ответ студента на вопрос 3', 75.50) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (36, 18, 4, 'Ответ студента на вопрос 4', 90.00) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (37, 19, 5, 'Ответ студента на вопрос 5', 80.25) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (38, 19, 6, 'Ответ студента на вопрос 6', 85.75) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (39, 20, 7, 'Ответ студента на вопрос 7', 70.00) ON CONFLICT DO NOTHING;
INSERT INTO "public"."answer_student" ("id", "id_student", "id_question", "text", "accuracy_percent") VALUES (40, 20, 8, 'Ответ студента на вопрос 8', 75.50) ON CONFLICT DO NOTHING;


--
-- TOC entry 4907 (class 0 OID 17488)
-- Dependencies: 230
-- Data for Name: briefing; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."briefing" ("id", "id_subject", "number", "title", "duration", "status") VALUES (1, 1, 1, 'Летучка по интегральным уравнениям', '01:00:00', 'открыто') ON CONFLICT DO NOTHING;
INSERT INTO "public"."briefing" ("id", "id_subject", "number", "title", "duration", "status") VALUES (2, 1, 2, 'Летучка по интегральным уравнениям', '00:45:00', 'открыто') ON CONFLICT DO NOTHING;
INSERT INTO "public"."briefing" ("id", "id_subject", "number", "title", "duration", "status") VALUES (3, 2, 1, 'Летучка по линейной алгебре', '02:00:00', 'закрыто') ON CONFLICT DO NOTHING;
INSERT INTO "public"."briefing" ("id", "id_subject", "number", "title", "duration", "status") VALUES (4, 2, 2, 'Летучка по линейной алгебре', '01:30:00', 'открыто') ON CONFLICT DO NOTHING;
INSERT INTO "public"."briefing" ("id", "id_subject", "number", "title", "duration", "status") VALUES (5, 3, 1, 'Летучка по программированию на Python', '01:00:00', 'открыто') ON CONFLICT DO NOTHING;
INSERT INTO "public"."briefing" ("id", "id_subject", "number", "title", "duration", "status") VALUES (6, 3, 2, 'Летучка по программированию на Python', '01:30:00', 'открыто') ON CONFLICT DO NOTHING;
INSERT INTO "public"."briefing" ("id", "id_subject", "number", "title", "duration", "status") VALUES (7, 4, 1, 'Летучка по методам оптимизации', '02:00:00', 'открыто') ON CONFLICT DO NOTHING;
INSERT INTO "public"."briefing" ("id", "id_subject", "number", "title", "duration", "status") VALUES (8, 4, 2, 'Летучка по методам оптимизации', '01:30:00', 'открыто') ON CONFLICT DO NOTHING;


--
-- TOC entry 4893 (class 0 OID 17386)
-- Dependencies: 216
-- Data for Name: loginmoodle; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."loginmoodle" ("id", "login", "status") VALUES (1, 'coolbro1234', 'student') ON CONFLICT DO NOTHING;
INSERT INTO "public"."loginmoodle" ("id", "login", "status") VALUES (2, 'sergey3000', 'student') ON CONFLICT DO NOTHING;
INSERT INTO "public"."loginmoodle" ("id", "login", "status") VALUES (3, 'artyomcrutoi2001', 'student') ON CONFLICT DO NOTHING;
INSERT INTO "public"."loginmoodle" ("id", "login", "status") VALUES (4, 'coolgirls2323', 'student') ON CONFLICT DO NOTHING;
INSERT INTO "public"."loginmoodle" ("id", "login", "status") VALUES (5, 'gena20020', 'student') ON CONFLICT DO NOTHING;
INSERT INTO "public"."loginmoodle" ("id", "login", "status") VALUES (6, 'coroleva222', 'student') ON CONFLICT DO NOTHING;
INSERT INTO "public"."loginmoodle" ("id", "login", "status") VALUES (7, 'alsuyoya', 'student') ON CONFLICT DO NOTHING;
INSERT INTO "public"."loginmoodle" ("id", "login", "status") VALUES (8, 'nikitalol2', 'student') ON CONFLICT DO NOTHING;
INSERT INTO "public"."loginmoodle" ("id", "login", "status") VALUES (9, 'caifguy', 'student') ON CONFLICT DO NOTHING;
INSERT INTO "public"."loginmoodle" ("id", "login", "status") VALUES (10, 'goncon2323322', 'student') ON CONFLICT DO NOTHING;
INSERT INTO "public"."loginmoodle" ("id", "login", "status") VALUES (11, 'crutoiparen21212', 'student') ON CONFLICT DO NOTHING;
INSERT INTO "public"."loginmoodle" ("id", "login", "status") VALUES (12, 'efremov5454', 'student') ON CONFLICT DO NOTHING;
INSERT INTO "public"."loginmoodle" ("id", "login", "status") VALUES (13, 'klalbolt222', 'student') ON CONFLICT DO NOTHING;
INSERT INTO "public"."loginmoodle" ("id", "login", "status") VALUES (14, 'cutemilashka', 'student') ON CONFLICT DO NOTHING;
INSERT INTO "public"."loginmoodle" ("id", "login", "status") VALUES (15, 'dude99898', 'student') ON CONFLICT DO NOTHING;
INSERT INTO "public"."loginmoodle" ("id", "login", "status") VALUES (16, 'arabadamov', 'student') ON CONFLICT DO NOTHING;
INSERT INTO "public"."loginmoodle" ("id", "login", "status") VALUES (17, 'andreycoolnicebro', 'student') ON CONFLICT DO NOTHING;
INSERT INTO "public"."loginmoodle" ("id", "login", "status") VALUES (18, 'alexeypretty', 'student') ON CONFLICT DO NOTHING;
INSERT INTO "public"."loginmoodle" ("id", "login", "status") VALUES (19, 'efimovthebest', 'student') ON CONFLICT DO NOTHING;
INSERT INTO "public"."loginmoodle" ("id", "login", "status") VALUES (20, 'arkadiy777', 'student') ON CONFLICT DO NOTHING;
INSERT INTO "public"."loginmoodle" ("id", "login", "status") VALUES (21, 'pupkinVasiliy1966', 'teacher') ON CONFLICT DO NOTHING;
INSERT INTO "public"."loginmoodle" ("id", "login", "status") VALUES (22, 'ivanov2022', 'teacher') ON CONFLICT DO NOTHING;


--
-- TOC entry 4905 (class 0 OID 17458)
-- Dependencies: 228
-- Data for Name: news; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."news" ("id", "date_start", "text", "id_teacher", "id_profile") VALUES (1, '2024-05-01 10:00:00', 'Летучка от учителя Александрова для профиля ИФСТ.', 1, 1) ON CONFLICT DO NOTHING;
INSERT INTO "public"."news" ("id", "date_start", "text", "id_teacher", "id_profile") VALUES (2, '2024-05-02 11:00:00', 'Летучка от учителя Ивановой для профиля ИФСТ.', 2, 1) ON CONFLICT DO NOTHING;
INSERT INTO "public"."news" ("id", "date_start", "text", "id_teacher", "id_profile") VALUES (3, '2024-05-03 12:00:00', 'Летучка от учителя Александрова для профиля ПИНФ.', 1, 2) ON CONFLICT DO NOTHING;
INSERT INTO "public"."news" ("id", "date_start", "text", "id_teacher", "id_profile") VALUES (4, '2024-05-04 13:00:00', 'Летучка от учителя Ивановой для профиля ПИНФ.', 2, 2) ON CONFLICT DO NOTHING;
INSERT INTO "public"."news" ("id", "date_start", "text", "id_teacher", "id_profile") VALUES (5, '2024-05-05 14:00:00', 'Летучка от учителя Александрова для профиля ИФСТ.', 1, 1) ON CONFLICT DO NOTHING;
INSERT INTO "public"."news" ("id", "date_start", "text", "id_teacher", "id_profile") VALUES (6, '2024-05-06 15:00:00', 'Летучка от учителя Ивановой для профиля ИФСТ.', 2, 1) ON CONFLICT DO NOTHING;
INSERT INTO "public"."news" ("id", "date_start", "text", "id_teacher", "id_profile") VALUES (7, '2024-05-07 16:00:00', 'Летучка от учителя Александрова для профиля ПИНФ.', 1, 2) ON CONFLICT DO NOTHING;
INSERT INTO "public"."news" ("id", "date_start", "text", "id_teacher", "id_profile") VALUES (8, '2024-05-08 17:00:00', 'Летучка от учителя Ивановой для профиля ПИНФ.', 2, 2) ON CONFLICT DO NOTHING;
INSERT INTO "public"."news" ("id", "date_start", "text", "id_teacher", "id_profile") VALUES (9, '2024-05-09 18:00:00', 'Летучка от учителя Александрова для профиля ИФСТ.', 1, 1) ON CONFLICT DO NOTHING;
INSERT INTO "public"."news" ("id", "date_start", "text", "id_teacher", "id_profile") VALUES (10, '2024-05-10 19:00:00', 'Летучка от учителя Ивановой для профиля ИФСТ.', 2, 1) ON CONFLICT DO NOTHING;


--
-- TOC entry 4914 (class 0 OID 17547)
-- Dependencies: 237
-- Data for Name: plagiat; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4895 (class 0 OID 17393)
-- Dependencies: 218
-- Data for Name: profile; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."profile" ("id", "title") VALUES (1, 'ИФСТ') ON CONFLICT DO NOTHING;
INSERT INTO "public"."profile" ("id", "title") VALUES (2, 'ПИНФ') ON CONFLICT DO NOTHING;


--
-- TOC entry 4910 (class 0 OID 17513)
-- Dependencies: 233
-- Data for Name: profilebriefing; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."profilebriefing" ("id_profile", "id_briefing", "id") VALUES (1, 1, 1) ON CONFLICT DO NOTHING;
INSERT INTO "public"."profilebriefing" ("id_profile", "id_briefing", "id") VALUES (1, 2, 2) ON CONFLICT DO NOTHING;
INSERT INTO "public"."profilebriefing" ("id_profile", "id_briefing", "id") VALUES (1, 3, 3) ON CONFLICT DO NOTHING;
INSERT INTO "public"."profilebriefing" ("id_profile", "id_briefing", "id") VALUES (1, 4, 4) ON CONFLICT DO NOTHING;
INSERT INTO "public"."profilebriefing" ("id_profile", "id_briefing", "id") VALUES (2, 5, 5) ON CONFLICT DO NOTHING;
INSERT INTO "public"."profilebriefing" ("id_profile", "id_briefing", "id") VALUES (2, 6, 6) ON CONFLICT DO NOTHING;
INSERT INTO "public"."profilebriefing" ("id_profile", "id_briefing", "id") VALUES (2, 7, 7) ON CONFLICT DO NOTHING;
INSERT INTO "public"."profilebriefing" ("id_profile", "id_briefing", "id") VALUES (2, 8, 8) ON CONFLICT DO NOTHING;


--
-- TOC entry 4909 (class 0 OID 17500)
-- Dependencies: 232
-- Data for Name: question; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."question" ("id", "id_briefing", "text", "type_verification", "answer") VALUES (1, 1, 'Что такое алгоритм сортировки QuickSort?', 'вручную', 'Ответ на вопрос 1 летучки 1') ON CONFLICT DO NOTHING;
INSERT INTO "public"."question" ("id", "id_briefing", "text", "type_verification", "answer") VALUES (2, 1, 'Какие основные типы данных используются в языке программирования Java?', 'автоматически', '') ON CONFLICT DO NOTHING;
INSERT INTO "public"."question" ("id", "id_briefing", "text", "type_verification", "answer") VALUES (3, 2, 'Что такое рекурсия в программировании?', 'вручную', 'Ответ на вопрос 1 летучки 2') ON CONFLICT DO NOTHING;
INSERT INTO "public"."question" ("id", "id_briefing", "text", "type_verification", "answer") VALUES (4, 2, 'Что такое операторы условия в программировании?', 'автоматически', '') ON CONFLICT DO NOTHING;
INSERT INTO "public"."question" ("id", "id_briefing", "text", "type_verification", "answer") VALUES (5, 3, 'Что такое SQL и для чего он используется?', 'вручную', 'Ответ на вопрос 1 летучки 3') ON CONFLICT DO NOTHING;
INSERT INTO "public"."question" ("id", "id_briefing", "text", "type_verification", "answer") VALUES (6, 3, 'Какие основные конструкции управления потоком данных существуют в языке программирования Python?', 'автоматически', '') ON CONFLICT DO NOTHING;
INSERT INTO "public"."question" ("id", "id_briefing", "text", "type_verification", "answer") VALUES (7, 4, 'Каким образом работает алгоритм поиска в ширину (BFS) в графах?', 'вручную', 'Ответ на вопрос 1 летучки 4') ON CONFLICT DO NOTHING;
INSERT INTO "public"."question" ("id", "id_briefing", "text", "type_verification", "answer") VALUES (8, 4, 'Что такое переменная и какие типы переменных существуют в языке программирования?', 'автоматически', '') ON CONFLICT DO NOTHING;
INSERT INTO "public"."question" ("id", "id_briefing", "text", "type_verification", "answer") VALUES (9, 5, 'Какие основные принципы объектно-ориентированного программирования (ООП)?', 'вручную', 'Ответ на вопрос 1 летучки 5') ON CONFLICT DO NOTHING;
INSERT INTO "public"."question" ("id", "id_briefing", "text", "type_verification", "answer") VALUES (10, 5, 'Что такое алгоритм бинарного поиска?', 'автоматически', '') ON CONFLICT DO NOTHING;
INSERT INTO "public"."question" ("id", "id_briefing", "text", "type_verification", "answer") VALUES (11, 6, 'Что такое реляционная база данных и какие преимущества она предоставляет?', 'вручную', 'Ответ на вопрос 1 летучки 6') ON CONFLICT DO NOTHING;
INSERT INTO "public"."question" ("id", "id_briefing", "text", "type_verification", "answer") VALUES (12, 6, 'Какие основные операторы используются в языке программирования C++?', 'автоматически', '') ON CONFLICT DO NOTHING;
INSERT INTO "public"."question" ("id", "id_briefing", "text", "type_verification", "answer") VALUES (13, 7, 'Что такое стек и каковы его основные операции?', 'вручную', 'Ответ на вопрос 1 летучки 7') ON CONFLICT DO NOTHING;
INSERT INTO "public"."question" ("id", "id_briefing", "text", "type_verification", "answer") VALUES (14, 7, 'Что такое алгоритм сортировки Merge Sort?', 'автоматически', '') ON CONFLICT DO NOTHING;
INSERT INTO "public"."question" ("id", "id_briefing", "text", "type_verification", "answer") VALUES (15, 8, 'Какие основные типы данных используются в языке программирования Python?', 'вручную', 'Ответ на вопрос 1 летучки 8') ON CONFLICT DO NOTHING;
INSERT INTO "public"."question" ("id", "id_briefing", "text", "type_verification", "answer") VALUES (16, 8, 'Что такое понятие объект в контексте объектно-ориентированного программирования?', 'автоматически', '') ON CONFLICT DO NOTHING;


--
-- TOC entry 4899 (class 0 OID 17412)
-- Dependencies: 222
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."student" ("id", "name", "surname", "patronymic", "id_group", "id_login") VALUES (1, 'Иван', 'Иванов', 'Иванович', 1, 1) ON CONFLICT DO NOTHING;
INSERT INTO "public"."student" ("id", "name", "surname", "patronymic", "id_group", "id_login") VALUES (2, 'Петр', 'Петров', 'Петрович', 1, 2) ON CONFLICT DO NOTHING;
INSERT INTO "public"."student" ("id", "name", "surname", "patronymic", "id_group", "id_login") VALUES (3, 'Сидор', 'Сидоров', 'Сидорович', 2, 3) ON CONFLICT DO NOTHING;
INSERT INTO "public"."student" ("id", "name", "surname", "patronymic", "id_group", "id_login") VALUES (4, 'Михаил', 'Михайлов', 'Михайлович', 2, 4) ON CONFLICT DO NOTHING;
INSERT INTO "public"."student" ("id", "name", "surname", "patronymic", "id_group", "id_login") VALUES (5, 'Алексей', 'Алексеев', 'Алексеевич', 3, 5) ON CONFLICT DO NOTHING;
INSERT INTO "public"."student" ("id", "name", "surname", "patronymic", "id_group", "id_login") VALUES (6, 'Николай', 'Николаев', 'Николаевич', 3, 6) ON CONFLICT DO NOTHING;
INSERT INTO "public"."student" ("id", "name", "surname", "patronymic", "id_group", "id_login") VALUES (7, 'Андрей', 'Андреев', 'Андреевич', 4, 7) ON CONFLICT DO NOTHING;
INSERT INTO "public"."student" ("id", "name", "surname", "patronymic", "id_group", "id_login") VALUES (8, 'Дмитрий', 'Дмитриев', 'Дмитриевич', 4, 8) ON CONFLICT DO NOTHING;
INSERT INTO "public"."student" ("id", "name", "surname", "patronymic", "id_group", "id_login") VALUES (9, 'Владимир', 'Владимиров', 'Владимирович', 5, 9) ON CONFLICT DO NOTHING;
INSERT INTO "public"."student" ("id", "name", "surname", "patronymic", "id_group", "id_login") VALUES (10, 'Сергей', 'Сергеев', 'Сергеевич', 5, 10) ON CONFLICT DO NOTHING;
INSERT INTO "public"."student" ("id", "name", "surname", "patronymic", "id_group", "id_login") VALUES (11, 'Алексей', 'Алексеев', 'Алексеевич', 6, 11) ON CONFLICT DO NOTHING;
INSERT INTO "public"."student" ("id", "name", "surname", "patronymic", "id_group", "id_login") VALUES (12, 'Игорь', 'Игорев', 'Игоревич', 6, 12) ON CONFLICT DO NOTHING;
INSERT INTO "public"."student" ("id", "name", "surname", "patronymic", "id_group", "id_login") VALUES (13, 'Юрий', 'Юрьев', 'Юрьевич', 7, 13) ON CONFLICT DO NOTHING;
INSERT INTO "public"."student" ("id", "name", "surname", "patronymic", "id_group", "id_login") VALUES (14, 'Олег', 'Олегов', 'Олегович', 7, 14) ON CONFLICT DO NOTHING;
INSERT INTO "public"."student" ("id", "name", "surname", "patronymic", "id_group", "id_login") VALUES (15, 'Денис', 'Денисов', 'Денисович', 1, 15) ON CONFLICT DO NOTHING;
INSERT INTO "public"."student" ("id", "name", "surname", "patronymic", "id_group", "id_login") VALUES (16, 'Вячеслав', 'Вячеславов', 'Вячеславович', 2, 16) ON CONFLICT DO NOTHING;
INSERT INTO "public"."student" ("id", "name", "surname", "patronymic", "id_group", "id_login") VALUES (17, 'Геннадий', 'Геннадиев', 'Геннадиевич', 3, 17) ON CONFLICT DO NOTHING;
INSERT INTO "public"."student" ("id", "name", "surname", "patronymic", "id_group", "id_login") VALUES (18, 'Евгений', 'Евгеньев', 'Евгеньевич', 4, 18) ON CONFLICT DO NOTHING;
INSERT INTO "public"."student" ("id", "name", "surname", "patronymic", "id_group", "id_login") VALUES (19, 'Артем', 'Артемов', 'Артемович', 5, 19) ON CONFLICT DO NOTHING;
INSERT INTO "public"."student" ("id", "name", "surname", "patronymic", "id_group", "id_login") VALUES (20, 'Станислав', 'Станиславов', 'Станиславович', 6, 20) ON CONFLICT DO NOTHING;


--
-- TOC entry 4903 (class 0 OID 17441)
-- Dependencies: 226
-- Data for Name: subject; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."subject" ("id", "title", "id_teacher", "id_profile") VALUES (1, 'Математика', 1, 1) ON CONFLICT DO NOTHING;
INSERT INTO "public"."subject" ("id", "title", "id_teacher", "id_profile") VALUES (2, 'Физика', 2, 1) ON CONFLICT DO NOTHING;
INSERT INTO "public"."subject" ("id", "title", "id_teacher", "id_profile") VALUES (3, 'Информатика', 1, 2) ON CONFLICT DO NOTHING;
INSERT INTO "public"."subject" ("id", "title", "id_teacher", "id_profile") VALUES (4, 'Химия', 2, 2) ON CONFLICT DO NOTHING;


--
-- TOC entry 4901 (class 0 OID 17429)
-- Dependencies: 224
-- Data for Name: teacher; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."teacher" ("id", "name", "surname", "patronymic", "id_login") VALUES (1, 'Василий', 'Пупкин', 'Александрович', 21) ON CONFLICT DO NOTHING;
INSERT INTO "public"."teacher" ("id", "name", "surname", "patronymic", "id_login") VALUES (2, 'Мария', 'Иванова', 'Петровна', 22) ON CONFLICT DO NOTHING;


--
-- TOC entry 4897 (class 0 OID 17400)
-- Dependencies: 220
-- Data for Name: universitygroup; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."universitygroup" ("id", "id_profile", "year_begin", "number") VALUES (1, 1, 2020, '11') ON CONFLICT DO NOTHING;
INSERT INTO "public"."universitygroup" ("id", "id_profile", "year_begin", "number") VALUES (2, 1, 2021, '12') ON CONFLICT DO NOTHING;
INSERT INTO "public"."universitygroup" ("id", "id_profile", "year_begin", "number") VALUES (3, 1, 2022, '13') ON CONFLICT DO NOTHING;
INSERT INTO "public"."universitygroup" ("id", "id_profile", "year_begin", "number") VALUES (4, 1, 2020, '21') ON CONFLICT DO NOTHING;
INSERT INTO "public"."universitygroup" ("id", "id_profile", "year_begin", "number") VALUES (5, 1, 2021, '22') ON CONFLICT DO NOTHING;
INSERT INTO "public"."universitygroup" ("id", "id_profile", "year_begin", "number") VALUES (6, 2, 2022, '23') ON CONFLICT DO NOTHING;
INSERT INTO "public"."universitygroup" ("id", "id_profile", "year_begin", "number") VALUES (7, 2, 2023, '24') ON CONFLICT DO NOTHING;


--
-- TOC entry 4947 (class 0 OID 0)
-- Dependencies: 234
-- Name: answer_student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."answer_student_id_seq"', 40, true);


--
-- TOC entry 4948 (class 0 OID 0)
-- Dependencies: 229
-- Name: briefing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."briefing_id_seq"', 8, true);


--
-- TOC entry 4949 (class 0 OID 0)
-- Dependencies: 215
-- Name: loginmoodle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."loginmoodle_id_seq"', 22, true);


--
-- TOC entry 4950 (class 0 OID 0)
-- Dependencies: 227
-- Name: news_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."news_id_seq"', 10, true);


--
-- TOC entry 4951 (class 0 OID 0)
-- Dependencies: 236
-- Name: plagiat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."plagiat_id_seq"', 3, true);


--
-- TOC entry 4952 (class 0 OID 0)
-- Dependencies: 217
-- Name: profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."profile_id_seq"', 2, true);


--
-- TOC entry 4953 (class 0 OID 0)
-- Dependencies: 238
-- Name: profilebriefing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."profilebriefing_id_seq"', 8, true);


--
-- TOC entry 4954 (class 0 OID 0)
-- Dependencies: 231
-- Name: question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."question_id_seq"', 16, true);


--
-- TOC entry 4955 (class 0 OID 0)
-- Dependencies: 221
-- Name: student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."student_id_seq"', 20, true);


--
-- TOC entry 4956 (class 0 OID 0)
-- Dependencies: 225
-- Name: subject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."subject_id_seq"', 4, true);


--
-- TOC entry 4957 (class 0 OID 0)
-- Dependencies: 223
-- Name: teacher_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."teacher_id_seq"', 2, true);


--
-- TOC entry 4958 (class 0 OID 0)
-- Dependencies: 219
-- Name: universitygroup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."universitygroup_id_seq"', 7, true);


--
-- TOC entry 4730 (class 2606 OID 17535)
-- Name: answer_student answer_student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."answer_student"
    ADD CONSTRAINT "answer_student_pkey" PRIMARY KEY ("id");


--
-- TOC entry 4726 (class 2606 OID 17493)
-- Name: briefing briefing_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."briefing"
    ADD CONSTRAINT "briefing_pkey" PRIMARY KEY ("id");


--
-- TOC entry 4712 (class 2606 OID 17391)
-- Name: loginmoodle loginmoodle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."loginmoodle"
    ADD CONSTRAINT "loginmoodle_pkey" PRIMARY KEY ("id");


--
-- TOC entry 4724 (class 2606 OID 17465)
-- Name: news news_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."news"
    ADD CONSTRAINT "news_pkey" PRIMARY KEY ("id");


--
-- TOC entry 4732 (class 2606 OID 17552)
-- Name: plagiat plagiat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."plagiat"
    ADD CONSTRAINT "plagiat_pkey" PRIMARY KEY ("id");


--
-- TOC entry 4714 (class 2606 OID 17398)
-- Name: profile profile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."profile"
    ADD CONSTRAINT "profile_pkey" PRIMARY KEY ("id");


--
-- TOC entry 4728 (class 2606 OID 17507)
-- Name: question question_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."question"
    ADD CONSTRAINT "question_pkey" PRIMARY KEY ("id");


--
-- TOC entry 4718 (class 2606 OID 17417)
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."student"
    ADD CONSTRAINT "student_pkey" PRIMARY KEY ("id");


--
-- TOC entry 4722 (class 2606 OID 17446)
-- Name: subject subject_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."subject"
    ADD CONSTRAINT "subject_pkey" PRIMARY KEY ("id");


--
-- TOC entry 4720 (class 2606 OID 17434)
-- Name: teacher teacher_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."teacher"
    ADD CONSTRAINT "teacher_pkey" PRIMARY KEY ("id");


--
-- TOC entry 4716 (class 2606 OID 17405)
-- Name: universitygroup universitygroup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."universitygroup"
    ADD CONSTRAINT "universitygroup_pkey" PRIMARY KEY ("id");


--
-- TOC entry 4745 (class 2606 OID 17541)
-- Name: answer_student answer_student_id_question_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."answer_student"
    ADD CONSTRAINT "answer_student_id_question_fkey" FOREIGN KEY ("id_question") REFERENCES "public"."question"("id");


--
-- TOC entry 4746 (class 2606 OID 17536)
-- Name: answer_student answer_student_id_student_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."answer_student"
    ADD CONSTRAINT "answer_student_id_student_fkey" FOREIGN KEY ("id_student") REFERENCES "public"."student"("id");


--
-- TOC entry 4741 (class 2606 OID 17494)
-- Name: briefing briefing_id_subject_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."briefing"
    ADD CONSTRAINT "briefing_id_subject_fkey" FOREIGN KEY ("id_subject") REFERENCES "public"."subject"("id");


--
-- TOC entry 4739 (class 2606 OID 17471)
-- Name: news news_id_profile_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."news"
    ADD CONSTRAINT "news_id_profile_fkey" FOREIGN KEY ("id_profile") REFERENCES "public"."profile"("id");


--
-- TOC entry 4740 (class 2606 OID 17466)
-- Name: news news_id_teacher_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."news"
    ADD CONSTRAINT "news_id_teacher_fkey" FOREIGN KEY ("id_teacher") REFERENCES "public"."teacher"("id");


--
-- TOC entry 4747 (class 2606 OID 17553)
-- Name: plagiat plagiat_id_answer_student1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."plagiat"
    ADD CONSTRAINT "plagiat_id_answer_student1_fkey" FOREIGN KEY ("id_answer_student1") REFERENCES "public"."answer_student"("id");


--
-- TOC entry 4748 (class 2606 OID 17558)
-- Name: plagiat plagiat_id_answer_student2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."plagiat"
    ADD CONSTRAINT "plagiat_id_answer_student2_fkey" FOREIGN KEY ("id_answer_student2") REFERENCES "public"."answer_student"("id");


--
-- TOC entry 4743 (class 2606 OID 17521)
-- Name: profilebriefing profilebriefing_id_briefing_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."profilebriefing"
    ADD CONSTRAINT "profilebriefing_id_briefing_fkey" FOREIGN KEY ("id_briefing") REFERENCES "public"."briefing"("id");


--
-- TOC entry 4744 (class 2606 OID 17516)
-- Name: profilebriefing profilebriefing_id_profile_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."profilebriefing"
    ADD CONSTRAINT "profilebriefing_id_profile_fkey" FOREIGN KEY ("id_profile") REFERENCES "public"."profile"("id");


--
-- TOC entry 4742 (class 2606 OID 17508)
-- Name: question question_id_briefing_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."question"
    ADD CONSTRAINT "question_id_briefing_fkey" FOREIGN KEY ("id_briefing") REFERENCES "public"."briefing"("id");


--
-- TOC entry 4734 (class 2606 OID 17418)
-- Name: student student_id_group_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."student"
    ADD CONSTRAINT "student_id_group_fkey" FOREIGN KEY ("id_group") REFERENCES "public"."universitygroup"("id");


--
-- TOC entry 4735 (class 2606 OID 17423)
-- Name: student student_id_login_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."student"
    ADD CONSTRAINT "student_id_login_fkey" FOREIGN KEY ("id_login") REFERENCES "public"."loginmoodle"("id");


--
-- TOC entry 4737 (class 2606 OID 17452)
-- Name: subject subject_id_profile_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."subject"
    ADD CONSTRAINT "subject_id_profile_fkey" FOREIGN KEY ("id_profile") REFERENCES "public"."profile"("id");


--
-- TOC entry 4738 (class 2606 OID 17447)
-- Name: subject subject_id_teacher_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."subject"
    ADD CONSTRAINT "subject_id_teacher_fkey" FOREIGN KEY ("id_teacher") REFERENCES "public"."teacher"("id");


--
-- TOC entry 4736 (class 2606 OID 17435)
-- Name: teacher teacher_id_login_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."teacher"
    ADD CONSTRAINT "teacher_id_login_fkey" FOREIGN KEY ("id_login") REFERENCES "public"."loginmoodle"("id");


--
-- TOC entry 4733 (class 2606 OID 17406)
-- Name: universitygroup universitygroup_id_profile_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."universitygroup"
    ADD CONSTRAINT "universitygroup_id_profile_fkey" FOREIGN KEY ("id_profile") REFERENCES "public"."profile"("id");


--
-- TOC entry 4923 (class 0 OID 0)
-- Dependencies: 235
-- Name: TABLE "answer_student"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."answer_student" TO "student_br";


SET SESSION AUTHORIZATION 'postgres';

--
-- TOC entry 4925 (class 0 OID 0)
-- Dependencies: 230
-- Name: TABLE "briefing"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."briefing" TO "student_br";


SET SESSION AUTHORIZATION 'postgres';

--
-- TOC entry 4927 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE "loginmoodle"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."loginmoodle" TO "student_br";


SET SESSION AUTHORIZATION 'postgres';

--
-- TOC entry 4929 (class 0 OID 0)
-- Dependencies: 228
-- Name: TABLE "news"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."news" TO "student_br";


SET SESSION AUTHORIZATION 'postgres';

--
-- TOC entry 4931 (class 0 OID 0)
-- Dependencies: 237
-- Name: TABLE "plagiat"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."plagiat" TO "student_br";


SET SESSION AUTHORIZATION 'postgres';

--
-- TOC entry 4933 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE "profile"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."profile" TO "student_br";


SET SESSION AUTHORIZATION 'postgres';

--
-- TOC entry 4935 (class 0 OID 0)
-- Dependencies: 233
-- Name: TABLE "profilebriefing"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."profilebriefing" TO "student_br";


SET SESSION AUTHORIZATION 'postgres';

--
-- TOC entry 4937 (class 0 OID 0)
-- Dependencies: 232
-- Name: TABLE "question"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."question" TO "student_br";


SET SESSION AUTHORIZATION 'postgres';

--
-- TOC entry 4939 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE "student"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."student" TO "student_br";


SET SESSION AUTHORIZATION 'postgres';

--
-- TOC entry 4941 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE "subject"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."subject" TO "student_br";


SET SESSION AUTHORIZATION 'postgres';

--
-- TOC entry 4943 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE "teacher"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."teacher" TO "student_br";


SET SESSION AUTHORIZATION 'postgres';

--
-- TOC entry 4945 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE "universitygroup"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE "public"."universitygroup" TO "student_br";


-- Completed on 2024-05-15 09:23:24

--
-- PostgreSQL database dump complete
--

