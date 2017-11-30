function positions = UpdatePositions(positions, grid, diffusionRate)

numberOfAgents = size(positions,1);
tempPositions = positions;
neighbors = [
     0 -1;
     0 +1;
    -1  0;
    +1  0;
];
noise=0.99;
nbNeighbors = length(neighbors);
gridLength = length(grid);
willMove = rand(numberOfAgents) < diffusionRate;

for iAgent=1:numberOfAgents
    if willMove(iAgent)
        neighborsPos = positions(iAgent,:) + neighbors;
        
        % Apply periodic boundary condition
        neighborsPos = mod(neighborsPos - 1, gridLength) + 1;
        
        neighborsValues = zeros([nbNeighbors 1]);
        for i = 1:nbNeighbors
           neighborsValues(i) = (1-noise)*grid(neighborsPos(i,1),neighborsPos(i,2))+noise*rand();
        end
        [~, indexMaxValue] = max(neighborsValues);
        tempPositions(iAgent,:) = neighborsPos(indexMaxValue,:);
    end
end

positions = tempPositions;

end
