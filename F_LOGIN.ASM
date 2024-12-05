; 3. LOG IN CUSTOMER
CheckMatch MACRO src, dst, len
    LEA SI, src
    LEA DI, dst 
    MOV CX, len
    CheckMatchLoop:
        mov al, [si]
        mov bl, [di]
        cmp al, bl
        jne CheckMatchWrong
        inc si
        inc di
        LOOP CheckMatchLoop  
        JMP CheckMatchRight
    CheckMatchWrong:
        CALL LOGIN_ERROR
        CALL CLEAR_SCREEN
        RETF
    CheckMatchRight:
        MOV bufferN2, 1
    ENDM
CheckMatch2 MACRO src, dst, len
    LEA SI, src
    LEA DI, dst 
    MOV CX, len
    CheckMatchLoop2:
        mov al, [si]
        mov bl, [di]
        cmp al, bl
        jne CheckMatchWrong2
        inc si
        inc di
        LOOP CheckMatchLoop2
        JMP CheckMatchRight2
    CheckMatchWrong2:
        CALL LOGIN_ERROR
        CALL CLEAR_SCREEN
        RETF
    CheckMatchRight2:
        MOV bufferN2, 1
    ENDM
LOGIN_DEBUG PROC FAR
    nwln 
    space 5
    PrintChar '#'
    Print uname1
    PrintChar '#'
    Print uname2
    PrintChar '#'
    Print uname3
    PrintChar '#'
    Print uname4
    PrintChar '#'
    Print uname5
    PrintChar '#'
    nwln 
    space 5
    PrintChar '#'
    Print pword1
    PrintChar '#'
    Print pword2
    PrintChar '#'
    Print pword3
    PrintChar '#'
    Print pword4
    PrintChar '#'
    Print pword5
    PrintChar '#'
    nwln
    space 5
    PrintChar '#'
    Print buffer1
    PrintChar '#'
    Print buffer2
    PrintChar '#'
    Print buffer3
    PrintChar '#'
    Print buffer0
    PrintChar '#'
    nwln
RETF
LOGIN_DEBUG ENDP
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
    MOV ah, 01h
    INT 21h
    CMP AL, 'n'
    JE LOGIN_ERROR_GIVE_UP
    CMP AL, 'N'
    JE LOGIN_ERROR_GIVE_UP
    MOV AX, 0
    MOV next_screen, 3
    RETF

    LOGIN_ERROR_GIVE_UP:
    MOV next_screen, 1
    MOV AX, 1
    
RETF
LOGIN_ERROR ENDP

LOG_IN PROC FAR
    ;CALL LOGIN_DEBUG
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
    InputStr buffer1
    nwln
    Color 0FH, 17
    Print regis3      
    InputStr buffer2  ; Password:
    nwln 
    
    CheckMatch buffer1, uname1, MAX_STR_LEN
    CheckMatch2 buffer2, pword1, MAX_STR_LEN
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