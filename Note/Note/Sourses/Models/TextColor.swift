//
//  TextColor.swift
//  Note
//
//  Created by Поздняков Игорь Николаевич on 17.02.2022.
//

import UIKit

enum TextColor: String {
    case normal
    case coral
}

extension TextColor {
    
    var color: UIColor {
        switch self {
        case .normal:
            return UIColor.black
        case .coral:
            return UIColor(named: "Coral") ?? UIColor.orange
        }
    }
}

