package com.example.platform_channel_demo

import android.content.Context
import android.os.BatteryManager
import android.os.Build
import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val BATTERY_CHANNEL = "com.example.platform_channel_demo/battery"
    private val CALCULATOR_CHANNEL = "com.example.platform_channel_demo/calculator"
    private val DEVICE_CHANNEL = "com.example.platform_channel_demo/device"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // BATTERY LEVEL CHANNEL
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            BATTERY_CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()
                Log.e("battery level", "$batteryLevel")
                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available", null)
                }
            }
        }

        // CALCULATOR CHANNEL
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CALCULATOR_CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "calculate") {
                val num1 = call.argument<Double>("num1") ?: 0.0
                val num2 = call.argument<Double>("num2") ?: 0.0
                val operation = call.argument<String>("operation") ?: "+"

                val calculatedResult = when (operation) {
                    "+" -> num1 + num2
                    "-" -> num1 - num2
                    "*" -> num1 * num2
                    "/" -> num1 / num2
                    else -> 0.0
                }

                result.success(calculatedResult)
            } else {
                result.notImplemented()
            }
        }

        // DEVICE INFO CHANNEL
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            DEVICE_CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "getDeviceInfo") {
                val deviceInfo = HashMap<String, Any>()
                deviceInfo["model"] = Build.MODEL
                deviceInfo["brand"] = Build.BRAND
                deviceInfo["androidVersion"] = Build.VERSION.RELEASE
                deviceInfo["sdkVersion"] = Build.VERSION.SDK_INT
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getBatteryLevel(): Int {
        val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
        return batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    }
}
