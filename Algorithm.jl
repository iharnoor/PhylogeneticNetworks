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
# if statement modified to so that it gets added in both ways

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
				println(temp)
				# println(temp2)
            	if(temp in T && !(temp in computed)) #Z=Z U {c} (contains)
            		append!(Z,c)
					append!(computed, temp)
					# print('X=',X)
					# print('Y=',X)
					# print('temp11=',temp)
					# print('temp21',temp2)
            	end
            	if(temp2 in T && !(temp2 in computed))
            		append!(Z,c)
					append!(computed, temp2)
					# print('computed2=',computed)
					# print('temp11=',temp)
					# print('temp21',temp2)
            	end
				# print(computed)
            end
        end
        h =Z[1]
        append!(X,h)
        splice!(Z,1)
    end
    return X
end

T= [[1,2,3], [1,2,4], [1,2,5], [2,3,4], [2,3,4], [2,3,5], [3,4,5], [1,3,4],
[1,3,4], [1,3,5], [1,4,5], [2,4,5]]
L= [2,4,5]

N= @enter computeSN(T, L,1,3)
print(N)

# T= [[(1,2),3], [(1,2),4], [1,2,5], [2,(3,4)], [(2,3),4], [2,3,5], [3,4,5], [1,3,4],
# [1,3,4], [1,3,5], [1,4,5], [2,4,5]]
# T= parsedT(T)
