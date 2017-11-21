function grid = Collect(grid, positions)
    %numberOfGatherers = size(positions,1);
    numberOfGatherers = length(positions); %better, but not secure for case with only one gatherer?
    
    for i = 1:numberOfGatherers
        xPos = positions(i,1);
        yPos = positions(i,2);
        grid(xPos,yPos) = 0;
    end
    
end