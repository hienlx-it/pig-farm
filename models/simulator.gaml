/**
* Name: Simulator
* Author: Nguyen Ngoc Oanh
*/
model Simulator

import './pig.gaml'

global {
	geometry shape <- rectangle(64#m,64#m);
	list<point> trough_locs <- [{33, 14}, {38, 14}, {43, 14}, {48, 14}, {53, 14}];
	init {
		file pigs <- csv_file("../includes/input/pigs.csv", true);
		create Pig from: pigs;
		create Trough number: 5;
		loop i from: 0 to: 4 {
			Trough[i].location <- trough_locs[i];
		}

	}

	reflex stop when: cycle = 60 * 24 * 1 {
		do pause;
	}

}

experiment Normal {
	output {
		display Simulator {
			image "../includes/images/background.png" refresh: false;
			species Pig aspect: base;
		}
	}
}