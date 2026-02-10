final int N = 64;
final int SCALE = 12;
final int max_iter = 10;
final float FadeSpeed=0.2;
final float DensityIgnore=0.5;
final float TimeStep=0.05;
boolean Render_Density=true;
boolean Render_VelocityField=false;
boolean Render_AccelerationField=false;
boolean Render_VortexDetector=false;
boolean Simulate=true;

Grid grid;

void settings() {
  size(N*SCALE, N*SCALE);
}

void setup() {
  //flama  *, 0.001, 0.0
  //humo   *, 0, 0.0
  //Grid( dt,  diffusion,  viscosity )
  grid = new Grid(TimeStep, 0.0001, 0.0);
  grid.init_memory();
}

void draw() {
  background(0);
  if(Simulate){
    int x = int(0.5*width/SCALE);
    int y = int(0.85*height/SCALE);
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        grid.addDensity(x+i, y+j, random(100, 150));
      }
    }
    PVector v = PVector.fromAngle(-PI/2+random(-1,1));
    v.mult(random(0.1,1.8));
    grid.addVelocity(x, y, v.x, v.y );
    grid.Simulate();
  }
  if(Render_Density) grid.RenderDensity();
  if(Render_VelocityField)  grid.RenderVelocityField();
  if(Render_AccelerationField) grid.RenderAccelerationField();
  if(Render_VortexDetector) grid.RenderVortexDetector();
  render_buttons();
}
