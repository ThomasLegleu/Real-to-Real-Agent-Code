import peasy.*;
import toxi.geom.*;
import toxi.volume.*;
import toxi.geom.mesh.*;
import toxi.processing.*;
import nervoussystem.obj.*;



ToxiclibsSupport gfx;

int colorSwitch;
PeasyCam cam;

boolean b;

ArrayList wallList;
ArrayList randomList;
ArrayList randomListTwo;
ArrayList randomListThree;

ArrayList meshList;


PGraphics3D g3;

boolean record = false;
WETriangleMesh mesh;





void setup() {
  
  size(1280, 720,P3D);
  cam = new PeasyCam(this, 500);
  cam.setRotations(-PI/2, 0, 0); 
  g3 = (PGraphics3D)g;
  frameRate(2);
  smooth();
  background(0);
  
  wallList = new ArrayList();
  randomList = new ArrayList();
  randomListTwo = new ArrayList();
  randomListThree = new ArrayList();
  
  // import for pointcloud capture
//  importAtt("Apoints.txt");  
//  // import for culled point cloud
//  importAtt2("culled_Pts.txt");
//  importAtt3("box_Big.txt");  
//  importAtt4("box_Skinny.txt");


   meshList = new ArrayList();
   mesh = new WETriangleMesh();

   stlImport("boxes.stl");
   
   gfx = new ToxiclibsSupport(this);

  
}


void draw() {
   
  background(255);
  noStroke();
  randomSeed(0);
   
  // location marker 0,0,0 
 
 
//  if (record) {
//    beginRecord("nervoussystem.obj.OBJExport", "filename.obj"); 
//    }


  box(15);
  strokeWeight(5);
  stroke(255, 0, 0);
  line(0, 0, 0, 200, 0, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 0, 200, 0);
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, 200); 
  
   noStroke();
  //fill(0,155,155,70);
  fill(125, 0, 0);
  gfx.mesh(mesh);
  
  
  
//    if (record) {
//    endRecord();
//    record = false;
//  } 
 
 
  if(record == true) {
      //beginRecord("nervoussystem.obj.OBJExport", "filename.obj");
//      OBJExport obj = (OBJExport) createGraphics(1,1,"nervoussystem.obj.OBJExport","cube.obj");
//      obj.setColor(true);
//      obj.beginDraw();
//      obj.noFill();
//      for (int i = 0; i < randomListTwo.size(); i++) {
//        boxBig me = (boxBig) randomListTwo.get(i);
//        //me.update();
//        me.render(obj);
//      }
//      obj.endDraw();
//      obj.dispose();
      
      OBJExport obj2 = (OBJExport) createGraphics(1,1,"nervoussystem.obj.OBJExport","cube2.obj");
      obj2.setColor(true);
      obj2.beginDraw();
      obj2.noFill();
      for (int i = 0; i < randomList.size(); i+= 10) {
   box me = (box) randomList.get(i);
    me.render(obj2);
  }
      obj2.endDraw();
      obj2.dispose();
//      render(obj);

      record =  false;
  }
 
 
     for (Vertex v : mesh.getVertices ()) {
      if (random(10) < 2) {
        float rad = 1;
        Vec3D newV = new Vec3D(v.x, v.y, v.z);
          Vec3D aPo = new Vec3D(v.x, v.y, v.z);
          box newAtt = new box(aPo);
          randomList.add(newAtt);
      }
  }
 
 
 
  
  //println(frameCount);
  lights();

  
 //  loop through wall and randomList and call the functions

    for (int i = 0; i < wallList.size(); i++) {
    wall me = (wall) wallList.get(i);
    me.render(this.g);
  }


for (int i = 0; i < randomList.size(); i++) {
    box me = (box) randomList.get(i);
    me.render(this.g);
  }
  
  for (int i = 0; i < randomListTwo.size(); i++) {
    boxBig me = (boxBig) randomListTwo.get(i);
    me.render(this.g);
  }
  
   for (int i = 0; i < randomListThree.size(); i++) {
    boxSkinny me = (boxSkinny) randomListThree.get(i);
    me.render();
  }
    
}

void keyPressed(){
  if(key == 'r'){ record = true;
  println("i saved");
  }
}


//void mousePressed() {
//  record = true;
//}