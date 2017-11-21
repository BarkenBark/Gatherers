function [positions] = InitializeAgents(nbrOfAgents, gridLength)
  
  positions = randi([1 gridLength], nbrOfAgents, 2);

end