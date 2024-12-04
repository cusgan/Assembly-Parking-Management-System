; SEE PARKING SLOT AVAILABILITY
SLOTS_NUM PROC FAR
    PrintChar '['
    PrintChar ' '
    mov ax, bufferN2
    cmp ax, 10
    jl slot_num_2digit
        StrictNum ax, 3
        PrintChar ']'
        PrintChar ' '
        jmp slot_num_after
    slot_num_2digit:
        PrintChar '0'
        mov ax, bufferN2
        StrictNum ax, 2
        PrintChar ']'
        PrintChar ' '
        jmp slot_num_after
    slot_num_after:
    retf
    SLOTS_NUM ENDP
SLOT_YES PROC FAR
    Color 70H, 4
    space 4
    Color 2FH, 34
    CALL SLOTS_NUM
    Print availyes
    RETF
SLOT_YES ENDP
SLOT_NO PROC FAR
    Color 70H, 4
    space 4
    Color 70H, 34
    CALL SLOTS_NUM
    Print availno
    RETF
SLOT_NO ENDP



; slot options

; park car
SLOTS_PARK PROC FAR 
    nwln 
    nwln 
    Color 0FH, 31
    Print park1 ; enter slot to park

    ; if slot is already occupied, print error message
    ; press enter to continue -> refresh

    nwln
    Color 0FH, 35
    Print park2 ; enter hrs

    nwln
    nwln
    Color 0FH, 29
    Print park3 ; success
RETF
SLOTS_PARK ENDP  

; open slot
SLOTS_OPEN PROC FAR 
    nwln 
    nwln 
    Color 0FH, 31
    Print opslot1 ; enter slot to open

    ; if slot is already empty, print error message
    ; press enter to continue -> refresh

    nwln
    nwln 
    Color 0FH, 80
    Print opslot2 ; success

    Color 0FH, 80
    Print opslot3 ; display total P
    StrictNum total, 60

    Color 0EH, 31
    Print continue
    CALL CLEAR_SCREEN
    MOV next_screen, 5 
RETF
SLOTS_OPEN ENDP 

; change slot hours
SLOT_CHANGE_HRS PROC FAR

RETF 
SLOT_CHANGE_HRS ENDP



SLOT_AVAILABILITY PROC FAR
;MOV AH, 09H
    CALL PRINT_CITU
    Color 4EH, 80
    Print subavail
    Color 4FH, 80
    space 80
    Color 70H, 80
    space 80

    Color 70H, 4
    space 4
    Color 4FH, 27
    Print avail0 
    Color 70H, 49
    space 49

    ; no of available
    Color 70H, 80
    print avail1
    StrictNum availvar, 40
    ; no of unavailable
    Color 70H, 80
    print avail2
    StrictNum unavailvar, 40
    ; total no
    Color 70H, 80 
    Print avail3

    Color 70H, 80 
    space 80

    LEA SI, hoursdata
    MOV AX, 0
    MOV bufferN2, 0
    SLOT_CHECK_LOOP:
        INC bufferN2
        PUSH AX
        MOV BL, [SI]
        CMP BL, '$'
        JE SLOT_CHECK_ENDL
        CMP BL, '0'
        JNE SLOT_CHECK_YES
            CALL SLOT_NO
        JMP SLOT_CHECK_END
        SLOT_CHECK_YES:
            CALL SLOT_YES
        SLOT_CHECK_END:
        INC SI
        POP AX
        INC AX
        TEST AL, 1
        JNZ SLOT_CHECK_LOOP
        Color 70H, 4
        space 4
        JMP SLOT_CHECK_LOOP
    SLOT_CHECK_ENDL:

    Color 70H, 80 
    space 80

    nwln

    Color 0EH, 25 
    Print option
    Color 0FH, 80 
    Print slotmenu1
    Color 0FH, 80 
    Print slotmenu2
    Color 0FH, 80 
    Print slotmenu3
    Color 0FH, 80 
    Print slotmenu4
    Color 0FH, 80 
    Print slotmenu5

    Color 10001110B, 17
    Print choice

    MOV AH, 01H
    INT 21H
    MOV inputChoice, AL
    CMP AL, '1'
    JE SLOTS_CHOICE_1
    CMP AL, '2'
    JE SLOTS_CHOICE_2
    CMP AL, '3'
    JE SLOTS_CHOICE_3
    CMP AL, '4'
    JE SLOTS_CHOICE_4
    CMP AL, '5'
    JE SLOTS_CHOICE_5
    JMP SLOTS_SCREEN_END
    SLOTS_CHOICE_1: ; park
        CALL SLOTS_PARK 
        
        MOV ah, 01h
        INT 21h
        CALL CLEAR_SCREEN
        MOV next_screen, 4 ; refresh slots screen
        JMP SLOTS_SCREEN_END
    SLOTS_CHOICE_2: ; open slot
        CALL SLOTS_OPEN
        JMP SLOTS_SCREEN_END
    SLOTS_CHOICE_3: ; change hrs
        CALL SLOT_CHANGE_HRS
        JMP SLOTS_SCREEN_END
    SLOTS_CHOICE_4: ; return to main menu
        CALL CLEAR_SCREEN
        MOV next_screen, 4
        JMP SLOTS_SCREEN_END
    SLOTS_CHOICE_5: ; exit
        CALL CLEAR_SCREEN
        MOV next_screen, 0
        JMP SLOTS_SCREEN_END
    SLOTS_SCREEN_END:
    xor ax, ax 
    xor bx, bx
    xor cx, cx 
    xor dx, dx
RETF
SLOT_AVAILABILITY ENDP