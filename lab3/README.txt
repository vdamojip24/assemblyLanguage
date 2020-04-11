Vishal Damojipurapu
vdamojip@ucsc.edu
LAB 3: RIPPLE ADDER WITH MEMORY 
2/7/18
1D, Carlos Ramirez
					Lab 3 README

Magic numbers:

(hexadecimal) 0x6010
(octal) 0234
(binary) 0b0111 - It was in binary but the what the professor wrote down looked like a b instead of a 10, so I am not sure

	I received help from the textbook and lab in this assignment. I got the adder from the textbook and lab helped me with figuring out how to use the MUX. The lab TA’s told me to connect the E from the MUX to ground. 
	There was a lot I learned from this lab. The most important tool I learned  from this lab was how to use the MUX. It fascinates me how it can select an option  for you by using an inverter. I also learned about the register and  how we use it  to store bits. In addition, I learned to connect the E part of the MUX to ground.   The binary addition was new to me as well because earlier I did not know you needed two extra bits to add four bits in hexadecimal. The final thing I learned was how to create an adder. I used the adder from the textbook, but I still took time to      understand it. The most interesting part for me was dropping the last carry bit in  the last adder.                                                                     
	As usual, there were several issues I came across when building the circuit. It began with the adder. There were so many lines pointing in so many places that  it was hard to figure out which wire goes where. I thought I figured it  out, but   when I tested out a single adder using the LED, I found out I messed up somewhere.  Luckily, it was an easy fix because the diagram was given in the textbook. I also   had trouble figuring out what the first carry bit (C_0) was. After going to lab, I  learned the first carry bit was a 0 if we are adding and 1 if we are subtracting    (due to two complement). Lastly, I had trouble figuring out how to use the MUX. I   had particular issues with figuring out what to do with “E”, but then again I got assistance from a TA that I had to connect it to ground. 
	Debugging was an issue in this lab because there were so many wires         everywhere. I could not tell which part of the circuit was messing up until I used  the LEDs. I fixed my one bit adder using LEDs, and just copied five more onto the   following pages since I knew it worked. I was not really sure how to debug the MUX  because everything seemed to work correctly except for one small part, and the only reason I was able to fix it was because I got assistance from a TA. One issue I had with the register was that I mislabeled some receivers, but luckily MML directs you to those kind of mistakes. I also debugged it by placing LEDs and changing some of  the receivers to switches to test the inverters. 
	When subtracting a larger number from a smaller number, the display begins  to count backwards from 3F. For example if you subtract 1 from 0, you end up at 3F. As you continue subtracting 1, it results in counting backwards from 3F to 3D and onwards. This technically makes sense to me because there is a pattern to it, and you cannot really display a negative number, so this is the best we can do. When adding two numbers that do not fit in six bits, we start again at 0. For example, if we add 5 to 3C, we get 01. This is because it does not fit in six bits anymore, so we have to begin at 1 again. 
