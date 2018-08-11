include("DistanceMatrix.jl")

function operateDistMatrix(aList)
# Make the Set method to work 1st August
    setAdjacencyList(aList)

    for i=1:length(aList[:,1])
        visited=[]
        depth=0
        distFunc(aList, i, i)
    end

    return (returnDistanceMatrix())
end
        
# aList = [0 0 0 0 1 0 0 0; 0 0 0 0 1 0 0 0; 0 0 0 0 0 0 1 0; 0 0 0 0 0 1 0 0; 1 1 0 0 0 1 1 0; 0 0 0 1 1 0 0 1; 0 0 1 0 1 0 0 1; 0 0 0 0 0 1 1 0]
      
# println(operateDistMatrix(aList))