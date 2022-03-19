#-------vending_machine--------------------------------#

#-------Convert .vhd to .fsm---------------------------#
vending_machine:
	rename .vhd  .fsm *.vhd

#-------Finite State Machine Plot----------------------#
fsm_plot_view:
	xfsm -l vending_machine.fsm

#-------Finite State Machine Synthesis-----------------#
vending_machinea.vbe: vending_machine.fsm
	@echo " Encoding Synthesis -> vending_machinea.vbe"
	syf -CEV -a vending_machine

vending_machinej.vbe: vending_machine.fsm
	@echo " Encoding Synthesis  -> vending_machinej.vbe"
	syf -CEV -j vending_machine
 
vending_machinem.vbe: vending_machine.fsm
	@echo " Encoding Synthesis  -> vending_machinem.vbe"
	syf -CEV -m vending_machine
 
vending_machineo.vbe: vending_machine.fsm
	@echo " Encoding Synthesis  -> vending_machineo.vbe"
	syf -CEV -o vending_machine
 
vending_machiner.vbe: vending_machine.fsm
	@echo " Encoding Synthesis  -> vending_machiner.vbe"
	syf -CEV -r vending_machine

#-------BOOM optimization------------------------------#

vending_machinea_b.vbe: vending_machinea.vbe
	@echo " Boolean Optimization -> vending_machinea_b.vbe "
	boom  -V -A -d 50 vending_machinea vending_machinea_b

vending_machinej_b.vbe: vending_machinej.vbe
	@echo " Boolean Optimization -> vending_machinej_b.vbe "
	boom  -V -A -d 50 vending_machinej vending_machinej_b

vending_machinem_b.vbe: vending_machinem.vbe
	@echo " Boolean Optimization -> vending_machinem_b.vbe "
	boom  -V -A -d 50 vending_machinem vending_machinem_b

vending_machineo_b.vbe: vending_machineo.vbe
	@echo " Boolean Optimization -> vending_machineo_b.vbe "
	boom  -V -A -d 50 vending_machineo vending_machineo_b

vending_machiner_b.vbe: vending_machiner.vbe
	@echo " Boolean Optimization -> vending_machiner_b.vbe "
	boom  -V -A -d 50 vending_machiner vending_machiner_b 

#----------------BOOG ---------------------------------#

vending_machinea_bg.vst:  vending_machinea_b.vbe 
	@echo " BOOG -a -> vending_machine_b.pat "
	boog -l paramfile vending_machinea_b vending_machinea_bg   

vending_machinej_bg.vst:  vending_machinej_b.vbe 
	@echo " BOOG -j -> vending_machine_b.pat "
	boog -l paramfile vending_machinej_b vending_machinej_bg   

vending_machinem_bg.vst:  vending_machinem_b.vbe 
	@echo " BOOG -m -> vending_machine_b.pat "
	boog -l paramfile vending_machinem_b vending_machinem_bg

vending_machineo_bg.vst:  vending_machineo_b.vbe 
	@echo " BOOG -o -> vending_machine_b.pat "
	boog -l paramfile vending_machineo_b vending_machineo_bg 

vending_machiner_bg.vst:  vending_machiner_b.vbe 
	@echo " BOOG -r -> vending_machine_b.pat "
	boog -l paramfile vending_machiner_b vending_machiner_bg

#----------------LOON ---------------------------------#

vending_machinea_ln.vst:  vending_machinea_bg.vst 
	@echo "  LOON -a -> vending_machinea_ln.pat "
	loon -l paramfile vending_machinea_bg vending_machinea_ln   

vending_machinej_ln.vst:  vending_machinej_bg.vst 
	@echo "  LOON -j -> vending_machinej_ln.pat "
	loon -l paramfile vending_machinej_bg vending_machinej_ln    

vending_machinem_ln.vst:  vending_machinem_bg.vst 
	@echo "  LOON -m -> vending_machinem_ln.pat "
	loon -l paramfile vending_machinem_bg vending_machinem_ln 

vending_machineo_ln.vst:  vending_machineo_bg.vst 
	@echo "  LOON -o -> vending_machineo_ln.pat "
	loon -l paramfile vending_machineo_bg vending_machineo_ln 

vending_machiner_ln.vst:  vending_machiner_bg.vst 
	@echo "  LOON -r -> vending_machiner_ln.pat "
	loon -l paramfile vending_machiner_bg vending_machiner_ln     

#-----------------Netlist Visualization--------------------#
vending_machinea_netlist_view:
	xsch -I vst -l vending_machinea_ln

#-----------------Flat Behavioral--------------------------#

vending_machinea_fb:  vending_machinea_ln.vst 
	@echo " Flat Behavioral Completed "
	flatbeh vending_machinea_ln vending_machine_fb   

#---------------------Proof--------------------------------#

vending_machinea_pf:  vending_machinea.vbe vending_machine_fb.vbe  
	@echo " Proof Completed "
	proof -d vending_machinea vending_machine_fb 

#-----------------Scan-path Insertion----------------------#
vending_machinea_registers:
	cat vending_machinea_ln.vst | grep sff

vending_machinea_s.vst:  vending_machinea_ln.vst scan.path
	@echo " Scan-path Insertion Completed "
	scapin -VRB vending_machinea_ln scan vending_machinea_s

#-----------------DFT Netlist Visualization----------------#
vending_machinea_dft_netlist_view:
	xsch -I vst -l vending_machinea_s

#-------------------Placement------------------------------#
vending_machinea_placement.ap: pin_order.ioc vending_machinea_s.vst  
	@echo "  Placement Completed "
	ocp -v -ring -ioc pin_order vending_machinea_s vending_machinea_p > ocp.out

#----------------Placement Visualization-------------------#
vending_machinea_placement:
	RDS_TECHNO_NAME=/home/alliance/CAD2_2021/techno/techno-symb.rds; export RDS_TECHNO_NAME; \
	graal -l vending_machinea_p

#-------------------Rounting--------------------------------#
vending_machinea_rout.ap: vending_machinea_p.ap vending_machinea_s.vst  
	@echo "  Rounting Completed "
	nero -V -p vending_machinea_p vending_machinea_s vending_machinea_s > nero.out

#----------------Rounting Visualization---------------------#
vending_machinea_routing:
	RDS_TECHNO_NAME=/home/alliance/CAD2_2021/techno/techno-symb.rds; export RDS_TECHNO_NAME; \
	graal -l vending_machinea_s

#--------------Post-Layout Visualization--------------------#
vending_machinea_post_layout.al: vending_machinea_s.ap
	@echo "  Chip Post-Layout Visualization Completed "
	MBK_OUT_LO=al; export MBK_OUT_LO; \
	RDS_TECHNO_NAME=/home/alliance/CAD2_2021/techno/techno-035.rds; export RDS_TECHNO_NAME; \
	cougar -v vending_machinea_s > cougar.out
	lvx vst al vending_machinea_s vending_machinea_s -f > lvx.out

#----------------DRC----------------------------------------#
drc:
	RDS_TECHNO_NAME=/home/alliance/CAD2_2021/techno/techno-symb.rds; export RDS_TECHNO_NAME; \
	graal -l vending_machinea_s

#----------------Chip Visualization-------------------------#
chip_view:
	xsch -I vst -l chip

#-------------------Chip Assembly---------------------------#
chip_assembly.ap: chip.vst chip.rin
	@echo "  Chip assembly "
	ring chip chip_layout > ring.out

#----------------Chip Layout Visualization-----------------#
chip_layout_view:
	RDS_TECHNO_NAME=/home/alliance/CAD2_2021/techno/techno-symb.rds; export RDS_TECHNO_NAME; \
	graal -l chip_layout

#-------------Chip Post-Layout Visualization---------------#
chip_post_layout.al: chip_layout.ap
	@echo " Chip Post-Layout Visualization "
	MBK_OUT_LO=al; export MBK_OUT_LO; \
	RDS_TECHNO_NAME=/home/alliance/CAD2_2021/techno/techno-035.rds; export RDS_TECHNO_NAME; \
	cougar -v chip_layout > chip_cougar.out
	lvx vst al chip chip_layout -f > chip_lvx.out

#---------------------Chip DRC------------------------------#
chip_drc:
	RDS_TECHNO_NAME=/home/alliance/CAD2_2021/techno/techno-symb.rds; export RDS_TECHNO_NAME; \
	graal -l chip_layout


#-------------Symbolic to Real Conversion--------------------#
chip_s2r.cif: chip_layout.ap  
	@echo " Symbolic to real conversion "
	RDS_TECHNO_NAME=/home/alliance/CAD2_2021/techno/techno-035.rds; export RDS_TECHNO_NAME; \
	s2r -v -r chip_layout > chip_s2r.out

#----------------Real Layout Viewer-----------------#
chip_layout_view:
	RDS_TECHNO_NAME=/home/alliance/CAD2_2021/techno/techno-035.rds; export RDS_TECHNO_NAME; \
	dreal -l chip_layout


#-------------------Clean Up------------------------------------#
 
clean : 
	rm -f  *.vbe *.enc *~ 
	#@echo "Erase all the files generated by the makefile"

