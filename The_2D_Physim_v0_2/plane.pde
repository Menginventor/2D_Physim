plane TOP_PLANE ;
plane LEFT_PLANE ;
plane BOTTOM_PLANE ;
plane RIGHT_PLANE;

class plane {
  PVector point;
  PVector dir;
  boolean define = false;
  color COLOR = color(255);
  float COF = 1;
  plane(PVector _point, PVector _dir) {
    point = _point;
    dir =_dir;
    define = true;
  }
  void draw() {
    if (!define)return;
    PVector[] CORN = {P2V(0, 0), P2V(width, 0), P2V(width, height), P2V(0, height)};
    plane[] WALL = {TOP_PLANE, RIGHT_PLANE, BOTTOM_PLANE, LEFT_PLANE};
    PVector[] VERTEX = {};

    stroke(COLOR);
    fill(COLOR);

    //  line_point(point, PVector.add(point, PVector.mult(dir, 30)));

    boolean inLoop = PVector.dot(dir, PVector.sub(CORN[3], point)) < 0;

    for (int i = 0; i<4; i++) {
      if (PVector.dot(dir, PVector.sub(CORN[i], point)) < 0) {
        if (!inLoop) {
          int j = i-1;
          if (j<0)j+=4;
          VERTEX = (PVector[]) append(VERTEX, planeIntersection(this, WALL[j]));
        }
        inLoop = true;
        VERTEX = (PVector[]) append(VERTEX, CORN[i]);
      } else {
        if (inLoop) {
          int j = i-1;
          if (j<0)j+=4;
          VERTEX = (PVector[]) append(VERTEX, planeIntersection(this, WALL[j]));
        }
        inLoop = false;
      }
    }


    vertex_point_list(VERTEX);
  }
}


void plane_init() {
  /*
  TOP_PLANE = new plane (P2V(0, 0), P2V(0, 1));
  LEFT_PLANE = new plane (P2V(0, 0), P2V(1, 0));
  BOTTOM_PLANE = new plane (P2V(0, height), P2V(0, -1));
  RIGHT_PLANE = new plane (P2V(width, 0), P2V(-1, 0));
  */
  TOP_PLANE = new plane (P2V(20, 20), P2V(0, 1));
  LEFT_PLANE = new plane (P2V(20, 20), P2V(1, 0));
  BOTTOM_PLANE = new plane (P2V(20, height-20), P2V(0, -1));
  RIGHT_PLANE = new plane (P2V(width-20, 20), P2V(-1, 0));
}