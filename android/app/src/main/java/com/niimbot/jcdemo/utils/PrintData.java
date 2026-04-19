package com.niimbot.jcdemo.utils;

import android.util.Log;

import java.util.ArrayList;
import java.util.List;

/**
 * PrintData - Utility class for generating print data in JcDemo format
 * Matches the original JcDemo implementation
 */
public class PrintData {
    private static final String TAG = "PrintData";

    /**
     * Get print data based on type - matches JcDemo implementation
     */
    public static List<ArrayList<String>> getPrintData(int copies, String type, float multiple) {
        switch (type) {
            case "text":
                return getTextPrintData(copies, multiple);
            case "image":
                return getImagePrintData(copies, multiple);
            case "qrcode":
                return getQrCodePrintData(copies, multiple);
            case "barcode":
                return getBarCodePrintData(copies, multiple);
            case "line":
                return getLinePrintData(copies, multiple);
            case "graph":
                return getGraphPrintData(copies, multiple);
            case "batch":
                return getBatchPrintData(copies, multiple);
            default:
                return null;
        }
    }

    /**
     * Get text print data - matches JcDemo format
     */
    public static List<ArrayList<String>> getTextPrintData(int copies, float multiple) {
        List<ArrayList<String>> printData = new ArrayList<>();
        ArrayList<String> printJsonData = new ArrayList<>();
        ArrayList<String> printInfoData = new ArrayList<>();

        float offsetX = 0f;
        float offsetY = 0f;
        float width = 50f;
        float height = 20f;
        int rotate = 0;
        float marginX = 2.0f;
        float marginY = 2.0f;
        float fontSize = 3.2f;

        String data = "[" +
                "{" +
                "\"InitDrawingBoardParam\": {" +
                "\"width\": " + width + "," +
                "\"height\": " + height + "," +
                "\"rotate\": " + rotate + "," +
                "\"path\": \"ZT001.ttf\"," +
                "\"verticalShift\": 0," +
                "\"HorizontalShift\": 0" +
                "}," +
                "\"elements\": [" +
                "{" +
                "\"type\": \"text\"," +
                "\"json\": {" +
                "\"x\": " + (marginX + offsetX) + "," +
                "\"y\": " + (marginY + offsetY) + "," +
                "\"height\": " + (height - marginY * 2) + "," +
                "\"width\": " + (width - marginX * 2) + "," +
                "\"value\": \"Test Print Label\"," +
                "\"fontFamily\": \"宋体\"," +
                "\"rotate\": 0," +
                "\"fontSize\": " + fontSize + "," +
                "\"textAlignHorizonral\": 1," +
                "\"textAlignVertical\": 1," +
                "\"letterSpacing\": 0.0," +
                "\"lineSpacing\": 1.0," +
                "\"lineMode\": 6," +
                "\"fontStyle\": [false, false, false, false]" +
                "}" +
                "}" +
                "]" +
                "}";

        printJsonData.add(data);
        printInfoData.add("Text print");

        printData.add(printJsonData);
        printData.add(printInfoData);
        return printData;
    }

    /**
     * Get QR code print data - matches JcDemo format
     */
    public static List<ArrayList<String>> getQrCodePrintData(int copies, float multiple) {
        List<ArrayList<String>> printData = new ArrayList<>();
        ArrayList<String> printJsonData = new ArrayList<>();
        ArrayList<String> printInfoData = new ArrayList<>();

        float offsetX = 0f;
        float offsetY = 0f;
        float width = 50f;
        float height = 20f;
        int rotate = 0;
        float marginX = 2.0f;
        float marginY = 2.0f;
        float qrCodeHeight = height - marginY * 2.0f;
        float qrCodeWidth = height - marginY * 2.0f;

        String data = "[" +
                "{" +
                "\"InitDrawingBoardParam\": {" +
                "\"width\": " + width + "," +
                "\"height\": " + height + "," +
                "\"rotate\": " + rotate + "," +
                "\"path\": \"ZT001.ttf\"," +
                "\"verticalShift\": 0," +
                "\"HorizontalShift\": 0" +
                "}," +
                "\"elements\": [" +
                "{" +
                "\"type\": \"qrCode\"," +
                "\"json\": {" +
                "\"x\": " + (marginX + offsetX) + "," +
                "\"y\": " + (marginY + offsetY) + "," +
                "\"height\": " + qrCodeHeight + "," +
                "\"width\": " + qrCodeWidth + "," +
                "\"value\": \"12345678\"," +
                "\"codeType\": \"31\"," +
                "\"rotate\": 0" +
                "}" +
                "}" +
                "]" +
                "}";

        printJsonData.add(data);
        printInfoData.add("QR Code print");

        printData.add(printJsonData);
        printData.add(printInfoData);
        return printData;
    }

    /**
     * Get barcode print data - matches JcDemo format
     */
    public static List<ArrayList<String>> getBarCodePrintData(int copies, float multiple) {
        List<ArrayList<String>> printData = new ArrayList<>();
        ArrayList<String> printJsonData = new ArrayList<>();
        ArrayList<String> printInfoData = new ArrayList<>();

        float offsetX = 0f;
        float offsetY = 0f;
        float width = 50f;
        float height = 20f;
        int rotate = 0;
        float marginX = 2.0f;
        float marginY = 2.0f;
        float barcodeHeight = height - marginY * 2.0f;
        float barcodeWidth = width - marginX * 2.0f;

        String data = "[" +
                "{" +
                "\"InitDrawingBoardParam\": {" +
                "\"width\": " + width + "," +
                "\"height\": " + height + "," +
                "\"rotate\": " + rotate + "," +
                "\"path\": \"ZT001.ttf\"," +
                "\"verticalShift\": 0," +
                "\"HorizontalShift\": 0" +
                "}," +
                "\"elements\": [" +
                "{" +
                "\"type\": \"barCode\"," +
                "\"json\": {" +
                "\"x\": " + (marginX + offsetX) + "," +
                "\"y\": " + (marginY + offsetY) + "," +
                "\"height\": " + barcodeHeight + "," +
                "\"width\": " + barcodeWidth + "," +
                "\"value\": \"123456789\"," +
                "\"codeType\": \"128\"," +
                "\"rotate\": 0" +
                "}" +
                "}" +
                "]" +
                "}";

        printJsonData.add(data);
        printInfoData.add("Barcode print");

        printData.add(printJsonData);
        printData.add(printInfoData);
        return printData;
    }

    /**
     * Get line print data - matches JcDemo format
     */
    public static List<ArrayList<String>> getLinePrintData(int copies, float multiple) {
        List<ArrayList<String>> printData = new ArrayList<>();
        ArrayList<String> printJsonData = new ArrayList<>();
        ArrayList<String> printInfoData = new ArrayList<>();

        // Simple line print data
        String data = "[]";
        printJsonData.add(data);
        printInfoData.add("Line print");

        printData.add(printJsonData);
        printData.add(printInfoData);
        return printData;
    }

    /**
     * Get graph print data - matches JcDemo format
     */
    public static List<ArrayList<String>> getGraphPrintData(int copies, float multiple) {
        List<ArrayList<String>> printData = new ArrayList<>();
        ArrayList<String> printJsonData = new ArrayList<>();
        ArrayList<String> printInfoData = new ArrayList<>();

        // Simple graph print data
        String data = "[]";
        printJsonData.add(data);
        printInfoData.add("Graph print");

        printData.add(printJsonData);
        printData.add(printInfoData);
        return printData;
    }

    /**
     * Get image print data - matches JcDemo format
     */
    public static List<ArrayList<String>> getImagePrintData(int copies, float multiple) {
        List<ArrayList<String>> printData = new ArrayList<>();
        ArrayList<String> printJsonData = new ArrayList<>();
        ArrayList<String> printInfoData = new ArrayList<>();

        // Simple image print data
        String data = "[]";
        printJsonData.add(data);
        printInfoData.add("Image print");

        printData.add(printJsonData);
        printData.add(printInfoData);
        return printData;
    }

    /**
     * Get batch print data - matches JcDemo format
     */
    public static List<ArrayList<String>> getBatchPrintData(int copies, float multiple) {
        List<ArrayList<String>> printData = new ArrayList<>();
        ArrayList<String> printJsonData = new ArrayList<>();
        ArrayList<String> printInfoData = new ArrayList<>();

        // Batch print combines multiple types
        String data = "[]";
        printJsonData.add(data);
        printInfoData.add("Batch print");

        printData.add(printJsonData);
        printData.add(printInfoData);
        return printData;
    }

    /**
     * Generate text print data in JcDemo format
     */
    public static String generateTextPrintData(String text) {
        Log.d(TAG, "Generating text print data for: " + text);
        
        float width = 40f;
        float height = 30f;
        int rotate = 0;
        float marginX = 2.0f;
        float marginY = 2.0f;
        float fontSize = 3.2f;
        
        String data = "{" +
                "\"InitDrawingBoardParam\": {" +
                "\"width\": " + width + "," +
                "\"height\": " + height + "," +
                "\"rotate\": " + rotate + "," +
                "\"path\": \"ZT001.ttf\"," +
                "\"verticalShift\": 0," +
                "\"HorizontalShift\": 0" +
                "}," +
                "\"elements\": [" +
                "{" +
                "\"type\": \"text\"," +
                "\"json\": {" +
                "\"x\": " + marginX + "," +
                "\"y\": " + marginY + "," +
                "\"height\": " + (height - marginY * 2) + "," +
                "\"width\": " + (width - marginX * 2) + "," +
                "\"value\": \"" + text.replace("\"", "\\\"").replace("\n", "\\n") + "\"," +
                "\"fontFamily\": \"宋体\"," +
                "\"rotate\": 0," +
                "\"fontSize\": " + fontSize + "," +
                "\"textAlignHorizonral\": 1," +
                "\"textAlignVertical\": 1," +
                "\"letterSpacing\": 0.0," +
                "\"lineSpacing\": 1.0," +
                "\"lineMode\": 6," +
                "\"fontStyle\": [false, false, false, false]" +
                "}" +
                "}" +
                "]" +
                "}";
        
        Log.d(TAG, "Generated text print data: " + data);
        return data;
    }

    /**
     * Generate QR code print data in JcDemo format
     */
    public static String generateQRCodePrintData(String qrData) {
        Log.d(TAG, "Generating QR code print data for: " + qrData);
        
        float width = 40f;
        float height = 30f;
        int rotate = 0;
        float marginX = 2.0f;
        float marginY = 2.0f;
        float qrCodeHeight = height - marginY * 2.0f;
        float qrCodeWidth = height - marginY * 2.0f;
        
        String data = "{" +
                "\"InitDrawingBoardParam\": {" +
                "\"width\": " + width + "," +
                "\"height\": " + height + "," +
                "\"rotate\": " + rotate + "," +
                "\"path\": \"ZT001.ttf\"," +
                "\"verticalShift\": 0," +
                "\"HorizontalShift\": 0" +
                "}," +
                "\"elements\": [" +
                "{" +
                "\"type\": \"qrCode\"," +
                "\"json\": {" +
                "\"x\": " + marginX + "," +
                "\"y\": " + marginY + "," +
                "\"height\": " + qrCodeHeight + "," +
                "\"width\": " + qrCodeWidth + "," +
                "\"value\": \"" + qrData + "\"," +
                "\"codeType\": \"31\"," +
                "\"rotate\": 0" +
                "}" +
                "}" +
                "]" +
                "}";
        
        Log.d(TAG, "Generated QR code print data: " + data);
        return data;
    }

    /**
     * Generate barcode print data in JcDemo format
     */
    public static String generateBarcodePrintData(String barcodeData) {
        Log.d(TAG, "Generating barcode print data for: " + barcodeData);
        
        float width = 40f;
        float height = 30f;
        int rotate = 0;
        float marginX = 2.0f;
        float marginY = 2.0f;
        float barcodeHeight = height - marginY * 2.0f;
        float barcodeWidth = width - marginX * 2.0f;
        
        String data = "{" +
                "\"InitDrawingBoardParam\": {" +
                "\"width\": " + width + "," +
                "\"height\": " + height + "," +
                "\"rotate\": " + rotate + "," +
                "\"path\": \"ZT001.ttf\"," +
                "\"verticalShift\": 0," +
                "\"HorizontalShift\": 0" +
                "}," +
                "\"elements\": [" +
                "{" +
                "\"type\": \"barCode\"," +
                "\"json\": {" +
                "\"x\": " + marginX + "," +
                "\"y\": " + marginY + "," +
                "\"height\": " + barcodeHeight + "," +
                "\"width\": " + barcodeWidth + "," +
                "\"value\": \"" + barcodeData + "\"," +
                "\"codeType\": \"128\"," +
                "\"rotate\": 0" +
                "}" +
                "}" +
                "]" +
                "}";
        
        Log.d(TAG, "Generated barcode print data: " + data);
        return data;
    }

    /**
     * Generate receipt print data in JcDemo format
     */
    public static String generateReceiptPrintData(String title, String content) {
        Log.d(TAG, "Generating receipt print data for: " + title);
        
        float width = 50f;
        float height = 40f;
        int rotate = 0;
        float marginX = 2.0f;
        float marginY = 2.0f;
        float fontSize = 3.2f;
        
        String data = "{" +
                "\"InitDrawingBoardParam\": {" +
                "\"width\": " + width + "," +
                "\"height\": " + height + "," +
                "\"rotate\": " + rotate + "," +
                "\"path\": \"ZT001.ttf\"," +
                "\"verticalShift\": 0," +
                "\"HorizontalShift\": 0" +
                "}," +
                "\"elements\": [" +
                "{" +
                "\"type\": \"text\"," +
                "\"json\": {" +
                "\"x\": " + marginX + "," +
                "\"y\": " + marginY + "," +
                "\"height\": " + (height - marginY * 2) + "," +
                "\"width\": " + (width - marginX * 2) + "," +
                "\"value\": \"" + title + "\\n\\n" + content.replace("\"", "\\\"").replace("\n", "\\n") + "\"," +
                "\"fontFamily\": \"宋体\"," +
                "\"rotate\": 0," +
                "\"fontSize\": " + fontSize + "," +
                "\"textAlignHorizonral\": 1," +
                "\"textAlignVertical\": 1," +
                "\"letterSpacing\": 0.0," +
                "\"lineSpacing\": 1.0," +
                "\"lineMode\": 6," +
                "\"fontStyle\": [false, false, false, false]" +
                "}" +
                "}" +
                "]" +
                "}";
        
        Log.d(TAG, "Generated receipt print data: " + data);
        return data;
    }
}
