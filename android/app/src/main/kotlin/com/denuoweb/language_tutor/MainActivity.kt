package com.denuoweb.language_tutor

import androidx.activity.ComponentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    private val rayBanBridge = RayBanBridge()

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        rayBanBridge.register(this as ComponentActivity, flutterEngine)
    }
}
