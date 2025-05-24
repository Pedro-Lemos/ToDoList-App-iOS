//
//  NoItemsView.swift
//  ToDoList
//
//  Created by Pedro Lemos on 23/05/25.
//

import SwiftUI

struct NoItemsView: View {
    @State private var isPressed: Bool = false

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("Não há tarefas.")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Adicione uma tarefa clicando no botão 'Adicionar' ou no botão abaixo.")
                    .padding(.bottom, 40)
                NavigationLink(
                    destination: AddView(),
                    label: {
                        Image(systemName: "plus")
                            .font(.system(size: 30))
                            .foregroundColor(.accentColor)
                            .background(
                                Circle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 50, height: 50)
                                    .shadow(color: Color.gray, radius: 10)
                            )
                            .scaleEffect(isPressed ? 0.8 : 1.0)
                            .animation(.spring(response: 0.3, dampingFraction: 0.4), value: isPressed)
                    }
                )
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            isPressed = true
                        }
                        .onEnded { _ in
                            isPressed = false
                        }
                )
            }
            .frame(maxWidth: 400)
            .multilineTextAlignment(.center)
            .padding(40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    NavigationView {
        NoItemsView()
    }
}
