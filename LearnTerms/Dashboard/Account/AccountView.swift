//
//  AccountView.swift
//  LearnTerms
//
//  Created by Justin Dang on 2/7/25.
//

import SwiftUI
import Clerk

struct AccountView: View {
    @Environment(Clerk.self) private var clerk

    var body: some View {
        NavigationView {
            VStack {
                if let user = clerk.user {
                    // Convert the imageURL string to a URL
                    if let url = URL(string: user.imageUrl) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .padding()
                        } placeholder: {
                            ProgressView() // Placeholder while loading
                        }
                    } else {
                        // Display a default image if imageURL is nil or the URL conversion fails
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                            .padding()
                    }

                    // User Greeting
                    Text("Hello, \(user.firstName ?? "user")")
                        .font(.title)
                        .padding()

                    // Display additional user information
                    if let email = user.primaryEmailAddress?.emailAddress {
                        Text("Email: \(email)")
                            .font(.subheadline)
                            .padding(.bottom)
                    }

                    // Sign Out Button
                    Button("Sign Out") {
                        Task {
                            try? await clerk.signOut()
                        }
                    }
                    .padding().foregroundStyle(Color.theme.secondary)
                    
                    
                    // Additional options (e.g., Edit Profile)
                    NavigationLink(destination: EditProfileView()) {
                        Text("Edit Profile")
                            .padding()
                            .foregroundColor(.blue)
                    }
                    .padding(.top)
                } else {
                    // Show Sign Up or Sign In View if no user is signed in
                    SignUpOrSignInView()
                }
            }
            .navigationTitle("Account")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// Placeholder for EditProfileView
struct EditProfileView: View {
    var body: some View {
        Text("Edit Profile View")
            .font(.largeTitle)
            .padding()
    }
}
