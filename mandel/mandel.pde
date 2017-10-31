// mandel
cell[][] c;
int step=1;
double targetX=0.0, targetY=0.0,targetWidth=4.0;
int limitCnt = 100;
int ms=0;
int xsize=400;
int ysize=400;
int margine=200;

void setup(){
  
  size(100,100);
  surface.setResizable(true);
  surface.setSize(xsize+margine, ysize);
  surface.setResizable(false);

  step = 4;

  noStroke();
  colorMode(HSB, 200, 100, 100);

  //textFont( loadFont("u-Bold-16.vlw"), 16);
  textFont( loadFont("Century-16.vlw"), 16);
  
  c = new cell[xsize][ysize];
  for(int y=0; y<ysize; y++){
    for(int x=0; x<xsize; x++){
      c[y][x] = new cell(0, 0);
    }
  }
  initCell();
  //noLoop();
} // setup

void initCell(){
  for(int y=0; y<ysize; y++){
    for(int x=0; x<xsize; x++){
      c[y][x].c_re = targetX + targetWidth * ((double)x / xsize - 0.5);
      c[y][x].c_im = targetY + targetWidth * ((double)y / ysize - 0.5);
      c[y][x].ploted = false;
    }
  }
}
//
void draw(){  
  for(int y=0; y<ysize; y+=step){
    for(int x=0; x<xsize; x+=step){
      if(c[y][x].ploted == false){
        c[y][x].iterate(limitCnt);
        c[y][x].plot(x,y,step,step);
      }
    }
  }
  noFill();
  stroke(100,0,50);
  rect(xsize/2-20, ysize/2-20, 40, 40);
  //
  noStroke();
  fill(0,0,0);
  rect(xsize,0, width-xsize, height);
  
  smooth();
  fill(0,0,100);
  text(str((float)targetX), xsize + 10, 20);  
  text(str((float)targetY), xsize + 10, 40);  
  text(str(limitCnt), xsize + 10, 60);  
  noSmooth();
  // text(str(ms), 300, 20);  
  // text(str(ms), 300, 20);  
  if(step <= 1){
    noLoop();
  } else {
    step /= 2;
  }
} // draw()

void mousePressed(){
  targetX = targetX + targetWidth * ((double)mouseX/xsize  - 0.5);
  targetY = targetY + targetWidth * ((double)mouseY/ysize - 0.5);
  if(mouseButton == LEFT){
    step = 8;
    targetWidth *= 0.65;
  }else{
    step = 8;
    targetWidth *= 1.2;
  }
  ms++;
  initCell();
  loop();
}

void keyPressed(){
  if(key =='u'){
    limitCnt *= 2;
  }else{
    limitCnt /= 2;
  }
  // initCell();
  // step = 8;
  loop();
}

class cell {
  double c_re, c_im;
  int count;
  boolean ploted;
  cell(){
  }
  cell(double rr, double ii){
    c_re = rr;
    c_im = ii;
  }
  void iterate(int limitCnt){
    double re=0, im=0, r2, i2;
    for(int i=0; i<limitCnt; i++){
      r2 = re * re;
      i2 = im * im;
      if((r2+i2)>4.0){
        return ;
      }
      im = 2 * re * im + c_im;
      re = r2 - i2 + c_re;
      count = i;
    }
    count = -count;
  }
  void plot(int x, int y,int w, int h){
    int H,S=100,B=100;
    if(count<0){
      H=0;
      S=0;
      B=0;
    }else{
      c[y][x].ploted = true;
      H = (int)sqrt((float)count*100);
      H %= 200;
    }
    
    if((w==1)&&(h==1)){
      noFill();
      stroke(H,S,B);
      point(x,y);
    } else {
      noStroke();
      fill(H,S,B);
      rect(x,y,w,h);
    }
  }  
}