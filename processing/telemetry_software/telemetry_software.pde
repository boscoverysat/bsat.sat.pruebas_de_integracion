import processing.serial.*;
Serial tty;

int backgroundColor = 255;

/**********Gradient Vars****************/
int X_AXIS = 2;
color gradientColor1, gradientColor2;
/***************************************/

String[] testing = {"0;0;4;-236;17244;-2480;182;159;-12;320;-474;-406",
"1;912;-572;-568;16784;-2480;203;124;20;322;-474;-408",
"3;2681;-24;-216;17232;-2448;201;118;49;320;-472;-403",
"4;3571;132;-144;17372;-2480;180;86;36;320;-472;-406",
"5;4454;-64;-216;17304;-2448;197;149;47;321;-475;-405",
"7;6235;-16;-224;17172;-2448;192;100;31;321;-471;-404",
"8;7125;60;-100;17128;-2464;169;106;29;319;-472;-410",
"9;8010;88;-192;17124;-2432;183;118;14;322;-472;-411",
"10;8893;32;36;17192;-2448;183;124;38;320;-472;-408",
"11;9772;96;-108;17204;-2432;184;105;10;321;-473;-405",
"13;11564;80;-124;17156;-2432;182;107;27;324;-475;-409",
"14;12461;176;-92;17280;-2432;186;102;3;320;-473;-407",
"15;13351;92;-184;17148;-2448;192;136;12;320;-477;-407",
"16;14247;-56;-100;17156;-2464;191;119;23;326;-476;-407",
"17;15149;8;-156;17108;-2416;195;137;9;322;-477;-408",
"18;16034;-48;-156;17208;-2432;198;142;26;324;-474;-409",
"19;16936;56;-116;17196;-2448;182;121;4;320;-475;-405",
"20;17826;48;-196;17320;-2432;195;133;29;321;-473;-406",
"21;18723;-56;-116;17176;-2448;205;121;27;320;-473;-409",
"22;19625;-4;-96;17216;-2464;182;89;37;320;-473;-406"};

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
  
  //Middle Dividers
  line(width/2, 230, width, 230);                                                                     //Change Here
  line(width/2 + (width/2)/2, 200, width/2 + (width/2)/2, 400);                                       //Change Here
  
  //Temperature Gradient Colors
  gradientColor1 = color(255, 40, 40);
  gradientColor2 = color(172, 234, 255); 
  
}
      
void draw() {  
  //String data;
  
  //while (tty.available() > 0){
     //data = tty.readStringUntil("\n");
     
     //String[] dataSplit = split(data, ";");
     //int temperature = 20;//getTemperature( int(dataSplit[5]) );
     
  for (String data : testing) {
    //print (data + '\n');
    String [] dataSplit = split(data, ';');
    int temperature = getTemperature( int(dataSplit[6]) );
       
    //Temperature Gradient
    setGradient((width/2) + (((width/2)/2) - (450/2)), 60, 450, 20, gradientColor2, gradientColor1, X_AXIS);         //Change Here
     
    //Temperature Indicator
    stroke(255);
    fill(255);
    rectMode(CORNERS);
    rect((width/2) + 235 + temperature, 61, width - 26, 79);                                                         //Change Here
    // Inicio X | Espacio | Grosor | Arriba | Espacio | Grosor | Abajo
    
    //Clear Temperature
    fill(backgroundColor);
    rect(width/2 + 20, 100, width - 20, 180);                                                                        //Change Here
     
    //Temperature Text
    fill(0);
    textSize(60);
    text(str(temperature)+ " ºC", ((width/2) + (((width/2)/2))) - 75, 160);                                          //Change Here
   
    print(str(temperature) + '\n');
    delay(1000);
        
  }
     
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

int getTemperature(int temp){
  return temp;
} 