# Research-in-Julia
Creating a level 1 phylogenic tree

## Built By 
* [Naman Kanwar](https://github.com/Naman26) 
* [Harnoor Singh](https://github.com/iharnoor) 

## Test cases
1,2,3,4,5
(n+1) choose 2 = 6 choose 2 = 15

5 repeated:
* SN(1,1) = 1
* SN(2,2) = 2
* SN(3,3) = 3
* SN(4,4) = 4
* SN(5,5) = 5

5 choose 2 = 10 => no repeated
* SN(1,2) = {1,2}//  correct
* SN(1,3) = {1,3,2,4} //correct
* SN(1,4) = {1,2,3,4}  correct
* SN(1,5) = [1, 5, 2, 3, 4]// correct
* SN(2,3) = [2, 3, 4]//Incorrect(1,2,3,4) fixed
* SN(2,4) = [2, 4, 3]//Incorrect (1,2,3,4)/fixed
* SN(2,5) = [2, 5, 3, 4]//Incorrect (1,2,3,4,5)/fixed
* SN(3,4) = {3,4}//correct wrong 3412
* SN(3,5) = [3, 5, 4]//Incorrect (1,2,3,4,5) /corrected
* SN(4,5) = {4,5}//Incorrect (1,2,3,4,5)/corrected
