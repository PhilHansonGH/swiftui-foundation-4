//
//  DataService.swift
//  Recipe List App
//
//  Created by Phil Hanson on 8/11/21.
//

import Foundation

class DataService {
    
    func getLocalData() -> [Recipe] {
        
        // Parse local json file
        
        // Get a url path to the json file
        let pathString = Bundle.main.path(forResource: "recipes", ofType: "json")
        
        // Guard statement
        // Check if path string is not nil, otherwise ...
        guard pathString != nil else {
            return [Recipe]()
        }
        
        // Create a url object
        let url = URL(fileURLWithPath: pathString!)
        
        do {
            // Create a data object
            let data = try Data(contentsOf: url)
            
            // Decode the data with a json decoder
            let decoder = JSONDecoder()
        
            do {
                let recipeData = try decoder.decode([Recipe].self, from: data)
                
                // Add the unique IDs for recipes
                for r in recipeData {
                    r.id = UUID()
                    
                    // Add the unique IDs for ingredients
                    for i in r.ingredients {
                        i.id = UUID()
                    }
                }
                
                // Return the recipes
                return recipeData
                
            } catch {
                // Error with parsing json
                print(error)
            }

        } catch {
            // Error with getting data
            print(error)
        }

        // Returns an empty array if all else fails
        return [Recipe]()
        
    }

}
