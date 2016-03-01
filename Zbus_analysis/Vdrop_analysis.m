%This script visualizes the grid
clear all
%% VAriables
ForPaper = 0; % (1) plots for paper (0) plots not for paper
Details = 1;   % (1) for line and node definitions  




%% Define files to read
linesFile='IEEE_files/European_LV_CSV/Lines.csv';
lineCodeFile= 'IEEE_files/European_LV_CSV/LineCodes.csv';
BuscoordsFile='IEEE_files/European_LV_CSV/Buscoords-.csv';

LoadsFile= 'IEEE_files/European_LV_CSV/Loads.csv';
LoadShapesFile= 'IEEE_files/European_LV_CSV/LoadShapes.csv';
%% Get data
Lines = readtable(linesFile,'HeaderLines',1,'Format','%s%f%f%s%f%s%s');
LineCodes = readtable (lineCodeFile, 'HeaderLines',1,'Format','%s%u%f%f%f%f%f%f%s');
Buscoords = readtable(BuscoordsFile, 'HeaderLines',1,'Format', '%f%f%f');
Loads = readtable(LoadsFile, 'HeaderLines',2, 'Format', '%s%f%f%s%f%f%s%f%f%s');
LoadShapes= readtable(LoadShapesFile, 'HeaderLines',1, 'Format', '%s%f%f%s%s');

%Add Ampacity to lines
Ampacity= [56    80    83   110   210   305   210   405   560   180]'; % From similar cables in Power Factory
CableNamesPF={ 'NYY 4x6   1.00 kV';... % Cable names in Power Factory
    'PVC-SWA-AL 3x25   1.00 kV';...
    'PVC-SWA-CU 3x16   1.00 kV';...
    'PILC-AL 3x35  11.00 kV';...
    'PILC-AL 1x70   1.00 kV';...
    'PILC-AL 1x120   1.00 kV';...
    'PILC-AL 1x300   1.00 kV';...
    'PILC-AL 1x185   1.00 kV';...
    'PILC-AL 1x70   1.00 kV'
    'PILC-CU 3x50   1.00 kV'};
LineCodes=[LineCodes table(Ampacity,CableNamesPF)];


% put information of lines together
LineCodes.Properties.VariableNames{'Name'} = 'LineCode';
T = table([1:size(LineCodes,1)]','VariableNames',{'LineCodeIndex'});
LineCodes = [LineCodes T];
Lines = join(Lines, LineCodes,'key','LineCode');

% Deifine information of loads
Loads.Properties.VariableNames{'Bus'}='Busname';
Loads = join( Loads, Buscoords,'key', 'Busname' ) ;  

%% Regularize IEEE European LV Test Feeder data for EVNUM

%Edges start and terminal
s = Lines{:,2};
t = Lines{:,3};

%node labels
nLabels = Buscoords{:,'Busname'}';
eLabels = Lines{:,'Name'};
weigths = Lines{:,'Length'};% .* 1e-3 .*  complex(Lines{:,'R1'}, Lines{:,'X1'});   %tranform length to [km]

G1=graph(s,t,weigths);
max_distance= max(max(distances(G1)));
L=max_distance/1000; %to put it in km
R=table2array(LineCodes(:,3));
X=table2array(LineCodes(:,4));

Vnom=230;
max_Vdrop=Vnom-(Vnom*0.9);
FP=0.95;
N=55;
e=((N+1)/(2*N));
FPs=sin(acos(FP));

Imax=max_Vdrop./(sqrt(3)*e*((R.*FP)+(X.*FPs))*L);

wirecodes=LineCodes{:,1};
[bestwire,ind]=max(Imax);

In=bestwire;
Vdrop=sqrt(3)*e*((R.*FP)+(X.*FPs))*L*In;

disp=table(wirecodes,Vdrop,Imax);
display(disp)
display(wirecodes(ind))
display(bestwire)
display(max_Vdrop)


