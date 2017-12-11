function grid = RandomNoisePattern(gridLength, percentHighestValue, maxValue, diffusionSteps, k)
    averagingFilterSize = 3;
    
    grid = zeros(gridLength);
    r = rand(gridLength);
    mustSetToMax = r <= percentHighestValue;
    grid(mustSetToMax) = maxValue;
    diffusionFilter = ones(averagingFilterSize) / averagingFilterSize^2;
    for i = 1:diffusionSteps
        grid = imfilter(grid, diffusionFilter, 'circular');
    end
    
    normalizingFactor = k/sum(sum(grid));
    grid = grid*normalizingFactor;
    
end
