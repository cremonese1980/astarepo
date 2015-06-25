package com.kre.dd;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.GradientPaint;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.geom.Ellipse2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

public class WriteImageType {
	
	private static final String HOME = "/home/cremo80/draw/";
	
	private static final int WIDTH = 800;
    private static final int HEIGHT = 800;
    private static final int OFFSET = 100;
    private static final int DIST = 10;
	
  static public void main(String args[]) throws Exception {
    try {
      int width = 200, height = 200;

      // TYPE_INT_ARGB specifies the image format: 8-bit RGBA packed
      // into integer pixels
      BufferedImage bi = new BufferedImage(WIDTH, HEIGHT, BufferedImage.TYPE_INT_ARGB);

      Graphics2D ig2 = bi.createGraphics();


//      Font font = new Font("TimesRoman", Font.BOLD, 20);
//      ig2.setFont(font);
//      String message = "www.java2s.com!";
//      FontMetrics fontMetrics = ig2.getFontMetrics();
//      int stringWidth = fontMetrics.stringWidth(message);
//      int stringHeight = fontMetrics.getAscent();
//      ig2.setPaint(Color.black);
//      ig2.drawString(message, (width - stringWidth) / 2, height / 2 + stringHeight / 4);
      
      drawDia(ig2);

      ImageIO.write(bi, "PNG", new File(HOME + "img.PNG"));
      ImageIO.write(bi, "JPEG", new File(HOME + "img.JPG"));
      ImageIO.write(bi, "gif", new File(HOME + "img.GIF"));
      ImageIO.write(bi, "BMP", new File(HOME + "img.BMP"));
      
    } catch (IOException ie) {
      ie.printStackTrace();
    }

  }
  
  
  private static void drawDia(Graphics g){
	  g.setColor(Color.MAGENTA);

      int center = HEIGHT/2;
      
      g.drawLine(center, OFFSET, center, HEIGHT-OFFSET);
      g.drawLine(OFFSET, center,WIDTH- OFFSET, center);
      
      
//		for (int x = OFFSET+DIST; x <= WIDTH - OFFSET; x+=DIST) {
//			if (x % DIST == 0) {
//				for (int y = OFFSET+DIST; y < HEIGHT - OFFSET; y+=DIST) {
//					if (x==y) {
//						
//						g.drawLine(x, HEIGHT-OFFSET, OFFSET, y);
//					}
//
//				}
//			}
//		}
//		
//		for (int x = OFFSET; x <= WIDTH - OFFSET; x+=DIST) {
//			if (x % DIST == 0) {
//				for (int y = OFFSET; y < HEIGHT - OFFSET; y+=DIST) {
//						
//						g.drawLine(x, HEIGHT-OFFSET, OFFSET, y);
//
//				}
//			}
//		}
      
      
      for (int x = OFFSET; x <= WIDTH - OFFSET; x+=DIST) {
			 
      	int distA = x-OFFSET+DIST;
      	int distB = x-center-DIST;
      	
      	if(x<center){
      		
      		g.drawLine(x, center, center, center-distA);
      		
      		g.drawLine(x, center, center, center+distA);
      	}else{
      		
      		g.drawLine(x, center, center, OFFSET+distB);
      		
      		g.drawLine(x, center, center, HEIGHT-OFFSET-distB);
      	}

      }
  }
  
}

         
