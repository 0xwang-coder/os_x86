# 
boot.bin: c13_mbr.asm
	nasm c13_mbr.asm -o boot.bin -l boot.lst
ipl.sys: c13_core.asm boot.bin
	nasm c13_core.asm -o ipl.sys -l ipl.lst
app.sys: c13.asm ipl.sys
	nasm c13.asm -o app.sys -l app.lst

ipl.img: boot.bin ipl.sys app.sys Makefile
	FixVhdWr -r boot.bin -a 0 -w ./os.vhd
	FixVhdWr -r ipl.sys -a 1 -w ./os.vhd
	FixVhdWr -r app.sys -a 50 -w ./os.vhd

# 
default:
	make run
img: 
	cp ../os.vhd ./
	make -r ipl.img
run:
	make img
	qemu-system-i386 os.vhd
