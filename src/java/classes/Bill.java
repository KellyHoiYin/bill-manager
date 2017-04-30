package classes;

public class Bill {
    
    private String billId;
    private String billDate;
    private String billRef;
    private String billRemarks;
    private String billStat;
    private Company issueTo;
    private String issueBy;
    private Product[] billProd;
    
    public String getBillId(){
        return billId;    
    }
    
    public String getBillDate(){
        return billDate;
    }
    
    public String getBillRef(){
        return billRef;
    }
    
    public String getBillRemark(){
        return billRemarks;
    }
    
    public String getBillStat(){
        return billStat;
    }
    
    public Company getIssueTo(){
        return issueTo;
    }
    
    public String getIssueBy(){
        return issueBy;
    }
    
    public Product[] getProds(){
        return billProd;
    }
}
