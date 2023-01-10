import Foundation

@objc(HaqqEncryptionRN)
class HaqqEncryptionRN: NSObject {
    @objc
    public func encrypt(_ password: Optional<String>, data: Optional<String>, resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock) -> Void {
        do {
            guard let password = password, let data = data else {
                throw EncryptionError.params;
            }

            let encryption = Encryption(password: password)

            let encryptedResult = try encryption.encrypt( data);

            let jsonEncoder = JSONEncoder();

            guard let encode = try? jsonEncoder.encode(encryptedResult) else {
                throw EncryptionError.encodeJson;
            }

            guard let resp = String(data: encode, encoding: .utf8) else {
                throw EncryptionError.encodeJson;
            }

            resolve(resp);
        } catch {
            logger("encrypt \(error)")
            reject("0", "encrypt error", nil)
        }
    }

    @objc
    public func decrypt(_ password: Optional<String>, data: Optional<String>, resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock) -> Void {
        do {
            guard let password = password, let data = data else {
                throw EncryptionError.params;
            }

            let encryption = Encryption(password: password)

            guard let result = try? encryption.decrypt(data) else {
                throw EncryptionError.decrypt;
            }

            resolve(result);
        } catch {
            logger("decrypt \(error)")
            reject("0", "decrypt error", nil)
        }
    }
}
