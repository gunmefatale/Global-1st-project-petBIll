package pet.hos.model;

public class AvgPriceDTO {

	// 진료비 고유번호 
	private int avgHosNo;
	
	// 진료비 병원 정보 및 시,구 
	private String avgHosName;
	private String avgHosGu;
	private String avgHosSi;
	
	// 진료비 각 정보.
	private int avgBasicVaccin;
	private int avgNeuteringMan;
	private int avgNeuteringWoman;
	private int avgHeartWorm;
	
	
	public int getAvgHosNo() {
		return avgHosNo;
	}
	public void setAvgHosNo(int avgHosNo) {
		this.avgHosNo = avgHosNo;
	}
	public String getAvgHosName() {
		return avgHosName;
	}
	public void setAvgHosName(String avgHosName) {
		this.avgHosName = avgHosName;
	}
	public String getAvgHosGu() {
		return avgHosGu;
	}
	public void setAvgHosGu(String avgHosGu) {
		this.avgHosGu = avgHosGu;
	}
	public String getAvgHosSi() {
		return avgHosSi;
	}
	public void setAvgHosSi(String avgHosSi) {
		this.avgHosSi = avgHosSi;
	}
	public int getAvgBasicVaccin() {
		return avgBasicVaccin;
	}
	public void setAvgBasicVaccin(int avgBasicVaccin) {
		this.avgBasicVaccin = avgBasicVaccin;
	}
	public int getAvgNeuteringMan() {
		return avgNeuteringMan;
	}
	public void setAvgNeuteringMan(int avgNeuteringMan) {
		this.avgNeuteringMan = avgNeuteringMan;
	}
	public int getAvgNeuteringWoman() {
		return avgNeuteringWoman;
	}
	public void setAvgNeuteringWoman(int avgNeuteringWoman) {
		this.avgNeuteringWoman = avgNeuteringWoman;
	}
	public int getAvgHeartWorm() {
		return avgHeartWorm;
	}
	public void setAvgHeartWorm(int avgHeartWorm) {
		this.avgHeartWorm = avgHeartWorm;
	}
	
	
	
	
	
	
}
