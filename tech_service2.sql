-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Апр 12 2025 г., 23:14
-- Версия сервера: 8.0.30
-- Версия PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `tech_service2`
--

-- --------------------------------------------------------

--
-- Структура таблицы `archive`
--

CREATE TABLE `archive` (
  `id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `code` varchar(50) NOT NULL,
  `description` varchar(70) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `archive`
--

INSERT INTO `archive` (`id`, `name`, `code`, `description`, `created_at`) VALUES
(1, 'архив 2024', 'сервис 2024', 'архив сервисных заявок 2024', '2025-04-09 01:31:23'),
(2, 'архив 2025', 'сервис 2025', 'архив сервисных заявок 2025', '2025-04-09 01:31:23');

-- --------------------------------------------------------

--
-- Структура таблицы `cases`
--

CREATE TABLE `cases` (
  `id` int NOT NULL,
  `title` varchar(50) NOT NULL,
  `id_department` int NOT NULL,
  `completeness_checked` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_archive` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `cases`
--

INSERT INTO `cases` (`id`, `title`, `id_department`, `completeness_checked`, `created_at`, `id_archive`) VALUES
(1, 'журнал ремонтов кассовых аппаратов', 3, 0, '2025-04-09 01:33:00', 1),
(2, 'акты проверок торговых точек', 4, 0, '2025-04-09 01:33:00', 2),
(3, 'реестр замененных деталей', 3, 0, '2025-04-09 01:33:44', 2);

-- --------------------------------------------------------

--
-- Структура таблицы `client`
--

CREATE TABLE `client` (
  `id` int NOT NULL,
  `name` varchar(70) NOT NULL,
  `email` varchar(70) NOT NULL,
  `phone` varchar(70) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `client`
--

INSERT INTO `client` (`id`, `name`, `email`, `phone`) VALUES
(1, 'Камилла', 'kama@mail.ru', '79623214556'),
(2, 'Александр', 'sasha@mail.ru', '79648562314'),
(3, 'Марина', 'marina@mail.ru', '79681234556'),
(4, 'Антон', 'anton@mail.ru', '79842369125'),
(5, 'Карина', 'karina@mail.ru', '78561234796');

-- --------------------------------------------------------

--
-- Структура таблицы `departments`
--

CREATE TABLE `departments` (
  `id` int NOT NULL,
  `name` varchar(70) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `departments`
--

INSERT INTO `departments` (`id`, `name`) VALUES
(3, 'сервисный центр'),
(4, 'логистика запчастей');

-- --------------------------------------------------------

--
-- Структура таблицы `documents`
--

CREATE TABLE `documents` (
  `id` int NOT NULL,
  `id_case` int DEFAULT NULL,
  `title` varchar(70) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_data` longblob NOT NULL,
  `file_size` int NOT NULL DEFAULT '0',
  `file_type` varchar(50) DEFAULT NULL,
  `completeness_checked` tinyint(1) NOT NULL,
  `signature_verified` tinyint(1) NOT NULL,
  `reproducibility_verified` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `documents`
--

INSERT INTO `documents` (`id`, `id_case`, `title`, `file_name`, `file_data`, `file_size`, `file_type`, `completeness_checked`, `signature_verified`, `reproducibility_verified`, `created_at`) VALUES
(1, 1, 'акт ремонта кассы 245', '', '', 0, NULL, 0, 0, 0, '2025-04-09 01:35:36'),
(2, 3, 'заявка на запчасти 312', '', '', 0, NULL, 0, 0, 0, '2025-04-09 01:35:36'),
(3, 2, 'акт проверки магазина', '', '', 0, NULL, 0, 0, 0, '2025-04-09 01:36:04'),
(4, 1, 'test.txt', 'test.txt', '', 0, 'text/plain', 0, 0, 0, '2025-04-12 22:46:31');

-- --------------------------------------------------------

--
-- Структура таблицы `interaction_history`
--

CREATE TABLE `interaction_history` (
  `id` int NOT NULL,
  `id_archive` int NOT NULL,
  `request_id` int NOT NULL,
  `user_id` int NOT NULL,
  `id_type` int NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `interaction_history`
--

INSERT INTO `interaction_history` (`id`, `id_archive`, `request_id`, `user_id`, `id_type`, `created_at`) VALUES
(1, 1, 1, 1, 1, '2025-04-09 01:44:33'),
(2, 2, 2, 2, 2, '2025-04-09 01:44:33'),
(3, 1, 3, 2, 3, '2025-04-09 01:45:56'),
(4, 2, 3, 1, 4, '2025-04-09 01:45:56');

-- --------------------------------------------------------

--
-- Структура таблицы `messages`
--

CREATE TABLE `messages` (
  `id` int NOT NULL,
  `id_requests` int NOT NULL,
  `sender_id` int NOT NULL,
  `text` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `messages`
--

INSERT INTO `messages` (`id`, `id_requests`, `sender_id`, `text`, `created_at`) VALUES
(1, 1, 1, 'прошу зарегистрировать дела', '2025-04-09 01:50:32'),
(2, 2, 2, 'требуется срочная проверка подписей', '2025-04-09 01:50:32'),
(3, 3, 1, 'заявка отправлена на доработку', '2025-04-09 01:53:13'),
(4, 1, 1, 'обнаружены отсутствующие документы', '2025-04-09 01:53:13');

-- --------------------------------------------------------

--
-- Структура таблицы `opici`
--

CREATE TABLE `opici` (
  `id` int NOT NULL,
  `id_case` int NOT NULL,
  `description` varchar(70) NOT NULL,
  `complectness_checked` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `opici`
--

INSERT INTO `opici` (`id`, `id_case`, `description`, `complectness_checked`, `created_at`) VALUES
(1, 3, 'опись сервисных заявок', 0, '2025-04-09 01:38:12'),
(2, 1, 'опись запасных частей', 0, '2025-04-09 01:38:12'),
(4, 2, 'опись актов проверок', 0, '2025-04-09 01:38:27');

-- --------------------------------------------------------

--
-- Структура таблицы `requests`
--

CREATE TABLE `requests` (
  `id` int NOT NULL,
  `number` int NOT NULL,
  `created_at` date NOT NULL,
  `status` varchar(70) NOT NULL,
  `priority` varchar(70) NOT NULL,
  `type_id` int NOT NULL,
  `id_client` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `requests`
--

INSERT INTO `requests` (`id`, `number`, `created_at`, `status`, `priority`, `type_id`, `id_client`) VALUES
(1, 123, '2025-03-27', 'в обработке', 'высокий', 1, 1),
(2, 234, '2023-02-16', '3', '3', 2, 2),
(3, 456, '2025-03-11', 'на проверке', 'средний', 3, 3);

-- --------------------------------------------------------

--
-- Структура таблицы `type_interaction`
--

CREATE TABLE `type_interaction` (
  `id` int NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `type_interaction`
--

INSERT INTO `type_interaction` (`id`, `name`) VALUES
(1, 'создано новое дело'),
(2, 'статус изменен'),
(3, 'добавлен в документ'),
(4, 'удален документ'),
(5, 'обновлено дело');

-- --------------------------------------------------------

--
-- Структура таблицы `type_requests`
--

CREATE TABLE `type_requests` (
  `id` int NOT NULL,
  `name` varchar(70) NOT NULL,
  `description` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `type_requests`
--

INSERT INTO `type_requests` (`id`, `name`, `description`) VALUES
(1, 'заявка 1', 'заявка на поставку кассовых'),
(2, 'заявка 2', 'заявка на поставку запчастей'),
(3, 'заявка 3', 'заявка на поставку актов');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `name` varchar(70) NOT NULL,
  `surname` varchar(70) NOT NULL,
  `email` varchar(70) NOT NULL,
  `phone` varchar(13) NOT NULL,
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `name`, `surname`, `email`, `phone`, `password`, `role`) VALUES
(1, 'Апал', 'Топчубаева', 'apal@mail.ru', '79680849088', 'apal', 'сотрудник'),
(2, 'Иван', 'Иванов', 'ivan@mail.ru', '79652364112', 'ivan', 'админ'),
(3, 'катя', 'иванова', 'kate', '555555', '1', 'сотрудник'),
(4, 'камилла', 'талибова', 'kama', '8899', NULL, 'админ');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `archive`
--
ALTER TABLE `archive`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `cases`
--
ALTER TABLE `cases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_department` (`id_department`),
  ADD KEY `id_archive` (`id_archive`);

--
-- Индексы таблицы `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_case` (`id_case`);

--
-- Индексы таблицы `interaction_history`
--
ALTER TABLE `interaction_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_type` (`id_type`),
  ADD KEY `id_archive` (`id_archive`),
  ADD KEY `request_id` (`request_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_requests` (`id_requests`),
  ADD KEY `sender_id` (`sender_id`);

--
-- Индексы таблицы `opici`
--
ALTER TABLE `opici`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_case` (`id_case`);

--
-- Индексы таблицы `requests`
--
ALTER TABLE `requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type_id` (`type_id`),
  ADD KEY `id_client` (`id_client`);

--
-- Индексы таблицы `type_interaction`
--
ALTER TABLE `type_interaction`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `type_requests`
--
ALTER TABLE `type_requests`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `archive`
--
ALTER TABLE `archive`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `cases`
--
ALTER TABLE `cases`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `client`
--
ALTER TABLE `client`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `documents`
--
ALTER TABLE `documents`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `interaction_history`
--
ALTER TABLE `interaction_history`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `opici`
--
ALTER TABLE `opici`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `requests`
--
ALTER TABLE `requests`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `type_interaction`
--
ALTER TABLE `type_interaction`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `type_requests`
--
ALTER TABLE `type_requests`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `cases`
--
ALTER TABLE `cases`
  ADD CONSTRAINT `cases_ibfk_1` FOREIGN KEY (`id_department`) REFERENCES `departments` (`id`),
  ADD CONSTRAINT `cases_ibfk_2` FOREIGN KEY (`id_archive`) REFERENCES `archive` (`id`);

--
-- Ограничения внешнего ключа таблицы `documents`
--
ALTER TABLE `documents`
  ADD CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`id_case`) REFERENCES `cases` (`id`);

--
-- Ограничения внешнего ключа таблицы `interaction_history`
--
ALTER TABLE `interaction_history`
  ADD CONSTRAINT `interaction_history_ibfk_1` FOREIGN KEY (`id_type`) REFERENCES `type_interaction` (`id`),
  ADD CONSTRAINT `interaction_history_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `interaction_history_ibfk_4` FOREIGN KEY (`id_archive`) REFERENCES `archive` (`id`);

--
-- Ограничения внешнего ключа таблицы `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`id_requests`) REFERENCES `requests` (`id`),
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `opici`
--
ALTER TABLE `opici`
  ADD CONSTRAINT `opici_ibfk_1` FOREIGN KEY (`id_case`) REFERENCES `cases` (`id`);

--
-- Ограничения внешнего ключа таблицы `requests`
--
ALTER TABLE `requests`
  ADD CONSTRAINT `requests_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `type_requests` (`id`),
  ADD CONSTRAINT `requests_ibfk_2` FOREIGN KEY (`id_client`) REFERENCES `client` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
