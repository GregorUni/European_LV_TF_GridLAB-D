clear all
close all

% ****************************************************
% * Initialize OpenDSS
% ****************************************************
% Instantiate the OpenDSS Object
DSSObj = actxserver('OpenDSSEngine.DSS');
% Start up the Solver
if ~DSSObj.Start(0),
 disp('Unable to start the OpenDSS Engine')
 return
end


% Set up the Text, Circuit, and Solution Interfaces to manage ODSS
DSSText = DSSObj.Text;
DSSCircuit = DSSObj.ActiveCircuit;
DSSSolution = DSSCircuit.Solution;


% ****************************************************
% * Examples Using the DSSText Object
% ****************************************************
DSSText.Command = 'Compile "Master.dss"'; 
% Master is the Opendss file with the LVTfeeder
% that file contains no solve command

DSSText.Command = 'set mode=yearly number= 1 stepsize=1m';
%solve the circuit in snap shot mode
DSSText.Command = 'solve mode=snap';
DSSText.Command = 'Set controlmode=time';

DSSSolution.InitSnap;
DSSSolution.dblHour = 0.0;
 
% % Solve the Circuit
present_step = 1;
 while(present_step <= 3) % 3 just to test. Solution is still the same each step, no idea how to correct that
    
     % solve power flow for each time
     DSSSolution.Solve;
     if DSSSolution.Converged,
        disp('The Circuit Solved Successfully')
     end
     
     % export and read voltages
     DSSText.Command = 'Export Voltages';
     Filename = DSSText.Result;
     disp(['File saved to: ' Filename])
     Voltages{:,present_step} = readtable('LVTest_EXP_VOLTAGES.csv'); 
     
     DSSText.Command = 'Export Currents';
     Filename = DSSText.Result;
     disp(['File saved to: ' Filename])
     Currents{:,present_step} = readtable('LVTest_EXP_CURRENTS.csv');

     % Here could be located the loadprofile modification based on the
     % control/optimization
     
 %increment the present step
 present_step = present_step + 1;
 end 



% there's also a way to see the overloads
% DSSText.Command = 'Export Overloads';
% Filename = DSSText.Result;
% disp(['File saved to: ' Filename])
% Overloads = readtable('LVTest_EXP_OVERLOADS.csv');

