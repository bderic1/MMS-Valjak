  PImage slika; 
  float b; 

void setup() {
  size(800, 800, P3D);
  slika=loadImage("slika.png"); 
  b=slika.width/(2*PI);
  
}

void draw() {
  background(0);
  lights();
  translate(width / 2, height/3);
  if(mousePressed)
  {
    rotateY(map(mouseX, 0, width, 0, PI));
    rotateZ(map(mouseY, 0, height, 0, -PI));
  }
  noStroke();
  fill(255, 255, 255);
  translate(0, -40, 0);
  valjak(b, slika.height, 50); 
}
void valjak(float radijus, float visina,int broj_stranica)
{
  float kut=0; 
  float kutpovecavanja=2*PI/broj_stranica; 
  beginShape(QUAD_STRIP);
  for(int i = 0; i <= broj_stranica; ++i) 
  {
    vertex(radijus*cos(kut), 0, radijus*sin(kut));
    vertex(radijus*cos(kut), visina, radijus*sin(kut));
    kut += kutpovecavanja;
  }
  endShape();
  
  //donji krug
  kut = 0;
  beginShape(TRIANGLE_FAN);
  vertex(0, 0, 0);
  for(int i = 0; i <=broj_stranica; i++) 
  {
      vertex(radijus * cos(kut), 0, radijus * sin(kut));
      kut += kutpovecavanja;
    }
    endShape();
  //gornji krug
  kut = 0;
  beginShape(TRIANGLE_FAN);
  vertex(0, visina, 0);
  for (int i = 0; i <= broj_stranica; i++) 
  {
    vertex(radijus * cos(kut),visina, radijus * sin(kut));
      kut += kutpovecavanja;
  }
    endShape();
  
}
