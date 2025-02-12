//
//  QuestionData.swift
//  LearnTerms
//
//  Created by Justin Dang on 2/12/25.
//

import Foundation

struct QuestionData: Decodable {
    let options: [String]
    let question: String
    let explanation: String
    let correct_answers: [String]
}
