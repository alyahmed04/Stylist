//
//  AuthViewModel.swift
//  LoginApp
//
//  Manages authentication state and user session
//

import Foundation
import SwiftUI
import Combine

enum AuthError: LocalizedError {
    case invalidCredentials
    case networkError
    case accountNotFound
    case serverError
    case emailAlreadyExists
    case weakPassword
    case invalidEmail
    case passwordMismatch
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Incorrect email or password. Please try again."
        case .networkError:
            return "Network error. Please check your internet connection."
        case .accountNotFound:
            return "No account found with this email. Would you like to sign up?"
        case .serverError:
            return "Something went wrong on our end. Please try again later."
        case .emailAlreadyExists:
            return "An account with this email already exists."
        case .weakPassword:
            return "Password must be at least 8 characters long."
        case .invalidEmail:
            return "Please enter a valid email address."
        case .passwordMismatch:
            return "Passwords do not match."
        }
    }
}

class AuthViewModel: ObservableObject {
    // MARK: - Published Properties
    
    @State private var modelData = ModelData()
    
    @Published var isAuthenticated = false {
        didSet {
            UserDefaults.standard.set(isAuthenticated, forKey: "isLoggedIn")
        }
    }
    
    @Published var currentUser: User? {
        didSet {
            saveUser()
        }
    }
    
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var biometricAuthEnabled = false
    
    // Session management
    private var sessionTimer: Timer?
    private let sessionTimeout: TimeInterval = 900 // 15 minutes
    
    // MARK: - Initialization
    
    init() {
        // Check if user was previously logged in
        self.isAuthenticated = UserDefaults.standard.bool(forKey: "isLoggedIn")
        self.biometricAuthEnabled = UserDefaults.standard.bool(forKey: "biometricAuthEnabled")
        
        // Load saved user
        loadUser()
        
        if isAuthenticated {
            startSession()
        }
    }
    
    // MARK: - Login
    
    func login(email: String, password: String) {
        errorMessage = nil
        isLoading = true
        
        // Simulate network delay (replace with real API call)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else { return }
            
            // Mock authentication - replace with real API
            if email.lowercased() == "student@example.com" && password == "password123" {
                // Success!
                let user = User(
                    id: UUID().uuidString,
                    email: email,
                    name: "Student User"
                )
                self.currentUser = user
                self.isAuthenticated = true
                self.startSession()
            } else if email.lowercased() == "demo@demo.com" && password == "demo1234" {
                // Additional demo account
                let user = User(
                    id: UUID().uuidString,
                    email: email,
                    name: "Demo User"
                )
                self.currentUser = user
                self.isAuthenticated = true
                self.startSession()
            } else {
                // Failed
                self.errorMessage = "Invalid email or password"
            }
            
            self.isLoading = false
        }
    }
    
    // MARK: - Registration
    
    func register(name: String, email: String, password: String, confirmPassword: String) {
        errorMessage = nil
        isLoading = true
        
        // Validate passwords match
        guard password == confirmPassword else {
            errorMessage = AuthError.passwordMismatch.localizedDescription
            isLoading = false
            return
        }
        
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else { return }
            
            // Mock registration - replace with real API
            // In real app, check if email already exists
            modelData.currentUser = User(
                id: UUID().uuidString,
                email: email,
                name: name,
            )
            
            self.currentUser = modelData.currentUser!
            self.isAuthenticated = true
            self.startSession()
            self.isLoading = false
        }
    }
    
    // MARK: - Biometric Authentication
    
    func loginWithBiometrics(completion: @escaping (Bool) -> Void) {
        guard biometricAuthEnabled else {
            completion(false)
            return
        }
        
        let biometricType = BiometricAuthManager.shared.biometricType()
        let reason = biometricType == .faceID ? "Log in with Face ID" : "Log in with Touch ID"
        
        BiometricAuthManager.shared.authenticate(reason: reason) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                // Load saved user and authenticate
                self.loadUser()
                if self.currentUser != nil {
                    self.isAuthenticated = true
                    self.startSession()
                    completion(true)
                } else {
                    self.errorMessage = "No saved user found"
                    completion(false)
                }
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                completion(false)
            }
        }
    }
    
    func enableBiometricAuth() {
        biometricAuthEnabled = true
        UserDefaults.standard.set(true, forKey: "biometricAuthEnabled")
    }
    
    func disableBiometricAuth() {
        biometricAuthEnabled = false
        UserDefaults.standard.set(false, forKey: "biometricAuthEnabled")
    }
    
    // MARK: - Logout
    
    func logout() {
        isAuthenticated = false
        // Don't clear currentUser - keep it for Face ID to work on next login
        errorMessage = nil
        sessionTimer?.invalidate()
        sessionTimer = nil
    }
    
    func completeLogout() {
        // Complete logout - clears all user data (use for "Sign out completely" or account switching)
        isAuthenticated = false
        currentUser = nil
        biometricAuthEnabled = false
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        UserDefaults.standard.removeObject(forKey: "currentUser")
        UserDefaults.standard.removeObject(forKey: "biometricAuthEnabled")
        errorMessage = nil
        sessionTimer?.invalidate()
        sessionTimer = nil
    }
    
    // MARK: - Password Reset
    
    func sendPasswordResetEmail(email: String, completion: @escaping (Bool) -> Void) {
        isLoading = true
        
        // Simulate sending reset email
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.isLoading = false
            // In real app, call API to send reset email
            completion(true)
        }
    }
    
    // MARK: - Session Management
    
    func startSession() {
        resetSessionTimer()
    }
    
    func resetSessionTimer() {
        sessionTimer?.invalidate()
        sessionTimer = Timer.scheduledTimer(withTimeInterval: sessionTimeout, repeats: false) { [weak self] _ in
            self?.logout()
        }
    }
    
    func userActivity() {
        // Call this on user interactions to reset timeout
        if isAuthenticated {
            resetSessionTimer()
        }
    }
    
    // MARK: - User Persistence
    
    private func saveUser() {
        guard let user = currentUser else {
            UserDefaults.standard.removeObject(forKey: "currentUser")
            return
        }
        
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: "currentUser")
        }
    }
    
    private func loadUser() {
        if let userData = UserDefaults.standard.data(forKey: "currentUser"),
           let user = try? JSONDecoder().decode(User.self, from: userData) {
            self.currentUser = user
        }
    }
    
    // MARK: - Validation
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func validateLoginInput(email: String, password: String) -> Bool {
        // Check if fields are empty
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields"
            return false
        }
        
        // Validate email format
        guard isValidEmail(email) else {
            errorMessage = "Please enter a valid email address"
            return false
        }
        
        return true
    }
    
    func validateRegistrationInput(name: String, email: String, password: String, confirmPassword: String) -> Bool {
        // Check all fields filled
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            errorMessage = "Please fill in all fields"
            return false
        }
        
        // Validate email
        guard isValidEmail(email) else {
            errorMessage = "Please enter a valid email address"
            return false
        }
        
        // Check password strength
        guard password.count >= 8 else {
            errorMessage = "Password must be at least 8 characters"
            return false
        }
        
        // Check passwords match
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match"
            return false
        }
        
        return true
    }
}

