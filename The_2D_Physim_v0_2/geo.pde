PVector planeIntersection (plane A, plane B) {
  mat COF = new mat(2, 2);
  mat SOL = new mat(2, 1);
  COF.set_ele(new float[][]{
    {A.dir.x, A.dir.y}, 
    {B.dir.x, B.dir.y}, 

    });
  SOL.set_ele(new float[][]{
    { A.point.x*A.dir.x + A.point.y*A.dir.y}, 
    { B.point.x*B.dir.x + B.point.y*B.dir.y}, 

    });
  mat VAR = mat_mult(COF.inv(), SOL);
  return new PVector(VAR.ele[0][0],VAR.ele[1][0]);
}

void line_point(PVector A,PVector B){
  line(A.x,A.y,B.x,B.y);
}

void ellipse_point(PVector A,float w,float h){
  ellipse(A.x,A.y,w,h);
}

void vertex_point(PVector A){
  vertex(A.x,A.y);
}

void vertex_point_list(PVector []VERTEX){
  beginShape();
    for (int i = 0; i < VERTEX.length; i++) {

      vertex_point(VERTEX[i]);
    }
    endShape(CLOSE);
}

PVector mouseVec (){
  return  new  PVector(mouseX, mouseY);
}


PVector P2V(float x, float y) {
  return  new  PVector(x, y);
}
PVector P2V(float x, float y, float z) {
  return  new  PVector(x, y, z);
}
float V2R(PVector A) {
  return atan2(A.y, A.x);
}
PVector R2V(float  A) {
  return new  PVector(cos(A), sin(A));
}

boolean SameSide(PVector p1, PVector p2, PVector a, PVector b) {
  b = PVector.sub(b,a);
  p1 = PVector.sub(p1,a);
  p2 = PVector.sub(p2,a);
 
  PVector cp1 = b.cross(p1);
  PVector cp2 = b.cross(p2);

  if ((cp1.dot(cp2)) >= 0) {
    return true;
  }
  else
    return false;
}

boolean PointInTriangle(PVector p,PVector a,PVector b,PVector c) {
  if (SameSide(p,a, b,c) && SameSide(p,b, a,c) && SameSide(p,c, a,b)) {
    fill(255,0,0);
    return true;
  }
  else
    fill(255,255,255);
  return false;
}