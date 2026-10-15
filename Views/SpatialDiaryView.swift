import SwiftUI
import SwiftData

// ============================================
// SpatialDiaryView.swift
// PURPOSE: Shows diary cards floating in
//          3D mixed reality environment
// ROLE: Keyworker
// GDPR NOTE: Child diary data shown only
//            to authorised keyworker
//            UK GDPR Article 5
// ============================================

struct SpatialDiaryView: View {
    
    // Fetches all diary entries
    @Query private var entries: [DiaryEntry]
    
    // Tracks selected card for detail view
    @State private var selectedEntry: 
        DiaryEntry? = nil
    
    // Closes this diary cards window
    @Environment(\.dismissWindow)
    private var dismissWindow
    
    var body: some View {
        
        // MARK: - Full Screen Layout
        VStack(spacing: 0) {
            spatialHeader
            
            Divider()
                .overlay(NurseryTheme.textSecondary.opacity(0.3))
                .padding(.horizontal, 32)
            
            VStack(spacing: 28) {
                // MARK: - Top Row Cards
                HStack(spacing: 22) {
                    ForEach(
                        Array(entries.prefix(3).enumerated()),
                        id: \.offset
                    ) { _, entry in
                        cardButton(for: entry)
                    }
                }
                
                // MARK: - Bottom Row Cards
                HStack(spacing: 22) {
                    ForEach(
                        Array(entries.dropFirst(3).prefix(3).enumerated()),
                        id: \.offset
                    ) { _, entry in
                        cardButton(for: entry)
                    }
                }
            }
            .padding(.horizontal, 36)
            .padding(.vertical, 32)
            
            Divider()
                .overlay(NurseryTheme.textSecondary.opacity(0.3))
                .padding(.horizontal, 32)
            
            // MARK: - Exit Button
            Button {
                dismissWindow(id: "DiarySpace")
            } label: {
                Label("Close Diary View", systemImage: "xmark.circle.fill")
            }
            .buttonStyle(NurseryPrimaryButtonStyle())
            .padding(.vertical, 24)
        }
        .frame(minWidth: 820)
        .background(NurseryTheme.panelBackground)
        .clipShape(RoundedRectangle(cornerRadius: NurseryTheme.panelRadius))
        .overlay(
            RoundedRectangle(cornerRadius: NurseryTheme.panelRadius)
                .strokeBorder(NurseryTheme.brandGreen.opacity(0.25), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.18), radius: 28, y: 14)
        .sheet(item: $selectedEntry) { entry in
            DiaryDetailView(entry: entry)
        }
    }
    
    // MARK: - Spatial Header
    
    /// Title and entry count for the diary window.
    private var spatialHeader: some View {
        HStack(alignment: .center, spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(NurseryTheme.brandGreenLight)
                    .frame(width: 48, height: 48)
                Image(systemName: "text.book.closed.fill")
                    .font(.title2)
                    .foregroundStyle(NurseryTheme.brandGreen)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Today's Diary Entries")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(NurseryTheme.textPrimary)
                Text("Little Stars Nursery · Keyworker view")
                    .font(.subheadline)
                    .foregroundStyle(NurseryTheme.textSecondary)
            }
            
            Spacer()
            
            Text("\(entries.count) entries")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(NurseryTheme.brandGreen)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(NurseryTheme.brandGreenLight, in: Capsule())
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 24)
    }
    
    // MARK: - Card Button
    
    /// Tappable diary card with subtle press feedback.
    private func cardButton(for entry: DiaryEntry) -> some View {
        DiaryCardView(entry: entry)
            .onTapGesture {
                selectedEntry = entry
            }
            .hoverEffect(.lift)
    }
}
