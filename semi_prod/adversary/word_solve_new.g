Read(Concatenation(DirectoryAnalysis, "adversary/triangular_matrix.g"));

word_solve := function(G, gen_set, gm) local H, gen_elems, gen_elem, gen_exps, h, h_exp, v, index, exp, w, result, i, jl, MyFreeGroup, FreeGroupMatrix, m, n, row, gen_bundle, gen_reference,j, result2, o, p;
	result := [];
	H := Subgroup(G, gen_set[1]);
	MyFreeGroup := FreeGroup(Length(gen_set[1]));
	
	gen_bundle := IgsParallel(gen_set[1], GeneratorsOfGroup(MyFreeGroup));
	
	gen_elems := gen_bundle[1];
	gen_reference := gen_bundle[2];
	
	h := gm;
	while not h=Identity(G) do
		h_exp := GenExpList(h);
		Print(h);Print("\n");
		if h_exp[2] < 0 then
			h_exp[2] := Order(GeneratorsOfGroup(G)[h.exp[1]]) + h_exp[2];
		fi;
		for i in [1..Length(gen_elems)] do
			if GenExpList(gen_elems[i])[1] = h_exp[1] then
				w := gen_elems[i];
				index := i;
				break;
			fi;
		od;
		exp := 0;
		for j in [1..Order(GeneratorsOfGroup(G)[h_exp[1]])] do
			exp := (exp + GenExpList(w)[2]) mod Order(GeneratorsOfGroup(G)[h_exp[1]]);
			if exp = GenExpList(h)[2] then
				exp := j;
				break;
			fi;
		od;
		v := w^(exp);
		h := v^-1*h;
		Add(result,index);
		Add(result,exp);
	od;
	
	# converting the format according to LetterRepAssocWord format
	result2 := [];
	for o in [1..(Length(result)/2)] do
		index := (o*2) - 1;
		for p in [1..result[index+1]] do
			Add(result2, LetterRepAssocWord(gen_reference[result[index]]));
		od;
	od;
	
	result := Flat(result2);
	
	return result;
end;
