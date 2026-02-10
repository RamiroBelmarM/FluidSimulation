
void render_buttons(){
  fill(255);
  text("Den",(N-4.5)*SCALE, 2*SCALE);
  text("Vel",(N-4.5)*SCALE, 4*SCALE);
  text("Ace",(N-4.5)*SCALE, 6*SCALE);
  text("Vor",(N-4.5)*SCALE, 8*SCALE);
  stroke(255);
  if(Render_Density){
    fill(255); 
    rect((N-2)*SCALE, SCALE, SCALE, SCALE, 3);
  }else{
    fill(0); 
    rect((N-2)*SCALE, SCALE, SCALE, SCALE, 3);
  }
  if(Render_VelocityField){ 
    fill(255); 
    rect((N-2)*SCALE, 3*SCALE, SCALE, SCALE, 3);
  }else{
    fill(0); 
    rect((N-2)*SCALE, 3*SCALE, SCALE, SCALE, 3);
  }
  if(Render_AccelerationField){
    fill(255); 
    rect((N-2)*SCALE, 5*SCALE, SCALE, SCALE, 3);
  }else{
    fill(0); 
    rect((N-2)*SCALE, 5*SCALE, SCALE, SCALE, 3);
  }
  if(Render_VortexDetector){
    fill(255); 
    rect((N-2)*SCALE, 7*SCALE, SCALE, SCALE, 3);
  }else{
    fill(0); 
    rect((N-2)*SCALE, 7*SCALE, SCALE, SCALE, 3);
  }
  if(Simulate){
    fill(255); 
    rect(SCALE, SCALE, SCALE, SCALE, 3);
  }else{
    fill(0); 
    rect(SCALE, SCALE, SCALE, SCALE, 3);
  }
  return;
}
