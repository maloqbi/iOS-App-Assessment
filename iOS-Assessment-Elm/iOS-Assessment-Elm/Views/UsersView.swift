//
//  UsersView.swift
//  iOS-Assessment-Elm
//
//  Created by Mohammed on 18/03/1446 AH.
//

import SwiftUI

struct UsersView: View {
    @StateObject private var viewModel = UsersViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading users...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    
                    List(Array(Set(viewModel.users))) { user in
                        HStack {
                            AsyncImage(url: URL(string: user.profileImageUrl))
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            Text(user.name)
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchUsers()
            }
            .navigationTitle("Users")
        }
    }
}
