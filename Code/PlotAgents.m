function agentsHandle = PlotAgents(positions, agentsHandle)
  %First time, call function without second argument to create new handle

  if ~exist('agentsHandle', 'var')
    agentsHandle = scatter(positions(:,1), positions(:,2), ...
      'MarkerFaceColor', agentColor);
  else
    set(agentsHandle, 'XData', positions(:,1), 'YData', position(:,2));
  end

end