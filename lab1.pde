Button b;
// float chartWidth;
// float chartHeight;
// ArrayList<RoundButton> dataPoints;

LineChart lineChart;

void setup() {
    size(800, 600);
    background(255);
    frame.setResizable(true);
    //chartWidth = width * .9;
    //chartHeight = height * .75;
    Table dataTable = parseCSV("lab1-data.csv");
    lineChart = new LineChart(dataTable);

    
    b = new Button(width * .2, height * .2, width * .25, height * .25, 200, "Switch to\nBar Graph", "Switch to\nLine Graph");

    

}

void draw() {
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


void mouseClicked() {
    if (b.intersectsWith(mouseX, mouseY)) {
        b.click();
    }
}

void resize() {
    //chartWidth = width * .9;
    //chartHeight = height * .75;
    b.resizeButton(width * .10, height * .10);

}

Table parseCSV(String filename) {
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