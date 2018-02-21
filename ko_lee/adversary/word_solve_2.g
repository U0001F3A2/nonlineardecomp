
# Pcp G, list of generators of subgroup H gen_set, known element in H gm

word_solve := function(G, gen_set, gm) local H, Isomorphism, gmMapped, hom, wExponentList, newGenSet, w, i,j,k,l, H2, hom2, element_images, element_image,result_exponent_list,w_igs,w_igs_exponentlist, element_image_exp,element_image_exps;

	H := Subgroup(G, gen_set[1]);
	induced_gen_set := Igs(H);
	hom := EpimorphismFromFreeGroup(H);
	
	H2 := Subgroup(G, Igs(H));
	hom2 := EpimorphismFromFreeGroup(H2);
	w_igs := PreImagesRepresentative(hom2,gm);
	w_igs_exponentlist := LetterRepAssocWord(w_igs);
	
	
	element_image_exps_list := [];
	for j in [1..Length(induced_gen_set)] do
		element_image := PreImagesRepresentative(hom,induced_gen_set[j]);
		element_image_exps := LetterRepAssocWord(element_image);
		Add(element_image_exps_list,element_image_exps);
	od;
	
	#decompose to get image in respect to original generating set
	result_exponent_list := [];
	for k in [1..Length(w_igs_exponentlist)] do
		sign := 1;
		if w_igs_exponentlist[k] < 0 then
			w_igs_exponentlist[k] := -w_igs_exponentlist[k];
			sign := -1;
		fi;
		
		for l in [1..Length(element_image_exps_list[w_igs_exponentlist[k]])] do
			element := element_image_exps_list[w_igs_exponentlist[k]];
			#Print(element);
			Add(result_exponent_list, element[l] * sign);
		od;
	od;
	
	w := PreImagesRepresentative(hom,gm);
	
	##Print("w\n");#Print(w);#Print("\n");
	#newGenSet := [Length(gen_set[1])];
	#for i in [1..Length(gen_set[1])] do
	#	newGenSet[i] := PreImagesRepresentative(hom,gen_set[1][i]);
	#od;
	##Print(newGenSet);
	##Print("\n");
	wExponentList := LetterRepAssocWord(w);
	##Print("wExponentList\n");
	##Print(wExponentList);
	##Print("\n");
	##Print("wExtRepObj");
	#extrep := ExtRepOfObj( w );
	##Print(extrep);
	##Print("\n");
	return result_exponent_list;

end;