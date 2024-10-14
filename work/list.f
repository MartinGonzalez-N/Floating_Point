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