// -------------------------------------------------------------------------
/**
 * This class takes in the unfiltered data and parses it out into new lists
 *
 *
 * @author Gareth Griffith
 * @version (2013.11.11)
 */

public class ListFilter
{
  private ArrayList<Entry> unfilteredData = new ArrayList<Entry>();
  private ArrayList<Entry> filteredData = new ArrayList<Entry>();
  private ArrayList<Entry> filteredCityMaint = new ArrayList<Entry>();
  private ArrayList<Entry> filteredDMV = new ArrayList<Entry>();
  private ArrayList<Entry> filteredPublicWorks = new ArrayList<Entry>();
  private ArrayList<Entry> filteredVehicleViolations = new ArrayList<Entry>();
  private ArrayList<Entry> filteredPest = new ArrayList<Entry>();
  private ArrayList<Entry> filteredCityPrograms = new ArrayList<Entry>();
  private ArrayList<Entry> filteredVegMaint = new ArrayList<Entry>();
  private ArrayList<Entry> filteredFireEmergency = new ArrayList<Entry>();
  private ArrayList<Entry> filteredOther = new ArrayList<Entry>();

  public ListFilter(ArrayList tempUnfilteredData)
  {
    unfilteredData = tempUnfilteredData;
  }
  /**
   *
   *  This function runs all of the list filters to populate all of the filtered lists
   *
   */
  public void filterList()
  {
    filterByCityMaint();
    filterByDMV();
    filterByPublicWorks();
    filterByVehicleViolations();
    filterByPest();
    filterByCityPrograms();
    filterByVegMaint();  
    filterByFireEmergency();
    filterByOther();
  }

  /**
   *
   *  This function takes in the unfilteredData list and builds a new list
   *  containing the City Mainenance items.
   *
   */
  public void filterByCityMaint()
  {         
    for (Entry e : unfilteredData)
    {
      if (e.getCategory() == 0)
      {
        filteredCityMaint.add(e);
      }
    }
  }

  /**
   *
   *  This function returns the filtered list containing the City Maintenance items
   *
   *  @return filteredCityMaint - the filtered list
   *
   */
  public ArrayList<Entry> getCityMaint()
  {    
    return filteredCityMaint;
  }

  /**
   *
   *  This function takes in the unfilteredData list and builds a new list
   *  containing the DMV items.
   *
   */
  public void filterByDMV()
  {
    for (Entry e : unfilteredData)
    {
      if (e.getCategory() == 1)
      {
        filteredDMV.add(e);
      }
    }
  }
  /**
   *
   *  This function returns the filtered list containing the DMV items
   *
   *  @return filteredDMV - the filtered list
   *
   */
  public ArrayList<Entry> getDMV()
  {    
    return filteredDMV;
  } 

  /**
   *
   *  This function takes in the unfilteredData list and builds a new list
   *  containing the Public Works items.
   *
   */
  public void filterByPublicWorks()
  {
    for (Entry e : unfilteredData)
    {
      if (e.getCategory() == 2)
      {
        filteredPublicWorks.add(e);
      }
    }
  }

  /**
   *
   *  This function returns the filtered list containing the public works items
   *
   *  @return filteredPublicWorks - the filtered list
   *
   */
  public ArrayList<Entry> getPublicWorks()
  {    
    return filteredPublicWorks;
  }

  /**
   *
   *  This function takes in the unfilteredData list and builds a new list
   *  containing the Vehicle Violations.
   *
   */
  public void filterByVehicleViolations()
  {
    for (Entry e : unfilteredData)
    {
      if (e.getCategory() == 3)
      {
        filteredVehicleViolations.add(e);
      }
    }
  }

  /**
   *
   *  This function returns the filtered list containing the Vehicle Violations
   *
   *  @return filteredVehicleViolations - the filtered list
   *
   */
  public ArrayList<Entry> getVehicleViolations()
  {    
    return filteredVehicleViolations;
  }

  /**
   *
   *  This function takes in the unfilteredData list and builds a new list
   *  containing the Animal/Pest issues.
   *
   */
  public void filterByPest()
  {
    for (Entry e : unfilteredData)
    {
      if (e.getCategory() == 4)
      {
        filteredPest.add(e);
      }
    }
  }
  /**
   *
   *  This function returns the filtered list containing the issues related
   *  to Animals/Pests
   *
   *  @return filteredPest - the filtered list
   *
   */
  public ArrayList<Entry> getPest()
  {    
    return filteredPest;
  } 


  /**
   *
   *  This function takes in the unfilteredData list and builds a new list
   *  containing the City Program items.
   *
   */
  public void filterByCityPrograms()
  {
    for (Entry e : unfilteredData)
    {
      if (e.getCategory() == 5)
      {
        filteredCityPrograms.add(e);
      }
    }
  }

  /**
   *
   *  This function returns the filtered list containing classes and programs lead by the city.
   *
   *  @return filteredCityPrograms - the filtered list
   *
   */
  public ArrayList<Entry> getCityPrograms()
  {    
    return filteredCityPrograms;
  }

  /**
   *
   *  This function takes in the unfilteredData list and builds a new list
   *  containing the Vegetation Maintenance and Management items.
   *
   */
  public void filterByVegMaint()
  {
    for (Entry e : unfilteredData)
    {
      if (e.getCategory() == 6)
      {
        filteredVegMaint.add(e);
      }
    }
  }

  /**
   *
   *  This function returns the filtered list containing the Vegetaion 
   *  Maintenance and Management items
   *
   *  @return filteredVegMaint - the filtered list
   *
   */
  public ArrayList<Entry> getVegMaint()
  {    
    return filteredVegMaint;
  }

  /**
   *
   *  This function takes in the unfilteredData list and builds a new list
   *  containing the Fire & Emergency items.
   *
   */
  public void filterByFireEmergency()
  {
    for (Entry e : unfilteredData)
    {
      if (e.getCategory() == 7)
      {
        filteredFireEmergency.add(e);
      }
    }
  }

  /**
   *
   *  This function returns the filtered list containing the Fire & Emergency issues
   *
   *  @return filteredFireEmergency - the filtered list
   *
   */
  public ArrayList<Entry> getFireEmergency()
  {    
    return filteredFireEmergency;
  }

  /**
   *
   *  This function takes in the unfilteredData list and builds a new list
   *  containing the non-categorized items.
   *
   */
  public void filterByOther()
  {
    for (Entry e : unfilteredData)
    {
      if (e.getCategory() == 8)
      {
        filteredOther.add(e);
      }
    }
  }

  /**
   *
   *  This function returns the filtered list containing the miscellaneous 
   *  issues that don't fit in other categories. 
   *
   *  @return filteredOther - the filtered list
   *
   */
  public ArrayList<Entry> getOther()
  {    
    return filteredOther;
  }
}

