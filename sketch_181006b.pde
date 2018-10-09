import java.util.Collections;
import java.util.Comparator;

Device _printer;
Settings _settings;
Processor _processor;
Drawer _drawer;
GcodeGenerator _gcodeGenerator;
ArrayList<PShape> paths = new ArrayList<PShape>();

void setup() {
  size(800, 600, P3D);
  noLoop();
  
  _printer = new Device();
  _settings = new Settings();
  
  Canvas canvas1 = new Canvas(10, 10, 210, 297);
  Canvas canvas2 = new Canvas(300, 5, 297, 420);
  Canvas canvas3 = new Canvas(10, 430, 1189, 841);
  
  Cube cube1 = new Cube(_printer, _settings);
  cube1.generate(20, 500, 200, 45);
  Cube cube2 = new Cube(_printer, _settings);
  cube2.generate(50, 700, 200);
  
  _processor = new Processor();
  _processor
    .addCanvas(canvas1)
    .addCanvas(canvas2)
    .addCanvas(canvas3)
    .addObject(cube1)
    .addObject(cube2)
    .sortPaths();
  
  _drawer = new Drawer(_processor, _printer);
  
  _gcodeGenerator = new GcodeGenerator(_printer, _settings, _processor);
  _gcodeGenerator.generate().export();
}

void draw() {
  background(46);
  _drawer.display();
}
