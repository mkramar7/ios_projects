//
//  ContentView.swift
//  LearnMultiplication
//
//  Created by Marko Kramar on 26/08/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import SwiftUI

struct Question: Hashable {
    var upTo: Int
    var question: String
    var answer: String
}

var questions = [Question]()
func generateQuestions(upToNumber: Int, numberOfQuestions: String) {
    for upTo in 4...12 {
        for i in 1...3 {
            let multiplierOne = Int.random(in: i...upTo)
            let multiplierTwo = Int.random(in: i...upTo)
            let questionString = "What is \(multiplierOne) x \(multiplierTwo)?"
            let answerString = String(multiplierOne * multiplierTwo)
            questions.append(Question(upTo: upTo, question: questionString, answer: answerString))
        }
    }
    
    questions = numberOfQuestions == "All" ? questions : Array(questions.filter { $0.upTo <= upToNumber }.shuffled().prefix(Int(numberOfQuestions)!))
}

struct SettingsView: View {
    @State private var upTo = 5
    @State private var numberOfQuestions = "10"
    
    var gameStarted: Binding<Bool>
    
    private let numberOfQuestionsOptions = ["5", "10", "20", "All"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Multiply numbers up to")
                        .font(.headline)

                    Stepper(value: $upTo, in: 4...12) {
                        Text("\(upTo)")
                    }
                }
                
                Section {
                    Text("How many questions?")
                        .font(.headline)

                    Picker("Number of questions", selection: $numberOfQuestions) {
                        ForEach(numberOfQuestionsOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .labelsHidden()
                }
                
                Button(action: {
                    generateQuestions(upToNumber: self.upTo, numberOfQuestions: self.numberOfQuestions)
                    self.gameStarted.wrappedValue = true
                }) {
                    HStack {
                        Spacer()
                        Text("Start game")
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("Multiplication game")
        }
    }
}

struct ContentView: View {
    @State private var gameStarted = false
    
    @State private var questionIndex = 0
    @State private var enteredAnswer = ""
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    @State private var score = 0
    
    var body: some View {
        Group {
            if gameStarted {
                VStack {
                    if questionIndex < questions.count {
                        Text("Question \(questionIndex+1)/\(questions.count)")
                            .font(.subheadline
                        )
                        Text("\(questions[questionIndex].question)")
                            .font(.title)
                        
                        TextField("Enter answer", text: $enteredAnswer)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 300, alignment: Alignment.center)
                        
                        Button(action: {
                            if self.enteredAnswer == questions[self.questionIndex].answer {
                                self.score += 1
                                self.correctMessage()
                            } else {
                                self.wrongMessage()
                            }
                        }) {
                            HStack {
                                Spacer()
                                Text("Submit answer")
                                Spacer()
                            }
                        }
                    } else {
                        Text("Score: \(score)")
                        Button(action: {
                            self.enteredAnswer = ""
                            self.questionIndex = 0
                            self.score = 0
                            self.gameStarted = false
                        }) {
                            HStack {
                                Spacer()
                                Text("New game")
                                Spacer()
                            }
                        }
                    }
                    
                    Spacer()
                }
            } else {
                SettingsView(gameStarted: $gameStarted)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(self.alertTitle), message: Text(self.alertMessage), dismissButton: .default(Text("OK")) {
                self.questionIndex += 1
                self.enteredAnswer = ""
            })
        }
    }
    
    func correctMessage() {
        alertTitle = "Bravo"
        alertMessage = "Correct!!! Going to the next question..."
        showAlert = true
    }
    
    func wrongMessage() {
        alertTitle = "Not good"
        alertMessage = "Wrong!!! Better luck next time... Going to the next question..."
        showAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
