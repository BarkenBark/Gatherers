function landscapeHandle = PlotLandscape(landscape, landscapeHandle)
  %First time, call function without second argument to create new handle

  if ~exist('treeScatter', 'var')
    landscapeHandle = imagesc(landscape); 
  else
    set(landscapeHandle, 'CData', landscape);
  end

  drawnow

end