package pet.hos.model;

import java.text.DecimalFormat;

public class PubDataDAO {

	public static void main(String[] args) {
		
		DecimalFormat df = new DecimalFormat("#,###");
		
		double basicVaccin = 0;
		double totalBasicVaccin = 0;
		
		double neuteringMan = 0;
		double neuteringWoman = 0;
		
		double heartWorm = 0;
		
		// 기초 접종
		System.out.println("-------------------기초접종---------------------");
		for (int i = 0; i < 33; i++) {
			int totalBasicVaccin3 = ((int)totalBasicVaccin) * 3;
			for (int j = 0; j < 3; j ++) {
				basicVaccin = (Math.round((Math.random() * (45.000 - 31.000)) + 31.000)) * 1000;	
				totalBasicVaccin = basicVaccin;
			}
//			System.out.println(df.format(totalBasicVaccin3));
			System.out.println(totalBasicVaccin3);
		}
		
		// 중성화(남) 
		System.out.println("----------------중성화(남)------------------------");
		for (int i = 0; i < 32; i++) {
			neuteringMan = (Math.round((Math.random() * (190.000 - 140.000)) + 140.000)) * 1000;	
			System.out.println((int)neuteringMan);
		}
//		System.out.println("중성화(남) : " + df.format(neuteringMan));
		
		// 중성화(여) 
		System.out.println("-----------------중성화(여)-----------------------");
		for (int i = 0; i < 32; i++) {
			neuteringWoman = (Math.round((Math.random() * (390.000 - 340.000)) + 340.000)) * 1000;	
			System.out.println((int)neuteringWoman);
		}
//		System.out.println("중성화(여) : " + df.format(neuteringWoman));
		
		// 심장사상충
		System.out.println("--------------------심장사상--------------------");
		for (int i = 0; i < 32; i++) {
			heartWorm = (Math.round((Math.random() * (45.000 - 40.000)) + 40.000)) * 1000;	
			System.out.println((int)heartWorm);
		}
//		System.out.println("심장사상충 : " + df.format(heartWorm));
		
	}
}


