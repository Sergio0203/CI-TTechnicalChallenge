//
//  CI_T_technicalChallengeTests.swift
//  CI&T technicalChallengeTests
//
//  Created by Sérgio César Lira Júnior on 24/09/25.
//

import XCTest
@testable import CI_T_technicalChallenge

final class CI_T_technicalChallengeTests: XCTestCase {

    private var viewModel: ContentViewModel!
    private var mockPokeService: MockPokeService!

    override func setUp() {
        super.setUp()
        mockPokeService = MockPokeService()
        viewModel = ContentViewModel(pokeService: mockPokeService)
    }

    override func tearDown() {
        viewModel = nil
        mockPokeService = nil
        super.tearDown()
    }

    func testLoadPokemons_Success() async {

        // Arrange
        let fakePokemonList = PokeListResponseDTO(next: "http://fake.com?offset=20", previous: nil, results: [
            PokeResults(name: "bulbasaur")
        ])

        let fakePokemonDetail = PokeResponseDTO(id: 1, name: "bulbasaur", sprites: Sprites(front_default: "www.teste.com"), types: [.init(type: PokeType(name: .dark))], weight: 10)

        let expectedResponse = [PokemonModel(pokemonResponse: fakePokemonDetail)]
        mockPokeService.pokemonListResult = .success(fakePokemonList)
        mockPokeService.pokemonDetailResult = .success(fakePokemonDetail)


        // Act
        viewModel.loadPokemons()
        let expectation =  expectation(description: "Loading Pokemons")
        expectation.fulfill()
        await fulfillment(of: [expectation], timeout: 1.0)

        // Assert
        XCTAssertEqual(expectedResponse, viewModel.pokemons)
    }

    func testLoadPokemonsPokemonDetails_Failure() async {
        // Arrange

        let fakePokemonList = PokeListResponseDTO(next: "http://fake.com?offset=20", previous: nil, results: [
            PokeResults(name: "bulbasaur")
        ])

        mockPokeService.pokemonListResult = .success(fakePokemonList)
        mockPokeService.pokemonDetailResult = .failure(MockError.networkError)

        let expectation = XCTestExpectation(description: "Aguardando a falha do carregamento")

        let expectationPokemonList: [PokemonModel] = [.init(pokeResult: fakePokemonList.results.first!)]
        let expectationErrorAppeared: Bool = true
        // Act
        viewModel.loadPokemons()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 2.0)

        // Assert
        XCTAssertEqual(expectationPokemonList, viewModel.pokemons)
        XCTAssertEqual(expectationErrorAppeared, viewModel.errorAppeared)
    }

    func testLoadPokemonsPokemonList_Failure() async {
        // Arrange

        mockPokeService.pokemonListResult = .failure(MockError.networkError)

        let expectation = XCTestExpectation(description: "Aguardando a falha do carregamento")

        let expectationPokemonList: [PokemonModel] = []
        let expectationErrorAppeared: Bool = true
        // Act
        viewModel.loadPokemons()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 2.0)

        // Assert
        XCTAssertEqual(expectationPokemonList, viewModel.pokemons)
        XCTAssertEqual(expectationErrorAppeared, viewModel.errorAppeared)
    }

    func testLoadPokemonListCancellationFailure_Success() async {
        // Arrange

        let fakePokemonDetail = PokeResponseDTO(id: 1, name: "bulbasaur", sprites: Sprites(front_default: "www.teste.com"), types: [.init(type: PokeType(name: .dark))], weight: 10)

        mockPokeService.pokemonListResult = .failure(MockError.cancelled)
        mockPokeService.pokemonDetailResult = .success(fakePokemonDetail)

        let expectation = XCTestExpectation(description: "Aguardando a falha do carregamento")
        let expectedResponse: [PokemonModel] = []
        let expectationErrorAppeared: Bool = false

        // Act
        viewModel.loadPokemons()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 2.0)

        // Assert
        XCTAssertEqual(expectedResponse, viewModel.pokemons)
        XCTAssertEqual(expectationErrorAppeared, viewModel.errorAppeared)
    }

    func testLoadPokemonDetailsCancellationFailure_Success() async {
        // Arrange

        let fakePokemonList = PokeListResponseDTO(next: "http://fake.com?offset=20", previous: nil, results: [
            PokeResults(name: "bulbasaur")
        ])

        mockPokeService.pokemonListResult = .success(fakePokemonList)
        mockPokeService.pokemonDetailResult = .failure(MockError.cancelled)

        let expectation = XCTestExpectation(description: "Aguardando a falha do carregamento")
        let expectedResponse: [PokemonModel] = []
        let expectationErrorAppeared: Bool = false

        // Act
        viewModel.loadPokemons()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 2.0)

        // Assert
        XCTAssertEqual(expectedResponse, viewModel.pokemons)
        XCTAssertEqual(expectationErrorAppeared, viewModel.errorAppeared)
    }
}
