# include("ComputeSN.jl")

function maximalSubsets(SNs, L)
	# SNs are sorted according to its size
		sortBySize(SNs)
		filter!(x -> x!=L,SNs)
		maxLen=0

		println(SNs)
		# index=1
		# indexOfMax=0#
		# for x in SNs
		# 	if (length(x) > maxLen)
		# 		maxLen = length(x)
		# 		indexOfMax=index
		# 	end
		# 	index=index+1
		# end
		x=1

		# while(x<indexOfMax)
		# 	if (findin(SNs[indexOfMax],SNs[x])!=Int64[])
		# 		# then remove x
		# 		deleteat!(SNs,x)
		# 		# println("Inside If statement",string(x))
		# 		indexOfMax-=1
		# 		x-=1
		# 	end
		# 	x+=1
		# end
		return SNs
end

T= [[1,2,3], [1,2,4], [1,2,5], [2,3,4], [3,4,2], [2,3,5], [3,4,5], [1,3,4],
[3,4,1], [1,3,5], [1,4,5], [2,4,5],[2,1,3]]
L= [1,2,3,4]
set_SN = retComputeSN(T,L)
maximumSubsets= maximalSubsets(set_SN,L)
print(maximumSubsets)

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
