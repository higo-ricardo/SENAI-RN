/* ============================================================
   Projeto: Jogo de RPG online
   Aluno: Higo Ricardo
   SGBD:    SQL Server
   Script:  Criação do banco de dados e das tabelas de Jogo RPG
   ============================================================ */

-- 1. CRIAÇÃO DO DATABASE 
IF DB_ID('rpg_online') IS NULL -- se ainda não existir, criar novo
    CREATE DATABASE rpg_online;
GO

-- 2. SELECIONAR O DATABASE CRIADO
USE rpg_online;
GO

-- 3. CRIAÇÃO DA TABELA USUARIOS
CREATE TABLE Usuarios (
    UsuarioId INT IDENTITY(1,1) NOT NULL, -- chave primária
    Email     VARCHAR(150)      NOT NULL,
    Senha     VARCHAR(255)      NOT NULL,
    CONSTRAINT pk_usuarios PRIMARY KEY (UsuarioId),
    CONSTRAINT uq_usuarios_email UNIQUE (Email)
);
GO

-- 4. CRIAÇÃO DA TABELA CLASSES
CREATE TABLE Classes (
    ClasseId  INT IDENTITY(1,1) NOT NULL,
    Nome      VARCHAR(50)       NOT NULL,
    Descricao VARCHAR(255)      NULL,
    CONSTRAINT pk_classes PRIMARY KEY (ClasseId),
    CONSTRAINT uq_classes_nome UNIQUE (Nome)
);
GO

-- 5. CRIAÇÃO DA TABELA HABILIDADES
CREATE TABLE Habilidades (
    HabilidadeId INT IDENTITY(1,1) NOT NULL,
    Nome         VARCHAR(50)       NOT NULL,
    CONSTRAINT pk_habilidades PRIMARY KEY (HabilidadeId),
    CONSTRAINT uq_habilidades_nome UNIQUE (Nome)
);
GO

-- 6. CRIAÇÃO DA TABELA PERSONAGENS
CREATE TABLE Personagens (
    PersonagemId   INT IDENTITY(1,1) NOT NULL, --  chave primária
    NomePersonagem VARCHAR(50)       NOT NULL,
    UsuarioId      INT               NOT NULL, -- chave estrangeira
    ClasseId       INT               NOT NULL, 
    CONSTRAINT pk_personagens PRIMARY KEY (PersonagemId),
    CONSTRAINT uq_personagens_nome UNIQUE (NomePersonagem),
    CONSTRAINT fk_personagens_usuarios
        FOREIGN KEY (UsuarioId) REFERENCES USUARIOS (UsuarioId),
    CONSTRAINT fk_personagens_classes
        FOREIGN KEY (ClasseId) REFERENCES CLASSES (ClasseId)
);
GO

-- 7. CRIAÇÃO DA TABELA CLASSES_HABILIDADES (Tabela associativa)
CREATE TABLE Classes_Habilidades (
    ClasseId     INT NOT NULL, --   Cada coluna é FK
    HabilidadeId INT NOT NULL,
    CONSTRAINT pk_classes_habilidades PRIMARY KEY (ClasseId, HabilidadeId),
    CONSTRAINT fk_classes_habilidades_classes
        FOREIGN KEY (ClasseId) REFERENCES CLASSES (ClasseId),
    CONSTRAINT fk_classes_habilidades_habilidades
        FOREIGN KEY (HabilidadeId) REFERENCES HABILIDADES (HabilidadeId)
);
GO
