
import SwiftUI

struct PokemonDetailsView: View {
    var name: String
    var image: UIImage?
    var types: [PokeTypeName]
    var weight: Int

    var body: some View {
        VStack {
            pokemonImage

                .frame(width: 150, height: 150)
            Text("Types:")
                .font(.title)
                .fontWeight(.bold)
            ForEach(types, id: \.hashValue) { type in
                Text(type.rawValue)
            }
            Text("Weight: \(weight) kg")
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle(name)
    }

    @ViewBuilder
    var pokemonImage: some View {
        if let image {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
        }
        else {
            Image(systemName: "photo.fill")
                .resizable()
                .scaledToFill()
        }
    }
}
#if DEBUG
#Preview {
    NavigationStack {
        PokemonDetailsView(name: "Bulbasaur", image: UIImage(systemName: "questionmark.folder.ar")!, types: [.dark, .dragon ], weight: 82)
    }
}
#endif
