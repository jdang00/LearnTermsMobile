//
//  SignUpView.swift
//  LearnTerms
//
//  Created by Justin Dang on 2/7/25.
//


import SwiftUI
import Clerk

struct SignUpView: View {
  @State private var email = ""
  @State private var password = ""
  @State private var code = ""
  @State private var isVerifying = false
  @State private var isLoading = false
  @State private var errorMessage: String?
  @FocusState private var emailFieldFocused: Bool
  @FocusState private var passwordFieldFocused: Bool
  @FocusState private var codeFieldFocused: Bool

  var body: some View {
    ScrollView {
      VStack {
        Spacer()
          .frame(height: 50)

        Text("Create Account")
          .font(.largeTitle)
          .fontWeight(.bold)
          .padding(.bottom)

        Text("Sign up to get started")
          .font(.subheadline)
          .foregroundColor(.gray)
          .padding(.bottom, 30)

        if isVerifying {
          VStack(spacing: 20) {
            TextField("Verification Code", text: $code)
              .padding()
              .background(Color(.secondarySystemBackground))
              .cornerRadius(10)
              .keyboardType(.numberPad)
              .focused($codeFieldFocused)
          }
          .padding(.horizontal)
        } else {
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
        }

        if let errorMessage = errorMessage {
          Text(errorMessage)
            .foregroundColor(.red)
            .padding(.top, 10)
        }

        Button(action: {
          Task {
            isLoading = true
            if isVerifying {
              await verify(code: code)
            } else {
              await signUp(email: email, password: password)
            }
            isLoading = false
          }
        }) {
          Text(isVerifying ? "Verify Code" : "Sign Up")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.theme.primary)
            .cornerRadius(10)
        }
        .padding()
        .disabled(isLoading)
        .opacity(isLoading ? 0.7 : 1.0)

        Spacer()
      }
      .padding()
      .frame(maxWidth: .infinity)
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
    )
  }
}

extension SignUpView {
  func signUp(email: String, password: String) async {
    do {
      let signUp = try await SignUp.create(
        strategy: .standard(emailAddress: email, password: password)
      )

      try await signUp.prepareVerification(strategy: .emailCode)

      isVerifying = true
      errorMessage = nil // Clear any previous errors
    } catch {
      dump(error)
      errorMessage = error.localizedDescription
    }
  }

  func verify(code: String) async {
    do {
      guard let signUp = Clerk.shared.client?.signUp else {
        isVerifying = false
        errorMessage = "Sign-up session expired."
        return
      }

      try await signUp.attemptVerification(.emailCode(code: code))
      // Handle successful verification (e.g., navigate to the main app)
    } catch {
      dump(error)
      errorMessage = error.localizedDescription
    }
  }
}

