-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Tempo de geração: 29-Nov-2022 às 00:08
-- Versão do servidor: 10.4.25-MariaDB
-- versão do PHP: 7.4.30

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
(2, 'Masteria', '/images/mundos/BwpsIA9ZRDALyEp.jpg', 'Aventura', 'Mundo legal', '1234', 'batata', '2022-11-02', 2, 'CfZXYe', 1, 3),
(10, 'Landfall', '/images/mundos/M6SRMDP444Zwkv7.jpg', 'Dark Fantasy', 'Um mundo cheio de guerreiros e monstros', 'D&D', 'Todos os Domingos', '2022-12-04', 5, '', 0, 2),
(11, 'Midgard', '/images/mundos/MrH2ALldJncS0F4.jpg', 'Medieval', 'Proteção de castelos e monstros', 'D&D', 'Segundas', '2022-12-05', 3, '', 0, 2),
(12, 'Magika', '/images/mundos/4lIoZudrfOWyop2.jpg', 'High Fantasy', 'Uma aventura mágica e fantástica', 'D&D', 'Todo dia', '2022-11-30', 8, '', 0, 1),
(13, 'Fear', '/images/mundos/Zlzyz35Zk8rGLNE.jpg', 'Terror', 'Mistérios e Fantasmas?', 'D&D', '1 vez ao mês', '2022-12-10', 2, '', 0, 1),
(14, 'Pontalia', '/images/mundos/SsoKjsYLvSlpffK.webp', 'Terror Mágico', 'Uma floresta amaldiçoada cheia de perigos', 'D&D', 'Toda Semana', '2022-12-02', 1, '', 0, 3),
(15, 'Rockfar', '/images/mundos/lbx8ddUehHAYkr1.webp', 'Não Especificado', 'Um mundo vazio... ou não', 'D&D', '1 Vez ao Ano', '2022-12-10', 6, '', 0, 4),
(16, 'Postur', '/images/mundos/hIDa8XyQT3qDYeb.webp', 'Aventura Dimensional', 'Vários mundos diferentes e... estranhos', 'D&D', 'Toda Segunda Feira', '2022-11-25', 1, '', 0, 5);

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
(23, 'Orbar', '/images/fichas/FXiVD371Zg2O3EP.png', 12, 12, 7, 2, 2, 2, 1, 1, 100, 300, '{\'idade\': 200, \'altura\': 1.3, \'peso\': 50.0, \'cabelo\': \'Preto\', \'olho\': \'Preto\', \'pele\': \'Branca\'}', '{\'inspiracao\': 0, \'percepcao\': 2, \'dados_vida\': \'2\', \'classe_armadura\': 2, \'iniciativa\': 2, \'deslocamento\': 2}', '#3689a4', '{\'forca\': 20, \'destreza\': 15, \'constituicao\': 14, \'inteligencia\': 13, \'sabedoria\': 12, \'carisma\': 12}', '[\'6\', \'7\', \'12\', \'15\', \'16\']', '[\'1\', \'5\']', 'Idiomas: Posmdo', 'Espada', '{\'pc\': \'20\', \'pp\': \'0\', \'pe\': \'0\', \'po\': \'0\', \'pl\': \'0\'}', '---', '[\'3\', \'4\', \'5\', \'6\', \'7\', \'27\', \'28\', \'29\', \'30\', \'51\', \'52\', \'53\', \'54\']', 'Se tornou um guerreiro após perder sua família', 'Nada ainda', 'Guilda da Cidade'),
(24, 'Landmir', '/images/fichas/9Rffw0R9cXisgvV.png', 50, 79, 3, 3, 10, 2, 6, 8, 20, 400, '{\'idade\': 20, \'altura\': 180.0, \'peso\': 80.0, \'cabelo\': \'Preto\', \'olho\': \'Marrom\', \'pele\': \'Branca\'}', '{\'inspiracao\': 1, \'percepcao\': 2, \'dados_vida\': \'2\', \'classe_armadura\': 2, \'iniciativa\': 2, \'deslocamento\': 2}', '#7ae114', '{\'forca\': 20, \'destreza\': 10, \'constituicao\': 14, \'inteligencia\': 11, \'sabedoria\': 12, \'carisma\': 8}', '[\'1\', \'7\', \'11\', \'13\']', '[\'1\', \'4\']', 'Não Fala', 'Pá', '{\'pc\': \'0\', \'pp\': \'0\', \'pe\': \'0\', \'po\': \'20\', \'pl\': \'0\'}', 'Proficiência em Armas Grandes', '[\'2\', \'3\', \'4\', \'5\', \'6\', \'7\', \'8\', \'9\', \'10\', \'11\', \'12\', \'13\', \'14\', \'15\', \'16\', \'17\', \'18\', \'19\', \'20\', \'21\', \'22\', \'23\', \'24\', \'25\', \'26\', \'27\', \'28\', \'29\', \'30\', \'31\', \'32\', \'33\', \'34\', \'35\', \'36\', \'37\', \'38\', \'39\', \'40\', \'41\', \'42\', \'43\', \'44\', \'45\', \'46\', \'47\', \'48\', \'49\', \'50\', \'51\', \'52\', \'53\', \'54\', \'55\', \'56\', \'57\', \'58\']', 'Era um coveiro e um dia começou a falar com os mortos', 'Jóias dos mortos', 'Cemitério e os Mortos'),
(25, 'Varys', '/images/fichas/0YgMKuy95YUm6vK.png', 12, 12, 9, 2, 6, 1, 3, 2, 2, 2, '{\'idade\': 59, \'altura\': 2.0, \'peso\': 180.0, \'cabelo\': \'Preto\', \'olho\': \'Verdes\', \'pele\': \'Branca\'}', '{\'inspiracao\': 1, \'percepcao\': 2, \'dados_vida\': \'2\', \'classe_armadura\': 3, \'iniciativa\': 3, \'deslocamento\': 3}', '#3689a4', '{\'forca\': 9, \'destreza\': 12, \'constituicao\': 10, \'inteligencia\': 15, \'sabedoria\': 20, \'carisma\': 8}', '[\'5\', \'6\', \'7\', \'11\', \'12\']', '[\'3\', \'5\']', 'Idiomas: Lioniano', 'Cajado', '{\'pc\': \'5\', \'pp\': \'2\', \'pe\': \'50\', \'po\': \'0\', \'pl\': \'0\'}', 'Proficiência em Facas', '[\'2\', \'3\', \'4\', \'5\', \'6\', \'7\', \'8\', \'9\', \'10\', \'11\', \'12\', \'13\', \'14\', \'15\', \'16\', \'17\', \'18\', \'19\', \'20\', \'21\', \'22\', \'23\', \'24\', \'25\', \'26\', \'27\', \'28\', \'29\', \'30\', \'31\', \'32\', \'33\', \'34\', \'35\', \'36\', \'37\', \'38\', \'39\', \'40\', \'41\', \'42\', \'43\', \'44\', \'45\', \'46\', \'47\', \'48\', \'49\', \'50\', \'51\', \'52\', \'53\', \'54\', \'55\', \'56\', \'57\', \'58\', \'59\', \'60\', \'61\', \'62\', \'63\', \'64\', \'65\', \'66\', \'67\', \'68\', \'69\', \'70\', \'71\', \'72\', \'73\', \'74\', \'75\', \'76\', \'77\', \'78\', \'79\', \'80\', \'81\', \'82\', \'83\', \'84\', \'85\', \'86\', \'87\', \'88\', \'89\', \'90\', \'91\', \'92\', \'93\', \'94\', \'95\', \'96\', \'97\', \'98\', \'99\', \'100\', \'101\', \'102\', \'103\', \'104\', \'105\', \'106\', \'107\', \'108\', \'109\', \'110\', \'111\', \'112\', \'113\', \'114\', \'115\', \'116\', \'117\', \'118\', \'119\', \'120\', \'121\', \'122\', \'123\', \'124\', \'125\', \'126\', \'127\', \'128\', \'129\', \'130\', \'131\', \'132\', \'133\', \'134\', \'135\', \'136\', \'137\', \'138\', \'139\']', 'Um mago do conselho mágico', '--', '--'),
(26, 'Erevan', '/images/fichas/mlrJYfcNookoMsY.png', 21, 21, 5, 2, 7, 3, 3, 1, 20, 30, '{\'idade\': 500, \'altura\': 2.0, \'peso\': 70.0, \'cabelo\': \'Preto\', \'olho\': \'Preto\', \'pele\': \'Branca\'}', '{\'inspiracao\': 1, \'percepcao\': 1, \'dados_vida\': \'1\', \'classe_armadura\': 1, \'iniciativa\': 1, \'deslocamento\': 1}', '#3689a4', '{\'forca\': 20, \'destreza\': 11, \'constituicao\': 12, \'inteligencia\': 15, \'sabedoria\': 11, \'carisma\': 7}', '[\'11\', \'12\', \'13\', \'14\', \'16\']', '[\'3\', \'5\']', 'Idiomas: Animal', 'Clava e Bordão', '{\'pc\': \'20\', \'pp\': \'2\', \'pe\': \'5\', \'po\': \'0\', \'pl\': \'20\'}', 'Armas Marciais', '[\'3\', \'4\', \'5\', \'6\', \'7\', \'8\', \'9\', \'10\', \'11\', \'12\', \'13\', \'14\', \'15\', \'16\', \'17\', \'18\', \'19\', \'20\', \'21\', \'22\', \'23\', \'24\', \'25\', \'26\', \'27\', \'28\', \'29\', \'30\', \'31\', \'32\', \'33\', \'34\', \'35\', \'36\', \'37\', \'38\', \'39\', \'40\', \'41\', \'42\', \'43\', \'44\', \'45\', \'46\', \'47\', \'48\', \'49\', \'50\', \'51\', \'52\', \'53\', \'54\', \'55\', \'56\', \'57\', \'58\', \'59\', \'60\', \'61\', \'62\', \'63\', \'64\', \'65\', \'66\', \'67\', \'68\', \'69\', \'70\', \'71\', \'72\', \'73\', \'74\', \'75\', \'76\', \'77\', \'78\', \'79\', \'80\', \'81\', \'82\', \'83\', \'84\', \'85\', \'86\', \'87\', \'88\', \'89\', \'90\', \'91\', \'92\', \'93\', \'94\', \'95\', \'96\', \'97\', \'98\', \'99\', \'100\', \'101\', \'102\', \'103\', \'104\', \'105\', \'106\', \'107\', \'108\', \'109\', \'110\', \'111\', \'112\', \'113\', \'114\', \'115\', \'116\', \'117\', \'118\', \'119\', \'120\', \'121\', \'122\', \'123\', \'124\', \'125\', \'126\', \'127\', \'128\', \'129\', \'130\']', 'Um druida que vivia na floresta e decidiu ajudar as florestas de uma maneira diferente', '-', 'Seres da Floresta'),
(27, 'Valen', '/images/fichas/d6sRaIoOA9jlkpM.PNG', 12, 12, 2, 5, 1, 3, 3, 8, 0, 0, '{\'idade\': 20, \'altura\': 180.0, \'peso\': 50.0, \'cabelo\': \'Branco\', \'olho\': \'Preto\', \'pele\': \'Branca\'}', '{\'inspiracao\': 1, \'percepcao\': 1, \'dados_vida\': \'1\', \'classe_armadura\': 1, \'iniciativa\': 1, \'deslocamento\': 1}', '#3689a4', '{\'forca\': 12, \'destreza\': 14, \'constituicao\': 15, \'inteligencia\': 20, \'sabedoria\': 12, \'carisma\': 10}', '[\'8\', \'12\', \'14\', \'16\']', '[\'2\', \'5\']', '-', 'Capa de Fogo', '{\'pc\': \'20\', \'pp\': \'0\', \'pe\': \'2\', \'po\': \'10\', \'pl\': \'1\'}', '-', '[\'5\', \'6\', \'7\', \'8\', \'9\', \'10\', \'11\', \'12\', \'13\', \'14\', \'15\', \'16\', \'17\', \'18\', \'19\', \'20\', \'21\', \'22\', \'23\', \'24\', \'25\', \'26\', \'27\', \'28\', \'29\', \'30\', \'31\', \'32\', \'33\', \'34\', \'35\', \'36\', \'37\', \'38\', \'39\', \'40\', \'41\', \'42\', \'43\', \'44\', \'45\', \'46\', \'47\', \'48\', \'49\', \'50\', \'51\', \'52\', \'53\', \'54\', \'55\', \'56\', \'57\', \'58\', \'59\', \'60\', \'61\', \'62\', \'63\', \'64\', \'65\', \'66\', \'67\', \'68\', \'69\', \'70\', \'71\', \'72\', \'73\', \'74\', \'75\', \'76\', \'77\', \'78\', \'79\', \'80\', \'81\', \'82\', \'83\', \'84\', \'85\', \'86\', \'87\', \'88\', \'89\', \'90\', \'91\', \'92\', \'93\', \'94\', \'95\', \'96\', \'97\', \'98\', \'99\', \'100\', \'101\', \'102\', \'103\', \'104\', \'105\', \'106\', \'107\', \'108\', \'109\', \'110\', \'111\', \'112\', \'113\', \'114\', \'115\', \'116\', \'117\', \'118\', \'119\', \'120\', \'121\', \'122\', \'123\', \'124\', \'125\', \'126\', \'127\', \'128\', \'129\', \'130\', \'131\', \'132\', \'133\', \'134\', \'135\', \'136\', \'137\', \'138\', \'139\', \'140\', \'141\', \'142\', \'143\', \'144\', \'145\', \'146\', \'147\', \'148\', \'149\', \'150\', \'151\']', 'Elfo que perdeu os pais e decidiu ir atrás da verdade desse mundo', 'Castelo de Grayskull', 'Grupo de Amigos'),
(28, 'Atila', '/images/fichas/8xb0nuqvhwy73jz.png', 500, 500, 1, 20, 4, 4, 9, 4, 20, 20, '{\'idade\': 21, \'altura\': 156.0, \'peso\': 30.0, \'cabelo\': \'Sem Cabelo\', \'olho\': \'Preto\', \'pele\': \'Branco com Laranja\'}', '{\'inspiracao\': 1, \'percepcao\': 1, \'dados_vida\': \'1\', \'classe_armadura\': 1, \'iniciativa\': 1, \'deslocamento\': 1}', '#dd6036', '{\'forca\': 20, \'destreza\': 8, \'constituicao\': 8, \'inteligencia\': 8, \'sabedoria\': 10, \'carisma\': 15}', '[\'1\', \'6\', \'8\', \'10\']', '[\'3\', \'5\']', '-', 'Armadura de Placas', '{\'pc\': \'2\', \'pp\': \'0\', \'pe\': \'0\', \'po\': \'0\', \'pl\': \'50\'}', '-', '[\'5\', \'6\', \'7\', \'8\', \'9\', \'10\', \'11\', \'12\', \'13\', \'14\', \'15\', \'16\', \'17\', \'18\', \'19\', \'20\', \'21\', \'22\', \'23\', \'24\', \'25\', \'26\', \'27\', \'28\', \'29\', \'30\', \'31\', \'32\', \'33\', \'34\', \'35\', \'36\', \'37\', \'38\', \'39\', \'40\', \'41\', \'42\', \'43\', \'44\', \'45\', \'46\', \'47\', \'48\', \'49\', \'50\', \'51\', \'52\', \'53\', \'54\', \'55\', \'56\', \'57\', \'58\', \'59\', \'60\', \'61\', \'62\', \'63\', \'64\', \'65\', \'66\', \'67\', \'68\', \'69\', \'70\', \'71\', \'72\', \'73\', \'74\', \'75\', \'76\', \'77\', \'78\', \'79\', \'80\', \'81\', \'82\', \'83\', \'84\', \'85\', \'86\', \'87\', \'88\', \'89\', \'90\', \'91\', \'92\', \'93\', \'94\', \'95\', \'96\', \'97\', \'98\', \'99\', \'100\', \'101\', \'102\', \'103\', \'104\', \'105\', \'106\', \'107\', \'108\', \'109\', \'110\', \'111\', \'112\', \'113\', \'114\', \'115\', \'116\', \'117\', \'118\', \'119\', \'120\', \'121\', \'122\', \'123\', \'124\', \'125\', \'126\', \'127\', \'128\', \'129\', \'130\', \'131\', \'132\', \'133\', \'134\', \'135\', \'136\', \'137\', \'138\', \'139\', \'140\', \'141\', \'142\', \'143\', \'144\', \'145\', \'146\', \'147\', \'148\', \'149\', \'150\', \'151\', \'152\', \'153\', \'154\', \'155\', \'156\', \'157\', \'158\', \'159\', \'160\', \'161\', \'162\', \'163\', \'164\', \'165\', \'166\', \'167\', \'168\', \'169\', \'170\', \'171\', \'172\', \'173\', \'174\', \'175\', \'176\', \'177\', \'178\', \'179\', \'180\', \'181\', \'182\', \'183\', \'184\', \'185\', \'186\', \'187\', \'188\', \'189\', \'190\', \'191\', \'192\', \'193\', \'194\', \'195\', \'196\', \'197\', \'198\', \'199\', \'200\', \'201\', \'202\', \'203\', \'204\', \'205\', \'206\', \'207\', \'208\', \'209\', \'210\', \'211\', \'212\', \'213\', \'214\', \'215\', \'216\', \'217\', \'218\', \'219\', \'220\', \'221\', \'222\', \'223\', \'224\', \'225\', \'226\', \'227\', \'228\', \'229\', \'230\', \'231\', \'232\', \'233\', \'234\', \'235\', \'236\', \'237\', \'238\', \'239\', \'240\', \'241\', \'242\', \'243\', \'244\', \'245\', \'246\', \'247\', \'248\', \'249\', \'250\', \'251\', \'252\', \'253\', \'254\', \'255\', \'256\', \'257\', \'258\', \'259\', \'260\', \'261\', \'262\', \'263\', \'264\', \'265\', \'266\', \'267\', \'268\', \'269\', \'270\', \'271\', \'272\', \'273\', \'274\', \'275\', \'276\', \'277\', \'278\', \'279\', \'280\', \'281\', \'282\', \'283\', \'284\', \'285\', \'286\', \'287\', \'288\', \'289\', \'290\', \'291\', \'292\', \'293\', \'294\', \'295\', \'296\', \'297\', \'298\', \'299\', \'300\', \'301\', \'302\', \'303\', \'304\', \'305\', \'306\', \'307\', \'308\', \'309\', \'310\', \'311\', \'312\', \'313\', \'314\', \'315\', \'316\', \'317\', \'318\', \'319\']', 'Um peixe estranhamente poderoso', 'Atlântida', 'Amigos do mar'),
(29, 'Shinzo', '/images/fichas/hnHTFcMTM6ZM5tV.png', 1, 1, 9, 2, 5, 4, 3, 5, 20, 59, '{\'idade\': 30, \'altura\': 180.0, \'peso\': 70.0, \'cabelo\': \'Preto\', \'olho\': \'Preto\', \'pele\': \'Cinza\'}', '{\'inspiracao\': 0, \'percepcao\': 1, \'dados_vida\': \'1\', \'classe_armadura\': 1, \'iniciativa\': 1, \'deslocamento\': 1}', '#0a4052', '{\'forca\': 10, \'destreza\': 20, \'constituicao\': 12, \'inteligencia\': 18, \'sabedoria\': 15, \'carisma\': 12}', '[\'6\', \'9\', \'10\', \'11\', \'14\']', '[\'2\', \'4\']', 'Idiomas: Tohaco e Comum', 'Adaga', '{\'pc\': \'23\', \'pp\': \'11\', \'pe\': \'23\', \'po\': \'0\', \'pl\': \'2\'}', '-', '[\'159\', \'160\', \'161\', \'162\', \'163\', \'164\', \'165\', \'166\', \'167\', \'168\', \'169\', \'170\', \'171\', \'172\', \'173\', \'174\', \'175\', \'176\', \'177\', \'178\', \'179\', \'180\', \'181\', \'182\', \'183\', \'184\', \'185\', \'186\', \'187\', \'188\', \'189\', \'190\', \'191\', \'192\', \'193\', \'194\', \'195\', \'196\', \'197\', \'198\', \'199\', \'200\', \'201\', \'202\', \'203\', \'204\', \'205\', \'206\', \'207\', \'208\', \'209\', \'210\', \'211\', \'212\', \'213\', \'214\', \'215\', \'216\', \'217\', \'218\', \'219\', \'220\', \'221\', \'222\', \'223\', \'224\', \'225\', \'226\', \'227\', \'228\', \'229\', \'230\', \'231\', \'232\', \'233\', \'234\', \'235\', \'236\', \'237\', \'238\', \'239\', \'240\', \'241\', \'242\', \'243\', \'244\', \'245\', \'246\', \'247\', \'248\', \'249\', \'250\', \'251\', \'252\', \'253\', \'254\', \'255\', \'256\', \'257\', \'258\', \'259\', \'260\', \'261\', \'262\', \'263\', \'264\', \'265\', \'266\', \'267\', \'268\', \'269\', \'270\', \'271\', \'272\', \'273\', \'274\', \'275\', \'276\', \'277\', \'278\', \'279\', \'280\', \'281\', \'282\', \'283\', \'284\', \'285\', \'286\', \'287\', \'288\', \'289\', \'290\', \'291\', \'292\', \'293\', \'294\', \'295\', \'296\', \'297\', \'298\', \'299\', \'300\', \'301\', \'302\', \'303\', \'304\', \'305\', \'306\', \'307\', \'308\', \'309\']', 'Quer fugir do seu país e descobrir o que há fora dele', '-', 'Clã dos Perdidos'),
(30, 'Blaspur', '/images/fichas/HCZHal1TI2e5zSi.png', 12, 12, 11, 2, 12, 5, 3, 5, 20, 20, '{\'idade\': 100, \'altura\': 2.0, \'peso\': 50.0, \'cabelo\': \'Loiro\', \'olho\': \'Verde\', \'pele\': \'Branca\'}', '{\'inspiracao\': 1, \'percepcao\': 2, \'dados_vida\': \'2\', \'classe_armadura\': 2, \'iniciativa\': 2, \'deslocamento\': 2}', '#3689a4', '{\'forca\': 10, \'destreza\': 8, \'constituicao\': 12, \'inteligencia\': 15, \'sabedoria\': 20, \'carisma\': 13}', '[\'3\', \'5\', \'9\', \'14\', \'15\']', '[\'4\', \'5\']', 'Idiomas: Comum', 'Lança', '{\'pc\': \'2\', \'pp\': \'2\', \'pe\': \'2\', \'po\': \'2\', \'pl\': \'20\'}', 'Armas Curtas', '[\'4\', \'5\', \'6\', \'7\', \'8\', \'9\', \'10\', \'11\', \'12\', \'13\', \'14\', \'15\', \'16\', \'17\', \'18\', \'19\', \'20\', \'21\', \'22\', \'23\', \'24\', \'25\', \'26\', \'27\', \'28\', \'29\', \'30\', \'31\', \'32\', \'33\', \'34\', \'35\', \'36\', \'37\', \'38\', \'39\', \'40\', \'41\', \'42\', \'43\', \'44\', \'45\']', 'Um velho elfo que decidiu lutar depois de perder sua casa para os Orcs', '-', '-');

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

--
-- Extraindo dados da tabela `solicitacoes`
--

INSERT INTO `solicitacoes` (`id_solicitacao`, `id_usuario`, `id_mundo`) VALUES
(1, 3, 11);

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
  MODIFY `id_mundo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

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
  MODIFY `id_personagem` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

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
  MODIFY `id_solicitacao` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
