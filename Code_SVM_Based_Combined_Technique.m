clc
clear
format long
load CombModel
% ------------------------
% Chargement des donn√©es
% ------------------------

N = 117;        % Nombre d'Èchantillon
Feuille = 1;    % Feuille excel

n1 = xlsread('Data.xlsm',Feuille,'A2:A118'); % ('Concentration de H2')
n2 = xlsread('Data.xlsm',Feuille,'B2:B118'); % ('Concentration de CH4')
n3 = xlsread('Data.xlsm',Feuille,'C2:C118'); % ('Concentration de C2H6')
n4 = xlsread('Data.xlsm',Feuille,'D2:D118'); % ('Concentration de C2H4')
n5 = xlsread('Data.xlsm',Feuille,'E2:E118'); % ('Concentration de C2H2')

% -----------------
% Initialisations
% -----------------

DDD = zeros(N,1); DD = zeros(N,1); Di = zeros(N,1); D_8 = zeros(N,1);

D_1 = Code_Hybrid_Method_Elsevier_Vect_1(n1, n2, n3, n4, n5, N);
D_2 = Code_Hybrid_Method_Elsevier_Vect_2(n1, n2, n3, n4, n5, N);
D_3 = Code_Hybrid_Method_Elsevier_Vect_3(n1, n2, n3, n4, n5, N);
D_4 = Code_Hybrid_Method_Elsevier_Vect_4(n1, n2, n3, n4, n5, N);
D_5 = Code_Hybrid_Method_Elsevier_Vect_5(n1, n2, n3, n4, n5, N);
D_6 = Code_Hybrid_Method_Elsevier_Vect_6(n1, n2, n3, n4, n5, N);
D_7 = Code_Hybrid_Method_Elsevier_Vect_7(n1, n2, n3, n4, n5, N);

for i = 1:N
    D_8(i) = CombinedModel.predictFcn([D_1(i) D_2(i) D_3(i) D_4(i) D_5(i) D_6(i) D_7(i)]);
end

% for i = 1:N
%     
%     if ((D_1(i,1) == D_2(i,1)) && (D_2(i,1) == D_3(i,1)) && (D_3(i,1) == D_4(i,1)) && (D_4(i,1) == D_5(i,1)) && (D_5(i,1) == D_6(i,1)) && (D_6(i,1) == D_7(i,1)))
% %         if (((D_1(i,1) == 4) || (D_1(i,1) == 5) || (D_1(i,1) == 6)))% || ((D_3(i,1) == 4) || (D_3(i,1) == 5) || (D_3(i,1) == 6))) %&& ((D_4(i,1) == 4) || (D_4(i,1) == 5) || (D_4(i,1) == 6)))
% %             Di(i,1) = D_1(i,1);
% %         else
% %             Di(i,1) = D_1(i,1);
% %         end
%         Di(i,1) = D_1(i,1);
%         Dii(i,1) = 1;
%     else
%         Dii(i,1) = 0;
%         if (((D_1(i,1) == 4) || (D_1(i,1) == 5) || (D_1(i,1) == 6)))% || ((D_3(i,1) == 4) || (D_3(i,1) == 5) || (D_3(i,1) == 6))) %&& ((D_4(i,1) == 4) || (D_4(i,1) == 5) || (D_4(i,1) == 6)))
%             if (((D_6(i,1) == 1) || (D_6(i,1) == 2) || (D_6(i,1) == 3)))
%                 DDD(i,1) = 1; % ELEC
%             else
%                 DDD(i,1) = 2; % THERM
%             end
%         else
%             DDD(i,1) = 3; % ELEC
%         end
% 
%         if DDD(i,1) == 1
%             Di(i,1) = D_6(i,1);
%         elseif DDD(i,1) == 2
%             if ((D_4(i,1) == 4) || (D_4(i,1) == 5))% && ((D_6(i,1) == 2) || (D_6(i,1) == 3)))
%                 DD(i,1) = 1; % T1/T2
%             else
%                 DD(i,1) = 2; % T3
%             end
%         else
%             if ((D_5(i,1) == 2) || (D_5(i,1) == 3))% && ((D_6(i,1) == 2) || (D_6(i,1) == 3)))
%                 DD(i,1) = 3; % D1/D2
%             else
%                 DD(i,1) = 4; % PD
%             end
%         end
% % % 
%         if DD(i,1) == 2
%             Di(i,1) = 6;
%         elseif DD(i,1) == 3
%             if ((D_7(i,1) == 2))% && ((D_6(i,1) == 2) || (D_6(i,1) == 3)))
%                 if ((D_3(i,1) == 3))
%                     Di(i,1) = 3;
%                 else
%                     Di(i,1) = 2;
%                 end
%             else
%                 Di(i,1) = 3;
%             end
%         elseif DD(i,1) == 4
%             Di(i,1) = 1;
%         else
%             if ((D_1(i,1) == 4))% && ((D_6(i,1) == 2) || (D_6(i,1) == 3)))
%                 if ((D_5(i,1) == 5))
%                     Di(i,1) = 5;
%                 else
%                     Di(i,1) = 4;
%                 end
%             else
%                 if ((D_5(i,1) == 4))
%                     Di(i,1) = 4;
%                 else
%                     Di(i,1) = 5;
%                 end
%             end
%         end
%     end
%     D_8(i,1) = Di(i,1);
% end

% for i = 1:N
%     
%     if ((((D_1(i,1) == 4) || (D_1(i,1) == 5) || (D_1(i,1) == 6)) && ((D_3(i,1) == 4) || (D_3(i,1) == 5) || (D_3(i,1) == 6)) && ((D_4(i,1) == 4) || (D_4(i,1) == 5) || (D_4(i,1) == 6))))
%         DDD(i,1) = 2;
%     else
%         DDD(i,1) = 1;
%     end
%     
%     if DDD(i,1) == 1
%         if ((D_1(i,1) == 1) && (D_2(i,1) == 1) && (D_4(i,1) == 1) && (D_5(i,1) == 1) && (D_7(i,1) == 1))
%             DD(i,1) = 1;
%         else
%             DD(i,1) = 2;
%         end
%     else
%         if (((D_1(i,1) == 4) || (D_1(i,1) == 5)) && ((D_4(i,1) == 4) || (D_4(i,1) == 5)) && ((D_5(i,1) == 4) || (D_5(i,1) == 5)) && ((D_6(i,1) == 4) || (D_6(i,1) == 5)))
%             DD(i,1) = 3;
%         else
%             DD(i,1) = 4;
%         end
%     end
%     
%     if DD(i,1) == 1
%         Di(i,1) = 1;
%     elseif DD(i,1) == 2
%         if ((D_4(i,1) == 3) && (D_6(i,1) == 3))
%             Di(i,1) = 3;
%         else
%             Di(i,1) = 2;
%         end
%     elseif DD(i,1) == 4
%         Di(i,1) = 6;
%     else
%         if ((D_2(i,1) == 4) && (D_4(i,1) == 4) && (D_5(i,1) == 4))
%             Di(i,1) = 4;
%         else
%             Di(i,1) = 5;
%         end
%     end
%     
%     D_8(i,1) = Di(i,1);
% end


xlswrite('Data.xlsm',D_1,Feuille,'G2:G118')
xlswrite('Data.xlsm',D_2,Feuille,'H2:H118')
xlswrite('Data.xlsm',D_3,Feuille,'I2:I118')
xlswrite('Data.xlsm',D_4,Feuille,'J2:J118')
xlswrite('Data.xlsm',D_5,Feuille,'K2:K118')
xlswrite('Data.xlsm',D_6,Feuille,'L2:L118')
xlswrite('Data.xlsm',D_7,Feuille,'M2:M118')
xlswrite('Data.xlsm',D_8,Feuille,'N2:N118')
% xlswrite('Data.xlsm',Dii,Feuille,'O2:O118')
                

    