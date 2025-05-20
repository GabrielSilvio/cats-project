import SwiftUI
import Kingfisher

struct CatDetailView: View {
    @ObservedObject var viewModel: CatDetailViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack(alignment: .topTrailing) {
            if viewModel.isLoading {
                VStack {
                    Spacer()
                    ProgressView()
                        .scaleEffect(1.5)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.15), .white]), startPoint: .top, endPoint: .bottom))
            } else if let uiModel = viewModel.uiModel {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        ZStack(alignment: .topTrailing) {
                            KFImage(uiModel.imageURL)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity, minHeight: 320, maxHeight: 400)
                                .clipped()
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.2), .white]), startPoint: .top, endPoint: .bottom)
                                )
                                .cornerRadius(0)
                            Button(action: { dismiss() }) {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.system(size: 32))
                                    .foregroundColor(.white)
                                    .shadow(radius: 6)
                            }
                            .padding(.top, 16)
                            .padding(.trailing, 20)
                        }
                        VStack(alignment: .leading, spacing: 24) {
                            HStack(spacing: 8) {
                                Image(systemName: "pawprint.fill")
                                    .foregroundColor(.accentColor)
                                Text(NSLocalizedString("Cat Details", comment: "Title for cat details screen"))
                                    .font(.title)
                                    .fontWeight(.bold)
                            }
                            if !uiModel.tagsText.isEmpty && uiModel.tagsText != NSLocalizedString("No tags", comment: "No tags fallback") {
                                TagsListView(tags: uiModel.tagsText.components(separatedBy: ", "))
                            } else {
                                Text(NSLocalizedString("No tags", comment: "No tags fallback"))
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            HStack(spacing: 16) {
                                Label(uiModel.createdAtText, systemImage: "calendar")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Label(uiModel.mimetypeText, systemImage: "photo")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Divider()
                            VStack(alignment: .leading, spacing: 8) {
                                Text(NSLocalizedString("Cat ID:", comment: "Label for cat id"))
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(uiModel.id)
                                    .font(.body.monospaced())
                                    .foregroundColor(.primary)
                                    .contextMenu { Text(uiModel.id) }
                            }
                        }
                        .padding(24)
                        .background(
                            RoundedRectangle(cornerRadius: 32)
                                .fill(Color(.systemBackground))
                                .shadow(color: .black.opacity(0.07), radius: 8, x: 0, y: -2)
                        )
                        .offset(y: -32)
                    }
                }
                .ignoresSafeArea(edges: .top)
                .background(
                    LinearGradient(gradient: Gradient(colors: [.white, .gray.opacity(0.08)]), startPoint: .top, endPoint: .bottom)
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
            } else if let error = viewModel.error {
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 48))
                        .foregroundColor(.orange)
                    Text(NSLocalizedString("Failed to load cat details", comment: "Error title"))
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(error)
                        .font(.body)
                        .foregroundColor(.secondary)
                    Button(NSLocalizedString("Try again", comment: "Retry button")) {
                        Task { await viewModel.fetch() }
                    }
                    .buttonStyle(.borderedProminent)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(LinearGradient(gradient: Gradient(colors: [.orange.opacity(0.1), .white]), startPoint: .top, endPoint: .bottom))
            }
        }
        .task {
            await viewModel.fetch()
        }
    }
}

private struct TagsListView: View {
    let tags: [String]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(tags, id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Capsule().fill(Color.accentColor.opacity(0.15)))
                        .foregroundColor(.accentColor)
                }
            }
        }
    }
} 
