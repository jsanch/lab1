public class LineChart extends Chart {

    ArrayList<RoundButton> dataPoints;
    
    LineChart(Table dataIn) {
        super(dataIn);
        dataPoints = new ArrayList<RoundButton>();
      }

    void drawData() {
        dataPoints.clear();
        int colCount = 1;
        float lastX = -1;
        float lastY = -1;

        float colSpace = chartWidth / (dataTable.getRowCount() + 1);


        println(dataTable.getRowCount());
        for (TableRow row: dataTable.rows()) {
            float currentX = baseX + (colSpace * colCount);
            float currentY = baseY - chartHeight * (row.getFloat(" Number") / dataMax);
            RoundButton rb = new RoundButton(currentX, currentY, .01 * chartWidth, .01 * chartWidth, row.getString("Name") + " " + row.getString(" Number"));
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
                text(r.getText(), r.getX(), r.getY() - (chartWidth * .01 + 5));
            }
            r.display();
            r.setColor(100);

        }

    }

}