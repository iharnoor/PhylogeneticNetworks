include("DistanceMatrix.jl")

function parseAdjList2(adjList)
        updatedList = Dict{Int64,Array}()
        for i in adjList
            a = collect(keys(adjList))
            max= maximum(a)*2+1
    
            b = collect(values(adjList))
            conversion = Dict{Int64,Int64}()
            
            for (key, values) in adjList
                if(key<0)
                    temp = key
                    key+=max
                    conversion[key]=temp
                end
                for i=1:length(values)
                    if(values[i]<0)
                        values[i]+=max
                    end
                end
                updatedList[key] = values
            end
        end
    return updatedList
end

function operateDistMatrix(mat)
# Make the Set method to work 1st August
#     setAdjacencyList(aList)
    aList=mat
    global distMatrix =  copy(aList)
#     setAdjacencyList(aList)
#     println("naman Input Matrix = ",distMatrix)
    
    for i=1:length(mat[:,1])
        visited=[]
        depth=0
        distFunc(mat, i, i,visited,depth)
    end
    
#     println("naman Output Matrix = ",returnDistanceMatrix())
    return distMatrix
end
        
#  Floyd Warshall Test with real data
function floydWarshall(dists)  # graph is 4x4
    n = 8
    for k = 1 : n, i = 1 : n, j = 1 : n
        dists[i, j] = min(dists[i, k] + dists[k, j],dists[i,j])
    end
    return (dists)
end

#TODO:  Keep track of the leaf nodes. This algorithm only works for 4 leaf nodes. So remove 5 from Dense to make it work
function checkConsistency(floydWarshall)
   # Given Floyd warshall matrix and adjacency matrix
   #Given Triplets
    T= [[1,2,3], [1,2,4], [2,3,4], [3,4,2], [1,3,4], [3,4,1], [2,1,3]]
    #-1 -2 -3 -4 1234 +9 = 1234 5678
    # we need to know 1234 are the positive nodes.
    # check distance of 12, 23, 13 in the floyd warshall and similarly 12 24 14
    consistent = true
    for i in T
            if(floydWarshall[i[1],i[2]]  >= floydWarshall[i[1],i[3]]  && floydWarshall[i[1],i[2]]  >= floydWarshall[i[2],i[3]])
#                     println("Failed case: ", i[1], i[2], i[3])
#                     println("floyd result:", floydWarshall[i[1],i[2]], floydWarshall[i[1],i[3]], floydWarshall[i[2],i[3]])
                    consistent = false
                    break
            end
    end 
#     println("Consistent=",consistent)
    return consistent 
end

function removeEdge(dictionary, key, value)
    for i in value
        if(haskey(dictionary,key))
            # append!(dictionary[key],value)
            filter!(x -> x!=i,dictionary[key])
            # if(dictionary[key]== Int64[])
            #  delete!(dictionary,key)
            # end
        end
        if(haskey(dictionary,i))
            # append!(dictionary[key],value)
            filter!(x -> x!=key,dictionary[i])
            # if(dictionary[value]== Int64[])
            #     delete!(dictionary,value)
            # end
        end
    end
    # filter!(x -> x!=value,dictionary[key]) # Removing a value
#     print(dictionary)
end
function addVertex(dictionary, key, value)
    for i in value
        if(haskey(dictionary,key))
            append!(dictionary[key],i) # Appending a value
        else
            dictionary[key]=[i]
        end
        if(haskey(dictionary,i))
            append!(dictionary[i],key) # Appending a value
        else
            dictionary[i]=[key] # Appending a value
        end
    end
end


function oneHybridLeaf()
    SNs =[[1,2],[3],[4]]
    a1= SNs[1]
    a2= SNs[2]
    a3= SNs[3]
    ds=[]
    p=[]
    q=[]
    h=[]

#     if 1 and 3 or 2 and 3 are connected then it is consistent.
#     let a1 be c and r = addEdge(a2,a3)
    c=a1
    u=a2
    v=a3
    
    testDictionary = Dict(zip([1], [[1]]))

    arrOfDicts = fill!(Array{Dict{Int64,Array}}(3), testDictionary)

#     println("array of Dicts= ", arrOfDicts)
    
    alphas =[a1,a2,a3]
    for i=1:3
        c=alphas[i]
        if(i==1)
            u=alphas[i+1]
            v=alphas[i+2]
        elseif(i==2)
            u=alphas[i-1]
            v=alphas[i+1]
        else
            u=alphas[i-2]
            v=alphas[i-1]
        end
        adjListR=Dict{Int64,Array}()
        internalVertex = -1
        v0=internalVertex
        addVertex(adjListR,v0,u) #3=>-1 and -1=>3,4 and 4=>-1 
        addVertex(adjListR,v0,v) #3=>-1 and -1=>3,4 and 4=>-1 

        internalVertex -= 1
        p=internalVertex
        internalVertex -= 1
        q=internalVertex
        internalVertex -= 1
        h=internalVertex

    #     (p,u), (p,h), (q,v),(q,h)
        addVertex(adjListR,p,u)
        addVertex(adjListR,p,[h])
        addVertex(adjListR,q,v)
        addVertex(adjListR,q,[h])
        addVertex(adjListR,h,c)

        addVertex(adjListR,v0,[p])
        addVertex(adjListR,v0,[q])
        removeEdge(adjListR,v0,u)
        removeEdge(adjListR,v0,v)
        
#         println("adjListR==",adjListR) 
#         append!(adjLists,adjListR)
        arrOfDicts[i]=adjListR
#         return adjListR
    end
    return arrOfDicts
end
# oneHybridLeaf()

function zerosMatrix(size)
    array = zeros(Int64,size)
    container = Array{Int64}[]
    for i=1:size
        push!(container,array)
    end 
    return container
end

function listToMatrix(list)
    matrix = Array{Int64}(length(list),length(list))
    fill!(matrix,0)
#     println("length of list: ", length(list))
#     println("listToMatrix == ",matrix)
    for i =1:length(list),j=1:length(list)
        if(any(x->x==j, list[i])) #if (list[i] conatins j)
            matrix[i,j] =1
        end
     end
    return matrix
end

function parseAdjList()
    adjLists=oneHybridLeaf()
#     println("--------------------------")
#     println("received adjlist from onehybrid leaf", adjLists)
#     println("--------------------------")
    # Todo split parse AdjlIst
    
    testDictionary = Dict(zip([1], [[1]]))
    updatedLists = fill!(Array{Dict{Int64,Array}}(3), testDictionary)
#     for i = 1:length(updatedLists)
#         println("initial values of adjList", updatedLists[i])
#     end
    
#     println("indexing", updatedLists[1])
    
    index=1
    consistentAdjList=[]
    for list in adjLists
        copyCurrentList = copy(list)
#         println("--")
#         print("adjList123=",list)
        updatedList = Dict{Int64,Array}()
#         matrix = listToMatrix(list)
        for i in list
            a = collect(keys(list))
            max= maximum(a)*2+1
    
            b = collect(values(list))
            conversion = Dict{Int64,Int64}()
            
            for (key, values) in list
                if(key<0)
                    temp = key
                    key+=max
                    conversion[key]=temp
                end
                for i=1:length(values)
                    if(values[i]<0)
                        values[i]+=max
                    end
                end
#                 println(key, " ==> ", values)
                updatedList[key] = values
            end
        #     println("convertedDict=",conversion)
        #     println("updatedList=",updatedList)
#             println("---------------------")
        #      sort(collect(updatedList), by=x->x[2])
        #     maxOfKeys = maximum(keys(updatedList))
        end
#         print("\n-----")
#         print("updatedList:= ",updatedList)
#         println("-----")
        
        updatedLists[index] = updatedList
        index=index+1
#         println("updatedList of lists=: ",updatedLists)
    end
    
#     println(adjLists)
#     println("Make Distance Matrices")
#     matrix = listToMatrix(updatedList)
#     println("AdjacencyMatrix = ",matrix)
#     distanceMatrix = operateDistMatrix(matrix)
# #     floydWarshall =  floydWarshall(matrix)
#     println("distance matrix = ", distanceMatrix)
#     println("updatedLists",updatedLists)
    return updatedLists
end


function returnConsistentAdjList(adjLists)
    consistentAdjList=[]
    updatedLists = parseAdjList()
    index=1
    for updatedList in updatedLists
#         println("updated List == ",updatedList)
        matrix= listToMatrix(updatedList)
#         println("Matrix1: ", matrix)
        matrix2= operateDistMatrix(matrix)
#         println("Matrix2: ", matrix2)
        floyd= floydWarshall(matrix2)
#         println("Floyd",floyd)
#         print("convert to matrix",matrix)
        if(checkConsistency(floyd) == true)
            consistentAdjList= adjLists[index]
#             println("current List = ",list)
#             println("consistentAdjList",consistentAdjList)
        end
        index+=1
    end
    
    return consistentAdjList
end

function mainOneHybrid()
    initialAdjList = oneHybridLeaf()
    returnConsistentAdjList(initialAdjList)    
end

# mainOneHybrid()