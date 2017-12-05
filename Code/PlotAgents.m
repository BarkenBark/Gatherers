function agentsHandle = PlotAgents(positions, agentColor, agentsHandle)
  %First time, call function without second argument to create new handle

  if ~exist('agentsHandle', 'var')
    agentsHandle = scatter(positions(:,2), positions(:,1), ...
      'MarkerFaceColor', agentColor, 'MarkerEdgeColor', agentColor);
  else
    set(agentsHandle, 'XData', positions(:,2), 'YData', positions(:,1));
  end
  
end