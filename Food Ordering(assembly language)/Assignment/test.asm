INCLUDE Irvine32.inc

.data

User BYTE "user1", 0
password BYTE "abc123",0
MAX = 50
userVerify BYTE MAX+1 DUP (?)
passwordVerify BYTE MAX+1 DUP (?)

display1 BYTE "Username : ",0
display2 BYTE "Password : ",0
display3 BYTE "Wrong username or password!",0
display4 BYTE "Welcome Back!",0


count  = 2
total1 BYTE "You have use this system to order ",0
total2 BYTE " movie ticket",0
thanks BYTE " Thank you for using our program",0



.code
main proc
	Start:
	;call clrscr
	mov edx,OFFSET display1
	call WriteString

	mov edx,OFFSET userVerify
	mov ecx,MAX
	call ReadString

	mov edx,OFFSET display2
	call WriteString

	mov edx,OFFSET passwordVerify
	mov ecx,MAX
	call ReadString

	INVOKE Str_compare, ADDR User, ADDR userVerify
	jne epass

sameuser:	
		INVOKE Str_compare, ADDR password, ADDR passwordVerify
		je	samepassword
		jne epass

epass:
		mov edx,OFFSET display3
		call WriteString
		mov eax,600
		call delay
		;call DumpRegs
		call clrscr
		jmp Start

samepassword:
		mov edx,OFFSET display4
		call WriteString
		call Crlf
;		jmp mainrun


;mainrun:
;		mov edx,OFFSET total1
;		call WriteString
;		mov eax,count
;		call WriteDec
;		mov edx,OFFSET total2
;		call WriteString
;		call Crlf
		

endmain:
;mov edx,OFFSET thanks
;call WriteString
invoke ExitProcess, 0
main endp
end main