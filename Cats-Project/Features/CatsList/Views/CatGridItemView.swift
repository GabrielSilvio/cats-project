import SwiftUI
import Kingfisher

struct CatGridItemView: View {
    let uiModel: CatRowUIModel
    var animation: Namespace.ID
    var isSource: Bool

    var body: some View {
        VStack(spacing: 8) {
            KFImage(uiModel.thumbnailURL)
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(height: 140)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .matchedGeometryEffect(id: uiModel.id, in: animation, isSource: isSource)
                .shadow(radius: 6)
            Text(uiModel.mainTag)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(1)
            Text(uiModel.createdAtText)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(1)
            Text(uiModel.tagsText)
                .font(.caption2)
                .foregroundColor(.accentColor)
                .lineLimit(1)
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.07), radius: 4, x: 0, y: 2)
        )
        .scaleEffect(0.98)
        .animation(.spring(), value: uiModel.id)
    }
} 
