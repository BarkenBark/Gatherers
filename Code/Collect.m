function [grid, inventory] = Collect(grid, inventory, positions, hunger, collectionRate)
  %Currently returns the harvested grid, but should also return the
  %collected resources for the agents. 
  
nbrOfAgents = size(positions, 1);

gridLength = size(grid, 1);
newGrid = zeros(gridLength);
collection = zeros(nbrOfAgents, 1);
for i = nbrOfAgents
  xPos = positions(i,1);
  yPos = positions(i,2);
  newGrid(xPos,yPos) = collectionRate.* grid(xPos,yPos) .* (1 - grid(xPos,yPos)); % maximum sustainable yield
  collection(i) = grid(xPos,yPos) - newGrid(xPos,yPos);
end

inventory = inventory + collection;

    
end