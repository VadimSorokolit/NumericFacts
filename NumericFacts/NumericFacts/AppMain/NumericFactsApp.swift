//
//  NumericFactsApp.swift
//  NumericFacts
//
//  Created by Vadim Sorokolit on 15.09.2025.
//
    
import SwiftUI
import SwiftData
import CustomAlerts

@main
struct NumericFactsApp: App {
    
    // MARK: - Properties. Private
    
    @State private var viewModel: NumericFactsViewModel = NumericFactsViewModel(service: NetworkService())
    @State private var appAlert: AlertNotice?
    private var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            NumericFact.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    // MARK: - Root scene
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(self.viewModel)
                .environmentAlert($appAlert)
                .modelContainer(sharedModelContainer)
        }
    }
    
}
