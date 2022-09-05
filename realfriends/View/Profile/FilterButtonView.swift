//
//  FilterButtonView.swift
//  realfriends
//
//  Created by John McCants on 7/30/22.
//

import SwiftUI

enum WinFilterOptions: Int, CaseIterable {
    case wins
    case respects
    
    var title: String {
        switch self {
        case .wins: return "Wins"
        case .respects: return "Respects"
        }
    }
}

struct FilterButtonView: View {
    @Binding var selectedOption: WinFilterOptions
    
    private let underlineWidth = UIScreen.main.bounds.width / CGFloat(WinFilterOptions.allCases.count)
    
    private var padding: CGFloat {
        let rawValue = CGFloat(selectedOption.rawValue)
        let count = CGFloat(WinFilterOptions.allCases.count)
        return ((UIScreen.main.bounds.width / count) * rawValue) + 16
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ForEach(WinFilterOptions.allCases, id: \.self) {  option in
                    Button(action: {
                        self.selectedOption = option
                    }, label: {
                        Text(option.title)
                            .frame(width: underlineWidth - 8)
                    })
                    
                    
                    
                }
            }
            
            Rectangle()
                .frame(width: underlineWidth - 24, height: 3, alignment: .center)
                .foregroundColor(.blue)
                .padding(.leading, padding)
                .animation(.spring())
            
        }
    }
}

struct FilterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FilterButtonView(selectedOption: .constant(.wins))
    }
}
