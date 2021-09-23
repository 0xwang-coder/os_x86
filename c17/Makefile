# 
boot.bin: c17_mbr.asm
	nasm c17_mbr.asm -o boot.bin -l boot.lst
ipl.sys: c17_core.asm boot.bin
	nasm c17_core.asm -o ipl.sys -l ipl.lst
app.sys: c17-1.asm ipl.sys
	nasm c17-1.asm -o app.sys -l app.lst
app2.sys: c17-2.asm ipl.sys
	nasm c17-2.asm -o app2.sys -l app2.lst

ipl.img: boot.bin ipl.sys app.sys app2.sys Makefile
	FixVhdWr -r boot.bin -a 0 -w ./os.vhd
	FixVhdWr -r ipl.sys -a 1 -w ./os.vhd
	FixVhdWr -r app.sys -a 50 -w ./os.vhd
	FixVhdWr -r app2.sys -a 100 -w ./os.vhd

# 
default:
	make run
img: 
	cp ../os.vhd ./
	make -r ipl.img
run:
	make img
	qemu-system-i386 os.vhd
