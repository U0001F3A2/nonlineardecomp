find_generating_set := function(G,A,g) local  gen_list,i,j,k,prev_subgroup,result_word,new_index,new_letter,extended,result,gen_set_A,exponent_list,gen_bundle;

	gen_list := [g];
	exponent_list := [Identity(G)];
	i := 1;
	gen_set_A := GeneratorsOfGroup(A);
	extended := true;
	while extended = true do
		prev_subgroup := Subgroup(G,gen_list);
		
		for j in [1..(Length(gen_set_A))^i] do
			result_word := Identity(G);
			result := Identity(G);
			
			for k in [1..i] do
				new_index := ((j mod Length(gen_set_A)^(k+1)) - (j mod Length(gen_set_A)^k))
				/ Length(gen_set_A)^k;
				new_letter := gen_set_A[new_index+1];
				result := new_letter*result;
			od;
			
			if not (g^result in Subgroup(G, gen_list)) then
				Add(gen_list,g^result);
				Add(exponent_list,result);
			fi;
			
		od;
		if prev_subgroup = Subgroup(G, gen_list) then
			extended := false;
		fi;
		i := i + 1;
	od;
	#Print(exponent_list);
	#Print(gen_list);
	
	return [gen_list,exponent_list];
end;