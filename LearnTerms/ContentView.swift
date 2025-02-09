//
//  ContentView.swift
//  LearnTerms
//
//  Created by Justin Dang on 2/7/25.
//

import SwiftUI
import Clerk


struct ContentView: View {
    @Environment(Clerk.self) private var clerk
    
    
    var body: some View {
        if let user = clerk.user{
            MainTabView()

        }else{
            SignUpOrSignInView()
        }
    }
}

#Preview {
    ContentView()
}
