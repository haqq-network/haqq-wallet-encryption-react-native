//
//  logger.swift
//  HaqqEncryptionRN
//
//  Created by Andrey Makarov on 06.01.2023.
//  Copyright © 2023 Facebook. All rights reserved.
//

import Foundation

public func logger(_ input: String) -> Void {
    let df = DateFormatter()
    df.dateFormat = "y-MM-dd HH:mm:ss.SSSSSS"
    print("\(df.string(from: Date())) \(input)")
}
