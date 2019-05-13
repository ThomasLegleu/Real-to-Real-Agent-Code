class trail {

  Vec3D pos;
  Vec3D vel;
  float life;
  agent parent;
  ArrayList history;
  //ArrayList mPts;

  //this is the constructor
  trail(Vec3D _pos, Vec3D _vel, agent _parent) {

    pos = _pos.copy();
    vel = _vel.copy();
    vel.normalize();
    life = 1000;
    parent = _parent;
    history = new ArrayList();
    //mPts = new ArrayList();
  }


  void updateT() {

    // put position into arraylist
    Vec3D oldPos = pos.copy();
    history.add(oldPos);
  }



  void renderT(PGraphics pg) {
    stroke(205*life/100, 150, 50);
    Vec3D temp = vel.copy();
    temp.scaleSelf(tLength);
    //if(showTrail==true) {
    //stroke(0.5);
    point(pos.x, pos.y, pos.z);
    //line(pos.x, pos.y, pos.z,pos.x + temp.x, pos.y+ temp.y, pos.z + temp.z);
    pg.pushMatrix();
    pg.fill(225);
    pg.noStroke();
    pg.translate(pos.x, pos.y, pos.z);
    //if(showAttractor == true) {
    //pg.scale(1, 1, 1);
    //pg.rotateY(-0.2);
    pg.rotateZ(-0.2);
    pg.box(1);
    //}
    pg.popMatrix();

    life = life -1;
    if (life < 0) {
      trailList.remove(this);
    }
  }
  
  
    void renderTTwo(PGraphics pg) {
    stroke(205*life/10+100, 150, 50);
    Vec3D temp = vel.copy();
    temp.scaleSelf(tLength);
    //if(showTrail==true) {
    //stroke(0.5);
    //line(pos.x, pos.y, pos.z,pos.x + temp.x, pos.y+ temp.y, pos.z + temp.z);
    pg.pushMatrix();
    pg.fill(225);
    pg.noStroke();
    pg.translate(pos.x, pos.y, pos.z);
    //if(showAttractor == true) {
    pg.scale(1, 1, 1);
    //pg.box(0.5);
    //}
    pg.popMatrix();

    life = life -1;
    if (life < 0) {
      trailList.remove(this);
    }
  }
  
  
  
}