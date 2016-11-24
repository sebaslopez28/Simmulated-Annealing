clc
clear all

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
    
    x0 = 10*(2*rand(n_dimentions,1)-1);
    
    % ************************************************************************

    % print initial values
    sprintf('initial_temperature = %f', initial_temperature)
    sprintf('final_temperature = %f', final_temperature)
    sprintf('reduction_fraction = %f', reduction_fraction)

    % Calculate error for initial point
    
    func=sprintf('%s(x0)',target_function);
    error0 = eval(func);

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
            for i=1:n_dimentions
                x1(i) = x0(i) + (-0.5 + rand(1)) * dt;

                % If the point is outside the model, return it into the model
                x1(i) = max(min(x1(i),range_max),range_min);
            end

            % Calculate value of E for the new model
             func2=sprintf('%s(x1)',target_function);
             error1 = eval(func2);

            delta_error = error1 - error0;

            if (delta_error <0)
                for i=1:n_dimentions
                    x0(i) = x1(i);
                end
                error0 = error1;
            else
                p = exp(-(delta_error/temperature));
                r = rand;

                if (p>r)
                    for i=1:n_dimentions
                        x0(i) = x1(i);
                    end
                    error0 = error1;
                end
            end

        for i=1:n_dimentions
            text=sprintf('%2.8f,  ', x0(i));
            disp(text)
        end
        
        test1=sprintf('%s(x0)',target_function);
        test2 = eval(test1);
        
        text=sprintf('= %f',test2);
        disp(text)
        disp('----------')
        end
    end

    for i=1:n_dimentions
        result(i) = x0(i);
    end
    result