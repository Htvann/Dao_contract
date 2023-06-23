// SPDX-License-Identifier: MIT
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

pragma solidity ^0.8.9;

interface IAIHomesDao {
    function profilesLength() external returns (uint256 length);
    function isOwnDao(address by) external returns (bool);
    function profilesById(
        uint256 _id
    )
        external
        returns (uint256 id, string memory name, address owner, uint256 option);
}

contract AihomeDaoStaking is Pausable, Ownable {
    //NOTE: testnet
    // address constant HOMES = 0x8402c360a9C1C9214D870c00835450899bC4F318;
    // address constant AIHomesDao = 0xf355A894C449D81570E5C4B7da43Ca266987808c;

    //NOTE: local
    address constant HOMES = 0x5FbDB2315678afecb367f032d93F642f64180aa3;
    address constant AIHomesDao = 0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9;

    address public accountReceiveTicketPrice;
    address public accountReceiveStaking;

    struct ProfileDao {
        uint256 totalMember;
        uint256 totalStake;
    }

    struct ProfileMember {
        uint256 id;
        string name;
        uint256 daoId;
        address addressUser;
        uint256 amountStaking;
        uint256 timeJoinDao;
        uint256 timeLeaveDao;
        string status;
    }

    mapping(address => ProfileMember) public profileMemberDao;
    mapping(address => bool) public isMemberDao;
    mapping(uint256 => ProfileDao) public profileDaoById;
    mapping(uint256 => mapping(uint256 => address)) private getAddressDaoById;
    mapping(string => bool) public isExistName;

    event JoinDao(address by,string name, uint256 timestamp, uint256 amount, uint256 idDao);
    event LeaveDao(address by, uint256 timeJoinDao, uint256 idDao);

    constructor(
        address _accountReceiveTicketPrice,
        address _accountReceiveStaking
    ) {
        accountReceiveTicketPrice = _accountReceiveTicketPrice;
        accountReceiveStaking = _accountReceiveStaking;
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function joinDao(uint256 _id, string memory _name) public whenNotPaused {
        ProfileMember memory info;
        require(isMemberDao[msg.sender] == false, "you are a member of dao");
        require(IAIHomesDao(AIHomesDao).isOwnDao(msg.sender)==false, 'you are owner dao');
        require(isExistName[_name] == false, "Name already exist");
        require(bytes(_name).length > 0, "Invalid name");
        require(
            _id <= IAIHomesDao(AIHomesDao).profilesLength(),
            "dao id does not exist"
        );
        (, , , uint256 _option) = IAIHomesDao(AIHomesDao).profilesById(_id);

        uint256 priceStake;

        if (_option == 1) {
            priceStake = 40 ether;
        } else if (_option == 2) {
            priceStake = 60 ether;
        } else {
            priceStake = 100 ether;
        }
        require(
            IERC20(HOMES).balanceOf(msg.sender) >= priceStake,
            "not enough money to trade"
        );
        require(
            block.timestamp >
                profileMemberDao[msg.sender].timeLeaveDao + 30 days,
            "not enough time"
        );

        IERC20(HOMES).transferFrom(
            msg.sender,
            accountReceiveTicketPrice,
            priceStake
        );

        profileDaoById[_id].totalStake += priceStake;

        info.addressUser = msg.sender;
        info.daoId = _id;
        info.name = _name;
        info.amountStaking = priceStake;
        info.timeJoinDao = block.timestamp;
        info.status = "active";
        isMemberDao[msg.sender] = true;
        profileDaoById[_id].totalMember++;
        info.id = profileDaoById[_id].totalMember;

        profileMemberDao[msg.sender] = info;
        getAddressDaoById[_id][info.id] = msg.sender;

        isExistName[_name] = true;
        emit JoinDao(msg.sender, _name, block.timestamp, priceStake, _id);
    }

    function leaveDao() public whenNotPaused {
        ProfileMember storage info = profileMemberDao[msg.sender];
        require(isMemberDao[msg.sender] == true, "you are not a member of dao");

        IERC20(HOMES).transferFrom(
            accountReceiveTicketPrice,
            msg.sender,
            profileMemberDao[msg.sender].amountStaking
        );

        profileDaoById[profileMemberDao[msg.sender].daoId]
            .totalStake -= profileMemberDao[msg.sender].amountStaking;

        isMemberDao[msg.sender] = false;
        info.status = "inActive";
        info.timeLeaveDao = block.timestamp;

        isExistName[profileMemberDao[msg.sender].name] = false;
        emit LeaveDao(msg.sender, block.timestamp, info.timeLeaveDao);
    }

    function getInfoMemberById(
        uint256 _id,
        uint256 _index
    ) public view returns (ProfileMember memory) {
        address add = getAddressDaoById[_id][_index];
        ProfileMember memory member = profileMemberDao[add];
        return member;
    }
}
