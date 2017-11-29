function resourceHandle = PlotNbrOfResources(nbrOfResources, resourceHandle)
  %nbrOfResources is a cell vector where each cell contains the nbr
  %of resources at the corresponding cluster in the landscape at all times
  %so far
  
  nbrOfPlots = length(nbrOfResources);
  time = length(nbrOfResources{1}); %Assuming all nbrOfResources are of same length
  
  if ~exist('resourceHandle', 'var')
    resourceHandle = cell(nbrOfPlots,1);
    hold on
    for i = 1:nbrOfPlots
      resourceHandle{i} = plot(1:time, nbrOfResources{i});
      set(resourceHandle{i}, 'LineWidth', 2);
    end
  else
    hold on
    for i = 1:nbrOfPlots
      set(resourceHandle{i}, 'XData', 1:time, 'YData', nbrOfResources{i});
    end
  end
  
end