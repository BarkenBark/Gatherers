function grid = GrowResources(grid, resourceGrowthRate)
    
    %resourceGrowthRate = 1.25; % resourceGrowthRate \in [1,\infty) 
                               % (but large values will create crazy values, try to keep under 3)
    
%     for i=1:size(grid,1)
%        for j = 1:size(grid,2)
%           grid(i,j) = resourceGrowthRate*grid(i,j)*(1-grid(i,j)); 
%        end
%     end

  %grid = grid + eps; %To make sure there can always grow new resources if a space is completely empties
  grid = grid + resourceGrowthRate .* grid .* (1 - grid);
    
end
