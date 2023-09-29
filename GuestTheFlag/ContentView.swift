//
//  ContentView.swift
//  GuestTheFlag
//
//  Created by Aaron Brown on 9/27/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore: Bool = false
    @State private var scoreTitle: String = ""
    @State private var score: Int = 0
    @State private var countries: Array = ["Estonia", "France", "Germany", "Ireland","Italy", "Monaco", "Nigeria", "Poland", "Russia","Spain","UK", "US"].shuffled()
    
    @State private var correctAnswer: Int = Int.random(in: 0...2)
    
    func evaluateSelection(_ selection: Int) {
        if (selection == correctAnswer) {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
            if (score == 0) {
                score = 0
            } else {
                score -= 1
            }
        }
        showingScore.toggle()
    }
    
    func restartGame () {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                HStack() {
                    Spacer()
                    ZStack {
                        Circle()
                            .foregroundColor(.cyan)
                            .frame(width: 40)
                        Text(score, format: .number)
                            .foregroundColor(.white)
                            .font(.title2.weight(.bold))
                    }
                }
                .padding()
                Spacer()
                VStack(spacing: 30) {
                    
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.white)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { selection in
                        
                        Button {
                            evaluateSelection(selection)
                        } label: {
                            Image(countries[selection])
                                .renderingMode(.original)
                                .shadow(radius: 5)
                        }
                    }
                }
                Spacer()
                Spacer()
            }
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: restartGame)
            } message: {
                Text("Your score is \(score)")
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
