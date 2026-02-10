class Grid {
  float dt;
  float diff;
  float visc;
  float max_density=0;
  float max_gamma=0;

  float[] temp_array;
  float[] density;

  float[] Vx;
  float[] Vy;

  float[] Vx0;
  float[] Vy0;
  
  CVD_Pallete cvdcolor; 

  Grid(float dt, float diffusion, float viscosity) {
    this.dt = dt;
    this.diff = diffusion;
    this.visc = viscosity;
  }
  
  void init_memory(){
    this.temp_array = new float[N*N];
    this.density = new float[N*N];

    this.Vx = new float[N*N];
    this.Vy = new float[N*N];

    this.Vx0 = new float[N*N];
    this.Vy0 = new float[N*N];
    
    cvdcolor = new CVD_Pallete();
    return;
  }

  void Simulate() {
    Diffuse(1, this.Vx0, this.Vx, this.visc, this.dt);
    Diffuse(2, this.Vy0, this.Vy, this.visc, this.dt);

    Velocity_Field_Solver(this.Vx0, this.Vy0, this.Vx, this.Vy);

    Advection_Solver(1, this.Vx, this.Vx0, this.Vx0, this.Vy0, this.dt);
    Advection_Solver(2, this.Vy, this.Vy0, this.Vx0, this.Vy0, this.dt);

    Velocity_Field_Solver(this.Vx, this.Vy, this.Vx0, this.Vy0);

    Diffuse(0, this.temp_array, this.density, this.diff, this.dt);
    Advection_Solver(0, this.density, this.temp_array, this.Vx, this.Vy, this.dt);
    
    UpdateDensity();
    
    return;
  }

  void addDensity(int x, int y, float drho) {
    int index = IX(x, y);
    this.density[index] += drho;
    
    return;
  }

  void addVelocity(int x, int y, float dvx, float dvy) {
    int index = IX(x, y);
    this.Vx[index] += dvx;
    this.Vy[index] += dvy;
    
    return;
  }

  void RenderDensity() {
    colorMode(RGB, 255);
    for (int i = 0; i < N; i++) {
      for (int j = 0; j < N; j++) {
        float x = i * SCALE;
        float y = j * SCALE;
        float d = this.density[IX(i, j)];
        if (d>max_density) max_density=d;
        d=(d/max_density);
        cvdcolor.Inferno(d);
        fill(cvdcolor.get_R(),cvdcolor.get_G(),cvdcolor.get_B());
        noStroke();
        square(x, y, SCALE);
      }
    }
    
    return;
  }

  void RenderVelocityField() {
    for (int i = 1; i < N-1; i+=2) {
      for (int j = 1; j < N-1; j+=2) {
        float d = this.density[IX(i, j)];
        if (d!=0) {
          float vx = this.Vx[IX(i, j)];
          float vy = this.Vy[IX(i, j)];
          float local_velocity=sqrt(vx*vx+vy*vy);
          float x = i * SCALE+SCALE/2;
          float y = j * SCALE+SCALE/2;
          cvdcolor.Plasma(SCALE*local_velocity);
          stroke(cvdcolor.get_R(),cvdcolor.get_G(),cvdcolor.get_B());
          fill(cvdcolor.get_R(),cvdcolor.get_G(),cvdcolor.get_B());
          PVector unit = new PVector(vx, vy);
          unit.normalize();
          unit.mult(SCALE*0.75);
          Arrow(x, y,x+unit.x,y+unit.y);
        }
      }
    }
    return;
  }
  
  void RenderVortexDetector(){
    int n=4;
    for (int i = n; i < N-n; i++) {
      for (int j = n; j < N-n; j++) {
        float vx_mean=0;
        float vy_mean=0;
        boolean pass=true;
        for (int k=0; k<(2*n) && pass;k++){
          for (int w=0; w<(2*n) && pass; w++){
            vx_mean+=this.Vx[IX(i+k-n,j+w-n)];
            vy_mean+=this.Vy[IX(i+k-n,j+w-n)];
            pass=pass&&( (this.Vx[IX(i+k-n,j+w-n)]!=0)||(this.Vy[IX(i+k-n,j+w-n)]!=0) );
          }
        }
        if (pass){
          float gamma=0;
          float x = i * SCALE;
          float y = j * SCALE;
          vx_mean/=pow(2*n,2);
          vy_mean/=pow(2*n,2);
          for (int k=0; k<(2*n);k++){
            for (int w=0; w<(2*n); w++){
              float temp;
              float x_t= (i+k-n)*SCALE+SCALE/2;
              float y_t= (j+w-n)*SCALE+SCALE/2;
              if(dist(x,y,x_t,y_t)>n*SCALE) continue;
              temp=cross(x_t-x,y_t-y, this.Vx[IX(i+k-n,j+w-n)] -vx_mean , this.Vy[IX(i+k-n,j+w-n)]-vy_mean);
              temp/=(dist(x,y,x_t,y_t)*sqrt(  
              (this.Vx[IX(i+k-n,j+w-n)] -vx_mean)*(this.Vx[IX(i+k-n,j+w-n)] -vx_mean)+ 
              (this.Vy[IX(i+k-n,j+w-n)]-vy_mean)*(this.Vy[IX(i+k-n,j+w-n)]-vy_mean) ) );
              gamma+=temp;
            }
          }
          gamma/=pow(2*n,2);
          if (abs(gamma)>2/PI){
            if (abs(gamma)>max_gamma) max_gamma=abs(gamma);
            float gamma_grad=(abs(gamma)-2/PI)/(max_gamma-2/PI);
            cvdcolor.Cividis(gamma_grad);
            stroke(cvdcolor.get_R(),cvdcolor.get_G(),cvdcolor.get_B());
            fill(cvdcolor.get_R(),cvdcolor.get_G(),cvdcolor.get_B());
            x+=SCALE/2;
            y+=SCALE/2; 
            Arrow(x, y, 
               x+constrain(this.Vx[IX(i,j)]*SCALE*SCALE,-SCALE/2,SCALE/2), 
               y+constrain(this.Vy[IX(i,j)]*SCALE*SCALE,-SCALE/2,SCALE/2) );
          }
        }
      }
    }
    return;
  }
  
  void RenderAccelerationField(){
    for (int i = 1; i < N-2; i+=2) {
      for (int j = 1; j < N-2; j+=2) {
        if(this.density[IX(i,j)]!=0){
          float x = i * SCALE+SCALE/2;
          float y = j * SCALE+SCALE/2;
          float ax = this.Vx[IX(i,j)]*(this.Vx[IX(i+1,j)]-this.Vx[IX(i-1,j)])/( this.dt);
                ax+= this.Vy[IX(i,j)]*(this.Vx[IX(i,j+1)]-this.Vx[IX(i,j-1)])/( this.dt);
                
          float ay = this.Vx[IX(i,j)]*(this.Vy[IX(i+1,j)]-this.Vy[IX(i-1,j)])/( this.dt);
                ay+= this.Vy[IX(i,j)]*(this.Vy[IX(i,j+1)]-this.Vy[IX(i,j-1)])/( this.dt);
                
          cvdcolor.Viridis(sqrt(ax*ax+ay*ay)*SCALE);
          stroke(cvdcolor.get_R(),cvdcolor.get_G(),cvdcolor.get_B());
          fill(cvdcolor.get_R(),cvdcolor.get_G(),cvdcolor.get_B());
          PVector unit = new PVector(ax, ay);
          unit.normalize();
          unit.mult(SCALE*0.75);
          Arrow(x,y,x+unit.x,y+unit.y);
        }
      }
    }
    return;
  }
  void UpdateDensity(){
    for (int i = 0; i < N; i++) {
      for (int j = 0; j < N; j++) {
        int ij=IX(i, j);
        if(this.density[ij]<= DensityIgnore){
          this.Vx[ij]=0;
          this.Vy[ij]=0;
          this.density[ij]=0;
        }
        this.density[ij] = constrain(this.density[ij]-FadeSpeed, 0, 255);
      }
    }
    return;
  }
  void Arrow(float x1, float y1, float x2, float y2) {
    float a = dist(x1, y1, x2, y2) / 5;
    pushMatrix();
    translate(x2, y2);
    rotate(atan2(y2 - y1, x2 - x1));
    triangle(- a * 2 , - a, 0, 0, - a * 2, a);
    popMatrix();
    line(x1, y1, x2, y2);  
  }
 
}
