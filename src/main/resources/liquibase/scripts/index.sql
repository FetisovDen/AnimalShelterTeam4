--liquibase formatted sql

--changeset dfetisov:1
--precondition-sql-check expectedResult:0 SELECT count(*) FROM pg_tables WHERE tablename='chat'
--onFail=MARK_RAN
CREATE TABLE chat
(
    id           BIGINT PRIMARY KEY generated always as identity,
    name         TEXT NOT NULL,
    phone        VARCHAR(15),
    address      TEXT,
    is_volunteer BOOLEAN DEFAULT FALSE
);

--changeset dfetisov:2
--precondition-sql-check expectedResult:0 SELECT count(*) FROM pg_tables WHERE tablename='call_request'
--onFail=MARK_RAN
CREATE TABLE call_request
(
    id                    BIGINT PRIMARY KEY generated always as identity,
    id_chat_client        BIGINT    NOT NULL REFERENCES chat (id),
    id_chat_volunteer     BIGINT REFERENCES chat (id),
    is_open               BOOLEAN DEFAULT TRUE,
    local_date_time_open  TIMESTAMP NOT NULL,
    local_date_time_close TIMESTAMP
);

--changeset zaytsev:3
--precondition-sql-check expectedResult:1 SELECT count(*) FROM pg_tables WHERE tablename='chat'
--onFail=MARK_RAN
alter table chat
    alter column id drop identity;

--changeset dfetisov:4
--precondition-sql-check expectedResult:0 SELECT count(*) FROM pg_tables WHERE tablename='dog_owner'
--onFail=MARK_RAN
CREATE TABLE dog_owner
(
    id            BIGINT PRIMARY KEY generated always as identity,
    name_Dog       TEXT NOT NULL,
    id_chat_owner BIGINT REFERENCES chat (id)
);

--changeset dfetisov:5
--precondition-sql-check expectedResult:1 SELECT count(*) FROM pg_tables WHERE tablename='chat'
--onFail=MARK_RAN
ALTER TABLE chat
ADD COLUMN is_owner BOOLEAN DEFAULT FALSE;