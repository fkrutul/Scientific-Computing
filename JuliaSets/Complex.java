package julia; 

public class Complex {

  private double real;
  private double imag; 

  public Complex(double real, double imag) {
    this.real = real;
    this.imag = imag;
  }

  public double getReal() {
    return real;
  }

  public double getImag() {
    return imag;
  }

  public double magnitude() {
  	return Math.sqrt((real * real) + (imag * imag));
  }

  public Complex add(Complex c) {
    return new Complex(this.real + c.getReal(),
                       this.imag + c.getImag());
  }

  public Complex mult(Complex c) {
    double x = real;
    double y = imag;

    double u = c.getReal();
    double v = c.getImag();
    
    return new Complex((x * u) - (y * v), 
                       (x * v) + (y * u)  
                       );
  }

  public String toString() {
    return String.valueOf(real)
      + "+"
      + String.valueOf(imag)
      + "i";
  }
  
  public static void main(String[] args) {
    Complex c1 = new Complex(3, 2); 
    Complex c2 = new Complex(1, 4); 

    Complex c3 = c1.add(c2);        
    Complex c4 = c1.mult(c2); 
    double d1 = c4.magnitude(); 
                                
    System.out.println(c3);
    System.out.println(c4);
    System.out.println(d1);
  }  
}
