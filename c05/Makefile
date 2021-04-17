# 
run: c05_mbr.asm
	nasm c05_mbr.asm -o ipl.img
	qemu-system-i386 -hdd ipl.img

default:
	make run
