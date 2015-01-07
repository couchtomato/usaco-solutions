const
  chg:array[1..4]of longint=(%111111,%101010,%010101,%001001);
  var
    lim,n,c,ct,bit:longint;
	knn:array[0..7]of longint;
	ans:array[0..2000]of string;
	procedure init;
	  var
	    i,a:longint;
	  begin {0=not determined; 1=not lit 2=lit}
	  randomize;
	       read(n,c);a:=0;read(A);
		   while a<>-1 do
		     begin
                            if a mod 6<>0 then
                              knn[a mod 6]:=2
                              else knn[6]:=2;
			    read(a);
			 end;
		  a:=0; read(a);
		  while a<>-1 do
		    begin
                      if a mod 6<>0 then knn[a mod 6]:=1
                      else knn[6]:=1;
			     read(a);
			end;
		if n<7 then begin lim:=1 shl n-1;bit:=n;end
		else begin lim:=1 shl 6-1;bit:=6;end;
	  end;
        function rev(i:longint):string;
          var
            k:string;x:longint;
          begin
             //str(i,k);
             k:='';
               for x:=1 to bit do
               begin
                  k:=k+chr(i and 1+48);
                  i:=i shr 1;
               end;
             {rev:=k;
             for x:=1 to length(k)do
               rev[x]:=k[length(k)-x+1];}
               exit(k);
          end;
	procedure chk(status:longint);
	  var
	    i,j:longint;
	  begin
	         i:=status;
			 for j:=1 to bit do
			   begin
			       if knn[j]=1 then
				     if i and 1=1 then
					   exit;
					if knn[j]=2 then
					  if i and 1=0 then
					    exit;
					i:=i shr 1;
			   end;
			   inc(ct);ans[ct]:=rev(status);
	  end;
	procedure search(dep,chd,status:longint);
	  begin
               status:=status and lim;
	       if dep=5 then
		     begin  //writeln(rev(status),' ',chd);
			    if (chd<=c)and(chd and 1=c and 1) then
                            chk(status);
			 end
			 else
			   begin
			       search(dep+1,chd,status);
                               if (dep<=4)and(dep>0) then
				   search(dep+1,chd+1,status xor chg[dep]);
			   end;
	  end;
	procedure qsort(l,r:longint);
	  var
	    i,j:longint; x,y:string;
	  begin
	     i:=random(r-l)+l;
		 x:=ans[i];
		 i:=l;j:=r;
		 repeat
		    while ans[i]<x do inc(i);
			while ans[j]>x do dec(j);
			if not(i>j)then
			  begin
			       y:=ans[i];ans[i]:=ans[j];ans[j]:=y;
				   inc(i);dec(j);
			  end;
		 until i>=j;
		 if j>l then qsort(l,j);
		 if i<r then qsort(i,r);
	  end;
	procedure wt(i:longint);
	   var
	     k:string;x:longint;
	   begin
	       {str(i,k);}
               k:=ans[i];write(k);x:=n-length(k);
		   while x>=length(k)do
		      begin write(k);dec(x,length(k));end;
		   for i:=1 to x do
		     write(k[i]);
			 writeln;
		
	   end;
	procedure prn;
	  var
	    i:longint;
	  begin
	    if ct=0 then
		  begin writeln('IMPOSSIBLE');end
		  else begin
	           qsort(1,ct);
			   for i:=1 to ct do
			     if ans[i]<>ans[i-1]then
				   wt(i);
			 end;
	  end;
	  begin
	  assign(input,'lamps.in');reset(input);
	  assign(output,'lamps.out');rewrite(output);
	        init;
			search(0,0,lim);
			prn;
close(input);close(output);
	  end.
