// SPDX-License-Identifier: MIT
// File: @openzeppelin/contracts/GSN/Context.sol

pragma solidity ^0.6.0;

/*
 * Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

// File: @openzeppelin/contracts/token/ERC20/IERC20.sol

pragma solidity ^0.6.0;

/**
 * Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * Sets `amount` as the allowance of `spender` over the caller's tokens.
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
     * Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

// File: @openzeppelin/contracts/math/SafeMath.sol

pragma solidity ^0.6.0;

/**
 * Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

// File: @openzeppelin/contracts/token/ERC20/ERC20.sol

pragma solidity ^0.6.0;

/**
 * Implementation of the {IERC20} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 * For a generic mechanism see {ERC20PresetMinterPauser}.
 *
 * TIP: For a detailed writeup see our guide
 * https://forum.zeppelin.solutions/t/how-to-implement-erc20-supply-mechanisms/226[How
 * to implement supply mechanisms].
 *
 * We have followed general OpenZeppelin guidelines: functions revert instead
 * of returning `false` on failure. This behavior is nonetheless conventional
 * and does not conflict with the expectations of ERC20 applications.
 *
 * Additionally, an {Approval} event is emitted on calls to {transferFrom}.
 * This allows applications to reconstruct the allowance for all accounts just
 * by listening to said events. Other implementations of the EIP may not emit
 * these events, as it isn't required by the specification.
 *
 * Finally, the non-standard {decreaseAllowance} and {increaseAllowance}
 * functions have been added to mitigate the well-known issues around setting
 * allowances. See {IERC20-approve}.
 */
contract RebaseableERC20 is Context, IERC20 {
    using SafeMath for uint256;
    
    uint256 internal _totalSupply;

    string private _name;
    string private _symbol;
    uint8 private _decimals;
    
    uint256 public constant internalDecimals = 1e24;

    /**
     * @notice Used for percentage maths
     */
    uint256 public constant BASE = 1e18;

    /**
     * @notice Scaling factor that adjusts everyone's balances
     */
    uint256 public reethScalingFactor;

    mapping (address => uint256) internal _reethBalances;

    mapping (address => mapping (address => uint256)) internal _allowedFragments;
    
    uint256 public initSupply;
    
    /**
     * Sets the values for {name} and {symbol}, initializes {decimals} with
     * a default value of 18.
     *
     * To select a different value for {decimals}, use {_setupDecimals}.
     *
     * All three of these values are immutable: they can only be set once during
     * construction.
     */
    constructor (string memory name, string memory symbol) public {
        _name = name;
        _symbol = symbol;
        _decimals = 18;
    }
    
    function _initialize(address recipient, uint256 initialSupply) internal {
        reethScalingFactor = BASE;
        initSupply = _fragmentToReeth(initialSupply);
        _totalSupply = initialSupply;
        _reethBalances[recipient] = initSupply;
        emit Transfer(address(0), recipient, initialSupply);
    }
    
    /**
     * @notice Event emitted when tokens are rebased
     */

    // Prevent sending to this address or 0 address
    modifier validRecipient(address to) {
        require(to != address(0) && to != address(this), "Not a valid recipient");
        _;
    }
    
    /**
    * @notice Computes the current max scaling factor
    */
    function maxScalingFactor()
        external
        view
        returns (uint256)
    {
        return _maxScalingFactor();
    }

    function _maxScalingFactor()
        internal
        view
        returns (uint256)
    {
        // scaling factor can only go up to 2**256-1 = initSupply * reethScalingFactor
        // this is used to check if reethScalingFactor will be too high to compute balances when rebasing.
        return uint256(-1) / initSupply;
    }

    /**
     * Returns the name of the token.
     */
    function name() public view returns (string memory) {
        return _name;
    }

    /**
     * Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view returns (string memory) {
        return _symbol;
    }

    /**
     * Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5,05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the value {ERC20} uses, unless {_setupDecimals} is
     * called.
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view returns (uint8) {
        return _decimals;
    }

    /**
     * See {IERC20-totalSupply}.
     */
    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    /**
     * See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view override returns (uint256) {
        return _reethToFragment(_reethBalances[account]);
    }
    /**

    /**
     * See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `recipient` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    /**
     * See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowedFragments[owner][spender];
    }

    /**
     * See {IERC20-approve}.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    /**
     * See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20};
     *
     * Requirements:
     * - `sender` and `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     * - the caller must have allowance for ``sender``'s tokens of at least
     * `amount`.
     */
    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowedFragments[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;
    }

    /**
     * Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowedFragments[_msgSender()][spender].add(addedValue));
        return true;
    }

    /**
     * Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowedFragments[_msgSender()][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));
        return true;
    }

    /**
     * Moves tokens `amount` from `sender` to `recipient`.
     *
     * This is internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `sender` cannot be the zero address.
     * - `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     */
    function _transfer(address sender, address recipient, uint256 amount) internal virtual validRecipient(recipient) {
        require(sender != address(0), "ERC20: transfer from the zero address");
        
        _transferHook();

        // underlying balance is stored in reeth subunit, so divide by current scaling factor

        // note, this means as scaling factor grows, dust will be untransferrable.
        // minimum transfer value == reethScalingFactor / 1e24;

        // get amount in underlying
        uint256 reethValue = _fragmentToReeth(amount);

        // sub from balance of sender
        _reethBalances[sender] = _reethBalances[sender].sub(reethValue, "ERC20: transfer amount exceeds balance");

        // add to balance of receiver
        _reethBalances[recipient] = _reethBalances[recipient].add(reethValue);
        emit Transfer(sender, recipient, amount);
    }

    /** Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements
     *
     * - `to` cannot be the zero address.
     */
    function _mint(address to, uint256 amount) internal virtual validRecipient(to) {
        // increase totalSupply
        _totalSupply = _totalSupply.add(amount);

        // get underlying value
        uint256 reethValue = _fragmentToReeth(amount);

        // increase initSupply
        initSupply = initSupply.add(reethValue);

        // make sure the mint didnt push maxScalingFactor too low
        require(reethScalingFactor <= _maxScalingFactor(), "max scaling factor too low");

        // add balance
        _reethBalances[to] = _reethBalances[to].add(reethValue);

        emit Transfer(address(0), to, amount);
    }
    
    /**
     * Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        // decrease totalSupply
        _totalSupply = _totalSupply.sub(amount);

        // get underlying value
        uint256 reethValue = _fragmentToReeth(amount);

        // decrease initSupply
        initSupply = initSupply.sub(reethValue);

        // probably unnecessary check
        require(reethScalingFactor <= _maxScalingFactor(), "max scaling factor too low");

        // sub balance
        _reethBalances[account] = _reethBalances[account].sub(reethValue, "ERC20: burn amount exceeds balance");

        emit Transfer(account, address(0), amount);
    }

    /**
     * Sets `amount` as the allowance of `spender` over the `owner`s tokens.
     *
     * This is internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(address owner, address spender, uint256 amount) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowedFragments[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     * Sets {decimals} to a value other than the default one of 18.
     *
     * WARNING: This function should only be called from the constructor. Most
     * applications that interact with token contracts will not expect
     * {decimals} to ever change, and may work incorrectly if it does.
     */
    function _setupDecimals(uint8 decimals_) internal {
        _decimals = decimals_;
    }
    
    // Scaling functions
    function reethToFragment(uint256 val)
        external
        view
        returns (uint256)
    {
        return _reethToFragment(val);
    }

    function fragmentToReeth(uint256 val)
        external
        view
        returns (uint256)
    {
        return _fragmentToReeth(val);
    }

    function _reethToFragment(uint256 val)
        internal
        view
        returns (uint256)
    {
        return val.mul(reethScalingFactor).div(internalDecimals);
    }

    function _fragmentToReeth(uint256 val)
        internal
        view
        returns (uint256)
    {
        return val.mul(internalDecimals).div(reethScalingFactor);
    }
    
    /**
     * Hook that is called before any transfer of tokens.
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _transferHook() internal virtual returns (bool) {}
}

// File: @openzeppelin/contracts/utils/Address.sol

pragma solidity ^0.6.2;

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts
        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned
        // for accounts without code, i.e. `keccak256('')`
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        // solhint-disable-next-line no-inline-assembly
        assembly { codehash := extcodehash(account) }
        return (codehash != accountHash && codehash != 0x0);
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success, ) = recipient.call{ value: amount }("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain`call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
      return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        return _functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        return _functionCallWithValue(target, data, value, errorMessage);
    }

    function _functionCallWithValue(address target, bytes memory data, uint256 weiValue, string memory errorMessage) private returns (bytes memory) {
        require(isContract(target), "Address: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.call{ value: weiValue }(data);
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

// File: @openzeppelin/contracts/token/ERC20/SafeERC20.sol

pragma solidity ^0.6.0;

/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure (when the token
 * contract returns false). Tokens that return no value (and instead revert or
 * throw on failure) are also supported, non-reverting calls are assumed to be
 * successful.
 * To use this library you can add a `using SafeERC20 for IERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20 {
    using SafeMath for uint256;
    using Address for address;

    function safeTransfer(IERC20 token, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(IERC20 token, address from, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    /**
     * @dev Deprecated. This function has issues similar to the ones found in
     * {IERC20-approve}, and its usage is discouraged.
     *
     * Whenever possible, use {safeIncreaseAllowance} and
     * {safeDecreaseAllowance} instead.
     */
    function safeApprove(IERC20 token, address spender, uint256 value) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        // solhint-disable-next-line max-line-length
        require((value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }

    function safeIncreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 newAllowance = token.allowance(address(this), spender).add(value);
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    function safeDecreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 newAllowance = token.allowance(address(this), spender).sub(value, "SafeERC20: decreased allowance below zero");
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address.functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
        if (returndata.length > 0) { // Return data is optional
            // solhint-disable-next-line max-line-length
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}

// File: @openzeppelin/contracts/access/Ownable.sol

pragma solidity ^0.6.0;

/**
 * Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
contract Ownable is Context {
    address private _owner;

    event GovernanceTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * Initializes the contract setting the deployer as the initial owner.
     */
    constructor () internal {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit GovernanceTransferred(address(0), msgSender);
    }

    /**
     * Returns the address of the current owner.
     */
    function governance() public view returns (address) {
        return _owner;
    }

    /**
     * Throws if called by any account other than the owner.
     */
    modifier onlyGovernance() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function _transferGovernance(address newOwner) internal virtual onlyGovernance {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit GovernanceTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

// File: contracts/ReethToken.sol

pragma solidity =0.6.6;

interface MonetaryPolicyInterface{
    // This function is called whenever reeth is transferred
    function reethTransferActions() external;
}

// Reeth token whose supply can be altered by its price compared to ETH

contract ReethToken is RebaseableERC20("Reeth Token", "REETH"), Ownable {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;
    
    address public monetaryPolicy;
    uint256 private _latestEpoch;
    bool public rebaseable;
    
    struct Epoch {
        uint256 price;
        int256 supplyChangeAmount;
        uint256 rebaseTime;
    }
    
    // These are addresses that are allowed to mint new tokens
    mapping (address => bool) internal _allowedMinters;
    mapping (uint256 => Epoch) internal _epochDetails;
    
    modifier onlyMonetaryPolicy() {
        require(_msgSender() == monetaryPolicy, "Not monetary policy");
        _;
    }
    
    modifier onlyMinters() {
        require(isMinter(_msgSender()) == true, "Not a minter");
        _;
    }

    event Rebase(uint256 epoch, uint256 currentPrice, int256 supplyChangeAmount, uint256 currentSupply);

    constructor(uint256 _initialSupply) public {
        _initialize(_msgSender(), _initialSupply);
    }
    
    function isMinter(address _addr) public view returns (bool) {
        return _allowedMinters[_addr];
    }
    
    function latestEpoch() external view returns (uint256) {
        return _latestEpoch;
    }
    
    function getEpochDetails(uint256 _pos) external view returns (uint256, int256, uint256) {
        if(_pos == 0) { return (0, 0, 0); } // No epoch available yet as no rebases have happened yet
        _pos = _pos.sub(1);
        require(_pos < _latestEpoch, "Epoch doesn't yet exist");
        return (_epochDetails[_pos].price, _epochDetails[_pos].supplyChangeAmount, _epochDetails[_pos].rebaseTime);
    }
    
    function isRebaseable() external view returns (bool) {
        return rebaseable;
    }
    
    // This function is called when tokens are being transferred
    function _transferHook() internal virtual override returns (bool) {
        super._transferHook(); // Call parent hook
        if(monetaryPolicy != address(0)){
            MonetaryPolicyInterface(monetaryPolicy).reethTransferActions();
        }
    }
    
    function mint(address recipient, uint256 amount) external onlyMinters returns (bool) {
        _mint(recipient, amount);
        return true;
    }
    
    // Users can burn their own tokens if they want to
    function burn(uint256 amount) external returns (bool) {
        _burn(_msgSender(), amount);
        return true;
    }
    
    /**
    * @notice Initiates a new rebase operation based on the current monetary policy
    */
    function rebase(
        uint256 price,
        uint256 indexDelta,
        bool positive
    )
        external
        onlyMonetaryPolicy
        returns (uint256)
    {
        require(rebaseable == true, "Not yet able to rebase token");
        _latestEpoch = _latestEpoch.add(1);
        uint256 _EpochPos = _latestEpoch.sub(1);
        
        // no change
        if (indexDelta == 0) {
          emit Rebase(_latestEpoch, price, 0, _totalSupply);
          _epochDetails[_EpochPos].price = price;
          _epochDetails[_EpochPos].supplyChangeAmount = 0;
          _epochDetails[_EpochPos].rebaseTime = now;
          return _totalSupply;
        }

        if (!positive) {
            // negative rebase, decrease scaling factor
            reethScalingFactor = reethScalingFactor.mul(BASE.sub(indexDelta)).div(BASE);
        } else {
            // positive reabse, increase scaling factor
            uint256 newScalingFactor = reethScalingFactor.mul(BASE.add(indexDelta)).div(BASE);
            if (newScalingFactor < _maxScalingFactor()) {
                reethScalingFactor = newScalingFactor;
            } else {
                reethScalingFactor = _maxScalingFactor();
            }
        }

        // update total supply, correctly
        uint256 oldSupply = _totalSupply;
        int256 supplyChange = 0;
        _totalSupply = _reethToFragment(initSupply);
        
        // Calculate the change in tokens
        if(oldSupply < _totalSupply){
            // Expanded supply
            oldSupply = _totalSupply.sub(oldSupply);
            supplyChange = int256(oldSupply);
        }else if(oldSupply > _totalSupply){
            // Supply shrank
            oldSupply = oldSupply.sub(_totalSupply);
            supplyChange = 0 - int256(oldSupply);
        }

        emit Rebase(_latestEpoch, price, supplyChange, _totalSupply);
        _epochDetails[_EpochPos].price = price;
        _epochDetails[_EpochPos].supplyChangeAmount = supplyChange;
        _epochDetails[_EpochPos].rebaseTime = now;
        return _totalSupply;
    }

    // Governance functions
    function governanceActivateRebasing() external onlyGovernance {
        require(rebaseable == false, "Already rebaseable");
        rebaseable = true;
    }
    
    // Now add some governance functions behind 24 hour timelock
    
    // Timelock variables

    uint256 private _timelockStart; // The start of the timelock to change governance variables
    uint256 private _timelockType; // The function that needs to be changed
    uint256 constant TIMELOCK_DURATION = 86400; // Timelock is 24 hours
    
    // Reusable timelock variables
    address private _timelock_address;
    
    modifier timelockConditionsMet(uint256 _type) {
        require(_timelockType == _type, "Timelock not acquired for this function");
        _timelockType = 0; // Reset the type once the timelock is used
        if(rebaseable == true){
            require(now >= _timelockStart + TIMELOCK_DURATION, "Timelock time not met");
        }
        _;
    }
    
    // Change the governance
    // --------------------
    function startChangeGovernance(address _address) external onlyGovernance {
        _timelockStart = now;
        _timelockType = 1;
        _timelock_address = _address;       
    }
    
    function finishChangeGovernance() external onlyGovernance timelockConditionsMet(1) {
        _transferGovernance(_timelock_address);
    }
    // --------------------
    
    // Add a new minter
    // --------------------
    function startAddMinter(address _address) external onlyGovernance {
        _timelockStart = now;
        _timelockType = 2;
        _timelock_address = _address;       
    }
    
    function finishAddMinter() external onlyGovernance timelockConditionsMet(2) {
        _allowedMinters[_timelock_address] = true;
    }
    // --------------------
    
    // Remove a minter
    // --------------------
    function startRemoveMinter(address _address) external onlyGovernance {
        _timelockStart = now;
        _timelockType = 3;
        _timelock_address = _address;       
    }
    
    function finishRemoveMinter() external onlyGovernance timelockConditionsMet(3) {
        _allowedMinters[_timelock_address] = false;
    }
    // --------------------
    
    // Change the monetary policy
    // --------------------
    function startChangeMonetaryPolicy(address _address) external onlyGovernance {
        _timelockStart = now;
        _timelockType = 4;
        _timelock_address = _address;       
    }
    
    function finishChangeMonetaryPolicy() external onlyGovernance timelockConditionsMet(4) {
        monetaryPolicy = _timelock_address;
    }
    // --------------------
}