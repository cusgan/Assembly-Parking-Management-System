; 4. MAIN MENU
MAIN_MENU PROC FAR
    Color 4FH, 80
    Print head
    Color 4EH, 80
    Print submenu
    
    Color 70H, 80
    Print empty

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
    Print menu6
    Color 70H, 80
    Print empty

    nwln

    Color 0EH, 17
    Print choice
    
    nwln
RETF
MAIN_MENU ENDP
