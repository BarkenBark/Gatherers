function grid = InitializeGrid(gridLength, percentBestLand, maxResourceLevel, diffusionSteps, k)
    averagingFilterSize = 3;
    
    grid = zeros(gridLength);
    r = rand(gridLength);
    mustSetToMax = r <= percentBestLand;
    grid(mustSetToMax) = maxResourceLevel;
    diffusionFilter = ones(averagingFilterSize) / averagingFilterSize^2;
    for i = 1:diffusionSteps
        grid = imfilter(grid, diffusionFilter, 'circular');
    end
    
    normalizingFactor = k/sum(sum(grid));
    grid = grid*normalizingFactor;
    
end
