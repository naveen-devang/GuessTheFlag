//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Naveen Devang on 11/19/24.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var correctA = 0
    
    @State private var questionCounter = 1
    
    var body: some View {
        ZStack{
            MeshGradient(width: 2, height: 2 , points: [
                [0, 0], [1, 0],
                [0, 1], [1, 1]
            ], colors: [.blue, .black, .black, .blue])
                .ignoresSafeArea()
            VStack(spacing: 30){
                VStack {
                    Text("Tap the flag of")
                        .foregroundStyle(Color.white)
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .foregroundStyle(Color.white)
                        .font(.largeTitle.weight(.semibold))
                }
                
                ForEach(0..<3) { number in
                    Button{
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .clipShape(.rect(cornerRadius: 15))
                            .shadow(radius: 5)
                    }
                }
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            if questionCounter != 8 {
                Button("Continue", action: askQuestion)
            } else {
                Button("Restart", action: restartGame)
            }
        } message: {
            if questionCounter != 8 {
                Text("Your score is \(correctA)")
            } else {
                Text("You ended the game with a score of \(correctA). Press the restart button to restart the game.")
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            correctA = correctA + 1
        } else {
            scoreTitle = "Incorrect!! That's the flag of \(countries[number])"
            correctA = correctA
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCounter += 1
    }
    
    func restartGame() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCounter += 1
        correctA = 0
    }
}

#Preview {
    ContentView()
}
