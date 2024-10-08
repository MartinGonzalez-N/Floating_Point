
// Generated by Cadence Genus(TM) Synthesis Solution 21.10-p002_1
// Generated on: Sep 24 2024 19:46:55 UTC (Sep 24 2024 19:46:55 UTC)

// Verification Directory fv/lzc_32 

module lzc_32(a, c, v);
  input [31:0] a;
  output [4:0] c;
  output v;
  wire [31:0] a;
  wire [4:0] c;
  wire v;
  wire n_0, n_1, n_2, n_3, n_4, n_5, n_6, n_7;
  wire n_8, n_9, n_10, n_11, n_12, n_13, n_14, n_15;
  wire n_16, n_17, n_18, n_19, n_20, n_21, n_22, n_23;
  wire n_24, n_25, n_26, n_27, n_29, n_30, n_32, n_33;
  wire n_34, n_35, n_36, n_37, n_39, n_40, n_41, n_42;
  wire n_44, n_45, n_47, n_48;
  sky130_fd_sc_hd__nand3_1 g1378__2398(.A (n_48), .B (n_45), .C (n_44),
       .Y (c[0]));
  sky130_fd_sc_hd__a21oi_1 g1380__5107(.A1 (n_0), .A2 (a[29]), .B1
       (n_47), .Y (n_48));
  sky130_fd_sc_hd__o2111ai_1 g1381__6260(.A1 (n_12), .A2 (n_30), .B1
       (n_13), .C1 (n_20), .D1 (n_41), .Y (n_47));
  sky130_fd_sc_hd__nand4b_1 g1379__4319(.A_N (a[30]), .B (n_42), .C
       (n_45), .D (n_44), .Y (c[1]));
  sky130_fd_sc_hd__nand2_1 g1382__8428(.A (n_39), .B (n_35), .Y (c[2]));
  sky130_fd_sc_hd__a2111oi_0 g1383__5526(.A1 (n_40), .A2 (a[2]), .B1
       (n_32), .C1 (n_17), .D1 (n_37), .Y (n_42));
  sky130_fd_sc_hd__a221oi_1 g1384__6783(.A1 (n_36), .A2 (n_11), .B1
       (n_40), .B2 (n_3), .C1 (n_29), .Y (n_41));
  sky130_fd_sc_hd__a21oi_1 g1385__3680(.A1 (n_27), .A2 (n_8), .B1
       (n_34), .Y (n_39));
  sky130_fd_sc_hd__nand2_1 g1386__1617(.A (n_40), .B (n_6), .Y (v));
  sky130_fd_sc_hd__nand2_1 g1387__2802(.A (n_40), .B (a[3]), .Y (n_45));
  sky130_fd_sc_hd__a22o_1 g1388__1705(.A1 (n_36), .A2 (n_14), .B1
       (n_35), .B2 (a[26]), .X (n_37));
  sky130_fd_sc_hd__o2bb2ai_1 g1389__5122(.A1_N (n_33), .A2_N (n_36),
       .B1 (n_18), .B2 (n_25), .Y (n_34));
  sky130_fd_sc_hd__nor2b_1 g1390__8246(.A (n_33), .B_N (n_36), .Y
       (n_40));
  sky130_fd_sc_hd__o22ai_1 g1392__7098(.A1 (n_23), .A2 (c[4]), .B1
       (n_24), .B2 (n_30), .Y (n_32));
  sky130_fd_sc_hd__nor2_1 g1393__6131(.A (n_26), .B (c[4]), .Y (n_36));
  sky130_fd_sc_hd__a31oi_1 g1394__1881(.A1 (n_21), .A2 (n_16), .A3
       (n_2), .B1 (c[4]), .Y (n_29));
  sky130_fd_sc_hd__a21o_1 g1391__5115(.A1 (n_27), .A2 (n_26), .B1
       (n_25), .X (c[3]));
  sky130_fd_sc_hd__inv_1 g1395(.A (n_27), .Y (c[4]));
  sky130_fd_sc_hd__nor4b_1 g1396__7482(.A (n_30), .B (a[17]), .C
       (a[16]), .D_N (n_24), .Y (n_27));
  sky130_fd_sc_hd__nor2_1 g1397__4733(.A (a[14]), .B (n_22), .Y (n_23));
  sky130_fd_sc_hd__nand2_1 g1398__6161(.A (n_21), .B (n_10), .Y (n_22));
  sky130_fd_sc_hd__o21ai_0 g1401__9315(.A1 (a[23]), .A2 (n_1), .B1
       (n_19), .Y (n_20));
  sky130_fd_sc_hd__nand2_1 g1400__9945(.A (n_19), .B (n_18), .Y (n_30));
  sky130_fd_sc_hd__nor2_1 g1399__2883(.A (n_9), .B (n_25), .Y (n_17));
  sky130_fd_sc_hd__nand3b_1 g1408__2346(.A_N (a[10]), .B (n_15), .C
       (a[9]), .Y (n_16));
  sky130_fd_sc_hd__a21oi_1 g1402__1666(.A1 (n_15), .A2 (a[11]), .B1
       (a[15]), .Y (n_21));
  sky130_fd_sc_hd__or3_1 g1419__7410(.A (a[5]), .B (a[4]), .C (n_14),
       .X (n_33));
  sky130_fd_sc_hd__nand3b_1 g1407__6417(.A_N (a[26]), .B (n_35), .C
       (a[25]), .Y (n_13));
  sky130_fd_sc_hd__inv_1 g1404(.A (n_25), .Y (n_19));
  sky130_fd_sc_hd__a21oi_1 g1403__5477(.A1 (n_35), .A2 (a[27]), .B1
       (a[31]), .Y (n_44));
  sky130_fd_sc_hd__a21oi_1 g1411__2398(.A1 (n_24), .A2 (a[17]), .B1
       (a[19]), .Y (n_12));
  sky130_fd_sc_hd__a21o_1 g1412__5107(.A1 (n_4), .A2 (a[5]), .B1
       (a[7]), .X (n_11));
  sky130_fd_sc_hd__nand2_1 g1409__6260(.A (n_15), .B (n_5), .Y (n_26));
  sky130_fd_sc_hd__nand2_1 g1405__4319(.A (n_15), .B (a[10]), .Y
       (n_10));
  sky130_fd_sc_hd__nor3b_1 g1418__8428(.A (a[21]), .B (a[20]), .C_N
       (n_9), .Y (n_18));
  sky130_fd_sc_hd__nand2_1 g1406__5526(.A (n_35), .B (n_7), .Y (n_25));
  sky130_fd_sc_hd__inv_1 g1410(.A (n_15), .Y (n_8));
  sky130_fd_sc_hd__nor4_1 g1415__6783(.A (a[25]), .B (a[27]), .C
       (a[26]), .D (a[24]), .Y (n_7));
  sky130_fd_sc_hd__nor4_1 g1414__3680(.A (a[29]), .B (a[31]), .C
       (a[30]), .D (a[28]), .Y (n_35));
  sky130_fd_sc_hd__nor4_1 g1413__1617(.A (a[13]), .B (a[15]), .C
       (a[14]), .D (a[12]), .Y (n_15));
  sky130_fd_sc_hd__nor4_1 g1416__2802(.A (a[3]), .B (a[1]), .C (a[2]),
       .D (a[0]), .Y (n_6));
  sky130_fd_sc_hd__nor4_1 g1417__1705(.A (a[9]), .B (a[11]), .C
       (a[10]), .D (a[8]), .Y (n_5));
  sky130_fd_sc_hd__inv_1 g1423(.A (n_4), .Y (n_14));
  sky130_fd_sc_hd__nor2b_1 g1420__5122(.A (a[2]), .B_N (a[1]), .Y
       (n_3));
  sky130_fd_sc_hd__nand2b_1 g1421__8246(.A_N (a[14]), .B (a[13]), .Y
       (n_2));
  sky130_fd_sc_hd__nor2_1 g1426__7098(.A (a[7]), .B (a[6]), .Y (n_4));
  sky130_fd_sc_hd__nor2b_1 g1424__6131(.A (a[22]), .B_N (a[21]), .Y
       (n_1));
  sky130_fd_sc_hd__nor2_1 g1425__1881(.A (a[22]), .B (a[23]), .Y (n_9));
  sky130_fd_sc_hd__nor2_1 g1422__5115(.A (a[19]), .B (a[18]), .Y
       (n_24));
  sky130_fd_sc_hd__inv_1 g1427(.A (a[30]), .Y (n_0));
endmodule

