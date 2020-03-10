//
//  AddItemViewController.swift
//  currie-recipe-app
//
//  Created by Currie on 3/2/20.
//  Copyright © 2020 Currie. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: properties
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var imageLink: UITextField!
    @IBOutlet weak var nameRecipe: UITextField!
    @IBOutlet weak var ingredients: UITextField!
    @IBOutlet weak var steps: UITextView!
    
    var recipeTypesVM: [RecipeTypeViewModel] = []
    var type: String = ""
    
    let addRecipeVM = AddRecipeViewModel()
    let getAllRecipeTypesVM = GetAllRecipeTypesViewModel()
    
    //MARK: init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRecipeVM.addRecipeViewModelDelegate = self
        picker.dataSource = self
        picker.delegate = self
        self.recipeTypesVM = getAllRecipeTypesVM.getAllType()
        self.type = recipeTypesVM[0].name
        self.picker.selectRow(0, inComponent: 0, animated: true)
    }
    
    //MARK: handler
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return recipeTypesVM.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return recipeTypesVM[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        print(recipeTypes[row].name)
        self.type = recipeTypesVM[row].name
    }
    
    @IBAction func addItem(_ sender: UIButton) {
        let recipe = Recipe(name: nameRecipe.text!, imageLink: imageLink.text!, ingredients: ingredients.text!, steps: steps.text!, type: self.type)
        self.addRecipeVM.addRecipe(recipe: RecipeViewModel(recipe: recipe))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension AddItemViewController: AddRecipeViewModelDelegate{
    func didAddRecipe() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

