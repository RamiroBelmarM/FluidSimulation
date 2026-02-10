class CVD_Pallete{
  int R=0;
  int G=0;
  int B=0;
  CVD_Pallete(){
    this.R=0;
    this.G=0;
    this.B=0;
    return;
  }
  void Viridis(float x){
    x=constrain(x,0,1);
    this.R= floor(-2828.5*pow(x,5) + 5952.4*pow(x,4) - 3298.3*pow(x,3) + 354.51*x*x + 2.8666*x + 69.416);
    this.G= floor(-112.99*x*x + 346.58*x + 1.4162);
    this.B= floor( 7725.5*pow(x,6) - 19456*pow(x,5) + 17287*pow(x,4) - 6231.5*pow(x,3) + 290.05*pow(x,2) + 335.96*x + 84.491);
    this.R=constrain(this.R,0,255);
    this.G=constrain(this.G,0,255);
    this.B=constrain(this.B,0,255);
    return;
  }
  void Inferno(float x){
    x=constrain(x,0,1);
    this.R=floor(7256.3*pow(x,6) - 20543*pow(x,5) + 22119*pow(x,4) - 11815*pow(x,3) + 3232.8*pow(x,2) + 1.8244*x + 0.098);
    this.G=floor(-605.73*pow(x,4) + 1259.4*pow(x,3) - 531.62*pow(x,2) + 136.72*x + 0.5958);
    this.B=floor(-5632.2*pow(x,6) + 16462*pow(x,5) - 16305*pow(x,4) + 7521.7*pow(x,3) - 2709*pow(x,2) + 830.37*x + 0.3216);
    this.R=constrain(this.R,0,255);
    this.G=constrain(this.G,0,255);
    this.B=constrain(this.B,0,255);
  
    return;
  }
  void Magma(float x){
    x=constrain(x,0,1);
    this.R=floor(4484.8*pow(x,6) - 12378*pow(x,5) + 12994*pow(x,4) - 7098.9*pow(x,3) + 2202.5*pow(x,2) + 49.269*x - 0.4759);
    this.G=floor(-1976.7*pow(x,6) + 4668.6*pow(x,5) - 4137.8*pow(x,4) + 2096.5*pow(x,3) - 538.73*pow(x,2) + 139.06*x + 0.484);
    this.B=floor(-140.02*pow(x,6) - 3309.3*pow(x,5) + 9102.5*pow(x,4) - 7178.9*pow(x,3) + 1228.3*pow(x,2) + 486.38*x + 2.3189);
    this.R=constrain(this.R,0,255);
    this.G=constrain(this.G,0,255);
    this.B=constrain(this.B,0,255);
    return;
  }
  void Plasma(float x){
    x=constrain(x,0,1);
    this.R=floor(-273.59*pow(x,4) + 445.65*pow(x,3) - 494.29*pow(x,2) + 547.57*x + 14.2);
    this.G=floor(-5386.1*pow(x,6) + 16824*pow(x,5) - 19454*pow(x,4) + 9862.8*pow(x,3) - 1632.2*pow(x,2) + 25.075*x + 7.9023);
    this.B=floor(3453*pow(x,6) - 10516*pow(x,5) + 11929*pow(x,4) - 5594.8*pow(x,3) + 398.71*pow(x,2) + 229.22*x + 135.07);
    this.R=constrain(this.R,0,255);
    this.G=constrain(this.G,0,255);
    this.B=constrain(this.B,0,255);
  
    return;
  }
  void Cividis(float x){
    x=constrain(x,0,1);
    this.R=floor(-362.11*pow(x,6) - 1787.2*pow(x,5) + 6281.1*pow(x,4) - 6296.2*pow(x,3) + 2501.8*pow(x,2) - 85.209*x + 0.8209);
    this.G=floor(29.494*pow(x,4) - 24.39*pow(x,3) + 22.511*pow(x,2) + 174.32*x + 32.292);
    this.B=floor(75.729*pow(x,6) + 2231*pow(x,5) - 6318.4*pow(x,4) + 6010.3*pow(x,3) - 2455*pow(x,2) + 444.55*x + 80.898);
    this.R=constrain(this.R,0,255);
    this.G=constrain(this.G,0,255);
    this.B=constrain(this.B,0,255);
  
    return;
  }
  int get_R(){
    return this.R;
  }
  int get_G(){
    return this.G;
  }
  int get_B(){
    return this.B;
  }

}
int IX(int x, int y) {
  x = constrain(x, 0, N-1);
  y = constrain(y, 0, N-1);
  return x + (y * N);
}
void mouseClicked(){
  if(mouseX>((N-2)*SCALE) && mouseX <((N-1)*SCALE) && mouseY>SCALE && mouseY <2*SCALE){
      Render_Density= (!( Render_Density && true ) && !( !(Render_Density) && false) );
    }
  if(mouseX>((N-2)*SCALE) && mouseX <((N-1)*SCALE) && mouseY>3*SCALE && mouseY <4*SCALE){
      Render_VelocityField= (!( Render_VelocityField && true ) && !( !(Render_VelocityField) && false) );
    }
  if(mouseX>((N-2)*SCALE) && mouseX <((N-1)*SCALE) && mouseY>5*SCALE && mouseY <6*SCALE){
      Render_AccelerationField= (!( Render_AccelerationField && true) && !( !(Render_AccelerationField) && false) );
    }
  if(mouseX>((N-2)*SCALE) && mouseX <((N-1)*SCALE) && mouseY>7*SCALE && mouseY <8*SCALE){
      Render_VortexDetector= (!( Render_VortexDetector && true ) && !( !(Render_VortexDetector) && false) );
    }
  if(mouseX>(SCALE) && mouseX <(2*SCALE) && mouseY>SCALE && mouseY <2*SCALE){
    Simulate= (!( Simulate && true ) && !( !(Simulate) && false) );
  }
  return;
}
