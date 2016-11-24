function [Ac, m_layout,posiciones]= layout(Ac, p_actual, vec_test, secuencia,piso)


% A=[1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20 21	22	23	24	25	26	27	28	29	30	31	32	33	34	35	36	37	38	39	40;
%    8	16	12	12	16	8	8	16	4	16	16	4	16	16	8	8	4	4	4	4 16	16	8	8	4	4	8	16	12	4	4	16	16	4	4	4	4	8	4	32];

%   Forma del Layout   Si se quiere subir no se suma en realidad se resta y
%   así
%   8 => Arriba
%   6 => Derecha
%   4 => Izquierda
%   0 => Abajo 
% sec_p2y3=[8 6 5 6 6 8 4 8 6 8 4 4 5 4 8 8 8 6 5 6 6 8 4 8 6 8 4 4 5 4 8 8 8 6 5 6 8 6 5 6 8 6 5 6 8 6 5 5 5 4 8 4 4 5 6 5 4 5 6 6 8 6 5 5 5 4 8 4 4 5 6 5 4 5 6 6 8 6 5 6 6 8 4 8 8 6 5 6 8 6 5 5 4 5 6 6 6 8 4 8 6 8 4 8 6 8 4 8 6 8 4 4 4 5 6 5 5 4 8 4 5 4 8 8 6 8 4 8 8 6 5 6 8 6 5 6 8 6 5];
% sec_p1=[4 8 6 8 4 8 6 8 4 8 6 8 4 8 6 8 4 8 6 6 5 6 8 6 6 5 4 5 6 5 4 4 8 4 5 5 5 6 8 6 6 5 4 5 6 5 4 4 8 4 5 5 5 6 8 6 5 6 8 6 5 6 8 6 5 6 8 8 8 4 5 4 4 8 6 8 4 8 6 6 5 6 8 8 8 4 5 4 4 8 6 8 4 8 6 6 5 6 8 6 5 6 8 6 5 6 8];

% vec_test=[8    12    15    19    20    25    29    32    33    38    39];

% p_inicial1=[10,2];
% p_inicial2y3=[10,1];
%% Llenado del Layout

m_layout=ones(10,14).*0;
% p_actual=p_inicial1;
% secuencia=sec_p1;

cont=length(secuencia);

Ac(2,vec_test(1))=Ac(2,vec_test(1))-1;
m_layout(p_actual(1),p_actual(2))=vec_test(1,1);

Ax=p_actual(2)-0.5;
Ay=p_actual(1)-0.5;
At=1;

if (piso==1)   % si es el piso 1
    
    m_layout(3:end,11:end)=40;
    indexx=find(vec_test==40);
    Ac(3,40)=6;
    Ac(4,40)=12;
    Ac(5,40)=1;
    
    if (size(vec_test,1)>1)
        vec_test=[vec_test(1:indexx-1) ; vec_test(indexx+1:end)];
    else
        vec_test=[vec_test(1:indexx-1) , vec_test(indexx+1:end)];
    end
end
    
conta=1;
posiciones(conta,1)=p_actual(1);
posiciones(conta,2)=p_actual(2);
posiciones(conta,3)=vec_test(1);
conta=2;
for i=1:1:(length(vec_test) )

    for j=1:1:(Ac(2,vec_test(i)))
       
        cont_v=1 + mod(cont,length(secuencia));
        switch(secuencia(cont_v))
            case 8
                p_actual(1)= p_actual(1)-1;
%                 disp('arriba');
            case 6
                p_actual(2)=p_actual(2)+1;
%                 disp('derecha');
            case 4 
                p_actual(2)=p_actual(2)-1;
%                 disp('izquierda');
            case 5
                p_actual(1)=p_actual(1)+1;
%                 disp('abajo');
        end
        %===========CENTROIDE============
        Ax=Ax + p_actual(2) - 0.5;
        Ay=Ay + p_actual(1) - 0.5;
        At=At + 1;
        %================================
        
        cont=cont+1;
        m_layout(p_actual(1),p_actual(2))=vec_test(i);
        
        posiciones(conta,1)=p_actual(1);
        posiciones(conta,2)=p_actual(2);
        posiciones(conta,3)=vec_test(i);
        conta=conta+1;
%         imagesc(m_layout)
%         pause
        
    end
    Ac(3,vec_test(i)) = Ay/At;   %Centro de masa en Y (Filas)
    Ac(4,vec_test(i)) = Ax/At;   %Centro de masa en X (Columnas)
    Ac(5,vec_test(i)) = piso;   %Centro de masa en X (Columnas)

    
    Ax=0;
    Ay=0;
    At=0;
    
end
Ac(2,vec_test(1))=1 + Ac(2,vec_test(1));
