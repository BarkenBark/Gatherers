function nbrOfResources = GetNbrOfResources(grid, nbrOfClusters)

  clusterLength = sqrt(nbrOfClusters);
  if mod(clusterLength, 1) ~= 0
    error('Use a cluster number which is a squared integer.');
  end
  
  nbrOfResources = cell(nbrOfClusters, 1);
  cluster = mat2cell(grid, ...
    [clusterLength clusterLength],[clusterLength clusterLength]);
  
  for i = 1:length(cluster)
    nbrOfResources{i} = sum(sum(cluster{i}));
  end

end