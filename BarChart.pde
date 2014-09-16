public class BarChart extends Chart {

    ArrayList<BarChartButton> dataPoints;

    BarChart(Table dataIn) {
        super(dataIn);
        dataPoints = new ArrayList<BarChartButton>();
    }

    void drawData(){

        dataPoints.clear();
        int colCount = 1;
        float lastX = -1;
        float lastY = -1;

        float colSpace = chartWidth / (dataTable.getRowCount() + 1);

        float currentX = baseX;
        float currentY = baseY;

        for (TableRow row: dataTable.rows()) {
            currentX = baseX + (colSpace * colCount);
            currentY = baseY - chartHeight * (row.getFloat(" Number") / dataMax);
            float centerX = currentX;
            float centerY = baseY - ((baseY - currentY) / 2);
            BarChartButton b = new BarChartButton(centerX, centerY, colSpace, baseY - currentY, currentY, row.getString("Name") + "\n" + row.getString(" Number"));
            dataPoints.add(b);


            lastX = currentX;
            lastY = currentY;
            colCount++;
        }

        for(BarChartButton bu : dataPoints) {
            
            if (bu.intersectsWith(mouseX, mouseY)) {
                bu.setColor(color(0, 215, 245));
                bu.display();
                fill(0);
                textAlign(CENTER);
                textSize(12);
                text(bu.getText(), bu.getX(), bu.getY());
                bu.setColor(100);
            } else {
                bu.display();
            }
                

        }

    }
}