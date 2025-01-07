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
import android.content.pm.PackageInfo
import android.util.Log
import android.webkit.WebView

class MainActivity : FlutterFragmentActivity() {
    private val CHANNEL = "biometric_channel"
    private val UTILITYCHANNEL = "utility_channel"

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

         MethodChannel(flutterEngine.dartExecutor.binaryMessenger, UTILITYCHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "isWebViewEnabled") {
                val isEnabled = isWebViewEnabled(this)
                result.success(isEnabled)
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

    fun isWebViewEnabled(context: Context): Boolean {
        return try {
            val packageName = "com.google.android.webview"

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                // For Android 8.0 (API 26) and above
                val webViewPackage = try {
                    val method = WebView::class.java.getMethod("getCurrentWebViewPackage")
                    method.invoke(null) as? PackageInfo
                } catch (e: Exception) {
                    Log.e("WebViewCheck", "Reflection error: ${e.message}")
                    null
                }
                val webViewPackageName = webViewPackage?.packageName
                Log.d("WebViewCheck", "Current WebView Package: $webViewPackageName")
                webViewPackageName == packageName
            } else {
                // For Android 5.0 (API 21) to Android 7.1 (API 25)
                val packageInfo = try {
                    context.packageManager.getPackageInfo(packageName, 0)
                } catch (e: PackageManager.NameNotFoundException) {
                    Log.e("WebViewCheck", "Android System WebView is not installed.")
                    null
                }
                packageInfo?.applicationInfo?.enabled == true
            }
        } catch (e: Exception) {
            Log.e("WebViewCheck", "Error checking WebView status: ${e.message}")
            false
        }
    }
}
