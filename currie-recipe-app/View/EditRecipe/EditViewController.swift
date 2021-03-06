//
//  EditViewController.swift
//  currie-recipe-app
//
//  Created by Currie on 3/2/20.
//  Copyright © 2020 Currie. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    //MARK: properties
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var imageRecipe: UITextField!
    @IBOutlet weak var pickerType: UIPickerView!
    @IBOutlet weak var ingredients: UITextView!
    @IBOutlet weak var steps: UITextView!
    
//    let recipeService = RecipeService()
//    let recipeTypeService = RecipeTypeService()
    let detailRecipeVM = DetailRecipeViewModel()
    let editRecipeVM = EditRecipeViewModel()
    let getAllRecipeTypesVM = GetAllRecipeTypesViewModel()
    
    public var recipe:RecipeViewModel?
    var recipeTypesVM: [RecipeTypeViewModel] = []
    var recipeType: String?
    var nameTitle: String?
    
    //MARK: init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameTitle = self.title
        pickerType.dataSource = self
        pickerType.delegate = self
        editRecipeVM.updateRecipeViewModelDelegate = self
        recipeTypesVM = getAllRecipeTypesVM.getAllType()
        
        self.recipe = detailRecipeVM.getDetailRecipe(name: self.nameTitle!)
        self.imageRecipe.text = recipe!.image
        self.name.text = recipe!.name
        recipeType = recipe!.type
        let tmpType = RecipeType(name: recipe!.type)
        let defaultType = recipeTypesVM.lastIndex { $0.name == tmpType.name }
        self.pickerType.selectRow(defaultType ?? 0, inComponent: 0, animated: true)
        self.ingredients.text = recipe!.ingredients
        self.steps.text = recipe!.steps
       
    }
    
    //MARK: handler
    @IBAction func done(_ sender: UIButton) {
        let recipeUpdate = RecipeViewModel(recipe: Recipe(name: self.title!, imageLink: self.imageRecipe.text!, ingredients: self.ingredients.text!, steps: self.steps.text!, type: recipeType!))
        editRecipeVM.editRecipe(recipe: recipeUpdate)
        
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.recipeType = recipeTypesVM[row].name
//        print(recipeType)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
extension EditViewController: UpdateRecipeViewModelDelegate{
    
    func didUpdateRecipe() {
        navigationController?.popViewController(animated: true)
    }
    
    
}
