-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customer` (
  `idcustomer` INT NOT NULL,
  `customer_names` VARCHAR(45) NULL,
  `contact_details` VARCHAR(45) NULL,
  PRIMARY KEY (`idcustomer`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `idBookings` INT NOT NULL,
  `booking_date` DATE NULL,
  `table_number` VARCHAR(45) NULL,
  `Customer_idcustomer` INT NOT NULL,
  PRIMARY KEY (`idBookings`),
  INDEX `fk_Bookings_Customer1_idx` (`Customer_idcustomer` ASC) VISIBLE,
  CONSTRAINT `fk_Bookings_Customer1`
    FOREIGN KEY (`Customer_idcustomer`)
    REFERENCES `LittleLemonDB`.`Customer` (`idcustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Staff` (
  `idStaff` INT NOT NULL,
  `role` VARCHAR(45) NULL,
  `salary` DECIMAL(10,2) NULL,
  PRIMARY KEY (`idStaff`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Order_Delivery_Status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Order_Delivery_Status` (
  `idOrder_Delivery_Status` INT NOT NULL,
  `delivery_status` VARCHAR(45) NULL,
  `delivery_date` DATE NULL,
  PRIMARY KEY (`idOrder_Delivery_Status`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menu` (
  `idMenu` INT NOT NULL,
  `Menu_name` VARCHAR(45) NULL,
  `cuisine` VARCHAR(45) NULL,
  PRIMARY KEY (`idMenu`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `idOrders` INT NOT NULL,
  `order_date` DATE NULL,
  `quantity` INT NULL,
  `total_cost` DECIMAL(10,2) NULL,
  `Customer_idcustomer` INT NOT NULL,
  `Staff_idStaff` INT NOT NULL,
  `Order_Delivery_Status_idOrder_Delivery_Status` INT NOT NULL,
  `Menu_idMenu` INT NOT NULL,
  PRIMARY KEY (`idOrders`),
  INDEX `fk_Orders_Customer1_idx` (`Customer_idcustomer` ASC) VISIBLE,
  INDEX `fk_Orders_Staff1_idx` (`Staff_idStaff` ASC) VISIBLE,
  INDEX `fk_Orders_Order_Delivery_Status1_idx` (`Order_Delivery_Status_idOrder_Delivery_Status` ASC) VISIBLE,
  INDEX `fk_Orders_Menu1_idx` (`Menu_idMenu` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Customer1`
    FOREIGN KEY (`Customer_idcustomer`)
    REFERENCES `LittleLemonDB`.`Customer` (`idcustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Staff1`
    FOREIGN KEY (`Staff_idStaff`)
    REFERENCES `LittleLemonDB`.`Staff` (`idStaff`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Order_Delivery_Status1`
    FOREIGN KEY (`Order_Delivery_Status_idOrder_Delivery_Status`)
    REFERENCES `LittleLemonDB`.`Order_Delivery_Status` (`idOrder_Delivery_Status`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Menu1`
    FOREIGN KEY (`Menu_idMenu`)
    REFERENCES `LittleLemonDB`.`Menu` (`idMenu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menu_Items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menu_Items` (
  `idMenu_Items` INT NOT NULL,
  `courses` VARCHAR(45) NULL,
  `desserts` VARCHAR(45) NULL,
  `drinks` VARCHAR(45) NULL,
  `starter` VARCHAR(45) NULL,
  `Menu_idMenu` INT NOT NULL,
  PRIMARY KEY (`idMenu_Items`),
  INDEX `fk_Menu_Items_Menu1_idx` (`Menu_idMenu` ASC) VISIBLE,
  CONSTRAINT `fk_Menu_Items_Menu1`
    FOREIGN KEY (`Menu_idMenu`)
    REFERENCES `LittleLemonDB`.`Menu` (`idMenu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE USER 'user1';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
