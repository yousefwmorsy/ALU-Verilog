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
        for (i = -3; i <= 3; i = i + 1) begin
            for (j = -3; j <= 3; j = j + 1) begin
                A = (i < 0) ? {1'b1, -i[1:0]} : {1'b0, i[1:0]};
                B = (j < 0) ? {1'b1, -j[1:0]} : {1'b0, j[1:0]};
                #10;
                result = (R[3] == 1) ? -R[2:0] : R[2:0]; 
                $fdisplay(file_add, "A = %0d, B = %0d, R = %0d, SF = %b, ZF = %b",
                          i, j, result, SF, ZF); 
            end
        end
        $fclose(file_add);

        file_sub = $fopen("sub.txt", "w");
        if (file_sub == 0) begin
            $display("Error opening file!");
            $finish;
        end
        OP = 1;
        for (i = -3; i <= 3; i = i + 1) begin
            for (j = -3; j <= 3; j = j + 1) begin
                A = (i < 0) ? {1'b1, -i[1:0]} : {1'b0, i[1:0]};
                B = (j < 0) ? {1'b1, -j[1:0]} : {1'b0, j[1:0]};
                #10;
                result = (R[3] == 1) ? -R[2:0] : R[2:0];  
                $fdisplay(file_sub, "A = %0d, B = %0d, R = %0d, SF = %b, ZF = %b",
                          i, j, result, SF, ZF); 
            end
        end
        $fclose(file_sub);
        $finish;
        end
endmodule

