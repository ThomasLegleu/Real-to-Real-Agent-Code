 class wall{
  Vec3D pos;

  
  wall(Vec3D _pos){
    pos = _pos.copy();

  }
  
  void render(PGraphics pg){
    pg.fill(130,75);
    pg.noStroke();
    //stroke(0.5);
    pg.pushMatrix();
    pg.translate(pos.x, pos.y, pos.z);
       //scale(1,1,100);
      //pg.box(0.25);
    pg.popMatrix();
  }
 
  
}