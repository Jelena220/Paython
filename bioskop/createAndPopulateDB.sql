-- COPY THIS TO MYSQL CONSOLE TO CREATE DB & TABLES

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
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Blagajnik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Blagajnik` (
  `idBlagajnik` INT NOT NULL AUTO_INCREMENT,
  `korisnickoIme` VARCHAR(45) NOT NULL,
  `sifra` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idBlagajnik`),
  UNIQUE INDEX `korisnickoIme_UNIQUE` (`korisnickoIme` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Film`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Film` (
  `idFilm` INT NOT NULL AUTO_INCREMENT,
  `nazivFilma` VARCHAR(45) NOT NULL,
  `reziserFilma` VARCHAR(45) NOT NULL,
  `ocena` DOUBLE NULL,
  `posecenost` INT NULL,
  PRIMARY KEY (`idFilm`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Glumac`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Glumac` (
  `idGlumac` INT NOT NULL AUTO_INCREMENT,
  `imeGlumca` VARCHAR(45) NOT NULL,
  `prezimeGlumca` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idGlumac`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Sala`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Sala` (
  `idSala` INT NOT NULL AUTO_INCREMENT,
  `brojSale` VARCHAR(45) NOT NULL,
  `brojRedova` INT NOT NULL,
  `brojKolona` INT NOT NULL,
  PRIMARY KEY (`idSala`),
  UNIQUE INDEX `brojSale_UNIQUE` (`brojSale` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Projekcija`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Projekcija` (
  `Film_idFilm` INT NOT NULL,
  `Sala_idSala` INT NOT NULL,
  `datumProjekcije` DATETIME NOT NULL,
  `cenaKarte` INT NOT NULL,
  PRIMARY KEY (`Film_idFilm`, `Sala_idSala`),
  INDEX `fk_Film_has_Sala_Sala1_idx` (`Sala_idSala` ASC) VISIBLE,
  INDEX `fk_Film_has_Sala_Film_idx` (`Film_idFilm` ASC) VISIBLE,
  CONSTRAINT `fk_Film_has_Sala_Film`
    FOREIGN KEY (`Film_idFilm`)
    REFERENCES `mydb`.`Film` (`idFilm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Film_has_Sala_Sala1`
    FOREIGN KEY (`Sala_idSala`)
    REFERENCES `mydb`.`Sala` (`idSala`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Karta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Karta` (
  `idMesto` INT NOT NULL AUTO_INCREMENT,
  `pozicijaI` INT NOT NULL,
  `pozicijaJ` INT NOT NULL,
  `Projekcija_Film_idFilm` INT NOT NULL,
  `Projekcija_Sala_idSala` INT NOT NULL,
  `Blagajnik_idBlagajnik` INT NOT NULL,
  PRIMARY KEY (`idMesto`),
  INDEX `fk_Mesto_Projekcija1_idx` (`Projekcija_Film_idFilm` ASC, `Projekcija_Sala_idSala` ASC) VISIBLE,
  INDEX `fk_Karta_Blagajnik1_idx` (`Blagajnik_idBlagajnik` ASC) VISIBLE,
  CONSTRAINT `fk_Mesto_Projekcija1`
    FOREIGN KEY (`Projekcija_Film_idFilm` , `Projekcija_Sala_idSala`)
    REFERENCES `mydb`.`Projekcija` (`Film_idFilm` , `Sala_idSala`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Karta_Blagajnik1`
    FOREIGN KEY (`Blagajnik_idBlagajnik`)
    REFERENCES `mydb`.`Blagajnik` (`idBlagajnik`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Uloga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Uloga` (
  `Film_idFilm` INT NOT NULL,
  `Glumac_idGlumac` INT NOT NULL,
  `uloga` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Film_idFilm`, `Glumac_idGlumac`),
  INDEX `fk_Film_has_Glumac_Glumac1_idx` (`Glumac_idGlumac` ASC) VISIBLE,
  INDEX `fk_Film_has_Glumac_Film1_idx` (`Film_idFilm` ASC) VISIBLE,
  CONSTRAINT `fk_Film_has_Glumac_Film1`
    FOREIGN KEY (`Film_idFilm`)
    REFERENCES `mydb`.`Film` (`idFilm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Film_has_Glumac_Glumac1`
    FOREIGN KEY (`Glumac_idGlumac`)
    REFERENCES `mydb`.`Glumac` (`idGlumac`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;










-- -----------------------------------------------------
-- Data for table `mydb`.`Film`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Film` (`idFilm`, `nazivFilma`, `reziserFilma`, `ocena`, `posecenost`) VALUES (1, ' Escape from Shoshenko', 'Frank Darabont', 9.3, 21820);
INSERT INTO `mydb`.`Film` (`idFilm`, `nazivFilma`, `reziserFilma`, `ocena`, `posecenost`) VALUES (2, ' The Godfather', 'Francis Ford Coppola', 9.2, 20613);
INSERT INTO `mydb`.`Film` (`idFilm`, `nazivFilma`, `reziserFilma`, `ocena`, `posecenost`) VALUES (3, ' The Dark Knight', 'Christopher Nolan', 9.0, 22578);
INSERT INTO `mydb`.`Film` (`idFilm`, `nazivFilma`, `reziserFilma`, `ocena`, `posecenost`) VALUES (4, ' Schindlers List', 'Steven Spielberg', 8.9, 14821);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Glumac`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Glumac` (`idGlumac`, `imeGlumca`, `prezimeGlumca`) VALUES (1, 'Tim ', 'Robbins');
INSERT INTO `mydb`.`Glumac` (`idGlumac`, `imeGlumca`, `prezimeGlumca`) VALUES (2, 'Morgan ', 'Freeman');
INSERT INTO `mydb`.`Glumac` (`idGlumac`, `imeGlumca`, `prezimeGlumca`) VALUES (3, 'Marlon ', 'Brando');
INSERT INTO `mydb`.`Glumac` (`idGlumac`, `imeGlumca`, `prezimeGlumca`) VALUES (4, 'Al ', 'Pacino');
INSERT INTO `mydb`.`Glumac` (`idGlumac`, `imeGlumca`, `prezimeGlumca`) VALUES (5, 'Christian ', 'Bale');
INSERT INTO `mydb`.`Glumac` (`idGlumac`, `imeGlumca`, `prezimeGlumca`) VALUES (6, 'Heath ', 'Ledger');
INSERT INTO `mydb`.`Glumac` (`idGlumac`, `imeGlumca`, `prezimeGlumca`) VALUES (7, 'Liam ', 'Neeson');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Sala`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Sala` (`idSala`, `brojSale`, `brojRedova`, `brojKolona`) VALUES (1, 'Sala 1', 9, 10);
INSERT INTO `mydb`.`Sala` (`idSala`, `brojSale`, `brojRedova`, `brojKolona`) VALUES (2, 'Sala 2', 5, 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Projekcija`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Projekcija` (`Film_idFilm`, `Sala_idSala`, `datumProjekcije`, `cenaKarte`) VALUES (1, 1, '2020-08-18 20:00:00', 300);
INSERT INTO `mydb`.`Projekcija` (`Film_idFilm`, `Sala_idSala`, `datumProjekcije`, `cenaKarte`) VALUES (1, 2, '2020-08-18 20:30:00', 300);
INSERT INTO `mydb`.`Projekcija` (`Film_idFilm`, `Sala_idSala`, `datumProjekcije`, `cenaKarte`) VALUES (2, 1, '2020-08-18 21:30:00', 400);
INSERT INTO `mydb`.`Projekcija` (`Film_idFilm`, `Sala_idSala`, `datumProjekcije`, `cenaKarte`) VALUES (3, 2, '2020-08-18 22:30:00', 300);
INSERT INTO `mydb`.`Projekcija` (`Film_idFilm`, `Sala_idSala`, `datumProjekcije`, `cenaKarte`) VALUES (3, 2, '2020-08-18 23:30:00', 300);
INSERT INTO `mydb`.`Projekcija` (`Film_idFilm`, `Sala_idSala`, `datumProjekcije`, `cenaKarte`) VALUES (4, 1, '2020-08-18 16:30:00', 200);

COMMIT;



-- -----------------------------------------------------
-- Data for table `mydb`.`Blagajnik`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Blagajnik` (`idBlagajnik`, `korisnickoIme`, `sifra`) VALUES (1, 'Jelena', '123');
INSERT INTO `mydb`.`Blagajnik` (`idBlagajnik`, `korisnickoIme`, `sifra`) VALUES (2, 'Jovana', '123');

COMMIT;



-- -----------------------------------------------------
-- Data for table `mydb`.`Karta`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Karta` (`idMesto`, `pozicijaI`, `pozicijaJ`, `Projekcija_Film_idFilm`, `Projekcija_Sala_idSala`, `Blagajnik_idBlagajnik`) VALUES (1, 5, 5, 3, 1, 1);
INSERT INTO `mydb`.`Karta` (`idMesto`, `pozicijaI`, `pozicijaJ`, `Projekcija_Film_idFilm`, `Projekcija_Sala_idSala`, `Blagajnik_idBlagajnik`) VALUES (2, 5, 6, 3, 1, 1);
INSERT INTO `mydb`.`Karta` (`idMesto`, `pozicijaI`, `pozicijaJ`, `Projekcija_Film_idFilm`, `Projekcija_Sala_idSala`, `Blagajnik_idBlagajnik`) VALUES (3, 2, 5, 2, 2, 1);
INSERT INTO `mydb`.`Karta` (`idMesto`, `pozicijaI`, `pozicijaJ`, `Projekcija_Film_idFilm`, `Projekcija_Sala_idSala`, `Blagajnik_idBlagajnik`) VALUES (4, 2, 6, 1, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Uloga`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Uloga` (`Film_idFilm`, `Glumac_idGlumac`, `uloga`) VALUES (1, 1, 'Andy Dufresne');
INSERT INTO `mydb`.`Uloga` (`Film_idFilm`, `Glumac_idGlumac`, `uloga`) VALUES (1, 2, 'Ellis Boyd \'Red\' Redding');
INSERT INTO `mydb`.`Uloga` (`Film_idFilm`, `Glumac_idGlumac`, `uloga`) VALUES (2, 3, 'Don Vito Corleone');
INSERT INTO `mydb`.`Uloga` (`Film_idFilm`, `Glumac_idGlumac`, `uloga`) VALUES (2, 4, 'Michael Corleone');
INSERT INTO `mydb`.`Uloga` (`Film_idFilm`, `Glumac_idGlumac`, `uloga`) VALUES (3, 5, 'Bruce Wayne');
INSERT INTO `mydb`.`Uloga` (`Film_idFilm`, `Glumac_idGlumac`, `uloga`) VALUES (3, 6, 'Joker');
INSERT INTO `mydb`.`Uloga` (`Film_idFilm`, `Glumac_idGlumac`, `uloga`) VALUES (4, 7, 'Oskar Schindler');

COMMIT;