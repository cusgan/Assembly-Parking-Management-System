# Parking Management System

An assembly language program for efficient campus parking slot management. Tracks slot availability, assigns slots to vehicles, and handles basic possible errors.

Final project for the Computer Organization and Architecture course.

## Features

### 1. Opening Screen
Contains the system name, programmer name, and date completed. User can register an account, log into their account, or close the program.

![Opening Screen](/documentation/opening.png "Opening Screen")

### 2. Register User 
The user can register an account with a username and password. Birth year is taken to validate that the user is of legal age to drive (at least 18 years old). If the user is below 18 years old, they cannot register an account.

![Register](/documentation/register.png "Register User")

### 3. Log In User
User can log into their account with their username and password. If the inputted username and password are invalid or do not match, they cannot log in.

![Log In](/documentation/login.png "Log In")

### 4. Main Menu
The user has the option to check the parking slots and their availability, log out of their account, or close the program. 

![Main Menu](/documentation/mainmenu.png "Main Menu")

### 5. Parking Slot CRUD

![Parking Slots](/documentation/slots.png "Parking Slot Availability")

The system has CRUD (create-read-update-delete) capabilities as follows:

#### Read/View Existing Records
User can view existing parking slots and their respective availability statuses.

#### Create New Record 
User can choose to park in any of the available parking slots. User cannot park in parking slots that are already occupied.

#### Update Existing Record
User can update the number of hours they will park in a parking slot. User cannot update parking slots that are not occupied.

#### Delete Existing Record
User can open or free up their parked slots. User cannot open parking slots that are already empty. They will then see their total parking fee for that parking slot based on the hours parked. The parking fee rate is P30 per hour. 
