VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "acr2"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL XLXN_3
        SIGNAL XLXN_4
        SIGNAL stress
        SIGNAL XLXN_6
        SIGNAL XLXN_8
        SIGNAL XLXN_9
        SIGNAL XLXN_10
        SIGNAL XLXN_11
        SIGNAL XLXN_12
        SIGNAL XLXN_13
        SIGNAL XLXN_14
        SIGNAL XLXN_16
        SIGNAL XLXN_17
        SIGNAL clk
        SIGNAL XLXN_19
        SIGNAL reset
        SIGNAL XLXN_21
        SIGNAL XLXN_22
        SIGNAL XLXN_23
        SIGNAL XLXN_24
        SIGNAL XLXN_25
        SIGNAL Fplus1
        SIGNAL Amin1
        SIGNAL Fmin1
        SIGNAL XLXN_29
        SIGNAL XLXN_30
        SIGNAL endofline
        PORT Input stress
        PORT Input clk
        PORT Input reset
        PORT Output Fplus1
        PORT Output Amin1
        PORT Output Fmin1
        PORT Input endofline
        BEGIN BLOCKDEF and2
            TIMESTAMP 2000 1 1 10 10 10
            LINE N 0 -64 64 -64 
            LINE N 0 -128 64 -128 
            LINE N 256 -96 192 -96 
            ARC N 96 -144 192 -48 144 -48 144 -144 
            LINE N 144 -48 64 -48 
            LINE N 64 -144 144 -144 
            LINE N 64 -48 64 -144 
        END BLOCKDEF
        BEGIN BLOCKDEF inv
            TIMESTAMP 2000 1 1 10 10 10
            LINE N 0 -32 64 -32 
            LINE N 224 -32 160 -32 
            LINE N 64 -64 128 -32 
            LINE N 128 -32 64 0 
            LINE N 64 0 64 -64 
            CIRCLE N 128 -48 160 -16 
        END BLOCKDEF
        BEGIN BLOCKDEF fdr
            TIMESTAMP 2000 1 1 10 10 10
            LINE N 0 -128 64 -128 
            LINE N 0 -256 64 -256 
            LINE N 384 -256 320 -256 
            LINE N 0 -32 64 -32 
            RECTANGLE N 64 -320 320 -64 
            LINE N 192 -64 192 -32 
            LINE N 192 -32 64 -32 
            LINE N 64 -112 80 -128 
            LINE N 80 -128 64 -144 
        END BLOCKDEF
        BEGIN BLOCK XLXI_1 and2
            PIN I0 clk
            PIN I1 stress
            PIN O XLXN_19
        END BLOCK
        BEGIN BLOCK XLXI_3 inv
            PIN I stress
            PIN O XLXN_14
        END BLOCK
        BEGIN BLOCK XLXI_4 and2
            PIN I0 XLXN_11
            PIN I1 XLXN_14
            PIN O XLXN_30
        END BLOCK
        BEGIN BLOCK XLXI_5 and2
            PIN I0 XLXN_25
            PIN I1 XLXN_30
            PIN O Fplus1
        END BLOCK
        BEGIN BLOCK XLXI_6 and2
            PIN I0 XLXN_25
            PIN I1 XLXN_29
            PIN O Amin1
        END BLOCK
        BEGIN BLOCK XLXI_7 and2
            PIN I0 XLXN_25
            PIN I1 XLXN_19
            PIN O Fmin1
        END BLOCK
        BEGIN BLOCK XLXI_9 fdr
            PIN C clk
            PIN D XLXN_30
            PIN R XLXN_21
            PIN Q XLXN_10
        END BLOCK
        BEGIN BLOCK XLXI_11 inv
            PIN I XLXN_10
            PIN O XLXN_11
        END BLOCK
        BEGIN BLOCK XLXI_12 and2
            PIN I0 XLXN_14
            PIN I1 XLXN_10
            PIN O XLXN_29
        END BLOCK
        BEGIN BLOCK XLXI_13 and2
            PIN I0 endofline
            PIN I1 reset
            PIN O XLXN_21
        END BLOCK
        BEGIN BLOCK XLXI_14 inv
            PIN I XLXN_21
            PIN O XLXN_25
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        INSTANCE XLXI_3 656 352 R0
        INSTANCE XLXI_5 2224 384 R0
        INSTANCE XLXI_6 2320 784 R0
        INSTANCE XLXI_7 2256 1328 R0
        BEGIN BRANCH stress
            WIRE 96 464 256 464
            WIRE 256 464 464 464
            WIRE 464 464 544 464
            WIRE 544 464 544 592
            WIRE 544 592 848 592
            WIRE 544 320 656 320
            WIRE 544 320 544 464
            BEGIN DISPLAY 256 464 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        INSTANCE XLXI_9 496 1280 R0
        INSTANCE XLXI_4 1152 272 R0
        INSTANCE XLXI_11 944 1056 R0
        BEGIN BRANCH XLXN_10
            WIRE 880 1024 928 1024
            WIRE 928 1024 944 1024
            WIRE 928 928 928 1024
            WIRE 928 928 1056 928
            WIRE 1056 432 1056 928
            WIRE 1056 432 1264 432
        END BRANCH
        BEGIN BRANCH XLXN_11
            WIRE 1088 208 1152 208
            WIRE 1088 208 1088 304
            WIRE 1088 304 1232 304
            WIRE 1232 304 1232 1024
            WIRE 1168 1024 1232 1024
        END BRANCH
        INSTANCE XLXI_12 1264 560 R0
        INSTANCE XLXI_1 848 720 R0
        BEGIN BRANCH XLXN_14
            WIRE 880 320 944 320
            WIRE 944 320 992 320
            WIRE 944 320 944 496
            WIRE 944 496 1264 496
            WIRE 992 144 1152 144
            WIRE 992 144 992 320
        END BRANCH
        BEGIN BRANCH clk
            WIRE 80 1152 160 1152
            WIRE 160 1152 288 1152
            WIRE 288 1152 496 1152
            WIRE 288 656 848 656
            WIRE 288 656 288 1152
            BEGIN DISPLAY 160 1152 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_19
            WIRE 1104 624 1680 624
            WIRE 1680 624 1680 1200
            WIRE 1680 1200 2256 1200
        END BRANCH
        BEGIN BRANCH reset
            WIRE 64 1520 160 1520
            WIRE 160 1520 336 1520
            WIRE 336 1520 384 1520
            BEGIN DISPLAY 160 1520 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        INSTANCE XLXI_13 384 1648 R0
        BEGIN BRANCH XLXN_21
            WIRE 496 1248 496 1328
            WIRE 496 1328 704 1328
            WIRE 704 1328 704 1552
            WIRE 704 1552 1088 1552
            WIRE 1088 1552 1120 1552
            WIRE 640 1552 704 1552
        END BRANCH
        INSTANCE XLXI_14 1120 1584 R0
        BEGIN BRANCH XLXN_25
            WIRE 1344 1552 2096 1552
            WIRE 2096 320 2224 320
            WIRE 2096 320 2096 720
            WIRE 2096 720 2320 720
            WIRE 2096 720 2096 1264
            WIRE 2096 1264 2256 1264
            WIRE 2096 1264 2096 1552
        END BRANCH
        BEGIN BRANCH Fplus1
            WIRE 2480 288 2624 288
            WIRE 2624 288 2848 288
            BEGIN DISPLAY 2624 288 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH Amin1
            WIRE 2576 688 2704 688
            WIRE 2704 688 2896 688
            BEGIN DISPLAY 2704 688 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH Fmin1
            WIRE 2512 1232 2624 1232
            WIRE 2624 1232 2864 1232
            BEGIN DISPLAY 2624 1232 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_29
            WIRE 1520 464 1920 464
            WIRE 1920 464 1920 656
            WIRE 1920 656 2320 656
        END BRANCH
        BEGIN BRANCH XLXN_30
            WIRE 144 368 144 1024
            WIRE 144 1024 496 1024
            WIRE 144 368 1504 368
            WIRE 1408 176 1504 176
            WIRE 1504 176 1808 176
            WIRE 1808 176 1808 256
            WIRE 1808 256 2224 256
            WIRE 1504 176 1504 368
        END BRANCH
        IOMARKER 80 1152 clk R180 28
        IOMARKER 64 1520 reset R180 28
        IOMARKER 2848 288 Fplus1 R0 28
        IOMARKER 2896 688 Amin1 R0 28
        IOMARKER 2864 1232 Fmin1 R0 28
        IOMARKER 96 464 stress R180 28
        BEGIN BRANCH endofline
            WIRE 112 1584 112 1824
            WIRE 112 1584 224 1584
            WIRE 224 1584 240 1584
            WIRE 240 1584 384 1584
            BEGIN DISPLAY 224 1584 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 112 1824 endofline R90 28
    END SHEET
END SCHEMATIC
