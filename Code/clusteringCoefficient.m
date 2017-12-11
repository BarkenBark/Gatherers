function clusteringCoefficient = clusteringCoefficient(positions,clusteringThreshold,gridLength)
    
    % Calculates the area of the cells for every unique position of the agents. 
    % If there are more than one agent in the same position, the area of the 
    % corresponding cell is divided by the number of agents at that
    % position.
    areaOfCells = SquareBV(positions(:,1),positions(:,2),0,[0 gridLength+1 0 gridLength+1]); 
    
    nbrOfAgentsInACluster = nnz(areaOfCells < clusteringThreshold);
    nbrOfUniqueAgentsInCluster = length(areaOfCells);
    
    clusteringCoefficient = nbrOfAgentsInACluster/nbrOfUniqueAgentsInCluster;

end



