//
//  TrialBackgroundView.swift
//  Project-Beatcode
//
//  Created by Gina Saviano on 07/07/25.
//

///here I'll try to figure out how to put a custom background with NavigationStack and ScrollView

import SwiftUI

struct TrialBackgroundView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(.systemGray2).opacity(0.7),
                        Color(.systemGray6).opacity(0.3)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
//                Color.green
                .ignoresSafeArea()
                
                ScrollView {
                    Text("Hello, World!")
                        .font(.largeTitle)
                }
                .padding(.top, 50)
            }
        }
    }
}

#Preview {
    TrialBackgroundView()
}
