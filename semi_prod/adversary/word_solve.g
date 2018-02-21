
# Pcp G, list of generators of subgroup H gen_set, known element in H gm

word_solve := function(G, gen_set, gm) local H, Isomorphism, gmMapped, hom, wExponentList, newGenSet, w, i;

	H := Subgroup(G, gen_set);
	Print(H);
	Print("\n");
	Print(gen_set);
	Print("\n");
	hom := EpimorphismFromFreeGroup(H);
	w := PreImagesRepresentative(hom,gm);
	
	Print("w\n");Print(w);Print("\n");
	#newGenSet := [Length(gen_set)];
	#for i in [1..Length(gen_set)] do
	#	newGenSet[i] := PreImagesRepresentative(hom,gen_set[i]);
	#od;
	#Print(newGenSet);
	#Print("\n");
	wExponentList := LetterRepAssocWord(w);
	Print("wExponentList\n");
	Print(wExponentList);
	Print("\n");
	return wExponentList;
	
	#Isomorphism := IsomorphismFpGroupByGenerators(H, gen_set);
	#gmMapped := SetReducedMultiplication(Image(Isomorphism, gm));
	#Print(gmMapped);
	#Print("\n");
	#return Exponents(gmMapped);

end;