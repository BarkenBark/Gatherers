function [hunger, inventory] = EatResources(hunger, inventory, hungerRate)
%The hungrier an agent is, the more it should eat regardless of inventory

  nbrOfAgents = length(hunger);

  hunger = hunger + hungerRate;
  deltaHunger = -hunger.*inventory;
%   for i = 1:nbrOfAgents
%     if hunger(i) + deltaHunger(i) < 0 
%      deltaHunger(i) = -hunger(i);
%     end
%   end
  

  tmpHunger = hunger + deltaHunger;
  deltaHunger(tmpHunger < 0) = -hunger(tmpHunger<0);
  deltaInventory = deltaHunger;   
  
  hunger = hunger + deltaHunger;
  inventory = inventory + deltaInventory;

end