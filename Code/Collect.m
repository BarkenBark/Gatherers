function [grid, inventory] = Collect(grid, inventory, positions, hunger, collectionCapPerTimeStep)
    growthRate = 0.1;
    grid(xPos,yPos) = 0.1 .* grid(xPos,yPos) .* (1 - grid(xPos,yPos)); % maximum sustainable yield
end