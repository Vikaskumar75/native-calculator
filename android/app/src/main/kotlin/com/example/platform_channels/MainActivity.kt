package com.example.platform_channels

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel



class MainActivity: FlutterActivity() {
    private  val CHANNEL = "flutter.dev.calculator";
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger,CHANNEL).setMethodCallHandler(){
            call, result ->
          val numbers =  call.arguments as ArrayList<Int>

            when (call.method) {
                "add" -> {
                    result.success(add(numbers))
                }
                "multiply"-> {
                    result.success(multiply(numbers))
                }
                "divide" -> {
                    result.success(divide(numbers))
                }
                "subtract" -> {
                    result.success(subtract(numbers))
                }
            }

        }
    }

    private fun add(x: ArrayList<Int>): Int {
       return  x[0]+x[1]
    }

    private fun subtract(x: ArrayList<Int>): Int {
        return  x[0]-x[1]
    }

    private fun multiply(x: ArrayList<Int>): Int {
        return  x[0]*x[1]
    }

    private fun divide(x: ArrayList<Int>): Int {
        return  x[0]/x[1]
    }
}
