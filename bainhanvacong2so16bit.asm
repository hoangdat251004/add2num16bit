.model small
.stack 100h
.data
        msg1 db          ' a = $'
        msg2 db 13,10,   ' b = $'
        msg3 db 13,10,   ' tich 2 so la : $'
        num1 db 0
        num2 db 0
        
.code

main proc
    
    mov ax,@data          ; lay dai chi vung data
    mov ds,ax  
;----------------------------------------------------------;   
    Lea dx,msg1           ; thong bao nhap so thu nhat
    mov ah,9
    int 21h
    
    input1:               ; nhan co ten input1
        mov ah,1h         ; bao nguoi dung nhap 
        int 21h           ;
        
        cmp aL,13         ; so sanh al voi 13 ,13 la phim enter giong nhu \n
        je input2         ; neu nhan enter thi nhay input2
        
        sub al,48         ; chuyen thanh ku tu so
        mov dL,aL         ; luu gia tri tai aL vao dL
        
        mov aL,num1       ; gan gia tri num1 vao aL
        mov bL,10         ; gan 10 vao bL
        
        MUL BL            ; nhan aL voi bL, bL dang bang 10
        ADD AL,DL         ; lay ket qua vua nhan cong voi 1
        mov num1,AL       ; luu gia tri vua cong vao bien num1

    jmp input1
    
    input2:

        LEA dx,msg2       
        mov ah,9
        int 21h

        nhap:
            mov ah,1
            int 21h 
            
            cmp aL,13
            je multip
            
            sub aL,48 
            mov dL,aL
            
            mov aL,num2
            mov bL,10  
            
            MUL bL
            ADD aL,dL
            mov num2,aL

        jmp nhap
        
multip: 
        mov aL,num1             ; dua 2 so vua nhap ra thanh ghi aL
        xor ah,ah            
        ;add aL,num2            ; lenh de cong 2 so
                    
        MUL num2                ; nhan voi so thu 2
        mov bx,ax               ; luu ket qua vao thanh ghi bx
        
        LEA dx,msg3
        mov ah,9                ; in ra tich vua nhan
        int 21h
        
        mov ax,bx                
        mov bx,10               
        xor cx,cx               ; xoa gia tri thanh ghi cx
        
        
        chia:                   ; tach so
            xor dx,dx           ; clear thanh ghi dx
            div bx              ; chi lay du de tach dua tung so len man hinh
            
            push dx             ; luu gia tri o dx vao dinh cua ngan xep
            inc cx              ; tang bien dem len 1
        cmp ax,0
        ja chia
        
        view:
            pop dx              ; lay gia tri dx o dinh ngan xep
            ADD dL,48           ; chuyen sang ma assci
            mov ah,2            ; hien thi ky tu len man hinh tu thanh ghi DL
            int 21h
        loop view
        
ra:
mov ah,4ch
int 21h
main endp   