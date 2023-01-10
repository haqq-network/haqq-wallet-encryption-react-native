package haqq.encryptionrn

import java.util.*

fun ByteArray.toBase64(): String =
  String(Base64.getEncoder().encode(this))
