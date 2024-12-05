; EXIT
EXIT PROC FAR
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
    space 80
    Color 70H, 80
    space 80

    Color 70H, 80
    Print exit1     ; thank you for using
    Color 70H, 35
    Print exit2     ; see you soon
    Color 11110100B, 45
    mov ah,02h
	mov cl,03 	; shaded heart
	mov dl,cl
	int 21h	 
    space 44

    Color 70H, 80
    space 80
    Color 70H, 80
    space 80
    Color 70H, 80
    space 80
    nwln
    MOV next_screen, 99
RETF 
EXIT ENDP