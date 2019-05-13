
 class attractor{
  Vec3D pos;
  
  attractor(Vec3D _pos){
    pos = _pos.copy();
  }
  
  void render(){
    noStroke();
    fill(255);
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    //if(showAttractor == true) {
       box(5);
    //}
    popMatrix();
  }
 
  
}
