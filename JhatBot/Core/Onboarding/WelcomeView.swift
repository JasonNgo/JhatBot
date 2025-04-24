//
//  WelcomeView.swift
//  JhatBot
//
//  Created by Jason Ngo on 2025-04-22.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome")
                    .frame(maxHeight: .infinity)

                NavigationLink {
                    OnboardingCompletedView()
                } label: {
                    Text("Get Started")
                        .withCallToActionStyle()
                }
            }
            .padding()
        }
    }
}

#Preview {
    WelcomeView()
}
