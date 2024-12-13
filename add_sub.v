/*================== Half_Adder Module ====================*/
module Half_Adder (
    input in1,in2,
    output O1, O2
);
    xor x1(O1, in1, in2); //Sum
    and n1(O2, in1, in2); //Carry
endmodule
/*================== Full_Adder Module ====================*/
module Full_Adder (
    input A,B,C,
    output Sum, Carry
);
    wire sum1, sum2, carry1, carry2;
    Half_Adder H1(
        .in1(A),
        .in2(B),
        .O1(sum1),
        .O2(carry1)
    );
    Half_Adder H2(
        .in1(C),
        .in2(sum1),
        .O1(sum2),
        .O2(carry2)
    );
    assign Sum = sum2;
    assign Carry = carry1 | carry2;
endmodule
/*================== 1-Complement Module ====================*/
module One_Complement (
    input in1, in2, in3,
    output O1, O2
);
    
    xor x1(O1, in1, in3);
    xor x2(O2, in2, in3);
endmodule
/*================== Main ====================*/
module add_sub (
    input OP, [2:0]A, [2:0]B,
    output SF, DZF, ZF, [3:0]R
);
    wire w1, w2, w3, w4, w5, w6 ,w8 ,w9 ,w10 ,w11, w12;
/* ============================== Level 1 =========================*/
    xor x1(w1, OP, B[2]);
    and and1(w2, w1, ~A[2]);
    and and2(w3, ~w1, A[2]);
    wire A1inv, A2inv, B1inv, B2inv;
    One_Complement invA(
        .in1(A[0]),
        .in2(A[1]),
        .in3(w3),   
        .O1(A1inv),
        .O2(A2inv)
    );
    One_Complement invB(
        .in1(B[0]),
        .in2(B[1]),
        .in3(w2),
        .O1(B1inv),
        .O2(B2inv)
    );
/* ============================== Level 2 =========================*/
    or o1(w4, w3, w2);
    wire s1, c1, s2, c2, s3, c3;
    Full_Adder f1(
        .A(A1inv),
        .B(B1inv),
        .C(w4),
        .Sum(s1),
        .Carry(c1)
    );
    Full_Adder f2(
        .A(A2inv),
        .B(B2inv),
        .C(c1),
        .Sum(s2),
        .Carry(c2)
    );
/* ============================== Level 3 =========================*/
    and and3(w6, w4, ~c2);
    wire S1inv, S2inv;
    One_Complement invS(
        .in1(s1),
        .in2(s2),
        .in3(w6),
        .O1(S1inv),
        .O2(S2inv)
    );
/* ============================== Level 4 =========================*/
    and and4(w5, A[2], w1);
    Half_Adder HF1(
        .in1(S1inv),
        .in2(w6),
        .O1(s3),
        .O2(c3)
    );
    xor x3(w8, S2inv, c3);
    and(w9, c2, ~w4);
/* ============================== Level 5 =========================*/
    or o2(w10, w5, w6);
    or o3(w11, w9, w8, s3);
    and and5(w12, w11, w10);
/* ============================== Level 6 =========================*/
    assign R[0] = s3;
    assign R[1] = w8;
    assign R[2] = w9;
    assign R[3] = w12;
    assign SF = R[3];
    assign DZF = 0;
    assign ZF = ~w11;
endmodule