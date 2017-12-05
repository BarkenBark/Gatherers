function positions = UpdatePositions(positions, grid, diffusionRate, craziness)

numberOfAgents = size(positions,1);
tempPositions = positions;
neighbors = [
     0 -1;
     0 +1;
    -1  0;
    +1  0;
];

nbNeighbors = length(neighbors);
gridLength = length(grid);

moveLikeliness = (1-craziness).*grid + craziness.*rand(gridLength);

neighborsValues = NaN([nbNeighbors 1]);

for iAgent=1:numberOfAgents
    agentPos = positions(iAgent,:);
    willMove = rand() < (diffusionRate * (1-grid(agentPos(1), agentPos(2)))); % TODO could be optimized
    if willMove
        neighborsPos = agentPos + neighbors;
        
        % Apply periodic boundary condition
        neighborsPos = mod(neighborsPos - 1, gridLength) + 1;
        
        for i = 1:nbNeighbors
           neighborsValues(i) = moveLikeliness(neighborsPos(i,1),neighborsPos(i,2)); % TODO could be optimized
        end
        [~, indexMaxValue] = max(neighborsValues); % TODO could be optimized
        tempPositions(iAgent,:) = neighborsPos(indexMaxValue,:);
    end
end

positions = tempPositions;

end
