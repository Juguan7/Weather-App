//
//  LocationSearchView.swift
//  weather
//
//  
//

import SwiftUI

struct LocationSearchView: View {
    var body: some View {
        VStack{
            SearchBarView(text: .constant(""))
            Spacer()
        }
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView()
    }
}
