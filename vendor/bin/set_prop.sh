#! /system/bin/sh
settings put global nrdp_audio_platform_capabilities '{
  "audiocaps": {
    "continuousAudio" : true,
    "pcm" : {
      "mixing" : true,
      "easing" : true
    },
    "ddplus" : {
      "mixing" : true,
      "easing" : true
    },
    "atmos" : {
      "enabled" : true,
      "mixing" : true,
      "easing" : true
    }
  }
}'
