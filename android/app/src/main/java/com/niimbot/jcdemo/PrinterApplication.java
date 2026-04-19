package com.niimbot.jcdemo;

import android.app.Application;
import android.content.Context;

/**
 * PrinterApplication - Application class for printer functionality
 */
public class PrinterApplication extends Application {
    private static PrinterApplication instance;

    @Override
    public void onCreate() {
        super.onCreate();
        instance = this;
    }

    public static PrinterApplication getInstance() {
        return instance;
    }

    public static Context getContext() {
        return instance.getApplicationContext();
    }
}
