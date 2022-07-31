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
                Text(remoteConfigState.title)
                    .font(.title)
                AsyncImage(
                    url: remoteConfigState.imageUrl,
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
                Text(remoteConfigState.message)
                    .font(.subheadline)
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
