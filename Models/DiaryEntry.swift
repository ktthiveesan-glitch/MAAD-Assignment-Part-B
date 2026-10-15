import Foundation
import SwiftData

// ============================================
// DiaryEntry.swift
// PURPOSE: Data model for child diary entries
// ROLE: Keyworker
// GDPR NOTE: Contains child personal data
//            stored locally on device only
//            under UK GDPR Article 6(1)(b)
// ============================================

@Model
class DiaryEntry {
    var id: UUID
    var childName: String
    var activityType: String
    var entryDescription: String
    var mood: String
    var date: Date
    
    init(
        childName: String,
        activityType: String,
        entryDescription: String,
        mood: String
    ) {
        self.id = UUID()
        self.childName = childName
        self.activityType = activityType
        self.entryDescription = entryDescription
        self.mood = mood
        self.date = Date()
    }
}
