/ Pong implemented in Q
/ Requires Linux system calls to show correct screen

/ Up    = uU
/ Down  = jJ
/ Quit  = qQ

if[.z.o<>`l64; '"Can only run on Linux"; exit 1];

getScreenInfo:{("J"$raze system'[("tput cols";"tput lines")]) div 2};

WINNINGSCORE:21;
VELOCITY0:0 1;
BALLPOSITION0:0 0;
BALL:"O";
RACKETLENGTH:10;
RACKETPOSITION0:0;

sball:{[p;v] `p`v!(p;v)};
sracket:{[y;l] `y`l!(y;l)};
score:0 0;
buffer:"";
movemode:1b;

init:{[]
  ball::sball[BALLPOSITION0; VELOCITY0];
  rackets::sracket'[0 0;RACKETLENGTH]
 };


clearAndResize:{[w;h] system"c ",.Q.s1 3+h,w; -1 system"clear";};

upd:{[]
  ball[`p]+:ball[`v];
 };

render:{[w;h]
  clearAndResize[w;h];
  background:(h;w)#" ";
  ballpos:ball[`p] + (h;w) div 2;
  racketpos:rackets[`y] + h div 2;
  racketCoords:(h div 2)+rackets[`y]+\:til'[RACKETLENGTH] - RACKETLENGTH div 2;
  b1:.[background;ballpos;:;BALL];
  b2:./[b1;((racketCoords 0;0);(racketCoords 1;w-1));:;"#"];
  -1 "\n" sv b2;
 };

checkBuffer:{[]
  b:buffer inter "\" \"q\n";
  if[not count b;:(::)];
  if["q" in b; exit 0];
  steps:{$[" "=x; [movemode::not movemode;0]; 1 -1@movemode]} each buffer;
  buffer::"";
  rackets[1;`y]+:sum steps;
 };

checkCollision:{[w]
  wrel:w div 2;
  if[ball[`p;1] in (neg wrel;wrel);
    if[ball[`p;0] within (rackets[`y]+\:{(neg x;x)}RACKETLENGTH div 2)@(neg wrel;wrel)?ball[`p;1];
      ball[`v]*:-1;
      :0b
    ];
    score+:(0 1;1 0) (neg wrel;wrel)?ball[`p;1];
    init[];
    :1b;
  ];
  :0b;
  };

.z.ts:{
  s:getScreenInfo[];
  d:checkBuffer[];
  upd[];
  if[checkCollision[s 0];:(::)];
  render[s 0;s 1];
 };

.z.pi:{[c] buffer,:c};

if[not system"t";system"t 100"];
init[];

if[`debug in key .Q.opt .z.x;
  system"x .z.pi";
  system"t 0"];
