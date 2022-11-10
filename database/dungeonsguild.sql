-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Tempo de geração: 10-Nov-2022 às 15:21
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
-- Estrutura da tabela `antecedentes`
--

CREATE TABLE `antecedentes` (
  `id` int(11) NOT NULL,
  `antecedente` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `antecedentes`
--

INSERT INTO `antecedentes` (`id`, `antecedente`) VALUES
(1, 'Acólito'),
(2, 'Artesão de Guilda'),
(3, 'Artista'),
(4, 'Charlatão'),
(5, 'Criminoso'),
(6, 'Eremita'),
(7, 'Forasteiro'),
(8, 'Herói Popular'),
(9, 'Marinheiro'),
(10, 'Morador de Rua'),
(11, 'Nobre'),
(12, 'Sábio'),
(13, 'Soldado');

-- --------------------------------------------------------

--
-- Estrutura da tabela `assinaturas`
--

CREATE TABLE `assinaturas` (
  `id_assinatura` int(11) NOT NULL,
  `nome_assinatura` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `assinaturas`
--

INSERT INTO `assinaturas` (`id_assinatura`, `nome_assinatura`) VALUES
(1, 'Versão Gratuita'),
(2, 'Versão Paga');

-- --------------------------------------------------------

--
-- Estrutura da tabela `cadastro`
--

CREATE TABLE `cadastro` (
  `id_cadastro` int(11) NOT NULL,
  `nome_cadastro` varchar(40) NOT NULL,
  `apelido_cadastro` varchar(60) NOT NULL,
  `email_cadastro` varchar(50) NOT NULL,
  `senha_cadastro` varchar(50) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `data_conta` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_assinatura` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `cadastro`
--

INSERT INTO `cadastro` (`id_cadastro`, `nome_cadastro`, `apelido_cadastro`, `email_cadastro`, `senha_cadastro`, `data_conta`, `id_assinatura`) VALUES
(1, 'Rafael Eduardo Gonçalves', 'RafaEg', 'rafa@gmail.com', '123123', '2022-10-02 17:32:58', 1),
(2, 'Renato Silva', 'Renatinho123', 'renatosilva@gmail.com', '123123', '2022-10-09 05:27:51', 1),
(3, 'Gabriel Fernandes da Costa', 'Uhuton', 'gabriel@example.com', 'senhaDaora', '2022-10-09 16:33:03', 2),
(4, 'João Henrique Bertelli', 'bertelli', 'joao_h_bertelli@estudante.sc.senai.br', '123', '2022-11-04 13:25:00', 1),
(5, 'Nicolas Valdevino Coelho', 'Yuta', 'nicolas_v_coelho@estudante.sc.senai.br', 'abcabc', '2022-11-10 13:37:49', 1);

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
(7, 'Guerreiro'),
(8, 'Ladino'),
(9, 'Mago'),
(10, 'Monge'),
(11, 'Paladino'),
(12, 'Patrulheiro');

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
  `url_imagem` varchar(70) NOT NULL,
  `vida_atual` int(11) NOT NULL,
  `vida_total` int(11) NOT NULL,
  `id_classe` int(11) NOT NULL,
  `nivel_personagem` int(11) NOT NULL,
  `id_antecedente` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_raca` int(11) NOT NULL,
  `id_tendencia` int(11) NOT NULL,
  `xp_atual` int(11) NOT NULL,
  `xp_total` int(11) NOT NULL,
  `lista_aparencia` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `lista_bonus` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `cor_ficha` varchar(10) NOT NULL,
  `salvaguardas` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `pericias` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `testes_resistencia` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `idiomas_proficiencias` varchar(300) NOT NULL,
  `equipamentos` varchar(500) NOT NULL,
  `lista_dinheiro` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `caracteristicas` varchar(500) NOT NULL,
  `magias` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `historia` varchar(2000) NOT NULL,
  `tesouro` varchar(200) NOT NULL,
  `aliados` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `personagem`
--

INSERT INTO `personagem` (`id_personagem`, `nome_personagem`, `url_imagem`, `vida_atual`, `vida_total`, `id_classe`, `nivel_personagem`, `id_antecedente`, `id_usuario`, `id_raca`, `id_tendencia`, `xp_atual`, `xp_total`, `lista_aparencia`, `lista_bonus`, `cor_ficha`, `salvaguardas`, `pericias`, `testes_resistencia`, `idiomas_proficiencias`, `equipamentos`, `lista_dinheiro`, `caracteristicas`, `magias`, `historia`, `tesouro`, `aliados`) VALUES
(1, 'Yggis', '/images/fichas/41pZusVfSQOMRb3.jpg', 51, 129, 3, 3, 7, 1, 2, 3, 120, 300, '{\'idade\': 38, \'altura\': 1.77, \'peso\': 75.0, \'cabelo\': \'Nenhum\', \'olho\': \'Amarelos\', \'pele\': \'Bordô\'}', '{\'inspiracao\': 2, \'percepcao\': 3, \'dados_vida\': 2, \'classe_armadura\': 2, \'iniciativa\': 3, \'deslocamento\': 4}', '#d93407', '{\'forca\': 17, \'destreza\': 10, \'constituicao\': 15, \'inteligencia\': 7, \'sabedoria\': 12, \'carisma\': 9}', '[\'5\', \'8\', \'14\']', '[\'2\', \'6\']', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras interdum justo eu metus ornare vulputate. Praesent eu tempus libero. In at mattis velit, eget luctus ipsum. Donec iaculis egestas risus, vel molestie ex malesuada at. Donec vitae lacinia turpis. Praesent a eros nisi.', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras interdum justo eu metus ornare vulputate.\r\n\r\nPraesent eu tempus libero. In at mattis velit, eget luctus ipsum.\r\n\r\nDonec iaculis egestas risus, vel molestie ex malesuada at. \r\n\r\nDonec vitae lacinia turpis. Praesent a eros nisi.\r\n\r\nSed finibus efficitur velit non vestibulum. Vivamus mattis malesuada lacinia.\r\n\r\nVestibulum imperdiet at est et placerat. In posuere enim dui, id efficitur libero vestibulum eget.', '{\'pc\': \'48\', \'pp\': \'17\', \'pe\': \'39\', \'po\': \'92\', \'pl\': \'42\'}', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras interdum justo eu metus ornare vulputate. Praesent eu tempus libero. In at mattis velit, eget luctus ipsum. Donec iaculis egestas risus, vel molestie ex malesuada at. Donec vitae lacinia turpis. Praesent a eros nisi. Sed finibus efficitur velit non vestibulum. Vivamus mattis malesuada lacinia.\r\n\r\nVestibulum imperdiet at est et placerat.', '[\'2\', \'4\', \'5\', \'7\', \'10\', \'11\', \'12\', \'13\', \'17\', \'18\', \'20\', \'22\', \'24\', \'28\', \'31\', \'34\', \'36\', \'38\']', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras interdum justo eu metus ornare vulputate. Praesent eu tempus libero. In at mattis velit, eget luctus ipsum. Donec iaculis egestas risus, vel molestie ex malesuada at. Donec vitae lacinia turpis. Praesent a eros nisi. Sed finibus efficitur velit non vestibulum. Vivamus mattis malesuada lacinia.\r\n\r\nVestibulum imperdiet at est et placerat. In posuere enim dui, id efficitur libero vestibulum eget. Praesent arcu neque, vulputate quis egestas sed, blandit vel purus. Vivamus in convallis arcu. Ut posuere, lectus eu convallis luctus, diam libero dictum mi, non laoreet massa diam in arcu. Suspendisse tempus, turpis et mattis fringilla, nibh lectus lobortis justo, in tempus tortor metus et turpis. Duis congue, turpis vel semper venenatis, libero lacus sollicitudin ipsum, non pulvinar leo lacus in mi. Vivamus imperdiet odio nec justo tincidunt, nec bibendum libero feugiat. Fusce aliquam nibh vel metus condimentum blandit. Ut et tortor non libero ornare rutrum et ac lacus. Donec elit orci, tincidunt a sollicitudin ut, congue eget ex. Nullam ut mauris congue, facilisis ex at, imperdiet ligula. Aliquam gravida quam diam, sit amet dignissim nisi efficitur sit amet. In pulvinar efficitur bibendum. In aliquet nec purus eget sagittis. Aliquam pulvinar consequat sapien non volutpat.', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras interdum justo eu metus ornare vulputate.', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras interdum justo eu metus ornare vulputate. Praesent eu tempus libero. In at mattis velit, eget luctus ipsum.'),
(3, 'Calango', '/images/fichas/oovMv6Za1w9pgtq.png', 100, 100, 2, 2, 8, 5, 3, 1, 300, 900, '{\'idade\': 22, \'altura\': 1.73, \'peso\': 67.0, \'cabelo\': \'Marrom\', \'olho\': \'Pretos\', \'pele\': \'Branco\'}', '{\'inspiracao\': 2, \'percepcao\': 5, \'dados_vida\': 2, \'classe_armadura\': 14, \'iniciativa\': 3, \'deslocamento\': 11}', '#9c43a8', '{\'forca\': 10, \'destreza\': 20, \'constituicao\': 12, \'inteligencia\': 13, \'sabedoria\': 13, \'carisma\': 20}', '[\'1\', \'5\', \'6\', \'15\', \'16\']', '[\'4\', \'6\']', '.', 'Alaúde', '{\'pc\': \'21\', \'pp\': \'67\', \'pe\': \'45\', \'po\': \'92\', \'pl\': \'25\'}', '.', '[\'8\', \'14\', \'21\', \'26\', \'30\', \'58\', \'60\', \'67\', \'70\', \'72\']', '.', '.', '.');

-- --------------------------------------------------------

--
-- Estrutura da tabela `racas`
--

CREATE TABLE `racas` (
  `id_raca` int(11) NOT NULL,
  `nome_raca` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `racas`
--

INSERT INTO `racas` (`id_raca`, `nome_raca`) VALUES
(1, 'Anão'),
(2, 'Draconato'),
(3, 'Elfo'),
(4, 'Gnomo'),
(5, 'Halfling'),
(6, 'Humano'),
(7, 'Meio-Elfo'),
(8, 'Meio-Orc'),
(9, 'Tiefling');

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
-- Índices para tabela `antecedentes`
--
ALTER TABLE `antecedentes`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `assinaturas`
--
ALTER TABLE `assinaturas`
  ADD PRIMARY KEY (`id_assinatura`);

--
-- Índices para tabela `cadastro`
--
ALTER TABLE `cadastro`
  ADD PRIMARY KEY (`id_cadastro`),
  ADD KEY `id_assinatura` (`id_assinatura`);

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
  ADD KEY `id_classe` (`id_classe`),
  ADD KEY `id_raca` (`id_raca`),
  ADD KEY `id_tendencia` (`id_tendencia`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_antecedente` (`id_antecedente`);

--
-- Índices para tabela `racas`
--
ALTER TABLE `racas`
  ADD PRIMARY KEY (`id_raca`);

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
-- AUTO_INCREMENT de tabela `antecedentes`
--
ALTER TABLE `antecedentes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de tabela `assinaturas`
--
ALTER TABLE `assinaturas`
  MODIFY `id_assinatura` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `cadastro`
--
ALTER TABLE `cadastro`
  MODIFY `id_cadastro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
  MODIFY `id_personagem` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `racas`
--
ALTER TABLE `racas`
  MODIFY `id_raca` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

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
-- Limitadores para a tabela `cadastro`
--
ALTER TABLE `cadastro`
  ADD CONSTRAINT `cadastro_ibfk_1` FOREIGN KEY (`id_assinatura`) REFERENCES `assinaturas` (`id_assinatura`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `pericias`
--
ALTER TABLE `pericias`
  ADD CONSTRAINT `pericias_ibfk_1` FOREIGN KEY (`id_salvaguardas`) REFERENCES `salvaguardas` (`id_salvaguardas`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `personagem`
--
ALTER TABLE `personagem`
  ADD CONSTRAINT `personagem_ibfk_1` FOREIGN KEY (`id_classe`) REFERENCES `classes` (`id_classe`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `personagem_ibfk_2` FOREIGN KEY (`id_raca`) REFERENCES `racas` (`id_raca`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `personagem_ibfk_3` FOREIGN KEY (`id_tendencia`) REFERENCES `tendencias` (`id_tendencia`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `personagem_ibfk_4` FOREIGN KEY (`id_usuario`) REFERENCES `cadastro` (`id_cadastro`),
  ADD CONSTRAINT `personagem_ibfk_5` FOREIGN KEY (`id_antecedente`) REFERENCES `antecedentes` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
