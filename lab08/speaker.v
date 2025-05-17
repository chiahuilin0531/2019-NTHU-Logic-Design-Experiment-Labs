`define silence   32'd50000000

`define C 1
`define D 2
`define E 3
`define F 4
`define G 5
`define A 6
`define B 7


module speaker(
    clk, // clock from crystal
    rst, // active high reset: BTNC
    _play, // SW: Play/Pause
    _mute, // SW: Mute
    _repeat, // SW: Repeat
    _music, // SW: Music
    _volUP, // BTN: Vol up
    _volDOWN, // BTN: Vol down
    _led_vol, // LED: volume
    audio_mclk, // master clock
    audio_lrck, // left-right clock
    audio_sck, // serial clock
    audio_sdin, // serial audio data input
    DISPLAY, // 7-seg
    DIGIT // 7-seg
);

    // I/O declaration
    input clk;  // clock from the crystal
    input rst;  // active high reset
    input _play, _mute, _repeat, _music, _volUP, _volDOWN;
    output [4:0] _led_vol;
    output audio_mclk; // master clock
    output audio_lrck; // left-right clock
    output audio_sck; // serial clock
    output audio_sdin; // serial audio data input
    output [6:0] DISPLAY;
    output [3:0] DIGIT;
    
    // Internal Signal
    wire [2:0] pitch;
    
    wire [15:0] audio_in_left, audio_in_right;
    
    wire clkDiv22, clkDiv16, clkDiv13;
    wire [11:0] ibeatNum; // Beat counter
    wire [31:0] freqL, freqR; // Raw frequency, produced by music module
    wire [21:0] freq_outL, freq_outR; // Processed Frequency, adapted to the clock rate of Basys3
    

    assign freq_outL = 50000000 / (_mute ? `silence : freqL); // Note gen makes no sound, if freq_out = 50000000 / `silence = 1
    assign freq_outR = 50000000 / (_mute ? `silence : freqR);


    //Design
    
    wire _volD_d, _volU_d;
    wire _volD_1, _volU_1;
    
    debounce d0(.pb_debounced(_volD_d), .pb(_volDOWN) , .clk(clkDiv16));
    debounce d1(.pb_debounced(_volU_d), .pb(_volUP) , .clk(clkDiv16));
    
    onepulse o0(.signal(_volD_d), .clk(clkDiv16), .op(_volD_1));
    onepulse o1(.signal(_volU_d), .clk(clkDiv16), .op(_volU_1));
    
    // Volume Control
    
    reg [2:0] vol, next_vol; 
    
    always@(posedge clkDiv16 or posedge rst) begin
        if (rst) begin
            vol = 3'd3;
        end else 
            vol = next_vol;    
    end
    
    always@* begin
        next_vol = vol;
        if (_volD_1 && vol > 1) begin
            next_vol = vol - 1;
        end
        if (_volU_1 && vol < 5) begin
            next_vol = vol + 1;
        end
    end
    
    assign _led_vol[0] = (!_mute)? 1'b1 : 1'b0;
    assign _led_vol[1] = (!_mute && vol > 1)? 1'b1 : 1'b0;
    assign _led_vol[2] = (!_mute && vol > 2)? 1'b1 : 1'b0;
    assign _led_vol[3] = (!_mute && vol > 3)? 1'b1 : 1'b0;
    assign _led_vol[4] = (!_mute && vol > 4)? 1'b1 : 1'b0;
    
    // Other Modules
    
    SevenSegment s0(
        .clk(clkDiv13), 
        .pitch(pitch),
        .DIGIT(DIGIT), 
        .DISPLAY(DISPLAY)
    );
    
    clock_divider #(.n(22)) clock_22(
        .clk(clk),
        .clk_div(clkDiv22)
    );
    
    clock_divider #(.n(16)) clock_16(
        .clk(clk),
        .clk_div(clkDiv16)
    );
    
    clock_divider #(.n(13)) clock_13(
        .clk(clk),
        .clk_div(clkDiv13)
    );
    
    // Player Control
    player_control #(.LEN(512)) playerCtrl_00 ( 
        .clk(clkDiv22),
        .reset(rst),
        ._play(_play),
        ._repeat(_repeat),
        ._music(_music),
        .ibeat(ibeatNum)
    );

    // Music module
    // [in]  beat number and en
    // [out] left & right raw frequency
    music_example music_00 (
        .ibeatNum(ibeatNum),
        .en(_play),
        .music(_music),
        .toneL(freqL),
        .toneR(freqR),
        .pitch(pitch)
    );

    // Note generation
    // [in]  processed frequency
    // [out] audio wave signal (using square wave here)
    note_gen noteGen_00(
        .clk(clk), // clock from crystal
        .rst(rst), // active high reset
        .note_div_left(freq_outL),
        .note_div_right(freq_outR),
        .audio_left(audio_in_left), // left sound audio
        .audio_right(audio_in_right),
        .volume(vol) // 3 bits for 5 levels
    );

    // Speaker controller
    speaker_control sc(
        .clk(clk),  // clock from the crystal
        .rst(rst),  // active high reset
        .audio_in_left(audio_in_left), // left channel audio data input
        .audio_in_right(audio_in_right), // right channel audio data input
        .audio_mclk(audio_mclk), // master clock
        .audio_lrck(audio_lrck), // left-right clock
        .audio_sck(audio_sck), // serial clock
        .audio_sdin(audio_sdin) // serial audio data input
    );

endmodule

module SevenSegment (clk, pitch, DIGIT, DISPLAY);

    input clk;
    input [2:0] pitch;
    output reg [3:0] DIGIT;
    output reg [6:0] DISPLAY;
    
    reg [2:0] dis;
    
    always@(posedge clk) begin
        case (DIGIT)
            4'b1110: begin
                dis = 0;
                DIGIT = 4'b1101;
            end
            4'b1101: begin
                dis = 0;
                DIGIT = 4'b1011;
            end
            4'b1011: begin
                dis = 0;
                DIGIT = 4'b0111;
            end
            4'b0111: begin
                dis = pitch;
                DIGIT = 4'b1110;
            end
            default: begin
                dis = pitch;
                DIGIT = 4'b1110;
            end
        endcase 
    end
    
    always @* begin
        case (dis)
            0: DISPLAY = 7'b0111111;
            1: DISPLAY = 7'b1000110;
            2: DISPLAY = 7'b0100001;
            3: DISPLAY = 7'b0000110;
            4: DISPLAY = 7'b0001110;
            5: DISPLAY = 7'b1000010;
            6: DISPLAY = 7'b0001000;
            7: DISPLAY = 7'b0000011;
            default: DISPLAY = 7'b0111111;
        endcase
    end
    

endmodule
