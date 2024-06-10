//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Álvaro Gascón on 10/6/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Query(filter: #Predicate<User> { user in
//        user.name.contains("R")
//        user.name.localizedStandardContains("R")  // 1ª Forma
//        user.name.localizedStandardContains("R") && // 2ª Forma
//        user.city == "London"
        if user.name.localizedStandardContains("R") { // 3ª Forma
                if user.city == "London" {
                    return true
                } else {
                    return false
                }
            } else {
                return false
            }                               // Hasta aquí
    }, sort: \User.name) var users: [User]
    
    @State private var path = [User]()
    
    var body: some View {
        NavigationStack(path: $path) {
            List(users) { user in
                Text(user.name)
            }
            .navigationTitle("Users")
            .toolbar {
                Button("Add Samples", systemImage: "plus") {
                    try? modelContext.delete(model: User.self)
                    
                    let first = User(name: "Ed Sheeran", city: "London", joinDate: .now.addingTimeInterval(86400 * -10))
                    let second = User(name: "Rosa Diaz", city: "New York", joinDate: .now.addingTimeInterval(86400 * -5))
                    let third = User(name: "Roy Kent", city: "London", joinDate: .now.addingTimeInterval(86400 * 5))
                    let fourth = User(name: "Johnny English", city: "London", joinDate: .now.addingTimeInterval(86400 * 10))

                    modelContext.insert(first)
                    modelContext.insert(second)
                    modelContext.insert(third)
                    modelContext.insert(fourth)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
