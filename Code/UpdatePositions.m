function positions = UpdatePositions(positions, grid, diffusionRate)

tempPositions=positions;
numberOfAgents = size(positions, 1);

for iAgent=1:numberOfAgents
    if rand<diffusionRate
        step=randi(4);
        if step==1
            tempPositions(iAgent,1)=positions(iAgent,1)+1;
        elseif step==2
            tempPositions(iAgent,2)=positions(iAgent,2)+1;
        elseif step==3
            tempPositions(iAgent,1)=positions(iAgent,1)-1;
        else
            tempPositions(iAgent,2)=positions(iAgent,2)-1;
        end
    end
end

% Apply periodic boundary condition
positions = mod(tempPositions-1, gridLength)+1;

end
