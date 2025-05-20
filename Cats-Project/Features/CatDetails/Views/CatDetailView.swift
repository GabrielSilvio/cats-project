import SwiftUI

struct CatDetailView: View {
    @ObservedObject var viewModel: CatDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                AsyncImage(url: viewModel.imageURL) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else if phase.error != nil {
                        Image(systemName: "photo")
                            .imageScale(.large)
                            .frame(maxWidth: .infinity, minHeight: 300)
                            .background(Color.gray.opacity(0.1))
                    } else {
                        ProgressView()
                            .frame(maxWidth: .infinity, minHeight: 300)
                            .background(Color.gray.opacity(0.1))
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 300)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(radius: 5)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Information")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    HStack {
                        Text("ID:")
                            .fontWeight(.medium)
                        Text(viewModel.id)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    
                    HStack {
                        Text("Created At:")
                            .fontWeight(.medium)
                        Text(viewModel.createdAtFormatted)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    
                    HStack {
                        Text("Media Type:")
                            .fontWeight(.medium)
                        Text(viewModel.mimetype)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    
                    if !viewModel.tags.isEmpty {
                        Text("Tags:")
                            .font(.headline)
                            .padding(.top, 8)
                        
                        FlowLayout {
                            ForEach(viewModel.tags, id: \.self) { tag in
                                Text(tag)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.blue.opacity(0.1))
                                    .foregroundColor(.blue)
                                    .cornerRadius(20)
                            }
                        }
                    }
                }
                .padding()
            }
            .padding()
        }
        .navigationTitle("Cat Details")
    }
}

struct FlowLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        
        var totalHeight: CGFloat = 0
        var totalWidth: CGFloat = 0
        var lineWidth: CGFloat = 0
        var lineHeight: CGFloat = 0
        
        let width = proposal.width ?? 0
        
        for size in sizes {
            if lineWidth + size.width > width {
                totalHeight += lineHeight + 8
                lineWidth = size.width
                lineHeight = size.height
            } else {
                lineWidth += size.width + 8
                lineHeight = max(lineHeight, size.height)
            }
            
            totalWidth = max(totalWidth, lineWidth)
        }
        
        totalHeight += lineHeight
        
        return CGSize(width: totalWidth, height: totalHeight)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        
        var lineX = bounds.minX
        var lineY = bounds.minY
        var lineHeight: CGFloat = 0
        
        for (index, subview) in subviews.enumerated() {
            let size = sizes[index]
            
            if lineX + size.width > bounds.maxX {
                lineY += lineHeight + 8
                lineHeight = 0
                lineX = bounds.minX
            }
            
            subview.place(at: CGPoint(x: lineX, y: lineY), proposal: ProposedViewSize(width: size.width, height: size.height))
            
            lineHeight = max(lineHeight, size.height)
            lineX += size.width + 8
        }
    }
}
