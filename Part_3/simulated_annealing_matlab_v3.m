% v2.0 %
    
clc
clear all
close all

% Internal variables

    N=40; %numero de departamentos    
    Amax=140;  % Area maxima permetida por piso
    lift=[11 1]; % posiciones del ascensor
    
    n_cicles = 10;
    n_tries_for_cicle = 10;
    
    target_function = 'boha1';
    n_dimentions = 2;

    % Probabilities of accept the worst solution
    initial_probability = 0.7;
    final_probability = 0.001;

    % Calculate temperature and steps
    initial_temperature = -1 / log(initial_probability);
    final_temperature = -1 / log(final_probability);
    reduction_fraction = (final_temperature / initial_temperature)^(1/(n_cicles-1));


    % Initial position
    % Generate random number in the range of each dimention
    
    range_min=1;
    range_max=40;
    
    v0 = floor(4*(rand(n_dimentions,1)))
    
    % ************************************************************************

    % print initial values
    sprintf('initial_temperature = %f', initial_temperature)
    sprintf('final_temperature = %f', final_temperature)
    sprintf('reduction_fraction = %f', reduction_fraction)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%% Calculate error for initial point%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%% Se establecen las unidades de carga f1,f2,..,f20 y el flujo de cada producto C1,C2,..,C20 
    
    
    f1=[250     100     100     250     250     500];
    f2=[250     200     200     100];
    f3=[100     200     100];
    f4=[2000    400     200     400];
       
    f5=[250     250     500     100     200     250     500];
    f6=[250     100     200];
    f7=[250     200     200];
    f8=[500     200     200     200];
    f9=[500     100     100];
    
    f10=[250        100     100     200     200     100];
    f11=[200        100     200     200];
    f12=[250        200     100     200];
    f13=[250        100     250];
    f14=[250        50      25      62.5];
    
    f15=[250        100     200     200     200     100     200];
    f16=[200        200     100     100];
    f17=[2000       400     400     200];
    
    f18=[500        100     200     200     100     100     200     500];
    f19=[200        200     250     100];
    f20=[250        250     100     100];
    f21=[250        100     200     100];
    f22=[1000       200     100];
    
    C1=[40	1	9	10	11	2];
    C2=[40	1	3	4];
    C3=[40	1	5];
    C4=[40	1	5   6];
    
    C5=[40	1	12  13  14  15  2];
    C6=[40  16  17];
    C7=[40  18  19];
    C8=[40  1   3   4];
    C9=[40  1   5];
    
    
    C10=[40 20  21  22  23  8];
    C11=[40 7   24  25];
    C12=[40 1   3   4];
    C13=[40 1   5];
    C14=[40 1   5];
    
    C15=[40 26 27   28  29  8   2];
    C16=[40 1   3   4];
    C17=[40 1   5   6];
    
    
    C18=[40 1   30  31  32  33  34  2];
    C19=[40 1   36  37];
    C20=[40 1   38  39];
    C21=[40 1   3   4];
    C22=[40 1   5];

    % Tabla sobre la respectiva area de cada deparmento.
    A=[1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20 21	22	23	24	25	26	27	28	29	30	31	32	33	34	35	36	37	38	39	40;
8	16	12	12	16	8	8	16	4	16	16	4	16	16	8	8	4	4	4	4 16	16	8	8	4	4	8	16	12	4	4	16	16	4	4	4	4	8	4	32];
    

%% Generación del punto de partida 

while 2>1 
    A1=A(2,40);
    A2=0;
    A3=0;
    dept1=40;
    dept2=0;
    dept3=0;
    
        X0=randperm(39);

    for i=1:N-1

        v0 = floor(3*(rand(1,1)))+1;
    
    if v0==1
        dept1=[dept1 X0(i)];
        A1=A(2,X0(i))+A1;
    else if v0==2
            dept2=[dept2 X0(i)];
            A2=A(2,X0(i))+A2;
    else
            dept3=[dept3 X0(i)];
            A3=A(2,X0(i))+A3;
   end

    
    end  
    end
    if (A1<=Amax && A2<=Amax && A3<=Amax)
    break;
    end
    
end

%dept1=[1,3,4,9,10,12,28,30,31,32,33,36,37,38,39,40];
%dept2=[0 2, 5 6,7 ,8,11, 15,23,24,25,26,27,29,34,35];
%dept3=[0 13,14,16,17,19,20,21,22];
  

error1=0; 
error0=0;
sigma=16; % distancia entre pisos adyacentes
Cv=0.08;  % factor de costo vertical
Ch=0.016; % factor de costo Horizontal
No_f=22;  % numero de flujos establecidos en todo los productos
    
for k=1:No_f

    for i=1:length(eval(strcat('C',num2str(k))))-1
        
        Dk=0;
        Dg=0;
        
        for j=1:length(dept1)
        
        if dept1((j))==(eval(strcat('C',num2str(k),'(',num2str(i),')')))
        Dk=1;
        end
        
        if dept1((j))==(eval(strcat('C',num2str(k),'(',num2str(i+1),')')))
        Dg=1;
        end
        
        end
        
        for j=2:length(dept2)
        
        if dept2((j))==(eval(strcat('C',num2str(k),'(',num2str(i),')')))
        Dk=2;

        end
        
        if dept2((j))==(eval(strcat('C',num2str(k),'(',num2str(i+1),')')))
        Dg=2;

        end
        
        end
        
        
        for j=2:length(dept3)
        
        if dept3((j))==(eval(strcat('C',num2str(k),'(',num2str(i),')')))
        Dk=3;
        end
       
        if dept3((j))==(eval(strcat('C',num2str(k),'(',num2str(i+1),')')))
        Dg=3;
        end
        
        end
        
        error0=abs(Dg-Dk)*sigma*Cv*(eval(strcat('f',num2str(k),'(',num2str(i),')')))+error0;
        
    end

end


    dept1=sort(dept1);
    dept2=sort(dept2(2:end));
    dept3=sort(dept3(2:end));
    
       disp('Departamentos en el piso 1:');
       disp(dept1)
       
       disp('Departamentos en el piso 2:');
       disp(dept2)
       
       disp('Departamentos en el piso 3:');
       disp(dept3)

              
      disp('Funcion de costo vertical inicial:');
      disp(error0)
    
      cont=1;
      vector(cont)=error0;

  %%
    
   % Iterate over temperature
    
    X(1)=initial_temperature;
    cont=2;
    temperature=initial_temperature;
    while (temperature>=final_temperature)
        temperature=temperature*reduction_fraction;
        X(cont)=temperature;
        cont=cont+1;
    end;
    
    
    for temperature=X
        sprintf('Temperature = %f', temperature);
        % Iterations for each temperature
        for n=1:n_tries_for_cicle
    
    % Generate new point of exploration
   
    while 2>1 
    A1=A(2,40);
    A2=0;
    A3=0;
    dept1_f=40;
    dept2_f=0;
    dept3_f=0;

    X1=randperm(39);

    for i=1:N-1
               
    v0 = floor(3*(rand(1,1)))+1;
    
    if v0==1
        dept1_f=[dept1_f X1(i)];
        A1=A(2,X1(i))+A1;
    else if v0==2
            dept2_f=[dept2_f X1(i)];
            A2=A(2,X1(i))+A2;
    else
            dept3_f=[dept3_f X1(i)];
            A3=A(2,X1(i))+A3;
   end

    
    end  
    end
    if (A1<=Amax && A2<=Amax && A3<=Amax)
    break;
    end
    
    end


    
    for k=1:No_f

    for i=1:length(eval(strcat('C',num2str(k))))-1
        
        Dk=0;
        Dg=0;
        
        for j=1:length(dept1_f)
        
        if dept1_f((j))==(eval(strcat('C',num2str(k),'(',num2str(i),')')))
        Dk=1;
        end
        
        if dept1_f((j))==(eval(strcat('C',num2str(k),'(',num2str(i+1),')')))
        Dg=1;
        end
        
        end
        
        for j=2:length(dept2_f)
        
        if dept2_f((j))==(eval(strcat('C',num2str(k),'(',num2str(i),')')))
        Dk=2;

        end
        
        if dept2_f((j))==(eval(strcat('C',num2str(k),'(',num2str(i+1),')')))
        Dg=2;

        end
        
        end
        
        
        for j=2:length(dept3_f)
        
        if dept3_f((j))==(eval(strcat('C',num2str(k),'(',num2str(i),')')))
        Dk=3;
        end
       
        if dept3_f((j))==(eval(strcat('C',num2str(k),'(',num2str(i+1),')')))
        Dg=3;
        end
        
        end
        
        error1=abs(Dg-Dk)*sigma*Cv*(eval(strcat('f',num2str(k),'(',num2str(i),')')))+error1;
        
    end

end
               delta_error = error1 - error0;

            if (delta_error <0)
                for i=1:n_dimentions
                    dept1 = dept1_f;
                    dept2 = dept2_f;
                    dept3 = dept3_f;
                end
                error0 = error1;
            else
                p = exp(-(delta_error/temperature));
                r = rand;

                if (p>r)
                    for i=1:n_dimentions
                    dept1 = dept1_f;
                    dept2 = dept2_f;
                    dept3 = dept3_f;
                    end
                    error0 = error1;
                end
            end
            
            disp('----------')

       dept1=sort(dept1);
       dept2=sort(dept2);
       dept3=sort(dept3);
       
       disp('Departamentos en el piso 1:');
       disp(dept1)
       
       disp('Departamentos en el piso 2:');
       disp(dept2(2:end))
       
       disp('Departamentos en el piso 3:');
       disp(dept3(2:end))
          

             
        error1=0;
        
        disp('error0:');
        disp(error0)
        
        vector=[vector error0];
        cont=cont+1;
        
        disp('----------')

        end
    end

    disp('           ----------')
    disp(' resultado ----------')

    dept1=sort(dept1)
    dept2=sort(dept2(2:end))
    dept3=sort(dept3(2:end))
    
     disp('Departamentos en el piso 1:');
       disp(dept1)
       
       disp('Departamentos en el piso 2:');
       disp(dept2(1:end))
       
       disp('Departamentos en el piso 3:');
       disp(dept3(1:end))
    
      disp('Funcion de costo vertical final:');
      disp(error0)
    figure, plot(vector)
    title('Funcion Costo - Primera Etapa');
 
    Ac=A;

% dept1=[1,3,4,9,10,12,28,30,31,32,33,36,37,38,39,40];
% dept2=[2, 5 6,7 ,8,11, 15,23,24,25,26,27,29,34,35];
% dept2=[24,23,11,5,6,7,25,34,8,2,26,35,29,15,27];
% dept3=[19,13,14,18,17,16,21,20,22];
% dept3=[13,14,16,17,19,20,21,22];
     


%% Seccond Stage
 
    piso1=[dept1'];
    piso2=[dept2'];
    piso3=[dept3'];

    sec_p2y3=[8 6 5 6 6 8 4 8 6 8 4 4 5 4 8 8 8 6 5 6 6 8 4 8 6 8 4 4 5 4 8 8 8 6 5 6 8 6 5 6 8 6 5 6 8 6 5 5 5 4 8 4 4 5 6 5 4 5 6 6 8 6 5 5 5 4 8 4 4 5 6 5 4 5 6 6 8 6 5 6 6 8 4 8 8 6 5 6 8 6 5 5 4 5 6 6 6 8 4 8 6 8 4 8 6 8 4 8 6 8 4 4 4 5 6 5 5 4 8 4 5 4 8 8 6 8 4 8 8 6 5 6 8 6 5 6 8 6 5];
    sec_p1=[4 8 6 8 4 8 6 8 4 8 6 8 4 8 6 8 4 8 6 6 5 6 8 6 6 5 4 5 6 5 4 4 8 4 5 5 5 6 8 6 6 5 4 5 6 5 4 4 8 4 5 5 5 6 8 6 5 6 8 6 5 6 8 6 5 6 8 8 8 4 5 4 4 8 6 8 4 8 6 6 5 6 8 8 8 4 5 4 4 8 6 8 4 8 6 6 5 6 8 6 5 6 8 6 5 6 8];
                 
    p_inicial1=[10,2];
    p_inicial2y3=[10,1];

    [Ac, m_layout1,posiciones1]= layout(Ac, p_inicial1, piso1, sec_p1,1);
    figure,
    imagesc(m_layout1), caxis([-10 35])
     title('Primer Piso - Inicial');
     
    for ii=1:1:(size(posiciones1,1))
    text(posiciones1(ii,2),posiciones1(ii,1),strcat('\fontsize{15}',num2str(posiciones1(ii,3))),'color',[0.5 0.5 0.5]);
    end
    text(12,7,'\fontsize{15} 40','color',[0.5 0.5 0.5]);
    axis square

    [Ac, m_layout2,posiciones2]= layout(Ac, p_inicial2y3, piso2, sec_p2y3,2);
    figure,
    imagesc(m_layout2)
    title('Segundo Piso - Inicial');

    for ii=1:1:(size(posiciones2,1))
    text(posiciones2(ii,2),posiciones2(ii,1),strcat('\fontsize{15}',num2str(posiciones2(ii,3))),'color',[0.5 0.5 0.5]);
    end
    axis square


    [Ac, m_layout3, posiciones3]= layout(Ac, p_inicial2y3, piso3, sec_p2y3,3);
    figure,
    imagesc(m_layout3)
    title('Tercer Piso - Inicial');

    for ii=1:1:(size(posiciones3,1))
    text(posiciones3(ii,2),posiciones3(ii,1),strcat('\fontsize{15}',num2str(posiciones3(ii,3))), 'color', [0.5 0.5 0.5]);
    end
    axis square



posiciones1(length(posiciones1(:,3))+1,1:3)=0;
posiciones1(length(posiciones1(:,3)),3)=40;


error1=0;
error0=0;

cont=1;

for k=1:No_f

        for i=1:length(eval(strcat('C',num2str(k))))-1
%     for i=1:1
        
        [ik1,jk1]=find(posiciones1(:,3)==(eval(strcat('C',num2str(k),'(',num2str(i),')'))));
        [ik2,jk2]=find(posiciones1(:,3)==(eval(strcat('C',num2str(k),'(',num2str(i+1),')'))));

        [ik3,jk3]=find(posiciones2(:,3)==(eval(strcat('C',num2str(k),'(',num2str(i),')'))));
        [ik4,jk4]=find(posiciones2(:,3)==(eval(strcat('C',num2str(k),'(',num2str(i+1),')'))));

        [ik5,jk5]=find(posiciones3(:,3)==(eval(strcat('C',num2str(k),'(',num2str(i),')'))));
        [ik6,jk6]=find(posiciones3(:,3)==(eval(strcat('C',num2str(k),'(',num2str(i+1),')'))));

        if isempty(ik1)==0 
            dk=1;
        end
        if isempty(ik2)==0
            dg=1;
        end
        
        if isempty(ik3)==0 
            dk=2;
        end
        if isempty(ik4)==0
            dg=2;
        end

        if isempty(ik5)==0 
            dk=3;
        end
        if isempty(ik6)==0
            dg=3;
        end
        
        
            [ixx1 jxx1]=find(eval(strcat('C',num2str(k),'(',num2str(i),')'))==Ac(1,:));
            [ixx2 jxx2]=find(eval(strcat('C',num2str(k),'(',num2str(i+1),')'))==Ac(1,:));
            
        if (dk-dg==0)
%             disp('son el mismo piso');
            distance=sqrt((Ac(3,jxx1)-Ac(3,jxx2))^2+(Ac(4,jxx1)-Ac(4,jxx2))^2);
        else
%             disp('son pisos distintos');
            distance=sqrt((Ac(3,jxx1)-lift(1))^2+(Ac(4,jxx1)-lift(2))^2)+sqrt((Ac(3,jxx1)-lift(1))^2+(Ac(4,jxx1)-lift(2)^2));
        end
        vector2(cont)=distance;
        cont=cont+1;
        error0=distance*Ch*(eval(strcat('f',num2str(k),'(',num2str(i),')')))+error0;
    end
end

disp('Funcion de costo horizontal inicial:');
disp(error0);

    lift=[11 1]; % posiciones del ascensor

    n_cicles = 10;
    n_tries_for_cicle = 10;
    
    n_dimentions = 2;

    % Probabilities of accept the worst solution
    initial_probability = 0.7;
    final_probability = 0.001;

    % Calculate temperature and steps
    initial_temperature = -1 / log(initial_probability);
    final_temperature = -1 / log(final_probability);
    reduction_fraction = (final_temperature / initial_temperature)^(1/(n_cicles-1));

    % Initial position
    % Generate random number in the range of each dimention
    
    range_min=1;
    range_max=40;
    
    
    % ************************************************************************

    % print initial values
    sprintf('initial_temperature = %f', initial_temperature)
    sprintf('final_temperature = %f', final_temperature)
    sprintf('reduction_fraction = %f', reduction_fraction)
    conta=1;
    
     X(1)=initial_temperature;
    cont=2;
    temperature=initial_temperature;
    while (temperature>=final_temperature)
        temperature=temperature*reduction_fraction;
        X(cont)=temperature;
        cont=cont+1;
    end;
    
     for temperature=X
         
        sprintf('Temperature = %f', temperature);
        % Iterations for each temperature
        for n=1:n_tries_for_cicle
            
   
    dept_1=dept1(randperm(length(dept1)));
    dept_2=dept2(randperm(length(dept2)));
    dept_3=dept3(randperm(length(dept3)));
   
    Ac=A;
 
    piso1=[dept_1'];
    piso2=[dept_2'];
    piso3=[dept_3'];


[Ac, m_layout1,posiciones1]= layout(Ac, p_inicial1, piso1, sec_p1,1);
% figure
% imagesc(m_layout1), caxis([-10 35])
% for ii=1:1:(size(posiciones1,1))
%     text(posiciones1(ii,2),posiciones1(ii,1),strcat('\fontsize{15}',num2str(posiciones1(ii,3))),'color',[0.5 0.5 0.5]);
% end
% text(12,7,'\fontsize{15} 40','color',[0.5 0.5 0.5]);
% axis square



% posiciones=[];
[Ac, m_layout2,posiciones2]= layout(Ac, p_inicial2y3, piso2, sec_p2y3,2);
% figure
% imagesc(m_layout2)
% 
% for ii=1:1:(size(posiciones2,1))
%     text(posiciones2(ii,2),posiciones2(ii,1),strcat('\fontsize{15}',num2str(posiciones2(ii,3))),'color',[0.5 0.5 0.5]);
% end
% axis square


% posiciones=[];
[Ac, m_layout3, posiciones3]= layout(Ac, p_inicial2y3, piso3, sec_p2y3,3);
% figure
% imagesc(m_layout3)
% 
% for ii=1:1:(size(posiciones3,1))
%     text(posiciones3(ii,2),posiciones3(ii,1),strcat('\fontsize{15}',num2str(posiciones3(ii,3))), 'color', [0.5 0.5 0.5]);
% end
% axis square




%%
    cont=1;
    posiciones1(length(posiciones1(:,3))+1,1:3)=0;
    posiciones1(length(posiciones1(:,3)),3)=40;

for k=1:No_f

        for i=1:length(eval(strcat('C',num2str(k))))-1
%     for i=1:2
        
        [ik1,jk1]=find(posiciones1(:,3)==(eval(strcat('C',num2str(k),'(',num2str(i),')'))));
        [ik2,jk2]=find(posiciones1(:,3)==(eval(strcat('C',num2str(k),'(',num2str(i+1),')'))));

        [ik3,jk3]=find(posiciones2(:,3)==(eval(strcat('C',num2str(k),'(',num2str(i),')'))));
        [ik4,jk4]=find(posiciones2(:,3)==(eval(strcat('C',num2str(k),'(',num2str(i+1),')'))));

        [ik5,jk5]=find(posiciones3(:,3)==(eval(strcat('C',num2str(k),'(',num2str(i),')'))));
        [ik6,jk6]=find(posiciones3(:,3)==(eval(strcat('C',num2str(k),'(',num2str(i+1),')'))));

        if isempty(ik1)==0 
            dk=1;
        end
        if isempty(ik2)==0
            dg=1;
        end
        
        if isempty(ik3)==0 
            dk=2;
        end
        if isempty(ik4)==0
            dg=2;
        end

        if isempty(ik5)==0 
                    dk=3;
        end
        if isempty(ik6)==0
            dg=3;
        end
        
        
            [ixx1 jxx1]=find(eval(strcat('C',num2str(k),'(',num2str(i),')'))==Ac(1,:));
            [ixx2 jxx2]=find(eval(strcat('C',num2str(k),'(',num2str(i+1),')'))==Ac(1,:));
            
        if (dk-dg==0)
%             disp('son el mismo piso');
            distance=sqrt((Ac(3,jxx1)-Ac(3,jxx2))^2+(Ac(4,jxx1)-Ac(4,jxx2))^2);
        else
%             disp('son pisos distintos');
            distance=sqrt((Ac(3,jxx1)-lift(1))^2+(Ac(4,jxx1)-lift(2))^2)+sqrt((Ac(3,jxx1)-lift(1))^2+(Ac(4,jxx1)-lift(2)^2));
        end
%         distance
        vector3(cont)=distance;
        cont=cont+1;
        error1=distance*Ch*(eval(strcat('f',num2str(k),'(',num2str(i),')')))+error1;
    end
end

  delta_error = error1 - error0;

            if (delta_error <0)
                for i=1:n_dimentions
                    dept_11 = dept_1;
                    dept_22 = dept_2;
                    dept_33 = dept_3;
                end
                error0 = error1;
            else
                p = exp(-(delta_error/temperature));
                r = rand;

                if (p>r)
                    for i=1:n_dimentions
                    dept_11 = dept_1;
                    dept_22 = dept_2;
                    dept_33 = dept_3;
                    end
                    error0 = error1;
                end
            end
            
            disp('----------')

      
                  
        error1=0;
        
        disp('error0:');
        disp(error0)
        Error2(conta)=error0;
        conta=conta+1;
        
        disp('----------')

        end
    end

piso1=[dept_11'];
piso2=[dept_22'];
piso3=[dept_33'];

sec_p2y3=[8 6 5 6 6 8 4 8 6 8 4 4 5 4 8 8 8 6 5 6 6 8 4 8 6 8 4 4 5 4 8 8 8 6 5 6 8 6 5 6 8 6 5 6 8 6 5 5 5 4 8 4 4 5 6 5 4 5 6 6 8 6 5 5 5 4 8 4 4 5 6 5 4 5 6 6 8 6 5 6 6 8 4 8 8 6 5 6 8 6 5 5 4 5 6 6 6 8 4 8 6 8 4 8 6 8 4 8 6 8 4 4 4 5 6 5 5 4 8 4 5 4 8 8 6 8 4 8 8 6 5 6 8 6 5 6 8 6 5];
sec_p1=[4 8 6 8 4 8 6 8 4 8 6 8 4 8 6 8 4 8 6 6 5 6 8 6 6 5 4 5 6 5 4 4 8 4 5 5 5 6 8 6 6 5 4 5 6 5 4 4 8 4 5 5 5 6 8 6 5 6 8 6 5 6 8 6 5 6 8 8 8 4 5 4 4 8 6 8 4 8 6 6 5 6 8 8 8 4 5 4 4 8 6 8 4 8 6 6 5 6 8 6 5 6 8 6 5 6 8];
                 
p_inicial1=[10,2];
p_inicial2y3=[10,1];

[Ac, m_layout1,posiciones1]= layout(A, p_inicial1, piso1, sec_p1,1);
figure
imagesc(m_layout1), caxis([-10 35]),
title('Primer Piso - Final');

for ii=1:1:(size(posiciones1,1))
    text(posiciones1(ii,2),posiciones1(ii,1),strcat('\fontsize{15}',num2str(posiciones1(ii,3))),'color',[0.5 0.5 0.5]);
end
text(12,7,'\fontsize{15} 40','color',[0.5 0.5 0.5]);
axis square



% posiciones=[];
[Ac, m_layout2,posiciones2]= layout(A, p_inicial2y3, piso2, sec_p2y3,2);
figure,
imagesc(m_layout2)
title('Segundo Piso - Final');

for ii=1:1:(size(posiciones2,1))
    text(posiciones2(ii,2),posiciones2(ii,1),strcat('\fontsize{15}',num2str(posiciones2(ii,3))),'color',[0.5 0.5 0.5]);
end
axis square


% posiciones=[];
[Ac, m_layout3, posiciones3]= layout(A, p_inicial2y3, piso3, sec_p2y3,3);
figure,
imagesc(m_layout3)
title('Tercer Piso - Final');


for ii=1:1:(size(posiciones3,1))
    text(posiciones3(ii,2),posiciones3(ii,1),strcat('\fontsize{15}',num2str(posiciones3(ii,3))), 'color', [0.5 0.5 0.5]);
end
axis square


disp('Funcion de costo horizontal final:');
disp(error0);

figure
plot(Error2);
title('Funcion de costo - Segunda Etapa')