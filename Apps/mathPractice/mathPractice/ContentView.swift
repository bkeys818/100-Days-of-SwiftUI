//
//  ContentView.swift
//  mathPractice
//
//  Created by Benjamin Keys on 5/2/20.
//  Copyright © 2020 Ben Keys. All rights reserved.
//
import SwiftUI

class ColorStore: ObservableObject {
    @Published var gradient: Gradient
    
    init(gradient: Gradient) {
        self.gradient = gradient
    }
}
struct thisButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [.green, Color("darkGreen")]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
            .padding(.horizontal, 30)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct ContentView: View {
    @State private var startMenu = true
    @State private var showCorrections = false
    
    private var difficultyList = ["Easy", "Medium", "Hard"]
    @State private var difficultyLevel = 0
    @State private var questionCount = [10, 20, 30]
    
    @State private var questions  = [[Int]]()
    @State private var answers = [String]()
    @State private var rightOrWrong = [Bool]()
    
    @State private var buttonLabel = "Start Game"
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color("teal"), .blue]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                if startMenu {
                    VStack{
                        Text("Multiplication Practice")
                            .font(.largeTitle)
                            .fontWeight(.medium)
                            .padding(.bottom, 40)
                        
                        Section(header: Text("Select a Difficulty").font(.title)) {
                            Picker("Example Label", selection: $difficultyLevel){
                                ForEach(0..<difficultyList.count) {
                                    Text("\(self.difficultyList[$0])")
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                            
                        .padding(.horizontal)
                        
                        Button(buttonLabel){
                            self.questions.append(contentsOf: self.createQuestion())
                            for _ in 1...self.questionCount[self.difficultyLevel] {
                                self.answers.append(contentsOf: [""])
                                self.rightOrWrong.append(contentsOf: [false])
                            }
                            self.buttonLabel = "Check Work"
                            self.startMenu.toggle()
                        }
                        .buttonStyle(thisButtonStyle())
                        .font(.title)
                        .frame(maxWidth: 275)
                        .padding(.top, 50)
                        Spacer()
                    }
                } else {
                    ScrollView{
                        VStack{
                            ForEach(0..<questionCount[difficultyLevel]){ number in
                                HStack{
                                    Group{
                                        Text("\(number + 1). ")
                                            .fontWeight(.medium)
                                            .multilineTextAlignment(.trailing)
                                        Text("\((self.questions[number])[0])")
                                        Image(systemName: "multiply")
                                        Text("\((self.questions[number])[1])")
                                        Image(systemName: "equal")
                                    }
                                    .font(.title)
                                    Group{
                                        TextField("?", text: self.$answers[number])
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .keyboardType(.numberPad)
                                            .font(.title)
                                            .frame(width: 180.0)
                                            .padding(.trailing)
                                        if self.showCorrections {
                                            if self.rightOrWrong[number] {
                                                Image(systemName: "checkmark")
                                                    .foregroundColor(Color("darkGreen"))
                                                    .font(Font.title.weight(.black))
                                                    .transition(.scale)
                                            } else {
                                                Image(systemName: "xmark")
                                                    .foregroundColor(.red)
                                                    .font(Font.title.weight(.black))
                                                    .transition(.scale)
                                            }
                                        }
                                    }
                                }
                            }
                            Button("\(buttonLabel)"){
                                if self.buttonLabel == "Play Again" {
                                    self.resetGame()
                                } else {
                                    self.checkAnswer()
                                }
                            }
                            .buttonStyle(thisButtonStyle())
                            .font(.headline)
                            .frame(maxWidth: 200)
                            .padding()
                        }
                    }
                    .frame(maxWidth:.infinity)
                }
            }
        }
    }
    func createQuestion() -> [[Int]] {
        var questionList = [[Int]]()
        questionExistLoop: repeat {
            let question = [Int.random(in: 1...12), Int.random(in: 1...12)]
            if questionList.contains(question) == false {
                questionList.append(contentsOf: [question])
            }
        } while questionList.count < questionCount[difficultyLevel]
        return questionList
    }
    func checkAnswer() {
        for i in 0...(questionCount[difficultyLevel] - 1) {
            let thisQuestion = questions[i]
            let thisAnswer = Int(answers[i]) ?? 0
            let correct = thisAnswer == (thisQuestion[0] * thisQuestion[1])
            rightOrWrong[i] = correct ? true : false
        }
        withAnimation(.easeInOut(duration: 0.25)) {
            self.showCorrections = true
        }
        if rightOrWrong.contains(false) == false {
            buttonLabel = "Play Again"
        }
    }
    func resetGame() {
        buttonLabel = "Start game"
        startMenu = true
        questions.removeAll()
        answers.removeAll()
        rightOrWrong.removeAll()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
