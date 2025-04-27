CREATE DATABASE IF NOT EXISTS tcc_cfg;
USE tcc_cfg;

-- Excluir tabelas se já existirem
DROP TABLE IF EXISTS Avaliacoes;
DROP TABLE IF EXISTS Agendamentos;
DROP TABLE IF EXISTS Consultas;
DROP TABLE IF EXISTS Exames;
DROP TABLE IF EXISTS Feedback;
DROP TABLE IF EXISTS Noticias;
DROP TABLE IF EXISTS Ouvidoria;
DROP TABLE IF EXISTS Produtos;
DROP TABLE IF EXISTS Registros;
DROP TABLE IF EXISTS RenovacoesRecepcao;
DROP TABLE IF EXISTS Acolhimento;
DROP TABLE IF EXISTS SistemaTriagem;
DROP TABLE IF EXISTS Vacinacoes;
DROP TABLE IF EXISTS Horarios;
DROP TABLE IF EXISTS Consultorios;
DROP TABLE IF EXISTS Profissionais;
DROP TABLE IF EXISTS Usuarios;
DROP TABLE IF EXISTS Eventos;

-- Recriar tabelas
CREATE TABLE Usuarios (
    usuario_id INT PRIMARY KEY AUTO_INCREMENT,
    nome_usuario VARCHAR(50) NOT NULL,
    senha VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    papel ENUM('usuario', 'administrador') NOT NULL,
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Profissionais (
    profissional_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    especializacao VARCHAR(100),
    contato VARCHAR(100),
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Registros (
    registro_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NULL,
    nome_completo VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    endereco VARCHAR(255),
    telefone VARCHAR(20),
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id) ON DELETE SET NULL
);

CREATE TABLE Agendamentos (
    agendamento_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT,
    profissional_id INT,
    data_agendamento DATETIME NOT NULL,
    status ENUM('agendado', 'concluído', 'cancelado') DEFAULT 'agendado',
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id) ON DELETE CASCADE,
    FOREIGN KEY (profissional_id) REFERENCES Profissionais(profissional_id) ON DELETE SET NULL
);

CREATE TABLE Avaliacoes (
    avaliacao_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT,
    profissional_id INT,
    agendamento_id INT,
    nota INT CHECK (nota BETWEEN 1 AND 5),
    comentarios TEXT,
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id) ON DELETE CASCADE,
    FOREIGN KEY (profissional_id) REFERENCES Profissionais(profissional_id) ON DELETE SET NULL,
    FOREIGN KEY (agendamento_id) REFERENCES Agendamentos(agendamento_id) ON DELETE SET NULL
);

CREATE TABLE Ouvidoria (
    ouvidoria_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT,
    assunto VARCHAR(100),
    descricao TEXT,
    status ENUM('aberto', 'resolvido', 'fechado') DEFAULT 'aberto',
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id) ON DELETE CASCADE
);

CREATE TABLE Feedback (
    feedback_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT,
    assunto VARCHAR(100),
    mensagem TEXT,
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id) ON DELETE CASCADE
);

CREATE TABLE Noticias (
    noticia_id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100),
    conteudo TEXT,
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario_id INT,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id) ON DELETE SET NULL
);

CREATE TABLE Produtos (
    produto_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    descricao TEXT,
    categoria ENUM('auxiliar', 'recepcionista'),
    preco DECIMAL(10, 2),
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    profissional_id INT,
    FOREIGN KEY (profissional_id) REFERENCES Profissionais(profissional_id) ON DELETE SET NULL
);

CREATE TABLE Exames (
    exame_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NULL,
    profissional_id INT NULL,
    data_exame DATETIME,
    resultados TEXT,
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id) ON DELETE SET NULL,
    FOREIGN KEY (profissional_id) REFERENCES Profissionais(profissional_id) ON DELETE SET NULL
);

CREATE TABLE Consultas (
    consulta_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NULL,
    profissional_id INT NULL,
    data_consulta DATETIME,
    diagnostico TEXT,
    prescricao TEXT,
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id) ON DELETE SET NULL,
    FOREIGN KEY (profissional_id) REFERENCES Profissionais(profissional_id) ON DELETE SET NULL
);

CREATE TABLE RenovacoesRecepcao (
    renovacao_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT,
    detalhes TEXT,
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id) ON DELETE CASCADE
);

CREATE TABLE Acolhimento (
    acolhimento_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT,
    enfermeira_id INT,
    comentarios TEXT,
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id) ON DELETE CASCADE
);

CREATE TABLE SistemaTriagem (
    triagem_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT,
    profissional_id INT NULL,
    detalhes_triagem TEXT,
    prescricao TEXT,
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id) ON DELETE CASCADE,
    FOREIGN KEY (profissional_id) REFERENCES Profissionais(profissional_id) ON DELETE SET NULL
);

CREATE TABLE Vacinacoes (
    vacinacao_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT,
    nome_vacina VARCHAR(100),
    data_vacinacao DATETIME,
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id) ON DELETE CASCADE
);

CREATE TABLE Consultorios (
    consultorio_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    endereco VARCHAR(255),
    telefone VARCHAR(20),
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Horarios (
    horario_id INT PRIMARY KEY AUTO_INCREMENT,
    profissional_id INT,
    consultorio_id INT,
    data_disponivel DATETIME,
    status ENUM('disponível', 'reservado', 'indisponível') DEFAULT 'disponível',
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (profissional_id) REFERENCES Profissionais(profissional_id) ON DELETE CASCADE,
    FOREIGN KEY (consultorio_id) REFERENCES Consultorios(consultorio_id) ON DELETE SET NULL
);

CREATE TABLE Eventos (
    evento_id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100),
    descricao TEXT,
    data_evento DATETIME,
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario_id INT,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id) ON DELETE SET NULL
);