//
//  HorizontalAlignment.swift
//  ackee_ukol
//
//  Created by Jan Gutwirth on 06.07.2023.
//

import SwiftUI

extension HorizontalAlignment {
    struct HorizontalInfoAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.leading]
        }
    }

    static let horizontalInfoAlignment = HorizontalAlignment(HorizontalInfoAlignment.self)
}
