int CountStartTime;
boolean Stage0_Started = false;
void draw_stage(int Stage){
  switch (Stage){
    case 0:
        //GameStage ++;
        GameState = 0;        
        fill(255,0,0, 100);
        textFont(Msgfont,64);
        if(!Stage0_Started){
          Stage0_Started = true;
          CountStartTime = millis();
        }
        text("Stage 1 Start", width*2/10, height*45/100);
        if(millis() - CountStartTime > 2000){
          GameState = 1;
          GameStage++;
        }
        
      break;
    case 1:
      DrawStandard();            
      if(GameState == 0){
        textFont(Msgfont,64);
        fill(255,0,0, 255);
        text("Stage 1 Complete", width*1/10, height*45/100);
        CountStartTime = millis();
        if(millis() - CountStartTime > 2000){
          GameState = 1;
          GameStage++;
        }        
        GameStage++;
      }
      break;
    case 2:
      break;
    case -1:
    if(Winner == 2)
      text("You Lose", width*3/10, height*45/100);
      break;      
    default:
      break;
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
}
