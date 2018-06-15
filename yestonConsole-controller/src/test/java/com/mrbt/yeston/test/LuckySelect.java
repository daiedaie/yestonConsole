package com.mrbt.yeston.test;

import java.util.Random;

public class LuckySelect {
	public static void main(String[] args) {
		
		int ydj = 0;
		int edj = 0;
		for (int i = 0; i < 100; i++) {
			Js js = new Js();
			int x = 0;
			while(x < 10000){
				Thread t = new cjsx(js);
				t.start();
				
				x++;
				if(Thread.activeCount() > 100){
					try {
						Thread.sleep(100);
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
			
			System.out.println(js.getAz());
			System.out.println(js.getBz());
			System.out.println(js.getCz());
			System.out.println(js.getDz());
			System.out.println(js.getEz());
			System.out.println(js.getFz());
			
			ydj = ydj + js.getAz();
			edj = edj + js.getBz();
		}
		
		System.out.println("冲到一等奖的总次数:" + ydj);
		System.out.println("冲到二等奖的总次数:" + edj);
		
	}
}

class Js{
	int az;
	int bz;
	int cz;
	int dz;
	int ez;
	int fz;
	public int getAz() {
		return az;
	}
	public void setAz(int az){
		this.az = az;
	}
	public int getBz() {
		return bz;
	}
	public void setBz(int bz) {
		this.bz = bz;
	}
	public int getCz() {
		return cz;
	}
	public void setCz(int cz) {
		this.cz = cz;
	}
	public int getDz() {
		return dz;
	}
	public void setDz(int dz) {
		this.dz = dz;
	}
	public int getEz() {
		return ez;
	}
	public void setEz(int ez) {
		this.ez = ez;
	}
	public int getFz() {
		return fz;
	}
	public void setFz(int fz) {
		this.fz = fz;
	}
}

class cjsx extends Thread{
	
	static int j = 10000;
	static int a = 1;
	static int[] b = {2, 11};
	static int[] c = {12, 113};
	static int[] d = {114, 4515};
	static int[] e = {4516, 7316};
	static int[] f = {7317, 10000};
	
	static Random r = new Random();
	
	static Js js = new Js();
	
	public cjsx(Js js2) {
		js = js2;
	}

	public void run(){
		cj();
	}
	
	public static void cj(){
		int z = r.nextInt(j);
		if(z == a){
			js.setAz(js.getAz() + 1);
		}
		if((b[0] <= z) && (b[1] >= z)){
			js.setBz(js.getBz() + 1);
		}
		if((c[0] <= z) && (c[1] >= z)){
			js.setCz(js.getCz() + 1);
		}
		if((d[0] <= z) && (d[1] >= z)){
			js.setDz(js.getDz() + 1);
		}
		if((e[0] <= z) && (e[1] >= z)){
			js.setEz(js.getEz() + 1);
		}
		if((f[0] <= z) && (f[1] >= z)){
			js.setFz(js.getFz() + 1);
		}
	}
}
