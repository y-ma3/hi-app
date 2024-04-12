//
//  SettingView.swift
//  Hi
//
//  Created by Yuma on 2024/04/09.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var router: NavigationRouter
    @EnvironmentObject var service: Auth0Service
    
    var body: some View {
        VStack {
            VStack {
                Text("名前")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 5)
                Text("ユーザーID：〇〇〇〇〇〇")
                    .font(.headline)
                    .padding(.bottom)
            }
            .padding()
            
            VStack {
                HStack {
                    Text("設定の確認・変更")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .bold()
                        .padding(.leading, 25)
                    Spacer()
                }
                let settingLabels = ["名前", "ユーザーID", "起きる時間", "曜日"]
                ForEach(0 ..< settingLabels.count, id: \.self) { index in
                    SettingCard(label: "\(settingLabels[index])", action: {
                        router.navigateToView(destination: router.settingNavigationPath[index])
                    })
                }
            }
            .padding(.bottom)
            
            VStack {
                HStack {
                    Text("フレンド")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .bold()
                        .padding(.leading, 25)
                    Spacer()
                }
                let friendLabels = ["フレンド一覧"]
                ForEach(0 ..< friendLabels.count, id: \.self) { index in
                    SettingCard(label: "\(friendLabels[index])", action: {
                        print("\(friendLabels[index])画面へ")
                    })
                }
                SettingExclamationMarkCard(label: "フレンド承認", isShowMark: true, action: {
                    print("フレンド承認画面へ")
                })
            }
            .padding(.bottom)
            
            Spacer()
            LogoutButton(action: {
                service.logout()
            })
        }
        .onChange(of: service.isAuthenticated) {
            if !service.isAuthenticated {
                router.navigateToView(destination: .login)
            }
        }
    }
}

// 以降、各種設定画面への遷移後のビュー
struct SettingNameView: View {
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        AccountSettingName(nextButtonLabel: "変更する", isShowBackButton: true, action: {
            router.backPage()
        })
        .navigationBarHidden(true)
    }
}

struct SettingUserIDView: View {
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        AccountSettingUserID(nextButtonLabel: "変更する", action: {
            router.backPage()
        })
        .navigationBarHidden(true)
    }
}

struct SettingWakeUpTimeView: View {
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        AccountSettingWakeUpTime(nextButtonLabel: "変更する", action: {
            router.backPage()
        })
        .navigationBarHidden(true)
    }
}

struct SettingDayOfWeekView: View {
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        AccountSettingDayOfWeek(nextButtonLabel: "変更する", action: {
            router.backPage()
        })
        .navigationBarHidden(true)
    }
}

#Preview {
    SettingView()
}
