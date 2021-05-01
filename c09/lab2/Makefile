# 
boot.bin: mbr.asm
	nasm mbr.asm -o boot.bin -l boot.lst
ipl.sys: boot.bin
	nasm c09_2.asm -o ipl.sys -l ipl.lst

ipl.img: boot.bin ipl.sys Makefile
	FixVhdWr -r boot.bin -a 0 -w ./os.vhd
	FixVhdWr -r ipl.sys -a 100 -w ./os.vhd

# 
default:
	make run
img: 
	cp ../../os.vhd ./
	make -r ipl.img
run:
	make img
	qemu-system-i386 os.vhd
