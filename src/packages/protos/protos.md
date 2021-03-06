[返回主页](/index.html)
#protobuf定义
```protobuf
syntax = "proto3";
package pb;

/*
	Pack==1
	Error==2
	Operation==3
	CreateRole==4
	EnterChapter==5

	Delete==11
	SigninRecord==12
	SigninGet==13
	MapRecordSave==15

	ShopRecord==21
	ShopBuy==22
	
	OpenBox==31
	GainBox==32

	FinishMission==51
	MissionEvent==52
	FinishAchv==53
	TalentUnlock==54

	Role==101
	Chapters==102
	MissionList==105
	Boxes==106
	Props==107
	Rewards==108
	AchvList==109
	Talents==110

	Chapter==1021
	Box==1061
	Prop==1071
	MissionItem==1051
	AchvItem==1091
*/
message Pack{
	int32 type = 1;
	bytes content = 2; //actions的参数
	int32 msgid = 3;
}

message Error{
	enum EType{
		None = 0;
		UserLoggedIn = 1; //用户已经登陆
		NoSetNickname = 2; //没有设置好用户名
		NoneConfigID = 3; //缺少Config ID
		NoneID = 4; //缺少参数ID
		NoneConfig = 5; //缺少配置文件
		Unfinished = 6; //未完成
		NoAccept = 7; //没达到条件，不接受
		NoParam = 8; //缺少参数
		UnExpectedError = 10; //不期望的错误
		ConfigError = 11; //配置表错误
		OutOfDate = 12; //已经过期
		LessGold = 13; //金币不够
		LessDiamond = 14;//钻石不够
		LessTimes = 15;//超出次数
		LessProp = 16; //缺少道具
		LessTech = 17; //缺少科技点
		NoneRole = 1001; //还没有创建角色
		NoneProp = 1002; //道具不存在
		NoneEquipment = 1003; //装备不存在
		NoneBox = 1004; //箱子不存在
		NoneGold = 1005; //金币不足
		NonoDiamond = 1006; //钻石不足

		NoneMission = 1011; //找不到任务

		OperationNotPermit = 2001; //操作不允许
		NotBuy = 3001; //没有购买
	}
	EType code = 1; //错误码
	int32 type = 2;
}

message Operation{
	bool result = 1;
	int32 type = 2;
}

//Server Command
/*
ID 名称说明
id: 道具ID，存储的ID
cid: 配置表ID
oid：配置表中的originalId
*/
//创建角色命令
message CreateRole{
	string nickname = 1; //昵称
}

//进入章节
message EnterChapter{
	int32 cid = 1; //进入章节
}

//打开箱子
message OpenBox{
	int32 id = 1;
}
//收取箱子里的物品
message GainBox{
	int32 id = 1;
}

message Delete{
	int32 id = 1; //需要删除的id
	int32 type = 2; // 需要删除的类型
}

message Vector{
	float x = 1;
	float y = 2;
	float z = 3;
}

//数据
message Role{
	int32 id = 1;
    int32 pid = 2;
    int32 cid = 3;
    string nickname = 4;
    int32 level = 5;
    int32 techPoint = 6; //科技点
    int32 diamond = 7;
    int32 loginTime = 8;
    int32 createTime = 9;
    int32 exp = 10;
}

message Prop{
	int32 id = 1;
	int32 rid = 2;
	int32 cid = 3;
	int32 count = 4;
}

message Props{
	repeated Prop items = 1;
}

message Chapter{
	int32 id = 1;
	int32 rid = 2;
	int32 cid = 3;
	int32 status = 4;
	bytes record1 = 5;
	bytes record2 = 6;
	bytes record3 = 7;
}

message Chapters{
	repeated Chapter items = 1;
}

//完成任务
message FinishMission{
	int32 id = 1; //mission id
}

//完成任务
message FinishAchv{
	int32 id = 1; //achv id
}

message MissionEvent{
	enum MType{
		None = 0;
		Kill = 1; //杀死怪物
		Collect = 2; //收集物品
		MakeProp = 3; //制作道具
		Build = 4; //建造
		Alive = 5; //存活
		UseDiamond = 6; //使用钻石
		UseTech = 7; //使用科技点
		UseItem = 8; //使用道具
		UpgradeTech = 9; //提升科技
		UpgradeTalent = 10; //提升天赋
		FinishMission = 11; //完成任务
		FinishChapter = 12; //通过章节
		MakeEquip = 13; //制作装备
	}

	int32 action_id = 1;
	int32 action_place = 2;
	int32 action_count = 3;
	int32 action_type = 4;
	bool action_override = 5;
}

//任务项目
message MissionItem{
	int32 id = 1;
	int32 process = 2;
	int32 cid = 3;
	int32 rid = 4;
}

//任务列表
message MissionList{
	repeated MissionItem items = 1;
}

//任务项目
message AchvItem{
	int32 id = 1;
	int32 process = 2;
	int32 cid = 3;
	int32 rid = 4;
	int32 got = 5; //0没领取，1领取了
}

//成就列表
message AchvList{
	repeated AchvItem items = 1;
}

message Box{
	int32 id = 1;
   	int32 rid = 2;
   	int32 cid = 3;
   	int32 unlockTime = 4; //解锁时间，0为未解锁，否则为解锁结束时间
}

message Boxes{
	repeated Box items = 1;
}

message Reward{
	int32 tp = 1; //1钻石，2:科技点，3:道具
	int32 id = 2;
	int32 count = 3;
}

message Rewards{
	repeated Reward items = 1;
}

message Talent{
	int32 id = 1;
	int32 rid = 2;
	int32 cid = 3;
	int32 level = 4;
}

message Talents{
	repeated Talent items = 1;
}

message TalentUnlock{
	int32 cid = 1; //配置id
	int32 level = 2; //等级
}

message SigninRecord{
	int32 times = 1;
	repeated int32 record = 2 [packed=true]; //已经签到天
}

message SigninGet{
	int32 day = 1; //获取第几天的奖励
}

message ShopBuy{
	int32 id = 1; //购买商店物品
}

message ShopRecord{
	repeated int32 id = 1 [packed=true]; //已经购买过的id
}

message CompositeItem{
	int32 id = 1;
	int32 timeEnd = 2;
}

//武器或者道具
message ItemData{
	int32 id = 1; //id
	int32 count = 2; //道具数量或者武器的子弹装载数量
	int32 hp = 3; //耐久度/血量
	int32 location = 4; //位置信息
}

//角色数据
message PlayerData{
	int32 health = 1;
	int32 stamina = 2;
	repeated ItemData props = 3;
	repeated ItemData weapons = 4;
	Vector Position = 5;
	repeated ItemData equipedProps = 6;
	repeated ItemData equipedWeapons = 7;
}

//地图记录
message MapRecord{
	repeated RecordItem towers = 1;
	repeated RecordItem items = 2;
	int64 time = 3;
}

message MapRecordSave{
	int32 id = 1;
	int32 seq = 2;
	bytes record = 3;
}

//id对应的数据
message RecordItem{
	int32 id = 1;
	bytes contents = 2;
}

//建筑数据
message BuildData{
	int32 actualID = 1;
	int32 health = 2;
	int32 upgradeTime = 3;
	int32 repairTime = 4;
	repeated CompositeItem composites = 5;
	repeated ItemData props = 6; //仓库中才使用
	repeated ItemData weapons = 7; //仓库中才使用
}

//日历数据
message CalendarData{
	int32 minutes = 1; //当前时间进度
	int32 eventid = 2; //当前事件进度
}

//塔数据
message TowerData{
	int32 actualID = 1;
	int32 health = 2;
	int32 upgradeTime = 3;
	int32 repairTime = 4;
	Vector Position = 5;
}

//任务数据
message CMissionItem{
	int32 id = 1;
	int32 process = 2;
}

//任务信息
message CMissionData{
	int32 id = 1;
	repeated CMissionItem list = 2;
	int32 refreshTime = 3;
}

//任务列表
message CMissionList{
	repeated CMissionData list = 1;
}```
