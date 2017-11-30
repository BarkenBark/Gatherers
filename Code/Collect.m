function [grid, inventory] = Collect(grid, inventory, positions, hunger, collectionCapPerTimeStep)
  %Currently returns the harvested grid, but should also return the
  %collected resources for the agents. 

    numberOfGatherers = size(positions,1);
    %numberOfGatherers = length(positions); %better, but not secure for case with only one gatherer?
    
    %collectionRate = GetCollectionRate(hunger, inventory); %If we want a more sophisticated way to calculate collectionRate
    collectionRate = hunger;
    collection = collectionRate*collectionCapPerTimeStep;
    
    for i = 1:numberOfGatherers
        xPos = positions(i,1);
        yPos = positions(i,2);
        grid(xPos,yPos) = 0.1 .* grid(xPos,yPos) .* (1 - grid(xPos,yPos));
    end
    
    inventory = inventory + collection;
    
end