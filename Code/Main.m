%% Main-skeleton

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
agentColor = 'red';

%Misc setting




%% Run simulation
landscape = InitializeGrid(gridLength, percentBestLand, maxResourceLevel, diffusionSteps);
[positions] = InitializeAgents(nbrOfAgents, gridLength);

[figureHandle, titleHandle] = InitializeFigure(figureSize, titleString);
landscapeHandle = PlotLandscape(landscape);
agentsHandle = PlotAgents(positions, agentColor);

isSimulationRunning = true;
while isSimulationRunning
  landscape = Collect(landscape, positions);
  landscape = GrowResources(landscape, growthRate);
  positions = UpdatePositions(nbrOfAgents, positions, landscape, diffusionRate);
  
  landscapeHandle = PlotLandscape(landscape, landscapeHandle);
  agentsHandle = PlotAgents(positions, agentsHandle);
end










