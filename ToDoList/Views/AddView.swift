//
//  AddView.swift
//  ToDoList
//
//  Created by Pedro Lemos on 23/05/25.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Digite sua task aqui..", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(
                        Color(UIColor.secondarySystemBackground)
                    )
                    .cornerRadius(10)
                
                Button(action: saveButtonPressed, label: {
                    Text("Adicionar".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })
            }
            .padding(14)
        }
        .navigationTitle("Adicionar Tarefa 🖊️")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func saveButtonPressed() {
        if textIsAppropiate() {
            listViewModel.addItem(title: textFieldText)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func textIsAppropiate() -> Bool {
        if textFieldText.count < 3 {
            alertTitle = "Seu novo item tem que ter pelo menos 3 caracteres! 🤗"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
    
}

#Preview {
    NavigationStack {
        AddView()
    }
    .environmentObject(ListViewModel())
}
