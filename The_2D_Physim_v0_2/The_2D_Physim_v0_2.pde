/*
 2D Physim project
 is 2-Dimensions Physic simulator.
 complete solving collision response of triangle and plane.
 Thank equation from "https://en.wikipedia.org/wiki/Collision_response"
 version 0.2
 By Dhamdhawach Horsuwan
 11 July 2018 , Bangkok Thailand.
 */
triangle A;
float timeStep = 0.001;
void setup() {
  size(1000, 1000);
  init();


  A = new triangle(P2V(0, 100), P2V(50, -50), P2V(-50, -50));
  A.lin_pos = P2V(width/2, height/2);
  A.lin_vel = P2V(200, 200);
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
  noStroke();
}



void init() {
  plane_init();
}
void mouseWheel(MouseEvent event) {
  A.ang_pos.z =   A.ang_pos.z  + radians(event.getCount()*5);
}