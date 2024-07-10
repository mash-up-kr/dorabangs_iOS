//
//  LKBannerView.swift
//  DesignSystemKit
//
//  Created by 안상희 on 7/5/24.
//  Copyright © 2024 mashup.dorabangs. All rights reserved.
//

import SwiftUI

public struct LKBannerView: View {
    private let prefix: String
    private let count: Int?
    private let buttonTitle: String
    private let action: () -> Void

    public init(
        prefix: String,
        count: Int?,
        buttonTitle: String,
        action: @escaping () -> Void
    ) {
        self.prefix = prefix
        self.count = count
        self.buttonTitle = buttonTitle
        self.action = action
    }

    public var body: some View {
        VStack(spacing: 0) {
            DesignSystemKitAsset.Icons.icStar.swiftUIImage
                .frame(width: 250, height: 212)

            HomeBannerMessageView(
                prefix: prefix,
                count: count
            )

            Spacer()
                .frame(height: 12)

            BannerButton(title: buttonTitle, action: action)

            Spacer()
                .frame(height: 24)
        }
        .frame(width: 390, height: 340)
        .background(DesignSystemKitAsset.Colors.gradient6)
        .background(.white.opacity(0.5))
    }
}

private struct HomeBannerMessageView: View {
    private let prefix: String
    private let count: Int?

    fileprivate init(prefix: String, count: Int?) {
        self.prefix = prefix
        self.count = count
    }

    fileprivate var body: some View {
        VStack(spacing: 0) {
            Text(prefix)
                .multilineTextAlignment(.center)
                .font(weight: .heavy, semantic: .subtitle2)
                .foregroundStyle(DesignSystemKitAsset.Colors.g8.swiftUIColor)

            if let count, count > 0 {
                HStack(spacing: 0) {
                    Text("\(count)개 ")
                        .font(weight: .heavy, semantic: .subtitle2)
                        .foregroundStyle(DesignSystemKitAsset.Colors.primary.swiftUIColor)

                    Text("있어요")
                        .font(weight: .heavy, semantic: .subtitle2)
                        .foregroundStyle(DesignSystemKitAsset.Colors.g8.swiftUIColor)
                }
            }
        }
    }
}

#Preview {
    LKBannerView(prefix: "AI로 분류한 링크가", count: 2, buttonTitle: "저장하기", action: {})
}
