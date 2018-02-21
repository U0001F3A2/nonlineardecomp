

Read(Concatenation(DirectoryAnalysis, "adversary/find_generating_set.g"));
Read(Concatenation(DirectoryAnalysis, "adversary/find_key.g"));
Read(Concatenation(DirectoryAnalysis, "adversary/word_solve.g"));
#Read(Concatenation(DirectoryAnalysis, "adversary/MyImagesRepresentative.g"));

# G is a group
# A,B are subgroups of G that commutes element-wise.
# gm = Alice's Key
# gn = Bob's Key
# g = public element in G

nonlinear_decomposition := function(G,A,B,gm,gn,g) local gen_set, gm_in_terms_of_gen_set, shared_key, TimeStart, TimeSpent, thisShouldBeGm,i,index;

	gen_set := find_generating_set(G,A,g);
	gm_in_terms_of_gen_set := word_solve(G,gen_set,gm);	
	shared_key := find_key(G,gen_set,gm_in_terms_of_gen_set,gn);
	
	return shared_key;
end;
