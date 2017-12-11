%% Main-skeleton
clearvars;
close all;

%Problem Parameters
gridLength = 100;
initialNbrOfAgents = 1000;
diffusionRate = 0.4;
growthRate = ones(gridLength) .* 0.05;
consumptionRate = 0.05;
collectionRate = 0.5;

percentBestLand = 0.005;
minResourceLevel = 0;
maxResourceLevel = 1;

diffusionSteps = 20;
eps = 0.01; %Always add this value to all resorces to make sure complete depletion doesn't permanently destroy the field

%Measures
estimatedTimeSteps = 1000; %To pre-allocate measure-vectors for performance
nbrOfResources = zeros(estimatedTimeSteps, 1);
nbrOfGatherers = zeros(estimatedTimeSteps, 1);

%Interface
figureSize = 800;
landscapeTitleString = 'Landscape';
agentColor = [1 0 0];
monitorTitleString = 'Inventory';

%Misc setting


%% Run simulation
landscape = ones(gridLength) .* maxResourceLevel * 0.05;%InitializeGrid(gridLength, percentBestLand, maxResourceLevel, diffusionSteps);
[positions, inventory] = InitializeAgents(initialNbrOfAgents, gridLength);
%WARNING: stateVector(i,:) should always correspond to the ith agent


[landscapeFigureHandle, landscapeTitleHandle] = InitializeFigure(figureSize, landscapeTitleString);
landscapeHandle = PlotLandscape(landscape);
agentsHandle = PlotAgents(positions, agentColor);
uistack(agentsHandle, 'top')

[monitorFigureHandle, monitorTitleHandle] = InitializeFigure(figureSize, monitorTitleString);
monitorHandle = PlotVector(inventory(1), [1 0 0]);
hurr = [];
%%

t = 0;
isSimulationRunning = true;
while isSimulationRunning
  t = t+1;
  
  [landscape, inventory] = Collect(landscape, inventory, positions, collectionRate);
	[positions, inventory] = EatResources(inventory, positions, consumptionRate);
  %[positions, inventory, hunger] = KillAgents(positions, inventory, hunger);
  
  positions = UpdatePositions(positions, landscape, diffusionRate);
  landscape = GrowResources(landscape, growthRate);



    
  %Measuring
  thisNbrOfResources = GetNbrOfResources(landscape, 1); %Because the function is stupid andreturns a cell instead of double
  nbrOfResources(t) = thisNbrOfResources{1};
  nbrOfGatherers(t) = length(inventory); %Arbitrary choice

  %Plotting
  set(0, 'CurrentFigure', landscapeFigureHandle)
  landscapeHandle = PlotLandscape(landscape, landscapeHandle);
  agentsHandle = PlotAgents(positions, agentColor, agentsHandle);
  uistack(agentsHandle, 'top')
  set(0, 'CurrentFigure', monitorFigureHandle)
  hurr = [hurr, inventory(1)];
  monitorHandle = PlotVector(hurr, [1 0 0], monitorHandle);
  drawnow
  %isSimulationRunning = false;
  
  %Stopping conditions
  if nbrOfGatherers(t) == 0
    disp('All gatherers are dead')
    isSimulationRunning = false;
  end
  
%   %Misc. debugging
  fprintf('Inventory of agent 1 is: %.4f\n', inventory(1));
%   fprintf('Hunger of agent 1 is: %.2f\n', hunger(1));



end










