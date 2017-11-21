function grid = InitializeGrid(gridLength, percentBestLand, maxResourceLevel, diffusionSteps)
    averagingFilterSize = 3;
    
    grid = zeros(gridLength);
    r = rand(gridLength);
    mustSetToMax = r <= percentBestLand;
    grid(mustSetToMax) = maxResourceLevel;
    diffusionFilter = ones(averagingFilterSize) / averagingFilterSize^2;
    for i = 1:diffusionSteps
        grid = imfilter(grid, diffusionFilter, 'circular');
    end
end
