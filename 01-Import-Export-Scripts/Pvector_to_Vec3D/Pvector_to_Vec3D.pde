import toxi.geom.*;
import peasy.*;

PeasyCam pcam;
PVector pv;
Vec3D tv;

void setup(){
  size(1280,720,P3D);
  pcam = new PeasyCam(this,100);
  background(0);
  lights();
  
}

void draw(){
  pv = new PVector(mouseX, mouseY, mouseX/(mouseY+1));
  background(0);
  tv = new Vec3D(pv.x, pv.y, pv.z);
  translate(tv.x, tv.y, tv.z);
  noStroke();
  box(100,100,100);
  
}
