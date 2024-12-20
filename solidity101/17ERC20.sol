// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol"; // 引入 OpenZeppelin 的 IERC20 接口
import "@openzeppelin/contracts/utils/Context.sol";     // 用于操作 msg.sender 的辅助工具

contract MyToken is Context, IERC20 {
    string private _name; // 代币名称
    string private _symbol; // 代币符号
    uint8 private _decimals; // 小数位
    uint256 private _totalSupply; // 总供应量
    mapping(address => uint256) private _balance; // 余额
    mapping (address => mapping (address => uint256)) private _allowance; // 授权额度
    address public realFrom;

    constructor(string memory name_, string memory symbol_, uint256 initialSupply) {
        _name = name_;
        _symbol = symbol_;
        _decimals = 18; // 一般默认为18
        _mint(_msgSender(), initialSupply * 10 ** uint256(_decimals)); // 铸造初始供应量
    }
    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "erc20 not avaliable");
        _totalSupply += amount;
        _balance[account] += amount;
        emit Transfer(address(0), account, amount);
    }
    function name() public view returns(string memory) {
        return _name;
    }
    function symbol() public view returns(string memory) {
        return _symbol;
    }
    function decimals() public view returns (uint8) {
        return _decimals;
    }
    function totalSupply() public view override  returns (uint256) {
        return _totalSupply;
    }

    function allowance(address owner, address spender) external view returns (uint256){
    return _allowance[owner][spender];
    }
    // 授权功能
    function approve(address spender, uint256 value) external returns (bool) {
        _approve(_msgSender(), spender, value);
        return true;
    }
    // 内部授权
    function _approve(address owner, address spender, uint256 value) internal {
        require(owner != address(0), "cannot be zero");
        require(spender != address(0), "cannot be zero");
        _allowance[owner][spender] = value;
        emit Approval(owner, spender, value);
    }
    // 获取指定地址余额
    function balanceOf(address account) external view returns (uint256) {
    return _balance[account];
    }

    // 转账功能
    function transfer(address to, uint256 value) external override returns (bool) {
        _transfer(_msgSender(), to, value);
        return true;
    }
    // 授权转账,授权是不涉及代币的资金变化的，只有转账才能让代币数量发生变化
    function transferFrom(address from, address to, uint256 value) external returns (bool){
        _transfer(from, to, value);
        _approve(from, _msgSender(), _allowance[from][_msgSender()] - value);
        return true;
    }
    // 内部转账
    function _transfer(address from, address to, uint256 amount) internal {
        realFrom = from;
        require(from != address(0), "from cannot be zero");
        require(to != address(0), "to cannot be zero");
        require(_balance[from] > amount, "sender balance is smaller amount");
        _balance[from] -= amount;
        _balance[to] += amount;
        emit Transfer(from, to, amount);
    }
}
