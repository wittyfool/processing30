 
void setup(){
float x,y;
int c;

  size(200, 200);
  background(0);

for(int i=0; i<height; i+=1) {
  y = (float)(i - (height/2))*4.0/(float)height;
  for(int j=0; j<width; j+=1) {
    x = (float)(j - (width/2))*4.0/(float)width;
    c = count(x, y, 500);
    //stroke(distances[j][i]);
    //stroke(c);
    //point(j, i);
    //color(c, c, c);
    set(j, i, color(i % 255, c, 0));
  }
}
}

int count(float xx, float yy, int limit){
  float zr=0, zi=0;
  float r2,i2;
  int ret = 0;

  //return 255;
  //return (int)(xx*100.0) % 100;
  
  for(int i=0; i<limit; i++){
    r2 = zr * zr;
    if(r2 > 4) break;
    i2 = zi * zi;
    if(i2 > 4) break;
    if((r2+i2)>4) break;
    zi = yy + 2.0 * (zr * zi);
    zr = xx + r2 - i2;
    ret++;
  }
  return ret % 256;
}
