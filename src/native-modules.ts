import {NativeModules, Platform} from 'react-native';

const LINKING_ERROR =
  `The package '@haqq/encryption-react-native' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ios: "- You have run 'pod install'\n", default: ''}) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const HaqqEncryptionRN = NativeModules.HaqqEncryptionRN
  ? NativeModules.HaqqEncryptionRN
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      },
    );

/**
 * Encrypts a JS object using a password (and AES encryption with native libraries)
 *
 * @param {string} password - Password used for encryption
 * @param {object} object - Data object to encrypt
 * @returns - Promise resolving to stringified data
 */
export async function encrypt<T extends object>(
  password: string,
  object: T,
): Promise<string> {
  return HaqqEncryptionRN.encrypt(password, JSON.stringify(object));
}

/**
 * Decrypts an encrypted JS object (encryptedString)
 * using a password (and AES decryption with native libraries)
 *
 * @param {string} password - Password used for decryption
 * @param {string} encryptedString - String to decrypt
 * @returns - Promise resolving to decrypted data object
 */
export async function decrypt<T extends object>(
  password: string,
  encryptedString: string,
): Promise<T> {
  return HaqqEncryptionRN.decrypt(password, encryptedString).then(
    (resp: string) => JSON.parse(resp),
  );
}
