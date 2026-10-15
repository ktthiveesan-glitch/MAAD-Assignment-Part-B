import SwiftUI
import SwiftData

// ============================================
// ContentView.swift
// PURPOSE: Welcome screen with button to 
//          open the spatial diary view
// ROLE: Keyworker
// GDPR NOTE: Entry point - no child data
//            shown on this screen
// ============================================

struct ContentView: View {
    
    // Opens the diary cards window
    @Environment(\.openWindow)
    var openWindow
    
    // SwiftData context for seeding entries
    @Environment(\.modelContext)
    private var modelContext
    
    // Check if diary entries exist
    @Query private var entries: [DiaryEntry]
    
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: - Header Band
            headerBand
            
            // MARK: - Main Content
            VStack(spacing: 28) {
                logoView
                titleBlock
                primaryAction
                footerHint
                entryStatusBadge
            }
            .padding(.horizontal, 48)
            .padding(.vertical, 36)
        }
        .frame(minWidth: 520, minHeight: 440)
        .background(NurseryTheme.panelBackground)
        .clipShape(RoundedRectangle(cornerRadius: NurseryTheme.panelRadius))
        .overlay(
            RoundedRectangle(cornerRadius: NurseryTheme.panelRadius)
                .strokeBorder(NurseryTheme.brandGreen.opacity(0.2), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.15), radius: 24, y: 12)
        .task {
            seedEntriesIfNeeded()
        }
        .ornament(
            visibility: .visible,
            attachmentAnchor: .scene(.trailing)
        ) {
            KeyworkerPanelView(entryCount: entries.count)
        }
    }
    
    // MARK: - Header Band
    
    /// Subtle brand strip across the top of the welcome window.
    private var headerBand: some View {
        HStack {
            Image(systemName: "leaf.fill")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.9))
            Text("Little Stars Nursery")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(.white.opacity(0.95))
            Spacer()
            Text("Keyworker")
                .font(.caption2)
                .fontWeight(.semibold)
                .foregroundStyle(.white.opacity(0.75))
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(.white.opacity(0.15), in: Capsule())
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .background(NurseryTheme.brandGreen)
    }
    
    // MARK: - Logo
    
    /// Centre logo with soft ring accent.
    private var logoView: some View {
        ZStack {
            Circle()
                .fill(NurseryTheme.brandGreenLight)
                .frame(width: 96, height: 96)
            Circle()
                .fill(NurseryTheme.brandGreen)
                .frame(width: 76, height: 76)
            Image(systemName: "leaf.fill")
                .font(.system(size: 34, weight: .medium))
                .foregroundStyle(.white)
        }
    }
    
    // MARK: - Title Block
    
    /// App name and dashboard subtitle.
    private var titleBlock: some View {
        VStack(spacing: 8) {
            Text("NurseryConnect")
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .foregroundStyle(NurseryTheme.textPrimary)
            Text("Keyworker Spatial Dashboard")
                .font(.title3)
                .foregroundStyle(NurseryTheme.textSecondary)
        }
        .multilineTextAlignment(.center)
    }
    
    // MARK: - Primary Action
    
    /// Opens the diary cards window.
    private var primaryAction: some View {
        Button(action: toggleSpatialView) {
            Label("Open Diary Cards View", systemImage: "square.grid.2x2.fill")
        }
        .buttonStyle(NurseryPrimaryButtonStyle())
    }
    
    // MARK: - Footer Hint
    
    /// Short description below the main button.
    private var footerHint: some View {
        Text("View your children's diary entries in a spatial layout designed for Vision Pro.")
            .font(.subheadline)
            .foregroundStyle(NurseryTheme.textSecondary)
            .multilineTextAlignment(.center)
            .lineSpacing(4)
            .frame(maxWidth: 360)
    }
    
    // MARK: - Entry Status Badge
    
    /// Shows how many entries are loaded.
    private var entryStatusBadge: some View {
        Group {
            if entries.isEmpty {
                Label("Loading diary entries…", systemImage: "clock")
                    .font(.caption)
                    .foregroundStyle(NurseryTheme.textSecondary)
            } else {
                Label("\(entries.count) diary entries ready", systemImage: "checkmark.circle.fill")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(NurseryTheme.brandGreen)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(NurseryTheme.brandGreenLight, in: Capsule())
            }
        }
    }
    
    // MARK: - Open Diary Window
    
    /// Opens the diary cards window in spatial layout.
    private func toggleSpatialView() {
        seedEntriesIfNeeded()
        openWindow(id: "DiarySpace")
    }
    
    // MARK: - Seed Data
    
    /// Ensures sample entries exist so the welcome screen count updates.
    private func seedEntriesIfNeeded() {
        let descriptor = FetchDescriptor<DiaryEntry>()
        let count = (try? modelContext.fetchCount(descriptor)) ?? 0
        guard count == 0 else { return }
        
        let samples = [
            DiaryEntry(childName: "Emma Johnson", activityType: "Outdoor Play",
                       entryDescription: "Emma enjoyed playing in the garden and practiced counting flowers. She was very engaged throughout.", mood: "Happy"),
            DiaryEntry(childName: "Emma Johnson", activityType: "Reading",
                       entryDescription: "Emma read her favourite story book about animals. She remembered all the sounds and was excited.", mood: "Excited"),
            DiaryEntry(childName: "Noah Williams", activityType: "Arts and Crafts",
                       entryDescription: "Noah painted a picture of his family using watercolours. He showed great creativity today.", mood: "Happy"),
            DiaryEntry(childName: "Noah Williams", activityType: "Music and Dance",
                       entryDescription: "Noah learned new nursery rhymes and danced with friends. He was full of energy all morning.", mood: "Excited"),
            DiaryEntry(childName: "Lily Chen", activityType: "Educational",
                       entryDescription: "Lily practiced writing her name and counting to ten. She was focused and completed everything.", mood: "Happy"),
            DiaryEntry(childName: "Lily Chen", activityType: "Free Play",
                       entryDescription: "Lily played with building blocks and made a tall tower. She was a little tired after lunch.", mood: "Tired")
        ]
        samples.forEach { modelContext.insert($0) }
        try? modelContext.save()
    }
}

// MARK: - Shared Theme

/// Nursery brand colours and layout constants used across all views.
enum NurseryTheme {

    static let brandGreen = Color(
        red: 30 / 255,
        green: 122 / 255,
        blue: 60 / 255
    )

    static let brandGreenLight = Color(
        red: 30 / 255,
        green: 122 / 255,
        blue: 60 / 255
    ).opacity(0.12)

    static let cardRadius: CGFloat = 20
    static let panelRadius: CGFloat = 24

    /// Solid light panel — readable on any visionOS background.
    static let panelBackground = Color(
        red: 0.97,
        green: 0.98,
        blue: 0.97
    )

    static let cardBackground = Color.white

    /// Fixed dark text (avoids white-on-white in immersive mode).
    static let textPrimary = Color(
        red: 0.12,
        green: 0.14,
        blue: 0.12
    )

    static let textSecondary = Color(
        red: 0.38,
        green: 0.40,
        blue: 0.38
    )

    static let textOnGreen = Color.white
}

// MARK: - Primary Button Style

/// Green primary button used on welcome, diary, and detail screens.
struct NurseryPrimaryButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(.white)
            .padding(.horizontal, 32)
            .padding(.vertical, 14)
            .background(
                NurseryTheme.brandGreen.opacity(
                    configuration.isPressed ? 0.85 : 1
                ),
                in: RoundedRectangle(cornerRadius: 14)
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}
