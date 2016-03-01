% Prepare data for EV NUM paper
% author: Jose Rivera (2016)

%% Define files to read
linesFile='IEEE_files/European_LV_CSV/Lines.csv';
lineCodeFile= 'IEEE_files/European_LV_CSV/LineCodes.csv';
BuscoordsFile='IEEE_files/European_LV_CSV/Buscoords-.csv';

LoadsFile= 'IEEE_files/European_LV_CSV/Loads.csv';
LoadShapesFile= 'IEEE_files/European_LV_CSV/LoadShapes.csv';
%% Getting data
Lines = readtable(linesFile,'HeaderLines',1,'Format','%s%f%f%s%f%s%s');
LineCodes = readtable (lineCodeFile, 'HeaderLines',1,'Format','%s%u%f%f%f%f%f%f%s');
Buscoords = readtable(BuscoordsFile, 'HeaderLines',1,'Format', '%f%f%f');
Loads = readtable(LoadsFile, 'HeaderLines',2, 'Format', '%s%f%f%s%f%f%s%f%f%s');
LoadShapes= readtable(LoadShapesFile, 'HeaderLines',1, 'Format', '%s%f%f%s%s');

%% Ordering data
% Add line code information to lines table
LineCodes.Properties.VariableNames{'Name'} = 'LineCode';
Lines = join(Lines, LineCodes,'key','LineCode');

%% Constructing graph 


%%  Constructing Impedance matrix Z

%Define line admittances 
impedances= Lines{:,'Length'} .* 1e-3 .*  complex(Lines{:,'R1'}, Lines{:,'X1'});
admitances= 1./impedances; 
Lines= [Lines table(admitances)];


% create simple grid graph 
s = Lines{:,2};
t = Lines{:,3};
G = graph(s,t);

% Admittance and Impedance matrix - calculatred based on incidence matrix 
I=full( incidence(G));
Bline=diag((Lines.admitances));
Y= I*Bline*I';

% Admittance matrix (Y is singular, add delta to make invertible)
Ynew= Y+ (eye(size(Y))*1e-9);
Z= inv(Ynew);

%% Leonardo Cardona method

EdgeTable = table([s t],Lines{:,'R1'},Lines{:,'X1'},'VariableNames',{'EndNodes' 'R1' 'X1'});
G1 = digraph(EdgeTable);

%plot(G1,'EdgeLabel',G1.Edges.R1)
plot(G)







