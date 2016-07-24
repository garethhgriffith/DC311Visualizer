import processing.opengl.*;
//import codeanticode.glgraphics.*;
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.ui.*;
import controlP5.*;

//PRIMITIVES
private float locRad;
private int locIter;
private int currLoc;
private int reportTitleX, reportAddX, reportTimeX, reportDateX;
private int mapMarkX, mapMarkY, mapMarkW, mapMarkH;
private int filterX, filterY, filterW, filterH;
private int counter;
//MAP VARIABLES
private UnfoldingMap map;
private SimplePointMarker mark;
//FONTS
private PFont infoHeadFont;
private PFont infoTextFont;
private PFont filterFont;
private PFont resetFont;
private PFont fiftyFiveFont;
private PFont thirtySixFont;
//IMAGES
private PImage infoBg;
private PImage headText;
private PImage filterIcon;
private PImage filterGrey;
private PImage mapMarker;
private PImage mapGrey;
private PImage filterBg;
//SWITCHES  
private boolean filterOver;
private boolean mapMarkOver;
private boolean filterSwitch;
private boolean filterPage;
private boolean descriptionPage;
//INSTANTIATIONS
private Marker marker;
private ReportDesc reportDesc;
private ReportDesc reportTitleText;
private ReportDesc reportAddText;
private ReportDesc reportTimeText;
private ReportDesc reportDateText;
private LocationInfo currentLoc;
private ListFilter listFilter;
//LISTS, ARRAYS.....
private XML[] xmlEntry;
private ArrayList<Entry> unfilteredData;
private ArrayList<Entry> filteredData;
//LOCATION
private Location washDC;
//CONTROLP5
ControlP5 cp5;
ControlP5 cp5Button;
CheckBox checkbox;
Button resetButton, plusButton, minusButton;
int btnActColor = color(50, 50, 50, 220);
int btnBgColor = color(100, 100, 100, 220);
int btnFgColor = color(150, 150, 150, 220);


/**
 *
 * This function is basically the master constructor of the
 * processing sketch. 
 *  
 */
public void setup()
{
//  size(1600, 900, GLConstants.GLGRAPHICS);
  size(1600, 900);

  colorMode(HSB, 360, 100, 100, 100);
  smooth();

  //GRAPHICAL ELEMENTS
  infoBg = loadImage("123.png");
  headText = loadImage("311HeadText.png");
  mapMarker = loadImage("mapMarker.png");
  mapGrey = loadImage("mapGrey.png");
  filterIcon = loadImage("filter.png");
  filterGrey = loadImage("filterGrey.png");
  filterBg = loadImage("filterBg.png");  
  //FONTS
  infoHeadFont = loadFont("HelveticaNeueLT-Light-50.vlw");
  infoTextFont = loadFont("HelveticaNeueLT-Light-36.vlw");
  filterFont = loadFont("HelveticaNeueLT-Light-23.vlw");
  resetFont = loadFont("HelveticaNeueLT-Light-13.vlw");
  fiftyFiveFont = loadFont("HelveticaNeueLT-Light-55.vlw");
  thirtySixFont = loadFont("HelveticaNeueLT-Light-36.vlw");
  //filterFont = createFont("Helvetica LT 45 Light", 23);
  //resetFont = createFont("Helvetica LT 45 Light", 13);
   //CONTROLP5
  cp5 = new ControlP5(this);
  cp5Button = new ControlP5(this);
  resetButton = cp5Button.addButton("   Reset Map")
    .setValue(50)
      .setColorBackground(btnBgColor)
        .setColorActive(btnActColor)
          .setColorForeground(btnFgColor)
            .setPosition(width - 95, 20)
              .setSize(78, 20);
  resetButton.getCaptionLabel()
    .setFont(resetFont)
      .toUpperCase(false);

  minusButton = cp5Button.addButton("      -")
    .setValue(50)
      .setColorBackground(btnBgColor)
        .setColorActive(btnActColor)
          .setColorForeground(btnFgColor)
            .setPosition(width - 95, 43)
              .setSize(37, 20);
  minusButton.getCaptionLabel().setFont(resetFont);

  plusButton = cp5Button.addButton("      +")
    .setValue(50)
      .setColorBackground(btnBgColor)
        .setColorActive(btnActColor)
          .setColorForeground(btnFgColor)
            .setPosition(width - 54, 43)
              .setSize(37, 20);              
  plusButton.getCaptionLabel().setFont(resetFont);

  cp5.setControlFont(filterFont);
  checkbox = cp5.addCheckBox("checkbox")
    .setPosition(50, height-200)
      .setColorLabel(color(0))
        .setSize(41, 41)
          .setItemsPerRow(3)
            .setSpacingColumn(350)
              .setSpacingRow(25)
                .addItem("  Maintenance & Repairs", 0)
                  .addItem("  Vehicle Violations", 0)
                    .addItem("  Public Works", 0)
                      .addItem("  Public Health", 0)
                        .addItem("  City Programs", 0)
                          .addItem("  Vegetation Maintenance", 0)
                            .addItem("  DMV", 0)
                              .addItem("  Fire & Emergency", 0)
                                .addItem("  Other", 0)
                                  .toUpperCase(false);
  //CUSTOMIZED ICONS FOR CHECKBOX
  for (Toggle t : checkbox.getItems()) 
  {
    t.setView(new CheckBoxItemView());
  }
  checkbox.hide();
  //LOCATION MARKER SIZE
  locRad = 12;
  //TEXT SCROLLERS
  reportTitleX = 0;
  reportAddX = 0;
  reportTimeX = 0;
  reportDateX = 0;
  //ICON VARIABLES
  mapMarkX = width - 400;
  mapMarkY = height - 170;
  mapMarkW = mapMarker.width+275;
  mapMarkH = mapMarker.height;

  filterX = width - 400;
  filterY = height - 98;
  filterW = filterIcon.width+220;
  filterH = filterIcon.height;

  filterOver = false;
  mapMarkOver = false;
  filterPage = false;
  descriptionPage = true;  
  //XML DATA
  XML xml = loadXML("http://data.octo.dc.gov/feeds/src/src_current.xml");
  //TEMPORARY XML FILE IN CASE WEB XML IS DOWN
//  XML xml = loadXML("data/src_current.xml");
  xmlEntry = xml.getChildren("entry");
  //MAP
  washDC = new Location (38.88500, -77.1201);
//  map = new UnfoldingMap(this, new OpenStreetMap.CloudmadeProvider("243a7ed56c5e48cc9956c699638586ee", 999));
//  map = new UnfoldingMap(this, new OpenStreetMap.OpenStreetMapProvider());
//  map = new UnfoldingMap(this, new StamenMapProvider.Toner());
//  map = new UnfoldingMap(this, new Google.GoogleMapProvider());
//  map = new UnfoldingMap(this, new EsriProvider.WorldStreetMap());
//  map = new UnfoldingMap(this, new Google.GoogleTerrainProvider());
//  map = new UnfoldingMap(this, new Microsoft.RoadProvider());
//  map = new UnfoldingMap(this, new Microsoft.AerialProvider());
//  map = new UnfoldingMap(this, new AcetateProvider.Roads());
//  map = new UnfoldingMap(this, new ThunderforestProvider.Landscape());
//  map = new UnfoldingMap(this, new Google.GoogleSimplifiedProvider());
  map = new UnfoldingMap(this, new Google.GoogleSimplifiedProvider());


  map.setZoomRange(12, 18);
  map.zoomAndPanTo(washDC, 12);
  MapUtils.createDefaultEventDispatcher(this, map);
  //MAP MARKERS
  marker = new Marker();
  currentLoc = new LocationInfo(xmlEntry);
  //UNFILTERED LIST
  unfilteredData = new ArrayList<Entry>();   
  buildList(); 
  //FILTERED LIST
  listFilter = new ListFilter(unfilteredData);
  listFilter.filterList();
  filteredData = new ArrayList<Entry>(unfilteredData);
  //INITIALIZE CURRENT LOCATION
  locIter = filteredData.size()-1;
  currLoc = filteredData.size()-1;
}
/**
 *
 * This function scrapes the xml data and builds a list of objects that contain the
 * location information.
 *
 */
public void buildList()
{
  for (int i = 0; i < xmlEntry.length; i++)
  {

    String reportCode = currentLoc.getReportCode(i);
    int category = categoryCheck(reportCode);
    String description = currentLoc.getReportTitle(i);
    String address = currentLoc.getReportAddress(i);
    String zip = currentLoc.getReportZip(i);
    String time = currentLoc.getReportTime(i);
    String date = currentLoc.getReportDate(i);
    float locX = currentLoc.getLocX(i);
    float locY = currentLoc.getLocY(i);

    unfilteredData.add(new Entry(reportCode, category, description, address, zip, time, date, locX, locY));
  }
}
/**
 *
 *  This function takes the reports code and breaks it into categories based on its type
 *
 *  @ param reportCode - the reports code
 *  @ return category - the reports category
 *
 */
public int categoryCheck(String reportCode)
{
  int category = 8;
  String code = reportCode;
  if (code.equals("S0016") 
    || code.equals("S05AL") 
    || code.equals("MARKINST") 
    || code.equals("MARKMODI") 
    || code.equals("S0276") 
    || code.equals("S0016")
    || code.equals("S0301")
    || code.equals("S0361")
    || code.equals("SIGNMISS")
    || code.equals("S0376")
    || code.equals("S0287")
    || code.equals("S0286")
    || code.equals("S05SL")
    || code.equals("SIGTRAMA")
    || code.equals("S0466")
    || code.equals("S0081")
    || code.equals("MARKMAIN"))
  {
    category = 0;
  }
  if (code.equals("DMVADJSU") 
    || code.equals("DMV40") 
    || code.equals("DMV48")
    || code.equals("DMV66") 
    || code.equals("DMV01") 
    || code.equals("DMV08") 
    || code.equals("DMV43")
    || code.equals("DMV37")
    || code.equals("ITISSUES")
    || code.equals("DMPRCEMA")
    || code.equals("DMV51")
    || code.equals("DMV63")
    || code.equals("DMV71")
    || code.equals("DMV19")
    || code.equals("DMV31")
    || code.equals("DMVOFFSE"))
  {
    category = 1;
  }
  if (code.equals("S0011")
    || code.equals("GRAFF")
    || code.equals("Voucher")
    || code.equals("S0181")
    || code.equals("S0031") 
    || code.equals("S0196")
    || code.equals("S0316") 
    || code.equals("S0321") 
    || code.equals("S0346")
    || code.equals("S0391") 
    || code.equals("S0423")
    || code.equals("S0422")
    || code.equals("S0451")
    || code.equals("TRACO001")
    || code.equals("S0441")
    || code.equals("S0476")
    || code.equals("SWMCOLBU")
    || code.equals("TRUREPOR")
    || code.equals("SRC01")
    || code.equals("S0421")
    || code.equals("RECCONRE"))
  {
    category = 2;
  }
  if (code.equals("S0003") 
    || code.equals("S0000") 
    || code.equals("S0021") 
    || code.equals("DDOTCITA") 
    || code.equals("HMDCP") 
    || code.equals("S0336")
    || code.equals("S0261")
    || code.equals("RPP"))
  {
    category = 3;
  }
  if (code.equals("11") 
    || code.equals("INSECTS") 
    || code.equals("S0311"))
  {
    category = 4;
  }
  if (code.equals("PVDNUSIT") 
    || code.equals("PEDSAFPR"))
  {
    category = 5;
  }
  if (code.equals("S0457") 
    || code.equals("S04TP") 
    || code.equals("PRUNING") 
    || code.equals("S0459") 
    || code.equals("S0471")
    || code.equals("S0460"))
  {
    category = 6;
  }
  if (code.equals("FESPEDNU") 
    || code.equals("FESAADNU") 
    || code.equals("CFSAMISS") 
    || code.equals("DHS09"))
  {
    category = 7;
  }
  if (code.equals("SPSTDAMA"))
  {
    category = 8;
  }
  return category;
}

/**
 *
 * This function is the brains of the sketch and runs as an infinite loop
 * until the program is exited.
 *  
 */
public void draw()
{      
  map.draw();
  update();
  //  printCodes();

  drawMarker();

  //HEADER
  image(headText, 50, 50);
  fill(180, 0, 100); 

  infoBar();
  displayInfo();
  freezeMap();
//  println(frameRate);
   
}

/**
 *
 * This function draws all of the markers on the map using their geo-location.
 * If the marker is clicked it will then display the information associated
 * with that marker.
 * 
 *  
 */
public void drawMarker()
{
  //GENERAL LOCATION MARKERS
  for (int i = 0; i < filteredData.size(); i++)  
  {    
    float locX = filteredData.get(i).getLocX();
    float locY = filteredData.get(i).getLocY();
    Location incident = new Location(locX, locY);
    mark = new SimplePointMarker(incident);
    ScreenPosition markPos = mark.getScreenPosition(map);

    String reportCode = filteredData.get(i).getReportCode();
    int category = filteredData.get(i).getCategory();

    marker.display(markPos.x, markPos.y, locRad, category); 

    if (dist(markPos.x, markPos.y, mouseX, mouseY) < locRad/2  && mousePressed && (mouseButton == LEFT))
    { 
      locIter = i;
      filterOver = false;
      descriptionPage = true;
      filterPage = false;
    }
  }
} 

/**
 *
 * This function displays the text information about the selected location.
 * 
 *  
 */
public void displayInfo()
{
  //DISPLAY CURRENT REPORT INFORMATIVE TEXT AND MARKER
  if (locIter > -1)
  { 
    //CATEGORY ICON
    int category = filteredData.get(locIter).getCategory();   
    PImage catImage = categoryImage(category); 
    image(catImage, 50, height-200); 

    //REPORT DESCRIPTION
    String description = filteredData.get(locIter).getDesc();
    reportTitleText = new ReportDesc(description, fiftyFiveFont, 55, 0);
    reportTitleText.display(250, height-183, 450, reportTitleX);
    reportTitleX = reportTitleText.getTextX();

    //REPORT ADDRESS
    String address = filteredData.get(locIter).getAdd();
    reportAddText = new ReportDesc(address, thirtySixFont, 36, 0);
    reportAddText.display(250, height-125, 450, reportAddX);
    reportAddX = reportAddText.getTextX();

    //REPORT CITY, STATE, ZIP
    String zip = filteredData.get(locIter).getZip();
    fill(0);
    textFont(infoTextFont);
    //textAlign(LEFT);
    text("Washington, DC " + zip, 250, height - 47);

    textAlign(CENTER);
    text("Received ", 949, height - 145);
    fill(50);
    textAlign(LEFT);
    line(750, height - 133, 1148, height - 133);

    //REPORT TIME
    fill(0);
    String time = filteredData.get(locIter).getTime();
    reportTimeText = new ReportDesc(time, thirtySixFont, 36, 0);
    reportTimeText.display(750, height-125, 700, reportTimeX);
    reportTimeX = reportTimeText.getTextX();

    //REPORT DATE
    String date = filteredData.get(locIter).getDate();
    text(date, 750, height - 47);

    //ACTIVE LOCATION MARKER
    float locX = filteredData.get(locIter).getLocX();
    float locY = filteredData.get(locIter).getLocY();
    Location incident = new Location(locX, locY);
    mark = new SimplePointMarker(incident);
    ScreenPosition markPos = mark.getScreenPosition(map);
    marker.activeLoc(markPos.x, markPos.y);

    //STORE THE ITERATOR
    currLoc = locIter;
  }
}
/**
 *
 * This function checks the reports category and sets the appropriate icon for 
 * its category
 *  
 * @param category - the report category
 * @return catImage -  the category icon
 *  
 */
public PImage categoryImage(int category)
{
  PImage catImage;
  if (category == 0)
  {
    catImage = loadImage("maint.png");
  }
  else if (category == 1)
  {
    catImage = loadImage("dmv.png");
  }
  else if (category == 2)
  {
    catImage = loadImage("gear.png");
  }
  else if (category == 3)
  {
    catImage = loadImage("vwBus.png");
  }
  else if (category == 4)
  {
    catImage = loadImage("dead.png");
  }
  else if (category == 5)
  {
    catImage = loadImage("city.png");
  }
  else if (category == 6)
  {
    catImage = loadImage("tree.png");
  }
  else if (category == 7)
  {
    catImage = loadImage("ems.png");
  }
  else
  {
    catImage = loadImage("other.png");
  }
  return catImage;
}
/**
 *
 * This function switches back and forth between the information display
 * page and the filtering options page. 
 * 
 *  
 */
public void infoBar()
{
  //SWITCH BETWEEN THE FILTER BAR AND THE DESCRIPTION BAR
  if (filterOver == true  && mousePressed && (mouseButton == LEFT))
  {   
    locIter = -1;
    filterPage = true;
    descriptionPage = false;
  }
  else if (mapMarkOver == true  && mousePressed && (mouseButton == LEFT))
  {   
    locIter = filteredData.size()-1;
    filterPage = false;    
    descriptionPage = true;
    mapMarkOver = false;
  }
  //DISPLAY THE FILTER OPTIONS
  if (filterPage == true)
  {   
    image(filterBg, 0, height-225); 
    
    checkbox.show();
    noStroke();
    //TOP ROW
    fill(150, 83, 63);
    ellipse(71, height-178, 37, 37);    
    fill(54, 83, 63);
    ellipse(461, height-178, 37, 37);    
    fill(86, 83, 63);
    ellipse(852, height-178, 37, 37);    
    //MIDDLE ROW
    fill(22, 83, 63);
    ellipse(71, height-113, 37, 37); 
    fill(350, 83, 63);
    ellipse(461, height-113, 37, 37);
    fill(318, 83, 63);
    ellipse(852, height-113, 37, 37);
    //BOTTOM ROW
    fill(118, 83, 63);
    ellipse(71, height-46, 37, 37);
    fill(286, 83, 63);
    ellipse(461, height-46, 37, 37);    
    fill(254, 83, 63);
    ellipse(852, height-46, 37, 37);
    
    image(mapGrey, mapMarkX, mapMarkY);  
    image(filterIcon, filterX, filterY);    
    textFont(infoTextFont);
    textAlign(LEFT);
    fill(50);
    text("Current Location", mapMarkX + mapMarker.width + 20, mapMarkY + mapMarker.height/1.2);
    fill(0);
    text("Filter Results", filterX + filterIcon.width + 23, filterY + filterIcon.height/1.3);
  }
  else if (descriptionPage == true)
  {
    checkbox.hide();
    image(infoBg, 0, height-225);
    image(mapMarker, mapMarkX, mapMarkY);
    image(filterGrey, filterX, filterY);
    textFont(infoTextFont);
    textAlign(LEFT);
    fill(0);
    text("Current Location", mapMarkX + mapMarker.width + 20, mapMarkY + mapMarker.height/1.2);
    fill(50);
    text("Filter Results", filterX + filterIcon.width + 23, filterY + filterIcon.height/1.3);
  }
}

/**
 *
 * This function will freeze the current map position if you are interacting
 * with a controlP5 element.
 *  
 */
public void freezeMap()
{
  if (cp5.window(this).isMouseOver())
  {
    map.setPanningRestriction(map.getCenter(), 0);
  }
  else 
  {
    map.resetPanningRestriction();
  }
}

/**
 *
 * This function monitors the status of the checkboxes and updates
 * its status.
 * 
 *  
 */
public void controlEvent(ControlEvent theEvent) 
{  
  if (theEvent.isFrom(resetButton))
  {   
    map.zoomAndPanTo(new Location (38.88500, -77.1201), 12);
  }
  if (theEvent.isFrom(plusButton))
  {   
    map.zoomIn();
    map.setPanningRestriction(map.getCenter(), 0);
  }
  if (theEvent.isFrom(minusButton))
  {   
    map.zoomOut();
    map.setPanningRestriction(map.getCenter(), 0);
  }

  if (theEvent.isFrom(checkbox)) 
  { 
    filteredData.clear();   

    if (checkbox.getArrayValue()[0] == 1)
    { 
      filteredData.addAll(listFilter.getCityMaint());
    }    
    if (checkbox.getArrayValue()[1] == 1)
    {   
      filteredData.addAll(listFilter.getVehicleViolations());
    }
    if (checkbox.getArrayValue()[2] == 1)
    {   
      filteredData.addAll(listFilter.getPublicWorks());
    }
    if (checkbox.getArrayValue()[3] == 1)
    {   
      filteredData.addAll(listFilter.getPest());
    }
    if (checkbox.getArrayValue()[4] == 1)
    {   
      filteredData.addAll(listFilter.getCityPrograms());
    }
    if (checkbox.getArrayValue()[5] == 1)
    {   
      filteredData.addAll(listFilter.getVegMaint());
    }
    if (checkbox.getArrayValue()[6] == 1)
    {   
      filteredData.addAll(listFilter.getDMV());
    }
    if (checkbox.getArrayValue()[7] == 1)
    {   
      filteredData.addAll(listFilter.getFireEmergency());
    }
    if (checkbox.getArrayValue()[8] == 1)
    {   
      filteredData.addAll(listFilter.getOther());
    }
    if ((checkbox.getArrayValue()[0] == 0)
      && (checkbox.getArrayValue()[1] == 0)
      && (checkbox.getArrayValue()[2] == 0)
      && (checkbox.getArrayValue()[3] == 0)
      && (checkbox.getArrayValue()[4] == 0)
      && (checkbox.getArrayValue()[5] == 0)
      && (checkbox.getArrayValue()[6] == 0)
      && (checkbox.getArrayValue()[7] == 0)
      && (checkbox.getArrayValue()[8] == 0))
    {
      filteredData.addAll(unfilteredData);
    }
  }
}

/**
 *
 * This function checks to see if the mouse is over an item.
 * 
 *  @param x - The x cooridinate of the item.
 *  @param y - The y cooridinate of the item.
 *  @param w - The width of the item.
 *  @param h - The height of the item.
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
 *
 * This function checks the mouse position and its relation to the item. 
 *  
 */
public void update() 
{  
  if (overRect(filterX, filterY, filterW, filterH))
  {
    filterOver = true;
    mapMarkOver = false;
  }
  else if (overRect(mapMarkX, mapMarkY, mapMarkW, mapMarkH))
  {
    mapMarkOver = true;
    filterOver = false;
  }
}

