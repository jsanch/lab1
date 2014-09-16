public class BarChartButton extends Button {

        float top;

        BarChartButton() {
                super();
        }


        BarChartButton(float x, float y, float w, float h, float t, String text) {
                xpos = x;
                ypos = y;
                width = w;
                height = h;
                top = t;
                currentColor = color(200);
                currentText = text;

        }

        void display() {
                fill(currentColor);
                rectMode(CENTER);
                rect(xpos, ypos, width, height);

        }

        boolean intersectsWith(int x, int y) {
                return (x > (xpos - width / 2) && 
                        x < (xpos + width / 2) &&
                        y > (ypos - height / 2)  &&
                        y < (ypos + height / 2));
        }

        float getTop() {
                return top;
        }
}