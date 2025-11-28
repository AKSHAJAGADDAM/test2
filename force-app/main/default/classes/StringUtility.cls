/**
 * @description Provides basic utility methods for String manipulation and validation.
 */
public class StringUtility {

    /**
     * @description Checks if a string conforms to a basic email pattern (contains '@' and '.').
     * @param inputString The string value to validate.
     * @return true if the string appears to be a basic email, false otherwise.
     */
    public static Boolean isValidEmailBasic(String inputString) {
        // Return false immediately if the string is null or empty
        if (String.isBlank(inputString)) {
            return false;
        }

        // Basic check: must contain '@' and '.'
        // Note: Real-world email validation requires a more complex regex.
        if (inputString.contains('@') && inputString.contains('.')) {
            return true;
        } else {
            return false;
        }
    }
}