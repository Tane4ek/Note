//
//  FontStyle.swift
//  Note
//
//  Created by Татьяна Лузанова on 16.02.2022.
//

import UIKit

enum FontStyle: String {
    case normal
    case bold
    case italic
    case name
    case title
    case subTitle
}

extension FontStyle {
    
    var font: UIFont {
        switch self {
        case .normal:
            return UIFont.systemFont(ofSize: 20)
        case .bold:
            return UIFont.systemFont(ofSize: 20, weight: .bold)
        case .italic:
            return UIFont.italicSystemFont(ofSize: 20)
        case .name:
            return UIFont.systemFont(ofSize: 24, weight: .bold)
        case .title:
            return UIFont.systemFont(ofSize: 22, weight: .bold)
        case .subTitle:
            return UIFont.systemFont(ofSize: 20, weight: .bold)
        }
    }
}
