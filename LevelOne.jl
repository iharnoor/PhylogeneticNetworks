include("ComputeSN.jl")


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
	println(set_SN)
	L= [1,2,3,4]
	var =maximalSubsets(set_SN,L)
	println("Maximal Subsets=",string(var))
end
main_func()
