package customer;

import java.sql.Date;

public class Customer {
    private String fullName;
    private String address;
    private String phoneNumber;
    private String account_type;
    private String dateOfBirth;
    private String idProof;
    private String emailId;
    private String password;
    private int accountNo;

    // Getters and Setters for all fields
    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAccount_type() {
        return account_type;
    }

    public void setAccount_type(String account_type) {
        this.account_type = account_type;
    }

    public String getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(String dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getIdProof() {
        return idProof;
    }

    public void setIdProof(String idProof) {
        this.idProof = idProof;
    }

    public String getEmailId() {
        return emailId;
    }

    public void setEmailId(String emailId) {
        this.emailId = emailId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getAccountNo() {
        return accountNo;
    }

    public void setAccountNo(int accountNo) {
        this.accountNo = accountNo;
    }

	public void setAccountNumber(String string) {
		// TODO Auto-generated method stub
		
	}

	public void setDob(Date date) {
		// TODO Auto-generated method stub
		
	}

	public void setTypeOfAccount(String string) {
		// TODO Auto-generated method stub
		
	}

	public void setUsername(String string) {
		// TODO Auto-generated method stub
		
	}

	public void setInitialBalance(double double1) {
		// TODO Auto-generated method stub
		
	}
}
