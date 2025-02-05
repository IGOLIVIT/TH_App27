//
//  RecipesViewModel.swift
//  TH_App27
//
//  Created by IGOR on 03/02/2025.
//

import SwiftUI
import CoreData

final class RecipesViewModel: ObservableObject {
    
    @Published var categories: [String] = ["Hand & Manual Tools", "Power & Electric Tools", "Cutting & Abrasive Tools", "Measuring & Precision Tools", "Specialized & Job-Specific Tools", "Other"]
    @Published var currCat = ""
    
    @Published var conditions: [String] = ["℃", "℃"]
    @Published var currCond = ""

    @Published var isAdd: Bool = false
    @Published var isDelete: Bool = false
    @Published var isSettings: Bool = false
    @Published var isDetail: Bool = false

    @Published var reName: String = ""
    @Published var reTemp: String = ""
    @Published var reTType: String = ""
    @Published var reTime: Date = Date()
    @Published var reIng: String = ""
    @Published var reDescr: String = ""

    @Published var recipes: [RecipeModel] = []
    @Published var selectedRec: RecipeModel?

    func addRecipe() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "RecipeModel", into: context) as! RecipeModel

        loan.reName = reName
        loan.reTemp = reTemp
        loan.reTType = reTType
        loan.reTime = reTime
        loan.reIng = reIng
        loan.reDescr = reDescr

        CoreDataStack.shared.saveContext()
    }

    func fetchRecipes() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<RecipeModel>(entityName: "RecipeModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.recipes = result

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.recipes = []
        }
    }

}
