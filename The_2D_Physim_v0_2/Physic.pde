void plane_triangle_impulse(plane  body1, Triangle body2) {

  boolean collision = false;
  PVector r_contact = new PVector(0, 0, 0);
  int contact_point = -1;
  float contact_dist = 0;
  for (int i = 0; i<body2.shape.length; i++) {
    body2.point[i] = mat_mult(RZ(body2.ang_pos.z), V2M(PVector.sub(body2.shape[i], body2.CM))).toVector().add(body2.lin_pos);
    contact_dist = point_to_plane( PVector.sub(body2.point[i], body1.point), body1);
    if (contact_dist<0) {
      r_contact =  PVector.sub(body2.point[i], body2.lin_pos );
      collision = true;
      contact_point = i;
      break;
    }
  }
  if (!collision) {
    return ;
  }
  body2.lin_pos.sub(PVector.mult(body1.dir,contact_dist));



  PVector Vp1 = new PVector(0, 0, 0);
  PVector Vp2 = PVector.add(body2.lin_vel, body2.ang_vel.cross(r_contact));
  PVector Vr = PVector.sub(Vp2, Vp1);
  float m1 = INF;
  float m2 = body2.mass;
  float I1 = INF;
  float I2 = body2.Jzc;
  PVector r1 = body1.dir;
  PVector r2 = r_contact;
  PVector n = body1.dir;
  float COF = max(body1.COF, body2.COF);
  stroke(255, 0, 0);
  line_vec( body2.lin_pos, PVector.add( body2.lin_pos, r_contact));
  stroke(0, 255, 0);
  line_vec( PVector.add( body2.lin_pos, r_contact).add(PVector.mult(n, 50)), PVector.add( body2.lin_pos, r_contact));
  float Jr = impulse_cal(Vr,m1,m2,I1,I2,r1,r2,n,COF);
  body2.lin_vel.add(PVector.mult(n,Jr/m2));
  body2.ang_vel.add(PVector.mult(r2.cross(n),Jr/I2));
  //body2.lin_vel = body2.lin_vel.mult(-1);
  println(body2.kinetic_energy());
}
float impulse_cal(PVector Vr, float m1, float m2, float I1, float I2, PVector r1, PVector r2, PVector n, float COF) {
  float upper_term = -(1+COF)*Vr.dot(n);
  float lower_term = pow(m1, -1) + pow(m2, -1) + (PVector.mult(r1.cross(n), pow(I1, -1)).cross(r1).add( PVector.mult(r2.cross(n), pow(I2, -1)).cross(r2))).dot(n);  
  return upper_term/lower_term;
}