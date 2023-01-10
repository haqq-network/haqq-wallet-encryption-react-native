//
//  EncryptedResult.swift
//  HaqqEncryptionRN
//
//  Created by Andrey Makarov on 06.01.2023.
//  Copyright © 2023 Facebook. All rights reserved.
//

import Foundation

public struct EncryptedResult: Codable {
    var cipher: String
    var iv: String
    var salt: String;
    var method: EncryptionMethod;
}
