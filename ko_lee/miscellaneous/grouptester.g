
grouptest := function (G) local gens,i,j,commute, result;
	result := [];
	gens := GeneratorsOfGroup(G);
	for i in [1..Length(gens)] do
		for j in [(i+1)..Length(gens)] do
			Print(gens[i],", ",gens[j],": ");
			commute := gens[i]^-1*gens[j]^-1*gens[i]*gens[j] = Identity(G);
			Print(commute);
			if not commute then
				Add(result,[gens[i],gens[j]]);
			fi;
			Print("\n");
		od;
		Print("\n");
	od;
	return result;
end;