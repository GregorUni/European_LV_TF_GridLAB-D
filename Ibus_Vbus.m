clear all


%% Define files to read

LoadsFile= 'IEEE_files/European_LV_CSV/Loads.csv';
linesFile='IEEE_files/European_LV_CSV/Lines.csv';
%files from Case1
VoltageFile1p= 'Output_case1/output_voltage_1.csv';
CurrentFile1p= 'Output_case1/output_current_1.csv';
%files from Case1 3phasic loads
VoltageFile3p= 'Output_case1_3p/output_voltage_1.csv';
CurrentFile3p= 'Output_case1_3p/output_current_1.csv';

%% Get data
Loads = readtable(LoadsFile, 'HeaderLines',2, 'Format', '%s%f%f%s%f%f%s%f%f%s'); %to take the node where the load is connected
Lines = readtable(linesFile,'HeaderLines',1,'Format','%s%f%f%s%f%s%s'); %to see ti which nodes is a line connected

% format Loads: Name,numPhases,Bus,phases,kV,Model,Connection,kW,PF,Yearly
% format Lines: Name,Bus1,Bus2,Phases,Length,Units,LineCode
% format Voltage: node_name,voltA_mag,voltA_angle,voltB_mag,voltB_angle,voltC_mag,voltC_angle
% format Current: link_name,currA_mag,currA_angle,currB_mag,currB_angle,currC_mag,currC_angle

% Data from Case1
Voltage1p = readtable(VoltageFile1p, 'HeaderLines',2, 'Format', '%s%f%f%f%f%f%f'); %to take the voltage Vbus
Current1p = readtable(CurrentFile1p, 'HeaderLines',2, 'Format', '%s%f%f%f%f%f%f'); %to take currents and then create Ibus

% Data from Case1 3phases
Voltage3p = readtable(VoltageFile3p, 'HeaderLines',2, 'Format', '%s%f%f%f%f%f%f'); %to take the voltage Vbus
Current3p = readtable(CurrentFile3p, 'HeaderLines',2, 'Format', '%s%f%f%f%f%f%f'); %to take currents and then create Ibus

%% Create vectors of base data

Load_bus = table2array(Loads(:,3)); %take bus number of the loads
Lines_end_bus = table2array(Lines(:,3)); %take the bus towards the line goes

%% Create vectors in rectangulars
%take all currents/voltages on lines with voltage level 4.16 kV
%% Case 1, 1 phase
CurrentA_ang= table2array(Current1p(2:size(Current1p,1),3)); %gridlab-d give it in radians
CurrentA_mag= table2array(Current1p(2:size(Current1p,1),2));
[CurrentReA,CurrentImA]= pol2cart(CurrentA_ang,CurrentA_mag); % pol2cart uses angles in radians too
Current_rectA=CurrentReA+(CurrentImA*j);
%length(Current_rect)-length(Lines_end_bus)%=0  confirmate same size
VoltageA_ang= table2array(Voltage1p(2:size(Voltage1p,1),3));
VoltageA_mag= table2array(Voltage1p(2:size(Voltage1p,1),2));
[VoltageReA,VoltageImA]= pol2cart(VoltageA_ang,VoltageA_mag); % pol2cart uses angles in radians too
Voltage_rectA=VoltageReA+(VoltageImA*j);

%% Case 1, 3 phases
Current3p_ang= table2array(Current3p(2:size(Current3p,1),3)); %gridlab-d give it in radians
Current3p_mag= table2array(Current3p(2:size(Current3p,1),2));
[CurrentRe3p,CurrentIm3p]= pol2cart(Current3p_ang,Current3p_mag); % pol2cart uses angles in radians too
Current_rect3p=CurrentRe3p+(CurrentIm3p*j);
Voltage3p_ang= table2array(Voltage3p(2:size(Voltage3p,1),3));
Voltage3p_mag= table2array(Voltage3p(2:size(Voltage3p,1),2));
[VoltageRe3p,VoltageIm3p]= pol2cart(Voltage3p_ang,Voltage3p_mag); % pol2cart uses angles in radians too
Voltage_rect3p=VoltageRe3p+(VoltageIm3p*j);

%% Create Vbus 

VbusA=Voltage_rectA; %Vbus for case1 with one phase (phase A)
Vbus3p=Voltage_rect3p; %Vbus for case1 with 3 phases

%% Create Ibus
% Lines_end_bus has direct relation of componentes with Current_rectA
% select the correct currents to fulfill the Ibus vector
%% Case 1, 1 phase
IbusA=zeros(length(Current_rectA),1);
 for i=1:length(Load_bus)
     for j=1:length(Lines_end_bus)
         if(Load_bus(i)==Lines_end_bus(j))
             IbusA=-(Current_rectA); %take the negative for the load
         else
             IbusA=0;
         end
     end
 end
 IbusA(1)=Current_rectA(1); %take the positive for the source
%% Case 1, 3 phases
Ibus3p=zeros(length(Current_rect3p),1);
 for i=1:length(Load_bus)
     for j=1:length(Lines_end_bus)
         if(Load_bus(i)==Lines_end_bus(j))
             Ibus3p=-(Current_rect3p); %take the negative for the load
         else
             Ibus3p=0;
         end
     end
 end
 Ibus3p(1)=Current_rect3p(1); %take the positive for the source
%% Display Ibus and Vbus in rectangulars

[VbusA;Vbus3p;IbusA;Ibus3p]




