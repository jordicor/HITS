//---------------------------------------------------------------------------
//
// Programa: Hits
// Fecha inicio: 6/5/2000 Fecha fin: 5/6/2000
// Programador/es: Jordi Corrales Jim‚nez & ?
//
//---------------------------------------------------------------------------


PROGRAM HITS;

CONST
tiempo=99;

GLOBAL
el;
fondo;
pulsado;
pulsado2;
elegido;
salte;
id_jug;
id_jug2;
elige[1];
coord[1];
equis[1];
igriega[1];
me_muro[1];
dar[1];
recibir[1];
victorias[1];
x_jug[1];
gana[2];
ya;
dfiendo;
contador=1;
txt_tiempo;
tutupa;
j;

PRIVATE
i;

BEGIN
 load_pal("\HITS\CONTRAP.MAP");
 fondo=load_map("\HITS\CONTRAP.MAP");
 set_mode(m1024x768);
 put_screen(0,fondo);
 WHILE (!scan_code)
  FRAME;
 END
 LOOP
  load_pal("HITS\SELECT.FPG");
  load_fpg("\HITS\SELECT.FPG");
  dar[0]=load_pcm("\HITS\ATACA.PCM",0);
  dar[1]=load_pcm("\HITS\ATACA2.PCM",0);
  recibir[0]=load_pcm("\HITS\IMPACTA.PCM",0);
  recibir[1]=load_pcm("\HITS\IMPACTA2.PCM",0);
  dfiendo=load_pcm("\HITS\DFENSA.PCM",0);
  gana[0]=load_pcm("\HITS\GANA1.PCM",0);
  gana[1]=load_pcm("\HITS\GANA2.PCM",0);
  gana[2]=load_pcm("\HITS\EMPATE.PCM",0);
  tutupa=load_pcm("\HITS\TUTUPA.PCM",0);
  set_mode(m640x480);
  set_fps(10,0);
  elegido=0; salte=0; victorias[0]=0; victorias[1]=0; ya=0;
  delete_draw(all_drawing);
  delete_text(all_text);
  E_jug(160,320,0);
  E_jug(480,320,1);
  el=rand(0,1);
  if (!el) el=6; end
  put_screen(0,el);
  el=rand(0,1);
  if(el)
   load_song("D:\DIV2\MOD\HITS\JONAS08.S3M",1);
  else
   load_song("D:\DIV2\MOD\HITS\JONAS11.S3M",1);
  end
  song(0);
  LOOP

   if(elegido) contador=tiempo-timer[0]/100; end

   FRAME;

   if(elegido)
    if(abs(equis[0]-10)=>400||abs(equis[1]-1014)=>400) salte=1; end
   end

   IF (key(_enter)&!elegido);
    elegido=1;
    unload_fpg(0);
    let_me_alone();
    load_fpg("\HITS\FONDOS.FPG");
    load_pal("\HITS\CROWDAT.FPG");
    load_fnt("\HITS\HITS.FNT");
    delete_draw(all_drawing);
    delete_text(all_text);
    FOR (i=0; i<2; i++)
     SWITCH (elige[i])
      CASE 1:
       load_fpg("\HITS\CROWDAT.FPG");
       coord[i]=620;
       if (!i)
        write(1,20,100,3,"CrowDat");
       else
        write(1,1010,100,5,"CrowDat");
       end
      END
      CASE 2:
       load_fpg("\HITS\JONAS.FPG");
       coord[i]=600;
       if (!i)
        write(1,20,100,3,"Jonas");
       else
        write(1,1010,100,5,"Jonas");
       end
      END
      CASE 3:
       load_fpg("\HITS\P_J.FPG");
       coord[i]=620;
       if (!i)
        write(1,20,100,3,"P.J.");
       else
        write(1,1010,100,5,"P.J.");
       end
      END
      CASE 4:
       load_fpg("\HITS\HAIR_DO.FPG");
       coord[i]=620;
       if (!i)
        write(1,20,100,3,"Hair-Do");
       else
        write(1,1010,100,5,"Hair-Do");
       end
      END
     END
    END
    set_mode(m1024x768);
    set_fps(20,0);
    id_jug=Jug(350,coord[0]);
    id_jug2=Jug2(650,coord[1]);
    put_screen(0,1);
    unload_song(0);
    el=rand(0,1);
    if(el)
     load_song("D:\DIV2\MOD\HITS\MOD.S3M",1);
    else
     load_song("D:\DIV2\MOD\HITS\HMM.S3M",1);
    end
    song(0);
    ko(); barras();
    timer[0]=0; equis[0]=10; equis[1]=1014;
    write_int(1,512,125,4,&contador);
    ya=1;
   END

   if(salte)
    if(equis[0]-10==400)
     victorias[1]++; cara(victorias[1],2);
    else
     victorias[0]++; cara(victorias[0],1);
    end
    signal(id_jug,s_freeze); signal(id_jug2,s_freeze);
    for(j=0; j<15; j++)
     sound(tutupa,256,256);
    end
    timer[1]=0;
    while(timer[1]<100)
     FRAME;
    end
    signal(id_jug,s_wakeup); signal(id_jug2,s_wakeup);
    if(victorias[0]==2||victorias[1]==2)
     salte=1;
    else
     salte=0; ya=0; x_jug[0]=id_jug.x; x_jug[1]=id_jug2.x;
     signal(id_jug,s_kill);
     signal(id_jug2,s_kill);
     signal(TYPE ko,s_kill);
     delete_draw(all_drawing);
     timer[0]=0; equis[0]=10; equis[1]=1014;
     barras(); ko();
     write_int(1,512,125,4,&contador);
     id_jug=Jug(x_jug[0],coord[0]);
     id_jug2=Jug2(x_jug[1],coord[1]);
     ya=1;
    end
   end

   if (key(_ESC)||contador<=0||salte)
    stop_song(); unload_song(0); FRAME(200);
    if(contador<=0||salte)
     signal(id_jug,s_freeze); signal(id_jug2,s_freeze);
     if(abs(equis[0]-10)<abs(equis[1]-1014))
      write(1,512,384,4,"Gana el jugador 1");
      for(j=0; j<5; j++)
       sound(gana[0],256,256);
      end
     else
      if(abs(equis[0]-10)>abs(equis[1]-1014))
       write(1,512,384,4,"Gana el jugador 2");
       for(j=0; j<5; j++)
        sound(gana[1],256,256);
       end
      else
       write(1,512,384,4,"EMPATE");
       for(j=0; j<5; j++)
        sound(gana[2],256,256);
       end
      end
     end
     timer[1]=0;
     while(timer[1]<300)
      FRAME;
     end
    end
    if (elegido)
     unload_fpg(0); unload_fpg(1); unload_fpg(2);
     let_me_alone();
     contador=1;
    end
    break;
   end
  END
  if (!elegido) break; end
 END

 let_me_alone();

 load_pal("\HITS\PORTADA.MAP");
 fondo=load_map("\HITS\PORTADA.MAP");
 set_mode(m1024x768);
 put_screen(0,fondo);
 WHILE (!scan_code)
  FRAME;
 END

END

//---------------------------------------------------------------------------
// Proceso para poner al jugador en pantalla
//---------------------------------------------------------------------------


PROCESS Jug(x,y);

BEGIN
 file=1; graph=1;
 LOOP

if(ya)
 if (key(_k))
  if(id_jug2.graph)
   graph=1; x+=10; if (x>920) x=920; end
   if (abs(id_jug.x-id_jug2.x)<=100) x=id_jug2.x-100; end
  end
 else
  if (key(_j))
   if(pulsado2&&id_jug2.graph<>1)
    graph=8;
    if(elige[0]==4) y=700; end
    frame(200);
   else
    y=coord[0]; graph=1; x-=10; if (x<105) x=105; end
    if (abs(id_jug.x-id_jug2.x)<=100) x=id_jug2.x-100; end
   end
  end
 end
end

if(key(_a)||key(_s)||key(_d)||key(_z)||key(_x)||key(_c))
 if(!pulsado)
  pulsado=1;
  el=rand(0,1);
  for(j=0; j<10; j++)
   sound(dar[el],256,256);
  end

  if(key(_a))
   graph=2;
   SWITCH (elige[0]);
    CASE 3: y=650; END
   END
  end

  if(key(_s))
   graph=3;
   SWITCH (elige[0]);
    CASE 3: y=650; END
   END
  end

  if(key(_d))
   graph=4;
   SWITCH (elige[0]);
    CASE 3: y=660; END
   END
  end

  if(key(_z))
   graph=5;
   SWITCH (elige[0]);
    CASE 3: y=635; END
    CASE 4: y=630; END
   END
  end

  if(key(_x))
   graph=6;
   SWITCH (elige[0]);
    CASE 4: y=630; END
   END
  end

  if(key(_c))
   graph=7;
  end

  FRAME(275);
  graph=1;
  y=coord[0];

 end
else
 if(smallbro<>0)
  if(collision(type jug2)&&pulsado2&&id_jug2.graph<>1)
   if(graph<>8)
    graph=9;
    el=rand(0,1);
    for(j=0; j<10; j++);
     sound(recibir[el],256,256);
    end
    frame(250);
    graph=1; equis[0]+=10;
    if (equis[0]>20) delete_draw(me_muro[0]); end
    me_muro[0]=draw(3,15,10,0,10,30,equis[0],70);
    if (abs(id_jug.x-id_jug2.x)<=200)
     x-=50; id_jug2.x+=50;
     if (x<105) x=105; id_jug2.x+=30; end
     if (id_jug2.x>920) id_jug2.x=920; end
    end
   else
    for(j=0; j<10; j++);
     sound(dfiendo,256,256);
    end
   end
  end
 end
 pulsado=0;
end


  FRAME;


 END
END

//---------------------------------------------------------------------------
// Proceso para poner al jugador en pantalla
//---------------------------------------------------------------------------


PROCESS Jug2(x,y);

BEGIN
 graph=1; flags=1; file=2;
 LOOP

if(ya)
 if (key(_right))
  if(pulsado&&id_jug.graph<>1)
   graph=8;
   if(elige[1]==4) y=700; end
   frame(200);
  else
   y=coord[1]; graph=1; x+=10; if (x>920) x=920; end
   if (abs(id_jug.x-id_jug2.x)<=100) x=id_jug.x+100; end
  end
 else
  if (key(_left))
   if(id_jug.graph)
    graph=1; x-=10; if (x<20) x=20; end
    if (abs(id_jug.x-id_jug2.x)<=100) x=id_jug.x+100; end
   end
  end
 end
end

if(key(_ins)||key(_home)||key(_pgup)||key(_del)||key(_end)||key(_pgdn))
 if(!pulsado2)
  pulsado2=1;
  el=rand(0,1);
  for(j=0; j<10; j++)
   sound(dar[el],256,256);
  end

  if(key(_ins))
   graph=2;
   SWITCH (elige[1]);
    CASE 3: y=650; END
   END
  end

  if(key(_home))
   graph=3;
   SWITCH (elige[1]);
    CASE 3: y=650; END
   END
  end

  if(key(_pgup))
   graph=4;
   SWITCH (elige[1]);
    CASE 3: y=660; END
   END
  end

  if(key(_del))
   graph=5;
   SWITCH (elige[1]);
    CASE 3: y=635; END
    CASE 4: y=630; END
   END
  end

  if(key(_end))
   graph=6;
   SWITCH (elige[1]);
    CASE 4: y=630; END
   END
  end

  if(key(_pgdn))
   graph=7;
  end

  FRAME(275);
  graph=1;
  y=coord[1];

 end
else
 if(collision(type jug)&&pulsado&&id_jug.graph<>1)
  if(graph<>8)
   graph=9;
   el=rand(0,1);
   for(j=0; j<10; j++)
    sound(recibir[el],256,256);
   end
   frame(250);
   graph=1; equis[1]-=10;
   if( equis[1]<1004) delete_draw(me_muro[1]); end
   me_muro[1]=draw(3,15,10,0,1014,30,equis[1],70);
   if (abs(id_jug.x-id_jug2.x)<=200)
    x+=50; id_jug.x-=50;
    if (x>920) x=920; id_jug.x+=30; end
    if (id_jug.x<105) id_jug.x=105; end
   end
  else
   for(j=0; j<10; j++);
    sound(dfiendo,256,256);
   end
  end
 end
 pulsado2=0;
end


  FRAME;

 END
END

//---------------------------------------------------------------------------
// Proceso para elegir jugador
//---------------------------------------------------------------------------


PROCESS E_Jug(x,y,flags);

PRIVATE
banderas;

BEGIN
banderas=flags;
graph=2;
elige[banderas]=1;

LOOP

IF (banderas==0);

 if (key(_j)) graph--;
  if (graph<2) graph=5; end
  elige[banderas]--; if (elige[banderas]==0) elige[banderas]=4; end
 end

 if (key(_k)) graph++;
  if (graph>5) graph=2; end
  elige[banderas]++; if (elige[banderas]==5) elige[banderas]=1; end
 end

else

 if (key(_left)) graph--;
  if (graph<2) graph=5; end
  elige[banderas]--; if (elige[banderas]==0) elige[banderas]=4; end
 end

 if (key(_right)) graph++;
  if (graph>5) graph=2; end
  elige[banderas]++; if (elige[banderas]==5) elige[banderas]=1; end
 end

end

 if (graph==3)
  y=350;
 else
  flags=banderas; y=320;
  if (graph==4 or graph==5)
   flags=flags xor 1;
  end
 end


 FRAME;

END

END


//---------------------------------------------------------------------------
// Proceso para poner letras K.O.
//---------------------------------------------------------------------------


PROCESS KO();

BEGIN

file=0; graph=2; x=512; y=50;

LOOP
 FRAME;
END

END

//---------------------------------------------------------------------------
// Proceso para la cara de pepone
//---------------------------------------------------------------------------


PROCESS cara(victoria,jugador);

BEGIN

file=0; graph=3; y=121; size=75;

if(jugador)
 if(victoria) x=370; else x=270; end
else
 if(victoria) x=670; else x=770; end
end

LOOP
 FRAME;
END

END


//---------------------------------------------------------------------------
// Proceso para dibujar las barras de vida
//---------------------------------------------------------------------------


PROCESS barras();

BEGIN

 draw(2,2,15,0,9,29,411,71); //Jug1
 draw(3,241,10,0,10,30,410,70);

 draw(2,2,15,0,1015,29,613,71); //Jug2
 draw(3,241,10,0,1014,30,614,70);

 draw(3,2,15,0,470,97,552,151); //Tiempo
 draw(3,255,15,0,472,99,550,149);

 FRAME;

END