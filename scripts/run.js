async function main() {
  const [owner, randoPerson] = await hre.ethers.getSigners();
  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy({
    value: hre.ethers.utils.parseEther("0.1"),
  });
  await waveContract.deployed();
  console.log("Deployed to: ", waveContract.address);
  // console.log("Contract deployed by: ", owner.address);

  let date = new Date().getTime();
  let waveDate = date / 1000;

  let waveCount;
  waveCount = await waveContract.getTotalWaves();

  let waveTxn;
  waveTxn = await waveContract.wave("A message");
  waveTxn.wait();

  let contractBalance = await hre.ethers.provider.getBalance(
    waveContract.address
  );
  console.log(
    "Contract balance is",
    hre.ethers.utils.formatEther(contractBalance)
  );

  waveCount = await waveContract.getTotalWaves();

  contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
  console.log(
    "Contract balance is",
    hre.ethers.utils.formatEther(contractBalance)
  );

  waveCount = await waveContract.getTotalWaves();
  const allWaves = await waveContract.getWaves();

  const amount = hre.ethers.BigNumber.from(allWaves[0].amountEarned);
  const formatedAm = ethers.utils.formatEther(amount);
  console.log("🚀 ~ file: run.js ~ line 45 ~ main ~ formatedAm", formatedAm);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.log(error);
    process.exit(1);
  });
