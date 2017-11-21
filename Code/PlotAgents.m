function agentsHandle = PlotAgents(positions, agentColor, agentsHandle)
  %First time, call function without second argument to create new handle

  if ~exist('agentsHandle', 'var')
    agentsHandle = scatter(positions(:,1), positions(:,2), ...
      'MarkerFaceColor', agentColor, 'MarkerEdgeColor', agentColor);
  else
    set(agentsHandle, 'XData', positions(:,1), 'YData', positions(:,2));
  end
  
end