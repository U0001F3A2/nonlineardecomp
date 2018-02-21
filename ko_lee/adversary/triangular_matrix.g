triangular_matrix := function(gen_set,G)

local element_list,reference_list,myfgroup,index_of_elem_with_smallest_index,smallest_index,
current_smallest_index,exp,tmp,tmp2,i,j,k,gen_set_list,origin;
	gen_set_list := [];

	myfgroup := FreeGroup(Length(gen_set[1]));
	element_list := ShallowCopy(gen_set[1]);
	reference_list:=ShallowCopy(GeneratorsOfGroup(myfgroup));
	
	for i in [1..Length(gen_set[1])-1] do
	
		Print("\n\n");
		Print(element_list);
		Print(reference_list);
		Print("\ni : ");
		Print(i);
		index_of_elem_with_smallest_index := i;
		smallest_index := GenExpList(element_list[i])[1];
		Print(element_list);
		
		for j in [i+1..Length(element_list)] do
			Print("\nj : ");
			Print(j);
			current_smallest_index := GenExpList(element_list[j])[1];
			
			#if smallest_index < current_smallest_index then
			#	continue;
			#fi;
			
			if smallest_index = current_smallest_index then
				exp := 0;
				for k in [1..Order(GeneratorsOfGroup(G)[smallest_index])] do
					Print("\nk : ");
					Print(k);
					exp := (exp + GenExpList(element_list[i])[2]) mod Order(GeneratorsOfGroup(G)[smallest_index]);
					
					if exp = GenExpList(element_list[j])[2] then
						element_list[j] := (element_list[i]^-1)^k * element_list[j];
						reference_list[j] := (reference_list[i]^-1)^k * reference_list[j];
						
						Print("\n");
						Print(element_list);
						break;
					fi;
					
				od;
			fi;
			
			if smallest_index > current_smallest_index then
				current_smallest_index := smallest_index;
				smallest_index := current_smallest_index;
				index_of_elem_with_smallest_index := j;
			fi;
		od;
		
		tmp := element_list[i];
		element_list[i] := element_list[index_of_elem_with_smallest_index];
		element_list[index_of_elem_with_smallest_index] := tmp;
		
		tmp2 := reference_list[i];
		reference_list[i] := reference_list[index_of_elem_with_smallest_index];
		reference_list[index_of_elem_with_smallest_index] := tmp2;
			
	od;
	
	for i in [1..Length(element_list)-1] do
		origin := Length(element_list)-i +1;
		for j in [1..origin-1] do
			exp := 0;
			for k in [1..Order(GeneratorsOfGroup(G)[smallest_index])] do
				exp := (exp + GenExpList(element_list[origin])[2]) mod Order(GeneratorsOfGroup(G)[smallest_index]);
				
				if exp = GenExpList(element_list[j])[2] then
					element_list[j] := element_list[j] * (element_list[origin]^-1)^k;
					reference_list[j] := reference_list[j] * (reference_list[origin]^-1)^k;
					
				fi;
			od;
		od;
	od;
	
	Print(element_list);
	Print(reference_list);
	
	return [element_list,reference_list];
end;