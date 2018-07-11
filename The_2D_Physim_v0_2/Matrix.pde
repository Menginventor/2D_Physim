class mat {
  int row, col;
  float[][] ele;
  mat(int _row, int _col) {
    row = _row;
    col = _col;
    ele = new float[row][col];
  }
  float det() {
    //row must equal col
    if (row == 1)return ele[0][0]; 
    else {
      int i = 0;
      float sum = 0;
      for (int j = 0; j<col; j++) {
        sum += ele[i][j]*cof(i, j);
      }
      return sum;
    }
  }
  float cof (int i, int j) {
    return pow(-1, i+j) * minor(i, j);
  }
  float minor(int _i, int _j) {
    mat minor_mat = new mat(row-1, col-1);
    for (int i = 0; i< minor_mat.row; i++) {
      for (int j = 0; j< minor_mat.col; j++) {
        if (i<_i && j<_j)minor_mat.ele[i][j] = ele[i][j];
        else if (i<_i && j>=_j)minor_mat.ele[i][j] = ele[i][j+1];
        else if (i>=_i && j<_j)minor_mat.ele[i][j] = ele[i+1][j];
        else if (i>=_i && j>=_j)minor_mat.ele[i][j] = ele[i+1][j+1];
      }
    }
    return minor_mat.det();
  }
  void set_ele(float[][] _ele) {
    for (int i = 0; i<row; i++) {
      for (int j = 0; j<col; j++) {
        ele[i][j] =  _ele[i][j];
      }
    }
  }
  mat transpose() {
    mat result = new mat(row, col);
    for (int i = 0; i<row; i++) {
      for (int j = 0; j<col; j++) {
        result.ele[i][j] =  ele[j][i];
      }
    }
    return result;
  }

  void mat_print() {
    for (int i = 0; i<row; i++) {
      print("[ ");
      for (int j = 0; j<col; j++) {
        print(ele[i][j]);
        if (j<col-1)print(" , ");
      }
      println(" ]");
    }
  }

  mat adj() {
    mat result = new mat(row, col);
    for (int i = 0; i<row; i++) {
      for (int j = 0; j<col; j++) {
        result.ele[i][j] =  cof(i, j);
      }
    }
    return result.transpose();
  }
  mat mat_scale(float a) {
    mat result = new mat(row, col);
    for (int i = 0; i<row; i++) {
      for (int j = 0; j<col; j++) {
        result.ele[i][j] =  a*ele[i][j];
      }
    }
    return result;
  }
  mat inv() {
    return adj().mat_scale(pow(det(), -1));
  }
  PVector toVector() {
    return new PVector(ele[0][0], ele[1][0], ele[2][0]) ;
  }
}


mat mat_mult(mat A, mat B) {
  mat result = new mat(A.row, B.col);
  for (int i = 0; i<result.row; i++) {
    for (int j = 0; j<result.col; j++) {
      result.ele[i][j] = 0;
      for (int k = 0; k<A.col; k++) {
        result.ele[i][j] += A.ele[i][k]*B.ele[k][j];
      }
    }
  }
  return result;
}

mat RZ(float theta) {
  mat R = new mat(3, 3);
  R.set_ele(new float[][]{
    {cos(theta), -sin(theta), 0}, 
    {sin(theta), cos(theta), 0}, 
    {0, 0, 1}

    });
    return R;
}

mat V2M(PVector v){
  mat m = new mat(3, 1);
  m.set_ele(new float[][]{
    {v.x}, 
    {v.y}, 
    {v.z}

    });
    return m;
}