package com.mrbt.yeston.web.utils;

import java.awt.AlphaComposite;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import javax.imageio.ImageIO;

import org.apache.commons.io.IOUtils;

/**
 * @author loxn
 */
public class WaterMarkHelper {

	public static void main(String[] args) throws Exception {
		WaterMarkHelper helper = new WaterMarkHelper();
		WaterMarkConfigure configure = helper.new WaterMarkConfigure();
		configure.setFont(new Font("华文彩云", Font.ITALIC, 60));
		configure.setWaterMarkContent("领钱儿");
		configure.setMarkContentColor(new Color(255, 255, 255));
		configure.setDegree(null);
		configure.setAlpha(0.5f);
		InputStream srcStream = new FileInputStream("E:/gallery/image-3.jpg");
		InputStream stream = helper.getMarkedInputstream(srcStream, configure);
		IOUtils.copy(stream, new FileOutputStream("E:/ss.jpg"));
	}

	/**
	 * 获得加水印后的流
	 * 
	 * @param src
	 *            原图流
	 * @param configure
	 *            水印配置
	 * @return
	 */
	public InputStream getMarkedInputstream(InputStream src, WaterMarkConfigure configure) {
		try {
			Image srcImg = ImageIO.read(src);
			int srcImgWidth = srcImg.getWidth(null);
			int srcImgHeight = srcImg.getHeight(null);
			// 加水印
			BufferedImage bufImg = new BufferedImage(srcImgWidth, srcImgHeight, BufferedImage.TYPE_INT_RGB);
			Graphics2D g = bufImg.createGraphics();
			g.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING, RenderingHints.VALUE_TEXT_ANTIALIAS_ON);
			g.drawImage(srcImg, 0, 0, srcImgWidth, srcImgHeight, null);
			g.setColor(configure.getMarkContentColor()); // 根据图片的背景设置水印颜色
			g.setFont(configure.getFont());

			Integer x = configure.getX();
			Integer y = configure.getY();
			// 水印默认位置，正中
			if(x == null){
				x = srcImgWidth / 2 - getWatermarkLength(configure.getWaterMarkContent(), g) / 2;
			}
			if(y == null){
				y = srcImgHeight / 2;
			}

			// 设置旋转度数
			if (configure.getDegree() != null) {
				g.rotate(Math.toRadians(configure.getDegree()), (double) bufImg.getWidth() / 2,
						(double) bufImg.getHeight() / 2);
			}

			// 设置透明度
			g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP, configure.getAlpha()));
			g.drawString(configure.getWaterMarkContent(), x, y);
			g.dispose();
			ByteArrayOutputStream os = new ByteArrayOutputStream();
			ImageIO.write(bufImg, "jpg", os);
			return new ByteArrayInputStream(os.toByteArray());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 获取水印文字总长度
	 */
	private int getWatermarkLength(String waterMarkContent, Graphics2D g) {
		return g.getFontMetrics(g.getFont()).charsWidth(waterMarkContent.toCharArray(), 0, waterMarkContent.length());
	}

	public class WaterMarkConfigure {
		private String waterMarkContent;// 水印文字
		private Font font;// 水印字体
		private Color markContentColor;// 水印颜色
		private Double degree;
		private Float alpha;
		private Integer x;
		private Integer y;

		public Integer getX() {
			return x;
		}

		public void setX(Integer x) {
			this.x = x;
		}

		public Integer getY() {
			return y;
		}

		public void setY(Integer y) {
			this.y = y;
		}

		public Float getAlpha() {
			return alpha;
		}

		public void setAlpha(Float alpha) {
			this.alpha = alpha;
		}

		public String getWaterMarkContent() {
			return waterMarkContent;
		}

		public void setWaterMarkContent(String waterMarkContent) {
			this.waterMarkContent = waterMarkContent;
		}

		public Font getFont() {
			return font;
		}

		public void setFont(Font font) {
			this.font = font;
		}

		public Color getMarkContentColor() {
			return markContentColor;
		}

		public void setMarkContentColor(Color markContentColor) {
			this.markContentColor = markContentColor;
		}

		public Double getDegree() {
			return degree;
		}

		public void setDegree(Double degree) {
			this.degree = degree;
		}
	}
}
