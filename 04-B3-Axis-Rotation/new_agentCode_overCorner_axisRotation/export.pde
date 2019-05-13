PrintWriter output;

void export(){
  output = createWriter("nodes_" + frameCount + ".txt");
  
  for(int i = 0; i < trailList.size(); i++){
    trail c = (trail) trailList.get(i);
    
//      for(int j = 0; j < c.mPts.size(); j++){
//        trail n = (trail) c.mPts.get(j);
        
      output.println(c.pos.x + "," + c.pos.y + "," + c.pos.z );
      //output.printlne();
      //if(j < c.mPts.size() -1){
     //   output.print(" ");
      //}
      }
   
   
  
  output.flush();
  output.close();
}