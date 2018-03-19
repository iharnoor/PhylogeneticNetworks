using DataStructures
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
print(unique(alpha))
