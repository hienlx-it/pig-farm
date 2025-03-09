/**
* Name: Barn
* Author: Nguyen Ngoc Oanh
*/
model Barn

import './pig.gaml'

global {
	geometry shape <- rectangle(30 #m, 60 #m);
	list<point> gate_locs <- [{28, 59}, {3, 59}, {8, 59}, {13, 59}, {18, 59}, {23, 59}];
	list<point> water_locs <- [{1, 2}, {2, 6}, {1, 10}, {2, 14}, {1, 18}, {2, 22}];

	init {
		create Barn;
		file pigs <- csv_file("../includes/input/pigs.csv", true);
		create Pigs from: pigs;
		create Trough number: 5;
		loop i from: 1 to: 5 {
			Trough[i - 1].location <- gate_locs[i];
		}

	}

	reflex stop when: cycle = 60 * 24 * 20 {
		do pause;
	}

}

experiment Test type: gui {
	output {
		display Display1 {
			species Barn aspect: base;
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

species Barn {
	geometry shape <- rectangle(30 #dm, 60 #dm);
	
	aspect base {
		draw image("../includes/images/barn.png") at: {0, 0};
	}

}

species Pigs parent: Pig {

	/**
     * Get location functions
     */
	point get_relax_loc {
		return {rnd(4, 25), rnd(28, 55)};
	}

	point get_gate_in_loc {
		return gate_locs[rnd(length(gate_locs) - 2) + 1];
	}

	point get_gate_out_loc {
		return gate_locs[0];
	}

	point get_drink_loc {
		return water_locs[rnd(length(water_locs) - 1)];
	}

	point get_excrete_loc {
		return {rnd(11, 25), rnd(4, 20)};
	}

	reflex routine {
		do normal_routine();
		do refresh_per_day();
	}

}