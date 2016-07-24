// -------------------------------------------------------------------------
/**
 * This class takes in the unfiltered data and parses it out into new lists
 *
 *
 * @author Gareth Griffith
 * @version (2013.12.1)
 */
public class Entry
{

  String reportCode;
  int category;
  String description;
  String address;
  String zip;
  String time;
  String date;
  float locX;
  float locY;


  public Entry(String tempCode, int tempCat, String tempDesc, String tempAdd, String tempZip, String tempTime, String tempDate, float tempLocX, float tempLocY)
  {

    reportCode = tempCode;
    category = tempCat;
    description = tempDesc;
    address = tempAdd;
    zip = tempZip;
    time = tempTime;
    date = tempDate;
    locX = tempLocX;
    locY = tempLocY;
  }  
  
  /**
   *
   *  This function returns the service code of a report
   *
   *  @return reportCode - the service code
   *
   */
  public String getReportCode()
  {
    return reportCode;
  }
  /**
   *
   *  This function returns the description of the report
   *
   *  @return description - the description
   *
   */
  public String getDesc()
  {
    return description;
  }
  /**
   *
   *  This function returns the category of the report
   *
   *  @return category - the category
   *
   */
  public int getCategory()
  {
    return category;
  }
  /**
   *
   *  This function returns the address of the report
   *
   *  @return address - the address
   *
   */
  public String getAdd()
  {
    return address;
  }
  /**
   *
   *  This function returns the zip code of the report
   *
   *  @return zip - the zip code
   *
   */
  public String getZip()
  {
    return zip;
  }
  /**
   *
   *  This function returns the time the report was filed
   *
   *  @return time - the time
   *
   */
  public String getTime()
  {
    return time;
  }
  /**
   *
   *  This function returns the date the report was filed
   *
   *  @return date - the date
   *
   */
  public String getDate()
  {
    return date;
  }
  /**
   *
   *  This function returns the X location of the report in relation to the 
   *  geo-location
   *
   *  @return locX - the x location
   *
   */
  public float getLocX()
  {
    return locX;
  }
  /**
   *
   *  This function returns the Y location of the report in relation to the 
   *  geo-location
   *
   *  @return locY - the Y location
   *
   */
  public float getLocY()
  {
    return locY;
  }
}

