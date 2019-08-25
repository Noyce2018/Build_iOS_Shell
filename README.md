# Build_iOS_Shell
构建iOS相关命令
当前只搞了adhoc版内测包的打法，现详细说明
0. xcodebuildADHOC与ADHOCExportOptionsPlist与xcodeproj在同一路径下
1.ExportOptionsPlist里:
1.1:provisioningProfiles属性的值为:XXXX.mobileprovision
1.2:value里是XXXX.mobileprovision
2.xcodebuildADHOC中的全局变量配置
#工程名字(Target名字)
Project_Name=""
#配置环境，Release或者Debug
Configuration="Release"
#AdHoc版本的Bundle ID
AdHocBundleID=""
#证书名#描述文件:个人或公司
ADHOCCODE_SIGN_IDENTITY="iPhone Distribution:XXX(个人或公司名)"
ADHOCPROVISIONING_PROFILE_NAME="描述文件名不用加后缀"
3. .strings文件的编码格式
在Xcode10中，此文件编码格式未被取为utf-8，需要手动改，否则编译报错

