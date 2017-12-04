function positions = UpdatePositions(positions, grid, diffusionRate)

numberOfAgents = size(positions,1);
tempPositions = positions;
neighbors = [
     0 -1;
     0 +1;
    -1  0;
    +1  0;
];
noise=0.05;
nbNeighbors = length(neighbors);
gridLength = length(grid);
% willMove = rand(numberOfAgents) < diffusionRate;

moveLikeliness = grid;%imfilter(grid, ones(3^2)./3^2, 'circular');
moveLikeliness = (1-noise).*moveLikeliness + noise.*rand(gridLength);

for iAgent=1:numberOfAgents
    agentPos = positions(iAgent,:);
    willMove = rand() < (diffusionRate * (1-grid(agentPos(1), agentPos(2))));
    if willMove
        neighborsPos = agentPos + neighbors;
        
        % Apply periodic boundary condition
        neighborsPos = mod(neighborsPos - 1, gridLength) + 1;
        
        neighborsValues = zeros([nbNeighbors 1]);
        for i = 1:nbNeighbors
           neighborsValues(i) = moveLikeliness(neighborsPos(i,1),neighborsPos(i,2));%(1-noise)*grid(neighborsPos(i,1),neighborsPos(i,2))+noise*rand();
        end
        [~, indexMaxValue] = max(neighborsValues);
        tempPositions(iAgent,:) = neighborsPos(indexMaxValue,:);
    end
end

positions = tempPositions;

end
