section .data
    extern len_cheie, len_haystack
    nr_linii dd 1
    rest_div dd 1
    col_index dd 1
    iterator dd 0
    head_of_line dd 1
    head_of_line_plus_col dd 1
    
section .text
    global columnar_transposition

;; void columnar_transposition(int key[], char *haystack, char *ciphertext);
columnar_transposition:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha 

    mov edi, [ebp + 8]   ;key
    mov esi, [ebp + 12]  ;haystack
    mov ebx, [ebp + 16]  ;ciphertext
    ;; DO NOT MODIFY

    ;; TODO: Implment columnar_transposition
    ;; FREESTYLE STARTS HERE

;calculez dimensiunea matricii
divide:
    xor eax,   eax
    xor edx,   edx
    mov eax,   [len_haystack]
    div dword  [len_cheie]
    mov dword  [rest_div], edx
    inc eax
    mov dword  [nr_linii], eax
    xor ebx,   ebx
    xor ecx,   ecx

;iterez prin indecsii cheii
iterate_key:
    mov eax,   [edi + 4 * ebx]
    mov dword  [col_index], eax 
    xor eax,   eax
     ;pentru fiecare index din cheie calculez
     ;pozitia in matrice a urmatorului element
     ;si apoi ii mut in registrul final
     iterate_haystack:
         mov eax,   ecx
         mul dword  [len_cheie]
         mov dword  [head_of_line], eax
         mov dword  [head_of_line_plus_col], eax
         mov eax,   [col_index]
         add dword  [head_of_line_plus_col], eax
         xor eax,   eax
         mov edx,   [head_of_line_plus_col]
         mov al,    byte [esi + edx]
         xor edx,   edx
         push ebx
         mov ebx,   [ebp + 16]
         xor edx,   edx
         mov edx,   [head_of_line_plus_col]
         cmp edx,   [len_haystack]
         jae continue
         mov edx,   [iterator]
         mov byte   [ebx + edx], al
         inc dword  [iterator]
     continue: 
         pop ebx
         inc ecx
         cmp ecx,   [nr_linii]
         jne iterate_haystack
    xor ecx,  ecx
    inc ebx
    cmp ebx,  [len_cheie]
    jne iterate_key
    mov [iterator], dword 0

    popa
    leave
    ret
