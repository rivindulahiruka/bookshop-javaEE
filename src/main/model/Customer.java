package main.model;

public class Customer {
    private int id;
    private String accNo;
    private String name;
    private String address;
    private String phone;
    private String email;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getaccNo() { return accNo; }
    public void setAccNo(String accNo) { this.accNo = accNo; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
}
