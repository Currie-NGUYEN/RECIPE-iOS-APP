//
//  ViewController.swift
//  currie-recipe-app
//
//  Created by Currie on 3/2/20.
//  Copyright © 2020 Currie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ListItemsController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var listItems: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var pickerData:[String] = [String]()
//    var recipesFilterVM = Variable<[RecipeViewModel]>([])
    var recipeTypesVM: [RecipeTypeViewModel] = []
    var currentType = "All"
    
    let filterRecipeVM = FilterRecipeViewModel()
    let getAllRecipeTypesVM = GetAllRecipeTypesViewModel()
    let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listItems.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        recipeTypesVM.append(RecipeTypeViewModel(recipeType: RecipeType(name: "All")))
        recipeTypesVM.append(contentsOf: getAllRecipeTypesVM.getAllType())
        
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.selectRow(0, inComponent: 0, animated: true)
        
        filterRecipeVM.typeChanged = self.pickerView.rx.itemSelected.asDriver()
        filterRecipeVM.filterRecipe()
        
        filterRecipeVM.recipes.asObservable().bind(to: listItems.rx.items(cellIdentifier: "cell", cellType: ItemTableViewCell.self)) {_, recipeViewModel, cell in
            cell.recipeViewModel = recipeViewModel
        }.disposed(by: disposeBag)
        
        listItems.rx.modelSelected(RecipeViewModel.self).subscribe(onNext: { recipe in
            guard let viewController = self.storyboard?.instantiateViewController(identifier: "DetailItem") else {
                return
            }
            viewController.title = recipe.name
            self.navigationController?.pushViewController(viewController, animated: true)
            }).disposed(by: disposeBag)
        listItems.rowHeight = 120
        
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return recipeTypesVM.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return recipeTypesVM[row].name
    }

    override func viewDidAppear(_ animated: Bool) {
        self.filterRecipeVM.filterRecipe()
    }
}
