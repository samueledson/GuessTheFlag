//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Samuel Edson on 11/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
        .shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreDescription = ""
    @State private var scoreLabel = "Continuar"
    
    @State private var score = 0
    @State private var totalQuestions = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Adivinha a Bandeira")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)

                VStack(spacing: 15) {
                    VStack {
                        Text("Toque na bandeira de:")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        
                        Text(countries[correctAnswer])
                            .foregroundStyle(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Pontuação: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button(scoreLabel, action: askQuestion)
        } message: {
            Text(scoreDescription)
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correto"
            score += 1
        } else {
            scoreTitle = "Errado"
            score -= 1
        }
        
        scoreDescription = "Sua pontuação é: \(score)"
        
        if number != correctAnswer {
            scoreDescription = "Essa é a bandeira da \(countries[number]) \n \(scoreDescription) "
        }

        totalQuestions += 1;
        
        if (totalQuestions == 8) {
            scoreLabel = "Recomeçar"
            scoreTitle = "\(scoreTitle) e Fim de Jogo!"
            askQuestion()
            score = 0;
        } else {
            scoreLabel = "Continuar"
        }
        
        showingScore = true
    }
}

#Preview {
    ContentView()
}
