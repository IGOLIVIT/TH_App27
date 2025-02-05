//
//  ExperimentsViewModel.swift
//  TH_App27
//
//  Created by IGOR on 03/02/2025.
//

import SwiftUI
import CoreData

final class ExperimentsViewModel: ObservableObject {
    
    @Published var statuses: [String] = ["In development", "Ready"]
    @Published var currStatus = ""
    
    @Published var statusesForFilter: [String] = ["All", "In development", "Ready"]
    @Published var currStatusForFilter = "All"
    
    @Published var isAdd: Bool = false
    @Published var isDelete: Bool = false
    @Published var isSettings: Bool = false
    @Published var isDetail: Bool = false

    @Published var exName: String = ""
    @Published var exIdea: String = ""
    @Published var exComment: String = ""
    @Published var exDate: Date = Date()
    @Published var exStatus: String = ""

    @Published var experiments: [ExperimentModel] = []
    @Published var selectedExperiment: ExperimentModel?

    func addExperiment() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "ExperimentModel", into: context) as! ExperimentModel

        loan.exName = exName
        loan.exIdea = exIdea
        loan.exComment = exComment
        loan.exDate = exDate
        loan.exStatus = exStatus

        CoreDataStack.shared.saveContext()
    }

    func fetchExperiments() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ExperimentModel>(entityName: "ExperimentModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.experiments = result

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.experiments = []
        }
    }

}
