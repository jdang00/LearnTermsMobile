//
//  SignInView.swift
//  LearnTerms
//
//  Created by Justin Dang on 2/7/25.
//

import SwiftUI
import Clerk

struct SignInView: View {
  @State private var email = ""
  @State private var password = ""
  @State private var isLoading = false
  @State private var errorMessage: String?
  @FocusState private var emailFieldFocused: Bool
  @FocusState private var passwordFieldFocused: Bool

  var body: some View {
    ScrollView {
      VStack {
        Spacer()
          .frame(height: 50) // Add some space at the top

        Text("Welcome Back")
          .font(.largeTitle)
          .fontWeight(.bold)
          .padding(.bottom)

        Text("Sign in to continue")
          .font(.subheadline)
          .foregroundColor(.gray)
          .padding(.bottom, 30)

        VStack(spacing: 20) {
          TextField("Email", text: $email)
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
            .autocapitalization(.none)
            .keyboardType(.emailAddress)
            .focused($emailFieldFocused)

          SecureField("Password", text: $password)
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
            .focused($passwordFieldFocused)
        }
        .padding(.horizontal)

        if let errorMessage = errorMessage {
          Text(errorMessage)
            .foregroundColor(.red)
            .padding(.top, 10)
        }

        // Regular Email/Password Sign In Button
        Button(action: {
          Task {
            isLoading = true
            await submit(email: email, password: password)
            isLoading = false
          }
        }) {
          Text("Sign In")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.theme.primary)
            .cornerRadius(10)
        }
        .padding(.horizontal)
        .disabled(isLoading)
        .opacity(isLoading ? 0.7 : 1.0)

        // Google Sign In Button
        Button(action: {
          Task {
            isLoading = true
            do {
              try await SignIn.create(strategy: .oauth(provider: .google))
            } catch {
              dump(error)
              errorMessage = error.localizedDescription
            }
            isLoading = false
          }
        }) {
          HStack {
            // Use the iconImageUrl function from OAuthProvider to load the Google icon
            if let iconUrl = OAuthProvider.google.iconImageUrl(darkMode: false) {
              AsyncImage(url: iconUrl) { image in
                image
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 20, height: 20)
              } placeholder: {
                ProgressView()
                  .frame(width: 20, height: 20)
              }
            } else {
              Image(systemName: "globe")
                .frame(width: 20, height: 20)
            }
            Text("Sign in with Google")
          }
          .font(.headline)
          .foregroundColor(Color(.black))
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color(.systemGray6))
          .cornerRadius(10)
        }
        .padding(.horizontal)
        .disabled(isLoading)
        .opacity(isLoading ? 0.7 : 1.0)

        Spacer() // Push content to the top

      }
      .padding()
      .frame(maxWidth: .infinity) // Ensure VStack takes full width
    }
    .alert(
      isPresented: Binding<Bool>(
        get: { errorMessage != nil },
        set: { newValue in
          if !newValue {
            errorMessage = nil
          }
        }
      ),
      content: {
        Alert(
          title: Text("Error"),
          message: Text(errorMessage ?? "Unknown error"),
          dismissButton: .default(Text("OK"))
        )
      }
    )
    .overlay(
      isLoading ? ProgressView().scaleEffect(2) : nil
    ) // Show loading indicator as overlay
  }
}

extension SignInView {
  func submit(email: String, password: String) async {
    do {
      try await SignIn.create(
        strategy: .identifier(email, password: password)
      )
    } catch {
      dump(error)
      errorMessage = error.localizedDescription
    }
  }
}



