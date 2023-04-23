function [D_5] = Code_Hybrid_method_Elsevier_Vect_5(n1, n2, n3, n4, n5, N)

format long
load('BestSol_GA_Vect_5.mat')

% % ------------------------
% % Chargement des donn√©es
% % ------------------------
% 
% N = 254;        % Nombre d'Èchantillon
% Feuille = 1;    % Feuille excel
% 
% n1 = xlsread('Data.xlsm',Feuille,'A2:A255'); % ('Concentration de H2')
% n2 = xlsread('Data.xlsm',Feuille,'B2:B255'); % ('Concentration de CH4')
% n3 = xlsread('Data.xlsm',Feuille,'C2:C255'); % ('Concentration de C2H6')
% n4 = xlsread('Data.xlsm',Feuille,'D2:D255'); % ('Concentration de C2H4')
% n5 = xlsread('Data.xlsm',Feuille,'E2:E255'); % ('Concentration de C2H2')

% -------------------------
% Concentrations limites
% -------------------------

n1lim = 100;    %input('H2 = ');
n2lim = 120;    %input('CH4 = ');
n3lim = 65;     %input('C2H6 = ');
n4lim = 50;     %input('C2H4 = ');
n5lim = 1;      %input('C2H2 = ');

% -----------------
% Initialisations
% -----------------

T = zeros(N,1);
R1 = zeros(N,1); R2 = zeros(N,1); R3 = zeros(N,1); R4 = zeros(N,1); R5 = zeros(N,1); R6 = zeros(N,1); R7 = zeros(N,1); R8 = zeros(N,1); R9 = zeros(N,1); R10 = zeros(N,1); R11 = zeros(N,1);
R12 = zeros(N,1); R13 = zeros(N,1); R14 = zeros(N,1); R15 = zeros(N,1); Diag_Prop = zeros(N,1); X = zeros(N,5); dist = zeros(N,5); IND = zeros(N,1);
K1 = zeros(N,1); K2 = zeros(N,1); K3 = zeros(N,1); K4 = zeros(N,1); K5 = zeros(N,1); Cmax = zeros(N,1);

% -----------------
% Proposed method
% -----------------

for i = 1:N
    
    % -------------------
    % Compute the ratios
    % -------------------
    
    T(i,1) = n1(i,1)+n2(i,1)+n3(i,1)+n4(i,1)+n5(i,1);
    R1(i,1) = (n2(i,1)+n3(i,1))/T(i,1);
    R2(i,1) = (n2(i,1)+n4(i,1))/T(i,1);
    R3(i,1) = n3(i,1)/(n2(i,1)+n4(i,1));
    R4(i,1) = (n1(i,1)+n2(i,1))/T(i,1);
    R5(i,1) = (n4(i,1)+n5(i,1))/T(i,1);
    R6(i,1) = (n5(i,1)/n4(i,1));
    R7(i,1) = (n3(i,1)+n4(i,1))/(n1(i,1)+n5(i,1)+n2(i,1));
    R8(i,1) = (n2(i,1)+n5(i,1))/n4(i,1);
    R9(i,1) = (n2(i,1))/(n2(i,1)+n4(i,1)+n5(i,1));
    R10(i,1) = (n4(i,1))/(n2(i,1)+n4(i,1)+n5(i,1));
    R11(i,1) = (n5(i,1))/(n2(i,1)+n4(i,1)+n5(i,1));
    R12(i,1) = (n2(i,1)/n1(i,1));
    R13(i,1) = (n4(i,1)/n3(i,1));
    R14(i,1) = (n3(i,1)+n4(i,1))/(n1(i,1)+n5(i,1));
    R15(i,1) = (n3(i,1)+n5(i,1))/n4(i,1);
    
    % ------------------------------------
    % determination of the sample' cluster
    % ------------------------------------
    
    Cmax(i,1) = max([n1(i,1),n2(i,1),n3(i,1),n4(i,1),n5(i,1)]);
    
    K1(i,1) = n1(i,1)/Cmax(i,1);
    K2(i,1) = n2(i,1)/Cmax(i,1);
    K3(i,1) = n3(i,1)/Cmax(i,1);
    K4(i,1) = n4(i,1)/Cmax(i,1);
    K5(i,1) = n5(i,1)/Cmax(i,1);
    
    X(i,1) = K1(i,1)/( K1(i,1)+ K2(i,1)+ K3(i,1)+ K4(i,1)+ K5(i,1));
    X(i,2) = K2(i,1)/( K1(i,1)+ K2(i,1)+ K3(i,1)+ K4(i,1)+ K5(i,1));
    X(i,3) = K3(i,1)/( K1(i,1)+ K2(i,1)+ K3(i,1)+ K4(i,1)+ K5(i,1));
    X(i,4) = K4(i,1)/( K1(i,1)+ K2(i,1)+ K3(i,1)+ K4(i,1)+ K5(i,1));
    X(i,5) = K5(i,1)/( K1(i,1)+ K2(i,1)+ K3(i,1)+ K4(i,1)+ K5(i,1));
    Xx = [X(i,1) X(i,2) X(i,3) X(i,4) X(i,5)];
    dist = pdist2(Xx, BestSol.Position);
    [dmin, ind] = min(dist, [], 2);
    IND(i,1) = ind;
    
    if (n1(i,1) <= n1lim) && (n2(i,1) <= n2lim) && (n3(i,1) <= n3lim) && (n4(i,1) <= n4lim) && (n5(i,1) <= n5lim)
        n = 'Normal';
    end
    
    if ind == 1
        n = 'Cluster_1';
    end
    if ind == 2
        n = 'Cluster_2';
    end
    if ind == 3
        n = 'Cluster_3';
    end
    if ind == 4
        n = 'Cluster_4';
    end
    if ind == 5
        n = 'Cluster_5';
    end
    if ind == 6
        n = 'Cluster_6';
    end
    if ind == 7
        n = 'Cluster_7';
    end
    if ind == 8
        n = 'Cluster_8';
    end
    if ind == 9
        n = 'Cluster_9';
    end
    if ind == 10
        n = 'Cluster_10';
    end
    if ind == 11
        n = 'Cluster_11';
    end
    if ind == 12
        n = 'Cluster_12';
    end
    if ind == 13
        n = 'Cluster_13';
    end
    if ind == 14
        n = 'Cluster_14';
    end
    if ind == 15
        n = 'Cluster_15';
    end
    if ind == 16
        n = 'Cluster_16';
    end
    if ind == 17
        n = 'Cluster_17';
    end
    if ind == 18
        n = 'Cluster_18';
    end
    if ind == 19
        n = 'Cluster_19';
    end
    if ind == 20
        n = 'Cluster_20';
    end
    if ind == 21
        n = 'Cluster_21';
    end
    if ind == 22
        n = 'Cluster_22';
    end
    if ind == 23
        n = 'Cluster_23';
    end
    if ind == 24
        n = 'Cluster_24';
    end
    if ind == 25
        n = 'Cluster_25';
    end
    if ind == 26
        n = 'Cluster_26';
    end
    if ind == 27
        n = 'Cluster_27';
    end
    if ind == 28
        n = 'Cluster_28';
    end
    if ind == 29
        n = 'Cluster_29';
    end
    if ind == 30
        n = 'Cluster_30';
    end
    if ind == 31
        n = 'Cluster_31';
    end
    if ind == 32
        n = 'Cluster_32';
    end
    if ind == 33
        n = 'Cluster_33';
    end
    if ind == 34
        n = 'Cluster_34';
    end
    if ind == 35
        n = 'Cluster_35';
    end
    if ind == 36
        n = 'Cluster_36';
    end
    if ind == 37
        n = 'Cluster_37';
    end
    if ind == 38
        n = 'Cluster_38';
    end
    if ind == 39
        n = 'Cluster_39';
    end
    if ind == 40
        n = 'Cluster_40';
    end
    if ind == 41
        n = 'Cluster_41';
    end
    if ind == 42
        n = 'Cluster_42';
    end
    if ind == 43
        n = 'Cluster_43';
    end
    if ind == 44
        n = 'Cluster_44';
    end
    if ind == 45
        n = 'Cluster_45';
    end
    if ind == 46
        n = 'Cluster_46';
    end
    if ind == 47
        n = 'Cluster_47';
    end
    if ind == 48
        n = 'Cluster_48';
    end
    if ind == 49
        n = 'Cluster_49';
    end
    if ind == 50
        n = 'Cluster_50';
    end
    if ind == 51
        n = 'Cluster_51';
    end
    if ind == 52
        n = 'Cluster_52';
    end
    if ind == 53
        n = 'Cluster_53';
    end
    if ind == 54
        n = 'Cluster_54';
    end
    if ind == 55
        n = 'Cluster_55';
    end
    if ind == 56
        n = 'Cluster_56';
    end
    if ind == 57
        n = 'Cluster_57';
    end
    if ind == 58
        n = 'Cluster_58';
    end
    if ind == 59
        n = 'Cluster_59';
    end
    if ind == 60
        n = 'Cluster_60';
    end
    if ind == 61
        n = 'Cluster_61';
    end
    if ind == 62
        n = 'Cluster_62';
    end
    if ind == 63
        n = 'Cluster_63';
    end
    if ind == 64
        n = 'Cluster_64';
    end
    if ind == 65
        n = 'Cluster_65';
    end
    if ind == 66
        n = 'Cluster_66';
    end
    if ind == 67
        n = 'Cluster_67';
    end
    if ind == 68
        n = 'Cluster_68';
    end
    if ind == 69
        n = 'Cluster_69';
    end
    if ind == 70
        n = 'Cluster_70';
    end
    if ind == 71
        n = 'Cluster_71';
    end
    if ind == 72
        n = 'Cluster_72';
    end
    if ind == 73
        n = 'Cluster_73';
    end
    if ind == 74
        n = 'Cluster_74';
    end
    if ind == 75
        n = 'Cluster_75';
    end
    if ind == 76
        n = 'Cluster_76';
    end
    if ind == 77
        n = 'Cluster_77';
    end
    if ind == 78
        n = 'Cluster_78';
    end
    if ind == 79
        n = 'Cluster_79';
    end
    if ind == 80
        n = 'Cluster_80';
    end
    if ind == 81
        n = 'Cluster_81';
    end
    if ind == 82
        n = 'Cluster_82';
    end
    if ind == 83
        n = 'Cluster_83';
    end
    if ind == 84
        n = 'Cluster_84';
    end
    if ind == 85
        n = 'Cluster_85';
    end
    if ind == 86
        n = 'Cluster_86';
    end
    if ind == 87
        n = 'Cluster_87';
    end
    if ind == 88
        n = 'Cluster_88';
    end
    if ind == 89
        n = 'Cluster_89';
    end
    if ind == 90
        n = 'Cluster_90';
    end
    if ind == 91
        n = 'Cluster_91';
    end
    if ind == 92
        n = 'Cluster_92';
    end
    if ind == 93
        n = 'Cluster_93';
    end
    if ind == 94
        n = 'Cluster_94';
    end
    if ind == 95
        n = 'Cluster_95';
    end
    if ind == 96
        n = 'Cluster_96';
    end
    if ind == 97
        n = 'Cluster_97';
    end
    if ind == 98
        n = 'Cluster_98';
    end
    if ind == 99
        n = 'Cluster_99';
    end
    if ind == 100
        n = 'Cluster_100';
    end
    if ind == 101
        n = 'Cluster_101';
    end
    if ind == 102
        n = 'Cluster_102';
    end
    if ind == 103
        n = 'Cluster_103';
    end
    if ind == 104
        n = 'Cluster_104';
    end
    if ind == 105
        n = 'Cluster_105';
    end
    if ind == 106
        n = 'Cluster_106';
    end
    if ind == 107
        n = 'Cluster_107';
    end
    if ind == 108
        n = 'Cluster_108';
    end
    if ind == 109
        n = 'Cluster_109';
    end
    if ind == 110
        n = 'Cluster_110';
    end
    if ind == 111
        n = 'Cluster_111';
    end
    if ind == 112
        n = 'Cluster_112';
    end
    if ind == 113
        n = 'Cluster_113';
    end
    if ind == 114
        n = 'Cluster_114';
    end
    if ind == 115
        n = 'Cluster_115';
    end
    if ind == 116
        n = 'Cluster_116';
    end
    if ind == 117
        n = 'Cluster_117';
    end
    if ind == 118
        n = 'Cluster_118';
    end
    if ind == 119
        n = 'Cluster_119';
    end
    if ind == 120
        n = 'Cluster_120';
    end
    
    switch n
        
        case 'Normal'
            D = 0;
        case 'Cluster_1'
            D = 2;
        case 'Cluster_2'
            if R12(i,1) >= 10
                D = 2;
            else
                if R13(i,1) >= 50
                    D = 2;
                else
                    D = 3;
                end
            end
        case 'Cluster_3'
            D = 3;
        case 'Cluster_4'
            D = 3;
        case 'Cluster_5'
            if R15(i,1) >= 5.5
                D = 2;
            else
                D = 1;
            end
        case 'Cluster_6'
            D = 2;
        case 'Cluster_7'
            if R15(i,1) >= 2.5
                if R12(i,1) >= 4.5
                    D = 4;
                else
                    D = 5;
                end
            else
                if R12(i,1) >= 4.5
                    if R6(i,1) >= 0.05
                        D = 4;
                    else
                        D = 5;
                    end
                else
                    D = 6;
                end
            end
        case 'Cluster_8'
            if R6(i,1) >= 0.05
                D = 6;
            else
                D = 4;
            end
        case 'Cluster_9'
            if R6(i,1) >= 0.05
                D = 2;
            else
                if R15(i,1) >= 3
                    D = 6;
                else
                    D = 5;
                end
            end
        case 'Cluster_10'
            if R6(i,1) >= 0.05
                D = 2;
            else
                D = 4;
            end
        case 'Cluster_11'
            D = 6;
        case 'Cluster_12'
            if R6(i,1) >= 0.1
                D = 2;
            else
                if R12(i,1) >= 1.25
                    D = 4;
                else
                    D = 1;
                end
            end
        case 'Cluster_13'
            if R3(i,1) < 0.1
                D = 1;
            else
                if R15(i,1) < 10
                    D = 4;
                else
                    D = 2;
                end
            end
        case 'Cluster_14'
            if R13(i,1) >= 7.5
                D = 3;
            else
                D = 4;
            end
        case 'Cluster_15'
            if R8(i,1) < 1.25
                D = 3;
            else
                D = 2;
            end
        case 'Cluster_16'
            D = 1;
        case 'Cluster_17'
            if R11(i,1) < 0.05
                D = 4;
            else
                if R3(i,1) < 2
                    if R6(i,1) < 1
                        D = 6;
                    else
                        D = 3;
                    end
                else
                    if R8(i,1) < 3
                        D = 2;
                    else
                        D = 1;
                    end
                end
            end
        case 'Cluster_18'
            if R15(i,1) >= 10
                D = 5;
            else
                if R3(i,1) >= 1.5
                    D = 5;
                else
                    D = 6;
                end
            end
        case 'Cluster_19'
            if R13(i,1) > 0.1
                D = 4;
            else
                D = 1;
            end
        case 'Cluster_20'
            if R11(i,1) > 0.05
                if R8(i,1) > 100
                    D = 1;
                else
                    D = 2;
                end
            else
                if R3(i,1) > 2
                    D = 1;
                else
                    D = 4;
                end
            end
        case 'Cluster_21'
            if R7(i,1) >= 1.75
                D = 6;
            else
                D = 5;
            end
        case 'Cluster_22'
            D = 3;
       case 'Cluster_23'
            D = 3;
        case 'Cluster_24'
            if R15(i,1) > 12
                if R14(i,1) >= 4.5
                    D = 5;
                else
                    D = 4;
                end
            else
                if R12(i,1) >= 2
                    D = 4;
                else
                    D = 5;
                end
            end
        case 'Cluster_25'
            D = 4;
        case 'Cluster_26'
            if R12(i,1) <= 2.25
                D = 5;
            else
                if R14(i,1) >= 3.5
                    D = 6;
                else
                    D = 4;
                end
            end
        case 'Cluster_27'
            if R6(i,1) >= 0.25
                if R8(i,1) >= 5
                    D = 1;
                else
                    D = 2;
                end
            else
                if R1(i,1) >= 0.2
                    D = 4;
                else
                    D = 1;
                end
            end
        case 'Cluster_28'
            D = 2;
        case 'Cluster_29'
            D = 6;
        case 'Cluster_30'
            D = 3;
        case 'Cluster_31'
            if R7(i,1) >= 2
                D = 3;
            else
                D = 2;
            end
        case 'Cluster_32'
            D = 5;
        case 'Cluster_33'
            if R6(i,1) >= 2
                D = 3;
            else
                if R13(i,1) >= 100
                    D = 3;
                else
                    D = 2;
                end
            end
        case 'Cluster_34'
            if R12(i,1) < 5
                if R3(i,1) >= 0.4
                    D = 3;
                else
                    D = 2;
                end
            else
                D = 3;
            end
        case 'Cluster_35'
            if R14(i,1) <= 0.1
                D = 1;
            else
                D = 4;
            end
        case 'Cluster_36'
            if R12(i,1) >= 0.1
                D = 6;
            else
                D = 2;
            end
        case 'Cluster_37'
            D = 4;
        case 'Cluster_38'
            D = 7;
        case 'Cluster_39'
            D = 5;
        case 'Cluster_40'
            if R4(i,1) >= 0.1
                D = 4;
            else
                D = 6;
            end
        case 'Cluster_41'
            if R12(i,1) >= 3
                if R7(i,1) >= 0.75
                    D = 5;
                else
                    D = 6;
                end
            else
                D = 5;
            end
        case 'Cluster_42'
            D = 6;
        case 'Cluster_43'
            D = 5;
        case 'Cluster_44'
            if R12(i,1) > 10
                D = 4;
            else
                D = 6;
            end
        case 'Cluster_45'
            D = 7;
        case 'Cluster_46'
            if R3(i,1) < 0.1
                D = 3;
            else
                if R2(i,1) >= 0.05
                    D = 2;
                else
                    D = 3;
                end
            end
        case 'Cluster_47'
            if R6(i,1) < 0.15
                if R12(i,1) >= 1
                    D = 2;
                else
                    D = 4;
                end
            else
                D = 3;
            end
        case 'Cluster_48'
            if R6(i,1) < 1
                D = 4;
            else
                D = 3;
            end
        case 'Cluster_49'
            D = 3;
        case 'Cluster_50'
            if R12(i,1) > 1.15
                D = 4;
            else
                D = 6;
            end
        case 'Cluster_51'
            if R7(i,1) < 15
                D = 6;
            else
                D = 5;
            end
        case 'Cluster_52'
            if R8(i,1) < 3
                D = 3;
            else
                D = 2;
            end
        case 'Cluster_53'
            if R15(i,1) < 4
                D = 6;
            else
                D = 4;
            end
        case 'Cluster_54'
            if R14(i,1) < 4
                D = 6;
            else
                D = 4;
            end
        case 'Cluster_55'
            D = 6;
        case 'Cluster_56'
            if R13(i,1) < 1.25
                D = 4;
            else
                D = 5;
            end
        case 'Cluster_57'
            if R7(i,1) < 0.1
                if R2(i,1) < 0.1
                    D = 2;
                else
                    D = 3;
                end
            else
                if R6(i,1) >= 4
                    D = 3;
                else
                    D = 2;
                end
            end
        case 'Cluster_58'
            if R6(i,1) >= 1.20
                if R13(i,1) < 100
                    D = 3;
                else
                    D = 2;
                end
            else
                D = 3;
            end
        case 'Cluster_59'
            if R8(i,1) >= 2
                if R6(i,1) < 0.05
                    D = 5;
                else
                    D = 6;
                end
            else
                if R7(i,1) >= 1.20
                    D = 5;
                else
                    D = 6;
                end
            end
        case 'Cluster_60'
            if R3(i,1) < 0.15
                if R6(i,1) < 0.05
                    D = 4;
                else
                    D = 6;
                end
            else
                if R13(i,1) >= 3
                    D = 5;
                else
                    D = 4;
                end
            end
        case 'Cluster_61'
            if R15(i,1) >= 0.15
                if R13(i,1) < 2
                    D = 4;
                else
                    D = 5;
                end
            else
                D = 4;
            end
        case 'Cluster_62'
            if R7(i,1) >= 3.5
                D = 5;
            else
                D = 6;
            end
        case 'Cluster_63'
            if R12(i,1) >= 5
                D = 6;
            else
                D = 5;
            end
        case 'Cluster_64'
            if R6(i,1) < 0.05
                D = 1;
            else
                D = 2;
            end
        case 'Cluster_65'
            D = 3;
        case 'Cluster_66'
            if R6(i,1) < 0.5
                D = 6;
            else
                D = 3;
            end
        case 'Cluster_67'
            D = 3;
        case 'Cluster_68' 
            D = 1;
        case 'Cluster_69' 
            if R15(i,1) < 8.5
                D = 4;
            else
                D = 5;
            end
        case 'Cluster_70'
            if R6(i,1) >= 0.1
                D = 3;
            else
                if R14(i,1) < 2
                    D = 4;
                else
                    D = 6;
                end
            end
        case 'Cluster_71'
            D = 3;
        case 'Cluster_72'
            if R15(i,1) >= 3
                if R13(i,1) >= 3
                    D = 1;
                else
                    if R13(i,1) >= 0.35
                        D = 3;
                    else
                        D = 2;
                    end
                end
            else
                if R6(i,1) < 1
                    D = 6;
                else
                    if R8(i,1) >= 4.5
                        D = 3;
                    else
                        D = 2;
                    end
                end
            end
        case 'Cluster_73'
            D = 4;
        case 'Cluster_74'
            if R11(i,1) >= 0.1
                D = 3;
            else
                if R10(i,1) >= 0.1
                    D = 4;
                else
                    D = 1;
                end
            end
        case 'Cluster_75'
            if R12(i,1) >= 100
                D = 6;
            else
                D = 5;
            end
        case 'Cluster_76'
            D = 2;
        case 'Cluster_77'
            if R13(i,1) < 5
                D = 2;
            else
                D = 3;
            end
        case 'Cluster_78'
            if R15(i,1) >= 2
                D = 6;
            else
                if R6(i,1) >= 0.1
                    D = 3;
                else
                    D = 4;
                end
            end
        case 'Cluster_79'
            if R7(i,1) < 0.1
                D = 3;
            else
                if R13(i,1) >= 50
                    D = 3;
                else
                    D = 2;
                end
            end
        case 'Cluster_80'
            if R12(i,1) < 0.1
                D = 2;
            else
                D = 3;
            end
        case 'Cluster_81'
            D = 4;
        case 'Cluster_82' 
            if R13(i,1) < 0.1
                D = 1;
            else
                if R3(i,1) < 0.1
                    D = 4;
                else
                    D = 5;
                end
            end 
        case 'Cluster_83'
            if R15(i,1) < 1.25
                D = 4;
            else
                D = 5;
            end
        case 'Cluster_84'
            if R3(i,1) < 0.15
                D = 6;
            else
                if R13(i,1) < 4
                    D = 5;
                else
                    D = 6;
                end
            end
        case 'Cluster_85'
            if R14(i,1) >= 7
                if R12(i,1) < 4.5
                    D = 6;
                else
                    D = 5;
                end
            else
                D = 5;
            end
        case 'Cluster_86'
            D = 6;
        case 'Cluster_87'
            D = 3;
        case 'Cluster_88'
            D = 4;
        case 'Cluster_89' 
            if R6(i,1) >= 0.15
                D = 3;
            else
                if R13(i,1) >= 1.15
                    D = 4;
                else
                    D = 5;
                end
            end
        case 'Cluster_90'
            if R10(i,1) < 0.1
                D = 3;
            else
                D = 2;
            end
        case 'Cluster_91'
            if R6(i,1) >= 0.05
                D = 1;
            else
                if R13(i,1) >= 0.1
                    D = 1;
                else
                    D = 2;
                end
            end
        case 'Cluster_92'
            if R3(i,1) < 0.1
                D = 2;
            else
                if R13(i,1) >= 0.5
                    D = 3;
                else
                    D = 1;
                end
            end
        case 'Cluster_93'
            if R9(i,1) >= 0.25
                D = 3;
            else
                D = 4;
            end
        case 'Cluster_94'
            D = 5;
        case 'Cluster_95'
            if R6(i,1) > 0.1
                D = 2;
            else
                if R15(i,1) >= 4.25
                    D = 4;
                else
                    D = 5;
                end
            end
        case 'Cluster_96'
            D = 6;
        case 'Cluster_97'
            D = 6;
        case 'Cluster_98'
            D = 6;
        case 'Cluster_99'
            if R6(i,1) >= 0.1
                D = 6;
            else
                D = 4;
            end
        case 'Cluster_100'
            if R6(i,1) < 2
                D = 3;
            else
                if R15(i,1) >= 4
                    D = 3;
                else
                    D = 2;
                end
            end
        case 'Cluster_101'
            D = 3;
        case 'Cluster_102'
            if R6(i,1) < 0.1
                D = 4;
            else
                if R13(i,1) >= 0.5
                    D = 3;
                else
                    D = 2;
                end
            end
        case 'Cluster_103' 
            if R10(i,1) < 0.05
                D = 1;
            else
                if R6(i,1) < 0.1
                    D = 4;
                else
                    D = 1;
                end
            end
        case 'Cluster_104'
            if R11(i,1) >= 0.1
                if R3(i,1) < 0.75
                    D = 2;
                else
                    D = 1;
                end
            else
                if R13(i,1) >= 1
                    if R8(i,1) >= 1.75
                        D = 4;
                    else
                        D = 1;
                    end
                else
                    if R15(i,1) >= 3
                        D = 1;
                    else
                        D = 6;
                    end
                end
            end
        case 'Cluster_105'
            if R12(i,1) < 1
                if R13(i,1) < 0.1
                    D = 4;
                else
                    D = 6;
                end
            else
                if R15(i,1) < 15
                    D = 4;
                else
                    D = 5;
                end
            end
        case 'Cluster_106'
            D = 4;
        case 'Cluster_107'
            if R7(i,1) < 2
                if R12(i,1) < 1.5
                    D = 6;
                else
                    D = 5;
                end
            else
                D = 6;
            end
        case 'Cluster_108'
            D = 3;
        case 'Cluster_109'
            D = 2;
        case 'Cluster_110'
            if R3(i,1) < 0.1
                if R15(i,1) < 5
                    D = 1;
                else
                    D = 2;
                end
            else
                if R15(i,1) < 15
                    D = 2;
                else
                    D = 1;
                end
            end
        case 'Cluster_111'
            if R13(i,1) < 5
                D = 4;
            else
                D = 1;
            end
        case 'Cluster_112'
            D = 2;
        case 'Cluster_113'
            if R11(i,1) > 0.2
                D = 3;
            else
                D = 2;
            end
        case 'Cluster_114'
            if R13(i,1) > 100
                D = 1;
            else
                if R6(i,1) >= 5
                    D = 2;
                else
                    D = 3;
                end
            end
        case 'Cluster_115'
            if R15(i,1) >= 1
                D = 1;
            else
                D = 4;
            end
        case 'Cluster_116'
            if R6(i,1) < 0.1
                if R15(i,1) < 1.25
                    D = 5;
                else
                    D = 4;
                end
            else
                if R13(i,1) < 1
                    D = 2;
                else
                    D = 3;
                end
            end
        case 'Cluster_117'
            if R14(i,1) < 3
                D = 6;
            else
                D = 5;
            end
        case 'Cluster_118'
            if R15(i,1) < 2
                D = 1;
            else
                D = 6;
            end
        case 'Cluster_119'
            D = 6;
        case 'Cluster_120'
            if R3(i,1) < 0.05
                D = 6;
            else
                D = 3;
            end
        otherwise
            D = 7;
            
    end
    Diag_Prop(i,1) = D;
end

D_5 = Diag_Prop;
end
                

    