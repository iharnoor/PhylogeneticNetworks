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
    while(!isempty(Z))
        z=Z[1]
        for a in X
            for c in L
            	temp=[a,c,z]
            	temp2=[z,c,a]
            	if(temp in T && !(temp in computed)) #pseudo code
            		#Z=Z U {c}
            		append!(Z,c)
					append!(computed, temp)
            	end
            	if(temp2 in T && !(temp2 in computed))
            		append!(Z,c)
					append!(computed, temp2)
            	end
            	#or contains!(T,temp2))
            end
        end
        c =Z[1]
        append!(X,c)
        splice!(Z,1)
    end
    return X
end

T= [[1,2,3], [1,2,4], [1,2,5], [2,3,4], [2,3,4], [2,3,5], [3,4,5], [1,3,4],
[1,3,4], [1,3,5], [1,4,5], [2,4,5]]
L= [2,3,5]

N= computeSN(T, L,1,4)
print(N)
