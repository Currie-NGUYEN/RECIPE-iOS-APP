//
//  ViewController.swift
//  currie-recipe-app
//
//  Created by Currie on 3/2/20.
//  Copyright © 2020 Currie. All rights reserved.
//

import UIKit

class ListItemsController: UIViewController, XMLParserDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var listItems: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var pickerData:[String] = [String]()
    var recipes:[Recipe] = []
    var recipesFilter: [Recipe] = []
    var recipeTypes: [RecipeType] = []
    var name = String()
    var elementName = String()
    var currentType = "All"
    
    let defaults = UserDefaults.standard
    let jsonDecoder = JSONDecoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recipes = read()
        listItems.delegate = self
        listItems.dataSource = self
        listItems.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        recipeTypes.append(RecipeType(name: "All"))
        if let path = Bundle.main.url(forResource: "recipetypes", withExtension: "xml") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
            }
        }
        
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.selectRow(0, inComponent: 0, animated: true)
        
        filterRecipes(type: currentType)
        // Do any additional setup after loading the view.
    }
    func filterRecipes(type:String) {
        if( type != "All"){
            self.recipesFilter = recipes.filter {$0.type == type}
        }else{
            self.recipesFilter = recipes
        }
        
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
            
            if( elementName == "type"){

                name = String()
            }
            
            self.elementName = elementName
        }
        
        func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
            if( elementName == "type"){
                let recipeType = RecipeType(name: name)
                self.recipeTypes.append(recipeType)
            }
        }
        
        func parser(_ parser: XMLParser, foundCharacters string: String) {
            let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

            if (!data.isEmpty) {
                if self.elementName == "name" {
                    name += data
                }
            }
        }

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return recipeTypes.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return recipeTypes[row].name
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    //        print(recipeTypes[row].name)
            self.currentType = recipeTypes[row].name
            filterRecipes(type: currentType)
            listItems.reloadData()
        }

    func read() -> [Recipe] {
        let data = defaults.object(forKey: "recipes")
        if(data != nil){
            do{
                let value = try jsonDecoder.decode([Recipe].self, from: data as! Data)
                return value
            } catch let e{
                print(e)
            }
        }
        return []
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.recipes = read()
        filterRecipes(type: currentType)
        listItems.reloadData()
    }
    
}

extension ListItemsController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let viewController = storyboard?.instantiateViewController(identifier: "DetailItem") else {
            return
        }
        viewController.title = recipes[indexPath.row].name
        navigationController?.pushViewController(viewController, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension ListItemsController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ItemTableViewCell
        cell.imageRecipe.imageFromUrl(urlString: recipesFilter[indexPath.row].imageLink)
        cell.name.text = recipesFilter[indexPath.row].name
        return cell
    }
    
}
extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) {
                (response: URLResponse!, data: Data!, error: Error!) -> Void in
                if(data != nil){
                    self.image = UIImage(data: data)
                }
            }
        }
    }
}
