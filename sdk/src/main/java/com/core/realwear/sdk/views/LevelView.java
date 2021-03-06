/*
 * RealWear Development Software, Source Code and Object Code
 * (c) RealWear, Inc. All rights reserved.
 * <p>
 * Contact info@realwear.com for further information about the use of this code.
 */
package com.core.realwear.sdk.views;

import android.content.Context;
import android.content.res.TypedArray;
import android.support.annotation.Nullable;
import android.text.TextUtils;
import android.util.AttributeSet;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.RadioButton;
import android.widget.TextView;

import com.core.realwear.sdk.R;

/**
 * Created by William on 06/04/2017.
 */
public class LevelView extends LinearLayout {
    private TextView mLabelTextView;

    private RadioButton[] mLevelButtons;

    private int mLevel;
    private String mContentDescriptionTemplate;

    private OnLevelSelectedListener mOnLevelSelectedListener;

    private OnClickListener mButtonOnClickListener = new OnClickListener() {
        @Override
        public void onClick(View v) {
            mLevel = (int) v.getTag();
            updateButtonStates();

            if (mOnLevelSelectedListener != null) {
                mOnLevelSelectedListener.onLevelSelected(mLevel);
            }
        }
    };

    public LevelView(Context context) {
        this(context, null);
    }

    public LevelView(Context context, AttributeSet attrs) {
        this(context, attrs, 0);
    }

    public LevelView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);

        final String text;
        final TypedArray a = context.getTheme().obtainStyledAttributes(attrs, R.styleable.LevelView, defStyleAttr, 0);
        try {
            final int level = a.getInt(R.styleable.LevelView_level, 1);
            mLevel = Math.min(Math.max(1, level), 5);

            text = a.getString(R.styleable.LevelView_text);

            mContentDescriptionTemplate = a.getString(R.styleable.LevelView_content_description_template);
        } finally {
            a.recycle();
        }

        initialiseViews(context, text);
    }

    /**
     * Sets the string value of the TextView. TextView <em>does not</em> accept
     * HTML-like formatting, which you can do with text strings in XML resource files.
     * To style your strings, attach android.text.style.* objects to a
     * {@link android.text.SpannableString SpannableString}, or see the
     * <a href="{@docRoot}guide/topics/resources/available-resources.html#stringresources">
     * Available Resource Types</a> documentation for an example of setting
     * formatted text in the XML resource file.
     */
    public void setText(CharSequence text) {
        mLabelTextView.setText(text);
    }

    /**
     * Return the text the TextView is displaying.
     */
    public CharSequence getText() {
        return mLabelTextView.getText();
    }

    /**
     * Set's the level value of the LevelView.
     */
    public void setLevel(int level) {
        mLevel = level;
        updateButtonStates();
    }

    /**
     * Return the current level set by the LevelView.
     */
    public int getLevel() {
        return mLevel;
    }

    @Override
    public void setOnClickListener(@Nullable OnClickListener l) {
        throw new UnsupportedOperationException("Use the OnLevelSelectedListener instead of this. " +
                "Due to the way WearHF was built, if a ViewGroup (like this one) is clickable, " +
                "has no text, but has child nodes that 1. have text and 2. aren't clickable then, " +
                "the child node text will be used for this view. This results in things like " +
                "adding a voice command Select Volume 1-5, which gets translated to " +
                "Select Volume 15");
    }

    public void setOnLevelSelectedListener(OnLevelSelectedListener onLevelSelectedListener) {
        mOnLevelSelectedListener = onLevelSelectedListener;
    }

    /**
     * Initialise the views that make up this control.
     *
     * @param context
     * @param text
     */
    private void initialiseViews(Context context, String text) {
        View.inflate(context, R.layout.radio_button_layout, this);

        mLabelTextView = findViewById(R.id.text);
        mLabelTextView.setText(text);

        final RadioButton level1Button = findViewById(R.id.level_1);
        level1Button.setTag(1);

        final RadioButton level2Button = findViewById(R.id.level_2);
        level2Button.setTag(2);

        final RadioButton level3Button = findViewById(R.id.level_3);
        level3Button.setTag(3);

        final RadioButton level4Button = findViewById(R.id.level_4);
        level4Button.setTag(4);

        final RadioButton level5Button = findViewById(R.id.level_5);
        level5Button.setTag(5);

        // Store the buttons in an array to make them easier to access.
        mLevelButtons = new RadioButton[]{level1Button, level2Button, level3Button, level4Button, level5Button};

        // Assign the on click to each button.
        for (Button button : mLevelButtons) {
            if (!TextUtils.isEmpty(mContentDescriptionTemplate)) {
                button.setContentDescription(String.format(mContentDescriptionTemplate, button.getTag()));
            }
            button.setOnClickListener(mButtonOnClickListener);
        }

        // Update the state of the buttons so the correct one is selected.
        updateButtonStates();
    }

    private void updateButtonStates() {
        // Select the button that need selecting.
        for (RadioButton button : mLevelButtons) {
            button.setChecked((int) button.getTag() <= mLevel);
        }
    }

    public interface OnLevelSelectedListener {
        void onLevelSelected(int level);
    }
}
