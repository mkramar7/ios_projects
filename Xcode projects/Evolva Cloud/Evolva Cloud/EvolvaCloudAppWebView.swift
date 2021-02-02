//
//  EvolvaCloudAppView.swift
//  Evolva Cloud
//
//  Created by Marko Kramar on 26.01.2021..
//

import SwiftUI
import WebKit

struct EvolvaCloudAppWebView: View {
    var url: String
    var requestBody: Data?
    
    @State private var webView = WebView()
    
    var body: some View {
        VStack {
            HStack {
                Button("< Back") {
                    self.webView.wkWebView.goBack()
                }
                Spacer()
            }
            .padding(.leading, 20)
            .padding(.top, 10)
            
            self.webView
                .edgesIgnoringSafeArea(.all)
                .navigationBarHidden(true)
        }
        .onAppear {
            guard let url = URL(string: self.url) else {
                print("Wrong URL")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpBody = requestBody
            self.webView.wkWebView.load(request)
        }
    }
}

struct WebView: UIViewRepresentable {
    var wkWebView = WKWebView()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func makeUIView(context: Context) -> WKWebView {
        wkWebView.uiDelegate = context.coordinator
        wkWebView.allowsBackForwardNavigationGestures = true
        return wkWebView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

class Coordinator: NSObject, WKUIDelegate {
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if let frame = navigationAction.targetFrame, frame.isMainFrame {
            return nil
        }
        webView.load(navigationAction.request)
        return nil
    }
}

