//
//  SignUpOrSignInView.swift
//  LearnTerms
//
//  Created by Justin Dang on 2/7/25.
//


import SwiftUI

struct SignUpOrSignInView: View {
  @State private var isSignUp = true

  var body: some View {
    ScrollView {
      if isSignUp {
        SignUpView()
      } else {
        SignInView()
      }

      Button {
        isSignUp.toggle()
      } label: {
        if isSignUp {
          Text("Already have an account? Sign In")
        } else {
          Text("Don't have an account? Sign Up")
        }
      }
      .padding()
    }
  }
}