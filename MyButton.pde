public class Button {
        float xpos;
        float ypos;
        float width;
        float height;
        color currentColor;
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

        Button(float x, float y, float w, float h, color col, String text1, String text2) {
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


        void display() {
                fill(currentColor);
                rectMode(CENTER);
                rect(xpos, ypos, width, height);
                textAlign(CENTER, CENTER);
                textSize(12);
                fill(0);
                text(currentText, xpos, ypos);
        }

        boolean intersectsWith(int x, int y) {
                return (x > (xpos - width / 2) && 
                        x < (xpos + width / 2) &&
                        y > (ypos - height / 2)  &&
                        y < (ypos + height / 2));
        }

        void update() {
        
        }

        
        float getX() {
                return xpos;
        }

        void setX(float x) {
                xpos = x;
        }

    
        float getY() {
                return ypos;
        }

        void setY(int y) {
                ypos = y;
        }

        void setWidth(int w) {
                width = w;
        }

        void setHeight(int h) {
                height = h;
        }

        void setColor(color newColor) {
                currentColor = newColor;
        }


        String getText() {
                return currentText;
        }

        void setText(String newText) {
                currentText = newText;
        }


        void click() {
                clicked = !clicked;
                if (currentText == t1) {
                        currentText = t2;
                } else { 
                        currentText = t1;
                }
        }

        boolean isClicked() {
            return clicked;
        }

        void resizeButton(float w, float h) {
                width = w;
                height = h;
    
        }



}


