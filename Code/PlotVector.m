function vectorHandle = PlotVector(vector, color, vectorHandle)
  %First time, call function without second argument to create new handle

  if ~exist('agentsHandle', 'var')
    vectorHandle = plot(vector, 'LineWidth', 2, ...
      'MarkerFaceColor', color, 'MarkerEdgeColor', color);
  else
    t = 1:length(vector);
    t = t(:);
    vector = vector(:);
    set(vectorHandle, 'XData', t, 'YData', vector);
  end
  
end