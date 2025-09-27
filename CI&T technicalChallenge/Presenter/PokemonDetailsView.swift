
import SwiftUI

struct PokemonDetailsView: View {
    var name: String
    var image: String?
    var types: [PokeTypeName]
    var weight: Double

    var body: some View {
        VStack {
            ZStack {
                Image(.poke2)
                    .opacity(0.9)
                pokemonImage
                    .frame(width: 300, height: 300)
            }
            Text(name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .accessibilityIdentifier(name)


            HStack(spacing: 8){
                ForEach(types, id: \.hashValue) { type in
                    Text(type.rawValue.capitalized)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.background)
                                .stroke(type.color, lineWidth: 1)
                        }
                        .foregroundStyle(type.color)
                }
            }
             weightComponent
                .padding(.top, 40)

        }
    }
    @ViewBuilder
    var weightComponent: some View {
        VStack(spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: "scalemass")
                    .foregroundStyle(.secondary)
                Text(String(format: "%.1fkg", weight))
            }
            Text("Weight")
                .foregroundStyle(Color.weight)
        }
    }
    @ViewBuilder
    var pokemonImage: some View {
        if let image {
            CachedAsyncImage(url: URL(string: image)!)
                .aspectRatio(contentMode: .fill)
                .scaledToFill()
                .frame(width: 300, height: 300)
        }
        else {
            Image(systemName: "photo.fill")
                .resizable()
                .scaledToFill()
        }
    }
}
