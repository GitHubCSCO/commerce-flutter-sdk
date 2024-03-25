package com.dxp.commerce

import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import androidx.biometric.BiometricManager
import androidx.biometric.BiometricPrompt
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {
    private val CHANNEL = "biometric_channel"

    @RequiresApi(Build.VERSION_CODES.M)
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getBiometricType") {
                val biometricType = getBiometricType(this)
                result.success(biometricType)
            } else {
                result.notImplemented()
            }
        }
    }

    @RequiresApi(Build.VERSION_CODES.M)
    private fun getBiometricType(context: Context): String {
        val biometricManager = BiometricManager.from(context)

        return when (biometricManager.canAuthenticate()) {
            BiometricManager.BIOMETRIC_SUCCESS -> {
                val packageManager = context.packageManager
                
                if (packageManager.hasSystemFeature(PackageManager.FEATURE_FINGERPRINT)) {
                    "Fingerprint"
                }
                else {
                    "Unknown"
                }
            }
            BiometricManager.BIOMETRIC_ERROR_NO_HARDWARE -> "No biometric hardware"
            BiometricManager.BIOMETRIC_ERROR_HW_UNAVAILABLE -> "Biometric hardware unavailable"
            BiometricManager.BIOMETRIC_ERROR_NONE_ENROLLED -> "No biometric enrolled"
            else -> "Unknown"
        }
    }
}
