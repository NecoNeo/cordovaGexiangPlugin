package com.chuwa.cordova.gexiang;

import org.apache.cordova.LOG;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import com.getui.gis.sdk.GInsightManager;


public class GInsightEventReceiver extends BroadcastReceiver {

    public static final String TAG = GInsightEventReceiver.class.getSimpleName();

    @Override
    public void onReceive(Context context, Intent intent) {
        String action = intent.getStringExtra("action");
        if (action.equalsIgnoreCase(GInsightManager.ACTION_GIUID_GENERATED)) {
            String giuid = intent.getStringExtra("giuid");
            Log.w(TAG, "giuid = " + giuid);

            // App app = (App)context.getApplicationContext();
            // app.setGiuid(giuid);

            Gexiang gexiangPlugin = Gexiang.getInstance();
            gexiangPlugin.setGiuid(giuid);
        }
    }

}
