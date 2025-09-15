package com.example.clean_arch

import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    private val CHANNEL = "error_channel"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
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
    }
}
