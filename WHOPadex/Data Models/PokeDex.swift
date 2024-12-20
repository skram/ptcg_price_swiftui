//
//  PokeDex.swift
//  WHOPadex
//
//  Created by Mark Peterson on 12/14/24.
//

import Foundation


class PokeDex : NSObject {
    
    var allPokemon:[Pokemon] = [Pokemon]()
    
    override init() {
        super.init()
        self.populateData()
    }
    
    func pokemonFromSearch(query:String) -> Pokemon? {
        return allPokemon.filter({$0.name == query}).first
    }
    
    private func populateData() {
        
        guard let data = self.pokemonDataFromFile() else { return }
                
        do {
            let p = try JSONDecoder().decode([Pokemon].self, from: data)
            self.allPokemon = p
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
    }
    
    private func pokemonDataFromFile() -> Data? {
        if let path = Bundle.main.path(forResource: "PokemonData", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                print("broken")
                return nil
            }
        }
        return nil
    }
    
}
