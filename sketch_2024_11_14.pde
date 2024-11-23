float px, py, ps, pl, pr, pt, pb;
float bx, by, block_w, block_h;
int i, j, rows, cols;
boolean w_flag, a_flag, s_flag, d_flag; // block atari hanntei\
boolean clicked;
//boolean is_alive[][] = new boolean[5][5];
int is_alive[][] = new int[6][6];
int facing_flag;
PVector a,b,c;
PImage arrow,top,bottom,right,left,player,axe,block_sokumen,block_tenjo,block_corner,block_strate;

// 減算の間隔（ミリ秒単位）
int interval = 500;  // 500ミリ秒ごとに減算を実行
// 最後に減算した時刻を保持
float lastTime = 0;

void setup() {
  //px = width/2;
  //py = height/2;
  px = 32;
  py = 32;
  ps = 32;
 
  block_w = ps;
  block_h = ps;
  
  rows = 6;
  cols = 6;
  
  for(int i=0;i<cols;i++){
    for(int j=0;j<rows;j++){
      is_alive[i][j] = 3;
    }
  }
  
 setOuterValuesToZero(is_alive);
 
 printArray(is_alive);
 
 arrow = loadImage("imgs/arrow.png");
 top = loadImage("imgs/top.png");
 bottom = loadImage("imgs/bottom.png");
 left = loadImage("imgs/left.png");
 right = loadImage("imgs/right.png");
 axe = loadImage("imgs/axe.png");
 block_sokumen = loadImage("imgs/sokumen.png");
 block_tenjo = loadImage("imgs/tenjo.png");
 block_corner = loadImage("imgs/corner3.png");
 block_strate = loadImage("imgs/strate.png");
 
  size(640, 480);
 
  
  smooth();
  frameRate(60);
  background(255,255,255);
}

void draw() {
  translate(width/2, height/2);
  background(255,255,255);
  pl = px;
  pr = px+ps;
  pt = py;
  pb = py+ps;
  
  //camera();
 
 
  // BLOCK
  w_flag = false;
  a_flag = false;
  s_flag = false;
  d_flag = false;
  
  for(i=0;i<cols;i++){
    for(j=0;j<rows;j++){
      bx = i*block_w+32;
      by = j*block_h+32;
       
      
      if(is_alive[i][j] > 0)
      {
        if (is_alive[i-1][j]==0 & is_alive[i][j-1]==0) {
          image(block_corner, bx, by, block_w, block_h);
        } else if (is_alive[i+1][j]==0 & is_alive[i][j-1]==0) {
          drawBlock(block_corner, bx, by, PI/2);
        } else {
          image(block_tenjo, bx, by, block_w, block_h);
        }
        
        
        if (is_alive[i][j+1] == 0) {
          image(block_sokumen, bx, by+block_h, block_w, block_h * 3 / 4);
        } 
        
        fill(0);
        rect(px, py, 4, 4);
        rect(pr, pb, 4, 4);
        rect(bx, by, 4, 4);
      
       // W
       if((pt == by+block_h && pl >= bx && pr <= bx+block_w)){
          if(facing_flag == 2 && mousePressed && millis() - lastTime > interval) {  // 時間が経過した場合のみ
            is_alive[i][j] -= 1;
            println("is_alive", is_alive[i][j]);
            lastTime = millis();  // 最後の減算時刻を更新
          }
         w_flag = true;
       }
      
       // A
       if((pl == bx+block_w && pt >= by && pb <= by+block_h)){
         if(facing_flag == 1 && mousePressed && millis() - lastTime > interval) {  // 時間が経過した場合のみ
            is_alive[i][j] -= 1;
            println("is_alive", is_alive[i][j]);
            lastTime = millis();  // 最後の減算時刻を更新
          }
        a_flag = true;
       }
      
       // S
       if((pb == by && pl >= bx && pr <= bx+block_w)){
         if(facing_flag == 0 && mousePressed && millis() - lastTime > interval) {  // 時間が経過した場合のみ
            is_alive[i][j] -= 1;
            println("is_alive", is_alive[i][j]);
            lastTime = millis();  // 最後の減算時刻を更新
          }
         s_flag = true;
       }
      
       // D
       if((pr == bx && pt >= by && pb <= by+block_h)){
          if(facing_flag == 3 && mousePressed && millis() - lastTime > interval) {  // 時間が経過した場合のみ
            is_alive[i][j] -= 1;
            println("is_alive", is_alive[i][j]);
            lastTime = millis();  // 最後の減算時刻を更新
          }
         d_flag = true;
       }
      }  
    }
  }
  // BLOCK
  
  // PLAYER
  a = new PVector((mouseX - width/2), -(mouseY - height/2));
  b = new PVector(px, -py);
  c = PVector.sub(a, b);
  //float rad = calc_angle(new PVector(1, 0), c);
  
    // 向きの判定
  if (c.y < 0 && abs(c.x) <= abs(c.y)) {
    facing_flag = 0; 
  } else if (c.x < 0 && abs(c.x) >= abs(c.y)) {
    facing_flag = 1; 
  } else if (c.y > 0 && abs(c.x) <= abs(c.y)) {
    facing_flag = 2; 
  } else if (c.x > 0 && abs(c.x) >= abs(c.y)) {
    facing_flag = 3; 
  }

  // デバッグ用出力
  //println("facing_flag:", facing_flag); // 向きをコンソールに表示

  
  pushMatrix();
    translate(px, py);
    fill(0);
    //rotate(a.y >= b.y ? -(rad - HALF_PI) : (rad + HALF_PI));
    //image(arrow, -ps/2,-ps/2, ps, ps);
    if (facing_flag == 0) {
      player = bottom;
    } else if (facing_flag == 1) {
      player = left;
    } else if (facing_flag == 2) {
      player = top;
    } else if (facing_flag == 3) {
      player = right;
    }
    //rotate(-PI/8);
    //image(axe, -ps/2-10,-ps/2, 28, 28);
    //rotate(PI/8);
    image(player, 0, ps-player.height, ps, ps);
  popMatrix();
  
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

void setOuterValuesToZero(int[][] array) {
  int rows = array.length;
  int cols = array[0].length;

  // 上辺（左から右）
  for (int col = 0; col < cols; col++) {
    array[0][col] = 0;
  }

  // 右辺（上から下、ただし最上部と最下部は除く）
  for (int row = 1; row < rows - 1; row++) {
    array[row][cols - 1] = 0;
  }

  // 下辺（右から左）
  for (int col = cols - 1; col >= 0; col--) {
    array[rows - 1][col] = 0;
  }

  // 左辺（下から上、ただし最上部と最下部は除く）
  for (int row = rows - 2; row > 0; row--) {
    array[row][0] = 0;
  }
}

void printArray(int[][] array) {
  for (int[] row : array) {
    println(row);
  }
}

void drawRect(float x, float y, float w ,float h) {
  fill(0,0,0);
  rect(x,y,w,h);
}

void drawBlock(PImage img, float x, float y, float rad) {
  pushMatrix();
    translate(x+ps/2, y+ps/2);
    rotate(rad);
    image(img, -ps/2, -ps/2, block_w, block_h);
  popMatrix();
}


float calc_angle(PVector a, PVector b){
  float cos_theta = a.dot(b) / (a.mag() * b.mag());
  float theta = acos(cos_theta);
  return theta;
}
