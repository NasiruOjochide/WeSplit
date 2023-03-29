//
//  ContentView.swift
//  WeSplit
//
//  Created by Danjuma Nasiru on 23/12/2022.
//

import SwiftUI
// lets quickly note that swiftui does not allow us have more than 10 contents in any view struct, for example, form below can only have maximum of 10 views within it. if you want more, place the views in groups/sections as shown
//we also add a navigation view so that we can have a navigation bar at the top so when we scroll, our content does not overlap with the iphones ui like the clock. Instead it just scrolls underneath the navigation bar.
struct ContentView: View {
    //@state is used for a property that is used in one view and not shared acorss views. so swiftui requires us to add private just to indicate that
//    @State private var name = ""
//
//
//    @State private var tapCount = 0
//
//
//    let students = ["Harry", "Hermione", "Ron"]
//    @State private var selectedStudent = "Harry"
    
    //day 17 part, the main project work
    @State private var checkAmount = 0.0
    @State private var noOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    //the @focusstate is just like the @state but this helps to check if our ui, a text field for example is in focus
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPlusTip : Double {
        let tipAmount = checkAmount * Double(tipPercentage) / 100
        return checkAmount + (tipAmount)
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(noOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    
    var currency : FloatingPointFormatStyle<Double>.Currency {
        .currency(code: Locale.current.currencyCode ?? "NGN")
    }
    //day 17 end here
    
    var body: some View {
        
        //adding a navigation bar
//        NavigationView{
//            Form{
//                Section{
//                    Text("Hello, world!")
//                    Text("Hello, world!")
//                }
//                Section{
//                    Text("Hello, world!")
//                    Text("Hello, world!")
//                    Text("hdgfsjk")
//                }
//            }
//            .navigationTitle("SwiftUI")
//            .navigationBarTitleDisplayMode(.inline)
//        }
        
        
        //modyfying program state
//        Button("Tap Count \(tapCount)"){tapCount += 1}
        
        
        //binding state to user interface controls
//        Form{
//            TextField("enter your name", text: $name)
//            Text("Your name is: \(name)")
//        }
        
        
        //creating views with a loop
//        NavigationView{
//            Form{
//                //ForEach(0..<50){Text("Row: \($0)")}
//                Picker("Select your student", selection: $selectedStudent, content: {ForEach(students,id: \.self, content: {Text($0)})})
//            }
//        }
        
        NavigationView {
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "NGN"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    //this text field uses the value paramter bcos we're not taking in text. also the local.current.currencycode is inbuilt in ios and helps us get the user's currency base on various checks. if its not available, use USD.
                    Picker("Number of people", selection: $noOfPeople, content: {
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    })
                } header: {
                    Text("Amount Charged")
                }
                Section{
                    Picker("Tip Percentage", selection: $tipPercentage, content: {
                        ForEach(0...100, id: \.self, content: {
                            Text($0, format: .percent)
                        })
                    })
                    .pickerStyle(.automatic)
                } header: {
                    Text("How much do you want to leave")
                }
                
                Section{
                    Text(totalPlusTip, format: currency).foregroundColor(tipPercentage == 0 ? .red : .primary)
                } header: {
                    Text("Total amount plus tip")
                }
                
                Section {
                    Text(totalPerPerson, format: currency)
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{ToolbarItemGroup(placement: .keyboard){
                Spacer()
                Button("Done", action: {amountIsFocused  = false})
            }
            }//The toolbar() modifier lets us specify toolbar items for a view. These toolbar items might appear in various places on the screen – in the navigation bar at the top, in a special toolbar area at the bottom, and so on.
            //ToolbarItemGroup lets us place one or more buttons in a specific location, and this is where we get to specify we want a keyboard toolbar – a toolbar that is attached to the keyboard, so it will automatically appear and disappear with the keyboard.
            //The Button view we’re using here displays some tappable text, which in our case is “Done”. We also need to provide it with some code to run when the button is pressed, which in our case sets amountIsFocused to false so that the keyboard is dismissed.
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
