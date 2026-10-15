import SwiftUI

// ============================================
// KeyworkerPanelView.swift
// PURPOSE: Small ornament panel showing
//          diary entry count and date
// ROLE: Keyworker
// GDPR NOTE: Shows only count not personal
//            data in this panel
// ============================================

struct KeyworkerPanelView: View {
    
    let entryCount: Int
    
    // Formats todays date for display
    var todayDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: Date())
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            // MARK: - Panel Header
            HStack(spacing: 8) {
                Image(systemName: "person.crop.circle.badge.checkmark")
                    .font(.body)
                    .foregroundStyle(NurseryTheme.brandGreen)
                Text("Keyworker Panel")
                    .font(.headline)
                    .foregroundStyle(NurseryTheme.brandGreen)
            }
            .padding(.bottom, 16)
            
            Divider()
                .padding(.bottom, 14)
            
            // MARK: - Entry Count
            panelRow(
                icon: "book.closed.fill",
                title: "Diary entries",
                value: "\(entryCount)"
            )
            
            // MARK: - Date
            panelRow(
                icon: "calendar",
                title: "Today",
                value: todayDate
            )
            
            Spacer(minLength: 12)
            
            Divider()
                .padding(.bottom, 10)
            
            // MARK: - Assignment Label
            Text("SE4020 visionOS Prototype")
                .font(.caption2)
                .foregroundStyle(NurseryTheme.textSecondary)
        }
        .padding(22)
        .frame(width: 228, alignment: .topLeading)
        .frame(minHeight: 200)
        .background(NurseryTheme.panelBackground)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .strokeBorder(NurseryTheme.brandGreen.opacity(0.35), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.12), radius: 12, y: 4)
    }
    
    // MARK: - Panel Row
    
    /// Single labelled row with icon in the keyworker panel.
    private func panelRow(icon: String, title: String, value: String) -> some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: icon)
                .font(.subheadline)
                .foregroundStyle(NurseryTheme.brandGreen)
                .frame(width: 20)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(NurseryTheme.textSecondary)
                Text(value)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(NurseryTheme.textPrimary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.bottom, 12)
    }
}
