package com.pmcode.mapbox_navigation

import android.content.Context
import android.content.Intent
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class MapboxNavigationPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {

    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        channel = MethodChannel(binding.binaryMessenger, "mapbox_navigation")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "startNavigation" -> {
                val start_lat = call.argument<Double>("start_lat")
                val start_lng = call.argument<Double>("start_lng")
                val end_lat = call.argument<Double>("end_lat")
                val end_lng = call.argument<Double>("end_lng")
                if (start_lat != null && start_lng != null && end_lat != null && end_lng != null) {
                    startNavigation(TurnByTurnExperienceActivity::class.java, start_lat, start_lng,end_lat,end_lng)
                    result.success(null)
                } else {
                    result.error("MISSING_ARGUMENTS", "Latitude or longitude missing", null)
                }
            }

            else -> result.notImplemented()
        }
    }

    private fun startNavigation(activityClass: Class<*>, start_lat: Double, start_lng: Double,end_lat: Double,end_lng: Double) {
        val intent = Intent(context, activityClass)
        intent.putExtra("start_lat", start_lat)
        intent.putExtra("start_lng", start_lng)
        intent.putExtra("end_lat", end_lat)
        intent.putExtra("end_lng", end_lng)
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        context.startActivity(intent)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}