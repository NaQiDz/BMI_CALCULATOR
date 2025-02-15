package com.example.mysecondlabtest.model;

public class Data {

    private String strName, strWeight, strHeight, strBMI, strStatus;

    public Data(String strName, String strWeight, String strHeight, String strBMI, String strStatus) {
        this.strName = strName;
        this.strWeight = strWeight;
        this.strHeight = strHeight;
        this.strBMI = strBMI;
        this.strStatus = strStatus;
    }

    public String getStrName() {return strName;}
    public String getStrWeight() {return strWeight;}
    public String getStrHeight() {return strHeight;}
    public String getStrBMI() {return strBMI;}
    public String getStrStatus() {return strStatus;}

    public void setStrName(String strName) {this.strName = strName;}
    public void setStrWeight(String strWeight) {this.strWeight = strWeight;}
    public void setStrHeight(String strHeight) {this.strHeight = strHeight;}
    public void setStrBMI(String strBMI) {this.strBMI = strBMI;}
    public void setStrStatus(String strStatus) {this.strStatus = strStatus;}

}
