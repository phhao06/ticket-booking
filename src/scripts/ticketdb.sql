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
-- Table `mydb`.`cinema`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cinema` (
  `cinema_id` INT(11) NOT NULL,
  `cinema_number` INT(11) NOT NULL,
  PRIMARY KEY (`cinema_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `mydb`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customer` (
  `customer_id` INT(11) NOT NULL AUTO_INCREMENT,
  `customer_name` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  `customer_gender` INT(11) NULL DEFAULT NULL,
  `customer_bd` DATE NULL DEFAULT NULL,
  `customer_email` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  `customer_password` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `mydb`.`movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`movie` (
  `movie_id` INT(11) NOT NULL AUTO_INCREMENT,
  `movie_name` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  `movie_length` INT(11) NOT NULL,
  `movie_trailer` LONGBLOB NULL DEFAULT NULL,
  `movie_picture` LONGBLOB NULL DEFAULT NULL,
  PRIMARY KEY (`movie_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `mydb`.`schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`schedule` (
  `schedule_id` INT(11) NOT NULL AUTO_INCREMENT,
  `schedule_time_start` DATETIME NOT NULL,
  `cinema_cinema_id` INT(11) NOT NULL,
  `movie_movie_id` INT(11) NOT NULL,
  PRIMARY KEY (`schedule_id`),
  INDEX `fk_schedule_cinema1_idx` (`cinema_cinema_id` ASC),
  INDEX `fk_schedule_movie1_idx` (`movie_movie_id` ASC),
  CONSTRAINT `fk_schedule_cinema1`
    FOREIGN KEY (`cinema_cinema_id`)
    REFERENCES `mydb`.`cinema` (`cinema_id`),
  CONSTRAINT `fk_schedule_movie1`
    FOREIGN KEY (`movie_movie_id`)
    REFERENCES `mydb`.`movie` (`movie_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `mydb`.`seat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`seat` (
  `seat_id` INT NOT NULL AUTO_INCREMENT,
  `seat_vertical` INT NOT NULL,
  `seat_horizontal` INT NOT NULL,
  PRIMARY KEY (`seat_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `mydb`.`ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ticket` (
  `ticket_id` INT(11) NOT NULL AUTO_INCREMENT,
  `ticket_cost` FLOAT NOT NULL,
  `ticket_date` DATE NOT NULL,
  `customerr_customer_id` INT(11) NOT NULL,
  `schedule_schedule_id` INT(11) NOT NULL,
  PRIMARY KEY (`ticket_id`),
  INDEX `fk_ticket_customerr_idx` (`customerr_customer_id` ASC),
  INDEX `fk_ticket_schedule1_idx` (`schedule_schedule_id` ASC),
  CONSTRAINT `fk_ticket_customerr`
    FOREIGN KEY (`customerr_customer_id`)
    REFERENCES `mydb`.`customer` (`customer_id`),
  CONSTRAINT `fk_ticket_schedule1`
    FOREIGN KEY (`schedule_schedule_id`)
    REFERENCES `mydb`.`schedule` (`schedule_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `mydb`.`kind`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`kind` (
  `kind_id` INT NOT NULL AUTO_INCREMENT,
  `kind_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`kind_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`movie_has_kind`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`movie_has_kind` (
  `movie_movie_id` INT(11) NOT NULL,
  `kind_kind_id` INT NOT NULL,
  PRIMARY KEY (`movie_movie_id`, `kind_kind_id`),
  INDEX `fk_movie_has_kind_kind1_idx` (`kind_kind_id` ASC),
  INDEX `fk_movie_has_kind_movie1_idx` (`movie_movie_id` ASC),
  CONSTRAINT `fk_movie_has_kind_movie1`
    FOREIGN KEY (`movie_movie_id`)
    REFERENCES `mydb`.`movie` (`movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_has_kind_kind1`
    FOREIGN KEY (`kind_kind_id`)
    REFERENCES `mydb`.`kind` (`kind_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `mydb`.`cinema_has_seat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cinema_has_seat` (
  `cinema_cinema_id` INT(11) NOT NULL AUTO_INCREMENT,
  `seat_seat_id` INT NOT NULL,
  `seat_status` TINYINT NOT NULL,
  `ticket_ticket_id` INT(11) NOT NULL,
  PRIMARY KEY (`cinema_cinema_id`, `seat_seat_id`, `ticket_ticket_id`),
  INDEX `fk_cinema_has_seat_seat1_idx` (`seat_seat_id` ASC),
  INDEX `fk_cinema_has_seat_cinema1_idx` (`cinema_cinema_id` ASC),
  INDEX `fk_cinema_has_seat_ticket1_idx` (`ticket_ticket_id` ASC),
  CONSTRAINT `fk_cinema_has_seat_cinema1`
    FOREIGN KEY (`cinema_cinema_id`)
    REFERENCES `mydb`.`cinema` (`cinema_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cinema_has_seat_seat1`
    FOREIGN KEY (`seat_seat_id`)
    REFERENCES `mydb`.`seat` (`seat_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cinema_has_seat_ticket1`
    FOREIGN KEY (`ticket_ticket_id`)
    REFERENCES `mydb`.`ticket` (`ticket_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

