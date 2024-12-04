; 3. LOG IN CUSTOMER
LOGIN_ERROR PROC FAR
    nwln
    Color 11001110B, 11
    Print regiserror1    ; ERROR: 
    Color 4FH, 69
    Print loginerror     ; Password does not match
    nwln
    Color 10001110B, 14
    Print errcont    ; Continue?
    Color 0FH, 8
    Print yn 
    space 58
RETF
LOGIN_ERROR ENDP

LOG_IN PROC FAR
    CALL PRINT_CITU
    Color 4EH, 80
    Print sublogin
    Color 4EH, 80
    space 80 

    Color 70H, 80
    space 80 
    Color 70H, 80
    Print login1         ; Enter details to log in
    Color 70H, 80
    space 80 

    space 80
    Color 0FH, 17
    Print regis2        ; Username: 
    nwln
    Color 0FH, 17
    Print regis3        ; Password:
    nwln 

    ; if password does not match
    ;CALL LOGIN_ERROR
    ; "refresh" login page

    nwln 
    Color 0FH, 80
    Print login2        ; Successfully logged in

    nwln 
    Color 10001110B, 44
    Print login3        ; Continue on user input ENTER
    MOV ah, 01h
    INT 21h
    CALL CLEAR_SCREEN
    MOV next_screen, 4 ; main menu
RETF
LOG_IN ENDP