%% Prepare data for changing Load Profiles
clear all
%% Define files path
LPs_path='../IEEE_files/Initial_Load_Profile_csv/Load_profile_';

%% Define representative variables
Max_charger_power = 24;
Min_charging_time = 60;

Charging_power = 14;
Charging_time =Min_charging_time*(Max_charger_power/Charging_power);

arrive_time = 566; % in minutes. To modify Load Profile

%% Getting load profiles of the 55 loads /ready
for i=1:55
    if(i==1)
        T = readtable(strcat(LPs_path,num2str(i),'.csv'),'ReadVariableNames',false,'Format','%s%f\n');
        Time = T(:,1);
        LP = table2array(T(:,2));
    else
        T = readtable(strcat(LPs_path,num2str(i),'.csv'),'ReadVariableNames',false,'Format','%s%f\n');
        LP = [LP table2array(T(:,2))];
    end
end

%% Poision distribution and LoadProfile modification
% define each EV entrance time based on Poison distribution
% Modify LP values of EVs with 4kW taking into account the entrance time

paper_lamda=0.1; %departures/arrivals per second in the paper
lamda=paper_lamda*60; %modify lamda because GL-d simulation is each minute

take_load = linspace(1,55,55); %to select loads randomly

count=0; %how many EVs have dep/arrived
i=0; % to count minute of EV arrival. Start in 18:00
while (count~=55)
    EVs_pm = poissrnd(lamda); %how many cars depart/arrive in this minute
    
     if (count+EVs_pm>55) %to not exceed number of EVs/loads
         EVs_pm = 55-count;
         count_test=count;
     end
     count = count + EVs_pm;
     
    %  to selected load
    for e=1:EVs_pm
        [take_me,idx] = datasample(take_load,1); %take one random load
        
        % modify LP of taked load
        in = arrive_time +i; %to tell the minute of arrival
        for lp=(in):(in + Charging_time)
            LP(lp,take_me) = LP(lp,take_me) + Charging_power;
        end
        take_load(:,idx)=[]; %delete used load
    end
    
    i=i+1; %sum one minute to next EVs poisson arrival
end

%% Writing new Load Profiles /ready

LPs_path_new ='Load_profile_EVs_20kW/Load_profile_';
Time = table2cell(Time);

for i=1:55
    value = LP(:,i);
    LP_loadi = strcat(LPs_path_new,num2str(i),'.player');
    fileID = fopen(LP_loadi,'w');
    for j=1:1440
        fprintf(fileID,'%s,+%f\n',Time{j,:}, value(j));
    end
    fclose(fileID);
end







