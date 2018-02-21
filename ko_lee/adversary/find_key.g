
# G a fp group, gen_set a list, gm_in... a list of exponent vectors of gm in terms of gen_set

find_key := function(G,gen_set,gm_in_terms_of_gen_set,gn) local result,i,sign,leftPart,j;
	result := Identity(G);
	
	for i in [1..Length(gm_in_terms_of_gen_set)] do
		if gm_in_terms_of_gen_set[i] < 0 then
			result := result * (gn^(gen_set[2][-gm_in_terms_of_gen_set[i]]))^-1;
		else
			result := result * gn^(gen_set[2][gm_in_terms_of_gen_set[i]]);
		fi;
	od;
	
	return result;
end;
	
	#sign := 1;
	#for i in [1..Length(gm_in_terms_of_gen_set)] do
	#	if gm_in_terms_of_gen_set[i] < 0 then 
	#		gm_in_terms_of_gen_set[i] := -gm_in_terms_of_gen_set[i];
	#		sign := -1;
	#	fi;
	#	leftPart := gn;
	#	for j in [1..gm_in_terms_of_gen_set[i]] do
	#		leftPart := Image(endomorphism,leftPart);
	#	od;
	#	result := result * (leftPart * gen_set[gm_in_terms_of_gen_set[i]] * gn^-1)^sign;
	#	sign := 1;
	#od;
	#result := result * gn;
	#Print(gm_in_terms_of_gen_set);
	#Print("\n");
	#return result;
#end;