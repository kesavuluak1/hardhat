
async function main() {
  const Stable = await ethers.getContractFactory("BankStablecoin");
  const stable = await Stable.deploy();
  await stable.waitForDeployment();
  console.log("BankStablecoin:", await stable.getAddress());

  const Interbank = await ethers.getContractFactory("InterbankSettlement");
  const ib = await Interbank.deploy();
  await ib.waitForDeployment();
  console.log("InterbankSettlement:", await ib.getAddress());
}
main();
