//Part2: define a class which contains two inputs
class gcd_random;

rand bit [15:0] a; //Declare a random bit
rand bit [15:0] b; //Declare a random bit

//a and b must satisfy the following constraints, and a or b should not be '0'
constraint num_limit { 
a <= 'd500;
a > 'd0;
b < 'd500; 
b > 'd0; 
(a + b) == 'd500; 
}

endclass