//
//  EncrytionError.swift
//  HaqqEncryptionRN
//
//  Created by Andrey Makarov on 06.01.2023.
//  Copyright © 2023 Facebook. All rights reserved.
//

import Foundation

public enum EncryptionError: Error {
    case randomKey;
    case pbfdk2;
    case keyFromPassword;
    case params;
    case encodeJson;
    case decodeJson;
    case decrypt;
}
