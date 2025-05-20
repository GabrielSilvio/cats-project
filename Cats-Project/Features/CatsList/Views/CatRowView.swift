import SwiftUI
import Kingfisher

struct CatRowView: View {
    let uiModel: CatRowUIModel

    var body: some View {
        HStack(spacing: 16) {
            KFImage(uiModel.thumbnailURL)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(uiModel.mainTag)
                    .font(.headline)
                
                Text(uiModel.createdAtText)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}
