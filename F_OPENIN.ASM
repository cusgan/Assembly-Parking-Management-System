; 1. OPENING SCREEN
OPENING_SCREEN PROC FAR
    CALL CLEAR_SCREEN
    ; RED BACKGROUND HEADER
        CALL PRINT_CITU

        Color 4EH, 80
        Print head1

        Color 4EH, 80
        Print head2

        Color 4FH, 80
        space 80

    Color 70H, 80
    space 80

    Color 70H, 80
    Print open1     ; Welcome to CIT-U Car Parking Slot Management System!
    Color 70H, 80
    Print open2     ; You must log in to use the service.

    Color 70H, 80
    space 80

    Color 74H, 4
    Print indent
    Color 4FH, 32
    Print open3     ; CHOOSE FROM THE OPTIONS BELOW:
    Color 70H, 44
    space 44
    
    Color 70H, 80
    Print open4     ; 1. Register Account
    Color 70H, 80
    Print open5     ; 2. Log In Account
    Color 70H, 80
    Print open6     ; 3. Close Program

    Color 70H, 80
    space 80
    nwln

    Color 10001110B, 17
    Print choice

    MOV AH, 01H
    INT 21H
    MOV inputChoice, AL
    CMP AL, '1'
    JE OPENING_CHOICE_1
    CMP AL, '2'
    JE OPENING_CHOICE_2
    CMP AL, '3'
    JE OPENING_CHOICE_3
    JMP OPENING_SCREEN_END
    OPENING_CHOICE_1:
        CALL CLEAR_SCREEN
        MOV next_screen, 2 ; register
        JMP OPENING_SCREEN_END
    OPENING_CHOICE_2:
        CALL CLEAR_SCREEN
        MOV next_screen, 3 ; log in
        JMP OPENING_SCREEN_END
    OPENING_CHOICE_3:
        CALL CLEAR_SCREEN
        MOV next_screen, 0 ; exit
        JMP OPENING_SCREEN_END
    OPENING_SCREEN_END:
RETF 
OPENING_SCREEN ENDP