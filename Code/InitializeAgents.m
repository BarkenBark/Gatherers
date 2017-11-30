function [positions, inventory, hunger] = InitializeAgents(nbrOfAgents, gridLength)
  
  positions = randi([1 gridLength], nbrOfAgents, 2);
  hunger = 0.5*ones(nbrOfAgents, 1);
  inventory = zeros(nbrOfAgents, 1);

end