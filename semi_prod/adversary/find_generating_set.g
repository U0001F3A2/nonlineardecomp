find_generating_set := function(G,endomorphism,g) local  cur_gen, new_gen, result_gen_list, add_gen,subgroup;
	result_gen_list := [g];
	add_gen := Image(endomorphism,g);
	cur_gen := add_gen*g;
	subgroup := Subgroup(G, result_gen_list);
	
	while not \in(cur_gen,subgroup) do 
		Add(result_gen_list,cur_gen);
		subgroup := Subgroup(G, result_gen_list);
		add_gen := Image(endomorphism,add_gen);
		cur_gen := add_gen*cur_gen;
	od;
	
	#cur_gen := g;
	#result_gen_list := [g];
	#while not \in(cur_gen,subgroup) do
	#	cur_gen := Image(endomorphism,cur_gen);
	#	Add(result_gen_list, cur_gen);
	#od;
	return result_gen_list;
end;