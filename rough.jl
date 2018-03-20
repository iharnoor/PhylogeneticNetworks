# using DataStructures
T= [[1,2,3], [1,2,4], [1,2,5], [2,3,4], [3,4,2], [2,3,5], [3,4,5], [1,3,4],
[3,4,1], [1,3,5], [1,4,5], [2,4,5],[2,1,3]]
# L= [1,2,3,4,5]
SNs =[[1,2],[3],[4]]
a1= SNs[1]
a2= SNs[2]
a3= SNs[3]
alpha=[]
# 123 is same as 213 but not same as 132
for i in T
    if(findin(i,a1)!=Int64[]&&findin(i,a2)!=Int64[]&&findin(i,a3)!=Int64[])
        ds=[]
        for j in i
            if(findin(j,a1)!=Int64[])
                push!(ds,"a1")
            elseif(findin(j,a2)!=Int64[])
                push!(ds,"a2")
            elseif(findin(j,a3)!=Int64[])
                push!(ds,"a3")
            end
        end
        push!(alpha,ds)
    end
end
# print(unique(alpha))

# value=6
# append!(adjList[x],value) # Appending a value
# filter!(x -> x!=2,adjList[x]) # Removing a value
# print(adjList)
# addEdge(adjList,x,4)


function addEdge(dictionary, key, value)
    # adjList= Dict(-1 => [1,2,3])
    # x=-1
    # dictionary[key]= value
    # value=6
    if(haskey(dictionary,key))
        append!(dictionary[key],value) # Appending a value
    else
         dictionary[key]=[value]
    end
    if(haskey(dictionary,value))
        append!(dictionary[value],key) # Appending a value
    else
         dictionary[value]=[key]
    end

    # append!(dictionary[value],key) # Appending a value
    print(dictionary)
end
function removeEdge(dictionary, key, value)
    if(haskey(dictionary,key))
        # append!(dictionary[key],value)
        filter!(x -> x!=value,dictionary[key])
        # if(dictionary[key]== Int64[])
        #  delete!(dictionary,key)
        # end
    end
    if(haskey(dictionary,value))
        # append!(dictionary[key],value)
        filter!(x -> x!=key,dictionary[value])
        # if(dictionary[value]== Int64[])
        #     delete!(dictionary,value)
        # end
    end


    # filter!(x -> x!=value,dictionary[key]) # Removing a value
    print(dictionary)
end

adjList= Dict(-1 => [1,2,3])
# x=-1
# adjList[-1]= [-4,2,-3]
# adjList[2]=[6,9]
print(adjList)
addEdge(adjList,-1,4)
removeEdge(adjList,-1,4)
