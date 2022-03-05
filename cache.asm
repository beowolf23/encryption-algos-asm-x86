;; defining constants, you can use these as immediate values in your code
CACHE_LINES  EQU 100
CACHE_LINE_SIZE EQU 8
OFFSET_BITS  EQU 3
TAG_BITS EQU 29 ; 32 - OFSSET_BITS

section .data
    offset dd 1
    tag dd 1
    addr dd 1
    to_replace dd 1
section .text
    global load

;; void load(char* reg, char** tags, char cache[CACHE_LINES][CACHE_LINE_SIZE], char* address, int to_replace);
load:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; address of reg
    mov ebx, [ebp + 12] ; tags
    mov ecx, [ebp + 16] ; cache
    mov edx, [ebp + 20] ; address
    mov edi, [ebp + 24] ; to_replace (index of the cache line that needs to be replaced in case of a cache MISS)
    ;; DO NOT MODIFY
     
    ;tag + offset
    ;tag_i -> tags
    xor esi, esi
    mov [to_replace], edi

;calculez tag-ul si offset-ul
tag_and_offset:
    mov [addr],   edx
    and edx,      dword 7 
    mov [offset], edx
    mov edx,      [addr]
    sub edx,      [offset]
    shr edx,      3
    mov [tag], edx
    
    mov edi,      [tag]
    
;verific daca exista tag-ul in vector-ul tags
iterate_through_tags:
    cmp [ebx + esi], edi
    je cache_hit 

    inc esi 
    cmp esi,      CACHE_LINES
    jne iterate_through_tags

;cache miss
in_case_of_cache_miss:

    xor esi,      esi ; resetez counter

    ;mov edi, [offset]
    ;sub [addr], edi
    mov edx,     [addr] ; aici am adresa divizibila cu 8
    mov edi,     [to_replace] ; adaug ce era in edi la inceput

;calculez index-ul elementului care trebuie pus in cache
calcul_index:
    mov eax,     dword CACHE_LINE_SIZE
    mul edi

;daca nu exista in cache adresa
cache_miss:
    mov edx,     [ebp + 20]
    add eax,     esi
    ; mov [ecx + edi * CACHE_LINE_SIZE + esi], edx
    push ebx
    mov ebx,     esi
    sub ebx,     [offset]
    mov ebx,     [edx + ebx]
    mov [ecx + eax], ebx
    sub eax,     esi
    pop ebx

    inc esi 
    cmp esi,     CACHE_LINE_SIZE
    jl cache_miss

;adaug in tags si in registrul rezultat
after_cache_miss:
    mov esi,     eax
    add esi,     [offset]
    ; adaug in reg
    mov eax,     [ebp + 8]
    mov edx,     [ecx + esi]
    mov [eax],   edx

    push eax
    mov eax,     [to_replace]
    mov esi,     [tag]
    mov ebx,     [ebp + 12]
    mov [ebx + eax], esi
    pop eax
     
;cache hit - daca exista in cache deja
cache_hit:
    mov edi,     [ecx + CACHE_LINE_SIZE * esi] 
    add edi,     [offset]
    mov eax,     edi

continue:
    popa
    leave
    ret
    ;; DO NOT MODIFY
