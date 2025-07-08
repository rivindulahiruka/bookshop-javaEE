package main.util;

import java.util.regex.Pattern;

public class Validator {
    private static final Pattern EMAIL_PATTERN= Pattern.compile(
            "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$"
    );
    private static final Pattern PHONE_PATTERN=Pattern.compile(
            "^[0-9]{10}$"
    );
    public static boolean isValidEmail(String email){
        return email !=null&& EMAIL_PATTERN.matcher(email).matches();
    }
    public static boolean isValidPhone(String phone) {
        return phone != null && PHONE_PATTERN.matcher(phone).matches();
    }
    public static boolean isNotEmpty(String value){
        return value !=null && !value.trim().isEmpty();
    }

}
