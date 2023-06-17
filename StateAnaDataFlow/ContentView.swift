//
//  ContentView.swift
//  StateAnaDataFlow
//
//  Created by Alexey Efimov on 14.06.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var timer = TimeCounter()
    @EnvironmentObject private var user: UserSettings
    private let userInfo = StorageManager.shared.fetchUser()
    
    var body: some View {
        VStack {
            Text("Hi, \(userInfo.name)!")
                .font(.largeTitle)
                .padding(.top, 100)
            Text(timer.counter.formatted())
                .font(.largeTitle)
                .padding(.top, 100)
            Spacer()
            ButtonView(timer: timer)
            Spacer()
            LogOutButtonView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserSettings())
    }
}

struct ButtonView: View {
    @ObservedObject var timer: TimeCounter
    
    var body: some View {
        Button(action: timer.startTimer) {
            Text(timer.buttonTitle)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .frame(width: 200, height: 60)
        .background(.red)
        .cornerRadius(20)
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.black, lineWidth: 4)
        }
    }
}

struct LogOutButtonView: View {
    @EnvironmentObject private var user: UserSettings
    var body: some View {
        Button("LogOut") {
            StorageManager.shared.deleteUser()
            user.isLoggedIn.toggle()
        }
        .frame(width: 200, height: 60)
        .font(.title)
        .fontWeight(.bold)
        .background(.blue)
        .foregroundColor(.white)
        .cornerRadius(20)
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.black, lineWidth: 4)
        }
    }
}
