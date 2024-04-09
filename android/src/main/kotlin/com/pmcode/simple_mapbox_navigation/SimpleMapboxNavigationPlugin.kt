package com.pmcode.simple_mapbox_navigation

import android.content.Context
import android.content.Intent
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class SimpleMapboxNavigationPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {

    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        channel = MethodChannel(binding.binaryMessenger, "simple_mapbox_navigation")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "startNavigation" -> {
                val startLat = call.argument<Double>("startLat")
                val startLng = call.argument<Double>("startLng")
                val endLat = call.argument<Double>("endLat")
                val endLng = call.argument<Double>("endLng")
                if (startLat != null && startLng != null && endLat != null && endLng != null) {
                    startNavigation(TurnByTurnExperienceActivity::class.java, startLat, startLng,endLat,endLng)
                    result.success(null)
                } else {
                    result.error("MISSING_ARGUMENTS", "Latitude or longitude missing", null)
                }
            }

            else -> result.notImplemented()
        }
    }

    private fun startNavigation(activityClass: Class<*>, startLat: Double, startLng: Double,endLat: Double,endLng: Double) {
        val intent = Intent(context, activityClass)
        intent.putExtra("startLat", startLat)
        intent.putExtra("startLng", startLng)
        intent.putExtra("endLat", endLat)
        intent.putExtra("endLng", endLng)
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        context.startActivity(intent)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}