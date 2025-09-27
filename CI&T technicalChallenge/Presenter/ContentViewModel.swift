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
    var errorAppeared: Bool = false
    var canGoForward: Bool {
        pokemonTotals?.next != nil
    }

    var canGoBackward: Bool {
        pokemonTotals?.previous != nil
    }

    @ObservationIgnored var pokemonTotals: PokeListResponseDTO?
    @ObservationIgnored let pokeService: PokeServiceProtocol
    @ObservationIgnored private var loadPokemonsTask: Task<Void, Never>?

    init(pokeService: PokeServiceProtocol = PokeService()) {
        self.pokeService = pokeService
    }

    func loadPokemons(offset: Int = 0) {
        loadPokemonsTask?.cancel()
        isLoadingPokemons = true
        errorAppeared = false
        
        loadPokemonsTask = Task {
            let auxPokemon = await fetchPokemons(from: offset)

            await MainActor.run {
                pokemons = auxPokemon
                isLoadingPokemons = false
            }

            await setPokemons()
        }
    }

    private func fetchPokemons(from offset: Int) async -> [PokemonModel] {
        do {
            var auxPokemon: [PokemonModel] = []
            pokemonTotals = try await pokeService.getPokemons(offset: offset)

            guard let results = pokemonTotals?.results else { return  []}
            results.forEach { pokeResult in
                auxPokemon.append(PokemonModel(pokeResult: pokeResult))
            }

            return auxPokemon

        } catch is NetworkError{
            await setErrorAppearedtoTrue()
            return []
        } catch {
            return []
        }
    }

    private func setPokemons() async {
        for (index, pokemon) in pokemons.enumerated() {
            guard let pokemonDetails = await getPokemonDetails(pokemon: pokemon) else { return }
            let asyncPokemon = await PokemonModel(pokemonResponse: pokemonDetails)
            await MainActor.run {
                pokemons[index] = asyncPokemon
            }
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

    private func getPokemonDetails(pokemon: PokemonModel) async -> PokeResponseDTO? {
        do {
            guard let pokemonName = pokemon.name else {return nil}
            let pokemonResponse = try await pokeService.getPokemon(name: pokemonName)
            return pokemonResponse
        } catch is NetworkError {
            await setErrorAppearedtoTrue()
            return nil
        } catch {
            return nil
        }
    }

    private func setErrorAppearedtoTrue() async {
        await MainActor.run {
            errorAppeared = true
        }
    }
}
