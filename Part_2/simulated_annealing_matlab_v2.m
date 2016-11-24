% Se plantea solución para el problema minimizando la funcion de costo
% verticalmente. Se espera establecer los departamentos unicamente por piso


clc
clear all
close all

% Internal variables
		
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

    dt = 8; %Normalization

    % Initial position
    % Generate random number in the range of each dimention
    
    range_min=-10;
    range_max=10;
    
    v0 = floor(4*(rand(n_dimentions,1)))
    
    % ************************************************************************

    % print initial values
    sprintf('initial_temperature = %f', initial_temperature)
    sprintf('final_temperature = %f', final_temperature)
    sprintf('reduction_fraction = %f', reduction_fraction)

    % Calculate error for initial point
    
    %%
    % establecer la x0 para este caso sera la posicion de todos los
    % departamentos por piso
    
    
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


    A=[1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20 21	22	23	24	25	26	27	28	29	30	31	32	33	34	35	36	37	38	39	40;
8	16	12	12	16	8	8	16	4	16	16	4	16	16	8	8	4	4	4	4 16	16	8	8	4	4	8	16	12	4	4	16	16	4	4	4	4	8	4	32];
    
N=40; %numero de departamentos    
Amax=168;



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
        A1=A(2,i)+A1;
    else if v0==2
            dept2=[dept2 X0(i)];
            A2=A(2,i)+A2;
    else
            dept3=[dept3 X0(i)];
            A3=A(2,i)+A3;
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
  
element1=0;
element2=0;
element3=0;


for j=1:length(dept1)
    
    for i=1:length(C1)
    [i1,j1]=find(dept1(j)==C1(i));
    if j1==1
    element1=[element1 j];
    end
    end

end

for j=1:length(dept2)

    for i=1:length(C1)
    [i1,j1]=find(dept2(j)==C1(i));
    if j1==1
    element2=[element2 j];
    end
    end

end

for j=1:length(dept3)

    for i=1:length(C1)
    [i1,j1]=find(dept3(j)==C1(i));
    if j1==1
    element3=[element3 j];
    end
    end
end

error1=0;
error0=0;
sigma=16;
Cv=0.08;
Ch=0.016;
No_f=22;
    
for k=1:No_f

    for i=1:length(eval(strcat('C',num2str(k))))-1
        
        Dk=0;
        Dg=0;
        
        for j=2:length(element1)
        
        if dept1(element1(j))==(eval(strcat('C',num2str(k),'(',num2str(i),')')))
        Dk=1;
        end
        
        if dept1(element1(j))==(eval(strcat('C',num2str(k),'(',num2str(i+1),')')))
        Dg=1;
        end
        
        end
        
        for j=2:length(element2)
        
        if dept2(element2(j))==(eval(strcat('C',num2str(k),'(',num2str(i),')')))
        Dk=2;

        end
        
        if dept2(element2(j))==(eval(strcat('C',num2str(k),'(',num2str(i+1),')')))
        Dg=2;

        end
        
        end
        
        
        for j=2:length(element3)
        
        if dept3(element3(j))==(eval(strcat('C',num2str(k),'(',num2str(i),')')))
        Dk=3;
        end
       
        if dept3(element3(j))==(eval(strcat('C',num2str(k),'(',num2str(i+1),')')))
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

              
      disp('error0:');
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
        A1=A(2,i)+A1;
    else if v0==2
            dept2_f=[dept2_f X1(i)];
            A2=A(2,i)+A2;
    else
            dept3_f=[dept3_f X1(i)];
            A3=A(2,i)+A3;
   end

    
    end  
    end
    if (A1<=Amax && A2<=Amax && A3<=Amax)
    break;
    end
    
end

 
element1=0;
element2=0;
element3=0;


for j=1:length(dept1_f)
    
    for i=1:length(C1)
    [i1,j1]=find(dept1_f(j)==C1(i));
    if j1==1
    element1=[element1 j];
    end
    end

end

for j=1:length(dept2_f)

    for i=1:length(C1)
    [i1,j1]=find(dept2_f(j)==C1(i));
    if j1==1
    element2=[element2 j];
    end
    end

end

for j=1:length(dept3_f)

    for i=1:length(C1)
    [i1,j1]=find(dept3_f(j)==C1(i));
    if j1==1
    element3=[element3 j];
    end
    end
end


    
for k=1:No_f

    for i=1:length(eval(strcat('C',num2str(k))))-1
        
        Dk=0;
        Dg=0;
        
        for j=2:length(element1)
        
        if dept1_f(element1(j))==(eval(strcat('C',num2str(k),'(',num2str(i),')')))
        Dk=1;
        end
        
        if dept1_f(element1(j))==(eval(strcat('C',num2str(k),'(',num2str(i+1),')')))
        Dg=1;
        end
        
        end
        
        for j=2:length(element2)
        
        if dept2_f(element2(j))==(eval(strcat('C',num2str(k),'(',num2str(i),')')))
        Dk=2;

        end
        
        if dept2_f(element2(j))==(eval(strcat('C',num2str(k),'(',num2str(i+1),')')))
        Dg=2;

        end
        
        end
        
        
        for j=2:length(element3)
        
        if dept3_f(element3(j))==(eval(strcat('C',num2str(k),'(',num2str(i),')')))
        Dk=3;
        end
       
        if dept3_f(element3(j))==(eval(strcat('C',num2str(k),'(',num2str(i+1),')')))
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
       disp(dept2(2:end))
       
       disp('Departamentos en el piso 3:');
       disp(dept3(2:end))
    
      disp('error0:');
      disp(error0)
      
    
    
    figure, plot(vector)

    
