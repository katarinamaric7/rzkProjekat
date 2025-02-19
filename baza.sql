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
-- Table `mydb`.`Role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Role` (
  `idRole` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idRole`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(100) NOT NULL,
  `lastName` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `dateOfBirth` DATE NULL,
  `Role_idRole` INT NOT NULL,
  PRIMARY KEY (`idUser`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_User_Role_idx` (`Role_idRole` ASC) VISIBLE,
  CONSTRAINT `fk_User_Role`
    FOREIGN KEY (`Role_idRole`)
    REFERENCES `mydb`.`Role` (`idRole`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Author` (
  `idAuthor` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(100) NOT NULL,
  `lastName` VARCHAR(100) NOT NULL,
  `dateOfBirth` DATE NULL,
  PRIMARY KEY (`idAuthor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Category` (
  `idCategory` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCategory`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Book` (
  `idBook` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NOT NULL,
  `publishYear` INT NULL,
  `availableCopies` INT NOT NULL,
  `totalCopies` INT NOT NULL,
  `pageNumber` INT NULL,
  `language` VARCHAR(45) NULL,
  `Author_idAuthor` INT NOT NULL,
  `Category_idCategory` INT NOT NULL,
  PRIMARY KEY (`idBook`),
  INDEX `fk_Book_Author1_idx` (`Author_idAuthor` ASC) VISIBLE,
  INDEX `fk_Book_Category1_idx` (`Category_idCategory` ASC) VISIBLE,
  CONSTRAINT `fk_Book_Author1`
    FOREIGN KEY (`Author_idAuthor`)
    REFERENCES `mydb`.`Author` (`idAuthor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Book_Category1`
    FOREIGN KEY (`Category_idCategory`)
    REFERENCES `mydb`.`Category` (`idCategory`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Loan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Loan` (
  `idLoan` INT NOT NULL AUTO_INCREMENT,
  `loanDate` DATE NOT NULL,
  `returnDate` DATE NOT NULL,
  `actualReturnDate` DATE NULL,
  `status` VARCHAR(45) NOT NULL DEFAULT 'active',
  `User_idUser` INT NOT NULL,
  `Book_idBook` INT NOT NULL,
  PRIMARY KEY (`idLoan`),
  INDEX `fk_Loan_User1_idx` (`User_idUser` ASC) VISIBLE,
  INDEX `fk_Loan_Book1_idx` (`Book_idBook` ASC) VISIBLE,
  CONSTRAINT `fk_Loan_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `mydb`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Loan_Book1`
    FOREIGN KEY (`Book_idBook`)
    REFERENCES `mydb`.`Book` (`idBook`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`BookReservation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`BookReservation` (
  `idBookReservation` INT NOT NULL AUTO_INCREMENT,
  `reservationDate` DATE NOT NULL,
  `expirationDate` DATE NOT NULL,
  `pickupDate` DATE NULL,
  `status` VARCHAR(45) NOT NULL DEFAULT 'active',
  `User_idUser` INT NOT NULL,
  `Book_idBook` INT NOT NULL,
  PRIMARY KEY (`idBookReservation`),
  INDEX `fk_BookReservation_User1_idx` (`User_idUser` ASC) VISIBLE,
  INDEX `fk_BookReservation_Book1_idx` (`Book_idBook` ASC) VISIBLE,
  CONSTRAINT `fk_BookReservation_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `mydb`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_BookReservation_Book1`
    FOREIGN KEY (`Book_idBook`)
    REFERENCES `mydb`.`Book` (`idBook`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`BookReview`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`BookReview` (
  `idBookReview` INT NOT NULL AUTO_INCREMENT,
  `rating` INT NOT NULL,
  `createdAt` DATE NOT NULL,
  `comment` VARCHAR(250) NULL,
  `User_idUser` INT NOT NULL,
  `Book_idBook` INT NOT NULL,
  PRIMARY KEY (`idBookReview`),
  INDEX `fk_BookReview_User1_idx` (`User_idUser` ASC) VISIBLE,
  INDEX `fk_BookReview_Book1_idx` (`Book_idBook` ASC) VISIBLE,
  CONSTRAINT `fk_BookReview_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `mydb`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_BookReview_Book1`
    FOREIGN KEY (`Book_idBook`)
    REFERENCES `mydb`.`Book` (`idBook`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
