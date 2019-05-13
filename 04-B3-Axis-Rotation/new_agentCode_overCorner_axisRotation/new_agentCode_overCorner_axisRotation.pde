

import toxi.geom.*; 
import toxi.geom.mesh.*;
import toxi.volume.*;
import toxi.processing.*;
import java.text.DecimalFormat;
//import SimpleOpenNI.*;
import java.util.*;
import processing.net.*;


import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;
import processing.opengl.*;
import processing.opengl.*;


import controlP5.*;
//import damkjer.ocd.*;
import nervoussystem.obj.*;

/////////click on window and press 'c' to close the simulation and the sockets///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//  Agent Code Group B testa_Superpositions

////////  pre pseudo code // to do  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//SimpleOpenNI context;

ArrayList pts; 
ArrayList matter; 
ArrayList pathList;
ArrayList meshList;
ArrayList dumList;
int expTest = 0;



ArrayList agentList;
ArrayList agentListTwo;
ArrayList agentListThree;

ArrayList attList;

ArrayList trailList;
ArrayList trailListTwo;
ArrayList trailListThree;



int picTake;
ArrayList avPts;
ArrayList captureList;

float nearClip = 100;
float farClip = 500;

int lock = 0;
int rM = 1;
int screenSwitch = 0;


WETriangleMesh mesh;


float isoDens = 1;  // 
float ISO_THRESHOLD = .1;
float NS = 0.03;

//PrintWriter output;

trail export;

boolean record = false;


///////////////////// isosurface stuff   /////////////////////////////////////////////////////

VolumetricSpaceArray volume; // three dimensional voxel grid of points that contain a value
VolumetricBrush brush; // actual calculation of the threshold of which is exterior or interior of the isosurface
IsoSurface surface;   // class that allows a point to provide information to a voxel 

TriangleMesh mesh2 = new TriangleMesh("meshTest");
float ISO = 0.3;
int GRID = 40;
int DIM = 600;

Vec3D scale = new Vec3D(DIM, DIM, DIM);

ToxiclibsSupport gfx;
int sendSwitch = 1;


////////step is the resolution of the kinect, slack is the distance of error before the send function erases the stack////////////////
//int resolution = 2;
//float slack = 20;

//float zRot;
//float xRot;
//float yRot;
//Vec3D worldAdjust;


// gui stuff ////////////////////////////////////////////////////////////

ControlP5 controlP5;
PMatrix3D currCameraMatrix;
PGraphics3D g3;


boolean showAgents = false;
boolean showTrail = false;
boolean showAttractor = false;

public float separation=1;    // separation default value = 0.5
public float alignment=0.1; 
public float cohesion=0.05;    // separation default value = 0.2
public float seekTrail_threshold=0.5;
public float velocity=1;



public float life1 =1300;
public float tLength = 2;


////// camera stuff ////////////////////////////////////////////////////

PeasyCam cam;
//Camera camera1;

void setup() {


  size(1280, 720, P3D);
  // background(255,0,0);

  //instantiate camera
  cam = new PeasyCam(this, 1200);



  //size(3000, 1500, P3D);
  g3 = (PGraphics3D)g;
  //frameRate(10);
  smooth();


  controlP5 = new ControlP5(this);
  controlP5.setAutoDraw(false);

  output = createWriter("data/points.csv");


  // toggles 

  controlP5.addToggle("showAgents")
    .setPosition(20, 300);
  controlP5.addToggle("showTrail")
    .setPosition(20, 340);
  controlP5.addToggle("showAttractor")
    .setPosition(20, 380); 




  // agent gui stuff

  controlP5.addSlider("separation", 0, 20, 5, 20, 20, 100, 10);
  controlP5.addSlider("cohesion", 0, 1, 0.2, 20, 40, 100, 10);
  controlP5.addSlider("alignment", 0, 1, 0.2, 20, 60, 100, 10);
  controlP5.addSlider("seekTrail_threshold", 0, 5, 1, 20, 80, 100, 10);
  controlP5.addSlider("velocity", 0, 20, 0.5, 20, 100, 100, 10);

  //trail gui stuff  
  controlP5.addSlider("life1", 0, 1300, 1200, 20, 140, 100, 10);
  controlP5.addSlider("tLength", 0, 20, 2, 20, 160, 100, 10);


  ////////////////////////// dummy point import  //////////////////////////////// 
  picTake = 0;
  captureList = new ArrayList();
  avPts = new ArrayList();


  // for some reason when I turn on import point function in the import class i get a unexpected token: void in the agent class 
  // importPts("pts_124.txt");

  pts = new ArrayList();
  matter = new ArrayList();
  frameRate(24);

  // INITIATE SPACE ARRAY

  volume = new VolumetricSpaceArray (scale, GRID, GRID, GRID); // volumetric spacearray passes the information into the isosurface
  surface = new ArrayIsoSurface(volume); //      
  brush = new RoundBrush(volume, scale.x/2); // size of  painting information in the volumetric space array

  agentList = new ArrayList();
  agentListTwo = new ArrayList();
  trailList = new ArrayList();
  attList = new ArrayList();


  meshList = new ArrayList();
  mesh = new WETriangleMesh();

  stlImport("three_Pieces.stl");

  dumList = new ArrayList();

  //specify kinect position relative to world origin here
//  worldAdjust = new Vec3D(-146.1, -551.46, -225.11);
//  zRot = radians(-0.17084); // PI/2 aligns with world x Axis,  so y axis is PI
//  xRot = radians(-90.5403);
//  yRot = radians(1.26946);
  ///////end kinectStuff//////////////

  gfx = new ToxiclibsSupport(this);


  pathList = new ArrayList();
}


void draw() {

  
  noStroke();
  box(15);
  //strokeWeight(5);
  //stroke(255, 0, 0);
  //line(0, 0, 0, 200, 0, 0);
  //stroke(0, 255, 0);
  //line(0, 0, 0, 0, 200, 0);
  //stroke(0, 0, 255);
  //line(0, 0, 0, 0, 0, 200);
  
  scale(-1, 1, 1);

  lights();
  background(0);
  // println(frameCount);


  if  (frameCount == 1) {


    for (Vertex v : mesh.getVertices ()) {
      if (random(10) < 2) {
        float rad = 1;
        Vec3D newV = new Vec3D(v.x, v.y, v.z);
        agent newA = new agent(rad, newV);
        agentList.add(newA);
      }
    }
  }
      //if (random(10) < 0.05) {
      //  float rad = random(5, 10);
      //  Vec3D newV = new Vec3D(v.x, v.y, v.z);
      //  attractor newA = new attractor(newV);
      //  attList.add(newA);
      //}
   // }
//  }

  //if  (frameCount == 60) {


  //  for (Vertex v : mesh.getVertices ()) {
  //    if (random(10) < 2) {
  //      float rad = 1;
  //      Vec3D newV = new Vec3D(v.x, v.y, v.z);
  //      agent newA = new agent(rad, newV);
  //      agentListTwo.add(newA);
  //    }
  //  }
  //}


  if (record == true) {

    OBJExport obj2 = (OBJExport) createGraphics(1, 1, "nervoussystem.obj.OBJExport", "cube2.obj");
    obj2.setColor(true);
    obj2.beginDraw();
    obj2.noFill();
    for (int i = 0; i < trailList.size (); i++) {
      trail me = (trail) trailList.get(i);
      me.renderT(obj2);
    }
    obj2.endDraw();
    obj2.dispose();
    record =  false;
  }





  for (int i = 0; i < agentList.size (); i++) {
    agent a = (agent) agentList.get(i);
    // if  (frameCount < 60) { 
    a.update();
    //}
    a.render();
  }

  for (int i = 0; i < agentListTwo.size (); i++) {
    agent a = (agent) agentListTwo.get(i);
    a.update();
    a.renderTwo();
  }


  //  arraylist to bring in arrays tail class 

  for (int i = 0; i < trailList.size (); i++) {
    trail b = (trail) trailList.get(i);

    b.updateT();
    //if  (frameCount < 60){
    b.renderT(this.g);
    //}
    //else
    //b.renderTTwo(this.g);
  }




  for (int i = 0; i < attList.size (); i++) {
    attractor a = (attractor) attList.get(i);
    a.render();
  }

  noStroke();
  //fill(0,155,155,70);
  fill(125, 0, 0);
  //gfx.mesh(mesh);





  gui();


  println(frameCount);
  //saveFrame("overCorner/agent-####.png");
  
  
   if (expTest == 1) {
    export();
    exit();
  }
//if(frameCount%(cogLife-1) == 0){
//  export();
//  exit();
//}
  if (keyPressed == true) {
    if (key == 'x') {
      if (expTest == 0) {
        expTest = 1;
      }
      else {
        expTest = 0;
      }
    }
  }
  
  
}

void gui() {
  currCameraMatrix = new PMatrix3D(g3.camera);
  camera();
  //fill(10); 
  noStroke();
  // camera1.circle(radians(0) / 2.0);
  // camera1.roll(radians(0) / 2.0);
  //rect(0,0,width,80);
  controlP5.draw();
  g3.camera = currCameraMatrix;
}

void rotateMesh() {
  Collection vList = mesh.getVertices();
  Object[] vArray =  vList.toArray();
  Vec3D rCent = new Vec3D(-174, -1396, -95.99);
  meshList = new ArrayList();
  println("rotating");
  for (int i = 0; i < vArray.length; i++) {

    Vertex v1 = (Vertex) vArray[i];
    Vec3D tV = new Vec3D(v1.x, v1.y, v1.z);
    tV.subSelf(rCent);
    float mag = tV.magnitude();
    tV.normalize();
    tV.rotateZ(PI/10);
    tV.normalize();
    tV.scaleSelf(mag);
    tV.addSelf(rCent);
    v1.x = tV.x;
    v1.y = tV.y;
    v1.z = tV.z;
  }
  for (Face f : mesh.getFaces ()) {
    Triangle3D newM = f.toTriangle();
    meshList.add(newM);
  }
}

void keyPressed() {
  if (key == 'r') { 
    record = true;
    println("i saved");
  }
}