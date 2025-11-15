//
//  HomeView.swift
//  LoginApp
//
//  Protected home screen for authenticated users
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var showSettings = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    // Welcome section
                    welcomeSection
                    
                    // User info card
                    userInfoCard
                    
                    // Features grid
                    featuresGrid
                    
                    // Settings and logout
                    settingsSection
                }
                .padding()
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showSettings.toggle()
                    }) {
                        Image(systemName: "gear")
                            .foregroundColor(.blue)
                    }
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
                    .environmentObject(authVM)
            }
        }
    }
    
    // MARK: - Welcome Section
    
    private var welcomeSection: some View {
        VStack(spacing: 10) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            
            if let user = authVM.currentUser {
                Text("Welcome, \(user.name)!")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(user.email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.top, 20)
    }
    
    // MARK: - User Info Card
    
    private var userInfoCard: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Account Information")
                .font(.headline)
            
            if let user = authVM.currentUser {
                InfoRow(icon: "person.fill", title: "Name", value: user.name)
                Divider()
                InfoRow(icon: "envelope.fill", title: "Email", value: user.email)
                Divider()
                InfoRow(icon: "number", title: "User ID", value: user.id)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(15)
    }
    
    // MARK: - Features Grid
    
    private var featuresGrid: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Quick Actions")
                .font(.headline)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 15) {
                FeatureCard(icon: "chart.bar.fill", title: "Analytics", color: .blue)
                FeatureCard(icon: "bell.fill", title: "Notifications", color: .orange)
                FeatureCard(icon: "folder.fill", title: "Documents", color: .purple)
                FeatureCard(icon: "star.fill", title: "Favorites", color: .yellow)
            }
        }
    }
    
    // MARK: - Settings Section
    
    private var settingsSection: some View {
        VStack(spacing: 15) {
            // Biometric toggle
            if BiometricAuthManager.shared.isBiometricAvailable() {
                VStack(alignment: .leading, spacing: 12) {
                    Toggle(isOn: Binding(
                        get: { authVM.biometricAuthEnabled },
                        set: { enabled in
                            if enabled {
                                authVM.enableBiometricAuth()
                            } else {
                                authVM.disableBiometricAuth()
                            }
                        }
                    )) {
                        HStack {
                            Image(systemName: BiometricAuthManager.shared.biometricType() == .faceID ?
                                  "faceid" : "touchid")
                                .foregroundColor(.green)
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Enable \(BiometricAuthManager.shared.biometricType() == .faceID ? "Face ID" : "Touch ID")")
                                    .font(.body)
                                Text("Quick login on next visit")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            }
            
            // Logout button
            Button(action: {
                withAnimation {
                    authVM.logout()
                }
            }) {
                HStack {
                    Image(systemName: "arrow.right.square.fill")
                    Text("Logout")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.red)
                .cornerRadius(10)
            }
        }
    }
}

// MARK: - Supporting Views

struct InfoRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.body)
            }
            
            Spacer()
        }
    }
}

struct FeatureCard: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 30))
                .foregroundColor(color)
            
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .background(Color(.systemGray6))
        .cornerRadius(15)
    }
}

// MARK: - Settings View

struct SettingsView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Section("Account") {
                    if let user = authVM.currentUser {
                        HStack {
                            Text("Name")
                            Spacer()
                            Text(user.name)
                                .foregroundColor(.secondary)
                        }
                        
                        HStack {
                            Text("Email")
                            Spacer()
                            Text(user.email)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Section {
                    if BiometricAuthManager.shared.isBiometricAvailable() {
                        Toggle(isOn: Binding(
                            get: { authVM.biometricAuthEnabled },
                            set: { enabled in
                                if enabled {
                                    authVM.enableBiometricAuth()
                                } else {
                                    authVM.disableBiometricAuth()
                                }
                            }
                        )) {
                            HStack {
                                Image(systemName: BiometricAuthManager.shared.biometricType() == .faceID ?
                                      "faceid" : "touchid")
                                Text(BiometricAuthManager.shared.biometricType() == .faceID ?
                                     "Face ID" : "Touch ID")
                            }
                        }
                    }
                    
                    Button("Change Password") {
                        // Action for changing password
                    }
                } header: {
                    Text("Security")
                } footer: {
                    if BiometricAuthManager.shared.isBiometricAvailable() {
                        Text("Enable \(BiometricAuthManager.shared.biometricType() == .faceID ? "Face ID" : "Touch ID") to quickly log in without entering your password.")
                            .font(.caption)
                    }
                }
                
                Section("About") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                }
                
                Section {
                    Button(role: .destructive) {
                        authVM.logout()
                        dismiss()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Logout")
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject({
            let vm = AuthViewModel()
            vm.currentUser = User(id: "1", email: "demo@demo.com", name: "Demo User")
            vm.isAuthenticated = true
            return vm
        }())
}

