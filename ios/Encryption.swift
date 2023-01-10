//
//  Encryption.swift
//  HaqqEncryptionRN
//
//  Created by Andrey Makarov on 06.01.2023.
//  Copyright © 2023 Facebook. All rights reserved.
//


import Foundation
import CryptoSwift

public class Encryption {
    var password: [UInt8]

    init(password:String) {
        self.password = Array(password.utf8)
    }

    public func encrypt(_ data: String) throws -> EncryptedResult {
        guard let salt = randomKey(count: 16) else {
          throw EncryptionError.randomKey;
        }

        guard let key = try keyFromPassword(salt: salt) else {
          throw EncryptionError.keyFromPassword;
        }

        let result = try encryptWithKey(key: key, data: data);

        return EncryptedResult(cipher: result.0, iv: result.1, salt: salt, method: .chacha);
    }

    public func decrypt(_ data: String) throws -> String {
        let encryptedData = Data(data.utf8)
        let jsonDecoder = JSONDecoder()

        let decodedResult = try jsonDecoder.decode(EncryptedResult.self, from: encryptedData);
        guard let key = try keyFromPassword(salt: decodedResult.salt) else {
            throw EncryptionError.keyFromPassword;
        }

        guard let result = try decryptWithKey(key: key, cipher: decodedResult.cipher, iv: decodedResult.iv) else {
            throw EncryptionError.decrypt;
        }

        return result
    }

    func randomKey(count: Int) -> String? {
        var keyData = Data(count: count)
        let result = keyData.withUnsafeMutableBytes {
            SecRandomCopyBytes(kSecRandomDefault, 32, $0.baseAddress!)
        }
        if result == errSecSuccess {
            return keyData.base64EncodedString()
        } else {
            logger("Problem generating random bytes")
            return nil
        }
    }

    func encryptWithKey(key: [UInt8], data: String) throws -> (String, String) {
        let iv = ChaCha20.randomIV(12)
        let chacha = try ChaCha20(key: key, iv: iv)
        let cipher = try chacha.encrypt(Array(data.utf8))

        return (Data(cipher).base64EncodedString(), Data(iv).base64EncodedString())
    }

    func decryptWithKey(key: [UInt8], cipher: String, iv: String) throws -> String? {
        let iv = Data(base64Encoded: iv, options: .ignoreUnknownCharacters)!;
        let chacha = try ChaCha20(key: key, iv: iv.bytes)
        let cipher = Data(base64Encoded: cipher, options: .ignoreUnknownCharacters)!
        let result = try chacha.decrypt(cipher.bytes);

        return String(data: Data(result), encoding: .utf8);
    }

    func keyFromPassword(salt: String) throws -> [UInt8]? {
        do {
            let salt: Array<UInt8> = Array(salt.utf8)

            let key = try PKCS5.PBKDF2(password: self.password, salt: salt, iterations: 4096, keyLength: 32, variant: .sha2(.sha256)).calculate()

            return key
        } catch {
            logger("keyFromPassword \(error)");

            return nil;
        }
    }
}
