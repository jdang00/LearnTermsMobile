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
        // Use a single NavigationView on iPhone (compact)...
        if horizontalSizeClass == .compact {
            NavigationView {
                dashboardList
                    .navigationTitle("Dashboard")
            }
        } else {
            // ...and a NavigationSplitView on iPad (regular).
            NavigationSplitView {
                // Sidebar content (customize as needed)
                Text("Menu")
                    .frame(maxWidth: 200)
                    .navigationTitle("Menu")
            } detail: {
                dashboardList
                    .navigationTitle("Dashboard")
            }
        }
    }
    
    // A reusable list view that displays the chapters.
    private var dashboardList: some View {
        List(chapters) { chapter in
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
