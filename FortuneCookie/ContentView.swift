//
//  ContentView.swift
//  FortuneCookie
//
//  Created by 임채윤 on 1/21/24.
//

import SwiftUI

struct ContentView: View {
    @State private var messageText = ""
    
    var randomMessage: String {
        let fortuneMessages = ModelData().fortuneCookie.messages
        let range = 0..<fortuneMessages.count
        
        let randomMessage = fortuneMessages[Int.random(in: range)]
        
        return randomMessage
    }
    
    var body: some View {
        VStack {
            Text(messageText)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()
            
            Button("포츈 쿠키 열기") {
                messageText = randomMessage
            }
        }
        
    }
}

#Preview {
    ContentView()
}
