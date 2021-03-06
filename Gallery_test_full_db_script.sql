USE [master]
GO
/****** Object:  Database [Gallery_test]    Script Date: 25.05.2021 1:47:10 ******/
CREATE DATABASE [Gallery_test]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Gallery_test', FILENAME = N'D:\MS SQL SERVER\MSSQL14.SQLEXPRESS\MSSQL\DATA\Gallery_test.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Gallery_test_log', FILENAME = N'D:\MS SQL SERVER\MSSQL14.SQLEXPRESS\MSSQL\DATA\Gallery_test_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Gallery_test] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Gallery_test].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Gallery_test] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Gallery_test] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Gallery_test] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Gallery_test] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Gallery_test] SET ARITHABORT OFF 
GO
ALTER DATABASE [Gallery_test] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Gallery_test] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Gallery_test] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Gallery_test] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Gallery_test] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Gallery_test] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Gallery_test] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Gallery_test] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Gallery_test] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Gallery_test] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Gallery_test] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Gallery_test] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Gallery_test] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Gallery_test] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Gallery_test] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Gallery_test] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Gallery_test] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Gallery_test] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Gallery_test] SET  MULTI_USER 
GO
ALTER DATABASE [Gallery_test] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Gallery_test] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Gallery_test] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Gallery_test] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Gallery_test] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Gallery_test] SET QUERY_STORE = OFF
GO
USE [Gallery_test]
GO
/****** Object:  Table [dbo].[Player]    Script Date: 25.05.2021 1:47:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Player](
	[player_id] [int] IDENTITY(1,1) NOT NULL,
	[player_name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Place] PRIMARY KEY CLUSTERED 
(
	[player_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlayerHistory]    Script Date: 25.05.2021 1:47:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlayerHistory](
	[datetime] [datetime] NOT NULL,
	[player_id] [int] NOT NULL,
	[video_id] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlayerVideo]    Script Date: 25.05.2021 1:47:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlayerVideo](
	[player_id] [int] NOT NULL,
	[video_id] [int] NULL,
 CONSTRAINT [IX_PlayerVideo] UNIQUE NONCLUSTERED 
(
	[player_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Video]    Script Date: 25.05.2021 1:47:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Video](
	[video_id] [int] IDENTITY(1,1) NOT NULL,
	[video_name] [nvarchar](100) NOT NULL,
	[duration] [int] NOT NULL,
 CONSTRAINT [PK_Video] PRIMARY KEY CLUSTERED 
(
	[video_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [NonClusteredIndex-20210524-174019]    Script Date: 25.05.2021 1:47:10 ******/
CREATE UNIQUE NONCLUSTERED INDEX [NonClusteredIndex-20210524-174019] ON [dbo].[Video]
(
	[video_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PlayerHistory] ADD  CONSTRAINT [DF_PlayerHistory_datetime]  DEFAULT (getdate()) FOR [datetime]
GO
ALTER TABLE [dbo].[PlayerHistory]  WITH CHECK ADD  CONSTRAINT [FK_PlayerHistory_Player] FOREIGN KEY([player_id])
REFERENCES [dbo].[Player] ([player_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PlayerHistory] CHECK CONSTRAINT [FK_PlayerHistory_Player]
GO
ALTER TABLE [dbo].[PlayerHistory]  WITH CHECK ADD  CONSTRAINT [FK_PlayerHistory_Video] FOREIGN KEY([video_id])
REFERENCES [dbo].[Video] ([video_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PlayerHistory] CHECK CONSTRAINT [FK_PlayerHistory_Video]
GO
ALTER TABLE [dbo].[PlayerVideo]  WITH CHECK ADD  CONSTRAINT [FK_PlayerVideo_Player] FOREIGN KEY([player_id])
REFERENCES [dbo].[Player] ([player_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PlayerVideo] CHECK CONSTRAINT [FK_PlayerVideo_Player]
GO
ALTER TABLE [dbo].[PlayerVideo]  WITH CHECK ADD  CONSTRAINT [FK_PlayerVideo_Video] FOREIGN KEY([player_id])
REFERENCES [dbo].[Video] ([video_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PlayerVideo] CHECK CONSTRAINT [FK_PlayerVideo_Video]
GO
ALTER TABLE [dbo].[Video]  WITH CHECK ADD CHECK  (([duration]>(0)))
GO
/****** Object:  StoredProcedure [dbo].[DoCheck]    Script Date: 25.05.2021 1:47:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Кутумов Никита
-- Tel number:  89687995380
-- Email:		nik_2008@bk.ru
-- Create date: 24.05.21 - 25.05.21
-- Description:	Процедура для проверки
-- =============================================
CREATE proc [dbo].[DoCheck] as
BEGIN
-- сначала почистим историю плеера (показов видео)
	delete from PlayerHistory
---------------------
	BEGIN
	DECLARE 
		@total_duration int = 0
		-- ⚠ раскомментировать при проверке варианта с передачей имени текущего видео в процедуру
		--, @last_video_name nvarchar(100) = 'Лента.mp4'

		print '==================================================';
		print 'Список показанных видео за 1 час, последовательно:';
		print '==================================================';

	While (@total_duration < 3600)
		BEGIN
			-- sql server profiler, одна операция по получению видео ~9мс
			DECLARE @next_video_name nvarchar(100)

			--⚠ ЗАкомментировать при проверке варианта с передачей имени текущего видео в процедуру
			exec GetNextVideoFileName 1, null, @next_video_name Output

			--⚠ раскомментировать при проверке варианта с передачей имени текущего видео в процедуру
			--exec GetNextVideoFileName 1, @last_video_name, @next_video_name Output
			--SET @last_video_name = @next_video_name;

			-- прибавляем к текущей продолжительности показа время показа следующего видео
			SET @total_duration = @total_duration + (select duration from Video where video_name = @next_video_name);
		END
	END

END
GO
/****** Object:  StoredProcedure [dbo].[FillVideoTable]    Script Date: 25.05.2021 1:47:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[FillVideoTable] as
begin tran
insert into Video (video_name,duration)
values 
('MВидео.mp4', 5)
, ('Эльдорадо.mp4', 5)
, ('Перекресток.mp4', 10)
, ('Лента.mp4', 10)
, ('Форд.mp4', 5)
, ('Ашан.mp4', 5)
, ('Леруа.mp4', 5)
, ('Леново.mp4', 5)
, ('Фольксваген.mp4', 5)
, ('Йота.mp4', 5)
commit tran
GO
/****** Object:  StoredProcedure [dbo].[GetMinIndexVideoId]    Script Date: 25.05.2021 1:47:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==================[DESCRIPTION]===================
-- Author:		Кутумов Никита
-- Tel number:  89687995380
-- Email:		nik_2008@bk.ru
-- Create date: 24.05.21 - 25.05.21
-- Description:	Получение наименее воспроизводимого видео

CREATE PROC [dbo].[GetMinIndexVideoId](
	@player_id int = 1,
	@minIndexVideoId int OUTPUT
) AS
BEGIN
SET @minIndexVideoId =
  (SELECT top 1 Results.res_video_id
   FROM
     (SELECT isnull(count(resultArray.video_id) * resultArray.duration, 0) AS [index] ,
             resultArray.video_id AS res_video_id
      FROM
        (SELECT v.video_id
                , v.duration
                , ph.player_id
         FROM PlayerHistory AS ph
         LEFT JOIN Video AS v ON v.video_id = ph.video_id
         UNION ALL SELECT v.video_id
                          , v.duration
                          , ph.player_id
         FROM PlayerHistory AS ph
         FULL OUTER JOIN Video AS v ON v.video_id = ph.video_id) AS resultArray
      WHERE resultArray.player_id = @player_id
        OR resultArray.player_id IS NULL
      GROUP BY resultArray.video_id,
               resultArray.duration) AS Results
   ORDER BY Results.[index] ASC);

END
GO
/****** Object:  StoredProcedure [dbo].[GetNextVideoFileName]    Script Date: 25.05.2021 1:47:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================[INTRODUCTION]=====================
-- Данная процедура написана с допущением, что плеер вызывает ее
-- за секунду до окончания воспроизведения текущего видеоролика,
-- чтобы получить название файла слудющего ролика.
-- Также допускаем, что плеер не знает, какой video_id он
-- воспроизводит в данный момент времени 
-- (что вполне логично, ведь реализация плеера может быть различной),
-- а знает только название текущего видеофайла (MВидео.mp4).
--
-- В случае передачи текущего видео в параметры процедуры
-- (чтобы в процедуру плеер
-- передавал название прошлого ролика и при поиске следующего,
-- мы бы отталкивались от названия предыдущего)
-- можно добавить некластеризованный индекс
-- по полю video_name в таблицу Video, если она разрастется до размеров,
-- когда поиск по индексу станет проходить быстрее.
--
-- Я решил сделать универсальный вариант. 
-- Плеер может передавать в процедуру название текущего ролика, 
-- а может и нет, поэтому мы будем хранить текущий ролик в 
-- таблице с привязкой к абстрактному месту воспроизведения (Player).
--
-- Соответсвенно, завершая описание, скажем, что плеер должен
-- вызвать процедуру, отправив в качестве параметра обязательную
-- переменную @player_id, обуславливающую место воспроизведения.
-- А также в зависимости от реализации плеера, может отправить в 
-- качестве параметра и название текущего ролика.

-- ================[HOW IT WORKS]=====================
-- 1) В вызванной процедуре находим ID видео, которое 
-- воспроизводится в данный момент
-- 2) Записываем результат п.1 в таблицу PlayerHistory
-- 3) Находим video_id следующего видео, используя процедуру
--	GetMinIndexVideoId, которая создает импровизированный индекс, 
--	не имеющий ничего общего с индексами sql 😀, 
--	путем умножения числа воспроизведений видео на его продолжительность.
--	Выбираем video_id c !наименьшим импровизированным индексом.
-- 4) Заносим полученный в п.3 video_id нового видео в таблицу PlayerVideo, 
--	которая отражает текущее состояние плеера.
-- 5) Возвращаем плееру название нового видео.


-- ================[TEST]====================
-- ⚠ Специальная процедура для тестирования и проверки результов
-- называется DoCheck.
-- exec [dbo].[DoCheck];

-- ⚠ Чтобы проверить количество показаных объявлений за час,
-- запустите после exec DoCheck следующее:
--select 
--count(*)       as [Число показов за час]
--, v.video_name as [Название видео]
--, v.duration   as [Продолжительность, сек]
--from PlayerHistory as ph
--left join Video as v on v.video_id = ph.video_id
--group by v.video_name, v.video_id, v.duration
--order by  v.video_id


-- ==================[DESCRIPTION]===================
-- Author:		Кутумов Никита
-- Tel number:  89687995380
-- Email:		nik_2008@bk.ru
-- Create date: 24.05.21 - 25.05.21
-- Description:	Получение названия файла для воспроизведения


-- ==================[P.S.]===================
-- Примерно потрачено времени, с очисткой кода и комментариями:
-- 4-6 часов. Благодарю за внимание :)


CREATE PROCEDURE [dbo].[GetNextVideoFileName] (
	@player_id int = 1
	, @current_video_name nvarchar(100) = null
	, @next_video_name nvarchar(100) OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE
		@current_video_id int,
		@next_video_id int

	--Определение просмотренного видео
	IF(@current_video_name IS NOT NULL)
		BEGIN
			SET @current_video_id = ISNULL((select video_id from Video where video_name = @current_video_name),
				(select top 1 video_id from Video));
		END
	ELSE
		BEGIN 
			SET @current_video_id = ISNULL((select video_id from PlayerVideo where player_id = @player_id),
				(select top 1 video_id from Video));
		END

	--Запись в историю просмотренного видео
	INSERT INTO PlayerHistory (player_id, video_id) values (@player_id, @current_video_id);
	
	--Получение video_id (нового видео для плеера) с наименьшим коэфициентом 
	exec GetMinIndexVideoId @player_id, @next_video_id OUTPUT;

	--Запись в таблицу PlayerVideo выбранного (нового) видео
	UPDATE PlayerVideo SET video_id = @next_video_id where player_id = @player_id

	--Находим название нового видео
	SET @next_video_name = (select video_name from Video where video_id = @next_video_id);

	--Выводим название видео для наглядности
	print @next_video_name;
END

GO
USE [master]
GO
ALTER DATABASE [Gallery_test] SET  READ_WRITE 
GO
