package julia; 

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

public class JuliaSet {

  private Complex c; 
  private int NUM_COLOR_VALS = 256;
  private final int max_iterations = 1000;
  private final double step_size = 0.001;
  private final double max_y = 2.0;
  private final double min_y = -2.0; 
  private final double max_x = 2.0;
  private final double min_x = -2.0;
  private final Complex R = new Complex(2, 0);
  private final String fileName = "outputJulia.ppm";
  private final String[] colors = new String[] {"255   0   0  # red",
                                                "  0 255   0  # green",
                                                "  0   0 255  # blue",
                                                "255 255   0  # yellow",
                                                "255 255 255  # white",
                                                "  0 255 255",
                                                "255   0 255"};
  
  public JuliaSet(Complex c) {
    this.c = c;
  }

  public void drawSet() {
    PrintWriter myPW = null;
    int n = ((int) Math.floor((max_y - min_y) / step_size)) + 1;
    int m = ((int) Math.floor((max_x - min_x) / step_size)) + 1;   
    try{
      myPW = new PrintWriter(new File(fileName));
      myPW.println("P3");
      myPW.print(n);
      myPW.print(" ");
      myPW.println(m);
      myPW.println(NUM_COLOR_VALS - 1);
      for (double y = max_y; y > min_y; y -= step_size) {
        for (double x = min_x; x < max_x; x += step_size) {
          Complex z = new Complex(x, y);
          display_z(z, myPW);
        }
      }

    } catch (IOException ex) {
      ex.printStackTrace();
    } finally {
      if (myPW != null) {
        myPW.close();
      }
    }        
  }

  public void display_z(Complex z, PrintWriter myPW) {
    int n = iterate_f(z);
    if (n == -1) {
      myPW.println("  0  0  0  # black");
    } 
    else {    
      String colorString = (n % 256) + " " + (n % 256) + " " + (n % 256);
      myPW.println(colorString);
    }
  }

  public Complex f(Complex z) {
    Complex z_squared = z.mult(z);
    return z_squared.add(c);
  }

  public int iterate_f(Complex z) {
    for (int i = 0; i < max_iterations; i++) {
      if (z.magnitude() >= R.magnitude()) {
        return i;
      } 
      else {
        z = f(z);
      }
    }
    return -1;
  }

  public static void main(String[] args) {
    Complex c = new Complex(-0.8, 0.156); 
    JuliaSet js = new JuliaSet(c);
    js.drawSet();
  }
}
