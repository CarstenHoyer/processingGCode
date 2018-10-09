class Cube extends Creator {
  Cube(Device t_printer, Settings t_settings) {
    super(t_printer, t_settings);
  }
  
  void generate (float c_x, float c_y, float length_side_cube) {
    generate(c_x, c_y, length_side_cube, 0);
  }
  
  void generate(float c_x, float c_y, float length_side_cube, float rotation) {
    paths = new ArrayList<Path>();
    Path path = new Path();
    PVector p1 = new PVector(c_x, c_y);
    path.add(p1);
    path.add(new PVector(c_x + length_side_cube, c_y));
    path.add(new PVector(c_x + length_side_cube, c_y + length_side_cube));
    path.add(new PVector(c_x, c_y + length_side_cube));
    path.add(p1);
    paths.add(path);
    if (abs(rotation) > 0) {
      path.rotate(rotation, c_x, c_y, length_side_cube);
    }
  }
}
