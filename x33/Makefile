
NAME := x33
ASM  := 64tass
VICE := x64

all: $(NAME).prg

$(NAME).prg: Makefile $(NAME).s
	
	$(ASM) -Wall -C -a --vice-labels -l $(NAME).l -o $(NAME).prg $(NAME).s
	@cat $(NAME).l | grep -e ' \.\([a-z0-9:_]\+:_\?\)\?break[a-z0-9_]*$$' | sed -r 's/^al ([0-9a-fA-F]+) .*$$/break \1/' >> $(NAME).l
	@stat --printf="$$(md5sum $(NAME).prg | awk '{print $$1}'), %s bytes\n" $(NAME).prg

run: $(NAME).prg
	$(VICE) -moncommands $(NAME).l -autostart $(NAME).prg

clean:
	rm -f *.l *.prg

