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
	L1= copy(L) # Creating a copy to be used again
    while(!isempty(Z)) # Run until Z becomes empty
		z=Z[1]
        for a in X
			L= copy(L1)
			# Filter starts L- (X U Z)
			for p in X
				filter!(x -> x!=p,L) #removing all the elements of X in L
			end
			for p in Z
				filter!(x -> x!=p,L) #removing all the elements of Z in L
			end
			# Filter ends  L- (X U Z)
            for c in L
            	temp = [a,c,z]
            	temp2 = [z,c,a]
				temp3=[c,a,z]
				temp4=[c,z,a]
            	if(temp in T && !(temp in computed)) #pseudo code
            		#Z=Z U {c}
					append!(Z,c)
					Z = unique(Z) # Making Z unique to avoid redundancy
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
		# println(Z)
    end
    return X			#Returns a SubNetwork
end

# T= [[1,2,3], [1,2,4], [1,2,5], [2,3,4], [3,4,2], [2,3,5], [3,4,5], [1,3,4],
# [3,4,1], [1,3,5], [1,4,5], [2,4,5],[2,1,3]]
# L= [1,2,3,4]
# N=computeSN(T, L,2,4) # Storing the SubNetwork list in N
# print("Resulting SubNetwork: ",string(N))

# vector size less than 3 then you stop.

function maximalSubsets(SNs, L)

	    # Still need to use for loop to store the computeSN results in a single data structure and make it unique

	    # find the set with all leaf values and exclude it
	    # remove all the subsets that are not disjoint  and that will be the answer
		# for i in SNs
		# 	if i==L
		filter!(x -> x!=L,SNs)
		maxLen=0
		index=1
		indexOfMax=0
		for x in SNs
			if (length(x) > maxLen)
				maxLen = length(x)
				indexOfMax=index
			end
			index=index+1
		end
		# println(SNs)
		# println(indexOfMax)
		# println(maxLen)
		# for x in SNs
			# if SNs[indexOfMax] contains x in it $$ index != indexOfMax
			# 	then remove x
				# if
		x=1
		# Assuming SNs are sorted according to its size
		while(x<indexOfMax)
			if (findin(SNs[indexOfMax],SNs[x])!=Int64[])
				# then remove x
				deleteat!(SNs,x)
				# println("Inside If statement",string(x))
				indexOfMax-=1
				x-=1
			end
			x+=1
		end
		return SNs

		# for x in set_SN
		# 	for y in set_SN
		# for largest set in
		# for y in set_SN
		# if x contains y or y contains x remove it
		# else keep it
end
set_SN = [[1],[2],[3],[4],[5],[1,2],[1,2,3,4],[1,2,3,4,5]]
L= [1,2,3,4,5]
maximalSubsets(set_SN,L)





# Assuming we have stored have results in a single result in a single data structure

function oneHybridLeaf(T,L)
	maximumSubsets= maximalSubsets(set_SN,L)
	print(maximumSubsets)
	for SN in maximumSubsets
		if length(SN)>=3
			print("need to call computeSN(SN)")
		else
			print("need to make a tree with these 2 nodes")
		end
	end
	println("Working")
end




for i in eachindex(L)
	j= i+1
	while j<length(L)
		
