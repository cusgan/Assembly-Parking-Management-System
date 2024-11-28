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