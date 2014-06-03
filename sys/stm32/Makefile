
# Programs that live in subdirectories, and have makefiles of their own.
#
SUBDIR		= baremetal

default:

all:
		-for i in $(SUBDIR); do make -C $$i all; done

install:

clean:
		-for i in $(SUBDIR); do make -C $$i clean; done
		find .. -name \*~ | xargs rm -f

reconfig:
		-for i in $(SUBDIR); do echo $$i; I=`echo $$i | awk '{print toupper($$0)}'`; (cd $$i; ../../../tools/configsys/config $$I); done
