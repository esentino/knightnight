//
//  ContentView.swift
//  knightnight
//
//  Created by Janusz Janowski on 21/09/2024.
//

import SwiftUI

struct CommonWork: Identifiable {
    let name: String
    let level: Int = 0
    let income_per_day: Int
    let id = UUID()
}

var beggar = CommonWork(name: "Beggar", income_per_day: 1)
var farmer = CommonWork(name: "Farmer", income_per_day: 5)

struct Skill: Identifiable {
    let name: String
    let level: Int = 0
    let exp_per_day: Int
    let id = UUID()
}

var concentration = Skill(name: "Concentration", exp_per_day: 1)
var productivity = Skill(name: "Productivity", exp_per_day: 1)

struct ContentView: View {
    private var year: Int = 14
    private var day: Int = 1
    private var lifespan: Int = 70
    @State private var coper: Int = 0
    private var silver: Int = 0
    private var gold: Int = 0
    private var platine: Int = 0
    
    private var net_day: String = "0c"
    private var income_day: String = "0c"
    private var expense_day: String = "0c"
    
    @State var class_progress_view: Float = 0
    @State var CommonWorks: Array<CommonWork> = [
        beggar,
        farmer
    ]
    @State var selected_class: CommonWork? = nil
    let timer = Timer.publish(every: 1, on:.current, in: .common).autoconnect()
    @State var Skills: Array<Skill> = [
        concentration,
        productivity
    ]
    var body: some View {
        VStack{
            HStack {
                VStack(alignment: .leading){
                    Text("Age \(year) Day \(day)")
                    Text("Lifespan: \(lifespan) years")
                    Text("\(platine)p \(gold)s \(silver)s \(coper)c")
                    Text("Net/day: \(net_day)")
                    Text("Income/day: \(income_day)")
                    Text("Expense/day: \(expense_day)")
                }
                VStack(alignment: .leading){
                    ProgressView(value: class_progress_view, total: 100).onReceive(timer, perform: { benc in 
                        

                        
                    })
                    Text("Current class")
                    ProgressView(value: 0, total: 100)
                    Text("Current skill")
                    
                }
            }
            Table(CommonWorks){
                TableColumn("Name") {
                    customer in Button(action: {selected_class = customer}, label: {
                            Text(customer.name)
                        }
                    )
                }
                TableColumn("Level"){
                    customer in Text("\(customer.level)")
                }
                TableColumn("Income per day"){
                    customer in Text("\(customer.income_per_day)")
                }
            }
            Table(Skills) {
                TableColumn("Name"){
                    skill in Button(action:{}, label: {Text(skill.name)})
                }
            }
        }.onReceive(timer){
            _ in
            self.coper = (selected_class?.income_per_day ?? 0) + self.coper
            class_progress_view = class_progress_view + Float(selected_class?.income_per_day ?? 0)
        }
    }
}

#Preview {
    ContentView()
}
