//
//  RecipeModel.swift
//  Recipe List App
//
//  Created by Phil Hanson on 8/11/21.
//

import Foundation

class RecipeModel: ObservableObject {
    
    @Published var recipes = [Recipe]()
    
    init() {
        
        // Create and instance of data service and get data
        // Several ways to do this
        
        // let service = DataService()
        // self.recipes = service.getLocalData()
        
        // or
        
        self.recipes = DataService().getLocalData()

    }
    
    // Method to caclulate ingridients for portions selected
    static func getPortion(ingredient:Ingredient, recipeServings:Int, targetServings:Int) -> String {
         
        // Get a single serving size by multiplying deominator by the servings
        
        // Get target portion by multiplying numerator by target servings
        
        // Reduce fraction by greatest common divisor
        
        // Get the whole portion if numerator > denomerator
        
        // Express the remainder as a fraction
        
        return String(targetServings)
    }
    
}
