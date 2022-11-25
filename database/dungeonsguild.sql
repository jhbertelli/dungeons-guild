-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Tempo de geração: 25-Nov-2022 às 15:53
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
(1, 'Rafael Eduardo Gonçalves', 'RafaEg', 'rafa@gmail.com', '123123', '2022-10-02 17:32:58', 2),
(2, 'Renato Silva', 'Renatinho123', 'renatosilva@gmail.com', '123123', '2022-10-09 05:27:51', 2),
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
-- Estrutura da tabela `mundo`
--

CREATE TABLE `mundo` (
  `id_mundo` int(11) NOT NULL,
  `nome_mundo` varchar(50) NOT NULL,
  `imagem_mundo` varchar(70) NOT NULL,
  `tema_mundo` varchar(50) NOT NULL,
  `descricao_mundo` varchar(200) NOT NULL,
  `sistema_mundo` varchar(50) NOT NULL,
  `frequencia_mundo` varchar(50) NOT NULL,
  `data_mundo` date NOT NULL,
  `jgdorNeces_mundo` int(11) NOT NULL,
  `codigo_mundo` varchar(6) NOT NULL,
  `privacidade_mundo` tinyint(1) NOT NULL,
  `id_cadastro` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `mundo`
--

INSERT INTO `mundo` (`id_mundo`, `nome_mundo`, `imagem_mundo`, `tema_mundo`, `descricao_mundo`, `sistema_mundo`, `frequencia_mundo`, `data_mundo`, `jgdorNeces_mundo`, `codigo_mundo`, `privacidade_mundo`, `id_cadastro`) VALUES
(1, 'mundo foda 2', '/images/mundos/ZurMZ4ohF3uMPqK.png', 'teste', 'codigo novo', 'codigo', 'ono', '2022-06-14', 0, 'YvVh6L', 1, 1),
(2, 'Mundo massa', '/images/mundos/BwpsIA9ZRDALyEp.jpg', 'Mundo pica', 'Mundo legal', '1234', 'batata', '2022-11-02', 2, '5fGFJk', 1, 3),
(3, 'Mundo UAU', '/images/mundos/1iDiTTiK3f98g9m.png', 'Medieval', 'uau que mundo foda', 'testa', 'todo', '2022-11-03', 2, '', 0, 2),
(4, 'dawdw', '/images/mundos/KXMxXdy6CyCrVCt.jpg', '12312312', '231123', '312231', '132123', '2022-11-06', 12, '', 0, 2),
(5, 'etrtte', '/images/mundos/wodN09SdqQmFPKq.jpg', '12312', '312312312', '123123', '123', '2022-11-08', 20, '', 0, 2),
(6, 'wdwefgew', '/images/mundos/DvNra8WvDDNHBUJ.jpg', 'feqfeq', 'feqfqef', 'feqfeq', 'feqfeq', '2022-11-11', 20, '', 0, 2),
(7, '3123123123', '/images/mundos/wmLivOPlS66aPWU.png', '213312', '312312312', '312321', '312321312', '2022-11-08', 20, '', 0, 2),
(8, '5654654654', '/images/mundos/oYAYHt2iBe2TgdV.png', '345345345', '345345345', '435435', '534534543', '2022-11-08', 20, '', 0, 2),
(9, 'ué', '/images/mundos/PMLwF2eg5LiSkyN.png', '12', '122112', '122121', '121212', '2022-11-09', 12, '', 0, 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `participantes_mundo`
--

CREATE TABLE `participantes_mundo` (
  `id_participanteMundo` int(11) NOT NULL,
  `id_mundo` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `participantes_mundo`
--

INSERT INTO `participantes_mundo` (`id_participanteMundo`, `id_mundo`, `id_usuario`) VALUES
(1, 2, 2),
(2, 2, 1);

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
(3, 'Calango', '/images/fichas/oovMv6Za1w9pgtq.png', 100, 100, 2, 2, 8, 5, 3, 1, 300, 900, '{\'idade\': 22, \'altura\': 1.73, \'peso\': 67.0, \'cabelo\': \'Marrom\', \'olho\': \'Pretos\', \'pele\': \'Branco\'}', '{\'inspiracao\': 2, \'percepcao\': 5, \'dados_vida\': 2, \'classe_armadura\': 14, \'iniciativa\': 3, \'deslocamento\': 11}', '#9c43a8', '{\'forca\': 10, \'destreza\': 20, \'constituicao\': 12, \'inteligencia\': 13, \'sabedoria\': 13, \'carisma\': 20}', '[\'1\', \'5\', \'6\', \'15\', \'16\']', '[\'4\', \'6\']', '.', 'Alaúde', '{\'pc\': \'21\', \'pp\': \'67\', \'pe\': \'45\', \'po\': \'92\', \'pl\': \'25\'}', '.', '[\'8\', \'14\', \'21\', \'26\', \'30\', \'58\', \'60\', \'67\', \'70\', \'72\']', '.', '.', '.'),
(5, 'Dragão', '/images/fichas/H1cVd6FtFvGzt05.png', 123, 123, 1, 2, 3, 2, 4, 4, 123, 123, '{\'idade\': 12, \'altura\': 12.0, \'peso\': 12.0, \'cabelo\': \'12\', \'olho\': \'12\', \'pele\': \'12\'}', '{\'inspiracao\': 1, \'percepcao\': 2, \'dados_vida\': \'2\', \'classe_armadura\': 2, \'iniciativa\': 2, \'deslocamento\': 2}', '#3689a4', '{\'forca\': 2, \'destreza\': 2, \'constituicao\': 2, \'inteligencia\': 2, \'sabedoria\': 2, \'carisma\': 2}', '[\'2\', \'4\', \'7\']', '[]', 'A', 'A', '{\'pc\': \'21\', \'pp\': \'12\', \'pe\': \'12\', \'po\': \'12\', \'pl\': \'12\'}', 'A', '[\'3\', \'6\', \'9\', \'27\', \'29\', \'30\', \'31\', \'32\', \'33\', \'34\', \'35\', \'36\', \'37\', \'38\', \'39\', \'40\', \'41\', \'42\', \'43\', \'44\', \'45\', \'46\', \'47\', \'48\', \'49\', \'50\', \'51\', \'52\', \'53\', \'54\', \'55\', \'56\', \'57\', \'58\', \'59\', \'60\', \'61\', \'62\', \'63\', \'64\', \'65\', \'66\', \'67\', \'68\', \'69\', \'70\', \'71\', \'72\', \'73\', \'74\', \'75\', \'76\', \'77\', \'78\', \'79\', \'80\', \'81\', \'82\', \'83\', \'84\', \'85\', \'86\', \'87\', \'88\', \'89\', \'90\', \'91\', \'92\', \'93\', \'94\', \'95\', \'96\', \'97\', \'98\', \'99\', \'100\', \'101\', \'102\', \'103\', \'104\', \'105\', \'106\', \'107\', \'108\', \'109\', \'110\', \'111\', \'112\', \'113\', \'114\', \'115\', \'116\', \'117\', \'118\', \'119\', \'120\', \'121\', \'122\', \'123\', \'124\', \'125\', \'126\', \'127\', \'128\', \'129\', \'130\', \'131\', \'132\', \'133\', \'134\', \'135\', \'136\', \'137\', \'138\', \'139\', \'140\', \'141\', \'142\', \'143\', \'144\', \'145\', \'146\', \'147\', \'148\', \'149\', \'150\', \'151\', \'152\', \'153\', \'154\', \'155\', \'156\', \'157\', \'158\', \'159\', \'160\', \'161\', \'162\', \'163\', \'164\', \'165\', \'166\', \'167\', \'168\', \'169\', \'170\', \'171\', \'172\', \'173\', \'174\', \'175\', \'176\', \'177\', \'178\', \'179\', \'180\', \'181\', \'182\', \'183\', \'184\', \'185\', \'186\', \'187\', \'188\', \'189\', \'190\', \'191\', \'192\', \'193\', \'194\', \'195\', \'196\', \'197\', \'198\', \'199\', \'200\', \'201\', \'202\', \'203\', \'204\', \'205\', \'206\', \'207\', \'208\', \'209\', \'210\']', 'wadwadwa', 'wefwqef', 'gegre'),
(6, 'Brasil', '/images/fichas/jKRFgseiFFtpyHE.png', 2147483647, 2147483647, 8, 20, 10, 2, 4, 3, 2147483647, 2147483647, '{\'idade\': 2342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332, \'altura\': 2.3423423423432424e+75, \'peso\': 2.3423423423432422e+284, \'cabelo\': \'322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332\', \'olho\': \'3342323423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332\', \'pele\': \'23423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332\'}', '{\'inspiracao\': 234234234234324233223423423423432423322342342342343242332, \'percepcao\': 23423423423432423322342342342343242332, \'dados_vida\': \'234234234234324233223423423423432423322342342342343242332\', \'classe_armadura\': 23423423423432423322342342342343242332, \'iniciativa\': 23423423423432423322342342342343242332, \'deslocamento\': 234234234234324233223423423423432423322342342342343242332}', '#3689a4', '{\'forca\': 20, \'destreza\': 20, \'constituicao\': 20, \'inteligencia\': 20, \'sabedoria\': 20, \'carisma\': 20}', '[\'1\', \'2\', \'3\', \'4\', \'5\', \'6\', \'7\', \'8\', \'9\', \'10\', \'11\', \'12\', \'13\', \'14\', \'15\', \'16\', \'17\', \'18\']', '[]', '234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324', '23423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234', '{\'pc\': \'232342342342343242332234234234234324233242342342343242332\', \'pp\': \'232342342342343242332234234234234324233242342342343242332\', \'pe\': \'232342342342343242332234234234234324233242342342343242332\', \'po\': \'2342234234234234324233223423423423432423322342342342343242332342342343242332\', \'pl\': \'2342342342343242332234234234234324233223423423423432423322342342342343242332\'}', '23423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234', '[\'1\', \'2\', \'3\', \'4\', \'5\', \'6\', \'7\', \'8\', \'9\', \'10\', \'11\', \'12\', \'13\', \'14\', \'15\', \'16\', \'17\', \'18\', \'19\', \'20\', \'21\', \'22\', \'23\', \'24\', \'25\', \'26\', \'27\', \'28\', \'29\', \'30\', \'31\', \'32\', \'33\', \'34\', \'35\', \'36\', \'37\', \'38\', \'39\', \'40\', \'41\', \'42\', \'43\', \'44\', \'45\', \'46\', \'47\', \'48\', \'49\', \'50\', \'51\', \'52\', \'53\', \'54\', \'55\', \'56\', \'57\', \'58\', \'59\', \'60\', \'61\', \'62\', \'63\', \'64\', \'65\', \'66\', \'67\', \'68\', \'69\', \'70\', \'71\', \'72\', \'73\', \'74\', \'75\', \'76\', \'77\', \'78\', \'79\', \'80\', \'81\', \'82\', \'83\', \'84\', \'85\', \'86\', \'87\', \'88\', \'89\', \'90\', \'91\', \'92\', \'93\', \'94\', \'95\', \'96\', \'97\', \'98\', \'99\', \'100\', \'101\', \'102\', \'103\', \'104\', \'105\', \'106\', \'107\', \'108\', \'109\', \'110\', \'111\', \'112\', \'113\', \'114\', \'115\', \'116\', \'117\', \'118\', \'119\', \'120\', \'121\', \'122\', \'123\', \'124\', \'125\', \'126\', \'127\', \'128\', \'129\', \'130\', \'131\', \'132\', \'133\', \'134\', \'135\', \'136\', \'137\', \'138\', \'139\', \'140\', \'141\', \'142\', \'143\', \'144\', \'145\', \'146\', \'147\', \'148\', \'149\', \'150\', \'151\', \'152\', \'153\', \'154\', \'155\', \'156\', \'157\', \'158\', \'159\', \'160\', \'161\', \'162\', \'163\', \'164\', \'165\', \'166\', \'167\', \'168\', \'169\', \'170\', \'171\', \'172\', \'173\', \'174\', \'175\', \'176\', \'177\', \'178\', \'179\', \'180\', \'181\', \'182\', \'183\', \'184\', \'185\', \'186\', \'187\', \'188\', \'189\', \'190\', \'191\', \'192\', \'193\', \'194\', \'195\', \'196\', \'197\', \'198\', \'199\', \'200\', \'201\', \'202\', \'203\', \'204\', \'205\', \'206\', \'207\', \'208\', \'209\', \'210\', \'211\', \'212\', \'213\', \'214\', \'215\', \'216\', \'217\', \'218\', \'219\', \'220\', \'221\', \'222\', \'223\', \'224\', \'225\', \'226\', \'227\', \'228\', \'229\', \'230\', \'231\', \'232\', \'233\', \'234\', \'235\', \'236\', \'237\', \'238\', \'239\', \'240\', \'241\', \'242\', \'243\', \'244\', \'245\', \'246\', \'247\', \'248\', \'249\', \'250\', \'251\', \'252\', \'253\', \'254\', \'255\', \'256\', \'257\', \'258\', \'259\', \'260\', \'261\', \'262\', \'263\', \'264\', \'265\', \'266\', \'267\', \'268\', \'269\', \'270\', \'271\', \'272\', \'273\', \'274\', \'275\', \'276\', \'277\', \'278\', \'279\', \'280\', \'281\', \'282\', \'283\', \'284\', \'285\', \'286\', \'287\', \'288\', \'289\', \'290\', \'291\', \'292\', \'293\', \'294\', \'295\', \'296\', \'297\', \'298\', \'299\', \'300\', \'301\', \'302\', \'303\', \'304\', \'305\', \'306\', \'307\', \'308\', \'309\', \'310\', \'311\', \'312\', \'313\', \'314\', \'315\', \'316\', \'317\', \'318\', \'319\']', '23423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423', '23423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342', '23423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342343242332234234234234324233223423423423432423322342342342'),
(7, 'Testando', '/images/fichas/oLLSwICgJYIHjHf.png', 123124314, 1231231, 10, 20, 11, 2, 4, 3, 123123, 14341341, '{\'idade\': 12312412, \'altura\': 421321312.0, \'peso\': 412432431.0, \'cabelo\': \'1234134\', \'olho\': \'134134\', \'pele\': \'123124\'}', '{\'inspiracao\': 12, \'percepcao\': 12, \'dados_vida\': \'123\', \'classe_armadura\': 123, \'iniciativa\': 123, \'deslocamento\': 123}', '#3689a4', '{\'forca\': 12, \'destreza\': 12, \'constituicao\': 12, \'inteligencia\': 12, \'sabedoria\': 12, \'carisma\': 12}', '[\'5\', \'6\', \'7\']', '[]', '12', '1', '{\'pc\': \'1\', \'pp\': \'1\', \'pe\': \'1\', \'po\': \'1\', \'pl\': \'1\'}', '1', '[\'1\', \'2\', \'3\', \'4\', \'5\', \'6\', \'7\', \'8\', \'65\', \'66\', \'67\', \'68\', \'69\', \'70\', \'71\', \'72\', \'73\']', '1', '1', '1'),
(8, 'Homem Olho', '/images/fichas/E0QNN5Im5pwNv17.jpg', 1, 1, 2, 2, 6, 2, 3, 3, 32, 32, '{\'idade\': 2, \'altura\': 2.0, \'peso\': 2.0, \'cabelo\': \'2\', \'olho\': \'2\', \'pele\': \'2\'}', '{\'inspiracao\': 2, \'percepcao\': 2, \'dados_vida\': \'2\', \'classe_armadura\': 2, \'iniciativa\': 2, \'deslocamento\': 2}', '#3689a4', '{\'forca\': 2, \'destreza\': 2, \'constituicao\': 2, \'inteligencia\': 2, \'sabedoria\': 2, \'carisma\': 2}', '[\'1\']', '[]', '2', '2', '{\'pc\': \'2\', \'pp\': \'2\', \'pe\': \'2\', \'po\': \'2\', \'pl\': \'2\'}', '2', '[\'76\', \'77\', \'78\', \'79\', \'80\', \'81\', \'82\', \'83\', \'84\', \'85\', \'86\', \'87\', \'88\', \'89\', \'90\', \'91\', \'92\', \'93\', \'94\', \'95\', \'96\', \'97\', \'98\', \'99\', \'100\', \'101\', \'102\', \'103\', \'104\', \'105\', \'106\', \'107\', \'108\', \'109\', \'110\', \'111\', \'112\', \'113\', \'114\', \'115\', \'116\']', '2', '2', '2'),
(9, 'Homem', '/images/fichas/z2rUL9vehu18u5b.png', 1, 1, 9, 1, 11, 2, 2, 3, 1, 1, '{\'idade\': 1, \'altura\': 1.0, \'peso\': 1.0, \'cabelo\': \'121\', \'olho\': \'1\', \'pele\': \'123124\'}', '{\'inspiracao\': 1, \'percepcao\': 1, \'dados_vida\': \'123\', \'classe_armadura\': 1, \'iniciativa\': 1, \'deslocamento\': 1}', '#3689a4', '{\'forca\': 1, \'destreza\': 1, \'constituicao\': 1, \'inteligencia\': 1, \'sabedoria\': 1, \'carisma\': 1}', '[\'1\']', '[]', '11', '1', '{\'pc\': \'1\', \'pp\': \'1\', \'pe\': \'1\', \'po\': \'11\', \'pl\': \'1\'}', '11', '[\'3\', \'4\', \'5\', \'6\', \'7\', \'8\', \'9\', \'10\', \'11\', \'12\', \'13\', \'14\', \'15\', \'16\', \'17\', \'18\', \'19\', \'20\', \'21\', \'22\', \'23\', \'24\', \'25\', \'26\', \'27\', \'28\', \'29\', \'30\', \'31\', \'32\', \'33\', \'34\', \'35\', \'36\', \'37\', \'38\', \'39\', \'40\', \'41\', \'42\', \'43\', \'44\', \'45\', \'46\', \'47\', \'48\', \'49\', \'50\', \'51\', \'52\', \'53\', \'54\', \'55\', \'56\', \'57\', \'58\', \'59\', \'60\', \'61\', \'62\', \'63\', \'64\', \'65\', \'66\', \'67\', \'68\', \'69\', \'70\', \'71\', \'72\', \'73\', \'74\', \'75\', \'76\', \'77\', \'78\', \'79\', \'80\', \'81\', \'82\', \'83\', \'84\', \'85\', \'86\', \'87\', \'88\', \'89\', \'90\', \'91\']', '32', '32', '32'),
(10, 'Zé Pelinho', '/images/fichas/m5j4pNozVoFiONn.png', 1, 1, 10, 2, 11, 2, 5, 4, 2, 2, '{\'idade\': 2, \'altura\': 2.0, \'peso\': 2.0, \'cabelo\': \'2\', \'olho\': \'2\', \'pele\': \'2\'}', '{\'inspiracao\': 2, \'percepcao\': 2, \'dados_vida\': \'2\', \'classe_armadura\': 2, \'iniciativa\': 2, \'deslocamento\': 2}', '#3689a4', '{\'forca\': 2, \'destreza\': 2, \'constituicao\': 2, \'inteligencia\': 2, \'sabedoria\': 2, \'carisma\': 2}', '[\'1\', \'4\']', '[]', '2', '2', '{\'pc\': \'2\', \'pp\': \'2\', \'pe\': \'2\', \'po\': \'2\', \'pl\': \'2\'}', '2', '[\'4\']', '2', '2', '2'),
(11, 'Coveiro', '/images/fichas/k6rsrNJPGK8pDrP.png', 1, 1, 10, 1, 9, 2, 6, 5, 1, 1, '{\'idade\': 1, \'altura\': 1.0, \'peso\': 1.0, \'cabelo\': \'1\', \'olho\': \'1\', \'pele\': \'1\'}', '{\'inspiracao\': 1, \'percepcao\': 1, \'dados_vida\': \'1\', \'classe_armadura\': 1, \'iniciativa\': 1, \'deslocamento\': 1}', '#3689a4', '{\'forca\': 1, \'destreza\': 1, \'constituicao\': 1, \'inteligencia\': 1, \'sabedoria\': 1, \'carisma\': 1}', '[\'8\']', '[]', '1', '1', '{\'pc\': \'1\', \'pp\': \'1\', \'pe\': \'1\', \'po\': \'1\', \'pl\': \'1\'}', '1', '[\'6\', \'7\', \'8\', \'9\', \'10\', \'11\', \'12\', \'13\', \'14\', \'15\', \'16\', \'17\', \'18\', \'19\', \'20\', \'21\', \'22\', \'23\', \'24\', \'25\', \'26\', \'27\', \'28\', \'29\', \'30\', \'31\', \'32\', \'33\', \'34\', \'35\', \'36\', \'37\', \'38\', \'39\', \'40\', \'41\', \'42\', \'43\', \'44\', \'45\', \'46\', \'47\', \'48\', \'49\', \'50\', \'51\', \'52\', \'53\', \'54\', \'55\', \'56\', \'57\', \'58\', \'59\', \'60\', \'61\', \'62\', \'63\', \'64\', \'65\', \'66\', \'67\', \'68\', \'69\', \'70\', \'71\', \'72\', \'73\', \'74\', \'75\', \'76\', \'77\', \'78\', \'79\', \'80\', \'81\', \'82\', \'83\', \'84\', \'85\', \'86\', \'87\', \'88\', \'89\', \'90\', \'91\', \'92\', \'93\', \'94\', \'95\', \'96\', \'97\', \'98\', \'99\', \'100\', \'101\', \'102\', \'103\', \'104\', \'105\', \'106\', \'107\', \'108\', \'109\', \'110\', \'111\', \'112\', \'113\', \'114\', \'115\', \'116\', \'117\', \'118\', \'119\', \'120\', \'121\', \'122\', \'123\', \'124\', \'125\', \'126\', \'127\', \'128\', \'129\', \'130\', \'131\', \'132\', \'133\', \'134\', \'135\', \'136\', \'137\', \'138\', \'139\', \'140\', \'141\', \'142\', \'143\', \'144\', \'145\', \'146\', \'147\', \'148\', \'149\', \'150\', \'151\', \'152\', \'153\', \'154\', \'155\', \'156\', \'157\', \'158\', \'159\', \'160\', \'161\', \'162\', \'163\', \'164\', \'165\', \'166\', \'167\', \'168\', \'169\', \'170\', \'171\', \'172\', \'173\', \'174\', \'175\', \'176\', \'177\', \'178\', \'179\', \'180\', \'181\', \'182\', \'183\', \'184\', \'185\', \'186\', \'187\', \'188\', \'189\', \'190\', \'191\', \'192\', \'193\', \'194\', \'195\', \'196\', \'197\', \'198\', \'199\', \'200\', \'201\', \'202\', \'203\', \'204\', \'205\', \'206\', \'207\', \'208\', \'209\', \'210\', \'211\', \'212\', \'213\', \'214\', \'215\', \'216\', \'217\', \'218\', \'219\', \'220\', \'221\', \'222\', \'223\', \'224\', \'225\', \'226\', \'227\', \'228\', \'229\', \'230\', \'231\', \'232\', \'233\', \'234\', \'235\', \'236\', \'237\', \'238\', \'239\', \'240\', \'241\', \'242\', \'243\', \'244\', \'245\']', '1', '1', '1'),
(12, 'iu', '/images/fichas/m1gG5rzmkLbRiy4.png', 1, 1, 8, 2, 7, 2, 1, 4, 2, 2, '{\'idade\': 2, \'altura\': 2.0, \'peso\': 2.0, \'cabelo\': \'2\', \'olho\': \'2\', \'pele\': \'2\'}', '{\'inspiracao\': 2, \'percepcao\': 2, \'dados_vida\': \'2\', \'classe_armadura\': 2, \'iniciativa\': 2, \'deslocamento\': 2}', '#3689a4', '{\'forca\': 2, \'destreza\': 2, \'constituicao\': 2, \'inteligencia\': 2, \'sabedoria\': 2, \'carisma\': 2}', '[\'1\']', '[]', '2', '2', '{\'pc\': \'2\', \'pp\': \'2\', \'pe\': \'2\', \'po\': \'2\', \'pl\': \'2\'}', '2', '[]', '2', '2', '2'),
(13, 'Mostro', '/images/fichas/AAFI5kxuqOz9grx.jpg', 1, 1, 9, 1, 9, 2, 3, 6, 1, 1, '{\'idade\': 1, \'altura\': 1.0, \'peso\': 1.0, \'cabelo\': \'1\', \'olho\': \'1\', \'pele\': \'1\'}', '{\'inspiracao\': 1, \'percepcao\': 1, \'dados_vida\': \'1\', \'classe_armadura\': 1, \'iniciativa\': 1, \'deslocamento\': 1}', '#3689a4', '{\'forca\': 1, \'destreza\': 1, \'constituicao\': 1, \'inteligencia\': 1, \'sabedoria\': 1, \'carisma\': 1}', '[]', '[]', '1', '1', '{\'pc\': \'21\', \'pp\': \'1111\', \'pe\': \'1\', \'po\': \'1\', \'pl\': \'11\'}', '11', '[]', '1', '11', '1'),
(14, 'Druida', '/images/fichas/TG8Uu1nJy72A3UT.png', 111, 1, 8, 11, 9, 2, 3, 4, 2, 23, '{\'idade\': 2, \'altura\': 2.0, \'peso\': 2.0, \'cabelo\': \'2\', \'olho\': \'22\', \'pele\': \'2\'}', '{\'inspiracao\': 2, \'percepcao\': 2, \'dados_vida\': \'2\', \'classe_armadura\': 2, \'iniciativa\': 22, \'deslocamento\': 2}', '#3689a4', '{\'forca\': 6, \'destreza\': 6, \'constituicao\': 6, \'inteligencia\': 6, \'sabedoria\': 6, \'carisma\': 6}', '[]', '[]', '6', '6', '{\'pc\': \'6\', \'pp\': \'6\', \'pe\': \'6\', \'po\': \'6\', \'pl\': \'6\'}', '66', '[]', '6', '6', '6'),
(15, 'yrdtr', '/images/fichas/vRKkgnb41o2p3na.png', 21312, 3123123, 9, 20, 10, 2, 3, 4, 213123, 321231, '{\'idade\': 213, \'altura\': 322131.0, \'peso\': 21.0, \'cabelo\': \'213231\', \'olho\': \'312\', \'pele\': \'321321\'}', '{\'inspiracao\': 1, \'percepcao\': 1, \'dados_vida\': \'1\', \'classe_armadura\': 1, \'iniciativa\': 1, \'deslocamento\': 1}', '#3689a4', '{\'forca\': 1, \'destreza\': 1, \'constituicao\': 1, \'inteligencia\': 1, \'sabedoria\': 1, \'carisma\': 1}', '[\'1\']', '[]', '123123', '231', '{\'pc\': \'1\', \'pp\': \'1\', \'pe\': \'1\', \'po\': \'1\', \'pl\': \'1\'}', '123123', '[\'23\', \'24\', \'25\', \'26\', \'27\', \'28\', \'29\', \'30\', \'31\', \'32\', \'33\', \'34\', \'35\', \'36\', \'37\', \'38\', \'39\', \'40\', \'41\', \'42\', \'43\', \'44\', \'45\', \'46\', \'47\', \'48\', \'49\', \'50\', \'51\', \'52\', \'53\', \'54\', \'55\', \'56\', \'57\', \'58\', \'59\', \'60\', \'61\', \'62\', \'63\', \'64\', \'65\', \'66\', \'67\', \'68\', \'69\', \'70\', \'71\', \'72\']', '11', '1', '1'),
(16, 'o.o', '/images/fichas/IS68hJ6Kvpp2Qxy.jpg', 1, 1, 8, 1, 10, 2, 2, 6, 2, 2, '{\'idade\': 2, \'altura\': 2.0, \'peso\': 2.0, \'cabelo\': \'2\', \'olho\': \'2\', \'pele\': \'2\'}', '{\'inspiracao\': 2, \'percepcao\': 2, \'dados_vida\': \'2\', \'classe_armadura\': 2, \'iniciativa\': 2, \'deslocamento\': 2}', '#3689a4', '{\'forca\': 2, \'destreza\': 2, \'constituicao\': 2, \'inteligencia\': 2, \'sabedoria\': 2, \'carisma\': 2}', '[]', '[]', '22', '22', '{\'pc\': \'22\', \'pp\': \'2\', \'pe\': \'2\', \'po\': \'2\', \'pl\': \'2\'}', '22', '[]', '22', '2', '2'),
(17, 'pexi', '/images/fichas/GhztaCIB5Erg2rJ.png', 11, 1, 1, 1, 4, 2, 3, 6, 1, 1, '{\'idade\': 1, \'altura\': 1.0, \'peso\': 1.0, \'cabelo\': \'1\', \'olho\': \'11\', \'pele\': \'1\'}', '{\'inspiracao\': 1, \'percepcao\': 1, \'dados_vida\': \'1\', \'classe_armadura\': 11, \'iniciativa\': 1, \'deslocamento\': 11}', '#3689a4', '{\'forca\': 1, \'destreza\': 1, \'constituicao\': 11, \'inteligencia\': 1, \'sabedoria\': 1, \'carisma\': 11}', '[]', '[]', '1', '1', '{\'pc\': \'1\', \'pp\': \'1\', \'pe\': \'1\', \'po\': \'11\', \'pl\': \'1\'}', '111', '[]', '11', '1', '1'),
(18, 'ooooo', '/images/fichas/Hu7lbO4nWkzWgoy.png', 1, 1, 5, 11, 8, 2, 6, 2, 11, 1, '{\'idade\': 1, \'altura\': 11.0, \'peso\': 1.0, \'cabelo\': \'1\', \'olho\': \'1\', \'pele\': \'11\'}', '{\'inspiracao\': 1, \'percepcao\': 1, \'dados_vida\': \'1\', \'classe_armadura\': 11, \'iniciativa\': 1, \'deslocamento\': 1}', '#3689a4', '{\'forca\': 1, \'destreza\': 1, \'constituicao\': 1, \'inteligencia\': 1, \'sabedoria\': 11, \'carisma\': 1}', '[]', '[]', '1', '1', '{\'pc\': \'1\', \'pp\': \'1\', \'pe\': \'11\', \'po\': \'1\', \'pl\': \'1\'}', '1', '[\'3\', \'4\', \'5\', \'6\', \'7\', \'8\', \'9\', \'10\', \'11\', \'12\', \'13\', \'14\', \'15\', \'16\', \'17\', \'18\', \'19\', \'20\', \'21\', \'22\', \'23\', \'24\', \'25\', \'26\', \'27\', \'28\', \'29\', \'30\', \'31\', \'32\', \'33\', \'34\', \'35\', \'36\', \'37\', \'38\', \'39\', \'40\', \'41\', \'42\', \'43\', \'44\', \'45\', \'46\', \'47\', \'48\', \'49\', \'50\', \'51\', \'52\', \'53\', \'54\', \'55\', \'56\', \'57\', \'58\', \'59\', \'60\', \'61\', \'62\', \'63\', \'64\', \'65\', \'66\', \'67\', \'68\', \'69\', \'70\', \'71\', \'72\', \'73\', \'74\', \'75\', \'76\', \'77\', \'78\', \'79\', \'80\', \'81\', \'82\']', '11', '1', '1'),
(19, 'drthrdh', '/images/fichas/KMDy3UQ74zXXnBs.PNG', 1, 1, 5, 1, 8, 2, 7, 2, 1, 1, '{\'idade\': 1, \'altura\': 11.0, \'peso\': 1.0, \'cabelo\': \'1\', \'olho\': \'1\', \'pele\': \'11\'}', '{\'inspiracao\': 1, \'percepcao\': 1, \'dados_vida\': \'1\', \'classe_armadura\': 1, \'iniciativa\': 1, \'deslocamento\': 1}', '#3689a4', '{\'forca\': 1, \'destreza\': 1, \'constituicao\': 1, \'inteligencia\': 1, \'sabedoria\': 1, \'carisma\': 11}', '[]', '[]', '1', '1', '{\'pc\': \'1\', \'pp\': \'11\', \'pe\': \'1\', \'po\': \'1\', \'pl\': \'1\'}', '1', '[]', '1', '1', '1'),
(20, 'gyuk', '/images/fichas/OvCzTUF4yJlAQsY.jpg', 11, 1, 11, 1, 9, 2, 6, 5, 1, 1, '{\'idade\': 1, \'altura\': 1.0, \'peso\': 1.0, \'cabelo\': \'1\', \'olho\': \'1\', \'pele\': \'1\'}', '{\'inspiracao\': 1, \'percepcao\': 1, \'dados_vida\': \'1\', \'classe_armadura\': 1, \'iniciativa\': 1, \'deslocamento\': 1}', '#3689a4', '{\'forca\': 1, \'destreza\': 1, \'constituicao\': 11, \'inteligencia\': 1, \'sabedoria\': 1, \'carisma\': 1}', '[]', '[]', '1', '1', '{\'pc\': \'1\', \'pp\': \'1\', \'pe\': \'1\', \'po\': \'1\', \'pl\': \'1\'}', '1', '[]', '1', '1', '1'),
(21, 'gerwgre', '/images/fichas/Wxeifrxf8WlsgGe.png', 11, 111, 10, 1, 8, 2, 4, 3, 1, 11, '{\'idade\': 1, \'altura\': 1.0, \'peso\': 11.0, \'cabelo\': \'1\', \'olho\': \'1\', \'pele\': \'11\'}', '{\'inspiracao\': 1, \'percepcao\': 1, \'dados_vida\': \'11\', \'classe_armadura\': 1, \'iniciativa\': 1, \'deslocamento\': 11}', '#3689a4', '{\'forca\': 1, \'destreza\': 11, \'constituicao\': 1, \'inteligencia\': 1, \'sabedoria\': 1, \'carisma\': 1}', '[]', '[]', '1', '1', '{\'pc\': \'1\', \'pp\': \'1\', \'pe\': \'1\', \'po\': \'1\', \'pl\': \'1\'}', '1', '[\'120\', \'121\', \'122\', \'123\', \'124\', \'125\', \'126\', \'127\', \'128\', \'129\', \'130\', \'131\', \'132\', \'133\', \'134\', \'135\', \'136\', \'137\', \'138\', \'139\', \'140\', \'141\', \'142\', \'143\', \'144\', \'145\', \'146\', \'147\', \'148\', \'149\', \'150\', \'151\', \'152\', \'153\', \'154\', \'155\', \'156\', \'157\', \'158\', \'159\', \'160\', \'161\', \'162\', \'163\', \'164\', \'165\', \'166\', \'167\', \'168\', \'169\', \'170\', \'171\', \'172\', \'173\', \'174\', \'175\', \'176\', \'177\', \'178\', \'179\', \'180\', \'181\', \'182\', \'183\', \'184\', \'185\', \'186\', \'187\', \'188\', \'189\', \'190\', \'191\', \'192\', \'193\', \'194\', \'195\', \'196\', \'197\', \'198\', \'199\', \'200\', \'201\', \'202\', \'203\', \'204\', \'205\', \'206\', \'207\', \'208\', \'209\', \'210\', \'211\', \'212\', \'213\', \'214\', \'215\', \'216\', \'217\', \'218\', \'219\', \'220\', \'221\', \'222\', \'223\', \'224\', \'225\', \'226\', \'227\', \'228\', \'229\', \'230\', \'231\', \'232\', \'233\', \'234\', \'235\', \'236\', \'237\', \'238\', \'239\', \'240\', \'241\', \'242\', \'243\', \'244\', \'245\', \'246\', \'247\', \'248\', \'249\', \'250\', \'251\', \'252\', \'253\', \'254\', \'255\', \'256\', \'257\', \'258\', \'259\', \'260\', \'261\', \'262\', \'263\', \'264\', \'265\', \'266\', \'267\', \'268\', \'269\', \'270\', \'271\', \'272\', \'273\', \'274\', \'275\', \'276\', \'277\', \'278\', \'279\', \'280\', \'281\', \'282\', \'283\', \'284\', \'285\', \'286\', \'287\', \'288\', \'289\', \'290\', \'291\', \'292\', \'293\', \'294\', \'295\', \'296\', \'297\', \'298\', \'299\', \'300\', \'301\', \'302\', \'303\', \'304\']', '1', '1', '1'),
(22, 'yudi tamashiro', '/images/fichas/eruBZKxI7BzIscn.PNG', 1, 1, 9, 1, 9, 2, 2, 3, 1, 1, '{\'idade\': 1, \'altura\': 1.0, \'peso\': 1.0, \'cabelo\': \'11\', \'olho\': \'1\', \'pele\': \'1\'}', '{\'inspiracao\': 1, \'percepcao\': 11, \'dados_vida\': \'1\', \'classe_armadura\': 11, \'iniciativa\': 1, \'deslocamento\': 1}', '#3689a4', '{\'forca\': 1, \'destreza\': 1, \'constituicao\': 1, \'inteligencia\': 1, \'sabedoria\': 1, \'carisma\': 1}', '[\'1\']', '[]', '1', '1', '{\'pc\': \'1\', \'pp\': \'1\', \'pe\': \'1\', \'po\': \'1\', \'pl\': \'1\'}', '1', '[\'4\', \'5\', \'6\', \'7\', \'8\', \'9\', \'10\', \'11\', \'12\', \'13\', \'14\', \'15\', \'16\', \'17\', \'18\', \'19\', \'20\', \'21\', \'22\', \'23\', \'24\', \'25\', \'26\', \'27\', \'28\', \'29\', \'30\', \'31\', \'32\', \'33\', \'34\', \'35\', \'36\', \'37\', \'38\', \'39\', \'40\', \'41\', \'42\', \'43\', \'44\', \'45\', \'46\', \'47\', \'48\', \'49\', \'50\', \'51\', \'52\', \'53\', \'54\', \'55\', \'56\', \'57\', \'58\', \'59\', \'60\', \'61\', \'62\', \'63\', \'64\', \'65\', \'66\', \'67\', \'68\', \'69\', \'70\', \'71\', \'72\', \'73\', \'74\', \'75\', \'76\', \'77\', \'78\', \'79\', \'80\', \'81\', \'82\', \'83\', \'84\', \'85\', \'86\', \'87\', \'88\', \'89\', \'90\', \'91\', \'92\', \'93\', \'94\', \'95\', \'96\', \'97\', \'98\', \'99\', \'100\', \'101\', \'102\', \'103\', \'104\', \'105\', \'106\', \'107\', \'108\', \'109\', \'110\', \'111\', \'112\', \'113\', \'114\', \'115\', \'116\', \'117\', \'118\', \'119\', \'120\', \'121\', \'122\', \'123\', \'124\', \'125\', \'126\', \'127\', \'128\', \'129\', \'130\', \'131\', \'132\', \'133\', \'134\', \'135\', \'136\', \'137\', \'138\', \'139\', \'140\', \'141\', \'142\', \'143\', \'144\', \'145\', \'146\', \'147\', \'148\', \'149\', \'150\', \'151\', \'152\', \'153\', \'154\', \'155\', \'156\', \'157\', \'158\', \'159\', \'160\', \'161\', \'162\', \'163\', \'164\', \'165\', \'166\', \'167\', \'168\', \'169\', \'170\', \'171\', \'172\', \'173\', \'174\', \'175\', \'176\', \'177\', \'178\', \'179\', \'180\', \'181\', \'182\', \'183\', \'184\', \'185\', \'186\', \'187\', \'188\', \'189\', \'190\', \'191\', \'192\', \'193\', \'194\', \'195\', \'196\', \'197\', \'198\', \'199\', \'200\', \'201\', \'202\', \'203\', \'204\', \'205\', \'206\', \'207\', \'208\', \'209\', \'210\', \'211\', \'212\', \'213\', \'214\', \'215\', \'216\', \'217\', \'218\', \'219\', \'220\', \'221\', \'222\', \'223\', \'224\', \'225\', \'226\', \'227\', \'228\', \'229\', \'230\', \'231\', \'232\', \'233\', \'234\', \'235\', \'236\', \'237\', \'238\', \'239\', \'240\', \'241\', \'242\', \'243\', \'244\', \'245\', \'246\', \'247\', \'248\', \'249\', \'250\', \'251\']', '1', '1', '1');

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
-- Estrutura da tabela `solicitacoes`
--

CREATE TABLE `solicitacoes` (
  `id_solicitacao` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_mundo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
-- Índices para tabela `mundo`
--
ALTER TABLE `mundo`
  ADD PRIMARY KEY (`id_mundo`),
  ADD KEY `id_cadastro` (`id_cadastro`);

--
-- Índices para tabela `participantes_mundo`
--
ALTER TABLE `participantes_mundo`
  ADD PRIMARY KEY (`id_participanteMundo`),
  ADD KEY `id_mundo` (`id_mundo`),
  ADD KEY `id_usuario` (`id_usuario`);

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
-- Índices para tabela `solicitacoes`
--
ALTER TABLE `solicitacoes`
  ADD PRIMARY KEY (`id_solicitacao`),
  ADD KEY `id_mundo` (`id_mundo`),
  ADD KEY `id_usuario` (`id_usuario`);

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
-- AUTO_INCREMENT de tabela `mundo`
--
ALTER TABLE `mundo`
  MODIFY `id_mundo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de tabela `participantes_mundo`
--
ALTER TABLE `participantes_mundo`
  MODIFY `id_participanteMundo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `pericias`
--
ALTER TABLE `pericias`
  MODIFY `id_pericia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de tabela `personagem`
--
ALTER TABLE `personagem`
  MODIFY `id_personagem` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

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
-- AUTO_INCREMENT de tabela `solicitacoes`
--
ALTER TABLE `solicitacoes`
  MODIFY `id_solicitacao` int(11) NOT NULL AUTO_INCREMENT;

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
-- Limitadores para a tabela `mundo`
--
ALTER TABLE `mundo`
  ADD CONSTRAINT `id_cadastro` FOREIGN KEY (`id_cadastro`) REFERENCES `cadastro` (`id_cadastro`);

--
-- Limitadores para a tabela `participantes_mundo`
--
ALTER TABLE `participantes_mundo`
  ADD CONSTRAINT `participantes_mundo_ibfk_1` FOREIGN KEY (`id_mundo`) REFERENCES `mundo` (`id_mundo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `participantes_mundo_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `cadastro` (`id_cadastro`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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

--
-- Limitadores para a tabela `solicitacoes`
--
ALTER TABLE `solicitacoes`
  ADD CONSTRAINT `solicitacoes_ibfk_1` FOREIGN KEY (`id_mundo`) REFERENCES `mundo` (`id_mundo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `solicitacoes_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `cadastro` (`id_cadastro`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
