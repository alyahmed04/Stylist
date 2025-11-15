//
//  BiometricAuthManager.swift
//  LoginApp
//
//  Handles Face ID and Touch ID authentication
//

import Foundation
import LocalAuthentication

class BiometricAuthManager {
    
    static let shared = BiometricAuthManager()
    
    private init() {}
    
    enum BiometricType {
        case none
        case touchID
        case faceID
    }
    
    enum BiometricError: Error {
        case notAvailable
        case notEnrolled
        case authenticationFailed
        case userCancel
        case unknown
        
        var localizedDescription: String {
            switch self {
            case .notAvailable:
                return "Biometric authentication is not available on this device"
            case .notEnrolled:
                return "No biometric authentication is enrolled. Please set up Face ID or Touch ID in Settings"
            case .authenticationFailed:
                return "Authentication failed. Please try again"
            case .userCancel:
                return "Authentication was cancelled"
            case .unknown:
                return "An unknown error occurred"
            }
        }
    }
    
    // Check what type of biometric authentication is available
    func biometricType() -> BiometricType {
        let context = LAContext()
        var error: NSError?
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return .none
        }
        
        switch context.biometryType {
        case .faceID:
            return .faceID
        case .touchID:
            return .touchID
        default:
            return .none
        }
    }
    
    // Check if biometric authentication is available
    func isBiometricAvailable() -> Bool {
        let context = LAContext()
        var error: NSError?
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
    }
    
    // Authenticate with biometrics
    func authenticate(reason: String, completion: @escaping (Result<Void, BiometricError>) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        // Check if biometric authentication is available
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            if let error = error {
                switch error.code {
                case LAError.biometryNotAvailable.rawValue:
                    completion(.failure(.notAvailable))
                case LAError.biometryNotEnrolled.rawValue:
                    completion(.failure(.notEnrolled))
                default:
                    completion(.failure(.unknown))
                }
            } else {
                completion(.failure(.notAvailable))
            }
            return
        }
        
        // Perform authentication
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
            DispatchQueue.main.async {
                if success {
                    completion(.success(()))
                } else {
                    if let error = authError as? LAError {
                        switch error.code {
                        case .userCancel, .userFallback, .systemCancel:
                            completion(.failure(.userCancel))
                        case .authenticationFailed:
                            completion(.failure(.authenticationFailed))
                        default:
                            completion(.failure(.unknown))
                        }
                    } else {
                        completion(.failure(.unknown))
                    }
                }
            }
        }
    }
}

