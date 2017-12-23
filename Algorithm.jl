to separe L-> if statement
function toSep()
	L=[1,2,3,4,5]
	X=[1]
	Z=[2]
	filter!(x -> x!=Z[1],L)
	filter!(x -> x!=X[1],L)
	print(L)
	return L
end

# PreCondition:
# Input: Pair= Hashset-> T (Rooted Triplet) toString({1,2},3)=1 2 3
# Input is a hashset of 3 numbers.
# Input also contains a leaf set two variables x,y
# Output: 
function computeSN(T,L,x,y)
    X=[x]
    Z=[y]
    while(isempty(Z))
        z=Z[1]
        for a in X
            if c

