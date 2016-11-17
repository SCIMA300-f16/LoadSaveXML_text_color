/**
 * Loading XML Data
 * by Daniel Shiffman.  
 * 
 * This example demonstrates how to use loadXML()
 * to retrieve data from an XML file and make objects 
 * from that data.
 *
 * MH:: I added text input  
 * and code now tests string values to alter the color of the bubbles
 */
// An Array of Bubble objects
Bubble[] bubbles;

// A Table object
XML xml;

//variables related to text entry
String typedString = "";
char typedChars[] = new char[20];
int typedCount;

color c = color(255);

void setup() {
  size(600, 600);
  loadData();
}

void draw() {
  background(255);
  // Display all bubbles
  for (Bubble b : bubbles) {   
    b.display();
    b.rollover(mouseX, mouseY);
  }

  textAlign(LEFT);
  fill(0);
  text("1) Type out your emotion:", 10, height-30);
  text("2) Then click to add bubbles.", 10, height-10);
  textSize(18);
  text(typedString, 170, height-30);
  textSize(12);
}

void loadData() {
  // Load XML file
  xml = loadXML("data.xml");
  // Get all the child nodes named "bubble"
  XML[] children = xml.getChildren("bubble");

  // The size of the array of Bubble objects is determined by the total XML elements named "bubble"
  bubbles = new Bubble[children.length]; 

  for (int i = 0; i < bubbles.length; i++) {

    // The position element has two attributes: x and y
    XML positionElement = children[i].getChild("position");
    // Note how with attributes we can get an integer or float via getInt() and getFloat()
    float x = positionElement.getInt("x");
    float y = positionElement.getInt("y");

    // The diameter is the content of the child named "diamater"
    XML diameterElement = children[i].getChild("diameter");
    // Note how with the content of an XML node, we retrieve via getIntContent() and getFloatContent()
    float diameter = diameterElement.getFloatContent();

    // The label is the content of the child named "label"
    XML labelElement = children[i].getChild("label");
    String label = labelElement.getContent();

    // Make a Bubble object out of the data read
    bubbles[i] = new Bubble(x, y, diameter, label);
  }
}

// Still need to work on adding and deleting

void mousePressed() {

  // Create a new XML bubble element
  XML bubble = xml.addChild("bubble");

  // Set the poisition element
  XML position = bubble.addChild("position");
  // Here we can set attributes as integers directly
  position.setInt("x", mouseX);
  position.setInt("y", mouseY);

  // Set the diameter element
  XML diameter = bubble.addChild("diameter");
  // Here for a node's content, we have to convert to a String
  diameter.setFloatContent(random(100, 200));

  // Set a label
  XML label = bubble.addChild("label");
  if (typedString != null) {
    label.setContent(typedString);
  }

  // Here we are removing the oldest bubble if there are more than 10
  XML[] children = xml.getChildren("bubble");
  // If the XML file has more than 10 bubble elements
  if (children.length > 10) {
    // Delete the first one
    xml.removeChild(children[0]);
  }

  // Save a new XML file
  saveXML(xml, "data/data.xml");

  // reload the new data 
  loadData();

  typedString = "";
  typedCount = 0;
}

void keyPressed() {
  if ((key == BACKSPACE) || (key == DELETE)) {
    if (typedCount > 0) {
      typedCount--;
    }
    updateTyped();
  } else if ((key >= 'a') && (key <= 'z')) {
    typedChars[typedCount++] = key;
    println(typedCount);
  }
  updateTyped();
}

void updateTyped() {
  typedString = new String(typedChars, 0, typedCount);
  loop(); // re-enable updates
}