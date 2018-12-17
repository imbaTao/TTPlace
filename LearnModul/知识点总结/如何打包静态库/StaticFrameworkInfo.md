静态库 使用cocopods 打包方法 

1.创建工程
pod lib create MytestDemo

2.验证本地库 
pod lib lint MytestDemo.podspec --verbose --use-libraries --allow-warnings

3.打tag
git tag 0.1.0

git push --tags

4.安装一个 CocoaPods 打包插件
sudo gem install cocoapods-packager

5.打包库（注意文件夹类型）
pod package MytestDemo.podspec --no-mangle --force

详情见：https://www.jianshu.com/p/c32534076250




遇到的证书坑失效,将淘宝镜像源更换rubychina源方法
https://gems.ruby-china.com/
我的静态库git地址：https://github.com/imbahong/ImbaBox


个人使用流程
先更改项目中的版本号，然后打包tag
git tag 0.1.2
git push --tags

打包库
pod package ImbaBox.podspec --no-mangle --force

验证待发布的库
pod spec lint ImbaBox.podspec

发布
pod trunk push ImbaBox.podspec --verbose --use-libraries --allow-warnings

