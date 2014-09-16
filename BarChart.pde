public class BarChart extends Chart {

        ArrayList<Button> dataPoints;

        BarChart(Table dataIn) {
                super(dataIn);
                dataPoints = new ArrayList<Button>();
        }
}