class Drawer {
  Processor processor;
  Device device;
  int margin;
  float scale;
  float device_scaled_width;
  float device_scaled_height;
  float device_x;
  float device_y;

  Drawer(Processor t_processor, Device t_device) {
    processor = t_processor;
    device = t_device;

    margin = 50;
    scale = min(width / device.d_width, height / device.d_height);
    device_scaled_width = device.d_width * scale;
    device_scaled_height = device.d_height * scale;
    device_x = (width - device_scaled_width) / 2;
    device_y = (height - device_scaled_height) / 2;
  }

  void display() { 
    translate(device_x, device_y, 0);
    showDevice();
    for (Canvas canvas : processor.canvases) {
      showCanvas(canvas);
    }
    for (int i = 0; i < processor.paths.size(); i++) {
      showPath(processor.paths.get(i));
    }
    /*for (PShape path : processor.paths) {
      showPath(path);
    }*/
  }

  void display(color c) {
    stroke(c);
    display();
  }
  
  void showPath(Path path) { //<>// //<>// //<>//
    for (int i = 0; i < path.vertices.size() - 1; i++) {
      PVector p1 = path.vertices.get(i);
      PVector p2 = path.vertices.get(i + 1);
      pushMatrix();
      stroke(0);
      strokeWeight(2);
      line(p1.x * scale, p1.y * scale, p2.x * scale, p2.y * scale);
      popMatrix();
    }
  }
  
  void showCanvas(Canvas canvas) {
    pushMatrix();
    fill(255);
    noStroke();
    rect(canvas.x * scale, canvas.y * scale, canvas.c_width * scale, canvas.c_height * scale);
    popMatrix();
  }

  void showDevice() {
    pushMatrix();
    fill(71);
    noStroke();
    rect(0, 0, device_scaled_width, device_scaled_height);
    popMatrix();
  }
}
