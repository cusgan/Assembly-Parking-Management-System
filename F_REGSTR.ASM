; 2. REGISTER NEW CUSTOMER
REGISTER_HEADING PROC FAR 
    CALL PRINT_CITU
    Color 4EH, 80
    Print subregis
    Color 4EH, 80
    space 80 
RETF
REGISTER_HEADING ENDP

REGISTER_PUT PROC FAR
    
RETF 
REGISTER_PUT ENDP

; error if age is less than 18 (2024 - input)


; error if birth year is not a valid year
REGISTER_INVALID_ERROR PROC FAR 
    nwln
    Color 11001110B, 11
    Print regiserror1    ; ERROR: 
    Color 4FH, 69
    Print regiserror3    
    nwln
    Color 10001110B, 14
    Print errcont
    Color 0FH, 8
    Print yn 
    space 58
RETF
REGISTER_INVALID_ERROR ENDP

REGISTER_YES_PROC PROC FAR
    nwln
    nwln

    Color 0FH, 80
    Print regis7        ; Successfully registered

    nwln
    Color 10001110B, 41
    Print regis8        ; continue to login

    ; continue to login screen once user presses ENTER
    MOV ah, 01h
    INT 21h
    CALL CLEAR_SCREEN

    ; old way:
    ; CALL LOG_IN

    ; new way:
    MOV next_screen, 3  ; 3 = LOGIN
RETF 
REGISTER_YES_PROC ENDP

REGISTER_AGE_ERROR PROC FAR
    nwln
    Color 11001110B, 11
    Print regiserror1    ; ERROR: 
    Color 4FH, 69
    Print regiserror2    ; Only legally driving adults (18+) can register.
    nwln
    Color 10001110B, 14
    Print errcont
    Color 0FH, 8
    Print yn 
    
    AGE_IF:
        MOV ah, 01h
        INT 21h
        CMP AL, 'y'
        JE AGE_YES
        CMP AL, 'Y'
        JE AGE_YES
        CMP AL, 'n'
        JE AGE_NO
        CMP AL, 'N'
        JE AGE_NO
        
        ;INVALID INPUT ! ! !
        ; use regiserror4 -> error: invalid input
        ; ????
        JMP AGE_IF
    AGE_YES:
        CALL CLEAR_SCREEN
        MOV next_screen, 2 ; register
        RETF
    AGE_NO:
        CALL CLEAR_SCREEN
        MOV next_screen, 1 ; opening screen
        RETF
    RETF

RETF
REGISTER_AGE_ERROR ENDP

REGISTER PROC FAR
    register_input_loop:
    CALL REGISTER_HEADING

    Color 70H, 80
    space 80 
    Color 70H, 80
    Print regis1        ; Please enter the necessary details to register an account.
    Color 70H, 80
    space 80 

    ; prompts user input
    space 80
    Color 0FH, 17
    Print regis2        ; Username: 
    InputStr buffer1
    nwln
    Color 0FH, 17
    Print regis3        ; Password:
    InputStr buffer2
    nwln
    Color 0FH, 19
    Print regis4        ; Birth Year:
    InputStr buffer3
    nwln
    ; prompt end

    ; if error, CALL REGISTER_ERROR
    lea si, buffer3
    call str2int
    cmp ax, 2006
    jle register_year_valid
        CALL REGISTER_AGE_ERROR
        CALL CLEAR_SCREEN
        jmp register_input_loop
    register_year_valid:
    ;CALL REGISTER_ERROR
    ; then print regiserror3 (prompts for enter)
    ; wait for user to press ENTER to prompt again

    nwln
    Color 70H, 80
    space 80

    Color 70H, 4
    space 4
    Color 4EH, 21
    Print regis5
    Color 70H, 55
    space 55

    ; displays user input

    Color 70H, 80 
    Print regis2
    StrictPrint buffer1, 10
    space 52

    Color 70H, 80 
    Print regis3
    StrictPrint buffer2, 10
    space 52

    Color 70H, 80 
    Print regis4
    StrictPrint buffer3, 10
    space 50

    ; display end

    Color 70H, 80
    space 80

    space 80
    Color 10001110B, 27
    Print regis6 ; Confirm Account Details?
    Color 0FH, 8
    Print yn

    ; Take input
    REGISTER_IF:
        MOV ah, 01h
        INT 21h
        CMP AL, 'y'
        JE REGISTER_YES
        CMP AL, 'Y'
        JE REGISTER_YES
        CMP AL, 'n'
        JE REGISTER_NO
        CMP AL, 'N'
        JE REGISTER_NO
        
        ;INVALID INPUT ! ! !
        ; use regiserror4 -> error: invalid input
        ; ????
        JMP REGISTER_IF
    REGISTER_YES:
        CALL REGISTER_YES_PROC
        RETF
    REGISTER_NO:
        nwln
        Color 10001110B, 14
        Print errcont ; continue?
        Color 0FH, 8
        Print yn 
        REG_NO_IF:
            MOV ah, 01h
            INT 21h
            CMP AL, 'y'
            JE REG_NO_YES
            CMP AL, 'Y'
            JE REG_NO_YES
            CMP AL, 'n'
            JE REG_NO_NO
            CMP AL, 'N'
            JE REG_NO_NO

            JMP REGISTER_IF
        REG_NO_NO:
            CALL CLEAR_SCREEN
            MOV next_screen, 1 ; opening screen
            RETF
        REG_NO_YES:
            CALL CLEAR_SCREEN
            MOV next_screen, 2 ; 'refresh'
            RETF
        RETF
    RETF
    

RETF
REGISTER ENDP