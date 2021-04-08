SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema delta-digifier
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `delta-digifier` ;
-- -----------------------------------------------------
-- Schema delta-digifier
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `delta-digifier` DEFAULT CHARACTER SET utf8 ;
USE `delta-digifier` ;

-- -----------------------------------------------------
-- Table `delta-digifier`.`companies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `delta-digifier`.`companies` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delta-digifier`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `delta-digifier`.`clients` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `companies_id` INT NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_clients_companies1_idx` (`companies_id` ASC) VISIBLE,
  CONSTRAINT `fk_clients_companies1`
    FOREIGN KEY (`companies_id`)
    REFERENCES `delta-digifier`.`companies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delta-digifier`.`collaborators`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `delta-digifier`.`collaborators` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delta-digifier`.`services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `delta-digifier`.`services` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `price` FLOAT NOT NULL,
  `collaborators_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_services_collaborators1_idx` (`collaborators_id` ASC) VISIBLE,
  CONSTRAINT `fk_services_collaborators1`
    FOREIGN KEY (`collaborators_id`)
    REFERENCES `delta-digifier`.`collaborators` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delta-digifier`.`appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `delta-digifier`.`appointment` (
  `clients_id` INT NOT NULL,
  `services_id` INT NOT NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  `appointment` VARCHAR(10) NOT NULL,
  `done` TINYINT NOT NULL,
  `feedback` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_clients_has_services_services1_idx` (`services_id` ASC) VISIBLE,
  INDEX `fk_clients_has_services_clients_idx` (`clients_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_clients_has_services_clients`
    FOREIGN KEY (`clients_id`)
    REFERENCES `delta-digifier`.`clients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clients_has_services_services1`
    FOREIGN KEY (`services_id`)
    REFERENCES `delta-digifier`.`services` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- INSERTS
-- -----------------------------------------------------
INSERT INTO `delta-digifier`.`companies` (`name`, `address`) VALUES ('Google', 'New Avenue');
INSERT INTO `delta-digifier`.`clients` (`name`, `email`, `phone`, `description`, `companies_id`, `password`) VALUES ('Daniel', 'daniel.hdz1427@gmail.com', '8787000951', 'asd', '1', 'pass');
INSERT INTO `delta-digifier`.`collaborators` (`name`, `email`, `password`) VALUES ('Miguel', 'miguel@gmail.com', 'pass');
INSERT INTO `delta-digifier`.`services` (`name`, `description`, `price`, `collaborators_id`) VALUES ('Diseño web', 'Lorem ipsum', '1000', '1');


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
