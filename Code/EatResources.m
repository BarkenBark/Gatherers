function [hunger, inventory] = EatResources(hunger, inventory, hungerRate)
%The hungrier an agent is, the more it should eat regardless of inventory

  hunger = hunger + hungerRate;
  deltaHunger = -hunger.*inventory;
  if hunger + deltaHunger < 0 
    deltaHunger = -hunger;
  end
  deltaInventory = deltaHunger; 
  
  hunger = hunger + deltaHunger;
  inventory = inventory + deltaInventory;

end