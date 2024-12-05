.model small
.stack 100h

.data
    buffer1 db 100, 0   ; Max input length (100 bytes), initial length set to 0
    buffer2 db 100, 0
    prompt1 db "Enter the first string: $"
    prompt2 db "Enter the second string: $"
    sameMsg db "Strings are the same.$"
    diffMsg db "Strings are NOT the same.$"

.code
main proc
    mov ax, @data       ; Load data segment
    mov ds, ax

    ; Prompt and input for the first string
    lea dx, prompt1
    mov ah, 9           ; Print prompt
    int 21h

    lea dx, buffer1
    mov ah, 0Ah         ; Read string input
    int 21h

    ; Remove trailing carriage return from the first string
    lea si, buffer1
    mov cl, [si+1]      ; Length of input string
    lea di, buffer1 + 2 ; Start of actual string
    add di, cx          ; Move to the last character of input
    dec di              ; Move back one position
    cmp byte ptr [di], 13 ; Check for carriage return (ASCII 13)
    jne no_cr1          ; If not found, skip removal
    mov byte ptr [di], 0 ; Replace with null terminator
no_cr1:

    ; Newline for better display
    mov ah, 2
    mov dl, 0Ah
    int 21h

    ; Prompt and input for the second string
    lea dx, prompt2
    mov ah, 9           ; Print prompt
    int 21h

    lea dx, buffer2
    mov ah, 0Ah         ; Read string input
    int 21h

    ; Remove trailing carriage return from the second string
    lea si, buffer2
    mov cl, [si+1]      ; Length of input string
    lea di, buffer2 + 2 ; Start of actual string
    add di, cx          ; Move to the last character of input
    dec di              ; Move back one position
    cmp byte ptr [di], 13 ; Check for carriage return (ASCII 13)
    jne no_cr2          ; If not found, skip removal
    mov byte ptr [di], 0 ; Replace with null terminator
no_cr2:

    ; Compare the strings
    lea si, buffer1 + 2 ; Skip length byte
    lea di, buffer2 + 2 ; Skip length byte

compare_loop:
    mov al, [si]        ; Load current character of buffer1
    mov bl, [di]        ; Load current character of buffer2
    cmp al, bl          ; Compare the two characters
    jne strings_differ  ; If not equal, strings differ

    cmp al, 0           ; Check for null terminator
    je strings_equal    ; If both are null, strings are equal

    inc si              ; Move to next character in buffer1
    inc di              ; Move to next character in buffer2
    jmp compare_loop    ; Continue comparison

strings_differ:
    ; Newline for better display
    mov ah, 2
    mov dl, 0Ah
    int 21h

    lea dx, diffMsg
    mov ah, 9           ; Print "Strings are NOT the same"
    int 21h
    jmp done

strings_equal:
    ; Newline for better display
    mov ah, 2
    mov dl, 0Ah
    int 21h

    lea dx, sameMsg
    mov ah, 9           ; Print "Strings are the same"
    int 21h

done:
    ; Newline before exiting
    mov ah, 2
    mov dl, 0Ah
    int 21h

    mov ah, 4Ch         ; Exit program
    int 21h

main endp
end main
