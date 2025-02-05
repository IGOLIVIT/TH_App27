//
//  SalesViewModel.swift
//  TH_App27
//
//  Created by IGOR on 03/02/2025.
//

import SwiftUI
import CoreData

final class SalesViewModel: ObservableObject {

    @AppStorage("TotalSold") var TotalSold: Int = 0
    @AppStorage("Revenue") var Revenue: Int = 0

    @Published var isAdd: Bool = false
    @Published var isDelete: Bool = false
    @Published var isSettings: Bool = false
    @Published var isDetail: Bool = false

    @Published var saName: String = ""
    @Published var saQuan: String = ""
    @Published var saRev: String = ""
    @Published var saDate: Date = Date()

    @Published var sales: [SaleModel] = []
    @Published var selectedSale: SaleModel?

    func addSale() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "SaleModel", into: context) as! SaleModel

        loan.saName = saName
        loan.saQuan = saQuan
        loan.saRev = saRev
        loan.saDate = saDate

        CoreDataStack.shared.saveContext()
    }

    func fetchSales() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<SaleModel>(entityName: "SaleModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.sales = result

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.sales = []
        }
    }

}
