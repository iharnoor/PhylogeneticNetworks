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
    return unique(X)			#Returns a SubNetwork
end

function maximalSubsets(SNs, L)
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
end

function retComputeSN(T,L)
	pairs=[]
	for i in eachindex(L)
		j=i
		while(j<=length(L))
			temp=[]
			append!(temp,[L[i],L[j]])
			append!(pairs,[temp])
			j+=1
		end
		i+=1
	end
	res=[]
	for element in pairs
		temp=[]
		append!(temp,computeSN(T, L,element[1],element[2]))
		append!(res,[temp])
	end
	return res
end


function levelOne()
	T= [[1,2,3], [1,2,4], [1,2,5], [2,3,4], [3,4,2], [2,3,5], [3,4,5], [1,3,4],
	[3,4,1], [1,3,5], [1,4,5], [2,4,5],[2,1,3]]
	L= [1,2,3,4]
	set_SN = retComputeSN(T,L)
	maximumSubsets= maximalSubsets(set_SN,L)
	# print(maximumSubsets)
	tree=[]
	for SN in maximumSubsets
		if length(SN)>=3
			temp=retComputeSN(T,SN)
			maximumSets=maximalSubsets(temp,L)
			println("Printing")
			println(maximumSets)
		else
			# tree=
			println("need to make a tree with these 2 nodes")
		end
	end
end


function main_func()
	T= [[1,2,3], [1,2,4], [1,2,5], [2,3,4], [3,4,2], [2,3,5], [3,4,5], [1,3,4],
	[3,4,1], [1,3,5], [1,4,5], [2,4,5],[2,1,3]]
	L= [1,2,3,4]
	set_SN = retComputeSN(T,L)
	# print(set_SN)
	L= [1,2,3,4]
	var =maximalSubsets(set_SN,L)
	# print("Maximal Subsets=",string(var))
	# print(var)
end
main_func()
