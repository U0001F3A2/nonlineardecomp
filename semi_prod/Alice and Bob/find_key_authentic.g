find_key_authentic := function(g, m, endomorphism, gm, gn) local add_gen, i, key, TimeStart, TimeSpent, leftPart;
	TimeStart := Runtime();
	Print(TimeStart);
	Print("\n");
	#gm := g;
	#add_gen := Image(endomorphism,g);
	#for i in [1..(m-1)] do
	#	gm := add_gen * gm;
	#	add_gen := Image(endomorphism,add_gen);
	#od;
	
	leftPart := gn;
	for i in [1..m] do
		leftPart := Image(endomorphism,leftPart);
	od;
	key := leftPart * gm;
	TimeSpent := Runtime() - TimeStart;
	Print("Time authentic: ");
	Print(TimeSpent);
	Print("\n");
	return key;
end;