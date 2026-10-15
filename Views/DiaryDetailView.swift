import SwiftUI

// ============================================
// DiaryDetailView.swift
// PURPOSE: Shows full diary entry details
//          when a card is tapped
// ROLE: Keyworker  
// GDPR NOTE: Full child diary entry shown
//            only to authorised keyworker
//            under data minimisation rules
// ============================================

struct DiaryDetailView: View {
    
    let entry: DiaryEntry
    
    // Dismisses this detail view
    @Environment(\.dismiss) var dismiss
    
    // Returns emoji based on mood
    var moodEmoji: String {
        switch entry.mood {
        case "Happy": return "😊"
        case "Excited": return "🤩"
        case "Tired": return "😴"
        case "Sad": return "😢"
        case "Poorly": return "🤒"
        default: return "😊"
        }
    }
    
    // Formats date for display
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        return formatter.string(from: entry.date)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: - Sheet Header
            HStack {
                Text("Diary Entry")
                    .font(.headline)
                    .foregroundStyle(NurseryTheme.textSecondary)
                Spacer()
                Text(entry.mood)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(NurseryTheme.brandGreen)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(NurseryTheme.brandGreenLight, in: Capsule())
            }
            .padding(.horizontal, 28)
            .padding(.top, 24)
            .padding(.bottom, 16)
            
            Divider()
            
            ScrollView {
                VStack(spacing: 28) {
                    
                    Text(moodEmoji)
                        .font(.system(size: 64))
                        .padding(.top, 8)
                    
                    Text(entry.childName)
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundStyle(NurseryTheme.textPrimary)
                        .multilineTextAlignment(.center)
                    
                    Text(entry.activityType)
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundStyle(NurseryTheme.brandGreen)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Label("Notes", systemImage: "note.text")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(NurseryTheme.brandGreen)
                        Text(entry.entryDescription)
                            .font(.body)
                            .foregroundStyle(NurseryTheme.textPrimary)
                            .lineSpacing(5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(20)
                    .background(
                        NurseryTheme.cardBackground,
                        in: RoundedRectangle(cornerRadius: 16)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .strokeBorder(NurseryTheme.brandGreen.opacity(0.2), lineWidth: 1)
                    )
                    
                    Label(formattedDate, systemImage: "calendar")
                        .font(.subheadline)
                        .foregroundStyle(NurseryTheme.textSecondary)
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 24)
            }
            
            Divider()
            
            Button(action: { dismiss() }) {
                Text("Close")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(NurseryPrimaryButtonStyle())
            .padding(24)
        }
        .frame(minWidth: 420, minHeight: 520)
        .background(NurseryTheme.panelBackground)
    }
}
