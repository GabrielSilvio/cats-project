import SwiftUI
import Kingfisher

struct CatDetailView: View {
    let uiModel: CatDetailAnimatedModel
    var animation: Namespace.ID
    @Binding var show: Bool

    var body: some View {
        VStack {
            KFImage(uiModel.imageURL)
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .matchedGeometryEffect(id: uiModel.id, in: animation, isSource: show)
                .shadow(radius: 10)
                .padding(.top, 40)
            Text(uiModel.mainTag)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 16)
            Text(uiModel.createdAtText)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom, 8)
            Spacer()
            Button(action: {
                withAnimation(.spring()) {
                    show = false
                }
            }) {
                Text("Close")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
            .padding(.bottom, 24)
        }
        .background(
            RoundedRectangle(cornerRadius: 32)
                .fill(Color(.systemBackground))
                .shadow(radius: 20)
        )
        .padding(.horizontal, 24)
        .transition(.asymmetric(insertion: .scale.combined(with: .opacity), removal: .opacity))
    }
} 
