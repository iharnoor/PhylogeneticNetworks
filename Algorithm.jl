#=to separe L-> if statement
function separateL()
	L=[1,2,3,4,5]
	X=[1]
	Z=[2]
	filter!(x -> x!=Z[1],L)
	filter!(x -> x!=X[1],L)
	print(L)
	return L
end=#
#hi
# PreCondition:
# Input: Pair= Hashset-> T (Rooted Triplet) toString({1,2},3)=1 2 3
# Input is a hashset of 3 numbers.
# Input also contains a leaf set two variables x,y
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
		println("Z= ", string(Z))
        for a in X
			L= copy(L1)
			for p in X
				filter!(x -> x!=p,L)
			end
			for p in Z
				filter!(x -> x!=p,L)
			end
			# println("X= ", string(X))
			# println("a= ", string(a))
			# println("Z= ", string(Z))
			# println("z= ", string(z))
			# println("L1= ", string(L1))

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
				println("Z= ", string(Z))
            end
        end
        h =Z[1]
        append!(X,h)
        splice!(Z,1)
		println("Z= ", string(Z))
		println("--------------")

		#println("Z= ", string(Z))
    end
    return X
end

T= [[1,2,3], [1,2,4], [1,2,5], [2,3,4], [3,4,2], [2,3,5], [3,4,5], [1,3,4],
[3,4,1], [1,3,5], [1,4,5], [2,4,5]]

L= [1,2,3,4,5]

N=computeSN(T, L,1,3)
print(N)
