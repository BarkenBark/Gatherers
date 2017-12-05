function [positions, inventory] = EatResources(inventory, positions, hungerRate)
%The hungrier an agent is, the more it should eat regardless of inventory

  inventory = inventory - hungerRate;
  
  %Kill agents
  positions((inventory<=0),:) = [];
  inventory(inventory<=0) = [];

end