package classes;

public class Company {
    
    private String comId;
    private String comName;
    private String comAddress;
    private String comPhone;
    private String comNotes;
    private String comGST;
    private String comStat;
    private String[] comCat;
    private ContactPerson[] comCons;
    
    public String getComId(){
        return comId;
    }
    
    public String getComName(){
        return comName;
    }
    
    public String getComAdd(){
        return comAddress;
    }
    
    public String getComPhone(){
        return comPhone;
    }
    
    public String getComNotes(){
        return comNotes;
    }
    
    public String getComGST(){
        return comGST;
    }
    
    public String getComStat(){
        return comStat;
    }
    
    public String[] getComCat(){
        return comCat;
    }
    
    public ContactPerson[] getContactPerson(){
        return comCons;
    }
    
    public Company(){}
    
    public Company(String id, String name, String add, String notes, String gst, String stat, String[] cat, ContactPerson[] cons){
        this.comId = id;
        this.comName = name;
        this.comAddress = add;
        this.comNotes = notes;
        this.comGST = gst;
        this.comStat = stat;
//        comCat = new String[cat.length];
//        for(int x = 0; x < cat.length; x++){
//            this.comCat[x] = comCat[x];
//        }
        this.comCat = cat;  
        comCons = new ContactPerson[cons.length];
        this.comCons = cons;
    }
    
}
