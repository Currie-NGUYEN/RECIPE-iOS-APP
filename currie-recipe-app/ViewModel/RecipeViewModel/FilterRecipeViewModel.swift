//
//  FilterRecipeViewModel.swift
//  currie-recipe-app
//
//  Created by Currie on 3/9/20.
//  Copyright © 2020 Currie. All rights reserved.
//

import Foundation
import Resolver
import RxSwift
import RxCocoa

class FilterRecipeViewModel {
    
    //MARK: properties
    @Injected var recipeService: RecipeServiceProtocol
    @Injected var recipeTypeService: RecipeTypeServiceProtocol
    
    public var recipes: PublishSubject<[RecipeViewModel]> = PublishSubject()
    var typeChanged: SharedSequence<DriverSharingStrategy, (row: Int, component: Int)>!
    let disposeBag = DisposeBag()
    var recipeTypesVM: [RecipeTypeViewModel] = []
    var currentType = "All"
    
    init() {
        self.recipeTypesVM.append(RecipeTypeViewModel(recipeType: RecipeType(name: currentType)))
        self.recipeTypesVM.append(contentsOf: self.recipeTypeService.getAllRecipeType())
        self.recipes.onNext(self.recipeService.read(filterType: nil))
    }
    //MARK: Handler
    func filterRecipe(){
        self.recipes.onNext(self.recipeService.read(filterType: nil))
        self.typeChanged.asObservable().subscribe({ type in
            let typeName = self.recipeTypesVM[type.element!.row].name
            if typeName == "All"{
                self.recipes.onNext(self.recipeService.read(filterType: nil))
                    } else {
                self.recipes.onNext(self.recipeService.read(filterType: typeName))
                    }
            }).disposed(by: disposeBag)
    }
}
