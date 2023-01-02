//--------------------------------------------------------------------
// Register Address Map As Seen By the External/Caravel RISCV Core
//--------------------------------------------------------------------

//-------------------------------------
// PinMux Register
// ------------------------------------
#define reg_glbl_soft_reg_0    (*(volatile uint32_t*)0x30000000)  // reg_0 - Soft Register-0
#define reg_glbl_soft_reg_1    (*(volatile uint32_t*)0x30000004)  // reg_1 - Soft Register-1
#define reg_glbl_soft_reg_2    (*(volatile uint32_t*)0x30000008)  // reg_2 - Soft Register-2
#define reg_glbl_soft_reg_3    (*(volatile uint32_t*)0x3000000C)  // reg_3 - Soft Register-3
#define reg_glbl_soft_reg_4    (*(volatile uint32_t*)0x30000010)  // reg_4 - Soft Register-4
#define reg_glbl_soft_reg_5    (*(volatile uint32_t*)0x30000014)  // reg_5 - Soft Register-5
#define reg_glbl_mac_clk_cfg   (*(volatile uint32_t*)0x30000020)  // reg_8  - MAC Clock control
#define reg_glbl_chip_id       (*(volatile uint32_t*)0x30000024)  // reg_9  - Chip-ID
#define reg_glbl_chip_rdate    (*(volatile uint32_t*)0x30000028)  // reg_10 - Chip Release Date 
#define reg_glbl_chip_ver      (*(volatile uint32_t*)0x3000002C)  // reg_11 - Chip Version


#define reg_mprj_wbhost_ctrl (*(volatile uint32_t*)0x30080000)
