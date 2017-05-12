package com.core.realwear.sdk.util;

/**
 * Created by Fin on 05/09/2016.
 */
public class ExtensionTypes {

    public enum Supported{
        PDF,
        PNG,
        JPEG,
        MP4,
        MKV,
        GPP,
        WEBM,
        WEBP,
        BMP,
        MOV,
        GIF,
        AVI,
        NOT_SUPPORTED;
    }

    public static final String PNG = ".png";
    public static final String PDF = ".pdf";
    public static final String BMP = ".bmp";
    public static final String JPEG = ".jpeg";
    public static final String JPG = ".jpg";
    public static final String MP4 = ".mp4";
    public static final String MKV = ".mkv";
    public static final String GP = ".3gp";
    public static final String GPP = ".3gpp";
    public static final String WEBM = ".webm";
    public static final String WEBP = ".webp";
    public static final String MOV = ".mov";
    public static final String GIF = ".gif";
    public static final String AVI = ".avi";

    public static Supported ParseLocationToType(String location)
    {
        if(location.toLowerCase().endsWith(PNG)){
            return Supported.PNG;
        }else if(location.toLowerCase().endsWith(PDF)){
            return Supported.PDF;
        }else if(location.toLowerCase().endsWith(JPEG) || location.toLowerCase().endsWith(JPG)) {
            return Supported.JPEG;
        }else if(location.toLowerCase().endsWith(MP4)) {
            return Supported.MP4;
        }else if(location.toLowerCase().endsWith(BMP)) {
            return Supported.BMP;
        }
        else if(location.toLowerCase().endsWith(WEBP)) {
            return Supported.WEBP;
        }
        else if(location.toLowerCase().endsWith(MKV)) {
            return Supported.MKV;
        }
        else if(location.toLowerCase().endsWith(GPP) || location.toLowerCase().endsWith(GP)) {
            return Supported.GPP;
        }
        else if(location.toLowerCase().endsWith(WEBM)) {
            return Supported.WEBM;
        }
        else if(location.toLowerCase().endsWith(MOV)) {
            return Supported.MOV;
        }
        else if(location.toLowerCase().endsWith(GIF)) {
            return Supported.GIF;
        }
        else if(location.toLowerCase().endsWith(AVI)) {
            return Supported.AVI;
        }

        return Supported.NOT_SUPPORTED;
    }

    public static boolean isImage(String location) {
        switch (ParseLocationToType(location)) {
            case PNG:
            case JPEG:
            case WEBP:
            case BMP:
            case GIF:
                return true;

            default:
                return false;
        }
    }

    public static boolean isVideo(String location) {
        switch (ParseLocationToType(location)) {
            case MP4:
            case MKV:
            case GPP:
            case WEBM:
            case MOV:
            case AVI:
                return true;

            default:
                return false;
        }
    }

    public static boolean isPdf(String location) {
        return ParseLocationToType(location) == Supported.PDF;
    }

}
