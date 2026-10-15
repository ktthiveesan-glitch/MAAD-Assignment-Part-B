import SwiftUI

// ============================================
// DiaryCardView.swift
// PURPOSE: Single floating diary card shown
//          in 3D spatial environment
// ROLE: Keyworker
// GDPR NOTE: Shows individual child diary
//            data in spatial view
// ============================================

struct DiaryCardView: View {
    
    let entry: DiaryEntry
    
    // Returns emoji based on mood string
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
    
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: - Green Header
            VStack(spacing: 4) {
                Text(moodEmoji)
                    .font(.system(size: 32))
                Text(entry.childName)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(NurseryTheme.textOnGreen)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(NurseryTheme.brandGreen)
            
            // MARK: - Card Body
            VStack(alignment: .leading, spacing: 8) {
                Text(entry.activityType)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(NurseryTheme.textPrimary)
                    .lineLimit(1)
                
                Text(entry.entryDescription)
                    .font(.system(size: 12))
                    .foregroundStyle(NurseryTheme.textSecondary)
                    .lineLimit(3)
                    .lineSpacing(3)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer(minLength: 4)
                
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .font(.caption2)
                    Text(entry.date.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption2)
                }
                .foregroundStyle(NurseryTheme.textSecondary)
            }
            .padding(12)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(NurseryTheme.cardBackground)
        }
        .frame(width: 228, height: 220)
        .clipShape(RoundedRectangle(cornerRadius: NurseryTheme.cardRadius))
        .overlay(
            RoundedRectangle(cornerRadius: NurseryTheme.cardRadius)
                .strokeBorder(NurseryTheme.brandGreen.opacity(0.35), lineWidth: 1.5)
        )
        .shadow(color: .black.opacity(0.2), radius: 12, x: 0, y: 6)
    }
}
