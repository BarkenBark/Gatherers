%% Main-skeleton
clearvars;
close all;

varyingParameterVector = round(linspace(100,2000, 10));
nbrOfRuns = length(varyingParameterVector);
elapsedTime = tic;
nbrOfTests = 10;
showPlot = false;

nbrOfResourcesCell = cell(nbrOfRuns, 1);
nbrOfGatherersCell = cell(nbrOfRuns, 1);
meanInventoryCell = cell(nbrOfRuns, 1);

for iTest = 1:nbrOfTests
	iRun = 0;
	for varyingParameterValue = varyingParameterVector
		clearvars -except showPlot isSimulationRunning varyingParameterVector nbrOfRuns elapsedTime iRun varyingParameterValue nbrOfResourcesCell nbrOfGatherersCell meanInventoryCell iTest nbrOfTests
		close all
		iRun = iRun+1;

		%Problem Parameters
		gridLength = 100;
		craziness = 0.05;
		collectionRate= 0.1;
		initialNbrOfAgents = varyingParameterValue;
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
		estimatedTimeSteps = 50; %To pre-allocate measure-vectors for performance
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
		[positions, inventory, hunger] = InitializeAgents(varyingParameterValue, gridLength);
		%WARNING: stateVector(i,:) should always correspond to the ith agent

		if showPlot
			[landscapeFigureHandle, landscapeTitleHandle] = InitializeFigure(figureSize, landscapeTitleString);
			landscapeHandle = PlotLandscape(landscape);
			agentsHandle = PlotAgents(positions, agentColor);
			uistack(agentsHandle, 'top')
			drawnow
		end
		
		t = 0;
		isSimulationRunning = true;
		while isSimulationRunning
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

			if showPlot
				landscapeHandle = PlotLandscape(landscape, landscapeHandle);
				agentsHandle = PlotAgents(positions, agentColor, agentsHandle);
				uistack(agentsHandle, 'top')
				drawnow
			end

			%Stopping conditions
			isSimulationRunning = t <= estimatedTimeSteps;
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







