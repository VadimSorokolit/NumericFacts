//
//  HomeView.swift
//  NumericFacts
//
//  Created by Vadim Sorokolit on 15.09.2025.
//
    
import SwiftUI
import SwiftData

struct AppError: Identifiable, Equatable {
    let id = UUID()
    let message: String
}

struct HomeView: View {
    
    // MARK: - Properties. Private
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \NumericFact.index) private var numberFacts: [NumericFact]
    @Environment(NumericFactsViewModel.self) private var viewModel
    
    // MARK: - Man body
    
    var body: some View {
        @Bindable var vm = viewModel
        
        NavigationStack {
            VStack(spacing: 0.0) {
                VStack(spacing: 20.0) {
                    TextField("Enter number...", text: $vm.inputText)
                        .keyboardType(.numberPad)
                        .padding(.horizontal, 12.0)
                        .frame(width: 180.0, height: 30.0)
                        .background(.yellow, in: RoundedRectangle(cornerRadius: 20))
                    
                    Button(action: {
                        if let number = viewModel.inputNumber {
                            Task {
                                await viewModel.fetchFactFor(number: number)
                            }
                        }
                    }) {
                        Text("Get fact by input number")
                            .font(.headline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .frame(width: 160.0)
                            .padding(.vertical, 6.0)
                            .frame(width: 180.0)
                            .background(
                                RoundedRectangle(cornerRadius: 20.0)
                                    .fill(Color.blue.opacity(viewModel.inputNumber == nil ? 0.5 : 1.0))
                            )
                    }
                    .disabled(viewModel.inputNumber == nil)
                    
                    Button(action: {
                        viewModel.inputText = ""
                        Task {
                            await viewModel.fetchRandomFact()
                        }
                    }) {
                        Text("Get fact by random number")
                            .font(.headline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .frame(width: 160.0)
                            .padding(.vertical, 6.0)
                            .frame(width: 180.0)
                            .background(
                                RoundedRectangle(cornerRadius: 20.0)
                                    .fill(Color.orange)
                            )
                    }
                }
                
                Divider()
                    .background(Color.gray)
                    .frame(height: 4.0)
                    .padding(.top, 10.0)
                
                List {
                    ForEach(numberFacts) { numberFact in
                        NavigationLink {
                            FactDetailsView(numberFact: numberFact)
                        } label: {
                            DetailsCell(
                                number: numberFact.number,
                                numberFact: numberFact.factText,
                                isPreview: true
                            )
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .padding(.top, 40.0)
        .modifier(LoadViewModifier(handleInput: {
            handleInputNumber()
        }))
    }
    
    // MARK: - Methods. Private
    
    func handleInputNumber() {
        if let number = viewModel.currentNumber {
            let newNumberFact = NumericFact(
                index: numberFacts.count + 1,
                number: number,
                factText: viewModel.factText
            )
            modelContext.insert(newNumberFact)
            viewModel.inputText = ""
        }
        
        do {
            try modelContext.save()
        } catch {
            viewModel.errorMessage = AppError(message: error.localizedDescription)
        }
    }
    
    // MARK: - Modifiers
    
    struct LoadViewModifier: ViewModifier {
        @Environment(NumericFactsViewModel.self) var viewModel
        @Environment(\.appAlert) private var appAlert
        let handleInput: () -> Void
        
        func body(content: Content) -> some View {
            content
                .onChange(of: viewModel.errorMessage) { oldValue, newValue in
                    if let error = viewModel.errorMessage {
                        appAlert.error(Text(error.message))
                    }
                }
                .onChange(of: viewModel.factText) { 
                    handleInput()
                }
        }
    }
}
