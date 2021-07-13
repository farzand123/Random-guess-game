.model small
lfcr macro
    
     mov ah, 02
     mov dl, 0ah
     int 21h
     mov dl, 0dh
     int 21h
    
    
lfcr endm
.stack 100h
.data
number db ? 
count db ?
level       db  'Press 1 for easy, 2 for medium and any else for hard$'
easyl       db  'You selected easy level and get 9 guess$'
mediuml     db  'You selected medium level and get 4 guess$'
hardl       db  'You selected hard level and get 2 guess$'
life1       db  'You have $'
life2       db  ' guesses left$'
guess       db  'Guess the number between 0-9$'
prompt      db  'Please enter a valid number : $'
lessMsg     db  'Value is low, Guess higher $'
moreMsg     db  'Value is more, Guess lower $'
equalMsg    db  'You have Guessed correctly! $'
lost        db  'You ran out of guesses$'
overflowMsg db  'Error - Number out of range! $'
retry       db  'Press 1 to replay, press anything else to end $' 
.code
main:

    MOV ax, @data          
    MOV ds, ax             
  
   
   random:
   
   
    mov     ah, 0fh                                                                                                                                                                                            
    int     10h                                                                                                                                                                                                
    mov     ah, 0                                                                                                                                                                                              
    int     10h                                                                                                                                                                                                
      
   
   MOV AH, 00h  
   INT 1AH      

   mov  ax, dx
   xor  dx, dx
   mov  cx, 10    
   div  cx       

   add  dl, 48 
  
   mov number,dl
   
   
   mov ah,09
   lea dx,level
   int 21h
   lfcr
   
   MOV ah,01              
   int 21h  
   mov bl,al
   lfcr
   
   cmp bl,49
   je easy
   cmp bl,50
   je medium
   jmp hard
   
   
   
   
   easy:
   mov ah,09
   lea dx,easyl
   int 21h
   mov count,9
   lfcr
   jmp lastlevel
   
   medium:
   mov ah,09
   lea dx,mediuml
   int 21h    
    mov count,4
   lfcr 
   jmp lastlevel
   
   hard:
   mov ah,09
   lea dx,hardl
   int 21h     
    mov count,2
   lfcr
   
   lastlevel:
   
   
   mov ah,09
   lea dx,guess
   int 21h
   lfcr 
   
   add count,48
   
   start: 
 lfcr  
  cmp count,48
  je end1 
  mov ah,09
  lea dx,life1
  int 21h
  
  
  mov ah,02
  mov dx,count
  int 21h
  
  mov ah,09
  lea dx,life2
  int 21h 
   
     lfcr
    mov ah,09
    lea dx,prompt
    int 21h
   
    MOV ah,01              
    int 21h  
    mov bl,al
  
   
   
   cmp bl,57
   jg error
   
   cmp bl,number
   je equal
   jmp notequal
   
   equal:
   lfcr 
   lfcr
   mov ah,09
   lea dx,equalMsg
   int 21h
   jmp end
   
   notequal:
   lfcr
   dec count
   cmp number,bl
   jg greater
   jmp lesser
   
   greater:
   lfcr
   mov ah,09
   lea dx,lessMsg
   int 21h
   jmp start
   
   lesser:
   lfcr
   mov ah,09
   lea dx,moreMsg
   int 21h
   jmp start
   
   error:
   lfcr
   mov ah,09
   lea dx,overflowMsg
   int 21h
   jmp start 
   
    end1:
    mov ah,09
    lea dx,lost
    int 21h
   
    end:
    lfcr
    mov ah,09
    lea dx,retry
    int 21h
   
    mov ah,01              
    int 21h 
    mov bl,al 
    
   cmp bl,49
   je random
    
    
    
    
      
    MOV ax, 4ch 
    INT 21h     
    end main    
    