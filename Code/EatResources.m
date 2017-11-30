function [hunger, inventory] = EatResources(hunger, inventory, hungerRate)
%The hungrier an agent is, the more it should eat regardless of inventory

  hunger = hunger + hungerRate;
  deltaHunger = -inventory;

  tmpHunger = hunger + deltaHunger;
  deltaHunger(tmpHunger < 0) = -hunger(tmpHunger<0);
  deltaInventory = deltaHunger;   
  
  hunger = hunger + deltaHunger;
  inventory = inventory + deltaInventory;

end