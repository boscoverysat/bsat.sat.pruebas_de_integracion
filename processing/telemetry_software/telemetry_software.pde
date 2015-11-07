
import processing.serial.*;
Serial tty;

/**********Gradient Vars****************/
int X_AXIS = 2;
color gradientColor1, gradientColor2;
/***************************************/

void setup() {
  
  //TTY Config
  tty = new Serial(this, Serial.list()[4], 9600);
  
  //Main Window
  size(1000, 600);
  surface.setTitle("BoscoverySAT - Telemetry Panel v0.1");
  background(255);
  
  //Divider Line
  stroke(0);
  strokeWeight(2);
  line(0, 30, width, 30);                                                                             //Change Here
  line(width/2, height, width/2, 0);                                                                  //Change Here
  
  //3D CubeSAT
  fill(0);
  textSize(20);
  String titlePanel1 = "3D Rendering of CubeSAT:";
  text(titlePanel1, ((width/2)/2) - textWidth(titlePanel1)/2, 20);                                   //Change Here
  
  //Telemetry
  fill(0);
  textSize(20);
  String titlePanel2 = "Telemetry Data:";
  text(titlePanel2, (width/2) + (((width/2)/2) - (textWidth(titlePanel2)/2)), 20);                    //Change Here

  //Temperature Divider
  line(width/2, 200, width, 200);                                                                     //Change Here
  
  line(width/2, 400, width, 400);                                                                     //Change Here
  
  //Temperature Gradient Colors
  gradientColor1 = color(255, 40, 40);
  gradientColor2 = color(172, 234, 255);
  
}
      
void draw() {  
  String data;
  
  while (tty.available() > 0){
     data = tty.readStringUntil('\n');
     
     String[] dataSplit = split(data, ';');
     int temperature = getTemperature( int(dataSplit[5]) );
     
     //Temperature Gradient
     setGradient((width/2) + (((width/2)/2) - (450/2)), 60, 450, 20, gradientColor2, gradientColor1, X_AXIS);         //Change Here
     
     
     //Temperature Indicator
     stroke(255);
     fill(255);
     rectMode(CORNERS);
     rect((width/2) + 235 + temperature, 61, width - 26, 79);                                                         //Change Here
     // Inicio X | Espacio | Grosor | Arriba | Espacio | Grosor | Abajo
     
     //Temperature Text
     fill(0);
     textSize(60);
     text(str(temperature)+ " ºC", ((width/2) + (((width/2)/2))) - 75, 160);                                          //Change Here
     
  }
  
  //Aceleraciones
  
  //Velocidades Angulares
  
  //Sensores de Luminosidad
  
  //Nº Paquetes recibidos y perdidos
  
}

void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

  noFill();
  if (axis == X_AXIS) {  // Left to right gradient
    for (int i = x; i <= x + w; i++) {
      float inter = map(i, x, x + w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y + h);
    }
  }
  
}

int getTemperature(int temp){
  return temp;
}