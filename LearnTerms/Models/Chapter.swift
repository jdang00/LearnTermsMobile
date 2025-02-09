//
//  Chapter.swift
//  LearnTerms
//
//  Created by Justin Dang on 2/7/25.
//


import Foundation

struct Chapter:  Decodable, Identifiable  {
    let name: String
    let desc: String
    let numprobs: Int
    let chapter: Int;
    let emoji: String
    
    var id: Int { chapter }


}

