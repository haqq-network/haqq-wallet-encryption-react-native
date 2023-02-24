[@haqq/encryption-react-native - v0.0.1](README.md) / Exports

# @haqq/encryption-react-native - v0.0.1

## Table of contents

### Functions

- [decrypt](modules.md#decrypt)
- [encrypt](modules.md#encrypt)

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

[native-modules.ts:42](https://github.com/haqq-network/haqq-wallet-encryption-react-native/blob/3468305/src/native-modules.ts#L42)

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

[native-modules.ts:27](https://github.com/haqq-network/haqq-wallet-encryption-react-native/blob/3468305/src/native-modules.ts#L27)
