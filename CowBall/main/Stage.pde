void draw_stage(int Stage){
  switch (Stage){
    case 0:
      break;
    case 1:
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
    default:
      break;
  }
  
}
