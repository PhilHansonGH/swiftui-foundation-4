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
         
        
        var portion = ""
        var numerator = ingredient.num ?? 1
        var demoninator = ingredient.denom ?? 1
        var wholePortions = 0
        
        if ingredient.num != nil {
            
            // Get a single serving size by multiplying deominator by the servings
            demoninator *= recipeServings
            
            // Get target portion by multiplying numerator by target servings
            numerator *= targetServings
            
            // Reduce fraction by greatest common divisor
            let divisor = Rational.greatestCommonDivisor(numerator, demoninator)
            numerator /= divisor
            demoninator /= divisor
            
            // Get the whole portion if numerator > denomerator
            if numerator >= demoninator {
                
                // Calulate whole portions
                wholePortions = numerator / demoninator
                
                // Calulate remainder
                numerator = numerator % demoninator
                
                // Assign to portions string
                portion += String(wholePortions)
                
            }
            
            // Express the remainder as a fraction
            if numerator > 0 {
                // Assign remainer as fraction to portions string
                portion += wholePortions > 0 ? " " : ""
                portion += "\(numerator)/\(demoninator)"
            }
            
        }
        
        if var unit = ingredient.unit {
            
            if wholePortions > 1 {
                
                // Calculate suffix
                if unit.suffix(2) == "ch" {
                    unit += "es"
                }
                else if unit.suffix(1) == "f" {
                    unit = String(unit.dropLast())
                    unit += "ves"
                }
                else {
                    unit += "s"
                }
            }

            
            portion += ingredient.num == nil && ingredient.denom == nil ? "" : " "
            
            return portion + unit
        }
        
        return portion
    }
    
}
