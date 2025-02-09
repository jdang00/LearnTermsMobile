//
//  ChapterCardView.swift
//  LearnTerms
//
//  Created by Justin Dang on 2/7/25.
//

import SwiftUI

struct ChapterCardView: View {
    let chapter: Chapter
    let index: Int
    let isEnabled: Bool
    
    init(chapter: Chapter, index: Int, enabledThreshold: Int) {
        self.chapter = chapter
        self.index = index
        self.isEnabled = index < enabledThreshold
    }
    
    var body: some View {
        HStack {
            HStack(spacing: 20) {
                Text("\(index + 1)")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.gray)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(chapter.emoji)
                        Text(chapter.name)
                            .font(.headline)
                    }
                    
                    Text(chapter.desc)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .opacity(isEnabled ? 1 : 0.5)
    }
}
