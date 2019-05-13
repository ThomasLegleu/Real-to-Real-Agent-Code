class trail {

  Vec3D pos;
  Vec3D vel;
  float life;
  agent parent;
  ArrayList history;

  //this is the constructor
  trail(Vec3D _pos, Vec3D _vel, agent _parent) {

    pos = _pos.copy();
    vel = _vel.copy();
    vel.normalize();
    life = life1;
    parent = _parent;
    history = new ArrayList();
    
  }


void updateT(){
    
    // put position into arraylist
    Vec3D oldPos = pos.copy();
    history.add(oldPos);
}



  void renderT(PGraphics pg) {
    stroke(205*life/10+100,150,50);
    Vec3D temp = vel.copy();
    temp.scaleSelf(tLength);
    
    
     pg.pushMatrix();
     pg.fill(225);
     pg.noStroke();
     pg.translate(pos.x, pos.y, pos.z);
     pg.box(3);
     pg.popMatrix();


// GENERATE LINE FROM TRAIL LIST

//     if ( history.size() > 1){
//      for(int i = 1 ; i < history.size(); i++){ 
//        Vec3D p = (Vec3D) history.get(i);
//        Vec3D p2 = (Vec3D) history.get(i-1);
//        stroke(255);
//       // point(p.x,p.y,p.z);
//        line(p.x,p.y,p.z,p2.x,p2.y,p2.z);
//      }
//    }

   
    life = life -1;
    if(life < 0){
      trailList.remove(this);
    }
  }
}
