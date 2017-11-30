function grid = GrowResources(grid, resourceGrowthRate)
    grid = grid + resourceGrowthRate .* grid .* (1 - grid);
end
