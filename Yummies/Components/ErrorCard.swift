//
//  ErrorCard.swift
//  Yummies
//
//  Created by Yavor Radulov on 26.07.22.
//

import SwiftUI

struct ErrorCard: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color.white.opacity(0.7))
            .overlay {
                VStack {
                    VStack {
                        Text("Oops.. Something went wrong 💔")
                            .font(.system(.title2, design: .rounded))
                        Text("Please try again in a few moments :)")
                            .font(.system(.title3, design: .rounded))
                            .padding(.top, 5)
                    }
                    .padding()
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }) {
                        HStack {
                            Image(systemName: "arrow.counterclockwise")
                            Text("Try again")
                        }
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.medium)
                        .foregroundColor(Color.black)
                    }
                    .buttonStyle(.bordered)
                    .padding()
                }
            }
            .frame(width: 350, height: 200)
    }
}

struct ErrorCard_Previews: PreviewProvider {
    static var previews: some View {
        ErrorCard()
    }
}
