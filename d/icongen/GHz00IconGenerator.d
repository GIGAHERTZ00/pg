import std;
T[] readarr(T)(){return readln.chomp.split.map!(x => x.to!(T)).array;}

void main() {
  real r,H,W;
  bool needsBG,needsEdging,needsFG;
  string bgColor,edgeColor,fgColor;
  do{
    write("round:              ");
    string[] tmp = readarr!string;
    r = tmp.length && tmp.front.isNumeric && tmp.front.to!real == tmp.front.to!real.fabs ? tmp.front.to!real : NaN(0);
  }while(isNaN(r));
  do{
    write("height:             ");
    string[] tmp = readarr!string;
    H = tmp.length && tmp.front.isNumeric && tmp.front.to!real == tmp.front.to!real.fabs ? tmp.front.to!real : NaN(0);
  }while(isNaN(H));
  do{
    write("width:              ");
    string[] tmp = readarr!string;
    W = tmp.length && tmp.front.isNumeric && tmp.front.to!real == tmp.front.to!real.fabs ? tmp.front.to!real : NaN(0);
  }while(isNaN(W));
  while(true){
    "Need BG?(Y/n):      ".write;
    string[] tmp = readarr!string;
    if(!tmp.length){
      needsBG = true;
      break;
    }if(tmp.front.length == 1 && match(tmp.front.toLower, "[yn]")){
      needsBG = tmp.front.toLower == "y";
      break;
    }
  }if(needsBG){
    do{
      "BG color(HEXCODE):  ".write;
      string[] tmp = readarr!string;
      if(tmp.length &&  match(tmp.front, "^#?(?:[0-9A-Fa-f]{3}|[0-9A-Fa-f]{6})$")){
        bgColor = tmp.front.length == 6 ? tmp.front : tmp.front.length == 3 ? tmp.front : tmp.front[1..$];
        bgColor = '#'~bgColor;
      }
    }while(!bgColor.length);
  }
  while(true){
    "Need edging?(Y/n):  ".write;
    string[] tmp = readarr!string;
    if(!tmp.length){
      needsEdging = true;
      break;
    }if(tmp.front.length == 1 && match(tmp.front.toLower, "[yn]")){
      needsEdging = tmp.front.toLower == "y";
      break;
    }
  }if(needsEdging){
    do{
      "edge color(HEXCODE):".write;
      string[] tmp = readarr!string;
      if(tmp.length &&  match(tmp.front, "^#?(?:[0-9A-Fa-f]{3}|[0-9A-Fa-f]{6})$")){
        edgeColor = tmp.front.length == 6 ? tmp.front : tmp.front.length == 3 ? tmp.front : tmp.front[1..$];
        edgeColor = '#'~edgeColor;
      }
    }while(!edgeColor.length);
  }
  while(true){
    "Need FG?(Y/n):      ".write;
    string[] tmp = readarr!string;
    if(!tmp.length){
      needsFG = true;
      break;
    }if(tmp.front.length == 1 && match(tmp.front.toLower, "[yn]")){
      needsFG = tmp.front.toLower == "y";
      break;
    }
  }if(needsFG){
    do{
      "FG color(HEXCODE):  ".write;
      string[] tmp = readarr!string;
      if(tmp.length &&  match(tmp.front, "^#?(?:[0-9A-Fa-f]{3}|[0-9A-Fa-f]{6})$")){
        fgColor = tmp.front.length == 6 ? tmp.front : tmp.front.length == 3 ? tmp.front : tmp.front[1..$];
        fgColor = '#'~fgColor;
      }
    }while(!fgColor.length);
  }

  writeln("\n\n\n");
  
  iconGenerator(r,H,W,needsBG,bgColor,needsEdging,edgeColor,needsFG,fgColor).writeln;

}

string iconGenerator(
                  const real r,
                  const real H,
                  const real W,
                  const bool needsBG,     const string bgColor,
                  const bool needsEdging, const string edgeColor,
                  const bool needsFG,     const string fgColor
                )
{
  if( !needsBG && !needsEdging && !needsFG ){
    "What do you want to do???????".writeln;
    return "";
  }

  const real  k = 4.0L*(2.0L.sqrt - 1)/3.0L,
              h = H/256.0L,
              w = W/256.0L;

  auto S =  [i"<\?xml version=\"1.0\" standalone=\"no\"\?>".text] ~
            [i"<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" \"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">".text] ~
            [i"<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"$(W)\" height=\"$(H)\" viewBox=\"0 0 $(W) $(H)\">".text];
  
  if(needsBG){
    S ~=  [i"  <path d=\"".text] ~
          [i"    M0 0".text] ~
          [i"    H$(W)".text] ~
          [i"    V$(H)".text] ~
          [i"    H0".text] ~
          [i"    V0".text] ~
          [i"  \" stroke-width=\"0\" fill=\"$(bgColor)\"/>".text];
  }
  if(needsEdging){
    S ~=  [i"  <path d=\"".text] ~
          [i"    M$(w*92),$(h*36) H$(w*33)".text] ~
          [i"    C$(w*(33-10*k)),$(h*36) $(w*23),$(h*(46-10*k)) $(w*23),$(h*46)".text] ~
          [i"    V$(h*65)".text] ~
          [i"    Q$(w*23),$(h*(55+20/(2.0L.sqrt))) $(w*(33-10/(2.0L.sqrt))),$(h*(65+10/(2.0L.sqrt)))".text] ~
          [i"    L$(w*(92-20/(2.0L.sqrt))),$(h*124)".text] ~
          [i"    Q$(w*82),$(h*(114+20/(2.0L.sqrt))) $(w*82),$(h*134)".text] ~
          [i"    V$(h*216)".text] ~
          [i"    C$(w*82),$(h*(216+10*k)) $(w*(92-10*k)),$(h*226) $(w*92),$(h*226)".text] ~
          [i"    H$(w*211)".text] ~
          [i"    C$(w*(211+10*k)),$(h*226) $(w*221),$(h*(216+10*k)) $(w*221),$(h*216)".text] ~
          [i"    V$(h*46)".text] ~
          [i"    C$(w*221),$(h*(46-10*k)) $(w*(211+10*k)),$(h*36) $(w*211),$(h*36)".text] ~
          [i"    H$(w*92)".text] ~
          [i" stroke-width=\"0\"  \" fill=\"$(edgeColor)\"/>".text];
  }
  S ~=  [i"  <path d=\"".text] ~
        [i"    M$(w*(33+r)),$(h*46) C$(w*(33+r-r*k)),$(h*46) $(w*33),$(h*(46+r-r*k)) $(w*33),$(h*(46+r))".text] ~
        [i"    V$(h*(65-r))".text] ~
        [i"    Q$(w*33),$(h*65) $(w*(33+r/(2.0L.sqrt))),$(h*(65+r/(2.0L.sqrt)))".text] ~
        [i"    L$(w*(92-r/(2.0L.sqrt))),$(h*(124-r/(2.0L.sqrt)))".text] ~
        [i"    Q$(w*92),$(h*124) $(w*92),$(h*(124+r))".text] ~
        [i"    V$(h*(216-r))".text] ~
        [i"    C$(w*92),$(h*(216-r+r*k)) $(w*(92+r-r*k)),$(h*216) $(w*(92+r)),$(h*216)".text] ~
        [i"    H$(w*(111-r))".text] ~
        [i"    C$(w*(111-r+r*k)),$(h*216) $(w*111),$(h*(216-r+r*k)) $(w*111),$(h*(216-r))".text] ~
        [i"    V$(h*(124+r))".text] ~
        [i"    Q$(w*111),$(h*124) $(w*(111+r/(2.0L.sqrt))),$(h*(124-r/(2.0L.sqrt)))".text] ~
        [i"    L$(w*(170-r/(2.0L.sqrt))),$(h*(65+r/(2.0L.sqrt)))".text] ~
        [i"    Q$(w*170),$(h*65) $(w*170),$(h*(65-r/(2.0L.sqrt)))".text] ~
        [i"    V$(h*(46+r))".text] ~
        [i"    C$(w*170),$(h*(46+r-r*k)) $(w*(170-r+r*k)),$(h*46) $(w*(170-r)),$(h*46)".text] ~
        [i"    H$(w*(33+r))".text] ~
        [i"    ".text] ~
        [i"    M$(w*(33+19*(2.0L.sqrt)+r)),$(h*65) Q$(w*(33+19*(2.0L.sqrt))),$(h*65) $(w*(33+19*(2.0L.sqrt)+r/(2.0L.sqrt))),$(h*(65+r/(2.0L.sqrt)))".text] ~
        [i"    L$(w*(92-r/(2.0L.sqrt))),$(h*(124-19*(2.0L.sqrt)-r/(2.0L.sqrt)))".text] ~
        [i"    Q$(w*92),$(h*(124-19*(2.0L.sqrt))) $(w*92),$(h*(124-19*(2.0L.sqrt)-r))".text] ~
        [i"    V$(h*(65+r))".text] ~
        [i"    C$(w*92),$(h*(65+r-r*k)) $(w*(92-r+r*k)),$(h*65) $(w*(92-r)),$(h*65)".text] ~
        [i"    H$(w*(33+19*(2.0L.sqrt)+r))".text] ~
        [i"    ".text] ~
        [i"    M$(w*(111+r)),$(h*65) C$(w*(111+r-r*k)),$(h*65) $(w*111),$(h*(65+r-r*k)) $(w*111),$(h*(65+r))".text] ~
        [i"    V$(h*(124-19*(2.0L.sqrt)-r))".text] ~
        [i"    Q$(w*111),$(h*(124-19*(2.0L.sqrt))) $(w*(111+r/(2.0L.sqrt))),$(h*(124-19*(2.0L.sqrt)-r/(2.0L.sqrt)))".text] ~
        [i"    L$(w*(170-19*(2.0L.sqrt)-r/(2.0L.sqrt))),$(h*(65+r/(2.0L.sqrt)))".text] ~
        [i"    Q$(w*(170-19*(2.0L.sqrt))),$(h*65) $(w*(170-19*(2.0L.sqrt)-r)),$(h*65)".text] ~
        [i"    H$(w*(111+r))".text] ~
        [i"    ".text] ~
        [i"    ".text] ~
        [i"    M$(w*(136+r)),$(h*124) C$(w*(136+r-r*k)),$(h*124) $(w*136),$(h*(124+r-r*k)) $(w*136),$(h*(124+r))".text] ~
        [i"    V$(h*(216-r))".text] ~
        [i"    C$(w*136),$(h*(216-r+r*k)) $(w*(136+r-r*k)),$(h*216) $(w*(136+r)),$(h*216)".text] ~
        [i"    H$(w*(151-r))".text] ~
        [i"    C$(w*(151-r+r*k)),$(h*216) $(w*151),$(h*(216-r+r*k)) $(w*151),$(h*(216-r))".text] ~
        [i"    V$(h*(124+r))".text] ~
        [i"    C$(w*151),$(h*(124+r-r*k)) $(w*(151-r+r*k)),$(h*124) $(w*(151-r)),$(h*124)".text] ~
        [i"    H$(w*(136+r))".text] ~
        [i"    ".text] ~
        [i"    ".text] ~
        [i"    M$(w*(166+r)),$(h*94) C$(w*(166+r-r*k)),$(h*94) $(w*166),$(h*(94+r-r*k)) $(w*166),$(h*(94+r))".text] ~
        [i"    V$(h*(216-r))".text] ~
        [i"    C$(w*166),$(h*(216-r+r*k)) $(w*(166+r-r*k)),$(h*216) $(w*(166+r)),$(h*216)".text] ~
        [i"    H$(w*(181-r))".text] ~
        [i"    C$(w*(181-r+r*k)),$(h*216) $(w*181),$(h*(216-r+r*k)) $(w*181),$(h*(216-r))".text] ~
        [i"    V$(h*(94+r))".text] ~
        [i"    C$(w*181),$(h*(94+r-r*k)) $(w*(181-r+r*k)),$(h*94) $(w*(181-r)),$(h*94)".text] ~
        [i"    H$(w*(166+r))".text] ~
        [i"    ".text] ~
        [i"    ".text] ~
        [i"    M$(w*(196+r)),$(h*46) C$(w*(196+r-r*k)),$(h*46) $(w*196),$(h*(46+r-r*k)) $(w*196),$(h*(46+r))".text] ~
        [i"    V$(h*(216-r))".text] ~
        [i"    C$(w*196),$(h*(216-r+r*k)) $(w*(196+r-r*k)),$(h*216) $(w*(196+r)),$(h*216)".text] ~
        [i"    H$(w*(211-r))".text] ~
        [i"    C$(w*(211-r+r*k)),$(h*216) $(w*211),$(h*(216-r+r*k)) $(w*211),$(h*(216-r))".text] ~
        [i"    V$(h*(46+r))".text] ~
        [i"    C$(w*211),$(h*(46+r-r*k)) $(w*(211-r+r*k)),$(h*46) $(w*(211-r)),$(h*46)".text] ~
        [i"    H$(w*(196+r))".text] ~
        [i"  \" stroke-width=\"0\" fill=\"$(fgColor)\" fill-rule=\"evenodd\" />".text] ~
        [i"</svg>".text];
  return S.join('\n');
}
