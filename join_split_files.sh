#!/bin/bash

cat product/app/TrichromeLibrary/TrichromeLibrary.apk.* 2>/dev/null >> product/app/TrichromeLibrary/TrichromeLibrary.apk
rm -f product/app/TrichromeLibrary/TrichromeLibrary.apk.* 2>/dev/null
cat product/priv-app/PrebuiltGmsCorePano/PrebuiltGmsCorePano.apk.* 2>/dev/null >> product/priv-app/PrebuiltGmsCorePano/PrebuiltGmsCorePano.apk
rm -f product/priv-app/PrebuiltGmsCorePano/PrebuiltGmsCorePano.apk.* 2>/dev/null
cat product/priv-app/AndroidMediaShell/AndroidMediaShell.apk.* 2>/dev/null >> product/priv-app/AndroidMediaShell/AndroidMediaShell.apk
rm -f product/priv-app/AndroidMediaShell/AndroidMediaShell.apk.* 2>/dev/null
cat system/system/app/PrimeVideo/PrimeVideo.apk.* 2>/dev/null >> system/system/app/PrimeVideo/PrimeVideo.apk
rm -f system/system/app/PrimeVideo/PrimeVideo.apk.* 2>/dev/null
cat system/system/app/Netflix/Netflix.apk.* 2>/dev/null >> system/system/app/Netflix/Netflix.apk
rm -f system/system/app/Netflix/Netflix.apk.* 2>/dev/null
cat system/system/preloadapp/JioPages/JioPages.apk.* 2>/dev/null >> system/system/preloadapp/JioPages/JioPages.apk
rm -f system/system/preloadapp/JioPages/JioPages.apk.* 2>/dev/null
