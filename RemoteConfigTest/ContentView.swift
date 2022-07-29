//
//  ContentView.swift
//  RemoteConfigTest
//
//  Created by Hidetaka Matsumoto on 2022/07/27.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var remoteConfigState = RemoteConfigState()

    var body: some View {
        ZStack {
            if remoteConfigState.isUnderMaintenance {
                ZStack {
                    Rectangle()
                        .fill(.yellow)
                        .ignoresSafeArea()
                    Text(remoteConfigState.maintenanceMessage)
                }
            } else {
                Text("Status is normal.")
            }
            
            if remoteConfigState.isFetchAndActivating {
                ZStack {
                    Rectangle()
                        .fill(.gray.opacity(0.8))
                        .ignoresSafeArea()
                    Text("Loading...")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
