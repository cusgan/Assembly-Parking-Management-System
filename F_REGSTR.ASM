; 2. REGISTER NEW CUSTOMER
REGISTER_HEADING PROC FAR 
    CALL PRINT_CITU
    Color 4EH, 80
    Print subregis
    Color 4EH, 80
    space 80 
RETF
REGISTER_HEADING ENDP

REGISTER_ERROR PROC FAR
    nwln
    Color 11001110B, 11
    Print regiserror1    ; ERROR: 
    Color 4FH, 69
    Print regiserror2    ; Only legally driving adults (18+) can register.
    Color 10001110B, 14
    Print regiserror3
    Color 0FH, 8
    Print yn 
    space 58
RETF
REGISTER_ERROR ENDP

REGISTER PROC FAR
    CALL REGISTER_HEADING

    Color 70H, 80
    space 80 
    Color 70H, 80
    Print regis1        ; Please enter the necessary details to register an account.
    Color 70H, 80
    space 80 

    space 80
    Color 0FH, 17
    Print regis2        ; Username: 
    nwln
    Color 0FH, 17
    Print regis3        ; Password:
    nwln
    Color 0FH, 19
    Print regis4        ; Birth Year:
    nwln

    ; if error, CALL REGISTER_ERROR
    CALL REGISTER_ERROR
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

    Color 70H, 80 
    Print regis2
    space 62
    Color 70H, 80 
    Print regis3
    space 62
    Color 70H, 80 
    Print regis4
    space 60

    Color 70H, 80
    space 80

    space 80
    Color 10001110B, 27
    Print regis6
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
        ; ????
        JMP REGISTER_IF

    REGISTER_NO:
        ; GO BACK TO INPUT ???
    REGISTER_YES:
        nwln
        nwln

        Color 70H, 80
        space 80
        Color 70H, 80
        Print regis7        ; Successfully registered
        Color 70H, 80
        space 80

        nwln
        Color 10001110B, 80
        Print regis8        ; Return?

        ; return to opening screen once user presses ENTER
        MOV ah, 01h
        INT 21h
        CALL CLEAR_SCREEN

RETF
REGISTER ENDP