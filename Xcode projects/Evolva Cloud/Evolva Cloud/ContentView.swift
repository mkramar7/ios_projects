//
//  ContentView.swift
//  Evolva Cloud
//
//  Created by Marko Kramar on 25.01.2021..
//

import SwiftUI

struct ContentView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var url = ""
    
    @State private var loginResultAlertShown = false
    @State private var loginResultTitle = ""
    @State private var loginResultMessage = ""
    @State private var loginSuccessful = false
    
    @State private var isUnlocked = false
    @AppStorage("authentication_required") var authenticationRequired: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                if authenticationRequired && !isUnlocked {
                    AuthenticationView(unlocked: $isUnlocked)
                } else {
                    Image("ef_logo")
                        .resizable()
                        .scaledToFit()
                        .padding(20)
                    
                    VStack {
                        TextField("Enter username", text: $username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        SecureField("Enter password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        TextField("Enter URL", text: $url)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        
                        NavigationLink("", destination: EvolvaCloudAppWebView(url: self.url, requestBody: self.getCloudAppLoginHttpBodyParams()), isActive: $loginSuccessful)
                    
                        Button(action: {
                            self.doLogin()
                        }) {
                            HStack {
                                Image(systemName: "arrow.up.forward.app")
                                Text("Login to cloud app")
                                    .font(.headline)
                            }
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .stroke(lineWidth: 2.0)
                            )
                        }
                        .disabled(self.cannotPressLoginButton())
                    }
                    .padding(20)
                    .navigationBarHidden(true)
                }
            }
            .navigationBarTitle("Login settings")
            .alert(isPresented: $loginResultAlertShown) {
                Alert(title: Text(self.loginResultTitle), message: Text(self.loginResultMessage), dismissButton: .default(Text("OK")))
            }
            
            WelcomeView()
        }
    }
    
    func cannotPressLoginButton() -> Bool {
        self.username.isEmpty || self.password.isEmpty || self.url.isEmpty
    }
    
    func getCloudAppLoginHttpBodyParams() -> Data? {
        let params: [String: Any] = [
            "module" : "com.evolutionframework.flatdesign.LoginMobile",
            "akcija" : "login",
            "epis_user" : self.username,
            "epis_password" : self.password,
            "new_base_template" : "flat_design_mobile"
        ]
        
        return params.ampersandEncoded()
    }
    
    func doLogin() {
        guard let cloudAppUrl = URL(string: self.url), UIApplication.shared.canOpenURL(cloudAppUrl) else {
            showAlertError(title: "Wrong URL", message: "Please enter valid app URL.")
            return
        }
        
        var request = URLRequest(url: cloudAppUrl)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = getCloudAppLoginHttpBodyParams()
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  error == nil else {
                showAlertError(title: "Error", message: "There was an error while trying to open cloud app URL. Please contact administrator.")
                print("Error: ", error ?? "Unknown error")
                return
            }
            
            if response.statusCode != 200 {
                print("Response not OK, HTTP error code: \(response.statusCode)")
                return
            }
            
            guard let responseString = String(data: data, encoding: .windowsCP1250) else {
                print("Could not decode response")
                return
            }
            
            DispatchQueue.main.async {
                if !responseString.contains("<div class=\"indexScreen\"") {
                    showAlertError(title: "Login error", message: "Wrong username or password")
                    self.loginResultAlertShown = true
                    return
                }
                
                self.loginSuccessful = true
            }
            
            print("Response string: \(responseString)")
        }.resume()
    }
    
    func showAlertError(title: String, message: String) {
        self.loginResultTitle = title
        self.loginResultMessage = message
        self.loginResultAlertShown = true
    }
}

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to Evolva Cloud iPad app")
                .font(.largeTitle)
            
            Text("Please open Login settings and enter required login data for Evolva cloud app you wish to use.")
                .foregroundColor(.secondary)
        }
    }
}
