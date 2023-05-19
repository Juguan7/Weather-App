//
//  SearchBarView.swift
//  weather
//
//  
//

import SwiftUI

struct SearchBarView: View {
    
    
    @Binding var text: String
 
    @State private var isEditing = false
    
    @FocusState private var isFocused: Bool
 
    var body: some View {
        HStack {
 
            TextField("Search ...", text: $text)
                .focused(($isFocused))
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
//                .onTapGesture {
//                    self.isEditing = true
//                }
 
            if isFocused {
                Button(action: {
                    //self.isEditing = false
                    self.text = ""
                    isFocused = false
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(text: .constant(""))
    }
}
