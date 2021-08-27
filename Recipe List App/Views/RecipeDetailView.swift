//
//  RecipeDetailView.swift
//  Recipe List App
//
//  Created by Phil Hanson on 8/14/21.
//

import SwiftUI

struct RecipeDetailView: View {
    
    var recipe:Recipe
    @State var selectedServingSize = 2
    
    var body: some View {
      
        ScrollView {
            
            VStack (alignment: .leading) {
                // MARK: Recipe image
                Image(recipe.image)
                    .resizable()
                    .scaledToFill()
                
                // Recipe Title
                Text(recipe.name)
                    .bold()
                    .padding(.top, 40)
                    .padding(.leading)
                    .font(.largeTitle)
                
                // MARK: Portion picker
                VStack(alignment: .leading) {
                    Text("Select your serving size:")
                    .padding(.leading)
                    Picker("", selection: $selectedServingSize) {
                        Text("2").tag(2)
                        Text("4").tag(4)
                        Text("6").tag(6)
                        Text("8").tag(8)
                    }
                    .padding(.leading)
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 160)
                }
                
                // MARK: Ingredients
                VStack(alignment: .leading) {
                    
                    Text("Ingredients")
                        .font(.headline)
                        .padding(.vertical, 10)
                    
                    ForEach(recipe.ingredients) { item in
                        Text("· " + RecipeModel.getPortion(ingredient: item, recipeServings: recipe.servings, targetServings: selectedServingSize) + " " + item.name.lowercased())
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
        
    }

}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        let model = RecipeModel()
        
        RecipeDetailView(recipe: model.recipes[0])
    }
}
