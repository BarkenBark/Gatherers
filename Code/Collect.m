function [grid, inventory] = Collect(grid, inventory, positions, hunger, collectionRate)
  %Currently returns the harvested grid, but should also return the
  %collected resources for the agents. 
  
nbrOfAgents = size(positions, 1);

gridLength = size(grid, 1);
%collection = zeros(nbrOfAgents, 1);
for i = 1:nbrOfAgents
  xPos = positions(i,1);
  yPos = positions(i,2);
  newVal = collectionRate(xPos,yPos) * grid(xPos,yPos) * (1 - grid(xPos,yPos)); % maximum sustainable yield
  %collection(i) = grid(xPos,yPos) - newVal;
  grid(xPos,yPos) = newVal;
end

%inventory = inventory + collection;
    
end