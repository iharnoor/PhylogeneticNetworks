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
<<<<<<< HEAD
            	temp=[a,c,z]
            	temp2=[z,c,a]
=======
            	temp = [a,c,z]
            	temp2 = [z,c,a]
				temp3=[c,a,z]
				temp4=[c,z,a]
>>>>>>> Harnoor
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
				if(temp3 in T && !(temp3 in computed))
            		append!(Z,c)
					Z = unique(Z)
					append!(computed, temp3)
            	end
				if(temp3 in T && !(temp4 in computed))
            		append!(Z,c)
					Z = unique(Z)
					append!(computed, temp4)
            	end
            	#or contains!(T,temp2))

            end
			# print("X=",string(X))
			# println()
			# print("Z=",string(Z))
        end
        h =Z[1]
        append!(X,h)
        splice!(Z,1)
<<<<<<< HEAD
=======
		# println(Z)
>>>>>>> Harnoor
    end
    return unique(X)
end

T= [[1,2,3], [1,2,4], [1,2,5], [2,3,4], [3,4,2], [2,3,5], [3,4,5], [1,3,4],
[3,4,1], [1,3,5], [1,4,5], [2,4,5],[2,1,3]]
L= [1,2,3,4,5]
<<<<<<< HEAD

N=computeSN(T, L,1,3)
print(N)
=======
N=computeSN(T, L,3,4) # Storing the SubNetwork list in N
print("Resulting SubNetwork: ",string(N))
>>>>>>> Harnoor
