--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.19
-- Dumped by pg_dump version 9.5.5

-- Started on 2017-09-01 18:28:59

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 9 (class 2615 OID 762650)
-- Name: audit; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA audit;


ALTER SCHEMA audit OWNER TO postgres;

--
-- TOC entry 1 (class 3079 OID 11649)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2195 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 2 (class 3079 OID 762729)
-- Name: dblink; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS dblink WITH SCHEMA public;


--
-- TOC entry 2196 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION dblink; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dblink IS 'connect to other PostgreSQL databases from within a database';


SET search_path = audit, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 209 (class 1259 OID 762656)
-- Name: lote_aud; Type: TABLE; Schema: audit; Owner: postgres
--

CREATE TABLE lote_aud (
    id_lote bigint NOT NULL,
    rev bigint NOT NULL,
    revtype smallint,
    data_registro timestamp without time zone,
    numero_lote character varying(255),
    ordem_producao bigint,
    id_produto bigint
);


ALTER TABLE lote_aud OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 762666)
-- Name: lote_maquina_aud; Type: TABLE; Schema: audit; Owner: postgres
--

CREATE TABLE lote_maquina_aud (
    id_lote_maquina bigint NOT NULL,
    rev bigint NOT NULL,
    revtype smallint,
    data_hora_fim timestamp without time zone,
    data_hora_inicio timestamp without time zone,
    id_lote bigint,
    id_maquina bigint
);


ALTER TABLE lote_maquina_aud OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 762676)
-- Name: maquina_setpoint_aud; Type: TABLE; Schema: audit; Owner: postgres
--

CREATE TABLE maquina_setpoint_aud (
    id_maquina_setpoint bigint NOT NULL,
    rev bigint NOT NULL,
    revtype smallint,
    ativo boolean,
    data_registro timestamp without time zone,
    valor character varying(255),
    id_maquina bigint,
    id_setpoint bigint
);


ALTER TABLE maquina_setpoint_aud OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 762686)
-- Name: produto_aud; Type: TABLE; Schema: audit; Owner: postgres
--

CREATE TABLE produto_aud (
    id_produto bigint NOT NULL,
    rev bigint NOT NULL,
    revtype smallint,
    ativo boolean,
    codigo_sap integer,
    data_registro timestamp without time zone,
    descricao character varying(255),
    id_tipo_produto bigint
);


ALTER TABLE produto_aud OWNER TO postgres;

--
-- TOC entry 2197 (class 0 OID 0)
-- Dependencies: 212
-- Name: COLUMN produto_aud.rev; Type: COMMENT; Schema: audit; Owner: postgres
--

COMMENT ON COLUMN produto_aud.rev IS '
';


--
-- TOC entry 213 (class 1259 OID 762696)
-- Name: produto_maquina_aud; Type: TABLE; Schema: audit; Owner: postgres
--

CREATE TABLE produto_maquina_aud (
    id_produto_maquina bigint NOT NULL,
    rev bigint NOT NULL,
    revtype smallint,
    ativo boolean,
    data_registro timestamp without time zone,
    num_ciclos integer,
    quantidade_estufas integer,
    temperatura_secagem real,
    id_maquina bigint,
    id_produto bigint
);


ALTER TABLE produto_maquina_aud OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 762651)
-- Name: revinfo; Type: TABLE; Schema: audit; Owner: postgres
--

CREATE TABLE revinfo (
    rev bigint NOT NULL,
    revtstmp bigint NOT NULL,
    usuario character varying(255)
);


ALTER TABLE revinfo OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 762706)
-- Name: setpoint_aud; Type: TABLE; Schema: audit; Owner: postgres
--

CREATE TABLE setpoint_aud (
    id_setpoint bigint NOT NULL,
    rev bigint NOT NULL,
    revtype smallint,
    ativo boolean,
    data_registro timestamp without time zone,
    nome character varying(255)
);


ALTER TABLE setpoint_aud OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 762716)
-- Name: tempo_etapa_aud; Type: TABLE; Schema: audit; Owner: postgres
--

CREATE TABLE tempo_etapa_aud (
    id_tempo_etapa bigint NOT NULL,
    rev bigint NOT NULL,
    revtype smallint,
    ativo boolean,
    data_registro timestamp without time zone,
    valor integer,
    id_produto_maquina bigint,
    id_tipo_produto_etapa bigint
);


ALTER TABLE tempo_etapa_aud OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- TOC entry 164 (class 1259 OID 762319)
-- Name: alarme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE alarme (
    id_alarme bigint NOT NULL,
    nome character varying(60) NOT NULL,
    descricao character varying(150) NOT NULL,
    dica character varying(255) NOT NULL,
    data_registro timestamp without time zone NOT NULL,
    ativo boolean NOT NULL
);


ALTER TABLE alarme OWNER TO postgres;

--
-- TOC entry 165 (class 1259 OID 762322)
-- Name: alarme_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE alarme_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alarme_seq OWNER TO postgres;

--
-- TOC entry 2198 (class 0 OID 0)
-- Dependencies: 165
-- Name: alarme_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE alarme_seq OWNED BY alarme.id_alarme;


--
-- TOC entry 166 (class 1259 OID 762324)
-- Name: calibracao_sensor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE calibracao_sensor (
    id_calibracao_sensor bigint NOT NULL,
    id_equipamento bigint NOT NULL,
    cracha bigint,
    data_hora_inicio timestamp without time zone NOT NULL,
    data_hora_fim timestamp without time zone
);


ALTER TABLE calibracao_sensor OWNER TO postgres;

--
-- TOC entry 167 (class 1259 OID 762327)
-- Name: calibracao_sensor_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE calibracao_sensor_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE calibracao_sensor_seq OWNER TO postgres;

--
-- TOC entry 2199 (class 0 OID 0)
-- Dependencies: 167
-- Name: calibracao_sensor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE calibracao_sensor_seq OWNED BY calibracao_sensor.id_calibracao_sensor;


--
-- TOC entry 168 (class 1259 OID 762329)
-- Name: equipamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE equipamento (
    id_equipamento bigint NOT NULL,
    tag character varying(20) NOT NULL,
    descricao character varying(60) NOT NULL,
    ip character varying(20) NOT NULL,
    porta integer,
    id_tipo_comunicacao bigint NOT NULL,
    id_maquina bigint NOT NULL
);


ALTER TABLE equipamento OWNER TO postgres;

--
-- TOC entry 2200 (class 0 OID 0)
-- Dependencies: 168
-- Name: COLUMN equipamento.ip; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN equipamento.ip IS 'Não é obrigatório para caso de comunicação serial';


--
-- TOC entry 169 (class 1259 OID 762332)
-- Name: equipamento_alarme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE equipamento_alarme (
    id_equipamento_alarme bigint NOT NULL,
    id_equipamento bigint NOT NULL,
    id_alarme bigint NOT NULL,
    codigo_reset bigint,
    codigo bigint NOT NULL
);


ALTER TABLE equipamento_alarme OWNER TO postgres;

--
-- TOC entry 170 (class 1259 OID 762335)
-- Name: equipamento_alarme_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE equipamento_alarme_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE equipamento_alarme_seq OWNER TO postgres;

--
-- TOC entry 2201 (class 0 OID 0)
-- Dependencies: 170
-- Name: equipamento_alarme_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE equipamento_alarme_seq OWNED BY equipamento_alarme.id_equipamento_alarme;


--
-- TOC entry 171 (class 1259 OID 762337)
-- Name: equipamento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE equipamento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE equipamento_seq OWNER TO postgres;

--
-- TOC entry 2202 (class 0 OID 0)
-- Dependencies: 171
-- Name: equipamento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE equipamento_seq OWNED BY equipamento.id_equipamento;


--
-- TOC entry 172 (class 1259 OID 762339)
-- Name: etapa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE etapa (
    id_etapa bigint NOT NULL,
    nome character varying(60) NOT NULL,
    receita boolean NOT NULL,
    data_registro timestamp without time zone NOT NULL,
    ativo boolean NOT NULL,
    tipo smallint NOT NULL
);


ALTER TABLE etapa OWNER TO postgres;

--
-- TOC entry 2203 (class 0 OID 0)
-- Dependencies: 172
-- Name: COLUMN etapa.nome; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN etapa.nome IS 'Abastecimento
Aeração
Aquecimento
Secagem
Desligada
Homogeneização
Processo Finalizado';


--
-- TOC entry 2204 (class 0 OID 0)
-- Dependencies: 172
-- Name: COLUMN etapa.receita; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN etapa.receita IS 'true para etapas que possuem receita';


--
-- TOC entry 2205 (class 0 OID 0)
-- Dependencies: 172
-- Name: COLUMN etapa.tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN etapa.tipo IS '0 - ABASTECIMENTO, 1 - AERACAO, 2 - HOMOGENEIZACAO_INICIAL, 3 - SECAGEM, 4 - RESFRIAMENTO, 5 - HOMOGENEIZACAO_CICLO, 6 - DESCARREGAMENTO';


--
-- TOC entry 173 (class 1259 OID 762342)
-- Name: etapa_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE etapa_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE etapa_seq OWNER TO postgres;

--
-- TOC entry 2206 (class 0 OID 0)
-- Dependencies: 173
-- Name: etapa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE etapa_seq OWNED BY etapa.id_etapa;


--
-- TOC entry 216 (class 1259 OID 762727)
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hibernate_sequence OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 762344)
-- Name: io_equipamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE io_equipamento (
    id_io_equipamento bigint NOT NULL,
    id_equipamento bigint NOT NULL,
    nome character varying NOT NULL,
    variavel_clp character varying NOT NULL,
    ativo boolean NOT NULL,
    data_registro timestamp without time zone NOT NULL,
    tipo integer NOT NULL,
    porta character varying NOT NULL
);


ALTER TABLE io_equipamento OWNER TO postgres;

--
-- TOC entry 2207 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN io_equipamento.tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN io_equipamento.tipo IS '0 - Entrada Digital, 1 - Saida Digital, 2 - Entrada Analogica, 3 - Saida Analogica';


--
-- TOC entry 175 (class 1259 OID 762350)
-- Name: io_equipamento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE io_equipamento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE io_equipamento_seq OWNER TO postgres;

--
-- TOC entry 2208 (class 0 OID 0)
-- Dependencies: 175
-- Name: io_equipamento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE io_equipamento_seq OWNED BY io_equipamento.id_io_equipamento;


--
-- TOC entry 176 (class 1259 OID 762352)
-- Name: justificativa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE justificativa (
    id_justificativa bigint NOT NULL,
    descricao character varying NOT NULL,
    ativo boolean NOT NULL,
    data_registro timestamp without time zone NOT NULL
);


ALTER TABLE justificativa OWNER TO postgres;

--
-- TOC entry 177 (class 1259 OID 762358)
-- Name: justificativa_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE justificativa_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE justificativa_seq OWNER TO postgres;

--
-- TOC entry 2209 (class 0 OID 0)
-- Dependencies: 177
-- Name: justificativa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE justificativa_seq OWNED BY justificativa.id_justificativa;


--
-- TOC entry 178 (class 1259 OID 762360)
-- Name: log_etapa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE log_etapa (
    id_log_etapa bigint NOT NULL,
    id_equipamento bigint NOT NULL,
    id_lote_maquina bigint NOT NULL,
    id_tempo_etapa bigint NOT NULL,
    id_justificativa bigint,
    ciclo smallint NOT NULL,
    tempo_manual integer,
    data_hora_inicio timestamp without time zone NOT NULL,
    data_hora_fim timestamp without time zone,
    acao integer,
    tempo_decorrido integer,
    tempo_restante integer
);


ALTER TABLE log_etapa OWNER TO postgres;

--
-- TOC entry 2210 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN log_etapa.tempo_manual; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN log_etapa.tempo_manual IS 'gravado em minutos e exibido em formato HH:mm
Somente quando o usuário informar o tempo da etapa manualmente.';


--
-- TOC entry 179 (class 1259 OID 762363)
-- Name: log_etapa_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE log_etapa_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE log_etapa_seq OWNER TO postgres;

--
-- TOC entry 2211 (class 0 OID 0)
-- Dependencies: 179
-- Name: log_etapa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE log_etapa_seq OWNED BY log_etapa.id_log_etapa;


--
-- TOC entry 180 (class 1259 OID 762365)
-- Name: log_processo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE log_processo (
    id_log_processo bigint NOT NULL,
    id_equipamento bigint NOT NULL,
    id_lote_maquina bigint NOT NULL,
    temperatura_1 real NOT NULL,
    temperatura_2 real NOT NULL,
    temperatura_3 real NOT NULL,
    temperatura_4 real NOT NULL,
    temperatura_5 real NOT NULL,
    temperatura_6 real NOT NULL,
    umidade_estufa real NOT NULL,
    data_registro timestamp without time zone NOT NULL
);


ALTER TABLE log_processo OWNER TO postgres;

--
-- TOC entry 2212 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN log_processo.id_equipamento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN log_processo.id_equipamento IS 'Somente as estufas serão vinculadas a esta tabela.';


--
-- TOC entry 181 (class 1259 OID 762368)
-- Name: log_processo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE log_processo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE log_processo_seq OWNER TO postgres;

--
-- TOC entry 2213 (class 0 OID 0)
-- Dependencies: 181
-- Name: log_processo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE log_processo_seq OWNED BY log_processo.id_log_processo;


--
-- TOC entry 182 (class 1259 OID 762370)
-- Name: lote; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lote (
    id_lote bigint NOT NULL,
    id_produto bigint NOT NULL,
    data_registro timestamp without time zone NOT NULL,
    numero_lote character varying(10) NOT NULL,
    ordem_producao bigint NOT NULL
);


ALTER TABLE lote OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 762373)
-- Name: lote_maquina; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lote_maquina (
    id_lote_maquina bigint NOT NULL,
    id_maquina bigint NOT NULL,
    id_lote bigint NOT NULL,
    data_hora_inicio timestamp without time zone NOT NULL,
    data_hora_fim timestamp without time zone
);


ALTER TABLE lote_maquina OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 762376)
-- Name: lote_maquina_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE lote_maquina_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE lote_maquina_seq OWNER TO postgres;

--
-- TOC entry 2214 (class 0 OID 0)
-- Dependencies: 184
-- Name: lote_maquina_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE lote_maquina_seq OWNED BY lote_maquina.id_lote_maquina;


--
-- TOC entry 185 (class 1259 OID 762378)
-- Name: lote_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE lote_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE lote_seq OWNER TO postgres;

--
-- TOC entry 2215 (class 0 OID 0)
-- Dependencies: 185
-- Name: lote_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE lote_seq OWNED BY lote.id_lote;


--
-- TOC entry 186 (class 1259 OID 762380)
-- Name: maquina; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE maquina (
    id_maquina bigint NOT NULL,
    tag character varying(20) NOT NULL,
    data_registro timestamp without time zone NOT NULL,
    ativo boolean NOT NULL
);


ALTER TABLE maquina OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 762383)
-- Name: maquina_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE maquina_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE maquina_seq OWNER TO postgres;

--
-- TOC entry 2216 (class 0 OID 0)
-- Dependencies: 187
-- Name: maquina_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE maquina_seq OWNED BY maquina.id_maquina;


--
-- TOC entry 188 (class 1259 OID 762385)
-- Name: maquina_setpoint; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE maquina_setpoint (
    id_maquina_setpoint bigint NOT NULL,
    id_maquina bigint NOT NULL,
    id_setpoint bigint NOT NULL,
    valor character varying(100) NOT NULL,
    data_registro timestamp without time zone NOT NULL,
    ativo boolean NOT NULL
);


ALTER TABLE maquina_setpoint OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 762388)
-- Name: maquina_setpoint_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE maquina_setpoint_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE maquina_setpoint_seq OWNER TO postgres;

--
-- TOC entry 2217 (class 0 OID 0)
-- Dependencies: 189
-- Name: maquina_setpoint_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE maquina_setpoint_seq OWNED BY maquina_setpoint.id_maquina_setpoint;


--
-- TOC entry 190 (class 1259 OID 762390)
-- Name: produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE produto (
    id_produto bigint NOT NULL,
    codigo_sap integer NOT NULL,
    descricao character varying(60) NOT NULL,
    data_registro timestamp without time zone NOT NULL,
    ativo boolean NOT NULL,
    id_tipo_produto bigint NOT NULL
);


ALTER TABLE produto OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 762393)
-- Name: produto_maquina; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE produto_maquina (
    id_produto_maquina bigint NOT NULL,
    id_produto bigint NOT NULL,
    id_maquina bigint NOT NULL,
    temperatura_secagem real NOT NULL,
    data_registro timestamp without time zone NOT NULL,
    ativo boolean NOT NULL,
    quantidade_estufas integer NOT NULL,
    num_ciclos integer NOT NULL
);


ALTER TABLE produto_maquina OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 762396)
-- Name: produto_maquina_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE produto_maquina_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE produto_maquina_seq OWNER TO postgres;

--
-- TOC entry 2218 (class 0 OID 0)
-- Dependencies: 192
-- Name: produto_maquina_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE produto_maquina_seq OWNED BY produto_maquina.id_produto_maquina;


--
-- TOC entry 193 (class 1259 OID 762398)
-- Name: produto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE produto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE produto_seq OWNER TO postgres;

--
-- TOC entry 2219 (class 0 OID 0)
-- Dependencies: 193
-- Name: produto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE produto_seq OWNED BY produto.id_produto;


--
-- TOC entry 194 (class 1259 OID 762400)
-- Name: registro_alarme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE registro_alarme (
    id_registro_alarme bigint NOT NULL,
    id_lote_maquina bigint NOT NULL,
    id_equipamento_alarme bigint NOT NULL,
    data_hora_inicio timestamp without time zone NOT NULL,
    data_hora_fim timestamp without time zone,
    complemento character varying,
    cracha bigint,
    nome_usuario character varying
);


ALTER TABLE registro_alarme OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 762406)
-- Name: registro_alarme_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE registro_alarme_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE registro_alarme_seq OWNER TO postgres;

--
-- TOC entry 2220 (class 0 OID 0)
-- Dependencies: 195
-- Name: registro_alarme_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE registro_alarme_seq OWNED BY registro_alarme.id_registro_alarme;


--
-- TOC entry 196 (class 1259 OID 762408)
-- Name: setpoint; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE setpoint (
    id_setpoint bigint NOT NULL,
    nome character varying(60) NOT NULL,
    data_registro timestamp without time zone NOT NULL,
    ativo boolean NOT NULL
);


ALTER TABLE setpoint OWNER TO postgres;

--
-- TOC entry 2221 (class 0 OID 0)
-- Dependencies: 196
-- Name: COLUMN setpoint.nome; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN setpoint.nome IS 'TEMPERATURA_ESTUFA
PERIODO_ATUALIZACAO_TEMPERATURA
DELAY_COMUNICACAO_SERIAL
ATIVA_ESTUFA_1
ATIVA_ESTUFA_2';


--
-- TOC entry 197 (class 1259 OID 762411)
-- Name: setpoint_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE setpoint_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE setpoint_seq OWNER TO postgres;

--
-- TOC entry 2222 (class 0 OID 0)
-- Dependencies: 197
-- Name: setpoint_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE setpoint_seq OWNED BY setpoint.id_setpoint;


--
-- TOC entry 198 (class 1259 OID 762413)
-- Name: tempo_etapa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tempo_etapa (
    id_tempo_etapa bigint NOT NULL,
    valor integer NOT NULL,
    data_registro timestamp without time zone NOT NULL,
    ativo boolean NOT NULL,
    id_tipo_produto_etapa bigint NOT NULL,
    id_produto_maquina bigint NOT NULL
);


ALTER TABLE tempo_etapa OWNER TO postgres;

--
-- TOC entry 2223 (class 0 OID 0)
-- Dependencies: 198
-- Name: COLUMN tempo_etapa.valor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN tempo_etapa.valor IS 'Gravado em minutos e exibido em formato HH:mm';


--
-- TOC entry 199 (class 1259 OID 762416)
-- Name: tempo_etapa_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tempo_etapa_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tempo_etapa_seq OWNER TO postgres;

--
-- TOC entry 2224 (class 0 OID 0)
-- Dependencies: 199
-- Name: tempo_etapa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tempo_etapa_seq OWNED BY tempo_etapa.id_tempo_etapa;


--
-- TOC entry 200 (class 1259 OID 762418)
-- Name: teste_atmosfera; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE teste_atmosfera (
    id_teste_atmosfera bigint NOT NULL,
    id_equipamento bigint NOT NULL,
    id_lote_maquina bigint NOT NULL,
    nivel_tecnico double precision,
    nivel_sensor double precision,
    data_hora_inicio timestamp without time zone NOT NULL,
    data_hora_fim timestamp without time zone,
    status smallint NOT NULL
);


ALTER TABLE teste_atmosfera OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 762421)
-- Name: teste_atmosfera_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE teste_atmosfera_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE teste_atmosfera_seq OWNER TO postgres;

--
-- TOC entry 2225 (class 0 OID 0)
-- Dependencies: 201
-- Name: teste_atmosfera_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE teste_atmosfera_seq OWNED BY teste_atmosfera.id_teste_atmosfera;


--
-- TOC entry 202 (class 1259 OID 762423)
-- Name: tipo_comunicacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tipo_comunicacao (
    id_tipo_comunicacao bigint NOT NULL,
    descricao character varying(60) NOT NULL,
    data_registro timestamp without time zone NOT NULL,
    ativo boolean NOT NULL
);


ALTER TABLE tipo_comunicacao OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 762426)
-- Name: tipo_comunicacao_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipo_comunicacao_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tipo_comunicacao_seq OWNER TO postgres;

--
-- TOC entry 2226 (class 0 OID 0)
-- Dependencies: 203
-- Name: tipo_comunicacao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipo_comunicacao_seq OWNED BY tipo_comunicacao.id_tipo_comunicacao;


--
-- TOC entry 204 (class 1259 OID 762428)
-- Name: tipo_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tipo_produto (
    id_tipo_produto bigint NOT NULL,
    descricao character varying(60) NOT NULL,
    data_registro timestamp without time zone NOT NULL,
    ativo boolean NOT NULL
);


ALTER TABLE tipo_produto OWNER TO postgres;

--
-- TOC entry 2227 (class 0 OID 0)
-- Dependencies: 204
-- Name: COLUMN tipo_produto.descricao; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN tipo_produto.descricao IS 'ALCOOLICO OU AQUOSO';


--
-- TOC entry 205 (class 1259 OID 762431)
-- Name: tipo_produto_etapa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tipo_produto_etapa (
    id_tipo_produto_etapa bigint NOT NULL,
    data_registro timestamp without time zone NOT NULL,
    ativo boolean NOT NULL,
    id_tipo_produto bigint NOT NULL,
    id_etapa bigint NOT NULL,
    ordem integer NOT NULL
);


ALTER TABLE tipo_produto_etapa OWNER TO postgres;

--
-- TOC entry 2228 (class 0 OID 0)
-- Dependencies: 205
-- Name: COLUMN tipo_produto_etapa.id_etapa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN tipo_produto_etapa.id_etapa IS 'somente etapas com receita = true poderão ser vinculadas';


--
-- TOC entry 2229 (class 0 OID 0)
-- Dependencies: 205
-- Name: COLUMN tipo_produto_etapa.ordem; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN tipo_produto_etapa.ordem IS 'Ordem de execução das etapas. Etapa Aeração sempre será 0.';


--
-- TOC entry 206 (class 1259 OID 762434)
-- Name: tipo_produto_etapa_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipo_produto_etapa_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tipo_produto_etapa_seq OWNER TO postgres;

--
-- TOC entry 2230 (class 0 OID 0)
-- Dependencies: 206
-- Name: tipo_produto_etapa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipo_produto_etapa_seq OWNED BY tipo_produto_etapa.id_tipo_produto_etapa;


--
-- TOC entry 207 (class 1259 OID 762436)
-- Name: tipo_produto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipo_produto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tipo_produto_seq OWNER TO postgres;

--
-- TOC entry 2231 (class 0 OID 0)
-- Dependencies: 207
-- Name: tipo_produto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipo_produto_seq OWNED BY tipo_produto.id_tipo_produto;


--
-- TOC entry 1964 (class 2604 OID 762438)
-- Name: id_alarme; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY alarme ALTER COLUMN id_alarme SET DEFAULT nextval('alarme_seq'::regclass);


--
-- TOC entry 1965 (class 2604 OID 762439)
-- Name: id_calibracao_sensor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY calibracao_sensor ALTER COLUMN id_calibracao_sensor SET DEFAULT nextval('calibracao_sensor_seq'::regclass);


--
-- TOC entry 1966 (class 2604 OID 762440)
-- Name: id_equipamento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY equipamento ALTER COLUMN id_equipamento SET DEFAULT nextval('equipamento_seq'::regclass);


--
-- TOC entry 1967 (class 2604 OID 762441)
-- Name: id_equipamento_alarme; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY equipamento_alarme ALTER COLUMN id_equipamento_alarme SET DEFAULT nextval('equipamento_alarme_seq'::regclass);


--
-- TOC entry 1968 (class 2604 OID 762442)
-- Name: id_etapa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY etapa ALTER COLUMN id_etapa SET DEFAULT nextval('etapa_seq'::regclass);


--
-- TOC entry 1969 (class 2604 OID 762443)
-- Name: id_io_equipamento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY io_equipamento ALTER COLUMN id_io_equipamento SET DEFAULT nextval('io_equipamento_seq'::regclass);


--
-- TOC entry 1970 (class 2604 OID 762444)
-- Name: id_justificativa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY justificativa ALTER COLUMN id_justificativa SET DEFAULT nextval('justificativa_seq'::regclass);


--
-- TOC entry 1971 (class 2604 OID 762445)
-- Name: id_log_etapa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY log_etapa ALTER COLUMN id_log_etapa SET DEFAULT nextval('log_etapa_seq'::regclass);


--
-- TOC entry 1972 (class 2604 OID 762446)
-- Name: id_log_processo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY log_processo ALTER COLUMN id_log_processo SET DEFAULT nextval('log_processo_seq'::regclass);


--
-- TOC entry 1973 (class 2604 OID 762447)
-- Name: id_lote; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lote ALTER COLUMN id_lote SET DEFAULT nextval('lote_seq'::regclass);


--
-- TOC entry 1974 (class 2604 OID 762448)
-- Name: id_lote_maquina; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lote_maquina ALTER COLUMN id_lote_maquina SET DEFAULT nextval('lote_maquina_seq'::regclass);


--
-- TOC entry 1975 (class 2604 OID 762449)
-- Name: id_maquina; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY maquina ALTER COLUMN id_maquina SET DEFAULT nextval('maquina_seq'::regclass);


--
-- TOC entry 1976 (class 2604 OID 762450)
-- Name: id_maquina_setpoint; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY maquina_setpoint ALTER COLUMN id_maquina_setpoint SET DEFAULT nextval('maquina_setpoint_seq'::regclass);


--
-- TOC entry 1977 (class 2604 OID 762451)
-- Name: id_produto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY produto ALTER COLUMN id_produto SET DEFAULT nextval('produto_seq'::regclass);


--
-- TOC entry 1978 (class 2604 OID 762452)
-- Name: id_produto_maquina; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY produto_maquina ALTER COLUMN id_produto_maquina SET DEFAULT nextval('produto_maquina_seq'::regclass);


--
-- TOC entry 1979 (class 2604 OID 762453)
-- Name: id_registro_alarme; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY registro_alarme ALTER COLUMN id_registro_alarme SET DEFAULT nextval('registro_alarme_seq'::regclass);


--
-- TOC entry 1980 (class 2604 OID 762454)
-- Name: id_setpoint; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY setpoint ALTER COLUMN id_setpoint SET DEFAULT nextval('setpoint_seq'::regclass);


--
-- TOC entry 1981 (class 2604 OID 762455)
-- Name: id_tempo_etapa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tempo_etapa ALTER COLUMN id_tempo_etapa SET DEFAULT nextval('tempo_etapa_seq'::regclass);


--
-- TOC entry 1982 (class 2604 OID 762456)
-- Name: id_teste_atmosfera; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teste_atmosfera ALTER COLUMN id_teste_atmosfera SET DEFAULT nextval('teste_atmosfera_seq'::regclass);


--
-- TOC entry 1983 (class 2604 OID 762457)
-- Name: id_tipo_comunicacao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_comunicacao ALTER COLUMN id_tipo_comunicacao SET DEFAULT nextval('tipo_comunicacao_seq'::regclass);


--
-- TOC entry 1984 (class 2604 OID 762458)
-- Name: id_tipo_produto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_produto ALTER COLUMN id_tipo_produto SET DEFAULT nextval('tipo_produto_seq'::regclass);


--
-- TOC entry 1985 (class 2604 OID 762459)
-- Name: id_tipo_produto_etapa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_produto_etapa ALTER COLUMN id_tipo_produto_etapa SET DEFAULT nextval('tipo_produto_etapa_seq'::regclass);


SET search_path = audit, pg_catalog;

--
-- TOC entry 2039 (class 2606 OID 762660)
-- Name: lote_aud_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres
--

ALTER TABLE ONLY lote_aud
    ADD CONSTRAINT lote_aud_pkey PRIMARY KEY (id_lote, rev);


--
-- TOC entry 2041 (class 2606 OID 762670)
-- Name: lote_maquina_aud_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres
--

ALTER TABLE ONLY lote_maquina_aud
    ADD CONSTRAINT lote_maquina_aud_pkey PRIMARY KEY (id_lote_maquina, rev);


--
-- TOC entry 2043 (class 2606 OID 762680)
-- Name: maquina_setpoint_aud_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres
--

ALTER TABLE ONLY maquina_setpoint_aud
    ADD CONSTRAINT maquina_setpoint_aud_pkey PRIMARY KEY (id_maquina_setpoint, rev);


--
-- TOC entry 2045 (class 2606 OID 762690)
-- Name: produto_aud_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres
--

ALTER TABLE ONLY produto_aud
    ADD CONSTRAINT produto_aud_pkey PRIMARY KEY (id_produto, rev);


--
-- TOC entry 2047 (class 2606 OID 762700)
-- Name: produto_maquina_aud_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres
--

ALTER TABLE ONLY produto_maquina_aud
    ADD CONSTRAINT produto_maquina_aud_pkey PRIMARY KEY (id_produto_maquina, rev);


--
-- TOC entry 2037 (class 2606 OID 762655)
-- Name: revinfo_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres
--

ALTER TABLE ONLY revinfo
    ADD CONSTRAINT revinfo_pkey PRIMARY KEY (rev);


--
-- TOC entry 2049 (class 2606 OID 762710)
-- Name: setpoint_aud_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres
--

ALTER TABLE ONLY setpoint_aud
    ADD CONSTRAINT setpoint_aud_pkey PRIMARY KEY (id_setpoint, rev);


--
-- TOC entry 2051 (class 2606 OID 762720)
-- Name: tempo_etapa_aud_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres
--

ALTER TABLE ONLY tempo_etapa_aud
    ADD CONSTRAINT tempo_etapa_aud_pkey PRIMARY KEY (id_tempo_etapa, rev);


SET search_path = public, pg_catalog;

--
-- TOC entry 1989 (class 2606 OID 762461)
-- Name: calibracao_sensor_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY calibracao_sensor
    ADD CONSTRAINT calibracao_sensor_pk PRIMARY KEY (id_calibracao_sensor);


--
-- TOC entry 1996 (class 2606 OID 762463)
-- Name: equipamento_alarme_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY equipamento_alarme
    ADD CONSTRAINT equipamento_alarme_pk PRIMARY KEY (id_equipamento_alarme);


--
-- TOC entry 1987 (class 2606 OID 762465)
-- Name: id_alarme; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY alarme
    ADD CONSTRAINT id_alarme PRIMARY KEY (id_alarme);


--
-- TOC entry 1992 (class 2606 OID 762467)
-- Name: id_equipamento; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY equipamento
    ADD CONSTRAINT id_equipamento PRIMARY KEY (id_equipamento);


--
-- TOC entry 1999 (class 2606 OID 762469)
-- Name: id_etapa; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY etapa
    ADD CONSTRAINT id_etapa PRIMARY KEY (id_etapa);


--
-- TOC entry 2005 (class 2606 OID 762471)
-- Name: id_log_etapa; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY log_etapa
    ADD CONSTRAINT id_log_etapa PRIMARY KEY (id_log_etapa);


--
-- TOC entry 2007 (class 2606 OID 762473)
-- Name: id_log_processo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY log_processo
    ADD CONSTRAINT id_log_processo PRIMARY KEY (id_log_processo);


--
-- TOC entry 2009 (class 2606 OID 762475)
-- Name: id_lote; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lote
    ADD CONSTRAINT id_lote PRIMARY KEY (id_lote);


--
-- TOC entry 2011 (class 2606 OID 762477)
-- Name: id_lote_maquina; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lote_maquina
    ADD CONSTRAINT id_lote_maquina PRIMARY KEY (id_lote_maquina);


--
-- TOC entry 2013 (class 2606 OID 762479)
-- Name: id_maquina; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY maquina
    ADD CONSTRAINT id_maquina PRIMARY KEY (id_maquina);


--
-- TOC entry 2016 (class 2606 OID 762481)
-- Name: id_maquina_setpoint; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY maquina_setpoint
    ADD CONSTRAINT id_maquina_setpoint PRIMARY KEY (id_maquina_setpoint);


--
-- TOC entry 2018 (class 2606 OID 762483)
-- Name: id_produto; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY produto
    ADD CONSTRAINT id_produto PRIMARY KEY (id_produto);


--
-- TOC entry 2021 (class 2606 OID 762485)
-- Name: id_produto_maquina; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY produto_maquina
    ADD CONSTRAINT id_produto_maquina PRIMARY KEY (id_produto_maquina);


--
-- TOC entry 2023 (class 2606 OID 762487)
-- Name: id_registro_alarme; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY registro_alarme
    ADD CONSTRAINT id_registro_alarme PRIMARY KEY (id_registro_alarme);


--
-- TOC entry 2025 (class 2606 OID 762489)
-- Name: id_setpoint; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY setpoint
    ADD CONSTRAINT id_setpoint PRIMARY KEY (id_setpoint);


--
-- TOC entry 2027 (class 2606 OID 762491)
-- Name: id_tempo_etapa; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tempo_etapa
    ADD CONSTRAINT id_tempo_etapa PRIMARY KEY (id_tempo_etapa);


--
-- TOC entry 2031 (class 2606 OID 762493)
-- Name: id_tipo_comunicacao; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_comunicacao
    ADD CONSTRAINT id_tipo_comunicacao PRIMARY KEY (id_tipo_comunicacao);


--
-- TOC entry 2033 (class 2606 OID 762495)
-- Name: id_tipo_produto; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_produto
    ADD CONSTRAINT id_tipo_produto PRIMARY KEY (id_tipo_produto);


--
-- TOC entry 2035 (class 2606 OID 762497)
-- Name: id_tipo_produto_etapa; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_produto_etapa
    ADD CONSTRAINT id_tipo_produto_etapa PRIMARY KEY (id_tipo_produto_etapa);


--
-- TOC entry 2001 (class 2606 OID 762499)
-- Name: io_equipamento_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY io_equipamento
    ADD CONSTRAINT io_equipamento_pk PRIMARY KEY (id_io_equipamento);


--
-- TOC entry 2003 (class 2606 OID 762501)
-- Name: justificativa_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY justificativa
    ADD CONSTRAINT justificativa_pk PRIMARY KEY (id_justificativa);


--
-- TOC entry 2029 (class 2606 OID 762503)
-- Name: teste_atmosfera_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teste_atmosfera
    ADD CONSTRAINT teste_atmosfera_pk PRIMARY KEY (id_teste_atmosfera);


--
-- TOC entry 1993 (class 1259 OID 762504)
-- Name: equipamento_alarme_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX equipamento_alarme_idx ON equipamento_alarme USING btree (id_alarme, codigo, id_equipamento);


--
-- TOC entry 1994 (class 1259 OID 762505)
-- Name: equipamento_alarme_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX equipamento_alarme_idx1 ON equipamento_alarme USING btree (id_alarme, codigo_reset, id_equipamento);


--
-- TOC entry 1990 (class 1259 OID 762506)
-- Name: equipamento_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX equipamento_idx ON equipamento USING btree (tag);


--
-- TOC entry 1997 (class 1259 OID 762507)
-- Name: etapa_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX etapa_idx ON etapa USING btree (tipo);


--
-- TOC entry 2014 (class 1259 OID 762508)
-- Name: maquina_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX maquina_idx ON maquina USING btree (tag);


--
-- TOC entry 2019 (class 1259 OID 762509)
-- Name: produto_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX produto_idx ON produto USING btree (codigo_sap);


SET search_path = audit, pg_catalog;

--
-- TOC entry 2080 (class 2606 OID 762661)
-- Name: fk_a7fvsse3kx29uq1jrgxnbbamf; Type: FK CONSTRAINT; Schema: audit; Owner: postgres
--

ALTER TABLE ONLY lote_aud
    ADD CONSTRAINT fk_a7fvsse3kx29uq1jrgxnbbamf FOREIGN KEY (rev) REFERENCES revinfo(rev);


--
-- TOC entry 2086 (class 2606 OID 762721)
-- Name: fk_b3p8uajsyhj3npf8tguiovj8g; Type: FK CONSTRAINT; Schema: audit; Owner: postgres
--

ALTER TABLE ONLY tempo_etapa_aud
    ADD CONSTRAINT fk_b3p8uajsyhj3npf8tguiovj8g FOREIGN KEY (rev) REFERENCES revinfo(rev);


--
-- TOC entry 2083 (class 2606 OID 762691)
-- Name: fk_d1nbwhyn73g0erq2sp407dhb; Type: FK CONSTRAINT; Schema: audit; Owner: postgres
--

ALTER TABLE ONLY produto_aud
    ADD CONSTRAINT fk_d1nbwhyn73g0erq2sp407dhb FOREIGN KEY (rev) REFERENCES revinfo(rev);


--
-- TOC entry 2085 (class 2606 OID 762711)
-- Name: fk_grw9uomgupwhgvkft6esgosad; Type: FK CONSTRAINT; Schema: audit; Owner: postgres
--

ALTER TABLE ONLY setpoint_aud
    ADD CONSTRAINT fk_grw9uomgupwhgvkft6esgosad FOREIGN KEY (rev) REFERENCES revinfo(rev);


--
-- TOC entry 2081 (class 2606 OID 762671)
-- Name: fk_i325em34cvqw5cbgxsq93tcdu; Type: FK CONSTRAINT; Schema: audit; Owner: postgres
--

ALTER TABLE ONLY lote_maquina_aud
    ADD CONSTRAINT fk_i325em34cvqw5cbgxsq93tcdu FOREIGN KEY (rev) REFERENCES revinfo(rev);


--
-- TOC entry 2084 (class 2606 OID 762701)
-- Name: fk_lj6cmc5h8nxowgo2askjxuxkp; Type: FK CONSTRAINT; Schema: audit; Owner: postgres
--

ALTER TABLE ONLY produto_maquina_aud
    ADD CONSTRAINT fk_lj6cmc5h8nxowgo2askjxuxkp FOREIGN KEY (rev) REFERENCES revinfo(rev);


--
-- TOC entry 2082 (class 2606 OID 762681)
-- Name: fk_sqdor1thh4guk97vwhai9turl; Type: FK CONSTRAINT; Schema: audit; Owner: postgres
--

ALTER TABLE ONLY maquina_setpoint_aud
    ADD CONSTRAINT fk_sqdor1thh4guk97vwhai9turl FOREIGN KEY (rev) REFERENCES revinfo(rev);


SET search_path = public, pg_catalog;

--
-- TOC entry 2055 (class 2606 OID 762510)
-- Name: alarme_equipamento_alarme_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY equipamento_alarme
    ADD CONSTRAINT alarme_equipamento_alarme_fk FOREIGN KEY (id_alarme) REFERENCES alarme(id_alarme);


--
-- TOC entry 2072 (class 2606 OID 762515)
-- Name: equipamento_alarme_registro_alarme_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY registro_alarme
    ADD CONSTRAINT equipamento_alarme_registro_alarme_fk FOREIGN KEY (id_equipamento_alarme) REFERENCES equipamento_alarme(id_equipamento_alarme);


--
-- TOC entry 2052 (class 2606 OID 762520)
-- Name: equipamento_calibracao_sensor_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY calibracao_sensor
    ADD CONSTRAINT equipamento_calibracao_sensor_fk FOREIGN KEY (id_equipamento) REFERENCES equipamento(id_equipamento);


--
-- TOC entry 2056 (class 2606 OID 762525)
-- Name: equipamento_equipamento_alarme_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY equipamento_alarme
    ADD CONSTRAINT equipamento_equipamento_alarme_fk FOREIGN KEY (id_equipamento) REFERENCES equipamento(id_equipamento);


--
-- TOC entry 2057 (class 2606 OID 762530)
-- Name: equipamento_io_equipamento_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY io_equipamento
    ADD CONSTRAINT equipamento_io_equipamento_fk FOREIGN KEY (id_equipamento) REFERENCES equipamento(id_equipamento);


--
-- TOC entry 2058 (class 2606 OID 762535)
-- Name: equipamento_log_etapa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY log_etapa
    ADD CONSTRAINT equipamento_log_etapa_fk FOREIGN KEY (id_equipamento) REFERENCES equipamento(id_equipamento);


--
-- TOC entry 2062 (class 2606 OID 762540)
-- Name: equipamento_log_processo_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY log_processo
    ADD CONSTRAINT equipamento_log_processo_fk FOREIGN KEY (id_equipamento) REFERENCES equipamento(id_equipamento);


--
-- TOC entry 2076 (class 2606 OID 762545)
-- Name: equipamento_teste_atmosfera_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teste_atmosfera
    ADD CONSTRAINT equipamento_teste_atmosfera_fk FOREIGN KEY (id_equipamento) REFERENCES equipamento(id_equipamento);


--
-- TOC entry 2078 (class 2606 OID 762550)
-- Name: etapa_tipo_produto_etapa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_produto_etapa
    ADD CONSTRAINT etapa_tipo_produto_etapa_fk FOREIGN KEY (id_etapa) REFERENCES etapa(id_etapa);


--
-- TOC entry 2059 (class 2606 OID 762555)
-- Name: justificativa_log_etapa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY log_etapa
    ADD CONSTRAINT justificativa_log_etapa_fk FOREIGN KEY (id_justificativa) REFERENCES justificativa(id_justificativa);


--
-- TOC entry 2065 (class 2606 OID 762560)
-- Name: lote_log_lote_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lote_maquina
    ADD CONSTRAINT lote_log_lote_fk FOREIGN KEY (id_lote) REFERENCES lote(id_lote);


--
-- TOC entry 2073 (class 2606 OID 762565)
-- Name: lote_maquina_alarme_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY registro_alarme
    ADD CONSTRAINT lote_maquina_alarme_fk FOREIGN KEY (id_lote_maquina) REFERENCES lote_maquina(id_lote_maquina);


--
-- TOC entry 2060 (class 2606 OID 762570)
-- Name: lote_maquina_log_etapa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY log_etapa
    ADD CONSTRAINT lote_maquina_log_etapa_fk FOREIGN KEY (id_lote_maquina) REFERENCES lote_maquina(id_lote_maquina);


--
-- TOC entry 2063 (class 2606 OID 762575)
-- Name: lote_maquina_log_processo_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY log_processo
    ADD CONSTRAINT lote_maquina_log_processo_fk FOREIGN KEY (id_lote_maquina) REFERENCES lote_maquina(id_lote_maquina);


--
-- TOC entry 2077 (class 2606 OID 762580)
-- Name: lote_maquina_nivel_alcool_lote_maquina_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teste_atmosfera
    ADD CONSTRAINT lote_maquina_nivel_alcool_lote_maquina_fk FOREIGN KEY (id_lote_maquina) REFERENCES lote_maquina(id_lote_maquina);


--
-- TOC entry 2053 (class 2606 OID 762585)
-- Name: maquina_equipamento_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY equipamento
    ADD CONSTRAINT maquina_equipamento_fk FOREIGN KEY (id_maquina) REFERENCES maquina(id_maquina);


--
-- TOC entry 2066 (class 2606 OID 762590)
-- Name: maquina_lote_maquina_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lote_maquina
    ADD CONSTRAINT maquina_lote_maquina_fk FOREIGN KEY (id_maquina) REFERENCES maquina(id_maquina);


--
-- TOC entry 2067 (class 2606 OID 762595)
-- Name: maquina_maquina_setpoint_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY maquina_setpoint
    ADD CONSTRAINT maquina_maquina_setpoint_fk FOREIGN KEY (id_maquina) REFERENCES maquina(id_maquina);


--
-- TOC entry 2070 (class 2606 OID 762600)
-- Name: maquina_produto_maquina_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY produto_maquina
    ADD CONSTRAINT maquina_produto_maquina_fk FOREIGN KEY (id_maquina) REFERENCES maquina(id_maquina);


--
-- TOC entry 2064 (class 2606 OID 762605)
-- Name: produto_lote_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lote
    ADD CONSTRAINT produto_lote_fk FOREIGN KEY (id_produto) REFERENCES produto(id_produto);


--
-- TOC entry 2074 (class 2606 OID 762610)
-- Name: produto_maquina_receita_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tempo_etapa
    ADD CONSTRAINT produto_maquina_receita_fk FOREIGN KEY (id_produto_maquina) REFERENCES produto_maquina(id_produto_maquina);


--
-- TOC entry 2071 (class 2606 OID 762615)
-- Name: produto_produto_maquina_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY produto_maquina
    ADD CONSTRAINT produto_produto_maquina_fk FOREIGN KEY (id_produto) REFERENCES produto(id_produto);


--
-- TOC entry 2068 (class 2606 OID 762620)
-- Name: setpoint_maquina_setpoint_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY maquina_setpoint
    ADD CONSTRAINT setpoint_maquina_setpoint_fk FOREIGN KEY (id_setpoint) REFERENCES setpoint(id_setpoint);


--
-- TOC entry 2061 (class 2606 OID 762625)
-- Name: tempo_etapa_log_etapa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY log_etapa
    ADD CONSTRAINT tempo_etapa_log_etapa_fk FOREIGN KEY (id_tempo_etapa) REFERENCES tempo_etapa(id_tempo_etapa);


--
-- TOC entry 2054 (class 2606 OID 762630)
-- Name: tipo_comunicacao_equipamento_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY equipamento
    ADD CONSTRAINT tipo_comunicacao_equipamento_fk FOREIGN KEY (id_tipo_comunicacao) REFERENCES tipo_comunicacao(id_tipo_comunicacao);


--
-- TOC entry 2075 (class 2606 OID 762635)
-- Name: tipo_produto_etapa_receita_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tempo_etapa
    ADD CONSTRAINT tipo_produto_etapa_receita_fk FOREIGN KEY (id_tipo_produto_etapa) REFERENCES tipo_produto_etapa(id_tipo_produto_etapa);


--
-- TOC entry 2069 (class 2606 OID 762640)
-- Name: tipo_produto_produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY produto
    ADD CONSTRAINT tipo_produto_produto_fk FOREIGN KEY (id_tipo_produto) REFERENCES tipo_produto(id_tipo_produto);


--
-- TOC entry 2079 (class 2606 OID 762645)
-- Name: tipo_produto_tipo_produto_etapa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_produto_etapa
    ADD CONSTRAINT tipo_produto_tipo_produto_etapa_fk FOREIGN KEY (id_tipo_produto) REFERENCES tipo_produto(id_tipo_produto);


--
-- TOC entry 2194 (class 0 OID 0)
-- Dependencies: 8
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2017-09-01 18:29:00

--
-- PostgreSQL database dump complete
--

