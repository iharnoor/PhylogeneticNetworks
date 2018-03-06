T= [[1,2,3], [1,2,4], [1,2,5], [2,3,4], [3,4,2], [2,3,5], [3,4,5], [1,3,4],
[3,4,1], [1,3,5], [1,4,5], [2,4,5],[2,1,3]]
# L= [1,2,3,4,5]


SNs =[[1,2],[3],[4]]
a1= SNs[1]
a2= SNs[2]
a3= SNs[3]
ds=[]
# 123 is same as 213 but not same as 132
for i in T
    # Assuming we have all the lists of combinations from a1, a2, a3
    # temp1= [a1[1],a2,a3]
    # temp2= [a1[2],a2,a3]

    if(findin(i,a1)!=Int64[]&&findin(i,a2)!=Int64[]&&findin(i,a3)!=Int64[])
        ds=[i]
        print(ds)
    end
end

# if(ds contains element of a1 replace it by a1)
if(findin(ds,a1)!=Int64[]&&findin(ds,a2)!=Int64[]&&findin(ds,a3)!=Int64[])
    
end
