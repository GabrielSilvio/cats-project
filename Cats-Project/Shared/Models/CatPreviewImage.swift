import SwiftUI

struct CatPreviewImage: View {
    let id: String
    let tags: [String]
    
    var body: some View {
        ZStack {
            backgroundColor
            emoji
                .font(.system(size: 40))
                .shadow(radius: 2)
        }
    }
    
    private var backgroundColor: Color {
        if tags.contains("orange") {
            return .orange.opacity(0.7)
        } else if tags.contains("black") {
            return .black.opacity(0.8)
        } else if tags.contains("tuxedo") {
            return Color.gray.opacity(0.7)
        } else {
            return Color.blue.opacity(0.5)
        }
    }
    
    private var emoji: Text {
        if tags.contains("sleeping") || tags.contains("sleepy") {
            return Text("😴")
        } else if tags.contains("garfield") || tags.contains("lasagna") {
            return Text("🍝")
        } else if tags.contains("cute") {
            return Text("😺")
        } else if tags.contains("fluffy") {
            return Text("🐱")
        } else {
            return Text("🐈")
        }
    }
} 