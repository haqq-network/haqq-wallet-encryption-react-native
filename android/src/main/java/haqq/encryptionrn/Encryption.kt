package haqq.encryptionrn

import android.os.Build
import java.security.NoSuchAlgorithmException
import java.security.SecureRandom
import javax.crypto.Cipher
import java.util.Base64
import kotlinx.serialization.Serializable
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json
import java.security.spec.KeySpec
import javax.crypto.SecretKey
import javax.crypto.SecretKeyFactory
import javax.crypto.spec.IvParameterSpec
import javax.crypto.spec.PBEKeySpec

@Serializable
data class EncryptedResult(val cipher: String, val iv: String, val salt: String, val method: String)


class Encryption {
  companion object {
    private val ENCRYPT_ALGO =
      if (Build.VERSION.SDK_INT >= 28) "ChaCha20-Poly1305" else "AES/CBC/PKCS7Padding"
    private val NONCE_LEN = if (Build.VERSION.SDK_INT >= 28) 12 else 16

    private fun chaChaAvailable(algo: String): Boolean {
      return try {
        Cipher.getInstance(algo)
        true
      } catch (e: NoSuchAlgorithmException) {
        false
      }
    }

    fun getEncryptAlgo(): String {
      if (chaChaAvailable(ENCRYPT_ALGO)) {
        return ENCRYPT_ALGO
      }

      return "AES/CBC/PKCS7Padding"
    }

    private fun getNonceLen(): Int {
      if (chaChaAvailable(ENCRYPT_ALGO)) {
        return NONCE_LEN
      }

      return 16
    }

    fun getNonce(): ByteArray {
      val nonce = ByteArray(getNonceLen())
      SecureRandom().nextBytes(nonce)
      return nonce
    }
  }

  private var _password: CharArray;

  constructor(password: String) {
    _password = password.toCharArray()
  }

  fun encrypt(data: String): EncryptedResult? {
    val salt: ByteArray = randomKey(16)
    val nonce = getNonce();
    val key = keyFromPassword(salt)

    key?.let {
      val encrypted = encryptWithKey(key, data, nonce);

      return EncryptedResult(
        cipher = encrypted.toBase64(),
        iv = nonce.toBase64(),
        salt = salt.toBase64(),
        method = "chacha"
      )
    }

    return null
  }

  fun decrypt(data: String): String? {
    val obj = Json.decodeFromString<EncryptedResult>(data)

    keyFromPassword(Base64.getDecoder().decode(obj.salt))?.let { key ->
      decryptWithKey(key, obj.cipher, Base64.getDecoder().decode(obj.iv))?.let { resp ->
        return resp.toString(Charsets.UTF_8)
      }
    }

    return null
  }

  private fun keyFromPassword(salt: ByteArray): SecretKey? {
    val algorithm = "PBKDF2withHmacSHA256"

    val derivedKeyLength = 256

    val iterations = 4096

    val spec: KeySpec = PBEKeySpec(_password, salt, iterations, derivedKeyLength)

    val f: SecretKeyFactory = SecretKeyFactory.getInstance(algorithm)

    return f.generateSecret(spec)
  }

  private fun randomKey(len: Int): ByteArray {
    val random: SecureRandom = SecureRandom.getInstance("SHA1PRNG")

    val key = ByteArray(len)
    random.nextBytes(key)

    return key
  }

  private fun encryptWithKey(key: SecretKey, data: String, nonce: ByteArray): ByteArray {
    val cipher: Cipher = Cipher.getInstance(getEncryptAlgo())

    val iv = IvParameterSpec(nonce)
    cipher.init(Cipher.ENCRYPT_MODE, key, iv)

    return cipher.doFinal(data.toByteArray())
  }

  private fun decryptWithKey(key: SecretKey, data: String, nonce: ByteArray): ByteArray? {
    val cipher = Cipher.getInstance(getEncryptAlgo())

    val iv = IvParameterSpec(nonce)

    cipher.init(Cipher.DECRYPT_MODE, key, iv)

    val data = Base64.getDecoder().decode(data)

    return cipher.doFinal(data)
  }
}
