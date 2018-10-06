include("DistanceMatrix.jl")

function filter_T(T, L)
    T2 = copy(T)
    for i in T
        for j in i
#             if (j == node)
            if(!any(x->x==j, L)) #if (list[i] !contains j)
                filter!(x -> x!=i,T2)
            end
        end
    end
    return T2
end

function operateDistMatrix(mat)
    aList=mat
    global distMatrix =  copy(aList)
    for i=1:length(mat[:,1])
        visited=[]
        depth=0
        distFunc(mat, i, i,visited,depth)
    end
    return distMatrix
end

#  Floyd Warshall Test with real data
function floydWarshall(dists)  # graph is 4x4
#     println("dists in floyd",dists)
    n = Int64(sqrt(length(dists)))
    for k = 1 : n, i = 1 : n, j = 1 : n
        dists[i, j] = min(dists[i, k] + dists[k, j],dists[i,j])
    end
#     println("final Dists",dists)
    return (dists)
end

#TODO:  Keep track of the leaf nodes. This algorithm only works for 4 leaf nodes. So remove 5 from Dense to make it work
function checkConsistency(floydWarshall,L,T)
   # Given Floyd warshall matrix and adjacency matrix
   #Given Triplets
    T=filter_T(T, L)
#     T= [[1,2,3], [1,2,4], [2,3,4], [3,4,2], [1,3,4], [3,4,1], [2,1,3]]
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


function oneHybridLeaf(SNs)
#     SNs =[[3], [1,2], [4]]
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

    alphas =[a1,a2,a3]
    for i=1:3

#         println("iteration number",i)
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

#         println("adjlist step 1",adjListR)

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
        
#         println("adjListR final ==",adjListR)

        arrOfDicts[i]=adjListR
    end
    return arrOfDicts
end

function zerosMatrix(size)
    array = zeros(Int64,size)
    container = Array{Int64}[]
    for i=1:size
        push!(container,array)
    end
    return container
end

# takes positive list after parsing and converts it to adjacency matrix
function listToMatrix(list)
    matrix = Array{Int64}(length(list),length(list))
    fill!(matrix,0)
    for i =1:length(list),j=1:length(list)
        if(any(x->x==j, list[i])) #if (list[i] contains j)
            matrix[i,j] =1
        end
     end
    return matrix
end

# Makes the negative nodes positive in the list
function parseAdjList(SNs, adjLists2)
#     println("received adjlist from onehybrid leaf", adjLists2)

    adjListCopy = deepcopy(adjLists2)
    testDictionary = Dict(zip([1], [[1]]))
    updatedLists = fill!(Array{Dict{Int64,Array}}(3), testDictionary)

    index=1
    consistentAdjList=[]
    for list in adjListCopy
        copyCurrentList = copy(list)
        updatedList = Dict{Int64,Array}()
        for i in list
            a = collect(keys(list))
            max= maximum(a)

            b = collect(values(list))
            conversion = Dict{Int64,Int64}()

            for (key, values) in list
                if(key<0)
                    temp = key
                    key*=-1 #Converting negative to positive value 
                    key+=max  
                    conversion[key]=temp
                end
                for i=1:length(values)
                    if(values[i]<0)
                        values[i]*=-1
                        values[i]+=max
                    end
                end
                updatedList[key] = values
            end
        end
        updatedLists[index] = updatedList
        index=index+1
    end
    return updatedLists
end

# iterate through updated list (parsed) list and find the consistent adjList
function returnConsistentAdjList(adjLists,SNs, L, T)
    adjLists_copy= deepcopy(adjLists)
    consistentAdjList=[]
    updatedLists = parseAdjList(SNs, adjLists_copy)
    # println("adjLists",adjLists_copy)
    index=1
    for updatedList in updatedLists
        matrix= listToMatrix(updatedList)
        matrix2= operateDistMatrix(matrix)
        floyd= floydWarshall(matrix2)
        if(checkConsistency(floyd,L,T) == true)
            consistentAdjList= adjLists[index]
#             println()
#             println("consistentAdjList",consistentAdjList)
        end
        index+=1
    end
    return consistentAdjList
end

function mainOneHybrid(SNs)
    initialAdjList = oneHybridLeaf(SNs)
    L=[1,2,3,4]
   T = [[1,2,3], [1,2,4], [1,2,5], [2,3,4], [2,3,5], [4,5,3], [1,3,4], [1,3,5],
        [4,5,1], [4,5,2], [3,4,1], [3,5,1], [3,4,2], [3,5,2]]
    returnConsistentAdjList(initialAdjList, SNs,L,T)
end

# SNs_test = [[1,2],[3], [4]]
# SNs_test = [[1,2], [4], [3]]
# SNs_test = [[3], [1,2], [4]]
# SNs_test = [[3], [4], [1,2]]
# Failing Test Cases
# SNs_test = [[4], [3],[1,2]]
SNs_test = [[4,5], [1,2],[3]]


mainOneHybrid(SNs_test)