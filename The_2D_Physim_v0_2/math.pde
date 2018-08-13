float INF = Float.POSITIVE_INFINITY;
PVector sqrtVec (float val){
  
  if(val>=0)return new PVector(sqrt(val),0,0);
  else return new PVector(0,sqrt(-val),0);
}