; System: CIT-U Car Parking Slot Management System
; Description: 
; An assembly language program for efficient campus parking slot management. 
; Tracks slot availability, assigns slots to vehicles, and handles basic possible errors.
; Features:
;    Register account
;    Log in and manage parking activities
;    Exit program anytime
;    View parking slot status and availability
;    Assign and release parking slots
;    Calculate total parking fees 
; Programmer: FELISA MELANIE FAY G. BASCUG
; Date Finished: December 4, 2024

.MODEL LARGE
.STACK 200
.DATA
    MAX_STR_LEN equ 11
    head        DB '                    CIT-U CAR PARKING SLOT MANAGEMENT SYSTEM                    $' 
    head1       DB '                   Programmed by FELISA MELANIE FAY G. BASCUG                   $'
    head2       DB '                           Completed December 4, 2024                           $'

    next_screen DW 1

    open1       DB '    Welcome to CIT-U Car Parking Slot Management System!                        $'
    open2       DB '    You must log in to use the service.                                         $'
   ;open3       DB '    CHOOSE FROM THE OPTIONS BELOW:                                              $'
    open3       DB ' CHOOSE FROM THE OPTIONS BELOW: $' ; 30 characters
    open4       DB '        1. Register Account                                                     $'
    open5       DB '        2. Log In Account                                                       $'
    open6       DB '        3. Close Program                                                        $'

    exit1       DB '    Thank you for using CIT-U Car Parking Slot Management System!               $'
    exit2       DB '    We hope to see you again soon. $' ;35

    subregis    DB '                              REGISTER NEW ACCOUNT                              $'
    regis1      DB '    Please enter the necessary details to register an account.                  $'
    regis2      DB '        Username: $'
    regis3      DB '        Password: $'
    regis4      DB '        Birth Year: $'
   ;regis5      DB '    REGISTERING ACCOUNT                                                         $'
    regis5      DB ' REGISTERING ACCOUNT $' ; 21 characters
    regis6      DB '    Confirm Account Details$' ; 27 characters
    regis7      DB '    You have successfully registered!                                           $'
    regis8      DB '    Press ENTER to continue to log in... $' ; 41

    ; ACCOUNTS
    uname1      DB MAX_STR_LEN dup('$')
    uname2      DB MAX_STR_LEN dup('$')
    uname3      DB MAX_STR_LEN dup('$')
    uname4      DB MAX_STR_LEN dup('$')
    uname5      DB MAX_STR_LEN dup('$')

    pword1      DB MAX_STR_LEN dup('$')
    pword2      DB MAX_STR_LEN dup('$')
    pword3      DB MAX_STR_LEN dup('$')
    pword4      DB MAX_STR_LEN dup('$')
    pword5      DB MAX_STR_LEN dup('$')

    
    regiserror1 DB '    ERROR: $' ; 11 characters
    regiserror2 DB            'Only legally driving adults (18+) can register.                      $' ; 69  characters
    regiserror3 DB            'Invalid birth year!                                                  $'
    regiserror4 DB            'Invalid input!                                                       $'
    loginerror  DB            'Invalid username or password!                                        $'

    sublogin    DB '                                     LOG IN                                     $'
    login1      DB '    Please enter the necessary details to log into your account.                $'
    login2      DB '    Successfully logged in!                                                     $'
    login3      DB '    Press ENTER to continue to main menu... $' ; 44

    submenu     DB '                                   MAIN MENU                                    $'
    menu1       DB '    Hello, jdelacruz!                                                           $'
    menu2       DB '    What would you like to do today?                                            $'
    menu3       DB '        [1] View Parking Slots                                                  $'
    menu4       DB '        [2] Log Out                                                             $'
    menu5       DB '        [3] Close Program                                                       $'

    subavail    DB '                           PARKING SLOT AVAILABILITY                            $'
    avail0      DB ' PARKING FEE: P30 PER HOUR $' ; 27 
    avail1      DB '    No. of Available Parking Slots:     $' ; 38 spaces after number
    avail2      DB '    No. of Unavailable Parking Slots:   $'
    avail3      DB '    Total No. of Parking Slots:         10                                      $'
    availyes    DB 'Available                  $'
    availno     DB 'Occupied | Hours: $'        
    availvar    DW 10
    unavailvar  DW 0
    hoursorder  DB 0,5,1,6,2,7,3,8,4,9,'$'
    hoursdata   DB 0,69,0,0,0,0,0,0,0,0,'$'
    hours       DB ' hours of parking.        $'
    num         DB '[ 01 ] $'
    slotmenu1   DB '        [1] Park Car                                                            $'
    slotmenu2   DB '        [2] Open Parking Slot                                                   $'
    slotmenu3   DB '        [3] Change Slot Hours                                                   $'
    slotmenu4   DB '        [4] Return to Main Menu                                                 $'
    slotmenu5   DB '        [5] Close Program                                                       $'
    park1       DB '    Enter slot number to park: $' ; 31
    park2       DB '    Enter number of hours to park: $' ; 35
    park3       DB '    Successfully parked car! $' ; 29, enter to refresh screen after
    parkerr     DB            'Slot is already occupied!                                            $'
    opslot1     DB '    Enter slot number to open: $' ; 31
    opslot2     DB '    Successfully opened slot!                                                   $' 
    opslot3     DB '    Slot Parking Fee: P$' ; 23
    opsloterr   DB            'Slot is already empty!                                               $'
    chngeslt1   DB '    Enter slot number to change hours: $' ; 39
    chngeslt2   DB '    Enter new number of hours to park: $' ; 39
    chngeslt3   DB '    Successfully changed slot hours!                                            $' ; 37, enter to refresh screen after
    chngeslterr DB            'Cannot change slot hours!                                            $'

    continue    DB '    Press ENTER to continue... $' ; 31
    option      DB '    Options:                                                                    $'
    errcont     DB '    Continue?$' ; 14
    yn          DB ' [Y/N]: $' ; 8 
    indent      DB '    $'
    returnmenu  DB '    Return to main menu? [Y/N]: $'
    empty       DB '                                                                                $'
    choice      DB '    Your choice: $' ; 18 characters
	inputChoice DB ?    ; variable to store the input character
    buffer0 DB MAX_STR_LEN dup ('$')
    buffer1 DB MAX_STR_LEN dup ('$')
    buffer2 DB MAX_STR_LEN dup ('$')
    buffer3 DB MAX_STR_LEN dup ('$')
    bufferN DW 0
    bufferN2 DW 0
    
    inbf db  MAX_STR_LEN,?,MAX_STR_LEN dup('$')
    total       DW 0

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

INCLUDE F_EXIT.ASM
INCLUDE F_LOGIN.ASM         ; LOG_IN
INCLUDE F_REGSTR.ASM        ; REGISTER
INCLUDE F_SLOTS.ASM         ; SLOT_AVAILABILITY
INCLUDE F_OPENING.ASM       ; OPENING_SCREEN
INCLUDE F_MENU.ASM          ; MAIN_MENU

ROUTER PROC FAR

    ; MOV ah, 01h
    ;     INT 21h

    ; 0 = EXIT
    ; 1 = OPENING 
    ; 2 = REGISTER
    ; 3 = LOGIN
    ; 4 = MENU
    ; 5 = SLOTS
    MOV AX, next_screen
    CMP AX, 0
    JE route_exit
    CMP AX, 1
    JE route_opening
    CMP AX, 2
    JE route_register
    CMP AX, 3
    JE route_login
    CMP AX, 4
    JE route_menu
    CMP AX, 5
    JE route_slots
    MOV AH, 4CH
    INT 21H
    RETF
    route_opening:
        CALL OPENING_SCREEN
        RETF
    route_register:
        CALL REGISTER
        RETF
    route_login:
        CALL LOG_IN
        RETF
    route_menu:
        CALL MAIN_MENU
        RETF
    route_slots:
        CALL SLOT_AVAILABILITY
        RETF
    route_exit:
        CALL EXIT
        RETF
ROUTER ENDP

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    CALL CLEAR_SCREEN
    MOV next_screen, 1
    super_main_loop:
        CALL ROUTER
        MOV AX, next_screen
        CMP AX, 99
        JNE super_main_loop
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN