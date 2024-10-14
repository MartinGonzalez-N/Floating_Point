#rtl

#fp16 open
../definitions/definitions.sv
../rtl/fp16/open/adder/add_normalizer.v
../rtl/fp16/open/adder/alignment.v
../rtl/fp16/open/adder/cla_nbit.v
../rtl/fp16/open/adder/int_fp_add.v
../rtl/fp16/open/mul/int_fp_mul.v
../rtl/fp16/open/mul/mul_normalizer.v
../rtl/fp16/open/mul/mul2x2.v
../rtl/fp16/open/mul/mul4x4.v
../rtl/fp16/open/mul/mul8x8.v
../rtl/fp16/open/mul/mul16x16.v
//bb fp
../rtl/bb_fp/adder.sv
../rtl/bb_fp/comp2.sv
../rtl/bb_fp/exp_diff.sv
../rtl/bb_fp/lzd.sv
../rtl/bb_fp/mag_comp.sv
../rtl/bb_fp/man_align.sv
../rtl/bb_fp/man_swap.sv
../rtl/bb_fp/norm.sv
../rtl/bb_fp/sign_ctrl.sv
../rtl/bb_fp/round.sv
../rtl/bb_fp/fp_add_naive.sv
//propio
../rtl/fp16/propio/fp16_add.sv
../rtl/fp16/propio/fp16_comp.sv
../rtl/fp16/propio/fp16_mult.sv

#misc
../rtl/misc/mult_16bits.v
../rtl/misc/mult_11bits.v
../rtl/misc/mult_nbits.v
../rtl/misc/adder_tree.v

#dv
../dv/tb_fp16.sv
../rtl/misc/mult_16bits_tb.sv
../rtl/misc/mult_nbits_tb.sv
../rtl/misc/adder_tree_tb.sv


../rtl/test.sv