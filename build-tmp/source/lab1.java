import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class lab1 extends PApplet {

Button b;
// float chartWidth;
// float chartHeight;
// ArrayList<RoundButton> dataPoints;

LineChart lineChart;

public void setup() {
    size(800, 600);
    background(255);
    frame.setResizable(true);
    //chartWidth = width * .9;
    //chartHeight = height * .75;
    Table dataTable = parseCSV("lab1-data.csv");
    b = new Button(width * .2f, height * .2f, width * .25f, height * .25f, 200, "Switch to\nBar Graph", "Switch to\nLine Graph");

    /*println("Rows in Lab1.pde");
    for (TableRow row: dataTable.rows()) {
        println(row.getString("Name"));
    }
    println("End Rows");*/


    lineChart = new LineChart(dataTable);

}

public void draw() {
    background(255);
    resize();
    b.display();

    if (b.isClicked()) {
        println("bar chart");
    } else {
        lineChart.draw();
        //drawLineGraph();
    }   
    
} 


public void mouseClicked() {
    if (b.intersectsWith(mouseX, mouseY)) {
        b.click();
    }
}

public void resize() {
    //chartWidth = width * .9;
    //chartHeight = height * .75;
    b.resizeButton(width * .10f, height * .10f);

}

public Table parseCSV(String filename) {
    Table dataTable = loadTable(filename, "header");
    dataTable.trim();    
    return dataTable;
}

// void drawLineGraph() {
//     float colSpace = chartWidth/(dataTable.getRowCount()+1);
//     float baseX = width * .05;
//     float baseY = chartHeight + height * .05;

//     // Get Max Y Value
//     float max = -1;
//     for (TableRow row: dataTable.rows()) {
//         if (row.getFloat(" Number") > max) {
//             max = row.getFloat(" Number");
//         }
//     }

//     // Draw Y Axis Labels
//     drawYAxisLabels(chartWidth, chartHeight, baseX, baseY, max);
//     drawXAxisLabels(baseX, baseY, colSpace, max);

//     int colCount = 1;
//     float lastX = -1;
//     float lastY = -1;
//     for (TableRow row: dataTable.rows()) {
//         float currentX = baseX+(colSpace*colCount);
//         float currentY = baseY- chartHeight * (row.getFloat(" Number") / max);
//         RoundButton rb = new RoundButton(currentX, currentY, .02 * chartWidth, .02 * chartWidth, row.getString("Name") + " " + row.getString(" Number"));
//         dataPoints.add(rb);
//         if (lastX >= 0) {
//             line(currentX, currentY, lastX, lastY);
//         }

//         lastX = currentX;
//         lastY = currentY;
//         colCount++;
//     }

   
//     for(RoundButton r : dataPoints) {
//         if (r.intersectsWith(mouseX, mouseY)) {
//             r.setColor(color(0, 215, 245));
//             fill(0);
//             textAlign(CENTER);
//             text(r.getText(), r.getX(), r.getY() - (chartWidth * .01 + 5));
//         }
//         r.display();
//         r.setColor(100);

//     }
// }


/*void drawXAxisLabels(float baseX, float baseY, float colSpace, float max) {
    int colCount = 1; 
    float lastX = -1; 
    float lastY = -1; 
    for (TableRow row: dataTable.rows()) {
        
        float currentX = baseX + (colSpace*colCount);
        float currentY = baseY - chartHeight * (row.getFloat(" Number") / max);          
        
        textAlign(RIGHT, CENTER);
        pushMatrix();
        textSize(12);
        translate(currentX,baseY+10);
        rotate(-HALF_PI);
        text(row.getString("Name"), 0, 0);
        popMatrix();

        lastX = currentX;
        lastY = currentY;
        colCount++;
    }

}



void drawYAxisLabels(float chartWidth, float chartHeight, float baseX, float baseY, float maxVal) {

    // Set Basis
    rectMode(CORNER);
    textSize(12);
    textAlign(RIGHT, CENTER);
    
    // Pick a Number of Divisions
    int yDivisions = (int)chartHeight/50;
    // Find the Amount of Space Between the Divisions
    float yDivSpacing = chartHeight/(float)yDivisions;
    // Find the Value that Each Division Represents
    float yValuePerDiv = maxVal/yDivisions;
    // Print a Label at Each Division
    for (int i = 0; i <= yDivisions; i++) {
        float yPos = baseY - (i*yDivSpacing);
        float labelVal = yValuePerDiv*i;
        String label = String.format("%.1f", labelVal);
        text(label, baseX-5, yPos);
        
        line(baseX-3, yPos, baseX+3, yPos);
    }

}

*/
public abstract class Chart {

    // Set Based on Height/Width of Applet
    float chartWidth;
    float chartHeight;

    // Baseline of Graph (Origin Point)
    float baseX;
    float baseY;

    // Data Used to Build Graph
    Table dataTable;
    float dataMax;
    
    Chart(Table dataIn) {
        dataTable = dataIn;

        // Calculate Max Value (Doesn't Change)
        dataMax = -1;
        for (TableRow row: dataTable.rows()) {
            if (row.getFloat(" Number") > dataMax) {
                dataMax = row.getFloat(" Number");
            }
        }
    }

    public void draw() {

        // Set Sizing Params
        chartWidth = width * .9f;
        chartHeight = height * .75f;
        baseX = width * .05f;
        baseY = chartHeight + height * .05f;

        // println("width: "+width);
        // println("height: "+height);

        drawXAxis();
        drawYAxis();
        drawData();
    }

    public void drawXAxis() {

        // X-Axis Line
        line(width * .05f, chartHeight + height * .05f, width * .05f + chartWidth, chartHeight + height * .05f);

        // X-Axis Labels
        int colCount = 1; 
        float colSpace = chartWidth/(dataTable.getRowCount()+1);
        int labelPadding= 10; 


        float lastX = -1; 
        float lastY = -1; 
        for (TableRow row : dataTable.rows()) {

            //println(row.getString("Name"));
            
            float currentX = baseX + (colSpace*colCount);
            float currentY = baseY - chartHeight * (row.getFloat(" Number") / dataMax);          
            
            textAlign(RIGHT, CENTER);
            pushMatrix();
            textSize(12);
            translate(currentX, baseY+labelPadding);
            rotate(-HALF_PI);
            text(row.getString("Name"), 0, 0);
            popMatrix();

            lastX = currentX;
            lastY = currentY;
            colCount++;

        }

    }

    public void drawYAxis() {

        // Set Drawing Parameters
        rectMode(CORNER);
        textSize(12);
        textAlign(RIGHT, CENTER);

        // Y-Axis Line
        line(width * .05f, chartHeight + height * .05f, width * .05f, height * .05f);
        
        // Pick a Number of Divisions
        int yDivisions = (int)chartHeight/50;
        // Find the Amount of Space Between the Divisions
        float yDivSpacing = chartHeight/(float)yDivisions;
        // Find the Value that Each Division Represents
        float yValuePerDiv = dataMax/yDivisions;

        // Print a Label at Each Division
        for (int i = 0; i <= yDivisions; i++) {
            float yPos = baseY - (i*yDivSpacing);
            float labelVal = yValuePerDiv*i;
            String label = String.format("%.1f", labelVal);
            text(label, baseX-5, yPos);
            
            // And a Line to Look Nice
            line(baseX-3, yPos, baseX+3, yPos);
        }
        
    }

    public abstract void drawData();

}

public class LineChart extends Chart {

    ArrayList<RoundButton> dataPoints;
    
    LineChart(Table dataIn) {
        super(dataIn);
        dataPoints = new ArrayList<RoundButton>();
      }

    public void drawData() {
        dataPoints.clear();
        int colCount = 1;
        float lastX = -1;
        float lastY = -1;

        float colSpace = chartWidth / (dataTable.getRowCount() + 1);


        println(dataTable.getRowCount());
        for (TableRow row: dataTable.rows()) {
            println("name1: "+row.getString("Name"));
            println("num1:  "+row.getFloat(" Number"));
            float currentX = baseX + (colSpace * colCount);
            float currentY = baseY - chartHeight * (row.getFloat(" Number") / dataMax);
            RoundButton rb = new RoundButton(currentX, currentY, .01f * chartWidth, .01f * chartWidth, row.getString("Name") + " " + row.getString(" Number"));
            println("name2: "+row.getString("Name"));
            dataPoints.add(rb);
            if (lastX >= 0) {
                line(currentX, currentY, lastX, lastY);
            }

            lastX = currentX;
            lastY = currentY;
            colCount++;
        }

        for(RoundButton r : dataPoints) {
            
            if (r.intersectsWith(mouseX, mouseY)) {
                r.setColor(color(0, 215, 245));
                fill(0);
                textAlign(CENTER);
                text(r.getText(), r.getX(), r.getY() - (chartWidth * .01f + 5));
            }
            r.display();
            r.setColor(100);

        }

    }

}
public class Button {
        float xpos;
        float ypos;
        float width;
        float height;
        int currentColor;
        String currentText;
        String t1;
        String t2;
        boolean clicked;


        Button() {
                xpos = 200;
                ypos = 150;
                width = 200;
                height = 150;
                currentColor = color(100);
                currentText = "hello";
                t1 = "hello";
                t2 = "world";
                clicked = false;
        }

        Button(float x, float y, float w, float h, int col, String text1, String text2) {
                xpos = x;
                ypos = y;
                width = w;
                height = h;
                currentColor = color(col);
                currentText = text1;
                t1 = text1;
                t2 = text2;
                clicked = false;
        }


        public void display() {
                fill(currentColor);
                rectMode(CENTER);
                rect(xpos, ypos, width, height);
                textAlign(CENTER, CENTER);
                textSize(12);
                fill(0);
                text(currentText, xpos, ypos);
        }

        public boolean intersectsWith(int x, int y) {
                return (x > (xpos - width / 2) && 
                        x < (xpos + width / 2) &&
                        y > (ypos - height / 2)  &&
                        y < (ypos + height / 2));
        }

        public void update() {
        
        }

        
        public float getX() {
                return xpos;
        }

        public void setX(float x) {
                xpos = x;
        }

    
        public float getY() {
                return ypos;
        }

        public void setY(int y) {
                ypos = y;
        }

        public void setWidth(int w) {
                width = w;
        }

        public void setHeight(int h) {
                height = h;
        }

        public void setColor(int newColor) {
                currentColor = newColor;
        }


        public String getText() {
                return currentText;
        }

        public void setText(String newText) {
                currentText = newText;
        }


        public void click() {
                clicked = !clicked;
                if (currentText == t1) {
                        currentText = t2;
                } else { 
                        currentText = t1;
                }
        }

        public boolean isClicked() {
            return clicked;
        }

        public void resizeButton(float w, float h) {
                width = w;
                height = h;
    
        }



}


public class RoundButton extends Button {
        
        RoundButton() {
                super();

        }

        RoundButton(float x, float y, float w, float h, String txt) {
                xpos = x;
                ypos = y;
                width = w;
                height = h;
                currentColor = color(100);
                currentText = txt;
        }


        public void display() {
                fill(currentColor);
                ellipseMode(CENTER);
                ellipse(xpos, ypos, width, height);

        }

        public boolean intersectsWith(float x, float y) {
                return (dist(x, y, xpos, ypos) < width);

        }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "lab1" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
