const hre = require("hardhat");

async function main() {
  // Fetch contract
  const Token = await ethers.getContractFactory('Token')

  // Deploy contract
  const token = await Token.deploy('Dog Slobber', 'DSLB', '1000000')
  await token.deployed()
  console.log(`Token deployed to: ${token.address}`)

}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
