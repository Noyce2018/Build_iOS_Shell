##########################################
# 使用Xcode 命令打adhoc内测包，研究集中构建原理
# CreateBy TianBL
# 2019.8.24
#########################################
#全局变量#
#工程名字(Target名字)
Project_Name=""
#配置环境，Release或者Debug
Configuration="Release"
#AdHoc版本的Bundle ID
AdHocBundleID=""
# ADHOC
#证书名#描述文件:友邦软件
ADHOCCODE_SIGN_IDENTITY=""
ADHOCPROVISIONING_PROFILE_NAME=""
#加载ADHOC的plist文件
ADHOCExportOptionsPlist=./ADHOCExportOptionsPlist.plist
##########################################
#脚本主体：先clean再archive
#配置证书和描述文件以及签名方式
#修改相关文件为utf-8编码
#########################################
#脚本与xcode工程记得在统一路径下

#clean
xcodebuild clean -xcodeproj ./$Project_Name/$Project_Name.xcodeproj -configuration $Configuration -alltargets

#set ProvisioningStyle = Manual
sed -i "" s/'ProvisioningStyle = Automatic;'/'ProvisioningStyle = Manual;'/g $Project_Name.xcodeproj/project.pbxproj

#set CODE_SIGN_STYLE = Manual
sed -i "" s/'CODE_SIGN_STYLE = Automatic;'/'CODE_SIGN_STYLE = Manual;'/g $Project_Name.xcodeproj/project.pbxproj

#set Provisioning
#PROVISIONING_PROFILE_SPECIFIER = 后面写上描述文件的名字
sed -i "" s/'PROVISIONING_PROFILE_SPECIFIER = "";'/'PROVISIONING_PROFILE_SPECIFIER = ;'/g $Project_Name.xcodeproj/project.pbxproj
#change to utf-8
sed -i "" s/'isa = PBXFileReference; explicitFileType = undefined; fileEncoding = 9; includeInIndex = 0; lastKnownFileType = unknown; path = QBImagePicker.strings;'/'isa = PBXFileReference; explicitFileType = undefined; fileEncoding = 4; includeInIndex = 0; lastKnownFileType = unknown; path = QBImagePicker.strings;'/g $Project_Name.xcodeproj/project.pbxproj
#adhoc打包
xcodebuild -project $Project_Name.xcodeproj -scheme $Project_Name -configuration $Configuration -archivePath build/$Project_Name-adhoc.xcarchive clean archive build CODE_SIGN_IDENTITY="${ADHOCCODE_SIGN_IDENTITY}" PROVISIONING_PROFILE="${ADHOCPROVISIONING_PROFILE_NAME}" PRODUCT_BUNDLE_IDENTIFIER="${AdHocBundleID}"
xcodebuild -exportArchive -archivePath build/$Project_Name-adhoc.xcarchive -exportOptionsPlist $ADHOCExportOptionsPlist -exportPath ~/Desktop/$Project_Name-adhoc.ipa


