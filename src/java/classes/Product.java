package classes;

public class Product {
    
    private String prodId;
    private String prodCode;
    private String prodDesc;
    private String prodOPrice;
    private String prodUnit;
    private String prodCat;
    
    //for billing details
    private String quantity;
    private String sellPrice;
    private String sellDesc;
    
    public String getProdId(){
        return prodId;
    }
    
    public String getProdCode(){
        return prodCode;
    }
    
    public String getProdDesc(){
        return prodDesc;
    }
    
    public String getProdOPrice(){
        return prodOPrice;
    }
    
    public String getProdUnit(){
        return prodUnit;
    }
    
    public String getProdCat(){
        return prodCat;
    }
    
    public String getQuantity(){
        return quantity;
    }
    
    public String getSellPrice(){
        return sellPrice;
    }
    
    public String getSellDesc(){
        return sellDesc;
    }
    
}
