//
//  PullToRefresh.swift
//  Yummies
//
//  Created by Yavor Radulov on 27.07.22.
//

import SwiftUI

struct PullToRefresh: View {
    
    var coordinateSpaceName: String
    var onRefresh: () -> Void
    
    @State var needRefresh: Bool = false
    
    let haptics = UINotificationFeedbackGenerator()
    
    var body: some View {
        GeometryReader { geo in
            if (geo.frame(in: .named(coordinateSpaceName)).midY > 50) {
                Spacer()
                    .onAppear {
                        needRefresh = true
                    }
            } else if (geo.frame(in: .named(coordinateSpaceName)).maxY < 10) {
                Spacer()
                    .onAppear {
                        if needRefresh {
                            needRefresh = false
                            haptics.notificationOccurred(.success)
                            onRefresh()
                        }
                    }
            }
            HStack {
                Spacer()
                if needRefresh {
                    ProgressView()
                } else {
                    Image(systemName: "arrow.down")
                }
                Spacer()
            }
        }.padding(.top, -50)
    }
}

//struct PullToRefresh_Previews: PreviewProvider {
//    static var previews: some View {
//        PullToRefresh()
//    }
//}
