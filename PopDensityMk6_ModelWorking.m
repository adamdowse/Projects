%Simulating an infection spread (Zombie Outbreak) with the SRI model.
%By Adam Dowse
%11/3/19

%Initilise Variables
b = 0.008;  %The average number of contacts per day to spread the infection
y = 0.7;    %

Ftime = 500;%The max time to run

%Create the square population (the world)
Worldsize = 100;      %The size  

%Suseptable People
S = zeros(Worldsize+2);%Create the world and initalise to zero
S(2:Worldsize-1,2:Worldsize-1) = randi(500,Worldsize-2); %Add the population with random variation
S(2:floor(Worldsize/2),floor(Worldsize/2)) = 0; %Simulate a wall stopping transmition

%Infected People
I = zeros(Worldsize);   %Initalise to zero
I(3,4) = 1;             %Set one infected person

%Recovered People (Assumed they cant transmit infection)
R = zeros(Worldsize);

%Solve Equations 
for t = 2:Ftime
    for i = 2:(Worldsize-1) %Work within boundaries
        for j = 2:(Worldsize-1)
            %The S.I.R Differential Equations
            S(i,j,t) = S(i,j,t-1)-b.*((I(i,j,t-1)*S(i,j,t-1))+(I(i-1,j,t-1)*S(i-1,j,t-1))+(I(i+1,j,t-1)*S(i+1,j,t-1))+(I(i,j-1,t-1)*S(i,j-1,t-1))+(I(i,j+1,t-1)*S(i,j+1,t-1)));
            I(i,j,t) = I(i,j,t-1)+(b*((I(i,j,t-1)*S(i,j,t-1))+(I(i-1,j,t-1)*S(i-1,j,t-1))+(I(i+1,j,t-1)*S(i+1,j,t-1))+(I(i,j-1,t-1)*S(i,j-1,t-1))+(I(i,j+1,t-1)*S(i,j+1,t-1))) - y*I(i,j,t-1));
            R(i,j,t) = R(i,j,t-1) + y*I(i,j,t-1);
            
            %Setting cut off point so small numbers are not used
            if S(i,j,t) < 0.001
                S(i,j,t) = 0;
            end
            if I(i,j,t) < 0.001
                I(i,j,t) = 0;
            end
            if R(i,j,t) <0.001
                R(i,j,t) = 0;
            end
        end
    end
end

%Display the heatmap of the population 
m = heatmap(S(:,:,1));
for k = 2:Ftime
    pause(0.1);
    set(m,'ColorData',S(:,:,k));
    drawnow;
end


    
    
    
    