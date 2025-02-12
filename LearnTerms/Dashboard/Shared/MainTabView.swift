import SwiftUI
import Supabase

struct MainTabView: View {
    @State private var pharmChapters: [Chapter] = []
    
    // Sample data to use before fetching.
    let sampleChapters = [
        Chapter(name: "Loading", desc: "Loading chapters", numprobs: 30, chapter: 1, emoji: "💊"),
    ]
    
    let sampleUser = MockUser(firstName: "John", imageUrl: "person.crop.circle")
    
    var body: some View {
        TabView {
            DashboardView(
                chapters: pharmChapters.isEmpty ? sampleChapters : pharmChapters,
                user: sampleUser,
                enabledThreshold: 2
            )
            .tabItem {
                Label("Dashboard", systemImage: "house")
            }
            
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person")
                }
        }.accentColor(Color.theme.primary) 
        // Show an overlay ProgressView when chapters are loading.
        .overlay {
            if pharmChapters.isEmpty {
                ProgressView()
            }
        }
        // Task to fetch chapters from your Supabase "pharmchapters" table.
        .task {
            do {
                // Replace this with your actual Supabase query.
                pharmChapters = try await supabase
                    .from("pharmchapters")
                    .select()
                    .execute()
                    .value
            } catch {
                dump(error)
            }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
