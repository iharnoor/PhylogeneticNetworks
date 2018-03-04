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
	X=sort(X)
    return unique(X)			#Returns a SubNetwork
end

function maximalSubsets(SNs, L)
	# SNs are sorted according to its size
		sortBySize(SNs)
		filter!(x -> x!=L,SNs)
		maxLen=0
		index=1
		# actually equal to the last element as the list is sorted by size
		indexOfMax = length(SNs)
		x=1
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
		return unique(SNs)
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

function sortBySize(arr)
    i=key=j=0
    # print(i)
    for i=2: length(arr)
        key = arr[i]
        j=i-1

        while(j>=1 && length(arr[j])>length(key))
            arr[j+1]=arr[j]
            j=j-1
        end
        arr[j+1]=key
    end
    # print(arr)
end
