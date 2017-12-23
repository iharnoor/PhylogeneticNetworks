to separe L-> if statement
function separateL()
	L=[1,2,3,4,5]
	X=[1]
	Z=[2]
	filter!(x -> x!=Z[1],L)
	filter!(x -> x!=X[1],L)
	print(L)
	return L
end
#hi
# PreCondition:
# Input: Pair= Hashset-> T (Rooted Triplet) toString({1,2},3)=1 2 3
# Input is a hashset of 3 numbers.
# Input also contains a leaf set two variables x,y
# Output: 
-- if statement modified to so that it gets added in 
-- both ways
function computeSN(T,L,x,y)
    X=[x]
    Z=[y]
    while(isempty(Z))
        z=Z[1]
        for a in X
            for c in L
            	temp=[a,c,z]
            	temp2=[z,c,a]
            	if(contains!(T,temp))#pseudo code
            		-- Z=Z U {c}
            		append!(Z,c)
            	end
            	if(contains!(T,temp2))
            		append!(Z,c)
            	end
            	#or contains!(T,temp2))
            end
        end
        rub=Z[1]
        append!(X,rub)
        -- filter!(x -> x!=Z[1],Z)
       	splice!(Z,1)
    end
    return X
end
