/*
Autor: Henrique Gonçalves
Atividade 15A - Banco de dados (Stored Procedures)
Data: 18/10/2025
*/


DROP DATABASE IF EXISTS senaiTurmas;

CREATE DATABASE senaiTurmas;

USE senaiTurmas;

CREATE TABLE alunos (
	idAluno INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    situacao VARCHAR(10) NOT NULL
);

CREATE TABLE cursos (
	idCurso INT AUTO_INCREMENT PRIMARY KEY,
    nomeCurso VARCHAR(150) NOT NULL,
    cargaHoraria DECIMAL (10, 2) NOT NULL
);

CREATE TABLE matriculas (
	idMatricula INT AUTO_INCREMENT PRIMARY KEY,
    idAluno INT NOT NULL,
    idCurso INT NOT NULL,
    dataMatricula DATE NOT NULL,
    statusMatricula VARCHAR(30) NOT NULL,
    notaFinal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (idAluno) REFERENCES alunos (idAluno),
    FOREIGN KEY (idCurso) REFERENCES cursos (idCurso)
);

CREATE TABLE produtos (
	idProduto INT AUTO_INCREMENT PRIMARY KEY,
    nomeProduto VARCHAR(150) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL
);

CREATE TABLE pedidos (
	idPedido INT AUTO_INCREMENT PRIMARY KEY,
    idAluno INT NOT NULL,
    dataPedido DATE NOT NULL,
    valorTotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (idAluno) REFERENCES alunos (idAluno)
);

CREATE TABLE itensPedido (
	idItens INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT NOT NULL,
    idProduto INT NOT NULL,
    quantidade INT NOT NULL,
    valorUnitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (idPedido) REFERENCES pedidos (idPedido),
    FOREIGN KEY (idProduto) REFERENCES produtos (idProduto)
);

DELIMITER **
	CREATE PROCEDURE cadastrarAlunos(
		IN a_nome VARCHAR(150),
        IN a_email VARCHAR(150),
        IN a_situacao VARCHAR(10)
    )
    
    BEGIN
		INSERT INTO alunos (nome, email, situacao)
        VALUES (a_nome, a_email, a_situacao);
	END **
DELIMITER ;

CALL cadastrarAlunos('Amênio Souza', 'amenioalegrinho11@gmail.com', 'Ativo');
CALL cadastrarAlunos('Lucas Silva', 'lucassi00@gmail.com', 'Ativo');
CALL cadastrarAlunos('Ana Oliveira', 'aninhaon1134@gmail.com', 'Ativo');
CALL cadastrarAlunos('Luana Souza', 'luanaem2144@gmail.com', 'Ativo');
CALL cadastrarAlunos('Gabriel Boggart', 'gabrielexmaquinagames12@gmail.com', 'Inativo');
CALL cadastrarAlunos('Dereck Santos', 'dedecolivre115@gmail.com', 'Inativo');
CALL cadastrarAlunos('Maria Amaral', 'obedecaobed00143@gmail.com', 'Inativo');
CALL cadastrarAlunos('Thorin Escudo de Carvalho', 'realreisobreamontanha@gmail.com', 'Ativo');
CALL cadastrarAlunos('Bilbo Bolseiro', 'bilbotranquilao114@gmail.com', 'Ativo');
CALL cadastrarAlunos('Onix Prates', 'onixprata2018@gmail.com', 'Ativo');

DELIMITER **
	CREATE PROCEDURE listarPorSituacao(
		IN a_situacao VARCHAR(10)
    )
    
    BEGIN
		IF a_situacao != 'ativo' AND a_situacao != 'inativo' THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERRO! A situação digitada é inválida';
		END IF;
    
		SELECT 
        nome as 'Nome do aluno',
        email as 'Email do aluno',
        situacao as 'Situacao do aluno'
        FROM alunos
        WHERE situacao = a_situacao;
    END **
DELIMITER ;

DELIMITER **
	CREATE PROCEDURE atualizarSituacao(
		IN a_idAluno INT,
        IN a_situacao VARCHAR(10)
    )
    
    BEGIN
		UPDATE alunos
        SET situacao = a_situacao
        WHERE a_idAluno = idAluno;
    END **
DELIMITER ;

INSERT INTO cursos (nomeCurso, cargaHoraria)
VALUES
('Desenvolvimento de Sistemas', 3200),
('Mecatrônica', 2200),
('Enfermagem', 1200),
('Aprendizagem de Mecatrônica', 600),
('Aprendizagem de Enfermagem', 600);

DELIMITER **
	CREATE PROCEDURE listarCursos_porCargaHoraria(
		IN c_cargaMinima DECIMAL(10, 2)
	)
    
    BEGIN
		SELECT
        nomeCurso as 'Curso',
        cargaHoraria as 'Carga Horária'
        FROM cursos
        WHERE cargaHoraria > c_cargaMinima;
    END **
DELIMITER ;

CALL listarCursos_porCargaHoraria (800);
