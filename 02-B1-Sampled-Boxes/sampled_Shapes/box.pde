 class box{
  Vec3D pos;

  
  box(Vec3D _pos){
    pos = _pos.copy();

  }
  
  void render(PGraphics pg){
    pg.fill(255,75);
    pg.noStroke();
    
    // light blue boxes
    pg.pushMatrix();
    pg.fill(155,255,255,75);
    pg.translate(pos.x, pos.y, pos.z);
    pg.noStroke();
    pg.scale(4,4,200);
    pg.box(random(0.75));
    pg.popMatrix();
    
    // orange skinny boxes
    pg.pushMatrix();
    pg.fill(255,116,0,75);
    pg.translate(pos.x, pos.y, pos.z);
        pg.rotateZ(PI/4.0);
        pg.scale(random(5,200),1,1);
       //pg.box(1);
    pg.popMatrix();
    
     pushMatrix();
     fill(0,0,255,75);
     translate(pos.x, pos.y, pos.z);
       noStroke();
       scale(random(1,5),10,15);
       //box(7);
    popMatrix();
  }
 
  
}