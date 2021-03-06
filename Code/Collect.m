function [grid, inventory] = Collect(grid, inventory, positions,collectionRate)
  %Currently returns the harvested grid, but should also return the
  %collected resources for the agents. 
  
nbrOfAgents = size(positions, 1);

gridLength = size(grid, 1);
collection = zeros(nbrOfAgents, 1);
for i = 1:nbrOfAgents
  xPos = positions(i,1);
  yPos = positions(i,2);
  amount = collectionRate * grid(xPos,yPos) * (1 - grid(xPos,yPos)/2); % maximum sustainable yield
  collection(i) = amount;
  grid(xPos,yPos) = grid(xPos,yPos) - amount;
end

inventory = inventory + collection;
    
end