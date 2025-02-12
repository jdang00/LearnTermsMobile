//
//  DashboardView.swift
//  LearnTerms
//
//  Created by Justin Dang on 2/7/25.
//

import SwiftUI

struct DashboardView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    let chapters: [Chapter]
    let user: MockUser
    let enabledThreshold: Int
    
    var body: some View {
        if horizontalSizeClass == .compact {
            NavigationView {
                dashboardList
                    .navigationTitle("Dashboard")
            }
        } else {
            NavigationSplitView {
                Text("Menu")
                    .frame(maxWidth: 200)
                    .navigationTitle("Menu")
            } detail: {
                dashboardList
                    .navigationTitle("Dashboard")
            }
        }
    }
    
    private var dashboardList: some View {
        List(chapters) { chapter in
            NavigationLink(destination: QuizView(chapter: chapter)) {
                HStack {
                    Text(chapter.emoji)
                    VStack(alignment: .leading) {
                        Text(chapter.name)
                            .font(.headline)
                        Text(chapter.desc)
                            .font(.subheadline)
                    }
                }
                .padding(.vertical, 4)
            }
        }
    }
}
