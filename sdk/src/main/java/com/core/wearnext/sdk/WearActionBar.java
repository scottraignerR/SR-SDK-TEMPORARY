package com.core.wearnext.sdk;

import android.content.Context;
import android.util.AttributeSet;
import android.view.View;

/**
 * Created by Fin on 23/08/2016.
 */
public class WearActionBar extends View {
    public WearActionBar(Context context) {
        super(context);
    }

    public WearActionBar(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public WearActionBar(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        init();
    }

    protected void init(){
        //View.inflate(getContext(), R.layout.gi_button_layout, this);
    }
}