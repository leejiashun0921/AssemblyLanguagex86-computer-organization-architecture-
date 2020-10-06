INCLUDE Irvine32.inc

.data

tab1 db "				",0
tab2 db "			",0
tab3 db "		",0

msgstart db 0dh,0ah,"================================="
db 0dh,0ah,"< Welcome to Movie Ticket Selling System >"
db 0dh,0ah,"==========================================",0dh,0ah
db "Service List",0dh, 0ah
db "1) Login", 0dh, 0ah
db "2) SearchMovie", 0dh, 0ah
db "3) Exit", 0dh, 0ah
db 0dh, 0ah, "Please Select Your Service: ",0
;db 0dh,0ah,"Please select again!", 0dh,0ah,0dh,0ah,"",0

User BYTE "user1", 0
password BYTE "abc123",0
MAX = 50
userVerify BYTE MAX+1 DUP (?)
passwordVerify BYTE MAX+1 DUP (?)
place BYTE MAX+1 DUP (?)
time BYTE MAX+1 DUP (?)

display1 BYTE "Username : ",0
display2 BYTE "Password : ",0
display3 BYTE "Wrong username or password!",0
display4 BYTE "Welcome Back!",0


mainpage2 BYTE "1.",0
mainpage3 BYTE "2.",0

count dword 0
total1 BYTE "You have use this system to order ",0
total2 BYTE " movie ticket",0
thanks BYTE " Thank you for using our program",0


msg1 db 0dh,0ah,"=========================================="
db 0dh,0ah,"< Welcome to Movie Ticket Selling System >"
db 0dh,0ah,"==========================================",0dh,0ah
db "Service List",0dh, 0ah
db "1) Select Movie", 0dh, 0ah
db "2) Log Out", 0dh, 0ah
db 0dh, 0ah, "Please Select Your Service: ",0
wrgmsg db 0dh,0ah,0dh,0ah,"You have selected an wrong option!",0
;db 0dh,0ah,"Please select again!", 0dh,0ah,0dh,0ah,"",0

msg20 db "1 ticket cost RM 5",0
msg21 db "Enter Payment:",0
msg22 db "Change:RM",0
msg23 db "Not enough money!",0

arrn1 db "1)Avengers:EndGame",0
arrt1 db "14:00",0
arrd1 db "16/08/2019#17/08/2019$",0
arrp1 db "      #      $"

arrn2 db "2)Fast&Furious",0
arrt2 db "14:00",0
arrd2 db "16/08/2019#18/08/2019$",0
arrp2 db "      #      $"

arrn3 db "3)Spider Man",0
arrt3 db "17:00",0
arrd3 db "17/08/2019#18/08/2019$",0
arrp3 db "      #      $"

arrn4 db "4)Annabelle",0
arrt4 db "20:00",0
arrd4 db "16/08/2019#17/08/2019$",0
arrp4 db "      #      $"

arrn5 db "5)Star Wars",0
arrt5 db "13:00",0
arrd5 db "16/08/2019#17/08/2019$",0
arrp5 db "      #      $"

arrn6 db "6)Terminator",0
arrt6 db "15:00",0
arrd6 db "17/08/2019#18/08/2019$",0
arrp6 db "      #      $"

arrn7 db "7)Crawl",0
arrt7 db "18:00",0
arrd7 db "16/08/2019#18/08/2019$",0
arrp7 db "      #      $"

arrn8 db "8)The Lion King",0
arrt8 db "21:00",0
arrd8 db "17/08/2019#18/08/2019$",0
arrp8 db "      #      $"

icache db 10 dup ("0"),0
dcache db 10 dup ("0"),0
tcache db 10 dup ("0"),0
book1 db "##########",0

msg12 db 0dh, 0ah, "Please Select a Movie: ",0
select BYTE ?
pay dword ?
msg13 db 0dh, 0ah, "Please choose a Date: ",0


msg14 db 0dh, 0ah, "Please Select a Place: ",0

msg15 db 0dh, 0ah, "-------------",0

receipt1 db 0dh, 0ah, "===================================================",0
receipt2 db 0dh, 0ah, "Movie Ticket",0
receipt3 db 0dh, 0ah, "Movie Name:",0
receipt4 db 0dh, 0ah, "Movie Date:",0
receipt5 db 0dh, 0ah, "Movie Time:",0
receipt6 db 0dh, 0ah, "Seat No   :",0
receipt7 db 0dh, 0ah, "(Press any key to continue)",0



.code
main proc

mainpage:

mov edx,OFFSET msgstart
call WriteString
call readchar
cmp al,31h
je jumpback
cmp al,32h
je end1
jne mainerror

mainerror:
call clrscr
mov edx,OFFSET wrgmsg
call writeString
jmp mainpage

Login:
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

je	sameuser
jmp error

jumpback:
		call clrscr
		jmp Login

jumpmain:
		call clrscr
		jmp mainpage

sameuser:	
		INVOKE Str_compare, ADDR password, ADDR passwordVerify
		je	samepassword
		jmp error

error:
		call clrscr
		mov edx,OFFSET display3
		call WriteString
		call Crlf
		jmp Login

samepassword:
		call clrscr
		mov edx,OFFSET display4
		call WriteString
		call Crlf
		jmp Start

Start:
lea edx, msg1
call writestring
call readchar
call writechar
call isDigit
jne end1
cmp al,31h
je selectMovie
cmp al,32h
je SearchMovie
cmp al,33h
je jumpmain
jne errorstart

errorstart:
call clrscr
mov edx,OFFSET wrgmsg
call writeString
jmp Start

selectMovie:
call clrscr
lea edx,arrn1
call writestring

call crlf

lea edx,arrn2
call writestring

call crlf

lea edx,arrn3
call writestring

call crlf

lea edx,arrn4
call writestring

call crlf

lea edx,arrn5
call writestring

call crlf

lea edx,arrn6
call writestring

call crlf

lea edx,arrn7
call writestring

call crlf

lea edx,arrn8
call writestring

call crlf

lea edx, msg12
call writestring

call readchar
call writechar
call isDigit
call crlf
mov select,al
mov icache[0],al
cmp icache[0],31h
je movie1
cmp al,32h
je movie2
cmp al,33h
je movie3
cmp al,34h
je movie4
cmp al,35h
je movie5
cmp al,36h
je movie6
cmp al,37h
je movie7
cmp al,38h
je movie8


movie1:
call clrscr
mov esi,0
mov ecx,30
arrd11:
mov al,arrd1[esi]
cmp al,24h
je ttime
cmp al,23h
je sym
call writechar
inc esi
loop arrd11

movie2:
call clrscr
mov esi,0
mov ecx,30
arrd12:
mov al,arrd2[esi]
cmp al,24h
je ttime
cmp al,23h
je sym
call writechar
inc esi
loop arrd12

movie3:
call clrscr
mov esi,0
mov ecx,30
arrd13:
mov al,arrd3[esi]
cmp al,24h
je ttime
cmp al,23h
je sym
call writechar
inc esi
loop arrd13

movie4:
call clrscr
mov esi,0
mov ecx,30
arrd14:
mov al,arrd4[esi]
cmp al,24h
je ttime
cmp al,23h
je sym
call writechar
inc esi
loop arrd14

movie5:
call clrscr
mov esi,0
mov ecx,30
arrd15:
mov al,arrd5[esi]
cmp al,24h
je ttime
cmp al,23h
je sym
call writechar
inc esi
loop arrd15

movie6:
call clrscr
mov esi,0
mov ecx,30
arrd16:
mov al,arrd6[esi]
cmp al,24h
je ttime
cmp al,23h
je sym
call writechar
inc esi
loop arrd16

movie7:
call clrscr
mov esi,0
mov ecx,30
arrd17:
mov al,arrd7[esi]
cmp al,24h
je ttime
cmp al,23h
je sym
call writechar
inc esi
loop arrd17

movie8:
call clrscr
mov esi,0
mov ecx,30
arrd18:
mov al,arrd8[esi]
cmp al,24h
je ttime
cmp al,23h
je sym
call writechar
inc esi
loop arrd18

sym:
call crlf
inc esi
mov al,icache[0]
cmp al,31h
je arrd11
cmp al,32h
je arrd12
cmp al,33h
je arrd13
cmp al,34h
je arrd14
cmp al,35h
je arrd15
cmp al,36h
je arrd16
cmp al,37h
je arrd17
cmp al,38h
je arrd18

ttime:
lea edx, msg13
call writeString
mov edx,OFFSET time
mov ecx,MAX
call ReadString
mov icache[0],al
call writechar
mov al,icache[1]
call writechar
call isDigit
jne end1
;mov eax,1200
;call delay
mov al,select
cmp al,31h
je movie11
cmp al,32h
je movie22
cmp al,33h
je movie33
cmp al,34h
je movie44
cmp al,35h
je movie55
cmp al,36h
je movie66
cmp al,37h
je movie77
cmp al,38h
je movie88


movie11:
cmp icache[1],31h
je decx1
cmp icache[1],32h
je decx2
decx1:
mov esi,0
jmp movie1t
decx2:
mov esi,11
jmp movie1t

movie1t:
mov ecx,30
mov ebx,0
movie1t1:
mov al,arrd1[esi]
cmp al,23h
je dcache1
cmp al,24h
je dcache1
mov dcache[ebx],al
inc esi
inc ebx
loop movie1t1

dcache1:
call clrscr
lea edx,arrn1[2]
call writestring
lea edx,tab3
call writestring
lea edx,dcache
call writestring
lea edx,tab3
call writestring
lea edx,arrt1
call writestring
lea edx,msg15
call writestring
call crlf

cmp icache[1],31h
je mesi1
cmp icache[1],32h
je mesi2

mesi1:
mov esi,0
jmp pplace1
mesi2:
mov esi,7
jmp pplace1

pplace1:
mov ecx,6
place1:
mov al,7ch
call writechar
mov al,arrp1[esi]
cmp al,20h
je empty1
cmp al,58h
je order1
cmp al,24h
je dselect
cmp al,23h
je dselect
loop place1

empty1:
mov al,"E"
call writechar
inc esi
jmp place1
order1:
mov al,"X"
call writechar
inc esi
jmp place1

movie22:
cmp icache[1],31h
je decx3
cmp icache[1],32h
je decx4
decx3:
mov esi,0
jmp movie2t
decx4:
mov esi,11
jmp movie2t

movie2t:
mov ecx,30
mov ebx,0
movie2t2:
mov al,arrd2[esi]
cmp al,23h
je dcache2
cmp al,24h
je dcache2
mov dcache[ebx],al
inc esi
inc ebx
loop movie2t2

dcache2:
call clrscr
lea edx,arrn2[2]
call writestring
lea edx,tab3
call writestring
lea edx,dcache
call writestring
lea edx,tab3
call writestring
lea edx,arrt2
call writestring
lea edx,msg15
call writestring
call crlf

cmp icache[1],31h
je mesi3
cmp icache[1],32h
je mesi4

mesi3:
mov esi,0
jmp pplace2
mesi4:
mov esi,7
jmp pplace2

pplace2:
mov ecx,6
place2:
mov al,7ch
call writechar
mov al,arrp2[esi]
cmp al,20h
je empty2
cmp al,58h
je order2
cmp al,24h
je dselect
cmp al,23h
je dselect
loop place2

empty2:
mov al,"E"
call writechar
inc esi
jmp place2
order2:
mov al,"X"
call writechar
inc esi
jmp place2

movie33:
cmp icache[1],31h
je decx5
cmp icache[1],32h
je decx6
decx5:
mov esi,0
jmp movie3t
decx6:
mov esi,11
jmp movie3t

movie3t:
mov ecx,30
mov ebx,0
movie3t3:
mov al,arrd3[esi]
cmp al,23h
je dcache3
cmp al,24h
je dcache3
mov dcache[ebx],al
inc esi
inc ebx
loop movie3t3

dcache3:
call clrscr
lea edx,arrn3[2]
call writestring
lea edx,tab3
call writestring
lea edx,dcache
call writestring
lea edx,tab3
call writestring
lea edx,arrt3
call writestring
lea edx,msg15
call writestring
call crlf

cmp icache[1],31h
je mesi5
cmp icache[1],32h
je mesi6

mesi5:
mov esi,0
jmp pplace3
mesi6:
mov esi,7
jmp pplace3

pplace3:
mov ecx,6
place3:
mov al,7ch
call writechar
mov al,arrp3[esi]
cmp al,20h
je empty3
cmp al,58h
je order3
cmp al,24h
je dselect
cmp al,23h
je dselect
loop place3

empty3:
mov al,"E"
call writechar
inc esi
jmp place3
order3:
mov al,"X"
call writechar
inc esi
jmp place3

movie44:
cmp icache[1],31h
je decx7
cmp icache[1],32h
je decx8
decx7:
mov esi,0
jmp movie4t
decx8:
mov esi,11
jmp movie4t

movie4t:
mov ecx,30
mov ebx,0
movie4t4:
mov al,arrd4[esi]
cmp al,23h
je dcache4
cmp al,24h
je dcache4
mov dcache[ebx],al
inc esi
inc ebx
loop movie4t4

dcache4:
call clrscr
lea edx,arrn4[2]
call writestring
lea edx,tab3
call writestring
lea edx,dcache
call writestring
lea edx,tab3
call writestring
lea edx,arrt4
call writestring
lea edx,msg15
call writestring
call crlf

cmp icache[1],31h
je mesi7
cmp icache[1],32h
je mesi8

mesi7:
mov esi,0
jmp pplace4
mesi8:
mov esi,7
jmp pplace4

pplace4:
mov ecx,6
place4:
mov al,7ch
call writechar
mov al,arrp4[esi]
cmp al,20h
je empty4
cmp al,58h
je order4
cmp al,24h
je dselect
cmp al,23h
je dselect
loop place4

empty4:
mov al,"E"
call writechar
inc esi
jmp place4
order4:
mov al,"X"
call writechar
inc esi
jmp place4

movie55:
cmp icache[1],31h
je decx9
cmp icache[1],32h
je decx10
decx9:
mov esi,0
jmp movie5t
decx10:
mov esi,11
jmp movie5t

movie5t:
mov ecx,30
mov ebx,0
movie5t5:
mov al,arrd5[esi]
cmp al,23h
je dcache5
cmp al,24h
je dcache5
mov dcache[ebx],al
inc esi
inc ebx
loop movie5t5

dcache5:
call clrscr
lea edx,arrn5[2]
call writestring
lea edx,tab3
call writestring
lea edx,dcache
call writestring
lea edx,tab3
call writestring
lea edx,arrt5
call writestring
lea edx,msg15
call writestring
call crlf

cmp icache[1],31h
je mesi9
cmp icache[1],32h
je mesi10

mesi9:
mov esi,0
jmp pplace5
mesi10:
mov esi,7
jmp pplace5

pplace5:
mov ecx,6
place5:
mov al,7ch
call writechar
mov al,arrp5[esi]
cmp al,20h
je empty5
cmp al,58h
je order5
cmp al,24h
je dselect
cmp al,23h
je dselect
loop place5

empty5:
mov al,"E"
call writechar
inc esi
jmp place5
order5:
mov al,"X"
call writechar
inc esi
jmp place5

movie66:
cmp icache[1],31h
je decx11
cmp icache[1],32h
je decx12
decx11:
mov esi,0
jmp movie6t
decx12:
mov esi,11
jmp movie6t

movie6t:
mov ecx,30
mov ebx,0
movie6t6:
mov al,arrd6[esi]
cmp al,23h
je dcache6
cmp al,24h
je dcache6
mov dcache[ebx],al
inc esi
inc ebx
loop movie6t6

dcache6:
call clrscr
lea edx,arrn6[2]
call writestring
lea edx,tab3
call writestring
lea edx,dcache
call writestring
lea edx,tab3
call writestring
lea edx,arrt6
call writestring
lea edx,msg15
call writestring
call crlf

cmp icache[1],31h
je mesi11
cmp icache[1],32h
je mesi12

mesi11:
mov esi,0
jmp pplace6
mesi12:
mov esi,7
jmp pplace6

pplace6:
mov ecx,6
place6:
mov al,7ch
call writechar
mov al,arrp6[esi]
cmp al,20h
je empty6
cmp al,58h
je order6
cmp al,24h
je dselect
cmp al,23h
je dselect
loop place6

empty6:
mov al,"E"
call writechar
inc esi
jmp place6
order6:
mov al,"X"
call writechar
inc esi
jmp place6

movie77:
cmp icache[1],31h
je decx13
cmp icache[1],32h
je decx14
decx13:
mov esi,0
jmp movie7t
decx14:
mov esi,11
jmp movie7t

movie7t:
mov ecx,30
mov ebx,0
movie7t7:
mov al,arrd7[esi]
cmp al,23h
je dcache7
cmp al,24h
je dcache7
mov dcache[ebx],al
inc esi
inc ebx
loop movie7t7

dcache7:
call clrscr
lea edx,arrn7[2]
call writestring
lea edx,tab3
call writestring
lea edx,dcache
call writestring
lea edx,tab3
call writestring
lea edx,arrt7
call writestring
lea edx,msg15
call writestring
call crlf

cmp icache[1],31h
je mesi13
cmp icache[1],32h
je mesi14

mesi13:
mov esi,0
jmp pplace7
mesi14:
mov esi,7
jmp pplace7

pplace7:
mov ecx,6
place7:
mov al,7ch
call writechar
mov al,arrp7[esi]
cmp al,20h
je empty7
cmp al,58h
je order7
cmp al,24h
je dselect
cmp al,23h
je dselect
loop place7

empty7:
mov al,"E"
call writechar
inc esi
jmp place7
order7:
mov al,"X"
call writechar
inc esi
jmp place7


movie88:
cmp icache[1],31h
je decx15
cmp icache[1],32h
je decx16
decx15:
mov esi,0
jmp movie8t
decx16:
mov esi,11
jmp movie8t

movie8t:
mov ecx,30
mov ebx,0
movie8t8:
mov al,arrd8[esi]
cmp al,23h
je dcache8
cmp al,24h
je dcache8
mov dcache[ebx],al
inc esi
inc ebx
loop movie8t8

dcache8:
call clrscr
lea edx,arrn8[2]
call writestring
lea edx,tab3
call writestring
lea edx,dcache
call writestring
lea edx,tab3
call writestring
lea edx,arrt8
call writestring
lea edx,msg15
call writestring
call crlf

cmp icache[1],31h
je mesi15
cmp icache[1],32h
je mesi16

mesi15:
mov esi,0
jmp pplace8
mesi16:
mov esi,7
jmp pplace8

pplace8:
mov ecx,6
place8:
mov al,7ch
call writechar
mov al,arrp8[esi]
cmp al,20h
je empty8
cmp al,58h
je order8
cmp al,24h
je dselect
cmp al,23h
je dselect
loop place8

empty8:
mov al,"E"
call writechar
inc esi
jmp place8
order8:
mov al,"X"
call writechar
inc esi
jmp place8

dselect:
lea edx,msg15
call writeString
lea edx,msg14
call writeString
mov edx,OFFSET place
mov ecx,MAX
call ReadString
call writechar
call isDigit
mov icache[2],al
;mov testcache,al
jmp choice1

choice1:
call crlf
lea edx,msg20
call writeString
call crlf
lea edx,msg21
call writeString
call readInt
cmp eax,5
jl no
jge choice2

no:
call crlf
lea edx,msg23
call writeString
call crlf
jmp choice1

choice2:
sub eax, 5
mov pay,eax
call crlf
lea edx,msg22
call writeString
call writeDec
call readChar
mov eax,count
add eax,1
mov count,eax
call crlf
lea edx,icache
;call writestring
call crlf
sub eax,eax
sub ah,ah
sub al,al
sub ax,ax
mov al,icache[2]
;call writechar
call crlf
mov al,select
cmp al,31h
je bmovie111
cmp al,32h
je bmovie222
cmp al,33h
je bmovie333
cmp al,34h
je bmovie444
cmp al,35h
je bmovie555
cmp al,36h
je bmovie666
cmp al,37h
je bmovie777
cmp al,38h
je bmovie888
jne choice1

bmovie111:
call clrscr
lea edx,receipt1
call writeString
lea edx,receipt2
call writeString
lea edx,receipt1
call writeString

lea edx,receipt3
call writeString
lea edx,arrn1
call writeString

lea edx,receipt4
call writeString
lea edx,time
call writeString
lea edx,receipt5
call writeString
lea edx,arrt1
call writeString

lea edx,receipt6
call writeString
lea edx,place
call writeString
call crlf
lea edx,receipt1
call writeString
lea edx,receipt7
call writeString

call readChar
call clrscr

cmp icache[1],31H
je bmovie1
cmp icache[1],"2"
je bmovie2


bmovie1:
cmp icache[2],31h
je bmovie11
cmp icache[2],32h
je bmovie12
cmp icache[2],33h
je bmovie13
cmp icache[2],34h
je bmovie14
cmp icache[2],35h
je bmovie15
cmp icache[2],36h
je bmovie16

bmovie11:
mov arrp1[0],58H
jmp Start

bmovie12:
mov arrp1[1],58H
jmp Start

bmovie13:
mov arrp1[2],58H
jmp Start

bmovie14:
mov arrp1[3],58H
jmp Start

bmovie15:
mov arrp1[4],58H
jmp Start

bmovie16:
mov arrp1[5],58H
jmp Start


bmovie2:
mov al,icache[2]
cmp icache[2],31h
je bmovie21
cmp icache[2],32h
je bmovie22
cmp icache[2],33h
je bmovie23
cmp icache[2],34h
je bmovie24
cmp icache[2],35h
je bmovie25
cmp icache[2],36h
je bmovie26

bmovie21:
mov arrp1[7],58H
jmp Start

bmovie22:
mov arrp1[8],58H
jmp Start

bmovie23:
mov arrp1[9],58H
jmp Start

bmovie24:
mov arrp1[10],58H
jmp Start

bmovie25:
mov arrp1[11],58H
jmp Start

bmovie26:
mov arrp1[12],58H
jmp Start


bmovie222:
call clrscr
lea edx,receipt1
call writeString
lea edx,receipt2
call writeString
lea edx,receipt1
call writeString

lea edx,receipt3
call writeString
lea edx,arrn2
call writeString

lea edx,receipt4
call writeString
lea edx,time
call writeString
lea edx,receipt5
call writeString
lea edx,arrt2
call writeString

lea edx,receipt6
call writeString
lea edx,place
call writeString
call crlf
lea edx,receipt1
call writeString
lea edx,receipt7
call writeString

call readChar
call clrscr

cmp icache[1],31H
je bmovie3
cmp icache[1],32H
je bmovie4


bmovie3:
cmp icache[2],31h
je bmovie31
cmp icache[2],32h
je bmovie32
cmp icache[2],33h
je bmovie33
cmp icache[2],34h
je bmovie34
cmp icache[2],35h
je bmovie35
cmp icache[2],36h
je bmovie36

bmovie31:
mov arrp2[0],58H
jmp Start

bmovie32:
mov arrp2[1],58H
jmp Start

bmovie33:
mov arrp2[2],58H
jmp Start

bmovie34:
mov arrp2[3],58H
jmp Start

bmovie35:
mov arrp2[4],58H
jmp Start

bmovie36:
mov arrp2[5],58H
jmp Start


bmovie4:
cmp icache[2],31h
je bmovie41
cmp icache[2],32h
je bmovie42
cmp icache[2],33h
je bmovie43
cmp icache[2],34h
je bmovie44
cmp icache[2],35h
je bmovie45
cmp icache[2],36h
je bmovie46

bmovie41:
mov arrp2[7],58H
jmp Start

bmovie42:
mov arrp2[8],58H
jmp Start

bmovie43:
mov arrp2[9],58H
jmp Start

bmovie44:
mov arrp2[10],58H
jmp Start

bmovie45:
mov arrp2[11],58H
jmp Start

bmovie46:
mov arrp2[12],58H
jmp Start


bmovie333:
call clrscr
lea edx,receipt1
call writeString
lea edx,receipt2
call writeString
lea edx,receipt1
call writeString

lea edx,receipt3
call writeString
lea edx,arrn3
call writeString

lea edx,receipt4
call writeString
lea edx,time
call writeString
lea edx,receipt5
call writeString
lea edx,arrt3
call writeString

lea edx,receipt6
call writeString
lea edx,place
call writeString
call crlf
lea edx,receipt1
call writeString
lea edx,receipt7
call writeString

call readChar
call clrscr

cmp icache[1],31H
je bmovie5
cmp icache[1],32H
je bmovie6


bmovie5:
cmp icache[2],31h
je bmovie51
cmp icache[2],32h
je bmovie52
cmp icache[2],33h
je bmovie53
cmp icache[2],34h
je bmovie54
cmp icache[2],35h
je bmovie55
cmp icache[2],36h
je bmovie56

bmovie51:
mov arrp3[0],58H
jmp Start

bmovie52:
mov arrp3[1],58H
jmp Start

bmovie53:
mov arrp3[2],58H
jmp Start

bmovie54:
mov arrp3[3],58H
jmp Start

bmovie55:
mov arrp3[4],58H
jmp Start

bmovie56:
mov arrp3[5],58H
jmp Start


bmovie6:
cmp icache[2],31h
je bmovie61
cmp icache[2],32h
je bmovie62
cmp icache[2],33h
je bmovie63
cmp icache[2],34h
je bmovie64
cmp icache[2],35h
je bmovie65
cmp icache[2],36h
je bmovie66

bmovie61:
mov arrp3[7],58H
jmp Start

bmovie62:
mov arrp3[8],58H
jmp Start

bmovie63:
mov arrp3[9],58H
jmp Start

bmovie64:
mov arrp3[10],58H
jmp Start

bmovie65:
mov arrp3[11],58H
jmp Start

bmovie66:
mov arrp3[12],58H
jmp Start


bmovie444:
call clrscr
lea edx,receipt1
call writeString
lea edx,receipt2
call writeString
lea edx,receipt1
call writeString

lea edx,receipt3
call writeString
lea edx,arrn4
call writeString

lea edx,receipt4
call writeString
lea edx,time
call writeString
lea edx,receipt5
call writeString
lea edx,arrt4
call writeString

lea edx,receipt6
call writeString
lea edx,place
call writeString
call crlf
lea edx,receipt1
call writeString
lea edx,receipt7
call writeString

call readChar
call clrscr

cmp icache[1],31H
je bmovie7
cmp icache[1],32H
je bmovie8


bmovie7:
cmp icache[2],31h
je bmovie71
cmp icache[2],32h
je bmovie72
cmp icache[2],33h
je bmovie73
cmp icache[2],34h
je bmovie74
cmp icache[2],35h
je bmovie75
cmp icache[2],36h
je bmovie76

bmovie71:
mov arrp4[0],58H
jmp Start

bmovie72:
mov arrp4[1],58H
jmp Start

bmovie73:
mov arrp4[2],58H
jmp Start

bmovie74:
mov arrp4[3],58H
jmp Start

bmovie75:
mov arrp4[4],58H
jmp Start

bmovie76:
mov arrp4[5],58H
jmp Start


bmovie8:
cmp icache[2],31h
je bmovie81
cmp icache[2],32h
je bmovie82
cmp icache[2],33h
je bmovie83
cmp icache[2],34h
je bmovie84
cmp icache[2],35h
je bmovie85
cmp icache[2],36h
je bmovie86

bmovie81:
mov arrp4[7],58H
jmp Start

bmovie82:
mov arrp4[8],58H
jmp Start

bmovie83:
mov arrp4[9],58H
jmp Start

bmovie84:
mov arrp4[10],58H
jmp Start

bmovie85:
mov arrp4[11],58H
jmp Start

bmovie86:
mov arrp4[12],58H
jmp Start


bmovie555:
call clrscr
lea edx,receipt1
call writeString
lea edx,receipt2
call writeString
lea edx,receipt1
call writeString

lea edx,receipt3
call writeString
lea edx,arrn5
call writeString

lea edx,receipt4
call writeString
lea edx,time
call writeString
lea edx,receipt5
call writeString
lea edx,arrt5
call writeString

lea edx,receipt6
call writeString
lea edx,place
call writeString
call crlf
lea edx,receipt1
call writeString
lea edx,receipt7
call writeString

call readChar
call clrscr

cmp icache[1],31H
je bmovie01
cmp icache[1],32H
je bmovie02


bmovie01:
cmp icache[2],31h
je bmovie91
cmp icache[2],32h
je bmovie92
cmp icache[2],33h
je bmovie93
cmp icache[2],34h
je bmovie94
cmp icache[2],35h
je bmovie95
cmp icache[2],36h
je bmovie96

bmovie91:
mov arrp5[0],58H
jmp Start

bmovie92:
mov arrp5[1],58H
jmp Start

bmovie93:
mov arrp5[2],58H
jmp Start

bmovie94:
mov arrp5[3],58H
jmp Start

bmovie95:
mov arrp5[4],58H
jmp Start

bmovie96:
mov arrp5[5],58H
jmp Start


bmovie02:
cmp icache[2],31h
je bmovie101
cmp icache[2],32h
je bmovie102
cmp icache[2],33h
je bmovie103
cmp icache[2],34h
je bmovie104
cmp icache[2],35h
je bmovie105
cmp icache[2],36h
je bmovie106

bmovie101:
mov arrp5[7],58H
jmp Start

bmovie102:
mov arrp5[8],58H
jmp Start

bmovie103:
mov arrp5[9],58H
jmp Start

bmovie104:
mov arrp5[10],58H
jmp Start

bmovie105:
mov arrp5[11],58H
jmp Start

bmovie106:
mov arrp5[12],58H
jmp Start


bmovie666:
call clrscr
lea edx,receipt1
call writeString
lea edx,receipt2
call writeString
lea edx,receipt1
call writeString

lea edx,receipt3
call writeString
lea edx,arrn6
call writeString

lea edx,receipt4
call writeString
lea edx,time
call writeString
lea edx,receipt5
call writeString
lea edx,arrt6
call writeString

lea edx,receipt6
call writeString
lea edx,place
call writeString
call crlf
lea edx,receipt1
call writeString
lea edx,receipt7
call writeString

call readChar
call clrscr

cmp icache[1],31H
je bmovie03
cmp icache[1],32H
je bmovie04

bmovie03:
cmp icache[2],31h
je bmovie001
cmp icache[2],32h
je bmovie002
cmp icache[2],33h
je bmovie003
cmp icache[2],34h
je bmovie004
cmp icache[2],35h
je bmovie005
cmp icache[2],36h
je bmovie006

bmovie001:
mov arrp6[0],58H
jmp Start

bmovie002:
mov arrp6[1],58H
jmp Start

bmovie003:
mov arrp6[2],58H
jmp Start

bmovie004:
mov arrp6[3],58H
jmp Start

bmovie005:
mov arrp6[4],58H
jmp Start

bmovie006:
mov arrp6[5],58H
jmp Start


bmovie04:
cmp icache[2],31h
je bmovie011
cmp icache[2],32h
je bmovie012
cmp icache[2],33h
je bmovie013
cmp icache[2],34h
je bmovie014
cmp icache[2],35h
je bmovie015
cmp icache[2],36h
je bmovie016

bmovie011:
mov arrp6[7],58H
jmp Start

bmovie012:
mov arrp6[8],58H
jmp Start

bmovie013:
mov arrp6[9],58H
jmp Start

bmovie014:
mov arrp6[10],58H
jmp Start

bmovie015:
mov arrp6[11],58H
jmp Start

bmovie016:
mov arrp6[12],58H
jmp Start


bmovie777:
call clrscr
lea edx,receipt1
call writeString
lea edx,receipt2
call writeString
lea edx,receipt1
call writeString

lea edx,receipt3
call writeString
lea edx,arrn7
call writeString

lea edx,receipt4
call writeString
lea edx,time
call writeString
lea edx,receipt5
call writeString
lea edx,arrt7
call writeString

lea edx,receipt6
call writeString
lea edx,place
call writeString
call crlf
lea edx,receipt1
call writeString
lea edx,receipt7
call writeString

call readChar
call clrscr

cmp icache[1],31H
je bmovie05
cmp icache[1],32H
je bmovie06

bmovie05:
cmp icache[2],31h
je bmovie0001
cmp icache[2],32h
je bmovie0002
cmp icache[2],33h
je bmovie0003
cmp icache[2],34h
je bmovie0004
cmp icache[2],35h
je bmovie0005
cmp icache[2],36h
je bmovie0006

bmovie0001:
mov arrp7[0],58H
jmp Start

bmovie0002:
mov arrp7[1],58H
jmp Start

bmovie0003:
mov arrp7[2],58H
jmp Start

bmovie0004:
mov arrp7[3],58H
jmp Start

bmovie0005:
mov arrp7[4],58H
jmp Start

bmovie0006:
mov arrp7[5],58H
jmp Start


bmovie06:
cmp icache[2],31h
je bmovie017
cmp icache[2],32h
je bmovie018
cmp icache[2],33h
je bmovie019
cmp icache[2],34h
je bmovie020
cmp icache[2],35h
je bmovie021
cmp icache[2],36h
je bmovie022

bmovie017:
mov arrp7[7],58H
jmp Start

bmovie018:
mov arrp7[8],58H
jmp Start

bmovie019:
mov arrp7[9],58H
jmp Start

bmovie020:
mov arrp7[10],58H
jmp Start

bmovie021:
mov arrp7[11],58H
jmp Start

bmovie022:
mov arrp7[12],58H
jmp Start


bmovie888:
call clrscr
lea edx,receipt1
call writeString
lea edx,receipt2
call writeString
lea edx,receipt1
call writeString

lea edx,receipt3
call writeString
lea edx,arrn8
call writeString

lea edx,receipt4
call writeString
lea edx,time
call writeString
lea edx,receipt5
call writeString
lea edx,arrt8
call writeString

lea edx,receipt6
call writeString
lea edx,place
call writeString
call crlf
lea edx,receipt1
call writeString
lea edx,receipt7
call writeString

call readChar
call clrscr

cmp icache[1],31H
je bmovie07
cmp icache[1],32H
je bmovie08

bmovie07:
cmp icache[2],31h
je bmovie0007
cmp icache[2],32h
je bmovie0008
cmp icache[2],33h
je bmovie0009
cmp icache[2],34h
je bmovie0010
cmp icache[2],35h
je bmovie0011
cmp icache[2],36h
je bmovie0012

bmovie0007:
mov arrp8[0],58H
jmp Start

bmovie0008:
mov arrp8[1],58H
jmp Start

bmovie0009:
mov arrp8[2],58H
jmp Start

bmovie0010:
mov arrp8[3],58H
jmp Start

bmovie0011:
mov arrp8[4],58H
jmp Start

bmovie0012:
mov arrp8[5],58H
jmp Start


bmovie08:
cmp icache[2],31h
je bmovie023
cmp icache[2],32h
je bmovie024
cmp icache[2],33h
je bmovie025
cmp icache[2],34h
je bmovie026
cmp icache[2],35h
je bmovie027
cmp icache[2],36h
je bmovie028

bmovie023:
mov arrp8[7],58H
jmp Start

bmovie024:
mov arrp8[8],58H
jmp Start

bmovie025:
mov arrp8[9],58H
jmp Start

bmovie026:
mov arrp8[10],58H
jmp Start

bmovie027:
mov arrp8[11],58H
jmp Start

bmovie028:
mov arrp8[12],58H
jmp Start


SearchMovie:
	jmp mainpage

end1:
		call clrscr
		mov edx,OFFSET total1
		call WriteString
		mov eax,count
		call WriteDec
		mov edx,OFFSET total2
		call WriteString
		call Crlf
		mov edx,OFFSET thanks
		call WriteString

invoke ExitProcess, 0

main endp
end main