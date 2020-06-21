//import controlP5.*;

//ControlP5 cp5;

//float sliderValue = 0.025;
//Slider abc;

int cols, rows;
int scl = 10; //20 for triangles
int w = 1000;
int h = 1000;

float orbitDiv = 2;

float orbRadius = 150; // Size of the circle
int orbPoints = 16; // Number of points on the circe
float orbAngle=TWO_PI/(float)orbPoints; // Calculate the angle each point is on
float[][] orbArray; // Declare an array

float speed = 0.025;
float blue = 255;
float saveSpeed = 0;
boolean pause = false;

float movingVal = 0;

float[][] terrain;

void setup(){
  //size(600, 600, P3D);
  fullScreen(P3D);
  cols = w/scl;
  rows = h/scl;
  terrain = new float [cols][rows];
  
  // CREATE A LIST OF x & y CO-ORDINATES
  orbArray = new float [orbPoints][2]; // Setup the array dimentions
  for(int i=0;i<orbPoints;i++) { 
    float x = orbRadius*sin(orbAngle*i)+width/2;
    float y = orbRadius*cos(orbAngle*i)+height/2;
    //NEED SOMETHING HERE TO COMPARE ALL THE POINTS ON THE CIRCLE TO THE GRID
    //NEEDS QUANTIZING LOL 
    orbArray[i][0] = x; // Store the x co-ordinate
    orbArray[i][1] = y; // Store the y co-ordinate
  }
  
  //noStroke();
  //cp5 = new ControlP5(this);
  //cp5.addSlider("speedSliderValue")
  //   .setPosition(10,800)
  //   .setSize(100, 200)
  //   .setRange(0.001, 0.099)
  //   .setValue(0.025)
  //   ;
  
  //frameRate(1);
}

void draw(){
  
  movingVal -= speed;
  
  float yoffset = movingVal;
   for(int y = 0; y < rows; y++){
    float xoffset = 0; 
    for(int x = 0; x < cols; x++){
      terrain[x][y] = map(noise(xoffset, yoffset), 0, 1, -100, 100);
      xoffset += map(mouseX, 0, 600, 0.01, 0.9); 
     }
     yoffset += map(mouseY, 0, 600, 0.01, 0.9);
    }
    
  background(0);
  stroke(255, 60);
  //noStroke();
  //noFill(); 
  fill(map(mouseX, 0, 600, 0, 255), map(mouseY, 0, 600, 0, 255), blue, 30); //30 for triangles
   translate(width/2, height/2);
   rotateX(PI/3);
   rotateY(PI/50);
   rotateZ(PI/3);
   translate(-w/0.85, -h/1.008, -w/2);
 
  for(int y = 0; y < rows-1; y++){
    //beginShape(TRIANGLE_STRIP);
    for(int x = 0; x < cols; x++){
      //vertex(x*scl, y*scl, terrain[x][y]);
      //vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
      
      //This sets the colour of the circle
      if(circleCheck(x,y)){stroke(255,0,0);}
      else{stroke(0,0,255);}
      
      point(x*scl, y*scl, terrain[x][y]);


      //point(x*scl, (y+1)*scl);
      //rect(x*scl, y*scl, scl, scl);
    }
    //endShape();
    if(frameCount % 60 == 0){
      orbitDiv = orbitDiv + 1;
      if(orbitDiv > 10){orbitDiv = 1;}
    }
  }
}

void mousePressed(){
  speed = map(mouseY, 0, 600, 0.001, 0.099);
  blue = map(mouseY, 0, 600, 0, 255);
}

void mouseDragged(){
  speed = map(mouseY, 0, 600, 0.001, 0.099);
  blue = map(mouseY, 0, 600, 0, 255);
}

void keyPressed(){
  if(key == ENTER){
    pause = !pause;
    if(pause == true){
      saveSpeed = speed;
      speed = 0;
    }
    else if(pause == false){
      speed = saveSpeed;
    }
  }
}



//This is the checker function for the circle



bool circleCheck(int X, int Y){

  int x_Center= 50;
  int y_Center=50;
  int radius=25;
  int line_thickness=2;

  int scanvalue=(X-x_Center)^2 + (Y-y_Center)^2;
 
 if((scanvalue<radius^2+linethickness) && (scanvalue>radius^2-linethickness))
 {
 return true;
 } 
 return false;
}
