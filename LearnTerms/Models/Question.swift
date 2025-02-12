//
//  Question.swift
//  LearnTerms
//
//  Created by Justin Dang on 2/12/25.
//

import Foundation

struct Question: Decodable, Identifiable {
    let id: String
    let question_data: QuestionData
}
