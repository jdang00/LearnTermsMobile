//
//  SidebarView.swift
//  LearnTerms
//
//  Created by Justin Dang on 2/7/25.
//

import SwiftUI

struct SidebarView: View {
    let user: MockUser
    
    var body: some View {
        VStack {
            UserProfileView(user: user)
            Spacer()
        }
        .frame(width: 300)
        .padding()
        .background(Color(.systemGray6))
        .border(Color.gray.opacity(0.3), width: 0.5)
    }
}
