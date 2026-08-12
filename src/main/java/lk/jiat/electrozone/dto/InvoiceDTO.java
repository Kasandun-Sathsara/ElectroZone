package lk.jiat.ElectroZone.dto;

import java.io.Serializable;
import java.util.List;

public class InvoiceDTO implements Serializable {
    private String invoiceNo;
    private String invoiceDate;
    private String invoiceStatus;
    private String buyerName;
    private String address;
    private String cityName;
    private String countryName;
    private String email;
    private List<InvoiceItemDTO> invoiceItemDTOList;
    private double shippingCharges;

    public String getBuyerName() {
        return buyerName;
    }

    public void setBuyerName(String buyerName) {
        this.buyerName = buyerName;
    }

    public String getInvoiceNo() {
        return invoiceNo;
    }

    public void setInvoiceNo(String invoiceNo) {
        this.invoiceNo = invoiceNo;
    }

    public String getInvoiceDate() {
        return invoiceDate;
    }

    public void setInvoiceDate(String invoiceDate) {
        this.invoiceDate = invoiceDate;
    }

    public String getInvoiceStatus() {
        return invoiceStatus;
    }

    public void setInvoiceStatus(String invoiceStatus) {
        this.invoiceStatus = invoiceStatus;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }

    public String getCountryName() {
        return countryName;
    }

    public void setCountryName(String countryName) {
        this.countryName = countryName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public List<InvoiceItemDTO> getInvoiceItemDTOList() {
        return invoiceItemDTOList;
    }

    public void setInvoiceItemDTOList(List<InvoiceItemDTO> invoiceItemDTOList) {
        this.invoiceItemDTOList = invoiceItemDTOList;
    }

    public double getShippingCharges() {
        return shippingCharges;
    }

    public void setShippingCharges(double shippingCharges) {
        this.shippingCharges = shippingCharges;
    }
}
