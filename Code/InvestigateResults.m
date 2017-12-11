%% PopulationSize investigation

clear all
load('..\Results\Results_1211T1041');
close all


%% Get the averages

cellsize = size(nbrOfGatherersCell); %Same for all cells

meanMeanInventory = GetAveragesOverTests(meanInventoryCell);
meanNbrOfAgents = GetAveragesOverTests(nbrOfGatherersCell);
meanNbrOfResources = GetAveragesOverTests(nbrOfResourcesCell);
  
%% Get final population size as function of initial size

for i = 1:length(meanNbrOfAgents)
  initialN(i) = meanNbrOfAgents{i}(1);
  finalN(i) = meanNbrOfAgents{i}(end);
end

plot(initialN, finalN./initialN)
xlabel('Initial Population Size');
ylabel('Relative Steady State Population Size');
title('Survival rate as function of initial population size')

%%

N1000 = meanNbrOfAgents{10};
N1500 = meanNbrOfAgents{15};
N1200 = meanNbrOfAgents{12};
N500 = meanNbrOfAgents{5};
N900 = meanNbrOfAgents{8};
figure
hold on
time = 1:length(N1000);
plot(time, N1000);
plot(time, N1500);
plot(time, N500);
plot(time, N900); 
plot(time, N1200);
xlim([0 8000])
xlabel('Time', 'FontSize', 14);
ylabel('Population size', 'FontSize', 14)
title('Population size over time for different initial population sizes');
