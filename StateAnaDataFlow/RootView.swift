//
//  RootView.swift
//  StateAnaDataFlow
//
//  Created by Alexey Efimov on 14.06.2023.
//

import SwiftUI

struct RootView: View {
    @StateObject private var user = UserSettings()
    
    private let userInfo = StorageManager.shared.fetchUser()
    
    var body: some View {
        Group {
            if userInfo.isSigned {
                ContentView()
            } else {
                LoginView()
            }
        }
        .environmentObject(user)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
