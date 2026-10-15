import SwiftUI
import SwiftData

@main
struct NurseryConnectVisionApp: App {
    
    // Creates shared SwiftData container
    let container: ModelContainer = {
        let schema = Schema([DiaryEntry.self])
        // Named store avoids crash from older incompatible schemas on disk
        let config = ModelConfiguration(
            "NurseryConnectV2",
            schema: schema,
            isStoredInMemoryOnly: false
        )
        do {
            return try ModelContainer(
                for: schema,
                configurations: [config]
            )
        } catch {
            fatalError("Cannot create container: \(error)")
        }
    }()
    
    var body: some Scene {
        
        // Main welcome window
        WindowGroup {
            ContentView()
                .onAppear {
                    insertSampleData(
                        context: container
                            .mainContext
                    )
                }
        }
        .modelContainer(container)
        
        // Diary cards window (spatial layout)
        WindowGroup(id: "DiarySpace") {
            SpatialDiaryView()
        }
        .modelContainer(container)
    }
    
    // Inserts sample data using app container
    // Runs once when app first launches
    // Only inserts if no data exists already
    func insertSampleData(
        context: ModelContext
    ) {
        let descriptor = FetchDescriptor<DiaryEntry>()
        let existing = try? context.fetch(
            descriptor
        )
        guard existing?.isEmpty ?? true
        else { return }
        
        let samples = [
            DiaryEntry(
                childName: "Emma Johnson",
                activityType: "Outdoor Play",
                entryDescription: "Emma enjoyed playing in the garden and practiced counting flowers. She was very engaged throughout.",
                mood: "Happy"
            ),
            DiaryEntry(
                childName: "Emma Johnson",
                activityType: "Reading",
                entryDescription: "Emma read her favourite story book about animals. She remembered all the sounds and was excited.",
                mood: "Excited"
            ),
            DiaryEntry(
                childName: "Noah Williams",
                activityType: "Arts and Crafts",
                entryDescription: "Noah painted a picture of his family using watercolours. He showed great creativity today.",
                mood: "Happy"
            ),
            DiaryEntry(
                childName: "Noah Williams",
                activityType: "Music and Dance",
                entryDescription: "Noah learned new nursery rhymes and danced with friends. He was full of energy all morning.",
                mood: "Excited"
            ),
            DiaryEntry(
                childName: "Lily Chen",
                activityType: "Educational",
                entryDescription: "Lily practiced writing her name and counting to ten. She was focused and completed everything.",
                mood: "Happy"
            ),
            DiaryEntry(
                childName: "Lily Chen",
                activityType: "Free Play",
                entryDescription: "Lily played with building blocks and made a tall tower. She was a little tired after lunch.",
                mood: "Tired"
            )
        ]
        
        for entry in samples {
            context.insert(entry)
        }
        try? context.save()
    }
}
