void stlImport(String mFile) {
  TriangleMesh tmesh = (TriangleMesh) new STLReader().loadBinary(sketchPath(mFile), STLReader.TRIANGLEMESH);
  mesh = new WETriangleMesh();
  mesh.addMesh(tmesh);
  for (Face f : mesh.getFaces ()) {
    Triangle3D newM = f.toTriangle();
    meshList.add(newM);
  }
}



//void importAtt(String aFile) {
//  String lines[] = loadStrings(aFile);
//  for (int i = 0; i < lines.length; i++) {
//    String row[] = split(lines[i], ' ');
//    Vec3D aPo = new Vec3D(float(row[0]), float(row[1]), float(row[2]));
//    wall newAtt = new wall(aPo);
//    wallList.add(newAtt);
//  }
//}
//
//void importAtt2(String aFile) {
//  String lines[] = loadStrings(aFile);
//  for (int i = 0; i < lines.length; i++) {
//    String row[] = split(lines[i], ' ');
//    Vec3D aPo = new Vec3D(float(row[0]), float(row[1]), float(row[2]));
//    box newAtt = new box(aPo);
//    randomList.add(newAtt);
//  }
//}
//
//void importAtt3(String aFile) {
//  String lines[] = loadStrings(aFile);
//  for (int i = 0; i < lines.length; i++) {
//    String row[] = split(lines[i], ' ');
//    Vec3D aPo = new Vec3D(float(row[0]), float(row[1]), float(row[2]));
//    boxBig newAtt = new boxBig(aPo);
//    randomListTwo.add(newAtt);
//  }
//}
//
//
//void importAtt4(String aFile) {
//  String lines[] = loadStrings(aFile);
//  for (int i = 0; i < lines.length; i++) {
//    String row[] = split(lines[i], ' ');
//    Vec3D aPo = new Vec3D(float(row[0]), float(row[1]), float(row[2]));
//    boxSkinny newAtt = new boxSkinny(aPo);
//    randomListThree.add(newAtt);
//  }
//}