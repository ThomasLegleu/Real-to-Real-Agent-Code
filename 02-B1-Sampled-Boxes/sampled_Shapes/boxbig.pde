class boxBig{
  Vec3D pos;
  float dlin;

  
  boxBig(Vec3D _pos){
    pos = _pos.copy();

  }
  
  void render(PGraphics pg){
     //pg.colorMode(HSB,100);
    color fil = color(map(dlin, 0, 10, 0,255), 100, 100);
    pg.fill(fil);
    pg.noStroke();
    pg.pushMatrix();
    pg.translate(pos.x, pos.y, pos.z);
//    sphereDetail(10);
    pg.box(random(70));
    pg.popMatrix();
    
    
     // orange skinny boxes
//    pushMatrix();
//    fill(255,116,0,75);
//    translate(pos.x, pos.y, pos.z);
//        rotateZ(PI/4.0);
//        scale(random(5,200),1,1);
//       box(1);
//    popMatrix();
    
  }
 
  
}