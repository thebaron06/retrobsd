
# Linaro toolchain
# https://launchpad.net/gcc-arm-embedded/+milestone/4.6-2012-q4-update
ifndef GCCPREFIX
ifeq (/opt/linaro/arm-2013.11/bin/arm-none-linux-gnueabi-gcc,$(wildcard /opt/linaro/arm-2013.11/bin/arm-none-linux-gnueabi-gcc))
	GCCPREFIX   = /opt/linaro/arm-2013.11/bin/arm-none-linux-gnueabi-
	LDFLAGS     = -Wl,--oformat=elf32-littlearm
endif
endif


# Mentor Sourcery CodeBench Lite toolchain
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# You can download a Linux or Windows binary package from
# https://sourcery.mentor.com/
ifndef GCCPREFIX
ifeq (/opt/CodeSourcery/2013.11-33/bin/arm-none-linux-gnueabi-gcc,$(wildcard /opt/CodeSourcery/2013.11-33/bin/arm-none-linux-gnueabi-gcc))
	GCCPREFIX   = /opt/CodeSourcery/2013.11-33/bin/arm-none-linux-gnueabi-
	LDFLAGS     = -Wl,--oformat=elf32-littlearm
endif
endif

ifndef GCCPREFIX
    $(error Unable to locate any GCC ARM toolchain!)
endif
