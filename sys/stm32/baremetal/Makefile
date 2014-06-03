BUILDPATH = ../../../tools/configsys/../../sys/stm32
H         = ../../../tools/configsys/../../sys/include
M         = ../../../tools/configsys/../../sys/stm32
S         = ../../../tools/configsys/../../sys/kernel

vpath %.c $(M):$(S)
vpath %.S $(M):$(S)

KERNOBJ += _startup_stm32f4xx.o clock.o devsw.o exception.o exec_aout.o exec_conf.o exec_elf.o exec_script.o exec_subr.o init_main.o init_sysent.o kern_clock.o kern_descrip.o kern_exec.o kern_exit.o kern_fork.o kern_mman.o kern_proc.o kern_prot.o kern_prot2.o kern_resource.o kern_sig.o kern_sig2.o kern_subr.o kern_synch.o kern_sysctl.o kern_time.o machdep.o mem.o signal.o subr_prf.o subr_rmap.o swap.o sys_generic.o sys_inode.o sys_pipe.o sys_process.o syscalls.o sysctl.o vers.o vfs_vnops.o vm_sched.o vm_swap.o vm_swp.o 
EXTRA_TARGETS = 

DEFS += -DBUS_KHZ=168000
DEFS += -DCPU_KHZ=168000
DEFS += -DEXEC_AOUT
DEFS += -DEXEC_ELF
DEFS += -DEXEC_SCRIPT
DEFS += -DKERNEL
DEFS += -DSTM32F4xx
DEFS += -DUCB_METER


LDSCRIPT = ../../../tools/configsys/../../sys/stm32/cfg/bare.ld

CONFIG = BAREMETAL
CONFIGPATH = ../../../tools/configsys

include ../../../tools/configsys/../../sys/stm32/kernel-post.mk
