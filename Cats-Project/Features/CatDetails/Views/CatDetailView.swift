import SwiftUI
import Kingfisher

struct CatDetailView: View {
    @ObservedObject var viewModel: CatDetailViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack(alignment: .topTrailing) {
            if viewModel.isLoading {
                LoadingView()
            } else if let uiModel = viewModel.uiModel {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        CatImageHeaderView(imageURL: uiModel.imageURL, onClose: { dismiss() })
                        CatDetailContentView(uiModel: uiModel)
                    }
                }
                .ignoresSafeArea(edges: .top)
                .background(
                    LinearGradient(gradient: Gradient(colors: [.white, .gray.opacity(0.08)]), startPoint: .top, endPoint: .bottom)
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
            } else if let error = viewModel.error {
                ErrorView(error: error, onRetry: { Task { await viewModel.fetch() } })
            }
        }
        .task {
            await viewModel.fetch()
        }
    }
}

private struct LoadingView: View {
    var body: some View {
        VStack {
            Spacer()
            ProgressView()
                .scaleEffect(1.5)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.15), .white]), startPoint: .top, endPoint: .bottom))
    }
}

private struct ErrorView: View {
    let error: String
    let onRetry: () -> Void
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 48))
                .foregroundColor(.orange)
            Text("Failed to load cat details")
                .font(.title2)
                .fontWeight(.bold)
            Text(error)
                .font(.body)
                .foregroundColor(.secondary)
            Button("Try again") {
                onRetry()
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [.orange.opacity(0.1), .white]), startPoint: .top, endPoint: .bottom))
    }
}

private struct CatImageHeaderView: View {
    let imageURL: URL?
    let onClose: () -> Void
    var body: some View {
        ZStack(alignment: .topTrailing) {
            KFImage(imageURL)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, minHeight: 320, maxHeight: 400)
                .clipped()
                .background(
                    LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.2), .white]), startPoint: .top, endPoint: .bottom)
                )
                .cornerRadius(0)
            Button(action: { onClose() }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 32))
                    .foregroundColor(.white)
                    .shadow(radius: 6)
            }
            .padding(.top, 16)
            .padding(.trailing, 20)
        }
    }
}

private struct CatDetailContentView: View {
    let uiModel: CatDetailUIModel
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack(spacing: 8) {
                Image(systemName: "pawprint.fill")
                    .foregroundColor(.accentColor)
                Text(uiModel.titleText)
                    .font(.title)
                    .fontWeight(.bold)
            }
            if !uiModel.tags.isEmpty {
                TagsListView(tags: uiModel.tags)
            } else {
                Text(uiModel.tagsText)
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
                Text(uiModel.idLabelText)
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
