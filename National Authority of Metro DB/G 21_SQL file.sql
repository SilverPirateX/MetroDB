-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Metro
-- -----------------------------------------------------
-- The National Authority of Metro
DROP SCHEMA IF EXISTS `Metro` ;

-- -----------------------------------------------------
-- Schema Metro
--
-- The National Authority of Metro
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Metro` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `Metro` ;

-- -----------------------------------------------------
-- Table `Metro`.`Staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Staff` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Staff` (
  `Ssn` INT NOT NULL AUTO_INCREMENT,
  `Fname` VARCHAR(45) NOT NULL,
  `Lname` VARCHAR(45) NOT NULL,
  `Salary` INT NOT NULL,
  `Bdate` DATE NOT NULL,
  `Age` INT NOT NULL,
  `Sex` CHAR(2) NOT NULL COMMENT 'the gender of the staff member \'M\' for male \'F\' for female.',
  PRIMARY KEY (`Ssn`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Phone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Phone` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Phone` (
  `Phone_no` INT NOT NULL,
  `Staff_Ssn` INT NOT NULL,
  PRIMARY KEY (`Phone_no`, `Staff_Ssn`),
  INDEX `fk_Phone_Staff1_idx` (`Staff_Ssn` ASC),
  CONSTRAINT `fk_Phone_Staff1`
    FOREIGN KEY (`Staff_Ssn`)
    REFERENCES `Metro`.`Staff` (`Ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Dependant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Dependant` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Dependant` (
  `Name` VARCHAR(40) NOT NULL DEFAULT 'nameless',
  `Staff_Ssn` INT NOT NULL DEFAULT 0000,
  `Relativity` VARCHAR(20) NOT NULL DEFAULT 'no',
  PRIMARY KEY (`Staff_Ssn`),
  CONSTRAINT `fk_Dependant_Staff1`
    FOREIGN KEY (`Staff_Ssn`)
    REFERENCES `Metro`.`Staff` (`Ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Manager`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Manager` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Manager` (
  `Type` VARCHAR(45) NOT NULL,
  `M_Ssn` INT NOT NULL,
  PRIMARY KEY (`M_Ssn`),
  CONSTRAINT `fk_Manager_Staff1`
    FOREIGN KEY (`M_Ssn`)
    REFERENCES `Metro`.`Staff` (`Ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Station`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Station` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Station` (
  `Number` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Line` INT NOT NULL,
  `Manager_M_Ssn` INT NOT NULL,
  PRIMARY KEY (`Number`),
  INDEX `fk_Station_Manager1_idx` (`Manager_M_Ssn` ASC),
  CONSTRAINT `fk_Station_Manager1`
    FOREIGN KEY (`Manager_M_Ssn`)
    REFERENCES `Metro`.`Manager` (`M_Ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Security`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Security` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Security` (
  `Position` VARCHAR(40) NOT NULL,
  `Station_Number` INT NOT NULL,
  `Staff_Ssn` INT NOT NULL,
  INDEX `fk_Security_Station1_idx` (`Station_Number` ASC),
  PRIMARY KEY (`Staff_Ssn`),
  CONSTRAINT `fk_Security_Station1`
    FOREIGN KEY (`Station_Number`)
    REFERENCES `Metro`.`Station` (`Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Security_Staff1`
    FOREIGN KEY (`Staff_Ssn`)
    REFERENCES `Metro`.`Staff` (`Ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Employee` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Employee` (
  `Place` VARCHAR(45) NOT NULL,
  `Supervisor Essn` INT NULL,
  `Station_Number` INT NOT NULL,
  `Staff_Ssn` INT NOT NULL,
  INDEX `fk_Employee_Station1_idx` (`Station_Number` ASC),
  PRIMARY KEY (`Staff_Ssn`),
  INDEX `fk_Employee_Staff2_idx` (`Staff_Ssn` ASC),
  INDEX `Supervisor Essn_idx` (`Supervisor Essn` ASC),
  CONSTRAINT `fk_Employee_Station1`
    FOREIGN KEY (`Station_Number`)
    REFERENCES `Metro`.`Station` (`Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_Staff2`
    FOREIGN KEY (`Staff_Ssn`)
    REFERENCES `Metro`.`Staff` (`Ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Supervisor Essn`
    FOREIGN KEY (`Supervisor Essn`)
    REFERENCES `Metro`.`Employee` (`Staff_Ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Service_Section`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Service_Section` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Service_Section` (
  `Section_no` INT NOT NULL,
  `Station_Number` INT NOT NULL,
  PRIMARY KEY (`Section_no`, `Station_Number`),
  INDEX `fk_Service_Section_Station1_idx` (`Station_Number` ASC),
  CONSTRAINT `fk_Service_Section_Station1`
    FOREIGN KEY (`Station_Number`)
    REFERENCES `Metro`.`Station` (`Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Ticket_Window`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Ticket_Window` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Ticket_Window` (
  `Number_ticket` INT NOT NULL,
  `Station_Number` INT NOT NULL,
  PRIMARY KEY (`Number_ticket`, `Station_Number`),
  INDEX `fk_Ticket_Window_Station1_idx` (`Station_Number` ASC),
  CONSTRAINT `fk_Ticket_Window_Station1`
    FOREIGN KEY (`Station_Number`)
    REFERENCES `Metro`.`Station` (`Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Maintenance_Workshop`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Maintenance_Workshop` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Maintenance_Workshop` (
  `Number` INT NOT NULL,
  `Station_Number` INT NOT NULL,
  PRIMARY KEY (`Number`, `Station_Number`),
  INDEX `fk_Maintenance_Workshop_Station1_idx` (`Station_Number` ASC),
  CONSTRAINT `fk_Maintenance_Workshop_Station1`
    FOREIGN KEY (`Station_Number`)
    REFERENCES `Metro`.`Station` (`Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Subscribtion_Office`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Subscribtion_Office` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Subscribtion_Office` (
  `User_Name` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Number` INT NOT NULL,
  `Service_Section_Section_no` INT NOT NULL,
  PRIMARY KEY (`Number`, `Service_Section_Section_no`),
  INDEX `fk_Subscribtion_Office_Service_Section1_idx` (`Service_Section_Section_no` ASC),
  CONSTRAINT `fk_Subscribtion_Office_Service_Section1`
    FOREIGN KEY (`Service_Section_Section_no`)
    REFERENCES `Metro`.`Service_Section` (`Section_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Metro_Store`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Metro_Store` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Metro_Store` (
  `Name` VARCHAR(45) NOT NULL,
  `Section_no` INT NOT NULL,
  `storeid` INT NULL,
  PRIMARY KEY (`Name`, `Section_no`),
  INDEX `fk_Metro_Store_Service_Section1_idx` (`Section_no` ASC),
  CONSTRAINT `fk_Metro_Store_Service_Section1`
    FOREIGN KEY (`Section_no`)
    REFERENCES `Metro`.`Service_Section` (`Section_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Ad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Ad` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Ad` (
  `ADID` INT NOT NULL,
  `Sponser_Name` VARCHAR(45) NOT NULL,
  `Sphone` INT NOT NULL,
  `Semail` VARCHAR(45) NOT NULL,
  `Sfax` INT NOT NULL,
  `Ad_copy` INT NOT NULL,
  `Section_Number` INT NOT NULL,
  PRIMARY KEY (`ADID`, `Section_Number`),
  INDEX `fk_Ad_Service_Section1_idx` (`Section_Number` ASC),
  CONSTRAINT `fk_Ad_Service_Section1`
    FOREIGN KEY (`Section_Number`)
    REFERENCES `Metro`.`Service_Section` (`Section_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Ticket`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Ticket` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Ticket` (
  `Serial` INT NOT NULL AUTO_INCREMENT,
  `Price` INT NOT NULL,
  `Category` CHAR(1) NOT NULL,
  PRIMARY KEY (`Serial`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Train`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Train` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Train` (
  `Number` INT NOT NULL,
  `System` VARCHAR(45) NOT NULL,
  `Type` VARCHAR(45) NOT NULL,
  `MWS_no` INT NOT NULL,
  PRIMARY KEY (`Number`),
  INDEX `fk_Train_Maintenance_Workshop1_idx` (`MWS_no` ASC),
  CONSTRAINT `fk_Train_Maintenance_Workshop1`
    FOREIGN KEY (`MWS_no`)
    REFERENCES `Metro`.`Maintenance_Workshop` (`Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Time_Table`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Time_Table` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Time_Table` (
  `LS_Time` CHAR(10) NOT NULL COMMENT 'first station arrived time o the metro line.',
  `FS_Time` CHAR(10) NOT NULL COMMENT 'first station arrived time o the metro line',
  `Direction` VARCHAR(20) NOT NULL,
  `Train_Number` INT NOT NULL,
  PRIMARY KEY (`Train_Number`),
  CONSTRAINT `fk_Time_Table_Train1`
    FOREIGN KEY (`Train_Number`)
    REFERENCES `Metro`.`Train` (`Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Subscriber`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Subscriber` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Subscriber` (
  `Name` VARCHAR(45) NOT NULL,
  `Ssn` INT NOT NULL,
  `Card_Serial` INT NOT NULL,
  `Card_Type` VARCHAR(20) NOT NULL,
  `Card_exp_date` DATE NOT NULL,
  `SO_Number` INT NOT NULL COMMENT 'subscribtion office number .',
  PRIMARY KEY (`Ssn`, `Card_Serial`),
  INDEX `fk_Subscriber_Subscribtion_Office1_idx` (`SO_Number` ASC),
  CONSTRAINT `fk_Subscriber_Subscribtion_Office1`
    FOREIGN KEY (`SO_Number`)
    REFERENCES `Metro`.`Subscribtion_Office` (`Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Sell`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Sell` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Sell` (
  `Ticket_Serial` INT NOT NULL,
  `tc_number` INT NOT NULL,
  PRIMARY KEY (`Ticket_Serial`, `tc_number`),
  INDEX `fk_Ticket_has_Ticket_Window_Ticket1_idx` (`Ticket_Serial` ASC),
  INDEX `tc_number_idx` (`tc_number` ASC),
  CONSTRAINT `fk_Ticket_has_Ticket_Window_Ticket1`
    FOREIGN KEY (`Ticket_Serial`)
    REFERENCES `Metro`.`Ticket` (`Serial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tc_number`
    FOREIGN KEY (`tc_number`)
    REFERENCES `Metro`.`Ticket_Window` (`Number_ticket`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Data for table `Metro`.`Staff`
-- -----------------------------------------------------
START TRANSACTION;
USE `Metro`;
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654321, 'Ahmed', 'Alagouz', 50000, '2000/09/22', 19, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654322, 'Mostafa', 'Atia', 50000, '2000/08/21', 19, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654323, 'Eslam', 'Mohamed', 50000, '2000/06/26', 19, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654324, 'Nada', 'Hamed', 50000, '2000/09/07', 19, 'F');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654325, 'Safa', 'Aymen', 50000, '2000/01/19', 19, 'F');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654326, 'John', 'Smith', 50000, '1994/05/15', 25, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654327, 'Nader', 'Hussien', 100000, '1990/05/24', 29, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654328, 'Ibrahim', 'Hegazy', 80000, '1990/05/22', 29, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654329, 'Sam', 'Ismail', 50000, '1996/04/22', 23, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654320, 'Elliot', 'Elderson', 50000, '1989/06/22', 30, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654330, 'Sohair', 'Abdallah', 10000, '1990/05/05', 29, 'F');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654331, 'Karema', 'Samir', 11000, '1990/06/22', 29, 'F');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654332, 'Amin', 'Abd-elgaleel', 9000, '1988/11/11', 31, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654333, 'Amin', 'Eltahawy', 9000, '1988/05/17', 31, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654334, 'Soltan', 'Abdallah', 9000, '1989/07/18', 32, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654335, 'Rahma', 'Nasser', 11000, '1999/07/23', 20, 'F');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654336, 'Fatma', 'Mansour', 5000, '1996/06/07', 24, 'F');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654337, 'Mai', 'Mohamed', 7000, '1999/08/17', 20, 'F');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654338, 'Ahmed', 'Mohamed', 7000, '1998/09/12', 21, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654339, 'Mohamed', 'Said', 7000, '1998/05/23', 21, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654340, 'Ahmed', 'Raafat', 10000, '1998/07/12', 21, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654341, 'Mohamed', 'Abdelfatah', 20000, '1999/11/02', 20, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654342, 'Cillian', 'Murphy', 20000, '1990/03/15', 29, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654380, 'Eida', 'Shelby', 20000, '1992/03/27', 29, 'F');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654343, 'Ahmed', 'Bayome', 20000, '2000/02/11', 19, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654344, 'Ahmed', 'Abbas', 20000, '2000/05/22', 19, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654345, 'Ibrahim', 'Atia', 15000, '1999/08/03', 20, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654346, 'Abdallah', 'Shawky', 15000, '1998/02/07', 21, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654347, 'Mahmoud', 'Eltayb', 15000, '1994/05/28', 25, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654348, 'Waheed', 'Ibrahim', 15000, '1992/12/01', 27, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654349, 'Vikram', 'Aryan', 15000, '1995/11/02', 24, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654350, 'Nada', 'Mohamed', 15000, '1992/05/12', 27, 'F');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654351, 'Samir', 'Mohamed', 15000, '1993/07/06', 26, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654352, 'Aya', 'Ashraf', 15000, '1998/08/03', 21, 'F');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654353, 'Aya', 'Samir', 15000, '1999/09/02', 20, 'F');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654354, 'Mazen', 'Mohamed', 15000, '1998/12/03', 21, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654355, 'Hoda', 'Mahmoud', 15000, '1991/11/09', 29, 'F');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654356, 'Karam', 'Mohamed', 15000, '1988/02/12', 32, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654357, 'Sohana', 'Khan', 15000, '2000/06/27', 19, 'F');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654358, 'Cristina', 'Aryan', 15000, '2000/05/19', 19, 'F');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654359, 'Emy', 'Hetari', 15000, '1987/01/12', 32, 'F');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654360, 'Negm', 'Taher', 15000, '1996/02/15', 23, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654361, 'Anas', 'Mohamed', 15000, '1994/03/08', 25, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654362, 'Osama', 'Gamal', 15000, '1995/08/07', 24, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654363, 'Mohamed', 'Gamal', 15000, '1980/11/05', 39, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654364, 'Mona', 'Mohamed', 15000, '1998/02/05', 21, 'F');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654365, 'Sara', 'Ahmed', 15000, '1988/08/26', 31, 'F');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654366, 'Oliver', 'Morjan', 15000, '1991/07/17', 28, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654367, 'Tomas', 'Alison', 15000, '1988/02/28', 31, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654368, 'Flora', 'Jean', 15000, '1994/08/14', 25, 'F');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654369, 'Kamilia', 'Botros', 15000, '1993/04/16', 26, 'F');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654370, 'Sami', 'Abdallah', 15000, '1994/05/21', 25, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654371, 'Nour', 'Ahmed', 15000, '1995/02/14', 24, 'F');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654372, 'Serag', 'Kasab', 15000, '1993/01/25', 26, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654373, 'Saly', 'Mansour', 15000, '1997/06/27', 22, 'F');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654374, 'Mahmoud', 'Ashraf', 15000, '1998/07/02', 21, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654375, 'Mena', 'Nader', 15000, '1999/08/29', 20, 'F');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654376, 'Shady', 'Abdelfatah', 15000, '1992/05/04', 27, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654377, 'Yassin', 'Saif', 15000, '1995/11/08', 24, 'M');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654378, 'Nourhan', 'Osama', 15000, '1998/05/07', 21, 'F');
INSERT INTO `Metro`.`Staff` (`Ssn`, `Fname`, `Lname`, `Salary`, `Bdate`, `Age`, `Sex`) VALUES (987654379, 'Marina', 'Saad', 15000, '1999/02/22', 20, 'F');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Metro`.`Phone`
-- -----------------------------------------------------
START TRANSACTION;
USE `Metro`;
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01149783038, 987654320);
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01125341323, 987654320);
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01262597536, 987654321);
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01010505160, 987654322);
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01565987423, 987654321);
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01150574376, 987654323);
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01012449767, 987654324);
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01256894232, 987654325);
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01156892255, 987654326);
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01756897145, 987654325);
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01758995869, 987654329);
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01325698756, 987654326);
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01259875566, 987654327);
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01122356698, 987654330);
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01245987622, 987654331);
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01159876346, 987654332);
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01256987566, 987654333);
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01565942365, 987654333);
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01368584455, 987654341);
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01256897565, 987654342);
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01115688966, 987654343);
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01556895321, 987654344);
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01156863545, 987654345);
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01356987862, 987654346);
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01279895563, 987654347);
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01766598456, 987654348);
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01369875241, 987654349);
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01333655998, 987654358);
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01115666987, 987654355);
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01156988772, 987654342);
INSERT INTO `Metro`.`Phone` (`Phone_no`, `Staff_Ssn`) VALUES (01445699632, 987654350);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Metro`.`Dependant`
-- -----------------------------------------------------
START TRANSACTION;
USE `Metro`;
INSERT INTO `Metro`.`Dependant` (`Name`, `Staff_Ssn`, `Relativity`) VALUES ('Alagouz Mohamed', 987654321, 'Father');
INSERT INTO `Metro`.`Dependant` (`Name`, `Staff_Ssn`, `Relativity`) VALUES ('Ibrahim Alagouz', 987654322, 'brother');
INSERT INTO `Metro`.`Dependant` (`Name`, `Staff_Ssn`, `Relativity`) VALUES ('Darlene Elderson', 987654323, 'Sister');
INSERT INTO `Metro`.`Dependant` (`Name`, `Staff_Ssn`, `Relativity`) VALUES ('Kareem Hegazy', 987654324, 'Brother');
INSERT INTO `Metro`.`Dependant` (`Name`, `Staff_Ssn`, `Relativity`) VALUES ('Hesham Hegazy', 987654325, 'Brother');
INSERT INTO `Metro`.`Dependant` (`Name`, `Staff_Ssn`, `Relativity`) VALUES ('Sandra Ismail', 987654326, 'Mother');
INSERT INTO `Metro`.`Dependant` (`Name`, `Staff_Ssn`, `Relativity`) VALUES ('Hossam Mohamed', 987654327, 'Brother');
INSERT INTO `Metro`.`Dependant` (`Name`, `Staff_Ssn`, `Relativity`) VALUES ('Sakra Smith', 987654328, 'Mother');
INSERT INTO `Metro`.`Dependant` (`Name`, `Staff_Ssn`, `Relativity`) VALUES ('Shady Atia', 987654329, 'Brother');
INSERT INTO `Metro`.`Dependant` (`Name`, `Staff_Ssn`, `Relativity`) VALUES ('Abdallah Mohamed', 987654330, 'father');
INSERT INTO `Metro`.`Dependant` (`Name`, `Staff_Ssn`, `Relativity`) VALUES ('Soha Samir', 987654331, 'Sister');
INSERT INTO `Metro`.`Dependant` (`Name`, `Staff_Ssn`, `Relativity`) VALUES ('Kareem Samir', 987654332, 'Brother');
INSERT INTO `Metro`.`Dependant` (`Name`, `Staff_Ssn`, `Relativity`) VALUES ('Mona Sami', 987654333, 'Mother');
INSERT INTO `Metro`.`Dependant` (`Name`, `Staff_Ssn`, `Relativity`) VALUES ('Ahmed Said', 987654334, 'Brother');
INSERT INTO `Metro`.`Dependant` (`Name`, `Staff_Ssn`, `Relativity`) VALUES ('Raafat Abdallah', 987654335, 'Father');
INSERT INTO `Metro`.`Dependant` (`Name`, `Staff_Ssn`, `Relativity`) VALUES ('Mohamed Raafat', 987654336, 'Brother');
INSERT INTO `Metro`.`Dependant` (`Name`, `Staff_Ssn`, `Relativity`) VALUES ('Mohamed Soltan', 987654337, 'Son');
INSERT INTO `Metro`.`Dependant` (`Name`, `Staff_Ssn`, `Relativity`) VALUES ('Sohila Soltan', 987654338, 'Daughter');
INSERT INTO `Metro`.`Dependant` (`Name`, `Staff_Ssn`, `Relativity`) VALUES (DEFAULT, DEFAULT, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Metro`.`Manager`
-- -----------------------------------------------------
START TRANSACTION;
USE `Metro`;
INSERT INTO `Metro`.`Manager` (`Type`, `M_Ssn`) VALUES ('Commission_Master', 987654320);
INSERT INTO `Metro`.`Manager` (`Type`, `M_Ssn`) VALUES ('Line_Master', 987654321);
INSERT INTO `Metro`.`Manager` (`Type`, `M_Ssn`) VALUES ('Station_Master', 987654322);
INSERT INTO `Metro`.`Manager` (`Type`, `M_Ssn`) VALUES ('Station_Master', 987654323);
INSERT INTO `Metro`.`Manager` (`Type`, `M_Ssn`) VALUES ('Station_Master', 987654324);
INSERT INTO `Metro`.`Manager` (`Type`, `M_Ssn`) VALUES ('Station_Master', 987654325);
INSERT INTO `Metro`.`Manager` (`Type`, `M_Ssn`) VALUES ('Station_Master', 987654326);
INSERT INTO `Metro`.`Manager` (`Type`, `M_Ssn`) VALUES ('Station_Master', 987654327);
INSERT INTO `Metro`.`Manager` (`Type`, `M_Ssn`) VALUES ('Station_Master', 987654328);
INSERT INTO `Metro`.`Manager` (`Type`, `M_Ssn`) VALUES ('Station_Master', 987654329);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Metro`.`Station`
-- -----------------------------------------------------
START TRANSACTION;
USE `Metro`;
INSERT INTO `Metro`.`Station` (`Number`, `Name`, `Line`, `Manager_M_Ssn`) VALUES (1, 'Adarsh Nagar', 1, 987654322);
INSERT INTO `Metro`.`Station` (`Number`, `Name`, `Line`, `Manager_M_Ssn`) VALUES (2, 'AIIMS', 1, 987654323);
INSERT INTO `Metro`.`Station` (`Number`, `Name`, `Line`, `Manager_M_Ssn`) VALUES (3, 'Central Secretariat', 2, 987654324);
INSERT INTO `Metro`.`Station` (`Number`, `Name`, `Line`, `Manager_M_Ssn`) VALUES (4, 'Guru Dronacharya', 3, 987654325);
INSERT INTO `Metro`.`Station` (`Number`, `Name`, `Line`, `Manager_M_Ssn`) VALUES (5, 'Hauz Khas', 1, 987654326);
INSERT INTO `Metro`.`Station` (`Number`, `Name`, `Line`, `Manager_M_Ssn`) VALUES (6, 'Jahangirpuri', 1, 987654327);
INSERT INTO `Metro`.`Station` (`Number`, `Name`, `Line`, `Manager_M_Ssn`) VALUES (7, 'Jor Bagh', 1, 987654328);
INSERT INTO `Metro`.`Station` (`Number`, `Name`, `Line`, `Manager_M_Ssn`) VALUES (8, 'Model Town', 1, 987654329);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Metro`.`Security`
-- -----------------------------------------------------
START TRANSACTION;
USE `Metro`;
INSERT INTO `Metro`.`Security` (`Position`, `Station_Number`, `Staff_Ssn`) VALUES ('Main_Hall', 1, 987654330);
INSERT INTO `Metro`.`Security` (`Position`, `Station_Number`, `Staff_Ssn`) VALUES ('Western_Gate', 1, 987654331);
INSERT INTO `Metro`.`Security` (`Position`, `Station_Number`, `Staff_Ssn`) VALUES ('Eastern_Gate', 1, 987654332);
INSERT INTO `Metro`.`Security` (`Position`, `Station_Number`, `Staff_Ssn`) VALUES ('Arriving_Platform', 1, 987654333);
INSERT INTO `Metro`.`Security` (`Position`, `Station_Number`, `Staff_Ssn`) VALUES ('Arriving_Platform', 2, 987654334);
INSERT INTO `Metro`.`Security` (`Position`, `Station_Number`, `Staff_Ssn`) VALUES ('Main_Hall', 2, 987654335);
INSERT INTO `Metro`.`Security` (`Position`, `Station_Number`, `Staff_Ssn`) VALUES ('Main_Gate', 2, 987654336);
INSERT INTO `Metro`.`Security` (`Position`, `Station_Number`, `Staff_Ssn`) VALUES ('Main_Gate', 3, 987654337);
INSERT INTO `Metro`.`Security` (`Position`, `Station_Number`, `Staff_Ssn`) VALUES ('Arriving_Platform', 3, 987654338);
INSERT INTO `Metro`.`Security` (`Position`, `Station_Number`, `Staff_Ssn`) VALUES ('Main_Gate', 4, 987654339);
INSERT INTO `Metro`.`Security` (`Position`, `Station_Number`, `Staff_Ssn`) VALUES ('Main_Hall', 4, 987654340);
INSERT INTO `Metro`.`Security` (`Position`, `Station_Number`, `Staff_Ssn`) VALUES ('Arriving_Platform', 5, 987654350);
INSERT INTO `Metro`.`Security` (`Position`, `Station_Number`, `Staff_Ssn`) VALUES ('Main_Hall', 5, 987654341);
INSERT INTO `Metro`.`Security` (`Position`, `Station_Number`, `Staff_Ssn`) VALUES ('Arriving_Platform', 6, 987654342);
INSERT INTO `Metro`.`Security` (`Position`, `Station_Number`, `Staff_Ssn`) VALUES ('Main_Gate', 6, 987654343);
INSERT INTO `Metro`.`Security` (`Position`, `Station_Number`, `Staff_Ssn`) VALUES ('Eastern_Gate', 7, 987654344);
INSERT INTO `Metro`.`Security` (`Position`, `Station_Number`, `Staff_Ssn`) VALUES ('Arriving_Platform', 7, 987654345);
INSERT INTO `Metro`.`Security` (`Position`, `Station_Number`, `Staff_Ssn`) VALUES ('Western_Gate', 7, 987654346);
INSERT INTO `Metro`.`Security` (`Position`, `Station_Number`, `Staff_Ssn`) VALUES ('Eastern_Gate', 8, 987654347);
INSERT INTO `Metro`.`Security` (`Position`, `Station_Number`, `Staff_Ssn`) VALUES ('Main_Hall', 8, 987654348);
INSERT INTO `Metro`.`Security` (`Position`, `Station_Number`, `Staff_Ssn`) VALUES ('Main_Gate', 8, 987654349);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Metro`.`Employee`
-- -----------------------------------------------------
START TRANSACTION;
USE `Metro`;
INSERT INTO `Metro`.`Employee` (`Place`, `Supervisor Essn`, `Station_Number`, `Staff_Ssn`) VALUES ('Main_Section', null, 1, 987654351);
INSERT INTO `Metro`.`Employee` (`Place`, `Supervisor Essn`, `Station_Number`, `Staff_Ssn`) VALUES ('Cleaning_Section', 987654351, 1, 987654352);
INSERT INTO `Metro`.`Employee` (`Place`, `Supervisor Essn`, `Station_Number`, `Staff_Ssn`) VALUES ('Violations_Section', 987654351, 1, 987654353);
INSERT INTO `Metro`.`Employee` (`Place`, `Supervisor Essn`, `Station_Number`, `Staff_Ssn`) VALUES ('IT', 987654351, 1, 987654354);
INSERT INTO `Metro`.`Employee` (`Place`, `Supervisor Essn`, `Station_Number`, `Staff_Ssn`) VALUES ('Main_Section', null, 2, 987654355);
INSERT INTO `Metro`.`Employee` (`Place`, `Supervisor Essn`, `Station_Number`, `Staff_Ssn`) VALUES ('Cleaning_Section', 987654355, 2, 987654356);
INSERT INTO `Metro`.`Employee` (`Place`, `Supervisor Essn`, `Station_Number`, `Staff_Ssn`) VALUES ('Violations_Section', 987654355, 2, 987654357);
INSERT INTO `Metro`.`Employee` (`Place`, `Supervisor Essn`, `Station_Number`, `Staff_Ssn`) VALUES ('IT', 987654355, 2, 987654358);
INSERT INTO `Metro`.`Employee` (`Place`, `Supervisor Essn`, `Station_Number`, `Staff_Ssn`) VALUES ('Main_Section', null, 3, 987654359);
INSERT INTO `Metro`.`Employee` (`Place`, `Supervisor Essn`, `Station_Number`, `Staff_Ssn`) VALUES ('Cleaning_Section', 987654359, 3, 987654360);
INSERT INTO `Metro`.`Employee` (`Place`, `Supervisor Essn`, `Station_Number`, `Staff_Ssn`) VALUES ('Violations_Section', 987654359, 3, 987654361);
INSERT INTO `Metro`.`Employee` (`Place`, `Supervisor Essn`, `Station_Number`, `Staff_Ssn`) VALUES ('IT', 987654359, 3, 987654362);
INSERT INTO `Metro`.`Employee` (`Place`, `Supervisor Essn`, `Station_Number`, `Staff_Ssn`) VALUES ('Main_Section', null, 4, 987654363);
INSERT INTO `Metro`.`Employee` (`Place`, `Supervisor Essn`, `Station_Number`, `Staff_Ssn`) VALUES ('Cleaning_Section', 987654363, 4, 987654364);
INSERT INTO `Metro`.`Employee` (`Place`, `Supervisor Essn`, `Station_Number`, `Staff_Ssn`) VALUES ('Violations_Section', 987654363, 4, 987654365);
INSERT INTO `Metro`.`Employee` (`Place`, `Supervisor Essn`, `Station_Number`, `Staff_Ssn`) VALUES ('IT', 987654363, 4, 987654366);
INSERT INTO `Metro`.`Employee` (`Place`, `Supervisor Essn`, `Station_Number`, `Staff_Ssn`) VALUES ('Main_Section', null, 5, 987654367);
INSERT INTO `Metro`.`Employee` (`Place`, `Supervisor Essn`, `Station_Number`, `Staff_Ssn`) VALUES ('Cleaning_Section', 987654367, 5, 987654368);
INSERT INTO `Metro`.`Employee` (`Place`, `Supervisor Essn`, `Station_Number`, `Staff_Ssn`) VALUES ('Violations_Section', 987654367, 5, 987654369);
INSERT INTO `Metro`.`Employee` (`Place`, `Supervisor Essn`, `Station_Number`, `Staff_Ssn`) VALUES ('IT', 987654367, 5, 987654370);
INSERT INTO `Metro`.`Employee` (`Place`, `Supervisor Essn`, `Station_Number`, `Staff_Ssn`) VALUES ('Main_Section', null, 6, 987654371);
INSERT INTO `Metro`.`Employee` (`Place`, `Supervisor Essn`, `Station_Number`, `Staff_Ssn`) VALUES ('Cleaning_Section', 987654371, 6, 987654372);
INSERT INTO `Metro`.`Employee` (`Place`, `Supervisor Essn`, `Station_Number`, `Staff_Ssn`) VALUES ('Violations_Section', 987654371, 6, 987654373);
INSERT INTO `Metro`.`Employee` (`Place`, `Supervisor Essn`, `Station_Number`, `Staff_Ssn`) VALUES ('IT', 987654371, 6, 987654374);
INSERT INTO `Metro`.`Employee` (`Place`, `Supervisor Essn`, `Station_Number`, `Staff_Ssn`) VALUES ('Main_Section', null, 7, 987654375);
INSERT INTO `Metro`.`Employee` (`Place`, `Supervisor Essn`, `Station_Number`, `Staff_Ssn`) VALUES ('Cleaning_Section', 987654375, 7, 987654376);
INSERT INTO `Metro`.`Employee` (`Place`, `Supervisor Essn`, `Station_Number`, `Staff_Ssn`) VALUES ('Violations_Section', 987654375, 7, 987654377);
INSERT INTO `Metro`.`Employee` (`Place`, `Supervisor Essn`, `Station_Number`, `Staff_Ssn`) VALUES ('Main_Section', null, 8, 987654378);
INSERT INTO `Metro`.`Employee` (`Place`, `Supervisor Essn`, `Station_Number`, `Staff_Ssn`) VALUES ('Cleaning_Section', 987654378, 8, 987654379);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Metro`.`Service_Section`
-- -----------------------------------------------------
START TRANSACTION;
USE `Metro`;
INSERT INTO `Metro`.`Service_Section` (`Section_no`, `Station_Number`) VALUES (111, 1);
INSERT INTO `Metro`.`Service_Section` (`Section_no`, `Station_Number`) VALUES (222, 2);
INSERT INTO `Metro`.`Service_Section` (`Section_no`, `Station_Number`) VALUES (333, 3);
INSERT INTO `Metro`.`Service_Section` (`Section_no`, `Station_Number`) VALUES (444, 4);
INSERT INTO `Metro`.`Service_Section` (`Section_no`, `Station_Number`) VALUES (555, 5);
INSERT INTO `Metro`.`Service_Section` (`Section_no`, `Station_Number`) VALUES (666, 6);
INSERT INTO `Metro`.`Service_Section` (`Section_no`, `Station_Number`) VALUES (777, 7);
INSERT INTO `Metro`.`Service_Section` (`Section_no`, `Station_Number`) VALUES (888, 8);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Metro`.`Ticket_Window`
-- -----------------------------------------------------
START TRANSACTION;
USE `Metro`;
INSERT INTO `Metro`.`Ticket_Window` (`Number_ticket`, `Station_Number`) VALUES (1, 1);
INSERT INTO `Metro`.`Ticket_Window` (`Number_ticket`, `Station_Number`) VALUES (2, 1);
INSERT INTO `Metro`.`Ticket_Window` (`Number_ticket`, `Station_Number`) VALUES (3, 1);
INSERT INTO `Metro`.`Ticket_Window` (`Number_ticket`, `Station_Number`) VALUES (4, 1);
INSERT INTO `Metro`.`Ticket_Window` (`Number_ticket`, `Station_Number`) VALUES (5, 2);
INSERT INTO `Metro`.`Ticket_Window` (`Number_ticket`, `Station_Number`) VALUES (6, 2);
INSERT INTO `Metro`.`Ticket_Window` (`Number_ticket`, `Station_Number`) VALUES (7, 2);
INSERT INTO `Metro`.`Ticket_Window` (`Number_ticket`, `Station_Number`) VALUES (8, 2);
INSERT INTO `Metro`.`Ticket_Window` (`Number_ticket`, `Station_Number`) VALUES (9, 3);
INSERT INTO `Metro`.`Ticket_Window` (`Number_ticket`, `Station_Number`) VALUES (10, 3);
INSERT INTO `Metro`.`Ticket_Window` (`Number_ticket`, `Station_Number`) VALUES (11, 3);
INSERT INTO `Metro`.`Ticket_Window` (`Number_ticket`, `Station_Number`) VALUES (12, 3);
INSERT INTO `Metro`.`Ticket_Window` (`Number_ticket`, `Station_Number`) VALUES (13, 4);
INSERT INTO `Metro`.`Ticket_Window` (`Number_ticket`, `Station_Number`) VALUES (14, 4);
INSERT INTO `Metro`.`Ticket_Window` (`Number_ticket`, `Station_Number`) VALUES (15, 4);
INSERT INTO `Metro`.`Ticket_Window` (`Number_ticket`, `Station_Number`) VALUES (16, 4);
INSERT INTO `Metro`.`Ticket_Window` (`Number_ticket`, `Station_Number`) VALUES (17, 5);
INSERT INTO `Metro`.`Ticket_Window` (`Number_ticket`, `Station_Number`) VALUES (18, 5);
INSERT INTO `Metro`.`Ticket_Window` (`Number_ticket`, `Station_Number`) VALUES (19, 5);
INSERT INTO `Metro`.`Ticket_Window` (`Number_ticket`, `Station_Number`) VALUES (20, 5);
INSERT INTO `Metro`.`Ticket_Window` (`Number_ticket`, `Station_Number`) VALUES (21, 6);
INSERT INTO `Metro`.`Ticket_Window` (`Number_ticket`, `Station_Number`) VALUES (22, 6);
INSERT INTO `Metro`.`Ticket_Window` (`Number_ticket`, `Station_Number`) VALUES (23, 6);
INSERT INTO `Metro`.`Ticket_Window` (`Number_ticket`, `Station_Number`) VALUES (24, 6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Metro`.`Maintenance_Workshop`
-- -----------------------------------------------------
START TRANSACTION;
USE `Metro`;
INSERT INTO `Metro`.`Maintenance_Workshop` (`Number`, `Station_Number`) VALUES (1, 1);
INSERT INTO `Metro`.`Maintenance_Workshop` (`Number`, `Station_Number`) VALUES (2, 8);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Metro`.`Subscribtion_Office`
-- -----------------------------------------------------
START TRANSACTION;
USE `Metro`;
INSERT INTO `Metro`.`Subscribtion_Office` (`User_Name`, `Password`, `Number`, `Service_Section_Section_no`) VALUES ('Venaldom112', 'pass123', 1, 222);
INSERT INTO `Metro`.`Subscribtion_Office` (`User_Name`, `Password`, `Number`, `Service_Section_Section_no`) VALUES ('Kirito19', '5689esl', 2, 444);
INSERT INTO `Metro`.`Subscribtion_Office` (`User_Name`, `Password`, `Number`, `Service_Section_Section_no`) VALUES ('HiIndia', '14ghoult', 3, 555);
INSERT INTO `Metro`.`Subscribtion_Office` (`User_Name`, `Password`, `Number`, `Service_Section_Section_no`) VALUES ('Itchigo88', 'Zabemaro19', 4, 666);
INSERT INTO `Metro`.`Subscribtion_Office` (`User_Name`, `Password`, `Number`, `Service_Section_Section_no`) VALUES ('olduser', 'drowssap11', 5, 777);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Metro`.`Metro_Store`
-- -----------------------------------------------------
START TRANSACTION;
USE `Metro`;
INSERT INTO `Metro`.`Metro_Store` (`Name`, `Section_no`, `storeid`) VALUES ('Cash&Carry', 111, 1);
INSERT INTO `Metro`.`Metro_Store` (`Name`, `Section_no`, `storeid`) VALUES ('Grofers', 111, 2);
INSERT INTO `Metro`.`Metro_Store` (`Name`, `Section_no`, `storeid`) VALUES ('Main Hoon na', 222, 3);
INSERT INTO `Metro`.`Metro_Store` (`Name`, `Section_no`, `storeid`) VALUES ('Kulture', 222, 4);
INSERT INTO `Metro`.`Metro_Store` (`Name`, `Section_no`, `storeid`) VALUES ('Cash&Carry', 333, 5);
INSERT INTO `Metro`.`Metro_Store` (`Name`, `Section_no`, `storeid`) VALUES ('Grofers', 333, 6);
INSERT INTO `Metro`.`Metro_Store` (`Name`, `Section_no`, `storeid`) VALUES ('Main Hoon na', 444, 7);
INSERT INTO `Metro`.`Metro_Store` (`Name`, `Section_no`, `storeid`) VALUES ('Kulture ', 444, 8);
INSERT INTO `Metro`.`Metro_Store` (`Name`, `Section_no`, `storeid`) VALUES ('Main Hoon na', 555, 9);
INSERT INTO `Metro`.`Metro_Store` (`Name`, `Section_no`, `storeid`) VALUES ('Cash&Carry', 555, 10);
INSERT INTO `Metro`.`Metro_Store` (`Name`, `Section_no`, `storeid`) VALUES ('Grofers', 666, 11);
INSERT INTO `Metro`.`Metro_Store` (`Name`, `Section_no`, `storeid`) VALUES ('Main Hoon na', 666, 12);
INSERT INTO `Metro`.`Metro_Store` (`Name`, `Section_no`, `storeid`) VALUES ('Kulture ', 777, 13);
INSERT INTO `Metro`.`Metro_Store` (`Name`, `Section_no`, `storeid`) VALUES ('Main Hoon na', 777, 14);
INSERT INTO `Metro`.`Metro_Store` (`Name`, `Section_no`, `storeid`) VALUES ('Grofers', 888, 15);
INSERT INTO `Metro`.`Metro_Store` (`Name`, `Section_no`, `storeid`) VALUES ('Cash&Carry', 888, 16);
INSERT INTO `Metro`.`Metro_Store` (`Name`, `Section_no`, `storeid`) VALUES ('Main Hoon na', 111, 17);
INSERT INTO `Metro`.`Metro_Store` (`Name`, `Section_no`, `storeid`) VALUES ('Grofers', 222, 18);
INSERT INTO `Metro`.`Metro_Store` (`Name`, `Section_no`, `storeid`) VALUES ('Kulture ', 333, 19);
INSERT INTO `Metro`.`Metro_Store` (`Name`, `Section_no`, `storeid`) VALUES ('monjeni', 444, 20);
INSERT INTO `Metro`.`Metro_Store` (`Name`, `Section_no`, `storeid`) VALUES ('monjeni', 555, 21);
INSERT INTO `Metro`.`Metro_Store` (`Name`, `Section_no`, `storeid`) VALUES ('monjeni', 666, 22);
INSERT INTO `Metro`.`Metro_Store` (`Name`, `Section_no`, `storeid`) VALUES ('monjeni', 777, 23);
INSERT INTO `Metro`.`Metro_Store` (`Name`, `Section_no`, `storeid`) VALUES ('monjeni', 888, 24);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Metro`.`Ad`
-- -----------------------------------------------------
START TRANSACTION;
USE `Metro`;
INSERT INTO `Metro`.`Ad` (`ADID`, `Sponser_Name`, `Sphone`, `Semail`, `Sfax`, `Ad_copy`, `Section_Number`) VALUES (01, 'Vodafone', 16888, 'SU@vodafone.com', 021029865, 1, 111);
INSERT INTO `Metro`.`Ad` (`ADID`, `Sponser_Name`, `Sphone`, `Semail`, `Sfax`, `Ad_copy`, `Section_Number`) VALUES (03, 'Uber', 13000912, 'first@UberSupport.com', 026457982, 1, 222);
INSERT INTO `Metro`.`Ad` (`ADID`, `Sponser_Name`, `Sphone`, `Semail`, `Sfax`, `Ad_copy`, `Section_Number`) VALUES (04, 'Oppo', 18001032, 'hello@oppo.com', 024934512, 1, 333);
INSERT INTO `Metro`.`Ad` (`ADID`, `Sponser_Name`, `Sphone`, `Semail`, `Sfax`, `Ad_copy`, `Section_Number`) VALUES (05, 'Samsung', 16580, 'contact@samsung.com', 021526847, 1, 444);
INSERT INTO `Metro`.`Ad` (`ADID`, `Sponser_Name`, `Sphone`, `Semail`, `Sfax`, `Ad_copy`, `Section_Number`) VALUES (06, 'Infinix', 00562171, 'hello@infinix.com', 025166687, 1, 555);
INSERT INTO `Metro`.`Ad` (`ADID`, `Sponser_Name`, `Sphone`, `Semail`, `Sfax`, `Ad_copy`, `Section_Number`) VALUES (07, 'Vodafone', 16888, 'SU@vodafone.com', 025679336, 2, 666);
INSERT INTO `Metro`.`Ad` (`ADID`, `Sponser_Name`, `Sphone`, `Semail`, `Sfax`, `Ad_copy`, `Section_Number`) VALUES (08, 'Careem', 97144405, 'legal@careem.com', 029865320, 1, 777);
INSERT INTO `Metro`.`Ad` (`ADID`, `Sponser_Name`, `Sphone`, `Semail`, `Sfax`, `Ad_copy`, `Section_Number`) VALUES (09, 'Hair Code', 03429788, 'HCSupport@hotmail.com', 021897656, 1, 888);
INSERT INTO `Metro`.`Ad` (`ADID`, `Sponser_Name`, `Sphone`, `Semail`, `Sfax`, `Ad_copy`, `Section_Number`) VALUES (10, 'Vatika', 34768, 'vbc@vatikagroup.com', 022215689, 1, 555);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Metro`.`Ticket`
-- -----------------------------------------------------
START TRANSACTION;
USE `Metro`;
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123456, 3, 'A');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123457, 3, 'A');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123458, 3, 'A');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123459, 5, 'B');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123460, 5, 'B');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123461, 7, 'C');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123462, 7, 'C');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123463, 7, 'C');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123464, 10, 'D');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123465, 10, 'D');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123466, 3, 'A');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123467, 3, 'A');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123468, 3, 'A');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123469, 5, 'B');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123470, 5, 'B');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123471, 3, 'A');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123472, 3, 'A');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123473, 3, 'A');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123474, 7, 'C');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123475, 7, 'C');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123476, 7, 'C');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123477, 5, 'B');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123478, 5, 'B');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123479, 5, 'B');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123480, 10, 'D');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123481, 3, 'A');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123482, 3, 'A');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123483, 7, 'C');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123484, 7, 'C');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123485, 10, 'D');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123486, 10, 'D');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123487, 3, 'A');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123488, 7, 'C');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123489, 5, 'B');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123490, 5, 'B');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123491, 5, 'B');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123492, 5, 'B');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123493, 5, 'B');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123494, 3, 'A');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123495, 3, 'A');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123496, 3, 'A');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123497, 3, 'A');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123498, 3, 'A');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123499, 5, 'B');
INSERT INTO `Metro`.`Ticket` (`Serial`, `Price`, `Category`) VALUES (123500, 7, 'C');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Metro`.`Train`
-- -----------------------------------------------------
START TRANSACTION;
USE `Metro`;
INSERT INTO `Metro`.`Train` (`Number`, `System`, `Type`, `MWS_no`) VALUES (001, 'A_electricity', 'French', 1);
INSERT INTO `Metro`.`Train` (`Number`, `System`, `Type`, `MWS_no`) VALUES (002, 'B_electricity', 'Italian', 1);
INSERT INTO `Metro`.`Train` (`Number`, `System`, `Type`, `MWS_no`) VALUES (003, 'A_electricity', 'French', 1);
INSERT INTO `Metro`.`Train` (`Number`, `System`, `Type`, `MWS_no`) VALUES (004, 'A_electricity', 'Spanish', 1);
INSERT INTO `Metro`.`Train` (`Number`, `System`, `Type`, `MWS_no`) VALUES (005, 'A_electricity', 'Chinese', 1);
INSERT INTO `Metro`.`Train` (`Number`, `System`, `Type`, `MWS_no`) VALUES (006, 'B_electricity', 'Spanish', 2);
INSERT INTO `Metro`.`Train` (`Number`, `System`, `Type`, `MWS_no`) VALUES (007, 'A_electricity', 'French', 2);
INSERT INTO `Metro`.`Train` (`Number`, `System`, `Type`, `MWS_no`) VALUES (008, 'B_electricity', 'Chinese', 2);
INSERT INTO `Metro`.`Train` (`Number`, `System`, `Type`, `MWS_no`) VALUES (009, 'A_electricity', 'Spanish', 2);
INSERT INTO `Metro`.`Train` (`Number`, `System`, `Type`, `MWS_no`) VALUES (010, 'B_electricity', 'Chinese', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Metro`.`Time_Table`
-- -----------------------------------------------------
START TRANSACTION;
USE `Metro`;
INSERT INTO `Metro`.`Time_Table` (`LS_Time`, `FS_Time`, `Direction`, `Train_Number`) VALUES ('10:20 am', '8:20 am', 'Adarsh Nagar', 001);
INSERT INTO `Metro`.`Time_Table` (`LS_Time`, `FS_Time`, `Direction`, `Train_Number`) VALUES ('10:40 am', '8:40 am', 'Adarsh Nagar', 002);
INSERT INTO `Metro`.`Time_Table` (`LS_Time`, `FS_Time`, `Direction`, `Train_Number`) VALUES ('11:00 am', '9:00 am', 'Model Town', 003);
INSERT INTO `Metro`.`Time_Table` (`LS_Time`, `FS_Time`, `Direction`, `Train_Number`) VALUES ('11:20 am', '9:20 am', 'Model Town', 004);
INSERT INTO `Metro`.`Time_Table` (`LS_Time`, `FS_Time`, `Direction`, `Train_Number`) VALUES ('11:40 am', '9:40 am', 'Adarsh Nagar', 005);
INSERT INTO `Metro`.`Time_Table` (`LS_Time`, `FS_Time`, `Direction`, `Train_Number`) VALUES ('12:00 pm', '10:00 am', 'Adarsh Nagar', 006);
INSERT INTO `Metro`.`Time_Table` (`LS_Time`, `FS_Time`, `Direction`, `Train_Number`) VALUES ('12:20 pm', '10:20 am', 'Model Town', 007);
INSERT INTO `Metro`.`Time_Table` (`LS_Time`, `FS_Time`, `Direction`, `Train_Number`) VALUES ('12:40 pm', '10:40 am', 'Model Town', 008);
INSERT INTO `Metro`.`Time_Table` (`LS_Time`, `FS_Time`, `Direction`, `Train_Number`) VALUES ('1:00 pm', '11:00 am', 'Adarsh Nagar', 009);
INSERT INTO `Metro`.`Time_Table` (`LS_Time`, `FS_Time`, `Direction`, `Train_Number`) VALUES ('1:20 pm', '11:20 am', 'Model Town', 010);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Metro`.`Subscriber`
-- -----------------------------------------------------
START TRANSACTION;
USE `Metro`;
INSERT INTO `Metro`.`Subscriber` (`Name`, `Ssn`, `Card_Serial`, `Card_Type`, `Card_exp_date`, `SO_Number`) VALUES ('Ahmed Ali', 987654371, 00000, 'Business', '2022/5/20', 1);
INSERT INTO `Metro`.`Subscriber` (`Name`, `Ssn`, `Card_Serial`, `Card_Type`, `Card_exp_date`, `SO_Number`) VALUES ('Mohamed Hussien', 987654372, 00001, 'University', '2020/1/26', 1);
INSERT INTO `Metro`.`Subscriber` (`Name`, `Ssn`, `Card_Serial`, `Card_Type`, `Card_exp_date`, `SO_Number`) VALUES ('Hoda Osama', 987654373, 00002, 'Tourism', '2020/3/12', 2);
INSERT INTO `Metro`.`Subscriber` (`Name`, `Ssn`, `Card_Serial`, `Card_Type`, `Card_exp_date`, `SO_Number`) VALUES ('Amina Ashraf', 987654374, 00003, 'University', '2020/1/15', 2);
INSERT INTO `Metro`.`Subscriber` (`Name`, `Ssn`, `Card_Serial`, `Card_Type`, `Card_exp_date`, `SO_Number`) VALUES ('Saad Mohy', 987654375, 00004, 'University', '2020/1/20', 3);
INSERT INTO `Metro`.`Subscriber` (`Name`, `Ssn`, `Card_Serial`, `Card_Type`, `Card_exp_date`, `SO_Number`) VALUES ('Amira Samir', 987654376, 00005, 'University', '2020/2/2', 4);
INSERT INTO `Metro`.`Subscriber` (`Name`, `Ssn`, `Card_Serial`, `Card_Type`, `Card_exp_date`, `SO_Number`) VALUES ('Sara Zahran', 987654377, 00006, 'University', '2020/2/15', 5);
INSERT INTO `Metro`.`Subscriber` (`Name`, `Ssn`, `Card_Serial`, `Card_Type`, `Card_exp_date`, `SO_Number`) VALUES ('Ismail Mousa', 987654378, 00007, 'Business', '2022/3/26', 3);
INSERT INTO `Metro`.`Subscriber` (`Name`, `Ssn`, `Card_Serial`, `Card_Type`, `Card_exp_date`, `SO_Number`) VALUES ('Neven Ashraf', 987654379, 00008, 'Tourism', '2020/1/2', 4);
INSERT INTO `Metro`.`Subscriber` (`Name`, `Ssn`, `Card_Serial`, `Card_Type`, `Card_exp_date`, `SO_Number`) VALUES ('Nagwa Abdallah', 987654380, 00009, 'University', '2020/2/14', 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Metro`.`Sell`
-- -----------------------------------------------------
START TRANSACTION;
USE `Metro`;
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123456, 1);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123457, 2);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123458, 3);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123459, 4);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123460, 5);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123461, 6);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123462, 7);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123463, 8);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123464, 9);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123465, 10);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123466, 11);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123467, 12);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123468, 13);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123469, 14);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123470, 15);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123471, 16);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123472, 17);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123473, 8);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123474, 19);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123475, 20);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123476, 21);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123477, 22);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123478, 23);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123479, 24);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123480, 1);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123481, 2);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123482, 3);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123483, 4);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123484, 5);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123485, 6);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123486, 7);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123487, 8);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123488, 9);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123489, 10);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123490, 11);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123491, 12);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123492, 13);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123493, 14);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123494, 15);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123495, 16);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123496, 17);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123497, 18);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123498, 19);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123499, 20);
INSERT INTO `Metro`.`Sell` (`Ticket_Serial`, `tc_number`) VALUES (123500, 21);

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
