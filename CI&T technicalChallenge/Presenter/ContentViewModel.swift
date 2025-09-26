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
    var isLoadingPokemons: Bool = false

    var canGoForward: Bool {
        pokemonTotals?.next != nil
    }

    var canGoBackward: Bool {
        pokemonTotals?.previous != nil
    }

    @ObservationIgnored var pokemonTotals: PokeListResponseDTO?
    @ObservationIgnored let pokeService: PokeService = PokeService()
    
    func loadPokemons(offset: Int = 0) {
        isLoadingPokemons = true
        Task {
            await fetchPokemons(from: offset)
            await setPokemons()
        }
    }

    private func getPokemon(pokemons: [PokeResults]) async -> [PokemonModel] {
        var auxPokemons: [PokemonModel] = []
        for pokemon in pokemons {
            guard let response = await getPokemonDetails(pokemon: pokemon) else { return []}
            auxPokemons.append(response)
        }
        return auxPokemons
    }

    private func fetchPokemons(from offset: Int) async {
        isLoadingPokemons = true
        do {
            pokemonTotals = try await pokeService.getPokemons(offset: offset)
        } catch let error as NetworkError {
            print(error)
        } catch let error {
            print("n sei")
        }
    }

    func pageForward() {
        guard let pokemonTotals = pokemonTotals else { return }
        guard let offset = pokemonTotals.getForwardOffset() else { return }
        loadPokemons(offset: offset)
    }

    func pageBackward() {
        guard let pokemonTotals = pokemonTotals else { return }
        guard let offset = pokemonTotals.getBackwardOffset() else { return }
        loadPokemons(offset: offset)
    }

    private func setPokemons() async {
        guard let results = pokemonTotals?.results else { return }
        let pokemonAnswer = await getPokemon(pokemons: results)
        await MainActor.run {
            self.pokemons = pokemonAnswer
            self.isLoadingPokemons = false
        }
    }

    private func getPokemonDetails(pokemon: PokeResults) async -> PokemonModel? {
        do {
            let pokemonResponse = try await pokeService.getPokemon(name: pokemon.name)
            return PokemonModel(pokemonResponse: pokemonResponse)
        } catch let networkError as NetworkError {
            print(networkError.localizedDescription)
            return nil
        } catch let error {
            print(error.localizedDescription)
            return  nil
        }
    }
}
