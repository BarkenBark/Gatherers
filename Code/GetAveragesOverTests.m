function meanCell = GetAveragesOverTests(resultsCell)
%%Assumes resultsCell is a nbrOfRuns x nbrOfTests sized cell matrix
%%containins results of the same dimension.
%%Returns a cell vector of size nbrOfRuns x 1 which containes the averaged
%%results over nbrOfTests runs.


nbrOfRuns = size(resultsCell, 1);
nbrOfTests = size(resultsCell, 2);

meanCell = cell(nbrOfRuns, 1);
resultsSize = size(resultsCell{1,1}); %Assume same size for all results

for iRun = 1:nbrOfRuns
  meanCell{iRun} = zeros(resultsSize);
  for iTest = 1:nbrOfTests
    meanCell{iRun} = meanCell{iRun} + resultsCell{iRun, iTest};
  end
  meanCell{iRun} = meanCell{iRun}/nbrOfTests;
end
end