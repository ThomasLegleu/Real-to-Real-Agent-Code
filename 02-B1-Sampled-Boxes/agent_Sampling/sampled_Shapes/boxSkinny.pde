class boxSkinny{
  Vec3D pos;

  
  boxSkinny(Vec3D _pos){
    pos = _pos.copy();

  }
  
  void render(){
    
     // orange skinny boxes
    pushMatrix();
    fill(255,116,0,75);
    translate(pos.x, pos.y, pos.z);
        rotateZ(PI/4.0);
        scale(random(5,200),1,1);
       //box(1);
    popMatrix();
    
  }
 
  
}