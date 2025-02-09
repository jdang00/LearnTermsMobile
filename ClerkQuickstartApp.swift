//
//  ClerkQuickstartApp.swift
//  LearnTerms
//
//  Created by Justin Dang on 2/7/25.
//


import SwiftUI
import Clerk

@main
struct ClerkQuickstartApp: App {
  private var clerk = Clerk.shared

  var body: some Scene {
    WindowGroup {
      ZStack {
        if clerk.isLoaded {
          ContentView()
        } else {
          ProgressView()
        }
      }
      .environment(clerk)
      .task {
        clerk.configure(publishableKey: "pk_test_Y2FsbS10aHJ1c2gtMTQuY2xlcmsuYWNjb3VudHMuZGV2JA")
        try? await clerk.load()
      }
    }
  }
}

