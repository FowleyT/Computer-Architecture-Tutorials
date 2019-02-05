includelib legacy_stdio_definitions.lib
extrn printf:near
option casemap:none                         ; case sensitive


.data   
fxp3 db 'qns\n', 0AH, 00H ; ASCII format string
fxp2 db 'a = %I64d b = %I64d c = %I64d d = %I64d e = %I64d a+b+c+d+e = %I64d', 0AH, 00H ; ASCII format string
public g									; 
g	QWORD 4									;  global variable g = 4

.code

public min									; min function

min:			
				
				mov  rax,rcx			    ; int v = a
				cmp  rdx,rax			    ; if (b < v)
				jge  bLessThanV				; branch
				mov  rax,rdx     			; else (v = b)

bLessThanV:	    cmp  r8,rax			        ; if(c < v)
				jge  cLessThanV				; branch
				mov  rax,r8      			; else (v = c)

cLessThanV:		
			    ret							; return


public p

p:			
                sub  rsp, 32                ; allocate shadow space
				mov  [rsp + 64], r8         ; storing r8
				mov  [rsp + 72], r9         ; storing r9
				mov  r8, rdx                ; j
                mov  rdx, rcx               ; i
                mov  rcx, g                 ; g
				call min					; call min(g, i, j)
				mov  rdx, [rsp + 64]        ; k
                mov  r8, [rsp + 72]         ; l
				mov  rcx, rax               ; min(min(g, i, j)
				call min					; min(min(g, i, j), k, l)
				add  rsp, 32                ; deallocate shadow space
				ret							; return


public gcd

gcd:			
				
				cmp  rdx,0	                ; if (b == 0)
				jne  bNotZeroYet
				mov  eax,ecx    			; return a
				jmp  bZero

bNotZeroYet:    mov  rax,rcx     			; gcd(b, a % b)
                mov  rcx,rdx     			; set variable b
				cdq							; extend to quadword
				idiv rcx					; divide variables
				call gcd                    ; recusively go through until b == 0
			
bZero:			
			    ret							; return



public  q                       

q:             
              
                mov  rax, rcx	             ; rax = a
	            add  rax, rdx		         ; rax = a + b
                add  rax, r8                 ; rax = a + b + c
                add  rax, r9                 ; rax = a + b + c + d
                mov  rbx, [rsp + 40]         ; rbx = e 
                add  rax, rbx                ; rax = a + b + c + d + e 
			    sub  rsp, 64                 ; allocate shadow space 
                mov  [rsp + 56], rax         ; store rax
                mov  [rsp + 48], rbx         ; store e
                mov  [rsp + 40], r9          ; store d
                mov  [rsp + 32], rax		 ; store rax again for printf
                mov  r9, r8			         ; store c
                mov  r8, rdx				 ; store b
                mov  rdx, rcx				 ; store a
                lea  rcx, fxp2			     ; store prinf
                call printf				     ; call printf
				mov  rax, [rsp + 56]         ; remove a + b ...etc from rax
                add  rsp, 64				 ; deallocate shadow space
                ret							 ; return


public  qns                    

qns:     
                lea  rcx, fxp3        
                ;sub  rsp, 32         ; allocate shadow space
                call printf          ; call printf
				mov  rax,0           ; set to zero
                ;add  rsp, 32         ; deallocate shadow space
                ret                  ; return

       
end