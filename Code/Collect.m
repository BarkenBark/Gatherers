function [grid, inventory] = Collect(grid, inventory, positions, collectionRate, collectionCapPerTimeStep)
  %Currently returns the harvested grid, but should also return the
  %collected resources for the agents. 

    %numberOfGatherers = size(positions,1);
    numberOfGatherers = length(positions); %better, but not secure for case with only one gatherer?
    
    collection = collectionRate*collectionCapPerTimeStep;
    
    for i = 1:numberOfGatherers
        xPos = positions(i,1);
        yPos = positions(i,2);
        grid(xPos,yPos) = grid(xPos,yPos) - collection;
        %grid(xPos,yPos) = grid(xPos,yPos) * collectionRate; %Depends on
        %how we want to define it
        grid(grid<0) = 0; %Apply safety thingy to make sure there can't be negative resources on a cell
        %Could make our lives difficult when we integrate with agents
        %actually collecting resources
    end
    
end