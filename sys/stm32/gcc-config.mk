# Mentor Sourcery CodeBench Lite toolchain
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# You can download a Linux or Windows binary package from
# https://sourcery.mentor.com/
ifndef GCCPREFIX
    GCCPREFIX   = arm-none-linux-gnueabi-
    LDFLAGS     = -Wl,--oformat=elf32-littlearm
endif

ifndef GCCPREFIX
    $(error Unable to locate any GCC ARM toolchain!)
endif

