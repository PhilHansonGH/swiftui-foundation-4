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
    
    
}
