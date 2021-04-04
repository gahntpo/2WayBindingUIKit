//
//  ContentView.swift
//  DataFlowProject
//
//  Created by Karin Prater on 29.03.21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var text = "hello"
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Binding between property and ui control")
                .padding()
            
            HStack {
//                TextField("", text: $text) { (isChanged) in
//                    
//                } onCommit: {
//                   
//                }

                TextField("Placeholder", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    text = ""
                }) {
                    Text("clear")
                }
            }
            
            Text(text)
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
