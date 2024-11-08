//
//  SettingsView.swift
//  Meraki
//
//  Created by Christos Eteoglou on 2024-11-08.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        
        VStack (alignment: .leading, spacing: 20) {
            
            Text("Settings")
                .font(.largeTitle)
                .bold()
            
            List {
                
                // Rate the app
                let reviewUrl = URL(string: "https://apps.apple.com/app/idxxxxxxxxxx?actions=write-review")!
                
                Link(destination: reviewUrl, label: {
                    HStack {
                        Image(systemName: "star.bubble")
                        Text("Rate the app")
                    }
                })
                
                // Recommend the app
                let shareUrl = URL(string: "https://apps.apple.com/app/idxxxxxxxxxx")!
                
                ShareLink(item: shareUrl) {
                    HStack {
                        Image(systemName: "arrowshape.turn.up.right")
                        Text("Recommend the app")
                    }
                }
                
                // Contact
                Button {
                    // Compose email
                    let mailUrl = createMailUrl()
                    
                    if let mailUrl = mailUrl,
                       UIApplication.shared.canOpenURL(mailUrl) {
                        UIApplication.shared.open(mailUrl)
                    } else {
                        print("Couldn't open mail app")
                    }
                } label: {
                    HStack {
                        Image(systemName: "quote.bubble")
                        Text("Submit Feedback")
                    }
                }
                
                // Privacy Policy
                let privacyUrl = URL(string: "https://christoseteoglou.com/privacy-policy/")!
                
                Link(destination: privacyUrl, label: {
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Privacy Policy")
                    }
                })
                
            }
            .listRowSeparator(.hidden)
            .listStyle(.plain)
            .tint(.black)
        }
    }
    
    func createMailUrl() -> URL? {
        
        var mailUrlComponents = URLComponents()
        mailUrlComponents.scheme = "mailto"
        mailUrlComponents.path = "feedback@example.com"
        mailUrlComponents.queryItems = [
            URLQueryItem(name: "subject", value: "Feedback"),
        ]
        
        return mailUrlComponents.url
        
    }
}

#Preview {
    SettingsView()
}
