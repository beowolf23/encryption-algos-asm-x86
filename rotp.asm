section .text
    global rotp
;; void rotp(char *ciphertext, char *plaintext, char *key, int len);
rotp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; ciphertext
    mov     esi, [ebp + 12] ; plaintext
    mov     edi, [ebp + 16] ; key
    mov     ecx, [ebp + 20] ; len
    ;; DO NOT MODIFY
    ;; TODO: Implment rotp
    ;; FREESTYLE STARTS HERE

    xor ebx, ebx ; iterator -> 0

reverse:
    mov eax, [esi + ebx]      ; eax <- plaintext[i] unde i este ebx
    sub ecx, ebx
    xor eax, [edi + ecx - 1]  ; xor eax, key[len - 1] unde len se decrementeaza
    mov [edx + ebx], al       ; ciphertext[i] = plaintext[i] ^ key[len - i - 1]
    add ecx, ebx
    inc ebx
    cmp ecx, ebx
    jne reverse 
    

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
