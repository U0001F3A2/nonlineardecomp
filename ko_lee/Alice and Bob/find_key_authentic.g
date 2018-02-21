find_key_authentic := function(g, a, gn) local add_gen, i, key, TimeStart, TimeSpent, leftPart;
	key := a^-1*gn*a;
	return key;
end;