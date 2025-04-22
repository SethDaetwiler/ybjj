//
//  File.swift
//  ybjj
//
//  Created by Seth Daetwiler on 4/21/25.
//

import Foundation
import SwiftData

@Model
class DrillEntry {
    var id: UUID
    var title: String              // User-defined or suggested name
    var notes: String?             // Optional free-form notes
    var category: DrillCategory    // Enum: technique, concept, chain, session
    var tags: [String]             // “guard”, “side control”, “passing”
    var duration: TimeInterval?    // Optional (in seconds)
    var createdAt: Date            // When it was logged
    var isFavorite: Bool           // Optional for flagging key drills

    init(
        title: String,
        notes: String? = nil,
        category: DrillCategory,
        tags: [String] = [],
        duration: TimeInterval? = nil,
        createdAt: Date = .now,
        isFavorite: Bool = false
    ) {
        self.id = UUID()
        self.title = title
        self.notes = notes
        self.category = category
        self.tags = tags
        self.duration = duration
        self.createdAt = createdAt
        self.isFavorite = isFavorite
    }
}

enum DrillCategory: String, Codable, CaseIterable {
    case technique
    case concept
    case chain
    case session
}
