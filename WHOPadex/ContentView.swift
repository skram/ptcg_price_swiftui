//
//  ContentView.swift
//  WHOPadex
//
//  Created by Mark Peterson on 12/14/24.
//

import SwiftUI
import Foundation
import SDWebImage
import SDWebImageSwiftUI

struct ContentView: View {
    
    var pokeDex:PokeDex = PokeDex()
    
    @State private var searchQuery: String = ""
    @State private var selectedPokemon: Pokemon?
    @State private var isLoading = true
    @State private var loadError: Error?

    var body: some View {
        NavigationStack {
            
            let query = self.pokeDex.allPokemon.filter{searchQuery.isEmpty ? true:$0.name.localizedCaseInsensitiveContains(searchQuery)}
            
            List(query) { pokemon in
                PokemonRowView(pokemon: pokemon)
            }
            .navigationTitle("WHOPadex")
            .searchable(text:$searchQuery)
            .navigationDestination(for: Pokemon.self) { pokemon in
                if let url = pokemon.generatedSearchURL {
                    WHOPWebView(url: url, isLoading: $isLoading, error: $loadError)
                        .navigationTitle(pokemon.name)
                }
            }
            .navigationDestination(for: String.self) { evolutionQuery in
                let newPokemon = self.searchPokemonByEvolution(evolution: evolutionQuery)
                if let url = newPokemon?.generatedSearchURL {
                    WHOPWebView(url: url, isLoading: $isLoading, error: $loadError)
                        .navigationTitle(selectedPokemon?.name ?? "")
                }
            }
        }
    }
    
    func searchPokemonByEvolution(evolution:String) ->Pokemon? {
        if let result = self.pokeDex.allPokemon.first(where: {$0.name.lowercased() == evolution.lowercased()}) {
            return result
        }
        return nil
    }
}

#Preview {
    ContentView()
}
