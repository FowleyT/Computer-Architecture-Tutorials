.686                                        ; create 32 bit code
.model flat, C                              ; 32 bit memory model
option casemap:none                         ; case sensitive

.data                                      

public g									; 
g	DWORD 4									;  global variable g = 4

.code

public min									; min function

min:			push ebp					; push frame pointer
				mov  ebp,esp				; update ebp
				mov  eax,[ebp + 8]			; int v = a
				cmp  [ebp + 12],eax			; if (b < v)
				jge  bLessThanV				; branch
				mov  eax,[ebp + 12]			; else (v = b)

bLessThanV:	    cmp  [ebp + 16],eax			; if(c < v)
				jge  cLessThanV				; branch
				mov  eax,[ebp + 16]			; else (v = c)

cLessThanV:		pop	 ebx					; restore registers
				mov  esp,ebp				; restore esp
         	   	pop  ebp					; restore ebp
			    ret							; return


public p

p:				push ebp                    ; push frame pointer
			    mov  ebp,esp				; update frame pointer   
				push g					    ; push g
				push [ebp + 8]				; push i
				push [ebp + 12]				; push j
				call min					; call min(g, i, j)
				push [ebp + 16]				; push k
				push [ebp + 20]				; push l
				push eax					; min(g, i, j)
				call min					; min(min(g, i, j), k, l)
				pop ebx						; restore registers
			    mov esp, ebp			    ; restore esp
        	    pop ebp					    ; restore frame pointer
				ret							; return


public gcd

gcd:			push ebp                    ; push frame pointer
			    mov  ebp,esp				; update frame pointer 
				mov  eax,[ebp+12]			; set variable b
				cmp  eax,0	                ; if (b == 0)
				jne  bNotZeroYet
				mov  eax,[ebp+8]			; return b
				jmp  bZero

bNotZeroYet:    mov  eax,[ebp+8]			; gcd(b, a % b)
				cdq							; extend to quadword
				mov  ebx,[ebp+12]			; set variable b
				idiv ebx					; divide variables
				push edx				    ; push modulo 
				push ebx                    ; push b
				call gcd                    ; recusively go through until b == 0
				pop ebx						; restore registers



bZero:			mov  esp, ebp				; restore esp
          		pop  ebp					; rrestore frame pointer
			    ret							; return

end