
# G a fp group, gen_set a list, gm_in... a list of exponent vectors of gm in terms of gen_set

find_key := function(G,endomorphism,gen_set,gm_in_terms_of_gen_set,gn) local result,i,sign,leftPart,j;
	result := Random(G)^0;
	sign := 1;
	for i in [1..Length(gm_in_terms_of_gen_set)] do
		if gm_in_terms_of_gen_set[i] < 0 then 
			gm_in_terms_of_gen_set[i] := -gm_in_terms_of_gen_set[i];
			sign := -1;
		fi;
		leftPart := gn;
		for j in [1..gm_in_terms_of_gen_set[i]] do
			leftPart := Image(endomorphism,leftPart);
		od;
		result := result * (leftPart * gen_set[gm_in_terms_of_gen_set[i]] * gn^-1)^sign;
		sign := 1;
	od;
	result := result * gn;
	Print(gm_in_terms_of_gen_set);
	Print("\n");
	return result;
end;