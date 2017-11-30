function [positions, inventory, hunger] = KillAgents(positions, inventory, hunger)
%Simply drop the rows corresponding to the agents whose hungers are above a
%certain threshold

  nbrOfAgents = size(positions, 1);
  threshold = 0.8;

  toKill = [];
  for i = 1:nbrOfAgents
    if hunger(i) > threshold
      toKill = [toKill, i];
      disp('An agent died');
    end
  end  

  positions(toKill,:) = [];
  inventory(toKill) = [];
  hunger(toKill) = [];
  
end