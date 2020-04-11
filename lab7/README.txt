Vishal Damojipurapu
vdamojip@ucsc.edu
Lab7: Floating Point Calculations
3/16/18
1D, Carlos Ramirez
					README

	This concept of IEEE 754 Single-Precision format was completely new to me. I always thought converting from one base to another would be very simple because of how I had done it before. However, this format was a little more trickier. Luckily, the format of the technique made it a lot easier to understand. The one formula that helped me throughout the lab was (-1)^s * (1.F)(2)^(e-127) where s is the sign bit, F is the significand, and e is the exponent. I was a little surprised at how the 1 from the 1.F becomes a hidden bit, but other than that, the rest of it made sense. The arithmetic behind the lab worked really well for me because I like performing calculations, however some problems became too tedious and difficult. The multiplication was very tedious and a simple mistake threw off the entire answer. Also, 2b was a difficult problem and I am not too sure if I did that one correctly either. 
	The largest positive number in IEEE floating point in binary would be 0 followed by 31 1's. This would look like: 01111111111111111111111111111111. Thus, the decimal form would be: (2 − 2^(-23)) × 2^127. This is equivalent to 3.4 * 10^38. The smallest positive number in IEEE floating point binary would be 31 0's followed by a singular 1. This would look like : 000000000000000000000000000000001. The decimal form of this would be 2^(-126) or 1.18 * 10^(-38). 
	Bias representation in the exponents speeds up floating point addition and subtraction much faster than twos complement representation because it requires less work and sign is not an issue. All you have to do is compare the exponents and subtract the bias, which is really simple. Compared to twos complement representation, where you have to compare the exponent and the significand, subtracting the bias from the exponent is much simpler.  

FL_add:
	0. store both sign bits in separate registers. 
	1. check exponents of both numbers by checking bits 1-8 and subtract bias (127) 
	2. get significand bits (bits 9-31) and make both of the significand's have the 	   same 2^(exp-bias) by shifting the bits of the significands accordingly
	3. add each bit by bit of the significand and store result as new significand
	4. put together newly added number by first placing the sign bit, followed by the 	   8 exponent bits from the step 2, followed by the 23 bit new significand. 	
	5. store this in added number in a new register. 

Fl_mult:
	0. store both sign bits in separate registers.
	1. check exponents of both numbers by checking bits 1-8 and subtract bias (127)
	2. get significand bits (bits 9-31) and store in register
	3. multiply the +/- 1.F * +/- 1.F numbers together where F is the significand to 	   each number. 
	4. multiply the two 2^(exp - bias) numbers by simply adding their exponent value 	   and store that number as well.
	5. put together newly multiplied number by first placing the sigh bit, followed by 	   the 8 exponent bits from the multiplying in step 4 , followed by the 23 bit new 	   significand we get from multiplication. 