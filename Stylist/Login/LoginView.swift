//
//  LoginView.swift
//  LoginApp
//
//  Login screen with email/password authentication
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var showRegistration = false
    @State private var showForgotPassword = false
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    // Logo/Header
                    VStack(spacing: 10) {
                        Image(systemName: "jacket.fill")
                            .font(.system(size: 70))
                            .foregroundColor(.brown)
                            .padding(.top, 40)
                        
                        Text("Stylist")
                            .font(.system(size: 60, weight: .bold, design: .serif))
                        
                        Text("Sign in to continue")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.bottom, 20)
                    
                    // Biometric login option (only show if user has logged in before)
                    if authVM.biometricAuthEnabled && 
                       BiometricAuthManager.shared.isBiometricAvailable() && 
                       authVM.currentUser != nil {
                        biometricLoginButton
                    }
                    
                    // Email field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        HStack {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.gray)
                            
                            TextField("Enter your email", text: $email)
                                .textInputAutocapitalization(.never)
                                .keyboardType(.emailAddress)
                                .autocorrectionDisabled()
                                .accessibilityLabel("Email address field")
                                .accessibilityHint("Enter your email address")
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    }
                    
                    // Password field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundColor(.gray)
                            
                            if showPassword {
                                TextField("Enter your password", text: $password)
                                    .autocorrectionDisabled()
                            } else {
                                SecureField("Enter your password", text: $password)
                                    .accessibilityLabel("Password field")
                                    .accessibilityHint("Enter your password")
                            }
                            
                            Button(action: {
                                showPassword.toggle()
                            }) {
                                Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    }
                    
                    // Forgot password
                    HStack {
                        Spacer()
                        Button("Forgot Password?") {
                            showForgotPassword = true
                        }
                        .font(.subheadline)
                        .foregroundColor(.blue)
                    }
                    
                    // Error message
                    if let error = authVM.errorMessage {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.red)
                            Text(error)
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(10)
                    }
                    
                    // Login button
                    Button {
                        if authVM.validateLoginInput(email: email, password: password) {
                            authVM.login(email: email, password: password)
                        }
                    } label: {
                        if authVM.isLoading {
                            ProgressView()
                                .progressViewStyle(.circular)
                                .tint(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                        } else {
                            Text("Login")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                        }
                    }
                    .background(
                        (email.isEmpty || password.isEmpty || authVM.isLoading) ? 
                        Color.gray : .brown
                    )
                    .cornerRadius(10)
                    .disabled(email.isEmpty || password.isEmpty || authVM.isLoading)
                    .accessibilityLabel("Login button")
                    .accessibilityHint("Double tap to log in")
                    
                    // Sign up link
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(.secondary)
                        Button("Sign Up") {
                            showRegistration = true
                        }
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                    }
                    .padding(.top, 10)
                    
                    // Demo credentials helper
                    demoCrendentialsView
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showRegistration) {
                RegistrationView()
                    .environmentObject(authVM)
            }
            .sheet(isPresented: $showForgotPassword) {
                ForgotPasswordView()
                    .environmentObject(authVM)
            }
        }
    }
    
    // MARK: - Biometric Login Button
    
    private var biometricLoginButton: some View {
        Button(action: {
            authVM.loginWithBiometrics { success in
                if success {
                    print("Biometric login successful")
                }
            }
        }) {
            HStack {
                Image(systemName: BiometricAuthManager.shared.biometricType() == .faceID ? 
                      "faceid" : "touchid")
                    .font(.title2)
                
                Text("Login with \(BiometricAuthManager.shared.biometricType() == .faceID ? "Face ID" : "Touch ID")")
                    .font(.headline)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.green)
            .cornerRadius(10)
        }
    }
    
    // MARK: - Demo Credentials View
    
    private var demoCrendentialsView: some View {
        VStack(spacing: 8) {
            Divider()
                .padding(.vertical, 10)
            
            Text("Demo Credentials")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("Email:")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text("student@example.com")
                        .font(.caption2)
                        .fontWeight(.medium)
                }
                HStack {
                    Text("Password:")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text("password123")
                        .font(.caption2)
                        .fontWeight(.medium)
                }
            }
            .padding(8)
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
}

