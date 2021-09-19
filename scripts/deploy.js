async function main() {
  const [deployer] = await hre.ethers.getSigners();
  console.log("Deploying contract with the address", deployer.address);
  console.log("Account balance", (await deployer.getBalance()).toString());

  const Token = await hre.ethers.getContractFactory("WavePortal");
  const token = await Token.deploy({
    value: hre.ethers.utils.parseEther("0.01"),
  });
  await token.deployed();
  console.log("Wave Portal Address", token.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.log(error);
    process.exit(1);
  });
