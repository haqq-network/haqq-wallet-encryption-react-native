package haqq.encryptionrn

import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.Promise
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json

class HaqqEncryptionRNModule(reactContext: ReactApplicationContext) :
  ReactContextBaseJavaModule(reactContext) {

  override fun getName(): String {
    return NAME
  }

  companion object {
    const val NAME = "HaqqEncryptionRN"
  }

  @ReactMethod
  fun encrypt(password: String, data: String, promise: Promise) {
    val encryption = Encryption(password);
    val encrypted = encryption.encrypt(data);

    if (encrypted == null) {
      promise.reject("0", "encrypt")
    }

    val result = Json.encodeToString(encrypted);
    promise.resolve(result)

  }

  @ReactMethod
  fun decrypt(password: String, data: String, promise: Promise) {
    val encryption = Encryption(password);
    val decrypted = encryption.decrypt(data);

    if (decrypted == null) {
      promise.reject("0", "decrypt")
    }

    promise.resolve(decrypted)
  }
}
