// -------------------------------------------------------------------------
/**
 * This class places and styles the informative text that is
 * displayed in the information box
 *
 *
 * @author Gareth Griffith
 * @version (2013.11.7)
 */

public class ReportDesc
{
  private String reportStr;
  private PFont fontName;
  private int rectX, rectY, rectW, rectH;
  private int textX, textY;
  private int textSpeed;
  private int fontSize;
  private color fontColor;  
  private PFont font;
  private PGraphics textBox;  
  private boolean rectOver = false;


  public ReportDesc(String tempString, PFont tempFontName, int tempFontSize, color tempFontColor)
  {
    reportStr = tempString;
    fontColor = tempFontColor;
    fontSize = tempFontSize;
    fontName = tempFontName;
    textSpeed = 1;
  }

  /**
   *  This function sets the location and width of the text on the screen
   * 
   *  @param tempX - The x cooridinate of the text box on the screen.
   *  @param tempY - The y cooridinate of the text box on the screen.
   *  @param tempW - The width of the text box.
   */
  public void display(int tempX, int tempY, int tempW, int tempTextX)
  {  
    rectX = tempX;
    rectY = tempY;
    rectW = tempW;
    textX = tempTextX;

    textSize(fontSize);
//    font = createFont(fontName, fontSize);
    //font = loadFont(fontName);
    rectH = (int)Math.ceil(textAscent() + textDescent() + 10);
    textY = rectH - rectH/4;

    update();

    textBox = createGraphics(rectW, rectH, JAVA2D);
    textBox.beginDraw();    
    textBox.colorMode(HSB);
    textBox.textFont(fontName);
    textBox.textAlign(LEFT);
    textBox.background(0, 0);
    textBox.fill(fontColor);
    textBox.text(reportStr, textX, textY);
    textBox.endDraw();
    image(textBox, rectX, rectY);

    if (textWidth(reportStr) > rectW  && rectOver)
    {      
      scroll();
    }
    else
    {
      textX = 0;
    }
  }
  /**
   * This function scrolls the text within the text box 
   *  
   */
  public void scroll()
  {
    textX -= textSpeed;

    if (textX < -textWidth(reportStr))
    {
      textX = rectW;
    }
  }
  /**
   *  This function monitors and returns the updated value of the
   *  text x coordinate in the text box
   * 
   *  @return textX - the postition of the text's x coordiante 
   *                  inside the text box
   *
   */
  public int getTextX()
  {
    return textX;
  }

  /**
   * This function checks to see if the mouse is over the text box.
   * 
   *  @param x - The x cooridinate of the text box.
   *  @param y - The y cooridinate of the text box.
   *  @param w - The width of the text box.
   *  @param h - The height of the text box.
   */
  public boolean overRect(float x, float y, float w, float h)
  {
    if (mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h) 
    {
      return true;
    } 
    else 
    {
      return false;
    }
  }

  /**
   * This function checks the mouse position and its relation to the text box. 
   *  
   */
  public void update() 
  {  
    if (overRect(rectX, rectY, rectW, rectH))
    {
      rectOver = true;
    }
    else 
    {
      rectOver = false;
    }
  }
}

