  PImage slika; 
  PImage mask; 

  float b; 

void setup() {
  size(800, 800, P3D);
  slika=loadImage("slika.png"); 
  b=slika.width/(2*PI); //b je radijus valjka, širina slike/2pi
}

void draw() {
  background(0);
  lights();
  translate(width / 2, height/3);
  if(mousePressed)//Za kameru, treba podesiti, nije baš idealno
  {
    rotateY(map(mouseX, 0, width, 0, PI));
    rotateZ(map(mouseY, 0, height, 0, -PI));
  }
  noStroke();
  fill(255, 255, 255);
  translate(0, -40, 0);
  crtaj_valjak(b, slika.height, 15); 
}

void crtaj_valjak(float radijus, float visina,int broj_stranica)
{
  //s tim da broj_stranica je ujedno i broj na koliko ćemo dijelova dijeliti sliku
  float kut=0; 
  float kutpovecavanja=2*PI/broj_stranica; 
  beginShape(QUAD_STRIP); 
  //objašnjenje quad stripa i triangle fana
  //https://processing.org/reference/beginShape_.html
  for(int i = 0; i <= broj_stranica; ++i) 
  {
    vertex(radijus*cos(kut), 0, radijus*sin(kut));
    vertex(radijus*cos(kut), visina, radijus*sin(kut));
    kut += kutpovecavanja;
  }
  endShape();
  
  //tu sam pozvala fju za stavljanje slika na valjak
  stavi_sliku(radijus, kut, kutpovecavanja, broj_stranica); 
  
  //gornji krug
  kut = 0;  
  beginShape(TRIANGLE_FAN);
  vertex(0, 0, 0);
  for(int i = 0; i <=broj_stranica; i++) 
  {
      vertex(radijus * cos(kut), 0, radijus * sin(kut));
      kut += kutpovecavanja;
    }
    endShape();
  //donji krug
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
void stavi_sliku(float radijus,float kut, float kutpovecavanja, int broj_stranica)
{
  float pomak_slike=slika.width/broj_stranica; //za koliko se miče odrezani pravokutnik
  pushMatrix(); 
  kut=2*PI;
  int i=0;
  for(i=0; i<broj_stranica; i++)
  {
  translate(radijus*cos(kut-i*kutpovecavanja), 0, radijus*sin(kut-i*kutpovecavanja));
  rotateY(PI/2+kutpovecavanja/2+i*kutpovecavanja); 
  kreiraj_masku(i, broj_stranica);
  if(i%5==0) //ovo sam stavila za isprobati, ali sad se vidi da nešto ovdje ne štima
  //ili je kriva maska ili su krive translacija i rotacija
  {
  slika.mask(mask);
  image(slika,-pomak_slike*i,0);
  }
  rotateY(-PI/2-kutpovecavanja/2-i*kutpovecavanja); 
  translate(-radijus*cos(kut-i*kutpovecavanja), 0, -radijus*sin(kut-i*kutpovecavanja));

  }
   
  popMatrix();
}


void kreiraj_masku(int koji, int broj_stranica)
{
mask = createImage(slika.width, slika.height, RGB);
  mask.loadPixels();
  for(int x=0; x<mask.height; x++)
  for(int y=0; y<mask.width; y++)
  {
    int i=mask.width*x+y; 
    if(y<(mask.width/broj_stranica)*(koji+1)&&y>(mask.width/broj_stranica)*(koji)) 
      mask.pixels[i]=color(255,255,255);
    else
      mask.pixels[i]=color(0,0,0);

  }
 
  mask.updatePixels();
}
