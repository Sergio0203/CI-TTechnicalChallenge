//
//  ContentView.swift
//  CI&T technicalChallenge
//
//  Created by Sérgio César Lira Júnior on 24/09/25.
//

import SwiftUI

struct ContentView: View {
    @State var viewModel = ContentViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                content

            }
            .onAppear {
                if viewModel.pokemonTotals == nil {
                    viewModel.loadPokemons()
                }
            }
            .refreshable {
                viewModel.loadPokemons()
            }
        }
    }

    @ViewBuilder
    var content: some View {
        if viewModel.isLoadingPokemons {
            ProgressView()
        }
        else {
            List (viewModel.pokemons, id: \.self.name) { pokemon in
                NavigationLink{
                    PokemonDetailsView(name: pokemon.name ?? "", image: pokemon.image, types: pokemon.types, weight: pokemon.weight ?? 0)
                } label: {
                    HStack {
                        getPokeImage(image: pokemon.image)
                            .frame(width: 60, height: 60)
                        Text(pokemon.name ?? "")
                    }
                }
            }


            HStack {
                if viewModel.canGoBackward {
                    Button(action: viewModel.pageBackward) {
                        Image(systemName: "chevron.left")
                    }
                }

                Spacer()
                if viewModel.canGoForward {
                    Button(action: viewModel.pageForward) {
                        Image(systemName: "chevron.right")
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
    @ViewBuilder
    func getPokeImage(image: UIImage?) -> some View {
        if let image = image {
             Image(uiImage: image)
                .resizable()
                .scaledToFill()
        } else {
             ProgressView()
        }
    }
}

#Preview {
    ContentView()
}
