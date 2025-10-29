# Simple Savings DApp

A decentralized savings application built with Solidity and Hardhat, allowing users to deposit and withdraw ETH with event tracking.

## Features

- **Deposit ETH**: Users can deposit ETH to their savings account
- **Withdraw ETH**: Users can withdraw their deposited funds
- **Balance Tracking**: Track individual user balances and total contract deposits
- **Event Logging**: All transactions are logged with events for transparency
- **Owner Controls**: Emergency withdrawal functionality for contract owner

## Smart Contract

### SimpleSavings Contract

The main contract provides the following functionality:

- `deposit()`: Deposit ETH to your savings account
- `withdraw(uint256 amount)`: Withdraw specified amount from your savings
- `getBalance()`: Get your current balance
- `getContractBalance()`: Get total contract balance
- `getTotalDeposits()`: Get total deposits across all users
- `emergencyWithdraw()`: Owner-only emergency withdrawal function

### Events

- `Deposited(address indexed user, uint256 amount, uint256 timestamp)`
- `Withdrawn(address indexed user, uint256 amount, uint256 timestamp)`

## Development

### Prerequisites

- Node.js
- npm or yarn

### Installation

```bash
npm install
```

### Testing

Run the test suite using viem assertions:

```bash
npx hardhat test
```

The tests include:
- Deposit functionality with event verification
- Withdraw functionality with event verification
- Balance tracking validation

### Compilation

```bash
npx hardhat compile
```

### Deployment

#### Local Development Network

Deploy to a local Hardhat network:

```bash
# Start local Hardhat network
npx hardhat node

# In another terminal, deploy the contract
npx hardhat ignition deploy ignition/modules/SimpleSavings.ts --network local
```

#### Testnet Deployment (Sepolia)

Deploy to Sepolia testnet:

1. **Set up environment variables**:
   Create a `.env` file in the project root:
   ```bash
   SEPOLIA_RPC_URL=https://sepolia.infura.io/v3/YOUR_INFURA_PROJECT_ID
   SEPOLIA_PRIVATE_KEY=your_private_key_here
   ```

2. **Get testnet ETH**:
   - Visit [Sepolia Faucet](https://sepoliafaucet.com/) to get test ETH
   - Or use [Alchemy Faucet](https://sepoliafaucet.com/)

3. **Deploy to Sepolia**:
   ```bash
   npx hardhat ignition deploy ignition/modules/SimpleSavings.ts --network sepolia
   ```

#### Other Networks

The project is configured to support multiple networks:

- **Hardhat Mainnet Simulation**: `--network hardhatMainnet`
- **Hardhat Optimism Simulation**: `--network hardhatOp`
- **Local Network**: `--network local`
- **Sepolia Testnet**: `--network sepolia`

#### Verification (Optional)

After deployment, verify your contract on Etherscan:

```bash
npx hardhat verify --network sepolia <CONTRACT_ADDRESS>
```

## Project Structure

```
├── contracts/
│   └── SimpleSavings.sol          # Main smart contract
├── test/
│   └── SimpleSavings.ts           # Test suite with viem assertions
├── scripts/
│   └── send-op-tx.ts              # Transaction scripts
├── ignition/
│   └── modules/
│       └── Counter.ts             # Deployment module
├── hardhat.config.ts              # Hardhat configuration
└── package.json                   # Dependencies and scripts
```

## Security Features

- **Access Control**: Owner-only emergency functions
- **Input Validation**: Amount validation for deposits and withdrawals
- **Safe Transfers**: Proper ETH transfer handling with success checks
- **Event Logging**: Complete transaction history for auditability

## License

MIT License