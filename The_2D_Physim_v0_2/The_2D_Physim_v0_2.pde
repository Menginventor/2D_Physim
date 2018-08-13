/*
 2D Physim project
 is 2-Dimensions Physic simulator.
 complete solving collision response of triangle and plane.
 Thank equation from "https://en.wikipedia.org/wiki/Collision_response"
 version 0.2
 By Dhamdhawach Horsuwan
 11 July 2018 , Bangkok Thailand.
 */
Triangle A;
Ellipse B;
float timeStep = 0.001;
void setup() {
  size(1000, 1000);
  init();
  B = new Ellipse(300, 200);
  B.lin_pos = P2V(width/2, height/2);
  //B.ang_vel = P2V(0,0,10);
  

   A = new Triangle(P2V(0, 100), P2V(50, -50), P2V(-50, -50));
   A.lin_pos = P2V(width/2, height/2);
   A.lin_vel = P2V(0, 1000);
   A.ang_vel = P2V(0, 0, 0);
   
}


void draw() {
  //A.lin_pos = mouseVec();
  background(0);
  TOP_PLANE.draw();
  RIGHT_PLANE.draw();
  BOTTOM_PLANE.draw();
  LEFT_PLANE.draw();
  
  for (int i = 0; i<10; i++) {
   A.update();
   plane_triangle_impulse(BOTTOM_PLANE, A);
   plane_triangle_impulse(TOP_PLANE, A);
   plane_triangle_impulse(LEFT_PLANE, A);
   plane_triangle_impulse(RIGHT_PLANE, A);
   }
   A.draw();
   
  B.update();
  //B.draw();


  PVector dir = PVector.sub(mouseVec(), B.lin_pos).normalize();
  float theta = dir.heading()-B.ang_pos.z;
  float r = B.A*B.B/sqrt(pow(B.B*cos(theta), 2)+pow(B.A*sin(theta), 2));
  stroke(GREEN);
  //line_vec(B.lin_pos, mouseVec());
  stroke(RED);
  PVector peri = PVector.add(B.lin_pos, PVector.mult(dir, r));
  //line_vec(B.lin_pos, peri);
  stroke(BLUE);
  line_vec(B.focusA, peri);
  line_vec(B.focusB, peri);
  float line_length = PVector.dist(B.focusA, peri) + PVector.dist(B.focusB, peri);
  PVector FdirA = PVector.sub(B.focusA, peri).normalize();
  PVector FdirB = PVector.sub(B.focusB, peri).normalize();
  PVector normal = PVector.add(FdirA, FdirB).normalize();
  stroke(RED);
  line_vec(PVector.add(peri, PVector.mult(normal, 100)), PVector.sub(peri, PVector.mult(normal, 100)));
  stroke(GREEN);
  line_vec(PVector.add(peri, PVector.mult(normal, 100).rotate(HALF_PI)), PVector.sub(peri, PVector.mult(normal, 100).rotate(HALF_PI)));
  println(line_length);

  noStroke();
}



void init() {
  plane_init();
}
void mouseWheel(MouseEvent event) {
  B.ang_pos.z =   B.ang_pos.z  + radians(event.getCount()*5);
}