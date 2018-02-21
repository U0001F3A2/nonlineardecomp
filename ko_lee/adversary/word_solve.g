
# Pcp G, list of generators of subgroup H gen_set, known element in H gm

word_solve := function(G, gen_set, gm) local H, Isomorphism, gmMapped, hom, wExponentList, newGenSet, w, i;

	H := Subgroup(G, gen_set[1]);
	hom := EpimorphismFromFreeGroup(H);
	w := PreImagesRepresentative(hom,gm);
	#Print(w,"\n");
	wExponentList := LetterRepAssocWord(w);
	return wExponentList;
end;