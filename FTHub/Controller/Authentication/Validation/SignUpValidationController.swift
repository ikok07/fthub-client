


final class SignUpValidationController: ValidationController {
    static func validate(name: String, email: String, password: String, confirmPassword: String) -> String? {
        if let message = super.validateName(name: name).message {
            return message
        }
        
        if let message = super.validateEmail(email: email).message {
            return message
        }
        
        if let message = super.validatePassword(password: password).message {
            return message
        }
        
        if password != confirmPassword {
            return "Passwords don't match."
        }
        
        return nil
    }
}
