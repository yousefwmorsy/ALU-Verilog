`timescale 1ns/100ps
module add_sub_tb ();
    reg [2:0] A;
    reg [2:0] B;
    reg OP;
    wire DZF;
    wire ZF;
    wire SF;
    wire [3:0] R;
    integer file_add, file_sub, i, j;
    integer result;

    add_sub AddSub (
        .OP(OP),
        .A(A),
        .B(B),
        .R(R),
        .DZF(DZF),
        .ZF(ZF),
        .SF(SF)
    );

    initial begin
        file_add = $fopen("add.txt", "w");
        if (file_add == 0) begin
            $display("Error opening file!");
            $finish;
        end
        OP = 0;
        for (i = 3; i >= 1; i = i - 1) begin
            for (j = 3; j >= 1; j = j - 1) begin
                A[2] = 1;
                B[2] = 1;
                A[1] = i[1];
                B[1] = j[1];
                A[0] = i[0];
                B[0] = j[0];
                #10;
                $fdisplay(file_add, "A = %3b, B = %3b, R = %4b, SF = %b, ZF = %b, DZF = %b",
                          A, B, R, SF, ZF, DZF);  
            end
            for (j = 0; j <= 3; j = j + 1) begin
                A[2] = 1;
                B[2] = 0;
                A[1] = i[1];
                B[1] = j[1];
                A[0] = i[0];
                B[0] = j[0];
                #10;
                $fdisplay(file_add, "A = %3b, B = %3b, R = %4b, SF = %b, ZF = %b, DZF = %b",
                          A, B, R, SF, ZF, DZF);  
            end
        end
        for (i = 0; i <= 3; i = i + 1) begin
            for (j = 3; j >= 1; j = j - 1) begin
                A[2] = 0;
                B[2] = 1;
                A[1] = i[1];
                B[1] = j[1];
                A[0] = i[0];
                B[0] = j[0];
                #10;
                $fdisplay(file_add, "A = %3b, B = %3b, R = %4b, SF = %b, ZF = %b, DZF = %b",
                          A, B, R, SF, ZF, DZF);  
            end
            for (j = 0; j <= 3; j = j + 1) begin
                A[2] = 0;
                B[2] = 0;
                A[1] = i[1];
                B[1] = j[1];
                A[0] = i[0];
                B[0] = j[0];
                #10;
                $fdisplay(file_add, "A = %3b, B = %3b, R = %4b, SF = %b, ZF = %b, DZF = %b",
                          A, B, R, SF, ZF, DZF);  
            end
        end
        $fclose(file_add);

        file_sub = $fopen("sub.txt", "w");
        if (file_sub == 0) begin
            $display("Error opening file!");
            $finish;
        end
        OP = 1;
        for (i = 3; i >= 1; i = i - 1) begin
            for (j = 3; j >= 1; j = j - 1) begin
                A[2] = 1;
                B[2] = 1;
                A[1] = i[1];
                B[1] = j[1];
                A[0] = i[0];
                B[0] = j[0];
                #10;
                $fdisplay(file_sub, "A = %3b, B = %3b, R = %4b, SF = %b, ZF = %b, DZF = %b",
                          A, B, R, SF, ZF, DZF);  
            end
            for (j = 0; j <= 3; j = j + 1) begin
                A[2] = 1;
                B[2] = 0;
                A[1] = i[1];
                B[1] = j[1];
                A[0] = i[0];
                B[0] = j[0];
                #10;
                $fdisplay(file_sub, "A = %3b, B = %3b, R = %4b, SF = %b, ZF = %b, DZF = %b",
                          A, B, R, SF, ZF, DZF);  
            end
        end
        for (i = 0; i <= 3; i = i + 1) begin
            for (j = 3; j >= 1; j = j - 1) begin
                A[2] = 0;
                B[2] = 1;
                A[1] = i[1];
                B[1] = j[1];
                A[0] = i[0];
                B[0] = j[0];
                #10;
                $fdisplay(file_sub, "A = %3b, B = %3b, R = %4b, SF = %b, ZF = %b, DZF = %b",
                          A, B, R, SF, ZF, DZF);  
            end
            for (j = 0; j <= 3; j = j + 1) begin
                A[2] = 0;
                B[2] = 0;
                A[1] = i[1];
                B[1] = j[1];
                A[0] = i[0];
                B[0] = j[0];
                #10;
                $fdisplay(file_sub, "A = %3b, B = %3b, R = %4b, SF = %b, ZF = %b, DZF = %b",
                          A, B, R, SF, ZF, DZF);  
            end
        end
        $fclose(file_sub);
    end
endmodule

