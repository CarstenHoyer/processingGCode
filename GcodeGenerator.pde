class GcodeGenerator {
  
  ArrayList<String> gcode;
  Device printer;
  Settings settings;
  Processor processor;
  
  GcodeGenerator(Device t_printer, Settings t_settings, Processor t_processor) {
    printer = t_printer;
    settings = t_settings;
    processor = t_processor;
  }
  
  GcodeGenerator generate() {
    gcode = new ArrayList<String>();
    startPrint();
    for (Path path : processor.paths) {
      moveTo(path.vertices.get(0));
      write("G1 Z0"); //Go to height 0
      for (int i = 0; i < path.vertices.size() - 1; i++) {
        PVector p1 = path.vertices.get(i);
        PVector p2 = path.vertices.get(i+1);
        moveTo(p1, p2);
      }
      write("G1 Z1"); //Go to height 0
    }
    endPrint();
    return this;
  }
  
  void write(String command) {
    gcode.add(command);
  }
  
  void moveTo(PVector p) {
    write("G1 " + "X" + p.x + " Y" + p.y + " F" + settings.travel_speed);
  }
  
  void moveTo(PVector p1, PVector p2) {
    write("G1 " + "X" + p2.x + " Y" + p2.y);
  }
  
  void startPrint() {
    write("G91"); //Relative mode
    write("G1 Z1"); //Up one millimeter
    write("G28"); //Home X and Y axes
    write("G90"); //Absolute mode
  }
  
  void endPrint() {
    write("G1 Z1"); //Up one millimeter
    write("G28");
  }
  
  void export() {
    //Create a unique name for the exported file
    String name_save = "gcode_"+day()+""+hour()+""+minute()+"_"+second()+".g";
    //Convert from ArrayList to array (required by saveString function)
    String[] arr_gcode = gcode.toArray(new String[gcode.size()]);
    // Export GCODE
    print(arr_gcode);
    saveStrings(name_save, arr_gcode);
  }
}
