LIBRARY sxlib_ModelSim;

entity vending_machinea_ln is
   port (
      ck         : in      bit;
      vdd        : in      bit;
      vss        : in      bit;
      reset      : in      bit;
      soft_drink : in      bit;
      juice      : in      bit;
      cancel     : in      bit;
      piasters   : in      bit_vector(1 downto 0);
      drink      : out     bit_vector(1 downto 0);
      change25   : out     bit;
      change50   : out     bit;
      change100  : out     bit
 );
end vending_machinea_ln;

architecture structural of vending_machinea_ln is
Component nxr2_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component on12_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component ao22_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component o2_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component noa22_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component an12_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component no4_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      i3  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component no2_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component sff1_x4
   port (
      ck  : in      bit;
      i   : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component oa22_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component a2_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component nao22_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component o4_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      i3  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component na2_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component o3_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component na3_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component inv_x2
   port (
      i   : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component no3_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

signal not_piasters                : bit_vector( 1 downto 0);
signal not_vending_machine_cs      : bit_vector( 0 downto 0);
signal vending_machine_cs          : bit_vector( 2 downto 0);
signal vending_machine_ns_s50      : bit;
signal oa22_x2_sig                 : bit;
signal o4_x2_sig                   : bit;
signal o4_x2_3_sig                 : bit;
signal o4_x2_2_sig                 : bit;
signal o3_x2_sig                   : bit;
signal o3_x2_4_sig                 : bit;
signal o3_x2_3_sig                 : bit;
signal o3_x2_2_sig                 : bit;
signal o2_x2_sig                   : bit;
signal o2_x2_3_sig                 : bit;
signal o2_x2_2_sig                 : bit;
signal nxr2_x1_sig                 : bit;
signal not_vending_machine_cs_s50  : bit;
signal not_vending_machine_cs_s25  : bit;
signal not_vending_machine_cs_s100 : bit;
signal not_vending_machine_cs_s0   : bit;
signal not_cancel                  : bit;
signal not_aux9                    : bit;
signal not_aux8                    : bit;
signal not_aux6                    : bit;
signal not_aux15                   : bit;
signal not_aux14                   : bit;
signal not_aux1                    : bit;
signal not_aux0                    : bit;
signal noa22_x1_sig                : bit;
signal noa22_x1_3_sig              : bit;
signal noa22_x1_2_sig              : bit;
signal no4_x1_sig                  : bit;
signal no4_x1_2_sig                : bit;
signal no3_x1_sig                  : bit;
signal no3_x1_3_sig                : bit;
signal no3_x1_2_sig                : bit;
signal no2_x1_sig                  : bit;
signal no2_x1_3_sig                : bit;
signal no2_x1_2_sig                : bit;
signal nao22_x1_sig                : bit;
signal nao22_x1_2_sig              : bit;
signal na3_x1_sig                  : bit;
signal na2_x1_sig                  : bit;
signal na2_x1_2_sig                : bit;
signal inv_x2_sig                  : bit;
signal inv_x2_4_sig                : bit;
signal inv_x2_3_sig                : bit;
signal inv_x2_2_sig                : bit;
signal aux14                       : bit;
signal aux12                       : bit;
signal aux11                       : bit;
signal aux1                        : bit;
signal aux0                        : bit;
signal ao22_x2_sig                 : bit;
signal an12_x1_sig                 : bit;
signal a2_x2_sig                   : bit;
signal a2_x2_3_sig                 : bit;
signal a2_x2_2_sig                 : bit;

begin

not_aux9_ins : no2_x1
   port map (
      i0  => cancel,
      i1  => not_aux1,
      nq  => not_aux9,
      vdd => vdd,
      vss => vss
   );

not_aux0_ins : inv_x2
   port map (
      i   => aux0,
      nq  => not_aux0,
      vdd => vdd,
      vss => vss
   );

na2_x1_ins : na2_x1
   port map (
      i0  => not_vending_machine_cs_s50,
      i1  => not_vending_machine_cs_s25,
      nq  => na2_x1_sig,
      vdd => vdd,
      vss => vss
   );

noa22_x1_ins : noa22_x1
   port map (
      i0  => na2_x1_sig,
      i1  => piasters(0),
      i2  => vending_machine_cs(0),
      nq  => noa22_x1_sig,
      vdd => vdd,
      vss => vss
   );

not_aux6_ins : ao22_x2
   port map (
      i0  => noa22_x1_sig,
      i1  => not_piasters(1),
      i2  => not_vending_machine_cs_s100,
      q   => not_aux6,
      vdd => vdd,
      vss => vss
   );

not_aux8_ins : o3_x2
   port map (
      i0  => not_piasters(0),
      i1  => not_aux1,
      i2  => not_piasters(1),
      q   => not_aux8,
      vdd => vdd,
      vss => vss
   );

nxr2_x1_ins : nxr2_x1
   port map (
      i0  => piasters(0),
      i1  => piasters(1),
      nq  => nxr2_x1_sig,
      vdd => vdd,
      vss => vss
   );

not_aux15_ins : on12_x1
   port map (
      i0  => nxr2_x1_sig,
      i1  => cancel,
      q   => not_aux15,
      vdd => vdd,
      vss => vss
   );

not_vending_machine_cs_s0_ins : o3_x2
   port map (
      i0  => vending_machine_cs(2),
      i1  => vending_machine_cs(1),
      i2  => vending_machine_cs(0),
      q   => not_vending_machine_cs_s0,
      vdd => vdd,
      vss => vss
   );

not_vending_machine_cs_s100_ins : on12_x1
   port map (
      i0  => vending_machine_cs(1),
      i1  => vending_machine_cs(2),
      q   => not_vending_machine_cs_s100,
      vdd => vdd,
      vss => vss
   );

not_vending_machine_cs_s50_ins : na2_x1
   port map (
      i0  => vending_machine_cs(2),
      i1  => vending_machine_cs(1),
      nq  => not_vending_machine_cs_s50,
      vdd => vdd,
      vss => vss
   );

not_aux14_ins : inv_x2
   port map (
      i   => aux14,
      nq  => not_aux14,
      vdd => vdd,
      vss => vss
   );

not_vending_machine_cs_s25_ins : on12_x1
   port map (
      i0  => vending_machine_cs(2),
      i1  => vending_machine_cs(1),
      q   => not_vending_machine_cs_s25,
      vdd => vdd,
      vss => vss
   );

not_vending_machine_cs_0_ins : inv_x2
   port map (
      i   => vending_machine_cs(0),
      nq  => not_vending_machine_cs(0),
      vdd => vdd,
      vss => vss
   );

not_aux1_ins : inv_x2
   port map (
      i   => aux1,
      nq  => not_aux1,
      vdd => vdd,
      vss => vss
   );

not_cancel_ins : inv_x2
   port map (
      i   => cancel,
      nq  => not_cancel,
      vdd => vdd,
      vss => vss
   );

not_piasters_1_ins : inv_x2
   port map (
      i   => piasters(1),
      nq  => not_piasters(1),
      vdd => vdd,
      vss => vss
   );

not_piasters_0_ins : inv_x2
   port map (
      i   => piasters(0),
      nq  => not_piasters(0),
      vdd => vdd,
      vss => vss
   );

aux14_ins : no2_x1
   port map (
      i0  => piasters(0),
      i1  => not_piasters(1),
      nq  => aux14,
      vdd => vdd,
      vss => vss
   );

aux12_ins : no2_x1
   port map (
      i0  => not_piasters(0),
      i1  => not_vending_machine_cs_s0,
      nq  => aux12,
      vdd => vdd,
      vss => vss
   );

aux11_ins : na2_x1
   port map (
      i0  => piasters(0),
      i1  => not_piasters(1),
      nq  => aux11,
      vdd => vdd,
      vss => vss
   );

aux1_ins : no2_x1
   port map (
      i0  => juice,
      i1  => soft_drink,
      nq  => aux1,
      vdd => vdd,
      vss => vss
   );

aux0_ins : no2_x1
   port map (
      i0  => piasters(0),
      i1  => piasters(1),
      nq  => aux0,
      vdd => vdd,
      vss => vss
   );

o4_x2_ins : o4_x2
   port map (
      i0  => soft_drink,
      i1  => juice,
      i2  => not_aux15,
      i3  => not_vending_machine_cs_s50,
      q   => o4_x2_sig,
      vdd => vdd,
      vss => vss
   );

o3_x2_ins : o3_x2
   port map (
      i0  => not_vending_machine_cs_s25,
      i1  => piasters(1),
      i2  => not_piasters(0),
      q   => o3_x2_sig,
      vdd => vdd,
      vss => vss
   );

o2_x2_ins : o2_x2
   port map (
      i0  => not_vending_machine_cs_s0,
      i1  => not_aux14,
      q   => o2_x2_sig,
      vdd => vdd,
      vss => vss
   );

vending_machine_ns_s50_ins : na3_x1
   port map (
      i0  => o2_x2_sig,
      i1  => o3_x2_sig,
      i2  => o4_x2_sig,
      nq  => vending_machine_ns_s50,
      vdd => vdd,
      vss => vss
   );

o3_x2_2_ins : o3_x2
   port map (
      i0  => not_vending_machine_cs_s50,
      i1  => piasters(1),
      i2  => not_piasters(0),
      q   => o3_x2_2_sig,
      vdd => vdd,
      vss => vss
   );

ao22_x2_ins : ao22_x2
   port map (
      i0  => not_vending_machine_cs_s25,
      i1  => not_aux14,
      i2  => o3_x2_2_sig,
      q   => ao22_x2_sig,
      vdd => vdd,
      vss => vss
   );

inv_x2_ins : inv_x2
   port map (
      i   => aux11,
      nq  => inv_x2_sig,
      vdd => vdd,
      vss => vss
   );

o3_x2_3_ins : o3_x2
   port map (
      i0  => cancel,
      i1  => not_aux1,
      i2  => inv_x2_sig,
      q   => o3_x2_3_sig,
      vdd => vdd,
      vss => vss
   );

o2_x2_2_ins : o2_x2
   port map (
      i0  => not_vending_machine_cs(0),
      i1  => o3_x2_3_sig,
      q   => o2_x2_2_sig,
      vdd => vdd,
      vss => vss
   );

noa22_x1_2_ins : noa22_x1
   port map (
      i0  => o2_x2_2_sig,
      i1  => ao22_x2_sig,
      i2  => reset,
      nq  => noa22_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

vending_machine_cs_0_ins : sff1_x4
   port map (
      ck  => ck,
      i   => noa22_x1_2_sig,
      q   => vending_machine_cs(0),
      vdd => vdd,
      vss => vss
   );

no3_x1_ins : no3_x1
   port map (
      i0  => not_aux1,
      i1  => not_vending_machine_cs_s100,
      i2  => cancel,
      nq  => no3_x1_sig,
      vdd => vdd,
      vss => vss
   );

o2_x2_3_ins : o2_x2
   port map (
      i0  => piasters(0),
      i1  => not_vending_machine_cs_s50,
      q   => o2_x2_3_sig,
      vdd => vdd,
      vss => vss
   );

inv_x2_2_ins : inv_x2
   port map (
      i   => aux12,
      nq  => inv_x2_2_sig,
      vdd => vdd,
      vss => vss
   );

noa22_x1_3_ins : noa22_x1
   port map (
      i0  => inv_x2_2_sig,
      i1  => o2_x2_3_sig,
      i2  => not_piasters(1),
      nq  => noa22_x1_3_sig,
      vdd => vdd,
      vss => vss
   );

no2_x1_2_ins : no2_x1
   port map (
      i0  => aux11,
      i1  => not_vending_machine_cs(0),
      nq  => no2_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

no4_x1_ins : no4_x1
   port map (
      i0  => no2_x1_2_sig,
      i1  => vending_machine_ns_s50,
      i2  => noa22_x1_3_sig,
      i3  => no3_x1_sig,
      nq  => no4_x1_sig,
      vdd => vdd,
      vss => vss
   );

no2_x1_ins : no2_x1
   port map (
      i0  => reset,
      i1  => no4_x1_sig,
      nq  => no2_x1_sig,
      vdd => vdd,
      vss => vss
   );

vending_machine_cs_1_ins : sff1_x4
   port map (
      ck  => ck,
      i   => no2_x1_sig,
      q   => vending_machine_cs(1),
      vdd => vdd,
      vss => vss
   );

no3_x1_2_ins : no3_x1
   port map (
      i0  => not_cancel,
      i1  => not_aux8,
      i2  => not_vending_machine_cs_s100,
      nq  => no3_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

an12_x1_ins : an12_x1
   port map (
      i0  => piasters(1),
      i1  => aux12,
      q   => an12_x1_sig,
      vdd => vdd,
      vss => vss
   );

no3_x1_3_ins : no3_x1
   port map (
      i0  => not_aux1,
      i1  => not_aux15,
      i2  => not_vending_machine_cs_s25,
      nq  => no3_x1_3_sig,
      vdd => vdd,
      vss => vss
   );

no4_x1_2_ins : no4_x1
   port map (
      i0  => no3_x1_3_sig,
      i1  => an12_x1_sig,
      i2  => vending_machine_ns_s50,
      i3  => no3_x1_2_sig,
      nq  => no4_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

no2_x1_3_ins : no2_x1
   port map (
      i0  => reset,
      i1  => no4_x1_2_sig,
      nq  => no2_x1_3_sig,
      vdd => vdd,
      vss => vss
   );

vending_machine_cs_2_ins : sff1_x4
   port map (
      ck  => ck,
      i   => no2_x1_3_sig,
      q   => vending_machine_cs(2),
      vdd => vdd,
      vss => vss
   );

a2_x2_ins : a2_x2
   port map (
      i0  => not_aux1,
      i1  => not_aux0,
      q   => a2_x2_sig,
      vdd => vdd,
      vss => vss
   );

change100_ins : no3_x1
   port map (
      i0  => a2_x2_sig,
      i1  => not_aux6,
      i2  => not_cancel,
      nq  => change100,
      vdd => vdd,
      vss => vss
   );

a2_x2_2_ins : a2_x2
   port map (
      i0  => not_piasters(0),
      i1  => not_aux1,
      q   => a2_x2_2_sig,
      vdd => vdd,
      vss => vss
   );

o4_x2_2_ins : o4_x2
   port map (
      i0  => not_aux9,
      i1  => not_piasters(1),
      i2  => not_vending_machine_cs_s100,
      i3  => a2_x2_2_sig,
      q   => o4_x2_2_sig,
      vdd => vdd,
      vss => vss
   );

oa22_x2_ins : oa22_x2
   port map (
      i0  => not_aux0,
      i1  => not_aux8,
      i2  => not_cancel,
      q   => oa22_x2_sig,
      vdd => vdd,
      vss => vss
   );

a2_x2_3_ins : a2_x2
   port map (
      i0  => not_vending_machine_cs_s50,
      i1  => not_vending_machine_cs(0),
      q   => a2_x2_3_sig,
      vdd => vdd,
      vss => vss
   );

change50_ins : nao22_x1
   port map (
      i0  => a2_x2_3_sig,
      i1  => oa22_x2_sig,
      i2  => o4_x2_2_sig,
      nq  => change50,
      vdd => vdd,
      vss => vss
   );

nao22_x1_ins : nao22_x1
   port map (
      i0  => not_vending_machine_cs_s25,
      i1  => aux14,
      i2  => not_vending_machine_cs(0),
      nq  => nao22_x1_sig,
      vdd => vdd,
      vss => vss
   );

nao22_x1_2_ins : nao22_x1
   port map (
      i0  => not_aux1,
      i1  => not_piasters(1),
      i2  => not_aux0,
      nq  => nao22_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

na3_x1_ins : na3_x1
   port map (
      i0  => cancel,
      i1  => nao22_x1_2_sig,
      i2  => nao22_x1_sig,
      nq  => na3_x1_sig,
      vdd => vdd,
      vss => vss
   );

o4_x2_3_ins : o4_x2
   port map (
      i0  => not_piasters(1),
      i1  => not_piasters(0),
      i2  => not_vending_machine_cs_s50,
      i3  => aux1,
      q   => o4_x2_3_sig,
      vdd => vdd,
      vss => vss
   );

na2_x1_2_ins : na2_x1
   port map (
      i0  => piasters(0),
      i1  => piasters(1),
      nq  => na2_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

o3_x2_4_ins : o3_x2
   port map (
      i0  => not_aux9,
      i1  => not_vending_machine_cs_s100,
      i2  => na2_x1_2_sig,
      q   => o3_x2_4_sig,
      vdd => vdd,
      vss => vss
   );

change25_ins : na3_x1
   port map (
      i0  => o3_x2_4_sig,
      i1  => o4_x2_3_sig,
      i2  => na3_x1_sig,
      nq  => change25,
      vdd => vdd,
      vss => vss
   );

inv_x2_3_ins : inv_x2
   port map (
      i   => juice,
      nq  => inv_x2_3_sig,
      vdd => vdd,
      vss => vss
   );

drink_0_ins : no3_x1
   port map (
      i0  => aux0,
      i1  => not_aux6,
      i2  => inv_x2_3_sig,
      nq  => drink(0),
      vdd => vdd,
      vss => vss
   );

inv_x2_4_ins : inv_x2
   port map (
      i   => soft_drink,
      nq  => inv_x2_4_sig,
      vdd => vdd,
      vss => vss
   );

drink_1_ins : no3_x1
   port map (
      i0  => aux0,
      i1  => not_aux6,
      i2  => inv_x2_4_sig,
      nq  => drink(1),
      vdd => vdd,
      vss => vss
   );


end structural;
