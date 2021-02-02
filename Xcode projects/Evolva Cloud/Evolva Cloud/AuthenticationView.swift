//
//  AuthenticationView.swift
//  Evolva Cloud
//
//  Created by Marko Kramar on 26.01.2021..
//

import SwiftUI
import LocalAuthentication

struct AuthenticationView: View {
    @Binding var unlocked: Bool
    
    @State var authenticationText = "Please authenticate via Face ID or Touch ID before using this app."
    @State var authenticationNotSuccessful = false
    
    var body: some View {
        Text(authenticationText)
            .padding(30)
            .foregroundColor(authenticationNotSuccessful ? .red : .secondary)
            .navigationBarHidden(true)
        
        Button("Authenticate") {
            self.authenticate()
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Need to unlock app access."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.unlocked = true
                    } else {
                        self.authenticationNotSuccessful = true
                        self.authenticationText = "Error while trying to authenticate. Please try again."
                    }
                }
            }
        }
    }
}
