class Triangle {
  PVector shape[] = new PVector[3];
  PVector point[] = new PVector[3];
  PVector CM;
  PVector lin_pos = P2V(0, 0, 0);
  PVector ang_pos = P2V(0, 0, 0);
  PVector lin_vel = P2V(0, 0, 0);
  PVector ang_vel = P2V(0, 0, 0);
  color COLOR = color(255);
  float Jzc ;
  float Area;
  float density = 1;
  float mass ;
  float COF = 1;

  Triangle(PVector _p1, PVector _p2, PVector _p3) {
    shape[0] = _p1;
    shape[1] = _p2;
    shape[2] = _p3;
    PVector bc = new PVector(shape[1].x+(shape[2].x-shape[1].x)/2, shape[1].y+(shape[2].y-shape[1].y)/2);
    CM = new PVector( shape[0].x+(bc.x-shape[0].x)*2.0/3.0, shape[0].y+(bc.y-shape[0].y)*2.0/3.0 );
    PVector s1 = PVector.sub(_p1, _p2); 
    PVector s2 = PVector.sub(_p3, _p2); 
    float b = s2.mag();
    float h = s1.cross(s2).mag()/b;
    float a = PVector.dot(s1, s2)/b;

    Jzc = (pow(b, 3)*h-pow(b, 2)*h*a+b*h*pow(a, 2) + b*pow(h, 3))/36.0;
    Area = 0.5*b*h;
    mass = density*Area;
    println("Jzc = "+str(Jzc));
    println("Area = "+str(Area));
  }
  void draw() {
    stroke(COLOR);
    fill(COLOR);

    vertex_point_list(point);
    stroke(0);
    ellipse_point(lin_pos, 10, 10);
  }
  void update() {
    lin_pos.add(PVector.mult(lin_vel, timeStep));
    ang_pos.add(PVector.mult(ang_vel, timeStep));

    for (int i = 0; i<shape.length; i++) {
      point[i] = mat_mult(RZ(ang_pos.z), V2M(PVector.sub(shape[i], CM))).toVector().add(lin_pos);
    }
  }

  float kinetic_energy() {
    return 0.5*mass*lin_vel.magSq() + 0.5*Jzc*ang_vel.magSq();
  }
}
class Ellipse {

  float A, B;

  PVector lin_pos = P2V(0, 0, 0);
  PVector ang_pos = P2V(0, 0, 0);
  PVector lin_vel = P2V(0, 0, 0);
  PVector ang_vel = P2V(0, 0, 0);
  PVector focus_dist;
  PVector focusA;
  PVector focusB;
  color COLOR = color(255);
  float Jzc ;
  float Area;
  float density = 1;
  float mass ;
  float COF = 1;

  Ellipse(float _width, float _height) {
    A = _width/2.0;
    B = _height/2.0;


    Jzc = PI*A*B*(pow(A, 2)+pow(B, 2))/4.0;
    Area = PI*A*B;
    mass = density*Area;
    focus_dist = sqrtVec(pow(A, 2)-pow(B, 2));
    focusA = PVector.add(lin_pos, focus_dist);
    focusB = PVector.sub(lin_pos, focus_dist);
    println("Jzc = "+str(Jzc));
    println("Area = "+str(Area));
  }
  void draw() {
    stroke(COLOR);
    fill(COLOR);



    pushMatrix();
    translate(lin_pos.x, lin_pos.y);
    rotate(ang_pos.z);
    ellipse(0, 0, 2*A, 2*B);
    popMatrix();
    stroke(0);
    ellipse_point(lin_pos, 10, 10);
  }
  void update() {

    lin_pos.add(PVector.mult(lin_vel, timeStep));
    ang_pos.add(PVector.mult(ang_vel, timeStep));
    focusA = PVector.add(lin_pos, rotateVec(focus_dist,ang_pos.z));
    focusB = PVector.sub(lin_pos, rotateVec(focus_dist,ang_pos.z));
  }

  float kinetic_energy() {
    return 0.5*mass*lin_vel.magSq() + 0.5*Jzc*ang_vel.magSq();
  }
}

float point_to_plane(PVector _point, plane _plane) {
  return PVector.dot(_point, _plane.dir);
}