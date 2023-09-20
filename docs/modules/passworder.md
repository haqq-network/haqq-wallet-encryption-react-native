[@haqq/encryption-react-native - v0.0.4](../README.md) / [Exports](../modules.md) / passworder

# Namespace: passworder

## Table of contents

### Functions

- [decrypt](passworder.md#decrypt)
- [encrypt](passworder.md#encrypt)

## Functions

### decrypt

▸ **decrypt**<`T`\>(`password`, `encryptedString`): `Promise`<`T`\>

Decrypts an encrypted JS object (encryptedString)
using a password (and AES decryption with native libraries)

#### Type parameters

| Name | Type |
| :------ | :------ |
| `T` | extends `object` |

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `password` | `string` | Password used for decryption |
| `encryptedString` | `string` | String to decrypt |

#### Returns

`Promise`<`T`\>

- Promise resolving to decrypted data object

#### Defined in

[passworder.ts:69](https://github.com/haqq-network/haqq-wallet-encryption-react-native/blob/1082177/src/passworder.ts#L69)

___

### encrypt

▸ **encrypt**<`T`\>(`password`, `object`): `Promise`<`string`\>

Encrypts a JS object using a password (and AES encryption with native libraries)

#### Type parameters

| Name | Type |
| :------ | :------ |
| `T` | extends `object` |

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `password` | `string` | Password used for encryption |
| `object` | `T` | Data object to encrypt |

#### Returns

`Promise`<`string`\>

- Promise resolving to stringified data

#### Defined in

[passworder.ts:50](https://github.com/haqq-network/haqq-wallet-encryption-react-native/blob/1082177/src/passworder.ts#L50)
