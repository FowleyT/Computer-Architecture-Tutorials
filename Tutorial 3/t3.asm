;;; uploaded late with permission after producing doctor's cert

public g									 ; 
g	QWORD 4									 ;  global variable g = 4

.code

public min									 ; min function

min:			
				
				add   r26,r0,r1			     ; int v = a
				sub   r27,r1,r0{C}           ; if (b < v)
				jge   bLessThanV			 ; branch
				xor   r0,r0,r0               ; nop
				add   r27,r0,r1     		 ; else (v = b)

bLessThanV:	    sub   r28,r1,r0{C}           ; if(c < v)
				jge   cLessThanV			 ; branch
				xor   r0,r0,r0               ; nop
				add   r28,r0,r1  			 ; else (v = c)

cLessThanV:		
			    ret	  r25,0				     ; return v
				xor   r0,r0,r0               ; nop

public p

p:			
                
				add   r27,r0,r10             ; j
                add   r26,r0,r11             ; i
				callr r25,min				 ; call min(g, i, j)
				add   g,r0,r12               ; g (instead of nop)
				add   r28,r0,r11             ; l
                mov   r29,r0,r12             ; k
				callr r25,min			     ; min(min(g, i, j), k, l)
				add   r1,r0,r10              ; min(min(g, i, j) (instead of nop)
				ret	  r25,0					 ; return final result
				xor   r0,r0,r0				 ; nop


public gcd

gcd:			
				
				cmp   rdx,0	                 ; if (b == 0)
				jeq   bZero
				add   r26,r0,r1			   	 ; return a
				add   r26,r0,r10			 ; a
				callr r25, mod			     ; a % b
				add   r27,r0,r11			 ; b (instead of nop)
				add   r27,r0,r10             ; b (for gcd)
				callr r25,gcd				 ; recursively call gcd(b, a % b)
				add   r0,r1,r11              ; a % b (instead of nop)
				
bZero:			
			    ret	 r25,0				     ; return result