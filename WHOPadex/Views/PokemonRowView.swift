//
//  PokemonRowView.swift
//  WHOPadex
//
//  Created by Mark Peterson on 12/15/24.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI


// https://www.tcgplayer.com/search/pokemon/product?Language=English&productLineName=pokemon&q=XY01&view=grid

struct PokemonRowView: View {
    
    var pokemon:Pokemon
    @State var isExpanded: Bool = false
    @State var isEvolution: Bool = false
    @State var parentView: ContentView?

    /**
     Main Content for Row's View. - Displaying  Image and Pokemon
    */
    var rowContent: some View {
        HStack {
            if let image = pokemon.images?.small {
                WebImage(url: URL(string: image))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth:80, maxHeight:80)
            }
            VStack {
                Text(pokemon.name).frame(maxWidth: .infinity,alignment: .leading)
                Text("#\(pokemon.number.trimmingCharacters(in: .whitespacesAndNewlines))").frame(maxWidth: .infinity,alignment: .leading)
            }
        }
    }
    
    /**
     DisclosureGroup for collapse folder functionality -
    */
    var evolutionFolder: some View {
        DisclosureGroup(
            isExpanded:$isExpanded,
            content: {
                NavigationLink(value:pokemon) {
                    Text("Check \(pokemon.name) Prices")
                        .accessibilityAddTraits(.isButton)
                        .accessibilityLabel("\(pokemon.name) Prices")
                }
                ForEach(pokemon.evolvesTo ?? [], id: \.self) { evolution in
                    NavigationLink(value:evolution) {
                        Text("Check \(evolution) Evolution Prices")
                            .accessibilityAddTraits(.isButton)
                            .accessibilityLabel("\(evolution) Evolution Prices")
                    }
                }
            }, label: {
                rowContent
            }
        )
    }

    /**
     Determine what main content shows - for Top Level Pokemon, and or Evolution(s) group.
    */
    var body: some View {
        if(pokemon.hasEvolutions) {
                evolutionFolder
        } else {
            NavigationLink(value:pokemon) {
                rowContent
            }
        }
    }
}
