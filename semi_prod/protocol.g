# DirectoryAnalysis := "./Dropbox/NonabelianCryptography/semi_prod/";

DirectoryAnalysis := "C:/Users/Yoongbok Lee/Dropbox/Nonabelian cryptography/semi_prod/";

Read(Concatenation(DirectoryAnalysis, "groupGenerator.g"));

Read(Concatenation(DirectoryAnalysis, "adversary/nonlinear_decomposition.g"));

Read(Concatenation(DirectoryAnalysis, "Alice and Bob/find_key_authentic.g"));

trials := 100;
protocol := function(primes) local
AdversaryResultList,AliceResultList,BobResultList, p, i, j, k, G, g, A, B, a, gm, b, gn, startTime1, authentic1, TimeSpent1,
startTime2, authentic2, TimeSpent2, startTime3, pirated, TimeSpent3,AliceSum, BobSum, AdversarySum,AliceAverage, BobAverage, AdversaryAverage,
AliceResultLists, BobResultLists, AdversaryResultLists, resultLists;

	AdversaryResultLists := [];
	AliceResultLists := [];
	BobResultLists := [];
	resultLists := [];
	
	for p in primes do
	
		Print(p);Print("\n");
		AdversaryResultList := [];
		AliceResultList:= [];
		BobResultList := [];
		Print(Runtime());Print("\n");
		
		for i in [1..trials] do
		
			G := groupGenerator(p);
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
			

			#Print("gm\n");
			#Print(gm);
			#Print("\n");
			#Print(a);
			#Print("\n");
			#Print("gn\n");
			#Print(gn);
			#Print("\n");
			#Print(b);
			#Print("\n");
			
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
			Add(AdversaryResultList, TimeSpent3);
			
			if not (authentic1 = pirated) then
				Print("FAIL! adversary got the wrong key\n");
			fi;
			
			#Print(pirated);#Print("\n");
			#Print(authentic1 = pirated);#Print("\n");
		od;
		Print(Runtime());Print("\n");
		
		Add(AdversaryResultLists, AdversaryResultList);
		Add(AliceResultLists, AliceResultList);
		Add(BobResultLists, BobResultList);
		
		AliceSum := 0;
		BobSum := 0;
		AdversarySum := 0;
		for i in [1..trials] do
			AliceSum := AliceSum + AliceResultList[i];
			BobSum := BobSum + BobResultList[i];
			AdversarySum := AdversarySum + AdversaryResultList[i];
		od;
		AliceAverage := AliceSum / 100;
		BobAverage := BobSum / 100;
		AdversaryAverage := AdversarySum / 100;
		
		Print(AliceAverage);
		Print("\n");
		Print(BobAverage);
		Print("\n");
		Print(AdversaryAverage);
		Print("\n");
		Add(resultLists, [AliceResultLists,BobResultLists,AdversaryResultLists]);
		PrintTo(Concatenation(DirectoryAnalysis,"results/",String(p),".g"), [AliceResultLists,BobResultLists,AdversaryResultLists]);
	od;
	# PrintTo(Concatenation(DirectoryAnalysis,filename),resultLists);
end;

protocol([7,11,13,17,23,27]);
