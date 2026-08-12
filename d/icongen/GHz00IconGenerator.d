import std;
T[] readarr(T)(){return readln.chomp.split.map!(x => x.to!(T)).array;}

void main() {
  real r,H,W;
  bool needsBG,needsEdging,needsFG;
  string bgColor,edgeColor,fgColor;
  do{
    writef("%-39s","round:");
    string[] tmp = readarr!string;
    r = tmp.length && tmp.front.isNumeric && tmp.front.to!real == tmp.front.to!real.fabs ? tmp.front.to!real : NaN(0);
  }while(isNaN(r));
  do{
    writef("%-39s","height:");
    string[] tmp = readarr!string;
    H = tmp.length && tmp.front.isNumeric && tmp.front.to!real == tmp.front.to!real.fabs ? tmp.front.to!real : NaN(0);
  }while(isNaN(H));
  do{
    writef("%-39s","width:");
    string[] tmp = readarr!string;
    W = tmp.length && tmp.front.isNumeric && tmp.front.to!real == tmp.front.to!real.fabs ? tmp.front.to!real : NaN(0);
  }while(isNaN(W));
  do{
    writef("%-39s","BG color(HEXCODE, empty if omitting):");
    string[] tmp = readarr!string;
    if(!tmp.length){
      break;
    }else if(match(tmp.front, "^#?(?:[0-9A-Fa-f]{3}|[0-9A-Fa-f]{6})$")){
      bgColor = tmp.front.length == 6 ? tmp.front : tmp.front.length == 3 ? tmp.front : tmp.front[1..$];
      bgColor = '#'~bgColor;
    }
  }while(!bgColor.length);
  do{
    writef("%-39s","edge color(HEXCODE, empty if omitting):");
    string[] tmp = readarr!string;
    if(!tmp.length){
      break;
    }else if(match(tmp.front, "^#?(?:[0-9A-Fa-f]{3}|[0-9A-Fa-f]{6})$")){
      edgeColor = tmp.front.length == 6 ? tmp.front : tmp.front.length == 3 ? tmp.front : tmp.front[1..$];
      edgeColor = '#'~edgeColor;
    }
  }while(!edgeColor.length);
  do{
    writef("%-39s","FG color(HEXCODE, empty if omitting):");
    string[] tmp = readarr!string;
    if(!tmp.length){
      break;
    }else if(match(tmp.front, "^#?(?:[0-9A-Fa-f]{3}|[0-9A-Fa-f]{6})$")){
      fgColor = tmp.front.length == 6 ? tmp.front : tmp.front.length == 3 ? tmp.front : tmp.front[1..$];
      fgColor = '#'~fgColor;
    }
  }while(!fgColor.length);


  writeln("\n\n\n");
  
  iconGenerator(r,H,W,bgColor,edgeColor,fgColor).writeln;

}

string iconGenerator(
                  const real r,
                  const real H,
                  const real W,
                  const string bgColor,
                  const string edgeColor,
                  const string fgColor
                )
{
  if( !bgColor && !edgeColor && !fgColor ){
    return "What do you want???????";
  }

  const real  k = 4.0L*(2.0L.sqrt - 1)/3.0L,
              h = H/256.0L,
              w = W/256.0L;

  auto S =  [i"<\?xml version=\"1.0\" standalone=\"no\"\?>".text] ~
            [i"<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" \"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">".text] ~
            [i"<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"$(W)\" height=\"$(H)\" viewBox=\"0 0 $(W) $(H)\">".text];
  
  if(bgColor){
    S ~=  [i"  <path d=\"".text] ~
          [i"    M0 0".text] ~
          [i"    H$(W)".text] ~
          [i"    V$(H)".text] ~
          [i"    H0".text] ~
          [i"    V0".text] ~
          [i"  \" stroke-width=\"0\" fill=\"$(bgColor)\"/>".text];
  }
  if(edgeColor){
    S ~=  [i"  <path d=\"".text] ~
          [i"    M$(w*92),$(h*36) H$(w*23+r*2.0L)".text] ~
          [i"    A$(w*r*2.0L),$(h*r*2.0L) 0 0 0 $(w*23),$(h*(36+r*2.0L))".text] ~
          [i"    V$(h*(55+20/(2.0L.sqrt)-r*tan(PI/8.0L)*4.0L))".text] ~
          //[i"    Q$(w*23),$(h*(55+20/(2.0L.sqrt))) $(w*(33-10/(2.0L.sqrt))),$(h*(65+10/(2.0L.sqrt)))".text] ~
          [i"    A$(w*r*4.0L),$(h*r*4.0L) 0 0 0 $(w*(23+r*4.0L*tan(PI/8.0L)*cos(PI/4.0L))),$(h*(55+20/(2.0L.sqrt)+r*4.0L*tan(PI/8.0L)*cos(PI/4.0L)))".text] ~
          //[i"    L$(w*(92-20/(2.0L.sqrt))),$(h*124)".text] ~
          [i"    L$(w*(82-r*4.0L*tan(PI/8.0L)*cos(PI/4.0L))),$(h*(114+20/(2.0L.sqrt)-r*4.0L*tan(PI/8.0L)*cos(PI/4.0L)))".text] ~
          [i"    A$(w*r*4.0L),$(h*r*4.0L) 0 0 1 $(w*82),$(h*(114+20/(2.0L.sqrt)+r*tan(PI/8.0L)*4.0L))".text] ~
          [i"    V$(h*(226-r*2.0L))".text] ~
          [i"    A$(w*r*2.0L),$(h*r*2.0L) 0 0 0 $(w*(82+r*2.0L)),$(h*226)".text] ~
          [i"    H$(w*221-r*2.0L)".text] ~
          [i"    A$(w*r*2.0L),$(h*r*2.0L) 0 0 0 $(w*221),$(h*(226-r*2.0L))".text] ~
          [i"    V$(h*(36+r*2.0L))".text] ~
          [i"    A$(w*r*2.0L),$(h*r*2.0L) 0 0 0 $(w*(221-r*2.0L)),$(h*36)".text] ~
          [i"    H$(w*92)".text] ~
          [i"\" stroke-width=\"0\" fill=\"$(edgeColor)\"/>".text];
  }
  if(fgColor){
    S ~=  [i"  <path d=\"".text] ~
          [i"    M$(w*(33+r)),$(h*46) A$(w*r),$(h*r) 0 0 0 $(w*33),$(h*(46+r))".text] ~
          [i"    V$(h*(65-r*tan(PI/8.0L)*2.0L))".text] ~
          [i"    A$(w*r*2.0L),$(h*r*2.0L) 0 0 0 $(w*(33+r*2.0L*tan(PI/8.0L)*cos(PI/4.0L))),$(h*(65+r*2.0L*(tan(PI/8.0L)*cos(PI/4.0L))))".text] ~
          [i"    L$(w*(92-r*2.0L*(tan(PI/8.0L)*cos(PI/4.0L)))),$(h*(124-r*2.0L*(tan(PI/8.0L)*cos(PI/4.0L))))".text] ~
          [i"    A$(w*r*2.0L),$(h*r*2.0L) 0 0 1 $(w*92),$(h*(124+r*2.0L*tan(PI/8.0L)))".text] ~
          [i"    V$(h*(216-r))".text] ~
          [i"    A$(w*r),$(h*r) 0 0 0 $(w*(92+r)),$(h*216)".text] ~
          [i"    H$(w*(111-r))".text] ~
          [i"    A$(w*r),$(h*r) 0 0 0 $(w*111),$(h*(216-r))".text] ~
          [i"    V$(h*(124+r*2.0L*tan(PI/8.0L)))".text] ~
          [i"    A$(w*r*2.0L),$(h*r*2.0L) 0 0 1 $(w*(111+r*2.0L*(tan(PI/8.0L)*cos(PI/4.0L)))),$(h*(124-r*2.0L*(tan(PI/8.0L)*cos(PI/4.0L))))".text] ~
          [i"    L$(w*(170-r*2.0L*(tan(PI/8.0L)*cos(PI/4.0L)))),$(h*(65+r*2.0L*(tan(PI/8.0L)*cos(PI/4.0L))))".text] ~
          [i"    A$(w*r*2.0L),$(h*r*2.0L) 0 0 0 $(w*170),$(h*(65-r*2.0L*tan(PI/8.0L)))".text] ~
          [i"    V$(h*(46+r))".text] ~
          [i"    A$(w*r),$(h*r) 0 0 0 $(w*(170-r)),$(h*46)".text] ~
          [i"    H$(w*(33+r))".text] ~
          [i"    ".text] ~
          [i"    M$(w*(33+19*(2.0L.sqrt)+r/2.0L/tan(PI/8.0L))),$(h*65) A$(w*r/2.0L),$(h*r/2.0L) 0 0 0 $(w*(33+19*(2.0L.sqrt)+r/2.0L*cos(PI/4.0L)/tan(PI/8.0L))),$(h*(65+r/2.0L*cos(PI/4.0L)/tan(PI/8.0L)))".text] ~
          [i"    L$(w*(92-r/2.0L*cos(PI/4.0L)/tan(PI/8.0L))),$(h*(124-19*(2.0L.sqrt)-r/2.0L*cos(PI/4.0L)/tan(PI/8.0L)))".text] ~
          [i"    A$(w*r/2.0L),$(h*r/2.0L) 0 0 0 $(w*92),$(h*(124-19*(2.0L.sqrt)-r/2.0L/tan(PI/8.0L)))".text] ~
          [i"    V$(h*(65+r))".text] ~
          [i"    A$(w*r),$(h*r) 0 0 0 $(w*(92-r)),$(h*65)".text] ~
          [i"    H$(w*(33+19*(2.0L.sqrt)+r/2.0L/tan(PI/8.0L)))".text] ~
          [i"    ".text] ~
          [i"    M$(w*(111+r)),$(h*65) A$(w*r),$(h*r) 0 0 0 $(w*111),$(h*(65+r))".text] ~
          [i"    V$(h*(124-19*(2.0L.sqrt)-r/2.0L/tan(PI/8.0L)))".text] ~
          [i"    A$(w*r/2.0L),$(h*r/2.0L) 0 0 0 $(w*(111+r/2.0L*cos(PI/4.0L)/tan(PI/8.0L))),$(h*(124-19*(2.0L.sqrt)-r/2.0L*cos(PI/4.0L)/tan(PI/8.0L)))".text] ~
          [i"    L$(w*(170-19*(2.0L.sqrt)-r/2.0L*cos(PI/4.0L)/tan(PI/8.0L))),$(h*(65+r/2.0L*cos(PI/4.0L)/tan(PI/8.0L)))".text] ~
          [i"    A$(w*r/2.0L),$(h*r/2.0L) 0 0 0 $(w*(170-19*(2.0L.sqrt)-r/2.0L/tan(PI/8.0L))),$(h*65)".text] ~
          [i"    H$(w*(111+r))".text] ~
          [i"    ".text] ~
          [i"    ".text] ~
          [i"    M$(w*(136+r)),$(h*124) A$(w*r),$(h*r) 0 0 0 $(w*136),$(h*(124+r))".text] ~
          [i"    V$(h*(216-r))".text] ~
          [i"    A$(w*r),$(h*r) 0 0 0 $(w*(136+r)),$(h*216)".text] ~
          [i"    H$(w*(151-r))".text] ~
          [i"    A$(w*r),$(h*r) 0 0 0 $(w*151),$(h*(216-r))".text] ~
          [i"    V$(h*(124+r))".text] ~
          [i"    A$(w*r),$(h*r) 0 0 0 $(w*(151-r)),$(h*124)".text] ~
          [i"    H$(w*(136+r))".text] ~
          [i"    ".text] ~
          [i"    ".text] ~
          [i"    M$(w*(166+r)),$(h*94) A$(w*r),$(h*r) 0 0 0 $(w*166),$(h*(94+r))".text] ~
          [i"    V$(h*(216-r))".text] ~
          [i"    A$(w*r),$(h*r) 0 0 0 $(w*(166+r)),$(h*216)".text] ~
          [i"    H$(w*(181-r))".text] ~
          [i"    A$(w*r),$(h*r) 0 0 0 $(w*181),$(h*(216-r))".text] ~
          [i"    V$(h*(94+r))".text] ~
          [i"    A$(w*r),$(h*r) 0 0 0 $(w*(181-r)),$(h*94)".text] ~
          [i"    H$(w*(166+r))".text] ~
          [i"    ".text] ~
          [i"    ".text] ~
          [i"    M$(w*(196+r)),$(h*46) A$(w*r),$(h*r) 0 0 0 $(w*196),$(h*(46+r))".text] ~
          [i"    V$(h*(216-r))".text] ~
          [i"    A$(w*r),$(h*r) 0 0 0 $(w*(196+r)),$(h*216)".text] ~
          [i"    H$(w*(211-r))".text] ~
          [i"    A$(w*r),$(h*r) 0 0 0 $(w*211),$(h*(216-r))".text] ~
          [i"    V$(h*(46+r))".text] ~
          [i"    A$(w*r),$(h*r) 0 0 0 $(w*(211-r)),$(h*46)".text] ~
          [i"    H$(w*(196+r))".text] ~
          [i"  \" stroke-width=\"0\" fill=\"$(fgColor)\" fill-rule=\"evenodd\" />".text];
    }
    S ~= [i"</svg>".text];
  return S.join('\n');
}


