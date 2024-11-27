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

    open1       DB '    Welcome to CIT-U Car Parking Slot Management System!                        $'
    open2       DB '    You must log in to use the service.                                         $'
    open3       DB '    Choose from the options below:                                              $'
    open4       DB '        1. Register Account                                                     $'
    open5       DB '        2. Log In Account                                                       $'
    open6       DB '        3. Close Program                                                        $'

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

    indent      DB '    $'
    returnmenu  DB '    Return to main menu? [Y/N]: $'
    empty       DB '                                                                                $'
    choice      DB '    Your choice: $'


.CODE
INCLUDE MYIO.MAC
; CLEAR THE SCREEN
CLEAR_SCREEN PROC FAR
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 0
    MOV DL, 0
    INT 10H

    MOV CX, 2000
    MOV AH, 09H 
    MOV AL, 20H
    MOV BH, 0
    MOV BL, 07H

    WRITE_SPACES:
    INT 10H         ; WRITE THE SPACE TO THE SCREEN
    LOOP WRITE_SPACES

RETF
CLEAR_SCREEN ENDP

; 1. OPENING SCREEN
OPENING_SCREEN PROC FAR
    MOV AH, 09H
    MOV BL, 4FH     ; BG FG
    MOV CX, 80      ; NO. OF CHARS TO CHANGE
    INT 10H

    MOV AH, 09H
    LEA DX, head    ; CITU PARKING SLOT MANAGEMENT SYSTEM
    INT 21H

    MOV AH, 09H
    MOV BL, 70H     ; BG FG
    MOV CX, 80      ; NO. OF CHARS TO CHANGE
    INT 10H

    MOV AH, 09H
    LEA DX, empty
    INT 21H

    MOV AH, 09H
    MOV BL, 70H     ; BG FG
    MOV CX, 80      ; NO. OF CHARS TO CHANGE
    INT 10H
    
    MOV AH, 09H
    LEA DX, open1
    INT 21H

    MOV AH, 09H
    MOV BL, 70H     ; BG FG
    MOV CX, 80      ; NO. OF CHARS TO CHANGE
    INT 10H
    
    MOV AH, 09H
    LEA DX, open2
    INT 21H

    MOV AH, 09H
    MOV BL, 70H         ; BG FG
    MOV CX, 80          ; NO. OF CHARS TO CHANGE
    INT 10H

    MOV AH, 09H
    LEA DX, empty
    INT 21H

    MOV AH, 09H
    MOV BL, 11110100B   ; 1 BLINK BIT + 3 BG BITS + 4 FG BITS
    MOV CX, 80          ; NO. OF CHARS TO CHANGE
    INT 10H
        
    MOV AH, 09H
    LEA DX, open3
    INT 21H

    MOV AH, 09H
    MOV BL, 70H         ; BG FG
    MOV CX, 80          ; NO. OF CHARS TO CHANGE
    INT 10H
    
    MOV AH, 09H
    LEA DX, open4
    INT 21H

    MOV AH, 09H
    MOV BL, 70H         ; BG FG
    MOV CX, 80          ; NO. OF CHARS TO CHANGE
    INT 10H
    
    MOV AH, 09H
    LEA DX, open5
    INT 21H

    MOV AH, 09H
    MOV BL, 70H        ; BG FG
    MOV CX, 80      ; NO. OF CHARS TO CHANGE
    INT 10H
    
    MOV AH, 09H
    LEA DX, open6
    INT 21H

    MOV AH, 09H
    MOV BL, 70H     ; BG FG
    MOV CX, 80      ; NO. OF CHARS TO CHANGE
    INT 10H

    MOV AH, 09H
    LEA DX, empty
    INT 21H

    MOV AH,02H
    MOV CL,0AH      ; NEWLINE
    MOV DL,CL
    INT 21H

    MOV AH, 09H
    MOV BL, 0EH     ; BG FG
    MOV CX, 17      ; NO. OF CHARS TO CHANGE
    INT 10H
    
    MOV AH, 09H
    LEA DX, choice
    INT 21H
    
    MOV AH,02H
    MOV CL,0AH      ; NEWLINE
    MOV DL,CL
    INT 21H

RETF 
OPENING_SCREEN ENDP
    
; 2. REGISTER NEW CUSTOMER
REGISTER PROC FAR

RETF
REGISTER ENDP

; 3. LOG IN CUSTOMER
LOG_IN PROC FAR

RETF
LOG_IN ENDP

; 4. MAIN MENU
MAIN_MENU PROC FAR
    MOV AH, 09H
    MOV BL, 4FH ; BG FG
    MOV CX, 80 ; NO. OF CHARS TO CHANGE
    INT 10H

    MOV AH, 09H
    LEA DX, head
    INT 21H

    MOV AH, 09H
    MOV BL, 4EH ; BG FG
    MOV CX, 80 ; NO. OF CHARS TO CHANGE
    INT 10H

    MOV AH, 09H
    LEA DX, submenu
    INT 21H
    
    MOV AH, 09H
    MOV BL, 70H ; BG FG
    MOV CX, 80 ; NO. OF CHARS TO CHANGE
    INT 10H

    MOV AH, 09H
    LEA DX, empty
    INT 21H

    MOV AH, 09H
    MOV BL, 11110100B ; 1 BLINK BIT + 3 BG BITS + 4 FG BITS
    MOV CX, 80 ; NO. OF CHARS TO CHANGE
    INT 10H
    
    MOV AH, 09H
    LEA DX, menu1
    INT 21H

    MOV AH, 09H
    MOV BL, 70H ; BG FG
    MOV CX, 80 ; NO. OF CHARS TO CHANGE
    INT 10H
        
    MOV AH, 09H
    LEA DX, menu2
    INT 21H

    MOV AH, 09H
    MOV BL, 70H ; BG FG
    MOV CX, 80 ; NO. OF CHARS TO CHANGE
    INT 10H
        
    MOV AH, 09H
    LEA DX, menu3
    INT 21H

    MOV AH, 09H
    MOV BL, 70H ; BG FG
    MOV CX, 80 ; NO. OF CHARS TO CHANGE
    INT 10H
    
    MOV AH, 09H
    LEA DX, menu4
    INT 21H

    MOV AH, 09H
    MOV BL, 70H ; BG FG
    MOV CX, 80 ; NO. OF CHARS TO CHANGE
    INT 10H
    
    MOV AH, 09H
    LEA DX, menu5
    INT 21H

    MOV AH, 09H
    MOV BL, 70H ; BG FG
    MOV CX, 80 ; NO. OF CHARS TO CHANGE
    INT 10H
    
    MOV AH, 09H
    LEA DX, menu6
    INT 21H

    MOV AH, 09H
    MOV BL, 70H ; BG FG
    MOV CX, 80 ; NO. OF CHARS TO CHANGE
    INT 10H

    MOV AH, 09H
    LEA DX, empty
    INT 21H

    MOV AH,02H
    MOV CL,0AH ; NEWLINE
    MOV DL,CL
    INT 21H

    MOV AH, 09H
    MOV BL, 0EH ; BG FG
    MOV CX, 17 ; NO. OF CHARS TO CHANGE
    INT 10H
    
    MOV AH, 09H
    LEA DX, choice
    INT 21H
    
    MOV AH,02H
    MOV CL,0AH ; NEWLINE
    MOV DL,CL
    INT 21H
RETF
MAIN_MENU ENDP

; 5. CREATE NEW RECORD

; 6. UPDATE EXISTING RECORD

; 7. DELETE EXISTING RECORD

; SEE PARKING SLOT AVAILABILITY
SLOT_YES PROC FAR
    Color 70H, 4
    space 4
    Color 2FH, 34
    Print num
    Print availyes
    RETF
SLOT_YES ENDP
SLOT_NO PROC FAR
    Color 70H, 4
    space 4
    Color 70H, 34
    Print num
    Print availno
    RETF
SLOT_NO ENDP

SLOT_AVAILABILITY PROC FAR
MOV AH, 09H

    Color 4FH, 80
    Print head
    Color 4EH, 80
    Print subavail
    Color 70H, 80
    Print empty

    Color 2FH, 80
    Print avail1
    Color 70H, 80
    print avail2
    Color 70H, 80 
    Print avail3

    Color 70H, 80 
    Print empty

    LEA SI, hoursdata
    MOV AX, 0
    SLOT_CHECK_LOOP:
        PUSH AX
        MOV BL, [SI]
        CMP BL, '$'
        JE SLOT_CHECK_END
        CMP BL, '0'
        JNE SLOT_CHECK_YES
        CALL SLOT_NO
        JMP SLOT_CHECK_ENDL
        SLOT_CHECK_YES:
        CALL SLOT_YES
        SLOT_CHECK_ENDL:
        INC SI
        POP AX
        INC AX
        TEST AL, 1
        JNZ SLOT_CHECK_LOOP
        Color 70H, 4
        Print indent
        JMP SLOT_CHECK_LOOP
    SLOT_CHECK_END:

    Color 70H, 80 
    Print EMPTY

    nwln

    Color 0EH, 25 
    Print RETURNMENU

    nwln

RETF
SLOT_AVAILABILITY ENDP


MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    CALL CLEAR_SCREEN
    CALL SLOT_AVAILABILITY

    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN