/**
* Name: Simulator
* Author: Nguyen Ngoc Oanh
*/
model Simulator

import './pig.gaml'

global {
	geometry shape <- rectangle(64 #m, 64 #m);
	list<int> trough_locs <- [25, 10, 33, 10, 38, 10, 43, 10, 48, 10, 53, 10];
	list<int> water_locs <- [3, 28, 2, 39, 3, 46, 2, 53, 3, 60];
	list<int> relax_locs<- [30, 60, 40, 60];
	list<int> excrete_locs<- [8, 19, 37, 59];
	list<int> gate_in_locs<- [25, 33, 33, 36];
	list<int> gate_out_locs<- [58, 63, 28, 31];
	
}

experiment TransmitDisease {
	output {
		display Simulator {
			image "../includes/images/background.png" refresh: false;
			species Pig aspect: base;
		}
	}
}