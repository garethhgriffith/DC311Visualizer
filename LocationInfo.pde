import java.text.SimpleDateFormat;


// -------------------------------------------------------------------------
/**
 * Grabs the location information from the XML data feed and places
 * the information into array lists for use in the main program.
 *
 *
 * @author Gareth Griffith
 * @version (2013.10.17)
 */


public class LocationInfo
{
  private ArrayList<Float> locXList = new ArrayList<Float>();
  private ArrayList<Float> locYList = new ArrayList<Float>(); 
  private XML[] xmlEntry; 

  public LocationInfo(XML[] tempXmlEntry)
  {    
    xmlEntry = tempXmlEntry;
  }

  /**
   *
   *  This function takes in the X geo-location from the XML data and returns 
   *  the screen X location
   *
   *  @param locIter - the current location of the iterator
   *  @return locX - the screen X location
   *
   */
  public float getLocX(int locIter)
  {
    XML geo = xmlEntry[locIter].getChild("content/dcst:ServiceRequest/georss:point");
    String geoLoc = geo.getContent();

    String[] geoSplit = geoLoc.split(" ");
    float locX = Float.valueOf(geoSplit[0]);
    return locX;
  }
  /**
   *
   *  This function takes in the Y geo-location from the XML data and returns 
   *  the screen Y location
   *
   *  @param locIter - the current location of the iterator
   *  @return locX - the screen Y location
   *
   */
  public float getLocY(int locIter)
  {
    XML geo = xmlEntry[locIter].getChild("content/dcst:ServiceRequest/georss:point");
    String geoLoc = geo.getContent();

    String[] geoSplit = geoLoc.split(" ");
    float locY = Float.valueOf(geoSplit[1]);
    return locY;
  }
  /**
   *
   *  This function gets the report title out of the XML data and returns the title as a string. 
   *
   *  @param locIter - the current location of the iterator
   *  @return description - the description of the report
   *
   */
  public String getReportTitle(int locIter)
  {
    XML reportType = xmlEntry[locIter].getChild("content/dcst:ServiceRequest/dcst:servicecodedescription");
    String description = reportType.getContent();

    return description;
  }
  /**
   *
   *  This function gets the address out of the XML data and returns the address as a string. 
   *
   *  @param locIter - the current location of the iterator
   *  @return address - the address of the report
   *
   */
  public String getReportAddress(int locIter)
  {
    XML siteAddress = xmlEntry[locIter].getChild("content/dcst:ServiceRequest/dcst:siteaddress");
    String tempAddress = siteAddress.getContent();
    String address = capitalizeString(tempAddress);
    return address;
  }
  /**
   *
   *  This function takes in a string and modifies it so that all words are capitolized
   *
   *  @param string - the string to check for case modification
   *  @return String.valueOf(chars) - the modified string
   *
   */
  public String capitalizeString(String string) 
  {
    char[] chars = string.toLowerCase().toCharArray();
    boolean found = false;
    for (int i = 0; i < chars.length; i++) 
    {
      if (!found && Character.isLetter(chars[i])) 
      {
        chars[i] = Character.toUpperCase(chars[i]);
        found = true;
      } 
      else if (Character.isWhitespace(chars[i]) || chars[i]=='.' || chars[i]=='\'') 
      { 
        found = false;
      }
    }
    return String.valueOf(chars);
  }


  /**
   *
   *  This function gets the zip code out of the XML data and returns the zip code as a string.  
   *
   *  @param locIter - the current location of the iterator
   *  @return zip - the report zip code
   *
   */
  public String getReportZip(int locIter)
  {
    XML reportZip = xmlEntry[locIter].getChild("content/dcst:ServiceRequest/dcst:zipcode");
    String zip = reportZip.getContent(); 
    return zip;
  }
  /**
   *
   *  This function gets the report date out of the XML data, modifies the date format
   *  and returns the date as a string. 
   *
   *  @param locIter - the current location of the iterator
   *  @return reformattedDate - the report date
   *
   */
  public String getReportDate(int locIter)
  {
    XML reportDate = xmlEntry[locIter].getChild("content/dcst:ServiceRequest/dcst:serviceorderdate");
    String date = reportDate.getContent();
    //EDIT DATE STRING
    SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
    SimpleDateFormat outputFormat = new SimpleDateFormat("MMM d, yyyy");
    String reformattedDate = null;
    try
    {
      reformattedDate = outputFormat.format(inputFormat.parse(date));
    }
    catch(Exception e)
    {
      println("Unable to parse string!");
    }  
    return reformattedDate;
  }
  /**
   *
   *  This function gets the report time out of the XML data, modifies the time format
   *  and returns the date as a string. 
   *
   *  @param locIter - the current location of the iterator
   *  @return reformattedTime - the report time
   *
   */
  public String getReportTime(int locIter)
  {
    XML reportDate = xmlEntry[locIter].getChild("content/dcst:ServiceRequest/dcst:serviceorderdate");
    String date = reportDate.getContent();
    //EDIT DATE STRING
    SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");    
    SimpleDateFormat outputTime = new SimpleDateFormat("h:mm a");    
    String reformattedTime = null;    
    try
    {      
      reformattedTime = outputTime.format(inputFormat.parse(date));
    }
    catch(Exception e)
    {
      println("Unable to parse string!");
    }  
    return reformattedTime;
  }
  /**
   *
   *  This function gets the report code out of the XML data and returns the report code as a string.  
   *
   *  @param locIter - the current location of the iterator
   *  @return reportCode - the report code
   *
   */
  public String getReportCode(int locIter)
  {
    XML code = xmlEntry[locIter].getChild("content/dcst:ServiceRequest/dcst:servicecode");
    String reportCode = code.getContent();    
    return reportCode;
  }
}

