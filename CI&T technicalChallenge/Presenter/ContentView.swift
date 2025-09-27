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
            ZStack {
                content
                    .padding(.horizontal, 16)
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
            VStack(alignment: .leading, spacing: 46) {
                header
                ScrollView() {
                    VStack(spacing: 14) {
                        ForEach (viewModel.pokemons, id: \.self.name) { pokemon in
                            NavigationLink{
                                PokemonDetailsView(name: pokemon.name ?? "", image: pokemon.image, types: pokemon.types, weight: pokemon.weight ?? 0)
                            } label: {
                                HStack(alignment: .top, spacing: 0){
                                    Text(pokemon.name ?? "")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                        .padding(.top, 19)
                                    Spacer()
                                    getPokeImage(image: pokemon.image)
                                        .frame(width: 94, height: 94)
                                }
                            }
                            .padding()
                            .background(Color.cards)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                    }
                }
                .padding(.horizontal, 11)
            }
            pageControllers
                .padding(.bottom, 24)
        }
    }

    @ViewBuilder
    var pageControllers: some View {
        VStack {
            Spacer()
            HStack(alignment: .bottom) {
                if viewModel.canGoBackward {
                    Button(action: viewModel.pageBackward) {
                        Circle()
                            .fill(.pageController)
                            .frame(width: 50, height: 50)
                            .overlay {
                                Image(systemName: "arrow.left")
                            }
                    }
                    .frame(width: 50, height: 50)
                }

                Spacer()
                if viewModel.canGoForward {
                    Button(action: viewModel.pageForward) {
                        Circle()
                            .fill(.pageController)
                            .frame(width: 50, height: 50)
                            .overlay {
                                Image(systemName: "arrow.right")
                            }
                    }
                }
            }
            .foregroundStyle(.white)
        }
    }

    @ViewBuilder
    var header: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Select your")
                .font(.title)
            HStack(spacing: 0) {
                Text("Pokemon")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Image(.pokeBalllmage)
            }
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
