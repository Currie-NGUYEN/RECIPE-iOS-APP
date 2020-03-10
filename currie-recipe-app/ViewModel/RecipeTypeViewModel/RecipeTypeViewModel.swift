//
//  RecipeTypeViewModel.swift
//  currie-recipe-app
//
//  Created by Currie on 3/6/20.
//  Copyright © 2020 Currie. All rights reserved.
//

struct RecipeTypeViewModel {
    var name: String
    
    init(recipeType: RecipeType) {
        self.name = recipeType.name
    }
    
}
