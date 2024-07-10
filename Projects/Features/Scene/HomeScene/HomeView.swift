//
//  HomeView.swift
//  Home
//
//  Created by 김영균 on 6/13/24.
//  Copyright © 2024 mashup.dorabangs. All rights reserved.
//

import ACarousel
import ComposableArchitecture
import DesignSystemKit
import SwiftUI

public struct HomeView: View {
    @Perception.Bindable private var store: StoreOf<Home>
    @Environment(\.scenePhase) var scenePhase

    public init(store: StoreOf<Home>) {
        self.store = store
    }

    public var body: some View {
        WithPerceptionTracking {
            VStack(spacing: 0) {
                LKTopLogoBar {
                    store.send(.addLinkButtonTapped)
                }

                LKTopScrollBar(
                    titleList: ["전체", "즐겨찾기", "나중에 읽을 링크", "나즁에 또 읽을 링크", "영원히 안 볼 링크"],
                    selectedIndex: 0
                )

                ScrollView {
                    ACarousel(
                        store.bannerList,
                        id: \.self,
                        index: $store.bannerIndex.sending(\.updateBannerPageIndicator),
                        spacing: 0,
                        headspace: 0,
                        sidesScaling: 1,
                        isWrap: false,
                        autoScroll: .active(TimeInterval(3))
                    ) { item in
                        LKBannerView(
                            prefix: item.prefix,
                            count: item.count,
                            buttonTitle: item.buttonTitle,
                            action: {
                                store.send(.bannerButtonTapped(item.bannerType))
                            }
                        )
                    }
                    .frame(height: 340)

                    if store.bannerList.count > 1 {
                        HomeBannerPageControlView(
                            bannerList: store.bannerList,
                            selectedBanner: store.selectedBannerType
                        )
                    }

                    LazyVStack(spacing: 0) {
                        Section {
                            LazyVStack(spacing: 0) {
                                ForEach(store.cards.indices, id: \.self) { index in
                                    LKCard(
                                        title: "에스파 '슈퍼노바', 올해 멜론 주간 차트 최장 1위…'쇠맛' 흥행 질주에스파 '슈퍼노바', 올해 멜론 주간 차트 최장 1위…'쇠맛' 흥행 질주 에스파 '슈퍼노바', 올해 멜론 주간 차트 최장 1위…'쇠맛' 흥행 질주",
                                        description: "사건은 다가와 아 오 에 거세게 커져가 아 오 에 That tick, that tick, tick bomb That tick, that tick, tick bomb 사건은 다가와 아 오 에 거세게 커져가 아 오 에 That tick, that tick, tick bomb That tick, that tick, tick bomb",
                                        tags: ["# 에스파", "# SM", "# 오에이옹에이옹"],
                                        category: "Category",
                                        timeSince: "1일 전",
                                        bookMarkAction: { store.send(.bookMarkButtonTapped(index)) },
                                        showModalAction: { store.send(.showModalButtonTapped(index), animation: .easeInOut) }
                                    )
                                    .onAppear {
                                        if index % 9 == 0 {
                                            store.send(.fetchData)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding(.vertical, 12)
            .navigationBarHidden(true)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                store.send(.onAppear)
                checkClipboardURL()
            }
            .onChange(of: scenePhase) { newValue in
                guard newValue == .active else { return }
                checkClipboardURL()
            }
        }
    }

    private func checkClipboardURL() {
        if let url = UIPasteboard.general.url {
            store.send(.clipboardURLChanged(url))
            UIPasteboard.general.url = nil
        }
    }
}
