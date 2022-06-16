// Copyright (C) 2021 Cycan Technologies

pragma solidity ^0.8.0;


interface IMysteryBox {
	//盲盒池结构
	struct BoxPool {
		uint 		poolId;				//盲盒池id， id为0的为主池
		string		name;
		uint 		price;
		uint32		feeRatio;			//手续费比例，4位精度， 4项和为100%
		uint32 		ownerRatio;			//作者或众筹收入比例
		uint32 		fundRatio;			//去中心化基金比例
		uint32 		rewardRatio;		//奖励池比例
		bool  		isValid;		//是否有效
	}
	//最小手续费，4位精度
	function minFeeRatio() external view returns(uint);
	//最大减免费，4位精度
	function maxFeeDiscount() external view returns(uint);
	//盲盒池
	function getBoxPool(uint poolId_) external view returns(BoxPool memory);
	//准备创建盲盒包
	function preparePackage(uint worksId_, uint NFTtokenId_, uint count_) external;
	//创建盲盒包
	function createPackage(uint worksId_, uint NFTtokenId_, uint count_) external;

	//售出一个盲盒包
	function packageSold(uint worksId_) external;
	//打开一个盲盒包, 取一个NFT
	function packageOpened(uint worksId_, uint NFTtokenId_) external;
	//设置最大减免折扣，4位精度
	function setMaxFeeDiscount(uint maxFeeDiscount_) external;


	//获取池总数
	function getPoolCount() external view returns(uint);
	//获取池的信息, 返回价格，分成比例，是否有效，名字
	function  getPoolInfo(uint poolId_) external view returns(uint, uint32[4] memory, bool, string memory);
	//获取池中盲盒包数量
	function getPackageCount(uint poolId_) external view returns(uint);
	//获取池中盲盒包
	function getPackage(uint poolId_, uint index_) external view returns(uint);
	//获取盲盒包NFT数量信息 返回NFT总数， 剩下数量， 未出售数量
	function getPackageNFTCount(uint worksId_) external view returns(uint, uint, uint);
	//获取盲盒包池数量
	function getPackagePoolCount(uint worksId_) external view returns(uint);
	//获取盲盒包池信息, 返回池Id
	function getPacakgePool(uint worksId_, uint index_) external view returns(uint);
	//获取盲盒包NFT信息, NFTTokenId, 数量， 剩下数量
	function getPackageNFTInfo(uint worksId_, uint index_) external view returns(uint, uint, uint);

	//获取盲盒包NFTtokenID数组
	function getPackageNFTtokenID(uint worksId_) external view  returns(uint[] memory);
	//获取盲盒包NFTtokenID数组长度
	function getPackageNFTsLength(uint worksId_) external view  returns(uint);
	//查询某NFTId是否已在盲盒池中
	function isInPackage(uint worksId_, uint nftId_) external view returns(bool);
	//获取盲盒包某个NFT剩下数量
	function getPackageNFTremained(uint worksId_, uint NFTtokenId_) external view returns(uint);
	//获取池中未出售盲盒数量和剩余盲盒数量
	function getCountInfoOfPool(uint poolId_) external view returns(uint unsoldTotal_, uint remained_);
	//查询某poolId池子是否存在
	function isPoolExisted(uint poolId_) external view returns(bool);

	event CreatePool(address indexed sender, uint indexed poolId, string indexed poolName);
	event DeletePool(address indexed sender, uint indexed poolId, string indexed poolName);
	event CreatePackage(address indexed sender, uint indexed worksId, uint total);
}
