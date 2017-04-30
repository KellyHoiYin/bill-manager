package classes;

public class ContactPerson {
    
    private String conID;
    private String conFName;
    private String conLName;
    private String conPhone;
    private String conEmail;
    private String conFax;
    
    public String getConID(){
        return conID;
    }
    
    public String getConFName(){
        return conFName;
    }
    
    public String getConLName(){
        return conLName;
    }
    
    public String getConPhone(){
        return conPhone;
    }
    
    public String getConEmail(){
        return conEmail;
    }
    
    public String getConFax(){
        return conFax;
    }
    
    public ContactPerson(){}
    
    public ContactPerson(String id, String fn, String ln, String ph, String email, String fax){
        this.conID = id;
        this.conFName = fn;
        this.conLName = ln;
        this.conPhone = ph;
        this.conEmail = email;
        this.conFax = fax;
    }
    
    public String toString(){
        return conFName + conLName + ": " + conPhone + " (PH) | " + conEmail + " | " + conFax + " (Fax)";
    }
}
