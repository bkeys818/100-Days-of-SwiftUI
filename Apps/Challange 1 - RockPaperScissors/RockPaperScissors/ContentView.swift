//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Benjamin Keys on 4/16/20.
//  Copyright © 2020 Ben Keys. All rights reserved.
//

import SwiftUI


struct formatText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color("Text Color"))
            .font(.largeTitle)
            .multilineTextAlignment(.center)
    }
}


struct ContentView: View {
    let answers = ["Rock", "Paper", "Scisors"]
    @State private var correctAnswer = Int.random(in: 0..<3)
    
    @State private var alertShowing = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var alertButton = ""
    
    @State private var roundCount = 0
    @State private var score = 0
        
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color("Background Color 1"), Color("Background Color 2")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack{
                Text("Round \(roundCount)/10")
                    .modifier(formatText())
                    .padding(.bottom, 10.0)

                
                Text("Score: \(score)")
                    .font(.title)
                    .frame(width: 200.0)
                    .modifier(formatText())
                    .padding(.bottom, 15.0)

                

                ForEach(0..<answers.count){number in
                    Button(action: {
                        self.clickButton(number)
                    }) {
                        Text(self.answers[number])
                            .fontWeight(.semibold)
                            .frame(width: 150.0, height: 50.0)
                        
                    }
                    .background(Color("Button Color"))
                    .foregroundColor(Color("Text Color"))
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .clipShape(Capsule())
                    .overlay(Capsule()
                    .stroke(Color("Outline Color"), lineWidth: 3))
                    .padding(.bottom, 20.0)
                }
                Spacer()
            }
        }
                
        .alert(isPresented: $alertShowing) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text(alertButton)){
            })
        }
    }
        
    func clickButton(_ button: Int) {
        switch roundCount {
            case 0..<10:
                if button == correctAnswer {
                    alertTitle = "You Win!"
                    score += 1
                } else {
                    alertTitle = "You Lose!"
                }
                alertMessage = "You won \(score)/10 rounds"
                alertButton = "Next Round"
                alertShowing = true
                resetRound()
            case 10:
                alertTitle = "Game Over"
                if score < 5 {
                    alertMessage = "You Lose!"
                } else if score == 5 {
                    alertMessage = "It's a tie!"
                } else if score < 5 {
                    alertMessage = "You win!"
                }
                alertButton = "Play Again"
                alertShowing = true
                resetGame()
            default:
                return
        }
    }
        
    func resetRound() {
        roundCount += 1
        correctAnswer = Int.random(in: 0..<3)
    }
    func resetGame() {
        roundCount = 0
        score = 0
        correctAnswer = Int.random(in: 0..<3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
