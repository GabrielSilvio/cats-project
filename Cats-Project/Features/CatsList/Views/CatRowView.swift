import SwiftUI

struct CatRowView: View {
    let uiModel: CatRowUIModel

    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: uiModel.thumbnailURL) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else if phase.error != nil {
                    Image(systemName: "photo")
                        .imageScale(.large)
                } else {
                    ProgressView()
                }
            }
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
