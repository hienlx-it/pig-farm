/**
* Name: Farm
* Author: Nguyen Ngoc Oanh
*/
model Farm

import './pig.gaml'

global {
	geometry shape <- rectangle(64 #m, 64 #m);
	list<int> trough_locs <- [25, 10, 33, 10, 38, 10, 43, 10, 48, 10, 53, 10];
	list<int> water_locs <- [3, 28, 2, 39, 3, 46, 2, 53, 3, 60];
	list<int> relax_locs<- [30, 60, 40, 60];
	list<int> excrete_locs<- [8, 19, 37, 59];
	list<int> gate_in_locs<- [25, 33, 33, 36];
	list<int> gate_out_locs<- [58, 63, 28, 31];

	init {
		file pigs <- csv_file("../includes/input/pigs.csv", true);
		create Pigs from: pigs;
		
		create Trough number: 6;
		loop i from: 0 to: 5 {
			Trough[i].location <- {trough_locs[2*i], trough_locs[2*i+1]};
		}

	}

	reflex stop when: cycle = 60 * 24 * 20 {
		do pause;
	}

}

experiment Test type: gui {
	output {
		display Simulator {
			image "../includes/images/background.png" refresh: false;
			species Pigs aspect: base;
		}

		display CFI refresh: every((60 * 24) #cycles) {
			chart "CFI" type: series {
				loop pig over: Pigs {
					data string(pig.id) value: pig.cfi;
				}

			}

		}

		display Weight refresh: every((60 * 24) #cycles) {
			chart "Weight" type: histogram {
				loop pig over: Pigs {
					data string(pig.id) value: pig.weight;
				}

			}

		}

	}

}

species Farm {
	geometry shape <- rectangle(64 #m, 64 #m);
	aspect base {
		draw image("../includes/images/backgroud.png");
	}
}

species Pigs parent: Pig {
	int barn;
/**
     * Get location functions
     */
	point get_relax_loc {
		return {rnd(relax_locs[0] + barn * 29, relax_locs[1] + barn * 29), rnd(relax_locs[2], relax_locs[3])};
	}

	point get_gate_in_loc {
		return {rnd(gate_in_locs[0], gate_in_locs[1]), rnd(gate_in_locs[2], gate_in_locs[3])};
	}

	point get_gate_out_loc {
		return {rnd(gate_out_locs[0], gate_out_locs[1]), rnd(gate_out_locs[2], gate_out_locs[3])};
	}

	point get_drink_loc {
		int i<-rnd(1, 4);
		return {water_locs[2*i] + barn * 29, water_locs[2*i+1]};
	}

	point get_excrete_loc {
		return {rnd(excrete_locs[0] + barn * 29, excrete_locs[1] + barn * 29), rnd(excrete_locs[2], excrete_locs[3])};
	}

	reflex routine {
		do normal_routine();
		do refresh_per_day();
	}

}