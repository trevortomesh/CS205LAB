float i = 0; // This will be our "iterative value" to move our animation along
int sizex = 200; // set canvas size
int sizey = 200; 

void setup(){
size(sizex,sizey); // Set the size. 
frameRate(60); // Set frame-rate because some computers are faster than others!  
}



void draw(){
  clear();
  background(#CCE1EA); 
  drawOrangi(sizex/2,50+100*pow(sin(i),2),#F57520); //Our custom "Orangi" function -- takes x position, y position and color.
  i+=.1; // move the animation along
}


void drawOrangi(float posx, float posy, color Color){
 drawLimbs(posx,posy); //draw the limbs relative to the body position
 
//Draw our body
 strokeWeight(2);
 fill(Color);
 ellipse(posx,posy,50,50); 
 //fill(#000000);
 //ellipse(posx,posy,10,10); 
 
 
 drawEye(posx,posy);
 
}

void drawEye(float eyex, float eyey){
   float blink = random(0,100);
   //println(blink);
   fill(#000000);
   if(blink > 98){
     ellipse(eyex,eyey,10,1);
   }
   else{
   ellipse(eyex,eyey,10,10); 
}
}

void drawLimbs(float px, float py){
  strokeWeight(2);
  float l = 50;
  float rs = px+25; //right shoulder
  float ls = px-25; //left shoulder
  line(rs,py,rs+l*abs(cos(i)),py+l*abs(sin(i)));
  line(ls,py,ls-l*abs(cos(i)),py+l*abs(sin(i)));
  
  
}
