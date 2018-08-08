package com.chuwa.cordova.gexiang;

import com.getui.gis.sdk.GInsightManager;

import org.apache.cordova.CordovaInterface;

import android.content.Intent;
import android.net.Uri;
import android.content.SharedPreferences;
// import android.content.Context;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;


public class Gexiang extends CordovaPlugin {

    private static Gexiang instance;

    private static final String GET_TAG_HTTP_URL = "http://demo-gi.getui.com/v2/?os=android&giuid=";

    private static final String START_SDK_WITH_APPID = "startSDKWithAppId";
    private static final String GET_GI_UID = "getGiUid";
    private static final String OPEN_URL = "openURL";
    private static final String DEBUG = "debug";

    private String giuid;

    public Gexiang() {
        instance = this;
    }

    public static Gexiang getInstance() {
        return instance;
    }

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (START_SDK_WITH_APPID.equals(action)) {
            startSDKWithAppId();
        } else if (GET_GI_UID.equals(action)) {
            getGiUid(callbackContext);
        } else if (OPEN_URL.equals(action)) {
            openBrowser(Uri.parse(GET_TAG_HTTP_URL + giuid));
        } else if (DEBUG.equals(action)) {
            // String message = args.getString(0);
            System.out.println("debug");
            return true;
        }
        return false;
    }

    public void setGiuid(String giuid) {
        // SharedPreferences sp = getSharedPreferences(getClass().getSimpleName(), Context.MODE_PRIVATE);
        // sp.edit().putString("giuid", giuid).apply();
        this.giuid = giuid;
    }

    // 初始化sdk
    private void startSDKWithAppId() {
        GInsightManager.getInstance().init(getApplicationContext(), "appId");
    }

    //getGiUid
    private void getGiUid(CallbackContext callbackContext) {
        callbackContext.success(giuid);
    }

    // openURL
    private void openBrowser(Uri uri) {
        Intent intent = new Intent(Intent.ACTION_VIEW, uri);
        startActivity(intent);
    }

}
