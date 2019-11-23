-- MySQL Script generated by MySQL Workbench
-- Mon Nov 18 13:35:39 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customer` (
  `customer_id` INT NOT NULL,
  `customer_name` NVARCHAR(100) NOT NULL,
  `customer_gender` INT NULL,
  `customer_bd` DATE NULL,
  `customer_email` NVARCHAR(100) NOT NULL,
  `customer_password` NVARCHAR(100) NOT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cinema`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cinema` (
  `cinema_id` INT NOT NULL,
  `cinema_number` INT NOT NULL,
  `cinema_seat_code` CHAR(5) NOT NULL,
  PRIMARY KEY (`cinema_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`movie` (
  `movie_id` INT NOT NULL,
  `movie_name` NVARCHAR(100) NOT NULL,
  `movie_length` INT NOT NULL,
  `movie_kind` NVARCHAR(45) NULL,
  `movie_trailer` LONGBLOB NULL,
  `movie_picture` LONGBLOB NULL,
  PRIMARY KEY (`movie_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`schedule` (
  `schedule_id` INT NOT NULL,
  `schedule_time_start` DATETIME NOT NULL,
  `schedule_time_end` DATETIME NOT NULL,
  `cinema_cinema_id` INT NOT NULL,
  `movie_movie_id` INT NOT NULL,
  PRIMARY KEY (`schedule_id`, `cinema_cinema_id`, `movie_movie_id`),
  INDEX `fk_schedule_cinema1_idx` (`cinema_cinema_id` ASC),
  INDEX `fk_schedule_movie1_idx` (`movie_movie_id` ASC),
  CONSTRAINT `fk_schedule_cinema1`
    FOREIGN KEY (`cinema_cinema_id`)
    REFERENCES `mydb`.`cinema` (`cinema_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_schedule_movie1`
    FOREIGN KEY (`movie_movie_id`)
    REFERENCES `mydb`.`movie` (`movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ticket` (
  `ticket_id` INT NOT NULL,
  `ticket_cost` FLOAT NOT NULL,
  `ticket_date` DATE NOT NULL,
  `customer_customer_id` INT NOT NULL,
  `schedule_schedule_id` INT NOT NULL,
  PRIMARY KEY (`ticket_id`, `customer_customer_id`, `schedule_schedule_id`),
  INDEX `fk_ticket_customer_idx` (`customer_customer_id` ASC),
  INDEX `fk_ticket_schedule1_idx` (`schedule_schedule_id` ASC),
  CONSTRAINT `fk_ticket_customer`
    FOREIGN KEY (`customer_customer_id`)
    REFERENCES `mydb`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_schedule1`
    FOREIGN KEY (`schedule_schedule_id`)
    REFERENCES `mydb`.`schedule` (`schedule_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;