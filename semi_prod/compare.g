DirectoryAnalysis := "C:/Users/Yoongbok Lee/Dropbox/Nonabelian cryptography/semi_prod/";

# DirectoryAnalysis := "./Dropbox/NonabelianCryptography/semi_prod/";

Read(Concatenation(DirectoryAnalysis, "groupGenerator.g"));

Read(Concatenation(DirectoryAnalysis, "miscellaneous/grouptester.g"));

Read(Concatenation(DirectoryAnalysis, "adversary/nonlinear_decomposition.g"));

Read(Concatenation(DirectoryAnalysis, "adversary/nonlinear_decomposition_preimage.g"));

Read(Concatenation(DirectoryAnalysis, "Alice and Bob/find_key_authentic.g"));

trials := 100;
protocol := function(primes,G,A,B) local 
AdversaryResultList1,AdversaryResultList2 ,AliceResultList,BobResultList, p, i, j, k, g, a, gm, b, gn, startTime1, authentic1, TimeSpent1,
startTime2, authentic2, TimeSpent2, startTime3, pirated, TimeSpent3,AliceSum, BobSum, AdversarySum,AliceAverage, BobAverage, AdversaryAverage1, AdversaryAverage2,
AliceResultLists, BobResultLists, AdversaryResultLists,AverageList,resultList,
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
			
			newMap := Random(G);
			g := Random(G);
			gens := GeneratorsOfGroup(G);
			imgs := newMap^-1*gens*newMap;
			phi := GroupHomomorphismByImages( G, G, gens, imgs );
			
			int := [1..10000]
			a := Random(int);
			for i in [1..a] do
				gm := phi(g);
			od;

			int := [1..10000]
			b := Random(int);
			for i in [1..b] do
				gn := phi(g);
			od;
			
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
			TimeSpent4 := Runtime() - startTime4;
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
			resultList := [AliceResultList,BobResultList,AdversaryResultList1,AdversaryResultList2,AverageList];
			PrintTo(Concatenation(DirectoryAnalysis,"compare_test_results/",String(p),".txt"), resultList);
			
		od;
		Print("end time: ", Runtime());Print("\n");
		
		Print(AliceAverage);
		Print("\n");
		Print(BobAverage);
		Print("\n");
		Print(AdversaryAverage1);
		Print("\n");
		Print(AdversaryAverage2);
		Print("\n");
		
	od;
end;

l27 := AllSmallGroups(27);
filt27:= Filtered(l27, i -> not IsAbelian(i));
B:= StandardWreathProduct(filt27[1], Group((1,2,3)));
iso:= IsomorphismPcGroup(B);
G:= Image(iso);
isom:= IsomorphismPcpGroup(G);
G:= Image(isom);

for i in Filtered([1..30], x-> IsPrime(x)) do
	G := groupGenerator(i);
	
	# Gs := Filtered(AllGroups(i^5), x-> Length(grouptest(x))>3);
	Gs := [G];
	for G in Gs do
		# tested := grouptest(G);
		# A := Group(Flat([tested[1],tested[2]]));
		# B := Group(Flat([tested[3],tested[4]]));
		protocol([i],G,A,B);
	od;
od;
