//
//  RegistrationView.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-05.
//

import SwiftUI

public struct RegistrationView: View {
    public init() {

    }
    
    public var body: some View {
        VStack(spacing: 24) {
            VStack(alignment: .leading) {
                Text("Create Account")
                    .font(.largeTitle)
                    .fontWeight(.semibold)

                Text("Don't lose your data! Connect to a SSO provider to save your account.")
                    .font(.body)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()
        }
        .padding(16)
        .padding(.top, 24)
    }
}

#Preview {
    RegistrationView()
}
