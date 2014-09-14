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


        void display() {
                fill(currentColor);
                ellipseMode(CENTER);
                ellipse(xpos, ypos, width, height);

        }

        boolean intersectsWith(float x, float y) {
                return (dist(x, y, xpos, ypos) < width);

        }
}