//
//  EncryptionMethod.swift
//  HaqqEncryptionRN
//
//  Created by Andrey Makarov on 06.01.2023.
//  Copyright © 2023 Facebook. All rights reserved.
//

import Foundation

public enum EncryptionMethod: String, Codable {
    case js;
    case aes;
    case chacha;
}
