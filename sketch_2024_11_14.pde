float px, py, ps, pl, pr, pt, pb;
float bx, by, block_w, block_h;
int i, j;
boolean w_flag, a_flag, s_flag, d_flag; // block atari hanntei
boolean is_alive[][] = new boolean[5][5];
int facing_flag; //0=top, 1=left, 2=bottom, 3=right

void setup() {
  //px = width/2;
  //py = height/2;
  px = 50;
  py = 50;
  ps = 16;
 
  block_w = ps;
  block_h = ps;
  
  for(int i=0;i<5;i++){
    for(int j=0;j<5;j++){
      is_alive[i][j] = true;
    }
  }
 
  size(640, 480);
 
  noStroke();
  smooth();
  background(255,255,255);
}

void draw() {
  translate(width/2, height/2);
  background(255,255,255);
  pl = px;
  pr = px+ps;
  pt = py;
  pb = py+ps;
  
  println("px py", px, py);
 
  // BLOCK
  w_flag = false;
  a_flag = false;
  s_flag = false;
  d_flag = false;
  
  for(i=0;i<5;i++){
    for(j=0;j<5;j++){
      bx = i*block_w+64;
      by = j*block_h+64;
      
      if(is_alive[i][j])
      {
        fill(84);
        rect(bx, by, block_w, block_h, 20);
      
       // W
       if((pt == by+block_h && pl >= bx && pr <= bx+block_w)){
         w_flag = true;
       }
      
       // A
       if((pl < bx+block_w && pt >= by && pb <= by+block_h)){
         a_flag = true;
         is_alive[i][j] = false;
       }
      
       // S
       if((pb == by && pl >= bx && pr <= bx+block_w)){
         s_flag = true;
       }
      
       // D
       if((pr == bx && pt >= by && pb <= by+block_h)){
         d_flag = true;
       }
      }  
    }
  }
  // BLOCK
  
  // PLAYER
  //pushMatrix();
    
    PVector a = new PVector(mouseX - width/2, -1*(mouseY - height/2));
    PVector b = new PVector(px, py);
    PVector c = PVector.sub(a, b);
    float rad = calc_angle(new PVector(1, 0), c);
  
    //triangle((pl+pr)/2, pt, pr, pb, pl, pb);
    //drawRect(px,py,ps,ps);
    drawRect(0,0,10,10);
  //popMatrix();
  pushMatrix();
    //println(b.x, -b.y);
    fill(0);
    translate(px+ps/2, py+ps/2);
    drawRect(0,0,10,10);
    rotate(a.y >= b.y ? -(rad - HALF_PI) : (rad + HALF_PI));
    drawRect(-ps/2,-ps/2,ps,ps);
    //triangle((pl+pr)/2, pt, pr, pb, pl, pb);
  popMatrix();
  
}

void drawRect(float x, float y, float w ,float h) {
  fill(0,0,0);
  rect(x,y,w,h);
}

Float calc_angle(PVector a, PVector b){
  float cos_theta = a.dot(b) / (a.mag() * b.mag());
  float theta = acos(cos_theta);
  return theta;
}

void keyPressed(){
  if(key == 'w' && py > -height/2) {
    if(!w_flag) py -= ps;
  }
  if(key == 's' && py + ps < height/2) {
    if(!s_flag) py += ps;
  }
  if(key == 'a' && px > -width/2) {
    if(!a_flag) px -= ps;
  }
  if(key == 'd' && px + ps < width/2) {
    if(!d_flag) 
    px += ps;
  }
}
