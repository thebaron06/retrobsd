#==========================================
#    Makefile: makefile for adc-demo
#	Copyright 2012 Majenko Technolohies
#		(matt@majenko.co.uk
#	Last Modified: 29/01/2012
#==========================================

TOPSRC          = $(shell cd ../../..; pwd)
include $(TOPSRC)/target.mk

PWD             = $(shell pwd)
PROG            = $(shell basename "$(PWD)")

OBJS            = $(PROG).o
SRCS            = $(PROG).c

all:            $(PROG)

-include Makefile.app

$(PROG):       ${OBJS}
		${CC} ${LDFLAGS} -o $(PROG).elf ${OBJS} ${LIBS}
		${OBJDUMP} -S $(PROG).elf > $(PROG).dis
		${SIZE} $(PROG).elf
		${ELF2AOUT} $(PROG).elf $@

clean:
		-rm -f $(PROG) ${OBJS} $(PROG).elf $(PROG).dis

install:        all
		install $(PROG) $(DESTDIR)/bin/
