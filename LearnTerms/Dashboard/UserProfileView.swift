//
//  UserProfileView.swift
//  LearnTerms
//
//  Created by Justin Dang on 2/7/25.
//
import SwiftUI

struct UserProfileView: View {
    let user: MockUser
    
    var body: some View {
        VStack {
            Image(systemName: user.imageUrl)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .padding(4)
                .overlay(
                    Circle()
                        .stroke(Color.blue, lineWidth: 2)
                )
            
            Text("Hi, \(user.firstName)")
                .font(.title)
                .fontWeight(.semibold)
        }
        .padding(.top)
    }
}
