%% Main-skeleton
clearvars;
close all;

%Problem Parameters
gridLength = 100;
initialNbrOfAgents = 4000;
diffusionRate = 0.6;
hungerRate = 0.001;
craziness = 0.05;
collectionGrowthRatio = 1.3;
growthRateResetInterval = 800;
landscapeNoise = 10^(-6);

percentHigherResources = 0.01;
minResourceLevel = 0;
maxResourceLevel = 1;
maxGrowthRate = 1;
diffusionSteps = 15;

%Measures
estimatedTimeSteps = 1000; %To pre-allocate measure-vectors for performance
nbrOfResources = zeros(estimatedTimeSteps, 1);
nbrOfGatherers = zeros(estimatedTimeSteps, 1);

%Interface
figureSize = 800;
landscapeTitleString = 'Landscape';
agentColor = [1 0 0];

%Initial lanscape state
landscape = ones(gridLength) * 0.01 + rand(gridLength)*landscapeNoise;
growthRate = RandomNoisePattern(gridLength, percentHigherResources, maxGrowthRate, diffusionSteps);
collectionRate = collectionGrowthRatio * growthRate;

%% Run simulation
[positions, inventory, hunger] = InitializeAgents(initialNbrOfAgents, gridLength);
%WARNING: stateVector(i,:) should always correspond to the ith agent


[landscapeFigureHandle, landscapeTitleHandle] = InitializeFigure(figureSize, landscapeTitleString);
landscapeHandle = PlotLandscape(landscape);
agentsHandle = PlotAgents(positions, agentColor);
uistack(agentsHandle, 'top')

%[resourceFigureHandle, resourceTitleHandle] = InitializeFigure(figureSize, )

%%

t = 0;
isSimulationRunning = true;
while isSimulationRunning
  t = t+1;
  
  [landscape, inventory] = Collect(landscape, inventory, positions, collectionRate);
  [inventory, positions] = EatResources(inventory, positions, hungerRate);
  
  positions = UpdatePositions(positions, landscape, diffusionRate, craziness);

  if mod(t, growthRateResetInterval) == 0
    disp('growth reset');
    growthRate = RandomNoisePattern(gridLength, percentHigherResources, maxGrowthRate, diffusionSteps);
    collectionRate = collectionGrowthRatio * growthRate;
  end
  
  landscape = GrowResources(landscape, growthRate);
  landscape = landscape + rand(gridLength)*landscapeNoise;
  
  % Apply resource level limits
  landscape = Clamp(landscape, minResourceLevel, maxResourceLevel);
    
  %Measuring
  thisNbrOfResources = GetNbrOfResources(landscape, 1); %Because the function is stupid andreturns a cell instead of double
  nbrOfResources(t) = thisNbrOfResources{1};
  nbrOfGatherers(t) = length(inventory); %Arbitrary choice

  %Plotting
  landscapeHandle = PlotLandscape(landscape, landscapeHandle);
  agentsHandle = PlotAgents(positions, agentColor, agentsHandle);
  uistack(agentsHandle, 'top')
  drawnow
  %isSimulationRunning = false;
  
  %Stopping conditions
  if nbrOfGatherers(t) == 0
    disp('All gatherers are dead')
    isSimulationRunning = false;
  end
  
  %Misc. debugging
  %fprintf('Inventory of agent 1 is: %.4f\n', inventory(1));
  %fprintf('Hunger of agent 1 is: %.2f\n', hunger(1));
  
  
end










