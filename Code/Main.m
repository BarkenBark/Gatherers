%% Main-skeleton
clearvars;
close all;

%Problem Parameters
gridLength = 100;
nbrOfAgents = 1000;
diffusionRate = 0.3;
growthRate = 1.25;

percentBestLand = 0.25;
maxResourceLevel = 1;
diffusionSteps = 10;

%Interface
figureSize = 800;
titleString = 'Landscape';
agentColor = [1 0 0];

%Misc setting




%% Run simulation
landscape = InitializeGrid(gridLength, percentBestLand, maxResourceLevel, diffusionSteps);
[positions] = InitializeAgents(nbrOfAgents, gridLength);

[figureHandle, titleHandle] = InitializeFigure(figureSize, titleString);
landscapeHandle = PlotLandscape(landscape);
agentsHandle = PlotAgents(positions, agentColor);
uistack(agentsHandle, 'top')

isSimulationRunning = true;
while isSimulationRunning
  landscape = Collect(landscape, positions);
  landscape = GrowResources(landscape, growthRate);
  positions = UpdatePositions(nbrOfAgents, positions, gridLength, diffusionRate);
  
  landscapeHandle = PlotLandscape(landscape, landscapeHandle);
  agentsHandle = PlotAgents(positions, agentColor, agentsHandle);
end










