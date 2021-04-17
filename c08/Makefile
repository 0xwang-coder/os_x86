# 
boot.bin: c08_mbr.asm
	nasm c08_mbr.asm -o boot.bin -l boot.lst
ipl.sys: c08.asm
	nasm c08.asm -o ipl.sys -l ipl.lst

ipl.img: boot.bin ipl.sys Makefile
	dd if=boot.bin of=ipl.img bs=512 count=1
	# mformat -f 1440 -C -B boot.bin -i ipl.img :: 
	dd if=ipl.sys of=ipl.img bs=512 seek=100
	# mcopy ipl.sys -i ipl.img :: 

# 
default:
	make run
img: 
	make -r ipl.img
run:
	make img
	qemu-system-i386 -fda ipl.img 
