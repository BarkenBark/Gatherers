%% Main-skeleton
clearvars;
close all;

%Problem Parameters
gridLength = 100;
nbrOfAgents = 1000;
diffusionRate = 0.1;
growthRate = 0.5;
collectionRate = 0.5;
hungerRate = 1; %Value in [0,1], 0 -> collect nothing, 1 -> collect everything 
collectionCapPerTimeStep = 1/100;

percentBestLand = 0.25;
maxResourceLevel = 1;
diffusionSteps = 10;
eps = 0.01; %Always add this value to all resorces to make sure complete depletion doesn't permanently destroy the field

%Measures
estimatedTimeSteps = 1000; %To pre-allocate measure-vectors for performance
nbrOfResources = zeros(estimatedTimeStep, 1);
nbrOfGatherers = zeros(estimatedTimeStep, 1);

%Interface
figureSize = 800;
titleString = 'Landscape';
agentColor = [1 0 0];

%Misc setting


%% Run simulation
landscape = InitializeGrid(gridLength, percentBestLand, maxResourceLevel, diffusionSteps);
[positions, inventory, hunger] = InitializeAgents(nbrOfAgents, gridLength);
%WARNING: stateVector(i,:) should always correspond to the ith agent

[figureHandle, titleHandle] = InitializeFigure(figureSize, titleString);
landscapeHandle = PlotLandscape(landscape);
agentsHandle = PlotAgents(positions, agentColor);
uistack(agentsHandle, 'top')

%%

t = 0;
isSimulationRunning = true;
while isSimulationRunning
  t = t+1;
  
  collectionRate = GetCollectionRate(hunger); %vector
  [landscape, inventory] = Collect(landscape, inventory, positions, collectionRate);
  [hunger, inventory] = EatResources(hunger, inventory);
  [positions, inventory, hunger] = KillAgents(positions, inventory, hunger);
  
  positions = UpdatePositions(nbrOfAgents, positions, gridLength, diffusionRate);
  
  landscape = GrowResources(landscape, growthRate, eps);

  %Measuring
  nbrOfResources(t) = GetNbrOfResources(landcape, 1);
  nbrOfGatherers(t) = length(inventory); %Arbitrary choice
  
  %Plotting
  landscapeHandle = PlotLandscape(landscape, landscapeHandle);
  agentsHandle = PlotAgents(positions, agentColor, agentsHandle);
  uistack(agentsHandle, 'top')
  drawnow
  %isSimulationRunning = false;
end










