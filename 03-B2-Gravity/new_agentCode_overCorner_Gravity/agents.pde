// need to add a wander theta to the operations so its scanning at different angles
// 
// need to add information about the agent searching for a given angle to seek that tail 

class agent {
  float rad;
  Vec3D pos;
  Vec3D vel;

  
  
  ArrayList history;
  ArrayList trail;
  //this is the constructor
  
  agent(float _rad, Vec3D other) {
    rad = _rad;
    pos = other.copy();
    vel = new Vec3D();
    vel = seekMeshNorm(pos);
    history = new ArrayList();
    base = new Vec3D(0,0,0);
  }




 void update() {
   if(pos.z > 0){
     
    //put position copy in history arrayList
    Vec3D oldPos = pos.copy();
    history.add(oldPos);
    
  
    
    // new walk through 
    if (frameCount%1 == 0) {
      trail newT = new trail(pos.copy(), vel.copy(), this);
      trailList.add(newT);
    }
    
    
    if (history.size() > 1000) {
      history.remove(0);
    }

  
    Vec3D sum = new Vec3D();
    

    //specific behavior functions
    
    Vec3D sep =  separate();
    Vec3D ali = align();
    Vec3D coh = cohesion();
    Vec3D seekT = seekTrail();
    //Vec3D seekAtt = seekAttractors(); 
    Vec3D seekM = seekMeshPt(pos);
    //seekM.subSelf(pos);
    
    Vec3D grav = new Vec3D(0,0,-1);
       
    //scaling the behavior functions
    
    sep.scaleSelf(separation);
    ali.scaleSelf(alignment);
    coh.scaleSelf(cohesion);
    seekT.scaleSelf(seekTrail_threshold);
    //seekM.limit(rad);
    //seekM.scaleSelf(0.5);
    
    //seekAtt.scaleSelf(5);
        
    //add the vectors together and limit
    sum.addSelf(grav);
    //sum.addSelf(sep);
    //sum.addSelf(ali);
    sum.addSelf(coh);
    //sum.addSelf(seekM);
    sum.addSelf(seekT);
    //sum.addSelf(seekAtt);
    
    
    sum.limit(rad);
    vel.addSelf(sum);
    vel.limit(velocity);
    
    
    //add the sum to the position and move the agent
    Vec3D rnd = vel.copy();
    rnd.normalize();
    rnd.roundToAxis();
    
    pos.addSelf(rnd);
   }
}


  Vec3D align() {
    Vec3D sum = new Vec3D();
    //loop through other agents and get their velocities
    for (int i = 0; i < agentList.size (); i++) {
      agent other = (agent) agentList.get(i);
      float dis = pos.distanceTo(other.pos);
      if (dis > 0 && dis < 200) {
        Vec3D temp = other.vel.copy();
        if (temp.magnitude() > 0) {
          temp.normalize();
          float factor = 1/dis;
          temp.scaleSelf(factor);
          sum.addSelf(temp);
        }
      }
    }
    if (sum.magnitude() > 0) {
      sum.normalize();
    }
    return sum;
  }


  Vec3D separate() {
    //create a vector to sum all of the separations
    Vec3D sum = new Vec3D();
    //loop through all the agents in the scene and check for overlaps
    for (int i = 0; i < agentList.size (); i++) {
      agent other = (agent) agentList.get(i);
      //make sure other is not this agent
      if (other != this) {
        //check if overlapping
        float dis = pos.distanceTo(other.pos);
        if (dis < 2*(rad + other.rad) && dis > 0) {
          //create a vector away from overlap and scale by 1/2 overlap distance
          Vec3D temp = pos.sub(other.pos);
          temp.normalize();
          float factor = 1-(dis/(2*(rad+other.rad))) ;
          temp.scaleSelf(factor);
          sum.addSelf(temp);
        }
      }
    }
    //return the final sum
    return sum;
  }


    Vec3D cohesion(){
    
    //create a vector to sum all of the separations
    Vec3D sum = new Vec3D();
    //loop through all the circles in the scene and check for overlaps
    for(int i = 0; i < agentList.size(); i++){
      agent other = (agent) agentList.get(i);
      // find the distance from 
        float dis = pos.distanceTo(other.pos);
        if(dis > 0 && dis < 20){
          //create a vector away from overlap and scale by 1/2 overlap distance
          Vec3D temp =other.pos.copy();
          temp.subSelf(pos);
          temp.normalize();
          // vector math to make the cohesion occur
          float factor = (1-(dis/100));
          temp.scaleSelf(factor);
          sum.addSelf(temp);
        }
    }
    //return the final sum
    return sum;
  }
 

  Vec3D seekTrail () {

    //create a sum vector
    Vec3D sum = new Vec3D();
    float closDis = 900000;
// loop in all the trails of the list
    for (int i = 0; i < trailList.size (); i++) {
      trail a = (trail) trailList.get(i);
      // if the trail is not itself get the distance from the trail to the agent 
      if (a.parent != this) {
        float dis = pos.distanceTo(a.pos);
      // if the distance is greater than zero create a factor
        if (dis > 0 && dis < 20*rad) {
          float factor = 1/pow(dis, 2);
      // if the distance is less than the radius create a temp vec3d that gets the velocity of the trails in the list and stores them in temp
          if (dis < rad) {
            Vec3D temp = a.vel.copy();
      // scaleself = Scales vector uniformly and overrides coordinates with result >>>> temp is replaced by the float factor    
            temp.normalize();
            temp.scaleSelf(factor);
      // addself to the overall sum       
            sum.addSelf(temp);          
      
          }else{
            Vec3D temp = a.pos.copy();
            temp.subSelf(pos);
            temp.normalize();
            temp.scaleSelf(factor);
            sum.addSelf(temp);
          }
        }
      }
    }

    
    return sum;
  }    


//seek attractor(){
  // 
     Vec3D seekAttractors(){
     // create a sum vector
     Vec3D sum = new Vec3D();
     float closDis = 900000;
     
     // loop through attractors and find closest one
     for (int i = 0 ; i < attList.size() ; i++){
       attractor a = (attractor) attList.get(i);
       float dis = pos.distanceTo(a.pos);
       if(dis < closDis){
         closDis = dis;
         sum = a.pos.copy();
       }
     }
    // return the vector to the closest attractor 
     if (closDis < 900000){
       sum.subSelf(pos);
       sum.limit(.1*rad);
     }
     
   return sum;
 
  
}

  void render() {
    //draw history
    if (history.size() > 1) {
      for (int i = 1; i < history.size (); i++) {
        Vec3D p = (Vec3D) history.get(i);
        Vec3D p2 = (Vec3D) history.get(i-1);
        stroke(0,255,0);
       // line(p.x, p.y, p.z, p2.x, p2.y, p2.z);
      }
    }
   
    noStroke();
    fill(0, 150, 220,60);
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    sphereDetail(1);
    
   //sphere(rad);
    if(showAgents==true) {
    sphere(rad/8);
  } else {
    sphere(rad/4);
  }
  
//   myBrush.setSize(80);
//   myBrush.drawAtAbsolutePos(loc,1);
  
    popMatrix();
  }
  
}

