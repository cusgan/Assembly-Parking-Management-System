; System: CIT-U Car Parking Slot Management System
; Description: An assembly language program designed to manage parking slots within the CIT-U campus efficiently. 
; The system tracks available slots, assigns them to vehicles, and marks them as occupied upon entry. 
; It features functionalities for displaying current slot availability, releasing slots upon vehicle exit, 
; and handling basic error conditions like full capacity. 
; Programmer: FELISA MELANIE FAY G. BASCUG
; Date Finished: TBD, 2024

.MODEL SMALL
.STACK 100
.DATA
    head        DB '                    CIT-U CAR PARKING SLOT MANAGEMENT SYSTEM                    $' 
    head1       DB '                   Programmed by FELISA MELANIE FAY G. BASCUG                   $'
    head2       DB '                          Completed ???ember ??, 2024                           $'

    open1       DB '    Welcome to CIT-U Car Parking Slot Management System!                        $'
    open2       DB '    You must log in to use the service.                                         $'
;   open3       DB '    CHOOSE FROM THE OPTIONS BELOW:                                              $'
    open3       DB ' CHOOSE FROM THE OPTIONS BELOW: $' ; 30 characters
    open4       DB '        1. Register Account                                                     $'
    open5       DB '        2. Log In Account                                                       $'
    open6       DB '        3. Close Program                                                        $'

    subregis    DB '                              REGISTER NEW ACCOUNT                              $'
    regis1      DB '    Please enter the necessary details to register an account.                  $'
    regis2      DB '        Username: $'
    regis3      DB '        Password: $'
    regis4      DB '        Birth Year: $'
;   regis5      DB '    REGISTERING ACCOUNT                                                         $'
    regis5      DB ' REGISTERING ACCOUNT $' ; 21 characters
    regis6      DB '    Confirm Account Details$' ; 27 characters
    regis7      DB '    You have successfully registered!                                           $'
    regis8      DB '    Press ENTER to return to opening screen... $' ; 29
    
    regiserror1 DB '    ERROR: $' ; 11 characters
    regiserror2 DB            'Only legally driving adults (18+) can register.                      $' ; 69  characters
    loginerror  DB            'Password does not match!                                             $'
    regiserror3 DB '    Continue?$' ; 14

    sublogin    DB '                                     LOG IN                                     $'
    login1      DB '    Please enter the necessary details to log into your account.                $'
    login2      DB '    Successfully logged in!                                                     $'
    login3      DB '    Press ENTER to continue to main menu... $'

    submenu     DB '                                   MAIN MENU                                    $'
    menu1       DB '    Hello, Firstname Lastname!                                                  $'
    menu2       DB '    What would you like to do today?                                            $'
    menu3       DB '        1. See Vacant Parking Slots                                             $'
    menu4       DB '        2. Park My Car                                                          $'
    menu5       DB '        3. Open a Parking Slot                                                  $'
    menu6       DB '        4. Close Program                                                        $'

    subavail    DB '                           PARKING SLOT AVAILABILITY                            $'
    avail1      DB '    No. of Available Parking Slots:     08                                      $'
    avail2      DB '    No. of Unavailable Parking Slots:   08                                      $'
    avail3      DB '    Total No. of Parking Slots:         16                                      $'
    availyes    DB 'Available                  $'
    availno     DB 'Not Available              $'
    hoursdata   DB '10010000010000001000$'
    hours       DB ' hours of parking.        $'
    num         DB '[ 01 ] $'

    yn          DB ' [Y/N]: $' ; 8 
    indent      DB '    $'
    returnmenu  DB '    Return to main menu? [Y/N]: $'
    empty       DB '                                                                                $'
    choice      DB '    Your choice: $' ; 18 characters
	inputChoice DB ?    ; variable to store the input character


.CODE
INCLUDE MYIO.MAC

; PRINT CIT-U CAR PARKING SLOT MANAGEMENT SYSTEM
PRINT_CITU PROC FAR
    Color 4FH, 80
    space 80

    Color 4FH, 80
    Print head
RETF
PRINT_CITU ENDP

INCLUDE F_REGSTR.ASM        ; 2. REGISTER NEW CUSTOMER
INCLUDE F_LOGIN.ASM         ; 3. LOG IN CUSTOMER
INCLUDE F_MENU.ASM          ; 4. MAIN MENU
; 5. CREATE NEW RECORD

; 6. UPDATE EXISTING RECORD

; 7. DELETE EXISTING RECORD

INCLUDE F_SLOTS.ASM         ; SEE PARKING SLOT AVAILABILITY
INCLUDE F_OPENING.ASM       ; 1. OPENING SCREEN

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    CALL CLEAR_SCREEN
    CALL OPENING_SCREEN

    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN