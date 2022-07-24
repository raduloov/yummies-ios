//
//  LoadingIndicator.swift
//  Yummies
//
//  Created by Yavor Radulov on 24.07.22.
//

import SwiftUI

struct LoadingIndicator: View {
    
    var text: String?
    var size: Double?
    
    var body: some View {
        ProgressView(text ?? "Loading...")
            .scaleEffect(size ?? 1)
            .font(.system(.body, design: .rounded))
    }
}

struct LoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicator(text: "Spinner", size: 2)
    }
}
