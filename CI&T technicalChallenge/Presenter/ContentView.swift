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
            List (viewModel.pokemons) { pokemon in
                NavigationLink{
                    PokemonDetailsView(name: pokemon.name, image: pokemon.image, types: pokemon.types, weight: pokemon.weight)
                } label: {
                    HStack {
                        Image(uiImage: pokemon.image ?? UIImage())
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                        Text(pokemon.name)
                        Spacer()
                        Image(systemName: "chevron.right")
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
}

#Preview {
    ContentView()
}
