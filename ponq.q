/ Up    = uU
/ Down  = jJ
/ Quit  = qQ

if[.z.o<>`l64; '"Can only run on Linux"; exit 1];

WINNINGSCORE:21;
VELOCITY0:1;

sball:{[x;y;w;h;dx;dy]  `x`y`w`h`dx`dy!(x;y;w;h;dx;dy)};
spaddle:{[x;y;w;h]      `x`y`w`h!(x;y;w;h)};
score:0 0;
buffer:"";
clear::system"clear";
movemode:1b;

init:{[]
  ball::sball[screen[`w] div 2; screen[`h] div 2; 10; 10; 1; 1];
  paddles::spaddle'[]
 };

move:{};

upd:{[]
  s:`c`l!getScreenInfo[];
  d:checkBuffer[];
  if[d>0;move d];
  /
  };

render:{};

printScreen:{

  };

getScreenInfo:{"J"$raze system'[("tput cols";"tput lines")]};
checkBuffer:{[]
  b:buffer inter "\" \"q\n"
  if["q" in b; exit 0];
  steps:{$[" "=x; [movemode::not movemode;0]; 1 -1@ movemode]} each buffer;
  buffer::"";
 };

.z.ts:{
  s:getScreenInfo[];
  d:checkBuffer[];
  upd[];
  render[];
 };

.z.pi:{[c] buffer,:c};
