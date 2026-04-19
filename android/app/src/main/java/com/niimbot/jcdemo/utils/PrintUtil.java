package com.niimbot.jcdemo.utils;

import android.content.Context;
import android.graphics.Bitmap;
import android.os.Handler;
import android.util.Log;

import com.gengcon.www.jcprintersdk.JCPrintApi;
import com.gengcon.www.jcprintersdk.callback.Callback;
import com.gengcon.www.jcprintersdk.callback.PrintCallback;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * PrintUtil - Simplified version for Flutter integration
 * Provides essential printer functionality for the Flutter app
 */
public class PrintUtil {
    private static final String TAG = "PrintUtil";
    private static int mConnectedType = -1;
    private static volatile JCPrintApi api;
    private static Context applicationContext;

    /**
     * Initialize the printer SDK
     */
    public static void initSdk(Context context) {
        applicationContext = context;
        if (api == null) {
            synchronized (PrintUtil.class) {
                if (api == null) {
                    api = JCPrintApi.getInstance(CALLBACK);
                    // Cast context to Application if it's an Application context
                    if (context instanceof android.app.Application) {
                        api.initSdk((android.app.Application) context);
                    } else {
                        // Use the application context
                        api.initSdk((android.app.Application) context.getApplicationContext());
                    }
                }
            }
        }
    }

    /**
     * Callback interface for printer events
     */
    private static final Callback CALLBACK = new Callback() {
        @Override
        public void onConnectSuccess(String address, int type) {
            mConnectedType = type;
            Log.d(TAG, "Connected to printer: " + address + ", type: " + type);
        }

        @Override
        public void onDisConnect() {
            mConnectedType = -1;
            Log.d(TAG, "Printer disconnected");
        }

        @Override
        public void onElectricityChange(int powerLevel) {
            Log.d(TAG, "Battery level: " + powerLevel);
        }

        @Override
        public void onCoverStatus(int coverStatus) {
            Log.d(TAG, "Cover status: " + coverStatus);
        }

        @Override
        public void onPaperStatus(int paperStatus) {
            Log.d(TAG, "Paper status: " + paperStatus);
        }

        @Override
        public void onRfidReadStatus(int rfidReadStatus) {
            Log.d(TAG, "RFID read status: " + rfidReadStatus);
        }

        @Override
        public void onRibbonRfidReadStatus(int ribbonRfidReadStatus) {
            Log.d(TAG, "Ribbon RFID read status: " + ribbonRfidReadStatus);
        }

        @Override
        public void onRibbonStatus(int ribbonStatus) {
            Log.d(TAG, "Ribbon status: " + ribbonStatus);
        }

        @Override
        public void onFirmErrors() {
            Log.d(TAG, "Firmware error detected");
        }
    };

    /**
     * Get JCPrintApi singleton instance
     */
    public static JCPrintApi getInstance() {
        if (api == null) {
            throw new IllegalStateException("PrintUtil not initialized. Call initSdk() first.");
        }
        return api;
    }

    /**
     * Connect to Bluetooth printer
     */
    public static boolean connectBluetooth(String address) {
        try {
            // Validate address
            if (address == null || address.trim().isEmpty()) {
                Log.e(TAG, "Bluetooth address is null or empty");
                return false;
            }
            
            JCPrintApi localApi = getInstance();
            String cleanAddress = address.trim();
            Log.d(TAG, "Attempting to connect to Bluetooth printer: " + cleanAddress);
            
            int result = localApi.connectBluetoothPrinter(cleanAddress);
            Log.d(TAG, "Bluetooth connection result: " + result);
            return result == 0;
        } catch (Exception e) {
            Log.e(TAG, "Bluetooth connection failed", e);
            return false;
        }
    }

    /**
     * Connect to WiFi printer
     */
    public static boolean connectWifi(String ipAddress) {
        try {
            // Validate IP address
            if (ipAddress == null || ipAddress.trim().isEmpty()) {
                Log.e(TAG, "WiFi IP address is null or empty");
                return false;
            }
            
            JCPrintApi localApi = getInstance();
            String cleanIp = ipAddress.trim();
            Log.d(TAG, "Attempting to connect to WiFi printer: " + cleanIp);
            
            // WiFi connection typically requires port number as second parameter
            // Using default port 9100 for most printers
            int result = localApi.connectWifiPrinter(cleanIp, 9100);
            Log.d(TAG, "WiFi connection result: " + result);
            return result == 0;
        } catch (Exception e) {
            Log.e(TAG, "WiFi connection failed", e);
            return false;
        }
    }

    /**
     * Disconnect from printer
     */
    public static void disconnect() {
        try {
            JCPrintApi localApi = getInstance();
            localApi.close();
        } catch (Exception e) {
            Log.e(TAG, "Disconnect failed", e);
        }
    }

    /**
     * Check if printer is connected
     */
    public static int isConnection() {
        try {
            JCPrintApi localApi = getInstance();
            return localApi.isConnection();
        } catch (Exception e) {
            Log.e(TAG, "Connection check failed", e);
            return -1;
        }
    }

    /**
     * Print status callback interface
     */
    public interface PrintStatusCallback {
        void onProgress(int pageIndex, int quantityIndex);
        void onError(int errorCode, int printState);
        void onCancelJob(boolean isSuccess);
        void onPrintComplete();
    }

    /**
     * Start label print job
     */
    public static void startLabelPrintJob(int copies, int density, int labelType, int mode,
                                        Handler handler, List<String> jsonList, List<String> infoList,
                                        PrintStatusCallback callback) {
        if (isConnection() != 0) {
            handler.post(() -> callback.onError(-1, 0));
            return;
        }

        AtomicInteger generatedPages = new AtomicInteger(0);
        AtomicBoolean isError = new AtomicBoolean(false);
        AtomicBoolean isCancel = new AtomicBoolean(false);
        int pages = jsonList.size();

        getInstance().setTotalPrintQuantity(pages * copies);

        getInstance().startPrintJob(density, labelType, mode, new PrintCallback() {
            @Override
            public void onProgress(int pageIndex, int quantityIndex, HashMap<String, Object> hashMap) {
                handler.post(() -> callback.onProgress(pageIndex, quantityIndex));
                if (pageIndex == pages && quantityIndex == copies) {
                    getInstance().endPrintJob();
                    handler.post(callback::onPrintComplete);
                }
            }

            @Override
            public void onError(int i) {
                // Single parameter error method - delegate to two parameter version
                onError(i, 0);
            }

            @Override
            public void onError(int errorCode, int printState) {
                isError.set(true);
                handler.post(() -> callback.onError(errorCode, printState));
            }

            @Override
            public void onCancelJob(boolean success) {
                isCancel.set(success);
                handler.post(() -> callback.onCancelJob(success));
            }

            @Override
            public void onBufferFree(int pageIndex, int bufferSize) {
                if (isError.get() || isCancel.get() || pageIndex > pages) return;

                int commitSize = Math.min(pages - generatedPages.get(), bufferSize);
                List<String> subJson = jsonList.subList(generatedPages.get(), generatedPages.get() + commitSize);
                List<String> subInfo = infoList.subList(generatedPages.get(), generatedPages.get() + commitSize);
                getInstance().commitData(subJson, subInfo);
                generatedPages.addAndGet(commitSize);
            }
        });
    }

    /**
     * Commit image data for printing
     */
    public static void commitImageData(int orientation, Bitmap bitmap, int width, int height,
                                     int copies, int marginTop, int marginBottom, int marginLeft,
                                     int marginRight, String extraData) {
        try {
            getInstance().commitImageData(orientation, bitmap, width, height, copies,
                marginTop, marginBottom, marginLeft, marginRight, extraData);
        } catch (Exception e) {
            Log.e(TAG, "Failed to commit image data", e);
        }
    }

    /**
     * End print job
     */
    public static boolean endPrintJob() {
        try {
            return getInstance().endPrintJob();
        } catch (Exception e) {
            Log.e(TAG, "Failed to end print job", e);
            return false;
        }
    }

    /**
     * Set total print quantity
     */
    public static void setTotalPrintQuantity(int quantity) {
        try {
            getInstance().setTotalPrintQuantity(quantity);
        } catch (Exception e) {
            Log.e(TAG, "Failed to set total print quantity", e);
        }
    }
}
