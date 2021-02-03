// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IUniswapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);
    function migrator() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
    function setMigrator(address) external;
}

interface IUniswapV2Router01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}

interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}
interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}


abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return payable(msg.sender);
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

contract Owned is Context {
    address private _owner;
    address private _pendingOwner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier ownerOnly {
        require(_owner == _msgSender(), "Owner only");
        _;
    }
    modifier pendingOnly {
        require (_pendingOwner == msg.sender, "cannot claim");
        _;
    }

    function pendingOwner() public view returns (address) {
        return _pendingOwner;
    }

    function renounceOwnership() public virtual ownerOnly {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    function transferOwnership(address newOwner) public ownerOnly {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _pendingOwner = newOwner;
    }

    function cancelTransfer() public ownerOnly {
        require(_pendingOwner != address(0), "no pending owner");
        _pendingOwner = address(0);
    }

    function claimOwnership() public pendingOnly {
        _pendingOwner = address(0);
        emit OwnershipTransferred(_owner, _msgSender());
        _owner = _msgSender();
    }
}


interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract Pool {}

library EnumerableSet {
    // To implement this library for multiple types with as little code
    // repetition as possible, we write it in terms of a generic Set type with
    // bytes32 values.
    // The Set implementation uses private functions, and user-facing
    // implementations (such as AddressSet) are just wrappers around the
    // underlying Set.
    // This means that we can only create new EnumerableSets for types that fit
    // in bytes32.

    struct Set {
        // Storage of set values
        bytes32[] _values;

        // Position of the value in the `values` array, plus 1 because index 0
        // means a value is not in the set.
        mapping (bytes32 => uint256) _indexes;
    }

    /**
     * @dev Add a value to a set. O(1).
     *
     * Returns true if the value was added to the set, that is if it was not
     * already present.
     */
    function _add(Set storage set, bytes32 value) private returns (bool) {
        if (!_contains(set, value)) {
            set._values.push(value);
            // The value is stored at length-1, but we add 1 to all indexes
            // and use 0 as a sentinel value
            set._indexes[value] = set._values.length;
            return true;
        } else {
            return false;
        }
    }

    /**
     * @dev Removes a value from a set. O(1).
     *
     * Returns true if the value was removed from the set, that is if it was
     * present.
     */
    function _remove(Set storage set, bytes32 value) private returns (bool) {
        // We read and store the value's index to prevent multiple reads from the same storage slot
        uint256 valueIndex = set._indexes[value];

        if (valueIndex != 0) { // Equivalent to contains(set, value)
            // To delete an element from the _values array in O(1), we swap the element to delete with the last one in
            // the array, and then remove the last element (sometimes called as 'swap and pop').
            // This modifies the order of the array, as noted in {at}.

            uint256 toDeleteIndex = valueIndex - 1;
            uint256 lastIndex = set._values.length - 1;

            // When the value to delete is the last one, the swap operation is unnecessary. However, since this occurs
            // so rarely, we still do the swap anyway to avoid the gas cost of adding an 'if' statement.

            bytes32 lastvalue = set._values[lastIndex];

            // Move the last value to the index where the value to delete is
            set._values[toDeleteIndex] = lastvalue;
            // Update the index for the moved value
            set._indexes[lastvalue] = toDeleteIndex + 1; // All indexes are 1-based

            // Delete the slot where the moved value was stored
            set._values.pop();

            // Delete the index for the deleted slot
            delete set._indexes[value];

            return true;
        } else {
            return false;
        }
    }

    /**
     * @dev Returns true if the value is in the set. O(1).
     */
    function _contains(Set storage set, bytes32 value) private view returns (bool) {
        return set._indexes[value] != 0;
    }

    /**
     * @dev Returns the number of values on the set. O(1).
     */
    function _length(Set storage set) private view returns (uint256) {
        return set._values.length;
    }

   /**
    * @dev Returns the value stored at position `index` in the set. O(1).
    *
    * Note that there are no guarantees on the ordering of values inside the
    * array, and it may change when more values are added or removed.
    *
    * Requirements:
    *
    * - `index` must be strictly less than {length}.
    */
    function _at(Set storage set, uint256 index) private view returns (bytes32) {
        require(set._values.length > index, "EnumerableSet: index out of bounds");
        return set._values[index];
    }

    // Bytes32Set

    struct Bytes32Set {
        Set _inner;
    }

    /**
     * @dev Add a value to a set. O(1).
     *
     * Returns true if the value was added to the set, that is if it was not
     * already present.
     */
    function add(Bytes32Set storage set, bytes32 value) internal returns (bool) {
        return _add(set._inner, value);
    }

    /**
     * @dev Removes a value from a set. O(1).
     *
     * Returns true if the value was removed from the set, that is if it was
     * present.
     */
    function remove(Bytes32Set storage set, bytes32 value) internal returns (bool) {
        return _remove(set._inner, value);
    }

    /**
     * @dev Returns true if the value is in the set. O(1).
     */
    function contains(Bytes32Set storage set, bytes32 value) internal view returns (bool) {
        return _contains(set._inner, value);
    }

    /**
     * @dev Returns the number of values in the set. O(1).
     */
    function length(Bytes32Set storage set) internal view returns (uint256) {
        return _length(set._inner);
    }

   /**
    * @dev Returns the value stored at position `index` in the set. O(1).
    *
    * Note that there are no guarantees on the ordering of values inside the
    * array, and it may change when more values are added or removed.
    *
    * Requirements:
    *
    * - `index` must be strictly less than {length}.
    */
    function at(Bytes32Set storage set, uint256 index) internal view returns (bytes32) {
        return _at(set._inner, index);
    }

    // AddressSet

    struct AddressSet {
        Set _inner;
    }

    /**
     * @dev Add a value to a set. O(1).
     *
     * Returns true if the value was added to the set, that is if it was not
     * already present.
     */
    function add(AddressSet storage set, address value) internal returns (bool) {
        return _add(set._inner, bytes32(uint256(uint160(value))));
    }

    /**
     * @dev Removes a value from a set. O(1).
     *
     * Returns true if the value was removed from the set, that is if it was
     * present.
     */
    function remove(AddressSet storage set, address value) internal returns (bool) {
        return _remove(set._inner, bytes32(uint256(uint160(value))));
    }

    /**
     * @dev Returns true if the value is in the set. O(1).
     */
    function contains(AddressSet storage set, address value) internal view returns (bool) {
        return _contains(set._inner, bytes32(uint256(uint160(value))));
    }

    /**
     * @dev Returns the number of values in the set. O(1).
     */
    function length(AddressSet storage set) internal view returns (uint256) {
        return _length(set._inner);
    }

   /**
    * @dev Returns the value stored at position `index` in the set. O(1).
    *
    * Note that there are no guarantees on the ordering of values inside the
    * array, and it may change when more values are added or removed.
    *
    * Requirements:
    *
    * - `index` must be strictly less than {length}.
    */
    function at(AddressSet storage set, uint256 index) internal view returns (address) {
        return address(uint160(uint256(_at(set._inner, index))));
    }


    // UintSet

    struct UintSet {
        Set _inner;
    }

    /**
     * @dev Add a value to a set. O(1).
     *
     * Returns true if the value was added to the set, that is if it was not
     * already present.
     */
    function add(UintSet storage set, uint256 value) internal returns (bool) {
        return _add(set._inner, bytes32(value));
    }

    /**
     * @dev Removes a value from a set. O(1).
     *
     * Returns true if the value was removed from the set, that is if it was
     * present.
     */
    function remove(UintSet storage set, uint256 value) internal returns (bool) {
        return _remove(set._inner, bytes32(value));
    }

    /**
     * @dev Returns true if the value is in the set. O(1).
     */
    function contains(UintSet storage set, uint256 value) internal view returns (bool) {
        return _contains(set._inner, bytes32(value));
    }

    /**
     * @dev Returns the number of values on the set. O(1).
     */
    function length(UintSet storage set) internal view returns (uint256) {
        return _length(set._inner);
    }

   /**
    * @dev Returns the value stored at position `index` in the set. O(1).
    *
    * Note that there are no guarantees on the ordering of values inside the
    * array, and it may change when more values are added or removed.
    *
    * Requirements:
    *
    * - `index` must be strictly less than {length}.
    */
    function at(UintSet storage set, uint256 index) internal view returns (uint256) {
        return uint256(_at(set._inner, index));
    }
}

contract Storage {

    struct Addresses {
        address pool;
        address router;
        address pair;
        address protocol;
        address dogecity;
        address prizePool;
        address buyBonusPool;
        address presale;
    }

    struct Balance {
        uint256 tokenSupply;
        uint256 networkSupply;
        uint256 targetSupply;
        uint256 pairSupply;
        uint256 lpSupply;
        uint256 fees;
        uint256 burned;
    }

    struct Account {
        bool feeless;
        bool transferPair;
        bool excluded;
        uint256 lastDogeIt;
        uint256 tTotal;
        uint256 rTotal;
        mapping(address => uint256) allowances;
    }

    struct Divisors {
        uint8 buy;
        uint8 sell;
        // multiplied by 10000
        uint8 dogecity;
        uint8 bonus;
        uint8 tokenLPBurn;
        uint8 inflate;
        uint8 buyCounter;
        uint8 tx;
        uint8 dogeitlimit;
        uint256 dogeify;
    }

    struct S {
        bool initialized;
        bool paused;
        uint8 decimals;
        Addresses addresses;
        Balance balances;
        Divisors divisors;
        uint256 random;
        uint256 buyFee;
        uint256 sellFee;
        uint256 minBuyForBonus;
        uint256 buys;
        uint256 sells;
        uint256 lastAttack;
        uint256 attackCooldown;
        mapping(address => Account) accounts;
        address[] entries;
        string symbol;
        string name;
        EnumerableSet.AddressSet excludedAccounts;

    }

}

contract State {
    Storage.S state;
    TState lastTState;

    enum TxType { FromExcluded, ToExcluded, BothExcluded, Standard }
    enum TState { Buy, Sell, Normal }
}

contract Getters is State {

    function canIDogeIt() public view returns(bool) {
        return state.accounts[msg.sender].lastDogeIt + state.divisors.dogeify < block.timestamp;
    }

    function isMinBuyForBonus(uint256 amount) public view returns(bool) {
        return amount > state.minBuyForBonus * (10 ** state.decimals);
    }

    function isFeelessTx(address sender, address recipient) public view returns(bool) {
        if(sender == state.addresses.presale) {
            return true;
        }
        return state.accounts[sender].feeless || state.accounts[recipient].feeless;
    }

    function getBurned() external view returns(uint256) {
        return state.balances.burned;
    }

    function getFees() external view returns(uint256) {
        return state.balances.fees;
    }

    function getExcluded(address account) public view returns(bool) {
        return state.accounts[account].excluded;
    }

    function getCurrentLPBal() public view returns(uint256) {
        return IERC20(state.addresses.pool).totalSupply();
    }

    function getLPBalanceOf(address account) external view returns(uint256) {
        return IERC20(state.addresses.pool).balanceOf(account);
    }

    function getFeeless(address account) external view returns (bool) {
        return state.accounts[account].feeless;
    }

    function getTState(address sender, address recipient, uint256 lpAmount) public view returns(TState t) {
        if(sender == state.addresses.router) {
            t = TState.Normal;
        } else if(state.accounts[sender].transferPair) {
            if(state.balances.lpSupply != lpAmount) { // withdraw vs buy
                t = TState.Normal;
            }
            t = TState.Buy;
        } else if(state.accounts[recipient].transferPair) {
            t = TState.Sell;
        } else {
            t = TState.Normal;
        }
        return t;
    }

    function getRouter() external view returns(address) {
        return state.addresses.router;
    }

    function getPair() external view returns(address) {
        return state.addresses.pair;
    }

    function getPool() external view returns(address) {
        return state.addresses.pool;
    }

    function getCirculatingSupply() public view returns(uint256, uint256) {
        uint256 rSupply = state.balances.networkSupply;
        uint256 tSupply = state.balances.tokenSupply;
        for (uint256 i = 0; i < EnumerableSet.length(state.excludedAccounts); i++) {
            address account = EnumerableSet.at(state.excludedAccounts, i);
            uint256 rBalance = state.accounts[account].rTotal;
            uint256 tBalance = state.accounts[account].tTotal;
            if (rBalance > rSupply || tBalance > tSupply) return (state.balances.networkSupply, state.balances.tokenSupply);
            rSupply -= rBalance;
            tSupply -= tBalance;
        }
        if (rSupply < state.balances.networkSupply / state.balances.tokenSupply) return (state.balances.networkSupply, state.balances.tokenSupply);
        return (rSupply, tSupply);
    }

    function getTxType(address sender, address recipient) public view returns(TxType t) {
        bool isSenderExcluded = state.accounts[sender].excluded;
        bool isRecipientExcluded = state.accounts[recipient].excluded;
        if (isSenderExcluded && !isRecipientExcluded) {
            t = TxType.FromExcluded;
        } else if (!isSenderExcluded && isRecipientExcluded) {
            t = TxType.ToExcluded;
        } else if (!isSenderExcluded && !isRecipientExcluded) {
            t = TxType.Standard;
        } else if (isSenderExcluded && isRecipientExcluded) {
            t = TxType.BothExcluded;
        } else {
            t = TxType.Standard;
        }
    }

    function getBuyBonus(uint256 amount) public view returns(uint256) {
        uint256 bonus;
        uint256 total = IERC20(address(this)).balanceOf(state.addresses.buyBonusPool);
        if(lastTState == TState.Sell) {
            if(amount >= total / 2) {
                bonus = total / state.divisors.bonus;
            } else if(amount >= total / 5) {
                bonus = total / (state.divisors.bonus * 2);
            } else if(amount >= total / 10) {
                bonus = total / (state.divisors.bonus * 3);
            } else if(amount >= total / 25) {
                bonus = total / (state.divisors.bonus * 4);
            } else {
                bonus = total / (state.divisors.bonus * 5);
            }
        } else if(isMinBuyForBonus(amount)) {
            bonus = (total / state.divisors.bonus) / 10;
        }
        return bonus > total ? 0 : bonus;
    }

    function getFee(uint256 amount, uint256 divisor) public pure returns (uint256) {
        return amount / divisor;
    }

    function getPrizePoolAddress() public view returns(address) {
        return state.addresses.prizePool;
    }

    function getPrizePoolAmount() public view returns(uint256) {
        return state.accounts[getPrizePoolAddress()].rTotal / ratio();
    }

    function getBuyPoolAmount() public view returns(uint256) {
        return state.accounts[getBuyBonusPoolAddress()].rTotal / ratio();
    }

    function getBuyBonusPoolAddress() public view returns(address) {
        return state.addresses.buyBonusPool;
    }

    function getAmountForMinBuyTax() public view returns(uint256) {
        return (state.balances.tokenSupply / 100);
    }

    function getBuyTax(uint256 amount) public view returns(uint256) {
        uint256 _ratio = amount * 100000 / state.balances.tokenSupply;
        if(_ratio < 1) { // .001%
            return state.divisors.buy; // charges whatever max buy fee is at, to discourage gaming the prizepool.
        } else if (_ratio >= 1000) { // 1%
            return state.divisors.buy * 5; // charges 1/5th of buy fee, from default is 1%
        } else if (_ratio >= 10 && _ratio < 100){
            return state.divisors.buy * 2; // and so on.
        } else if (_ratio >= 100 && _ratio < 500) {
            return state.divisors.buy * 3;
        } else if (_ratio >= 500 && _ratio < 1000) {
            return state.divisors.buy * 4;
        } else { // shouldn't hit this
            return state.divisors.buy;
        }
    }

    function getTimeTillNextAttack() public view returns(uint256) {
        uint256 time = (state.lastAttack + state.attackCooldown);
        return block.timestamp > time ? block.timestamp - (state.lastAttack + state.attackCooldown) : 0;
    }

    function getLastTState() public view returns(TState) {
        return lastTState;
    }

    function ratio() public view returns(uint256) {
        return state.balances.networkSupply / state.balances.tokenSupply;
    }

}

contract Dogira is IERC20, Getters, Owned {

    struct TxValue {
        uint256 amount;
        uint256 transferAmount;
        uint256 fee;
        uint256 buyFee;
        uint256 sellFee;
        uint256 buyBonus;
        uint256 operationalFee;
    }
    event BonusAwarded(address account, uint256 amount);
    event Kek(address account, uint256 amount);
    event Doge(address account, uint256 amount);
    event Winner(address account, uint256 amount);
    event Smashed(uint256 amount);
    event Atomacized(uint256 amount);
    event Blazed(uint256 amount);

    uint256 constant private TOKEN_SUPPLY = 100_000_000;

    function name() public view returns(string memory) {
        return state.name;
    }

    function decimals() public view returns(uint8) {
        return state.decimals;
    }

    function symbol() public view returns (string memory) {
        return state.symbol;
    }

    function initialize() public {
        require(!state.initialized, "Contract instance has already been initialized");
        state.initialized = true;
        state.decimals = 18;
        state.symbol = "DOGIRA";
        state.name = "Dogira Token";
        state.balances.tokenSupply = TOKEN_SUPPLY * (10 ** state.decimals);
        state.balances.networkSupply = (~uint256(0) - (~uint256(0) % TOKEN_SUPPLY));
        state.divisors.buy = 20; // 5% max - 1% depending on buy size.
        state.divisors.sell = 20; // 5%
        state.divisors.bonus = 20;
        state.divisors.dogecity = 100;
        state.divisors.inflate = 50;
        state.divisors.tokenLPBurn = 50;
        state.divisors.tx = 100;
        state.divisors.dogeitlimit = 20;
        state.divisors.dogeify = 1 hours;
        state.divisors.buyCounter = 10;
        state.minBuyForBonus = TOKEN_SUPPLY / 500;
        state.addresses.prizePool = address(new Pool());
        state.addresses.buyBonusPool = address(new Pool());
        state.addresses.router = address(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
        state.addresses.pair = IUniswapV2Router02(state.addresses.router).WETH();
        state.addresses.pool =
            IUniswapV2Factory(IUniswapV2Router02(state.addresses.router).factory()).createPair(address(this), state.addresses.pair);
        state.accounts[address(0)].feeless = true;
        state.accounts[msg.sender].feeless = true;
        state.accounts[state.addresses.pool].transferPair = true;
        state.accounts[msg.sender].rTotal = state.balances.networkSupply;
        state.addresses.dogecity = address(0x6E3543b9E5d530c469a8F7aF87f841a7F121Dfba);
        state.paused = true;
        state.attackCooldown = 10 minutes;
    }

    function allowance(address owner, address spender) public view override returns (uint256) {
        return state.accounts[owner].allowances[spender];
    }

    function balanceOf(address account) public view override returns (uint256) {
        return getExcluded(account) ? state.accounts[account].tTotal : state.accounts[account].rTotal / ratio();
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function _approve(address owner, address spender, uint256 amount) private {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        state.accounts[owner].allowances[spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, state.accounts[_msgSender()].allowances[spender] + addedValue);
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, state.accounts[_msgSender()].allowances[spender] - (subtractedValue));
        return true;
    }

    function totalSupply() public view override returns (uint256) {
        return state.balances.tokenSupply;
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), state.accounts[sender].allowances[_msgSender()] - amount);
        return true;
    }

    function _transfer(address sender, address recipient, uint256 amount) internal returns(bool) {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        require(amount > 0, "Transfer amount must be greater than zero");
        if(sender == state.addresses.pool) { // for presales
            require(state.paused == false, "Transfers are paused");
        }
        bool noFee = isFeelessTx(sender, recipient);
        uint256 rate = ratio();
        uint256 lpAmount = getCurrentLPBal();
        (TxValue memory t, TState ts, TxType txType) = tValues(sender, recipient, amount, noFee, lpAmount);
        state.balances.lpSupply = lpAmount;
        handleTRV(recipient, rate, ts, t);
        rTransfer(sender, recipient, rate, t, txType);
        state.balances.fees += t.fee;
        state.balances.networkSupply -= (t.fee * rate);
        lastTState = ts;
        emit Transfer(msg.sender, recipient, t.transferAmount);
        return true;
    }

    function rTransfer(address sender, address recipient, uint256 rate, TxValue memory t, TxType txType) internal {
        if (txType == TxType.ToExcluded) {
            state.accounts[sender].rTotal         -= t.amount * rate;
            state.accounts[recipient].tTotal      += (t.transferAmount);
            state.accounts[recipient].rTotal      += t.transferAmount * rate;
        } else if (txType == TxType.FromExcluded) {
            state.accounts[sender].tTotal         -= t.amount;
            state.accounts[sender].rTotal         -= t.amount * rate;
            state.accounts[recipient].rTotal      += t.transferAmount * rate;
        } else if (txType == TxType.BothExcluded) {
            state.accounts[sender].tTotal         -= t.amount;
            state.accounts[sender].rTotal         -= (t.amount * rate);
            state.accounts[recipient].tTotal      += t.transferAmount;
            state.accounts[recipient].rTotal      += (t.transferAmount * rate);
        } else {
            state.accounts[sender].rTotal         -= (t.amount * rate);
            state.accounts[recipient].rTotal      += (t.transferAmount * rate);
        }
    }

    // burn supply, not negative rebase
    function verysmashed() external  {
        require(state.lastAttack + state.attackCooldown < block.timestamp, "Dogira coolingdown");
        uint256 rLp = state.accounts[state.addresses.pool].rTotal;
        uint256 amountToDeflate = (rLp / (state.divisors.tokenLPBurn));
        uint256 burned = amountToDeflate / ratio();
        state.accounts[state.addresses.pool].rTotal -= amountToDeflate;
        state.accounts[address(0)].rTotal += amountToDeflate;
        state.accounts[address(0)].tTotal += burned;
        state.balances.burned += burned;
        state.lastAttack = block.timestamp;
        syncPool();
        emit Smashed(burned);
    }

    // positive rebase
    function dogebreath() external {
        require(state.lastAttack + state.attackCooldown < block.timestamp, "Dogira coolingdown");
        uint256 rate = ratio();
        uint256 target = state.balances.burned == 0 ? state.balances.tokenSupply : state.balances.burned;
        uint256 amountToInflate = target / state.divisors.inflate;
        if(state.balances.burned > amountToInflate) {
            state.balances.burned -= amountToInflate;
            state.accounts[address(0)].rTotal -= amountToInflate * rate;
            state.accounts[address(0)].tTotal -= amountToInflate;
        }
        // positive rebase
        state.balances.networkSupply -= amountToInflate * rate;
        state.lastAttack = block.timestamp;
        syncPool();
        emit Atomacized(amountToInflate);
    }

    function wow(uint256 amount) external {
        address sender = msg.sender;
        uint256 rate = ratio();
        require(!getExcluded(sender), "Excluded addresses can't call this function");
        require(amount * rate < state.accounts[sender].rTotal, "too much");
        state.accounts[sender].rTotal -= (amount * rate);
        state.balances.networkSupply -= amount * rate;
        state.balances.fees += amount;
        syncPool();
    }

    function suchburn(uint256 amount) external {
        address sender = msg.sender;
        uint256 rate = ratio();
        require(!getExcluded(sender), "Excluded addresses can't call this function");
        require(amount * rate < state.accounts[sender].rTotal, "too much");
        state.accounts[sender].rTotal -= (amount * rate);
        state.accounts[address(0)].rTotal += (amount * rate);
        state.accounts[address(0)].tTotal += (amount);
        state.balances.burned += amount;
        syncPool();
        emit Blazed(amount);

    }

    function dogeit(uint256 amount) external {
        require(!getExcluded(msg.sender), "excluded can't call");
        uint256 rAmount = amount * ratio();
        require(state.accounts[msg.sender].lastDogeIt + state.divisors.dogeify < block.timestamp, "you need to wait to doge");
        require(rAmount <= state.accounts[state.addresses.buyBonusPool].rTotal / state.divisors.dogeitlimit, "can't kek too much");
        state.accounts[msg.sender].lastDogeIt = block.timestamp;
        if((state.random + block.timestamp + block.number) % 2 == 0) {
            state.accounts[state.addresses.buyBonusPool].rTotal -= rAmount;
            state.accounts[msg.sender].rTotal += rAmount;
            emit Doge(msg.sender, amount);
        } else {
            state.accounts[msg.sender].rTotal -= rAmount;
            state.accounts[state.addresses.buyBonusPool].rTotal += rAmount;
            emit Kek(msg.sender, amount);
        }
    }

    function handleTRV(address recipient, uint256 rate, TState ts, TxValue memory t) internal {
        state.accounts[state.addresses.dogecity].rTotal += (t.operationalFee * rate);
        if(ts == TState.Sell) {
            state.accounts[state.addresses.buyBonusPool].rTotal += t.sellFee * rate;
            state.accounts[state.addresses.buyBonusPool].tTotal += t.sellFee;
        }
        if(ts == TState.Buy) {
            state.buys++;
            if(state.buys % state.divisors.buyCounter == 0) {
                uint256 a = state.accounts[state.addresses.prizePool].rTotal + (t.buyFee * rate);
                state.accounts[state.addresses.prizePool].rTotal = 0;
                state.accounts[state.addresses.prizePool].tTotal = 0;
                state.accounts[recipient].rTotal += a;
                emit Winner(recipient, a);
            } else {
                state.accounts[state.addresses.prizePool].rTotal += t.buyFee * rate;
                state.accounts[state.addresses.prizePool].tTotal += t.buyFee;
            }
            state.accounts[state.addresses.buyBonusPool].rTotal -= t.buyBonus * rate;
            state.accounts[state.addresses.buyBonusPool].tTotal -= t.buyBonus;
            state.accounts[recipient].rTotal += t.buyBonus * rate;
            emit BonusAwarded(recipient, t.buyBonus);
        }
    }

    function tValues(address sender, address recipient, uint256 amount, bool noFee, uint256 lpAmount) public view returns (TxValue memory t, TState ts, TxType txType) {
        ts = getTState(sender, recipient, lpAmount);
        txType = getTxType(sender, recipient);
        t.amount = amount;
        if(!noFee) {
            t.fee = getFee(amount, state.divisors.tx);
            t.operationalFee = getFee(amount, state.divisors.dogecity);
            if(ts == TState.Sell) {
                t.sellFee = getFee(amount, state.divisors.sell);
            }
            if(ts == TState.Buy) {
                t.buyFee = getFee(amount, getBuyTax(amount));
                t.buyBonus = getBuyBonus(amount);
            }
        }
        t.transferAmount = t.amount - t.fee - t.sellFee - t.buyFee - t.operationalFee;
        return (t, ts, txType);
    }

    function include(address account) external ownerOnly {
        require(state.accounts[account].excluded, "Account is already excluded");
        state.accounts[account].tTotal = 0;
        EnumerableSet.remove(state.excludedAccounts, account);
    }

    function exclude(address account) external ownerOnly {
        require(!state.accounts[account].excluded, "Account is already excluded");
        state.accounts[account].excluded = true;
        if(state.accounts[account].rTotal > 0) {
            state.accounts[account].tTotal = state.accounts[account].rTotal / ratio();
        }
        state.accounts[account].excluded = true;
        EnumerableSet.add(state.excludedAccounts, account);
    }

    function syncPool() public  {
        IUniswapV2Pair(state.addresses.pool).sync();
    }

    function enableTrading() external ownerOnly {
        state.paused = false;
    }

    function setPresale(address account) external ownerOnly {
        state.addresses.presale = account;
        state.accounts[account].feeless = true;
    }

    function setFeeless(address account, bool value) external ownerOnly {
        state.accounts[account].feeless = value;
    }

    function setBuyFee(uint8 fd) external ownerOnly {
        require(fd >= 20, "can't be more than 5%");
        state.divisors.buy = fd;
    }

    function setSellFee(uint8 fd) external ownerOnly {
        require(fd >= 10, "can't be more than 10%");
        state.divisors.sell = fd;
    }

    function setRandomSeed(uint256 random) external ownerOnly {
        state.random = random;
    }

    function setTreasury(address account) external {
        require(msg.sender == state.addresses.dogecity || msg.sender == owner(), "invalid setter");
        state.addresses.dogecity = account; // can point to monster farm
    }

    function setCooldown(uint256 timeInSeconds) external ownerOnly {
        require(timeInSeconds > 1 minutes, "too short a time");
        state.attackCooldown = timeInSeconds;
    }

    function setBuyCounter(uint8 counter) external ownerOnly {
        require(counter > 5, "too few people");
        state.divisors.buyCounter = counter;
    }

    function setDogeItCooldown(uint256 time) external ownerOnly {
        require(time > 5 minutes, "too quick");
        state.divisors.dogeify = time;
    }

    function setTokenLPBurn(uint8 fd) external ownerOnly {
        require(fd > 20, "can't be more than 5%");
        state.divisors.tokenLPBurn = fd;
    }

    function setInflation(uint8 fd) external ownerOnly {
        require(fd > 20, "can't be more than 5%");
        state.divisors.inflate = fd;
    }

    function setDogeItLimit(uint8 fd) external ownerOnly {
        require(fd >= 10, "can't be more than 10% of the supply");
        state.divisors.dogeitlimit = fd;
    }

}