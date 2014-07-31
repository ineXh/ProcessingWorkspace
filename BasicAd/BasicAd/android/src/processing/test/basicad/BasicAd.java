package processing.test.basicad;
import android.os.Bundle;
import android.widget.LinearLayout;

import com.google.ads.*;
import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdSize;
import com.google.android.gms.ads.AdView;

import android.os.Bundle;
import android.view.Gravity;
import android.view.Window;
import android.widget.RelativeLayout;
import com.google.ads.*;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class BasicAd extends PApplet {

	public void setup(){
	    background(255, 0, 0);
	}
	
	public void draw(){
	  //background(0);
	  strokeWeight(6);
	  line(pmouseX, pmouseY, mouseX, mouseY);
	}
	
	 private AdView adView;

	  /* Your ad unit id. Replace with your actual ad unit id. */
	  private static final String AD_UNIT_ID = "a14d7f7d2180609";
	  
	  /** Called when the activity is first created. */
	  /*
	  @Override
	  public void onCreate(Bundle savedInstanceState) {
	    super.onCreate(savedInstanceState);
	    setContentView(R.layout.main);

	    // Create an ad.
	    adView = new AdView(this);
	    adView.setAdSize(AdSize.BANNER);
	    adView.setAdUnitId(AD_UNIT_ID);

	    // Add the AdView to the view hierarchy. The view will have no size
	    // until the ad is loaded.
	    LinearLayout layout = (LinearLayout) findViewById(R.id.linearLayout);
	    layout.addView(adView);

	    // Create an ad request. Check logcat output for the hashed device ID to
	    // get test ads on a physical device.
	    AdRequest adRequest = new AdRequest.Builder()
	        .addTestDevice(AdRequest.DEVICE_ID_EMULATOR)
	        .addTestDevice("43423541314439565659")
	        .build();

	    // Start loading the ad in the background.
	    adView.loadAd(adRequest);
	  }*/
	  
	  @Override
      public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Window window = getWindow();
        RelativeLayout adsLayout = new RelativeLayout(this);
        RelativeLayout.LayoutParams lp2 = new RelativeLayout.LayoutParams(
               RelativeLayout.LayoutParams.WRAP_CONTENT, RelativeLayout.LayoutParams.FILL_PARENT);
         // Displays Ads at the bottom of your sketch, use Gravity.TOP to display them at the top
        adsLayout.setGravity(Gravity.BOTTOM);
        adView = new AdView(this);
	    adView.setAdSize(AdSize.BANNER);
	    adView.setAdUnitId(AD_UNIT_ID);
        adsLayout.addView(adView);
	    AdRequest adRequest = new AdRequest.Builder()
        .addTestDevice(AdRequest.DEVICE_ID_EMULATOR)
        .addTestDevice("43423541314439565659")
        .build();
        // Remark: uncomment next line for testing your Ads (fake ads)
        //newAdReq.setTesting(true);
        adView.loadAd(adRequest);
        window.addContentView(adsLayout,lp2);
	  }

}
