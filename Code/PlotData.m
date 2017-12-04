function dataHandle = PlotData(state, dataHandle)
  %First time, call function without second argument to create new handle
  t = length(state);
  if ~exist('dataHandle', 'var')
    dataHandle = plot(1:t, state);
  else
    set(dataHandle, 'XData', 1:t, 'YData', state);
  end
  
end