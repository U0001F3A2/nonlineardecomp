# DirectoryAnalysis := "./Dropbox/NonabelianCryptography/nonlinear_decomp_in_GAP/";

DirectoryAnalysis := "C:/Users/yoongbok lee/Dropbox/Nonabelian cryptography/ko_lee/";

Read(Concatenation(DirectoryAnalysis, "groupGenerator.g"));

Read(Concatenation(DirectoryAnalysis, "miscellaneous/grouptester.g"));

Read(Concatenation(DirectoryAnalysis, "adversary/nonlinear_decomposition.g"));

Read(Concatenation(DirectoryAnalysis, "adversary/nonlinear_decomposition_preimage.g"));

Read(Concatenation(DirectoryAnalysis, "Alice and Bob/find_key_authentic.g"));

trials := 100;
protocol := function(primes,G,A,B) local 
AdversaryResultList,AliceResultList,BobResultList, p, i, j, k, G, g, A, B, a, gm, b, gn, startTime1, authentic1, TimeSpent1,
startTime2, authentic2, TimeSpent2, startTime3, pirated, TimeSpent3,AliceSum, BobSum, AdversarySum,AliceAverage, BobAverage, AdversaryAverage,
AliceResultLists, BobResultLists, AdversaryResultLists,AverageList,resultList
startTime4, TimeSpent4, pirated2;

	for p in primes do
	
		Print("prime: ", p);Print("\n");
		AdversaryResultList1 := [];
		AdversaryResultList2 := [];
		AliceResultList := [];
		
		BobResultList := [];
		Print("start time: ", Runtime());Print("\n");
		
		#G := groupGenerator(p);
		#A := Group(G.2,G.3,G.4);
		#B := Group(G.5,G.6,G.7);
		
		#G := HeisenbergPcpGroup(p);
		#A := Group(G.1, G.4, G.2, G.5);
		#B := Group(G.3, G.4, G.6, G.7);
		
		for i in [1..trials] do
			
			g := Random(G);
			while (g in A) or (g in B) do
				g := Random(G);
			od;
			
			a := Random(A);
			gm := a^-1*g*a;

			b := Random(B);
			gn := b^-1*g*b;
			
			startTime1 := Runtime();
			authentic1 := find_key_authentic(g,a,gn);
			TimeSpent1 := Runtime() - startTime1;
			Add(AliceResultList,TimeSpent1);
			
			#Print(authentic1);
			#Print("\n");
			
			startTime2 := Runtime();
			authentic2 := find_key_authentic(g,b,gm);
			TimeSpent2 := Runtime() - startTime2;
			Add(BobResultList,TimeSpent2);
			
			#Print(authentic2);
			#Print("\n");

			#Print("Alice Key = Bob Key?\n");#Print(authentic1 = authentic2);#Print("\n");
			
			startTime3 := Runtime();
			pirated := nonlinear_decomposition(G,A,B,gm,gn,g);
			TimeSpent3 := Runtime() - startTime3;
			Add(AdversaryResultList1, TimeSpent3);
			
			if not (authentic1 = pirated) then
				Print("FAIL! adversary got the wrong key\n");
			fi;
			
			startTime4 := Runtime();
			pirated2 := nonlinear_decomposition_preimage(G,A,B,gm,gn,g);
			TimeSpent4 = Runtime() - startTime4;
			Add(AdversaryResultList2, TimeSpent4);
			
			if not (authentic1 = pirated2) then
				Print("FAIL! adversary got the wrong key\n");
			fi;
			
			#Print(pirated);#Print("\n");
			#Print(authentic1 = pirated);#Print("\n");
			
			AliceAverage := Average(AliceResultList);
			BobAverage := Average(BobResultList);
			AdversaryAverage1 := Average(AdversaryResultList1);
			AdversaryAverage2 := Average(AdversaryResultList2);
			
			AverageList := [AliceAverage,BobAverage,AdversaryAverage1,AdversaryAverage2];
			resultList := [AliceResultList,BobResultList,AdversaryResultList,AverageList];
			PrintTo(Concatenation(DirectoryAnalysis,"compare_test_results/",String(p),".txt"), resultList);
			
		od;
		Print("end time: ", Runtime());Print("\n");
		
		Print(AliceAverage);
		Print("\n");
		Print(BobAverage);
		Print("\n");
		Print(AdversaryAverage);
		Print("\n");
		
	od;
end;
for i in Filtered([1..20], x-> IsPrime(x)) do
	Gs := Filtered(AllGroups(i^5), x-> Length(grouptest(x))>3);
	for G in Gs do
		A := Group(Flat(grouptest(G)[1],grouptest(G)[2]));
		B := Group(Flat(grouptest(G)[3],grouptest(G)[4]));
		protocol([3],G,A,B);
	od;
od;