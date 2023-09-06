package tripletriolimited.distributor

import android.os.Messenger
import android.content.Context
import android.content.ContextWrapper
import android.content.IntentFilter
import android.os.BatteryManager
import android.view.WindowManager.LayoutParams
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import android.content.Intent
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES

class MainActivity: FlutterActivity() {
    private val METHOD_CHANNEL_NAME = "tech.ddsolutions.app/method"

    private val BATTERY_CHANNEL_NAME = "tech.ddsolutions.app/battery"

    private val NETWORK_CONNECTIVITY_CHANNEL_NAME = "tech.ddsolutions.app/network"

    private val PRINT_CHANNEL_NAME = "tech.ddsolutions.app/print"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        window.addFlags(LayoutParams.FLAG_SECURE)
        super.configureFlutterEngine(flutterEngine)

        //Setup channels
        setupChannels(this, flutterEngine.dartExecutor.binaryMessenger)
    }

    override fun onDestroy(){
        teardownChannels()
       super.onDestroy();
    }

    private fun setupChannels(context: Context, messenger: BinaryMessenger){
        print("---in setup channels---")
    }

    private fun teardownChannels(){
        print("---teardown channels---")
    }

    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }

        return batteryLevel
    }


}