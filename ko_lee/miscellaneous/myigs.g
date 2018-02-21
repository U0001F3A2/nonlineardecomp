myigs := function(igs,gens)
	local coll, rels, todo, n, ind, g, d, h, k, eg, eh, e, f, c, i, l;

    if Length( gens ) = 0 then return igs; fi;

    # get information
    coll := Collector( gens[1] );
    rels := RelativeOrders( coll );
    n    := NumberOfGenerators( coll );

    # create new list from igs
    ind  := ListWithIdenticalEntries(n, false );
    for g in igs do ind[Depth(g)] := g; od;
	Print("ind: ",ind,"\n");

    # set counter and add tail as far as possible
    c := UpdateCounter( ind, gens, n+1 );
	Print("c: ",c,"\n");

    # create a to-do list and a pointer
    todo := Set( Filtered( gens, x -> Depth( x ) < c ) );
	Print("todo: ", todo,"\n");

    # loop over to-do list until it is empty
    while Length( todo ) > 0 and c > 1 do

        g := Remove( todo );
        d := Depth( g );
        f := [];

        # shift g into ind
        while d < c do
            h := ind[d];
			Print("h: ", h,"\n");
            if not IsBool( h ) then

                # reduce g with h
                eg := LeadingExponent( g );
                eh := LeadingExponent( h );
                e  := Gcdex( eg, eh );
				Print("e: ", e,"\n");

                # adjust ind[d] by gcd
                ind[d] := (g^e.coeff1) * (h^e.coeff2);
                if e.coeff1 <> 0 then Add( f, d ); fi;

                # adjust g
                g := (g^e.coeff3) * (h^e.coeff4);
				Print("g: ", g,"\n");
            else

                # just add g into ind
                ind[d] := g;
                g := g^0;
                Add( f, d );
            fi;
            d := Depth( g );
            c := UpdateCounter( ind, todo, c );
			Print("c after update: ",c,"\n");
        od;
		Print("ffffffffffffffffffff: ", f, "\n");
        # now add powers and commutators
        for d in f do
            g := ind[d];
            if d <= Length( rels ) and rels[d] > 0 and d < c then
                k := g ^ RelativeOrderPcp( g );
                if Depth(k) < c then  Add( todo, k ); fi;
            fi;
            for l in [1..n] do
                if not IsBool( ind[l] ) and ( d < c  or l < c ) then
                    k := Comm( g, ind[l] );
                    if Depth(k) < c then  Add( todo, k ); fi;
                fi;
            od;
        od;

        # try sorting
        Sort( todo );

    od;

    # return resulting list
	Print(Filtered( ind, x -> not IsBool( x ) ));
    return Filtered( ind, x -> not IsBool( x ) );
end;

G := BurdeGrunewaldPcpGroup(0, 13);
gens := [G.1*G.2, G.1^G.6, G.3*G.4^G.5, G.11];
Print(gens,"\n");
igs := myigs([],gens);
