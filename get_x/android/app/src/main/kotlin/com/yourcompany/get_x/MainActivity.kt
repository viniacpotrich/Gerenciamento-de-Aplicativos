package com.yourcompany.get_x

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.widget.Toast

class MainActivity : FlutterActivity() {
    private val ERRORCHANNEL = "error_channel"
    private val TOASTCHANNEL = "toast_channel"
    
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Canal de erro
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, ERRORCHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "throwError" -> {
                    try {
                        throw RuntimeException("This is a Kotlin error!")
                    } catch (e: Exception) {
                        result.error("KOTLIN_ERROR", e.message, null)
                    }
                }
                else -> result.notImplemented()
            }
        }

        // Canal de toast
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, TOASTCHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "showToast" -> {
                    val message = call.argument<String>("message")
                    Toast.makeText(this, message ?: "Mensagem vazia", Toast.LENGTH_SHORT).show()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }
}
