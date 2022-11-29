1.运行前先podInstall
2.导入TTBox,不要选Copy items if needed
3.导入TTBox里的TTThirdSDK，同样不要选Copy items if needed
4.R.swift接入
// R.swift接入流程
Add pod 'R.swift' to your Podfile and run pod install
In Xcode: Click on your project in the file list, choose your target under TARGETS, click the Build Phases tab and add a New Run Script Phase by clicking the little plus icon in the top left
Drag the new Run Script phase above the Compile Sources phase and below Check Pods Manifest.lock, expand it and paste the following script:
"$PODS_ROOT/R.swift/rswift" generate "$SRCROOT/R.generated.swift"
Add $TEMP_DIR/rswift-lastrun to the "Input Files" and $SRCROOT/R.generated.swift to the "Output Files" of the Build Phase
Build your project, in Finder you will now see a R.generated.swift in the $SRCROOT-folder, drag the R.generated.swift files into your project and uncheck Copy items if needed