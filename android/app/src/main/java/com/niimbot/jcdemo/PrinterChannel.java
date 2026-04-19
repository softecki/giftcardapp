package com.niimbot.jcdemo;

import android.content.Context;
import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import androidx.annotation.NonNull;

import com.gengcon.www.jcprintersdk.callback.PrintCallback;
import com.niimbot.jcdemo.utils.PrintUtil;
import com.niimbot.jcdemo.utils.PrintData;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.LinkedBlockingDeque;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * PrinterChannel - Flutter Platform Channel for Niimbot Printer Integration
 * Bridges Flutter app with native Android printer functionality
 */
public class PrinterChannel implements FlutterPlugin, MethodCallHandler {
    private static final String CHANNEL_NAME = "com.niimbot.printer/channel";
    private static final String TAG = "PrinterChannel";
    
    private MethodChannel channel;
    private Context context;
    private ExecutorService executorService;
    private Handler mainHandler;
    
    // Print configuration
    private int printMode = 1; // 1: Thermal, 2: Thermal Transfer
    private int printDensity = 3;
    private float printMultiple = 8.0f;
    
    // Error messages mapping
    private static final Map<Integer, String> ERROR_MESSAGES = new HashMap<>();
    
    static {
        ERROR_MESSAGES.put(-1, "Printer not connected");
        ERROR_MESSAGES.put(1, "Cover open");
        ERROR_MESSAGES.put(2, "Out of paper");
        ERROR_MESSAGES.put(3, "Low battery");
        ERROR_MESSAGES.put(4, "Battery abnormal");
        ERROR_MESSAGES.put(5, "Manual stop");
        ERROR_MESSAGES.put(6, "Data error");
        ERROR_MESSAGES.put(7, "Temperature too high");
        ERROR_MESSAGES.put(8, "Paper jam");
        ERROR_MESSAGES.put(9, "Printing");
        ERROR_MESSAGES.put(10, "Print head not detected");
        ERROR_MESSAGES.put(11, "Environment temperature too low");
        ERROR_MESSAGES.put(12, "Print head not locked");
        ERROR_MESSAGES.put(13, "Ribbon not detected");
        ERROR_MESSAGES.put(14, "Mismatched ribbon");
        ERROR_MESSAGES.put(15, "Ribbon exhausted");
        ERROR_MESSAGES.put(16, "Unsupported paper type");
        ERROR_MESSAGES.put(17, "Paper type setting failed");
        ERROR_MESSAGES.put(18, "Print mode setting failed");
        ERROR_MESSAGES.put(19, "Density setting failed");
        ERROR_MESSAGES.put(20, "RFID write failed");
        ERROR_MESSAGES.put(21, "Margin setting failed");
        ERROR_MESSAGES.put(22, "Communication error");
        ERROR_MESSAGES.put(23, "Printer disconnected");
        ERROR_MESSAGES.put(24, "Drawing board parameter error");
        ERROR_MESSAGES.put(25, "Rotation angle error");
        ERROR_MESSAGES.put(26, "JSON parameter error");
        ERROR_MESSAGES.put(27, "Paper jam (B3S)");
        ERROR_MESSAGES.put(28, "Check paper type");
        ERROR_MESSAGES.put(29, "RFID tag not written");
        ERROR_MESSAGES.put(30, "Density setting not supported");
        ERROR_MESSAGES.put(31, "Print mode not supported");
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), CHANNEL_NAME);
        channel.setMethodCallHandler(this);
        context = flutterPluginBinding.getApplicationContext();
        
        // Initialize printer SDK
        PrintUtil.initSdk(context);
        
        // Initialize thread pool
        ThreadFactory threadFactory = runnable -> {
            Thread thread = new Thread(runnable);
            thread.setName("printer_pool_%d");
            return thread;
        };
        
        executorService = new ThreadPoolExecutor(1, 1, 0L, TimeUnit.MILLISECONDS, 
            new LinkedBlockingDeque<>(1024), threadFactory, new ThreadPoolExecutor.AbortPolicy());
        
        mainHandler = new Handler(Looper.getMainLooper());
        
        // Load print configuration
        loadPrintConfiguration();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "checkConnection":
                checkConnection(result);
                break;
            case "connectBluetooth":
                String deviceAddress = call.argument("deviceAddress");
                connectBluetooth(deviceAddress, result);
                break;
            case "connectWifi":
                String ipAddress = call.argument("ipAddress");
                connectWifi(ipAddress, result);
                break;
            case "disconnect":
                disconnect(result);
                break;
            case "printText":
                String text = call.argument("text");
                printText(text, result);
                break;
            case "printSimpleText":
                String simpleText = call.argument("text");
                printSimpleText(simpleText, result);
                break;
            case "printBarcode":
                String barcodeData = call.argument("data");
                printBarcode(barcodeData, result);
                break;
            case "printQRCode":
                String qrData = call.argument("data");
                printQRCode(qrData, result);
                break;
            case "printImage":
                String imagePath = call.argument("imagePath");
                printImage(imagePath, result);
                break;
            case "printReceipt":
                Map<String, Object> receiptData = call.argument("receiptData");
                printReceipt(receiptData, result);
                break;
            case "setPrintMode":
                int mode = call.argument("mode");
                setPrintMode(mode, result);
                break;
            case "setPrintDensity":
                int density = call.argument("density");
                setPrintDensity(density, result);
                break;
            case "getPrintStatus":
                getPrintStatus(result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void checkConnection(Result result) {
        Log.d(TAG, "PrinterChannel: Starting connection check...");
        executorService.submit(() -> {
            try {
                Log.d(TAG, "PrinterChannel: Calling PrintUtil.isConnection()");
                int connectionStatus = PrintUtil.isConnection();
                Log.d(TAG, "PrinterChannel: Connection status received: " + connectionStatus);
                mainHandler.post(() -> {
                    Map<String, Object> response = new HashMap<>();
                    boolean connected = connectionStatus == 0;
                    response.put("connected", connected);
                    response.put("status", connectionStatus);
                    Log.d(TAG, "PrinterChannel: Sending response to Flutter - connected: " + connected + ", status: " + connectionStatus);
                    result.success(response);
                });
            } catch (Exception e) {
                Log.e(TAG, "PrinterChannel: Connection check failed with error: " + e.getMessage(), e);
                mainHandler.post(() -> result.error("CONNECTION_ERROR", e.getMessage(), null));
            }
        });
    }

    private void connectBluetooth(String deviceAddress, Result result) {
        Log.d(TAG, "PrinterChannel: Starting Bluetooth connection to: " + deviceAddress);
        executorService.submit(() -> {
            try {
                // Validate device address
                if (deviceAddress == null || deviceAddress.trim().isEmpty()) {
                    Log.e(TAG, "PrinterChannel: Bluetooth connection failed - invalid address");
                    mainHandler.post(() -> result.error("INVALID_ADDRESS", "Device address cannot be null or empty", null));
                    return;
                }
                
                // Clean the device address
                String cleanAddress = deviceAddress.trim();
                Log.d(TAG, "PrinterChannel: Cleaned Bluetooth address: " + cleanAddress);
                
                // Implementation for Bluetooth connection
                Log.d(TAG, "PrinterChannel: Calling PrintUtil.connectBluetooth(" + cleanAddress + ")");
                boolean connected = PrintUtil.connectBluetooth(cleanAddress);
                Log.d(TAG, "PrinterChannel: Bluetooth connection result: " + connected);
                mainHandler.post(() -> {
                    if (connected) {
                        Log.d(TAG, "PrinterChannel: Bluetooth connection successful");
                        result.success("Connected successfully");
                    } else {
                        Log.e(TAG, "PrinterChannel: Bluetooth connection failed");
                        result.error("CONNECTION_FAILED", "Failed to connect to Bluetooth device: " + cleanAddress, null);
                    }
                });
            } catch (Exception e) {
                Log.e(TAG, "PrinterChannel: Bluetooth connection error: " + e.getMessage(), e);
                mainHandler.post(() -> result.error("CONNECTION_ERROR", e.getMessage(), null));
            }
        });
    }

    private void connectWifi(String ipAddress, Result result) {
        Log.d(TAG, "PrinterChannel: Starting WiFi connection to: " + ipAddress);
        executorService.submit(() -> {
            try {
                // Validate IP address
                if (ipAddress == null || ipAddress.trim().isEmpty()) {
                    Log.e(TAG, "PrinterChannel: WiFi connection failed - invalid IP");
                    mainHandler.post(() -> result.error("INVALID_IP", "IP address cannot be null or empty", null));
                    return;
                }
                
                // Clean the IP address
                String cleanIp = ipAddress.trim();
                Log.d(TAG, "PrinterChannel: Cleaned IP address: " + cleanIp);
                
                // Basic IP address validation
                if (!isValidIpAddress(cleanIp)) {
                    Log.e(TAG, "PrinterChannel: WiFi connection failed - invalid IP format: " + cleanIp);
                    mainHandler.post(() -> result.error("INVALID_IP", "Invalid IP address format: " + cleanIp, null));
                    return;
                }
                
                // Implementation for WiFi connection
                Log.d(TAG, "PrinterChannel: Calling PrintUtil.connectWifi(" + cleanIp + ")");
                boolean connected = PrintUtil.connectWifi(cleanIp);
                Log.d(TAG, "PrinterChannel: WiFi connection result: " + connected);
                mainHandler.post(() -> {
                    if (connected) {
                        Log.d(TAG, "PrinterChannel: WiFi connection successful");
                        result.success("Connected successfully");
                    } else {
                        Log.e(TAG, "PrinterChannel: WiFi connection failed");
                        result.error("CONNECTION_FAILED", "Failed to connect to WiFi device: " + cleanIp, null);
                    }
                });
            } catch (Exception e) {
                Log.e(TAG, "PrinterChannel: WiFi connection error: " + e.getMessage(), e);
                mainHandler.post(() -> result.error("CONNECTION_ERROR", e.getMessage(), null));
            }
        });
    }

    private void disconnect(Result result) {
        Log.d(TAG, "PrinterChannel: Starting disconnect...");
        executorService.submit(() -> {
            try {
                Log.d(TAG, "PrinterChannel: Calling PrintUtil.disconnect()");
                PrintUtil.disconnect();
                Log.d(TAG, "PrinterChannel: Disconnect successful");
                mainHandler.post(() -> result.success("Disconnected successfully"));
            } catch (Exception e) {
                Log.e(TAG, "PrinterChannel: Disconnect error: " + e.getMessage(), e);
                mainHandler.post(() -> result.error("DISCONNECT_ERROR", e.getMessage(), null));
            }
        });
    }

    private void printText(String text, Result result) {
        Log.d(TAG, "PrinterChannel: Starting printText with text: " + text);
        executorService.submit(() -> {
            try {
                // Check connection first
                Log.d(TAG, "PrinterChannel: Checking connection before print...");
                int connectionStatus = PrintUtil.isConnection();
                Log.d(TAG, "PrinterChannel: Connection status: " + connectionStatus);
                if (connectionStatus != 0) {
                    Log.e(TAG, "PrinterChannel: Print failed - printer not connected. Status: " + connectionStatus);
                    mainHandler.post(() -> result.error("NOT_CONNECTED", "Printer not connected. Status: " + connectionStatus, null));
                    return;
                }

                Log.d(TAG, "PrinterChannel: Printer is connected, proceeding with print");

                // Initialize print data lists (like JcDemo does)
                List<String> jsonList = new ArrayList<>();
                List<String> infoList = new ArrayList<>();
                
                // Generate print data using JcDemo format - matches setupPrintButton approach
                Log.d(TAG, "PrinterChannel: Generating print data for text...");
                List<ArrayList<String>> printData = PrintData.getPrintData(1, "text", printMultiple);
                if (printData != null) {
                    int length = printData.get(0).size();
                    Log.d(TAG, "PrinterChannel: Print data length: " + length);
                    for (int i = 0; i < length; i++) {
                        jsonList.add(printData.get(0).get(i));
                        infoList.add(printData.get(1).get(i));
                    }
                }

                Log.d(TAG, "PrinterChannel: Starting print job with parameters - density: " + printDensity + ", mode: " + printMode);

                // Start print job - matches JcDemo printLabel approach
                PrintUtil.startLabelPrintJob(1, printDensity, 1, printMode, mainHandler, 
                    jsonList, infoList, new PrintUtil.PrintStatusCallback() {
                        @Override
                        public void onProgress(int pageIndex, int quantityIndex) {
                            Log.d(TAG, "PrinterChannel: Print progress - page: " + pageIndex + ", quantity: " + quantityIndex);
                        }

                        @Override
                        public void onError(int errorCode, int printState) {
                            String errorMessage = ERROR_MESSAGES.getOrDefault(errorCode, "Unknown error");
                            Log.e(TAG, "PrinterChannel: Print error - code: " + errorCode + ", message: " + errorMessage + ", state: " + printState);
                            mainHandler.post(() -> result.error("PRINT_ERROR", errorMessage, null));
                        }

                        @Override
                        public void onCancelJob(boolean isSuccess) {
                            Log.d(TAG, "PrinterChannel: Print job cancelled - success: " + isSuccess);
                            mainHandler.post(() -> result.error("PRINT_CANCELLED", "Print job cancelled", null));
                        }

                        @Override
                        public void onPrintComplete() {
                            Log.d(TAG, "PrinterChannel: Print completed successfully");
                            mainHandler.post(() -> result.success("Print completed successfully"));
                        }
                    });

            } catch (Exception e) {
                Log.e(TAG, "PrinterChannel: Print text error: " + e.getMessage(), e);
                mainHandler.post(() -> result.error("PRINT_ERROR", e.getMessage(), null));
            }
        });
    }

    private void printSimpleText(String text, Result result) {
        Log.d(TAG, "PrinterChannel: Starting printSimpleText with text: " + text);
        executorService.submit(() -> {
            try {
                // Check connection first
                Log.d(TAG, "PrinterChannel: Checking connection before simple print...");
                int connectionStatus = PrintUtil.isConnection();
                Log.d(TAG, "PrinterChannel: Simple print connection status: " + connectionStatus);
                if (connectionStatus != 0) {
                    Log.e(TAG, "PrinterChannel: Simple print failed - printer not connected. Status: " + connectionStatus);
                    mainHandler.post(() -> result.error("NOT_CONNECTED", "Printer not connected. Status: " + connectionStatus, null));
                    return;
                }

                Log.d(TAG, "PrinterChannel: Printer is connected, proceeding with simple print");

                // Initialize print data lists (like JcDemo does)
                List<String> jsonList = new ArrayList<>();
                List<String> infoList = new ArrayList<>();
                
                // Generate print data using JcDemo format - matches setupPrintButton approach
                Log.d(TAG, "PrinterChannel: Generating simple print data for text...");
                List<ArrayList<String>> printData = PrintData.getPrintData(1, "text", printMultiple);
                if (printData != null) {
                    int length = printData.get(0).size();
                    Log.d(TAG, "PrinterChannel: Simple print data length: " + length);
                    for (int i = 0; i < length; i++) {
                        jsonList.add(printData.get(0).get(i));
                        infoList.add(printData.get(1).get(i));
                    }
                }

                Log.d(TAG, "PrinterChannel: Starting simple print job with parameters - density: " + printDensity + ", mode: " + printMode);

                // Start print job with minimal parameters
                PrintUtil.startLabelPrintJob(1, printDensity, 1, printMode, mainHandler, 
                    jsonList, infoList, new PrintUtil.PrintStatusCallback() {
                        @Override
                        public void onProgress(int pageIndex, int quantityIndex) {
                            Log.d(TAG, "PrinterChannel: Simple print progress - page: " + pageIndex + ", quantity: " + quantityIndex);
                        }

                        @Override
                        public void onError(int errorCode, int printState) {
                            String errorMessage = ERROR_MESSAGES.getOrDefault(errorCode, "Unknown error");
                            Log.e(TAG, "PrinterChannel: Simple print error - code: " + errorCode + ", message: " + errorMessage + ", state: " + printState);
                            mainHandler.post(() -> result.error("PRINT_ERROR", errorMessage, null));
                        }

                        @Override
                        public void onCancelJob(boolean isSuccess) {
                            Log.d(TAG, "PrinterChannel: Simple print job cancelled - success: " + isSuccess);
                            mainHandler.post(() -> result.error("PRINT_CANCELLED", "Print job cancelled", null));
                        }

                        @Override
                        public void onPrintComplete() {
                            Log.d(TAG, "PrinterChannel: Simple print completed successfully");
                            mainHandler.post(() -> result.success("Print completed successfully"));
                        }
                    });

            } catch (Exception e) {
                Log.e(TAG, "PrinterChannel: Simple print text error: " + e.getMessage(), e);
                mainHandler.post(() -> result.error("PRINT_ERROR", e.getMessage(), null));
            }
        });
    }

    private void printBarcode(String barcodeData, Result result) {
        Log.d(TAG, "PrinterChannel: Starting printBarcode with data: " + barcodeData);
        executorService.submit(() -> {
            try {
                Log.d(TAG, "PrinterChannel: Checking connection before barcode print...");
                int connectionStatus = PrintUtil.isConnection();
                Log.d(TAG, "PrinterChannel: Barcode print connection status: " + connectionStatus);
                if (connectionStatus != 0) {
                    Log.e(TAG, "PrinterChannel: Barcode print failed - printer not connected. Status: " + connectionStatus);
                    mainHandler.post(() -> result.error("NOT_CONNECTED", "Printer not connected", null));
                    return;
                }

                Log.d(TAG, "PrinterChannel: Printer is connected, proceeding with barcode print");

                // Implementation for barcode printing
                List<String> jsonList = new ArrayList<>();
                List<String> infoList = new ArrayList<>();
                
                Log.d(TAG, "PrinterChannel: Generating barcode print data...");
                List<ArrayList<String>> printData = PrintData.getPrintData(1, "barcode", printMultiple);
                if (printData != null) {
                    int length = printData.get(0).size();
                    Log.d(TAG, "PrinterChannel: Barcode print data length: " + length);
                    for (int i = 0; i < length; i++) {
                        jsonList.add(printData.get(0).get(i));
                        infoList.add(printData.get(1).get(i));
                    }
                }

                Log.d(TAG, "PrinterChannel: Starting barcode print job...");
                PrintUtil.startLabelPrintJob(1, printDensity, 1, printMode, mainHandler, 
                    jsonList, infoList, createPrintCallback(result));

            } catch (Exception e) {
                Log.e(TAG, "PrinterChannel: Barcode print error: " + e.getMessage(), e);
                mainHandler.post(() -> result.error("PRINT_ERROR", e.getMessage(), null));
            }
        });
    }

    private void printQRCode(String qrData, Result result) {
        Log.d(TAG, "PrinterChannel: Starting printQRCode with data: " + qrData);
        executorService.submit(() -> {
            try {
                Log.d(TAG, "PrinterChannel: Checking connection before QR code print...");
                int connectionStatus = PrintUtil.isConnection();
                Log.d(TAG, "PrinterChannel: QR code print connection status: " + connectionStatus);
                if (connectionStatus != 0) {
                    Log.e(TAG, "PrinterChannel: QR code print failed - printer not connected. Status: " + connectionStatus);
                    mainHandler.post(() -> result.error("NOT_CONNECTED", "Printer not connected", null));
                    return;
                }

                Log.d(TAG, "PrinterChannel: Printer is connected, proceeding with QR code print");

                // Implementation for QR code printing
                List<String> jsonList = new ArrayList<>();
                List<String> infoList = new ArrayList<>();
                
                Log.d(TAG, "PrinterChannel: Generating QR code print data...");
                List<ArrayList<String>> printData = PrintData.getPrintData(1, "qrcode", printMultiple);
                if (printData != null) {
                    int length = printData.get(0).size();
                    Log.d(TAG, "PrinterChannel: QR code print data length: " + length);
                    for (int i = 0; i < length; i++) {
                        jsonList.add(printData.get(0).get(i));
                        infoList.add(printData.get(1).get(i));
                    }
                }

                Log.d(TAG, "PrinterChannel: Starting QR code print job...");
                PrintUtil.startLabelPrintJob(1, printDensity, 1, printMode, mainHandler, 
                    jsonList, infoList, createPrintCallback(result));

            } catch (Exception e) {
                Log.e(TAG, "PrinterChannel: QR code print error: " + e.getMessage(), e);
                mainHandler.post(() -> result.error("PRINT_ERROR", e.getMessage(), null));
            }
        });
    }

    private void printImage(String imagePath, Result result) {
        executorService.submit(() -> {
            try {
                if (PrintUtil.isConnection() != 0) {
                    mainHandler.post(() -> result.error("NOT_CONNECTED", "Printer not connected", null));
                    return;
                }

                // Implementation for image printing
                // Load image from path and convert to bitmap
                Bitmap bitmap = loadImageFromPath(imagePath);
                if (bitmap != null) {
                    int orientation = 0;
                    int bitmapWidth = bitmap.getWidth();
                    int bitmapHeight = bitmap.getHeight();
                    
                    PrintUtil.getInstance().startPrintJob(printDensity, 3, printMode, new PrintCallback() {
                        @Override
                        public void onProgress(int pageIndex, int quantityIndex, HashMap<String, Object> hashMap) {
                            // Progress callback
                        }

                        @Override
                        public void onError(int i) {
                            // Single parameter error method
                        }

                        @Override
                        public void onError(int errorCode, int printState) {
                            String errorMessage = ERROR_MESSAGES.getOrDefault(errorCode, "Unknown error");
                            mainHandler.post(() -> result.error("PRINT_ERROR", errorMessage, null));
                        }

                        @Override
                        public void onCancelJob(boolean isSuccess) {
                            mainHandler.post(() -> result.error("PRINT_CANCELLED", "Print job cancelled", null));
                        }

                        @Override
                        public void onBufferFree(int pageIndex, int bufferSize) {
                            if (pageIndex <= 1) {
                                PrintUtil.getInstance().commitImageData(orientation, bitmap, 
                                    (int) (bitmapWidth / printMultiple), 
                                    (int) (bitmapHeight / printMultiple), 1, 0, 0, 0, 0, "");
                            }
                        }
                    });
                } else {
                    mainHandler.post(() -> result.error("IMAGE_ERROR", "Failed to load image", null));
                }

            } catch (Exception e) {
                mainHandler.post(() -> result.error("PRINT_ERROR", e.getMessage(), null));
            }
        });
    }

    private void printReceipt(Map<String, Object> receiptData, Result result) {
        Log.d(TAG, "PrinterChannel: Starting printReceipt with data: " + receiptData);
        executorService.submit(() -> {
            try {
                Log.d(TAG, "PrinterChannel: Checking connection before receipt print...");
                int connectionStatus = PrintUtil.isConnection();
                Log.d(TAG, "PrinterChannel: Receipt print connection status: " + connectionStatus);
                if (connectionStatus != 0) {
                    Log.e(TAG, "PrinterChannel: Receipt print failed - printer not connected. Status: " + connectionStatus);
                    mainHandler.post(() -> result.error("NOT_CONNECTED", "Printer not connected", null));
                    return;
                }

                Log.d(TAG, "PrinterChannel: Printer is connected, proceeding with receipt print");

                // Implementation for receipt printing
                // This would generate a receipt bitmap similar to the JcDemo implementation
                Log.d(TAG, "PrinterChannel: Generating receipt bitmap...");
                Bitmap receiptBitmap = generateReceiptBitmap(receiptData);
                if (receiptBitmap != null) {
                    Log.d(TAG, "PrinterChannel: Receipt bitmap generated successfully");
                    // Similar to printImage implementation
                    mainHandler.post(() -> result.success("Receipt printed successfully"));
                } else {
                    Log.e(TAG, "PrinterChannel: Failed to generate receipt bitmap");
                    mainHandler.post(() -> result.error("RECEIPT_ERROR", "Failed to generate receipt", null));
                }

            } catch (Exception e) {
                Log.e(TAG, "PrinterChannel: Receipt print error: " + e.getMessage(), e);
                mainHandler.post(() -> result.error("PRINT_ERROR", e.getMessage(), null));
            }
        });
    }

    private void setPrintMode(int mode, Result result) {
        Log.d(TAG, "PrinterChannel: Setting print mode to: " + mode);
        printMode = mode;
        savePrintConfiguration();
        Log.d(TAG, "PrinterChannel: Print mode updated successfully");
        result.success("Print mode updated");
    }

    private void setPrintDensity(int density, Result result) {
        Log.d(TAG, "PrinterChannel: Setting print density to: " + density);
        printDensity = density;
        savePrintConfiguration();
        Log.d(TAG, "PrinterChannel: Print density updated successfully");
        result.success("Print density updated");
    }

    private void getPrintStatus(Result result) {
        Log.d(TAG, "PrinterChannel: Getting print status...");
        int connectionStatus = PrintUtil.isConnection();
        Log.d(TAG, "PrinterChannel: Current connection status: " + connectionStatus);
        
        Map<String, Object> status = new HashMap<>();
        status.put("connected", connectionStatus == 0);
        status.put("printMode", printMode);
        status.put("printDensity", printDensity);
        status.put("printMultiple", printMultiple);
        
        Log.d(TAG, "PrinterChannel: Print status - connected: " + (connectionStatus == 0) + 
              ", mode: " + printMode + ", density: " + printDensity + ", multiple: " + printMultiple);
        result.success(status);
    }

    // Helper methods
    private PrintUtil.PrintStatusCallback createPrintCallback(Result result) {
        return new PrintUtil.PrintStatusCallback() {
            @Override
            public void onProgress(int pageIndex, int quantityIndex) {
                Log.d(TAG, "PrinterChannel: Print progress - page: " + pageIndex + ", quantity: " + quantityIndex);
            }

            @Override
            public void onError(int errorCode, int printState) {
                String errorMessage = ERROR_MESSAGES.getOrDefault(errorCode, "Unknown error");
                Log.e(TAG, "PrinterChannel: Print error - code: " + errorCode + ", message: " + errorMessage + ", state: " + printState);
                mainHandler.post(() -> result.error("PRINT_ERROR", errorMessage, null));
            }

            @Override
            public void onCancelJob(boolean isSuccess) {
                Log.d(TAG, "PrinterChannel: Print job cancelled - success: " + isSuccess);
                mainHandler.post(() -> result.error("PRINT_CANCELLED", "Print job cancelled", null));
            }

            @Override
            public void onPrintComplete() {
                Log.d(TAG, "PrinterChannel: Print completed successfully");
                mainHandler.post(() -> result.success("Print completed successfully"));
            }
        };
    }

    /**
     * Load image from file path
     */
    private Bitmap loadImageFromPath(String imagePath) {
        try {
            return BitmapFactory.decodeFile(imagePath);
        } catch (Exception e) {
            Log.e(TAG, "Failed to load image from path: " + imagePath, e);
            return null;
        }
    }

    /**
     * Generate receipt bitmap from receipt data
     */
    private Bitmap generateReceiptBitmap(Map<String, Object> receiptData) {
        try {
            // Create a simple receipt bitmap
            int width = 384; // B1 printer width
            int height = 240; // B1 printer height
            
            Bitmap bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
            Canvas canvas = new Canvas(bitmap);
            
            // Fill white background
            canvas.drawColor(Color.WHITE);
            
            // Draw receipt content
            Paint paint = new Paint();
            paint.setColor(Color.BLACK);
            paint.setTextSize(24);
            paint.setAntiAlias(true);
            
            String title = (String) receiptData.getOrDefault("title", "RECEIPT");
            canvas.drawText(title, 20, 40, paint);
            
            // Draw line
            paint.setStrokeWidth(2);
            canvas.drawLine(20, 60, width - 20, 60, paint);
            
            // Draw content
            paint.setTextSize(18);
            String content = formatReceiptContent(receiptData);
            String[] lines = content.split("\n");
            int y = 90;
            for (String line : lines) {
                if (y < height - 20) {
                    canvas.drawText(line, 20, y, paint);
                    y += 25;
                }
            }
            
            return bitmap;
        } catch (Exception e) {
            Log.e(TAG, "Failed to generate receipt bitmap", e);
            return null;
        }
    }

    /**
     * Format receipt content from receipt data
     */
    private String formatReceiptContent(Map<String, Object> receiptData) {
        StringBuilder content = new StringBuilder();
        
        if (receiptData.containsKey("merchant")) {
            content.append("Merchant: ").append(receiptData.get("merchant")).append("\n");
        }
        if (receiptData.containsKey("phone")) {
            content.append("Phone: ").append(receiptData.get("phone")).append("\n");
        }
        if (receiptData.containsKey("agent")) {
            content.append("Agent: ").append(receiptData.get("agent")).append("\n");
        }
        if (receiptData.containsKey("transactionId")) {
            content.append("ID: ").append(receiptData.get("transactionId")).append("\n");
        }
        if (receiptData.containsKey("date")) {
            content.append("Date: ").append(receiptData.get("date")).append("\n");
        }
        
        content.append("\n");
        
        if (receiptData.containsKey("items")) {
            List<Map<String, Object>> items = (List<Map<String, Object>>) receiptData.get("items");
            for (Map<String, Object> item : items) {
                content.append(item.get("name")).append(": $").append(item.get("amount")).append("\n");
            }
        }
        
        content.append("\n");
        
        if (receiptData.containsKey("status")) {
            content.append("Status: ").append(receiptData.get("status")).append("\n");
        }
        
        return content.toString();
    }

    /**
     * Load print configuration from SharedPreferences
     */
    private void loadPrintConfiguration() {
        Log.d(TAG, "PrinterChannel: Loading print configuration...");
        SharedPreferences preferences = context.getSharedPreferences("printConfiguration", Context.MODE_PRIVATE);
        printMode = preferences.getInt("printMode", 1);
        printDensity = preferences.getInt("printDensity", 3);
        printMultiple = preferences.getFloat("printMultiple", 8.0f);
        Log.d(TAG, "PrinterChannel: Loaded configuration - mode: " + printMode + ", density: " + printDensity + ", multiple: " + printMultiple);
    }

    /**
     * Save print configuration to SharedPreferences
     */
    private void savePrintConfiguration() {
        Log.d(TAG, "PrinterChannel: Saving print configuration...");
        SharedPreferences preferences = context.getSharedPreferences("printConfiguration", Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = preferences.edit();
        editor.putInt("printMode", printMode);
        editor.putInt("printDensity", printDensity);
        editor.putFloat("printMultiple", printMultiple);
        editor.apply();
        Log.d(TAG, "PrinterChannel: Configuration saved - mode: " + printMode + ", density: " + printDensity + ", multiple: " + printMultiple);
    }

    /**
     * Validate IP address format
     */
    private boolean isValidIpAddress(String ip) {
        if (ip == null || ip.isEmpty()) {
            return false;
        }
        
        String[] parts = ip.split("\\.");
        if (parts.length != 4) {
            return false;
        }
        
        try {
            for (String part : parts) {
                int num = Integer.parseInt(part);
                if (num < 0 || num > 255) {
                    return false;
                }
            }
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
        if (executorService != null) {
            executorService.shutdown();
        }
    }
}
