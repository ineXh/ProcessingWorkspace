int CountStartTime;
boolean Stage_inter = false;
boolean Stage_started = false;
boolean Stage_ended = false;
String msg;
void draw_stage(int Stage){
  switch (Stage){
    case 0:
    if(GameState == 0){
      playbutton.draw();
      quitbutton.draw();
    }
      //GameStage++;
      break;
    case 1:                       
        StageStandard();        
      break;
    case 2:
        if(!Stage_inter){
          HPMax+= 5;
          hippo.HP = HPMax;
          hippo.damping += 0.01;
        }
        StageStandard();
      break;
    case 3:
      if(!Stage_inter){
            HPMax+= 5;
            hippo.HP = HPMax;
            hippo.damping += 0.01;
        }
        StageStandard();
      break;
   case 4:
      if(!Stage_inter){
            HPMax+= 5;
            hippo.HP = HPMax;
            hippo.damping += 0.01;
        }
        StageStandard();
      break;  
    case 5:
      GameState = 0;
       background(0, 0, 0);  
       textFont(Msgfont,64);
       text("You Win", width*3/10, height*45/100);
       playbutton.draw();
       quitbutton.draw();  
    case -1:
    textFont(Msgfont,64);
    if(Winner == 2) text("You Lose", width*3/10, height*45/100);
    if(GameState == 0){
      playbutton.draw();
      quitbutton.draw();
    }
      break;      
    default:
      break;
  }  
}
void StageStandard(){
  if(!Stage_inter){
    background(0, 0, 0);
    GameState = 0;
    Stage_inter = true;
    CountStartTime = millis();
    fill(255,0,0, 255);
    textFont(Msgfont,64);
    msg = "Stage " + GameStage + " Start";
    text(msg, width*2/10, height*45/100);
  }        
  if(millis() - CountStartTime > 2000 && !Stage_ended){
    GameState = 1;
    //GameStage++;
    Stage_started = true;
    background(0, 0, 0);
  }
  if(Stage_started){
    DrawStandard();
    if(Winner == 1){
      CountStartTime = millis();
      Stage_ended = true;
      Stage_started = false;
    }          
  }
  if(Winner == 1){                              
    fill(255,0,0, 255);
    textFont(Msgfont,64);
    msg = "Stage " + GameStage + " Complete";
    text(msg, width*1/10, height*45/100);
     if(millis() - CountStartTime > 2000){
        GameState = 1;
        GameStage++;
        Winner = 0;
        cow.loseHP(-1);   
        Stage_inter = false;
        Stage_started = false;
        Stage_ended = false;       
     }                                    
   }
}
void DrawStandard(){
    
    // Background
      //noStroke();
      fill(10, 20, 30, 40 + second()*2);
      rect(0, 0, width, height);
  
      // Move and display the orb
      orb.move();
      orb.Draw();
      // Check walls
      orb.checkWallCollision();

     // Check against all the ground segments
     orb.checkGround(ground_B);
     orb.checkGround(ground_R);
     orb.checkGround(ground_T);
     orb.checkGround(ground_L);
     orb.checkCharacterCollision(cow);
     orb.checkCharacterCollision(hippo);
         
      Update();
      fill(0, 200, 0, 1);
      ground_B.Draw();
      ground_R.Draw();
      ground_T.Draw();
      ground_L.Draw();
      // Cow
      
      cow.Draw();
      cow.move();
      //cow.checkWallCollision();
      cow.checkCharacterCollision(hippo);
      cow.checkGround(ground_B);
      cow.checkGround(ground_R);
      cow.checkGround(ground_T);
      cow.checkGround(ground_L);
      
      // Hippo
      hippo.Draw();
      hippo.move();
      hippo.checkGround(ground_B);
      hippo.checkGround(ground_R);
      hippo.checkGround(ground_T);
      hippo.checkGround(ground_L);
/*
    fill(255,0,0, 255);
    textFont(Msgfont,64);
    msg = "Stage: " + GameStage;
    text(msg, 10, 50);      
    msg = "Ball Speed: " + orb.getSpeed();
    text(msg, 10, 70);*/
}
