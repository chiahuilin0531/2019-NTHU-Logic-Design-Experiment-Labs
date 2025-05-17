`define lc   32'd131   // C2
`define ld   32'd147   // D2
`define lef  32'd156   // Eb2
`define le   32'd165   // E2
`define lf   32'd175   // F2
`define lfs  32'd185   // F#2
`define lg   32'd196   // G2
`define la   32'd220   // A2
`define lbf  32'd233   // Bb2
`define lb   32'd247   // B2

`define c   32'd262   // C3
`define d   32'd294   // D3
`define ef  32'd311   // Eb3
`define e   32'd330   // E3
`define f   32'd349   // F3
`define fs  32'd370   //F#3
`define g   32'd392   // G3
`define a   32'd440   // A3
`define bf  32'd466   // Bb3
`define b   32'd494   // B3

`define hc  32'd524   // C4
`define hd  32'd588   // D4
`define hef 32'd622   // Eb4
`define he  32'd660   // E4
`define hf  32'd698   // F4
`define hg  32'd784   // G4
`define ha  32'd880   // A4
`define hbf 32'd933   // Bb4
`define hb  32'd988   // B4

`define sil   32'd50000000 // slience

module music_example (
	input [11:0] ibeatNum,
	input en,
	input music,
	output reg [31:0] toneL,
    output reg [31:0] toneR,
    output reg [2:0] pitch
);

    always @* begin
        if (en) begin
            case(toneR)
                `hc, `c, `lc: pitch = 1;
                `hd, `d, `ld: pitch = 2;
                `hef, `ef, `lef: pitch = 3;
                `he, `e, `le: pitch = 3;
                `hf, `f, `lf: pitch = 4;
                `fs, `lfs:    pitch = 4;
                `hg, `g, `lg: pitch = 5;
                `ha, `a, `la: pitch = 6;
                `hbf, `bf, `lbf: pitch = 7;
                `hb, `b, `lb: pitch = 7;
                default: pitch = 0;
            endcase
        end else begin
            pitch = 0;
        end
    end
    
    always @* begin
        if(en && music) begin
            case(ibeatNum)
            
 //Lightly Row
                // --- Measure 1 ---
                
                12'd0: toneR = `hg;      12'd1: toneR = `hg; // HG (half-beat)
                12'd2: toneR = `hg;      12'd3: toneR = `hg;
                12'd4: toneR = `hg;      12'd5: toneR = `hg;
                12'd6: toneR = `hg;      12'd7: toneR = `hg;
                12'd8: toneR = `he;      12'd9: toneR = `he; // HE (half-beat)
                12'd10: toneR = `he;     12'd11: toneR = `he;
                12'd12: toneR = `he;     12'd13: toneR = `he;
                12'd14: toneR = `he;     12'd15: toneR = `sil; // (Short break for repetitive notes: high E)

                12'd16: toneR = `he;     12'd17: toneR = `he; // HE (one-beat)
                12'd18: toneR = `he;     12'd19: toneR = `he;
                12'd20: toneR = `he;     12'd21: toneR = `he;
                12'd22: toneR = `he;     12'd23: toneR = `he;
                12'd24: toneR = `he;     12'd25: toneR = `he;
                12'd26: toneR = `he;     12'd27: toneR = `he;
                12'd28: toneR = `he;     12'd29: toneR = `he;
                12'd30: toneR = `he;     12'd31: toneR = `he;

                12'd32: toneR = `hf;     12'd33: toneR = `hf; // HF (half-beat)
                12'd34: toneR = `hf;     12'd35: toneR = `hf;
                12'd36: toneR = `hf;     12'd37: toneR = `hf;
                12'd38: toneR = `hf;     12'd39: toneR = `hf;
                12'd40: toneR = `hd;     12'd41: toneR = `hd; // HD (half-beat)
                12'd42: toneR = `hd;     12'd43: toneR = `hd;
                12'd44: toneR = `hd;     12'd45: toneR = `hd;
                12'd46: toneR = `hd;     12'd47: toneR = `sil; // (Short break for repetitive notes: high D)

                12'd48: toneR = `hd;     12'd49: toneR = `hd; // HD (one-beat)
                12'd50: toneR = `hd;     12'd51: toneR = `hd;
                12'd52: toneR = `hd;     12'd53: toneR = `hd;
                12'd54: toneR = `hd;     12'd55: toneR = `hd;
                12'd56: toneR = `hd;     12'd57: toneR = `hd;
                12'd58: toneR = `hd;     12'd59: toneR = `hd;
                12'd60: toneR = `hd;     12'd61: toneR = `hd;
                12'd62: toneR = `hd;     12'd63: toneR = `hd;

                // --- Measure 2 ---
                
                12'd64: toneR = `hc;     12'd65: toneR = `hc; // HC (half-beat)
                12'd66: toneR = `hc;     12'd67: toneR = `hc;
                12'd68: toneR = `hc;     12'd69: toneR = `hc;
                12'd70: toneR = `hc;     12'd71: toneR = `hc;
                12'd72: toneR = `hd;     12'd73: toneR = `hd; // HD (half-beat)
                12'd74: toneR = `hd;     12'd75: toneR = `hd;
                12'd76: toneR = `hd;     12'd77: toneR = `hd;
                12'd78: toneR = `hd;     12'd79: toneR = `hd;

                12'd80: toneR = `he;     12'd81: toneR = `he; // HE (half-beat)
                12'd82: toneR = `he;     12'd83: toneR = `he;
                12'd84: toneR = `he;     12'd85: toneR = `he;
                12'd86: toneR = `he;     12'd87: toneR = `he;
                12'd88: toneR = `hf;     12'd89: toneR = `hf; // HF (half-beat)
                12'd90: toneR = `hf;     12'd91: toneR = `hf;
                12'd92: toneR = `hf;     12'd93: toneR = `hf;
                12'd94: toneR = `hf;     12'd95: toneR = `hf;

                12'd96: toneR = `hg;     12'd97: toneR = `hg; // HG (half-beat)
                12'd98: toneR = `hg;     12'd99: toneR = `hg;
                12'd100: toneR = `hg;     12'd101: toneR = `hg;
                12'd102: toneR = `hg;     12'd103: toneR = `sil; // (Short break for repetitive notes: high D)
                12'd104: toneR = `hg;     12'd105: toneR = `hg; // HG (half-beat)
                12'd106: toneR = `hg;     12'd107: toneR = `hg;
                12'd108: toneR = `hg;     12'd109: toneR = `hg;
                12'd110: toneR = `hg;     12'd111: toneR = `sil; // (Short break for repetitive notes: high D)

                12'd112: toneR = `hg;     12'd113: toneR = `hg; // HG (one-beat)
                12'd114: toneR = `hg;     12'd115: toneR = `hg;
                12'd116: toneR = `hg;     12'd117: toneR = `hg;
                12'd118: toneR = `hg;     12'd119: toneR = `hg;
                12'd120: toneR = `hg;     12'd121: toneR = `hg;
                12'd122: toneR = `hg;     12'd123: toneR = `hg;
                12'd124: toneR = `hg;     12'd125: toneR = `hg;
                12'd126: toneR = `hg;     12'd127: toneR = `sil;
                
                // --- Measure 3 ---
                
                12'd128: toneR = `hg;      12'd129: toneR = `hg; // HG (half-beat)
                12'd130: toneR = `hg;      12'd131: toneR = `hg;
                12'd132: toneR = `hg;      12'd133: toneR = `hg;
                12'd134: toneR = `hg;      12'd135: toneR = `hg;
                12'd136: toneR = `he;      12'd137: toneR = `he; // HE (half-beat)
                12'd138: toneR = `he;     12'd139: toneR = `he;
                12'd140: toneR = `he;     12'd141: toneR = `he;
                12'd142: toneR = `he;     12'd143: toneR = `sil; // (Short break for repetitive notes: high E)

                12'd144: toneR = `he;     12'd145: toneR = `he; // HE (one-beat)
                12'd146: toneR = `he;     12'd147: toneR = `he;
                12'd148: toneR = `he;     12'd149: toneR = `he;
                12'd150: toneR = `he;     12'd151: toneR = `he;
                12'd152: toneR = `he;     12'd153: toneR = `he;
                12'd154: toneR = `he;     12'd155: toneR = `he;
                12'd156: toneR = `he;     12'd157: toneR = `he;
                12'd158: toneR = `he;     12'd159: toneR = `he;

                12'd160: toneR = `hf;     12'd161: toneR = `hf; // HF (half-beat)
                12'd162: toneR = `hf;     12'd163: toneR = `hf;
                12'd164: toneR = `hf;     12'd165: toneR = `hf;
                12'd166: toneR = `hf;     12'd167: toneR = `hf;
                12'd168: toneR = `hd;     12'd169: toneR = `hd; // HD (half-beat)
                12'd170: toneR = `hd;     12'd171: toneR = `hd;
                12'd172: toneR = `hd;     12'd173: toneR = `hd;
                12'd174: toneR = `hd;     12'd175: toneR = `sil; // (Short break for repetitive notes: high D)

                12'd176: toneR = `hd;     12'd177: toneR = `hd; // HD (one-beat)
                12'd178: toneR = `hd;     12'd179: toneR = `hd;
                12'd180: toneR = `hd;     12'd181: toneR = `hd;
                12'd182: toneR = `hd;     12'd183: toneR = `hd;
                12'd184: toneR = `hd;     12'd185: toneR = `hd;
                12'd186: toneR = `hd;     12'd187: toneR = `hd;
                12'd188: toneR = `hd;     12'd189: toneR = `hd;
                12'd190: toneR = `hd;     12'd191: toneR = `hd;

                // --- Measure 4 ---
                
                12'd192: toneR = `hc;     12'd193: toneR = `hc; // HC (half-beat)
                12'd194: toneR = `hc;     12'd195: toneR = `hc;
                12'd196: toneR = `hc;     12'd197: toneR = `hc;
                12'd198: toneR = `hc;     12'd199: toneR = `hc;
                12'd200: toneR = `he;     12'd201: toneR = `he; // HD (half-beat)
                12'd202: toneR = `he;     12'd203: toneR = `he;
                12'd204: toneR = `he;     12'd205: toneR = `he;
                12'd206: toneR = `he;     12'd207: toneR = `he;

                12'd208: toneR = `hg;     12'd209: toneR = `hg; // HE (half-beat)
                12'd210: toneR = `hg;     12'd211: toneR = `hg;
                12'd212: toneR = `hg;     12'd213: toneR = `hg;
                12'd214: toneR = `hg;     12'd215: toneR = `sil;
                12'd216: toneR = `hg;     12'd217: toneR = `hg; // HF (half-beat)
                12'd218: toneR = `hg;     12'd219: toneR = `hg;
                12'd220: toneR = `hg;     12'd221: toneR = `hg;
                12'd222: toneR = `hg;     12'd223: toneR = `hg;

                12'd224: toneR = `he;     12'd225: toneR = `he; // HG (half-beat)
                12'd226: toneR = `he;     12'd227: toneR = `he;
                12'd228: toneR = `he;     12'd229: toneR = `he;
                12'd230: toneR = `he;     12'd231: toneR = `he; // (Short break for repetitive notes: high D)
                12'd232: toneR = `he;     12'd233: toneR = `he; // HG (half-beat)
                12'd234: toneR = `he;     12'd235: toneR = `he;
                12'd236: toneR = `he;     12'd237: toneR = `he;
                12'd238: toneR = `he;     12'd239: toneR = `he; // (Short break for repetitive notes: high D)

                12'd240: toneR = `he;     12'd241: toneR = `he; // HG (one-beat)
                12'd242: toneR = `he;     12'd243: toneR = `he;
                12'd244: toneR = `he;     12'd245: toneR = `he;
                12'd246: toneR = `he;     12'd247: toneR = `he;
                12'd248: toneR = `he;     12'd249: toneR = `he;
                12'd250: toneR = `he;     12'd251: toneR = `he;
                12'd252: toneR = `he;     12'd253: toneR = `he;
                12'd254: toneR = `he;     12'd255: toneR = `he;
                
                // --- Measure 5 ---
                
                12'd256: toneR = `hd;     12'd257: toneR = `hd; // HG (half-beat)
                12'd258: toneR = `hd;     12'd259: toneR = `hd;
                12'd260: toneR = `hd;     12'd261: toneR = `hd;
                12'd262: toneR = `hd;     12'd263: toneR = `sil;
                12'd264: toneR = `hd;     12'd265: toneR = `hd; // HE (half-beat)
                12'd266: toneR = `hd;     12'd267: toneR = `hd;
                12'd268: toneR = `hd;     12'd269: toneR = `hd;
                12'd270: toneR = `hd;     12'd271: toneR = `sil; // (Short break for repetitive notes: high E)

                12'd272: toneR = `hd;     12'd273: toneR = `hd; // HE (one-beat)
                12'd274: toneR = `hd;     12'd275: toneR = `hd;
                12'd276: toneR = `hd;     12'd277: toneR = `hd;
                12'd278: toneR = `hd;     12'd279: toneR = `sil;
                12'd280: toneR = `hd;     12'd281: toneR = `hd;
                12'd282: toneR = `hd;     12'd283: toneR = `hd;
                12'd284: toneR = `hd;     12'd285: toneR = `hd;
                12'd286: toneR = `hd;     12'd287: toneR = `sil;

                12'd288: toneR = `hd;     12'd289: toneR = `hd; // HF (half-beat)
                12'd290: toneR = `hd;     12'd291: toneR = `hd;
                12'd292: toneR = `hd;     12'd293: toneR = `hd;
                12'd294: toneR = `hd;     12'd295: toneR = `hd;
                12'd296: toneR = `he;     12'd297: toneR = `he; // HD (half-beat)
                12'd298: toneR = `he;     12'd299: toneR = `he;
                12'd300: toneR = `he;     12'd301: toneR = `he;
                12'd302: toneR = `he;     12'd303: toneR = `he; // (Short break for repetitive notes: high D)

                12'd304: toneR = `hf;     12'd305: toneR = `hf; // HD (one-beat)
                12'd306: toneR = `hf;     12'd307: toneR = `hf;
                12'd308: toneR = `hf;     12'd309: toneR = `hf;
                12'd310: toneR = `hf;     12'd311: toneR = `hf;
                12'd312: toneR = `hf;     12'd313: toneR = `hf;
                12'd314: toneR = `hf;     12'd315: toneR = `hf;
                12'd316: toneR = `hf;     12'd317: toneR = `hf;
                12'd318: toneR = `hf;     12'd319: toneR = `hf;

                // --- Measure 6 ---
                
                12'd320: toneR = `he;     12'd321: toneR = `he; // HC (half-beat)
                12'd322: toneR = `he;     12'd323: toneR = `he;
                12'd324: toneR = `he;     12'd325: toneR = `he;
                12'd326: toneR = `he;     12'd327: toneR = `sil;
                12'd328: toneR = `he;      12'd329: toneR = `he; // la (half-beat)
                12'd330: toneR = `he;      12'd331: toneR = `he;
                12'd332: toneR = `he;      12'd333: toneR = `he;
                12'd334: toneR = `he;      12'd335: toneR = `sil;
                
                12'd336: toneR = `he;     12'd337: toneR = `he; // HE (half-beat)
                12'd338: toneR = `he;     12'd339: toneR = `he;
                12'd340: toneR = `he;     12'd341: toneR = `he;
                12'd342: toneR = `he;     12'd343: toneR = `sil;
                12'd344: toneR = `he;     12'd345: toneR = `he; // HF (half-beat)
                12'd346: toneR = `he;     12'd347: toneR = `he;
                12'd348: toneR = `he;     12'd349: toneR = `he;
                12'd350: toneR = `he;     12'd351: toneR = `sil;

                12'd352: toneR = `he;     12'd353: toneR = `he; // HG (half-beat)
                12'd354: toneR = `he;     12'd355: toneR = `he;
                12'd356: toneR = `he;     12'd357: toneR = `he;
                12'd358: toneR = `he;     12'd359: toneR = `he; // (Short break for repetitive notes: high D)
                12'd360: toneR = `hf;     12'd361: toneR = `hf; // HG (half-beat)
                12'd362: toneR = `hf;     12'd363: toneR = `hf;
                12'd364: toneR = `hf;     12'd365: toneR = `hf;
                12'd366: toneR = `hf;     12'd367: toneR = `hf; // (Short break for repetitive notes: high D)

                12'd368: toneR = `hg;     12'd369: toneR = `hg; // HG (one-beat)
                12'd370: toneR = `hg;     12'd371: toneR = `hg;
                12'd372: toneR = `hg;     12'd373: toneR = `hg;
                12'd374: toneR = `hg;     12'd375: toneR = `hg;
                12'd376: toneR = `hg;     12'd377: toneR = `hg;
                12'd378: toneR = `hg;     12'd379: toneR = `hg;
                12'd380: toneR = `hg;     12'd381: toneR = `hg;
                12'd382: toneR = `hg;     12'd383: toneR = `sil;

                // --- Measure 7 ---
                
                12'd384: toneR = `hg;      12'd385: toneR = `hg; // HG (half-beat)
                12'd386: toneR = `hg;      12'd387: toneR = `hg;
                12'd388: toneR = `hg;      12'd389: toneR = `hg;
                12'd390: toneR = `hg;      12'd391: toneR = `hg;
                12'd392: toneR = `he;      12'd393: toneR = `he; // HE (half-beat)
                12'd394: toneR = `he;     12'd395: toneR = `he;
                12'd396: toneR = `he;     12'd397: toneR = `he;
                12'd398: toneR = `he;     12'd399: toneR = `sil; // (Short break for repetitive notes: high E)

                12'd400: toneR = `he;     12'd401: toneR = `he; // HE (one-beat)
                12'd402: toneR = `he;     12'd403: toneR = `he;
                12'd404: toneR = `he;     12'd405: toneR = `he;
                12'd406: toneR = `he;     12'd407: toneR = `he;
                12'd408: toneR = `he;     12'd409: toneR = `he;
                12'd410: toneR = `he;     12'd411: toneR = `he;
                12'd412: toneR = `he;     12'd413: toneR = `he;
                12'd414: toneR = `he;     12'd415: toneR = `he;

                12'd416: toneR = `hf;     12'd417: toneR = `hf; // HF (half-beat)
                12'd418: toneR = `hf;     12'd419: toneR = `hf;
                12'd420: toneR = `hf;     12'd421: toneR = `hf;
                12'd422: toneR = `hf;     12'd423: toneR = `hf;
                12'd424: toneR = `hd;     12'd425: toneR = `hd; // lef (half-beat)
                12'd426: toneR = `hd;     12'd427: toneR = `hd;
                12'd428: toneR = `hd;     12'd429: toneR = `hd;
                12'd430: toneR = `hd;     12'd431: toneR = `sil; // (Short break for repetitive notes: high D)

                12'd432: toneR = `hd;     12'd433: toneR = `hd; // HD (one-beat)
                12'd434: toneR = `hd;     12'd435: toneR = `hd;
                12'd436: toneR = `hd;     12'd437: toneR = `hd;
                12'd438: toneR = `hd;     12'd439: toneR = `hd;
                12'd440: toneR = `hd;     12'd441: toneR = `hd;
                12'd442: toneR = `hd;     12'd443: toneR = `hd;
                12'd444: toneR = `hd;     12'd445: toneR = `hd;
                12'd446: toneR = `hd;     12'd447: toneR = `hd;
                
                // --- Measure 8 ---
                
                12'd448: toneR = `hc;     12'd449: toneR = `hc; // HC (half-beat)
                12'd450: toneR = `hc;     12'd451: toneR = `hc;
                12'd452: toneR = `hc;     12'd453: toneR = `hc;
                12'd454: toneR = `hc;     12'd455: toneR = `hc;
                12'd456: toneR = `he;      12'd457: toneR = `he; // HD (half-beat)
                12'd458: toneR = `he;      12'd459: toneR = `he;
                12'd460: toneR = `he;      12'd461: toneR = `he;
                12'd462: toneR = `he;      12'd463: toneR = `he;

                12'd464: toneR = `hg;    12'd465: toneR = `hg; // HE (half-beat)
                12'd466: toneR = `hg;    12'd467: toneR = `hg;
                12'd468: toneR = `hg;    12'd469: toneR = `hg;
                12'd470: toneR = `hg;    12'd471: toneR = `sil;
                12'd472: toneR = `hg;     12'd473: toneR = `hg; // HF (half-beat)
                12'd474: toneR = `hg;     12'd475: toneR = `hg;
                12'd476: toneR = `hg;     12'd477: toneR = `hg;
                12'd478: toneR = `hg;     12'd479: toneR = `hg;

                12'd480: toneR = `hc;      12'd481: toneR = `hc; // HG (half-beat)
                12'd482: toneR = `hc;      12'd483: toneR = `hc;
                12'd484: toneR = `hc;      12'd485: toneR = `hc;
                12'd486: toneR = `hc;      12'd487: toneR = `hc; // (Short break for repetitive notes: high D)
                12'd488: toneR = `hc;     12'd489: toneR = `hc; // HG (half-beat)
                12'd490: toneR = `hc;     12'd491: toneR = `hc;
                12'd492: toneR = `hc;     12'd493: toneR = `hc;
                12'd494: toneR = `hc;     12'd495: toneR = `hc; // (Short break for repetitive notes: high D)

                12'd496: toneR = `hc;     12'd497: toneR = `hc; // HG (one-beat)
                12'd498: toneR = `hc;     12'd499: toneR = `hc;
                12'd500: toneR = `hc;     12'd501: toneR = `hc;
                12'd502: toneR = `hc;     12'd503: toneR = `hc;
                12'd504: toneR = `hc;    12'd505: toneR = `hc;
                12'd506: toneR = `hc;    12'd507: toneR = `hc;
                12'd508: toneR = `hc;    12'd509: toneR = `hc;
                12'd510: toneR = `hc;    12'd511: toneR = `hc;
                
                default: toneR = `sil;
            endcase
        end else if(en && !music) begin
            case(ibeatNum)
                
                // --- Measure 1 ---
                
                12'd0: toneR = `hd;      12'd1: toneR = `hd; // HG (half-beat)
                12'd2: toneR = `hd;      12'd3: toneR = `hd;
                12'd4: toneR = `hd;      12'd5: toneR = `hd;
                12'd6: toneR = `hd;      12'd7: toneR = `sil;
                12'd8: toneR = `hd;      12'd9: toneR = `hd; // HE (half-beat)
                12'd10: toneR = `hd;     12'd11: toneR = `hd;
                12'd12: toneR = `hd;     12'd13: toneR = `hd;
                12'd14: toneR = `hd;     12'd15: toneR = `hd; // (Short break for repetitive notes: high E)

                12'd16: toneR = `bf;     12'd17: toneR = `bf; // HE (one-beat)
                12'd18: toneR = `bf;     12'd19: toneR = `bf;
                12'd20: toneR = `bf;     12'd21: toneR = `bf;
                12'd22: toneR = `bf;     12'd23: toneR = `sil;
                12'd24: toneR = `bf;     12'd25: toneR = `bf;
                12'd26: toneR = `bf;     12'd27: toneR = `bf;
                12'd28: toneR = `bf;     12'd29: toneR = `bf;
                12'd30: toneR = `bf;     12'd31: toneR = `bf;

                12'd32: toneR = `g;     12'd33: toneR = `g; // HF (half-beat)
                12'd34: toneR = `g;     12'd35: toneR = `g;
                12'd36: toneR = `g;     12'd37: toneR = `g;
                12'd38: toneR = `g;     12'd39: toneR = `g;
                12'd40: toneR = `g;     12'd41: toneR = `g; // HD (half-beat)
                12'd42: toneR = `g;     12'd43: toneR = `g;
                12'd44: toneR = `g;     12'd45: toneR = `g;
                12'd46: toneR = `g;     12'd47: toneR = `g; // (Short break for repetitive notes: high D)

                12'd48: toneR = `sil;     12'd49: toneR = `sil; // HD (one-beat)
                12'd50: toneR = `sil;     12'd51: toneR = `sil;
                12'd52: toneR = `sil;     12'd53: toneR = `sil;
                12'd54: toneR = `sil;     12'd55: toneR = `sil;
                12'd56: toneR = `sil;     12'd57: toneR = `sil;
                12'd58: toneR = `sil;     12'd59: toneR = `sil;
                12'd60: toneR = `sil;     12'd61: toneR = `sil;
                12'd62: toneR = `sil;     12'd63: toneR = `sil;

                // --- Measure 2 ---
                
                12'd64: toneR = `sil;     12'd65: toneR = `sil; // HC (half-beat)
                12'd66: toneR = `sil;     12'd67: toneR = `sil;
                12'd68: toneR = `sil;     12'd69: toneR = `sil;
                12'd70: toneR = `sil;     12'd71: toneR = `sil;
                12'd72: toneR = `hd;     12'd73: toneR = `hd; // HD (half-beat)
                12'd74: toneR = `hd;     12'd75: toneR = `hd;
                12'd76: toneR = `hd;     12'd77: toneR = `hd;
                12'd78: toneR = `hd;     12'd79: toneR = `hd;

                12'd80: toneR = `hc;     12'd81: toneR = `hc; // HE (half-beat)
                12'd82: toneR = `hc;     12'd83: toneR = `hc;
                12'd84: toneR = `hc;     12'd85: toneR = `hc;
                12'd86: toneR = `hc;     12'd87: toneR = `hc;
                12'd88: toneR = `hd;     12'd89: toneR = `hd; // HF (half-beat)
                12'd90: toneR = `hd;     12'd91: toneR = `hd;
                12'd92: toneR = `hd;     12'd93: toneR = `hd;
                12'd94: toneR = `hd;     12'd95: toneR = `hd;

                12'd96: toneR = `hef;     12'd97: toneR = `hef; // HG (half-beat)
                12'd98: toneR = `hef;     12'd99: toneR = `hef;
                12'd100: toneR = `hef;     12'd101: toneR = `hef;
                12'd102: toneR = `hef;     12'd103: toneR = `hef; // (Short break for repetitive notes: high D)
                12'd104: toneR = `hd;     12'd105: toneR = `hd; // HG (half-beat)
                12'd106: toneR = `hd;     12'd107: toneR = `hd;
                12'd108: toneR = `hd;     12'd109: toneR = `hd;
                12'd110: toneR = `hd;     12'd111: toneR = `hd; // (Short break for repetitive notes: high D)

                12'd112: toneR = `hc;     12'd113: toneR = `hc; // HG (one-beat)
                12'd114: toneR = `hc;     12'd115: toneR = `hc;
                12'd116: toneR = `hc;     12'd117: toneR = `hc;
                12'd118: toneR = `hc;     12'd119: toneR = `hc;
                12'd120: toneR = `bf;     12'd121: toneR = `bf;
                12'd122: toneR = `bf;     12'd123: toneR = `bf;
                12'd124: toneR = `bf;     12'd125: toneR = `bf;
                12'd126: toneR = `bf;     12'd127: toneR = `bf;
                
                // --- Measure 3 ---
                
                12'd128: toneR = `hd;     12'd129: toneR = `hd; // HG (half-beat)
                12'd130: toneR = `hd;     12'd131: toneR = `hd;
                12'd132: toneR = `hd;     12'd133: toneR = `hd;
                12'd134: toneR = `hd;     12'd135: toneR = `sil;
                12'd136: toneR = `hd;     12'd137: toneR = `hd; // HE (half-beat)
                12'd138: toneR = `hd;     12'd139: toneR = `hd;
                12'd140: toneR = `hd;     12'd141: toneR = `hd;
                12'd142: toneR = `hd;     12'd143: toneR = `hd; // (Short break for repetitive notes: high E)

                12'd144: toneR = `bf;     12'd145: toneR = `bf; // HE (one-beat)
                12'd146: toneR = `bf;     12'd147: toneR = `bf;
                12'd148: toneR = `bf;     12'd149: toneR = `bf;
                12'd150: toneR = `bf;     12'd151: toneR = `sil;
                12'd152: toneR = `bf;     12'd153: toneR = `bf;
                12'd154: toneR = `bf;     12'd155: toneR = `bf;
                12'd156: toneR = `bf;     12'd157: toneR = `bf;
                12'd158: toneR = `bf;     12'd159: toneR = `bf;

                12'd160: toneR = `g;     12'd161: toneR = `g; // HF (half-beat)
                12'd162: toneR = `g;     12'd163: toneR = `g;
                12'd164: toneR = `g;     12'd165: toneR = `g;
                12'd166: toneR = `g;     12'd167: toneR = `g;
                12'd168: toneR = `g;     12'd169: toneR = `g; // HD (half-beat)
                12'd170: toneR = `g;     12'd171: toneR = `g;
                12'd172: toneR = `g;     12'd173: toneR = `g;
                12'd174: toneR = `g;     12'd175: toneR = `g; // (Short break for repetitive notes: high D)

                12'd176: toneR = `sil;     12'd177: toneR = `sil; // HD (one-beat)
                12'd178: toneR = `sil;     12'd179: toneR = `sil;
                12'd180: toneR = `sil;     12'd181: toneR = `sil;
                12'd182: toneR = `sil;     12'd183: toneR = `sil;
                12'd184: toneR = `sil;     12'd185: toneR = `sil;
                12'd186: toneR = `sil;     12'd187: toneR = `sil;
                12'd188: toneR = `sil;     12'd189: toneR = `sil;
                12'd190: toneR = `sil;     12'd191: toneR = `sil;

                // --- Measure 4 ---
                
                12'd192: toneR = `sil;     12'd193: toneR = `sil; // HC (half-beat)
                12'd194: toneR = `sil;     12'd195: toneR = `sil;
                12'd196: toneR = `sil;     12'd197: toneR = `sil;
                12'd198: toneR = `sil;     12'd199: toneR = `sil;
                12'd200: toneR = `hd;      12'd201: toneR = `hd; // HD (half-beat)
                12'd202: toneR = `hd;      12'd203: toneR = `hd;
                12'd204: toneR = `hd;      12'd205: toneR = `hd;
                12'd206: toneR = `hd;      12'd207: toneR = `hd;

                12'd208: toneR = `hc;     12'd209: toneR = `hc; // HE (half-beat)
                12'd210: toneR = `hc;     12'd211: toneR = `hc;
                12'd212: toneR = `hc;     12'd213: toneR = `hc;
                12'd214: toneR = `hc;     12'd215: toneR = `hc;
                12'd216: toneR = `hd;     12'd217: toneR = `hd; // HF (half-beat)
                12'd218: toneR = `hd;     12'd219: toneR = `hd;
                12'd220: toneR = `hd;     12'd221: toneR = `hd;
                12'd222: toneR = `hd;     12'd223: toneR = `hd;

                12'd224: toneR = `hef;     12'd225: toneR = `hef; // HG (half-beat)
                12'd226: toneR = `hef;     12'd227: toneR = `hef;
                12'd228: toneR = `hef;     12'd229: toneR = `hef;
                12'd230: toneR = `hef;     12'd231: toneR = `hef; // (Short break for repetitive notes: high D)
                12'd232: toneR = `hd;     12'd233: toneR = `hd; // HG (half-beat)
                12'd234: toneR = `hd;     12'd235: toneR = `hd;
                12'd236: toneR = `hd;     12'd237: toneR = `hd;
                12'd238: toneR = `hd;     12'd239: toneR = `hd; // (Short break for repetitive notes: high D)

                12'd240: toneR = `hc;     12'd241: toneR = `hc; // HG (one-beat)
                12'd242: toneR = `hc;     12'd243: toneR = `hc;
                12'd244: toneR = `hc;     12'd245: toneR = `hc;
                12'd246: toneR = `hc;     12'd247: toneR = `hc;
                12'd248: toneR = `bf;     12'd249: toneR = `bf;
                12'd250: toneR = `bf;     12'd251: toneR = `bf;
                12'd252: toneR = `bf;     12'd253: toneR = `bf;
                12'd254: toneR = `bf;     12'd255: toneR = `bf;

                // --- Measure 5 ---
                
                12'd256: toneR = `hd;     12'd257: toneR = `hd; // HG (half-beat)
                12'd258: toneR = `hd;     12'd259: toneR = `hd;
                12'd260: toneR = `hd;     12'd261: toneR = `hd;
                12'd262: toneR = `hd;     12'd263: toneR = `sil;
                12'd264: toneR = `hd;     12'd265: toneR = `hd; // HE (half-beat)
                12'd266: toneR = `hd;     12'd267: toneR = `hd;
                12'd268: toneR = `hd;     12'd269: toneR = `hd;
                12'd270: toneR = `hd;     12'd271: toneR = `hd; // (Short break for repetitive notes: high E)

                12'd272: toneR = `bf;     12'd273: toneR = `bf; // HE (one-beat)
                12'd274: toneR = `bf;     12'd275: toneR = `bf;
                12'd276: toneR = `bf;     12'd277: toneR = `bf;
                12'd278: toneR = `bf;     12'd279: toneR = `sil;
                12'd280: toneR = `bf;     12'd281: toneR = `bf;
                12'd282: toneR = `bf;     12'd283: toneR = `bf;
                12'd284: toneR = `bf;     12'd285: toneR = `bf;
                12'd286: toneR = `bf;     12'd287: toneR = `bf;

                12'd288: toneR = `g;     12'd289: toneR = `g; // HF (half-beat)
                12'd290: toneR = `g;     12'd291: toneR = `g;
                12'd292: toneR = `g;     12'd293: toneR = `g;
                12'd294: toneR = `g;     12'd295: toneR = `g;
                12'd296: toneR = `g;     12'd297: toneR = `g; // HD (half-beat)
                12'd298: toneR = `g;     12'd299: toneR = `g;
                12'd300: toneR = `g;     12'd301: toneR = `g;
                12'd302: toneR = `g;     12'd303: toneR = `g; // (Short break for repetitive notes: high D)

                12'd304: toneR = `sil;     12'd305: toneR = `sil; // HD (one-beat)
                12'd306: toneR = `sil;     12'd307: toneR = `sil;
                12'd308: toneR = `sil;     12'd309: toneR = `sil;
                12'd310: toneR = `sil;     12'd311: toneR = `sil;
                12'd312: toneR = `sil;     12'd313: toneR = `sil;
                12'd314: toneR = `sil;     12'd315: toneR = `sil;
                12'd316: toneR = `sil;     12'd317: toneR = `sil;
                12'd318: toneR = `sil;     12'd319: toneR = `sil;

                // --- Measure 6 ---
                
                12'd320: toneR = `sil;     12'd321: toneR = `sil; // HC (half-beat)
                12'd322: toneR = `sil;     12'd323: toneR = `sil;
                12'd324: toneR = `sil;     12'd325: toneR = `sil;
                12'd326: toneR = `sil;     12'd327: toneR = `sil;
                12'd328: toneR = `hd;      12'd329: toneR = `hd; // HD (half-beat)
                12'd330: toneR = `hd;      12'd331: toneR = `hd;
                12'd332: toneR = `hd;      12'd333: toneR = `hd;
                12'd334: toneR = `hd;      12'd335: toneR = `hd;
                
                12'd336: toneR = `hc;     12'd337: toneR = `hc; // HE (half-beat)
                12'd338: toneR = `hc;     12'd339: toneR = `hc;
                12'd340: toneR = `hc;     12'd341: toneR = `hc;
                12'd342: toneR = `hc;     12'd343: toneR = `hc;
                12'd344: toneR = `hd;     12'd345: toneR = `hd; // HF (half-beat)
                12'd346: toneR = `hd;     12'd347: toneR = `hd;
                12'd348: toneR = `hd;     12'd349: toneR = `hd;
                12'd350: toneR = `hd;     12'd351: toneR = `hd;

                12'd352: toneR = `hef;     12'd353: toneR = `hef; // HG (half-beat)
                12'd354: toneR = `hef;     12'd355: toneR = `hef;
                12'd356: toneR = `hef;     12'd357: toneR = `hef;
                12'd358: toneR = `hef;     12'd359: toneR = `hef; // (Short break for repetitive notes: high D)
                12'd360: toneR = `hd;     12'd361: toneR = `hd; // HG (half-beat)
                12'd362: toneR = `hd;     12'd363: toneR = `hd;
                12'd364: toneR = `hd;     12'd365: toneR = `hd;
                12'd366: toneR = `hd;     12'd367: toneR = `hd; // (Short break for repetitive notes: high D)

                12'd368: toneR = `hc;     12'd369: toneR = `hc; // HG (one-beat)
                12'd370: toneR = `hc;     12'd371: toneR = `hc;
                12'd372: toneR = `hc;     12'd373: toneR = `hc;
                12'd374: toneR = `hc;     12'd375: toneR = `hc;
                12'd376: toneR = `bf;     12'd377: toneR = `bf;
                12'd378: toneR = `bf;     12'd379: toneR = `bf;
                12'd380: toneR = `bf;     12'd381: toneR = `bf;
                12'd382: toneR = `bf;     12'd383: toneR = `bf;

                // --- Measure 7 ---
                
                12'd384: toneR = `hd;      12'd385: toneR = `hd; // HG (half-beat)
                12'd386: toneR = `hd;      12'd387: toneR = `hd;
                12'd388: toneR = `hd;      12'd389: toneR = `hd;
                12'd390: toneR = `hd;      12'd391: toneR = `hd;
                12'd392: toneR = `bf;      12'd393: toneR = `bf; // HE (half-beat)
                12'd394: toneR = `bf;     12'd395: toneR = `bf;
                12'd396: toneR = `bf;     12'd397: toneR = `bf;
                12'd398: toneR = `bf;     12'd399: toneR = `bf; // (Short break for repetitive notes: high E)

                12'd400: toneR = `sil;     12'd401: toneR = `sil; // HE (one-beat)
                12'd402: toneR = `sil;     12'd403: toneR = `sil;
                12'd404: toneR = `sil;     12'd405: toneR = `sil;
                12'd406: toneR = `sil;     12'd407: toneR = `sil;
                12'd408: toneR = `hd;     12'd409: toneR = `hd;
                12'd410: toneR = `hd;     12'd411: toneR = `hd;
                12'd412: toneR = `hd;     12'd413: toneR = `hd;
                12'd414: toneR = `hd;     12'd415: toneR = `hd;

                12'd416: toneR = `hc;     12'd417: toneR = `hc; // HF (half-beat)
                12'd418: toneR = `hc;     12'd419: toneR = `hc;
                12'd420: toneR = `hc;     12'd421: toneR = `hc;
                12'd422: toneR = `hc;     12'd423: toneR = `hc;
                12'd424: toneR = `hd;     12'd425: toneR = `hd; // HD (half-beat)
                12'd426: toneR = `hd;     12'd427: toneR = `hd;
                12'd428: toneR = `hd;     12'd429: toneR = `hd;
                12'd430: toneR = `hd;     12'd431: toneR = `hd; // (Short break for repetitive notes: high D)

                12'd432: toneR = `hc;     12'd433: toneR = `hc; // HD (one-beat)
                12'd434: toneR = `hc;     12'd435: toneR = `hc;
                12'd436: toneR = `hc;     12'd437: toneR = `hc;
                12'd438: toneR = `hc;     12'd439: toneR = `hc;
                12'd440: toneR = `bf;     12'd441: toneR = `bf;
                12'd442: toneR = `bf;     12'd443: toneR = `bf;
                12'd444: toneR = `bf;     12'd445: toneR = `bf;
                12'd446: toneR = `bf;     12'd447: toneR = `bf;
                
                // --- Measure 8 ---
                
                12'd448: toneR = `hd;     12'd449: toneR = `hd; // HC (half-beat)
                12'd450: toneR = `hd;     12'd451: toneR = `hd;
                12'd452: toneR = `hd;     12'd453: toneR = `hd;
                12'd454: toneR = `hd;     12'd455: toneR = `hd;
                12'd456: toneR = `a;      12'd457: toneR = `a; // HD (half-beat)
                12'd458: toneR = `a;      12'd459: toneR = `a;
                12'd460: toneR = `a;      12'd461: toneR = `a;
                12'd462: toneR = `a;      12'd463: toneR = `a;

                12'd464: toneR = `sil;    12'd465: toneR = `sil; // HE (half-beat)
                12'd466: toneR = `sil;    12'd467: toneR = `sil;
                12'd468: toneR = `sil;    12'd469: toneR = `sil;
                12'd470: toneR = `sil;    12'd471: toneR = `sil;
                12'd472: toneR = `bf;     12'd473: toneR = `bf; // HF (half-beat)
                12'd474: toneR = `bf;     12'd475: toneR = `bf;
                12'd476: toneR = `bf;     12'd477: toneR = `bf;
                12'd478: toneR = `bf;     12'd479: toneR = `bf;

                12'd480: toneR = `a;      12'd481: toneR = `a; // HG (half-beat)
                12'd482: toneR = `a;      12'd483: toneR = `a;
                12'd484: toneR = `a;      12'd485: toneR = `a;
                12'd486: toneR = `a;      12'd487: toneR = `a; // (Short break for repetitive notes: high D)
                12'd488: toneR = `bf;     12'd489: toneR = `bf; // HG (half-beat)
                12'd490: toneR = `bf;     12'd491: toneR = `bf;
                12'd492: toneR = `bf;     12'd493: toneR = `bf;
                12'd494: toneR = `bf;     12'd495: toneR = `bf; // (Short break for repetitive notes: high D)

                12'd496: toneR = `a;     12'd497: toneR = `a; // HG (one-beat)
                12'd498: toneR = `a;     12'd499: toneR = `a;
                12'd500: toneR = `a;     12'd501: toneR = `a;
                12'd502: toneR = `a;     12'd503: toneR = `a;
                12'd504: toneR = `bf;    12'd505: toneR = `bf;
                12'd506: toneR = `bf;    12'd507: toneR = `bf;
                12'd508: toneR = `bf;    12'd509: toneR = `bf;
                12'd510: toneR = `bf;    12'd511: toneR = `bf;
                
                default: toneR = `sil;
            endcase
        end else begin
            toneR = `sil;
        end
    end

    always @(*) begin
        if(en && music)begin
            case(ibeatNum)
                //Lightly Row

                // --- Measure 1 ---
             
                12'd0: toneL = `c;  	    12'd1: toneL = `c; // HC (two-beat)
                12'd2: toneL = `c;  	    12'd3: toneL = `c;
                12'd4: toneL = `c;	        12'd5: toneL = `c;
                12'd6: toneL = `c;  	    12'd7: toneL = `c;
                12'd8: toneL = `c;	        12'd9: toneL = `c;
                12'd10: toneL = `c;     	12'd11: toneL = `c;
                12'd12: toneL = `c;	        12'd13: toneL = `c;
                12'd14: toneL = `c;	        12'd15: toneL = `c;

                12'd16: toneL = `c;     	12'd17: toneL = `c;
                12'd18: toneL = `c;     	12'd19: toneL = `c;
                12'd20: toneL = `c;      	12'd21: toneL = `c;
                12'd22: toneL = `c;	        12'd23: toneL = `c;
                12'd24: toneL = `c;	        12'd25: toneL = `c;
                12'd26: toneL = `c;     	12'd27: toneL = `c;
                12'd28: toneL = `c;     	12'd29: toneL = `c;
                12'd30: toneL = `c;     	12'd31: toneL = `c;

                12'd32: toneL = `lg;	    12'd33: toneL = `lg; // G (one-beat)
                12'd34: toneL = `lg;	    12'd35: toneL = `lg;
                12'd36: toneL = `lg;	    12'd37: toneL = `lg;
                12'd38: toneL = `lg;	    12'd39: toneL = `lg;
                12'd40: toneL = `lg;	    12'd41: toneL = `lg;
                12'd42: toneL = `lg;	    12'd43: toneL = `lg;
                12'd44: toneL = `lg;	    12'd45: toneL = `lg;
                12'd46: toneL = `lg;	    12'd47: toneL = `lg;

                12'd48: toneL = `lb;	    12'd49: toneL = `lb; // B (one-beat)
                12'd50: toneL = `lb;	    12'd51: toneL = `lb;
                12'd52: toneL = `lb;	    12'd53: toneL = `lb;
                12'd54: toneL = `lb;	    12'd55: toneL = `lb;
                12'd56: toneL = `lb;	    12'd57: toneL = `lb;
                12'd58: toneL = `lb;	    12'd59: toneL = `lb;
                12'd60: toneL = `lb;	    12'd61: toneL = `lb;
                12'd62: toneL = `lb;	    12'd63: toneL = `lb;

                12'd64: toneL = `c;	    12'd65: toneL = `c; // HC (two-beat)
                12'd66: toneL = `c;	    12'd67: toneL = `c;
                12'd68: toneL = `c;	    12'd69: toneL = `c;
                12'd70: toneL = `c;	    12'd71: toneL = `c;
                12'd72: toneL = `c;	    12'd73: toneL = `c;
                12'd74: toneL = `c;	    12'd75: toneL = `c;
                12'd76: toneL = `c;	    12'd77: toneL = `c;
                12'd78: toneL = `c;	    12'd79: toneL = `c;

                12'd80: toneL = `c;	    12'd81: toneL = `c;
                12'd82: toneL = `c;	    12'd83: toneL = `c;
                12'd84: toneL = `c;	    12'd85: toneL = `c;
                12'd86: toneL = `c;	    12'd87: toneL = `c;
                12'd88: toneL = `c;	    12'd89: toneL = `c;
                12'd90: toneL = `c;	    12'd91: toneL = `c;
                12'd92: toneL = `c;	    12'd93: toneL = `c;
                12'd94: toneL = `c;	    12'd95: toneL = `c;

                12'd96: toneL = `lg;	12'd97: toneL = `lg; // G (one-beat)
                12'd98: toneL = `lg; 	12'd99: toneL = `lg;
                12'd100: toneL = `lg;	12'd101: toneL = `lg;
                12'd102: toneL = `lg;	12'd103: toneL = `lg;
                12'd104: toneL = `lg;	12'd105: toneL = `lg;
                12'd106: toneL = `lg;	12'd107: toneL = `lg;
                12'd108: toneL = `lg;	12'd109: toneL = `lg;
                12'd110: toneL = `lg;	12'd111: toneL = `lg;

                12'd112: toneL = `lb;	12'd113: toneL = `lb; // B (one-beat)
                12'd114: toneL = `lb;	12'd115: toneL = `lb;
                12'd116: toneL = `lb;	12'd117: toneL = `lb;
                12'd118: toneL = `lb;	12'd119: toneL = `lb;
                12'd120: toneL = `lb;	12'd121: toneL = `lb;
                12'd122: toneL = `lb;	12'd123: toneL = `lb;
                12'd124: toneL = `lb;	12'd125: toneL = `lb;
                12'd126: toneL = `lb;	12'd127: toneL = `lb;

                // --- Measure 3 ---
                
                12'd128: toneL = `c;      12'd129: toneL = `c; // HG (half-beat)
                12'd130: toneL = `c;      12'd131: toneL = `c;
                12'd132: toneL = `c;      12'd133: toneL = `c;
                12'd134: toneL = `c;      12'd135: toneL = `c;
                12'd136: toneL = `c;      12'd137: toneL = `c; // HE (half-beat)
                12'd138: toneL = `c;     12'd139: toneL = `c;
                12'd140: toneL = `c;     12'd141: toneL = `c;
                12'd142: toneL = `c;     12'd143: toneL = `c; // (Short break for repetitive notes: high E)

                12'd144: toneL = `c;     12'd145: toneL = `c; // HE (one-beat)
                12'd146: toneL = `c;     12'd147: toneL = `c;
                12'd148: toneL = `c;     12'd149: toneL = `c;
                12'd150: toneL = `c;     12'd151: toneL = `c;
                12'd152: toneL = `c;     12'd153: toneL = `c;
                12'd154: toneL = `c;     12'd155: toneL = `c;
                12'd156: toneL = `c;     12'd157: toneL = `c;
                12'd158: toneL = `c;     12'd159: toneL = `c;

                12'd160: toneL = `lg;     12'd161: toneL = `lg; // HF (half-beat)
                12'd162: toneL = `lg;     12'd163: toneL = `lg;
                12'd164: toneL = `lg;     12'd165: toneL = `lg;
                12'd166: toneL = `lg;     12'd167: toneL = `lg;
                12'd168: toneL = `lg;     12'd169: toneL = `lg; // HD (half-beat)
                12'd170: toneL = `lg;     12'd171: toneL = `lg;
                12'd172: toneL = `lg;     12'd173: toneL = `lg;
                12'd174: toneL = `lg;     12'd175: toneL = `lg; // (Short break for repetitive notes: high D)

                12'd176: toneL = `lb;     12'd177: toneL = `lb; // HD (one-beat)
                12'd178: toneL = `lb;     12'd179: toneL = `lb;
                12'd180: toneL = `lb;     12'd181: toneL = `lb;
                12'd182: toneL = `lb;     12'd183: toneL = `lb;
                12'd184: toneL = `lb;     12'd185: toneL = `lb;
                12'd186: toneL = `lb;     12'd187: toneL = `lb;
                12'd188: toneL = `lb;     12'd189: toneL = `lb;
                12'd190: toneL = `lb;     12'd191: toneL = `lb;

                // --- Measure 4 ---
                
                12'd192: toneL = `c;     12'd193: toneL = `c; // HC (half-beat)
                12'd194: toneL = `c;     12'd195: toneL = `c;
                12'd196: toneL = `c;     12'd197: toneL = `c;
                12'd198: toneL = `c;     12'd199: toneL = `c;
                12'd200: toneL = `c;     12'd201: toneL = `c; // HD (half-beat)
                12'd202: toneL = `c;     12'd203: toneL = `c;
                12'd204: toneL = `c;     12'd205: toneL = `c;
                12'd206: toneL = `c;     12'd207: toneL = `c;

                12'd208: toneL = `lg;     12'd209: toneL = `lg; // lg (half-beat)
                12'd210: toneL = `lg;     12'd211: toneL = `lg;
                12'd212: toneL = `lg;     12'd213: toneL = `lg;
                12'd214: toneL = `lg;     12'd215: toneL = `lg;
                12'd216: toneL = `lg;     12'd217: toneL = `lg; // lg (half-beat)
                12'd218: toneL = `lg;     12'd219: toneL = `lg;
                12'd220: toneL = `lg;     12'd221: toneL = `lg;
                12'd222: toneL = `lg;     12'd223: toneL = `lg;

                12'd224: toneL = `le;     12'd225: toneL = `le; // c (half-beat)
                12'd226: toneL = `le;     12'd227: toneL = `le;
                12'd228: toneL = `le;     12'd229: toneL = `le;
                12'd230: toneL = `le;     12'd231: toneL = `le; // (Short break for repetitive notes: high D)
                12'd232: toneL = `le;     12'd233: toneL = `le; // c (half-beat)
                12'd234: toneL = `le;     12'd235: toneL = `le;
                12'd236: toneL = `le;     12'd237: toneL = `le;
                12'd238: toneL = `le;     12'd239: toneL = `le; // (Short break for repetitive notes: high D)

                12'd240: toneL = `lc;     12'd241: toneL = `lc; // c (one-beat)
                12'd242: toneL = `lc;     12'd243: toneL = `lc;
                12'd244: toneL = `lc;     12'd245: toneL = `lc;
                12'd246: toneL = `lc;     12'd247: toneL = `lc;
                12'd248: toneL = `lc;     12'd249: toneL = `lc;
                12'd250: toneL = `lc;     12'd251: toneL = `lc;
                12'd252: toneL = `lc;     12'd253: toneL = `lc;
                12'd254: toneL = `lc;     12'd257: toneL = `lc;
                
                // --- Measure 5 ---
                
                12'd256: toneL = `lg;     12'd257: toneL = `lg; // c (half-beat)
                12'd258: toneL = `lg;     12'd259: toneL = `lg;
                12'd260: toneL = `lg;     12'd261: toneL = `lg;
                12'd262: toneL = `lg;     12'd263: toneL = `lg;
                12'd264: toneL = `lg;     12'd265: toneL = `lg; // c (half-beat)
                12'd266: toneL = `lg;     12'd267: toneL = `lg;
                12'd268: toneL = `lg;     12'd269: toneL = `lg;
                12'd270: toneL = `lg;     12'd271: toneL = `lg; // (Short break for repetitive notes: high E)

                12'd272: toneL = `lg;     12'd273: toneL = `lg; // lg (one-beat)
                12'd274: toneL = `lg;     12'd275: toneL = `lg;
                12'd276: toneL = `lg;     12'd277: toneL = `lg;
                12'd278: toneL = `lg;     12'd279: toneL = `lg;
                12'd280: toneL = `lg;     12'd281: toneL = `lg;
                12'd282: toneL = `lg;     12'd283: toneL = `lg;
                12'd284: toneL = `lg;     12'd285: toneL = `lg;
                12'd286: toneL = `lg;     12'd287: toneL = `lg;

                12'd288: toneL = `lf;     12'd289: toneL = `lf; // lf (half-beat)
                12'd290: toneL = `lf;     12'd291: toneL = `lf;
                12'd292: toneL = `lf;     12'd293: toneL = `lf;
                12'd294: toneL = `lf;     12'd295: toneL = `lf;
                12'd296: toneL = `lf;     12'd297: toneL = `lf; // lf (half-beat)
                12'd298: toneL = `lf;     12'd299: toneL = `lf;
                12'd300: toneL = `lf;     12'd301: toneL = `lf;
                12'd302: toneL = `lf;     12'd303: toneL = `lf; // (Short break for repetitive notes: high D)

                12'd304: toneL = `ld;     12'd305: toneL = `ld; // ld (one-beat)
                12'd306: toneL = `ld;     12'd307: toneL = `ld;
                12'd308: toneL = `ld;     12'd309: toneL = `ld;
                12'd310: toneL = `ld;     12'd311: toneL = `ld;
                12'd312: toneL = `ld;     12'd313: toneL = `ld;
                12'd314: toneL = `ld;     12'd315: toneL = `ld;
                12'd316: toneL = `ld;     12'd317: toneL = `ld;
                12'd318: toneL = `ld;     12'd319: toneL = `ld;

                // --- Measure 6 ---
                
                12'd320: toneL = `le;     12'd321: toneL = `le; // Hle (half-beat)
                12'd322: toneL = `le;     12'd323: toneL = `le;
                12'd324: toneL = `le;     12'd325: toneL = `le;
                12'd326: toneL = `le;     12'd327: toneL = `le;
                12'd328: toneL = `le;      12'd329: toneL = `le; // la (half-beat)
                12'd330: toneL = `le;      12'd331: toneL = `le;
                12'd332: toneL = `le;      12'd333: toneL = `le;
                12'd334: toneL = `le;      12'd335: toneL = `le;
                
                12'd336: toneL = `le;     12'd337: toneL = `le; // le (half-beat)
                12'd338: toneL = `le;     12'd339: toneL = `le;
                12'd340: toneL = `le;     12'd341: toneL = `le;
                12'd342: toneL = `le;     12'd343: toneL = `le;
                12'd344: toneL = `le;     12'd345: toneL = `le; // le (half-beat)
                12'd346: toneL = `le;     12'd347: toneL = `le;
                12'd348: toneL = `le;     12'd349: toneL = `le;
                12'd350: toneL = `le;     12'd351: toneL = `le;

                12'd352: toneL = `lg;     12'd353: toneL = `lg; // lg (half-beat)
                12'd354: toneL = `lg;     12'd355: toneL = `lg;
                12'd356: toneL = `lg;     12'd357: toneL = `lg;
                12'd358: toneL = `lg;     12'd359: toneL = `lg; // (Short break for repetitive notes: high D)
                12'd360: toneL = `lg;     12'd361: toneL = `lg; // lg (half-beat)
                12'd362: toneL = `lg;     12'd363: toneL = `lg;
                12'd364: toneL = `lg;     12'd365: toneL = `lg;
                12'd366: toneL = `lg;     12'd367: toneL = `lg; // (Short break for repetitive notes: high D)

                12'd368: toneL = `lb;     12'd369: toneL = `lb; // lb (one-beat)
                12'd370: toneL = `lb;     12'd371: toneL = `lb;
                12'd372: toneL = `lb;     12'd373: toneL = `lb;
                12'd374: toneL = `lb;     12'd375: toneL = `lb;
                12'd376: toneL = `lb;     12'd377: toneL = `lb;
                12'd378: toneL = `lb;     12'd379: toneL = `lb;
                12'd380: toneL = `lb;     12'd381: toneL = `lb;
                12'd382: toneL = `lb;     12'd383: toneL = `lb;

                // --- Measure 7 ---
                
                12'd384: toneL = `c;      12'd385: toneL = `c; // c (half-beat)
                12'd386: toneL = `c;      12'd387: toneL = `c;
                12'd388: toneL = `c;      12'd389: toneL = `c;
                12'd390: toneL = `c;      12'd391: toneL = `c;
                12'd392: toneL = `c;      12'd393: toneL = `c; // c (half-beat)
                12'd394: toneL = `c;     12'd395: toneL = `c;
                12'd396: toneL = `c;     12'd397: toneL = `c;
                12'd398: toneL = `c;     12'd399: toneL = `c; // (Short break for repetitive notes: high E)

                12'd400: toneL = `c;     12'd401: toneL = `c; // c (one-beat)
                12'd402: toneL = `c;     12'd403: toneL = `c;
                12'd404: toneL = `c;     12'd405: toneL = `c;
                12'd406: toneL = `c;     12'd407: toneL = `c;
                12'd408: toneL = `c;     12'd409: toneL = `c;
                12'd410: toneL = `c;     12'd411: toneL = `c;
                12'd412: toneL = `c;     12'd413: toneL = `c;
                12'd414: toneL = `c;     12'd415: toneL = `c;

                12'd416: toneL = `lg;     12'd417: toneL = `lg; // lg (half-beat)
                12'd418: toneL = `lg;     12'd419: toneL = `lg;
                12'd420: toneL = `lg;     12'd421: toneL = `lg;
                12'd422: toneL = `lg;     12'd423: toneL = `lg;
                12'd424: toneL = `lg;     12'd425: toneL = `lg; // lef (half-beat)
                12'd426: toneL = `lg;     12'd427: toneL = `lg;
                12'd428: toneL = `lg;     12'd429: toneL = `lg;
                12'd430: toneL = `lg;     12'd431: toneL = `lg; // (Short break for repetitive notes: high D)

                12'd432: toneL = `lb;     12'd433: toneL = `lb; // lb (one-beat)
                12'd434: toneL = `lb;     12'd435: toneL = `lb;
                12'd436: toneL = `lb;     12'd437: toneL = `lb;
                12'd438: toneL = `lb;     12'd439: toneL = `lb;
                12'd440: toneL = `lb;     12'd441: toneL = `lb;
                12'd442: toneL = `lb;     12'd443: toneL = `lb;
                12'd444: toneL = `lb;     12'd445: toneL = `lb;
                12'd446: toneL = `lb;     12'd447: toneL = `lb;
                
                // --- Measure 8 ---
                
                12'd448: toneL = `c;     12'd449: toneL = `c; // HC (half-beat)
                12'd450: toneL = `c;     12'd451: toneL = `c;
                12'd452: toneL = `c;     12'd453: toneL = `c;
                12'd454: toneL = `c;     12'd455: toneL = `c;
                12'd456: toneL = `c;      12'd457: toneL = `c; // c (half-beat)
                12'd458: toneL = `c;      12'd459: toneL = `c;
                12'd460: toneL = `c;      12'd461: toneL = `c;
                12'd462: toneL = `c;      12'd463: toneL = `c;

                12'd464: toneL = `lg;    12'd465: toneL = `lg; // lg (half-beat)
                12'd466: toneL = `lg;    12'd467: toneL = `lg;
                12'd468: toneL = `lg;    12'd469: toneL = `lg;
                12'd470: toneL = `lg;    12'd471: toneL = `lg;
                12'd472: toneL = `lg;     12'd473: toneL = `lg; // lg (half-beat)
                12'd474: toneL = `lg;     12'd475: toneL = `lg;
                12'd476: toneL = `lg;     12'd477: toneL = `lg;
                12'd478: toneL = `lg;     12'd479: toneL = `lg;

                12'd480: toneL = `c;      12'd481: toneL = `c; // c (half-beat)
                12'd482: toneL = `c;      12'd483: toneL = `c;
                12'd484: toneL = `c;      12'd485: toneL = `c;
                12'd486: toneL = `c;      12'd487: toneL = `c; // (Short break for repetitive notes: high D)
                12'd488: toneL = `c;     12'd489: toneL = `c; // c (half-beat)
                12'd490: toneL = `c;     12'd491: toneL = `c;
                12'd492: toneL = `c;     12'd493: toneL = `c;
                12'd494: toneL = `c;     12'd495: toneL = `c; // (Short break for repetitive notes: high D)

                12'd496: toneL = `lc;     12'd497: toneL = `lc; // lc (one-beat)
                12'd498: toneL = `lc;     12'd499: toneL = `lc;
                12'd500: toneL = `lc;     12'd501: toneL = `lc;
                12'd502: toneL = `lc;     12'd503: toneL = `lc;
                12'd504: toneL = `lc;    12'd505: toneL = `lc;
                12'd506: toneL = `lc;    12'd507: toneL = `lc;
                12'd508: toneL = `lc;    12'd509: toneL = `lc;
                12'd510: toneL = `lc;    12'd511: toneL = `lc;
                
                default : toneL = `sil;
            endcase
        end
        else if(en && !music)begin
            case(ibeatNum)
                // Havana
                
                // --- Measure 1 ---
                
                12'd0: toneL = `lg;      12'd1: toneL = `lg; // HG (half-beat)
                12'd2: toneL = `lg;      12'd3: toneL = `lg;
                12'd4: toneL = `lg;      12'd5: toneL = `lg;
                12'd6: toneL = `lg;      12'd7: toneL = `lg;
                12'd8: toneL = `lg;      12'd9: toneL = `lg; // HE (half-beat)
                12'd10: toneL = `lg;     12'd11: toneL = `lg;
                12'd12: toneL = `lg;     12'd13: toneL = `lg;
                12'd14: toneL = `lg;     12'd15: toneL = `lg; // (Short break for repetitive notes: high E)

                12'd16: toneL = `d;     12'd17: toneL = `d; // HE (one-beat)
                12'd18: toneL = `d;     12'd19: toneL = `d;
                12'd20: toneL = `d;     12'd21: toneL = `d;
                12'd22: toneL = `d;     12'd23: toneL = `d;
                12'd24: toneL = `lg;     12'd25: toneL = `lg;
                12'd26: toneL = `lg;     12'd27: toneL = `lg;
                12'd28: toneL = `lg;     12'd29: toneL = `lg;
                12'd30: toneL = `lg;     12'd31: toneL = `lg;

                12'd32: toneL = `lef;     12'd33: toneL = `lef; // HF (half-beat)
                12'd34: toneL = `lef;     12'd35: toneL = `lef;
                12'd36: toneL = `lef;     12'd37: toneL = `lef;
                12'd38: toneL = `lef;     12'd39: toneL = `sil;
                12'd40: toneL = `lef;     12'd41: toneL = `lef; // HD (half-beat)
                12'd42: toneL = `lef;     12'd43: toneL = `lef;
                12'd44: toneL = `lef;     12'd45: toneL = `lef;
                12'd46: toneL = `lef;     12'd47: toneL = `lef; // (Short break for repetitive notes: high D)

                12'd48: toneL = `lg;     12'd49: toneL = `lg; // HD (one-beat)
                12'd50: toneL = `lg;     12'd51: toneL = `lg;
                12'd52: toneL = `lg;     12'd53: toneL = `lg;
                12'd54: toneL = `lg;     12'd55: toneL = `lg;
                12'd56: toneL = `ld;     12'd57: toneL = `ld;
                12'd58: toneL = `ld;     12'd59: toneL = `ld;
                12'd60: toneL = `ld;     12'd61: toneL = `ld;
                12'd62: toneL = `ld;     12'd63: toneL = `ld;

                // --- Measure 2 ---
                
                12'd64: toneL = `ld;     12'd65: toneL = `ld; // HC (half-beat)
                12'd66: toneL = `ld;     12'd67: toneL = `ld;
                12'd68: toneL = `ld;     12'd69: toneL = `ld;
                12'd70: toneL = `ld;     12'd71: toneL = `ld;
                12'd72: toneL = `la;     12'd73: toneL = `la; // HD (half-beat)
                12'd74: toneL = `la;     12'd75: toneL = `la;
                12'd76: toneL = `la;     12'd77: toneL = `la;
                12'd78: toneL = `la;     12'd79: toneL = `la;

                12'd80: toneL = `c;     12'd81: toneL = `c; // HE (half-beat)
                12'd82: toneL = `c;     12'd83: toneL = `c;
                12'd84: toneL = `c;     12'd85: toneL = `c;
                12'd86: toneL = `c;     12'd87: toneL = `c;
                12'd88: toneL = `c;     12'd89: toneL = `c; // HF (half-beat)
                12'd90: toneL = `c;     12'd91: toneL = `c;
                12'd92: toneL = `c;     12'd93: toneL = `c;
                12'd94: toneL = `c;     12'd95: toneL = `c;

                12'd96: toneL = `sil;     12'd97: toneL = `sil; // HG (half-beat)
                12'd98: toneL = `sil;     12'd99: toneL = `sil;
                12'd100: toneL = `sil;     12'd101: toneL = `sil;
                12'd102: toneL = `sil;     12'd103: toneL = `sil; // (Short break for repetitive notes: high D)
                12'd104: toneL = `lfs;     12'd105: toneL = `lfs; // HG (half-beat)
                12'd106: toneL = `lfs;     12'd107: toneL = `lfs;
                12'd108: toneL = `lfs;     12'd109: toneL = `lfs;
                12'd110: toneL = `lfs;     12'd111: toneL = `lfs; // (Short break for repetitive notes: high D)

                12'd112: toneL = `ef;     12'd113: toneL = `ef; // HG (one-beat)
                12'd114: toneL = `ef;     12'd115: toneL = `ef;
                12'd116: toneL = `ef;     12'd117: toneL = `ef;
                12'd118: toneL = `ef;     12'd119: toneL = `ef;
                12'd120: toneL = `d;     12'd121: toneL = `d;
                12'd122: toneL = `d;     12'd123: toneL = `d;
                12'd124: toneL = `d;     12'd125: toneL = `d;
                12'd126: toneL = `d;     12'd127: toneL = `d;
                
                // --- Measure 3 ---
                
                12'd128: toneL = `lg;     12'd129: toneL = `lg; // HG (half-beat)
                12'd130: toneL = `lg;     12'd131: toneL = `lg;
                12'd132: toneL = `lg;     12'd133: toneL = `lg;
                12'd134: toneL = `lg;     12'd135: toneL = `lg;
                12'd136: toneL = `lg;     12'd137: toneL = `lg; // HE (half-beat)
                12'd138: toneL = `lg;     12'd139: toneL = `lg;
                12'd140: toneL = `lg;     12'd141: toneL = `lg;
                12'd142: toneL = `lg;     12'd143: toneL = `lg; // (Short break for repetitive notes: high E)

                12'd144: toneL = `d;     12'd145: toneL = `d; // HE (one-beat)
                12'd146: toneL = `d;     12'd147: toneL = `d;
                12'd148: toneL = `d;     12'd149: toneL = `d;
                12'd150: toneL = `d;     12'd151: toneL = `d;
                12'd152: toneL = `lg;     12'd153: toneL = `lg;
                12'd154: toneL = `lg;     12'd155: toneL = `lg;
                12'd156: toneL = `lg;     12'd157: toneL = `lg;
                12'd158: toneL = `lg;     12'd159: toneL = `lg;

                12'd160: toneL = `lef;     12'd161: toneL = `lef; // HF (half-beat)
                12'd162: toneL = `lef;     12'd163: toneL = `lef;
                12'd164: toneL = `lef;     12'd165: toneL = `lef;
                12'd166: toneL = `lef;     12'd167: toneL = `sil;
                12'd168: toneL = `lef;     12'd169: toneL = `lef; // HD (half-beat)
                12'd170: toneL = `lef;     12'd171: toneL = `lef;
                12'd172: toneL = `lef;     12'd173: toneL = `lef;
                12'd174: toneL = `lef;     12'd175: toneL = `lef; // (Short break for repetitive notes: high D)

                12'd176: toneL = `lg;     12'd177: toneL = `lg; // HD (one-beat)
                12'd178: toneL = `lg;     12'd179: toneL = `lg;
                12'd180: toneL = `lg;     12'd181: toneL = `lg;
                12'd182: toneL = `lg;     12'd183: toneL = `lg;
                12'd184: toneL = `sil;     12'd185: toneL = `ld;
                12'd186: toneL = `ld;     12'd187: toneL = `ld;
                12'd188: toneL = `ld;     12'd189: toneL = `ld;
                12'd190: toneL = `ld;     12'd191: toneL = `ld;

                // --- Measure 4 ---
                
                12'd192: toneL = `ld;     12'd193: toneL = `ld; // HC (half-beat)
                12'd194: toneL = `ld;     12'd195: toneL = `ld;
                12'd196: toneL = `ld;     12'd197: toneL = `ld;
                12'd198: toneL = `ld;     12'd199: toneL = `ld;
                12'd200: toneL = `la;      12'd201: toneL = `la; // a (half-beat)
                12'd202: toneL = `la;      12'd203: toneL = `la;
                12'd204: toneL = `la;      12'd205: toneL = `la;
                12'd206: toneL = `la;      12'd207: toneL = `la;

                12'd208: toneL = `c;     12'd209: toneL = `c; // HE (half-beat)
                12'd210: toneL = `c;     12'd211: toneL = `c;
                12'd212: toneL = `c;     12'd213: toneL = `c;
                12'd214: toneL = `c;     12'd215: toneL = `c;
                12'd216: toneL = `c;     12'd217: toneL = `c; // HF (half-beat)
                12'd218: toneL = `c;     12'd219: toneL = `c;
                12'd220: toneL = `c;     12'd221: toneL = `c;
                12'd222: toneL = `c;     12'd223: toneL = `c;

                12'd224: toneL = `sil;     12'd225: toneL = `sil; // HG (half-beat)
                12'd226: toneL = `sil;     12'd227: toneL = `sil;
                12'd228: toneL = `sil;     12'd229: toneL = `sil;
                12'd230: toneL = `sil;     12'd231: toneL = `sil; // (Short break for repetitive notes: high D)
                12'd232: toneL = `lfs;     12'd233: toneL = `lfs; // HG (half-beat)
                12'd234: toneL = `lfs;     12'd235: toneL = `lfs;
                12'd236: toneL = `lfs;     12'd237: toneL = `lfs;
                12'd238: toneL = `lfs;     12'd239: toneL = `lfs; // (Short break for repetitive notes: high D)

                12'd240: toneL = `ef;     12'd241: toneL = `ef; // HG (one-beat)
                12'd242: toneL = `ef;     12'd243: toneL = `ef;
                12'd244: toneL = `ef;     12'd245: toneL = `ef;
                12'd246: toneL = `ef;     12'd247: toneL = `ef;
                12'd248: toneL = `d;     12'd249: toneL = `d;
                12'd250: toneL = `d;     12'd251: toneL = `d;
                12'd252: toneL = `d;     12'd253: toneL = `d;
                12'd254: toneL = `d;     12'd255: toneL = `d;

                // --- Measure 5 ---
                
                12'd256: toneL = `lg;     12'd257: toneL = `lg; // HG (half-beat)
                12'd258: toneL = `lg;     12'd259: toneL = `lg;
                12'd260: toneL = `lg;     12'd261: toneL = `lg;
                12'd262: toneL = `lg;     12'd263: toneL = `lg;
                12'd264: toneL = `lg;     12'd265: toneL = `lg; // HE (half-beat)
                12'd266: toneL = `lg;     12'd267: toneL = `lg;
                12'd268: toneL = `lg;     12'd269: toneL = `lg;
                12'd270: toneL = `lg;     12'd271: toneL = `lg; // (Short break for repetitive notes: high E)

                12'd272: toneL = `d;     12'd273: toneL = `d; // HE (one-beat)
                12'd274: toneL = `d;     12'd275: toneL = `d;
                12'd276: toneL = `d;     12'd277: toneL = `d;
                12'd278: toneL = `d;     12'd279: toneL = `d;
                12'd280: toneL = `lg;     12'd281: toneL = `lg;
                12'd282: toneL = `lg;     12'd283: toneL = `lg;
                12'd284: toneL = `lg;     12'd285: toneL = `lg;
                12'd286: toneL = `lg;     12'd287: toneL = `lg;

                12'd288: toneL = `lef;     12'd289: toneL = `lef; // HF (half-beat)
                12'd290: toneL = `lef;     12'd291: toneL = `lef;
                12'd292: toneL = `lef;     12'd293: toneL = `lef;
                12'd294: toneL = `lef;     12'd295: toneL = `sil;
                12'd296: toneL = `lef;     12'd297: toneL = `lef; // HD (half-beat)
                12'd298: toneL = `lef;     12'd299: toneL = `lef;
                12'd300: toneL = `lef;     12'd301: toneL = `lef;
                12'd302: toneL = `lef;     12'd303: toneL = `lef; // (Short break for repetitive notes: high D)

                12'd304: toneL = `lg;     12'd305: toneL = `lg; // HD (one-beat)
                12'd306: toneL = `lg;     12'd307: toneL = `lg;
                12'd308: toneL = `lg;     12'd309: toneL = `lg;
                12'd310: toneL = `lg;     12'd311: toneL = `lg;
                12'd312: toneL = `ld;     12'd313: toneL = `ld;
                12'd314: toneL = `ld;     12'd315: toneL = `ld;
                12'd316: toneL = `ld;     12'd317: toneL = `ld;
                12'd318: toneL = `ld;     12'd319: toneL = `ld;

                // --- Measure 6 ---
                
                12'd320: toneL = `ld;     12'd321: toneL = `ld; // HC (half-beat)
                12'd322: toneL = `ld;     12'd323: toneL = `ld;
                12'd324: toneL = `ld;     12'd325: toneL = `ld;
                12'd326: toneL = `ld;     12'd327: toneL = `ld;
                12'd328: toneL = `la;      12'd329: toneL = `la; // la (half-beat)
                12'd330: toneL = `la;      12'd331: toneL = `la;
                12'd332: toneL = `la;      12'd333: toneL = `la;
                12'd334: toneL = `la;      12'd335: toneL = `la;
                
                12'd336: toneL = `c;     12'd337: toneL = `c; // HE (half-beat)
                12'd338: toneL = `c;     12'd339: toneL = `c;
                12'd340: toneL = `c;     12'd341: toneL = `c;
                12'd342: toneL = `c;     12'd343: toneL = `c;
                12'd344: toneL = `c;     12'd345: toneL = `c; // HF (half-beat)
                12'd346: toneL = `c;     12'd347: toneL = `c;
                12'd348: toneL = `c;     12'd349: toneL = `c;
                12'd350: toneL = `c;     12'd351: toneL = `c;

                12'd352: toneL = `sil;     12'd353: toneL = `sil; // HG (half-beat)
                12'd354: toneL = `sil;     12'd355: toneL = `sil;
                12'd356: toneL = `sil;     12'd357: toneL = `sil;
                12'd358: toneL = `sil;     12'd359: toneL = `sil; // (Short break for repetitive notes: high D)
                12'd360: toneL = `lfs;     12'd361: toneL = `lfs; // HG (half-beat)
                12'd362: toneL = `lfs;     12'd363: toneL = `lfs;
                12'd364: toneL = `lfs;     12'd365: toneL = `lfs;
                12'd366: toneL = `lfs;     12'd367: toneL = `lfs; // (Short break for repetitive notes: high D)

                12'd368: toneL = `ef;     12'd369: toneL = `ef; // HG (one-beat)
                12'd370: toneL = `ef;     12'd371: toneL = `ef;
                12'd372: toneL = `ef;     12'd373: toneL = `ef;
                12'd374: toneL = `ef;     12'd375: toneL = `ef;
                12'd376: toneL = `d;     12'd377: toneL = `d;
                12'd378: toneL = `d;     12'd379: toneL = `d;
                12'd380: toneL = `d;     12'd381: toneL = `d;
                12'd382: toneL = `d;     12'd383: toneL = `d;

                // --- Measure 7 ---
                
                12'd384: toneL = `lg;      12'd385: toneL = `lg; // HG (half-beat)
                12'd386: toneL = `lg;      12'd387: toneL = `lg;
                12'd388: toneL = `lg;      12'd389: toneL = `lg;
                12'd390: toneL = `lg;      12'd391: toneL = `lg;
                12'd392: toneL = `lg;      12'd393: toneL = `lg; // HE (half-beat)
                12'd394: toneL = `lg;     12'd395: toneL = `lg;
                12'd396: toneL = `lg;     12'd397: toneL = `lg;
                12'd398: toneL = `lg;     12'd399: toneL = `lg; // (Short break for repetitive notes: high E)

                12'd400: toneL = `d;     12'd401: toneL = `d; // HE (one-beat)
                12'd402: toneL = `d;     12'd403: toneL = `d;
                12'd404: toneL = `d;     12'd405: toneL = `d;
                12'd406: toneL = `d;     12'd407: toneL = `d;
                12'd408: toneL = `lg;     12'd409: toneL = `lg;
                12'd410: toneL = `lg;     12'd411: toneL = `lg;
                12'd412: toneL = `lg;     12'd413: toneL = `lg;
                12'd414: toneL = `lg;     12'd415: toneL = `lg;

                12'd416: toneL = `lef;     12'd417: toneL = `lef; // HF (half-beat)
                12'd418: toneL = `lef;     12'd419: toneL = `lef;
                12'd420: toneL = `lef;     12'd421: toneL = `lef;
                12'd422: toneL = `lef;     12'd423: toneL = `sil;
                12'd424: toneL = `lef;     12'd425: toneL = `lef; // lef (half-beat)
                12'd426: toneL = `lef;     12'd427: toneL = `lef;
                12'd428: toneL = `lef;     12'd429: toneL = `lef;
                12'd430: toneL = `lef;     12'd431: toneL = `lef; // (Short break for repetitive notes: high D)

                12'd432: toneL = `lg;     12'd433: toneL = `lg; // HD (one-beat)
                12'd434: toneL = `lg;     12'd435: toneL = `lg;
                12'd436: toneL = `lg;     12'd437: toneL = `lg;
                12'd438: toneL = `lg;     12'd439: toneL = `lg;
                12'd440: toneL = `ld;     12'd441: toneL = `ld;
                12'd442: toneL = `ld;     12'd443: toneL = `ld;
                12'd444: toneL = `ld;     12'd445: toneL = `ld;
                12'd446: toneL = `ld;     12'd447: toneL = `ld;
                
                // --- Measure 8 ---
                
                12'd448: toneL = `sil;     12'd449: toneL = `sil; // HC (half-beat)
                12'd450: toneL = `sil;     12'd451: toneL = `sil;
                12'd452: toneL = `sil;     12'd453: toneL = `sil;
                12'd454: toneL = `sil;     12'd455: toneL = `sil;
                12'd456: toneL = `sil;      12'd457: toneL = `sil; // HD (half-beat)
                12'd458: toneL = `sil;      12'd459: toneL = `sil;
                12'd460: toneL = `sil;      12'd461: toneL = `sil;
                12'd462: toneL = `sil;      12'd463: toneL = `sil;

                12'd464: toneL = `sil;    12'd465: toneL = `sil; // HE (half-beat)
                12'd466: toneL = `sil;    12'd467: toneL = `sil;
                12'd468: toneL = `sil;    12'd469: toneL = `sil;
                12'd470: toneL = `sil;    12'd471: toneL = `sil;
                12'd472: toneL = `sil;     12'd473: toneL = `sil; // HF (half-beat)
                12'd474: toneL = `sil;     12'd475: toneL = `sil;
                12'd476: toneL = `sil;     12'd477: toneL = `sil;
                12'd478: toneL = `sil;     12'd479: toneL = `sil;

                12'd480: toneL = `sil;      12'd481: toneL = `sil; // HG (half-beat)
                12'd482: toneL = `sil;      12'd483: toneL = `sil;
                12'd484: toneL = `sil;      12'd485: toneL = `sil;
                12'd486: toneL = `sil;      12'd487: toneL = `sil; // (Short break for repetitive notes: high D)
                12'd488: toneL = `sil;     12'd489: toneL = `sil; // HG (half-beat)
                12'd490: toneL = `sil;     12'd491: toneL = `sil;
                12'd492: toneL = `sil;     12'd493: toneL = `sil;
                12'd494: toneL = `sil;     12'd495: toneL = `sil; // (Short break for repetitive notes: high D)

                12'd496: toneL = `sil;     12'd497: toneL = `sil; // HG (one-beat)
                12'd498: toneL = `sil;     12'd499: toneL = `sil;
                12'd500: toneL = `sil;     12'd501: toneL = `sil;
                12'd502: toneL = `sil;     12'd503: toneL = `sil;
                12'd504: toneL = `sil;    12'd505: toneL = `sil;
                12'd506: toneL = `sil;    12'd507: toneL = `sil;
                12'd508: toneL = `sil;    12'd509: toneL = `sil;
                12'd510: toneL = `sil;    12'd511: toneL = `sil;
                
                default : toneL = `sil;
            endcase
        end
        else begin
            toneL = `sil;
        end
    end
endmodule