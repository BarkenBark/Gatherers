function landscapeHandle = PlotLandscape(landscape, landscapeHandle)
  
  if ~exist('treeScatter', 'var')
    landscapeHandle = imagesc(landscape); 
  else
    set(landscapeHandle, 'CData', landscape);
  end

  drawnow

end