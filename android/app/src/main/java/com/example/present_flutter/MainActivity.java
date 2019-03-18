package com.example.flutterapp;

import android.app.Application;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.ResolveInfo;
import android.content.res.Resources;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.provider.SyncStateContract;
import android.util.Log;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "flutter.native/helper";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
      new MethodChannel.MethodCallHandler() {
        @Override
        public void onMethodCall(MethodCall call, MethodChannel.Result result) {
          if (call.method.equals("helloFromNativeCode")) {
            String greetings = helloFromNativeCode();
            result.success(greetings);
          }
        }});



  }
  private String helloFromNativeCode() {
    String pacid = "com.gameloft.android.ANMP.GloftNJHM";
    if(OpenPackageId(pacid)) {
        return "YES";
    }
    return  "NO";
  }
 
  boolean OpenPackageId(String pacId) {
      final PackageManager pm = getPackageManager();
      List<ApplicationInfo> packages = pm.getInstalledApplications(PackageManager.GET_META_DATA);
      int i = 0;
      for (ApplicationInfo packageInfo : packages) {
          if(pm.getLaunchIntentForPackage(packageInfo.packageName)!= null &&
                  !pm.getLaunchIntentForPackage(packageInfo.packageName).equals("")){

              System.out.println("Package Name :" + packageInfo.packageName);
              System.out.println("Launch Intent For Package :"   +
                      pm.getLaunchIntentForPackage(packageInfo.packageName));
              System.out.println("Application Label :"   + pm.getApplicationLabel(packageInfo));

              if(packageInfo.packageName.toLowerCase().equals(pacId.toLowerCase())) {
                  startActivity(pm.getLaunchIntentForPackage(packageInfo.packageName));
                  return  true;
              }
          }
      }
      return  false;
  }
 

}
