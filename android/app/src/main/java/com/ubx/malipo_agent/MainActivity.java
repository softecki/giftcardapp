package com.ubx.malipo_agent;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import com.niimbot.jcdemo.PrinterChannel;

public class MainActivity extends FlutterActivity {
    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        
        // Register the printer channel
        flutterEngine.getPlugins().add(new PrinterChannel());
    }
}
