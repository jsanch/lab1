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

    void draw() {

        // Set Sizing Params
        chartWidth = width * .9;
        chartHeight = height * .75;
        baseX = width * .05;
        baseY = chartHeight + height * .05;

        // println("width: "+width);
        // println("height: "+height);

        drawXAxis();
        drawYAxis();
        drawData();
    }

    void drawXAxis() {

        // X-Axis Line
        line(width * .05, chartHeight + height * .05, width * .05 + chartWidth, chartHeight + height * .05);

        // X-Axis Labels
        int colCount = 1; 
        float colSpace = chartWidth/(dataTable.getRowCount()+1);
        int labelPadding= 10; 


        float lastX = -1; 
        float lastY = -1; 
        for (TableRow row : dataTable.rows()) {

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

    void drawYAxis() {

        // Set Drawing Parameters
        rectMode(CORNER);
        textSize(12);
        textAlign(RIGHT, CENTER);

        // Y-Axis Line
        line(width * .05, chartHeight + height * .05, width * .05, height * .05);
        
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

    abstract void drawData();

}

