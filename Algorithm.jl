# PreCondition:
# Input: Pair= Hashset-> T (Rooted Triplet) toString({1,2},3)=[1 2 3]
# Input also contains set of leaves l
# Input also contains two variables
# Output:
#if statement modified to so that it gets added in both ways
function computeSN(T,L,x,y)
    X= [x]
    Z= [y]
	computed= []
	L1= []
	L1= copy(L)
    while(!isempty(Z))
		z=Z[1]
		# println("L= ", string(L))
        for a in X
			L= copy(L1)
			for p in X
				filter!(x -> x!=p,L)
			end
			for p in Z
				filter!(x -> x!=p,L)
			end
            for c in L
            	temp=[a,c,z]
            	temp2=[z,c,a]
            	if(temp in T && !(temp in computed)) #pseudo code
            		#Z=Z U {c}
					append!(Z,c)
					Z = unique(Z)
				#	println("Z= ", string(Z))
					append!(computed, temp)
            	end
            	if(temp2 in T && !(temp2 in computed))
            		append!(Z,c)
					Z = unique(Z)
					append!(computed, temp2)
            	end
            	#or contains!(T,temp2))

            end
        end
        h =Z[1]
        append!(X,h)
        splice!(Z,1)
    end
    return unique(X)
end

# T= [[1,2,3], [1,2,4], [1,2,5], [2,3,4], [3,4,2], [2,3,5], [3,4,5], [1,3,4],
# [3,4,1], [1,3,5], [1,4,5], [2,4,5]]

T= [[1,2,3], [1,2,4], [2,3,4], [3,4,2], [1,3,4], [3,4,1]]

L= [1,2,3,4]

N=computeSN(T, L,1,2)
print(N)
