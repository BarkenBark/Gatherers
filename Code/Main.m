%% Main-skeleton
clearvars;
close all;

initialNbrOfAgentsVector = round(linspace(100,2000, 10));
nbrOfRuns = length(initialNbrOfAgentsVector);
elapsedTime = tic;
nbrOfTests = 10;

nbrOfResourcesCell = cell(nbrOfRuns, 1);
nbrOfGatherersCell = cell(nbrOfRuns, 1);
meanInventoryCell = cell(nbrOfRuns, 1);

for iTest = 1:nbrOfTests
iRun = 0;
for initialNbrOfAgents = initialNbrOfAgentsVector
clearvars -except initialNbrOfAgentsVector nbrOfRuns elapsedTime iRun initialNbrOfAgents nbrOfResourcesCell nbrOfGatherersCell meanInventoryCell iTest nbrOfTests
close all
iRun = iRun+1;
  
  
%Problem Parameters
gridLength = 100;
craziness = 0.05;
collectionRate= 0.1;
% initialNbrOfAgents = 1000;
diffusionRate = 0.4;
hungerRate = 0.01;
growthRateResetInterval = 1000;
landscapeNoise = 0*10^(-9999);

percentHigherResources = 0.01;
minResourceLevel = 0;
maxResourceLevel = 1;
maxInitialResourceLevel = 0.5;
maxGrowthRate = 1;

k = 100;
heterogenuity = 0.2;
diffusionSteps = 15;

%Measures
estimatedTimeSteps = 10000; %To pre-allocate measure-vectors for performance
nbrOfResources = zeros(estimatedTimeSteps, 1);
nbrOfGatherers = zeros(estimatedTimeSteps, 1);
meanInventory = zeros(estimatedTimeSteps, 1);
% clusteringCoefficient = zeros(estimatedTimeSteps, 1);

%Interface
figureSize = 800;
landscapeTitleString = 'Landscape';
agentColor = [1 0 0];

%Initial lanscape state
growthRate = RandomNoisePattern(gridLength, percentHigherResources, maxGrowthRate, diffusionSteps, k);
landscape = ones(gridLength) * maxInitialResourceLevel + rand(gridLength)*landscapeNoise;

% Run simulation
[positions, inventory, hunger] = InitializeAgents(initialNbrOfAgents, gridLength);
%WARNING: stateVector(i,:) should always correspond to the ith agent


% [landscapeFigureHandle, landscapeTitleHandle] = InitializeFigure(figureSize, landscapeTitleString);
% landscapeHandle = PlotLandscape(landscape);
% agentsHandle = PlotAgents(positions, agentColor);
% uistack(agentsHandle, 'top')
% drawnow

%[resourceFigureHandle, resourceTitleHandle] = InitializeFigure(figureSize, )

%

t = 0;
isSimulationRunning = true;
while t <= estimatedTimeSteps
  t = t+1;
  
  [landscape, inventory] = Collect(landscape, inventory, positions, collectionRate);
  [inventory, positions] = EatResources(inventory, positions, hungerRate);
  
  positions = UpdatePositions(positions, landscape, diffusionRate, craziness);

  if mod(t, growthRateResetInterval) == 0
    growthRate = RandomNoisePattern(gridLength, percentHigherResources, maxGrowthRate, diffusionSteps, k);
  end
  
  landscape = GrowResources(landscape, growthRate);
  landscape = landscape + rand(gridLength)*landscapeNoise;
  
  % Apply resource level limits
  landscape = Clamp(landscape, minResourceLevel, maxResourceLevel);
    
  %Measuring
  thisNbrOfResources = GetNbrOfResources(landscape, 1); %Because the function is stupid andreturns a cell instead of double
%   thisClusteringCoefficient = CalculateAffinity(positions);
  nbrOfResources(t) = thisNbrOfResources{1};
  nbrOfGatherers(t) = length(inventory); %Arbitrary choice
  meanInventory(t) = mean(inventory);
%   clusteringCoefficient(t) = thisClusteringCoefficient;

%   %Plotting
%   landscapeHandle = PlotLandscape(landscape, landscapeHandle);
%   agentsHandle = PlotAgents(positions, agentColor, agentsHandle);
%   uistack(agentsHandle, 'top')
%   drawnow
%   %isSimulationRunning = false;
%   
  %Stopping conditions
%   if nbrOfGatherers(t) == 0
%     disp('All gatherers are dead')
%     isSimulationRunning = false;
%   end
%   
%   if mod(t,100) == 0
%   disp(t)
%   end
  %Misc. debugging
  %fprintf('Inventory of agent 1 is: %.4f\n', inventory(1));
  %fprintf('Hunger of agent 1 is: %.2f\n', hunger(1));
  
  
end
nbrOfResourcesCell{iRun, iTest} = nbrOfResources;
nbrOfGatherersCell{iRun, iTest} = nbrOfGatherers;
meanInventoryCell{iRun, iTest} = meanInventory;


end

fprintf('Test %d of %d completed after %.2f seconds\n', iTest, nbrOfTests, toc(elapsedTime));

end


dateString = datestr(now, 30);
dateString = dateString(1:end-2); %Remove seconds
dateString = dateString(5:end); %Remove year
filepath = strcat('..\Results\Results_', dateString);
save(filepath)







