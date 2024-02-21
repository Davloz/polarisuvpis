-- Crear la base de datos si no existe
CREATE DATABASE IF NOT EXISTS semaforo_pis;

-- Seleccionar la base de datos recién creada
USE semaforo_pis;

-- Verificar si el usuario 'desarrollo' ya existe
SELECT user FROM mysql.user WHERE user = 'desarrollo' AND host = '%';

-- Si el usuario 'desarrollo' no existe, entonces créalo
CREATE USER IF NOT EXISTS 'desarrollo'@'%' IDENTIFIED BY 'desarrollo';

-- Asignar todos los privilegios al usuario 'desarrollo'
GRANT ALL PRIVILEGES ON semaforo_pis.* TO 'desarrollo'@'%';

-- Indicar a MySQL que recargue los privilegios
FLUSH PRIVILEGES;

DROP TABLE IF EXISTS `persona`;
CREATE TABLE `persona` (
  `id` int NOT NULL AUTO_INCREMENT,
  `external_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `nombres` varchar(50) DEFAULT 'NO_DATA',
  `apellidos` varchar(50) DEFAULT 'NO_DATA',
  `fecha_nacimiento` datetime DEFAULT NULL,
  `direccion` varchar(255) DEFAULT 'NO_DATA',
  `ocupacion` varchar(50) DEFAULT 'NO_DATA',
  `organizacion` varchar(100) DEFAULT 'NO_DATA',
  `rol` enum('ADMINISTRADOR','USUARIO') DEFAULT 'USUARIO',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `cuenta`;
CREATE TABLE `cuenta` (
  `id` int NOT NULL AUTO_INCREMENT,
  `external_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `estado` enum('ESPERA','ACEPTADO','RECHAZADO') DEFAULT 'ESPERA',
  `correo` varchar(75) NOT NULL,
  `clave` varchar(250) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `id_persona` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_persona` (`id_persona`),
  CONSTRAINT `cuenta_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Definir la estructura de las tablas
DROP TABLE IF EXISTS `comentario`;
CREATE TABLE `comentario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `external_id` char(36) DEFAULT NULL,
  `coment` varchar(200) NOT NULL,
  `sentimiento` varchar(50) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `persona` VALUES (2,'613c860e-63d5-4624-9754-8c1eab114b34','Thais Nicole','Cartuche Peralta','2003-05-02 00:00:00','Loja - Loja','estudiante UNL','Universidad Nacional de Loja','ADMINISTRADOR','2024-01-23 01:16:53','2024-01-23 01:16:53'),(3,'88a4935d-6680-465d-bf1a-ed4ad8480463','Thais Nicole','Cartuche Peralta','2003-05-02 00:00:00','Loja - Loja','estudiante UNL','Universidad Nacional de Loja','ADMINISTRADOR','2024-01-23 01:19:58','2024-01-23 01:19:58'),(4,'6c9af3e8-aead-4cb1-91c3-8351833a2931','Diego Oswaldo','Marquez','1995-05-19 00:00:00','Loja - Loja','estudiante UNL','Universidad Nacional de Loja','USUARIO','2024-01-23 01:22:01','2024-01-23 01:22:01'),(5,'9d675510-d5cb-415b-b14c-e03ac96f519c','KEYLA MABEL','CARTUCHE PERALTA','1997-08-06 00:00:00','LA ARGELIA ','ESTUDIANTE','UNL','USUARIO','2024-01-24 21:48:40','2024-01-24 21:48:40'),(6,'709a06e1-3a2c-4858-8d92-1047f939ea17','KAREN BRIGITH','GONZAGA RIVAS','2003-12-05 00:00:00','LA TEBAIDA','ESTUDIANTE','UNL','USUARIO','2024-01-25 04:32:11','2024-01-25 04:32:11'),(8,'0374bca5-d224-4020-8f64-7b0694437c63','Diego Oswaldo','Marquez','1995-05-19 00:00:00','Loja - Loja','estudiante UNL','Universidad Nacional de Loja','ADMINISTRADOR','2024-02-01 03:00:55','2024-02-01 03:00:55'),(9,'60305d8b-8088-4ec6-a46c-53f5bf6ac737','Jordy Vladimir','Torres Contento','2003-01-28 00:00:00','Julio Ordoñez','ESTUDIANTE','UNL','USUARIO','2024-02-06 23:30:37','2024-02-06 23:30:37'),(10,'ffb082dc-a616-4e09-a4a0-30a7a88469c5','Davis','Veloz','1997-05-19 00:00:00','Loja - Loja','estudiante UNL','Universidad Nacional de Loja','USUARIO','2024-02-09 05:04:54','2024-02-09 05:04:54'),(11,'71b96c61-0cf1-4c6c-a2dc-fdc82811c5a2','Hilary Madelein','Calva Camacho','2003-09-15 00:00:00','Loja - Loja','ESTUDIANTE','Universidad Nacional de Loja','USUARIO','2024-02-09 05:05:45','2024-02-09 05:05:45'),(12,'9f992d38-e468-4f8e-b320-2cd437835f64','Diego Rene','Cartuche Carchi','1972-09-18 00:00:00','Loja - Loja','DOCENTE','Universidad Nacional de Loja','USUARIO','2024-02-09 05:07:42','2024-02-09 05:07:42'),(13,'fc5f8478-e44e-4ead-89ba-771ea65e5cbe','Yasoly Thalia','Azuero Carrion','2000-11-18 00:00:00','Centro','ESTUDIANTE','UNL','USUARIO','2024-02-19 18:17:18','2024-02-19 18:17:18');

-- Insertar datos en las tablas
INSERT INTO `comentario` VALUES (26,'7cd812d1-c3fd-4ef2-ac4b-8ee8547825ff','Me gusto mucho','😊 Positivo','2024-02-01 01:24:08','2024-02-01 01:24:08','KEYLA MABEL'),(27,'821d63e4-dabf-4f64-91eb-253a922c918c','Creo que se podría mejorar','😊 Positivo','2024-02-01 01:43:05','2024-02-01 01:43:05','KEYLA MABEL'),(29,'d9ef70f8-54b7-4b8b-a7c8-fbdb450cfa51','horrible','😢 Negativo','2024-02-01 02:37:07','2024-02-01 02:37:07','KEYLA MABEL'),(30,'062fba4c-77a4-4e79-b167-fdf8218e3bd3','no me gusto','😢 Negativo','2024-02-01 03:14:07','2024-02-01 03:14:07','Thais Nicole'),(31,'e39f3c2a-4241-4cab-8dd3-d054eff83203','no tiene nada de especial','😐 Neutro','2024-02-01 03:16:33','2024-02-01 03:16:33','Thais Nicole'),(32,'05019e4e-027d-453a-9baf-8ec6aecfd0f1','horrible','😢 Negativo','2024-02-05 23:55:48','2024-02-05 23:55:48','Thais Nicole'),(33,'cbd94372-102e-458a-8ff6-a1bbfd39be8b','Colores agradables','😊 Positivo','2024-02-09 06:13:29','2024-02-09 06:13:29','KEYLA MABEL'),(34,'1990418f-f29f-43e2-916d-fc0de1b9e178','es un buen sitio, muy util','😊 Positivo','2024-02-15 17:39:39','2024-02-15 17:39:39','KEYLA MABEL'),(35,'e37cc5a4-7a5c-4115-9a09-3e0b4e7ed159','estoy con hambre','😐 Neutro','2024-02-15 17:40:37','2024-02-15 17:40:37','KEYLA MABEL'),(36,'6b806736-3b81-4371-b786-80f92f25df5e','la información proporcionada no es adecuada','😢 Negativo','2024-02-15 17:41:35','2024-02-15 17:41:35','KEYLA MABEL'),(37,'520bb03f-a5a8-456e-b10c-e4f226b0810f','muy bonitos colores','😊 Positivo','2024-02-19 06:21:00','2024-02-19 06:21:00','KEYLA MABEL'),(38,'91392b44-3104-4f1a-b2d7-5a0db684a4ee','Karen bella','😊 Positivo','2024-02-19 06:21:35','2024-02-19 06:21:35','KEYLA MABEL');

INSERT INTO `cuenta` VALUES (2,'41ef5b6f-4d84-4236-865d-5e34d03922fc','ACEPTADO','thais@unl.edu.ec','$2b$08$gED4WG2AQJ4UyktRZv67W.HkMqT0CSRmetTbKrpmx421.O3zO2OQa','2024-01-23 01:16:53','2024-02-05 23:55:34',2),(3,'5b92a398-e5c5-428c-b7d7-45909cae383f','ACEPTADO','thais123@unl.edu.ec','$2b$08$rr6w2I7d9Pt9PnRcc50JueA3AOgKNaAsdKOoL0RtXM.iB959fJgma','2024-01-23 01:19:58','2024-01-23 01:26:20',3),(4,'8f718779-198d-4353-904e-ee11e351b485','RECHAZADO','diego@unl.edu.ec','$2b$08$eem/wDWumNtEgAWhP7CTHO61vPViCl3fcICpimjH4C5fHmxcwEuim','2024-01-23 01:22:01','2024-01-25 04:30:38',4),(5,'64af4c0e-2e77-4394-a353-c4669654c257','ACEPTADO','keyla@gmail.com','$2b$08$9g7WmprHSzG8WUdT4oyXEuUuwI/PVB8u0ANLmZyPJtrdCbzzYv8om','2024-01-24 21:48:40','2024-01-30 01:10:32',5),(6,'4961729b-7fd4-417d-be4f-813f1737d458','ACEPTADO','karen@gmail.com','$2b$08$ivw7ScW0lGQKGUFkfRDp2euHV6n9hjNaeAd47EdVCGto08h8mYzE6','2024-01-25 04:32:11','2024-02-06 23:28:42',6),(8,'81af4db3-560c-4817-99b4-fc42bd5c7caa','ACEPTADO','admin@admin.com','$2b$08$shp.l..4pRPqwaKRxXHxyuKtwENLjjqDAXvkvyL8EzDz7PE46bXK.','2024-02-01 03:00:55','2024-02-05 03:13:15',8),(9,'a1cb1d5f-fec6-4665-869b-0771b45963b9','ESPERA','jordy.torres@unl.edu.ec','$2b$08$tR0guO.mEFGs6.zVqkysxOLASoFDNZH6EemrjOGPYhWI.5UqQiOie','2024-02-06 23:30:37','2024-02-06 23:30:37',9),(10,'309f5990-cde0-414c-8edf-bab050c98fbf','ESPERA','davis@unl.edu.ec','$2b$08$tWNLEI4lzpBbERSpnkpsb.nLfGLn4hZmEaKYv5PrYY0FR3WnZAWgK','2024-02-09 05:04:54','2024-02-09 05:04:54',10),(11,'870e0ba8-066c-4c86-b634-83c3340520e9','ESPERA','hilary@unl.edu.ec','$2b$08$4ewtuIzWA92pF06N6vZVFeqTNqSC1HSp9/RoQDpl6g8vIAf3xKyJy','2024-02-09 05:05:45','2024-02-09 05:05:45',11),(12,'c4841972-25e2-4e3a-9d56-00508da1f530','ACEPTADO','diegorcc@unl.edu.ec','$2b$08$wdwlr9tDb2vCW7K54S7tKufGrtBn/fSAuoHfl5Sipyfg5q.0ftgDW','2024-02-09 05:07:42','2024-02-19 19:37:26',12),(13,'70048ca5-d3d0-477a-a1c2-457c04a283cd','ESPERA','yasoly.azuero@unl.edu.ec','$2b$08$DFmvQ/RvNvEfjDR15bLFt.NWgaABPdmQC1qzFdq/X7T/eM7qcwy7u','2024-02-19 18:17:18','2024-02-19 18:17:18',13);


