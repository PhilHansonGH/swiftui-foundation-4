//
//  RecipeDetailView.swift
//  Recipe List App
//
//  Created by Phil Hanson on 8/14/21.
//

import SwiftUI

struct RecipeDetailView: View {
    
    var recipe:Recipe
    
    var body: some View {
      
        ScrollView {
            
            VStack (alignment: .leading) {
                // MARK: Recipe image
                Image(recipe.image)
                    .resizable()
                    .scaledToFill()
                
                // MARK: Ingredients
                VStack(alignment: .leading) {
                    
                    Text("Ingredients")
                        .font(.headline)
                        .padding(.vertical, 10)
                    
                    ForEach(recipe.ingredients) { item in
                        Text("· " + item.name)
                    }
                }
                .padding(.horizontal)
                    
                // MARK: Directions
                VStack(alignment: .leading) {
                    
                    Divider()
                    
                    Text("Directions")
                        .font(.headline)
                        .padding(.vertical, 5)
                    
                    ForEach(0..<recipe.directions.count, id: \.self) { index in
                        Text(String(index + 1) + ". " + recipe.directions[index])
                            .padding(.bottom, 5)
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitle(recipe.name).padding(.top, 15)
    }

}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        let model = RecipeModel()
        
        RecipeDetailView(recipe: model.recipes[0])
    }
}
