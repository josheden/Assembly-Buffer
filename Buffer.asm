;JOSHUA EDEN
;USING VISUAL STUDIO 2015

;This program inputs an entire line of text, up to 132 characters, into a buffer.
;It will then have the program determine how many times each letter of the alphabet
;occurs.

INCLUDE Irvine32.inc
 
.Data
buff db 133       
  db ?       
  db 133 dup(0)      
  displayArrow BYTE "-->",0
      
displayMessage  db "Please enter a string (a-z), (A-Z), (0-9) only of up to 132 characters.", 0ah, 0dh
string BYTE 133 DUP(?)
count BYTE 133 DUP(?)
 
.Code
main PROC
	 MOV EAX,EDX				; moving the EDX register into the EAX register
	 MOV EDX, offset displayMessage   ; move display message into the EDX register
	 call WriteString     
	 MOV EDX, offset string		; Move offset of string into the EDX register
	 MOV ECX, sizeof string -1	; Move size of (string-1) into the ECX register
	 call ReadString     
	 XOR ECX, ECX				; exclusive OR the ECX register  
	 XOR ESI, ESI				; exclusive OR the ESI register
	 MOV ECX, 133				; moving 133 into the ECX register
L1:								; initializing loop
		 MOV AL, string[ESI]    ; move memory address of strings ESI into AL
		 jmp lowerChar			; Jump if true
	lowerChar:
		 cmp AL, 'a'			; Comparing AL with 'a'
		 jb upperChar			; Jump if true
		 cmp AL, 'z'			; Comparing AL with 'z'
		 ja next				; Jump if true
		 MOVZX EDI, AL			; Move AL register into the EDI register
		 ADD count[EDI], 1		; Add 1 to EDI register
		 jmp next				; Jump if true
	upperChar:           
		 cmp AL, 'A'			; Compare AL with 'A'
		 jb type			; jump condition with type
		 cmp AL, 'Z'			; Compare AL with 'Z'
		 ja next				; To scan through each character
		 MOVZX EDI, AL			; Move AL into the EDI register
		 ADD count[EDI], 1		; Add 1 to EDI register
		 jmp next				; Jump if true
	type:
		 cmp AL, '0'			; Compare AL with '0'
		 jb next				; Iterating through each number
		 cmp AL, '9'			; Compare AL with '9'
		 ja next				; Jump if true
		 MOVZX EDI, AL			; Move AL into the EDI register
		 ADD count[EDI], 1		; Adding 1 to the EDI register
		 jmp next				; Jump if true
	next:          
		 inc ESI				; Increment the ESI register
 loop L1
	XOR EDX, EDX				; Exclusive OR the EDX register
	MOV EAX, 48					; Moving 48 in the EAX register
displayInfo:
	 call Crlf
	 call WriteChar				; Show character
	 MOV EDX, OFFSET displayArrow   ; Move display arrow into the EDX register
	 call WriteString			; Show arrow
	 MOV EDI, EAX				; Move contents of EAX into EDI register
	 MOVZX EAX, count[EDI]		; Move EDI of count into the EAX register
	 call WriteDec				; Write to signed int
	 MOV EAX, EDI               ; Move EDI contents into the EAX register
	 inc EAX					; Increment the EAX register
	 cmp EAX, 57				; Compare EAX to 57
	 ja ifUppercase				; Jump if true
	 jmp displayInfo			; Jump to display info
ifUppercase:
	 cmp EAX, 90				; Compare EAX to 90
	 ja ifLowercase				; Jump if lowerChar
	 cmp EAX, 65				; Compare EAX contents to 65
	 jge displayInfo			; Jump to display info
	 inc EAX;					; Increment the EAX register
	 jmp ifUppercase			; Jump if upperChar
ifLowercase:        
	 cmp EAX, 122				; Compare EAX contents to 122
	 ja exitProgram				; Jump to exit program if true
	 cmp EAX, 97				; Compare EAX contents to 97
	 jge displayInfo			; Jump if true
	 inc EAX;					; Increment the EAX register
	 jmp ifUppercase			; Jump if upperChar
exitProgram:       
	 call Crlf					
	 call ReadChar
	 exit
main ENDP						; End main procedure
END main						; End program
