package classes;

public class Payment {
    
    private String payDate;
    private String payRefNo;
    private String payRefBank;
    private double payAmt;
    private String auditor;
    private String payType;
    private Company payBy;
    private Bill[] payBill;
    
    public String getPayDate(){
        return payDate;
    }
    
    public String getPayRefNo(){
        return payRefNo;
    }
    
    public String getPayRefBank(){
        return payRefBank;
    }
    
    public double getPayAmt(){
        return payAmt;
    }
    
    public String getAuditor(){
        return auditor;
    }
    
    public String getPayType(){
        return payType;
    }
    
    public Company getPayBy(){
        return payBy;
    }
    
    public Bill[] getPayBill(){
        return payBill;
    }
    
    public Payment(){}
    
    public Payment(String date, String ref, String bank, double amt, String audit, String type, Company by, Bill[] bill){
    this.payDate = date;
    this.payRefNo = ref;
    this.payRefBank = bank;
    this.payAmt = amt;
    this.auditor = audit;
    this.payType = type;
    this.payBy = by;
    this.payBill = bill;
    }
}
