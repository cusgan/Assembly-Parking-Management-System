; 4. MAIN MENU
MAIN_MENU PROC FAR
    CALL PRINT_CITU
    Color 4EH, 80
    Print submenu
    Color 4FH, 80
    space 80
    
    Color 70H, 80
    space 80

    Color 11110100B, 80
    Print menu1

    Color 70H, 80
    Print menu2
    Color 70H, 80
    Print menu3
    Color 70H, 80
    Print menu4
    Color 70H, 80
    Print menu5
    Color 70H, 80
    space 80

    nwln

    Color 10001110B, 17
    Print choice
    
    MOV AH, 01H
    INT 21H
    MOV inputChoice, AL
    CMP AL, '1'
    JE MENU_CHOICE_1
    CMP AL, '2'
    JE MENU_CHOICE_2
    CMP AL, '3'
    JE MENU_CHOICE_3
    JMP MENU_SCREEN_END
    MENU_CHOICE_1:
        CALL CLEAR_SCREEN
        MOV next_screen, 5 ; slot availability
        JMP MENU_SCREEN_END
    MENU_CHOICE_2:
        CALL CLEAR_SCREEN
        MOV next_screen, 1 ; 
        JMP MENU_SCREEN_END
    MENU_CHOICE_3:
        CALL CLEAR_SCREEN
        MOV next_screen, 0 ; exit
        JMP MENU_SCREEN_END
    MENU_SCREEN_END:
RETF
MAIN_MENU ENDP
