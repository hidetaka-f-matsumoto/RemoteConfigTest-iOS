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
            VStack(alignment: .leading) {
                Text("Your Instance ID: \(CurrentUser.shared.instanceId)")
                    .font(.subheadline)
                    .padding()
                Text(remoteConfigState.pickupArticle.title)
                    .font(.title)
                    .padding(.horizontal)
                AsyncImage(
                    url: URL(string: remoteConfigState.pickupArticle.imageUrl),
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(
                                maxWidth: UIScreen.main.bounds.width,
                                maxHeight: 240)
                    },
                    placeholder: {
                        ProgressView()
                    })
                Text(remoteConfigState.pickupArticle.message)
                    .font(.subheadline)
                    .padding(.horizontal)
            }
            .padding()

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
