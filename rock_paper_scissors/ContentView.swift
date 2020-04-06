//
//  ContentView.swift
//  rock_paper_scissors
//
//  Created by Lanre ESAN on 25/03/2020.
//  Copyright © 2020 tomisinesan.com. All rights reserved.
//

import SwiftUI

enum variable {
       case Rock
       case  Paper
       case Scissors
   }



struct ChoiceView : View {
    var val: variable
    
    var imageUrl: String {
        
        switch(val){
                           case variable.Rock: return "Rock"
                 
                           case variable.Paper : return "Paper"
                
                           case variable.Scissors : return "Scissors"
                     
                           }
    }
    
    var body : some View{
        Image(imageUrl).renderingMode(.original).resizable()
            .frame(width: 32.0, height: 32.0).clipShape(Capsule()).overlay(Capsule().stroke(Color.black, lineWidth: 1)).shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
     
     @State private var choices = [variable.Rock, variable.Paper, variable.Scissors].shuffled()
     @State private var choice = 0
     @State private var states = true
     @State private var score =  0
     @State private var count = 0
     @State private var present = false
    
    
   
    
    
    var body: some View {
        Form{
            
            Section(header:Text("Computer")) {
                Text("Computer wants you to \(states ? "Win" : "Lose")")
                ChoiceView(val: choices[0])
            }
            
            Section(header:Text("User")) {
                
                ForEach(0 ..< choices.count){
                    number in
                    Button(action:{
                        self.checkScore(number: number)
                    }){
                        ChoiceView(val: self.choices[number])
                    }
                }
            }
            
            Section(header:Text("Score")) {
                Text("Your total score is \(score) / \(count)")
            }
        }.alert(isPresented: $present){
            Alert(title: Text("Game over"), message: Text("Your final score is \(score)"),dismissButton: .default(Text("Play again")){
                self.refresh()
                })
        }
    }
    
    func Compiler(number:variable) -> Bool {
        if(choices[0] == variable.Rock){
                    switch(number){
                    case variable.Rock: return false
                    case variable.Paper : return true
                    case variable.Scissors : return false
                    }
                   }
        
       else  if(choices[0] == variable.Paper){
                           switch(number){
                           case variable.Rock: return false
              
                           case variable.Paper : return false
                      
                           case variable.Scissors : return true
                      
                           }
                          }
       else if(choices[0] == variable.Scissors){
                           switch(number){
                           case variable.Rock: return true
                 
                           case variable.Paper : return false
                        
                           case variable.Scissors : return false
                        
                 
                           }
                          }
        return false;
    }
    
    func checkScore(number:Int){
        let compile = Compiler( number: choices[number])
        
        if(states && compile || states == false && compile == false){
            score += 1
        }
        else if (states == false && compile == true || states && compile == false){
            score -= 1
        }
        
        count += 1
        
        if(count < 10){
            choices.shuffle()
            states = !states
        }
        else{
            present = true
        }
    }
    
    func refresh() {
        score = 0
        count = 0
    }
    

    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
