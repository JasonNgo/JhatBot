//
//  SwiftUIView.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-05.
//

import Shared
import SwiftUI

public struct AppAlert: Sendable {

    // MARK: - Properties

    public private(set) var title: String?
    public private(set) var subtitle: String?
    public private(set) var buttons: @Sendable () -> AnyView

    // MARK: - Initializers

    public init(
        title: String? = nil,
        subtitle: String? = nil,
        buttons: @escaping @Sendable () -> AnyView
    ) {
        self.title = title
        self.subtitle = subtitle
        self.buttons = buttons
    }

}

public enum AppAlertType {
    case alert
    case confirmationDialog
}

extension View {

    @ViewBuilder
    public func showCustomAlert(type: AppAlertType = .alert, alert: Binding<AppAlert?>) -> some View {
        switch type {
        case .alert:
            self.alert(
                alert.wrappedValue?.title ?? "",
                isPresented: Binding(ifNotNil: alert),
                actions: {
                    alert.wrappedValue?.buttons()
                },

                message: {
                    if let subtitle = alert.wrappedValue?.subtitle {
                        Text(subtitle)
                    }
                })

        case .confirmationDialog:
            self.confirmationDialog(
                alert.wrappedValue?.title ?? "",
                isPresented: Binding(ifNotNil: alert),
                actions: {
                    alert.wrappedValue?.buttons()
                },
                message: {
                    if let subtitle = alert.wrappedValue?.subtitle {
                        Text(subtitle)
                    }
                })
        }
    }

}
