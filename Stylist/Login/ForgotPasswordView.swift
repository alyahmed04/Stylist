//
//  ForgotPasswordView.swift
//  LoginApp
//
//  Password reset screen
//

import SwiftUI

struct ForgotPasswordView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var email = ""
    @State private var emailSent = false
    @State private var showError = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    // Header
                    VStack(spacing: 10) {
                        Image(systemName: "key.fill")
                            .font(.system(size: 70))
                            .foregroundColor(.brown)
                            .padding(.top, 40)
                        
                        Text("Forgot Password?")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Enter your email address and we'll send you instructions to reset your password")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding(.bottom, 20)
                    
                    if !emailSent {
                        // Email input section
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Email")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            HStack {
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(.gray)
                                
                                TextField("Enter your email", text: $email)
                                    .textInputAutocapitalization(.never)
                                    .keyboardType(.emailAddress)
                                    .autocorrectionDisabled()
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        }
                        
                        // Error message
                        if showError {
                            HStack {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.red)
                                Text(errorMessage)
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(10)
                        }
                        
                        // Send button
                        Button {
                            sendResetEmail()
                        } label: {
                            if authVM.isLoading {
                                ProgressView()
                                    .progressViewStyle(.circular)
                                    .tint(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                            } else {
                                Text("Send Reset Link")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                            }
                        }
                        .background(
                            (email.isEmpty || authVM.isLoading) ? 
                            Color.gray : .brown
                        )
                        .cornerRadius(10)
                        .disabled(email.isEmpty || authVM.isLoading)
                        
                        // Back to login
                        Button("Back to Login") {
                            dismiss()
                        }
                        .foregroundColor(.blue)
                        .padding(.top, 10)
                        
                    } else {
                        // Success message
                        VStack(spacing: 20) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 80))
                                .foregroundColor(.green)
                            
                            Text("Email Sent!")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text("Check your email for password reset instructions")
                                .font(.body)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                            
                            VStack(spacing: 15) {
                                Text("Didn't receive the email?")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                Button("Resend Email") {
                                    sendResetEmail()
                                }
                                .font(.headline)
                                .foregroundColor(.blue)
                            }
                            .padding(.top, 20)
                            
                            Button("Back to Login") {
                                dismiss()
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.top, 30)
                        }
                    }
                    
                    // Help text
                    if !emailSent {
                        VStack(spacing: 10) {
                            Divider()
                                .padding(.vertical, 10)
                            
                            Text("Need help?")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Button("Contact Support") {
                                // Action for contacting support
                            }
                            .font(.caption)
                            .foregroundColor(.blue)
                        }
                        .padding(.top, 20)
                    }
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    // MARK: - Send Reset Email
    
    private func sendResetEmail() {
        showError = false
        
        // Validate email
        guard authVM.isValidEmail(email) else {
            errorMessage = "Please enter a valid email address"
            showError = true
            return
        }
        
        authVM.sendPasswordResetEmail(email: email) { success in
            if success {
                withAnimation {
                    emailSent = true
                }
            } else {
                errorMessage = "Failed to send reset email. Please try again."
                showError = true
            }
        }
    }
}

#Preview {
    ForgotPasswordView()
        .environmentObject(AuthViewModel())
}

