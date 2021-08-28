//
//  RecipeFeaturedView.swift
//  Recipe List App
//
//  Created by Phil Hanson on 8/19/21.
//

import SwiftUI

struct RecipeFeaturedView: View {
    
    @EnvironmentObject var model:RecipeModel
    @State var isDetailViewShowing = false
    @State var tabSelectionIndex = 0

    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Featured Recipes")
                .bold()
                .padding(.leading)
                .padding(.top, 40)
                .font(.largeTitle)
            
            
            GeometryReader { geo in
                
                TabView (selection: $tabSelectionIndex){
                    
                    // Loop throughe each recipe
                    ForEach (0..<model.recipes.count) { index in
                        
                        // Only show those featured
                        if model.recipes[index].featured == true {
                            
                            // Recipe Card Button
                            Button(action:  {
                                
                                // Show the recipe detail sheet
                                self.isDetailViewShowing = true
                                
                            }, label: {
                                // Recipe card
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.white)
                                    VStack(spacing: 0) {
                                        Image(model.recipes[index].image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .clipped()
                                        Text(model.recipes[index].name)
                                            .padding(10)
                                    }
                                }
                            })
                            .tag(index)
                            .sheet(isPresented: $isDetailViewShowing) {
                                // Show the Recipe detail view
                                RecipeDetailView(recipe: model.recipes[index])
                            }
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: geo.size.width - 40, height: geo.size.height - 100, alignment: .center)
                            .cornerRadius(15)
                            .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.5), radius: 5, x: -5, y: 5)
                        }
                        
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Preparation time")
                    .font(.headline)
                Text(model.recipes[tabSelectionIndex].prepTime)
                Text("Highlights")
                    .font(.headline)
                RecipeHighlights(highlights: model.recipes[tabSelectionIndex].highlights)
            }
            .padding([.leading, .bottom])}
            .onAppear(perform: {
                setFeaturedIndex()
            })
    }
    
    func setFeaturedIndex() {
        // Find the index of first featured recipe
        let index = model.recipes.firstIndex { (receipe) -> Bool in
            return receipe.featured == true
        }
        tabSelectionIndex = index ?? 0
    }
}

struct RecipeFeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFeaturedView()
            .environmentObject(RecipeModel())
    }
}
