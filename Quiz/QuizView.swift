//
//  QuizView.swift
//  LearnTerms
//
//  Created by Justin Dang on 2/12/25.
//

import SwiftUI

import SwiftUI

struct QuizView: View {
    let chapter: Chapter
    
    var body: some View {
        // Here we embed the QuestionsListView for the selected chapter.
        // Assuming that QuestionsListView takes an Int (the chapter number).
        QuestionsListView(chapter: chapter.chapter)
    }
}
