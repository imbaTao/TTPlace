//
//  MyProfileViewModel.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/2/27.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation

//class MyProfileDetailInfoSubLevelModel: HandyJSON {
//    required init() {
//
//    }
//}


class MyProfileDetailInfoModel: TTTableViewStaticListModel {
    var oneLineData = [String]()
    var twoLineData = [String]()
    
    var secondLevelData = [[String]]()
    var workData = [MyProfileDetailWorkInfoModel]()
    var isEmpty: Bool {
        return subContent.isEmpty
    }
}

class MyProfileDetailWorkInfoModel: HandyJSON {
    var id: String = ""
    var name: String = ""
    var subModel: MyProfileDetailWorkInfoModel = MyProfileDetailWorkInfoModel()
    
    required init() {
        
    }
}



class MyProfileDetailInfoViewModel: NSObject {
    
    var data = [[MyProfileDetailInfoModel]]()
    
    override init() {
        super.init()
        fetchData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchData() {
        let model1 =  MyProfileDetailInfoModel.init()
        model1.mainContent = "头像"
        model1.subContent = "请上传看得到本人人脸的头像"
        model1.iconName = ""
        
        
        let model2 =  MyProfileDetailInfoModel.init()
        model2.mainContent = "昵称"
        model2.subContent = "xxx的昵称"
        model2.type = .two
        
        let model3 =  MyProfileDetailInfoModel.init()
        model3.mainContent = "性别"
        model3.subContent = "xxx的性别"
        model3.oneLineData = ["男","女"]
        
        let model4 =  MyProfileDetailInfoModel.init()
        model4.mainContent = "年龄"
        model4.subContent = "xxx岁"
        for age in 18..<60 {
            model4.oneLineData.append("\(age)岁")
        }
        
        let model5 =  MyProfileDetailInfoModel.init()
        model5.mainContent = "当前所在地"
        model5.subContent = "xxx所在"
        
        let model6 =  MyProfileDetailInfoModel.init()
        model6.mainContent = "身高"
        model6.subContent = "xxx"
        for height  in 150..<199 {
            model6.oneLineData.append("\(height)")
        }
        
        let model7 =  MyProfileDetailInfoModel.init()
        model7.mainContent = "老家"
        model7.subContent = "xxx"
        model7.oneLineData = ["湖北"]
        
        
        
        let model8 =  MyProfileDetailInfoModel.init()
        model8.mainContent = "月收入"
        model8.subContent = "xxx"
        for money in 1..<6 {
            model8.oneLineData.append("\(money * 2000)")
            model8.twoLineData.append("\(money * 2000)")
        }
        
        
        
        let model9 =  MyProfileDetailInfoModel.init()
        model9.mainContent = "职业"
        model9.subContent = "xxx"
        model9.workData = fetchWorkModel()
        
        
        let model10 =  MyProfileDetailInfoModel.init()
        model10.mainContent = "婚姻状况"
        model10.subContent = "xxx"
        model10.oneLineData = ["未婚","离异无孩子","丧偶","离异带孩子"]
        
        
        let model11 =  MyProfileDetailInfoModel.init()
        model11.mainContent = "有无孩子"
        model11.subContent = "xxx"
        model11.oneLineData = ["没有","有一个","有一个以上"]

        
        let model12 =  MyProfileDetailInfoModel.init()
        model12.mainContent = "住房情况"
        model12.subContent = "xxx"
        model12.oneLineData = ["已买","未买","保密"]
          
        
        
        let model13 =  MyProfileDetailInfoModel.init()
        model13.mainContent = "买车情况"
        model13.subContent = "xxx"
        model13.iconName = ""
        model13.oneLineData = ["已买","未买","保密"]
        
        data = [
            [model1,model2],
            [model3,model4,model5,model6,model7,model8],
            [model9,model10,model11,model12,model13],
        ]
    }
    
    
    
    
}

func fetchWorkModel() -> [MyProfileDetailWorkInfoModel] {
    
    //一级分类
    let oneLevelStrs = ["AA", "农林牧业", "CE", "通讯电子", "CM", "文化传媒", "EP", "能源环保", "ET", "教育培训", "FC", "金融", "IT", "IT互联网", "LI", "轻工贸易", "MB", "医疗生物", "MF", "生产制造", "OT", "其他", "PW", "政法公益", "RE", "房产建筑", "SI", "服务业"]
    
    let secondLevelStrs = [
        ["AA01", "兽医", "AA02", "饲养", "AA03", "养殖", "AA04", "销售", "AA05", "项目管理", "AA06", "技术员", "AA07", "加工/质检", "AA08", "市场商务", "AA09", "机械设备"],
        ["CE01", "销售", "CE02", "生产制造", "CE03", "技工普工", "CE04", "硬件研发", "CE05", "工程/维护", "CE06", "经营管理", "CE07", "市场商务", "CE08", "行政人员", "CE09", "工业设计", "CE10", "采购物控", "CE11", "增值业务"],
        ["CM01", "设计", "CM02", "动画", "CM03", "行政人事", "CM04", "销售", "CM05", "品牌", "CM06", "公关", "CM07", "策划", "CM08", "高管", "CM08", "自由撰稿人", "CM09", "艺人", "CM10", "经纪人", "CM11", "演出/会展", "CM12", "市场商务", "CM13", "编导制作", "CM14", "编辑记者", "CM15", "艺术家", "CM16", "收藏", "CM17", "出版发行"],
        ["EP01", "能源/矿工", "EP02", "地质勘查", "EP03", "环境科学", "EP04", "环保"],
        ["ET01", "市场销售", "ET02", "幼教", "ET03", "艺术体育", "ET04", "职业技能", "ET05", "培训讲师", "ET06", "人民教师", "ET07", "行政人事", "ET08", "教务/管理", "ET09", "课外辅导", "ET10", "科研/学者", "ET11", "中专技校", "ET12", "移民留学", "ET13", "特岗教师"],
        ["FC01", "销售/理财", "FC02", "银行", "FC03", "财税/审计", "FC04", "交易证券", "FC05", "高管", "FC06", "市场商务", "FC07", "风投/投行", "FC08", "担保/信贷", "FC09", "保险", "FC10", "人力资源", "FC11", "行政后勤", "FC12", "客户服务", "FC13", "融资租赁", "FC14", "咨询服务", "FC15", "拍卖典当"],
        ["IT01", "研发", "IT01", "设计", "IT01", "销售", "IT01", "运营/编辑", "IT01", "产品", "IT01", "市场商务", "IT01", "高管", "IT01", "运营/安全", "IT01", "人力HR", "IT01", "行政后勤", "IT01", "测试", "IT01", "客服", "IT01", "项目管理"],
        ["LI01", "销售", "LI02", "纺织服装", "LI03", "贸易进出口", "LI04", "采购", "LI05", "仓储/物流", "LI06", "食品饮料", "LI07", "建材家居", "LI08", "商贸百货", "LI09", "包装印刷", "LI10", "市场商务", "LI11", "行政人事", "LI12", "工艺礼品", "LI13", "产品设计", "LI14", "产品研发", "LI15", "珠宝首饰", "LI16", "质检/认证", "LI17", "机电仪表", "LI18", "客服"],
        ["MB01", "销售", "MB02", "医生", "MB03", "护士/护理", "MB04", "保健按摩", "MB05", "行政人事", "MB06", "经营管理", "MB07", "市场商务", "MB08", "医生生产", "MB09", "医学研发", "MB10", "辅诊/药剂", "MB11", "宠物"],
        ["MF01", "生产管理", "MF02", "生产运营", "MF03", "销售与服务", "MF04", "电子/电器", "MF05", "汽车", "MF06", "机械制造", "MF07", "服装/纺织", "MF08", "技工", "MF09", "生物/制药", "MF10", "医疗器械", "MF11", "化工"],
        ["OT01", "自由职业", "OT02", "社会工作者", "OT03", "学生"],
        ["PW01", "国家机关", "PW02", "事业单位", "PW03", "科研机构", "PW04", "国企", "PW05", "后勤人事", "PW06", "公安/司法", "PW07", "律师/法务", "PW08", "军队武警", "PW09", "社团协会", "PW10", "咨询", "PW11", "顾问", "PW12", "调研", "PW13", "数据分析", "PW14", "翻译"],
        ["RE01", "装修施工", "RE02", "销售", "RE03", "经纪人", "RE04", "设计规划", "RE05", "项目管理", "RE06", "高管", "RE07", "市场商务", "RE08", "行政人事", "RE09", "质检造价", "RE10", "开发/物业"],
        ["SI01", "市场销售", "SI02", "娱乐/餐饮", "SI03", "经营管理", "SI04", "个体/网店", "SI05", "交通物流", "SI06", "服务/接班", "SI07", "美容/造型师", "SI08", "保健", "SI09", "酒店/旅游", "SI10", "行政后勤", "SI11", "人力HR", "SI12", "机电维修", "SI13", "安保", "SI14", "运动健身", "SI15", "家政保洁", "SI16", "客服"]
    ]
    
    var data =  [MyProfileDetailWorkInfoModel]()
    
    for i in stride( from : 0 , through : oneLevelStrs.count ,  by : 2){
        let id = oneLevelStrs[i]
        let name = oneLevelStrs[i + 1]
        let oneLevelModel = MyProfileDetailWorkInfoModel()
        oneLevelModel.id = id
        oneLevelModel.name = id
        data.append(oneLevelModel)
        
        
        
        
        let secondStrs = secondLevelStrs[i]
        for j in stride( from : 0 , through : secondStrs.count ,  by : 2){
            let id = secondStrs[j]
            let name = secondStrs[j + 1]
            let secondLevelModel = MyProfileDetailWorkInfoModel()
            secondLevelModel.id = id
            secondLevelModel.name = id
            oneLevelModel.subModel = secondLevelModel
        }
    }
    
    return data
}

