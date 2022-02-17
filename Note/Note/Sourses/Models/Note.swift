//
//  Note.swift
//  Note
//
//  Created by Татьяна Лузанова on 10.02.2022.
//

import Foundation
import UIKit

struct Note {
    let id: UUID
    var name: String
    var text: String
    let dateOfLastChange: Date
    var styleText: String
    var textColor: String
}
