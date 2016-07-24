// -------------------------------------------------------------------------
/**
 * Displays all of the report locations on the map.
 *
 *
 * @author Gareth Griffith
 * @version (2013.10.17)
 */
public class Marker 
{
  private int b;
  private int s;
  private int a;
  private float innerRad;
  private float innerStart;
  private float outerRad;
  private float outerStart;
  private float locInit;
  private float outerMax;
  private int numPoints;
  private float theta;
  private color cityMaintColor, dmvColor, publicWorksColor, vehicleVioColor, 
  pestColor, cityProgColor, vegMaintColor, fireEmergColor, 
  otherColor, remainColor;

  public Marker()
  {
    b = 63;
    s = 84;
    a = 100;
    innerRad = 5;
    innerStart = 5;
    outerRad = 5;
    outerStart = 5;
    locInit = 12;
    outerMax = 35;
    numPoints = 100;
    theta = 2*TWO_PI/numPoints;
    cityMaintColor = color(150, 83, 63);
    dmvColor = color(118, 83, 63);
    publicWorksColor = color(86, 83, 63);
    vehicleVioColor = color(54, 83, 63);
    pestColor = color(22, 83, 63);
    cityProgColor = color(350, 83, 63);
    vegMaintColor = color(318, 83, 63);
    fireEmergColor = color(286, 83, 63);
    otherColor = color(254, 83, 63);
  }

  /**
   * This function defines the look and location of the on-screen markers.
   * 
   *  @param x - The x cooridinate of the location on the screen
   *  @param x - The y cooridinate of the location on the screen
   *  @param locRad - The raduis of the location ellipse.
   *  @param category - The report category
   */
  public void display(float x, float y, float locRad, int category)
  { 
    if (dist(x, y, mouseX, mouseY) < locRad/2)
    {            
      stroke(1);
      fill(175, 63, 84 );
      ellipse(x, y, locRad, locRad);
    }
    else
    {      
      colorLoc(x, y, locRad, category);
    }
  }


  /**
   *  This function defines the look and location of currently 
   *  selected location/report.
   * 
   *  @param x - The x cooridinate of the location on the screen
   *  @param x - The y cooridinate of the location on the screen
   */
  public void activeLoc(float x, float y)
  { 
    if (outerRad > outerMax)
    {
      outerRad = outerStart;
      innerRad = innerStart;
      b = 63;
      s = 84;
      a = 100;
    }
    else if (outerRad < outerMax + 1)
    {
      outerRad += 0.4;
      innerRad += 0.15;
      //      s -= 1.9;
      //      b += 0.9;
      a -= 2;
    }

    //PShape ring
    float theta = 2*TWO_PI/numPoints;
    pushMatrix();
    translate(x, y);
    noStroke();
    fill(175, s, b, a);
    beginShape(TRIANGLE_STRIP);
    for (int i=0; i<numPoints; i++) 
    {
      float angle = i*theta;
      float ca = cos(angle);
      float sa = sin(angle);
      vertex(ca*outerRad, sa*outerRad);
      vertex(ca*innerRad, sa*innerRad);
    }
    endShape();
    popMatrix();
  }
  /**
   *  This function colors the location markers depending on their category
   * 
   *  @param x - The x cooridinate of the location on the screen
   *  @param y - The y cooridinate of the location on the screen
   *  @param locRad - the radius of the location marker
   *  @param category - the report category
   *
   */
  public void colorLoc(float x, float y, float locRad, int category)
  {
    if (category == 0)
    {
      stroke(1);
      fill(cityMaintColor);
      ellipse(x, y, locRad, locRad);
    }
    else if (category == 1)
    {
      stroke(1);
      fill(dmvColor);
      ellipse(x, y, locRad, locRad);
    }
    else if (category == 2)
    {
      stroke(1);
      fill(publicWorksColor);
      ellipse(x, y, locRad, locRad);
    }
    else if (category == 3)
    {
      stroke(1);
      fill(vehicleVioColor);
      ellipse(x, y, locRad, locRad);
    }
    else if (category == 4)
    {
      stroke(1);
      fill(pestColor);
      ellipse(x, y, locRad, locRad);
    }
    else if (category == 5)
    {
      stroke(1);
      fill(cityProgColor);
      ellipse(x, y, locRad, locRad);
    }
    else if (category == 6)
    {
      stroke(1);
      fill(vegMaintColor);
      ellipse(x, y, locRad, locRad);
    }    
    else if (category == 7)
    {
      stroke(1);
      fill(fireEmergColor);
      ellipse(x, y, locRad, locRad);
    }    
    else if (category == 8)
    {
      stroke(1);
      fill(otherColor);
      ellipse(x, y, locRad, locRad);
    }
    else
    {
      stroke(1);
      fill(otherColor);
      ellipse(x, y, locRad, locRad);
    }
  }
}

