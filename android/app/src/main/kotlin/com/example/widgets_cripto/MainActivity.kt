package com.example.widgets_cripto

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.example.widgets_cripto/widget")
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "refreshWidget" -> {
                        val intent = Intent(this, MySimpleWidget::class.java).apply {
                            action = "com.example.widgets_cripto.ACTION_REFRESH"
                        }
                        sendBroadcast(intent)
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
    }
}

