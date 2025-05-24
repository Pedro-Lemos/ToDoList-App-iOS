//
//  ListViewModel.swift
//  ToDoList
//
//  Created by Pedro Lemos on 23/05/25.
//

import Foundation

/*
 CRUD Functions
 
 Create
 Read
 Update
 Delete
 */

class ListViewModel: ObservableObject {
    
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }
    
    let itemsKey: String = "items_list"
    
    init() {
        getItems()
    }
    
    func getItems() {
        
        // Massa de teste
//        let newItems = [
//            ItemModel(title: "Primeiro título", isCompleted: false),
//            ItemModel(title: "Segundo título", isCompleted: true),
//            ItemModel(title: "Terceiro título", isCompleted: false),
//        ]
//        items.append(contentsOf: newItems)
            
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        
        self.items = savedItems
    }
    
    func deleteItem(at indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String) {
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel) {
        
        // Obter a posição do item que foi clicado dentro da lista
//        if let index = items.firstIndex { existingItem in
//            return existingItem.id == item.id
//        } {
//            
//        }
        
        // Outra forma de fazer
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateCompletition()
        }
    }
    
    func saveItems() {
        if let encodedData = try?
            JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}
