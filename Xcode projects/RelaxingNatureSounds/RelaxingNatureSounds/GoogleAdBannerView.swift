//
//  GoogleAd.swift
//  RelaxingNatureSounds
//
//  Created by Marko Kramar on 31/08/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import SwiftUI
import GoogleMobileAds

private struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

private struct GoogleAdBannerRepresentable: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<GoogleAdBannerRepresentable>) -> GADBannerView {
        let banner = GADBannerView(adSize: kGADAdSizeBanner)
        // banner.adUnitID = "ca-app-pub-2155607165715644/1922843841" // Real banner ID
        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716" // Sample banner ID
        banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
        banner.load(GADRequest())
        return banner
    }
    
    func updateUIView(_ uiView: GADBannerView, context: UIViewRepresentableContext<GoogleAdBannerRepresentable>) {
        
    }
    
}

struct GoogleAdBannerView: View {
    var body: some View {
        Group {
            if UIApplication.shared.windows.first!.safeAreaInsets.bottom > 0 {
                googleBannerWithBackground()
            } else {
                googleBanner()
            }
        }
    }
    
    func googleBanner() -> some View {
        GoogleAdBannerRepresentable()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
    }
    
    func googleBannerWithBackground() -> some View {
        VStack {
            googleBanner()
            VisualEffectView(effect: UIBlurEffect(style: .dark)).padding(0).edgesIgnoringSafeArea(.all)
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: (50 + UIApplication.shared.windows.first!.safeAreaInsets.bottom))
        .padding(0)
    }
}
