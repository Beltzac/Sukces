-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           5.5.27 - MySQL Community Server (GPL)
-- OS do Servidor:               Win32
-- HeidiSQL Versão:              8.0.0.4444
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Copiando estrutura do banco de dados para lolwtf2
CREATE DATABASE IF NOT EXISTS `lolwtf2` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `lolwtf2`;


-- Copiando estrutura para tabela lolwtf2.categoria
CREATE TABLE IF NOT EXISTS `categoria` (
  `cod` int(10) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  PRIMARY KEY (`cod`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela lolwtf2.categoria: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` (`cod`, `nome`) VALUES
	(0, 'Lancamentos'),
	(1, 'Canecas'),
	(2, 'Camisetas'),
	(3, 'Chaveiro'),
	(4, 'Relogio');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;


-- Copiando estrutura para tabela lolwtf2.contem
CREATE TABLE IF NOT EXISTS `contem` (
  `quantidade` int(7) NOT NULL,
  `preco` float(8,2) NOT NULL,
  `cod_prod` int(10) NOT NULL,
  `cod_ped` int(10) NOT NULL,
  PRIMARY KEY (`cod_prod`,`cod_ped`),
  KEY `cod_prod` (`cod_prod`),
  KEY `cod_ped` (`cod_ped`),
  CONSTRAINT `contem_ibfk_1` FOREIGN KEY (`cod_prod`) REFERENCES `produto` (`cod_prod`),
  CONSTRAINT `contem_ibfk_2` FOREIGN KEY (`cod_ped`) REFERENCES `pedido` (`cod_pedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela lolwtf2.contem: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `contem` DISABLE KEYS */;
INSERT INTO `contem` (`quantidade`, `preco`, `cod_prod`, `cod_ped`) VALUES
	(1, 1599.00, 32, 2);
/*!40000 ALTER TABLE `contem` ENABLE KEYS */;


-- Copiando estrutura para tabela lolwtf2.endereco
CREATE TABLE IF NOT EXISTS `endereco` (
  `rua` varchar(30) NOT NULL,
  `num` varchar(30) NOT NULL,
  `complemento` varchar(500) DEFAULT NULL,
  `cidade` varchar(30) NOT NULL,
  `estado` varchar(2) NOT NULL,
  `cep` varchar(50) NOT NULL,
  `cod_end` int(10) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`cod_end`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela lolwtf2.endereco: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `endereco` DISABLE KEYS */;
INSERT INTO `endereco` (`rua`, `num`, `complemento`, `cidade`, `estado`, `cep`, `cod_end`) VALUES
	('Aristides Cooper', '55', 'casa', 'Curitiba', 'PR', '82', 1),
	('rua aleatoria', '12', 'apto 308', 'Curitiba', 'PR', '91.282-490', 2),
	('87986986986986', '9869698686', '97988977', 'dssdfs', 'AC', '23.523-532', 3),
	('98698696986', '8698698698', 'efwf', '235235', 'AC', '23.235-325', 4);
/*!40000 ALTER TABLE `endereco` ENABLE KEYS */;


-- Copiando estrutura para tabela lolwtf2.marca
CREATE TABLE IF NOT EXISTS `marca` (
  `codmarc` int(10) NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) NOT NULL,
  PRIMARY KEY (`codmarc`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela lolwtf2.marca: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `marca` DISABLE KEYS */;
INSERT INTO `marca` (`codmarc`, `nome`) VALUES
	(1, 'Sony'),
	(2, 'Apple'),
	(3, 'Samsung'),
	(4, 'Nokia'),
	(5, 'LG'),
	(6, 'Motorola');
/*!40000 ALTER TABLE `marca` ENABLE KEYS */;


-- Copiando estrutura para tabela lolwtf2.pedido
CREATE TABLE IF NOT EXISTS `pedido` (
  `situacao` varchar(100) NOT NULL,
  `cod_pedido` int(10) NOT NULL AUTO_INCREMENT,
  `forma_d_entreg` varchar(40) DEFAULT NULL,
  `forma_d_pag` varchar(40) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_p` int(11) NOT NULL,
  `cod_end` int(8) NOT NULL,
  PRIMARY KEY (`cod_pedido`),
  KEY `id_p` (`id_p`),
  KEY `cod_end` (`cod_end`),
  CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`id_p`) REFERENCES `pessoa` (`id`),
  CONSTRAINT `pedido_ibfk_2` FOREIGN KEY (`cod_end`) REFERENCES `endereco` (`cod_end`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela lolwtf2.pedido: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` (`situacao`, `cod_pedido`, `forma_d_entreg`, `forma_d_pag`, `data`, `id_p`, `cod_end`) VALUES
	('a enviar', 2, 'PAC', 'HSBC', '2014-03-07 14:22:51', 1, 1),
	('carrinho', 3, NULL, NULL, '2014-03-07 17:16:33', 1, 1);
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;


-- Copiando estrutura para tabela lolwtf2.pessoa
CREATE TABLE IF NOT EXISTS `pessoa` (
  `nome` varchar(30) NOT NULL,
  `telefone` varchar(20) NOT NULL,
  `senha` varchar(100) NOT NULL,
  `email` varchar(30) NOT NULL,
  `rg` varchar(50) NOT NULL,
  `cpf` varchar(50) NOT NULL,
  `nivel_d_aces` int(5) NOT NULL,
  `cod_end` int(8) NOT NULL,
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `nascimento` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cod_end` (`cod_end`),
  CONSTRAINT `pessoa_ibfk_1` FOREIGN KEY (`cod_end`) REFERENCES `endereco` (`cod_end`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela lolwtf2.pessoa: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `pessoa` DISABLE KEYS */;
INSERT INTO `pessoa` (`nome`, `telefone`, `senha`, `email`, `rg`, `cpf`, `nivel_d_aces`, `cod_end`, `id`, `nascimento`) VALUES
	('Rafael Kozar', '(23)0972-3057', 'e10adc3949ba59abbe56e057f20f883e', 'rafael_kozar@hotmail.com', '03.275.903-2', '019.270.372-50', 1, 1, 1, '2013-07-25'),
	('Alexandre Beltzac 2', '0', 'e10adc3949ba59abbe56e057f20f883e', 'lol2@gmail.com', '65546', '111111', 0, 1, 4, '1993-08-11'),
	('Samuel Yuji Yamaguchi', '(92)4719-0271', 'e10adc3949ba59abbe56e057f20f883e', 'samuel@lolwtf.com', '84.910.270-9', '927.507.125-75', 0, 2, 5, '1992-07-09');
/*!40000 ALTER TABLE `pessoa` ENABLE KEYS */;


-- Copiando estrutura para tabela lolwtf2.produto
CREATE TABLE IF NOT EXISTS `produto` (
  `nome` varchar(30) NOT NULL,
  `descricao` varchar(10000) DEFAULT NULL,
  `cod_prod` int(10) NOT NULL AUTO_INCREMENT,
  `categoria` int(10) NOT NULL DEFAULT '0',
  `estoque` int(10) NOT NULL,
  `peso` int(11) DEFAULT NULL,
  `cod_marc` int(10) NOT NULL,
  `preco` decimal(10,2) NOT NULL,
  `dimensoes` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cod_prod`),
  KEY `cod_marc` (`cod_marc`),
  KEY `FK_produto_categoria` (`categoria`),
  CONSTRAINT `FK_produto_categoria` FOREIGN KEY (`categoria`) REFERENCES `categoria` (`cod`),
  CONSTRAINT `produto_ibfk_1` FOREIGN KEY (`cod_marc`) REFERENCES `marca` (`codmarc`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela lolwtf2.produto: ~8 rows (aproximadamente)
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
INSERT INTO `produto` (`nome`, `descricao`, `cod_prod`, `categoria`, `estoque`, `peso`, `cod_marc`, `preco`, `dimensoes`) VALUES
	('Relogio', 'Relogio analogico e metalico', 11, 4, 214, 100, 5, 20.00, '131x314x444'),
	('Chaveiro', '', 32, 0, 120, 100, 2, 1599.00, '141x241x241'),
	('Caneca', 'Caneca personalizÃ¡vel com vÃ¡rias cores disponÃ­veis', 33, 1, 150, 0, 2, 0.00, '123x123x123'),
	('Camisetas Coloridas', '', 34, 0, 121, 23432, 5, 799.00, '232x535x325'),
	('Capa de Almofada', '', 35, 0, 124, 0, 5, 349.90, '214x124x121'),
	('Caneca Termica', '', 36, 0, 214, 35325, 6, 499.00, '325x523x523'),
	('Pijama', '', 37, 0, 124, 93252, 4, 1299.00, '241x412x412'),
	('Camiseta Branca', '', 38, 0, 231, 0, 3, 2449.00, '323x532x525');
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
