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
        VStack {
            List (viewModel.pokemons) { pokemon in
                Button(action: {
                    viewModel.isPresented = true
                }, label: {
                    HStack {
                        Text(pokemon.name)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                })
            }
        }
        .onAppear {
            viewModel.getPokemons()
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
