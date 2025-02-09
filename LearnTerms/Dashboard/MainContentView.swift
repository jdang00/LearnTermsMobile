//
//  MainContentView.swift
//  LearnTerms
//
//  Created by Justin Dang on 2/7/25.
//

import SwiftUI

struct MainContentView: View {
    let chapters: [Chapter]
    let enabledThreshold: Int
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(Array(chapters.enumerated()), id: \.element.id) { index, chapter in
                    ChapterCardView(
                        chapter: chapter,
                        index: index,
                        enabledThreshold: enabledThreshold
                    )
                }
            }
            .padding()
        }
        .background(Color(.secondarySystemBackground))
    }
}
