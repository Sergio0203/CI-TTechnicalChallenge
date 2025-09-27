//
//  CachedAsyncImage.swift
//  CI&T technicalChallenge
//
//  Created by Sérgio César Lira Júnior on 27/09/25.
//

import SwiftUI

struct CachedAsyncImage: View {
    private let url: URL?
    @State private var image: Image? = nil
    @State private var isLoading = false

    public init(url: URL?) {
        self.url = url
    }

    var body: some View {
        if let image = image {
            image
                .resizable()
                .scaledToFit()
        } else {
            ProgressView()
                .onAppear {
                    Task {
                        await loadImage()
                    }
                }
        }
    }

    func loadImage() async {
        guard let url = url, !isLoading else { return }

        isLoading = true

        // Check if the image is already cached
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request),
           let cachedImage = UIImage(data: cachedResponse.data) {
            await MainActor.run {
                self.image = Image(uiImage: cachedImage)
                self.isLoading = false
            }
            return
        }

        // Fetch the image from the network
        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            // Cache the image
            let cachedData = CachedURLResponse(response: response, data: data)
            URLCache.shared.storeCachedResponse(cachedData, for: request)

            if let uiImage = UIImage(data: data) {
                await MainActor.run {
                    self.image = Image(uiImage: uiImage)
                    self.isLoading = false
                }
            }
        } catch {
            // Handle any errors here (e.g., network failure)
            await MainActor.run {
                self.isLoading = false
            }
        }
    }
}
