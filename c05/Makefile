# 
boot.bin: c05_mbr.asm
	nasm c05_mbr.asm -o boot.bin -l boot.lst

ipl.img: boot.bin Makefile
	mformat -f 1440 -C -B boot.bin -i ipl.img :: 

# 
run: c05_mbr.asm
	qemu-system-i386 -hdd ipl.img

default:
	make run
