-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Tempo de geração: 04-Out-2022 às 02:58
-- Versão do servidor: 10.4.22-MariaDB
-- versão do PHP: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `dungeonsguild`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `cadastro`
--

CREATE TABLE `cadastro` (
  `id_cadastro` int(11) NOT NULL,
  `nome_cadastro` varchar(40) NOT NULL,
  `apelido_cadastro` varchar(60) NOT NULL,
  `email_cadastro` varchar(50) NOT NULL,
  `senha_cadastro` varchar(50) NOT NULL,
  `data_conta` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `cadastro`
--

INSERT INTO `cadastro` (`id_cadastro`, `nome_cadastro`, `apelido_cadastro`, `email_cadastro`, `senha_cadastro`, `data_conta`) VALUES
(1, 'Rafael Eduardo Gonçalves', 'RafaEg', 'rafa@gmail.com', '123', '2022-10-02 17:32:58');

-- --------------------------------------------------------

--
-- Estrutura da tabela `classes`
--

CREATE TABLE `classes` (
  `id_classe` int(11) NOT NULL,
  `nome_classe` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `classes`
--

INSERT INTO `classes` (`id_classe`, `nome_classe`) VALUES
(1, 'Bárbaro'),
(2, 'Bardo'),
(3, 'Bruxo'),
(4, 'Clérigo'),
(5, 'Druida'),
(6, 'Feiticeiro'),
(7, 'Guardião'),
(8, 'Guerreiro'),
(9, 'Ladino'),
(10, 'Mago'),
(11, 'Monge'),
(12, 'Paladino');

-- --------------------------------------------------------

--
-- Estrutura da tabela `pericias`
--

CREATE TABLE `pericias` (
  `id_pericia` int(11) NOT NULL,
  `nome_pericia` varchar(35) NOT NULL,
  `id_salvaguardas` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `pericias`
--

INSERT INTO `pericias` (`id_pericia`, `nome_pericia`, `id_salvaguardas`) VALUES
(1, 'Acrobacia', 2),
(2, 'Arcanismo', 4),
(3, 'Atletismo', 1),
(4, 'Atuação', 6),
(5, 'Enganação', 6),
(6, 'Furtividade', 2),
(7, 'História', 4),
(8, 'Intimidação', 6),
(9, 'Intuição', 5),
(10, 'Investigação', 4),
(11, 'Lidar com animais', 5),
(12, 'Medicina', 5),
(13, 'Natureza', 4),
(14, 'Percepção', 5),
(15, 'Persuasão', 6),
(16, 'Prestidigitação', 2),
(17, 'Religião', 4),
(18, 'Sobrevivência', 5);

-- --------------------------------------------------------

--
-- Estrutura da tabela `personagem`
--

CREATE TABLE `personagem` (
  `id_personagem` int(11) NOT NULL,
  `nome_personagem` varchar(50) NOT NULL,
  `pv_atual` int(11) NOT NULL,
  `pv_total` int(11) NOT NULL,
  `id_classe` int(11) NOT NULL,
  `nivel_personagem` int(11) NOT NULL,
  `antecedente` varchar(30) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `raca` varchar(30) NOT NULL,
  `id_tendencia` int(11) NOT NULL,
  `xp_atual` int(11) NOT NULL,
  `xp_total` int(11) NOT NULL,
  `idade` int(11) NOT NULL,
  `altura` float NOT NULL,
  `peso` float NOT NULL,
  `cabelo` varchar(30) NOT NULL,
  `olhos` int(30) NOT NULL,
  `pele` int(30) NOT NULL,
  `inspiracao` int(11) NOT NULL,
  `bonus_proficiencia` int(11) NOT NULL,
  `percepcao` int(11) NOT NULL,
  `dados_vida` int(11) NOT NULL,
  `classe_armadura` int(11) NOT NULL,
  `iniciativa` int(11) NOT NULL,
  `deslocamento` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `salvaguardas`
--

CREATE TABLE `salvaguardas` (
  `id_salvaguardas` int(11) NOT NULL,
  `nome_salvaguarda` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `salvaguardas`
--

INSERT INTO `salvaguardas` (`id_salvaguardas`, `nome_salvaguarda`) VALUES
(1, 'Força'),
(2, 'Destreza'),
(3, 'Constituição'),
(4, 'Inteligência'),
(5, 'Sabedoria'),
(6, 'Carisma');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tendencias`
--

CREATE TABLE `tendencias` (
  `id_tendencia` int(11) NOT NULL,
  `nome_tendencia` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `tendencias`
--

INSERT INTO `tendencias` (`id_tendencia`, `nome_tendencia`) VALUES
(1, 'Leal e Bom'),
(2, 'Neutro e Bom'),
(3, 'Caótico e Bom'),
(4, 'Leal e Neutro'),
(5, 'Neutro'),
(6, 'Caótico e Neutro'),
(7, 'Leal e Mau'),
(8, 'Neutro e Mau'),
(9, 'Caótico e Mau');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `cadastro`
--
ALTER TABLE `cadastro`
  ADD PRIMARY KEY (`id_cadastro`);

--
-- Índices para tabela `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`id_classe`);

--
-- Índices para tabela `pericias`
--
ALTER TABLE `pericias`
  ADD PRIMARY KEY (`id_pericia`),
  ADD KEY `id_salvaguardas` (`id_salvaguardas`);

--
-- Índices para tabela `personagem`
--
ALTER TABLE `personagem`
  ADD PRIMARY KEY (`id_personagem`),
  ADD KEY `id_classe` (`id_classe`);

--
-- Índices para tabela `salvaguardas`
--
ALTER TABLE `salvaguardas`
  ADD PRIMARY KEY (`id_salvaguardas`);

--
-- Índices para tabela `tendencias`
--
ALTER TABLE `tendencias`
  ADD PRIMARY KEY (`id_tendencia`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `cadastro`
--
ALTER TABLE `cadastro`
  MODIFY `id_cadastro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `classes`
--
ALTER TABLE `classes`
  MODIFY `id_classe` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de tabela `pericias`
--
ALTER TABLE `pericias`
  MODIFY `id_pericia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de tabela `personagem`
--
ALTER TABLE `personagem`
  MODIFY `id_personagem` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `salvaguardas`
--
ALTER TABLE `salvaguardas`
  MODIFY `id_salvaguardas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `tendencias`
--
ALTER TABLE `tendencias`
  MODIFY `id_tendencia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `pericias`
--
ALTER TABLE `pericias`
  ADD CONSTRAINT `pericias_ibfk_1` FOREIGN KEY (`id_salvaguardas`) REFERENCES `salvaguardas` (`id_salvaguardas`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `personagem`
--
ALTER TABLE `personagem`
  ADD CONSTRAINT `personagem_ibfk_1` FOREIGN KEY (`id_classe`) REFERENCES `classes` (`id_classe`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
