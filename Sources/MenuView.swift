//
//  MenuView.swift
//  CleanSlate
//
//  Created by Carlos Andres Chaguendo Sanchez on 9/06/22.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack {
            NavigationLink(destination: VoiceOverView()) {
                Text("Voice Over")
            }
            Spacer()
            Button("A") {
                
            }
        }.navigationTitle("Options")
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
