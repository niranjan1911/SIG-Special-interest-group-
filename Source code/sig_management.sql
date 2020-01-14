-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 23, 2019 at 04:08 PM
-- Server version: 10.1.28-MariaDB
-- PHP Version: 7.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sig_management`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `eventcount` ()  BEGIN
    DECLARE finished INTEGER DEFAULT 0;
    DECLARE store varchar(10);
    DECLARE noOfEvents INT;
 
    SET noOfEvents :=0;
    
    BEGIN
     
    DECLARE t_event CURSOR FOR 
    SELECT event_id FROM event;
 
    
    DECLARE CONTINUE HANDLER 
FOR NOT FOUND SET finished = 1;
 
    OPEN t_event;
 
    getUsers: LOOP
FETCH t_event INTO store;

IF finished = 1 THEN 
    LEAVE getUsers;
ELSE
    SET noOfEvents := noOfEvents+1;
END IF;
    END LOOP getUsers;
    CLOSE t_event;
    END;
  SELECT noOfEvents;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAnswers` (IN `qid` VARCHAR(10))  NO SQL
BEGIN
	select * from answers
	where question_id = qid
   	order by posted_on DESC;
END$$

CREATE DEFINER=``@`localhost` PROCEDURE `getComments` (IN `pid` VARCHAR(10))  begin
select * from comments where post_id=pid order by posted_on desc;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `groupcount` ()  BEGIN
    DECLARE finished INTEGER DEFAULT 0;
    DECLARE store varchar(10);
    DECLARE noOfGroups INT;
 
    SET noOfGroups :=0;
    
    BEGIN
     
    DECLARE t_group CURSOR FOR 
    SELECT group_id FROM group_details;
 
    
    DECLARE CONTINUE HANDLER 
FOR NOT FOUND SET finished = 1;
 
    OPEN t_group;
 
    getUsers: LOOP
FETCH t_group INTO store;

IF finished = 1 THEN 
    LEAVE getUsers;
ELSE
    SET noOfGroups := noOfGroups+1;
END IF;
    END LOOP getUsers;
    CLOSE t_group;
    END;
  SELECT noOfGroups;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `isMember` (IN `uid` VARCHAR(10), IN `gid` VARCHAR(10))  BEGIN
	select * from group_members where group_id = gid and user_id = uid;
END$$

CREATE DEFINER=``@`localhost` PROCEDURE `leave_group` (IN `uid` VARCHAR(11), IN `gid` VARCHAR(11))  begin
    delete from `event` where user_id = uid and group_id = gid;
    delete from `answers` where user_id = uid and question_id in (select question_id from questions where group_id = gid);
    delete from `comments` where user_id = uid and post_id in (select post_id from post where group_id = gid);
    delete from `post` where user_id = uid and group_id = gid;
    delete from `questions` where user_id = uid and group_id = gid;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `usercount` ()  BEGIN     DECLARE finished INTEGER DEFAULT 0;     DECLARE store varchar(10);     DECLARE noOfUsers INT;       SET noOfUsers :=0;          BEGIN           DECLARE t_users CURSOR FOR      SELECT user_id FROM users;            DECLARE CONTINUE HANDLER  FOR NOT FOUND SET finished = 1;       OPEN t_users;       getUsers: LOOP FETCH t_users INTO store;  IF finished = 1 THEN      LEAVE getUsers; ELSE     SET noOfUsers := noOfUsers+1; END IF;     END LOOP getUsers;     CLOSE t_users;     END;   SELECT noOfUsers; END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `answers`
--

CREATE TABLE `answers` (
  `question_id` int(11) NOT NULL,
  `answer_id` int(11) NOT NULL,
  `answer` varchar(500) NOT NULL,
  `user_id` varchar(10) NOT NULL,
  `posted_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `answers`
--

INSERT INTO `answers` (`question_id`, `answer_id`, `answer`, `user_id`, `posted_on`) VALUES
(2, 2, 'using callable statements.', 'sanket', '2019-10-23 12:31:20'),
(2, 3, 'using callable statements in java', 'Swapnil', '2019-10-23 12:46:39'),
(3, 4, 'java is founded by Sun micro system at AT and T s laboratory.. ', 'niranjan19', '2019-10-23 12:46:46'),
(4, 5, 'wish arya', 'Swapnil', '2019-10-23 12:48:15'),
(6, 6, 'see the post related to blockchain', 'Swapnil', '2019-10-23 12:53:47'),
(8, 7, 'Bro here machine learns to do do tasks and predict results based on data.', 'jp_007', '2019-10-23 12:53:51'),
(3, 8, 'And it runs on 3 billion devices', 'manas', '2019-10-23 12:55:43'),
(8, 9, 'Improve adapt overcome', 'manas', '2019-10-23 12:58:01'),
(11, 12, 'no bro we cant use javascript for database connection it is only for scripting.', 'Swapnil', '2019-10-23 13:07:50'),
(11, 13, 'If you use both together it will be awesome', 'manas', '2019-10-23 13:08:03'),
(14, 14, 'supervised needs  trained data.', 'jp_007', '2019-10-23 13:10:41'),
(18, 15, 'He will play next world cup bro..', 'ravindra', '2019-10-23 13:44:37'),
(20, 16, 'See whenever you use any application. Your data has to be maintained somewhere. Database is the key to do that.', 'manas', '2019-10-23 13:46:41'),
(20, 17, 'Thank you....!', 'shirdhone', '2019-10-23 13:47:09');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `comment_id` int(11) NOT NULL,
  `comment` varchar(500) NOT NULL,
  `post_id` int(11) NOT NULL,
  `user_id` varchar(10) NOT NULL,
  `posted_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`comment_id`, `comment`, `post_id`, `user_id`, `posted_on`) VALUES
(2, 'yes....', 2, 'sanket', '2019-10-23 12:30:54'),
(3, 'yes, it is fully object oriented language', 2, 'Swapnil', '2019-10-23 12:45:42'),
(4, 'not only bitcoins.', 4, 'jp_007', '2019-10-23 12:46:57'),
(5, 'it can be used for any secured data storing.', 4, 'Swapnil', '2019-10-23 12:50:21'),
(6, 'i want complete overview..', 4, 'niranjan19', '2019-10-23 12:54:54'),
(7, 'Whats the difference', 7, 'manas', '2019-10-23 12:55:04'),
(8, 'I agree', 2, 'manas', '2019-10-23 12:55:18'),
(9, 'you can attend the events related to blockchain.', 4, 'Swapnil', '2019-10-23 12:57:31'),
(10, 'Ofcourse', 3, 'manas', '2019-10-23 12:57:46'),
(11, 'Sure', 8, 'manas', '2019-10-23 13:10:06'),
(12, 'rich dad poor dad', 13, 'Swapnil', '2019-10-23 13:19:28'),
(13, 'please ask your questions in question section.', 13, 'niranjan19', '2019-10-23 13:19:57'),
(14, 'yay....!  india is going to win this also.....', 15, 'niranjan19', '2019-10-23 13:21:00'),
(15, 'The best biopic', 16, 'manas', '2019-10-23 13:21:37'),
(16, 'Ok thanks', 13, 'manas', '2019-10-23 13:22:17'),
(17, 'Is doni going to play there', 15, 'jp_007', '2019-10-23 13:25:07'),
(18, 'yes\r\n', 16, 'shirdhone', '2019-10-23 13:43:15');

-- --------------------------------------------------------

--
-- Table structure for table `event`
--

CREATE TABLE `event` (
  `event_id` int(11) NOT NULL,
  `details` varchar(500) NOT NULL,
  `group_id` varchar(10) NOT NULL,
  `date` date NOT NULL,
  `user_id` varchar(10) NOT NULL,
  `posted_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `event_name` varchar(50) NOT NULL,
  `venue` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `event`
--

INSERT INTO `event` (`event_id`, `details`, `group_id`, `date`, `user_id`, `posted_on`, `event_name`, `venue`) VALUES
(1, 'This event is for java developers from scratch.', 'java', '2019-10-22', 'niranjan19', '2019-10-23 12:25:12', 'java workshop', 'pict, pune'),
(2, 'This event is for java developers from scratch.', 'java', '2019-10-24', 'niranjan19', '2019-10-23 12:25:58', 'java workshop', 'pict, pune'),
(3, 'This seminar will be taken by most experienced man in ML.', 'ML', '2019-10-23', 'jp_007', '2019-10-23 12:33:44', 'Seminar on ML', 'shivaji nagar pune'),
(4, 'This seminar will be taken by most experienced man in ML.', 'ML', '2019-10-25', 'jp_007', '2019-10-23 12:33:53', 'Seminar on ML', 'shivaji nagar pune'),
(5, 'For blockchain eiginers', 'blockchain', '2019-10-26', 'niranjan19', '2019-10-23 12:37:34', 'Enthusia', 'mumbai'),
(6, 'web development and penetration testing. ', 'PHP', '2019-10-31', 'jp_007', '2019-10-23 12:59:51', 'being web spider', 'mumbai'),
(7, 'an wonderful opportunity to grab on to industry on site internships..', 'ML', '2019-10-30', 'manas', '2019-10-23 13:00:09', 'ml internship fair', 'pict pune'),
(8, 'blockchain concepts and basics will be covered.', 'blockchain', '2019-10-29', 'Swapnil', '2019-10-23 13:00:57', 'blockchain workshop', 'PICT,Pune '),
(9, 'cloud computing workshop', 'cloud', '2019-11-14', 'manas', '2019-10-23 13:02:32', 'cloud computing', 'sllab'),
(10, 'Mysql meetup 1', 'mysql', '2019-10-31', 'manas', '2019-10-23 13:06:47', 'MYSQL Meetup', 'pict pune'),
(11, 'Financial awareness addressed by experienced persons. ', 'Finance', '2019-11-07', 'jp_007', '2019-10-23 13:22:36', 'finAware', 'nashik'),
(12, 'Cricket match on next sunday', 'Cricket', '2019-11-08', 'Swapnil', '2019-10-23 13:24:26', 'Match', 'in Pune'),
(13, 'at kharadi', 'blockchain', '2019-11-21', 'Swapnil', '2019-10-23 13:26:30', 'workshop', 'kharadi bypass'),
(14, 'Cloud workshop 1', 'cloud', '2019-12-14', 'manas', '2019-10-23 13:32:57', 'cloud workshop', 'cloud lab'),
(15, 'java event', 'java', '2019-10-10', 'niranjan19', '2019-10-23 13:35:03', 'javax', 'pune');

-- --------------------------------------------------------

--
-- Table structure for table `event_registered`
--

CREATE TABLE `event_registered` (
  `event_id` int(11) NOT NULL,
  `user_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `event_registered`
--

INSERT INTO `event_registered` (`event_id`, `user_id`) VALUES
(4, 'niranjan19'),
(5, 'niranjan19'),
(5, 'Swapnil'),
(5, 'jp_007'),
(2, 'manas'),
(6, 'manas');

-- --------------------------------------------------------

--
-- Table structure for table `group_details`
--

CREATE TABLE `group_details` (
  `group_id` varchar(10) NOT NULL,
  `group_name` varchar(50) NOT NULL,
  `description` varchar(500) NOT NULL,
  `created_by` varchar(10) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `group_details`
--

INSERT INTO `group_details` (`group_id`, `group_name`, `description`, `created_by`, `date_created`) VALUES
('blockchain', 'Blockchain', 'blockchain is the technology that store the data securely.', 'Swapnil', '2019-10-23 12:35:21'),
('cloud', 'cloud computing', 'This sig will walk you through all the basics of cloud computing', 'manas', '2019-10-23 12:57:28'),
('Cricket', 'Cricket', 'The all about cricket is discussed here. \r\n', 'niranjan19', '2019-10-23 13:18:35'),
('Finance', 'Finance', 'Awareness of financial terms', 'jp_007', '2019-10-23 13:13:20'),
('java', 'java', 'a group for java developer to learn core java.', 'niranjan19', '2019-10-23 12:21:20'),
('ML', 'Machine Learning', 'group for machine learning enthusiasts and data scientists.', 'jp_007', '2019-10-23 12:25:59'),
('mongo', 'mongodb', 'MongoDB is the document oriented database.', 'Swapnil', '2019-10-23 13:17:30'),
('mysql', 'MySQL SIG', 'This sig is for MySQL', 'manas', '2019-10-23 13:06:02'),
('PHP', 'PHP', 'web developement using php.', 'jp_007', '2019-10-23 12:56:58'),
('python', 'python', 'python group.', 'sanket', '2019-10-23 12:30:26');

-- --------------------------------------------------------

--
-- Table structure for table `group_members`
--

CREATE TABLE `group_members` (
  `group_id` varchar(10) NOT NULL,
  `user_id` varchar(10) NOT NULL,
  `designation` varchar(20) NOT NULL DEFAULT 'member',
  `joined_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `group_members`
--

INSERT INTO `group_members` (`group_id`, `user_id`, `designation`, `joined_on`) VALUES
('blockchain', 'jp_007', 'member', '2019-10-23 12:46:26'),
('blockchain', 'manas', 'member', '2019-10-23 13:09:52'),
('blockchain', 'niranjan19', 'moderator', '2019-10-23 12:35:45'),
('blockchain', 'shirdhone', 'member', '2019-10-23 13:39:19'),
('blockchain', 'Swapnil', 'admin', '2019-10-23 12:35:21'),
('cloud', 'manas', 'admin', '2019-10-23 12:57:28'),
('cloud', 'niranjan19', 'member', '2019-10-23 12:59:18'),
('cloud', 'Swapnil', 'member', '2019-10-23 13:10:42'),
('Cricket', 'jp_007', 'member', '2019-10-23 13:24:14'),
('Cricket', 'manas', 'member', '2019-10-23 13:19:35'),
('Cricket', 'niranjan19', 'admin', '2019-10-23 13:18:35'),
('Cricket', 'ravindra', 'member', '2019-10-23 13:43:27'),
('Cricket', 'sanket', 'member', '2019-10-23 13:36:16'),
('Cricket', 'shirdhone', 'member', '2019-10-23 13:39:02'),
('Cricket', 'Swapnil', 'moderator', '2019-10-23 13:19:47'),
('Finance', 'jp_007', 'admin', '2019-10-23 13:13:20'),
('Finance', 'manas', 'member', '2019-10-23 13:17:54'),
('Finance', 'niranjan19', 'member', '2019-10-23 13:19:17'),
('Finance', 'Swapnil', 'member', '2019-10-23 13:17:45'),
('java', 'jp_007', 'member', '2019-10-23 12:49:27'),
('java', 'niranjan19', 'admin', '2019-10-23 12:21:20'),
('java', 'sanket', 'moderator', '2019-10-23 12:30:39'),
('java', 'shirdhone', 'member', '2019-10-23 13:39:11'),
('java', 'Swapnil', 'member', '2019-10-23 12:44:16'),
('ML', 'jp_007', 'admin', '2019-10-23 12:25:59'),
('ML', 'manas', 'moderator', '2019-10-23 12:57:36'),
('ML', 'niranjan19', 'member', '2019-10-23 12:27:47'),
('ML', 'Swapnil', 'member', '2019-10-23 12:35:53'),
('mongo', 'manas', 'member', '2019-10-23 13:37:13'),
('mongo', 'sanket', 'member', '2019-10-23 13:36:29'),
('mongo', 'Swapnil', 'admin', '2019-10-23 13:17:30'),
('mysql', 'manas', 'admin', '2019-10-23 13:06:02'),
('mysql', 'niranjan19', 'moderator', '2019-10-23 13:06:08'),
('mysql', 'sanket', 'member', '2019-10-23 13:36:23'),
('mysql', 'shirdhone', 'member', '2019-10-23 13:44:15'),
('PHP', 'jp_007', 'admin', '2019-10-23 12:56:58'),
('PHP', 'manas', 'member', '2019-10-23 13:03:40'),
('PHP', 'Swapnil', 'member', '2019-10-23 13:03:42'),
('python', 'jp_007', 'member', '2019-10-23 12:55:42'),
('python', 'manas', 'member', '2019-10-23 12:52:50'),
('python', 'sanket', 'admin', '2019-10-23 12:30:26'),
('python', 'Swapnil', 'member', '2019-10-23 12:35:46');

-- --------------------------------------------------------

--
-- Table structure for table `post`
--

CREATE TABLE `post` (
  `post_id` int(11) NOT NULL,
  `post` varchar(500) NOT NULL,
  `group_id` varchar(10) NOT NULL,
  `user_id` varchar(10) NOT NULL,
  `posted_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `post`
--

INSERT INTO `post` (`post_id`, `post`, `group_id`, `user_id`, `posted_on`) VALUES
(2, 'java is object oriented language.', 'java', 'niranjan19', '2019-10-23 12:23:29'),
(3, 'Welcome to this group guys. Do share your ideas and solutions here ', 'ML', 'jp_007', '2019-10-23 12:29:28'),
(4, 'Blockchain is the technology that is used for bitcoin currency.', 'blockchain', 'Swapnil', '2019-10-23 12:38:21'),
(5, 'where should i start', 'java', 'manas', '2019-10-23 12:50:48'),
(6, 'Can you tell me something about python?\r\n', 'python', 'manas', '2019-10-23 12:53:07'),
(7, 'use java 8 not java 12\r\n', 'java', 'Swapnil', '2019-10-23 12:54:48'),
(8, 'see the events related to blockchain.', 'blockchain', 'Swapnil', '2019-10-23 12:58:01'),
(9, 'Is this the official php group?\r\n', 'PHP', 'manas', '2019-10-23 13:03:53'),
(10, 'hi welcome all', 'cloud', 'manas', '2019-10-23 13:04:50'),
(12, 'hii i am very excited for this', 'cloud', 'niranjan19', '2019-10-23 13:11:24'),
(13, 'Can u suggest any good book?\r\n', 'Finance', 'manas', '2019-10-23 13:18:11'),
(14, 'Finance literacy related posts here', 'Finance', 'Swapnil', '2019-10-23 13:18:17'),
(15, 'India vs Ban Series starting soon stay tuned for updates', 'Cricket', 'manas', '2019-10-23 13:20:07'),
(16, 'ms dhoni ', 'Cricket', 'Swapnil', '2019-10-23 13:20:23'),
(17, 'get help by using db.commandname.help()', 'mongo', 'manas', '2019-10-23 13:37:54'),
(18, 'I am big fan of roHIT sharma.....', 'Cricket', 'shirdhone', '2019-10-23 13:43:48'),
(19, 'MySQL is the best relational database systems available.', 'mysql', 'manas', '2019-10-23 13:45:24');

--
-- Triggers `post`
--
DELIMITER $$
CREATE TRIGGER `del_post` BEFORE DELETE ON `post` FOR EACH ROW begin
delete from comments where post_id=old.post_id;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `question_id` int(11) NOT NULL,
  `question` varchar(500) NOT NULL,
  `group_id` varchar(10) NOT NULL,
  `user_id` varchar(10) NOT NULL,
  `resolved_by` varchar(10) DEFAULT NULL,
  `posted_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`question_id`, `question`, `group_id`, `user_id`, `resolved_by`, `posted_on`) VALUES
(2, 'how can i call procedure of mysql in java.', 'java', 'niranjan19', NULL, '2019-10-23 12:24:05'),
(3, 'What is history of java', 'java', 'Swapnil', NULL, '2019-10-23 12:44:47'),
(4, 'Who invented blockchain', 'blockchain', 'jp_007', NULL, '2019-10-23 12:47:51'),
(6, 'what is concept of blockchain???????????', 'blockchain', 'niranjan19', NULL, '2019-10-23 12:51:04'),
(7, 'why do i get nullpointer on my page?', 'java', 'manas', NULL, '2019-10-23 12:51:09'),
(8, 'What is exactly means machine learning', 'ML', 'Swapnil', NULL, '2019-10-23 12:51:57'),
(9, 'how to use loops in python?', 'python', 'manas', NULL, '2019-10-23 12:53:20'),
(11, 'Cant we use javascript except php.', 'PHP', 'jp_007', NULL, '2019-10-23 13:04:25'),
(12, 'ask your questions here', 'cloud', 'manas', NULL, '2019-10-23 13:05:20'),
(14, 'What is difference between supervised and unsupervised learning.', 'ML', 'niranjan19', NULL, '2019-10-23 13:07:49'),
(15, 'can we implement the mvc architecture using php', 'PHP', 'Swapnil', NULL, '2019-10-23 13:08:55'),
(16, 'what is cloud?', 'cloud', 'Swapnil', NULL, '2019-10-23 13:10:58'),
(17, 'what is difference between current and savings account', 'Finance', 'manas', NULL, '2019-10-23 13:18:46'),
(18, 'When the dhoni will be declare his retirement?', 'Cricket', 'Swapnil', NULL, '2019-10-23 13:21:25'),
(19, 'what is map reduce used for', 'mongo', 'manas', NULL, '2019-10-23 13:43:42'),
(20, 'I am ENTC student .what is database actually? can anyone tell me please.', 'mysql', 'shirdhone', NULL, '2019-10-23 13:45:31');

--
-- Triggers `questions`
--
DELIMITER $$
CREATE TRIGGER `del_question` BEFORE DELETE ON `questions` FOR EACH ROW begin delete from answers where question_id=old.question_id; end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(32) NOT NULL,
  `mobile_number` varchar(10) NOT NULL,
  `acc_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `name`, `email`, `password`, `mobile_number`, `acc_created`) VALUES
('jp_007', 'jayesh prajapati', 'prajapatijayesh1999@gmail.com', '4d069b4e77b1d1804bead1d3bea762b8', '9765657476', '2019-10-23 12:23:58'),
('manas', 'manas patil', 'pmanas10001@gmail.com', '55d50b38628db9c493be776840f8470d', '8551076431', '2019-10-23 12:48:29'),
('niranjan19', 'Niranjan Patil', 'niranjanpatil391312@gmail.com', '5b5238abd36529298cfcad96245c8ea4', '9422391312', '2019-10-23 12:18:53'),
('ravindra', 'ravi pawar', 'mnpatil155137@gmail.com', 'da5f05e5a77b8ddb8fb308eeab603575', '9878787656', '2019-10-23 13:42:20'),
('sanket', 'sanket ahane', 'sanket@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '9422399999', '2019-10-23 12:29:05'),
('shirdhone', 'Niranjan shirdhone', 'abc@gmail.com', 'a01610228fe998f515a72dd730294d87', '9422399999', '2019-10-23 13:37:37'),
('Swapnil', 'Swapnil', 'patilswapnil2512@gmail.com', '6c2c8b38d8ddacb6ec4a9a6466bd9a84', '8408057795', '2019-10-23 12:26:46');

--
-- Triggers `users`
--
DELIMITER $$
CREATE TRIGGER `user_delete` BEFORE DELETE ON `users` FOR EACH ROW begin
delete from group_members where user_id=old.user_id;
delete from post where user_id=old.user_id;
delete from questions where user_id=old.user_id;
end
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `answers`
--
ALTER TABLE `answers`
  ADD PRIMARY KEY (`answer_id`),
  ADD KEY `fk_question_answer` (`question_id`),
  ADD KEY `fk_user_answer` (`user_id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`comment_id`),
  ADD KEY `fk_post_comments` (`post_id`),
  ADD KEY `fk_user_comments` (`user_id`);

--
-- Indexes for table `event`
--
ALTER TABLE `event`
  ADD PRIMARY KEY (`event_id`),
  ADD KEY `fk_group_event` (`group_id`),
  ADD KEY `fk_user_event` (`user_id`);

--
-- Indexes for table `event_registered`
--
ALTER TABLE `event_registered`
  ADD KEY `fk_user_register` (`user_id`),
  ADD KEY `fk_event_event` (`event_id`);

--
-- Indexes for table `group_details`
--
ALTER TABLE `group_details`
  ADD PRIMARY KEY (`group_id`),
  ADD KEY `fk_group_creator` (`created_by`);

--
-- Indexes for table `group_members`
--
ALTER TABLE `group_members`
  ADD PRIMARY KEY (`group_id`,`user_id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `fk_user` (`user_id`);

--
-- Indexes for table `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`post_id`),
  ADD KEY `fk_group_post` (`group_id`),
  ADD KEY `fk_user_post` (`user_id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`question_id`),
  ADD KEY `fk_group_question` (`group_id`),
  ADD KEY `fk_user_question` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `unique_email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `answers`
--
ALTER TABLE `answers`
  MODIFY `answer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `comment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `event`
--
ALTER TABLE `event`
  MODIFY `event_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `post`
--
ALTER TABLE `post`
  MODIFY `post_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `question_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `answers`
--
ALTER TABLE `answers`
  ADD CONSTRAINT `fk_question_ans` FOREIGN KEY (`question_id`) REFERENCES `questions` (`question_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_answer` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `fk_post_comment` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_comments` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `event`
--
ALTER TABLE `event`
  ADD CONSTRAINT `fk_group_event` FOREIGN KEY (`group_id`) REFERENCES `group_details` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_event` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `event_registered`
--
ALTER TABLE `event_registered`
  ADD CONSTRAINT `fk_event_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_register` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `group_details`
--
ALTER TABLE `group_details`
  ADD CONSTRAINT `fk_group_creator` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `group_members`
--
ALTER TABLE `group_members`
  ADD CONSTRAINT `fk_group` FOREIGN KEY (`group_id`) REFERENCES `group_details` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `post`
--
ALTER TABLE `post`
  ADD CONSTRAINT `fk_group_post` FOREIGN KEY (`group_id`) REFERENCES `group_details` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_post` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `fk_group_question` FOREIGN KEY (`group_id`) REFERENCES `group_details` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_question` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
