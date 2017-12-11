function positions = UpdatePositions2(positions, grid)

  nbrOfAgents = size(positions, 1);
  gridLength = size(grid, 1);
  neighbors = [
     0 -1;
     0 +1;
    -1  0;
    +1  0;
];
  
  diffusionRate = zeros(nbrOfAgents, 1);
  for i = 1:nbrOfAgents
    diffusionRate(i) = grid(positions(i,1), positions(i,1));
  end
  
  willMove = rand(nbrOfAgents, 1) < diffusionRate;
  
  tempPositions = positions;
  for iAgent=1:nbrOfAgents
      if willMove(iAgent)
          neighborsPos = positions(iAgent,:) + neighbors;
          neighborsPos = mod(neighborsPos - 1, gridLength) + 1;
          neighborIndex = ceil(4*rand);
          tempPositions(iAgent,:) = neighborsPos(neighborIndex,:);
      end
  end

  positions = tempPositions;

end