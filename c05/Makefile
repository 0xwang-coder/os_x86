# 
boot.bin: c05_mbr.asm
	nasm c05_mbr.asm -o boot.bin -l boot.lst

ipl.img: boot.bin Makefile
	FixVhdWr -r boot.bin -a 0 -w ./os.vhd

# 
default:
	make run
img: 
	cp ../os.vhd ./
	make -r ipl.img
run:
	make img
	qemu-system-i386 os.vhd
