//
//  ContentView.swift
//  EcoGive
//
//  Created by oumayma cherif on 24/11/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View{
        NavigationStack {
            VStack {
                NavigationLink {
                    Text ("new view")
                } label: {
            Image(systemName:"globle").imageScale(.medium).foregroundColor(.accentColor)
                    Text("hello, world ")
                  }
                  }
            .padding()
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
