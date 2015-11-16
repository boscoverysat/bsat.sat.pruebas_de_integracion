import processing.serial.*;
Serial tty;

int backgroundColor = 255;
int packets = 0;
int lost = 0;
int lastId = -1;


/**********Gradient Vars****************/
int X_AXIS = 2;
color gradientColor1, gradientColor2;
/***************************************/

String[] testing = {"0;0;4;-236;17244;-2480;182;159;-12;320;-474;-406;0;1;0;1",
"1;912;-572;-568;16784;0;203;124;20;322;-474;-408;0;1;0;1",
"1;912;-572;-568;16784;-2480;203;124;20;322;-474;-408;0;1;0;1",
"3;2681;-24;-216;17232;-2448;201;118;49;320;-472;-403;1;1;0;1",
"4;3571;132;-144;17372;-2480;180;86;36;320;-472;-406;0;1;0;1",
"5;4454;-64;-216;17304;-2448;197;149;47;321;-475;-405;1;1;0;1",
"7;6235;-16;-224;17172;-2448;192;100;31;321;-471;-404;0;1;0;0",
"8;7125;60;-100;17128;-2464;169;106;29;319;-472;-410;1;1;0;1",
"9;8010;88;-192;17124;-2432;183;118;14;322;-472;-411;0;0;1;1",
"10;8893;32;36;17192;-2448;183;124;38;320;-472;-408;1;1;0;1",
"11;9772;96;-108;17204;-2432;184;105;10;321;-473;-405;0;1;0;0",
"13;11564;80;-124;17156;-2432;182;107;27;324;-475;-409;1;1;0;1",
"14;12461;176;-92;17280;-2432;186;102;3;320;-473;-407;0;0;;1",
"15;13351;92;-184;17148;-2448;192;136;12;320;-477;-407;1;0;0;1",
"16;14247;-56;-100;17156;-2464;191;119;23;326;-476;-407;0;1;0;1",
"17;15149;8;-156;17108;-2416;195;137;9;322;-477;-408;0;0;1;1",
"18;16034;-48;-156;17208;-2432;198;142;26;324;-474;-409;0;1;0;1",
"19;16936;56;-116;17196;-2448;182;121;4;320;-475;-405;0;1;0;0",
"20;17826;48;-196;17320;-2432;195;133;29;321;-473;-406;1;1;0;1",
"21;18723;-56;-116;17176;-2448;205;121;27;320;-473;-409;0;1;0;1",
"22;19625;-4;-96;17216;-2464;182;89;37;320;-473;-406;0;1;0;1"};

void setup() {
  
  //TTY Config
  //tty = new Serial(this, Serial.list()[4], 9600);
  
  //Main Window
  size(1000, 600);
  surface.setTitle("BoscoverySAT - Telemetry Panel v0.1");
  background(backgroundColor);
  
  //Divider Line
  stroke(0);
  strokeWeight(2);
  line(0, 30, width, 30);                                                                             //Change Here
  line(width/2, height, width/2, 0);                                                                  //Change Here
  
  //Below Divider
  line(width/2, height - 30, width, height - 30);                                                     //Change Here
  
  //3D CubeSAT
  fill(0);
  textSize(20);
  String titlePanel1 = "3D Rendering of CubeSAT:";
  text(titlePanel1, ((width/2)/2) - textWidth(titlePanel1)/2, 20);                                    //Change Here
  
  //Telemetry
  fill(0);
  textSize(20);
  String titlePanel2 = "Telemetry Data:";
  text(titlePanel2, (width/2) + (((width/2)/2) - (textWidth(titlePanel2)/2)), 20);                    //Change Here

  //Temperature Divider
  line(width/2, 200, width, 200);                                                                     //Change Here 
  line(width/2, 400, width, 400);                                                                     //Change Here
  
  //Middle Dividers
  line(width/2, 230, width, 230);                                                                     //Change Here
  line(width/2 + (width/2)/2, 200, width/2 + (width/2)/2, 400);                                       //Change Here
  
  //Angular Velocity Dividers
  line(width/2, 310, width, 310);                                                                     //Change Here
  text("Angular Velocity:", width/2 + 40, 360);                                                       //Change Here
  
  //Acceleration Texts
  fill(0);
  textSize(20);
  String titlePanel3 = "Accelerations:";
  text(titlePanel3, (width/2) + ((width/2)/4) - (textWidth(titlePanel3)/2), 222);                     //Change Here
  
  //Magnetrometer Texts
  fill(0);
  textSize(20);
  String titlePanel4 = "Magnetometer:";
  text(titlePanel4, width - (width/2)/4 - (textWidth(titlePanel4)/2), 222);                           //Change Here
  
  //Temperature Gradient Colors
  gradientColor1 = color(255, 40, 40);
  gradientColor2 = color(172, 234, 255);
  
  //Packets Divider
  line(width/2 + (width/2)/2, height - 30, width/2 + (width/2)/2, height);                           //Change Here
  
}

int i = 0;
      
void draw() {  
  //String data;
  
  //while (tty.available() > 0){
     //data = tty.readStringUntil("\n");
     
     //String[] dataSplit = split(data, ";");
     //int temperature = 20;//getTemperature( int(dataSplit[5]) );
     
    
    if(i + 1 > testing.length){
      i = 0; 
    }
    
    String [] dataSplit = split(testing[i], ';');
    
    int packet = int(dataSplit[0]);
    
    float temperature = getTemperature( int(dataSplit[5]) );
    float acelX = getAcceleration( int(dataSplit[2]) );
    float acelY = getAcceleration( int(dataSplit[4]) );
    float acelZ = getAcceleration( int(dataSplit[5]) );
    
    float angX = getAngular( int(dataSplit[6]) );
    float angY = getAngular( int(dataSplit[7]) );
    float angZ = getAngular( int(dataSplit[8]) );
    
    float magX = getMagnetometer( int(dataSplit[9]) );
    float magY = getMagnetometer( int(dataSplit[10]) );
    float magZ = getMagnetometer( int(dataSplit[11]) );
    
    int ldr1 = int(dataSplit[12]);
    int ldr2 = int(dataSplit[13]);
    int ldr3 = int(dataSplit[14]);
    int ldr4 = int(dataSplit[15]);
       
    //Temperature Gradient
    setGradient((width/2) + (((width/2)/2) - (450/2)), 60, 450, 20, gradientColor2, gradientColor1, X_AXIS);        //Change Here
     
    //Temperature Indicator
    stroke(255);
    fill(255);
    rectMode(CORNERS);
    rect((width/2) + 235 + temperature, 61, width - 26, 79);                                                        //Change Here
    // Inicio X | Espacio | Grosor | Arriba | Espacio | Grosor | Abajo
    
    //Clear Temperature
    fill(backgroundColor);
    rect(width/2 + 20, 100, width - 20, 180);                                                                       //Change Here
     
    //Temperature Text
    fill(0);
    textSize(60);
    String temperatureString = nf(temperature, 2   , 2)+ " ºC";
    text(temperatureString, ((width/2) + (((width/2)/2))) - (textWidth(temperatureString)/2), 160);                 //Change Here
    
    //Clear Acelerations
    fill(backgroundColor);
    rect(width/2 + 5, 235, width/2 + ((width/2)/2) - 5, 305);                                                       //Change Here
    
    //Accelerations Texts
    fill(0);
    textSize(15);
    text("X Axis: " + nf(acelX, 3 ,2) + " m/s^2", width/2 + 10, 255);                                                //Change Here
    text("Y Axis: " + nf(acelY, 3 ,2) + " m/s^2", width/2 + 10, 275);                                                //Change Here
    text("Z Axis: " + nf(acelZ, 3 ,2) + " m/s^2", width/2 + 10, 295);                                                //Change Here
    
    //Clear Magnetometer
    fill(backgroundColor);
    rect(width/2 + ((width/2)/2) + 5, 235, width - 5, 305);                                                          //Change Here
    
    //Magnetometer Texts
    fill(0);
    textSize(15);
    text("X Magnetometer: " + str(magX), width/2 + (width/2)/2 + 10, 255);                                           //Change Here
    text("Y Magnetometer: " + str(magY), width/2 + (width/2)/2 + 10, 275);                                           //Change Here
    text("Z Magnetometer: " + str(magZ), width/2 + (width/2)/2 + 10, 295);                                           //Change Here
    
    //Clear Angular
    fill(backgroundColor);
    rect(width/2 + ((width/2)/2) + 5, 315, width, 395);                                                              //Change Here
    
    //Angular Texts
    fill(0);
    textSize(15);
    text("X Angular Velocity: " + str(angX), width/2 + (width/2)/2 + 10, 340);                                       //Change Here
    text("Y Angular Velocity: " + str(angY), width/2 + (width/2)/2 + 10, 360);                                       //Change Here
    text("Z Angular Velocity: " + str(angZ), width/2 + (width/2)/2 + 10, 380);                                       //Change Here
    
    //Clear Packets
    fill(backgroundColor);
    rect(width/2 + 4, height - 24, width/2 + (width/2)/2 - 4, height - 4);                                           //Change Here
    rect(width/2 + (width/2)/2 + 4, height - 24, width - 4, height - 4);                                             //Change Here
    
    //Packets Texts
    if(lastId + 1 != packet){
      for(int i = lastId + 2; i <= packet; i++){
        lost++;
      }
      //lost = lost + (packet - lastId);
    }
    lastId = packet;
    
    fill(0);
    textSize(15);
    text("Packets Received: " + str(packets), width/2 + 5, height - 8);                                           //Change Here
    text("Lost Packets: " + str(lost), width/2 + width/4 + 5, height - 8);                                        //Change Here
    
    //LDRs Squares
    stroke(0);
    textSize(40);
    
    fill(getFillLDR(ldr1));
    rect(width/2 + 25, 435, (width/2 + (width/2)/4) - 25, 510);                                                  //Change Here
    fill(getLDRText(ldr1));
    text("A", width/2 + 48, 485);                                                                                //Change Here
    
    fill(getFillLDR(ldr2));
    rect((width/2 + (width/2)/4) + 25, 435, (width/2 + ((width/2)/4) * 2) - 25, 510);                            //Change Here
    fill(getLDRText(ldr2));
    text("B", (width/2 + (width/2)/4) + 48, 485);                                                                //Change Here
    
    fill(getFillLDR(ldr3));
    rect((width/2 + ((width/2)/4) * 2) + 25, 435, (width/2 + ((width/2)/4) * 3) - 25, 510);                      //Change Here
    fill(getLDRText(ldr3));
    text("C", (width/2 + ((width/2)/4) * 2) + 48, 485);                                                          //Change Here
    
    fill(getFillLDR(ldr4));
    rect((width/2 + ((width/2)/4) * 3) + 25, 435, (width/2 + ((width/2)/4) * 4) - 25, 510);                      //Change Here
    fill(getLDRText(ldr4));
    text("D", (width/2 + ((width/2)/4) * 3) + 48, 485);                                                          //Change Here
    
    packets++;
    delay(1000);
    i++;
     
}
  
  //Aceleraciones
  
  //Velocidades Angulares
  
  //Sensores de Luminosidad
  
  //Nº Paquetes recibidos y perdidos
  
//}

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

int getFillLDR(int value){
  int fillColor = 255;
  if(value == 1){
      fillColor = 0;
   }
   return fillColor;
}

int getLDRText(int value){
  int fillColor = 0;
  if(value == 1){
      fillColor = 255;
   }
   return fillColor;
}

float getTemperature(int temp){
  float out = 0;
  out = (temp/340.00) + 36.53;
  return out;
}

float getAcceleration(int accel){
  float out = 0;
  out = (accel/16384.0) * 9.8;
  return out;
}

float getMagnetometer(int mag){
  float out = 0;
  out = ((mag * 0.73)/1000.0)*100.0;
  return out;
}

float getAngular(int ang){
  float out = 0;
  out = (ang/131.0);
  return out;
}