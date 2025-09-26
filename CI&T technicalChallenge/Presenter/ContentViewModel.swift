//
//  ContentViewModel.swift
//  CI&T technicalChallenge
//
//  Created by Sérgio César Lira Júnior on 25/09/25.
//

import SwiftUI

@Observable
final class ContentViewModel {
    var pokemons: [PokemonModel] = []
    var isPresented: Bool = false
    var generation: Int = 1
    var page: Int = 0
    var totalPages: Int = 1
    var isLoadingPokemons: Bool = false
    @ObservationIgnored var pokemonTotals: PokeListResponseDTO?
    @ObservationIgnored var currentindex: Int {
        get {
            page
        }
    }

    @ObservationIgnored let pokeService: PokeService = PokeService()

    func getPokemons() {
        isLoadingPokemons = true
        Task {
            if pokemonTotals == nil {
                await fetchPokemonsFromGeneration()
            }
            let pokemonsAnswer = await paginationPokemon()
            await MainActor.run {
                self.pokemons = pokemonsAnswer
                self.isLoadingPokemons = false
            }
        }

    }

    private func paginationPokemon() async -> [PokemonModel] {
        pokemons = []
        var auxPokemons: [PokemonModel] = []
        guard let pokemonList = pokemonTotals?.results else { return []}
        let startIndex = (currentindex) * 10
        let endIndex = (startIndex + 10) > pokemonList.count ? pokemonList.count : (startIndex + 10)

        for pokemon in pokemonList[startIndex...endIndex] {
            guard let pokemon = await getPokemon(pokemon: pokemon) else { return [] }
            auxPokemons.append(pokemon)
        }
        return auxPokemons
    }
    
    private func getPokemon(pokemon: PokeResults) async -> PokemonModel? {

        do {
            let pokemonResponse = try await pokeService.getPokemon(name: pokemon.name)
            return PokemonModel(pokemonResponse: pokemonResponse)
        } catch let networkError as NetworkError {
            print(networkError.localizedDescription)
            return nil
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }

    private func fetchPokemonsFromGeneration() async {
        isLoadingPokemons = true
        do {
            pokemonTotals = try await pokeService.getPokemons()
            totalPages = Int(ceil(Double(pokemonTotals?.results.count ?? 0)/10))
        } catch let error as NetworkError {
            print(error)
        } catch let error {
            print("n sei")
        }
    }
}


