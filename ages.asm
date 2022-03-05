; This is your structure
struc  my_date
    .day: resw 1
    .month: resw 1
    .year: resd 1
endstruc

section .text
    global ages

; void ages(int len, struct my_date* present, struct my_date* dates, int* all_ages);
ages:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; present
    mov     edi, [ebp + 16] ; dates
    mov     ecx, [ebp + 20] ; all_ages
    ;; DO NOT MODIFY

    ;; TODO: Implement ages
    ;; FREESTYLE STARTS HERE

    xor ebx, ebx    

calculate_age:
    mov eax, dword [esi + 4]
    sub eax, [edi + 8 * ebx + 4] 
    cmp eax, 0
    mov [ecx + 4 * ebx], eax          ; mut diferenta de ani in allages


;calculate_month - label pentru a compara luna nasterii cu cea curenta
calculate_month:
    xor ax, ax
    mov ax, [esi + 2]
    
    cmp ax, word [edi + 8 * ebx + 2]
    jl  dec_year
    cmp ax, word [edi + 8 * ebx + 2]
    jg  continue
    cmp ax, word [edi + 8 * ebx + 2]
    je  calculate_day

;calculate_day - label pentru a compara ziua nasterii cu cea curenta
calculate_day:
    xor ax, ax
    mov ax, [esi]
    cmp ax, [edi + 8 * ebx]
    jl  dec_year 
    cmp ax, [edi + 8 * ebx]
    jg continue
    cmp ax, [edi + 8 * ebx]
    je continue

;dec_year decrementez diferenta de ani
dec_year:
    dec dword [ecx + 4 * ebx]
    jmp continue

increment:
    inc dword [ecx + 4 * ebx]
    jmp continue

continue:
    xor eax, eax
    cmp [ecx + 4 * ebx], eax
    jl increment 
    inc ebx
    cmp edx, ebx
    jne calculate_age

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
