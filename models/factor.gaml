/**
* Name: Factor
* Author: Nguyen Ngoc Oanh
*/

model Factor

import './farm.gaml'

species Factor {
	int duration;
	float size;
	float transmit_rate; // transmit rate
	float e <- 2.72;
	
	init {
		transmit_rate <- 0.0;
		size <- 0.0;
		duration <- 0;
	}
	
	reflex update {
		if(duration > 0) {
			
			duration <- duration - 1;
		}
		else {
			do die;
		}
	}
	
	bool expose(agent pig) {
		return flip(1 - e ^-transmit_rate) and distance_to(pig.location, location) <= size;
	}
}