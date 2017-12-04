%% Main-skeleton
clearvars;
close all;

%Problem Parameters
gridLength = 100;
initialNbrOfAgents = 1000;
diffusionRate = 0.4;
growthRate = ones(gridLength) .* 0.05;
hungerRate = 0.1;
collectionRate = growthRate;

percentBestLand = 0.01;
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

%Misc setting


%% Run simulation
landscape = InitializeGrid(gridLength, percentBestLand, maxResourceLevel, diffusionSteps);
growthRate = InitializeGrid(gridLength, percentBestLand, maxResourceLevel, diffusionSteps);
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
  
  [landscape, inventory] = Collect(landscape, inventory, positions, hunger, collectionRate);
  %[hunger, inventory] = EatResources(hunger, inventory, hungerRate);
  %[positions, inventory, hunger] = KillAgents(positions, inventory, hunger);
  
  positions = UpdatePositions(positions, landscape, diffusionRate);
  
%   smoothRate = 0.05;
%    growthRate = imfilter(growthRate, [
%      0, 1, 0;
%      1, 2, 1;
%      0, 1, 0
%    ] ./ 6, 'circular');
  %growthRate = growthRate + 0.000001;
  collectionRate = 1.2*growthRate;
  landscape = GrowResources(landscape, growthRate);
  landscape = landscape + rand(gridLength)*0.000001;

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










