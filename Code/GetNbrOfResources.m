function nbrOfResources = GetNbrOfResources(grid, nbrOfAreas)
% I dunno what the heck I've done with this function. Feel free to
% completely erase it and start from scratch.
% I guess the idea was to allow for us to monitor resource evolution of
% different subspaces of the landscape.
% Currently returns a cell matrix of nbrOfResources over different areas.


  gridLength = size(grid,1); %Assuming square grid
  areaLength = sqrt(nbrOfAreas);
  if mod(areaLength, 1) ~= 0
    error('Use a cluster number which is a squared integer.');
  elseif mod(gridLength, areaLength) ~= 0
    error('Use a cluster length that gridLength is divisible by.');
  end
  
  nbrOfResources = cell(nbrOfAreas, 1);
  area = mat2cell(grid, repmat(gridLength/areaLength, areaLength, 1), ...
    repmat(gridLength/areaLength, areaLength, 1));
  
  for i = 1:length(area)
    nbrOfResources{i} = sum(sum(area{i}));
  end

end